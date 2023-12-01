#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

error () {
	>&2 echo "$@"
	false
}

main () {
	local target_dir=$PWD

	pushd $SCRIPT_DIR >/dev/null

	for name in "$@"; do
		stat "$name" >/dev/null || error "Template $name not found"
	done

	for name in "$@"; do
		pushd "$name" >/dev/null

		find -type d -exec mkdir -p "$target_dir"/{} \;
		find -type f -exec bash -c 'cat "$0" >> "'"$target_dir"'"/"$0"' {} \;

		popd >/dev/null
	done
}

main "$@"
