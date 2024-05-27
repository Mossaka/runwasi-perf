#!/bin/bash

# Check if the number of repetitions is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <number_of_repetitions>"
    exit 1
fi

echo "#########################################"
echo "Containerd + RUNWASI with Spin SHIM"
echo "#########################################"
echo

# Get the number of repetitions from the command-line argument
N=$1

# Initialize arrays to store time differences
time_differences=()

# Loop N times
for ((i=1; i<=$N; i++)); do
    echo "Running experiment $i"

    # Get the initial timestamp in milliseconds
    start_timestamp=$(date +%s%3N)

    # Execute containerd with crun
    end_timestamp=$(ctr run --rm --runtime io.containerd.spin.v2  docker.io/library/spin_performance_test:v3 test)

    # Calculate the difference in milliseconds
    time_difference=$((end_timestamp - start_timestamp))

    # Store the time difference in the array
    time_differences+=($time_difference)

    echo "Start timestamp in milis: $start_timestamp" milliseconds
    echo "End timestamp in milis: $end_timestamp" milliseconds
    echo "Time difference: $time_difference milliseconds"
    echo
done

# Calculate mean
mean=0
for time_diff in "${time_differences[@]}"; do
    mean=$((mean + time_diff))
done
mean=$((mean / N))

# Calculate median
sorted_times=($(for val in "${time_differences[@]}"; do echo $val; done | sort))
middle=$((N / 2))
median=$((N % 2 ? sorted_times[middle] : (sorted_times[middle-1] + sorted_times[middle]) / 2))

# Calculate mode
mode=$(printf "%s\n" "${time_differences[@]}" | sort | uniq -c | sort -n | tail -n1 | awk '{print $2}')

# Calculate standard deviation
sum_squared_diff=0
for time_diff in "${time_differences[@]}"; do
    squared_diff=$(( (time_diff - mean) ** 2 ))
    sum_squared_diff=$((sum_squared_diff + squared_diff))
done
variance=$((sum_squared_diff / N))
standard_deviation=$(echo "scale=2; sqrt($variance)" | bc)

# Calculate minimum and maximum
minimum=$(printf "%s\n" "${time_differences[@]}" | sort -n | head -n1)
maximum=$(printf "%s\n" "${time_differences[@]}" | sort -n | tail -n1)

# Print the results
echo "Mean: $mean milliseconds"
echo "Median: $median milliseconds"
echo "Mode: $mode milliseconds"
echo "Standard Deviation: $standard_deviation milliseconds"
echo "Minimum Time: $minimum milliseconds"
echo "Maximum Time: $maximum milliseconds"
