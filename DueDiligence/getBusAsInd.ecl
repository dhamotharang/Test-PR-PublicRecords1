IMPORT Advo, BIPv2, Business_Risk, Business_Risk_BIP, Drivers, DueDiligence, doxie, Header, MDR, Risk_Indicators, STD, UT;

/* 
	Following Keys being used:
			Advo.Key_Addr1_history
			doxie.Key_Header_SSN
			doxie.Key_Header
			Business_Risk.Key_SSN_Address
*/

EXPORT getBusAsInd(DATASET(DueDiligence.Layouts.Busn_Internal) indata,
										Business_Risk_BIP.LIB_Business_Shell_LIBIN options) := FUNCTION

  //grab the operating locations
  operatingLocations := DueDiligence.CommonBusiness.GetChildAsInquired(indata, operatingLocations, DueDiligence.Constants.OPERATING_LOCATION);
  
  //add operating locations and the inquired business together
  partiesToCheck := indata + operatingLocations;

	/*Taken from Business_Risk_BIP.getBusinessHeader*/
	withAdvoRaw := JOIN(partiesToCheck, Advo.Key_Addr1_history,
											LEFT.Busn_info.address.zip5 != DueDiligence.Constants.EMPTY AND 
											LEFT.Busn_info.address.prim_range != DueDiligence.Constants.EMPTY AND
											KEYED(LEFT.Busn_info.address.zip5 = RIGHT.zip) AND
											KEYED(LEFT.Busn_info.address.prim_range = RIGHT.prim_range) AND
											KEYED(LEFT.Busn_info.address.prim_name = RIGHT.prim_name) AND
											KEYED(LEFT.Busn_info.address.addr_suffix = RIGHT.addr_suffix) AND
											KEYED(LEFT.Busn_info.address.predir = RIGHT.predir) AND
											KEYED(LEFT.Busn_info.address.postdir = RIGHT.postdir) AND
											KEYED(LEFT.Busn_info.address.sec_range = RIGHT.sec_range),
											TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, STRING2 partyIndicator, UNSIGNED4 historyDate, RECORDOF(RIGHT), INTEGER advoDtfirstseen},
																	SELF.Residential_or_Business_Ind := RIGHT.Residential_or_Business_Ind;
																	SELF.advoDtfirstseen := (INTEGER)RIGHT.date_first_seen;
																	SELF.seq := LEFT.seq;
																	SELF.ultID := LEFT.Busn_info.BIP_IDs.UltID.LinkID;
																	SELF.orgID := LEFT.Busn_info.BIP_IDs.OrgID.LinkID;
																	SELF.seleID := LEFT.Busn_info.BIP_IDs.SeleID.LinkID;
																	SELF.historyDate := LEFT.historyDate;
                                  SELF.partyIndicator := LEFT.relatedDegree;
																	SELF := RIGHT;
																	SELF := [];), 
											LEFT OUTER, ATMOST(DueDiligence.Constants.MAX_ATMOST_100));

	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	advoCleanRecs := DueDiligence.Common.CleanDatasetDateFields(withAdvoRaw, 'advoDtfirstseen, date_first_seen, date_vendor_first_reported');
	
	// Filter out records after our history date.
	advoFilt := DueDiligence.Common.FilterRecords(advoCleanRecs, date_first_seen, date_vendor_first_reported);
																	
	advoOnInputAddrSort := SORT(advoFilt, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), partyIndicator, zip, prim_range,	prim_name, addr_suffix, predir, postdir, sec_range, -advoDtfirstseen); 
	advoDedup := DEDUP(advoOnInputAddrSort, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), partyIndicator, zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range);
																									
	rollAdvo := ROLLUP(advoDedup,
                      #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                      LEFT.partyIndicator = RIGHT.partyIndicator, 
											TRANSFORM(RECORDOF(LEFT),
																SELF.Residential_or_Business_Ind := IF(LEFT.Residential_or_Business_Ind = DueDiligence.Constants.EMPTY, RIGHT.Residential_or_Business_Ind, LEFT.Residential_or_Business_Ind);
																SELF := LEFT;));
                                
  //add the address type to the operating locations
	initialOpLocations := DueDiligence.CommonBusiness.GetOperatingLocations(indata);
	addOpLocAddrType := JOIN(initialOpLocations, rollAdvo(partyIndicator = DueDiligence.Constants.OPERATING_LOCATION),
                            #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
                            TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DATASET(DueDiligence.Layouts.CommonGeographicLayout) opLocations},
                                      SELF.opLocations := DATASET([TRANSFORM(DueDiligence.Layouts.CommonGeographicLayout,
                                                                              SELF.addressType := RIGHT.Residential_or_Business_Ind;
                                                                              SELF := LEFT;)]);
                                      SELF := LEFT;),
                            LEFT OUTER);
	
										
	//reAdd operating locations
	addOperatingLocation := DueDiligence.CommonBusiness.readdOperatingLocations(indata, addOpLocAddrType, opLocations);                                

																
	addResidentialAddr := JOIN(addOperatingLocation, rollAdvo(partyIndicator = DueDiligence.Constants.INQUIRED_BUSINESS_DEGREE),
															#EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),	
															TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																				SELF.residentialAddr := RIGHT.Residential_or_Business_Ind;
																				SELF.busIsSOHO := LEFT.busIsSOHO OR (RIGHT.Residential_or_Business_Ind = 'A' AND LEFT.SOSIncorporationDate > 0);
																				SELF := LEFT;),
															LEFT OUTER);
													
	/*Taken from Business_Risk_BIP.getConsumerHeader*/
	// Grab all DID's associated with that SSN (FEIN) 
	feinSsn_dids := JOIN(indata, doxie.Key_Header_SSN, //Input Business FEIN Matches Header SSN
											(INTEGER)LEFT.Busn_info.fein > 0 AND LENGTH(TRIM(LEFT.Busn_info.fein)) = 9 AND
											KEYED(LEFT.Busn_info.fein[1] = RIGHT.S1 AND 
														LEFT.Busn_info.fein[2] = RIGHT.S2 AND 
														LEFT.Busn_info.fein[3] = RIGHT.S3 AND 
														LEFT.Busn_info.fein[4] = RIGHT.S4 AND 
														LEFT.Busn_info.fein[5] = RIGHT.S5 AND 
														LEFT.Busn_info.fein[6] = RIGHT.S6 AND 
														LEFT.Busn_info.fein[7] = RIGHT.S7 AND 
														LEFT.Busn_info.fein[8] = RIGHT.S8 AND 
														LEFT.Busn_info.fein[9] = RIGHT.S9),
											TRANSFORM({UNSIGNED4 seq, UNSIGNED6 ultID, UNSIGNED6 orgID, UNSIGNED6 seleID, UNSIGNED6 historyDate, BOOLEAN feinMatched, STRING fein, 
																		STRING10 prim_range, STRING2  predir, STRING28 prim_name, STRING4  addr_suffix, STRING2  postdir, STRING10 unit_desig, 
																		STRING8  sec_range, STRING25 city, STRING2  state, STRING5  zip5, STRING4  zip4, STRING companyName, RECORDOF(RIGHT)},
																SELF.ultID := LEFT.Busn_info.BIP_IDs.UltID.LinkID;
																SELF.orgID := LEFT.Busn_info.BIP_IDs.OrgID.LinkID;
																SELF.seleID := LEFT.Busn_info.BIP_IDs.SeleID.LinkID;
																SELF.seq := LEFT.seq;
																SELF.historyDate := LEFT.historyDate;
																SELF.companyName := LEFT.busn_info.companyName;
																SELF.feinMatched := RIGHT.did > 0;
																SELF.fein := LEFT.busn_info.fein;
																SELF.prim_range := LEFT.busn_info.address.prim_range;
																SELF.predir := LEFT.busn_info.address.predir;
																SELF.prim_name := LEFT.busn_info.address.prim_name;
																SELF.addr_suffix := LEFT.busn_info.address.addr_suffix;
																SELF.postdir := LEFT.busn_info.address.postdir;
																SELF.unit_desig := LEFT.busn_info.address.unit_desig;
																SELF.sec_range := LEFT.busn_info.address.sec_range;
																SELF.city := LEFT.busn_info.address.city;
																SELF.state := LEFT.busn_info.address.state;
																SELF.zip5 := LEFT.busn_info.address.zip5;
																SELF.zip4 := LEFT.busn_info.address.zip4;
																SELF := RIGHT;
																SELF := [];),
											ATMOST(Business_Risk_BIP.Constants.Limit_Default));
																	
	// ------                                                                                    ------
	// ------ The FEIN is assigned via IRS and SSN's are assigned via Social Security            ------
	// ------ Administration                                                                     ------
	// ------ The IRS does not intentionally assign a TIN that is the same as SSN                ------
  // ------ but it does happen.  Attempt to find these cases through this logic                ------
	// ------                                                                                    ------		
  
  uniqueDIDs := ROLLUP(SORT(feinSsn_dids, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did), 
												#EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
												LEFT.did = RIGHT.did,
												TRANSFORM({RECORDOF(LEFT)},
																		SELF.feinMatched := LEFT.feinMatched OR RIGHT.feinMatched;
																		SELF.fein        := MAP(LEFT.feinMatched => LEFT.fein,
																											     RIGHT.feinMatched => RIGHT.fein,
																											                          DueDiligence.Constants.EMPTY);
																		SELF             := LEFT;));
                                    
  SimpleBusinessExecutives   := DueDiligence.CommonBusiness.getexecs(indata);   											
																			
	//keep only rows where FEIN is an SSN AND SSN belongs to one of the Business Executives listed in the Inquired Business
  FEINisSSNofBEO     := JOIN (SimpleBusinessExecutives, uniqueDIDs,
                           #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
												   LEFT.did = RIGHT.did,
                           TRANSFORM({RECORDOF(RIGHT)},
                               SELF    := RIGHT;), 
                           KEEP(1), ATMOST(DueDiligence.Constants.MAX_ATMOST_1000));  
                           
                           
  // -----                                                                                     ------
  // ----- If the FEIN is an SSN of a BEO then continue looking up information for this DID    ------
  // -----                                                                                     ------
  
																			
	consumerHeaderDidRaw := JOIN(FEINisSSNofBEO, doxie.Key_Header, 
																LEFT.did > 0 AND 
																KEYED(LEFT.did = RIGHT.s_did) AND
																((INTEGER)LEFT.fein > 0 AND LEFT.fein = RIGHT.ssn) AND 
																// check permissions
																ut.PermissionTools.glb.SrcOk(Options.GLBA_Purpose, RIGHT.src, RIGHT.dt_first_seen) AND
																RIGHT.src NOT IN Risk_Indicators.iid_constants.masked_header_sources(Options.DataRestrictionMask, FALSE) AND
																(MDR.Source_is_DPPA(RIGHT.src) = FALSE OR
																(Risk_Indicators.iid_constants.DPPA_OK(Options.DPPA_Purpose, FALSE) AND Drivers.State_DPPA_OK(Header.TranslateSource(RIGHT.src), Options.DPPA_Purpose, RIGHT.src))) AND
																Risk_Indicators.iid_constants.filtered_source(RIGHT.src, RIGHT.st) = FALSE,
																TRANSFORM({STRING dt_first_seen, INTEGER feinPersonAddrOverlap, UNSIGNED feinPersonNameMatchLevel, STRING fname,
                                                                 STRING mname, STRING lname, STRING name_suffix, STRING dt_last_seen, RECORDOF(LEFT)},
																					
																					isBusinessRecord := LEFT.feinMatched;
																					feinMatched := (INTEGER)LEFT.fein > 0 AND LEFT.fein = RIGHT.ssn AND isBusinessRecord;
																					
																					SELF.dt_first_seen := IF(RIGHT.dt_first_seen > 0, (STRING)RIGHT.dt_first_seen, (STRING)RIGHT.dt_vendor_first_reported);
																					SELF.dt_last_seen := IF(RIGHT.dt_last_seen > 0, (STRING)RIGHT.dt_last_seen, (STRING)RIGHT.dt_vendor_last_reported);
																					
																					fNameHit := feinMatched AND Business_Risk_BIP.Common.fn_isFoundInCompanyName(LEFT.companyName, RIGHT.fname);
																					lNameHit := feinMatched AND Business_Risk_BIP.Common.fn_isFoundInCompanyName(LEFT.companyName, RIGHT.lname);
																					nameSimilar := fNameHit OR lNameHit;
																					
																					addressPopulated := TRIM(LEFT.prim_Name) <> DueDiligence.Constants.EMPTY AND TRIM(LEFT.zip5) <> DueDiligence.Constants.EMPTY;
																					zipScore := IF(feinMatched, Risk_Indicators.AddrScore.ZIP_Score(LEFT.Zip5, RIGHT.Zip), 255);
																					cityStateScore := IF(feinMatched, Risk_Indicators.AddrScore.CityState_Score(LEFT.city, LEFT.state, RIGHT.city_name, RIGHT.st, DueDiligence.Constants.EMPTY), 255);
																					
																					addressScore := Risk_Indicators.AddrScore.AddressScore(LEFT.prim_range, LEFT.prim_name, LEFT.sec_range, 
																																																RIGHT.prim_range, RIGHT.prim_name, RIGHT.sec_range,
																																																zipScore, cityStateScore);	
																					addressMatched := Risk_Indicators.iid_constants.ga(addressScore) AND addressPopulated AND feinMatched;

																					SELF.feinPersonAddrOverlap := MAP(feinMatched AND NOT addressPopulated => -1,		
																																								(INTEGER)LEFT.fein = DueDiligence.Constants.NUMERIC_ZERO	OR NOT isBusinessRecord => -2, // -2s will be set to 0, but need something smaller than -1 since -1 should take precedence in MAX() in Rollup.
																																								(INTEGER)RIGHT.did = DueDiligence.Constants.NUMERIC_ZERO OR NOT feinMatched AND addressPopulated => -2, 
																																								(INTEGER)RIGHT.did <> DueDiligence.Constants.NUMERIC_ZERO  AND NOT addressMatched AND feinMatched AND addressPopulated => 1,
																																								(INTEGER)RIGHT.did <> DueDiligence.Constants.NUMERIC_ZERO  AND addressMatched AND feinMatched AND addressPopulated => 2,
																																								-1);
																																																																				 
																					SELF.feinPersonNameMatchLevel := IF((INTEGER)RIGHT.did <> DueDiligence.Constants.NUMERIC_ZERO AND nameSimilar AND feinMatched, 1, DueDiligence.Constants.NUMERIC_ZERO);																																						 
																					
                                          SELF := RIGHT;
																					SELF := LEFT;
																					SELF := [];),
																ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	consumerHeaderCleanRecs := DueDiligence.Common.CleanDatasetDateFields(consumerHeaderDidRaw, 'dt_first_seen, dt_last_seen');
	
	// Filter out records after our history date.
	consumerHeaderDidFiltRecs := DueDiligence.Common.FilterRecordsSingleDate(consumerHeaderCleanRecs, dt_first_seen);
															
	// Determine if any records matched per Seq/DID
	consumerHeaderDidStats := TABLE(consumerHeaderDidFiltRecs, {seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did,
																															 busFEINLinkedPersonAddr := MAX(GROUP, feinPersonAddrOverlap),
																															 feinPersonNameMatch := MAX(GROUP, feinPersonNameMatchLevel)},
																	seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);

	// Determine counts by Seq
	consumerHeaderDidCounts := ROLLUP(SORT(consumerHeaderDidStats, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids())), 
																		#EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()), 
																		TRANSFORM(RECORDOF(LEFT),
																							SELF.busFEINLinkedPersonAddr := MAX(LEFT.busFEINLinkedPersonAddr, RIGHT.busFEINLinkedPersonAddr);
																							SELF.feinPersonNameMatch := MAX(LEFT.feinPersonNameMatch, RIGHT.feinPersonNameMatch);
																							SELF := LEFT));
	//******
  //***
  //******
	addFeinMatchNameAddr := JOIN(addResidentialAddr, consumerHeaderDidCounts,
																#EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
																TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																					SELF.feinIsSSN := LEFT.feinIsSSN OR (RIGHT.feinPersonNameMatch > DueDiligence.Constants.NUMERIC_ZERO OR RIGHT.busFEINLinkedPersonAddr > DueDiligence.Constants.NUMERIC_ZERO);
																					SELF.personNameSSN := RIGHT.feinPersonNameMatch;
																					SELF.personAddrSSN := RIGHT.busFEINLinkedPersonAddr;																					
																					SELF.busIsSOHO := LEFT.busIsSOHO OR 
																														(RIGHT.busFEINLinkedPersonAddr = 2 OR RIGHT.feinPersonNameMatch = 1) AND LEFT.SOSIncorporationDate > DueDiligence.Constants.NUMERIC_ZERO;
																					SELF := LEFT;),
																LEFT OUTER);
                                
  //sort individuals
  sortConsumerHeader := SORT(consumerHeaderDidFiltRecs, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, -dt_last_seen);  
  
  rollupIndvForNames := ROLLUP(sortConsumerHeader,
                               #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                               LEFT.did = RIGHT.did,
                               TRANSFORM(RECORDOF(LEFT),
                                          SELF := LEFT;));

  
  //sort and limit the number of names
  sortAndGroupNames := GROUP(SORT(rollupIndvForNames, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -dt_last_seen), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));  
 
 
  DueDiligence.LayoutsInternal.MultipleNames getMaxNames(sortAndGroupNames sagn, INTEGER cnt) := TRANSFORM, SKIP(cnt > DueDiligence.Constants.MAX_ASSOCIATED_FEIN_NAMES)
    SELF.nameAndDate := DATASET([TRANSFORM(DueDiligence.Layouts.LayoutAgent,
                                            SELF.firstName := sagn.fname;
                                            SELF.middleName := sagn.mname;
                                            SELF.lastName := sagn.lname;
                                            SELF.suffix := sagn.name_suffix;
                                            SELF.dateLastSeen := sagn.dt_last_seen;
                                            SELF := [])]);
    SELF := sagn;
    SELF := [];
  
  END;
 
 
  //reformat to add max individuals
  formatNames := UNGROUP(PROJECT(sortAndGroupNames, getMaxNames(LEFT, COUNTER)));

	
  //combine names for the same inquired business															
  rollIndvFormatNames := ROLLUP(SORT(formatNames, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids())),
                                 #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
                                 TRANSFORM(RECORDOF(LEFT),
                                            SELF.nameAndDate := LEFT.nameAndDate + RIGHT.nameAndDate;
                                            SELF := LEFT;));
                                            
  //add names that share the same fein
  addNamesByFein := JOIN(addFeinMatchNameAddr, rollIndvFormatNames,
                          #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
                          TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                    SELF.namesAssocWithFein := RIGHT.nameAndDate;
                                    SELF := LEFT;),
                          LEFT OUTER);
                                
                                
                                
	//check if the fein is an SSN by address
	checkFeinIsSSN := JOIN(indata, Business_Risk.Key_SSN_Address,
													LEFT.busn_info.address.prim_name != DueDiligence.Constants.EMPTY and
													KEYED(LEFT.busn_info.fein = RIGHT.ssn) and
													KEYED(LEFT.busn_info.address.prim_name = RIGHT.prim_name),
													TRANSFORM({BOOLEAN isSSN, RECORDOF(DueDiligence.Layouts.Busn_Internal)},
																		SELF.isSSN := IF(LEFT.busn_info.fein = DueDiligence.Constants.EMPTY, FALSE, LEFT.busn_info.fein = RIGHT.ssn);
																		SELF := LEFT;),
													LEFT OUTER, KEEP(100));
													
	rollFeinCheck := ROLLUP(SORT(checkFeinIsSSN, seq, #EXPAND(DueDiligence.Constants.mac_ListTop3Linkids())),
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.Busn_info.BIP_IDS.UltID.LinkID AND
													LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.Busn_info.BIP_IDS.OrgID.LinkID AND
													LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.Busn_info.BIP_IDS.SeleID.LinkID,
													TRANSFORM({RECORDOF(checkFeinIsSSN)},
																		SELF.isSSN := LEFT.isSSN OR RIGHT.isSSN;
																		SELF := LEFT;));
													
	addFeinAsSSN := JOIN(addNamesByFein, rollFeinCheck,
												LEFT.seq = RIGHT.seq AND
												LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.Busn_info.BIP_IDS.UltID.LinkID AND
												LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.Busn_info.BIP_IDS.OrgID.LinkID AND
												LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.Busn_info.BIP_IDS.SeleID.LinkID,
												TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																	SELF.feinIsSSN := LEFT.feinIsSSN OR RIGHT.isSSN;
																	SELF := LEFT;),
												LEFT OUTER);
	

	
	
	
	// OUTPUT(indata, NAMED('indata'));
	// OUTPUT(partiesToCheck, NAMED('partiesToCheck'));
	
	// OUTPUT(withAdvoRaw, NAMED('withAdvoRaw'));
	// OUTPUT(advoFiltRecs, NAMED('advoFiltRecs'));
	// OUTPUT(advoFilt, NAMED('advoFilt'));
	// OUTPUT(advoOnInputAddrSort, NAMED('advoOnInputAddrSort'));
	// OUTPUT(advoDedup, NAMED('advoDedup'));
	// OUTPUT(rollAdvo, NAMED('rollAdvo'));
  
	// OUTPUT(initialOpLocations, NAMED('initialOpLocations'));
	// OUTPUT(addOpLocAddrType, NAMED('addOpLocAddrType'));
	// OUTPUT(addOperatingLocation, NAMED('addOperatingLocation'));
  // OUTPUT(addResidentialAddr, NAMED('addResidentialAddr'));
	
	// OUTPUT(feinSsn_dids, NAMED('feinSsn_dids'));
	// OUTPUT(uniqueDIDs, NAMED('uniqueDIDs'));
  
  // OUTPUT(SimpleBusinessExecutives, NAMED('SimpleBusinessExecutives'));
	// OUTPUT(FEINisSSNofBEO, NAMED('FEINisSSNofBEO'));
  
	// OUTPUT(consumerHeaderDidRaw, NAMED('consumerHeaderDidRaw'));
	// OUTPUT(consumerHeaderDidFiltRecs, NAMED('consumerHeaderDidFiltRecs'));
	// OUTPUT(consumerHeaderDidStats, NAMED('consumerHeaderDidStats'));
	// OUTPUT(sortConsumerHeader, NAMED('sortConsumerHeader'));
	// OUTPUT(rollupIndvForNames, NAMED('rollupIndvForNames'));
	// OUTPUT(sortAndGroupNames, NAMED('sortAndGroupNames'));
	// OUTPUT(formatNames, NAMED('formatNames'));
	// OUTPUT(rollIndvFormatNames, NAMED('rollIndvFormatNames'));
	// OUTPUT(addNamesByFein, NAMED('addNamesByFein'));
	// OUTPUT(consumerHeaderDidCounts, NAMED('consumerHeaderDidCounts'));
	// OUTPUT(addFeinMatchNameAddr, NAMED('addFeinMatchNameAddr'));
	
	// OUTPUT(checkFeinIsSSN, NAMED('checkFeinIsSSN'));
	// OUTPUT(addFeinAsSSN, NAMED('addFeinAsSSN'));
	
	RETURN addFeinAsSSN;
END;