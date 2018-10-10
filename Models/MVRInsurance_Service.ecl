/*--SOAP--
<message name="MVRInsurance_Service">
	<!-- XML INPUT -->
	<part name="FcraInsuranceModelRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="4"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="TestDataEnabled" type="xsd:boolean"/>
	<part name="TestDataTableName" type="xsd:string"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	</message>
*/
/*--INFO-- LexisNexis MVR Insurance real-time service */
/*--HELP-- 
<pre>
&lt;FcraInsuranceModelRequest&gt;
  &lt;Row&gt;
    &lt;User&gt;
      &lt;ReferenceCode&gt;&lt;/ReferenceCode&gt;
      &lt;BillingCode&gt;&lt;/BillingCode&gt;
      &lt;QueryID&gt;&lt;/QueryID&gt;
      &lt;CompanyID&gt;&lt;/CompanyID&gt;
      &lt;GLBPurpose&gt;&lt;/GLBPurpose&gt;
      &lt;DLPurpose&gt;&lt;/DLPurpose&gt;
      &lt;LoginHistoryID&gt;&lt;/LoginHistoryID&gt;
      &lt;DebitUnits&gt;0&lt;/DebitUnits&gt;
      &lt;IP&gt;&lt;/IP&gt;
      &lt;IndustryClass&gt;&lt;/IndustryClass&gt;
      &lt;resultformat&gt;&lt;/resultformat&gt;
      &lt;logasfunction&gt;&lt;/logasfunction&gt;
      &lt;ssnmask&gt;&lt;/ssnmask&gt;
      &lt;dobmask&gt;&lt;/dobmask&gt;
      &lt;dlmask&gt;false&lt;/dlmask&gt;
      &lt;datarestrictionmask&gt;&lt;/datarestrictionmask&gt;
      &lt;datapermissionmask&gt;&lt;/datapermissionmask&gt;
      &lt;ssnmaskingon&gt;false&lt;/ssnmaskingon&gt;
      &lt;dlmaskingon&gt;false&lt;/dlmaskingon&gt;
      &lt;EndUser&gt;
        &lt;companyname&gt;&lt;/companyname&gt;
        &lt;streetaddress1&gt;&lt;/streetaddress1&gt;
        &lt;city&gt;&lt;/city&gt;
        &lt;state&gt;&lt;/state&gt;
        &lt;zip5&gt;&lt;/zip5&gt;
      &lt;/EndUser&gt;
      &lt;maxwaitseconds&gt;0&lt;/maxwaitseconds&gt;
      &lt;relatedtransactionid&gt;&lt;/relatedtransactionid&gt;
      &lt;accountnumber&gt;&lt;/accountnumber&gt;
    &lt;/User&gt;
    &lt;remotelocations&gt;&lt;/remotelocations&gt;
    &lt;servicelocations&gt;&lt;/servicelocations&gt;
    &lt;alerttokensets&gt;&lt;/alerttokensets&gt;
    &lt;Options&gt;
      &lt;blind&gt;false&lt;/blind&gt;
      &lt;encrypt&gt;false&lt;/encrypt&gt;
      &lt;returntokens&gt;false&lt;/returntokens&gt;
      &lt;permissibleuse&gt;&lt;/permissibleuse&gt;
      &lt;ModelRequests&gt;
        &lt;ModelRequest&gt;
          &lt;ModelName&gt;WOMV002.0.0&lt;/ModelName&gt;
        &lt;/ModelRequest&gt;
      &lt;/ModelRequests&gt;
    &lt;/Options&gt;
    &lt;SearchBy&gt;
      &lt;Name&gt;
        &lt;full&gt;&lt;/full&gt;
        &lt;first&gt;&lt;/first&gt;
        &lt;middle&gt;&lt;/middle&gt;
        &lt;last&gt;&lt;/last&gt;
        &lt;suffix&gt;&lt;/suffix&gt;
        &lt;prefix&gt;&lt;/prefix&gt;
      &lt;/Name&gt;
      &lt;Address&gt;
        &lt;streetnumber&gt;&lt;/streetnumber&gt;
        &lt;streetpredirection&gt;&lt;/streetpredirection&gt;
        &lt;streetname&gt;&lt;/streetname&gt;
        &lt;streetsuffix&gt;&lt;/streetsuffix&gt;
        &lt;streetpostdirection&gt;&lt;/streetpostdirection&gt;
        &lt;unitdesignation&gt;&lt;/unitdesignation&gt;
        &lt;unitnumber&gt;&lt;/unitnumber&gt;
        &lt;streetaddress1&gt;&lt;/streetaddress1&gt;
        &lt;streetaddress2&gt;&lt;/streetaddress2&gt;
        &lt;city&gt;&lt;/city&gt;
        &lt;state&gt;&lt;/state&gt;
        &lt;zip5&gt;&lt;/zip5&gt;
        &lt;zip4&gt;&lt;/zip4&gt;
        &lt;county&gt;&lt;/county&gt;
        &lt;postalcode&gt;&lt;/postalcode&gt;
        &lt;statecityzip&gt;&lt;/statecityzip&gt;
      &lt;/Address&gt;
      &lt;DOB&gt;
        &lt;Year&gt;0&lt;/Year&gt;
        &lt;Month&gt;0&lt;/Month&gt;
        &lt;Day&gt;0&lt;/Day&gt;
      &lt;/DOB&gt;
      &lt;SSN&gt;&lt;/SSN&gt;
      &lt;DriverLicenseNumber&gt;&lt;/DriverLicenseNumber&gt;
      &lt;DriverLicenseState&gt;&lt;/DriverLicenseState&gt;
      &lt;HomePhone&gt;&lt;/HomePhone&gt;
      &lt;WorkPhone&gt;&lt;/WorkPhone&gt;
    &lt;/SearchBy&gt;
  &lt;/Row&gt;
&lt;/FcraInsuranceModelRequest&gt;
</pre>
*/


EXPORT MVRInsurance_Service := MACRO

	IMPORT Risk_Indicators, UT, iesp, Address, Seed_Files;
	
	validModels := ['WOMV002.0.0', 
									'MV361006.0.0', 
									'MX361006.0.0', 
									'MV361006.1.0', 
									'MX361006.1.0', 
									'MNC21106.0.0', // DHDB Non-Clear
									'RVR611.0.0',		// RiskView Retail
									'MPX1211.0.0'   // DHDB Partial Score for MPX1/MPV1 (Progressive)
									// 'RVR1003.0.0'		// RiskView Retail v3
									];
	
	#STORED('InsuranceMode', true);

	/* *******************************************
   *               Get XML Input               *
   ********************************************* */
	ds_in    := DATASET([], iesp.mvrinsurance.fcrainsurance.t_FcraInsuranceModelRequest)  : STORED('FcraInsuranceModelRequest', FEW);
	gateways_in := Gateway.Configuration.Get();
	UNSIGNED3 history_date := 999999                                                  		: STORED('HistoryDateYYYYMM');
	STRING50 DataRestriction := Risk_Indicators.iid_Constants.default_DataRestriction 		: STORED('DataRestrictionMask');
	STRING50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission 			: STORED('DataPermissionMask');
	BOOLEAN  TestDataEnabled   := FALSE																										:	STORED('TestDataEnabled');
	STRING20 TestDataTableName := ''																											:	STORED('TestDataTableName');
	
	/* *******************************************
   *         Filter Out Targus Gateway         *
   ********************************************* */
	Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
		SELF.servicename := le.servicename;
		SELF.url := IF(le.servicename IN ['targus'], '', le.url);
		self := le;
	END;
	gateways := PROJECT(gateways_in, gw_switch(LEFT));

	/* *******************************************
   *           Add Sequence to Input           *
   ********************************************* */
	layoutAcctSeq := RECORD
		INTEGER4 seq;
		ds_in;
	END;
	withSeq := PROJECT(ds_in, TRANSFORM(layoutAcctSeq, SELF.seq := COUNTER, SELF := LEFT));
	
	inputRecord := withSeq[1]; // Realtime service - Only one record on input
	
	/* *******************************************
   *               Clean Up Input              *
   ********************************************* */
	Risk_Indicators.Layout_Input into(withSeq le) := TRANSFORM
		SELF.seq := le.seq;
		SELF.ssn := le.searchBy.ssn;
		dob :=                    le.searchBy.dob.year
		    + intformat((INTEGER1)le.searchBy.dob.month, 2, 1)
		    + intformat((INTEGER1)le.searchBy.dob.day,   2, 1);
		SELF.dob := dob;
		SELF.age := (STRING3)ut.GetAgeI_asOf((UNSIGNED8)dob, (UNSIGNED)Risk_Indicators.iid_Constants.myGetDate(history_date));		
		fullName := TRIM(le.searchBy.Name.Full);
		cleanName := Address.CleanPerson73(fullName);
		title := IF(le.searchBy.Name.prefix = '' AND fullName != '', TRIM((cleanName[1..5])), le.searchBy.Name.prefix);
		firstName := IF(le.searchBy.Name.first = '' AND fullName != '', TRIM((cleanName[6..25])), le.searchBy.Name.first);
		middleName := IF(le.searchBy.Name.middle= '' AND fullName != '', TRIM((cleanName[26..45])), le.searchBy.Name.middle);
		lastName := IF(le.searchBy.Name.last  = '' AND fullName != '', TRIM((cleanName[46..65])), le.searchBy.Name.last);
		suffix := IF(le.searchBy.Name.suffix = '' AND fullName != '', TRIM((cleanName[66..70])), le.searchBy.Name.suffix);
		
		SELF.title  := StringLib.stringToUpperCase(title);
		SELF.fname  := StringLib.stringToUpperCase(firstName);
		SELF.mname  := StringLib.stringToUpperCase(middleName);
		SELF.lname  := StringLib.stringToUpperCase(lastName);
		SELF.suffix := StringLib.stringToUpperCase(suffix);
		
		addr_value := IF(TRIM(le.searchBy.address.streetaddress1) != '', le.searchBy.address.streetaddress1,
				Address.Addr1FromComponents(le.searchBy.address.streetnumber, le.searchBy.address.streetpredirection, le.searchBy.address.streetname,
					le.searchBy.address.streetsuffix, le.searchBy.address.streetpostdirection, le.searchBy.address.unitdesignation, le.searchBy.address.unitnumber));

		clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, le.searchBy.address.city, le.searchBy.address.state, le.searchBy.address.zip5);

		SELF.in_streetAddress := addr_value;
		SELF.in_city          := le.searchby.address.city;
		SELF.in_state         := le.searchby.address.state;
		SELF.in_zipCode       := le.searchby.address.zip5;	
		SELF.prim_range       := clean_a2[1..10];
		SELF.predir           := clean_a2[11..12];
		SELF.prim_name        := clean_a2[13..40];
		SELF.addr_suffix      := clean_a2[41..44];
		SELF.postdir          := clean_a2[45..46];
		SELF.unit_desig       := clean_a2[47..56];
		SELF.sec_range        := clean_a2[57..64];
		SELF.p_city_name      := clean_a2[90..114];
		SELF.st               := clean_a2[115..116];
		SELF.z5               := clean_a2[117..121];
		SELF.zip4             := clean_a2[122..125];
		SELF.lat              := clean_a2[146..155];
		SELF.long             := clean_a2[156..166];
		SELF.addr_type        := clean_a2[139];
		SELF.addr_status      := clean_a2[179..182];
		SELF.county           := clean_a2[143..145];
		SELF.geo_blk          := clean_a2[171..177];
		SELF.dl_number        := le.searchBy.DriverLicenseNumber;
		SELF.dl_state         := le.searchBy.DriverLicenseState;
		SELF.historydate			:= history_date;
		SELF.phone10					:= le.searchBy.HomePhone;
		SELF.wphone10					:= le.searchBy.WorkPhone;
		
		SELF := [];
	END;
	bsPrep := PROJECT(withSeq, into(LEFT));

  /* *******************************************
   *           Grab Requested Models           *
   ********************************************* */
	modelName := RECORD
		STRING16 model := '';
	END;
	modelName getModels(iesp.mvrinsurance.fcrainsurance.t_ModelRequest le) := TRANSFORM
		currentModelName := IF(StringLib.StringToUpperCase(le.modelname) NOT IN validModels, ERROR('Invalid model specified'), StringLib.StringToUpperCase(le.modelname));
		SELF.model := currentModelName;
	END;
	modelNames := PROJECT(inputRecord.Options.ModelRequests, getModels(LEFT));
	
	/* *******************************************
   *           Boca Shell Variables            *
   ********************************************* */
	BOOLEAN   isUtility            := FALSE;
	BOOLEAN   require2ele          := FALSE;
	UNSIGNED1 dppa                 := 0; // Not needed for FCRA
	UNSIGNED1 glba                 := 0; // Not needed for FCRA
	BOOLEAN   isLn                 := FALSE; // Not needed anymore
	BOOLEAN   doRelatives          := FALSE;
	BOOLEAN   doDL                 := FALSE;
	BOOLEAN   doVehicle            := FALSE;
	BOOLEAN   doDerogs             := TRUE;
	BOOLEAN   ofacOnly             := TRUE;
	BOOLEAN   suppressNearDups     := FALSE;
	BOOLEAN   fromBIID             := FALSE;
	BOOLEAN   excludeWatchlists    := TRUE; // Turned off the OFAC searching as I don't think it is needed
	BOOLEAN   fromIT1O             := FALSE;
	UNSIGNED1 ofacVersion          := 1;
	BOOLEAN   includeOfac          := FALSE;
	BOOLEAN   includeAddWatchlists := FALSE;
	REAL      watchlistThreshold   := 0.84;
	// BOOLEAN   doScore              := IF(StringLib.StringToUpperCase(inputRecord.Options.ModelRequests[1].modelname) = 'MPX1211.0.0',TRUE,FALSE);
	BOOLEAN   doScore              := IF(EXISTS(modelNames (model = 'MPX1211.0.0')),TRUE,FALSE); // just in case there are more than 1 models requested
	BOOLEAN   isPreScreen          := FALSE;
	// INTEGER1  bsVersion            := IF(StringLib.StringToUpperCase(inputRecord.Options.ModelRequests[1].modelname) = 'MPX1211.0.0',4,3);
	INTEGER1  bsVersion            := IF(EXISTS(modelNames (model = 'MPX1211.0.0')),4,3);  // just in case there are more than 1 models requested
  BOOLEAN   nugen                := TRUE;
	BOOLEAN   ADL_Based_Shell      := FALSE;
	unsigned8 BSOptions							:= Risk_Indicators.iid_constants.BSOptions.InsuranceFCRABankruptcyException;
																		

	clam := Risk_Indicators.Boca_Shell_Function_FCRA(
		bsprep, gateways, dppa, glba, isUtility, isLN,
		require2ele, doRelatives, doDL, doVehicle, doDerogs, ofacOnly,
		suppressNearDups, fromBIID, excludeWatchlists, fromIT1O,
		ofacVersion, includeOfac, includeAddWatchlists, watchlistThreshold,
		bsVersion, isPreScreen, doScore, nugen, ADL_Based_Shell, datarestriction:=datarestriction,
		datapermission:=datapermission,BSOptions:=BSOptions
	);
	
	emptyclam := group(project(bsPrep, transform(risk_indicators.Layout_Boca_Shell, 
														self.seq := left.seq, self := [])), seq);
	clamtemp := IF(TestDataEnabled, emptyclam, clam);
	
   	
  /* *******************************************
   * MVR Insurance Models - Grab Model Scores  *
   ********************************************* */
	layoutMVR := RECORD
		INTEGER seq;
		REAL4 score;
	END;
	workingLayout := RECORD
		layoutMVR;
		STRING model := '';
		DATASET(Risk_Indicators.Layout_Desc) ri;
	END;
	
	workingLayout getMVRModelScores(modelNames le) := TRANSFORM
		MVRModelResult := MAP(le.model = 'WOMV002.0.0'  => Models.WOMV002_0_0(UNGROUP(clam)),
													le.model = 'MV361006.0.0' => Models.MV361006_0_0(UNGROUP(clam)),
													le.model = 'MV361006.1.0' => Models.MV361006_1_0(UNGROUP(clam)),
													le.model = 'MX361006.0.0' => Models.MX361006_0_0(UNGROUP(clam)),
													le.model = 'MX361006.1.0' => Models.MX361006_1_0(UNGROUP(clam)),
													le.model = 'MNC21106.0.0' => Models.MNC21106_0_0(UNGROUP(clam)),
													le.model = 'MPX1211.0.0' => Models.MPX1211_0_0(UNGROUP(clam)),
																											 DATASET([], layoutMVR)
												);
		SELF.seq := MVRModelResult[1].seq;
		SELF.score := MVRModelResult[1].score;
		SELF.model := IF(EXISTS(MVRModelResult), le.model, '');
		
		SELF := [];
	END;
	
	mvrScores := PROJECT(modelNames, getMVRModelScores(LEFT)) (seq <> 0); // If the model ran, it should have a Seq of 1

  /* *******************************************
   *    RiskView Models - Grab Model Scores    *
   ********************************************* */
	 
	workingLayout getRVModelScores(modelNames le) := TRANSFORM
		RiskViewModelResult := MAP(le.model = 'RVR611.0.0'	=> UNGROUP(Models.RVR611_0_0(clam, FALSE)),
															 // le.model = 'RVR1003.0.0'	=> UNGROUP(Models.RVR1003_0_0(clam)),
																													 DATASET([], Models.Layout_ModelOut)
															);
		SELF.seq := RiskViewModelResult[1].seq;
		SELF.score := (REAL)RiskViewModelResult[1].score;
		SELF.model := IF(EXISTS(RiskViewModelResult), le.model, '');
		SELF.ri := RiskViewModelResult[1].ri;
		
		SELF := [];
	END;
	
	riskViewScores := PROJECT(modelNames, getRVModelScores(LEFT)) (seq <> 0); // If the model ran, it should have a Seq of 1

  /* *******************************************
   *         Combine MVR With RiskView         *
   ********************************************* */
	combinedRealtimeScores := mvrScores + riskViewScores;
	
	/* *******************************************
   *            Grab MVR TestSeeds             *
   ********************************************* */
	// Apparently MVR testseeds only allow model names of 10 bytes... So truncate all of the input models if need be.
	testSeedModelName := RECORD
		STRING10 model := '';
	END;
	testSeedModelNames := PROJECT(modelNames, TRANSFORM(testSeedModelName, SELF.model := (STRING10)LEFT.model;));
	MVRSeeds := Models.MVRInsurance_TestSeed_Function(ds_in, TestDataTableName, testSeedModelNames);
	
	workingLayout seedsToMVRWorkingLayout (MVRSeeds le) := TRANSFORM
		SELF.seq := 1;
		SELF.score := le.score;
		// Since MVR Test Seeds only have 10-byte Model Names, need to expand them back out to the full name
		SELF.model := MAP(le.model_name = 'WOMV002.0.' => 'WOMV002.0.0',
											le.model_name = 'MV361006.0' => 'MV361006.0.0',
											le.model_name = 'MV361006.1' => 'MV361006.1.0',
											le.model_name = 'MX361006.0' => 'MX361006.0.0',
											le.model_name = 'MX361006.1' => 'MX361006.1.0',
											le.model_name = 'MNC21106.0' => 'MNC21106.0.0',
											le.model_name = 'MPX1211.0.' => 'MPX1211.0.0',
																											''
											);
		SELF := [];
	END;
	MVRSeedsWorkingLayout := PROJECT(MVRSeeds, seedsToMVRWorkingLayout(LEFT)) (TRIM(model) <> '');
	
  /* *******************************************
   * Grab RiskView TestSeeds - Only 1 RV Model *
   ********************************************* */
	Risk_Indicators.Layout_Input intoRVInput(ds_in le) := TRANSFORM
		fullName := TRIM(le.searchBy.Name.Full);
		cleanName := Address.CleanPerson73(fullName);
		firstName := IF(le.searchBy.Name.first = '' AND fullName != '', TRIM((cleanName[6..25])), le.searchBy.Name.first);
		lastName := IF(le.searchBy.Name.last  = '' AND fullName != '', TRIM((cleanName[46..65])), le.searchBy.Name.last);
		SELF.seq := 1;
		SELF.fName := StringLib.StringToUpperCase(firstName);
		SELF.lName := StringLib.StringToUpperCase(lastName);
		SELF.ssn := le.searchBy.SSN;
		SELF.z5 := le.searchBy.Address.Zip5;
		SELF.zip4 := le.searchBy.Address.Zip4;
		SELF.phone10 := le.searchBy.HomePhone;
		
		SELF := [];
	END;
	rv_ds_in := PROJECT(ds_in, intoRVInput(LEFT));
	
	// This is just to appease the RV_TestSeed_Function which can only handle 1 model on input
	accountNumber := '1';
	serviceName := MAP(EXISTS(modelNames (model = 'RVR611.0.0')) => 'models.rvretail_service',
										// EXISTS(modelNames (model = 'RVR1003.0.0')) => 'models.rvretail_service',
																	'');
	riskViewModelName := MAP(EXISTS(modelNames (model = 'RVR611.0.0')) => '',						// Blank in the RV_TestSeed_Function means RVR611_0
													// EXISTS(modelNames (model = 'RVR1003.0.0')) => 'RVR1003_0',
																																			''); 
	RiskViewSeeds := Risk_Indicators.RV_TestSeed_Function(rv_ds_in, accountNumber, TestDataTableName, serviceName, riskViewModelName);
	
	workingLayout seedsToRVWorkingLayout (RiskViewSeeds le) := TRANSFORM
		SELF.seq := 1;
		SELF.score := (REAL)le.scores[1].i;
		SELF.model := IF(EXISTS(modelNames (model = 'RVR611.0.0')) AND le.scores[1].i <> '', 'RVR611.0.0', '');
		SELF.ri := PROJECT(le.scores[1].reason_codes, TRANSFORM(Risk_Indicators.Layout_Desc, SELF.hri := LEFT.reason_code; SELF.desc := LEFT.reason_description));
	END;
	RiskViewSeedsWorkingLayout := PROJECT(RiskViewSeeds, seedsToRVWorkingLayout(LEFT)) (TRIM(model) <> '');
	
	/* *******************************************
   *   Combine MVR Seeds With RiskView Seeds   *
   ********************************************* */
	combinedSeedsScores := MVRSeedsWorkingLayout + RiskViewSeedsWorkingLayout;
	
  /* *******************************************
   *        Convert Everything to ESDL         *
   ********************************************* */
	combinedScores := IF(TestDataEnabled, combinedSeedsScores, combinedRealtimeScores);
	 
	iesp.mvrinsurance.fcrainsurance.t_Model scoreIntoESDL(combinedScores le) := TRANSFORM
		// Build up Model Scores structure
		riskCodes := PROJECT(CHOOSEN(le.ri, 4), TRANSFORM(iesp.share.t_RiskIndicator, SELF.RiskCode := LEFT.hri; SELF.Description := LEFT.desc));
		score := PROJECT(le, TRANSFORM(iesp.mvrinsurance.fcrainsurance.t_Score, SELF._type := ''; SELF.Value := LEFT.score; SELF.RiskIndicators := riskCodes));
																																						
		SELF.Name := le.model;
		SELF.scores := score;
		
		SELF := [];
	END;
	scoreResult := PROJECT(combinedScores, scoreIntoESDL(LEFT));
	
	iesp.mvrinsurance.fcrainsurance.t_FcraInsuranceModelResponse inputIntoESDL(withSeq le, clam ri) := TRANSFORM
		name := PROJECT(le, TRANSFORM(iesp.share.t_Name, SELF := LEFT.SearchBy.Name));
		address := PROJECT(le, TRANSFORM(iesp.share.t_Address, SELF := LEFT.SearchBy.Address));
		dateOfBirth := PROJECT(le, TRANSFORM(iesp.share.t_Date, SELF := LEFT.SearchBy.DOB));
		search := PROJECT(le, TRANSFORM(iesp.mvrinsurance.fcrainsurance.t_FcraInsuranceModelSearchBy,  
																																											SELF.Name := name; 
																																											SELF.Address := address; 
																																											SELF.DOB := dateOfBirth; 
																																											SELF.SSN := LEFT.SearchBy.SSN;
																																											SELF.DriverLicenseNumber := LEFT.SearchBy.DriverLicenseNumber;
																																											SELF.DriverLicenseState := LEFT.SearchBy.DriverLicenseState;
																																											SELF.HomePhone := LEFT.SearchBy.HomePhone; 
																																											SELF.WorkPhone := LEFT.SearchBy.WorkPhone;
																																											SELF := []));
		res := PROJECT(le, TRANSFORM(iesp.mvrinsurance.fcrainsurance.t_FcraInsuranceModelResult,
																																											SELF.InputEcho := search;
																																											self.UniqueID := (string)ri.did;
																																											SELF.Models := scoreResult;
																																											SELF := []));
																																											
		SELF.Result := res;
		
		SELF := [];
	END;
	result := join(withSeq, clam, left.seq=right.seq, inputIntoESDL(LEFT, right));
	OUTPUT(result, NAMED('Results'));
ENDMACRO;
// Models.MVRInsurance_Service();