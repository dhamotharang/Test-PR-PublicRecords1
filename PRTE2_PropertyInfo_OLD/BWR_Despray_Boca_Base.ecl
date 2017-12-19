// PRTE2_PropertyInfo.BWR_Despray_Boca_Base
//  - despray the Property Info base file for editing.

IMPORT PRTE2_Common, ut;
IMPORT PRTE2_PropertyInfo as PII;
IMPORT PRTE2_PropertyScramble as SCR;
#workunit('name', 'Boca CT PropertyInfo Despray');

dateString := ut.GetDate;
LandingZoneIP 				:= PII.Constants.LandingZoneIP;
TempCSV								:= PII.Files.PII_CSV_FILE + '::' +  WORKUNIT;
//---------------------------------------------------------------------
//----------- If the Boca export, then use Plain Boca layout ----------
desprayName 					:= 'PropertyInfo_Export_Boca_Base_'+dateString+'.csv';
EXPORT_DS							:= PII.Files.BOCA_BASE_SF_DS;
//---------------------------------------------------------------------
lzFilePathGatewayFile	:= PII.Constants.SourcePathForPIICSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);

