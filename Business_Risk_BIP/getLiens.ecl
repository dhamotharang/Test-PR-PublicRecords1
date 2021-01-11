IMPORT BIPV2, Business_Risk_BIP, MDR, LiensV2, Risk_Indicators, UT;

EXPORT getLiens(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	UCase := StringLib.StringToUpperCase;
	BHBuildDate := Risk_Indicators.get_Build_date('bip_build_version');
	
	// --------------- Judgments and Liens ----------------
	
	// Get the TMSID/RMSID results for Liens and Judgments data
	LiensJudgmentsTMSIDRaw := LiensV2.Key_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(LiensJudgmentsTMSIDRaw, Shell, LiensJudgmentsTMSIDSeq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodes := Business_Risk_BIP.Common.GrabFetchErrorCode(LiensJudgmentsTMSIDSeq);

	// Under the most recent definition for source codes that are allowed for Marketing purposes, all Liens
	// are restricted with the exception of the following sources: 
	set_MarketingAllowedLienSources := ['MA','HG','CL','IL','NY','CJ'];
	
	// Filter out records after our history date; set sourceCode to null string for FilterRecords so all UCC 
	// records return whether Marketing restriction is indicated or not.
	LiensJudgmentsTMSID_pre := Business_Risk_BIP.Common.FilterRecords(LiensJudgmentsTMSIDSeq, date_first_seen, date_vendor_first_reported, '', AllowedSourcesSet);

	LiensJudgmentsTMSID := IF( Options.MarketingMode = 1,
			LiensJudgmentsTMSID_pre(tmsid[1..2] IN set_MarketingAllowedLienSources),
			LiensJudgmentsTMSID_pre);

	// Add stats for first seen, last seen, record count, etc.

	// Figure out the first seen and last seen date per source for each Seq, by LinkID level
	LienStats := TABLE(LiensJudgmentsTMSID,
			{Seq,
			 TMSID,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_Liens_v2,
			 STRING6 DateFirstSeen       := Business_Risk_BIP.Common.groupMinDate6(date_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_vendor_first_reported, HistoryDate),
			 STRING6 DateLastSeen        := Business_Risk_BIP.Common.groupMaxDate6(date_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen  := Business_Risk_BIP.Common.groupMaxDate6(date_vendor_last_reported, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP)
			 },
			 Seq, TMSID, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );

	// Rollup the dates first/last seen into child datasets by Seq, and add Sources to Shell layout.
	tempLayout := RECORD
		UNSIGNED4 Seq;
		STRING TMSID;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) Sources;
	END;
  
	LienStatsTemp := PROJECT(LienStats, 
			TRANSFORM(tempLayout,
				SELF.Seq := LEFT.Seq;
				SELF.TMSID := LEFT.TMSID;
				SELF.Sources := 
						DATASET([{LEFT.Source, 
							IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
							IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
							LEFT.DateLastSeen,
							LEFT.DateVendorLastSeen,
							LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources)));

	LienStatsRolled := 
		ROLLUP(
			LienStatsTemp, 
			LEFT.Seq = RIGHT.Seq, 
			TRANSFORM( tempLayout, 
				SELF.Seq := LEFT.Seq; 
				SELF.TMSID := LEFT.TMSID; 
				SELF.Sources := LEFT.Sources + RIGHT.Sources
			));
	
	withLienStats := JOIN(Shell, LienStatsRolled, 
			LEFT.Seq = RIGHT.Seq,
			TRANSFORM(Business_Risk_BIP.Layouts.Shell,
				SELF.Sources := RIGHT.Sources;
				SELF.seq := left.seq;
				SELF := RIGHT,
				SELF := LEFT),
				LEFT OUTER, KEEP(1), ATMOST(100), FEW);	
	
	// Define categories of filing statuses.
	
	SET OF STRING filing_status_satisfied :=
		[
			'SATISFIED', 'SETTLED', 'RELEASED', 'CLOSED', 'DISCHARGED'
		];

	SET OF STRING filing_status_dismissed :=
		[
			'DISPOSED - HEARING', 'DISMISSED', 'DELETED FROM VENDOR SYSTEM', 'VACATED', 'REMOVED',
			'DISCONTINUED', 'DELETED', 'WITHDRAWN', 'VOID', 'STRIKE', 'FILED IN ERROR', 'DISPOSED',
			'DISPOSED - PENDING', 'EXPUNGED', 'JUDGMENT VACATED'
		];
		
	layout_liens_judgments := RECORD
		UNSIGNED4 seq;
		UNSIGNED3	HistoryDate;
		STRING8  date_first_seen;
		STRING8  date_last_seen;
		STRING50 tmsid;
		STRING1  eviction;
		STRING8  orig_filing_date;
		STRING50 filing_type_desc;
		STRING11 amount;
		STRING8  release_date;
		STRING8  lapse_date;
		STRING30 filing_status;
		STRING2  agency_state;
	END;

	// Get Liens main records. Convert filing_type_desc and filing_status values to upper case;
	// represent Amounts in whole dollars.
	liens_judgments_main :=
		JOIN(
			LiensJudgmentsTMSID, LiensV2.key_liens_main_ID,
			KEYED( LEFT.tmsid = RIGHT.tmsid AND
			LEFT.rmsid = RIGHT.rmsid),
			TRANSFORM( layout_liens_judgments,
				SELF.seq              := LEFT.seq,
				SELF.HistoryDate			:= LEFT.HistoryDate,
				SELF.date_first_seen  := LEFT.date_first_seen,
				SELF.date_last_seen   := LEFT.date_last_seen,
				SELF.filing_type_desc := UCase(RIGHT.filing_type_desc),
				SELF.filing_status    := UCase(RIGHT.filing_status[1].filing_status_desc),
				SELF.amount           := (STRING11)(TRUNCATE(((REAL)RIGHT.amount))),
				// SELF.release_date     := MAX( RIGHT.release_date, LEFT.date_last_seen ),
				SELF.release_date     := MAP(((INTEGER)RIGHT.release_date[1..6]) <= LEFT.HistoryDate	=> RIGHT.release_date,
																		 ((INTEGER)LEFT.date_last_seen[1..6]) <= LEFT.HistoryDate	=> LEFT.date_last_seen,
																																																 Business_Risk_BIP.Constants.MissingDate),
				SELF := RIGHT,
				SELF := []
			),
			INNER,
			ATMOST(1000)
		);

	liens_judgments_sorted := 
		SORT( liens_judgments_main, seq, tmsid, -orig_filing_date, -release_date, RECORD );
	
	// Rollup to aggregate to the Liens Level (TMSID)
	// Rules: retain...
	//   ...the oldest (by value) date_first_seen
	//   ...the most recent (by value) date_last_seen
	//   ...any eviction value = 'Y'
	//   ...the oldest (by value) orig_filing_date
	//   ...the most recent (by record order) nonblank filing_type_desc
	//   ...the most recent (by record order) nonzero/nonblank amount 
	//   ...the most recent (by value) release_date 
	//   ...the most recent (by value) lapse_date 
	//   ...the first (by record order) nonblank agency_state
	//   ...the most recent (by record order) nonblank filing_status
	liens_judgments_rolled :=
		ROLLUP(
			liens_judgments_sorted,
			LEFT.seq = RIGHT.seq AND
			LEFT.tmsid = RIGHT.tmsid,
			TRANSFORM( layout_liens_judgments,
				SELF.seq              := LEFT.seq,
				SELF.HistoryDate			:= LEFT.HistoryDate,
				SELF.date_first_seen  := IF( LEFT.date_first_seen != '' AND LEFT.date_first_seen < RIGHT.date_first_seen, LEFT.date_first_seen, RIGHT.date_first_seen ),
				SELF.date_last_seen   := IF( LEFT.date_last_seen != '' AND LEFT.date_last_seen > RIGHT.date_last_seen, LEFT.date_last_seen, RIGHT.date_last_seen ),
				SELF.tmsid            := RIGHT.tmsid,
				SELF.eviction         := MAP( LEFT.eviction = 'Y' => LEFT.eviction, RIGHT.eviction = 'Y' => RIGHT.eviction, LEFT.eviction ),
				SELF.orig_filing_date := IF( LEFT.orig_filing_date != '' AND (LEFT.orig_filing_date < RIGHT.orig_filing_date OR RIGHT.orig_filing_date = ''), LEFT.orig_filing_date, RIGHT.orig_filing_date ),
				SELF.filing_type_desc := IF( LEFT.filing_type_desc != '', LEFT.filing_type_desc, RIGHT.filing_type_desc ),
				SELF.amount           := IF( LEFT.amount != '0', LEFT.amount, RIGHT.amount ), 
				SELF.release_date     := IF( LEFT.release_date != '' AND LEFT.release_date > RIGHT.release_date AND ((INTEGER)LEFT.release_date[1..6]) <= LEFT.HistoryDate, LEFT.release_date, RIGHT.release_date ), // Only keep the release date if it is prior to the history date
				SELF.lapse_date       := IF( LEFT.lapse_date != '' AND LEFT.lapse_date > RIGHT.lapse_date, LEFT.lapse_date, RIGHT.lapse_date ),
				SELF.agency_state     := IF( LEFT.agency_state != '', LEFT.agency_state, RIGHT.agency_state ),
				SELF.filing_status    := IF(TRIM(RIGHT.filing_status) != '', RIGHT.filing_status, LEFT.filing_status ),
			)
		);
	
	// Categorize each Lien by filing_type_desc and filing_status.
	layout_liens_judgments_categorized := RECORD
		layout_liens_judgments;
		STRING  lien_type_category;
		STRING  judgment_type_category;
		STRING  filing_status_category;
	END;

	liens_judgments_categorized :=
		PROJECT(
			liens_judgments_rolled,
			TRANSFORM( layout_liens_judgments_categorized,
				SELF.lien_type_category := 
					MAP(
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.set_Invalid_Liens_50	=> 'IN',
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.setSuits           	=> 'SU',
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.setSmallClaims    		=> 'SC',
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.setFederalTax     		=> 'FX',
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.setForeclosure     	=> 'FC',
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.setLandlordTenant 		=> 'LT',
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.setLisPendens     		=> 'LP',
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.setMechanicsLiens 		=> 'ML',
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.setCivilJudgment  		=> 'CJ',
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.setOtherTax					=> 'OX',
						LEFT.filing_type_desc NOT IN 
							[ 
								Risk_Indicators.iid_constants.setCivilJudgment + Risk_Indicators.iid_constants.setFederalTax + 
								Risk_Indicators.iid_constants.setLandlordTenant + Risk_Indicators.iid_constants.setSmallClaims + 
								Risk_Indicators.iid_constants.setForeclosure + Risk_Indicators.iid_constants.setOtherTax
							]  => 'OT',
						'OT' // default
					),
				SELF.judgment_type_category := 
					MAP(
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.set_Invalid_Liens_50	=> 'Invalid',
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.setSuits           	=> 'Judgment',
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.setSmallClaims    		=> 'Judgment',
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.setFederalTax     		=> 'Lien',
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.setForeclosure     	=> 'Lien',
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.setLandlordTenant 		=> 'Lien',
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.setLisPendens     		=> 'Lien',
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.setOtherTax       		=> 'Lien',
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.setMechanicsLiens 		=> 'Lien',
						LEFT.filing_type_desc IN Risk_Indicators.iid_constants.setCivilJudgment  		=> 'Judgment',
						LEFT.filing_type_desc NOT IN 
							[ 
								Risk_Indicators.iid_constants.setCivilJudgment + Risk_Indicators.iid_constants.setFederalTax + 
								Risk_Indicators.iid_constants.setLandlordTenant + Risk_Indicators.iid_constants.setOtherTax + 
								Risk_Indicators.iid_constants.setSmallClaims + Risk_Indicators.iid_constants.setForeclosure
							]  => 'Lien',
						'Lien' // default
					),
				SELF.filing_status_category := 
					MAP(
						LEFT.filing_status IN filing_status_satisfied => 'Satis',
						LEFT.filing_status IN filing_status_dismissed => 'Dismiss',
						LEFT.filing_status  = 'UNLAPSED'              => 'Unlapsed',
						LEFT.filing_status  = 'LAPSED'                => 'Lapsed',
						LEFT.filing_status NOT IN
							[
								filing_status_satisfied + filing_status_dismissed + [ 'UNLAPSED','LAPSED' ]
							]   => 'Other',
						'' // default
					),
				SELF := LEFT,
				SELF := []
			)
		);

	// Order those Liens having a nonblank orig_filing_date newest to oldest.
	liens_judgments_newest_first := 
		SORT( liens_judgments_categorized(orig_filing_date != ''), seq, -orig_filing_date, RECORD );
	
	// Remove any Liens older than 7 years as well as any evictions.
	sevenYearsAgo(UNSIGNED3 HistoryDate) := IF((STRING)HistoryDate = Business_Risk_BIP.Constants.NinesDate, 
																								(UNSIGNED)(StringLib.GetDateYYYYMMDD()[1..6]) - 700, // If realtime - take today's date and minus 700 (EX: 201407-700=200707)
																								HistoryDate - 700); // If historical archive - take archive date and minus 700 (EX: 201007-700 = 200307)
	oneYearAgo(UNSIGNED3 HistoryDate) := IF((STRING)HistoryDate = Business_Risk_BIP.Constants.NinesDate, 
																								(UNSIGNED)(StringLib.GetDateYYYYMMDD()[1..6]) - 100, // If realtime - take today's date and minus 100 (EX: 201407-100=201307)
																								HistoryDate - 100); // If historical archive - take archive date and minus 100 (EX: 201007-100 = 200907)
	twoYearsAgo(UNSIGNED3 HistoryDate) := IF((STRING)HistoryDate = Business_Risk_BIP.Constants.NinesDate, 
																								(UNSIGNED)(StringLib.GetDateYYYYMMDD()[1..6]) - 200, // If realtime - take today's date and minus 200 (EX: 201407-200=201207)
																								HistoryDate - 200); // If historical archive - take archive date and minus 200 (EX: 201007-200 = 200807)

	liens_judgments_no_evictions   := liens_judgments_newest_first(eviction != 'Y');
	liens_judgments_last_seven_years := liens_judgments_no_evictions( (UNSIGNED)(orig_filing_date[1..6]) >= sevenYearsAgo(HistoryDate));
	
	// Project Liens only into layout having the required lists.
	layout_lien_lists := RECORD
		UNSIGNED4 seq;
		UNSIGNED3 HistoryDate; 					// Need to track this for archival purposes
		DATASET({STRING FilingDate, STRING ReleaseDate, STRING LienType, 
						 STRING FilingStatus, STRING FilingState, STRING Amount}) Liens;
		UNSIGNED6  LienDollarTotal;     // The total amount of all liens. (string9)
		UNSIGNED4  LienCount;           // The count of the number of unique liens on file for this business (not including judgments). (string4)
		UNSIGNED4  LienCount12Month;         // Count of the number of liens originating in the last year (excluding judgments). (string4)	
		UNSIGNED4  LienCount24Month;         // Count of the number of liens originating in the last 2 years (excluding judgments). (string4)	
	END;
		
	// Transfer data to aggregation fields (lists and totals) to prepare for rolling up.
	liens_to_rollup := 
		PROJECT( 
			liens_judgments_last_seven_years(judgment_type_category = 'Lien'),
			TRANSFORM( layout_lien_lists,
				SELF.seq                  := LEFT.seq;
				SELF.HistoryDate					:= LEFT.HistoryDate;
				SELF.Liens := DATASET([{Business_Risk_BIP.Common.checkInvalidDate(LEFT.orig_filing_date, Business_Risk_BIP.Constants.MissingDate, LEFT.HistoryDate),
																Business_Risk_BIP.Common.checkInvalidDate(LEFT.release_date, Business_Risk_BIP.Constants.MissingDate, LEFT.HistoryDate),
																TRIM(LEFT.lien_type_category),
																TRIM(LEFT.filing_status_category),
																TRIM(LEFT.agency_state),
																(STRING)(INTEGER)LEFT.amount}], 
										{STRING FilingDate, STRING ReleaseDate, STRING LienType, 
										 STRING FilingStatus, STRING FilingState, STRING Amount});
				SELF.LienDollarTotal      := (UNSIGNED)LEFT.amount;       
				SELF.LienCount            := 1; 
				SELF.LienCount12Month          := IF( (UNSIGNED)(LEFT.orig_filing_date[1..6]) >= oneYearAgo(LEFT.HistoryDate), 1, 0 );
				SELF.LienCount24Month          := IF( (UNSIGNED)(LEFT.orig_filing_date[1..6]) >= twoYearsAgo(LEFT.HistoryDate), 1, 0 );
			)
		);

	// Rollup Liens to aggregate to the Business Level (seq), creating concatenated lists newest to 
	// oldest by orig_filing_date.
	liens_rolled :=
		ROLLUP(
			liens_to_rollup,
			LEFT.seq = RIGHT.seq,
			TRANSFORM( layout_lien_lists,
				SELF.seq                  := LEFT.seq;
				SELF.HistoryDate					:= LEFT.HistoryDate;
				SELF.Liens								:= LEFT.Liens + RIGHT.Liens;
				SELF.LienDollarTotal      := LEFT.LienDollarTotal + RIGHT.LienDollarTotal;
				SELF.LienCount            := LEFT.LienCount + RIGHT.LienCount; 
				SELF.LienCount12Month     := LEFT.LienCount12Month + RIGHT.LienCount12Month;
				SELF.LienCount24Month     := LEFT.LienCount24Month + RIGHT.LienCount24Month;
			)
		);

	// Project Judgments only into layout having the required lists.
	layout_judgment_lists := RECORD
		UNSIGNED4 seq;
		UNSIGNED3 HistoryDate;							// Need to track this for archival purposes
		UNSIGNED3 JudgmentCount;        		// The count of the number of unique judgments on file for this business.
		UNSIGNED3 JudgmentCount12Month;      		// Count of the number of judgments originating in the last year.
		UNSIGNED3 JudgmentCount24Month;      		// Count of the number of judgments originating in the last 2 years.
		DATASET({STRING FilingDate, STRING ReleaseDate, STRING JudgmentType, 
						 STRING FilingStatus, STRING FilingState, STRING Amount}) Judgments;
		UNSIGNED6  JudgmentDollarTotal;     // The total amount of all liens. (string9)
	END;

	// Transfer data to aggregation fields (lists and totals) to prepare for rolling up.
	judgments_to_rollup := 
		PROJECT( 
			liens_judgments_last_seven_years(judgment_type_category = 'Judgment'),
			TRANSFORM( layout_judgment_lists,
				SELF.seq                  		:= LEFT.seq;	
				SELF.HistoryDate							:= LEFT.HistoryDate;
				SELF.Judgments := DATASET([{Business_Risk_BIP.Common.checkInvalidDate(LEFT.orig_filing_date, Business_Risk_BIP.Constants.MissingDate, LEFT.HistoryDate),
																		Business_Risk_BIP.Common.checkInvalidDate(LEFT.release_date, Business_Risk_BIP.Constants.MissingDate, LEFT.HistoryDate),
																		TRIM(LEFT.lien_type_category),
																		TRIM(LEFT.filing_status_category),
																		TRIM(LEFT.agency_state),
																		(STRING)(INTEGER)LEFT.amount}],
													{STRING FilingDate, STRING ReleaseDate, STRING JudgmentType, 
													 STRING FilingStatus, STRING FilingState, STRING Amount});
				SELF.JudgmentDollarTotal      := (UNSIGNED)LEFT.amount;  
				SELF.JudgmentCount        		:= 1; 
				SELF.JudgmentCount12Month      		:= IF( (UNSIGNED)(LEFT.orig_filing_date[1..6]) >= oneYearAgo(LEFT.HistoryDate), 1, 0 );
				SELF.JudgmentCount24Month      		:= IF( (UNSIGNED)(LEFT.orig_filing_date[1..6]) >= twoYearsAgo(LEFT.HistoryDate), 1, 0 );
				)
		);

	// Rollup Liens to aggregate to the Business Level (seq), creating concatenated lists newest to 
	// oldest by orig_filing_date.
	judgments_rolled :=
		ROLLUP(
			judgments_to_rollup,
			LEFT.seq = RIGHT.seq,
			TRANSFORM( layout_judgment_lists,
				SELF.seq                  := LEFT.seq;
				SELF.HistoryDate					:= LEFT.HistoryDate;
				SELF.Judgments						:= LEFT.Judgments + RIGHT.Judgments;
				SELF.JudgmentDollarTotal  := LEFT.JudgmentDollarTotal + RIGHT.JudgmentDollarTotal;
				SELF.JudgmentCount        := LEFT.JudgmentCount + RIGHT.JudgmentCount; 
				SELF.JudgmentCount12Month := LEFT.JudgmentCount12Month + RIGHT.JudgmentCount12Month; 
				SELF.JudgmentCount24Month := LEFT.JudgmentCount24Month + RIGHT.JudgmentCount24Month;
				)
		);

	// Finally, add Liens and Judgments to the Shell. First Liens...:
	withLienData := 
		JOIN(
			withLienStats, liens_rolled, 
			LEFT.Seq = RIGHT.Seq,
			TRANSFORM( Business_Risk_BIP.Layouts.Shell,
				sortedLiens := SORT(RIGHT.Liens, -FilingDate, -ReleaseDate) (FilingDate <> '');
				SELF.Lien_And_Judgment.LienFilingDateList   := Business_Risk_BIP.Common.convertDelimited(sortedLiens, FilingDate, Business_Risk_BIP.Constants.FieldDelimiter);
				
				newestFiling := Business_Risk_BIP.Common.checkInvalidDate(TOPN(sortedLiens, 1, -FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				oldestFiling := Business_Risk_BIP.Common.checkInvalidDate(TOPN(sortedLiens, 1, FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				TodaysDate := Business_Risk_BIP.Common.todaysDate(BHBuildDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienFiledDateFirstSeen := oldestFiling;
				SELF.Lien_And_Judgment.LienFiledDateLastSeen := newestFiling;
				SELF.Lien_And_Judgment.LienTimeNewest := (STRING)MAP((INTEGER)newestFiling > 0                                                  => Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart(newestFiling, TodaysDate), 1, 999),
                                                              Options.BusShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30 => -1,
                                                                                                                                            0);
				SELF.Lien_And_Judgment.LienTimeOldest := (STRING)MAP((INTEGER)oldestFiling > 0                                                  => Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart(oldestFiling, TodaysDate), 1, 999), 
                                                              Options.BusShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30 => -1,
                                                                                                                                            0);
				liensFiled := sortedLiens ((INTEGER)FilingDate > 0);
				liens60Month := liensFiled (ut.DaysApart(FilingDate, TodaysDate) <= ut.DaysInNYears(5));
				liens36Month := liens60Month (ut.DaysApart(FilingDate, TodaysDate) <= ut.DaysInNYears(3));
				liens24Month := liens36Month (ut.DaysApart(FilingDate, TodaysDate) <= ut.DaysInNYears(2));
				liens12Month := liens24Month (ut.DaysApart(FilingDate, TodaysDate) <= ut.DaysInNYears(1));
				liens06Month := liens12Month (ut.DaysApart(FilingDate, TodaysDate) <= Business_Risk_BIP.Constants.SixMonths);
				liens03Month := liens06Month (ut.DaysApart(FilingDate, TodaysDate) <= Business_Risk_BIP.Constants.ThreeMonths);
				liensReleased := sortedLiens ((INTEGER)ReleaseDate > 0);
				liensReleased60Month := liensReleased (ut.DaysApart(ReleaseDate, TodaysDate) <= ut.DaysInNYears(5));
				liensReleased36Month := liensReleased60Month (ut.DaysApart(ReleaseDate, TodaysDate) <= ut.DaysInNYears(3));
				liensReleased24Month := liensReleased36Month (ut.DaysApart(ReleaseDate, TodaysDate) <= ut.DaysInNYears(2));
				liensReleased12Month := liensReleased24Month (ut.DaysApart(ReleaseDate, TodaysDate) <= ut.DaysInNYears(1));
				liensReleased06Month := liensReleased12Month (ut.DaysApart(ReleaseDate, TodaysDate) <= Business_Risk_BIP.Constants.SixMonths);
				liensReleased03Month := liensReleased06Month (ut.DaysApart(ReleaseDate, TodaysDate) <= Business_Risk_BIP.Constants.ThreeMonths);
				SELF.Lien_And_Judgment.LienFiledCount60			:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(liens60Month), -1, 99999);
				SELF.Lien_And_Judgment.LienFiledCount36			:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(liens36Month), -1, 99999);
				SELF.Lien_And_Judgment.LienFiledCount24			:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(liens24Month), -1, 99999);
				SELF.Lien_And_Judgment.LienFiledCount12			:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(liens12Month), -1, 99999);
				SELF.Lien_And_Judgment.LienFiledCount06			:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(liens06Month), -1, 99999);
				SELF.Lien_And_Judgment.LienFiledCount03			:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(liens03Month), -1, 99999);
				SELF.Lien_And_Judgment.LienReleasedCount60	:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(liensReleased60Month), -1, 99999);
				SELF.Lien_And_Judgment.LienReleasedCount36	:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(liensReleased36Month), -1, 99999);
				SELF.Lien_And_Judgment.LienReleasedCount24	:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(liensReleased24Month), -1, 99999);
				SELF.Lien_And_Judgment.LienReleasedCount12	:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(liensReleased12Month), -1, 99999);
				SELF.Lien_And_Judgment.LienReleasedCount06	:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(liensReleased06Month), -1, 99999);
				SELF.Lien_And_Judgment.LienReleasedCount03	:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(liensReleased03Month), -1, 99999);
				
				filedFT := liensFiled (LienType = 'FX');
				SELF.Lien_And_Judgment.LienFiledFTCount					:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(filedFT), -1, 99999);
				SELF.Lien_And_Judgment.LienFiledFTDateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedFT, 1, FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienFiledFTDateLastSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedFT, 1, -FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienFiledFTTotalAmount		:= (STRING)Business_Risk_BIP.Common.capNum(SUM(filedFT, (INTEGER)Amount), -1, 999999);
				releasedFT := liensReleased (LienType = 'FX');
				SELF.Lien_And_Judgment.LienReleasedFTCount					:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(releasedFT), -1, 99999);
				SELF.Lien_And_Judgment.LienReleasedFTDateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedFT, 1, ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienReleasedFTDateLastSeen		:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedFT, 1, -ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienReleasedFTTotalAmount		:= (STRING)Business_Risk_BIP.Common.capNum(SUM(releasedFT, (INTEGER)Amount), -1, 999999);
				
				filedFC := liensFiled (LienType = 'FC');
				SELF.Lien_And_Judgment.LienFiledFCCount					:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(filedFC), -1, 99999);
				SELF.Lien_And_Judgment.LienFiledFCDateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedFC, 1, FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienFiledFCDateLastSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedFC, 1, -FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienFiledFCTotalAmount		:= (STRING)Business_Risk_BIP.Common.capNum(SUM(filedFC, (INTEGER)Amount), -1, 999999);
				releasedFC := liensReleased (LienType = 'FC');
				SELF.Lien_And_Judgment.LienReleasedFCCount					:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(releasedFC), -1, 99999);
				SELF.Lien_And_Judgment.LienReleasedFCDateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedFC, 1, ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienReleasedFCDateLastSeen		:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedFC, 1, -ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienReleasedFCTotalAmount		:= (STRING)Business_Risk_BIP.Common.capNum(SUM(releasedFC, (INTEGER)Amount), -1, 999999);
				
				filedLT := liensFiled (LienType = 'LT');
				SELF.Lien_And_Judgment.LienFiledLTCount					:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(filedLT), -1, 99999);
				SELF.Lien_And_Judgment.LienFiledLTDateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedLT, 1, FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienFiledLTDateLastSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedLT, 1, -FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienFiledLTTotalAmount		:= (STRING)Business_Risk_BIP.Common.capNum(SUM(filedLT, (INTEGER)Amount), -1, 999999);
				releasedLT := liensReleased (LienType = 'LT');
				SELF.Lien_And_Judgment.LienReleasedLTCount					:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(releasedLT), -1, 99999);
				SELF.Lien_And_Judgment.LienReleasedLTDateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedLT, 1, ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienReleasedLTDateLastSeen		:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedLT, 1, -ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienReleasedLTTotalAmount		:= (STRING)Business_Risk_BIP.Common.capNum(SUM(releasedLT, (INTEGER)Amount), -1, 999999);
				
				filedOT := liensFiled (LienType = 'OX');
				SELF.Lien_And_Judgment.LienFiledOTCount					:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(filedOT), -1, 99999);
				SELF.Lien_And_Judgment.LienFiledOTDateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedOT, 1, FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienFiledOTDateLastSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedOT, 1, -FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienFiledOTTotalAmount		:= (STRING)Business_Risk_BIP.Common.capNum(SUM(filedOT, (INTEGER)Amount), -1, 999999);
				releasedOT := liensReleased (LienType = 'OX');
				SELF.Lien_And_Judgment.LienReleasedOTCount					:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(releasedOT), -1, 99999);
				SELF.Lien_And_Judgment.LienReleasedOTDateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedOT, 1, ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienReleasedOTDateLastSeen		:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedOT, 1, -ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienReleasedOTTotalAmount		:= (STRING)Business_Risk_BIP.Common.capNum(SUM(releasedOT, (INTEGER)Amount), -1, 999999);
				
				filedML := liensFiled (LienType = 'ML');
				SELF.Lien_And_Judgment.LienFiledMLCount					:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(filedML), -1, 99999);
				SELF.Lien_And_Judgment.LienFiledMLDateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedML, 1, FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienFiledMLDateLastSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedML, 1, -FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienFiledMLTotalAmount		:= (STRING)Business_Risk_BIP.Common.capNum(SUM(filedML, (INTEGER)Amount), -1, 999999);
				releasedML := liensReleased (LienType = 'ML');
				SELF.Lien_And_Judgment.LienReleasedMLCount					:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(releasedML), -1, 99999);
				SELF.Lien_And_Judgment.LienReleasedMLDateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedML, 1, ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienReleasedMLDateLastSeen		:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedML, 1, -ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienReleasedMLTotalAmount		:= (STRING)Business_Risk_BIP.Common.capNum(SUM(releasedML, (INTEGER)Amount), -1, 999999);
				
				filedO := liensFiled (LienType NOT IN ['FX', 'FC', 'LT', 'OX', 'ML']); // Anything other than what we counted already above
				SELF.Lien_And_Judgment.LienFiledOCount					:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(filedO), -1, 99999);
				SELF.Lien_And_Judgment.LienFiledODateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedO, 1, FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienFiledODateLastSeen		:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedO, 1, -FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienFiledOTotalAmount		:= (STRING)Business_Risk_BIP.Common.capNum(SUM(filedO, (INTEGER)Amount), -1, 999999);
				releasedO := liensReleased (LienType NOT IN ['FX', 'FC', 'LT', 'OX', 'ML']); // Anything other than what we counted already above
				SELF.Lien_And_Judgment.LienReleasedOCount					:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(releasedO), -1, 99999);
				SELF.Lien_And_Judgment.LienReleasedODateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedO, 1, ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienReleasedODateLastSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedO, 1, -ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.LienReleasedOTotalAmount		:= (STRING)Business_Risk_BIP.Common.capNum(SUM(releasedO, (INTEGER)Amount), -1, 999999);
				
				SELF.Lien_And_Judgment.LienReleaseDateList  := Business_Risk_BIP.Common.convertDelimited(sortedLiens, ReleaseDate, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.Lien_And_Judgment.LienReleasedCount    := (STRING)Business_Risk_BIP.Common.capNum(COUNT(liensReleased), -1, 99999);
				SELF.Lien_And_Judgment.LienTypeList         := Business_Risk_BIP.Common.convertDelimited(sortedLiens, LienType, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.Lien_And_Judgment.LienType							:= if(RIGHT.LienCount = 0, '-1', sortedLiens (LienType <> '')[1].LienType); // Grab the most recent populated lien type
				SELF.Lien_And_Judgment.LienFilingStatusList := Business_Risk_BIP.Common.convertDelimited(sortedLiens, FilingStatus, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.Lien_And_Judgment.LienFilingStateList  := Business_Risk_BIP.Common.convertDelimited(sortedLiens, FilingState, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.Lien_And_Judgment.LienStateCount				:= (STRING)Business_Risk_BIP.Common.capNum(COUNT(DEDUP(SORT(sortedLiens (FilingState <> ''), FilingState), FilingState)), -1, 99999); // Count all unique states
				SELF.Lien_And_Judgment.LienStateInput				:= IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND TRIM(LEFT.Clean_Input.State)='', '-1',
                                                          Business_Risk_BIP.Common.SetBoolean(COUNT(sortedLiens (FilingState = LEFT.Clean_Input.State)) > 0)); // Business has a lien filing within the input state
				SELF.Lien_And_Judgment.LienAmountList       := Business_Risk_BIP.Common.convertDelimited(sortedLiens, Amount, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.Lien_And_Judgment.LienDollarTotal      := MAP(RIGHT.LienCount = 0 AND Options.BusShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30 => '-1',
                                                          RIGHT.LienCount = 0 AND Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 => '0',
                                                                                                                                                                (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.LienDollarTotal, -1, 99999999));
        SELF.Lien_And_Judgment.LienCount            := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.LienCount, -1, 99999);
				SELF.Lien_And_Judgment.LienCount12Month     := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.LienCount12Month, -1, 99999);
				SELF.Lien_And_Judgment.LienCount24Month     := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.LienCount24Month, -1, 99999);
				SELF := LEFT
			),
			LEFT OUTER, KEEP(1), ATMOST(100), FEW
		);
	
	// ...and now Judgments...:
	withLienandJudgmentData := 
		JOIN(
			withLienData, judgments_rolled, 
			LEFT.Seq = RIGHT.Seq,
			TRANSFORM( Business_Risk_BIP.Layouts.Shell,
				sortedJudgments := SORT(RIGHT.Judgments, -FilingDate, -ReleaseDate);
				SELF.Lien_And_Judgment.JudgmentFilingDateList   := Business_Risk_BIP.Common.convertDelimited(sortedJudgments, FilingDate, Business_Risk_BIP.Constants.FieldDelimiter);
				
				newestFiling := TOPN(sortedJudgments, 1, -FilingDate)[1].FilingDate;
				oldestFiling := TOPN(sortedJudgments, 1, FilingDate)[1].FilingDate;
				TodaysDate := Business_Risk_BIP.Common.todaysDate(BHBuildDate, LEFT.Clean_Input.HistoryDate);
				
				JudgFiled := sortedJudgments ((INTEGER)FilingDate > 0);
				Judg60Month := JudgFiled (ut.DaysApart(FilingDate, TodaysDate) <= ut.DaysInNYears(5));
				Judg36Month := Judg60Month (ut.DaysApart(FilingDate, TodaysDate) <= ut.DaysInNYears(3));
				Judg24Month := Judg36Month (ut.DaysApart(FilingDate, TodaysDate) <= ut.DaysInNYears(2));
				Judg12Month := Judg24Month (ut.DaysApart(FilingDate, TodaysDate) <= ut.DaysInNYears(1));
				Judg06Month := Judg12Month (ut.DaysApart(FilingDate, TodaysDate) <= Business_Risk_BIP.Constants.SixMonths);
				Judg03Month := Judg06Month (ut.DaysApart(FilingDate, TodaysDate) <= Business_Risk_BIP.Constants.ThreeMonths);
				JudgReleased := sortedJudgments ((INTEGER)ReleaseDate > 0);
				JudgReleased60Month := JudgReleased (ut.DaysApart(ReleaseDate, TodaysDate) <= ut.DaysInNYears(5));
				JudgReleased36Month := JudgReleased60Month (ut.DaysApart(ReleaseDate, TodaysDate) <= ut.DaysInNYears(3));
				JudgReleased24Month := JudgReleased36Month (ut.DaysApart(ReleaseDate, TodaysDate) <= ut.DaysInNYears(2));
				JudgReleased12Month := JudgReleased24Month (ut.DaysApart(ReleaseDate, TodaysDate) <= ut.DaysInNYears(1));
				JudgReleased06Month := JudgReleased12Month (ut.DaysApart(ReleaseDate, TodaysDate) <= Business_Risk_BIP.Constants.SixMonths);
				JudgReleased03Month := JudgReleased06Month (ut.DaysApart(ReleaseDate, TodaysDate) <= Business_Risk_BIP.Constants.ThreeMonths);
				SELF.Lien_And_Judgment.JudgmentFiledCount60			:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(Judg60Month), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentFiledCount36			:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(Judg36Month), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentFiledCount24			:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(Judg24Month), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentFiledCount12			:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(Judg12Month), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentFiledCount06			:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(Judg06Month), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentFiledCount03			:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(Judg03Month), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentReleasedCount60	:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(JudgReleased60Month), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentReleasedCount36	:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(JudgReleased36Month), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentReleasedCount24	:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(JudgReleased24Month), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentReleasedCount12	:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(JudgReleased12Month), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentReleasedCount06	:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(JudgReleased06Month), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentReleasedCount03	:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(JudgReleased03Month), -1, 99999);
				
				filedCJ := JudgFiled (JudgmentType = 'CJ');
				SELF.Lien_And_Judgment.JudgmentFiledCJCount					:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(filedCJ), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentFiledCJDateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedCJ, 1, FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.JudgmentFiledCJDateLastSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedCJ, 1, -FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.JudgmentFiledCJTotalAmount		:= (STRING)Business_Risk_BIP.Common.CapNum(SUM(filedCJ, (INTEGER)Amount), -1, 99999999);
				releasedCJ := JudgReleased (JudgmentType = 'CJ');
				SELF.Lien_And_Judgment.JudgmentReleasedCJCount					:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(releasedCJ), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentReleasedCJDateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedCJ, 1, ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.JudgmentReleasedCJDateLastSeen		:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedCJ, 1, -ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.JudgmentReleasedCJTotalAmount		:= (STRING)Business_Risk_BIP.Common.CapNum(SUM(releasedCJ, (INTEGER)Amount), -1, 99999999);
				
				filedSC := JudgFiled (JudgmentType = 'SC');
				SELF.Lien_And_Judgment.JudgmentFiledSCCount					:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(filedSC), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentFiledSCDateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedSC, 1, FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.JudgmentFiledSCDateLastSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedSC, 1, -FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.JudgmentFiledSCTotalAmount		:= (STRING)Business_Risk_BIP.Common.CapNum(SUM(filedSC, (INTEGER)Amount), -1, 99999999);
				releasedSC := JudgReleased (JudgmentType = 'SC');
				SELF.Lien_And_Judgment.JudgmentReleasedSCCount					:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(releasedSC), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentReleasedSCDateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedSC, 1, ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.JudgmentReleasedSCDateLastSeen		:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedSC, 1, -ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.JudgmentReleasedSCTotalAmount		:= (STRING)Business_Risk_BIP.Common.CapNum(SUM(releasedSC, (INTEGER)Amount), -1, 99999999);
				
				filedST := JudgFiled (JudgmentType = 'SU');
				SELF.Lien_And_Judgment.JudgmentFiledSTCount					:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(filedST), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentFiledSTDateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedST, 1, FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.JudgmentFiledSTDateLastSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedST, 1, -FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.JudgmentFiledSTTotalAmount		:= (STRING)Business_Risk_BIP.Common.CapNum(SUM(filedST, (INTEGER)Amount), -1, 99999999);
				releasedST := JudgReleased (JudgmentType = 'SU');
				SELF.Lien_And_Judgment.JudgmentReleasedSTCount					:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(releasedST), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentReleasedSTDateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedST, 1, ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.JudgmentReleasedSTDateLastSeen		:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedST, 1, -ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.JudgmentReleasedSTTotalAmount		:= (STRING)Business_Risk_BIP.Common.CapNum(SUM(releasedST, (INTEGER)Amount), -1, 99999999);
				
				filedO := JudgFiled (JudgmentType NOT IN ['CJ', 'SC', 'SU']); // Anything other than what we counted already above
				SELF.Lien_And_Judgment.JudgmentFiledOCount					:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(filedO), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentFiledODateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedO, 1, FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.JudgmentFiledODateLastSeen		:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(filedO, 1, -FilingDate)[1].FilingDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.JudgmentFiledOTotalAmount		:= (STRING)Business_Risk_BIP.Common.CapNum(SUM(filedO, (INTEGER)Amount), -1, 99999999);
				releasedO := JudgReleased (JudgmentType NOT IN ['CJ', 'SC', 'SU']); // Anything other than what we counted already above
				SELF.Lien_And_Judgment.JudgmentReleasedOCount					:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(releasedO), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentReleasedODateFirstSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedO, 1, ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.JudgmentReleasedODateLastSeen	:= Business_Risk_BIP.Common.checkInvalidDate(TOPN(releasedO, 1, -ReleaseDate)[1].ReleaseDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate);
				SELF.Lien_And_Judgment.JudgmentReleasedOTotalAmount		:= (STRING)Business_Risk_BIP.Common.CapNum(SUM(releasedO, (INTEGER)Amount), -1, 99999999);
				
				SELF.Lien_And_Judgment.JudgFiledDateFirstSeen		:= oldestFiling;
				SELF.Lien_And_Judgment.JudgFiledDateLastSeen		:= newestFiling;
				SELF.Lien_And_Judgment.JudgmentTimeNewest 		:= (STRING)MAP((INTEGER)newestFiling > 0                                                   => Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart(newestFiling, TodaysDate), 1, 999),
                                                                      Options.BusShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30 => -1,
                                                                                                                                                    0);
				SELF.Lien_And_Judgment.JudgmentTimeOldest 		:= (STRING)MAP((INTEGER)oldestFiling > 0                                                  => Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart(oldestFiling, TodaysDate), 1, 999), 
                                                                      Options.BusShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30 => -1,
                                                                                                                                                    0);
				SELF.Lien_And_Judgment.JudgmentReleasedCount    := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(JudgReleased), -1, 99999);
				SELF.Lien_And_Judgment.JudgmentTypeList         := Business_Risk_BIP.Common.convertDelimited(sortedJudgments, JudgmentType, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.Lien_And_Judgment.JudgmentType				:= if(RIGHT.JudgmentCount = 0, '-1', sortedJudgments (JudgmentType <> '')[1].JudgmentType); // Grab the most recent populated judgment type
				SELF.Lien_And_Judgment.JudgmentFilingStatusList := Business_Risk_BIP.Common.convertDelimited(sortedJudgments, FilingStatus, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.Lien_And_Judgment.JudgmentFilingStateList  := Business_Risk_BIP.Common.convertDelimited(sortedJudgments, FilingState, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.Lien_And_Judgment.JudgmentStateCount				:= (STRING)Business_Risk_BIP.Common.CapNum(COUNT(DEDUP(SORT(sortedJudgments (FilingState <> ''), FilingState), FilingState)), -1, 99); // Count all unique states
				SELF.Lien_And_Judgment.JudgmentStateInput				:= IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND TRIM(LEFT.Clean_Input.State)='', '-1',
                                                              Business_Risk_BIP.Common.SetBoolean(COUNT(sortedJudgments (FilingState = LEFT.Clean_Input.State)) > 0)); // Business has a judgment filing within the input state
				SELF.Lien_And_Judgment.JudgmentAmountList       := Business_Risk_BIP.Common.convertDelimited(sortedJudgments, Amount, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF.Lien_And_Judgment.JudgmentDollarTotal      := MAP(RIGHT.JudgmentCount = 0 AND Options.BusShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30 => '-1',
                                                               RIGHT.JudgmentCount = 0 AND Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 => '0',
                                                                                                                (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.JudgmentDollarTotal, -1, 99999999));
				SELF.Lien_And_Judgment.JudgmentCount        		:= (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.JudgmentCount, -1, 99999);
				SELF.Lien_And_Judgment.JudgmentCount12Month     := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.JudgmentCount12Month, -1, 99999);
				SELF.Lien_And_Judgment.JudgmentCount24Month     := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.JudgmentCount24Month, -1, 99999);
				SELF.Lien_And_Judgment.JudgmentReleasedDateList := Business_Risk_BIP.Common.convertDelimited(sortedJudgments, ReleaseDate, Business_Risk_BIP.Constants.FieldDelimiter);
				SELF := LEFT
			),
			LEFT OUTER, KEEP(1), ATMOST(100), FEW
		);
	
	withErrorCodes := JOIN(withLienandJudgmentData, kFetchErrorCodes, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeLien := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
	
	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT( LiensJudgmentsTMSIDRaw, NAMED('LiensJudgmentsTMSIDRaw') );
	// OUTPUT( LiensJudgmentsTMSID, NAMED('LiensJudgmentsTMSID') );
	// OUTPUT( LienStats, NAMED('LienStats') );
	// OUTPUT( LienStatsTemp, NAMED('LienStatsTemp') );
	// OUTPUT( LienStatsRolled, NAMED('LienStatsRolled') );
	// OUTPUT( withLienStats, NAMED('withLienStats') );
	// OUTPUT( liens_judgments_main, NAMED('liens_judgments_main') );
	// OUTPUT( liens_judgments_sorted, NAMED('liens_judgments_sorted') );
	// OUTPUT( liens_judgments_rolled, NAMED('liens_judgments_rolled') );
	// OUTPUT( liens_judgments_categorized, NAMED('liens_judgments_categorized') );
	// OUTPUT( liens_judgments_newest_first, NAMED('liens_judgments_newest_first') );
	// OUTPUT( liens_to_rollup, NAMED('liens_to_rollup') );
	// OUTPUT( liens_rolled, NAMED('liens_rolled') );
	// OUTPUT( judgments_to_rollup, NAMED('judgments_to_rollup') );
	// OUTPUT( judgments_rolled, NAMED('judgments_rolled') );

	RETURN withErrorCodes;
END;


/*
	----------[ Data Requirements for Sprint 7B ]----------

LienFilingDateList 
	A list of all of the orig_filing_dates on file for this business, descending

LienReleaseDateList 
	A list of all of the release_dates on file for this business, in the same order as 'LienFilingDateList'

LienTypeList 
	A list of all of the lien types on file for this business in the same order as 'LienFilingDateList'.

LienFilingStatusList 
	A list of all of the lien statuses on file for this business in the same order as 'LienFilingDateList'.

LienFilingStateList 
	A list of all of the states for the liens on file for this business in the same order as 
	'LienFilingDateList' (2 digits).

LienAmountList 
	A list of the amount each lien is for in the same order as 'LienFilingDateList' (in whole dollars).

LienDollarTotal 
	The total amount of all liens.
	-1 = The business is not on file
	0-99999999 = In whole dollars the amount of the lien

LienCount 
	The count of the number of unique liens on file for this business (not including judgments).
	-1 = The business is not on file
	0-9999 =The count of the number of non-judgments liens on file for the business

LienCount12Month 
	Count of the number of liens in the last year (excluding judgments).
	-1 = The business is not on file
	0-9999 =The count of the number of non-judgments liens on file for the business in the last year

JudgmentCount 
	Keying off of the 'LienTypeList' a count of where the type is judgment.
	-1 = The business is not on file
	0-999 = The count of the number of judgments on file total for the business (filed and released)

JudgmentCount12Month 
	Count of the number of judgments in the last year.
	-1 = The business is not on file
	0-999 = The count of the number of judgments total for the business in the last year

JudgmentReleasedDateList 
	A list of the released date for judgments in the same order as 'JudgmentList'. If a judgment 
	is not released it will be blank.
*/
