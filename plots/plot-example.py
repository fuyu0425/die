#!/usr/bin/env python3
"""Simple CSV to PDF plot using matplotlib."""
import csv
import os
import sys
import matplotlib.pyplot as plt

def main():
    csv_file = sys.argv[1]
    output_file = os.environ.get("OUT")

    # Read CSV data
    with open(csv_file) as f:
        reader = csv.DictReader(f)
        data = list(reader)

    # Extract columns for plotting
    x = [row['x'] for row in data]
    y = [float(row['y']) for row in data]

    # Create bar plot
    fig, ax = plt.subplots(figsize=(6, 4))
    ax.bar(x, y)
    ax.set_xlabel('Category')
    ax.set_ylabel('Value')
    ax.set_title('Example Plot')

    if output_file:
        plt.savefig(output_file, bbox_inches='tight')
    plt.close()

if __name__ == "__main__":
    main()

# ARGS: example-data.csv
