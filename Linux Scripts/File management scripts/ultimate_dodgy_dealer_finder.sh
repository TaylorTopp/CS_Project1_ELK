#!/bin/bash
#requests user to enter date they want to investigate
echo 'Please enter date (format = MMDD)' 

read date

#requests game the user wants to investigate
echo 'Enter a game (choose from BlackJack, Roulette, Texas): '

read game

#transforms game enters to all lowercase
game=$(echo $game | tr [:upper:] [:lower:])

#assigns numbers corresponding to column of the game
if [ "$game" = "blackjack" ];
 then
   gamecode1=3 gamecode2=4
elif [ "$game" = "roulette" ];
 then
   gamecode1=5 gamecode2=6
elif [ "$game" = "texas" ];
 then
   gamecode1=7 gamecode2=8
else
   echo "Incorrect game type selected"
fi

#finds losses in the player analysis file of the date selected
grep -- - /home/sysadmin/CS_HW/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Analysis/${date}_win_loss_player_data | awk -F" " '{print $1,$2}' | sed s/[^0-9]*\(0-9.*\)// > temp.txt

#assigns a variable to the number of lines of losses
n=$(wc -l temp.txt)
echo $n > temp2.txt
n=$(awk -F " " '{print $1}' temp2.txt)

#loop to read times from temp.txt (times where losses occured)
i=1
until [ $i -gt $n ]
  do
   VAR1="$(awk -F" " -v i=$i 'NR==i{print $1}' temp.txt)"
   VAR2="$(awk -F" " -v i=$i 'NR==i{print $2}' temp.txt)"
      i=$(($i + 1))

#outputs the dealer on the selected date and game
grep $VAR1 /home/sysadmin/CS_HW/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis/${date}_Dealer_schedule | grep $VAR2 | awk -F" " -v gc1=$gamecode1 -v gc2=$gamecode2 '{print $1" "$2" : "$gc1" "$gc2}';

done

#cleanup
rm temp.txt
rm temp2.txt
