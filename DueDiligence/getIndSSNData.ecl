IMPORT Doxie, DueDiligence, Risk_Indicators;


/*
	Following Keys being used:
			Risk_Indicators.Key_SSN_Table_v4_2
			Risk_Indicators.key_ADL_Risk_Table_v4
*/

EXPORT getIndSSNData(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                      doxie.IDataAccess mod_access,
                      BOOLEAN isFCRA,
                      INTEGER bsVersion,
                      UNSIGNED8 bsOptions) := FUNCTION

    dataRestriction := mod_access.dataRestrictionMask;


    parents := DueDiligence.CommonIndividual.GetRelationshipAsInquired(inData, parents, DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT);
    spouse := DueDiligence.CommonIndividual.GetRelationshipAsInquired(inData, spouses, DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE);
    relatives := DueDiligence.CommonIndividual.GetRelationshipAsInquired(inData, associates, DueDiligence.Constants.INQUIRED_INDIVIDUAL_OTHER_RELATION);

    convertToRelatedParty := DueDiligence.CommonIndividual.CreateRelatedPartyDataset(spouse + parents + relatives);


    allInd := spouse + parents + relatives + inData;
    uniqueDIDs := DEDUP(SORT(allInd, individual.did), individual.did);

    withSSNFlags := DueDiligence.CommonIndividual.GetIIDSSNFlags(uniqueDIDs, mod_access, bsVersion, bsOptions, isFCRA);


    validateSSN := JOIN(allInd, withSSNFlags,
                        LEFT.individual.did = RIGHT.did,
                        TRANSFORM({DueDiligence.LayoutsInternal.RelatedParty, STRING2 relationshipToInquired, UNSIGNED6 inquiredDID},

                                    valid := RIGHT.socsvalflag in ['3', '0'] OR (RIGHT.socsvalflag = '2' AND LENGTH(TRIM(RIGHT.ssn)) = 4);
                                    itin := Risk_Indicators.rcSet.isCodeIT(RIGHT.ssn);
                                    nonUSSSN := Risk_Indicators.rcSet.isCode85(RIGHT.ssn, RIGHT.socllowissue);
                                    ssnExists := TRIM(RIGHT.ssn) <> DueDiligence.Constants.EMPTY;

                                    parent := LEFT.indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT;

                                    SELF.hasSSN := ssnExists;
                                    SELF.hasITIN := itin;
                                    SELF.hasImmigrantSSN := nonUSSSN;
                                    SELF.validSSN := valid;
                                    SELF.ssnLowIssue := (UNSIGNED4)RIGHT.socllowissue;
                                    SELF.atleastOneParentHasSSN := parent AND ssnExists;
                                    SELF.atleastOneParentHasITIN := parent AND itin;
                                    SELF.atleastOneParentHasImmigrantSSN := parent AND nonUSSSN;
                                    SELF.mostRecentParentSSNIssuanceDate := IF(parent, (UNSIGNED)RIGHT.socllowissue, 0);

                                    SELF.seq := LEFT.seq;
                                    SELF.did := LEFT.individual.did;
                                    SELF.party := LEFT.individual;

                                    SELF.relationshipToInquired := LEFT.indvType;
                                    SELF.inquiredDID := LEFT.inquiredDID;

                                    SELF := LEFT;
                                    SELF := [];),
                        LEFT OUTER);

    //unique related parties
    uniqueRelatedParties := DEDUP(SORT(validateSSN, seq, did, relationshipToInquired), seq, did);



    suspiciousSSNs := JOIN(uniqueRelatedParties, Risk_Indicators.Key_SSN_Table_v4_2,
                            KEYED(LEFT.party.ssn = RIGHT.ssn)	AND
                            //only keep records that are suspicious
                            RIGHT.combo.recentcount >= 3,
                            TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,
                                      SELF.ssnMultiIdentities := RIGHT.combo.recentcount;
                                      SELF := LEFT;),
                            LEFT OUTER,
                            ATMOST(KEYED(LEFT.party.ssn = RIGHT.ssn), DueDiligence.Constants.MAX_ATMOST_500));


    adlsPerSSN := JOIN(suspiciousSSNs, Risk_Indicators.key_ADL_Risk_Table_v4,
                        KEYED(LEFT.did = RIGHT.did),
                        TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,

                                  header_version := MAP(dataRestriction[Risk_Indicators.iid_constants.posEquifaxRestriction] = Risk_Indicators.iid_constants.sFalse AND
                                                        dataRestriction[Risk_Indicators.iid_constants.posTransUnionRestriction] = Risk_Indicators.iid_constants.sFalse AND
                                                        ((~isFCRA AND dataRestriction[Risk_Indicators.iid_constants.posExperianRestriction] = Risk_Indicators.iid_constants.sFalse) OR (isFCRA AND dataRestriction[Risk_Indicators.iid_constants.posExperianFCRARestriction] = Risk_Indicators.iid_constants.sFalse)) => RIGHT.combo,
                                                        ((~isFCRA AND dataRestriction[Risk_Indicators.iid_constants.posExperianRestriction] = Risk_Indicators.iid_constants.sFalse) OR (isFCRA AND dataRestriction[Risk_Indicators.iid_constants.posExperianFCRARestriction] = Risk_Indicators.iid_constants.sFalse)) => RIGHT.en,
                                                        ~isFCRA AND dataRestriction[Risk_Indicators.iid_constants.posTransUnionRestriction] = Risk_Indicators.iid_constants.sFalse => RIGHT.tn,
                                                        RIGHT.eq);  // default to the EQ version

                                  perADL := Risk_Indicators.iid_constants.capVelocity(header_version.ssn_ct);

                                  SELF.ssnPerADL := perADL;

                                  SELF.ssnRisk := LEFT.validSSN = FALSE OR
                                                    (UNSIGNED4)LEFT.ssnLowIssue > LEFT.party.dob OR
                                                    LEFT.ssnMultiIdentities > 2 OR
                                                    perADL > 1 OR
                                                    LEFT.hasSSN = FALSE;


                                  SELF := LEFT;),
                        LEFT OUTER,
                        ATMOST(DueDiligence.Constants.MAX_ATMOST_1000),
                        KEEP(1));




    perAssocOptions := MODULE(DueDiligence.DataInterface.iAttributePerAssoc)
                                EXPORT BOOLEAN includeSSNData := TRUE;
                                EXPORT BOOLEAN includeHeaderData := FALSE;
                       END;


    updateRelatives := DueDiligence.CommonIndividual.UpdateRelationships(inData, adlsPerSSN, perAssocOptions);


    sortValidatedSSN := SORT(validateSSN(relationshipToInquired IN [DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT, DueDiligence.Constants.INQUIRED_INDIVIDUAL]), seq, inquiredDID, relationshipToInquired);

    rollValidatedSSN := ROLLUP(sortValidatedSSN,
                                LEFT.seq = RIGHT.seq AND
                                LEFT.inquiredDID = RIGHT.inquiredDID,
                                TRANSFORM(RECORDOF(LEFT),
                                          SELF.validSSN := LEFT.validSSN;
                                          SELF.hasITIN := LEFT.hasITIN;
                                          SELF.hasImmigrantSSN := LEFT.hasImmigrantSSN;
                                          SELF.hasSSN := LEFT.hasSSN;

                                          SELF.atleastOneParentHasITIN := LEFT.atleastOneParentHasITIN OR RIGHT.atleastOneParentHasITIN;
                                          SELF.atleastOneParentHasImmigrantSSN := LEFT.atleastOneParentHasImmigrantSSN OR RIGHT.atleastOneParentHasImmigrantSSN;
                                          SELF.atleastOneParentHasSSN := LEFT.atleastOneParentHasSSN OR RIGHT.atleastOneParentHasSSN;
                                          SELF.mostRecentParentSSNIssuanceDate := MAX(LEFT.mostRecentParentSSNIssuanceDate, RIGHT.mostRecentParentSSNIssuanceDate);
                                          SELF := LEFT;));

    addSSNData := JOIN(updateRelatives, rollValidatedSSN,
                        LEFT.seq = RIGHT.seq AND
                        LEFT.inquiredDID = RIGHT.inquiredDID,
                        TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                  SELF.hasSSN := RIGHT.hasSSN;
                                  SELF.hasITIN := RIGHT.hasITIN;
                                  SELF.hasImmigrantSSN := RIGHT.hasImmigrantSSN;
                                  SELF.validSSN := RIGHT.validSSN;

                                  SELF.atleastOneParentHasSSN := RIGHT.atleastOneParentHasSSN;
                                  SELF.atleastOneParentHasITIN := RIGHT.atleastOneParentHasITIN;
                                  SELF.mostRecentParentSSNIssuanceDate := RIGHT.mostRecentParentSSNIssuanceDate;
                                  SELF.atleastOneParentHasImmigrantSSN := RIGHT.atleastOneParentHasImmigrantSSN;
                                  SELF := LEFT;),
                        LEFT OUTER);




		// OUTPUT(allInd, NAMED('allInd_ssnData'));
		// OUTPUT(uniqueDIDs, NAMED('uniqueDIDs'));
		// OUTPUT(withSSNFlags, NAMED('withSSNFlags'));

		// OUTPUT(validateSSN, NAMED('validateSSN'));
		// OUTPUT(suspiciousSSNs, NAMED('suspiciousSSNs'));
		// OUTPUT(adlsPerSSN, NAMED('adlsPerSSN'));

		// OUTPUT(updateRelatives, NAMED('updateRelatives'));

		// OUTPUT(sortValidatedSSN, NAMED('sortValidatedSSN'));
		// OUTPUT(rollValidatedSSN, NAMED('rollValidatedSSN'));
		// OUTPUT(addSSNData, NAMED('addSSNData'));




		RETURN addSSNData;

END;
