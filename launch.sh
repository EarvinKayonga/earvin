#!/bin/bash
echo "Launching the server";
forever --minUptime 2000 --spinSleepTime 2000 -al access.log -o out.log -e err.log start server.js
