#!/bin/bash

# Welcome Message
echo "Welcome to the world of Gambling."

declare -a gamblerPaidPerDay
declare -a luckiestDay
declare -a unluckiestDay

# Declare variables and assign values. 
stakeMoneyPerDay=100;
betMoneyPerGame=1;
totalDaysInMonth=30;
tranferStakeMoneyPerDay=0;
finalMoneyInMonth=0;
newStakeMoneyPerDay=0;
tempWin=0;
tempLost=0;
winPerDay=0;
lostPerDay=0;
dayCountWin=0;
dayCountLost=0;

totalStakeAmount=$((stakeMoneyPerDay*totalDaysInMonth));
moneyEarns=$((stakeMoneyPerDay));
exactMoneyEarn=0;

# Gambler plays for 20 Days. 
for (( daysCount=1;daysCount<=$totalDaysInMonth;daysCount++ ))
do
    tranferStakeMoneyPerDay=$(($newStakeMoneyPerDay+$stakeMoneyPerDay));
    stakeGamePercent=$(($tranferStakeMoneyPerDay/2));
    maxMoneyWinPerDay=$((tranferStakeMoneyPerDay+stakeGamePercent));
    minMoneyLostPerDay=$((tranferStakeMoneyPerDay-stakeGamePercent));
	
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

    if [[ $tranferStakeMoneyPerDay -lt $moneyEarns ]]
    then
        winsMoney=$(($moneyEarns-$tranferStakeMoneyPerDay))
        #echo "Start: $tranferStakeMoneyPerDay You won on Day"$daysCount $winsMoney "End: $moneyEarns"
        if [[ $winsMoney -gt $tempWin ]]
        then
            tempWin=$(($winsMoney))
            winPerDay=$(($daysCount))
        fi
    else
        lostMoney=$(($tranferStakeMoneyPerDay-$moneyEarns))
        #echo "Start: $tranferStakeMoneyPerDay You lost on Day"$daysCount $lostMoney "End: $moneyEarns"
        if [[ $lostMoney -gt $tempLost ]]
        then
            tempLost=$(($lostMoney))
            lostPerDay=$(($daysCount))
        fi
    fi
    newStakeMoneyPerDay=$((moneyEarns));
done

echo "Gambler luckiest $winPerDay Days are in a month."
echo "Gambler Unluckiest $lostPerDay Days are in a month."

#End with UC6
