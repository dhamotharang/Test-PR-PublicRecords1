/* *********************************************************************************************
PRTE2_Liens_Ins_DataPrep.U_GatherFix_Analytics_Despray

Despray process to be run after the following:
	U_GatherFix_Analytics_PRCT_1_PrimParty
	U_GatherFix_Analytics_PRCT_2_Main
	U_GatherFix_Analytics_PRCT_2_PostProcess
	U_GatherFix_Analytics_PRCT_3_Usable
	U_GatherFix_Analytics_PRCT_9_audits	(just to check record counts, tmsid dups, etc)

(the import for main was LJTestCases1213_wTMSID.csv)

********************************************************************************************* */
IMPORT PRTE2_Liens_Ins_DataPrep, PRTE2_Liens_Ins, PRTE2_Common;

STRING dateString := PRTE2_Common.Constants.TodayString+'';

// **********************************************************************************************
Main_Final := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Usable_Main_DS;
Party_Final := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Usable_Party_DS;	
PrimParty := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Prim_Party_DS;	
Later1 := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Main_Later1_DS;	
Later2 := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Main_Later2_DS;	
// **********************************************************************************************
MainLay := PRTE2_Liens_Ins.Layouts.BaseMain_in_raw;
PartyLay := PRTE2_Liens_Ins.Layouts.Baseparty_in;
// **********************************************************************************************
MainOut := PROJECT(Main_Final,MainLay);
PartyOut := PROJECT(Party_Final,PartyLay);
OUTPUT(MainOut);
OUTPUT(PartyOut);
OUTPUT(PrimParty);
// **********************************************************************************************
// **********************************************************************************************
LandingZoneIP 	:= PRTE2_Liens_Ins.Constants.LandingZoneIP;
TempCSV	:= PRTE2_Liens_Ins.Files.FILE_SPRAY;
pathFileParty	:= PRTE2_Liens_Ins.Constants.SourcePathForCSV;
PRTE2_Common.DesprayCSV(MainOut, TempCSV+'_1', LandingZoneIP, pathFileParty+'Final_Alpha_Main_'+dateString+'.csv');
PRTE2_Common.DesprayCSV(PartyOut, TempCSV+'_2', LandingZoneIP, pathFileParty+'Final_Alpha_Party_'+dateString+'.csv');
PRTE2_Common.DesprayCSV(PrimParty, TempCSV+'_3', LandingZoneIP, pathFileParty+'Final_Parties_All_(hits)_'+dateString+'.csv');
PRTE2_Common.DesprayCSV(Later1, TempCSV+'_4', LandingZoneIP, pathFileParty+'Main_Dups_for_Later1_'+dateString+'.csv');
PRTE2_Common.DesprayCSV(Later2, TempCSV+'_5', LandingZoneIP, pathFileParty+'Main_Dups_for_Later2_'+dateString+'.csv');
// **********************************************************************************************