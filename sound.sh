#!/bin/bash

#########################################################################
#                                                   
#   Script to print on display the audio's bar level when it is                             
#   modified. This script needs the following components to run                       
#   correctly:                                             
#      1- amixer - to set audio's level                              
#      2- xosd - to print the bar on display                           
#                                                   
#   This script recives only one parameter on input, with one of      
#   these three fixed values:                        
#      1- up - to increase audio's level                  
#      2- down - to decrease audio's level               
#      3- mute - to enable/diseable audio               
#                                       
#   I hope it will be useful to you ! Contact me if you need help ;)   
#            E-mail: m.zeuli@studenti.unina.it            
#                                       
#########################################################################

#Function to detect audio's level when it is incremented or decremented
function up_down_mode {
   local level=`echo "$1" | egrep -o '([[:digit:]]{1,3}%)?' | sed 's/%//'`
   print $level
}

#Function to detect if audio has been activated or deactivated
function mute_unmute_mode {
   echo "$1" | grep off
   local mute=$?
   
   if [ $mute == 0 ]; then
      print 0
   else
      local level=`echo $1 | egrep -o '([[:digit:]]{1,3}%)?' | sed -e 's/%//' -e 's/ .*//'`
      print $level
   fi
}

#Function to print on display the audio's bar level
function print {
   local index="$1"
   index=`expr $index / 10`
   
   #You should change these following line to change the bar's color
   if [ $index -eq 0 ]; then  
      local color="red"      #Audio is diseable
   else
      local color="orange"   #Audio is enable
   fi
   
   #Building the audio's bar
   local audioBar='['
   for n in `seq 1 $index`
   do
      audioBar=$audioBar'='
   done

   index=`expr $index + 1`
   for n in `seq $index 10`
   do
      audioBar=$audioBar' '
   done

   audioBar=$audioBar']'
   echo "Volume: $audioBar" | osd_cat -p top -o 22 -A right -c $color -d 5 &
}

#Argument's number control
if [ $# != 1 ]; then
   echo "Argument number incorrect, only one parameter is needed"
   return 1
fi

#Kill the previews notification
killall osd_cat &> /dev/null 

mode=$1
case $mode in
   #You should change these following lines to set your audio's preferences
   up)         
     sound=`amixer sset Master 5%+ unmute` 
     up_down_mode "$sound"
   ;;
   down)
     sound=`amixer sset Master 5%-`
     up_down_mode "$sound"
   ;;
   mute)
     sound=`amixer sset Master toggle`
     mute_unmute_mode "$sound"
   ;;
   *)
     echo "Wrong parameter value !"
     echo "Possible values are: up, down, mute"
     return 1
   ;;
esac

return 0
