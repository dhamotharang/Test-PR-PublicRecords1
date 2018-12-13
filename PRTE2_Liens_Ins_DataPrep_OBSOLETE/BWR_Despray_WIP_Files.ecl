/* *********************************************************************************************
 PRTE2_Liens_Ins_DataPrep.BWR_Despray_WIP_Files
 This is for despraying base data to csv files
********************************************************************************************* */

IMPORT PRTE2_Liens_Ins, PRTE2_Liens_Ins_DataPrep, PRTE2_Common;
#workunit('name', 'PRTE2 Alpha Liens Dataprep Despray');

// ---------------------------------------------------------------------------
STRING dateString := PRTE2_Common.Constants.TodayString+'';
desprayNameMain		:= 'WIP_Main_PROD_Samples_'+dateString+'.csv';
desprayNameParty	:= 'WIP_Party_PROD_Samples_'+dateString+'.csv';
desprayWIPMain		:= 'WIP_Main_Generated_'+dateString+'.csv';
desprayWIPParty		:= 'WIP_Party_Generated_'+dateString+'.csv';
desprayIHDR_IN		:= 'IHDR_Incoming_'+dateString+'.csv';
// ---------------------------------------------------------------------------

Save_ProdParty_DS	:= SORT(PRTE2_Liens_Ins_DataPrep.Files.Save_ProdParty_DS,tmsid);
Save_ProdMain_DS	:= SORT(PRTE2_Liens_Ins_DataPrep.Files.Save_ProdMain_DS,tmsid);
WIP_Party_DS			:= SORT(PRTE2_Liens_Ins_DataPrep.Files.Save_PartyWIP_DS,orig_state, joinint);
WIP_Main_DS				:= SORT(PRTE2_Liens_Ins_DataPrep.Files.Save_MainWIP_DS,exjoinint1);
IHDR_Incoming_DS	:= PRTE2_Liens_Ins_DataPrep.Files.Incoming_IHDR_DS;

LandingZoneIP 	:= PRTE2_Liens_Ins.Constants.LandingZoneIP;
TempCSV1				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_1';
TempCSV2				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_2';
TempCSV3				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_3';
TempCSV4				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_4';
TempCSV5				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_5';
pathFile				:= PRTE2_Liens_Ins.Constants.SourcePathForCSV;

// PRTE2_Common.DesprayCSV(Save_ProdMain_DS, TempCSV1, LandingZoneIP, pathFile+desprayNameMain);
// PRTE2_Common.DesprayCSV(Save_ProdParty_DS, TempCSV2, LandingZoneIP, pathFile+desprayNameParty);
// PRTE2_Common.DesprayCSV(IHDR_Incoming_DS, TempCSV3, LandingZoneIP, pathFile+desprayIHDR_IN);
PRTE2_Common.DesprayCSV(WIP_Party_DS, TempCSV4, LandingZoneIP, pathFile+desprayWIPParty);
PRTE2_Common.DesprayCSV(WIP_Main_DS, TempCSV5, LandingZoneIP, pathFile+desprayWIPMain);

// ----------------- OLD --------------------------------------------------------------------------
// NOTE: the EQ and TU files are ONLY for the purpose of selecting 10 records per state from their 50k 
// desprayNameEQ			:= 'WIP_Incoming_EQ_'+dateString+'.csv';
// desprayNameTU			:= 'WIP_Incoming_TU_'+dateString+'.csv';
// TMP_EQ_DS					:= PRTE2_Liens_Ins_DataPrep.Files.TMP_EQ_DS;
// TMP_TU_DS					:= PRTE2_Liens_Ins_DataPrep.Files.TMP_TU_DS;
// PRTE2_Common.DesprayCSV(TMP_EQ_DS, TempCSV3, LandingZoneIP, pathFile+desprayNameEQ);
// PRTE2_Common.DesprayCSV(TMP_TU_DS, TempCSV4, LandingZoneIP, pathFile+desprayNameTU);
