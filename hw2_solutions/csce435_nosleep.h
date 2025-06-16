#include <time.h>

// For Problem 6: Set tv_sec = 0 and tv_nsec = 0 to see pure synchronization overhead
int work (int thread_id, int num_threads) {
    struct timespec sleeptime;
    sleeptime.tv_sec = 2.0; sleeptime.tv_nsec = 0;  // Change to 0, 0 for Problem 6
    nanosleep(&sleeptime, NULL);
    return 0;
}

// Alternative version for Problem 6 experiments:
// int work (int thread_id, int num_threads) {
//     struct timespec sleeptime;
//     sleeptime.tv_sec = 0; sleeptime.tv_nsec = 0;  // No sleep - pure synchronization overhead
//     nanosleep(&sleeptime, NULL);
//     return 0;
// }
