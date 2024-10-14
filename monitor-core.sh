#!/bin/bash


monitor_stellar_core() {
        STATUS=$(curl -s http://localhost:11626/info | grep state | awk -F': ' '{print $2}' | sed 's/"//g' | sed 's/!//g')
        LAST_CHECK_LEDGER=$(curl -s http://localhost:11626/info | grep last_check_ledger | awk -F': ' '{print $2}' | sed 's/"//g' | sed 's/,//g')

        echo -e "\n$(date)"
        echo -e "\tHostname: $HOSTNAME"
        echo -e "\tStatus: $STATUS"
        echo -e "\tLast Check Ledger: $LAST_CHECK_LEDGER"

        DDTAGS="env:production,service:stellar-core,host:$HOSTNAME,status:$STATUS"

        curl -X POST "https://http-intake.logs.datadoghq.com/v1/input/${DD_API_KEY}" \
                -H "Content-Type: application/json" \
                -d '{
                        "message": "'"${LAST_CHECK_LEDGER}"'",
                        "ddtags": "'"${DDTAGS}"'",
                        "level": "'"info"'"
                }'

        echo "Log message sent."
        echo -e "\n"
}

while sleep 15; do monitor_stellar_core; done
