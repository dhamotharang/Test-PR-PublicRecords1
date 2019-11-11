IMPORT DueDiligence, ut;

EXPORT fn_getMovingDetails(DATASET(DueDiligence.LayoutsInternal.chronoAddressesLayout) inData) := FUNCTION

    //get all the unique addresses for a given person
    clamAddrSeq := DEDUP(SORT(inData(address_history_seq NOT IN [255, 0] AND chronodate_first <> 0),
                              seq, did, address_history_seq, chronoprim_name, chronopredir, chronoprim_range, chronosuffix, chronopostdir,
                              chronounit_desig, chronosec_range, chronocity, chronozip, chronodate_first),
                              seq, did, address_history_seq, chronoprim_name, chronopredir, chronoprim_range, chronosuffix, chronopostdir,
                              chronounit_desig, chronosec_range, chronocity, chronozip, chronodate_first, KEEP(1));
                              

    //grab the top 4 address per person
    grpAddrHistSeq := GROUP(SORT(clamAddrSeq, seq, did, address_history_seq), seq, did);  
    maxAddrSeq := DueDiligence.Common.GetMaxRecords(grpAddrHistSeq, 4);                 
     
     
    moversRecs := PROJECT(maxAddrSeq, TRANSFORM(DueDiligence.LayoutsInternal.distanceZipLayout,
                                                  SELF.seq := LEFT.seq;
                                                  SELF.did := LEFT.did;
                                                  SELF.addressHistorySeq := LEFT.address_history_seq;
                                                  SELF.chronoZip := LEFT.chronozip;
                                                  SELF.dateFirstSeen := (UNSIGNED4)DueDiligence.Common.checkInvalidDate((STRING)LEFT.chronodate_first);
                                                  SELF := [];));

      
    moversZip := ITERATE(GROUP(moversRecs, seq, did), TRANSFORM(DueDiligence.LayoutsInternal.distanceZipLayout,
                                                                SELF.seq := RIGHT.seq;
                                                                SELF.did := RIGHT.did;
                                                                SELF.addressHistorySeq := RIGHT.addressHistorySeq;
                                                                SELF.chronoZip := RIGHT.chronoZip;
                                                                
                                                                SELF.addr1_zip := IF(COUNTER = 1, RIGHT.chronozip, LEFT.addr1_zip);
                                                                SELF.addr2_zip := IF(COUNTER = 2, RIGHT.chronozip, LEFT.addr2_zip);
                                                                SELF.addr3_zip := IF(COUNTER = 3, RIGHT.chronozip, LEFT.addr3_zip);
                                                                SELF.addr4_zip := IF(COUNTER = 4, RIGHT.chronozip, LEFT.addr4_zip);
                                                                
                                                                SELF.addr1_firstSeenDate := IF(COUNTER = 1, RIGHT.dateFirstSeen, LEFT.addr1_firstSeenDate);
                                                                SELF.addr2_firstSeenDate := IF(COUNTER = 2, RIGHT.dateFirstSeen, LEFT.addr2_firstSeenDate);
                                                                SELF.addr3_firstSeenDate := IF(COUNTER = 3, RIGHT.dateFirstSeen, LEFT.addr3_firstSeenDate);
                                                                SELF.addr4_firstSeenDate := IF(COUNTER = 4, RIGHT.dateFirstSeen, LEFT.addr4_firstSeenDate);
                                                                
                                                                
                                                                SELF := [];));
      
      
    sdMoversZip := DEDUP(SORT(moversZip, -addressHistorySeq, did, -addr4_zip, -addr3_zip, -addr2_zip, -addr1_zip), did);

    moveDistance := PROJECT(sdMoversZip, TRANSFORM(DueDiligence.LayoutsInternal.distanceZipLayout,
                                                    SELF.move1_dist := IF(LEFT.addr1_zip = DueDiligence.Constants.EMPTY OR
                                                                          LEFT.addr2_zip = DueDiligence.Constants.EMPTY, '', (STRING)MIN((INTEGER)ut.zip_Dist(LEFT.addr1_zip, LEFT.addr2_zip), 9998));
                                                                          
                                                    SELF.move2_dist := IF(LEFT.addr2_zip = DueDiligence.Constants.EMPTY OR
                                                                          LEFT.addr3_zip = DueDiligence.Constants.EMPTY, '', (STRING)MIN((INTEGER)ut.zip_Dist(LEFT.addr2_zip, LEFT.addr3_zip), 9998));
                                                                          
                                                    SELF.move3_dist := IF(LEFT.addr3_zip = DueDiligence.Constants.EMPTY OR
                                                                          LEFT.addr4_zip = DueDiligence.Constants.EMPTY, '', (STRING)MIN((INTEGER)ut.zip_Dist(LEFT.addr3_zip, LEFT.addr4_zip), 9998));
                                                    
                                                    SELF := LEFT;));

										
                    
                    
                    
    // OUTPUT(clamAddrSeq,named('clamAddrSeq'));																				
    // OUTPUT(maxAddrSeq,named('maxAddrSeq'));																
    // OUTPUT(moversRecs,named('moversRecs'));															
    // OUTPUT(moversZip,named('moversZip'));										
    // OUTPUT(sdMoversZip,named('sdMoversZip'));										
    // OUTPUT(moveDistance,named('moveDistance'));										
                                    
                        
    RETURN moveDistance;
END;
										