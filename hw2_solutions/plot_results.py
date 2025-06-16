import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

def plot_minimum_results():
    """Plot results for Problem 2"""
    # Read the results (you'll need to paste your data here)
    # Example format:
    threads = [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192]
    times = []  # Fill with your execution times
    
    # Calculate speedup
    t1 = times[0] if times else 1  # Time with 1 thread
    speedups = [t1/t for t in times] if times else []
    
    # Create figure with two subplots
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 5))
    
    # Plot 1: Execution time vs threads (log scale)
    ax1.semilogx(threads, times, 'bo-', base=2)
    ax1.set_xlabel('Number of Threads (p)')
    ax1.set_ylabel('Execution Time (seconds)')
    ax1.set_title('Execution Time vs Number of Threads')
    ax1.grid(True, which="both", ls="-", alpha=0.2)
    
    # Plot 2: Speedup vs threads
    ax2.plot(threads, speedups, 'ro-')
    ax2.plot(threads, threads, 'k--', label='Ideal speedup')  # Ideal speedup line
    ax2.set_xlabel('Number of Threads (p)')
    ax2.set_ylabel('Speedup')
    ax2.set_title('Speedup vs Number of Threads')
    ax2.legend()
    ax2.grid(True)
    
    plt.tight_layout()
    plt.savefig('minimum_performance.png')
    plt.show()

def plot_barrier_results():
    """Plot results for Problem 5"""
    # Read the results (you'll need to paste your data here)
    threads = [2**k for k in range(1, 15)]
    times = []  # Fill with your execution times
    
    plt.figure(figsize=(8, 6))
    plt.semilogx(threads, times, 'go-', base=2)
    plt.xlabel('Number of Threads (p)')
    plt.ylabel('Execution Time (seconds)')
    plt.title('Barrier Performance vs Number of Threads')
    plt.grid(True, which="both", ls="-", alpha=0.2)
    plt.savefig('barrier_performance.png')
    plt.show()

# Example of how to read results from file
def read_results_from_file(filename):
    """Read results from CSV format file"""
    df = pd.read_csv(filename)
    return df['Thread Count'].tolist(), df['Execution Time'].tolist()

if __name__ == "__main__":
    # Uncomment and modify based on your results
    # threads, times = read_results_from_file('minimum_results.txt')
    # plot_minimum_results()
    # plot_barrier_results()
    pass
