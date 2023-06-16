#!/usr/bin/tcsh
cd $argv[1]
ls ?? | xargs -l fgrep ../allcards -e | cut --complement -c1-2
ls ?H |& fgrep -v : | wc -l > ___tempfile1
ls ?C |& fgrep -v : | wc -l >> ___tempfile1
ls ?D |& fgrep -v : | wc -l >> ___tempfile1
ls ?S |& fgrep -v : | wc -l >> ___tempfile1
fgrep 5 ___tempfile1 > ___tempfile2 && echo Flush!  
ls [2-9]?  |&  xargs -l fgrep ../allcards -e  |&  fgrep -v : | cut -c1  >  faces   
ls [T,J,Q,K,A]? |& xargs -l fgrep ../allcards -e |& fgrep -v : | cat -n | cut --complement -c 6-7,9- | tr " TJQKA" "10-4" | cut --complement -c1-4  >> faces
sort -sg faces | uniq -c | cut -c7 > facecounts 
expr `wc -l < facecounts` == 4 > ___tempfile2 && echo One pair! 
expr `wc -l < facecounts` == 3 > ___tempfile2 && fgrep 2 facecounts >> ___tempfile2 && echo Two pair!
expr `wc -l < facecounts` == 3 > ___tempfile2 && fgrep 3 facecounts >> ___tempfile2 && echo Three of a kind! 
expr `wc -l < facecounts` == 2 > ___tempfile2 && fgrep 4 facecounts >> ___tempfile2 && echo Four of a kind!
expr `wc -l < facecounts` == 2 > ___tempfile2 && fgrep 3 facecounts >> ___tempfile2 && echo Full house!
expr `wc -l < facecounts` == 5 > ___tempfile2 && expr `sort -sg faces | tail -1` - `sort -sg faces | head -1` == 4 >> ___tempfile2 && echo Straight!
expr `wc -l < facecounts` == 5 > ___tempfile2 && expr `sort -sg faces | tail -1` == 14 >> ___tempfile2 && expr `sort -sg faces | head -1` == 2 >> ___tempfile2 && expr `sort -sg faces | head -4 | tail -1` == 5 >> ___tempfile2 && echo Straight! 

