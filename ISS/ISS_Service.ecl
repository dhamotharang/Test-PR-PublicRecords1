/*--SOAP--
<message name="ISS_Service">
	<part name="InsuranceScoringServiceRequest" type="tns:XmlDataSet" cols="80" rows="50" />
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="4"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DataPermissionMask" type="xsd:string"/>
</message>
*/
/*--INFO-- Boca Shell for Insurance real-time service */
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
	  &ltRemoveFares&gtfalse&lt/RemoveFares&gt 
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


export ISS_Service := MACRO

	import risk_indicators, ut, iesp, address, seed_files, models, dma, doxie, riskwise, gateway, OFAC_XG5;

	// Get XML input 
	ds_in    	:= dataset([], iesp.issservice.t_InsuranceScoringServiceRequest)  	: stored('InsuranceScoringServiceRequest', few);
  unsigned1 ofac_version_      := 1        : stored('OFACVersion');
	gateways_in := Gateway.Configuration.Get();

	optionsIn := ds_in[1].options;
	userIn := ds_in[1].user;
	
	history_date 		:= if(optionsIn.historyDateYYYYMM=0, 999999, optionsIn.historyDateYYYYMM);
  // can't have duplicate definitions for the Stored value DataRestrictionMask, 
	// so we need workaround to check if datarestriction stored is the global default
	// if restriction=global default of '1    0', then use risk_indicators default instead
	STRING50 outOfBandDataRestriction_temp := AutoStandardI.GlobalModule().DataRestrictionMask;
	STRING50 outOfBandDataRestriction := if(outOfBandDataRestriction_temp=AutoStandardI.Constants.DataRestrictionMask_default, risk_indicators.iid_constants.default_DataRestriction, outOfBandDataRestriction_temp);
  STRING DataRestriction := IF(TRIM(userIn.DataRestrictionMask) <> '', userIn.DataRestrictionMask, outOfBandDataRestriction);
  STRING50 outOfBandDataPermission := '' : STORED('DataPermissionMask');
	DataPermission 	  := MAP(TRIM(userIn.DataPermissionMask) <> ''       => userIn.DataPermissionMask,
                                  TRIM(outOfBandDataPermission) <> ''  => outOfBandDataPermission,
                                                                           Risk_Indicators.iid_constants.default_DataPermission); 

	bsversion 			:= optionsIn.bsVersion;	// version 1 is the original, 2 would add BS 2 fields and 3 will add BS 3 fields
	AdlBasedShell		:= optionsIn.AdlBasedShell;
	
	TestDataEnabled 	:= userIn.TestDataEnabled;
	TestDataTableName := userIn.TestDataTableName;
	
	
	
	attributesIn := optionsIn.RequestedAttributeGroups;
	
	// get input attributes
	layout_settings := {boolean LIver1:=false, boolean LIver3:=false, boolean Fraudver1:=false};
	
	layout_settings get_settings( ds_in le ) := TRANSFORM
		liIn := attributesIn(StringLib.StringToLowerCase(TRIM(Name)) = 'leadintegrity');
		fraudIn := attributesIn(StringLib.StringToLowerCase(TRIM(Name)) = 'fraud');
		
		self.LIver1 := if(liIn[1].Version = '1', true, false);
		self.LIver3 := if(liIn[1].Version = '3', true, false);
		self.Fraudver1 := if(fraudIn[1].Version = '1', true, false);
	END;
	settings 	:= project( ds_in[1], get_settings(left) );
	
	doLIver1 	:= settings.LIver1;
	doLIver3   := settings.LIver3;
	doFraudver1 := settings.Fraudver1;
	liVersion := map(doLIver1 => 1,
							doLIver3 => 3,
							0);
							


	
	// hard code GLB, DPPA and RemoveFares if ITA is chosen
	DPPA 			:= map(	doLIver1 or doLIver3 		=> 0,
								userIn.DLPurpose='' => 0, 
								(unsigned1)userIn.DLPurpose);
	GLBA 			:= map(	doLIver1 or doLIver3 			=> 5,
								userIn.GLBPurpose='' 	=> 8, 
								(unsigned1)userIn.GLBPurpose);
	RemoveFares	:= if(doLIver1 or doLIver3, true, optionsIn.RemoveFares);
	
	
	
	
	// get watchlist input - probably not used in this product but allow it anyway
	temp := record
		dataset(iesp.share.t_StringArrayItem) WatchList {xpath('WatchList/Name'), MAXCOUNT(iesp.Constants.MaxCountWatchLists)};
	end;
	watchlist_options := dataset([],temp);
	watchlists_request := watchlist_options[1].WatchList;
	
	
	// Do Not Allow Targus Gateway To Come In
	Gateway.Layouts.Config gw_switch(gateways_in le) := transform
		self.servicename := map(le.servicename = 'targus' => '',	// don't allow targus gateway
										le.servicename);
		self.url := map(	le.servicename = 'targus' => '',	// don't allow targus gateway
								le.url); 
		self := le;						
	end;
	gateways := project(gateways_in, gw_switch(left));
	

	
	layout_acctseq := record
		integer4 seq;
		ds_in;
	end;
	wseq := project( ds_in, transform( layout_acctseq, self.seq := counter, self := left ) );
	
	wseqcheck := if(bsVersion=0, FAIL(layout_acctseq, 'No Boca Shell version passed in'), wseq);	// if no bsversion passed in then fail
	
	
	// IID and Boca Shell
	risk_indicators.Layout_Input into(wseqcheck l) := TRANSFORM
		self.seq := l.seq;
		self.historydate := history_date;
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
	boolean 	 isFCRA					:= false;
	boolean   isUtility := 			userIn.industryClass = 'UTILI';
	boolean   require2ele         := false;
	boolean   isLn                := false; // not needed anymore
	boolean	 no_rel 					:= false;
	boolean   doDL                := true;
	boolean   doVehicle           := true;
	boolean   doDerogs            := true;
	boolean   ofacOnly            := true;
	boolean   suppressNearDups    := false;
	boolean   fromBIID            := false;
	boolean   excludeWatchlists   := false;
	boolean   fromIT1O            := false;
	unsigned1 OFACVersion 			:= ofac_version_;
	real      watchlist_threshold := if(OFACVersion in [1, 2, 3], 0.84, 0.85);
	boolean   usedobFilter 			:= false;
	integer2  dob_radius 			:= -1;	
	boolean   includeOfac         := if(OFACVersion = 1, false, true);
	boolean   includeAddWatchlists:= false;
	boolean   nugen               := true;
	boolean   doScore 				:= true;
	boolean 	 runSSNCodes 			:= true;
	boolean   runBestAddr 			:= true;
	boolean   runChronoPhone 		:= true;
	boolean   runAreaCodeSplit 	:= true;
	boolean   allowCellPhones 		:= false;
	string10  ExactMatchLevel 		:= Risk_Indicators.iid_constants.default_ExactMatchLevel;
	string10  CustomDataFilter 	:= '';
	boolean   IncludeDLverification := false;
	DOBMatchOptions := dataset([], risk_indicators.layouts.layout_dob_match_options);
	unsigned2 EverOccupant_PastMonths := 0;
	unsigned4 EverOccupant_StartDate  := 99999999;
	unsigned1 AppendBest := 1;	// search the best file

IF( OFACVersion != 4 AND OFAC_XG5.constants.wlALLV4 IN SET(watchlists_request, value),
    FAIL( OFAC_XG5.Constants.ErrorMsg_OFACversion ) );

	iid := risk_indicators.InstantID_Function(iid_prep, 
															gateways, 
															dppa, 
															glba, 
															isUtility, 
															isLN,
															ofacOnly,
															suppressNearDups,
															require2ele,
															isFCRA,
															fromBIID,
															ExcludeWatchLists,
															fromIT1O,
															OFACVersion,
															includeOfac,
															includeAddWatchlists,
															watchlist_threshold,
															dob_radius,
															bsversion, 
															runSSNCodes,
															runBestAddr,
															runChronoPhone,
															runAreaCodeSplit,
															allowCellPhones,
															ExactMatchLevel, 
															DataRestriction, 
															CustomDataFilter, 
															IncludeDLverification, 
															watchlists_request, 
															DOBMatchOptions,
															EverOccupant_PastMonths, 
															EverOccupant_StartDate, 
															AppendBest,
															in_DataPermission:=DataPermission);
														
																							
																										
	clam := risk_indicators.Boca_Shell_Function(	iid, 
																gateways, 
																DPPA, 
																GLBA, 
																isUtility,
																isLN,
																~no_rel, 
																doDL, 
																doVehicle, 
																doDerogs, 
																bsversion, 
																doScore, 
																nugen, 
																RemoveFares, 
																DataRestriction,
																DataPermission:=DataPermission);
																
	adlBasedClam := risk_indicators.ADL_Based_Modeling_Function(iid_prep,
																					gateways, 
																					dppa, 
																					glba, 
																					isFCRA,
																					bsversion, 
																					isUtility,
																					isLn,
																					ofacOnly,
																					suppressNearDups,
																					require2ele,
																					fromBIID,
																					excludeWatchLists,
																					fromIT1O,
																					ofacVersion,
																					includeOfac,
																					includeAddWatchlists,
																					watchlist_threshold,
																					dob_radius,
																					~no_rel,
																					doDL,
																					doVehicle, 
																					doDerogs, 
																					doScore, 
																					nugen,
																					DataRestriction:=DataRestriction,
																					DataPermission:=DataPermission);
																		

	finalClam := if(ADLBasedShell, adlBasedClam, clam);
  
  if( OFACVersion = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

	// get boca shell test seeds
	clamTestSeeds := Risk_Indicators.Boca_Shell_Test_Function(test_prep, ds_in[1].searchby.accountNumber, TestDataTableName, IsFCRA);
														
	// map the bocashell	into esdl names													
	mappedBocaShell := iss.getBocaShell(finalClam, datarestriction, TestDataEnabled, TestDataTableName, bsversion);
	
	// choose between real clam or testseed clam
	clamFinal := if(TestDataEnabled, group(clamTestSeeds,seq), mappedBocaShell);


	
		
	// Get Lead Integrity Attributes
	li := Models.get_LeadIntegrity_Attributes(finalClam, liVersion);
	// get Lead Integrity test seeds
	liTestSeeds := Models.LeadIntegrity_TestSeed_Function(test_prep, TestDataTableName, '', 0);

	
	

	//add the do not mail search -- if we get a hit, return just the flag and blank everything else out
	suppressed_do_not_mail := join(iid_prep, dma.key_DNM_Name_Address, 
												keyed(left.prim_name = right.l_prim_name) and
												keyed(left.prim_range = right.l_prim_range) and 
												keyed(left.st = right.l_st) and
												keyed(right.l_city_code in doxie.Make_CityCodes(left.p_city_name).rox) and 
												keyed(left.z5= right.l_zip) and 
												keyed(left.sec_range = right.l_sec_range) and 
												keyed(left.lname = right.l_lname) and
												keyed(left.fname = right.l_fname),
												 Transform(models.layouts.layout_LeadIntegrity_attributes_batch, self.DoNotMail := if(right.l_zip='', '0', '1'),
																	self.seq := (string)left.seq, self := []) 
												 , left outer, keep(1));

	with_dnm1 := join(li, suppressed_do_not_mail, left.seq=(string)right.seq,
									transform(models.layouts.layout_LeadIntegrity_attributes_batch, 
														self := if(right.DoNotMail='1', right, left) ) );

	with_dnm := if(doLIver1 or doLIver3, if(TestDataEnabled, liTestSeeds, with_dnm1), dataset([], models.layouts.layout_LeadIntegrity_attributes_batch));


	// get the IP data from netacuity outside the getFDattributes()
	ip_prepped := project( iid_prep, transform( riskwise.Layout_IPAI, self.seq := left.seq, self.ipaddr := left.ip_address ) );
	ip_gateway_response := risk_indicators.getNetAcuity( ip_prepped, gateways, DPPA, GLBA );
	
	// Get Fraud Attributes
	fraudAttr := Models.getFDAttributes(finalClam, iid, '', ip_gateway_response);
	// search for test seeds
	fraudAttrTestSeed := Risk_Indicators.FDAttributes_TestSeed_Function(test_prep, '', TestDataTableName);																						
	// choose either test seed or real
	fraudAttrFinal := if(doFraudver1, if(TestDataEnabled, fraudAttrTestSeed, ungroup(fraudAttr)), dataset([], Models.Layout_FraudAttributes));




	// Populate input echo and clam
	iesp.issservice.t_InsuranceScoringServiceResponse getIEclam(wseqcheck le, clamFinal ri) := transform
		self.result.bocashell.version3 := ri;
		
		self.result.inputecho := le.searchby;
		
		self.result.LeadIntegrityAttributes := [];
		self.result.fraudattributes := [];
		
		self._Header := [];	// does this need populating?
	end;
	wIEclam := join(wseqcheck, clamFinal, left.seq=right.seq, getIEclam(left,right));


	// Populate Lead Integrity Attributes
	iesp.issservice.t_InsuranceScoringServiceResponse intoClamLI(wIEclam le, with_dnm ri) := transform
		self.result.LeadIntegrityAttributes.Version3 := if(doLIver3, ri.version3);
		self.result.LeadIntegrityAttributes.Version1 := if(doLIver1, ri);
		self := le;
	end;
	wClamLI := join(wIEclam, with_dnm, left.result.bocashell.Version3.seq=(unsigned)right.seq, intoClamLI(left,right), left outer);



	// Populate Fraud Attributes
	iesp.issservice.t_InsuranceScoringServiceResponse getFA(wClamLI le, fraudAttrFinal ri) := transform
		// specifically map the fields that have an underscore in the name to match esdl name
		self.result.FraudAttributes.Version1.IAMEDHHINC := ri.version1.iamed_hhinc;
		self.result.FraudAttributes.Version1.IAMEDHVAL := ri.version1.iamed_hval;
		self.result.FraudAttributes.Version1.CAMEDHHINC := ri.version1.camed_hhinc;
		self.result.FraudAttributes.Version1.CAMEDHVAL := ri.version1.camed_hval;
		self.result.FraudAttributes.Version1.PAMEDHHINC := ri.version1.pamed_hhinc;
		self.result.FraudAttributes.Version1.PAMEDHVAL := ri.version1.pamed_hval;
		self.result.FraudAttributes.Version1.mobilityindicator := ri.version1.mobility_indicator;
		self.result.FraudAttributes.Version1 := ri.version1;
		self := le;
	end;
	wFraud := join(wClamLI, fraudAttrFinal, left.result.bocashell.Version3.seq=right.input.seq, getFA(left,right), left outer);
	
	output(wFraud, named('Results'));
	
	royalties := IF(doFraudver1 and ~TestDataEnabled, Royalty.RoyaltyNetAcuity.GetOnlineRoyalties(gateways, ip_prepped, ip_gateway_response));
	output(royalties,NAMED('RoyaltySet'));
ENDMACRO;
// ISS.ISS_Service();