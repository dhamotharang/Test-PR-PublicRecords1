IMPORT iesp, BIPV2, doxie_cbrs, Moxie_phonesplus_Server, Watchdog;

EXPORT Layouts := MODULE
  EXPORT rec_ids_in := RECORD
    STRING30 acctno := '';
    UNSIGNED6 bdid := 0;
    UNSIGNED6 group_id := 0;
    BIPV2.IDlayouts.l_xlink_ids;
  END;
  
  EXPORT rec_ids_did_in := RECORD
    rec_ids_in;
    UNSIGNED6 did := 0;
  END;
  
  EXPORT rec_corp := RECORD
    rec_ids_in;
    STRING60 corp_status_desc;
    STRING8 corp_status_date;
  END;
  
  EXPORT rec_contact := RECORD
    rec_ids_in;
    UNSIGNED6 did := 0; // DID from Headers
    UNSIGNED4 dt_first_seen; // From contact info if available
    UNSIGNED4 dt_last_seen; // From contact infor if available
    STRING2 source; // Source file type
    STRING1 record_type; // 'C' = Current, 'H' = Historical
    STRING1 from_hdr := 'N'; // 'Y' if contact is from address
    QSTRING35 company_title; // Title of Contact at Company if available
    QSTRING35 company_department := '';
    QSTRING5 title;
    QSTRING20 fname;
    QSTRING20 mname;
    QSTRING20 lname;
    QSTRING5 name_suffix;
    STRING1 name_score;
    QSTRING10 prim_range;
    STRING2 predir;
    QSTRING28 prim_name;
    QSTRING4 addr_suffix;
    STRING2 postdir;
    QSTRING5 unit_desig;
    QSTRING8 sec_range;
    QSTRING25 city;
    STRING2 state;
    UNSIGNED3 zip;
    UNSIGNED2 zip4;
    STRING3 county;
    QSTRING10 geo_lat;
    QSTRING11 geo_long;
    UNSIGNED6 phone;
    STRING60 email_address;
    STRING9 ssn := '';
    // QSTRING34 company_source_group := ''; // Source group
    // QSTRING120 company_name;
    // QSTRING10 company_prim_range;
    // STRING2 company_predir;
    // QSTRING28 company_prim_name;
    // QSTRING4 company_addr_suffix;
    // STRING2 company_postdir;
    // QSTRING5 company_unit_desig;
    // QSTRING8 company_sec_range;
    // QSTRING25 company_city;
    // STRING2 company_state;
    // UNSIGNED3 company_zip;
    // UNSIGNED2 company_zip4;
    // UNSIGNED6 company_phone;
    // UNSIGNED4 company_fein := 0;
    UNSIGNED2 title_rank;
    BOOLEAN is_exec;
  END;
  
  EXPORT rec_phones := RECORD
    STRING15 phone := '';
    UNSIGNED6 phone_source_id := 0;
  END;
  
  EXPORT rec_phone_variations := RECORD
    rec_ids_in;
    DATASET(rec_phones) phones {MAXCOUNT(iesp.constants.BR.MaxPhones)};
  END;
  
  EXPORT rec_phone_variations_normalized := RECORD
    rec_ids_in;
    STRING15 phone := '';
    UNSIGNED6 phone_source_id := 0;
  END;
  
  EXPORT rec_company_best := RECORD
    rec_ids_in;
    rec_ids_in AND NOT acctno parent_ids;
    doxie_cbrs.layout_best_info AND NOT bdid;
    STRING60 corp_status_desc := '';
  END;
  
  EXPORT rec_gong_records_acctno := RECORD
    rec_ids_in;
    Watchdog.Layout_Gong_DID AND NOT group_id;
    STRING18 county_name := '';
    STRING4 TimeZone := '';
  END;
  
  EXPORT rec_phonesplus_acctno := RECORD
    rec_ids_in;
    Moxie_phonesplus_Server.Layout_batch_did.w_timezone AND NOT Feedback;
  END;
  
  EXPORT rec_BCCReport_acctno := RECORD
    STRING30 acctno := '';
    iesp.businesscontactcardreport.t_BCCReport;
  END;

  EXPORT rec_BCCSubject_acctno := RECORD
    STRING30 acctno := '';
    iesp.businesscontactcardreport.t_BCCSubject;
  END;

  EXPORT rec_BCCParent_acctno := RECORD
    rec_ids_in;
    iesp.businesscontactcardreport.t_BCCParent;
  END;
  
  EXPORT rec_BCCExecs_acctno := RECORD
    rec_ids_in;
    iesp.businesscontactcardreport.t_BCCExecs;
    UNSIGNED2 title_rank := 0;
  END;

  EXPORT rec_BCCPhoneInfoWithFeedback_acctno := RECORD // i.e. EDA/Gong
    rec_ids_did_in;
    iesp.businesscontactcardreport.t_BCCPhoneInfoWithFeedback;
  END;
  
  EXPORT rec_BCCPhonesPlusRecordWithFeedback_acctno := RECORD
    rec_ids_did_in;
    iesp.businesscontactcardreport.t_BCCPhonesPlusRecordWithFeedback;
  END;

END;
