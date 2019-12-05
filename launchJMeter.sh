#!/bin/sh
jmeter -n -t ./test-plan.jmx -JnbThreads=30 -Jduration=300 -JrampUp=150 -JBuildNumber="$1" -JhostUrl=localhost -JhostPort=1337
