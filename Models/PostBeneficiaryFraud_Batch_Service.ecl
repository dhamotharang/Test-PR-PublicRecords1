/*--SOAP--
<message name="PostBeneficiaryFraud_Batch_Service">
	<part name="PBF_batch_in"                      type="tns:XmlDataSet" cols="70" rows="20"/>
	<part name="Gateways"                          type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose"                       type="xsd:byte"/>
	<part name="GLBPurpose"                        type="xsd:byte"/>
	<part name="DataPermissionMask" 							 type="xsd:string"/>
	<part name="SelectTimeFrame"                   type="xsd:string"/>
	<part name="RealTimePermissibleUse"            type="xsd:string"/>	
	<part name="RelativeDepthLevel"                type="xsd:byte"/>
  <part name="IncludeAllAttributeCategories"     type="xsd:boolean"/>
  <part name="IncludeRelativeAndAssociates"      type="xsd:boolean"/>
  <part name="IncludeDriversLicense"             type="xsd:boolean"/>
  <part name="IncludeProperty"                   type="xsd:boolean"/>
  <part name="IncludeInHouseMotorVehicle"        type="xsd:boolean"/>
  <part name="IncludeRealTimeMotorVehicle"       type="xsd:boolean"/>
  <part name="IncludeWatercraftAndAircraft"      type="xsd:boolean"/>
  <part name="IncludeProfessionalLicense"        type="xsd:boolean"/>
  <part name="IncludeBusinessAffiliations"       type="xsd:boolean"/>
  <part name="IncludePeopleAtWork"               type="xsd:boolean"/>
  <part name="IncludeBankruptcyLiensJudgements"  type="xsd:boolean"/>
  <part name="IncludeCriminalSOFR"               type="xsd:boolean"/>
  <part name="IncludeUCCFilings"                 type="xsd:boolean"/>
</message>
*/

IMPORT Address, Risk_Indicators, RiskWise, ut, doxie, gateway;

EXPORT PostBeneficiaryFraud_Batch_Service := MACRO
  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
  PBF_Layout := Models.Layout_PostBeneficiaryFraud;
  PBF_Functions := Models.PostBeneficiaryFraud_Functions;
  UCase := StringLib.StringToUpperCase;
	
	// All the attributes set by the SOAP
	doxie.MAC_Header_Field_Declare(); // Used to get DPPA_Purpose, GLB_Purpose, and dppa_ok
  #STORED('DLPurpose', DPPA_Purpose);
  // Can't have duplicate definitions of Stored with different default values, 
  // so add the default to #stored to eliminate the assignment of a default value.
  #stored('DataPermissionMask',risk_indicators.iid_constants.default_DataPermission);
	
  batchin := DATASET([], PBF_Layout.BatchInput) : STORED('PBF_batch_in', FEW);
  gateways := Gateway.Configuration.Get();
  STRING    RealTimePermissibleUse := '' : STORED('RealTimePermissibleUse');
  UNSIGNED1 RelativeDepthLevel := 1 : STORED('RelativeDepthLevel');
  BOOLEAN   Stored_Include_All := FALSE : STORED('IncludeAllAttributeCategories');
  BOOLEAN   Stored_Include_Relative_And_Associates := FALSE : STORED('IncludeRelativeAndAssociates');
  BOOLEAN   Stored_Include_Drivers_License := FALSE : STORED('IncludeDriversLicense');
  BOOLEAN   Stored_Include_Property := FALSE : STORED('IncludeProperty');
  BOOLEAN   Stored_Include_In_House_Motor_Vehicle := FALSE : STORED('IncludeInHouseMotorVehicle');
  BOOLEAN   Stored_Include_Real_Time_Motor_Vehicle := FALSE : STORED('IncludeRealTimeMotorVehicle');
  BOOLEAN   Stored_Include_Watercraft_And_Aircraft := FALSE : STORED('IncludeWatercraftAndAircraft');
  BOOLEAN   Stored_Include_Professional_License := FALSE : STORED('IncludeProfessionalLicense');
  BOOLEAN   Stored_Include_Business_Affiliations := FALSE : STORED('IncludeBusinessAffiliations');
  BOOLEAN   Stored_Include_People_At_Work := FALSE : STORED('IncludePeopleAtWork');
  BOOLEAN   Stored_Include_Bankruptcy_Liens_Judgements := FALSE : STORED('IncludeBankruptcyLiensJudgements');
  BOOLEAN   Stored_Include_Criminal_SOFR := FALSE : STORED('IncludeCriminalSOFR');
  BOOLEAN   Stored_Include_UCC_Filings := FALSE : STORED('IncludeUCCFilings');
  STRING7   TIME_FRAME := 'ALL' : STORED('SelectTimeFrame');
	
	// Various flags necessary for getting the Boca Shell data
  BOOLEAN   isUtility := FALSE;
  BOOLEAN   ofac_Only := FALSE;
  BOOLEAN   excludewatchlists := TRUE;
  STRING50  datarestriction := Risk_Indicators.iid_constants.default_DataRestriction;
  STRING    DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
  UNSIGNED1 bsVersion := 3;
  UNSIGNED3 history_date := 999999;
	
	// All the attributes dealing with what to include and the 'Select Time Frame' option (Date_Cutoff)
	STRING7   Uppercase_Time_Frame := TRIM(UCase(TIME_FRAME));
	UNSIGNED  Unsigned_Time_Frame := (UNSIGNED)(TIME_FRAME);
	BOOLEAN   Current_Only := Uppercase_Time_Frame = 'CURRENT';
	UNSIGNED2 Date_Cutoff :=
	            MAP(
							  Uppercase_Time_Frame IN ['ALL', 'CURRENT'] => 60000,
								Unsigned_Time_Frame BETWEEN 1 AND 255 => Unsigned_Time_Frame,
								60000);
	BOOLEAN   All_False :=
	            ~Stored_Include_Relative_And_Associates AND ~Stored_Include_Drivers_License AND
	            ~Stored_Include_Property AND ~Stored_Include_In_House_Motor_Vehicle AND
							~Stored_Include_Real_Time_Motor_Vehicle AND ~Stored_Include_Watercraft_And_Aircraft AND
							~Stored_Include_Professional_License AND ~Stored_Include_Business_Affiliations AND
							~Stored_Include_People_At_Work AND ~Stored_Include_Bankruptcy_Liens_Judgements AND
							~Stored_Include_Criminal_SOFR AND ~Stored_Include_UCC_Filings;											
  BOOLEAN   INCLUDE_ALL := IF(Stored_Include_All OR All_False, TRUE, FALSE);
  BOOLEAN   INCLUDE_RELATIVE_AND_ASSOCIATES := IF(INCLUDE_ALL, TRUE, Stored_Include_Relative_And_Associates);
  BOOLEAN   INCLUDE_DRIVERS_LICENSE := IF(INCLUDE_ALL, TRUE, Stored_Include_Drivers_License);
  BOOLEAN   INCLUDE_PROPERTY := IF(INCLUDE_ALL, TRUE, Stored_Include_Property);
  BOOLEAN   INCLUDE_IN_HOUSE_MOTOR_VEHICLE := IF(INCLUDE_ALL, TRUE, Stored_Include_In_House_Motor_Vehicle);
	          // We only do real-time MVR if the customer has checked that box and ONLY then.
  BOOLEAN   INCLUDE_REAL_TIME_MOTOR_VEHICLE := Stored_Include_Real_Time_Motor_Vehicle;
  BOOLEAN   INCLUDE_WATERCRAFT_AND_AIRCRAFT := IF(INCLUDE_ALL, TRUE, Stored_Include_Watercraft_And_Aircraft);
  BOOLEAN   INCLUDE_PROFESSIONAL_LICENSE := IF(INCLUDE_ALL, TRUE, Stored_Include_Professional_License);
  BOOLEAN   INCLUDE_BUSINESS_AFFILIATIONS := IF(INCLUDE_ALL, TRUE, Stored_Include_Business_Affiliations);
  BOOLEAN   INCLUDE_PEOPLE_AT_WORK := IF(INCLUDE_ALL, TRUE, Stored_Include_People_At_Work);
  BOOLEAN   INCLUDE_BANKRUPTCY_LIENS_JUDGEMENTS := IF(INCLUDE_ALL, TRUE, Stored_Include_Bankruptcy_Liens_Judgements);
  BOOLEAN   INCLUDE_CRIMINAL_SOFR := IF(INCLUDE_ALL, TRUE, Stored_Include_Criminal_SOFR);
  BOOLEAN   INCLUDE_UCC_FILINGS := IF(INCLUDE_ALL, TRUE, Stored_Include_UCC_Filings);
	STRING11  MVR_THRESHOLD_DEFAULT := '10000.00';

  // Set attributes for passing to bocashell function
  BOOLEAN require2ele := FALSE;
  BOOLEAN isLn := FALSE;	// not needed anymore
  BOOLEAN doRelatives := FALSE;
  BOOLEAN doDL := FALSE;
  BOOLEAN doVehicle := FALSE;
  BOOLEAN doDerogs := TRUE;
  BOOLEAN suppressNearDups := FALSE;
  BOOLEAN fromBIID := FALSE;
  BOOLEAN isFCRA := FALSE;
  BOOLEAN fromIT1O := FALSE;
  BOOLEAN doScore := FALSE;
  BOOLEAN nugen := TRUE;
  BOOLEAN filter_out_fares := FALSE;  

  cap_min := 0;
	cap_max := 255;
	capU(UNSIGNED input, UNSIGNED lower, UNSIGNED upper) := FUNCTION
		RETURN(IF(input <= lower, lower, IF(input >= upper, upper, input)));
	END;

  // **********************************************************************************************
	// ** PROGRAM START
	// **********************************************************************************************
  sorted_input := SORT(
	                  batchin,
										(UNSIGNED)acctno, RECORD);
	
  // add sequence to match up later to add acctno to output and add any defaults
  PBF_Layout.BatchInput_With_Seq add_seq(PBF_Layout.BatchInput le, INTEGER C) := TRANSFORM
	  SELF.seq := C;
		SELF.mvr_vehicle_threshold := IF(le.mvr_vehicle_threshold = '',
		                                 MVR_THRESHOLD_DEFAULT,
																		 le.mvr_vehicle_threshold);
	  SELF := le;
  END;
  batchinseq := PROJECT(sorted_input, add_seq(LEFT, COUNTER)) : INDEPENDENT;

  risk_indicators.Layout_Input into_in(PBF_Layout.BatchInput_With_Seq le) := TRANSFORM
	  // clean up input
	  dob_val := RiskWise.cleanDOB(le.dob);
	  dl_num_clean := RiskWise.cleanDL_num(le.dl_number);

	  SELF.seq := le.seq;	
	  SELF.ssn := le.ssn;
	  SELF.dob := dob_val;
	  SELF.age := IF((INTEGER)dob_val != 0, (STRING3)ut.GetAgeI((INTEGER)dob_val), '');
	
	  SELF.phone10 := le.Home_Phone;
	
	  cleaned_name := Address.CleanPerson73(le.unparsed_full_name);
	  BOOLEAN valid_cleaned := le.unparsed_full_name <> '';
	
	  SELF.fname := UCase(IF(le.Name_First = '' AND valid_cleaned, cleaned_name[6..25], le.Name_First));
	  SELF.lname := UCase(IF(le.Name_Last = '' AND valid_cleaned, cleaned_name[46..65], le.Name_Last));
	  SELF.mname := UCase(IF(le.Name_Middle = '' AND valid_cleaned, cleaned_name[26..45], le.Name_Middle));
	  SELF.title := UCase(IF(valid_cleaned, cleaned_name[1..5], ''));

	  clean_addr := Risk_Indicators.MOD_AddressClean.clean_addr(le.street_address, le.p_City_name, le.St, le.Z5);

	  SELF.in_streetAddress := le.street_address;
	  SELF.in_city := UCase(le.p_City_name);
	  SELF.in_state := UCase(le.St);
	  SELF.in_zipCode := le.Z5;
		
	  SELF.prim_range := Address.CleanFields(clean_addr).prim_range;
	  SELF.predir := Address.CleanFields(clean_addr).predir;
	  SELF.prim_name := Address.CleanFields(clean_addr).prim_name;
	  SELF.addr_suffix := Address.CleanFields(clean_addr).addr_suffix;
	  SELF.postdir := Address.CleanFields(clean_addr).postdir;
	  SELF.unit_desig := Address.CleanFields(clean_addr).unit_desig;
	  SELF.sec_range := Address.CleanFields(clean_addr).sec_range;
	  SELF.p_city_name := Address.CleanFields(clean_addr).p_city_name;
	  SELF.st := Address.CleanFields(clean_addr).st;
	  SELF.z5 := Address.CleanFields(clean_addr).zip;
	  SELF.zip4 := Address.CleanFields(clean_addr).zip4;
	  SELF.lat := Address.CleanFields(clean_addr).geo_lat;
	  SELF.long := Address.CleanFields(clean_addr).geo_long;
	  SELF.addr_type := Address.CleanFields(clean_addr).rec_type[1];
	  SELF.addr_status := Address.CleanFields(clean_addr).err_stat;
		// we only want the county fips, not all 5.  first 2 are the state fips
	  SELF.county := Address.CleanFields(clean_addr).county[3..5];
	  SELF.geo_blk := Address.CleanFields(clean_addr).geo_blk;
	
	  SELF.dl_number := UCase(dl_num_clean);
	  SELF.dl_state := UCase(le.dl_state);
		SELF.historydate := history_date;
		
	  SELF := [];
  END;
	
  cleanIn := PROJECT(batchinseq, into_in(LEFT));

  iid :=
	  Risk_Indicators.InstantID_Function(cleanIn, gateways, DPPA_Purpose, GLB_Purpose, isUtility, isLn,
		  ofac_only, suppressNearDups, require2Ele, fromBIID, isFCRA, excludewatchlists, fromIT1O, 
			in_BSversion := bsVersion, in_DataRestriction := DataRestriction, in_DataPermission := DataPermission);

  // Instead of calling the Risk_Indicators.Boca_Shell_Function, we need to call the individual
	// pieces, so those pieces can be used for later processing.
  ids_wide := 
	  Risk_Indicators.Boca_Shell_FCRA_Neutral_Function(iid, DPPA_Purpose, GLB_Purpose, isUtility, isLN,
		                                                 doRelatives, FALSE, bsVersion, nugen := nugen,
																										 DataRestriction := DataRestriction,
																										 BSOptions:=0);
 	
  p := DEDUP(
		     GROUP(
			     SORT(
				     PROJECT(
					     ids_wide(~isrelat),
						   Risk_Indicators.Layout_Boca_Shell),
					   seq, RECORD),
				   seq),
			   seq);

  clam := Risk_Indicators.getAllBocaShellData(iid, ids_wide, p,
                                              FALSE, isLN, DPPA_Purpose, dppa_ok,
																							doRelatives, doDL, doVehicle, doDerogs, bsVersion,
																							FALSE, doScore, filter_out_fares, DataRestriction, 0, GLB_Purpose, gateways, DataPermission);

  PostBeneficiaryFraud :=
	  Models.get_PostBeneficiaryFraud_Attributes(clam, ids_wide, p, batchinseq, cleanIn, gateways,
		                                           GLB_Purpose, DPPA_Purpose, Date_Cutoff, Current_Only,
																							 RelativeDepthLevel,
																							 INCLUDE_RELATIVE_AND_ASSOCIATES,
																							 INCLUDE_DRIVERS_LICENSE, INCLUDE_PROPERTY,
																							 INCLUDE_IN_HOUSE_MOTOR_VEHICLE,
																							 INCLUDE_REAL_TIME_MOTOR_VEHICLE,
																							 INCLUDE_WATERCRAFT_AND_AIRCRAFT,
																							 INCLUDE_PROFESSIONAL_LICENSE,
																							 INCLUDE_BUSINESS_AFFILIATIONS,
																							 INCLUDE_PEOPLE_AT_WORK,
																							 INCLUDE_BANKRUPTCY_LIENS_JUDGEMENTS,
																							 INCLUDE_CRIMINAL_SOFR,
																							 INCLUDE_UCC_FILINGS);

	PBF_Layout.Final_Plus xfm_final_output(PBF_Layout.BatchInput_With_Seq le,
	                                       PBF_Layout.Combined_Attributes ri) := TRANSFORM
    license_category := Risk_Indicators.getPLinfo(ri.license_type).PLcategory;		
		
	  SELF.VerifiedSSN := ri.VerifiedSSN;
	  SELF.VerifiedName := ri.VerifiedName;
	  SELF.VerifiedAddress := ri.VerifiedAddress;
	  SELF.VerifiedDOB := ri.VerifiedDOB;
	  SELF.VerifiedPhone := ri.VerifiedPhone;
	  SELF.IdentityValid := ri.IdentityValid;
		SELF.DuplicateEntry := IF(ri.repeat_did_count > 1, '1', '0');
	  SELF.InvalidSSN := ri.InvalidSSN;
	  SELF.SSNLowIssueDate := ri.LowIssueDate;
	  SELF.SSNHighIssueDate := ri.HighIssueDate;
	  SELF.SSNIssueState := ri.SSNIssueState;
	  SELF.isIssuedPrior := ri.SSNIssuedPrior;
		SELF.InputSSNpossrandomized :=
		  MAP(
			  le.ssn = '' => '-1',
		    IF(Risk_Indicators.rcSet.isCodeRS(le.ssn, ri.socsvalflag, ri.LowIssueDate, ri.socsRCISflag),
				   '1',
					 '0'));
		SELF.InputSSNpossrandominvalid :=
		  MAP(
			  le.ssn = '' => '-1',
		    IF(Risk_Indicators.rcSet.isCodeIS(le.ssn, ri.socsvalflag, ri.LowIssueDate, ri.socsRCISflag),
				   '1',
					 '0'));
	  SELF.SSNDeceased := ri.SSNDeceased;
	  SELF.SSNDateDeceased := ri.DateSSNDeceased;
		SELF.SharedAddress := ri.SharedAddress;
		SELF.NumSharedAddr := ri.NumAtSharedAddr;
		SELF.RelativesSharedAddr := ri.RelativesAtSharedAddr;
		SELF.NumRelativesAtAddr := ri.NumRelativesAtAddrOnInputDate;
		SELF.AssociateSharedAddr := ri.AssociateAtSharedAddr;
		SELF.NumAssociatesAtAddr := ri.NumAssociatesAtAddrOnInputDate;
		SELF.NumofAdults := ri.NumofAdultsNotReported;
		SELF.DLnumoutofState := ri.DLNumberOutOfState;
		SELF.DLissuedState := ri.DLStateIssued;
		SELF.RealProperty := IF(INCLUDE_PROPERTY,
			                      IF(ri.total_owned_property > 0, '1', '0'),
				                    '');
		SELF.MultipleProperties :=
		  MAP(
			  ~INCLUDE_PROPERTY => '',
			  le.number_of_properties = 0 => '0',
				(Date_Cutoff BETWEEN 0 AND 255) AND ri.total_owned_property = 0 => '-1',
				ri.total_owned_property > le.number_of_properties => '1',
				'0');
		SELF.NumMultipleProperties := IF(INCLUDE_PROPERTY,
		                                 (STRING)capU(ri.total_owned_property, cap_min, cap_max),
																		 '');
		SELF.RealPropertyoutofState :=
		  MAP(
			  ~INCLUDE_PROPERTY => '',
				(Date_Cutoff BETWEEN 0 AND 255) AND ri.total_owned_property_out_of_state = 0 => '-1',
				ri.total_owned_property_out_of_state > 0 => '1',
				'0');
		SELF.MVRvaluegreaterthanthreshold :=
			MAP(
				~(INCLUDE_IN_HOUSE_MOTOR_VEHICLE OR INCLUDE_REAL_TIME_MOTOR_VEHICLE) => '',
				ri.registration_count = 0 => '-1',
			  (UNSIGNED)ri.value_greater_than_threshold_count > 0 => '1',
				'0');
		SELF.MVRreglessthan20yrs :=
			MAP(
				~(INCLUDE_IN_HOUSE_MOTOR_VEHICLE OR INCLUDE_REAL_TIME_MOTOR_VEHICLE) => '',
				ri.registration_count = 0 => '-1',
			  (UNSIGNED)ri.registrations_less_than_20yrs_count > 0 => '1',
				'0');		
		SELF.NumUnreportedMVR :=
			MAP(
				~(INCLUDE_IN_HOUSE_MOTOR_VEHICLE OR INCLUDE_REAL_TIME_MOTOR_VEHICLE) => '',
				le.number_of_mvr = 0 => '0',
			  (STRING)capU(IF(ri.registration_count_difference < 0,
				                0,
												ri.registration_count_difference),
										 cap_min,
										 cap_max));		
		SELF.MVRCommercial :=
			MAP(
				~(INCLUDE_IN_HOUSE_MOTOR_VEHICLE OR INCLUDE_REAL_TIME_MOTOR_VEHICLE) => '',
				ri.commercial_registration_count > 0 => '1',
				'0');		
		SELF.NumMVRCommercial :=
			IF(INCLUDE_IN_HOUSE_MOTOR_VEHICLE OR INCLUDE_REAL_TIME_MOTOR_VEHICLE,
			   (STRING)capU(ri.commercial_registration_count, cap_min, cap_max),
				 '');		
		SELF.WatercraftCount := IF(INCLUDE_WATERCRAFT_AND_AIRCRAFT,
		                           (STRING)capU(ri.watercraft_count, cap_min, cap_max),
															 '');
		SELF.AircraftCount := IF(INCLUDE_WATERCRAFT_AND_AIRCRAFT,
		                         (STRING)capU(ri.aircraft_count, cap_min, cap_max),
														 '');
		SELF.ProfLicissued := IF(INCLUDE_PROFESSIONAL_LICENSE,
		                         IF(ri.prof_license_count > 0, '1', '0'),
														 '');
		SELF.ProfLicCount := IF(INCLUDE_PROFESSIONAL_LICENSE,
		                        (STRING)capU(ri.prof_license_count, cap_min, cap_max),
														'');
		SELF.ProfLicTypeCategory := IF(INCLUDE_PROFESSIONAL_LICENSE,
		                               IF(license_category = '', '-1', license_category),
																	 '');
		SELF.BusinessAffiliations := IF(INCLUDE_BUSINESS_AFFILIATIONS,
		                                IF(ri.affiliation_count > 0, '1', '0'),
																		'');
		SELF.PossibleWorkLocation := IF(INCLUDE_PEOPLE_AT_WORK,
		                                IF(ri.paw_count > 0, '1', '0'),
																	  '');
		SELF.BankruptcyCount := IF(INCLUDE_BANKRUPTCY_LIENS_JUDGEMENTS,
		                           (STRING)capU(ri.bankruptcy_count, cap_min, cap_max),
															 '');
		SELF.LiensorJudgments := IF(INCLUDE_BANKRUPTCY_LIENS_JUDGEMENTS,
		                            (STRING)capU(ri.liens_count, cap_min, cap_max),
															  '');
	  SELF.PossibleIncarceration := IF(INCLUDE_CRIMINAL_SOFR,
		                                 IF(ri.is_in_jail, '1', '0'),
																		 '');
	  SELF.PossibleSOFR := IF(INCLUDE_CRIMINAL_SOFR,
		                        IF(ri.has_sofr, '1', '0'),
														'');
		SELF.UCCFiling := IF(INCLUDE_UCC_FILINGS,
		                     (STRING)capU(ri.UCC_count, cap_min, cap_max),
												 '');
		SELF.CurrentBestAddressHighRisk := ri.address_high_risk;
		SELF.CurrentBestAddrHRRC1 := ri.CurrentBestAddrHRRC1;
		SELF.CurrentBestAddrHRDesc1 := ri.CurrentBestAddrHRDesc1;
		SELF.CurrentBestAddrHRRC2 := ri.CurrentBestAddrHRRC2;
		SELF.CurrentBestAddrHRDesc2 := ri.CurrentBestAddrHRDesc2;
		SELF.CurrentBestAddrHRRC3 := ri.CurrentBestAddrHRRC3;
		SELF.CurrentBestAddrHRDesc3 := ri.CurrentBestAddrHRDesc3;
		SELF.CurrentBestAddressBusiness := ri.address_business;
		SELF.CurrentBestAddressVacant := ri.address_vacant;
		SELF.CurrAddrPrison := ri.CurrAddrPrison;
	  SELF.caaddress := ri.caaddress;
	  SELF.cacity := ri.cacity;
	  SELF.castate := ri.castate;
	  SELF.cazip := ri.cazip;
	  SELF.caphonenumber := IF(ri.caphonenumber = '0', '', ri.caphonenumber);
		SELF.Link_ID := ri.did;
		SELF.input_state := ri.input_state;
		SELF.matchcode := ri.matchcode;
		
	  SELF := le;
	END;
	
	final_attribute_result := JOIN(batchinseq, PostBeneficiaryFraud,
		                          LEFT.seq = (UNSIGNED)RIGHT.seq,
			                        xfm_final_output(LEFT, RIGHT),
			                        LEFT OUTER);

	codes_result := PBF_Functions.fn_get_reason_codes(final_attribute_result);
	
	final_result := PROJECT(codes_result, PBF_Layout.Final_Output);

	OUTPUT(final_result, NAMED('Results'));
/*
	//OUTPUT(cleanIn, NAMED('Results'));
	//OUTPUT(iid, NAMED('Results'));
	//OUTPUT(p, NAMED('Results'));
	//OUTPUT(clam, NAMED('Results'));
	OUTPUT(PostBeneficiaryFraud, NAMED('Results'));	
*/
ENDMACRO;
// Models.PostBeneficiaryFraud_Batch_Service()