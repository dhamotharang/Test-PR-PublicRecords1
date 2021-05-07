IMPORT Business_Risk_BIP, DueDiligence, dx_header, iesp, Suppress;


/*
	Following Keys being used:
			dx_header.key_wild_SSN
*/
EXPORT reportIndIdentitySSNVariation(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                                      Business_Risk_BIP.LIB_Business_Shell_LIBIN options
                                      ) := FUNCTION



    STRING RELATION_SELF := 'Self';



    ssnVariations := NORMALIZE(inData, LEFT.ssnOnFile, TRANSFORM(DueDiligence.LayoutsInternalReport.PersonSSNDeviation,
                                                                  SELF.seq := LEFT.seq;
                                                                  SELF.inquiredDID := LEFT.inquiredDID;
                                                                  SELF.historyDate := LEFT.historyDate;
                                                                  SELF.inputSSN := LEFT.indvRawInput.ssn;
                                                                  SELF.maskedInputSSN := LEFT.indvRawInput.ssn;
                                                                  SELF.ssnOnFile := RIGHT.ssn;
                                                                  SELF.maskedSSNOnFile := RIGHT.ssn;
                                                                  SELF.bestSSN := LEFT.bestSSN;
                                                                  SELF.maskedBestSSN := LEFT.bestSSN;
                                                                  SELF.inquiredBestSSN := LEFT.bestSSN;
                                                                  SELF.bestDOB := LEFT.bestDOB;
                                                                  SELF.bestName := LEFT.bestName;
                                                                  SELF.bestAddress := LEFT.bestAddress;
                                                                  SELF.didTiedToSSN := 0;
                                                                  SELF.relation := 0;
                                                                  SELF.relationText := '';
                                                                  SELF.differentSSNs := 0;
                                                                  SELF.differentBestSSNs := 0;
                                                                  SELF.reportedSSNs := DATASET([], iesp.duediligencepersonreport.t_DDRPersonSSNLexID);
                                                                  SELF.inputPersonDeviations := DATASET([], iesp.duediligencepersonreport.t_DDRPersonSSNDeviations);
                                                                  SELF.bestPersonDeviations := DATASET([], iesp.duediligencepersonreport.t_DDRPersonSSNDeviations);));


		getLexIDsBySSNs := JOIN(ssnVariations, dx_header.key_wild_SSN(),
                            LEFT.ssnOnFile <> '' AND
                            KEYED(LEFT.ssnOnFile[1] = RIGHT.s1) AND
                            KEYED(LEFT.ssnOnFile[2] = RIGHT.s2) AND
                            KEYED(LEFT.ssnOnFile[3] = RIGHT.s3) AND
                            KEYED(LEFT.ssnOnFile[4] = RIGHT.s4) AND
                            KEYED(LEFT.ssnOnFile[5] = RIGHT.s5) AND
                            KEYED(LEFT.ssnOnFile[6] = RIGHT.s6) AND
                            KEYED(LEFT.ssnOnFile[7] = RIGHT.s7) AND
                            KEYED(LEFT.ssnOnFile[8] = RIGHT.s8) AND
                            KEYED(LEFT.ssnOnFile[9] = RIGHT.s9),
                            TRANSFORM(DueDiligence.LayoutsInternalReport.PersonSSNDeviation,
                                      SELF.seq := LEFT.seq;
                                      SELF.inquiredDID := LEFT.inquiredDID;
                                      SELF.historyDate := LEFT.historyDate;

                                      SELF.inputSSN := LEFT.inputSSN;;
                                      SELF.maskedInputSSN := LEFT.maskedInputSSN;

                                      SELF.ssnOnFile := LEFT.ssnOnFile;
                                      SELF.maskedSSNOnFile := LEFT.maskedSSNOnFile;

                                      SELF.inquiredBestSSN := LEFT.inquiredBestSSN;

                                      BOOLEAN inquired := LEFT.inquiredDID = RIGHT.did;

                                      SELF.bestSSN := IF(inquired, LEFT.bestSSN, '');
                                      SELF.maskedBestSSN := IF(inquired, LEFT.bestSSN, '');

                                      SELF.bestDOB := IF(inquired, LEFT.bestDOB, 0);
                                      SELF.bestName := IF(inquired, LEFT.bestName, DATASET([], DueDiligence.Layouts.Name)[1]);
                                      SELF.bestAddress := IF(inquired, LEFT.bestAddress, DATASET([], DueDiligence.Layouts.Address)[1]);

                                      SELF.didTiedToSSN := RIGHT.did;
                                      SELF.relation := IF(inquired, dx_header.relative_titles.num_Subject, 0);
                                      SELF.relationText := IF(inquired, RELATION_SELF, '');
                                      SELF.differentSSNs := 0;
                                      SELF.differentBestSSNs := 0;

                                      SELF.reportedSSNs := DATASET([], iesp.duediligencepersonreport.t_DDRPersonSSNLexID);
                                      SELF.bestPersonDeviations := DATASET([], iesp.duediligencepersonreport.t_DDRPersonSSNDeviations);
                                      SELF.inputPersonDeviations := DATASET([], iesp.duediligencepersonreport.t_DDRPersonSSNDeviations);),
                            LEFT OUTER,
                            ATMOST(DueDiligence.Constants.MAX_ATMOST_1000), KEEP(DueDiligence.Constants.MAX_ATMOST_100));


    //determine how many times an SSN was seen per LexID
    uniqueSSNsPerInquired := DEDUP(SORT(getLexIDsBySSNs, seq, inquiredDID, didTiedToSSN, ssnOnFile), seq, inquiredDID, didTiedToSSN, ssnOnFile);


    //get unique LexIDs regardless to determine their best data - exclude inquired as we already have their best data
    uniqueInd := DEDUP(SORT(uniqueSSNsPerInquired(relation <> dx_header.relative_titles.num_Subject), didTiedToSSN), didTiedToSSN);

    others := PROJECT(uniqueInd, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                            SELF.individual.did := LEFT.didTiedToSSN;
                                            SELF.historyDate := LEFT.historyDate;
                                            SELF := [];));

    othersBestData := DueDiligence.getIndInformation(options).GetIndividualBestDataWithLexID(others);

    addOthersDetails := JOIN(uniqueSSNsPerInquired, othersBestData,
                             LEFT.didTiedToSSN = RIGHT.individual.did,
                             TRANSFORM(DueDiligence.LayoutsInternalReport.PersonSSNDeviation,

                                        isSelf := LEFT.relation = dx_header.relative_titles.num_Subject;

                                        SELF.seq := LEFT.seq;
                                        SELF.inquiredDID := LEFT.inquiredDID;
                                        SELF.historyDate := LEFT.historyDate;

                                        SELF.inputSSN := LEFT.inputSSN;;
                                        SELF.maskedInputSSN := LEFT.maskedInputSSN;

                                        SELF.ssnOnFile := LEFT.ssnOnFile;
                                        SELF.maskedSSNOnFile := LEFT.maskedSSNOnFile;

                                        SELF.bestSSN := IF(isSelf, LEFT.bestSSN, RIGHT.individual.ssn);
                                        SELF.maskedBestSSN := IF(isSelf, LEFT.bestSSN, RIGHT.individual.ssn);

                                        SELF.bestDOB := IF(isSelf, LEFT.bestDOB, RIGHT.individual.dob);
                                        SELF.inquiredBestSSN := LEFT.inquiredBestSSN;

                                        SELF.bestName.firstName := IF(isSelf, LEFT.bestName.firstName, RIGHT.individual.firstName);
                                        SELF.bestName.middleName := IF(isSelf, LEFT.bestName.middleName, RIGHT.individual.middleName);
                                        SELF.bestName.lastName := IF(isSelf, LEFT.bestName.lastName, RIGHT.individual.lastName);
                                        SELF.bestName.suffix := IF(isSelf, LEFT.bestName.suffix, RIGHT.individual.suffix);

                                        SELF.bestAddress.streetAddress1 := IF(isSelf, LEFT.bestAddress.streetAddress1, RIGHT.individual.streetAddress1);
                                        SELF.bestAddress.streetAddress2 := IF(isSelf, LEFT.bestAddress.streetAddress2, RIGHT.individual.streetAddress2);

                                        SELF.bestAddress.prim_range := IF(isSelf, LEFT.bestAddress.prim_range, RIGHT.individual.prim_range);
                                        SELF.bestAddress.predir := IF(isSelf, LEFT.bestAddress.predir, RIGHT.individual.predir);
                                        SELF.bestAddress.prim_name := IF(isSelf, LEFT.bestAddress.prim_name, RIGHT.individual.prim_name);
                                        SELF.bestAddress.addr_suffix := IF(isSelf, LEFT.bestAddress.addr_suffix, RIGHT.individual.addr_suffix);
                                        SELF.bestAddress.postdir := IF(isSelf, LEFT.bestAddress.postdir, RIGHT.individual.postdir);
                                        SELF.bestAddress.unit_desig := IF(isSelf, LEFT.bestAddress.unit_desig, RIGHT.individual.unit_desig);
                                        SELF.bestAddress.sec_range := IF(isSelf, LEFT.bestAddress.sec_range, RIGHT.individual.sec_range);
                                        SELF.bestAddress.city := IF(isSelf, LEFT.bestAddress.city, RIGHT.individual.city);
                                        SELF.bestAddress.state := IF(isSelf, LEFT.bestAddress.state, RIGHT.individual.state);
                                        SELF.bestAddress.zip5 := IF(isSelf, LEFT.bestAddress.zip5, RIGHT.individual.zip5);
                                        SELF.bestAddress.zip4 := IF(isSelf, LEFT.bestAddress.zip4, RIGHT.individual.zip4);

                                        SELF.didTiedToSSN := LEFT.didTiedToSSN;
                                        SELF.relation := LEFT.relation;
                                        SELF.relationText := LEFT.relationText;
                                        SELF.differentSSNs := 0;
                                        SELF.differentBestSSNs := 0;

                                        SELF := [];),
                             LEFT OUTER,
                             ATMOST(1));

    //mask SSNs
    Suppress.MAC_Mask(addOthersDetails, maskedInputSSNData, maskedInputSSN, '', TRUE, FALSE,,,, options.ssn_mask);
    Suppress.MAC_Mask(maskedInputSSNData, maskedSSNOnFileData, maskedSSNOnFile, '', TRUE, FALSE,,,, options.ssn_mask);
    Suppress.MAC_Mask(maskedSSNOnFileData, maskedBestSSNData, maskedBestSSN, '', TRUE, FALSE,,,, options.ssn_mask);

    //add reported SSNs that are now masked
    maskedSSNs := PROJECT(maskedBestSSNData, TRANSFORM(DueDiligence.LayoutsInternalReport.PersonSSNDeviation,
                                                        SELF.reportedSSNs := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonSSNLexID,
                                                                                                SELF.ssn := LEFT.maskedSSNOnFile;
                                                                                                SELF.lexID := (STRING)LEFT.didTiedToSSn;)]);
                                                        SELF := LEFT;));



    fn_getCounts(DATASET(DueDiligence.LayoutsInternalReport.PersonSSNDeviation) dataToJoin, BOOLEAN bestCounts) := FUNCTION
        dsToUse := IF(bestCounts, uniqueSSNsPerInquired(inquiredBestSSN = ssnonfile AND inquiredBestSSN = bestSSN), uniqueSSNsPerInquired);

        tblResults := TABLE(dsToUse, {seq, inquiredDID, didTiedToSSN, ssnOnFile, cntGroup := COUNT(GROUP)}, seq, inquiredDID, didTiedToSSN, ssnOnFile);

        rollResultsByDIDTiedToSSN := ROLLUP(SORT(tblResults, seq, inquiredDID, didTiedToSSN),
                                            LEFT.seq = RIGHT.seq AND
                                            LEFT.inquiredDID = RIGHT.inquiredDID AND
                                            LEFT.didTiedToSSN = RIGHT.didTiedToSSN,
                                            TRANSFORM(RECORDOF(LEFT),
                                                      SELF.cntGroup := LEFT.cntGroup + RIGHT.cntGroup;
                                                      SELF := LEFT;));

        joinResults := JOIN(dataToJoin, rollResultsByDIDTiedToSSN,
                            LEFT.seq = RIGHT.seq AND
                            LEFT.inquiredDID = RIGHT.inquiredDID AND
                            LEFT.didTiedToSSN = RIGHT.didTiedToSSN,
                            TRANSFORM(DueDiligence.LayoutsInternalReport.PersonSSNDeviation,
                                      SELF.differentSSNs := IF(bestCounts, LEFT.differentSSNs, RIGHT.cntGroup);
                                      SELF.differentBestSSNs := IF(bestCounts, RIGHT.cntGroup, LEFT.differentBestSSNs);
                                      SELF := LEFT;),
                            LEFT OUTER,
                            ATMOST(1));

        RETURN joinResults;
    END;

    //count the variations that match best SSN
    variationPerBestSSN := fn_getCounts(maskedSSNs, TRUE);

    //count the variations, this will also include the inquired
    variationPerSSN := fn_getCounts(variationPerBestSSN, FALSE);

    //all SSN specific data/calcs done - now rollup data to the did
    uniqueLexIDsPerInquired := ROLLUP(SORT(variationPerSSN, seq, inquiredDID, didTiedToSSN),
                                      LEFT.seq = RIGHT.seq AND
                                      LEFT.inquiredDID = RIGHT.inquiredDID AND
                                      LEFT.didTiedToSSN = RIGHT.didTiedToSSN,
                                      TRANSFORM(DueDiligence.LayoutsInternalReport.PersonSSNDeviation,
                                                SELF.reportedSSNs := LEFT.reportedSSNs + RIGHT.reportedSSNs;
                                                SELF := LEFT;));




    //get unique LexIDs per inquired
    allRelations := DueDiligence.CommonIndividual.GetAllRelationships(inData);

    beos := NORMALIZE(inData, LEFT.perbusinessassociations.beos, TRANSFORM(DueDiligence.LayoutsInternal.SlimRelationWithHistoryDate,
                                                                            SELF.seq := LEFT.seq;
                                                                            SELF.inquiredDID := LEFT.inquiredDID;
                                                                            SELF.relationship := dx_header.relative_titles.num_associate;
                                                                            SELF.historyDate := LEFT.historyDate;
                                                                            SELF := RIGHT;
                                                                            SELF := [];));


    allAssociations := allRelations + beos;


    addRelationship := JOIN(uniqueLexIDsPerInquired, allAssociations,
                            LEFT.seq = RIGHT.seq AND
                            LEFT.inquiredDID = RIGHT.inquiredDID AND
                            LEFT.didTiedToSSN = RIGHT.did,
                            TRANSFORM(DueDiligence.LayoutsInternalReport.PersonSSNDeviation,

                                      isInquired := LEFT.relation = dx_header.relative_titles.num_Subject;

                                      SELF.relation := IF(isInquired, LEFT.relation, RIGHT.relationship);
                                      SELF.relationText := IF(isInquired, LEFT.relationText, dx_header.relative_titles.fn_get_str_title(RIGHT.relationship));
                                      SELF := LEFT;),
                            LEFT OUTER,
                            ATMOST(1));


    convertLayout := PROJECT(addRelationship, TRANSFORM(DueDiligence.LayoutsInternalReport.PersonSSNDeviation,

                                                        espAddress := iesp.ECL2ESP.SetAddress(LEFT.bestAddress.prim_name, LEFT.bestAddress.prim_range, LEFT.bestAddress.predir,
                                                                                                LEFT.bestAddress.postdir, LEFT.bestAddress.addr_suffix, LEFT.bestAddress.unit_desig,
                                                                                                LEFT.bestAddress.sec_range, LEFT.bestAddress.city, LEFT.bestAddress.state, LEFT.bestAddress.zip5,
                                                                                                LEFT.bestAddress.zip4, LEFT.bestAddress.county, DueDiligence.Constants.EMPTY,
                                                                                                LEFT.bestAddress.streetAddress1, LEFT.bestAddress.streetAddress2);

                                                        espName := iesp.ECL2ESP.SetName(LEFT.bestName.firstName, LEFT.bestName.middleName, LEFT.bestName.lastName, LEFT.bestName.suffix, DueDiligence.Constants.EMPTY);
                                                        espDOB := iesp.ECL2ESP.toDate(LEFT.bestDOB);
                                                        espLexID := (STRING)LEFT.didTiedToSSN;
                                                        espRelative := LEFT.relationText;

                                                        SELF.inputPersonDeviations := IF(LEFT.inputSSN = DueDiligence.Constants.Empty,
                                                                                         DATASET([], iesp.duediligencepersonreport.t_DDRPersonSSNDeviations),
                                                                                         DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonSSNDeviations,
                                                                                                            SELF.address := espAddress;
                                                                                                            SELF.name := espName;
                                                                                                            SELF.dob := espDOB;
                                                                                                            SELF.lexID := espLexID;
                                                                                                            SELF.relative := espRelative;
                                                                                                            SELF.ssnTimesAssociated := LEFT.differentSSNs;)]));

                                                        SELF.bestPersonDeviations := IF(LEFT.inquiredBestSSN = LEFT.bestSSN,
                                                                                          DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonSSNDeviations,
                                                                                                              SELF.address := espAddress;
                                                                                                              SELF.name := espName;
                                                                                                              SELF.dob := espDOB;
                                                                                                              SELF.lexID := espLexID;
                                                                                                              SELF.relative := espRelative;
                                                                                                              SELF.ssnTimesAssociated := LEFT.differentBestSSNs;)]),
                                                                                          DATASET([], iesp.duediligencepersonreport.t_DDRPersonSSNDeviations));
                                                        SELF := LEFT;));


    //rollup variations to get unique ssn and lexIDs per inquired
    finalResults := ROLLUP(SORT(convertLayout, seq, inquiredDID, didTiedToSSN),
                            LEFT.seq = RIGHT.seq AND
                            LEFT.inquiredDID = RIGHT.inquiredDID,
                            TRANSFORM(DueDiligence.LayoutsInternalReport.PersonSSNDeviation,
                                      SELF.inputPersonDeviations := LEFT.inputPersonDeviations + RIGHT.inputPersonDeviations;
                                      SELF.bestPersonDeviations := LEFT.bestPersonDeviations + RIGHT.bestPersonDeviations;
                                      SELF.reportedSSNs := LEFT.reportedSSNs + RIGHT.reportedSSNs;

                                      keepData := IF(LEFT.relation = dx_header.relative_titles.num_Subject, LEFT, RIGHT);

                                      SELF := keepData;));


    limitResults := PROJECT(finalResults, TRANSFORM(DueDiligence.LayoutsInternalReport.PersonSSNDeviation,
                                                    SELF.reportedSSNs := CHOOSEN(SORT(LEFT.reportedSSNs, ssn, lexID), iesp.constants.DDRAttributesConst.MaxSSNAssociations);
                                                    SELF.inputPersonDeviations := CHOOSEN(SORT(LEFT.inputPersonDeviations, -ssnTimesAssociated, relative, lexID), iesp.constants.DDRAttributesConst.MaxSSNDeviations);
                                                    SELF.bestPersonDeviations := CHOOSEN(SORT(LEFT.bestPersonDeviations, -ssnTimesAssociated, relative, lexID) , iesp.constants.DDRAttributesConst.MaxSSNDeviations);
                                                    SELF := LEFT;));








    // OUTPUT(ssnVariations, NAMED('ssnVariations'));
    // OUTPUT(getLexIDsBySSNs, NAMED('getLexIDsBySSNs'));
    // OUTPUT(uniqueSSNsPerInquired, NAMED('uniqueSSNsPerInquired'));

    // OUTPUT(uniqueInd, NAMED('uniqueInd'));
    // OUTPUT(others, NAMED('others'));
    // OUTPUT(othersBestData, NAMED('othersBestData'));
    // OUTPUT(addOthersDetails, NAMED('addOthersDetails'));

    // OUTPUT(maskedInputSSNData, NAMED('maskedInputSSNData'));
    // OUTPUT(maskedSSNOnFileData, NAMED('maskedSSNOnFileData'));
    // OUTPUT(maskedSSNs, NAMED('maskedSSNs'));

    // OUTPUT(variationPerBestSSN, NAMED('variationPerBestSSN'));
    // OUTPUT(variationPerSSN, NAMED('variationPerSSN'));

    // OUTPUT(uniqueLexIDsPerInquired, NAMED('uniqueLexIDsPerInquired'));

    // OUTPUT(allRelations, NAMED('allRelations'));
    // OUTPUT(beos, NAMED('beos'));
    // OUTPUT(allAssociations, NAMED('allAssociations'));
    // OUTPUT(addRelationship, NAMED('addRelationship'));

    // OUTPUT(convertLayout, NAMED('convertLayout'));
    // OUTPUT(finalResults, NAMED('finalResults'));
    // OUTPUT(limitResults, NAMED('limitResults'));




    RETURN limitResults;

END;
