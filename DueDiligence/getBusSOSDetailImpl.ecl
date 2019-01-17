IMPORT BIPv2, Business_Risk_BIP, Corp2, DueDiligence, STD;

/*
	Following Keys being used:
			Corp2.Key_LinkIDs.Corp.kfetch2
*/
EXPORT getBusSOSDetailImpl := MODULE

    EXPORT getFilteredData(DATASET(DueDiligence.Layouts.Busn_Internal) inData, Business_Risk_BIP.LIB_Business_Shell_LIBIN options) := FUNCTION
        corpFilingsRaw := Corp2.Key_LinkIDs.Corp.kfetch2(DueDiligence.CommonBusiness.GetLinkIDs(inData),
                                                         Business_Risk_BIP.Common.SetLinkSearchLevel(options.LinkSearchLevel),
                                                         0, // ScoreThreshold --> 0 = Give me everything
                                                         Business_Risk_BIP.Constants.Limit_Default,
                                                         options.KeepLargeBusinesses);
                                                     
        //add back to the seq numbers
        corpFilingsSeq := DueDiligence.CommonBusiness.AppendSeq(corpFilingsRaw, indata, TRUE);
          
        //clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
        corpFilingsCleanDate := DueDiligence.Common.CleanDatasetDateFields(corpFilingsSeq, 'dt_first_seen, dt_vendor_first_reported, corp_inc_date, corp_filing_date, dt_last_seen');
        
        //filter out records after our history date.
        corpFilingsFilt := DueDiligence.Common.FilterRecords(corpFilingsCleanDate, dt_first_seen, dt_vendor_first_reported);
        
        RETURN corpFilingsFilt;	
    END;
    
    
    
    EXPORT getIncorporationDate(inBusiness, filteredData) := FUNCTIONMACRO
        incDateSort := SORT(filteredData(corp_inc_date <> 0), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_inc_date);
        incDateDedup := DEDUP(incDateSort, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
        
        addIncDate := JOIN(inBusiness, incDateDedup,
                            LEFT.seq = RIGHT.seq AND
                            LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
                            LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
                            LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,	
                            TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                      SELF.SOSIncorporationDate := (UNSIGNED)RIGHT.corp_inc_date;
                                      SELF := LEFT;),
                            LEFT OUTER,
                            ATMOST(1));
                            
        RETURN addIncDate;
    ENDMACRO;
    
    
    EXPORT getFilingDate(inBusiness, filteredData) := FUNCTIONMACRO
        corpFilingDateSort := SORT(filteredData, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -corp_filing_date);
        corpFilingDateDedup := DEDUP(corpFilingDateSort, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
        
        addEverFiled := JOIN(inBusiness, corpFilingDateDedup,
                              LEFT.seq = RIGHT.seq AND
                              LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
                              LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
                              LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,	
                              TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                        SELF.filingDate := (UNSIGNED)RIGHT.corp_filing_date;
                                        SELF.NoSOSFilingEver := IF((UNSIGNED)RIGHT.corp_filing_date > 0, FALSE, TRUE); //if a filing date is populated, corp filed at one point
                                        SELF := LEFT;),
                              LEFT OUTER,
                              ATMOST(1));
                              
        RETURN addEverFiled;
    ENDMACRO;
    
    
    EXPORT getOperatingLocations(inBusiness, filteredData) := FUNCTIONMACRO
        filtAddrLoc := filteredData(corp_addr1_prim_name != DueDiligence.Constants.EMPTY AND REGEXFIND(DueDiligence.RegularExpressions.NOT_PO_ADDRESS_EXPRESSION, TRIM(corp_addr1_prim_name), NOCASE));
        corpAddrLocSort := SORT(filtAddrLoc, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop4Linkids()), -dt_last_seen);
        corpAddrLocDedup := DEDUP(corpAddrLocSort, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop4Linkids()));
        
        corpAddrProject := PROJECT(corpAddrLocDedup, TRANSFORM(DueDiligence.LayoutsInternal.OperatingLocationLayout,
                                                                SELF.addrCount := 1;
                                                                SELF.locAddrs := PROJECT(LEFT, TRANSFORM(DueDiligence.Layouts.CommonGeographicLayout,
                                                                                                          SELF.prim_range:= LEFT.corp_addr1_prim_range;
                                                                                                          SELF.predir:= LEFT.corp_addr1_predir;
                                                                                                          SELF.prim_name:= LEFT.corp_addr1_prim_name;
                                                                                                          SELF.addr_suffix:= LEFT.corp_addr1_addr_suffix;
                                                                                                          SELF.postdir:= LEFT.corp_addr1_postdir;
                                                                                                          SELF.unit_desig:= LEFT.corp_addr1_unit_desig;
                                                                                                          SELF.sec_range:= LEFT.corp_addr1_sec_range;
                                                                                                          SELF.city:= LEFT.corp_addr1_v_city_name;
                                                                                                          SELF.state:= LEFT.corp_addr1_state;
                                                                                                          SELF.zip5:= LEFT.corp_addr1_zip5;
                                                                                                          SELF.zip4:= LEFT.corp_addr1_zip4;
                                                                                                          SELF.cart:= LEFT.corp_addr1_cart;
                                                                                                          SELF.cr_sort_sz:= LEFT.corp_addr1_cr_sort_sz;
                                                                                                          SELF.lot:= LEFT.corp_addr1_lot;	
                                                                                                          SELF.lot_order:= LEFT.corp_addr1_lot_order;
                                                                                                          SELF.dbpc:= LEFT.corp_addr1_dpbc;	
                                                                                                          SELF.chk_digit:= LEFT.corp_addr1_chk_digit;
                                                                                                          SELF.rec_type:= LEFT.corp_addr1_rec_type;                               
                                                                                                          SELF.geo_lat:= LEFT.corp_addr1_geo_lat;
                                                                                                          SELF.geo_long:= LEFT.corp_addr1_geo_long;
                                                                                                          SELF.msa:= LEFT.corp_addr1_msa; 	
                                                                                                          SELF.geo_blk:= LEFT.corp_addr1_geo_blk;
                                                                                                          SELF.geo_match:= LEFT.corp_addr1_geo_match;
                                                                                                          SELF.err_stat:= LEFT.corp_addr1_err_stat;
                                                                                                          SELF.dateLastSeen := LEFT.dt_last_seen;
                                                                                                          SELF := LEFT;
                                                                                                          SELF := [];));
                                                                SELF := LEFT;
                                                                SELF := [];));
        
        addBusnLocCnt := DueDiligence.CommonBusiness.AddOperatingLocations(corpAddrProject, inBusiness, DueDiligence.Constants.SOURCE_BUSINESS_CORP);
				
        RETURN addBusnLocCnt;
    ENDMACRO;
    
    
    
    EXPORT getSICNAICS(inBusiness, filteredData) := FUNCTIONMACRO
        outCorpSic := DueDiligence.CommonBusiness.getSicNaicCodes(filteredData, DueDiligence.Constants.EMPTY, DueDiligence.Constants.SOURCE_BUSINESS_CORP, corp_sic_code, TRUE, TRUE, dt_first_seen, dt_last_seen);
        outCorpNaic := DueDiligence.CommonBusiness.getSicNaicCodes(filteredData, DueDiligence.Constants.EMPTY, DueDiligence.Constants.SOURCE_BUSINESS_CORP, corp_naic_code, FALSE, TRUE, dt_first_seen, dt_last_seen);
        
        allCorpSicNaic := outCorpSic + outCorpNaic;
        sortCorpRollSicNaic := DueDiligence.CommonBusiness.rollSicNaicBySeqAndBIP(inBusiness, allCorpSicNaic);
          
        addCorpSicNaic := JOIN(inBusiness, sortCorpRollSicNaic,
                                LEFT.seq = RIGHT.seq AND
                                LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
                                LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
                                LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
                                TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                          SELF.SicNaicSources := RIGHT.sources;
                                          SELF := LEFT;),
                                LEFT OUTER,
                                ATMOST(1));
                                
        RETURN addCorpSicNaic;
    ENDMACRO;
    
    
    
    EXPORT getFilingStatuses(inBusiness, filteredData) := FUNCTIONMACRO
        projectDates := PROJECT(filteredData, TRANSFORM({UNSIGNED4 lastReinstateDate, BOOLEAN otherStatusExists, BOOLEAN dissolvedExists, BOOLEAN inactiveExists, Boolean suspendedExists, BOOLEAN allDissolveInactiveSuspended, BOOLEAN activeExists, BOOLEAN sosFilingExists, {RECORDOF(corpFilingsFilt)}},
                                                        corpStatusCd := DueDiligence.CommonBusiness.GetSOSStatuses(LEFT);
                      
                                                        SELF.lastReinstateDate := IF(corpStatusCd = DueDiligence.Constants.CORP_STATUS_REINSTATE, LEFT.dt_last_seen, DueDiligence.Constants.NUMERIC_ZERO);
                                                        SELF.activeExists := IF(corpStatusCd = DueDiligence.Constants.CORP_STATUS_ACTIVE, TRUE, FALSE);
                                                        SELF.dissolvedExists := IF(corpStatusCd = DueDiligence.Constants.CORP_STATUS_DISSOLVED, TRUE, FALSE);
                                                        SELF.inactiveExists := IF(corpStatusCd = DueDiligence.Constants.CORP_STATUS_INACTIVE, TRUE, FALSE);
                                                        SELF.suspendedExists := IF(corpStatusCd = DueDiligence.Constants.CORP_STATUS_SUSPEND, TRUE, FALSE);
                                                        SELF.allDissolveInactiveSuspended := IF(corpStatusCd IN [DueDiligence.Constants.CORP_STATUS_DISSOLVED, DueDiligence.Constants.CORP_STATUS_INACTIVE, DueDiligence.Constants.CORP_STATUS_SUSPEND], TRUE, FALSE);
                                                        SELF.otherStatusExists := IF(corpStatusCd = DueDiligence.Constants.COPR_STATUS_OTHER, TRUE, FALSE);
                                                        SELF.sosFilingExists := TRUE;
                                                        SELF := LEFT;));
                                                                      
        lastSeenSort := SORT(projectDates, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_sos_charter_nbr, -dt_last_seen);
        
        rollLastSeen := ROLLUP(lastSeenSort,
                                LEFT.seq = RIGHT.seq AND
                                LEFT.ultID = RIGHT.ultID AND
                                LEFT.orgID = RIGHT.orgID AND
                                LEFT.seleID = RIGHT.seleID,
                                TRANSFORM({RECORDOF(LEFT)},
                                          SELF.lastReinstateDate := MAX(LEFT.lastReinstateDate, RIGHT.lastReinstateDate);
                                          SELF.activeExists := LEFT.activeExists OR RIGHT.activeExists;
                                          SELF.dissolvedExists :=LEFT.dissolvedExists OR RIGHT.dissolvedExists;
                                          SELF.inactiveExists := LEFT.inactiveExists OR RIGHT.inactiveExists;
                                          SELF.suspendedExists := LEFT.suspendedExists OR RIGHT.suspendedExists;
                                          SELF.allDissolveInactiveSuspended := LEFT.allDissolveInactiveSuspended AND RIGHT.allDissolveInactiveSuspended;
                                          SELF.otherStatusExists := LEFT.otherStatusExists OR RIGHT.otherStatusExists;
                                          SELF.sosFilingExists := LEFT.sosFilingExists OR RIGHT.sosFilingExists;
                                          SELF := LEFT;));

        addSosStatusDates := JOIN(inBusiness, rollLastSeen,
                                  LEFT.seq = RIGHT.seq AND
                                  LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
                                  LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
                                  LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
                                  TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                            SELF.sosAllDissolveInactiveSuspend := RIGHT.allDissolveInactiveSuspended;
                                            SELF.sosHasAtleastOneDissolvedFiling := RIGHT.dissolvedExists;					
                                            SELF.sosHasAtleastOneInactiveFiling := RIGHT.inactiveExists;					
                                            SELF.sosHasAtleastOneSuspendedFiling := RIGHT.suspendedExists;					
                                            SELF.sosHasAtleastOneActiveFiling := RIGHT.activeExists;
                                            SELF.sosHasAtleastOneOtherStatusFiling := RIGHT.otherStatusExists;
                                            SELF.sosLastReinstateDate := RIGHT.lastReinstateDate;
                                            SELF.sosFilingExists := RIGHT.sosFilingExists;
                                            SELF := LEFT;),
                                  LEFT OUTER,
                                  ATMOST(1));
                                  
        RETURN addSosStatusDates;
    ENDMACRO;
    
    
    
    EXPORT getIncoprorationWithLooseLaws(inBusiness, filteredData) := FUNCTIONMACRO
        projectLooseLaws := PROJECT(filteredData, TRANSFORM({BOOLEAN looseLawState, RECORDOF(LEFT)}, 
                                                            SELF.looseLawState := LEFT.corp_inc_state IN DueDiligence.Constants.STATES_WITH_LOOSE_INCORPORATION_LAWS;
                                                            SELF := LEFT;
                                                            SELF := [];));
        
        sortLooseLaws := SORT(projectLooseLaws, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
        
        rollLooseLaws := ROLLUP(sortLooseLaws,
                                LEFT.seq = RIGHT.seq AND
                                LEFT.ultID = RIGHT.ultID AND
                                LEFT.orgID = RIGHT.orgID AND
                                LEFT.seleID = RIGHT.seleID,
                                TRANSFORM({RECORDOF(LEFT)},
                                            SELF.looseLawState := LEFT.looseLawState OR RIGHT.looseLawState;
                                            SELF := LEFT;));
                                            
        addIncLooseLaws := JOIN(inBusiness, rollLooseLaws,
                                LEFT.seq = RIGHT.seq AND
                                LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
                                LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
                                LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
                                TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                          SELF.incorpWithLooseLaws := LEFT.incorpWithLooseLaws OR RIGHT.looseLawState;
                                          SELF := LEFT;),
                                LEFT OUTER,
                                ATMOST(1));
                                
        RETURN addIncLooseLaws;
    ENDMACRO;
    
    
    
    EXPORT getRegisteredAgents(inBusiness, filteredData) := FUNCTIONMACRO
        sosAgent := filteredData((corp_ra_cname1 <> DueDiligence.Constants.EMPTY OR corp_ra_lname1 <> DueDiligence.Constants.EMPTY) AND corp_ra_prim_name <> DueDiligence.Constants.EMPTY);
        sortSosAgent := SORT(sosAgent, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_ra_prim_range, corp_ra_predir, corp_ra_prim_name, corp_ra_addr_suffix, corp_ra_postdir, corp_ra_zip5, dt_first_seen);

        rollSosAgent := ROLLUP(sortSosAgent,
                                LEFT.seq = RIGHT.seq AND
                                LEFT.ultID = RIGHT.ultID AND
                                LEFT.orgID = RIGHT.orgID AND
                                LEFT.seleID = RIGHT.seleID AND
                                LEFT.corp_ra_prim_range = RIGHT.corp_ra_prim_range AND
                                LEFT.corp_ra_predir = RIGHT.corp_ra_predir AND
                                LEFT.corp_ra_prim_name = RIGHT.corp_ra_prim_name AND
                                LEFT.corp_ra_addr_suffix = RIGHT.corp_ra_addr_suffix AND
                                LEFT.corp_ra_postdir = RIGHT.corp_ra_postdir AND
                                LEFT.corp_ra_zip5 = RIGHT.corp_ra_zip5,
                                TRANSFORM({RECORDOF(LEFT)},
                                           SELF.dt_last_seen := MAX(LEFT.dt_last_seen, RIGHT.dt_last_seen);
                                           SELF := LEFT;));
        
        projectSosAgent := PROJECT(rollSosAgent, TRANSFORM(DueDiligence.LayoutsInternal.Agent,
                                                            SELF.agent.source := DueDiligence.Constants.SOURCE_BUSINESS_CORP;
                                                            SELF.agent.prim_range := LEFT.corp_ra_prim_range;
                                                            SELF.agent.predir := LEFT.corp_ra_predir;
                                                            SELF.agent.prim_name := LEFT.corp_ra_prim_name;
                                                            SELF.agent.addr_suffix := LEFT.corp_ra_addr_suffix;
                                                            SELF.agent.postdir := LEFT.corp_ra_postdir;
                                                            SELF.agent.unit_desig := LEFT.corp_ra_unit_desig;
                                                            SELF.agent.sec_range := LEFT.corp_ra_sec_range;
                                                            SELF.agent.city := LEFT.corp_ra_v_city_name;
                                                            SELF.agent.state := LEFT.corp_ra_state;
                                                            SELF.agent.zip5 := LEFT.corp_ra_zip5;
                                                            SELF.agent.zip4 := LEFT.corp_ra_zip4;
                                                            SELF.agent.fullName := LEFT.corp_ra_cname1;
                                                            SELF.agent.firstName := LEFT.corp_ra_fname1;
                                                            SELF.agent.lastName := LEFT.corp_ra_lname1;
                                                            SELF.agent.dateFirstSeen := LEFT.dt_first_seen;
                                                            SELF.agent.dateLastSeen := LEFT.dt_last_seen;
                                                            SELF := LEFT;
                                                            SELF := [];));
                                                                                                                        
        addAgents := DueDiligence.CommonBusiness.AddAgents(projectSosAgent, inBusiness);
        
        RETURN addAgents;
    ENDMACRO;
END;