IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_In_MI) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_code_cnt := COUNT(GROUP,h.code <> (TYPEOF(h.code))'');
    populated_code_pcnt := AVE(GROUP,IF(h.code = (TYPEOF(h.code))'',0,100));
    maxlength_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.code)));
    avelength_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.code)),h.code<>(typeof(h.code))'');
    populated_customer_dln_pid_cnt := COUNT(GROUP,h.customer_dln_pid <> (TYPEOF(h.customer_dln_pid))'');
    populated_customer_dln_pid_pcnt := AVE(GROUP,IF(h.customer_dln_pid = (TYPEOF(h.customer_dln_pid))'',0,100));
    maxlength_customer_dln_pid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_dln_pid)));
    avelength_customer_dln_pid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_dln_pid)),h.customer_dln_pid<>(typeof(h.customer_dln_pid))'');
    populated_last_name_cnt := COUNT(GROUP,h.last_name <> (TYPEOF(h.last_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_first_name_cnt := COUNT(GROUP,h.first_name <> (TYPEOF(h.first_name))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_middle_name_cnt := COUNT(GROUP,h.middle_name <> (TYPEOF(h.middle_name))'');
    populated_middle_name_pcnt := AVE(GROUP,IF(h.middle_name = (TYPEOF(h.middle_name))'',0,100));
    maxlength_middle_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.middle_name)));
    avelength_middle_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.middle_name)),h.middle_name<>(typeof(h.middle_name))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_street_address_cnt := COUNT(GROUP,h.street_address <> (TYPEOF(h.street_address))'');
    populated_street_address_pcnt := AVE(GROUP,IF(h.street_address = (TYPEOF(h.street_address))'',0,100));
    maxlength_street_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_address)));
    avelength_street_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_address)),h.street_address<>(typeof(h.street_address))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zipcode_cnt := COUNT(GROUP,h.zipcode <> (TYPEOF(h.zipcode))'');
    populated_zipcode_pcnt := AVE(GROUP,IF(h.zipcode = (TYPEOF(h.zipcode))'',0,100));
    maxlength_zipcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zipcode)));
    avelength_zipcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zipcode)),h.zipcode<>(typeof(h.zipcode))'');
    populated_date_of_birth_cnt := COUNT(GROUP,h.date_of_birth <> (TYPEOF(h.date_of_birth))'');
    populated_date_of_birth_pcnt := AVE(GROUP,IF(h.date_of_birth = (TYPEOF(h.date_of_birth))'',0,100));
    maxlength_date_of_birth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_of_birth)));
    avelength_date_of_birth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_of_birth)),h.date_of_birth<>(typeof(h.date_of_birth))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_dln_pid_indicator_cnt := COUNT(GROUP,h.dln_pid_indicator <> (TYPEOF(h.dln_pid_indicator))'');
    populated_dln_pid_indicator_pcnt := AVE(GROUP,IF(h.dln_pid_indicator = (TYPEOF(h.dln_pid_indicator))'',0,100));
    maxlength_dln_pid_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dln_pid_indicator)));
    avelength_dln_pid_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dln_pid_indicator)),h.dln_pid_indicator<>(typeof(h.dln_pid_indicator))'');
    populated_mailing_street_address_cnt := COUNT(GROUP,h.mailing_street_address <> (TYPEOF(h.mailing_street_address))'');
    populated_mailing_street_address_pcnt := AVE(GROUP,IF(h.mailing_street_address = (TYPEOF(h.mailing_street_address))'',0,100));
    maxlength_mailing_street_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_street_address)));
    avelength_mailing_street_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_street_address)),h.mailing_street_address<>(typeof(h.mailing_street_address))'');
    populated_mailing_city_cnt := COUNT(GROUP,h.mailing_city <> (TYPEOF(h.mailing_city))'');
    populated_mailing_city_pcnt := AVE(GROUP,IF(h.mailing_city = (TYPEOF(h.mailing_city))'',0,100));
    maxlength_mailing_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_city)));
    avelength_mailing_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_city)),h.mailing_city<>(typeof(h.mailing_city))'');
    populated_mailing_state_cnt := COUNT(GROUP,h.mailing_state <> (TYPEOF(h.mailing_state))'');
    populated_mailing_state_pcnt := AVE(GROUP,IF(h.mailing_state = (TYPEOF(h.mailing_state))'',0,100));
    maxlength_mailing_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_state)));
    avelength_mailing_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_state)),h.mailing_state<>(typeof(h.mailing_state))'');
    populated_mailing_zipcode_cnt := COUNT(GROUP,h.mailing_zipcode <> (TYPEOF(h.mailing_zipcode))'');
    populated_mailing_zipcode_pcnt := AVE(GROUP,IF(h.mailing_zipcode = (TYPEOF(h.mailing_zipcode))'',0,100));
    maxlength_mailing_zipcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_zipcode)));
    avelength_mailing_zipcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_zipcode)),h.mailing_zipcode<>(typeof(h.mailing_zipcode))'');
    populated_blob_cnt := COUNT(GROUP,h.blob <> (TYPEOF(h.blob))'');
    populated_blob_pcnt := AVE(GROUP,IF(h.blob = (TYPEOF(h.blob))'',0,100));
    maxlength_blob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.blob)));
    avelength_blob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.blob)),h.blob<>(typeof(h.blob))'');
    populated_clean_name_prefix_cnt := COUNT(GROUP,h.clean_name_prefix <> (TYPEOF(h.clean_name_prefix))'');
    populated_clean_name_prefix_pcnt := AVE(GROUP,IF(h.clean_name_prefix = (TYPEOF(h.clean_name_prefix))'',0,100));
    maxlength_clean_name_prefix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_prefix)));
    avelength_clean_name_prefix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_prefix)),h.clean_name_prefix<>(typeof(h.clean_name_prefix))'');
    populated_clean_fname_cnt := COUNT(GROUP,h.clean_fname <> (TYPEOF(h.clean_fname))'');
    populated_clean_fname_pcnt := AVE(GROUP,IF(h.clean_fname = (TYPEOF(h.clean_fname))'',0,100));
    maxlength_clean_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_fname)));
    avelength_clean_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_fname)),h.clean_fname<>(typeof(h.clean_fname))'');
    populated_clean_mname_cnt := COUNT(GROUP,h.clean_mname <> (TYPEOF(h.clean_mname))'');
    populated_clean_mname_pcnt := AVE(GROUP,IF(h.clean_mname = (TYPEOF(h.clean_mname))'',0,100));
    maxlength_clean_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_mname)));
    avelength_clean_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_mname)),h.clean_mname<>(typeof(h.clean_mname))'');
    populated_clean_lname_cnt := COUNT(GROUP,h.clean_lname <> (TYPEOF(h.clean_lname))'');
    populated_clean_lname_pcnt := AVE(GROUP,IF(h.clean_lname = (TYPEOF(h.clean_lname))'',0,100));
    maxlength_clean_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_lname)));
    avelength_clean_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_lname)),h.clean_lname<>(typeof(h.clean_lname))'');
    populated_clean_name_suffix_cnt := COUNT(GROUP,h.clean_name_suffix <> (TYPEOF(h.clean_name_suffix))'');
    populated_clean_name_suffix_pcnt := AVE(GROUP,IF(h.clean_name_suffix = (TYPEOF(h.clean_name_suffix))'',0,100));
    maxlength_clean_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_suffix)));
    avelength_clean_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_suffix)),h.clean_name_suffix<>(typeof(h.clean_name_suffix))'');
    populated_clean_name_score_cnt := COUNT(GROUP,h.clean_name_score <> (TYPEOF(h.clean_name_score))'');
    populated_clean_name_score_pcnt := AVE(GROUP,IF(h.clean_name_score = (TYPEOF(h.clean_name_score))'',0,100));
    maxlength_clean_name_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_score)));
    avelength_clean_name_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_score)),h.clean_name_score<>(typeof(h.clean_name_score))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_code_pcnt *   0.00 / 100 + T.Populated_customer_dln_pid_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_middle_name_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_street_address_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zipcode_pcnt *   0.00 / 100 + T.Populated_date_of_birth_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_dln_pid_indicator_pcnt *   0.00 / 100 + T.Populated_mailing_street_address_pcnt *   0.00 / 100 + T.Populated_mailing_city_pcnt *   0.00 / 100 + T.Populated_mailing_state_pcnt *   0.00 / 100 + T.Populated_mailing_zipcode_pcnt *   0.00 / 100 + T.Populated_blob_pcnt *   0.00 / 100 + T.Populated_clean_name_prefix_pcnt *   0.00 / 100 + T.Populated_clean_fname_pcnt *   0.00 / 100 + T.Populated_clean_mname_pcnt *   0.00 / 100 + T.Populated_clean_lname_pcnt *   0.00 / 100 + T.Populated_clean_name_suffix_pcnt *   0.00 / 100 + T.Populated_clean_name_score_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'process_date','code','customer_dln_pid','last_name','first_name','middle_name','name_suffix','street_address','city','state','zipcode','date_of_birth','gender','county','dln_pid_indicator','mailing_street_address','mailing_city','mailing_state','mailing_zipcode','blob','clean_name_prefix','clean_fname','clean_mname','clean_lname','clean_name_suffix','clean_name_score');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_code_pcnt,le.populated_customer_dln_pid_pcnt,le.populated_last_name_pcnt,le.populated_first_name_pcnt,le.populated_middle_name_pcnt,le.populated_name_suffix_pcnt,le.populated_street_address_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zipcode_pcnt,le.populated_date_of_birth_pcnt,le.populated_gender_pcnt,le.populated_county_pcnt,le.populated_dln_pid_indicator_pcnt,le.populated_mailing_street_address_pcnt,le.populated_mailing_city_pcnt,le.populated_mailing_state_pcnt,le.populated_mailing_zipcode_pcnt,le.populated_blob_pcnt,le.populated_clean_name_prefix_pcnt,le.populated_clean_fname_pcnt,le.populated_clean_mname_pcnt,le.populated_clean_lname_pcnt,le.populated_clean_name_suffix_pcnt,le.populated_clean_name_score_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_code,le.maxlength_customer_dln_pid,le.maxlength_last_name,le.maxlength_first_name,le.maxlength_middle_name,le.maxlength_name_suffix,le.maxlength_street_address,le.maxlength_city,le.maxlength_state,le.maxlength_zipcode,le.maxlength_date_of_birth,le.maxlength_gender,le.maxlength_county,le.maxlength_dln_pid_indicator,le.maxlength_mailing_street_address,le.maxlength_mailing_city,le.maxlength_mailing_state,le.maxlength_mailing_zipcode,le.maxlength_blob,le.maxlength_clean_name_prefix,le.maxlength_clean_fname,le.maxlength_clean_mname,le.maxlength_clean_lname,le.maxlength_clean_name_suffix,le.maxlength_clean_name_score);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_code,le.avelength_customer_dln_pid,le.avelength_last_name,le.avelength_first_name,le.avelength_middle_name,le.avelength_name_suffix,le.avelength_street_address,le.avelength_city,le.avelength_state,le.avelength_zipcode,le.avelength_date_of_birth,le.avelength_gender,le.avelength_county,le.avelength_dln_pid_indicator,le.avelength_mailing_street_address,le.avelength_mailing_city,le.avelength_mailing_state,le.avelength_mailing_zipcode,le.avelength_blob,le.avelength_clean_name_prefix,le.avelength_clean_fname,le.avelength_clean_mname,le.avelength_clean_lname,le.avelength_clean_name_suffix,le.avelength_clean_name_score);
END;
EXPORT invSummary := NORMALIZE(summary0, 26, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.code),TRIM((SALT311.StrType)le.customer_dln_pid),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.middle_name),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.street_address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zipcode),TRIM((SALT311.StrType)le.date_of_birth),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.dln_pid_indicator),TRIM((SALT311.StrType)le.mailing_street_address),TRIM((SALT311.StrType)le.mailing_city),TRIM((SALT311.StrType)le.mailing_state),TRIM((SALT311.StrType)le.mailing_zipcode),TRIM((SALT311.StrType)le.blob),TRIM((SALT311.StrType)le.clean_name_prefix),TRIM((SALT311.StrType)le.clean_fname),TRIM((SALT311.StrType)le.clean_mname),TRIM((SALT311.StrType)le.clean_lname),TRIM((SALT311.StrType)le.clean_name_suffix),TRIM((SALT311.StrType)le.clean_name_score)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,26,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 26);
  SELF.FldNo2 := 1 + (C % 26);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.code),TRIM((SALT311.StrType)le.customer_dln_pid),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.middle_name),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.street_address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zipcode),TRIM((SALT311.StrType)le.date_of_birth),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.dln_pid_indicator),TRIM((SALT311.StrType)le.mailing_street_address),TRIM((SALT311.StrType)le.mailing_city),TRIM((SALT311.StrType)le.mailing_state),TRIM((SALT311.StrType)le.mailing_zipcode),TRIM((SALT311.StrType)le.blob),TRIM((SALT311.StrType)le.clean_name_prefix),TRIM((SALT311.StrType)le.clean_fname),TRIM((SALT311.StrType)le.clean_mname),TRIM((SALT311.StrType)le.clean_lname),TRIM((SALT311.StrType)le.clean_name_suffix),TRIM((SALT311.StrType)le.clean_name_score)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.code),TRIM((SALT311.StrType)le.customer_dln_pid),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.middle_name),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.street_address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zipcode),TRIM((SALT311.StrType)le.date_of_birth),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.dln_pid_indicator),TRIM((SALT311.StrType)le.mailing_street_address),TRIM((SALT311.StrType)le.mailing_city),TRIM((SALT311.StrType)le.mailing_state),TRIM((SALT311.StrType)le.mailing_zipcode),TRIM((SALT311.StrType)le.blob),TRIM((SALT311.StrType)le.clean_name_prefix),TRIM((SALT311.StrType)le.clean_fname),TRIM((SALT311.StrType)le.clean_mname),TRIM((SALT311.StrType)le.clean_lname),TRIM((SALT311.StrType)le.clean_name_suffix),TRIM((SALT311.StrType)le.clean_name_score)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),26*26,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'code'}
      ,{3,'customer_dln_pid'}
      ,{4,'last_name'}
      ,{5,'first_name'}
      ,{6,'middle_name'}
      ,{7,'name_suffix'}
      ,{8,'street_address'}
      ,{9,'city'}
      ,{10,'state'}
      ,{11,'zipcode'}
      ,{12,'date_of_birth'}
      ,{13,'gender'}
      ,{14,'county'}
      ,{15,'dln_pid_indicator'}
      ,{16,'mailing_street_address'}
      ,{17,'mailing_city'}
      ,{18,'mailing_state'}
      ,{19,'mailing_zipcode'}
      ,{20,'blob'}
      ,{21,'clean_name_prefix'}
      ,{22,'clean_fname'}
      ,{23,'clean_mname'}
      ,{24,'clean_lname'}
      ,{25,'clean_name_suffix'}
      ,{26,'clean_name_score'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Fields.InValid_code((SALT311.StrType)le.code),
    Fields.InValid_customer_dln_pid((SALT311.StrType)le.customer_dln_pid),
    Fields.InValid_last_name((SALT311.StrType)le.last_name),
    Fields.InValid_first_name((SALT311.StrType)le.first_name,(SALT311.StrType)le.middle_name,(SALT311.StrType)le.last_name),
    Fields.InValid_middle_name((SALT311.StrType)le.middle_name),
    Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    Fields.InValid_street_address((SALT311.StrType)le.street_address),
    Fields.InValid_city((SALT311.StrType)le.city),
    Fields.InValid_state((SALT311.StrType)le.state),
    Fields.InValid_zipcode((SALT311.StrType)le.zipcode),
    Fields.InValid_date_of_birth((SALT311.StrType)le.date_of_birth),
    Fields.InValid_gender((SALT311.StrType)le.gender),
    Fields.InValid_county((SALT311.StrType)le.county),
    Fields.InValid_dln_pid_indicator((SALT311.StrType)le.dln_pid_indicator),
    Fields.InValid_mailing_street_address((SALT311.StrType)le.mailing_street_address),
    Fields.InValid_mailing_city((SALT311.StrType)le.mailing_city),
    Fields.InValid_mailing_state((SALT311.StrType)le.mailing_state),
    Fields.InValid_mailing_zipcode((SALT311.StrType)le.mailing_zipcode),
    Fields.InValid_blob((SALT311.StrType)le.blob),
    Fields.InValid_clean_name_prefix((SALT311.StrType)le.clean_name_prefix),
    Fields.InValid_clean_fname((SALT311.StrType)le.clean_fname,(SALT311.StrType)le.clean_mname,(SALT311.StrType)le.clean_lname),
    Fields.InValid_clean_mname((SALT311.StrType)le.clean_mname),
    Fields.InValid_clean_lname((SALT311.StrType)le.clean_lname),
    Fields.InValid_clean_name_suffix((SALT311.StrType)le.clean_name_suffix),
    Fields.InValid_clean_name_score((SALT311.StrType)le.clean_name_score),
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
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_past_date','invalid_code','invalid_dl_number_check','Unknown','invalid_name','Unknown','Unknown','invalid_street','invalid_city','invalid_state','invalid_zip','invalid_past_date','invalid_gender','invalid_numeric','invalid_dln_pid_indi','invalid_street','invalid_city','invalid_state','invalid_zip','Unknown','Unknown','invalid_clean_name','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_code(TotalErrors.ErrorNum),Fields.InValidMessage_customer_dln_pid(TotalErrors.ErrorNum),Fields.InValidMessage_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_street_address(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zipcode(TotalErrors.ErrorNum),Fields.InValidMessage_date_of_birth(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_dln_pid_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_street_address(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_city(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_state(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_zipcode(TotalErrors.ErrorNum),Fields.InValidMessage_blob(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_prefix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_fname(TotalErrors.ErrorNum),Fields.InValidMessage_clean_mname(TotalErrors.ErrorNum),Fields.InValidMessage_clean_lname(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_score(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DL_MI, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
