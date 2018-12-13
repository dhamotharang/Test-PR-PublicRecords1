/* *********************************************************************************************
PRTE2_Liens_Ins_DataPrep.U_GatherFix_Analytics_PRCT_3_Usable

--- take what was created in U_GatherFix_Analytics_PRCT_2_Main and now join 
* State-Grouped MAIN file
* State-Grouped PARTY file
--- and create final version of party file that is joined to the already created main file.
********************************************************************************************* */

IMPORT PRTE2_Liens_Ins,PromoteSupers, PRTE2_Common;

//***********************************************************************************************
Main_Final := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Main_Final_DS(joinint<>0);
Party_Final := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Party_Final_DS(joinint<>0);		
MainUsable := SORT(Main_Final(joinint < 101),agency_state,joinint);					// these are still numbered grouped by state
PartyUsable := SORT(Party_Final(joinint < 101),st,joinint);									// these are still numbered grouped by state
OUTPUT(MainUsable,, PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Usable_Main_Final, OVERWRITE);
OUTPUT(PartyUsable,, PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Usable_Party_Final, OVERWRITE);

MainOut 	:= PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Usable_Main_DS;
PartyOut 	:= PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Usable_Party_DS;

// See also U_GatherFix_Analytics_PRCT_9_audits for tests which I ran.

DataIn := PartyOut;
report0 := RECORD
	recTypeSrc	 := DataIn.st;
	GroupCount := COUNT(GROUP);
END;

RepTable0 := TABLE(DataIn,report0,st);
OUTPUT(SORT(RepTable0,recTypeSrc),ALL);

