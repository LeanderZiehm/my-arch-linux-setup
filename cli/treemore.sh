find . -type f | while read file; do
    echo "===== $file ====="
    cat "$file"
    echo
done
