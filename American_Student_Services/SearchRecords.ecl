IMPORT doxie, AutoheaderI, American_Student_Services;

EXPORT SearchRecords(American_Student_Services.IParam.searchParams aInputData, unsigned1 ds_exclusion = 0) := FUNCTION
  
  // get asl id's from autokeys for name, address, and ssn etc.Functions.apply_restrictions
  asl_ids_byak := American_Student_Services.AutoKeyIds(aInputData);
  all_ids := dedup(sort(asl_ids_byak,id),id);
  mod_access := project(aInputData,doxie.IDataAccess);
  // get more did's by deep dive
  tempmod := module(project(aInputData,AutoheaderI.LIBIN.FetchI_Hdr_Indv.full,opt))
      export noFail := true;
    end;
  deep_dids := limit( AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(tempmod), 100, skip);
  
  //get payload data by asl id's (key).
  recs_by_ids := American_Student_Services.Raw.getPayloadByIDS(all_ids, mod_access);
  
  //accumulate dids by autokeys, input and autoheaderi lookups.
  in_did := dataset ([(unsigned6) aInputData.didValue],doxie.layout_references);
  ds_dids := project(in_did,transform(American_Student_Services.layouts.deepDids,self:=left));
  ds_deep_dids := project(deep_dids,transform(American_Student_Services.layouts.deepDids,self.isdeepdive := true; self:=left));
  dids_from_recs_by_ids := project(recs_by_ids,transform(American_Student_Services.layouts.deepDids,self:=left));
  all_dids := dedup(sort(ds_dids + if(ds_exclusion <> 3, dids_from_recs_by_ids) + if(aInputData.isDeepDive,ds_deep_dids),did),did);
      
  //get payload data by dids
  recs_by_dids := American_Student_Services.Raw.getPayloadByDIDS(all_dids, mod_access);
  sup_recs_by_dids := American_Student_Services.Raw.getSupplementalStudentInfobyDIDs(all_dids,mod_access);
  
  all_recs := map(ds_exclusion=1 => recs_by_ids + recs_by_dids, // DatasourceExclusion=1, no Alloy, keep ASL
                  ds_exclusion=2 => sup_recs_by_dids, // DatasourceExclusion=2, no ASL, keep Alloy
                  ds_exclusion=3 => recs_by_dids + sup_recs_by_dids, // DatasourceExclusion=3, no Autokeys, Keep only by DIDs.
                  recs_by_ids + recs_by_dids + sup_recs_by_dids); // Both ASL and Alloy included (default)
  
  ds_rollup := American_Student_Services.functions.rollup_recs(all_recs);
  ds_pen_recs := American_Student_Services.Functions.apply_penalty(ds_rollup, aInputData);
  
  ds_filter_by_pen := ds_pen_recs(record_penalty <= aInputData.penalty_threshold or isdeepdive);
  
  commonParam := PROJECT(aInputData, American_Student_Services.IParam.reportParams);
  studentrecs := American_Student_Services.Functions.apply_restrictions(ds_filter_by_pen, commonParam);

  //Add college indicators
 outputRec := American_Student_Services.functions.add_college_indicators(studentrecs, all_dids, mod_access);

/* Debug*/
  // output(ds_sorted,named('ds_sorted'));
  // output(ds_rollup,named('ds_rollup'));

  return outputRec;
END;
