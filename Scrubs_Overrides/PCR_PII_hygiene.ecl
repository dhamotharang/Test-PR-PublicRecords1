IMPORT SALT311,STD;
EXPORT PCR_PII_hygiene(dataset(PCR_PII_layout_Overrides) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_uid_cnt := COUNT(GROUP,h.uid <> (TYPEOF(h.uid))'');
    populated_uid_pcnt := AVE(GROUP,IF(h.uid = (TYPEOF(h.uid))'',0,100));
    maxlength_uid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.uid)));
    avelength_uid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.uid)),h.uid<>(typeof(h.uid))'');
    populated_date_created_cnt := COUNT(GROUP,h.date_created <> (TYPEOF(h.date_created))'');
    populated_date_created_pcnt := AVE(GROUP,IF(h.date_created = (TYPEOF(h.date_created))'',0,100));
    maxlength_date_created := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_created)));
    avelength_date_created := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_created)),h.date_created<>(typeof(h.date_created))'');
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_ssn_cnt := COUNT(GROUP,h.ssn <> (TYPEOF(h.ssn))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_address_cnt := COUNT(GROUP,h.address <> (TYPEOF(h.address))'');
    populated_address_pcnt := AVE(GROUP,IF(h.address = (TYPEOF(h.address))'',0,100));
    maxlength_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address)));
    avelength_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address)),h.address<>(typeof(h.address))'');
    populated_city_name_cnt := COUNT(GROUP,h.city_name <> (TYPEOF(h.city_name))'');
    populated_city_name_pcnt := AVE(GROUP,IF(h.city_name = (TYPEOF(h.city_name))'',0,100));
    maxlength_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_name)));
    avelength_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_name)),h.city_name<>(typeof(h.city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_dl_number_cnt := COUNT(GROUP,h.dl_number <> (TYPEOF(h.dl_number))'');
    populated_dl_number_pcnt := AVE(GROUP,IF(h.dl_number = (TYPEOF(h.dl_number))'',0,100));
    maxlength_dl_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dl_number)));
    avelength_dl_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dl_number)),h.dl_number<>(typeof(h.dl_number))'');
    populated_dl_state_cnt := COUNT(GROUP,h.dl_state <> (TYPEOF(h.dl_state))'');
    populated_dl_state_pcnt := AVE(GROUP,IF(h.dl_state = (TYPEOF(h.dl_state))'',0,100));
    maxlength_dl_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dl_state)));
    avelength_dl_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dl_state)),h.dl_state<>(typeof(h.dl_state))'');
    populated_dispute_flag_cnt := COUNT(GROUP,h.dispute_flag <> (TYPEOF(h.dispute_flag))'');
    populated_dispute_flag_pcnt := AVE(GROUP,IF(h.dispute_flag = (TYPEOF(h.dispute_flag))'',0,100));
    maxlength_dispute_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dispute_flag)));
    avelength_dispute_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dispute_flag)),h.dispute_flag<>(typeof(h.dispute_flag))'');
    populated_security_freeze_cnt := COUNT(GROUP,h.security_freeze <> (TYPEOF(h.security_freeze))'');
    populated_security_freeze_pcnt := AVE(GROUP,IF(h.security_freeze = (TYPEOF(h.security_freeze))'',0,100));
    maxlength_security_freeze := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.security_freeze)));
    avelength_security_freeze := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.security_freeze)),h.security_freeze<>(typeof(h.security_freeze))'');
    populated_security_freeze_pin_cnt := COUNT(GROUP,h.security_freeze_pin <> (TYPEOF(h.security_freeze_pin))'');
    populated_security_freeze_pin_pcnt := AVE(GROUP,IF(h.security_freeze_pin = (TYPEOF(h.security_freeze_pin))'',0,100));
    maxlength_security_freeze_pin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.security_freeze_pin)));
    avelength_security_freeze_pin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.security_freeze_pin)),h.security_freeze_pin<>(typeof(h.security_freeze_pin))'');
    populated_security_alert_cnt := COUNT(GROUP,h.security_alert <> (TYPEOF(h.security_alert))'');
    populated_security_alert_pcnt := AVE(GROUP,IF(h.security_alert = (TYPEOF(h.security_alert))'',0,100));
    maxlength_security_alert := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.security_alert)));
    avelength_security_alert := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.security_alert)),h.security_alert<>(typeof(h.security_alert))'');
    populated_negative_alert_cnt := COUNT(GROUP,h.negative_alert <> (TYPEOF(h.negative_alert))'');
    populated_negative_alert_pcnt := AVE(GROUP,IF(h.negative_alert = (TYPEOF(h.negative_alert))'',0,100));
    maxlength_negative_alert := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.negative_alert)));
    avelength_negative_alert := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.negative_alert)),h.negative_alert<>(typeof(h.negative_alert))'');
    populated_id_theft_flag_cnt := COUNT(GROUP,h.id_theft_flag <> (TYPEOF(h.id_theft_flag))'');
    populated_id_theft_flag_pcnt := AVE(GROUP,IF(h.id_theft_flag = (TYPEOF(h.id_theft_flag))'',0,100));
    maxlength_id_theft_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.id_theft_flag)));
    avelength_id_theft_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.id_theft_flag)),h.id_theft_flag<>(typeof(h.id_theft_flag))'');
    populated_insuff_inqry_data_cnt := COUNT(GROUP,h.insuff_inqry_data <> (TYPEOF(h.insuff_inqry_data))'');
    populated_insuff_inqry_data_pcnt := AVE(GROUP,IF(h.insuff_inqry_data = (TYPEOF(h.insuff_inqry_data))'',0,100));
    maxlength_insuff_inqry_data := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuff_inqry_data)));
    avelength_insuff_inqry_data := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.insuff_inqry_data)),h.insuff_inqry_data<>(typeof(h.insuff_inqry_data))'');
    populated_consumer_statement_flag_cnt := COUNT(GROUP,h.consumer_statement_flag <> (TYPEOF(h.consumer_statement_flag))'');
    populated_consumer_statement_flag_pcnt := AVE(GROUP,IF(h.consumer_statement_flag = (TYPEOF(h.consumer_statement_flag))'',0,100));
    maxlength_consumer_statement_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.consumer_statement_flag)));
    avelength_consumer_statement_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.consumer_statement_flag)),h.consumer_statement_flag<>(typeof(h.consumer_statement_flag))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_uid_pcnt *   0.00 / 100 + T.Populated_date_created_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_address_pcnt *   0.00 / 100 + T.Populated_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_dl_number_pcnt *   0.00 / 100 + T.Populated_dl_state_pcnt *   0.00 / 100 + T.Populated_dispute_flag_pcnt *   0.00 / 100 + T.Populated_security_freeze_pcnt *   0.00 / 100 + T.Populated_security_freeze_pin_pcnt *   0.00 / 100 + T.Populated_security_alert_pcnt *   0.00 / 100 + T.Populated_negative_alert_pcnt *   0.00 / 100 + T.Populated_id_theft_flag_pcnt *   0.00 / 100 + T.Populated_insuff_inqry_data_pcnt *   0.00 / 100 + T.Populated_consumer_statement_flag_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'uid','date_created','dt_first_seen','dt_last_seen','did','fname','mname','lname','name_suffix','ssn','dob','predir','prim_name','prim_range','suffix','postdir','unit_desig','sec_range','zip4','address','city_name','st','zip','phone','dl_number','dl_state','dispute_flag','security_freeze','security_freeze_pin','security_alert','negative_alert','id_theft_flag','insuff_inqry_data','consumer_statement_flag');
  SELF.populated_pcnt := CHOOSE(C,le.populated_uid_pcnt,le.populated_date_created_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_did_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_ssn_pcnt,le.populated_dob_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_prim_range_pcnt,le.populated_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_zip4_pcnt,le.populated_address_pcnt,le.populated_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_phone_pcnt,le.populated_dl_number_pcnt,le.populated_dl_state_pcnt,le.populated_dispute_flag_pcnt,le.populated_security_freeze_pcnt,le.populated_security_freeze_pin_pcnt,le.populated_security_alert_pcnt,le.populated_negative_alert_pcnt,le.populated_id_theft_flag_pcnt,le.populated_insuff_inqry_data_pcnt,le.populated_consumer_statement_flag_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_uid,le.maxlength_date_created,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_did,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_ssn,le.maxlength_dob,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_prim_range,le.maxlength_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_zip4,le.maxlength_address,le.maxlength_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_phone,le.maxlength_dl_number,le.maxlength_dl_state,le.maxlength_dispute_flag,le.maxlength_security_freeze,le.maxlength_security_freeze_pin,le.maxlength_security_alert,le.maxlength_negative_alert,le.maxlength_id_theft_flag,le.maxlength_insuff_inqry_data,le.maxlength_consumer_statement_flag);
  SELF.avelength := CHOOSE(C,le.avelength_uid,le.avelength_date_created,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_did,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_ssn,le.avelength_dob,le.avelength_predir,le.avelength_prim_name,le.avelength_prim_range,le.avelength_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_zip4,le.avelength_address,le.avelength_city_name,le.avelength_st,le.avelength_zip,le.avelength_phone,le.avelength_dl_number,le.avelength_dl_state,le.avelength_dispute_flag,le.avelength_security_freeze,le.avelength_security_freeze_pin,le.avelength_security_alert,le.avelength_negative_alert,le.avelength_id_theft_flag,le.avelength_insuff_inqry_data,le.avelength_consumer_statement_flag);
END;
EXPORT invSummary := NORMALIZE(summary0, 34, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.uid),TRIM((SALT311.StrType)le.date_created),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.did),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.dl_number),TRIM((SALT311.StrType)le.dl_state),TRIM((SALT311.StrType)le.dispute_flag),TRIM((SALT311.StrType)le.security_freeze),TRIM((SALT311.StrType)le.security_freeze_pin),TRIM((SALT311.StrType)le.security_alert),TRIM((SALT311.StrType)le.negative_alert),TRIM((SALT311.StrType)le.id_theft_flag),TRIM((SALT311.StrType)le.insuff_inqry_data),TRIM((SALT311.StrType)le.consumer_statement_flag)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,34,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 34);
  SELF.FldNo2 := 1 + (C % 34);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.uid),TRIM((SALT311.StrType)le.date_created),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.did),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.dl_number),TRIM((SALT311.StrType)le.dl_state),TRIM((SALT311.StrType)le.dispute_flag),TRIM((SALT311.StrType)le.security_freeze),TRIM((SALT311.StrType)le.security_freeze_pin),TRIM((SALT311.StrType)le.security_alert),TRIM((SALT311.StrType)le.negative_alert),TRIM((SALT311.StrType)le.id_theft_flag),TRIM((SALT311.StrType)le.insuff_inqry_data),TRIM((SALT311.StrType)le.consumer_statement_flag)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.uid),TRIM((SALT311.StrType)le.date_created),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.did),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.dl_number),TRIM((SALT311.StrType)le.dl_state),TRIM((SALT311.StrType)le.dispute_flag),TRIM((SALT311.StrType)le.security_freeze),TRIM((SALT311.StrType)le.security_freeze_pin),TRIM((SALT311.StrType)le.security_alert),TRIM((SALT311.StrType)le.negative_alert),TRIM((SALT311.StrType)le.id_theft_flag),TRIM((SALT311.StrType)le.insuff_inqry_data),TRIM((SALT311.StrType)le.consumer_statement_flag)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),34*34,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'uid'}
      ,{2,'date_created'}
      ,{3,'dt_first_seen'}
      ,{4,'dt_last_seen'}
      ,{5,'did'}
      ,{6,'fname'}
      ,{7,'mname'}
      ,{8,'lname'}
      ,{9,'name_suffix'}
      ,{10,'ssn'}
      ,{11,'dob'}
      ,{12,'predir'}
      ,{13,'prim_name'}
      ,{14,'prim_range'}
      ,{15,'suffix'}
      ,{16,'postdir'}
      ,{17,'unit_desig'}
      ,{18,'sec_range'}
      ,{19,'zip4'}
      ,{20,'address'}
      ,{21,'city_name'}
      ,{22,'st'}
      ,{23,'zip'}
      ,{24,'phone'}
      ,{25,'dl_number'}
      ,{26,'dl_state'}
      ,{27,'dispute_flag'}
      ,{28,'security_freeze'}
      ,{29,'security_freeze_pin'}
      ,{30,'security_alert'}
      ,{31,'negative_alert'}
      ,{32,'id_theft_flag'}
      ,{33,'insuff_inqry_data'}
      ,{34,'consumer_statement_flag'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    PCR_PII_Fields.InValid_uid((SALT311.StrType)le.uid),
    PCR_PII_Fields.InValid_date_created((SALT311.StrType)le.date_created),
    PCR_PII_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    PCR_PII_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    PCR_PII_Fields.InValid_did((SALT311.StrType)le.did),
    PCR_PII_Fields.InValid_fname((SALT311.StrType)le.fname),
    PCR_PII_Fields.InValid_mname((SALT311.StrType)le.mname),
    PCR_PII_Fields.InValid_lname((SALT311.StrType)le.lname),
    PCR_PII_Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    PCR_PII_Fields.InValid_ssn((SALT311.StrType)le.ssn),
    PCR_PII_Fields.InValid_dob((SALT311.StrType)le.dob),
    PCR_PII_Fields.InValid_predir((SALT311.StrType)le.predir),
    PCR_PII_Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    PCR_PII_Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    PCR_PII_Fields.InValid_suffix((SALT311.StrType)le.suffix),
    PCR_PII_Fields.InValid_postdir((SALT311.StrType)le.postdir),
    PCR_PII_Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    PCR_PII_Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    PCR_PII_Fields.InValid_zip4((SALT311.StrType)le.zip4),
    PCR_PII_Fields.InValid_address((SALT311.StrType)le.address),
    PCR_PII_Fields.InValid_city_name((SALT311.StrType)le.city_name),
    PCR_PII_Fields.InValid_st((SALT311.StrType)le.st),
    PCR_PII_Fields.InValid_zip((SALT311.StrType)le.zip),
    PCR_PII_Fields.InValid_phone((SALT311.StrType)le.phone),
    PCR_PII_Fields.InValid_dl_number((SALT311.StrType)le.dl_number),
    PCR_PII_Fields.InValid_dl_state((SALT311.StrType)le.dl_state),
    PCR_PII_Fields.InValid_dispute_flag((SALT311.StrType)le.dispute_flag),
    PCR_PII_Fields.InValid_security_freeze((SALT311.StrType)le.security_freeze),
    PCR_PII_Fields.InValid_security_freeze_pin((SALT311.StrType)le.security_freeze_pin),
    PCR_PII_Fields.InValid_security_alert((SALT311.StrType)le.security_alert),
    PCR_PII_Fields.InValid_negative_alert((SALT311.StrType)le.negative_alert),
    PCR_PII_Fields.InValid_id_theft_flag((SALT311.StrType)le.id_theft_flag),
    PCR_PII_Fields.InValid_insuff_inqry_data((SALT311.StrType)le.insuff_inqry_data),
    PCR_PII_Fields.InValid_consumer_statement_flag((SALT311.StrType)le.consumer_statement_flag),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,34,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := PCR_PII_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Char','Invalid_Date','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_SSN','Invalid_DOB','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Unknown','Unknown','Invalid_State','Invalid_Num','Invalid_Num','Invalid_DLNum','Invalid_State','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,PCR_PII_Fields.InValidMessage_uid(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_date_created(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_did(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_fname(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_mname(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_lname(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_ssn(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_dob(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_predir(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_address(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_city_name(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_st(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_zip(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_phone(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_dl_number(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_dl_state(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_dispute_flag(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_security_freeze(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_security_freeze_pin(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_security_alert(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_negative_alert(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_id_theft_flag(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_insuff_inqry_data(TotalErrors.ErrorNum),PCR_PII_Fields.InValidMessage_consumer_statement_flag(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Overrides, PCR_PII_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
