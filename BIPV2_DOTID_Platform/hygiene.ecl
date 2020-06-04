IMPORT ut,SALT32;
EXPORT hygiene(dataset(layout_DOT) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT32.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.source);    NumberOfRecords := COUNT(GROUP);
    populated_cnp_number_pcnt := AVE(GROUP,IF(h.cnp_number = (TYPEOF(h.cnp_number))'',0,100));
    maxlength_cnp_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.cnp_number)));
    avelength_cnp_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.cnp_number)),h.cnp_number<>(typeof(h.cnp_number))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_isContact_pcnt := AVE(GROUP,IF(h.isContact = (TYPEOF(h.isContact))'',0,100));
    maxlength_isContact := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.isContact)));
    avelength_isContact := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.isContact)),h.isContact<>(typeof(h.isContact))'');
    populated_contact_ssn_pcnt := AVE(GROUP,IF(h.contact_ssn = (TYPEOF(h.contact_ssn))'',0,100));
    maxlength_contact_ssn := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.contact_ssn)));
    avelength_contact_ssn := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.contact_ssn)),h.contact_ssn<>(typeof(h.contact_ssn))'');
    populated_company_fein_pcnt := AVE(GROUP,IF(h.company_fein = (TYPEOF(h.company_fein))'',0,100));
    maxlength_company_fein := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_fein)));
    avelength_company_fein := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_fein)),h.company_fein<>(typeof(h.company_fein))'');
    populated_active_enterprise_number_pcnt := AVE(GROUP,IF(h.active_enterprise_number = (TYPEOF(h.active_enterprise_number))'',0,100));
    maxlength_active_enterprise_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.active_enterprise_number)));
    avelength_active_enterprise_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.active_enterprise_number)),h.active_enterprise_number<>(typeof(h.active_enterprise_number))'');
    populated_active_domestic_corp_key_pcnt := AVE(GROUP,IF(h.active_domestic_corp_key = (TYPEOF(h.active_domestic_corp_key))'',0,100));
    maxlength_active_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.active_domestic_corp_key)));
    avelength_active_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.active_domestic_corp_key)),h.active_domestic_corp_key<>(typeof(h.active_domestic_corp_key))'');
    populated_cnp_name_pcnt := AVE(GROUP,IF(h.cnp_name = (TYPEOF(h.cnp_name))'',0,100));
    maxlength_cnp_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.cnp_name)));
    avelength_cnp_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.cnp_name)),h.cnp_name<>(typeof(h.cnp_name))'');
    populated_corp_legal_name_pcnt := AVE(GROUP,IF(h.corp_legal_name = (TYPEOF(h.corp_legal_name))'',0,100));
    maxlength_corp_legal_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.corp_legal_name)));
    avelength_corp_legal_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.corp_legal_name)),h.corp_legal_name<>(typeof(h.corp_legal_name))'');
    populated_active_duns_number_pcnt := AVE(GROUP,IF(h.active_duns_number = (TYPEOF(h.active_duns_number))'',0,100));
    maxlength_active_duns_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.active_duns_number)));
    avelength_active_duns_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.active_duns_number)),h.active_duns_number<>(typeof(h.active_duns_number))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_cnp_btype_pcnt := AVE(GROUP,IF(h.cnp_btype = (TYPEOF(h.cnp_btype))'',0,100));
    maxlength_cnp_btype := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.cnp_btype)));
    avelength_cnp_btype := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.cnp_btype)),h.cnp_btype<>(typeof(h.cnp_btype))'');
    populated_cnp_lowv_pcnt := AVE(GROUP,IF(h.cnp_lowv = (TYPEOF(h.cnp_lowv))'',0,100));
    maxlength_cnp_lowv := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.cnp_lowv)));
    avelength_cnp_lowv := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.cnp_lowv)),h.cnp_lowv<>(typeof(h.cnp_lowv))'');
    populated_cnp_translated_pcnt := AVE(GROUP,IF(h.cnp_translated = (TYPEOF(h.cnp_translated))'',0,100));
    maxlength_cnp_translated := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.cnp_translated)));
    avelength_cnp_translated := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.cnp_translated)),h.cnp_translated<>(typeof(h.cnp_translated))'');
    populated_cnp_classid_pcnt := AVE(GROUP,IF(h.cnp_classid = (TYPEOF(h.cnp_classid))'',0,100));
    maxlength_cnp_classid := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.cnp_classid)));
    avelength_cnp_classid := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.cnp_classid)),h.cnp_classid<>(typeof(h.cnp_classid))'');
    populated_company_bdid_pcnt := AVE(GROUP,IF(h.company_bdid = (TYPEOF(h.company_bdid))'',0,100));
    maxlength_company_bdid := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_bdid)));
    avelength_company_bdid := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_bdid)),h.company_bdid<>(typeof(h.company_bdid))'');
    populated_company_phone_pcnt := AVE(GROUP,IF(h.company_phone = (TYPEOF(h.company_phone))'',0,100));
    maxlength_company_phone := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_phone)));
    avelength_company_phone := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_phone)),h.company_phone<>(typeof(h.company_phone))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_contact_phone_pcnt := AVE(GROUP,IF(h.contact_phone = (TYPEOF(h.contact_phone))'',0,100));
    maxlength_contact_phone := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.contact_phone)));
    avelength_contact_phone := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.contact_phone)),h.contact_phone<>(typeof(h.contact_phone))'');
    populated_contact_email_pcnt := AVE(GROUP,IF(h.contact_email = (TYPEOF(h.contact_email))'',0,100));
    maxlength_contact_email := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.contact_email)));
    avelength_contact_email := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.contact_email)),h.contact_email<>(typeof(h.contact_email))'');
    populated_contact_job_title_raw_pcnt := AVE(GROUP,IF(h.contact_job_title_raw = (TYPEOF(h.contact_job_title_raw))'',0,100));
    maxlength_contact_job_title_raw := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.contact_job_title_raw)));
    avelength_contact_job_title_raw := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.contact_job_title_raw)),h.contact_job_title_raw<>(typeof(h.contact_job_title_raw))'');
    populated_company_department_pcnt := AVE(GROUP,IF(h.company_department = (TYPEOF(h.company_department))'',0,100));
    maxlength_company_department := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_department)));
    avelength_company_department := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_department)),h.company_department<>(typeof(h.company_department))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_cnp_number_pcnt *  14.00 / 100 + T.Populated_prim_range_pcnt *  13.00 / 100 + T.Populated_prim_name_pcnt *  15.00 / 100 + T.Populated_st_pcnt *   5.00 / 100 + T.Populated_isContact_pcnt *   1.00 / 100 + T.Populated_contact_ssn_pcnt *  28.00 / 100 + T.Populated_company_fein_pcnt *  27.00 / 100 + T.Populated_active_enterprise_number_pcnt *  27.00 / 100 + T.Populated_active_domestic_corp_key_pcnt *  27.00 / 100 + T.Populated_cnp_name_pcnt *  25.00 / 100 + T.Populated_corp_legal_name_pcnt *  25.00 / 100 + T.Populated_active_duns_number_pcnt *  24.00 / 100 + T.Populated_zip_pcnt *  14.00 / 100 + T.Populated_sec_range_pcnt *  12.00 / 100 + T.Populated_v_city_name_pcnt *  11.00 / 100 + T.Populated_lname_pcnt *  11.00 / 100 + T.Populated_mname_pcnt *  10.00 / 100 + T.Populated_fname_pcnt *   9.00 / 100 + T.Populated_name_suffix_pcnt *   9.00 / 100 + T.Populated_cnp_btype_pcnt *   3.00 / 100 + T.Populated_cnp_lowv_pcnt *   0.00 / 100 + T.Populated_cnp_translated_pcnt *   0.00 / 100 + T.Populated_cnp_classid_pcnt *   0.00 / 100 + T.Populated_company_bdid_pcnt *   0.00 / 100 + T.Populated_company_phone_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_contact_phone_pcnt *   0.00 / 100 + T.Populated_contact_email_pcnt *   0.00 / 100 + T.Populated_contact_job_title_raw_pcnt *   0.00 / 100 + T.Populated_company_department_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING source1;
    STRING source2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.source1 := le.Source;
    SELF.source2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_cnp_number_pcnt*ri.Populated_cnp_number_pcnt *  14.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *  13.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *  15.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   5.00 / 10000 + le.Populated_isContact_pcnt*ri.Populated_isContact_pcnt *   1.00 / 10000 + le.Populated_contact_ssn_pcnt*ri.Populated_contact_ssn_pcnt *  28.00 / 10000 + le.Populated_company_fein_pcnt*ri.Populated_company_fein_pcnt *  27.00 / 10000 + le.Populated_active_enterprise_number_pcnt*ri.Populated_active_enterprise_number_pcnt *  27.00 / 10000 + le.Populated_active_domestic_corp_key_pcnt*ri.Populated_active_domestic_corp_key_pcnt *  27.00 / 10000 + le.Populated_cnp_name_pcnt*ri.Populated_cnp_name_pcnt *  25.00 / 10000 + le.Populated_corp_legal_name_pcnt*ri.Populated_corp_legal_name_pcnt *  25.00 / 10000 + le.Populated_active_duns_number_pcnt*ri.Populated_active_duns_number_pcnt *  24.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *  14.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *  12.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *  11.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *  11.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *  10.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   9.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   9.00 / 10000 + le.Populated_cnp_btype_pcnt*ri.Populated_cnp_btype_pcnt *   3.00 / 10000 + le.Populated_cnp_lowv_pcnt*ri.Populated_cnp_lowv_pcnt *   0.00 / 10000 + le.Populated_cnp_translated_pcnt*ri.Populated_cnp_translated_pcnt *   0.00 / 10000 + le.Populated_cnp_classid_pcnt*ri.Populated_cnp_classid_pcnt *   0.00 / 10000 + le.Populated_company_bdid_pcnt*ri.Populated_company_bdid_pcnt *   0.00 / 10000 + le.Populated_company_phone_pcnt*ri.Populated_company_phone_pcnt *   0.00 / 10000 + le.Populated_company_name_pcnt*ri.Populated_company_name_pcnt *   0.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   0.00 / 10000 + le.Populated_contact_phone_pcnt*ri.Populated_contact_phone_pcnt *   0.00 / 10000 + le.Populated_contact_email_pcnt*ri.Populated_contact_email_pcnt *   0.00 / 10000 + le.Populated_contact_job_title_raw_pcnt*ri.Populated_contact_job_title_raw_pcnt *   0.00 / 10000 + le.Populated_company_department_pcnt*ri.Populated_company_department_pcnt *   0.00 / 10000 + le.Populated_dt_first_seen_pcnt*ri.Populated_dt_first_seen_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_pcnt*ri.Populated_dt_last_seen_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT32.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'cnp_number','prim_range','prim_name','st','isContact','contact_ssn','company_fein','active_enterprise_number','active_domestic_corp_key','cnp_name','corp_legal_name','active_duns_number','zip','sec_range','v_city_name','lname','mname','fname','name_suffix','cnp_btype','cnp_lowv','cnp_translated','cnp_classid','company_bdid','company_phone','company_name','title','contact_phone','contact_email','contact_job_title_raw','company_department','dt_first_seen','dt_last_seen');
  SELF.populated_pcnt := CHOOSE(C,le.populated_cnp_number_pcnt,le.populated_prim_range_pcnt,le.populated_prim_name_pcnt,le.populated_st_pcnt,le.populated_isContact_pcnt,le.populated_contact_ssn_pcnt,le.populated_company_fein_pcnt,le.populated_active_enterprise_number_pcnt,le.populated_active_domestic_corp_key_pcnt,le.populated_cnp_name_pcnt,le.populated_corp_legal_name_pcnt,le.populated_active_duns_number_pcnt,le.populated_zip_pcnt,le.populated_sec_range_pcnt,le.populated_v_city_name_pcnt,le.populated_lname_pcnt,le.populated_mname_pcnt,le.populated_fname_pcnt,le.populated_name_suffix_pcnt,le.populated_cnp_btype_pcnt,le.populated_cnp_lowv_pcnt,le.populated_cnp_translated_pcnt,le.populated_cnp_classid_pcnt,le.populated_company_bdid_pcnt,le.populated_company_phone_pcnt,le.populated_company_name_pcnt,le.populated_title_pcnt,le.populated_contact_phone_pcnt,le.populated_contact_email_pcnt,le.populated_contact_job_title_raw_pcnt,le.populated_company_department_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_cnp_number,le.maxlength_prim_range,le.maxlength_prim_name,le.maxlength_st,le.maxlength_isContact,le.maxlength_contact_ssn,le.maxlength_company_fein,le.maxlength_active_enterprise_number,le.maxlength_active_domestic_corp_key,le.maxlength_cnp_name,le.maxlength_corp_legal_name,le.maxlength_active_duns_number,le.maxlength_zip,le.maxlength_sec_range,le.maxlength_v_city_name,le.maxlength_lname,le.maxlength_mname,le.maxlength_fname,le.maxlength_name_suffix,le.maxlength_cnp_btype,le.maxlength_cnp_lowv,le.maxlength_cnp_translated,le.maxlength_cnp_classid,le.maxlength_company_bdid,le.maxlength_company_phone,le.maxlength_company_name,le.maxlength_title,le.maxlength_contact_phone,le.maxlength_contact_email,le.maxlength_contact_job_title_raw,le.maxlength_company_department,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen);
  SELF.avelength := CHOOSE(C,le.avelength_cnp_number,le.avelength_prim_range,le.avelength_prim_name,le.avelength_st,le.avelength_isContact,le.avelength_contact_ssn,le.avelength_company_fein,le.avelength_active_enterprise_number,le.avelength_active_domestic_corp_key,le.avelength_cnp_name,le.avelength_corp_legal_name,le.avelength_active_duns_number,le.avelength_zip,le.avelength_sec_range,le.avelength_v_city_name,le.avelength_lname,le.avelength_mname,le.avelength_fname,le.avelength_name_suffix,le.avelength_cnp_btype,le.avelength_cnp_lowv,le.avelength_cnp_translated,le.avelength_cnp_classid,le.avelength_company_bdid,le.avelength_company_phone,le.avelength_company_name,le.avelength_title,le.avelength_contact_phone,le.avelength_contact_email,le.avelength_contact_job_title_raw,le.avelength_company_department,le.avelength_dt_first_seen,le.avelength_dt_last_seen);
END;
EXPORT invSummary := NORMALIZE(summary0, 33, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT32.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.DOTid;
  SELF.Src := le.source;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT32.StrType)le.cnp_number),TRIM((SALT32.StrType)le.prim_range),TRIM((SALT32.StrType)le.prim_name),TRIM((SALT32.StrType)le.st),TRIM((SALT32.StrType)le.isContact),TRIM((SALT32.StrType)le.contact_ssn),TRIM((SALT32.StrType)le.company_fein),TRIM((SALT32.StrType)le.active_enterprise_number),TRIM((SALT32.StrType)le.active_domestic_corp_key),TRIM((SALT32.StrType)le.cnp_name),TRIM((SALT32.StrType)le.corp_legal_name),TRIM((SALT32.StrType)le.active_duns_number),TRIM((SALT32.StrType)le.zip),TRIM((SALT32.StrType)le.sec_range),TRIM((SALT32.StrType)le.v_city_name),TRIM((SALT32.StrType)le.lname),TRIM((SALT32.StrType)le.mname),TRIM((SALT32.StrType)le.fname),TRIM((SALT32.StrType)le.name_suffix),TRIM((SALT32.StrType)le.cnp_btype),TRIM((SALT32.StrType)le.cnp_lowv),TRIM((SALT32.StrType)le.cnp_translated),TRIM((SALT32.StrType)le.cnp_classid),TRIM((SALT32.StrType)le.company_bdid),TRIM((SALT32.StrType)le.company_phone),TRIM((SALT32.StrType)le.company_name),TRIM((SALT32.StrType)le.title),TRIM((SALT32.StrType)le.contact_phone),TRIM((SALT32.StrType)le.contact_email),TRIM((SALT32.StrType)le.contact_job_title_raw),TRIM((SALT32.StrType)le.company_department),TRIM((SALT32.StrType)le.dt_first_seen),TRIM((SALT32.StrType)le.dt_last_seen)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,33,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT32.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 33);
  SELF.FldNo2 := 1 + (C % 33);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT32.StrType)le.cnp_number),TRIM((SALT32.StrType)le.prim_range),TRIM((SALT32.StrType)le.prim_name),TRIM((SALT32.StrType)le.st),TRIM((SALT32.StrType)le.isContact),TRIM((SALT32.StrType)le.contact_ssn),TRIM((SALT32.StrType)le.company_fein),TRIM((SALT32.StrType)le.active_enterprise_number),TRIM((SALT32.StrType)le.active_domestic_corp_key),TRIM((SALT32.StrType)le.cnp_name),TRIM((SALT32.StrType)le.corp_legal_name),TRIM((SALT32.StrType)le.active_duns_number),TRIM((SALT32.StrType)le.zip),TRIM((SALT32.StrType)le.sec_range),TRIM((SALT32.StrType)le.v_city_name),TRIM((SALT32.StrType)le.lname),TRIM((SALT32.StrType)le.mname),TRIM((SALT32.StrType)le.fname),TRIM((SALT32.StrType)le.name_suffix),TRIM((SALT32.StrType)le.cnp_btype),TRIM((SALT32.StrType)le.cnp_lowv),TRIM((SALT32.StrType)le.cnp_translated),TRIM((SALT32.StrType)le.cnp_classid),TRIM((SALT32.StrType)le.company_bdid),TRIM((SALT32.StrType)le.company_phone),TRIM((SALT32.StrType)le.company_name),TRIM((SALT32.StrType)le.title),TRIM((SALT32.StrType)le.contact_phone),TRIM((SALT32.StrType)le.contact_email),TRIM((SALT32.StrType)le.contact_job_title_raw),TRIM((SALT32.StrType)le.company_department),TRIM((SALT32.StrType)le.dt_first_seen),TRIM((SALT32.StrType)le.dt_last_seen)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT32.StrType)le.cnp_number),TRIM((SALT32.StrType)le.prim_range),TRIM((SALT32.StrType)le.prim_name),TRIM((SALT32.StrType)le.st),TRIM((SALT32.StrType)le.isContact),TRIM((SALT32.StrType)le.contact_ssn),TRIM((SALT32.StrType)le.company_fein),TRIM((SALT32.StrType)le.active_enterprise_number),TRIM((SALT32.StrType)le.active_domestic_corp_key),TRIM((SALT32.StrType)le.cnp_name),TRIM((SALT32.StrType)le.corp_legal_name),TRIM((SALT32.StrType)le.active_duns_number),TRIM((SALT32.StrType)le.zip),TRIM((SALT32.StrType)le.sec_range),TRIM((SALT32.StrType)le.v_city_name),TRIM((SALT32.StrType)le.lname),TRIM((SALT32.StrType)le.mname),TRIM((SALT32.StrType)le.fname),TRIM((SALT32.StrType)le.name_suffix),TRIM((SALT32.StrType)le.cnp_btype),TRIM((SALT32.StrType)le.cnp_lowv),TRIM((SALT32.StrType)le.cnp_translated),TRIM((SALT32.StrType)le.cnp_classid),TRIM((SALT32.StrType)le.company_bdid),TRIM((SALT32.StrType)le.company_phone),TRIM((SALT32.StrType)le.company_name),TRIM((SALT32.StrType)le.title),TRIM((SALT32.StrType)le.contact_phone),TRIM((SALT32.StrType)le.contact_email),TRIM((SALT32.StrType)le.contact_job_title_raw),TRIM((SALT32.StrType)le.company_department),TRIM((SALT32.StrType)le.dt_first_seen),TRIM((SALT32.StrType)le.dt_last_seen)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),33*33,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'cnp_number'}
      ,{2,'prim_range'}
      ,{3,'prim_name'}
      ,{4,'st'}
      ,{5,'isContact'}
      ,{6,'contact_ssn'}
      ,{7,'company_fein'}
      ,{8,'active_enterprise_number'}
      ,{9,'active_domestic_corp_key'}
      ,{10,'cnp_name'}
      ,{11,'corp_legal_name'}
      ,{12,'active_duns_number'}
      ,{13,'zip'}
      ,{14,'sec_range'}
      ,{15,'v_city_name'}
      ,{16,'lname'}
      ,{17,'mname'}
      ,{18,'fname'}
      ,{19,'name_suffix'}
      ,{20,'cnp_btype'}
      ,{21,'cnp_lowv'}
      ,{22,'cnp_translated'}
      ,{23,'cnp_classid'}
      ,{24,'company_bdid'}
      ,{25,'company_phone'}
      ,{26,'company_name'}
      ,{27,'title'}
      ,{28,'contact_phone'}
      ,{29,'contact_email'}
      ,{30,'contact_job_title_raw'}
      ,{31,'company_department'}
      ,{32,'dt_first_seen'}
      ,{33,'dt_last_seen'}],SALT32.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT32.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT32.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT32.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source) source; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_cnp_number((SALT32.StrType)le.cnp_number),
    Fields.InValid_prim_range((SALT32.StrType)le.prim_range),
    Fields.InValid_prim_name((SALT32.StrType)le.prim_name),
    Fields.InValid_st((SALT32.StrType)le.st),
    Fields.InValid_isContact((SALT32.StrType)le.isContact),
    Fields.InValid_contact_ssn((SALT32.StrType)le.contact_ssn),
    Fields.InValid_company_fein((SALT32.StrType)le.company_fein),
    Fields.InValid_active_enterprise_number((SALT32.StrType)le.active_enterprise_number),
    Fields.InValid_active_domestic_corp_key((SALT32.StrType)le.active_domestic_corp_key),
    Fields.InValid_cnp_name((SALT32.StrType)le.cnp_name),
    Fields.InValid_corp_legal_name((SALT32.StrType)le.corp_legal_name),
    0, // Uncleanable field
    Fields.InValid_active_duns_number((SALT32.StrType)le.active_duns_number),
    0, // Uncleanable field
    Fields.InValid_zip((SALT32.StrType)le.zip),
    0, // Uncleanable field
    Fields.InValid_sec_range((SALT32.StrType)le.sec_range),
    Fields.InValid_v_city_name((SALT32.StrType)le.v_city_name),
    Fields.InValid_lname((SALT32.StrType)le.lname),
    Fields.InValid_mname((SALT32.StrType)le.mname),
    Fields.InValid_fname((SALT32.StrType)le.fname),
    Fields.InValid_name_suffix((SALT32.StrType)le.name_suffix),
    Fields.InValid_cnp_btype((SALT32.StrType)le.cnp_btype),
    Fields.InValid_cnp_lowv((SALT32.StrType)le.cnp_lowv),
    Fields.InValid_cnp_translated((SALT32.StrType)le.cnp_translated),
    Fields.InValid_cnp_classid((SALT32.StrType)le.cnp_classid),
    Fields.InValid_company_bdid((SALT32.StrType)le.company_bdid),
    Fields.InValid_company_phone((SALT32.StrType)le.company_phone),
    Fields.InValid_company_name((SALT32.StrType)le.company_name),
    Fields.InValid_title((SALT32.StrType)le.title),
    Fields.InValid_contact_phone((SALT32.StrType)le.contact_phone),
    Fields.InValid_contact_email((SALT32.StrType)le.contact_email),
    Fields.InValid_contact_job_title_raw((SALT32.StrType)le.contact_job_title_raw),
    Fields.InValid_company_department((SALT32.StrType)le.company_department),
    Fields.InValid_dt_first_seen((SALT32.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT32.StrType)le.dt_last_seen),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source := le.source;
END;
Errors := NORMALIZE(h,36,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.source;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.source;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','alpha','Unknown','number','Unknown','Unknown','Unknown','multiword','Unknown','Unknown','Unknown','Unknown','number','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','cname','Unknown','Unknown','upper','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_cnp_number(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_isContact(TotalErrors.ErrorNum),Fields.InValidMessage_contact_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_company_fein(TotalErrors.ErrorNum),Fields.InValidMessage_active_enterprise_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_legal_name(TotalErrors.ErrorNum),'',Fields.InValidMessage_active_duns_number(TotalErrors.ErrorNum),'',Fields.InValidMessage_zip(TotalErrors.ErrorNum),'',Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_btype(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_lowv(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_translated(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_classid(TotalErrors.ErrorNum),Fields.InValidMessage_company_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_company_phone(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_contact_phone(TotalErrors.ErrorNum),Fields.InValidMessage_contact_email(TotalErrors.ErrorNum),Fields.InValidMessage_contact_job_title_raw(TotalErrors.ErrorNum),Fields.InValidMessage_company_department(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//Compute field consistencies between sources
  SALT32.mac_srcfrequency_outliers(h,company_name,source,company_name_outliers)
  SALT32.mac_srcfrequency_outliers(h,prim_range,source,prim_range_outliers)
  SALT32.mac_srcfrequency_outliers(h,prim_name,source,prim_name_outliers)
  SALT32.mac_srcfrequency_outliers(h,sec_range,source,sec_range_outliers)
  SALT32.mac_srcfrequency_outliers(h,st,source,st_outliers)
  SALT32.mac_srcfrequency_outliers(h,v_city_name,source,v_city_name_outliers)
  SALT32.mac_srcfrequency_outliers(h,zip,source,zip_outliers)
EXPORT AllOutliers := company_name_outliers + prim_range_outliers + prim_name_outliers + sec_range_outliers + st_outliers + v_city_name_outliers + zip_outliers;
//We have DOTid specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT32.MOD_ClusterStats.Counts(h,DOTid);
EXPORT ClusterSrc := SALT32.MOD_ClusterStats.Sources(h,DOTid,source);
END;
