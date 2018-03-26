/* **************************************************************************************************************
*************** All of the "Fix-Code" logic is made obsolete because we went to the more advanced method
*************** of doing full refreshes from production - see "V_Refresh_*" attributes
************************************************************************************************************** */

// Despray the LNProperty file for Alpharetta but during the despray, fix some of the code fields

IMPORT PRTE2_LNProperty as LNP;
IMPORT PRTE2_Common, ut;
#workunit('name', 'Boca CT LNProperty Despray');

dateString	:= ut.GetDate;

TempCSV							:= LNP.Files.LNP_CSV_FILE + '::' +  WORKUNIT;
LandingZoneIP 			:= LNP.Constants.LandingZoneIP;

desprayName 				:= 'LN_Property_CodeFix_'+dateString+'.csv';
LNP_Base_SF_DS			:= LNP.Files.LNP_Scramble_SF_DS_Prod;
lzFilePathGatewayFile	:= LNP.Constants.SourcePathForLNPCSV + desprayName;

EXPORT_DS2 					:= PROJECT(LNP_Base_SF_DS, LNP.U_Fix_Alpha_Codes_1(LEFT));
EXPORT_DS0 					:= PROJECT(EXPORT_DS2, LNP.Transforms.Gateway_Reduce(LEFT));
EXPORT_DS						:= SORT(EXPORT_DS0, did,fid_type,ln_fares_id,lname,fname,zip);

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);