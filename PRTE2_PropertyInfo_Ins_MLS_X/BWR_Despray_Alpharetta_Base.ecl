/* ************************************************************************************************************************
**********************************************************************************************
***** MLS CONVERSION NOTES:
ACTIVATE THE NEW CSV NAME AND REMOVE THE OLD V3 NAME (lINE 26-27)
// desprayName 		:= 'PropertyInfo_MLS_Prod_'+dateString+'.csv';

**********************************************************************************************
************************************************************************************************************************ */

IMPORT PRTE2_Common, ut;
IMPORT PRTE2_PropertyInfo_Ins_MLS as PII;
#workunit('name', 'ALPHA PRCT PropertyInfo Despray');

dateString 			:= PRTE2_Common.Constants.TodayString;
LandingZoneIP 		:= PII.Constants.LandingZoneIP;
TempCSV				:= PII.Files.Alpha_Spray_Name;
//----------- Prepare the Alpharetta Export_DS desired ----------------
// desprayName 		:= 'PropertyInfo_MLS_Prod_'+dateString+'.csv';
// EXPORT_DS0			:= SORT(PII.Files.PII_ALPHA_BASE_SF_DS_Prod,property_rid);
// desprayName 		:= 'PropertyInfo_MLS_AfterAdds_'+dateString+'.csv';
desprayName 		:= 'PropertyInfo_MLS_Dev_'+dateString+'.csv';
EXPORT_DS0 			:= SORT(PII.Files.PII_ALPHA_BASE_SF_DS(property_street_address<>''),property_rid);
//---------------------------------------------------------------------
appendIfCSZ := PRTE2_Common.Functions.appendIfCSZ;
EXPORT_DS1 := PROJECT(EXPORT_DS0, TRANSFORM({EXPORT_DS0},
																SELF.property_city_state_zip := appendIfCSZ(LEFT.v_city_name,LEFT.st,LEFT.zip);
																SELF := LEFT;
																));																
EXPORT_DS := SORT(EXPORT_DS1,fares_unformatted_apn,vendor_source);
//---------------------------------------------------------------------
lzFilePathFile	:= PII.Constants.SourcePathForPIICSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathFile);


//---------------------------------------------------------------------
// OBSOLETE - we previously had the "gateway" layout and the editable (left off code groups 21-85)
// Now that we transformed all those code groups into actual field values, we just use the main "expanded" file layout (above)
// PII_Base_SF_DS				:= PII.Files.PII_ALPHA_BASE_SF_DS_Prod;
// EXPORT_DS 						:= PROJECT(PII_Base_SF_DS,PII.Transforms.Gateway_Reduce(LEFT));
//---------------------------------------------------------------------

