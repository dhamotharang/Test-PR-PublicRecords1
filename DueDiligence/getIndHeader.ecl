Import doxie, drivers, header, mdr, Risk_Indicators, riskwise, header_quick, ut, STD, Suppress, data_services;
IMPORT drivers, DueDiligence, dx_header, header, header_quick, MDR, Risk_Indicators, ut;

/*
	Following Keys being used:
			dx_header.key_header
			header_quick.key_DID
*/

EXPORT getIndHeader(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                    STRING dataRestrictionMask,
                    UNSIGNED1 dppa,
                    UNSIGNED1 glba,
                    BOOLEAN isFCRA,
                    INTEGER bsVersion,
                    BOOLEAN includeReport = FALSE,
                    doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

    data_environment :=  IF(isFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA);
                        

    glb_ok := Risk_Indicators.iid_constants.glb_ok(glba, isFCRA);
    dppa_ok := Risk_Indicators.iid_constants.dppa_ok(dppa, isFCRA);


    parents := DueDiligence.CommonIndividual.getRelationship(inData, parents, DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT);																																																							
    allInd := parents + inData;

    getHeaderData(key, didField, atmostValue, keepValue) := FUNCTIONMACRO
        results_unsuppressed := JOIN(allInd, key, 
                        KEYED(LEFT.individual.did = RIGHT.didField) AND
                        RIGHT.src NOT IN Risk_Indicators.iid_constants.masked_header_sources(dataRestrictionMask, isFCRA) AND 
                        (header.isPreGLB(RIGHT) OR glb_ok) AND 
                        (~mdr.Source_is_DPPA(RIGHT.src) OR (dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src), dppa, RIGHT.src))) AND 
                        ~Risk_Indicators.iid_constants.filtered_source(RIGHT.src, RIGHT.st, bsVersion), 
                        TRANSFORM({unsigned4 global_sid, DueDiligence.LayoutsInternal.IndSlimHeader}, 
                                  SELF.global_sid := RIGHT.global_sid;
                                  SELF.seq := LEFT.seq;
                                  SELF.inquiredDID := LEFT.inquiredDID;
                                  SELF.did := LEFT.individual.did;
                                  SELF.indvType := LEFT.indvType;
                                  SELF.historydate := LEFT.historyDate;
                                  SELF.dateFirstSeen := IF(RIGHT.dt_first_seen = 0, RIGHT.dt_vendor_first_reported, RIGHT.dt_first_seen);
                                  SELF.dateLastSeen := IF(RIGHT.dt_last_seen = 0, RIGHT.dt_vendor_last_reported, RIGHT.dt_last_seen);
                                  SELF.addr_suffix := RIGHT.suffix;
                                  SELF.city := RIGHT.city_name;
                                  SELF.state := RIGHT.st;
                                  SELF.zip5 := RIGHT.zip;
                                  SELF.firstName := RIGHT.fname;
                                  SELF.middleName := RIGHT.mname;
                                  SELF.lastName := RIGHT.lname;
                                  SELF.suffix := RIGHT.name_suffix;
                                  SELF := RIGHT;
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
    filterHeader := DueDiligence.Common.FilterRecordsSingleDate(headerCleanDates, dateFirstSeen);

    //only inquired records
    inquiredHeaderData := filterHeader(indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL);


    //first seen date for a given inquired did
    sortHeaderDateFirstSeen := SORT(inquiredHeaderData(dateFirstSeen <> 0), seq, did, dateFirstSeen);
    dedupHeaderDateFirstSeen := DEDUP(sortHeaderDateFirstSeen, seq, did);

    addDateFirstReported := JOIN(inData, dedupHeaderDateFirstSeen,
                                  LEFT.seq = RIGHT.seq AND
                                  LEFT.individual.did = RIGHT.did,
                                  TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                            SELF.firstReportedDate := RIGHT.dateFirstSeen;
                                            SELF := LEFT;),
                                  LEFT OUTER,
                                  ATMOST(DueDiligence.Constants.MAX_ATMOST_1));

                               
                               
    addVoterInfo := DueDiligence.getIndVoterData(addDateFirstReported, filterHeader);

    addMobilityInfo := DueDiligence.getIndMobility(addVoterInfo, inquiredHeaderData, isFCRA, bsVersion);

                                                                          




    // output(parents, named('parents'));
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

    // output(addVoterInfo, named('addVoterInfo'));
    // output(addMobilityInfo, named('addMobilityInfo'));




    RETURN addMobilityInfo;
END;
