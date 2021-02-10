IMPORT Business_Risk_BIP, Doxie, DueDiligence, Header, Relationship, RelationshipIdentifier_Services;


EXPORT getIndRelationships(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                           Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                           doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION



    NO_DIRECT_RELATION := [Header.relative_titles.num_associate, Header.relative_titles.num_Neighbor, Header.relative_titles.num_Business, Header.relative_titles.num_transactionalAssociate];
    GRANDPARENT_RELATION := [Header.relative_titles.num_Grandfather, Header.relative_titles.num_Grandmother, Header.relative_titles.num_Grandparent];



    getRelations(DATASET(Relationship.Layout_GetRelationship.DIDs_layout) listOfDIDs) := FUNCTION

        relativeIDs := Relationship.proc_GetRelationshipNeutral(listOfDIDs, TopNCount := 100, RelativeFlag := TRUE, AssociateFlag := TRUE,
                                                                doAtmost := TRUE, MaxCount := DueDiligence.Constants.MAX_ATMOST_1000).Result;

        RETURN relativeIDs(r2rdid = 0);
    END;


    getListOfRelations(relationData, filterRelativesBy) := FUNCTIONMACRO

        filteredRelations := relationData(indvType IN filterRelativesBy);

        //make sure we only have 1 relationship with a given DID
        uniqueDIDs := DEDUP(SORT(filteredRelations, seq, inquiredDID, individual.did), seq, inquiredDID, individual.did);

        reformatRelations := PROJECT(uniqueDIDs, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DATASET(DueDiligence.Layouts.SlimRelation) relations},
                                                            SELF.seq := LEFT.seq;
                                                            SELF.did := LEFT.inquiredDID;
                                                            SELF.relations := DATASET([TRANSFORM(DueDiligence.Layouts.SlimRelation,
                                                                                                  SELF.relationToInquired := MAP(LEFT.indvType IN [DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE] => DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE,
                                                                                                                                 LEFT.indvType IN [DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT] => DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT,
                                                                                                                                 DueDiligence.Constants.INQUIRED_INDIVIDUAL_OTHER_RELATION);

                                                                                                  SELF.rawRelationshipType := LEFT.indvType;
                                                                                                  SELF := LEFT.individual;
                                                                                                  SELF := [];)]);
                                                            SELF := [];));

        sortReformatted := SORT(reformatRelations, seq, did);
        rollReformatted := ROLLUP(sortReformatted,
                                  LEFT.seq = RIGHT.seq AND
                                  LEFT.did = RIGHT.did,
                                  TRANSFORM(RECORDOF(LEFT),
                                            SELF.relations := LEFT.relations + RIGHT.relations;
                                            SELF := LEFT;));

        RETURN rollReformatted;
    ENDMACRO;









    justDIDs := PROJECT(inData, TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.inquiredDID;));
    uniqueJustDIDs := DEDUP(SORT(justDIDs, did), did);

    firstDegreeRelationships := getRelations(uniqueJustDIDs);

    //grab high confident personal relationships for parents/spouses and everyone else who is not a confident personal parent/spouse
    filteredFirstDegree := firstDegreeRelationships((title IN [Header.relative_titles.set_Spouse, Header.relative_titles.set_Parent] AND TYPE = RelationshipIdentifier_Services.Constants.RELTYPE_PERSONAL AND CONFIDENCE = RelationshipIdentifier_Services.Constants.HIGH) OR title NOT IN [Header.relative_titles.set_Spouse, Header.relative_titles.set_Parent]);

    //pull off related DIDs, we don't care about associates/neighbors relationships to the inquired or generic relatives
    firstDegreeJustDIDs := PROJECT(filteredFirstDegree(title NOT IN [NO_DIRECT_RELATION, Header.relative_titles.num_relative]), TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.did2;));
    uniqueFirstDegreeDIDs := DEDUP(SORT(firstDegreeJustDIDs, did), did);

    //get second degree but remove anyone that has no relationship to the inquired
    secondDegreeRelationships := getRelations(uniqueFirstDegreeDIDs)(title NOT IN NO_DIRECT_RELATION);



    addFirstDegree := JOIN(inData, filteredFirstDegree,
                            LEFT.inquiredDID = RIGHT.did1,
                            TRANSFORM({UNSIGNED seq, UNSIGNED inquiredDID, UNSIGNED6 historyDate, BOOLEAN fd, UNSIGNED firstDegreeDID, UNSIGNED firstDegreeRelationship, integer firstDegreeSourceType, UNSIGNED secondDegreeDID, UNSIGNED secondDegreeRelationship, UNSIGNED secondDegreeRelationshipRaw/*, SET of UNSIGNED6 kid, SET of UNSIGNED6 sibling*/},
                                      SELF.seq := LEFT.seq;
                                      SELF.inquiredDID := LEFT.inquiredDID;
                                      SELF.historyDate := LEFT.historyDate;

                                      SELF.fd := TRUE;
                                      SELF.firstDegreeDID := RIGHT.did2;
                                      SELF.firstDegreeRelationship := IF(RIGHT.title = Header.relative_titles.num_associate, CASE(RIGHT.source_type,
                                                                                                                                  -3 => DueDiligence.Constants.RELATIONSHIP_ROOM_MATE,
                                                                                                                                  -4 => DueDiligence.Constants.RELATIONSHIP_BUSINESS,
                                                                                                                                  -5 => DueDiligence.Constants.RELATIONSHIP_REAL_ESTATE,
                                                                                                                                  -6 => DueDiligence.Constants.RELATIONSHIP_OTHER_PROPERTY,
                                                                                                                                  Header.relative_titles.num_associate), RIGHT.title);
                                      SELF.firstDegreeSourceType := RIGHT.source_type;

                                      SELF := [];));


    addSecondDegree := JOIN(addFirstDegree, secondDegreeRelationships,
                             LEFT.firstDegreeDID = RIGHT.did1,
                             TRANSFORM(RECORDOF(LEFT),
                                        SELF.secondDegreeDID := RIGHT.did2;

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
                                        SELF.secondDegreeRelationshipRaw := RIGHT.title;
                                        SELF := LEFT;));

    //only grab those relations that pertain to the inquired
    //filter our inquired/spouse/parents/child/siblings, they should have been tied via the first degree to reduce incorrectly tied relationships
    filterNoRelation := addSecondDegree(secondDegreeRelationship BETWEEN 1 AND 43 AND secondDegreeRelationship NOT IN [Header.relative_titles.set_Spouse, Header.relative_titles.set_Parent, Header.relative_titles.set_Child, Header.relative_titles.set_Sibling, Header.relative_titles.num_Subject]);

    relation1 := PROJECT(filterNoRelation, TRANSFORM(RECORDOF(LEFT),
                                                      SELF.seq := LEFT.seq;
                                                      SELF.inquiredDID := LEFT.inquiredDID;
                                                      SELF.firstDegreeDID := LEFT.secondDegreeDID;
                                                      SELF.firstDegreeRelationship := LEFT.secondDegreeRelationship;
                                                      SELF := [];));


    sortRemainingRelations := SORT(addFirstDegree + relation1, seq, inquiredDID, firstDegreeDID, firstDegreeRelationship);

    rollData := ROLLUP(sortRemainingRelations,
                        LEFT.seq = RIGHT.seq AND
                        LEFT.inquiredDID = RIGHT.inquiredDID AND
                        LEFT.firstDegreeDID = RIGHT.firstDegreeDID,
                        TRANSFORM(RECORDOF(LEFT),
                                  SELF.fd := LEFT.fd OR RIGHT.fd;
                                  SELF := LEFT;));

    rellyIndv := PROJECT(rollData, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                              SELF.seq := LEFT.seq;
                                              SELF.historyDate := LEFT.historyDate;
                                              SELF.inquiredDID := LEFT.inquiredDID;
                                              SELF.individual.did := LEFT.firstDegreeDID;
                                              SELF.indvType := MAP(LEFT.firstDegreeRelationship IN Header.relative_titles.set_Spouse => DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE,
                                                                   LEFT.firstDegreeRelationship IN Header.relative_titles.set_Parent => DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT,
                                                                   LEFT.fd = FALSE => DueDiligence.Constants.INQUIRED_INDIVIDUAL_SECOND_DEGREE,
                                                                   DueDiligence.Constants.INQUIRED_INDIVIDUAL_FIRST_DEGREE);
                                              SELF.individual.relationship := LEFT.firstDegreeRelationship;
                                              SELF := [];));

    uniqueRelly := DEDUP(SORT(rellyIndv, individual.did), individual.did);

    bestRellyData := DueDiligence.getIndInformation(options, mod_access).GetIndividualBestDataWithLexID(uniqueRelly);

    addBestRellyData := JOIN(rellyIndv, bestRellyData,
                             LEFT.individual.did = RIGHT.individual.did,
                             TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                        SELF.seq := LEFT.seq;
                                        SELF.historyDate := LEFT.historyDate;
                                        SELF.inquiredDID := LEFT.inquiredDID;
                                        SELF.indvType := LEFT.indvType;
                                        SELF.individual.relationship := LEFT.individual.relationship;
                                        SELF := RIGHT;),
                             LEFT OUTER);


    //filter minors - those that do not have name, address, ssn, dob
    filterMinors := addBestRellyData(individual.firstName <> '' OR individual.middleName <> '' OR individual.lastName <> '' OR
                                      individual.ssn <> '' OR individual.dob <> 0 OR
                                      individual.streetAddress1 <> '' OR individual.city <> '' OR individual.state <> '' OR individual.zip5 <> '');


    slimmedRolledSpouseData := getListOfRelations(filterMinors, [DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE]);
    slimmedRolledParentData := getListOfRelations(filterMinors, [DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT]);
    slimmedRolledRelationData := getListOfRelations(filterMinors, [DueDiligence.Constants.INQUIRED_INDIVIDUAL_FIRST_DEGREE, DueDiligence.Constants.INQUIRED_INDIVIDUAL_SECOND_DEGREE]);


    addSpouse := JOIN(inData, slimmedRolledSpouseData,
                      LEFT.seq = RIGHT.seq AND
                      LEFT.inquiredDID = RIGHT.did,
                      TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                SELF.spouses := LEFT.spouses + RIGHT.relations;
                                SELF := LEFT;),
                      LEFT OUTER,
                      ATMOST(DueDiligence.Constants.MAX_ATMOST_1));

    addParents := JOIN(addSpouse, slimmedRolledParentData,
                        LEFT.seq = RIGHT.seq AND
                        LEFT.inquiredDID = RIGHT.did,
                        TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                  SELF.parents := LEFT.parents + RIGHT.relations;
                                  SELF.hasParent := COUNT(RIGHT.relations) > 0;
                                  SELF := LEFT;),
                        LEFT OUTER,
                        ATMOST(DueDiligence.Constants.MAX_ATMOST_1));

    addOtherRelations := JOIN(addParents, slimmedRolledRelationData,
                              LEFT.seq = RIGHT.seq AND
                              LEFT.inquiredDID = RIGHT.did,
                              TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                        SELF.associates := LEFT.associates + RIGHT.relations;
                                        SELF := LEFT;),
                              LEFT OUTER,
                              ATMOST(DueDiligence.Constants.MAX_ATMOST_1));






    // OUTPUT(inData, NAMED('relativeInData'));
    // OUTPUT(firstDegreeRelationships, NAMED('firstDegreeRelationships'));
    // OUTPUT(filteredFirstDegree, NAMED('filteredFirstDegree'));

    // OUTPUT(firstDegreeJustDIDs, NAMED('firstDegreeJustDIDs'));
    // OUTPUT(uniqueFirstDegreeDIDs, NAMED('uniqueFirstDegreeDIDs'));

    // OUTPUT(secondDegreeRelationships, NAMED('secondDegreeRelationships'));

    // OUTPUT(addFirstDegree, NAMED('addFirstDegree'));
    // OUTPUT(addSecondDegree, NAMED('addSecondDegree'));

    // OUTPUT(filterNoRelation, NAMED('filterNoRelation'));
    // OUTPUT(relation1, NAMED('relation1'));
    // OUTPUT(sortRemainingRelations, NAMED('sortRemainingRelations'));
    // OUTPUT(rollData, NAMED('rollData'));

    // OUTPUT(rellyIndv, NAMED('rellyIndv'));
    // OUTPUT(uniqueRelly, NAMED('uniqueRelly'));
    // OUTPUT(bestRellyData, NAMED('bestRellyData'));
    // OUTPUT(addBestRellyData, NAMED('addBestRellyData'));

    // OUTPUT(slimmedRolledSpouseData, NAMED('slimmedRolledSpouseData'));
    // OUTPUT(slimmedRolledParentData, NAMED('slimmedRolledParentData'));
    // OUTPUT(slimmedRolledRelationData, NAMED('slimmedRolledRelationData'));

    // OUTPUT(addSpouse, NAMED('addSpouse'));
    // OUTPUT(addParents, NAMED('addParents'));
    // OUTPUT(addOtherRelations, NAMED('addOtherRelations'));




    RETURN addOtherRelations;

END;
