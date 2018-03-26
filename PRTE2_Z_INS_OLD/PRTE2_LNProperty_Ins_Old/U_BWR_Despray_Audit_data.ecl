//---------------------------------------------------------------------
// PRTE2_LNProperty.U_BWR_Despray_Audit_data
//---------------------------------------------------------------------

IMPORT PRTE2_LNProperty as LNP;
IMPORT PRTE2_X_Ins_PropertyScramble as SCR;
IMPORT PRTE2_Common, ut;
#workunit('name', 'Boca CT LNProperty Despray');

dateString	:= ut.GetDate+'';

TempCSV							:= LNP.Files.LNP_CSV_FILE + '::' +  WORKUNIT;
// ------------ despray the alpharetta audit file in expanded layout -------------
desprayName 				:= 'LN_PropertyV2_Audit_'+dateString+'.csv';
EXPORT_DS0					:= LNP.Files.Alpha_Audit_SF_DS;
// ------------ despray the Samples from Boca Base in expanded layout -------------
// desprayName 				:= 'LN_PropertyV2_Boca_Samples_'+dateString+'.csv';
// EXPORT_DS0 					:= LNP.Files.BOCA_PROD_SAMPLE_DATA;
EXPORT_DS						:= SORT(EXPORT_DS0,did,fid_type,ln_fares_id,lname,fname,zip,source_code);
LandingZoneIP 			:= LNP.Constants.LandingZoneIP;
lzFilePathGatewayFile	:= LNP.Constants.SourcePathForLNPCSV + desprayName;
PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);