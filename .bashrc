# ~/.bashrc: executed by bash(1) for non-login shells.
# This file configures some aliases and the prompt of
# our web container

export LS_OPTIONS='--color=auto'
export SHELL=/bin/bash
eval "`dircolors`"

alias be='bundle exec'
alias rs='bundle exec rspec'

export PS1="\u\[\e[32m\]@\[\e[m\]\[\e[35m\]\h\[\e[m\]:\w \[\e[36m\]⇒\[\e[m\] "
