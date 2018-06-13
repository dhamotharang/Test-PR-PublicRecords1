/* *****************************************************************************************
 PRTE2_Gong_Ins.BWR_Despray_Base 
 This is for despraying base data to csv file

NOTE: This is designed to despray the Alpha CSV base file in our layout, not the final Boca Base.
***************************************************************************************** */
IMPORT PRTE2_Gong_Ins, PRTE2_Common;
#workunit('name', 'Alpha PRTE2 GONG Despray');

STRING dateString := PRTE2_Common.Constants.TodayString+'';

desprayName	:= 'Gong_Base_Dev2_'+dateString+'.csv';
EXPORT_DS		:=	SORT(PRTE2_Gong_Ins.Files.Gong_Base_CSV_DS,did);
// desprayName	:= 'Gong_Base_PROD_'+dateString+'.csv';
// EXPORT_DS		:=	SORT(PRTE2_Gong_Ins.Files.Gong_Base_CSV_DS_Prod,did); //Prod file.

LandingZoneIP 	:= PRTE2_Gong_Ins.Constants.LandingZoneIP;
TempCSV					:= PRTE2_Gong_Ins.Files.FILE_SPRAY;
lzFilePathGatewayFile	:= PRTE2_Gong_Ins.Constants.SourcePathForCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);
