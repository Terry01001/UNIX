#!/usr/bin/sed -nf

s/\([2-9TJQKA][DHSC]\)\(.*\)/\2\n\1/;P
s/.*\n\([2-9TJQKA][DHSC]\)/\1/
H


g

:J;tJ 


s/\n[2-9TJQKA]\([DHSC]\)\(\n[2-9TJQKA]\1\)\{4\}/Flush/p


s/\n[2-9TJQKA][DHSC]\n\([2-9TJQKA]\)[DHSC]\(\n\1[DHSC]\)\{3\}/Four of a kind/p

s/\n\([2-9TJQKA]\)[DHSC]\(\n\1[DHSC]\)\{3\}\n[2-9TJQKA][DHSC]/Four of a kind/p

# -------------------------------------------------------------------------

$ !d


bX
:quit;q
:X; tquit


y/\n/ /
s/[ DHSC]//g


/.*\([2-9TJQKA]\)\1\{2\}.*/  !bY

   /\([2-9TJQKA]\)\1.\([2-9TJQKA]\)\2/ cFull house

   /\([2-9TJQKA]\)\1.\([2-9TJQKA]\)\2/ !cThree of a kind

:Y


/.*\([2-9TJQKA]\)\1.*/  !bZ

   /.*\([2-9TJQKA]\)\1.*\([2-9TJQKA]\)\2.*/ cTwo pair

   /.*\([2-9TJQKA]\)\1.*\([2-9TJQKA]\)\2.*/ !cOne pair

:Z


s/.*/&_23456789T/


/\(\([2-9T]\)\{5\}\)_.*\1.*/ cStraight


/2345A.*/ cStraight


/[9A]JKQT.*/ cStraight


/89JQT.*/ cStraight


/789JT.*/ cStraight


cNothing

