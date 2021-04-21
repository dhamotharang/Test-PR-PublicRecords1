IMPORT DCA, Doxie, LN_PropertyV2_Services, USAbizV2_Services,
       YellowPages, AutoKey_Batch, BankruptcyV3_Services, uccv2_services, Email_Data,
       DriversV2_Services, Corrections, BIPV2;

EXPORT Layouts := MODULE
  Export layout_batch_common_acct := Record
      STRING30     acctno        := '';
  end;
  Export layout_batch_common_acct2 := Record
      STRING30     _acctno        := '';
  end;
  Export layout_batch_common_name := Record
      STRING20     name_first    := '';
      STRING20     name_middle   := '';
      STRING20     name_last     := '';
      STRING5      name_suffix   := '';
  end;
  Export layout_batch_common_name2 := Record
      STRING20    _name_first    := '';
      STRING20    _name_middle   := '';
      STRING20    _name_last     := '';
      STRING5     _name_suffix   := '';
  end;
  Export layout_batch_common_address := Record
      STRING10    prim_range    := '';
      STRING2     predir        := '';
      STRING28    prim_name     := '';
      STRING4     addr_suffix   := '';
      STRING2     postdir       := '';
      STRING10    unit_desig    := '';
      STRING8     sec_range     := '';
      STRING25    p_city_name   := '';
      STRING2     st            := '';
      STRING5     z5            := '';
      STRING4     zip4          := '';
      string18    county_name   := '';
  end;
  Export layout_batch_common_address2 := Record
      STRING10    _prim_range  := '';
      STRING2     _predir      := '';
      STRING28    _prim_name   := '';
      STRING4     _addr_suffix := '';
      STRING2     _postdir     := '';
      STRING10    _unit_desig  := '';
      STRING8     _sec_range   := '';
      STRING25    _p_city_name := '';
      STRING2     _st          := '';
      STRING5     _z5          := '';
      STRING4     _zip4        := '';
      string18     _county_name := '';
  end;

  EXPORT layout_batch_in_for_penalties := RECORD
      layout_batch_common_acct2;

      layout_batch_common_name2;

      layout_batch_common_address2 -_county_name;

      STRING120   _comp_name   := '';
      STRING12    _ssn         := '';
      STRING8     _dob         := '';
      STRING10    _homephone   := '';
      STRING16    _workphone   := '';
  END;

  EXPORT layout_BIPLinkids := RECORD
    UNSIGNED6 UltID := 0;
    UNSIGNED6 OrgID := 0;
    UNSIGNED6 SELEID := 0;
    UNSIGNED6 ProxID := 0;
    UNSIGNED6 POWID := 0;
    UNSIGNED6 EmpID := 0;
    UNSIGNED6 DotID := 0;
  END;


  EXPORT Accurint := MODULE
    EXPORT rec_input_and_penalties := RECORD
      layout_batch_common_acct;
      layout_batch_common_name;
      layout_batch_common_address2 -_county_name;
      LN_PropertyV2_Services.layouts.fid;
      UNSIGNED1 prop_addr_penalty  := 0;
      UNSIGNED1 ownr_name_penalty  := 0;
      UNSIGNED1 sell_name_penalty  := 0;
    END;
  END;


  EXPORT LN_Property := MODULE

    EXPORT rec_acctnos_fids := RECORD
      layout_batch_common_acct;
      UNSIGNED1 search_status      :=  0;
      STRING10  matchCode          := '';
      LN_PropertyV2_Services.layouts.fid; // fid == string12 ln_fares_id
    END;

    EXPORT rec_acctnos_fids_plus_fips := RECORD
      layout_batch_common_acct;
      UNSIGNED1 search_status      :=  0;
      STRING10  matchCode          := '';
      STRING5   fips_code          := '';
      LN_PropertyV2_Services.layouts.fid; // fid == string12 ln_fares_id
    END;

    EXPORT rec_acctnos_fids_plus_linkids := RECORD
      layout_batch_common_acct;
      LN_PropertyV2_Services.layouts.fid; // fid == string12 ln_fares_id
      BIPV2.IDlayouts.l_key_ids_bare;
    END;

    EXPORT rec_widest_plus_acctnos := RECORD
      layout_batch_common_acct;
      INTEGER   error_code                     :=  0;
      LN_PropertyV2_Services.layouts.combined.widest;
    END;

    EXPORT rec_widest_plus_acctnos_plus_matchcodes := RECORD
      layout_batch_common_acct;
      INTEGER   error_code                     :=  0;
      STRING8    matchcodes                     := '';
      LN_PropertyV2_Services.layouts.combined.widest;
    END;

    EXPORT rec_input_and_matchcodes := RECORD
      layout_batch_common_acct;
      string12    ssn                           := '';
      layout_batch_common_name;
      STRING120 comp_name                       := '';
      layout_batch_common_address2 -_county_name;
      LN_PropertyV2_Services.layouts.fid;
      STRING3  assess_prop_addr_match_code := '';
      STRING3  assess_mail_addr_match_code := '';
      STRING3  assess_ownr_addr_match_code := '';
      STRING3  deed_prop_addr_match_code   := '';
      STRING3  deed_buyr_addr_match_code   := '';
      STRING3  deed_sell_addr_match_code   := '';
    END;

  END;

  EXPORT Business := MODULE

    EXPORT rec_SourceOutput_and_acctno := RECORD
      layout_batch_common_acct;
      USAbizV2_Services.layouts.SourceOutput;
    END;

    EXPORT rec_acctnos_recs := RECORD
      layout_batch_common_acct;
      DCA.Layout_DCA_Base;
    END;

    EXPORT rec_acctnos_recs_yp := RECORD
      layout_batch_common_acct;
      YellowPages.Layout_YellowPages_Base;
    END;

  END;

  EXPORT OthersUsingSSN := MODULE

    EXPORT rec_results_raw := RECORD
      Doxie.layout_references_acctno;
      UNSIGNED6 other_did := 0;
      UNSIGNED3 penalt := 0;
      doxie.layout_best AND NOT did;
    END;

  END;

  EXPORT AKAs := MODULE

    EXPORT rec_results_raw := RECORD
      unsigned6 did         := 0;
      layout_batch_common_acct;
      qstring9  ssn         := '';
      qstring8  dob         := '';
      qstring20 fname       := '';
      qstring20 mname       := '';
      qstring20 lname       := '';
      qstring5  name_suffix := '';
    END;

    EXPORT rec_results_temp := RECORD
      rec_results_raw;
      integer3 dt_last_seen  := 0;
      unsigned3 penalt       := 0;
    END;

  END;

  EXPORT DEA := MODULE

    EXPORT rec_results_raw := RECORD
    layout_batch_common_acct;

    String20 fname           := '';
    String20 mname           := '';
    String20 lname           := '';
    String5  name_suffix     := '';

    String28 prim_name       := '';
    String10 prim_range      := '';
    string2  predir          := '';
    string2  postdir         := '';
    string4  addr_suffix     := '';
    string10 unit_desig      := '';
    string8  sec_range       := '';
    string40 address1        := '';
    string40 address2        := '';
    string2  St              := '';
    string25 p_city_name     := '';
    string5  Zip             := '';
    string4  Zip4            := '';
    string18 County_name     := '';
    string5 county           := '';
    string3 county_fips      := '';
    string9  dea_registration_number := '';

    string30 Drug_Schedules  := '';
    string9  best_ssn        := '';
    string12 did             := '';
    string1 business_activity_code   := '';

    string40 Cname    := '';
    string8  Expiration_date := '';
    boolean DeepDive := false;

    END;

  export rec_results_raw_penalty := record
    unsigned2 penalt;
    rec_results_raw;
  end;

  Export layout_Index := RECORD

  string8 date_first_reported;
  string8 date_last_reported;
  string9 dea_registration_number;
  string1 business_activity_code;
  string16 drug_schedules;
  string8 expiration_date;
  string40 address1;
  string40 address2;
  string40 address3;
  string40 address4;
  string33 address5;
  string2 state;
  string5 zip_code;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  integer1 filler;
  boolean is_company_flag;
  string40 cname;
  string2 crlf;
  string18 county_name;
  string12 did;
  string3 score;
  string9 best_ssn;
  string12 bdid;
  string10 cprim_range;
  string28 cprim_name;
  string8 csec_range;
  string25 cv_city_name;
  string2 cst;
  string5 czip;
  unsigned integer1 zero;
  unsigned integer6 indid;
  unsigned integer6 inbdid;
  end;

  export rec_batch_dea_input := RECORD
    Autokey_batch.Layouts.rec_inBatchMaster;
    String15 dea_registration_number := '';
  end;

  END;

  export bankruptcy := MODULE
    EXPORT caserec_single_debtor := record
      BankruptcyV3_Services.layout_bkv3_rollup_ext
        and not debtors;
      BankruptcyV3_Services.layouts.layout_party and not caseid;
      string30 acctno;
      STRING30 matchcode;
    end;

    EXPORT layout_bdids := RECORD
      doxie.layout_inBatchMaster.acctno;
      doxie.Layout_ref_bdid;
    END;
  end;

  export UCC := MODULE
     export rec_autokey_batch_tmsid := RECORD
      Autokey_batch.Layouts.rec_inBatchMaster;
      uccv2_services.layout_tmsid;
    END;

    export rec_ucc_rollup_src_acctno := RECORD
      string30 acctno;
      uccv2_services.layout_ucc_rollup_src;
    END;

    export batch_in := RECORD
      Autokey_batch.Layouts.rec_inBatchMaster;
      layout_BIPLinkids;
    end;
  end;


  EXPORT Email := Module
    //former: Entiera.Layouts.Base_For_Indexes and not[Clean_name, Clean_Address];
    base := Email_Data.Layout_email.keys;
    rec_email := RECORD
      base.orig_pmghousehold_id;
      base.orig_pmgindividual_id;
      base.orig_first_name;
      base.orig_last_name;
      base.orig_address;
      base.orig_city;
      base.orig_state;
      base.orig_zip;
      base.orig_zip4;
      base.orig_email;
      base.orig_ip;
      base.orig_login_date;
      base.orig_site;
      base.orig_e360_id;
      base.orig_teramedia_id;
      base.did;
      base.did_score;
      base.best_ssn;
      base.best_dob;
      base.process_date;
    END;
    EXPORT rec_results_raw := record
      layout_batch_common_acct;
      rec_email;
      string5  title;
      string20 fname;
      string20 mname;
      string20 lname;
      string5  name_suffix;
      string10 prim_range;
      string2  predir;
      string28 prim_name;
      string4  addr_suffix;
      string2  postdir;
      string10 unit_desig;
      string8  sec_range;
      string25 p_city_name;
      string25 v_city_name;
      string2  st;
      string5  zip;
      string4  zip4;
      string2   email_src;
    end;
    export rec_batch_email_input := RECORD
      string72 email_addrFull;
      Autokey_batch.Layouts.rec_inBatchMaster;
    end;
  END;
  EXPORT RTPhones := Module
    export rec_batch_RTPhones_out := record, maxlength(1485)
      layout_batch_common_acct;
      unsigned1  seq;
      string11   ssn;
      string12   DID;
      string10 phone;
      string80 name;
      string20 callerid_name;
      string50 address;
      string30 city;
      string2  state;
      string9  zip;
      string10 latitude;
      string10 longitude;
      string2  congressional_district;
      string4  carrier_route;
      string1  sort_zone;
      string5  fips;
      string5  msa;
      string5  cmsa;
      string8  listing_creation_date;
      string8  listing_transaction_date;
      string20 address_type;
      string25 source;
      string80 carrier_info;
      string2  line_type;
      string30 phone_line_status;
      string2  phone_listing_type;
      string1  non_published;
      string1  ported;
      string80 operating_company_name;
      string80 operating_company_affiliated_to ;
      string50 operating_company_address;
      string20 operating_company_city;
      string2  operating_company_state;
      string9  operating_company_zip;
      string10 operating_company_phone;
      string10 operating_company_fax;
      string80 operating_company_contact;
      string60 company_contact_email;
      string50 company_contact_address;
      string20 company_contact_city;
      string2  company_contact_state;
      string9  company_contact_zip;

      string2  prev_line_type;
      string30 prev_phone_line_status;
      string2  prev_phone_listing_type;
      string1  prev_non_published;
      string1  prev_ported;
      string80 prev_operating_company_name;
      string80 prev_operating_company_affiliated_to ;
      string50 prev_operating_company_address;
      string20 prev_operating_company_city;
      string2  prev_operating_company_state;
      string9  prev_operating_company_zip;
      string10 prev_operating_company_phone;
      string10 prev_operating_company_fax;
      string80 prev_operating_company_contact;
      string60 prev_company_contact_email;
      string50 prev_company_contact_address;
      string20 prev_company_contact_city;
      string2  prev_company_contact_state;
      string9  prev_company_contact_zip;
      string20 responseStatus := '';
     end;
    export rec_output_internal := record(rec_batch_RTPhones_out), maxlength(1501)
      string8     dt_first_seen := '';
      string8     dt_last_seen := '';
      string8     sec_range := '';
      string1     typeflag := '';
      string2     vendor_id := '';
    end;
    export rec_batch_RTPhones_input := record, maxlength(150630)
      layout_batch_common_acct;
      string20   orig_acctno; // internal
      string11   ssn;
      string12   did;
      string15   phoneno;
      string100  unparsedfullname;
      string20   name_first;
      string20   name_last;
      string100  unparsedaddr1;
      string100  unparsedaddr2;
      string10   prim_range;  // used internally
      string28   prim_name;   // used internally
      string40   p_city_name;
      string2    st;
      string5    zip5;
      unsigned1  resultcount := 0; //internal
      string20   requestStatus := ''; //internal
      dataset(rec_output_internal) results {maxcount(100)};// internal
    end;
  END;
  EXPORT Resident := Module
    EXPORT batch_in := Record
         layout_batch_common_acct;
        string100   addr := '';
        string10    prim_range := '';
        string2     predir := '';
        string28    prim_name := '';
        string4     addr_suffix := '';
        string2     postdir := '';
        string8     sec_range := '';
        string25    p_city_name := '';
        string2     st := '';
        string5     z5 := '';
    END;
    Export cln_batch_in := Record ( batch_in )
        string10    unit_desig := '';
        string4     zip4 := '';
        string2 rec_type := '';
        string2 drop_ind := '';
        boolean missing_sec_range := false;
    END;
    EXPORT batch_out := Record
         layout_batch_common_acct;
        string3 age := '0';
        boolean verified := false;
        boolean current := false;
        string1 gender := '';
        unsigned3 dt_first_seen := 0;
        unsigned3 dt_last_seen := 0;
        string20 fname := '';
        string20 mname := '';
        string20 lname :='';
        string5 name_suffix := '';
        string8 dob := '';
        boolean  deceased := false;
        string10 phone_address := '';
        boolean missing_sec_range := false;
    END;
  END; // End of Residents
  EXPORT DriversV2 := Module
    EXPORT batch_in := Record
         Autokey_batch.Layouts.rec_inBatchMaster;
    END;
    EXPORT AcctRec := RECORD(DriversV2_Services.layouts.seq)
      Autokey_batch.Layouts.rec_inBatchMaster.acctno;
      UNSIGNED6  did := 0;
      STRING24  dl_number := '';
      STRING2    dlstate := '';
    END;
    EXPORT AcctRecWithInput := RECORD(AcctRec)
      Autokey_batch.Layouts.rec_inBatchMaster - [acctno, did, dlstate];
    END;
    EXPORT batch_out := RECORD(DriversV2_Services.layouts.result_narrow)
         AcctRec.acctno;
        STRING10  height_desc;
    END;
  END; // End of DriversV2
  EXPORT ReversePhoneHistory := Module
    EXPORT batch_in := Record
        layout_batch_common_acct;
        string10     phone   := '';
        string2     st := '';
        UNSIGNED6    did := 0;
        UNSIGNED6    bdid := 0;
    END;
    EXPORT batch_in_cleaned := Record
        layout_batch_common_acct;
        string7     phone7 := '';
        string3     phone3 := '';
        string2     st := '';
        UNSIGNED6    did := 0;
        UNSIGNED6    bdid := 0;
    END;
    EXPORT batch_out := Record
        layout_batch_common_acct;
        string20    errormsg         := '';
        unsigned4    seq              := 0;
        string1      iscurrent        := '';
        unsigned6    did              := 0;
        unsigned6    bdid            := 0;
        string10     phone             := '';
        string3      timezone        := '';
        STRING120    listed_name      := '';
        string5     title            := '';
        layout_batch_common_name;
        layout_batch_common_address;
        string8     date_first_seen  := '';
        string8     date_last_seen  := '';
        string1      listing_type    := '';
        string1      publish_code    := '';
        string1      omit_address    := '';
        string1      omit_phone      := '';
        string1      omit_locality    := '';
        string1      search_type      := '';
    END;
  END;
  EXPORT CourtLocator := Module
    EXPORT layout_batch_in := RECORD
      Autokey_batch.Layouts.rec_inBatchMaster.acctno;
      Autokey_batch.Layouts.rec_inBatchMaster.prim_range;
      Autokey_batch.Layouts.rec_inBatchMaster.predir;
      Autokey_batch.Layouts.rec_inBatchMaster.prim_name;
      Autokey_batch.Layouts.rec_inBatchMaster.addr_suffix;
      Autokey_batch.Layouts.rec_inBatchMaster.postdir;
      Autokey_batch.Layouts.rec_inBatchMaster.unit_desig;
      Autokey_batch.Layouts.rec_inBatchMaster.sec_range;
      Autokey_batch.Layouts.rec_inBatchMaster.p_city_name;
      Autokey_batch.Layouts.rec_inBatchMaster.st;
      Autokey_batch.Layouts.rec_inBatchMaster.z5;
      Autokey_batch.Layouts.rec_inBatchMaster.zip4;
      string5    fips_code := '';
    END;
    EXPORT layout_batch_out := RECORD
      string20     acctno;
      string5     fipscode;
      string100    CourtName;
      string2     State;
      string100    County;
      string75    PhysicalAddress1;
      string50    PhysicalAddress2;
      string25    PhysicalCity;
      string2     PhysicalState;
      string10     PhysicalZip;
      string50    MailAddress1;
      string50    MailAddress2;
      string25    MailCity;
      string2      MailState;
      string5      MailZip;
      string10     Phone;
      string300    CourtCosts;
      string100    FilingAmounts;
    END;
  END; // END OF COURT LOCATOR

  EXPORT SsnIssuance := MODULE
    export batch_in := record
      string20 acctno;
      string9 ssn;
    end;

    export batch_out := record (batch_in)
      integer validity_code;
      string32 issued_location;
      string8 issued_start_date;
      string8 issued_end_date;
    end;
  END;

  //Tax Refund Investigative Solution
  EXPORT TaxRefundIS := MODULE
    export batch_in := record
      layout_batch_common_acct; //acctno
      unsigned8   seq := 0; //internal use
      layout_batch_common_name; //name
      string9 ssn := '';
      string8 dob := '';
      string40 address        := '';
      layout_batch_common_address; //address
      STRING10  homephone   := '';
      STRING16  workphone   := '';
  end;

    export batch_out := record
      batch_in; //input data
      string9  best_ssn;
      string1 ssn_invalid_flag;
      string1 ssn_randomization_flag;
      string3 possible_age_dob;
      string3 possible_age_ssn_issuance;
      //from best_address
      string2 address_outside_of_home_state;
      string50 Address_Confidence;
      string30 best_fname;
      string30 best_lname;
      string120   best_addr1 := '';
      string30  best_city := '';
      string2    best_state := '';
      string5    best_zip :='';
      string6 date_last_seen; //YYYYMM format
      string6 InputAddrDate; //YYYYMM format
      string1 MatchedInputAddr;
      //from consumer instantID
      string3 Identity_Verification_NAS_Code;
      string3 Identity_Verification_CVI_Code;
      string4 hri_1_indicator;
      string100 hri_1_description;
      string4 hri_2_indicator;
      string100 hri_2_description;
      string4 hri_3_indicator;
      string100 hri_3_description;
      string4 hri_4_indicator;
      string100 hri_4_description;
      string4 hri_5_indicator;
      string100 hri_5_description;
      string4 hri_6_indicator;
      string100 hri_6_description;
      //from deceased
      string30 deceased_first_name;
      string30 deceased_last_name;
      string8 DOD; //YYYYMMDD format
      string5 deceased_matchcode;
      //from criminal
      string2 doc_state_origin;
      string12 doc_sdid;
      string9 doc_ssn_1;
      string30 doc_lname;
      string30 doc_fname;
      string30 doc_mname;
      string10 doc_num;
      string8 doc_dob; //YYYYMMDD format
      Corrections.Layout_Offender.curr_incar_flag;
      Corrections.Layout_Offender.curr_parole_flag;
      Corrections.Layout_Offender.curr_probation_flag;
      //from criminal based on best SSN
      string2 doc_state_origin_BestSSN;
      string12 doc_sdid_BestSSN;
      string9 doc_ssn_1_BestSSN;
      string30 doc_lname_BestSSN;
      string30 doc_fname_BestSSN;
      string30 doc_mname_BestSSN;
      string10 doc_num_BestSSN;
      string8 doc_dob_BestSSN; //YYYYMMDD format
      string1  curr_incar_flag_BestSSN := '';
      string1  curr_parole_flag_BestSSN := '';
      string1  curr_probation_flag_BestSSN := '';
      string8 InputAddrZipDate; //YYYYMMDD format
      string1 inputAddrRel := '';
      //from FraudPoint 2.0
      string3  npi_indicator:=''; // Higher score, the better person 0 - 999
      //for filter
      string30  identity_filter :='';

    end;
  END;
END;
