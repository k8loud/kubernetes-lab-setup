#!/bin/bash
cd "$(dirname "$0")"
source ./constants.sh

EVAL_CHAR='%'
COMMENT_CHAR='#'
SCRIPTS_PATH=".."
SHEBANG="#!/bin/bash"

function append_start() {
  local step="$1"
  echo -e "\necho '===== Starting $step ====='" >> "$script"
}

function append_end() {
  local step="$1"
  echo -e "\necho '===== Finished $step ====='" >> "$script"
}

function substitute_variables() {
  local line="$1"
  eval "echo \"$line\""
}

function generate_script() {
  local recipe="$1"
  local script="target/$recipe.sh"
  echo "$SHEBANG" > "$script"
  chmod +x "$script"
  while IFS="" read -r p || [ -n "$p" ]; do
    local step=$(printf '%s\n' "$p")
    if [[ ${step::1} == "$COMMENT_CHAR" ]]; then
      step="${step:1}" # Remove $COMMENT_CHAR
      echo "Skipping commented out step: $step"
    elif [[ ${step::1} == "$EVAL_CHAR" ]]; then
      step="${step:1}" # Remove $EVAL_CHAR
      echo "Appending eval: $step"
      echo -e "\n#$EVAL_CHAR$step" >> "$script"
      echo "$(substitute_variables "$step")" >> "$script"
    else
      local sub_script=$(echo "$SCRIPTS_PATH/$step")
      echo "Appending: $sub_script"
      append_start "$sub_script"
      cat "$sub_script" | grep -v "$SHEBANG" >> "$script"
      append_end "$sub_script"
    fi
  done < "recipe/$recipe.txt"
  append_end "ALL_STEPS"
  echo
}

function main() {
  mkdir -p "target"
  for recipe_file in recipe/*.txt; do
    [ -e "$recipe_file" ] || continue
    recipe="${recipe_file%.*}"
    recipe=$(basename $recipe)
    echo "Generating based on $recipe"
    generate_script "$recipe"
  done
}

main
