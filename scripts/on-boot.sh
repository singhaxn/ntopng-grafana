#!/bin/sh

{
    cd "$(dirname $0)/.."
    
    retry=10
    fail=1
    while [ $retry -gt 0 -a $fail -ne 0 ]; do
        # Wait for docker to start
        docker ps
        fail=$?
        retry=$(( $retry - 1 ))
        if [ $fail -ne 0 ]; then
            echo "docker is not ready. Retrying in 5 sec. $retry attempts remaining..."
            sleep 5
        fi
    done
    
    if [ $fail -eq 0 ]; then
        docker compose down
        docker compose up -d
    else
        echo "script timed out!"
    fi
} 2>&1 | logger -s -t "on-boot"
