IMPORT uccd,ut;

EXPORT UCC_records_prs(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

  uccs := doxie_cbrs.UCC_Records(bdids);

  rec := RECORD //from doxie_crs.layout_UCC_Records
    uccs.level;
    STRING50 ucc_key;
    UNSIGNED6 did;
    UNSIGNED6 bdid;

    //from party
    STRING20 debtor_fname;
    STRING20 debtor_mname;
    STRING20 debtor_lname;
    STRING5 debtor_name_suffix;

    STRING60 debtor_name := '';
    
    STRING60 secured_name := '';
    STRING10 secured_prim_range := '';
    STRING2 secured_predir := '';
    STRING28 secured_prim_name := '';
    STRING4 secured_addr_suffix := '';
    STRING2 secured_postdir := '';
    STRING10 secured_unit_desig := '';
    STRING8 secured_sec_range := '';
    STRING25 secured_city_name := '';
    STRING18 secured_county_name := '';
    STRING2 secured_st := '';
    STRING5 secured_zip := '';
    STRING4 secured_zip4 := '';
    
    //from collateral
    DATASET(uccd.Layout_Collateral_ChildDS) collateral_children;
    
    //from summary
    STRING2 filing_state := '';
    STRING4 filing_count := '';
    STRING4 document_count := '';
    STRING3 debtor_count := '';
    STRING3 secured_count := '';
    
    //from event
    STRING8 orig_filing_date := '';
    STRING8 filing_date := '';
    STRING32 event_document_num := '';
    STRING60 filing_type_desc := '';
  END;

  ut.MAC_Slim_Back(uccs, rec, uccslim)

  RETURN uccslim;
END;
