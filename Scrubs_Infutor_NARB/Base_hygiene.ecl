IMPORT ut,SALT34;
EXPORT Base_hygiene(dataset(Base_layout_Infutor_NARB) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT34.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_rcid_pcnt := AVE(GROUP,IF(h.rcid = (TYPEOF(h.rcid))'',0,100));
    maxlength_rcid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rcid)));
    avelength_rcid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rcid)),h.rcid<>(typeof(h.rcid))'');
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
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_pid_pcnt := AVE(GROUP,IF(h.pid = (TYPEOF(h.pid))'',0,100));
    maxlength_pid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pid)));
    avelength_pid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pid)),h.pid<>(typeof(h.pid))'');
    populated_address_type_code_pcnt := AVE(GROUP,IF(h.address_type_code = (TYPEOF(h.address_type_code))'',0,100));
    maxlength_address_type_code := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_type_code)));
    avelength_address_type_code := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_type_code)),h.address_type_code<>(typeof(h.address_type_code))'');
    populated_url_pcnt := AVE(GROUP,IF(h.url = (TYPEOF(h.url))'',0,100));
    maxlength_url := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.url)));
    avelength_url := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.url)),h.url<>(typeof(h.url))'');
    populated_sic1_pcnt := AVE(GROUP,IF(h.sic1 = (TYPEOF(h.sic1))'',0,100));
    maxlength_sic1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic1)));
    avelength_sic1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic1)),h.sic1<>(typeof(h.sic1))'');
    populated_sic2_pcnt := AVE(GROUP,IF(h.sic2 = (TYPEOF(h.sic2))'',0,100));
    maxlength_sic2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic2)));
    avelength_sic2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic2)),h.sic2<>(typeof(h.sic2))'');
    populated_sic3_pcnt := AVE(GROUP,IF(h.sic3 = (TYPEOF(h.sic3))'',0,100));
    maxlength_sic3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic3)));
    avelength_sic3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic3)),h.sic3<>(typeof(h.sic3))'');
    populated_sic4_pcnt := AVE(GROUP,IF(h.sic4 = (TYPEOF(h.sic4))'',0,100));
    maxlength_sic4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic4)));
    avelength_sic4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic4)),h.sic4<>(typeof(h.sic4))'');
    populated_sic5_pcnt := AVE(GROUP,IF(h.sic5 = (TYPEOF(h.sic5))'',0,100));
    maxlength_sic5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic5)));
    avelength_sic5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic5)),h.sic5<>(typeof(h.sic5))'');
    populated_incorporation_state_pcnt := AVE(GROUP,IF(h.incorporation_state = (TYPEOF(h.incorporation_state))'',0,100));
    maxlength_incorporation_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.incorporation_state)));
    avelength_incorporation_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.incorporation_state)),h.incorporation_state<>(typeof(h.incorporation_state))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_contact_title_pcnt := AVE(GROUP,IF(h.contact_title = (TYPEOF(h.contact_title))'',0,100));
    maxlength_contact_title := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.contact_title)));
    avelength_contact_title := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.contact_title)),h.contact_title<>(typeof(h.contact_title))'');
    populated_normcompany_type_pcnt := AVE(GROUP,IF(h.normcompany_type = (TYPEOF(h.normcompany_type))'',0,100));
    maxlength_normcompany_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.normcompany_type)));
    avelength_normcompany_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.normcompany_type)),h.normcompany_type<>(typeof(h.normcompany_type))'');
    populated_clean_company_name_pcnt := AVE(GROUP,IF(h.clean_company_name = (TYPEOF(h.clean_company_name))'',0,100));
    maxlength_clean_company_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_company_name)));
    avelength_clean_company_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_company_name)),h.clean_company_name<>(typeof(h.clean_company_name))'');
    populated_clean_phone_pcnt := AVE(GROUP,IF(h.clean_phone = (TYPEOF(h.clean_phone))'',0,100));
    maxlength_clean_phone := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phone)));
    avelength_clean_phone := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phone)),h.clean_phone<>(typeof(h.clean_phone))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_prep_address_line1_pcnt := AVE(GROUP,IF(h.prep_address_line1 = (TYPEOF(h.prep_address_line1))'',0,100));
    maxlength_prep_address_line1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prep_address_line1)));
    avelength_prep_address_line1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prep_address_line1)),h.prep_address_line1<>(typeof(h.prep_address_line1))'');
    populated_prep_address_line_last_pcnt := AVE(GROUP,IF(h.prep_address_line_last = (TYPEOF(h.prep_address_line_last))'',0,100));
    maxlength_prep_address_line_last := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prep_address_line_last)));
    avelength_prep_address_line_last := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prep_address_line_last)),h.prep_address_line_last<>(typeof(h.prep_address_line_last))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_rcid_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_pid_pcnt *   0.00 / 100 + T.Populated_address_type_code_pcnt *   0.00 / 100 + T.Populated_url_pcnt *   0.00 / 100 + T.Populated_sic1_pcnt *   0.00 / 100 + T.Populated_sic2_pcnt *   0.00 / 100 + T.Populated_sic3_pcnt *   0.00 / 100 + T.Populated_sic4_pcnt *   0.00 / 100 + T.Populated_sic5_pcnt *   0.00 / 100 + T.Populated_incorporation_state_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_contact_title_pcnt *   0.00 / 100 + T.Populated_normcompany_type_pcnt *   0.00 / 100 + T.Populated_clean_company_name_pcnt *   0.00 / 100 + T.Populated_clean_phone_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_prep_address_line1_pcnt *   0.00 / 100 + T.Populated_prep_address_line_last_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'rcid','powid','proxid','seleid','orgid','ultid','did','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','pid','address_type_code','url','sic1','sic2','sic3','sic4','sic5','incorporation_state','email','contact_title','normcompany_type','clean_company_name','clean_phone','fname','lname','prim_range','p_city_name','v_city_name','st','zip','prep_address_line1','prep_address_line_last');
  SELF.populated_pcnt := CHOOSE(C,le.populated_rcid_pcnt,le.populated_powid_pcnt,le.populated_proxid_pcnt,le.populated_seleid_pcnt,le.populated_orgid_pcnt,le.populated_ultid_pcnt,le.populated_did_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_process_date_pcnt,le.populated_record_type_pcnt,le.populated_pid_pcnt,le.populated_address_type_code_pcnt,le.populated_url_pcnt,le.populated_sic1_pcnt,le.populated_sic2_pcnt,le.populated_sic3_pcnt,le.populated_sic4_pcnt,le.populated_sic5_pcnt,le.populated_incorporation_state_pcnt,le.populated_email_pcnt,le.populated_contact_title_pcnt,le.populated_normcompany_type_pcnt,le.populated_clean_company_name_pcnt,le.populated_clean_phone_pcnt,le.populated_fname_pcnt,le.populated_lname_pcnt,le.populated_prim_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_prep_address_line1_pcnt,le.populated_prep_address_line_last_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_rcid,le.maxlength_powid,le.maxlength_proxid,le.maxlength_seleid,le.maxlength_orgid,le.maxlength_ultid,le.maxlength_did,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_process_date,le.maxlength_record_type,le.maxlength_pid,le.maxlength_address_type_code,le.maxlength_url,le.maxlength_sic1,le.maxlength_sic2,le.maxlength_sic3,le.maxlength_sic4,le.maxlength_sic5,le.maxlength_incorporation_state,le.maxlength_email,le.maxlength_contact_title,le.maxlength_normcompany_type,le.maxlength_clean_company_name,le.maxlength_clean_phone,le.maxlength_fname,le.maxlength_lname,le.maxlength_prim_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_prep_address_line1,le.maxlength_prep_address_line_last);
  SELF.avelength := CHOOSE(C,le.avelength_rcid,le.avelength_powid,le.avelength_proxid,le.avelength_seleid,le.avelength_orgid,le.avelength_ultid,le.avelength_did,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_process_date,le.avelength_record_type,le.avelength_pid,le.avelength_address_type_code,le.avelength_url,le.avelength_sic1,le.avelength_sic2,le.avelength_sic3,le.avelength_sic4,le.avelength_sic5,le.avelength_incorporation_state,le.avelength_email,le.avelength_contact_title,le.avelength_normcompany_type,le.avelength_clean_company_name,le.avelength_clean_phone,le.avelength_fname,le.avelength_lname,le.avelength_prim_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_prep_address_line1,le.avelength_prep_address_line_last);
END;
EXPORT invSummary := NORMALIZE(summary0, 36, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT34.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.rcid <> 0,TRIM((SALT34.StrType)le.rcid), ''),IF (le.powid <> 0,TRIM((SALT34.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT34.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT34.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT34.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT34.StrType)le.ultid), ''),IF (le.did <> 0,TRIM((SALT34.StrType)le.did), ''),IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),IF (le.process_date <> 0,TRIM((SALT34.StrType)le.process_date), ''),TRIM((SALT34.StrType)le.record_type),TRIM((SALT34.StrType)le.pid),TRIM((SALT34.StrType)le.address_type_code),TRIM((SALT34.StrType)le.url),TRIM((SALT34.StrType)le.sic1),TRIM((SALT34.StrType)le.sic2),TRIM((SALT34.StrType)le.sic3),TRIM((SALT34.StrType)le.sic4),TRIM((SALT34.StrType)le.sic5),TRIM((SALT34.StrType)le.incorporation_state),TRIM((SALT34.StrType)le.email),TRIM((SALT34.StrType)le.contact_title),TRIM((SALT34.StrType)le.normcompany_type),TRIM((SALT34.StrType)le.clean_company_name),TRIM((SALT34.StrType)le.clean_phone),TRIM((SALT34.StrType)le.fname),TRIM((SALT34.StrType)le.lname),TRIM((SALT34.StrType)le.prim_range),TRIM((SALT34.StrType)le.p_city_name),TRIM((SALT34.StrType)le.v_city_name),TRIM((SALT34.StrType)le.st),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.prep_address_line1),TRIM((SALT34.StrType)le.prep_address_line_last)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,36,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT34.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 36);
  SELF.FldNo2 := 1 + (C % 36);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.rcid <> 0,TRIM((SALT34.StrType)le.rcid), ''),IF (le.powid <> 0,TRIM((SALT34.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT34.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT34.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT34.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT34.StrType)le.ultid), ''),IF (le.did <> 0,TRIM((SALT34.StrType)le.did), ''),IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),IF (le.process_date <> 0,TRIM((SALT34.StrType)le.process_date), ''),TRIM((SALT34.StrType)le.record_type),TRIM((SALT34.StrType)le.pid),TRIM((SALT34.StrType)le.address_type_code),TRIM((SALT34.StrType)le.url),TRIM((SALT34.StrType)le.sic1),TRIM((SALT34.StrType)le.sic2),TRIM((SALT34.StrType)le.sic3),TRIM((SALT34.StrType)le.sic4),TRIM((SALT34.StrType)le.sic5),TRIM((SALT34.StrType)le.incorporation_state),TRIM((SALT34.StrType)le.email),TRIM((SALT34.StrType)le.contact_title),TRIM((SALT34.StrType)le.normcompany_type),TRIM((SALT34.StrType)le.clean_company_name),TRIM((SALT34.StrType)le.clean_phone),TRIM((SALT34.StrType)le.fname),TRIM((SALT34.StrType)le.lname),TRIM((SALT34.StrType)le.prim_range),TRIM((SALT34.StrType)le.p_city_name),TRIM((SALT34.StrType)le.v_city_name),TRIM((SALT34.StrType)le.st),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.prep_address_line1),TRIM((SALT34.StrType)le.prep_address_line_last)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.rcid <> 0,TRIM((SALT34.StrType)le.rcid), ''),IF (le.powid <> 0,TRIM((SALT34.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT34.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT34.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT34.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT34.StrType)le.ultid), ''),IF (le.did <> 0,TRIM((SALT34.StrType)le.did), ''),IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),IF (le.process_date <> 0,TRIM((SALT34.StrType)le.process_date), ''),TRIM((SALT34.StrType)le.record_type),TRIM((SALT34.StrType)le.pid),TRIM((SALT34.StrType)le.address_type_code),TRIM((SALT34.StrType)le.url),TRIM((SALT34.StrType)le.sic1),TRIM((SALT34.StrType)le.sic2),TRIM((SALT34.StrType)le.sic3),TRIM((SALT34.StrType)le.sic4),TRIM((SALT34.StrType)le.sic5),TRIM((SALT34.StrType)le.incorporation_state),TRIM((SALT34.StrType)le.email),TRIM((SALT34.StrType)le.contact_title),TRIM((SALT34.StrType)le.normcompany_type),TRIM((SALT34.StrType)le.clean_company_name),TRIM((SALT34.StrType)le.clean_phone),TRIM((SALT34.StrType)le.fname),TRIM((SALT34.StrType)le.lname),TRIM((SALT34.StrType)le.prim_range),TRIM((SALT34.StrType)le.p_city_name),TRIM((SALT34.StrType)le.v_city_name),TRIM((SALT34.StrType)le.st),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.prep_address_line1),TRIM((SALT34.StrType)le.prep_address_line_last)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),36*36,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'rcid'}
      ,{2,'powid'}
      ,{3,'proxid'}
      ,{4,'seleid'}
      ,{5,'orgid'}
      ,{6,'ultid'}
      ,{7,'did'}
      ,{8,'dt_first_seen'}
      ,{9,'dt_last_seen'}
      ,{10,'dt_vendor_first_reported'}
      ,{11,'dt_vendor_last_reported'}
      ,{12,'process_date'}
      ,{13,'record_type'}
      ,{14,'pid'}
      ,{15,'address_type_code'}
      ,{16,'url'}
      ,{17,'sic1'}
      ,{18,'sic2'}
      ,{19,'sic3'}
      ,{20,'sic4'}
      ,{21,'sic5'}
      ,{22,'incorporation_state'}
      ,{23,'email'}
      ,{24,'contact_title'}
      ,{25,'normcompany_type'}
      ,{26,'clean_company_name'}
      ,{27,'clean_phone'}
      ,{28,'fname'}
      ,{29,'lname'}
      ,{30,'prim_range'}
      ,{31,'p_city_name'}
      ,{32,'v_city_name'}
      ,{33,'st'}
      ,{34,'zip'}
      ,{35,'prep_address_line1'}
      ,{36,'prep_address_line_last'}],SALT34.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT34.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT34.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT34.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Fields.InValid_rcid((SALT34.StrType)le.rcid),
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
    Base_Fields.InValid_process_date((SALT34.StrType)le.process_date),
    Base_Fields.InValid_record_type((SALT34.StrType)le.record_type),
    Base_Fields.InValid_pid((SALT34.StrType)le.pid),
    Base_Fields.InValid_address_type_code((SALT34.StrType)le.address_type_code),
    Base_Fields.InValid_url((SALT34.StrType)le.url),
    Base_Fields.InValid_sic1((SALT34.StrType)le.sic1),
    Base_Fields.InValid_sic2((SALT34.StrType)le.sic2),
    Base_Fields.InValid_sic3((SALT34.StrType)le.sic3),
    Base_Fields.InValid_sic4((SALT34.StrType)le.sic4),
    Base_Fields.InValid_sic5((SALT34.StrType)le.sic5),
    Base_Fields.InValid_incorporation_state((SALT34.StrType)le.incorporation_state),
    Base_Fields.InValid_email((SALT34.StrType)le.email),
    Base_Fields.InValid_contact_title((SALT34.StrType)le.contact_title),
    Base_Fields.InValid_normcompany_type((SALT34.StrType)le.normcompany_type),
    Base_Fields.InValid_clean_company_name((SALT34.StrType)le.clean_company_name),
    Base_Fields.InValid_clean_phone((SALT34.StrType)le.clean_phone),
    Base_Fields.InValid_fname((SALT34.StrType)le.fname),
    Base_Fields.InValid_lname((SALT34.StrType)le.lname),
    Base_Fields.InValid_prim_range((SALT34.StrType)le.prim_range),
    Base_Fields.InValid_p_city_name((SALT34.StrType)le.p_city_name),
    Base_Fields.InValid_v_city_name((SALT34.StrType)le.v_city_name),
    Base_Fields.InValid_st((SALT34.StrType)le.st),
    Base_Fields.InValid_zip((SALT34.StrType)le.zip),
    Base_Fields.InValid_prep_address_line1((SALT34.StrType)le.prep_address_line1),
    Base_Fields.InValid_prep_address_line_last((SALT34.StrType)le.prep_address_line_last),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,36,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_rcid','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_record_type','invalid_numeric','invalid_address_type_code','invalid_url','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_st','invalid_email','invalid_mandatory','invalid_norm_type','invalid_mandatory','invalid_phone','invalid_alphanum_specials','invalid_alphanum_specials','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_st','invalid_zip5','invalid_mandatory','invalid_mandatory');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Fields.InValidMessage_rcid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_did(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_pid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_address_type_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_url(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_incorporation_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_email(TotalErrors.ErrorNum),Base_Fields.InValidMessage_contact_title(TotalErrors.ErrorNum),Base_Fields.InValidMessage_normcompany_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_company_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_address_line1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_address_line_last(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
