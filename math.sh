#!/bin/bash

HISTORY_FILE=".history"
touch "$HISTORY_FILE"

function display_help {
  echo "Math Calculator"
  echo "Usage: ./math.sh [OPTIONS]"
  echo "Options:"
  echo "  --help            Display this help message."
  echo "  --history         Display the history of previous calculations."
  echo "  --clean-history   Remove the history file."
}

function display_history {
  if [ -s "$HISTORY_FILE" ]; then
    echo "Command history:"
    cat "$HISTORY_FILE"
  else
    echo "No commands in history."
  fi
}

function clean_history {
  if [ -s "$HISTORY_FILE" ]; then
    rm -rf "$HISTORY_FILE"
    echo "History file removed."
  else
    echo "History does not exist."
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --help)
      display_help
      exit 0
      ;;
    --history)
      display_history
      exit 0
      ;;
    --clean-history)
      clean_history
      exit 0
      ;;
    *)
      echo "Invalid option: $1. Type --help to see all options."
      exit 1
      ;;
  esac
  shift
done

echo "Welcome to the math calculator!"
echo "Type 'exit' or press Ctrl+C to quit."

while true; do
  read -p "Please enter a mathematical expression: " input

  if [ "$input" == "exit" ]; then
    echo "Exiting interactive mode."
    break
  fi

  if [ "$input" == "history" ]; then
    if [ -s "$HISTORY_FILE" ]; then
      echo "Command history:"
      cat "$HISTORY_FILE"
    else
      echo "No commands in history."
    fi
  fi

  if [ -z "$input" ]; then
    echo "Error: Please enter a mathematical expression."
    continue
  fi

  if [[ "$input" =~ \. ]]; then
    decimal_places=${input##*.}
    scale=${#decimal_places}
    
    result=$(echo "scale=$scale; $input" | bc -l 2>/dev/null)
  else
    result=$(echo "$input" | bc 2>/dev/null)
  fi

  if [[ "$input" == *"/0"* ]] || [[ "$input" == *"/ 0"* ]]; then
    echo "Error: Division by 0 is not allowed."
    continue
  else
    echo "$input = $result" >> "$HISTORY_FILE"
    echo "Result: $result"
  fi
done
