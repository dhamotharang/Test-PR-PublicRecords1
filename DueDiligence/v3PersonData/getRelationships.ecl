IMPORT DueDiligence, Header, Relationship, RelationshipIdentifier_Services;


EXPORT getRelationships(DATASET(DueDiligence.v3Layouts.Internal.PersonTemp) inData,
                        DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess,
                        BOOLEAN includeSpouses,
                        BOOLEAN includeParents,
                        BOOLEAN includeOtherRelationships,
                        BOOLEAN includeReportData) := FUNCTION
                                         
                                         
 									
    //CONSTANTS
    NO_DIRECT_RELATION := [Header.relative_titles.num_associate, Header.relative_titles.num_Neighbor, Header.relative_titles.num_Business, Header.relative_titles.num_transactionalAssociate];
    GRANDPARENT_RELATION := [Header.relative_titles.num_Grandfather, Header.relative_titles.num_Grandmother, Header.relative_titles.num_Grandparent];

    
  
  
    //INTERNAL FUNCTIONS
    fn_getRelations(DATASET(Relationship.Layout_GetRelationship.DIDs_layout) listOfDIDs) := FUNCTION
      
        relativeIDs := Relationship.proc_GetRelationshipNeutral(listOfDIDs, TopNCount := 100, RelativeFlag := TRUE, AssociateFlag := TRUE, 
                                                                doAtmost := TRUE, MaxCount := DueDiligence.Constants.MAX_1000).Result;
                                                          
        RETURN PROJECT(relativeIDs(r2rdid = 0), TRANSFORM(DueDiligence.v3Layouts.InternalPerson.SlimRelationshipLayout, 
                                                          SELF.did1 := LEFT.did1;
                                                          SELF.did2 := LEFT.did2;
                                                          SELF.title := LEFT.title;
                                                          SELF.sourceType := LEFT.source_type;
                                                          SELF.relationshipType := LEFT.type;
                                                          SELF.confidence := LEFT.confidence;
                                                          SELF := [];));//TO RESEARCH: AND TRIM(STD.Str.ToUpperCase(cluster)) <> 'DEAD'
    END;
    
    
    
    fn_getListOfRelations(DATASET(DueDiligence.v3Layouts.InternalPerson.SlimRelationshipLayout) filteredData) := FUNCTION
        
        slimInd := JOIN(inData, filteredData, 
                        LEFT.inquiredDID = RIGHT.did1,
                        TRANSFORM(DueDiligence.v3Layouts.InternalPerson.SlimBestSearch,
                                  SELF.lexID := RIGHT.did2;
                                  SELF.inquiredLexID := RIGHT.did1;
                                  SELF.historyDate := LEFT.historyDate;
                                  SELF.relationship := RIGHT.title;
                                  SELF := [];));  
                                  
        uniqueLexIDs := DEDUP(SORT(slimInd, lexID), lexID);
        
        bestData := DueDiligence.v3PersonData.getBestData(regulatoryAccess).GetIndividualBestDataWithLexID(uniqueLexIDs);
        
        addSlimAndBestData := JOIN(slimInd, bestData,
                                    LEFT.lexID = RIGHT.lexID,
                                    TRANSFORM(DueDiligence.v3Layouts.InternalPerson.SlimBestSearch,
                                              SELF.inquiredLexID := LEFT.inquiredLexID;
                                              SELF.relationship := LEFT.relationship;
                                              SELF := RIGHT;
                                              SELF := [];));
                                   
              
        relations := IF(includeReportData, addSlimAndBestData, slimInd);
        
        convertRelations := PROJECT(relations, TRANSFORM({UNSIGNED6 inquiredLexID, STRING2 relationCat, UNSIGNED2 relationRaw, UNSIGNED6 relationID, DATASET(DueDiligence.v3Layouts.Internal.SlimPerson) parent, DATASET(DueDiligence.v3Layouts.Internal.SlimPerson) spouse, DATASET(DueDiligence.v3Layouts.Internal.SlimPerson) otherRelation},
                                                          indiv := DATASET([TRANSFORM(DueDiligence.v3Layouts.Internal.SlimPerson, 
                                                                                      SELF.lexID := LEFT.lexID; 
                                                                                      SELF.relationship := LEFT.relationship;
                                                                                      SELF.fullName := LEFT.fullName;
                                                                                      SELF.firstName := LEFT.firstName;
                                                                                      SELF.middleName := LEFT.middleName;
                                                                                      SELF.lastName := LEFT.lastName;
                                                                                      SELF.suffix := LEFT.suffix;	 
                                                                                      
                                                                                      SELF.dob := LEFT.dob;
                                                                                      SELF.phone := LEFT.phone;
                                                                                      SELF.ssn := LEFT.ssn;
                                                                                      
                                                                                      SELF.streetAddress1 := LEFT.streetAddress1;
                                                                                      SELF.streetAddress2 := LEFT.streetAddress2;
                                                                                      SELF.prim_range := LEFT.prim_range;
                                                                                      SELF.predir := LEFT.predir;
                                                                                      SELF.prim_name := LEFT.prim_name;
                                                                                      SELF.addr_suffix := LEFT.addr_suffix;
                                                                                      SELF.postdir := LEFT.postdir;
                                                                                      SELF.unit_desig := LEFT.unit_desig;
                                                                                      SELF.sec_range := LEFT.sec_range;
                                                                                      SELF.city := LEFT.city;
                                                                                      SELF.state := LEFT.state;
                                                                                      SELF.zip := LEFT.zip;
                                                                                      SELF.zip4 := LEFT.zip4;
                                                                                      SELF.geo_blk := LEFT.geo_blk;
                                                                                      SELF.county := LEFT.county;
                                                                                      SELF := [];)]);
                                                          
                                                          SELF.inquiredLexID := LEFT.inquiredLexID;
                                                          SELF.parent := IF(LEFT.relationship IN Header.relative_titles.set_Parent, indiv);
                                                          SELF.spouse := IF(LEFT.relationship IN Header.relative_titles.set_Spouse, indiv);
                                                          SELF.otherRelation := IF(LEFT.relationship NOT IN [Header.relative_titles.set_Spouse, Header.relative_titles.set_Parent], indiv);
                                                          
                                                          SELF.relationCat := MAP(LEFT.relationship IN Header.relative_titles.set_Parent => DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT,
                                                                                  LEFT.relationship IN Header.relative_titles.set_Spouse => DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE,
                                                                                  DueDiligence.Constants.INQUIRED_INDIVIDUAL_OTHER_RELATION);
                                                          SELF.relationRaw := LEFT.relationship;
                                                          SELF.relationID := LEFT.lexID;
                                                          
                                                          SELF := [];));
                                                          
        //limit each relationship category to return only max parties
        grpRelationsParent := GROUP(SORT(convertRelations(relationCat = DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT), inquiredLexID, relationRaw, relationID), inquiredLexID);
        maxParents := DueDiligence.v3Common.General.GetMaxNumberOfRecords(grpRelationsParent, DueDiligence.Constants.MAX_PARENTS);
                            
        grpRelationsSpouse := GROUP(SORT(convertRelations(relationCat = DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE), inquiredLexID, relationRaw, relationID), inquiredLexID);
        maxSpouses := DueDiligence.v3Common.General.GetMaxNumberOfRecords(grpRelationsSpouse, DueDiligence.Constants.MAX_PARENTS);
                            
        grpRelationsOther := GROUP(SORT(convertRelations(relationCat = DueDiligence.Constants.INQUIRED_INDIVIDUAL_OTHER_RELATION), inquiredLexID, relationRaw, relationID), inquiredLexID);
        maxOthers := DueDiligence.v3Common.General.GetMaxNumberOfRecords(grpRelationsOther, DueDiligence.Constants.MAX_PARENTS);
        
        limitedRelations := maxParents + maxSpouses + maxOthers;
                                                                  
        rollRelationships := ROLLUP(SORT(limitedRelations, inquiredLexID),
                                    LEFT.inquiredLexID = RIGHT.inquiredLexID,
                                    TRANSFORM(RECORDOF(LEFT),
                                              SELF.inquiredLexID := LEFT.inquiredLexID;
                                              SELF.parent := LEFT.parent + RIGHT.parent;
                                              SELF.spouse := LEFT.spouse + RIGHT.spouse;
                                              SELF.otherRelation := LEFT.otherRelation + RIGHT.otherRelation;
                                              SELF := LEFT;));
      
        RETURN JOIN(inData, rollRelationships,
                     LEFT.inquiredDID = RIGHT.inquiredLexID,
                     TRANSFORM(DueDiligence.v3Layouts.Internal.PersonTemp,
                               SELF.spouses := RIGHT.spouse;
                               SELF.parents := RIGHT.parent;
                               SELF.associations := RIGHT.otherRelation;
                               SELF := LEFT;),
                     LEFT OUTER,
                     ATMOST(1));
    END;
    
    
    
    fn_getSpouseParents(DATASET(DueDiligence.v3Layouts.InternalPerson.SlimRelationshipLayout) inFirstDegree) := FUNCTION
    
        filtSpouseParent := MAP(includeSpouses AND includeParents => inFirstDegree(title IN [Header.relative_titles.set_Spouse, Header.relative_titles.set_Parent]),
                                includeSpouses => inFirstDegree(title IN Header.relative_titles.set_Spouse),
                                inFirstDegree(title IN Header.relative_titles.set_Parent));
                                
        
                                       

        RETURN fn_getListOfRelations(filtSpouseParent);
    END;
    
    
    
    fn_getAllRelationships(DATASET(DueDiligence.v3Layouts.InternalPerson.SlimRelationshipLayout) inFirstDegree) := FUNCTION
        // pull off related DIDs, we don't care about associates/neighbors relationships to the inquired or generic relatives
        firstDegreeJustDIDs := PROJECT(inFirstDegree(title NOT IN [NO_DIRECT_RELATION, Header.relative_titles.num_relative]), TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.did2;));
        uniqueFirstDegreeDIDs := DEDUP(SORT(firstDegreeJustDIDs, did), did);
        
        // get second degree but remove anyone that has no relationship to the inquired
        secondDegreeRelationships := fn_getRelations(uniqueFirstDegreeDIDs)(title NOT IN NO_DIRECT_RELATION);
        
        //create a new structure to translate all relationships
        addFirstDegreeToInquired := JOIN(inData, inFirstDegree,
                                          LEFT.inquiredDID = RIGHT.did1,
                                          TRANSFORM({UNSIGNED seq, UNSIGNED inquiredDID, UNSIGNED6 historyDate, UNSIGNED firstDegreeDID, UNSIGNED firstDegreeRelationship, UNSIGNED secondDegreeDID, UNSIGNED secondDegreeRelationship},
                                                    SELF.seq := LEFT.seq;
                                                    SELF.inquiredDID := LEFT.inquiredDID;
                                                    SELF.historyDate := LEFT.historyDate;
                                                    SELF.firstDegreeDID := RIGHT.did2;
                                                    SELF.firstDegreeRelationship := IF(RIGHT.title = Header.relative_titles.num_associate, CASE(RIGHT.sourceType,
                                                                                                                                                -3 => DueDiligence.Constants.RELATIONSHIP_ROOM_MATE,
                                                                                                                                                -4 => DueDiligence.Constants.RELATIONSHIP_BUSINESS,
                                                                                                                                                -5 => DueDiligence.Constants.RELATIONSHIP_REAL_ESTATE,
                                                                                                                                                -6 => DueDiligence.Constants.RELATIONSHIP_OTHER_PROPERTY,
                                                                                                                                                Header.relative_titles.num_associate), RIGHT.title);
                                                                                                                                                
                                                    SELF := [];));
                                                    
        addSecondDegreeRelation := JOIN(addFirstDegreeToInquired, secondDegreeRelationships,
                                         LEFT.firstDegreeDID = RIGHT.did1,
                                         TRANSFORM(RECORDOF(LEFT),
                                                    SELF.secondDegreeDID := RIGHT.did2;
                                                    
                                                    //need to translate as the relationships of the second degree is to the first degree
                                                    //meaning if the 1st degree relationship is spouse (so the inquired's spouse) and
                                                    //the 2nd degree relationship to the 1st degree is parent then
                                                    //that would mean the spouse's parent is the inquiured's parent-in-law
                                                    sdRelation := MAP(RIGHT.did2 = LEFT.inquiredDID => Header.relative_titles.num_Subject, //inquired
                                                                       
                                                                       LEFT.firstDegreeRelationship IN GRANDPARENT_RELATION AND RIGHT.title IN Header.relative_titles.set_Spouse => CASE(RIGHT.title, Header.relative_titles.num_Husband => Header.relative_titles.num_Grandfather, Header.relative_titles.num_Wife => Header.relative_titles.num_Grandmother, Header.relative_titles.num_Grandparent), //grandparent to inquired
                                                    
                                                                       LEFT.firstDegreeRelationship IN Header.relative_titles.set_Parent AND RIGHT.title IN Header.relative_titles.set_Spouse => CASE(RIGHT.title, Header.relative_titles.num_Husband => Header.relative_titles.num_Father, Header.relative_titles.num_Wife => Header.relative_titles.num_Mother, Header.relative_titles.num_Parent), //parent to inquired
                                                                       LEFT.firstDegreeRelationship IN Header.relative_titles.set_Parent AND RIGHT.title IN Header.relative_titles.set_Parent => CASE(RIGHT.title, Header.relative_titles.num_Father => Header.relative_titles.num_Grandfather, Header.relative_titles.num_Mother => Header.relative_titles.num_Grandmother, Header.relative_titles.num_Grandparent), //grandparent to inquired
                                                                       LEFT.firstDegreeRelationship IN Header.relative_titles.set_Parent AND RIGHT.title IN Header.relative_titles.set_Sibling => CASE(RIGHT.title, Header.relative_titles.num_Brother => Header.relative_titles.num_auncle, Header.relative_titles.num_Sister => Header.relative_titles.num_aunt, Header.relative_titles.num_relative), //aunt or uncle to inquired
                                                                       LEFT.firstDegreeRelationship IN Header.relative_titles.set_Parent AND RIGHT.title IN Header.relative_titles.set_Child => CASE(RIGHT.title, Header.relative_titles.num_Son => Header.relative_titles.num_Brother, Header.relative_titles.num_Daughter => Header.relative_titles.num_Sister, Header.relative_titles.num_Sibling), //sibling to inquired
                                                                       
                                                                       LEFT.firstDegreeRelationship IN Header.relative_titles.set_Sibling AND RIGHT.title IN Header.relative_titles.set_Spouse => CASE(RIGHT.title, Header.relative_titles.num_Husband => Header.relative_titles.num_BrotherInlaw, Header.relative_titles.num_Wife => Header.relative_titles.num_SisterInlaw, Header.relative_titles.num_SiblingInlaw), //sibling-in-law to inquired
                                                                       LEFT.firstDegreeRelationship IN Header.relative_titles.set_Sibling AND RIGHT.title IN Header.relative_titles.set_Child => CASE(RIGHT.title, Header.relative_titles.num_Son => Header.relative_titles.num_nephew, Header.relative_titles.num_Daughter => Header.relative_titles.num_niece, Header.relative_titles.num_relative), //niece or nephew to inquired
                                                                       LEFT.firstDegreeRelationship IN Header.relative_titles.set_Sibling AND RIGHT.title IN Header.relative_titles.set_Parent => RIGHT.title, //parent to inquired
                                                                       LEFT.firstDegreeRelationship IN Header.relative_titles.set_Sibling => RIGHT.title, //should be the same relation to inquired as their sibling
                                                                       
                                                                       LEFT.firstDegreeRelationship IN Header.relative_titles.set_Child AND RIGHT.title IN Header.relative_titles.set_Parent => CASE(RIGHT.title, Header.relative_titles.num_Father => Header.relative_titles.num_Husband, Header.relative_titles.num_Mother => Header.relative_titles.num_Wife, Header.relative_titles.num_Parent), //spouse
                                                                       LEFT.firstDegreeRelationship IN Header.relative_titles.set_Child AND RIGHT.title IN Header.relative_titles.set_Sibling => CASE(RIGHT.title, Header.relative_titles.num_Brother => Header.relative_titles.num_Son, Header.relative_titles.num_Sister => Header.relative_titles.num_Daughter, Header.relative_titles.num_Child), //child to inquired
                                                                       LEFT.firstDegreeRelationship IN Header.relative_titles.set_Child AND RIGHT.title IN Header.relative_titles.set_Child => CASE(RIGHT.title, Header.relative_titles.num_Son => Header.relative_titles.num_Grandson, Header.relative_titles.num_Daughter => Header.relative_titles.num_Granddaughter, Header.relative_titles.num_Gradchild), //grandkid to inquired
                                                                       LEFT.firstDegreeRelationship IN Header.relative_titles.set_Child AND RIGHT.title IN Header.relative_titles.set_Spouse => 0, //child-in-law to inquired
                                                                       
                                                                       LEFT.firstDegreeRelationship IN Header.relative_titles.set_Spouse AND RIGHT.title IN Header.relative_titles.set_Parent => CASE(RIGHT.title, Header.relative_titles.num_Father => Header.relative_titles.num_FatherInlaw, Header.relative_titles.num_Mother => Header.relative_titles.num_MotherInlaw, Header.relative_titles.num_ParentInlaw), //parent-in-law to inquired
                                                                       LEFT.firstDegreeRelationship IN Header.relative_titles.set_Spouse AND RIGHT.title IN Header.relative_titles.set_Sibling => CASE(RIGHT.title, Header.relative_titles.num_Brother => Header.relative_titles.num_BrotherInlaw, Header.relative_titles.num_Sister => Header.relative_titles.num_SisterInlaw, Header.relative_titles.num_SiblingInlaw), //sibling-in-law to inquired
                                                                       LEFT.firstDegreeRelationship IN Header.relative_titles.set_Spouse AND RIGHT.title IN Header.relative_titles.set_Child => RIGHT.title, //child to inquired
                                                                       LEFT.firstDegreeRelationship IN Header.relative_titles.set_Spouse => Header.relative_titles.num_Inlaw, //inquired in-law of some sort
                                                                       
                                                                       LEFT.firstDegreeRelationship < Header.relative_titles.num_associate AND RIGHT.title < Header.relative_titles.num_associate => Header.relative_titles.num_relative, //some relative relationship to the inquired
                                                                       RIGHT.title);
                                                    
                                                    SELF.secondDegreeRelationship := sdRelation;
                                                    SELF := LEFT;));
          
          
        //only grab those relations that pertain to the inquired
        //filter out inquired/spouse/parents/child/siblings, they should have been tied via the first degree to reduce incorrectly tied relationships
        filterToInquired := addSecondDegreeRelation(secondDegreeRelationship BETWEEN 1 AND 43 AND secondDegreeRelationship NOT IN [Header.relative_titles.set_Spouse, Header.relative_titles.set_Parent, Header.relative_titles.set_Child, Header.relative_titles.set_Sibling, Header.relative_titles.num_Subject]);
        
        //convert the 2nd degree relations to first degree fields to add with first and roll up
        convertSecondToFirst := PROJECT(filterToInquired, TRANSFORM(RECORDOF(LEFT),
                                                                    SELF.seq := LEFT.seq;
                                                                    SELF.inquiredDID := LEFT.inquiredDID;
                                                                    SELF.firstDegreeDID := LEFT.secondDegreeDID;
                                                                    SELF.firstDegreeRelationship := LEFT.secondDegreeRelationship;
                                                                    SELF := [];));
                                                                    
        sortRemainingRelations := SORT(addFirstDegreeToInquired + convertSecondToFirst, seq, inquiredDID, firstDegreeDID, firstDegreeRelationship);
         
        dedupData := DEDUP(sortRemainingRelations, seq, inquiredDID, firstDegreeDID);
                                      
        convertBackToRelationshipLayout := PROJECT(dedupData, TRANSFORM(DueDiligence.v3Layouts.InternalPerson.SlimRelationshipLayout,
                                                                        SELF.did1 := LEFT.inquiredDID;
                                                                        SELF.did2 := LEFT.firstDegreeDID;
                                                                        SELF.title := LEFT.firstDegreeRelationship;
                                                                        SELF := [];));
 
        RETURN fn_getListOfRelations(convertBackToRelationshipLayout);
    
    END;
		
	
	
  
  
  
  
  
    //MAIN LOGIC
    justInputDIDs := PROJECT(inData, TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.inquiredDID;));	
    uniqueJustInputDIDs := DEDUP(SORT(justInputDIDs, did), did);

    firstDegreeRelationships := fn_getRelations(uniqueJustInputDIDs);

    //grab high confident personal relationships for parents/spouses and everyone else who is not a confident personal parent/spouse
    filteredFirstDegree := firstDegreeRelationships((title IN [Header.relative_titles.set_Spouse, Header.relative_titles.set_Parent] AND relationshipType = RelationshipIdentifier_Services.Constants.RELTYPE_PERSONAL AND confidence = RelationshipIdentifier_Services.Constants.HIGH) OR title NOT IN [Header.relative_titles.set_Spouse, Header.relative_titles.set_Parent]);
    
    
    //based on the data being requested, only populate what is needed
    getRequestedData := MAP(includeOtherRelationships = FALSE  => fn_getSpouseParents(filteredFirstDegree),
                            includeOtherRelationships => fn_getAllRelationships(filteredFirstDegree),
                            inData);


    
    // OUTPUT(uniqueJustInputDIDs, NAMED('uniqueJustInputDIDs'));
    // OUTPUT(firstDegreeRelationships, NAMED('firstDegreeRelationships'));
    // OUTPUT(filteredFirstDegree, NAMED('filteredFirstDegree'));
    // OUTPUT(getRequestedData, NAMED('getRequestedData'));
    
    RETURN getRequestedData;
END;