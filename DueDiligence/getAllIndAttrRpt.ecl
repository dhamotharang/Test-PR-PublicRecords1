IMPORT DueDiligence, Risk_Indicators, STD, ut;


EXPORT getAllIndAttrRpt(DATASET(DueDiligence.v3Layouts.Internal.PersonTemp) v3Input,
                        DATASET(DueDiligence.v3Layouts.DDInput.PersonSearch) personToSearchInput,
                        DATASET(Risk_Indicators.Layout_Boca_Shell) bsData,
                        DATASET(DueDiligence.Citizenship.Layouts.IndicatorLayout) riskIndicators,
                        DueDiligence.DDInterface.iDDv3PersonAttributes attributesRequested,
                        DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess,
                        DueDiligence.DDInterface.iDDPersonOptions ddOptions,
                        BOOLEAN debugMode) := FUNCTION



    convertToOldSlimRelation(DATASET(DueDiligence.v3Layouts.Internal.SlimPerson) inSlim, STRING2 rawType) := FUNCTION
        RETURN PROJECT(inSlim, TRANSFORM(DueDiligence.Layouts.SlimRelation,
                                          SELF.did := LEFT.lexID;
                                          SELF.rawRelationshipType := rawType;
                                          SELF.relationToInquired := (STRING)LEFT.relationship;
                                          SELF := LEFT;
                                          SELF := [];));
    END;


    //temp code to get the other attributes/reports
    newInput := PROJECT(v3Input, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                            SELF.seq := LEFT.seq;

                                            SELF.historyDateRaw := LEFT.historyDateRaw;
                                            SELF.historyDate := LEFT.historyDate;
                                            SELF.indvType := DueDiligence.Constants.INQUIRED_INDIVIDUAL;

                                            SELF.inquiredDID := LEFT.inquiredDID;
                                            SELF.individual.did := LEFT.inquiredDID;
                                            SELF.individual.score := LEFT.lexIDScore;
                                            SELF.individual.ssn := LEFT.inquired.ssn;
                                            SELF.individual.dob := (UNSIGNED4)LEFT.inquired.dob;
                                            SELF.individual.phone := LEFT.inquired.phone;

                                            SELF.individual.zip5 := LEFT.inquired.zip;

                                            SELF.individual := LEFT.inquired;

                                            SELF.bestSSN := LEFT.bestData.ssn;
                                            SELF.bestPhone := LEFT.bestData.phone;
                                            SELF.bestDOB := (UNSIGNED4)LEFT.bestData.dob;

                                            SELF.bestName := LEFT.bestData;
                                            SELF.bestAddress.zip5 := LEFT.bestData.zip;
                                            SELF.bestAddress := LEFT.bestData;
                                            SELF.bestSSNDetails.ssn := LEFT.bestData.ssn;



                                            // SELF.spouses := convertToOldSlimRelation(LEFT.spouses, DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE);
                                            // SELF.parents := convertToOldSlimRelation(LEFT.parents, DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT);
                                            // SELF.associates := convertToOldSlimRelation(LEFT.associations, DueDiligence.Constants.INQUIRED_INDIVIDUAL_OTHER_RELATION);



                                            validDOB := DueDiligence.CommonDate.IsValidDate((UNSIGNED4)LEFT.bestData.dob);
                                            tempHistoryDate := IF(LEFT.historyDate = DueDiligence.Constants.date8Nines, STD.Date.Today(), LEFT.historyDate);
                                            validHistDate := STD.Date.IsValidDate(tempHistoryDate);

                                            SELF.estimatedAge := IF(validDOB AND validHistDate, ut.Age((UNSIGNED4)LEFT.bestData.dob, tempHistoryDate), 0);


                                            SELF := [];));

    addRawData := JOIN(newInput, personToSearchInput,
                       LEFT.seq = RIGHT.seq,
                       TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                  SELF.indvRawInput.lexID := (STRING)RIGHT.rawData.lexID;
                                  SELF.indvRawInput.accountNumber := RIGHT.accountNumber;
                                  SELF.indvRawInput.address.zip5 := RIGHT.rawData.zip;
                                  SELF.indvRawInput.address := RIGHT.rawData;
                                  SELF.indvRawInput.phone := RIGHT.rawData.phone;
                                  SELF.indvRawInput.name := RIGHT.rawData;
                                  SELF.indvRawInput.ssn := RIGHT.rawData.ssn;
                                  SELF.indvRawInput.dob := (STRING8)RIGHT.rawData.dob;
                                  SELF.indvRawInput.cleanAddress.zip5 := RIGHT.searchBy.zip;
                                  SELF.indvRawInput.cleanAddress := RIGHT.searchBy;

                                  SELF.inputSSNDetails.ssn := RIGHT.rawData.ssn;

                                  SELF.inputaddressprovided := RIGHT.rawData.streetAddress1 <> DueDiligence.Constants.EMPTY OR RIGHT.rawData.streetAddress2 <> DueDiligence.Constants.EMPTY OR RIGHT.rawData.prim_range <> DueDiligence.Constants.EMPTY OR RIGHT.rawData.predir <> DueDiligence.Constants.EMPTY OR
                                                                RIGHT.rawData.prim_name <> DueDiligence.Constants.EMPTY OR RIGHT.rawData.addr_suffix <> DueDiligence.Constants.EMPTY OR RIGHT.rawData.postdir <> DueDiligence.Constants.EMPTY OR RIGHT.rawData.unit_desig <> DueDiligence.Constants.EMPTY OR
                                                                RIGHT.rawData.sec_range <> DueDiligence.Constants.EMPTY OR RIGHT.rawData.city <> DueDiligence.Constants.EMPTY OR RIGHT.rawData.state <> DueDiligence.Constants.EMPTY OR RIGHT.rawData.zip <> DueDiligence.Constants.EMPTY;


                                  SELF.fullinputaddressprovided := (RIGHT.searchBy.streetAddress1 <> DueDiligence.Constants.EMPTY OR RIGHT.searchBy.prim_name <> DueDiligence.Constants.EMPTY) AND RIGHT.searchBy.city <> DueDiligence.Constants.EMPTY AND RIGHT.searchBy.state <> DueDiligence.Constants.EMPTY AND RIGHT.searchBy.zip <> DueDiligence.Constants.EMPTY;

                                  SELF := LEFT;),
                       LEFT OUTER,
                       ATMOST(1));



    addBSData := JOIN(addRawData, bsData,
                      LEFT.seq = RIGHT.seq,
                      TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                //pull any necessary fields needed for processing from the boca shell
                                SELF.bs_bestSSNDecsFlag := RIGHT.best_flags.best_ssn_decsflag;
                                SELF.bs_bestSSNValid := RIGHT.best_flags.best_ssn_valid;
                                SELF.bs_lexIDDeceased := RIGHT.iid.diddeceased;
                                SELF.bs_bestSSNSSNDOBFlag := RIGHT.best_flags.best_ssn_ssndobflag;
                                SELF.bs_adlsPerSSN := RIGHT.velocity_counters.adls_per_ssn_seen_18months;
                                SELF.bs_adlPerBestSSN := RIGHT.best_flags.adls_per_bestssn;
                                SELF.bs_bestSSN := RIGHT.best_flags.ssn;
                                SELF.bs_iidSocsValFlag := RIGHT.iid.socsvalflag;
                                SELF.bs_iidPwSocsValFlag := RIGHT.iid.pwsocsvalflag;
                                SELF.bs_inputSocsCharFlag := RIGHT.ssn_verification.validation.inputsocscharflag;

                                //fields for the Identity Report
                                SELF.inputSSNDetails.issuedLowDate := RIGHT.SSN_Verification.Validation.low_issue_date;
                                SELF.inputSSNDetails.issuedHighDate := RIGHT.SSN_Verification.Validation.high_issue_date;
                                SELF.inputSSNDetails.issuedState := RIGHT.SSN_Verification.Validation.issue_state;
                                SELF.inputSSNDetails.randomized := Risk_Indicators.rcSet.isCodeRS(LEFT.indvRawInput.ssn, RIGHT.iid.socsvalflag, RIGHT.iid.socllowissue, RIGHT.iid.socsrcisflag);

                                ssnOnFile := DueDiligence.Common.GetStringListAsDataset(RIGHT.header_summary.ssns_on_file);
                                SELF.ssnOnFile := PROJECT(ssnOnFile(info <> DueDiligence.Constants.EMPTY), TRANSFORM({STRING9 ssn}, SELF.ssn := LEFT.info;));

                                dobOnFile := DueDiligence.Common.GetStringListAsDataset(RIGHT.header_summary.dobs_on_file);
                                SELF.dobOnFile := PROJECT(dobOnFile(info <> DueDiligence.Constants.EMPTY), TRANSFORM({STRING8 dob}, SELF.dob := LEFT.info;));



                                SELF := LEFT;),
                      LEFT OUTER,
                      ATMOST(1));


    addRIData := JOIN(addBSData, riskIndicators,
                      LEFT.seq = RIGHT.seq,
                      TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                //pull any necessary fields needed for processing from the Citizenship risk indicators
                                SELF.cit_inputSSNReportedDeceased := RIGHT.inputssnreporteddeceased;
                                SELF.cit_inputSSNInvalid := RIGHT.inputssninvalid;
                                SELF.cit_inputSSNIssuePriorToDOB := RIGHT.inputssnissuedpriordob;
                                SELF.cit_inputSSNRandomIssuedInvalid := RIGHT.inputssnrandomissuedinvalid;
                                SELF.cit_lexIDMultipleSSNs := RIGHT.lexidmultiplessns;
                                SELF.cit_lexIDBestSSNInvalid := RIGHT.lexidbestssninvalid;
                                SELF.cit_lexIDReportedDeceased := RIGHT.lexidreporteddeceased;
                                SELF.cit_lastReportedByAnySource := RIGHT.lastReportedByAnySource;
                                SELF.cit_inputSSNITIN := RIGHT.inputSSNITIN;
                                SELF.cit_lexID := RIGHT.lexID;

                                SELF := LEFT;),
                      LEFT OUTER,
                      ATMOST(1));


    busOptions := DueDiligence.v3Common.DDBusiness.GetBusinessShellOptions(regulatoryAccess);
    linkingOpts := DueDiligence.v3Common.DDBusiness.GetLinkingOptions(regulatoryAccess);


    oldSharedInput := DueDiligence.getIndAttributes(addRIData, ddOptions.includeReportData,
                                                      busOptions, linkingOpts, debugMode);


    convertOld2New := PROJECT(oldSharedInput, TRANSFORM(DueDiligence.v3Layouts.InternalPerson.PersonResults,
                                                        SELF.seq := LEFT.seq;
                                                        SELF.lexID := LEFT.inquiredDID;

                                                        SELF.economicReportIncluded := ddOptions.includeReportData AND DueDiligence.v3Common.DDPerson.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_ECONOMIC, attributesRequested);
                                                        SELF.geographicReportIncluded := ddOptions.includeReportData AND DueDiligence.v3Common.DDPerson.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_GEOGRAPHIC, attributesRequested);
                                                        SELF.identityReportIncluded := ddOptions.includeReportData AND DueDiligence.v3Common.DDPerson.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_IDENTITY, attributesRequested);
                                                        SELF.networkReportIncluded := ddOptions.includeReportData AND DueDiligence.v3Common.DDPerson.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_NETWORK, attributesRequested);

                                                        SELF.personReport := LEFT.personReport;

                                                        SELF := LEFT;
                                                        SELF := [];));




    // OUTPUT(newInput, NAMED('newInput'));
    // OUTPUT(addRawData, NAMED('addRawData'));
    // OUTPUT(addBSData, NAMED('addBSData'));
    // OUTPUT(addRIData, NAMED('addRIData'));
    // OUTPUT(oldSharedInput, NAMED('oldSharedInput'));
    // OUTPUT(convertOld2New, NAMED('convertOld2New'));


    RETURN convertOld2New;
END;
