// --------------------------------------------------------------------------------
//  PRTE2_Prolicv2.BWR_Despray_Boca_Base 
//  This is for despraying base data to csv file 
// --------------------------------------------------------------------------------

IMPORT ut, PRTE2_Prolicv2, PRTE2_Common;
#workunit('name', 'Boca PRTE2 Prolicv2 Despray');

dateString			:= ut.GetDate;
TempCSV					:= PRTE2_Prolicv2.Files.FILE_DESPRAY_CSV + '::' +  WORKUNIT;

desprayName 		:= 'Prolicv2_Export_DEV_'+dateString+'.csv';
EXPORT_DS	      := PRTE2_Prolicv2.Files.Prolicv2_Boca_SF_DS;

// NOTE: If Boca wants some other despray location edit these locations in the Constants ...
LandingZoneIP 	:= PRTE2_Prolicv2.Constants.LandingZoneIP;
lzFilePathGatewayFile	:= PRTE2_Prolicv2.Constants.SourcePathForCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);

