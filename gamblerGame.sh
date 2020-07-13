#!/bin/bash

# Welcome Message
echo "Welcome to the world of Gambling."

declare -A gamblerPaidPerDay

# Declare variables and assign values. 
stakeMoneyPerDay=100;
betMoneyPerGame=1;
totalDaysPlayed=20;
stakePercent=$(($((stakeMoneyPerDay/100))*50));
maxMoneyWinPerDay=$((stakeMoneyPerDay+stakePercent));
minMoneyLostPerDay=$((stakeMoneyPerDay-stakePercent));

totalStakeAmount=$((stakeMoneyPerDay*totalDaysPlayed));
moneyEarns=$((stakeMoneyPerDay));
exactMoneyEarn=0;

# Gambler plays for 20 Days. 
for (( daysCount=1;daysCount<=$totalDaysPlayed;daysCount++ ))
do
	while [[ $moneyEarns -le $maxMoneyWinPerDay && $moneyEarns -ge $minMoneyLostPerDay ]]
	do
		gameResult=$(($RANDOM%2));

		if [[ $gameResult -eq 1 ]]
		then
			((moneyEarns++));
		else
			((moneyEarns--));
		fi
	done
	gamblerPaidPerDay[daysCount]=$((moneyEarns));
	exactMoneyEarn=$(($exactMoneyEarn+$moneyEarns));
	moneyEarns=$((stakeMoneyPerDay));
done

echo "After 20 days, Total Amount Gambler Earns: $exactMoneyEarn"

if [[ $exactMoneyEarn -gt $totalStakeAmount ]]
then
	moneyWins=`expr $exactMoneyEarn - $totalStakeAmount`
	echo "Gambler wins: $moneyWins"
elif [[ $exactMoneyEarn -lt $totalStakeAmount ]]
then
	moneyLost=`expr $totalStakeAmount - $exactMoneyEarn`
	echo "Gambler lost: $moneyLost"
else
	echo "Gambler has Neither Won Nor Lost."
fi

#End of UseCase 04
