IMPORT DueDiligence;


EXPORT getIndLegalEvents(DATASET(DueDiligence.Layouts.Indv_Internal) inData) := FUNCTION
    
    
    //get spouse, parent and relatives
    getSpouseAsInquired := DueDiligence.CommonIndividual.GetRelationshipAsInquired(inData, spouses, DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE);
    getParentAsInquired := DueDiligence.CommonIndividual.GetRelationshipAsInquired(inData, parents, DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT);
    getOtherRelationAsInquired := DueDiligence.CommonIndividual.GetRelationshipAsInquired(inData, associates, DueDiligence.Constants.INQUIRED_INDIVIDUAL_OTHER_RELATION);
    
    allIndividuals := inData + getSpouseAsInquired + getParentAsInquired + getOtherRelationAsInquired;
    
    //Need to convert the inquuired individual into a dataset
    relatedParty := PROJECT(allIndividuals, TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty, 
                                                       SELF.seq := LEFT.seq;
                                                       SELF.did := LEFT.individual.did;
                                                       SELF.party := LEFT.individual;
                                                       SELF := LEFT;
                                                       SELF := [];));
                                                       

    //grab unqiue DIDs so we don't have to query the same person multiple times
    uniqueRelatedParties := DEDUP(SORT(relatedParty, did), did);
    
    //get the criminal data
    crimData := DueDiligence.getIndCriminal(uniqueRelatedParties);     
    
    //get any sex offender data
    sexOffender := DueDiligence.getIndCriminalSexOffender(crimData);
    
    //add back the data to all parties with the same DID
    allRelatedParties := JOIN(relatedParty, sexOffender,
                              LEFT.did = RIGHT.did,
                              TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,
                                        SELF.party.legalEventTypeScore := RIGHT.party.legalEventTypeScore;
                                        SELF.party.legalEventTypeFlags := RIGHT.party.legalEventTypeFlags;
                                        SELF.party.stateCriminalLegalEventsScore := RIGHT.party.stateCriminalLegalEventsScore;
                                        SELF.party.stateCriminalLegalEventsFlags := RIGHT.party.stateCriminalLegalEventsFlags;
                                        SELF.party.indoffenses := RIGHT.party.indoffenses;
                                        
                                        SELF.potentialSO := RIGHT.potentialSO;
                                        
                                        SELF.trafficOffenseFound := RIGHT.trafficOffenseFound;
                                        SELF.otherOffenseFound := RIGHT.otherOffenseFound;
                                        SELF.currIncar := RIGHT.currIncar;
                                        SELF.currParole := RIGHT.currParole;
                                        SELF.currProbation := RIGHT.currProbation;
                                        SELF.prevIncar := RIGHT.prevIncar;
                                        SELF.felonyPast3Years := RIGHT.felonyPast3Years;
                                        
                                        SELF := LEFT;),
                              LEFT OUTER,
                              ATMOST(1));
    
    
    //put the inquired individual back on the internal layout to be passed on for more information
    addInquiredCriminalData := JOIN(inData, allRelatedParties,
                                    LEFT.seq = RIGHT.seq AND
                                    LEFT.inquiredDID = RIGHT.did,
                                    TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                              SELF.individual := RIGHT.party;
                                              SELF := LEFT;),
                                    LEFT OUTER,
                                    ATMOST(1));
    

 
    perAssocOptions := MODULE(DueDiligence.DataInterface.iAttributePerAssoc)
                                EXPORT BOOLEAN includeSSNData := FALSE;
                                EXPORT BOOLEAN includeHeaderData := FALSE;
                        END;
     
    updateRelations := DueDiligence.CommonIndividual.UpdateRelationships(addInquiredCriminalData, sexOffender, perAssocOptions);
    
    
    
    
    
    
    
    
    
    
    // OUTPUT(inData, NAMED('inData'));
    // OUTPUT(allIndividuals, NAMED('allIndividuals'));
    // OUTPUT(relatedParty, NAMED('relatedParty'));
    // OUTPUT(uniqueRelatedParties, NAMED('uniqueRelatedParties'));
    // OUTPUT(crimData, NAMED('crimData'));
    // OUTPUT(sexOffender, NAMED('sexOffender'));
    // OUTPUT(allRelatedParties, NAMED('allRelatedParties'));
    // OUTPUT(addInquiredCriminalData, NAMED('addInquiredCriminalData'));
    // OUTPUT(updateRelations, NAMED('updateRelations'));
    
    
    RETURN updateRelations;
END;