/* *********************************************************************************************
PRTE2_Liens_Ins_DataPrep.U_GatherFix_Analytics_PRCT_9_audits

hit problems with DUP tmsid records after all was done, had to go back to U_GatherFix_Analytics_PRCT_2_Main
and capture dup tmsid records that came in from analytics group. we can study those later and re-add them.
See: 
PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Main_Later1_DS		// contains dups rejected
PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Main_Later2_DS		// contains dups and single records kept to study relationships.
********************************************************************************************* */

IMPORT PRTE2_Liens_Ins,PromoteSupers, PRTE2_Common;

MainOut 	:= PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Usable_Main_DS;
PartyOut 	:= PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Usable_Party_DS;

OUTPUT(CHOOSEN(MainOut,1000));
OUTPUT(CHOOSEN(PartyOut,1000));
testjoin := JOIN(MainOut,PartyOut,
									left.tmsid=right.tmsid,
									TRANSFORM({MainOut},SELF := left;),
									inner);
OUTPUT(COUNT(testjoin));		// s/b the same as the file count of 5,100 since we have simple single records but it had 5,694 ???
// first tests that had problems:
// MainD := DEDUP(SORT(MainOut,tmsid),tmsid);		// 4,897	... so we have some DUP tmsid's?
// PartyD := DEDUP(SORT(PartyOut,tmsid),tmsid);	// 4,897	... so we have some DUP tmsid's?
MainD := DEDUP(SORT(MainOut,tmsid),tmsid);		// 5,066 which matches final_usable_main
PartyD := DEDUP(SORT(PartyOut,tmsid),tmsid);	// 5,066 which matches final_usable_party
OUTPUT(COUNT(MainD));		
OUTPUT(COUNT(PartyD));		
main_1 := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Main_Final_DS;
Main1D := DEDUP(SORT(main_1,tmsid),tmsid);
// first tests that had problems:
// OUTPUT(COUNT(main_1),NAMED('main_1'));		// 9,271
// OUTPUT(COUNT(Main1D),NAMED('Main1D'));		// 8,945	... so yes, the initial main creation created some DUP tmsids - need to redo that step.
OUTPUT(COUNT(main_1),NAMED('main_1'));		// After fixes, 8927
OUTPUT(COUNT(Main1D),NAMED('Main1D'));		// After fixes, 8927, so fixes worked.
dups1 := JOIN(main_1,main1d,
						left.tmsid=right.tmsid and left.agency_state=right.agency_state and left.joinint=right.joinint,
						TRANSFORM({MainOut},SELF := left;),
						left only);
dups1Set := SET(dups1,tmsid);						
dups2 := main_1(tmsid IN dups1Set);

OUTPUT(dups1);
OUTPUT(SORT(dups2,tmsid));

DataIn := PartyOut;
report0 := RECORD
	recTypeSrc	 := DataIn.st;
	GroupCount := COUNT(GROUP);
END;

RepTable0 := TABLE(DataIn,report0,st);
OUTPUT(SORT(RepTable0,recTypeSrc),ALL);

