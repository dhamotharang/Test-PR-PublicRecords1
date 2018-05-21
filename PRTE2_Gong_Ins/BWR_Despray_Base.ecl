/* *****************************************************************************************
 PRTE2_Gong_Ins.BWR_Despray_Base 
 This is for despraying base data to csv file
***************************************************************************************** */
IMPORT PRTE2_Gong_Ins, PRTE2_Common;
#workunit('name', 'Boca PRTE2 GONG Despray');

STRING dateString := PRTE2_Common.Constants.TodayString+'';

desprayName	:= 'Gong_Base_AfterAdds_'+dateString+'.csv';
EXPORT_DS		:=	SORT(PRTE2_Gong_Ins.Files.Gong_Base_SF_DS,did);
// desprayName	:= 'Gong_Base_PROD_'+dateString+'.csv';
// EXPORT_DS		:=	SORT(PRTE2_Gong_Ins.Files.Gong_Base_SF_DS_PROD,l_did); //Prod file.

LandingZoneIP 	:= PRTE2_Gong_Ins.Constants.LandingZoneIP;
TempCSV					:= PRTE2_Gong_Ins.Files.FILE_SPRAY;
lzFilePathGatewayFile	:= PRTE2_Gong_Ins.Constants.SourcePathForCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);
