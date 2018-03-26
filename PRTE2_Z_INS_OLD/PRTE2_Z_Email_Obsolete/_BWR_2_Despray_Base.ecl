// PRTE2_LNProperty.BWR_Despray_Alpha_Base 
// TEMP Fix ... obsolete when PRTE2_Email_Data is complete

IMPORT PRTE2_Email as EMAIL;
IMPORT PRTE2_Common, ut;
#workunit('name', 'Boca CT Despray');
Add_Foreign_prod					:= PRTE2_Common.Constants.Add_Foreign_prod;	// a function

dateString	:= ut.GetDate;

TempCSV							:= '~TEMP::BAP::' +  WORKUNIT;
LandingZoneIP	:= PRTE2_Common.Constants.EDATA11;
desprayName 				:= 'Email_Base_PROD_'+dateString+'.csv';
FileName := Add_Foreign_prod(EMAIL._constants.baseSuperFileString);
EXPORT_DS			:= DATASET ( FileName, EMAIL._layouts.base, thor);
lzFilePathGatewayFile	:= '/load01/prct2/email/'+ desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);