import marriage_divorce_v2, marriage_divorce_v2_Services, doxie, fcra, ut, suppress;

boolean IsFCRA := true;
MAX_OVERRIDE_LIMIT := FCRA.compliance.MAX_OVERRIDE_LIMIT;
nss_const := Suppress.Constants.NonSubjectSuppression;

// NOTE: function is not "batch-safe": if multiple DIDs ever going to be passed as an input,
// then correction records from the FlagFile should be checked for each DID individually.
// Right now there's no need to account for that.

EXPORT _MarriageDivorce_data (dataset (doxie.layout_references) dids, 
                              dataset (fcra.Layout_override_flag) flag_file,
                              integer nss = nss_const.doNothing
                              ) := MODULE

  shared ids := marriage_divorce_v2_Services.MDRaw.get_id_from_did (dids, isFCRA);

  // same approach as in marriage_divorce_v2_Services/fn_getMD_report minus any business logic

  main_ffids := SET (flag_file (file_id = FCRA.FILE_ID.MARRIAGE), flag_file_id);
  main_rids  := SET (flag_file (file_id = FCRA.FILE_ID.MARRIAGE), record_id);

  // MAIN data
  
  key_main := marriage_divorce_v2.key_mar_div_id_main (isFCRA);
  rec_main := recordof (key_main);
  
  main_raw := join (ids, key_main,
    keyed (left.record_id = right.record_id)
    and (~ut.IndustryClass.is_knowx or right.state_origin<>'OK')
    and ((string)right.persistent_record_id not in main_rids),
    transform (rec_main, Self := Right), //marriage_divorce_v2.layout_mar_div_base_slim;
    keep (1), limit(0)
  );

  // overrides
  main_over := choosen (FCRA.key_override_marriage.marriage_main (keyed (flag_file_id in main_ffids)), MAX_OVERRIDE_LIMIT);
  main_corrected := main_raw + project (main_over, transform (rec_main, Self := Left));
  
  export main := main_corrected; // TODO: sorting, etc.


  // PARTY information

  search_ffids := SET (flag_file (file_id = FCRA.FILE_ID.MARRIAGE_SEARCH), flag_file_id);
  search_rids  := SET (flag_file (file_id = FCRA.FILE_ID.MARRIAGE_SEARCH), record_id);

  key_search := marriage_divorce_v2.key_mar_div_id_search (isFCRA);
  rec_search := recordof (key_search);

  // Transform is capable of applying non-subject suppression
  rec_search GetParties (ids L, key_search R) := function
    boolean IsSubject := (L.search_did = (unsigned6) R.did);
    
    rec_search mTransf := transform, SKIP ( (nss = nss_const.returnBlank) and ~IsSubject)
        boolean do_blank_nss := ~IsSubject and (nss = nss_const.returnRestrictedDescription);
      
      Self.record_id := L.record_id;
      Self.persistent_record_id   := R.persistent_record_id;
      
      Self.lname := if (do_blank_nss, FCRA.Constants.FCRA_Restricted, R.lname);    
      Self := if (~do_blank_nss, R);
    end; 
    return mTransf;
  end;
  
  party_raw := join (ids, key_search,
                     keyed(left.record_id = right.record_id)
                     and ((string)right.persistent_record_id not in search_rids),
                     GetParties (Left, Right),
                     limit(ut.limits.MARRIAGEDIVORCE_PARTY_PER_RECORD));
  
  party_over := choosen (FCRA.key_override_marriage.marriage_search (keyed (flag_file_id in search_ffids)), MAX_OVERRIDE_LIMIT);
  
  party_corr := party_raw + project (party_over, rec_search);
  
   
  export party := party_corr;  // TODO: sorting, etc.
END;   
