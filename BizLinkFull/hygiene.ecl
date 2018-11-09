IMPORT SALT37;
EXPORT hygiene(dataset(layout_BizHead) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_parent_proxid_pcnt := AVE(GROUP,IF(h.parent_proxid = (TYPEOF(h.parent_proxid))'',0,100));
    maxlength_parent_proxid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.parent_proxid)));
    avelength_parent_proxid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.parent_proxid)),h.parent_proxid<>(typeof(h.parent_proxid))'');
    populated_sele_proxid_pcnt := AVE(GROUP,IF(h.sele_proxid = (TYPEOF(h.sele_proxid))'',0,100));
    maxlength_sele_proxid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.sele_proxid)));
    avelength_sele_proxid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.sele_proxid)),h.sele_proxid<>(typeof(h.sele_proxid))'');
    populated_org_proxid_pcnt := AVE(GROUP,IF(h.org_proxid = (TYPEOF(h.org_proxid))'',0,100));
    maxlength_org_proxid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.org_proxid)));
    avelength_org_proxid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.org_proxid)),h.org_proxid<>(typeof(h.org_proxid))'');
    populated_ultimate_proxid_pcnt := AVE(GROUP,IF(h.ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',0,100));
    maxlength_ultimate_proxid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultimate_proxid)));
    avelength_ultimate_proxid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultimate_proxid)),h.ultimate_proxid<>(typeof(h.ultimate_proxid))'');
    populated_has_lgid_pcnt := AVE(GROUP,IF(h.has_lgid = (TYPEOF(h.has_lgid))'',0,100));
    maxlength_has_lgid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.has_lgid)));
    avelength_has_lgid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.has_lgid)),h.has_lgid<>(typeof(h.has_lgid))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_source_record_id_pcnt := AVE(GROUP,IF(h.source_record_id = (TYPEOF(h.source_record_id))'',0,100));
    maxlength_source_record_id := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_record_id)));
    avelength_source_record_id := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_record_id)),h.source_record_id<>(typeof(h.source_record_id))'');
    populated_source_docid_pcnt := AVE(GROUP,IF(h.source_docid = (TYPEOF(h.source_docid))'',0,100));
    maxlength_source_docid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_docid)));
    avelength_source_docid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_docid)),h.source_docid<>(typeof(h.source_docid))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_company_name_prefix_pcnt := AVE(GROUP,IF(h.company_name_prefix = (TYPEOF(h.company_name_prefix))'',0,100));
    maxlength_company_name_prefix := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_name_prefix)));
    avelength_company_name_prefix := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_name_prefix)),h.company_name_prefix<>(typeof(h.company_name_prefix))'');
    populated_cnp_name_pcnt := AVE(GROUP,IF(h.cnp_name = (TYPEOF(h.cnp_name))'',0,100));
    maxlength_cnp_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.cnp_name)));
    avelength_cnp_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.cnp_name)),h.cnp_name<>(typeof(h.cnp_name))'');
    populated_cnp_number_pcnt := AVE(GROUP,IF(h.cnp_number = (TYPEOF(h.cnp_number))'',0,100));
    maxlength_cnp_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.cnp_number)));
    avelength_cnp_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.cnp_number)),h.cnp_number<>(typeof(h.cnp_number))'');
    populated_cnp_btype_pcnt := AVE(GROUP,IF(h.cnp_btype = (TYPEOF(h.cnp_btype))'',0,100));
    maxlength_cnp_btype := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.cnp_btype)));
    avelength_cnp_btype := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.cnp_btype)),h.cnp_btype<>(typeof(h.cnp_btype))'');
    populated_cnp_lowv_pcnt := AVE(GROUP,IF(h.cnp_lowv = (TYPEOF(h.cnp_lowv))'',0,100));
    maxlength_cnp_lowv := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.cnp_lowv)));
    avelength_cnp_lowv := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.cnp_lowv)),h.cnp_lowv<>(typeof(h.cnp_lowv))'');
    populated_company_phone_pcnt := AVE(GROUP,IF(h.company_phone = (TYPEOF(h.company_phone))'',0,100));
    maxlength_company_phone := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_phone)));
    avelength_company_phone := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_phone)),h.company_phone<>(typeof(h.company_phone))'');
    populated_company_phone_3_pcnt := AVE(GROUP,IF(h.company_phone_3 = (TYPEOF(h.company_phone_3))'',0,100));
    maxlength_company_phone_3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_phone_3)));
    avelength_company_phone_3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_phone_3)),h.company_phone_3<>(typeof(h.company_phone_3))'');
    populated_company_phone_3_ex_pcnt := AVE(GROUP,IF(h.company_phone_3_ex = (TYPEOF(h.company_phone_3_ex))'',0,100));
    maxlength_company_phone_3_ex := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_phone_3_ex)));
    avelength_company_phone_3_ex := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_phone_3_ex)),h.company_phone_3_ex<>(typeof(h.company_phone_3_ex))'');
    populated_company_phone_7_pcnt := AVE(GROUP,IF(h.company_phone_7 = (TYPEOF(h.company_phone_7))'',0,100));
    maxlength_company_phone_7 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_phone_7)));
    avelength_company_phone_7 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_phone_7)),h.company_phone_7<>(typeof(h.company_phone_7))'');
    populated_company_fein_pcnt := AVE(GROUP,IF(h.company_fein = (TYPEOF(h.company_fein))'',0,100));
    maxlength_company_fein := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_fein)));
    avelength_company_fein := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_fein)),h.company_fein<>(typeof(h.company_fein))'');
    populated_company_sic_code1_pcnt := AVE(GROUP,IF(h.company_sic_code1 = (TYPEOF(h.company_sic_code1))'',0,100));
    maxlength_company_sic_code1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_sic_code1)));
    avelength_company_sic_code1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_sic_code1)),h.company_sic_code1<>(typeof(h.company_sic_code1))'');
    populated_active_duns_number_pcnt := AVE(GROUP,IF(h.active_duns_number = (TYPEOF(h.active_duns_number))'',0,100));
    maxlength_active_duns_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.active_duns_number)));
    avelength_active_duns_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.active_duns_number)),h.active_duns_number<>(typeof(h.active_duns_number))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_city_clean_pcnt := AVE(GROUP,IF(h.city_clean = (TYPEOF(h.city_clean))'',0,100));
    maxlength_city_clean := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.city_clean)));
    avelength_city_clean := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.city_clean)),h.city_clean<>(typeof(h.city_clean))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_company_url_pcnt := AVE(GROUP,IF(h.company_url = (TYPEOF(h.company_url))'',0,100));
    maxlength_company_url := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_url)));
    avelength_company_url := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_url)),h.company_url<>(typeof(h.company_url))'');
    populated_isContact_pcnt := AVE(GROUP,IF(h.isContact = (TYPEOF(h.isContact))'',0,100));
    maxlength_isContact := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.isContact)));
    avelength_isContact := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.isContact)),h.isContact<>(typeof(h.isContact))'');
    populated_contact_did_pcnt := AVE(GROUP,IF(h.contact_did = (TYPEOF(h.contact_did))'',0,100));
    maxlength_contact_did := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.contact_did)));
    avelength_contact_did := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.contact_did)),h.contact_did<>(typeof(h.contact_did))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_fname_preferred_pcnt := AVE(GROUP,IF(h.fname_preferred = (TYPEOF(h.fname_preferred))'',0,100));
    maxlength_fname_preferred := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fname_preferred)));
    avelength_fname_preferred := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fname_preferred)),h.fname_preferred<>(typeof(h.fname_preferred))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_contact_ssn_pcnt := AVE(GROUP,IF(h.contact_ssn = (TYPEOF(h.contact_ssn))'',0,100));
    maxlength_contact_ssn := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.contact_ssn)));
    avelength_contact_ssn := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.contact_ssn)),h.contact_ssn<>(typeof(h.contact_ssn))'');
    populated_contact_email_pcnt := AVE(GROUP,IF(h.contact_email = (TYPEOF(h.contact_email))'',0,100));
    maxlength_contact_email := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.contact_email)));
    avelength_contact_email := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.contact_email)),h.contact_email<>(typeof(h.contact_email))'');
    populated_sele_flag_pcnt := AVE(GROUP,IF(h.sele_flag = (TYPEOF(h.sele_flag))'',0,100));
    maxlength_sele_flag := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.sele_flag)));
    avelength_sele_flag := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.sele_flag)),h.sele_flag<>(typeof(h.sele_flag))'');
    populated_org_flag_pcnt := AVE(GROUP,IF(h.org_flag = (TYPEOF(h.org_flag))'',0,100));
    maxlength_org_flag := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.org_flag)));
    avelength_org_flag := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.org_flag)),h.org_flag<>(typeof(h.org_flag))'');
    populated_ult_flag_pcnt := AVE(GROUP,IF(h.ult_flag = (TYPEOF(h.ult_flag))'',0,100));
    maxlength_ult_flag := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ult_flag)));
    avelength_ult_flag := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ult_flag)),h.ult_flag<>(typeof(h.ult_flag))'');
    populated_fallback_value_pcnt := AVE(GROUP,IF(h.fallback_value = (TYPEOF(h.fallback_value))'',0,100));
    maxlength_fallback_value := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fallback_value)));
    avelength_fallback_value := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fallback_value)),h.fallback_value<>(typeof(h.fallback_value))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_parent_proxid_pcnt *  28.00 / 100 + T.Populated_sele_proxid_pcnt *  28.00 / 100 + T.Populated_org_proxid_pcnt *  28.00 / 100 + T.Populated_ultimate_proxid_pcnt *  28.00 / 100 + T.Populated_has_lgid_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   4.00 / 100 + T.Populated_source_record_id_pcnt *  27.00 / 100 + T.Populated_source_docid_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *  25.00 / 100 + T.Populated_company_name_prefix_pcnt *  14.00 / 100 + T.Populated_cnp_name_pcnt *  25.00 / 100 + T.Populated_cnp_number_pcnt *  13.00 / 100 + T.Populated_cnp_btype_pcnt *   3.00 / 100 + T.Populated_cnp_lowv_pcnt *   5.00 / 100 + T.Populated_company_phone_pcnt *   0.00 / 100 + T.Populated_company_phone_3_pcnt *   9.00 / 100 + T.Populated_company_phone_3_ex_pcnt *   9.00 / 100 + T.Populated_company_phone_7_pcnt *  23.00 / 100 + T.Populated_company_fein_pcnt *  25.00 / 100 + T.Populated_company_sic_code1_pcnt *  10.00 / 100 + T.Populated_active_duns_number_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *  13.00 / 100 + T.Populated_prim_name_pcnt *  14.00 / 100 + T.Populated_sec_range_pcnt *  12.00 / 100 + T.Populated_city_pcnt *  11.00 / 100 + T.Populated_city_clean_pcnt *  11.00 / 100 + T.Populated_st_pcnt *   5.00 / 100 + T.Populated_zip_pcnt *  14.00 / 100 + T.Populated_company_url_pcnt *  27.00 / 100 + T.Populated_isContact_pcnt *   1.00 / 100 + T.Populated_contact_did_pcnt *  25.00 / 100 + T.Populated_title_pcnt *   1.00 / 100 + T.Populated_fname_pcnt *   8.00 / 100 + T.Populated_fname_preferred_pcnt *   9.00 / 100 + T.Populated_mname_pcnt *   9.00 / 100 + T.Populated_lname_pcnt *  10.00 / 100 + T.Populated_name_suffix_pcnt *   8.00 / 100 + T.Populated_contact_ssn_pcnt *  27.00 / 100 + T.Populated_contact_email_pcnt *  27.00 / 100 + T.Populated_sele_flag_pcnt *   0.00 / 100 + T.Populated_org_flag_pcnt *   0.00 / 100 + T.Populated_ult_flag_pcnt *   0.00 / 100 + T.Populated_fallback_value_pcnt *   1.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT37.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'parent_proxid','sele_proxid','org_proxid','ultimate_proxid','has_lgid','empid','source','source_record_id','source_docid','company_name','company_name_prefix','cnp_name','cnp_number','cnp_btype','cnp_lowv','company_phone','company_phone_3','company_phone_3_ex','company_phone_7','company_fein','company_sic_code1','active_duns_number','prim_range','prim_name','sec_range','city','city_clean','st','zip','company_url','isContact','contact_did','title','fname','fname_preferred','mname','lname','name_suffix','contact_ssn','contact_email','sele_flag','org_flag','ult_flag','fallback_value');
  SELF.populated_pcnt := CHOOSE(C,le.populated_parent_proxid_pcnt,le.populated_sele_proxid_pcnt,le.populated_org_proxid_pcnt,le.populated_ultimate_proxid_pcnt,le.populated_has_lgid_pcnt,le.populated_empid_pcnt,le.populated_source_pcnt,le.populated_source_record_id_pcnt,le.populated_source_docid_pcnt,le.populated_company_name_pcnt,le.populated_company_name_prefix_pcnt,le.populated_cnp_name_pcnt,le.populated_cnp_number_pcnt,le.populated_cnp_btype_pcnt,le.populated_cnp_lowv_pcnt,le.populated_company_phone_pcnt,le.populated_company_phone_3_pcnt,le.populated_company_phone_3_ex_pcnt,le.populated_company_phone_7_pcnt,le.populated_company_fein_pcnt,le.populated_company_sic_code1_pcnt,le.populated_active_duns_number_pcnt,le.populated_prim_range_pcnt,le.populated_prim_name_pcnt,le.populated_sec_range_pcnt,le.populated_city_pcnt,le.populated_city_clean_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_company_url_pcnt,le.populated_isContact_pcnt,le.populated_contact_did_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_fname_preferred_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_contact_ssn_pcnt,le.populated_contact_email_pcnt,le.populated_sele_flag_pcnt,le.populated_org_flag_pcnt,le.populated_ult_flag_pcnt,le.populated_fallback_value_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_parent_proxid,le.maxlength_sele_proxid,le.maxlength_org_proxid,le.maxlength_ultimate_proxid,le.maxlength_has_lgid,le.maxlength_empid,le.maxlength_source,le.maxlength_source_record_id,le.maxlength_source_docid,le.maxlength_company_name,le.maxlength_company_name_prefix,le.maxlength_cnp_name,le.maxlength_cnp_number,le.maxlength_cnp_btype,le.maxlength_cnp_lowv,le.maxlength_company_phone,le.maxlength_company_phone_3,le.maxlength_company_phone_3_ex,le.maxlength_company_phone_7,le.maxlength_company_fein,le.maxlength_company_sic_code1,le.maxlength_active_duns_number,le.maxlength_prim_range,le.maxlength_prim_name,le.maxlength_sec_range,le.maxlength_city,le.maxlength_city_clean,le.maxlength_st,le.maxlength_zip,le.maxlength_company_url,le.maxlength_isContact,le.maxlength_contact_did,le.maxlength_title,le.maxlength_fname,le.maxlength_fname_preferred,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_contact_ssn,le.maxlength_contact_email,le.maxlength_sele_flag,le.maxlength_org_flag,le.maxlength_ult_flag,le.maxlength_fallback_value);
  SELF.avelength := CHOOSE(C,le.avelength_parent_proxid,le.avelength_sele_proxid,le.avelength_org_proxid,le.avelength_ultimate_proxid,le.avelength_has_lgid,le.avelength_empid,le.avelength_source,le.avelength_source_record_id,le.avelength_source_docid,le.avelength_company_name,le.avelength_company_name_prefix,le.avelength_cnp_name,le.avelength_cnp_number,le.avelength_cnp_btype,le.avelength_cnp_lowv,le.avelength_company_phone,le.avelength_company_phone_3,le.avelength_company_phone_3_ex,le.avelength_company_phone_7,le.avelength_company_fein,le.avelength_company_sic_code1,le.avelength_active_duns_number,le.avelength_prim_range,le.avelength_prim_name,le.avelength_sec_range,le.avelength_city,le.avelength_city_clean,le.avelength_st,le.avelength_zip,le.avelength_company_url,le.avelength_isContact,le.avelength_contact_did,le.avelength_title,le.avelength_fname,le.avelength_fname_preferred,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_contact_ssn,le.avelength_contact_email,le.avelength_sele_flag,le.avelength_org_flag,le.avelength_ult_flag,le.avelength_fallback_value);
END;
EXPORT invSummary := NORMALIZE(summary0, 44, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.proxid;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.parent_proxid),TRIM((SALT37.StrType)le.sele_proxid),TRIM((SALT37.StrType)le.org_proxid),TRIM((SALT37.StrType)le.ultimate_proxid),TRIM((SALT37.StrType)le.has_lgid),TRIM((SALT37.StrType)le.empid),TRIM((SALT37.StrType)le.source),TRIM((SALT37.StrType)le.source_record_id),TRIM((SALT37.StrType)le.source_docid),TRIM((SALT37.StrType)le.company_name),TRIM((SALT37.StrType)le.company_name_prefix),TRIM((SALT37.StrType)le.cnp_name),TRIM((SALT37.StrType)le.cnp_number),TRIM((SALT37.StrType)le.cnp_btype),TRIM((SALT37.StrType)le.cnp_lowv),TRIM((SALT37.StrType)le.company_phone),TRIM((SALT37.StrType)le.company_phone_3),TRIM((SALT37.StrType)le.company_phone_3_ex),TRIM((SALT37.StrType)le.company_phone_7),TRIM((SALT37.StrType)le.company_fein),TRIM((SALT37.StrType)le.company_sic_code1),TRIM((SALT37.StrType)le.active_duns_number),TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.sec_range),TRIM((SALT37.StrType)le.city),TRIM((SALT37.StrType)le.city_clean),TRIM((SALT37.StrType)le.st),TRIM((SALT37.StrType)le.zip),TRIM((SALT37.StrType)le.company_url),TRIM((SALT37.StrType)le.isContact),TRIM((SALT37.StrType)le.contact_did),TRIM((SALT37.StrType)le.title),TRIM((SALT37.StrType)le.fname),TRIM((SALT37.StrType)le.fname_preferred),TRIM((SALT37.StrType)le.mname),TRIM((SALT37.StrType)le.lname),TRIM((SALT37.StrType)le.name_suffix),TRIM((SALT37.StrType)le.contact_ssn),TRIM((SALT37.StrType)le.contact_email),TRIM((SALT37.StrType)le.sele_flag),TRIM((SALT37.StrType)le.org_flag),TRIM((SALT37.StrType)le.ult_flag),TRIM((SALT37.StrType)le.fallback_value)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,44,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 44);
  SELF.FldNo2 := 1 + (C % 44);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.parent_proxid),TRIM((SALT37.StrType)le.sele_proxid),TRIM((SALT37.StrType)le.org_proxid),TRIM((SALT37.StrType)le.ultimate_proxid),TRIM((SALT37.StrType)le.has_lgid),TRIM((SALT37.StrType)le.empid),TRIM((SALT37.StrType)le.source),TRIM((SALT37.StrType)le.source_record_id),TRIM((SALT37.StrType)le.source_docid),TRIM((SALT37.StrType)le.company_name),TRIM((SALT37.StrType)le.company_name_prefix),TRIM((SALT37.StrType)le.cnp_name),TRIM((SALT37.StrType)le.cnp_number),TRIM((SALT37.StrType)le.cnp_btype),TRIM((SALT37.StrType)le.cnp_lowv),TRIM((SALT37.StrType)le.company_phone),TRIM((SALT37.StrType)le.company_phone_3),TRIM((SALT37.StrType)le.company_phone_3_ex),TRIM((SALT37.StrType)le.company_phone_7),TRIM((SALT37.StrType)le.company_fein),TRIM((SALT37.StrType)le.company_sic_code1),TRIM((SALT37.StrType)le.active_duns_number),TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.sec_range),TRIM((SALT37.StrType)le.city),TRIM((SALT37.StrType)le.city_clean),TRIM((SALT37.StrType)le.st),TRIM((SALT37.StrType)le.zip),TRIM((SALT37.StrType)le.company_url),TRIM((SALT37.StrType)le.isContact),TRIM((SALT37.StrType)le.contact_did),TRIM((SALT37.StrType)le.title),TRIM((SALT37.StrType)le.fname),TRIM((SALT37.StrType)le.fname_preferred),TRIM((SALT37.StrType)le.mname),TRIM((SALT37.StrType)le.lname),TRIM((SALT37.StrType)le.name_suffix),TRIM((SALT37.StrType)le.contact_ssn),TRIM((SALT37.StrType)le.contact_email),TRIM((SALT37.StrType)le.sele_flag),TRIM((SALT37.StrType)le.org_flag),TRIM((SALT37.StrType)le.ult_flag),TRIM((SALT37.StrType)le.fallback_value)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.parent_proxid),TRIM((SALT37.StrType)le.sele_proxid),TRIM((SALT37.StrType)le.org_proxid),TRIM((SALT37.StrType)le.ultimate_proxid),TRIM((SALT37.StrType)le.has_lgid),TRIM((SALT37.StrType)le.empid),TRIM((SALT37.StrType)le.source),TRIM((SALT37.StrType)le.source_record_id),TRIM((SALT37.StrType)le.source_docid),TRIM((SALT37.StrType)le.company_name),TRIM((SALT37.StrType)le.company_name_prefix),TRIM((SALT37.StrType)le.cnp_name),TRIM((SALT37.StrType)le.cnp_number),TRIM((SALT37.StrType)le.cnp_btype),TRIM((SALT37.StrType)le.cnp_lowv),TRIM((SALT37.StrType)le.company_phone),TRIM((SALT37.StrType)le.company_phone_3),TRIM((SALT37.StrType)le.company_phone_3_ex),TRIM((SALT37.StrType)le.company_phone_7),TRIM((SALT37.StrType)le.company_fein),TRIM((SALT37.StrType)le.company_sic_code1),TRIM((SALT37.StrType)le.active_duns_number),TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.sec_range),TRIM((SALT37.StrType)le.city),TRIM((SALT37.StrType)le.city_clean),TRIM((SALT37.StrType)le.st),TRIM((SALT37.StrType)le.zip),TRIM((SALT37.StrType)le.company_url),TRIM((SALT37.StrType)le.isContact),TRIM((SALT37.StrType)le.contact_did),TRIM((SALT37.StrType)le.title),TRIM((SALT37.StrType)le.fname),TRIM((SALT37.StrType)le.fname_preferred),TRIM((SALT37.StrType)le.mname),TRIM((SALT37.StrType)le.lname),TRIM((SALT37.StrType)le.name_suffix),TRIM((SALT37.StrType)le.contact_ssn),TRIM((SALT37.StrType)le.contact_email),TRIM((SALT37.StrType)le.sele_flag),TRIM((SALT37.StrType)le.org_flag),TRIM((SALT37.StrType)le.ult_flag),TRIM((SALT37.StrType)le.fallback_value)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config_BIP.CorrelateSampleSize),44*44,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'parent_proxid'}
      ,{2,'sele_proxid'}
      ,{3,'org_proxid'}
      ,{4,'ultimate_proxid'}
      ,{5,'has_lgid'}
      ,{6,'empid'}
      ,{7,'source'}
      ,{8,'source_record_id'}
      ,{9,'source_docid'}
      ,{10,'company_name'}
      ,{11,'company_name_prefix'}
      ,{12,'cnp_name'}
      ,{13,'cnp_number'}
      ,{14,'cnp_btype'}
      ,{15,'cnp_lowv'}
      ,{16,'company_phone'}
      ,{17,'company_phone_3'}
      ,{18,'company_phone_3_ex'}
      ,{19,'company_phone_7'}
      ,{20,'company_fein'}
      ,{21,'company_sic_code1'}
      ,{22,'active_duns_number'}
      ,{23,'prim_range'}
      ,{24,'prim_name'}
      ,{25,'sec_range'}
      ,{26,'city'}
      ,{27,'city_clean'}
      ,{28,'st'}
      ,{29,'zip'}
      ,{30,'company_url'}
      ,{31,'isContact'}
      ,{32,'contact_did'}
      ,{33,'title'}
      ,{34,'fname'}
      ,{35,'fname_preferred'}
      ,{36,'mname'}
      ,{37,'lname'}
      ,{38,'name_suffix'}
      ,{39,'contact_ssn'}
      ,{40,'contact_email'}
      ,{41,'sele_flag'}
      ,{42,'org_flag'}
      ,{43,'ult_flag'}
      ,{44,'fallback_value'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_parent_proxid((SALT37.StrType)le.parent_proxid),
    Fields.InValid_sele_proxid((SALT37.StrType)le.sele_proxid),
    Fields.InValid_org_proxid((SALT37.StrType)le.org_proxid),
    Fields.InValid_ultimate_proxid((SALT37.StrType)le.ultimate_proxid),
    Fields.InValid_has_lgid((SALT37.StrType)le.has_lgid),
    Fields.InValid_empid((SALT37.StrType)le.empid),
    Fields.InValid_source((SALT37.StrType)le.source),
    Fields.InValid_source_record_id((SALT37.StrType)le.source_record_id),
    Fields.InValid_source_docid((SALT37.StrType)le.source_docid),
    Fields.InValid_company_name((SALT37.StrType)le.company_name),
    Fields.InValid_company_name_prefix((SALT37.StrType)le.company_name_prefix),
    Fields.InValid_cnp_name((SALT37.StrType)le.cnp_name),
    Fields.InValid_cnp_number((SALT37.StrType)le.cnp_number),
    Fields.InValid_cnp_btype((SALT37.StrType)le.cnp_btype),
    Fields.InValid_cnp_lowv((SALT37.StrType)le.cnp_lowv),
    Fields.InValid_company_phone((SALT37.StrType)le.company_phone),
    Fields.InValid_company_phone_3((SALT37.StrType)le.company_phone_3),
    Fields.InValid_company_phone_3_ex((SALT37.StrType)le.company_phone_3_ex),
    Fields.InValid_company_phone_7((SALT37.StrType)le.company_phone_7),
    Fields.InValid_company_fein((SALT37.StrType)le.company_fein),
    Fields.InValid_company_sic_code1((SALT37.StrType)le.company_sic_code1),
    Fields.InValid_active_duns_number((SALT37.StrType)le.active_duns_number),
    Fields.InValid_prim_range((SALT37.StrType)le.prim_range),
    Fields.InValid_prim_name((SALT37.StrType)le.prim_name),
    Fields.InValid_sec_range((SALT37.StrType)le.sec_range),
    Fields.InValid_city((SALT37.StrType)le.city),
    Fields.InValid_city_clean((SALT37.StrType)le.city_clean),
    Fields.InValid_st((SALT37.StrType)le.st),
    Fields.InValid_zip((SALT37.StrType)le.zip),
    Fields.InValid_company_url((SALT37.StrType)le.company_url),
    Fields.InValid_isContact((SALT37.StrType)le.isContact),
    Fields.InValid_contact_did((SALT37.StrType)le.contact_did),
    Fields.InValid_title((SALT37.StrType)le.title),
    Fields.InValid_fname((SALT37.StrType)le.fname),
    Fields.InValid_fname_preferred((SALT37.StrType)le.fname_preferred),
    Fields.InValid_mname((SALT37.StrType)le.mname),
    Fields.InValid_lname((SALT37.StrType)le.lname),
    Fields.InValid_name_suffix((SALT37.StrType)le.name_suffix),
    Fields.InValid_contact_ssn((SALT37.StrType)le.contact_ssn),
    Fields.InValid_contact_email((SALT37.StrType)le.contact_email),
    Fields.InValid_sele_flag((SALT37.StrType)le.sele_flag),
    Fields.InValid_org_flag((SALT37.StrType)le.org_flag),
    Fields.InValid_ult_flag((SALT37.StrType)le.ult_flag),
    Fields.InValid_fallback_value((SALT37.StrType)le.fallback_value),
    0, // Uncleanable field
    0, // Uncleanable field
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,46,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','T_ALPHANUM','T_ALPHANUM','T_ALPHANUM','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','T_FEIN','Unknown','Unknown','Unknown','T_ALPHANUM','T_ALPHANUM','T_ALPHANUM','T_ALPHANUM','T_ALPHA','T_NUMBER','T_ALPHANUM','Unknown','Unknown','Unknown','T_ALPHANUM','T_ALPHANUM','T_ALPHANUM','T_ALPHANUM','T_ALPHANUM','Unknown','T_ALLCAPS','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_parent_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_sele_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_org_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_ultimate_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_has_lgid(TotalErrors.ErrorNum),Fields.InValidMessage_empid(TotalErrors.ErrorNum),Fields.InValidMessage_source(TotalErrors.ErrorNum),Fields.InValidMessage_source_record_id(TotalErrors.ErrorNum),Fields.InValidMessage_source_docid(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_company_name_prefix(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_name(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_number(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_btype(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_lowv(TotalErrors.ErrorNum),Fields.InValidMessage_company_phone(TotalErrors.ErrorNum),Fields.InValidMessage_company_phone_3(TotalErrors.ErrorNum),Fields.InValidMessage_company_phone_3_ex(TotalErrors.ErrorNum),Fields.InValidMessage_company_phone_7(TotalErrors.ErrorNum),Fields.InValidMessage_company_fein(TotalErrors.ErrorNum),Fields.InValidMessage_company_sic_code1(TotalErrors.ErrorNum),Fields.InValidMessage_active_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_city_clean(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_company_url(TotalErrors.ErrorNum),Fields.InValidMessage_isContact(TotalErrors.ErrorNum),Fields.InValidMessage_contact_did(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_fname_preferred(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_contact_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_contact_email(TotalErrors.ErrorNum),Fields.InValidMessage_sele_flag(TotalErrors.ErrorNum),Fields.InValidMessage_org_flag(TotalErrors.ErrorNum),Fields.InValidMessage_ult_flag(TotalErrors.ErrorNum),Fields.InValidMessage_fallback_value(TotalErrors.ErrorNum),'','');
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
//We have proxid specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT37.MOD_ClusterStats.Counts(h,proxid);
END;
