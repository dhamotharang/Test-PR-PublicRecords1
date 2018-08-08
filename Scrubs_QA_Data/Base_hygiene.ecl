IMPORT ut,SALT34;
EXPORT Base_hygiene(dataset(Base_layout_QA_Data) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT34.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_rawtrans_masteraddressid_pcnt := AVE(GROUP,IF(h.rawtrans_masteraddressid = (TYPEOF(h.rawtrans_masteraddressid))'',0,100));
    maxlength_rawtrans_masteraddressid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawtrans_masteraddressid)));
    avelength_rawtrans_masteraddressid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawtrans_masteraddressid)),h.rawtrans_masteraddressid<>(typeof(h.rawtrans_masteraddressid))'');
    populated_rawtrans_date_pcnt := AVE(GROUP,IF(h.rawtrans_date = (TYPEOF(h.rawtrans_date))'',0,100));
    maxlength_rawtrans_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawtrans_date)));
    avelength_rawtrans_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawtrans_date)),h.rawtrans_date<>(typeof(h.rawtrans_date))'');
    populated_rawtrans_category_pcnt := AVE(GROUP,IF(h.rawtrans_category = (TYPEOF(h.rawtrans_category))'',0,100));
    maxlength_rawtrans_category := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawtrans_category)));
    avelength_rawtrans_category := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawtrans_category)),h.rawtrans_category<>(typeof(h.rawtrans_category))'');
    populated_rawaddr_databasematchcode_pcnt := AVE(GROUP,IF(h.rawaddr_databasematchcode = (TYPEOF(h.rawaddr_databasematchcode))'',0,100));
    maxlength_rawaddr_databasematchcode := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawaddr_databasematchcode)));
    avelength_rawaddr_databasematchcode := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawaddr_databasematchcode)),h.rawaddr_databasematchcode<>(typeof(h.rawaddr_databasematchcode))'');
    populated_rawaddr_homebusinessflag_pcnt := AVE(GROUP,IF(h.rawaddr_homebusinessflag = (TYPEOF(h.rawaddr_homebusinessflag))'',0,100));
    maxlength_rawaddr_homebusinessflag := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawaddr_homebusinessflag)));
    avelength_rawaddr_homebusinessflag := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawaddr_homebusinessflag)),h.rawaddr_homebusinessflag<>(typeof(h.rawaddr_homebusinessflag))'');
    populated_rawaddr_masteraddressid_pcnt := AVE(GROUP,IF(h.rawaddr_masteraddressid = (TYPEOF(h.rawaddr_masteraddressid))'',0,100));
    maxlength_rawaddr_masteraddressid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawaddr_masteraddressid)));
    avelength_rawaddr_masteraddressid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawaddr_masteraddressid)),h.rawaddr_masteraddressid<>(typeof(h.rawaddr_masteraddressid))'');
    populated_prep_trans_line1_pcnt := AVE(GROUP,IF(h.prep_trans_line1 = (TYPEOF(h.prep_trans_line1))'',0,100));
    maxlength_prep_trans_line1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prep_trans_line1)));
    avelength_prep_trans_line1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prep_trans_line1)),h.prep_trans_line1<>(typeof(h.prep_trans_line1))'');
    populated_prep_trans_line_last_pcnt := AVE(GROUP,IF(h.prep_trans_line_last = (TYPEOF(h.prep_trans_line_last))'',0,100));
    maxlength_prep_trans_line_last := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prep_trans_line_last)));
    avelength_prep_trans_line_last := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prep_trans_line_last)),h.prep_trans_line_last<>(typeof(h.prep_trans_line_last))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_addr_line_last = (TYPEOF(h.prep_addr_line_last))'',0,100));
    maxlength_prep_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prep_addr_line_last)));
    avelength_prep_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prep_addr_line_last)),h.prep_addr_line_last<>(typeof(h.prep_addr_line_last))'');
    populated_trans_address_prim_name_pcnt := AVE(GROUP,IF(h.trans_address_prim_name = (TYPEOF(h.trans_address_prim_name))'',0,100));
    maxlength_trans_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.trans_address_prim_name)));
    avelength_trans_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.trans_address_prim_name)),h.trans_address_prim_name<>(typeof(h.trans_address_prim_name))'');
    populated_trans_address_p_city_name_pcnt := AVE(GROUP,IF(h.trans_address_p_city_name = (TYPEOF(h.trans_address_p_city_name))'',0,100));
    maxlength_trans_address_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.trans_address_p_city_name)));
    avelength_trans_address_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.trans_address_p_city_name)),h.trans_address_p_city_name<>(typeof(h.trans_address_p_city_name))'');
    populated_trans_address_v_city_name_pcnt := AVE(GROUP,IF(h.trans_address_v_city_name = (TYPEOF(h.trans_address_v_city_name))'',0,100));
    maxlength_trans_address_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.trans_address_v_city_name)));
    avelength_trans_address_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.trans_address_v_city_name)),h.trans_address_v_city_name<>(typeof(h.trans_address_v_city_name))'');
    populated_trans_address_st_pcnt := AVE(GROUP,IF(h.trans_address_st = (TYPEOF(h.trans_address_st))'',0,100));
    maxlength_trans_address_st := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.trans_address_st)));
    avelength_trans_address_st := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.trans_address_st)),h.trans_address_st<>(typeof(h.trans_address_st))'');
    populated_trans_address_zip_pcnt := AVE(GROUP,IF(h.trans_address_zip = (TYPEOF(h.trans_address_zip))'',0,100));
    maxlength_trans_address_zip := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.trans_address_zip)));
    avelength_trans_address_zip := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.trans_address_zip)),h.trans_address_zip<>(typeof(h.trans_address_zip))'');
    populated_addr_address_prim_name_pcnt := AVE(GROUP,IF(h.addr_address_prim_name = (TYPEOF(h.addr_address_prim_name))'',0,100));
    maxlength_addr_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_address_prim_name)));
    avelength_addr_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_address_prim_name)),h.addr_address_prim_name<>(typeof(h.addr_address_prim_name))'');
    populated_addr_address_p_city_name_pcnt := AVE(GROUP,IF(h.addr_address_p_city_name = (TYPEOF(h.addr_address_p_city_name))'',0,100));
    maxlength_addr_address_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_address_p_city_name)));
    avelength_addr_address_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_address_p_city_name)),h.addr_address_p_city_name<>(typeof(h.addr_address_p_city_name))'');
    populated_addr_address_v_city_name_pcnt := AVE(GROUP,IF(h.addr_address_v_city_name = (TYPEOF(h.addr_address_v_city_name))'',0,100));
    maxlength_addr_address_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_address_v_city_name)));
    avelength_addr_address_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_address_v_city_name)),h.addr_address_v_city_name<>(typeof(h.addr_address_v_city_name))'');
    populated_addr_address_st_pcnt := AVE(GROUP,IF(h.addr_address_st = (TYPEOF(h.addr_address_st))'',0,100));
    maxlength_addr_address_st := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_address_st)));
    avelength_addr_address_st := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_address_st)),h.addr_address_st<>(typeof(h.addr_address_st))'');
    populated_addr_address_zip_pcnt := AVE(GROUP,IF(h.addr_address_zip = (TYPEOF(h.addr_address_zip))'',0,100));
    maxlength_addr_address_zip := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_address_zip)));
    avelength_addr_address_zip := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_address_zip)),h.addr_address_zip<>(typeof(h.addr_address_zip))'');
    populated_clean_person_type_pcnt := AVE(GROUP,IF(h.clean_person_type = (TYPEOF(h.clean_person_type))'',0,100));
    maxlength_clean_person_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_person_type)));
    avelength_clean_person_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_person_type)),h.clean_person_type<>(typeof(h.clean_person_type))'');
    populated_clean_person_name_fname_pcnt := AVE(GROUP,IF(h.clean_person_name_fname = (TYPEOF(h.clean_person_name_fname))'',0,100));
    maxlength_clean_person_name_fname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_person_name_fname)));
    avelength_clean_person_name_fname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_person_name_fname)),h.clean_person_name_fname<>(typeof(h.clean_person_name_fname))'');
    populated_clean_person_name_lname_pcnt := AVE(GROUP,IF(h.clean_person_name_lname = (TYPEOF(h.clean_person_name_lname))'',0,100));
    maxlength_clean_person_name_lname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_person_name_lname)));
    avelength_clean_person_name_lname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_person_name_lname)),h.clean_person_name_lname<>(typeof(h.clean_person_name_lname))'');
    populated_clean_phone_pcnt := AVE(GROUP,IF(h.clean_phone = (TYPEOF(h.clean_phone))'',0,100));
    maxlength_clean_phone := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phone)));
    avelength_clean_phone := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phone)),h.clean_phone<>(typeof(h.clean_phone))'');
    populated_clean_company_pcnt := AVE(GROUP,IF(h.clean_company = (TYPEOF(h.clean_company))'',0,100));
    maxlength_clean_company := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_company)));
    avelength_clean_company := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_company)),h.clean_company<>(typeof(h.clean_company))'');
    populated_nametype_pcnt := AVE(GROUP,IF(h.nametype = (TYPEOF(h.nametype))'',0,100));
    maxlength_nametype := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nametype)));
    avelength_nametype := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nametype)),h.nametype<>(typeof(h.nametype))'');
    populated_source_rec_id_pcnt := AVE(GROUP,IF(h.source_rec_id = (TYPEOF(h.source_rec_id))'',0,100));
    maxlength_source_rec_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.source_rec_id)));
    avelength_source_rec_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.source_rec_id)),h.source_rec_id<>(typeof(h.source_rec_id))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_rawtrans_masteraddressid_pcnt *   0.00 / 100 + T.Populated_rawtrans_date_pcnt *   0.00 / 100 + T.Populated_rawtrans_category_pcnt *   0.00 / 100 + T.Populated_rawaddr_databasematchcode_pcnt *   0.00 / 100 + T.Populated_rawaddr_homebusinessflag_pcnt *   0.00 / 100 + T.Populated_rawaddr_masteraddressid_pcnt *   0.00 / 100 + T.Populated_prep_trans_line1_pcnt *   0.00 / 100 + T.Populated_prep_trans_line_last_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_line_last_pcnt *   0.00 / 100 + T.Populated_trans_address_prim_name_pcnt *   0.00 / 100 + T.Populated_trans_address_p_city_name_pcnt *   0.00 / 100 + T.Populated_trans_address_v_city_name_pcnt *   0.00 / 100 + T.Populated_trans_address_st_pcnt *   0.00 / 100 + T.Populated_trans_address_zip_pcnt *   0.00 / 100 + T.Populated_addr_address_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_address_p_city_name_pcnt *   0.00 / 100 + T.Populated_addr_address_v_city_name_pcnt *   0.00 / 100 + T.Populated_addr_address_st_pcnt *   0.00 / 100 + T.Populated_addr_address_zip_pcnt *   0.00 / 100 + T.Populated_clean_person_type_pcnt *   0.00 / 100 + T.Populated_clean_person_name_fname_pcnt *   0.00 / 100 + T.Populated_clean_person_name_lname_pcnt *   0.00 / 100 + T.Populated_clean_phone_pcnt *   0.00 / 100 + T.Populated_clean_company_pcnt *   0.00 / 100 + T.Populated_nametype_pcnt *   0.00 / 100 + T.Populated_source_rec_id_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT34.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'powid','proxid','seleid','orgid','ultid','did','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','rawtrans_masteraddressid','rawtrans_date','rawtrans_category','rawaddr_databasematchcode','rawaddr_homebusinessflag','rawaddr_masteraddressid','prep_trans_line1','prep_trans_line_last','prep_addr_line1','prep_addr_line_last','trans_address_prim_name','trans_address_p_city_name','trans_address_v_city_name','trans_address_st','trans_address_zip','addr_address_prim_name','addr_address_p_city_name','addr_address_v_city_name','addr_address_st','addr_address_zip','clean_person_type','clean_person_name_fname','clean_person_name_lname','clean_phone','clean_company','nametype','source_rec_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_powid_pcnt,le.populated_proxid_pcnt,le.populated_seleid_pcnt,le.populated_orgid_pcnt,le.populated_ultid_pcnt,le.populated_did_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_record_type_pcnt,le.populated_rawtrans_masteraddressid_pcnt,le.populated_rawtrans_date_pcnt,le.populated_rawtrans_category_pcnt,le.populated_rawaddr_databasematchcode_pcnt,le.populated_rawaddr_homebusinessflag_pcnt,le.populated_rawaddr_masteraddressid_pcnt,le.populated_prep_trans_line1_pcnt,le.populated_prep_trans_line_last_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_line_last_pcnt,le.populated_trans_address_prim_name_pcnt,le.populated_trans_address_p_city_name_pcnt,le.populated_trans_address_v_city_name_pcnt,le.populated_trans_address_st_pcnt,le.populated_trans_address_zip_pcnt,le.populated_addr_address_prim_name_pcnt,le.populated_addr_address_p_city_name_pcnt,le.populated_addr_address_v_city_name_pcnt,le.populated_addr_address_st_pcnt,le.populated_addr_address_zip_pcnt,le.populated_clean_person_type_pcnt,le.populated_clean_person_name_fname_pcnt,le.populated_clean_person_name_lname_pcnt,le.populated_clean_phone_pcnt,le.populated_clean_company_pcnt,le.populated_nametype_pcnt,le.populated_source_rec_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_powid,le.maxlength_proxid,le.maxlength_seleid,le.maxlength_orgid,le.maxlength_ultid,le.maxlength_did,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_record_type,le.maxlength_rawtrans_masteraddressid,le.maxlength_rawtrans_date,le.maxlength_rawtrans_category,le.maxlength_rawaddr_databasematchcode,le.maxlength_rawaddr_homebusinessflag,le.maxlength_rawaddr_masteraddressid,le.maxlength_prep_trans_line1,le.maxlength_prep_trans_line_last,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_line_last,le.maxlength_trans_address_prim_name,le.maxlength_trans_address_p_city_name,le.maxlength_trans_address_v_city_name,le.maxlength_trans_address_st,le.maxlength_trans_address_zip,le.maxlength_addr_address_prim_name,le.maxlength_addr_address_p_city_name,le.maxlength_addr_address_v_city_name,le.maxlength_addr_address_st,le.maxlength_addr_address_zip,le.maxlength_clean_person_type,le.maxlength_clean_person_name_fname,le.maxlength_clean_person_name_lname,le.maxlength_clean_phone,le.maxlength_clean_company,le.maxlength_nametype,le.maxlength_source_rec_id);
  SELF.avelength := CHOOSE(C,le.avelength_powid,le.avelength_proxid,le.avelength_seleid,le.avelength_orgid,le.avelength_ultid,le.avelength_did,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_record_type,le.avelength_rawtrans_masteraddressid,le.avelength_rawtrans_date,le.avelength_rawtrans_category,le.avelength_rawaddr_databasematchcode,le.avelength_rawaddr_homebusinessflag,le.avelength_rawaddr_masteraddressid,le.avelength_prep_trans_line1,le.avelength_prep_trans_line_last,le.avelength_prep_addr_line1,le.avelength_prep_addr_line_last,le.avelength_trans_address_prim_name,le.avelength_trans_address_p_city_name,le.avelength_trans_address_v_city_name,le.avelength_trans_address_st,le.avelength_trans_address_zip,le.avelength_addr_address_prim_name,le.avelength_addr_address_p_city_name,le.avelength_addr_address_v_city_name,le.avelength_addr_address_st,le.avelength_addr_address_zip,le.avelength_clean_person_type,le.avelength_clean_person_name_fname,le.avelength_clean_person_name_lname,le.avelength_clean_phone,le.avelength_clean_company,le.avelength_nametype,le.avelength_source_rec_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 38, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT34.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.powid <> 0,TRIM((SALT34.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT34.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT34.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT34.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT34.StrType)le.ultid), ''),IF (le.did <> 0,TRIM((SALT34.StrType)le.did), ''),IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT34.StrType)le.record_type),TRIM((SALT34.StrType)le.rawtrans_masteraddressid),TRIM((SALT34.StrType)le.rawtrans_date),TRIM((SALT34.StrType)le.rawtrans_category),TRIM((SALT34.StrType)le.rawaddr_databasematchcode),TRIM((SALT34.StrType)le.rawaddr_homebusinessflag),TRIM((SALT34.StrType)le.rawaddr_masteraddressid),TRIM((SALT34.StrType)le.prep_trans_line1),TRIM((SALT34.StrType)le.prep_trans_line_last),TRIM((SALT34.StrType)le.prep_addr_line1),TRIM((SALT34.StrType)le.prep_addr_line_last),TRIM((SALT34.StrType)le.trans_address_prim_name),TRIM((SALT34.StrType)le.trans_address_p_city_name),TRIM((SALT34.StrType)le.trans_address_v_city_name),TRIM((SALT34.StrType)le.trans_address_st),TRIM((SALT34.StrType)le.trans_address_zip),TRIM((SALT34.StrType)le.addr_address_prim_name),TRIM((SALT34.StrType)le.addr_address_p_city_name),TRIM((SALT34.StrType)le.addr_address_v_city_name),TRIM((SALT34.StrType)le.addr_address_st),TRIM((SALT34.StrType)le.addr_address_zip),TRIM((SALT34.StrType)le.clean_person_type),TRIM((SALT34.StrType)le.clean_person_name_fname),TRIM((SALT34.StrType)le.clean_person_name_lname),TRIM((SALT34.StrType)le.clean_phone),TRIM((SALT34.StrType)le.clean_company),TRIM((SALT34.StrType)le.nametype),IF (le.source_rec_id <> 0,TRIM((SALT34.StrType)le.source_rec_id), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,38,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT34.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 38);
  SELF.FldNo2 := 1 + (C % 38);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.powid <> 0,TRIM((SALT34.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT34.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT34.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT34.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT34.StrType)le.ultid), ''),IF (le.did <> 0,TRIM((SALT34.StrType)le.did), ''),IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT34.StrType)le.record_type),TRIM((SALT34.StrType)le.rawtrans_masteraddressid),TRIM((SALT34.StrType)le.rawtrans_date),TRIM((SALT34.StrType)le.rawtrans_category),TRIM((SALT34.StrType)le.rawaddr_databasematchcode),TRIM((SALT34.StrType)le.rawaddr_homebusinessflag),TRIM((SALT34.StrType)le.rawaddr_masteraddressid),TRIM((SALT34.StrType)le.prep_trans_line1),TRIM((SALT34.StrType)le.prep_trans_line_last),TRIM((SALT34.StrType)le.prep_addr_line1),TRIM((SALT34.StrType)le.prep_addr_line_last),TRIM((SALT34.StrType)le.trans_address_prim_name),TRIM((SALT34.StrType)le.trans_address_p_city_name),TRIM((SALT34.StrType)le.trans_address_v_city_name),TRIM((SALT34.StrType)le.trans_address_st),TRIM((SALT34.StrType)le.trans_address_zip),TRIM((SALT34.StrType)le.addr_address_prim_name),TRIM((SALT34.StrType)le.addr_address_p_city_name),TRIM((SALT34.StrType)le.addr_address_v_city_name),TRIM((SALT34.StrType)le.addr_address_st),TRIM((SALT34.StrType)le.addr_address_zip),TRIM((SALT34.StrType)le.clean_person_type),TRIM((SALT34.StrType)le.clean_person_name_fname),TRIM((SALT34.StrType)le.clean_person_name_lname),TRIM((SALT34.StrType)le.clean_phone),TRIM((SALT34.StrType)le.clean_company),TRIM((SALT34.StrType)le.nametype),IF (le.source_rec_id <> 0,TRIM((SALT34.StrType)le.source_rec_id), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.powid <> 0,TRIM((SALT34.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT34.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT34.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT34.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT34.StrType)le.ultid), ''),IF (le.did <> 0,TRIM((SALT34.StrType)le.did), ''),IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT34.StrType)le.record_type),TRIM((SALT34.StrType)le.rawtrans_masteraddressid),TRIM((SALT34.StrType)le.rawtrans_date),TRIM((SALT34.StrType)le.rawtrans_category),TRIM((SALT34.StrType)le.rawaddr_databasematchcode),TRIM((SALT34.StrType)le.rawaddr_homebusinessflag),TRIM((SALT34.StrType)le.rawaddr_masteraddressid),TRIM((SALT34.StrType)le.prep_trans_line1),TRIM((SALT34.StrType)le.prep_trans_line_last),TRIM((SALT34.StrType)le.prep_addr_line1),TRIM((SALT34.StrType)le.prep_addr_line_last),TRIM((SALT34.StrType)le.trans_address_prim_name),TRIM((SALT34.StrType)le.trans_address_p_city_name),TRIM((SALT34.StrType)le.trans_address_v_city_name),TRIM((SALT34.StrType)le.trans_address_st),TRIM((SALT34.StrType)le.trans_address_zip),TRIM((SALT34.StrType)le.addr_address_prim_name),TRIM((SALT34.StrType)le.addr_address_p_city_name),TRIM((SALT34.StrType)le.addr_address_v_city_name),TRIM((SALT34.StrType)le.addr_address_st),TRIM((SALT34.StrType)le.addr_address_zip),TRIM((SALT34.StrType)le.clean_person_type),TRIM((SALT34.StrType)le.clean_person_name_fname),TRIM((SALT34.StrType)le.clean_person_name_lname),TRIM((SALT34.StrType)le.clean_phone),TRIM((SALT34.StrType)le.clean_company),TRIM((SALT34.StrType)le.nametype),IF (le.source_rec_id <> 0,TRIM((SALT34.StrType)le.source_rec_id), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),38*38,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'powid'}
      ,{2,'proxid'}
      ,{3,'seleid'}
      ,{4,'orgid'}
      ,{5,'ultid'}
      ,{6,'did'}
      ,{7,'dt_first_seen'}
      ,{8,'dt_last_seen'}
      ,{9,'dt_vendor_first_reported'}
      ,{10,'dt_vendor_last_reported'}
      ,{11,'record_type'}
      ,{12,'rawtrans_masteraddressid'}
      ,{13,'rawtrans_date'}
      ,{14,'rawtrans_category'}
      ,{15,'rawaddr_databasematchcode'}
      ,{16,'rawaddr_homebusinessflag'}
      ,{17,'rawaddr_masteraddressid'}
      ,{18,'prep_trans_line1'}
      ,{19,'prep_trans_line_last'}
      ,{20,'prep_addr_line1'}
      ,{21,'prep_addr_line_last'}
      ,{22,'trans_address_prim_name'}
      ,{23,'trans_address_p_city_name'}
      ,{24,'trans_address_v_city_name'}
      ,{25,'trans_address_st'}
      ,{26,'trans_address_zip'}
      ,{27,'addr_address_prim_name'}
      ,{28,'addr_address_p_city_name'}
      ,{29,'addr_address_v_city_name'}
      ,{30,'addr_address_st'}
      ,{31,'addr_address_zip'}
      ,{32,'clean_person_type'}
      ,{33,'clean_person_name_fname'}
      ,{34,'clean_person_name_lname'}
      ,{35,'clean_phone'}
      ,{36,'clean_company'}
      ,{37,'nametype'}
      ,{38,'source_rec_id'}],SALT34.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT34.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT34.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT34.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Fields.InValid_powid((SALT34.StrType)le.powid),
    Base_Fields.InValid_proxid((SALT34.StrType)le.proxid),
    Base_Fields.InValid_seleid((SALT34.StrType)le.seleid),
    Base_Fields.InValid_orgid((SALT34.StrType)le.orgid),
    Base_Fields.InValid_ultid((SALT34.StrType)le.ultid),
    Base_Fields.InValid_did((SALT34.StrType)le.did),
    Base_Fields.InValid_dt_first_seen((SALT34.StrType)le.dt_first_seen),
    Base_Fields.InValid_dt_last_seen((SALT34.StrType)le.dt_last_seen),
    Base_Fields.InValid_dt_vendor_first_reported((SALT34.StrType)le.dt_vendor_first_reported),
    Base_Fields.InValid_dt_vendor_last_reported((SALT34.StrType)le.dt_vendor_last_reported),
    Base_Fields.InValid_record_type((SALT34.StrType)le.record_type),
    Base_Fields.InValid_rawtrans_masteraddressid((SALT34.StrType)le.rawtrans_masteraddressid),
    Base_Fields.InValid_rawtrans_date((SALT34.StrType)le.rawtrans_date),
    Base_Fields.InValid_rawtrans_category((SALT34.StrType)le.rawtrans_category),
    Base_Fields.InValid_rawaddr_databasematchcode((SALT34.StrType)le.rawaddr_databasematchcode),
    Base_Fields.InValid_rawaddr_homebusinessflag((SALT34.StrType)le.rawaddr_homebusinessflag),
    Base_Fields.InValid_rawaddr_masteraddressid((SALT34.StrType)le.rawaddr_masteraddressid),
    Base_Fields.InValid_prep_trans_line1((SALT34.StrType)le.prep_trans_line1),
    Base_Fields.InValid_prep_trans_line_last((SALT34.StrType)le.prep_trans_line_last),
    Base_Fields.InValid_prep_addr_line1((SALT34.StrType)le.prep_addr_line1),
    Base_Fields.InValid_prep_addr_line_last((SALT34.StrType)le.prep_addr_line_last),
    Base_Fields.InValid_trans_address_prim_name((SALT34.StrType)le.trans_address_prim_name),
    Base_Fields.InValid_trans_address_p_city_name((SALT34.StrType)le.trans_address_p_city_name),
    Base_Fields.InValid_trans_address_v_city_name((SALT34.StrType)le.trans_address_v_city_name),
    Base_Fields.InValid_trans_address_st((SALT34.StrType)le.trans_address_st),
    Base_Fields.InValid_trans_address_zip((SALT34.StrType)le.trans_address_zip),
    Base_Fields.InValid_addr_address_prim_name((SALT34.StrType)le.addr_address_prim_name),
    Base_Fields.InValid_addr_address_p_city_name((SALT34.StrType)le.addr_address_p_city_name),
    Base_Fields.InValid_addr_address_v_city_name((SALT34.StrType)le.addr_address_v_city_name),
    Base_Fields.InValid_addr_address_st((SALT34.StrType)le.addr_address_st),
    Base_Fields.InValid_addr_address_zip((SALT34.StrType)le.addr_address_zip),
    Base_Fields.InValid_clean_person_type((SALT34.StrType)le.clean_person_type),
    Base_Fields.InValid_clean_person_name_fname((SALT34.StrType)le.clean_person_name_fname),
    Base_Fields.InValid_clean_person_name_lname((SALT34.StrType)le.clean_person_name_lname),
    Base_Fields.InValid_clean_phone((SALT34.StrType)le.clean_phone),
    Base_Fields.InValid_clean_company((SALT34.StrType)le.clean_company),
    Base_Fields.InValid_nametype((SALT34.StrType)le.nametype),
    Base_Fields.InValid_source_rec_id((SALT34.StrType)le.source_rec_id),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,38,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_record_type','invalid_numeric_or_blank','invalid_date_time','invalid_mandatory','invalid_db_match','invalid_home_business','invalid_numeric','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_st','invalid_zip5','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_st','invalid_zip5','invalid_person_type','invalid_alphanum_specials','invalid_alphanum_specials','invalid_phone','invalid_mandatory','invalid_nametype','invalid_src_rid');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_did(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_rawtrans_masteraddressid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_rawtrans_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_rawtrans_category(TotalErrors.ErrorNum),Base_Fields.InValidMessage_rawaddr_databasematchcode(TotalErrors.ErrorNum),Base_Fields.InValidMessage_rawaddr_homebusinessflag(TotalErrors.ErrorNum),Base_Fields.InValidMessage_rawaddr_masteraddressid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_trans_line1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_trans_line_last(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_addr_line_last(TotalErrors.ErrorNum),Base_Fields.InValidMessage_trans_address_prim_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_trans_address_p_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_trans_address_v_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_trans_address_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_trans_address_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_addr_address_prim_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_addr_address_p_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_addr_address_v_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_addr_address_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_addr_address_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_person_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_person_name_fname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_person_name_lname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_company(TotalErrors.ErrorNum),Base_Fields.InValidMessage_nametype(TotalErrors.ErrorNum),Base_Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
