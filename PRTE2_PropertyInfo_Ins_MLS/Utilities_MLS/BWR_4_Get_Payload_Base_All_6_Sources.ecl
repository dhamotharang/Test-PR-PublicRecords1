/* ************************************************************************************************************************
PRTE2_PropertyInfo_Ins_MLS.Utilities.BWR_4_Get_Payload_Base_All_6_Sources

**********************************************************************************************
***** MLS CONVERSION NOTES:
This is a one time fix to despray all 4 record sources instead of the old 2 record sources.
After this PRTE2_PropertyInfo_Ins_MLS.Get_Payload will change quite a bit with less to do.
Also while I'm doing this create logic to add "E" and "F" records, then despray all 6 record types
**********************************************************************************************
************************************************************************************************************************ */

IMPORT PRTE2_Common, ut;
IMPORT PRTE2_PropertyInfo_Ins_PreMLS;
IMPORT PRTE2_PropertyInfo_Ins_MLS;

#workunit('name', 'ALPHA PRCT PropertyInfo Despray');

dateString 		:= PRTE2_Common.Constants.TodayString;
LandingZoneIP 	:= PRTE2_PropertyInfo_Ins_PreMLS.Constants.LandingZoneIP;
TempCSV			:= PRTE2_PropertyInfo_Ins_PreMLS.Files.Alpha_Spray_Name;
appendIfCSZ 	:= PRTE2_Common.Functions.appendIfCSZ;

//----------- Prepare the Alpharetta Export_DS desired ----------------
desprayName 	:= 'PropertyInfo_MLS_Prod_'+dateString+'.csv';
PropInfo_ABCD_0 		:= SORT(PRTE2_PropertyInfo_Ins_MLS.Utilities_MLS.proc_Get_Payload_CSV_Layout.All_Expanded,property_street_address,property_city_state_zip,vendor_source);
//---------------------------------------------------------------------
// NOTE: The following is temporary - BC2.1 Data3 will give better fields to fill.
//---------------------------------------------------------------------
PropInfo_ABCD := PROJECT(PropInfo_ABCD_0, TRANSFORM({PropInfo_ABCD_0},
																SELF.property_city_state_zip := appendIfCSZ(LEFT.v_city_name,LEFT.st,LEFT.zip);
																apnFake := HASH(LEFT.property_street_address,SELF.property_city_state_zip,LEFT.geo_lat,LEFT.geo_long);
																SELF.fares_unformatted_apn := (string45)apnFake;
																SELF.apn_number := (string45)apnFake;
																SELF := LEFT;
																));
//---------------------------------------------------------------------
PropInfo_E := PRTE2_PropertyInfo_Ins_MLS.Utilities_MLS.fn_add_Type_E(PropInfo_ABCD(vendor_source='D'));
//---------------------------------------------------------------------
PropInfo_F := PRTE2_PropertyInfo_Ins_MLS.Utilities_MLS.fn_add_Type_F(PropInfo_E, PropInfo_ABCD);

//---------------------------------------------------------------------
PropInfo_ABCDEF_1 := PropInfo_ABCD+PropInfo_E+PropInfo_F;
// ----- Renumber RIDs after all is done ------------------------------ 
PropInfo_ABCDEF_1  Resequence_Rids (PropInfo_ABCDEF_1 L, Integer C) := TRANSFORM
		self.property_rid   := (unsigned) PRTE2_PropertyInfo_Ins_MLS.Constants.ALPHA_RID_CONSTANT + C;
		SELF := L;
		SELF := [];
END;		
PropInfo_ABCDEF 	:= PROJECT(PropInfo_ABCDEF_1, Resequence_Rids (Left, Counter));
//---------------------------------------------------------------------

EXPORT_DS := SORT(PropInfo_ABCDEF,fares_unformatted_apn,vendor_source);		// We could also do this by fares_unformatted_apn

ViewLayout := RECORD
  unsigned6 property_rid;
  unsigned4 dt_vendor_last_reported;
  string8 tax_sortby_date;
  string8 deed_sortby_date;
  string1 vendor_source;
  string100 property_street_address;
  string50 property_city_state_zip;
  string45 fares_unformatted_apn;
  string45 apn_number;
  string5 src_apn_number;	
END;
OUTPUT(PROJECT(EXPORT_DS,viewLayout));
//---------------------------------------------------------------------
lzFilePathFile	:= PRTE2_PropertyInfo_Ins_PreMLS.Constants.SourcePathForPIICSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathFile);

