#!/bin/bash

a=$1
if [a>=18]; then
    echo "You are $a years old, eligible to cast a vote"
else
    echo "You are not eligible to cast a vote"
fi
