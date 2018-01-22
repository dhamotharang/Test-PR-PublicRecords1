IMPORT AutoStandardI, DueDiligence, Gateway, iesp, STD, WSInput;

EXPORT DueDiligence_Service := MACRO

	UNSIGNED1 NUMBER_OF_INDIVIDUAL_ATTRIBUTES := 19;
	UNSIGNED1 NUMBER_OF_BUSINESS_ATTRIBUTES := 23;

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
	outerBandDPPA := DueDiligence.Constants.EMPTY : STORED('DD_DPPAPurpose');
	outerBandGLBA := DueDiligence.Constants.EMPTY : STORED('DD_GLBPurpose');
	outerBandHistoryDate := DueDiligence.Constants.NUMERIC_ZERO : STORED('DD_HistoryDateYYYYMMDD');
	
	drm	:= IF(TRIM(userIn.DataRestrictionMask) <> DueDiligence.Constants.EMPTY, userIn.DataRestrictionMask, AutoStandardI.GlobalModule().DataRestrictionMask);
	dpm	:= IF(TRIM(userIn.DataPermissionMask) <> DueDiligence.Constants.EMPTY, userIn.DataPermissionMask, AutoStandardI.GlobalModule().DataPermissionMask);
	dppa := IF((UNSIGNED1)userIn.DLPurpose > DueDiligence.Constants.NUMERIC_ZERO, (UNSIGNED1)userIn.DLPurpose, (UNSIGNED1)outerBandDPPA);
	glba := IF((UNSIGNED1)userIn.GLBPurpose > DueDiligence.Constants.NUMERIC_ZERO, (UNSIGNED1)userIn.GLBPurpose, (UNSIGNED1)outerBandGLBA);	
	
	requestedVersion := TRIM(STD.Str.ToUpperCase(optionsIn.AttributesVersionRequest));
	includeReport := optionsIn.IncludeReport;
	displayAttributeText := optionsIn.displayText;
	
	gateways := Gateway.Configuration.Get();
	
	
	
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
																					 
	consumerResults := DueDiligence.getIndAttributes(cleanData, DPPA, glba, drm, gateways, includeReport, displayAttributeText, debugIndicator);
		
		
	
	
	
	iesp.share.t_NameValuePair createIndIndex(consumerResults le, INTEGER c) := TRANSFORM
	
		SELF := CASE(c,
									1  => ROW(createNVPair('PerAssetOwnProperty', le.PerAssetOwnProperty)),
									2  => ROW(createNVPair('PerAssetOwnAircraft', le.PerAssetOwnAircraft)),
									3  => ROW(createNVPair('PerAssetOwnWatercraft', le.PerAssetOwnWatercraft)),
									4  => ROW(createNVPair('PerAssetOwnVehicle', le.PerAssetOwnVehicle)),
									5  => ROW(createNVPair('PerAccessToFundsProperty', le.PerAccessToFundsProperty)),
									6  => ROW(createNVPair('PerAccessToFundsIncome', le.PerAccessToFundsIncome)),
									7  => ROW(createNVPair('PerGeographic', le.PerGeographic)),
									8  => ROW(createNVPair('PerMobility', le.PerMobility)),
									9  => ROW(createNVPair('PerLegalCriminal', le.PerLegalCriminal)),
									10 => ROW(createNVPair('PerLegalCivil', le.PerLegalCivil)),
									11 => ROW(createNVPair('PerLegalTraffInfr', le.PerLegalTraffInfr)),
									12 => ROW(createNVPair('PerLegalTypes', le.PerLegalTypes)),
									13 => ROW(createNVPair('PerHighRiskNewsProfiles', le.PerHighRiskNewsProfiles)),
									14 => ROW(createNVPair('PerAgeRange', le.PerAgeRange)),
									15 => ROW(createNVPair('PerIdentityRisk', le.PerIdentityRisk)),
									16 => ROW(createNVPair('PerUSResidency', le.PerUSResidency)),
									17 => ROW(createNVPair('PerMatchLevel', le.PerMatchLevel)),
									18 => ROW(createNVPair('PerAssociatesIndex', le.PerAssociatesIndex)),
									19 => ROW(createNVPair('PerProfLicense', le.PerProfLicense)),
												ROW(createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID)));
	END;
	
	iesp.share.t_NameValuePair createIndHit(consumerResults le, INTEGER c) := TRANSFORM
	
		SELF := CASE(c,
									1  => ROW(createNVPair('PerAssetOwnProperty_Flag', le.PerAssetOwnProperty_Flag)),
									2  => ROW(createNVPair('PerAssetOwnAircraft_Flag', le.PerAssetOwnAircraft_Flag)),
									3  => ROW(createNVPair('PerAssetOwnWatercraft_Flag', le.PerAssetOwnWatercraft_Flag)),
									4  => ROW(createNVPair('PerAssetOwnVehicle_Flag', le.PerAssetOwnVehicle_Flag)),
									5  => ROW(createNVPair('PerAccessToFundsProperty_Flag', le.PerAccessToFundsProperty_Flag)),
									6  => ROW(createNVPair('PerAccessToFundsIncome_Flag', le.PerAccessToFundsIncome_Flag)),
									7  => ROW(createNVPair('PerGeographic_Flag', le.PerGeographic_Flag)),
									8  => ROW(createNVPair('PerMobility_Flag', le.PerMobility_Flag)),
									9  => ROW(createNVPair('PerLegalCriminal_Flag', le.PerLegalCriminal_Flag)),
									10 => ROW(createNVPair('PerLegalCivil_Flag', le.PerLegalCivil_Flag)),
									11 => ROW(createNVPair('PerLegalTraffInfr_Flag', le.PerLegalTraffInfr_Flag)),
									12 => ROW(createNVPair('PerLegalTypes_Flag', le.PerLegalTypes_Flag)),
									13 => ROW(createNVPair('PerHighRiskNewsProfiles_Flag', le.PerHighRiskNewsProfiles_Flag)),
									14 => ROW(createNVPair('PerAgeRange_Flag', le.PerAgeRange_Flag)),
									15 => ROW(createNVPair('PerIdentityRisk_Flag', le.PerIdentityRisk_Flag)),
									16 => ROW(createNVPair('PerUSResidency_Flag', le.PerUSResidency_Flag)),
									17 => ROW(createNVPair('PerMatchLevel_Flag', le.PerMatchLevel_Flag)),
									18 => ROW(createNVPair('PerAssociatesIndex_Flag', le.PerAssociatesIndex_Flag)),
									19 => ROW(createNVPair('PerProfLicense_Flag', le.PerProfLicense_Flag)),
												ROW(createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID)));
	END;

	indIndex := NORMALIZE(UNGROUP(consumerResults), NUMBER_OF_INDIVIDUAL_ATTRIBUTES, createIndIndex(LEFT, COUNTER));
	indIndexHits := NORMALIZE(consumerResults, NUMBER_OF_INDIVIDUAL_ATTRIBUTES, createIndHit(LEFT, COUNTER));
	
	iesp.duediligencereport.t_DueDiligenceReportResponse IntoConsumerAttributes(layout_acctseq le, DueDiligence.Layouts.Indv_Internal ri ) := TRANSFORM
    	SELF.result.uniqueID := (STRING)ri.individual.did;
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
		EXPORT UNSIGNED1	DPPA_Purpose 				:= dppa;
		EXPORT UNSIGNED1	GLBA_Purpose 				:= glba;
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
									6  => ROW(createNVPair('BusGeographic', le.BusGeographic)),
									7  => ROW(createNVPair('BusValidity', le.BusValidity)),
									8  => ROW(createNVPair('BusStability', le.BusStability)),
									9  => ROW(createNVPair('BusIndustry', le.BusIndustry)),
									10 => ROW(createNVPair('BusStructureType', le.BusStructureType)),
									11 => ROW(createNVPair('BusSOSAgeRange', le.BusSOSAgeRange)),
									12 => ROW(createNVPair('BusPublicRecordAgeRange', le.BusPublicRecordAgeRange)),
									13 => ROW(createNVPair('BusShellShelf', le.BusShellShelf)),
									14 => ROW(createNVPair('BusMatchLevel', le.BusMatchLevel)),
									15 => ROW(createNVPair('BusLegalCriminal', le.BusLegalCriminal)),
									16 => ROW(createNVPair('BusLegalCivil', le.BusLegalCivil)),
									17 => ROW(createNVPair('BusLegalTraffInfr', le.BusLegalTraffInfr)),
									18 => ROW(createNVPair('BusLegalTypes', le.BusLegalTypes)),
									19 => ROW(createNVPair('BusHighRiskNewsProfiles', le.BusHighRiskNewsProfiles)),
									20 => ROW(createNVPair('BusLinkedBusFootprint', le.BusLinkedBusFootprint)),
									21 => ROW(createNVPair('BusLinkedBusIndex', le.BusLinkedBusIndex)),
									22 => ROW(createNVPair('BusBEOProfLicense', le.BusBEOProfLicense)),
									23 => ROW(createNVPair('BusBEOUSResidency', le.BusBEOUSResidency)),
												ROW(createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID)));
	END;
	
	iesp.share.t_NameValuePair createBusHit(DueDiligence.Layouts.Busn_Internal le, INTEGER C) := TRANSFORM
		
		SELF := CASE(c,
									1  => ROW(createNVPair('BusAssetOwnProperty_Flag', le.BusAssetOwnProperty_Flag)),
									2  => ROW(createNVPair('BusAssetOwnAircraft_Flag', le.BusAssetOwnAircraft_Flag)),
									3  => ROW(createNVPair('BusAssetOwnWatercraft_Flag', le.BusAssetOwnWatercraft_Flag)),
									4  => ROW(createNVPair('BusAssetOwnVehicle_Flag', le.BusAssetOwnVehicle_Flag)),
									5  => ROW(createNVPair('BusAccessToFundsProperty_Flag', le.BusAccessToFundsProperty_Flag)),
									6  => ROW(createNVPair('BusGeographic_Flag', le.BusGeographic_Flag)),
									7  => ROW(createNVPair('BusValidity_Flag', le.BusValidity_Flag)),
									8  => ROW(createNVPair('BusStability_Flag', le.BusStability_Flag)),
									9  => ROW(createNVPair('BusIndustry_Flag', le.BusIndustry_Flag)),
									10 => ROW(createNVPair('BusStructureType_Flag', le.BusStructureType_Flag)),
									11 => ROW(createNVPair('BusSOSAgeRange_Flag', le.BusSOSAgeRange_Flag)),
									12 => ROW(createNVPair('BusPublicRecordAgeRange_Flag', le.BusPublicRecordAgeRange_Flag)),
									13 => ROW(createNVPair('BusShellShelf_Flag', le.BusShellShelf_Flag)),
									14 => ROW(createNVPair('BusMatchLevel_Flag', le.BusMatchLevel_Flag)),
									15 => ROW(createNVPair('BusLegalCriminal_Flag', le.BusLegalCriminal_Flag)),
									16 => ROW(createNVPair('BusLegalCivil_Flag', le.BusLegalCivil_Flag)),
									17 => ROW(createNVPair('BusLegalTraffInfr_Flag', le.BusLegalTraffInfr_Flag)),
									18 => ROW(createNVPair('BusLegalTypes_Flag', le.BusLegalTypes_Flag)),
									19 => ROW(createNVPair('BusHighRiskNewsProfiles_Flag', le.BusHighRiskNewsProfiles_Flag)),
									20 => ROW(createNVPair('BusLinkedBusFootprint_Flag', le.BusLinkedBusFootprint_Flag)),
									21 => ROW(createNVPair('BusLinkedBusIndex_Flag', le.BusLinkedBusIndex_Flag)),
									22 => ROW(createNVPair('BusBEOProfLicense_Flag', le.BusBEOProfLicense_Flag)),
									23 => ROW(createNVPair('BusBEOUSResidency_Flag', le.BusBEOUSResidency_Flag)),
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
	IF(intermediates, output(consumerResults, NAMED('indResults')));                        //This is for debug mode 

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