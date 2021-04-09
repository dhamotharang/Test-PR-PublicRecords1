IMPORT AutoStandardI, doxie, FCRA;

EXPORT ReportService_ids := MODULE

  EXPORT val(CriminalRecords_Services.IParam.report in_mod,
             BOOLEAN IsFCRA = FALSE,
             DATASET (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile) := FUNCTION
  
    // lookup by offender key
    offender_key_ids := DATASET([{in_mod.offender_key,FALSE}],layouts.l_search);
    offender_key:=IF(in_mod.IncludeAllCriminalRecords,
      CriminalRecords_Services.Raw.getOffenderKeys.byoffenderID(offender_key_ids),
      offender_key_ids);
            
    // lookup by docnum
    docnum := DATASET([{in_mod.doc_number}],layouts.docnum_rec);
    by_docnum := CriminalRecords_Services.Raw.getOffenderKeys.byDocNums(docnum);
    
    // lookup by DID
    dids := DATASET([{(UNSIGNED)in_mod.DID}],doxie.layout_references);
    by_did := IF((UNSIGNED)in_mod.DID > 0,CriminalRecords_Services.Raw.getOffenderKeys.byDIDs(dids, IsFCRA, flagfile));
    
    // decide which key to use
    ids := MAP(in_mod.offender_key <> '' => offender_key,
               in_mod.doc_number <> '' => by_docnum,
               in_mod.DID <> '' => by_did,
               DATASET([], layouts.l_search));
    ids_d := DEDUP(SORT(ids, offender_key, isDeepDive), offender_key);
    
    final_ids := IF(isFCRA, by_did, ids_d); // the only way to get data on FCRA-side is by DID
    
    RETURN final_ids;
  
  END;

END;
