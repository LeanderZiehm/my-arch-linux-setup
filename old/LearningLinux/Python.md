# Disable Python Cashe and Delete

export PYTHONDONTWRITEBYTECODE=1

find . -type d -name "__pycache__" -print
find . -type d -name "__pycache__" -exec rm -r {} +
