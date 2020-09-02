/* ************************************************************************************************************************
PRTE2_PropertyInfo_Ins_MLS\Utilities_MLS\BWR_5_Get_Payload_Adding_G.ecl

**********************************************************************************************
***** MLS CONVERSION NOTES:
This adds a final source G onto what the BWR_4_Get_Payload_Base_All_6_Sources already produced
So just read in the currect base file, and generate new G records from cloning A records
The G records needs to not have any E or F sources in them - so we'll only use A,B,C,D
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
desprayName 	:= 'PropertyInfo_MLS_Prod_Plus_G_'+dateString+'.csv';
PropInfo_ABCDEF_0 		:= SORT(PRTE2_PropertyInfo_Ins_MLS.Files.PII_ALPHA_BASE_SF_DS,property_street_address,property_city_state_zip,vendor_source);
//---------------------------------------------------------------------
// NOTE: The following is temporary - BC2.1 Data3 will give better fields to fill.
//---------------------------------------------------------------------
PropInfo_ABCDEF := PROJECT(PropInfo_ABCDEF_0, TRANSFORM({PropInfo_ABCDEF_0},
																SELF.property_city_state_zip := appendIfCSZ(LEFT.v_city_name,LEFT.st,LEFT.zip);
																apnFake := HASH(LEFT.property_street_address,SELF.property_city_state_zip,LEFT.geo_lat,LEFT.geo_long);
																SELF.fares_unformatted_apn := (string45)apnFake;
																SELF.apn_number := (string45)apnFake;
																SELF := LEFT;
																));
PropInfo_ABCD := PropInfo_ABCDEF(vendor_source in ['A','B','C','D']);
PropInfo_A := PropInfo_ABCDEF(vendor_source='A');
//---------------------------------------------------------------------
PropInfo_G := PRTE2_PropertyInfo_Ins_MLS.Utilities_MLS.fn_add_Type_G(PropInfo_A, PropInfo_ABCD);
OUTPUT('compare: '+COUNT(PropInfo_A)+' '+COUNT(PropInfo_G));
//---------------------------------------------------------------------
PropInfo_ABCDEFG_1 := PropInfo_ABCDEF+PropInfo_G;
// ----- Renumber RIDs after all is done ------------------------------ 
PropInfo_ABCDEFG_1  Resequence_Rids (PropInfo_ABCDEFG_1 L, Integer C) := TRANSFORM
		self.property_rid   := (unsigned) PRTE2_PropertyInfo_Ins_MLS.Constants.ALPHA_RID_CONSTANT + C;
		SELF := L;
		SELF := [];
END;		
PropInfo_ABCDEFG 	:= PROJECT(PropInfo_ABCDEFG_1, Resequence_Rids (Left, Counter));
OUTPUT('compare: '+COUNT(PropInfo_ABCDEF)+' '+COUNT(PropInfo_ABCDEFG));
//---------------------------------------------------------------------

EXPORT_DS := SORT(PropInfo_ABCDEFG,fares_unformatted_apn,vendor_source);		// We could also do this by fares_unformatted_apn

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

