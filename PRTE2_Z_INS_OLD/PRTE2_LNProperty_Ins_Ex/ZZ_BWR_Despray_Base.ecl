// PRTE2_LNProperty.BWR_Despray_Base 

IMPORT PRTE2_LNProperty as LNP;
IMPORT PRTE2_PropertyScramble as SCR;
IMPORT PRTE2_Common, ut;
#workunit('name', 'Boca CT LNProperty Despray');

dateString	:= ut.GetDate;

TempCSV							:= LNP.Files.LNP_CSV_FILE + '::' +  WORKUNIT;
LandingZoneIP 			:= LNP.Constants.LandingZoneIP;

// desprayName 				:= 'LN_Property_Export_DEV_'+dateString+'.csv';
// LNP_Base_SF_DS			:= LNP.Files.LNP_Scramble_SF_DS;
desprayName 				:= 'LN_Property_Export_PROD_'+dateString+'.csv';
LNP_Base_SF_DS			:= LNP.Files.LNP_Scramble_SF_DS_Prod;
EXPORT_DS 					:= PROJECT(LNP_Base_SF_DS, LNP.Constants.Gateway_Reduce(LEFT));
lzFilePathGatewayFile	:= LNP.Constants.SourcePathForLNPCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);