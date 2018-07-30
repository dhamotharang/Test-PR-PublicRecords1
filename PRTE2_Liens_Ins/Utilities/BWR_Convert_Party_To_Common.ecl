/* *********************************************************************************************
 PRTE2_Liens_Ins.BWR_Despray_All
 This is for despraying base data to csv files
********************************************************************************************* */

IMPORT PRTE2_Liens_Ins, PRTE2_Common;
#workunit('name', 'Boca PRTE2 Alpha Liens Despray');

STRING dateString := PRTE2_Common.Constants.TodayString+'';
IDsLinda := ['17272013003100','17271233003396','17271233004331','17272093001033','17272003001904','17272033000153','17272033003262','17272063004816','17271233002091',
'17272093000553','17271233000885','17272003004922','17271223000123','17271233002617','17272023000506','17272033000854','17272003003197','17272013003403',
'17271223000290','17272013001356','17272023000516','17272033003331','17272073000058','HG123ERT4958000OHCUYM7','HG123ERT4968000OHCOSM1',
'HG123ERT4978000OHCUYM7','HG123ERT4988000OHCOSM1'];
// ---- PROD DESPRAY ---------------------------------------------------------
desprayNameMain	:= 'Liens_MainV2_PROD_'+dateString+'.csv';
desprayNameParty	:= 'Liens_PartyV2_PROD_'+dateString+'.csv';

Export_Main0		:=	SORT(PRTE2_Liens_Ins.Files.Main_IN_DS_Prod_OLD,tmsid); //Prod file.
Export_Party0		:=	SORT(PRTE2_Liens_Ins.Files.Party_IN_DS_Prod_OLD,tmsid); //Prod file.

// -----------------------------------------------------
Export_Main := PROJECT(Export_Main0,TRANSFORM(
																			PRTE2_Liens_Ins.Layouts.BaseMain_in_raw,
																			// SELF.bug_num := IF(tmsid in IDsLinda,'CT-1677','DF-22454'),
																			// SELF.Cust_Name := 'IN_PR',
																			SELF := LEFT,
																			SELF := []));
Export_Party := PROJECT(Export_Party0,TRANSFORM(
																			PRTE2_Liens_Ins.Layouts.Baseparty_in,
																			SELF.orig_address2 := '';
																			SELF.xBug_num := IF(LEFT.tmsid in IDsLinda,'CT-1677','DF-22454'),
																			SELF.xSponsor := 'IN_PR',
																			SELF.bug_num := IF(LEFT.tmsid in IDsLinda,'CT-1677','DF-22454'),
																			SELF.Cust_Name := 'IN_PR',
																			SELF := LEFT,
																			SELF := []));
// -----------------------------------------------------

// OUTPUT(COUNT(Export_Main(bcbflag=TRUE)));
LandingZoneIP 	:= PRTE2_Liens_Ins.Constants.LandingZoneIP;
TempCSV1				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_1';
TempCSV2				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_2';
pathFile				:= PRTE2_Liens_Ins.Constants.SourcePathForCSV;

PRTE2_Common.DesprayCSV(Export_Main, TempCSV1, LandingZoneIP, pathFile+desprayNameMain);
PRTE2_Common.DesprayCSV(Export_Party, TempCSV2, LandingZoneIP, pathFile+desprayNameParty);
Export_Party;
Export_Main;