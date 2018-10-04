/*--SOAP--
<message name="ISS_FCRA_Service">
	<!-- XML INPUT -->
	<part name="FCRAInsuranceScoringServiceRequest" type="tns:XmlDataSet" cols="80" rows="50" />
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="4"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
</message>
*/
/*--INFO--  FCRA Boca Shell for Insurance real-time service */
/*--HELP--
<pre>
ISSServiceRequest XML:
&ltDataset&gt
  &ltRow&gt
  &ltUser&gt
	  &ltReferenceCode&gt&lt/ReferenceCode&gt 
	  &ltBillingCode&gt&lt/BillingCode&gt 
	  &ltQueryId&gt&lt/QueryId&gt 
	  &ltCompanyId&gt&lt/CompanyId&gt 
	  &ltGLBPurpose&gt&lt/GLBPurpose&gt 
	  &ltDLPurpose&gt&lt/DLPurpose&gt 
	  &ltLoginHistoryId&gt&lt/LoginHistoryId&gt 
	  &ltDebitUnits&gt0&lt/DebitUnits&gt 
	  &ltIP&gt&lt/IP&gt 
	  &ltIndustryClass&gt&lt/IndustryClass&gt 
	  &ltResultFormat&gt&lt/ResultFormat&gt 
	  &ltLogAsFunction&gt&lt/LogAsFunction&gt 
	  &ltSSNMask&gt&lt/SSNMask&gt 
	  &ltDOBMask&gt&lt/DOBMask&gt 
	  &ltDLMask&gtfalse&lt/DLMask&gt 
	  &ltDataRestrictionMask&gt&lt/DataRestrictionMask&gt 
	  &ltDataPermissionMask&gt&lt/DataPermissionMask&gt 
	  &ltApplicationType&gt&lt/ApplicationType&gt 
	  &ltSSNMaskingOn&gtfalse&lt/SSNMaskingOn&gt 
	  &ltDLMaskingOn&gtfalse&lt/DLMaskingOn&gt 
	  &ltEndUser&gt
		  &ltCompanyName&gt&lt/CompanyName&gt 
		  &ltStreetAddress1&gt&lt/StreetAddress1&gt 
		  &ltCity&gt&lt/City&gt 
		  &ltState&gt&lt/State&gt 
		  &ltZip5&gt&lt/Zip5&gt 
	  &lt/EndUser&gt
	  &ltMaxWaitSeconds&gt0&lt/MaxWaitSeconds&gt 
	  &ltRelatedTransactionId&gt&lt/RelatedTransactionId&gt 
	  &ltAccountNumber&gt&lt/AccountNumber&gt 
	  &ltTestDataEnabled&gtfalse&lt/TestDataEnabled&gt 
	  &ltTestDataTableName&gt&lt/TestDataTableName&gt 
  &lt/User&gt
  &ltRemoteLocations&gt&lt/RemoteLocations&gt 
  &ltServiceLocations&gt&lt/ServiceLocations&gt 
  &ltOptions&gt
	  &ltBlind&gtfalse&lt/Blind&gt 
	  &ltEncrypt&gtfalse&lt/Encrypt&gt 
	  &ltReturnTokens&gtfalse&lt/ReturnTokens&gt 
	  &ltStrictMatch&gtfalse&lt/StrictMatch&gt 
	  &ltMaxResults&gt0&lt/MaxResults&gt 
	  &ltUseNicknames&gtfalse&lt/UseNicknames&gt 
	  &ltIncludeAlsoFound&gtfalse&lt/IncludeAlsoFound&gt 
	  &ltUsePhonetics&gtfalse&lt/UsePhonetics&gt 
	  &ltPenaltyThreshold&gt0&lt/PenaltyThreshold&gt 
	  &ltBSVersion&gt3&lt/BSVersion&gt 
	  &ltPreScreen&gtfalse&lt/PreScreen&gt 
	  &ltHistoryDateYYYYMM&gt0&lt/HistoryDateYYYYMM&gt 
	  &ltRequestedAttributeGroups&gt&lt/RequestedAttributeGroups&gt 
  &lt/Options&gt
  &ltSearchBy&gt
	  &ltName&gt
		  &ltFull&gt&lt/Full&gt 
		  &ltFirst&gt&lt/First&gt 
		  &ltMiddle&gt&lt/Middle&gt 
		  &ltLast&gt&lt/Last&gt 
		  &ltSuffix&gt&lt/Suffix&gt 
		  &ltPrefix&gt&lt/Prefix&gt 
	  &lt/Name&gt
	  &ltAddress&gt
		  &ltStreetNumber&gt&lt/StreetNumber&gt 
		  &ltStreetPreDirection&gt&lt/StreetPreDirection&gt 
		  &ltStreetName&gt&lt/StreetName&gt 
		  &ltStreetSuffix&gt&lt/StreetSuffix&gt 
		  &ltStreetPostDirection&gt&lt/StreetPostDirection&gt 
		  &ltUnitDesignation&gt&lt/UnitDesignation&gt 
		  &ltUnitNumber&gt&lt/UnitNumber&gt 
		  &ltStreetAddress1&gt&lt/StreetAddress1&gt 
		  &ltStreetAddress2&gt&lt/StreetAddress2&gt 
		  &ltCity&gt&lt/City&gt 
		  &ltState&gt&lt/State&gt 
		  &ltZip5&gt&lt/Zip5&gt 
		  &ltZip4&gt&lt/Zip4&gt 
		  &ltCounty&gt&lt/County&gt 
		  &ltPostalCode&gt&lt/PostalCode&gt 
		  &ltStateCityZip&gt&lt/StateCityZip&gt 
	  &lt/Address&gt
	  &ltDOB&gt
		  &ltYear&gt0&lt/Year&gt 
		  &ltMonth&gt0&lt/Month&gt 
		  &ltDay&gt0&lt/Day&gt 
	  &lt/DOB&gt
	  &ltAge&gt0&lt/Age&gt 
	  &ltSSN&gt&lt/SSN&gt 
	  &ltDriverLicenseNumber&gt&lt/DriverLicenseNumber&gt 
	  &ltDriverLicenseState&gt&lt/DriverLicenseState&gt 
	  &ltEmail&gt&lt/Email&gt 
	  &ltIPAddress&gt&lt/IPAddress&gt 
	  &ltHomePhone&gt&lt/HomePhone&gt 
	  &ltWorkPhone&gt&lt/WorkPhone&gt 
	  &ltAccountNumber&gt&lt/AccountNumber&gt 
  &lt/SearchBy&gt
  &lt/Row&gt
  &lt/Dataset&gt
</pre>
*/

export ISS_FCRA_Service := MACRO

	import risk_indicators, ut, iesp, address, seed_files, models, dma, doxie, iss, fcra_opt_out, riskwise, gateway;

	// Get XML input 
	ds_in       := dataset([], iesp.fcrainsurancescoringservice.t_FCRAInsuranceScoringServiceRequest) 	: stored('FCRAInsuranceScoringServiceRequest', few);
	gateways_in := Gateway.Configuration.Get();
	
	optionsIn := ds_in[1].options;
	userIn := ds_in[1].user;
	
	history_date 		:= if(optionsIn.historyDateYYYYMM=0, 999999, optionsIn.historyDateYYYYMM);
	STRING50 outOfBandDataRestriction := '' : STORED('DataRestrictionMask');
	DataRestriction 	:= MAP(TRIM(userIn.DataRestrictionMask) <> ''       => userIn.DataRestrictionMask,
                                  TRIM(outOfBandDataRestriction) <> ''  => outOfBandDataRestriction,
                                                                           Risk_Indicators.iid_constants.default_DataRestriction); 
	STRING10 outOfBandDataPermission := '' : STORED('DataPermissionMask');
	DataPermission 	  := MAP(TRIM(userIn.DataPermissionMask) <> ''       => userIn.DataPermissionMask,
                                  TRIM(outOfBandDataPermission) <> ''  => outOfBandDataPermission,
                                                                           Risk_Indicators.iid_constants.default_DataPermission); 

	bsVersion 			:= optionsIn.bsVersion;	// version 1 is the original, 2 would add BS 2 fields and 3 will add BS 3 fields
	isPreScreen     := StringLib.StringToUpperCase(optionsIn.IntendedPurpose) = 'PRESCREENING';
	AdlBasedShell		:= optionsIn.AdlBasedShell;
	
	TestDataEnabled 	:= userIn.TestDataEnabled;
	TestDataTableName := userIn.TestDataTableName;
	
	boolean   FilterLiens := if(DataRestriction[risk_indicators.iid_constants.posLiensJudgRestriction]='1', true, false ); //DRM says don't run lnj or include is false so don't run lnj
	
	// get input attributes
	attributesIn := optionsIn.RequestedAttributeGroups;
	
	rvIn := attributesIn(StringLib.StringToLowerCase(TRIM(Name)) = 'riskview');
	doRVver1 := TRIM(rvIn[1].Version) = '1';	// output version1 if requested
	doRVver2 := TRIM(rvIn[1].Version) = '2';	// output version2 if requested
	doRVver3 := TRIM(rvIn[1].Version) = '3';	// output version3 if requested

	
	// Do Not Allow Targus Gateway To Come In
	Gateway.Layouts.Config gw_switch(gateways_in le) := transform
		_isTargus := Gateway.Configuration.IsTargus(le.servicename);
		self.servicename := if (_isTargus, '',	le.servicename); // don't allow targus gateway										
		self.url := if(_isTargus, '',	le.url); // don't allow targus gateway								
		self := le;							
	end;
	gateways := project(gateways_in, gw_switch(left));
	
	
	
	layout_acctseq := record
		integer4 seq;
		ds_in;
	end;
	wseq := project( ds_in, transform( layout_acctseq, self.seq := counter, self := left ) );
	
	wseqcheck := if(bsVersion=0, FAIL(layout_acctseq, 'No Boca Shell version passed in'), wseq);	// if no bsversion passed in then fail
	
	
	// Boca Shell
	Risk_Indicators.Layout_Input into(wseqcheck l) := TRANSFORM
		self.seq := l.seq;
		self.ssn := l.searchby.ssn;
		dob :=                    l.searchby.dob.year
		    + intformat((integer1)l.searchby.dob.month, 2, 1)
		    + intformat((integer1)l.searchby.dob.day,   2, 1);
		self.dob := if((unsigned)dob=0, '', dob);
		self.age := if (l.searchby.age = 0 and (integer)dob != 0, 
														(STRING3)ut.GetAgeI_asOf((unsigned8)dob, (unsigned)risk_indicators.iid_constants.myGetDate(history_date)), 
														if(l.searchby.age=0, '', (STRING3)l.searchby.age));	
		fullname := trim(l.searchby.name.full);
		cleanname := address.CleanPerson73( fullname );
		title  := if(l.searchby.name.prefix='' and fullname!='', trim((cleanname[1..5]))  , l.searchby.name.prefix);
		fname  := if(l.searchby.name.first ='' and fullname!='', trim((cleanname[6..25])) , l.searchby.name.first );
		mname  := if(l.searchby.name.middle='' and fullname!='', trim((cleanname[26..45])), l.searchby.name.middle);
		lname  := if(l.searchby.name.last  ='' and fullname!='', trim((cleanname[46..65])), l.searchby.name.last  );
		suffix := if(l.searchby.name.suffix='' and fullname!='', trim((cleanname[66..70])), l.searchby.name.suffix);
		
		self.title  := stringlib.stringtouppercase(title);
		self.fname  := stringlib.stringtouppercase(fname);
		self.mname  := stringlib.stringtouppercase(mname);
		self.lname  := stringlib.stringtouppercase(lname);
		self.suffix := stringlib.stringtouppercase(suffix);
		
		addr_value := if(trim(l.searchby.address.streetaddress1)!='', l.searchby.address.streetaddress1,
				Address.Addr1FromComponents(l.searchby.address.streetnumber, l.searchby.address.streetpredirection, l.searchby.address.streetname,
					l.searchby.address.streetsuffix, l.searchby.address.streetpostdirection, l.searchby.address.unitdesignation, l.searchby.address.unitnumber));

		clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, l.searchby.address.city, l.searchby.address.state, l.searchby.address.zip5);

		self.in_streetAddress:= addr_value;
		self.in_city         := l.searchby.address.city;
		self.in_state        := l.searchby.address.state;
		self.in_zipCode      := l.searchby.address.zip5;	
		self.prim_range      := clean_a2[1..10];
		self.predir          := clean_a2[11..12];
		self.prim_name       := clean_a2[13..40];
		self.addr_suffix     := clean_a2[41..44];
		self.postdir         := clean_a2[45..46];
		self.unit_desig      := clean_a2[47..56];
		self.sec_range       := clean_a2[57..64];
		self.p_city_name     := clean_a2[90..114];
		self.st              := clean_a2[115..116];
		self.z5              := clean_a2[117..121];
		self.zip4            := clean_a2[122..125];
		self.lat             := clean_a2[146..155];
		self.long            := clean_a2[156..166];
		self.addr_type       := clean_a2[139];
		self.addr_status     := clean_a2[179..182];
		self.county          := clean_a2[143..145];
		self.geo_blk         := clean_a2[171..177];
		dl_num_clean := riskwise.cleanDL_num(l.searchby.DriverLicenseNumber);
		self.dl_number       := stringlib.stringtouppercase(dl_num_clean);
		self.dl_state        := stringlib.stringtouppercase(l.searchby.DriverLicenseState);
		self.phone10 			:= l.searchby.homephone;
		self.wphone10			:= l.searchby.workphone;
		self.email_address	:= l.searchby.email;
		self.ip_address		:= l.searchby.ipAddress;
		self.historydate := history_date;
		self := [];
	END;
	iid_prep := PROJECT(wseqcheck, into(left));
	
	
	// prep input for test seeds
	risk_indicators.layout_input into_test_prep(wseqcheck l) := transform
		self.seq := l.seq;	
		self.ssn := l.searchby.ssn;
		self.phone10 := l.searchby.homephone;
		
		fullname := trim(l.searchby.name.full);
		cleanname := address.CleanPerson73( fullname );
		fname  := if(l.searchby.name.first ='' and fullname!='', trim((cleanname[6..25])) , l.searchby.name.first );
		lname  := if(l.searchby.name.last  ='' and fullname!='', trim((cleanname[46..65])), l.searchby.name.last  );
		self.fname := stringlib.stringtouppercase(fname);
		self.lname := stringlib.stringtouppercase(lname);
		SELF.in_zipCode := l.searchby.address.zip5;
		self := [];
	end;
	test_prep := PROJECT(wseqcheck, into_test_prep(LEFT));
	
	

	// set variables for passing to bocashell function fcra
	boolean 	isFCRA							:= true;
	unsigned1 dppa                := 0; // not needed for FCRA
	unsigned1 glba                := 0; // not needed for FCRA
	boolean   isUtility 					:= userIn.industryClass = 'UTILI';
	boolean   require2ele         := false;
	boolean   isLn                := false; // not needed anymore
	boolean   doRelatives         := false;
	boolean   doDL                := false;
	boolean   doVehicle           := false;
	boolean   doDerogs            := true;
	boolean   ofacOnly            := true;
	boolean   suppressNearDups    := false;
	boolean   fromBIID            := false;
	boolean   excludeWatchlists   := true;
	boolean   fromIT1O            := false;
	unsigned1 OFACVersion 				:= 0;	// not used in fcra
	real      watchlistThreshold 	:= 0.84;	// not used in fcra
	boolean   includeOfac         := false;
	boolean   includeAddWatchlists:= false;
	boolean   nugen               := true;
	boolean   doScore 						:= true;
	unsigned1 AppendBest					:= 1;	// search best file
	unsigned8 BSOptions						:= if(FilterLiens, risk_indicators.iid_constants.BSOptions.FilterLiens, 0 ) + //DRM to drive Liens/Judgments;
													Risk_Indicators.iid_constants.BSOptions.InsuranceFCRABankruptcyException;
	

	clam := Risk_Indicators.Boca_Shell_Function_FCRA(	iid_prep, 
																		gateways, 
																		dppa, 
																		glba, 
																		isUtility, 
																		isLN, 
																		require2ele, 
																		doRelatives, 
																		doDL, 
																		doVehicle, 
																		doDerogs, 
																		ofacOnly,
																		suppressNearDups, 
																		fromBIID, 
																		excludeWatchlists, 
																		fromIT1O,
																		ofacVersion, 
																		includeOfac, 
																		includeAddWatchlists, 
																		watchlistThreshold,
																		bsVersion, 
																		isPreScreen, 
																		doScore, 
																		nugen, 
																		AdlBasedShell, 
																		datarestriction,
																		AppendBest,
																		BSOptions,
																		datapermission
																	);
	
	
	// get boca shell test seeds
	clamTestSeeds := Risk_Indicators.Boca_Shell_Test_Function(test_prep, ds_in[1].searchby.accountNumber, TestDataTableName, IsFCRA);
									
	// map the bocashell															
	mappedBocaShell := iss.getBocaShell(clam, datarestriction, TestDataEnabled, TestDataTableName, bsVersion);
	
	// choose between real clam or testseed clam
	clamFinal := if(TestDataEnabled, group(clamTestSeeds,seq), mappedBocaShell);



	// check the optout file for isPreScreen
	opt_outs := fcra_opt_out.identify_opt_outs(ungroup(project(clam, transform(risk_indicators.Layout_Input, self := left.shell_input))) );


	// GET RV ATTRIBUTES
	rvAttr := Models.getRVAttributes(clam, '', isPreScreen,  if(isPrescreen, opt_outs[1].opt_out_hit, false));
	rvTestSeed := PROJECT(Risk_Indicators.RVAttributes_TestSeed_Function(test_prep, '', TestDataTableName), TRANSFORM(Models.Layout_RVAttributes.Layout_rvAttrSeqWithAddrAppend, SELF := LEFT; SELF := []));
	rvFinal := if(TestDataEnabled, rvTestSeed, ungroup(rvAttr));

	
	// get input echo and clam
	iesp.fcrainsurancescoringservice.t_FCRAInsuranceScoringServiceResponse getIEclam(wseq le, clamFinal ri) := transform
		self.result.bocashell.version3 := ri;
		
		self.result.inputecho := le.searchby;
		
		self.result.RiskviewAttributes := [];
		
		self._Header := [];	// does this need populating?
		self := [];
	end;
	wIEclam := join(wseqcheck, clamFinal, left.seq=right.seq, getIEclam(left,right));




	// Populate RiskView Attributes
	iesp.fcrainsurancescoringservice.t_FCRAInsuranceScoringServiceResponse getFA(wIEclam le, rvFinal ri) := transform
		self.result.RiskviewAttributes.Version1.Lifestyle.dwelltype := if(doRVver1, ri.lifestyle.dwelltype, '');
		self.result.RiskviewAttributes.Version1.Lifestyle.AssessedAmount := if(doRVver1, ri.lifestyle.assessed_amount, 0);
		self.result.RiskviewAttributes.Version1.Lifestyle.ApplicantOwned := if(doRVver1, ri.lifestyle.applicant_owned, false);
		self.result.RiskviewAttributes.Version1.Lifestyle.FamilyOwned := if(doRVver1, ri.lifestyle.family_owned, false);
		self.result.RiskviewAttributes.Version1.Lifestyle.OccupantOwned := if(doRVver1, ri.lifestyle.occupant_owned, false);
		self.result.RiskviewAttributes.Version1.Lifestyle.IsBestMatch := if(doRVver1, ri.lifestyle.isbestmatch, false);
		self.result.RiskviewAttributes.Version1.Lifestyle.DateFirstSeen := if(doRVver1, ri.lifestyle.date_first_seen, 0);
		self.result.RiskviewAttributes.Version1.Lifestyle.DateFirstSeen2 := if(doRVver1, ri.lifestyle.date_first_seen2, 0);
		self.result.RiskviewAttributes.Version1.Lifestyle.DateFirstSeen3 := if(doRVver1, ri.lifestyle.date_first_seen3, 0);
		self.result.RiskviewAttributes.Version1.Lifestyle.NumberNonderogs := if(doRVver1, ri.lifestyle.number_nonderogs, '');
		self.result.RiskviewAttributes.Version1.Lifestyle.DateLastSeen := if(doRVver1, ri.lifestyle.date_last_seen, 0);
		self.result.RiskviewAttributes.Version1.Lifestyle.RecentUpdate := if(doRVver1, ri.lifestyle.recent_update, false);

		self.result.RiskviewAttributes.Version1.Dems.SsnIssued := if(doRVver1, ri.dems.ssn_issued, false);
		self.result.RiskviewAttributes.Version1.Dems.LowIssueDate := if(doRVver1, ri.dems.low_issue_date, 0);
		self.result.RiskviewAttributes.Version1.Dems.HighIssueDate := if(doRVver1, ri.dems.high_issue_date, 0);
		self.result.RiskviewAttributes.Version1.Dems.NonUsSSN := if(doRVver1, ri.dems.nonUS_ssn, false);
		self.result.RiskviewAttributes.Version1.Dems.SsnIssueState := if(doRVver1, ri.dems.ssn_issue_state, '');
		self.result.RiskviewAttributes.Version1.Dems.SsnFirstSeen := if(doRVver1, ri.dems.ssn_first_seen, 0);	

		self.result.RiskviewAttributes.Version1.Finance.PhoneFullNameMatch := if(doRVver1, ri.finance.phone_full_name_match, false);
		self.result.RiskviewAttributes.Version1.Finance.PhoneLastNameMatch := if(doRVver1, ri.finance.phone_last_name_match, false);
		self.result.RiskviewAttributes.Version1.Finance.NapStatus := if(doRVver1, ri.finance.nap_status, '');

		self.result.RiskviewAttributes.Version1.Property.PropertyOwnedTotal := if(doRVver1, ri.property.property_owned_total, 0);
		self.result.RiskviewAttributes.Version1.Property.PropertyOwnedAssessedTotal := if(doRVver1, ri.property.property_owned_assessed_total, 0);
		self.result.RiskviewAttributes.Version1.Property.PropertyHistoricallyOwned := if(doRVver1, ri.property.property_historically_owned, 0);

		self.result.RiskviewAttributes.Version1.Derogs.CriminalCount := if(doRVver1, ri.derogs.criminal_count, 0);
		self.result.RiskviewAttributes.Version1.Derogs.FilingCount := if(doRVver1, ri.derogs.filing_count, 0);
		self.result.RiskviewAttributes.Version1.Derogs.DateLastSeen := if(doRVver1, ri.derogs.date_last_seen, 0);
		self.result.RiskviewAttributes.Version1.Derogs.Disposition := if(doRVver1, ri.derogs.disposition, '');
		self.result.RiskviewAttributes.Version1.Derogs.LiensHistoricalUnreleasedCount := if(doRVver1, ri.derogs.liens_historical_unreleased_count, 0);
		self.result.RiskviewAttributes.Version1.Derogs.LiensRecentUnreleasedCount := if(doRVver1, ri.derogs.liens_recent_unreleased_count, 0);
		self.result.RiskviewAttributes.Version1.Derogs.TotalNumberDerogs := if(doRVver1, ri.derogs.total_number_derogs, 0);
		
	
		// populate the fields that have an '_' in the field name
		self.result.RiskviewAttributes.Version2.mobilityindicator := if(doRVver2, ri.version2.mobility_indicator, '');
		
		self.result.RiskviewAttributes.Version2.propertyownedtotal := if(doRVver2, ri.version2.property_owned_total, 0);
		self.result.RiskviewAttributes.Version2.propertyownedassessedtotal := if(doRVver2, ri.version2.property_owned_assessed_total, 0);
		self.result.RiskviewAttributes.Version2.propertyhistoricallyowned := if(doRVver2, ri.version2.property_historically_owned, 0);
		self.result.RiskviewAttributes.Version2.datefirstpurchase := if(doRVver2, ri.version2.date_first_purchase, 0);
		self.result.RiskviewAttributes.Version2.datemostrecentpurchase := if(doRVver2, ri.version2.date_most_recent_purchase, 0);
		self.result.RiskviewAttributes.Version2.datemostrecentsale := if(doRVver2, ri.version2.date_most_recent_sale, 0);
		
		self.result.RiskviewAttributes.Version2.wealthindicator := if(doRVver2, ri.version2.wealth_indicator, '');

		self.result.RiskviewAttributes.Version2.totalnumberderogs := if(doRVver2, ri.version2.total_number_derogs, 0);
		self.result.RiskviewAttributes.Version2.datelastderog := if(doRVver2, ri.version2.date_last_derog, 0);
		
		self.result.RiskviewAttributes.Version2.datelastconviction := if(doRVver2, ri.version2.date_last_conviction, 0);
		
		self.result.RiskviewAttributes.Version2.numliens := if(doRVver2, ri.version2.num_liens, 0);
		self.result.RiskviewAttributes.Version2.numunreleasedliens := if(doRVver2, ri.version2.num_unreleased_liens, 0);
		self.result.RiskviewAttributes.Version2.datelastunreleased := if(doRVver2, ri.version2.date_last_unreleased, 0);
		self.result.RiskviewAttributes.Version2.numunreleasedliens30 := if(doRVver2, ri.version2.num_unreleased_liens30, 0);
		self.result.RiskviewAttributes.Version2.numunreleasedliens90 := if(doRVver2, ri.version2.num_unreleased_liens90, 0);
		self.result.RiskviewAttributes.Version2.numunreleasedliens180 := if(doRVver2, ri.version2.num_unreleased_liens180, 0);
		self.result.RiskviewAttributes.Version2.numunreleasedliens12 := if(doRVver2, ri.version2.num_unreleased_liens12, 0);
		self.result.RiskviewAttributes.Version2.numunreleasedliens24 := if(doRVver2, ri.version2.num_unreleased_liens24, 0);
		self.result.RiskviewAttributes.Version2.numunreleasedliens36 := if(doRVver2, ri.version2.num_unreleased_liens36, 0);
		self.result.RiskviewAttributes.Version2.numunreleasedliens60 := if(doRVver2, ri.version2.num_unreleased_liens60, 0);
		
		self.result.RiskviewAttributes.Version2.numreleasedliens := if(doRVver2, ri.version2.num_released_liens, 0);
		self.result.RiskviewAttributes.Version2.datelastreleased := if(doRVver2, ri.version2.date_last_released, 0);
		self.result.RiskviewAttributes.Version2.numreleasedliens30 := if(doRVver2, ri.version2.num_released_liens30, 0);
		self.result.RiskviewAttributes.Version2.numreleasedliens90 := if(doRVver2, ri.version2.num_released_liens90, 0);
		self.result.RiskviewAttributes.Version2.numreleasedliens180 := if(doRVver2, ri.version2.num_released_liens180, 0);
		self.result.RiskviewAttributes.Version2.numreleasedliens12 := if(doRVver2, ri.version2.num_released_liens12, 0);
		self.result.RiskviewAttributes.Version2.numreleasedliens24 := if(doRVver2, ri.version2.num_released_liens24, 0);
		self.result.RiskviewAttributes.Version2.numreleasedliens36 := if(doRVver2, ri.version2.num_released_liens36, 0);
		self.result.RiskviewAttributes.Version2.numreleasedliens60 := if(doRVver2, ri.version2.num_released_liens60, 0);
		
		self.result.RiskviewAttributes.Version2.bankruptcycount := if(doRVver2, ri.version2.bankruptcy_count, 0);
		self.result.RiskviewAttributes.Version2.datelastbankruptcy := if(doRVver2, ri.version2.date_last_bankruptcy, 0);
		self.result.RiskviewAttributes.Version2.filingtype := if(doRVver2, ri.version2.filing_type, '');
		self.result.RiskviewAttributes.Version2.bankruptcycount30 := if(doRVver2, ri.version2.bankruptcy_count30, 0);
		self.result.RiskviewAttributes.Version2.bankruptcycount90 := if(doRVver2, ri.version2.bankruptcy_count90, 0);
		self.result.RiskviewAttributes.Version2.bankruptcycount180 := if(doRVver2, ri.version2.bankruptcy_count180, 0);
		self.result.RiskviewAttributes.Version2.bankruptcycount12 := if(doRVver2, ri.version2.bankruptcy_count12, 0);
		self.result.RiskviewAttributes.Version2.bankruptcycount24 := if(doRVver2, ri.version2.bankruptcy_count24, 0);
		self.result.RiskviewAttributes.Version2.bankruptcycount36 := if(doRVver2, ri.version2.bankruptcy_count36, 0);
		self.result.RiskviewAttributes.Version2.bankruptcycount60 := if(doRVver2, ri.version2.bankruptcy_count60, 0);
		
		self.result.RiskviewAttributes.Version2.evictioncount := if(doRVver2, ri.version2.eviction_count, 0);
		self.result.RiskviewAttributes.Version2.datelasteviction := if(doRVver2, ri.version2.date_last_eviction, 0);
		self.result.RiskviewAttributes.Version2.evictioncount30 := if(doRVver2, ri.version2.eviction_count30, 0);
		self.result.RiskviewAttributes.Version2.evictioncount90 := if(doRVver2, ri.version2.eviction_count90, 0);
		self.result.RiskviewAttributes.Version2.evictioncount180 := if(doRVver2, ri.version2.eviction_count180, 0);
		self.result.RiskviewAttributes.Version2.evictioncount12 := if(doRVver2, ri.version2.eviction_count12, 0);
		self.result.RiskviewAttributes.Version2.evictioncount24 := if(doRVver2, ri.version2.eviction_count24, 0);
		self.result.RiskviewAttributes.Version2.evictioncount36 := if(doRVver2, ri.version2.eviction_count36, 0);
		self.result.RiskviewAttributes.Version2.evictioncount60 := if(doRVver2, ri.version2.eviction_count60, 0);

		self.result.RiskviewAttributes.Version2.numnonderogs := if(doRVver2, ri.version2.num_nonderogs, 0);
		self.result.RiskviewAttributes.Version2.numnonderogs30 := if(doRVver2, ri.version2.num_nonderogs30, 0);
		self.result.RiskviewAttributes.Version2.numnonderogs90 := if(doRVver2, ri.version2.num_nonderogs90, 0);
		self.result.RiskviewAttributes.Version2.numnonderogs180 := if(doRVver2, ri.version2.num_nonderogs180, 0);
		self.result.RiskviewAttributes.Version2.numnonderogs12 := if(doRVver2, ri.version2.num_nonderogs12, 0);
		self.result.RiskviewAttributes.Version2.numnonderogs24 := if(doRVver2, ri.version2.num_nonderogs24, 0);
		self.result.RiskviewAttributes.Version2.numnonderogs36 := if(doRVver2, ri.version2.num_nonderogs36, 0);
		self.result.RiskviewAttributes.Version2.numnonderogs60 := if(doRVver2, ri.version2.num_nonderogs60, 0);
		
		self.result.RiskviewAttributes.Version2.numproflic := if(doRVver2, ri.version2.num_proflic, 0);
		self.result.RiskviewAttributes.Version2.datelastproflic := if(doRVver2, ri.version2.date_last_proflic, 0);
		self.result.RiskviewAttributes.Version2.proflictype := if(doRVver2, ri.version2.proflic_type, '');
		self.result.RiskviewAttributes.Version2.expiredatelastproflic := if(doRVver2, ri.version2.expire_date_last_proflic, 0);
		
		self.result.RiskviewAttributes.Version2.numproflic30 := if(doRVver2, ri.version2.num_proflic30, 0);
		self.result.RiskviewAttributes.Version2.numproflic90 := if(doRVver2, ri.version2.num_proflic90, 0);
		self.result.RiskviewAttributes.Version2.numproflic180 := if(doRVver2, ri.version2.num_proflic180, 0);
		self.result.RiskviewAttributes.Version2.numproflic12 := if(doRVver2, ri.version2.num_proflic12, 0);
		self.result.RiskviewAttributes.Version2.numproflic24 := if(doRVver2, ri.version2.num_proflic24, 0);
		self.result.RiskviewAttributes.Version2.numproflic36 := if(doRVver2, ri.version2.num_proflic36, 0);
		self.result.RiskviewAttributes.Version2.numproflic60 := if(doRVver2, ri.version2.num_proflic60, 0);
		
		self.result.RiskviewAttributes.Version2.numproflicexp30 := if(doRVver2, ri.version2.num_proflic_exp30, 0);
		self.result.RiskviewAttributes.Version2.numproflicexp90 := if(doRVver2, ri.version2.num_proflic_exp90, 0);
		self.result.RiskviewAttributes.Version2.numproflicexp180 := if(doRVver2, ri.version2.num_proflic_exp180, 0);
		self.result.RiskviewAttributes.Version2.numproflicexp12 := if(doRVver2, ri.version2.num_proflic_exp12, 0);
		self.result.RiskviewAttributes.Version2.numproflicexp24 := if(doRVver2, ri.version2.num_proflic_exp24, 0);
		self.result.RiskviewAttributes.Version2.numproflicexp36 := if(doRVver2, ri.version2.num_proflic_exp36, 0);
		self.result.RiskviewAttributes.Version2.numproflicexp60 := if(doRVver2, ri.version2.num_proflic_exp60, 0);
		
		
		// populate the fields that have an '_' in the field name
		self.result.RiskviewAttributes.Version3.mobilityindicator := if(doRVver3, ri.version3.mobility_indicator, '');
		
		self.result.RiskviewAttributes.Version3.propertyownedtotal := if(doRVver3, ri.version3.property_owned_total, 0);
		self.result.RiskviewAttributes.Version3.propertyownedassessedtotal := if(doRVver3, ri.version3.property_owned_assessed_total, 0);
		self.result.RiskviewAttributes.Version3.propertyhistoricallyowned := if(doRVver3, ri.version3.property_historically_owned, 0);

		self.result.RiskviewAttributes.Version3.wealthindicator := if(doRVver3, ri.version3.wealth_indicator, '');

		self.result.RiskviewAttributes.Version3.totalnumberderogs := if(doRVver3, ri.version3.total_number_derogs, 0);

		self.result.RiskviewAttributes.Version3.numliens := if(doRVver3, ri.version3.num_liens, 0);
		self.result.RiskviewAttributes.Version3.numunreleasedliens := if(doRVver3, ri.version3.num_unreleased_liens, 0);
		self.result.RiskviewAttributes.Version3.numunreleasedliens30 := if(doRVver3, ri.version3.num_unreleased_liens30, 0);
		self.result.RiskviewAttributes.Version3.numunreleasedliens90 := if(doRVver3, ri.version3.num_unreleased_liens90, 0);
		self.result.RiskviewAttributes.Version3.numunreleasedliens180 := if(doRVver3, ri.version3.num_unreleased_liens180, 0);
		self.result.RiskviewAttributes.Version3.numunreleasedliens12 := if(doRVver3, ri.version3.num_unreleased_liens12, 0);
		self.result.RiskviewAttributes.Version3.numunreleasedliens24 := if(doRVver3, ri.version3.num_unreleased_liens24, 0);
		self.result.RiskviewAttributes.Version3.numunreleasedliens36 := if(doRVver3, ri.version3.num_unreleased_liens36, 0);
		self.result.RiskviewAttributes.Version3.numunreleasedliens60 := if(doRVver3, ri.version3.num_unreleased_liens60, 0);
		
		self.result.RiskviewAttributes.Version3.numreleasedliens := if(doRVver3, ri.version3.num_released_liens, 0);
		self.result.RiskviewAttributes.Version3.numreleasedliens30 := if(doRVver3, ri.version3.num_released_liens30, 0);
		self.result.RiskviewAttributes.Version3.numreleasedliens90 := if(doRVver3, ri.version3.num_released_liens90, 0);
		self.result.RiskviewAttributes.Version3.numreleasedliens180 := if(doRVver3, ri.version3.num_released_liens180, 0);
		self.result.RiskviewAttributes.Version3.numreleasedliens12 := if(doRVver3, ri.version3.num_released_liens12, 0);
		self.result.RiskviewAttributes.Version3.numreleasedliens24 := if(doRVver3, ri.version3.num_released_liens24, 0);
		self.result.RiskviewAttributes.Version3.numreleasedliens36 := if(doRVver3, ri.version3.num_released_liens36, 0);
		self.result.RiskviewAttributes.Version3.numreleasedliens60 := if(doRVver3, ri.version3.num_released_liens60, 0);
		
		self.result.RiskviewAttributes.Version3.bankruptcycount := if(doRVver3, ri.version3.bankruptcy_count, 0);
		self.result.RiskviewAttributes.Version3.filingtype := if(doRVver3, ri.version3.filing_type, '');
		self.result.RiskviewAttributes.Version3.bankruptcycount30 := if(doRVver3, ri.version3.bankruptcy_count30, 0);
		self.result.RiskviewAttributes.Version3.bankruptcycount90 := if(doRVver3, ri.version3.bankruptcy_count90, 0);
		self.result.RiskviewAttributes.Version3.bankruptcycount180 := if(doRVver3, ri.version3.bankruptcy_count180, 0);
		self.result.RiskviewAttributes.Version3.bankruptcycount12 := if(doRVver3, ri.version3.bankruptcy_count12, 0);
		self.result.RiskviewAttributes.Version3.bankruptcycount24 := if(doRVver3, ri.version3.bankruptcy_count24, 0);
		self.result.RiskviewAttributes.Version3.bankruptcycount36 := if(doRVver3, ri.version3.bankruptcy_count36, 0);
		self.result.RiskviewAttributes.Version3.bankruptcycount60 := if(doRVver3, ri.version3.bankruptcy_count60, 0);
		
		self.result.RiskviewAttributes.Version3.evictioncount := if(doRVver3, ri.version3.eviction_count, 0);
		self.result.RiskviewAttributes.Version3.evictioncount30 := if(doRVver3, ri.version3.eviction_count30, 0);
		self.result.RiskviewAttributes.Version3.evictioncount90 := if(doRVver3, ri.version3.eviction_count90, 0);
		self.result.RiskviewAttributes.Version3.evictioncount180 := if(doRVver3, ri.version3.eviction_count180, 0);
		self.result.RiskviewAttributes.Version3.evictioncount12 := if(doRVver3, ri.version3.eviction_count12, 0);
		self.result.RiskviewAttributes.Version3.evictioncount24 := if(doRVver3, ri.version3.eviction_count24, 0);
		self.result.RiskviewAttributes.Version3.evictioncount36 := if(doRVver3, ri.version3.eviction_count36, 0);
		self.result.RiskviewAttributes.Version3.evictioncount60 := if(doRVver3, ri.version3.eviction_count60, 0);

		self.result.RiskviewAttributes.Version3.numnonderogs := if(doRVver3, ri.version3.num_nonderogs, 0);
		self.result.RiskviewAttributes.Version3.numnonderogs30 := if(doRVver3, ri.version3.num_nonderogs30, 0);
		self.result.RiskviewAttributes.Version3.numnonderogs90 := if(doRVver3, ri.version3.num_nonderogs90, 0);
		self.result.RiskviewAttributes.Version3.numnonderogs180 := if(doRVver3, ri.version3.num_nonderogs180, 0);
		self.result.RiskviewAttributes.Version3.numnonderogs12 := if(doRVver3, ri.version3.num_nonderogs12, 0);
		self.result.RiskviewAttributes.Version3.numnonderogs24 := if(doRVver3, ri.version3.num_nonderogs24, 0);
		self.result.RiskviewAttributes.Version3.numnonderogs36 := if(doRVver3, ri.version3.num_nonderogs36, 0);
		self.result.RiskviewAttributes.Version3.numnonderogs60 := if(doRVver3, ri.version3.num_nonderogs60, 0);
		
		self.result.RiskviewAttributes.Version3.numproflic := if(doRVver3, ri.version3.num_proflic, 0);
		self.result.RiskviewAttributes.Version3.proflictype := if(doRVver3, ri.version3.proflic_type, '');
		self.result.RiskviewAttributes.Version3.expiredatelastproflic := if(doRVver3, ri.version3.expire_date_last_proflic, '');
		
		self.result.RiskviewAttributes.Version3.numproflic30 := if(doRVver3, ri.version3.num_proflic30, 0);
		self.result.RiskviewAttributes.Version3.numproflic90 := if(doRVver3, ri.version3.num_proflic90, 0);
		self.result.RiskviewAttributes.Version3.numproflic180 := if(doRVver3, ri.version3.num_proflic180, 0);
		self.result.RiskviewAttributes.Version3.numproflic12 := if(doRVver3, ri.version3.num_proflic12, 0);
		self.result.RiskviewAttributes.Version3.numproflic24 := if(doRVver3, ri.version3.num_proflic24, 0);
		self.result.RiskviewAttributes.Version3.numproflic36 := if(doRVver3, ri.version3.num_proflic36, 0);
		self.result.RiskviewAttributes.Version3.numproflic60 := if(doRVver3, ri.version3.num_proflic60, 0);
		
		self.result.RiskviewAttributes.Version3.numproflicexp30 := if(doRVver3, ri.version3.num_proflic_exp30, 0);
		self.result.RiskviewAttributes.Version3.numproflicexp90 := if(doRVver3, ri.version3.num_proflic_exp90, 0);
		self.result.RiskviewAttributes.Version3.numproflicexp180 := if(doRVver3, ri.version3.num_proflic_exp180, 0);
		self.result.RiskviewAttributes.Version3.numproflicexp12 := if(doRVver3, ri.version3.num_proflic_exp12, 0);
		self.result.RiskviewAttributes.Version3.numproflicexp24 := if(doRVver3, ri.version3.num_proflic_exp24, 0);
		self.result.RiskviewAttributes.Version3.numproflicexp36 := if(doRVver3, ri.version3.num_proflic_exp36, 0);
		self.result.RiskviewAttributes.Version3.numproflicexp60 := if(doRVver3, ri.version3.num_proflic_exp60, 0);
		
		self.result.RiskviewAttributes.Version2 := if(doRVver2, ri.version2);
		self.result.RiskviewAttributes.Version3 := if(doRVver3, ri.version3);
	
		self := le;
	end;
	wRV := join(wIEclam, rvFinal, left.result.bocashell.Version3.seq=right.seq, getFA(left,right), left outer);
	
	output(wRV, named('Results'));
ENDMACRO;
// ISS.ISS_FCRA_Service();