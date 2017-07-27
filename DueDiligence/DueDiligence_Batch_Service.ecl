IMPORT Risk_Indicators, Gateway, Business_Risk_BIP, BIPV2, DueDiligence;

EXPORT DueDiligence_Batch_Service() := FUNCTION
	
	//The following macro defines the field sequence on WsECL page of query.
	#WEBSERVICE(FIELDS(
                'batch_in',
                'GLBAPurpose',
                'DPPAPurpose',
								'DataRestriction',
								'DataPermissionMask',
                'AttributesVersion',
                'IncludeNews',
								'IncludeAllLevels',
                'gateways',
								'debugMode'
                ));


  batch_in  := DATASET([], DueDiligence.Layouts.BatchInLayout ) : STORED('batch_in');
  unsigned1 glba := 5  : STORED('GLBAPurpose');
	unsigned1 dppa := 3  : STORED('DPPAPurpose');
	unsigned1 AttributesVersion := 3  : STORED('AttributesVersion'); 
	Boolean  	IncludeNewsProfile := TRUE  : STORED('IncludeNewsProfile');
	string50	DataRestriction := risk_indicators.iid_constants.default_DataRestriction : STORED('DataRestriction');
  string50 	DataPermission := Risk_Indicators.iid_constants.default_DataPermission : STORED('DataPermissionMask');
	
	//Get debugging indicator
	BOOLEAN debugIndicator := FALSE : STORED('debugMode');
	
	

	wseq := PROJECT(batch_in, TRANSFORM(DueDiligence.Layouts.BatchInLayout, SELF.seq := COUNTER, SELF := left));

	//Keep track of individual vs business requests
	indRecs :=  wseq(StringLib.StringToUpperCase(CustType) = DueDiligence.Constants.INDIVIDUAL);
  busRecs :=  wseq(StringLib.StringToUpperCase(CustType) = DueDiligence.Constants.BUSINESS);


	DueDiligence.Layouts.Input formatIndData(DueDiligence.Layouts.BatchInLayout le) := TRANSFORM

		address_in := DATASET([TRANSFORM(DueDiligence.Layouts.Address,
																			SELF.streetAddress1 := TRIM(le.streetAddress1);
																			SELF.streetAddress2 := TRIM(le.streetAddress2);
																			SELF.city := TRIM(le.city);
																			SELF.state := TRIM(le.state);
																			SELF.zip5 := TRIM(le.zip5);
																			SELF := [];)]);
																			
		name_in := DATASET([TRANSFORM(DueDiligence.Layouts.Name,
																	SELF.firstName := TRIM(le.firstName);
																	SELF.middleName := TRIM(le.middleName);
																	SELF.lastName := TRIM(le.lastName);
																	SELF.suffix := TRIM(le.suffix);
																	SELF := [];)]);
																				
		ind_in := DATASET([TRANSFORM(DueDiligence.Layouts.Indv_Input,
																	SELF.lexID := TRIM(le.lexID);
																	SELF.name := name_in[1];
																	SELF.address := address_in[1];
																	SELF.phone := TRIM(le.phone);
																	SELF.ssn := TRIM(le.taxID);
																	SELF.accountNumber := TRIM(le.acctNo);
																	SELF := [];)]);		
																	
																		
		SELF.seq := le.seq;
		SELF.individual := ind_in[1];
		SELF.historyDateYYYYMMDD := IF((UNSIGNED4)le.HistoryDateYYYYMMDD = 0, DueDiligence.Constants.date8Nines, (UNSIGNED4)le.HistoryDateYYYYMMDD);
		SELF := [];
	END;


	inIndData := PROJECT(indRecs, formatIndData(LEFT));
	cleanIndData := DueDiligence.Common.GetCleanData(inIndData);
	
	consumerAttributes := inIndData;//DueDiligence.getIndAttributes();
																				 

	STRING2 negOne := '-1';
	STRING10 notFoundFlags := 'FFFFFFFFFF';
																						 
	DueDiligence.Layouts.BatchOut IndMapOut(consumerAttributes le, wseq ri) := TRANSFORM
		SELF.acctNo := ri.acctNo;
		SELF.IndLexID := (STRING)0;
		SELF.IndAssetOwnProperty := 'IndAssetOwnProperty:' + ' ' + negOne;
		SELF.IndAssetOwnProperty_Flags := 'IndAssetOwnProperty:' + ' ' + notFoundFlags;
		SELF.IndAssetOwnAircraft := 'IndAssetOwnAircraft:' + ' ' + negOne;
		SELF.IndAssetOwnAircraft_Flags := 'IndAssetOwnAircraft:' + ' ' + notFoundFlags;
		SELF.IndAssetOwnWatercraft := 'IndAssetOwnWatercraft:' + ' ' + negOne;
		SELF.IndAssetOwnWatercraft_Flags := 'IndAssetOwnWatercraft:' + ' ' + notFoundFlags;
		SELF.IndAssetOwnVehicle := 'IndAssetOwnVehicle:' + ' ' + negOne;
		SELF.IndAssetOwnVehicle_Flags := 'IndAssetOwnVehicle:' + ' ' + notFoundFlags;
		SELF.IndAccessToFundsIncome := 'IndAccessToFundsIncome:' + ' ' + negOne;
		SELF.IndAccessToFundsIncome_Flags := 'IndAccessToFundsIncome:' + ' ' + notFoundFlags;
		SELF.IndAccessToFundsProperty := 'IndAccessToFundsProperty:' + ' ' + negOne;
		SELF.IndAccessToFundsProperty_Flags := 'IndAccessToFundsProperty:' + ' ' + notFoundFlags;
		SELF.IndGeographicRisk := 'IndGeographicRisk:' + ' ' + negOne;
		SELF.IndGeographicRisk_Flags := 'IndGeographicRisk:' + ' ' + notFoundFlags;
		SELF.IndMobility := 'IndMobility:' + ' ' + negOne;
		SELF.IndMobility_Flags := 'IndMobility:' + ' ' + notFoundFlags;
		SELF.IndLegalEvents := 'IndLegalEvents:' + ' ' + negOne;
		SELF.IndLegalEvents_Flags := 'IndLegalEvents:' + ' ' + notFoundFlags;
		SELF.IndLegalEventsFelonyType := 'IndLegalEventsFelonyType:' + ' ' + negOne;
		SELF.IndLegalEventsFelonyType_Flags := 'IndLegalEventsFelonyType:' + ' ' + notFoundFlags;
		SELF.IndHighRiskNewsProfiles := 'IndHighRiskNewsProfiles:' + ' ' + negOne;
		SELF.IndHighRiskNewsProfiles_Flags := 'IndHighRiskNewsProfiles:' + ' ' + notFoundFlags;
		SELF.IndAgeRange := 'IndAgeRange:' + ' ' + negOne;
		SELF.IndAgeRange_Flags := 'IndAgeRange:' + ' ' + notFoundFlags;
		SELF.IndIdentityRisk := 'IndIdentityRisk:' + ' ' + negOne;
		SELF.IndIdentityRisk_Flags := 'IndIdentityRisk:' + ' ' + notFoundFlags;
		SELF.IndResidencyRisk := 'IndResidenceyRisk:' + ' ' + negOne;
		SELF.IndResidencyRisk_Flags := 'IndResidenceyRisk:' + ' ' + notFoundFlags;
		SELF.IndMatchLevel := 'IndMatchLevel:' + ' ' + negOne;
		SELF.IndMatchLevel_Flags := 'IndMatchLevel:' + ' ' + notFoundFlags;
		SELF.IndAssociatesRisk := 'IndAssociatesRisk:' + ' ' + negOne;
		SELF.IndAssociatesRisk_Flags := 'IndAssociatesRisk:' + ' ' + notFoundFlags;
		SELF.IndProfessionalRisk := 'IndProfessionalRisk:' + ' ' + negOne;
		SELF.IndProfessionalRisk_Flags := 'IndProfessionalRisk:' + ' ' + notFoundFlags;
		
		SELF := [];
	END;


	indIndex := JOIN(consumerAttributes, indRecs, 
							LEFT.seq = RIGHT.seq, 
							IndMapOut(LEFT, RIGHT), LEFT OUTER);  



//********************************************************BUSINESS ATTRIBUTES STARTS HERE********************************************************
	options := MODULE(Business_Risk_BIP.LIB_Business_Shell_LIBIN)
		// Clean up the Options and make sure that defaults are enforced
		EXPORT UNSIGNED1	DPPA_Purpose 				:= dppa;
		EXPORT UNSIGNED1	GLBA_Purpose 				:= glba;
		EXPORT STRING50		DataRestrictionMask	:= DataRestriction;
		EXPORT STRING50		DataPermissionMask	:= DataPermission;
		EXPORT STRING10		IndustryClass				:= StringLib.StringToUpperCase(Business_Risk_BIP.Constants.Default_IndustryClass);
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
		EXPORT BOOLEAN AllowGLB							:= Risk_Indicators.iid_constants.glb_ok(Options.GLBA_Purpose, FALSE );
		EXPORT BOOLEAN AllowDPPA						:= Risk_Indicators.iid_constants.dppa_ok(Options.DPPA_Purpose, FALSE);
		EXPORT UNSIGNED1 DPPAPurpose				:= Options.DPPA_Purpose;
		EXPORT UNSIGNED1 GLBPurpose					:= Options.GLBA_Purpose;
		EXPORT BOOLEAN IncludeMinors				:= TRUE; // Shouldn't really have an impact on business searches, set to TRUE for now
		EXPORT BOOLEAN LNBranded						:= TRUE; // Not entirely certain what effect this has
	END;
	
	
	DueDiligence.Layouts.Input formatBusData(DueDiligence.Layouts.BatchInLayout le) := TRANSFORM

		address_in := DATASET([TRANSFORM(DueDiligence.Layouts.Address,
																			SELF.streetAddress1 := TRIM(le.streetAddress1);
																			SELF.streetAddress2 := TRIM(le.streetAddress2);
																			SELF.city := TRIM(le.city);
																			SELF.state := TRIM(le.state);
																			SELF.zip5 := TRIM(le.zip5);
																			SELF := [];)]);
																				
		bus_in := DATASET([TRANSFORM(DueDiligence.Layouts.Busn_Input,
																	SELF.lexID := TRIM(le.lexID);
																	SELF.companyName := TRIM(le.companyName);
																	SELF.altCompanyName := TRIM(le.altCompanyName);
																	SELF.address := address_in[1];
																	SELF.phone := TRIM(le.phone);
																	SELF.fein := TRIM(le.taxID);
																	SELF.accountNumber := TRIM(le.acctNo);
																	SELF := [];)]);		
																				
																				
		SELF.seq := le.seq;
		SELF.business := bus_in[1];
		SELF.historyDateYYYYMMDD := (UNSIGNED4)le.HistoryDateYYYYMMDD;
		SELF := [];
	END;


	inBusData := PROJECT(busRecs, formatBusData(LEFT));
	cleanBusData := DueDiligence.Common.GetCleanData(inBusData);
	
	//get the business data
	businessResults := inBusData; //DueDiligence.getBusAttributes(cleanBusData, options, linkingOptions);
														 


	DueDiligence.Layouts.BatchOut BusMapOut(businessResults le, BusRecs ri) := TRANSFORM
		SELF.acctNo := ri.acctNo;
		SELF.BusLexID := (STRING)0;
		SELF.BusAssetOwnProperty := 'BusAssetOwnProperty:' + ' ' + negOne;        
		SELF.BusAssetOwnProperty_Flags := 'BusAssetOwnProperty:' + ' ' + notFoundFlags;         
		SELF.BusAssetOwnAircraft := 'BusAssetOwnAircraft:' + ' ' + negOne;
		SELF.BusAssetOwnAircraft_Flags := 'BusAssetOwnAircraft:' + ' ' + notFoundFlags;
		SELF.BusAssetOwnWatercraft := 'BusAssetOwnWatercraft:' + ' ' + negOne;
		SELF.BusAssetOwnWatercraft_Flags := 'BusAssetOwnWatercraft:' + ' ' + notFoundFlags;
		SELF.BusAssetOwnVehicle := 'BusAssetOwnVehicle:' + ' ' + negOne;
		SELF.BusAssetOwnVehicle_Flags := 'BusAssetOwnVehicle:' + ' ' + notFoundFlags;
		SELF.BusAccessToFundsProperty := 'BusAccessToFundsProperty:' + ' ' + negOne;
		SELF.BusAccessToFundsProperty_Flags := 'BusAccessToFundsProperty:' + ' ' + notFoundFlags;
		SELF.BusGeographicRisk := 'BusGeographicRisk:' + ' ' + negOne;
		SELF.BusGeographicRisk_Flags := 'BusGeographicRisk:' + ' ' + notFoundFlags;
		SELF.BusValidityRisk := 'BusValidityRisk:' + ' ' + negOne;
		SELF.BusValidityRisk_Flags := 'BusValidityRisk:' + ' ' + notFoundFlags;
		SELF.BusStabilityRisk := 'BusStabilityRisk:' + ' ' + negOne;
		SELF.BusStabilityRisk_Flags := 'BusStabilityRisk:' + ' ' + notFoundFlags;
		SELF.BusIndustryRisk := 'BusIndustryRisk:' + ' ' + negOne;
		SELF.BusIndustryRisk_Flags := 'BusIndustryRisk:' + ' ' + notFoundFlags;
		SELF.BusStructureType := 'BusStructureType:' + ' ' + negOne;
		SELF.BusStructureType_Flags := 'BusStructureType:' + ' ' + notFoundFlags;
		SELF.BusSOSAgeRange := 'BusSOSAgeRange:' + ' ' + negOne;
		SELF.BusSOSAgeRange_Flags := 'BusSOSAgeRange:' + ' ' + notFoundFlags;
		SELF.BusPublicRecordAgeRange := 'BusPublicRecordAgeRange:' + ' ' + negOne;
		SELF.BusPublicRecordAgeRange_Flags := 'BusPublicRecordAgeRange:' + ' ' + notFoundFlags;
		SELF.BusShellShelfRisk := 'BusShellShelfRisk:' + ' ' + negOne;
		SELF.BusShellShelfRisk_Flags := 'BusShellShelfRisk:' + ' ' + notFoundFlags;
		SELF.BusMatchLevel := 'BusMatchLevel:' + ' ' + negOne;
		SELF.BusMatchLevel_Flags := 'BusMatchLevel:' + ' ' + notFoundFlags;
		SELF.BusLegalEvents := 'BusLegalEvents:' + ' ' + negOne;
		SELF.BusLegalEvents_Flags := 'BusLegalEvents:' + ' ' + notFoundFlags;
		SELF.BusLegalEventsFelonyType := 'BusLegalEventsFelonyType:' + ' ' + negOne;
		SELF.BusLegalEventsFelonyType_Flags := 'BusLegalEventsFelonyType:' + ' ' + notFoundFlags;
		SELF.BusHighRiskNewsProfiles := 'BusHighRiskNewsProfiles:' + ' ' + negOne;
		SELF.BusHighRiskNewsProfiles_Flags := 'BusHighRiskNewsProfiles:' + ' ' + notFoundFlags;
		SELF.BusLinkedBusRisk := 'BusLinkedBusRisk:' + ' ' + negOne; 
		SELF.BusLinkedBusRisk_Flags := 'BusLinkedBusRisk:' + ' ' + notFoundFlags; 
		SELF.BusExecOfficersRisk := 'BusExecOfficersRisk:' + ' ' + negOne;
		SELF.BusExecOfficersRisk_Flags := 'BusExecOfficersRisk:' + ' ' + notFoundFlags;
		SELF.BusExecOfficersResidencyRisk := 'BusExecOfficersResidencyRisk:' + ' ' + negOne;	
		SELF.BusExecOfficersResidencyRisk_Flags := 'BusExecOfficersResidencyRisk:' + ' ' + notFoundFlags;	
		SELF := [];
	END;

	busIndex := JOIN(businessResults, BusRecs,
									LEFT.seq = RIGHT.seq, 
									BusMapOut(LEFT, RIGHT), LEFT OUTER); 
							

	final :=  UNGROUP(indIndex) + UNGROUP(busIndex);
	
	
	
	IF(debugIndicator, output(cleanIndData, NAMED('clean_ind_data')));           //This is for debug mode 	
	IF(debugIndicator, output(cleanBusData, NAMED('clean_bus_data')));           //This is for debug mode 	
	
		
	RETURN final;
															 

END;
