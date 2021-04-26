IMPORT BIPV2, Business_Risk_BIP, Cortera, doxie, dx_Cortera, MDR, Risk_Indicators, STD, UT;

EXPORT getCortera(DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
                          Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
                          BIPV2.mod_sources.iParams linkingOptions,
                          SET OF STRING2 AllowedSourcesSet,
                          DATASET(Cortera.layout_Retrotest_raw) ds_CorteraRetrotestRecsRaw = DATASET([],Cortera.layout_Retrotest_raw)) := FUNCTION

	mod_access := PROJECT(Options, doxie.IDataAccess);

	link_search_level := Options.LinkSearchLevel;

	Allow_Cortera := Options.DataRestrictionMask[42] IN ['0', ''];

	TempLayoutCortera := RECORD
		UNSIGNED seq;
		INTEGER4 Ultimate_LinkID;
		Business_Risk_BIP.Layouts.LayoutB2B;
		//STRING8 Cortera_Build_Date;
		STRING2 SourceIndex;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		BOOLEAN AIR_SPEND;
		BOOLEAN FUEL_SPEND;
		BOOLEAN LEASING_SPEND;
		BOOLEAN LTL_SPEND;
		BOOLEAN RAIL_SPEND;
		BOOLEAN TL_SPEND;
		BOOLEAN TRANSVC_SPEND;
		BOOLEAN TRANSUP_SPEND;
		BOOLEAN BST_SPEND;
		BOOLEAN DG_SPEND;
		BOOLEAN ELECTRICAL_SPEND;
		BOOLEAN HVAC_SPEND;
		BOOLEAN OTHER_B_SPEND;
		BOOLEAN PLUMBING_SPEND;
		BOOLEAN RS_SPEND;
		BOOLEAN WP_SPEND;
		BOOLEAN CHEMICAL_SPEND;
		BOOLEAN ELECTRONIC_SPEND;
		BOOLEAN METAL_SPEND;
		BOOLEAN OTHER_M_SPEND;
		BOOLEAN PACKAGING_SPEND;
		BOOLEAN PVF_SPEND;
		BOOLEAN PLASTIC_SPEND;
		BOOLEAN TEXTILE_SPEND;
		BOOLEAN BS_SPEND;
		BOOLEAN CE_SPEND;
		BOOLEAN HARDWARE_SPEND;
		BOOLEAN IE_SPEND;
		BOOLEAN IS_SPEND;
		BOOLEAN IT_SPEND;
		BOOLEAN MLS_SPEND;
		BOOLEAN OS_SPEND;
		BOOLEAN PP_SPEND;
		BOOLEAN SIS_SPEND;
		BOOLEAN APPAREL_SPEND;
		BOOLEAN BEVERAGES_SPEND;
		BOOLEAN CONSTR_SPEND;
		BOOLEAN CONSULTING_SPEND;
		BOOLEAN FS_SPEND;
		BOOLEAN FP_SPEND;
		BOOLEAN INSURANCE_SPEND;
		BOOLEAN LS_SPEND;
		BOOLEAN OIL_GAS_SPEND;
		BOOLEAN UTILITIES_SPEND;
		BOOLEAN OTHER_SPEND;
		BOOLEAN ADVT_SPEND;
	END;

	// ---------------[ Cortera Retrotest Data ]----------------
	CorteraRetrotestRecs := PROJECT( ds_CorteraRetrotestRecsRaw((INTEGER)Ultimate_Linkid > 0), Business_Risk_BIP.xfm_convertRawCorteraData(LEFT) );

 	// If Cortera retrotester results are passed into Business_Risk_BIP.getCortera, then we will use this data instead of searching the Cortera keys
	UseRetroTest := Options.CorteraRetrotest = TRUE;

	// ---------------[ Cortera Data ]----------------
	CorteraBuildDate := Risk_Indicators.get_Build_date('cortera_build_version');

	CorteraRaw := dx_Cortera.Key_LinkIds.kfetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
                                            Business_Risk_BIP.Common.SetLinkSearchLevel(link_search_level),
                                            0, // ScoreThreshold --> 0 = Give me everything
                                            Business_Risk_BIP.Constants.Limit_Default,
                                            Options.KeepLargeBusinesses,
                                            mod_access,
                                            /* append_contact */ TRUE
                                           );

	// Add back our Seq numbers.
	Business_Risk_BIP.Common.AppendSeq2(CorteraRaw, Shell, CorteraSeq);

	// Figure out if the kFetch was successful
	kFetchErrorCodes := Business_Risk_BIP.Common.GrabFetchErrorCode(CorteraSeq);

  // First, filter off records after our historydate. We will use this data to determine how long a business has been on Cortera header
  AllCorteraRecords := Business_Risk_BIP.Common.FilterRecords(CorteraSeq, dt_vendor_first_reported, 0, MDR.SourceTools.src_Cortera, AllowedSourcesSet);

  CorteraHeaderFirstSeen := TABLE(AllCorteraRecords,
			{Seq,
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_vendor_first_reported, HistoryDate),
			 UNSIGNED3 HistoryDate := HistoryDate,
			 UNSIGNED4 RecordCount := COUNT(GROUP)
			 },
			 Seq, FEW
			 );

  // Calculate months since business was first seen on Cortera by LN. Farther down, we will set B2B.HeaderTimeOldest to -1 if the business was not seen in the most recent Cortera update.
  withCorteraHeaderFirstSeen := JOIN(Shell, CorteraHeaderFirstSeen, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                                              TodaysDate := Business_Risk_BIP.Common.todaysDate(CorteraBuildDate, RIGHT.HistoryDate);
																							SELF.B2B.HeaderTimeOldest := (STRING)IF((INTEGER)RIGHT.DateVendorFirstSeen > 0,
                                              Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart((STRING)RIGHT.DateVendorFirstSeen, (STRING)TodaysDate), 1, 99999), -1);

                                              SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	// Now, filter out records that aren't from the most recent build as of the historydate, since we only want to look at the most recent Cortera records when calculating the attriubtes.
	CorteraRecs := Business_Risk_BIP.Common.FilterCorteraRecords(AllCorteraRecords, dt_first_seen, dt_vendor_first_reported, dt_vendor_last_reported, Current, MDR.SourceTools.src_Cortera, AllowedSourcesSet);

	CorteraRecs_DD := DEDUP(SORT(CorteraRecs, Seq, ultimate_linkid), Seq, ultimate_linkid);

	CorteraAttributes_InHouse_Raw_pre := JOIN(CorteraRecs_DD, dx_Cortera.Key_Attributes_Link_Id,
    KEYED( LEFT.ultimate_linkid = RIGHT.ultimate_linkid) AND LEFT.Ultid=RIGHT.UltID AND LEFT.OrgID=RIGHT.OrgID AND LEFT.SeleID=RIGHT.SeleID ,
					TRANSFORM({RECORDOF(RIGHT), UNSIGNED4 Seq, UNSIGNED6 HistoryDate},
											SELF.Seq := LEFT.Seq;
											SELF.HistoryDate := LEFT.HistoryDate;
											SELF := RIGHT),
					ATMOST(Business_Risk_BIP.Constants.Limit_Default));
  
  dx_Cortera.mac_incremental_rollup(CorteraAttributes_InHouse_Raw_pre, CorteraAttributes_InHouse_Raw, current_rec);

  // First, filter off records after our historydate. We will use this data to determine how long a business has been on Cortera attributes
  CorteraAttributes_InHouse_All := Business_Risk_BIP.Common.FilterRecords(CorteraAttributes_InHouse_Raw, dt_vendor_first_reported, 0, MDR.SourceTools.src_Cortera, AllowedSourcesSet);

  CorteraAttributesFirstSeen := TABLE(CorteraAttributes_InHouse_All,
			{Seq,
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_vendor_first_reported, HistoryDate),
			 UNSIGNED3 HistoryDate := HistoryDate,
			 UNSIGNED4 RecordCount := COUNT(GROUP)
			 },
			 Seq, FEW
			 );

  // Calculate months since business was first seen on Cortera by LN. Farther down, we will set B2B.HeaderTimeOldest to -1 if the business was not seen in the most recent Cortera update.
  withCorteraAttributesFirstSeen := IF(UseRetroTest, withCorteraHeaderFirstSeen,
                                  JOIN(withCorteraHeaderFirstSeen, CorteraAttributesFirstSeen, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                                              TodaysDate := Business_Risk_BIP.Common.todaysDate(CorteraBuildDate, RIGHT.HistoryDate);
																							SELF.B2B.AttributesTimeOldest := (STRING)IF((INTEGER)RIGHT.DateVendorFirstSeen > 0,
                                              Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart((STRING)RIGHT.DateVendorFirstSeen, (STRING)TodaysDate), 1, 99999), -1);

                                              SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW));

	// Now filter down to Cortera Attribute Records that are either marked current or have been seen in the last build (within a week of the history date)
	CorteraAttributes_InHouse_Filtered := Business_Risk_BIP.Common.FilterCorteraRecords(CorteraAttributes_InHouse_All, dt_first_seen, dt_vendor_first_reported, dt_vendor_last_reported, Current_Rec, MDR.SourceTools.src_Cortera, AllowedSourcesSet);

	CorteraAttributes_InHouse := PROJECT(CorteraAttributes_InHouse_Filtered,
    TRANSFORM( TempLayoutCortera,
				SELF.seq := LEFT.seq;
				SELF.Ultimate_LinkID := LEFT.Ultimate_LinkID;
				SELF.VendorScoreFutureDelinquencyMax := LEFT.Cortera_Score;
				SELF.VendorScoreFutureDelinquencyMin := LEFT.Cortera_Score;
				SELF.VendorScorePaymentBehaviorMax := LEFT.CPR_Score;
				SELF.VendorScorePaymentBehaviorMin := LEFT.CPR_Score;
				SELF.AvgProviderCount12Mos := (STRING)ROUND((REAL)LEFT.Total_NumRel_Avg12, 2);
				SELF.ProviderTrajectory12Mos := Business_Risk_BIP.Common.getCorteraTrajectory(LEFT.total_numrel_avg12, LEFT.total_numrel_slope_0t12);
				SELF.ProviderTrajectory24Mos := Business_Risk_BIP.Common.getCorteraTrajectory(LEFT.total_numrel_avg12, LEFT.total_numrel_slope_0t24, LEFT.total_numrel_monthspastleast_24, LEFT.total_numrel_monthpspastmost_24); // changed from sample code
        // There is a bug in the data we recieve from Cortera where we need to subtract 12 from total_spend_sum_12 to reflect the true value.
        Total_Spend_Sum_12 := IF((INTEGER)LEFT.Total_Spend_Sum_12 >= 12, (STRING)((INTEGER)LEFT.Total_Spend_Sum_12 - 12), LEFT.Total_Spend_Sum_12);
				SELF.TotalSpend12Mos := Total_Spend_Sum_12;
				SELF.SpendTrajectory12Mos := Business_Risk_BIP.Common.getCorteraTrajectory(Total_Spend_Sum_12, LEFT.total_spend_slope_0t12);
				SELF.SpendTrajectory24Mos := Business_Risk_BIP.Common.getCorteraTrajectory(Total_Spend_Sum_12, LEFT.total_spend_slope_0t24, LEFT.total_spend_monthspastleast_24, LEFT.total_spend_monthspastmost_24);
				SELF.AveDaysBeyondTerms := LEFT.DBT; //dbt returns decimal responses. do we need to round it?
				SELF.AvgPctTradelinesGT30DPD12Mos := (STRING)ROUND((REAL)LEFT.Total_PercProv30_Avg_0T12 * 100);
				SELF.AvgPctTradelinesGT60DPD12Mos := (STRING)ROUND((REAL)LEFT.Total_PercProv60_Avg_0T12 * 100);
				SELF.AvgPctTradelinesGT90DPD12Mos := (STRING)ROUND((REAL)LEFT.Total_PercProv90_Avg_0T12 * 100);
				SELF.DaysBeyondTerms30Trajectory12Mos := Business_Risk_BIP.Common.getCorteraTrajectory(LEFT.total_numrel_avg12, LEFT.total_percprov30_slope_0t12);
				SELF.DaysBeyondTerms30Trajectory24Mos := Business_Risk_BIP.Common.getCorteraTrajectory(LEFT.total_numrel_avg12, LEFT.total_percprov30_slope_0t24, LEFT.total_numrel_monthspastleast_24, LEFT.total_numrel_monthpspastmost_24);
				SELF.DaysBeyondTerms60Trajectory12Mos := Business_Risk_BIP.Common.getCorteraTrajectory(LEFT.total_numrel_avg12, LEFT.total_percprov60_slope_0t12);
				SELF.DaysBeyondTerms60Trajectory24Mos := Business_Risk_BIP.Common.getCorteraTrajectory(LEFT.total_numrel_avg12, LEFT.total_percprov60_slope_0t24, LEFT.total_numrel_monthspastleast_24, LEFT.total_numrel_monthpspastmost_24);
				SELF.PaidInFull12Mos := MAP(TRIM(Total_Spend_Sum_12) = '' 																						 => '-1', // No Cortera data available
																		(INTEGER)Total_Spend_Sum_12 = 0 AND TRIM(Total_Spend_Sum_12) <> '' 	 	     => '0',  // No Cortera data available in the past 12 months
																		(REAL)LEFT.Total_Paid_Average_0T12 < 1 AND (INTEGER)Total_Spend_Sum_12 > 0 => '1',  // Not all balances were paid in the past 12 months
																		(REAL)LEFT.Total_Paid_Average_0T12 = 1 AND (INTEGER)Total_Spend_Sum_12 > 0 => '2',	 // All balances paid in full in the last 12 months
																																																									'0');


				SELF.AvgPayments03Mos := LEFT.Avg_Bal;
				SELF.SourceIndex := IF(LEFT.Ultimate_LinkID > 0, '2', '0');
				SELF.dt_first_seen := LEFT.dt_first_seen;
				SELF.dt_last_Seen := LEFT.dt_last_seen;
				SELF.AIR_SPEND := (INTEGER)LEFT.AIR_SPEND > 0;
				SELF.FUEL_SPEND := (INTEGER)LEFT.FUEL_SPEND > 0;
				SELF.LEASING_SPEND := (INTEGER)LEFT.LEASING_SPEND > 0;
				SELF.LTL_SPEND := (INTEGER)LEFT.LTL_SPEND > 0;
				SELF.RAIL_SPEND := (INTEGER)LEFT.RAIL_SPEND > 0;
				SELF.TL_SPEND := (INTEGER)LEFT.TL_SPEND > 0;
				SELF.TRANSVC_SPEND := (INTEGER)LEFT.TRANSVC_SPEND > 0;
				SELF.TRANSUP_SPEND := (INTEGER)LEFT.TRANSUP_SPEND > 0;
				SELF.BST_SPEND := (INTEGER)LEFT.BST_SPEND > 0;
				SELF.DG_SPEND := (INTEGER)LEFT.DG_SPEND > 0;
				SELF.ELECTRICAL_SPEND := (INTEGER)LEFT.ELECTRICAL_SPEND > 0;
				SELF.HVAC_SPEND := (INTEGER)LEFT.HVAC_SPEND > 0;
				SELF.OTHER_B_SPEND := (INTEGER)LEFT.OTHER_B_SPEND > 0;
				SELF.PLUMBING_SPEND := (INTEGER)LEFT.PLUMBING_SPEND > 0;
				SELF.RS_SPEND := (INTEGER)LEFT.RS_SPEND > 0;
				SELF.WP_SPEND := (INTEGER)LEFT.WP_SPEND > 0;
				SELF.CHEMICAL_SPEND := (INTEGER)LEFT.CHEMICAL_SPEND > 0;
				SELF.ELECTRONIC_SPEND := (INTEGER)LEFT.ELECTRONIC_SPEND > 0;
				SELF.METAL_SPEND := (INTEGER)LEFT.METAL_SPEND > 0;
				SELF.OTHER_M_SPEND := (INTEGER)LEFT.OTHER_M_SPEND > 0;
				SELF.PACKAGING_SPEND := (INTEGER)LEFT.PACKAGING_SPEND > 0;
				SELF.PVF_SPEND := (INTEGER)LEFT.PVF_SPEND > 0;
				SELF.PLASTIC_SPEND := (INTEGER)LEFT.PLASTIC_SPEND > 0;
				SELF.TEXTILE_SPEND := (INTEGER)LEFT.TEXTILE_SPEND > 0;
				SELF.BS_SPEND := (INTEGER)LEFT.BS_SPEND > 0;
				SELF.CE_SPEND := (INTEGER)LEFT.CE_SPEND > 0;
				SELF.HARDWARE_SPEND := (INTEGER)LEFT.HARDWARE_SPEND > 0;
				SELF.IE_SPEND := (INTEGER)LEFT.IE_SPEND > 0;
				SELF.IS_SPEND := (INTEGER)LEFT.IS_SPEND > 0;
				SELF.IT_SPEND := (INTEGER)LEFT.IT_SPEND > 0;
				SELF.MLS_SPEND := (INTEGER)LEFT.MLS_SPEND > 0;
				SELF.OS_SPEND := (INTEGER)LEFT.OS_SPEND > 0;
				SELF.PP_SPEND := (INTEGER)LEFT.PP_SPEND > 0;
				SELF.SIS_SPEND := (INTEGER)LEFT.SIS_SPEND > 0;
				SELF.APPAREL_SPEND := (INTEGER)LEFT.APPAREL_SPEND > 0;
				SELF.BEVERAGES_SPEND := (INTEGER)LEFT.BEVERAGES_SPEND > 0;
				SELF.CONSTR_SPEND := (INTEGER)LEFT.CONSTR_SPEND > 0;
				SELF.CONSULTING_SPEND := (INTEGER)LEFT.CONSULTING_SPEND > 0;
				SELF.FS_SPEND := (INTEGER)LEFT.FS_SPEND > 0;
				SELF.FP_SPEND := (INTEGER)LEFT.FP_SPEND > 0;
				SELF.INSURANCE_SPEND := (INTEGER)LEFT.INSURANCE_SPEND > 0;
				SELF.LS_SPEND := (INTEGER)LEFT.LS_SPEND > 0;
				SELF.OIL_GAS_SPEND := (INTEGER)LEFT.OIL_GAS_SPEND > 0;
				SELF.UTILITIES_SPEND := (INTEGER)LEFT.UTILITIES_SPEND > 0;
				SELF.OTHER_SPEND := (INTEGER)LEFT.OTHER_SPEND > 0;
				SELF.ADVT_SPEND := (INTEGER)LEFT.ADVT_SPEND > 0;
				SELF := []
    ));

	CorteraAttributes_RetroTest := JOIN(Shell, CorteraRetrotestRecs,
		LEFT.Input_Echo.Acctno = RIGHT.Acctno,
    TRANSFORM( TempLayoutCortera,
				SELF.seq := LEFT.seq;
				SELF.Ultimate_LinkID := RIGHT.Ultimate_LinkID;
				SELF.VendorScoreFutureDelinquencyMax := (STRING)RIGHT.Cortera_Score;
				SELF.VendorScoreFutureDelinquencyMin := (STRING)RIGHT.Cortera_Score;
				SELF.VendorScorePaymentBehaviorMax := (STRING)RIGHT.CPR_Score;
				SELF.VendorScorePaymentBehaviorMin := (STRING)RIGHT.CPR_Score;
				SELF.AvgProviderCount12Mos := (STRING)ROUND((REAL)RIGHT.Total_NumRel_Avg12, 2);
				SELF.ProviderTrajectory12Mos := Business_Risk_BIP.Common.getCorteraTrajectory(RIGHT.total_numrel_avg12, RIGHT.total_numrel_slope_0t12);
				SELF.ProviderTrajectory24Mos := Business_Risk_BIP.Common.getCorteraTrajectory(RIGHT.total_numrel_avg12, RIGHT.total_numrel_slope_0t24, RIGHT.total_numrel_monthspastleast_24, RIGHT.total_numrel_monthpspastmost_24); // changed from sample code
				 // There is a bug in the data we recieve from Cortera where we need to subtract 12 from total_spend_sum_12 to reflect the true value.
        Total_Spend_Sum_12 := IF((INTEGER)RIGHT.Total_Spend_Sum_12 >= 12, (STRING)((INTEGER)RIGHT.Total_Spend_Sum_12 - 12), RIGHT.Total_Spend_Sum_12);
        SELF.TotalSpend12Mos := Total_Spend_Sum_12;
				SELF.SpendTrajectory12Mos := Business_Risk_BIP.Common.getCorteraTrajectory(Total_Spend_Sum_12, RIGHT.total_spend_slope_0t12);
				SELF.SpendTrajectory24Mos := Business_Risk_BIP.Common.getCorteraTrajectory(Total_Spend_Sum_12, RIGHT.total_spend_slope_0t24, RIGHT.total_spend_monthspastleast_24, RIGHT.total_spend_monthspastmost_24);
				SELF.AveDaysBeyondTerms := RIGHT.DBT; //dbt returns decimal responses. do we need to round it?
				SELF.AvgPctTradelinesGT30DPD12Mos := (STRING)ROUND((REAL)RIGHT.Total_PercProv30_Avg_0T12 * 100);
				SELF.AvgPctTradelinesGT60DPD12Mos := (STRING)ROUND((REAL)RIGHT.Total_PercProv60_Avg_0T12 * 100);
				SELF.AvgPctTradelinesGT90DPD12Mos := (STRING)ROUND((REAL)RIGHT.Total_PercProv90_Avg_0T12 * 100);
				SELF.DaysBeyondTerms30Trajectory12Mos := Business_Risk_BIP.Common.getCorteraTrajectory(RIGHT.total_numrel_avg12, RIGHT.total_percprov30_slope_0t12);
				SELF.DaysBeyondTerms30Trajectory24Mos := Business_Risk_BIP.Common.getCorteraTrajectory(RIGHT.total_numrel_avg12, RIGHT.total_percprov30_slope_0t24, RIGHT.total_numrel_monthspastleast_24, RIGHT.total_numrel_monthpspastmost_24);
				SELF.DaysBeyondTerms60Trajectory12Mos := Business_Risk_BIP.Common.getCorteraTrajectory(RIGHT.total_numrel_avg12, RIGHT.total_percprov60_slope_0t12);
				SELF.DaysBeyondTerms60Trajectory24Mos := Business_Risk_BIP.Common.getCorteraTrajectory(RIGHT.total_numrel_avg12, RIGHT.total_percprov60_slope_0t24, RIGHT.total_numrel_monthspastleast_24, RIGHT.total_numrel_monthpspastmost_24);
				SELF.PaidInFull12Mos := MAP(TRIM(Total_Spend_Sum_12) = '' 																						 	=> '-1', // No Cortera data available
																		(INTEGER)Total_Spend_Sum_12 = 0 AND TRIM(Total_Spend_Sum_12) <> '' 	 	      => '0',  // No Cortera data available in the past 12 months
																		(REAL)RIGHT.Total_Paid_Average_0T12 < 1 AND (INTEGER)Total_Spend_Sum_12 > 0 => '1',  // Not all balances were paid in the past 12 months
																		(REAL)RIGHT.Total_Paid_Average_0T12 = 1 AND (INTEGER)Total_Spend_Sum_12 > 0 => '2',	 // All balances paid in full in the last 12 months
																																																									 '0');
				SELF.AvgPayments03Mos := RIGHT.Avg_Bal;
				SELF.SourceIndex := IF(RIGHT.Ultimate_LinkID > 0, '2', '0');
				// SELF.dt_first_seen := RIGHT.dt_first_seen;
				// SELF.dt_last_Seen := RIGHT.dt_last_seen;
				SELF.AIR_SPEND := (INTEGER)RIGHT.AIR_SPEND > 0;
				SELF.FUEL_SPEND := (INTEGER)RIGHT.FUEL_SPEND > 0;
				SELF.LEASING_SPEND := (INTEGER)RIGHT.LEASING_SPEND > 0;
				SELF.LTL_SPEND := (INTEGER)RIGHT.LTL_SPEND > 0;
				SELF.RAIL_SPEND := (INTEGER)RIGHT.RAIL_SPEND > 0;
				SELF.TL_SPEND := (INTEGER)RIGHT.TL_SPEND > 0;
				SELF.TRANSVC_SPEND := (INTEGER)RIGHT.TRANSVC_SPEND > 0;
				SELF.TRANSUP_SPEND := (INTEGER)RIGHT.TRANSUP_SPEND > 0;
				SELF.BST_SPEND := (INTEGER)RIGHT.BST_SPEND > 0;
				SELF.DG_SPEND := (INTEGER)RIGHT.DG_SPEND > 0;
				SELF.ELECTRICAL_SPEND := (INTEGER)RIGHT.ELECTRICAL_SPEND > 0;
				SELF.HVAC_SPEND := (INTEGER)RIGHT.HVAC_SPEND > 0;
				SELF.OTHER_B_SPEND := (INTEGER)RIGHT.OTHER_B_SPEND > 0;
				SELF.PLUMBING_SPEND := (INTEGER)RIGHT.PLUMBING_SPEND > 0;
				SELF.RS_SPEND := (INTEGER)RIGHT.RS_SPEND > 0;
				SELF.WP_SPEND := (INTEGER)RIGHT.WP_SPEND > 0;
				SELF.CHEMICAL_SPEND := (INTEGER)RIGHT.CHEMICAL_SPEND > 0;
				SELF.ELECTRONIC_SPEND := (INTEGER)RIGHT.ELECTRONIC_SPEND > 0;
				SELF.METAL_SPEND := (INTEGER)RIGHT.METAL_SPEND > 0;
				SELF.OTHER_M_SPEND := (INTEGER)RIGHT.OTHER_M_SPEND > 0;
				SELF.PACKAGING_SPEND := (INTEGER)RIGHT.PACKAGING_SPEND > 0;
				SELF.PVF_SPEND := (INTEGER)RIGHT.PVF_SPEND > 0;
				SELF.PLASTIC_SPEND := (INTEGER)RIGHT.PLASTIC_SPEND > 0;
				SELF.TEXTILE_SPEND := (INTEGER)RIGHT.TEXTILE_SPEND > 0;
				SELF.BS_SPEND := (INTEGER)RIGHT.BS_SPEND > 0;
				SELF.CE_SPEND := (INTEGER)RIGHT.CE_SPEND > 0;
				SELF.HARDWARE_SPEND := (INTEGER)RIGHT.HARDWARE_SPEND > 0;
				SELF.IE_SPEND := (INTEGER)RIGHT.IE_SPEND > 0;
				SELF.IS_SPEND := (INTEGER)RIGHT.IS_SPEND > 0;
				SELF.IT_SPEND := (INTEGER)RIGHT.IT_SPEND > 0;
				SELF.MLS_SPEND := (INTEGER)RIGHT.MLS_SPEND > 0;
				SELF.OS_SPEND := (INTEGER)RIGHT.OS_SPEND > 0;
				SELF.PP_SPEND := (INTEGER)RIGHT.PP_SPEND > 0;
				SELF.SIS_SPEND := (INTEGER)RIGHT.SIS_SPEND > 0;
				SELF.APPAREL_SPEND := (INTEGER)RIGHT.APPAREL_SPEND > 0;
				SELF.BEVERAGES_SPEND := (INTEGER)RIGHT.BEVERAGES_SPEND > 0;
				SELF.CONSTR_SPEND := (INTEGER)RIGHT.CONSTR_SPEND > 0;
				SELF.CONSULTING_SPEND := (INTEGER)RIGHT.CONSULTING_SPEND > 0;
				SELF.FS_SPEND := (INTEGER)RIGHT.FS_SPEND > 0;
				SELF.FP_SPEND := (INTEGER)RIGHT.FP_SPEND > 0;
				SELF.INSURANCE_SPEND := (INTEGER)RIGHT.INSURANCE_SPEND > 0;
				SELF.LS_SPEND := (INTEGER)RIGHT.LS_SPEND > 0;
				SELF.OIL_GAS_SPEND := (INTEGER)RIGHT.OIL_GAS_SPEND > 0;
				SELF.UTILITIES_SPEND := (INTEGER)RIGHT.UTILITIES_SPEND > 0;
				SELF.OTHER_SPEND := (INTEGER)RIGHT.OTHER_SPEND > 0;
				SELF.ADVT_SPEND := (INTEGER)RIGHT.ADVT_SPEND > 0;
				SELF := []
    )
    /*,LEFT OUTER*/, ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	// Check DPM to make sure we can return Cortera attribute data, and determine whether to use the Cortera retrotest records
	// that were passed in or the in-house Cortera data.
	CorteraAttributes := MAP(Allow_Cortera AND UseRetroTest => CorteraAttributes_RetroTest,
													 Allow_Cortera AND NOT UseRetroTest => CorteraAttributes_InHouse,
																													DATASET([], TempLayoutCortera));

	// Only look at most recent record for each Cortera LinkID.
	CorteraAttributesUltimateID := DEDUP(SORT(CorteraAttributes, Seq, Ultimate_LinkID, -dt_last_seen, -dt_first_seen, RECORD), seq, Ultimate_LinkID);

	rollCorteraAttributes := ROLLUP(CorteraAttributesUltimateID, LEFT.Seq = RIGHT.Seq, TRANSFORM(TempLayoutCortera,
				SELF.seq := LEFT.seq;
				SELF.VendorScoreFutureDelinquencyMax := (STRING)MAX((UNSIGNED)LEFT.VendorScoreFutureDelinquencyMax, (UNSIGNED)RIGHT.VendorScoreFutureDelinquencyMax);
				SELF.VendorScoreFutureDelinquencyMin := (STRING)ut.Min2((UNSIGNED)LEFT.VendorScoreFutureDelinquencyMin, (UNSIGNED)RIGHT.VendorScoreFutureDelinquencyMin);
				SELF.VendorScorePaymentBehaviorMax := (STRING)MAX((UNSIGNED)LEFT.VendorScorePaymentBehaviorMax, (UNSIGNED)RIGHT.VendorScorePaymentBehaviorMax);
				SELF.VendorScorePaymentBehaviorMin := (STRING)ut.Min2((UNSIGNED)LEFT.VendorScorePaymentBehaviorMin, (UNSIGNED)RIGHT.VendorScorePaymentBehaviorMin);
				SELF.AvgProviderCount12Mos := (STRING)MAX((REAL)LEFT.AvgProviderCount12Mos, (REAL)RIGHT.AvgProviderCount12Mos);
				SELF.ProviderTrajectory12Mos := Business_Risk_BIP.Common.rollCorteraTrajectory(LEFT.ProviderTrajectory12Mos, RIGHT.ProviderTrajectory12Mos);
				SELF.ProviderTrajectory24Mos := Business_Risk_BIP.Common.rollCorteraTrajectory(LEFT.ProviderTrajectory24Mos, RIGHT.ProviderTrajectory24Mos);
				SELF.TotalSpend12Mos := (STRING)SUM((UNSIGNED)LEFT.TotalSpend12Mos, (UNSIGNED)RIGHT.TotalSpend12Mos);
				SELF.SpendTrajectory12Mos := Business_Risk_BIP.Common.rollCorteraTrajectory(LEFT.SpendTrajectory12Mos, RIGHT.SpendTrajectory12Mos);
				SELF.SpendTrajectory24Mos := Business_Risk_BIP.Common.rollCorteraTrajectory(LEFT.SpendTrajectory24Mos, RIGHT.SpendTrajectory24Mos);
				SELF.AveDaysBeyondTerms := (STRING)MAX((REAL)LEFT.AveDaysBeyondTerms, (REAL)RIGHT.AveDaysBeyondTerms); //dbt returns decimal responses. do we need to round it?
				SELF.AvgPctTradelinesGT30DPD12Mos := (STRING)MAX((UNSIGNED)LEFT.AvgPctTradelinesGT30DPD12Mos, (UNSIGNED)RIGHT.AvgPctTradelinesGT30DPD12Mos);
				SELF.AvgPctTradelinesGT60DPD12Mos := (STRING)MAX((UNSIGNED)LEFT.AvgPctTradelinesGT60DPD12Mos, (UNSIGNED)RIGHT.AvgPctTradelinesGT60DPD12Mos);
				SELF.AvgPctTradelinesGT90DPD12Mos := (STRING)MAX((UNSIGNED)LEFT.AvgPctTradelinesGT90DPD12Mos, (UNSIGNED)RIGHT.AvgPctTradelinesGT90DPD12Mos);
				SELF.DaysBeyondTerms30Trajectory12Mos := Business_Risk_BIP.Common.rollCorteraTrajectory(LEFT.DaysBeyondTerms30Trajectory12Mos, RIGHT.DaysBeyondTerms30Trajectory12Mos);
				SELF.DaysBeyondTerms30Trajectory24Mos := Business_Risk_BIP.Common.rollCorteraTrajectory(LEFT.DaysBeyondTerms30Trajectory24Mos, RIGHT.DaysBeyondTerms30Trajectory24Mos);
				SELF.DaysBeyondTerms60Trajectory12Mos := Business_Risk_BIP.Common.rollCorteraTrajectory(LEFT.DaysBeyondTerms60Trajectory12Mos, RIGHT.DaysBeyondTerms60Trajectory12Mos);
				SELF.DaysBeyondTerms60Trajectory24Mos := Business_Risk_BIP.Common.rollCorteraTrajectory(LEFT.DaysBeyondTerms60Trajectory24Mos, RIGHT.DaysBeyondTerms60Trajectory24Mos);
				SELF.PaidInFull12Mos := IF((INTEGER)LEFT.PaidInFull12Mos > 0 AND (INTEGER)RIGHT.PaidInFull12Mos > 0, 	  // If both values are greater than 0, then we have payment data on both Cortera IDs, and we take the MIN
																	(STRING)MIN((INTEGER)LEFT.PaidInFull12Mos, (INTEGER)RIGHT.PaidInFull12Mos),	  // (So if we are comparing a 1 (some balance not paid in full) to a 2 (all balances paid in full) we return a 1 (some balance not paid in full))
																	(STRING)MAX((INTEGER)LEFT.PaidInFull12Mos, (INTEGER)RIGHT.PaidInFull12Mos));  // Otherwise, at least one value is -1 or 0, so we keep the MAX (the Cortera ID we have the most data on)
				SELF.AvgPayments03Mos := (STRING)MAX((UNSIGNED)LEFT.AvgPayments03Mos, (UNSIGNED)RIGHT.AvgPayments03Mos);
				SELF.SourceIndex := (STRING)MAX((UNSIGNED)LEFT.SourceIndex, (UNSIGNED)RIGHT.SourceIndex);
				SELF.dt_first_seen := 0;
				SELF.dt_last_Seen := 0;
				SELF.AIR_SPEND := LEFT.AIR_SPEND OR RIGHT.AIR_SPEND;
				SELF.FUEL_SPEND := LEFT.FUEL_SPEND OR RIGHT.FUEL_SPEND;
				SELF.LEASING_SPEND := LEFT.LEASING_SPEND OR RIGHT.LEASING_SPEND;
				SELF.LTL_SPEND := LEFT.LTL_SPEND OR RIGHT.LTL_SPEND;
				SELF.RAIL_SPEND := LEFT.RAIL_SPEND OR RIGHT.RAIL_SPEND;
				SELF.TL_SPEND := LEFT.TL_SPEND OR RIGHT.TL_SPEND;
				SELF.TRANSVC_SPEND := LEFT.TRANSVC_SPEND OR RIGHT.TRANSVC_SPEND;
				SELF.TRANSUP_SPEND := LEFT.TRANSUP_SPEND OR RIGHT.TRANSUP_SPEND;
				SELF.BST_SPEND := LEFT.BST_SPEND OR RIGHT.BST_SPEND;
				SELF.DG_SPEND := LEFT.DG_SPEND OR RIGHT.DG_SPEND;
				SELF.ELECTRICAL_SPEND := LEFT.ELECTRICAL_SPEND OR RIGHT.ELECTRICAL_SPEND;
				SELF.HVAC_SPEND := LEFT.HVAC_SPEND OR RIGHT.HVAC_SPEND;
				SELF.OTHER_B_SPEND := LEFT.OTHER_B_SPEND OR RIGHT.OTHER_B_SPEND;
				SELF.PLUMBING_SPEND := LEFT.PLUMBING_SPEND OR RIGHT.PLUMBING_SPEND;
				SELF.RS_SPEND := LEFT.RS_SPEND OR RIGHT.RS_SPEND;
				SELF.WP_SPEND := LEFT.WP_SPEND OR RIGHT.WP_SPEND;
				SELF.CHEMICAL_SPEND := LEFT.CHEMICAL_SPEND OR RIGHT.CHEMICAL_SPEND;
				SELF.ELECTRONIC_SPEND := LEFT.ELECTRONIC_SPEND OR RIGHT.ELECTRONIC_SPEND;
				SELF.METAL_SPEND := LEFT.METAL_SPEND OR RIGHT.METAL_SPEND;
				SELF.OTHER_M_SPEND := LEFT.OTHER_M_SPEND OR RIGHT.OTHER_M_SPEND;
				SELF.PACKAGING_SPEND := LEFT.PACKAGING_SPEND OR RIGHT.PACKAGING_SPEND;
				SELF.PVF_SPEND := LEFT.PVF_SPEND OR RIGHT.PVF_SPEND;
				SELF.PLASTIC_SPEND := LEFT.PLASTIC_SPEND OR RIGHT.PLASTIC_SPEND;
				SELF.TEXTILE_SPEND := LEFT.TEXTILE_SPEND OR RIGHT.TEXTILE_SPEND;
				SELF.BS_SPEND := LEFT.BS_SPEND OR RIGHT.BS_SPEND;
				SELF.CE_SPEND := LEFT.CE_SPEND OR RIGHT.CE_SPEND;
				SELF.HARDWARE_SPEND := LEFT.HARDWARE_SPEND OR RIGHT.HARDWARE_SPEND;
				SELF.IE_SPEND := LEFT.IE_SPEND OR RIGHT.IE_SPEND;
				SELF.IS_SPEND := LEFT.IS_SPEND OR RIGHT.IS_SPEND;
				SELF.IT_SPEND := LEFT.IT_SPEND OR RIGHT.IT_SPEND;
				SELF.MLS_SPEND := LEFT.MLS_SPEND OR RIGHT.MLS_SPEND;
				SELF.OS_SPEND := LEFT.OS_SPEND OR RIGHT.OS_SPEND;
				SELF.PP_SPEND := LEFT.PP_SPEND OR RIGHT.PP_SPEND;
				SELF.SIS_SPEND := LEFT.SIS_SPEND OR RIGHT.SIS_SPEND;
				SELF.APPAREL_SPEND := LEFT.APPAREL_SPEND OR RIGHT.APPAREL_SPEND;
				SELF.BEVERAGES_SPEND := LEFT.BEVERAGES_SPEND OR RIGHT.BEVERAGES_SPEND;
				SELF.CONSTR_SPEND := LEFT.CONSTR_SPEND OR RIGHT.CONSTR_SPEND;
				SELF.CONSULTING_SPEND := LEFT.CONSULTING_SPEND OR RIGHT.CONSULTING_SPEND;
				SELF.FS_SPEND := LEFT.FS_SPEND OR RIGHT.FS_SPEND;
				SELF.FP_SPEND := LEFT.FP_SPEND OR RIGHT.FP_SPEND;
				SELF.INSURANCE_SPEND := LEFT.INSURANCE_SPEND OR RIGHT.INSURANCE_SPEND;
				SELF.LS_SPEND := LEFT.LS_SPEND OR RIGHT.LS_SPEND;
				SELF.OIL_GAS_SPEND := LEFT.OIL_GAS_SPEND OR RIGHT.OIL_GAS_SPEND;
				SELF.UTILITIES_SPEND := LEFT.UTILITIES_SPEND OR RIGHT.UTILITIES_SPEND;
				SELF.OTHER_SPEND := LEFT.OTHER_SPEND OR RIGHT.OTHER_SPEND;
				SELF.ADVT_SPEND := LEFT.ADVT_SPEND OR RIGHT.ADVT_SPEND;
				SELF := LEFT));

	withCorteraAttributes := JOIN(withCorteraAttributesFirstSeen, rollCorteraAttributes, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
				CorteraNoHit := RIGHT.Ultimate_LinkID = 0;
        SELF.B2B.AttributesTimeOldest := IF(CorteraNoHit OR (INTEGER)LEFT.B2B.AttributesTimeOldest=0, '-1', LEFT.B2B.AttributesTimeOldest);
				SELF.B2B.VendorScoreFutureDelinquencyMax := IF(CorteraNoHit OR (INTEGER)RIGHT.VendorScoreFutureDelinquencyMax = 0, '-1', (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.VendorScoreFutureDelinquencyMax, -1, 900));
				SELF.B2B.VendorScoreFutureDelinquencyMin := IF(CorteraNoHit OR (INTEGER)RIGHT.VendorScoreFutureDelinquencyMin = 0, '-1', (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.VendorScoreFutureDelinquencyMin, -1, 900));
				SELF.B2B.VendorScorePaymentBehaviorMax := IF(CorteraNoHit OR (INTEGER)RIGHT.VendorScorePaymentBehaviorMax = 0, '-1', (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.VendorScorePaymentBehaviorMax, -1, 900));
				SELF.B2B.VendorScorePaymentBehaviorMin := IF(CorteraNoHit OR (INTEGER)RIGHT.VendorScorePaymentBehaviorMin = 0, '-1', (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.VendorScorePaymentBehaviorMin, -1, 900));
				SELF.B2B.AvgProviderCount12Mos := IF(CorteraNoHit, '-1', (STRING)Business_Risk_BIP.Common.capNum((REAL)RIGHT.AvgProviderCount12Mos, -1, 999999999));
				SELF.B2B.ProviderTrajectory12Mos := IF(CorteraNoHit, '-1', RIGHT.ProviderTrajectory12Mos);
				SELF.B2B.ProviderTrajectory24Mos := IF(CorteraNoHit, '-1', RIGHT.ProviderTrajectory24Mos);
				NumSpendCategories12Mos :=
							(INTEGER)RIGHT.AIR_SPEND				+	(INTEGER)RIGHT.FUEL_SPEND			+	(INTEGER)RIGHT.LEASING_SPEND		+	(INTEGER)RIGHT.LTL_SPEND				+	(INTEGER)RIGHT.RAIL_SPEND			+
							(INTEGER)RIGHT.TL_SPEND					+	(INTEGER)RIGHT.TRANSVC_SPEND	+	(INTEGER)RIGHT.TRANSUP_SPEND		+	(INTEGER)RIGHT.BST_SPEND				+	(INTEGER)RIGHT.DG_SPEND				+
							(INTEGER)RIGHT.ELECTRICAL_SPEND	+	(INTEGER)RIGHT.HVAC_SPEND			+	(INTEGER)RIGHT.OTHER_B_SPEND		+	(INTEGER)RIGHT.PLUMBING_SPEND		+	(INTEGER)RIGHT.RS_SPEND				+
							(INTEGER)RIGHT.WP_SPEND					+	(INTEGER)RIGHT.CHEMICAL_SPEND	+	(INTEGER)RIGHT.ELECTRONIC_SPEND	+	(INTEGER)RIGHT.METAL_SPEND			+	(INTEGER)RIGHT.OTHER_M_SPEND	+
							(INTEGER)RIGHT.PACKAGING_SPEND	+	(INTEGER)RIGHT.PVF_SPEND			+	(INTEGER)RIGHT.PLASTIC_SPEND		+	(INTEGER)RIGHT.TEXTILE_SPEND		+	(INTEGER)RIGHT.BS_SPEND				+
							(INTEGER)RIGHT.CE_SPEND					+	(INTEGER)RIGHT.HARDWARE_SPEND	+	(INTEGER)RIGHT.IE_SPEND					+	(INTEGER)RIGHT.IS_SPEND					+	(INTEGER)RIGHT.IT_SPEND				+
							(INTEGER)RIGHT.MLS_SPEND				+	(INTEGER)RIGHT.OS_SPEND				+	(INTEGER)RIGHT.PP_SPEND					+	(INTEGER)RIGHT.SIS_SPEND				+	(INTEGER)RIGHT.APPAREL_SPEND	+
							(INTEGER)RIGHT.BEVERAGES_SPEND	+	(INTEGER)RIGHT.CONSTR_SPEND		+	(INTEGER)RIGHT.CONSULTING_SPEND	+	(INTEGER)RIGHT.FS_SPEND					+	(INTEGER)RIGHT.FP_SPEND				+
							(INTEGER)RIGHT.INSURANCE_SPEND	+	(INTEGER)RIGHT.LS_SPEND				+	(INTEGER)RIGHT.OIL_GAS_SPEND		+	(INTEGER)RIGHT.UTILITIES_SPEND	+	(INTEGER)RIGHT.OTHER_SPEND		+
							(INTEGER)RIGHT.ADVT_SPEND;
				SELF.B2B.NumSpendCategories12Mos := IF(CorteraNoHit, '-1', (STRING)Business_Risk_BIP.Common.capNum(NumSpendCategories12Mos, -1, 50));
				SELF.B2B.TotalSpend12Mos := IF(CorteraNoHit, '-1', (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.TotalSpend12Mos, -1, 999999999)) ;
				SELF.B2B.SpendTrajectory12Mos := IF(CorteraNoHit, '-1', RIGHT.SpendTrajectory12Mos);
				SELF.B2B.SpendTrajectory24Mos := IF(CorteraNoHit, '-1', RIGHT.SpendTrajectory24Mos);
				SELF.B2B.AveDaysBeyondTerms := IF(CorteraNoHit, '-1', (STRING)Business_Risk_BIP.Common.capNum((REAL)RIGHT.AveDaysBeyondTerms, -1,  999999999)); //dbt is a string. do we need to round it?
				AvgPctTradelinesGT30DPD12Mos := IF(CorteraNoHit, '-1', (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.AvgPctTradelinesGT30DPD12Mos, -1, 100));
				SELF.B2B.AvgPctTradelinesGT30DPD12Mos := AvgPctTradelinesGT30DPD12Mos;
				SELF.B2B.AvgPctTradelinesGT30DPDIndex12Mos := Business_Risk_BIP.Common.getCorteraTradelineIndex(AvgPctTradelinesGT30DPD12Mos);
				AvgPctTradelinesGT60DPD12Mos := IF(CorteraNoHit, '-1', (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.AvgPctTradelinesGT60DPD12Mos, -1, 100));
				SELF.B2B.AvgPctTradelinesGT60DPD12Mos := AvgPctTradelinesGT60DPD12Mos;
				SELF.B2B.AvgPctTradelinesGT60DPDIndex12Mos := Business_Risk_BIP.Common.getCorteraTradelineIndex(AvgPctTradelinesGT60DPD12Mos);
				AvgPctTradelinesGT90DPD12Mos := IF(CorteraNoHit, '-1', (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.AvgPctTradelinesGT90DPD12Mos, -1, 100));
				SELF.B2B.AvgPctTradelinesGT90DPD12Mos := AvgPctTradelinesGT90DPD12Mos;
				SELF.B2B.AvgPctTradelinesGT90DPDIndex12Mos := Business_Risk_BIP.Common.getCorteraTradelineIndex(AvgPctTradelinesGT90DPD12Mos);
				SELF.B2B.DaysBeyondTerms30Trajectory12Mos := IF(CorteraNoHit, '-1', RIGHT.DaysBeyondTerms30Trajectory12Mos);
				SELF.B2B.DaysBeyondTerms30Trajectory24Mos := IF(CorteraNoHit, '-1', RIGHT.DaysBeyondTerms30Trajectory24Mos);
				SELF.B2B.DaysBeyondTerms60Trajectory12Mos := IF(CorteraNoHit, '-1', RIGHT.DaysBeyondTerms60Trajectory12Mos);
				SELF.B2B.DaysBeyondTerms60Trajectory24Mos := IF(CorteraNoHit, '-1', RIGHT.DaysBeyondTerms60Trajectory24Mos);
				SELF.B2b.PaidInFull12Mos := IF(CorteraNoHit, '-1', RIGHT.PaidInFull12Mos);
				SELF.B2B.AvgPayments03Mos := IF(CorteraNoHit, '-1', (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.AvgPayments03Mos, -1, 999999999)) ;
				SELF.Data_Build_Dates.CorteraBuildDate := CorteraBuildDate;
				SELF.Verification.SourceIndex := RIGHT.SourceIndex;
				SELF := LEFT
			),
			LEFT OUTER, KEEP(1), ATMOST(100), FEW
		);

	CorteraStats_pre_pre := TABLE(CorteraRecs,
				{Seq,
			 HistoryDate,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID),
			 Source := MDR.SourceTools.src_Cortera,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_vendor_first_reported, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_vendor_last_reported, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 INTEGER FirmEmployeeCount := MAX(GROUP, IF(total_employees = '', -1, (INTEGER)total_employees)), // if total_employees is not populated, set to -1 to differentiate from a 0 in the data.
			 INTEGER FirmReportedSales := MAX(GROUP, IF(total_sales = '', -1, (INTEGER)total_sales)), // if total_sales is not populated, set to -1 to differentiate from a 0 in the data.
			 INTEGER YearStart := MAX(GROUP, (UNSIGNED)Year_Start);
			 INTEGER BusinessClosedDate := MAX(GROUP, STD.Date.FromStringToDate(Closed_date, '%d-%b-%y'));
			 STRING2 OwnershipType := MAX(GROUP, Ownership);
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID)
			 );

  // If running Business Shell version 31 or higher, we'll need a dataset consisting of records that exist in the past 24 months
  // to calculate FirmEmployeeCount and FirmReportedSales.
  CorteraRecs_past24Months := CorteraRecs( dt_vendor_last_reported >= STD.Date.AdjustDate( HistoryDate, year_delta := -2 ) );

  // Sum of all most recent, populated employee count values among all unique data source company identifiers.
  tbl_FirmEmployeeCount := TABLE(
    DEDUP(SORT(CorteraRecs_past24Months(total_employees != ''), Seq, ultimate_linkid, -dt_last_seen, -(INTEGER)total_employees), Seq, ultimate_linkid),
    {seq, FirmEmployeeCount := SUM( GROUP, (INTEGER)total_employees )},
    Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID) );

  CorteraStats_pre :=
    JOIN(
      CorteraStats_pre_pre, tbl_FirmEmployeeCount,
      LEFT.seq = RIGHT.seq,
      TRANSFORM( RECORDOF(CorteraStats_pre_pre),
        SELF.FirmEmployeeCount :=
						IF( Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v31,
								IF( COUNT(tbl_FirmEmployeeCount(seq = LEFT.seq)) > 0, RIGHT.FirmEmployeeCount, -1 ),
								LEFT.FirmEmployeeCount ),
        SELF := LEFT,
        SELF := []
      ),
			LEFT OUTER, FEW
    );

  // Sum of all most recent, populated reported sales values among all unique data source company identifiers.
  tbl_FirmReportedSales := TABLE(
      DEDUP(SORT(CorteraRecs_past24Months(total_sales != ''), Seq, ultimate_linkid, -dt_last_seen, -(INTEGER)total_sales), Seq, ultimate_linkid),
      {seq, FirmReportedSales := SUM( GROUP, (INTEGER)total_sales )},
      Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID) );

  CorteraStats :=
    JOIN(
      CorteraStats_pre, tbl_FirmReportedSales,
      LEFT.Seq = RIGHT.Seq,
      TRANSFORM( RECORDOF(CorteraStats_pre_pre),
        SELF.FirmReportedSales :=
						IF( Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v31,
								IF( COUNT(tbl_FirmReportedSales(seq = LEFT.seq)) > 0, RIGHT.FirmReportedSales, -1 ),
								LEFT.FirmReportedSales ),
        SELF := LEFT,
        SELF := []
      ),
      LEFT OUTER, FEW
    );

	tempLayout := RECORD
		UNSIGNED4 Seq;
		UNSIGNED3 HistoryDate;
		INTEGER YearStart;
		INTEGER BusinessClosedDate;
		STRING2 OwnershipType;
		UNSIGNED4 RecordCount;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) Sources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) EmployeeSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSICNAIC) SICNAICSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSalesSources) SalesSources;
	END;

	CorteraStatsTemp := PROJECT(CorteraStats, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.HistoryDate := LEFT.HistoryDate,
																				SELF.Sources := DATASET([{LEFT.Source,
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen),
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen),
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF.EmployeeSources := IF(LEFT.FirmEmployeeCount <> -1, DATASET([{LEFT.Source,
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen),
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen),
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.FirmEmployeeCount}], Business_Risk_BIP.Layouts.LayoutSources),
																																	DATASET([],  Business_Risk_BIP.Layouts.LayoutSources));
																				SELF.SalesSources := DATASET([{LEFT.Source,
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen),
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen),
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.FirmReportedSales}], Business_Risk_BIP.Layouts.LayoutSalesSources);
																				SELF.YearStart				 := LEFT.YearStart;
																				SELF.OwnershipType		 := LEFT.OwnershipType;
																				SELF.BusinessClosedDate := LEFT.BusinessClosedDate;
																				SELF.RecordCount := 			LEFT.RecordCount;
																				SELF := []));

		CorteraStatsRolled := ROLLUP(CorteraStatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout,
																																		SELF.Seq := LEFT.Seq;
																																		SELF.HistoryDate := LEFT.HistoryDate;
																																		SELF.Sources := LEFT.Sources + RIGHT.Sources;
																																		SELF.EmployeeSources := LEFT.EmployeeSources + RIGHT.EmployeeSources;
																																		SELF.SalesSources := LEFT.SalesSources + RIGHT.SalesSources;
																																		SELF.YearStart := MAX(LEFT.YearStart, RIGHT.YearStart);
																																		SELF.OwnershipType := MAX(LEFT.OwnershipType, RIGHT.OwnershipType);
																																		SELF.BusinessClosedDate := MAX(LEFT.BusinessClosedDate, RIGHT.BusinessClosedDate);
																																		SELF.RecordCount := LEFT.RecordCount + RIGHT.RecordCount;
																																		SELF := LEFT));

		withCorteraStats := JOIN(withCorteraAttributes, CorteraStatsRolled, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
				CorteraExists := RIGHT.RecordCount > 0;
        YearToday :=  IF((STRING)RIGHT.historyDate = Business_Risk_BIP.Constants.NinesDate, (UNSIGNED)(((STRING)Std.Date.Today())[1..4]), (UNSIGNED)(((STRING)RIGHT.historyDate)[1..4]));
				SELF.Firmographic.FirmAgeEstablished := (STRING)Business_Risk_BIP.Common.CapNum(IF((UNSIGNED)RIGHT.YearStart > 0, YearToday - (UNSIGNED)RIGHT.YearStart, -1), -1, 110);
				SELF.Firmographic.OwnershipType := MAP(TRIM(RIGHT.OwnershipType)='P' => '1',
																							 TRIM(RIGHT.OwnershipType)='V' => '2',
																																							 '0');
				SELF.B2B.BusinessClosedDate := IF(RIGHT.BusinessClosedDate > 0, (STRING)RIGHT.BusinessClosedDate, '-1');
				SELF.Sources := LEFT.Sources + RIGHT.Sources;
				SELF.EmployeeSources := LEFT.EmployeeSources + RIGHT.EmployeeSources;
				SELF.SalesSources := LEFT.SalesSources + RIGHT.SalesSources;
        SELF.B2B.HeaderTimeOldest := IF(CorteraExists, LEFT.B2B.HeaderTimeOldest, '-1'); // If we haven't seen the business on the most recent Cortera update, overwrite this to -1.
				SELF := LEFT
			),
			LEFT OUTER, KEEP(1), ATMOST(100), FEW
		);

  CorteraUltimateIDData := TABLE(CorteraRecs,
       {seq,
       ultimate_linkid,
       BOOLEAN IsActive := COUNT(GROUP, Status='A') > 0;
       INTEGER RecordCount := COUNT(GROUP)},
     Seq, Ultimate_linkid);

  CorteraUltimateIDStats := TABLE(CorteraUltimateIDData,
      {Seq,
      UltimateIDCount := COUNT(GROUP),
      UltimateIDActiveCount := COUNT(GROUP, IsActive);
      UltimateIDInactiveCount := COUNT(GROUP, NOT IsActive)},
    Seq, FEW);

	withCorteraUltimateIDStats := JOIN(withCorteraStats, CorteraUltimateIDStats, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                                              CorteraExists := RIGHT.UltimateIDCount > 0;
																							SELF.B2B.UltimateIDCount := IF(NOT CorteraExists, '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.UltimateIDCount, -1, 99999));
																							SELF.B2B.UltimateIDCountActive := IF(NOT CorteraExists, '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.UltimateIDActiveCount, -1, 99999));
																							SELF.B2B.UltimateIDCountInactive := IF(NOT CorteraExists, '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.UltimateIDInactiveCount, -1, 99999));
                                              SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	CorteraSIC := TABLE(CorteraRecs,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID),
			 Source := MDR.SourceTools.src_Cortera,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 STRING10 SICCode := (STD.Str.Filter((STRING)primary_sic, '0123456789'))[1..4],
			 BOOLEAN IsPrimary := TRUE
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID), ((STRING)primary_sic)[1..4]
			 );

	CorteraSICTemp := PROJECT(CorteraSIC, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.SICNAICSources := DATASET([{LEFT.Source, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, LEFT.SICCode, Business_Risk_BIP.Common.industryGroup(LEFT.SICCode, Business_Risk_BIP.Constants.SIC), '' /*NAICCode*/, '' /*NAICIndustry*/, LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
																				SELF := []));

	CorteraSICRolled := ROLLUP(CorteraSICTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources; SELF := LEFT));

	withCorteraSIC := JOIN(withCorteraUltimateIDStats, CorteraSICRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

		CorteraNAIC := TABLE(CorteraRecs,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID),
			 Source := MDR.SourceTools.src_Cortera,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 STRING10 NAICCode := (STD.Str.Filter((STRING)primary_naics, '0123456789'))[1..6],
			 BOOLEAN IsPrimary := TRUE
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID), ((STRING)primary_naics)[1..6]
			 );

	CorteraNAICTemp := PROJECT(CorteraNAIC, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.SICNAICSources := DATASET([{LEFT.Source, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, '' /*SICCode*/, '' /*SICIndustry*/, LEFT.NAICCode, Business_Risk_BIP.Common.industryGroup(LEFT.NAICCode, Business_Risk_BIP.Constants.NAIC), LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
																				SELF := []));

	CorteraNAICRolled := ROLLUP(CorteraNAICTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources; SELF := LEFT));

	withCorteraNAIC := JOIN(withCorteraSIC, CorteraNAICRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);


	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(Shell, 100), NAMED('Sample_Shell'));
	// OUTPUT(CHOOSEN(CorteraRetrotestRecs, 100), NAMED('Sample_CorteraRetrotestRecs'));
	// OUTPUT(CHOOSEN(CorteraRaw, 100), NAMED('Sample_CorteraRaw'));
  // OUTPUT(CHOOSEN(CorteraSeq, 100), NAMED('Sample_CorteraSeq'));
  // OUTPUT(CHOOSEN(kFetchErrorCodes, 100), NAMED('Sample_kFetchErrorCodes'));
	// OUTPUT(CHOOSEN(AllCorteraRecords, 100), NAMED('Sample_AllCorteraRecords'));
	// OUTPUT(CHOOSEN(CorteraHeaderFirstSeen, 100), NAMED('Sample_CorteraHeaderFirstSeen'));
  // OUTPUT(CHOOSEN(withCorteraHeaderFirstSeen, 100), NAMED('Sample_withCorteraHeaderFirstSeen'));
	// OUTPUT(CHOOSEN(CorteraRecs, 100), NAMED('Sample_CorteraRecs'));
  // OUTPUT(CHOOSEN(CorteraRecs_DD, 100), NAMED('Sample_CorteraRecs_DD'));
	// OUTPUT(CHOOSEN(CorteraAttributes_InHouse_All, 100), NAMED('Sample_CorteraAttributes_InHouse_All'));
	// OUTPUT(CHOOSEN(CorteraAttributesFirstSeen, 100), NAMED('Sample_CorteraAttributesFirstSeen'));
	// OUTPUT(CHOOSEN(withCorteraAttributesFirstSeen, 100), NAMED('Sample_withCorteraAttributesFirstSeen'));
	// OUTPUT(CHOOSEN(CorteraAttributes_InHouse, 100), NAMED('Sample_CorteraAttributes_InHouse'));
	// OUTPUT(CHOOSEN(CorteraAttributes_RetroTest, 100), NAMED('Sample_CorteraAttributes_RetroTest'));
	// OUTPUT(CHOOSEN(CorteraAttributes, 100), NAMED('Sample_CorteraAttributes'));
	// OUTPUT(CHOOSEN(CorteraAttributesUltimateID, 100), NAMED('Sample_CorteraAttributesUltimateID'));
	// OUTPUT(CHOOSEN(rollCorteraAttributes, 100), NAMED('Sample_rollCorteraAttributes'));
	// OUTPUT(CHOOSEN(withCorteraAttributes, 100), NAMED('Sample_withCorteraAttributes'));
	// OUTPUT(CHOOSEN(CorteraStats_pre_pre, 100), NAMED('Sample_CorteraStats_pre_pre'));
  // OUTPUT(CHOOSEN(CorteraRecs_past24Months, 100), NAMED('Sample_CorteraRecs_past24Mos'));
  // OUTPUT(CHOOSEN(tbl_FirmEmployeeCount, 100), NAMED('Sample_tbl_FirmEmployeeCount'));
	// OUTPUT(CHOOSEN(CorteraStats_pre, 100), NAMED('Sample_CorteraStats_pre'));
  // OUTPUT(CHOOSEN(tbl_FirmReportedSales, 100), NAMED('Sample_tbl_FirmReportedSales'));
	// OUTPUT(CHOOSEN(CorteraStats, 100), NAMED('Sample_CorteraStats'));
	// OUTPUT(CHOOSEN(CorteraStatsTemp, 100), NAMED('Sample_CorteraStatsTemp'));
	// OUTPUT(CHOOSEN(CorteraStatsRolled, 100), NAMED('Sample_CorteraStatsRolled'));
	// OUTPUT(CHOOSEN(withCorteraStats, 100), NAMED('Sample_withCorteraStats'));
	// OUTPUT(CHOOSEN(CorteraUltimateIDData, 100), NAMED('Sample_CorteraUltimateIDData'));
	// OUTPUT(CHOOSEN(CorteraUltimateIDStats, 100), NAMED('Sample_CorteraUltimateIDStats'));
	// OUTPUT(CHOOSEN(withCorteraUltimateIDStats, 100), NAMED('Sample_withCorteraUltimateIDStats'));
	// OUTPUT(CHOOSEN(CorteraSIC, 100), NAMED('Sample_CorteraSIC'));
	// OUTPUT(CHOOSEN(CorteraSICTemp, 100), NAMED('Sample_CorteraSICTemp'));
	// OUTPUT(CHOOSEN(CorteraSICRolled, 100), NAMED('Sample_CorteraSICRolled'));
	// OUTPUT(CHOOSEN(withCorteraSIC, 100), NAMED('Sample_withCorteraSIC'));
	// OUTPUT(CHOOSEN(CorteraNAIC, 100), NAMED('Sample_CorteraNAIC'));
	// OUTPUT(CHOOSEN(CorteraNAICTemp, 100), NAMED('Sample_CorteraNAICTemp'));
	// OUTPUT(CHOOSEN(CorteraNAICRolled, 100), NAMED('Sample_CorteraNAICRolled'));
	// OUTPUT(CHOOSEN(withCorteraNAIC, 100), NAMED('Sample_withCorteraNAIC'));

	RETURN withCorteraNAIC;
END;
