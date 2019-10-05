#!/bin/bash

# ./dock workspace - exec bash into workspace
# ./dock up - start all containers
# ./dock down - stop all containers
# ./dock kill - destroy all containers
# ./dock build service - build container by name

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ $1 == "workspace" ]
then
    docker-compose exec --user=laradock workspace bash
fi

if [ $1 == "logs" ]
then
    docker-compose logs $2
fi

if [ $1 == "tail" ]
then
    docker-compose logs -f $2
fi

if [ $1 == "build" ]
then
    docker-compose build $2
fi

if [ $1 == "up" ]
then
    docker-compose up -d nginx mysql redis workspace 
fi

if [ $1 == "down" ]
then
    docker-compose stop
    docker stop $(docker ps -aq)
    docker rm $(docker ps -aq)
fi

if [ $1 == "kill" ]
then
    docker system prune -a
fi
