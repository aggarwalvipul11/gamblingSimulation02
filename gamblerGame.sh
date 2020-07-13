#!/bin/bash -x

# Welcome Message
echo "Welcome to the world of Gambling."

declare -A gamblerPaidPerDay

# Declare variables and assign values. 
resetValues() {
    stakeMoneyPerDay=100;
    betMoneyPerGame=1;
    totalDaysPlayed=20;
    maxMoneyWinPerDay=150;
    minMoneyLostPerDay=50;
    totalDaysInAMonth=30;
    totalStakeAmount=$((stakeMoneyPerDay*totalDaysInAMonth));
    moneyEarns=$((stakeMoneyPerDay));
    exactMoneyEarn=0;
    countProfitDays=0;
    countLossDays=0;
    findValue=0;
    totalMoneyWinsInMonth=0;
    totalMoneyLostInMonth=0;
}
# Gambler plays for 20 Days. 
daysCountInMonth() {
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
}

monthCheck=1;

while [[ $monthCheck -le 12 ]]
do
    resetValues
    daysCountInMonth    
    if [[ $exactMoneyEarn -gt $totalStakeAmount ]]
    then
        echo "At end of $monthCheck month, Gambler Wins $countProfitDays Days and continues to play next month :)"
        resetValues
        daysCountInMonth
    else
        echo "At end of $monthCheck month, Gambler Lost $countLossDays Days and eliminate from Gambling :("
        break;
    fi
    ((monthCheck++))
done

#End of UseCase 07
