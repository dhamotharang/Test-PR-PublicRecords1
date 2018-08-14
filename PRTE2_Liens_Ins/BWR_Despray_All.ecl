/* *********************************************************************************************
 PRTE2_Liens_Ins.BWR_Despray_All
 This is for despraying base data to csv files
********************************************************************************************* */

IMPORT PRTE2_Liens_Ins, PRTE2_Common;
#workunit('name', 'Boca PRTE2 Alpha Liens Despray');

STRING dateString := PRTE2_Common.Constants.TodayString+'';

// ----- DEV DESPRAY ---------------------------------------------------------
// desprayNameMain	:= 'Liens_MainV2_DEV_'+dateString+'.csv';
// desprayNameParty	:= 'Liens_PartyV2_DEV_'+dateString+'.csv';
// Export_Main		:=	SORT(PRTE2_Liens_Ins.Files.Main_IN_DS,tmsid);
// Export_Party		:=	SORT(PRTE2_Liens_Ins.Files.Party_IN_DS,tmsid);
// ---------------------------------------------------------------------------
// ---- PROD DESPRAY ---------------------------------------------------------
desprayNameMain	:= 'Liens_MainV2_PROD_'+dateString+'.csv';
desprayNameParty	:= 'Liens_PartyV2_PROD_'+dateString+'.csv';
Export_Main		:=	SORT(PRTE2_Liens_Ins.Files.Main_IN_DS_PROD,tmsid); //Prod file.
Export_Party		:=	SORT(PRTE2_Liens_Ins.Files.Party_IN_DS_PROD,tmsid); //Prod file.
// ---------------------------------------------------------------------------
// OUTPUT(COUNT(Export_Main(bcbflag=TRUE)));
LandingZoneIP 	:= PRTE2_Liens_Ins.Constants.LandingZoneIP;
TempCSV1				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_1';
TempCSV2				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_2';
pathFile				:= PRTE2_Liens_Ins.Constants.SourcePathForCSV;

PRTE2_Common.DesprayCSV(Export_Main, TempCSV1, LandingZoneIP, pathFile+desprayNameMain);
PRTE2_Common.DesprayCSV(Export_Party, TempCSV2, LandingZoneIP, pathFile+desprayNameParty);
