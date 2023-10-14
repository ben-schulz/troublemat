#!/bin/bash

# watch the file at TARGET_PATH for changes,
# and open it in a new Firefox browser window on change.
#
# close any windows previously opened this way.
#
# note: this only works cleanly if Firefox
# is not already running.


echo $1

if [[ -z $1 ]]; then
  echo -e "usage:\n"
  echo -e "\tbash watch.sh PATH"
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

TARGET_PATH=$(realpath $1)

LAST_BROWSER_PID=0

while $(test 1); do

    T=$(inotifywait --event modify --event attrib --format '%e' $TARGET_PATH) && \
    sleep 1.0

    if [[ 0 -ne $LAST_BROWSER_PID ]]; then
        kill -s SIGHUP $LAST_BROWSER_PID
    fi

    firefox "file:///${TARGET_PATH}" &
    LAST_BROWSER_PID=$!
    sleep 1.0

done
