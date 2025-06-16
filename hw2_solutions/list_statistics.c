//
// Computes the mean and standard deviation of a list using multiple threads
//
// Warning: Return values of calls are not checked for error to keep 
// the code simple.
//
// Compilation command on ADA ($ sign is the shell prompt):
//  $ module load intel/2017A
//  $ icc -o list_statistics.exe list_statistics.c -lpthread -lc -lrt -lm
//
// Sample execution and output ($ sign is the shell prompt):
//  $ ./list_statistics.exe 1000000 9
// Threads = 9, mean = 500.1234, standard deviation = 288.6751, time (sec) =   0.0015
//
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#define MAX_THREADS     65536
#define MAX_LIST_SIZE   268435456

int num_threads;		// Number of threads to create - user input 

int thread_id[MAX_THREADS];	// User defined id for thread
pthread_t p_threads[MAX_THREADS];// Threads
pthread_attr_t attr;		// Thread attributes 

pthread_mutex_t lock_stats;	// Protects sum, sum_of_squares
double sum;			// Sum of all elements
double sum_of_squares;		// Sum of squares of all elements
double mean;			// Mean of the list
double standard_deviation;	// Standard deviation of the list

int list[MAX_LIST_SIZE];	// List of values
int list_size;			// List size

// Thread routine to compute sum and sum of squares of sublist assigned to thread
void *compute_statistics (void *s) {
    int j;
    int my_thread_id = *((int *)s);

    int block_size = list_size/num_threads;
    int my_start = my_thread_id*block_size;
    int my_end = (my_thread_id+1)*block_size-1;
    if (my_thread_id == num_threads-1) my_end = list_size-1;

    // Thread computes sum and sum of squares of list[my_start ... my_end]
    double my_sum = 0.0; 
    double my_sum_of_squares = 0.0;
    
    for (j = my_start; j <= my_end; j++) {
        my_sum += list[j];
        my_sum_of_squares += (double)list[j] * (double)list[j];
    }

    // Thread updates global sums
    pthread_mutex_lock(&lock_stats);
    sum += my_sum;
    sum_of_squares += my_sum_of_squares;
    pthread_mutex_unlock(&lock_stats);

    // Thread exits
    pthread_exit(NULL);
}

// Main program - set up list of random integers and use threads to compute
// the mean and standard deviation
int main(int argc, char *argv[]) {

    struct timespec start, stop;
    double total_time, time_res;
    int i, j; 
    double true_sum = 0.0, true_sum_of_squares = 0.0;
    double true_mean, true_std_dev;

    if (argc != 3) {
	printf("Need two integers as input \n"); 
	printf("Use: <executable_name> <list_size> <num_threads>\n"); 
	exit(0);
    }
    if ((list_size = atoi(argv[argc-2])) > MAX_LIST_SIZE) {
	printf("Maximum list size allowed: %d.\n", MAX_LIST_SIZE);
	exit(0);
    }; 
    if ((num_threads = atoi(argv[argc-1])) > MAX_THREADS) {
	printf("Maximum number of threads allowed: %d.\n", MAX_THREADS);
	exit(0);
    }; 
    if (num_threads > list_size) {
	printf("Number of threads (%d) < list_size (%d) not allowed.\n", num_threads, list_size);
	exit(0);
    }; 

    // Initialize mutex and attribute structures
    pthread_mutex_init(&lock_stats, NULL); 
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

    // Initialize list, compute true mean and std dev to verify result
    srand48(0); 	// seed the random number generator
    for (j = 0; j < list_size; j++) {
	list[j] = lrand48() % 1000;  // Limit to smaller values for easier verification
	true_sum += list[j];
	true_sum_of_squares += (double)list[j] * (double)list[j];
    }
    true_mean = true_sum / list_size;
    double variance = (true_sum_of_squares / list_size) - (true_mean * true_mean);
    true_std_dev = sqrt(variance);

    // Initialize global sums
    sum = 0.0;
    sum_of_squares = 0.0;

    // Create threads; each thread executes compute_statistics
    clock_gettime(CLOCK_REALTIME, &start);
    for (i = 0; i < num_threads; i++) {
	thread_id[i] = i; 
	pthread_create(&p_threads[i], &attr, compute_statistics, (void *) &thread_id[i]); 
    }
    // Join threads
    for (i = 0; i < num_threads; i++) {
	pthread_join(p_threads[i], NULL);
    }

    // Compute mean and standard deviation
    mean = sum / list_size;
    variance = (sum_of_squares / list_size) - (mean * mean);
    standard_deviation = sqrt(variance);

    // Compute time taken
    clock_gettime(CLOCK_REALTIME, &stop);
    total_time = (stop.tv_sec-start.tv_sec)
	+0.000000001*(stop.tv_nsec-start.tv_nsec);

    // Check answer (with small tolerance for floating point errors)
    if (fabs(true_mean - mean) > 0.0001 || fabs(true_std_dev - standard_deviation) > 0.0001) {
	printf("Houston, we have a problem!\n"); 
	printf("Expected: mean = %8.4f, std dev = %8.4f\n", true_mean, true_std_dev);
	printf("Got:      mean = %8.4f, std dev = %8.4f\n", mean, standard_deviation);
    }

    // Print results
    printf("Threads = %d, mean = %8.4f, standard_deviation = %8.4f, time (sec) = %8.4f\n", 
	    num_threads, mean, standard_deviation, total_time);

    // Destroy mutex and attribute structures
    pthread_attr_destroy(&attr);
    pthread_mutex_destroy(&lock_stats);
}
