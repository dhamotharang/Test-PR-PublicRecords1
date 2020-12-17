IMPORT doxie_crs, UCCv2_services;
EXPORT layout_legacy := MODULE
  
  EXPORT level_rec := { UNSIGNED1 level; UCCv2_services.layout_tmsid };
  EXPORT ucc_rec := doxie_crs.layout_UCC_Records;
  EXPORT collateral_rec := { STRING60 collateral_type_desc := '' }; // UCCD.Layout_Collateral_ChildDS
  EXPORT raw_rec := RECORD
    // ---- These were from UCCD.Key_BDID ----
    UNSIGNED INTEGER6 bdid;
    STRING50 ucc_key;
    UNSIGNED INTEGER6 did;
    STRING20 debtor_event_key;
    STRING20 debtor_fname;
    STRING20 debtor_mname;
    STRING20 debtor_lname;
    STRING5 debtor_name_suffix;
    STRING60 debtor_status_desc;
    STRING60 debtor_name;
    STRING10 debtor_prim_range;
    STRING2 debtor_predir;
    STRING28 debtor_prim_name;
    STRING4 debtor_addr_suffix;
    STRING2 debtor_postdir;
    STRING10 debtor_unit_desig;
    STRING8 debtor_sec_range;
    STRING25 debtor_city_name;
    STRING18 debtor_county_name;
    STRING2 debtor_st;
    STRING5 debtor_zip;
    STRING4 debtor_zip4;
    STRING20 secured_event_key;
    STRING60 secured_status_desc;
    STRING60 secured_name;
    STRING10 secured_prim_range;
    STRING2 secured_predir;
    STRING28 secured_prim_name;
    STRING4 secured_addr_suffix;
    STRING2 secured_postdir;
    STRING10 secured_unit_desig;
    STRING8 secured_sec_range;
    STRING25 secured_city_name;
    STRING18 secured_county_name;
    STRING2 secured_st;
    STRING5 secured_zip;
    STRING4 secured_zip4;
    DATASET(collateral_rec) collateral_children {MAXCOUNT ($.Constants.MAX_LEGACY_COLLATERAL_RECS)};
    STRING2 filing_state;
    STRING4 filing_count;
    STRING4 document_count;
    STRING3 debtor_count;
    STRING3 secured_count;
    STRING8 ucc_exp_date;
    STRING60 ucc_filing_type_desc;
    STRING20 event_key;
    STRING8 orig_filing_date;
    STRING32 orig_filing_num;
    STRING8 filing_date;
    STRING32 event_document_num;
    STRING60 filing_type_desc;
  END;
  EXPORT raw_level_rec := RECORD
    UNSIGNED1 level;
    raw_rec;
  END;
  EXPORT super_rec := RECORD
    ucc_rec.penalt;
    raw_level_rec;
  END;

END;
