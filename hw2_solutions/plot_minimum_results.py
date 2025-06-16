import matplotlib.pyplot as plt
import numpy as np

# Data from execution results
threads = [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192]
times = [0.1253, 0.0644, 0.0328, 0.0187, 0.0133, 0.0125, 0.0122, 0.0107, 0.0132, 0.0176, 0.0339, 0.0666, 0.1380, 0.2881]

# Calculate speedup (T1/Tp)
speedup = [times[0] / t for t in times]

# Create figure with two subplots
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 5))

# Plot 1: Execution time vs Number of threads (log scale)
ax1.semilogx(threads, times, 'b-o', linewidth=2, markersize=8)
ax1.set_xlabel('Number of Threads (p)', fontsize=12)
ax1.set_ylabel('Execution Time (seconds)', fontsize=12)
ax1.set_title('Execution Time vs Number of Threads\n(n = 2×10⁸)', fontsize=14)
ax1.grid(True, which="both", ls="-", alpha=0.3)
ax1.set_xticks(threads)
ax1.set_xticklabels(threads, rotation=45)

# Plot 2: Speedup vs Number of threads
ax2.semilogx(threads, speedup, 'r-o', linewidth=2, markersize=8, label='Actual speedup')
ax2.semilogx(threads[:8], threads[:8], 'k--', alpha=0.5, label='Ideal speedup')
ax2.set_xlabel('Number of Threads (p)', fontsize=12)
ax2.set_ylabel('Speedup', fontsize=12)
ax2.set_title('Speedup vs Number of Threads\n(n = 2×10⁸)', fontsize=14)
ax2.grid(True, which="both", ls="-", alpha=0.3)
ax2.set_xticks(threads)
ax2.set_xticklabels(threads, rotation=45)
ax2.set_ylim(0, 20)  # Set reasonable y-axis limits
ax2.legend()

# Add annotations for key points
min_time_idx = times.index(min(times))
ax1.annotate(f'Min: {times[min_time_idx]:.4f}s', 
             xy=(threads[min_time_idx], times[min_time_idx]), 
             xytext=(threads[min_time_idx]*2, times[min_time_idx]*1.5),
             arrowprops=dict(arrowstyle='->', color='red', alpha=0.7))

max_speedup_idx = speedup.index(max(speedup))
ax2.annotate(f'Max speedup: {speedup[max_speedup_idx]:.2f}x', 
             xy=(threads[max_speedup_idx], speedup[max_speedup_idx]), 
             xytext=(threads[max_speedup_idx]*2, speedup[max_speedup_idx]*0.8),
             arrowprops=dict(arrowstyle='->', color='red', alpha=0.7))

plt.tight_layout()
plt.savefig('minimum_performance_analysis.png', dpi=300, bbox_inches='tight')
plt.show()

# Print analysis summary
print("\nPerformance Analysis Summary:")
print("="*50)
print(f"Sequential time (1 thread): {times[0]:.4f} seconds")
print(f"Best parallel time: {min(times):.4f} seconds at {threads[min_time_idx]} threads")
print(f"Maximum speedup: {max(speedup):.2f}x at {threads[max_speedup_idx]} threads")
print(f"\nPerformance degradation starts at: {threads[min_time_idx]} threads")
print(f"Time at 8192 threads: {times[-1]:.4f} seconds (slower than sequential!)")