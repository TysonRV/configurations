#!/bin/bash

#############
# Variables #
#############

#####################
# Exports variables #
#####################
export PS1="[\[\033[32m\]\w\[\033[0m\]]\$(parse_git_branch)\n\$(get_date) \[\033[1;36m\]\[\033[1;33m\]-> \[\033[0m\]"
export PYTHONIOENCODING=utf_8
export EDITOR=nano

# Mac
export PIP_DOWNLOAD_CACHE=$HOME/Library/Caches/pip-downloads

#############
# Functions #
#############

parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

parse_git_remote () {
    git ls-remote --get-url 2> /dev/null | sed "s/git@github.com:/https:\/\/github.com\//" | sed s/.git$//
}

kill_port () {
    lsof -i tcp:$1
    lsof -t -i tcp:$1 | xargs kill -9
}

get_date () {
    date "+%H:%M:%S"
}

all () {
    cmd="$*"

    for i in *; do
        echo ""
        echo "'$cmd' on $i"
        pushd $i >/dev/null
        bash -c $cmd 2> /dev/null || true
        popd >/dev/null
    done;
}

###########
# Aliases #
###########
alias venv='virtualenv .venv && . .venv/bin/activate'
alias grep='grep --color=auto'

# ls aliases
alias l='ls -1'
alias ll='ls -lah'
alias ls='ls'

# work aliases
alias e='if [ -d .venv ]; then . .venv/bin/activate; fi'

# python aliases
alias run='python manage.py runserver'

# Clean pyc files
alias clean='find . -name "*~" -delete && find . -name "*.pyc" -delete'

# Remove the storage folder, migrate the db, load initial data, generate some new data, and load the auth file
alias gsmash='rm -rf .storage/ && ./manage.py migrate && ./manage.py loaddata initial_data && ./manage.py generate_data && ./manage.py loaddata .idea/auth.yaml'
alias gclear='git branch --merged | grep -v "\*\|master\|develop\|trodriguez/bits_and_bobs" | xargs -n 1 git branch -d'
alias mmsmash='dropdb mailman && createdb mailman && ./manage.py migrate'
alias clear_migrations='find . -path "*/migrations/*.py" -not -name "__init__.py" -delete && find . -path "*/migrations/*.pyc" -delete'

# Docker
alias docker_container_wipe='docker rm -f $(docker ps -a -q)'
alias docker_image_wipe='docker rmi -f $(docker images -q)'
