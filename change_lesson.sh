#!/bin/bash

# Check if lesson name is provided
if [ -z "$1" ]; then
    echo "Error: Please provide the lesson name as an argument."
    echo "Usage: ./replace_template.sh [lesson_name]"
    echo "Example: ./replace_template.sh meme-generator"
    exit 1
fi

LESSON_NAME=$1
TEMPLATES_DIR="templates-scrimba/$LESSON_NAME"
SRC_DIR="src"

# Check if templates directory exists
if [ ! -d "$TEMPLATES_DIR" ]; then
    echo "Error: Template directory '$TEMPLATES_DIR' not found."
    echo "Available lessons:"
    ls templates-scrimba | grep -v "README.md"
    exit 1
fi

# Backup current src folder if it exists
if [ -d "$SRC_DIR" ]; then
    BACKUP_NAME="src_backup_$(date +%Y%m%d_%H%M%S)"
    echo "Backing up current src folder as $BACKUP_NAME"
    mv "$SRC_DIR" "$BACKUP_NAME"
fi

# Copy template files
echo "Copying template files from $TEMPLATES_DIR to $SRC_DIR"
cp -r "$TEMPLATES_DIR" "$SRC_DIR"

echo "Successfully replaced src folder with $LESSON_NAME template"