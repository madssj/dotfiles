#!/bin/sh

find . -not -wholename "*.git*" -not -name . -not -name install.sh -print0 | while IFS= read -r -d '' i; do
	name="$(echo "$i" | sed -e 's/^\.\///' | sed -e 's/^dot//')"

	ln -si "$i" ~/"$name"
done
