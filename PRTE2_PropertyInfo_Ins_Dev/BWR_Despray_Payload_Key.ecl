/* ************************************************************************
Despray the Address (Payload) key for review only - DO NOT re-spray it as base file.
This is just to hand someone the final set of records INCLUDING all 4 source records
************************************************************************
====>>> NOTE The PRCT PropertyInfo Build doesn't create SF - need TODO!
Till then - have to set up the fileVersion to make it work
************************************************************************ */

IMPORT PRTE2_Common,PRTE2_PropertyInfo_Ins,PropertyCharacteristics, ut;

// ---------- Stuff we need to fill in for each test -------------
keyFileVersion := '20180518';
foreignProd := PRTE2_Common.Constants.foreign_prod;
CTRidKeyName := '~'+foreignProd+'prte::key::propertyinfo::'+keyFileVersion+'::rid';
dateString := PRTE2_Common.Constants.TodayString;

// ----------------------------------------------------------------------------------------------------------
RidKeyDef 	:= PropertyCharacteristics.Key_PropChar_RID;
EXPORT_DS0	:= Index(RidKeyDef, CTRidKeyName);			// The above key definitions point to production names but we'll override the name here.
EXPORT_DS 	:= SORT(EXPORT_DS0,Property_Street_Address,Property_City_State_Zip,vendor_source);
// ----------------------------------------------------------------------------------------------------------
LandingZoneIP 				:= PRTE2_PropertyInfo_Ins.Constants.LandingZoneIP;
TempCSV								:= PRTE2_PropertyInfo_Ins.Files.Alpha_Spray_Name;
desprayName 					:= 'PropertyInfo_Payload_Key_Prod_ForReview_'+dateString+'.csv';
// appendIfCSZ := PRTE2_Common.Functions.appendIfCSZ;
// EXPORT_DS := PROJECT(EXPORT_DS0, TRANSFORM({EXPORT_DS0},
																// SELF.property_city_state_zip := appendIfCSZ(LEFT.v_city_name,LEFT.st,LEFT.zip);
																// SELF := LEFT;
																// ));
//---------------------------------------------------------------------
lzFilePathFile	:= PRTE2_PropertyInfo_Ins.Constants.SourcePathForPIICSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathFile);

