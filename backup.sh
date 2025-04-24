#!/usr/bin/env bash
set -euo pipefail

# Function to display usage information
usage() {
    cat <<EOF >&2
Usage: $0 <source_directory> <destination_directory>

Creates a gzipped tarball of files changed in the last 24h.
EOF
}

# Display help and exit if -h or --help is provided
if [[ "${1-:-}" == "-h" ]] || [[ "${1-:-}" == "--help" ]]; then
    usage
    exit 0
fi

# Check that exactly two arguments are provided
if (( $# != 2 )); then
    echo "Usage: $0 <source_directory> <destination_directory>" >&2
    exit 1
fi

# Resolve absolute paths for source and destination directories
src=$(realpath -m "$1")
dst=$(realpath -m "$2")

# Validate that source and destination directories exist
for dir in "$src" "$dst"; do
    if [[ ! -d $dir ]]; then
        echo "Directory not found: $dir" >&2
        exit 1
    fi
done

# Display the source and destination paths
echo "Source:      $src"
echo "Destination: $dst"
echo

# Calculate timestamps: current time and 24 hours ago
currentTS=$(date +%s)
yesterdayTS=$(( currentTS - 24*60*60 ))

# Initialize an array to hold files to backup
declare -a toBackup=()

# Change to the source directory
cd "$src"

# Loop over all items in the source directory
for file in *; do
    # Skip if not a regular file
    [[ -f $file ]] || continue

    # Get the last modification time of the file (in seconds since epoch)
    mtime=$(date -r "$file" +%s)

    # If the file was modified within the last 24 hours, add to the list
    if (( mtime > yesterdayTS )); then
        toBackup+=("$file")
    fi
done

# Define the backup filename and its full path in the destination directory
backupFileName="backup-${currentTS}.tar.gz"
fullPath="$dst/$backupFileName"

# Create a gzipped tarball in the destination directory, preserving relative paths
tar -czvf "$fullPath" -C "$src" "${toBackup[@]}"

# Provide feedback about the backup operation
echo "Files backed up (${#toBackup[@]}): ${toBackup[*]}"
echo "Backup saved to: $fullPath"
