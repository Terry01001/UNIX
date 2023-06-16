#!/usr/bin/csh
@ f = `seq 1 13 | sort -R | head -1` 

./topface $f
switch ( $1 )
    case "[Rr]*":
        cat allcards | sort -R | sed '6,$ d' 
        exit
    case "[Ff]*":
        @ suit = `seq 1 13 40 | sort -R | head -1` 

        cat allcards | sed -n `expr $suit`,`expr $suit + 12`p | sort -R | sed 5q
        exit
    case "[Ss]*":
        @ f = `seq 8 | sort -R | head -1` 
        set h
        foreach i ( `seq 0 4`)
        @ suit = `seq 1 13 40 | sort -R | head -1`  
            set h = ( $h `expr $f + $i + $suit` ) 
        end
        echo $h | tr " " "\n" | sort -R > nums
        breaksw
    case "4*":
        cat topdeck | sed 5q > nums
        breaksw
    case "3*":
        cat topdeck | sed 1d\;6q > nums
        breaksw
    case "2*":
        cat topdeck | sed 3,7\!d > nums
        breaksw
    case "1*":
        cat topdeck | sed 1,3d > nums
        breaksw
    case "[Hh]*":
        cat topdeck | sed -n 3p > nums
    case "[Pp]*":
        cat topdeck | sed 2q >> nums
        @ f2 = `cat topdeck | sed 5\!\d | xargs expr 0 - 1 +` % 13 + 1
        ./topface $f2
        cat topdeck | sed 2q >> nums
        @ f3 = `cat topdeck | sed 5\!\d | xargs expr 0 - 1 +` % 13 + 1
        if ( $f3 != $f ) cat topdeck | sed 5\!d >> nums
        if ( $f3 == $f ) cat topdeck | sed 6\!d >> nums
        breaksw
    default:
        echo "This program is meant to receive one argument:"
        echo '  (R) Random'
        echo '  (F) Flush'
        echo '  (S) Straight'
        echo '  (H) Full House'
        echo '  (P) Two Pair'
        echo '  (4) Four of a kind'
        echo '  (3) Three of a kind'
        echo '  (2) Two of a kind (ie, 1 pair)'
        echo '  (1) "One" of a kind (ie, no matching cards)'
        echo
        exit
endsw

sed -n `head -5 nums|sed 'N;N;N;N;s/\n/p;/g;s/$/p/'` allcards   

rm nums
