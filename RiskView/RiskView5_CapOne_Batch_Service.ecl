/*--SOAP--
<message name="RiskView RiskView5_CapOne_Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="Bankcard_model_name" type="xsd:string"/>
	<part name="prescreen_score_threshold" type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="FFDOptionsMask"      type="xsd:string"/>
</message>
*/
/*--INFO-- Contains RiskView Scores and attributes version 5.0 and higher */

//You'll need to check on the items included in Rich's email 9.20.16...
import iesp, gateway, risk_indicators, UT, riskview, address, riskwise, Risk_Reporting, Consumerstatement, Models, aid_build;


export RiskView5_CapOne_Batch_Service := MACRO

		//Input declarations...
		#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);
		batchin := dataset([],Models.layouts.Layout_CapOneRV5_Batch_In) 		: stored('batch_in',few);	
		string    DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
		string50  DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
		string    Bankcard_model_name := '' 						: stored('Bankcard_model_name');
		string    prescreen_score_threshold := '' 			: stored('prescreen_score_threshold');

		//Don't allow Targus Gateway
		gateways_in := Gateway.Configuration.Get();
		Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
			SELF.servicename := le.servicename;
			SELF.url := IF(le.servicename IN ['targus'], '', le.url); //Don't allow Targus Gateway
			SELF := le;
		END;
		gateways := PROJECT(gateways_in, gw_switch(LEFT));

		//Query specific hard-coded options (eliminated from pass in) ::
		string  AttributesVersionRequest := 'riskviewattrv5';
		boolean isCalifornia_in_person := FALSE;
		string  caller := riskview.constants.batch;
		boolean RiskviewReportRequest := riskview.constants.no_riskview_report;
		string6	SSNMask := '';
		string6 DOBMask := '';
		boolean	DLMask := FALSE;
		string 		intended_purpose := 'PRESCREENING';
		boolean   isPreScreenPurpose := TRUE;//StringLib.StringToUpperCase(intended_purpose) = 'PRESCREENING';
		boolean   isCollectionsPurpose := FALSE;//StringLib.StringToUpperCase(intended_purpose) = 'COLLECTIONS';
		boolean   isDirectToConsumerPurpose := FALSE;//StringLib.StringToUpperCase(intended_purpose) = Constants.directToConsumer;

		STRING  strFFDOptionsMask_in	 :=  '0' : STORED('FFDOptionsMask');
		boolean OutputConsumerStatements := strFFDOptionsMask_in[1] = '1';	

		//You'll need to populate seqCounter before formatting layout input, as acctNo is dropped in the transform below,
		//		but why not use acctNo as sequenceCounter?
		//Alternatively, is there any way to declare a sequence counter by default in a layout?
		batchinseq_LyOt := RECORD
			unsigned4 seq;
			Models.layouts.Layout_CapOneRV5_Batch_In;
		end;
		batchinseq_LyOt addSeq(batchin le, unsigned c) := TRANSFORM
			self.seq := c;
			self := le;
		end;
		batchin_seq := Project(batchin, addSeq(left,counter));

		Risk_Indicators.Layout_Input prepInput(batchin_seq le) := TRANSFORM
			self.seq := le.seq; //Production
			// self.seq := (unsigned)le.acctNo; //Validation
		
			self.DID := (unsigned)le.LexID;
			self.score := if(self.did<>0, 100, 0);
			//Clean up input
				invalidPrescreenSSN := LENGTH(TRIM(StringLib.StringFilter(le.RX_SSN, '0123456789'))) < 4 OR
										StringLib.StringFilter(le.RX_SSN, '0123456789') IN ['000000000', '111111111', '222222222', '333333333', '444444444', '555555555', '666666666', '777777777', '888888888', '999999999'] OR
										TRIM(le.RX_SSN) = '';
				//Consider a social as "not provided on input" if it is all repeating digits, less than 4 bytes, or blank on input for prescreen mode, otherwise only blank out all 0's.
				ssn_val := IF((invalidPrescreenSSN AND isPreScreenPurpose) OR StringLib.StringFilter(le.RX_SSN, '0123456789') = '000000000', '', StringLib.StringFilter(le.RX_SSN, '0123456789'));
			self.ssn := ssn_val;
			self.dob := '';// -- not being passed in by cap one per ian caton
			self.age := '';// -- not being passed in by cap one per ian caton
			self.phone10 := '';// -- not being passed in by cap one per ian caton
			self.wphone10 := '';//-- not being passed in by cap one per ian caton
			
				cleaned_name := Address.CleanPerson73(le.RX_unparsedfullname);
				boolean valid_cleaned := le.RX_unparsedfullname <> '';
			self.fname := stringlib.stringtouppercase(if(valid_cleaned, cleaned_name[6..25], ''));
			self.lname := stringlib.stringtouppercase(if(valid_cleaned, cleaned_name[46..65], ''));
			self.mname := stringlib.stringtouppercase(if(valid_cleaned, cleaned_name[26..45], ''));
			self.suffix := stringlib.stringtouppercase(if(valid_cleaned, cleaned_name[66..70], ''));	
			self.title := stringlib.stringtouppercase(if(valid_cleaned, cleaned_name[1..5],''));								

				input_addr := trim(le.Address1)+' '+trim(le.Address2);
			self.in_streetAddress := input_addr;
			self.in_city := le.City;
			self.in_state := le.State;
			self.in_zipCode := le.Zip5;
				clean_addr := risk_indicators.MOD_AddressClean.clean_addr( input_addr, le.City, le.State, le.Zip5 );			
				a := address.cleanFields(clean_addr);	
			self.prim_range := a.prim_range;
			self.predir := a.predir;
			self.prim_name := a.prim_name;
			self.addr_suffix := a.addr_suffix;
			self.postdir := a.postdir;
			self.unit_desig := a.unit_desig;
			self.sec_range := a.sec_range;
			self.p_city_name := a.v_city_name;  // use v_city_name 90..114 to match all other scoring products
			self.st := a.st;
			self.z5 := a.zip;
			self.zip4 := a.zip4;
			self.lat := a.geo_lat;
			self.long := a.geo_long;
			self.addr_type := a.rec_type;
			self.addr_status := a.err_stat;
			self.county := clean_addr[143..145];  // a.county returns the full 5 character fips, we only want the county fips
			self.geo_blk := a.geo_blk;
			self.country := '';
			self.dl_number := '';//stringlib.stringtouppercase(dl_num_clean);
			self.dl_state := '';
	
				historydate := risk_indicators.iid_constants.default_history_date;
			self.historydate := historydate;
			self.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp('', historydate);
			self := [];
		END;
		cleanInput := project(batchin_seq, prepInput(left));
		//output(cleanInput);

		lib_in := module(Models.RV_LIBIN)
			EXPORT STRING30 modelName := '';
			EXPORT STRING50 IntendedPurpose := '';
			EXPORT BOOLEAN LexIDOnlyOnInput := FALSE;
			EXPORT BOOLEAN isCalifornia := FALSE;
			EXPORT BOOLEAN preScreenOptOut := FALSE;
			EXPORT STRING65 returnCode := '';
			EXPORT STRING65 payFrequency := '';
			//EXPORT DATASET(RiskView.Layouts.Layout_Custom_Inputs) Custom_Inputs := custominputs;
		end;

		//For batch, assuming that if 1 record is LexID only on input that all records are LexID only on input to greatly simplify this calculation/requirement
		LexIDOnlyOnInput := FALSE;
		//Set variables for passing to bocashell function fcra
		bsversion := 50;
		BOOLEAN   isUtility := FALSE;
		boolean   require2ele := FALSE;  // don't need 2 elements verified together like we did in riskwise days
		unsigned1 dppa := 0; // not needed for FCRA, just populate it with full purpose anyway
		unsigned1 glba := 0; // not needed for FCRA, just populate it with full purpose anyway
		boolean   isLn := FALSE; // not needed anymore
		boolean   doRelatives := FALSE;  // no relatives in FCRA
		boolean   doDL := FALSE;  // not used
		boolean   doVehicle := FALSE;  // no vehicles in FCRA
		boolean   doDerogs := TRUE;
		boolean   suppressNearDups := FALSE;
		boolean   fromBIID := FALSE; // not a biid product	
		boolean   fromIT1O := FALSE;  // not a riskwise collection product
		boolean   doScore := FALSE;  // don't need the flagship scores populated in the bocashell
		// no ofac searching in fCRA
		boolean   ofacOnly := FALSE;  
		boolean   excludeWatchlists := TRUE; 
		unsigned1 ofacVersion := 1;
		boolean   includeOfac := FALSE;
		boolean   includeAddWatchlists := FALSE;
		real      watchlistThreshold := 1.00;
		unsigned8 BSOptions := risk_indicators.iid_constants.BSOptions.IncludePreScreen
													 | risk_indicators.iid_constants.BSOptions.IsCapOneBatch
													 | risk_indicators.iid_constants.BSOptions.RetainInputDID;
			
		//Pull clam data for retrieving RV attributes.
		clam := Risk_Indicators.Boca_Shell_Function_FCRA(
						cleanInput, gateways, dppa, glba, isUtility, isLN,
						require2ele, doRelatives, doDL, doVehicle, doDerogs, ofacOnly,
						suppressNearDups, fromBIID, excludeWatchlists, fromIT1O,
						ofacVersion, includeOfac, includeAddWatchlists, watchlistThreshold,
						bsVersion, isPreScreenPurpose, doScore, ADL_Based_Shell:=true, datarestriction:=datarestriction, BSOptions:=BSOptions,
						datapermission:=datapermission, IN_isDirectToConsumer:=isDirectToConsumerPurpose
						);
						
	
		#if(Models.LIB_RiskView_Models().TurnOnValidation = FALSE)
			

		/*Valid Models on Input*/
		model_info := Models.LIB_RiskView_Models().ValidV50Models; // Grab the valid models, output model name, billing index and model type
		valid_model_names := SET(model_info, Model_Name);
		
		/*Check for valid attributes request, may be hard-coded*/
		valid_attributes := RiskView.Constants.valid_attributes;
		valid_attributes_requested := stringlib.stringtolowercase(AttributesVersionRequest) in valid_attributes;
		  // ...if valid attributes aren't requested, don't bother calling get_attributes_v5...
		attrv5 := if(valid_attributes_requested,
									riskview.get_attributes_v5(clam, isPreScreenPurpose),
									project(clam, transform(riskview.layouts.attributes_internal_layout_noscore, self := left, self := []))
								);

		// /*Get all of our model scores*/
		noModelResults := DATASET([], Models.Layout_ModelOut);
		bankcard_model := StringLib.StringToUpperCase(bankcard_model_name);
		valid_bankcard := bankcard_model <> '' AND bankcard_model IN valid_model_names;
		bankcard_model_result := MAP(valid_bankcard	=> Models.LIB_RiskView_V50_Function(clam, bankcard_model, intended_purpose, LexIDOnlyOnInput/*, Custom_Inputs_in := customInputs*/),
																									 noModelResults);

		RV5attrs_W_bankcardResults := JOIN(attrv5, bankcard_model_result, LEFT.seq = RIGHT.seq,
			TRANSFORM(RiskView.layouts.layout_RV5capOneBatch_searchResults-AcctNo,//RiskView.layouts.layout_riskview5_search_results,
				Bankcard_info := model_info(Model_Name = bankcard_model)[1];
				//SELF.Bankcard_Index := if(valid_bankcard, (STRING)Bankcard_info.Billing_Index, '');
				SELF.Bankcard_Score_Name := if(valid_bankcard, Bankcard_info.Output_Model_Name, '');
				SELF.Bankcard_score := if(valid_bankcard, RIGHT.Score, '');
				SELF := LEFT, SELF := []), LEFT OUTER, KEEP(1), ATMOST(100));

		riskview.layouts.layout_RV5capOneBatch_searchResults-AcctNo apply_score_alert_filters(RV5attrs_W_bankcardResults le, clam rt) := transform
				SELF.LexID := IF(rt.DID = 0, '', (STRING)rt.DID); //FCRA_listGen - This should never be zero in Riskview.LITE
        
				// if the transaction can't get a score, don't return the DID for logging the inquiry
        self.inquiry_lexid := if(riskview.constants.noscore(rt.iid.nas_summary,rt.iid.nap_summary, rt.address_verification.input_address_information.naprop, rt.truedid), 
        '', 
        (string12)rt.did);

				// ====================================================
				// 							Alerts
				// ====================================================

				//security freeze, return alert code 100A
				boolean hasSecurityFreeze := rt.consumerFlags.security_freeze;
				
				//security fraud alert, return alert code 100B
				boolean hasSecurityFraudAlert := rt.consumerFlags.security_alert or rt.consumerFlags.id_theft_flag ;

				//consumer statement alert, return alert code 100C
				boolean hasConsumerStatement := rt.consumerFlags.consumer_statement_flag;

				//California or Rhodes Island state exceptions, return alert code 100D
				boolean isCaliforniaException := isCalifornia_in_person and 
																				StringLib.StringToUpperCase(intended_purpose) = 'APPLICATION' and
																				((integer)(boolean)rt.iid.combo_firstcount+(integer)(boolean)rt.iid.combo_lastcount
																				+(integer)(boolean)rt.iid.combo_addrcount+(integer)(boolean)rt.iid.combo_hphonecount
																				+(integer)(boolean)rt.iid.combo_ssncount+(integer)(boolean)rt.iid.combo_dobcount) < 3;
				boolean isRhodeIslandException := rt.rhode_island_insufficient_verification;
				boolean isStateException := (isCaliforniaException or isRhodeIslandException) OR 
																		// Also fail California In-Person Retail and Rhode Island Verification minimum input requirements for LexID Only input
																		(isCalifornia_in_person AND LexIDOnlyOnInput) OR 
																		(rt.shell_input.in_state = 'RI' AND LexIDOnlyOnInput);
				
	// Regulatory Condition 100E, too young for prescreening
	ageDate := Risk_Indicators.iid_constants.myGetDate(rt.historydate);
	BestReportedAge := ut.Age(rt.reported_dob, (unsigned)ageDate);
	boolean tooYoungForPrescreen :=  isPreScreenPurpose and BestReportedAge between 1 and 20;
				
				// Regulatory Condition 100F, on the FCRA Prescreen OptOut File
				boolean PrescreenOptOut :=  isPreScreenPurpose and risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, rt.iid.iid_flags );

				hasScore (STRING score) := le.Bankcard_score=score;
				boolean has200Score := hasScore('200');
				boolean has222Score := hasScore('222');
				
				boolean chapter7bankruptcy := trim(rt.bjl.bk_chapter)='7' AND NOT isPreScreenPurpose;	
				boolean chapter9bankruptcy := trim(rt.bjl.bk_chapter)='9' AND NOT isPreScreenPurpose;	
				boolean chapter11bankruptcy := trim(rt.bjl.bk_chapter)='11' AND NOT isPreScreenPurpose;	
				boolean chapter12bankruptcy := trim(rt.bjl.bk_chapter)='12' AND NOT isPreScreenPurpose;	
				boolean chapter13bankruptcy := trim(rt.bjl.bk_chapter)='13' AND NOT isPreScreenPurpose;	
				boolean chapter15bankruptcy := trim(rt.bjl.bk_chapter) in ['15', '304'] AND NOT isPreScreenPurpose;	
				
				hasBankruptcyAlert := chapter7bankruptcy or chapter9bankruptcy or chapter11bankruptcy or chapter12bankruptcy or chapter13bankruptcy or chapter15bankruptcy;
				
				// currently there are only 6 conditions to trigger an alert, but leaving room in the batch layout for up to 10 alerts to be returned.
				ds_alerts_temp1 := dataset([
					{if(hasSecurityFreeze and isCollectionsPurpose, '100A', '')},  // only include securityFreeze alert in this dataset if the purpose is collections
					{if(hasSecurityFraudAlert, '100B', '')},
					{if(hasConsumerStatement, '100C', '')},
					{if(has200Score, '200A', '')},
					{if(chapter7bankruptcy, '300A', '')},
					{if(chapter9bankruptcy, '300B', '')},
					{if(chapter11bankruptcy, '300C', '')},
					{if(chapter12bankruptcy, '300D', '')},
					{if(chapter13bankruptcy, '300E', '')},
					{if(chapter15bankruptcy, '300F', '')}
				], {string4 alert_code})(alert_code<>'');
				
				// when confirmationSubjectFound = 0, the only alert to come back should be the 222A.  all other alert conditions are ignored
				// when state exeption, just return a 100D and no other alerts
				ds_alert_subject_not_found := dataset([{'222A'}],{string4 alert_code});
				ds_alert_state_exception := dataset([{'100D'}],{string4 alert_code});
				ds_alert_tooYoungForPrescreen := dataset([{'100E'}],{string4 alert_code});
				ds_alert_PrescreenOptOut := dataset([{'100F'}],{string4 alert_code});
				ds_alert_SecurityFreeze := dataset([{'100A'}],{string4 alert_code});  // comes back by itself if purpose is not collections
								
				ds_alerts_temp := map(isStateException 																=> ds_alert_state_exception,  // because the state exceptions are also coming through as 222, Brad wants to put this first in map so allert of 100D
															le.ConfirmationSubjectFound='0' or has222score 	=> ds_alert_subject_not_found,
															TooYoungForPrescreen														=> ds_alert_tooYoungForPrescreen,
															PrescreenOptOut																	=> ds_alert_PrescreenOptOut,
															hasSecurityFreeze and ~isCollectionsPurpose			=> ds_alert_SecurityFreeze,
																																								 ds_alerts_temp1);
				
				// Only 100B, 100C, 200A, 222A alert codes allow for valid RiskView Scores to return, if it's the others override the score to a 100.  100A allows for a score to return if this is a collections purpose.
				score_override_alert_returned := UT.Exists2(ds_alerts_temp (alert_code IN ['100D', '100E', '100F'])) OR (UT.Exists2(ds_alerts_temp (alert_code = '100A')) AND ~isCollectionsPurpose);
				
				// If the score is being overridden to a 100, don't return a 200 or 222 score alert code.
				ds_alerts := IF(score_override_alert_returned, ds_alerts_temp (alert_code NOT IN ['200A', '222A']), ds_alerts_temp);
				ReportSuppressAlerts := (UT.Exists2(ds_alerts (alert_code = '222A')) or UT.Exists2(ds_alerts (alert_code = '200A')));
				
				self.alert1 := ds_alerts[1].alert_code;
				self.alert2 := ds_alerts[2].alert_code;
				self.alert3 := ds_alerts[3].alert_code;
				self.alert4 := ds_alerts[4].alert_code;
				self.alert5 := ds_alerts[5].alert_code;
				self.alert6 := ds_alerts[6].alert_code;
				self.alert7 := ds_alerts[7].alert_code;
				self.alert8 := ds_alerts[8].alert_code;
				self.alert9 := ds_alerts[9].alert_code;
				self.alert10 := ds_alerts[10].alert_code;
				
			// ===========================================================================
			// Now, set the fields based on all the rules in the Riskview 5 requirements
			// ===========================================================================

				// riskview scores requirement 3.3, check that the prescreen score is higher than the prescreen_score_threshold
					prescreen_score_fail_bankcard := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Bankcard_score < (INTEGER)prescreen_score_threshold;
					prescreen_score_pass_bankcard := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Bankcard_score >= (INTEGER)prescreen_score_threshold;
					prescreen_score_scenario_bankcard := prescreen_score_pass_bankcard OR prescreen_score_fail_bankcard;
		 
					SELF.Bankcard_score := MAP(le.Bankcard_score <> '' AND score_override_alert_returned 	=> '100',
																		 le.Bankcard_score <> '' AND prescreen_score_pass_bankcard	=> '1',
																		 le.Bankcard_score <> '' AND prescreen_score_fail_bankcard	=> '0',
																																																	 le.Bankcard_score);
		 
				AlertRegulatoryCondition := map(
						le.confirmationsubjectfound='0' => '0',  //If the subject is not found on file, also return a 0 for the AlertRegulatoryCondition	
						(hasSecurityFreeze and ~isCollectionsPurpose) or isStateException or tooYoungForPrescreen
							or PrescreenOptOut or prescreen_score_scenario_bankcard 					=> '3',  //Subject has an alert on their file restricting the return of their information and therefore all attributes values have been suppressed 
						hasSecurityFreeze and isCollectionsPurpose 													=> '2',  //Security freeze isn't a regulatory condition to blank everything out if the purpose is collections	
						hasConsumerStatement or hasSecurityFraudAlert or hasBankruptcyAlert => '2',  //Subject has an alert on their file that does not impact the return of their information
																																									 '1');
				self.AlertRegulatoryCondition := if(valid_attributes_requested, AlertRegulatoryCondition, '');
								
				suppress_condition := AlertRegulatoryCondition='3';
				self.InputProvidedFirstName	 := if(suppress_condition, '', le.InputProvidedFirstName	);
				self.InputProvidedLastName	 := if(suppress_condition, '', le.InputProvidedLastName	);
				self.InputProvidedStreetAddress	 := if(suppress_condition, '', le.InputProvidedStreetAddress	);
				self.InputProvidedCity	 := if(suppress_condition, '', le.InputProvidedCity	);
				self.InputProvidedState	 := if(suppress_condition, '', le.InputProvidedState	);
				self.InputProvidedZipCode	 := if(suppress_condition, '', le.InputProvidedZipCode	);
				self.InputProvidedSSN	 := if(suppress_condition, '', le.InputProvidedSSN	);
				self.InputProvidedDateofBirth	 := if(suppress_condition, '', le.InputProvidedDateofBirth	);
				self.InputProvidedPhone	 := if(suppress_condition, '', le.InputProvidedPhone	);
				self.InputProvidedLexID	 := if(suppress_condition, '', '0'	);
				self.SubjectRecordTimeOldest	 := if(suppress_condition, '', le.SubjectRecordTimeOldest	);
				self.SubjectRecordTimeNewest	 := if(suppress_condition, '', le.SubjectRecordTimeNewest	);
				self.SubjectNewestRecord12Month	 := if(suppress_condition, '', le.SubjectNewestRecord12Month	);
				self.SubjectActivityIndex03Month	 := if(suppress_condition, '', le.SubjectActivityIndex03Month	);
				self.SubjectActivityIndex06Month	 := if(suppress_condition, '', le.SubjectActivityIndex06Month	);
				self.SubjectActivityIndex12Month	 := if(suppress_condition, '', le.SubjectActivityIndex12Month	);
				self.SubjectAge	 := if(suppress_condition, '', le.SubjectAge	);
				self.SubjectDeceased	 := if(suppress_condition, '', le.SubjectDeceased	);
				self.SubjectSSNCount	 := if(suppress_condition, '', le.SubjectSSNCount	);
				self.SubjectStabilityIndex	 := if(suppress_condition, '', le.SubjectStabilityIndex	);
				self.SubjectStabilityPrimaryFactor	 := if(suppress_condition, '', le.SubjectStabilityPrimaryFactor	);
				self.SubjectAbilityIndex	 := if(suppress_condition, '', le.SubjectAbilityIndex	);
				self.SubjectAbilityPrimaryFactor	 := if(suppress_condition, '', le.SubjectAbilityPrimaryFactor	);
				self.SubjectWillingnessIndex	 := if(suppress_condition, '', le.SubjectWillingnessIndex	);
				self.SubjectWillingnessPrimaryFactor	 := if(suppress_condition, '', le.SubjectWillingnessPrimaryFactor	);
				// self.ConfirmationSubjectFound	 := if(suppress_condition, '', le.ConfirmationSubjectFound	);  // don't ever suppress this attribute.
				self.ConfirmationInputName	 := if(suppress_condition, '', le.ConfirmationInputName	);
				self.ConfirmationInputDOB	 := if(suppress_condition, '', le.ConfirmationInputDOB	);
				self.ConfirmationInputSSN	 := if(suppress_condition, '', le.ConfirmationInputSSN	);
				self.ConfirmationInputAddress	 := if(suppress_condition, '', le.ConfirmationInputAddress	);
				self.SourceNonDerogProfileIndex	 := if(suppress_condition, '', le.SourceNonDerogProfileIndex	);
				self.SourceNonDerogCount	 := if(suppress_condition, '', le.SourceNonDerogCount	);
				self.SourceNonDerogCount03Month	 := if(suppress_condition, '', le.SourceNonDerogCount03Month	);
				self.SourceNonDerogCount06Month	 := if(suppress_condition, '', le.SourceNonDerogCount06Month	);
				self.SourceNonDerogCount12Month	 := if(suppress_condition, '', le.SourceNonDerogCount12Month	);
				self.SourceCredHeaderTimeOldest	 := if(suppress_condition, '', le.SourceCredHeaderTimeOldest	);
				self.SourceCredHeaderTimeNewest	 := if(suppress_condition, '', le.SourceCredHeaderTimeNewest	);
				self.SourceVoterRegistration	 := if(suppress_condition, '', le.SourceVoterRegistration	);
				self.EducationAttendance	 := if(suppress_condition, '', le.EducationAttendance	);
				self.EducationEvidence	 := if(suppress_condition, '', le.EducationEvidence	);
				self.EducationProgramAttended	 := if(suppress_condition, '', le.EducationProgramAttended	);
				self.EducationInstitutionPrivate	 := if(suppress_condition, '', le.EducationInstitutionPrivate	);
				self.EducationInstitutionRating	 := if(suppress_condition, '', le.EducationInstitutionRating	);
				self.ProfLicCount	 := if(suppress_condition, '', le.ProfLicCount	);
				self.ProfLicTypeCategory	 := if(suppress_condition, '', le.ProfLicTypeCategory	);
				self.BusinessAssociation	 := if(suppress_condition, '', le.BusinessAssociation	);
				self.BusinessAssociationIndex	 := if(suppress_condition, '', le.BusinessAssociationIndex	);
				self.BusinessAssociationTimeOldest	 := if(suppress_condition, '', le.BusinessAssociationTimeOldest	);
				self.BusinessTitleLeadership	 := if(suppress_condition, '', le.BusinessTitleLeadership	);
				self.AssetIndex	 := if(suppress_condition, '', le.AssetIndex	);
				self.AssetIndexPrimaryFactor	 := if(suppress_condition, '', le.AssetIndexPrimaryFactor	);
				self.AssetOwnership	 := if(suppress_condition, '', le.AssetOwnership	);
				self.AssetProp	 := if(suppress_condition, '', le.AssetProp	);
				self.AssetPropIndex	 := if(suppress_condition, '', le.AssetPropIndex	);
				self.AssetPropEverCount	 := if(suppress_condition, '', le.AssetPropEverCount	);
				self.AssetPropCurrentCount	 := if(suppress_condition, '', le.AssetPropCurrentCount	);
				self.AssetPropCurrentTaxTotal	 := if(suppress_condition, '', le.AssetPropCurrentTaxTotal	);
				self.AssetPropPurchaseCount12Month	 := if(suppress_condition, '', le.AssetPropPurchaseCount12Month	);
				self.AssetPropPurchaseTimeOldest	 := if(suppress_condition, '', le.AssetPropPurchaseTimeOldest	);
				self.AssetPropPurchaseTimeNewest	 := if(suppress_condition, '', le.AssetPropPurchaseTimeNewest	);
				self.AssetPropNewestMortgageType	 := if(suppress_condition, '', le.AssetPropNewestMortgageType	);
				self.AssetPropEverSoldCount	 := if(suppress_condition, '', le.AssetPropEverSoldCount	);
				self.AssetPropSoldCount12Month	 := if(suppress_condition, '', le.AssetPropSoldCount12Month	);
				self.AssetPropSaleTimeOldest	 := if(suppress_condition, '', le.AssetPropSaleTimeOldest	);
				self.AssetPropSaleTimeNewest	 := if(suppress_condition, '', le.AssetPropSaleTimeNewest	);
				self.AssetPropNewestSalePrice	 := if(suppress_condition, '', le.AssetPropNewestSalePrice	);
				self.AssetPropSalePurchaseRatio	 := if(suppress_condition, '', le.AssetPropSalePurchaseRatio	);
				self.AssetPersonal	 := if(suppress_condition, '', le.AssetPersonal	);
				self.AssetPersonalCount	 := if(suppress_condition, '', le.AssetPersonalCount	);
				self.PurchaseActivityIndex	 := if(suppress_condition, '', le.PurchaseActivityIndex	);
				self.PurchaseActivityCount	 := if(suppress_condition, '', le.PurchaseActivityCount	);
				self.PurchaseActivityDollarTotal	 := if(suppress_condition, '', le.PurchaseActivityDollarTotal	);
				self.DerogSeverityIndex	 := if(suppress_condition, '', le.DerogSeverityIndex	);
				self.DerogCount	 := if(suppress_condition, '', le.DerogCount	);
				self.DerogCount12Month	 := if(suppress_condition, '', le.DerogCount12Month	);
				self.DerogTimeNewest	 := if(suppress_condition, '', le.DerogTimeNewest	);
				self.CriminalFelonyCount	 := if(suppress_condition, '', le.CriminalFelonyCount	);
				self.CriminalFelonyCount12Month	 := if(suppress_condition, '', le.CriminalFelonyCount12Month	);
				self.CriminalFelonyTimeNewest	 := if(suppress_condition, '', le.CriminalFelonyTimeNewest	);
				self.CriminalNonFelonyCount	 := if(suppress_condition, '', le.CriminalNonFelonyCount	);
				self.CriminalNonFelonyCount12Month	 := if(suppress_condition, '', le.CriminalNonFelonyCount12Month	);
				self.CriminalNonFelonyTimeNewest	 := if(suppress_condition, '', le.CriminalNonFelonyTimeNewest	);
				self.EvictionCount	 := if(suppress_condition, '', le.EvictionCount	);
				self.EvictionCount12Month	 := if(suppress_condition, '', le.EvictionCount12Month	);
				self.EvictionTimeNewest	 := if(suppress_condition, '', le.EvictionTimeNewest	);
				self.LienJudgmentSeverityIndex	 := if(suppress_condition, '', le.LienJudgmentSeverityIndex	);
				self.LienJudgmentCount	 := if(suppress_condition, '', le.LienJudgmentCount	);
				self.LienJudgmentCount12Month	 := if(suppress_condition, '', le.LienJudgmentCount12Month	);
				self.LienJudgmentSmallClaimsCount	 := if(suppress_condition, '', le.LienJudgmentSmallClaimsCount	);
				self.LienJudgmentCourtCount	 := if(suppress_condition, '', le.LienJudgmentCourtCount	);
				self.LienJudgmentTaxCount	 := if(suppress_condition, '', le.LienJudgmentTaxCount	);
				self.LienJudgmentForeclosureCount	 := if(suppress_condition, '', le.LienJudgmentForeclosureCount	);
				self.LienJudgmentOtherCount	 := if(suppress_condition, '', le.LienJudgmentOtherCount	);
				self.LienJudgmentTimeNewest	 := if(suppress_condition, '', le.LienJudgmentTimeNewest	);
				self.LienJudgmentDollarTotal	 := if(suppress_condition, '', le.LienJudgmentDollarTotal	);
				self.BankruptcyCount 	 := if(suppress_condition, '', le.BankruptcyCount 	);
				self.BankruptcyCount24Month	 := if(suppress_condition, '', le.BankruptcyCount24Month	);
				self.BankruptcyTimeNewest	 := if(suppress_condition, '', le.BankruptcyTimeNewest	);
				self.BankruptcyChapter	 := if(suppress_condition, '', le.BankruptcyChapter	);
				self.BankruptcyStatus	 := if(suppress_condition, '', le.BankruptcyStatus	);
				self.BankruptcyDismissed24Month	 := if(suppress_condition, '', le.BankruptcyDismissed24Month	);
				self.ShortTermLoanRequest	 := if(suppress_condition, '', le.ShortTermLoanRequest	);
				self.ShortTermLoanRequest12Month	 := if(suppress_condition, '', le.ShortTermLoanRequest12Month	);
				self.ShortTermLoanRequest24Month	 := if(suppress_condition, '', le.ShortTermLoanRequest24Month	);
				self.InquiryAuto12Month	 := if(suppress_condition, '', le.InquiryAuto12Month	);
				self.InquiryBanking12Month	 := if(suppress_condition, '', le.InquiryBanking12Month	);
				self.InquiryTelcom12Month	 := if(suppress_condition, '', le.InquiryTelcom12Month	);
				self.InquiryNonShortTerm12Month	 := if(suppress_condition, '', le.InquiryNonShortTerm12Month	);
				self.InquiryShortTerm12Month	 := if(suppress_condition, '', le.InquiryShortTerm12Month	);
				self.InquiryCollections12Month	 := if(suppress_condition, '', le.InquiryCollections12Month	);
				self.SSNSubjectCount	 := if(suppress_condition, '', le.SSNSubjectCount	);
				self.SSNDeceased	 := if(suppress_condition, '', le.SSNDeceased	);
				self.SSNDateLowIssued	 := if(suppress_condition, '', le.SSNDateLowIssued	);
				self.SSNProblems	 := if(suppress_condition, '', le.SSNProblems	);
				self.AddrOnFileCount	 := if(suppress_condition, '', le.AddrOnFileCount	);
				self.AddrOnFileCorrectional	 := if(suppress_condition, '', le.AddrOnFileCorrectional	);
				self.AddrOnFileCollege	 := if(suppress_condition, '', le.AddrOnFileCollege	);
				self.AddrOnFileHighRisk	 := if(suppress_condition, '', le.AddrOnFileHighRisk	);
					self.AddrInputTimeOldest	 := if(suppress_condition, '', le.AddrInputTimeOldest	);
				self.AddrInputTimeNewest	 := if(suppress_condition, '', le.AddrInputTimeNewest	);
				self.AddrInputLengthOfRes	 := if(suppress_condition, '', le.AddrInputLengthOfRes	);
				self.AddrInputSubjectCount	 := if(suppress_condition, '', le.AddrInputSubjectCount	);
				self.AddrInputMatchIndex	 := if(suppress_condition, '', le.AddrInputMatchIndex	);
				self.AddrInputSubjectOwned	 := if(suppress_condition, '', le.AddrInputSubjectOwned	);
				self.AddrInputDeedMailing	 := if(suppress_condition, '', le.AddrInputDeedMailing	);
				self.AddrInputOwnershipIndex	 := if(suppress_condition, '', le.AddrInputOwnershipIndex	);
				self.AddrInputPhoneService	 := if(suppress_condition, '', le.AddrInputPhoneService	);
				self.AddrInputPhoneCount	 := if(suppress_condition, '', le.AddrInputPhoneCount	);
				self.AddrInputDwellType	 := if(suppress_condition, '', le.AddrInputDwellType	);
				self.AddrInputDwellTypeIndex	 := if(suppress_condition, '', le.AddrInputDwellTypeIndex	);
				self.AddrInputDelivery	 := if(suppress_condition, '', le.AddrInputDelivery	);
				self.AddrInputTimeLastSale	 := if(suppress_condition, '', le.AddrInputTimeLastSale	);
				self.AddrInputLastSalePrice	 := if(suppress_condition, '', le.AddrInputLastSalePrice	);
				self.AddrInputTaxValue	 := if(suppress_condition, '', le.AddrInputTaxValue	);
				self.AddrInputTaxYr	 := if(suppress_condition, '', le.AddrInputTaxYr	);
				self.AddrInputTaxMarketValue	 := if(suppress_condition, '', le.AddrInputTaxMarketValue	);
				self.AddrInputAVMValue	 := if(suppress_condition, '', le.AddrInputAVMValue	);
				self.AddrInputAVMValue12Month	 := if(suppress_condition, '', le.AddrInputAVMValue12Month	);
				self.AddrInputAVMRatio12MonthPrior	 := if(suppress_condition, '', le.AddrInputAVMRatio12MonthPrior	);
				self.AddrInputAVMValue60Month	 := if(suppress_condition, '', le.AddrInputAVMValue60Month	);
				self.AddrInputAVMRatio60MonthPrior	 := if(suppress_condition, '', le.AddrInputAVMRatio60MonthPrior	);
				self.AddrInputCountyRatio	 := if(suppress_condition, '', le.AddrInputCountyRatio	);
				self.AddrInputTractRatio	 := if(suppress_condition, '', le.AddrInputTractRatio	);
				self.AddrInputBlockRatio	 := if(suppress_condition, '', le.AddrInputBlockRatio	);
				self.AddrInputProblems	 := if(suppress_condition, '', le.AddrInputProblems	);
				self.AddrCurrentTimeOldest	 := if(suppress_condition, '', le.AddrCurrentTimeOldest	);
				self.AddrCurrentTimeNewest	 := if(suppress_condition, '', le.AddrCurrentTimeNewest	);
				self.AddrCurrentLengthOfRes    := if(suppress_condition, '', le.AddrCurrentLengthOfRes 	);
				self.AddrCurrentSubjectOwned 	 := if(suppress_condition, '', le.AddrCurrentSubjectOwned 	);
				self.AddrCurrentDeedMailing	 := if(suppress_condition, '', le.AddrCurrentDeedMailing	);
				self.AddrCurrentOwnershipIndex	 := if(suppress_condition, '', le.AddrCurrentOwnershipIndex	);
				self.AddrCurrentPhoneService	 := if(suppress_condition, '', le.AddrCurrentPhoneService	);
				self.AddrCurrentDwellType 	 := if(suppress_condition, '', le.AddrCurrentDwellType 	);
				self.AddrCurrentDwellTypeIndex	 := if(suppress_condition, '', le.AddrCurrentDwellTypeIndex	);
				self.AddrCurrentTimeLastSale	 := if(suppress_condition, '', le.AddrCurrentTimeLastSale	);
				self.AddrCurrentLastSalesPrice	 := if(suppress_condition, '', le.AddrCurrentLastSalesPrice	);
				self.AddrCurrentTaxValue	 := if(suppress_condition, '', le.AddrCurrentTaxValue	);
				self.AddrCurrentTaxYr	 := if(suppress_condition, '', le.AddrCurrentTaxYr	);
				self.AddrCurrentTaxMarketValue	 := if(suppress_condition, '', le.AddrCurrentTaxMarketValue	);
				self.AddrCurrentAVMValue	 := if(suppress_condition, '', le.AddrCurrentAVMValue	);
				self.AddrCurrentAVMValue12Month	 := if(suppress_condition, '', le.AddrCurrentAVMValue12Month	);
				self.AddrCurrentAVMRatio12MonthPrior	 := if(suppress_condition, '', le.AddrCurrentAVMRatio12MonthPrior	);
				self.AddrCurrentAVMValue60Month	 := if(suppress_condition, '', le.AddrCurrentAVMValue60Month	);
				self.AddrCurrentAVMRatio60MonthPrior	 := if(suppress_condition, '', le.AddrCurrentAVMRatio60MonthPrior	);
				self.AddrCurrentCountyRatio	 := if(suppress_condition, '', le.AddrCurrentCountyRatio	);
				self.AddrCurrentTractRatio	 := if(suppress_condition, '', le.AddrCurrentTractRatio	);
				self.AddrCurrentBlockRatio	 := if(suppress_condition, '', le.AddrCurrentBlockRatio	);
				self.AddrCurrentCorrectional	 := if(suppress_condition, '', le.AddrCurrentCorrectional	);
				self.AddrPreviousTimeOldest	 := if(suppress_condition, '', le.AddrPreviousTimeOldest	);
				self.AddrPreviousTimeNewest	 := if(suppress_condition, '', le.AddrPreviousTimeNewest	);
				self.AddrPreviousLengthOfRes 	 := if(suppress_condition, '', le.AddrPreviousLengthOfRes 	);
				self.AddrPreviousSubjectOwned 	 := if(suppress_condition, '', le.AddrPreviousSubjectOwned 	);
				self.AddrPreviousOwnershipIndex	 := if(suppress_condition, '', le.AddrPreviousOwnershipIndex	);
				self.AddrPreviousDwellType 	 := if(suppress_condition, '', le.AddrPreviousDwellType 	);
				self.AddrPreviousDwellTypeIndex	 := if(suppress_condition, '', le.AddrPreviousDwellTypeIndex	);
				self.AddrPreviousCorrectional	 := if(suppress_condition, '', le.AddrPreviousCorrectional	);
				self.AddrStabilityIndex	 := if(suppress_condition, '', le.AddrStabilityIndex	);
				self.AddrChangeCount03Month	 := if(suppress_condition, '', le.AddrChangeCount03Month	);
				self.AddrChangeCount06Month	 := if(suppress_condition, '', le.AddrChangeCount06Month	);
				self.AddrChangeCount12Month	 := if(suppress_condition, '', le.AddrChangeCount12Month	);
				self.AddrChangeCount24Month	 := if(suppress_condition, '', le.AddrChangeCount24Month	);
				self.AddrChangeCount60Month	 := if(suppress_condition, '', le.AddrChangeCount60Month	);
				self.AddrLastMoveTaxRatioDiff	 := if(suppress_condition, '', le.AddrLastMoveTaxRatioDiff	);
				self.AddrLastMoveEconTrajectory	 := if(suppress_condition, '', le.AddrLastMoveEconTrajectory	);
				self.AddrLastMoveEconTrajectoryIndex	 := if(suppress_condition, '', le.AddrLastMoveEconTrajectoryIndex	);
				self.PhoneInputProblems	 := if(suppress_condition, '', le.PhoneInputProblems	);
				self.PhoneInputSubjectCount	 := if(suppress_condition, '', le.PhoneInputSubjectCount	);
				self.PhoneInputMobile 	 := if(suppress_condition, '', le.PhoneInputMobile 	);
				self := le;
				//self := [];
		end;
		RV5_batchResults_preAcctNo := join(RV5attrs_W_bankcardResults, clam, 
																			left.seq=right.seq,
																			apply_score_alert_filters(left, right));

		RV5_batchResults := JOIN(RV5_batchResults_preAcctNo, batchin_seq, 
															left.seq=right.seq, 
													TRANSFORM(riskview.layouts.layout_RV5capOneBatch_searchResults-seq,
															self.AcctNo := right.AcctNo;
															self := left));

		// ===================================
		// 					for debugging
		// ===================================

		// output(cleanInput, named('SAMPLE__cleanInput'));
		// output(clam, named('SAMPLE__clam'));
		// output(attrv5, named('SAMPLE__attrv5'));

		Results := RV5_batchResults;
		#else // Else, output the model results directly

		// return Models.LIB_RiskView_Models(clam, lib_in).ValidatingModel;
		Results := Models.LIB_RiskView_Models(clam, lib_in).ValidatingModel;
		#end

		output(Results, named('Results'));

ConsumerStatementResults1 := project(clam.ConsumerStatements, 
	transform(FFD.layouts.ConsumerStatementBatchFullFlat,
		self.UniqueId := left.uniqueId;

		self.StatementID := (string)left.statementID;
		self.dateAdded := // renamed timestamp to be dateAdded to match what krishna's team is doing
			intformat(left.timestamp.year, 4, 1) + 
			intformat(left.timestamp.month, 2, 1) + 
			intformat(left.timestamp.day, 2, 1) +
			' ' +
			intformat(left.timestamp.hour24, 2, 1) + 
			intformat(left.timestamp.minute, 2, 1) + 
			intformat(left.timestamp.second, 2, 1);
		self.recordtype := left.statementtype;	// renamed the statement type to be recordtype like krishna's team is doing instead to be more generic since it also includes disputes now as well
		self := left,
		self := []));

empty_ds := dataset([], FFD.layouts.ConsumerStatementBatchFullFlat);

ConsumerStatementResults_temp := if(OutputConsumerStatements, ConsumerStatementResults1, empty_ds);
		
ConsumerStatementResults := join(Results, ConsumerStatementResults_temp, (unsigned)left.lexid=(unsigned)right.uniqueid, 
			transform(FFD.layouts.ConsumerStatementBatchFullFlat, 
			self.acctno := left.acctno, self := right));

			
output(ConsumerStatementResults, named('CSDResults'));  


		//output(clam, named('clam'));

ENDMACRO;