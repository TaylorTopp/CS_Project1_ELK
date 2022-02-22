#!/bin/bash
#variables entered when running command
echo 'Please enter date (format = MMDD), time (format XX AM/PM)' 
#requests user to enter game (case sensitive)
echo 'Enter a game (choose from BlackJack, Roulette, Texas): '
read VAR

#assigns numbers to the game chosen based on columns from dealer files
if [ "$VAR" = "BlackJack" ];
 then
   gamecode1=3 gamecode2=4
elif [ "$VAR" = "Roulette" ];
 then
   gamecode1=5 gamecode2=6
elif [ "$VAR" = "Texas" ];
 then
   gamecode1=7 gamecode2=8
else
   echo "Incorrect game type selected"
fi

#grep the time requested in the date of the file requested, then filters to AM/PM via 2nd grep, then uses numbers assigned in if statement to print the dealer of the game requested
grep $2 $1_Dealer_schedule | grep $3 | awk -F" " -v gc1=$gamecode1 -v gc2=$gamecode2 '{print $gc1, $gc2}'
