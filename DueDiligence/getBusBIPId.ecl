IMPORT Address, BIPV2, Business_Risk, Business_Risk_BIP, DueDiligence, Risk_Indicators, RiskWise, STD, ut;

EXPORT getBusBIPId(DATASET(DueDiligence.Layouts.CleanedData) indata,
										Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
										BIPV2.mod_sources.iParams linkingOptions,
										BOOLEAN includeReport) := FUNCTION



	// ------                                                                                     ------
	// ------ check to see if any of the input provided a seleid to search on                     ------  
	// ------ IF YES                                                                              ------
	// ------      proceed by calling the SearchInputByLEXID                                      ------
	// ------                                                                                     ------
	inputLexID := indata((UNSIGNED)cleanedInput.business.lexID > 0);
	
	searchInputByLexID := PROJECT(inputLexID, TRANSFORM(BIPV2.IDFunctions.rec_SearchInput, 
																											SELF.inSeleid := LEFT.cleanedInput.business.lexID; 
																											SELF.acctNo := (STRING)LEFT.cleanedInput.seq; 
																											SELF := [];));

	linkIDs := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(searchInputByLexID).Data2_;
	
	joinFoundBipIDs := JOIN(inputLexID, linkIDs,
													LEFT.cleanedInput.seq = (UNSIGNED)RIGHT.acctNo AND
													LEFT.cleanedInput.business.lexID = (STRING)RIGHT.seleID,
													TRANSFORM({BOOLEAN lessSearchDate, RECORDOF(RIGHT)},
																			lessThanDt := IF(LEFT.cleanedInput.historyDateYYYYMMDD = DueDiligence.Constants.date8Nines, STD.Date.Today(), LEFT.cleanedInput.historyDateYYYYMMDD);
																			dateFirstSeen := (UNSIGNED)DueDiligence.Common.checkInvalidDate((STRING)RIGHT.dt_first_seen);
																			SELF.lessSearchDate := IF(dateFirstSeen < lessThanDt AND dateFirstSeen > 0, TRUE, FALSE);
																			SELF := RIGHT;
																			SELF := [];),
													LEFT OUTER);

	sortFoundBipsByDate := SORT(joinFoundBipIDs(lessSearchDate), seleID, -dt_last_seen, -dt_vendor_last_reported);
	rollFoundBips := ROLLUP(sortFoundBipsByDate,
													LEFT.seleID = RIGHT.seleID,
													TRANSFORM({RECORDOF(LEFT)}, SELF := LEFT;));
	
	//This data will include an address associated with this LexID
	addFoundBipIDs := JOIN(indata, rollFoundBips,
													LEFT.cleanedInput.business.lexID = (STRING)RIGHT.seleID,
													TRANSFORM(DueDiligence.Layouts.CleanedData,
																			SELF.cleanedInput.business.BIP_IDs.PowID.LinkID := RIGHT.powID;
																			SELF.cleanedInput.business.BIP_IDs.ProxID.LinkID := RIGHT.proxID;
																			SELF.cleanedInput.business.BIP_IDs.SeleID.LinkID := RIGHT.seleID;
																			SELF.cleanedInput.business.BIP_IDs.OrgID.LinkID := RIGHT.orgID;
																			SELF.cleanedInput.business.BIP_IDs.UltID.LinkID := RIGHT.ultID;
																			SELF := LEFT;),
													LEFT OUTER);
	//Put the data including the Clean this address into the Busines Shell layout for the further processing by the BIP_LINK_ID_Append logic
	cleanedInput := DueDiligence.CommonBusiness.GetCleanBIPShell(addFoundBipIDs);
	
	//Do 1 more reformatting step to Grab just the clean input to pass to the BIP Linking Process
	prepBIPAppend := PROJECT(cleanedInput, TRANSFORM(Business_Risk_BIP.Layouts.Input, SELF := LEFT.Clean_Input));
	
	
	// ------                                                                                     ------
	// ------ Continue the BIP Linking process                                                    ------  
	// ------  at this point some companies have a LinkID and some don't                          ------
	// ------  the end result is all companies will have a LINKID appended                        ------
	
	bipAppend := Business_Risk_BIP.BIP_LinkID_Append(prepBIPAppend);

  
	final := JOIN(indata, bipAppend,
								LEFT.cleanedInput.seq = RIGHT.seq,
								TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																			SELF.seq := LEFT.cleanedInput.seq;
																			
																			SELF.busn_info.BIP_IDs.UltID.LinkID := RIGHT.UltID.LinkID;
																			SELF.busn_info.BIP_IDs.OrgID.LinkID := RIGHT.OrgID.LinkID;
																			SELF.busn_info.BIP_IDs.SeleID.LinkID := RIGHT.SeleID.LinkID;
																			SELF.busn_info.BIP_IDs.ProxID.LinkID := RIGHT.ProxID.LinkID;
																			SELF.busn_info.BIP_IDs.PowID.LinkID := RIGHT.PowID.LinkID;
																			
																			SELF.busn_info.lexID := (STRING)RIGHT.SeleID.LinkID;
																			SELF.historyDate := LEFT.cleanedInput.historyDateYYYYMMDD;
																			
																			SELF.inputaddressprovided := LEFT.cleanedInput.addressProvided;
																			SELF.fullinputaddressprovided := LEFT.cleanedInput.fullAddressProvided;
																			SELF.relatedDegree := DueDiligence.Constants.INQUIRED_BUSINESS_DEGREE;
																			
																			SELF.busn_info := LEFT.cleanedInput.business;
																			SELF.busn_input := LEFT.inputEcho.business;
																			
																			SELF := [];),
								LEFT OUTER);

	
	
	
	// OUTPUT(indata, NAMED('indata'));
	// OUTPUT(inputLexID, NAMED('inputLexID'));
	// OUTPUT(searchInputByLexID, NAMED('searchInputByLexID'));
	// OUTPUT(linkIDs, NAMED('linkIDs'));
	
	// OUTPUT(joinFoundBipIDs, NAMED('joinFoundBipIDs'));
	// OUTPUT(sortFoundBipsByDate, NAMED('sortFoundBipsByDate'));
	// OUTPUT(rollFoundBips, NAMED('rollFoundBips'));
	// OUTPUT(addFoundBipIDs, NAMED('addFoundBipIDs'));
	
	// OUTPUT(cleanedInput, NAMED('cleanedInput'));
	// OUTPUT(prepBIPAppend, NAMED('prepBIPAppend'));
	// OUTPUT(bipAppend, NAMED('bipAppend'));
	// OUTPUT(final, NAMED('final'));
	
	return final;

END;