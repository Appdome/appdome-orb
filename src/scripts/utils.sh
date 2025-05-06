expand_env_vars_with_prefix() {
  local prefix="$1"
  local out_var="$2"

  if [[ -z "$prefix" || -z "$out_var" ]]; then
    echo "❌ Usage: expand_env_vars_with_prefix <PREFIX> <output_variable>" >&2
    return 1
  fi

  local file_paths=""
  local env_var

  echo "🔍 Scanning environment variables starting with: $prefix"
  while IFS='=' read -r env_var _; do
    local value="${!env_var}"
    if [[ -n "$value" ]]; then
      local index="${env_var##*_}"
      [[ "$index" == "$env_var" ]] && index=""  # unset if no numeric suffix
      local file_name="${prefix,,}${index}.decoded"
      local path="appdome_files/$file_name"

      echo "✅ Found env var: $env_var"
      echo "📦 Writing to: $path"
      echo -n "$value" | base64 -d > "$path"

      file_paths+="$path,"
    fi
  done < <(env | grep "^${prefix}")

  # Strip trailing comma and export
  file_paths="${file_paths%,}"
  eval "$out_var=\"$file_paths\""
  echo "📋 Final list for $out_var: $file_paths"
}
