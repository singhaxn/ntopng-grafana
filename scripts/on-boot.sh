#!/bin/sh

N_RETRY=10
# OS=$( cat /etc/*-release | grep -e ^ID= | cut -d "=" -f 2 )
COMPOSE_FILE=${1:-docker-compose.yml}

{
    cd "$(dirname $0)/.."
    
    retry=$N_RETRY
    fail=1
    while [ $retry -gt 0 -a $fail -ne 0 ]; do
        # Wait for docker to start
        if [ $retry -lt $N_RETRY ]; then
            echo "docker is not ready. Retrying in 5 sec. $retry attempts remaining..."
            sleep 5
        fi
        
        docker ps
        fail=$?
        retry=$(( $retry - 1 ))
    done
    
    if [ $fail -eq 0 ]; then
        echo "Using compose file: $COMPOSE_FILE"
        docker compose -f "$COMPOSE_FILE" down
        docker compose -f "$COMPOSE_FILE" up -d
    else
        echo "script timed out!"
    fi
} 2>&1 | logger -s -t "on-boot"
