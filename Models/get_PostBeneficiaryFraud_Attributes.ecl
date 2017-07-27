IMPORT Risk_Indicators, ut, gateway;

  R_I := Risk_Indicators;
  PBF_Layout := Models.Layout_PostBeneficiaryFraud;
  PBF_Functions := Models.PostBeneficiaryFraud_Functions;
  UCase := StringLib.StringToUpperCase;

// Code from the beginning to where attr is assigned is mainly an absorption of the code contained in
// Models.get_LeadIntegrity_Attributes.  The Easi Census information is not needed for this product.
EXPORT get_PostBeneficiaryFraud_Attributes(GROUPED DATASET(R_I.Layout_Boca_Shell) clam,
                                           GROUPED DATASET(R_I.Layout_BocaShell_Neutral) ids_wide,
                                           GROUPED DATASET(R_I.Layout_Boca_Shell) in_p,
                                           DATASET(PBF_Layout.BatchInput_With_Seq) original_input,
                                           DATASET(risk_indicators.Layout_Input) original_clean_input,
																					 DATASET(Gateway.Layouts.Config) gateways,
                                           UNSIGNED1 GLB_Purpose,
																					 UNSIGNED1 DPPA_Purpose,
																					 UNSIGNED2 Date_Cutoff,
																					 BOOLEAN Current_Only,
																					 UNSIGNED1 RelativeDepthLevel,
																					 BOOLEAN INCLUDE_RELATIVE_AND_ASSOCIATES,
																					 BOOLEAN INCLUDE_DRIVERS_LICENSE,
																					 BOOLEAN INCLUDE_PROPERTY,
																					 BOOLEAN INCLUDE_IN_HOUSE_MOTOR_VEHICLE,
																					 BOOLEAN INCLUDE_REAL_TIME_MOTOR_VEHICLE,
																					 BOOLEAN INCLUDE_WATERCRAFT_AND_AIRCRAFT,
																					 BOOLEAN INCLUDE_PROFESSIONAL_LICENSE,
																					 BOOLEAN INCLUDE_BUSINESS_AFFILIATIONS,
																					 BOOLEAN INCLUDE_PEOPLE_AT_WORK,
																					 BOOLEAN INCLUDE_BANKRUPTCY_LIENS_JUDGEMENTS,
																					 BOOLEAN INCLUDE_CRIMINAL_SOFR,
																					 BOOLEAN INCLUDE_UCC_FILINGS) := FUNCTION

	// Only what's needed from the clam:
	Layout_InstantID_Results_slim := RECORD
		INTEGER1 NAS_Summary;
		BOOLEAN ssnexists := true;
	END;

	Layout_Input_Validation_slim := RECORD
		BOOLEAN Address;
		BOOLEAN SSN;
		BOOLEAN HomePhone;
	END;

	Layout_Other_Address_Fields_slim := RECORD
		boolean isPrison := false;
	END;
	
	Layout_Address_Verification_slim :=
		RECORD
			Risk_Indicators.Layouts.Layout_Address_Informationv3 Input_Address_Information;
			UNSIGNED5 activePhone;
			UNSIGNED5 activePhone2;
			UNSIGNED5 activePhone3;
			Risk_Indicators.Layouts.Layout_Address_Informationv3 Address_History_1;
			Risk_Indicators.Layouts.Layout_Address_Informationv3 Address_History_2;
		END;

	layout_clam_slim := RECORD
		unsigned4 seq;
		unsigned6 did;
		Layout_InstantID_Results_slim    iid;
		Layout_Input_Validation_slim     Input_Validation;
		Layout_Other_Address_Fields_slim other_address_info;
		Layout_Address_Verification_slim Address_Verification;
		UNSIGNED3	historyDate;
	END;

	working_layout := RECORD
		Models.layouts.layout_LeadIntegrity_attributes_batch_v1;
		layout_clam_slim clam;
		UNSIGNED6 did := 0;
		STRING1   socsvalflag := '';
		STRING2   IdentityValid := '';
	  STRING65  caaddress := '';
	  STRING25  cacity := '';
	  STRING2   castate := '';
	  STRING5   cazip := '';
	  STRING10  caphonenumber := '';
		UNSIGNED1 CAaddrChooser := 0;
	  STRING10  ca_prim_range := '';
	  STRING2   ca_predir := '';
	  STRING28  ca_prim_name := '';
	  STRING4   ca_addr_suffix := '';
	  STRING2   ca_postdir := '';
	  STRING10  ca_unit_desig := '';
	  STRING8   ca_sec_range := '';
	END;

	checkBoolean(BOOLEAN x) := IF(x, '1', '0');
	
	STRING6 todays_date := StringLib.GetDateYYYYMMDD()[1..6];

  // create all of the attributes from what we have available in the clam
  working_layout map_fields(R_I.Layout_Boca_Shell le) := TRANSFORM
	  fullDate := (UNSIGNED)R_I.iid_constants.full_history_date(le.historydate);
	
	  SELF.seq := (STRING)le.seq;
	  SELF.acctno := '';
		
	  // Identity Authentication Attributes	
	  SELF.InvalidSSN := checkboolean(~le.SSN_Verification.Validation.valid);
	
    // SSN Attributes
		SELF.socsvalflag := le.iid.socsvalflag;
	  SELF.ssndeceased := checkboolean(le.iid.decsflag = '1');
	  SELF.datessndeceased := (STRING)IF(le.ssn_verification.Validation.deceasedDate > fullDate,
		                                   0,
																			 le.ssn_verification.Validation.deceasedDate);
	  SELF.LowIssueDate := (STRING)IF((UNSIGNED)le.iid.socllowissue > fullDate,
		                                0,
																		(UNSIGNED)le.iid.socllowissue);
	  SELF.HighIssueDate := (STRING)IF((UNSIGNED)le.iid.soclhighissue > fullDate,
		                                 0,
																		 (UNSIGNED)le.iid.soclhighissue);
	  SELF.SSNIssueState := le.iid.soclstate;
	
    // Evidence of Compromised Identity
	  SELF.SSNIssuedPrior := checkboolean(le.ssn_verification.validation.dob_mismatch);
		
	  SELF.clam := le;
		SELF := [];
  END;
	
  p := PROJECT(clam, map_fields(LEFT));
	
	// Transform to Combined_Attributes.
	// This transform uses Date_Cutoff a lot to establish CurrentAddress (e.g. caaddress, cacity) 
	// within the time period specified by Date_Cutoff. We also calculate min_date and max_date here for 
	// use in Archive Mode in the functions Models.PostBeneficiaryFraud_Functions.fn_get_[attributeName] 
	// following the transform. 
  PBF_Layout.Combined_Attributes map_fields_v3(working_layout le, R_I.Layout_Boca_Shell ri) := TRANSFORM
	  // Version 3
	  noSSN   := NOT le.clam.input_validation.ssn;
	  ssnNull := (noSSN OR NOT le.clam.iid.ssnexists);
		attr_master := Models.Attributes_Master(ri, isFCRA:=false);

	  SELF.did := le.clam.did;

	  // Verification Attributes
	  SELF.VerifiedName := attr_master.VerifiedName;
	  SELF.VerifiedSSN := attr_master.VerifiedSSN;
	  SELF.VerifiedPhone := attr_master.VerifiedPhone;

	  SELF.IdentityValid := MAP(
		                        noSSN => '-1',
		                        le.clam.iid.nas_summary IN [9, 12] AND le.InvalidSSN = '0' => '1',
		                        '0');

	  SELF.VerifiedAddress := attr_master.VerifiedAddress;
	  SELF.VerifiedDOB := attr_master.VerifiedDOB;
		
	  // High Risk Address Attributes
		
	  // Characteristics of Current Address (Most Recent Date First Reported)
	  CAaddrChooser :=
		  MAP(
		    le.clam.did = 0 => 0,
				le.clam.address_verification.input_address_information.date_first_seen >=
				le.clam.address_verification.address_history_1.date_first_seen AND 
				le.clam.address_verification.input_address_information.date_first_seen >= 
				le.clam.address_verification.address_history_2.date_first_seen => 1,	// input is picked
				le.clam.address_verification.address_history_1.date_first_seen >= 
				le.clam.address_verification.input_address_information.date_first_seen AND
				le.clam.address_verification.address_history_1.date_first_seen >= 
				le.clam.address_verification.address_history_2.date_first_seen => 2,	// address history 1 is picked
				3); // address history 2 is picked

		SELF.CAaddrChooser := CAaddrChooser;
		
		CA_Date_Last_Seen :=
		  CASE(CAaddrChooser,
		    0 => '',
			  1 => ((STRING)le.clam.address_verification.input_address_information.date_last_seen)[1..6],
				2 => ((STRING)le.clam.address_verification.address_history_1.date_last_seen[1..6]),
				((STRING)le.clam.address_verification.address_history_2.date_last_seen[1..6]));
				
		SELF.CA_Date_Last_Seen := CA_Date_Last_Seen;
		
	  SELF.CurrAddrPrison :=
		  IF(ut.MonthsApart(todays_date, CA_Date_Last_Seen) <= Date_Cutoff,
			   IF(CAaddrChooser = 0, '-1', checkBoolean(le.clam.other_address_info.isprison)),
				 '-1');

    // Current or Best Address Attributes		
	  SELF.caaddress :=
		  IF(ut.MonthsApart(todays_date, CA_Date_Last_Seen) <= Date_Cutoff,
		     MAP(
				   CAaddrChooser = 0 => '',
					 CAaddrChooser = 1 => R_I.MOD_AddressClean.street_address(
					                        '', le.clam.address_verification.input_address_information.prim_range,
																	le.clam.address_verification.input_address_information.predir,
																	le.clam.address_verification.input_address_information.prim_name,
																  le.clam.address_verification.input_address_information.addr_suffix,
																	le.clam.address_verification.input_address_information.postdir,
																	le.clam.address_verification.input_address_information.unit_desig,
																	le.clam.address_verification.input_address_information.sec_range),
					 CAaddrChooser = 2 => R_I.MOD_AddressClean.street_address(
					                        '', le.clam.address_verification.address_history_1.prim_range,
																	le.clam.address_verification.address_history_1.predir,
																  le.clam.address_verification.address_history_1.prim_name,
																	le.clam.address_verification.address_history_1.addr_suffix,
																	le.clam.address_verification.address_history_1.postdir,
																	le.clam.address_verification.address_history_1.unit_desig,
																  le.clam.address_verification.address_history_1.sec_range),
					 R_I.MOD_AddressClean.street_address('', le.clam.address_verification.address_history_2.prim_range,
																							 le.clam.address_verification.address_history_2.predir,
																							 le.clam.address_verification.address_history_2.prim_name,
																							 le.clam.address_verification.address_history_2.addr_suffix,
																							 le.clam.address_verification.address_history_2.postdir,
																							 le.clam.address_verification.address_history_2.unit_desig,
																							 le.clam.address_verification.address_history_2.sec_range)),
				 '');
	  SELF.cacity := IF(ut.MonthsApart(todays_date, CA_Date_Last_Seen) <= Date_Cutoff,
		                  MAP(CAaddrChooser = 0 => '',
											    CAaddrChooser = 1 => le.clam.address_verification.input_address_information.city_name,
											    CAaddrChooser = 2 => le.clam.address_verification.address_history_1.city_name,
											    le.clam.address_verification.address_history_2.city_name),
									    '');
	  SELF.castate :=
	    IF(ut.MonthsApart(todays_date, CA_Date_Last_Seen) <= Date_Cutoff,
		     MAP(CAaddrChooser = 0 => '',
						 CAaddrChooser = 1 => le.clam.address_verification.input_address_information.st,
						 CAaddrChooser = 2 => le.clam.address_verification.address_history_1.st,
						 le.clam.address_verification.address_history_2.st),
				 '');
	  SELF.cazip := IF(ut.MonthsApart(todays_date, CA_Date_Last_Seen) <= Date_Cutoff,
		                 MAP(CAaddrChooser = 0 => '',
											   CAaddrChooser = 1 => le.clam.address_verification.input_address_information.zip5,
											   CAaddrChooser = 2 => le.clam.address_verification.address_history_1.zip5,
											   le.clam.address_verification.address_history_2.zip5),
										 '');
	  SELF.caphonenumber := IF(ut.MonthsApart(todays_date, CA_Date_Last_Seen) <= Date_Cutoff,
		                         MAP(CAaddrChooser = 1 => (STRING)le.clam.address_verification.activePhone,
															   CAaddrChooser = 2 => (STRING)le.clam.address_verification.activePhone2,
															   (STRING)le.clam.address_verification.activePhone3),
														 '');
	  SELF.ca_prim_range :=
		  MAP(
		    CAaddrChooser = 0 => '',
				CAaddrChooser = 1 => le.clam.address_verification.input_address_information.prim_range,
				CAaddrChooser = 2 => le.clam.address_verification.address_history_1.prim_range,
				le.clam.address_verification.address_history_2.prim_range);
	  SELF.ca_predir :=
		  MAP(
		    CAaddrChooser = 0 => '',
				CAaddrChooser = 1 => le.clam.address_verification.input_address_information.predir,
				CAaddrChooser = 2 => le.clam.address_verification.address_history_1.predir,
				le.clam.address_verification.address_history_2.predir);
	  SELF.ca_prim_name :=
		  MAP(
		    CAaddrChooser = 0 => '',
				CAaddrChooser = 1 => le.clam.address_verification.input_address_information.prim_name,
				CAaddrChooser = 2 => le.clam.address_verification.address_history_1.prim_name,
				le.clam.address_verification.address_history_2.prim_name);
	  SELF.ca_addr_suffix :=
		  MAP(
		    CAaddrChooser = 0 => '',
				CAaddrChooser = 1 => le.clam.address_verification.input_address_information.addr_suffix,
				CAaddrChooser = 2 => le.clam.address_verification.address_history_1.addr_suffix,
				le.clam.address_verification.address_history_2.addr_suffix);
	  SELF.ca_postdir :=
		  MAP(
		    CAaddrChooser = 0 => '',
				CAaddrChooser = 1 => le.clam.address_verification.input_address_information.postdir,
				CAaddrChooser = 2 => le.clam.address_verification.address_history_1.postdir,
				le.clam.address_verification.address_history_2.postdir);
	  SELF.ca_unit_desig :=
		  MAP(
		    CAaddrChooser = 0 => '',
				CAaddrChooser = 1 => le.clam.address_verification.input_address_information.unit_desig,
				CAaddrChooser = 2 => le.clam.address_verification.address_history_1.unit_desig,
				le.clam.address_verification.address_history_2.unit_desig);
	  SELF.ca_sec_range :=
		  MAP(
		    CAaddrChooser = 0 => '',
				CAaddrChooser = 1 => le.clam.address_verification.input_address_information.sec_range,
				CAaddrChooser = 2 => le.clam.address_verification.address_history_1.sec_range,
				le.clam.address_verification.address_history_2.sec_range);

		SELF.history_date := le.clam.historydate;
		SELF.min_date     := IF( Date_Cutoff = 60000, 0, Models.PostBeneficiaryFraud_Functions.fn_get_min_date( le.clam.historydate, Date_Cutoff ) );
		SELF.max_date     := Models.PostBeneficiaryFraud_Functions.fn_get_max_date(le.clam.historydate);
		SELF := le;
	END;
		
	attr := 
		JOIN(
			p, clam,
			LEFT.seq = (STRING)RIGHT.seq,
			map_fields_v3(LEFT,RIGHT),
			KEEP(1)
		);

	PBF_Layout.Combined_Attributes add_original_user_input(PBF_Layout.Combined_Attributes le,
	                                                       PBF_Layout.BatchInput_With_Seq ri) := TRANSFORM
		SELF.input_state := UCase(ri.input_state);
		SELF.input_date := ri.input_date;
		SELF.ssn := ri.ssn;
		SELF.acctno := ri.acctno;
		SELF.number_of_mvr := ri.number_of_mvr;
		SELF.mvr_vehicle_threshold := ri.mvr_vehicle_threshold;
		
	  SELF := le;
	END;

	PBF_Layout.Combined_Attributes add_cleaned_user_input(PBF_Layout.Combined_Attributes le, risk_indicators.Layout_Input ri) := TRANSFORM
	  SELF.name_first := ri.fname;
		SELF.name_middle := ri.mname;
	  SELF.name_last := ri.lname;
	  SELF.prim_range := ri.prim_range;
	  SELF.predir := ri.predir;	
	  SELF.prim_name := ri.prim_name;	
	  SELF.addr_suffix := ri.addr_suffix;	
	  SELF.postdir := ri.postdir;
	  SELF.unit_desig := ri.unit_desig;
	  SELF.sec_range := ri.sec_range;
	  SELF.city_name := ri.p_city_name;
	  SELF.st := ri.st;
	  SELF.z5 := ri.z5;
		SELF.input_dl_number := ri.dl_number;
		
	  SELF := le;
	END;

  // Attach user inputs necessary for determining various fields
  original_user_result := JOIN(attr, original_input,
	                          (UNSIGNED)LEFT.seq = RIGHT.seq,
									          add_original_user_input(LEFT, RIGHT)) : INDEPENDENT;

  user_result := JOIN(original_user_result, original_clean_input,
	                 (UNSIGNED)LEFT.seq = RIGHT.seq,
									 add_cleaned_user_input(LEFT, RIGHT)) : INDEPENDENT;

  // Get all relative and associate attribute information
	relatives_result :=
	  IF(INCLUDE_RELATIVE_AND_ASSOCIATES,
		   PBF_Functions.fn_get_relatives_and_associates(user_result, clam, original_input, RelativeDepthLevel,
			                                               GLB_Purpose, DPPA_Purpose),
			 user_result) : INDEPENDENT;
			 						
	// Get all drivers license attribute information
  DL_result := IF(INCLUDE_DRIVERS_LICENSE,
	                PBF_Functions.fn_get_drivers_license_info(relatives_result, DPPA_Purpose,
									                                          Current_Only),
									relatives_result) : INDEPENDENT;
									
  // Get real property attribute information
  property_result := IF(INCLUDE_PROPERTY,
	                      PBF_Functions.fn_get_property_info(DL_result, in_p, ids_wide),
												DL_result) : INDEPENDENT;
												
  // Get motor vehicle registration (MVR) information
  MVR_result :=
	  IF(INCLUDE_IN_HOUSE_MOTOR_VEHICLE OR INCLUDE_REAL_TIME_MOTOR_VEHICLE,
	     PBF_Functions.fn_get_mvr_info(property_result, INCLUDE_REAL_TIME_MOTOR_VEHICLE,
																		 GLB_Purpose, Date_Cutoff, Current_Only),
			 property_result) : INDEPENDENT;
												
  // Get watercraft attribute information
  watercraft_result := IF(INCLUDE_WATERCRAFT_AND_AIRCRAFT,
	                        PBF_Functions.fn_get_watercraft_info(MVR_result, Current_Only),
													MVR_result) : INDEPENDENT;

  // Get aircraft attribute information
  aircraft_result := IF(INCLUDE_WATERCRAFT_AND_AIRCRAFT,
	                      PBF_Functions.fn_get_aircraft_info(watercraft_result, Current_Only),
												watercraft_result) : INDEPENDENT;

  // Get professional license attribute information
  prof_license_result := IF(INCLUDE_PROFESSIONAL_LICENSE,
	                          PBF_Functions.fn_get_prof_license_info(aircraft_result, Current_Only),
												    aircraft_result) : INDEPENDENT;

  // Get business affiliation attribute information
  business_affiliation_result :=
	  IF(INCLUDE_BUSINESS_AFFILIATIONS,
	     PBF_Functions.fn_get_business_affiliation_info(prof_license_result),
			 prof_license_result) : INDEPENDENT;

  // Get People at Work information (PAW)
  PAW_result := IF(INCLUDE_PEOPLE_AT_WORK,
	                 PBF_Functions.fn_get_paw_info(business_affiliation_result, Current_Only),
									 business_affiliation_result) : INDEPENDENT;
	
  // Get bankruptcy attribute information
  bankruptcy_result := IF(INCLUDE_BANKRUPTCY_LIENS_JUDGEMENTS,
	                        PBF_Functions.fn_get_bankruptcy_info(PAW_result, Current_Only),
												  PAW_result) : INDEPENDENT;

  // Get liens attribute information
  liens_result := IF(INCLUDE_BANKRUPTCY_LIENS_JUDGEMENTS,
	                   PBF_Functions.fn_get_liens_info(bankruptcy_result),
										 bankruptcy_result) : INDEPENDENT;

  // Get possible incarceration attribute information
  incarceration_result := IF(INCLUDE_CRIMINAL_SOFR,
	                           PBF_Functions.fn_get_incarceration_info(liens_result),
										         liens_result) : INDEPENDENT;

  // Get SOFR (sexual offender) attribute information
  SOFR_result := IF(INCLUDE_CRIMINAL_SOFR,
	                  PBF_Functions.fn_get_sofr_info(incarceration_result),
										incarceration_result) : INDEPENDENT;

  // Get UCC attribute information
  UCC_result := IF(INCLUDE_UCC_FILINGS,
	                 PBF_Functions.fn_get_UCC_info(SOFR_result, Current_Only),
									 SOFR_result) : INDEPENDENT;

  // Get various High Risk Address attributes
	high_risk_result := PBF_Functions.fn_get_high_risk_info(UCC_result) : INDEPENDENT;
	
  // See if the information given points to a dead person
	deceased_result := PBF_Functions.fn_get_deceased_info(high_risk_result) : INDEPENDENT;

  // See if we've processed somebody more than once during the run
	duplicate_detection_result := PBF_Functions.fn_get_duplicate_did_info(deceased_result);
	
//===================================================================================================
//output(p, named('p'));
//output(attr, named('ORIGINALattr'));
//output(relatives_result, named('relativesRESULTS'));
//output(DL_result, named('dlRESULTS'));
//output(property_result, named('propertyRESULT'));
//output(MVR_result, named('MVRresult'));
//output(INCLUDE_IN_HOUSE_MOTOR_VEHICLE, named('useINHOUSE'));
//output(INCLUDE_REAL_TIME_MOTOR_VEHICLE, named('useREALTIME'));
//output(watercraft_result, named('watercraftRESULT'));
//output(aircraft_result, named('aircraftRESULT'));
//output(prof_license_result, named('proflicenseRESULT'));
//output(business_affiliation_result, named('businessaffiliationRESULT'));
//output(PAW_result, named('peopleatworkRESULT'));
//output(bankruptcy_result, named('bankruptcyRESULT'));
//output(liens_result, named('liensRESULT'));
//output(incarceration_result, named('incarcerationRESULT'));
//output(SOFR_result, named('sofrRESULT'));
//output(UCC_result, named('uccRESULT'));
//output(high_risk_result, named('hrRESULT'));
//output(deceased_result, named('deceasedRESULT'));
//output(duplicate_detection_result, named('duplicateRESULT'));
//===================================================================================================

  RETURN SORT(
			     duplicate_detection_result,
			     seq, RECORD);

END;