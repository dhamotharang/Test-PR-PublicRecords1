IMPORT DueDiligence, iesp;

EXPORT reportIndCriminal(DATASET(DueDiligence.layouts.Indv_Internal) inData, 
                         STRING6 ssnMask) := FUNCTION


  listOfInquiredOffenses := NORMALIZE(inData, LEFT.individual.indOffenses, TRANSFORM(DueDiligence.LayoutsInternalReport.FlatListOfIndividualsWithCriminalLayout,																												
                                                                                        SELF.seq := LEFT.seq;  
                                                                                        SELF.did := LEFT.inquiredDID; 
                                                                                        SELF := LEFT.individual; 
                                                                                        SELF.crimData := RIGHT;
                                                                                        SELF := [];)); 


  populateChildCrimDataset := DueDiligence.reportSharedLegal.getDDRLegalEventCriminalWithMasking(listOfInquiredOffenses, ssnMask);
  
  formatInquiredCriminal := PROJECT(populateChildCrimDataset, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, iesp.duediligencepersonreport.t_DDRPersonCriminalEvents crimEvents},
                                                                          SELF.seq := LEFT.seq;
                                                                          SELF.did := LEFT.did;
                                                                          SELF.crimEvents.PersonInfo := LEFT;
                                                                          SELF.crimEvents.Criminals := LEFT.criminalChildDS;
                                                                          SELF := [];));


  addInquiredLegal := JOIN(inData, formatInquiredCriminal,
                            LEFT.seq = RIGHT.seq AND
                            LEFT.inquiredDID = RIGHT.did,
                            TRANSFORM(RECORDOF(LEFT),
                                      SELF.personReport.PersonAttributeDetails.Legal.PossibleLegalEvents := RIGHT.crimEvents;
                                      SELF := LEFT;),
                            LEFT OUTER,
                            ATMOST(1));





  // OUTPUT(inData, NAMED('inData'));
  // OUTPUT(listOfInquiredOffenses, NAMED('ListOfInquiredOffenses'));
  // OUTPUT(populateChildCrimDataset, NAMED('populateChildCrimDataset'));
  // OUTPUT(formatInquiredCriminal, NAMED('formatInquiredCriminal'));
  // OUTPUT(addInquiredLegal, NAMED('addInquiredLegal'));

  RETURN addInquiredLegal;
END;