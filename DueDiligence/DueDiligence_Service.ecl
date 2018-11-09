IMPORT AutoStandardI, DueDiligence, Gateway, iesp, STD, WSInput;

EXPORT DueDiligence_Service := MACRO

	UNSIGNED1 NUMBER_OF_INDIVIDUAL_ATTRIBUTES := 17;
	UNSIGNED1 NUMBER_OF_BUSINESS_ATTRIBUTES := 20;

	//The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_DueDiligence_Service();
	
	//Get debugging indicator
	debugIndicator := FALSE : STORED('debugMode');
	intermediates := FALSE : STORED('intermediateVariables');

	// Get XML input 
	requestIn := DATASET([], iesp.duediligencereport.t_DueDiligenceReportRequest)  	: STORED('DueDiligenceReportRequest', few);

	firstRow := requestIn[1] : INDEPENDENT; // Since this is realtime AND not batch, should only have one row on input.

	optionsIn 	:= GLOBAL(firstRow.options);
	userIn 			:= GLOBAL(firstRow.user);
	search 			:= GLOBAL(firstRow.reportBy);
	
	//get outer band data - to use if customer data is not populated
	outerBandDPPA := DueDiligence.Constants.EMPTY : STORED('DPPAPurpose');
	outerBandGLBA := DueDiligence.Constants.EMPTY : STORED('GLBPurpose');
	outerBandHistoryDate := 0 : STORED('HistoryDateYYYYMMDD');
	
	drm	:= IF(TRIM(userIn.DataRestrictionMask) <> DueDiligence.Constants.EMPTY, userIn.DataRestrictionMask, AutoStandardI.GlobalModule().DataRestrictionMask);
	dpm	:= IF(TRIM(userIn.DataPermissionMask) <> DueDiligence.Constants.EMPTY, userIn.DataPermissionMask, AutoStandardI.GlobalModule().DataPermissionMask);
	dppa := IF((UNSIGNED1)userIn.DLPurpose > 0, (UNSIGNED1)userIn.DLPurpose, (UNSIGNED1)outerBandDPPA);
	glba := IF((UNSIGNED1)userIn.GLBPurpose > 0, (UNSIGNED1)userIn.GLBPurpose, (UNSIGNED1)outerBandGLBA);	
	
	requestedVersion := TRIM(STD.Str.ToUpperCase(optionsIn.AttributesVersionRequest));
	includeReport := optionsIn.IncludeReport;
	
	//gateways				:= Gateway.Configuration.Get();
	
	
	
	layout_acctseq := RECORD
		INTEGER4 seq;
		requestIn;
	END;
	wseq := PROJECT(requestIn, TRANSFORM(layout_acctseq, SELF.seq := COUNTER, SELF := left));

	
	DueDiligence.Layouts.Input formatInput(layout_acctseq le) := TRANSFORM
	
		version := requestedVersion;
	
		reportBy := le.reportBy;
		indBusAddr := IF(version IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, le.reportBy.individual.address, le.reportBy.business.address);
		
		address_in := DATASET([TRANSFORM(DueDiligence.Layouts.Address,
																			SELF.prim_range := TRIM(indBusAddr.streetnumber);
																			SELF.predir := TRIM(indBusAddr.streetPreDirection);
																			SELF.prim_name := TRIM(indBusAddr.streetName);
																			SELF.addr_suffix := TRIM(indBusAddr.streetSuffix);
																			SELF.postdir := TRIM(indBusAddr.streetPostDirection);
																			SELF.unit_desig := TRIM(indBusAddr.unitDesignation);
																			SELF.sec_range := TRIM(indBusAddr.unitNumber);
																			SELF.streetAddress1 := TRIM(indBusAddr.streetAddress1);
																			SELF.streetAddress2 := TRIM(indBusAddr.streetAddress2);
																			SELF.city := TRIM(indBusAddr.city);
																			SELF.state := TRIM(indBusAddr.state);
																			SELF.zip5 := TRIM(indBusAddr.zip5);
																			SELF.zip4 := TRIM(indBusAddr.zip4);
																			SELF.county := TRIM(indBusAddr.county);
																			SELF := [];)]);
																				
		ind_in := IF(version IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, 
												DATASET([TRANSFORM(DueDiligence.Layouts.Indv_Input,
																						SELF.lexID := TRIM(reportBy.individual.lexID);
																						SELF.name := DATASET([TRANSFORM(DueDiligence.Layouts.Name,
																																						SELF.fullName := TRIM(reportBy.individual.name.full);
																																						SELF.firstName := TRIM(reportBy.individual.name.first);
																																						SELF.middleName := TRIM(reportBy.individual.name.middle);
																																						SELF.lastName := TRIM(reportBy.individual.name.last);
																																						SELF.suffix := TRIM(reportBy.individual.name.suffix);
																																						SELF := [];)])[1];
																						SELF.address := address_in[1];
																						SELF.phone := TRIM(reportBy.individual.phone);
																						SELF.ssn := TRIM(reportBy.individual.ssn);
																						SELF.accountNumber := TRIM(le.user.accountNumber);
																						SELF := [];)]),
												DATASET([], DueDiligence.Layouts.Indv_Input));
																	
		bus_in := IF(version IN DueDiligence.Constants.VALID_BUS_ATTRIBUTE_VERSIONS, 
												DATASET([TRANSFORM(DueDiligence.Layouts.Busn_Input,
																						SELF.lexID := TRIM(reportBy.business.lexID);
																						SELF.accountNumber := TRIM(le.user.accountNumber);
																						SELF.companyName := TRIM(reportBy.business.companyName);
																						SELF.altCompanyName := TRIM(reportBy.business.alternateCompanyName);
																						SELF.address := address_in[1];
																						SELF.fein := TRIM(reportBy.business.fein);
																						SELF := [];,)]),
												DATASET([], DueDiligence.Layouts.Busn_Input));
		
		useHistDate := (UNSIGNED4)(INTFORMAT(le.options.HistoryDate.Year, 4, 1) + INTFORMAT(le.options.HistoryDate.Month, 2, 1) + INTFORMAT(le.options.HistoryDate.Day, 2, 1));
		histDate := IF(useHistDate > 0, useHistDate, (UNSIGNED4)outerBandHistoryDate);
																		
		SELF.seq := le.seq;
		SELF.individual := ind_in[1];
		SELF.business := bus_in[1];
		SELF.historyDateYYYYMMDD := histDate;
		SELF.requestedVersion := version;
		SELF := [];
	END;

	input := PROJECT(wseq, formatInput(LEFT));
	validatedRequest := DueDiligence.Common.ValidateRequest(input, glba, dppa);
	
	//update the error message if the version was incorrect
	updateVersionMessage := PROJECT(validatedRequest(validRequest = FALSE), TRANSFORM(DueDiligence.Layouts.Input,
																																										versionReq := ': ' + DueDiligence.Constants.IND_REQ_ATTRIBUTE_V3 + ' OR ' + DueDiligence.Constants.BUS_REQ_ATTRIBUTE_V3;
																																										SELF.errorMessage := IF(LEFT.errorMessage = DueDiligence.Constants.VALIDATION_INVALID_VERSION, TRIM(LEFT.errorMessage) + versionReq, LEFT.errorMessage);
																																										SELF := LEFT;));

	IF(COUNT(updateVersionMessage) > 0 AND updateVersionMessage[1].validRequest = FALSE, FAIL(updateVersionMessage[1].errorMessage));

	
	cleanData := DueDiligence.Common.GetCleanData(validatedRequest(validRequest));
	
	iesp.share.t_NameValuePair createNVPair(STRING name, STRING val) := TRANSFORM
		SELF.Name := name;
		SELF.Value := val;
	END;


	// TEST SEEDS
	// risk_indicators.layout_input intoTestPrep(wseq l) := TRANSFORM
		// SELF.seq := l.seq;	
		// SELF.ssn := l.searchby.Individual.ssn;
		// SELF.phone10 := l.searchby.Individual.Phone;
		// SELF.fname := STD.Str.ToUpperCase(l.searchby.Individual.name.first);
		// SELF.lname := STD.Str.ToUpperCase(l.searchby.Individual.name.last);
		// SELF.in_zipCode := l.searchby.Individual.address.zip5;
		// SELF := [];
	// END;
	// test_prep := PROJECT(wseq, intoTestPrep(LEFT));


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
																					 
	consumerResults := DATASET([TRANSFORM(DueDiligence.Layouts.Indv_Internal, SELF.seq := 1; SELF := [];)]); 
		
		
	
	
	
	iesp.share.t_NameValuePair createIndIndex(consumerResults le, INTEGER c) := TRANSFORM
	
		SELF := CASE(c,
									1  => ROW(createNVPair('IndAssetOwnProperty', le.IndAssetOwnProperty)),
									2  => ROW(createNVPair('IndAssetOwnAircraft', le.IndAssetOwnAircraft)),
									3  => ROW(createNVPair('IndAssetOwnWatercraft', le.IndAssetOwnWatercraft)),
									4  => ROW(createNVPair('IndAssetOwnVehicle', le.IndAssetOwnVehicle)),
									5  => ROW(createNVPair('IndAccessToFundsIncome', le.IndAccessToFundsIncome)),
									6  => ROW(createNVPair('IndAccessToFundsProperty', le.IndAccessToFundsProperty)),
									7  => ROW(createNVPair('IndGeographicRisk', le.IndGeographicRisk)),
									8  => ROW(createNVPair('IndMobility', le.IndMobility)),
									9 => ROW(createNVPair('IndLegalEvents', le.IndLegalEvents)),
									10 => ROW(createNVPair('IndLegalEventsFelonyType', le.IndLegalEventsFelonyType)),
									11 => ROW(createNVPair('IndHighRiskNewsProfiles', le.IndHighRiskNewsProfiles)),
									12 => ROW(createNVPair('IndAgeRange', le.IndAgeRange)),
									13 => ROW(createNVPair('IndIdentityRisk', le.IndIdentityRisk)),
									14 => ROW(createNVPair('IndResidencyRisk', le.IndResidencyRisk)),
									15 => ROW(createNVPair('IndMatchLevel', le.IndMatchLevel)),
									16 => ROW(createNVPair('IndAssociatesRisk', le.IndAssociatesRisk)),
									17 => ROW(createNVPair('IndProfessionalRisk', le.IndProfessionalRisk)),
												ROW(createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID)));
	END;
	
	iesp.share.t_NameValuePair createIndHit(consumerResults le, INTEGER c) := TRANSFORM
	
		SELF := CASE(c,
									1  => ROW(createNVPair('IndAssetOwnProperty', le.IndAssetOwnProperty_Flags)),
									2  => ROW(createNVPair('IndAssetOwnAircraft', le.IndAssetOwnAircraft_Flags)),
									3  => ROW(createNVPair('IndAssetOwnWatercraft', le.IndAssetOwnWatercraft_Flags)),
									4  => ROW(createNVPair('IndAssetOwnVehicle', le.IndAssetOwnVehicle_Flags)),
									5  => ROW(createNVPair('IndAccessToFundsIncome', le.IndAccessToFundsIncome_Flags)),
									6  => ROW(createNVPair('IndAccessToFundsProperty', le.IndAccessToFundsProperty_Flags)),
									7  => ROW(createNVPair('IndGeographicRisk', le.IndGeographicRisk_Flags)),
									8  => ROW(createNVPair('IndMobility', le.IndMobility_Flags)),
									9  => ROW(createNVPair('IndLegalEvents', le.IndLegalEvents_Flags)),
									10 => ROW(createNVPair('IndLegalEventsFelonyType', le.IndLegalEventsFelonyType_Flags)),
									11 => ROW(createNVPair('IndHighRiskNewsProfiles', le.IndHighRiskNewsProfiles_Flags)),
									12 => ROW(createNVPair('IndAgeRange', le.IndAgeRange_Flags)),
									13 => ROW(createNVPair('IndIdentityRisk', le.IndIdentityRisk_Flags)),
									14 => ROW(createNVPair('IndResidencyRisk', le.IndResidencyRisk_Flags)),
									15 => ROW(createNVPair('IndMatchLevel', le.IndMatchLevel_Flags)),
									16 => ROW(createNVPair('IndAssociatesRisk', le.IndAssociatesRisk_Flags)),
									17 => ROW(createNVPair('IndProfessionalRisk', le.IndProfessionalRisk_Flags)),
												ROW(createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID)));
	END;
 	
	indIndex := NORMALIZE(UNGROUP(consumerResults), NUMBER_OF_INDIVIDUAL_ATTRIBUTES, createIndIndex(LEFT, COUNTER));
	indIndexHits := NORMALIZE(consumerResults, NUMBER_OF_INDIVIDUAL_ATTRIBUTES, createIndHit(LEFT, COUNTER));
	
	iesp.duediligencereport.t_DueDiligenceReportResponse IntoConsumerAttributes(layout_acctseq le, DueDiligence.Layouts.Indv_Internal ri ) := TRANSFORM
    	SELF.result.uniqueID := '';
			SELF.Result.InputEcho := le.reportBy;	
			SELF.Result.AttributeGroup.attributes :=  indIndex;
			SELF.Result.AttributeGroup.AttributeLevelHits := indIndexHits;
			SELF.Result.AttributeGroup.Name := requestedVersion;
		  SELF := le;
			SELF := [];
	END;
	
	IndAttributes := JOIN(wseq, consumerResults,
													 LEFT.seq = RIGHT.seq,
													 IntoConsumerAttributes(LEFT, RIGHT));


//********************************************************BUSINESS ATTRIBUTES STARTS HERE********************************************************
	options := MODULE(Business_Risk_BIP.LIB_Business_Shell_LIBIN)
		// Clean up the Options and make sure that defaults are enforced
		EXPORT UNSIGNED1	DPPA_Purpose 				:= DPPA;
		EXPORT UNSIGNED1	GLBA_Purpose 				:= GLBA;
		EXPORT STRING50		DataRestrictionMask	:= TRIM(drm);
		EXPORT STRING50		DataPermissionMask	:= TRIM(dpm);
		EXPORT STRING10		IndustryClass				:= STD.Str.ToUpperCase(IF(TRIM(userIn.IndustryClass) <> DueDiligence.Constants.EMPTY, userIn.IndustryClass, Business_Risk_BIP.Constants.Default_IndustryClass));
		EXPORT UNSIGNED1	LinkSearchLevel			:= Business_Risk_BIP.Constants.LinkSearch.SeleID;
		EXPORT UNSIGNED1	BusShellVersion			:= Business_Risk_BIP.Constants.Default_BusShellVersion;
		EXPORT UNSIGNED1	MarketingMode				:= Business_Risk_BIP.Constants.Default_MarketingMode;
		EXPORT STRING50		AllowedSources			:= Business_Risk_BIP.Constants.Default_AllowedSources;
		EXPORT UNSIGNED1	BIPBestAppend	 			:= Business_Risk_BIP.Constants.BIPBestAppend.OverwriteWithBest;
	END;

	linkingOptions := MODULE(BIPV2.mod_sources.iParams)
		EXPORT STRING DataRestrictionMask		:= Options.DataRestrictionMask; 
		EXPORT BOOLEAN ignoreFares					:= FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore FARES data - default it to FALSE to always utilize whatever the DataRestrictionMask allows
		EXPORT BOOLEAN ignoreFidelity				:= FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore Fidelity data - default it to FALSE to always utilize whatever the DataRestrictionMask allows
		EXPORT BOOLEAN AllowAll							:= IF(Options.AllowedSources = Business_Risk_BIP.Constants.AllowDNBDMI, TRUE, FALSE);
		EXPORT BOOLEAN AllowGLB							:= TRUE; //This already passed validation
		EXPORT BOOLEAN AllowDPPA						:= TRUE; //This already passed validation
		EXPORT UNSIGNED1 DPPAPurpose				:= Options.DPPA_Purpose;
		EXPORT UNSIGNED1 GLBPurpose					:= Options.GLBA_Purpose;
		EXPORT BOOLEAN IncludeMinors				:= TRUE; // Shouldn't really have an impact on business searches, set to TRUE for now
		EXPORT BOOLEAN LNBranded						:= TRUE; // Not entirely certain what effect this has
	END;

	
	businessResults := DueDiligence.getBusAttributes(cleanData, options, linkingOptions, includeReport, debugIndicator);

	iesp.share.t_NameValuePair createBusIndex(DueDiligence.Layouts.Busn_Internal le, INTEGER C) := TRANSFORM
			
		SELF := CASE(c,
									1  => ROW(createNVPair('BusAssetOwnProperty', le.BusAssetOwnProperty)),
									2  => ROW(createNVPair('BusAssetOwnAircraft', le.BusAssetOwnAircraft)),
									3  => ROW(createNVPair('BusAssetOwnWatercraft', le.BusAssetOwnWatercraft)),
									4  => ROW(createNVPair('BusAssetOwnVehicle', le.BusAssetOwnVehicle)),
									5  => ROW(createNVPair('BusAccessToFundsProperty', le.BusAccessToFundsProperty)),
									6  => ROW(createNVPair('BusGeographicRisk', le.BusGeographicRisk)),
									7  => ROW(createNVPair('BusValidityRisk', le.BusValidityRisk)),
									8  => ROW(createNVPair('BusStabilityRisk', le.BusStabilityRisk)),
									9 => ROW(createNVPair('BusIndustryRisk', le.BusIndustryRisk)),
									10 => ROW(createNVPair('BusStructureType', le.BusStructureType)),
									11 => ROW(createNVPair('BusSOSAgeRange', le.BusSOSAgeRange)),
									12 => ROW(createNVPair('BusPublicRecordAgeRange', le.BusPublicRecordAgeRange)),
									13 => ROW(createNVPair('BusShellShelfRisk', le.BusShellShelfRisk)),
									14 => ROW(createNVPair('BusMatchLevel', le.BusMatchLevel)),
									15 => ROW(createNVPair('BusLegalEvents', le.BusLegalEvents)),
									16 => ROW(createNVPair('BusLegalEventsFelonyType', le.BusLegalEventsFelonyType)),
									17 => ROW(createNVPair('BusHighRiskNewsProfiles', le.BusHighRiskNewsProfiles)),
									18 => ROW(createNVPair('BusLinkedBusRisk', le.BusLinkedBusRisk)),
									19 => ROW(createNVPair('BusExecOfficersRisk', le.BusExecOfficersRisk)),
									20 => ROW(createNVPair('BusExecOfficersResidencyRisk', le.BusExecOfficersResidencyRisk)),
												ROW(createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID)));
	END;
	
	iesp.share.t_NameValuePair createBusHit(DueDiligence.Layouts.Busn_Internal le, INTEGER C) := TRANSFORM
		
		SELF := CASE(c,
									1  => ROW(createNVPair('BusAssetOwnProperty_Flags', le.BusAssetOwnProperty_Flags)),
									2  => ROW(createNVPair('BusAssetOwnAircraft_Flags', le.BusAssetOwnAircraft_Flags)),
									3  => ROW(createNVPair('BusAssetOwnWatercraft_Flags', le.BusAssetOwnWatercraft_Flags)),
									4  => ROW(createNVPair('BusAssetOwnVehicle_Flags', le.BusAssetOwnVehicle_Flags)),
									5  => ROW(createNVPair('BusAccessToFundsProperty_Flags', le.BusAccessToFundsProperty_Flags)),
									6  => ROW(createNVPair('BusGeographicRisk_Flags', le.BusGeographicRisk_Flags)),
									7  => ROW(createNVPair('BusValidityRisk_Flags', le.BusValidityRisk_Flags)),
									8  => ROW(createNVPair('BusStabilityRisk_Flags', le.BusStabilityRisk_Flags)),
									9  => ROW(createNVPair('BusIndustryRisk_Flags', le.BusIndustryRisk_Flags)),
									10 => ROW(createNVPair('BusStructureType_Flags', le.BusStructureType_Flags)),
									11 => ROW(createNVPair('BusSOSAgeRange_Flags', le.BusSOSAgeRange_Flags)),
									12 => ROW(createNVPair('BusPublicRecordAgeRange_Flags', le.BusPublicRecordAgeRange_Flags)),
									13 => ROW(createNVPair('BusShellShelfRisk_Flags', le.BusShellShelfRisk_Flags)),
									14 => ROW(createNVPair('BusMatchLevel_Flags', le.BusMatchLevel_Flags)),
									15 => ROW(createNVPair('BusLegalEvents_Flags', le.BusLegalEvents_Flags)),
									16 => ROW(createNVPair('BusLegalEventsFelonyType_Flags', le.BusLegalEventsFelonyType_Flags)),
									17 => ROW(createNVPair('BusHighRiskNewsProfiles_Flags', le.BusHighRiskNewsProfiles_Flags)),
									18 => ROW(createNVPair('BusLinkedBusRisk_Flags', le.BusLinkedBusRisk_Flags)),
									19 => ROW(createNVPair('BusExecOfficersRisk_Flags', le.BusExecOfficersRisk_Flags)),
									20 => ROW(createNVPair('BusExecOfficersResidencyRisk_Flags', le.BusExecOfficersResidencyRisk_Flags)),
												ROW(createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID)));
	END;

	busnIndex := NORMALIZE(businessResults, NUMBER_OF_BUSINESS_ATTRIBUTES, createBusIndex(LEFT, COUNTER));
	busIndexHits := NORMALIZE(businessResults, NUMBER_OF_BUSINESS_ATTRIBUTES, createBusHit(LEFT, COUNTER));
	
	iesp.duediligencereport.t_DueDiligenceReportResponse IntoBusnAttributes(layout_acctseq le, DueDiligence.Layouts.Busn_Internal ri) := TRANSFORM
    	SELF.result.businessID := (STRING)ri.busn_info.BIP_IDs.SeleID.LinkID;
			SELF.result.inputecho := le.reportBy;	
			SELF.result.AttributeGroup.attributes :=  busnIndex;
			SELF.result.AttributeGroup.AttributeLevelHits := busIndexHits;
			SELF.result.AttributeGroup.Name := requestedVersion;
			SELF.result.BusinessReport := IF(includeReport, ri.BusinessReport, DATASET([TRANSFORM(iesp.duediligencereport.t_DDRBusinessReport, SELF := [];)])[1]);
		  SELF := le;
			SELF := [];
	END;
	
	BusnAttributes := JOIN(wseq, businessResults, 
													LEFT.seq = RIGHT.seq,
													IntoBusnAttributes(LEFT, RIGHT));


	final := IF(requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, IndAttributes, Busnattributes);
	
	output(final, NAMED('Results')); //This is the customer facing output    

	IF(debugIndicator, output(cleanData, NAMED('cleanData')));                              //This is for debug mode 	
	IF(debugIndicator, output(wseq, NAMED('wseq')));                              					//This is for debug mode 
	IF(intermediates, output(businessResults, NAMED('busResults')));                        //This is for debug mode 

ENDMACRO;


/*--SOAP-- 
<message name="duediligence.duediligence_service">
	<part name="duediligencereportrequest" sequence="1" type="tns:XmlDataset"/>
	<part name="datapermissionmask" sequence="2" type="xsd:string"/>
	<part name="datarestrictionmask" sequence="3" type="xsd:string"/>
	<part name="dppapurpose" sequence="4" type="xsd:string"/>
	<part name="glbpurpose" sequence="5" type="xsd:string"/>
	<part name="historydateyyyymmdd" sequence="6" type="xsd:integer"/>
	<part name="debugmode" sequence="7" type="xsd:boolean"/>
	<part name="intermediatevariables" sequence="8" type="xsd:boolean"/>
</message>
*/