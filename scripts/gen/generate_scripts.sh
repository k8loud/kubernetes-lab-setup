#!/bin/bash
cd "$(dirname "$0")"

SCRIPTS_PATH=".."
BRANCH="feature/more-terraform"

function generate_script() {
  local recipe="$1"
  local script="target/$recipe.sh"
  echo '' > "$script"
  chmod +x "$script"
  while IFS="" read -r p || [ -n "$p" ]; do
    local sub_script=$(printf '%s\n' "$p")
    local sub_script_path_aware=$(echo "$SCRIPTS_PATH/$sub_script")
    echo "Appending $sub_script"
    cat "$sub_script_path_aware" >> "$script"
    [[ "$sub_script" == "server_setup/00_initial.sh" ]] && echo "git checkout $BRANCH" >> "$script"
    echo -e "echo '===== Finished $sub_script ====='\n\n\n" >> "$script"
  done < "recipe/$recipe.txt"
  echo -e "echo '===== Finished ALL_SUB_SCRIPTS ====='\n" >> "$script"
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
