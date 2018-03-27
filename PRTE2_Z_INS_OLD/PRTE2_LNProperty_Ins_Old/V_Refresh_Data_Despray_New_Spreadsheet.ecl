//---------------------------------------------------------------------
// PRTE2_LNProperty.V_Refresh_Data_Despray_New_Spreadsheet
//---------------------------------------------------------------------

IMPORT PRTE2_LNProperty as LNP;
IMPORT PRTE2_Common, ut;
#workunit('name', 'Boca CT LNProperty Despray');

dateString	:= ut.GetDate;
TempCSV							:= LNP.Files.LNP_CSV_FILE + '::' +  WORKUNIT;

desprayName 		:= 'LN_PropertyV2_Base_Data_Refresh_DEV_'+dateString+'.csv';
DedupedData 			:= DEDUP(SORT(LNP.V_Refresh_Data_Base_Files.BaseBatchInRefreshenedDS,ln_fares_id),ln_fares_id);
RefreshedData		:= SORT(DedupedData, did, fid_type, ln_fares_id, lname, fname, zip);
EXPORT_DS				:= PROJECT(RefreshedData,LNP.Layouts.batch_in);

LandingZoneIP 	:= LNP.Constants.LandingZoneIP;
lzFilePathGatewayFile	:= LNP.Constants.SourcePathForLNPCSV + desprayName;
PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);
