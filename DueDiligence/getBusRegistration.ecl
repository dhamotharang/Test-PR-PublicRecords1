IMPORT Address_Attributes, Business_Risk, BIPV2, BusReg, Business_Risk_BIP, DueDiligence, Corp2, Riskwise, Risk_Indicators, business_header;

/* 
	Following Keys being used:
			BusReg.key_busreg_company_linkids.kFetch2
*/

EXPORT getBusRegistration(DATASET(DueDiligence.Layouts.Busn_Internal) indata,
													Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
													BIPV2.mod_sources.iParams linkingOptions) := FUNCTION


	// ---------------- BusReg - Business Registration ------------------
	regBusRaw := BusReg.key_busreg_company_linkids.kFetch2(DueDiligence.Common.GetLinkIDs(indata),
																												 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																												 0, /*ScoreThreshold --> 0 = Give me everything*/
																												 Business_Risk_BIP.Constants.Limit_Default,
																												 Options.KeepLargeBusinesses);
	
	// Add back our Seq numbers
	regBusSeq := DueDiligence.Common.AppendSeq(regBusRaw, indata, TRUE);

	// Filter out records after our history date.
	regBusFiltRec := DueDiligence.Common.FilterRecords(regBusSeq, dt_first_seen, dt_vendor_first_reported);
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently - dates used in FilterRecords have been cleaned
	cleanRB_recordDt := DueDiligence.Common.CleanDateFields(regBusFiltRec, record_date);
	cleanRB_dateLastSeen := DueDiligence.Common.CleanDateFields(cleanRB_recordDt, dt_last_seen);

	//creating variable to be used in logic so if add additional dates, does not impact flow
	regBusFilt := cleanRB_dateLastSeen;
	
	//sort current registered business
	regBusSort := SORT(regBusFilt, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -record_date);
	regBusDedup := DEDUP(regBusSort, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
	
	addRegBusHit := JOIN(indata, regBusDedup,
												LEFT.seq = RIGHT.seq AND
												LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
												LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
												LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,	
												TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																	SELF.BusRegHit := IF(RIGHT.br_id <> 0, TRUE, FALSE);
																	SELF := LEFT;),
												LEFT OUTER);
												
	//retrieve SIC and NAIC codes with dates
	outRegBusSic := DueDiligence.Common.getSicNaicCodes(regBusFilt, RawFields.SIC, TRUE, TRUE, dt_first_seen, dt_last_seen, DueDiligence.Constants.SOURCE_BUSINESS_REGISTRATION);
	outRegBusNaic := DueDiligence.Common.getSicNaicCodes(regBusFilt, RawFields.NAICS, FALSE, TRUE, dt_first_seen, dt_last_seen, DueDiligence.Constants.SOURCE_BUSINESS_REGISTRATION);
	
	allRegBusSicNaic := outRegBusSic + outRegBusNaic;
	sortRegBusRollSicNaic := DueDiligence.Common.rollSicNaicBySeqAndBIP(allRegBusSicNaic);
		
	addRegBusSicNaic := JOIN(addRegBusHit, sortRegBusRollSicNaic,
														LEFT.seq = RIGHT.seq AND
														LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
														LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
														LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
														TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																			SELF.SicNaicSources := LEFT.SicNaicSources + RIGHT.sources;
																			SELF := LEFT;),
														LEFT OUTER);					
	


	//get registered agent information
	busRegAgent := regBusFilt(rawfields.ra_name <> DueDiligence.Constants.EMPTY AND clean_ra_address.prim_name <> DueDiligence.Constants.EMPTY);
	sortBusRegAgent := SORT(busRegAgent, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), clean_ra_address.prim_range, clean_ra_address.predir, clean_ra_address.prim_name, clean_ra_address.addr_suffix, clean_ra_address.postdir, clean_ra_address.zip, dt_first_seen);

	rollBusRegAgent := ROLLUP(sortBusRegAgent,
													LEFT.seq = RIGHT.seq AND
													LEFT.ultID = RIGHT.ultID AND
													LEFT.orgID = RIGHT.orgID AND
													LEFT.seleID = RIGHT.seleID AND
													LEFT.clean_ra_address.prim_range = RIGHT.clean_ra_address.prim_range AND
													LEFT.clean_ra_address.predir = RIGHT.clean_ra_address.predir AND
													LEFT.clean_ra_address.prim_name = RIGHT.clean_ra_address.prim_name AND
													LEFT.clean_ra_address.addr_suffix = RIGHT.clean_ra_address.addr_suffix AND
													LEFT.clean_ra_address.postdir = RIGHT.clean_ra_address.postdir AND
													LEFT.clean_ra_address.zip = RIGHT.clean_ra_address.zip,
													TRANSFORM({RECORDOF(LEFT)},
																		 SELF.dt_last_seen := MAX(LEFT.dt_last_seen, RIGHT.dt_last_seen);
																		 SELF := LEFT;));
	
	projectBusRegAgent := PROJECT(rollBusRegAgent, TRANSFORM(DueDiligence.LayoutsInternal.AgentLayout,
																														SELF.ultID := LEFT.ultID;
																														SELF.orgID := LEFT.orgID;
																														SELF.seleID := LEFT.seleID;
																														SELF.proxID := LEFT.proxID;
																														SELF.powID := LEFT.powID;
																														SELF.agents := PROJECT(LEFT, TRANSFORM(DueDiligence.Layouts.LayoutAgent,
																																																		SELF.source := DueDiligence.Constants.SOURCE_BUSINESS_REGISTRATION;
																																																		SELF.prim_range := LEFT.clean_ra_address.prim_range;
																																																		SELF.predir := LEFT.clean_ra_address.predir;
																																																		SELF.prim_name := LEFT.clean_ra_address.prim_name;
																																																		SELF.addr_suffix := LEFT.clean_ra_address.addr_suffix;
																																																		SELF.postdir := LEFT.clean_ra_address.postdir;
																																																		SELF.unit_desig := LEFT.clean_ra_address.unit_desig;
																																																		SELF.sec_range := LEFT.clean_ra_address.sec_range;
																																																		SELF.city := LEFT.clean_ra_address.v_city_name;
																																																		SELF.state := LEFT.clean_ra_address.st;
																																																		SELF.zip5 := LEFT.clean_ra_address.zip;
																																																		SELF.zip4 := LEFT.clean_ra_address.zip4;
																																																		SELF.fullName := LEFT.rawfields.ra_name;
																																																		SELF.dateFirstSeen := LEFT.dt_first_seen;
																																																		SELF.dateLastSeen := LEFT.dt_last_seen;
																																																		SELF := [];));
																														SELF := LEFT;
																														SELF := [];));
																											
	rollRegAgents := ROLLUP(projectBusRegAgent,
													LEFT.seq = RIGHT.seq AND
													LEFT.ultID = RIGHT.ultID AND
													LEFT.orgID = RIGHT.orgID AND
													LEFT.seleID = RIGHT.seleID,
													TRANSFORM(DueDiligence.LayoutsInternal.AgentLayout,
																		SELF.agents := LEFT.agents + RIGHT.agents;
																		SELF := LEFT;));
																	
	addRegisteredAgents := JOIN(addRegBusSicNaic, rollRegAgents,
															LEFT.seq = RIGHT.seq AND
															LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
															LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
															LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
															TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																				SELF.registeredAgentExists := LEFT.registeredAgentExists OR EXISTS(RIGHT.agents);
																				SELF.registeredAgents := LEFT.registeredAgents + RIGHT.agents;
																				SELF := LEFT;),
															LEFT OUTER);




	// OUTPUT(regBusFilt, NAMED('regBusFilt'));
	// OUTPUT(outRegBusSic, NAMED('outRegBusSic'));
	// OUTPUT(outRegBusNaic, NAMED('outRegBusNaic'));
	// OUTPUT(allRegBusSicNaic, NAMED('allRegBusSicNaic'));
	// OUTPUT(sortRegBusRollSicNaic, NAMED('sortRegBusRollSicNaic'));
	// OUTPUT(addRegBusSicNaic, NAMED('addRegBusSicNaic'));	
	
	// OUTPUT(busRegAgent, NAMED('busRegAgent'));	
	// OUTPUT(sortBusRegAgent, NAMED('sortBusRegAgent'));	
	// OUTPUT(rollBusRegAgent, NAMED('rollBusRegAgent'));	
	// OUTPUT(projectBusRegAgent, NAMED('projectBusRegAgent'));	
	// OUTPUT(rollRegAgents, NAMED('rollRegAgents'));	
	// OUTPUT(addRegisteredAgents, NAMED('addRegisteredAgents'));	

	
	RETURN addRegisteredAgents;
END;