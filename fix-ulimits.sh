#!/usr/bin/env bash

# The following options are the equivalent of set -eux
# exit the script if we run into errors (-e)
# set -o errexit
# accessing an unset variable or parameter should cause an error (-u)
# set -o nounset
# print a trace of commands (-x)
# set -o xtrace

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
readonly SCRIPTDIR

function err() {
  echo "$@" >&2
}

function install() {
  local -r src="$1"
  local -r target="/Library/LaunchDaemons/${src##*/}"

  echo "${src}" "${target}"
  cp "${src}" "${target}"
  chown root:wheel "${target}"
  chmod 0644 "${target}"
  launchctl load -w "${target}"
}

function main() {
  if [[ $EUID -ne 0 ]]; then
    echo "$EUID - This script must be run as root"
    return 1
  fi

  install "${SCRIPTDIR}/limit.maxfiles.plist"
  install "${SCRIPTDIR}/limit.maxproc.plist"
}

main "$@"
