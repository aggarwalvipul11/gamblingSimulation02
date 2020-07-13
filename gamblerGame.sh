#!/bin/bash

# Welcome Message
echo "Welcome to the world of Gambling."

declare -A gamblerPaidPerDay

# Declare variables and assign values. 
stakeMoneyPerDay=100;
betMoneyPerGame=1;
stakePercent=$(($((stakeMoneyPerDay/100))*50));
maxMoneyWinPerDay=$((stakeMoneyPerDay+stakePercent));
minMoneyLostPerDay=$((stakeMoneyPerDay-stakePercent));
totalDaysInAMonth=30;
totalStakeAmount=$((stakeMoneyPerDay*totalDaysInAMonth));
moneyEarns=$((stakeMoneyPerDay));
exactMoneyEarn=0;
countProfitDays=0;
countLossDays=0;
findValue=0;
totalMoneyWinsInMonth=0;
totalMoneyLostInMonth=0;

# Gambler plays for 1 Month. 
for (( daysCount=1;daysCount<=$totalDaysInAMonth;daysCount++ ))
do
	while [[ $moneyEarns -lt $maxMoneyWinPerDay && $moneyEarns -gt $minMoneyLostPerDay ]]
	do
		gameResult=$(($RANDOM%2));

		if [[ $gameResult -eq 1 ]]
		then
			((moneyEarns++));
		else
			((moneyEarns--));
		fi
	done
        if [[ $moneyEarns -eq $maxMoneyWinPerDay ]]
        then    
            ((countProfitDays++));
            totalMoneyWinsInMonth=$(($totalMoneyWinsInMonth+$moneyEarns));
        elif [[ $moneyEarns -eq $minMoneyLostPerDay ]]
        then
            ((countLossDays++));
            totalMoneyLostInMonth=$(($totalMoneyLostInMonth+$moneyEarns));
        else
            echo "No Loss No Profit!"
        fi                        
	gamblerPaidPerDay[daysCount]=$((moneyEarns));
	exactMoneyEarn=$(($exactMoneyEarn+$moneyEarns));    
	moneyEarns=$((stakeMoneyPerDay));
done

if [[ $exactMoneyEarn -gt $totalStakeAmount ]]
then

    echo "At End of Month, Gambler Wins $countProfitDays Days and $totalMoneyWinsInMonth Dollar."
elif [[ $exactMoneyEarn -lt $totalStakeAmount ]]
then
    echo "At End of Month, Gambler Lost $countLossDays Days and $totalMoneyLostInMonth Dollar."
else
    echo "Gambler has Neither Won Nor Lost."
fi

#End of UseCase 05
