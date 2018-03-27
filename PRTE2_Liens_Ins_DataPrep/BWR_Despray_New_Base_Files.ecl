/* *********************************************************************************************
 PRTE2_Liens_Ins_DataPrep.BWR_Despray_New_Base_Files
 Basically works like a spray/add process to take what we generated and append to base files.

********************************************************************************************* */

IMPORT PRTE2_Liens_Ins, PRTE2_Liens_Ins_DataPrep, PRTE2_Common;
#workunit('name', 'Boca PRTE2 Alpha Liens Despray');

STRING dateString := PRTE2_Common.Constants.TodayString+'';
desprayNameMain	:= 'Liens_Main_Added_'+dateString+'.csv';
desprayNameParty	:= 'Liens_Party_Added_'+dateString+'.csv';

// -----------------------------------------------------
Layouts := PRTE2_Liens_Ins.Layouts;
// ---- PROD DESPRAY ---------------------------------------------------------
WIP_Party_DS			:= SORT(PRTE2_Liens_Ins_DataPrep.Files.Save_PartyWIP_DS,orig_state, joinint);
WIP_Main_DS				:= SORT(PRTE2_Liens_Ins_DataPrep.Files.Save_MainWIP_DS,exjoinint1);
WIP_Party_Ready 	:= PROJECT(WIP_Party_DS,Layouts.BaseParty_in);
WIP_Main_Ready	 	:= PROJECT(WIP_Main_DS,Layouts.BaseMain_in_raw);
Export_Main0			:=	SORT(PRTE2_Liens_Ins.Files.Main_IN_DS_PROD,tmsid); //Prod file.
Export_Party0			:=	SORT(PRTE2_Liens_Ins.Files.Party_IN_DS_PROD,tmsid); //Prod file.
Export_Main				:=	Export_Main0 + WIP_Main_Ready;
Export_Party			:=	Export_Party0 + WIP_Party_Ready;
// ---------------------------------------------------------------------------
LandingZoneIP 	:= PRTE2_Liens_Ins.Constants.LandingZoneIP;
TempCSV1				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_1';
TempCSV2				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_2';
pathFile				:= PRTE2_Liens_Ins.Constants.SourcePathForCSV;

PRTE2_Common.DesprayCSV(Export_Main, TempCSV1, LandingZoneIP, pathFile+desprayNameMain);
PRTE2_Common.DesprayCSV(Export_Party, TempCSV2, LandingZoneIP, pathFile+desprayNameParty);
