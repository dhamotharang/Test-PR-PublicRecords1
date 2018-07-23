/*--SOAP--
<message name="ConsumerAttributes_Service">
	<part name="ConsumerAttributesReportRequest" type="tns:XmlDataSet" cols="110" rows="50" />
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="25"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DataPermissionMask" type="xsd:string"/>
	<part name="ReturnFlatLayout" type="xsd:Boolean" />
</message>
*/

/*--INFO-- ConsumerAttributes - Realtime Service */
/*--HELP--
<pre>
ConsumerAttributesReportRequest XML:

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
		&ltLexId&gt&lt/LexId&gt 
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


import risk_indicators, ut, iesp, address, riskwise, seed_files, gateway, OFAC_XG5;

export ConsumerAttributes_Service := MACRO


	// Get XML input 
	ds_in    		:= dataset([], iesp.consumerattributesreport.t_ConsumerAttributesReportRequest)  	: stored('ConsumerAttributesReportRequest', few);
  unsigned1 ofac_version_      := 1        : stored('OFACVersion');
	gateways_in := Gateway.Configuration.Get();

	optionsIn 	:= ds_in[1].options;
	userIn 			:= ds_in[1].user;
	
	INTEGER3 history_date 						:= if(optionsIn.historyDateYYYYMM=0, 999999, optionsIn.historyDateYYYYMM);
  // can't have duplicate definitions for the Stored value DataRestrictionMask, 
	// so we need workaround to check if datarestriction stored is the global default
	// if restriction=global default of '1    0', then use risk_indicators default instead
	STRING50 outOfBandDataRestriction_temp := AutoStandardI.GlobalModule().DataRestrictionMask;
	STRING50 outOfBandDataRestriction := if(outOfBandDataRestriction_temp=AutoStandardI.Constants.DataRestrictionMask_default, risk_indicators.iid_constants.default_DataRestriction, outOfBandDataRestriction_temp);
  STRING50 DataRestrictionMask := IF(TRIM(userIn.DataRestrictionMask) <> '', userIn.DataRestrictionMask, outOfBandDataRestriction);
  STRING50 outOfBandDataPermission 	:= '' : STORED('DataPermissionMask');
	DataPermission 	  								:= MAP(	TRIM(userIn.DataPermissionMask) <> ''    => userIn.DataPermissionMask,
																						TRIM(outOfBandDataPermission)   <> ''    => outOfBandDataPermission,
																						Risk_Indicators.iid_constants.default_DataPermission); 
	
	STRING20 AccountNumber 	:= ds_in[1].searchby.AccountNumber;													 
	TestDataEnabled 				:= userIn.TestDataEnabled;
	TestDataTableName 			:= userIn.TestDataTableName;
	
	AdlBasedShell		:= optionsIn.AdlBasedShell;

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
	
	DPPA := map(  isLeadIntegrity => 0,
								userIn.DLPurpose='' => 0,
								(unsigned1)userIn.DLPurpose);
	GLBA := map(	isLeadIntegrity => 5,
								userIn.GLBPurpose='' 	=> 8, 
								(unsigned1)userIn.GLBPurpose);
								
	RemoveFares	:= if(isLeadIntegrity, true, optionsIn.RemoveFares);
			
	temp := record
		dataset(iesp.share.t_StringArrayItem) WatchList {xpath('WatchList/Name'), MAXCOUNT(iesp.Constants.MaxCountWatchLists)};
	end;
	watchlist_options := dataset([],temp);
	watchlists_request := watchlist_options[1].WatchList;
		
	// Do Not Allow Targus Gateway To Come In
	gateways := gateways_in(~Gateway.Configuration.IsTargus(servicename));
			
	layout_acctseq := record
		integer4 seq;
		ds_in;
	end;
	wseq := project( ds_in, transform( layout_acctseq, self.seq := counter, self := left ) );
		
	// IID and Boca Shell
	Risk_Indicators.Layout_Input into(wseq l) := TRANSFORM
		self.did := (integer)l.searchby.LexId;
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

	boolean 	 isFCRA							:= false;
	boolean   isUtility 					:= userIn.industryClass = 'UTILI';
	boolean   require2ele         := false;
	boolean   isLn                := false; // not needed anymore
	boolean	 	no_rel 							:= false;
	boolean   doDL                := true;
	boolean   doVehicle           := true;
	boolean   doDerogs            := true;
	boolean   ofacOnly            := true;
	boolean   suppressNearDups    := false;
	boolean   fromBIID            := false;
	boolean   excludeWatchlists   := false;
	boolean   fromIT1O            := false;
	unsigned1 OFACVersion 				:= ofac_version_;
	real      watchlist_threshold := if(OFACVersion in [1, 2, 3], 0.84, 0.85);
	boolean   usedobFilter 				:= false;
	integer2  dob_radius 					:= -1;	
	boolean   includeOfac := if(OFACVersion = 1, false, true);
	boolean   includeAddWatchlists:= false;
	boolean   nugen               := true;
	boolean   doScore 						:= true;
	boolean 	 runSSNCodes 				:= true;
	boolean   runBestAddr 				:= true;
	boolean   runChronoPhone 			:= true;
	boolean   runAreaCodeSplit 		:= true;
	boolean   allowCellPhones 		:= false;
	string10  ExactMatchLevel 		:= Risk_Indicators.iid_constants.default_ExactMatchLevel;
	string10  CustomDataFilter 		:= '';
	boolean   IncludeDLverification := false;
	DOBMatchOptions := dataset([], risk_indicators.layouts.layout_dob_match_options);
	unsigned2 EverOccupant_PastMonths := 0;
	unsigned4 EverOccupant_StartDate  := 99999999;
	unsigned1 AppendBest 					:= 1;	// search the best file
	unsigned8 BSOptions 					:= risk_indicators.iid_constants.BSOptions.DIDRIDSearchOnly;

IF( OFACVersion != 4 AND OFAC_XG5.constants.wlALLV4 IN SET(watchlists_request, value),
   FAIL( OFAC_XG5.Constants.ErrorMsg_OFACversion ) );

////////////////////////////////////////////////////////////			
	iid(unsigned1 bsversion) := risk_indicators.InstantID_Function(iid_prep, 
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
															DataRestrictionMask, 
															CustomDataFilter, 
															IncludeDLverification, 
															watchlists_request, 
															DOBMatchOptions,
															EverOccupant_PastMonths, 
															EverOccupant_StartDate, 
															AppendBest,
															BSOptions,
															in_DataPermission:=DataPermission);
														
																							
																										
	clam(unsigned1 bsversion) := risk_indicators.Boca_Shell_Function(	iid(bsversion), 
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
															DataRestrictionMask,
															DataPermission:=DataPermission);
																
	adlBasedClam(unsigned1 bsversion) := risk_indicators.ADL_Based_Modeling_Function(iid_prep,
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
															DataRestriction:=DataRestrictionMask,
															DataPermission:=DataPermission);
																	

	finalClam(unsigned1 bsversion) := if(ADLBasedShell, adlBasedClam(bsversion), clam(bsversion));

  clamTestSeeds := ISS.CAR_Test_Seed_Function(test_prep, ds_in[1].searchby.accountNumber, TestDataTableName, IsFCRA);
	clamOrSeed(unsigned1 bsversion) := if( TestDataEnabled, group(clamTestSeeds, seq), finalClam(bsversion));										

	bsversion := MAX(attributesIn, attributesIn.bsversion);

	clamAndSeed := clamOrSeed(bsversion);
  
  if( OFACVersion = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

	bocaV4 		:= UNGROUP(ISS.AttributesBocaV4.toAttributesBocaV4(clamAndSeed, isFCRA, DataRestrictionMask, AccountNumber));
	bocaV3 		:= UNGROUP(ISS.AttributesBocaV4.toAttributesBocaV4(clamAndSeed, isFCRA, DataRestrictionMask, AccountNumber)); // these are the same because I don't currently have a V3 edina layout
	// no riskview attributes in the non-fcra version
	// PreScreenOptOut := risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, clamAndSeed[1].iid.iid_flags );	
	// attrRaw := Models.getRVAttributes(clamAndSeed, AccountNumber, false,  false, DataRestrictionMask);
	// attr := project(attrRaw, TRANSFORM(ISS.AttributesRiskViewV4.Layout_rvAttrSeq, self := left) );
//	rvAttrV3 	:= UNGROUP(ISS.AttributesRiskViewV3.toAttributesRiskViewV3(attr));
//	rvAttrV4 	:= UNGROUP(ISS.AttributesRiskViewV4.toAttributesRiskViewV4(attr));
	
	iesp.fcraconsumerattributesreport.t_FCRAConsumerAttributesReportGroup process_groups(attributesIn le) := TRANSFORM				
			self.Name := le.attr;
			self.Attributes := CASE( le.attr,
																'bocashellattrv3' => bocaV3, // this isn't active yet, but serves as a placeholder.
																'bocashellattrv4' => bocaV4
					);
	end;
	
	attributes := project(attributesIn, process_groups(LEFT));

 iesp.consumerattributesreport.t_ConsumerAttributesReportResponse build_result(DATASET(iesp.consumerattributesreport.t_CARAttributeGroup) le) := TRANSFORM
		self._Header := [];
		self.Result.InputEcho := ds_in[1].searchby;
		self.Result.AttributeGroups := le;
		self.Result := [];
 end;
 
	res := ROW(build_result( attributes));
	
	output(res, named('Results'));
ENDMACRO;
//ISS.ConsumerAttributes_Service();
