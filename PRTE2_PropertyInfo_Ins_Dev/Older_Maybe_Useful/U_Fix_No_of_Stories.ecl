//---------------------------------------------------------------------
// Take the no_of_stories field and round it up to an integer
//---------------------------------------------------------------------

IMPORT PRTE2_Common, ut;
IMPORT PRTE2_PropertyInfo as PII;
IMPORT PRTE2_X_Ins_PropertyScramble as SCR;
#workunit('name', 'Boca CT PropertyInfo Despray');

dateString := ut.GetDate;
LandingZoneIP 				:= PII.Constants.LandingZoneIP;
TempCSV								:= PII.Files.PII_CSV_FILE + '::' +  WORKUNIT;
desprayName 					:= 'PropertyInfo_V2_Prod_Fix_NStories_'+dateString+'.csv';
EXPORT_DS0				:= PII.Files.PII_ALPHA_BASE_SF_DS_Prod;
//---------------------------------------------------------------------
lzFilePathGatewayFile	:= PII.Constants.SourcePathForPIICSV + desprayName;

EXPORT_DS0 xformRounding(EXPORT_DS0 L) := TRANSFORM
	newValue := (STRING) ROUNDUP((REAL)L.no_of_stories);
	SELF.no_of_stories := IF(newValue='0','',newValue);
	SELF := L;
END;

EXPORT_DS := PROJECT(EXPORT_DS0,xformRounding(LEFT));

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);
