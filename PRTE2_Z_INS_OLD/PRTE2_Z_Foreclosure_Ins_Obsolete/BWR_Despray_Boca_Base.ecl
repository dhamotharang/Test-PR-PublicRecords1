// PRTE2_Foreclosure.BWR_Despray_Boca_Base -
//  - despray the Boca Base CSV

IMPORT PRTE2_Foreclosure as FRCL;
IMPORT PRTE2_Common, ut;
#workunit('name', 'Boca CT Foreclosures Despray');

dateString	:= ut.GetDate+'';
LandingZoneIP 				:= FRCL.Constants.LandingZoneIP;
TempCSV								:= FRCL.Files.FRCL_CSV_FILE + '::' +  WORKUNIT;

desprayName 					:= 'Foreclosures_Boca_Base_'+dateString+'.csv';
EXPORT_DS							:= FRCL.Files.BOCA_BASE_SF_DS;
lzFilePathGatewayFile	:= FRCL.Constants.SourcePathForBOCACSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);