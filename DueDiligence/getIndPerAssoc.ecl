IMPORT DueDiligence, ut;


EXPORT getIndPerAssoc(DATASET(DueDiligence.Layouts.Indv_Internal) inData) := FUNCTION

    //all information for the associations should be gathered prior to this call - legal, header, ssn
    //get all associations
    allRelations := DueDiligence.CommonIndividual.GetAllRelationships(inData);
    
    
    countFirstSeenSSNRisks := TABLE(allRelations, {seq, inquiredDID, 
                                                       lessThan1Year := COUNT(GROUP, headerFirstSeenDate <> 0 AND 
                                                                                     DueDiligence.CommonDate.DaysApartWithZeroEmptyDate((STRING)headerFirstSeenDate, (STRING)historyDate) <= ut.DaysInNYears(1) AND 
                                                                                     ssnrisk),
                                                       greaterThan1Year := COUNT(GROUP, headerFirstSeenDate <> 0 AND 
                                                                                        DueDiligence.CommonDate.DaysApartWithZeroEmptyDate((STRING)headerFirstSeenDate, (STRING)historyDate) > ut.DaysInNYears(1) AND 
                                                                                        ssnrisk)}, seq, inquiredDID);
                                                                                    
                                                                                    
    
    addSSNRiskCounts := JOIN(inData, countFirstSeenSSNRisks,
                              LEFT.seq = RIGHT.seq AND
                              LEFT.inquiredDID = RIGHT.inquiredDID,
                              TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                        SELF.relationHeaderLess1YearWithSSNRiskCount := RIGHT.lessThan1Year;
                                        SELF.relationHeaderGreater1YearWithSSNRiskCount := RIGHT.greaterThan1Year;
                                        SELF := LEFT;),
                              LEFT OUTER,
                              ATMOST(1));
    
    
    
    

    // OUTPUT(countFirstSeenSSNRisks, NAMED('countFirstSeenSSNRisks'));
    // OUTPUT(addSSNRiskCounts, NAMED('addSSNRiskCounts'));



    RETURN addSSNRiskCounts;
END;