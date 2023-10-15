#!/bin/bash

# watch files at the specified paths,
# and reload the test window on change,
# by closing the previous window
# and opening a new one.
#
# note: this only works cleanly if Firefox
# is not already running.


if [[ -z $1 ]]; then
  echo -e "usage:\n"
  echo -e "\tbash watch-tests.sh FILEPATH [...]"
  echo -e "\nspecify a path to watch."
  exit 0
fi

if [[ -z $(which inotifywait) ]]; then
  echo 'cannot watch; you do not seem to have `inotifywait` installed.'
  exit 0
fi


if [[ -z $(which firefox) ]]; then
  echo 'cannot watch; you do not seem to have `firefox` installed.'
  exit 0
fi

ARGS=( "${@}" )
TARGET_PATHS[0]=$(realpath $1)
for ARG in "${ARGS[@]:1}"
do
    TARGET_PATH=$(realpath $ARG)
    TARGET_PATHS="${TARGET_PATHS} ${TARGET_PATH}"
done

for TARGET_PATH in $TARGET_PATHS
do
    echo "watching: $TARGET_PATH"
done

LAST_BROWSER_PID=0

while $(test 1); do

    T=$(inotifywait --event modify --event attrib --format '%e' ${TARGET_PATHS}) && \
    sleep 1.0

    if [[ 0 -ne $LAST_BROWSER_PID ]]; then
        kill -s SIGHUP $LAST_BROWSER_PID
    fi

    firefox "file:///${PWD}/tests/test-results.html" &
    LAST_BROWSER_PID=$!
    sleep 1.0

done
