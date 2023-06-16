                           Unix System Programming
                          Programming Assignment #1

Due date: Friday, March 10, at 11:59pm

Submission requirements: You must submit exactly one file, named "flushtest".

Submission method: Through the cyberuniversity. See Lecture 3 for details.
                   Note: If you aren't registered for the course yet, then
                         email your code to me at: stevewhaga@yahoo.com
                   Note: After you submit, verify that it submitted correctly;
                         every year I get empty or garbled submissions.



                        - = - = - = - = - = - = - = - 
                      | Section 1.  A look at PA1.tar |
                        - = - = - = - = - = - = - = -

If you are reading this file, then you must have downloaded it from the cyber-
university website. And you must have seen the other file that was provided
in the same cyberuniversity post. That other file is named "PA1.tar". We will
learn in Lecture #3 that files named with a ".tar" are compressed directories.
Such files can be uncompressed with a unix command named "tar".

Now, on your computer, perform the following steps.
1. Copy the "PA1.tar" file into your unix home directory.
2. Then type this:
     % ls PA1.tar
     PA1.tar
     % tar -xf PA1.tar
     % cd PA1
     % ls
     REAMDE.txt allcards sample1  sample2  sample3  sample4  sample5  screen.png
     %

   As you can see above, the "PA1.tar" file has expanded to create a directory
   named PA1. That directory has the contents shown above. One of those is the
   "README.txt" file, which is a copy of the file you are currently reading.
   
   There is also a file named "screen.png". That is a screen snapshot of how
   your homework is meant to run. Let's now consider that file...

3. Open "screen.png" using a picture viewer. For example, if you are using
   cygwin inside of Windows, then you would open File Explorer, and would then
   navigate to C:\cygwin64(or maybe just cygwin)\home\(your account name)\PA1.
   Once in the right directory, you would click on the icon for the png file,
   and Windows will open it using appropriate software.
   
   Having opened the screenshot, take a moment to examine and understand it.
   Only continue reading this current file after you have done that.

   ...

   OK, so now you have taken the time to look at the screenshot, and you now
   know that your homework involves displaying cards and identifying whether
   your cards are all the same suit, which is called a "flush".

   As the screenshot also showed, there were 5 sample card hands. (A "hand" is
   a set of cards; in your homework, each hand will always have 5 cards.)
   I have provided 5 samples, but I can test other hands besides those samples.


   Now recall what we had typed above:
     % ls
     REAMDE.txt allcards sample1  sample2  sample3  sample4  sample5  screen.png
     %
     
   By this point, we have discussed README.txt and screen.png. Next, we will
   discuss "allcards".


4. Type the following:
     % head -3 allcards
     2D2♦
     3D3♦
     4D4♦
     % tail -3 allcards
     QCQ♣
     KCK♣
     ACA♣
     % head -23 allcards | tail -3
     9H9♥
     TH10♥
     JHJ♥
     % wc -l < allcards
     52
     %

   In your output, you probably see color, unlike the output I've shown above.
   (If you don't see color, and if your homework solution therefore has no
   color, that is OK. Now, if you output looks like "2D[01;31;107m[K2[m[K...",
   then that is a difference in how your UNIX displays color. That is also OK,
   because your code will still display correctly on my UNIX.)

   Now, the above output also shows that the "allcards" file has 52 lines,
   meaning that the each of the 52 cards found in a deck of cards gets a line.

   One special thing to note above is that the 10 of hearts reads as "TH10♥".
   So notice that the first character is "T" (Ten). This was done so that every
   card has a 2-character code. (Using the code "10H" would need 3 characters.)


   Now let's again recall what we had typed above:
     % ls
     REAMDE.txt allcards sample1  sample2  sample3  sample4  sample5  screen.png
     %

   At this point, we have talked about everything but the sample[1-5] listings.
   These ones are all subdirectories. So let's look at one of them now...


5. Type the following:
     % cd example5
     % ls
     3S  4D  4H  4S  QS
     % cat 3S
     % cat *
     %

   The cat commands you typed above prove that these 5 files are all empty.
   If they are empty, then what are they there for? The answer is that it is
   their filenames that matter. To understand this further, Let's see all of
   the sample[1-5] directories...


6. Type the following:
     % basename `pwd`
     example5
     % cd ..
     % ls *1; ls *2; ls *3; ls *4; ls *5
     2C  3C  5C  AC  TC
     3S  4S  AS  JS  KS
     2D  3C  5C  AC  TC
     3S  4S  5H  6S  7D
     3S  4D  4H  4S  QS
     %

   So we see that each of the directories contain 5 files, and each file has
   a two-letter name. In fact, referring back to "screen.png" These directories
   each indicate the five cards in a hand, with the first two directories
   having flushes.


   So we have now looked at everything provided in "PA1.tar". All that remains
   is to actually do the assignment. We will talk about that now...




           - = - = - = - = - = - = - = - = - = - = - = - = - = - = -
         | Section 2.  Some specific hints on some specific commands |
           - = - = - = - = - = - = - = - = - = - = - = - = - = - = -


You are restricted to only use commands and syntax from Lectures 1 and 2.

For some of the commands you will be using, a few hints are worth pointing out.

------
xargs: Note that lecture 2, Slide 140 indicates that -l is a useful xargs flag.
------
       So, what does the -l do? It runs each passed in-line separately.
       For example, compare the following two executions of xargs:
          % cd sample1
          % ls
          2C  3C  5C  AC  TC
          % ls | xargs echo ":)"
          :) 2C 3C 5C AC TC
          % ls | xargs -l echo ":)"
          :) 2C
          :) 3C
          :) 5C
          :) AC
          :) TC
          %

       In the first case, "xargs echo" executed one time. In the second case,
       "xargs -l echo" executed "echo" five separate times (once for each
       passed-in argument) -- and that is why you get five output lines, each
       with a ":)".
       
       Furthermore, notice that the ":)" went at the front of each output line.
       That is because xargs puts the passed-in value AT THE END of the next
       commands argument list. So, if you typed  "echo A | xargs echo B", then
       xargs will put the "A" at the end of echo's argument list, to create the
       command "echo B A". This is also discussed in lecture 2, slides 146-152.

      This is a behavior you will need in implementing Line #2 of flushtest.

------
fgrep: The hint I will point out here is that Lecture 1, slide 130 indicates
------ that -e is a useful flag for fgrep. Let's explain its use...

       To begin, we know that you can search for a string in a file:
         % cd PA1
         % fgrep 2D allcards
         2D2♦
         % fgrep 3D allcards
         3D3♦
         %
 
       But how do you search for either of two different strings? 
         % fgrep 2D 3D allcards
         grep: 3D: No such file or directory
         allcards:2D2♦
         %

      Well that didn't work. The right answer is to use -e:
         % fgrep -e 2D -e 3D allcards
         2D2♦
         3D3♦
         %

      OK. What you have just seen is the most common reason that people use
      the -e flag with fgrep. But this is not the reason that your solution
      to this homework will need the -e. You will use it to allow the string
      to be the final argument to fgrep.

      Consider that, ordinarily, the filename to search must be last argument:
         % fgrep 2D allcards
         2D2♦
         % fgrep allcards 2D
         grep: 2D: No such file or directory
         %

      But the -e flag can indicate any argument to be a search-string, and that
      can mean, in turn, that an earlier argument must have been the file name:
         % fgrep allcards -e 2D
         2D2♦
         %

      This is a behavior you will need in implementing Line #2 of flushtest.

---
ls:   The hint I will point out here is that Lecture 2, Slide 72 indicates that
---   ls generates an often-unwanted error message when there are no matches to
      the given pattern. But Lecture 2, Slides 73 goes on to indicate that any
      such error messages can be thrown away by sending them to /dev/null.
    
      This is a behavior you will need in implementing Lines #3-6 of flushtest.

-----
echo: The hint I will point out here is that you can redirect the output of
----- echo into a file, and this is an easy way to create a file with any
      specific text you want to put into it.

      This is a behavior you will need in implementing Line #7 of flushtest.

------
paste:The hint I will point out here is that paste allows lines of the piped-in
------input stream to be combined with lines from a file.

      One unusual use for this feature is to combine it with fgrep: since the
      combined new line of text now has information from both sources, a match
      to fgrep from one source now creates an output for the other source too.
      For example, suppose you were in a directory that contained files named
      "LettersOn26SeparateLines" and "WhichLetter", defined as follows:
         % head -3 LettersOn26SeparateLines
         A
         B
         C
         % head -3 WhichLetter
         is the first letter in the alphabet.
         is the second letter in the alphabet.
         is the third letter in the alphabet.
         %

      In that case, paste can combine them:
         % paste  LettersOn26SeparateLines WhichLetter | head -3
         A       is the first letter in the alphabet.
         B       is the second letter in the alphabet.
         C       is the third letter in the alphabet.
         %
       
      And fgrep can search for something from one file, even though what is
      really wanted is the corresponding information in the other file:
         % paste  LettersOn26SeparateLines WhichLetter | fgrep C
         C       is the third letter in the alphabet.
         % paste  LettersOn26SeparateLines WhichLetter | fgrep G
         G       is the seventh letter in the alphabet.
         % paste  LettersOn26SeparateLines WhichLetter | fgrep T
         T       is the twentieth letter in the alphabet.
         %


      This is a behavior you will need in implementing Line #8 of flushtest.




                   - = - = - = - = - = - = - = - = - = -
                 |  Section 3.  Implementation Details   |
                   - = - = - = - = - = - = - = - = - = -


To begin discussing how to do the implementation, let's reconsider two of the
runs we saw in "screen.png", for a working version of the flushtest program:
   % ~/flushtest sample1
   2♣
   3♣
   5♣
   A♣
   10♣
   Flush!
   %
   %
   % ~/flushtest sample3
   2♦
   3♣
   5♣
   A♣
   10♣
   %

As we see, the five cards display print, but the word "Flush" only sometimes
displays. "Flush!" displays if the cards are all of the same suit (in sample1,
they are all ♣).

So how can flushtest be implemented with just the commands we've learned in the
first two lectures? We'll consider that now, in a line-by-line discussion of
how to implement your homework...

-------------------------------------------------------------------------------
Line 1: Change the directory to the place indicated by the passed-in argument.

        Q. How to access the passed-in value?
        A. See Lecture 2, slides 97-100.

        Q. What if the user doesn't pass-in an argument, or passes-in two
           arguments, or passes-in an argument that isn't a subdirectory name?
        A. The TA will not test such cases, so ignore them.

        Q. What if I make my own subdirectory with its own name?
        A. Yes, the TA also will make some additional subdirectories. Your
           homework should work on these, just so long as such directories
           do contain exactly 5 files with valid names that correspond to
           one of the 52 card codes (note that these codes all use upper-case
           letters).
           Also note that the directories the TA creates may contain additional
           files -- the only restriction for the TA is that no other files
           can have 2-character filenames.

-------------------------------------------------------------------------------
Line 2: This line is responsible for printing the 5 cards.

        Being limited to just the commands from lectures 1&2 makes this harder.
        To accomplish it, you will need to use the following commands (and in
        the following order):

         1. Use ls (with any needed flags or arguments) in order to find the
            names of the cards in the hand.

         2. Use xargs (with any needed flags or arguments) in order to convert
            the ls output into arguments.
            (As a hint for this one, Section 2, above, has discussed the use of
            the -l flag with xargs).

         3. Use fgrep to look in the "allcards" file to find the line that
            matches to the argument that is passed to fgrep from xargs.
            (As a hint for this one, Section 2, above, has discussed the use of
            the -e flag with fgrep).

         4. Use cut to remove the first two characters from the input stream.
            For example, a passed-in input of "2D2♦", would create an output
            of "2♦". Or if the input was "TC10♣", the output would be "10♣".

-------------------------------------------------------------------------------
Lines 3-6: These four lines identify how many cards match to each of the four
           suits. The result of running these four lines is the creation of a
           temporary file containing four lines, where each line holds a number
           and where these four numbers always add up to 5 (because there are
           always five cards in a hand).

           So for example, consider that hand represented by sample5:
              % ls sample5
              3S  4D  4H  4S  QS
              %

           This hand has 3 Spades(♠), 1 Diamond(♦), 1 Heart(♥) and no Clubs(♣).
           So the four lines of the created temporary file would hold the
           numbers 3, 1, 1, and 0 (the order is not important). And, indeed,
           3+1+1+0 = 5.

           (As a hint for this one, Section 2, above, has discussed how the
           "ls" command sometimes creates unwanted error messages, and how
           those messages can be thrown away).
          
-------------------------------------------------------------------------------
Line 7:   This line creates a file containing the word "Flush!".
          (As a hint for this one, Section 2, above, has discussed how the
          "echo" command can be used to create a file.)
          
-------------------------------------------------------------------------------
Line 8:   This line is responsible for displaying the word "Flush!", when it
          is appropriate to display it. And when is it appropriate to display
          it? The answer is: when the temporary file creates on lines 3-6 holds
          a line with the number "5". (If you think about it, you will see that
          that is the appropriate test for a hand being a flush.)

          Now, to implement Line 8, execute the following commands (in the
          following order):
           1. Use fgrep to see if there is a "5" in the temporary file created
              in Lines 3-6.
           2. Use paste to combine the input stream from fgrep along with the
              file you created on Line 7 (which holds the word "Flush!").
              (As a hint for this one, Section 2, above, has discussed how the
              "paste" command can be used to combine things for a later fgrep.)
           3. Use fgrep to see if there is a line containing a "5" in the input
              stream.  But wait! Didn't step 1 already check for a "5"? Yes, it
              did. But not the paste command has created an input stream, even
              if there was no output from the earlier fgrep. 
           4. Use cut to remove the "5" and the "\t" from the input stream.
              (The "5" came from fgrep, and the "\t" was the paste delimiter.)

Line 9:   This line removes any temporary files created by the flushtest script.


And that is all there is to implement; the flushtest file will contain 9 lines.



 - = - = - = - = - = - = - = - = - = - = - 
| Section 4. Submission and Grading Rules |
 - = - = - = - = - = - = - = - = - = - = - 


This is a large class. Unless each of you follows the below rules, the grading
work becomes so hard. So I REQUIRE you to FOLLOW THESE RULES:

1. Submit on time. Submissions made after the deadline will be ignored.
   If you submit a second time, it will overwrite your first submission. If you
   submit after the deadline (11:59pm), then the system will not allow you to
   submit. (At that point you should immediately email your attached homework
   to me at stevewhaga@yahoo.com)
   (By the way, if you don't turn in your assignments, you will probably Fail
    The Class. That's a Fact. So start early and ask questions.)


2. Test your answer before submitting. In "screen.png", you will find a set of
   expected outputs. Some of these outputs print the word "Flush!", and other
   outputs just list the cards.
   If you cannot get the same output for listing the cards, you will get a 0%.
   If you cannot generate the "Flush!" in sample1 and sample2 (but not in
   sample3, sample4, and sample5), then you cannot earn more than 70%.


3. You must follow the instructions from Section 3. If you do not follow those
   instructions (eg, if you use commands that were not taught in Lectures 1&2)
   then you will not get the points for that part.
  

4. Don't cheat. You may discuss the assignment with your classmates. Discussion
   can be quite helpful to your learning -- IF you ONLY talk about the concepts
   of the assignment. If, however, you discuss specific implementation details,
   then you're not helping others learn; you're just doing their work for them.

   You CANNOT share code. You CANNOT show another student ANY part of your
   answer to the assignment. You CANNOT let another student look over your
   shoulder at your code. You CANNOT describe your answer, except in a general
   way. Think of these assignments as take-home exams.

   You CAN discuss what the assignment's requirements are (eg, questions over
   the meaning of the English). You CAN give general tips on how to implement
   the assignment. If a student describes to you what isn't working in their
   solution, you CAN give suggestions on how to try to fix it -- but you CANNOT
   look at their code and debug it for them. Instead, try using a different
   example that suffers from the same problem, and help your classmate to debug
   that example.
   
   Once again: you CANNOT let a student look over your shoulder when your code
   is on the screen.

   If students are found to be sharing work, they will receive a 0 for this
   course, or worse. We always look for evidence of cheating, so don't do it.
   (In any event, even if you do not get caught, a student who copies the
   homework will not learn the material, so they will fail the exam.)

   Some students have expressed some confusion about what constitutes cheating.
   我發現有些學生對於作弊的定義很困惑。

   You really ought to know by your third year of college. But, because the
   penalties are severe, I understand why some feel cautious.
   大三了，你應該早就知道甚麼是作弊。然而，由於後果是如此的嚴重，所以我了解你
   為何會如此謹慎。 

   Actually, the homework description files contain a pretty good definition of
   cheating: copying someone else's code or letting them copy your code. 
   事實上，每一次的作業都有很詳細的說明作弊的定義：抄襲別人的程式碼或讓別人抄襲
   自己的程式碼。

   The confusion comes from times when students work together on an assignment.
   To be more clear: working together on THINKING about an assignment. (Working
   together ON the assignment would be cheating, these are not group projects.)
   會產生對作弊的困惑是因為有些學生是團體一起寫作業。好吧，我們說得更清楚一些。
   就是一起討論和寫一份作業。(一起寫作業就是作弊，作業不是以組別為單位繳交的。)

   The analogy is identical to a take-home exam. There is no such thing as a
   group exam, but there is such a thing as a study group. 
   這跟帶回家的考試不一樣，因為有以群組為單位的讀書會這種東西，但是沒有以群組為
   單位的考試這種東西。

   Study groups are good; students learn from each other and end up with a
   better grasp of the material than if they had worked alone. 
   讀書會是好的，因為學生可以彼此學習，比起自己一個人努力讀書，團體讀書更可以掌
   握教材。

   But groups working together to DO an assignment are bad, because students
   learn less than they would alone -- no learning occurs when you just copy
   the code from someone else. 
   但是團體寫作業就不好了，因為比起自己單獨做作業，團體寫作業的時候學生可以學習
   的更少--特別是"只是抄襲別人的程式"這根本就沒有任何的學習。 

   So: If you do not actually look at someone else's code or actually give your
   code to someone else (electronically, physically, OR verbally), then you are
   not cheating. 
   所以，以下是我的答案：如果你沒有看別人的程式碼或把你的程式碼給別人看，那你就
   沒有作弊。(傳檔案，手抄，口頭轉達)

   Of course, the line blurs a little bit: "What if my friend asked me why his
   xargs command didn't work, and I told him he needed a -l flag? Then, later,
   when he puts this command into his program, did I cheat?" Answer: No. 
   當然，這界線有點模糊：如果我朋友問我說為何指令xargs不能用？然後我告訴他說：
   你需要加上-l。然後，他就把這個答案放進去他的程式裡面，那我算作弊嗎？答案是：
   不算

   That type of collaboration falls into the category of studying together, not
   team-programming. 
   這類型的合作屬於一起學習，而非團體寫程式。 

   The outcome of such collaboration is increased learning, not decreased
   learning.
   這種方式的合作會增加學生了解內容的機會，不會減少學生去認識課程內容。 

   But it becomes a different thing when your friend says: "I don't understand
   how to do line 3 in HW1". 
   但這種情況就另當別論了，當你的朋友說：我不知作業1的第3行怎麼寫耶。

   And then you answer: "Oh, use this: ..." and you show or describe the whole
   thing or give him your wildcard pattern. That is a bigger piece of code. 
   然後你回答：喔...就是用這個阿...。然後你就把整個答案都給他看。<--這可是一大
   塊程式碼耶！ 

   That's called doing his assignment for him. Another name for it is cheating.
   It's not fair to the other students who try to work on their own. 
   這種情形就叫做"幫別人寫作業"。另外一種說法就是"作弊"。這對於那些努力試著自己
   寫作業的學生來說這是不公平的。 

   Note that this rule is not limited to literally showing the code, because it
   is also cheating to DESCRIBE the code so clearly that you might as well have
   shown it.

   If you have further questions, you may ask me.
