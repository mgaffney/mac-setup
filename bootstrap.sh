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

FORMULAS=(
  python
  python3
  ack
  autojump
  bash
  coreutils
  ctags
  curl
  direnv
  dos2unix
  ffmpeg
  findutils
  fzf
  git
  gnupg
  go
  gperftools
  gpg-agent
  graphvix
  grep
  hub
  jq
  lesspipe
  macvim
  netcat
  nmap
  osxutils
  p7zip
  pandoc
  pinentry-mac
  plantuml
  protobuf
  reattach-to-user-namespace
  ripgrep
  shellcheck
  sloccount
  sox
  ssh-copy-id
  terminal-notifier
  the_silver_searcher
  tidy-html5
  tmux
  tree
  unrar
  w3m
  wget
  youtube-dl
  zsh
  zsh-completions
)
readonly FORMULAS

function err() {
  echo "$@" >&2
}

function main() {
  hash brew 2>/dev/null || { err "Abort: brew is not install"; exit 1; }

  for formula in "${FORMULAS[@]}"; do
    brew install "${formula}"
  done
}

main "$@"
