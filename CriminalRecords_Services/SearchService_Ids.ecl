IMPORT AutoStandardI, doxie, FCRA;

EXPORT SearchService_ids := MODULE

  EXPORT val(CriminalRecords_Services.IParam.search in_mod,
             BOOLEAN isFCRA = FALSE,
             DATASET (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile) := FUNCTION
    
    ak_mod := MODULE(PROJECT(in_mod,CriminalRecords_Services.IParam.ak_params,OPT)) END;
    by_auto := CriminalRecords_Services.AutoKey_IDs.val(ak_mod);
    
    //lookup by deep dids
    deep_dids := LIMIT(doxie.Get_Dids(,TRUE),in_mod.MAX_DEEP_DIDS,SKIP);
    by_deep_dids := IF(
      NOT in_mod.noDeepDive,
      PROJECT(
        CriminalRecords_Services.Raw.getOffenderKeys.byDIDs(deep_dids),
        TRANSFORM(CriminalRecords_Services.layouts.l_search,SELF.isdeepdive:=TRUE,SELF:=LEFT)
      )
    );
    
    // lookup by offender key
    offender_key := DATASET([{in_mod.offender_key,FALSE}],CriminalRecords_Services.layouts.l_search);
    
    // lookup by docnum
    docnum := DATASET([{in_mod.doc_number}],CriminalRecords_Services.layouts.docnum_rec);
    by_docnum := CriminalRecords_Services.Raw.getOffenderKeys.byDocNums(docnum);
    
    // lookup by DID
    dids := DATASET([{(UNSIGNED)in_mod.DID}],doxie.layout_references);
    by_did := IF((UNSIGNED)in_mod.DID > 0, CriminalRecords_Services.Raw.getOffenderKeys.byDIDs(dids, isFCRA, flagfile));
    
    // lookup by CaseNumber
    casenum := DATASET([{in_mod.case_number}], CriminalRecords_Services.layouts.casenum_rec);
    by_casenum := CriminalRecords_Services.Raw.getOffenderKeys.byCaseNum(casenum);
    
    // decide which type of lookup to use
    ids := MAP(in_mod.offender_key <> '' => offender_key,
               in_mod.doc_number <> '' => by_docnum,
               in_mod.DID <> '' => by_did,
               in_mod.case_number <> '' => by_casenum,
               by_auto + by_deep_dids);
    ids_d := DEDUP(SORT(ids, offender_key, isDeepDive), offender_key);
    
    final_ids := IF(isFCRA, by_did, ids_d);

    RETURN final_ids;
    
  END;

END;
