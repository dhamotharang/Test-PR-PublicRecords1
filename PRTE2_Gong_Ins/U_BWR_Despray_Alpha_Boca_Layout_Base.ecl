/* *****************************************************************************************
 PRTE2_Gong_Ins.U_BWR_Despray_Alpha_Boca_Layout_Base
 This is for despraying the final Boca compatible base data to a csv file
 AB stands for Alpha-Boca Compatible base file.
***************************************************************************************** */

IMPORT PRTE2_Gong_Ins, PRTE2_Common;
#workunit('name', 'Alpha PRTE2 GONG AB Despray');

STRING dateString := PRTE2_Common.Constants.TodayString+'';

// desprayName	:= 'Gong_AB_Base_DEV_'+dateString+'.csv';
// EXPORT_DS		:=	SORT(PRTE2_Gong_Ins.Files.Gong_Base_SF_DS,did);
desprayName	:= 'Gong_AB_Base2_PROD_'+dateString+'.csv';
EXPORT_DS		:=	SORT(PRTE2_Gong_Ins.Files.Gong_Base_SF_DS_Prod,did);

LandingZoneIP 	:= PRTE2_Gong_Ins.Constants.LandingZoneIP;
TempCSV					:= PRTE2_Gong_Ins.Files.FILE_SPRAY;
lzFilePathGatewayFile	:= PRTE2_Gong_Ins.Constants.SourcePathForCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);
