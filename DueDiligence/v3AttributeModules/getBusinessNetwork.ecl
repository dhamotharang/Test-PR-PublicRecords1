IMPORT DueDiligence;


EXPORT getBusinessNetwork(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                          DueDiligence.DDInterface.iDDv3BusinessAttributes attributesRequested) := FUNCTION
                          
                          

    //based on the network data - populate requested attributes
    noAttributeResults := DATASET([], DueDiligence.v3Layouts.InternalBusiness.BusinessAttributes);
    

    beoAccessFundsPropAttributeResults := DueDiligence.v3BusinessAttributes.getBEOAccessToFundsProperty(inData);
    
    
    beoAccessToFundsAndProperty := IF(attributesRequested.includeAll OR attributesRequested.includeBEOAccessToFundsProperty, beoAccessFundsPropAttributeResults, noAttributeResults);

   
    //add all the attributes together to get all necessary network attributes
    networkAttributes := ROLLUP(SORT(beoAccessToFundsAndProperty, seq, ultID, orgID, seleID),
                                LEFT.seq = RIGHT.seq AND
                                LEFT.ultID = RIGHT.ultID AND
                                LEFT.orgID = RIGHT.orgID AND
                                LEFT.seleID = RIGHT.seleID,
                                TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessAttributes,
                                          SELF.seq := LEFT.seq;
                                          SELF.ultID := LEFT.ultID;
                                          SELF.orgID := LEFT.orgID;
                                          SELF.seleID := LEFT.seleID;

                                          SELF.busBEOAccessToFundsProperty := DueDiligence.v3Common.General.FirstPopulatedString(busBEOAccessToFundsProperty);
                                          SELF.busBEOAccessToFundsProperty_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busBEOAccessToFundsProperty_Flag);
                                          
                                          SELF := LEFT;));
                                        


    //based on request - populate the reports of the network section
    noNetworkReportData := DATASET([], DueDiligence.v3Layouts.InternalBusiness.BusinessReport);
    
                                            
    networkReport := noNetworkReportData;
    

    //join the attributes and report data together
    finalNetwork := JOIN(networkAttributes, networkReport,
                          LEFT.seq = RIGHT.seq AND
                          LEFT.ultID = RIGHT.ultID AND
                          LEFT.orgID = RIGHT.orgID AND
                          LEFT.seleID = RIGHT.seleID,
                          TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessResults,
                                    SELF.seq := LEFT.seq;
                                    SELF.ultID := LEFT.ultID;
                                    SELF.orgID := LEFT.orgID;
                                    SELF.seleID := LEFT.seleID;
                                    
                                    SELF.busBEOAccessToFundsProperty := LEFT.busBEOAccessToFundsProperty;
                                    SELF.busBEOAccessToFundsProperty_Flag := LEFT.busBEOAccessToFundsProperty_Flag;

                                    SELF := [];),
                          LEFT OUTER,
                          ATMOST(1));
    



    // OUTPUT(inData, NAMED('inData'));
    // OUTPUT(beoAccessToFundsAndProperty, NAMED('beoAccessToFundsAndProperty'));
    // OUTPUT(networkAttributes, NAMED('networkAttributes'));
    // OUTPUT(finalNetwork, NAMED('finalNetwork'));
    
    
                
                        
    RETURN finalNetwork;
END;