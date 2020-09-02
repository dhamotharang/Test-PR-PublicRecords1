/* **********************************************************************************************************
 Take the existing new data, collect sources ABCD and then source E (throw away the old F records)
 then use the fn_add_Type_F() to generate new F records using the E as a clone, and ABCD&E records as the sources
********************************************************************************************************** */
IMPORT PRTE2_PropertyInfo_Ins_MLS,PRTE2_Common,PRTE2_PropertyInfo_Ins_PreMLS;

// READ THE DEV BASE FILE SINCE WE SAVED STEP 1 and 2 there.
DS_Prop := SORT(PRTE2_PropertyInfo_Ins_MLS.Files.PII_ALPHA_BASE_SF_DS,property_rid);
setABCD := ['A','B','C','D'];
PropInfo_ABCD := DS_Prop(vendor_source IN setABCD);
PropInfo_E := DS_Prop(vendor_source = 'E');
// Junk_PropInfo_F := DS_Prop(vendor_source = 'F');     // just here to note that we're throwing away and rebuilding the F records.

// *********************************************************************************************
// this uses PII_ALPHA_BASE_SF_DS so if I change to using PROD we need to change it in here too
PropInfo_F := PRTE2_PropertyInfo_Ins_MLS.Utilities_MLS.fn_add_Type_F(PropInfo_E, DS_Prop);
// *********************************************************************************************
PropInfo_ABCDEF_0a := PropInfo_ABCD+PropInfo_E+PropInfo_F;
PropInfo_ABCDEF_0b := DISTRIBUTE(PropInfo_ABCDEF_0a,HASH(fares_unformatted_apn));
PropInfo_ABCDEF_1 := SORT(PropInfo_ABCDEF_0b,fares_unformatted_apn,vendor_source,local);
//---------------------------------------------------------------------
// ----- Renumber RIDs after all is done ------------------------------ 
PropInfo_ABCDEF_1  Resequence_Rids (PropInfo_ABCDEF_1 L, Integer C) := TRANSFORM
		self.property_rid   := (unsigned) PRTE2_PropertyInfo_Ins_MLS.Constants.ALPHA_RID_CONSTANT + C;
		SELF := L;
		SELF := [];
END;

PropInfo_ABCDEF := PROJECT(PropInfo_ABCDEF_1, Resequence_Rids (Left, Counter));
//---------------------------------------------------------------------

EXPORT_DS := SORT(PropInfo_ABCDEF,fares_unformatted_apn,vendor_source);

ViewLayout := RECORD
  unsigned6 property_rid;
  string45 fares_unformatted_apn;
  string1 vendor_source;
  unsigned4 dt_vendor_last_reported;
  string100 property_street_address;
  string50 property_city_state_zip;
  string45 apn_number;
  string5 src_apn_number;	
END;
OUTPUT('COUNTS:'+COUNT(DS_Prop)+' '+COUNT(EXPORT_DS));
// OUTPUT(CHOOSEN(PROJECT(EXPORT_DS,viewLayout),100));
// -------------------------------------------------------------------------------------
dateString 		:= PRTE2_Common.Constants.TodayString;
desprayName 	:= 'PropertyInfo_3_Refill_Best_'+dateString+'.csv';
lzFilePathFile	:= PRTE2_PropertyInfo_Ins_PreMLS.Constants.SourcePathForPIICSV + desprayName;
LandingZoneIP 	:= PRTE2_PropertyInfo_Ins_PreMLS.Constants.LandingZoneIP;
TempCSV			:= PRTE2_PropertyInfo_Ins_PreMLS.Files.Alpha_Spray_Name;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathFile);

// -------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------
// Files := PRTE2_PropertyInfo_Ins_MLS.Files;
// NewDataDS := DISTRIBUTE(EXPORT_DS,HASH(fares_unformatted_apn,property_rid));
// buildPIIBase := PRTE2_Common.Promote_Supers.mac_SFBuildProcess(NewDataDS, Files.PII_ALPHA_BASE_SF);
// SEQUENTIAL(buildPIIBase);
// -------------------------------------------------------------------------------------