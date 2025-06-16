#!/usr/bin/env python3
"""
Question 6: Plot time versus ntasks-per-node
"""

import matplotlib.pyplot as plt

# Data
ntasks = [4, 8, 16, 32]
times = [0.3550, 0.2938, 0.3998, 0.3533]

# Plot
plt.figure(figsize=(10, 6))
plt.plot(ntasks, times, 'bo-', linewidth=3, markersize=10)

plt.xlabel('ntasks-per-node', fontsize=14)
plt.ylabel('Execution Time (seconds)', fontsize=14)
plt.title('Time vs ntasks-per-node (n=10¹⁰, p=64)', fontsize=16)
plt.grid(True, alpha=0.3)

# Add values
for i, (x, y) in enumerate(zip(ntasks, times)):
    plt.annotate(f'{y:.4f}s', (x, y), textcoords="offset points", xytext=(0,15), ha='center')

plt.tight_layout()
plt.savefig('question6.png', dpi=300, bbox_inches='tight')
plt.show()

print(f"ANSWER: ntasks-per-node = {ntasks[min_idx]} minimizes total time ({times[min_idx]:.4f}s)")