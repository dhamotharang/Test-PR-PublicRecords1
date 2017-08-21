import Corp2, VehicleV2, DidVille, Business_Header, Watercraft, FAA, tools;

export ValidBatchServiceRun(STRING clientName,
														INTEGER4 clientId,
														STRING processDate,
														SET OF STRING2 noTaxStates = ['AK','DE','MT','NH','OR'],
														SET OF STRING2 searchStates,
														UNSIGNED1 DPPA_Purpose,
														UNSIGNED1 GLB_Purpose,
														STRING realTimePermissableUse,
														BOOLEAN onlyRVs = false, 
                            UNSIGNED minValue = 0,
														BOOLEAN useRealTimeMVR = false,
														BOOLEAN searchVehicle = true,
														BOOLEAN searchAircraft = true,
														BOOLEAN searchWatercraft = true,
														STRING SSN_Masking = 'FULL') := FUNCTION

  #stored('DPPAPurpose', DPPA_Purpose);
  #stored('GLBPurpose', GLB_Purpose);
	
  // all business in noTaxStates
	bus2 := Corp2.Files(,,tools._Constants.IsDataland).Base.Corp.QA(corp_state_origin IN noTaxStates, bdid != 0); 

	busLLC := bus2((stringlib.stringfind(corp_orig_org_structure_desc, 'LIMITED',1) > 0 OR
									stringlib.stringfind(corp_orig_org_structure_desc, 'LTD',1) > 0) AND
								 (corp_foreign_domestic_ind = 'D' OR 
									stringlib.stringfind(corp_orig_org_structure_desc, 'DOMESTIC',1) > 0 OR
									stringlib.stringfind(corp_orig_bus_type_desc, 'DOMESTIC',1) > 0 OR
									corp_state_origin = corp_inc_state)) : INDEPENDENT; // LLCs in noTaxStates

	// Extract Registered Agents from corp data
	busLLCContact := busLLC(corp_ra_state IN searchStates); //LLCs with contacts in searchState(s)

	initSliceRec := RECORD
		unsigned6 bdid;
		string30  corp_key;
		DidVille.Layout_Did_OutBatch;
	END;

	initSliceRec extractInitialInfo(Corp2.Layout_Corporate_Direct_Corp_Base L, INTEGER C) := TRANSFORM
		SELF.bdid := L.bdid;
		SELF.corp_key := L.corp_key;
		SELF.seq := (unsigned4) C; //needed for util
		SELF.ssn := (qSTRING9) '';
		SELF.dob := (qSTRING8) '';
		SELF.phone10 := (qstring10) '';
		SELF.title := (qSTRING5) L.corp_ra_title1;
		SELF.fname := (qSTRING20) L.corp_ra_fname1;
		SELF.mname := (qSTRING20) L.corp_ra_mname1;
		SELF.lname := (qSTRING20) L.corp_ra_lname1;
		SELF.suffix := (qSTRING5) L.corp_ra_name_suffix1;
		SELF.prim_range := (qSTRING10) L.corp_ra_prim_range;
		SELF.predir := (qSTRING2) L.corp_ra_predir;
		SELF.prim_name := (qSTRING28) L.corp_ra_prim_name;
		SELF.addr_suffix := (qSTRING4) L.corp_ra_addr_suffix;
		SELF.postdir := (qSTRING2) L.corp_ra_postdir;
		SELF.unit_desig := (qSTRING10) L.corp_ra_unit_desig;
		SELF.sec_range := (qSTRING8) L.corp_ra_sec_range;
		SELF.p_city_name := (qSTRING25) L.corp_ra_p_city_name;
		SELF.st := (qSTRING2) L.corp_ra_state;
		SELF.z5 := (qSTRING5) L.corp_ra_zip5;
		SELF.zip4 := (qSTRING4) L.corp_ra_zip4;
	END;

	initValues := PROJECT(busLLCContact, extractInitialInfo(LEFT, COUNTER));
	inputNames := PROJECT(initValues, DidVille.Layout_Did_OutBatch);

	//Extract the ra pairings
	outSeqRec := RECORD
		unsigned6 bdid;
		string30 corp_key;
		unsigned4 seq;
	END;
	regAgentSeqPairings := PROJECT(initValues, outSeqRec);

	// get did for name/address combo
	outNames := LuxuryAssetTax.rpc_for_dids(inputNames);
	validOutNames := outNames(score >= 70, did != 0);

	LuxuryAssetTax.Layouts.ContactPairRec matchCompanyRegAgent(outSeqRec L, DidVille.Layout_Did_OutBatch R) := TRANSFORM
		SELF.bdid := L.bdid;
		SELF.corp_key := L.corp_key;
		SELF.did := R.did;
	END;

	foundRegAgentsPairings := JOIN(RegAgentSeqPairings,
																 validOutNames,
																 LEFT.seq = RIGHT.seq,
																 matchCompanyRegAgent(LEFT, RIGHT));
	uniqFoundRegAgentsPairings := DEDUP(SORT(foundRegAgentsPairings, corp_key, bdid, did), corp_key, bdid, did);

	// dedup LLCs
	distBusLLC := DISTRIBUTE(busLLC, HASH32(bdid));
	uniqueBusLLC:= DEDUP(SORT(distBusLLC, bdid, record_type, -dt_vendor_last_reported, local),bdid, local);

	// Extract contacts from Business Header Contacts using BDid
	bhContacts := Business_Header.Files(,tools._Constants.IsDataland).Base.Business_Contacts.QA(state IN searchStates, bdid != 0, did != 0, from_hdr = 'N');
	distBhContacts := DISTRIBUTE(bhContacts, HASH32(bdid));
	uniqueBhContacts := DEDUP(SORT(distBhContacts, bdid, did, local),bdid, did, local);

	LuxuryAssetTax.Layouts.ContactPairRec matchBHContact(Corp2.Layout_Corporate_Direct_Corp_Base L, Business_Header.Layout_Business_Contact_Full_new R) := TRANSFORM
		SELF.bdid := L.bdid;
		SELF.corp_key := L.corp_key;
		SELF.did := R.did;
	END;

	bhContactPairingsInit := JOIN(uniqueBusLLC, uniqueBhContacts, LEFT.bdid = RIGHT.bdid, matchBHContact(LEFT, RIGHT), local);
	bhContactPairings := DEDUP(SORT(bhContactPairingsInit, corp_key, bdid, did), corp_key, bdid, did);
  uniqueBhContactPairings := JOIN(bhContactPairings, uniqFoundRegAgentsPairings, LEFT.corp_key = RIGHT.corp_key AND LEFT.did = RIGHT.did AND LEFT.corp_key = RIGHT.corp_key, TRANSFORM(LEFT), LEFT ONLY);

	// Extract contracts from corp contacts using corp_key
	corpContacts := Corp2.Files(,,tools._Constants.IsDataland).Base.Cont.QA(cont_state IN searchStates, did != 0);
	distCorpContacts := DISTRIBUTE(corpContacts, HASH32(corp_key));
	uniqueCorpContacts := DEDUP(SORT(distCorpContacts, corp_key, did, local), corp_key, did, local);

	corpBusLLC := DISTRIBUTE(uniqueBusLLC, HASH32(corp_key));

	LuxuryAssetTax.Layouts.ContactPairRec matchCorpContact(Corp2.Layout_Corporate_Direct_Corp_Base L, Corp2.Layout_Corporate_Direct_Cont_Base R) := TRANSFORM
		SELF.bdid := L.bdid;
		SELF.corp_key := L.corp_key;
		SELF.did := R.did;
	END;

	corpContactPairingsInit := JOIN(corpBusLLC, uniqueCorpContacts, LEFT.corp_key = RIGHT.corp_key, matchCorpContact(LEFT, RIGHT), local);
	corpContactPairings := DEDUP(SORT(corpContactPairingsInit, corp_key, bdid, did), corp_key, bdid, did);
	
	uniqueCorpContactPairingsInit := JOIN(corpContactPairings, bhContactPairings, LEFT.did = RIGHT.did AND LEFT.corp_key = RIGHT.corp_key, TRANSFORM(LEFT), LEFT ONLY);
	uniqueCorpContactPairings := JOIN(uniqueCorpContactPairingsInit, uniqFoundRegAgentsPairings, LEFT.did = RIGHT.did AND LEFT.corp_key = RIGHT.corp_key, TRANSFORM(LEFT), LEFT ONLY);

	// Merge and dedup all 3 contact inputs
	initialPairings := uniqFoundRegAgentsPairings + uniqueBhContactPairings + uniqueCorpContactPairings;
	totalFoundPairings := DEDUP(SORT(initialPairings, corp_key, bdid, did), corp_key, bdid, did);

	totalFoundPairingsBDid := DEDUP(SORT(totalFoundPairings, bdid), bdid);
	totalFoundPairingsDid := DEDUP(SORT(totalFoundPairings, did), did);

	foundBHContacts := JOIN(uniqueBhContacts, bhContactPairings, LEFT.bdid = RIGHT.bdid AND LEFT.did = RIGHT.did, TRANSFORM(LEFT));

	foundCorpContacts := JOIN(uniqueCorpContacts, corpContactPairings, LEFT.corp_key = RIGHT.corp_key AND LEFT.did = RIGHT.did, TRANSFORM(LEFT));
  foundUniqueCorpContacts := JOIN(uniqueCorpContacts, uniqueCorpContactPairings, LEFT.corp_key = RIGHT.corp_key AND LEFT.did = RIGHT.did, TRANSFORM(LEFT));

  LuxuryAssetTax.Layouts.BusinessList extractBusiness(Corp2.Layout_Corporate_Direct_Corp_Base L) := TRANSFORM
		SELF.bdid := L.bdid;
		SELF.corp_key := L.corp_key;	
	END;
	
	NoContactBusinesses := JOIN(uniqueBusLLC, totalFoundPairings, LEFT.bdid = RIGHT.bdid, extractBusiness(LEFT), LEFT ONLY);
  NoContactBDidList := DEDUP(SORT(NoContactBusinesses, bdid), bdid);

	ContactBusinesses := JOIN(uniqueBusLLC, totalFoundPairings, LEFT.bdid = RIGHT.bdid, extractBusiness(LEFT));
  ContactBDidList := DEDUP(SORT(ContactBusinesses, bdid), bdid);


	// Vehicle specific stuff 
  VehicleOutput := IF(searchVehicle,
	                    findVehicles(NoContactBDidList,
	                                 searchStates, 
																	 totalFoundPairingsDid, 
																	 totalFoundPairingsBDid, 
																	 NoContactBusinesses, 
																	 onlyRVs, 
																	 minValue, 
																	 ContactBusinesses, 
																	 totalFoundPairings, 
																	 busLLC, 
																	 foundBHContacts, 
																	 foundUniqueCorpContacts),
									    DATASET([], Layouts.outputRec)) : INDEPENDENT;

	// Aircraft specific stuff 
  AircraftOutput := IF(searchAircraft,
	                     findAircraft(NoContactBDidList,
																		searchStates, 
																		totalFoundPairingsDid, 
																		totalFoundPairingsBDid, 
																		NoContactBusinesses, 
																		ContactBusinesses, 
																		totalFoundPairings, 
																		busLLC, 
																		foundBHContacts, 
																		foundUniqueCorpContacts),
									    DATASET([], Layouts.outputRec)) : INDEPENDENT;
	
	// Watercraft Specific Stuff
  WatercraftOutput := IF(searchWatercraft,
	                    findWatercraft(NoContactBDidList,
	                                   searchStates, 
																		 totalFoundPairingsDid, 
																		 totalFoundPairingsBDid, 
																		 NoContactBusinesses, 
																		 minValue, 
																		 ContactBusinesses, 
																		 totalFoundPairings, 
																		 busLLC, 
																		 foundBHContacts, 
																		 foundUniqueCorpContacts),
									    DATASET([], Layouts.outputRec)) : INDEPENDENT;  

	RealTimeMVR := IF(useRealTimeMVR,
	                  addRealTimeMVR(totalFoundPairings, foundBHContacts, foundUniqueCorpContacts, busLLC, DPPA_Purpose,
										               GLB_Purpose, realTimePermissableUse ),
									  DATASET([], Layouts.outputRec));

	// Combine the individual outputs
  luxTaxOut := VehicleOutput
				 + AircraftOutput
				 + WatercraftOutput
				 + RealTimeMVR;

  contacts := DEDUP(SORT(totalFoundPairings, did, corp_key, bdid), did, corp_key, bdid);
	contactCorpKeys := DEDUP(SORT(luxTaxOut(out.Process_Flag = 'WC'), rec.corp_key, rec.id), rec.corp_key, rec.id);
	foundContactPairings := JOIN(contacts, 
	                             contactCorpKeys, 
															 LEFT.corp_key = RIGHT.rec.corp_key
															 AND LEFT.bdid = RIGHT.rec.id, 
															 TRANSFORM(LEFT));
	foundContactRecords := addBusinessContacts(foundContactPairings, busLLC, foundBHContacts, foundUniqueCorpContacts);

	luxTaxOut1 := dedupCorps(luxTaxOut);
	luxTaxOut1a := luxTaxOut1 + foundContactRecords;
	
	//Set ClientId fields
	clientIdRec := RECORD
	  string30 corp_key;
    INTEGER4 Client_ID := 0;
	END;
	
	corpKeyIdInit := DEDUP(SORT(PROJECT(luxTaxOut1a, TRANSFORM(clientIdRec, SELF.corp_key := LEFT.rec.corp_key)), corp_key), corp_key);
	corpKeyId := PROJECT(corpKeyIdInit, TRANSFORM(clientIdRec, SELF.Client_ID := COUNTER; SELF := LEFT));
	
	LuxuryAssetTax.Layouts.outputRec addClientId(LuxuryAssetTax.Layouts.outputRec L, clientIdRec R) := TRANSFORM
	  SELF.out.Client_ID := R.Client_ID;
		SELF := L;
	END;
	luxTaxOut2 := JOIN(luxTaxOut1a, corpKeyId, LEFT.rec.corp_key = RIGHT.corp_key, 
	                   addClientId(LEFT, RIGHT), MANY LOOKUP);

  LuxuryAssetTax.Layouts.outputRec maskFirst5(LuxuryAssetTax.Layouts.outputRec L) := TRANSFORM
	  SELF.out.owner1_SSN := IF(L.out.owner1_SSN != '', 'XXXXX' + L.out.owner1_SSN[6..9], '');
		SELF.out.owner2_SSN := IF(L.out.owner2_SSN != '', 'XXXXX' + L.out.owner2_SSN[6..9], '');
		SELF.out.reg_1_ssn := IF(L.out.reg_1_ssn != '', 'XXXXX' + L.out.reg_1_ssn[6..9], '');
		SELF.out.reg_2_ssn := IF(L.out.reg_2_ssn != '', 'XXXXX' + L.out.reg_2_ssn[6..9], '');
		SELF.out.Best_SSN := IF(L.out.Best_SSN != '', 'XXXXX' + L.out.Best_SSN[6..9], '');
		SELF := L;
	END;
	
  LuxuryAssetTax.Layouts.outputRec maskLast4(LuxuryAssetTax.Layouts.outputRec L) := TRANSFORM
	  SELF.out.owner1_SSN := IF(L.out.owner1_SSN != '', L.out.owner1_SSN[1..5] + 'XXXX', '');
		SELF.out.owner2_SSN := IF(L.out.owner2_SSN != '', L.out.owner2_SSN[1..5] + 'XXXX', '');
		SELF.out.reg_1_ssn := IF(L.out.reg_1_ssn != '', L.out.reg_1_ssn[1..5] + 'XXXX', '');
		SELF.out.reg_2_ssn := IF(L.out.reg_2_ssn != '', L.out.reg_2_ssn[1..5] + 'XXXX', '');
		SELF.out.Best_SSN := IF(L.out.Best_SSN != '', L.out.Best_SSN[1..5] + 'XXXX', '');
		SELF := L;
	END;

  LuxuryAssetTax.Layouts.outputRec maskAllSSN(LuxuryAssetTax.Layouts.outputRec L) := TRANSFORM
	  SELF.out.owner1_SSN := IF(L.out.owner1_SSN != '', 'XXXXXXXXX', '');
		SELF.out.owner2_SSN := IF(L.out.owner2_SSN != '', 'XXXXXXXXX', '');
		SELF.out.reg_1_ssn := IF(L.out.reg_1_ssn != '', 'XXXXXXXXX', '');
		SELF.out.reg_2_ssn := IF(L.out.reg_2_ssn != '', 'XXXXXXXXX', '');
		SELF.out.Best_SSN := IF(L.out.Best_SSN != '', 'XXXXXXXXX', '');
		SELF := L;
	END;
	
	//Mask SSNs as applicable
  luxTaxOut3 := IF(SSN_Masking = 'NONE',
	                 luxTaxOut2,
									 IF(SSN_Masking = 'FIRST5',
									    PROJECT(luxTaxOut2, maskFirst5(LEFT)),
											IF(SSN_Masking = 'LAST4',
											   PROJECT(luxTaxOut2, maskLast4(LEFT)),
												 PROJECT(luxTaxOut2, maskAllSSN(LEFT)))));
												 
	//group the output by business, and sort registrations individually from latest to earliest.
	sortedLuxTaxOut := SORT(luxTaxOut3, rec.corp_key, out.Id_Number, -rec.sort1, -rec.sort2);
	
	//OUTPUT statistics file
	statFile := '~thor_data400::stats::luxury_asset_tax::'+ processDate + '::' + clientName;
	numContactBusinesses := COUNT(DEDUP(SORT(ContactBusinesses, corp_key), corp_key));
	numNoContactBusinessWithVehicle := COUNT(DEDUP(SORT(luxTaxOut2(out.Process_Flag = 'WOC'), rec.corp_key), rec.corp_key));
	numBusinessWithIncoprYearMatch := COUNT(DEDUP(SORT(luxTaxOut2(out.Incorp_Reg_Year_Match = 'Y'), rec.corp_key), rec.corp_key));
	numBusinessWithBoughtBeforeLLCIncorp := COUNT(DEDUP(SORT(luxTaxOut2(out.Bought_Before_LLC_Incorp = 'Y'), rec.corp_key), rec.corp_key));
	// per product: still owns means the most recent registration for an asset was owned by the business or contact
	mostRecentRecords := DEDUP(luxTaxOut2, rec.corp_key, out.Id_Number);
	numBusinessWithBusinessOwned := COUNT(DEDUP(SORT(mostRecentRecords(out.Business_Owned = 'Y'), rec.corp_key), rec.corp_key));
	numBusinessWithContactOwned := COUNT(DEDUP(SORT(mostRecentRecords(out.Contact_Owned = 'Y'), rec.corp_key), rec.corp_key));

  stateRec := record
    STRING state;
  end;

  noTaxStateDS := DATASET(noTaxStates, stateRec);
	searchStateDS := DATASET(searchStates, stateRec);

	stateRec makeString(stateRec L, stateRec R) := TRANSFORM
	 SELF.state := L.state + ', ' + R.state;
	END;

	noTaxStateStr := ROLLUP(noTaxStateDS, true, makeString(LEFT, RIGHT));
	searchStateStr := ROLLUP(searchStateDS, true, makeString(LEFT, RIGHT));
	
	statDS := DATASET([{'Account Name: ' + clientName},
	                   {'Account Number: ' + (STRING) clientId},
										 {'Process Date of File: ' + (STRING) processDate},
										 {'No Tax States used: ' + noTaxStateStr[1].state},
										 {'Search States used: ' + searchStateStr[1].state},
										 {'InHouse Motor Vehicles Searched: ' + IF(searchVehicle,'Yes','No')},
										 {'Watercraft Searched: ' + IF(searchWatercraft,'Yes','No')},
										 {'Aircraft Searched: ' + IF(searchAircraft,'Yes','No')},
										 {'Real Time Motor Vehicles Searched: ' + IF(useRealTimeMVR,'Yes','No')},
										 {'Total Number of Businesses with State Contacts: ' + (STRING) numContactBusinesses},
										 {'Total Number of Businesses without State Contacts with State Registrations: ' + (STRING) numNoContactBusinessWithVehicle},
										 {'Total Number of Businesses whose Incorporation Year matches First Registration Year: ' + (STRING) numBusinessWithIncoprYearMatch},
										 {'Total Number of Businesses where the asset was bought before the LLC was incorporated: ' + (STRING) numBusinessWithBoughtBeforeLLCIncorp},
										 {'Total Number of Businesses where the business still owns the asset: ' + (STRING) numBusinessWithBusinessOwned},
										 {'Total Number of Businesses where the contact still owns the asset: ' + (STRING) numBusinessWithContactOwned}
										], {STRING120 statLine});

	RTInCount := 0 : stored('LuxuryAssetTaxRTInCount');
	RTOutCount := 0 : stored('LuxuryAssetTaxRTOutCount');
	RTStatDS := DATASET([{'Number of Inputs to RT Polk Gateway: ' + RTInCount},
	                     {'Number of Outputs received from RT Polk Gateway: ' + RTOutCount}
										], {STRING120 statLine});

	LuxuryAssetTax.Layouts.Layout_Final_Output extractOutput(LuxuryAssetTax.Layouts.outputRec L) := TRANSFORM
		SELF := L.out;
	END;	
	finalLuxTaxOut := PROJECT(sortedLuxTaxOut, extractOutput(LEFT));   
	
  OUTPUT(IF(useRealTimeMVR, statDS() + RTStatDS(), statDS()),,statFile, CSV, OVERWRITE);

	return finalLuxTaxOut;
END;