#!/bin/bash
resp=$(curl -LI -X GET $1 -o /dev/null -w '%{http_code}\n' -s)

  if [[ "$resp" -eq "200" ]]; then
    echo "Service successfuly registered and live!"
    exit 0
  else
    echo "Service not responce!"
    exit 1
  fi
