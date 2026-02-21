#!/usr/bin/env python3
"""
Simple CSV to LaTeX table converter.

Reads a CSV file and generates a LaTeX tabular environment with booktabs.
"""
import csv
import os
import pathlib
import sys


def generate_latex_table(csv_file):
    """
    Generate LaTeX tabular code from a CSV file.
    """
    with open(csv_file, "r") as f:
        reader = csv.reader(f)
        rows = list(reader)

    if not rows:
        return ""

    headers = rows[0]
    data_rows = rows[1:]

    # Build column specification (left-aligned for all columns)
    col_spec = "l" * len(headers)

    # Build header row with bold formatting
    header_cells = [f"\\textbf{{{h}}}" for h in headers]
    header_line = " & ".join(header_cells) + r" \\"

    # Build data rows
    data_lines = []
    for row in data_rows:
        data_lines.append(" & ".join(row) + r" \\")

    # Construct the full table
    data_block = "\n    ".join(data_lines)
    latex_table = f"""\\begin{{tabular}}{{{col_spec}}}
    \\toprule
    {header_line}
    \\midrule
    {data_block}
    \\bottomrule
\\end{{tabular}}"""

    return latex_table


def main():
    if len(sys.argv) < 2:
        print("Usage: table-example.py <csv_file>", file=sys.stderr)
        sys.exit(1)

    csv_file = pathlib.Path(sys.argv[1])
    output_file = os.environ.get("OUT")

    latex_table = generate_latex_table(csv_file)
    print(latex_table)

    if output_file:
        with open(output_file, "w") as f:
            f.write(latex_table)


if __name__ == "__main__":
    main()

# ARGS: example-data.csv
