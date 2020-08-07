IMPORT patriot,GlobalWatchLists,doxie,business_header,STD;

doxie_cbrs.mac_Selection_Declare()

gwl_key := GlobalWatchLists.Key_GlobalWatchLists_Key;

EXPORT Patriot_records(UNSIGNED1 ofac_version = 1, BOOLEAN include_ofac = FALSE, REAL global_watchlist_threshold = 0.8) :=
FUNCTION
  doxie_cbrs.layout_references proj(bdid_dataset l):= TRANSFORM
    SELF.bdid :=l.bdid;
  END;

  bdids :=PROJECT(bdid_dataset(Include_PatriotAct_val),proj(LEFT));
  all_company_names_recs := doxie_Cbrs.best_records;

  //***** Add a cleaned name for deduping, to avoid sending extra rows...still send unparsed field
  rec_pp := RECORD
    patriot.Layout_batch_in;
    STRING120 clean_name;
  END;

  rec_pp convert_company(all_company_names_recs le):=TRANSFORM
    ccf := Business_Header.CompanyCleanFields(le.company_name, TRUE);
    cn := TRIM(ccf.indicative) + ' ' + TRIM(ccf.secondary) + ' ' + TRIM(ccf.furniture);
    SELF.clean_name := STD.STR.ToUpperCase(cn);
    SELF.name_unparsed := STD.STR.ToUpperCase(le.company_name);
    SELF.search_type :='NON-INDIVIDUAL';
    SELF :=[];
  END;

  almost_ready_for_patriot := DEDUP(SORT(
    PROJECT(all_company_names_recs(company_name <>''), convert_company(LEFT)), 
    clean_name), clean_name);
  ready_for_patriot := PROJECT(almost_ready_for_patriot, patriot.Layout_batch_in);

  results_of_batch :=Patriot.Search_Batch_Function(GROUP(ready_for_patriot,acctno), FALSE, global_watchlist_threshold, ofac_version, include_ofac);

  ds_Patriot_records := JOIN(results_of_batch, gwl_key,
    KEYED(LEFT.pty_key=RIGHT.pty_key) AND
    LEFT.remarks_1=RIGHT.remarks_1 AND LEFT.remarks_2=RIGHT.remarks_2
    AND LEFT.remarks_3=RIGHT.remarks_3 AND LEFT.addr_1=RIGHT.addr_1 AND LEFT.addr_2=RIGHT.addr_2
    AND LEFT.addr_3=RIGHT.addr_3 AND LEFT.orig_pty_name=RIGHT.orig_pty_name AND LEFT.source=RIGHT.source,
    KEEP(50), LIMIT(1000,FAIL(203,doxie.ErrorCodes(203))), 
    LEFT OUTER);

  RETURN ds_Patriot_records;
END;
