import iesp,identifier2,address,models,ut,codes,Suppress,AutoStandardI, seed_files, risk_indicators,doxie, PersonReports, IntlIID, header, mdr, drivers;
	
	inputParams := project(AutoStandardI.GlobalModule(),input.params,opt);
	finderParams := project (AutoStandardI.GlobalModule(), PersonReports.input._finderreport, opt);

	boolean Test_Data_Enabled := FALSE   	: stored('TestDataEnabled');
	string20 Test_Data_Table_Name := ''  	: stored('TestDataTableName');

	unsigned1 DPPA_Purpose := inputParams.dppapurpose;
	unsigned1 GLB_Purpose := inputParams.glbpurpose;
	
	boolean IsFCRA := false;
	boolean ln_branded := false;
	string6 ssnMask := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(project(inputParams,AutoStandardI.InterfaceTranslator.ssn_mask_val.params));
	unsigned1 dlMask := AutoStandardI.InterfaceTranslator.dl_mask_val.val(project(inputParams,AutoStandardI.InterfaceTranslator.dl_mask_val.params));
	unsigned1 dob_mask_value := AutoStandardI.InterfaceTranslator.dob_mask_value.val(project(inputParams,AutoStandardI.InterfaceTranslator.dob_mask_value.params));
	
	unsigned3 Number_Of_Risk_Codes_Returned := 0 : stored('NumberOfRiskCodesReturned');
	boolean	Use_CurrentlyOwnedProperty := false : stored('UseCurrentlyOwnedProperty');
	boolean	Use_nonsubjectproperty := false : stored('use_nonsubjectproperty');
	boolean	Include_Prop_Data := false : stored('IncludePropertyData');
	boolean Include_Imposter_Data := false : stored('IncludeImposterData');
	boolean	Include_DEA_Data := false : stored('IncludeDEALicenseData');
	boolean	Include_ProfLic_Data := false : stored('IncludeProfLicenseData');
	boolean	Include_DL_Data := false : stored('IncludeDriverLicenseData');
	boolean	Include_SSNExist_Data := false : stored('IncludeSSNExistData');
	boolean	Include_Multiple_Identities := false : stored('IncludeMultipleIdentities');
	boolean	Include_Discovered_DOB := false : stored('IncludeDiscoveredDOB');
	boolean	Compare_Discovered_DOBToSSN := false : stored('CompareDiscoveredDOBToSSN');
	boolean	Verify_SSN_Exists_OnAnyAddress := false : stored('VerifySSNExistsOnAnyAddress');
	boolean	DOB_Matches_SSN := false : stored('DOBMatchesSSN');
	boolean	YOB_Matches_SSN := false : stored('YOBMatchesSSN');
	boolean	SSN_Last_DOB := false : stored('SSNLastDOB');
	boolean	Zip_Matches_State := false : stored('ZipMatchesState');
	boolean	Include_Valid_Drivers_License := false : stored('IncludeValidDriversLicense');
	boolean	Include_Valid_Professional_License := false : stored('IncludeValidProfessionalLicense');
	boolean	Include_Valid_DEA_License := false : stored('IncludeValidDEALicense');
	boolean	Currently_Own_Input_Property := false : stored('CurrentlyOwnInputProperty');
	string 	Verify_InputAddressMatchesKnownBad := '' : stored('VerifyInputAddressMatchesKnownBad');
	boolean	Ever_Owned_Input_Property := false : stored('EverOwnedInputProperty');
	Integer Ever_Owned_Input_Property_InPastNumberOfYears  := 0 : stored('EverOwnedInputPropertyInPastNumberOfYears');
	boolean	Owned_Any_Property := false : stored('OwnedAnyProperty');	  
	boolean	Current_Occupant := false : stored('CurrentOccupant');
	boolean	Ever_Occupant := false : stored('EverOccupant');
	
 	// unsigned2	Ever_Occupant_InPastNumberOfMonths := 0 : stored('EverOccupantInPastNumberOfMonths');
	// string  Ever_Occupant_StartDate := '' : stored('EverOccupantStartDate');
	unsigned2 EverOccupant_PastMonths := 0: stored('EverOccupant_PastMonths');
	unsigned4 EverOccupant_StartDate  := 99999999 : stored('EverOccupant_StartDate');

	boolean IncludeNAPData := false : stored('IncludeNAPData');
	
	string44 PassportUpperLine := '' : STORED('MachineReadableLine1');
	string44 PassportLowerLine := '' : STORED('MachineReadableLine2');
	string6 Gender := '' : STORED('Gender');
	boolean FromID2 := TRUE;
	#stored ('FromID2',FromID2);

	unsigned6 UniqueId := 0 : STORED('UniqueId');
	unsigned6 ID2UniqueId := UniqueId ;
	unsigned3 history_date := 999999 			: stored('HistoryDateYYYYMM');
	string DataRestriction := AutoStandardI.GlobalModule().DataRestrictionMask;
	string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');	
	// We want to turn on these IID options for Identifier 2 - don't need advo or uspis, they will always run
	// #stored('SearchADVO', TRUE);
	// #stored('SearchUSPISHotList', TRUE);
	#stored('SearchSicNAICSCodes', TRUE);

	#stored('InstantIDVersion','1');// ID2 wants all new CIID functionality by default (01/2014)
	#stored('DisallowInsurancePhoneHeaderGateway', true);	
	#stored('DisableCustomerNetworkOptionInCVI', true);
	#stored('IsIdentifier2', true);
	    
	
	//get iid results
	iidRecs := Risk_Indicators.InstantID_records;

	// per 3/24/11 email from Kim White: "I don't want this code to be activated in the Identifier2 project - I need time for it to be understood and vetted."
	// I'm leaving this code here in the event we want to turn it on in the future.
	/*
	iidRecs_pre := Risk_Indicators.InstantID_records;
	// per bug 71089, if the SSN is corrected, SSNInfo should reflect the corrected SSN's SSNMap data, not the input value
	risk_indicators.Layout_InstantID_NuGenPlus correctedSSNMap( iidRecs_pre le, doxie.Key_SSN_Map ri ) := TRANSFORM
		// new ssn-issue data have '20990101' for the current date intervals
		r_end := (UNSIGNED3) (ri.end_date[1..6]);
		end_yyyymm := IF (r_end = 209901, 0, r_end); 
		self.valid_ssn      := IF(le.valid_ssn='0' and ri.ssn5='','1',le.valid_ssn);
		self.ssa_state      := ri.state;
		self.ssa_date_first := ri.start_date;
		self.ssa_date_last  := IF((unsigned)ri.end_date in [0, 20990101, 20991231], '', ri.end_date);
		self.ssa_state_name := Address.Map_State_Name_To_Abbrev(Stringlib.StringToUpperCase(ri.state));

		self := le;
	END;
	iidRecs := if( iidRecs_pre[1].corrected_ssn='', iidRecs_pre,
		join( iidRecs_pre, doxie.Key_SSN_Map,
			keyed(left.corrected_ssn[1..5]=right.ssn5)
				AND keyed (left.corrected_ssn[6..9] between Right.start_serial AND Right.end_serial)
				// AND ((unsigned3)(RIGHT.start_date[1..6]) < history_date) // check date
				,
			correctedSSNMap(left,right),
			LEFT OUTER, keep (1))
	);
	*/





	// FUTURE ENHANCEMENT: use did2 and did3 in addition to did
	//pull the did out
	id2dids := project(iidRecs, doxie.layout_references);
	// stateOfZip := ziplib.ZipToState2(Zip2Check);			
	// doesZipMatchState := (St2Check = StateOfZip) and Zip_Matches_State;		
	best_recs := doxie.best_records(id2dids,false, DPPA_Purpose, GLB_Purpose);
	discoverDOB := best_recs[1].dob;	//Discover DOB (find dob even if not input)
	discoverDOBAge := best_recs[1].age;
		 
	iidOut := risk_indicators.Layout_InstantID_NuGenPlus;    

	id2rc( string hri ) := dataset([iesp.ECL2ESP.setRiskIndicator(hri,Identifier2.getRiskStatusDesc(hri))], iesp.share.t_RiskIndicator);
	id2si( string hri ) := dataset([iesp.ECL2ESP.setStatusIndicator(hri, Identifier2.getRiskStatusDesc(hri))], iesp.share.t_RiskIndicator);
	blank_ri := dataset([], iesp.share.t_RiskIndicator);

	iesp.instantid.t_WatchList xform_wl( risk_indicators.layouts.layout_watchlists_plus_seq le ) := transform
		self.Table                  := le.Watchlist_Table;
		self.RecordNumber           := le.Watchlist_Record_Number;
		self.Name.First             := le.Watchlist_fname;
		self.Name.Last              := le.Watchlist_lname;
		self.Name                   := [];
		self.Address.StreetAddress1 := le.Watchlist_address;
		self.Address.City           := le.Watchlist_City;
		self.Address.State          := le.Watchlist_State;
		self.Address.Zip5           := le.Watchlist_zip;
		self.Country                := le.Watchlist_contry;
		self.EntityName             := le.Watchlist_Entity_Name;

		clean := risk_indicators.MOD_AddressClean.clean_addr( le.Watchlist_address, le.Watchlist_City, le.Watchlist_State, le.Watchlist_zip );
		cf := Address.CleanFields(clean);

		self.Address.StreetNumber         := cf.prim_range;
		self.Address.StreetPreDirection   := cf.predir;
		self.Address.StreetName           := cf.prim_name;
		self.Address.StreetSuffix         := cf.addr_suffix;
		self.Address.StreetPostDirection  := cf.postdir;
		self.Address.UnitDesignation      := cf.unit_desig;
		self.Address.UnitNumber           := cf.sec_range;
		// self.Address.StreetAddress1       := le.Watchlist_address;
		self.Address.StreetAddress2       := '';
		// self.Address.City                 := cf.p_city_name;
		// self.Address.State                := cf.st;
		// self.Address.Zip5                 := cf.zip;
		self.Address.Zip4                 := cf.zip4;
		self.Address.County               := cf.county[3..5];
		self.Address.PostalCode           := '';
		self.Address.StateCityZip         := '';
		self.Sequence 							 := le.seq;
		self := [];
	end;

	identifier2.layout_Identifier2 addId2(iidOut le) := TRANSFORM
		//Add all data that doesn't call out to other modules of functions in order to make Identifier2 response.
		// ***********************************************************************************************************
		self.DiscoveredDOB.DOBDiscovered := discoverDOB > 0;
		self.DiscoveredDOB.Age := if (Include_Discovered_DOB and discoverDOBAGE > 0, discoverDOBAge,0); 
		self.DiscoveredDOB.RiskIndicators := IF (Include_Discovered_DOB and discoverDOB = 0, id2si('DX'), blank_ri);
		DDfull     := Include_Discovered_DOB and discoverDOB > 10000000 and discoverDOB % 10000 > 0 and discoverDOB % 100 > 0;
		DDyyyymm   := Include_Discovered_DOB and discoverDOB > 10000000 and discoverDOB % 10000 > 0 and discoverDOB % 100 = 0;
		DDyyyyOnly := Include_Discovered_DOB and discoverDOB > 10000000 and discoverDOB % 10000 = 0;
		DDmmOnly   := Include_Discovered_DOB and discoverDOB <= 1231 and discoverDOB % 100 = 0;
		DDddOnly   := Include_Discovered_DOB and (discoverDOB between 1 and 31);

		self.DiscoveredDOB.StatusIndicators := MAP(
			not Include_Discovered_DOB or discoverDOB = 0 => blank_ri,
			DDfull    => id2rc('DY'),
			DDyyyymm  => id2rc('D6'),   												
						 id2rc('D4')
			// DDyyyyOnly => dataset([iesp.ECL2ESP.setRiskIndicator('D4',Identifier2.getRiskStatusDesc('D4'))], iesp.share.t_RiskIndicator),   												
			// dataset([], iesp.share.t_RiskIndicator)
		);
		maskDiscDOB := risk_indicators.iid_constants.mask_dob((string)discoverDOB, dob_mask_value);	//Discover DOB (find dob even if not input)
		self.DiscoveredDOB.DOB := if (Include_Discovered_DOB and discoverDOB > 0, iesp.ECL2ESP.toDatestring8 (maskDiscDOB));

		// ***********************************************************************************************************
		//Assumption: le.ssa_date_last is already been thru exact logic 
		dobSSNValid := if ((integer4) le.ssa_date_last < (integer4) discoverDOB OR discoverDOB = 0, false, true);//discover dob ssn issue date compare.
		self.DiscoveredDOBComparedToSSN.DiscoveredDOBMatchedSSNIssueDate := if (Include_Discovered_DOB and Compare_Discovered_DOBToSSN, dobSSNValid, false);
			self.DiscoveredDOBComparedToSSN.RiskIndicators   := IF (Compare_Discovered_DOBToSSN and ~dobSSNValid,id2si('SP') ,blank_ri) ;
			self.DiscoveredDOBComparedToSSN.StatusIndicators := IF (Compare_Discovered_DOBToSSN and dobSSNValid,id2si('SA') ,blank_ri) ;
			
		// Instant Verify requires that date first seen and date last seen be '0' for randomized socials.  
		// If the SSN date first seen AND last seen match the randomized ssn date logic, this should be a randomized SSN.
		randomizedSSN := le.ssa_date_first = '20110625' AND le.ssa_date_last = IF(history_date = 999999, ut.getDate, history_date + '01');
		SELF.ssa_date_first := IF(randomizedSSN, '0', le.ssa_date_first);
		SELF.ssa_date_last := IF(randomizedSSN, '0', le.ssa_date_last);
		SELF.valid_ssn := IF(randomizedSSN, '', le.valid_ssn);
		
		// ***********************************************************************************************************
		// This check is exact only..no fuzzy logic
		// SSN exists in Header....quick check return address
		glb_ok := risk_indicators.iid_constants.glb_ok(GLB_Purpose, isFCRA);
		dppa_ok := risk_indicators.iid_constants.dppa_ok(dppa_purpose, isFCRA);
		didRec := Doxie.Key_Header_Wild_SSN(keyed(s1=le.ssn[1]),
															keyed(s2=le.ssn[2]),
															keyed(s3=le.ssn[3]),
															keyed(s4=le.ssn[4]),
															keyed(s5=le.ssn[5]),
															keyed(s6=le.ssn[6]),
															keyed(s7=le.ssn[7]),
															keyed(s8=le.ssn[8]),
															keyed(s9=le.ssn[9]));
		hRecs := join (didRec, doxie.key_header,
			LEFT.did<>0
			AND (LEFT.s1+LEFT.s2+LEFT.s3+LEFT.s4+LEFT.s5+LEFT.s6+LEFT.s7+LEFT.s8+LEFT.s9)=right.ssn
			AND RIGHT.prim_name<>''
			AND keyed(LEFT.did = RIGHT.s_did)
			AND right.src not in risk_indicators.iid_constants.masked_header_sources(DataRestriction, IsFCRA)
			AND (header.isPreGLB(RIGHT) OR glb_ok)
			AND (~mdr.Source_is_DPPA(RIGHT.src) OR
					(dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),dppa_purpose,RIGHT.src)))
			AND ~mdr.Source_is_on_Probation(RIGHT.src)  // we won't use probation data 
			// we won't use experian dl's/vehicles (requires LN branding)
			AND (ln_branded OR ~(dppa_ok AND (RIGHT.src in mdr.sourcetools.set_Experian_dl or RIGHT.src in mdr.sourcetools.set_Experian_vehicles))),
					LIMIT(ut.limits.HEADER_PER_DID), KEEP(1));
						
						
		self.SSNExistsOnAnAddress.SSNExistsOnAnAddress := Verify_SSN_Exists_OnAnyAddress and exists(hRecs);
		self.SSNExistsOnAnAddress.Address := if (Verify_SSN_Exists_OnAnyAddress and exists(hRecs) and Include_SSNExist_Data,
			iesp.ECL2ESP.SetAddress (
				hRecs[1].prim_name, hRecs[1].prim_range, hRecs[1].predir,hRecs[1].postdir, hRecs[1].suffix, hRecs[1].unit_desig, hRecs[1].sec_range,
				hRecs[1].city_name, hRecs[1].st,  hRecs[1].zip, hRecs[1].zip4, hRecs[1].county_name));
		// ***********************************************************************************************************
		// Assumptions:  le.combo_dobcount and le.combo_ssncount already go thru exact logic.
		dob_ssn_match := DOB_Matches_SSN and le.combo_dobcount > 0
			and le.combo_ssncount > 0
			and le.combo_ssnscore between 90 and 100;
		self.InputDOBMatchesSSN.InputDOBMatchesSSN := dob_ssn_match;
		self.InputDOBMatchesSSN.RiskIndicators   := IF (dob_matches_ssn and ~dob_ssn_match,id2si('SN') ,blank_ri) ;
		self.InputDOBMatchesSSN.StatusIndicators := IF (dob_matches_ssn and dob_ssn_match,id2si('SF') ,blank_ri) ;
		
		//not sure about below code for YOB SSN match....
		doesYOBMatchSSN := ((integer4)discoverDOB div 10000 = (integer4)le.dob div 10000)
			and YOB_Matches_SSN
			and le.combo_ssncount > 0
			and le.combo_ssnscore between 90 and 100;
		self.InputYOBMatchesSSN.InputYOBMatchesSSN := doesYOBMatchSSN;
		self.InputYOBMatchesSSN.RiskIndicators := IF (Yob_matches_ssn and ~doesYOBMatchSSN,id2si('YN') ,blank_ri) ;
		self.InputYOBMatchesSSN.StatusIndicators := IF (Yob_matches_ssn and doesYOBMatchSSN,id2si('YF') ,blank_ri) ;
		
		// ***********************************************************************************************************
		doesZipMatchState := false : stored('ZipStateMatch');
		self.InputZipMatchesState.InputZipMatchesState := doesZipMatchState;
		self.InputZipMatchesState.RiskIndicators := IF (Zip_Matches_State and ~doesZipMatchState,id2si('ZN') ,blank_ri) ;
		self.InputZipMatchesState.StatusIndicators := IF (Zip_Matches_State and doesZipMatchState,id2si('ZY') ,blank_ri) ;
		
		// ***********************************************************************************************************
		// Assumptions:  le.combo_lastcount and le.combo_dobcount and le.combo_ssncount already go thru exact logic.
		ssnlastdob := (
			SSN_Last_DOB and
			le.combo_lastcount>0 and 
			le.combo_dobcount > 0 and 
			le.combo_ssncount > 0 and 
			le.combo_ssnscore between 90 and 100
		);                          
		self.InputSSNMatchesLastAndDOB.InputSSNMatchesLastAndDOB := ssnlastdob;
		self.InputSSNMatchesLastAndDOB.RiskIndicators := IF (SSN_Last_DOB and ~ssnlastdob,id2si('NN') ,blank_ri) ;
		self.InputSSNMatchesLastAndDOB.StatusIndicators := IF (SSN_Last_DOB and ssnlastdob,id2si('NY') ,blank_ri) ;

		PassportLine := PassportUpperLine + PassportLowerLine;
		self.PassportValidated := IntlIID.ValidationFunctions().passportValidation(PassportLine, le.dob[3..8], gender);
		
		// Strictly an Input Echo
		self.InputEcho.Passport.MachineReadableLine1 := PassportUpperLine;
		self.InputEcho.Passport.MachineReadableLine2 := PassportLowerLine;
		self.InputEcho.Gender := Gender;
    self.InputEcho.UniqueId  := (string)ID2UniqueId;

		// self.name.full := '';
		self.watchlists := project( le.watchlists, xform_wl(left) );
		self.DOBMatchLevel := (integer)le.dobmatchlevel;		//***KWH - CIV
		SELF := le;
		self := [];
	END;

	iid2_minus_data := project(iidRecs, addId2(LEFT));
 
	// all additional data sections broken out
	identifier2.layout_Identifier2 foo( iidRecs le ) := TRANSFORM
		self.watchlists := project( le.watchlists, xform_wl(left) );
		self.passportValidated := le.passportValidated='Y';
		self.DOBMatchLevel := (integer)le.dobmatchlevel;		//***KWH - CIV
		self.InputEcho.UniqueId  := (string)ID2UniqueId;
		self := le;
		self := [];
	END;
	data_prep := project(iidRecs, foo(left));

	prop_details := getProperty(data_prep, owned_any_property, ever_owned_input_property, currently_own_input_property, 
																	Ever_Owned_Input_Property_InPastNumberOfYears, Include_Prop_Data);

	imposter_details := if(Include_Multiple_Identities, getImposters(data_prep, Include_Imposter_Data, IsFCRA,finderParams,dob_mask_value), data_prep);

	dl_details := if(Include_Valid_Drivers_License, getDls(data_prep, Include_DL_Data, ssnMask, dob_mask_value, dlMask), data_prep);

	profLic_details := if(Include_Valid_Professional_License, getprofLic(data_prep, Include_ProfLic_Data,dob_mask_value), data_prep);

	dea_details := if(Include_Valid_DEA_License, getDea(data_prep, Include_DEA_Data, ssnMask ), data_prep);

	occupant_details := getOccupant(data_prep, current_occupant, ever_occupant);

	md_prop := if(Owned_Any_property or Ever_Owned_Input_Property or Currently_Own_Input_Property, 
		join(iid2_minus_data, prop_details, left.seq=right.seq,
			transform(identifier2.layout_Identifier2, 
				self.OwnedAnyProperty := right.ownedAnyProperty;
				self.CurrentlyOwnInputProperty := right.CurrentlyOwnInputProperty;
				self.EverOwnedInputProperty := right.EverOwnedInputProperty;														
				self := left),	parallel),
		iid2_minus_data);

	dl_imposter := if(Include_Multiple_Identities or Include_Valid_Drivers_License, 
		join(dl_details, imposter_details, left.seq=right.seq,
			transform(identifier2.layout_Identifier2, 
				self.AdditionalIdentities := right.AdditionalIdentities;
				self := left),	parallel),
		data_prep);

	dea_proflic := if(Include_Valid_Professional_License or Include_Valid_DEA_License , 
		join(dea_details, proflic_details, left.seq=right.seq,
			transform(identifier2.layout_Identifier2, 
				self.ProfessionalLicense := right.ProfessionalLicense;
				self := left),	parallel),
		data_prep);


	md_prop_dl_imp := 	join(md_prop, dl_imposter, left.seq=right.seq,
		transform(identifier2.layout_Identifier2, 
			self.DriversLicense := right.DriversLicense;
			self.AdditionalIdentities := right.AdditionalIdentities;
			self := left),	parallel);

	dea_proflic_occupant := join(dea_proflic, occupant_details, left.seq=right.seq,
		transform(identifier2.layout_Identifier2, 
			self.InputAddressCurrentOccupant := right.InputAddressCurrentOccupant;
			self.InputAddressEverOccupant := right.InputAddressEverOccupant;
			self := left),	parallel);

	final_recs := join(md_prop_dl_imp, dea_proflic_occupant, left.seq=right.seq,
		transform(identifier2.layout_Identifier2, 
			self.InputAddressCurrentOccupant := right.InputAddressCurrentOccupant;
			self.InputAddressEverOccupant := right.InputAddressEverOccupant;
			self.DEALicense := right.DEALicense;
			self.ProfessionalLicense := right.ProfessionalLicense;
			self := left));

	//if the customer provides us a list of their known bad addresses, go join to it
	final_recs_plus_knownbad := if(trim(Verify_InputAddressMatchesKnownBad) not in ['', '0'],
																 identifier2.getBadAddresses(final_recs, Verify_InputAddressMatchesKnownBad),
																 final_recs);

	ret_test_seed := Seed_Files.GetIdentifier2(iidRecs,Test_Data_Table_Name);
	
  //transform output for ESDL compliance (iesp.instantid.t_Identifier2Result)
  iesp_out := iesp.transform_identifier2( if(test_data_Enabled, ret_test_seed, final_recs_plus_knownbad) );
	
export Identifier2Records := iesp_out;
