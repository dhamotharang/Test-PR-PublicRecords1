// PRTE2_Foreclosure.BWR_Despray_Base -
//  - despray the XRef CSV in the Full XRef Format
IMPORT PRTE2_Foreclosure as FRCL;
IMPORT PRTE2_Common, ut;
#workunit('name', 'Boca CT Foreclosures Despray');

dateString	:= ut.GetDate;
LandingZoneIP 				:= FRCL.Constants.LandingZoneIP;
TempCSV								:= FRCL.Files.FRCL_CSV_FILE + '::' +  WORKUNIT;

// desprayName 					:= 'Foreclosures_Alpha_Dev'+dateString+'.csv';
// FRCL_Base_SF_DS				:= FRCL.Files.Foreclosures_50k_Scrambled_SF_DS;
desprayName 					:= 'Foreclosures_Alpha_Prod_'+dateString+'.csv';
FRCL_Base_SF_DS				:= FRCL.Files.Foreclosures_50k_Scrambled_SF_DS_Prod;

EXPORT_DS := PROJECT(FRCL_Base_SF_DS,FRCL.Transforms.Gateway_Reduce(LEFT));
lzFilePathGatewayFile	:= FRCL.Constants.SourcePathForFRCLCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);