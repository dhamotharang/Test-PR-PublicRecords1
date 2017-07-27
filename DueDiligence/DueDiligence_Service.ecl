IMPORT AutoStandardI, DueDiligence, Gateway, iesp;   //, WSInput;

EXPORT DueDiligence_Service := MACRO

	//The following macro defines the field sequence on WsECL page of query.
  // WSInput.MAC_DueDiligence_Service();

	// Get XML input 
	requestIn := DATASET([], iesp.duediligencereport.t_DueDiligenceReportRequest)  	: STORED('DueDiligenceReportRequest', few);
	
	firstRow := requestIn[1] : INDEPENDENT; // Since this is realtime AND not batch, should only have one row on input.

	optionsIn 	:= GLOBAL(firstRow.options);
	userIn 			:= GLOBAL(firstRow.user);
	search 			:= GLOBAL(firstRow.SearchBy);
		
	//gateways				:= Gateway.Configuration.Get();
	
	
	DPPA := 	(UNSIGNED1)userIn.DLPurpose;
	GLBA := 	(UNSIGNED1)userIn.GLBPurpose;	
	
	attribsVersionUC := TRIM(StringLib.StringToUpperCase(optionsIn.AttributesVersionRequest));
	attributesVersion := MAP(attribsVersionUC = DueDiligence.Constants.BUS_REQ_ATTRIBUTE_V3 => DueDiligence.Constants.BUSINESS_V3, 	 	
														attribsVersionUC = DueDiligence.Constants.IND_REQ_ATTRIBUTE_V3 => DueDiligence.Constants.INDIVIDUAL_V3, 								
														DueDiligence.Constants.INVALID);
	
	
	// INTEGER3 history_date :=  IF((INTEGER3)(optionsIn.historyDateYYYYMM) <> 0, (INTEGER3)optionsIn.historyDateYYYYMM, 999999);
															
	// STRING50 DataRestrictionMask := IF(TRIM(userIn.DataRestrictionMask) <> '', userIn.DataRestrictionMask, AutoStandardI.GlobalModule().DataRestrictionMask);																					
  // STRING50 DataPermissionMask := IF(TRIM(userIn.DataPermissionMask) <> '', userIn.DataPermissionMask, Risk_Indicators.iid_constants.default_DataPermission);

	// BOOLEAN IncludeNewsProfile := ~optionsIn.ExcludeNewsAttributes;
	
	// '0' - do not call XG5
	// '1' - full XG5 response will be returned for DD report
	// '2' - Call Bridger XG5 for KRIs but not full response
	// '3' - Call Bridger XG4 for KRIs but not full response

	//Do not want XG5 call yet, continue to call XG4. for future
	// UseXG5 := IF(length(gateways(TRIM(ServiceName, LEFT,RIGHT) = Gateway.Constants.ServiceName.bridgerxg5)) > 0,  '2', '3'); 
	// UseXG5 := '3'; 
		 
						 
	// TestDataEnabled 				:= userIn.TestDataEnabled;
	// TestDataTableName 			:= TRIM(userIn.TestDataTableName);
	
	
  
	// INTEGER bsversion := 50;
	
	// IncludeNegativeNews := FALSE; // should never be called
	
			
	
  

	BOOLEAN IndFNamePopulated		  := TRIM(search.Individual.name.full) <> '' OR TRIM(search.Individual.name.first) <> '';
	BOOLEAN IndFLastPopulated	  	:= TRIM(search.Individual.name.full) <> '' OR TRIM(search.Individual.name.last) <> '';
	BOOLEAN IndFAddrPopulated		  := TRIM(search.Individual.address.streetaddress1) <> '' OR (TRIM(search.Individual.address.streetnumber) <> '' AND TRIM(search.Individual.address.streetname) <> '');
	BOOLEAN IndCityStatePopulated := TRIM(search.Individual.address.city) <> '' AND TRIM(search.Individual.address.state) <> '';
	BOOLEAN IndZipPopulated		    := TRIM(search.Individual.address.zip5) <> '';
	BOOLEAN IndSSNPopulated		    := TRIM(search.Individual.ssn) <> '';

	BOOLEAN BusNamePopulated		  := TRIM(search.Business.CompanyName) <> '' OR TRIM(search.Business.AlternateCompanyName) <> '';
	BOOLEAN BusAddrPopulated		  := TRIM(search.Business.address.streetaddress1) <> '' OR (TRIM(search.Business.address.streetnumber) <> '' AND TRIM(search.Business.address.streetname) <> '');
	BOOLEAN BusCityStatePopulated := TRIM(search.Business.address.city) <> '' AND TRIM(search.Business.address.state) <> '';
	BOOLEAN BusZipPopulated		    := TRIM(search.Business.address.zip5) <> '';
	BOOLEAN BusTaxIDPopulated		  := TRIM(search.Business.FEIN) <> '';
	
	BOOLEAN LexIDPopulated		  	:= TRIM(search.Individual.UniqueId) <> '';
	BOOLEAN BDIDPopulated	  	  	:= TRIM(search.Business.BusinessId) <> '';
	BOOLEAN ValidDPPA		  				:= TRIM(userIn.DLPurpose) <> '' AND (DPPA BETWEEN 0 AND 7);
	BOOLEAN ValidGLB	  					:= TRIM(userIn.GLBPurpose) <> ''  AND (GLBA BETWEEN 0 AND 7 OR GLBA = 11 OR GLBA = 12);

	setValidIndAttributeVersions := [DueDiligence.Constants.INDIVIDUAL_V3];
	setValidBusAttributeVersions := [DueDiligence.Constants.BUSINESS_V3];
	
	BOOLEAN ValidIndividual :=  IF((IndFNamePopulated AND IndFLastPopulated AND IndFAddrPopulated AND (IndCityStatePopulated OR IndSSNPopulated)) OR (IndFNamePopulated AND IndFLastPopulated AND IndSSNPopulated) OR LexIDPopulated, TRUE, FALSE);
	BOOLEAN ValidBusiness :=  IF((BusNamePopulated AND BusAddrPopulated AND (BusCityStatePopulated OR BusZipPopulated)) OR (BusNamePopulated AND BusTaxIDPopulated) OR BDIDPopulated, TRUE, FALSE);
	BOOLEAN RequestInvalid :=  IF(attributesVersion = DueDiligence.Constants.INVALID, TRUE, FALSE);
	BOOLEAN PermissionGLB := IF(ValidGLB,  TRUE, FALSE);
	BOOLEAN PermissionDPPA := IF(ValidDPPA, TRUE, FALSE);

	IF(attributesVersion IN setValidIndAttributeVersions AND NOT ValidIndividual, FAIL( 'Minimum input information not met. Minimum input information is: \n (1)  First Name, Last Name, Street Address, City and State or Zip  OR \n (2)  First Name, Last Name, SSN  OR \n (3)  LexID'));
	IF(attributesVersion IN setValidBusAttributeVersions AND NOT ValidBusiness, FAIL('Minimum input information not met. Minimum input information is:  \n (1)  Business Name, Street Address, City and State or Zip  OR \n (2)  Business Name, Tax ID OR \n (3)  LexID'));
	IF(RequestInvalid, FAIL('Please enter a valid attributes version: ' + DueDiligence.Constants.IND_REQ_ATTRIBUTE_V3 + ' OR ' + DueDiligence.Constants.BUS_REQ_ATTRIBUTE_V3));
	IF(NOT PermissionGLB, FAIL('Not an allowable GLB permissible purpose'));
	IF(NOT PermissionDPPA, FAIL('Not an allowable DPPA permissible purpose'));

	layout_acctseq := RECORD
		INTEGER4 seq;
		requestIn;
	END;
	wseq := PROJECT(requestIn, TRANSFORM(layout_acctseq, SELF.seq := COUNTER, SELF := left));

/*		
	// IID AND Boca Shell
	Risk_Indicators.Layout_Input into(wseq l) := TRANSFORM
		SELF.did := (INTEGER)l.searchby.Individual.UniqueId;
		SELF.seq := l.seq;
		// SELF.historydate := history_date;
		SELF.ssn := l.searchby.Individual.ssn;
		dob := l.searchby.Individual.dob.year
						+ INTFORMAT((INTEGER1)l.searchby.Individual.dob.month, 2, 1)
						+ INTFORMAT((INTEGER1)l.searchby.Individual.dob.day,   2, 1);
		SELF.dob := IF((UNSIGNED)dob=0, '', dob);
		// SELF.age := (STRING3)ut.Age((UNSIGNED8)dob, (UNSIGNED)risk_indicators.iid_constants.myGetDate(history_date));
		
		fullname := TRIM(l.searchby.Individual.name.full);
		cleanname := address.CleanPerson73( fullname );
		title  := IF(l.searchby.Individual.name.prefix='' AND fullname!='', TRIM((cleanname[1..5]))  , l.searchby.Individual.name.prefix);
		fname  := IF(l.searchby.Individual.name.first ='' AND fullname!='', TRIM((cleanname[6..25])) , l.searchby.Individual.name.first );
		mname  := IF(l.searchby.Individual.name.middle='' AND fullname!='', TRIM((cleanname[26..45])), l.searchby.Individual.name.middle);
		lname  := IF(l.searchby.Individual.name.last  ='' AND fullname!='', TRIM((cleanname[46..65])), l.searchby.Individual.name.last  );
		suffix := IF(l.searchby.Individual.name.suffix='' AND fullname!='', TRIM((cleanname[66..70])), l.searchby.Individual.name.suffix);
		
		SELF.title  := StringLib.StringToUpperCase(title);
		SELF.fname  := StringLib.StringToUpperCase(fname);
		SELF.mname  := StringLib.StringToUpperCase(mname);
		SELF.lname  := StringLib.StringToUpperCase(lname);
		SELF.suffix := StringLib.StringToUpperCase(suffix);
		
		addr_value := IF(TRIM(l.searchby.Individual.address.streetaddress1)!='', l.searchby.Individual.address.streetaddress1,
				Address.Addr1FromComponents(l.searchby.Individual.address.streetnumber, l.searchby.Individual.address.streetpredirection, l.searchby.Individual.address.streetname,
					l.searchby.Individual.address.streetsuffix, l.searchby.Individual.address.streetpostdirection, l.searchby.Individual.address.unitdesignation, l.searchby.Individual.address.unitnumber));

		clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, l.searchby.Individual.address.city, l.searchby.Individual.address.state, l.searchby.Individual.address.zip5);

		SELF.in_streetAddress:= addr_value;
		SELF.in_city         := l.searchby.Individual.address.city;
		SELF.in_state        := l.searchby.Individual.address.state;
		SELF.in_zipCode      := l.searchby.Individual.address.zip5;	
		SELF.prim_range      := clean_a2[1..10];
		SELF.predir          := clean_a2[11..12];
		SELF.prim_name       := clean_a2[13..40];
		SELF.addr_suffix     := clean_a2[41..44];
		SELF.postdir         := clean_a2[45..46];
		SELF.unit_desig      := clean_a2[47..56];
		SELF.sec_range       := clean_a2[57..64];
		SELF.p_city_name     := clean_a2[90..114];
		SELF.st              := clean_a2[115..116];
		SELF.z5              := clean_a2[117..121];
		SELF.zip4            := clean_a2[122..125];
		SELF.lat             := clean_a2[146..155];
		SELF.long            := clean_a2[156..166];
		SELF.addr_type 				:= risk_indicators.iid_constants.override_addr_type(addr_value, clean_a2[139],clean_a2[126..129]);
		SELF.addr_status     := clean_a2[179..182];
		SELF.county          := clean_a2[143..145];
		SELF.geo_blk         := clean_a2[171..177];
		
		SELF.dl_number       := '';
		SELF.dl_state        := '';;
		SELF.phone10 			   := l.searchby.Individual.Phone;
		SELF.wphone10			   := '';
		SELF.email_address	 := '';
		SELF.ip_address		   := '';
		SELF.in_country        := '';
		SELF.country         := '';
		
		SELF := [];
	END;
	iid_prep := PROJECT(wseq, into(left));	

	// TEST SEEDS
	risk_indicators.layout_input intoTestPrep(wseq l) := TRANSFORM
		SELF.seq := l.seq;	
		SELF.ssn := l.searchby.Individual.ssn;
		SELF.phone10 := l.searchby.Individual.Phone;
		SELF.fname := StringLib.StringToUpperCase(l.searchby.Individual.name.first);
		SELF.lname := StringLib.StringToUpperCase(l.searchby.Individual.name.last);
		SELF.in_zipCode := l.searchby.Individual.address.zip5;
		SELF := [];
	END;
	test_prep := PROJECT(wseq, intoTestPrep(LEFT));


	// consumerAttributes :=  IF(TestDataEnabled, DueDiligence.testSeed_ind(test_prep, TestDataTableName),
																// DueDiligence.getIndAttributes(iid_prep, 
																															 // DataRestrictionMask,
																															 // DPPA,
																															 // GLBA,
																															 // gateways, 
																															 // bsversion,
																															 // DataPermissionMask,
																															 // UseXG5,
																															 // IncludeNewsProfile));
	*/																					 
		consumerAttributes := DATASET([TRANSFORM(DueDiligence.Layouts.LayoutShell, SELF.seq := 1; SELF := [];)]); 
		
	iesp.share.t_NameValuePair createrec(DueDiligence.Layouts.LayoutShell le, INTEGER C) := TRANSFORM
			SELF.Name:= CASE( C,
				1 => 'IndLexID' ,
				2 => 'IndAssetOwnProperty' ,
				3 => 'IndAssetOwnAircraft' ,
				4 => 'IndAssetOwnWatercraft',
				5 => 'IndAssetOwnVehicle',
				6 => 'IndAccessToFundsIncome', 
				7 => 'IndAccessToFundsProperty', 
				8 => 'IndGeographicRisk', 
				9 => 'IndMobility', 
				10 => 'IndLegalEvents',  
				11 => 'IndLegalEventsFelonyType',  
				12 => 'IndHighRiskNewsProfiles',  
				13 => 'IndAgeRange',  
				14 => 'IndIdentityRisk',  
				15 => 'IndResidencyRisk',  
				16 => 'IndMatchLevel',  
				17 => 'IndAssociatesRisk',  
				18 => 'IndProfessionalRisk',
              DueDiligence.Constants.INVALID);
							
			SELF.Value:=  CASE(C,
			 1 =>  '0',   //(STRING)le.IndLexID,
			 2 =>  '-1',   //le.IndAssetOwnProperty,
			 3 =>  '-1',   //le.IndAssetOwnAircraft,
			 4 =>  '-1',   //le.IndAssetOwnWatercraft,
			 5 =>  '-1',   //le.IndAssetOwnVehicle,
			 6 =>  '-1',   //le.IndAccessToFundsIncome,
			 7 =>  '-1',   //le.IndAccessToFundsProperty,
			 8 =>  '-1',   //le.IndGeographicRisk,
			 9 =>  '-1',   //le.IndMobility,
			 10 =>  '-1',   //le.IndLegalEvents,
			 11 =>  '-1',   //le.IndLegalEventsFelonyType,
			 12 =>  '-1',   //le.IndHighRiskNewsProfiles,
			 13 =>  '-1',   //le.IndAgeRange,
			 14 =>  '-1',   //le.IndIdentityRisk,
			 15 =>  '-1',   //le.IndResidencyRisk,
			 16 =>  '-1',   //le.IndMatchLevel,
			 17 =>  '-1',   //le.IndAssociatesRisk,
			 18 =>  '-1',   //le.IndProfessionalRisk,
						DueDiligence.Constants.INVALID);
		
	END;
 	
	IndIndex := NORMALIZE(UNGROUP(consumerAttributes), 18, createrec(LEFT, COUNTER));
	
	iesp.duediligencereport.t_DueDiligenceReportResponse IntoConsumerAttributes(wseq le, consumerAttributes ri ) := TRANSFORM
    	SELF.Result.InputEcho := le.searchby;	
			SELF.Result.AttributeGroup.attributes :=  IndIndex;
			SELF.Result.UniqueId := (STRING)ri.did;
			SELF.Result.AttributeGroup.Name := DueDiligence.Constants.IND_REQ_ATTRIBUTE_V3;
		  SELF := le;
			SELF := [];
	END;
	
	
	IndAttributes := JOIN(wseq, consumerAttributes,
													 RIGHT.seq = LEFT.seq,
													 IntoConsumerAttributes(LEFT, RIGHT));


//********************************************************BUSINESS ATTRIBUTES STARTS HERE********************************************************

/*
	business_risk.Layout_Input into_input(wseq L) := TRANSFORM
		SELF.seq := l.seq;
		SELF.bdid := (INTEGER)l.searchby.Business.BusinessId;
		// SELF.historydate := history_date;
		SELF.Account := (STRING)l.seq;
		SELF.company_name := IF(StringLib.StringToUpperCase(l.searchby.Business.CompanyName) <> '',StringLib.StringToUpperCase(l.searchby.Business.CompanyName), StringLib.StringToUpperCase(l.searchby.Business.AlternateCompanyName));
		
		addr_value := IF(TRIM(l.searchby.Business.address.streetaddress1)!='', l.searchby.Business.address.streetaddress1,
				Address.Addr1FromComponents(l.searchby.Business.address.streetnumber, l.searchby.Business.address.streetpredirection, l.searchby.Business.address.streetname,
					l.searchby.Business.address.streetsuffix, l.searchby.Business.address.streetpostdirection, l.searchby.Business.address.unitdesignation, l.searchby.Business.address.unitnumber));

		clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, l.searchby.Business.address.city, l.searchby.Business.address.state, l.searchby.Business.address.zip5);

		SELF.prim_range      := clean_a2[1..10];
		SELF.predir          := clean_a2[11..12];
		SELF.prim_name       := clean_a2[13..40];
		SELF.addr_suffix     := clean_a2[41..44];
		SELF.postdir         := clean_a2[45..46];
		SELF.unit_desig      := clean_a2[47..56];
		SELF.sec_range       := clean_a2[57..64];
		SELF.p_city_name     := clean_a2[90..114];
		SELF.st              := clean_a2[115..116];
		SELF.z5              := clean_a2[117..121];
		SELF.zip4            := clean_a2[122..125];
		SELF.lat             := clean_a2[146..155];
		SELF.long            := clean_a2[156..166];
		SELF.addr_type       := clean_a2[139];
		SELF.addr_status     := clean_a2[179..182];
		SELF.county          := clean_a2[143..145];
		SELF.geo_blk         := clean_a2[171..177];
		SELF.fein		 				 := l.searchby.Business.fein;
		SELF.phone10    		 := l.searchby.Business.phone;
		
		SELF := [];

	END;
	busInput := PROJECT(wseq,into_input(LEFT));

	business_risk.Layout_Input into_test_Busnprep(wseq l) := TRANSFORM
		SELF.seq := l.seq;
		// SELF.historydate := history_date;
		SELF.Account := (STRING)l.seq;
		SELF.company_name := StringLib.StringToUpperCase(l.searchby.Business.CompanyName);
		SELF.z5              := l.searchby.business.address.zip5;
		SELF.fein		 				 := l.searchby.Business.FEIN;
		SELF.phone10    	   := l.searchby.Business.phone;
		SELF := [];
	END;
	test_Busnprep := PROJECT(wseq, into_test_Busnprep(LEFT));

	// businessResults := IF(TestDataEnabled, DueDiligence.testSeed_bus(test_Busnprep, TestDataTableName), 
														// DueDiligence.getBusAttributes(busInput, 
																													// DataRestrictionMask,
																													// DPPA,
																													// GLBA,
																													// gateways,
																													// bsversion,
																													// UseXG5,
																													// IncludeNewsProfile));
*/
	businessResults := DATASET([TRANSFORM(DueDiligence.Layouts.LayoutShell, SELF.seq := 1; SELF := [];)]); 


	iesp.share.t_NameValuePair BusnCreateRec(businessResults le, INTEGER C) := TRANSFORM
			SELF.Name:= CASE(c,
			 1 => 'BusLexID', 
			 2 => 'BusAssetOwnProperty', 
			 3 => 'BusAssetOwnAircraft', 
			 4 => 'BusAssetOwnWatercraft', 
			 5 => 'BusAssetOwnVehicle', 
			 6 => 'BusAccessToFundsProperty',
			 7 => 'BusGeographicRisk',
			 8 => 'BusValidityRisk', 
			 9 => 'BusStabilityRisk', 
			 10 => 'BusIndustryRisk',  
			 11 => 'BusStructureType', 
			 12 => 'BusSOSAgeRange', 
			 13 => 'BusPublicRecordAgeRange', 
			 14 => 'BusShellShelfRisk', 
			 15 => 'BusMatchLevel', 
			 16 => 'BusLegalEvents', 
			 17 => 'BusLegalEventsFelonyType',
			 18 => 'BusHighRiskNewsProfiles',
			 19 => 'BusKinkedBusRisk',
			 20 => 'BusExecOfficersRisk',
			 21 => 'BusExecOfficersResidencyRisk',
					  DueDiligence.Constants.INVALID);
						
			SELF.Value:= CASE(c,
			 1 =>  '0',  //(STRING)le.BusLexID,
			 2 =>  '-1',  //le.BusAssetOwnProperty,
			 3 =>  '-1',  //le.BusAssetOwnAircraft,
			 4 =>  '-1',  //le.BusAssetOwnWatercraft,
			 5 =>  '-1',  //le.BusAssetOwnVehicle,
			 6 =>  '-1',  //le.BusAccessToFundsProperty,
			 7 =>  '-1',  //le.BusGeographicRisk,
			 8 =>  '-1',  //le.BusValidityRisk,
			 9 =>  '-1',  //le.BusStabilityRisk,
			 10 =>  '-1',  //le.BusIndustryRisk,
			 11 =>  '-1',  //le.BusStructureType,
			 12 =>  '-1',  //le.BusSOSAgeRange,
			 13 =>  '-1',  //le.BusPublicRecordAgeRange,
			 14 =>  '-1',  //le.BusShellShelfRisk,
			 15 =>  '-1',  //le.BusMatchLevel,
			 16 =>  '-1',  //le.BusLegalEvents,
			 17 =>  '-1',  //le.BusLegalEventsFelonyType,
			 18 =>  '-1',  //le.BusHighRiskNewsProfiles,
			 19 =>  '-1',  //le.BusLinkedBusRisk,
			 20 =>  '-1',  //le.BusExecOfficersRisk,
			 21 =>  '-1',  //le.BusExecOfficersResidencyRisk,
			      DueDiligence.Constants.INVALID);
	END;

	BusnIndex := NORMALIZE(businessResults, 21, BusnCreateRec(LEFT, COUNTER));
	
	iesp.duediligencereport.t_DueDiligenceReportResponse IntoBusnAttributes(wseq le, businessResults ri) := TRANSFORM
    	SELF.result.inputecho := le.searchby;	
			SELF.Result.AttributeGroup.attributes :=  BusnIndex;
			SELF.Result.BusinessId  := (STRING)ri.DID;
			SELF.Result.AttributeGroup.Name := DueDiligence.Constants.BUS_REQ_ATTRIBUTE_V3;
		  SELF := le;
			SELF := [];
	END;
	
	
	BusnAttributes := JOIN(wseq, 	businessResults, 
													RIGHT.seq = LEFT.seq,
													IntoBusnAttributes(LEFT, RIGHT));




// debugging section



FINAL := IF(attributesVersion IN setValidIndAttributeVersions, (IndAttributes), (Busnattributes));
OUTPUT(final,NAMED('Results'));

ENDMACRO;
