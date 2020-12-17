EXPORT getBusHeaderReportData(businessHeaderData,
                              businessInternal,
                              options,
                              linkingOptions) := FUNCTIONMACRO
                              

    IMPORT BIPV2, BusinessInstantID20_Services, DueDiligence;


                          

    //get date vendor first reported - to be used to calc established date for report
    vendorFirstReported := SORT(businessHeaderData, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), dt_vendor_first_reported);
    
    rollVendorDates := ROLLUP(vendorFirstReported(dt_vendor_first_reported > 0), 
                            #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
                            TRANSFORM({RECORDOF(busHeaderFilt)},
                                      SELF.dt_vendor_first_reported := MIN(LEFT.dt_vendor_first_reported, RIGHT.dt_vendor_first_reported);
                                      SELF := LEFT;));
                                    
    addVenderFirstSeen := JOIN(businessInternal, rollVendorDates,
                                #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
                                TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                          SELF.dateVendorFirstReported := RIGHT.dt_vendor_first_reported;
                                          SELF := LEFT;),
                                LEFT OUTER);
                              
    //get additional names of business (DBA - Doing Business As)
    sortUniqueDBA := SORT(businessHeaderData(dba_name <> DueDiligence.Constants.EMPTY), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), dba_name, -dt_last_seen);
    dedupUniqueDBA := DEDUP(sortUniqueDBA, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), dba_name);
    
    //get max number of uniqueDBAs
    DueDiligence.LayoutsInternal.MultipleCompanyNames getMaxDBA(dedupUniqueDBA dudba, INTEGER dbaCount) := TRANSFORM, SKIP(dbaCount > DueDiligence.Constants.MAX_DBA_NAMES)
      SELF.companyNameAndLastSeen := PROJECT(dudba, TRANSFORM(DueDiligence.Layouts.DD_CompanyNames,
                                                              SELF.Name := LEFT.dba_name;
                                                              SELF.LinkCount := LEFT.dt_last_seen;
                                                              SELF := [];));
      SELF := dudba;
      SELF := [];   
    END;
                    
    mostRecentDBAs := GROUP(SORT(dedupUniqueDBA, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -dt_last_seen), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));	
    maxUniqueDBA := PROJECT(mostRecentDBAs, getMaxDBA(LEFT, COUNTER));
    
    rollUniqueDBAs := ROLLUP(UNGROUP(maxUniqueDBA),
                             #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
                             TRANSFORM({RECORDOF(LEFT)},
                                        SELF.companyNameAndLastSeen := LEFT.companyNameAndLastSeen + RIGHT.companyNameAndLastSeen;
                                        SELF := LEFT));
    
    addDBAs := JOIN(addVenderFirstSeen, rollUniqueDBAs,
                        #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
                        TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                              SELF.companyDBA := RIGHT.companyNameAndLastSeen;
                              SELF := LEFT;),
                        LEFT OUTER);
  
  
  
    //Determine the parent company
    emptyInput := DATASET([], BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean); //currently not used in fn_GetParentInfo as of 3/27/2018
    headerSlim := PROJECT(businessHeaderData, TRANSFORM(BusinessInstantID20_Services.layouts.BusinessHeaderSlim, SELF := LEFT; SELF := [];));
    
    parentInfo := BusinessInstantID20_Services.fn_GetParentInfo(emptyInput, headerSlim, options, linkingOptions);
       
    addParentCompany := JOIN(addDBAs, parentInfo,
                              LEFT.seq = RIGHT.seq,
                              TRANSFORM(RECORDOF(LEFT),
                                         SELF.parentCompanyName := RIGHT.parent_best_bus_name;
                                         SELF := LEFT;),
                              LEFT OUTER);
            
     
     
     
    //***************NON-CREDIT BUREAU SOURCES***************//	
    nonCreditBureaus := businessHeaderData(source NOT IN DueDiligence.Constants.CREDIT_SOURCES);
    addNONCreditSrc := DueDiligence.CommonBusiness.AddHeaderSources(nonCreditBureaus, addParentCompany, sourcesReporting);
    
    
    //***************CREDIT BUREAU SOURCES***************//
    creditBureaus := businessHeaderData(source IN DueDiligence.Constants.CREDIT_SOURCES);
    addCreditSrc := DueDiligence.CommonBusiness.AddHeaderSources(creditBureaus, addNONCreditSrc, bureauReporting);
    
 
 
    /*  Select just the Shell Shelf sources for the Shell Shelf Report section    */  
    shellSrcSummary := TABLE(businessHeaderData(source IN DueDiligence.Constants.BUS_SHELL_SOURCES), 
           /* define columns in the table */
           {seq, 
           #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), 
           TotalYellow          := SUM(GROUP, (integer)(source = DueDiligence.Constants.SOURCE_YELLOW_PAGES)),
           TotalBetterBusBueau  := SUM(GROUP, (integer)(source = DueDiligence.Constants.SOURCE_BETTER_BUS)), 
           TotalUtilities       := SUM(GROUP, (integer)(source = DueDiligence.Constants.SOURCE_UTILITIES)),
           TotalGongGov         := SUM(GROUP, (integer)(source = DueDiligence.Constants.SOURCE_GOVERNMENT)), 
           TotalGongBus         := SUM(GROUP, (integer)(source = DueDiligence.Constants.SOURCE_BUSINESS))
           /* end of columns in the table */  },
           /* Grouped By */   
           seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids())); 
      
  
 /*  Count the numbers from each source for the Shell Shelf Report section    */  
   
	addShellShelfCharCnt       := JOIN(addCreditSrc, shellSrcSummary,
													#EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.YellowPageCnt     := RIGHT.TotalYellow;
                                    SELF.BetterBusCnt      := RIGHT.TotalBetterBusBueau;
                                    SELF.UtilityCnt        := RIGHT.TotalUtilities;
                                    SELF.GongGovernmentCnt := RIGHT.TotalGongGov;
                                    SELF.GongBusinessCnt   := RIGHT.TotalGongBus;
																		SELF := LEFT),
													LEFT OUTER);

    
   
   
   
  // OUTPUT(sortUniqueDBA, NAMED('sortUniqueDBA'));	
	// OUTPUT(dedupUniqueDBA, NAMED('dedupUniqueDBA'));	
	// OUTPUT(maxUniqueDBA, NAMED('maxUniqueDBA'));	
	// OUTPUT(rollUniqueDBAs, NAMED('rollUniqueDBAs'));	
	// OUTPUT(addDBAs, NAMED('addDBAs'));
  
	// OUTPUT(parentInfo, NAMED('parentInfo'));
	// OUTPUT(addParentCompany, NAMED('addParentCompany'));
  
	// OUTPUT(addNONCreditSrc, NAMED('addNONCreditSrc'));
	// OUTPUT(addCreditSrc, NAMED('addCreditSrc'));
 // OUTPUT(shellSrcSummary, NAMED('shellSrcSummary'));
  
  
  
  
  RETURN addShellShelfCharCnt;
ENDMACRO;                          