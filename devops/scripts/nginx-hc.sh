#!/bin/bash

res=$(service nginx status | grep running)

if [[ "${res}" != "" ]]; then
   echo "Nginx online"
   exit 0
else
   echo "Nginx failed"
   exit 2
fi
