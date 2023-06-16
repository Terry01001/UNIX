#!/usr/bin/csh
@ f = _______ # Use seq, sort & head to create a random number between 1 and 13

./topface $f
switch ( $1 )
   case "[Rr]*":
      cat allcards | sort -R | sed ______ # prints first 5 lines
      exit
   case "[Ff]*":
      @ suit = ___ #Use seq, sort & head to randomly choose from 1, 14, 27 & 40

      #Now, the value of "suit" is the line number of "allcards" on which one
      #suit begins. And the next 12 lines of "allcards" will also be that suit.

      cat allcards | sed -n ______ | sort -R | sed 5q
      #The above _____ is a sed program to select the 13 lines of the "suit".
      #This must be achieved using expr, and using sed's "," range operator.
      exit
   case "[Ss]*":
      @ f = ___ # Use seq, sort & head to create a random number from 1 and 8
      set h
      foreach i ( `seq 0 4`)
         @ suit = __________ # This is the same as the earlier "@ suit =" line. 
         set h = ( $h ____ ) # Add next card to the straight, using above suit. 
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

# The first 5 lines of the "nums" file represent line numbers in the "allcards"
# file. The following ________ will produce a sed program to print those lines.
sed -n `head -5 nums|sed _______________________________` allcards

rm nums
