#!/bin/bash

# Check if a log file path is provided
if [ $# -eq 0 ]; then
    echo "Please provide the path to the log file as an argument."
    exit 1
fi

# Input log file
log_file="$1"

# Check if the log file exists
if [ ! -f "$log_file" ]; then
    echo "Error: Log file '$log_file' does not exist."
    exit 1
fi

# Output summary file
summary_file="summary_report_$(date +%Y%m%d).txt"

# Count total lines
total_lines=$(wc -l < "$log_file")

# Count error messages
error_count=$(grep -c "ERROR" "$log_file")

# Find critical events
critical_events=$(grep -n "CRITICAL" "$log_file")

# Find top 5 error messages
top_errors=$(grep "ERROR" "$log_file" | sort | uniq -c | sort -rn | head -5)

# Generate summary report
{
    echo "Log Analysis Summary Report"
    echo "==========================="
    echo "Date of Analysis: $(date)"
    echo "Log File: $log_file"
    echo "Total Lines Processed: $total_lines"
    echo "Total Error Count: $error_count"
    echo ""
    echo "Top 5 Error Messages:"
    echo "$top_errors"
    echo ""
    echo "Critical Events (with line numbers):"
    echo "$critical_events"
} > "$summary_file"

echo "Summary report generated: $summary_file"

# Optional: Archive the log file
archive_dir="processed_logs"
if [ ! -d "$archive_dir" ]; then
	    mkdir "$archive_dir"
fi

mv "$log_file" "$archive_dir/"
echo "Log file moved to $archive_dir/"

echo "Log analysis completed."
