#!/bin/bash
#greps the requested time from the requested date, the second grep filters this to AM or PM, then prints the time and the firstname/surname from roulette column
egrep $2 $1_Dealer_schedule | grep $3 | awk -F" " '{print $1" "$2" : "$5" "$6}' >> Dealers_working_during_losses
