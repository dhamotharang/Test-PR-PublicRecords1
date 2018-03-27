IMPORT PRTE2_Common, ut;
IMPORT PRTE2_PropertyInfo as PII;
#workunit('name', 'Alpha Clash PropInfo Despray');

dateString := ut.GetDate;
LandingZoneIP 				:= PII.Constants.LandingZoneIP;
TempCSV								:= PII.Files.PII_CSV_FILE + '::' +  WORKUNIT;
desprayName 					:= 'PropertyInfo_CLASH_BASE_'+dateString+'.csv';
EXPORT_DS 						:= PII.U_PropInfo_Clash_Files.SAVE_RECS_DS;
// desprayName 					:= 'PropertyInfo_CLASH_XREF_'+dateString+'.csv';
// EXPORT_DS 						:= PII.U_PropInfo_Clash_Files.SAVE_XREF_DS;

lzFilePathGatewayFile	:= PII.Constants.SourcePathForPIICSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);

