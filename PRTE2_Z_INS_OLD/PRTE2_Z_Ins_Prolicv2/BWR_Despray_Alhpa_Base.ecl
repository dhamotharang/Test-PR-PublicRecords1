IMPORT ut, PRTE2_Prolicv2, PRTE2_Common;
#workunit('name', 'Alpha PRTE2 Prolicv2 Despray');

dateString			:= ut.GetDate+'';
LandingZoneIP 	:= PRTE2_Prolicv2.Constants.LandingZoneIP;
TempCSV					:= PRTE2_Prolicv2.Files.FILE_DESPRAY_CSV + '::' +  WORKUNIT;

desprayName 				:= 'Prolicv2_Data_Despray_newBase'+dateString+'.csv';
EXPORT_DS	:=	PRTE2_Prolicv2.Files.Prolicv2_Alpha_SF_DS;

lzFilePathGatewayFile	:= PRTE2_Prolicv2.Constants.SourcePathForCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);

