#!/usr/bin/env python3

# Data from execution results
threads = [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192]
times = [0.1253, 0.0644, 0.0328, 0.0187, 0.0133, 0.0125, 0.0122, 0.0107, 0.0132, 0.0176, 0.0339, 0.0666, 0.1380, 0.2881]

# Calculate speedup (T1/Tp)
speedup = [times[0] / t for t in times]

# Calculate efficiency
efficiency = [s / p for s, p in zip(speedup, threads)]

print("Performance Analysis for List Minimum (n = 2×10⁸)")
print("=" * 70)
print(f"{'Threads':>8} | {'Time (s)':>10} | {'Speedup':>10} | {'Efficiency':>10}")
print("-" * 70)

for i in range(len(threads)):
    print(f"{threads[i]:>8} | {times[i]:>10.4f} | {speedup[i]:>10.2f} | {efficiency[i]:>10.3f}")

print("\n" + "=" * 70)
print("\nKey Observations:")
print("-" * 30)

# Find optimal thread count
min_time_idx = times.index(min(times))
print(f"1. Optimal performance: {threads[min_time_idx]} threads")
print(f"   - Execution time: {times[min_time_idx]:.4f} seconds")
print(f"   - Speedup: {speedup[min_time_idx]:.2f}x")
print(f"   - Efficiency: {efficiency[min_time_idx]:.1%}")

# Find where performance starts degrading
print(f"\n2. Performance degradation begins after {threads[min_time_idx]} threads")
print(f"   - Time increases from {times[min_time_idx]:.4f}s to {times[min_time_idx+1]:.4f}s")

# Compare worst vs best
worst_idx = times.index(max(times))
print(f"\n3. Worst performance: {threads[worst_idx]} threads")
print(f"   - Time: {times[worst_idx]:.4f}s (even slower than sequential!)")
print(f"   - This is {times[worst_idx]/times[0]:.2f}x slower than single-threaded")

print("\n\nReasons for Performance Variation:")
print("-" * 40)
print("1. **Initial speedup (1-128 threads)**: Good parallel efficiency due to:")
print("   - Effective work distribution")
print("   - Hardware parallelism utilization")
print("   - Cache benefits from smaller working sets per thread")

print("\n2. **Performance plateau (32-128 threads)**: Limited by:")
print("   - Memory bandwidth saturation")
print("   - Synchronization overhead becoming significant")

print("\n3. **Performance degradation (256+ threads)**: Caused by:")
print("   - Thread creation/management overhead exceeds computation")
print("   - Cache thrashing and false sharing")
print("   - OS scheduling overhead")
print("   - Exceeds hardware thread capacity (hyperthreading limits)")

print("\n4. **Severe degradation (4096-8192 threads)**: Due to:")
print("   - Massive context switching overhead")
print("   - Memory contention and synchronization bottlenecks")
print("   - Each thread does minimal work (n/p = 24,414 elements)")

# Generate CSV for external plotting
print("\n\nCSV Data (for plotting):")
print("-" * 30)
print("threads,time,speedup,efficiency")
for i in range(len(threads)):
    print(f"{threads[i]},{times[i]},{speedup[i]:.4f},{efficiency[i]:.4f}")