


Dups1 := SORT(PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Main_Later1_DS,tmsid);
Dups2 := SORT(PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Main_Later2_DS,tmsid);
Main1 := SORT(PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Main_Final_DS,tmsid);
OUTPUT(SORT(Dups1,tmsid,joinint));
OUTPUT(SORT(Dups1,tmsid,joinint));
OUTPUT(SORT(Main1,tmsid));
// dups1Set := SET(dups1,tmsid);						
// Main2 := Main1(tmsid IN dups1Set);
// OUTPUT(COUNT(Main2));
// OUTPUT(Main2);
