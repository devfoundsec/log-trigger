#!/usr/bin/env bash
#-------------
# Its free and open source at SCORPIONSEC
# for issue and support github.com/SCORP1ON-TEAM/log-trigger/issues

# Resolve directories
here=`dirname "$0"`
cd "$here"

# Make env.
[ ! -e /tmp/log-*.log ] && export tmp_log="$(mktemp /tmp/log-XXXXXX.log)" || export tmp_log="$(ls /tmp/log-*.log)"
origin_log="$1"

# Run Check and trigger
export buff="$(tail -n $(grep -v -f $tmp_log $origin_log | wc -l) $origin_log)"
if [ "$buff" != "" ]
then 
    bash ./run.sh "$buff"
    cp -f "$origin_log" "$tmp_log"
fi

unset -v $buff $origin_log $here $tmp_log
