IMPORT BIPv2, doxie, DueDiligence, liensV2, Risk_Indicators, Suppress, ut;

/*
	Following Keys being used:
			liensV2.key_liens_main_ID
*/

EXPORT getSharedLiensJudgementsEvictions(DATASET(DueDiligence.LayoutsInternal.SharedSlimLiens) inData,
                                         doxie.IDataAccess mod_access) := FUNCTION

    getLienTypeCategory(STRING filingTypeDesc) := FUNCTION

        lienTypeCategory := MAP(filingTypeDesc IN Risk_Indicators.iid_constants.set_Invalid_Liens_50 => DueDiligence.Constants.INVALID_LIEN, //'IN'
                                filingTypeDesc IN Risk_Indicators.iid_constants.setSuits => DueDiligence.Constants.SUITS, //'SU'
                                filingTypeDesc IN Risk_Indicators.iid_constants.setSmallClaims => DueDiligence.Constants.SMALL_CLAIMS, //'SC'
                                filingTypeDesc IN Risk_Indicators.iid_constants.setFederalTax => DueDiligence.Constants.FEDERAL_TAX, //'FX'
                                filingTypeDesc IN Risk_Indicators.iid_constants.setForeclosure => DueDiligence.Constants.FORECLOSURE, //'FC'
                                filingTypeDesc IN Risk_Indicators.iid_constants.setLandlordTenant => DueDiligence.Constants.LANDLORD_TENANT, //'LT'
                                filingTypeDesc IN Risk_Indicators.iid_constants.setLisPendens => DueDiligence.Constants.LISPENDENS, //'LP',
                                filingTypeDesc IN Risk_Indicators.iid_constants.setMechanicsLiens => DueDiligence.Constants.MECHANICS_LIEN, //'ML',
                                filingTypeDesc IN Risk_Indicators.iid_constants.setCivilJudgment => DueDiligence.Constants.CIVIL_JUDGMENT, //'CJ',
                                filingTypeDesc IN Risk_Indicators.iid_constants.setOtherTax => DueDiligence.Constants.OTHER_TAX, //'OX',
                                filingTypeDesc NOT IN [Risk_Indicators.iid_constants.setCivilJudgment + Risk_Indicators.iid_constants.setFederalTax + 
                                                       Risk_Indicators.iid_constants.setLandlordTenant + Risk_Indicators.iid_constants.setSmallClaims + 
                                                       Risk_Indicators.iid_constants.setForeclosure + Risk_Indicators.iid_constants.setOtherTax] => DueDiligence.Constants.DEFAULT_LIEN_CATAGORY,  //'OT',
                                DueDiligence.Constants.DEFAULT_LIEN_CATAGORY); //'OT' is default

        RETURN lienTypeCategory;
    END;


    getJudgmentTypeCategory(STRING filingTypeDesc) := FUNCTION

        judgmentTypeCategory := MAP(filingTypeDesc IN Risk_Indicators.iid_constants.set_Invalid_Liens_50 => DueDiligence.Constants.INVALID_JUDGMENT, //'Invalid',
                                    filingTypeDesc IN Risk_Indicators.iid_constants.setSuits => DueDiligence.Constants.JUDGMENT, //'Judgment',
                                    filingTypeDesc IN Risk_Indicators.iid_constants.setSmallClaims => DueDiligence.Constants.JUDGMENT, //'Judgment',
                                    filingTypeDesc IN Risk_Indicators.iid_constants.setFederalTax => DueDiligence.Constants.LIEN, //'Lien',
                                    filingTypeDesc IN Risk_Indicators.iid_constants.setForeclosure => DueDiligence.Constants.LIEN, //'Lien', 
                                    filingTypeDesc IN Risk_Indicators.iid_constants.setLandlordTenant => DueDiligence.Constants.LIEN, //'Lien',
                                    filingTypeDesc IN Risk_Indicators.iid_constants.setLisPendens => DueDiligence.Constants.LIEN, //'Lien',
                                    filingTypeDesc IN Risk_Indicators.iid_constants.setOtherTax => DueDiligence.Constants.LIEN, //'Lien',
                                    filingTypeDesc IN Risk_Indicators.iid_constants.setMechanicsLiens => DueDiligence.Constants.LIEN, //'Lien',
                                    filingTypeDesc IN Risk_Indicators.iid_constants.setCivilJudgment => DueDiligence.Constants.JUDGMENT, //'Judgment',
                                    filingTypeDesc NOT IN [Risk_Indicators.iid_constants.setCivilJudgment + Risk_Indicators.iid_constants.setFederalTax + 
                                                           Risk_Indicators.iid_constants.setLandlordTenant + Risk_Indicators.iid_constants.setOtherTax + 
                                                           Risk_Indicators.iid_constants.setSmallClaims + Risk_Indicators.iid_constants.setForeclosure] => DueDiligence.Constants.LIEN,
                                    DueDiligence.Constants.LIEN); //default
                
        RETURN judgmentTypeCategory;
    END;

    getFilingStatusCategory(STRING filingStatus) := FUNCTION

        filingStatusCategory := MAP(filingStatus IN DueDiligence.Constants.filing_status_satisfied => DueDiligence.Constants.SATISFIED,
                                    filingStatus IN DueDiligence.Constants.filing_status_dismissed => DueDiligence.Constants.DISMISS,
                                    filingStatus = DueDiligence.Constants.UNLAPSED_UPPER => DueDiligence.Constants.UNLAPSED_LOWER,
                                    filingStatus = DueDiligence.Constants.LAPSED_UPPER  => DueDiligence.Constants.LAPSED_LOWER,
                                    filingStatus NOT IN [DueDiligence.Constants.filing_status_satisfied + DueDiligence.Constants.filing_status_dismissed + 
                                                          [DueDiligence.Constants.UNLAPSED_UPPER, DueDiligence.Constants.LAPSED_UPPER]] => DueDiligence.Constants.OTHER_LOWER,
                                    DueDiligence.Constants.EMPTY); 
                                      
        RETURN filingStatusCategory; 
    END;




 
    
    
    mainLiensUnsuppressed := JOIN(inData, liensV2.key_liens_main_ID,
                                  KEYED(LEFT.tmsid = RIGHT.tmsid AND LEFT.rmsid = RIGHT.rmsid),
                                  TRANSFORM(DueDiligence.LayoutsInternal.SharedSlimLiens,
                                            SELF.seq := LEFT.seq;
                                            SELF.ultID := LEFT.ultID;
                                            SELF.orgID := LEFT.orgID;
                                            SELF.seleID := LEFT.seleID;
                                            SELF.did := LEFT.did;
                                            SELF.tmsid := LEFT.tmsid;
                                            SELF.rmsid := LEFT.rmsid;
                                            SELF.HistoryDate := DueDiligence.Common.GetMyDate(LEFT.HistoryDate);
                                            SELF.dateFirstSeen := LEFT.dateFirstSeen;
                                            SELF.dateLastSeen := LEFT.dateLastSeen;
                                               
                                            SELF.global_sid := RIGHT.global_sid;
                                            SELF.filingJurisdiction := RIGHT.filing_jurisdiction;
                                            SELF.filingNumber := RIGHT.filing_number;
                                            SELF.filingTypeDesc := RIGHT.filing_type_desc;
                                            SELF.filingStatus := RIGHT.filing_status[1].filing_status_desc;
                                            SELF.agency := RIGHT.agency;
                                            SELF.agencyState := RIGHT.agency_state;
                                            SELF.agencyCounty := RIGHT.agency_county;
                                            SELF.amount := (STRING11)(TRUNCATE(((REAL)RIGHT.amount))); 
                                            SELF.releaseDate := (UNSIGNED4)RIGHT.release_date;
                                            SELF.eviction := RIGHT.eviction;
                                            SELF.origFilingDate := (UNSIGNED4)RIGHT.orig_filing_date;
                                            SELF.lapseDate := (UNSIGNED4)RIGHT.lapse_date;
                                            SELF := [];), 
                                    ATMOST(DueDiligence.Constants.MAX_ATMOST_1000));
                                    
      
      
    mainLiens := Suppress.Suppress_ReturnOldLayout(mainLiensUnsuppressed, mod_access, DueDiligence.LayoutsInternal.SharedSlimLiens);
                                    
    cleanDates := DueDiligence.Common.CleanDatasetDateFields(mainLiens, 'dateFirstSeen, releaseDate, origFilingDate');  
    
    filterData := DueDiligence.Common.FilterRecordsSingleDate(cleanDates, dateFirstSeen);
    
    calcReleaseDate := PROJECT(filterData, TRANSFORM(DueDiligence.LayoutsInternal.SharedSlimLiens,
                                                      SELF.dateFirstSeen := LEFT.dateFirstSeen;
                                                      SELF.dateLastSeen := LEFT.dateLastSeen;
                                                      SELF.origFilingDate := LEFT.origFilingDate;
                                                      SELF.releaseDate := MAP(LEFT.releaseDate <= LEFT.historyDate => LEFT.releaseDate,
                                                                              LEFT.dateLastSeen <= LEFT.historyDate => LEFT.dateLastSeen,
                                                                              0);
                                                      SELF := LEFT;));
    
      
    mainLiensSorted := SORT(calcReleaseDate, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, tmsid, -origFilingDate, -releaseDate, RECORD);
    
   // Rollup to aggregate to the Liens Level (TMSID)
    // Rules: retain...
	  // ...the oldest (by value) date_first_seen
	  // ...the most recent (by value) date_last_seen
	  // ...any eviction value = 'Y'
	  // ...the oldest (by value) orig_filing_date
	  // ...the most recent (by record order) nonblank filing_type_desc
	  // ...the most recent (by record order) nonzero/nonblank amount 
	  // ...the most recent (by value) release_date 
	  // ...the most recent (by value) lapse_date 
	  // ...the first (by record order) nonblank agency_state
	  // ...the most recent (by record order) nonblank filing_status
    // It's only counted as an eviction if the eviction = 'Y', otherwise it is classified as a lien/judgement 
    mainLiensRolled := ROLLUP(mainLiensSorted,
                              LEFT.seq = RIGHT.seq AND
                              LEFT.ultID = RIGHT.ultID AND
                              LEFT.orgID = RIGHT.orgID AND
                              LEFT.seleID = RIGHT.seleID AND
                              LEFT.did = RIGHT.did AND
                              LEFT.tmsid = RIGHT.tmsid,
                              TRANSFORM(DueDiligence.LayoutsInternal.SharedSlimLiens,
                                        SELF.seq := LEFT.seq,
                                        SELF.ultID := LEFT.ultID;
                                        SELF.orgID := LEFT.orgID;
                                        SELF.seleID := LEFT.seleID;
                                        SELF.did := LEFT.did; 
                                        SELF.tmsid := LEFT.tmsid;
                                        SELF.historyDate := LEFT.historyDate;
                                        
                                        SELF.dateFirstSeen := IF(LEFT.dateFirstSeen <> 0 AND LEFT.dateFirstSeen < RIGHT.dateFirstSeen, LEFT.dateFirstSeen, RIGHT.dateFirstSeen);
                                        SELF.dateLastSeen := MAX(LEFT.dateLastSeen, RIGHT.dateLastSeen);
                                        
                                        SELF.filingNumber := DueDiligence.Common.firstPopulatedString(filingNumber);
                                        SELF.filingJurisdiction := DueDiligence.Common.firstPopulatedString(filingJurisdiction);
                                        SELF.filingTypeDesc := DueDiligence.Common.firstPopulatedString(filingTypeDesc);
                                        SELF.filingStatus := DueDiligence.Common.firstPopulatedString(filingStatus);
                                        
                                        SELF.agency := DueDiligence.Common.firstPopulatedString(agency);
                                        SELF.agencyState := DueDiligence.Common.firstPopulatedString(agencyState);
                                        SELF.agencyCounty := DueDiligence.Common.firstPopulatedString(agencyCounty);
                                        
                                        SELF.amount := DueDiligence.Common.firstPopulatedString(amount); 
                                        SELF.releaseDate := IF(LEFT.releaseDate <> 0 AND LEFT.releaseDate > RIGHT.releaseDate AND LEFT.releaseDate <= LEFT.HistoryDate, LEFT.releaseDate, RIGHT.releaseDate),;
                                        SELF.eviction := MAP(LEFT.eviction = DueDiligence.Constants.EMPTY  => LEFT.eviction, 
                                                             RIGHT.eviction = DueDiligence.Constants.EMPTY => RIGHT.eviction, 
                                                             LEFT.eviction);
                                                             
                                        SELF.origFilingDate := IF(LEFT.origFilingDate <> 0 AND (LEFT.origFilingDate < RIGHT.origFilingDate OR RIGHT.origFilingDate = 0), LEFT.origFilingDate, RIGHT.origFilingDate); 
                                                                               
                                        SELF.lapseDate := MAX(LEFT.lapseDate, RIGHT.lapseDate);                                        
                                        SELF := [];));
                                        
     
    mainLiensCategorized := PROJECT(mainLiensRolled, TRANSFORM(DueDiligence.LayoutsInternal.SharedSlimLiens, 
                                                                 SELF.lienTypeCategory := getLienTypeCategory(LEFT.filingTypeDesc), 
                                                                 SELF.judgmentCategory := getJudgmentTypeCategory(LEFT.filingTypeDesc),
                                                                 SELF.filingStatusCategory := getFilingStatusCategory(LEFT.filingStatus),
                                                                
                                                                 numOfDaysAgo := DueDiligence.CommonDate.DaysApartAccountingForZero((STRING)LEFT.dateFirstSeen, (STRING)LEFT.historyDate);
                                                                 
                                                                 SELF.totalEvictions := (INTEGER)(LEFT.eviction = DueDiligence.Constants.YES AND LEFT.releaseDate = 0);
                                                                 SELF.totalEvictionsOver3Yrs := (INTEGER)(LEFT.eviction = DueDiligence.Constants.YES AND numOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK) AND LEFT.releaseDate = 0);
                                                                 SELF.totalEvictionsPast3Yrs := (INTEGER)(LEFT.eviction = DueDiligence.Constants.YES AND numOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK) AND LEFT.releaseDate = 0);
                          
                                                                 SELF.totalUnreleasedLiens := (INTEGER)(LEFT.eviction != DueDiligence.Constants.YES AND LEFT.releaseDate = 0);
                                                                 SELF.totalUnreleasedLiensOver3Yrs := (INTEGER)(LEFT.eviction != DueDiligence.Constants.YES AND numOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK) AND LEFT.releaseDate = 0);
                                                                 SELF.totalUnreleasedLiensPast3Yrs := (INTEGER)(LEFT.eviction != DueDiligence.Constants.YES AND numOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK) AND LEFT.releaseDate = 0);
                                                                  
                                                                 SELF.totalReleasedLiens := (INTEGER)(LEFT.eviction != DueDiligence.Constants.YES AND LEFT.releaseDate != 0);

                                                                 SELF := LEFT,
                                                                 SELF := [])); 
                                                                 
                                                                 
    sortLienJudgementCounts := SORT(mainLiensCategorized, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
    
    summaryLiens := ROLLUP(sortLienJudgementCounts,
                            #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                            LEFT.did = RIGHT.did,
                            TRANSFORM(RECORDOF(LEFT),
                                      SELF.totalEvictions := LEFT.totalEvictions + RIGHT.totalEvictions;
                                      SELF.totalEvictionsOver3Yrs := LEFT.totalEvictionsOver3Yrs + RIGHT.totalEvictionsOver3Yrs;
                                      SELF.totalEvictionsPast3Yrs := LEFT.totalEvictionsPast3Yrs + RIGHT.totalEvictionsPast3Yrs;
                                      
                                      SELF.totalUnreleasedLiens := LEFT.totalUnreleasedLiens + RIGHT.totalUnreleasedLiens;
                                      SELF.totalUnreleasedLiensOver3Yrs := LEFT.totalUnreleasedLiensOver3Yrs + RIGHT.totalUnreleasedLiensOver3Yrs;
                                      SELF.totalUnreleasedLiensPast3Yrs := LEFT.totalUnreleasedLiensPast3Yrs + RIGHT.totalUnreleasedLiensPast3Yrs;
                                      
                                      SELF.totalReleasedLiens := LEFT.totalReleasedLiens + RIGHT.totalReleasedLiens;
                                      
                                      SELF := LEFT;));





    // OUTPUT(mainLiensUnsuppressed, NAMED('mainLiensUnsuppressed'));
    // OUTPUT(mainLiens, NAMED('mainLiens'));
    // OUTPUT(cleanDates, NAMED('cleanDates'));
    // OUTPUT(filterData, NAMED('filterData'));
    // OUTPUT(mainLiensSorted, NAMED('mainLiensSorted'));
    // OUTPUT(mainLiensRolled, NAMED('mainLiensRolled'));
    // OUTPUT(mainLiensCategorized, NAMED('mainLiensCategorized'));
    // OUTPUT(sortLienJudgementCounts, NAMED('sortLienJudgementCounts'));
    // OUTPUT(summaryLiens, NAMED('summaryLiens'));


    RETURN summaryLiens;
END;