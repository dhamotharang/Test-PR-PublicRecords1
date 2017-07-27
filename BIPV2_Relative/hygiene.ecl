import ut,SALT25;
export hygiene(dataset(layout_DOT_Base) h) := MODULE
//A simple summary record
export Summary(SALT25.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_cnp_hasnumber_pcnt := AVE(GROUP,IF(h.cnp_hasnumber = (TYPEOF(h.cnp_hasnumber))'',0,100));
    maxlength_cnp_hasnumber := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.cnp_hasnumber)));
    avelength_cnp_hasnumber := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.cnp_hasnumber)),h.cnp_hasnumber<>(typeof(h.cnp_hasnumber))'');
    populated_active_enterprise_number_pcnt := AVE(GROUP,IF(h.active_enterprise_number = (TYPEOF(h.active_enterprise_number))'',0,100));
    maxlength_active_enterprise_number := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.active_enterprise_number)));
    avelength_active_enterprise_number := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.active_enterprise_number)),h.active_enterprise_number<>(typeof(h.active_enterprise_number))'');
    populated_source_record_id_pcnt := AVE(GROUP,IF(h.source_record_id = (TYPEOF(h.source_record_id))'',0,100));
    maxlength_source_record_id := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.source_record_id)));
    avelength_source_record_id := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.source_record_id)),h.source_record_id<>(typeof(h.source_record_id))'');
    populated_contact_ssn_pcnt := AVE(GROUP,IF(h.contact_ssn = (TYPEOF(h.contact_ssn))'',0,100));
    maxlength_contact_ssn := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.contact_ssn)));
    avelength_contact_ssn := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.contact_ssn)),h.contact_ssn<>(typeof(h.contact_ssn))'');
    populated_company_fein_pcnt := AVE(GROUP,IF(h.company_fein = (TYPEOF(h.company_fein))'',0,100));
    maxlength_company_fein := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.company_fein)));
    avelength_company_fein := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.company_fein)),h.company_fein<>(typeof(h.company_fein))'');
    populated_company_charter_number_pcnt := AVE(GROUP,IF(h.company_charter_number = (TYPEOF(h.company_charter_number))'',0,100));
    maxlength_company_charter_number := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.company_charter_number)));
    avelength_company_charter_number := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.company_charter_number)),h.company_charter_number<>(typeof(h.company_charter_number))'');
    populated_active_duns_number_pcnt := AVE(GROUP,IF(h.active_duns_number = (TYPEOF(h.active_duns_number))'',0,100));
    maxlength_active_duns_number := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.active_duns_number)));
    avelength_active_duns_number := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.active_duns_number)),h.active_duns_number<>(typeof(h.active_duns_number))'');
    populated_active_domestic_corp_key_pcnt := AVE(GROUP,IF(h.active_domestic_corp_key = (TYPEOF(h.active_domestic_corp_key))'',0,100));
    maxlength_active_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.active_domestic_corp_key)));
    avelength_active_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.active_domestic_corp_key)),h.active_domestic_corp_key<>(typeof(h.active_domestic_corp_key))'');
    populated_contact_phone_pcnt := AVE(GROUP,IF(h.contact_phone = (TYPEOF(h.contact_phone))'',0,100));
    maxlength_contact_phone := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.contact_phone)));
    avelength_contact_phone := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.contact_phone)),h.contact_phone<>(typeof(h.contact_phone))'');
    populated_cnp_name_pcnt := AVE(GROUP,IF(h.cnp_name = (TYPEOF(h.cnp_name))'',0,100));
    maxlength_cnp_name := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.cnp_name)));
    avelength_cnp_name := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.cnp_name)),h.cnp_name<>(typeof(h.cnp_name))'');
    populated_corp_legal_name_pcnt := AVE(GROUP,IF(h.corp_legal_name = (TYPEOF(h.corp_legal_name))'',0,100));
    maxlength_corp_legal_name := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.corp_legal_name)));
    avelength_corp_legal_name := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.corp_legal_name)),h.corp_legal_name<>(typeof(h.corp_legal_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_cnp_number_pcnt := AVE(GROUP,IF(h.cnp_number = (TYPEOF(h.cnp_number))'',0,100));
    maxlength_cnp_number := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.cnp_number)));
    avelength_cnp_number := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.cnp_number)),h.cnp_number<>(typeof(h.cnp_number))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_company_inc_state_pcnt := AVE(GROUP,IF(h.company_inc_state = (TYPEOF(h.company_inc_state))'',0,100));
    maxlength_company_inc_state := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.company_inc_state)));
    avelength_company_inc_state := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.company_inc_state)),h.company_inc_state<>(typeof(h.company_inc_state))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_cnp_btype_pcnt := AVE(GROUP,IF(h.cnp_btype = (TYPEOF(h.cnp_btype))'',0,100));
    maxlength_cnp_btype := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.cnp_btype)));
    avelength_cnp_btype := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.cnp_btype)),h.cnp_btype<>(typeof(h.cnp_btype))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_iscorp_pcnt := AVE(GROUP,IF(h.iscorp = (TYPEOF(h.iscorp))'',0,100));
    maxlength_iscorp := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.iscorp)));
    avelength_iscorp := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.iscorp)),h.iscorp<>(typeof(h.iscorp))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_cnp_lowv_pcnt := AVE(GROUP,IF(h.cnp_lowv = (TYPEOF(h.cnp_lowv))'',0,100));
    maxlength_cnp_lowv := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.cnp_lowv)));
    avelength_cnp_lowv := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.cnp_lowv)),h.cnp_lowv<>(typeof(h.cnp_lowv))'');
    populated_cnp_translated_pcnt := AVE(GROUP,IF(h.cnp_translated = (TYPEOF(h.cnp_translated))'',0,100));
    maxlength_cnp_translated := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.cnp_translated)));
    avelength_cnp_translated := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.cnp_translated)),h.cnp_translated<>(typeof(h.cnp_translated))'');
    populated_cnp_classid_pcnt := AVE(GROUP,IF(h.cnp_classid = (TYPEOF(h.cnp_classid))'',0,100));
    maxlength_cnp_classid := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.cnp_classid)));
    avelength_cnp_classid := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.cnp_classid)),h.cnp_classid<>(typeof(h.cnp_classid))'');
    populated_company_bdid_pcnt := AVE(GROUP,IF(h.company_bdid = (TYPEOF(h.company_bdid))'',0,100));
    maxlength_company_bdid := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.company_bdid)));
    avelength_company_bdid := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.company_bdid)),h.company_bdid<>(typeof(h.company_bdid))'');
    populated_company_phone_pcnt := AVE(GROUP,IF(h.company_phone = (TYPEOF(h.company_phone))'',0,100));
    maxlength_company_phone := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.company_phone)));
    avelength_company_phone := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.company_phone)),h.company_phone<>(typeof(h.company_phone))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_Company_RAWAID_pcnt := AVE(GROUP,IF(h.Company_RAWAID = (TYPEOF(h.Company_RAWAID))'',0,100));
    maxlength_Company_RAWAID := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.Company_RAWAID)));
    avelength_Company_RAWAID := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.Company_RAWAID)),h.Company_RAWAID<>(typeof(h.Company_RAWAID))'');
    populated_isContact_pcnt := AVE(GROUP,IF(h.isContact = (TYPEOF(h.isContact))'',0,100));
    maxlength_isContact := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.isContact)));
    avelength_isContact := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.isContact)),h.isContact<>(typeof(h.isContact))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_contact_email_pcnt := AVE(GROUP,IF(h.contact_email = (TYPEOF(h.contact_email))'',0,100));
    maxlength_contact_email := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.contact_email)));
    avelength_contact_email := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.contact_email)),h.contact_email<>(typeof(h.contact_email))'');
    populated_contact_job_title_raw_pcnt := AVE(GROUP,IF(h.contact_job_title_raw = (TYPEOF(h.contact_job_title_raw))'',0,100));
    maxlength_contact_job_title_raw := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.contact_job_title_raw)));
    avelength_contact_job_title_raw := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.contact_job_title_raw)),h.contact_job_title_raw<>(typeof(h.contact_job_title_raw))'');
    populated_company_department_pcnt := AVE(GROUP,IF(h.company_department = (TYPEOF(h.company_department))'',0,100));
    maxlength_company_department := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.company_department)));
    avelength_company_department := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.company_department)),h.company_department<>(typeof(h.company_department))'');
    populated_contact_email_username_pcnt := AVE(GROUP,IF(h.contact_email_username = (TYPEOF(h.contact_email_username))'',0,100));
    maxlength_contact_email_username := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.contact_email_username)));
    avelength_contact_email_username := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.contact_email_username)),h.contact_email_username<>(typeof(h.contact_email_username))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT25.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT25.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
  END;
  RETURN table(h,SummaryLayout);
END;
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT25.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.Proxid;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT25.StrType)le.cnp_hasnumber),TRIM((SALT25.StrType)le.active_enterprise_number),TRIM((SALT25.StrType)le.source_record_id),TRIM((SALT25.StrType)le.contact_ssn),TRIM((SALT25.StrType)le.company_fein),TRIM((SALT25.StrType)le.company_charter_number),TRIM((SALT25.StrType)le.active_duns_number),TRIM((SALT25.StrType)le.active_domestic_corp_key),TRIM((SALT25.StrType)le.contact_phone),TRIM((SALT25.StrType)le.cnp_name),TRIM((SALT25.StrType)le.corp_legal_name),TRIM((SALT25.StrType)le.prim_range)+' '+TRIM((SALT25.StrType)le.prim_name)+' '+TRIM((SALT25.StrType)le.sec_range)+' '+TRIM((SALT25.StrType)le.v_city_name)+' '+TRIM((SALT25.StrType)le.st)+' '+TRIM((SALT25.StrType)le.zip),TRIM((SALT25.StrType)le.prim_range)+' '+TRIM((SALT25.StrType)le.prim_name)+' '+TRIM((SALT25.StrType)le.sec_range),TRIM((SALT25.StrType)le.v_city_name)+' '+TRIM((SALT25.StrType)le.st)+' '+TRIM((SALT25.StrType)le.zip),TRIM((SALT25.StrType)le.prim_name),TRIM((SALT25.StrType)le.lname),TRIM((SALT25.StrType)le.zip),TRIM((SALT25.StrType)le.prim_range),TRIM((SALT25.StrType)le.zip4),TRIM((SALT25.StrType)le.sec_range),TRIM((SALT25.StrType)le.cnp_number),TRIM((SALT25.StrType)le.p_city_name),TRIM((SALT25.StrType)le.v_city_name),TRIM((SALT25.StrType)le.fname),TRIM((SALT25.StrType)le.company_inc_state),TRIM((SALT25.StrType)le.mname),TRIM((SALT25.StrType)le.postdir),TRIM((SALT25.StrType)le.st),TRIM((SALT25.StrType)le.predir),TRIM((SALT25.StrType)le.addr_suffix),TRIM((SALT25.StrType)le.cnp_btype),TRIM((SALT25.StrType)le.source),TRIM((SALT25.StrType)le.iscorp),TRIM((SALT25.StrType)le.company_name),TRIM((SALT25.StrType)le.cnp_lowv),TRIM((SALT25.StrType)le.cnp_translated),TRIM((SALT25.StrType)le.cnp_classid),TRIM((SALT25.StrType)le.company_bdid),TRIM((SALT25.StrType)le.company_phone),TRIM((SALT25.StrType)le.unit_desig),TRIM((SALT25.StrType)le.Company_RAWAID),TRIM((SALT25.StrType)le.isContact),TRIM((SALT25.StrType)le.title),TRIM((SALT25.StrType)le.name_suffix),TRIM((SALT25.StrType)le.contact_email),TRIM((SALT25.StrType)le.contact_job_title_raw),TRIM((SALT25.StrType)le.company_department),TRIM((SALT25.StrType)le.contact_email_username),TRIM((SALT25.StrType)le.dt_first_seen),TRIM((SALT25.StrType)le.dt_last_seen)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,50,Into(LEFT,COUNTER));
SHARED FldIds := DATASET([{1,'cnp_hasnumber'}
      ,{2,'active_enterprise_number'}
      ,{3,'source_record_id'}
      ,{4,'contact_ssn'}
      ,{5,'company_fein'}
      ,{6,'company_charter_number'}
      ,{7,'active_duns_number'}
      ,{8,'active_domestic_corp_key'}
      ,{9,'contact_phone'}
      ,{10,'cnp_name'}
      ,{11,'corp_legal_name'}
      ,{12,'company_address'}
      ,{13,'company_addr1'}
      ,{14,'company_csz'}
      ,{15,'prim_name'}
      ,{16,'lname'}
      ,{17,'zip'}
      ,{18,'prim_range'}
      ,{19,'zip4'}
      ,{20,'sec_range'}
      ,{21,'cnp_number'}
      ,{22,'p_city_name'}
      ,{23,'v_city_name'}
      ,{24,'fname'}
      ,{25,'company_inc_state'}
      ,{26,'mname'}
      ,{27,'postdir'}
      ,{28,'st'}
      ,{29,'predir'}
      ,{30,'addr_suffix'}
      ,{31,'cnp_btype'}
      ,{32,'source'}
      ,{33,'iscorp'}
      ,{34,'company_name'}
      ,{35,'cnp_lowv'}
      ,{36,'cnp_translated'}
      ,{37,'cnp_classid'}
      ,{38,'company_bdid'}
      ,{39,'company_phone'}
      ,{40,'unit_desig'}
      ,{41,'Company_RAWAID'}
      ,{42,'isContact'}
      ,{43,'title'}
      ,{44,'name_suffix'}
      ,{45,'contact_email'}
      ,{46,'contact_job_title_raw'}
      ,{47,'company_department'}
      ,{48,'contact_email_username'}
      ,{49,'dt_first_seen'}
      ,{50,'dt_last_seen'}],SALT25.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT25.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT cnp_hasnumber_profile := AllProfiles(FldNo=1);
EXPORT active_enterprise_number_profile := AllProfiles(FldNo=2);
EXPORT source_record_id_profile := AllProfiles(FldNo=3);
EXPORT contact_ssn_profile := AllProfiles(FldNo=4);
EXPORT company_fein_profile := AllProfiles(FldNo=5);
EXPORT company_charter_number_profile := AllProfiles(FldNo=6);
EXPORT active_duns_number_profile := AllProfiles(FldNo=7);
EXPORT active_domestic_corp_key_profile := AllProfiles(FldNo=8);
EXPORT contact_phone_profile := AllProfiles(FldNo=9);
EXPORT cnp_name_profile := AllProfiles(FldNo=10);
EXPORT corp_legal_name_profile := AllProfiles(FldNo=11);
EXPORT company_address_profile := AllProfiles(FldNo=12);
EXPORT company_addr1_profile := AllProfiles(FldNo=13);
EXPORT company_csz_profile := AllProfiles(FldNo=14);
EXPORT prim_name_profile := AllProfiles(FldNo=15);
EXPORT lname_profile := AllProfiles(FldNo=16);
EXPORT zip_profile := AllProfiles(FldNo=17);
EXPORT prim_range_profile := AllProfiles(FldNo=18);
EXPORT zip4_profile := AllProfiles(FldNo=19);
EXPORT sec_range_profile := AllProfiles(FldNo=20);
EXPORT cnp_number_profile := AllProfiles(FldNo=21);
EXPORT p_city_name_profile := AllProfiles(FldNo=22);
EXPORT v_city_name_profile := AllProfiles(FldNo=23);
EXPORT fname_profile := AllProfiles(FldNo=24);
EXPORT company_inc_state_profile := AllProfiles(FldNo=25);
EXPORT mname_profile := AllProfiles(FldNo=26);
EXPORT postdir_profile := AllProfiles(FldNo=27);
EXPORT st_profile := AllProfiles(FldNo=28);
EXPORT predir_profile := AllProfiles(FldNo=29);
EXPORT addr_suffix_profile := AllProfiles(FldNo=30);
EXPORT cnp_btype_profile := AllProfiles(FldNo=31);
EXPORT source_profile := AllProfiles(FldNo=32);
EXPORT iscorp_profile := AllProfiles(FldNo=33);
EXPORT company_name_profile := AllProfiles(FldNo=34);
EXPORT cnp_lowv_profile := AllProfiles(FldNo=35);
EXPORT cnp_translated_profile := AllProfiles(FldNo=36);
EXPORT cnp_classid_profile := AllProfiles(FldNo=37);
EXPORT company_bdid_profile := AllProfiles(FldNo=38);
EXPORT company_phone_profile := AllProfiles(FldNo=39);
EXPORT unit_desig_profile := AllProfiles(FldNo=40);
EXPORT Company_RAWAID_profile := AllProfiles(FldNo=41);
EXPORT isContact_profile := AllProfiles(FldNo=42);
EXPORT title_profile := AllProfiles(FldNo=43);
EXPORT name_suffix_profile := AllProfiles(FldNo=44);
EXPORT contact_email_profile := AllProfiles(FldNo=45);
EXPORT contact_job_title_raw_profile := AllProfiles(FldNo=46);
EXPORT company_department_profile := AllProfiles(FldNo=47);
EXPORT contact_email_username_profile := AllProfiles(FldNo=48);
EXPORT dt_first_seen_profile := AllProfiles(FldNo=49);
EXPORT dt_last_seen_profile := AllProfiles(FldNo=50);
EXPORT SrcProfiles := SALT25.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
ErrorRecord := record
  unsigned1 FieldNum;
  unsigned1 ErrorNum;
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
  self.ErrorNum := CHOOSE(c,
    Fields.InValid_cnp_hasnumber((SALT25.StrType)le.cnp_hasnumber),
    Fields.InValid_active_enterprise_number((SALT25.StrType)le.active_enterprise_number),
    Fields.InValid_source_record_id((SALT25.StrType)le.source_record_id),
    Fields.InValid_contact_ssn((SALT25.StrType)le.contact_ssn),
    Fields.InValid_company_fein((SALT25.StrType)le.company_fein),
    Fields.InValid_company_charter_number((SALT25.StrType)le.company_charter_number),
    Fields.InValid_active_duns_number((SALT25.StrType)le.active_duns_number),
    Fields.InValid_active_domestic_corp_key((SALT25.StrType)le.active_domestic_corp_key),
    Fields.InValid_contact_phone((SALT25.StrType)le.contact_phone),
    Fields.InValid_cnp_name((SALT25.StrType)le.cnp_name),
    Fields.InValid_corp_legal_name((SALT25.StrType)le.corp_legal_name),
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    Fields.InValid_prim_name((SALT25.StrType)le.prim_name),
    Fields.InValid_lname((SALT25.StrType)le.lname),
    Fields.InValid_zip((SALT25.StrType)le.zip),
    Fields.InValid_prim_range((SALT25.StrType)le.prim_range),
    Fields.InValid_zip4((SALT25.StrType)le.zip4),
    Fields.InValid_sec_range((SALT25.StrType)le.sec_range),
    Fields.InValid_cnp_number((SALT25.StrType)le.cnp_number),
    Fields.InValid_p_city_name((SALT25.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT25.StrType)le.v_city_name),
    Fields.InValid_fname((SALT25.StrType)le.fname),
    Fields.InValid_company_inc_state((SALT25.StrType)le.company_inc_state),
    Fields.InValid_mname((SALT25.StrType)le.mname),
    Fields.InValid_postdir((SALT25.StrType)le.postdir),
    Fields.InValid_st((SALT25.StrType)le.st),
    Fields.InValid_predir((SALT25.StrType)le.predir),
    Fields.InValid_addr_suffix((SALT25.StrType)le.addr_suffix),
    Fields.InValid_cnp_btype((SALT25.StrType)le.cnp_btype),
    Fields.InValid_source((SALT25.StrType)le.source),
    Fields.InValid_iscorp((SALT25.StrType)le.iscorp),
    Fields.InValid_company_name((SALT25.StrType)le.company_name),
    Fields.InValid_cnp_lowv((SALT25.StrType)le.cnp_lowv),
    Fields.InValid_cnp_translated((SALT25.StrType)le.cnp_translated),
    Fields.InValid_cnp_classid((SALT25.StrType)le.cnp_classid),
    Fields.InValid_company_bdid((SALT25.StrType)le.company_bdid),
    Fields.InValid_company_phone((SALT25.StrType)le.company_phone),
    Fields.InValid_unit_desig((SALT25.StrType)le.unit_desig),
    Fields.InValid_Company_RAWAID((SALT25.StrType)le.Company_RAWAID),
    Fields.InValid_isContact((SALT25.StrType)le.isContact),
    Fields.InValid_title((SALT25.StrType)le.title),
    Fields.InValid_name_suffix((SALT25.StrType)le.name_suffix),
    Fields.InValid_contact_email((SALT25.StrType)le.contact_email),
    Fields.InValid_contact_job_title_raw((SALT25.StrType)le.contact_job_title_raw),
    Fields.InValid_company_department((SALT25.StrType)le.company_department),
    Fields.InValid_contact_email_username((SALT25.StrType)le.contact_email_username),
    Fields.InValid_dt_first_seen((SALT25.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT25.StrType)le.dt_last_seen),
    0);
  self.FieldNum := IF(self.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
end;
Errors := normalize(h,50,NoteErrors(left,counter));
ErrorRecordsTotals := record
  Errors.FieldNum;
  Errors.ErrorNum;
  unsigned Cnt := count(group);
end;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := record
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_cnp_hasnumber(TotalErrors.ErrorNum),Fields.InValidMessage_active_enterprise_number(TotalErrors.ErrorNum),Fields.InValidMessage_source_record_id(TotalErrors.ErrorNum),Fields.InValidMessage_contact_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_company_fein(TotalErrors.ErrorNum),Fields.InValidMessage_company_charter_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_contact_phone(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_legal_name(TotalErrors.ErrorNum),Fields.InValidMessage_company_address(TotalErrors.ErrorNum),Fields.InValidMessage_company_addr1(TotalErrors.ErrorNum),Fields.InValidMessage_company_csz(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_number(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_company_inc_state(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_btype(TotalErrors.ErrorNum),Fields.InValidMessage_source(TotalErrors.ErrorNum),Fields.InValidMessage_iscorp(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_lowv(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_translated(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_classid(TotalErrors.ErrorNum),Fields.InValidMessage_company_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_company_phone(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_Company_RAWAID(TotalErrors.ErrorNum),Fields.InValidMessage_isContact(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_contact_email(TotalErrors.ErrorNum),Fields.InValidMessage_contact_job_title_raw(TotalErrors.ErrorNum),Fields.InValidMessage_company_department(TotalErrors.ErrorNum),Fields.InValidMessage_contact_email_username(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
end;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
export ValidityErrors := ValErr;
//We have Proxid specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT25.MOD_ClusterStats.Counts(h,Proxid);
end;
