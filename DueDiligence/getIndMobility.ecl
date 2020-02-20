
EXPORT getIndMobility(inquiredInternal, inquiredHeaderData, isFCRA, bsVersion, includeReport) := FUNCTIONMACRO

    IMPORT DueDiligence, Risk_Indicators, ut;
    

    
    //first seen date for any address for a given inquired did
    sortHeaderDateFirstSeenAddr := SORT(inquiredHeaderData(dateFirstSeen <> 0 AND (prim_name <> DueDiligence.Constants.EMPTY OR prim_range <> DueDiligence.Constants.EMPTY) AND zip5 <> DueDiligence.Constants.EMPTY), seq, did, dateFirstSeen);
    dedupHeaderDateFirstSeenAddr := DEDUP(sortHeaderDateFirstSeenAddr, seq, did);

    addDateFirstReportedAddr := JOIN(inquiredInternal, dedupHeaderDateFirstSeenAddr,
                                      LEFT.seq = RIGHT.seq AND
                                      LEFT.individual.did = RIGHT.did,
                                      TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                                SELF.earliestHeaderAddressReported := RIGHT.dateFirstSeen;
                                                SELF := LEFT;),
                                      LEFT OUTER,
                                      ATMOST(DueDiligence.Constants.MAX_ATMOST_1));  


    //convert header layout into layout outx to be used to calc address hierarchy
    tempInquiredHeader := PROJECT(inquiredHeaderData, TRANSFORM(Risk_Indicators.iid_constants.layout_outx,
                                                                SELF.p_city_name := LEFT.city;
                                                                SELF.st := LEFT.state;
                                                                SELF.z5 := LEFT.zip5;
                                                                SELF.h.dt_first_seen := (UNSIGNED3)((STRING8)LEFT.dateFirstSeen)[..6];
                                                                SELF.h.dt_last_seen := (UNSIGNED3)((STRING8)LEFT.dateLastSeen)[..6];
                                                                SELF.h.prim_range := LEFT.prim_range;
                                                                SELF.h.predir := LEFT.predir;
                                                                SELF.h.prim_name := LEFT.prim_name;
                                                                SELF.h.suffix := LEFT.addr_suffix;
                                                                SELF.h.postdir := LEFT.postdir;
                                                                SELF.h.unit_desig := LEFT.unit_desig;
                                                                SELF.h.sec_range := LEFT.sec_range;
                                                                SELF.h.city_name := LEFT.city;
                                                                SELF.h.st := LEFT.state;
                                                                SELF.h.zip := LEFT.zip5;
                                                                SELF.h.zip4 := LEFT.zip4;
                                                                SELF.h := LEFT;
                                                                SELF.historyDate := (UNSIGNED3)((STRING8)LEFT.historyDate)[..6];
                                                                SELF.chronoprim_range := LEFT.prim_range;
                                                                SELF.chronopredir := LEFT.predir;
                                                                SELF.chronoprim_name := LEFT.prim_name;
                                                                SELF.chronosuffix := LEFT.addr_suffix;
                                                                SELF.chronopostdir := LEFT.postdir;
                                                                SELF.chronounit_desig := LEFT.unit_desig;
                                                                SELF.chronosec_range := LEFT.sec_range;
                                                                SELF.chronocity := LEFT.city;
                                                                SELF.chronostate := LEFT.state;
                                                                SELF.chronozip := LEFT.zip5;                                                                
                                                                SELF.chronozip4 := LEFT.zip4;
                                                                SELF.chronocounty := LEFT.county;
                                                                SELF.chronogeo_blk := LEFT.geo_blk;
                                                                SELF.chronodate_last := (UNSIGNED3)((STRING8)LEFT.dateLastSeen)[..6];
                                                                SELF.chronodate_first := (UNSIGNED3)((STRING8)LEFT.dateFirstSeen)[..6];
                                                                SELF.chronolast := LEFT.lastName;
                                                                SELF.chronofirst := LEFT.firstName;
                                                                SELF := LEFT;
                                                                SELF := [];));
                                                                                                                       

    addrHierarchy := Risk_Indicators.iid_append_address_hierarchy(GROUP(tempInquiredHeader, seq, did), isFCRA, bsVersion);




    //get the most recent addresses first
    sortHierarchyByDate := SORT(UNGROUP(addrHierarchy), seq, did, IF(address_history_seq = 0, 255, address_history_seq), 
                                -chronodate_last, -chronodate_first,
                                -chronozip, -chronoprim_name, -chronoprim_range, -chronopredir, -chronosuffix, -chronopostdir, 
                                -chronosec_range, -chronounit_desig, -chronogeo_blk, -chronozip4, -chronocity, -chronostate, 
                                src, record);
                          

    //get the current and previous addresses
    rollAddrByDate := ROLLUP(sortHierarchyByDate,
                              LEFT.seq = RIGHT.seq AND
                              LEFT.did = RIGHT.did,
                              TRANSFORM(RECORDOF(LEFT),
                                        
                                        howmany := MAP(LEFT.chronoprim_name=''  OR (LEFT.chronoprim_name= RIGHT.chronoprim_name and LEFT.chronoprim_range= RIGHT.chronoprim_range and LEFT.chronozip= RIGHT.chronozip) => 1,
                                                       LEFT.chronoprim_name2='' OR (LEFT.chronoprim_name2=RIGHT.chronoprim_name and LEFT.chronoprim_range2=RIGHT.chronoprim_range and LEFT.chronozip2=RIGHT.chronozip) => 2,
                                                       3);

                                       
                                        self.chronoprim_range := IF(howmany = 1, RIGHT.chronoprim_range, LEFT.chronoprim_range);
                                        self.chronopredir := IF(howmany = 1, RIGHT.chronopredir, LEFT.chronopredir);
                                        self.chronoprim_name := IF(howmany = 1, RIGHT.chronoprim_name, LEFT.chronoprim_name);
                                        self.chronosuffix := IF(howmany = 1, RIGHT.chronosuffix, LEFT.chronosuffix);
                                        self.chronopostdir := IF(howmany = 1, RIGHT.chronopostdir, LEFT.chronopostdir);
                                        self.chronounit_desig := IF(howmany = 1, RIGHT.chronounit_desig, LEFT.chronounit_desig);
                                        self.chronosec_range := IF(howmany = 1, RIGHT.chronosec_range, LEFT.chronosec_range);
                                        self.chronocity := IF(howmany = 1, RIGHT.chronocity, LEFT.chronocity);
                                        self.chronostate := IF(howmany = 1, RIGHT.chronostate, LEFT.chronostate);
                                        self.chronozip := IF(howmany = 1, RIGHT.chronozip, LEFT.chronozip);
                                        self.chronozip4 := IF(howmany = 1, RIGHT.chronozip4, LEFT.chronozip4);
                                        self.chronocounty := IF(howmany = 1, RIGHT.chronocounty, LEFT.chronocounty);
                                        self.chronogeo_blk := IF(howmany = 1, RIGHT.chronogeo_blk, LEFT.chronogeo_blk);
                                        self.chronodate_first := IF(howmany = 1, ut.Min2(LEFT.chronodate_first,RIGHT.chronodate_first), LEFT.chronodate_first);
                                        self.chronodate_last := IF(howmany = 1, MAX(LEFT.chronodate_last,RIGHT.chronodate_last), LEFT.chronodate_last);
                                        
                                        self.chronoprim_range2 := IF(howmany = 2, RIGHT.chronoprim_range, LEFT.chronoprim_range2);
                                        self.chronopredir2 := IF(howmany = 2, RIGHT.chronopredir, LEFT.chronopredir2);
                                        self.chronoprim_name2 := IF(howmany = 2, RIGHT.chronoprim_name, LEFT.chronoprim_name2);
                                        self.chronosuffix2 := IF(howmany = 2, RIGHT.chronosuffix, LEFT.chronosuffix2);
                                        self.chronopostdir2 := IF(howmany = 2, RIGHT.chronopostdir, LEFT.chronopostdir2);
                                        self.chronounit_desig2 := IF(howmany = 2, RIGHT.chronounit_desig, LEFT.chronounit_desig2);
                                        self.chronosec_range2 := IF(howmany = 2, RIGHT.chronosec_range, LEFT.chronosec_range2);
                                        self.chronocity2 := IF(howmany = 2, RIGHT.chronocity, LEFT.chronocity2);
                                        self.chronostate2 := IF(howmany = 2, RIGHT.chronostate, LEFT.chronostate2);
                                        self.chronozip2 := IF(howmany = 2, RIGHT.chronozip, LEFT.chronozip2);
                                        self.chronozip4_2 := IF(howmany = 2, RIGHT.chronozip4, LEFT.chronozip4_2);
                                        self.chronocounty2 := IF(howmany = 2, RIGHT.chronocounty, LEFT.chronocounty2);
                                        self.chronogeo_blk2 := IF(howmany = 2, RIGHT.chronogeo_blk, LEFT.chronogeo_blk2);
                                        self.chronodate_first2 := IF(howmany=2, ut.Min2(LEFT.chronodate_first2,RIGHT.chronodate_first), LEFT.chronodate_first2);
                                        self.chronodate_last2 := IF(howmany=2, MAX(LEFT.chronodate_last2,RIGHT.chronodate_last), LEFT.chronodate_last2);
                                        
                                        SELF := LEFT;));
                          
       
    slimAddrHierarchy := PROJECT(UNGROUP(addrHierarchy), TRANSFORM(DueDiligence.LayoutsInternal.chronoAddressesLayout, SELF := LEFT; SELF := [];));


    //sort address and calc first/last seen dates
    sortHierarchyByAddr := SORT(slimAddrHierarchy, seq, did, IF(address_history_seq=0, 255, address_history_seq), 
                                -chronozip, -chronoprim_name, -chronoprim_range, -chronopredir, -chronosuffix, -chronopostdir, 
                                -chronosec_range, -chronounit_desig, -chronogeo_blk, -chronozip4, -chronocity, -chronostate, -chronodate_last, -chronodate_first, src, record );
              

    rollHierarchyByAddr := ROLLUP(sortHierarchyByAddr,
                                  LEFT.seq = RIGHT.seq AND
                                  LEFT.did = RIGHT.did AND
                                  LEFT.address_history_seq = RIGHT.address_history_seq AND
                                  LEFT.chronozip = RIGHT.chronozip AND
                                  LEFT.chronoprim_name = RIGHT.chronoprim_name AND
                                  LEFT.chronoprim_range = RIGHT.chronoprim_range AND
                                  LEFT.chronocity = RIGHT.chronocity AND
                                  LEFT.chronostate = RIGHT.chronostate,
                                  TRANSFORM(DueDiligence.LayoutsInternal.chronoAddressesLayout,
                                            SELF.chronodate_last := MAX(LEFT.chronodate_last, RIGHT.chronodate_last);
                                            SELF.chronodate_first := ut.Min2(LEFT.chronodate_first, RIGHT.chronodate_first);
                                            SELF := LEFT;));


    //call function to calculate the distance between moves
    getMovingDistance := DueDiligence.fn_getMovingDetails(rollHierarchyByAddr); 


    addMoves := JOIN(addDateFirstReportedAddr, getMovingDistance,
                      LEFT.seq = RIGHT.seq AND
                      LEFT.individual.did = RIGHT.did,
                      TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                                                
                                addr1 := DueDiligence.CommonDate.GetAreDatesWithinNumYears(RIGHT.addr1_firstseendate, LEFT.historyDate, 3);
                                addr2 := DueDiligence.CommonDate.GetAreDatesWithinNumYears(RIGHT.addr2_firstseendate, LEFT.historyDate, 3);
                                addr3 := DueDiligence.CommonDate.GetAreDatesWithinNumYears(RIGHT.addr3_firstseendate, LEFT.historyDate, 3);
                                addr4 := DueDiligence.CommonDate.GetAreDatesWithinNumYears(RIGHT.addr4_firstseendate, LEFT.historyDate, 3);
                     
                                SELF.move1Distance := IF(addr1 AND addr2, (STRING20)RIGHT.Move1_dist, DueDiligence.Constants.EMPTY);
                                SELF.move2Distance := IF(addr2 AND addr3, (STRING20)RIGHT.Move2_dist, DueDiligence.Constants.EMPTY);
                                SELF.move3Distance := IF(addr3 AND addr4, (STRING20)RIGHT.Move3_dist, DueDiligence.Constants.EMPTY);
                                                                
                                SELF := LEFT;),
                      LEFT OUTER,
                      ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                      
                      

    addAddressHistories := JOIN(addMoves, rollAddrByDate,
                                LEFT.seq = RIGHT.seq AND
                                LEFT.individual.did = RIGHT.did,
                                TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                
                                          SELF.hasAddressHistory :=  (RIGHT.chronoprim_range <> '' OR RIGHT.chronoprim_name <> '') and RIGHT.chronozip <> '';
                                          SELF.hasPreviousAddressHistory := (RIGHT.chronoprim_range2 <> '' OR RIGHT.chronoprim_name2 <> '') and RIGHT.chronozip2 <> '';
                                          
                                          SELF.currentAddressFirstSeen := (UNSIGNED4)DueDiligence.Common.checkInvalidDate((STRING)RIGHT.chronodate_first);
                                          SELF.previousAddressFirstSeen := (UNSIGNED4)DueDiligence.Common.checkInvalidDate((STRING)RIGHT.chronodate_first2);
                                          
                                          SELF := LEFT;),
                                LEFT OUTER,
                                ATMOST(DueDiligence.Constants.MAX_ATMOST_1));  
                                
                                
                                
    //need to keep track of the addresses and order if the report is called to display accordingly
    convertHierarchyToDS := PROJECT(GROUP(SORT(rollHierarchyByAddr, seq, did, address_history_seq, -chronodate_last, chronodate_first), seq, did),
                                    TRANSFORM(DueDiligence.LayoutsInternal.chronoAddressesLayout,
                                              SELF.addrSeq := COUNTER;
                                              SELF.chronoAddresses := DATASET([TRANSFORM(DueDiligence.Layouts.AddressDetails,
                                                                                          SELF.seq := COUNTER;
                                                                                          SELF.prim_range := LEFT.chronoprim_range;
                                                                                          SELF.predir := LEFT.chronopredir;
                                                                                          SELF.prim_name := LEFT.chronoprim_name;
                                                                                          SELF.addr_suffix := LEFT.chronosuffix;
                                                                                          SELF.postdir := LEFT.chronopostdir;
                                                                                          SELF.unit_desig := LEFT.chronounit_desig;
                                                                                          SELF.sec_range := LEFT.chronosec_range;
                                                                                          SELF.city := LEFT.chronocity;
                                                                                          SELF.state := LEFT.chronostate;
                                                                                          SELF.zip5 := LEFT.chronozip;
                                                                                          SELF.zip4 := LEFT.chronozip4;
                                                                                          SELF.county := LEFT.chronocounty;
                                                                                          SELF.geo_blk := LEFT.chronogeo_blk;
                                                                                          SELF.dateFirstSeen := LEFT.chronodate_first;
                                                                                          SELF.dateLastSeen := LEFT.chronodate_last;
                                                                                          SELF := [];)]);
                                              SELF := LEFT;));
                                              
    //limit residences
    unGroupHierachyToDS := UNGROUP(convertHierarchyToDS);
    grpHierachyToDS := GROUP(SORT(unGroupHierachyToDS, seq, did, addrSeq), seq, did);
    limitedResidences := DueDiligence.Common.GetMaxRecords(grpHierachyToDS, DueDiligence.Constants.MAX_RESIDENCES);
                                              
    rollAddressesForReport := ROLLUP(SORT(limitedResidences, seq, did),
                                     LEFT.seq = RIGHT.seq AND
                                     LEFT.did = RIGHT.did,
                                     TRANSFORM(DueDiligence.LayoutsInternal.chronoAddressesLayout,
                                                SELF.chronoAddresses := LEFT.chronoAddresses + RIGHT.chronoAddresses;
                                                SELF := LEFT;));
                                                
                                                

    addReportAddresses := JOIN(addAddressHistories, rollAddressesForReport,
                                LEFT.seq = RIGHT.seq AND
                                LEFT.individual.did = RIGHT.did,
                                TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                          SELF.residences := RIGHT.chronoAddresses;
                                          SELF := LEFT;),
                                LEFT OUTER,
                                ATMOST(DueDiligence.Constants.MAX_ATMOST_1));  
                                                


    final := IF(includeReport, addReportAddresses, addAddressHistories); 
                                      


    // OUTPUT(inquiredHeaderData, NAMED('inquiredHeaderData'));
    // OUTPUT(tempInquiredHeader, NAMED('tempInquiredHeader'));
    // OUTPUT(addrHierarchy, NAMED('addrHierarchy'));

    // OUTPUT(sortHierarchyByDate, NAMED('sortHierarchyByDate'));
    // OUTPUT(rollAddrByDate, NAMED('rollAddrByDate'));
    
    // OUTPUT(slimAddrHierarchy, NAMED('slimAddrHierarchy')); 
    
    // OUTPUT(sortHierarchyByAddr, NAMED('sortHierarchyByAddr'));
    // OUTPUT(rollHierarchyByAddr, NAMED('rollHierarchyByAddr')); 
         
    // OUTPUT(getMovingDistance, NAMED('getMovingDistance'));     
  
    // OUTPUT(addAddressHistories, NAMED('addAddressHistories'));  
    // OUTPUT(convertHierarchyToDS, NAMED('convertHierarchyToDS'));  
    // OUTPUT(limitedResidences, NAMED('limitedResidences'));  
    // OUTPUT(rollAddressesForReport, NAMED('rollAddressesForReport'));  
    // OUTPUT(addReportAddresses, NAMED('addReportAddresses'));  
    // OUTPUT(final, NAMED('final'));  
    


    RETURN final;
ENDMACRO;