#!/bin/bash

# Specify the target directory
target_directory="$LFS/sources"

#!/bin/bash

# Specify the target directory

# List directories starting with "abc"
dirname="binutils"
directories=$(find "$target_directory" -mindepth 1 -maxdepth 1 -type d -name "$dirname*" | wc -l)

# Display the result
echo "Directories starting with 'abc' in $target_directory:"
echo "$directories"

