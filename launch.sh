#!/bin/bash
echo "Launching the server";
forever -l access.log -o out.log -e err.log --minUptime 2000 --spinSleepTime 2000 start server.js
