IMPORT Address, Doxie, DueDiligence, iesp, liensV2, Suppress;

/*
	Following Keys being used:
      liensv2.key_liens_party_id
      liensV2.key_liens_main_ID
*/
EXPORT getLiensJudgementsEvictions(DATASET(DueDiligence.v3Layouts.InternalShared.LiensJudgementsEvictions) inData,
                                   DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess) := FUNCTION




    //CONSTANTS
    PARTY_TYPE_DEBTOR := 'D';
    PARTY_TYPE_CREDITOR := 'C';
    PARTY_TYPE_SET := [PARTY_TYPE_DEBTOR, PARTY_TYPE_CREDITOR];


    modAccess := DueDiligence.v3Common.General.GetModAccess(regulatoryAccess);





    lienInfo := JOIN(inData, liensv2.key_liens_party_id,
                      LEFT.rmsid <> DueDiligence.Constants.EMPTY AND
                      KEYED(LEFT.tmsid = RIGHT.tmsid) AND
                      KEYED(LEFT.rmsid = RIGHT.rmsid),
                      TRANSFORM({DueDiligence.v3Layouts.InternalShared.LiensJudgementsEvictions, STRING20 firstName, STRING20 middleName, STRING20 lastName, STRING5 suffix, STRING120 fullName, STRING9 taxID},
                                SELF.ultID := LEFT.ultID;
                                SELF.orgID := LEFT.orgID;
                                SELF.seleID := LEFT.seleID;
                                SELF.did := LEFT.did;

                                SELF.tmsid := LEFT.tmsid;
                                SELF.rmsid := LEFT.rmsid;
                                SELF.historyDate := LEFT.historyDate;

                                SELF.dateFirstSeen := (UNSIGNED4)RIGHT.date_first_seen;
                                SELF.dateLastSeen := (UNSIGNED4)RIGHT.date_last_seen;

                                SELF.nameType := RIGHT.name_type;
                                SELF.partyLexID := MAX((UNSIGNED)RIGHT.seleID, (UNSIGNED)RIGHT.did);
                                SELF.firstName := RIGHT.fname;
                                SELF.middleName := RIGHT.mname;
                                SELF.lastName := RIGHT.lname;
                                SELF.suffix := RIGHT.name_suffix;
                                SELF.fullName := RIGHT.cname;
                                SELF.taxID := MAX(RIGHT.ssn, RIGHT.tax_id);

                                SELF.state := RIGHT.st;
                                SELF.county := RIGHT.county[3..5];


                                streetAddress1 := Address.Addr1FromComponents(RIGHT.prim_range,
                                                                              RIGHT.predir,
                                                                              RIGHT.prim_name,
                                                                              RIGHT.addr_suffix,
                                                                              RIGHT.postdir,
                                                                              RIGHT.unit_desig,
                                                                              RIGHT.sec_range);


                                debtorCreditor := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRCreditorDebtor,
                                                                    SELF.name := iesp.ECL2ESP.SetName(RIGHT.fname, RIGHT.mname, RIGHT.lname, RIGHT.name_suffix, DueDiligence.Constants.EMPTY, RIGHT.cname);
                                                                    SELF.address := iesp.ECL2ESP.SetAddress(RIGHT.prim_name, RIGHT.prim_range, RIGHT.predir,
                                                                                                            RIGHT.postdir, RIGHT.addr_suffix, RIGHT.unit_desig,
                                                                                                            RIGHT.sec_range, RIGHT.v_city_name, RIGHT.st, RIGHT.zip,
                                                                                                            RIGHT.zip4, DueDiligence.Constants.EMPTY, DueDiligence.Constants.EMPTY, streetAddress1);
                                                                    SELF.taxID := MAX(RIGHT.ssn, RIGHT.tax_id);
                                                                    SELF := [];)]);



                                SELF.espDetails.debtors := IF(RIGHT.name_type = PARTY_TYPE_DEBTOR, debtorCreditor);
                                SELF.espDetails.creditors := IF(RIGHT.name_type = PARTY_TYPE_CREDITOR, debtorCreditor);

                                SELF := [];),
                      KEEP(DueDiligence.Constants.MAX_1000),
                      ATMOST(KEYED(LEFT.tmsid = RIGHT.tmsid) AND KEYED(LEFT.rmsid = RIGHT.rmsid), DueDiligence.Constants.MAX_1000));


    cleanDates := DueDiligence.Common.CleanDatasetDateFields(lienInfo(nameType in PARTY_TYPE_SET), 'dateFirstSeen, dateLastSeen');

    filterData := DueDiligence.CommonDate.FilterRecordsSingleDate(cleanDates, dateFirstSeen);

    sortParties  := SORT(filterData, ultID, orgID, seleID, did, tmsid, rmsid, nameType, partyLexID, taxID, fullName, firstName, lastName, -middleName, -suffix, -dateLastSeen, -dateFirstSeen);
    dedupParties := DEDUP(sortParties, ultID, orgID, seleID, did, tmsid, rmsid, nameType, partyLexID, taxID, fullName, firstName, lastName);

    //mask ssn for the report
    Suppress.MAC_Mask(dedupParties, maskedDebtorsCreditors, taxID, '', TRUE, FALSE,,,, regulatoryAccess.ssn_mask);

    calcAddrCounty := DueDiligence.v3Common.Address.GetAddressCounty(maskedDebtorsCreditors);

    addCountyName := PROJECT(calcAddrCounty, TRANSFORM(RECORDOF(LEFT),

                                                       addrToUpdate := IF(LEFT.nameType = PARTY_TYPE_DEBTOR, LEFT.espDetails.debtors, LEFT.espDetails.creditors)[1];
                                                       addrCounty := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRCreditorDebtor,
                                                                                        SELF.taxID := LEFT.taxID;
                                                                                        SELF.address.county := LEFT.countyNameText;
                                                                                        SELF := addrToUpdate;)]);

                                                       SELF.espDetails.debtors := IF(LEFT.nameType = PARTY_TYPE_DEBTOR, addrCounty);
                                                       SELF.espDetails.creditors := IF(LEFT.nameType = PARTY_TYPE_CREDITOR, addrCounty);

                                                       SELF := LEFT;));

    //limit creditor/debtor
    grpSortDebtors := GROUP(SORT(addCountyName(nameType = PARTY_TYPE_DEBTOR), ultID, orgID, seleID, did, tmsid, rmsid, -dateFirstSeen, -dateLastSeen, partyLexID), ultID, orgID, seleID, did, tmsid, rmsid);
    grpSortCreditors := GROUP(SORT(addCountyName(nameType = PARTY_TYPE_CREDITOR), ultID, orgID, seleID, did, tmsid, rmsid, -dateFirstSeen, -dateLastSeen, partyLexID), ultID, orgID, seleID, did, tmsid, rmsid);

    limitDebtors := DueDiligence.v3Common.General.GetMaxNumberOfRecords(grpSortDebtors, iesp.constants.DDRAttributesConst.MaxDebtors);
    limitCreditors := DueDiligence.v3Common.General.GetMaxNumberOfRecords(grpSortCreditors, iesp.constants.DDRAttributesConst.MaxCreditors);

    rollDebtorsCreditors := ROLLUP(SORT(limitDebtors + limitCreditors, ultID, orgID, seleID, did, tmsid, rmsid),
                                   LEFT.ultID = RIGHT.ultID AND
                                   LEFT.orgID = RIGHT.orgID AND
                                   LEFT.seleID = RIGHT.seleID AND
                                   LEFT.did = RIGHT.did AND
                                   LEFT.tmsid = RIGHT.tmsid AND
                                   LEFT.rmsid = RIGHT.rmsid,
                                   TRANSFORM(RECORDOF(LEFT),
                                             SELF.espDetails.debtors := LEFT.espDetails.debtors + RIGHT.espDetails.debtors;
                                             SELF.espDetails.creditors := LEFT.espDetails.creditors + RIGHT.espDetails.creditors;

                                             SELF := LEFT;));


    transTMSRMSIDs := PROJECT(filterData, TRANSFORM(DueDiligence.v3Layouts.InternalShared.LiensJudgementsEvictions, SELF := LEFT;));

    rollTMSRMSIDs := ROLLUP(SORT(transTMSRMSIDs, ultID, orgID, seleID, did, tmsid, rmsid),
                             LEFT.ultID = RIGHT.ultID AND
                             LEFT.orgID = RIGHT.orgID AND
                             LEFT.seleID = RIGHT.seleID AND
                             LEFT.did = RIGHT.did AND
                             LEFT.tmsid = RIGHT.tmsid AND
                             LEFT.rmsid = RIGHT.rmsid,
                             TRANSFORM(DueDiligence.v3Layouts.InternalShared.LiensJudgementsEvictions,
                                       SELF.dateFirstSeen := MAP(LEFT.dateFirstSeen = 0 AND RIGHT.dateFirstSeen <> 0 => RIGHT.dateFirstSeen,
                                                                  LEFT.dateFirstSeen <> 0 AND RIGHT.dateFirstSeen = 0 => LEFT.dateFirstSeen,
                                                                  MIN(LEFT.dateFirstSeen, RIGHT.dateFirstSeen));

                                       SELF.dateLastSeen := MAX(LEFT.dateLastSeen, RIGHT.dateLastSeen);

                                       SELF := LEFT;));


    mainLiensUnsuppressed := JOIN(rollTMSRMSIDs, liensV2.key_liens_main_ID,
                                  KEYED(LEFT.tmsid = RIGHT.tmsid AND LEFT.rmsid = RIGHT.rmsid),
                                  TRANSFORM({DueDiligence.v3Layouts.InternalShared.LiensJudgementsEvictions, UNSIGNED4 global_sid},
                                            SELF.ultID := LEFT.ultID;
                                            SELF.orgID := LEFT.orgID;
                                            SELF.seleID := LEFT.seleID;
                                            SELF.did := LEFT.did;

                                            SELF.tmsid := LEFT.tmsid;
                                            SELF.rmsid := LEFT.rmsid;
                                            SELF.historyDate := LEFT.historyDate;

                                            SELF.dateFirstSeen := LEFT.dateFirstSeen;
                                            SELF.dateLastSeen := LEFT.dateLastSeen;

                                            SELF.filingDate := (UNSIGNED4)RIGHT.orig_filing_date;
                                            SELF.releaseDate := (UNSIGNED4)RIGHT.release_date;

                                            SELF.espDetails.filingType := RIGHT.filing_type_desc;
                                            SELF.espDetails.filingAmount := TRUNCATE(((REAL)RIGHT.amount));
                                            SELF.espDetails.filingNumber := RIGHT.filing_number;
                                            SELF.espDetails.filingJurisdiction := RIGHT.filing_jurisdiction;

                                            SELF.espDetails.eviction := STD.Str.ToUpperCase(RIGHT.eviction) = 'Y';

                                            SELF.espDetails.agency := RIGHT.agency;
                                            SELF.espDetails.agencyState := RIGHT.agency_state;
                                            SELF.espDetails.agencyCounty := RIGHT.agency_county;

                                            SELF.global_sid := RIGHT.global_sid;

                                            SELF := LEFT;),
                                    ATMOST(DueDiligence.Constants.MAX_1000));



    cleanRelFilDates := DueDiligence.Common.CleanDatasetDateFields(mainLiensUnsuppressed, 'releaseDate, filingDate');

    mainLiens := Suppress.Suppress_ReturnOldLayout(cleanRelFilDates, modAccess, DueDiligence.v3Layouts.InternalShared.LiensJudgementsEvictions);

    calcReleaseDate := PROJECT(mainLiens, TRANSFORM(DueDiligence.v3Layouts.InternalShared.LiensJudgementsEvictions,
                                                    SELF.releaseDate := MAP(LEFT.releaseDate <= LEFT.historyDate => LEFT.releaseDate,
                                                                            LEFT.dateLastSeen <= LEFT.historyDate => LEFT.dateLastSeen,
                                                                            0);
                                                    SELF := LEFT;));


    sortLiens := SORT(calcReleaseDate, ultID, orgID, seleID, did, tmsid, rmsid, -filingDate, -releaseDate, RECORD);

    // Rollup to aggregate to the Liens Level (TMSID)
    // Rules: retain...
	  // ...the oldest (by value) date_first_seen
	  // ...the most recent (by value) date_last_seen
	  // ...any eviction value = 'Y'
	  // ...the oldest (by value) orig_filing_date
	  // ...the most recent (by record order) nonblank filing_type_desc
	  // ...the most recent (by record order) nonzero/nonblank amount
	  // ...the most recent (by value) release_date
	  // ...the most recent (by value) lapse_date
	  // ...the first (by record order) nonblank agency_state
	  // ...the most recent (by record order) nonblank filing_status
    // It's only counted as an eviction if the eviction = 'Y', otherwise it is classified as a lien/judgement
    liensRolled := ROLLUP(sortLiens,
                          LEFT.ultID = RIGHT.ultID AND
                          LEFT.orgID = RIGHT.orgID AND
                          LEFT.seleID = RIGHT.seleID AND
                          LEFT.did = RIGHT.did AND
                          LEFT.tmsid = RIGHT.tmsid AND
                          LEFT.rmsid = RIGHT.rmsid,
                          TRANSFORM(DueDiligence.v3Layouts.InternalShared.LiensJudgementsEvictions,
                                    SELF.ultID := LEFT.ultID;
                                    SELF.orgID := LEFT.orgID;
                                    SELF.seleID := LEFT.seleID;
                                    SELF.did := LEFT.did;
                                    SELF.tmsid := LEFT.tmsid;
                                    SELF.historyDate := LEFT.historyDate;

                                    SELF.dateFirstSeen := LEFT.dateFirstSeen;
                                    SELF.dateLastSeen := LEFT.dateLastSeen;

                                    SELF.espDetails.filingAmount := DueDiligence.v3Common.General.firstNonZeroNumber(espDetails.filingAmount);
                                    SELF.espDetails.filingNumber := DueDiligence.v3Common.General.firstPopulatedString(espDetails.filingNumber);
                                    SELF.espDetails.filingJurisdiction := DueDiligence.v3Common.General.firstPopulatedString(espDetails.filingJurisdiction);
                                    SELF.espDetails.filingType := DueDiligence.v3Common.General.firstPopulatedString(espDetails.filingType);

                                    SELF.espDetails.agency := DueDiligence.v3Common.General.firstPopulatedString(espDetails.agency);
                                    SELF.espDetails.agencyState := DueDiligence.v3Common.General.firstPopulatedString(espDetails.agencyState);
                                    SELF.espDetails.agencyCounty := DueDiligence.v3Common.General.firstPopulatedString(espDetails.agencyCounty);


                                    SELF.releaseDate := MAX(LEFT.releaseDate, RIGHT.releaseDate);
                                    SELF.espDetails.eviction := LEFT.espDetails.eviction OR RIGHT.espDetails.eviction;

                                    SELF.filingDate := MAP(LEFT.filingDate = 0 AND RIGHT.filingDate <> 0 => RIGHT.filingDate,
                                                            LEFT.filingDate <> 0 AND RIGHT.filingDate = 0 => LEFT.filingDate,
                                                            MIN(LEFT.filingDate, RIGHT.filingDate));


                                    SELF := LEFT;));


    addDebtorCreditors := JOIN(liensRolled, rollDebtorsCreditors,
                                LEFT.ultID = RIGHT.ultID AND
                                LEFT.orgID = RIGHT.orgID AND
                                LEFT.seleID = RIGHT.seleID AND
                                LEFT.did = RIGHT.did AND
                                LEFT.tmsid = RIGHT.tmsid AND
                                LEFT.rmsid = RIGHT.rmsid,
                                TRANSFORM(DueDiligence.v3Layouts.InternalShared.LiensJudgementsEvictions,
                                          SELF.espDetails.releaseDate := iesp.ECL2ESP.toDate(LEFT.releaseDate);
                                          SELF.espDetails.filingDate := iesp.ECL2ESP.toDate(LEFT.filingDate);
                                          SELF.espDetails.debtors := RIGHT.espDetails.debtors;
                                          SELF.espDetails.creditors := RIGHT.espDetails.creditors;
                                          SELF := LEFT;));




    //limit data returned that way it consistent regardless if requesting just attributes and/or report
    grpFinalData := GROUP(SORT(addDebtorCreditors, ultID, orgID, seleID, did, -dateFirstSeen, -filingDate, -releaseDate, -dateLastSeen), ultID, orgID, seleID, did);
    limitedResults := DueDiligence.v3Common.General.GetMaxNumberOfRecords(grpFinalData, iesp.constants.DDRAttributesConst.MaxLienJudgementsEvictions);



    // OUTPUT(lienInfo, NAMED('lienInfo'));
    // OUTPUT(cleanDates, NAMED('cleanDates'));
    // OUTPUT(filterData, NAMED('filterData'));

    // OUTPUT(sortParties, NAMED('sortParties'));
    // OUTPUT(dedupParties, NAMED('dedupParties'));

    // OUTPUT(maskedDebtorsCreditors, NAMED('maskedDebtorsCreditors'));
    // OUTPUT(calcAddrCounty, NAMED('calcAddrCounty'));
    // OUTPUT(addCountyName, NAMED('addCountyName'));

    // OUTPUT(grpSortDebtors, NAMED('grpSortDebtors'));
    // OUTPUT(grpSortCreditors, NAMED('grpSortCreditors'));
    // OUTPUT(limitDebtors, NAMED('limitDebtors'));
    // OUTPUT(limitCreditors, NAMED('limitCreditors'));
    // OUTPUT(rollDebtorsCreditors, NAMED('rollDebtorsCreditors'));

    // OUTPUT(transTMSRMSIDs, NAMED('transTMSRMSIDs'));
    // OUTPUT(rollTMSRMSIDs, NAMED('rollTMSRMSIDs'));

    // OUTPUT(mainLiensUnsuppressed, NAMED('mainLiensUnsuppressed'));
    // OUTPUT(cleanRelFilDates, NAMED('cleanRelFilDates'));
    // OUTPUT(mainLiens, NAMED('mainLiens'));
    // OUTPUT(calcReleaseDate, NAMED('calcReleaseDate'));
    // OUTPUT(sortLiens, NAMED('sortLiens'));
    // OUTPUT(liensRolled, NAMED('liensRolled'));

    // OUTPUT(addDebtorCreditors, NAMED('addDebtorCreditors'));
    // OUTPUT(limitedResults, NAMED('limitedResults'));



    RETURN limitedResults;
END;
