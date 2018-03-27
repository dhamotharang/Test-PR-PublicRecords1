// --------------------------------------------------------------------------------
//  PRTE2_Hunting_Fishing.BWR_Despray_Base 
//  This is for despraying base data to csv file
// --------------------------------------------------------------------------------

IMPORT ut, PRTE2_Hunting_Fishing, PRTE2_Common;
#workunit('name', 'Boca PRTE2 HuntFish Despray');

dateString			:= ut.GetDate;
LandingZoneIP 	:= PRTE2_Hunting_Fishing.Constants.LandingZoneIP;
TempCSV					:= PRTE2_Hunting_Fishing.Files.FILE_DESPRAY_CSV + '::' +  WORKUNIT;

desprayName 				:= 'HuntFish_Export_DEV_'+dateString+'.csv';
EXPORT_DS	:=	PRTE2_Hunting_Fishing.Files.HuntFish_Alpha_SF_DS;
// desprayName 				:= 'HuntFish_Export_PROD_'+dateString+'.csv';
// EXPORT_DS	:=	PRTE2_Hunting_Fishing.Files.HuntFish_Alpha_SF_DS_Prod;
lzFilePathGatewayFile	:= PRTE2_Hunting_Fishing.Constants.SourcePathForCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);

