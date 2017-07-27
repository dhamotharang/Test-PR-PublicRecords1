IMPORT ut,SALT31;
EXPORT hygiene(dataset(layout_Base) h) := MODULE
//A simple summary record
EXPORT Summary(SALT31.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_active_duns_number_pcnt := AVE(GROUP,IF(h.active_duns_number = (TYPEOF(h.active_duns_number))'',0,100));
    maxlength_active_duns_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.active_duns_number)));
    avelength_active_duns_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.active_duns_number)),h.active_duns_number<>(typeof(h.active_duns_number))'');
    populated_active_enterprise_number_pcnt := AVE(GROUP,IF(h.active_enterprise_number = (TYPEOF(h.active_enterprise_number))'',0,100));
    maxlength_active_enterprise_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.active_enterprise_number)));
    avelength_active_enterprise_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.active_enterprise_number)),h.active_enterprise_number<>(typeof(h.active_enterprise_number))'');
    populated_company_charter_number_pcnt := AVE(GROUP,IF(h.company_charter_number = (TYPEOF(h.company_charter_number))'',0,100));
    maxlength_company_charter_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.company_charter_number)));
    avelength_company_charter_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.company_charter_number)),h.company_charter_number<>(typeof(h.company_charter_number))'');
    populated_company_fein_pcnt := AVE(GROUP,IF(h.company_fein = (TYPEOF(h.company_fein))'',0,100));
    maxlength_company_fein := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.company_fein)));
    avelength_company_fein := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.company_fein)),h.company_fein<>(typeof(h.company_fein))'');
    populated_source_record_id_pcnt := AVE(GROUP,IF(h.source_record_id = (TYPEOF(h.source_record_id))'',0,100));
    maxlength_source_record_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.source_record_id)));
    avelength_source_record_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.source_record_id)),h.source_record_id<>(typeof(h.source_record_id))'');
    populated_contact_ssn_pcnt := AVE(GROUP,IF(h.contact_ssn = (TYPEOF(h.contact_ssn))'',0,100));
    maxlength_contact_ssn := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.contact_ssn)));
    avelength_contact_ssn := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.contact_ssn)),h.contact_ssn<>(typeof(h.contact_ssn))'');
    populated_contact_phone_pcnt := AVE(GROUP,IF(h.contact_phone = (TYPEOF(h.contact_phone))'',0,100));
    maxlength_contact_phone := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.contact_phone)));
    avelength_contact_phone := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.contact_phone)),h.contact_phone<>(typeof(h.contact_phone))'');
    populated_contact_email_username_pcnt := AVE(GROUP,IF(h.contact_email_username = (TYPEOF(h.contact_email_username))'',0,100));
    maxlength_contact_email_username := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.contact_email_username)));
    avelength_contact_email_username := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.contact_email_username)),h.contact_email_username<>(typeof(h.contact_email_username))'');
    populated_cnp_name_pcnt := AVE(GROUP,IF(h.cnp_name = (TYPEOF(h.cnp_name))'',0,100));
    maxlength_cnp_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cnp_name)));
    avelength_cnp_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cnp_name)),h.cnp_name<>(typeof(h.cnp_name))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_company_inc_state_pcnt := AVE(GROUP,IF(h.company_inc_state = (TYPEOF(h.company_inc_state))'',0,100));
    maxlength_company_inc_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.company_inc_state)));
    avelength_company_inc_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.company_inc_state)),h.company_inc_state<>(typeof(h.company_inc_state))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_company_department_pcnt := AVE(GROUP,IF(h.company_department = (TYPEOF(h.company_department))'',0,100));
    maxlength_company_department := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.company_department)));
    avelength_company_department := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.company_department)),h.company_department<>(typeof(h.company_department))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_first_seen_contact_pcnt := AVE(GROUP,IF(h.dt_first_seen_contact = (TYPEOF(h.dt_first_seen_contact))'',0,100));
    maxlength_dt_first_seen_contact := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_first_seen_contact)));
    avelength_dt_first_seen_contact := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_first_seen_contact)),h.dt_first_seen_contact<>(typeof(h.dt_first_seen_contact))'');
    populated_dt_last_seen_contact_pcnt := AVE(GROUP,IF(h.dt_last_seen_contact = (TYPEOF(h.dt_last_seen_contact))'',0,100));
    maxlength_dt_last_seen_contact := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_last_seen_contact)));
    avelength_dt_last_seen_contact := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_last_seen_contact)),h.dt_last_seen_contact<>(typeof(h.dt_last_seen_contact))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_active_duns_number_pcnt *  28.00 / 100 + T.Populated_active_enterprise_number_pcnt *  28.00 / 100 + T.Populated_company_charter_number_pcnt *  27.00 / 100 + T.Populated_company_fein_pcnt *  27.00 / 100 + T.Populated_source_record_id_pcnt *  27.00 / 100 + T.Populated_contact_ssn_pcnt *  27.00 / 100 + T.Populated_contact_phone_pcnt *  27.00 / 100 + T.Populated_contact_email_username_pcnt *  27.00 / 100 + T.Populated_cnp_name_pcnt *  25.00 / 100 + T.Populated_lname_pcnt *  16.00 / 100 + T.Populated_prim_name_pcnt *  15.00 / 100 + T.Populated_prim_range_pcnt *  13.00 / 100 + T.Populated_sec_range_pcnt *  12.00 / 100 + T.Populated_v_city_name_pcnt *  11.00 / 100 + T.Populated_fname_pcnt *  11.00 / 100 + T.Populated_mname_pcnt *   8.00 / 100 + T.Populated_company_inc_state_pcnt *   7.00 / 100 + T.Populated_postdir_pcnt *   7.00 / 100 + T.Populated_st_pcnt *   5.00 / 100 + T.Populated_source_pcnt *   4.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_company_department_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_contact_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_contact_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT31.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'active_duns_number','active_enterprise_number','company_charter_number','company_fein','source_record_id','contact_ssn','contact_phone','contact_email_username','cnp_name','lname','prim_name','prim_range','sec_range','v_city_name','fname','mname','company_inc_state','postdir','st','source','unit_desig','company_department','dt_first_seen','dt_last_seen','dt_first_seen_contact','dt_last_seen_contact');
  SELF.populated_pcnt := CHOOSE(C,le.populated_active_duns_number_pcnt,le.populated_active_enterprise_number_pcnt,le.populated_company_charter_number_pcnt,le.populated_company_fein_pcnt,le.populated_source_record_id_pcnt,le.populated_contact_ssn_pcnt,le.populated_contact_phone_pcnt,le.populated_contact_email_username_pcnt,le.populated_cnp_name_pcnt,le.populated_lname_pcnt,le.populated_prim_name_pcnt,le.populated_prim_range_pcnt,le.populated_sec_range_pcnt,le.populated_v_city_name_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_company_inc_state_pcnt,le.populated_postdir_pcnt,le.populated_st_pcnt,le.populated_source_pcnt,le.populated_unit_desig_pcnt,le.populated_company_department_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_first_seen_contact_pcnt,le.populated_dt_last_seen_contact_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_active_duns_number,le.maxlength_active_enterprise_number,le.maxlength_company_charter_number,le.maxlength_company_fein,le.maxlength_source_record_id,le.maxlength_contact_ssn,le.maxlength_contact_phone,le.maxlength_contact_email_username,le.maxlength_cnp_name,le.maxlength_lname,le.maxlength_prim_name,le.maxlength_prim_range,le.maxlength_sec_range,le.maxlength_v_city_name,le.maxlength_fname,le.maxlength_mname,le.maxlength_company_inc_state,le.maxlength_postdir,le.maxlength_st,le.maxlength_source,le.maxlength_unit_desig,le.maxlength_company_department,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_first_seen_contact,le.maxlength_dt_last_seen_contact);
  SELF.avelength := CHOOSE(C,le.avelength_active_duns_number,le.avelength_active_enterprise_number,le.avelength_company_charter_number,le.avelength_company_fein,le.avelength_source_record_id,le.avelength_contact_ssn,le.avelength_contact_phone,le.avelength_contact_email_username,le.avelength_cnp_name,le.avelength_lname,le.avelength_prim_name,le.avelength_prim_range,le.avelength_sec_range,le.avelength_v_city_name,le.avelength_fname,le.avelength_mname,le.avelength_company_inc_state,le.avelength_postdir,le.avelength_st,le.avelength_source,le.avelength_unit_desig,le.avelength_company_department,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_first_seen_contact,le.avelength_dt_last_seen_contact);
END;
EXPORT invSummary := NORMALIZE(summary0, 26, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.Seleid;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.active_duns_number),TRIM((SALT31.StrType)le.active_enterprise_number),TRIM((SALT31.StrType)le.company_charter_number),TRIM((SALT31.StrType)le.company_fein),TRIM((SALT31.StrType)le.source_record_id),TRIM((SALT31.StrType)le.contact_ssn),TRIM((SALT31.StrType)le.contact_phone),TRIM((SALT31.StrType)le.contact_email_username),TRIM((SALT31.StrType)le.cnp_name),TRIM((SALT31.StrType)le.lname),TRIM((SALT31.StrType)le.prim_name),TRIM((SALT31.StrType)le.prim_range),TRIM((SALT31.StrType)le.sec_range),TRIM((SALT31.StrType)le.v_city_name),TRIM((SALT31.StrType)le.fname),TRIM((SALT31.StrType)le.mname),TRIM((SALT31.StrType)le.company_inc_state),TRIM((SALT31.StrType)le.postdir),TRIM((SALT31.StrType)le.st),TRIM((SALT31.StrType)le.source),TRIM((SALT31.StrType)le.unit_desig),TRIM((SALT31.StrType)le.company_department),TRIM((SALT31.StrType)le.dt_first_seen),TRIM((SALT31.StrType)le.dt_last_seen),TRIM((SALT31.StrType)le.dt_first_seen_contact),TRIM((SALT31.StrType)le.dt_last_seen_contact)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,26,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 26);
  SELF.FldNo2 := 1 + (C % 26);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.active_duns_number),TRIM((SALT31.StrType)le.active_enterprise_number),TRIM((SALT31.StrType)le.company_charter_number),TRIM((SALT31.StrType)le.company_fein),TRIM((SALT31.StrType)le.source_record_id),TRIM((SALT31.StrType)le.contact_ssn),TRIM((SALT31.StrType)le.contact_phone),TRIM((SALT31.StrType)le.contact_email_username),TRIM((SALT31.StrType)le.cnp_name),TRIM((SALT31.StrType)le.lname),TRIM((SALT31.StrType)le.prim_name),TRIM((SALT31.StrType)le.prim_range),TRIM((SALT31.StrType)le.sec_range),TRIM((SALT31.StrType)le.v_city_name),TRIM((SALT31.StrType)le.fname),TRIM((SALT31.StrType)le.mname),TRIM((SALT31.StrType)le.company_inc_state),TRIM((SALT31.StrType)le.postdir),TRIM((SALT31.StrType)le.st),TRIM((SALT31.StrType)le.source),TRIM((SALT31.StrType)le.unit_desig),TRIM((SALT31.StrType)le.company_department),TRIM((SALT31.StrType)le.dt_first_seen),TRIM((SALT31.StrType)le.dt_last_seen),TRIM((SALT31.StrType)le.dt_first_seen_contact),TRIM((SALT31.StrType)le.dt_last_seen_contact)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.active_duns_number),TRIM((SALT31.StrType)le.active_enterprise_number),TRIM((SALT31.StrType)le.company_charter_number),TRIM((SALT31.StrType)le.company_fein),TRIM((SALT31.StrType)le.source_record_id),TRIM((SALT31.StrType)le.contact_ssn),TRIM((SALT31.StrType)le.contact_phone),TRIM((SALT31.StrType)le.contact_email_username),TRIM((SALT31.StrType)le.cnp_name),TRIM((SALT31.StrType)le.lname),TRIM((SALT31.StrType)le.prim_name),TRIM((SALT31.StrType)le.prim_range),TRIM((SALT31.StrType)le.sec_range),TRIM((SALT31.StrType)le.v_city_name),TRIM((SALT31.StrType)le.fname),TRIM((SALT31.StrType)le.mname),TRIM((SALT31.StrType)le.company_inc_state),TRIM((SALT31.StrType)le.postdir),TRIM((SALT31.StrType)le.st),TRIM((SALT31.StrType)le.source),TRIM((SALT31.StrType)le.unit_desig),TRIM((SALT31.StrType)le.company_department),TRIM((SALT31.StrType)le.dt_first_seen),TRIM((SALT31.StrType)le.dt_last_seen),TRIM((SALT31.StrType)le.dt_first_seen_contact),TRIM((SALT31.StrType)le.dt_last_seen_contact)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),26*26,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'active_duns_number'}
      ,{2,'active_enterprise_number'}
      ,{3,'company_charter_number'}
      ,{4,'company_fein'}
      ,{5,'source_record_id'}
      ,{6,'contact_ssn'}
      ,{7,'contact_phone'}
      ,{8,'contact_email_username'}
      ,{9,'cnp_name'}
      ,{10,'lname'}
      ,{11,'prim_name'}
      ,{12,'prim_range'}
      ,{13,'sec_range'}
      ,{14,'v_city_name'}
      ,{15,'fname'}
      ,{16,'mname'}
      ,{17,'company_inc_state'}
      ,{18,'postdir'}
      ,{19,'st'}
      ,{20,'source'}
      ,{21,'unit_desig'}
      ,{22,'company_department'}
      ,{23,'dt_first_seen'}
      ,{24,'dt_last_seen'}
      ,{25,'dt_first_seen_contact'}
      ,{26,'dt_last_seen_contact'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_active_duns_number((SALT31.StrType)le.active_duns_number),
    Fields.InValid_active_enterprise_number((SALT31.StrType)le.active_enterprise_number),
    Fields.InValid_company_charter_number((SALT31.StrType)le.company_charter_number),
    Fields.InValid_company_fein((SALT31.StrType)le.company_fein),
    Fields.InValid_source_record_id((SALT31.StrType)le.source_record_id),
    Fields.InValid_contact_ssn((SALT31.StrType)le.contact_ssn),
    Fields.InValid_contact_phone((SALT31.StrType)le.contact_phone),
    Fields.InValid_contact_email_username((SALT31.StrType)le.contact_email_username),
    Fields.InValid_cnp_name((SALT31.StrType)le.cnp_name),
    Fields.InValid_lname((SALT31.StrType)le.lname),
    Fields.InValid_prim_name((SALT31.StrType)le.prim_name),
    Fields.InValid_prim_range((SALT31.StrType)le.prim_range),
    Fields.InValid_sec_range((SALT31.StrType)le.sec_range),
    Fields.InValid_v_city_name((SALT31.StrType)le.v_city_name),
    Fields.InValid_fname((SALT31.StrType)le.fname),
    Fields.InValid_mname((SALT31.StrType)le.mname),
    Fields.InValid_company_inc_state((SALT31.StrType)le.company_inc_state),
    Fields.InValid_postdir((SALT31.StrType)le.postdir),
    Fields.InValid_st((SALT31.StrType)le.st),
    Fields.InValid_source((SALT31.StrType)le.source),
    Fields.InValid_unit_desig((SALT31.StrType)le.unit_desig),
    Fields.InValid_company_department((SALT31.StrType)le.company_department),
    Fields.InValid_dt_first_seen((SALT31.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT31.StrType)le.dt_last_seen),
    Fields.InValid_dt_first_seen_contact((SALT31.StrType)le.dt_first_seen_contact),
    Fields.InValid_dt_last_seen_contact((SALT31.StrType)le.dt_last_seen_contact),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,26,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','wordbag','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','alpha','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_active_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_enterprise_number(TotalErrors.ErrorNum),Fields.InValidMessage_company_charter_number(TotalErrors.ErrorNum),Fields.InValidMessage_company_fein(TotalErrors.ErrorNum),Fields.InValidMessage_source_record_id(TotalErrors.ErrorNum),Fields.InValidMessage_contact_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_contact_phone(TotalErrors.ErrorNum),Fields.InValidMessage_contact_email_username(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_name(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_company_inc_state(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_source(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_company_department(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen_contact(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen_contact(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
//We have Seleid specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT31.MOD_ClusterStats.Counts(h,Seleid);
END;