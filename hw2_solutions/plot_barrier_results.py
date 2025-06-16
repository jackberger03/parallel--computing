import matplotlib.pyplot as plt
import numpy as np

# Data from barrier execution results
threads = [2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384]
times = [2.0008, 2.0008, 2.0008, 2.0010, 2.0015, 2.0024, 2.0045, 2.0088, 2.0167, 2.0329, 2.0653, 2.1403, 2.2804, 2.5586]

# Create the plot
plt.figure(figsize=(10, 6))
plt.semilogx(threads, times, 'b-o', linewidth=2, markersize=8)

# Add grid and labels
plt.grid(True, which="both", ls="-", alpha=0.3)
plt.xlabel('Number of Threads (p)', fontsize=12)
plt.ylabel('Barrier Time (seconds)', fontsize=12)
plt.title('Barrier Execution Time vs Number of Threads', fontsize=14)

# Set x-axis ticks
plt.xticks(threads, threads, rotation=45)

# Add annotations for key points
# Annotate where significant increase starts
sig_increase_idx = 10  # 2048 threads

# Annotate maximum time
max_idx = len(times) - 1
plt.annotate(f'Max: {times[max_idx]:.4f}s', 
             xy=(threads[max_idx], times[max_idx]), 
             xytext=(threads[max_idx]/4, times[max_idx]-0.05),
             arrowprops=dict(arrowstyle='->', color='red', alpha=0.7))

# Set y-axis limits for better visibility
plt.ylim(1.99, 2.6)

plt.tight_layout()
plt.savefig('barrier_performance.png', dpi=300, bbox_inches='tight')
plt.show()

# Print analysis
print("\nBarrier Performance Analysis:")
print("="*50)
print(f"Minimum time: {min(times):.4f}s at {threads[times.index(min(times))]} threads")
print(f"Maximum time: {max(times):.4f}s at {threads[times.index(max(times))]} threads")
print(f"Time increase: {((max(times) - min(times)) / min(times) * 100):.1f}%")
print(f"\nOverhead per doubling of threads (average):")
for i in range(1, len(threads)):
    overhead = (times[i] - times[i-1]) * 1000  # Convert to milliseconds
    print(f"  {threads[i-1]:5d} -> {threads[i]:5d}: +{overhead:6.2f} ms")