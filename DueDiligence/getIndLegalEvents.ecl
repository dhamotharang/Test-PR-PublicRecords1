﻿IMPORT DueDiligence;


EXPORT getIndLegalEvents(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                         BOOLEAN includeReport) := FUNCTION
    
    
    //Need to convert the inquuired individual into a dataset
    indivRelatedParty := PROJECT(inData, TRANSFORM({DATASET(DueDiligence.LayoutsInternal.RelatedParty) inquired},
                                                    SELF.inquired := PROJECT(LEFT, TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty, 
                                                                                             SELF.seq := LEFT.seq;
                                                                                             SELF.did := LEFT.inquiredDID;
                                                                                             SELF.party := LEFT.individual;
                                                                                             SELF := LEFT;
                                                                                             SELF := [];));
                                                    SELF := [];));
    
    //get the criminal data
    crimData := DueDiligence.getIndCriminal(indivRelatedParty.inquired, includeReport);
    
    
    //retrieve related party event types for a given offense charge
	  //getIndLegalEventType := DueDiligence.getIndLegalEventType(UpdateBusinessExecutivesCriminalOffense); //***this was released on May 22
	  updateIndLegalEventType := DueDiligence.getIndOffenseLegalEventType(crimData);                        //***this will switch over on June 5th
    
    //put the inquired individual back on the internal layout to be passed on for more information
    addInquiredCriminalData := JOIN(inData, updateIndLegalEventType,
                                    LEFT.seq = RIGHT.seq AND
                                    LEFT.inquiredDID = RIGHT.did,
                                    TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                              SELF.individual := RIGHT.party;
                                              SELF := LEFT;),
                                    LEFT OUTER,
                                    ATMOST(1));
    
    
    
    
    
    
    //OUTPUT(inData, NAMED('inData'));
    // OUTPUT(indivRelatedParty, NAMED('indivRelatedParty'));
    // OUTPUT(crimData, NAMED('crimData'));
    // OUTPUT(updateIndLegalEventType, NAMED('updateIndLegalEventType'));
    // OUTPUT(addInquiredCriminalData, NAMED('addInquiredCriminalData'));
    
    
    RETURN addInquiredCriminalData;
END;