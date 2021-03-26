IMPORT $, doxie, dx_Email, DidVille, Royalty, iesp;
EXPORT Layouts := MODULE

  EXPORT batch_email_input := RECORD
    STRING email;
    doxie.layout_inBatchMaster - [dl,dlstate,vin,Plate,PlateState,MatchCode,searchType,score,max_results];
  END;

  EXPORT batch_in_rec := RECORD
    STRING20    acctno := '';
    UNSIGNED    seq := 0; //to be used for internal search on multiple inputs for same acctno
    UNSIGNED    DID := 0;
    UNSIGNED    subject_lexid := 0;  // for Lexid resolved from input PII or DID provided from input

    STRING20    name_first := '';
    STRING20    name_middle := '';
    STRING20    name_last := '';
    STRING5     name_suffix := '';
    STRING12    ssn := '';
    STRING8     dob := '';
    STRING10    phone10 := '';
    STRING      email := '';
    STRING      email_username := '';  // user name from cleaned email
    STRING      email_domain := '';    // domain from cleaned email

    STRING10    prim_range := '';
    STRING2     predir := '';
    STRING28    prim_name := '';
    STRING4     addr_suffix := '';
    STRING2     postdir := '';
    STRING10    unit_desig := '';
    STRING8     sec_range := '';
    STRING25    p_city_name := '';
    STRING2     st := '';
    STRING5     z5 := '';
    STRING4     zip4 := '';
    BOOLEAN     isdeepdive := FALSE;
    BOOLEAN     has_full_address := FALSE;
    BOOLEAN     has_full_name := FALSE;
    BOOLEAN     has_full_ssn := FALSE;
  END;

  EXPORT batch_in_ext_rec := RECORD(batch_in_rec)
    UNSIGNED2  record_err_code := 0;
    STRING     record_err_msg  := '';
    BOOLEAN    is_rejected_rec := FALSE;
  END;

  EXPORT batch_in_didvile_rec := RECORD(DidVille.Layout_did_inbatch)
    UNSIGNED    DID := 0;
  END;

 EXPORT email_ids_rec := RECORD
    STRING20  acctno := '';
    UNSIGNED  seq := 0;
    UNSIGNED  email_rec_key := 0;
    BOOLEAN   isdeepdive := FALSE;
    UNSIGNED  subject_lexid := 0;  // keeping Lexid resolved from input PII or DID provided from input
  END;

  EXPORT orig_email_rec := RECORD
    STRING first_name;
    STRING last_name;
    STRING middle_name;
    STRING name_suffix;
    STRING address;
    STRING city;
    STRING state;
    STRING zip;
    STRING zip4;
    STRING email;
    STRING ip;
    STRING login_date;
    STRING site;
    STRING phone;
    STRING ssn;
    STRING dob;
  END;

  EXPORT clean_email_rec := RECORD
    STRING200 clean_email;
    dx_Email.Layouts.Layout_Clean_Name Name;
    dx_Email.Layouts.Layout_Clean182 Address;
    STRING10  clean_phone;
    STRING9   clean_ssn;
    UNSIGNED4 clean_dob;
  END;

  EXPORT email_raw_rec := RECORD
    STRING20  acctno := '';
    UNSIGNED  seq := 0; //need for internal use for multiple recs for same acctno
    UNSIGNED  email_id := 0;  // email rec key
    STRING2   email_src;
    STRING100 email_username;
    STRING120 email_domain;
    UNSIGNED6 did;
    UNSIGNED8 did_score := 0;
    STRING8   date_first_seen;
    STRING8   date_last_seen;
    UNSIGNED4 ln_date_first := 0;    // LN calculated date based on vendor's date_first_seen
    UNSIGNED4 ln_date_last := 0;    // LN calculated date based on vendor's date_last_seen
    STRING8   date_vendor_first_reported;
    STRING8   date_vendor_last_reported;
    STRING8   process_date;
    STRING1   activecode;
    BOOLEAN   is_current;
    UNSIGNED  rules;
    orig_email_rec original;
    clean_email_rec cleaned;
    BOOLEAN   isdeepdive := FALSE;
    UNSIGNED  subject_lexid := 0;  // keeping Lexid resolved from input PII or DID provided from input
    STRING    orig_CompanyName;
    STRING    cln_CompanyName;
    STRING    CompanyTitle;
    UNSIGNED6 DotID;
    UNSIGNED6 EmpID;
    UNSIGNED6 POWID;
    UNSIGNED6 ProxID;
    UNSIGNED6 SELEID;
    UNSIGNED6 OrgID;
    UNSIGNED6 UltID;
    UNSIGNED4 global_sid := 0;  //  GlobalSourceId
    UNSIGNED8 record_sid := 0;  //  SourceSpecificRecordId
   // UNSIGNED8 gdp_rules_mask := 0;  //  global data protection mask - to indicate which rules apply
  END;

  EXPORT email_internal_rec := RECORD
    email_raw_rec -[is_Current,activecode, rules, global_sid, record_sid];
    UNSIGNED email_quality_mask := 0;
    UNSIGNED penalt := 0;
    UNSIGNED penalt_addr := 0;
    UNSIGNED penalt_name := 0;
    UNSIGNED penalt_didssndob := 0;
    BOOLEAN  isRoyaltySource := FALSE;
    UNSIGNED num_sources := 0;
    STRING8  latest_orig_login_date := '';
    UNSIGNED num_email_per_did := 0;
    UNSIGNED num_did_per_email := 0;
  END;

  EXPORT best_rec := RECORD
    QSTRING5 title := '';
    QSTRING20 fname := '';
    QSTRING20 mname := '';
    QSTRING20 lname := '';
    QSTRING5 name_suffix := '';
    QSTRING10 prim_range := '';
    STRING2 predir := '';
    QSTRING28 prim_name := '';
    QSTRING4 suffix := '';
    STRING2 postdir := '';
    QSTRING10 unit_desig := '';
    QSTRING8 sec_range := '';
    QSTRING25 city_name := '';
    STRING2 st := '';
    QSTRING5 zip := '';
    QSTRING4 zip4 := '';
    QSTRING10 phone := '';
    QSTRING9 ssn := '';
    INTEGER4 dob := 0;
  END;

  EXPORT tmx_insights_rec := RECORD
    STRING  account_email_first_seen := '';
    STRING  account_email_last_event := '';
    STRING  account_email_last_update := '';
    STRING  account_email_result := '';
    INTEGER account_email_score := 0;
    INTEGER account_email_worst_score := 0;

    STRING  digital_id := '';
    INTEGER digital_id_confidence := 0;
    STRING  digital_id_first_seen := '';
    STRING  digital_id_last_event := '';
    STRING  digital_id_last_update := '';
    STRING  digital_id_result := '';

    STRING policy_score := '';
    STRING request_result := '';
    STRING review_status := '';
    STRING risk_rating := '';
  END;

  EXPORT email_final_rec := RECORD(email_internal_rec)
    best_rec bestinfo;
    tmx_insights_rec TMX_insights;
    STRING15   email_status := '';
    STRING50   email_status_reason := '';
    STRING70   additional_status_info := '';
    STRING20   ea_email_exist := '';
    STRING20   ea_email_status := '';
    STRING8    date_last_verified := '';
    STRING50   relationship  := '';
    STRING50   record_err_msg  := '';
    UNSIGNED2 record_err_code := 0;
    BOOLEAN  is_rejected_rec := FALSE;
  END;

  EXPORT email_combined_rec := RECORD
    DATASET(email_final_rec) Records;
    DATASET(Royalty.Layouts.RoyaltyForBatch) Royalties;
  END;

  EXPORT email_royalty_combined_rec := RECORD
    DATASET(email_final_rec) Records;
    DATASET(Royalty.Layouts.Royalty) Royalties;
  END;

  EXPORT event_history_rec := RECORD
    STRING200 email := '';
    STRING10  email_status := '';
    STRING100 email_status_reason := '';
    STRING40  error_code := '';
    BOOLEAN   is_disposable_address := FALSE;
    BOOLEAN   is_role_address := FALSE;
    STRING100 email_username := '';
    STRING100 email_domain := '';
    STRING8   date_added;
  END;

  EXPORT domain_rec := RECORD
    STRING100  email_domain;
    STRING8    expire_date;
    STRING8    date_last_verified;
    STRING50   domain_status;
    BOOLEAN    accept_all;
    STRING     source;
  END;

  EXPORT batch_final_rec := RECORD
    STRING20  acctno := '';
    //riginal fields:
    STRING orig_first_name;
    STRING orig_last_name;
    STRING orig_address;
    STRING orig_city;
    STRING orig_state;
    STRING orig_zip;
    STRING orig_zip4;
    STRING orig_email;
    STRING orig_ip;
    STRING orig_login_date;
    STRING orig_site;
    STRING company_title;
    STRING orig_company_name;
    // cleaned fields:
    STRING cln_company_name;
    STRING5  title;
    STRING20 fname;
    STRING20 mname;
    STRING20 lname;
    STRING5  name_suffix;
    STRING10 prim_range;
    STRING2  predir;
    STRING28 prim_name;
    STRING4  addr_suffix;
    STRING2  postdir;
    STRING10 unit_desig;
    STRING8  sec_range;
    STRING25 p_city_name;
    STRING25 v_city_name;
    STRING2  st;
    STRING5  zip;
    STRING4  zip4;
    STRING200 clean_email;
    //best fields:
    QSTRING5  best_title := '';
    QSTRING20 best_fname := '';
    QSTRING20 best_mname := '';
    QSTRING20 best_lname := '';
    QSTRING5  best_name_suffix := '';
    QSTRING10 best_prim_range := '';
    STRING2   best_predir := '';
    QSTRING28 best_prim_name := '';
    QSTRING4  best_addr_suffix := '';
    STRING2   best_postdir := '';
    QSTRING10 best_unit_desig := '';
    QSTRING8  best_sec_range := '';
    QSTRING25 best_city_name := '';
    STRING2   best_st := '';
    QSTRING5  best_zip := '';
    QSTRING4  best_zip4 := '';
    QSTRING9  best_ssn := '';
    INTEGER4  best_dob := 0;
    // other fields:
    STRING8   process_date;
    STRING8   date_first_seen;
    STRING8   date_last_seen;
    STRING8   date_vendor_first_reported;
    STRING8   date_vendor_last_reported;
    UNSIGNED6 DID;
    UNSIGNED6 DotID;
    UNSIGNED6 EmpID;
    UNSIGNED6 POWID;
    UNSIGNED6 ProxID;
    UNSIGNED6 SELEID;
    UNSIGNED6 OrgID;
    UNSIGNED6 UltID;
    UNSIGNED2 num_email_per_did := 0;
    UNSIGNED2 num_did_per_email := 0;
    STRING15  email_status := '';
    STRING50  email_status_reason := '';
    STRING70  additional_status_info := '';
    STRING20  ea_email_exist := '';
    STRING20  ea_email_status := '';
    STRING50  relationship  := '';
    STRING    src;
    STRING50  record_err_msg  := '';
    UNSIGNED2 record_err_code := 0;
    STRING8   ln_date_first := '';    // LN calculated date based on vendor's date_first_seen
    STRING8   ln_date_last := '';    // LN calculated date based on vendor's date_last_seen
  END;

  EXPORT batch_combined_rec := RECORD
    DATASET(batch_final_rec) Records;
    DATASET(Royalty.Layouts.RoyaltyForBatch) Royalties;
  END;

  crs_raw_cleaned := RECORD(iesp.emailsearchv2.t_EmailSearchV2CleanData)
    STRING10  Phone;
    STRING9   ssn;
    UNSIGNED4 dob;
  END;
  EXPORT crs_email_raw_rec := RECORD                         // to be used with source_counts reporting
    crs_raw_cleaned Cleaned;
    iesp.emailsearchv2.t_EmailSearchV2OriginalData - [FirstName,LastName,StreetAddress,City,State,Zip,Zip4] Original;
    unsigned8 LexId {xpath('LexId')};
    STRING8 DateFirstSeen {xpath('DateFirstSeen')};
    STRING8 DateLastSeen {xpath('DateLastSeen')};
    STRING8 DateVendorFirstReported {xpath('DateVendorFirstReported')};
    STRING8 DateVendorLastReported {xpath('DateVendorLastReported')};
    STRING8 ProcessDate {xpath('ProcessDate')};
    STRING2 Source {xpath('Source')};
    UNSIGNED EmailId {xpath('EmailId')};
  END;

  EXPORT crs_email_rec := RECORD(iesp.bpsreport.t_BpsReportEmailSearchRecord)
  END;

  EXPORT crs_email_combined_rec := RECORD
    DATASET(crs_email_rec) EmailV2Records  {xpath('Emails/Email'), MAXCOUNT(iesp.Constants.Email.MAX_RECS)};
    DATASET(Royalty.Layouts.Royalty) EmailV2Royalties;
  END;

  EXPORT Gateway_Data := MODULE
    EXPORT batch_in_gw_rec := RECORD
      STRING   email := '';
      INTEGER  rec_no := 0;
      INTEGER  group_no := 0;
    END;

    EXPORT bv_history_rec := RECORD
      STRING   email := '';
      STRING   email_status := '';
      STRING   email_status_reason := '';
      STRING   additional_status_info := '';
      STRING   email_username := '';
      STRING   email_domain := '';
    END;

    EXPORT bv_history_deltabase_rec := RECORD
      STRING   date_added := '';
      STRING   email_address := '';
      STRING   source := '';
      STRING   status := '';
      STRING   disposable := '';
      STRING   role_address := '';
      STRING   error_code := '';
      STRING   error := '';
      STRING   account := '';  // email user name
      STRING   domain := '';
    END;

     EXPORT bv_history_response_rec := RECORD
       DATASET (bv_history_deltabase_rec) Records  {XPATH('Records/Rec'), MAXCOUNT($.Constants.GatewayValues.SQLSelectLimit)};
       STRING  RecsReturned {XPATH('RecsReturned')};
       STRING  Latency {XPATH('Latency')};
       STRING  ExceptionMessage {XPATH('Exceptions/Exception/Message')};
    END;

    EXPORT ea_result_rec := RECORD
      STRING email := '';
      STRING email_domain := '';
      STRING email_username := '';
      STRING email_status := '';
      STRING email_exists := '';
    END;

  END;

END;
