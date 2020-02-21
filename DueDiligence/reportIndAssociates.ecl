IMPORT DueDiligence, Header, iesp, Suppress;


EXPORT reportIndAssociates(DATASET(DueDiligence.layouts.Indv_Internal) inData, 
                           STRING6 ssnMask) := FUNCTION


    allAssociations := DueDiligence.CommonIndividual.GetAllRelationships(inData);
    
    //grab the most that ESP will return
    sortAssociations := SORT(allAssociations, seq, inquiredDID, relationship, dob, lastName, firstName, ssn);
    grpSortedAssociations := GROUP(sortAssociations, seq, inquiredDID);
    limitedAssociations := DueDiligence.Common.GetMaxRecords(grpSortedAssociations, iesp.Constants.DDRAttributesConst.MaxPersonAssociations);
    
    //mask ssn for the report    
    Suppress.MAC_Mask(limitedAssociations, maskedSSN, ssn, '', TRUE, FALSE,,,, ssnMask);
    
    addressCounty := DueDiligence.CommonAddress.GetAddressCounty(maskedSSN);
    
    //convert to ESP layout
    convertLayout := PROJECT(addressCounty, TRANSFORM({UNSIGNED seq, UNSIGNED inquiredDID, UNSIGNED relation, UNSIGNED otherRelation, DATASET(iesp.duediligencepersonreport.t_DDRPersonAssociationRelationshipDetails) assocDetails},
                                                  SELF.seq := LEFT.seq;
                                                  SELF.inquiredDID := LEFT.inquiredDID;
                                                  SELF.relation := IF(LEFT.relationship < 44 OR LEFT.relationship IN [97, 98, 99], 1, 0);
                                                  SELF.otherRelation := IF(LEFT.relationship BETWEEN 44 AND 96, 1, 0);
                                                  SELF.assocDetails := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonAssociationRelationshipDetails,
                                                                                          SELF.Name := iesp.ECL2ESP.SetName(LEFT.firstName, LEFT.middleName, LEFT.lastName, LEFT.suffix, DueDiligence.Constants.EMPTY);
                                                                                          SELF.SSNLexID.SSN := LEFT.ssn;
                                                                                          SELF.SSNLexID.LexID := (STRING)LEFT.did;
                                                                                          SELF.DOB := iesp.ECL2ESP.toDate(LEFT.dob);
                                                                                          SELF.Address := iesp.ECL2ESP.SetAddress(LEFT.prim_name, LEFT.prim_range, LEFT.predir,
                                                                                                                                  LEFT.postdir, LEFT.addr_suffix, LEFT.unit_desig,
                                                                                                                                  LEFT.sec_range, LEFT.city, LEFT.state, LEFT.zip5,
                                                                                                                                  LEFT.zip4, LEFT.countyNameText);
                                                                                                              
                                                                                          SELF.TrafficRelated := LEFT.offenseTrafficRelated;
                                                                                          SELF.AllOtherCriminalRecords := LEFT.otherCriminalOffense;
                                                                                          SELF.PossibleRelationship := DueDiligence.translateCodeToText.RelationshipText(LEFT.relationship);
                                                                                          SELF :=[];)]);
                                                  SELF := [];));
    
    //roll relationships by inquired
    rollRelations := ROLLUP(SORT(convertLayout, seq, inquiredDID, -relation),
                            LEFT.seq = RIGHT.seq AND
                            LEFT.inquiredDID = RIGHT.inquiredDID,
                            TRANSFORM(RECORDOF(LEFT),
                                      SELF.relation := LEFT.relation + RIGHT.relation;
                                      SELF.otherRelation := LEFT.otherRelation + RIGHT.otherRelation;
                                      SELF.assocDetails := LEFT.assocDetails + RIGHT.assocDetails;
                                      SELF := LEFT;));





    addAssociates := JOIN(inData, rollRelations,
                          LEFT.seq = RIGHT.seq AND
                          LEFT.inquiredDID = RIGHT.inquiredDID,
                          TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                    SELF.personReport.PersonAttributeDetails.PersonAssociation.NumberRelatives := RIGHT.relation;
                                    SELF.personReport.PersonAttributeDetails.PersonAssociation.NumberOtherAssociates := RIGHT.otherRelation;
                                    SELF.personReport.PersonAttributeDetails.PersonAssociation.RelationDetails := RIGHT.assocDetails;
                                    
                                    SELF := LEFT;),
                          LEFT OUTER,
                          ATMOST(1));





    // OUTPUT(allAssociations, NAMED('allAssociations'));
    // OUTPUT(sortAssociations, NAMED('sortAssociations'));
    // OUTPUT(limitedAssociations, NAMED('limitedAssociations'));
    // OUTPUT(maskedSSN, NAMED('maskedSSN'));
    // OUTPUT(addressCounty, NAMED('addressCounty'));
    // OUTPUT(convertLayout, NAMED('convertLayout'));
    // OUTPUT(rollRelations, NAMED('rollRelations'));
        
    RETURN addAssociates;
END;