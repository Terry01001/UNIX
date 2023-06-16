#!/usr/bin/tcsh
set faces = ( 0 0 0 0 0 0 0 0 0 0 0 0 0 ) 
set suits = ( 0 0 0 0 )
set elements = ( ♦ ♥ ♠ ♣ )
foreach i( 0 10 26 36 39 )
    @ Suit = 1 + $i / 13
    @ Face = 1 + $i % 13
    echo -n \  `echo  $Face | grep '1[0-3]' | cut --complement -c1 | tr "0-3" "JQKA" || expr $Face + 1`$elements[$Suit]
    @ faces[$Face] = 1 + $faces[$Face]
    @ suits[$Suit] = 1 + $suits[$Suit]
end
echo -n ": "
switch ( `echo $faces | tr " " "\n" | sort -rg | tr -d "0\n"` )
    case 41:
        echo Four of a kind! ;breaksw
    case 32:
        echo Full house! ;breaksw
    case 311:
        echo Three of a kind! ;breaksw
    case 221:
        echo Two pair! ;breaksw
    case 2111:
        echo One pair! ;breaksw
    case 11111:
        
        set flush = ""
        if ( $suits[$Suit] == 5 ) set flush = \ Flush!
        if ( `echo $faces`  =~ '*1 1 1 1 1*' ) then
            echo Straight$flush!
        else if ( `echo $faces[13] $faces[1] $faces[2] $faces[3] $faces[4]`  == '1 1 1 1 1' ) then
            echo Straight$flush!
        else if ( $flush != "" ) then
	        echo Flush!
        else
            foreach facevalue ( `seq 13 -1 1` )
                if ( `echo $faces[$facevalue]` == '1' ) then
                    switch ( `echo  $facevalue` )
                        case 13:
                            echo Ace high!    ;exit
                        case 12:
                            echo King high!   ;exit
                        case 11:
                            echo Queen high!  ;exit
                        case 10:
                            echo Jack high!   ;exit
                        case 9:
                            echo "10 high!"   ;exit
                        case 8:
                            echo "9 high!"    ;exit
                        case 7:
                            echo "8 high!"    ;exit
                        case 6:
                            echo "7 high!"    ;exit
                        case 5:
                            echo "6 high!"    ;exit
                        case 4:
                            echo "5 high!"    ;exit
                        case 3:
                            echo "4 high!"    ;exit
                        case 2:
                            echo "3 high!"    ;exit
                        case 1:
                            echo "2 high!"    ;exit
                    endsw
		        endif
	        end
	    endif
endsw
