IMPORT BIPV2, Business_Risk_BIP, MDR, UCCv2, UCCv2_Services, UT, std;

EXPORT getUCC(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// --------------- Business Shell Versioning logic ----------------
	calculateValueFor := Business_Risk_BIP.mod_BusinessShellVersionLogic(Options);

	// --------------- UCC - Uniform Commercial Code ----------------
	// Get the TMSID/RMSID results for UCC data
	UCCTMSIDRaw := UCCV2.Key_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(UCCTMSIDRaw, Shell, UCCTMSIDSeq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodes := Business_Risk_BIP.Common.GrabFetchErrorCode(UCCTMSIDSeq);
	
	// Under the most recent definition for source codes that are allowed for Marketing purposes, all UCCs are
	// restricted with the exception of the following jurisdictions: ['TXD','TXH','CA','IL','NYC','MA','TX'].
	set_MarketingAllowedUCCSources2Chars := ['CA', 'IL', 'MA', 'TX'];
	set_MarketingAllowedUCCSources3Chars := ['TXD', 'TXH', 'NYC'];
	
	// Filter out records after our history date; set sourceCode to null string for FilterRecords so all UCC 
	// records return whether Marketing restriction is indicated or not.
	UCCTMSID_pre := Business_Risk_BIP.Common.FilterRecords(UCCTMSIDSeq, dt_first_seen, dt_vendor_first_reported, '', AllowedSourcesSet);
	
	UCCTMSID := IF( Options.MarketingMode = 1,
			UCCTMSID_pre(tmsid[1..3] IN set_MarketingAllowedUCCSources3Chars OR tmsid[1..2] IN set_MarketingAllowedUCCSources2Chars),
			UCCTMSID_pre);
	
	// ---- Get the raw data based on the unique TMSID codes - this is simlar to code adopted from TopBusiness_Services.UCCSource_Records ----
	UCCKeys := PROJECT(UCCTMSID (TRIM(TMSID) != ''), TRANSFORM(UCCv2_Services.layout_tmsid, SELF.TMSID := LEFT.TMSID, SELF := LEFT));
	
	// Only pass in the unique TMSID's, we will join back to Seq later
	UniqueUCCTMSIDSeq := DEDUP(SORT(UCCTMSID, Seq, TMSID), Seq, TMSID);
	UniqueUCCTMSID := DEDUP(SORT(UCCKeys, TMSID), TMSID);
	
	// Grab the raw UCC data by the appropriate view
  UCCData := UCCv2_Services.UCCRaw.Source_View.By_TMSID(UniqueUCCTMSID, '' /*SSNMask*/, FALSE /*MultiplePages*/, '' /*ApplicationType - IE: GOV*/);

	// Append our input Seq back
	UCCDataSeq := JOIN(UniqueUCCTMSIDSeq, UCCData, LEFT.TMSID = RIGHT.TMSID, 
    TRANSFORM({UNSIGNED4 Seq, UNSIGNED3 HistoryDate, STRING role_type, RECORDOF(RIGHT)}, 
      SELF.Seq := LEFT.Seq; 
      SELF.HistoryDate := LEFT.HistoryDate; 
      SELF.role_type := LEFT.party_type, 
      SELF := RIGHT),
    ATMOST(Business_Risk_BIP.Constants.Limit_Default));
  
	// Figure out the first seen and last seen date per source for each Seq, by LinkID level
	UCCStats := TABLE(UCCTMSID,
			{Seq,
			 TMSID,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_UCCV2,
			 STRING6 DateFirstSeen       := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_vendor_first_reported, HistoryDate),
			 STRING6 DateLastSeen        := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen  := Business_Risk_BIP.Common.groupMaxDate6(dt_vendor_last_reported, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP)
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );

	// Rollup the dates first/last seen into child datasets by Seq, and add Sources to Shell layout.
	tempLayout := RECORD
		UNSIGNED4 Seq;
		STRING TMSID;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) Sources;
	END;
  
	UCCStatsTemp := PROJECT(UCCStats, TRANSFORM(tempLayout,
													SELF.Seq := LEFT.Seq;
													SELF.TMSID := LEFT.TMSID;
													SELF.Sources := DATASET([{LEFT.Source, 
																		IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																		IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																		LEFT.DateLastSeen,
																		LEFT.DateVendorLastSeen,
																		LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources)));

	UCCStatsRolled := 
  ROLLUP(
    UCCStatsTemp, 
    LEFT.Seq = RIGHT.Seq, 
    TRANSFORM( tempLayout, 
      SELF.Seq := LEFT.Seq; 
      SELF.TMSID := LEFT.TMSID; 
      SELF.Sources := LEFT.Sources + RIGHT.Sources
    ));
	
	withUCC := JOIN(Shell, UCCStatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Sources := RIGHT.Sources;
																							SELF := RIGHT,
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

  // Evaluate UCC Filings and obtain Role type.	
	tempUCCRec := Business_Risk_BIP.Layouts.LayoutTempUCCFiling;
  
	tempUCCData := RECORD
		UNSIGNED4 Seq;
		UNSIGNED4 historydate; // For debugging.
		DATASET(tempUCCRec) UCC_Record;
	END;
  
	tempUCCRec grabUCCRec(UCCDataSeq le) := TRANSFORM
  uccf := calculateValueFor._UCCFiling( le );
         
		SELF.Date := IF( (INTEGER)Business_Risk_BIP.Common.checkInvalidDate(uccf.mostRecentFilingDate, Business_Risk_BIP.Constants.MissingDate, le.HistoryDate) > 0, 
                    Business_Risk_BIP.Common.checkInvalidDate(uccf.mostRecentFilingDate, Business_Risk_BIP.Constants.MissingDate, le.HistoryDate), 
                    Business_Risk_BIP.Common.checkInvalidDate(le.orig_filing_date, Business_Risk_BIP.Constants.MissingDate, le.HistoryDate));

		SELF.TMSID        := le.TMSID;
  SELF.roleType     := le.role_type;
  SELF.FilingDate   := MAX((INTEGER)uccf.mostRecentFilingDate, (INTEGER)le.orig_filing_date); // For debugging.
		SELF.FilingType   := uccf.FilingType;
		SELF.FilingStatus := uccf.FilingStatus;
	END;
  
	tempUCCData grabUCCData(UCCDataSeq le) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.historydate := le.historydate;
		SELF.UCC_Record := PROJECT(le, grabUCCRec(LEFT));
	END;
  
	UCCDataStats := PROJECT(UCCDataSeq, grabUCCData(LEFT));
	
	tempUCCData rollUCCData(tempUCCData le, tempUCCData ri) := TRANSFORM
		SELF.UCC_Record := le.UCC_Record + ri.UCC_Record;
		SELF.Seq := le.Seq;
		SELF.historydate := le.historydate;
	END;
  
	UCCDataRolled := ROLLUP(SORT(UCCDataStats, Seq), LEFT.Seq = RIGHT.Seq, rollUCCData(LEFT, RIGHT));
	
 STRING1 CREDITOR       := 'C'; // Note: Creditors and Secured Parties are both considered Creditors.
 STRING1 SECURED        := 'S';
 STRING1 DEBTOR         := 'D';
 STRING1 NO_UCCs        := '0';
 STRING1 NO_ACTIVE_UCCs := '0';
 UNSIGNED1 ACTIVE       := 1;
  
	withUCCData := JOIN(withUCC, UCCDataRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							TodaysDate := Business_Risk_BIP.Common.todaysDate((STRING8)Std.Date.Today(), LEFT.Clean_Input.HistoryDate);
																							SortedUCC  := SORT(RIGHT.UCC_Record, -Date, FilingStatus, -FilingType);
																							newestUCC  := Business_Risk_BIP.Common.checkInvalidDate(TOPN(SortedUCC ((INTEGER)Date > 0), 1, -Date)[1].Date, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
																							oldestUCC  := Business_Risk_BIP.Common.checkInvalidDate(TOPN(SortedUCC ((INTEGER)Date > 0), 1, Date)[1].Date, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
																							newestInitialFiling := Business_Risk_BIP.Common.checkInvalidDate(TOPN(SortedUCC ((INTEGER)Date > 0 AND FilingType = 7), 1, -Date)[1].Date, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate); // See the grabUCCRec TRANSFORM above for the filingtype number translation
																							oldestInitialFiling := Business_Risk_BIP.Common.checkInvalidDate(TOPN(SortedUCC ((INTEGER)Date > 0 AND FilingType = 7), 1, Date)[1].Date, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate); // See the grabUCCRec TRANSFORM above for the filingtype number translation

																							SELF.Public_Record.UCCCount := (STRING)Business_Risk_BIP.Common.capNum(COUNT(RIGHT.UCC_Record), -1, 999999);
																							SELF.Public_Record.UCCDateList := Business_Risk_BIP.Common.convertDelimited(SortedUCC, Date, Business_Risk_BIP.Constants.FieldDelimiter);
																							SELF.Public_Record.UCCInitialFilingDateFirstSeen := oldestInitialFiling;
																							SELF.Public_Record.UCCInitialFilingDateLastSeen := newestInitialFiling;
																							SELF.Public_Record.UCCDateFirstSeen := oldestUCC;
																							SELF.Public_Record.UCCDateLastSeen := newestUCC;
																							SELF.Public_Record.UCCActiveCount := (STRING)Business_Risk_BIP.Common.capNum(calculateValueFor._UCCActiveCount( SortedUCC ), -1, 999999); // See the grabUCCRec TRANSFORM above for the filingstatus number translation
																							SELF.Public_Record.UCCTerminatedCount := (STRING)Business_Risk_BIP.Common.capNum(COUNT(SortedUCC (FilingStatus = 3)), -1, 999999); // See the grabUCCRec TRANSFORM above for the filingstatus number translation
																							SELF.Public_Record.UCCOtherCount := (STRING)Business_Risk_BIP.Common.capNum(COUNT(SortedUCC (FilingStatus NOT IN [0, 1, 3])), -1, 999999); // See the grabUCCRec TRANSFORM above for the filingstatus number translation
																							SELF.Public_Record.UCCTimeNewest := (STRING)IF((INTEGER)newestUCC > 0, Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart(newestUCC, TodaysDate), 1, 99999), -1);
																							SELF.Public_Record.UCCTimeOldest := (STRING)IF((INTEGER)oldestUCC > 0, Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart(oldestUCC, TodaysDate), 1, 99999), -1);
																							SELF.Public_Record.UCCTypesList := Business_Risk_BIP.Common.convertDelimited(SortedUCC, FilingType, Business_Risk_BIP.Constants.FieldDelimiter);
																							SELF.Public_Record.UCCFilingStatusList := Business_Risk_BIP.Common.convertDelimited(SortedUCC, FilingStatus, Business_Risk_BIP.Constants.FieldDelimiter);
																							SELF.Public_Record.UCCRole :=
                          MAP(
                            COUNT( RIGHT.UCC_Record(roleType IN [CREDITOR,SECURED]) ) > 0 AND COUNT( RIGHT.UCC_Record(roleType IN [DEBTOR]) ) > 0 => '3',
                            COUNT( RIGHT.UCC_Record(roleType IN [DEBTOR]) ) > 0           => '2',
                            COUNT( RIGHT.UCC_Record(roleType IN [CREDITOR,SECURED]) ) > 0 => '1',
                            NO_UCCs
                          );
                        
																							SELF.Public_Record.UCCRoleActive := 
                          MAP(
                            COUNT( RIGHT.UCC_Record(filingStatus = ACTIVE AND roleType IN [CREDITOR,SECURED]) ) > 0 AND COUNT( RIGHT.UCC_Record(filingStatus = ACTIVE AND roleType IN [DEBTOR]) ) > 0 => '3',
                            COUNT( RIGHT.UCC_Record(filingStatus = ACTIVE AND roleType IN [DEBTOR]) ) > 0           => '2',
                            COUNT( RIGHT.UCC_Record(filingStatus = ACTIVE AND roleType IN [CREDITOR,SECURED]) ) > 0 => '1',
                            NO_ACTIVE_UCCs
                          );
                       
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	withErrorCodes := JOIN(withUCCData, kFetchErrorCodes, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeUCC := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(UCCTMSIDRaw, 100), NAMED('Sample_UCCTMSIDRaw'));
	// OUTPUT(CHOOSEN(UCCTMSID, 100), NAMED('Sample_UCCTMSID'));
	// OUTPUT(CHOOSEN(UniqueUCCTMSID, 100), NAMED('Sample_UniqueUCCTMSID'));
	// OUTPUT(CHOOSEN(UCCData, 100), NAMED('Sample_UCCData'));
	// OUTPUT(CHOOSEN(UCCDataSeq, 100), NAMED('Sample_UCCDataSeq'));
	// OUTPUT( UCCDataSeq_withMostRecentFiling, NAMED('UCCDataSeq_withMostRecentFiling') );
	// OUTPUT(CHOOSEN(UCCDataStats, 100), NAMED('Sample_UCCDataStats'));
	// OUTPUT(CHOOSEN(UCCDataRolled, 100), NAMED('Sample_UCCDataRolled'));
	// OUTPUT(CHOOSEN(UCCStats, 100), NAMED('Sample_UCCStats'));
	// OUTPUT(CHOOSEN(UCCStatsTemp, 100), NAMED('Sample_UCCStatsTemp'));
	// OUTPUT(CHOOSEN(withUCC, 100), NAMED('Sample_withUCC'));
	
	RETURN withErrorCodes;
END;