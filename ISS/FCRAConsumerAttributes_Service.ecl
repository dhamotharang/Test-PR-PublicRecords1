/*--SOAP--
<message name="FCRAConsumerAttributes_Service">
	<part name="FCRAConsumerAttributesReportRequest" type="tns:XmlDataSet" cols="110" rows="50" />
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="25"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DataPermissionMask" type="xsd:string"/>
	<part name="ReturnFlatLayout" type="xsd:Boolean" />
</message>
*/

/*--INFO-- FCRAConsumerAttributes - Realtime Service */
/*--HELP--
<pre>
FCRAConsumerAttributesReportRequest XML:

&lt;dataset&gt;
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
	  &ltADLBasedShell&gtfalse&lt/ADLBasedShell&gt 
	  &ltRemoveFares&gtfalse&lt/RemoveFares&gt 
	  &ltHistoryDateYYYYMM&gt0&lt/HistoryDateYYYYMM&gt 
    &lt;RequestedAttributeGroups&gt;
       &lt;Name&gt;bocashellattrv4&lt;/Name&gt;
    &lt;/RequestedAttributeGroups&gt;
  &lt/Options&gt
  &ltSearchBy&gt
		&ltUniqueId&gt&lt/UniqueId&gt 
		&ltUniqueIdScore&gt&lt/UniqueIdScore&gt 
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
&lt;/dataset&gt;

*/


import risk_indicators, ut, iesp, address, riskwise, seed_files, gateway, Consumerstatement;

export FCRAConsumerAttributes_Service := MACRO
 #onwarning(4207, ignore);

	// Get XML input 
	ds_in    		:= dataset([], iesp.fcraconsumerattributesreport.t_FCRAConsumerAttributesReportRequest)  	: stored('FCRAConsumerAttributesReportRequest', few);
	gateways_in := Gateway.Configuration.Get();

	optionsIn 	:= ds_in[1].options;
	userIn 			:= ds_in[1].user;
	
  BOOLEAN OutputConsumerStatements := optionsIn.FFDOptionsMask[1] = '1';
  
	INTEGER3 history_date 						:= if(optionsIn.historyDateYYYYMM=0, 999999, optionsIn.historyDateYYYYMM);
	STRING50 outOfBandDataRestriction := '' : STORED('DataRestrictionMask');
	DataRestriction 	:= MAP(TRIM(userIn.DataRestrictionMask) <> ''       => userIn.DataRestrictionMask,
                                  TRIM(outOfBandDataRestriction) <> ''  => outOfBandDataRestriction,
                                                                           Risk_Indicators.iid_constants.default_DataRestriction); 
	STRING10 outOfBandDataPermission := Risk_Indicators.iid_constants.default_DataPermission : STORED('DataPermissionMask');
	DataPermission 	  := MAP(TRIM(userIn.DataPermissionMask) <> ''       => userIn.DataPermissionMask,
                                  TRIM(outOfBandDataPermission) <> ''  => outOfBandDataPermission,
                                                                           Risk_Indicators.iid_constants.default_DataPermission); 
	
	STRING20 AccountNumber 	:= ds_in[1].searchby.AccountNumber;													 
	TestDataEnabled 				:= userIn.TestDataEnabled;
	TestDataTableName 			:= userIn.TestDataTableName;
	
	AdlBasedShell		:= optionsIn.AdlBasedShell;
	boolean   FilterLiens := if(DataRestriction[risk_indicators.iid_constants.posLiensJudgRestriction]='1', true, false ); //DRM says don't run lnj or include is false so don't run lnj

	// compile list of attributes and the bs versions
	attribElt := RECORD
		string32 attr;
		integer  bsversion;
	end;

	attribElt getVersions(iesp.share.t_StringArrayItem le) := TRANSFORM
		attr := StringLib.StringToLowerCase(TRIM(le.Value));
		self.attr := attr;
		self.bsversion := CASE( attr,
															'bocashellattrv3' => 3,
															'bocashellattrv4' => 4,
															'riskviewattrv3'  => 3,
															'riskviewattrv4'  => 4,
													 0);
	end;			
	
	attributesIn := project(optionsIn.RequestedAttributeGroups, getVersions(left));

	isLeadIntegrity := exists(attributesIn(attr[1..9]='leadinteg'));
	
	// DPPA := map(  isLeadIntegrity => 0,
								// userIn.DLPurpose='' => 0,
								// (unsigned1)userIn.DLPurpose);
	// GLBA := map(	isLeadIntegrity => 5,
								// userIn.GLBPurpose='' 	=> 8, 
								// (unsigned1)userIn.GLBPurpose);
								
	RemoveFares	:= if(isLeadIntegrity, true, optionsIn.RemoveFares);
			
	temp := record
		dataset(iesp.share.t_StringArrayItem) WatchList {xpath('WatchList/Name'), MAXCOUNT(iesp.Constants.MaxCountWatchLists)};
	end;
	watchlist_options := dataset([],temp);
	watchlists_request := watchlist_options[1].WatchList;
		
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
		
	// IID and Boca Shell
	Risk_Indicators.Layout_Input into(wseq l) := TRANSFORM
		self.did := (integer)l.searchby.UniqueID;
		self.score := l.searchby.UniqueIdScore ;
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

	iid_prep := PROJECT(wseq, into(left));	

	risk_indicators.layout_input into_test_prep(wseq l) := transform
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
	test_prep := PROJECT(wseq, into_test_prep(LEFT));

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
	boolean   isPreScreen     := StringLib.StringToUpperCase(optionsIn.IntendedPurpose) = 'PRESCREENING';

	unsigned8 BSOptions 					:= risk_indicators.iid_constants.BSOptions.DIDRIDSearchOnly +
			if(FilterLiens, risk_indicators.iid_constants.BSOptions.FilterLiens, 0 );//DRM to drive Liens/Judgments
										
	clam(unsigned1 bsVersion) := Risk_Indicators.Boca_Shell_Function_FCRA(
		iid_prep, gateways, dppa, glba, isUtility, isLN,
		require2ele, doRelatives, doDL, doVehicle, doDerogs, ofacOnly,
		suppressNearDups, fromBIID, excludeWatchlists, fromIT1O,
		ofacVersion, includeOfac, includeAddWatchlists, watchlistThreshold,
			bsVersion, isPreScreen, doScore, ADL_Based_Shell:=false, datarestriction:=datarestriction, BSOptions:=BSOptions,
			datapermission:=datapermission
	);
	adl_clam(unsigned1 bsVersion) := Risk_Indicators.Boca_Shell_Function_FCRA(
		iid_prep, gateways, dppa, glba, isUtility, isLN,
		require2ele, doRelatives, doDL, doVehicle, doDerogs, ofacOnly,
		suppressNearDups, fromBIID, excludeWatchlists, fromIT1O,
		ofacVersion, includeOfac, includeAddWatchlists, watchlistThreshold,
		bsVersion, isPreScreen, doScore, ADL_Based_Shell:=true, datarestriction:=datarestriction, BSOptions:=BSOptions,
		datapermission:=datapermission
	);																										

	finalClam(unsigned1 bsversion) := if(ADLBasedShell, adl_clam(bsversion), clam(bsversion));

  clamTestSeeds := ISS.CAR_Test_Seed_Function(test_prep, ds_in[1].searchby.accountNumber, TestDataTableName, IsFCRA);
	clamOrSeed(unsigned1 bsversion) := if( TestDataEnabled, group(clamTestSeeds, seq), finalClam(bsversion));										

 attributesInSorted := sort(attributesIn, -bsversion);	
	bsversion := attributesInSorted[1].bsversion;	 
	
	clamAndSeed := clamOrSeed(bsversion);
	

	workingLayout := RECORD
		INTEGER seq;
		REAL4 score;
		STRING model := '';
	END;	
	
		WOMV002ModelResult :=  	 PROJECT(Models.WOMV002_0_0(UNGROUP(clamAndSeed)),TRANSFORM(workingLayout, SELF.seq := left.seq, SELF.score := left.score, SELF.model := 'WOMV002.0.0' )) ;
		MV3610060ModelResult :=  PROJECT(Models.MV361006_0_0(UNGROUP(clamAndSeed)),TRANSFORM(workingLayout, SELF.seq := left.seq, SELF.score := left.score, SELF.model := 'MV361006.0.0' )) ;
		MX3610060ModelResult :=  PROJECT(Models.MX361006_0_0(UNGROUP(clamAndSeed)),TRANSFORM(workingLayout, SELF.seq := left.seq, SELF.score := left.score, SELF.model := 'MX361006.0.0' )) ;
		MPX1211ModelResult := 	 PROJECT(Models.MPX1211_0_0(UNGROUP(clamAndSeed)),TRANSFORM(workingLayout, SELF.seq := left.seq, SELF.score := left.score, SELF.model := 'MPX1211.0.0' )) ;
		MNC21106ModelResult := 	 PROJECT(Models.MNC21106_0_0(UNGROUP(clamAndSeed)),TRANSFORM(workingLayout, SELF.seq := left.seq, SELF.score := left.score, SELF.model := 'MNC21106.0.0' )) ;
		RiskViewModelResult :=  PROJECT(UNGROUP(Models.RVR611_0_0(clamAndSeed, FALSE)),TRANSFORM(workingLayout, SELF.seq := left.seq, SELF.score := (real4)left.score, SELF.model := 'RVR611.0.0' )) ;

		AllModelScores := SORT(WOMV002ModelResult + MV3610060ModelResult +  MX3610060ModelResult +  
													MPX1211ModelResult + MNC21106ModelResult + RiskViewModelResult, seq, model);
	


	PreScreenOptOut := risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, clamAndSeed[1].iid.iid_flags );	
	attrRaw := Models.getRVAttributes(clamAndSeed, AccountNumber, isPreScreen,  if(isPrescreen, PreScreenOptOut, false), datarestriction);
	attr := project(attrRaw, TRANSFORM(Models.Layout_RVAttributes.Layout_rvAttrSeq, self := left) );
	
	bocaV4TEMP 		:= UNGROUP(ISS.AttributesBocaV4.toAttributesBocaV4(clamAndSeed, isFCRA, datarestriction, AccountNumber));
	bocaV3TEMP 		:= UNGROUP(ISS.AttributesBocaV4.toAttributesBocaV4(clamAndSeed, isFCRA, datarestriction, AccountNumber)); // these are the same because I don't currently have a V3 edina layout
	rvAttrV3TEMP 	:= UNGROUP(ISS.AttributesRiskViewV3.toAttributesRiskViewV3(attr));
	rvAttrV4TEMP 	:= UNGROUP(ISS.AttributesRiskViewV4.toAttributesRiskViewV4(attr));
	
	// add Model scores
	
	iesp.consumerattributesreport.t_NameValuePairLong convertNVP( AllModelScores le, integer c) := TRANSFORM
	
		self.name := case(le.model,
			'MNC21106.0.0' => 'MNC21106', 
			'MPX1211.0.0' => 'MPX1211', 
			'MV361006.0.0' => 'MV361006', 
			'MX361006.0.0' => 'MX361006', 
			'RVR611.0.0' => 'RVR611', 
			'WOMV002.0.0' => 'WOMV002', 
			'Invalid');

		self.value := (string)le.score;		
			 
	END;
	
	MVRNameValuePairsTEMP := project(AllModelScores, convertNVP(LEFT, COUNTER));
	
	bocaV3 :=  bocaV3TEMP;
	bocaV4  := bocaV4TEMP +  MVRNameValuePairsTEMP;
	rvAttrV3  :=  rvAttrV3TEMP;
	rvAttrV4  :=  rvAttrV4TEMP + MVRNameValuePairsTEMP;
	
	iesp.fcraconsumerattributesreport.t_FCRAConsumerAttributesReportGroup process_groups(attributesIn le) := TRANSFORM				
			self.Name := le.attr;
			self.Attributes := CASE( le.attr,
																'bocashellattrv3' => bocaV3, // this isn't active yet, but serves as a placeholder.
																'bocashellattrv4' => bocaV4,
																'riskviewattrv3'  => rvAttrV3,
																'riskviewattrv4'  => rvAttrV4
					);
	end;

	attributes := project(attributesIn, process_groups(LEFT));

	consumer_statements := project(clamandseed[1].ConsumerStatements, transform(iesp.share_fcra.t_ConsumerStatement, self.dataGroup := '', self := left));
        
 iesp.fcraconsumerattributesreport.t_FCRAConsumerAttributesReportResponse build_result( DATASET(iesp.FCRAconsumerattributesreport.t_FCRAConsumerAttributesReportGroup) le,
                                                                                        DATASET(iesp.share_fcra.t_ConsumerStatement) rt
 ) := TRANSFORM
		self._Header := [];
		self.Result.InputEcho := ds_in[1].searchby;
		self.Result.AttributeGroups := le;
		
    self.Result.ConsumerStatements := rt;	
    // for inquiry logging, populate the Consumer.LexID.  if the person is a noScore, don't log the LexID
    self.Result.Consumer.LexID := if(riskview.constants.noscore(clamandseed[1].iid.nas_summary,clamandseed[1].iid.nap_summary, clamandseed[1].address_verification.input_address_information.naprop, clamandseed[1].truedid), 
        '', 
        (string12)clamandseed[1].did); 
		self.Result := [];
 end;
 
	res := ROW(build_result( attributes, consumer_statements ));
	
	output(res, named('Results'));
ENDMACRO;
