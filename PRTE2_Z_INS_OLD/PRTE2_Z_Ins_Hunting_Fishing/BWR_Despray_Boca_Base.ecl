// --------------------------------------------------------------------------------
//  PRTE2_Hunting_Fishing.BWR_Despray_Base 
//  This is for despraying base data to csv file
// --------------------------------------------------------------------------------

IMPORT ut, PRTE2_Hunting_Fishing, PRTE2_Common;
#workunit('name', 'Boca PRTE2 HuntFish_Boca Despray');

dateString			:= ut.GetDate;
TempCSV					:= PRTE2_Hunting_Fishing.Files.FILE_DESPRAY_CSV + '::' +  WORKUNIT;

desprayName 				:= 'HuntFish_Boca_Base_'+dateString+'.csv';
EXPORT_DS	:=	PRTE2_Hunting_Fishing.Files.HuntFish_Boca_SF_DS;

// NOTE: If Boca wants some other despray location edit these locations in the Constants ...
LandingZoneIP 	:= PRTE2_Hunting_Fishing.Constants.LandingZoneIP;
lzFilePathGatewayFile	:= PRTE2_Hunting_Fishing.Constants.SourcePathForCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);

