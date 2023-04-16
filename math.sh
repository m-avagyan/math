#!/bin/bash

echo "Welcome to the math calculator!"

while true; do
  read -p "Please enter a mathematical expression (or press Ctrl+C to quit): " input

  if [ -z "$input" ]; then
    echo "Error: Please enter a mathematical expression."
    continue
  fi

  if [[ "$input" =~ \. ]]; then
    read -p "Enter the scale for floating point operations: " scale
    result=$(echo "scale=$scale; $input" | bc -l 2>/dev/null)
  else
    result=$(echo "$input" | bc 2>/dev/null)
  fi

  if [[ "$input" == *"/0"* ]] || [[ "$input" == *"/ 0"* ]]; then
    echo "Error: Division by 0 is not allowed."
    continue
  else
    echo "Result: $result"
  fi
done
