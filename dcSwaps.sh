#!/bin/sh -f


# usage options
usage='dcSwaps.sh ttFile swapFile newttFile'
if ! [ $# -eq "3" ]
then
    echo $usage
    exit
fi

ttab=$1
swap=$2
tnew=$3

# if output file already exists then quit
if [ -e $tnew ] ; then echo $tnew already exist; exit 1; fi

echo Implementing swaps from file $swap in translation table $ttab
echo

# reading swap file
echo Reading swap file $swap
i=0 
#secSwap1()
while read -a line
do
    sectSwap1[$i]=${line[0]}
    layrSwap1[$i]=${line[1]}
    wireSwap1[$i]=${line[2]}
    sectSwap2[$i]=${line[3]}
    layrSwap2[$i]=${line[4]}
    wireSwap2[$i]=${line[5]}
    echo ${sectSwap1[$i]} ${layrSwap1[$i]} ${wireSwap1[$i]} ${sectSwap2[$i]} ${layrSwap2[$i]} ${wireSwap2[$i]}
    i=`expr "$i" + 1`
done < $swap
echo Read swap file: found ${#sectSwap1[@]} swaps
echo

# read translation table
echo Reading translation table $ttab
i=0
while read -a line
do
    crate[$i]=${line[0]}
    slot[$i]=${line[1]}
    chan[$i]=${line[2]}
    sect[$i]=${line[3]}
    layr[$i]=${line[4]}
    wire[$i]=${line[5]}
    orde[$i]=${line[6]}
    sectSwap[$i]=${line[3]}
    layrSwap[$i]=${line[4]}
    wireSwap[$i]=${line[5]}
    if [ `expr $i % 1000` -eq 0 ]
    then
        echo Read $i lines
    fi
#    if [ ${sect[$i]} == ${sectSwap[$i]} ] && [ ${layr[$i]} == ${layrSwap[$i]} ] && [ ${wire[$i]} == ${wireSwap[$i]} ]
#    then
#       echo ${crate[$i]} ${slot[$i]} ${chan[$i]} ${sect[$i]} ${layr[$i]} ${wire[$i]}
#    fi
    i=`expr "$i" + 1`
done < $ttab
echo Read translation table file: found ${#sect[@]} channels
echo

# loop through swaps and find them in the translation table
echo Searching swaps...
i=0
while [ $i -lt ${#sectSwap1[@]} ]
do
    j=0
    while [ $j -lt ${#crate[@]} ]
    do
        if [ ${sect[$j]} == ${sectSwap1[$i]} ] && [ ${layr[$j]} == ${layrSwap1[$i]} ] && [ ${wire[$j]} == ${wireSwap1[$i]} ]
        then
            echo Found swap n. $i : ${sectSwap1[$i]} ${layrSwap1[$i]} ${wireSwap1[$i]} ${sectSwap2[$i]} ${layrSwap2[$i]} ${wireSwap2[$i]}
            sectSwap[$j]=${sectSwap2[$i]}
            layrSwap[$j]=${layrSwap2[$i]}
            wireSwap[$j]=${wireSwap2[$i]}
#            orde[$j]=1
            echo Changing ${crate[$j]} ${slot[$j]} ${chan[$j]} ${sect[$j]} ${layr[$j]} ${wire[$j]} to ${crate[$j]} ${slot[$j]} ${chan[$j]} ${sectSwap[$j]} ${layrSwap[$j]} ${wireSwap[$j]}
            break
        fi
        j=`expr "$j" + 1`
    done
    i=`expr "$i" + 1`
done
echo
           
# write out new translation table
echo Writing new table to $tnew
i=0
while [ $i -lt ${#crate[@]} ] 
do
    if [ $i -eq 0 ]
    then
        echo ${crate[$i]} ${slot[$i]} ${chan[$i]} ${sectSwap[$i]} ${layrSwap[$i]} ${wireSwap[$i]} ${orde[$i]} > $tnew
    else
        echo ${crate[$i]} ${slot[$i]} ${chan[$i]} ${sectSwap[$i]} ${layrSwap[$i]} ${wireSwap[$i]} ${orde[$i]} >> $tnew
    fi
    if [ `expr $i % 1000` -eq 0 ]
    then
        echo Write $i lines
    fi
    i=`expr "$i" + 1`
done
echo Done writing $i lines!
