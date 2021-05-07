IMPORT PAW, doxie, BIPV2, BatchShare, FFD, paw_services;

EXPORT Layouts := MODULE
  EXPORT search := RECORD
    UNSIGNED6 contact_id;
    BOOLEAN isDeepDive := FALSE;
  END;

  EXPORT rec_seleid_only := RECORD
    BIPV2.IDlayouts.l_xlink_ids.SELEID;
  END;

  EXPORT rptPhone := RECORD
    BOOLEAN verified;
    STRING10 phone10;
    STRING4 timezone;
  END;

  EXPORT raw := RECORD
    RECORDOF(PAW.Key_contactID);
    BOOLEAN isDeepDive := FALSE;
    UNSIGNED2 penalt := 0;
    STRING4 timezone;
    BOOLEAN hasCriminalConviction := FALSE;
    BOOLEAN isSexualOffender := FALSE;
  END;

  EXPORT rptSsn := RECORD
    STRING9 ssn;
  END;

  EXPORT rptIndvName := RECORD
    STRING5 title;
    STRING20 fname;
    STRING20 mname;
    STRING20 lname;
    STRING5 name_suffix;
  END;

  EXPORT rptAddr := RECORD
    STRING10 prim_range;
    STRING2 predir;
    STRING28 prim_name;
    STRING4 addr_suffix;
    STRING2 postdir;
    STRING5 unit_desig;
    STRING8 sec_range;
    STRING25 city;
    STRING2 state;
    STRING5 zip;
    STRING4 zip4;
    DATASET(rptPhone) phones {MAXCOUNT(paw_services.Constants.MAX_PHONES_PER_ADDR)};
  END;

  EXPORT rptFein := RECORD
    STRING9 fein;
  END;

  EXPORT rptBizName := RECORD
    STRING120 company_name;
  END;

  EXPORT rptDtSeen := RECORD
    STRING8 dt_first_seen;
    STRING8 dt_last_seen;
  END;

  EXPORT rptPosition := RECORD
    DATASET(rptDtSeen) dates {MAXCOUNT(paw_services.Constants.MAX_DATES_PER_POSITION)};
    STRING35 company_title;
    STRING35 company_department;
  END;

  EXPORT rptEmployer := RECORD
    UNSIGNED6 bdid;
    BIPV2.IDlayouts.l_header_ids;
    DATASET(rptDtSeen) dates {MAXCOUNT(paw_services.Constants.MAX_DATES_PER_EMPLOYER)};
    DATASET(rptFein) feins {MAXCOUNT(paw_services.Constants.MAX_FEINS_PER_EMPLOYER)};
    DATASET(rptBizName) company_names {MAXCOUNT(paw_services.Constants.MAX_COMPANY_NAMES_PER_EMPLOYER)};
    DATASET(rptAddr) addrs {MAXCOUNT(paw_services.Constants.MAX_ADDRS_PER_EMPLOYER)};
    DATASET(rptPosition) positions {MAXCOUNT(paw_services.Constants.MAX_POSITIONS_PER_EMPLOYER)};
  END;

  EXPORT rptPerson := RECORD
    BOOLEAN isDeepDive;
    UNSIGNED2 penalt;
    UNSIGNED6 did;
    DATASET(rptSsn) ssns {MAXCOUNT(paw_services.Constants.MAX_SSNS_PER_PERSON)};
    DATASET(rptIndvName) names {MAXCOUNT(paw_services.Constants.MAX_NAMES_PER_PERSON)};
    DATASET(rptEmployer) employers {MAXCOUNT(paw_services.Constants.MAX_EMPLOYERS_PER_PERSON)};
    BOOLEAN hasCriminalConviction := FALSE;
    BOOLEAN isSexualOffender := FALSE;
  END;

  EXPORT batch_in := RECORD
    UNSIGNED2 penalt := 0;
    STRING8 matchcodes;
    INTEGER error_code;
    doxie.layout_inBatchMaster.acctno;
    RECORDOF(paw.Key_contactID);
  END;

  EXPORT layout_for_PAW_penalties := RECORD
    STRING20 _acctno := '';
    STRING20 _name_first := '';
    STRING20 _name_middle := '';
    STRING20 _name_last := '';
    STRING5 _name_suffix := '';
    STRING120 _comp_name := '';
    STRING10 _prim_range := '';
    STRING2 _predir := '';
    STRING28 _prim_name := '';
    STRING4 _addr_suffix := '';
    STRING2 _postdir := '';
    STRING10 _unit_desig := '';
    STRING8 _sec_range := '';
    STRING25 _p_city_name := '';
    STRING2 _st := '';
    STRING5 _z5 := '';
    STRING4 _zip4 := '';
    STRING12 _ssn := '';
    STRING12 _fein := '';
    STRING8 _dob := '';
    STRING10 _homephone := '';
    STRING16 _workphone := '';
  END;

  EXPORT Batch_out := RECORD
    STRING20 acctno;
    UNSIGNED2 penalt := 1000;
    INTEGER error_code;
    STRING8 matchcodes;

    STRING12 pawk_1_did;
    STRING3 pawk_1_confidence_level;
    STRING20 pawk_1_first;
    STRING20 pawk_1_middle;
    STRING20 pawk_1_last;
    STRING5 pawk_1_suffix;
    STRING9 pawk_1_ssn;
    STRING35 pawk_1_title;
    STRING8 pawk_1_first_seen;
    STRING8 pawk_1_last_seen;
    STRING12 pawk_1_bdid;
    STRING35 pawk_1_company_name;
    STRING35 pawk_1_department;
    STRING9 pawk_1_fein;
    STRING80 pawk_1_address;
    STRING25 pawk_1_city;
    STRING2 pawk_1_state;
    STRING5 pawk_1_zip5;
    STRING4 pawk_1_zip4;
    STRING10 pawk_1_phone10;
    STRING5 pawk_1_verified;
    STRING60 pawk_1_email;

    STRING12 pawk_2_did;
    STRING3 pawk_2_confidence_level;
    STRING20 pawk_2_first;
    STRING20 pawk_2_middle;
    STRING20 pawk_2_last;
    STRING5 pawk_2_suffix;
    STRING9 pawk_2_ssn;
    STRING35 pawk_2_title;
    STRING8 pawk_2_first_seen;
    STRING8 pawk_2_last_seen;
    STRING12 pawk_2_bdid;
    STRING120 pawk_2_company_name;
    STRING35 pawk_2_department;
    STRING9 pawk_2_fein;
    STRING80 pawk_2_address;
    STRING25 pawk_2_city;
    STRING2 pawk_2_state;
    STRING5 pawk_2_zip5;
    STRING4 pawk_2_zip4;
    STRING10 pawk_2_phone10;
    STRING5 pawk_2_verified;
    STRING60 pawk_2_email;

    STRING12 pawk_3_did;
    STRING3 pawk_3_confidence_level;
    STRING20 pawk_3_first;
    STRING20 pawk_3_middle;
    STRING20 pawk_3_last;
    STRING5 pawk_3_suffix;
    STRING9 pawk_3_ssn;
    STRING35 pawk_3_title;
    STRING8 pawk_3_first_seen;
    STRING8 pawk_3_last_seen;
    STRING12 pawk_3_bdid;
    STRING120 pawk_3_company_name;
    STRING35 pawk_3_department;
    STRING9 pawk_3_fein;
    STRING80 pawk_3_address;
    STRING25 pawk_3_city;
    STRING2 pawk_3_state;
    STRING5 pawk_3_zip5;
    STRING4 pawk_3_zip4;
    STRING10 pawk_3_phone10;
    STRING5 pawk_3_verified;
    STRING60 pawk_3_email;

    STRING12 pawk_4_did;
    STRING3 pawk_4_confidence_level;
    STRING20 pawk_4_first;
    STRING20 pawk_4_middle;
    STRING20 pawk_4_last;
    STRING5 pawk_4_suffix;
    STRING9 pawk_4_ssn;
    STRING35 pawk_4_title;
    STRING8 pawk_4_first_seen;
    STRING8 pawk_4_last_seen;
    STRING12 pawk_4_bdid;
    STRING120 pawk_4_company_name;
    STRING35 pawk_4_department;
    STRING9 pawk_4_fein;
    STRING80 pawk_4_address;
    STRING25 pawk_4_city;
    STRING2 pawk_4_state;
    STRING5 pawk_4_zip5;
    STRING4 pawk_4_zip4;
    STRING10 pawk_4_phone10;
    STRING5 pawk_4_verified;
    STRING60 pawk_4_email;

    STRING12 pawk_5_did;
    STRING3 pawk_5_confidence_level;
    STRING20 pawk_5_first;
    STRING20 pawk_5_middle;
    STRING20 pawk_5_last;
    STRING5 pawk_5_suffix;
    STRING9 pawk_5_ssn;
    STRING35 pawk_5_title;
    STRING8 pawk_5_first_seen;
    STRING8 pawk_5_last_seen;
    STRING12 pawk_5_bdid;
    STRING120 pawk_5_company_name;
    STRING35 pawk_5_department;
    STRING9 pawk_5_fein;
    STRING80 pawk_5_address;
    STRING25 pawk_5_city;
    STRING2 pawk_5_state;
    STRING5 pawk_5_zip5;
    STRING4 pawk_5_zip4;
    STRING10 pawk_5_phone10;
    STRING5 pawk_5_verified;
    STRING60 pawk_5_email;

  END;

  EXPORT FCRA := MODULE

    EXPORT inputRec:=RECORD
      BatchShare.Layouts.ShareAcct;
      BatchShare.Layouts.ShareDid;
      BatchShare.Layouts.ShareName;
      BatchShare.Layouts.SharePII;
      BatchShare.Layouts.ShareAddress;
    END;

    EXPORT workRec:=RECORD
      inputRec;
      TYPEOF(BatchShare.Layouts.ShareAcct.acctno) orig_acctno;
      Batchshare.Layouts.ShareErrors;
    END;

    // DISCLOSE ONLY
    EXPORT pawRec := RECORD
      Paw.Layout.Employment_Out.dt_first_seen;
      Paw.Layout.Employment_Out.dt_last_seen;
      Paw.Layout.Employment_Out.source;
      Paw.Layout.Employment_Out.company_name;
      Paw.Layout.Employment_Out.company_prim_range;
      Paw.Layout.Employment_Out.company_predir;
      Paw.Layout.Employment_Out.company_prim_name;
      Paw.Layout.Employment_Out.company_addr_suffix;
      Paw.Layout.Employment_Out.company_postdir;
      Paw.Layout.Employment_Out.company_unit_desig;
      Paw.Layout.Employment_Out.company_sec_range;
      Paw.Layout.Employment_Out.company_city;
      Paw.Layout.Employment_Out.company_state;
      Paw.Layout.Employment_Out.company_zip;
      Paw.Layout.Employment_Out.company_zip4;
      Paw.Layout.Employment_Out.company_title;
      Paw.Layout.Employment_Out.company_phone;
      Paw.Layout.Employment_Out.company_status;
      Paw.Layout.Employment_Out.active_phone_flag;
      Paw.Layout.Employment_Out.fname;
      Paw.Layout.Employment_Out.mname;
      Paw.Layout.Employment_Out.lname;
      Paw.Layout.Employment_Out.name_suffix;
      Paw.Layout.Employment_Out.phone;
      Paw.Layout.Employment_Out.email_address;
      Paw.Layout.Employment_Out.prim_range;
      Paw.Layout.Employment_Out.predir;
      Paw.Layout.Employment_Out.prim_name;
      Paw.Layout.Employment_Out.addr_suffix;
      Paw.Layout.Employment_Out.postdir;
      Paw.Layout.Employment_Out.unit_desig;
      Paw.Layout.Employment_Out.sec_range;
      Paw.Layout.Employment_Out.city;
      Paw.Layout.Employment_Out.state;
      Paw.Layout.Employment_Out.zip;
      Paw.Layout.Employment_Out.zip4;
      Paw.Layout.Employment_Out.county;
    END;

    EXPORT pawBatchOutRec:=RECORD
      BatchShare.Layouts.ShareAcct;
      UNSIGNED SequenceNumber;
      BatchShare.Layouts.ShareDid;
      BatchShare.Layouts.ShareErrors.error_code;
      pawRec;
      FFD.Layouts.ConsumerFlags;
      STRING12 inquiry_lexid;
    END;

    EXPORT pawWorkRec := RECORD
      pawBatchOutRec;
      Paw.Layout.Employment_Out.contact_id;
      DATASET(FFD.Layouts.ConsumerStatementBatch) StatementsAndDisputes;
      FFD.Layouts.CommonRawRecordElements;
    END;

  END;

END;
