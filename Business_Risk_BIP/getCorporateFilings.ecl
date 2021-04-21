IMPORT BIPV2, Business_Risk_BIP, Corp2, EBR, MDR, Risk_Indicators, UT, riskwise, Doxie, STD, BusinessCredit_Services;

EXPORT getCorporateFilings(DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	mod_access := PROJECT(Options, doxie.IDataAccess);

	STRING1 CURRENT := 'C';
	STRING1 HISTORY := 'H';
	STRING1 UNKNOWN := '0';

	LinkIDs := Business_Risk_BIP.Common.GetLinkIDs(Shell);

	// ---------------[ EBR (Experian Business Report) -- for OwnershipType field only ]----------------

	// NOTE: owner_type_code--One of the following descriptions will be listed: 0 = Unknown; 1 = Public; 2 = Private; 3 = Foreign; 4 = Non-Profit

	EBRRaw := EBR.Key_5600_Demographic_Data_linkids.kFetch2(LinkIDs, mod_access,
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
//if we are running this model in biid20 we need to use diff corp recs like LNSMB does
  BBFM1906_1_0_Set := EXISTS(Options.ModelsRequested(ModelName IN [BusinessCredit_Services.Constants.BBFM1906_1_0] ));
  
    EBR_recs_temp := PROJECT(
                              EBR_recs,
                                TRANSFORM( {RECORDOF(EBR_recs), STRING EverPublic},
                                          SELF.EverPublic := LEFT.owner_type_code,
                                          SELF := LEFT,
                                          SELF := []
                              )
                            );

	EBR_recs_rollup :=
		ROLLUP(
			SORT(	EBR_recs_temp, seq, UltID, OrgID, SeleID, ProxID, -(record_type = CURRENT), -process_date ),
			TRANSFORM( {RECORDOF(EBR_recs), STRING EverPublic},
				SELF.owner_type_code := IF( LEFT.owner_type_code != '', LEFT.owner_type_code, RIGHT.owner_type_code ),
        SELF.EverPublic := IF( LEFT.EverPublic = '1', LEFT.EverPublic, RIGHT.EverPublic ),
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
		STRING  temp_corp_inc_date := ''; // for sorting
		STRING  temp_corp_forgn_date := ''; // for sorting
		STRING  ownership_type    := '0';
		STRING1 SOSStanding       := '0';
		BOOLEAN everDefunct       := FALSE;
		BOOLEAN CurrDefunct       := FALSE;
		BOOLEAN PrivateOwnership  := FALSE;
    BOOLEAN EverNonProfit     := FALSE;
		DATASET({STRING TypeDesc}) OrigBus;
		DATASET({STRING Term}) TermExist;
		DATASET({STRING Standing}) SOSStandingBest;
		DATASET({STRING Standing}) SOSStandingWorst;
		DATASET({STRING FilingDate, STRING FilingCD, STRING ForgnDomstcInd}) Filings;
		DATASET({STRING FilingDate, STRING StatusCD, STRING StatusDesc, STRING RecordType}) FilingStatus;
		DATASET({STRING IncDate, STRING IncState}) Incorporation;
		DATASET({STRING IncDate, STRING IncState}) ForgnIncorporation;
		DATASET({STRING AgentName, STRING AgentChangeDate, STRING AgentChanged}) RegAgentChanges;
		DATASET({INTEGER Amendment}) Amendments;
		DATASET({STRING CharterNBR}) OrigSOS;
		DATASET({STRING StructureDesc}) OrigOrg;
		DATASET({STRING StateCD}) ForeignState;
		DATASET({STRING TypeDesc}) Address1;
	END;

	fn_getSOSStanding(STRING record_type, STRING corp_status_cd, STRING corp_status_desc) :=
    MAP(
      Business_Risk_BIP.Common.is_ActiveCorp(record_type, corp_status_cd, corp_status_desc)    => '3',
      STD.Str.Find(STD.Str.ToUpperCase(corp_status_desc), 'INACTIVE', 1) <> 0  => '2',
      STD.Str.Find(STD.Str.ToUpperCase(corp_status_desc), 'DISSOLVED', 1) <> 0 => '1',
      '0');

	CorpFilingsCleaned := PROJECT(CorpFilings_Recs_Filt, TRANSFORM(layout_corpfilings_inflated,
			SOSStanding := fn_getSOSStanding(LEFT.record_type, LEFT.corp_status_cd, LEFT.corp_status_desc);
			SELF.temp_corp_inc_date := IF( LEFT.corp_inc_date = '', '99999999', LEFT.corp_inc_date ),
			SELF.temp_corp_forgn_date := IF( LEFT.corp_forgn_date = '', '99999999', LEFT.corp_forgn_date ),
			SELF.SOSStanding := SOSStanding,
			SELF.CurrDefunct := IF(STD.Str.ToUpperCase(LEFT.corp_status_desc) IN ['FORFEITED','TERMINATED','DISSOLVED'] and left.record_type = CURRENT, true, false);
			SELF.everDefunct := IF(STD.Str.ToUpperCase(LEFT.corp_status_desc) IN ['FORFEITED','TERMINATED','DISSOLVED'], true, false);
			SELF.PrivateOwnership := IF(TRIM(LEFT.corp_for_profit_ind) = 'Y', TRUE, FALSE);
      SELF.EverNonProfit := TRIM(LEFT.corp_for_profit_ind) = 'N',
			SELF.OrigBus := DATASET([{Business_Risk_BIP.Common.filterOutSpecialChars(STD.Str.ToUpperCase(IF(TRIM(LEFT.corp_orig_bus_type_desc, LEFT, RIGHT) = '', LEFT.corp_entity_desc[1..20], LEFT.corp_orig_bus_type_desc[1..20])))}], {STRING TypeDesc});
			SELF.TermExist := DATASET([{Business_Risk_BIP.Common.filterOutSpecialChars(STD.Str.ToUpperCase(TRIM(LEFT.corp_term_exist_cd, LEFT, RIGHT)))}], {STRING Term});
			SELF.SOSStandingBest := DATASET([{SOSStanding}], {STRING Standing}),
			SELF.SOSStandingWorst := DATASET([{SOSStanding}], {STRING Standing}),
			SELF.Filings := DATASET([{Business_Risk_BIP.Common.checkInvalidDate(LEFT.corp_filing_date, Business_Risk_BIP.Constants.MissingDate, LEFT.HistoryDate),
																Business_Risk_BIP.Common.filterOutSpecialChars(STD.Str.ToUpperCase(TRIM(LEFT.corp_filing_cd, LEFT, RIGHT))),
																LEFT.corp_foreign_domestic_ind}], {STRING FilingDate, STRING FilingCD, STRING ForgnDomstcInd});
			SELF.FilingStatus := DATASET(
      [
        {
          Business_Risk_BIP.Common.checkInvalidDate(LEFT.corp_status_date, Business_Risk_BIP.Constants.MissingDate, LEFT.HistoryDate),
          LEFT.corp_status_cd,
          Business_Risk_BIP.Common.filterOutSpecialChars( STD.Str.ToUpperCase(TRIM(LEFT.corp_status_desc, LEFT, RIGHT)) ),
          LEFT.record_type
        }
      ],
      {STRING FilingDate, STRING StatusCD, STRING StatusDesc, STRING RecordType}
    );

			incDate := Business_Risk_BIP.Common.checkInvalidDate(LEFT.corp_inc_date, Business_Risk_BIP.Constants.MissingDate, LEFT.HistoryDate);

			SELF.Incorporation :=
      DATASET(
        [ { incDate, Business_Risk_BIP.Common.filterOutSpecialChars(STD.Str.ToUpperCase(TRIM(LEFT.corp_inc_state, LEFT, RIGHT)))} ],
        {STRING IncDate, STRING IncState} );

			ForgnIncDate := Business_Risk_BIP.Common.checkInvalidDate(LEFT.corp_forgn_date, Business_Risk_BIP.Constants.MissingDate, LEFT.HistoryDate);

			SELF.ForgnIncorporation :=
      DATASET(
        [ { ForgnIncDate, Business_Risk_BIP.Common.filterOutSpecialChars(STD.Str.ToUpperCase(TRIM(LEFT.corp_forgn_state_cd, LEFT, RIGHT)))} ],
        {STRING IncDate, STRING IncState} );

			registeredAgentChanged := (INTEGER)LEFT.corp_ra_effective_date > 0 OR // We have a registered agent effective date or a registered agent name
																TRIM(LEFT.Corp_RA_Name) <> '';
			SELF.RegAgentChanges := IF(registeredAgentChanged, DATASET([{STD.Str.ToUpperCase(TRIM(LEFT.Corp_RA_Name, LEFT, RIGHT)), Business_Risk_BIP.Common.checkInvalidDate(LEFT.corp_ra_effective_date, Business_Risk_BIP.Constants.MissingDate, LEFT.HistoryDate), '1'}], {STRING AgentName, STRING AgentChangeDate, STRING AgentChanged}),
																												 DATASET([{'', Business_Risk_BIP.Constants.MissingDate, '0'}], {STRING AgentName, STRING AgentChangeDate, STRING AgentChanged}));
			SELF.Amendments := DATASET([{(INTEGER)LEFT.corp_amendments_filed}], {INTEGER Amendment});
			SELF.OrigSOS := DATASET([{Business_Risk_BIP.Common.filterOutSpecialChars(STD.Str.ToUpperCase(TRIM(LEFT.corp_orig_sos_charter_nbr, LEFT, RIGHT)))}], {STRING CharterNBR});
			SELF.OrigOrg := DATASET([{Business_Risk_BIP.Common.filterOutSpecialChars(STD.Str.ToUpperCase(STD.Str.FilterOut(TRIM(LEFT.corp_orig_org_structure_desc, LEFT, RIGHT), '\n')))}], {STRING StructureDesc});
			SELF.ForeignState := DATASET([{Business_Risk_BIP.Common.filterOutSpecialChars(STD.Str.ToUpperCase(TRIM(LEFT.corp_forgn_state_cd, LEFT, RIGHT)))}], {STRING StateCD});
			SELF.Address1 := DATASET([{Business_Risk_BIP.Common.filterOutSpecialChars(STD.Str.ToUpperCase(TRIM(LEFT.corp_address1_type_desc, LEFT, RIGHT)))}], {STRING TypeDesc});
			SELF := LEFT));

	// Sort to the top the most recent, Current, Legal record for each corp_key. Among these,
	// we want the record to contain the oldest incorp date.
	CorpFilings_recs_srtd :=
		SORT(
			UNGROUP(CorpFilingsCleaned),
			seq,
			-corp_key,
			// -(record_type = CURRENT),
			record_type,
			-(corp_ln_name_type_desc = 'LEGAL'),
			MIN(temp_corp_inc_date, temp_corp_forgn_date),
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
			SELF.PrivateOwnership := LEFT.PrivateOwnership OR RIGHT.PrivateOwnership;
      SELF.EverNonProfit := LEFT.EverNonProfit OR RIGHT.EverNonProfit;
			SELF.OrigBus := LEFT.OrigBus + RIGHT.OrigBus;
			SELF.TermExist := LEFT.TermExist + RIGHT.TermExist;
			SELF.Filings := LEFT.Filings + RIGHT.Filings;
			SELF.SOSStandingBest := LEFT.SOSStandingBest + RIGHT.SOSStandingBest;
			SELF.SOSStandingWorst := LEFT.SOSStandingWorst + RIGHT.SOSStandingWorst;
			SELF.FilingStatus := LEFT.FilingStatus + RIGHT.FilingStatus;
			SELF.Incorporation := LEFT.Incorporation + RIGHT.Incorporation;
			SELF.ForgnIncorporation := LEFT.ForgnIncorporation + RIGHT.ForgnIncorporation;
			SELF.RegAgentChanges := LEFT.RegAgentChanges + RIGHT.RegAgentChanges;
			SELF.Amendments := LEFT.Amendments + RIGHT.Amendments;
			SELF.OrigSOS := LEFT.OrigSOS + RIGHT.OrigSOS;
			SELF.OrigOrg := LEFT.OrigOrg + RIGHT.OrigOrg;
			SELF.ForeignState := LEFT.ForeignState + RIGHT.ForeignState;
			SELF.Address1 := LEFT.Address1 + RIGHT.Address1;
			SELF := LEFT));

	// Now remove Duplicate/Blank Datasets.
	CorpFilingsRolledClean := PROJECT(CorpFilingsRolled1, TRANSFORM(layout_corpfilings_inflated,
			SELF.OrigBus            := DEDUP(SORT(LEFT.OrigBus (TypeDesc <> ''), TypeDesc), TypeDesc);
			SELF.TermExist          := DEDUP(SORT(LEFT.TermExist (Term <> ''), Term), Term);
			SELF.Filings            := DEDUP(SORT(LEFT.Filings (FilingDate <> ''), -FilingDate), FilingDate);
			SELF.SOSStandingBest    := DEDUP(SORT(LEFT.SOSStandingBest (Standing <> ''), -Standing), Standing);
			SELF.SOSStandingWorst   := DEDUP(SORT(LEFT.SOSStandingWorst (Standing <> ''), Standing), Standing);
			SELF.FilingStatus       := DEDUP(SORT(LEFT.FilingStatus (FilingDate NOT IN ['','0']), -FilingDate, StatusCD), FilingDate);
			SELF.Incorporation      := DEDUP(SORT(LEFT.Incorporation (IncDate <> ''), -IncDate), IncDate);
			SELF.ForgnIncorporation := DEDUP(SORT(LEFT.ForgnIncorporation (IncDate <> ''), -IncDate), IncDate);
			SELF.RegAgentChanges    := DEDUP(SORT(LEFT.RegAgentChanges (AgentChangeDate <> '' OR AgentName <> ''), -AgentChangeDate, AgentName), AgentChangeDate, AgentName);
			SELF.Amendments         := DEDUP(SORT(LEFT.Amendments (Amendment >= 0), -Amendment), Amendment);
			SELF.OrigSOS            := DEDUP(SORT(LEFT.OrigSOS (CharterNBR <> ''), CharterNBR), CharterNBR);
			SELF.OrigOrg            := DEDUP(SORT(LEFT.OrigOrg (StructureDesc <> ''), StructureDesc), StructureDesc);
			SELF.ForeignState       := DEDUP(SORT(LEFT.ForeignState (StateCD <> ''), StateCD), StateCD);
			SELF.Address1           := DEDUP(SORT(LEFT.Address1 (TypeDesc <> ''), TypeDesc), TypeDesc);
			SELF := LEFT));

	// Finally roll everything up into Per Seq Datasets
	CorpFilingsRolled := ROLLUP(SORT(CorpFilingsRolledClean, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(layout_corpfilings_inflated,
			// Use 'best' SOS standing -- if any corp key is reporting an active business, count SOS standing as active.
			SELF.SOSStanding := (STRING)MAX((INTEGER)LEFT.SOSStanding, (INTEGER)RIGHT.SOSStanding);
			SELF.everDefunct := LEFT.everDefunct OR RIGHT.everDefunct;
			SELF.CurrDefunct := LEFT.CurrDefunct OR RIGHT.CurrDefunct;
			SELF.PrivateOwnership := LEFT.PrivateOwnership OR RIGHT.PrivateOwnership;
      SELF.EverNonProfit := LEFT.EverNonProfit OR RIGHT.EverNonProfit;
			SELF.OrigBus := LEFT.OrigBus + RIGHT.OrigBus;
			SELF.TermExist := LEFT.TermExist + RIGHT.TermExist;
			SELF.SOSStandingBest := LEFT.SOSStandingBest + RIGHT.SOSStandingBest; // (STRING)MAX((INTEGER)LEFT.SOSStandingBest, (INTEGER)RIGHT.SOSStandingBest);
			SELF.SOSStandingWorst := LEFT.SOSStandingWorst + RIGHT.SOSStandingWorst; // (STRING)MIN((INTEGER)LEFT.SOSStandingBest, (INTEGER)RIGHT.SOSStandingBest);
			SELF.Filings := LEFT.Filings + RIGHT.Filings;
			SELF.FilingStatus := LEFT.FilingStatus + RIGHT.FilingStatus;
			SELF.Incorporation := LEFT.Incorporation + RIGHT.Incorporation;
			SELF.ForgnIncorporation := LEFT.ForgnIncorporation + RIGHT.ForgnIncorporation;
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
        SELF.Firmographic.FirmPublicFlag := IF(RIGHT.EverPublic = '1', '1', '0');
				SELF := LEFT
			),
			LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	withCorpFilingsData_Old := JOIN(withOwnership, CorpFilingsRolled, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
				newestIncorporation := TOPN(RIGHT.Incorporation, 1, -IncDate);
				oldestIncorporation := TOPN(RIGHT.Incorporation, 1, IncDate);
				oldestNonZeroIncorporation := TOPN(RIGHT.Incorporation ((INTEGER)IncDate > 0), 1, IncDate);
				newestIncorporationDate := Business_Risk_BIP.Common.checkInvalidDate(newestIncorporation[1].IncDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				oldestIncorporationDate := Business_Risk_BIP.Common.checkInvalidDate(oldestIncorporation[1].IncDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				oldestNonZeroIncorporationDate := Business_Risk_BIP.Common.checkInvalidDate(oldestNonZeroIncorporation[1].IncDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);

				BHBuildDate := Risk_Indicators.get_Build_date('bip_build_version');
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
				SELF.Firmographic.OwnershipType := IF(RIGHT.PrivateOwnership, '2', '0');
        SELF.Firmographic.FirmNonProfitFlag := IF(RIGHT.EverNonProfit, '1', '0');
				SELF := LEFT;
    SELF := [];
			),
			LEFT OUTER, KEEP(1), ATMOST(100), FEW
		);



	withCorpFilingsData_BIID20 := JOIN(withOwnership, CorpFilingsRolled, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                ds_Incorporation_Seq :=
                PROJECT(
                RIGHT.Incorporation,
                TRANSFORM( {INTEGER4 Seq, RECORDOF(RIGHT.Incorporation)},
                SELF.Seq     := COUNTER,
                SELF := LEFT
                ) );

                ds_FilingStatus_Seq :=
                PROJECT(
                RIGHT.FilingStatus,
                TRANSFORM( {INTEGER4 Seq, RECORDOF(RIGHT.FilingStatus)},
                SELF.Seq     := COUNTER,
                SELF := LEFT
                ) );

                Incorp_FilingStatus_Layout := RECORD
                RECORDOF(ds_Incorporation_Seq);
                RECORDOF(ds_FilingStatus_Seq) - Seq;
                END;

                Joined_Incorp_FilingStatus_Domestic := JOIN(ds_Incorporation_Seq, ds_FilingStatus_Seq,
                LEFT.Seq = RIGHT.Seq, TRANSFORM(Incorp_FilingStatus_Layout,
                SELF.Seq := LEFT.Seq;
                SELF.filingdate := RIGHT.filingdate;
                SELF.statuscd := RIGHT.statuscd;
                SELF.statusdesc := RIGHT.statusdesc;
                SELF.recordtype := RIGHT.recordtype;
                SELF.incdate := LEFT.incdate;
                SELF.incstate := LEFT.incstate;
                ), LEFT OUTER, ATMOST(riskwise.max_atmost));

				newestIncorporation := PROJECT(TOPN(Joined_Incorp_FilingStatus_Domestic, 1, StatusCD, -IncDate), TRANSFORM(RECORDOF(ds_Incorporation_Seq), SELF := LEFT));
				oldestIncorporation := PROJECT(TOPN(Joined_Incorp_FilingStatus_Domestic, 1, StatusCD, IncDate), TRANSFORM(RECORDOF(ds_Incorporation_Seq), SELF := LEFT));
				oldestNonZeroIncorporation := PROJECT(TOPN(Joined_Incorp_FilingStatus_Domestic, 1, StatusCD, (INTEGER)IncDate > 0), TRANSFORM(RECORDOF(ds_Incorporation_Seq), SELF := LEFT));
				newestIncorporationDate := Business_Risk_BIP.Common.checkInvalidDate(newestIncorporation[1].IncDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				oldestIncorporationDate := Business_Risk_BIP.Common.checkInvalidDate(oldestIncorporation[1].IncDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				oldestNonZeroIncorporationDate := Business_Risk_BIP.Common.checkInvalidDate(oldestNonZeroIncorporation[1].IncDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);

				BHBuildDate := Risk_Indicators.get_Build_date('bip_build_version');
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
				SELF.Firmographic.OwnershipType := IF(RIGHT.PrivateOwnership, '2', '0');
        SELF.Firmographic.FirmNonProfitFlag := IF(RIGHT.EverNonProfit, '1', '0');
				SELF := LEFT;
    SELF := [];
			),
			LEFT OUTER, KEEP(1), ATMOST(100), FEW
		);


	withCorpFilingsData_New := JOIN(withOwnership, CorpFilingsRolled, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
				ds_Incorporation      := RIGHT.Incorporation(incdate NOT IN ['','0']);
				ds_ForgnIncorporation := RIGHT.ForgnIncorporation(incdate NOT IN ['','0']);

    ds_DomesticIncorpsAsFilings :=
        PROJECT(
          ds_Incorporation,
          TRANSFORM( {STRING FilingDate, STRING FilingCD, STRING ForgnDomstcInd},
            SELF.FilingDate     := LEFT.incdate,
            SELF.FilingCD       := '',
            SELF.ForgnDomstcInd := 'D'
          ) );

				ds_Filings := RIGHT.Filings(filingdate NOT IN ['','0']) + ds_DomesticIncorpsAsFilings;

				newestDomesticIncorporation := SORT(ds_Incorporation, -IncDate)[1];
    newestForeignIncorporation  := SORT(ds_ForgnIncorporation, -IncDate)[1];
    newestIncorporation         := SORT( (newestDomesticIncorporation + newestForeignIncorporation), -IncDate )[1];

				oldestDomesticIncorporation := SORT(ds_Incorporation(IncDate NOT IN ['','0']), IncDate)[1];
    oldestForeignIncorporation  := SORT(ds_ForgnIncorporation(IncDate NOT IN ['','0']), IncDate)[1];
    oldestIncorporation :=
        IF(
          COUNT((oldestDomesticIncorporation + oldestForeignIncorporation)) > 0,
          SORT( (oldestDomesticIncorporation + oldestForeignIncorporation)(incdate NOT IN ['','0']), IncDate )[1],
          ROW( {'0',''}, {STRING IncDate, STRING IncState} )
        );

				newestIncorporationDate := Business_Risk_BIP.Common.checkInvalidDate(newestIncorporation.IncDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				oldestIncorporationDate := Business_Risk_BIP.Common.checkInvalidDate(oldestIncorporation.IncDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);

				BHBuildDate := Risk_Indicators.get_Build_date('bip_build_version');

				TodaysDate := Business_Risk_BIP.Common.todaysDate(BHBuildDate, LEFT.Clean_Input.HistoryDate);

				regAgentChanged := PROJECT(RIGHT.RegAgentChanges, TRANSFORM({STRING AgentName, STRING AgentChangeDate, STRING AgentChanged},
					SELF.AgentChanged := IF((INTEGER)LEFT.AgentChangeDate <> (INTEGER)oldestIncorporationDate, '1', '0');
					SELF := LEFT));

				SOSRecExists   := COUNT(ds_Incorporation) >= 1 OR COUNT(ds_ForgnIncorporation) >= 1;             // Adding foreign incorporations should fix a lot of the fields below.

				sortedRegAgent := SORT(regAgentChanged, -AgentChangeDate);
				newestRegAgent := sortedRegAgent[1];
				oldestRegAgent := TOPN(regAgentChanged(AgentChangeDate NOT IN ['','0']), 1, AgentChangeDate);

				newestFiling   := TOPN(ds_Filings, 1, -FilingDate);
				oldestFiling   := TOPN(ds_Filings(FilingDate NOT IN ['','0']), 1, FilingDate);

				recentAgentChangeDate := Business_Risk_BIP.Common.checkInvalidDate(sortedRegAgent[1].AgentChangeDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);

				countStateList := COUNT(DEDUP(SORT(ds_Incorporation(TRIM(IncState) <> ''), IncState), IncState)) +
        COUNT(DEDUP(SORT(ds_ForgnIncorporation(TRIM(IncState) <> ''), IncState), IncState));

    combinedStateLists := PROJECT(ds_Incorporation(TRIM(IncState) <> ''), TRANSFORM({STRING2 State}, SELF.State := LEFT.IncState)) +
                          PROJECT(ds_ForgnIncorporation(TRIM(IncState) <> ''), TRANSFORM({STRING2 State}, SELF.State := LEFT.IncState));

    nonZeroDomesticFilingDates := ds_Filings(ForgnDomstcInd = 'D' AND FilingDate NOT IN ['','0']);
    nonZeroForeignFilingDates  := ds_Filings(ForgnDomstcInd = 'F' AND FilingDate NOT IN ['','0']);

				regAgent12Month := sortedRegAgent ((INTEGER)AgentChangeDate > 0 AND ut.DaysApart(AgentChangeDate, TodaysDate) <= Business_Risk_BIP.Constants.OneYear);
				regAgent06Month := regAgent12Month ((INTEGER)AgentChangeDate > 0 AND ut.DaysApart(AgentChangeDate, TodaysDate) <= Business_Risk_BIP.Constants.SixMonths);
				regAgent03Month := regAgent06Month ((INTEGER)AgentChangeDate > 0 AND ut.DaysApart(AgentChangeDate, TodaysDate) <= Business_Risk_BIP.Constants.ThreeMonths);

    AllIncorporations := (ds_Incorporation + ds_ForgnIncorporation);

				SELF.SOS.SOSStateCount                       := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(DEDUP(SORT(combinedStateLists, State), State)), -1, 60);
				SELF.SOS.SOSTimeIncorporation                := (string)if(SOSRecExists, if((integer)oldestIncorporationDate <> 0, Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart(oldestIncorporationDate, TodaysDate), 1, 99999), 0), -1);
				SELF.SOS.SOSDateOfIncorporationList          := Business_Risk_BIP.Common.convertDelimited(AllIncorporations, IncDate, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSIncorporationCount               := (STRING)Business_Risk_BIP.Common.CapNum( (COUNT(AllIncorporations)), -1, 999);
				SELF.SOS.SOSIncorporationDateFirstSeen       := oldestIncorporationDate;
				SELF.SOS.SOSIncorporationDateLastSeen        := newestIncorporationDate;
				SELF.SOS.SOSIncorporationStateFirst          := oldestIncorporation.IncState;
				SELF.SOS.SOSIncorporationStateLast           := newestIncorporation.IncState;
				SELF.SOS.SOSIncorporationStateInput          := If(SOSRecExists, Business_Risk_BIP.Common.SetBoolean( (COUNT(AllIncorporations(IncState = LEFT.Clean_Input.State))) > 0 ), '-1');
				SELF.SOS.SOSStanding                         := IF(SOSRecExists, RIGHT.SOSStanding, '0');
				SELF.SOS.SOSEverDefunct                      := If(SOSRecExists, IF(RIGHT.currDefunct, '2', if(RIGHT.everDefunct, '1', '0')), '-1');
				SELF.SOS.SOSTypeOfFilingTermList             := Business_Risk_BIP.Common.convertDelimited(RIGHT.TermExist, Term, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSStateOfIncorporationList         := Business_Risk_BIP.Common.convertDelimited(ds_Incorporation, IncState, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSStateOfIncorporationCount        := (string)if(SOSRecExists, if(countStateList = 0, 0, Business_Risk_BIP.Common.capNum(countStateList, 1, 60)), -1) ;
				SELF.SOS.SOSDateOfFilingList                 := Business_Risk_BIP.Common.convertDelimited(ds_Filings, FilingDate, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSFilingCount                      := IF(SOSRecExists, (STRING)Business_Risk_BIP.Common.CapNum(COUNT(ds_Filings), -1, 999), '-1');
				SELF.SOS.SOSFilingDateFirstSeen              := Business_Risk_BIP.Common.checkInvalidDate(oldestFiling[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.SOS.SOSFilingDateLastSeen               := Business_Risk_BIP.Common.checkInvalidDate(newestFiling[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.SOS.SOSDomesticCount                    := (STRING)Business_Risk_BIP.Common.capNum( COUNT( ds_Incorporation ), 0, 99999 ); // Number of domestic SOS incorporation filings
				SELF.SOS.SOSDomesticDateFirstSeen            := IF( COUNT( nonZeroDomesticFilingDates ) = 0, '0', SORT(nonZeroDomesticFilingDates, FilingDate)[1].FilingDate ); // Date of first domestic SOS incorporation filing
				SELF.SOS.SOSDomesticDateLastSeen             := IF( COUNT( nonZeroDomesticFilingDates ) = 0, '0', SORT(nonZeroDomesticFilingDates, -FilingDate)[1].FilingDate ); // Date of most recent domestic SOS incorporation filing
				SELF.SOS.SOSDomesticMosSinceFirstSeen        := IF( COUNT( nonZeroDomesticFilingDates ) = 0, '0', (STRING)ut.MonthsApart( SORT(nonZeroDomesticFilingDates, FilingDate)[1].FilingDate, TodaysDate) ); // Months since the first domestic SOS incorporation filing
				SELF.SOS.SOSForeignCount                     := (STRING)Business_Risk_BIP.Common.capNum( COUNT( ds_ForgnIncorporation ), 0, 99999 ); // Number of foreign SOS incorporation filings
				SELF.SOS.SOSForeignDateFirstSeen             := IF( COUNT( nonZeroForeignFilingDates ) = 0, '0', SORT(nonZeroForeignFilingDates, FilingDate)[1].FilingDate ); // Date of first foreign SOS incorporation filing
				SELF.SOS.SOSForeignDateLastSeen              := IF( COUNT( nonZeroForeignFilingDates ) = 0, '0', SORT(nonZeroForeignFilingDates, -FilingDate)[1].FilingDate ); // Date of most recent foreign SOS incorporation filing
				SELF.SOS.SOSForeignMosSinceFirstSeen         := IF( COUNT( nonZeroForeignFilingDates ) = 0, '0', (STRING)Business_Risk_BIP.Common.capNum( ut.MonthsApart( SORT(nonZeroForeignFilingDates, FilingDate)[1].FilingDate, TodaysDate), 0, 99999 ) ); // Months since the first foreign SOS incorporation filing
				SELF.SOS.SOSStandingBest                     := MAX(RIGHT.SOSStandingBest,Standing);
				SELF.SOS.SOSStandingWorst                    := IF( COUNT(RIGHT.SOSStandingWorst(Standing != '0')) = 0, '0', MIN(RIGHT.SOSStandingWorst(Standing != '0'),Standing) );
				SELF.SOS.SOSCodeList                         := Business_Risk_BIP.Common.convertDelimited(RIGHT.OrigSOS, CharterNBR, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSFilingCodeList                   := Business_Risk_BIP.Common.convertDelimited(ds_Filings, FilingCD, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSForeignStateList                 := Business_Risk_BIP.Common.convertDelimited(RIGHT.ForeignState, StateCD, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSForeignStateFlag                 := If(SOSRecExists, if(count(right.ForeignState(trim(StateCD, all) <> '')) > 0, '1', '0'), '-1');
				SELF.SOS.SOSForeignStateCount                := IF(SOSRecExists, (STRING)Business_Risk_BIP.Common.CapNum(COUNT(DEDUP(SORT(RIGHT.ForeignState, StateCD), StateCD)), -1, 999), '-1');
				SELF.SOS.SOSCorporateStructureList           := Business_Risk_BIP.Common.convertDelimited(RIGHT.OrigOrg, StructureDesc, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSLocationDescriptionList          := Business_Risk_BIP.Common.convertDelimited(RIGHT.Address1, TypeDesc, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSNatureOfBusinessList             := Business_Risk_BIP.Common.convertDelimited(RIGHT.OrigBus, TypeDesc, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSCountOfAmendmentsList            := Business_Risk_BIP.Common.convertDelimited(RIGHT.Amendments, Amendment, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSRegisterAgentChangeList          := Business_Risk_BIP.Common.convertDelimited(sortedRegAgent, AgentChanged, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSRegisterAgentChangeDateList      := Business_Risk_BIP.Common.convertDelimited(sortedRegAgent, AgentChangeDate, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.SOS.SOSRegisterAgentChangeCount         := IF(SOSRecExists, (STRING)Business_Risk_BIP.Common.CapNum(COUNT(sortedRegAgent), -1, 999), '-1');
				SELF.SOS.SOSRegisterAgentChangeDateFirstSeen := Business_Risk_BIP.Common.checkInvalidDate(oldestRegAgent[1].AgentChangeDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.SOS.SOSRegisterAgentChangeDateLastSeen  := Business_Risk_BIP.Common.checkInvalidDate(newestRegAgent.AgentChangeDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.SOS.SOSTimeAgentChange                  := (STRING)IF(SOSRecExists, IF((INTEGER)recentAgentChangeDate <> 0, Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart(recentAgentChangeDate, TodaysDate), 1, 99999), 0), -1);
				SELF.SOS.SOSRegisterAgentChangeCount12Month  := IF(SOSRecExists, (STRING)Business_Risk_BIP.Common.CapNum(COUNT(regAgent12Month), -1, 999), '-1');
				SELF.SOS.SOSRegisterAgentChangeCount06Month  := IF(SOSRecExists, (STRING)Business_Risk_BIP.Common.CapNum(COUNT(regAgent06Month), -1, 999), '-1');
				SELF.SOS.SOSRegisterAgentChangeCount03Month  := IF(SOSRecExists, (STRING)Business_Risk_BIP.Common.CapNum(COUNT(regAgent03Month), -1, 999), '-1');
				SELF.Firmographic.OwnershipType              := IF(RIGHT.PrivateOwnership, '2', '0');
        SELF.Firmographic.FirmNonProfitFlag := IF(RIGHT.EverNonProfit, '1', '0');
				SELF := LEFT;
				SELF := [];
			),
			LEFT OUTER, KEEP(1), ATMOST(100), FEW
		);

 withCorpFilingsData_NonBIID20 := IF( Options.BusShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30, withCorpFilingsData_Old, withCorpFilingsData_New );
 withCorpFilingsData := IF( Options.BusShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30 AND Options.IsBIID20 = TRUE AND BBFM1906_1_0_Set = FALSE, withCorpFilingsData_BIID20, withCorpFilingsData_NonBIID20);

  // Get all unique NAIC Codes along with dates. For this data source, we only need the primary code.
	tempLayout := RECORD
		UNSIGNED4 Seq;
		DATASET(Business_Risk_BIP.Layouts.LayoutSICNAIC) SICNAICSources;
	END;

  CorpFilingsNAIC := TABLE(CorpFilings_withSrcCode,
    {
      Seq,
      LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
      STRING2 Source := corp_src_type, // obtained from call to MDR.sourceTools function, above
      STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
      STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
      UNSIGNED4 RecordCount := COUNT(GROUP),
      STRING10 NAICCode := (STD.Str.Filter((STRING)corp_naic_code, '0123456789'))[1..6],
      BOOLEAN IsPrimary := TRUE
    },
    Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID), ((STRING)corp_naic_code)[1..6]
  );

  CorpFilingsNAICTemp :=
    PROJECT(
      CorpFilingsNAIC,
      TRANSFORM(tempLayout,
        SELF.Seq := LEFT.Seq;
        SELF.SICNAICSources := DATASET([{LEFT.Source, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, '' /*SICCode*/, '' /*SICIndustry*/, LEFT.NAICCode, Business_Risk_BIP.Common.industryGroup(LEFT.NAICCode, Business_Risk_BIP.Constants.NAIC), LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
        SELF := []
      )
    );

  CorpFilingsNAICRolled :=
    ROLLUP(
      CorpFilingsNAICTemp,
      LEFT.Seq = RIGHT.Seq,
      TRANSFORM( tempLayout,
        SELF.Seq := LEFT.Seq;
        SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
        SELF := LEFT
      )
    );

  withCorpFilingsNAIC :=
    JOIN(withCorpFilingsData, CorpFilingsNAICRolled,
      LEFT.Seq = RIGHT.Seq,
      TRANSFORM( Business_Risk_BIP.Layouts.Shell,
        SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
        SELF := LEFT
      ),
      LEFT OUTER, KEEP(1), ATMOST(100), FEW
    );

	withErrorCodes := JOIN(withCorpFilingsNAIC, kFetchErrorCodes, LEFT.Seq = RIGHT.Seq,
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
  // OUTPUT( CorpFilingsCleaned, NAMED('CorpFilingsCleaned') );
  // OUTPUT( CorpFilings_recs_srtd, NAMED('CorpFilings_recs_srtd'), ALL );
  // OUTPUT( CorpFilingsRolled1, NAMED('CorpFilingsRolled1'));
  // OUTPUT( CorpFilingsRolledClean, NAMED('CorpFilingsRolledClean') );
  // OUTPUT( CorpFilingsRolled, NAMED('CorpFilingsRolled') );
  // OUTPUT(Options.BusShellVersion, named('Options_BusShellVersion'));
  // OUTPUT(Business_Risk_BIP.Constants.BusShellVersion_v30, named('Business_Risk_BIP_Constants_BusShellVersion'));
  // OUTPUT( withOwnership, NAMED('withOwnership') );
  // OUTPUT( withCorpFilingsData_Old, NAMED('withCorpFilingsData_Old') );
  // OUTPUT( withCorpFilingsData_New, NAMED('withCorpFilingsData_New') );
  // OUTPUT( withCorpFilingsData_BIID20, NAMED('withCorpFilingsData_BIID20') );
  // OUTPUT( withCorpFilingsData, NAMED('withCorpFilingsData') );

	RETURN withErrorCodes;
END;
