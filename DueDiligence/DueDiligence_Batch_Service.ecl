IMPORT Risk_Indicators, Gateway, Business_Risk_BIP, BIPV2, DueDiligence, STD, WSInput;

EXPORT DueDiligence_Batch_Service() := FUNCTION
	
	//The following macro defines the field sequence on WsECL page of query. 
  WSInput.MAC_DueDiligence_Batch_Service();
								

  batch_in  := DATASET([], DueDiligence.Layouts.BatchInLayout ) : STORED('batch_in');
  unsigned1 glba := DueDiligence.Constants.DEFAULT_GLBA  : STORED('glbaPurpose');
	unsigned1 dppa := DueDiligence.Constants.DEFAULT_DPPA  : STORED('dppaPurpose');
	unsigned1 attributesVersion := DueDiligence.Constants.VERSION_3  : STORED('attributesVersion'); 
	Boolean  	includeNewsProfile := TRUE  : STORED('includeNews');
	string50	dataRestriction := risk_indicators.iid_constants.default_DataRestriction : STORED('dataRestriction');
  string50 	dataPermission := Risk_Indicators.iid_constants.default_DataPermission : STORED('dataPermissionMask');

	
	DueDiligence.Layouts.Input formatInput(DueDiligence.Layouts.BatchInLayout le, INTEGER cnt) := TRANSFORM
	
		customerType := STD.Str.ToUpperCase(le.custType);
	
		version := MAP(attributesVersion = DueDiligence.Constants.VERSION_3 AND customerType = DueDiligence.Constants.INDIVIDUAL => DueDiligence.Constants.IND_REQ_ATTRIBUTE_V3,
										attributesVersion = DueDiligence.Constants.VERSION_3 AND customerType = DueDiligence.Constants.BUSINESS => DueDiligence.Constants.BUS_REQ_ATTRIBUTE_V3,
										DueDiligence.Constants.INVALID);
	
	
		address_in := DATASET([TRANSFORM(DueDiligence.Layouts.Address,
																			SELF.streetAddress1 := TRIM(le.streetAddress1);
																			SELF.streetAddress2 := TRIM(le.streetAddress2);
																			SELF.city := TRIM(le.city);
																			SELF.state := TRIM(le.state);
																			SELF.zip5 := TRIM(le.zip5);
																			SELF := [];)]);
																				
		ind_in := IF(version IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, 
												DATASET([TRANSFORM(DueDiligence.Layouts.Indv_Input,
																						SELF.lexID := TRIM(le.lexID);
																						SELF.nameInputOrder := TRIM(le.nameInputOrder);
																						SELF.name := DATASET([TRANSFORM(DueDiligence.Layouts.Name,
																																						SELF.fullName := TRIM(le.fullName);
																																						SELF.firstName := TRIM(le.firstName);
																																						SELF.middleName := TRIM(le.middleName);
																																						SELF.lastName := TRIM(le.lastName);
																																						SELF.suffix := TRIM(le.suffix);
																																						SELF := [];)])[1];
																						SELF.address := address_in[1];
																						SELF.phone := TRIM(le.phone);
																						SELF.ssn := TRIM(le.taxID);
																						SELF.accountNumber := TRIM(le.acctNo);
																						SELF := [];)]),
												DATASET([], DueDiligence.Layouts.Indv_Input));
																	
		bus_in := IF(version IN DueDiligence.Constants.VALID_BUS_ATTRIBUTE_VERSIONS, 
												DATASET([TRANSFORM(DueDiligence.Layouts.Busn_Input,
																						SELF.lexID := TRIM(le.lexID);
																						SELF.accountNumber := TRIM(le.acctNo);
																						SELF.companyName := TRIM(le.companyName);
																						SELF.altCompanyName := TRIM(le.altCompanyName);
																						SELF.address := address_in[1];
																						SELF.fein := TRIM(le.taxID);
																						SELF := [];,)]),
												DATASET([], DueDiligence.Layouts.Busn_Input));
																	
																		
		SELF.seq := cnt;
		SELF.individual := ind_in[1];
		SELF.business := bus_in[1];
		SELF.historyDateYYYYMMDD := IF((UNSIGNED4)le.HistoryDateYYYYMMDD = 0, DueDiligence.Constants.date8Nines, (UNSIGNED4)le.HistoryDateYYYYMMDD);
		SELF.requestedVersion := version;
		SELF := [];
	END;

	wseq := PROJECT(batch_in, formatInput(LEFT, COUNTER));
	
	validatedRequests := DueDiligence.Common.ValidateRequest(wseq, glba, dppa);

	//Keep track of individual vs business requests
	indRecs :=  validatedRequests(requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS);
  busRecs :=  validatedRequests(requestedVersion IN DueDiligence.Constants.VALID_BUS_ATTRIBUTE_VERSIONS);


	//clean and retrieve individual attributes
	cleanIndData := DueDiligence.Common.GetCleanData(indRecs(validRequest));
	consumerResults := DATASET([], DueDiligence.Layouts.Indv_Internal);//DueDiligence.getIndAttributes();
																				 

																						 
	DueDiligence.Layouts.BatchOut IndMapOut(DueDiligence.Layouts.Indv_Internal le, wseq ri) := TRANSFORM
		SELF.acctNo := ri.individual.accountNumber;
		SELF.IndLexID := (STRING)le.IndLexID;
		
		SELF.IndAssetOwnProperty 							:= le.IndAssetOwnProperty;
		SELF.IndAssetOwnProperty_Flags 				:= le.IndAssetOwnProperty_Flags;
		SELF.IndAssetOwnAircraft 							:= le.IndAssetOwnAircraft;
		SELF.IndAssetOwnAircraft_Flags 				:= le.IndAssetOwnAircraft_Flags;
		SELF.IndAssetOwnWatercraft 						:= le.IndAssetOwnWatercraft;
		SELF.IndAssetOwnWatercraft_Flags 			:= le.IndAssetOwnWatercraft_Flags;
		SELF.IndAssetOwnVehicle 							:= le.IndAssetOwnVehicle;
		SELF.IndAssetOwnVehicle_Flags 				:= le.IndAssetOwnVehicle_Flags;
		SELF.IndAccessToFundsIncome 					:= le.IndAccessToFundsIncome;
		SELF.IndAccessToFundsIncome_Flags 		:= le.IndAccessToFundsIncome_Flags;
		SELF.IndAccessToFundsProperty 				:= le.IndAccessToFundsProperty;
		SELF.IndAccessToFundsProperty_Flags 	:= le.IndAccessToFundsProperty_Flags;
		SELF.IndGeographicRisk 								:= le.IndGeographicRisk;
		SELF.IndGeographicRisk_Flags 					:= le.IndGeographicRisk_Flags;
		SELF.IndMobility 											:= le.IndMobility;
		SELF.IndMobility_Flags 								:= le.IndMobility_Flags;
		SELF.IndLegalEvents 									:= le.IndLegalEvents;
		SELF.IndLegalEvents_Flags 						:= le.IndLegalEvents_Flags;
		SELF.IndLegalEventsFelonyType 				:= le.IndLegalEventsFelonyType;
		SELF.IndLegalEventsFelonyType_Flags 	:= le.IndLegalEventsFelonyType_Flags;
		SELF.IndHighRiskNewsProfiles 					:= le.IndHighRiskNewsProfiles;
		SELF.IndHighRiskNewsProfiles_Flags 		:= le.IndHighRiskNewsProfiles_Flags;
		SELF.IndAgeRange 											:= le.IndAgeRange;
		SELF.IndAgeRange_Flags 								:= le.IndAgeRange_Flags;
		SELF.IndIdentityRisk 									:= le.IndIdentityRisk;
		SELF.IndIdentityRisk_Flags 						:= le.IndIdentityRisk_Flags;
		SELF.IndResidencyRisk 								:= le.IndResidencyRisk;
		SELF.IndResidencyRisk_Flags 					:= le.IndResidencyRisk_Flags;
		SELF.IndMatchLevel 										:= le.IndMatchLevel;
		SELF.IndMatchLevel_Flags 							:= le.IndMatchLevel_Flags;
		SELF.IndAssociatesRisk 								:= le.IndAssociatesRisk;
		SELF.IndAssociatesRisk_Flags 					:= le.IndAssociatesRisk_Flags;
		SELF.IndProfessionalRisk 							:= le.IndProfessionalRisk;
		SELF.IndProfessionalRisk_Flags 				:= le.IndProfessionalRisk_Flags;
		
		SELF := [];
	END;


	indIndex := JOIN(consumerResults, indRecs, 
										LEFT.seq = RIGHT.seq, 
										IndMapOut(LEFT, RIGHT), RIGHT OUTER);  



//********************************************************BUSINESS ATTRIBUTES STARTS HERE********************************************************
	options := MODULE(Business_Risk_BIP.LIB_Business_Shell_LIBIN)
		// Clean up the Options and make sure that defaults are enforced
		EXPORT UNSIGNED1	DPPA_Purpose 				:= dppa;
		EXPORT UNSIGNED1	GLBA_Purpose 				:= glba;
		EXPORT STRING50		DataRestrictionMask	:= dataRestriction;
		EXPORT STRING50		DataPermissionMask	:= dataPermission;
		EXPORT STRING10		IndustryClass				:= STD.Str.ToUpperCase(Business_Risk_BIP.Constants.Default_IndustryClass);
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
	
	
	//clean and retrieve business attributes
	cleanBusData := DueDiligence.Common.GetCleanData(busRecs(validRequest));
	businessResults := DueDiligence.getBusAttributes(cleanBusData, options, linkingOptions);
														 

	DueDiligence.Layouts.BatchOut BusMapOut(DueDiligence.Layouts.Busn_Internal le, BusRecs ri) := TRANSFORM
		SELF.acctNo := ri.business.accountNumber;
		SELF.BusLexID := (STRING)le.busLexID;
		
		SELF.BusAssetOwnProperty 								:= le.BusAssetOwnProperty;        
		SELF.BusAssetOwnProperty_Flags 					:= le.BusAssetOwnProperty_Flags;         
		SELF.BusAssetOwnAircraft 								:= le.BusAssetOwnAircraft;
		SELF.BusAssetOwnAircraft_Flags 					:= le.BusAssetOwnAircraft_Flags;
		SELF.BusAssetOwnWatercraft 							:= le.BusAssetOwnWatercraft;
		SELF.BusAssetOwnWatercraft_Flags 				:= le.BusAssetOwnWatercraft_Flags;
		SELF.BusAssetOwnVehicle 								:= le.BusAssetOwnVehicle;
		SELF.BusAssetOwnVehicle_Flags 					:= le.BusAssetOwnVehicle_Flags;
		SELF.BusAccessToFundsProperty 					:= le.BusAccessToFundsProperty;
		SELF.BusAccessToFundsProperty_Flags 		:= le.BusAccessToFundsProperty_Flags;
		SELF.BusGeographicRisk 									:= le.BusGeographicRisk;
		SELF.BusGeographicRisk_Flags 						:= le.BusGeographicRisk_Flags;
		SELF.BusValidityRisk 										:= le.BusValidityRisk;
		SELF.BusValidityRisk_Flags 							:= le.BusValidityRisk_Flags;
		SELF.BusStabilityRisk 									:= le.BusStabilityRisk;
		SELF.BusStabilityRisk_Flags 						:= le.BusStabilityRisk_Flags;
		SELF.BusIndustryRisk 										:= le.BusIndustryRisk;
		SELF.BusIndustryRisk_Flags 							:= le.BusIndustryRisk_Flags;
		SELF.BusStructureType 									:= le.BusStructureType;
		SELF.BusStructureType_Flags 						:= le.BusStructureType_Flags;
		SELF.BusSOSAgeRange 										:= le.BusSOSAgeRange;
		SELF.BusSOSAgeRange_Flags 							:= le.BusSOSAgeRange_Flags;
		SELF.BusPublicRecordAgeRange 						:= le.BusPublicRecordAgeRange;
		SELF.BusPublicRecordAgeRange_Flags 			:= le.BusPublicRecordAgeRange_Flags;
		SELF.BusShellShelfRisk 									:= le.BusShellShelfRisk;
		SELF.BusShellShelfRisk_Flags 						:= le.BusShellShelfRisk_Flags;
		SELF.BusMatchLevel 											:= le.BusMatchLevel;
		SELF.BusMatchLevel_Flags 								:= le.BusMatchLevel_Flags;
		SELF.BusLegalEvents 										:= le.BusLegalEvents;
		SELF.BusLegalEvents_Flags 							:= le.BusLegalEvents_Flags;
		SELF.BusLegalEventsFelonyType 					:= le.BusLegalEventsFelonyType;
		SELF.BusLegalEventsFelonyType_Flags 		:= le.BusLegalEventsFelonyType_Flags;
		SELF.BusHighRiskNewsProfiles 						:= le.BusHighRiskNewsProfiles;
		SELF.BusHighRiskNewsProfiles_Flags 			:= le.BusHighRiskNewsProfiles_Flags;
		SELF.BusLinkedBusRisk 									:= le.BusLinkedBusRisk; 
		SELF.BusLinkedBusRisk_Flags 						:= le.BusLinkedBusRisk_Flags; 
		SELF.BusExecOfficersRisk 								:= le.BusExecOfficersRisk;
		SELF.BusExecOfficersRisk_Flags 					:= le.BusExecOfficersRisk_Flags;
		SELF.BusExecOfficersResidencyRisk 			:= le.BusExecOfficersResidencyRisk;	
		SELF.BusExecOfficersResidencyRisk_Flags := le.BusExecOfficersResidencyRisk_Flags;	
		SELF := [];
	END;

	busIndex := JOIN(businessResults, busRecs,
										LEFT.seq = RIGHT.seq, 
										BusMapOut(LEFT, RIGHT), RIGHT OUTER); 
							

	final :=  UNGROUP(indIndex) + UNGROUP(busIndex);
		
	RETURN OUTPUT(final, NAMED('Results'));
															 
END;


/*--SOAP-- 
<message name="duediligence.duediligence_batch_service">
	<part name="batch_in" sequence="1" type="tns:XmlDataset"/>
	<part name="attributesversion" sequence="2" type="xsd:integer"/>
	<part name="glbapurpose" sequence="5" type="xsd:integer"/>
	<part name="dppapurpose" sequence="6" type="xsd:integer"/>
	<part name="datarestriction" sequence="7" type="xsd:string"/>
	<part name="datapermissionmask" sequence="8" type="xsd:string"/>
</message>
*/

