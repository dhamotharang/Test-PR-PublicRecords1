IMPORT doxie, business_risk, Business_Header, AutoStandardI;

EXPORT getBizReportBDIDs(doxie.IDataAccess mod_access):= MODULE

  EXPORT biid := Business_Risk.business_instantid_records;
  
  //Get BDID from Business InstantID
  SHARED businessInstantID_bdid := biid[1].bdid;
  
  //GET GROUPID from BDID
  SHARED groupID_BInstantID := LIMIT (Business_Header.Key_BH_SuperGroup_BDID(KEYED (bdid=businessInstantID_bdid)), 1, SKIP);
  
  //GET BDID SET, BDID OR GROUPID FROM BUSINESS HEADER ROLLUP SERVICE
  SHARED best_recs := business_header.fn_RSS_getBestRecords(mod_access,TRUE,FALSE,FALSE,FALSE,TRUE,FALSE,FALSE);

  //minimum field population filter
  SHARED best_recs_filt := best_recs(company_name != '' AND
           (prim_range != '' OR predir != '' OR prim_name != '' OR addr_suffix != '' OR
              postdir != '' OR unit_desig != '' OR sec_range != '' OR city != '' OR
                   state != '' OR zip != 0 OR zip4 != 0));

  SHARED brByGIDs_0 := Business_Header.fn_RSS_rollupBestRecords(best_recs_filt, mod_access, 10);
  
  SHARED brByGIDs := SORT(Business_Header.fn_RSS_attachParentInfo(brByGIDs_0,TRUE,TRUE), -score);

  //Check to see if the roll-up returned too many records and fail search if it does.
  SHARED UNSIGNED hi_score:=brByGIDs[1].score;
  SHARED ds_verify:=PROJECT(brByGIDs(score=hi_score),TRANSFORM(RECORDOF(brByGIDs),SELF:=LEFT));
  IF(COUNT(ds_verify)>1,
    FAIL (203, doxie.ErrorCodes (203)));
    
  // JOIN GROUPIDS FROM BIID AGAINST BHRS TO GET SET OF BDIDS OR GROUPID
  // Here BDID set ({}) or Â“Group IDÂ�?
  EXPORT runReport_ID := JOIN(groupID_BInstantID,ds_verify,
                   LEFT.group_id = RIGHT.group_id,
                   full OUTER);
  
  // bdids_mod := module(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.bdid_dataset.params,opt))
    // export bdid := if(length(runReport_ID[1].bdid_list)>0,runReport_ID[1].bdid_list,(string) runReport_ID[1].group_id);
  // end;
  STRING InputBdid := '' : STORED('BDID');
      
  bdids_mod := MODULE(PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.bdid_dataset.params,OPT))
    EXPORT bdid := MAP(InputBdid != '' => InputBdid,
      LENGTH(runReport_ID[1].bdid_list) > 0 => runReport_ID[1].bdid_list,
      (STRING)runReport_ID[1].group_id);
  END;
  
  EXPORT bdids := AutoStandardI.InterfaceTranslator.bdid_dataset.val(bdids_mod);
    
END;
