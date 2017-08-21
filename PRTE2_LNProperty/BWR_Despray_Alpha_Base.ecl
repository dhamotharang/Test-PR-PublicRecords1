//---------------------------------------------------------------------
// PRTE2_LNProperty.BWR_Despray_Alpha_Base 
//---------------------------------------------------------------------
IMPORT PRTE2_LNProperty as LNP;
IMPORT PRTE2_Common, ut;
#workunit('name', 'Boca CT LNProperty Despray');

dateString	:= ut.GetDate;
TempCSV							:= LNP.Files.LNP_CSV_FILE;

// Various files we might want to despray (Dev, Prod) [Dev and Prod need to be reduced]
desprayName 				:= 'LN_PropertyV2_Base_Refreshed_DEV_'+dateString+'.csv';
LNP_Base_Expanded	:= LNP.Files.ALP_LNP_SF_DS;
// desprayName 				:= 'LN_PropertyV2_Base_Refreshed_PROD_'+dateString+'.csv';
// LNP_Base_Expanded		:= LNP.Files.ALP_LNP_SF_DS_Prod;
EXPORT_DS						:= SORT(LNP_Base_Expanded, did,fid_type,ln_fares_id,lname,fname,zip);

LandingZoneIP 			:= LNP.Constants.LandingZoneIP;
lzFilePathGatewayFile	:= LNP.Constants.SourcePathForLNPCSV + desprayName;
PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);

//---------------------------------------------------------------------
// NOTE: The CSV name "Refreshed" is to indicate this data is post-V_Refresh process
// fixing various code fields...  Remaining work?
// 1. Finally when all codes are confirmed, remove the description fields.
//---------------------------------------------------------------------
// SEE:
// 			PRTE2_LNProperty.U_Fix_Alpha_Codes_1
// 			PRTE2_LNProperty.U_Fix_Alpha_Codes_1_BWR
//---------------------------------------------------------------------
