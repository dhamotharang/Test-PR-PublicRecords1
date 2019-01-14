IMPORT BIPv2, Business_Risk_BIP, BusReg, DueDiligence, STD;

/* 
	Following Keys being used:
			BusReg.key_busreg_company_linkids.kFetch2
*/
EXPORT getBusRegistrationImpl := MODULE

    EXPORT getFilteredData(DATASET(DueDiligence.Layouts.Busn_Internal) inData, Business_Risk_BIP.LIB_Business_Shell_LIBIN options) := FUNCTION
         rawBusRegistration := BusReg.key_busreg_company_linkids.kFetch2(DueDiligence.CommonBusiness.GetLinkIDs(inData),
                                                                         Business_Risk_BIP.Common.SetLinkSearchLevel(options.LinkSearchLevel),
                                                                         0, //ScoreThreshold --> 0 = Give me everything
                                                                         Business_Risk_BIP.Constants.Limit_Default,
                                                                         options.KeepLargeBusinesses);
	
        //add back seq numbers
        regBusSeq := DueDiligence.CommonBusiness.AppendSeq(rawBusRegistration, inData, TRUE);
        
        //clean dates used in logic and/or attribute levels here so all comparisions flow through consistently - dates used in FilterRecords have been cleaned
        regBusCleanDates := DueDiligence.Common.CleanDatasetDateFields(regBusSeq, 'dt_first_seen, dt_vendor_first_reported, record_date, dt_last_seen');

        //filter out records after our history date.
        regBusFilt := DueDiligence.Common.FilterRecords(regBusCleanDates, dt_first_seen, dt_vendor_first_reported);
        
        RETURN regBusFilt;
    END;



    EXPORT getRegisteredBusinessHit(inBusiness, filteredData) := FUNCTIONMACRO
        regBusSort := SORT(filteredData, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -record_date);
        regBusDedup := DEDUP(regBusSort, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
        
        regBusHit := JOIN(inBusiness, regBusDedup,
                          LEFT.seq = RIGHT.seq AND
                          LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
                          LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
                          LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,	
                          TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                    SELF.BusRegHit := IF(RIGHT.br_id <> 0, TRUE, FALSE);
                                    SELF := LEFT;),
                          LEFT OUTER,
                          ATMOST(1));
                                   
        RETURN regBusHit;
    ENDMACRO;
    
    
    
    EXPORT getSICNAICS(inBusiness, filteredData) := FUNCTIONMACRO
        outRegBusSic := DueDiligence.CommonBusiness.getSicNaicCodes(filteredData, DueDiligence.Constants.EMPTY, DueDiligence.Constants.SOURCE_BUSINESS_REGISTRATION, RawFields.SIC, TRUE, TRUE, dt_first_seen, dt_last_seen);
        outRegBusNaic := DueDiligence.CommonBusiness.getSicNaicCodes(filteredData, DueDiligence.Constants.EMPTY, DueDiligence.Constants.SOURCE_BUSINESS_REGISTRATION, RawFields.NAICS, FALSE, TRUE, dt_first_seen, dt_last_seen);
        
        allRegBusSicNaic := outRegBusSic + outRegBusNaic;
        sortRegBusRollSicNaic := DueDiligence.CommonBusiness.rollSicNaicBySeqAndBIP(inBusiness, allRegBusSicNaic);
          
        regBusSicNaic := JOIN(inBusiness, sortRegBusRollSicNaic,
                              LEFT.seq = RIGHT.seq AND
                              LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
                              LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
                              LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
                              TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                        SELF.SicNaicSources := RIGHT.sources;
                                        SELF := LEFT;),
                              LEFT OUTER,
                              ATMOST(1));
                              
        RETURN regBusSicNaic;
    ENDMACRO;
    
    
    
    EXPORT getRegisteredAgents(inBusiness, filteredData) := FUNCTIONMACRO
        busRegAgent := filteredData(rawfields.ra_name <> DueDiligence.Constants.EMPTY AND clean_ra_address.prim_name <> DueDiligence.Constants.EMPTY);
        sortBusRegAgent := SORT(busRegAgent, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), clean_ra_address.prim_range, clean_ra_address.predir, clean_ra_address.prim_name, clean_ra_address.addr_suffix, clean_ra_address.postdir, clean_ra_address.zip, dt_first_seen);

        rollBusRegAgent := ROLLUP(sortBusRegAgent,
                                  LEFT.seq = RIGHT.seq AND
                                  LEFT.ultID = RIGHT.ultID AND
                                  LEFT.orgID = RIGHT.orgID AND
                                  LEFT.seleID = RIGHT.seleID AND
                                  LEFT.clean_ra_address.prim_range = RIGHT.clean_ra_address.prim_range AND
                                  LEFT.clean_ra_address.predir = RIGHT.clean_ra_address.predir AND
                                  LEFT.clean_ra_address.prim_name = RIGHT.clean_ra_address.prim_name AND
                                  LEFT.clean_ra_address.addr_suffix = RIGHT.clean_ra_address.addr_suffix AND
                                  LEFT.clean_ra_address.postdir = RIGHT.clean_ra_address.postdir AND
                                  LEFT.clean_ra_address.zip = RIGHT.clean_ra_address.zip,
                                  TRANSFORM({RECORDOF(LEFT)},
                                             SELF.dt_last_seen := MAX(LEFT.dt_last_seen, RIGHT.dt_last_seen);
                                             SELF := LEFT;));
        
        projectBusRegAgent := PROJECT(rollBusRegAgent, TRANSFORM(DueDiligence.LayoutsInternal.Agent,
                                                                  SELF.ultID := LEFT.ultID;
                                                                  SELF.orgID := LEFT.orgID;
                                                                  SELF.seleID := LEFT.seleID;
                                                                  SELF.proxID := LEFT.proxID;
                                                                  SELF.powID := LEFT.powID;
                                                                  SELF.agent.source := DueDiligence.Constants.SOURCE_BUSINESS_REGISTRATION;
                                                                  SELF.agent.prim_range := LEFT.clean_ra_address.prim_range;
                                                                  SELF.agent.predir := LEFT.clean_ra_address.predir;
                                                                  SELF.agent.prim_name := LEFT.clean_ra_address.prim_name;
                                                                  SELF.agent.addr_suffix := LEFT.clean_ra_address.addr_suffix;
                                                                  SELF.agent.postdir := LEFT.clean_ra_address.postdir;
                                                                  SELF.agent.unit_desig := LEFT.clean_ra_address.unit_desig;
                                                                  SELF.agent.sec_range := LEFT.clean_ra_address.sec_range;
                                                                  SELF.agent.city := LEFT.clean_ra_address.v_city_name;
                                                                  SELF.agent.state := LEFT.clean_ra_address.st;
                                                                  SELF.agent.zip5 := LEFT.clean_ra_address.zip;
                                                                  SELF.agent.zip4 := LEFT.clean_ra_address.zip4;
                                                                  SELF.agent.fullName := LEFT.rawfields.ra_name;
                                                                  SELF.agent.dateFirstSeen := LEFT.dt_first_seen;
                                                                  SELF.agent.dateLastSeen := LEFT.dt_last_seen;
                                                                  SELF := LEFT;
                                                                  SELF := [];));
                                                                  
        agents := DueDiligence.CommonBusiness.AddAgents(projectBusRegAgent, inBusiness); 	
        
        RETURN agents;
    ENDMACRO;
END;