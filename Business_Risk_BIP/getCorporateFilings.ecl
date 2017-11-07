IMPORT BBB2, BIPV2, Business_Risk_BIP, BusReg, Corp2, EBR, MDR, Risk_Indicators, UT, Business_Header;

EXPORT getCorporateFilings(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	STRING1 CURRENT := 'C';
	STRING1 HISTORY := 'H';
	STRING1 UNKNOWN := '0';

	LinkIDs := Business_Risk_BIP.Common.GetLinkIDs(Shell);
	
	// ---------------[ EBR (Experian Business Report) -- for OwnershipType field only ]----------------
	
	// NOTE: owner_type_code--One of the following descriptions will be listed: 0 = Unknown; 1 = Public; 2 = Private; 3 = Foreign; 4 = Non-Profit

	EBRRaw := EBR.Key_5600_Demographic_Data_linkids.kFetch2(LinkIDs,
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, // ScoreThreshold --> 0 = Give me everything
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses
																							);																	
	// Add back our Seq numbers.
	Business_Risk_BIP.Common.AppendSeq2(EBRRaw, Shell, EBRSeq);
	
	// Filter out records after our history date.
	EBR_recs := Business_Risk_BIP.Common.FilterRecords(EBRSeq, date_first_seen, (UNSIGNED)Business_Risk_BIP.Constants.MissingDate, MDR.SourceTools.src_EBR, AllowedSourcesSet);
	
	EBR_recs_rollup :=
		ROLLUP(
			SORT(	EBR_recs, seq, UltID, OrgID, SeleID, ProxID, -(record_type = CURRENT), -process_date ),
			TRANSFORM( RECORDOF(EBR_recs),
				SELF.owner_type_code := IF( LEFT.owner_type_code != '', LEFT.owner_type_code, RIGHT.owner_type_code ),
				SELF := LEFT
			),
			seq, UltID, OrgID, SeleID, ProxID
		);
		
	// ---------------[ Corporate Filings (SoS) Data ]----------------	
	
	CorpFilings_raw := Corp2.Key_LinkIDs.Corp.kfetch2(LinkIDs,
	                                         Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
	                                         0, // ScoreThreshold --> 0 = Give me everything
																					 Business_Risk_BIP.Constants.Limit_Default,
																					 Options.KeepLargeBusinesses
													);

	// Add back our Seq numbers.
	Business_Risk_BIP.Common.AppendSeq2(CorpFilings_raw, Shell, CorpFilings_seq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodes := Business_Risk_BIP.Common.GrabFetchErrorCode(CorpFilings_seq);

 // Calculate the source code by state to restrict records for Marketing properly. We'll 
 // borrow corp_src_type for the state source code.
 CorpFilings_withSrcCode := 
  PROJECT(
    CorpFilings_seq,
    TRANSFORM( RECORDOF(CorpFilings_seq), 
      SELF.corp_src_type := MDR.sourceTools.fCorpV2( LEFT.corp_key, LEFT.corp_state_origin ),
      SELF := LEFT
    ) );
  
	// Filter out records after our history date.
	CorpFilings_recs := Business_Risk_BIP.Common.FilterRecords(CorpFilings_withSrcCode, dt_first_seen, dt_vendor_first_reported, corp_src_type, AllowedSourcesSet);
	
	// Filter out any companies (designated as such by corp_key) that have no Current corp filing 
	// records anywhere. Such companies no longer exist.
	CorpFilings_recs_grpd := GROUP( SORT( CorpFilings_recs, corp_key ), seq, corp_key );
	CorpFilings_recs_filt := CorpFilings_recs_grpd;    //HAVING( CorpFilings_recs_grpd, EXISTS(ROWS(LEFT)(record_type = CURRENT)) );
	
	// Inflate the corp filing record to include placeholders for derived, calculated data. Set
	// the is_defunct flag, and borrow from corp_entity_desc (limiting to 20 chars), corp_ra_resign_date,
	// corp_forgn_date, and corp_forgn_term_exist_cd if necessary. These will aid in rolling up later.
	layout_corpfilings_inflated := RECORD
		RECORDOF(CorpFilings_recs);
		STRING  ownership_type                := '0';
		STRING1 SOSStanding										:= '0';
		BOOLEAN everDefunct                  	:= FALSE;
		BOOLEAN CurrDefunct                  	:= FALSE;
		DATASET({STRING TypeDesc}) OrigBus;
		DATASET({STRING Term}) TermExist;
		DATASET({STRING FilingDate, STRING FilingCD}) Filings;
		DATASET({STRING IncDate, STRING IncState}) Incorporation;
		DATASET({STRING AgentName, STRING AgentChangeDate, STRING AgentChanged}) RegAgentChanges;
		DATASET({INTEGER Amendment}) Amendments;
		DATASET({STRING CharterNBR}) OrigSOS;
		DATASET({STRING StructureDesc}) OrigOrg;
		DATASET({STRING StateCD}) ForeignState;
		DATASET({STRING TypeDesc}) Address1;
	END;
	
	CorpFilingsCleaned := PROJECT(CorpFilings_Recs_Filt, TRANSFORM(layout_corpfilings_inflated,
			SELF.SOSStanding := MAP(Business_Risk_BIP.Common.is_ActiveCorp(LEFT.record_type, LEFT.corp_status_cd, LEFT.corp_status_desc)  => '3',
															StringLib.StringFind(StringLib.StringToUpperCase(LEFT.corp_status_desc), 'INACTIVE', 1) <> 0  				=> '2',
															StringLib.StringFind(StringLib.StringToUpperCase(LEFT.corp_status_desc), 'DISSOLVED', 1) <> 0 				=> '1',
																																																																			 '0');
			
			SELF.CurrDefunct := IF(StringLib.StringToUpperCase(LEFT.corp_status_desc) IN ['FORFEITED','TERMINATED','DISSOLVED']and left.record_type = CURRENT, true, false);
			SELF.everDefunct := IF(StringLib.StringToUpperCase(LEFT.corp_status_desc) IN ['FORFEITED','TERMINATED','DISSOLVED'],  true, false);
			SELF.OrigBus := DATASET([{Business_Risk_BIP.Common.filterOutSpecialChars(StringLib.StringToUpperCase(IF(TRIM(LEFT.corp_orig_bus_type_desc, LEFT, RIGHT) = '', LEFT.corp_entity_desc[1..20], LEFT.corp_orig_bus_type_desc[1..20])))}], {STRING TypeDesc});
			SELF.TermExist := DATASET([{Business_Risk_BIP.Common.filterOutSpecialChars(StringLib.StringToUpperCase(TRIM(LEFT.corp_term_exist_cd, LEFT, RIGHT)))}], {STRING Term});
			SELF.Filings := DATASET([{Business_Risk_BIP.Common.checkInvalidDate(LEFT.corp_filing_date, Business_Risk_BIP.Constants.MissingDate, LEFT.HistoryDate),
																Business_Risk_BIP.Common.filterOutSpecialChars(StringLib.StringToUpperCase(TRIM(LEFT.corp_filing_cd, LEFT, RIGHT)))}], {STRING FilingDate, STRING FilingCD});
			incDate := Business_Risk_BIP.Common.checkInvalidDate(LEFT.corp_inc_date, Business_Risk_BIP.Constants.MissingDate, LEFT.HistoryDate);
			SELF.Incorporation := DATASET([{incDate,
																			Business_Risk_BIP.Common.filterOutSpecialChars(StringLib.StringToUpperCase(TRIM(LEFT.corp_inc_state, LEFT, RIGHT)))}], {STRING IncDate, STRING IncState});
			registeredAgentChanged := (INTEGER)LEFT.corp_ra_effective_date > 0 OR // We have a registered agent effective date or a registered agent name
																TRIM(LEFT.Corp_RA_Name) <> '';
			SELF.RegAgentChanges := IF(registeredAgentChanged, DATASET([{StringLib.StringToUpperCase(TRIM(LEFT.Corp_RA_Name, LEFT, RIGHT)), Business_Risk_BIP.Common.checkInvalidDate(LEFT.corp_ra_effective_date, Business_Risk_BIP.Constants.MissingDate, LEFT.HistoryDate), '1'}], {STRING AgentName, STRING AgentChangeDate, STRING AgentChanged}),
																												 DATASET([{'', Business_Risk_BIP.Constants.MissingDate, '0'}], {STRING AgentName, STRING AgentChangeDate, STRING AgentChanged}));
			SELF.Amendments := DATASET([{(INTEGER)LEFT.corp_amendments_filed}], {INTEGER Amendment});
			SELF.OrigSOS := DATASET([{Business_Risk_BIP.Common.filterOutSpecialChars(StringLib.StringToUpperCase(TRIM(LEFT.corp_orig_sos_charter_nbr, LEFT, RIGHT)))}], {STRING CharterNBR});
			SELF.OrigOrg := DATASET([{Business_Risk_BIP.Common.filterOutSpecialChars(StringLib.StringToUpperCase(StringLib.StringFilterOut(TRIM(LEFT.corp_orig_org_structure_desc, LEFT, RIGHT), '\n')))}], {STRING StructureDesc});
			SELF.ForeignState := DATASET([{Business_Risk_BIP.Common.filterOutSpecialChars(StringLib.StringToUpperCase(TRIM(LEFT.corp_forgn_state_cd, LEFT, RIGHT)))}], {STRING StateCD});
			SELF.Address1 := DATASET([{Business_Risk_BIP.Common.filterOutSpecialChars(StringLib.StringToUpperCase(TRIM(LEFT.corp_address1_type_desc, LEFT, RIGHT)))}], {STRING TypeDesc});
			SELF := LEFT));
	
	// Sort to the top the most recent, Current, Legal record for each corp_key. Among these, 
	// we want the record to contain the oldest incorp date. 
	CorpFilings_recs_srtd :=
		SORT( 
			UNGROUP(CorpFilingsCleaned),
			seq,
			corp_key,
			// -(record_type = CURRENT), 
			record_type, 
			-(corp_ln_name_type_desc = 'LEGAL'), 
			MIN(corp_inc_date, corp_forgn_date),
			-corp_process_date, 
			-dt_last_seen,
			corp_ra_name
		);

	// Use a rollup to:
	//   o   ...keep the most recent corp_orig_bus_type_desc value,
	//   o   ...calculate whether the company was ever_defunct
	//   o   ...the highest number of corp_amendments_filed ever, 
	//   o   ...whether Registered Agents ever changed,
	//   o   ...and the Registered Agent Date Change list, removing dupes and ignoring blanks. 
	// The result of the rollup is the most recent record for each corp_key (per the Sort, above), 
	// plus the calculated values in the extra fields.
	CorpFilingsRolled1 := ROLLUP(CorpFilings_recs_srtd, LEFT.Seq = RIGHT.Seq AND LEFT.Corp_Key = RIGHT.Corp_Key, TRANSFORM(layout_corpfilings_inflated,
			SELF.SOSStanding := LEFT.SOSStanding;
			SELF.everDefunct := LEFT.everDefunct OR RIGHT.everDefunct;
			SELF.CurrDefunct := LEFT.CurrDefunct OR RIGHT.CurrDefunct;
			SELF.OrigBus := LEFT.OrigBus + RIGHT.OrigBus;
			SELF.TermExist := LEFT.TermExist + RIGHT.TermExist;
			SELF.Filings := LEFT.Filings + RIGHT.Filings;
			SELF.Incorporation := LEFT.Incorporation + RIGHT.Incorporation;
			SELF.RegAgentChanges := LEFT.RegAgentChanges + RIGHT.RegAgentChanges;
			SELF.Amendments := LEFT.Amendments + RIGHT.Amendments;
			SELF.OrigSOS := LEFT.OrigSOS + RIGHT.OrigSOS;
			SELF.OrigOrg := LEFT.OrigOrg + RIGHT.OrigOrg;
			SELF.ForeignState := LEFT.ForeignState + RIGHT.ForeignState;
			SELF.Address1 := LEFT.Address1 + RIGHT.Address1;
			SELF := LEFT));
	
	// Now remove Duplicate/Blank Datasets
	CorpFilingsRolledClean := PROJECT(CorpFilingsRolled1, TRANSFORM(layout_corpfilings_inflated,
			SELF.OrigBus := DEDUP(SORT(LEFT.OrigBus (TypeDesc <> ''), TypeDesc), TypeDesc);
			SELF.TermExist := DEDUP(SORT(LEFT.TermExist (Term <> ''), Term), Term);
			SELF.Filings := DEDUP(SORT(LEFT.Filings (FilingDate <> ''), -FilingDate), FilingDate);
			SELF.Incorporation := DEDUP(SORT(LEFT.Incorporation (IncDate <> ''), -IncDate), IncDate);
			SELF.RegAgentChanges := DEDUP(SORT(LEFT.RegAgentChanges (AgentChangeDate <> '' OR AgentName <> ''), -AgentChangeDate, AgentName), AgentChangeDate, AgentName);
			SELF.Amendments := DEDUP(SORT(LEFT.Amendments (Amendment >= 0), -Amendment), Amendment);
			SELF.OrigSOS := DEDUP(SORT(LEFT.OrigSOS (CharterNBR <> ''), CharterNBR), CharterNBR);
			SELF.OrigOrg := DEDUP(SORT(LEFT.OrigOrg (StructureDesc <> ''), StructureDesc), StructureDesc);
			SELF.ForeignState := DEDUP(SORT(LEFT.ForeignState (StateCD <> ''), StateCD), StateCD);
			SELF.Address1 := DEDUP(SORT(LEFT.Address1 (TypeDesc <> ''), TypeDesc), TypeDesc);
			SELF := LEFT));
	
	// Finally roll everything up into Per Seq Datasets
	CorpFilingsRolled := ROLLUP(SORT(CorpFilingsRolledClean, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(layout_corpfilings_inflated,
			// Use 'best' SOS standing -- if any corp key is reporting an active business, count SOS standing as active.
			SELF.SOSStanding := (STRING)MAX((INTEGER)LEFT.SOSStanding, (INTEGER)RIGHT.SOSStanding);
			SELF.everDefunct := LEFT.everDefunct OR RIGHT.everDefunct;
			SELF.CurrDefunct := LEFT.CurrDefunct OR RIGHT.CurrDefunct;
			SELF.OrigBus := LEFT.OrigBus + RIGHT.OrigBus;
			SELF.TermExist := LEFT.TermExist + RIGHT.TermExist;
			SELF.Filings := LEFT.Filings + RIGHT.Filings;
			SELF.Incorporation := LEFT.Incorporation + RIGHT.Incorporation;
			SELF.RegAgentChanges := LEFT.RegAgentChanges + RIGHT.RegAgentChanges;
			SELF.Amendments := LEFT.Amendments + RIGHT.Amendments;
			SELF.OrigSOS := LEFT.OrigSOS + RIGHT.OrigSOS;
			SELF.OrigOrg := LEFT.OrigOrg + RIGHT.OrigOrg;
			SELF.ForeignState := LEFT.ForeignState + RIGHT.ForeignState;
			SELF.Address1 := LEFT.Address1 + RIGHT.Address1;
			SELF := LEFT));

	// Add ownership_type to the Shell
	withOwnership := JOIN(Shell, EBR_recs_rollup, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
				SELF.SOS.SOSOwnershipTypeList := IF(RIGHT.owner_type_code = '', UNKNOWN, RIGHT.owner_type_code);
				SELF := LEFT
			),
			LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	withCorpFilingsData := JOIN(withOwnership, CorpFilingsRolled, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
				newestIncorporation := TOPN(RIGHT.Incorporation, 1, -IncDate);
				oldestIncorporation := TOPN(RIGHT.Incorporation, 1, IncDate);
				oldestNonZeroIncorporation := TOPN(RIGHT.Incorporation ((INTEGER)IncDate > 0), 1, IncDate);
				newestIncorporationDate := Business_Risk_BIP.Common.checkInvalidDate(newestIncorporation[1].IncDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				oldestIncorporationDate := Business_Risk_BIP.Common.checkInvalidDate(oldestIncorporation[1].IncDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				oldestNonZeroIncorporationDate := Business_Risk_BIP.Common.checkInvalidDate(oldestNonZeroIncorporation[1].IncDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				
				BHBuildDate := Risk_Indicators.get_Build_date('bheader_build_version');
				TodaysDate := Business_Risk_BIP.Common.todaysDate(BHBuildDate, LEFT.Clean_Input.HistoryDate);
				regAgentChanged := PROJECT(RIGHT.RegAgentChanges, TRANSFORM({STRING AgentName, STRING AgentChangeDate, STRING AgentChanged},
					SELF.AgentChanged := IF((INTEGER)LEFT.AgentChangeDate <> (INTEGER)oldestNonZeroIncorporationDate, '1', '0');
					SELF := LEFT));
				SOSRecExists := COUNT(RIGHT.Incorporation) >= 1;
				sortedRegAgent := SORT(regAgentChanged, -AgentChangeDate);
				newestRegAgent := TOPN(sortedRegAgent, 1, -AgentChangeDate);
				oldestRegAgent := TOPN(sortedRegAgent, 1, AgentChangeDate);
				newestFiling := TOPN(RIGHT.Filings, 1, -FilingDate);
				oldestFiling := TOPN(RIGHT.Filings, 1, FilingDate);
				recentAgentChangeDate := Business_Risk_BIP.Common.checkInvalidDate(sortedRegAgent[1].AgentChangeDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				countStateList := COUNT(DEDUP(SORT(RIGHT.Incorporation(TRIM(IncState) <> ''), IncState), IncState));
				combinedStateLists := PROJECT(RIGHT.Incorporation(TRIM(IncState) <> ''), TRANSFORM({STRING2 State}, SELF.State := LEFT.IncState)) + 
															PROJECT(RIGHT.ForeignState(TRIM(StateCD) <> ''), TRANSFORM({STRING2 State}, SELF.State := LEFT.StateCD));
				SELF.SOS.SOSStateCount := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(DEDUP(SORT(combinedStateLists, State), State)), -1, 60);
				SELF.SOS.SOSTimeIncorporation :=  (string)if(SOSRecExists, if((integer)oldestNonZeroIncorporationDate <> 0, Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart(oldestNonZeroIncorporationDate, TodaysDate), 1, 99999), 0), -1); 
				SELF.SOS.SOSDateOfIncorporationList := Business_Risk_BIP.Common.convertDelimited(RIGHT.Incorporation, IncDate, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSIncorporationCount := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(RIGHT.Incorporation), -1, 999);
				SELF.SOS.SOSIncorporationDateFirstSeen := oldestIncorporationDate;
				SELF.SOS.SOSIncorporationDateLastSeen := newestIncorporationDate;
				SELF.SOS.SOSIncorporationStateFirst := oldestIncorporation[1].IncState;
				SELF.SOS.SOSIncorporationStateLast := newestIncorporation[1].IncState;
				SELF.SOS.SOSIncorporationStateInput := If(SOSRecExists, Business_Risk_BIP.Common.SetBoolean(COUNT(RIGHT.Incorporation (IncState = LEFT.Clean_Input.State)) > 0), '-1');
				SELF.SOS.SOSStanding := IF(SOSRecExists, RIGHT.SOSStanding, '0');
				SELF.SOS.SOSEverDefunct := If(SOSRecExists, IF(RIGHT.currDefunct, '2', if(RIGHT.everDefunct, '1', '0')), '-1');
				SELF.SOS.SOSTypeOfFilingTermList := Business_Risk_BIP.Common.convertDelimited(RIGHT.TermExist, Term, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSStateOfIncorporationList := Business_Risk_BIP.Common.convertDelimited(RIGHT.Incorporation, IncState, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSStateOfIncorporationCount := (string)if(SOSRecExists, if(countStateList = 0, 0, Business_Risk_BIP.Common.capNum(countStateList, 1, 60)), -1) ;
				SELF.SOS.SOSDateOfFilingList := Business_Risk_BIP.Common.convertDelimited(RIGHT.Filings, FilingDate, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSFilingCount := IF(SOSRecExists, (STRING)Business_Risk_BIP.Common.CapNum(COUNT(RIGHT.Filings), -1, 999), '-1');
				SELF.SOS.SOSFilingDateFirstSeen := Business_Risk_BIP.Common.checkInvalidDate(oldestFiling[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.SOS.SOSFilingDateLastSeen := Business_Risk_BIP.Common.checkInvalidDate(newestFiling[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.SOS.SOSCodeList := Business_Risk_BIP.Common.convertDelimited(RIGHT.OrigSOS, CharterNBR, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSFilingCodeList := Business_Risk_BIP.Common.convertDelimited(RIGHT.Filings, FilingCD, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSForeignStateList := Business_Risk_BIP.Common.convertDelimited(RIGHT.ForeignState, StateCD, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSForeignStateFlag := If(SOSRecExists, if(count(right.ForeignState(trim(StateCD, all) <> '')) > 0, '1', '0'), '-1');
				SELF.SOS.SOSForeignStateCount := IF(SOSRecExists, (STRING)Business_Risk_BIP.Common.CapNum(COUNT(DEDUP(SORT(RIGHT.ForeignState, StateCD), StateCD)), -1, 999), '-1');
				SELF.SOS.SOSCorporateStructureList := Business_Risk_BIP.Common.convertDelimited(RIGHT.OrigOrg, StructureDesc, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSLocationDescriptionList := Business_Risk_BIP.Common.convertDelimited(RIGHT.Address1, TypeDesc, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSNatureOfBusinessList := Business_Risk_BIP.Common.convertDelimited(RIGHT.OrigBus, TypeDesc, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSCountOfAmendmentsList := Business_Risk_BIP.Common.convertDelimited(RIGHT.Amendments, Amendment, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSRegisterAgentChangeList := Business_Risk_BIP.Common.convertDelimited(sortedRegAgent, AgentChanged, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSRegisterAgentChangeDateList := Business_Risk_BIP.Common.convertDelimited(sortedRegAgent, AgentChangeDate, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSRegisterAgentChangeCount := IF(SOSRecExists, (STRING)Business_Risk_BIP.Common.CapNum(COUNT(sortedRegAgent), -1, 999), '-1');
				SELF.SOS.SOSRegisterAgentChangeDateFirstSeen := Business_Risk_BIP.Common.checkInvalidDate(oldestRegAgent[1].AgentChangeDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.SOS.SOSRegisterAgentChangeDateLastSeen := Business_Risk_BIP.Common.checkInvalidDate(newestRegAgent[1].AgentChangeDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.SOS.SOSTimeAgentChange := (string)if(SOSRecExists, if((integer)recentAgentChangeDate <> 0, Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart(recentAgentChangeDate, TodaysDate), 1, 99999), 0), -1); 
				regAgent12Month := sortedRegAgent ((INTEGER)AgentChangeDate > 0 AND ut.DaysApart(AgentChangeDate, TodaysDate) <= Business_Risk_BIP.Constants.OneYear);
				regAgent06Month := regAgent12Month ((INTEGER)AgentChangeDate > 0 AND ut.DaysApart(AgentChangeDate, TodaysDate) <= Business_Risk_BIP.Constants.SixMonths);
				regAgent03Month := regAgent06Month ((INTEGER)AgentChangeDate > 0 AND ut.DaysApart(AgentChangeDate, TodaysDate) <= Business_Risk_BIP.Constants.ThreeMonths);
				SELF.SOS.SOSRegisterAgentChangeCount12Month := IF(SOSRecExists, (STRING)Business_Risk_BIP.Common.CapNum(COUNT(regAgent12Month), -1, 999), '-1');
				SELF.SOS.SOSRegisterAgentChangeCount06Month := IF(SOSRecExists, (STRING)Business_Risk_BIP.Common.CapNum(COUNT(regAgent06Month), -1, 999), '-1');
				SELF.SOS.SOSRegisterAgentChangeCount03Month := IF(SOSRecExists, (STRING)Business_Risk_BIP.Common.CapNum(COUNT(regAgent03Month), -1, 999), '-1');
				SELF := LEFT
			),
			LEFT OUTER, KEEP(1), ATMOST(100), FEW
		);
	
	withErrorCodes := JOIN(withCorpFilingsData, kFetchErrorCodes, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeCorporateFilings := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT( Shell, NAMED('Shell') );
	// OUTPUT( LinkIDs, NAMED('LinkIDs') );
	// OUTPUT( EBR_recs, NAMED('EBR_recs') );
	// OUTPUT( EBR_recs_rollup, NAMED('EBR_recs_rollup') );
	// OUTPUT( CorpFilings_raw, NAMED('CorpFilings_raw') );
	// OUTPUT( CorpFilings_seq, NAMED('CorpFilings_seq') );
 // OUTPUT( CorpFilings_withSrcCode, NAMED('CorpFilings_withSrcCode') );
	// OUTPUT( CorpFilings_recs, NAMED('CorpFilings_recs') );
	// OUTPUT( CorpFilings_recs_filt, NAMED('CorpFilings_recs_filt'), ALL );
	// OUTPUT( CorpFilings_recs_srtd, NAMED('CorpFilings_recs_srtd'), ALL );
	// OUTPUT( CorpFilingsRolled1, NAMED('CorpFilingsRolled1'));
	// OUTPUT( CorpFilingsCleaned, NAMED('CorpFilingsCleaned') );
	// OUTPUT( CorpFilingsRolledClean, NAMED('CorpFilingsRolledClean') );
	// OUTPUT( CorpFilingsRolled, NAMED('CorpFilingsRolled') );
	// OUTPUT( withCorpFilingsData, NAMED('withCorpFilingsData') );

	RETURN withErrorCodes;
END;


/*   
	--------------------[ DATA REQUIREMENTS ]--------------------

	SOSDateOfIncorporationList	
	A List of the date of incorporation for all SOS fillings for this business. Note(for future 
	use): if multiple records are returned from a single source please use the earliest value for 
	this variable

	SOSEverDefunct	
	The entered business has ever been defunct in their SOS filing. Note: consult both current and 
	historical records.

	SOSTypeOfFilingTermList	
	List of Code indicating the type of filing term  in the same order as "SOSDateOfIncorporationList" 

	SOSStateOfIncorporationList	
	List of the state of incorporation in the same order as "SOSDateOfIncorporationList" 

	SOSDateOfFilingList	
	List of the date of filing for each SOS filling for the business in the same order as 
	"SOSDateOfIncorporationList" 

	SOSCodeList	
	List of the SOS provided code for each SOS filing for the business in the same order as 
	"SOSDateOfIncorporationList" 

	SOSFilingCodeList	
	List of the filing code for each SOS filing for the business in the same order as 
	"SOSDateOfIncorporationList" 

	SOSForeignStateList	
	List of the foreign state if the SOS filing is in conjunction with a business with filings in 
	multiple states in the same order as "SOSDateOfIncorporationList" (foreign state is the state 
	where the business "primarily does business" or calls home)

	SOSCorporateStructureList	
	List of the corporate structure for each SOS filing for the business in the same order as 
	"SOSDateOfIncorporationList". Note (for future use): if multiple records are returned from a 
	single source please use the largest value (largest company indication) for this variable

	SOSOwnershipTypeList	
	List of the ownership types for each SOS filing for the business in the same order as 
	"SOSDateOfIncorporationList" 

	SOSLocationDescriptionList	
	List of the location descriptions for each SOS filing for the business in the same order as 
	"SOSDateOfIncorporationList" 

	SOSNatureOfBusinessList	(REMOVED from requirements)
	List of the nature of business for each SOS filing for the business in the same order as 
	"SOSDateOfIncorporationList" 

	SOSCountOfAmendmentsList	
	The count of the total number of SOS amendments filed

	SOSRegisterAgentChangeList	
	The Registering Agent was changed

	SOSRegisterAgentChangeDateList	
	List of the Date(s) of the Registering Agent change(s) 
*/