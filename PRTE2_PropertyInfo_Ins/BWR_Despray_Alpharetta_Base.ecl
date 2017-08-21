/* **********************************************************************************
	PRTE2_PropertyInfo_Ins.BWR_Despray_Alpharetta_Base
 - despray the Property Info base file for editing.
March 2017 - just added a sort which can help comparing two CSVs to each other.
---------------------------------------------------------------------
	NOTE: The CSV name "PropertyInfo_V2" is to indicate we totally altered
	the main layouts removed gateway and editable_spreadsheet layouts
********************************************************************************** */

IMPORT PRTE2_Common, ut;
IMPORT PRTE2_PropertyInfo_Ins as PII;
#workunit('name', 'ALPHA PRCT PropertyInfo Despray');

dateString := PRTE2_Common.Constants.TodayString;
LandingZoneIP 				:= PII.Constants.LandingZoneIP;
TempCSV								:= PII.Files.Alpha_Spray_Name;
//----------- Prepare the Alpharetta Export_DS desired ----------------
// desprayName 							:= 'PropertyInfo_V3_Prod_'+dateString+'.csv';
// EXPORT_DS									:= SORT(PII.Files.PII_ALPHA_BASE_SF_DS_Prod,property_rid);
desprayName 							:= 'PropertyInfo_V3_AfterAdds_'+dateString+'.csv';
EXPORT_DS 								:= SORT(PII.Files.PII_ALPHA_BASE_SF_DS,property_rid);
// new layouts coming when we add people info into CSV to make editing easier
//---------------------------------------------------------------------
lzFilePathFile	:= PII.Constants.SourcePathForPIICSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathFile);


//---------------------------------------------------------------------
// OBSOLETE - we previously had the "gateway" layout and the editable (left off code groups 21-85)
// Now that we transformed all those code groups into actual field values, we just use the main "expanded" file layout (above)
// PII_Base_SF_DS				:= PII.Files.PII_ALPHA_BASE_SF_DS_Prod;
// EXPORT_DS 						:= PROJECT(PII_Base_SF_DS,PII.Transforms.Gateway_Reduce(LEFT));
//---------------------------------------------------------------------

