/* ************************************************************************
 * This function searches the Header and Fast Header to get unique				*
 * addresses seen within the last 5 years.  These results then get used		*
 * within Phone_Shell.Search_PhonesPlus and Phone_Shell.Search_EDA.				*
 **************************************************************************
 * Adapted from Risk_Indicators.iid_getHeader                             *
 ************************************************************************ */
 
IMPORT Drivers, Doxie, Header, Header_Quick, MDR, Phone_Shell, Risk_Indicators, UT, STD, Suppress;

todays_date := (string) STD.Date.Today();

EXPORT Phone_Shell.Layouts.layoutUniqueAddresses Search_Header_Unique_Addresses(DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, UNSIGNED1 GLBPurpose, UNSIGNED1 DPPAPurpose, STRING50 DataRestrictionMask, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION
	
  Layout_Unique_Addresses_CCPA := RECORD
  unsigned4 global_sid;
  Phone_Shell.Layouts.layoutUniqueAddresses;
  END;
  
  
  fullHeader_unsuppressed := JOIN(Input, Doxie.Key_Header,
													LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.s_DID) AND
													// We only want unique addresses to search by within the past 6 months
													(LEFT.Clean_Input.Prim_Range <> RIGHT.Prim_Range OR LEFT.Clean_Input.Predir <> RIGHT.Predir OR LEFT.Clean_Input.Prim_Name <> RIGHT.Prim_Name OR 
													LEFT.Clean_Input.Addr_Suffix <> RIGHT.Suffix OR LEFT.Clean_Input.Sec_Range <> RIGHT.Sec_Range OR LEFT.Clean_Input.Zip5 <> RIGHT.ZIP) AND
													((RIGHT.dt_last_seen <> 0 AND RIGHT.dt_last_seen >= (INTEGER)(ut.date_math(todays_date, -1 * Phone_Shell.Constants.HeaderSearchDate)[1..6]))
															OR
													(RIGHT.dt_last_seen = 0 AND RIGHT.dt_vendor_last_reported >= (INTEGER)(ut.date_math(todays_date, -1 * Phone_Shell.Constants.HeaderSearchDate)[1..6]))) AND // check date, only check vendor date if last seen date = 0
													// Make sure we can use this source in a Non-FCRA Scoring Product
													RIGHT.src IN Risk_Indicators.iid_constants.setPhillipMorrisAllowedHeaderSources AND
													RIGHT.src IN Risk_Indicators.iid_constants.setExperianBatchAllowedHeaderSources AND
													RIGHT.src NOT IN Risk_Indicators.iid_constants.masked_header_sources(DataRestrictionMask, FALSE) AND													
													(Header.isPreGLB(RIGHT) OR Risk_Indicators.iid_constants.glb_ok(GLBPurpose, FALSE)) AND 
													(~mdr.Source_is_DPPA(RIGHT.src) 
															OR
													(Risk_Indicators.iid_constants.dppa_ok(DPPAPurpose, FALSE) AND Drivers.state_dppa_ok(Header.translateSource(RIGHT.src), DPPAPurpose, RIGHT.src))) AND
													~Risk_Indicators.iid_constants.filtered_source(RIGHT.src, RIGHT.st), 
													TRANSFORM(Layout_Unique_Addresses_CCPA,	SELF.seq := LEFT.Clean_Input.seq; 
																														SELF.FirstName := LEFT.Clean_Input.FirstName;
																														SELF.LastName := LEFT.Clean_Input.LastName;
																														SELF.HomePhone := LEFT.Clean_Input.HomePhone;
																														SELF.WorkPhone := LEFT.Clean_Input.WorkPhone;
																														SELF.DateOfBirth := LEFT.Clean_Input.DateOfBirth;
																														SELF.SSN := LEFT.Clean_Input.SSN;
																														SELF.Prim_Range := RIGHT.Prim_Range;
																														SELF.Predir := RIGHT.Predir;
																														SELF.Prim_Name := RIGHT.Prim_Name;
																														SELF.Addr_Suffix := RIGHT.Suffix;
																														SELF.Sec_Range := RIGHT.Sec_Range;
																														SELF.Zip5 := RIGHT.ZIP;
																														SELF.City := RIGHT.City_Name;
																														SELF.State := RIGHT.St;
																														SELF.DID := RIGHT.s_DID;
                                                                                                                        SELF.global_sid := RIGHT.global_sid;
																														SELF.DateLastSeen := (STRING8)IF(RIGHT.dt_last_seen <> 0, RIGHT.dt_last_seen, RIGHT.dt_vendor_last_reported);
																														SELF := RIGHT), 
													KEEP(UT.Limits.HEADER_PER_DID), ATMOST(UT.Limits.HEADER_PER_DID));
													
	fullHeader := Suppress.Suppress_ReturnOldLayout(fullHeader_unsuppressed, mod_access, Phone_Shell.Layouts.layoutUniqueAddresses);
	
	fastHeader_unsuppressed := JOIN(Input, Header_Quick.Key_DID,
													LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.DID) AND
													// We only want unique addresses to search by within the past 6 months
													(LEFT.Clean_Input.Prim_Range <> RIGHT.Prim_Range OR LEFT.Clean_Input.Predir <> RIGHT.Predir OR LEFT.Clean_Input.Prim_Name <> RIGHT.Prim_Name OR 
													LEFT.Clean_Input.Addr_Suffix <> RIGHT.Suffix OR LEFT.Clean_Input.Sec_Range <> RIGHT.Sec_Range OR LEFT.Clean_Input.Zip5 <> RIGHT.ZIP) AND
													((RIGHT.dt_last_seen <> 0 AND RIGHT.dt_last_seen >= (INTEGER)(ut.date_math(todays_date, -1 * Phone_Shell.Constants.HeaderSearchDate)[1..6]))
															OR
													(RIGHT.dt_last_seen = 0 AND RIGHT.dt_vendor_last_reported >= (INTEGER)(ut.date_math(todays_date, -1 * Phone_Shell.Constants.HeaderSearchDate)[1..6]))) AND // check date, only check vendor date if last seen date = 0
													// Make sure we can use this source in a Non-FCRA Scoring Product
													RIGHT.src IN Risk_Indicators.iid_constants.setPhillipMorrisAllowedHeaderSources AND
													RIGHT.src IN Risk_Indicators.iid_constants.setExperianBatchAllowedHeaderSources AND
													RIGHT.src NOT IN Risk_Indicators.iid_constants.masked_header_sources(DataRestrictionMask, FALSE) AND													
													(Header.isPreGLB(RIGHT) OR Risk_Indicators.iid_constants.glb_ok(GLBPurpose, FALSE)) AND 
													(~mdr.Source_is_DPPA(RIGHT.src) 
															OR
													(Risk_Indicators.iid_constants.dppa_ok(DPPAPurpose, FALSE) AND Drivers.state_dppa_ok(Header.translateSource(RIGHT.src), DPPAPurpose, RIGHT.src))) AND
													~Risk_Indicators.iid_constants.filtered_source(RIGHT.src, RIGHT.st), 
													TRANSFORM(Layout_Unique_Addresses_CCPA,	SELF.seq := LEFT.Clean_Input.seq; 
																														SELF.FirstName := LEFT.Clean_Input.FirstName;
																														SELF.LastName := LEFT.Clean_Input.LastName;
																														SELF.HomePhone := LEFT.Clean_Input.HomePhone;
																														SELF.WorkPhone := LEFT.Clean_Input.WorkPhone;
																														SELF.DateOfBirth := LEFT.Clean_Input.DateOfBirth;
																														SELF.SSN := LEFT.Clean_Input.SSN;
																														SELF.Prim_Range := RIGHT.Prim_Range;
																														SELF.Predir := RIGHT.Predir;
																														SELF.Prim_Name := RIGHT.Prim_Name;
																														SELF.Addr_Suffix := RIGHT.Suffix;
																														SELF.Sec_Range := RIGHT.Sec_Range;
																														SELF.Zip5 := RIGHT.ZIP;
																														SELF.City := RIGHT.City_Name;
																														SELF.State := RIGHT.St;
																														SELF.DID := RIGHT.DID;
                                                                                                                        SELF.global_sid := RIGHT.global_sid;
																														SELF.DateLastSeen := (STRING8)IF(RIGHT.dt_last_seen <> 0, RIGHT.dt_last_seen, RIGHT.dt_vendor_last_reported);
																														SELF := RIGHT), 
													KEEP(UT.Limits.HEADER_PER_DID), ATMOST(UT.Limits.HEADER_PER_DID));
													
		fastHeader := Suppress.Suppress_ReturnOldLayout(fastHeader_unsuppressed, mod_access, Phone_Shell.Layouts.layoutUniqueAddresses);

	// Don't dedup by Sec_Range, just keep the version that has Apartment number populated to avoid finding phone numbers for the entire apartment complex.
	combinedUniqueHeaders := DEDUP(SORT(fullHeader + fastHeader, seq, DID, Prim_Range, Predir, Prim_Name, Addr_Suffix, -Sec_Range, Zip5, -((INTEGER)DateLastSeen)), seq, DID, Prim_Range, Predir, Prim_Name, Addr_Suffix, Zip5);
	
	// OUTPUT(fullHeader, NAMED('fullHeader'));
	// OUTPUT(fastHeader, NAMED('fastHeader'));
	// OUTPUT(combinedUniqueHeaders, NAMED('CombinedUniqueHeaders'));
	
	RETURN(combinedUniqueHeaders);
END;