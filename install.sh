#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

find "$DIR" -not -wholename "*.git*" -not -samefile "$DIR" -not -name install.sh -print0 | while IFS= read -r -d '' i; do
	name="$(echo "$i" | sed -e "s,^"$DIR"/,," | sed -e 's/^dot//')"

	ln -sf "$i" ~/"$name"
done
