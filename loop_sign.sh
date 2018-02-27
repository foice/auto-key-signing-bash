#!/usr/bin/env bash
sent='sent'

while read p; do
  echo "processing $p"
  if [ $(cat "$sent" | grep "$p" | wc -l)  -eq 0 ]; then
    ./auto_sign.sh "$p"
    echo "$p" >> "$sent"
  else
    echo "$p has already been processed"
  fi
done < "$1"
