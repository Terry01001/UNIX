BEGIN{DE="Database Entry: "}
$0 ~ /^End of/{next}
NR==448{$0=DE "Dilithium"}
$0 ~ /^Deep Space Hibernation:|^Weapons System:/{split($0,A,": ");DB[DE A[1]]=A[2] "\n"}
$0 ~ /Log, Day 113/ {sub("Log, Day 113","Log - Mission Day 113")}
$0 ~ /, Supplemental/ {sub(", Supplemental"," - Mission Day 113, Supplemental")}
$0 ~ /^Database|^Captain's Log/{K=$0; DB[K]=""; getline $0}
$0 ~ /^User/{K=""}
K!=""{DB[K] = DB[K] "\n" $0}
END{for (key in DB) {print key ":"; print DB[key]; print "------------------------"} }
