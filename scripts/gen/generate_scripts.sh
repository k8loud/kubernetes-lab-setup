#!/bin/bash
cd "$(dirname "$0")"
source ./constants.sh

SCRIPTS_PATH=".."

function append_start() {
  echo -e "\necho '===== Starting $line ====='" >> "$script"
}

function append_end() {
  echo -e "\necho '===== Finished $line ====='" >> "$script"
}

function substitute_variables() {
  local line="$1"
  eval "echo \"$line\""
}

function generate_script() {
  local recipe="$1"
  local script="target/$recipe.sh"
  echo '' > "$script"
  chmod +x "$script"
  while IFS="" read -r p || [ -n "$p" ]; do
    local line=$(printf '%s\n' "$p")
    if [[ ${line::1} == '>' ]]; then
      line="${line:1}" # Remove eval indicating char
      echo "Appending eval '$line'"
      echo -e "\n#>$line" >> "$script"
      echo "$(substitute_variables "$line")" >> "$script"
    else
      local sub_script=$(echo "$SCRIPTS_PATH/$line")
      echo "Appending $sub_script"
      append_start "$sub_script"
      cat "$sub_script" >> "$script"
      append_end "$sub_script"
    fi
  done < "recipe/$recipe.txt"
  echo -e "echo '===== Finished ALL_lineS ====='\n" >> "$script"
  echo
}

function main() {
  for recipe_file in recipe/*.txt; do
    [ -e "$recipe_file" ] || continue
    recipe="${recipe_file%.*}"
    recipe=$(basename $recipe)
    echo "Generating based on $recipe"
    generate_script "$(basename $recipe)"
  done
}

main
