#! /usr/bin/env bash

TAG="latest"

Usage="Build CLOSURE container

Usage: ${0##*/} [-h] [-r R] [-t T] [-c]  DIRECTORY
where:
  -h, --help show this help message and exit
  -t TAG     image tag (default=latest)
  -m HWMODE  Hardware mode (ilip, mind, emu)
  -c         no cache when building"
 
usage()
{
    echo; echo "$Usage"
    exit 1
}

NOCACHE=""

ARGS=$(getopt -o 'm:t:ch' -l 'help' -- "$@")
if [ $? -ne 0 ]
then
    usage
fi

eval set -- "$ARGS"
while :
do
    case "$1" in
	-h|--help)
	    shift
	    usage
	    ;;
	-c)
	    shift
	    NOCACHE="--no-cache"
	    ;;
	-t)
	    shift
	    TAG="$1"
	    shift
	    ;;
	-m)
	    shift
	    HWMODE="$1"
	    shift
	    ;;
	--)
	    shift
	    break
	    ;;
    esac
done

if [ $# -eq 0 ]
then
    echo "No directory specified"
    usage
fi

DIR=$1

REPO=$(echo -n $(basename $DIR) | tr '[A-Z]' '[a-z]' | tr -sc '[a-z0-9]' '.')

cd $DIR

docker build $NOCACHE --build-arg HWMODE=$HWMODE --rm -t $REPO:$TAG .
