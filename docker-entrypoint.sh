#!/bin/bash
set -Eeo pipefail
# TODO swap to -Eeuo pipefail above (after handling all potentially-unset variab

_is_sourced() {
	# https://unix.stackexchange.com/a/215279
	[ "${#FUNCNAME[@]}" -ge 2 ] \
		&& [ "${FUNCNAME[0]}" = '_is_sourced' ] \
		&& [ "${FUNCNAME[1]}" = 'source' ]
}

_main() {
	# if first arg looks like a flag, assume we want to run heroku commands
	#echo "$@"
	if [ "${1:0:1}" = '-' ]; then
	  echo "First if"
		set -- heroku "$@"
	fi

	if [ "$1" = 'bash' ]; then
	  exec "$@"
	fi

	if [ "$1" = '/bin/bash' ]; then
	  exec "$@"
	fi

	exec heroku "$@"
	}

if ! _is_sourced; then
	_main "$@"
fi