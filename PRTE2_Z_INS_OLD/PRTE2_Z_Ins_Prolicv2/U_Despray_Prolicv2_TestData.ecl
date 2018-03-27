IMPORT ut, PRTE2_Prolicv2, PRTE2_Common;
#workunit('name', 'Alpha PRTE2 Prolicv2 Despray');

Files   := PRTE2_Prolicv2.Files;
Layouts := PRTE2_Prolicv2.Layouts;

dateString			:= ut.GetDate+'';
LandingZoneIP 	:= PRTE2_Prolicv2.Constants.LandingZoneIP;
TempCSV					:= PRTE2_Prolicv2.Files.FILE_DESPRAY_CSV + '::' +  WORKUNIT;

desprayName 				:= 'Prolicv2_TestData_Despray'+dateString+'.csv';
EXPORT_DS	:=	DATASET(Files.BASE_PREFIX_NAME+'::tmp::qa::PRCT_Alpha_Prolicv2', Layouts.AlphaBaseOUT, THOR);

lzFilePathGatewayFile	:= PRTE2_Prolicv2.Constants.SourcePathForCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);

