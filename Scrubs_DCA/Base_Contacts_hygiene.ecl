IMPORT ut,SALT34;
EXPORT Base_Contacts_hygiene(dataset(Base_Contacts_layout_DCA) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT34.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_rid_pcnt := AVE(GROUP,IF(h.rid = (TYPEOF(h.rid))'',0,100));
    maxlength_rid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rid)));
    avelength_rid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rid)),h.rid<>(typeof(h.rid))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
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
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_date_vendor_first_reported_pcnt := AVE(GROUP,IF(h.date_vendor_first_reported = (TYPEOF(h.date_vendor_first_reported))'',0,100));
    maxlength_date_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_vendor_first_reported)));
    avelength_date_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_vendor_first_reported)),h.date_vendor_first_reported<>(typeof(h.date_vendor_first_reported))'');
    populated_date_vendor_last_reported_pcnt := AVE(GROUP,IF(h.date_vendor_last_reported = (TYPEOF(h.date_vendor_last_reported))'',0,100));
    maxlength_date_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_vendor_last_reported)));
    avelength_date_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_vendor_last_reported)),h.date_vendor_last_reported<>(typeof(h.date_vendor_last_reported))'');
    populated_physical_rawaid_pcnt := AVE(GROUP,IF(h.physical_rawaid = (TYPEOF(h.physical_rawaid))'',0,100));
    maxlength_physical_rawaid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_rawaid)));
    avelength_physical_rawaid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_rawaid)),h.physical_rawaid<>(typeof(h.physical_rawaid))'');
    populated_physical_aceaid_pcnt := AVE(GROUP,IF(h.physical_aceaid = (TYPEOF(h.physical_aceaid))'',0,100));
    maxlength_physical_aceaid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_aceaid)));
    avelength_physical_aceaid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_aceaid)),h.physical_aceaid<>(typeof(h.physical_aceaid))'');
    populated_mailing_rawaid_pcnt := AVE(GROUP,IF(h.mailing_rawaid = (TYPEOF(h.mailing_rawaid))'',0,100));
    maxlength_mailing_rawaid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_rawaid)));
    avelength_mailing_rawaid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_rawaid)),h.mailing_rawaid<>(typeof(h.mailing_rawaid))'');
    populated_mailing_aceaid_pcnt := AVE(GROUP,IF(h.mailing_aceaid = (TYPEOF(h.mailing_aceaid))'',0,100));
    maxlength_mailing_aceaid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_aceaid)));
    avelength_mailing_aceaid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_aceaid)),h.mailing_aceaid<>(typeof(h.mailing_aceaid))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_file_type_pcnt := AVE(GROUP,IF(h.file_type = (TYPEOF(h.file_type))'',0,100));
    maxlength_file_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.file_type)));
    avelength_file_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.file_type)),h.file_type<>(typeof(h.file_type))'');
    populated_lncagid_pcnt := AVE(GROUP,IF(h.lncagid = (TYPEOF(h.lncagid))'',0,100));
    maxlength_lncagid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lncagid)));
    avelength_lncagid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lncagid)),h.lncagid<>(typeof(h.lncagid))'');
    populated_lncaghid_pcnt := AVE(GROUP,IF(h.lncaghid = (TYPEOF(h.lncaghid))'',0,100));
    maxlength_lncaghid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lncaghid)));
    avelength_lncaghid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lncaghid)),h.lncaghid<>(typeof(h.lncaghid))'');
    populated_lncaiid_pcnt := AVE(GROUP,IF(h.lncaiid = (TYPEOF(h.lncaiid))'',0,100));
    maxlength_lncaiid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lncaiid)));
    avelength_lncaiid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lncaiid)),h.lncaiid<>(typeof(h.lncaiid))'');
    populated_rawfields_enterprise_num_pcnt := AVE(GROUP,IF(h.rawfields_enterprise_num = (TYPEOF(h.rawfields_enterprise_num))'',0,100));
    maxlength_rawfields_enterprise_num := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_enterprise_num)));
    avelength_rawfields_enterprise_num := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_enterprise_num)),h.rawfields_enterprise_num<>(typeof(h.rawfields_enterprise_num))'');
    populated_rawfields_name_pcnt := AVE(GROUP,IF(h.rawfields_name = (TYPEOF(h.rawfields_name))'',0,100));
    maxlength_rawfields_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_name)));
    avelength_rawfields_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_name)),h.rawfields_name<>(typeof(h.rawfields_name))'');
    populated_rawfields_executive_name_pcnt := AVE(GROUP,IF(h.rawfields_executive_name = (TYPEOF(h.rawfields_executive_name))'',0,100));
    maxlength_rawfields_executive_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_executive_name)));
    avelength_rawfields_executive_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_executive_name)),h.rawfields_executive_name<>(typeof(h.rawfields_executive_name))'');
    populated_rawfields_executive_title_pcnt := AVE(GROUP,IF(h.rawfields_executive_title = (TYPEOF(h.rawfields_executive_title))'',0,100));
    maxlength_rawfields_executive_title := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_executive_title)));
    avelength_rawfields_executive_title := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_executive_title)),h.rawfields_executive_title<>(typeof(h.rawfields_executive_title))'');
    populated_rawfields_executive_code_pcnt := AVE(GROUP,IF(h.rawfields_executive_code = (TYPEOF(h.rawfields_executive_code))'',0,100));
    maxlength_rawfields_executive_code := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_executive_code)));
    avelength_rawfields_executive_code := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_executive_code)),h.rawfields_executive_code<>(typeof(h.rawfields_executive_code))'');
    populated_clean_name_title_pcnt := AVE(GROUP,IF(h.clean_name_title = (TYPEOF(h.clean_name_title))'',0,100));
    maxlength_clean_name_title := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_name_title)));
    avelength_clean_name_title := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_name_title)),h.clean_name_title<>(typeof(h.clean_name_title))'');
    populated_clean_name_lname_pcnt := AVE(GROUP,IF(h.clean_name_lname = (TYPEOF(h.clean_name_lname))'',0,100));
    maxlength_clean_name_lname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_name_lname)));
    avelength_clean_name_lname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_name_lname)),h.clean_name_lname<>(typeof(h.clean_name_lname))'');
    populated_physical_address_prim_name_pcnt := AVE(GROUP,IF(h.physical_address_prim_name = (TYPEOF(h.physical_address_prim_name))'',0,100));
    maxlength_physical_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_prim_name)));
    avelength_physical_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_prim_name)),h.physical_address_prim_name<>(typeof(h.physical_address_prim_name))'');
    populated_physical_address_p_city_name_pcnt := AVE(GROUP,IF(h.physical_address_p_city_name = (TYPEOF(h.physical_address_p_city_name))'',0,100));
    maxlength_physical_address_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_p_city_name)));
    avelength_physical_address_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_p_city_name)),h.physical_address_p_city_name<>(typeof(h.physical_address_p_city_name))'');
    populated_physical_address_v_city_name_pcnt := AVE(GROUP,IF(h.physical_address_v_city_name = (TYPEOF(h.physical_address_v_city_name))'',0,100));
    maxlength_physical_address_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_v_city_name)));
    avelength_physical_address_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_v_city_name)),h.physical_address_v_city_name<>(typeof(h.physical_address_v_city_name))'');
    populated_physical_address_st_pcnt := AVE(GROUP,IF(h.physical_address_st = (TYPEOF(h.physical_address_st))'',0,100));
    maxlength_physical_address_st := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_st)));
    avelength_physical_address_st := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_st)),h.physical_address_st<>(typeof(h.physical_address_st))'');
    populated_physical_address_zip_pcnt := AVE(GROUP,IF(h.physical_address_zip = (TYPEOF(h.physical_address_zip))'',0,100));
    maxlength_physical_address_zip := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_zip)));
    avelength_physical_address_zip := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_zip)),h.physical_address_zip<>(typeof(h.physical_address_zip))'');
    populated_mailing_address_prim_name_pcnt := AVE(GROUP,IF(h.mailing_address_prim_name = (TYPEOF(h.mailing_address_prim_name))'',0,100));
    maxlength_mailing_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_prim_name)));
    avelength_mailing_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_prim_name)),h.mailing_address_prim_name<>(typeof(h.mailing_address_prim_name))'');
    populated_mailing_address_p_city_name_pcnt := AVE(GROUP,IF(h.mailing_address_p_city_name = (TYPEOF(h.mailing_address_p_city_name))'',0,100));
    maxlength_mailing_address_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_p_city_name)));
    avelength_mailing_address_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_p_city_name)),h.mailing_address_p_city_name<>(typeof(h.mailing_address_p_city_name))'');
    populated_mailing_address_v_city_name_pcnt := AVE(GROUP,IF(h.mailing_address_v_city_name = (TYPEOF(h.mailing_address_v_city_name))'',0,100));
    maxlength_mailing_address_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_v_city_name)));
    avelength_mailing_address_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_v_city_name)),h.mailing_address_v_city_name<>(typeof(h.mailing_address_v_city_name))'');
    populated_mailing_address_st_pcnt := AVE(GROUP,IF(h.mailing_address_st = (TYPEOF(h.mailing_address_st))'',0,100));
    maxlength_mailing_address_st := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_st)));
    avelength_mailing_address_st := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_st)),h.mailing_address_st<>(typeof(h.mailing_address_st))'');
    populated_mailing_address_zip_pcnt := AVE(GROUP,IF(h.mailing_address_zip = (TYPEOF(h.mailing_address_zip))'',0,100));
    maxlength_mailing_address_zip := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_zip)));
    avelength_mailing_address_zip := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_zip)),h.mailing_address_zip<>(typeof(h.mailing_address_zip))'');
    populated_clean_phones_phone_pcnt := AVE(GROUP,IF(h.clean_phones_phone = (TYPEOF(h.clean_phones_phone))'',0,100));
    maxlength_clean_phones_phone := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phones_phone)));
    avelength_clean_phones_phone := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phones_phone)),h.clean_phones_phone<>(typeof(h.clean_phones_phone))'');
    populated_clean_phones_fax_pcnt := AVE(GROUP,IF(h.clean_phones_fax = (TYPEOF(h.clean_phones_fax))'',0,100));
    maxlength_clean_phones_fax := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phones_fax)));
    avelength_clean_phones_fax := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phones_fax)),h.clean_phones_fax<>(typeof(h.clean_phones_fax))'');
    populated_clean_phones_telex_pcnt := AVE(GROUP,IF(h.clean_phones_telex = (TYPEOF(h.clean_phones_telex))'',0,100));
    maxlength_clean_phones_telex := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phones_telex)));
    avelength_clean_phones_telex := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phones_telex)),h.clean_phones_telex<>(typeof(h.clean_phones_telex))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_rid_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_physical_rawaid_pcnt *   0.00 / 100 + T.Populated_physical_aceaid_pcnt *   0.00 / 100 + T.Populated_mailing_rawaid_pcnt *   0.00 / 100 + T.Populated_mailing_aceaid_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_file_type_pcnt *   0.00 / 100 + T.Populated_lncagid_pcnt *   0.00 / 100 + T.Populated_lncaghid_pcnt *   0.00 / 100 + T.Populated_lncaiid_pcnt *   0.00 / 100 + T.Populated_rawfields_enterprise_num_pcnt *   0.00 / 100 + T.Populated_rawfields_name_pcnt *   0.00 / 100 + T.Populated_rawfields_executive_name_pcnt *   0.00 / 100 + T.Populated_rawfields_executive_title_pcnt *   0.00 / 100 + T.Populated_rawfields_executive_code_pcnt *   0.00 / 100 + T.Populated_clean_name_title_pcnt *   0.00 / 100 + T.Populated_clean_name_lname_pcnt *   0.00 / 100 + T.Populated_physical_address_prim_name_pcnt *   0.00 / 100 + T.Populated_physical_address_p_city_name_pcnt *   0.00 / 100 + T.Populated_physical_address_v_city_name_pcnt *   0.00 / 100 + T.Populated_physical_address_st_pcnt *   0.00 / 100 + T.Populated_physical_address_zip_pcnt *   0.00 / 100 + T.Populated_mailing_address_prim_name_pcnt *   0.00 / 100 + T.Populated_mailing_address_p_city_name_pcnt *   0.00 / 100 + T.Populated_mailing_address_v_city_name_pcnt *   0.00 / 100 + T.Populated_mailing_address_st_pcnt *   0.00 / 100 + T.Populated_mailing_address_zip_pcnt *   0.00 / 100 + T.Populated_clean_phones_phone_pcnt *   0.00 / 100 + T.Populated_clean_phones_fax_pcnt *   0.00 / 100 + T.Populated_clean_phones_telex_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'rid','did','bdid','powid','proxid','seleid','orgid','ultid','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','physical_rawaid','physical_aceaid','mailing_rawaid','mailing_aceaid','record_type','file_type','lncagid','lncaghid','lncaiid','rawfields_enterprise_num','rawfields_name','rawfields_executive_name','rawfields_executive_title','rawfields_executive_code','clean_name_title','clean_name_lname','physical_address_prim_name','physical_address_p_city_name','physical_address_v_city_name','physical_address_st','physical_address_zip','mailing_address_prim_name','mailing_address_p_city_name','mailing_address_v_city_name','mailing_address_st','mailing_address_zip','clean_phones_phone','clean_phones_fax','clean_phones_telex');
  SELF.populated_pcnt := CHOOSE(C,le.populated_rid_pcnt,le.populated_did_pcnt,le.populated_bdid_pcnt,le.populated_powid_pcnt,le.populated_proxid_pcnt,le.populated_seleid_pcnt,le.populated_orgid_pcnt,le.populated_ultid_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_physical_rawaid_pcnt,le.populated_physical_aceaid_pcnt,le.populated_mailing_rawaid_pcnt,le.populated_mailing_aceaid_pcnt,le.populated_record_type_pcnt,le.populated_file_type_pcnt,le.populated_lncagid_pcnt,le.populated_lncaghid_pcnt,le.populated_lncaiid_pcnt,le.populated_rawfields_enterprise_num_pcnt,le.populated_rawfields_name_pcnt,le.populated_rawfields_executive_name_pcnt,le.populated_rawfields_executive_title_pcnt,le.populated_rawfields_executive_code_pcnt,le.populated_clean_name_title_pcnt,le.populated_clean_name_lname_pcnt,le.populated_physical_address_prim_name_pcnt,le.populated_physical_address_p_city_name_pcnt,le.populated_physical_address_v_city_name_pcnt,le.populated_physical_address_st_pcnt,le.populated_physical_address_zip_pcnt,le.populated_mailing_address_prim_name_pcnt,le.populated_mailing_address_p_city_name_pcnt,le.populated_mailing_address_v_city_name_pcnt,le.populated_mailing_address_st_pcnt,le.populated_mailing_address_zip_pcnt,le.populated_clean_phones_phone_pcnt,le.populated_clean_phones_fax_pcnt,le.populated_clean_phones_telex_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_rid,le.maxlength_did,le.maxlength_bdid,le.maxlength_powid,le.maxlength_proxid,le.maxlength_seleid,le.maxlength_orgid,le.maxlength_ultid,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_physical_rawaid,le.maxlength_physical_aceaid,le.maxlength_mailing_rawaid,le.maxlength_mailing_aceaid,le.maxlength_record_type,le.maxlength_file_type,le.maxlength_lncagid,le.maxlength_lncaghid,le.maxlength_lncaiid,le.maxlength_rawfields_enterprise_num,le.maxlength_rawfields_name,le.maxlength_rawfields_executive_name,le.maxlength_rawfields_executive_title,le.maxlength_rawfields_executive_code,le.maxlength_clean_name_title,le.maxlength_clean_name_lname,le.maxlength_physical_address_prim_name,le.maxlength_physical_address_p_city_name,le.maxlength_physical_address_v_city_name,le.maxlength_physical_address_st,le.maxlength_physical_address_zip,le.maxlength_mailing_address_prim_name,le.maxlength_mailing_address_p_city_name,le.maxlength_mailing_address_v_city_name,le.maxlength_mailing_address_st,le.maxlength_mailing_address_zip,le.maxlength_clean_phones_phone,le.maxlength_clean_phones_fax,le.maxlength_clean_phones_telex);
  SELF.avelength := CHOOSE(C,le.avelength_rid,le.avelength_did,le.avelength_bdid,le.avelength_powid,le.avelength_proxid,le.avelength_seleid,le.avelength_orgid,le.avelength_ultid,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_physical_rawaid,le.avelength_physical_aceaid,le.avelength_mailing_rawaid,le.avelength_mailing_aceaid,le.avelength_record_type,le.avelength_file_type,le.avelength_lncagid,le.avelength_lncaghid,le.avelength_lncaiid,le.avelength_rawfields_enterprise_num,le.avelength_rawfields_name,le.avelength_rawfields_executive_name,le.avelength_rawfields_executive_title,le.avelength_rawfields_executive_code,le.avelength_clean_name_title,le.avelength_clean_name_lname,le.avelength_physical_address_prim_name,le.avelength_physical_address_p_city_name,le.avelength_physical_address_v_city_name,le.avelength_physical_address_st,le.avelength_physical_address_zip,le.avelength_mailing_address_prim_name,le.avelength_mailing_address_p_city_name,le.avelength_mailing_address_v_city_name,le.avelength_mailing_address_st,le.avelength_mailing_address_zip,le.avelength_clean_phones_phone,le.avelength_clean_phones_fax,le.avelength_clean_phones_telex);
END;
EXPORT invSummary := NORMALIZE(summary0, 41, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT34.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.rid <> 0,TRIM((SALT34.StrType)le.rid), ''),IF (le.did <> 0,TRIM((SALT34.StrType)le.did), ''),IF (le.bdid <> 0,TRIM((SALT34.StrType)le.bdid), ''),IF (le.powid <> 0,TRIM((SALT34.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT34.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT34.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT34.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT34.StrType)le.ultid), ''),IF (le.date_first_seen <> 0,TRIM((SALT34.StrType)le.date_first_seen), ''),IF (le.date_last_seen <> 0,TRIM((SALT34.StrType)le.date_last_seen), ''),IF (le.date_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.date_vendor_last_reported), ''),IF (le.physical_rawaid <> 0,TRIM((SALT34.StrType)le.physical_rawaid), ''),IF (le.physical_aceaid <> 0,TRIM((SALT34.StrType)le.physical_aceaid), ''),IF (le.mailing_rawaid <> 0,TRIM((SALT34.StrType)le.mailing_rawaid), ''),IF (le.mailing_aceaid <> 0,TRIM((SALT34.StrType)le.mailing_aceaid), ''),IF (le.record_type <> 0,TRIM((SALT34.StrType)le.record_type), ''),TRIM((SALT34.StrType)le.file_type),IF (le.lncagid <> 0,TRIM((SALT34.StrType)le.lncagid), ''),IF (le.lncaghid <> 0,TRIM((SALT34.StrType)le.lncaghid), ''),IF (le.lncaiid <> 0,TRIM((SALT34.StrType)le.lncaiid), ''),TRIM((SALT34.StrType)le.rawfields_enterprise_num),TRIM((SALT34.StrType)le.rawfields_name),TRIM((SALT34.StrType)le.rawfields_executive_name),TRIM((SALT34.StrType)le.rawfields_executive_title),TRIM((SALT34.StrType)le.rawfields_executive_code),TRIM((SALT34.StrType)le.clean_name_title),TRIM((SALT34.StrType)le.clean_name_lname),TRIM((SALT34.StrType)le.physical_address_prim_name),TRIM((SALT34.StrType)le.physical_address_p_city_name),TRIM((SALT34.StrType)le.physical_address_v_city_name),TRIM((SALT34.StrType)le.physical_address_st),TRIM((SALT34.StrType)le.physical_address_zip),TRIM((SALT34.StrType)le.mailing_address_prim_name),TRIM((SALT34.StrType)le.mailing_address_p_city_name),TRIM((SALT34.StrType)le.mailing_address_v_city_name),TRIM((SALT34.StrType)le.mailing_address_st),TRIM((SALT34.StrType)le.mailing_address_zip),TRIM((SALT34.StrType)le.clean_phones_phone),TRIM((SALT34.StrType)le.clean_phones_fax),TRIM((SALT34.StrType)le.clean_phones_telex)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,41,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT34.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 41);
  SELF.FldNo2 := 1 + (C % 41);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.rid <> 0,TRIM((SALT34.StrType)le.rid), ''),IF (le.did <> 0,TRIM((SALT34.StrType)le.did), ''),IF (le.bdid <> 0,TRIM((SALT34.StrType)le.bdid), ''),IF (le.powid <> 0,TRIM((SALT34.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT34.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT34.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT34.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT34.StrType)le.ultid), ''),IF (le.date_first_seen <> 0,TRIM((SALT34.StrType)le.date_first_seen), ''),IF (le.date_last_seen <> 0,TRIM((SALT34.StrType)le.date_last_seen), ''),IF (le.date_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.date_vendor_last_reported), ''),IF (le.physical_rawaid <> 0,TRIM((SALT34.StrType)le.physical_rawaid), ''),IF (le.physical_aceaid <> 0,TRIM((SALT34.StrType)le.physical_aceaid), ''),IF (le.mailing_rawaid <> 0,TRIM((SALT34.StrType)le.mailing_rawaid), ''),IF (le.mailing_aceaid <> 0,TRIM((SALT34.StrType)le.mailing_aceaid), ''),IF (le.record_type <> 0,TRIM((SALT34.StrType)le.record_type), ''),TRIM((SALT34.StrType)le.file_type),IF (le.lncagid <> 0,TRIM((SALT34.StrType)le.lncagid), ''),IF (le.lncaghid <> 0,TRIM((SALT34.StrType)le.lncaghid), ''),IF (le.lncaiid <> 0,TRIM((SALT34.StrType)le.lncaiid), ''),TRIM((SALT34.StrType)le.rawfields_enterprise_num),TRIM((SALT34.StrType)le.rawfields_name),TRIM((SALT34.StrType)le.rawfields_executive_name),TRIM((SALT34.StrType)le.rawfields_executive_title),TRIM((SALT34.StrType)le.rawfields_executive_code),TRIM((SALT34.StrType)le.clean_name_title),TRIM((SALT34.StrType)le.clean_name_lname),TRIM((SALT34.StrType)le.physical_address_prim_name),TRIM((SALT34.StrType)le.physical_address_p_city_name),TRIM((SALT34.StrType)le.physical_address_v_city_name),TRIM((SALT34.StrType)le.physical_address_st),TRIM((SALT34.StrType)le.physical_address_zip),TRIM((SALT34.StrType)le.mailing_address_prim_name),TRIM((SALT34.StrType)le.mailing_address_p_city_name),TRIM((SALT34.StrType)le.mailing_address_v_city_name),TRIM((SALT34.StrType)le.mailing_address_st),TRIM((SALT34.StrType)le.mailing_address_zip),TRIM((SALT34.StrType)le.clean_phones_phone),TRIM((SALT34.StrType)le.clean_phones_fax),TRIM((SALT34.StrType)le.clean_phones_telex)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.rid <> 0,TRIM((SALT34.StrType)le.rid), ''),IF (le.did <> 0,TRIM((SALT34.StrType)le.did), ''),IF (le.bdid <> 0,TRIM((SALT34.StrType)le.bdid), ''),IF (le.powid <> 0,TRIM((SALT34.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT34.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT34.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT34.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT34.StrType)le.ultid), ''),IF (le.date_first_seen <> 0,TRIM((SALT34.StrType)le.date_first_seen), ''),IF (le.date_last_seen <> 0,TRIM((SALT34.StrType)le.date_last_seen), ''),IF (le.date_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.date_vendor_last_reported), ''),IF (le.physical_rawaid <> 0,TRIM((SALT34.StrType)le.physical_rawaid), ''),IF (le.physical_aceaid <> 0,TRIM((SALT34.StrType)le.physical_aceaid), ''),IF (le.mailing_rawaid <> 0,TRIM((SALT34.StrType)le.mailing_rawaid), ''),IF (le.mailing_aceaid <> 0,TRIM((SALT34.StrType)le.mailing_aceaid), ''),IF (le.record_type <> 0,TRIM((SALT34.StrType)le.record_type), ''),TRIM((SALT34.StrType)le.file_type),IF (le.lncagid <> 0,TRIM((SALT34.StrType)le.lncagid), ''),IF (le.lncaghid <> 0,TRIM((SALT34.StrType)le.lncaghid), ''),IF (le.lncaiid <> 0,TRIM((SALT34.StrType)le.lncaiid), ''),TRIM((SALT34.StrType)le.rawfields_enterprise_num),TRIM((SALT34.StrType)le.rawfields_name),TRIM((SALT34.StrType)le.rawfields_executive_name),TRIM((SALT34.StrType)le.rawfields_executive_title),TRIM((SALT34.StrType)le.rawfields_executive_code),TRIM((SALT34.StrType)le.clean_name_title),TRIM((SALT34.StrType)le.clean_name_lname),TRIM((SALT34.StrType)le.physical_address_prim_name),TRIM((SALT34.StrType)le.physical_address_p_city_name),TRIM((SALT34.StrType)le.physical_address_v_city_name),TRIM((SALT34.StrType)le.physical_address_st),TRIM((SALT34.StrType)le.physical_address_zip),TRIM((SALT34.StrType)le.mailing_address_prim_name),TRIM((SALT34.StrType)le.mailing_address_p_city_name),TRIM((SALT34.StrType)le.mailing_address_v_city_name),TRIM((SALT34.StrType)le.mailing_address_st),TRIM((SALT34.StrType)le.mailing_address_zip),TRIM((SALT34.StrType)le.clean_phones_phone),TRIM((SALT34.StrType)le.clean_phones_fax),TRIM((SALT34.StrType)le.clean_phones_telex)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),41*41,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'rid'}
      ,{2,'did'}
      ,{3,'bdid'}
      ,{4,'powid'}
      ,{5,'proxid'}
      ,{6,'seleid'}
      ,{7,'orgid'}
      ,{8,'ultid'}
      ,{9,'date_first_seen'}
      ,{10,'date_last_seen'}
      ,{11,'date_vendor_first_reported'}
      ,{12,'date_vendor_last_reported'}
      ,{13,'physical_rawaid'}
      ,{14,'physical_aceaid'}
      ,{15,'mailing_rawaid'}
      ,{16,'mailing_aceaid'}
      ,{17,'record_type'}
      ,{18,'file_type'}
      ,{19,'lncagid'}
      ,{20,'lncaghid'}
      ,{21,'lncaiid'}
      ,{22,'rawfields_enterprise_num'}
      ,{23,'rawfields_name'}
      ,{24,'rawfields_executive_name'}
      ,{25,'rawfields_executive_title'}
      ,{26,'rawfields_executive_code'}
      ,{27,'clean_name_title'}
      ,{28,'clean_name_lname'}
      ,{29,'physical_address_prim_name'}
      ,{30,'physical_address_p_city_name'}
      ,{31,'physical_address_v_city_name'}
      ,{32,'physical_address_st'}
      ,{33,'physical_address_zip'}
      ,{34,'mailing_address_prim_name'}
      ,{35,'mailing_address_p_city_name'}
      ,{36,'mailing_address_v_city_name'}
      ,{37,'mailing_address_st'}
      ,{38,'mailing_address_zip'}
      ,{39,'clean_phones_phone'}
      ,{40,'clean_phones_fax'}
      ,{41,'clean_phones_telex'}],SALT34.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT34.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT34.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT34.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Contacts_Fields.InValid_rid((SALT34.StrType)le.rid),
    Base_Contacts_Fields.InValid_did((SALT34.StrType)le.did),
    Base_Contacts_Fields.InValid_bdid((SALT34.StrType)le.bdid),
    Base_Contacts_Fields.InValid_powid((SALT34.StrType)le.powid),
    Base_Contacts_Fields.InValid_proxid((SALT34.StrType)le.proxid),
    Base_Contacts_Fields.InValid_seleid((SALT34.StrType)le.seleid),
    Base_Contacts_Fields.InValid_orgid((SALT34.StrType)le.orgid),
    Base_Contacts_Fields.InValid_ultid((SALT34.StrType)le.ultid),
    Base_Contacts_Fields.InValid_date_first_seen((SALT34.StrType)le.date_first_seen),
    Base_Contacts_Fields.InValid_date_last_seen((SALT34.StrType)le.date_last_seen),
    Base_Contacts_Fields.InValid_date_vendor_first_reported((SALT34.StrType)le.date_vendor_first_reported),
    Base_Contacts_Fields.InValid_date_vendor_last_reported((SALT34.StrType)le.date_vendor_last_reported),
    Base_Contacts_Fields.InValid_physical_rawaid((SALT34.StrType)le.physical_rawaid),
    Base_Contacts_Fields.InValid_physical_aceaid((SALT34.StrType)le.physical_aceaid),
    Base_Contacts_Fields.InValid_mailing_rawaid((SALT34.StrType)le.mailing_rawaid),
    Base_Contacts_Fields.InValid_mailing_aceaid((SALT34.StrType)le.mailing_aceaid),
    Base_Contacts_Fields.InValid_record_type((SALT34.StrType)le.record_type),
    Base_Contacts_Fields.InValid_file_type((SALT34.StrType)le.file_type),
    Base_Contacts_Fields.InValid_lncagid((SALT34.StrType)le.lncagid),
    Base_Contacts_Fields.InValid_lncaghid((SALT34.StrType)le.lncaghid),
    Base_Contacts_Fields.InValid_lncaiid((SALT34.StrType)le.lncaiid),
    Base_Contacts_Fields.InValid_rawfields_enterprise_num((SALT34.StrType)le.rawfields_enterprise_num),
    Base_Contacts_Fields.InValid_rawfields_name((SALT34.StrType)le.rawfields_name),
    Base_Contacts_Fields.InValid_rawfields_executive_name((SALT34.StrType)le.rawfields_executive_name),
    Base_Contacts_Fields.InValid_rawfields_executive_title((SALT34.StrType)le.rawfields_executive_title),
    Base_Contacts_Fields.InValid_rawfields_executive_code((SALT34.StrType)le.rawfields_executive_code),
    Base_Contacts_Fields.InValid_clean_name_title((SALT34.StrType)le.clean_name_title),
    Base_Contacts_Fields.InValid_clean_name_lname((SALT34.StrType)le.clean_name_lname),
    Base_Contacts_Fields.InValid_physical_address_prim_name((SALT34.StrType)le.physical_address_prim_name),
    Base_Contacts_Fields.InValid_physical_address_p_city_name((SALT34.StrType)le.physical_address_p_city_name),
    Base_Contacts_Fields.InValid_physical_address_v_city_name((SALT34.StrType)le.physical_address_v_city_name),
    Base_Contacts_Fields.InValid_physical_address_st((SALT34.StrType)le.physical_address_st),
    Base_Contacts_Fields.InValid_physical_address_zip((SALT34.StrType)le.physical_address_zip),
    Base_Contacts_Fields.InValid_mailing_address_prim_name((SALT34.StrType)le.mailing_address_prim_name),
    Base_Contacts_Fields.InValid_mailing_address_p_city_name((SALT34.StrType)le.mailing_address_p_city_name),
    Base_Contacts_Fields.InValid_mailing_address_v_city_name((SALT34.StrType)le.mailing_address_v_city_name),
    Base_Contacts_Fields.InValid_mailing_address_st((SALT34.StrType)le.mailing_address_st),
    Base_Contacts_Fields.InValid_mailing_address_zip((SALT34.StrType)le.mailing_address_zip),
    Base_Contacts_Fields.InValid_clean_phones_phone((SALT34.StrType)le.clean_phones_phone),
    Base_Contacts_Fields.InValid_clean_phones_fax((SALT34.StrType)le.clean_phones_fax),
    Base_Contacts_Fields.InValid_clean_phones_telex((SALT34.StrType)le.clean_phones_telex),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,41,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Contacts_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_rid','invalid_numeric','invalid_bdid','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_record_type','invalid_file_type','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_phone','invalid_phone','invalid_phone');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Contacts_Fields.InValidMessage_rid(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_did(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_physical_rawaid(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_physical_aceaid(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_mailing_rawaid(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_mailing_aceaid(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_file_type(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_lncagid(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_lncaghid(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_lncaiid(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_rawfields_enterprise_num(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_rawfields_name(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_rawfields_executive_name(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_rawfields_executive_title(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_rawfields_executive_code(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_clean_name_title(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_clean_name_lname(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_physical_address_prim_name(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_physical_address_p_city_name(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_physical_address_v_city_name(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_physical_address_st(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_physical_address_zip(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_mailing_address_prim_name(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_mailing_address_p_city_name(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_mailing_address_v_city_name(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_mailing_address_st(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_mailing_address_zip(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_clean_phones_phone(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_clean_phones_fax(TotalErrors.ErrorNum),Base_Contacts_Fields.InValidMessage_clean_phones_telex(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
