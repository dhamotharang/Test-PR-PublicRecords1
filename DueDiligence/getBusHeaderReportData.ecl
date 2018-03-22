IMPORT BIPV2, BIPV2_Best, Business_Risk_BIP, DueDiligence, STD;

/*
	Following Keys being used: 
			BIPV2_Best.Key_LinkIds.kFetch2
*/

EXPORT getBusHeaderReportData(businessHeaderData,
                              businessInternal,
                              options,
                              linkingOptions) := FUNCTIONMACRO
                          

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
    
    addDBAs := JOIN(businessInternal, rollUniqueDBAs,
                        #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
                        TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                              SELF.companyDBA := RIGHT.companyNameAndLastSeen;
                              SELF := LEFT;),
                        LEFT OUTER);
  
  
  
    //Determine the parent company
    filterAboveSele := businessHeaderData(uniqueid != 0 AND parentAboveSELE = TRUE);
   
    sortFilter := SORT(UNGROUP(filterAboveSele), uniqueid, ultid, orgid, seleid, parent_proxid);
    dedupFilter := DEDUP(sortFilter, uniqueid, ultid, orgid, seleid, parent_proxid);

    // Get Parent and Ultimate Parent (Best) info.
	  parentLookup := PROJECT(dedupFilter, TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2, 
                                                  SELF.seleid := LEFT.parent_proxid;      // USING ---> parent proxid
                                                  SELF := LEFT;
                                                  SELF := [];));
                                                  
    ultParentLookup := PROJECT(dedupFilter, TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2, 
                                                      SELF.seleid := LEFT.ultimate_proxid, // USING ---> ultimate parent proxid
                                                      SELF := LEFT;
                                                      SELF := [];));
                                                      
    dedupUltParentLookup := DEDUP(ultParentLookup, uniqueid, ultid, orgid, seleid, HASH, ALL);

						
		parentInfoRaw := BIPV2_Best.Key_LinkIds.kFetch2(inputs := parentLookup, 
                                                     Level := Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel), 
                                                     ScoreThreshold := 0, // ScoreThreshold --> 0 = Give me everything
                                                     in_mod := linkingOptions,
                                                     IncludeStatus := TRUE,
                                                     JoinLimit := Business_Risk_BIP.Constants.Limit_Default,
                                                     JoinType := Business_Risk_BIP.Constants.DefaultJoinType)(proxid = 0);

		ultParentInfoRaw := BIPV2_Best.Key_LinkIds.kFetch2(inputs := dedupUltParentLookup, 
                                                       Level  := Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel), 
                                                       ScoreThreshold := 0, // ScoreThreshold --> 0 = Give me everything
                                                       in_mod := linkingOptions,
                                                       IncludeStatus := TRUE,
                                                       JoinLimit := Business_Risk_BIP.Constants.Limit_Default,
                                                       JoinType := Business_Risk_BIP.Constants.DefaultJoinType)(proxid = 0);

    // Do a right-only join to see if there are any ultimate-parent records that will
    // fill in a missing parent record.
		neededUltParentRecords := JOIN(parentInfoRaw, ultParentInfoRaw,
                                    LEFT.uniqueid = RIGHT.uniqueid,
                                    TRANSFORM(RIGHT),
                                    RIGHT ONLY,
                                    INNER);
                                    
    sortParentRecords := SORT((parentInfoRaw + neededUltParentRecords), uniqueid);                                
				
		parentInfo := PROJECT(sortParentRecords, TRANSFORM({DueDiligence.LayoutsInternal.InternalBIPIDsLayout, STRING parentCompanyName},
                                                        SELF.seq           := LEFT.uniqueid,
                                                        SELF.parentCompanyName := LEFT.company_name[1].company_name;
                                                        SELF := LEFT;
                                                        SELF := [];));
            
            
    addParentCompany := JOIN(addDBAs, parentInfo,
                              LEFT.seq = RIGHT.seq,
                              TRANSFORM(RECORDOF(LEFT),
                                         SELF.parentCompanyName := RIGHT.parentCompanyName;
                                         SELF := LEFT;),
                              LEFT OUTER);
            
        
            
   
  // OUTPUT(sortUniqueDBA, NAMED('sortUniqueDBA'));	
	// OUTPUT(dedupUniqueDBA, NAMED('dedupUniqueDBA'));	
	// OUTPUT(maxUniqueDBA, NAMED('maxUniqueDBA'));	
	// OUTPUT(rollUniqueDBAs, NAMED('rollUniqueDBAs'));	
	// OUTPUT(addDBAs, NAMED('addDBAs'));
  
	// OUTPUT(filterAboveSele, NAMED('filterAboveSele'));
	// OUTPUT(dedupFilter, NAMED('dedupFilter'));
	// OUTPUT(parentLookup, NAMED('parentLookup'));
	// OUTPUT(ultParentLookup, NAMED('ultParentLookup'));
	// OUTPUT(dedupUltParentLookup, NAMED('dedupUltParentLookup'));
	// OUTPUT(parentInfoRaw, NAMED('parentInfoRaw'));
	// OUTPUT(ultParentInfoRaw, NAMED('ultParentInfoRaw'));
	// OUTPUT(neededUltParentRecords, NAMED('neededUltParentRecords'));
	// OUTPUT(parentInfo, NAMED('parentInfo'));
	// OUTPUT(addParentCompany, NAMED('addParentCompany'));
  
  
  
  
  RETURN addParentCompany;
ENDMACRO;                          