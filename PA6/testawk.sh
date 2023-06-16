cat QuantumQuest:_A_ChatGPT_Space_Adventure | \
    awk -f PA6.awk | uniq | \
    sed 's/[[]Insert Ship Name]/Fortune Céleste/' > DatabaseAndLog

sort DatabaseAndLog > sortedDatabaseAndLog
sort DatabaseAndLogExpected > sortedDatabaseAndLogExpected
echo
diff -q sortedDatabaseAndLogExpected sortedDatabaseAndLog && \
     echo Matches\! || echo doesn\'t match\!
echo
rm -f sortedDatabaseAndLog sortedDatabaseAndLogExpected
