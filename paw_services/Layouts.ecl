import PAW,doxie, BIPV2, BatchShare, FFD, paw_services;

export Layouts := module
  export search := record
    unsigned6 contact_id;
    boolean isDeepDive := false;
  end;

  export rec_seleid_only := record
    BIPV2.IDlayouts.l_xlink_ids.SELEID;
  end;

  export rptPhone := record
    boolean verified;
    STRING10 phone10;
    STRING4  timezone;
  end;

  export raw := record
    recordof(PAW.Key_contactID);
    boolean isDeepDive := false;
    unsigned2 penalt := 0;
    string4   timezone;
    boolean hasCriminalConviction := false;
    boolean isSexualOffender := false;		
  end;

  export rptSsn := record
    string9 ssn;
  end;

  export rptIndvName := record
    string5 title;
    string20 fname;
    string20 mname;
    string20 lname;
    string5 name_suffix;
  end;

  export rptAddr := record
    string10 prim_range;
    string2 predir;
    string28 prim_name;
    string4 addr_suffix;
    string2 postdir;
    string5 unit_desig;
    string8 sec_range;
    string25 city;
    string2 state;
    string5 zip;
    string4 zip4;
    dataset(rptPhone) phones {maxcount(paw_services.Constants.MAX_PHONES_PER_ADDR)};
  end;

  export rptFein := record
    string9 fein;
  end;

  export rptBizName := record
    string120 company_name;
  end;

  export rptDtSeen := record
    string8 dt_first_seen;
    string8 dt_last_seen;
  end;

  export rptPosition := record
    dataset(rptDtSeen) dates {maxcount(paw_services.Constants.MAX_DATES_PER_POSITION)};
    string35 company_title;
    string35 company_department;
  end;

  export rptEmployer := record
    unsigned6 bdid;
    BIPV2.IDlayouts.l_header_ids;
    dataset(rptDtSeen) dates {maxcount(paw_services.Constants.MAX_DATES_PER_EMPLOYER)};
    dataset(rptFein) feins {maxcount(paw_services.Constants.MAX_FEINS_PER_EMPLOYER)};
    dataset(rptBizName) company_names {maxcount(paw_services.Constants.MAX_COMPANY_NAMES_PER_EMPLOYER)};
    dataset(rptAddr) addrs {maxcount(paw_services.Constants.MAX_ADDRS_PER_EMPLOYER)};
    dataset(rptPosition) positions {maxcount(paw_services.Constants.MAX_POSITIONS_PER_EMPLOYER)};
  end;

  export rptPerson := record
    boolean isDeepDive;
    unsigned2 penalt;
    unsigned6 did;
    dataset(rptSsn) ssns {maxcount(paw_services.Constants.MAX_SSNS_PER_PERSON)};
    dataset(rptIndvName) names {maxcount(paw_services.Constants.MAX_NAMES_PER_PERSON)};
    dataset(rptEmployer) employers {maxcount(paw_services.Constants.MAX_EMPLOYERS_PER_PERSON)};
    boolean hasCriminalConviction := false;
    boolean isSexualOffender := false;
  end;

  EXPORT batch_in := RECORD
    unsigned2 penalt := 0;
    string8 matchcodes;
    integer error_code;
    doxie.layout_inBatchMaster.acctno;
    recordof(paw.Key_contactID);
  END;

  EXPORT layout_for_PAW_penalties := RECORD
    string20    _acctno      := '';
    string20    _name_first  := '';
    string20    _name_middle := '';
    string20    _name_last   := '';
    string5     _name_suffix := '';
    string120   _comp_name   := '';
    string10    _prim_range  := '';
    string2     _predir      := '';
    string28    _prim_name   := '';
    string4     _addr_suffix := '';
    string2     _postdir     := '';
    string10    _unit_desig  := '';
    string8     _sec_range   := '';
    string25    _p_city_name := '';
    string2     _st          := '';
    string5     _z5          := '';
    string4     _zip4        := '';
    string12    _ssn         := '';
    string12    _fein        := '';
    string8     _dob         := '';
    string10    _homephone   := '';
    string16    _workphone   := '';
  END;

  EXPORT Batch_out := RECORD
    string20  acctno;
    unsigned2 penalt := 1000;
    integer   error_code;
    string8   matchcodes;

    string12  pawk_1_did;
    string3   pawk_1_confidence_level ;
    string20  pawk_1_first ;
    string20  pawk_1_middle ;
    string20  pawk_1_last ;
    string5   pawk_1_suffix ;
    string9   pawk_1_ssn ;
    string35  pawk_1_title ;
    string8   pawk_1_first_seen ;
    string8   pawk_1_last_seen ;
    string12  pawk_1_bdid;
    string35  pawk_1_company_name ;
    string35  pawk_1_department ;
    string9   pawk_1_fein ;
    string80  pawk_1_address ;
    string25  pawk_1_city ;
    string2   pawk_1_state ;
    string5   pawk_1_zip5 ;
    string4   pawk_1_zip4 ;
    string10  pawk_1_phone10 ;
    string5   pawk_1_verified ;
    string60  pawk_1_email ;

    string12  pawk_2_did;
    string3   pawk_2_confidence_level ;
    string20  pawk_2_first ;
    string20  pawk_2_middle ;
    string20  pawk_2_last ;
    string5   pawk_2_suffix ;
    string9   pawk_2_ssn ;
    string35  pawk_2_title ;
    string8   pawk_2_first_seen ;
    string8   pawk_2_last_seen ;
    string12  pawk_2_bdid;
    string120 pawk_2_company_name ;
    string35  pawk_2_department ;
    string9   pawk_2_fein ;
    string80  pawk_2_address ;
    string25  pawk_2_city ;
    string2   pawk_2_state ;
    string5   pawk_2_zip5 ;
    string4   pawk_2_zip4 ;
    string10  pawk_2_phone10 ;
    string5   pawk_2_verified ;
    string60  pawk_2_email ;

    string12  pawk_3_did;
    string3   pawk_3_confidence_level ;
    string20  pawk_3_first ;
    string20  pawk_3_middle ;
    string20  pawk_3_last ;
    string5   pawk_3_suffix ;
    string9   pawk_3_ssn ;
    string35  pawk_3_title ;
    string8   pawk_3_first_seen ;
    string8   pawk_3_last_seen ;
    string12  pawk_3_bdid;
    string120 pawk_3_company_name ;
    string35  pawk_3_department ;
    string9   pawk_3_fein ;
    string80  pawk_3_address ;
    string25  pawk_3_city ;
    string2   pawk_3_state ;
    string5   pawk_3_zip5 ;
    string4   pawk_3_zip4 ;
    string10  pawk_3_phone10 ;
    string5   pawk_3_verified ;
    string60  pawk_3_email ;

    string12  pawk_4_did;
    string3   pawk_4_confidence_level ;
    string20  pawk_4_first ;
    string20  pawk_4_middle ;
    string20  pawk_4_last ;
    string5   pawk_4_suffix ;
    string9   pawk_4_ssn ;
    string35  pawk_4_title ;
    string8   pawk_4_first_seen ;
    string8   pawk_4_last_seen ;
    string12  pawk_4_bdid;
    string120 pawk_4_company_name ;
    string35  pawk_4_department ;
    string9   pawk_4_fein ;
    string80  pawk_4_address ;
    string25  pawk_4_city ;
    string2   pawk_4_state ;
    string5   pawk_4_zip5 ;
    string4   pawk_4_zip4 ;
    string10  pawk_4_phone10 ;
    string5   pawk_4_verified ;
    string60  pawk_4_email ;

    string12  pawk_5_did;
    string3   pawk_5_confidence_level ;	
    string20  pawk_5_first ;
    string20  pawk_5_middle ;
    string20  pawk_5_last ;
    string5   pawk_5_suffix ;
    string9   pawk_5_ssn ;
    string35  pawk_5_title ;
    string8   pawk_5_first_seen ;
    string8   pawk_5_last_seen ;
    string12  pawk_5_bdid;
    string120 pawk_5_company_name ;
    string35  pawk_5_department ;
    string9   pawk_5_fein ;
    string80  pawk_5_address ;
    string25  pawk_5_city ;
    string2   pawk_5_state ;
    string5   pawk_5_zip5 ;
    string4   pawk_5_zip4 ;
    string10  pawk_5_phone10 ;
    string5   pawk_5_verified ;
    string60  pawk_5_email ;

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
      unsigned SequenceNumber;
      BatchShare.Layouts.ShareDid;
      BatchShare.Layouts.ShareErrors.error_code;
      pawRec;
      FFD.Layouts.ConsumerFlags;
      string12 inquiry_lexid;
    END;

    EXPORT pawWorkRec := RECORD
      pawBatchOutRec;
      Paw.Layout.Employment_Out.contact_id;
      DATASET(FFD.Layouts.ConsumerStatementBatch) StatementsAndDisputes;
      FFD.Layouts.CommonRawRecordElements;
    END;

  END;

end;
