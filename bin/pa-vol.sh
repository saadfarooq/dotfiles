#!/bin/bash
 
SINK_NAME="alsa_output.pci-0000_00_1b.0.analog-stereo"
VOL_STEP="0x01000"
 
VOL_NOW=`pacmd dump | grep -P "^set-sink-volume $SINK_NAME\s+" | perl -p -i -e 's/.+\s(.x.+)$/$1/'`
 
case "$1" in
  plus)
  VOL_NEW=$((VOL_NOW + VOL_STEP))
  if [ $VOL_NEW -gt $((0x10000)) ]
  then
    VOL_NEW=$((0x10000))
  fi
  pactl set-sink-volume $SINK_NAME `printf "0x%X" $VOL_NEW`
  notify-send --icon=notification-audio-volume-high -u low --expire-time=300 "Volume Increased" "$(($VOL_NEW*100/65536))"
 
  ;;
  minus)
  VOL_NEW=$((VOL_NOW - VOL_STEP))
  if [ $(($VOL_NEW)) -lt $((0x00000)) ]
  then
    VOL_NEW=$((0x00000))
  fi
  pactl set-sink-volume $SINK_NAME `printf "0x%X" $VOL_NEW`
  notify-send --icon=notification-audio-volume-low -u low --expire-time=300 "Volume Decreased" "$(($VOL_NEW*100/65536))"
  ;;
  mute)
 
  MUTE_STATE=`pacmd dump | grep -P "^set-sink-mute $SINK_NAME\s+" | perl -p -i -e 's/.+\s(yes|no)$/$1/'`
  if [ $MUTE_STATE = no ]
  then
          pactl set-sink-mute $SINK_NAME 1
          notify-send --icon=notification-audio-volume-muted -u low --expire-time=300 "Volume Muted" "Where's the sound go?"
  elif [ $MUTE_STATE = yes ]
  then
    pactl set-sink-mute $SINK_NAME 0
    notify-send --icon=notification-audio-volume-off -u low --expire-time=300 "Volume Un-muted" "I can hear again"
  fi
esac