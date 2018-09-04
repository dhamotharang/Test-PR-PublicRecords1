IMPORT BIPV2,BipV2_Best,BIPV2_Build,ExecAtHomeV2,MDR,paw;  

EXPORT eah_batch_service_records (ExecAtHomeV2.Iparams.BatchParams inMod,
                                  DATASET(execathomev2.Layouts.layoutBatchIn) batchIn) := 
FUNCTION
		
  dsSearchInputFormatted := 
  PROJECT(batchIn,ExecAtHomeV2.Transforms.xfmFormatInput(LEFT));

  // Get the linkids from the search criteria
  dsInSearchIDs := 
  PROJECT(BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(dsSearchInputFormatted).uid_results_w_acct,	
          TRANSFORM(ExecAtHomeV2.Layouts.SearchSlimLayout,
            SELF.UltID  := LEFT.UltID,
            SELF.OrgID  := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_OrgID_And_Down,  LEFT.OrgID, 0),
            SELF.SeleID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_SELEID_And_Down, LEFT.SeleID, 0),
            SELF.ProxID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_ProxID_And_Down, LEFT.ProxID, 0),
            SELF.PowID  := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_PowID_And_Down, LEFT.PowID, 0),
            SELF := LEFT)); 

  // Keep the best BIP rec/company per account number
  dsSearchIDsBestWeight := DEDUP(SORT(dsInSearchIDs,acctno,-weight),acctno);
  
  dsBestMrktLinkIdsLayout := 
  PROJECT(dsSearchIDsBestWeight, 
    TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
              SELF.uniqueId := 0,
              SELF := LEFT));
  marketingInMod := PROJECT(inMod,BIPV2.mod_sources.iParams,OPT);
  
  // Fetch marketing best to get company info
  dsMarketingBest := BipV2_Best.Key_LinkIds.kFetch2Marketing(dsBestMrktLinkIdsLayout,
	                                                           BIPV2.IDconstants.Fetch_Level_SELEID,, 
	                                                           marketingInMod,
                                                             FALSE, // status not needed
                                                            )(proxid=0);  
  dsMrktBest :=
  JOIN(dsSearchIDsBestWeight,dsMarketingBest, 
       BIPV2.IDmacros.mac_JoinTop3Linkids(),
       ExecAtHomeV2.Transforms.xfmAddMktBestFields(LEFT, RIGHT),
       LIMIT(0));

  dsMrktContactsLinkIdsLayout := PROJECT(dsMrktBest,BIPV2.IDlayouts.l_xlink_ids2);
  dsMarketingContactsAll := BIPV2_Build.key_contact_linkids.kFetchMarketing(dsMrktContactsLinkIdsLayout, 
	                                                                          BIPV2.IDconstants.Fetch_Level_SELEID,0, 
                                                	                          marketingInMod);

  // We want to keep the best (executive when applicable) DID record with the latest 
  // last seen date. For the executive_ind_order field, the lower the number, the 
  // higher up in the company the executive is.  
  dsMarketingContactsDedup := 
  DEDUP(SORT(dsMarketingContactsAll((~inMod.execsOnly OR executive_ind) AND contact_did != 0),
             #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),contact_did,-dt_last_seen_contact,-executive_ind,executive_ind_order), 
        #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),contact_did); 

  // keep only max Employees per company for less processing
  dsMarketingContacts := 
  UNGROUP(TOPN(GROUP(dsMarketingContactsDedup,#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids())),
               ExecAtHomeV2.Constants.MAX_EMPLOYEES_PER_COMP,#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),executive_ind_order)); 
  
 dsMrktContacts :=
  JOIN(dsMrktBest,dsMarketingContacts, 
       BIPV2.IDmacros.mac_JoinTop3Linkids(),
       ExecAtHomeV2.Transforms.xfmAddMktContactFields(LEFT, RIGHT),
       LIMIT(0)); 
  
  // get records not in the BipV2_Best.Key_LinkIds.kFetch2Marketing fetch
  dsNoHitMktBest :=
  JOIN(dsSearchIDsBestWeight,dsMarketingContacts, 
       BIPV2.IDmacros.mac_JoinTop3Linkids(), 
       TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
                 SELF := LEFT),
       LEFT ONLY);
  
  dsPawLinkIdsAll := paw.Key_LinkIDs.kFetch(dsNoHitMktBest,
                                            BIPV2.IDconstants.Fetch_Level_SELEID);
  
  dsPawFiltered := dsPawLinkIdsAll(DID != 0 AND
                                   record_type = ExecAtHomeV2.Constants.CURRENT_REC AND
                                   source NOT IN MDR.sourceTools.SET_Marketing_Restricted);

  // saving a join by using dsSearchIDsBestWeight (to pick up acctno) instead of dsPawLinkIdsAll 
  // because the later uses dsNoHitMktBest which will only return the desired result set
  dsPawContactsEAHLayout := 
  JOIN(dsSearchIDsBestWeight,dsPawFiltered, 
       BIPV2.IDmacros.mac_JoinTop3Linkids(),
       ExecAtHomeV2.Transforms.xfmGetPawData(LEFT, RIGHT),
       LIMIT(0));

  dsPawWithDecMkrFlag := 
  JOIN(dsPawContactsEAHLayout,ExecAtHomeV2.ExecutiveTitles,
       LEFT.company_title = RIGHT.companyTitle,
       TRANSFORM(ExecAtHomeV2.Layouts.expandedLayout,
                 isMatch := LEFT.company_title = RIGHT.companyTitle AND LEFT.company_title != '';
                 SELF.executive_flag := IF(isMatch,TRUE,FALSE); 
                 SELF.executive_ind_order := IF(isMatch,RIGHT.executive_ind_order,99); 
                 SELF.business_decision_maker_flag := IF(isMatch,'Y','');
                 SELF.business_owner_flag := IF(LEFT.company_title = ExecAtHomeV2.Constants.OWNER,'Y','');
                 SELF := LEFT),
       KEEP(1),
       LIMIT(0),
       LEFT OUTER);     
       
  dsPawRecsDedup :=
  DEDUP(SORT(dsPawWithDecMkrFlag(~inMod.execsOnly OR executive_flag),
             #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),did,-dt_last_seen,executive_ind_order), 
        #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),did);
  
  dsPawContacts := 
  UNGROUP(TOPN(GROUP(dsPawRecsDedup,#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids())),
               ExecAtHomeV2.Constants.MAX_EMPLOYEES_PER_COMP,#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),executive_ind_order)); 
  
  // Mutually exclusive datasets, so dedup not necessary
  dsContacts := dsMrktContacts + dsPawContacts;
 
  dsWithContactInfo := ExecAtHomeV2.GetContactInfo(dsContacts, 
                                                   inMod.DataRestrictionMask,
                                                   inMod.DataPermissionMask);

  // Previously limited above, there should never be more than 
  // a thousand executives per company
  dsAllRecs := 
  JOIN(batchIn,dsWithContactInfo,
       LEFT.acctno = RIGHT.acctno,
       TRANSFORM(ExecAtHomeV2.Layouts.expandedLayout,
                 SELF.acctno := LEFT.acctno,
                 SELF.customer_id := LEFT.customer_id,
                 SELF := RIGHT),
       LIMIT(ExecAtHomeV2.Constants.MAX_EMPLOYEES_PER_COMP),
       LEFT OUTER); 
  
  dsAllRecsSorted := 
  SORT(dsAllRecs, 
       acctno,customer_id,IF(business_decision_maker_flag = 'Y',0,1),executive_ind_order,did);
  
  dsFinalLayout := 
  PROJECT(dsAllRecsSorted,ExecAtHomeV2.Layouts.layoutEahOutput);

  RETURN dsFinalLayout;
  END;