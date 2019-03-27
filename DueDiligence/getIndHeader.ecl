Import doxie, drivers, header, mdr, Risk_Indicators, riskwise, header_quick, ut, STD;

/*
	Following Keys being used:
			doxie.Key_Header
			header_quick.key_DID
			VotersV2.Key_Voters_States
*/

EXPORT getIndHeader(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                    STRING dataRestrictionMask,
                    UNSIGNED1 dppa,
                    UNSIGNED1 glba,
                    BOOLEAN isFCRA,
                    BOOLEAN includeReport = FALSE) := FUNCTION

												
    BOOLEAN isUtility := FALSE;

    glb_ok := Risk_Indicators.iid_constants.glb_ok(glba, isFCRA);
    dppa_ok := Risk_Indicators.iid_constants.dppa_ok(dppa, isFCRA);


    parents := DueDiligence.CommonIndividual.getRelationship(inData, parents, DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT);																																																							
    allInd := parents + inData;

    getHeaderData(key, didField, atmostValue, keepValue) := FUNCTIONMACRO
        results := JOIN(allInd, key, 
                        KEYED(LEFT.individual.did = RIGHT.didField) AND
                        RIGHT.src NOT IN Risk_Indicators.iid_constants.masked_header_sources(dataRestrictionMask, isFCRA) AND 
                        (~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
                        (header.isPreGLB(RIGHT) OR glb_ok) AND 
                        (~mdr.Source_is_DPPA(RIGHT.src) OR (dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src), dppa, RIGHT.src))) AND 
                        ~Risk_Indicators.iid_constants.filtered_source(RIGHT.src, RIGHT.st), 
                        TRANSFORM(DueDiligence.LayoutsInternal.IndSlimHeader, 
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
                        
        RETURN results;		
    ENDMACRO;


    keyHeader := getHeaderData(doxie.Key_Header, s_did, ut.limits.HEADER_PER_DID, DueDiligence.Constants.MAX_ATMOST_150);									
    quickHeader := getHeaderData(header_quick.key_DID, did, RiskWise.max_atmost, DueDiligence.Constants.MAX_ATMOST_100);
                        
    realHeader :=  quickHeader + keyHeader;

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
	
		


		RETURN addVoterInfo;
END;
