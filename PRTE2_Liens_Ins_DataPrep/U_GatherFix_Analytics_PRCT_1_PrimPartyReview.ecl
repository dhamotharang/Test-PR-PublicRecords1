/* *********************************************************************************************
PRTE2_Liens_Ins_DataPrep.U_GatherFix_Analytics_PRCT_2_Party

Take what was produced by U_GatherFix_Analytics_Spray2 and U_GatherFix_Analytics_PRCT_1_PrimParty
and connect them into a connected MAIN and PARTY file
********************************************************************************************* */



Main_File_Name	:= PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Main_File_Final;
Party_File_Name := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Party_File_Final;
		
// Read MAIN 9000 records
AnalyMain2_DS := SORT(PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.AnalyMain2_DS,agency_state,joinint);
// Read PRIM_PARTY records where joinint<>0 and BocaHit<>'Y';
Prim_Party_DS := SORT(PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Prim_Party_DS(joinint > 0),st,joinint);

OUTPUT(COUNT(AnalyMain2_DS));
OUTPUT(Choosen(AnalyMain2_DS,1000));
OUTPUT(COUNT(Prim_Party_DS));
OUTPUT(Choosen(Prim_Party_DS,1000));

/*

Prim_Party_DS trxParty(AnalyMain2_Group L, Prim_Party_Group R) := TRANSFORM
END;

JOIN(AnalyMain2_Group, Prim_Party_Group,
			left.joinint = right.joinint AND left.agency_state = right.st
			...
			);
	
*/		