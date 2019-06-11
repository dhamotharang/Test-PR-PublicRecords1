IMPORT SALT39,STD;
EXPORT hygiene(dataset(layout_In_MA) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_pers_surrogate_cnt := COUNT(GROUP,h.pers_surrogate <> (TYPEOF(h.pers_surrogate))'');
    populated_pers_surrogate_pcnt := AVE(GROUP,IF(h.pers_surrogate = (TYPEOF(h.pers_surrogate))'',0,100));
    maxlength_pers_surrogate := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.pers_surrogate)));
    avelength_pers_surrogate := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.pers_surrogate)),h.pers_surrogate<>(typeof(h.pers_surrogate))'');
    populated_filler1_cnt := COUNT(GROUP,h.filler1 <> (TYPEOF(h.filler1))'');
    populated_filler1_pcnt := AVE(GROUP,IF(h.filler1 = (TYPEOF(h.filler1))'',0,100));
    maxlength_filler1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.filler1)));
    avelength_filler1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.filler1)),h.filler1<>(typeof(h.filler1))'');
    populated_license_licno_cnt := COUNT(GROUP,h.license_licno <> (TYPEOF(h.license_licno))'');
    populated_license_licno_pcnt := AVE(GROUP,IF(h.license_licno = (TYPEOF(h.license_licno))'',0,100));
    maxlength_license_licno := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_licno)));
    avelength_license_licno := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_licno)),h.license_licno<>(typeof(h.license_licno))'');
    populated_filler2_cnt := COUNT(GROUP,h.filler2 <> (TYPEOF(h.filler2))'');
    populated_filler2_pcnt := AVE(GROUP,IF(h.filler2 = (TYPEOF(h.filler2))'',0,100));
    maxlength_filler2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.filler2)));
    avelength_filler2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.filler2)),h.filler2<>(typeof(h.filler2))'');
    populated_license_bdate_yyyymmdd_cnt := COUNT(GROUP,h.license_bdate_yyyymmdd <> (TYPEOF(h.license_bdate_yyyymmdd))'');
    populated_license_bdate_yyyymmdd_pcnt := AVE(GROUP,IF(h.license_bdate_yyyymmdd = (TYPEOF(h.license_bdate_yyyymmdd))'',0,100));
    maxlength_license_bdate_yyyymmdd := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_bdate_yyyymmdd)));
    avelength_license_bdate_yyyymmdd := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_bdate_yyyymmdd)),h.license_bdate_yyyymmdd<>(typeof(h.license_bdate_yyyymmdd))'');
    populated_license_edate_yyyymmdd_cnt := COUNT(GROUP,h.license_edate_yyyymmdd <> (TYPEOF(h.license_edate_yyyymmdd))'');
    populated_license_edate_yyyymmdd_pcnt := AVE(GROUP,IF(h.license_edate_yyyymmdd = (TYPEOF(h.license_edate_yyyymmdd))'',0,100));
    maxlength_license_edate_yyyymmdd := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_edate_yyyymmdd)));
    avelength_license_edate_yyyymmdd := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_edate_yyyymmdd)),h.license_edate_yyyymmdd<>(typeof(h.license_edate_yyyymmdd))'');
    populated_license_lic_class_cnt := COUNT(GROUP,h.license_lic_class <> (TYPEOF(h.license_lic_class))'');
    populated_license_lic_class_pcnt := AVE(GROUP,IF(h.license_lic_class = (TYPEOF(h.license_lic_class))'',0,100));
    maxlength_license_lic_class := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_lic_class)));
    avelength_license_lic_class := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_lic_class)),h.license_lic_class<>(typeof(h.license_lic_class))'');
    populated_license_height_cnt := COUNT(GROUP,h.license_height <> (TYPEOF(h.license_height))'');
    populated_license_height_pcnt := AVE(GROUP,IF(h.license_height = (TYPEOF(h.license_height))'',0,100));
    maxlength_license_height := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_height)));
    avelength_license_height := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_height)),h.license_height<>(typeof(h.license_height))'');
    populated_license_sex_cnt := COUNT(GROUP,h.license_sex <> (TYPEOF(h.license_sex))'');
    populated_license_sex_pcnt := AVE(GROUP,IF(h.license_sex = (TYPEOF(h.license_sex))'',0,100));
    maxlength_license_sex := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_sex)));
    avelength_license_sex := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_sex)),h.license_sex<>(typeof(h.license_sex))'');
    populated_license_last_name_cnt := COUNT(GROUP,h.license_last_name <> (TYPEOF(h.license_last_name))'');
    populated_license_last_name_pcnt := AVE(GROUP,IF(h.license_last_name = (TYPEOF(h.license_last_name))'',0,100));
    maxlength_license_last_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_last_name)));
    avelength_license_last_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_last_name)),h.license_last_name<>(typeof(h.license_last_name))'');
    populated_license_first_name_cnt := COUNT(GROUP,h.license_first_name <> (TYPEOF(h.license_first_name))'');
    populated_license_first_name_pcnt := AVE(GROUP,IF(h.license_first_name = (TYPEOF(h.license_first_name))'',0,100));
    maxlength_license_first_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_first_name)));
    avelength_license_first_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_first_name)),h.license_first_name<>(typeof(h.license_first_name))'');
    populated_license_middle_name_cnt := COUNT(GROUP,h.license_middle_name <> (TYPEOF(h.license_middle_name))'');
    populated_license_middle_name_pcnt := AVE(GROUP,IF(h.license_middle_name = (TYPEOF(h.license_middle_name))'',0,100));
    maxlength_license_middle_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_middle_name)));
    avelength_license_middle_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_middle_name)),h.license_middle_name<>(typeof(h.license_middle_name))'');
    populated_licmail_street1_cnt := COUNT(GROUP,h.licmail_street1 <> (TYPEOF(h.licmail_street1))'');
    populated_licmail_street1_pcnt := AVE(GROUP,IF(h.licmail_street1 = (TYPEOF(h.licmail_street1))'',0,100));
    maxlength_licmail_street1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.licmail_street1)));
    avelength_licmail_street1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.licmail_street1)),h.licmail_street1<>(typeof(h.licmail_street1))'');
    populated_licmail_street2_cnt := COUNT(GROUP,h.licmail_street2 <> (TYPEOF(h.licmail_street2))'');
    populated_licmail_street2_pcnt := AVE(GROUP,IF(h.licmail_street2 = (TYPEOF(h.licmail_street2))'',0,100));
    maxlength_licmail_street2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.licmail_street2)));
    avelength_licmail_street2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.licmail_street2)),h.licmail_street2<>(typeof(h.licmail_street2))'');
    populated_licmail_city_cnt := COUNT(GROUP,h.licmail_city <> (TYPEOF(h.licmail_city))'');
    populated_licmail_city_pcnt := AVE(GROUP,IF(h.licmail_city = (TYPEOF(h.licmail_city))'',0,100));
    maxlength_licmail_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.licmail_city)));
    avelength_licmail_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.licmail_city)),h.licmail_city<>(typeof(h.licmail_city))'');
    populated_licmail_state_cnt := COUNT(GROUP,h.licmail_state <> (TYPEOF(h.licmail_state))'');
    populated_licmail_state_pcnt := AVE(GROUP,IF(h.licmail_state = (TYPEOF(h.licmail_state))'',0,100));
    maxlength_licmail_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.licmail_state)));
    avelength_licmail_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.licmail_state)),h.licmail_state<>(typeof(h.licmail_state))'');
    populated_licmail_zip_cnt := COUNT(GROUP,h.licmail_zip <> (TYPEOF(h.licmail_zip))'');
    populated_licmail_zip_pcnt := AVE(GROUP,IF(h.licmail_zip = (TYPEOF(h.licmail_zip))'',0,100));
    maxlength_licmail_zip := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.licmail_zip)));
    avelength_licmail_zip := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.licmail_zip)),h.licmail_zip<>(typeof(h.licmail_zip))'');
    populated_licresi_street1_cnt := COUNT(GROUP,h.licresi_street1 <> (TYPEOF(h.licresi_street1))'');
    populated_licresi_street1_pcnt := AVE(GROUP,IF(h.licresi_street1 = (TYPEOF(h.licresi_street1))'',0,100));
    maxlength_licresi_street1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.licresi_street1)));
    avelength_licresi_street1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.licresi_street1)),h.licresi_street1<>(typeof(h.licresi_street1))'');
    populated_licresi_street2_cnt := COUNT(GROUP,h.licresi_street2 <> (TYPEOF(h.licresi_street2))'');
    populated_licresi_street2_pcnt := AVE(GROUP,IF(h.licresi_street2 = (TYPEOF(h.licresi_street2))'',0,100));
    maxlength_licresi_street2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.licresi_street2)));
    avelength_licresi_street2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.licresi_street2)),h.licresi_street2<>(typeof(h.licresi_street2))'');
    populated_licresi_city_cnt := COUNT(GROUP,h.licresi_city <> (TYPEOF(h.licresi_city))'');
    populated_licresi_city_pcnt := AVE(GROUP,IF(h.licresi_city = (TYPEOF(h.licresi_city))'',0,100));
    maxlength_licresi_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.licresi_city)));
    avelength_licresi_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.licresi_city)),h.licresi_city<>(typeof(h.licresi_city))'');
    populated_licresi_state_cnt := COUNT(GROUP,h.licresi_state <> (TYPEOF(h.licresi_state))'');
    populated_licresi_state_pcnt := AVE(GROUP,IF(h.licresi_state = (TYPEOF(h.licresi_state))'',0,100));
    maxlength_licresi_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.licresi_state)));
    avelength_licresi_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.licresi_state)),h.licresi_state<>(typeof(h.licresi_state))'');
    populated_licresi_zip_cnt := COUNT(GROUP,h.licresi_zip <> (TYPEOF(h.licresi_zip))'');
    populated_licresi_zip_pcnt := AVE(GROUP,IF(h.licresi_zip = (TYPEOF(h.licresi_zip))'',0,100));
    maxlength_licresi_zip := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.licresi_zip)));
    avelength_licresi_zip := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.licresi_zip)),h.licresi_zip<>(typeof(h.licresi_zip))'');
    populated_issue_date_yyyymmdd_cnt := COUNT(GROUP,h.issue_date_yyyymmdd <> (TYPEOF(h.issue_date_yyyymmdd))'');
    populated_issue_date_yyyymmdd_pcnt := AVE(GROUP,IF(h.issue_date_yyyymmdd = (TYPEOF(h.issue_date_yyyymmdd))'',0,100));
    maxlength_issue_date_yyyymmdd := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.issue_date_yyyymmdd)));
    avelength_issue_date_yyyymmdd := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.issue_date_yyyymmdd)),h.issue_date_yyyymmdd<>(typeof(h.issue_date_yyyymmdd))'');
    populated_license_status_cnt := COUNT(GROUP,h.license_status <> (TYPEOF(h.license_status))'');
    populated_license_status_pcnt := AVE(GROUP,IF(h.license_status = (TYPEOF(h.license_status))'',0,100));
    maxlength_license_status := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_status)));
    avelength_license_status := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.license_status)),h.license_status<>(typeof(h.license_status))'');
    populated_clean_status_cnt := COUNT(GROUP,h.clean_status <> (TYPEOF(h.clean_status))'');
    populated_clean_status_pcnt := AVE(GROUP,IF(h.clean_status = (TYPEOF(h.clean_status))'',0,100));
    maxlength_clean_status := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.clean_status)));
    avelength_clean_status := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.clean_status)),h.clean_status<>(typeof(h.clean_status))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_pers_surrogate_pcnt *   0.00 / 100 + T.Populated_filler1_pcnt *   0.00 / 100 + T.Populated_license_licno_pcnt *   0.00 / 100 + T.Populated_filler2_pcnt *   0.00 / 100 + T.Populated_license_bdate_yyyymmdd_pcnt *   0.00 / 100 + T.Populated_license_edate_yyyymmdd_pcnt *   0.00 / 100 + T.Populated_license_lic_class_pcnt *   0.00 / 100 + T.Populated_license_height_pcnt *   0.00 / 100 + T.Populated_license_sex_pcnt *   0.00 / 100 + T.Populated_license_last_name_pcnt *   0.00 / 100 + T.Populated_license_first_name_pcnt *   0.00 / 100 + T.Populated_license_middle_name_pcnt *   0.00 / 100 + T.Populated_licmail_street1_pcnt *   0.00 / 100 + T.Populated_licmail_street2_pcnt *   0.00 / 100 + T.Populated_licmail_city_pcnt *   0.00 / 100 + T.Populated_licmail_state_pcnt *   0.00 / 100 + T.Populated_licmail_zip_pcnt *   0.00 / 100 + T.Populated_licresi_street1_pcnt *   0.00 / 100 + T.Populated_licresi_street2_pcnt *   0.00 / 100 + T.Populated_licresi_city_pcnt *   0.00 / 100 + T.Populated_licresi_state_pcnt *   0.00 / 100 + T.Populated_licresi_zip_pcnt *   0.00 / 100 + T.Populated_issue_date_yyyymmdd_pcnt *   0.00 / 100 + T.Populated_license_status_pcnt *   0.00 / 100 + T.Populated_clean_status_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT39.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'pers_surrogate','filler1','license_licno','filler2','license_bdate_yyyymmdd','license_edate_yyyymmdd','license_lic_class','license_height','license_sex','license_last_name','license_first_name','license_middle_name','licmail_street1','licmail_street2','licmail_city','licmail_state','licmail_zip','licresi_street1','licresi_street2','licresi_city','licresi_state','licresi_zip','issue_date_yyyymmdd','license_status','clean_status','process_date');
  SELF.populated_pcnt := CHOOSE(C,le.populated_pers_surrogate_pcnt,le.populated_filler1_pcnt,le.populated_license_licno_pcnt,le.populated_filler2_pcnt,le.populated_license_bdate_yyyymmdd_pcnt,le.populated_license_edate_yyyymmdd_pcnt,le.populated_license_lic_class_pcnt,le.populated_license_height_pcnt,le.populated_license_sex_pcnt,le.populated_license_last_name_pcnt,le.populated_license_first_name_pcnt,le.populated_license_middle_name_pcnt,le.populated_licmail_street1_pcnt,le.populated_licmail_street2_pcnt,le.populated_licmail_city_pcnt,le.populated_licmail_state_pcnt,le.populated_licmail_zip_pcnt,le.populated_licresi_street1_pcnt,le.populated_licresi_street2_pcnt,le.populated_licresi_city_pcnt,le.populated_licresi_state_pcnt,le.populated_licresi_zip_pcnt,le.populated_issue_date_yyyymmdd_pcnt,le.populated_license_status_pcnt,le.populated_clean_status_pcnt,le.populated_process_date_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_pers_surrogate,le.maxlength_filler1,le.maxlength_license_licno,le.maxlength_filler2,le.maxlength_license_bdate_yyyymmdd,le.maxlength_license_edate_yyyymmdd,le.maxlength_license_lic_class,le.maxlength_license_height,le.maxlength_license_sex,le.maxlength_license_last_name,le.maxlength_license_first_name,le.maxlength_license_middle_name,le.maxlength_licmail_street1,le.maxlength_licmail_street2,le.maxlength_licmail_city,le.maxlength_licmail_state,le.maxlength_licmail_zip,le.maxlength_licresi_street1,le.maxlength_licresi_street2,le.maxlength_licresi_city,le.maxlength_licresi_state,le.maxlength_licresi_zip,le.maxlength_issue_date_yyyymmdd,le.maxlength_license_status,le.maxlength_clean_status,le.maxlength_process_date);
  SELF.avelength := CHOOSE(C,le.avelength_pers_surrogate,le.avelength_filler1,le.avelength_license_licno,le.avelength_filler2,le.avelength_license_bdate_yyyymmdd,le.avelength_license_edate_yyyymmdd,le.avelength_license_lic_class,le.avelength_license_height,le.avelength_license_sex,le.avelength_license_last_name,le.avelength_license_first_name,le.avelength_license_middle_name,le.avelength_licmail_street1,le.avelength_licmail_street2,le.avelength_licmail_city,le.avelength_licmail_state,le.avelength_licmail_zip,le.avelength_licresi_street1,le.avelength_licresi_street2,le.avelength_licresi_city,le.avelength_licresi_state,le.avelength_licresi_zip,le.avelength_issue_date_yyyymmdd,le.avelength_license_status,le.avelength_clean_status,le.avelength_process_date);
END;
EXPORT invSummary := NORMALIZE(summary0, 26, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.pers_surrogate),TRIM((SALT39.StrType)le.filler1),TRIM((SALT39.StrType)le.license_licno),TRIM((SALT39.StrType)le.filler2),TRIM((SALT39.StrType)le.license_bdate_yyyymmdd),TRIM((SALT39.StrType)le.license_edate_yyyymmdd),TRIM((SALT39.StrType)le.license_lic_class),TRIM((SALT39.StrType)le.license_height),TRIM((SALT39.StrType)le.license_sex),TRIM((SALT39.StrType)le.license_last_name),TRIM((SALT39.StrType)le.license_first_name),TRIM((SALT39.StrType)le.license_middle_name),TRIM((SALT39.StrType)le.licmail_street1),TRIM((SALT39.StrType)le.licmail_street2),TRIM((SALT39.StrType)le.licmail_city),TRIM((SALT39.StrType)le.licmail_state),TRIM((SALT39.StrType)le.licmail_zip),TRIM((SALT39.StrType)le.licresi_street1),TRIM((SALT39.StrType)le.licresi_street2),TRIM((SALT39.StrType)le.licresi_city),TRIM((SALT39.StrType)le.licresi_state),TRIM((SALT39.StrType)le.licresi_zip),TRIM((SALT39.StrType)le.issue_date_yyyymmdd),TRIM((SALT39.StrType)le.license_status),TRIM((SALT39.StrType)le.clean_status),TRIM((SALT39.StrType)le.process_date)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,26,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 26);
  SELF.FldNo2 := 1 + (C % 26);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.pers_surrogate),TRIM((SALT39.StrType)le.filler1),TRIM((SALT39.StrType)le.license_licno),TRIM((SALT39.StrType)le.filler2),TRIM((SALT39.StrType)le.license_bdate_yyyymmdd),TRIM((SALT39.StrType)le.license_edate_yyyymmdd),TRIM((SALT39.StrType)le.license_lic_class),TRIM((SALT39.StrType)le.license_height),TRIM((SALT39.StrType)le.license_sex),TRIM((SALT39.StrType)le.license_last_name),TRIM((SALT39.StrType)le.license_first_name),TRIM((SALT39.StrType)le.license_middle_name),TRIM((SALT39.StrType)le.licmail_street1),TRIM((SALT39.StrType)le.licmail_street2),TRIM((SALT39.StrType)le.licmail_city),TRIM((SALT39.StrType)le.licmail_state),TRIM((SALT39.StrType)le.licmail_zip),TRIM((SALT39.StrType)le.licresi_street1),TRIM((SALT39.StrType)le.licresi_street2),TRIM((SALT39.StrType)le.licresi_city),TRIM((SALT39.StrType)le.licresi_state),TRIM((SALT39.StrType)le.licresi_zip),TRIM((SALT39.StrType)le.issue_date_yyyymmdd),TRIM((SALT39.StrType)le.license_status),TRIM((SALT39.StrType)le.clean_status),TRIM((SALT39.StrType)le.process_date)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.pers_surrogate),TRIM((SALT39.StrType)le.filler1),TRIM((SALT39.StrType)le.license_licno),TRIM((SALT39.StrType)le.filler2),TRIM((SALT39.StrType)le.license_bdate_yyyymmdd),TRIM((SALT39.StrType)le.license_edate_yyyymmdd),TRIM((SALT39.StrType)le.license_lic_class),TRIM((SALT39.StrType)le.license_height),TRIM((SALT39.StrType)le.license_sex),TRIM((SALT39.StrType)le.license_last_name),TRIM((SALT39.StrType)le.license_first_name),TRIM((SALT39.StrType)le.license_middle_name),TRIM((SALT39.StrType)le.licmail_street1),TRIM((SALT39.StrType)le.licmail_street2),TRIM((SALT39.StrType)le.licmail_city),TRIM((SALT39.StrType)le.licmail_state),TRIM((SALT39.StrType)le.licmail_zip),TRIM((SALT39.StrType)le.licresi_street1),TRIM((SALT39.StrType)le.licresi_street2),TRIM((SALT39.StrType)le.licresi_city),TRIM((SALT39.StrType)le.licresi_state),TRIM((SALT39.StrType)le.licresi_zip),TRIM((SALT39.StrType)le.issue_date_yyyymmdd),TRIM((SALT39.StrType)le.license_status),TRIM((SALT39.StrType)le.clean_status),TRIM((SALT39.StrType)le.process_date)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),26*26,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'pers_surrogate'}
      ,{2,'filler1'}
      ,{3,'license_licno'}
      ,{4,'filler2'}
      ,{5,'license_bdate_yyyymmdd'}
      ,{6,'license_edate_yyyymmdd'}
      ,{7,'license_lic_class'}
      ,{8,'license_height'}
      ,{9,'license_sex'}
      ,{10,'license_last_name'}
      ,{11,'license_first_name'}
      ,{12,'license_middle_name'}
      ,{13,'licmail_street1'}
      ,{14,'licmail_street2'}
      ,{15,'licmail_city'}
      ,{16,'licmail_state'}
      ,{17,'licmail_zip'}
      ,{18,'licresi_street1'}
      ,{19,'licresi_street2'}
      ,{20,'licresi_city'}
      ,{21,'licresi_state'}
      ,{22,'licresi_zip'}
      ,{23,'issue_date_yyyymmdd'}
      ,{24,'license_status'}
      ,{25,'clean_status'}
      ,{26,'process_date'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_pers_surrogate((SALT39.StrType)le.pers_surrogate),
    Fields.InValid_filler1((SALT39.StrType)le.filler1),
    Fields.InValid_license_licno((SALT39.StrType)le.license_licno),
    Fields.InValid_filler2((SALT39.StrType)le.filler2),
    Fields.InValid_license_bdate_yyyymmdd((SALT39.StrType)le.license_bdate_yyyymmdd),
    Fields.InValid_license_edate_yyyymmdd((SALT39.StrType)le.license_edate_yyyymmdd),
    Fields.InValid_license_lic_class((SALT39.StrType)le.license_lic_class),
    Fields.InValid_license_height((SALT39.StrType)le.license_height),
    Fields.InValid_license_sex((SALT39.StrType)le.license_sex),
    Fields.InValid_license_last_name((SALT39.StrType)le.license_last_name,(SALT39.StrType)le.license_first_name,(SALT39.StrType)le.license_middle_name),
    Fields.InValid_license_first_name((SALT39.StrType)le.license_first_name),
    Fields.InValid_license_middle_name((SALT39.StrType)le.license_middle_name),
    Fields.InValid_licmail_street1((SALT39.StrType)le.licmail_street1),
    Fields.InValid_licmail_street2((SALT39.StrType)le.licmail_street2),
    Fields.InValid_licmail_city((SALT39.StrType)le.licmail_city),
    Fields.InValid_licmail_state((SALT39.StrType)le.licmail_state),
    Fields.InValid_licmail_zip((SALT39.StrType)le.licmail_zip,(SALT39.StrType)le.licmail_state),
    Fields.InValid_licresi_street1((SALT39.StrType)le.licresi_street1),
    Fields.InValid_licresi_street2((SALT39.StrType)le.licresi_street2),
    Fields.InValid_licresi_city((SALT39.StrType)le.licresi_city),
    Fields.InValid_licresi_state((SALT39.StrType)le.licresi_state),
    Fields.InValid_licresi_zip((SALT39.StrType)le.licresi_zip,(SALT39.StrType)le.licresi_state),
    Fields.InValid_issue_date_yyyymmdd((SALT39.StrType)le.issue_date_yyyymmdd),
    Fields.InValid_license_status((SALT39.StrType)le.license_status),
    Fields.InValid_clean_status((SALT39.StrType)le.clean_status),
    Fields.InValid_process_date((SALT39.StrType)le.process_date),
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
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_pers_surrogate','Unknown','invalid_license_licno','Unknown','invalid_8pastdate','invalid_8date','invalid_license_lic_class','invalid_license_height','invalid_license_sex','invalid_license_name','invalid_wordbag','invalid_wordbag','Unknown','Unknown','Unknown','invalid_licmail_state','invalid_mailzip','invalid_wordbag','invalid_wordbag','invalid_wordbag','invalid_licresi_state','invalid_resizip','invalid_08pastdate','invalid_license_status','Unknown','invalid_8pastdate');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_pers_surrogate(TotalErrors.ErrorNum),Fields.InValidMessage_filler1(TotalErrors.ErrorNum),Fields.InValidMessage_license_licno(TotalErrors.ErrorNum),Fields.InValidMessage_filler2(TotalErrors.ErrorNum),Fields.InValidMessage_license_bdate_yyyymmdd(TotalErrors.ErrorNum),Fields.InValidMessage_license_edate_yyyymmdd(TotalErrors.ErrorNum),Fields.InValidMessage_license_lic_class(TotalErrors.ErrorNum),Fields.InValidMessage_license_height(TotalErrors.ErrorNum),Fields.InValidMessage_license_sex(TotalErrors.ErrorNum),Fields.InValidMessage_license_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_license_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_license_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_licmail_street1(TotalErrors.ErrorNum),Fields.InValidMessage_licmail_street2(TotalErrors.ErrorNum),Fields.InValidMessage_licmail_city(TotalErrors.ErrorNum),Fields.InValidMessage_licmail_state(TotalErrors.ErrorNum),Fields.InValidMessage_licmail_zip(TotalErrors.ErrorNum),Fields.InValidMessage_licresi_street1(TotalErrors.ErrorNum),Fields.InValidMessage_licresi_street2(TotalErrors.ErrorNum),Fields.InValidMessage_licresi_city(TotalErrors.ErrorNum),Fields.InValidMessage_licresi_state(TotalErrors.ErrorNum),Fields.InValidMessage_licresi_zip(TotalErrors.ErrorNum),Fields.InValidMessage_issue_date_yyyymmdd(TotalErrors.ErrorNum),Fields.InValidMessage_license_status(TotalErrors.ErrorNum),Fields.InValidMessage_clean_status(TotalErrors.ErrorNum),Fields.InValidMessage_process_date(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DL_MA, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
