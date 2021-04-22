IMPORT data_services, doxie, drivers, DueDiligence, dx_header, header, header_quick, MDR, Risk_Indicators, Suppress, ut;

/*
	Following Keys being used:
			dx_header.key_header
			header_quick.key_DID
*/

EXPORT getIndHeader(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                    doxie.IDataAccess mod_access,
                    BOOLEAN isFCRA,
                    INTEGER bsVersion,
                    BOOLEAN includeReport = FALSE) := FUNCTION

    data_environment :=  IF(isFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA);


    glb_ok := isFCRA OR doxie.compliance.glb_ok(mod_access.glb);
    dppa_ok := isFCRA OR doxie.compliance.dppa_ok(mod_access.dppa);
    dppa := mod_access.dppa;
    dataRestrictionMask := mod_access.dataRestrictionMask;

    parents := DueDiligence.CommonIndividual.GetRelationshipAsInquired(inData, parents, DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT);
    spouse := DueDiligence.CommonIndividual.GetRelationshipAsInquired(inData, spouses, DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE);
    associates := DueDiligence.CommonIndividual.GetRelationshipAsInquired(inData, associates, DueDiligence.Constants.INQUIRED_INDIVIDUAL_OTHER_RELATION);

    //remove any duplices - make sure we do not have any spouse/parents in associates
    removeDups := DEDUP(SORT(spouse + parents + associates, seq, inquiredDID, individual.did, indvType), seq, inquiredDID, individual.did);

    allInd := removeDups + inData;

    isPreGLB() := MACRO
      doxie.compliance.HeaderIsPreGLB((unsigned3)RIGHT.dt_nonglb_last_seen, (unsigned3)RIGHT.dt_first_seen, (string2)RIGHT.src, dataRestrictionMask)
    ENDMACRO;

    getHeaderData(key, didField, atmostValue, keepValue) := FUNCTIONMACRO
        results_unsuppressed := JOIN(allInd, key,
                                      KEYED(LEFT.individual.did = RIGHT.didField) AND
                                      RIGHT.src NOT IN Risk_Indicators.iid_constants.masked_header_sources(dataRestrictionMask, isFCRA) AND
                                      // (header.isPreGLB(RIGHT) OR glb_ok) AND
                                      (isPreGLB() OR glb_ok) AND
                                      (~mdr.Source_is_DPPA(RIGHT.src) OR (dppa_ok AND doxie.compliance.dppa_state_ok(dx_header.Functions.translateSource(RIGHT.src), mod_access.dppa, RIGHT.src))) AND
                                      ~Risk_Indicators.iid_constants.filtered_source(RIGHT.src, RIGHT.st, bsVersion),
                                      TRANSFORM({UNSIGNED4 global_sid, DueDiligence.LayoutsInternal.IndSlimHeader},
                                                SELF.global_sid := RIGHT.global_sid;
                                                SELF.seq := LEFT.seq;
                                                SELF.inquiredDID := LEFT.inquiredDID;
                                                SELF.did := LEFT.individual.did;
                                                SELF.indvType := LEFT.indvType;
                                                SELF.historydate := LEFT.historyDate;

                                                SELF.firstName := RIGHT.fname;
                                                SELF.middleName := RIGHT.mname;
                                                SELF.lastName := RIGHT.lname;
                                                SELF.suffix := RIGHT.name_suffix;

                                                SELF.inputSSN := LEFT.indvRawInput.ssn;
                                                SELF.bestSSN := LEFT.bestSSN;
                                                SELF.ssn := RIGHT.ssn;
                                                SELF.validSSN := RIGHT.valid_ssn;

                                                SELF.prim_range := RIGHT.prim_range;
                                                SELF.predir := RIGHT.predir;
                                                SELF.prim_name := RIGHT.prim_name;
                                                SELF.addr_suffix := RIGHT.suffix;
                                                SELF.postdir := RIGHT.postdir;
                                                SELF.unit_desig := RIGHT.unit_desig;
                                                SELF.sec_range := RIGHT.sec_range;
                                                SELF.city := RIGHT.city_name;
                                                SELF.state := RIGHT.st;
                                                SELF.zip5 := RIGHT.zip;
                                                SELF.zip4 := RIGHT.zip4;
                                                SELF.county := RIGHT.county;
                                                SELF.geo_blk := RIGHT.geo_blk;

                                                SELF.dateFirstSeen := IF(RIGHT.dt_first_seen = 0, RIGHT.dt_vendor_first_reported, RIGHT.dt_first_seen);
                                                SELF.dateLastSeen := IF(RIGHT.dt_last_seen = 0, RIGHT.dt_vendor_last_reported, RIGHT.dt_last_seen);
                                                SELF.src := RIGHT.src;

                                                SELF := [];),
                                      LEFT OUTER,
                                      ATMOST(atmostValue),
                                      KEEP(keepValue));

        results := Suppress.MAC_SuppressSource(results_unsuppressed, mod_access, data_env := data_environment);

        RETURN results;
    ENDMACRO;


    keyHeader := getHeaderData(dx_header.key_header(0), s_did, ut.limits.HEADER_PER_DID, DueDiligence.Constants.MAX_ATMOST_150);
    quickHeader := getHeaderData(header_quick.key_DID, did, DueDiligence.Constants.MAX_ATMOST_1000, DueDiligence.Constants.MAX_ATMOST_100);

    headerAll :=  quickHeader + keyHeader;
    realHeader := IF(dataRestrictionMask[Risk_Indicators.iid_constants.posEquifaxRestriction] = Risk_Indicators.iid_constants.sTrue, headerAll(src NOT IN [MDR.sourceTools.src_Equifax, MDR.sourcetools.src_Equifax_Quick, MDR.sourcetools.src_Equifax_Weekly]), headerAll);

    headerCleanDates := DueDiligence.Common.CleanDatasetDateFields(realHeader, 'dateFirstSeen, dateLastSeen');

    //filter out records after our history date - this contains both the inquired and parents data
    filterHeader := DueDiligence.CommonDate.FilterRecordsSingleDate(headerCleanDates, dateFirstSeen);

    //only inquired records
    inquiredHeaderData := filterHeader(indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL);

    //only parent and inquired records
    inquiredWithParentHeaderData := filterHeader(indvType IN [DueDiligence.Constants.INQUIRED_INDIVIDUAL, DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT]);


    //first seen date for a given inquired did
    sortHeaderDateFirstSeen := SORT(inquiredHeaderData(dateFirstSeen <> 0), seq, did, dateFirstSeen);
    dedupHeaderDateFirstSeen := DEDUP(sortHeaderDateFirstSeen, seq, did);

    addDateFirstReported := JOIN(inData, dedupHeaderDateFirstSeen,
                                  LEFT.seq = RIGHT.seq AND
                                  LEFT.inquiredDID = RIGHT.did,
                                  TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                            SELF.firstReportedDate := RIGHT.dateFirstSeen;
                                            SELF := LEFT;),
                                  LEFT OUTER,
                                  ATMOST(DueDiligence.Constants.MAX_ATMOST_1));


    //get the earliest first seen date for the inquireds relationships (spouses, parents, other relations)
    nonInquiredHeaderData := filterHeader(indvType <> DueDiligence.Constants.INQUIRED_INDIVIDUAL);

    sortRelativeDateFirstSeen := SORT(nonInquiredHeaderData(dateFirstSeen <> 0), seq, did, dateFirstSeen);
    dedupRelativeDateFirstSeen := DEDUP(sortRelativeDateFirstSeen, seq, did);

    convertToRelatedParty := DueDiligence.CommonIndividual.CreateRelatedPartyDataset(removeDups);

    addRelativeFirstSeen := JOIN(convertToRelatedParty, dedupRelativeDateFirstSeen,
                                  LEFT.seq = RIGHT.seq AND
                                  LEFT.party.did = RIGHT.did,
                                  TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,
                                            SELF.headerfirstseen := RIGHT.dateFirstSeen;
                                            SELF := LEFT;),
                                  LEFT OUTER,
                                  ATMOST(DueDiligence.Constants.MAX_ATMOST_1));

    perAssocOptions := MODULE(DueDiligence.DataInterface.iAttributePerAssoc)
                          EXPORT BOOLEAN includeSSNData := FALSE;
                          EXPORT BOOLEAN includeHeaderData := TRUE;
                       END;

    updateRelatives := DueDiligence.CommonIndividual.UpdateRelationships(addDateFirstReported, addRelativeFirstSeen, perAssocOptions);



    addVoterInfo := DueDiligence.getIndVoterData(updateRelatives, inquiredWithParentHeaderData);

    addMobilityInfo := DueDiligence.getIndMobility(addVoterInfo, inquiredHeaderData, isFCRA, bsVersion, includeReport);

    addReportData := IF(includeReport, DueDiligence.getIndHeaderReportData(addMobilityInfo, inquiredHeaderData), addMobilityInfo);






    // output(parents, named('parents'));
    // output(removeDups, named('removeDups'));
    // output(allInd, named('allInd'));

    // output(keyHeader, named('keyHeader'));
    // output(quickHeader, named('quickHeader'));
    // output(allInd, named('allInd_header'));
    // output(realHeader, named('realHeader'));

    // output(headerCleanDates, named('headerCleanDates'));
    // output(filterHeader, named('filterHeader'));
    // output(inquiredHeaderData, named('inquiredHeaderData'));

    // output(sortHeaderDateFirstSeen, named('sortHeaderDateFirstSeen'));
    // output(dedupHeaderDateFirstSeen, named('dedupHeaderDateFirstSeen'));
    // output(addDateFirstReported, named('addDateFirstReported'));

    // output(nonInquiredHeaderData, named('nonInquiredHeaderData'));
    // output(sortRelativeDateFirstSeen, named('sortRelativeDateFirstSeen'));
    // output(dedupRelativeDateFirstSeen, named('dedupRelativeDateFirstSeen'));
    // output(convertToRelatedParty, named('convertToRelatedParty'));
    // output(addRelativeFirstSeen, named('addRelativeFirstSeen'));
    // output(updateRelatives, named('updateRelatives'));

    // output(addVoterInfo, named('addVoterInfo'));
    // output(addMobilityInfo, named('addMobilityInfo'));
    // output(addReportData, named('addReportData'));




    RETURN addReportData;
END;
