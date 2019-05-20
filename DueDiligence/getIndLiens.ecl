Import RiskWise, liensv2, STD, Business_Risk_BIP;



export getIndLiens(DATASET(DueDiligence.LayoutsInternal.RelatedParty) Individuals ,
                           boolean debugmode = false,  
													 boolean isFCRA = false
  													) := FUNCTION


//kld			    := liensv2.key_liens_DID;
//klr_nonFCRA	:= liensv2.key_liens_party_id;


  
IndividualLiensStep1  := JOIN(Individuals, liensv2.key_liens_DID, 
                    keyed(LEFT.party.did = RIGHT.did), 
										TRANSFORM (DueDiligence.LayoutsInternal.LiensLayout_by_DID,
										          self.tmsid             := RIGHT.tmsid,
	                            SELF.rmsid             := RIGHT.rmsid,
															/* pass everything else from the left */
															SELF.did               := LEFT.party.did,
															self.historyDate       := LEFT.Historydate,
			                        /* Essentially this is today's date if history date is all 9's OR the history date itself */    
	                            SELF.DateToUse         := DueDiligence.Common.GetMyDate(LEFT.historydate),	
	                            SELF                   := LEFT,
	                            SELF                   := []),   //All other fields will get populated in further processing
										LEFT OUTER, KEEP(500),
					          ATMOST(keyed(left.party.did=right.did), Riskwise.max_atmost));
					
					
  // ------                                                                                    ------
	// ------ Join the business executives with the key_liens_party_id  to                       ------ 
  // ------ pick up a list of tmsid and rmsid's for this DID                                   ------
	// ------                                                                                    ------ 			
					


IndividualLiensStep2 := JOIN (IndividualLiensStep1, liensv2.key_liens_party_id, 
                    LEFT.rmsid<>'' 
										  AND
                    KEYED(LEFT.tmsid = RIGHT.tmsid) 
										  AND 
										KEYED(LEFT.rmsid = RIGHT.rmsid) 
										  AND
										RIGHT.name_type = DueDiligence.Constants.NAME_TYPE, 
										//AND 
										//(unsigned3)(RIGHT.date_first_seen) < left.DateToUse,
										TRANSFORM (DueDiligence.LayoutsInternal.LiensLayout_by_DID,
										         /* Pick up the date first seen and date last seen */  
										         /* Make sure the date has been cleaned */  
                             self.date_first_seen           := RIGHT.date_first_seen,
	                           self.date_last_seen            := RIGHT.date_last_seen,
                              /* create a new intermediate resultset */ 
			                        /* populate the data from the LEFT     */  
			                       self.did                       := LEFT.did,
	                           self.seq                       := LEFT.seq,           //This is the sequence number that ties us back to the BIP ID's
			                       self.historyDate               := LEFT.Historydate,
														 /* continue to carry the fields on the LEFT forward through the process */ 
                             SELF                           := LEFT),
										LEFT OUTER, KEEP(DueDiligence.Constants.MAX_KEEP),
				            ATMOST(keyed(left.tmsid = right.tmsid) and keyed(left.rmsid = right.rmsid), 
										       Riskwise.max_atmost));
  // ------                                                                                    ------
	// ------ Get Liens main records.                                                            ------
	// ------                                                                                    ------
	// ------                                                                                    ------
	IndividualLiensStep3 :=
		JOIN(
			IndividualLiensStep2, LiensV2.key_liens_main_ID,
			KEYED( LEFT.tmsid = RIGHT.tmsid AND
			       LEFT.rmsid = RIGHT.rmsid),
			TRANSFORM(DueDiligence.LayoutsInternal.LiensLayout_by_DID,
			  /* create the next intermediate resultset */
				/* populate the data from the LEFT     */  
				SELF.seq                                 := LEFT.seq,
				SELF.did                                 := LEFT.did,		
				SELF.HistoryDate			                   := LEFT.HistoryDate,
				/* Essentially this is today's date if history date is all 9's OR the history date itself */   
				SELF.DateToUse                           := LEFT.DateToUse,
				SELF.date_first_seen                     := LEFT.date_first_seen,
				SELF.date_last_seen                      := LEFT.date_last_seen,
				/* populate the data from RIGHT           */   
				SELF.filing_type_desc                    := RIGHT.filing_type_desc,
				SELF.filing_status                       := RIGHT.filing_status[1].filing_status_desc,
				/* represent Amounts in whole dollars.*/ 
				SELF.amount                              := (STRING11)(TRUNCATE(((REAL)RIGHT.amount))),
				/*   make sure the release date is BEFORE the History Date   */   
				SELF.release_date                        := MAP(((INTEGER)RIGHT.release_date[1..6]) <= LEFT.HistoryDate	=> RIGHT.release_date,
																		               ((INTEGER)LEFT.date_last_seen[1..6]) <= LEFT.HistoryDate	=> LEFT.date_last_seen,
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
 IndividualLiensStep4 := 
		SORT( IndividualLiensStep3, seq, did,  
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
	IndividualLiensStep5 :=
		ROLLUP(
			IndividualLiensStep4,
			LEFT.seq     = RIGHT.seq AND
			LEFT.did     = RIGHT.did AND
			LEFT.tmsid   = RIGHT.tmsid,
			TRANSFORM(DueDiligence.LayoutsInternal.LiensLayout_by_DID,
				SELF.seq          := LEFT.seq,
				SELF.rmsid        := LEFT.rmsid, 
				SELF.did          := LEFT.did,
				SELF.HistoryDate			          := LEFT.HistoryDate,
				SELF.DateToUse                  := LEFT.DateToUse,
				SELF.NumOfDaysAgo               := 0,    
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

				SELF.release_date               := IF( LEFT.release_date != DueDiligence.Constants.EMPTY AND LEFT.release_date > RIGHT.release_date 
				                                   AND ((INTEGER)LEFT.release_date[1..6]) <= LEFT.HistoryDate, LEFT.release_date, RIGHT.release_date ), 
				SELF.lapse_date                 := IF( LEFT.lapse_date != DueDiligence.Constants.EMPTY AND LEFT.lapse_date > RIGHT.lapse_date, 
				                                       LEFT.lapse_date, 
																							 RIGHT.lapse_date ),
				SELF.agency_state               := IF( LEFT.agency_state != DueDiligence.Constants.EMPTY, LEFT.agency_state, RIGHT.agency_state ),
				SELF.filing_status              := IF(TRIM(RIGHT.filing_status) != DueDiligence.Constants.EMPTY, RIGHT.filing_status, LEFT.filing_status ),
			)
		);
			
  // ----                                                                                 ------	
	// ----  Categorize each Lien by filing_type_desc and filing_status.                    ------
	// ----                                                                                 ------

  IndividualLiensStep6 := PROJECT(IndividualLiensStep5,
			TRANSFORM(DueDiligence.LayoutsInternal.ByDID_liens_judgments_categorized,
				SELF.lien_type_category     := DueDiligence.Common.getLienTypeCategory(LEFT.filing_type_desc), 
				SELF.judgment_type_category := DueDiligence.Common.getJudgmentTypeCategory(LEFT.filing_type_desc),
				SELF.filing_status_category := DueDiligence.Common.getFilingStatusCategory(LEFT.filing_status),
					/*  Things to Note:  
                        The date first seen is already the oldest one in the file after the ROLLUP 
                        The date first seen has already been cleanned by the DueDiligence.Common.FilterRecords
                        DateToUse is either the history date for achive mode or the current date for CURRENT MODE  
          */  
				SELF.NumOfDaysAgo           := DueDiligence.Common.DaysApartWithZeroEmptyDate(LEFT.date_first_seen, (STRING)LEFT.DateToUse),
				SELF                        := LEFT,
				SELF                        := [])); 	

    liens_judgments_unreleased     := IndividualLiensStep6(release_date = ''); 
		
		
		Summary_LiensJudgments_ByDID := table(IndividualLiensStep6,
	                               /* columns in the table */  
	                              {seq, 
																 did, 
																 HistoryDate,
																 DateToUse,
																 TotalEvictions               := #EXPAND (DueDiligence.Constants.mac_calculate_evictions()),
																 TotalEvictionsOVNYR          := #EXPAND (DueDiligence.Constants.mac_calculate_evictions_OVNYR()),																								 
																 TotalEvictionsNYR            := #EXPAND (DueDiligence.Constants.mac_calculate_evictionsNYR()),
																																										 
																 TotalLienAmount              := SUM(GROUP, (integer)amount), 
																
																/* if evictions flag is anything other than a 'Y' it will get counted as a lien  */   
																TotalUnreleasedLiens         := #EXPAND (DueDiligence.Constants.mac_calculate_liens()),
																TotalUnreleasedLiensOVNYR    := #EXPAND (DueDiligence.Constants.mac_calculate_liens_OVNYR()),											 
																TotalUnreleasedLiensNYR      := #EXPAND (DueDiligence.Constants.mac_calculate_liensNYR()),
															  /*end of columns in the table */ },
																/* Grouped by */  
																seq, did);

  // ------                                                                                    ------
	// ------ Do the final join back to the businessExecutives input                             ------ 
  // ------ with the liens released and un-released                                            ------
	// ------                                                                                    ------ 	
UpdateRelatedParty := join(Individuals, Summary_LiensJudgments_ByDID,
									left.seq       = right.seq and
									left.party.did = right.did,
									//left.origdid = right.origdid,
									transform(DueDiligence.LayoutsInternal.RelatedParty,
														self.party.liensUnreleasedCnt              := RIGHT.TotalUnreleasedLiens,
														self.party.liensUnreleasedCntOVNYR         := RIGHT.TotalUnreleasedLiensOVNYR,
														self.party.liensUnreleasedCntInThePastNYR  := RIGHT.TotalUnreleasedLiensNYR,
														SELF.party.evictionsCnt                    := RIGHT.TotalEvictions,
														SELF.party.evictionsCntOVNYR               := RIGHT.TotalEvictionsOVNYR,
														SELF.party.evictionsCntInThePastNYR        := RIGHT.TotalEvictionsNYR,
														self := left),
									left outer);
																							
									
  // ********************
	//   DEBUGGING OUTPUTS
	// ********************
	   	   	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(IndividualLiensStep1, 50),                NAMED('IndividualLiensStep1')));    	   	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(IndividualLiensStep2, 50),                NAMED('IndividualLiensStep2')));    	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(IndividualLiensStep3, 50),                NAMED('IndividualLiensStep3')));    	  	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(IndividualLiensStep4, 50),                NAMED('IndividualLiensStep4')));    	  	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(IndividualLiensStep5, 50),                NAMED('IndividualLiensStep5')));    	  	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(IndividualLiensStep6, 50),                NAMED('IndividualLiensStep6')));    	  	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(Summary_LiensJudgments_ByDID, 50),        NAMED('Summary_LiensJudgments_ByDID')));    	   	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(UpdateRelatedParty, 50),                  NAMED('UpdateRelatedParty')));    	 


RETURN UpdateRelatedParty;

END;