IMPORT BIPv2, Business_Risk_BIP, DueDiligence, Header, PAW, STD, Suppress;

/*
	Following Keys being used:
			paw.Key_Did
      paw.Key_contactid
*/
EXPORT getIndBusAssoc(DATASET(DueDiligence.Layouts.Indv_Internal) individuals,
                      Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                      BIPV2.mod_sources.iParams linkingOptions) := FUNCTION

    withPAW := JOIN(individuals, PAW.Key_Did,
                    KEYED(LEFT.inquiredDID = RIGHT.did),
                    TRANSFORM({UNSIGNED6 seq, UNSIGNED6 inquiredDID, UNSIGNED6 contactID, UNSIGNED4 historyDate},
                              SELF.seq := LEFT.seq;
                              SELF.historyDate := LEFT.historyDate;
                              SELF.inquiredDID := LEFT.inquiredDID;
                              SELF.contactID := RIGHT.contact_id;),
                    ATMOST(DueDiligence.Constants.MAX_ATMOST_1000),
                    KEEP(100));



    pawBusiness_unsuppressed := JOIN(withPAW, PAW.Key_contactid,
                                      KEYED(LEFT.contactID = RIGHT.contact_id),
                                      TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, UNSIGNED6 assocID, UNSIGNED4 historyDate, STRING8 dateFirstSeen, STRING8 dateLastSeen, UNSIGNED4 global_sid},
                                                SELF.global_sid := RIGHT.global_sid;
                                                SELF.seq := LEFT.seq;
                                                SELF.ultID := RIGHT.ultID;
                                                SELF.orgID := RIGHT.orgID;
                                                SELF.seleID := RIGHT.seleID;
                                                SELF.did := LEFT.inquiredDID;
                                                SELF.assocID := RIGHT.did;
                                                SELF.historyDate := LEFT.historyDate;
                                                SELF.dateFirstSeen := RIGHT.dt_first_seen;
                                                SELF.dateLastSeen := RIGHT.dt_last_seen;
                                                SELF := [];),
                                      ATMOST(DueDiligence.Constants.MAX_ATMOST_1000));

    pawBusiness := Suppress.MAC_SuppressSource(pawBusiness_unsuppressed, options);

    //clean the dates
    pawCleanDates := DueDiligence.Common.CleanDatasetDateFields(pawBusiness, 'dateFirstSeen, dateLastSeen');

    //filter out records after our history date
    filterPAW := DueDiligence.CommonDate.FilterRecordsSingleDate(pawCleanDates, dateFirstSeen);

    filterBusinessOnly := filterPAW(seleID > 0);
    filterBusAssocOnly := filterPAW(assocID > 0);

    //remove duplicate businesses
    uniquePAWBusinesses := DEDUP(SORT(filterBusinessOnly, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), dateFirstSeen, -dateLastSeen), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));

    uniqueBusinessID := PROJECT(uniquePAWBusinesses, TRANSFORM({UNSIGNED6 uniqueBusIdentifier, RECORDOF(LEFT)}, SELF.uniqueBusIdentifier := COUNTER; SELF := LEFT;));

    convertToBusiness := PROJECT(uniqueBusinessID, TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                                              SELF.seq := LEFT.uniqueBusIdentifier;
                                                              SELF.Busn_info.BIP_IDs.UltID.LinkID := LEFT.ultID;
                                                              SELF.Busn_info.BIP_IDs.OrgID.LinkID := LEFT.orgID;
                                                              SELF.Busn_info.BIP_IDs.SeleID.LinkID := LEFT.seleID;
                                                              SELF.Busn_info.inputSeq := LEFT.seq;
                                                              SELF.historydate := LEFT.historyDate;
                                                              SELF := [];));


    //get all associated business details, returns DS of DueDiligence.LayoutsInternal.IndBusAssociations
    allBusiness := DueDiligence.getIndBusAssocBus(convertToBusiness, options, linkingOptions);


    //add the inquired's did back in
    addInquiredToBusiness := JOIN(individuals, allBusiness,
                                  LEFT.seq = RIGHT.inputSeq,
                                  TRANSFORM(DueDiligence.LayoutsInternal.IndBusAssociations,
                                            SELF.did := LEFT.inquiredDID;
                                            SELF := RIGHT;));

    noAssocCounter := COUNT(uniqueBusinessID) + 1;

    //get individuals who had no business associations
    noBusAssoc := JOIN(individuals, uniqueBusinessID,
                        LEFT.seq = RIGHT.seq,
                        TRANSFORM(DueDiligence.LayoutsInternal.IndBusAssociations,
                                  SELF.inputSeq := LEFT.seq;
                                  SELF.did := LEFT.inquiredDID;
                                  SELF := [];),
                        LEFT ONLY);


    uniqueNoBusAssocID := PROJECT(noBusAssoc, TRANSFORM(DueDiligence.LayoutsInternal.IndBusAssociations, SELF.seq := COUNTER + noAssocCounter; SELF := LEFT;));

    //combine the BEOs with Inquireds
    allIndividuals := addInquiredToBusiness + uniqueNoBusAssocID;

    addInquiredBusAssoc := PROJECT(allIndividuals,
                                TRANSFORM(DueDiligence.LayoutsInternal.IndBusAssociations,
                                          busAssoc := DueDiligence.getIndKRIBusAssoc(LEFT);

                                          SELF.busAssocScore := busAssoc.name;
                                          SELF.busAssocFlags := busAssoc.value;
                                          SELF := LEFT;));


    //roll up associates for a given business per did
    sortAssociates := SORT(addInquiredBusAssoc, seq, ultID, orgID, seleID, did);
    rollAssociates := ROLLUP(sortAssociates,
                              LEFT.seq = RIGHT.seq AND
                              LEFT.ultID = RIGHT.ultID AND
                              LEFT.orgID = RIGHT.orgID AND
                              LEFT.seleID = RIGHT.seleID AND
                              LEFT.did = RIGHT.did,
                              TRANSFORM(DueDiligence.LayoutsInternal.IndBusAssociations,
                                        SELF.busAssociation.beos := LEFT.busAssociation.beos + RIGHT.busAssociation.beos;

                                        SELF.busAssocScore := MAX(LEFT.busAssocScore, RIGHT.busAssocScore);
                                        SELF.busAssocFlags := IF(LEFT.busAssocScore <> DueDiligence.Constants.EMPTY OR RIGHT.busAssocScore <> DueDiligence.Constants.EMPTY, DueDiligence.Common.RollFlags(busAssocFlags), DueDiligence.Constants.EMPTY);

                                        SELF := LEFT;));


    convertForDS := PROJECT(rollAssociates, TRANSFORM({UNSIGNED6 inputSeq, DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DATASET(DueDiligence.Layouts.BusAsscoiations) busAssociations, STRING2 busAssocScore, STRING10 busAssocFlags},
                                                      SELF.inputSeq := LEFT.inputSeq;
                                                      SELF.busAssociations := IF(LEFT.seleID > 0, LEFT.busAssociation);
                                                      SELF := LEFT;));


    sortConverted := SORT(convertForDS, inputSeq);
    rollConverted := ROLLUP(sortConverted,
                            LEFT.inputSeq = RIGHT.inputSeq,
                            TRANSFORM(RECORDOF(LEFT),
                                      SELF.busAssociations := LEFT.busAssociations + RIGHT.busAssociations;
                                      SELF.busAssocScore := MAX(LEFT.busAssocScore, RIGHT.busAssocScore);
                                      SELF.busAssocFlags := IF(LEFT.busAssocScore <> DueDiligence.Constants.EMPTY OR RIGHT.busAssocScore <> DueDiligence.Constants.EMPTY, DueDiligence.Common.RollFlags(busAssocFlags), DueDiligence.Constants.EMPTY);

                                      SELF := LEFT;));




    //add back to individual layout
    addAssociations := JOIN(individuals, rollConverted,
                            LEFT.seq = RIGHT.inputseq AND
                            LEFT.inquiredDID = RIGHT.did,
                            TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                      SELF.perBusinessAssociations := RIGHT.busAssociations;
                                      SELF.individual.busAssociationScore := RIGHT.busAssocScore;
                                      SELF.individual.busAssociationFlags := RIGHT.busAssocFlags;
                                      SELF := LEFT;));




    //get the BEOs
    beos := NORMALIZE(allBusiness, LEFT.busAssociation.beos, TRANSFORM(DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout,
                                                                          SELF.seq := LEFT.inputseq;
                                                                          SELF.did := RIGHT.did;
                                                                          SELF := [];));

    populatedBEODIDs := DEDUP(SORT(beos(did <> 0), seq, did), seq, did);


    //get the business associates that are not the inquired
    busAssociates := filterBusAssocOnly(did <> assocID);

    //remove duplicate business associates
    uniqueAssociates := DEDUP(SORT(busAssociates, did, assocID), did, assocID);

    //only care about associates that are NOT BEOs
    assocNotBEO := JOIN(uniqueAssociates, populatedBEODIDs,
                        LEFT.seq = RIGHT.seq AND
                        LEFT.assocID = RIGHT.did,
                        TRANSFORM(RECORDOF(LEFT),
                                  SELF := LEFT;),
                        LEFT ONLY);


    //add business associates to relationships of the inquired
    convertAssocToInquired := JOIN(individuals, assocNotBEO,
                                    LEFT.seq = RIGHT.seq AND
                                    LEFT.inquiredDID = RIGHT.did,
                                    TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                              SELF.seq := LEFT.seq;
                                              SELF.historyDate := LEFT.historyDate;
                                              SELF.inquiredDID := LEFT.inquiredDID;
                                              SELF.individual.did := RIGHT.assocID;
                                              SELF.indvType := DueDiligence.Constants.INQUIRED_INDIVIDUAL_BUSINESS_ASSOCIATE;
                                              SELF := [];));


    //pull unique individuals for best data - only need to do it once per person
    uniqueAssociateDIDs := DEDUP(SORT(convertAssocToInquired, individual.did), individual.did);

    bestAssocData := DueDiligence.getIndInformation(options).GetIndividualBestDataWithLexID(uniqueAssociateDIDs);


    addToInquired := JOIN(convertAssocToInquired, bestAssocData,
                          LEFT.individual.did = RIGHT.individual.did,
                          TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                    SELF.seq := LEFT.seq;
                                    SELF.inquiredDID := LEFT.inquiredDID;
                                    SELF := RIGHT;),
                          LEFT OUTER,
                          ATMOST(1));

    reformatAssociates := PROJECT(bestAssocData, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DATASET(DueDiligence.Layouts.SlimRelation) relations},
                                                        SELF.seq := LEFT.seq;
                                                        SELF.did := LEFT.inquiredDID;
                                                        SELF.relations := DATASET([TRANSFORM(DueDiligence.Layouts.SlimRelation,
                                                                                              SELF.relationToInquired := LEFT.indvType;
                                                                                              SELF.relationship := Header.relative_titles.num_associate;
                                                                                              SELF.rawRelationshipType := DueDiligence.Constants.INQUIRED_INDIVIDUAL_BUSINESS_ASSOCIATE;
                                                                                              SELF := LEFT.individual;
                                                                                              SELF := [];)]);
                                                        SELF := [];));

    sortReformatted := SORT(reformatAssociates, seq, did);
    rollReformatted := ROLLUP(sortReformatted,
                              LEFT.seq = RIGHT.seq AND
                              LEFT.did = RIGHT.did,
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.relations := LEFT.relations + RIGHT.relations;
                                        SELF := LEFT;));


    addAssociates := JOIN(addAssociations, rollReformatted,
                          LEFT.seq = RIGHT.seq AND
                          LEFT.inquiredDID = RIGHT.did,
                          TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                    SELF.associates := LEFT.associates + RIGHT.relations;
                                    SELF := LEFT;),
                          LEFT OUTER,
                          ATMOST(1));










    // OUTPUT(individuals, NAMED('individuals'));
    // OUTPUT(withPAW, NAMED('withPAW'));
    // OUTPUT(pawBusiness, NAMED('pawBusiness'));
    // OUTPUT(pawCleanDates, NAMED('pawCleanDates'));
    // OUTPUT(filterPAW, NAMED('filterPAW'));
    // OUTPUT(filterBusinessOnly, NAMED('filterBusinessOnly'));
    // OUTPUT(filterBusAssocOnly, NAMED('filterBusAssocOnly'));
    // OUTPUT(uniquePAWBusinesses, NAMED('uniquePAWBusinesses'));
    // OUTPUT(uniqueBusinessID, NAMED('uniqueBusinessID'));
    // OUTPUT(convertToBusiness, NAMED('convertToBusiness'));
    // OUTPUT(allBusiness, NAMED('allBusiness'));
    // OUTPUT(addInquiredToBusiness, NAMED('addInquiredToBusiness'));
    // OUTPUT(noAssocCounter, NAMED('noAssocCounter'));
    // OUTPUT(noBusAssoc, NAMED('noBusAssoc'));
    // OUTPUT(uniqueNoBusAssocID, NAMED('uniqueNoBusAssocID'));
    // OUTPUT(allIndividuals, NAMED('allIndividuals'));
    // OUTPUT(addInquiredBusAssoc, NAMED('addInquiredBusAssoc'));
    // OUTPUT(sortAssociates, NAMED('sortAssociates'));
    // OUTPUT(rollAssociates, NAMED('rollAssociates'));
    // OUTPUT(convertForDS, NAMED('convertForDS'));
    // OUTPUT(rollConverted, NAMED('rollConverted'));
    // OUTPUT(addAssociations, NAMED('addAssociations'));

    // OUTPUT(beos, NAMED('beos'));
    // OUTPUT(populatedBEODIDs, NAMED('populatedBEODIDs'));
    // OUTPUT(busAssociates, NAMED('busAssociates'));
    // OUTPUT(uniqueAssociates, NAMED('uniqueAssociates'));
    // OUTPUT(assocNotBEO, NAMED('assocNotBEO'));
    // OUTPUT(convertAssocToInquired, NAMED('convertAssocToInquired'));
    // OUTPUT(uniqueAssociateDIDs, NAMED('uniqueAssociateDIDs'));
    // OUTPUT(bestAssocData, NAMED('bestAssocData'));
    // OUTPUT(addToInquired, NAMED('addToInquired'));
    // OUTPUT(reformatAssociates, NAMED('reformatAssociates'));
    // OUTPUT(sortReformatted, NAMED('sortReformatted'));
    // OUTPUT(rollReformatted, NAMED('rollReformatted'));
    // OUTPUT(addAssociates, NAMED('addAssociates'));



    RETURN addAssociates;
END;
