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

# Kill npm run dev if running (search globally since it might be in src/)
echo "Checking for running npm run dev process..."
NPM_PID=$(pgrep -f "npm run dev")
if [ ! -z "$NPM_PID" ]; then
    echo "Killing npm run dev (PID: $NPM_PID)..."
    kill -9 $NPM_PID
fi

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

# Restart npm run dev inside src folder
echo "Restarting npm run dev in $SRC_DIR..."
(
    cd "$SRC_DIR" || exit
    npm run dev > /dev/null 2>&1 &
    NPM_PID=$!
    echo "npm run dev running in $SRC_DIR (PID: $NPM_PID)"
)

echo "Successfully:"
echo "- Replaced src folder with $LESSON_NAME template"
echo "- Restarted dev server inside $SRC_DIR"