// --------------------------------------------------------------------------------
//  PRTE2_eMerges.BWR_Despray_Base 
//  This is for despraying base data to csv file 
// --------------------------------------------------------------------------------

IMPORT ut, PRTE2_eMerges, PRTE2_Common;
#workunit('name', 'Boca PRTE2 eMerges Despray');

dateString			:= ut.GetDate;
TempCSV					:= PRTE2_eMerges.Files.FILE_DESPRAY_CSV + '::' +  WORKUNIT;

desprayName 				:= 'eMerges_Export_DEV_'+dateString+'.csv';
EXPORT_DS	:=	PRTE2_eMerges.Files.eMerges_Boca_SF_DS;

// NOTE: If Boca wants some other despray location edit these locations in the Constants ...
LandingZoneIP 	:= PRTE2_eMerges.Constants.LandingZoneIP;
lzFilePathGatewayFile	:= PRTE2_eMerges.Constants.SourcePathForCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);

