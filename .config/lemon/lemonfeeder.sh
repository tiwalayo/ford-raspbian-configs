#!/bin/sh

TABB='      '
clock() {
    date +%H:%M:%S
}

geteth() {
    var=$(echo $(ifconfig eth0 | grep 'inet ') | awk '{print $2;}')
    echo "E: $var"
}

freespace(){
    myS=$(df -k / | tail -1 | awk '{print $4}')
    myW=$(echo "scale=2 ; $myS / 1000" | bc)
    echo "$myW MB"
}

getip(){
    echo "extIP: $(curl -s http://whatismyip.akamai.com)"
}

temp(){
    var=$(/opt/vc/bin/vcgencmd measure_temp)
    echo "${var#temp=}"
}

gitHelpMessage(){
    #Comment the following line to remove the link to my github which has documentation & support for the rice configs
    echo "github.com/tiwalayo/ford-rc"
    #Alternatively, just delete "$(gitHelpMessage)${TABB}" from the BAR_INPUT line to remove this function from the lemonbar
}

while true; do
    BAR_INPUT="$(gitHelpMessage)${TABB}$(freespace)${TABB}$(temp)${TABB}$(geteth)${TABB}$(getip)${TABB}$(clock)${TABB}"
    echo "%{r}%{F#2B84BB} $BAR_INPUT"
    sleep 1
done
