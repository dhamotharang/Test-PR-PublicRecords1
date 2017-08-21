// --------------------------------------------------------------------------------
//  PRTE2_Phonesplus_Ins.BWR_Despray_Base 
//  This is for despraying base data to csv file
// --------------------------------------------------------------------------------

IMPORT PRTE2_Phonesplus_Ins, PRTE2_Common;
#workunit('name', 'Boca PRTE2 PhonesPlus Despray');

STRING dateString := PRTE2_Common.Constants.TodayString+'';

// desprayName	:= 'PhonesPlus_Base_DEV_'+dateString+'.csv';
// EXPORT_DS		:=	SORT(PRTE2_Phonesplus_Ins.Files.PhonesPlus_Base_SF_DS,l_did);
desprayName	:= 'PhonesPlus_Base_PROD_'+dateString+'.csv';
EXPORT_DS		:=	SORT(PRTE2_Phonesplus_Ins.Files.PhonesPlus_Base_SF_DS_PROD,l_did); //Prod file.

LandingZoneIP 	:= PRTE2_Phonesplus_Ins.Constants.LandingZoneIP;
TempCSV					:= PRTE2_Phonesplus_Ins.Files.FILE_SPRAY;
lzFilePathGatewayFile	:= PRTE2_Phonesplus_Ins.Constants.SourcePathForCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);
