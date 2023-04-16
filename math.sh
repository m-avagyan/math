#!/bin/bash

echo "Welcome to the math calculator!"

while true; do
  read -p "Please enter a mathematical expression (type 'exit' or press Ctrl+C to quit): " input

  if [ "$input" == "exit" ]; then
    echo "Exiting interactive mode."
    break
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
    echo "Result: $result"
  fi
done
