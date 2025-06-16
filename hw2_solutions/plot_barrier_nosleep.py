import matplotlib.pyplot as plt

# Data from barrier execution results with sleeptime = 0
threads = [2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384]
times = [0.0020, 0.0007, 0.0007, 0.0009, 0.0013, 0.0021, 0.0041, 0.0068, 0.0136, 0.0275, 0.0561, 0.1174, 0.2376, 0.4713]

# Create the plot
plt.figure(figsize=(10, 6))
plt.semilogx(threads, times, 'g-o', linewidth=2, markersize=8)

# Add grid and labels
plt.grid(True, which="both", ls="-", alpha=0.3)
plt.xlabel('Number of Threads (p)', fontsize=12)
plt.ylabel('Barrier Time (seconds)', fontsize=12)
plt.title('Barrier Execution Time vs Number of Threads\n(sleeptime = 0)', fontsize=14)

# Set x-axis ticks
plt.xticks(threads, threads, rotation=45)

# Add annotations for key points

plt.annotate(f'Max: {times[-1]:.4f}s', 
             xy=(threads[-1], times[-1]), 
             xytext=(threads[-1]/8, times[-1]*0.7),
             arrowprops=dict(arrowstyle='->', color='red', alpha=0.7))

plt.tight_layout()
plt.savefig('barrier_nosleep_performance.png', dpi=300, bbox_inches='tight')
plt.show()

# Analysis
print("\nBarrier Performance Analysis (sleeptime = 0):")
print("="*55)
print(f"Minimum time: {min(times):.4f}s at {threads[times.index(min(times))]} threads")
print(f"Maximum time: {max(times):.4f}s at {threads[times.index(max(times))]} threads")
print(f"Growth factor: {max(times)/min(times):.1f}x increase")

print(f"\nGrowth characterization:")
print("- Times approximately DOUBLE with each thread count doubling")
print("- This indicates O(p) or linear growth in barrier overhead")

print(f"\nDoubling analysis:")
for i in range(1, len(threads)):
    if threads[i] == 2 * threads[i-1]:  # Perfect doubling
        ratio = times[i] / times[i-1]
        print(f"  {threads[i-1]:5d} -> {threads[i]:5d} threads: {ratio:.2f}x time increase")

print(f"\nReason for growth:")
print("- Barrier synchronization overhead increases with thread count")
print("- More threads = more coordination required at each barrier")
print("- Cache coherence traffic increases quadratically")
print("- Memory contention at barrier variables increases")
print("- Context switching overhead grows with thread count")