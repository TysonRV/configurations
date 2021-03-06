#!/bin/bash

configure_history () {
    # Dont insert duplicates, or commands beggining with space
    # configure history size
    # append to the history file, don't overwrite it

    export HISTCONTROL=ignoredups:ignorespace
    export HISTSIZE=1000000
    export HISTFILESIZE=2000000
    shopt -s histappend
}

configure_bash () {
    # Bring in our aliases and autocompletion

    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi

    if [ -f ~/.bash_completion ] && ! shopt -oq posix; then
        . ~/.bash_completion
    fi
}

configure_shell () {
    # make less more friendly for non-text input files
    # Adjust window cols and rows on each command

    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
    shopt -s checkwinsize
}

configure_ssh_agent () {
    # Start up our ssh-agent and add our identity

    if [ ! -S ~/.ssh/ssh_auth_sock ]; then
        eval `ssh-agent`
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
    fi

    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
    ssh-add ~/.ssh/id_wab
    ssh-add -l | grep "The agent has no identities" && ssh-add
}

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

configure_shell
configure_history
configure_bash
configure_ssh_agent

