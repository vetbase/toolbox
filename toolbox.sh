#!/bin/bash

toolboxes=(
    'golang::Toolbox for working with Go applications'
)

if ! type "vagrant" > /dev/null; then
    echo "Vagrant (https://www.vagrantup.com/downloads.html) must be installed before building toolboxes"
fi

usage () {
    echo "Usage: $0 run <toolbox>" 1>&2;
    exit 1;
}

up () {
    echo "Running $1 toolbox"
    cd $1 && vagrant up
}

if [ $# -eq 0 ]; then
    usage
fi

if [ "$1" = "run" ]; then

    if [ "$2" = "" ]; then
        echo "ERROR: Run requires a toolbox name."
        echo "SUB-COMMANDS:"
        echo -e "list\tlist available boxes"
    fi

    if [ "$2" = "list" ]; then
        echo "Available Toolboxes"
        for index in "${toolboxes[@]}"; do
            KEY="${index%%::*}"
            VALUE="${index##*::}"
            echo -e "$KEY\t\t$VALUE";
        done
    fi

    for index in "${toolboxes[@]}"; do
        KEY="${index%%::*}"
        if [ "$2" = "$KEY" ]; then
            up $2
            break
        fi
    done
fi
