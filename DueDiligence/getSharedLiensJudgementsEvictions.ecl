IMPORT BIPv2, doxie, DueDiligence, liensV2, Suppress, ut;

/*
	Following Keys being used:
      liensv2.key_liens_party_id
      liensV2.key_liens_main_ID
*/

EXPORT getSharedLiensJudgementsEvictions(DATASET(DueDiligence.LayoutsInternal.SharedSlimLiens) inData,
                                         doxie.IDataAccess mod_access) := FUNCTION




    //CONSTANTS
    PARTY_TYPE_DEBTOR := 'D';
    PARTY_TYPE_CREDITOR := 'C';
    PARTY_TYPE_SET := [PARTY_TYPE_DEBTOR, PARTY_TYPE_CREDITOR];
    





    
    lienInfo := JOIN(inData, liensv2.key_liens_party_id, 
                          LEFT.rmsid <> DueDiligence.Constants.EMPTY AND
                          KEYED(LEFT.tmsid = RIGHT.tmsid) AND 
                          KEYED(LEFT.rmsid = RIGHT.rmsid),
                          TRANSFORM(DueDiligence.LayoutsInternal.SharedSlimLiens, 
                                     SELF.dateFirstSeen := (UNSIGNED4)RIGHT.date_first_seen;
                                     SELF.dateLastSeen := (UNSIGNED4)RIGHT.date_last_seen;
                                     
                                     SELF.nameType := RIGHT.name_type;
                                     SELF.taxID := MAX(RIGHT.ssn, RIGHT.tax_id);
                                     SELF.partyLexID := MAX((UNSIGNED)RIGHT.seleID, (UNSIGNED)RIGHT.did);
                                     
                                     SELF.firstName := RIGHT.fname;
                                     SELF.middleName := RIGHT.mname;
                                     SELF.lastName := RIGHT.lname;
                                     SELF.suffix := RIGHT.name_suffix;
                                     SELF.fullName := RIGHT.cname;
                                     
                                     SELF.prim_range := RIGHT.prim_range;
                                     SELF.predir := RIGHT.predir;
                                     SELF.prim_name := RIGHT.prim_name;
                                     SELF.addr_suffix := RIGHT.addr_suffix;
                                     SELF.postdir := RIGHT.postdir;
                                     SELF.unit_desig := RIGHT.unit_desig;
                                     SELF.sec_range := RIGHT.sec_range;
                                     SELF.city := RIGHT.v_city_name;
                                     SELF.state := RIGHT.st;
                                     SELF.zip5 := RIGHT.zip;
                                     SELF.zip4 := RIGHT.zip4;
                                     SELF.county := RIGHT.county[DueDiligence.Constants.FIRST_POS..DueDiligence.Constants.LAST_POS];
                                     
                                     SELF := LEFT;),
                          KEEP(DueDiligence.Constants.MAX_ATMOST_1000),
                          ATMOST(KEYED(LEFT.tmsid = RIGHT.tmsid) AND KEYED(LEFT.rmsid = RIGHT.rmsid), DueDiligence.Constants.MAX_ATMOST_1000));
                          

    calcAddrCounty := DueDiligence.CommonAddress.GetAddressCounty(lienInfo);
                          
                          
    mainLiensUnsuppressed := JOIN(calcAddrCounty, liensV2.key_liens_main_ID,
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
                                            SELF.filingAmount := (STRING11)(TRUNCATE(((REAL)RIGHT.amount))); 
                                            SELF.releaseDate := (UNSIGNED4)RIGHT.release_date;
                                            SELF.eviction := RIGHT.eviction;
                                            SELF.filingDate := (UNSIGNED4)RIGHT.orig_filing_date;
                                            SELF.lapseDate := (UNSIGNED4)RIGHT.lapse_date;
                                            
                                            SELF.countyName := LEFT.countyNameText;
                                            
                                            SELF := LEFT;), 
                                    ATMOST(DueDiligence.Constants.MAX_ATMOST_1000));
                                    
      
      
    mainLiens := Suppress.Suppress_ReturnOldLayout(mainLiensUnsuppressed, mod_access, DueDiligence.LayoutsInternal.SharedSlimLiens);
                                    
    cleanDates := DueDiligence.Common.CleanDatasetDateFields(mainLiens, 'dateFirstSeen, dateLastSeen, releaseDate, filingDate');  
    
    filterData := DueDiligence.CommonDate.FilterRecordsSingleDate(cleanDates, dateFirstSeen);
    
    calcReleaseDate := PROJECT(filterData, TRANSFORM(DueDiligence.LayoutsInternal.SharedSlimLiens,
                                                      SELF.dateFirstSeen := LEFT.dateFirstSeen;
                                                      SELF.dateLastSeen := LEFT.dateLastSeen;
                                                      SELF.filingDate := LEFT.filingDate;
                                                      SELF.releaseDate := MAP(LEFT.releaseDate <= LEFT.historyDate => LEFT.releaseDate,
                                                                              LEFT.dateLastSeen <= LEFT.historyDate => LEFT.dateLastSeen,
                                                                              0);
                                                      SELF := LEFT;));
    
      
    sortParties  := SORT(calcReleaseDate(nameType in PARTY_TYPE_SET), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, tmsid, rmsid, nameType, partyLexID, taxID, fullName, firstName, -middleName, lastName, -dateLastSeen);
    
    rollParty := ROLLUP(sortParties,
                        LEFT.seq = RIGHT.seq AND  
                        LEFT.ultID = RIGHT.ultID AND  
                        LEFT.orgID = RIGHT.orgID AND  
                        LEFT.seleID = RIGHT.seleID AND 
                        LEFT.did = RIGHT.did AND
                        LEFT.tmsid = RIGHT.tmsid AND  
                        LEFT.rmsid = RIGHT.rmsid AND
                        LEFT.NameType = RIGHT.NameType AND
                        LEFT.partyLexID = RIGHT.partyLexID AND
                        LEFT.taxID = RIGHT.taxID AND
                        LEFT.fullName = RIGHT.fullName AND
                        LEFT.lastName = RIGHT.lastName AND
                        LEFT.firstname = RIGHT.firstName,
                        TRANSFORM(DueDiligence.LayoutsInternal.SharedSlimLiens,
                                   SELF.firstName := IF(LEFT.firstName = DueDiligence.Constants.EMPTY, RIGHT.firstName, LEFT.firstName);
                                   SELF.middleName := IF(LEFT.middleName = DueDiligence.Constants.EMPTY, RIGHT.middleName, LEFT.middleName);
                                   SELF.lastName := IF(LEFT.lastName  = DueDiligence.Constants.EMPTY, RIGHT.lastName,  LEFT.lastName);
                                   SELF.fullName := IF(LEFT.fullName  = DueDiligence.Constants.EMPTY, RIGHT.fullName, LEFT.fullName);
                                   SELF.taxID := IF(LEFT.taxID = DueDiligence.Constants.EMPTY, RIGHT.taxID, LEFT.taxID);  
                                   SELF := LEFT)); 
                                   

    transformParties := PROJECT(rollParty, TRANSFORM(DueDiligence.LayoutsInternal.SharedSlimLiens,
                                                      SELF.debtors := IF(LEFT.nameType = PARTY_TYPE_DEBTOR, DATASET([TRANSFORM(DueDiligence.Layouts.DIDNameAddrTaxID,
                                                                                                                                SELF.did := LEFT.partyLexID;
                                                                                                                                SELF := LEFT;)]));
                                                                                                                                
                                                      SELF.creditors := IF(LEFT.nameType = PARTY_TYPE_CREDITOR, DATASET([TRANSFORM(DueDiligence.Layouts.DIDNameAddrTaxID,
                                                                                                                                    SELF.did := LEFT.partyLexID;
                                                                                                                                    SELF := LEFT;)]));                                                                          
                                                                                                                                
                                                      SELF := LEFT;));
                                                      
                                                      
    sortLiens := SORT(transformParties, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, tmsid, rmsid, -filingDate, -releaseDate, RECORD);
    
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
    liensRolled := ROLLUP(sortLiens,
                              LEFT.seq = RIGHT.seq AND
                              LEFT.ultID = RIGHT.ultID AND
                              LEFT.orgID = RIGHT.orgID AND
                              LEFT.seleID = RIGHT.seleID AND
                              LEFT.did = RIGHT.did AND
                              LEFT.tmsid = RIGHT.tmsid AND
                              LEFT.rmsid = RIGHT.rmsid,
                              TRANSFORM(DueDiligence.LayoutsInternal.SharedSlimLiens,
                                        SELF.seq := LEFT.seq,
                                        SELF.ultID := LEFT.ultID;
                                        SELF.orgID := LEFT.orgID;
                                        SELF.seleID := LEFT.seleID;
                                        SELF.did := LEFT.did; 
                                        SELF.tmsid := LEFT.tmsid;
                                        SELF.historyDate := LEFT.historyDate;
                                        
                                        SELF.dateFirstSeen := MAP(LEFT.dateFirstSeen = 0 AND RIGHT.dateFirstSeen <> 0 => RIGHT.dateFirstSeen,
                                                                  LEFT.dateFirstSeen <> 0 AND RIGHT.dateFirstSeen = 0 => LEFT.dateFirstSeen,
                                                                  MIN(LEFT.dateFirstSeen, RIGHT.dateFirstSeen));

                                        SELF.dateLastSeen := MAX(LEFT.dateLastSeen, RIGHT.dateLastSeen);
                                        
                                        SELF.filingNumber := DueDiligence.Common.firstPopulatedString(filingNumber);
                                        SELF.filingJurisdiction := DueDiligence.Common.firstPopulatedString(filingJurisdiction);
                                        SELF.filingTypeDesc := DueDiligence.Common.firstPopulatedString(filingTypeDesc);
                                        SELF.filingStatus := DueDiligence.Common.firstPopulatedString(filingStatus);
                                        
                                        SELF.agency := DueDiligence.Common.firstPopulatedString(agency);
                                        SELF.agencyState := DueDiligence.Common.firstPopulatedString(agencyState);
                                        SELF.agencyCounty := DueDiligence.Common.firstPopulatedString(agencyCounty);
                                        
                                        SELF.filingAmount := DueDiligence.Common.firstPopulatedString(filingAmount); 
                                        SELF.releaseDate := MAX(LEFT.releaseDate, RIGHT.releaseDate);
                                        SELF.eviction := MAP(LEFT.eviction = DueDiligence.Constants.YES => LEFT.eviction,
                                                             RIGHT.eviction = DueDiligence.Constants.YES => RIGHT.eviction,
                                                             DueDiligence.Common.firstPopulatedString(eviction));
                                                             
                                        SELF.filingDate := MAP(LEFT.filingDate = 0 AND RIGHT.filingDate <> 0 => RIGHT.filingDate,
                                                                LEFT.filingDate <> 0 AND RIGHT.filingDate = 0 => LEFT.filingDate,
                                                                MIN(LEFT.filingDate, RIGHT.filingDate));
                                                                               
                                        SELF.lapseDate := MAX(LEFT.lapseDate, RIGHT.lapseDate);
                                        
                                        SELF.debtors := LEFT.debtors + RIGHT.debtors;
                                        SELF.creditors := LEFT.creditors + RIGHT.creditors;
                                        
                                        SELF := LEFT;));
                                        
     
    mainLiensCategorized := PROJECT(liensRolled, TRANSFORM({DueDiligence.LayoutsInternal.SharedSlimLiens, DATASET(DueDiligence.Layouts.LiensJudgementsEvictionDetails) lje}, 
                                                           
                                                           numOfDaysAgo := DueDiligence.CommonDate.DaysApartWithZeroEmptyDate((STRING)LEFT.dateFirstSeen, (STRING)LEFT.historyDate);
                                                           
                                                           SELF.totalEvictionsOver3Yrs := (INTEGER)(LEFT.eviction = DueDiligence.Constants.YES AND numOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK) AND LEFT.releaseDate = 0);
                                                           SELF.totalEvictionsPast3Yrs := (INTEGER)(LEFT.eviction = DueDiligence.Constants.YES AND numOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK) AND LEFT.releaseDate = 0);
                    
                                                           SELF.totalUnreleasedLiensOver3Yrs := (INTEGER)(LEFT.eviction != DueDiligence.Constants.YES AND numOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK) AND LEFT.releaseDate = 0);
                                                           SELF.totalUnreleasedLiensPast3Yrs := (INTEGER)(LEFT.eviction != DueDiligence.Constants.YES AND numOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK) AND LEFT.releaseDate = 0);
                                                            
                                                           SELF.lje := DATASET([TRANSFORM(DueDiligence.Layouts.LiensJudgementsEvictionDetails, SELF := LEFT;)]);

                                                           SELF := LEFT,
                                                           SELF := [])); 
                                                                 
                                                                 
    sortLienJudgementCounts := SORT(mainLiensCategorized, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, -dateFirstSeen);
    
    summaryLiens := ROLLUP(sortLienJudgementCounts,
                            #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                            LEFT.did = RIGHT.did,
                            TRANSFORM(RECORDOF(LEFT),
                                      SELF.totalEvictionsOver3Yrs := LEFT.totalEvictionsOver3Yrs + RIGHT.totalEvictionsOver3Yrs;
                                      SELF.totalEvictionsPast3Yrs := LEFT.totalEvictionsPast3Yrs + RIGHT.totalEvictionsPast3Yrs;
                                      
                                      SELF.totalUnreleasedLiensOver3Yrs := LEFT.totalUnreleasedLiensOver3Yrs + RIGHT.totalUnreleasedLiensOver3Yrs;
                                      SELF.totalUnreleasedLiensPast3Yrs := LEFT.totalUnreleasedLiensPast3Yrs + RIGHT.totalUnreleasedLiensPast3Yrs;
                                                                            
                                      SELF.lje := IF(COUNT(LEFT.lje) < DueDiligence.Constants.MAX_LIENS_JUDGEMENTS_EVICTIONS, LEFT.lje + RIGHT.lje, LEFT.lje);
                                      
                                      SELF := LEFT;));
                                      
                                      
                                      
                                      
                                      
    
                                      





    // OUTPUT(lienInfo, NAMED('lienInfo'));
    // OUTPUT(mainLiensUnsuppressed, NAMED('mainLiensUnsuppressed'));
    // OUTPUT(mainLiens, NAMED('mainLiens'));
    // OUTPUT(cleanDates, NAMED('cleanDates'));
    // OUTPUT(filterData, NAMED('filterData'));
    // OUTPUT(calcReleaseDate, NAMED('calcReleaseDate'));
    // OUTPUT(sortParties, NAMED('sortParties'));
    // OUTPUT(rollParty, NAMED('rollParty'));
    // OUTPUT(transformParties, NAMED('transformParties'));
    // OUTPUT(liensRolled, NAMED('liensRolled'));
    // OUTPUT(mainLiensCategorized, NAMED('mainLiensCategorized'));
    // OUTPUT(sortLienJudgementCounts, NAMED('sortLienJudgementCounts'));
    // OUTPUT(summaryLiens, NAMED('summaryLiens'));
    
    
   


    RETURN summaryLiens;
END;