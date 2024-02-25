#!/bin/bash

mContainerName=pawtaldevdb
mVolumeName=pawtaldevdbvolume

docker stop $mContainerName 2> /dev/null || :
docker remove $mContainerName 2> /dev/null || :
docker volume rm ${mVolumeName} 2> /dev/null || :
