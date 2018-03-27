//---------------------------------------------------------------------
// PRTE2_LNProperty.V_Refresh_Data_U_Despray
//---------------------------------------------------------------------
IMPORT PRTE2_LNProperty as LNP;
IMPORT PRTE2_Common, ut;
#workunit('name', 'Boca CT LNProperty Despray');

dateString	:= ut.GetDate;
TempCSV							:= LNP.Files.LNP_CSV_FILE + '::' +  WORKUNIT;

// desprayName 				:= 'LN_PropertyV2_Base_Repairs_BatPlusPreFix_DEV_'+dateString+'.csv';
// EXPORT_DS						:= SORT(LNP.V_Refresh_Data_Base_Files.BaseBatchInPlusCleaningDS,DID);
desprayName 				:= 'LN_PropertyV2_Base_Repairs_BatchInPlusCodeFix_DEV_'+dateString+'.csv';
EXPORT_DS						:= SORT(LNP.V_Refresh_Data_Base_Files.BaseBatchInRefreshenedDS,DID);
testStrValue (String inStr) := function
	return if(length(Trim(inStr))>0,1,0);
end;
OUTPUT(COUNT(EXPORT_DS));
OUTPUT(SUM(EXPORT_DS,testStrValue(assess_garage_type_code)));
OUTPUT(SUM(EXPORT_DS,testStrValue(assess_parking_no_of_cars)));

LandingZoneIP 			:= LNP.Constants.LandingZoneIP;
lzFilePathGatewayFile	:= LNP.Constants.SourcePathForLNPCSV + desprayName;
PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);
