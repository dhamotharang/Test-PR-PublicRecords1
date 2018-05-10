IMPORT BIPV2, Business_Risk_BIP, MDR, LiensV2, Risk_Indicators, UT, STD, iesp;
 
EXPORT getBusLien(DATASET(DueDiligence.layouts.Busn_Internal) BusnData,  
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,           //***search level options set to SELEID
											 BIPV2.mod_sources.iParams linkingOptions,                     //***These are all your DRM, GLBA, DPPA options
											 boolean ReportIsRequested = FALSE, 
											 boolean DebugMode = FALSE 
											 )  := FUNCTION

	// ------                                                                             ------
	// ------ Get the LinkIDs for this Business                                          ------
	// ------                                                                            ------
	BusnKeys    := DueDiligence.CommonBusiness.GetLinkIDs(BusnData);
	
	// --------------- Judgments and Liens ----------------
	
	// Get the TMSID/RMSID results for Liens and Judgments data
	BusinessLiensTMSIDRaw := LiensV2.Key_LinkIds.kFetch2(BusnKeys,
																						  Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	

	// ------                                                                             ------
	// ------ Add our sequence number to the Raw  records found for this Business         ------
	// ------                                                                             ------
	BusinessLiensTMSIDSeq    :=  DueDiligence.CommonBusiness.AppendSeq(BusinessLiensTMSIDRaw, BusnData, TRUE);
	
	// ----                                                                                 ------	
	// ---- Dates in the raw data are not guaranteed to be clean.  Go through and           ------
	// ---- clean any dates(upto 10) used to calculate the attributes                       ------
	// ---- pass in the resultset and the name of each date in the result set that needs    ------
	// ---- to be cleaned.                                                                  ------
	// ----  CAUTION:  if you plan to a vendor supplied date to do a calculation and the    ------
	// ---- same date is displayed in the report you should show both the cleaned date and  ------
	// ---- and the vendor supplied date.                                                   ------
	// ----                                                                                 ------
	
	BusinessLiensTMSID       :=  DueDiligence.Common.CleanDatasetDateFields(BusinessLiensTMSIDSeq, 'date_first_seen, date_vendor_first_reported, date_last_seen');  
	

	// ------                                                                                    ------	
  // ------ When this query runs in ARCHIVE MODE the History date on the input contains a date ------
	// ------ Use this function drop property records that are out of scope for this transaction ------
	// ------ If the History date is all 9's essentially no records will be dropped - also known ------
	// ------ as CURRENT MODE.                                                                   ------
	// ------                                                                                    ------
	 
	BusinessLiensTMSIDSeq_Filtered := DueDiligence.Common.FilterRecords(BusinessLiensTMSID, date_first_seen, date_vendor_first_reported); 
	
	// ------                                                                                    ------
	// ------ Get Liens main records.                                                            ------
	// ------                                                                                    ------
	// ------                                                                                    ------
	BusinessLiens_main :=
		JOIN(
			BusinessLiensTMSIDSeq_Filtered, LiensV2.key_liens_main_ID,
			KEYED( LEFT.tmsid = RIGHT.tmsid AND
			       LEFT.rmsid = RIGHT.rmsid),
			TRANSFORM(DueDiligence.LayoutsInternal.layout_liens_judgments,
			  /* create a new intermediate resultset */ 
			  /* populate the data from the LEFT     */  
				SELF.liensJudgment.seq                   := LEFT.seq,
				SELF.liensJudgment.UltID                 := LEFT.ultID,
				SELF.liensJudgment.OrgID                 := LEFT.orgID,
				SELF.liensJudgment.SeleID                := LEFT.seleID,		
				SELF.HistoryDate			                   := LEFT.HistoryDate,
				/* Essentially this is today's date if history date is all 9's OR the history date itself */   
				SELF.DateToUse                           := DueDiligence.Common.GetMyDate(LEFT.HistoryDate),
				SELF.date_first_seen                     := (STRING)LEFT.date_first_seen,
				SELF.date_last_seen                      := (STRING)LEFT.date_last_seen,
				/* populate the data from RIGHT     */   
        SELF.filing_jurisdiction                 := RIGHT.filing_jurisdiction,
        SELF.filing_number                       := RIGHT.filing_number,
				SELF.filing_type_desc                    := RIGHT.filing_type_desc,
				SELF.filing_status                       := RIGHT.filing_status[1].filing_status_desc,
        SELF.agency                              := RIGHT.agency,
        SELF.agency_state                        := RIGHT.agency_state,
        SELF.agency_county                       := RIGHT.agency_county,
				/* represent Amounts in whole dollars.*/ 
				SELF.amount                              := (STRING11)(TRUNCATE(((REAL)RIGHT.amount))),
				/*   make sure the release date is BEFORE the History Date   */   
				SELF.release_date                        := MAP(
                                                        ((INTEGER)RIGHT.release_date) <= LEFT.HistoryDate	   => RIGHT.release_date,
																		                    ((INTEGER)LEFT.date_last_seen) <= LEFT.HistoryDate	 => (STRING)LEFT.date_last_seen,
																																																                Business_Risk_BIP.Constants.MissingDate),
				SELF := RIGHT,
				SELF := []
			       ),    /*  END the TRANSFORM  */  
			INNER,
			ATMOST(DueDiligence.Constants.MAX_ATMOST)
		);            /*   END the JOIN       */ 
		
	// ----                                                                                 ------	
	// ---- Sort the liens and judgement records in seq , TMSID and date sequence           ------
	// ----                                                                                 ------
  BusinessLiens_sorted := 
		SORT( BusinessLiens_main, liensJudgment.seq, 
		                          liensJudgment.UltID,
																            liensJudgment.OrgID,
																            liensJudgment.SeleID,
																            tmsid, -orig_filing_date, -release_date, RECORD );
	
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
	// It's only counted as an eviction if the eviction = 'Y', otherwise it is classified as a lien/judgement 
	BusinessLiens_rolled :=
		ROLLUP(
			BusinessLiens_sorted,
			LEFT.liensJudgment.seq     = RIGHT.liensJudgment.seq AND
			LEFT.liensJudgment.UltID   = RIGHT.liensJudgment.UltID AND
			LEFT.liensJudgment.OrgID   = RIGHT.liensJudgment.OrgID AND
			LEFT.liensJudgment.SeleID  = RIGHT.liensJudgment.SeleID AND
			LEFT.tmsid = RIGHT.tmsid,
			TRANSFORM(DueDiligence.LayoutsInternal.layout_liens_judgments,
				SELF.liensJudgment.seq          := LEFT.liensJudgment.seq,
				SELF.liensJudgment.UltID        := LEFT.liensJudgment.UltID,
				SELF.liensJudgment.OrgID        := LEFT.liensJudgment.OrgID,
				SELF.liensJudgment.SeleID       := LEFT.liensJudgment.SeleID,
				SELF.liensJudgment.proxid       := LEFT.liensJudgment.proxid,
				SELF.liensJudgment.powid        := LEFT.liensJudgment.powid,
				SELF.did                        := 0,    /*  This is always zero for all of our business logic  */   
				SELF.HistoryDate			          := LEFT.HistoryDate,
				SELF.DateToUse                  := LEFT.DateToUse,
				SELF.NumOfDaysAgo               := 0,    /* The number of days will be calculated after the rollup  */  
        SELF.filing_number              := IF(LEFT.filing_number != DueDiligence.Constants.EMPTY, LEFT.filing_number, RIGHT.filing_number), 
				SELF.date_first_seen            := IF( LEFT.date_first_seen != DueDiligence.Constants.EMPTY AND LEFT.date_first_seen < RIGHT.date_first_seen, 
				                                       LEFT.date_first_seen, 
																							 RIGHT.date_first_seen ),
				SELF.date_last_seen             := IF( LEFT.date_last_seen  != DueDiligence.Constants.EMPTY AND LEFT.date_last_seen > RIGHT.date_last_seen, 
				                                       LEFT.date_last_seen, 
																							 RIGHT.date_last_seen ),
				SELF.tmsid                      := RIGHT.tmsid,
				SELF.eviction                   := MAP( LEFT.eviction = DueDiligence.Constants.EMPTY  => LEFT.eviction, 
				                                        RIGHT.eviction = DueDiligence.Constants.EMPTY => RIGHT.eviction, 
																								                                                                     LEFT.eviction ),
				SELF.orig_filing_date           := IF( LEFT.orig_filing_date != DueDiligence.Constants.EMPTY AND (LEFT.orig_filing_date < RIGHT.orig_filing_date OR RIGHT.orig_filing_date = DueDiligence.Constants.EMPTY), 
				                                       LEFT.orig_filing_date,       
																							 RIGHT.orig_filing_date ),    
				SELF.filing_type_desc           := IF( LEFT.filing_type_desc != DueDiligence.Constants.EMPTY, LEFT.filing_type_desc, RIGHT.filing_type_desc ),
				SELF.amount                     := IF( LEFT.amount != DueDiligence.Constants.ZERO, LEFT.amount, RIGHT.amount ), 
				   //***Only keep the release date if it is prior to the history date
				SELF.release_date               := IF( LEFT.release_date != DueDiligence.Constants.EMPTY AND LEFT.release_date > RIGHT.release_date 
				                                   AND ((INTEGER)LEFT.release_date[1..6]) <= LEFT.HistoryDate, LEFT.release_date, RIGHT.release_date ), 
				SELF.lapse_date                 := IF( LEFT.lapse_date != DueDiligence.Constants.EMPTY AND LEFT.lapse_date > RIGHT.lapse_date, 
				                                       LEFT.lapse_date, 
																							 RIGHT.lapse_date ),
				SELF.agency                     := IF( LEFT.agency        != DueDiligence.Constants.EMPTY, LEFT.agency, RIGHT.agency),
				SELF.agency_state               := IF( LEFT.agency_state  != DueDiligence.Constants.EMPTY, LEFT.agency_state, RIGHT.agency_state),
				SELF.agency_county              := IF( LEFT.agency_county != DueDiligence.Constants.EMPTY, LEFT.agency_county, RIGHT.agency_county),
				SELF.filing_jurisdiction        := IF( LEFT.filing_jurisdiction != DueDiligence.Constants.EMPTY, LEFT.filing_jurisdiction, RIGHT.filing_jurisdiction),
				SELF.filing_status              := IF(TRIM(RIGHT.filing_status) != DueDiligence.Constants.EMPTY, RIGHT.filing_status, LEFT.filing_status ),
			)
		);
			
  

	// ------                                                                                    ------
	// ----- Take 1 more pass through the list and catagorize of calculate the age               ------
	// ------                                                                                    ------                                                                       
	
	 BusinessLiens_categorized      := PROJECT(BusinessLiens_rolled,
			   TRANSFORM(DueDiligence.LayoutsInternal.layout_liens_judgments_categorized,             //***Note this is layout used for liens against a business
				   SELF.lien_type_category     := DueDiligence.Common.getLienTypeCategory(LEFT.filing_type_desc), 
				   SELF.judgment_type_category := DueDiligence.Common.getJudgmentTypeCategory(LEFT.filing_type_desc),
				   SELF.filing_status_category := DueDiligence.Common.getFilingStatusCategory(LEFT.filing_status),
				  	 /*  Things to Note:  
                        The date first seen is already the oldest one in the file after the ROLLUP 
                        The date first seen has already been cleanned  
                        DateToUse is either the history date for achive mode or the current date for CURRENT MODE  
        */  
				   SELF.NumOfDaysAgo           := DueDiligence.Common.DaysApartWithZeroEmptyDate(LEFT.date_first_seen, (STRING)LEFT.DateToUse),
				   SELF                        := LEFT,
				   SELF                        := [])); 	
	 
	 
	
  // ------                                                                                    ------	
	 // ------                                                                                    ------
	 // ----- Summarize the results in scope for these liens and judgments                        ------
	 // ------                                                                                    ------
	
   lienJudgementCounts := PROJECT(BusinessLiens_categorized, TRANSFORM({DueDiligence.LayoutsInternal.InternalBIPIDsLayout, UNSIGNED historyDate, UNSIGNED dateToUse, 
                                                                                    UNSIGNED totalEvictions, UNSIGNED totalEvictionsOver3Yrs, UNSIGNED totalEvictionsPast3Yrs, 
                                                                                    UNSIGNED totalUnreleasedLiens, UNSIGNED totalUnreleasedLiensOver3Yrs, UNSIGNED totalUnreleasedLiensPast3Yrs, 
                                                                                    UNSIGNED totalReleasedLiens},
	                               /* columns in the table */  
                                                                       SELF.seq := LEFT.liensJudgment.seq;
                                                                       SELF.ultID := LEFT.liensJudgment.ultid;
                                                                       SELF.orgID := LEFT.liensJudgment.orgid;
                                                                       SELF.seleID := LEFT.liensJudgment.seleid;
																																			 
                                                                       SELF.totalEvictions := (INTEGER)(LEFT.eviction = DueDiligence.Constants.YES AND LEFT.release_date = DueDiligence.Constants.EMPTY);
                                                                       SELF.totalEvictionsOver3Yrs := (INTEGER)(LEFT.eviction = DueDiligence.Constants.YES  AND  LEFT.NumOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK) AND LEFT.release_date = DueDiligence.Constants.EMPTY);
                                                                       SELF.totalEvictionsPast3Yrs := (INTEGER)(LEFT.eviction = DueDiligence.Constants.YES  AND  LEFT.NumOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK) AND LEFT.release_date = DueDiligence.Constants.EMPTY);
																
                                                                       SELF.totalUnreleasedLiens := (INTEGER)(LEFT.eviction != DueDiligence.Constants.YES AND LEFT.release_date = DueDiligence.Constants.EMPTY);
                                                                       SELF.totalUnreleasedLiensOver3Yrs := (INTEGER)(LEFT.eviction != DueDiligence.Constants.YES 	AND   LEFT.NumOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK) AND LEFT.release_date = DueDiligence.Constants.EMPTY);
                                                                       SELF.totalUnreleasedLiensPast3Yrs := (INTEGER)(LEFT.eviction != DueDiligence.Constants.YES   AND  LEFT.NumOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK) AND LEFT.release_date = DueDiligence.Constants.EMPTY);
																/* if evictions flag is anything other than a 'Y' it will get counted as a lien  */   
                                                                       SELF.totalReleasedLiens := (INTEGER)(LEFT.eviction != DueDiligence.Constants.YES AND LEFT.release_date != DueDiligence.Constants.EMPTY);
																/* Grouped by */  
                                                                       SELF := LEFT;
                                                                       SELF := [];)); 
																
  sortlienJudgementCounts := SORT(lienJudgementCounts, seq, ultID, orgID, seleID);
	// ----                                                                                 ------	
  Summary_BusinessLiens := ROLLUP(sortlienJudgementCounts,
                      #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
                      TRANSFORM(RECORDOF(LEFT),
                                SELF.totalEvictions := LEFT.totalEvictions + RIGHT.totalEvictions;
                                SELF.totalEvictionsOver3Yrs := LEFT.totalEvictionsOver3Yrs + RIGHT.totalEvictionsOver3Yrs;
                                SELF.totalEvictionsPast3Yrs := LEFT.totalEvictionsPast3Yrs + RIGHT.totalEvictionsPast3Yrs;
	// ----  JOIN Summary to the Business Internal layout                                   ------
                                SELF.totalUnreleasedLiens := LEFT.totalUnreleasedLiens + RIGHT.totalUnreleasedLiens;
                                SELF.totalUnreleasedLiensOver3Yrs := LEFT.totalUnreleasedLiensOver3Yrs + RIGHT.totalUnreleasedLiensOver3Yrs;
                                SELF.totalUnreleasedLiensPast3Yrs := LEFT.totalUnreleasedLiensPast3Yrs + RIGHT.totalUnreleasedLiensPast3Yrs;
	// ----                                                                                 ------																									
                                SELF.totalReleasedLiens := LEFT.totalReleasedLiens + RIGHT.totalReleasedLiens;
                                
                                SELF := LEFT;));
																
	// ----                                                                                 ------	
	// ----  JOIN Summary to the Business Internal layout                                   ------
	// ----                                                                                 ------																									
	Update_BusnLiens := JOIN(BusnData, Summary_BusinessLiens,
												#EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),												
												TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																	SELF.Business.liensUnreleasedCnt              := RIGHT.TotalUnreleasedLiens,
																	SELF.Business.liensUnreleasedCntOVNYR         := RIGHT.totalUnreleasedLiensOver3Yrs,
																	SELF.Business.liensUnreleasedCntInThePastNYR  := RIGHT.totalUnreleasedLiensPast3Yrs,
																	
                                  SELF.Business.liensReleasedCnt                := RIGHT.totalReleasedLiens;
																	
																	SELF.Business.evictionsCnt                    := RIGHT.TotalEvictions,
																	SELF.Business.evictionsCntOVNYR               := RIGHT.totalEvictionsOver3Yrs,
																	SELF.Business.evictionsCntInThePastNYR        := RIGHT.totalEvictionsPast3Yrs,
																	SELF := LEFT),
																	LEFT OUTER);

	  
	 // ----- If the report is requested by the XML Service (not allowed by Batch)                -----
	 // ----- THEN add the liens and judgement data to that section of the report.                -----
	 // ----- ELSE just leave the reporting sections empty                                        -----
	 // -----                                                                                     -----
	UpdateBusnLiensWithReport  := IF(ReportIsRequested, 
                                  /* Pass both released and unreleased liens to the business report  */ 
                                  DueDiligence.reportBusLien(Update_BusnLiens, BusinessLiens_categorized, DebugMode),
																			             /* ELSE */ 
																			 Update_BusnLiens); 
		
	
	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	
	// IF(DebugMode,    OUTPUT(CHOOSEN (BusinessLiensTMSIDSeq, 10),            NAMED('BusinessLiensTMSIDSeq')));
	// IF(DebugMode,    OUTPUT(CHOOSEN (BusinessLiensTMSID, 10),               NAMED('BusinessLiensTMSID')));
	// IF(DebugMode,    OUTPUT(CHOOSEN (BusinessLiens_main, 10),               NAMED('BusinessLiens_main')));
	// IF(DebugMode,    OUTPUT(CHOOSEN (BusinessLiens_rolled, 10),             NAMED('BusinessLiens_rolled')));
	IF(DebugMode,    OUTPUT(CHOOSEN (BusinessLiens_categorized, 10),        NAMED('BusinessLiens_categorized')));
	//IF(DebugMode,    OUTPUT(CHOOSEN (Update_BusnLiens, 10),                  NAMED('Update_BusnLiens')));  
	

	

	RETURN UpdateBusnLiensWithReport;
	 
END;





