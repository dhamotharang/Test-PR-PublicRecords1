IMPORT $, doxie, dx_Email, DidVille, Royalty;
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
  
  EXPORT email_final_rec := RECORD(email_internal_rec)
    best_rec bestinfo;
    STRING   email_status := '';
    STRING   email_status_reason := '';
    STRING   additional_status_info := '';
    STRING   relationship  := '';
    STRING   record_err_msg  := '';
    UNSIGNED2 record_err_code := 0;
    BOOLEAN  is_rejected_rec := FALSE;
  END;

  EXPORT email_combined_rec := RECORD
    DATASET(email_final_rec) Records;
    DATASET(Royalty.Layouts.RoyaltyForBatch) Royalties;
  END;
  
  EXPORT GatewayData := MODULE
    EXPORT batch_in_bv_rec := RECORD
      STRING      email := '';
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
  END;

END;