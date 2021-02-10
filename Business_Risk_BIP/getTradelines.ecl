IMPORT BIPV2, Business_Risk_BIP, EBR, EBR_Services, MDR, Doxie, STD;

EXPORT getTradelines(DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// linkids := Business_Risk_BIP.Common.GetLinkIDs(Shell); // For debugging only.
	mod_access := PROJECT(Options, doxie.IDataAccess);

	temp_LayoutTradeline := RECORD
		UNSIGNED4 seq;
		STRING8 process_date;
		STRING10 FILE_NUMBER;
		Business_Risk_BIP.Layouts.LayoutTradeline;
		REAL8 TradeGoodStandingNewCount;
		REAL8 TradeGoodStandingAgedCount;
		REAL8 TradeGoodStandingCount;
		REAL8 TradeDPD01NewCount;
		REAL8 TradeDPD31NewCount;
		REAL8 TradeDPD61NewCount;
		REAL8 TradeDPD91NewCount;
		REAL8 TradeDPD01AgedCount;
		REAL8 TradeDPD31AgedCount;
		REAL8 TradeDPD61AgedCount;
		REAL8 TradeDPD91AgedCount;
		REAL8 TradeDPD01Count;
		REAL8 TradeDPD31Count;
		REAL8 TradeDPD61Count;
		REAL8 TradeDPD91Count;
		REAL8 TradeNEW1orMoreDPDCount;
		REAL8 TradeNEW31orMoreDPDCount;
		REAL8 TradeNEW61orMoreDPDCount;
		REAL8 TradeNEW91orMoreDPDCount;
		REAL8 TradeAged1orMoreDPDCount;
		REAL8 TradeAged31orMoreDPDCount;
		REAL8 TradeAged61orMoreDPDCount;
		REAL8 TradeAged91orMoreDPDCount;
		REAL8 Trade1orMoreDPDCount;
		REAL8 Trade31orMoreDPDCount;
		REAL8 Trade61orMoreDPDCount;
		REAL8 Trade91orMoreDPDCount;
	END;

	// --------------- EBR Data ----------------
	EBRRaw := EBR.Key_0010_Header_linkids.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell), mod_access,
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, // ScoreThreshold --> 0 = Give me everything
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	// Add back our Seq numbers.
	Business_Risk_BIP.Common.AppendSeq2(EBRRaw, Shell, EBRSeq);

	// Figure out if the kFetch was successful
	kFetchErrorCodes := Business_Risk_BIP.Common.GrabFetchErrorCode(EBRSeq);

	// Filter out records after our history date.
	EBR_recs := Business_Risk_BIP.Common.FilterRecords(EBRSeq, date_first_seen, process_date_first_seen,  MDR.SourceTools.src_EBR, AllowedSourcesSet);

	tempLayout := RECORD
		UNSIGNED4 Seq;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) Sources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSICNAIC) SICNAICSources;
	END;
	// Get all unique SIC Codes along with dates
	EBRSIC := TABLE(EBR_recs,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_EBR,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_first_seen, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_last_seen, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 STRING10 SICCode := STD.Str.Filter((STRING)SIC_Code, '0123456789')[1..4],
			 BOOLEAN IsPrimary := TRUE // There is only 1 SIC field on this source, mark it as primary
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID), SIC_Code
			 );

	EBRSICTemp := PROJECT(EBRSIC, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.SICNAICSources := DATASET([{LEFT.Source, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, LEFT.SICCode, Business_Risk_BIP.Common.industryGroup(LEFT.SICCode, Business_Risk_BIP.Constants.SIC), '' /*NAICCode*/, '' /*NAICIndustry*/, LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
																				SELF := []));

	EBRSICRolled := ROLLUP(EBRSICTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources; SELF := LEFT));

	withEBRSIC := JOIN(Shell, EBRSICRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	// Get EBR filing numbers from linkids.
	ebr_filing_numbers_plus_seq :=
		PROJECT( EBR_recs(file_number != ''), {UNSIGNED4 seq, EBR_Services.layout_file_number} );

	ebr_filing_numbers_plus_seq_ddpd := DEDUP(ebr_filing_numbers_plus_seq, ALL, HASH);

	// Join to several EBR data sources to obtain the required data. The following joins
	// are adapted from EBR_Services.ebr_raw, lines 129-137.

	// Header records. We need the process_date_last_seen field for the first join below.
	header_recs_pre :=
		JOIN(
			ebr_filing_numbers_plus_seq_ddpd, EBR.Key_0010_Header_FILE_NUMBER,
			KEYED( LEFT.file_number = RIGHT.file_number ),
			TRANSFORM( {UNSIGNED4 seq, EBR.layout_0010_header_base},
				SELF := RIGHT,
				SELF := LEFT
			),
			INNER,
			ATMOST(EBR_Services.constants.maxcounts.default)
		);

	// Mimicking what is done in other business queries, we will keep 1 file_number per sequence.  To do this we will keep the most recently processed record, following by most recently last seen, and then lastly the smallest file_number to make it determinate
	header_recs := GROUP(DEDUP(SORT(header_recs_pre, seq, -process_date_last_seen, -date_last_seen, file_number), Seq), seq);

	// Add Executives. (source: EBR-1000)
	executive_recs_added :=
		JOIN(
			header_recs, ebr.Key_1000_Executive_Summary_FILE_NUMBER,
			KEYED( LEFT.file_number = RIGHT.file_number ) AND
			LEFT.process_date_last_seen = (UNSIGNED)RIGHT.process_date,
			TRANSFORM( temp_LayoutTradeline,
				SELF.seq                        := LEFT.seq,
				SELF.process_date               := LEFT.process_date,
				SELF.FILE_NUMBER                := LEFT.file_number,
				SELF.TradeBalanceCurrent := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.current_account_balance, -1, 999999999),
				SELF.Trade06MonthHighBalance    := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.high_balance, -1, 999999999),  // lowest balance amount in last 6 months
				SELF.Trade06MonthLowBalance     := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.low_balance, -1, 999999999), // highest balance amount in last 6 months
				// Make sure that the HighExtendedCredit is at least as large as the MedianExtendedCredit.  Looks like there are a very small number of records in the data where this happens
				SELF.TradeHighBalanceExtendCredit    := (STRING)Business_Risk_BIP.Common.capNum(MAX((INTEGER)RIGHT.high_credit_extended, (INTEGER)RIGHT.median_credit_extended), -1, 999999999),
				SELF.TradeMedianBalanceExtendCredit  := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.median_credit_extended, -1, 999999999),
				SELF := []
			),
			LEFT OUTER, KEEP(1), // the 1000 file looks to be a 1-to-1 ratio to each corporate entity for a given process_date.
			ATMOST(EBR_Services.constants.maxcounts.default), FEW
		);

	// Add Trade Payment Records. (source: EBR-2015) NOTE: Among the fields listed in the Transform
	// below, the relationships among NEW, REG, and COMBO is REG + NEW = COMBO
	trade_payment_total_recs_added :=
		JOIN(
			executive_recs_added, ebr.Key_2015_Trade_Payment_Totals_FILE_NUMBER,
			KEYED( LEFT.file_number = RIGHT.file_number ) AND
			LEFT.process_date = RIGHT.process_date,
			TRANSFORM( temp_LayoutTradeline,
				TradeNewCount                 := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.trade_count2, -1, 999999);
				SELF.TradeNewCount            := TradeNewCount;
				TradeAgedCount                := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.trade_count1, -1, 999999);
				SELF.TradeAgedCount           := TradeAgedCount;
				TradeCount                    := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.trade_count3, -1, 999999);
				SELF.TradeCount               := TradeCount;
				SELF.TradeHighBalanceExtendCredit			 := (STRING)Business_Risk_BIP.Common.capNum(MAX((INTEGER)LEFT.TradeHighBalanceExtendCredit, (INTEGER)RIGHT.highest_credit_median), -1, 999999999);
				SELF.TradeMedianHighExtendedCredit := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.highest_credit_median, -1, 999999999);
				SELF.TradeHighBalanceNew    := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.recent_high_credit2, -1, 999999999);
				SELF.TradeHighBalanceAged    := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.recent_high_credit1, -1, 999999999);
				SELF.TradeHighBalance  := (STRING)Business_Risk_BIP.Common.capNum(MAX((INTEGER)RIGHT.recent_high_credit2, (INTEGER)RIGHT.recent_high_credit1), -1, 999999999);
				SELF.TradeBalanceActive       := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.masked_account_balance3, -1, 999999999);
				// The way Experian calculates the percent good standing is based off of the total account balance in dollars.  However this means that if there is no more balance on the account that
				// the percent of the account in good standing drops to 0 - when in reality it should be at 100% good balance as they owe nothing and thus are not past due on anything.  We will override
				// these 0's to 100%'s when all Percent Days Past Due fields are 0's.
				overrideNewGoodStanding		:= IF((INTEGER)RIGHT.masked_account_balance2 <= 0 AND (INTEGER)RIGHT.trade_count2 > 0 AND (REAL)RIGHT.debt_01_30_percent2 <= 0 AND (REAL)RIGHT.debt_31_60_percent2 <= 0 AND (REAL)RIGHT.debt_61_90_percent2 <= 0 AND (REAL)RIGHT.debt_91_plus_percent2 <= 0, TRUE, FALSE);
				overrideRegGoodStanding		:= IF((INTEGER)RIGHT.masked_account_balance1 <= 0 AND (INTEGER)RIGHT.trade_count1 > 0 AND (REAL)RIGHT.debt_01_30_percent1 <= 0 AND (REAL)RIGHT.debt_31_60_percent1 <= 0 AND (REAL)RIGHT.debt_61_90_percent1 <= 0 AND (REAL)RIGHT.debt_91_plus_percent1 <= 0, TRUE, FALSE);
				overrideComboGoodStanding	:= IF((INTEGER)RIGHT.masked_account_balance3 <= 0 AND (INTEGER)RIGHT.trade_count3 > 0 AND (REAL)RIGHT.debt_01_30_percent3 <= 0 AND (REAL)RIGHT.debt_31_60_percent3 <= 0 AND (REAL)RIGHT.debt_61_90_percent3 <= 0 AND (REAL)RIGHT.debt_91_plus_percent3 <= 0, TRUE, FALSE);
				TradeGoodStandingNewPercent   := (STRING)Business_Risk_BIP.Common.capNum(IF(overrideNewGoodStanding, 100.0, (REAL)RIGHT.current_balance_percent2), -1.0, 100.0);
				SELF.TradeGoodStandingNewPercent := TradeGoodStandingNewPercent;
				SELF.TradeGoodStandingNewCount := ((INTEGER)TradeGoodStandingNewPercent / 100) * (INTEGER)TradeNewCount;
				TradeGoodStandingAgedPercent   := (STRING)Business_Risk_BIP.Common.capNum(IF(overrideRegGoodStanding, 100.0, (REAL)RIGHT.current_balance_percent1), -1.0, 100.0);
				SELF.TradeGoodStandingAgedPercent   := TradeGoodStandingAgedPercent;
				SELF.TradeGoodStandingAgedCount   := ((INTEGER)TradeGoodStandingAgedPercent / 100) * (INTEGER)TradeAgedCount;
				TradeGoodStandingPercent := (STRING)Business_Risk_BIP.Common.capNum(IF(overrideComboGoodStanding, 100.0, (REAL)RIGHT.current_balance_percent3), -1.0, 100.0);
				SELF.TradeGoodStandingPercent := TradeGoodStandingPercent;
				SELF.TradeGoodStandingCount := ((INTEGER)TradeGoodStandingPercent / 100) * (INTEGER)TradeCount;
				TradeDPD01NewPercent       	:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_01_30_percent2), -1.0, 100.0);
				SELF.TradeDPD01NewPercent   := TradeDPD01NewPercent;
				SELF.TradeDPD01NewCount   	:= ((INTEGER)TradeDPD01NewPercent / 100) * (INTEGER)TradeNewCount;
				TradeDPD31NewPercent      	:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_31_60_percent2), -1.0, 100.0);
				SELF.TradeDPD31NewPercent   := TradeDPD31NewPercent;
				SELF.TradeDPD31NewCount		  := ((INTEGER)TradeDPD31NewPercent / 100) * (INTEGER)TradeNewCount;
				TradeDPD61NewPercent      	:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_61_90_percent2), -1.0, 100.0);
				SELF.TradeDPD61NewPercent   := TradeDPD61NewPercent;
				SELF.TradeDPD61NewCount   	:= ((INTEGER)TradeDPD61NewPercent / 100) * (INTEGER)TradeNewCount;
				TradeDPD91NewPercent    		:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_91_plus_percent2), -1.0, 100.0);
				SELF.TradeDPD91NewPercent   := TradeDPD91NewPercent;
				SELF.TradeDPD91NewCount   	:= ((INTEGER)TradeDPD91NewPercent / 100) * (INTEGER)TradeNewCount;
				TradeDPD01AgedPercent       := (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_01_30_percent1), -1.0, 100.0);
				SELF.TradeDPD01AgedPercent  := TradeDPD01AgedPercent;
				SELF.TradeDPD01AgedCount   	:= ((INTEGER)TradeDPD01AgedPercent / 100) * (INTEGER)TradeAgedCount;
				TradeDPD31AgedPercent      	:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_31_60_percent1), -1.0, 100.0);
				SELF.TradeDPD31AgedPercent  := TradeDPD31AgedPercent;
				SELF.TradeDPD31AgedCount   	:= ((INTEGER)TradeDPD31AgedPercent / 100) * (INTEGER)TradeAgedCount;
				TradeDPD61AgedPercent      	:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_61_90_percent1), -1.0, 100.0);
				SELF.TradeDPD61AgedPercent  := TradeDPD61AgedPercent;
				SELF.TradeDPD61AgedCount   	:= ((INTEGER)TradeDPD61AgedPercent / 100) * (INTEGER)TradeAgedCount;
				TradeDPD91AgedPercent    		:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_91_plus_percent1), -1.0, 100.0);
				SELF.TradeDPD91AgedPercent  := TradeDPD91AgedPercent;
				SELF.TradeDPD91AgedCount   	:= ((INTEGER)TradeDPD91AgedPercent / 100) * (INTEGER)TradeAgedCount;
				TradeDPD01Percent     			:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_01_30_percent3), -1.0, 100.0);
				SELF.TradeDPD01Percent     	:= TradeDPD01Percent;
				SELF.TradeDPD01Count   			:= ((INTEGER)TradeDPD01Percent / 100) * (INTEGER)TradeCount;
				TradeDPD31Percent    				:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_31_60_percent3), -1.0, 100.0);
				SELF.TradeDPD31Percent    	:= TradeDPD31Percent;
				SELF.TradeDPD31Count   			:= ((INTEGER)TradeDPD31Percent / 100) * (INTEGER)TradeCount;
				TradeDPD61Percent    				:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_61_90_percent3), -1.0, 100.0);
				SELF.TradeDPD61Percent    	:= TradeDPD61Percent;
				SELF.TradeDPD61Count   			:= ((INTEGER)TradeDPD61Percent / 100) * (INTEGER)TradeCount;
				TradeDPD91Percent  					:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_91_plus_percent3), -1.0, 100.0);
				SELF.TradeDPD91Percent  		:= TradeDPD91Percent;
				SELF.TradeDPD91Count   			:= ((INTEGER)TradeDPD91Percent / 100) * (INTEGER)TradeCount;
				TradeNEW1orMoreDPD					:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_91_plus_percent2 + (REAL)RIGHT.debt_61_90_percent2 + (REAL)RIGHT.debt_31_60_percent2 + (REAL)RIGHT.debt_01_30_percent2), -1.0, 100.0);
				SELF.TradeNEW1orMoreDPD			:= TradeNEW1orMoreDPD;
				SELF.TradeNEW1orMoreDPDCount:= ((INTEGER)TradeNEW1orMoreDPD / 100) * (INTEGER)TradeNewCount;
				TradeNEW31orMoreDPD					:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_91_plus_percent2 + (REAL)RIGHT.debt_61_90_percent2 + (REAL)RIGHT.debt_31_60_percent2), -1.0, 100.0);
				SELF.TradeNEW31orMoreDPD		:= TradeNEW31orMoreDPD;
				SELF.TradeNEW31orMoreDPDCount:= ((INTEGER)TradeNEW31orMoreDPD / 100) * (INTEGER)TradeNewCount;
				TradeNEW61orMoreDPD					:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_91_plus_percent2 + (REAL)RIGHT.debt_61_90_percent2), -1.0, 100.0);
				SELF.TradeNEW61orMoreDPD		:= TradeNEW61orMoreDPD;
				SELF.TradeNEW61orMoreDPDCount:= ((INTEGER)TradeNEW61orMoreDPD / 100) * (INTEGER)TradeNewCount;
				TradeNEW91orMoreDPD					:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_91_plus_percent2), -1.0, 100.0);
				SELF.TradeNEW91orMoreDPD		:= TradeNEW91orMoreDPD;
				SELF.TradeNEW91orMoreDPDCount:= ((INTEGER)TradeNEW91orMoreDPD / 100) * (INTEGER)TradeNewCount;
				TradeAged1orMoreDPD					:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_91_plus_percent1 + (REAL)RIGHT.debt_61_90_percent1 + (REAL)RIGHT.debt_31_60_percent1 + (REAL)RIGHT.debt_01_30_percent1), -1.0, 100.0);
				SELF.TradeAged1orMoreDPD		:= TradeAged1orMoreDPD;
				SELF.TradeAged1orMoreDPDCount:= ((INTEGER)TradeAged1orMoreDPD / 100) * (INTEGER)TradeAgedCount;
				TradeAged31orMoreDPD				:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_91_plus_percent1 + (REAL)RIGHT.debt_61_90_percent1 + (REAL)RIGHT.debt_31_60_percent1), -1.0, 100.0);
				SELF.TradeAged31orMoreDPD		:= TradeAged31orMoreDPD;
				SELF.TradeAged31orMoreDPDCount:= ((INTEGER)TradeAged31orMoreDPD / 100) * (INTEGER)TradeAgedCount;
				TradeAged61orMoreDPD				:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_91_plus_percent1 + (REAL)RIGHT.debt_61_90_percent1), -1.0, 100.0);
				SELF.TradeAged61orMoreDPD		:= TradeAged61orMoreDPD;
				SELF.TradeAged61orMoreDPDCount:= ((INTEGER)TradeAged61orMoreDPD / 100) * (INTEGER)TradeAgedCount;
				TradeAged91orMoreDPD				:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_91_plus_percent1), -1.0, 100.0);
				SELF.TradeAged91orMoreDPD		:= TradeAged91orMoreDPD;
				SELF.TradeAged91orMoreDPDCount:= ((INTEGER)TradeAged91orMoreDPD / 100) * (INTEGER)TradeAgedCount;
				Trade1orMoreDPD							:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_91_plus_percent3 + (REAL)RIGHT.debt_61_90_percent3 + (REAL)RIGHT.debt_31_60_percent3 + (REAL)RIGHT.debt_01_30_percent3), -1.0, 100.0);
				SELF.Trade1orMoreDPD				:= Trade1orMoreDPD;
				SELF.Trade1orMoreDPDCount		:= ((INTEGER)Trade1orMoreDPD / 100) * (INTEGER)TradeCount;
				Trade31orMoreDPD						:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_91_plus_percent3 + (REAL)RIGHT.debt_61_90_percent3 + (REAL)RIGHT.debt_31_60_percent3), -1.0, 100.0);
				SELF.Trade31orMoreDPD				:= Trade31orMoreDPD;
				SELF.Trade31orMoreDPDCount	:= ((INTEGER)Trade31orMoreDPD / 100) * (INTEGER)TradeCount;
				Trade61orMoreDPD						:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_91_plus_percent3 + (REAL)RIGHT.debt_61_90_percent3), -1.0, 100.0);
				SELF.Trade61orMoreDPD				:= Trade61orMoreDPD;
				SELF.Trade61orMoreDPDCount	:= ((INTEGER)Trade61orMoreDPD / 100) * (INTEGER)TradeCount;
				Trade91orMoreDPD						:= (STRING)Business_Risk_BIP.Common.capNum(ROUND((REAL)RIGHT.debt_91_plus_percent3), -1.0, 100.0);
				SELF.Trade91orMoreDPD				:= Trade91orMoreDPD;
				SELF.Trade91orMoreDPDCount	:= ((INTEGER)Trade91orMoreDPD / 100) * (INTEGER)TradeCount;


				NewestTradeDPD										 := Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.debt2, 0, 999);
				SELF.TradeHighestDPDNew					 := MAP(NewestTradeDPD = 0								=> '0',
																									NewestTradeDPD BETWEEN 1 AND 30		=> '1',
																									NewestTradeDPD BETWEEN 31 AND 60	=> '2',
																									NewestTradeDPD BETWEEN 61 AND 90	=> '3',
																									NewestTradeDPD >= 91							=> '4',
																																											 '-1');
				AgedTradeDPD											 := Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.debt1, 0, 999);
				SELF.TradeHighestDPDAged					 := MAP(AgedTradeDPD = 0								=> '0',
																									AgedTradeDPD BETWEEN 1 AND 30		=> '1',
																									AgedTradeDPD BETWEEN 31 AND 60	=> '2',
																									AgedTradeDPD BETWEEN 61 AND 90	=> '3',
																									AgedTradeDPD >= 91							=> '4',
																																											 '-1');
				TradeHighestDPD										 := Business_Risk_BIP.Common.capNum(MAX((INTEGER)RIGHT.debt1, (INTEGER)RIGHT.debt2), 0, 999);
				SELF.TradeHighestDPD					     := MAP(TradeHighestDPD = 0								=> '0',
																									TradeHighestDPD BETWEEN 1 AND 30	=> '1',
																									TradeHighestDPD BETWEEN 31 AND 60	=> '2',
																									TradeHighestDPD BETWEEN 61 AND 90	=> '3',
																									TradeHighestDPD >= 91							=> '4',
																																											 '-1');

				SELF := LEFT;
				SELF := []
			),
			LEFT OUTER, KEEP(1), // the 2015 file looks to be a 1-to-1 ratio to each corporate entity for each process date.
			ATMOST(EBR_Services.constants.maxcounts.default), FEW
		);

	temp_LayoutTradeline rollTradelines(temp_LayoutTradeline le, temp_LayoutTradeline ri) := TRANSFORM
		TradeCount := Business_Risk_BIP.Common.capNum((INTEGER)le.TradeCount + (INTEGER)ri.TradeCount, -1, 999999);
		TradeNewCount := Business_Risk_BIP.Common.capNum((INTEGER)le.TradeNewCount + (INTEGER)ri.TradeNewCount, -1, 999999);
		TradeAgedCount := Business_Risk_BIP.Common.capNum((INTEGER)le.TradeAgedCount + (INTEGER)ri.TradeAgedCount, -1, 999999);
		SELF.TradeCount := (STRING)TradeCount;
		SELF.TradeNewCount := (STRING)TradeNewCount;
		SELF.TradeAgedCount := (STRING)TradeAgedCount;
		SELF.TradeBalanceCurrent := (STRING)Business_Risk_BIP.Common.capNum(((INTEGER)le.TradeBalanceCurrent + (INTEGER)ri.TradeBalanceCurrent), -1, 999999999);
		SELF.TradeBalanceActive := (STRING)Business_Risk_BIP.Common.capNum(((INTEGER)le.TradeBalanceActive + (INTEGER)ri.TradeBalanceActive), -1, 999999999);
		SELF.TradeHighBalanceExtendCredit := (STRING)Business_Risk_BIP.Common.capNum(MAX((INTEGER)le.TradeHighBalanceExtendCredit, (INTEGER)ri.TradeHighBalanceExtendCredit), -1, 999999999);
		SELF.TradeMedianBalanceExtendCredit := (STRING)Business_Risk_BIP.Common.capNum(MAX((INTEGER)le.TradeMedianBalanceExtendCredit, (INTEGER)ri.TradeMedianBalanceExtendCredit), -1, 999999999);
		SELF.TradeHighBalanceNew := (STRING)Business_Risk_BIP.Common.capNum(MAX((INTEGER)le.TradeHighBalanceNew, (INTEGER)ri.TradeHighBalanceNew), -1, 999999999);
		SELF.TradeHighBalanceAged := (STRING)Business_Risk_BIP.Common.capNum(MAX((INTEGER)le.TradeHighBalanceAged, (INTEGER)ri.TradeHighBalanceAged), -1, 999999999);
		SELF.TradeHighBalance := (STRING)Business_Risk_BIP.Common.capNum(MAX((INTEGER)le.TradeHighBalance, (INTEGER)ri.TradeHighBalance), -1, 999999999);
		SELF.TradeHighestDPDNew := (STRING)Business_Risk_BIP.Common.capNum(MAX((INTEGER)le.TradeHighestDPDNew, (INTEGER)ri.TradeHighestDPDNew), -1, 4);
		SELF.TradeHighestDPDAged := (STRING)Business_Risk_BIP.Common.capNum(MAX((INTEGER)le.TradeHighestDPDAged, (INTEGER)ri.TradeHighestDPDAged), -1, 4);
		SELF.TradeHighestDPD := (STRING)Business_Risk_BIP.Common.capNum(MAX((INTEGER)le.TradeHighestDPD, (INTEGER)ri.TradeHighestDPD), -1, 4);
		SELF.Trade06MonthHighBalance := (STRING)Business_Risk_BIP.Common.capNum(MAX((INTEGER)le.Trade06MonthHighBalance, (INTEGER)ri.Trade06MonthHighBalance), -1, 999999999);
		SELF.Trade06MonthLowBalance := (STRING)Business_Risk_BIP.Common.capNum(MIN((INTEGER)le.Trade06MonthLowBalance, (INTEGER)ri.Trade06MonthLowBalance), -1, 999999999);
		SELF.TradeMedianHighExtendedCredit := (STRING)Business_Risk_BIP.Common.capNum(MAX((INTEGER)le.TradeMedianHighExtendedCredit, (INTEGER)ri.TradeMedianHighExtendedCredit), -1, 999999999);

		SELF.TradeGoodStandingNewCount := le.TradeGoodStandingNewCount + ri.TradeGoodStandingNewCount;
		SELF.TradeGoodStandingAgedCount := le.TradeGoodStandingAgedCount + ri.TradeGoodStandingAgedCount;
		SELF.TradeGoodStandingCount := le.TradeGoodStandingCount + ri.TradeGoodStandingCount;
		SELF.TradeDPD01NewCount := le.TradeDPD01NewCount + ri.TradeDPD01NewCount;
		SELF.TradeDPD31NewCount := le.TradeDPD31NewCount + ri.TradeDPD31NewCount;
		SELF.TradeDPD61NewCount := le.TradeDPD61NewCount + ri.TradeDPD61NewCount;
		SELF.TradeDPD91NewCount := le.TradeDPD91NewCount + ri.TradeDPD91NewCount;
		SELF.TradeDPD01AgedCount := le.TradeDPD01AgedCount + ri.TradeDPD01AgedCount;
		SELF.TradeDPD31AgedCount := le.TradeDPD31AgedCount + ri.TradeDPD31AgedCount;
		SELF.TradeDPD61AgedCount := le.TradeDPD61AgedCount + ri.TradeDPD61AgedCount;
		SELF.TradeDPD91AgedCount := le.TradeDPD91AgedCount + ri.TradeDPD91AgedCount;
		SELF.TradeDPD01Count := le.TradeDPD01Count + ri.TradeDPD01Count;
		SELF.TradeDPD31Count := le.TradeDPD31Count + ri.TradeDPD31Count;
		SELF.TradeDPD61Count := le.TradeDPD61Count + ri.TradeDPD61Count;
		SELF.TradeDPD91Count := le.TradeDPD91Count + ri.TradeDPD91Count;
		SELF.TradeNEW1orMoreDPDCount := le.TradeNEW1orMoreDPDCount + ri.TradeNEW1orMoreDPDCount;
		SELF.TradeNEW31orMoreDPDCount := le.TradeNEW31orMoreDPDCount + ri.TradeNEW31orMoreDPDCount;
		SELF.TradeNEW61orMoreDPDCount := le.TradeNEW61orMoreDPDCount + ri.TradeNEW61orMoreDPDCount;
		SELF.TradeNEW91orMoreDPDCount := le.TradeNEW91orMoreDPDCount + ri.TradeNEW91orMoreDPDCount;
		SELF.TradeAged1orMoreDPDCount := le.TradeAged1orMoreDPDCount + ri.TradeAged1orMoreDPDCount;
		SELF.TradeAged31orMoreDPDCount := le.TradeAged31orMoreDPDCount + ri.TradeAged31orMoreDPDCount;
		SELF.TradeAged61orMoreDPDCount := le.TradeAged61orMoreDPDCount + ri.TradeAged61orMoreDPDCount;
		SELF.TradeAged91orMoreDPDCount := le.TradeAged91orMoreDPDCount + ri.TradeAged91orMoreDPDCount;
		SELF.Trade1orMoreDPDCount := le.Trade1orMoreDPDCount + ri.Trade1orMoreDPDCount;
		SELF.Trade31orMoreDPDCount := le.Trade31orMoreDPDCount + ri.Trade31orMoreDPDCount;
		SELF.Trade61orMoreDPDCount := le.Trade61orMoreDPDCount + ri.Trade61orMoreDPDCount;
		SELF.Trade91orMoreDPDCount := le.Trade91orMoreDPDCount + ri.Trade91orMoreDPDCount;

		SELF := le;
		SELF := [];
	END;

	trade_payment_total_recs_rolled := ROLLUP(SORT(trade_payment_total_recs_added, Seq, File_Number, -Process_Date), LEFT.Seq = RIGHT.Seq, rollTradelines(LEFT, RIGHT));

	temp_LayoutTradeline calculateTradelinePercentages(temp_LayoutTradeline le) := TRANSFORM
		SELF.TradeGoodStandingNewPercent := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeGoodStandingNewCount / (REAL8)le.TradeNewCount) * 100), -1, 100);
		SELF.TradeGoodStandingAgedPercent := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeGoodStandingAgedCount / (REAL8)le.TradeAgedCount) * 100), -1, 100);
		SELF.TradeGoodStandingPercent := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeGoodStandingCount / (REAL8)le.TradeCount) * 100), -1, 100);
		SELF.TradeDPD01NewPercent := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeDPD01NewCount / (REAL8)le.TradeNewCount) * 100), -1, 100);
		SELF.TradeDPD31NewPercent := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeDPD31NewCount / (REAL8)le.TradeNewCount) * 100), -1, 100);
		SELF.TradeDPD61NewPercent := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeDPD61NewCount / (REAL8)le.TradeNewCount) * 100), -1, 100);
		SELF.TradeDPD91NewPercent := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeDPD91NewCount / (REAL8)le.TradeNewCount) * 100), -1, 100);
		SELF.TradeDPD01AgedPercent := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeDPD01AgedCount / (REAL8)le.TradeAgedCount) * 100), -1, 100);
		SELF.TradeDPD31AgedPercent := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeDPD31AgedCount / (REAL8)le.TradeAgedCount) * 100), -1, 100);
		SELF.TradeDPD61AgedPercent := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeDPD61AgedCount / (REAL8)le.TradeAgedCount) * 100), -1, 100);
		SELF.TradeDPD91AgedPercent := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeDPD91AgedCount / (REAL8)le.TradeAgedCount) * 100), -1, 100);
		SELF.TradeDPD01Percent := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeDPD01Count / (REAL8)le.TradeCount) * 100), -1, 100);
		SELF.TradeDPD31Percent := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeDPD31Count / (REAL8)le.TradeCount) * 100), -1, 100);
		SELF.TradeDPD61Percent := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeDPD61Count / (REAL8)le.TradeCount) * 100), -1, 100);
		SELF.TradeDPD91Percent := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeDPD91Count / (REAL8)le.TradeCount) * 100), -1, 100);
		SELF.TradeNEW1orMoreDPD := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeNEW1orMoreDPDCount / (REAL8)le.TradeNewCount) * 100), -1, 100);
		SELF.TradeNEW31orMoreDPD := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeNEW31orMoreDPDCount / (REAL8)le.TradeNewCount) * 100), -1, 100);
		SELF.TradeNEW61orMoreDPD := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeNEW61orMoreDPDCount / (REAL8)le.TradeNewCount) * 100), -1, 100);
		SELF.TradeNEW91orMoreDPD := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeNEW91orMoreDPDCount / (REAL8)le.TradeNewCount) * 100), -1, 100);
		SELF.TradeAged1orMoreDPD := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeAged1orMoreDPDCount / (REAL8)le.TradeAgedCount) * 100), -1, 100);
		SELF.TradeAged31orMoreDPD := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeAged31orMoreDPDCount / (REAL8)le.TradeAgedCount) * 100), -1, 100);
		SELF.TradeAged61orMoreDPD := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeAged61orMoreDPDCount / (REAL8)le.TradeAgedCount) * 100), -1, 100);
		SELF.TradeAged91orMoreDPD := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.TradeAged91orMoreDPDCount / (REAL8)le.TradeAgedCount) * 100), -1, 100);
		SELF.Trade1orMoreDPD := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.Trade1orMoreDPDCount / (REAL8)le.TradeCount) * 100), -1, 100);
		SELF.Trade31orMoreDPD := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.Trade31orMoreDPDCount / (REAL8)le.TradeCount) * 100), -1, 100);
		SELF.Trade61orMoreDPD := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.Trade61orMoreDPDCount / (REAL8)le.TradeCount) * 100), -1, 100);
		SELF.Trade91orMoreDPD := (STRING)Business_Risk_BIP.Common.CapNum(ROUND((le.Trade91orMoreDPDCount / (REAL8)le.TradeCount) * 100), -1, 100);

		SELF := le;
		SELF := [];
	END;
	trade_payment_total_recs_calculated := PROJECT(trade_payment_total_recs_rolled, calculateTradelinePercentages(LEFT));

	// Add to the Shell.
	withTradelines :=
		JOIN(
			withEBRSIC, trade_payment_total_recs_calculated,
			LEFT.Seq = RIGHT.Seq,
			TRANSFORM( Business_Risk_BIP.Layouts.Shell,
				SELF.Tradeline := RIGHT,
				SELF.Tradeline := [],
				SELF := LEFT
			),
			LEFT OUTER, KEEP(1), ATMOST(100), FEW
		);

	withErrorCodes := JOIN(withTradelines, kFetchErrorCodes, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeTradelines := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT( linkids, NAMED('linkids'), ALL );
	// OUTPUT( CHOOSEN(EBRRaw, 100), NAMED('Sample_EBRRaw') );
	// OUTPUT( CHOOSEN(EBR_recs, 100), NAMED('Sample_EBR_recs') );
	// OUTPUT( ebr_filing_numbers_plus_seq_ddpd, NAMED('ebr_filing_numbers_ddpd') );
	// OUTPUT( header_recs, NAMED('header_recs') );
	// OUTPUT( executive_recs_added, NAMED('EBR_1000_added') );
	// OUTPUT( trade_payment_total_recs_added, NAMED('EBR_2015_added') );
	// OUTPUT( trade_payment_total_recs_rolled, NAMED('EBR_2015_rolled') );
	// OUTPUT( trade_payment_total_recs_calculated, NAMED('EBR_2015_calculated') );

	RETURN withErrorCodes;

END;
