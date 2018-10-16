//RiskView.Search_Service
/*--SOAP--
<message name="RiskView Search_Service">
	<part name="RiskView2Request" type="tns:XmlDataSet" cols="110" rows="75"/>
	<part name="HistoryDateTimeStamp" type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="SSNMask" type="xsd:string"/>
	<part name="DLMask"	type="xsd:string"/>
	<part name="DOBMask" type="xsd:string"/>
	<part name="RetainInputDID" type="xsd:boolean"/>
</message>
*/
/*--INFO-- Contains RiskView Alerts, Scores, Attributes, Report version 5.0 and higher */

IMPORT Risk_Reporting, iesp, gateway, risk_indicators, std, ut, ffd, Inquiry_AccLogs, Risk_Reporting;

export Search_Service := MACRO

  // Can't have duplicate definitions of Stored with different default values, 
	// so add the default to #stored to eliminate the assignment of a default value.
	#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);
	#stored('DataPermissionMask',risk_indicators.iid_constants.default_DataPermission);

#WEBSERVICE(FIELDS(
		'RiskView2Request',
		'HistoryDateTimeStamp',
		'gateways',
		'DataRestrictionMask',
		'DataPermissionMask',
		'SSNMask',
		'DLMask',
		'DOBMask',
		'RetainInputDID'
	));

/* ***************************************
	 *             Grab Input:             *
   *************************************** */
  requestIn := DATASET([], iesp.riskview2.t_RiskView2Request)  	: STORED('RiskView2Request', FEW);
  firstRow := requestIn[1] : INDEPENDENT; // Since this is realtime and not batch, we only have one row on input.
	search := GLOBAL(firstRow.SearchBy);
	option := GLOBAL(firstRow.Options);
	users := GLOBAL(firstRow.User);
	context := GLOBAL(firstRow.TransactionContext);
	
/* **********************************************
	 *  Fields needed for improved Scout Logging  *
	 **********************************************/
	string32 _LoginID               := ''	: STORED('_LoginID');
	outofbandCompanyID							:= '' : STORED('_CompanyID');
	string20 CompanyID              := if(users.CompanyId != '', users.CompanyId, outofbandCompanyID);
	string20 FunctionName           := '' : STORED('_LogFunctionName');
	string50 ESPMethod              := '' : STORED('_ESPMethodName');
	string10 InterfaceVersion       := '' : STORED('_ESPClientInterfaceVersion');
	string5 DeliveryMethod          := '' : STORED('_DeliveryMethod');
	string5 DeathMasterPurpose      := '' : STORED('__deathmasterpurpose');
	STRING6 SSNMask                 := 'NONE'	: stored('SSNMask');
	STRING6 DOBMask                 := 'NONE'	: stored('DOBMask');
	BOOLEAN DLMask                  := false	: stored('DLMask');	
	BOOLEAN ExcludeDMVPII           := users.ExcludeDMVPII;
	BOOLEAN DisableOutcomeTracking  := False : STORED('OutcomeTrackingOptOut');
	BOOLEAN ArchiveOptIn            := False : STORED('instantidarchivingoptin');

	//Look up the industry by the company ID.
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(TRUE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.RiskView__Search_Service);
/* ************* End Scout Fields **************/

/* ***************************************
	 *           Set Search By:            *
   *************************************** */
	// Address
	STRING28 streetName := search.Address.StreetName;
	STRING10 streetNumber := search.Address.StreetNumber;
	STRING2 streetPreDirection := search.Address.StreetPreDirection;
	STRING2 streetPostDirection := search.Address.StreetPostDirection;
	STRING4 streetSuffix := search.Address.StreetSuffix;
	STRING8 UnitNumber := search.Address.UnitNumber;
	STRING10 UnitDesig := search.Address.UnitDesignation;
	STRING60 tempStreetAddr := Address.Addr1FromComponents(streetNumber, StreetPreDirection,	streetName, StreetSuffix, StreetPostDirection, UnitDesig, UnitNumber);
	STRING60 in_streetAddress1 := IF(search.Address.StreetAddress1='', tempStreetAddr, search.Address.StreetAddress1);
	STRING60 in_streetAddress2 := search.Address.StreetAddress2;
	STRING120 streetAddr := TRIM(in_streetAddress1) + ' ' + TRIM(in_streetAddress2);
	STRING25 City := search.Address.City;
	STRING2 State := search.Address.State;
	STRING5 Zip := search.Address.Zip5;
	STRING18 County := search.Address.County;
	// Other PII
		tmpDOB := iesp.ECL2ESP.DateToString(search.DOB);
	STRING8 DateOfBirth :=  IF(tmpDOB = '00000000', '', tmpDOB);
	STRING9 SSN := search.SSN;
	STRING10 HomePhone := search.HomePhone;
	STRING10 WorkPhone := search.WorkPhone;
	STRING50 Email := search.Email;
	STRING15 DLNumber := search.DriverLicenseNumber;
	STRING2 DLState := search.DriverLicenseState;
	string12 LexID := search.UniqueId;
	
/* ***************************************
	 *             Set Options:            *
   *************************************** */
	boolean OutputConsumerStatements := option.FFDOptionsMask[1] = '1';// this is coming from options tag now instead of out-of-band boolean option we had originally

	STRING auto_model_name := StringLib.StringToLowerCase(option.IncludeModels.Names(StringLib.StringToLowerCase(value[1..9])='rva1503_0')[1].value);
	STRING bankcard_model_name := StringLib.StringToLowerCase(option.IncludeModels.Names(StringLib.StringToLowerCase(value[1..9])='rvb1503_0')[1].value);
	STRING Short_term_lending_model_name := StringLib.StringToLowerCase(option.IncludeModels.Names(StringLib.StringToLowerCase(value[1..9])='rvg1502_0')[1].value);
	STRING Telecommunications_model_name := StringLib.StringToLowerCase(option.IncludeModels.Names(StringLib.StringToLowerCase(value[1..9])='rvt1503_0')[1].value);	
	STRING Crossindustry_model_name := StringLib.StringToLowerCase(option.IncludeModels.Names(StringLib.StringToLowerCase(value[1..9])='rvs1706_0')[1].value);	
	
	ds_flagship_models := dataset([{auto_model_name}, {bankcard_model_name}, {short_term_lending_model_name}, {telecommunications_model_name}, {Crossindustry_model_name}], {string flagship_names}) : global;
	STRING custom_model_name 	:= StringLib.StringToLowerCase(option.IncludeModels.Names(StringLib.StringToLowerCase(value) not in set(ds_flagship_models, flagship_names) )[1].value);
	ds_flagship_plus_custom   := ds_flagship_models + dataset([{custom_model_name}], {string flagship_names}) : global;
	STRING custom2_model_name := StringLib.StringToLowerCase(option.IncludeModels.Names(StringLib.StringToLowerCase(value) not in set(ds_flagship_plus_custom, flagship_names) )[1].value);
	ds_flagship_plus_custom2  := ds_flagship_plus_custom + dataset([{custom2_model_name}], {string flagship_names}) : global;
	STRING custom3_model_name := StringLib.StringToLowerCase(option.IncludeModels.Names(StringLib.StringToLowerCase(value) not in set(ds_flagship_plus_custom2, flagship_names) )[1].value);
	ds_flagship_plus_custom3  := ds_flagship_plus_custom2 + dataset([{custom3_model_name}], {string flagship_names}) : global;
	STRING custom4_model_name := StringLib.StringToLowerCase(option.IncludeModels.Names(StringLib.StringToLowerCase(value) not in set(ds_flagship_plus_custom3, flagship_names) )[1].value);
	ds_flagship_plus_custom4  := ds_flagship_plus_custom3 + dataset([{custom4_model_name}], {string flagship_names}) : global;
	STRING custom5_model_name := StringLib.StringToLowerCase(option.IncludeModels.Names(StringLib.StringToLowerCase(value) not in set(ds_flagship_plus_custom4, flagship_names) )[1].value);
	
	string intended_purpose := trim(option.IntendedPurpose);
	string	AttributesVersionRequest := trim(option.AttributesVersionRequest);
	string prescreen_score_threshold := option.IncludeModels.ModelOptions(StringLib.StringToLowerCase(OptionName)='prescreen_score_threshold')[1].OptionValue;
	boolean exception_score_reason := option.IncludeModels.ModelOptions(StringLib.StringToLowerCase(OptionName)='exception_score_reason')[1].OptionValue='1'; // T-Mobile option only - default to false
	boolean isCalifornia_in_person := option.IncludeModels.ModelOptions(StringLib.StringToLowerCase(OptionName)='inpersonapplicant')[1].OptionValue='1';  // defaults to false unless there is an option passed in to turn it on
	boolean run_riskview_report := option.IncludeReport;
	string20 HistoryDateTimeStamp := '' : STORED('HistoryDateTimeStamp');
	
	boolean IncludeLnJ := option.IncludeLiensJudgmentsReport;
	boolean IncludeRecordsWithSSN := option.LiensJudgmentsReportOptions.IncludeRecordsWithSSN;
	boolean IncludeBureauRecs := option.LiensJudgmentsReportOptions.IncludeBureauRecs;
 integer ReportingPeriod := if(option.LiensJudgmentsReportOptions.ReportingPeriod = 0, 84, 
                               option.LiensJudgmentsReportOptions.ReportingPeriod);
	
	//Default the options to be ON which is '1'. If excluded, then change to 0
	string tmpFilterLienTypes := Risk_Indicators.iid_constants.LnJDefault;

	boolean ExcludeCityTaxLiens := option.LiensJudgmentsReportOptions.ExcludeCityTaxLiens;
	boolean ExcludeCountyTaxLiens := option.LiensJudgmentsReportOptions.ExcludeCountyTaxLiens;
	boolean ExcludeStateTaxWarrants := option.LiensJudgmentsReportOptions.ExcludeStateTaxWarrants;
	boolean ExcludeStateTaxLiens := option.LiensJudgmentsReportOptions.ExcludeStateTaxLiens;
	boolean ExcludeFederalTaxLiens := option.LiensJudgmentsReportOptions.ExcludeFederalTaxLiens;
	boolean ExcludeOtherLiens := option.LiensJudgmentsReportOptions.ExcludeOtherLiens;
	boolean ExcludeJudgments := option.LiensJudgmentsReportOptions.ExcludeJudgments;
	boolean ExcludeEvictions := option.LiensJudgmentsReportOptions.ExcludeEvictions;
	
	// if the boolean flag is true, use the boolean flags
	// if the boolean flag is not true, then check to ensure the user didn't enter a FilterlienType
		
	tmpCityFltr := if(ExcludeCityTaxLiens, '0', tmpFilterLienTypes[1..1]);
	tmpCountyFltr := if(ExcludeCountyTaxLiens, '0', tmpFilterLienTypes[2..2]);
	tmpStateWarrantFltr := if(ExcludeStateTaxWarrants, '0', tmpFilterLienTypes[3..3]);
	tmpStateFltr :=  if(ExcludeStateTaxLiens, '0', tmpFilterLienTypes[4..4]);
	tmpFedFltr := if(ExcludeFederalTaxLiens, '0', tmpFilterLienTypes[5..5]);
	tmpLiensFltr := if(ExcludeOtherLiens,'0', tmpFilterLienTypes[6..6]);
	tmpJdgmtsFltr := if(ExcludeJudgments, '0', tmpFilterLienTypes[7..7]);
	tmpEvictionsFltr := if(ExcludeEvictions, '0', tmpFilterLienTypes[8..8]);
		//We now have boolean options for each of these filters. We built the code to use a bit (string)
		//saying which ones they want and which ones they want to filter. I take the boolean flags and 
		//turn them into the string the code is expecting. FlagLiensOptions in constants will convert to 
		//the BS options in the search_function.
	FilterLienTypes := tmpCityFltr + 
		tmpCountyFltr +
		tmpStateWarrantFltr +
		tmpStateFltr + 
		tmpFedFltr +
		tmpLiensFltr +
		tmpJdgmtsFltr +
		tmpEvictionsFltr;
		
	boolean RetainInputDID := false		: stored('RetainInputDID');		// to be used by modelers in R&D mode
	
	gateways_in := Gateway.Configuration.Get();
	Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
		SELF.servicename := le.servicename;
		SELF.url := IF(le.servicename IN ['targus'], '', le.url); // Don't allow Targus Gateway
		SELF := le;
	END;
	gateways := PROJECT(gateways_in, gw_switch(LEFT));
	
	#stored('DisableBocaShellLogging', DisableOutcomeTracking);

/* ***************************************
	 *           Set User Values:          *
   *************************************** */

  STRING outOfBandDataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
  STRING50 DataRestriction := IF(TRIM(users.DataRestrictionMask) <> '', users.DataRestrictionMask, outOfBandDataRestriction);

	STRING outOfBandDataPermission := '0000000000' : STORED('DataPermissionMask');
  STRING DataPermission := MAP(TRIM(users.DataPermissionMask) <> '' => users.DataPermissionMask,
                                  TRIM(outOfBandDataPermission) <> ''  => outOfBandDataPermission,
                                                                           Risk_Indicators.iid_constants.default_DataPermission);

  STRING20 AccountNumber := users.AccountNumber;
	BOOLEAN TestDataEnabled := users.TestDataEnabled;
	STRING32 TestDataTableName := StringLib.StringToUpperCase(TRIM(users.TestDataTableName, LEFT, RIGHT));
	
  //Used only by MLA
  STRING20 EndUserCompanyName 		:= context.MLAGatewayInfo.EndUserCompanyName;
  STRING20 CustomerNumber					:= context.MLAGatewayInfo.CustomerNumber ;
  STRING20 SecurityCode 					:= context.MLAGatewayInfo.SecurityCode  ;
	
/* ***************************************
	 *           Package Input:            *
   *************************************** */
	emptyRecord := Risk_Indicators.iid_constants.ds_Record;

	riskview.layouts.layout_riskview_input intoInput(emptyRecord le) := TRANSFORM	
	// Sequence - This is hidden from the ESP to be used by the ECL Developers for testing purposes	
		SELF.Seq := (integer)search.seq;
		self.unparsedfullname := search.name.full;
		SELF.Name_First := search.Name.First;
		SELF.name_middle := search.Name.Middle;
		SELF.name_last := search.Name.Last;
		SELF.name_suffix := search.Name.Suffix;
		SELF.street_addr   := streetAddr;
		SELF.p_City_name  := City;
		SELF.St        := State;
		SELF.Z5          := Zip;
		SELF.DOB := DateOfBirth;
		SELF.SSN := SSN;
		SELF.home_phone := HomePhone;
		SELF.work_phone := WorkPhone;
		SELF.Email := Email;
		SELF.DL_Number := DLNumber;
		SELF.DL_State := DLState;
		SELF.AcctNo := AccountNumber;
		self.LexID := LexID; 		
		self.HistoryDateTimeStamp := HistoryDateTimeStamp;
		self.Custom_Inputs := option.IncludeModels.ModelOptions;
		SELF := [];
	END;

	packagedInput := PROJECT(emptyRecord, intoInput(LEFT));
	
	Risk_Indicators.Layout_Input intoLayoutInput(emptyRecord le) := TRANSFORM
		SELF.seq := (integer)search.seq;	// Sequence - This is to be used by the ECL Developers for testing purposes	
		SELF.fname := StringLib.StringToUpperCase(search.Name.First);
		SELF.lname := StringLib.StringToUpperCase(search.Name.Last);
		SELF.ssn := SSN;
		SELF.in_zipCode := Zip;
		SELF.phone10 := HomePhone;
		SELF := [];
	END;

	packagedTestseedInput := PROJECT(emptyRecord, intoLayoutInput(LEFT));

/* ***************************************
	 *            Validate Input:          *
   *************************************** */
// a.	First Name, Last Name, Street Address, Zip
// b. First Name, Last Name, Street Address, City, State
// c.	First Name, Last Name, SSN
// d. LexID
error_message := 'Error - Minimum input fields required: First Name, Last Name, Address, and Zip or City and State; LexID only; or First Name, Last Name, and SSN';
// MLA alert requested by itself (no scores, attributes, report) 
MLA_alone				:= custom_model_name = 'mla1608_0' AND auto_model_name = '' AND bankcard_model_name = '' AND 
									 Short_term_lending_model_name = '' AND Telecommunications_model_name = '' AND Crossindustry_model_name ='' AND AttributesVersionRequest = '' AND
									 custom2_model_name = '' AND custom3_model_name = '' AND custom4_model_name = '' AND custom5_model_name = '' AND
									 ~run_riskview_report;
// Brad wants to keep error message stating just first/last name, but also allow user to use unparsedfullname field in place of first/last fields if they want

rpt_period_error_message := 'Error - Input Value for ReportingPeriod must be 1 - 84 months.';
            
input_ok := map((( 
							((trim(packagedInput[1].name_first)<>'' and trim(packagedInput[1].name_last)<>'') or trim(packagedInput[1].unparsedfullname)<>'') and  	// name check
							(trim(packagedInput[1].ssn)<>'' or   																																																		// ssn check
								( trim(packagedInput[1].street_addr)<>'' and 																																													// address check
								(trim(packagedInput[1].z5)<>'' OR (trim(packagedInput[1].p_city_name)<>'' AND trim(packagedInput[1].St)<>'')))												// zip or city/state check
							)
								) or
							 (MLA_alone //if MLA requested by itself, bypass Riskview minimum input checks here.
							  ) or
							(unsigned)packagedInput[1].LexID <> 0) 
           and
        (ReportingPeriod > 0 and ReportingPeriod <= 84)
         => true,
       (( 
							((trim(packagedInput[1].name_first)<>'' and trim(packagedInput[1].name_last)<>'') or trim(packagedInput[1].unparsedfullname)<>'') and  	// name check
							(trim(packagedInput[1].ssn)<>'' or   																																																		// ssn check
								( trim(packagedInput[1].street_addr)<>'' and 																																													// address check
								(trim(packagedInput[1].z5)<>'' OR (trim(packagedInput[1].p_city_name)<>'' AND trim(packagedInput[1].St)<>'')))												// zip or city/state check
							)
								) or
							 (MLA_alone //if MLA requested by itself, bypass Riskview minimum input checks here.
							  ) or
							(unsigned)packagedInput[1].LexID <> 0) 
           and
        (ReportingPeriod <= 0 or ReportingPeriod > 84) // same as above, everything is good EXCEPT reportingperiod
         => ERROR(301,rpt_period_error_message),
							ERROR(301,error_message) // else if anything else is wrong, give the other error message first priority.
						);
		//output(input_ok);				
/* ***************************************
	 *      Gather Attributes/Scores:      *
   *************************************** */

	search_results_temp := ungroup(
	riskview.Search_Function(packagedInput,
		gateways,
		DataRestriction,
		AttributesVersionRequest, 
		auto_model_name, 
		bankcard_model_name, 
		Short_term_lending_model_name, 
		Telecommunications_model_name, 
		Crossindustry_model_name, 
		Custom_model_name,
		Custom2_model_name,
		Custom3_model_name,
		Custom4_model_name,
		Custom5_model_name,
		intended_purpose,
		prescreen_score_threshold, 
		isCalifornia_in_person,
		riskview.constants.online,
		run_riskview_report,//riskview.constants.no_riskview_report // don't run report in initial deployment
		DataPermission,
		SSNMask,
		DOBMask,
		DLMask,
		FilterLienTypes, 
		EndUserCompanyName,
		CustomerNumber,
		SecurityCode, 
		IncludeRecordsWithSSN,
	 IncludeBureauRecs, 
		ReportingPeriod, 
		IncludeLnJ,
		RetainInputDID,
		exception_score_reason

		) 
	);
	
	#if(Models.LIB_RiskView_Models().TurnOnValidation) // If TRUE, output the model results directly
		output(search_results_temp, named('Results'));
	#else // Else, this is a normal transaction and should be formatted for output appropriately
	search_results := ungroup(
		IF(TestDataEnabled, 
		RiskView.TestSeed_Function(packagedTestseedInput, 
				TestDataTableName, 
				AttributesVersionRequest, 
				auto_model_name, 
				bankcard_model_name, 
				Short_term_lending_model_name, 
				Telecommunications_model_name, 
				Crossindustry_model_name, 
				Custom_model_name,
				Custom2_model_name,
				Custom3_model_name,
				Custom4_model_name,
				Custom5_model_name,
				intended_purpose,
				prescreen_score_threshold,
				run_riskview_report,
				includeLnj),	// TestSeed Values
		  search_results_temp
	 )
   );	

/* ***************************************
	 *    Convert Search Results to name/value pairs for ESDL:   *
   *************************************** */
	
	iesp.share.t_NameValuePair intoVersion5(search_results le, INTEGER c) := TRANSFORM
		SELF.name := MAP(
			c=1	=> 'InputProvidedFirstName',
			c=2	=> 'InputProvidedLastName',
			c=3	=> 'InputProvidedStreetAddress',
			c=4	=> 'InputProvidedCity',
			c=5	=> 'InputProvidedState',
			c=6	=> 'InputProvidedZipCode',
			c=7	=> 'InputProvidedSSN',
			c=8	=> 'InputProvidedDateofBirth',
			c=9	=> 'InputProvidedPhone',
			c=10	=> 'InputProvidedLexID',
			c=11	=> 'SubjectRecordTimeOldest',
			c=12	=> 'SubjectRecordTimeNewest',
			c=13	=> 'SubjectNewestRecord12Month',
			c=14	=> 'SubjectActivityIndex03Month',
			c=15	=> 'SubjectActivityIndex06Month',
			c=16	=> 'SubjectActivityIndex12Month',
			c=17	=> 'SubjectAge',
			c=18	=> 'SubjectDeceased',
			c=19	=> 'SubjectSSNCount',
			c=20	=> 'SubjectStabilityIndex',
			c=21	=> 'SubjectStabilityPrimaryFactor',
			c=22	=> 'SubjectAbilityIndex',
			c=23	=> 'SubjectAbilityPrimaryFactor',
			c=24	=> 'SubjectWillingnessIndex',
			c=25	=> 'SubjectWillingnessPrimaryFactor',
			c=26	=> 'ConfirmationSubjectFound',
			c=27	=> 'ConfirmationInputName',
			c=28	=> 'ConfirmationInputDOB',
			c=29	=> 'ConfirmationInputSSN',
			c=30	=> 'ConfirmationInputAddress',
			c=31	=> 'SourceNonDerogProfileIndex',
			c=32	=> 'SourceNonDerogCount',
			c=33	=> 'SourceNonDerogCount03Month',
			c=34	=> 'SourceNonDerogCount06Month',
			c=35	=> 'SourceNonDerogCount12Month',
			c=36	=> 'SourceCredHeaderTimeOldest',
			c=37	=> 'SourceCredHeaderTimeNewest',
			// c=38	=> 'SourceDirectory',   -- removing from layout for change control request #2
			// c=39	=> 'SourceDirectoryCount',   -- removing from layout for change control request #2
			c=40	=> 'SourceVoterRegistration',
			// c=41	=> 'EstimatedAnnualIncome',   -- removing from layout for change control request #2
			c=42	=> 'EducationAttendance',
			c=43	=> 'EducationEvidence',
			c=44	=> 'EducationProgramAttended',
			c=45	=> 'EducationInstitutionPrivate',
			c=46	=> 'EducationInstitutionRating',
			c=47	=> 'ProfLicCount',
			c=48	=> 'ProfLicTypeCategory',
			c=49	=> 'BusinessAssociation',
			c=50	=> 'BusinessAssociationIndex',
			c=51	=> 'BusinessAssociationTimeOldest',
			c=52	=> 'BusinessTitleLeadership',
			c=53	=> 'AssetIndex',
			c=54	=> 'AssetIndexPrimaryFactor',
			c=55	=> 'AssetOwnership',
			c=56	=> 'AssetProp',
			c=57	=> 'AssetPropIndex',
			c=58	=> 'AssetPropEverCount',
			c=59	=> 'AssetPropCurrentCount',
			c=60	=> 'AssetPropCurrentTaxTotal',
			c=61	=> 'AssetPropPurchaseCount12Month',
			c=62	=> 'AssetPropPurchaseTimeOldest',
			c=63	=> 'AssetPropPurchaseTimeNewest',
			c=64	=> 'AssetPropNewestMortgageType',
			c=65	=> 'AssetPropEverSoldCount',
			c=66	=> 'AssetPropSoldCount12Month',
			c=67	=> 'AssetPropSaleTimeOldest',
			c=68	=> 'AssetPropSaleTimeNewest',
			c=69	=> 'AssetPropNewestSalePrice',
			c=70	=> 'AssetPropSalePurchaseRatio',
			c=71	=> 'AssetPersonal',
			c=72	=> 'AssetPersonalCount',
			c=73	=> 'PurchaseActivityIndex',
			c=74	=> 'PurchaseActivityCount',
			c=75	=> 'PurchaseActivityDollarTotal',
			c=76	=> 'DerogSeverityIndex',
			c=77	=> 'DerogCount',
			c=78	=> 'DerogCount12Month',
			c=79	=> 'DerogTimeNewest',
			c=80	=> 'CriminalFelonyCount',
			c=81	=> 'CriminalFelonyCount12Month',
			c=82	=> 'CriminalFelonyTimeNewest',
			c=83	=> 'CriminalNonFelonyCount',
			c=84	=> 'CriminalNonFelonyCount12Month',
			c=85	=> 'CriminalNonFelonyTimeNewest',
			c=86	=> 'EvictionCount',
			c=87	=> 'EvictionCount12Month',
			c=88	=> 'EvictionTimeNewest',
			c=89	=> 'LienJudgmentSeverityIndex',
			c=90	=> 'LienJudgmentCount',
			c=91	=> 'LienJudgmentCount12Month',
			c=92	=> 'LienJudgmentSmallClaimsCount',
			c=93	=> 'LienJudgmentCourtCount',
			c=94	=> 'LienJudgmentTaxCount',
			c=95	=> 'LienJudgmentForeclosureCount',
			c=96	=> 'LienJudgmentOtherCount',
			c=97	=> 'LienJudgmentTimeNewest',
			c=98	=> 'LienJudgmentDollarTotal',
			c=99	=> 'BankruptcyCount',
			c=100	=> 'BankruptcyCount24Month',
			c=101	=> 'BankruptcyTimeNewest',
			c=102	=> 'BankruptcyChapter',
			c=103	=> 'BankruptcyStatus',
			c=104	=> 'BankruptcyDismissed24Month',
			c=105	=> 'ShortTermLoanRequest',
			c=106	=> 'ShortTermLoanRequest12Month',
			c=107	=> 'ShortTermLoanRequest24Month',
			c=108	=> 'InquiryAuto12Month',
			c=109	=> 'InquiryBanking12Month',
			c=110	=> 'InquiryTelcom12Month',
			c=111	=> 'InquiryNonShortTerm12Month',
			c=112	=> 'InquiryShortTerm12Month',
			c=113	=> 'InquiryCollections12Month',
			c=114	=> 'SSNSubjectCount',
			c=115	=> 'SSNDeceased',
			c=116	=> 'SSNDateLowIssued',
			c=117	=> 'SSNProblems',
			c=118	=> 'AddrOnFileCount',
			c=119	=> 'AddrOnFileCorrectional',
			c=120	=> 'AddrOnFileCollege',
			c=121	=> 'AddrOnFileHighRisk',
			c=122	=> 'AddrInputTimeOldest',
			c=123	=> 'AddrInputTimeNewest',
			c=124	=> 'AddrInputLengthOfRes',
			c=125	=> 'AddrInputSubjectCount',
			c=126	=> 'AddrInputMatchIndex',
			c=127	=> 'AddrInputSubjectOwned',
			c=128	=> 'AddrInputDeedMailing',
			c=129	=> 'AddrInputOwnershipIndex',
			c=130	=> 'AddrInputPhoneService',
			c=131	=> 'AddrInputPhoneCount',
			c=132	=> 'AddrInputDwellType',
			c=133	=> 'AddrInputDwellTypeIndex',
			c=134	=> 'AddrInputDelivery',
			c=135	=> 'AddrInputTimeLastSale',
			c=136	=> 'AddrInputLastSalePrice',
			c=137	=> 'AddrInputTaxValue',
			c=138	=> 'AddrInputTaxYr',
			c=139	=> 'AddrInputTaxMarketValue',
			c=140	=> 'AddrInputAVMValue',
			c=141	=> 'AddrInputAVMValue12Month',
			c=142	=> 'AddrInputAVMRatio12MonthPrior',
			c=143	=> 'AddrInputAVMValue60Month',
			c=144	=> 'AddrInputAVMRatio60MonthPrior',
			c=145	=> 'AddrInputCountyRatio',
			c=146	=> 'AddrInputTractRatio',
			c=147	=> 'AddrInputBlockRatio',
			c=148	=> 'AddrInputProblems',
			c=149	=> 'AddrCurrentTimeOldest',
			c=150	=> 'AddrCurrentTimeNewest',
			c=151	=> 'AddrCurrentLengthOfRes',
			c=152	=> 'AddrCurrentSubjectOwned',
			c=153	=> 'AddrCurrentDeedMailing',
			c=154	=> 'AddrCurrentOwnershipIndex',
			c=155	=> 'AddrCurrentPhoneService',
			c=156	=> 'AddrCurrentDwellType',
			c=157	=> 'AddrCurrentDwellTypeIndex',
			c=158	=> 'AddrCurrentTimeLastSale',
			c=159	=> 'AddrCurrentLastSalesPrice',
			c=160	=> 'AddrCurrentTaxValue',
			c=161	=> 'AddrCurrentTaxYr',
			c=162	=> 'AddrCurrentTaxMarketValue',
			c=163	=> 'AddrCurrentAVMValue',
			c=164	=> 'AddrCurrentAVMValue12Month',
			c=165	=> 'AddrCurrentAVMRatio12MonthPrior',
			c=166	=> 'AddrCurrentAVMValue60Month',
			c=167	=> 'AddrCurrentAVMRatio60MonthPrior',
			c=168	=> 'AddrCurrentCountyRatio',
			c=169	=> 'AddrCurrentTractRatio',
			c=170	=> 'AddrCurrentBlockRatio',
			c=171	=> 'AddrCurrentCorrectional',
			c=172	=> 'AddrPreviousTimeOldest',
			c=173	=> 'AddrPreviousTimeNewest',
			c=174	=> 'AddrPreviousLengthOfRes',
			c=175	=> 'AddrPreviousSubjectOwned',
			c=176	=> 'AddrPreviousOwnershipIndex',
			c=177	=> 'AddrPreviousDwellType',
			c=178	=> 'AddrPreviousDwellTypeIndex',
			c=179	=> 'AddrPreviousCorrectional',
			c=180	=> 'AddrStabilityIndex',
			c=181	=> 'AddrChangeCount03Month',
			c=182	=> 'AddrChangeCount06Month',
			c=183	=> 'AddrChangeCount12Month',
			c=184	=> 'AddrChangeCount24Month',
			c=185	=> 'AddrChangeCount60Month',
			c=186	=> 'AddrLastMoveTaxRatioDiff',
			c=187	=> 'AddrLastMoveEconTrajectory',
			c=188	=> 'AddrLastMoveEconTrajectoryIndex',
			c=189	=> 'PhoneInputProblems',
			c=190	=> 'PhoneInputSubjectCount',
			c=191	=> 'PhoneInputMobile',
			c=192	=> 'AlertRegulatoryCondition',
			''
		);

		SELF.value := MAP(
			c=1	=>  le.InputProvidedFirstName	,
			c=2	=>  le.InputProvidedLastName	,
			c=3	=>  le.InputProvidedStreetAddress	,
			c=4	=>  le.InputProvidedCity	,
			c=5	=>  le.InputProvidedState	,
			c=6	=>  le.InputProvidedZipCode	,
			c=7	=>  le.InputProvidedSSN	,
			c=8	=>  le.InputProvidedDateofBirth	,
			c=9	=>  le.InputProvidedPhone	,
			c=10	=>  le.InputProvidedLexID	,
			c=11	=>  le.SubjectRecordTimeOldest	,
			c=12	=>  le.SubjectRecordTimeNewest	,
			c=13	=>  le.SubjectNewestRecord12Month	,
			c=14	=>  le.SubjectActivityIndex03Month	,
			c=15	=>  le.SubjectActivityIndex06Month	,
			c=16	=>  le.SubjectActivityIndex12Month	,
			c=17	=>  le.SubjectAge	,
			c=18	=>  le.SubjectDeceased	,
			c=19	=>  le.SubjectSSNCount	,
			c=20	=>  le.SubjectStabilityIndex	,
			c=21	=>  le.SubjectStabilityPrimaryFactor	,
			c=22	=>  le.SubjectAbilityIndex	,
			c=23	=>  le.SubjectAbilityPrimaryFactor	,
			c=24	=>  le.SubjectWillingnessIndex	,
			c=25	=>  le.SubjectWillingnessPrimaryFactor	,
			c=26	=>  le.ConfirmationSubjectFound	,
			c=27	=>  le.ConfirmationInputName	,
			c=28	=>  le.ConfirmationInputDOB	,
			c=29	=>  le.ConfirmationInputSSN	,
			c=30	=>  le.ConfirmationInputAddress	,
			c=31	=>  le.SourceNonDerogProfileIndex	,
			c=32	=>  le.SourceNonDerogCount	,
			c=33	=>  le.SourceNonDerogCount03Month	,
			c=34	=>  le.SourceNonDerogCount06Month	,
			c=35	=>  le.SourceNonDerogCount12Month	,
			c=36	=>  le.SourceCredHeaderTimeOldest	,
			c=37	=>  le.SourceCredHeaderTimeNewest	,
			// c=38	=>  le.SourceDirectory	,
			// c=39	=>  le.SourceDirectoryCount	,
			c=40	=>  le.SourceVoterRegistration	,
			// c=41	=>  le.EstimatedAnnualIncome	,
			c=42	=>  le.EducationAttendance	,
			c=43	=>  le.EducationEvidence	,
			c=44	=>  le.EducationProgramAttended	,
			c=45	=>  le.EducationInstitutionPrivate	,
			c=46	=>  le.EducationInstitutionRating	,
			c=47	=>  le.ProfLicCount	,
			c=48	=>  le.ProfLicTypeCategory	,
			c=49	=>  le.BusinessAssociation	,
			c=50	=>  le.BusinessAssociationIndex	,
			c=51	=>  le.BusinessAssociationTimeOldest	,
			c=52	=>  le.BusinessTitleLeadership	,
			c=53	=>  le.AssetIndex	,
			c=54	=>  le.AssetIndexPrimaryFactor	,
			c=55	=>  le.AssetOwnership	,
			c=56	=>  le.AssetProp	,
			c=57	=>  le.AssetPropIndex	,
			c=58	=>  le.AssetPropEverCount	,
			c=59	=>  le.AssetPropCurrentCount	,
			c=60	=>  le.AssetPropCurrentTaxTotal	,
			c=61	=>  le.AssetPropPurchaseCount12Month	,
			c=62	=>  le.AssetPropPurchaseTimeOldest	,
			c=63	=>  le.AssetPropPurchaseTimeNewest	,
			c=64	=>  le.AssetPropNewestMortgageType	,
			c=65	=>  le.AssetPropEverSoldCount	,
			c=66	=>  le.AssetPropSoldCount12Month	,
			c=67	=>  le.AssetPropSaleTimeOldest	,
			c=68	=>  le.AssetPropSaleTimeNewest	,
			c=69	=>  le.AssetPropNewestSalePrice	,
			c=70	=>  le.AssetPropSalePurchaseRatio	,
			c=71	=>  le.AssetPersonal	,
			c=72	=>  le.AssetPersonalCount	,
			c=73	=>  le.PurchaseActivityIndex	,
			c=74	=>  le.PurchaseActivityCount	,
			c=75	=>  le.PurchaseActivityDollarTotal	,
			c=76	=>  le.DerogSeverityIndex	,
			c=77	=>  le.DerogCount	,
			c=78	=>  le.DerogCount12Month	,
			c=79	=>  le.DerogTimeNewest	,
			c=80	=>  le.CriminalFelonyCount	,
			c=81	=>  le.CriminalFelonyCount12Month	,
			c=82	=>  le.CriminalFelonyTimeNewest	,
			c=83	=>  le.CriminalNonFelonyCount	,
			c=84	=>  le.CriminalNonFelonyCount12Month	,
			c=85	=>  le.CriminalNonFelonyTimeNewest	,
			c=86	=>  le.EvictionCount	,
			c=87	=>  le.EvictionCount12Month	,
			c=88	=>  le.EvictionTimeNewest	,
			c=89	=>  le.LienJudgmentSeverityIndex	,
			c=90	=>  le.LienJudgmentCount	,
			c=91	=>  le.LienJudgmentCount12Month	,
			c=92	=>  le.LienJudgmentSmallClaimsCount	,
			c=93	=>  le.LienJudgmentCourtCount	,
			c=94	=>  le.LienJudgmentTaxCount	,
			c=95	=>  le.LienJudgmentForeclosureCount	,
			c=96	=>  le.LienJudgmentOtherCount	,
			c=97	=>  le.LienJudgmentTimeNewest	,
			c=98	=>  le.LienJudgmentDollarTotal	,
			c=99	=>  le.BankruptcyCount 	,
			c=100	=>  le.BankruptcyCount24Month	,
			c=101	=>  le.BankruptcyTimeNewest	,
			c=102	=>  le.BankruptcyChapter	,
			c=103	=>  le.BankruptcyStatus	,
			c=104	=>  le.BankruptcyDismissed24Month	,
			c=105	=>  le.ShortTermLoanRequest	,
			c=106	=>  le.ShortTermLoanRequest12Month	,
			c=107	=>  le.ShortTermLoanRequest24Month	,
			c=108	=>  le.InquiryAuto12Month	,
			c=109	=>  le.InquiryBanking12Month	,
			c=110	=>  le.InquiryTelcom12Month	,
			c=111	=>  le.InquiryNonShortTerm12Month	,
			c=112	=>  le.InquiryShortTerm12Month	,
			c=113	=>  le.InquiryCollections12Month	,
			c=114	=>  le.SSNSubjectCount	,
			c=115	=>  le.SSNDeceased	,
			c=116	=>  le.SSNDateLowIssued	,
			c=117	=>  le.SSNProblems	,
			c=118	=>  le.AddrOnFileCount	,
			c=119	=>  le.AddrOnFileCorrectional	,
			c=120	=>  le.AddrOnFileCollege	,
			c=121	=>  le.AddrOnFileHighRisk	,
			c=122	=>  le.AddrInputTimeOldest	,
			c=123	=>  le.AddrInputTimeNewest	,
			c=124	=>  le.AddrInputLengthOfRes	,
			c=125	=>  le.AddrInputSubjectCount	,
			c=126	=>  le.AddrInputMatchIndex	,
			c=127	=>  le.AddrInputSubjectOwned	,
			c=128	=>  le.AddrInputDeedMailing	,
			c=129	=>  le.AddrInputOwnershipIndex	,
			c=130	=>  le.AddrInputPhoneService	,
			c=131	=>  le.AddrInputPhoneCount	,
			c=132	=>  le.AddrInputDwellType	,
			c=133	=>  le.AddrInputDwellTypeIndex	,
			c=134	=>  le.AddrInputDelivery	,
			c=135	=>  le.AddrInputTimeLastSale	,
			c=136	=>  le.AddrInputLastSalePrice	,
			c=137	=>  le.AddrInputTaxValue	,
			c=138	=>  le.AddrInputTaxYr	,
			c=139	=>  le.AddrInputTaxMarketValue	,
			c=140	=>  le.AddrInputAVMValue	,
			c=141	=>  le.AddrInputAVMValue12Month	,
			c=142	=>  le.AddrInputAVMRatio12MonthPrior	,
			c=143	=>  le.AddrInputAVMValue60Month	,
			c=144	=>  le.AddrInputAVMRatio60MonthPrior	,
			c=145	=>  le.AddrInputCountyRatio	,
			c=146	=>  le.AddrInputTractRatio	,
			c=147	=>  le.AddrInputBlockRatio	,
			c=148	=>  le.AddrInputProblems	,
			c=149	=>  le.AddrCurrentTimeOldest	,
			c=150	=>  le.AddrCurrentTimeNewest	,
			c=151	=>  le.AddrCurrentLengthOfRes 	,
			c=152	=>  le.AddrCurrentSubjectOwned 	,
			c=153	=>  le.AddrCurrentDeedMailing	,
			c=154	=>  le.AddrCurrentOwnershipIndex	,
			c=155	=>  le.AddrCurrentPhoneService	,
			c=156	=>  le.AddrCurrentDwellType 	,
			c=157	=>  le.AddrCurrentDwellTypeIndex	,
			c=158	=>  le.AddrCurrentTimeLastSale	,
			c=159	=>  le.AddrCurrentLastSalesPrice	,
			c=160	=>  le.AddrCurrentTaxValue	,
			c=161	=>  le.AddrCurrentTaxYr	,
			c=162	=>  le.AddrCurrentTaxMarketValue	,
			c=163	=>  le.AddrCurrentAVMValue	,
			c=164	=>  le.AddrCurrentAVMValue12Month	,
			c=165	=>  le.AddrCurrentAVMRatio12MonthPrior	,
			c=166	=>  le.AddrCurrentAVMValue60Month	,
			c=167	=>  le.AddrCurrentAVMRatio60MonthPrior	,
			c=168	=>  le.AddrCurrentCountyRatio	,
			c=169	=>  le.AddrCurrentTractRatio	,
			c=170	=>  le.AddrCurrentBlockRatio	,
			c=171	=>  le.AddrCurrentCorrectional	,
			c=172	=>  le.AddrPreviousTimeOldest	,
			c=173	=>  le.AddrPreviousTimeNewest	,
			c=174	=>  le.AddrPreviousLengthOfRes 	,
			c=175	=>  le.AddrPreviousSubjectOwned 	,
			c=176	=>  le.AddrPreviousOwnershipIndex	,
			c=177	=>  le.AddrPreviousDwellType 	,
			c=178	=>  le.AddrPreviousDwellTypeIndex	,
			c=179	=>  le.AddrPreviousCorrectional	,
			c=180	=>  le.AddrStabilityIndex	,
			c=181	=>  le.AddrChangeCount03Month	,
			c=182	=>  le.AddrChangeCount06Month	,
			c=183	=>  le.AddrChangeCount12Month	,
			c=184	=>  le.AddrChangeCount24Month	,
			c=185	=>  le.AddrChangeCount60Month	,
			c=186	=>  le.AddrLastMoveTaxRatioDiff	,
			c=187	=>  le.AddrLastMoveEconTrajectory	,
			c=188	=>  le.AddrLastMoveEconTrajectoryIndex	,
			c=189	=>  le.PhoneInputProblems	,
			c=190	=>  le.PhoneInputSubjectCount	,
			c=191	=>  le.PhoneInputMobile 	,
			c=192	=>  le.AlertRegulatoryCondition	,
			''
		);
	END;
	nameValuePairsVersion5 :=  NORMALIZE(search_results, 192, 
		intoVersion5(LEFT, COUNTER))(trim(value)<>'');  // if the value is blank, that attribute isn't part of the AttributesVersionRequest

/* ***************************************
	 *    Convert Model Results to ESDL:   *
   *************************************** */
	
	iesp.riskview2.t_RiskView2ModelHRI intoModel(search_results le, integer c) := TRANSFORM
		
		score_name := MAP(
			c=1	=> le.Auto_Score_Name,
			c=2	=> le.BankCard_Score_Name,
			c=3	=> le.Short_term_lending_Score_Name,
			c=4	=> le.Telecommunications_Score_Name,
			c=5	=> le.Crossindustry_Score_Name,
			c=6	=> le.Custom_Score_Name,
			c=7	=> le.Custom2_Score_Name,
			c=8	=> le.Custom3_Score_Name,
			c=9	=> le.Custom4_Score_Name,
			c=10	=> le.Custom5_Score_Name,
			''
		);
		
		score_type := MAP(
			c=1 => le.Auto_Type,
			c=2 => le.BankCard_Type,
			c=3 => le.Short_term_lending_Type,
			c=4 => le.Telecommunications_Type,
			c=5 => le.Crossindustry_Type,
			c=6 => le.Custom_Type,
			c=7 => le.Custom2_Type,
			c=8 => le.Custom3_Type,
			c=9 => le.Custom4_Type,
			c=10 => le.Custom5_Type,			
			''
		);

		score_value := MAP(
			c=1	=> le.auto_score,
			c=2	=> le.Bankcard_score,
			c=3	=> le.Short_term_lending_score,
			c=4	=> le.Telecommunications_score,
			c=5	=> le.Crossindustry_score,
			c=6	=> le.Custom_score,
			c=7 => le.Custom2_score,
			c=8 => le.Custom3_score,
			c=9 => le.Custom4_score,
			c=10 => le.Custom5_score,
			''
		);
		
		reason1 := MAP(
			c=1	=> le.auto_reason1,
			c=2	=> le.Bankcard_reason1,
			c=3	=> le.Short_term_lending_reason1,
			c=4	=> le.Telecommunications_reason1,
			c=5	=> le.Crossindustry_reason1,
			c=6	=> le.Custom_reason1,
			c=7	=> le.Custom2_reason1,
			c=8	=> le.Custom3_reason1,
			c=9	=> le.Custom4_reason1,
			c=10	=> le.Custom5_reason1,
			''
		);
		
		reason2 := MAP(
			c=1	=> le.auto_reason2,
			c=2	=> le.Bankcard_reason2,
			c=3	=> le.Short_term_lending_reason2,
			c=4	=> le.Telecommunications_reason2,
			c=5	=> le.Crossindustry_reason2,
			c=6	=> le.Custom_reason2,
			c=7	=> le.Custom2_reason2,
			c=8	=> le.Custom3_reason2,
			c=9	=> le.Custom4_reason2,
			c=10	=> le.Custom5_reason2,
			''
		);
		
		reason3 := MAP(
			c=1	=> le.auto_reason3,
			c=2	=> le.Bankcard_reason3,
			c=3	=> le.Short_term_lending_reason3,
			c=4	=> le.Telecommunications_reason3,
			c=5	=> le.Crossindustry_reason3,
			c=6	=> le.Custom_reason3,
			c=7	=> le.Custom2_reason3,
			c=8	=> le.Custom3_reason3,
			c=9	=> le.Custom4_reason3,
			c=10	=> le.Custom5_reason3,
			''
		);
		
		reason4 := MAP(
			c=1	=> le.auto_reason4,
			c=2	=> le.Bankcard_reason4,
			c=3	=> le.Short_term_lending_reason4,
			c=4	=> le.Telecommunications_reason4,
			c=5	=> le.Crossindustry_reason4,
			c=6	=> le.Custom_reason4,
			c=7	=> le.Custom2_reason4,
			c=8	=> le.Custom3_reason4,
			c=9	=> le.Custom4_reason4,
			c=10	=> le.Custom5_reason4,
			''
		);
		
		reason5 := MAP(
			c=1	=> le.auto_reason5,
			c=2	=> le.Bankcard_reason5,
			c=3	=> le.Short_term_lending_reason5,
			c=4	=> le.Telecommunications_reason5,
			c=5	=> le.Crossindustry_reason5,
			c=6	=> le.Custom_reason5,
			c=7	=> le.Custom2_reason5,
			c=8	=> le.Custom3_reason5,
			c=9	=> le.Custom4_reason5,
			c=10	=> le.Custom5_reason5,
			''
		);
		
		ds_reasons := DATASET([
			{1, reason1, Risk_Indicators.getHRIDesc(reason1)},
			{2, reason2, Risk_Indicators.getHRIDesc(reason2)},
			{3, reason3, Risk_Indicators.getHRIDesc(reason3)},
			{4, reason4, Risk_Indicators.getHRIDesc(reason4)},
			{5, reason5, Risk_Indicators.getHRIDesc(reason5)}
			], iesp.riskview2.t_RiskView2RiskIndicator)(ReasonCode NOT IN ['','00']); // Only keep the valid reason codes
		
		self.name := score_name;
		
		SELF.Scores := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.riskview2.t_RiskView2ScoreHRI,
			self.value := (unsigned)score_value;
			self._type := score_type;
			self.ScoreReasons := ds_reasons;
			));
	END;
	
	modelResults := normalize(	search_results , 9, intoModel(LEFT, counter)	)(name<>'');
	
	/* ***************************************
	 *    Convert Search Results to alert code/description pairs for ESDL:   *
   *************************************** */
	
	iesp.riskview2.t_RiskView2Alert norm_alerts(search_results le, INTEGER c) := TRANSFORM
		
		SELF.code := MAP(
			c=1	=> le.alert1,
			c=2	=> le.alert2,
			c=3	=> le.alert3,
			c=4	=> le.alert4,
			c=5	=> le.alert5,
			c=6	=> le.alert6,
			c=7	=> le.alert7,
			c=8	=> le.alert8,
			c=9	=> le.alert9,
			c=10	=> le.alert10,
			''
		);

		SELF.description := MAP(
			c=1	=>  if(le.alert1<>'', risk_indicators.getHRIDesc(le.alert1), ''),
			c=2	=>  if(le.alert2<>'', risk_indicators.getHRIDesc(le.alert2), ''),
			c=3	=>  if(le.alert3<>'', risk_indicators.getHRIDesc(le.alert3), ''),
			c=4	=>  if(le.alert4<>'', risk_indicators.getHRIDesc(le.alert4), ''),
			c=5	=>  if(le.alert5<>'', risk_indicators.getHRIDesc(le.alert5), ''),
			c=6	=>  if(le.alert6<>'', risk_indicators.getHRIDesc(le.alert6), ''),
			c=7	=>  if(le.alert7<>'', risk_indicators.getHRIDesc(le.alert7), ''),
			c=8	=>  if(le.alert8<>'', risk_indicators.getHRIDesc(le.alert8), ''),
			c=9	=>  if(le.alert9<>'', risk_indicators.getHRIDesc(le.alert9), ''),
			c=10	=>  if(le.alert10<>'', risk_indicators.getHRIDesc(le.alert10), ''),
			''
		);
	END;
	nameValuePairsAlerts :=  NORMALIZE(search_results, 10, norm_alerts(LEFT, COUNTER))(code<>'');

	model_info := Models.LIB_RiskView_Models().ValidV50Models;
	Custom_info := model_info(Model_Name = 'MLA1608_0')[1];

	iesp.share.t_NameValuePair norm_LnJ(search_results le, INTEGER c) := TRANSFORM
		
		SELF.name := MAP(
		 c=1 => 'LnJEvictionTotalCount'        ,
		 c=2 => 'LnJEvictionTotalCount12Month',
		 c=3 => 'LnJEvictionTimeNewest'        ,
		 c=4 => 'LnJJudgmentSmallClaimsCount'  ,
		 c=5 => 'LnJJudgmentCourtCount'        ,
		 c=6 => 'LnJJudgmentForeclosureCount'  ,
		 c=7 => 'LnJLienJudgmentSeverityIndex' ,
		 c=8 => 'LnJLienJudgmentCount'         ,
		 c=9 => 'LnJLienJudgmentCount12Month'  ,
		 c=10=> 'LnJLienTaxCount'              ,
		 c=11 => 'LnJLienJudgmentOtherCount'    ,
		 c=12 => 'LnjLienJudgmentTimeNewest'    ,
		 c=13 => 'LnJLienJudgmentDollarTotal'   ,
		 c=14 => 'LnJLienCount'                 ,
		 c=15 => 'LnJLienTimeNewest'           ,
		 c=16 => 'LnJLienDollarTotal'           ,
		 c=17 => 'LnJLienTaxTimeNewest'         ,
		 c=18 => 'LnJLienTaxDollarTotal'        ,
		 c=19 => 'LnJLienTaxStateCount'         ,
		 c=20 => 'LnJLienTaxStateTimeNewest'    ,
		 c=21 => 'LnJLienTaxStateDollarTotal'   ,
		 c=22 => 'LnJLienTaxFederalCount'       ,
		 c=23 => 'LnJLienTaxFederalTimeNewest'  ,
		 c=24 => 'LnJLienTaxFederalDollarTotal' ,
		 c=25 => 'LnJJudgmentCount'             ,
		 c=26 => 'LnJJudgmentTimeNewest'        ,
		 c=27 => 'LnJJudgmentDollarTotal' ,
		 ''	);

		SELF.value := MAP(
			c=1 => le.LnJEvictionTotalCount        ,
			c=2 => le.LnJEvictionTotalCount12Month,
			c=3 => le.LnJEvictionTimeNewest        ,
			c=4 => le.LnJJudgmentSmallClaimsCount  ,
			c=5 => le.LnJJudgmentCourtCount        ,
			c=6 => le.LnJJudgmentForeclosureCount  ,																
			c=7 => le.LnJLienJudgmentSeverityIndex ,
			c=8 => le.LnJLienJudgmentCount         ,
			c=9 => le.LnJLienJudgmentCount12Month  ,
			c=10 => le.LnJLienTaxCount              ,
			c=11 => le.LnJLienJudgmentOtherCount    ,
			c=12 => le.LnjLienJudgmentTimeNewest    ,
			c=13 => le.LnJLienJudgmentDollarTotal   ,

			c=14 => le.LnJLienCount                 ,
			c=15 => le.LnJLienTimeNewest           ,
			c=16 => le.LnJLienDollarTotal           ,
			c=17 => le.LnJLienTaxTimeNewest         ,
			c=18 => le.LnJLienTaxDollarTotal       ,
			c=19 => le.LnJLienTaxStateCount         ,
			c=20 => le.LnJLienTaxStateTimeNewest    ,
			c=21 => le.LnJLienTaxStateDollarTotal   ,
			c=22 => le.LnJLienTaxFederalCount      ,
			c=23 => le.LnJLienTaxFederalTimeNewest  ,
			c=24 => le.LnJLienTaxFederalDollarTotal ,
			c=25 => le.LnJJudgmentCount             ,
			c=26 => le.LnJJudgmentTimeNewest        ,
			c=27 => le.LnJJudgmentDollarTotal,
			''
		);
	END;

	LnJReport := NORMALIZE(search_results, 27, norm_LnJ(LEFT, COUNTER))(trim(value)<>'');
	
	LnJ_liens := project(search_results[1].LnJliens, 
		transform(iesp.riskview2.t_RiskView2LiensJudgmentsReportForLien,
			self.seq := (string) left.seq;
			self.DateFiled := iesp.ECL2ESP.toDate((integer)left.DateFiled);
			self.ReleaseDate := iesp.ECL2ESP.toDate((integer)left.ReleaseDate);
			self.DateLastSeen := iesp.ECL2ESP.toDate((integer)left.DateLastSeen);
			self := left;
			self := [];
		));
	LnJ_jdgmts := project(search_results[1].LnJJudgments, 
		transform(iesp.riskview2.t_RiskView2LiensJudgmentsReportForJudgement,
			self.seq := (string) left.seq;
			self.DateFiled := iesp.ECL2ESP.toDate((integer)left.DateFiled);
			self.ReleaseDate := iesp.ECL2ESP.toDate((integer)left.ReleaseDate);
			self.DateLastSeen := iesp.ECL2ESP.toDate((integer)left.DateLastSeen);
			self := left;
			self := [];
		));
	
	valid_riskview_xml_response := project(search_results,
		transform(iesp.riskview2.t_RiskView2Response,
				self.Result.UniqueId := LEFT.LexID;
				self.Result.InputEcho := search;
				self.Result.Models := modelResults;
			  self.Result.AttributesGroup.name := StringLib.StringToUpperCase(AttributesVersionRequest);
			  self.Result.AttributesGroup.attributes := nameValuePairsVersion5;
				self.Result.Alerts := nameValuePairsAlerts;
				// self.Result.Report.ConsumerStatement := left.ConsumerStatementText;
				self.Result.Report := left.report;
				
				self.Result.ConsumerStatements := if(OutputConsumerStatements, left.ConsumerStatements);
				self.Result.LiensJudgmentsReports.Liens := LnJ_liens;
				self.Result.LiensJudgmentsReports.Judgments := LnJ_jdgmts;
				self.Result.LiensJudgmentsReports.LnJAttributes := LnJReport; 

        
        // for inquiry logging, populate the consumer section with the DID and input fields
        // don't log the lexid if the person got a noscore
        self.Result.Consumer.LexID := if(riskview.constants.noScoreAlert in [left.Alert1,left.Alert2,left.Alert3,left.Alert4,left.Alert5,left.Alert6,left.Alert7,left.Alert8,left.Alert9,left.Alert10], '', left.LexID);
        searchDOB := iesp.ECL2ESP.t_DateToString8(search.DOB);
		    SELF.Result.Consumer.Inquiry.DOB := IF((UNSIGNED)searchDOB > 0, searchDOB, '');
        self.Result.Consumer.Inquiry.Phone10 := search.HomePhone;
        self.Result.Consumer.Inquiry := search;      

				//For MLA, we need to populate the exception area of the result if there was an error flagged in the MLA process.  The
				//Exception_code field will contain the error code...use it to look up the description and format the exception record.
				ds_excep_blank := DATASET([], iesp.share.t_WsException); 
				
				ds_excep := DATASET([{'Roxie', 
															 left.Exception_code,  
															 '', 									
															 RiskView.Constants.MLA_error_desc(left.Exception_code)}], iesp.share.t_WsException); 

				SELF._Header.Exceptions := if((custom_model_name  = 'mla1608_0' or custom2_model_name = 'mla1608_0' or 
																			 custom3_model_name = 'mla1608_0' or custom4_model_name = 'mla1608_0' or 
																			 custom5_model_name = 'mla1608_0') and left.Exception_code <> '',
																			ds_excep, 
																			ds_excep_blank);

				SELF._Header := [];
	));

invalid_input_xml_response := project(search_results,
		transform(iesp.riskview2.t_RiskView2Response,
				self.Result.InputEcho := search;
				SELF := [];
	));

riskview_xml := if(input_ok, valid_riskview_xml_response, invalid_input_xml_response);		

output( riskview_xml, named( 'Results' ) );
// output(LnJ_liens, named('LnJ_liens'));
// output(LnJ_jdgmts, named('LnJ_jdgmts'));
// output(LnJReport, named('LnJReport'));
MLA_royalties := IF(TestDataEnabled, Royalty.RoyaltyMLA.GetNoRoyalties(), Royalty.RoyaltyMLA.GetOnlineRoyalties(search_results_temp));

OUTPUT(MLA_royalties, NAMED('RoyaltySet'));

// ****************************** temporarily turn off intermediate logging in Riskview to see how much latency improves ****************************

// intermediateLog := DATASET([], Risk_Reporting.Layouts.LOG_Boca_Shell) : STORED('Intermediate_Log');

// Note: All intermediate logs must have the following name schema:
// Starts with 'LOG_' (Upper case is important!!)
// Middle part is the database name, in this case: 'log__mbs__fcra'
// Must end with '_intermediate__log'

// OUTPUT( intermediateLog, NAMED('LOG_log__mbs__fcra_intermediate__log'));
// ****************************** temporarily turn off intermediate logging in Riskview to see how much latency improves ****************************

//Log to Deltabase
Deltabase_Logging_prep := project(riskview_xml, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																												 self.company_id := (Integer)CompanyID,
																												 self.login_id := _LoginID,
																												 self.product_id := Risk_Reporting.ProductID.RiskView__Search_Service,
																												 self.function_name := FunctionName,
																												 self.esp_method := ESPMethod,
																												 self.interface_version := InterfaceVersion,
																												 self.delivery_method := DeliveryMethod,
																												 self.date_added := (STRING8)Std.Date.Today(),
																												 self.death_master_purpose := DeathMasterPurpose,
																												 self.ssn_mask := SSNMask,
																												 self.dob_mask := DOBMask,
																												 self.dl_mask := (String)(Integer)DLMask,
																												 self.exclude_dmv_pii := (String)(Integer)ExcludeDMVPII,
																												 self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
																												 self.archive_opt_in := (String)(Integer)ArchiveOptIn,
                                                         self.glb := (Integer)users.GLBPurpose,
                                                         self.dppa := (Integer)users.DLPurpose,
																												 self.data_restriction_mask := DataRestriction,
																												 self.data_permission_mask := DataPermission,
																												 self.industry := Industry_Search[1].Industry,
																												 self.i_attributes_name := AttributesVersionRequest,
																												 self.i_ssn := search.SSN,
                                                         self.i_dob := DateOfBirth,
                                                         self.i_name_full := search.Name.Full,
																												 self.i_name_first := search.Name.First,
																												 self.i_name_last := search.Name.Last,
																												 self.i_lexid := (Integer)search.UniqueId, 
																												 self.i_address := streetAddr,
																												 self.i_city := search.Address.City,
																												 self.i_state := search.Address.State,
																												 self.i_zip := search.Address.Zip5,
																												 self.i_dl := search.DriverLicenseNumber,
																												 self.i_dl_state := search.DriverLicenseState,
                                                         self.i_home_phone := HomePhone,
                                                         self.i_work_phone := WorkPhone,
																												 model_count := count(option.IncludeModels.Names);
																												 self.i_model_name_1 := option.IncludeModels.Names[1].value,
																												 //Check to see if there was more than one model requested
																												 extra_score := model_count > 1;
																												 self.i_model_name_2 := IF(extra_score, option.IncludeModels.Names[2].value, ''),
																												 self.o_score_1    := (String)left.Result.Models[1].Scores[1].Value,
																												 self.o_reason_1_1 := left.Result.Models[1].Scores[1].ScoreReasons[1].ReasonCode,
																												 self.o_reason_1_2 := left.Result.Models[1].Scores[1].ScoreReasons[2].ReasonCode,
																												 self.o_reason_1_3 := left.Result.Models[1].Scores[1].ScoreReasons[3].ReasonCode,
																												 self.o_reason_1_4 := left.Result.Models[1].Scores[1].ScoreReasons[4].ReasonCode,
																												 self.o_reason_1_5 := left.Result.Models[1].Scores[1].ScoreReasons[5].ReasonCode,
																												 self.o_reason_1_6 := left.Result.Models[1].Scores[1].ScoreReasons[6].ReasonCode,
																												 self.o_score_2    := IF(extra_score, (String)left.Result.Models[2].Scores[1].Value, ''),
																												 self.o_reason_2_1 := IF(extra_score, left.Result.Models[2].Scores[1].ScoreReasons[1].ReasonCode, ''),
																												 self.o_reason_2_2 := IF(extra_score, left.Result.Models[2].Scores[1].ScoreReasons[2].ReasonCode, ''),
																												 self.o_reason_2_3 := IF(extra_score, left.Result.Models[2].Scores[1].ScoreReasons[3].ReasonCode, ''),
																												 self.o_reason_2_4 := IF(extra_score, left.Result.Models[2].Scores[1].ScoreReasons[4].ReasonCode, ''),
																												 self.o_reason_2_5 := IF(extra_score, left.Result.Models[2].Scores[1].ScoreReasons[5].ReasonCode, ''),
																												 self.o_reason_2_6 := IF(extra_score, left.Result.Models[2].Scores[1].ScoreReasons[6].ReasonCode, ''),
																												 self.o_lexid      := (Integer)left.Result.UniqueId,
																												 self := left,
																												 self := [] ));
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);

//Improved Scout Logging
IF(~DisableOutcomeTracking and ~TestDataEnabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs__fcra_transaction__log__scout')));

#end

/*--HELP-- 
<pre>
&lt;RiskView2Request&gt;
  &lt;Row&gt;
    &lt;SearchBy&gt;
      &lt;UniqueID&gt;&lt;/UniqueID&gt;
      &lt;Name&gt;
        &lt;Full&gt;&lt;/Full&gt;
        &lt;Prefix&gt;&lt;/Prefix&gt;
        &lt;First&gt;&lt;/First&gt;
        &lt;Middle&gt;&lt;/Middle&gt;
        &lt;Last&gt;&lt;/Last&gt;
        &lt;Suffix&gt;&lt;/Suffix&gt;
      &lt;/Name&gt;
      &lt;Address&gt;
        &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
        &lt;City&gt;&lt;/City&gt;
        &lt;State&gt;&lt;/State&gt;
        &lt;Zip5&gt;&lt;/Zip5&gt;
        &lt;County&gt;&lt;/County&gt;
        &lt;StreetNumber&gt;&lt;/StreetNumber&gt;
        &lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt;
        &lt;StreetName&gt;&lt;/StreetName&gt;
        &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
        &lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt;
        &lt;UnitNumber&gt;&lt;/UnitNumber&gt;
        &lt;UnitDesignation&gt;&lt;/UnitDesignation&gt;
      &lt;/Address&gt;
      &lt;DOB&gt;
        &lt;Year&gt;&lt;/Year&gt;
        &lt;Month&gt;&lt;/Month&gt;
        &lt;Day&gt;&lt;/Day&gt;
      &lt;/DOB&gt;
      &lt;SSN&gt;&lt;/SSN&gt;
      &lt;HomePhone&gt;&lt;/HomePhone&gt;
      &lt;WorkPhone&gt;&lt;/WorkPhone&gt;
      &lt;DriverLicenseNumber&gt;&lt;/DriverLicenseNumber&gt;
      &lt;DriverLicenseState&gt;&lt;/DriverLicenseState&gt;
    &lt;/SearchBy&gt;  
    &lt;Options&gt;
      &lt;AttributesVersionRequest&gt;RiskViewAttrV5&lt;/AttributesVersionRequest&gt;
      &lt;IntendedPurpose&gt;&lt;/IntendedPurpose&gt;
      &lt;IncludeReport&gt;&lt;/IncludeReport&gt;
      &lt;IncludeModels&gt;
       &lt;Names&gt;
         &lt;Name&gt;&lt;/Name&gt;
       &lt;/Names&gt;
       &lt;ModelOptions&gt;
        &lt;ModelOption&gt;
         &lt;OptionName&gt;inpersonapplicant&lt;/OptionName&gt;
         &lt;OptionValue&gt;0&lt;/OptionValue&gt;
        &lt;/ModelOption&gt;
       &lt;/ModelOptions&gt;
     &lt;/IncludeModels&gt;
		&lt;FFDOptionsMask&gt;&lt;/FFDOptionsMask&gt;
		&lt;IncludeLiensJudgmentsReport&gt;&lt;/IncludeLiensJudgmentsReport&gt;
		&lt;LiensJudgmentsReportOptions&gt;
		 &lt;IncludeRecordsWithSSN&gt;&lt;/IncludeRecordsWithSSN&gt;
		 &lt;IncludeBureauRecs&gt;&lt;/IncludeBureauRecs&gt;
   &lt;ReportingPeriod&gt;&lt;/ReportingPeriod&gt;
		 &lt;ExcludeCityTaxLiens&gt;&lt;/ExcludeCityTaxLiens&gt;
		 &lt;ExcludeCountyTaxLiens&gt;&lt;/ExcludeCountyTaxLiens&gt;
		 &lt;ExcludeStateTaxWarrants&gt;&lt;/ExcludeStateTaxWarrants&gt;
		 &lt;ExcludeStateTaxLiens&gt;&lt;/ExcludeStateTaxLiens&gt;
		 &lt;ExcludeFederalTaxLiens&gt;&lt;/ExcludeFederalTaxLiens&gt;
		 &lt;ExcludeOtherLiens&gt;&lt;/ExcludeOtherLiens&gt;
		 &lt;ExcludeJudgments&gt;&lt;/ExcludeJudgments&gt;
		 &lt;ExcludeEvictions&gt;&lt;/ExcludeEvictions&gt;
    &lt;/LiensJudgmentsReportOptions&gt
    &lt;/Options&gt;
    &lt;User&gt;
      &lt;ReferenceCode&gt;&lt;/ReferenceCode&gt;
      &lt;BillingCode&gt;&lt;/BillingCode&gt;
      &lt;QueryId&gt;&lt;/QueryId&gt;
      &lt;AccountNumber&gt;&lt;/AccountNumber&gt;
      &lt;GLBPurpose&gt;5&lt;/GLBPurpose&gt;
      &lt;DLPurpose&gt;0&lt;/DLPurpose&gt;
      &lt;DataRestrictionMask&gt;&lt;/DataRestrictionMask&gt; 
      &lt;DataPermissionMask&gt;&lt;/DataPermissionMask&gt; 
      &lt;TestDataEnabled&gt;0&lt;/TestDataEnabled&gt; 
      &lt;TestDataTableName&gt;&lt;/TestDataTableName&gt; 
    &lt;/User&gt;
  &lt;/Row&gt;
&lt;/RiskView2Request&gt;
</pre>
*/ 

ENDMACRO;