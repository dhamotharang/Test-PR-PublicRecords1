IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_PhonesFeedback) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_cnt := COUNT(GROUP,h.did_score <> (TYPEOF(h.did_score))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_hhid_cnt := COUNT(GROUP,h.hhid <> (TYPEOF(h.hhid))'');
    populated_hhid_pcnt := AVE(GROUP,IF(h.hhid = (TYPEOF(h.hhid))'',0,100));
    maxlength_hhid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hhid)));
    avelength_hhid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hhid)),h.hhid<>(typeof(h.hhid))'');
    populated_phone_number_cnt := COUNT(GROUP,h.phone_number <> (TYPEOF(h.phone_number))'');
    populated_phone_number_pcnt := AVE(GROUP,IF(h.phone_number = (TYPEOF(h.phone_number))'',0,100));
    maxlength_phone_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_number)));
    avelength_phone_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_number)),h.phone_number<>(typeof(h.phone_number))'');
    populated_login_history_id_cnt := COUNT(GROUP,h.login_history_id <> (TYPEOF(h.login_history_id))'');
    populated_login_history_id_pcnt := AVE(GROUP,IF(h.login_history_id = (TYPEOF(h.login_history_id))'',0,100));
    maxlength_login_history_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.login_history_id)));
    avelength_login_history_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.login_history_id)),h.login_history_id<>(typeof(h.login_history_id))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_street_pre_direction_cnt := COUNT(GROUP,h.street_pre_direction <> (TYPEOF(h.street_pre_direction))'');
    populated_street_pre_direction_pcnt := AVE(GROUP,IF(h.street_pre_direction = (TYPEOF(h.street_pre_direction))'',0,100));
    maxlength_street_pre_direction := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_pre_direction)));
    avelength_street_pre_direction := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_pre_direction)),h.street_pre_direction<>(typeof(h.street_pre_direction))'');
    populated_street_post_direction_cnt := COUNT(GROUP,h.street_post_direction <> (TYPEOF(h.street_post_direction))'');
    populated_street_post_direction_pcnt := AVE(GROUP,IF(h.street_post_direction = (TYPEOF(h.street_post_direction))'',0,100));
    maxlength_street_post_direction := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_post_direction)));
    avelength_street_post_direction := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_post_direction)),h.street_post_direction<>(typeof(h.street_post_direction))'');
    populated_street_number_cnt := COUNT(GROUP,h.street_number <> (TYPEOF(h.street_number))'');
    populated_street_number_pcnt := AVE(GROUP,IF(h.street_number = (TYPEOF(h.street_number))'',0,100));
    maxlength_street_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_number)));
    avelength_street_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_number)),h.street_number<>(typeof(h.street_number))'');
    populated_street_name_cnt := COUNT(GROUP,h.street_name <> (TYPEOF(h.street_name))'');
    populated_street_name_pcnt := AVE(GROUP,IF(h.street_name = (TYPEOF(h.street_name))'',0,100));
    maxlength_street_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_name)));
    avelength_street_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_name)),h.street_name<>(typeof(h.street_name))'');
    populated_street_suffix_cnt := COUNT(GROUP,h.street_suffix <> (TYPEOF(h.street_suffix))'');
    populated_street_suffix_pcnt := AVE(GROUP,IF(h.street_suffix = (TYPEOF(h.street_suffix))'',0,100));
    maxlength_street_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_suffix)));
    avelength_street_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_suffix)),h.street_suffix<>(typeof(h.street_suffix))'');
    populated_unit_number_cnt := COUNT(GROUP,h.unit_number <> (TYPEOF(h.unit_number))'');
    populated_unit_number_pcnt := AVE(GROUP,IF(h.unit_number = (TYPEOF(h.unit_number))'',0,100));
    maxlength_unit_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_number)));
    avelength_unit_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_number)),h.unit_number<>(typeof(h.unit_number))'');
    populated_unit_designation_cnt := COUNT(GROUP,h.unit_designation <> (TYPEOF(h.unit_designation))'');
    populated_unit_designation_pcnt := AVE(GROUP,IF(h.unit_designation = (TYPEOF(h.unit_designation))'',0,100));
    maxlength_unit_designation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_designation)));
    avelength_unit_designation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_designation)),h.unit_designation<>(typeof(h.unit_designation))'');
    populated_zip5_cnt := COUNT(GROUP,h.zip5 <> (TYPEOF(h.zip5))'');
    populated_zip5_pcnt := AVE(GROUP,IF(h.zip5 = (TYPEOF(h.zip5))'',0,100));
    maxlength_zip5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip5)));
    avelength_zip5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip5)),h.zip5<>(typeof(h.zip5))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_alt_phone_cnt := COUNT(GROUP,h.alt_phone <> (TYPEOF(h.alt_phone))'');
    populated_alt_phone_pcnt := AVE(GROUP,IF(h.alt_phone = (TYPEOF(h.alt_phone))'',0,100));
    maxlength_alt_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_phone)));
    avelength_alt_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_phone)),h.alt_phone<>(typeof(h.alt_phone))'');
    populated_other_info_cnt := COUNT(GROUP,h.other_info <> (TYPEOF(h.other_info))'');
    populated_other_info_pcnt := AVE(GROUP,IF(h.other_info = (TYPEOF(h.other_info))'',0,100));
    maxlength_other_info := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_info)));
    avelength_other_info := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_info)),h.other_info<>(typeof(h.other_info))'');
    populated_phone_contact_type_cnt := COUNT(GROUP,h.phone_contact_type <> (TYPEOF(h.phone_contact_type))'');
    populated_phone_contact_type_pcnt := AVE(GROUP,IF(h.phone_contact_type = (TYPEOF(h.phone_contact_type))'',0,100));
    maxlength_phone_contact_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_contact_type)));
    avelength_phone_contact_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_contact_type)),h.phone_contact_type<>(typeof(h.phone_contact_type))'');
    populated_feedback_source_cnt := COUNT(GROUP,h.feedback_source <> (TYPEOF(h.feedback_source))'');
    populated_feedback_source_pcnt := AVE(GROUP,IF(h.feedback_source = (TYPEOF(h.feedback_source))'',0,100));
    maxlength_feedback_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.feedback_source)));
    avelength_feedback_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.feedback_source)),h.feedback_source<>(typeof(h.feedback_source))'');
    populated_date_time_added_cnt := COUNT(GROUP,h.date_time_added <> (TYPEOF(h.date_time_added))'');
    populated_date_time_added_pcnt := AVE(GROUP,IF(h.date_time_added = (TYPEOF(h.date_time_added))'',0,100));
    maxlength_date_time_added := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_time_added)));
    avelength_date_time_added := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_time_added)),h.date_time_added<>(typeof(h.date_time_added))'');
    populated_loginid_cnt := COUNT(GROUP,h.loginid <> (TYPEOF(h.loginid))'');
    populated_loginid_pcnt := AVE(GROUP,IF(h.loginid = (TYPEOF(h.loginid))'',0,100));
    maxlength_loginid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.loginid)));
    avelength_loginid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.loginid)),h.loginid<>(typeof(h.loginid))'');
    populated_customerid_cnt := COUNT(GROUP,h.customerid <> (TYPEOF(h.customerid))'');
    populated_customerid_pcnt := AVE(GROUP,IF(h.customerid = (TYPEOF(h.customerid))'',0,100));
    maxlength_customerid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.customerid)));
    avelength_customerid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.customerid)),h.customerid<>(typeof(h.customerid))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_hhid_pcnt *   0.00 / 100 + T.Populated_phone_number_pcnt *   0.00 / 100 + T.Populated_login_history_id_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_street_pre_direction_pcnt *   0.00 / 100 + T.Populated_street_post_direction_pcnt *   0.00 / 100 + T.Populated_street_number_pcnt *   0.00 / 100 + T.Populated_street_name_pcnt *   0.00 / 100 + T.Populated_street_suffix_pcnt *   0.00 / 100 + T.Populated_unit_number_pcnt *   0.00 / 100 + T.Populated_unit_designation_pcnt *   0.00 / 100 + T.Populated_zip5_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_alt_phone_pcnt *   0.00 / 100 + T.Populated_other_info_pcnt *   0.00 / 100 + T.Populated_phone_contact_type_pcnt *   0.00 / 100 + T.Populated_feedback_source_pcnt *   0.00 / 100 + T.Populated_date_time_added_pcnt *   0.00 / 100 + T.Populated_loginid_pcnt *   0.00 / 100 + T.Populated_customerid_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'did','did_score','hhid','phone_number','login_history_id','fname','lname','mname','street_pre_direction','street_post_direction','street_number','street_name','street_suffix','unit_number','unit_designation','zip5','zip4','city','state','alt_phone','other_info','phone_contact_type','feedback_source','date_time_added','loginid','customerid');
  SELF.populated_pcnt := CHOOSE(C,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_hhid_pcnt,le.populated_phone_number_pcnt,le.populated_login_history_id_pcnt,le.populated_fname_pcnt,le.populated_lname_pcnt,le.populated_mname_pcnt,le.populated_street_pre_direction_pcnt,le.populated_street_post_direction_pcnt,le.populated_street_number_pcnt,le.populated_street_name_pcnt,le.populated_street_suffix_pcnt,le.populated_unit_number_pcnt,le.populated_unit_designation_pcnt,le.populated_zip5_pcnt,le.populated_zip4_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_alt_phone_pcnt,le.populated_other_info_pcnt,le.populated_phone_contact_type_pcnt,le.populated_feedback_source_pcnt,le.populated_date_time_added_pcnt,le.populated_loginid_pcnt,le.populated_customerid_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_did,le.maxlength_did_score,le.maxlength_hhid,le.maxlength_phone_number,le.maxlength_login_history_id,le.maxlength_fname,le.maxlength_lname,le.maxlength_mname,le.maxlength_street_pre_direction,le.maxlength_street_post_direction,le.maxlength_street_number,le.maxlength_street_name,le.maxlength_street_suffix,le.maxlength_unit_number,le.maxlength_unit_designation,le.maxlength_zip5,le.maxlength_zip4,le.maxlength_city,le.maxlength_state,le.maxlength_alt_phone,le.maxlength_other_info,le.maxlength_phone_contact_type,le.maxlength_feedback_source,le.maxlength_date_time_added,le.maxlength_loginid,le.maxlength_customerid);
  SELF.avelength := CHOOSE(C,le.avelength_did,le.avelength_did_score,le.avelength_hhid,le.avelength_phone_number,le.avelength_login_history_id,le.avelength_fname,le.avelength_lname,le.avelength_mname,le.avelength_street_pre_direction,le.avelength_street_post_direction,le.avelength_street_number,le.avelength_street_name,le.avelength_street_suffix,le.avelength_unit_number,le.avelength_unit_designation,le.avelength_zip5,le.avelength_zip4,le.avelength_city,le.avelength_state,le.avelength_alt_phone,le.avelength_other_info,le.avelength_phone_contact_type,le.avelength_feedback_source,le.avelength_date_time_added,le.avelength_loginid,le.avelength_customerid);
END;
EXPORT invSummary := NORMALIZE(summary0, 26, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),IF (le.hhid <> 0,TRIM((SALT311.StrType)le.hhid), ''),TRIM((SALT311.StrType)le.phone_number),TRIM((SALT311.StrType)le.login_history_id),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.street_pre_direction),TRIM((SALT311.StrType)le.street_post_direction),TRIM((SALT311.StrType)le.street_number),TRIM((SALT311.StrType)le.street_name),TRIM((SALT311.StrType)le.street_suffix),TRIM((SALT311.StrType)le.unit_number),TRIM((SALT311.StrType)le.unit_designation),TRIM((SALT311.StrType)le.zip5),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.alt_phone),TRIM((SALT311.StrType)le.other_info),TRIM((SALT311.StrType)le.phone_contact_type),TRIM((SALT311.StrType)le.feedback_source),TRIM((SALT311.StrType)le.date_time_added),TRIM((SALT311.StrType)le.loginid),TRIM((SALT311.StrType)le.customerid)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,26,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 26);
  SELF.FldNo2 := 1 + (C % 26);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),IF (le.hhid <> 0,TRIM((SALT311.StrType)le.hhid), ''),TRIM((SALT311.StrType)le.phone_number),TRIM((SALT311.StrType)le.login_history_id),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.street_pre_direction),TRIM((SALT311.StrType)le.street_post_direction),TRIM((SALT311.StrType)le.street_number),TRIM((SALT311.StrType)le.street_name),TRIM((SALT311.StrType)le.street_suffix),TRIM((SALT311.StrType)le.unit_number),TRIM((SALT311.StrType)le.unit_designation),TRIM((SALT311.StrType)le.zip5),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.alt_phone),TRIM((SALT311.StrType)le.other_info),TRIM((SALT311.StrType)le.phone_contact_type),TRIM((SALT311.StrType)le.feedback_source),TRIM((SALT311.StrType)le.date_time_added),TRIM((SALT311.StrType)le.loginid),TRIM((SALT311.StrType)le.customerid)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),IF (le.hhid <> 0,TRIM((SALT311.StrType)le.hhid), ''),TRIM((SALT311.StrType)le.phone_number),TRIM((SALT311.StrType)le.login_history_id),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.street_pre_direction),TRIM((SALT311.StrType)le.street_post_direction),TRIM((SALT311.StrType)le.street_number),TRIM((SALT311.StrType)le.street_name),TRIM((SALT311.StrType)le.street_suffix),TRIM((SALT311.StrType)le.unit_number),TRIM((SALT311.StrType)le.unit_designation),TRIM((SALT311.StrType)le.zip5),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.alt_phone),TRIM((SALT311.StrType)le.other_info),TRIM((SALT311.StrType)le.phone_contact_type),TRIM((SALT311.StrType)le.feedback_source),TRIM((SALT311.StrType)le.date_time_added),TRIM((SALT311.StrType)le.loginid),TRIM((SALT311.StrType)le.customerid)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),26*26,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'did'}
      ,{2,'did_score'}
      ,{3,'hhid'}
      ,{4,'phone_number'}
      ,{5,'login_history_id'}
      ,{6,'fname'}
      ,{7,'lname'}
      ,{8,'mname'}
      ,{9,'street_pre_direction'}
      ,{10,'street_post_direction'}
      ,{11,'street_number'}
      ,{12,'street_name'}
      ,{13,'street_suffix'}
      ,{14,'unit_number'}
      ,{15,'unit_designation'}
      ,{16,'zip5'}
      ,{17,'zip4'}
      ,{18,'city'}
      ,{19,'state'}
      ,{20,'alt_phone'}
      ,{21,'other_info'}
      ,{22,'phone_contact_type'}
      ,{23,'feedback_source'}
      ,{24,'date_time_added'}
      ,{25,'loginid'}
      ,{26,'customerid'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_did((SALT311.StrType)le.did),
    Fields.InValid_did_score((SALT311.StrType)le.did_score),
    Fields.InValid_hhid((SALT311.StrType)le.hhid),
    Fields.InValid_phone_number((SALT311.StrType)le.phone_number),
    Fields.InValid_login_history_id((SALT311.StrType)le.login_history_id),
    Fields.InValid_fname((SALT311.StrType)le.fname),
    Fields.InValid_lname((SALT311.StrType)le.lname),
    Fields.InValid_mname((SALT311.StrType)le.mname),
    Fields.InValid_street_pre_direction((SALT311.StrType)le.street_pre_direction),
    Fields.InValid_street_post_direction((SALT311.StrType)le.street_post_direction),
    Fields.InValid_street_number((SALT311.StrType)le.street_number),
    Fields.InValid_street_name((SALT311.StrType)le.street_name),
    Fields.InValid_street_suffix((SALT311.StrType)le.street_suffix),
    Fields.InValid_unit_number((SALT311.StrType)le.unit_number),
    Fields.InValid_unit_designation((SALT311.StrType)le.unit_designation),
    Fields.InValid_zip5((SALT311.StrType)le.zip5),
    Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Fields.InValid_city((SALT311.StrType)le.city),
    Fields.InValid_state((SALT311.StrType)le.state),
    Fields.InValid_alt_phone((SALT311.StrType)le.alt_phone),
    Fields.InValid_other_info((SALT311.StrType)le.other_info),
    Fields.InValid_phone_contact_type((SALT311.StrType)le.phone_contact_type),
    Fields.InValid_feedback_source((SALT311.StrType)le.feedback_source),
    Fields.InValid_date_time_added((SALT311.StrType)le.date_time_added),
    Fields.InValid_loginid((SALT311.StrType)le.loginid),
    Fields.InValid_customerid((SALT311.StrType)le.customerid),
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
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Unknown','Unknown','Unknown','Invalid_Direction','Invalid_Direction','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Num','Invalid_Num','Unknown','Invalid_State','Invalid_Num','Unknown','Invalid_Num','Invalid_Num','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Fields.InValidMessage_hhid(TotalErrors.ErrorNum),Fields.InValidMessage_phone_number(TotalErrors.ErrorNum),Fields.InValidMessage_login_history_id(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_street_pre_direction(TotalErrors.ErrorNum),Fields.InValidMessage_street_post_direction(TotalErrors.ErrorNum),Fields.InValidMessage_street_number(TotalErrors.ErrorNum),Fields.InValidMessage_street_name(TotalErrors.ErrorNum),Fields.InValidMessage_street_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_unit_number(TotalErrors.ErrorNum),Fields.InValidMessage_unit_designation(TotalErrors.ErrorNum),Fields.InValidMessage_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_alt_phone(TotalErrors.ErrorNum),Fields.InValidMessage_other_info(TotalErrors.ErrorNum),Fields.InValidMessage_phone_contact_type(TotalErrors.ErrorNum),Fields.InValidMessage_feedback_source(TotalErrors.ErrorNum),Fields.InValidMessage_date_time_added(TotalErrors.ErrorNum),Fields.InValidMessage_loginid(TotalErrors.ErrorNum),Fields.InValidMessage_customerid(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesFeedback, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
