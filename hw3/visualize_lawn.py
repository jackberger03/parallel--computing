#!/usr/bin/env python3
"""
Ant Distribution Visualization
Equivalent to MATLAB visualization for Lawn_Data output from anthill.cpp

Usage: python visualize_lawn.py [lawn_data_file]
"""

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import sys
import os

def load_lawn_data(filename="Lawn_Data"):
    """Load lawn data from file and return X, Y, Z coordinates and values."""
    try:
        data = np.loadtxt(filename)
        return data[:, 0], data[:, 1], data[:, 2]
    except FileNotFoundError:
        print(f"Error: {filename} not found. Run anthill.exe first to generate the data.")
        sys.exit(1)
    except Exception as e:
        print(f"Error loading {filename}: {e}")
        sys.exit(1)

def visualize_ant_distribution(x_coords, y_coords, ant_counts, save_plot=True):
    """Create 3D surface plot of ant distribution."""
    
    # Calculate grid size
    m = int(np.sqrt(len(x_coords)))
    print(f"Grid size: {m} x {m}")
    print(f"Total ants: {np.sum(ant_counts):.1f}")
    print(f"Maximum ant density: {np.max(ant_counts):.6f} at position ({x_coords[np.argmax(ant_counts)]:.0f}, {y_coords[np.argmax(ant_counts)]:.0f})")
    
    # Reshape data into 2D grids
    X = x_coords.reshape(m, m)
    Y = y_coords.reshape(m, m)
    Z = ant_counts.reshape(m, m)
    
    # Create 3D surface plot
    fig = plt.figure(figsize=(12, 9))
    ax = fig.add_subplot(111, projection='3d')
    
    # Surface plot with colormap
    surf = ax.plot_surface(X, Y, Z, cmap='viridis', alpha=0.8, 
                          linewidth=0, antialiased=True)
    
    # Add contour lines at the base
    ax.contour(X, Y, Z, zdir='z', offset=0, cmap='viridis', alpha=0.5)
    
    # Labels and title
    ax.set_xlabel('X Coordinate')
    ax.set_ylabel('Y Coordinate')
    ax.set_zlabel('Expected Ant Count')
    ax.set_title('Ant Distribution Across Lawn\n(Peak indicates anthill location)')
    
    # Add colorbar
    fig.colorbar(surf, shrink=0.6, aspect=20, label='Ant Density')
    
    # Improve viewing angle
    ax.view_init(elev=30, azim=45)
    
    plt.tight_layout()
    
    if save_plot:
        plt.savefig('ant_distribution_3d.png', dpi=300, bbox_inches='tight')
        print("3D visualization saved as 'ant_distribution_3d.png'")
    
    plt.show()

def create_2d_heatmap(x_coords, y_coords, ant_counts, save_plot=True):
    """Create 2D heatmap of ant distribution."""
    
    m = int(np.sqrt(len(x_coords)))
    X = x_coords.reshape(m, m)
    Y = y_coords.reshape(m, m)
    Z = ant_counts.reshape(m, m)
    
    fig, ax = plt.subplots(figsize=(10, 8))
    
    # Create heatmap
    im = ax.imshow(Z, cmap='viridis', origin='lower', extent=[0, m-1, 0, m-1])
    
    # Add contour lines
    contours = ax.contour(X, Y, Z, colors='white', alpha=0.6, linewidths=0.5)
    ax.clabel(contours, inline=True, fontsize=8, fmt='%.3f')
    
    # Mark the peak (anthill location)
    max_idx = np.argmax(ant_counts)
    max_x, max_y = x_coords[max_idx], y_coords[max_idx]
    ax.plot(max_x, max_y, 'r*', markersize=15, label=f'Anthill ({max_x:.0f}, {max_y:.0f})')
    
    # Labels and title
    ax.set_xlabel('X Coordinate')
    ax.set_ylabel('Y Coordinate')
    ax.set_title('Ant Distribution Heatmap\n(Red star marks anthill location)')
    ax.legend()
    
    # Add colorbar
    plt.colorbar(im, label='Ant Density')
    
    plt.tight_layout()
    
    if save_plot:
        plt.savefig('ant_distribution_2d.png', dpi=300, bbox_inches='tight')
        print("2D heatmap saved as 'ant_distribution_2d.png'")
    
    plt.show()

def main():
    """Main function to load data and create visualizations."""
    
    # Check command line arguments
    filename = sys.argv[1] if len(sys.argv) > 1 else "Lawn_Data"
    
    print(f"Loading lawn data from '{filename}'...")
    
    # Load data
    x_coords, y_coords, ant_counts = load_lawn_data(filename)
    
    print("Creating visualizations...")
    
    # Create both 3D and 2D visualizations
    visualize_ant_distribution(x_coords, y_coords, ant_counts)
    create_2d_heatmap(x_coords, y_coords, ant_counts)
    
    print("Visualization complete!")

if __name__ == "__main__":
    main() 