import os
import csv

def fix_timestamp(timestamp):
    parts = timestamp.split('.')
    if len(parts) == 1:
        return timestamp[:-1] + '.000000Z'

    return timestamp

def fix_timestamps_in_directory(directory):
    for filename in os.listdir(directory):
        print(filename)
        if filename.endswith(".txt"):
            file_path = os.path.join(directory, filename)

            with open(file_path, 'r') as file:
                reader = csv.reader(file)
                lines = list(reader)

            for i, line in enumerate(lines):
                # Check if the third column timestamp needs fixing
                line[2] = fix_timestamp(line[2])

                # Check if the fourth column timestamp needs fixing
                line[3] = fix_timestamp(line[3])

                lines[i] = line  # Update the line in the list

            with open(file_path, 'w', newline='') as file:
                writer = csv.writer(file)
                writer.writerows(lines)

# Example usage:
directory_path = 'data'  # Replace with your directory path containing CSV files
fix_timestamps_in_directory(directory_path)
