IMPORT risk_indicators, Risk_Reporting, address, ut, fcra_opt_out, gateway, RiskView, iesp, riskwisefcra, Inquiry_AccLogs, Business_Risk_BIP, STD;

VALIDATING := false;

	Risk_indicators.MAC_unparsedfullname(title_val,fname_val,mname_val,lname_val,suffix_val,'FirstName','MiddleName','LastName','NameSuffix');

	unsigned6 did_value := 0				: stored('DID');
	string30  account_value := '' 	: stored('AccountNumber');
	string120	fullname_value :=	''	: stored('UnParsedFullName');
	string120 addr_value := ''    	: stored('StreetAddress');
	string25  city_value := ''     	: stored('City');
	string2   state_value := ''     : stored('State');
	string5   zip_value := ''      	: stored('Zip');
	string25  country_value := '' 	: stored('Country');
	string9   ssn_value := ''      	: stored('ssn');
	string8   dob_value := ''      	: stored('DateOfBirth');
	unsigned1 age_value := 0      	: stored('Age');
	string20  drlc_value := ''    	: stored('DLNumber');
	string2   drlcstate_value := '' : stored('DLState');
	string100 email_value := ''  	  : stored('Email');
	string45  ip_value := ''      	: stored('IPAddress');
	string10  hphone_value := ''   	: stored('HomePhone');
	string10  wphone_value := ''  	: stored('WorkPhone');
	string100 cmpy_value := '' 		: stored('EmployerName');
	string30  formerlast_value := '': stored('FormerName');

	boolean	  doAttributes := false	: stored('Attributes');
	string40	purpose_value := ''	: stored('IntendedPurpose');

	boolean   Test_Data_Enabled := false   	: stored('TestDataEnabled');
	string20  Test_Data_Table_Name := ''   	: stored('TestDataTableName');

	string5   industry_class_val := '' 	    : stored('IndustryClass');
	unsigned3 history_date := 999999        : stored('HistoryDateYYYYMM');
	string50 DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
	string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
	boolean InPersonApplication := false : stored('InPersonApplication'); // this new variable is InPersonApplication -- not InPersonApplicant -- to make the ESP a bit cleaner

	boolean TestingService := false : STORED('TestingService');
	BOOLEAN DisableOutcomeTracking := FALSE : STORED('OutcomeTrackingOptOut');
	#stored('DisableBocaShellLogging', DisableOutcomeTracking);
	boolean FilterLiens := DataRestriction[risk_indicators.iid_constants.posLiensJudgRestriction]='1' ;
	
	// Allows for partial input address - when set to TRUE searches for a DID, if found then searches the Header for any partially matching addresses
	BOOLEAN AddressAppend := FALSE : STORED('AddressAppend');

	BOOLEAN returnBS := FALSE : STORED('ReturnBS');
	integer1 returnBSVersion := 1 : stored('ReturnBSVersion');
											 
	STRING  strFFDOptionsMask_in	 :=  '0' : STORED('FFDOptionsMask');
	boolean OutputConsumerStatements := strFFDOptionsMask_in[1] = '1';		
	

	Layout_Echo_In := RECORD
		string30 AccountNumber;
		string120 UnParsedFullName;
		string30 FirstName;
		string30 MiddleName;
		string30 LastName;
		string5 NameSuffix;
		string120 StreetAddress;
		string25  City;
		string2 State;
		string5 Zip;
		string25 Country;
		string9 SSN;
		string8 DateOfBirth;
		unsigned1 Age;
		string20 DLNumber;
		string2 DLState;
		string100 Email;
		string45 IPAddress;
		string10 HomePhone;
		string10 WorkPhone;
		string100 EmployerName;
		string30 FormerName;
		string5 IndustryClass;
		unsigned3 HistoryDateYYYYMM;
	END;

	echo_in := dataset([{account_value,fullname_value,fname_val,mname_val,lname_val,suffix_val,
											addr_value,city_value,state_value,zip_value,country_value,ssn_value,
											dob_value,age_value,drlc_value,drlcstate_value,email_value,ip_value,
											hphone_value,wphone_value,cmpy_value,formerlast_value,industry_class_val,
											history_date}], Layout_Echo_In);

	Layout_Attributes_In := RECORD
		string name;
	END;

	model_url1 := dataset([],Models.Layout_Score_Chooser) 		: stored('scores',few);
	attributesIn := dataset([],Layout_Attributes_In)			: stored('RequestedAttributeGroups',few);
	gateways_in := Gateway.Configuration.Get();
	model_url := if( exists(model_url1) or exists(attributesIn), model_url1, fail(Models.Layout_Score_Chooser, 'No scores or attributes requested'));
	
	layout_temp := record
		dataset(models.layout_parameters) params;
	end;
	
	//--------------------------------------------------------//
	// Custom Fields Section
	// model url is looking at the scores/name field,
	// could be models.riskview_service or Custom.
	// Ask the ESP developer if not sure.
	//--------------------------------------------------------//
	
	model_count := count(model_url);
	
	model_params := project(model_url(StringLib.StringToLowerCase(name)in 
	['models.riskview_service', 
	'models.rvauto_service', 
	'models.rvbankcard_service', 
	'models.rvretail_service', 
	'models.rvtelecom_service', 
	'models.rvmoney_service', 
	'models.rvprescreen_service']
	), transform(layout_temp, self.params := left.parameters(StringLib.StringToLowerCase(name)='custom')));
	custom_model_name := map(model_count > 1 and 'pva1602_0' in set(model_params.params, StringLib.StringToLowerCase(value)) => error('PVA1602_0 may only be requested alone'), 
													 model_count > 1 and 'fxd1607_0' in set(model_params.params, StringLib.StringToLowerCase(value)) => error('FXD1607_0 may only be requested alone'), 
													 model_params.params[1].value);

	income_params := project(model_url(StringLib.StringToLowerCase(name)='models.rvauto_service'), transform(layout_temp, self.params := left.parameters(StringLib.StringToLowerCase(name)='monthlyincome_value')));
	income_value := income_params.params[1].value;

	year_params := project(model_url(StringLib.StringToLowerCase(name)='models.rvauto_service'), transform(layout_temp, self.params := left.parameters(StringLib.StringToLowerCase(name)='numberofyearsemployed')));
	employment_years := year_params.params[1].value;

	month_params := project(model_url(StringLib.StringToLowerCase(name)='models.rvauto_service'), transform(layout_temp, self.params := left.parameters(StringLib.StringToLowerCase(name)='numberofmonthsemployed')));
	employment_months := month_params.params[1].value;
	 
	returncode_params := project(model_url(StringLib.StringToLowerCase(name)='custom'), transform(layout_temp, self.params := left.parameters(StringLib.StringToLowerCase(name)='returncode')));
	returncode := returncode_params.params[1].value;
	
	pay_frequency_params := project(model_url(StringLib.StringToLowerCase(name)='custom'), transform(layout_temp, self.params := left.parameters(StringLib.StringToLowerCase(name)='payfrequency')));
	pay_frequency := pay_frequency_params.params[1].value;
	
	//Input fields for powerview
	equifax_member_param := project(model_url(StringLib.StringToLowerCase(name)='models.riskview_service'), transform(layout_temp, self.params := left.parameters(StringLib.StringToLowerCase(name)='efxmembernumber')));
	equifax_membernumber := equifax_member_param.params[1].value;
	
	equifax_income_param := project(model_url(StringLib.StringToLowerCase(name)='models.riskview_service'), transform(layout_temp, self.params := left.parameters(StringLib.StringToLowerCase(name)='annualincome')));
	equifax_income := equifax_income_param.params[1].value;
	
	equifax_securitycode_param := project(model_url(StringLib.StringToLowerCase(name)='models.riskview_service'), transform(layout_temp, self.params := left.parameters(StringLib.StringToLowerCase(name)='securitycode')));
	equifax_securitycode := equifax_securitycode_param.params[1].value;
	//end powerview
	
	//--------------------------------------------------------//
	// End Custom Fields Section
	//--------------------------------------------------------//
	
	Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
		SELF.servicename := le.servicename;
		// Never allow Targus Gateway and only allow Equifax gateway if Powerview or FICO Score XD models are being requested.
		SELF.url := IF(StringLib.StringToLowerCase(le.servicename) IN ['targus'] or 
									(StringLib.StringToLowerCase(le.servicename) = 'equifaxsts' and StringLib.StringToLowerCase(custom_model_name) not in ['pva1602_0','fxd1607_0']),
									'', 	//if any of the conditions above are true, don't allow gateway
									le.url);
		self := le;
	END;
	emptyGateways := dataset([],Gateway.Layouts.Config); 
	gateways := PROJECT(gateways_in, gw_switch(LEFT));

	doLifestyle   := doAttributes and (EXISTS(attributesIn(stringlib.stringtolowercase(name)='lifestyle')) or attributesIn[1].name=''); 
	doDemographic := doAttributes and (EXISTS(attributesIn(stringlib.stringtolowercase(name)='demographic')) or attributesIn[1].name='');
	doFinancial   := doAttributes and (EXISTS(attributesIn(stringlib.stringtolowercase(name)='financial')) or attributesIn[1].name='');
	doProperty    := doAttributes and (EXISTS(attributesIn(stringlib.stringtolowercase(name)='property')) or attributesIn[1].name='');
	doDerog       := doAttributes and (EXISTS(attributesIn(stringlib.stringtolowercase(name)='derogatory')) or attributesIn[1].name='');
	doVersion2    := doAttributes and  EXISTS(attributesIn(stringlib.stringtolowercase(name)='version2'));	// output version2 if requested
	doVersion3    := doAttributes and  EXISTS(attributesIn(stringlib.stringtolowercase(name)='version3'));	// output version3 if requested
	doVersion4    := doAttributes and  EXISTS(attributesIn(stringlib.stringtolowercase(name)='version4'));	// output version4 if requested
	
	// Only allow Address Appending in Version 3 of the attributes
	DoAddressAppend := IF(doVersion3 = TRUE, AddressAppend, FALSE);

	/******************************************************************************/
	// Set attributes using <parameter> data from the Scores XML
	layout_settings := {integer1 bs_needed, boolean needs_vehicles, boolean require2, boolean isCalifornia };
	
	layout_settings get_settings( model_url le ) := TRANSFORM
		param := le.parameters(StringLib.StringToLowerCase(name)='custom');
		model_name := StringLib.StringToLowerCase(param[1].value);
		ca_params := le.parameters(StringLib.StringToLowerCase(name)='inpersonapplicant');
		ca_boolean := ca_params[1].value='1';
		svc_name := StringLib.StringToLowerCase(le.name); // the name of the service (eg, Models.RVAuto_Service)
	
		// Certain models require BS v2+, so check whether any of these are requested.If so, use BS2 (per bug 38294)
		self.bs_needed := map(
			   (svc_name='models.rvauto_service'      and model_name in ['rva1003_0','rva1007_1','rva1007_2'])
			or (svc_name='models.rvbankcard_service'  and model_name in ['rvb1003_0'])
			or (svc_name='models.rvretail_service'    and model_name in ['rvr1003_0', 'rvr1008_1'])
			or (svc_name='models.rvtelecom_service'   and model_name in ['rvt1003_0'])
			or (svc_name='models.rvmoney_service'     and model_name in ['rvg1003_0'])
			or (svc_name='models.rvprescreen_service' and model_name in ['rvp1003_0'])
			or (svc_name='models.rvretail_service'    and model_name in ['rvd1010_0','rvd1010_1','rvd1010_2']) => 3,

			   (svc_name='models.rvauto_service'     and model_name in ['rva711_0','rva707_0'])		
			or (svc_name='models.rvbankcard_service' and model_name='rvb711_0')		
			or (svc_name='models.rvretail_service'   and model_name in ['rvr711_0','rvr803_1'])		
			or (svc_name='models.rvtelecom_service'  and model_name='rvt711_0')
			or (svc_name='models.rvmoney_service'    and model_name in ['rvg812_0','rvg903_1','rvg904_1']) => 2,

			// going forward, service name is deprecated
			model_name in ['ie912_1', 'rva1008_1', 'rva1007_3'] => 3,

			// flagship v4
			model_name in ['rvg1103_0','rvr1103_0','rva1104_0','rvp1104_0','rvt1104_0','rvb1104_0'] => 4,
			
			// Payment Score - A Custom Flagship v4
			model_name IN ['rvc1112_0'] => 4,

			// custom v4
			model_name in ['rvg1106_1', 'rvt1104_1', 'rvd1110_1',
										 'ied1106_1', 'rvr1104_2', 'rvg1201_1', 
										 'rvr1104_3', 'rvt1204_1', 'rvt1210_1',
										 'rvr1303_1', 'rvb1104_1'] => 4,

			// Equifax Model
			model_name in ['pva1602_0'] => 4,
			model_name in ['fxd1607_0'] => 4, 
	
			// custom v41
			model_name IN ['rvc1210_1', 'rvt1212_1', 'rvg1302_1', 'rva1304_1', 'rva1304_2', 'rvg1304_1', 'rvg1304_2', 'rva1306_1', 'rva1305_1', 'rva1305_9',
										 'rva1309_1', 'rva1310_1', 'rva1310_2', 'rva1310_3', 'rvt1307_3', 'rva1311_1', 'rva1311_2', 'rva1311_3','rvg1401_1', 'rvg1401_2', 
										 'rvt1402_1', 'rvg1310_1', 'rvg1404_1', 'rvr1311_1','rvr1410_1','rvb1310_1', 'rvb1402_1', 'ied1002_0', 'rvt1605_1', 'rvt1605_2', 'rvt1705_1'] => 41,
			
			1
		);
		
		// aid605_1 uses vehicles
		self.needs_vehicles := (svc_name='models.rvauto_service'  and model_name='aid605_1' );
		
		// legacy models should require 2 elements
		self.require2 := (svc_name='models.rvauto_service'  and model_name in ['aid605_1','aid607_0'] );
		
		// CA In Person
		self.isCalifornia := ca_boolean;
	END;
	settings 			:= project( model_url, get_settings(left) );
	forceBS       := max(settings, bs_needed);
	forceVehicles := exists(settings(needs_vehicles));
	force2Ele     := exists(settings(require2));
	isCalifornia  := InPersonApplication or exists(settings(isCalifornia));
	/******************************************************************************/

	bsVersion := max( forceBS, Map(
		doVersion4 => 4,
		doVersion3 => 3,
		doVersion2 => 2,
		1), 
		returnBSVersion); // return bsversion defaults to 1 / but can be passed in.

	r := RECORD
		unsigned4 seq;
	END;
	d := dataset([{(integer)account_value}],r);

	Risk_Indicators.Layout_Input into(d l) := TRANSFORM
	
		clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, city_value, state_value, zip_value);

		self.DID := did_value; 	
		self.score := if(self.did<>0, 100, 0);
	
		self.seq :=  l.seq;    // (integer)account_value; // Used for Validation of models
		self.historydate := history_date;
		self.ssn := IF(ssn_value = '000000000', '', ssn_value);	// blank out social if it is all 0's
		self.dob := dob_value;
		
		// self is Layout_Input, which defines age as STRING3, so cast the appropriate values to that type.
		// make age archivable
		self.age := if (age_value = 0 and (integer)dob_value != 0, 
														(STRING3)ut.Age((unsigned)dob_value, (unsigned)risk_indicators.iid_constants.myGetDate(history_date)),
														(STRING3)age_value);
		
		self.phone10 := hphone_value;
		self.wphone10 := wphone_value;
		
		self.title := stringlib.stringtouppercase(title_val);
		self.fname := stringlib.stringtouppercase(fname_val);
		self.mname := stringlib.stringtouppercase(mname_val);
		self.lname := stringlib.stringtouppercase(lname_val);
		self.suffix := stringlib.stringtouppercase(suffix_val);
		
		self.in_streetAddress := addr_value;
		self.in_city := city_value;
		self.in_state := state_value;
		self.in_zipCode := zip_value;
		self.in_country := country_value;
		
		self.prim_range := clean_a2[1..10];
		self.predir := clean_a2[11..12];
		self.prim_name := clean_a2[13..40];
		self.addr_suffix := clean_a2[41..44];
		self.postdir := clean_a2[45..46];
		self.unit_desig := clean_a2[47..56];
		self.sec_range := clean_a2[57..64];
		self.p_city_name := clean_a2[90..114];
		self.st := clean_a2[115..116];
		self.z5 := MAP(TRIM(clean_a2[117..121]) <> '' => clean_a2[117..121], // If the cleaned zip is available, keep it
									 DoAddressAppend = TRUE => zip_value[1..5], // If we are running an Address Append and only ZIP is passed in it fails the address cleaner and has clean_a2 set to blank, set it to the input ZIP code. If Street Number + Zip are input it will clean the ZIP just fine.
									 '');
		self.zip4 := clean_a2[122..125];
		self.lat := clean_a2[146..155];
		self.long := clean_a2[156..166];
		self.addr_type := clean_a2[139];
		self.addr_status := clean_a2[179..182];
		self.county := clean_a2[143..145];
		self.geo_blk := clean_a2[171..177];
			
		self.country := country_value;
		
		dl_num := stringlib.stringFilterOut(drlc_value,'-');
		dl_num2 := stringlib.stringFilterOut(dl_num,' ');
		
		self.dl_number := stringlib.stringtouppercase(dl_num2);
		self.dl_state := stringlib.stringtouppercase(drlcstate_value);
		
		self.email_address := email_value;
		self.ip_address := ip_value;
		
		self.employer_name := stringlib.stringtouppercase(cmpy_value);
		self.lname_prev := stringlib.stringtouppercase(formerlast_value);

	END;
	bsprep := PROJECT(d, into(left));


	// specifically for test data enabled transactions
	Risk_Indicators.Layout_Input doTestInput(d l) := transform
		// only set the necessary fields to search test seed record, don't cass input addr
		self.seq := l.seq;
		self.ssn := ssn_value;
		self.phone10 := hphone_value;
		self.fname := stringlib.stringtouppercase(fname_val);
		self.lname := stringlib.stringtouppercase(lname_val);
		self.z5 := zip_value;
		self := [];
	END;
	testPrep := PROJECT(d, doTestInput(left));


	// set variables for passing to bocashell function fcra
	boolean   isUtility := StringLib.StringToUpperCase(industry_class_val) = 'UTILI';
	boolean   require2ele := force2Ele;
	unsigned1 dppa := 0; // not needed for FCRA
	unsigned1 glba := 0; // not needed for FCRA
	boolean   isLn := false; // not needed anymore
	boolean   doRelatives := false;
	boolean   doDL := false;
	boolean   doVehicle := forceVehicles;
	boolean   doDerogs := true;
	boolean   ofacOnly := true;
	boolean   suppressNearDups := false;
	boolean   fromBIID := false;
	boolean   excludeWatchlists := true; // turned off the ofac searching as I don't think it is needed
	boolean   fromIT1O := false;
	unsigned1 ofacVersion := 1;
	boolean   includeOfac := false;
	boolean   includeAddWatchlists := false;
	real      watchlistThreshold := 0.84;
	boolean   doScore := false;
	boolean   isPreScreen := StringLib.StringToUpperCase(purpose_value) = 'PRESCREENING';
	boolean 	isDirectToConsumerPurpose := StringLib.StringToUpperCase(purpose_value) = Riskview.Constants.directToConsumer;
	
	// TODO: remove RiskView's prescreen search. this is now available in the boca shell (85349)
	unsigned8 BSOptions := if( IsPreScreen, risk_indicators.iid_constants.BSOptions.IncludePreScreen, 0 ) + 
												 IF(DoAddressAppend, Risk_Indicators.iid_constants.BSOptions.IncludeAddressAppend, 0) +
												 if(FilterLiens, Risk_Indicators.iid_constants.BSOptions.FilterLiens, 0) ;

	clam := Risk_Indicators.Boca_Shell_Function_FCRA(
		bsprep, gateways, dppa, glba, isUtility, isLN,
		require2ele, doRelatives, doDL, doVehicle, doDerogs, ofacOnly,
		suppressNearDups, fromBIID, excludeWatchlists, fromIT1O,
		ofacVersion, includeOfac, includeAddWatchlists, watchlistThreshold,
			bsVersion, isPreScreen, doScore, ADL_Based_Shell:=false, datarestriction:=datarestriction, BSOptions:=BSOptions,
			datapermission:=datapermission,IN_isDirectToConsumer:=isDirectToConsumerPurpose	
	);
	adl_clam := Risk_Indicators.Boca_Shell_Function_FCRA(
		bsprep, gateways, dppa, glba, isUtility, isLN,
		require2ele, doRelatives, doDL, doVehicle, doDerogs, ofacOnly,
		suppressNearDups, fromBIID, excludeWatchlists, fromIT1O,
		ofacVersion, includeOfac, includeAddWatchlists, watchlistThreshold,
		bsVersion, isPreScreen, doScore, ADL_Based_Shell:=true, datarestriction:=datarestriction, BSOptions:=BSOptions,
		datapermission:=datapermission,IN_isDirectToConsumer:=isDirectToConsumerPurpose	
	);

	Models.Layout_Reason_Codes form_rc(Models.Layout_ModelOut le) := TRANSFORM
		self.reason_code := if(le.ri[1].hri <> '00', le.ri[1].hri, '36');  // 36 is the default reason code if no other codes are set
		self.reason_description := if(le.ri[1].hri <> '00',le.ri[1].desc, risk_indicators.getHRIDesc('36')) ;
	END;
	Models.Layout_Reason_Codes form_rc2(Models.Layout_ModelOut le) := TRANSFORM
		models36 := ['rvg1302_1', 'rva1304_1', 'rva1304_2', 'rvg1304_1', 'rvg1304_2', 'rva1306_1', 'rva1305_1', 'rva1305_9',
                 'rva1309_1', 'rva1310_1', 'rva1310_2', 'rva1310_3', 'rvt1307_3', 'rva1311_3', 'rvt1402_1', 'rvg1310_1',
								 'rvg1404_1', 'rvr1311_1', 'rvr1410_1', 'rvb1310_1', 'rvb1402_1', 'pva1602_0', 'fxd1607_0', 'rvt1605_1', 
                 'rvt1605_2','rvt1705_1'];  //for these newer models, logic is in the model itself for setting RC2 to 36 so don't overlay it here
		self.reason_code        := map(
			le.ri[2].hri <> '00' => le.ri[2].hri,
			custom_model_name not in models36 and le.ri[1].hri NOT IN ['00', '35', '36'] => '36',
			''
		);
		self.reason_description := map(
			le.ri[2].hri <> '00' => le.ri[2].desc,
			custom_model_name not in models36 and le.ri[1].hri NOT IN ['00', '35', '36'] => risk_indicators.getHRIDesc('36'),
			''
		);
	END;
	Models.Layout_Reason_Codes form_rc3(Models.Layout_ModelOut le) := TRANSFORM
		self.reason_code := if(le.ri[3].hri <> '00', le.ri[3].hri, '');
		self.reason_description := le.ri[3].desc;
	END;
	Models.Layout_Reason_Codes form_rc4(Models.Layout_ModelOut le) := TRANSFORM
		self.reason_code := if(le.ri[4].hri <> '00', le.ri[4].hri, '');
		self.reason_description := le.ri[4].desc;
	END;
	Models.Layout_Reason_Codes form_rc5(Models.Layout_ModelOut le) := TRANSFORM
		self.reason_code := if(le.ri[5].hri <> '00', le.ri[5].hri, '');
		self.reason_description := le.ri[5].desc;
	END;

	Models.Layout_Score form_cscore(Models.Layout_ModelOut le, string desc, string idx) := TRANSFORM
		self.i := le.score;
		self.description := desc;
		self.index := idx;
		reason_codes := PROJECT(le,form_rc(LEFT)) + PROJECT(le,form_rc2(LEFT)) + PROJECT(le,form_rc3(LEFT)) + PROJECT(le,form_rc4(LEFT)) + PROJECT(le,form_rc5(LEFT));
		risk_indicators.MAC_add_sequence(reason_codes(reason_code<>''), reason_codes_with_seq);
		self.reason_codes := reason_codes_with_seq;
	END;

	Models.Layout_Model form_model(Models.Layout_ModelOut le, string desc, string idx) := TRANSFORM
		self.accountnumber := account_value;
		self.description := 'RiskView';
		self.scores := PROJECT(le, form_cscore(LEFT, desc, idx));
	END;


	/**************************************************/
	/*This section for handling intermediate variables*/
	/**************************************************/
	Layout_ModelOut_ivars := record
		Models.Layout_ModelOut;
		dataset(Models.Layout_Score) ivars;
	END;
	Models.Layout_Model form_model_ivars(Layout_ModelOut_ivars le, string desc, string idx) := TRANSFORM
		self.accountnumber := account_value;
		self.description := 'RiskView';
		novars := project( le, transform( Models.Layout_Modelout, self := left, self := [] ) );
		self.scores := PROJECT(novars, form_cscore(LEFT, desc, idx)) + le.ivars;
	END;
	/**************************************************/

	outer_layout := RECORD
		STRING30 AccountNumber;
		DATASET(Models.Layout_Model) models;
	END;
	
	// the testseed layout	
	layout_rvSeq := RECORD
		unsigned4 seq;
		Models.Layout_Model;
	END;

	// PreScreenOptOut := isPreScreen and opt_outs[1].opt_out_hit;
	adl_clam_model := custom_model_name in ['rvp1003_0','rvp1104_0','rvc1112_0', 'rvc1210_1'];
	// If the model needs the ADL Append OR the special address append was requested - run the ADL_Clam, otherwise run the vanilla Clam
	clam_to_check := if(adl_clam_model OR DoAddressAppend, adl_clam[1], clam[1]);
	clam_to_run := if(adl_clam_model OR DoAddressAppend, adl_clam, clam);
	
	
	PreScreenOptOut := risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, clam_to_check.iid.iid_flags );

	#if(VALIDATING)
			// final := ungroup(Models.RVG1404_1_0(clam, isCalifornia));
			 final := ungroup(Models.RVT1705_1_0(clam, isCalifornia));
			// final := ungroup(Models.RVB1310_1_0(clam, false, true));
	    // final := ungroup(Models.RVB1104_1_0(clam, false));
	#else
	
 /* *************************************
  *   Boca Shell Logging Functionality  *
  ***************************************/
	productID := IF(TestingService, Risk_Reporting.ProductID.Models__RiskView_Testing_Service, Risk_Reporting.ProductID.Models__RiskView_Service);
	
	disable_logging := IF(TestingService or custom_model_name in ['pva1602_0','fxd1607_0'], true, false);
	
	intermediate_Log := IF(disable_logging, DATASET([], Risk_Reporting.Layouts.LOG_Boca_Shell), Risk_Reporting.To_LOG_Boca_Shell(IF(adl_clam_model OR DoAddressAppend, adl_clam, clam), productID, bsVersion));
	#stored('Intermediate_Log', intermediate_log);
 /* ************ End Logging ************/

 /* *************************************
  *   Boca Shell return Functionality  *
  *   allow caller to get bs result    *
  ***************************************/
	#stored('ReturnedBS', if(returnBS, UNGROUP(clam_to_run), DATASET([], Risk_Indicators.Layout_Boca_Shell)) );
	#stored('ReturnedBSVersion', bsVersion);
 /* ********* End Shell Return **********/

	outer_layout get_scores(model_url le) := TRANSFORM
		param := le.parameters(StringLib.StringToLowerCase(name)='custom');
		model_name := StringLib.StringToLowerCase(param[1].value);
		
		svc_name := StringLib.StringToLowerCase(le.name); // the name of the service (eg, Models.RVAuto_Service)
	
		ret_ModelOut := map(
			/* Flagship v1 */
			svc_name='models.rvbankcard_service' and model_name=''         => ungroup(Models.RVB609_0_0(clam_to_run, isCalifornia)),
			svc_name='models.rvauto_service'     and model_name=''         => ungroup(Models.RVA611_0_0(clam_to_run, isCalifornia)), // generic
			svc_name='models.rvtelecom_service'  and model_name=''         => ungroup(Models.RVT612_0(clam_to_run, isCalifornia)),
			svc_name='models.rvretail_service'   and model_name=''         => ungroup(Models.RVR611_0_0(clam_to_run, isCalifornia)),

			/* Flagship v2 */
			svc_name='models.rvbankcard_service' and model_name='rvb711_0' => ungroup(Models.RVB711_0_0(ungroup(clam_to_run),  false, isCalifornia)), // this OFAC argument is arbitrarily chosen since FCRA doesn't use RC32
			svc_name='models.rvauto_service'     and model_name='rva711_0' => ungroup(Models.RVA711_0_0(clam_to_run,  isCalifornia)),
			svc_name='models.rvtelecom_service'  and model_name='rvt711_0' => ungroup(Models.RVT711_0_0(clam_to_run,  isCalifornia)),
			svc_name='models.rvretail_service'   and model_name='rvr711_0' => ungroup(Models.RVR711_0_0(clam_to_run,  isCalifornia)),
			svc_name='models.rvmoney_service'    and model_name='rvg812_0' => ungroup(Models.RVG812_0_0(ungroup(clam_to_run),  isCalifornia)),			
			
			/* Custom retail models */
			svc_name='models.rvretail_service'   and model_name='rvr803_1' => ungroup(Models.RVR803_1_0(clam_to_run,  isCalifornia)),
			svc_name='models.rvretail_service'   and model_name='rvr1008_1' => ungroup(Models.RVR1008_1_0(clam_to_run, isCalifornia, PreScreenOptOut)),

			/* Custom auto models */
			svc_name='models.rvauto_service' and model_name='aid605_1' => ungroup(Models.AID605_1_0(clam_to_run,  false, isCalifornia, (real)employment_years, (real)employment_months, (real)income_value)),
			svc_name='models.rvauto_service' and model_name='aid607_0' => ungroup(Models.AID607_0_0(clam_to_run,  false, isCalifornia)),
			svc_name='models.rvauto_service' and model_name='rva707_0' => ungroup(Models.RVA707_0_0(clam_to_run,  isCalifornia)),
			
			/* Custom Money models */
			svc_name='models.rvmoney_service'    and model_name='rvg903_1' => ungroup(Models.RVG903_1_0(ungroup(clam_to_run),  isCalifornia)),
			svc_name='models.rvmoney_service'    and model_name='rvg904_1' => ungroup(Models.RVG904_1_0(ungroup(clam_to_run),  isCalifornia)),

			/* Flagship v3 */
			svc_name='models.rvauto_service'      and model_name='rva1003_0' => ungroup(Models.RVA1003_0_0(clam_to_run, isCalifornia, PreScreenOptOut)),
			svc_name='models.rvbankcard_service'  and model_name='rvb1003_0' => ungroup(Models.RVB1003_0_0(clam_to_run, isCalifornia, PreScreenOptOut)),
			svc_name='models.rvretail_service'    and model_name='rvr1003_0' => ungroup(Models.RVR1003_0_0(clam_to_run, isCalifornia, PreScreenOptOut)),
			svc_name='models.rvtelecom_service'   and model_name='rvt1003_0' => ungroup(Models.RVT1003_0_0(clam_to_run, isCalifornia, PreScreenOptOut)),
			svc_name='models.rvmoney_service'     and model_name='rvg1003_0' => ungroup(Models.RVG1003_0_0(clam_to_run, isCalifornia, PreScreenOptOut)),
			svc_name='models.rvprescreen_service' and model_name='rvp1003_0' => ungroup(Models.RVP1003_0_0(clam_to_run, isCalifornia, PreScreenOptOut)), // adl shell for prescreen
			
			
			svc_name='models.rvretail_service' and model_name='rvd1010_0' => Models.RVD1010_0_0(ungroup(clam_to_run), isCalifornia),
			svc_name='models.rvretail_service' and model_name='rvd1010_1' => Models.RVD1010_1_0(ungroup(clam_to_run), isCalifornia),
			svc_name='models.rvretail_service' and model_name='rvd1010_2' => Models.RVD1010_2_0(ungroup(clam_to_run), isCalifornia),
			
			
			model_name='ie912_1' => ungroup(Models.IE912_1_0(clam_to_run, isCalifornia)),
			model_name = 'rva1007_3' => UNGROUP(Models.RVA1007_3_0(clam_to_run, isCalifornia)),
		

			/* Flagship v4 */
			model_name = 'rvr1103_0' => ungroup(Models.RVR1103_0_0(clam_to_run, isCalifornia, PreScreenOptOut)),
			model_name = 'rvg1103_0' => ungroup(Models.RVG1103_0_0(clam_to_run, isCalifornia, PreScreenOptOut)),
			model_name = 'rva1104_0' => ungroup(Models.RVA1104_0_0(clam_to_run, isCalifornia, PreScreenOptOut)),
			model_name = 'rvp1104_0' => ungroup(Models.RVP1104_0_0(clam_to_run, isCalifornia, PreScreenOptOut)),
			model_name = 'rvt1104_0' => ungroup(Models.RVT1104_0_0(clam_to_run, isCalifornia, PreScreenOptOut)),
			model_name = 'rvb1104_0' => ungroup(Models.RVB1104_0_0(clam_to_run, isCalifornia, PreScreenOptOut)),
			
			
				/*Custom V3 */
			model_name = 'rva1008_1' => ungroup(Models.RVA1008_1_0(clam_to_run, isCalifornia, (real)employment_years, (real)employment_months, (real)income_value)),
			
			
			/* Custom v4 */
      model_name = 'rvc1112_0' => ungroup(Models.RVC1112_0_0(clam_to_run, isCalifornia, PreScreenOptOut)),
			// this model can be sunset for GE per mike woodberry 3/17/2014
			model_name = 'rvr1104_3' => UNGROUP(Models.RVR1104_3_0(clam_to_run, isCalifornia, PreScreenOptOut)),
			model_name = 'rvt1104_1' => ungroup(Models.RVT1104_1_0(clam_to_run, isCalifornia, PreScreenOptOut)),
			model_name = 'rvg1106_1' => ungroup(Models.RVG1106_1_0(clam_to_run, isCalifornia, PreScreenOptOut)),
			model_name = 'rvd1110_1' => ungroup(Models.RVD1110_1_0(clam_to_run, isCalifornia, PreScreenOptOut)),
			model_name = 'ied1106_1' => ungroup(Models.IED1106_1_0(ungroup(clam_to_run), isCalifornia)),
			model_name = 'rvr1104_2' => ungroup(Models.RVR1104_2_0(clam_to_run, isCalifornia, PreScreenOptOut)),
			model_name = 'rvg1201_1' => ungroup(Models.RVG1201_1_0(clam_to_run, isCalifornia, PreScreenOptOut)),
			model_name = 'rvt1204_1' => ungroup(Models.RVT1204_1(clam_to_run, isCalifornia)),
			model_name = 'rvt1210_1' => ungroup(Models.RVT1210_1_0(clam_to_run, isCalifornia, PreScreenOptOut)),
			model_name = 'rvr1303_1' => ungroup(Models.RVR1303_1_0(clam_to_run, isCalifornia)),
      model_name = 'rvb1104_1' => ungroup(Models.RVB1104_1_0(clam_to_run, isCalifornia, true)),
			// Call Equifax gateway but hard code to blank in the calls below when the model requested is not the model being called.
			// This is because the ECL map statement will execute both, which we do not want.
			model_name = 'pva1602_0' => Risk_Indicators.getPowerView(bsprep, if(model_name = 'pva1602_0',gateways, emptyGateways), equifax_membernumber, equifax_securitycode, equifax_income),
			model_name = 'fxd1607_0' => Risk_Indicators.getFICOScoreXD(bsprep, if(model_name = 'fxd1607_0',gateways, emptyGateways), equifax_membernumber, equifax_securitycode),

			
			/* custom V41 */
			model_name = 'rvc1210_1' => ungroup(Models.RVC1210_1_0(clam_to_run, isCalifornia, PreScreenOptOut, returncode, pay_frequency)),
			model_name = 'rvt1212_1' => ungroup(Models.RVT1212_1_0(clam_to_run, isCalifornia)),
			model_name = 'rvg1302_1' => ungroup(Models.RVG1302_1_0(clam_to_run, isCalifornia)),
			model_name = 'rva1304_1' => ungroup(Models.RVA1304_1_0(clam_to_run, isCalifornia)),
			model_name = 'rva1304_2' => ungroup(Models.RVA1304_2_0(clam_to_run, isCalifornia)),
			model_name = 'rvg1304_1' => ungroup(Models.RVG1304_1_0(clam_to_run, isCalifornia)),
			model_name = 'rvg1304_2' => ungroup(Models.RVG1304_2_0(clam_to_run, isCalifornia)),
			model_name = 'rva1306_1' => ungroup(Models.RVA1306_1_0(clam_to_run, isCalifornia)),
			model_name = 'rva1305_1' => ungroup(Models.RVA1305_1_0(clam_to_run, isCalifornia, False)),
			// RAV1305_9 is for internal use only.  This will be run by Nick M when a customer score of
			model_name = 'rva1305_9' => ungroup(Models.RVA1305_1_0(clam_to_run, isCalifornia, True)),
			model_name = 'rva1309_1' => ungroup(Models.RVA1309_1_0(clam_to_run, isCalifornia)),
			model_name = 'rva1310_1' => ungroup(Models.RVA1310_1_0(clam_to_run, isCalifornia)),
			model_name = 'rva1310_2' => ungroup(Models.RVA1310_2_0(clam_to_run, isCalifornia)),
			model_name = 'rva1310_3' => ungroup(Models.RVA1310_3_0(clam_to_run, isCalifornia)),
			model_name = 'rvt1307_3' => ungroup(Models.RVT1307_3_0(clam_to_run, isCalifornia, true)),
			model_name = 'rva1311_1' => ungroup(Models.RVA1311_1_0(clam_to_run, isCalifornia)),
			model_name = 'rva1311_2' => ungroup(Models.RVA1311_2_0(clam_to_run, isCalifornia)),
			model_name = 'rva1311_3' => ungroup(Models.RVA1311_3_0(clam_to_run, isCalifornia)),
			model_name = 'rvg1401_1' => ungroup(Models.RVG1401_1_0(clam_to_run, isCalifornia)),
			model_name = 'rvg1401_2' => ungroup(Models.RVG1401_2_0(clam_to_run, isCalifornia)),
			model_name = 'rvt1402_1' => ungroup(Models.RVT1402_1_0(clam_to_run, isCalifornia)),
			model_name = 'rvg1310_1' => ungroup(Models.RVG1310_1_0(clam_to_run, isCalifornia)),
			model_name = 'rvg1404_1' => ungroup(Models.RVG1404_1_0(clam_to_run, isCalifornia)),
			model_name = 'rvr1311_1' => ungroup(Models.RVR1311_1_0(clam_to_run, isCalifornia)),
			model_name = 'rvr1410_1' => ungroup(Models.RVR1410_1_0(clam_to_run, isCalifornia, true)),
			model_name = 'rvb1310_1' => ungroup(Models.RVB1310_1_0(clam_to_run, isCalifornia, true)),
			model_name = 'rvb1402_1' => ungroup(Models.RVB1402_1_0(clam_to_run, isCalifornia)),
			model_name = 'ied1002_0' => ungroup(Models.IED1002_0_9(clam_to_run, isCalifornia)),
			model_name = 'rvt1605_1' => ungroup(Models.RVT1605_1_0(clam_to_run, isCalifornia)),
			model_name = 'rvt1605_2' => ungroup(Models.RVT1605_2_0(clam_to_run, isCalifornia)),
			model_name = 'rvt1705_1' => ungroup(Models.RVT1705_1_0(clam_to_run, isCalifornia)),
			dataset([], Models.Layout_ModelOut)
			);
		
		
		ret_ivars := map(
			svc_name='models.rvauto_service' and model_name='rva707_1' =>	ungroup(Models.RVA707_1_0(clam_to_run,  isCalifornia)),
			svc_name='models.rvauto_service' and model_name='rva1007_1' =>	ungroup(Models.RVA1007_1_0(clam_to_run,  isCalifornia)),
			svc_name='models.rvauto_service' and model_name='rva1007_2' =>	ungroup(Models.RVA1007_2_0(clam_to_run,  isCalifornia)),
			dataset( [], Layout_ModelOut_ivars )
		);
		
		
		desc := map(
			/* Flagship v1 */
			svc_name='models.rvbankcard_service' and model_name = ''         => 'BankCard',
			svc_name='models.rvauto_service'     and model_name = ''         => 'Auto',
			svc_name='models.rvtelecom_service'  and model_name = ''         => 'Telecom',
			svc_name='models.rvretail_service'   and model_name = ''         => 'Retail',

			/* Flagship v2 */
			svc_name='models.rvbankcard_service' and model_name = 'rvb711_0' => 'BankCard',
			svc_name='models.rvauto_service'     and model_name = 'rva711_0' => 'Auto',
			svc_name='models.rvtelecom_service'  and model_name = 'rvt711_0' => 'Telecom',
			svc_name='models.rvretail_service'   and model_name = 'rvr711_0' => 'Retail',
			svc_name='models.rvmoney_service'    and model_name = 'rvg812_0' => 'Money',
			
			/* Custom retail models */
			svc_name='models.rvretail_service'   and model_name = 'rvr803_1' => 'RetailRVR8031',
			svc_name='models.rvretail_service'   and model_name = 'rvr1008_1' => 'RetailRVR10081',

			/* Custom auto models */
			svc_name='models.rvauto_service'     and model_name = 'aid605_1' => 'AutoAID6051',
			svc_name='models.rvauto_service'     and model_name = 'aid607_0' => 'AutoAID6070',
			svc_name='models.rvauto_service'     and model_name = 'rva707_1' => 'AutoRVA7071',
			svc_name='models.rvauto_service'     and model_name = 'rva1007_1' => 'AutoRVA10071',
			svc_name='models.rvauto_service'     and model_name = 'rva1007_2' => 'AutoRVA10072',
			svc_name='models.rvauto_service'     and model_name = 'rva707_0' => 'AutoRVA7070',
			
			/* Custom Money models */
			svc_name='models.rvmoney_service'    and model_name = 'rvg903_1' => 'MoneyRVG9031',
			svc_name='models.rvmoney_service'    and model_name = 'rvg904_1' => 'MoneyRVG9041',
			
			/* Flagship v3 */
			svc_name='models.rvauto_service'      and model_name='rva1003_0' => 'Auto',
			svc_name='models.rvbankcard_service'  and model_name='rvb1003_0' => 'BankCard',
			svc_name='models.rvretail_service'    and model_name='rvr1003_0' => 'Retail',
			svc_name='models.rvtelecom_service'   and model_name='rvt1003_0' => 'Telecom',
			svc_name='models.rvmoney_service'     and model_name='rvg1003_0' => 'Money',
			svc_name='models.rvprescreen_service' and model_name='rvp1003_0' => 'PreScreen',


			svc_name='models.rvretail_service' and model_name='rvd1010_0' => 'RetailRVD10100',
			svc_name='models.rvretail_service' and model_name='rvd1010_1' => 'RetailRVD10101',
			svc_name='models.rvretail_service' and model_name='rvd1010_2' => 'RetailRVD10102',
			
			/* Custom v3 */
			model_name = 'rva1007_3' => 'AutoRVA10073', // Harley (95452)
			model_name = 'rvr1104_3' => 'RetailRVR11043', //
			model_name = 'rva1008_1' => 'AutoRVA10081', // regional acceptance (86432)
			
			/* Flagship v4 */
			model_name='rva1104_0' => 'Auto',
			model_name='rvb1104_0' => 'BankCard',
			model_name='rvr1103_0' => 'Retail',
			model_name='rvt1104_0' => 'Telecom',
			model_name='rvg1103_0' => 'Money',
			model_name='rvp1104_0' => 'PreScreen',
			
			model_name='rvc1112_0' => 'Payment', // Payment Score model - a Custom Flagship
			
			/*Custom V4 */
			model_name='ie912_1' => 'IncomeIE91210', // because this is actually a spin of ie912_0_0, I'm using a description of 91210 instead of 91200
			model_name='rvg1106_1' => 'MoneyRVG11061', // CompuCredit custom model
			model_name = 'rvt1104_1' => 'TelecomRVT11041', // sprint (86464)
			model_name = 'rvd1110_1' => 'RetailRVD11101', // Republic Bank (90342)
			model_name = 'ied1106_1' => 'IncomeIED11061', // tracfone income estimator
			model_name = 'rvr1104_2' => 'RetailRVR11042', // bluestem
			model_name = 'rvg1201_1' => 'MoneyRVG12011', // compucredit
			model_name = 'rvt1204_1' => 'TelecomRVT12041', // Verizon
  		model_name = 'rvt1210_1' => 'TelecomRVT12101', // T-Mobile
			model_name = 'rvr1303_1' => 'RetailRVR13031', // bluestem
			model_name = 'rvb1104_1' => 'BankCardRVB11041', // One Technologies
			
			// Pass through to Equifax
			model_name = 'pva1602_0' => 'PowerViewPVA16020', // Equifax (PowerView)
			model_name = 'fxd1607_0' => 'FICOScoreXDFXD16070', // Equifax (FICO Score XD) 
			
      /* Custom V41 */			
			model_name = 'rvc1210_1' => 'PaymentRVC12101', // Epic Loans
			model_name = 'rvt1212_1' => 'TelecomRVT12121', // T-Mobile
			model_name = 'rvg1302_1' => 'MoneyRVG13021',   // Progressive
			model_name = 'rva1304_1' => 'AutoRVA13041',   // Santander
			model_name = 'rva1304_2' => 'AutoRVA13042',   // Santander
			model_name = 'rvg1304_1' => 'MoneyRVG13041',   // Strategic Link Consulting - VIP
			model_name = 'rvg1304_2' => 'MoneyRVG13042',   // Strategic Link Consulting - New
			model_name = 'rva1306_1' => 'AutoRVA13061',   // CIG Financial 135524
			model_name = 'rva1305_1' => 'AutoRVA13051',   // Carmax Auto
			model_name = 'rva1305_9' => 'AutoRVA13051',   // Carmax Auto
			model_name = 'rva1309_1' => 'AutoRVA13091',   // SFG Financial 
			model_name = 'rva1310_1' => 'AutoRVA13101',   // Auto Accept - Direct Loan 
			model_name = 'rva1310_2' => 'AutoRVA13102',   // Auto Accept - Indirect Loan 
			model_name = 'rva1310_3' => 'AutoRVA13103',   // Auto Accept - Consumer Loan 
			model_name = 'rvt1307_3' => 'TelecomRVT13073', // At&t
			model_name = 'rva1311_1' => 'AutoRVA13111',   // Coastal Credit Auto		
			model_name = 'rva1311_2' => 'AutoRVA13112',   // Coastal Credit Auto
			model_name = 'rva1311_3' => 'AutoRVA13113',   // Southern Auto Finance Company
			model_name = 'rvg1401_1' => 'MoneyRVG14011',   // Strategic Link Consulting
			model_name = 'rvg1401_2' => 'MoneyRVG14012',   // Strategic Link Consulting
			model_name = 'rvt1402_1' => 'TelecomRVT14021',   // Fortiva Financial
			model_name = 'rvg1310_1' => 'MoneyRVG13101',   // General Financial
			model_name = 'rvg1404_1' => 'MoneyRVG14041',   // Advance America Title Loan
			model_name = 'rvr1311_1' => 'RetailRVR13111', // bluestem
			model_name = 'rvr1410_1' => 'RetailRVR14101', // bluestem
			model_name = 'rvb1310_1' => 'BankCardRVB13101', // Bank of America
			model_name = 'rvb1402_1' => 'BankCardRVB14021', // RBS Citizens
			model_name = 'ied1002_0' => 'IncomeIED10020', // Estimated Income
			model_name = 'rvt1605_1' => 'TelecomRVT16051', // Equifax/Verizon
			model_name = 'rvt1605_2' => 'TelecomRVT16052', // Equifax/Verizon
			model_name = 'rvt1705_1' => 'TelecomRVT17051', // Huntington
			

			/***************/      
			''			
		);
		
		idx := map(
			/* Flagship v1 */
			svc_name='models.rvbankcard_service' and model_name = ''         => Risk_Indicators.BillingIndex.RVBankcard_v1,
			svc_name='models.rvauto_service'     and model_name = ''         => Risk_Indicators.BillingIndex.RVAuto_v1,
			svc_name='models.rvtelecom_service'  and model_name = ''         => Risk_Indicators.BillingIndex.RVTelecom_v1,
			svc_name='models.rvretail_service'   and model_name = ''         => Risk_Indicators.BillingIndex.RVRetail_v1,

			/* Flagship v2 */
			svc_name='models.rvauto_service'     and model_name = 'rva711_0' => Risk_Indicators.BillingIndex.RVAuto_v2,
			svc_name='models.rvbankcard_service' and model_name = 'rvb711_0' => Risk_Indicators.BillingIndex.RVBankcard_v2,
			svc_name='models.rvtelecom_service'  and model_name = 'rvt711_0' => Risk_Indicators.BillingIndex.RVTelecom_v2,
			svc_name='models.rvretail_service'   and model_name = 'rvr711_0' => Risk_Indicators.BillingIndex.RVRetail_v2,
			svc_name='models.rvmoney_service'    and model_name = 'rvg812_0' => Risk_Indicators.BillingIndex.RVMoney_v2,
			                                                                  
			/* Custom retail models */
			svc_name='models.rvretail_service'   and model_name = 'rvr803_1' => Risk_Indicators.BillingIndex.RVR_rvr803_1,
			svc_name='models.rvretail_service'   and model_name = 'rvr1008_1' => Risk_Indicators.BillingIndex.RVR1008_1,
														  
			/* Custom auto models */
			svc_name='models.rvauto_service'     and model_name = 'aid605_1' => Risk_Indicators.BillingIndex.RVA_aid605_1,
			svc_name='models.rvauto_service'     and model_name = 'aid607_0' => Risk_Indicators.BillingIndex.RVA_aid607_0,
			svc_name='models.rvauto_service'     and model_name = 'rva707_1' => Risk_Indicators.BillingIndex.RVA_rva707_1,
			svc_name='models.rvauto_service'     and model_name = 'rva1007_1' => Risk_Indicators.BillingIndex.RVA_rva1007_1,
			svc_name='models.rvauto_service'     and model_name = 'rva1007_2' => Risk_Indicators.BillingIndex.RVA_rva1007_2,
			svc_name='models.rvauto_service'     and model_name = 'rva707_0' => Risk_Indicators.BillingIndex.RVA_rva707_0, // sub-prime auto
			
			/* Custom Money models */
			svc_name='models.rvmoney_service'    and model_name = 'rvg903_1' => Risk_Indicators.BillingIndex.RVG_rvg903_1,
			svc_name='models.rvmoney_service'    and model_name = 'rvg904_1' => Risk_Indicators.BillingIndex.RVG_rvg904_1,
			
			/* Flagship v3 */
			svc_name='models.rvauto_service'      and model_name='rva1003_0' => Risk_Indicators.BillingIndex.RVAuto_v3,
			svc_name='models.rvbankcard_service'  and model_name='rvb1003_0' => Risk_Indicators.BillingIndex.RVBankcard_v3,
			svc_name='models.rvretail_service'    and model_name='rvr1003_0' => Risk_Indicators.BillingIndex.RVTelecom_v3,
			svc_name='models.rvtelecom_service'   and model_name='rvt1003_0' => Risk_Indicators.BillingIndex.RVRetail_v3,
			svc_name='models.rvmoney_service'     and model_name='rvg1003_0' => Risk_Indicators.BillingIndex.RVMoney_v3,
			svc_name='models.rvprescreen_service' and model_name='rvp1003_0' => Risk_Indicators.BillingIndex.RVPreScreen_v3,


			svc_name='models.rvretail_service' and model_name='rvd1010_0' => Risk_Indicators.BillingIndex.RVD_rvd1010_0,
			svc_name='models.rvretail_service' and model_name='rvd1010_1' => Risk_Indicators.BillingIndex.RVD_rvd1010_1,
			svc_name='models.rvretail_service' and model_name='rvd1010_2' => Risk_Indicators.BillingIndex.RVD_rvd1010_2,
			
			
			model_name='ie912_1'   => Risk_Indicators.BillingIndex.RV_Custom_IE9121,
			
      /* Custom V4 */			
			model_name='rvg1106_1' => Risk_Indicators.BillingIndex.RVG1106_1,
			model_name='rva1008_1' => Risk_Indicators.BillingIndex.RVA1008_1,
			model_name='rvt1104_1' => Risk_Indicators.BillingIndex.RVT1104_1,
			model_name='rvd1110_1' => Risk_Indicators.BillingIndex.RVD1110_1,
			model_name='ied1106_1' => Risk_Indicators.BillingIndex.IED1106_1,
			model_name='rva1007_3' => Risk_Indicators.BillingIndex.RVA1007_3,
			model_name='rvr1104_2' => Risk_Indicators.BillingIndex.RVR1104_2,
			model_name='rvr1104_3' => Risk_Indicators.BillingIndex.RVR1104_3,
			model_name='rvc1112_0' => Risk_Indicators.BillingIndex.RVC1112_0,
			
			model_name='pva1602_0' => Risk_Indicators.BillingIndex.PVA1602_0,
			model_name='fxd1607_0' => Risk_Indicators.BillingIndex.FXD1607_0,
			
			/* Flagship v4 */
			model_name='rva1104_0' => Risk_Indicators.BillingIndex.RVAuto_v4,
			model_name='rvb1104_0' => Risk_Indicators.BillingIndex.RVBankcard_v4,
			model_name='rvr1103_0' => Risk_Indicators.BillingIndex.RVRetail_v4,
			model_name='rvt1104_0' => Risk_Indicators.BillingIndex.RVTelecom_v4,
			model_name='rvg1103_0' => Risk_Indicators.BillingIndex.RVMoney_v4,
			model_name='rvp1104_0' => Risk_Indicators.BillingIndex.RVPreScreen_v4,
			model_name='rvr1303_1' => Risk_Indicators.BillingIndex.RVR1303_1,
			model_name='rvg1201_1' => Risk_Indicators.BillingIndex.RVG1201_1,
			model_name='rvb1104_1' => Risk_Indicators.BillingIndex.RVB1104_1,
			
			/* Custom V41 */
			model_name='rvt1204_1' => Risk_Indicators.BillingIndex.RVT1204_1,
			model_name='rvt1210_1' => Risk_Indicators.BillingIndex.RVT1210_1,
			
			model_name='rvc1210_1' => Risk_Indicators.BillingIndex.RVC1210_1,
			model_name='rvt1212_1' => Risk_Indicators.BillingIndex.RVT1212_1,	
			model_name='rvg1302_1' => Risk_Indicators.BillingIndex.RVG1302_1,	
			model_name='rva1304_1' => Risk_Indicators.BillingIndex.RVA1304_1,	
			model_name='rva1304_2' => Risk_Indicators.BillingIndex.RVA1304_2,
			model_name='rvg1304_1' => Risk_Indicators.BillingIndex.RVG1304_1,	
			model_name='rvg1304_2' => Risk_Indicators.BillingIndex.RVG1304_2,	
			model_name='rva1306_1' => Risk_Indicators.BillingIndex.RVA1306_1,	
			model_name='rva1305_1' => Risk_Indicators.BillingIndex.RVA1305_1,	
			model_name='rva1309_1' => Risk_Indicators.BillingIndex.RVA1309_1,	
			model_name='rva1310_1' => Risk_Indicators.BillingIndex.RVA1310_1,	
			model_name='rva1310_2' => Risk_Indicators.BillingIndex.RVA1310_2,	
			model_name='rva1310_3' => Risk_Indicators.BillingIndex.RVA1310_3,	
			model_name='rvt1307_3' => Risk_Indicators.BillingIndex.RVT1307_3,
			model_name='rva1311_1' => Risk_Indicators.BillingIndex.RVA1311_1,	
			model_name='rva1311_2' => Risk_Indicators.BillingIndex.RVA1311_2,
			model_name='rva1311_3' => Risk_Indicators.BillingIndex.RVA1311_3,
			model_name='rvg1401_1' => Risk_Indicators.BillingIndex.RVG1401_1,
			model_name='rvg1401_2' => Risk_Indicators.BillingIndex.RVG1401_2,
			model_name='rvt1402_1' => Risk_Indicators.BillingIndex.RVT1402_1,
			model_name='rvg1310_1' => Risk_Indicators.BillingIndex.RVG1310_1,
			model_name='rvg1404_1' => Risk_Indicators.BillingIndex.RVG1404_1,
			model_name='rvr1311_1' => Risk_Indicators.BillingIndex.RVR1311_1,
			model_name='rvr1410_1' => Risk_Indicators.BillingIndex.RVR1410_1,
			model_name='rvb1310_1' => Risk_Indicators.BillingIndex.RVB1310_1,
			model_name='rvb1402_1' => Risk_Indicators.BillingIndex.RVB1402_1,
			model_name='ied1002_0' => Risk_Indicators.BillingIndex.IED1002_0,
			model_name='rvt1605_1' => Risk_Indicators.BillingIndex.RVT1605_1,
			model_name='rvt1605_2' => Risk_Indicators.BillingIndex.RVT1605_2,
			model_name='rvt1705_1' => Risk_Indicators.BillingIndex.RVT1705_1,
			''
		);
				
		ret := if( svc_name='models.rvauto_service' and model_name IN ['rva707_1', 'rva1007_1', 'rva1007_2'],
			project( ret_ivars, form_model_ivars(LEFT,desc,idx)),
			project( ret_ModelOut, form_model(LEFT,desc,idx))
		);
		
		testout := Risk_Indicators.RV_TestSeed_Function(testPrep, account_value, Test_Data_Table_Name, svc_name, model_name );
		testret := project( testout, transform(Models.Layout_Model, self := left));

	// all possible valid models		
		setModels := [
			'','rvb711_0', 'rva711_0' , 'rvt711_0', 'rvr711_0', 'rvg812_0', 'rvr803_1', 'rvr1008_1', 'aid605_1', 'aid607_0', 'rva707_0', 'rvg903_1', 'rvg904_1', 'rva1003_0', 
			'rvb1003_0', 'rvr1003_0', 'rvt1003_0', 'rvg1003_0', 'rvp1003_0', 'rvd1010_0','rvd1010_1','rvd1010_2', 'ie912_1', 'rva1007_3','rvr1104_3', 'rvr1103_0', 'rvg1103_0', 
			'rva1104_0', 'rvp1104_0', 'rvt1104_0', 'rvb1104_0', 'rvc1112_0', 'rvg1106_1', 'rva1008_1', 'rvt1104_1', 'rvd1110_1', 'ied1106_1', 'rvr1104_2', 'rvg1201_1', 'rva707_1',         
			'rva1007_1', 'rva1007_2', 'rvt1204_1', 'rvt1210_1', 'rvr1303_1', 'rvc1210_1', 'rvt1212_1', 'rvg1302_1', 'rva1304_1', 'rva1304_2', 'rvg1304_1', 'rvg1304_2', 'rva1306_1',
			'rva1305_1', 'rva1305_9', 'rva1309_1', 'rva1310_1', 'rva1310_2', 'rva1310_3', 'rvt1307_3', 'rva1311_1', 'rva1311_2', 'rva1311_3','rvg1401_1', 'rvg1401_2', 'rvt1402_1',
			'rvg1310_1', 'rvg1404_1', 'rvr1311_1','rvr1410_1','rvb1310_1','rvb1402_1', 'rvb1104_1', 'ied1002_0', 'pva1602_0', 'fxd1607_0', 'rvt1605_1', 'rvt1605_2', 'rvt1705_1'];  

		models_result := if(test_data_enabled, testret, ret);
		self.models := if(model_name in setModels, models_result, FAIL(dataset( [], Models.Layout_Model ), 'Invalid model: ' + model_name));

		SELF := [];
	END;

	p := PROJECT(model_url, get_scores(LEFT));

	outer_layout denorm(outer_layout le, Models.Layout_Model ri) := TRANSFORM
		SELF.AccountNumber := ri.AccountNumber;
		SELF.models := ri;
	END;
	normed := NORMALIZE(p, LEFT.models, denorm(LEFT,RIGHT));

	outer_layout combine(outer_layout le, outer_layout ri) := TRANSFORM
		SELF.models := le.models+ri.models;
		SELF := le;
	END;

	scores := ROLLUP(SORT(normed,AccountNumber),LEFT.AccountNumber=RIGHT.AccountNumber, combine(LEFT,RIGHT));

	// get attributes
	attr := Models.getRVAttributes(clam_to_run, account_value, isPreScreen,  if(isPrescreen, PreScreenOptOut, false), datarestriction, BSOptions);
	// Need to project the test seeds into the same layout as attr (Attr contains Address Append attributes, the test seeds do not).
	ret_test_seed := PROJECT(Risk_Indicators.RVAttributes_TestSeed_Function(testPrep, account_value, Test_Data_Table_Name), TRANSFORM(Models.Layout_RVAttributes.Layout_rvAttrSeqWithAddrAppend, SELF := LEFT; SELF := []));


	checkBoolean(boolean x) := if(x, '1', '0');

	Models.Layout_RVAttributes.Layout_rvAttrSeqWithAddrAppend intoAttributes(Models.Layout_RVAttributes.Layout_rvAttrSeqWithAddrAppend le) := TRANSFORM
		self.AccountNumber := le.AccountNumber;
		self.lifestyle.dwelltype := if(doLifestyle, le.lifestyle.dwelltype, '');
		self.lifestyle.assessed_amount := if(doLifestyle, le.lifestyle.assessed_amount, 0);
		self.lifestyle.applicant_owned := if(doLifestyle, le.lifestyle.applicant_owned, false);
		self.lifestyle.family_owned := if(doLifestyle, le.lifestyle.family_owned, false);
		self.lifestyle.occupant_owned := if(doLifestyle, le.lifestyle.occupant_owned, false);
		self.lifestyle.isbestmatch := if(doLifestyle, le.lifestyle.isbestmatch, false);
		self.lifestyle.date_first_seen := if(doLifestyle, le.lifestyle.date_first_seen, 0);
		self.lifestyle.date_first_seen2 := if(doLifestyle, le.lifestyle.date_first_seen2, 0);
		self.lifestyle.date_first_seen3 := if(doLifestyle, le.lifestyle.date_first_seen3, 0);
		self.lifestyle.number_nonderogs := if(doLifestyle, le.lifestyle.number_nonderogs, '');
		self.lifestyle.date_last_seen := if(doLifestyle, le.lifestyle.date_last_seen, 0);
		self.lifestyle.recent_update := if(doLifestyle, le.lifestyle.recent_update, false);

		self.dems.ssn_issued := if(doDemographic, le.dems.ssn_issued, false);
		self.dems.low_issue_date := if(doDemographic, le.dems.low_issue_date, 0);
		self.dems.high_issue_date := if(doDemographic, le.dems.high_issue_date, 0);
		self.dems.nonUS_ssn := if(doDemographic, le.dems.nonUS_ssn, false);
		self.dems.ssn_issue_state := if(doDemographic, le.dems.ssn_issue_state, '');
		self.dems.ssn_first_seen := if(doDemographic, le.dems.ssn_first_seen, 0);	

		self.finance.phone_full_name_match := if(doFinancial, le.finance.phone_full_name_match, false);
		self.finance.phone_last_name_match := if(doFinancial, le.finance.phone_last_name_match, false);
		self.finance.nap_status := if(doFinancial, le.finance.nap_status, '');

		self.property.property_owned_total := if(doProperty, le.property.property_owned_total, 0);
		self.property.property_owned_assessed_total := if(doProperty, le.property.property_owned_assessed_total, 0);
		self.property.property_historically_owned := if(doProperty, le.property.property_historically_owned, 0);

		self.derogs.criminal_count := if(doDerog, le.derogs.criminal_count, 0);
		self.derogs.filing_count := if(doDerog, le.derogs.filing_count, 0);
		self.derogs.date_last_seen := if(doDerog, le.derogs.date_last_seen, 0);
		self.derogs.disposition := if(doDerog, le.derogs.disposition, '');
		self.derogs.liens_historical_unreleased_count := if(doDerog, le.derogs.liens_historical_unreleased_count, 0);
		self.derogs.liens_recent_unreleased_count := if(doDerog, le.derogs.liens_recent_unreleased_count, 0);
		self.derogs.total_number_derogs := if(doDerog, le.derogs.total_number_derogs, 0);
		self.version2 := le.version2;
		self.version3 := le.version3;
		self := le; // sets all v4 attributes
	END;
	attributes := project(if(Test_Data_Enabled, ret_test_seed, ungroup(attr)), intoAttributes(left));
	// attributes := project(ungroup(attr), intoAttributes(left)); // in the case of out of date test seeds us this code


	Layout_Attribute := RECORD, maxlength(10000)
		DATASET(Models.Layout_Parameters) Attribute;
	END;
	Layout_AttributeGroup := RECORD, maxlength(70000)
		string name;
		string index;
		DATASET(Layout_Attribute) Attributes;
	END;
	layout_RVAttributesOut := RECORD, maxlength(100000)
		string30 accountnumber;
		DATASET(Layout_AttributeGroup) AttributeGroup;
	END;

	Models.Layout_Parameters intoLife(attributes le, integer c) := transform
		self.name := map(c=1 => 'Dwelltype',
										 c=2 => 'AssessedAmount',
										 c=3 => 'ApplicantOwned',
										 c=4 => 'FamilyOwned',
										 c=5 => 'OccupantOwned',
										 c=6 => 'NotPrimaryResidence',
										 c=7 => 'DateFirstSeen',
										 c=8 => 'DateFirstSeen2',
										 c=9 => 'DateFirstSeen3',
										 c=10 => 'NumberNonDerogs',
										 c=11 => 'DateLastUpdate',
										 'RecentUpdate');
		self.value := map(c < 13 AND le.version2.SecurityFreeze => '', // Security Freeze Found - Mask all attributes except Security Freeze
											c=1 => le.lifestyle.dwelltype,
											c=2 => (string)le.lifestyle.assessed_amount,
											c=3 => if(le.lifestyle.applicant_owned, 'true', 'false'),
											c=4 => if(le.lifestyle.family_owned, 'true', 'false'),
											c=5 => if(le.lifestyle.occupant_owned, 'true', 'false'),
											c=6 => if(le.lifestyle.isBestMatch, 'true', 'false'),
											c=7 => (string)le.lifestyle.date_first_seen,
											c=8 => (string)le.lifestyle.Date_First_Seen2,
											c=9 => (string)le.lifestyle.Date_First_Seen3,
											c=10 => le.lifestyle.number_nonderogs,
											c=11 => (string)le.lifestyle.date_last_seen,
											if(le.lifestyle.recent_update, 'true', 'false'));
	END;
	Models.Layout_Parameters intoDem(attributes le, integer c) := transform
		self.name := map(c=1 => 'SSNIssued',
										 c=2 => 'LowIssueDate',
										 c=3 => 'HighIssueDate',
										 c=4 => 'NonUSssn',
										 c=5 => 'SSNIssueState',
										 'SSNFirstSeen');
		self.value := map(c < 7 AND le.version2.SecurityFreeze => '', // Security Freeze Found - Mask all attributes except Security Freeze
											c=1 => if(le.dems.ssn_issued, 'true', 'false'),
											c=2 => (string)le.dems.low_issue_date,
											c=3 => (string)le.dems.High_Issue_Date,
											c=4 => if(le.dems.NonUS_SSN, 'true', 'false'),
											c=5 => le.dems.SSN_Issue_State,
											(string)le.dems.SSN_First_Seen);
	END;
	Models.Layout_Parameters intoFin(attributes le, integer c) := TRANSFORM
		self.name := map(c=1 => 'PhoneFullNameMatch',
										 c=2 => 'PhoneLastNameMatch',
										 'NAPStatus');
		self.value := map(c < 4 AND le.version2.SecurityFreeze => '', // Security Freeze Found - Mask all attributes except Security Freeze
											c=1 => if(le.finance.phone_full_name_match, 'true', 'false'),
											c=2 => if(le.finance.phone_last_name_match, 'true', 'false'),
											le.finance.nap_status);
	END;
	Models.Layout_Parameters intoProp(attributes le, integer c) := TRANSFORM
		self.name := map(c=1 => 'PropertyOwnedTotal',
										 c=2 => 'PropertyOwnedAssessedTotal',
										 'PropertyHistoricallyOwned');
		self.value := map(c < 4 AND le.version2.SecurityFreeze => '', // Security Freeze Found - Mask all attributes except Security Freeze
											c=1 => (string)le.property.property_owned_total,
											c=2 => (string)le.property.property_owned_assessed_total,
											(string)le.property.property_historically_owned);
	END;
	Models.Layout_Parameters intoDerog(attributes le, integer c) := TRANSFORM
		self.name := map(c=1 => 'CriminalCount',
										 c=2 => 'FilingCount',
										 c=3 => 'DateLastSeen',
										 c=4 => 'Disposition',
										 c=5 => 'LiensHistoricalUnreleasedCount',
										 c=6 => 'LiensRecentUnreleasedCount',
										 'TotalNumberDerogs');
		self.value := map(c < 8 AND le.version2.SecurityFreeze => '', // Security Freeze Found - Mask all attributes except Security Freeze
											c=1 => (string)le.derogs.criminal_count,
											c=2 => (string)le.derogs.filing_count,
											c=3 => (string)le.derogs.date_last_seen,
											c=4 => le.derogs.Disposition,
											c=5 => (string)le.derogs.Liens_Historical_unreleased_count,
											c=6 => (string)le.derogs.Liens_recent_unreleased_count,
											(string)le.derogs.total_number_derogs);
	END;
	Models.Layout_Parameters intoVersion2(attributes le, integer c) := TRANSFORM
		self.name := map(c=1 => 'SSNFirstSeen',
									 c=2 => 'DateLastUpdate',
									 c=3 => 'RecentUpdate',
									 c=4 => 'NumSrcsConfirmIDAddr',
									 c=5 => 'PhoneFullNameMatch',
									 c=6 => 'PhoneLastNameMatch',
									 c=7 => 'InvalidSSN',
									 c=8 => 'InvalidPhone',
									 c=9 => 'InvalidAddr',
									 c=10 => 'InvalidDL',
									 c=11 => 'NoVerifyNameAddrPhoneSSN',
									 c=12 => 'SSNDeceased',
									 c=13 => 'DateSSNDeceased',
									 c=14 => 'SSNIssued',
									 c=15 => 'RecentSSN',
									 c=16 => 'LowIssueDate',
									 c=17 => 'HighIssueDate',
									 c=18 => 'SSNIssueState',
									 c=19 => 'NonUSssn',
									 c=20 => 'SSN3Years',
									 c=21 => 'SSNAfter5',
									 c=22 => 'InputAddrDateFirstSeen',
									 c=23 => 'InputAddrDateLastSeen',
									 c=24 => 'InputAddrLenOfRes',
									 c=25 => 'InputAddrDwellType',
									 c=26 => 'InputAddrLandUseCode',
									 c=27 => 'InputAddrAssessedValue',
									 c=28 => 'InputAddrApplicantOwned',
									 c=29 => 'InputAddrFamilyOwned',
									 c=30 => 'InputAddrOccupantOwned',
									 c=31 => 'InputAddrLastSalesDate',
									 c=32 => 'InputAddrLastSalesAmount',
									 c=33 => 'InputAddrNotPrimaryRes',
									 c=34 => 'InputAddrActivePhoneList',
									 c=35 => 'InputAddrActivePhoneNumber',
									 c=36 => 'CurrAddrDateFirstSeen',
									 c=37 => 'CurrAddrDateLastSeen',
									 c=38 => 'CurrAddrLenOfRes',
									 c=39 => 'CurrAddrDwellType',
									 c=40 => 'CurrAddrLandUseCode',
									 c=41 => 'CurrAddrAssessedValue',
									 c=42 => 'CurrAddrApplicantOwned',
									 c=43 => 'CurrAddrFamilyOwned',
									 c=44 => 'CurrAddrOccupantOwned',
									 c=45 => 'CurrAddrLastSalesDate',
									 c=46 => 'CurrAddrLastSalesAmount',
									 c=47 => 'CurrAddrNotPrimaryRes',
									 c=48 => 'CurrAddrActivePhoneList',
									 c=49 => 'CurrAddrActivePhoneNumber',
									 c=50 => 'PrevAddrDateFirstSeen',
									 c=51 => 'PrevAddrDateLastSeen',
									 c=52 => 'PrevAddrLenOfRes',
									 c=53 => 'PrevAddrDwellType',
									 c=54 => 'PrevAddrLandUseCode',
									 c=55 => 'PrevAddrAssessedValue',
									 c=56 => 'PrevAddrApplicantOwned',
									 c=57 => 'PrevAddrFamilyOwned',
									 c=58 => 'PrevAddrOccupantOwned',
									 c=59 => 'PrevAddrLastSalesDate',
									 c=60 => 'PrevAddrLastSalesAmount',
									 c=61 => 'PrevAddrNotPrimaryRes',
									 c=62 => 'PrevAddrActivePhoneList',
									 c=63 => 'PrevAddrActivePhoneNumber',
									 c=64 => 'InputAddrCurrAddrMatch',
									 c=65 => 'InputAddrCurrAddrDistance',
									 c=66 => 'InputAddrCurrAddrStateDiff',
									 c=67 => 'InputAddrCurrAddrAssessedDiff',
									 c=68 => 'EconomicTrajectory',
									 c=69 => 'InputAddrPrevAddrMatch',
									 c=70 => 'CurrAddrPrevAddrDistance',
									 c=71 => 'CurrAddrPrevAddrStateDiff',
									 c=72 => 'CurrAddrPrevAddrAssessedDiff',
									 c=73 => 'EconomicTrajectory2',
									 c=74 => 'AddrStability',
									 c=75 => 'StatusMostRecent',
									 c=76 => 'StatusPrevious',
									 c=77 => 'StatusNextPrevious',
									 c=78 => 'PrevAddrDateFirstSeen2',
									 c=79 => 'NextPrevDateFirstSeen',
									 c=80 => 'AddrChanges30',
									 c=81 => 'AddrChanges90',
									 c=82 => 'AddrChanges180',
									 c=83 => 'AddrChanges12',
									 c=84 => 'AddrChanges24',
									 c=85 => 'AddrChanges36',
									 c=86 => 'AddrChanges60',
									 c=87 => 'PropertyOwnedTotal',
									 c=88 => 'PropertyOwnedAssessedTotal',
									 c=89 => 'PropertyHistoricallyOwned',
									 c=90 => 'DateFirstPurchase',
									 c=91 => 'DateMostRecentPurchase',
									 c=92 => 'DateMostRecentSale',
									 c=93 => 'PropPurchased30',
									 c=94 => 'PropPurchased90',
									 c=95 => 'PropPurchased180',
									 c=96 => 'PropPurchased12',
									 c=97 => 'PropPurchased24',
									 c=98 => 'PropPurchased36',
									 c=99 => 'PropPurchased60',
									 c=100 => 'PropSold30',
									 c=101 => 'PropSold90',
									 c=102 => 'PropSold180',
									 c=103 => 'PropSold12',
									 c=104 => 'PropSold24',
									 c=105 => 'PropSold36',
									 c=106 => 'PropSold60',
									 c=107 => 'NumWatercraft',
									 c=108 => 'NumWatercraft30',
									 c=109 => 'NumWatercraft90',
									 c=110 => 'NumWatercraft180',
									 c=111 => 'NumWatercraft12',
									 c=112 => 'NumWatercraft24',
									 c=113 => 'NumWatercraft36',
									 c=114 => 'NumWatercraft60',
									 c=115 => 'NumAircraft',
									 c=116 => 'NumAircraft30',
									 c=117 => 'NumAircraft90',
									 c=118 => 'NumAircraft180',
									 c=119 => 'NumAircraft12',
									 c=120 => 'NumAircraft24',
									 c=121 => 'NumAircraft36',
									 c=122 => 'NumAircraft60',
									 c=123 => 'WealthIndex',
									 c=124 => 'TotalNumberDerogs',
									 c=125 => 'DateLastDerog',
									 c=126 => 'NumFelonies',
									 c=127 => 'DateLastConviction',
									 c=128 => 'NumFelonies30',
									 c=129 => 'NumFelonies90',
									 c=130 => 'NumFelonies180',
									 c=131 => 'NumFelonies12',
									 c=132 => 'NumFelonies24',
									 c=133 => 'NumFelonies36',
									 c=134 => 'NumFelonies60',
									 c=135 => 'LiensCount',
									 c=136 => 'LiensUnreleasedCount',
									 c=137 => 'MostRecentUnrelDate',
									 c=138 => 'LiensUnreleasedCount30',
									 c=139 => 'LiensUnreleasedCount90',
									 c=140 => 'LiensUnreleasedCount180',
									 c=141 => 'LiensUnreleasedCount12',
									 c=142 => 'LiensUnreleasedCount24',
									 c=143 => 'LiensUnreleasedCount36',
									 c=144 => 'LiensUnreleasedCount60',
									 c=145 => 'LiensReleasedCount',
									 c=146 => 'MostRecentReleasedDate',
									 c=147 => 'LiensReleasedCount30',
									 c=148 => 'LiensReleasedCount90',
									 c=149 => 'LiensReleasedCount180',
									 c=150 => 'LiensReleasedCount12',
									 c=151 => 'LiensReleasedCount24',
									 c=152 => 'LiensReleasedCount36',
									 c=153 => 'LiensReleasedCount60',
									 c=154 => 'BankruptCount',
									 c=155 => 'MostRecentBankruptDate',
									 c=156 => 'MostRecentBankruptType',
									 c=157 => 'MostRecentBankruptStatus',
									 c=158 => 'BankruptCount30',
									 c=159 => 'BankruptCount90',
									 c=160 => 'BankruptCount180',
									 c=161 => 'BankruptCount12',
									 c=162 => 'BankruptCount24',
									 c=163 => 'BankruptCount36',
									 c=164 => 'BankruptCount60',
									 c=165 => 'EvictionCount',
									 c=166 => 'MostRecentEvictionDate',
									 c=167 => 'EvictionCount30',
									 c=168 => 'EvictionCount90',
									 c=169 => 'EvictionCount180',
									 c=170 => 'EvictionCount12',
									 c=171 => 'EvictionCount24',
									 c=172 => 'EvictionCount36',
									 c=173 => 'EvictionCount60',
									 c=174 => 'NonDerogSrcCount',
									 c=175 => 'NonDerogSrcCount30',
									 c=176 => 'NonDerogSrcCount90',
									 c=177 => 'NonDerogSrcCount180',
									 c=178 => 'NonDerogSrcCount12',
									 c=179 => 'NonDerogSrcCount24',
									 c=180 => 'NonDerogSrcCount36',
									 c=181 => 'NonDerogSrcCount60',
									 c=182 => 'ProfLicCount',
									 c=183 => 'MostRecentProfLicDate',
									 c=184 => 'MostRecentProfLicType',
									 c=185 => 'MostRecentProfLicExpireDate',
									 c=186 => 'ProfLicCount30',
									 c=187 => 'ProfLicCount90',
									 c=188 => 'ProfLicCount180',
									 c=189 => 'ProfLicCount12',
									 c=190 => 'ProfLicCount24',
									 c=191 => 'ProfLicCount36',
									 c=192 => 'ProfLicCount60',
									 c=193 => 'ProfLicExpireCount30',
									 c=194 => 'ProfLicExpireCount90',
									 c=195 => 'ProfLicExpireCount180',
									 c=196 => 'ProfLicExpireCount12',
									 c=197 => 'ProfLicExpireCount24',
									 c=198 => 'ProfLicExpireCount36',
									 c=199 => 'ProfLicExpireCount60',
									 c=200 => 'InputAddrCommercial',
									 c=201 => 'InputPhoneCommercial',
									 c=202 => 'InputAddrPrison',
									 c=203 => 'InputZipPOBox',
									 c=204 => 'InputZipCorpMil',
									 c=205 => 'InputPhoneStatus',
									 c=206 => 'InputPhonePager',
									 c=207 => 'InputPhoneMobile',
									 c=208 => 'InvalidPhoneZip',
									 c=209 => 'InputPhoneAddrDist',
									 c=210 => 'SecurityFreeze',
									 c=211 => 'SecurityAlert',
									 c=212 => 'IdentityTheft',
									 c=213 => 'DisputeOnFile',
									 c=214 => 'NegativeFileAlert',
									 'CorrectionUsed');
									 
	self.value := map( c < 216 AND c <> 210 AND le.version2.SecurityFreeze => '', // Security Freeze Found - Mask all attributes except Security Freeze
										 c=1 => (string)le.version2.SSNFirstSeen,
										 c=2 => (string)le.version2.DateLastSeen,
										 c=3 => checkBoolean(le.version2.isRecentUpdate),
										 c=4 => (string)le.version2.NumSources,
										 c=5 => checkBoolean(le.version2.isPhoneFullNameMatch),
										 c=6 => checkBoolean(le.version2.isPhoneLastNameMatch),
										 c=7 => checkBoolean(le.version2.isSSNInvalid),
										 c=8 => checkBoolean(le.version2.isPhoneInvalid),
										 c=9 => checkBoolean(le.version2.isAddrInvalid),
										 c=10 => checkBoolean(le.version2.isDLInvalid),
										 c=11 => checkBoolean(le.version2.isNoVer),
										 c=12 => checkBoolean(le.version2.isDeceased),
										 c=13 => (string)le.version2.DeceasedDate,
										 c=14 => checkBoolean(le.version2.isSSNValid),
										 c=15 => checkBoolean(le.version2.isRecentIssue),
										 c=16 => (string)le.version2.LowIssueDate,
										 c=17 => (string)le.version2.HighIssueDate,
										 c=18 => (string)le.version2.IssueState,
										 c=19 => checkBoolean(le.version2.isNonUS),
										 c=20 => checkBoolean(le.version2.isIssued3),
										 c=21 => checkBoolean(le.version2.isIssuedAge5),
										 c=22 => (string)le.version2.IADateFirstReported,
										 c=23 => (string)le.version2.IADateLastReported,
										 c=24 => (string)le.version2.IALenOfRes,
										 c=25 => le.version2.IADwellType,
										 c=26 => le.version2.IALandUseCode,
										 c=27 => (string)le.version2.IAAssessedValue,
										 c=28 => checkBoolean(le.version2.IAisOwnedBySubject),
										 c=29 => checkBoolean(le.version2.IAisFamilyOwned),
										 c=30 => checkBoolean(le.version2.IAisOccupantOwned),
										 c=31 => (string)le.version2.IALastSaleDate,
										 c=32 => (string)le.version2.IALastSaleAmount,
										 c=33 => checkBoolean(le.version2.IAisNotPrimaryRes),
										 c=34 => (string)le.version2.IAPhoneListed,
										 c=35 => (string)le.version2.IAPhoneNumber,
										 c=36 => (string)le.version2.CADateFirstReported,
										 c=37 => (string)le.version2.CADateLastReported,
										 c=38 => (string)le.version2.CALenOfRes,
										 c=39 => le.version2.CADwellType,
										 c=40 => le.version2.CALandUseCode,
										 c=41 => (string)le.version2.CAAssessedValue,
										 c=42 => checkBoolean(le.version2.CAisOwnedBySubject),
										 c=43 => checkBoolean(le.version2.CAisFamilyOwned),
										 c=44 => checkBoolean(le.version2.CAisOccupantOwned),
										 c=45 => (string)le.version2.CALastSaleDate,
										 c=46 => (string)le.version2.CALastSaleAmount,
										 c=47 => checkBoolean(le.version2.CAisNotPrimaryRes),
										 c=48 => (string)le.version2.CAPhoneListed,
										 c=49 => (string)le.version2.CAPhoneNumber,
										 c=50 => (string)le.version2.PADateFirstReported,
										 c=51 => (string)le.version2.PADateLastReported,
										 c=52 => (string)le.version2.PALenOfRes,
										 c=53 => le.version2.PADwellType,
										 c=54 => le.version2.PALandUseCode,
										 c=55 => (string)le.version2.PAAssessedValue,
										 c=56 => checkBoolean(le.version2.PAisOwnedBySubject),
										 c=57 => checkBoolean(le.version2.PAisFamilyOwned),
										 c=58 => checkBoolean(le.version2.PAisOccupantOwned),
										 c=59 => (string)le.version2.PALastSaleDate,
										 c=60 => (string)le.version2.PALastSaleAmount,
										 c=61 => checkBoolean(le.version2.PAisNotPrimaryRes),
										 c=62 => (string)le.version2.PAPhoneListed,
										 c=63 => (string)le.version2.PAPhoneNumber,
										 c=64 => checkBoolean(le.version2.isInputCurrMatch),
										 c=65 => (string)le.version2.DistInputCurr,
										 c=66 => checkBoolean(le.version2.isDiffState),
										 c=67 => (string)le.version2.AssessedDiff,
										 c=68 => le.version2.EcoTrajectory,
										 c=69 => checkBoolean(le.version2.isInputPrevMatch),
										 c=70 => (string)le.version2.DistCurrPrev,
										 c=71 => checkBoolean(le.version2.isDiffState2),
										 c=72 => (string)le.version2.AssessedDiff2,
										 c=73 => le.version2.EcoTrajectory2,
										 c=74 => (string)le.version2.mobility_indicator,
										 c=75 => le.version2.statusAddr,
										 c=76 => le.version2.statusAddr2,
										 c=77 => le.version2.statusAddr3,
										 c=78 => (string)le.version2.PADateFirstReported2,
										 c=79 => (string)le.version2.NPADateFirstReported,
										 c=80 => (string)le.version2.addrChanges30,
										 c=81 => (string)le.version2.AddrChanges90,
										 c=82 => (string)le.version2.AddrChanges180,
										 c=83 => (string)le.version2.AddrChanges12,
										 c=84 => (string)le.version2.AddrChanges24,
										 c=85 => (string)le.version2.AddrChanges36,
										 c=86 => (string)le.version2.AddrChanges60,
										 c=87 => (string)le.version2.property_owned_total,
										 c=88 => (string)le.version2.property_owned_assessed_total,
										 c=89 => (string)le.version2.property_historically_owned,
										 c=90 => (string)le.version2.date_first_purchase,
										 c=91 => (string)le.version2.date_most_recent_purchase,
										 c=92 => (string)le.version2.date_most_recent_sale,
										 c=93 => (string)le.version2.numPurchase30,
										 c=94 => (string)le.version2.numPurchase90,
										 c=95 => (string)le.version2.numPurchase180,
										 c=96 => (string)le.version2.numPurchase12,
										 c=97 => (string)le.version2.numPurchase24,
										 c=98 => (string)le.version2.numPurchase36,
										 c=99 => (string)le.version2.numPurchase60,
										 c=100 => (string)le.version2.numSold30,
										 c=101 => (string)le.version2.numSold90,
										 c=102 => (string)le.version2.numSold180,
										 c=103 => (string)le.version2.numSold12,
										 c=104 => (string)le.version2.numSold24,
										 c=105 => (string)le.version2.numSold36,
										 c=106 => (string)le.version2.numSold60,
										 c=107 => (string)le.version2.NumWatercraft,
										 c=108 => (string)le.version2.NumWatercraft30,
										 c=109 => (string)le.version2.NumWatercraft90,
										 c=110 => (string)le.version2.NumWatercraft180,
										 c=111 => (string)le.version2.NumWatercraft12,
										 c=112 => (string)le.version2.NumWatercraft24,
										 c=113 => (string)le.version2.NumWatercraft36,
										 c=114 => (string)le.version2.NumWatercraft60,
										 c=115 => (string)le.version2.NumAircraft,
										 c=116 => (string)le.version2.NumAircraft30,
										 c=117 => (string)le.version2.NumAircraft90,
										 c=118 => (string)le.version2.NumAircraft180,
										 c=119 => (string)le.version2.NumAircraft12,
										 c=120 => (string)le.version2.NumAircraft24,
										 c=121 => (string)le.version2.NumAircraft36,
										 c=122 => (string)le.version2.NumAircraft60,
										 c=123 => le.version2.wealth_indicator,
										 c=124 => (string)le.version2.total_number_derogs,
										 c=125 => (string)le.version2.date_last_derog,
										 c=126 => (string)le.version2.felonies,
										 c=127 => (string)le.version2.date_last_conviction,
										 c=128 => (string)le.version2.Felonies30,
										 c=129 => (string)le.version2.Felonies90,
										 c=130 => (string)le.version2.Felonies180,
										 c=131 => (string)le.version2.Felonies12,
										 c=132 => (string)le.version2.Felonies24,
										 c=133 => (string)le.version2.Felonies36,
										 c=134 => (string)le.version2.Felonies60,
										 c=135 => (string)le.version2.num_liens,
										 c=136 => (string)le.version2.num_unreleased_liens,
										 c=137 => (string)le.version2.date_last_unreleased,
										 c=138 => (string)le.version2.num_unreleased_liens30,
										 c=139 => (string)le.version2.num_unreleased_liens90,
										 c=140 => (string)le.version2.num_unreleased_liens180,
										 c=141 => (string)le.version2.num_unreleased_liens12,
										 c=142 => (string)le.version2.num_unreleased_liens24,
										 c=143 => (string)le.version2.num_unreleased_liens36,
										 c=144 => (string)le.version2.num_unreleased_liens60,
										 c=145 => (string)le.version2.num_released_liens,
										 c=146 => (string)le.version2.date_last_released,
										 c=147 => (string)le.version2.num_released_liens30,
										 c=148 => (string)le.version2.num_released_liens90,
										 c=149 => (string)le.version2.num_released_liens180,
										 c=150 => (string)le.version2.num_released_liens12,
										 c=151 => (string)le.version2.num_released_liens24,
										 c=152 => (string)le.version2.num_released_liens36,
										 c=153 => (string)le.version2.num_released_liens60,
										 c=154 => (string)le.version2.bankruptcy_count,
										 c=155 => (string)le.version2.date_last_bankruptcy,
										 c=156 => le.version2.filing_type,
										 c=157 => le.version2.disposition,
										 c=158 => (string)le.version2.bankruptcy_count30,
										 c=159 => (string)le.version2.bankruptcy_count90,
										 c=160 => (string)le.version2.bankruptcy_count180,
										 c=161 => (string)le.version2.bankruptcy_count12,
										 c=162 => (string)le.version2.bankruptcy_count24,
										 c=163 => (string)le.version2.bankruptcy_count36,
										 c=164 => (string)le.version2.bankruptcy_count60,
										 c=165 => (string)le.version2.eviction_count,
										 c=166 => (string)le.version2.date_last_eviction,
										 c=167 => (string)le.version2.eviction_count30,
										 c=168 => (string)le.version2.eviction_count90,
										 c=169 => (string)le.version2.eviction_count180,
										 c=170 => (string)le.version2.eviction_count12,
										 c=171 => (string)le.version2.eviction_count24,
										 c=172 => (string)le.version2.eviction_count36,
										 c=173 => (string)le.version2.eviction_count60,
										 c=174 => (string)le.version2.num_nonderogs,
										 c=175 => (string)le.version2.num_nonderogs30,
										 c=176 => (string)le.version2.num_nonderogs90,
										 c=177 => (string)le.version2.num_nonderogs180,
										 c=178 => (string)le.version2.num_nonderogs12,
										 c=179 => (string)le.version2.num_nonderogs24,
										 c=180 => (string)le.version2.num_nonderogs36,
										 c=181 => (string)le.version2.num_nonderogs60,
										 c=182 => (string)le.version2.num_proflic,
										 c=183 => (string)le.version2.date_last_proflic,
										 c=184 => le.version2.proflic_type,
										 c=185 => IF(le.version2.expire_date_last_proflic = 999999, '', (string)le.version2.expire_date_last_proflic),
										 c=186 => (string)le.version2.num_proflic30,
										 c=187 => (string)le.version2.num_proflic90,
										 c=188 => (string)le.version2.num_proflic180,
										 c=189 => (string)le.version2.num_proflic12,
										 c=190 => (string)le.version2.num_proflic24,
										 c=191 => (string)le.version2.num_proflic36,
										 c=192 => (string)le.version2.num_proflic60,
										 c=193 => (string)le.version2.num_proflic_exp30,
										 c=194 => (string)le.version2.num_proflic_exp90,
										 c=195 => (string)le.version2.num_proflic_exp180,
										 c=196 => (string)le.version2.num_proflic_exp12,
										 c=197 => (string)le.version2.num_proflic_exp24,
										 c=198 => (string)le.version2.num_proflic_exp36,
										 c=199 => (string)le.version2.num_proflic_exp60,
										 c=200 => checkBoolean(le.version2.isAddrHighRisk),
										 c=201 => checkBoolean(le.version2.isPhoneHighRisk),
										 c=202 => checkBoolean(le.version2.isAddrPrison),
										 c=203 => checkBoolean(le.version2.isZipPOBox),
										 c=204 => checkBoolean(le.version2.isZipCorpMil),
										 c=205 => le.version2.phoneStatus,
										 c=206 => checkBoolean(le.version2.isPhonePager),
										 c=207 => checkBoolean(le.version2.isPhoneMobile),
										 c=208 => checkBoolean(le.version2.isPhoneZipMismatch),
										 c=209 => (string)le.version2.phoneAddrDist,
										 c=210 => checkBoolean(le.version2.SecurityFreeze),
										 c=211 => checkBoolean(le.version2.SecurityAlert),
										 c=212 => checkBoolean(le.version2.IdTheftFlag),
										 c=213 => checkBoolean(le.version2.DisputeFlag),
										 c=214 => checkBoolean(le.version2.NegativeAlert),
										 checkBoolean(le.version2.CorrectedFlag));
	END;

// determine if the transaction is coming from experian customer by checking the experian data restriction mask setting
// if the customer has access to see experian's fcra data, we know it's an experian customer
ExperianTransaction := DataRestriction[risk_indicators.iid_constants.posExperianFCRARestriction]='0';	
										 
	Models.Layout_Parameters intoVersion3(attributes le, integer c) := TRANSFORM
		self.name := map(c=1 => 'AgeOldestRecord',
									 c=2 => 'AgeNewestRecord',
									 c=3 => 'RecentUpdate',
									 c=4 => 'SrcsConfirmIDAddrCount',
									 c=5 => 'VerifiedPhoneFullName',
									 c=6 => 'VerifiedPhoneLastName',
									 c=7 => 'InvalidSSN',
									 c=8 => 'InvalidPhone',
									 c=9 => 'InvalidAddr',
									 c=10 => 'InvalidDL',
									 c=11 => 'VerificationFailure',
									 c=12 => 'SSNDeceased',
									 c=13 => 'SSNDateDeceased',
									 c=14 => 'SSNIssued',
									 c=15 => 'SSNRecent',
									 c=16 => 'SSNLowIssueDate',
									 c=17 => 'SSNHighIssueDate',
									 c=18 => 'SSNIssueState',
									 c=19 => 'SSNNonUS',
									 c=20 => 'SSN3Years',
									 c=21 => 'SSNAfter5',
									 c=22 => 'InputAddrAgeOldestRecord',
									 c=23 => 'InputAddrAgeNewestRecord',
									 c=24 => 'InputAddrLenOfRes',
									 c=25 => 'InputAddrDwellType',
									 c=26 => 'InputAddrLandUseCode',
									 c=27 => 'InputAddrTaxValue',
									 c=28 => 'InputAddrApplicantOwned',
									 c=29 => 'InputAddrFamilyOwned',
									 c=30 => 'InputAddrOccupantOwned',
									 c=31 => 'InputAddrAgeLastSale',
									 c=32 => 'InputAddrLastSalesPrice',
									 c=33 => 'InputAddrNotPrimaryRes',
									 c=34 => 'InputAddrActivePhoneList',
									 c=35 => 'InputAddrActivePhoneNumber',
									 c=36 => 'CurrAddrAgeOldestRecord',
									 c=37 => 'CurrAddrAgeNewestRecord',
									 c=38 => 'CurrAddrLenOfRes',
									 c=39 => 'CurrAddrDwellType',
									 c=40 => 'CurrAddrLandUseCode',
									 c=41 => 'CurrAddrTaxValue',
									 c=42 => 'CurrAddrApplicantOwned',
									 c=43 => 'CurrAddrFamilyOwned',
									 c=44 => 'CurrAddrOccupantOwned',
									 c=45 => 'CurrAddrAgeLastSale',
									 c=46 => 'CurrAddrLastSalesPrice',
									 c=47 => 'CurrAddrNotPrimaryRes',
									 c=48 => 'CurrAddrActivePhoneList',
									 c=49 => 'CurrAddrActivePhoneNumber',
									 c=50 => 'PrevAddrAgeOldestRecord',
									 c=51 => 'PrevAddrAgeNewestRecord',
									 c=52 => 'PrevAddrLenOfRes',
									 c=53 => 'PrevAddrDwellType',
									 c=54 => 'PrevAddrLandUseCode',
									 c=55 => 'PrevAddrTaxValue',
									 c=56 => 'PrevAddrApplicantOwned',
									 c=57 => 'PrevAddrFamilyOwned',
									 c=58 => 'PrevAddrOccupantOwned',
									 c=59 => 'PrevAddrAgeLastSale',
									 c=60 => 'PrevAddrLastSalesPrice',
									 c=61 => 'PrevAddrActivePhoneList',
									 c=62 => 'PrevAddrActivePhoneNumber',
									 c=63 => 'InputCurrAddrMatch',
									 c=64 => 'InputCurrAddrDistance',
									 c=65 => 'InputCurrAddrStateDiff',
									 c=66 => 'InputCurrAddrTaxDiff',
									 c=67 => 'InputCurrEconTrajectory',
									 c=68 => 'InputPrevAddrMatch',
									 c=69 => 'CurrPrevAddrDistance',
									 c=70 => 'CurrPrevAddrStateDiff',
									 c=71 => 'CurrPrevAddrTaxDiff',
									 c=72 => 'PrevCurrEconTrajectory',
									 c=73 => 'AddrStability',
									 c=74 => 'StatusMostRecent',
									 c=75 => 'StatusPrevious',
									 c=76 => 'StatusNextPrevious',
									 c=77 => 'AddrChangeCount01',
									 c=78 => 'AddrChangeCount03',
									 c=79 => 'AddrChangeCount06',
									 c=80 => 'AddrChangeCount12',
									 c=81 => 'AddrChangeCount24',
									 c=82 => 'AddrChangeCount36',
									 c=83 => 'AddrChangeCount60',
									 c=84 => 'PropOwnedCount',
									 c=85 => 'PropOwnedTaxTotal',
									 c=86 => 'PropOwnedHistoricalCount',
									 c=87 => 'PropAgeOldestPurchase',
									 c=88 => 'PropAgeNewestPurchase',
									 c=89 => 'PropAgeNewestSale',
									 c=90 => 'PropPurchasedCount01',
									 c=91 => 'PropPurchasedCount03',
									 c=92 => 'PropPurchasedCount06',
									 c=93 => 'PropPurchasedCount12',
									 c=94 => 'PropPurchasedCount24',
									 c=95 => 'PropPurchasedCount36',
									 c=96 => 'PropPurchasedCount60',
									 c=97 => 'PropSoldCount01',
									 c=98 => 'PropSoldCount03',
									 c=99 => 'PropSoldCount06',
									 c=100 => 'PropSoldCount12',
									 c=101 => 'PropSoldCount24',
									 c=102 => 'PropSoldCount36',
									 c=103 => 'PropSoldCount60',
									 c=104 => 'WatercraftCount',
									 c=105 => 'WatercraftCount01',
									 c=106 => 'WatercraftCount03',
									 c=107 => 'WatercraftCount06',
									 c=108 => 'WatercraftCount12',
									 c=109 => 'WatercraftCount24',
									 c=110 => 'WatercraftCount36',
									 c=111 => 'WatercraftCount60',
									 c=112 => 'AircraftCount',
									 c=113 => 'AircraftCount01',
									 c=114 => 'AircraftCount03',
									 c=115 => 'AircraftCount06',
									 c=116 => 'AircraftCount12',
									 c=117 => 'AircraftCount24',
									 c=118 => 'AircraftCount36',
									 c=119 => 'AircraftCount60',
									 c=120 => 'WealthIndex',
									 c=121 => 'DerogCount',
									 c=122 => 'DerogAge',
									 c=123 => 'FelonyCount',
									 c=124 => 'FelonyAge',
									 c=125 => 'FelonyCount01',
									 c=126 => 'FelonyCount03',
									 c=127 => 'FelonyCount06',
									 c=128 => 'FelonyCount12',
									 c=129 => 'FelonyCount24',
									 c=130 => 'FelonyCount36',
									 c=131 => 'FelonyCount60',
									 c=132 => 'LienCount',
									 c=133 => 'LienFiledCount',
									 c=134 => 'LienFiledAge',
									 c=135 => 'LienFiledCount01',
									 c=136 => 'LienFiledCount03',
									 c=137 => 'LienFiledCount06',
									 c=138 => 'LienFiledCount12',
									 c=139 => 'LienFiledCount24',
									 c=140 => 'LienFiledCount36',
									 c=141 => 'LienFiledCount60',
									 c=142 => 'LienReleasedCount',
									 c=143 => 'LienReleasedAge',
									 c=144 => 'LienReleasedCount01',
									 c=145 => 'LienReleasedCount03',
									 c=146 => 'LienReleasedCount06',
									 c=147 => 'LienReleasedCount12',
									 c=148 => 'LienReleasedCount24',
									 c=149 => 'LienReleasedCount36',
									 c=150 => 'LienReleasedCount60',
									 c=151 => 'BankruptcyCount',
									 c=152 => 'BankruptcyAge',
									 c=153 => 'BankruptcyType',
									 c=154 => 'BankruptcyStatus',
									 c=155 => 'BankruptcyCount01',
									 c=156 => 'BankruptcyCount03',
									 c=157 => 'BankruptcyCount06',
									 c=158 => 'BankruptcyCount12',
									 c=159 => 'BankruptcyCount24',
									 c=160 => 'BankruptcyCount36',
									 c=161 => 'BankruptcyCount60',
									 c=162 => 'EvictionCount',
									 c=163 => 'EvictionAge',
									 c=164 => 'EvictionCount01',
									 c=165 => 'EvictionCount03',
									 c=166 => 'EvictionCount06',
									 c=167 => 'EvictionCount12',
									 c=168 => 'EvictionCount24',
									 c=169 => 'EvictionCount36',
									 c=170 => 'EvictionCount60',
									 c=171 => 'NonDerogCount',
									 c=172 => 'NonDerogCount01',
									 c=173 => 'NonDerogCount03',
									 c=174 => 'NonDerogCount06',
									 c=175 => 'NonDerogCount12',
									 c=176 => 'NonDerogCount24',
									 c=177 => 'NonDerogCount36',
									 c=178 => 'NonDerogCount60',
									 c=179 => 'ProfLicCount',
									 c=180 => 'ProfLicAge',
									 c=181 => 'ProfLicType',
									 c=182 => 'ProfLicExpireDate',
									 c=183 => 'ProfLicCount01',
									 c=184 => 'ProfLicCount03',
									 c=185 => 'ProfLicCount06',
									 c=186 => 'ProfLicCount12',
									 c=187 => 'ProfLicCount24',
									 c=188 => 'ProfLicCount36',
									 c=189 => 'ProfLicCount60',
									 c=190 => 'ProfLicExpireCount01',
									 c=191 => 'ProfLicExpireCount03',
									 c=192 => 'ProfLicExpireCount06',
									 c=193 => 'ProfLicExpireCount12',
									 c=194 => 'ProfLicExpireCount24',
									 c=195 => 'ProfLicExpireCount36',
									 c=196 => 'ProfLicExpireCount60',
									 c=197 => 'InputAddrHighRisk',
									 c=198 => 'InputPhoneHighRisk',
									 c=199 => 'InputAddrPrison',
									 c=200 => 'InputZipPOBox',
									 c=201 => 'InputZipCorpMil',
									 c=202 => 'InputPhoneStatus',
									 c=203 => 'InputPhonePager',
									 c=204 => 'InputPhoneMobile',
									 c=205 => 'InvalidPhoneZip',
									 c=206 => 'InputPhoneAddrDist',
									 c=207 => 'SecurityFreeze',
									 c=208 => 'SecurityAlert',
									 c=209 => 'IDTheftFlag',
									 c=210 => 'CorrectedFlag',

									 c=211 => 'SSNNotFound',
									 c=212 => 'VerifiedName',
									 c=213 => 'VerifiedSSN',
									 c=214 => 'VerifiedPhone',
									 c=215 => 'VerifiedAddress',
									 c=216 => 'VerifiedDOB',
									 c=217 => 'InferredMinimumAge',
									 c=218 => 'BestReportedAge',
									 c=219 => 'SubjectSSNCount',
									 c=220 => 'SubjectAddrCount',
									 c=221 => 'SubjectPhoneCount',
									 c=222 => 'SubjectSSNRecentCount',
									 c=223 => 'SubjectAddrRecentCount',
									 c=224 => 'SubjectPhoneRecentCount',
									 c=225 => 'SSNIdentitiesCount',
									 c=226 => 'SSNAddrCount',
									 c=227 => 'SSNIdentitiesRecentCount',
									 c=228 => 'SSNAddrRecentCount',
									 c=229 => 'InputAddrIdentitiesCount',
									 c=230 => 'InputAddrSSNCount',
									 c=231 => 'InputAddrPhoneCount',
									 c=232 => 'InputAddrIdentitiesRecentCount',
									 c=233 => 'InputAddrSSNRecentCount',
									 c=234 => 'InputAddrPhoneRecentCount',
									 c=235 => 'PhoneIdentitiesCount',
									 c=236 => 'PhoneIdentitiesRecentCount',
									 c=237 => 'SSNIssuedPriorDOB',
									 c=238 => 'InputAddrTaxYr',
									 c=239 => 'InputAddrTaxMarketValue',
									 c=240 => 'InputAddrAVMTax',
									 c=241 => 'InputAddrAVMSalesPrice',
									 c=242 => 'InputAddrAVMHedonic',
									 c=243 => 'InputAddrAVMValue',
									 c=244 => 'InputAddrAVMConfidence',
									 c=245 => 'InputAddrCountyIndex',
									 c=246 => 'InputAddrTractIndex',
									 c=247 => 'InputAddrBlockIndex',
									 c=248 => 'CurrAddrTaxYr',
									 c=249 => 'CurrAddrTaxMarketValue',
									 c=250 => 'CurrAddrAVMTax',
									 c=251 => 'CurrAddrAVMSalesPrice',
									 c=252 => 'CurrAddrAVMHedonic',
									 c=253 => 'CurrAddrAVMValue',
									 c=254 => 'CurrAddrAVMConfidence',
									 c=255 => 'CurrAddrCountyIndex',
									 c=256 => 'CurrAddrTractIndex',
									 c=257 => 'CurrAddrBlockIndex',
									 c=258 => 'PrevAddrTaxYr',
									 c=259 => 'PrevAddrTaxMarketValue',
									 c=260 => 'PrevAddrAVMTax',
									 c=261 => 'PrevAddrAVMSalesPrice',
									 c=262 => 'PrevAddrAVMHedonic',
									 c=263 => 'PrevAddrAVMValue',
									 c=264 => 'PrevAddrAVMConfidence',
									 c=265 => 'PrevAddrCountyIndex',
									 c=266 => 'PrevAddrTractIndex',
									 c=267 => 'PrevAddrBlockIndex',
									 c=268 => 'EducationAttendedCollege',
									 c=269 => 'EducationProgram2Yr',
									 c=270 => 'EducationProgram4Yr',
									 c=271 => 'EducationProgramGraduate',
									 c=272 => 'EducationInstitutionPrivate',
									 c=273 => 'EducationInstitutionRating',
									 c=274 => 'PredictedAnnualIncome',
									 c=275 => 'PropNewestSalePrice',
									 c=276 => 'PropNewestSalePurchaseIndex',
									 c=277 => 'SubPrimeSolicitedCount',
									 c=278 => 'SubPrimeSolicitedCount01',
									 c=279 => 'SubprimeSolicitedCount03',
									 c=280 => 'SubprimeSolicitedCount06',
									 c=281 => 'SubPrimeSolicitedCount12',
									 c=282 => 'SubPrimeSolicitedCount24',
									 c=283 => 'SubPrimeSolicitedCount36',
									 c=284 => 'SubPrimeSolicitedCount60',
									 c=285 => 'LienFederalTaxFiledTotal',
									 c=286 => 'LienTaxOtherFiledTotal',
									 c=287 => 'LienForeclosureFiledTotal',
									 c=288 => 'LienPreforeclosureFiledTotal',
									 c=289 => 'LienLandlordTenantFiledTotal',
									 c=290 => 'LienJudgmentFiledTotal',
									 c=291 => 'LienSmallClaimsFiledTotal',
									 c=292 => 'LienOtherFiledTotal',
									 c=293 => 'LienFederalTaxReleasedTotal',
									 c=294 => 'LienTaxOtherReleasedTotal',
									 c=295 => 'LienForeclosureReleasedTotal',
									 c=296 => 'LienPreforeclosureReleasedTotal',
									 c=297 => 'LienLandlordTenantReleasedTotal',
									 c=298 => 'LienJudgmentReleasedTotal',
									 c=299 => 'LienSmallClaimsReleasedTotal',
									 c=300 => 'LienOtherReleasedTotal',
									 c=301 => 'LienFederalTaxFiledCount',
									 c=302 => 'LienTaxOtherFiledCount',
									 c=303 => 'LienForeclosureFiledCount',
									 c=304 => 'LienPreforeclosureFiledCount',
									 c=305 => 'LienLandlordTenantFiledCount',
									 c=306 => 'LienJudgmentFiledCount',
									 c=307 => 'LienSmallClaimsFiledCount',
									 c=308 => 'LienOtherFiledCount',
									 c=309 => 'LienFederalTaxReleasedCount',
									 c=310 => 'LienTaxOtherReleasedCount',
									 c=311 => 'LienForeclosureReleasedCount',
									 c=312 => 'LienPreforeclosureReleasedCount',
									 c=313 => 'LienLandlordTenantReleasedCount',
									 c=314 => 'LienJudgmentReleasedCount',
									 c=315 => 'LienSmallClaimsReleasedCount',
									 c=316 => 'LienOtherReleasedCount',
									 c=317 => 'ProfLicTypeCategory',
									 c=318 => 'PhoneEDAAgeOldestRecord',
									 c=319 => 'PhoneEDAAgeNewestRecord',
									 c=320 => 'PhoneOtherAgeOldestRecord',
									 c=321 => 'PhoneOtherAgeNewestRecord',
									 c=322 => 'PrescreenOptOut',
									 c=323 => 'AddrAppendInputCurr',
									 c=324 => 'AddrAppendStreetAddress',
									 c=325 => 'AddrAppendCity',
									 c=326 => 'AddrAppendState',
									 c=327 => 'AddrAppendZip',
														'');
									 
	self.value := map( (c < 322 OR c > 322) and le.version3.PrescreenOptOut = '1' => '', // opt out applies, blank all return values
										 c <= 327 AND c <> 207 AND le.version3.SecurityFreeze => '', // Security Freeze Found - Mask all attributes except Security Freeze
										 c <= 327 and c <> 11 and ExperianTransaction and le.version3.isnover => '',  // blank out all attributes for Experian transactions if VerificationFailure
                     c <= 327 and c <> 11 and le.v4_ConsumerStatement='1' => '', // blank out all attributes for someone with consumer statement.  Riskview Dempsey req 4.5, https://jira.rsi.lexisnexis.com/browse/RQ-14829
										 c=1 => le.version3.AgeOldestRecord,
										 c=2 => le.version3.AgeNewestRecord,
										 c=3 => checkBoolean(le.version3.isRecentUpdate),
										 c=4 => (string)le.version3.NumSources,
										 c=5 => le.version3.VerifiedPhoneFullName,
										 c=6 => le.version3.VerifiedPhoneLastName,
										 c=7 => le.version3.InvalidSSN,
										 c=8 => le.version3.InvalidPhone,
										 c=9 => le.version3.InvalidAddr,
										 c=10 => le.version3.InvalidDL,
										 c=11 => checkBoolean(le.version3.isNoVer),
										 c=12 => le.version3.SSNDeceased,
										 c=13 => le.version3.DeceasedDate,
										 c=14 => le.version3.SSNValid,
										 c=15 => le.version3.RecentIssue,
										 c=16 => le.version3.LowIssueDate,
										 c=17 => le.version3.HighIssueDate,
										 c=18 => (string)le.version3.IssueState,
										 c=19 => le.version3.NonUS,
										 c=20 => le.version3.Issued3,
										 c=21 => le.version3.IssuedAge5,
										 c=22 => le.version3.IAAgeOldestRecord,
										 c=23 => le.version3.IAAgeNewestRecord,
										 c=24 => le.version3.IALenOfRes,
										 c=25 => le.version3.IADwellType,
										 c=26 => le.version3.IALandUseCode,
										 c=27 => le.version3.IAAssessedValue,
										 c=28 => le.version3.IAOwnedBySubject,
										 c=29 => le.version3.IAFamilyOwned,
										 c=30 => le.version3.IAOccupantOwned,
										 c=31 => le.version3.IAAgeLastSale,
										 c=32 => le.version3.IALastSaleAmount,
										 c=33 => le.version3.IANotPrimaryRes,
										 c=34 => le.version3.IAPhoneListed,
										 c=35 => le.version3.IAPhoneNumber,
										 c=36 => le.version3.CAAgeOldestRecord,
										 c=37 => le.version3.CAAgeNewestRecord,
										 c=38 => le.version3.CALenOfRes,
										 c=39 => le.version3.CADwellType,
										 c=40 => le.version3.CALandUseCode,
										 c=41 => le.version3.CAAssessedValue,
										 c=42 => le.version3.CAOwnedBySubject,
										 c=43 => le.version3.CAFamilyOwned,
										 c=44 => le.version3.CAOccupantOwned,
										 c=45 => le.version3.CAAgeLastSale,
										 c=46 => le.version3.CALastSaleAmount,
										 c=47 => le.version3.CANotPrimaryRes,
										 c=48 => le.version3.CAPhoneListed,
										 c=49 => le.version3.CAPhoneNumber,
										 c=50 => le.version3.PAAgeOldestRecord,
										 c=51 => le.version3.PAAgeNewestRecord,
										 c=52 => le.version3.PALenOfRes,
										 c=53 => le.version3.PADwellType,
										 c=54 => le.version3.PALandUseCode,
										 c=55 => le.version3.PAAssessedValue,
										 c=56 => le.version3.PAOwnedBySubject,
										 c=57 => le.version3.PAFamilyOwned,
										 c=58 => le.version3.PAOccupantOwned,
										 c=59 => le.version3.PAAgeLastSale,
										 c=60 => le.version3.PALastSaleAmount,
										 c=61 => le.version3.PAPhoneListed,
										 c=62 => le.version3.PAPhoneNumber,
										 c=63 => le.version3.InputCurrMatch,
										 c=64 => le.version3.DistInputCurr,
										 c=65 => le.version3.DiffState,
										 c=66 => le.version3.AssessedDiff,
										 c=67 => le.version3.EcoTrajectory,
										 c=68 => le.version3.InputPrevMatch,
										 c=69 => le.version3.DistCurrPrev,
										 c=70 => le.version3.DiffState2,
										 c=71 => le.version3.AssessedDiff2,
										 c=72 => le.version3.EcoTrajectory2,
										 c=73 => (string)le.version3.mobility_indicator,
										 c=74 => le.version3.statusAddr,
										 c=75 => le.version3.statusAddr2,
										 c=76 => le.version3.statusAddr3,
										 c=77 => (string)le.version3.addrChanges30,
										 c=78 => (string)le.version3.AddrChanges90,
										 c=79 => (string)le.version3.AddrChanges180,
										 c=80 => (string)le.version3.AddrChanges12,
										 c=81 => (string)le.version3.AddrChanges24,
										 c=82 => (string)le.version3.AddrChanges36,
										 c=83 => (string)le.version3.AddrChanges60,
										 c=84 => (string)le.version3.property_owned_total,
										 c=85 => (string)le.version3.property_owned_assessed_total,
										 c=86 => (string)le.version3.property_historically_owned,
										 c=87 => le.version3.PropAgeOldestPurchase,
										 c=88 => le.version3.PropAgeNewestPurchase,
										 c=89 => le.version3.PropAgeNewestSale,
										 c=90 => (string)le.version3.numPurchase30,
										 c=91 => (string)le.version3.numPurchase90,
										 c=92 => (string)le.version3.numPurchase180,
										 c=93 => (string)le.version3.numPurchase12,
										 c=94 => (string)le.version3.numPurchase24,
										 c=95 => (string)le.version3.numPurchase36,
										 c=96 => (string)le.version3.numPurchase60,
										 c=97 => (string)le.version3.numSold30,
										 c=98 => (string)le.version3.numSold90,
										 c=99 => (string)le.version3.numSold180,
										 c=100 => (string)le.version3.numSold12,
										 c=101 => (string)le.version3.numSold24,
										 c=102 => (string)le.version3.numSold36,
										 c=103 => (string)le.version3.numSold60,
										 c=104 => (string)le.version3.NumWatercraft,
										 c=105 => (string)le.version3.NumWatercraft30,
										 c=106 => (string)le.version3.NumWatercraft90,
										 c=107 => (string)le.version3.NumWatercraft180,
										 c=108 => (string)le.version3.NumWatercraft12,
										 c=109 => (string)le.version3.NumWatercraft24,
										 c=110 => (string)le.version3.NumWatercraft36,
										 c=111 => (string)le.version3.NumWatercraft60,
										 c=112 => (string)le.version3.NumAircraft,
										 c=113 => (string)le.version3.NumAircraft30,
										 c=114 => (string)le.version3.NumAircraft90,
										 c=115 => (string)le.version3.NumAircraft180,
										 c=116 => (string)le.version3.NumAircraft12,
										 c=117 => (string)le.version3.NumAircraft24,
										 c=118 => (string)le.version3.NumAircraft36,
										 c=119 => (string)le.version3.NumAircraft60,
										 c=120 => le.version3.wealth_indicator,
										 c=121 => (string)le.version3.total_number_derogs,
										 c=122 => le.version3.DerogAge,
										 c=123 => (string)le.version3.felonies,
										 c=124 => le.version3.FelonyAge,
										 c=125 => (string)le.version3.Felonies30,
										 c=126 => (string)le.version3.Felonies90,
										 c=127 => (string)le.version3.Felonies180,
										 c=128 => (string)le.version3.Felonies12,
										 c=129 => (string)le.version3.Felonies24,
										 c=130 => (string)le.version3.Felonies36,
										 c=131 => (string)le.version3.Felonies60,
										 c=132 => (string)le.version3.num_liens,
										 c=133 => (string)le.version3.num_unreleased_liens,
										 c=134 => le.version3.LienFiledAge,
										 c=135 => (string)le.version3.num_unreleased_liens30,
										 c=136 => (string)le.version3.num_unreleased_liens90,
										 c=137 => (string)le.version3.num_unreleased_liens180,
										 c=138 => (string)le.version3.num_unreleased_liens12,
										 c=139 => (string)le.version3.num_unreleased_liens24,
										 c=140 => (string)le.version3.num_unreleased_liens36,
										 c=141 => (string)le.version3.num_unreleased_liens60,
										 c=142 => (string)le.version3.num_released_liens,
										 c=143 => le.version3.LienReleasedAge,
										 c=144 => (string)le.version3.num_released_liens30,
										 c=145 => (string)le.version3.num_released_liens90,
										 c=146 => (string)le.version3.num_released_liens180,
										 c=147 => (string)le.version3.num_released_liens12,
										 c=148 => (string)le.version3.num_released_liens24,
										 c=149 => (string)le.version3.num_released_liens36,
										 c=150 => (string)le.version3.num_released_liens60,
										 c=151 => (string)le.version3.bankruptcy_count,
										 c=152 => le.version3.BankruptcyAge,
										 c=153 => le.version3.filing_type,
										 c=154 => le.version3.disposition,
										 c=155 => (string)le.version3.bankruptcy_count30,
										 c=156 => (string)le.version3.bankruptcy_count90,
										 c=157 => (string)le.version3.bankruptcy_count180,
										 c=158 => (string)le.version3.bankruptcy_count12,
										 c=159 => (string)le.version3.bankruptcy_count24,
										 c=160 => (string)le.version3.bankruptcy_count36,
										 c=161 => (string)le.version3.bankruptcy_count60,
										 c=162 => (string)le.version3.eviction_count,
										 c=163 => le.version3.EvictionAge,
										 c=164 => (string)le.version3.eviction_count30,
										 c=165 => (string)le.version3.eviction_count90,
										 c=166 => (string)le.version3.eviction_count180,
										 c=167 => (string)le.version3.eviction_count12,
										 c=168 => (string)le.version3.eviction_count24,
										 c=169 => (string)le.version3.eviction_count36,
										 c=170 => (string)le.version3.eviction_count60,
										 c=171 => (string)le.version3.num_nonderogs,
										 c=172 => (string)le.version3.num_nonderogs30,
										 c=173 => (string)le.version3.num_nonderogs90,
										 c=174 => (string)le.version3.num_nonderogs180,
										 c=175 => (string)le.version3.num_nonderogs12,
										 c=176 => (string)le.version3.num_nonderogs24,
										 c=177 => (string)le.version3.num_nonderogs36,
										 c=178 => (string)le.version3.num_nonderogs60,
										 c=179 => (string)le.version3.num_proflic,
										 c=180 => le.version3.ProfLicAge,
										 c=181 => le.version3.proflic_type,
										 c=182 => le.version3.expire_date_last_proflic,
										 c=183 => (string)le.version3.num_proflic30,
										 c=184 => (string)le.version3.num_proflic90,
										 c=185 => (string)le.version3.num_proflic180,
										 c=186 => (string)le.version3.num_proflic12,
										 c=187 => (string)le.version3.num_proflic24,
										 c=188 => (string)le.version3.num_proflic36,
										 c=189 => (string)le.version3.num_proflic60,
										 c=190 => (string)le.version3.num_proflic_exp30,
										 c=191 => (string)le.version3.num_proflic_exp90,
										 c=192 => (string)le.version3.num_proflic_exp180,
										 c=193 => (string)le.version3.num_proflic_exp12,
										 c=194 => (string)le.version3.num_proflic_exp24,
										 c=195 => (string)le.version3.num_proflic_exp36,
										 c=196 => (string)le.version3.num_proflic_exp60,
										 c=197 => le.version3.AddrHighRisk,
										 c=198 => le.version3.PhoneHighRisk,
										 c=199 => le.version3.AddrPrison,
										 c=200 => le.version3.ZipPOBox,
										 c=201 => le.version3.ZipCorpMil,
										 c=202 => le.version3.phoneStatus,
										 c=203 => le.version3.PhonePager,
										 c=204 => le.version3.PhoneMobile,
										 c=205 => le.version3.PhoneZipMismatch,
										 c=206 => le.version3.phoneAddrDist,
										 c=207 => checkBoolean(le.version3.SecurityFreeze),
										 c=208 => checkBoolean(le.version3.SecurityAlert),
										 c=209 => checkBoolean(le.version3.IdTheftFlag),
										 c=210 => checkBoolean(le.version3.CorrectedFlag),

										 c=211 => le.version3.SSNNotFound,
										 c=212 => (string)le.version3.VerifiedName,
										 c=213 => (string)le.version3.VerifiedSSN,
										 c=214 => (string)le.version3.VerifiedPhone,
										 c=215 => (string)le.version3.VerifiedAddress,
										 c=216 => (string)le.version3.VerifiedDOB,
										 c=217 => le.version3.InferredMinimumAge,
										 c=218 => le.version3.BestReportedAge,
										 c=219 => (string)le.version3.SubjectSSNCount,
										 c=220 => (string)le.version3.SubjectAddrCount,
										 c=221 => (string)le.version3.SubjectPhoneCount,
										 c=222 => (string)le.version3.SubjectSSNRecentCount,
										 c=223 => (string)le.version3.SubjectAddrRecentCount,
										 c=224 => (string)le.version3.SubjectPhoneRecentCount,
										 c=225 => (string)le.version3.SSNIdentitiesCount,
										 c=226 => (string)le.version3.SSNAddrCount,
										 c=227 => (string)le.version3.SSNIdentitiesRecentCount,
										 c=228 => (string)le.version3.SSNAddrRecentCount,
										 c=229 => (string)le.version3.InputAddrIdentitiesCount,
										 c=230 => (string)le.version3.InputAddrSSNCount,
										 c=231 => (string)le.version3.InputAddrPhoneCount,
										 c=232 => (string)le.version3.InputAddrIdentitiesRecentCount,
										 c=233 => (string)le.version3.InputAddrSSNRecentCount,
										 c=234 => (string)le.version3.InputAddrPhoneRecentCount,
										 c=235 => (string)le.version3.PhoneIdentitiesCount,
										 c=236 => (string)le.version3.PhoneIdentitiesRecentCount,
										 c=237 => le.version3.SSNIssuedPriorDOB,
										 c=238 => le.version3.InputAddrTaxYr,
										 c=239 => (string)le.version3.InputAddrTaxMarketValue,
										 c=240 => (string)le.version3.InputAddrAVMTax,
										 c=241 => (string)le.version3.InputAddrAVMSalesPrice,
										 c=242 => (string)le.version3.InputAddrAVMHedonic,
										 c=243 => (string)le.version3.InputAddrAVMValue,
										 c=244 => (string)le.version3.InputAddrAVMConfidence,
										 c=245 => (string)le.version3.InputAddrCountyIndex,
										 c=246 => (string)le.version3.InputAddrTractIndex,
										 c=247 => (string)le.version3.InputAddrBlockIndex,
										 c=248 => le.version3.CurrAddrTaxYr,
										 c=249 => (string)le.version3.CurrAddrTaxMarketValue,
										 c=250 => (string)le.version3.CurrAddrAVMTax,
										 c=251 => (string)le.version3.CurrAddrAVMSalesPrice,
										 c=252 => (string)le.version3.CurrAddrAVMHedonic,
										 c=253 => (string)le.version3.CurrAddrAVMValue,
										 c=254 => (string)le.version3.CurrAddrAVMConfidence,
										 c=255 => (string)le.version3.CurrAddrCountyIndex,
										 c=256 => (string)le.version3.CurrAddrTractIndex,
										 c=257 => (string)le.version3.CurrAddrBlockIndex,
										 c=258 => le.version3.PrevAddrTaxYr,
										 c=259 => (string)le.version3.PrevAddrTaxMarketValue,
										 c=260 => (string)le.version3.PrevAddrAVMTax,
										 c=261 => (string)le.version3.PrevAddrAVMSalesPrice,
										 c=262 => (string)le.version3.PrevAddrAVMHedonic,
										 c=263 => (string)le.version3.PrevAddrAVMValue,
										 c=264 => (string)le.version3.PrevAddrAVMConfidence,
										 c=265 => (string)le.version3.PrevAddrCountyIndex,
										 c=266 => (string)le.version3.PrevAddrTractIndex,
										 c=267 => (string)le.version3.PrevAddrBlockIndex,
										 c=268 => le.version3.EducationAttendedCollege,
										 c=269 => le.version3.EducationProgram2Yr,
										 c=270 => le.version3.EducationProgram4Yr,
										 c=271 => le.version3.EducationProgramGraduate,
										 c=272 => le.version3.EducationInstitutionPrivate,
										 c=273 => le.version3.EducationInstitutionRating,
										 c=274 => le.version3.PredictedAnnualIncome,
										 c=275 => (string)le.version3.PropNewestSalePrice,
										 c=276 => (string)le.version3.PropNewestSalePurchaseIndex,
										 c=277 => (string)le.version3.SubPrimeSolicitedCount,
										 c=278 => (string)le.version3.SubPrimeSolicitedCount01,
										 c=279 => (string)le.version3.SubprimeSolicitedCount03,
										 c=280 => (string)le.version3.SubprimeSolicitedCount06,
										 c=281 => (string)le.version3.SubPrimeSolicitedCount12,
										 c=282 => (string)le.version3.SubPrimeSolicitedCount24,
										 c=283 => (string)le.version3.SubPrimeSolicitedCount36,
										 c=284 => (string)le.version3.SubPrimeSolicitedCount60,
										 c=285 => (string)le.version3.LienFederalTaxFiledTotal,
										 c=286 => (string)le.version3.LienTaxOtherFiledTotal,
										 c=287 => (string)le.version3.LienForeclosureFiledTotal,
										 c=288 => (string)le.version3.LienPreforeclosureFiledTotal,
										 c=289 => (string)le.version3.LienLandlordTenantFiledTotal,
										 c=290 => (string)le.version3.LienJudgmentFiledTotal,
										 c=291 => (string)le.version3.LienSmallClaimsFiledTotal,
										 c=292 => (string)le.version3.LienOtherFiledTotal,
										 c=293 => (string)le.version3.LienFederalTaxReleasedTotal,
										 c=294 => (string)le.version3.LienTaxOtherReleasedTotal,
										 c=295 => (string)le.version3.LienForeclosureReleasedTotal,
										 c=296 => (string)le.version3.LienPreforeclosureReleasedTotal,
										 c=297 => (string)le.version3.LienLandlordTenantReleasedTotal,
										 c=298 => (string)le.version3.LienJudgmentReleasedTotal,
										 c=299 => (string)le.version3.LienSmallClaimsReleasedTotal,
										 c=300 => (string)le.version3.LienOtherReleasedTotal,
										 c=301 => (string)le.version3.LienFederalTaxFiledCount,
										 c=302 => (string)le.version3.LienTaxOtherFiledCount,
										 c=303 => (string)le.version3.LienForeclosureFiledCount,
										 c=304 => (string)le.version3.LienPreforeclosureFiledCount,
										 c=305 => (string)le.version3.LienLandlordTenantFiledCount,
										 c=306 => (string)le.version3.LienJudgmentFiledCount,
										 c=307 => (string)le.version3.LienSmallClaimsFiledCount,
										 c=308 => (string)le.version3.LienOtherFiledCount,
										 c=309 => (string)le.version3.LienFederalTaxReleasedCount,
										 c=310 => (string)le.version3.LienTaxOtherReleasedCount,
										 c=311 => (string)le.version3.LienForeclosureReleasedCount,
										 c=312 => (string)le.version3.LienPreforeclosureReleasedCount,
										 c=313 => (string)le.version3.LienLandlordTenantReleasedCount,
										 c=314 => (string)le.version3.LienJudgmentReleasedCount,
										 c=315 => (string)le.version3.LienSmallClaimsReleasedCount,
										 c=316 => (string)le.version3.LienOtherReleasedCount,
										 c=317 => le.version3.ProfLicTypeCategory,
										 c=318 => le.version3.PhoneEDAAgeOldestRecord,
										 c=319 => le.version3.PhoneEDAAgeNewestRecord,
										 c=320 => le.version3.PhoneOtherAgeOldestRecord,
										 c=321 => le.version3.PhoneOtherAgeNewestRecord,
										 c=322 => le.version3.PrescreenOptOut,
										 c=323 => IF((INTEGER)zip_value > 0, le.version3.AddrAppendInputCurr, ''), // Only populate these if there was at least a ZIP code passed in
										 c=324 => IF((INTEGER)zip_value > 0, le.version3.AddrAppendStreetAddress, ''), // Only populate these if there was at least a ZIP code passed in
										 c=325 => IF((INTEGER)zip_value > 0, le.version3.AddrAppendCity, ''), // Only populate these if there was at least a ZIP code passed in
										 c=326 => IF((INTEGER)zip_value > 0, le.version3.AddrAppendState, ''), // Only populate these if there was at least a ZIP code passed in
										 c=327 => IF((INTEGER)zip_value > 0, le.version3.AddrAppendZip, ''), // Only populate these if there was at least a ZIP code passed in
															'');
	END;										 


	Models.Layout_Parameters intoVersion4(attributes le, integer c) := TRANSFORM
		self.name := map(	c=	1	=> 'AgeOldestRecord',
											c=	2	=> 'AgeNewestRecord',
											c=	3	=> 'RecentUpdate',
											c=	4	=> 'SrcsConfirmIDAddrCount',
											c=	5	=> 'InvalidDL',
											c=	6	=> 'VerificationFailure',
											c=	7	=> 'SSNNotFound',
											c=	8	=> 'VerifiedName',
											c=	9	=> 'VerifiedSSN',
											c=	10	=> 'VerifiedPhone',
											c=	11	=> 'VerifiedAddress',
											c=	12	=> 'VerifiedDOB',
											c=	13	=> 'InferredMinimumAge',
											c=	14	=> 'BestReportedAge',
											c=	15	=> 'SubjectSSNCount',
											c=	16	=> 'SubjectAddrCount',
											c=	17	=> 'SubjectPhoneCount',
											c=	18	=> 'SubjectSSNRecentCount',
											c=	19	=> 'SubjectAddrRecentCount',
											c=	20	=> 'SubjectPhoneRecentCount',
											c=	21	=> 'SSNIdentitiesCount',
											c=	22	=> 'SSNAddrCount',
											c=	23	=> 'SSNIdentitiesRecentCount',
											c=	24	=> 'SSNAddrRecentCount',
											c=	25	=> 'InputAddrPhoneCount',
											c=	26	=> 'InputAddrPhoneRecentCount',
											c=	27	=> 'PhoneIdentitiesCount',
											c=	28	=> 'PhoneIdentitiesRecentCount',
											c=	29	=> 'SSNAgeDeceased',
											c=	30	=> 'SSNRecent',
											c=	31	=> 'SSNLowIssueAge',
											c=	32	=> 'SSNHighIssueAge',
											c=	33	=> 'SSNIssueState',
											c=	34	=> 'SSNNonUS',
											c=	35	=> 'SSN3Years',
											c=	36	=> 'SSNAfter5',
											c=	37	=> 'SSNProblems',
											c=	38	=> 'InputAddrAgeOldestRecord',
											c=	39	=> 'InputAddrAgeNewestRecord',
											c=	40	=> 'InputAddrHistoricalMatch',
											c=	41	=> 'InputAddrLenOfRes',
											c=	42	=> 'InputAddrDwellType',
											c=	43	=> 'InputAddrDelivery',
											c=	44	=> 'InputAddrApplicantOwned',
											c=	45	=> 'InputAddrFamilyOwned',
											c=	46	=> 'InputAddrOccupantOwned',
											c=	47	=> 'InputAddrAgeLastSale',
											c=	48	=> 'InputAddrLastSalesPrice',
											c=	49	=> 'InputAddrMortgageType',
											c=	50	=> 'InputAddrNotPrimaryRes',
											c=	51	=> 'InputAddrActivePhoneList',
											c=	52	=> 'InputAddrTaxValue',
											c=	53	=> 'InputAddrTaxYr',
											c=	54	=> 'InputAddrTaxMarketValue',
											c=	55	=> 'InputAddrAVMValue',
											c=	56	=> 'InputAddrAVMValue12',
											c=	57	=> 'InputAddrAVMValue60',
											c=	58	=> 'InputAddrCountyIndex',
											c=	59	=> 'InputAddrTractIndex',
											c=	60	=> 'InputAddrBlockIndex',
											c=	61	=> 'CurrAddrAgeOldestRecord',
											c=	62	=> 'CurrAddrAgeNewestRecord',
											c=	63	=> 'CurrAddrLenOfRes',
											c=	64	=> 'CurrAddrDwellType',
											c=	65	=> 'CurrAddrApplicantOwned',
											c=	66	=> 'CurrAddrFamilyOwned',
											c=	67	=> 'CurrAddrOccupantOwned',
											c=	68	=> 'CurrAddrAgeLastSale',
											c=	69	=> 'CurrAddrLastSalesPrice',
											c=	70	=> 'CurrAddrMortgageType',
											c=	71	=> 'CurrAddrActivePhoneList',
											c=	72	=> 'CurrAddrTaxValue',
											c=	73	=> 'CurrAddrTaxYr',
											c=	74	=> 'CurrAddrTaxMarketValue',
											c=	75	=> 'CurrAddrAVMValue',
											c=	76	=> 'CurrAddrAVMValue12',
											c=	77	=> 'CurrAddrAVMValue60',
											c=	78	=> 'CurrAddrCountyIndex',
											c=	79	=> 'CurrAddrTractIndex',
											c=	80	=> 'CurrAddrBlockIndex',
											c=	81	=> 'PrevAddrAgeOldestRecord',
											c=	82	=> 'PrevAddrAgeNewestRecord',
											c=	83	=> 'PrevAddrLenOfRes',
											c=	84	=> 'PrevAddrDwellType',
											c=	85	=> 'PrevAddrApplicantOwned',
											c=	86	=> 'PrevAddrFamilyOwned',
											c=	87	=> 'PrevAddrOccupantOwned',
											c=	88	=> 'PrevAddrAgeLastSale',
											c=	89	=> 'PrevAddrLastSalesPrice',
											c=	90	=> 'PrevAddrTaxValue',
											c=	91	=> 'PrevAddrTaxYr',
											c=	92	=> 'PrevAddrTaxMarketValue',
											c=	93	=> 'PrevAddrAVMValue',
											c=	94	=> 'PrevAddrCountyIndex',
											c=	95	=> 'PrevAddrTractIndex',
											c=	96	=> 'PrevAddrBlockIndex',
											c=	97	=> 'AddrMostRecentDistance',
											c=	98	=> 'AddrMostRecentStateDiff',
											c=	99	=> 'AddrMostRecentTaxDiff',
											c=	100	=> 'AddrMostRecentMoveAge',
											c=	101	=> 'AddrRecentEconTrajectory',
											c=	102	=> 'AddrRecentEconTrajectoryIndex',
											c=	103	=> 'EducationAttendedCollege',
											c=	104	=> 'EducationProgram2Yr',
											c=	105	=> 'EducationProgram4Yr',
											c=	106	=> 'EducationProgramGraduate',
											c=	107	=> 'EducationInstitutionPrivate',
											c=	108	=> 'EducationFieldofStudyType',
											c=	109	=> 'EducationInstitutionRating',
											c=	110	=> 'AddrStability',
											c=	111	=> 'StatusMostRecent',
											c=	112	=> 'StatusPrevious',
											c=	113	=> 'StatusNextPrevious',
											c=	114	=> 'AddrChangeCount01',
											c=	115	=> 'AddrChangeCount03',
											c=	116	=> 'AddrChangeCount06',
											c=	117	=> 'AddrChangeCount12',
											c=	118	=> 'AddrChangeCount24',
											c=	119	=> 'AddrChangeCount60',
											c=	120	=> 'EstimatedAnnualIncome',
											c=	121	=> 'PropertyOwner',
											c=	122	=> 'PropOwnedCount',
											c=	123	=> 'PropOwnedTaxTotal',
											c=	124	=> 'PropOwnedHistoricalCount',
											c=	125	=> 'PropAgeOldestPurchase',
											c=	126	=> 'PropAgeNewestPurchase',
											c=	127	=> 'PropAgeNewestSale',
											c=	128	=> 'PropNewestSalePrice',
											c=	129	=> 'PropNewestSalePurchaseIndex',
											c=	130	=> 'PropPurchasedCount01',
											c=	131	=> 'PropPurchasedCount03',
											c=	132	=> 'PropPurchasedCount06',
											c=	133	=> 'PropPurchasedCount12',
											c=	134	=> 'PropPurchasedCount24',
											c=	135	=> 'PropPurchasedCount60',
											c=	136	=> 'PropSoldCount01',
											c=	137	=> 'PropSoldCount03',
											c=	138	=> 'PropSoldCount06',
											c=	139	=> 'PropSoldCount12',
											c=	140	=> 'PropSoldCount24',
											c=	141	=> 'PropSoldCount60',
											c=	142	=> 'AssetOwner',
											c=	143	=> 'WatercraftOwner',
											c=	144	=> 'WatercraftCount',
											c=	145	=> 'WatercraftCount01',
											c=	146	=> 'WatercraftCount03',
											c=	147	=> 'WatercraftCount06',
											c=	148	=> 'WatercraftCount12',
											c=	149	=> 'WatercraftCount24',
											c=	150	=> 'WatercraftCount60',
											c=	151	=> 'AircraftOwner',
											c=	152	=> 'AircraftCount',
											c=	153	=> 'AircraftCount01',
											c=	154	=> 'AircraftCount03',
											c=	155	=> 'AircraftCount06',
											c=	156	=> 'AircraftCount12',
											c=	157	=> 'AircraftCount24',
											c=	158	=> 'AircraftCount60',
											c=	159	=> 'WealthIndex',
											c=	160	=> 'BusinessActiveAssociation',
											c=	161	=> 'BusinessInactiveAssociation',
											c=	162	=> 'BusinessAssociationAge',
											c=	163	=> 'BusinessTitle',
											c=	164	=> 'DerogSeverityIndex',
											c=	165	=> 'DerogCount',
											c=	166	=> 'DerogRecentCount',
											c=	167	=> 'DerogAge',
											c=	168	=> 'FelonyCount',
											c=	169	=> 'FelonyAge',
											c=	170	=> 'FelonyCount01',
											c=	171	=> 'FelonyCount03',
											c=	172	=> 'FelonyCount06',
											c=	173	=> 'FelonyCount12',
											c=	174	=> 'FelonyCount24',
											c=	175	=> 'FelonyCount60',
											c=	176	=> 'LienCount',
											c=	177	=> 'LienFiledCount',
											c=	178	=> 'LienFiledAge',
											c=	179	=> 'LienFiledCount01',
											c=	180	=> 'LienFiledCount03',
											c=	181	=> 'LienFiledCount06',
											c=	182	=> 'LienFiledCount12',
											c=	183	=> 'LienFiledCount24',
											c=	184	=> 'LienFiledCount60',
											c=	185	=> 'LienReleasedCount',
											c=	186	=> 'LienReleasedAge',
											c=	187	=> 'LienReleasedCount01',
											c=	188	=> 'LienReleasedCount03',
											c=	189	=> 'LienReleasedCount06',
											c=	190	=> 'LienReleasedCount12',
											c=	191	=> 'LienReleasedCount24',
											c=	192	=> 'LienReleasedCount60',
											c=	193	=> 'LienFiledTotal',
											c=	194	=> 'LienFederalTaxFiledTotal',
											c=	195	=> 'LienTaxOtherFiledTotal',
											c=	196	=> 'LienForeclosureFiledTotal',
											c=	197	=> 'LienLandlordTenantFiledTotal',
											c=	198	=> 'LienJudgmentFiledTotal',
											c=	199	=> 'LienSmallClaimsFiledTotal',
											c=	200	=> 'LienOtherFiledTotal',
											c=	201	=> 'LienReleasedTotal',
											c=	202	=> 'LienFederalTaxReleasedTotal',
											c=	203	=> 'LienTaxOtherReleasedTotal',
											c=	204	=> 'LienForeclosureReleasedTotal',
											c=	205	=> 'LienLandlordTenantReleasedTotal',
											c=	206	=> 'LienJudgmentReleasedTotal',
											c=	207	=> 'LienSmallClaimsReleasedTotal',
											c=	208	=> 'LienOtherReleasedTotal',
											c=	209	=> 'LienFederalTaxFiledCount',
											c=	210	=> 'LienTaxOtherFiledCount',
											c=	211	=> 'LienForeclosureFiledCount',
											c=	212	=> 'LienLandlordTenantFiledCount',
											c=	213	=> 'LienJudgmentFiledCount',
											c=	214	=> 'LienSmallClaimsFiledCount',
											c=	215	=> 'LienOtherFiledCount',
											c=	216	=> 'LienFederalTaxReleasedCount',
											c=	217	=> 'LienTaxOtherReleasedCount',
											c=	218	=> 'LienForeclosureReleasedCount',
											c=	219	=> 'LienLandlordTenantReleasedCount',
											c=	220	=> 'LienJudgmentReleasedCount',
											c=	221	=> 'LienSmallClaimsReleasedCount',
											c=	222	=> 'LienOtherReleasedCount',
											c=	223	=> 'BankruptcyCount',
											c=	224	=> 'BankruptcyAge',
											c=	225	=> 'BankruptcyType',
											c=	226	=> 'BankruptcyStatus',
											c=	227	=> 'BankruptcyCount01',
											c=	228	=> 'BankruptcyCount03',
											c=	229	=> 'BankruptcyCount06',
											c=	230	=> 'BankruptcyCount12',
											c=	231	=> 'BankruptcyCount24',
											c=	232	=> 'BankruptcyCount60',
											c=	233	=> 'EvictionCount',
											c=	234	=> 'EvictionAge',
											c=	235	=> 'EvictionCount01',
											c=	236	=> 'EvictionCount03',
											c=	237	=> 'EvictionCount06',
											c=	238	=> 'EvictionCount12',
											c=	239	=> 'EvictionCount24',
											c=	240	=> 'EvictionCount60',
											c=	241	=> 'RecentActivityIndex',
											c=	242	=> 'NonDerogCount',
											c=	243	=> 'NonDerogCount01',
											c=	244	=> 'NonDerogCount03',
											c=	245	=> 'NonDerogCount06',
											c=	246	=> 'NonDerogCount12',
											c=	247	=> 'NonDerogCount24',
											c=	248	=> 'NonDerogCount60',
											c=	249	=> 'VoterRegistrationRecord',
											c=	250	=> 'ProfLicCount',
											c=	251	=> 'ProfLicAge',
											c=	252	=> 'ProfLicType',
											c=	253	=> 'ProfLicTypeCategory',
											c=	254	=> 'ProfLicExpired',
											c=	255	=> 'ProfLicCount01',
											c=	256	=> 'ProfLicCount03',
											c=	257	=> 'ProfLicCount06',
											c=	258	=> 'ProfLicCount12',
											c=	259	=> 'ProfLicCount24',
											c=	260	=> 'ProfLicCount60',
											c=	261	=> 'InquiryCollectionsRecent',
											c=	262	=> 'InquiryPersonalFinanceRecent',
											c=	263	=> 'InquiryOtherRecent',
											c=	264	=> 'HighRiskCreditActivity',
											c=	265	=> 'SubPrimeOfferRequestCount',
											c=	266	=> 'SubPrimeOfferRequestCount01',
											c=	267	=> 'SubPrimeOfferRequestCount03',
											c=	268	=> 'SubPrimeOfferRequestCount06',
											c=	269	=> 'SubPrimeOfferRequestCount12',
											c=	270	=> 'SubPrimeOfferRequestCount24',
											c=	271	=> 'SubPrimeOfferRequestCount60',
											c=	272	=> 'InputPhoneMobile',
											c=	273	=> 'PhoneEDAAgeOldestRecord',
											c=	274	=> 'PhoneEDAAgeNewestRecord',
											c=	275	=> 'PhoneOtherAgeOldestRecord',
											c=	276	=> 'PhoneOtherAgeNewestRecord',
											c=	277	=> 'InputPhoneHighRisk',
											c=	278	=> 'InputPhoneProblems',
											c=	279	=> 'EmailAddress',
											c=	280	=> 'InputAddrHighRisk',
											c=	281	=> 'CurrAddrCorrectional',
											c=	282	=> 'PrevAddrCorrectional',
											c=	283	=> 'HistoricalAddrCorrectional',
											c=	284	=> 'InputAddrProblems',
											c=	285	=> 'SecurityFreeze',
											c=	286	=> 'SecurityAlert',
											c=	287	=> 'IDTheftFlag',
											c=	288	=> 'ConsumerStatement',
											 'PrescreenOptOut');
		
		self.value := map(
											c < 289 and le.v4_PrescreenOptOut = '1' => '', // opt out applies, blank all return values except the PrescreenOptOut
											c <= 289 and c NOT IN IF(le.v4_ConsumerStatement='1', [285, 288], [285]) AND le.v4_SecurityFreeze='1'=> '', // Security Freeze Found - Mask all attributes except Security Freeze and consumer statement
											c <= 289 and c NOT IN IF(le.v4_SecurityFreeze='1', [285, 288], [288]) AND le.v4_ConsumerStatement='1'=> '', // Consumer Statement Found - Mask all attributes except Consumer Statement and security freeze
										  c <= 289 and c <> 6 and ExperianTransaction and le.v4_VerificationFailure='1' => '',  // blank out all attributes for Experian transactions if VerificationFailure
											
											c=	1	=> le.v4_AgeOldestRecord	,
											c=	2	=> le.v4_AgeNewestRecord	,
											c=	3	=> le.v4_RecentUpdate	,
											c=	4	=> le.v4_SrcsConfirmIDAddrCount	,
											c=	5	=> le.v4_InvalidDL	,
											c=	6	=> le.v4_VerificationFailure	,
											c=	7	=> le.v4_SSNNotFound	,
											c=	8	=> le.v4_VerifiedName	,
											c=	9	=> le.v4_VerifiedSSN	,
											c=	10	=> le.v4_VerifiedPhone	,
											c=	11	=> le.v4_VerifiedAddress	,
											c=	12	=> le.v4_VerifiedDOB	,
											c=	13	=> le.v4_InferredMinimumAge	,
											c=	14	=> le.v4_BestReportedAge	,
											c=	15	=> le.v4_SubjectSSNCount	,
											c=	16	=> le.v4_SubjectAddrCount	,
											c=	17	=> le.v4_SubjectPhoneCount	,
											c=	18	=> le.v4_SubjectSSNRecentCount	,
											c=	19	=> le.v4_SubjectAddrRecentCount	,
											c=	20	=> le.v4_SubjectPhoneRecentCount	,
											c=	21	=> le.v4_SSNIdentitiesCount	,
											c=	22	=> le.v4_SSNAddrCount	,
											c=	23	=> le.v4_SSNIdentitiesRecentCount	,
											c=	24	=> le.v4_SSNAddrRecentCount	,
											c=	25	=> le.v4_InputAddrPhoneCount	,
											c=	26	=> le.v4_InputAddrPhoneRecentCount	,
											c=	27	=> le.v4_PhoneIdentitiesCount	,
											c=	28	=> le.v4_PhoneIdentitiesRecentCount	,
											c=	29	=> le.v4_SSNAgeDeceased	,
											c=	30	=> le.v4_SSNRecent	,
											c=	31	=> le.v4_SSNLowIssueAge	,
											c=	32	=> le.v4_SSNHighIssueAge	,
											c=	33	=> le.v4_SSNIssueState	,
											c=	34	=> le.v4_SSNNonUS	,
											c=	35	=> le.v4_SSN3Years	,
											c=	36	=> le.v4_SSNAfter5 	,
											c=	37	=> le.v4_SSNProblems	,
											c=	38	=> le.v4_InputAddrAgeOldestRecord	,
											c=	39	=> le.v4_InputAddrAgeNewestRecord	,
											c=	40	=> le.v4_InputAddrHistoricalMatch	,
											c=	41	=> le.v4_InputAddrLenOfRes 	,
											c=	42	=> le.v4_InputAddrDwellType 	,
											c=	43	=> le.v4_InputAddrDelivery	,
											c=	44	=> le.v4_InputAddrApplicantOwned	,
											c=	45	=> le.v4_InputAddrFamilyOwned	,
											c=	46	=> le.v4_InputAddrOccupantOwned 	,
											c=	47	=> le.v4_InputAddrAgeLastSale	,
											c=	48	=> le.v4_InputAddrLastSalesPrice	,
											c=	49	=> le.v4_InputAddrMortgageType	,
											c=	50	=> le.v4_InputAddrNotPrimaryRes 	,
											c=	51	=> le.v4_InputAddrActivePhoneList 	,
											c=	52	=> le.v4_InputAddrTaxValue 	,
											c=	53	=> le.v4_InputAddrTaxYr	,
											c=	54	=> le.v4_InputAddrTaxMarketValue	,
											c=	55	=> le.v4_InputAddrAVMValue	,
											c=	56	=> le.v4_InputAddrAVMValue12	,
											c=	57	=> le.v4_InputAddrAVMValue60	,
											c=	58	=> le.v4_InputAddrCountyIndex	,
											c=	59	=> le.v4_InputAddrTractIndex	,
											c=	60	=> le.v4_InputAddrBlockIndex	,
											c=	61	=> le.v4_CurrAddrAgeOldestRecord	,
											c=	62	=> le.v4_CurrAddrAgeNewestRecord	,
											c=	63	=> le.v4_CurrAddrLenOfRes 	,
											c=	64	=> le.v4_CurrAddrDwellType 	,
											c=	65	=> le.v4_CurrAddrApplicantOwned 	,
											c=	66	=> le.v4_CurrAddrFamilyOwned 	,
											c=	67	=> le.v4_CurrAddrOccupantOwned 	,
											c=	68	=> le.v4_CurrAddrAgeLastSale	,
											c=	69	=> le.v4_CurrAddrLastSalesPrice	,
											c=	70	=> le.v4_CurrAddrMortgageType	,
											c=	71	=> le.v4_CurrAddrActivePhoneList 	,
											c=	72	=> le.v4_CurrAddrTaxValue 	,
											c=	73	=> le.v4_CurrAddrTaxYr	,
											c=	74	=> le.v4_CurrAddrTaxMarketValue	,
											c=	75	=> le.v4_CurrAddrAVMValue	,
											c=	76	=> le.v4_CurrAddrAVMValue12	,
											c=	77	=> le.v4_CurrAddrAVMValue60	,
											c=	78	=> le.v4_CurrAddrCountyIndex	,
											c=	79	=> le.v4_CurrAddrTractIndex	,
											c=	80	=> le.v4_CurrAddrBlockIndex	,
											c=	81	=> le.v4_PrevAddrAgeOldestRecord	,
											c=	82	=> le.v4_PrevAddrAgeNewestRecord	,
											c=	83	=> le.v4_PrevAddrLenOfRes 	,
											c=	84	=> le.v4_PrevAddrDwellType 	,
											c=	85	=> le.v4_PrevAddrApplicantOwned 	,
											c=	86	=> le.v4_PrevAddrFamilyOwned 	,
											c=	87	=> le.v4_PrevAddrOccupantOwned	,
											c=	88	=> le.v4_PrevAddrAgeLastSale	,
											c=	89	=> le.v4_PrevAddrLastSalesPrice	,
											c=	90	=> le.v4_PrevAddrTaxValue	,
											c=	91	=> le.v4_PrevAddrTaxYr	,
											c=	92	=> le.v4_PrevAddrTaxMarketValue	,
											c=	93	=> le.v4_PrevAddrAVMValue	,
											c=	94	=> le.v4_PrevAddrCountyIndex	,
											c=	95	=> le.v4_PrevAddrTractIndex	,
											c=	96	=> le.v4_PrevAddrBlockIndex	,
											c=	97	=> le.v4_AddrMostRecentDistance	,
											c=	98	=> le.v4_AddrMostRecentStateDiff	,
											c=	99	=> le.v4_AddrMostRecentTaxDiff	,
											c=	100	=> le.v4_AddrMostRecentMoveAge	,
											c=	101	=> le.v4_AddrRecentEconTrajectory	,
											c=	102	=> le.v4_AddrRecentEconTrajectoryIndex	,
											c=	103	=> le.v4_EducationAttendedCollege	,
											c=	104	=> le.v4_EducationProgram2Yr	,
											c=	105	=> le.v4_EducationProgram4Yr	,
											c=	106	=> le.v4_EducationProgramGraduate	,
											c=	107	=> le.v4_EducationInstitutionPrivate	,
											c=	108	=> le.v4_EducationFieldofStudyType	,
											c=	109	=> le.v4_EducationInstitutionRating	,
											c=	110	=> le.v4_AddrStability 	,
											c=	111	=> le.v4_StatusMostRecent 	,
											c=	112	=> le.v4_StatusPrevious 	,
											c=	113	=> le.v4_StatusNextPrevious	,
											c=	114	=> le.v4_AddrChangeCount01	,
											c=	115	=> le.v4_AddrChangeCount03	,
											c=	116	=> le.v4_AddrChangeCount06	,
											c=	117	=> le.v4_AddrChangeCount12	,
											c=	118	=> le.v4_AddrChangeCount24 	,
											c=	119	=> le.v4_AddrChangeCount60 	,
											c=	120	=> le.v4_EstimatedAnnualIncome	,
											c=	121	=> le.v4_PropertyOwner	,
											c=	122	=> le.v4_PropOwnedCount	,
											c=	123	=> le.v4_PropOwnedTaxTotal	,
											c=	124	=> le.v4_PropOwnedHistoricalCount	,
											c=	125	=> le.v4_PropAgeOldestPurchase	,
											c=	126	=> le.v4_PropAgeNewestPurchase	,
											c=	127	=> le.v4_PropAgeNewestSale	,
											c=	128	=> le.v4_PropNewestSalePrice	,
											c=	129	=> le.v4_PropNewestSalePurchaseIndex	,
											c=	130	=> le.v4_PropPurchasedCount01	,
											c=	131	=> le.v4_PropPurchasedCount03	,
											c=	132	=> le.v4_PropPurchasedCount06	,
											c=	133	=> le.v4_PropPurchasedCount12	,
											c=	134	=> le.v4_PropPurchasedCount24	,
											c=	135	=> le.v4_PropPurchasedCount60	,
											c=	136	=> le.v4_PropSoldCount01	,
											c=	137	=> le.v4_PropSoldCount03	,
											c=	138	=> le.v4_PropSoldCount06	,
											c=	139	=> le.v4_PropSoldCount12	,
											c=	140	=> le.v4_PropSoldCount24 	,
											c=	141	=> le.v4_PropSoldCount60 	,
											c=	142	=> le.v4_AssetOwner	,
											c=	143	=> le.v4_WatercraftOwner	,
											c=	144	=> le.v4_WatercraftCount	,
											c=	145	=> le.v4_WatercraftCount01	,
											c=	146	=> le.v4_WatercraftCount03	,
											c=	147	=> le.v4_WatercraftCount06	,
											c=	148	=> le.v4_WatercraftCount12 	,
											c=	149	=> le.v4_WatercraftCount24	,
											c=	150	=> le.v4_WatercraftCount60 	,
											c=	151	=> le.v4_AircraftOwner	,
											c=	152	=> le.v4_AircraftCount	,
											c=	153	=> le.v4_AircraftCount01	,
											c=	154	=> le.v4_AircraftCount03	,
											c=	155	=> le.v4_AircraftCount06	,
											c=	156	=> le.v4_AircraftCount12 	,
											c=	157	=> le.v4_AircraftCount24	,
											c=	158	=> le.v4_AircraftCount60 	,
											c=	159	=> le.v4_WealthIndex 	,
											c=	160	=> le.v4_BusinessActiveAssociation	,
											c=	161	=> le.v4_BusinessInactiveAssociation	,
											c=	162	=> le.v4_BusinessAssociationAge	,
											c=	163	=> le.v4_BusinessTitle	,
											c=	164	=> le.v4_DerogSeverityIndex	,
											c=	165	=> le.v4_DerogCount	,
											c=	166	=> le.v4_DerogRecentCount	,
											c=	167	=> le.v4_DerogAge	,
											c=	168	=> le.v4_FelonyCount	,
											c=	169	=> le.v4_FelonyAge	,
											c=	170	=> le.v4_FelonyCount01	,
											c=	171	=> le.v4_FelonyCount03	,
											c=	172	=> le.v4_FelonyCount06	,
											c=	173	=> le.v4_FelonyCount12	,
											c=	174	=> le.v4_FelonyCount24	,
											c=	175	=> le.v4_FelonyCount60	,
											c=	176	=> le.v4_LienCount	,
											c=	177	=> le.v4_LienFiledCount	,
											c=	178	=> le.v4_LienFiledAge	,
											c=	179	=> le.v4_LienFiledCount01	,
											c=	180	=> le.v4_LienFiledCount03	,
											c=	181	=> le.v4_LienFiledCount06	,
											c=	182	=> le.v4_LienFiledCount12	,
											c=	183	=> le.v4_LienFiledCount24	,
											c=	184	=> le.v4_LienFiledCount60	,
											c=	185	=> le.v4_LienReleasedCount	,
											c=	186	=> le.v4_LienReleasedAge	,
											c=	187	=> le.v4_LienReleasedCount01	,
											c=	188	=> le.v4_LienReleasedCount03	,
											c=	189	=> le.v4_LienReleasedCount06	,
											c=	190	=> le.v4_LienReleasedCount12	,
											c=	191	=> le.v4_LienReleasedCount24	,
											c=	192	=> le.v4_LienReleasedCount60	,
											c=	193	=> le.v4_LienFiledTotal	,
											c=	194	=> le.v4_LienFederalTaxFiledTotal	,
											c=	195	=> le.v4_LienTaxOtherFiledTotal	,
											c=	196	=> le.v4_LienForeclosureFiledTotal	,
											c=	197	=> le.v4_LienLandlordTenantFiledTotal	,
											c=	198	=> le.v4_LienJudgmentFiledTotal	,
											c=	199	=> le.v4_LienSmallClaimsFiledTotal	,
											c=	200	=> le.v4_LienOtherFiledTotal	,
											c=	201	=> le.v4_LienReleasedTotal	,
											c=	202	=> le.v4_LienFederalTaxReleasedTotal	,
											c=	203	=> le.v4_LienTaxOtherReleasedTotal	,
											c=	204	=> le.v4_LienForeclosureReleasedTotal	,
											c=	205	=> le.v4_LienLandlordTenantReleasedTotal	,
											c=	206	=> le.v4_LienJudgmentReleasedTotal	,
											c=	207	=> le.v4_LienSmallClaimsReleasedTotal	,
											c=	208	=> le.v4_LienOtherReleasedTotal	,
											c=	209	=> le.v4_LienFederalTaxFiledCount	,
											c=	210	=> le.v4_LienTaxOtherFiledCount	,
											c=	211	=> le.v4_LienForeclosureFiledCount	,
											c=	212	=> le.v4_LienLandlordTenantFiledCount	,
											c=	213	=> le.v4_LienJudgmentFiledCount	,
											c=	214	=> le.v4_LienSmallClaimsFiledCount	,
											c=	215	=> le.v4_LienOtherFiledCount	,
											c=	216	=> le.v4_LienFederalTaxReleasedCount	,
											c=	217	=> le.v4_LienTaxOtherReleasedCount	,
											c=	218	=> le.v4_LienForeclosureReleasedCount	,
											c=	219	=> le.v4_LienLandlordTenantReleasedCount	,
											c=	220	=> le.v4_LienJudgmentReleasedCount	,
											c=	221	=> le.v4_LienSmallClaimsReleasedCount	,
											c=	222	=> le.v4_LienOtherReleasedCount	,
											c=	223	=> le.v4_BankruptcyCount	,
											c=	224	=> le.v4_BankruptcyAge	,
											c=	225	=> le.v4_BankruptcyType	,
											c=	226	=> le.v4_BankruptcyStatus	,
											c=	227	=> le.v4_BankruptcyCount01	,
											c=	228	=> le.v4_BankruptcyCount03	,
											c=	229	=> le.v4_BankruptcyCount06	,
											c=	230	=> le.v4_BankruptcyCount12	,
											c=	231	=> le.v4_BankruptcyCount24	,
											c=	232	=> le.v4_BankruptcyCount60	,
											c=	233	=> le.v4_EvictionCount	,
											c=	234	=> le.v4_EvictionAge	,
											c=	235	=> le.v4_EvictionCount01	,
											c=	236	=> le.v4_EvictionCount03	,
											c=	237	=> le.v4_EvictionCount06	,
											c=	238	=> le.v4_EvictionCount12 	,
											c=	239	=> le.v4_EvictionCount24 	,
											c=	240	=> le.v4_EvictionCount60 	,
											c=	241	=> le.v4_RecentActivityIndex	,
											c=	242	=> le.v4_NonDerogCount	,
											c=	243	=> le.v4_NonDerogCount01	,
											c=	244	=> le.v4_NonDerogCount03	,
											c=	245	=> le.v4_NonDerogCount06	,
											c=	246	=> le.v4_NonDerogCount12	,
											c=	247	=> le.v4_NonDerogCount24	,
											c=	248	=> le.v4_NonDerogCount60	,
											c=	249	=> le.v4_VoterRegistrationRecord	,
											c=	250	=> le.v4_ProfLicCount	,
											c=	251	=> le.v4_ProfLicAge	,
											c=	252	=> le.v4_ProfLicType	,
											c=	253	=> le.v4_ProfLicTypeCategory	,
											c=	254	=> le.v4_ProfLicExpired	,
											c=	255	=> le.v4_ProfLicCount01	,
											c=	256	=> le.v4_ProfLicCount03	,
											c=	257	=> le.v4_ProfLicCount06	,
											c=	258	=> le.v4_ProfLicCount12	,
											c=	259	=> le.v4_ProfLicCount24	,
											c=	260	=> le.v4_ProfLicCount60	,
											c=	261	=> le.v4_InquiryCollectionsRecent	,
											c=	262	=> le.v4_InquiryPersonalFinanceRecent	,
											c=	263	=> le.v4_InquiryOtherRecent	,
											c=	264	=> le.v4_HighRiskCreditActivity	,
											c=	265	=> le.v4_SubPrimeOfferRequestCount	,
											c=	266	=> le.v4_SubPrimeOfferRequestCount01	,
											c=	267	=> le.v4_SubPrimeOfferRequestCount03	,
											c=	268	=> le.v4_SubPrimeOfferRequestCount06	,
											c=	269	=> le.v4_SubPrimeOfferRequestCount12	,
											c=	270	=> le.v4_SubPrimeOfferRequestCount24	,
											c=	271	=> le.v4_SubPrimeOfferRequestCount60	,
											c=	272	=> le.v4_InputPhoneMobile 	,
											c=	273	=> le.v4_PhoneEDAAgeOldestRecord	,
											c=	274	=> le.v4_PhoneEDAAgeNewestRecord	,
											c=	275	=> le.v4_PhoneOtherAgeOldestRecord	,
											c=	276	=> le.v4_PhoneOtherAgeNewestRecord	,
											c=	277	=> le.v4_InputPhoneHighRisk	,
											c=	278	=> le.v4_InputPhoneProblems	,
											c=	279	=> le.v4_EmailAddress	,
											c=	280	=> le.v4_InputAddrHighRisk	,
											c=	281	=> le.v4_CurrAddrCorrectional	,
											c=	282	=> le.v4_PrevAddrCorrectional	,
											c=	283	=> le.v4_HistoricalAddrCorrectional	,
											c=	284	=> le.v4_InputAddrProblems	,
											c=	285	=> le.v4_SecurityFreeze	,
											c=	286	=> le.v4_SecurityAlert	,
											c=	287	=> le.v4_IDTheftFlag	,
											c=	288	=> le.v4_ConsumerStatement	,
											le.v4_PrescreenOptOut);						 
	end;
	
	Layout_Attribute formLife(attributes le, integer c) := transform
		self.attribute := project(le, intoLife(left, c));
	END;
	Layout_Attribute formDem(attributes le, integer c) := transform
		self.attribute := project(le, intoDem(left, c));
	END;
	Layout_Attribute formFin(attributes le, integer c) := transform
		self.attribute := project(le, intoFin(left, c));
	END;
	Layout_Attribute formProp(attributes le, integer c) := transform
		self.attribute := project(le, intoProp(left, c));
	END;
	Layout_Attribute formDerog(attributes le, integer c) := transform
		self.attribute := project(le, intoDerog(left, c));
	END;
	Layout_Attribute formVersion2(attributes le, integer c) := transform
		self.attribute := project(le, intoVersion2(left, c));
	END;



	layout_AttributeGroup formAttributes(attributes le) := transform
		self.name := 'Lifestyle';
		self.index := if(doLifestyle, '0', '');
		self.Attributes := project(le, formLife(left,1)) + project(le, formLife(left,2)) + project(le, formLife(left,3)) + 
											 project(le, formLife(left,4)) + project(le, formLife(left,5)) + project(le, formLife(left,6)) + 
											 project(le, formLife(left,7)) + project(le, formLife(left,8)) + project(le, formLife(left,9)) + 
											 project(le, formLife(left,10)) + project(le, formLife(left,11)) + project(le, formLife(left,12));
	END;
	layout_AttributeGroup formAttributes2(attributes le) := transform
		self.name := 'Demographic';
		self.index := if(doDemographic, '1', '');
		self.Attributes := project(le, formDem(left,1)) + project(le, formDem(left,2)) + project(le, formDem(left,3)) + 
											 project(le, formDem(left,4)) + project(le, formDem(left,5)) + project(le, formDem(left,6));
	END;
	layout_AttributeGroup formAttributes3(attributes le) := TRANSFORM
		self.name := 'Financial';
		self.index := if(doFinancial, '2', '');
		self.Attributes := project(le, formFin(left,1)) + project(le, formFin(left,2)) + project(le, formFin(left,3));
	END;
	layout_AttributeGroup formAttributes4(attributes le) := TRANSFORM
		self.name := 'Property';
		self.index := if(doProperty, '3', '');
		self.Attributes := project(le, formProp(left,1)) + project(le, formProp(left,2)) + project(le, formProp(left,3));
	END;
	layout_AttributeGroup formAttributes5(attributes le) := TRANSFORM
		self.name := 'Derogatory';
		self.index := if(doDerog, '4', '');
		self.Attributes := project(le, formDerog(left,1)) + project(le, formDerog(left,2)) + project(le, formDerog(left,3)) +
											 project(le, formDerog(left,4)) + project(le, formDerog(left,5)) + project(le, formDerog(left,6)) + 
											 project(le, formDerog(left,7));
	END;

	// version 2 special
	name_pairs2 :=  normalize(attributes, 215, intoVersion2(left, counter));
	v2 := project(name_pairs2, transform(layout_attribute, self.attribute := left));

	layout_AttributeGroup formAttributes6(attributes le) := TRANSFORM
		self.name := 'Version2';
		self.index := if(doVersion2, '5', '');
		self.Attributes := ungroup(v2);
	END;

	// version 3 special
	// Only return the Address Append attributes at the end of the layout if the Address Append functionality is turned on - otherwise continue to function as it always has
	name_pairs3 :=  normalize(attributes, IF(DoAddressAppend = FALSE, 322, 327), intoVersion3(left, counter));
	v3 := project(name_pairs3, transform(layout_attribute, self.attribute := left));

	layout_AttributeGroup formAttributes7(attributes le) := TRANSFORM
		self.name := 'Version3';
		self.index := if(doVersion3, '6', '');
		self.Attributes := ungroup(v3);
	END;

	// version 4 variety
	name_pairs4 :=  normalize(attributes, 289, intoVersion4(left, counter));
	v4 := project(name_pairs4, transform(layout_attribute, self.attribute := left));

	layout_AttributeGroup formV4_attributes(attributes le) := TRANSFORM
		self.name := 'Version4';
		self.index := if(doVersion4, '7', '');
		self.Attributes := ungroup(v4);
	END;
	
	layout_RVAttributesOut formAttributeGroup(attributes le) := transform
		self.AccountNumber := if(doLifestyle or doDemographic or doFinancial or doProperty or doDerog or doVersion2 or doVersion3 or doVersion4, le.accountnumber, skip);
		dsAttributes := if(doLifestyle, project(le, formAttributes(left))) + 
										if(doDemographic, project(le, formAttributes2(left))) + 
										if(doFinancial, project(le, formAttributes3(left))) +
										if(doProperty, project(le, formAttributes4(left))) + 
										if(doDerog, project(le, formAttributes5(left))) +
										if(doVersion2, project(le, formAttributes6(left))) +
										if(doVersion3, project(le, formAttributes7(left))) +
										if(doVersion4, project(le, formV4_attributes(left)));
										
		self.AttributeGroup := dsAttributes(name <> '');											 
	END;
	attributeout := project(attributes, formAttributeGroup(left));

	Layout_RiskView := RECORD, maxlength(100000)
		STRING30 AccountNumber;
		unsigned6 did := 0;
		DATASET(Layout_Echo_In) InputEcho;
		DATASET(Models.Layout_Model) models;
		Layout_RVAttributesOut AttributeGroups;
		dataset(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements {xpath('ConsumerStatements/ConsumerStatement'), MAXCOUNT(iesp.Constants.MAX_CONSUMER_STATEMENTS)};
    iesp.share_fcra.t_FcraConsumer Consumer {xpath('Consumer')};//hidden[ecl_only]  // this is for FFD-523 to be compatible with all other public records fcra queries, even though it's redundant to the inputEcho section
  END;


	Models.Layout_Parameters CAParamsBlankout( Models.Layout_Parameters le ) := TRANSFORM
		self.name := le.name;
		self.value := '';
	END;
	Layout_Attribute CAAttributeBlankout( Layout_Attribute le ) := TRANSFORM
		self.Attribute := project( le.attribute, CAParamsBlankout(left) );
	END;
	Layout_AttributeGroup CAAttributeGroupBlankout( Layout_AttributeGroup le ) := TRANSFORM
		self.Attributes := project( le.Attributes, CAAttributeBlankout(left) );
		self := le;
	END;
//don't clear out the testseed results if they run inPersonApplication or CA records
	inCalif := ~Test_Data_Enabled and isCalifornia and (
		(integer)(boolean)clam_to_run[1].iid.combo_firstcount+(integer)(boolean)clam_to_run[1].iid.combo_lastcount
		+(integer)(boolean)clam_to_run[1].iid.combo_addrcount+(integer)(boolean)clam_to_run[1].iid.combo_hphonecount
		+(integer)(boolean)clam_to_run[1].iid.combo_ssncount+(integer)(boolean)clam_to_run[1].iid.combo_dobcount) < 3;

	Layout_Riskview putTogether(scores le, attributeout ri) := TRANSFORM
		self.AccountNumber := if(le.AccountNumber<>'', le.AccountNumber, ri.AccountNumber);
		self.did := clam_to_run[1].did;
		self.InputEcho := echo_in;										
		self.models := le.models;

    // for inquiry logging, populate the consumer section with the DID and input fields
    // if the person is a noScore, don't log the DID
    self.Consumer.LexID := if(riskview.constants.noscore(clam_to_run[1].iid.nas_summary,clam_to_run[1].iid.nap_summary, clam_to_run[1].address_verification.input_address_information.naprop, clam_to_run[1].truedid), 
        '', 
        (string12)clam_to_run[1].did); 
    
    searchDOB := echo_in[1].dateofbirth;
    SELF.Consumer.Inquiry.DOB := IF((UNSIGNED)searchDOB > 0, searchDOB, '');
    self.Consumer.Inquiry.Phone10 := echo_in[1].HomePhone;
    self.Consumer.Inquiry.name.Full := echo_in[1].unparsedfullname;
    self.Consumer.Inquiry.name.First := echo_in[1].firstname;
    self.Consumer.Inquiry.name.Middle := echo_in[1].middlename;
    self.Consumer.Inquiry.name.Last := echo_in[1].lastname;
    self.Consumer.Inquiry.name.Suffix := echo_in[1].namesuffix;
    self.Consumer.Inquiry.address.streetaddress1 := echo_in[1].streetaddress;
    self.Consumer.Inquiry.address.city := echo_in[1].city;
    self.Consumer.Inquiry.address.state := echo_in[1].state;
    self.Consumer.Inquiry.address.zip5 := echo_in[1].zip;
    self.Consumer.Inquiry.UniqueID := (string)clam_to_run[1].did;    
    self.Consumer.Inquiry := echo_in[1];  
        
		self.AttributeGroups.AccountNumber := ri.AccountNumber;
		self.AttributeGroups.AttributeGroup := if( inCalif, project( ri.AttributeGroup, CAAttributeGroupBlankout(left) ), ri.AttributeGroup );
		self := [];
	END;
	final1 := join(scores, attributeout, left.AccountNumber = right.AccountNumber, putTogether(left,right), full outer);
	

	final := join(clam_to_run, final1, left.did=right.did,
								transform(Layout_Riskview, 
									self.ConsumerStatements := if(OutputConsumerStatements, 
										project(left.ConsumerStatements, transform(
												iesp.share_fcra.t_ConsumerStatement, self.dataGroup := '', self := left)));
									self := right,
									self := []), KEEP(1), ATMOST(100));
#end

// adl_clam_model := custom_model_name in ['rvp1003_0','rvp1104_0','rvc1112_0', 'rvc1210_1'];

	// output(model_url, named('model_url'));
	// output(model_params, named('model_params'));
	// output(custom_model_name, named('custom_model_name'));
	// output(adl_clam_model, named('adl_clam_model'));
	// output(adl_clam, named('adl_clam'));
	// output(clam, named('clam'));
	// output(with_personContext, named('with_personContext'));
	
export RiskView_Records := final;
