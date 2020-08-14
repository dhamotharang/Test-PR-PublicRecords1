import doxie, business_risk, Business_Header, AutoStandardI;

export getBizReportBDIDs(doxie.IDataAccess mod_access):= MODULE

	EXPORT biid := Business_Risk.business_instantid_records;
	
	//Get BDID from Business InstantID
	shared businessInstantID_bdid := biid[1].bdid;
	
	//GET GROUPID from BDID
	shared groupID_BInstantID := LIMIT (Business_Header.Key_BH_SuperGroup_BDID(KEYED (bdid=businessInstantID_bdid)), 1, SKIP);
	
	//GET BDID SET, BDID OR GROUPID FROM BUSINESS HEADER ROLLUP SERVICE
	shared best_recs := business_header.fn_RSS_getBestRecords(mod_access,true,false,false,false,true,false,false); 

	//minimum field population filter
	shared best_recs_filt := best_recs(company_name != '' and 
					 (prim_range != '' or predir != '' or prim_name != '' or addr_suffix != '' or
	    				postdir != '' or unit_desig != '' or sec_range != '' or city != '' or
		           		state != '' or zip != 0 or zip4 != 0));

	shared brByGIDs_0 := Business_Header.fn_RSS_rollupBestRecords(best_recs_filt, mod_access, 10);
	
	shared brByGIDs := SORT(Business_Header.fn_RSS_attachParentInfo(brByGIDs_0,true,true), -score);

	//Check to see if the roll-up returned too many records and fail search if it does.
	shared unsigned hi_score:=brByGIDs[1].score;
	shared ds_verify:=project(brByGIDs(score=hi_score),transform(recordof(brByGIDs),self:=left));
	if(count(ds_verify)>1,
		fail (203, doxie.ErrorCodes (203)));
		
	// JOIN GROUPIDS FROM BIID AGAINST BHRS TO GET SET OF BDIDS OR GROUPID
	// Here BDID set ({}) or Â“Group IDÂ”
	EXPORT runReport_ID := join(groupID_BInstantID,ds_verify,
									 left.group_id = right.group_id,
									 full outer);
	
	// bdids_mod := module(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.bdid_dataset.params,opt))
		// export bdid := if(length(runReport_ID[1].bdid_list)>0,runReport_ID[1].bdid_list,(string) runReport_ID[1].group_id);
	// end;
	string InputBdid := '' : stored('BDID');
      
      bdids_mod := module(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.bdid_dataset.params,opt))
            export bdid := map(
                  InputBdid != '' => InputBdid,
                  length(runReport_ID[1].bdid_list) > 0 => runReport_ID[1].bdid_list,
                  (string)runReport_ID[1].group_id);
      end;
	
	EXPORT bdids := AutoStandardI.InterfaceTranslator.bdid_dataset.val(bdids_mod);
		
END;
