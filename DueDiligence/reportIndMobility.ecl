IMPORT ADVO, Business_Risk_BIP, Census_Data, codes, doxie, DueDiligence, dx_header, Easi, iesp, ut;


/*
	Following Keys being used:
			dx_header.key_nbr_address
      Easi.Key_Easi_Census
*/

EXPORT reportIndMobility(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                         Business_Risk_BIP.LIB_Business_Shell_LIBIN options
                         ) := FUNCTION

    mod_access := PROJECT(options, doxie.IDataAccess);

    HIGH_CRIME_TEXT := 'High Crime Index';
    AVERAGE_CRIME_TEXT := 'Average Crime Index';
    LOW_CRIME_TEXT := 'Low Crime Index';

    CURRENT_ADDRESS_TEXT := 'Current';
    PRIOR_ADDRESS_TEXT := 'Prior';





    //get all residences per inquired
    normAddresses := NORMALIZE(inData, LEFT.residences, TRANSFORM(DueDiligence.LayoutsInternalReport.MobilityData,
                                                                  SELF.seq := LEFT.seq;
                                                                  SELF.inquiredDID := LEFT.inquiredDID;
                                                                  SELF.historyDate := LEFT.historyDate;
                                                                  SELF.addrs := RIGHT;


                                                                  SELF := [];));


    cleanDates := DueDiligence.Common.CleanDatasetDateFields(normAddresses, 'addrs.dateFirstSeen, addrs.datelastSeen');


    calcMovingDist := ROLLUP(GROUP(SORT(cleanDates, seq, inquiredDID, addrs.seq), seq, inquiredDID),
                             LEFT.seq = RIGHT.seq AND
                             LEFT.inquiredDID = RIGHT.inquiredDID,
                             TRANSFORM(RECORDOF(cleanDates),

                                        dist := IF(LEFT.addrs.zip5 = DueDiligence.Constants.EMPTY OR RIGHT.addrs.zip5 = DueDiligence.Constants.EMPTY,
                                                      DueDiligence.Constants.EMPTY,
                                                      (STRING)(INTEGER)ut.zip_Dist(LEFT.addrs.zip5, RIGHT.addrs.zip5));

                                        SELF.movingDistances := LEFT.movingDistances + (dist + ',');
                                        SELF.addrs.zip5 := RIGHT.addrs.zip5;
                                        SELF := LEFT;));


    addMovingDistances := UNGROUP(PROJECT(GROUP(cleanDates, seq, inquiredDID), TRANSFORM(DueDiligence.LayoutsInternalReport.MobilityData,
                                                                                          splitDist := STD.Str.SplitWords(calcMovingDist(seq = LEFT.seq AND inquiredDID = LEFT.inquiredDID)[1].movingDistances, ',', TRUE);
                                                                                          SELF.movingDistances := splitDist[COUNTER];
                                                                                          SELF := LEFT;)));


    getAddressType := DueDiligence.CommonAddress.GetKeyAddr1HistoryAddressType(addMovingDistances, 'addrs');

    addAddressType := JOIN(addMovingDistances, getAddressType,
                            LEFT.seq = RIGHT.seq AND
                            LEFT.inquiredDID = RIGHT.inquiredDID AND
                            LEFT.addrs.seq = RIGHT.addrs.seq,
                            TRANSFORM(DueDiligence.LayoutsInternalReport.MobilityData,
                                      SELF.addressType := ADVO.Lookup_Descriptions.fn_addrtype(RIGHT.addr_type);
                                      SELF := LEFT;),
                            LEFT OUTER,
                            ATMOST(1));

    tempDS := PROJECT(addAddressType, TRANSFORM({DueDiligence.LayoutsInternalReport.MobilityData, STRING5 tempFIPS},
                                                addrWithin1Year := LEFT.addrs.dateLastSeen >= STD.Date.AdjustCalendar(LEFT.historyDate, -1);
                                                SELF.currentPreviousIndicator := IF(LEFT.addrs.seq = 1 AND addrWithin1Year, CURRENT_ADDRESS_TEXT, PRIOR_ADDRESS_TEXT);
                                                SELF.tempFIPS := codes.st2FipsCode(STD.Str.ToUpperCase(LEFT.addrs.state)) + LEFT.addrs.county;
                                                SELF := LEFT;));

    Census_Data.MAC_Fips2County_Keyed(tempDS, addrs.state, tempFIPS, countyName, countyNameResults);

    tblCurrPrevAddrIndicator := TABLE(tempDS, {seq, inquiredDID, currentPreviousIndicator, indicatorCnt := COUNT(GROUP)}, seq, inquiredDID, currentPreviousIndicator);


    addAreaRisk :=  JOIN(countyNameResults, Easi.Key_Easi_Census,
                          KEYED(RIGHT.geolink = LEFT.addrs.state + LEFT.addrs.county + LEFT.addrs.geo_blk),
                          TRANSFORM(DueDiligence.LayoutsInternalReport.MobilityData,
                                    INTEGER tempCrimeValue := (INTEGER)RIGHT.totcrime;

                                    SELF.areaRisk := MAP(tempCrimeValue = 0 => '',
                                                         tempCrimeValue >= DueDiligence.Constants.HighCrimeValue => HIGH_CRIME_TEXT,
                                                         tempCrimeValue <= DueDiligence.Constants.LowCrimeValue => LOW_CRIME_TEXT,
                                                         AVERAGE_CRIME_TEXT);
                                    SELF := LEFT;),
                          LEFT OUTER,
                          ATMOST(1));




    //find out who currently resides at all the residences
    residentTenants := JOIN(normAddresses, dx_header.key_nbr_address(),
                            KEYED(LEFT.addrs.prim_name = RIGHT.prim_name) AND
                            KEYED(LEFT.addrs.zip5 = RIGHT.zip) AND
                            KEYED(LEFT.addrs.zip4[1..2] = RIGHT.z2) AND
                            KEYED(LEFT.addrs.addr_suffix = RIGHT.suffix) AND
                            KEYED(LEFT.addrs.prim_range = RIGHT.prim_range) AND
                            LEFT.addrs.sec_range = RIGHT.sec_range AND
                            doxie.isrecent((STRING6)RIGHT.dt_last_seen, 3),
                            TRANSFORM(DueDiligence.LayoutsInternalReport.CurrentResidentTenantInfo,
                                      SELF.inquiredSeq := LEFT.seq;
                                      SELF.inquiredDID := LEFT.inquiredDID;
                                      SELF.inquiredAddressSeq := LEFT.addrs.seq;
                                      SELF.residentDID := RIGHT.did;
                                      SELF.residentLastSeenDate := RIGHT.dt_last_seen;
                                      SELF.residentFirstSeenDate := RIGHT.dt_first_seen;
                                      SELF.historyDate := LEFT.historyDate;
                                      SELF := LEFT.addrs;
                                      SELF := [];),
                            LIMIT(500, SKIP),
                            KEEP(100));

    dedupResidentTentants := DEDUP(SORT(residentTenants, inquiredSeq, inquiredDID, inquiredAddressSeq, residentDID, -residentLastSeenDate, -residentFirstSeenDate), inquiredSeq, inquiredDID, inquiredAddressSeq, residentDID);
    limitResidentTentants := DEDUP(SORT(dedupResidentTentants, inquiredSeq, inquiredDID, inquiredAddressSeq, -residentLastSeenDate, -residentFirstSeenDate), inquiredSeq, inquiredDID, inquiredAddressSeq, KEEP(10));

    residentTenantIndivs := PROJECT(limitResidentTentants, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                                                      SELF.individual.did := LEFT.residentDID;
                                                                      SELF.historyDate := LEFT.historyDate;
                                                                      SELF := [];));

    //If the same individual is found in the file - no need to grab their info more than once
    uniqueResidentTenantDIDs := DEDUP(SORT(residentTenantIndivs, individual.did), individual.did);
    bestResidentTenantInfo := DueDiligence.getIndInformation(options).GetIndividualBestDataWithLexID(uniqueResidentTenantDIDs);

    //kep only the resident/tenant that currently still resides at the address
    currentResidentTenants := JOIN(limitResidentTentants, bestResidentTenantInfo,
                                    LEFT.residentDID = RIGHT.individual.did AND
                                    LEFT.prim_range = RIGHT.individual.prim_range AND
                                    LEFT.predir = RIGHT.individual.predir AND
                                    LEFT.prim_name = RIGHT.individual.prim_name AND
                                    LEFT.addr_suffix = RIGHT.individual.addr_suffix AND
                                    LEFT.postdir = RIGHT.individual.postdir AND
                                    LEFT.unit_desig = RIGHT.individual.unit_desig AND
                                    LEFT.sec_range = RIGHT.individual.sec_range,
                                    TRANSFORM(DueDiligence.LayoutsInternalReport.CurrentResidentTenantInfo,
                                              SELF.firstName := RIGHT.individual.firstName;
                                              SELF.middleName := RIGHT.individual.middleName;
                                              SELF.lastName := RIGHT.individual.lastName;
                                              SELF.suffix := RIGHT.individual.suffix;
                                              SELF := LEFT;
                                              SELF := [];));



    //unique resident/tenants
    uniqueCurrentResidentTenants := DEDUP(SORT(currentResidentTenants, residentDID), residentDID);


    //Need to convert resident/tenants to determine licensing and criminal data
    relatedParty := PROJECT(uniqueCurrentResidentTenants, TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,
                                                                     SELF.seq := COUNTER;
                                                                     SELF.did := LEFT.residentDID;
                                                                     SELF.party.did := LEFT.residentDID;
                                                                     SELF.historyDate := LEFT.historyDate;
                                                                     SELF := [];));


    //get resident/tenant high risk professional licesnses
    rtProfLic := DueDiligence.getIndProfLic(relatedParty, mod_access);
    rtProfLicResults := JOIN(currentResidentTenants, rtProfLic,
                              LEFT.residentDID = RIGHT.did,
                              TRANSFORM(DueDiligence.LayoutsInternalReport.CurrentResidentTenantInfo,
                                        SELF.highRiskProfServOfStudy := RIGHT.activeLA OR RIGHT.activeFRE OR RIGHT.activeMED OR RIGHT.activeBP OR
                                                                        RIGHT.inactiveLA OR RIGHT.inactiveFRE OR RIGHT.inactiveMED OR RIGHT.inactiveBP;
                                        SELF := LEFT;),
                              LEFT OUTER,
                              ATMOST(1));

    //get resident/tenant criminal/arrest records
    //get the criminal data
    rtCrimData := DueDiligence.getIndCriminal(relatedParty);

    //get any sex offender data
    rtSexOffender := DueDiligence.getIndCriminalSexOffender(rtCrimData);

    rtCrimResult := JOIN(currentResidentTenants, rtSexOffender,
                          LEFT.residentDID = RIGHT.did,
                          TRANSFORM(DueDiligence.LayoutsInternalReport.CurrentResidentTenantInfo,
                                    SELF.potentialCrimArrest := COUNT(RIGHT.party.indOffenses) > 0;
                                    SELF.potentialSOs := RIGHT.potentialSO;
                                    SELF := LEFT;),
                          LEFT OUTER,
                          ATMOST(1));

    //add criminal and professional license info
    rtCrimProfLicResults := ROLLUP(SORT(rtProfLicResults + rtCrimResult, inquiredSeq, inquiredDID, residentDID),
                                    LEFT.inquiredSeq = RIGHT.inquiredSeq AND
                                    LEFT.inquiredDID = RIGHT.inquiredDID AND
                                    LEFT.residentDID = RIGHT.residentDID,
                                    TRANSFORM(DueDiligence.LayoutsInternalReport.CurrentResidentTenantInfo,
                                              SELF.highRiskProfServOfStudy := LEFT.highRiskProfServOfStudy OR RIGHT.highRiskProfServOfStudy;
                                              SELF.potentialCrimArrest := LEFT.potentialCrimArrest OR RIGHT.potentialCrimArrest;
                                              SELF.potentialSOs := LEFT.potentialSOs OR RIGHT.potentialSOs;
                                              SELF := LEFT;));



    //now determine if any of the residents are potential relatives and or business associates
    rtRelationships := PROJECT(rtCrimProfLicResults, TRANSFORM(DueDiligence.LayoutsInternalReport.MobilityData,
                                                                  inquiredRawData := inData(seq = LEFT.inquiredSeq AND inquiredDID = LEFT.inquiredDID);

                                                                  rellyDIDs := SET(inquiredRawData.spouses + inquiredRawData.parents + inquiredRawData.associates(rawRelationshipType <> DueDiligence.Constants.INQUIRED_INDIVIDUAL_BUSINESS_ASSOCIATE), did);
                                                                  busAssocDIDs := SET(inquiredRawData.associates(rawRelationshipType = DueDiligence.Constants.INQUIRED_INDIVIDUAL_BUSINESS_ASSOCIATE), did);


                                                                  SELF.seq := LEFT.inquiredSeq;
                                                                  SELF.addrs.seq := LEFT.inquiredAddressSeq;
                                                                  SELF.addrs := LEFT;
                                                                  SELF.resTenInfo := DATASET([TRANSFORM(DueDiligence.LayoutsInternalReport.SlimResidentTenant,
                                                                                                        SELF.relative := LEFT.residentDID IN rellyDIDs;
                                                                                                        SELF.busAssocs := LEFT.residentDID IN busAssocDIDs;
                                                                                                        SELF := LEFT;)]);
                                                                  SELF := LEFT;
                                                                  SELF := [];));


    //roll resident/tentant counts to a per address level
    rollRTData := ROLLUP(SORT(rtRelationships, seq, inquiredDID, addrs.seq),
                          LEFT.seq = RIGHT.seq AND
                          LEFT.inquiredDID = RIGHT.inquiredDID AND
                          LEFT.addrs.seq = RIGHT.addrs.seq,
                          TRANSFORM(DueDiligence.LayoutsInternalReport.MobilityData,
                                    SELF.resTenInfo := LEFT.resTenInfo + RIGHT.resTenInfo;
                                    SELF := LEFT;));

    //add all of the tenant counts
    addAllRTCounts := JOIN(addAreaRisk, rollRTData,
                            LEFT.seq = RIGHT.seq AND
                            LEFT.inquiredDID = RIGHT.inquiredDID AND
                            LEFT.addrs.seq = RIGHT.addrs.seq,
                            TRANSFORM(DueDiligence.LayoutsInternalReport.MobilityData,

                                      residentTenantInfo := RIGHT.resTenInfo;

                                      SELF.numberCurrentResidentTenants := COUNT(residentTenantInfo);
                                      SELF.numberOfRelatives := COUNT(residentTenantInfo(relative));
                                      SELF.numberOfBusAssocs := COUNT(residentTenantInfo(busAssocs));
                                      SELF.numberHighRiskProfServOfStudy := COUNT(residentTenantInfo(highRiskProfServOfStudy));
                                      SELF.numberPotentialCrimArrest := COUNT(residentTenantInfo(potentialCrimArrest));
                                      SELF.numberOfPotentialSOs := COUNT(residentTenantInfo(potentialSOs));
                                      SELF.resTenInfo := residentTenantInfo;

                                      SELF := LEFT;),
                            LEFT OUTER,
                            ATMOST(1));



    convertToESP := PROJECT(addAllRTCounts, TRANSFORM({UNSIGNED6 seq, UNSIGNED6 inquiredDID, UNSIGNED addressSeq, UNSIGNED currAddrCnt, UNSIGNED prevAddrCnt, DATASET(iesp.duediligencepersonreport.t_DDRPersonAddressDetails) addrDetails},

                                                      addr := LEFT.addrs;

                                                      SELF.addrDetails := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonAddressDetails,
                                                                                              SELF.address := iesp.ECL2ESP.SetAddress(addr.prim_name, addr.prim_range, addr.predir,
                                                                                                                                      addr.postdir, addr.addr_suffix, addr.unit_desig,
                                                                                                                                      addr.sec_range, addr.city, addr.state, addr.zip5,
                                                                                                                                      addr.zip4, LEFT.countyName, DueDiligence.Constants.EMPTY,
                                                                                                                                      DueDiligence.Constants.EMPTY, DueDiligence.Constants.EMPTY);

                                                                                              SELF.addressFirstSeenDate := iesp.ECL2ESP.toDate(LEFT.addrs.dateFirstSeen);
                                                                                              SELF.addressLastSeenDate := iesp.ECL2ESP.toDate(LEFT.addrs.dateLastSeen);
                                                                                              SELF.addressType := LEFT.addressType;
                                                                                              SELF.milesFromPreviousResidence := (UNSIGNED)LEFT.movingDistances;

                                                                                              SELF.areaInformation.areaRisk := LEFT.areaRisk;
                                                                                              SELF.areaInformation.residencyStatus := LEFT.currentPreviousIndicator;
                                                                                              SELF.areaInformation.residencyType := ''; //Will revisit at later date

                                                                                              SELF.residentTenantRisk.numberCurrentResidentTenant := LEFT.numberCurrentResidentTenants;
                                                                                              SELF.residentTenantRisk.numberRelatives := LEFT.numberOfRelatives;
                                                                                              SELF.residentTenantRisk.numberBusinessAssociates := LEFT.numberOfBusAssocs;
                                                                                              SELF.residentTenantRisk.numberHighRiskProfServiceProvidersOrFieldOfStudy := LEFT.numberHighRiskProfServOfStudy;
                                                                                              SELF.residentTenantRisk.numberPotentialCriminalRecordsArrests := LEFT.numberPotentialCrimArrest;
                                                                                              SELF.residentTenantRisk.numberPotentialSexOffenders := LEFT.numberOfPotentialSOs;

                                                                                              SELF := [];)]);



                                                      SELF.seq := LEFT.seq;
                                                      SELF.inquiredDID := LEFT.inquiredDID;
                                                      SELF.addressSeq := LEFT.addrs.seq;

                                                      currAddrIndicator := tblCurrPrevAddrIndicator(seq = LEFT.seq AND inquiredDID = LEFT.inquiredDID AND currentPreviousIndicator = CURRENT_ADDRESS_TEXT);
                                                      prevAddrIndicator := tblCurrPrevAddrIndicator(seq = LEFT.seq AND inquiredDID = LEFT.inquiredDID AND currentPreviousIndicator = PRIOR_ADDRESS_TEXT);

                                                      SELF.currAddrCnt := currAddrIndicator[1].indicatorCnt;
                                                      SELF.prevAddrCnt := prevAddrIndicator[1].indicatorCnt;

                                                      SELF := [];));

    //limit residency
    sortGrpResidency := GROUP(SORT(convertToESP, seq, inquiredDID, addressSeq), seq, inquiredDID);
    limitedResidency := DueDiligence.Common.GetMaxRecords(sortGrpResidency, iesp.constants.DDRAttributesConst.MaxResidence);

    rollResidency := ROLLUP(SORT(limitedResidency, seq, inquiredDID),
                            LEFT.seq = RIGHT.seq AND
                            LEFT.inquiredDID = RIGHT.inquiredDID,
                            TRANSFORM(RECORDOF(LEFT),
                                      SELF.addrDetails := LEFT.addrDetails + RIGHT.addrDetails;
                                      SELF := LEFT;));


    addMobilityToReport := JOIN(inData, rollResidency,
                                LEFT.seq = RIGHT.seq AND
                                LEFT.inquiredDID = RIGHT.inquiredDID,
                                TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                          SELF.personReport.PersonAttributeDetails.Geographic.ResidenceDetails := RIGHT.addrDetails;
                                          SELF.personReport.PersonAttributeDetails.Geographic.NumberCurrentResidence := RIGHT.currAddrCnt;
                                          SELF.personReport.PersonAttributeDetails.Geographic.NumberPriorResidence := RIGHT.prevAddrCnt;

                                          SELF := LEFT;),
                                LEFT OUTER,
                                ATMOST(1));





    // OUTPUT(normAddresses, NAMED('normAddresses'));
    // OUTPUT(cleanDates, NAMED('cleanDates'));
    // OUTPUT(calcMovingDist, NAMED('calcMovingDist'));
    // OUTPUT(addMovingDistances, NAMED('addMovingDistances'));
    // OUTPUT(getAddressType, NAMED('getAddressType'));
    // OUTPUT(addAddressType, NAMED('addAddressType'));
    // OUTPUT(countyNameResults, NAMED('countyNameResults'));
    // OUTPUT(addAreaRisk, NAMED('addAreaRisk'));
    // OUTPUT(tblCurrPrevAddrIndicator, NAMED('tblCurrPrevAddrIndicator'));

    // OUTPUT(residentTenants, NAMED('residentTenants'));
    // OUTPUT(dedupResidentTentants, NAMED('dedupResidentTentants'));
    // OUTPUT(limitResidentTentants, NAMED('limitResidentTentants'));
    // OUTPUT(uniqueResidentTenantDIDs, NAMED('uniqueResidentTenantDIDs'));
    // OUTPUT(bestResidentTenantInfo, NAMED('bestResidentTenantInfo'));

    // OUTPUT(currentResidentTenants, NAMED('currentResidentTenants'));

    // OUTPUT(uniqueCurrentResidentTenants, NAMED('uniqueCurrentResidentTenants'));
    // OUTPUT(relatedParty, NAMED('relatedParty'));

    // OUTPUT(rtProfLic, NAMED('rtProfLic'));
    // OUTPUT(rtProfLicResults, NAMED('rtProfLicResults'));
    // OUTPUT(rtCrimData, NAMED('rtCrimData'));
    // OUTPUT(rtSexOffender, NAMED('rtSexOffender'));
    // OUTPUT(rtCrimResult, NAMED('rtCrimResult'));
    // OUTPUT(rtCrimProfLicResults, NAMED('rtCrimProfLicResults'));

    // OUTPUT(rtRelationships, NAMED('rtRelationships'));
    // OUTPUT(rollRTData, NAMED('rollRTData'));
    // OUTPUT(addAllRTCounts, NAMED('addAllRTCounts'));
    // OUTPUT(convertToESP, NAMED('convertToESP'));
    // OUTPUT(rollResidency, NAMED('rollResidency'));


    RETURN addMobilityToReport;
END;
