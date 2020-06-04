IMPORT ut,SALT30;
EXPORT hygiene(dataset(layout_EmpID) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT30.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.source);    NumberOfRecords := COUNT(GROUP);
    populated_isCorpEnhanced_pcnt := AVE(GROUP,IF(h.isCorpEnhanced = (TYPEOF(h.isCorpEnhanced))'',0,100));
    maxlength_isCorpEnhanced := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.isCorpEnhanced)));
    avelength_isCorpEnhanced := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.isCorpEnhanced)),h.isCorpEnhanced<>(typeof(h.isCorpEnhanced))'');
    populated_contact_job_title_derived_pcnt := AVE(GROUP,IF(h.contact_job_title_derived = (TYPEOF(h.contact_job_title_derived))'',0,100));
    maxlength_contact_job_title_derived := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contact_job_title_derived)));
    avelength_contact_job_title_derived := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contact_job_title_derived)),h.contact_job_title_derived<>(typeof(h.contact_job_title_derived))'');
    populated_cname_devanitize_pcnt := AVE(GROUP,IF(h.cname_devanitize = (TYPEOF(h.cname_devanitize))'',0,100));
    maxlength_cname_devanitize := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cname_devanitize)));
    avelength_cname_devanitize := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cname_devanitize)),h.cname_devanitize<>(typeof(h.cname_devanitize))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_contact_phone_pcnt := AVE(GROUP,IF(h.contact_phone = (TYPEOF(h.contact_phone))'',0,100));
    maxlength_contact_phone := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contact_phone)));
    avelength_contact_phone := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contact_phone)),h.contact_phone<>(typeof(h.contact_phone))'');
    populated_contact_did_pcnt := AVE(GROUP,IF(h.contact_did = (TYPEOF(h.contact_did))'',0,100));
    maxlength_contact_did := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contact_did)));
    avelength_contact_did := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contact_did)),h.contact_did<>(typeof(h.contact_did))'');
    populated_contact_ssn_pcnt := AVE(GROUP,IF(h.contact_ssn = (TYPEOF(h.contact_ssn))'',0,100));
    maxlength_contact_ssn := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contact_ssn)));
    avelength_contact_ssn := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contact_ssn)),h.contact_ssn<>(typeof(h.contact_ssn))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_company_inc_state_pcnt := AVE(GROUP,IF(h.company_inc_state = (TYPEOF(h.company_inc_state))'',0,100));
    maxlength_company_inc_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_inc_state)));
    avelength_company_inc_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_inc_state)),h.company_inc_state<>(typeof(h.company_inc_state))'');
    populated_company_charter_number_pcnt := AVE(GROUP,IF(h.company_charter_number = (TYPEOF(h.company_charter_number))'',0,100));
    maxlength_company_charter_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_charter_number)));
    avelength_company_charter_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_charter_number)),h.company_charter_number<>(typeof(h.company_charter_number))'');
    populated_active_duns_number_pcnt := AVE(GROUP,IF(h.active_duns_number = (TYPEOF(h.active_duns_number))'',0,100));
    maxlength_active_duns_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.active_duns_number)));
    avelength_active_duns_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.active_duns_number)),h.active_duns_number<>(typeof(h.active_duns_number))'');
    populated_hist_duns_number_pcnt := AVE(GROUP,IF(h.hist_duns_number = (TYPEOF(h.hist_duns_number))'',0,100));
    maxlength_hist_duns_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hist_duns_number)));
    avelength_hist_duns_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hist_duns_number)),h.hist_duns_number<>(typeof(h.hist_duns_number))'');
    populated_active_domestic_corp_key_pcnt := AVE(GROUP,IF(h.active_domestic_corp_key = (TYPEOF(h.active_domestic_corp_key))'',0,100));
    maxlength_active_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.active_domestic_corp_key)));
    avelength_active_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.active_domestic_corp_key)),h.active_domestic_corp_key<>(typeof(h.active_domestic_corp_key))'');
    populated_hist_domestic_corp_key_pcnt := AVE(GROUP,IF(h.hist_domestic_corp_key = (TYPEOF(h.hist_domestic_corp_key))'',0,100));
    maxlength_hist_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hist_domestic_corp_key)));
    avelength_hist_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hist_domestic_corp_key)),h.hist_domestic_corp_key<>(typeof(h.hist_domestic_corp_key))'');
    populated_foreign_corp_key_pcnt := AVE(GROUP,IF(h.foreign_corp_key = (TYPEOF(h.foreign_corp_key))'',0,100));
    maxlength_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.foreign_corp_key)));
    avelength_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.foreign_corp_key)),h.foreign_corp_key<>(typeof(h.foreign_corp_key))'');
    populated_unk_corp_key_pcnt := AVE(GROUP,IF(h.unk_corp_key = (TYPEOF(h.unk_corp_key))'',0,100));
    maxlength_unk_corp_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unk_corp_key)));
    avelength_unk_corp_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unk_corp_key)),h.unk_corp_key<>(typeof(h.unk_corp_key))'');
    populated_company_fein_pcnt := AVE(GROUP,IF(h.company_fein = (TYPEOF(h.company_fein))'',0,100));
    maxlength_company_fein := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_fein)));
    avelength_company_fein := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_fein)),h.company_fein<>(typeof(h.company_fein))'');
    populated_cnp_btype_pcnt := AVE(GROUP,IF(h.cnp_btype = (TYPEOF(h.cnp_btype))'',0,100));
    maxlength_cnp_btype := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_btype)));
    avelength_cnp_btype := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_btype)),h.cnp_btype<>(typeof(h.cnp_btype))'');
    populated_cnp_name_pcnt := AVE(GROUP,IF(h.cnp_name = (TYPEOF(h.cnp_name))'',0,100));
    maxlength_cnp_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_name)));
    avelength_cnp_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_name)),h.cnp_name<>(typeof(h.cnp_name))'');
    populated_company_name_type_derived_pcnt := AVE(GROUP,IF(h.company_name_type_derived = (TYPEOF(h.company_name_type_derived))'',0,100));
    maxlength_company_name_type_derived := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_name_type_derived)));
    avelength_company_name_type_derived := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_name_type_derived)),h.company_name_type_derived<>(typeof(h.company_name_type_derived))'');
    populated_company_bdid_pcnt := AVE(GROUP,IF(h.company_bdid = (TYPEOF(h.company_bdid))'',0,100));
    maxlength_company_bdid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_bdid)));
    avelength_company_bdid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_bdid)),h.company_bdid<>(typeof(h.company_bdid))'');
    populated_nodes_total_pcnt := AVE(GROUP,IF(h.nodes_total = (TYPEOF(h.nodes_total))'',0,100));
    maxlength_nodes_total := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.nodes_total)));
    avelength_nodes_total := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.nodes_total)),h.nodes_total<>(typeof(h.nodes_total))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_isCorpEnhanced_pcnt *   0.00 / 100 + T.Populated_contact_job_title_derived_pcnt *   0.00 / 100 + T.Populated_cname_devanitize_pcnt *  20.00 / 100 + T.Populated_prim_range_pcnt *  13.00 / 100 + T.Populated_prim_name_pcnt *  15.00 / 100 + T.Populated_zip_pcnt *  14.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   8.00 / 100 + T.Populated_lname_pcnt *  15.00 / 100 + T.Populated_contact_phone_pcnt *  24.00 / 100 + T.Populated_contact_did_pcnt *  24.00 / 100 + T.Populated_contact_ssn_pcnt *   4.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_company_inc_state_pcnt *   0.00 / 100 + T.Populated_company_charter_number_pcnt *   0.00 / 100 + T.Populated_active_duns_number_pcnt *   0.00 / 100 + T.Populated_hist_duns_number_pcnt *   0.00 / 100 + T.Populated_active_domestic_corp_key_pcnt *   0.00 / 100 + T.Populated_hist_domestic_corp_key_pcnt *   0.00 / 100 + T.Populated_foreign_corp_key_pcnt *   0.00 / 100 + T.Populated_unk_corp_key_pcnt *   0.00 / 100 + T.Populated_company_fein_pcnt *   0.00 / 100 + T.Populated_cnp_btype_pcnt *   0.00 / 100 + T.Populated_cnp_name_pcnt *   0.00 / 100 + T.Populated_company_name_type_derived_pcnt *   0.00 / 100 + T.Populated_company_bdid_pcnt *   0.00 / 100 + T.Populated_nodes_total_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100;
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
    SELF.LinkingPotential := 0 + le.Populated_isCorpEnhanced_pcnt*ri.Populated_isCorpEnhanced_pcnt *   0.00 / 10000 + le.Populated_contact_job_title_derived_pcnt*ri.Populated_contact_job_title_derived_pcnt *   0.00 / 10000 + le.Populated_cname_devanitize_pcnt*ri.Populated_cname_devanitize_pcnt *  20.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *  13.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *  15.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *  14.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   8.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *  15.00 / 10000 + le.Populated_contact_phone_pcnt*ri.Populated_contact_phone_pcnt *  24.00 / 10000 + le.Populated_contact_did_pcnt*ri.Populated_contact_did_pcnt *  24.00 / 10000 + le.Populated_contact_ssn_pcnt*ri.Populated_contact_ssn_pcnt *   4.00 / 10000 + le.Populated_company_name_pcnt*ri.Populated_company_name_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_company_inc_state_pcnt*ri.Populated_company_inc_state_pcnt *   0.00 / 10000 + le.Populated_company_charter_number_pcnt*ri.Populated_company_charter_number_pcnt *   0.00 / 10000 + le.Populated_active_duns_number_pcnt*ri.Populated_active_duns_number_pcnt *   0.00 / 10000 + le.Populated_hist_duns_number_pcnt*ri.Populated_hist_duns_number_pcnt *   0.00 / 10000 + le.Populated_active_domestic_corp_key_pcnt*ri.Populated_active_domestic_corp_key_pcnt *   0.00 / 10000 + le.Populated_hist_domestic_corp_key_pcnt*ri.Populated_hist_domestic_corp_key_pcnt *   0.00 / 10000 + le.Populated_foreign_corp_key_pcnt*ri.Populated_foreign_corp_key_pcnt *   0.00 / 10000 + le.Populated_unk_corp_key_pcnt*ri.Populated_unk_corp_key_pcnt *   0.00 / 10000 + le.Populated_company_fein_pcnt*ri.Populated_company_fein_pcnt *   0.00 / 10000 + le.Populated_cnp_btype_pcnt*ri.Populated_cnp_btype_pcnt *   0.00 / 10000 + le.Populated_cnp_name_pcnt*ri.Populated_cnp_name_pcnt *   0.00 / 10000 + le.Populated_company_name_type_derived_pcnt*ri.Populated_company_name_type_derived_pcnt *   0.00 / 10000 + le.Populated_company_bdid_pcnt*ri.Populated_company_bdid_pcnt *   0.00 / 10000 + le.Populated_nodes_total_pcnt*ri.Populated_nodes_total_pcnt *   0.00 / 10000 + le.Populated_dt_first_seen_pcnt*ri.Populated_dt_first_seen_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_pcnt*ri.Populated_dt_last_seen_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT30.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'isCorpEnhanced','contact_job_title_derived','cname_devanitize','prim_range','prim_name','zip','zip4','fname','lname','contact_phone','contact_did','contact_ssn','company_name','sec_range','v_city_name','st','company_inc_state','company_charter_number','active_duns_number','hist_duns_number','active_domestic_corp_key','hist_domestic_corp_key','foreign_corp_key','unk_corp_key','company_fein','cnp_btype','cnp_name','company_name_type_derived','company_bdid','nodes_total','dt_first_seen','dt_last_seen');
  SELF.populated_pcnt := CHOOSE(C,le.populated_isCorpEnhanced_pcnt,le.populated_contact_job_title_derived_pcnt,le.populated_cname_devanitize_pcnt,le.populated_prim_range_pcnt,le.populated_prim_name_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_fname_pcnt,le.populated_lname_pcnt,le.populated_contact_phone_pcnt,le.populated_contact_did_pcnt,le.populated_contact_ssn_pcnt,le.populated_company_name_pcnt,le.populated_sec_range_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_company_inc_state_pcnt,le.populated_company_charter_number_pcnt,le.populated_active_duns_number_pcnt,le.populated_hist_duns_number_pcnt,le.populated_active_domestic_corp_key_pcnt,le.populated_hist_domestic_corp_key_pcnt,le.populated_foreign_corp_key_pcnt,le.populated_unk_corp_key_pcnt,le.populated_company_fein_pcnt,le.populated_cnp_btype_pcnt,le.populated_cnp_name_pcnt,le.populated_company_name_type_derived_pcnt,le.populated_company_bdid_pcnt,le.populated_nodes_total_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_isCorpEnhanced,le.maxlength_contact_job_title_derived,le.maxlength_cname_devanitize,le.maxlength_prim_range,le.maxlength_prim_name,le.maxlength_zip,le.maxlength_zip4,le.maxlength_fname,le.maxlength_lname,le.maxlength_contact_phone,le.maxlength_contact_did,le.maxlength_contact_ssn,le.maxlength_company_name,le.maxlength_sec_range,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_company_inc_state,le.maxlength_company_charter_number,le.maxlength_active_duns_number,le.maxlength_hist_duns_number,le.maxlength_active_domestic_corp_key,le.maxlength_hist_domestic_corp_key,le.maxlength_foreign_corp_key,le.maxlength_unk_corp_key,le.maxlength_company_fein,le.maxlength_cnp_btype,le.maxlength_cnp_name,le.maxlength_company_name_type_derived,le.maxlength_company_bdid,le.maxlength_nodes_total,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen);
  SELF.avelength := CHOOSE(C,le.avelength_isCorpEnhanced,le.avelength_contact_job_title_derived,le.avelength_cname_devanitize,le.avelength_prim_range,le.avelength_prim_name,le.avelength_zip,le.avelength_zip4,le.avelength_fname,le.avelength_lname,le.avelength_contact_phone,le.avelength_contact_did,le.avelength_contact_ssn,le.avelength_company_name,le.avelength_sec_range,le.avelength_v_city_name,le.avelength_st,le.avelength_company_inc_state,le.avelength_company_charter_number,le.avelength_active_duns_number,le.avelength_hist_duns_number,le.avelength_active_domestic_corp_key,le.avelength_hist_domestic_corp_key,le.avelength_foreign_corp_key,le.avelength_unk_corp_key,le.avelength_company_fein,le.avelength_cnp_btype,le.avelength_cnp_name,le.avelength_company_name_type_derived,le.avelength_company_bdid,le.avelength_nodes_total,le.avelength_dt_first_seen,le.avelength_dt_last_seen);
END;
EXPORT invSummary := NORMALIZE(summary0, 32, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.EmpID;
  SELF.Src := le.source;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.isCorpEnhanced),TRIM((SALT30.StrType)le.contact_job_title_derived),TRIM((SALT30.StrType)le.cname_devanitize),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.contact_phone),TRIM((SALT30.StrType)le.contact_did),TRIM((SALT30.StrType)le.contact_ssn),TRIM((SALT30.StrType)le.company_name),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.company_inc_state),TRIM((SALT30.StrType)le.company_charter_number),TRIM((SALT30.StrType)le.active_duns_number),TRIM((SALT30.StrType)le.hist_duns_number),TRIM((SALT30.StrType)le.active_domestic_corp_key),TRIM((SALT30.StrType)le.hist_domestic_corp_key),TRIM((SALT30.StrType)le.foreign_corp_key),TRIM((SALT30.StrType)le.unk_corp_key),TRIM((SALT30.StrType)le.company_fein),TRIM((SALT30.StrType)le.cnp_btype),TRIM((SALT30.StrType)le.cnp_name),TRIM((SALT30.StrType)le.company_name_type_derived),TRIM((SALT30.StrType)le.company_bdid),TRIM((SALT30.StrType)le.nodes_total),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,32,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 32);
  SELF.FldNo2 := 1 + (C % 32);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.isCorpEnhanced),TRIM((SALT30.StrType)le.contact_job_title_derived),TRIM((SALT30.StrType)le.cname_devanitize),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.contact_phone),TRIM((SALT30.StrType)le.contact_did),TRIM((SALT30.StrType)le.contact_ssn),TRIM((SALT30.StrType)le.company_name),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.company_inc_state),TRIM((SALT30.StrType)le.company_charter_number),TRIM((SALT30.StrType)le.active_duns_number),TRIM((SALT30.StrType)le.hist_duns_number),TRIM((SALT30.StrType)le.active_domestic_corp_key),TRIM((SALT30.StrType)le.hist_domestic_corp_key),TRIM((SALT30.StrType)le.foreign_corp_key),TRIM((SALT30.StrType)le.unk_corp_key),TRIM((SALT30.StrType)le.company_fein),TRIM((SALT30.StrType)le.cnp_btype),TRIM((SALT30.StrType)le.cnp_name),TRIM((SALT30.StrType)le.company_name_type_derived),TRIM((SALT30.StrType)le.company_bdid),TRIM((SALT30.StrType)le.nodes_total),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.isCorpEnhanced),TRIM((SALT30.StrType)le.contact_job_title_derived),TRIM((SALT30.StrType)le.cname_devanitize),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.contact_phone),TRIM((SALT30.StrType)le.contact_did),TRIM((SALT30.StrType)le.contact_ssn),TRIM((SALT30.StrType)le.company_name),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.company_inc_state),TRIM((SALT30.StrType)le.company_charter_number),TRIM((SALT30.StrType)le.active_duns_number),TRIM((SALT30.StrType)le.hist_duns_number),TRIM((SALT30.StrType)le.active_domestic_corp_key),TRIM((SALT30.StrType)le.hist_domestic_corp_key),TRIM((SALT30.StrType)le.foreign_corp_key),TRIM((SALT30.StrType)le.unk_corp_key),TRIM((SALT30.StrType)le.company_fein),TRIM((SALT30.StrType)le.cnp_btype),TRIM((SALT30.StrType)le.cnp_name),TRIM((SALT30.StrType)le.company_name_type_derived),TRIM((SALT30.StrType)le.company_bdid),TRIM((SALT30.StrType)le.nodes_total),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),32*32,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'isCorpEnhanced'}
      ,{2,'contact_job_title_derived'}
      ,{3,'cname_devanitize'}
      ,{4,'prim_range'}
      ,{5,'prim_name'}
      ,{6,'zip'}
      ,{7,'zip4'}
      ,{8,'fname'}
      ,{9,'lname'}
      ,{10,'contact_phone'}
      ,{11,'contact_did'}
      ,{12,'contact_ssn'}
      ,{13,'company_name'}
      ,{14,'sec_range'}
      ,{15,'v_city_name'}
      ,{16,'st'}
      ,{17,'company_inc_state'}
      ,{18,'company_charter_number'}
      ,{19,'active_duns_number'}
      ,{20,'hist_duns_number'}
      ,{21,'active_domestic_corp_key'}
      ,{22,'hist_domestic_corp_key'}
      ,{23,'foreign_corp_key'}
      ,{24,'unk_corp_key'}
      ,{25,'company_fein'}
      ,{26,'cnp_btype'}
      ,{27,'cnp_name'}
      ,{28,'company_name_type_derived'}
      ,{29,'company_bdid'}
      ,{30,'nodes_total'}
      ,{31,'dt_first_seen'}
      ,{32,'dt_last_seen'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source) source; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_isCorpEnhanced((SALT30.StrType)le.isCorpEnhanced),
    Fields.InValid_contact_job_title_derived((SALT30.StrType)le.contact_job_title_derived),
    Fields.InValid_cname_devanitize((SALT30.StrType)le.cname_devanitize),
    Fields.InValid_prim_range((SALT30.StrType)le.prim_range),
    Fields.InValid_prim_name((SALT30.StrType)le.prim_name),
    Fields.InValid_zip((SALT30.StrType)le.zip),
    Fields.InValid_zip4((SALT30.StrType)le.zip4),
    Fields.InValid_fname((SALT30.StrType)le.fname),
    Fields.InValid_lname((SALT30.StrType)le.lname),
    Fields.InValid_contact_phone((SALT30.StrType)le.contact_phone),
    Fields.InValid_contact_did((SALT30.StrType)le.contact_did),
    Fields.InValid_contact_ssn((SALT30.StrType)le.contact_ssn),
    Fields.InValid_company_name((SALT30.StrType)le.company_name),
    Fields.InValid_sec_range((SALT30.StrType)le.sec_range),
    Fields.InValid_v_city_name((SALT30.StrType)le.v_city_name),
    Fields.InValid_st((SALT30.StrType)le.st),
    Fields.InValid_company_inc_state((SALT30.StrType)le.company_inc_state),
    Fields.InValid_company_charter_number((SALT30.StrType)le.company_charter_number),
    Fields.InValid_active_duns_number((SALT30.StrType)le.active_duns_number),
    Fields.InValid_hist_duns_number((SALT30.StrType)le.hist_duns_number),
    Fields.InValid_active_domestic_corp_key((SALT30.StrType)le.active_domestic_corp_key),
    Fields.InValid_hist_domestic_corp_key((SALT30.StrType)le.hist_domestic_corp_key),
    Fields.InValid_foreign_corp_key((SALT30.StrType)le.foreign_corp_key),
    Fields.InValid_unk_corp_key((SALT30.StrType)le.unk_corp_key),
    Fields.InValid_company_fein((SALT30.StrType)le.company_fein),
    Fields.InValid_cnp_btype((SALT30.StrType)le.cnp_btype),
    Fields.InValid_cnp_name((SALT30.StrType)le.cnp_name),
    Fields.InValid_company_name_type_derived((SALT30.StrType)le.company_name_type_derived),
    Fields.InValid_company_bdid((SALT30.StrType)le.company_bdid),
    Fields.InValid_nodes_total((SALT30.StrType)le.nodes_total),
    Fields.InValid_dt_first_seen((SALT30.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT30.StrType)le.dt_last_seen),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source := le.source;
END;
Errors := NORMALIZE(h,32,NoteErrors(LEFT,COUNTER));
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
  FieldType := CHOOSE(TotalErrors.FieldNum,'isNoCorp','isOwner','multiword','Unknown','Unknown','number','hasZip4','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_isCorpEnhanced(TotalErrors.ErrorNum),Fields.InValidMessage_contact_job_title_derived(TotalErrors.ErrorNum),Fields.InValidMessage_cname_devanitize(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_contact_phone(TotalErrors.ErrorNum),Fields.InValidMessage_contact_did(TotalErrors.ErrorNum),Fields.InValidMessage_contact_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_company_inc_state(TotalErrors.ErrorNum),Fields.InValidMessage_company_charter_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_hist_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_hist_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_unk_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_company_fein(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_btype(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_name(TotalErrors.ErrorNum),Fields.InValidMessage_company_name_type_derived(TotalErrors.ErrorNum),Fields.InValidMessage_company_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_nodes_total(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//Compute field consistencies between sources
  SALT30.mac_srcfrequency_outliers(h,cname_devanitize,source,cname_devanitize_outliers)
  SALT30.mac_srcfrequency_outliers(h,prim_range,source,prim_range_outliers)
  SALT30.mac_srcfrequency_outliers(h,prim_name,source,prim_name_outliers)
  SALT30.mac_srcfrequency_outliers(h,zip,source,zip_outliers)
  SALT30.mac_srcfrequency_outliers(h,fname,source,fname_outliers)
  SALT30.mac_srcfrequency_outliers(h,lname,source,lname_outliers)
EXPORT AllOutliers := cname_devanitize_outliers + prim_range_outliers + prim_name_outliers + zip_outliers + fname_outliers + lname_outliers;
//We have EmpID specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT30.MOD_ClusterStats.Counts(h,EmpID);
EXPORT ClusterSrc := SALT30.MOD_ClusterStats.Sources(h,EmpID,source);
END;
