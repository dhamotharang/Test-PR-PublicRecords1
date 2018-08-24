IMPORT SALT38,STD;
EXPORT hygiene(dataset(layout_In_WY_MEDCERT) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_append_process_date_cnt := COUNT(GROUP,h.append_process_date <> (TYPEOF(h.append_process_date))'');
    populated_append_process_date_pcnt := AVE(GROUP,IF(h.append_process_date = (TYPEOF(h.append_process_date))'',0,100));
    maxlength_append_process_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.append_process_date)));
    avelength_append_process_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.append_process_date)),h.append_process_date<>(typeof(h.append_process_date))'');
    populated_orig_first_name_cnt := COUNT(GROUP,h.orig_first_name <> (TYPEOF(h.orig_first_name))'');
    populated_orig_first_name_pcnt := AVE(GROUP,IF(h.orig_first_name = (TYPEOF(h.orig_first_name))'',0,100));
    maxlength_orig_first_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_first_name)));
    avelength_orig_first_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_first_name)),h.orig_first_name<>(typeof(h.orig_first_name))'');
    populated_orig_middle_name_cnt := COUNT(GROUP,h.orig_middle_name <> (TYPEOF(h.orig_middle_name))'');
    populated_orig_middle_name_pcnt := AVE(GROUP,IF(h.orig_middle_name = (TYPEOF(h.orig_middle_name))'',0,100));
    maxlength_orig_middle_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_middle_name)));
    avelength_orig_middle_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_middle_name)),h.orig_middle_name<>(typeof(h.orig_middle_name))'');
    populated_orig_last_name_cnt := COUNT(GROUP,h.orig_last_name <> (TYPEOF(h.orig_last_name))'');
    populated_orig_last_name_pcnt := AVE(GROUP,IF(h.orig_last_name = (TYPEOF(h.orig_last_name))'',0,100));
    maxlength_orig_last_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_last_name)));
    avelength_orig_last_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_last_name)),h.orig_last_name<>(typeof(h.orig_last_name))'');
    populated_mailing_street_addr_1_cnt := COUNT(GROUP,h.mailing_street_addr_1 <> (TYPEOF(h.mailing_street_addr_1))'');
    populated_mailing_street_addr_1_pcnt := AVE(GROUP,IF(h.mailing_street_addr_1 = (TYPEOF(h.mailing_street_addr_1))'',0,100));
    maxlength_mailing_street_addr_1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mailing_street_addr_1)));
    avelength_mailing_street_addr_1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mailing_street_addr_1)),h.mailing_street_addr_1<>(typeof(h.mailing_street_addr_1))'');
    populated_mailing_city_1_cnt := COUNT(GROUP,h.mailing_city_1 <> (TYPEOF(h.mailing_city_1))'');
    populated_mailing_city_1_pcnt := AVE(GROUP,IF(h.mailing_city_1 = (TYPEOF(h.mailing_city_1))'',0,100));
    maxlength_mailing_city_1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mailing_city_1)));
    avelength_mailing_city_1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mailing_city_1)),h.mailing_city_1<>(typeof(h.mailing_city_1))'');
    populated_mailing_state_1_cnt := COUNT(GROUP,h.mailing_state_1 <> (TYPEOF(h.mailing_state_1))'');
    populated_mailing_state_1_pcnt := AVE(GROUP,IF(h.mailing_state_1 = (TYPEOF(h.mailing_state_1))'',0,100));
    maxlength_mailing_state_1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mailing_state_1)));
    avelength_mailing_state_1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mailing_state_1)),h.mailing_state_1<>(typeof(h.mailing_state_1))'');
    populated_mailing_zip_code_1_cnt := COUNT(GROUP,h.mailing_zip_code_1 <> (TYPEOF(h.mailing_zip_code_1))'');
    populated_mailing_zip_code_1_pcnt := AVE(GROUP,IF(h.mailing_zip_code_1 = (TYPEOF(h.mailing_zip_code_1))'',0,100));
    maxlength_mailing_zip_code_1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mailing_zip_code_1)));
    avelength_mailing_zip_code_1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mailing_zip_code_1)),h.mailing_zip_code_1<>(typeof(h.mailing_zip_code_1))'');
    populated_phys_street_addr_2_cnt := COUNT(GROUP,h.phys_street_addr_2 <> (TYPEOF(h.phys_street_addr_2))'');
    populated_phys_street_addr_2_pcnt := AVE(GROUP,IF(h.phys_street_addr_2 = (TYPEOF(h.phys_street_addr_2))'',0,100));
    maxlength_phys_street_addr_2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.phys_street_addr_2)));
    avelength_phys_street_addr_2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.phys_street_addr_2)),h.phys_street_addr_2<>(typeof(h.phys_street_addr_2))'');
    populated_phys_city_2_cnt := COUNT(GROUP,h.phys_city_2 <> (TYPEOF(h.phys_city_2))'');
    populated_phys_city_2_pcnt := AVE(GROUP,IF(h.phys_city_2 = (TYPEOF(h.phys_city_2))'',0,100));
    maxlength_phys_city_2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.phys_city_2)));
    avelength_phys_city_2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.phys_city_2)),h.phys_city_2<>(typeof(h.phys_city_2))'');
    populated_phys_state_2_cnt := COUNT(GROUP,h.phys_state_2 <> (TYPEOF(h.phys_state_2))'');
    populated_phys_state_2_pcnt := AVE(GROUP,IF(h.phys_state_2 = (TYPEOF(h.phys_state_2))'',0,100));
    maxlength_phys_state_2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.phys_state_2)));
    avelength_phys_state_2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.phys_state_2)),h.phys_state_2<>(typeof(h.phys_state_2))'');
    populated_phys_zip_code_2_cnt := COUNT(GROUP,h.phys_zip_code_2 <> (TYPEOF(h.phys_zip_code_2))'');
    populated_phys_zip_code_2_pcnt := AVE(GROUP,IF(h.phys_zip_code_2 = (TYPEOF(h.phys_zip_code_2))'',0,100));
    maxlength_phys_zip_code_2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.phys_zip_code_2)));
    avelength_phys_zip_code_2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.phys_zip_code_2)),h.phys_zip_code_2<>(typeof(h.phys_zip_code_2))'');
    populated_orig_dl_number_cnt := COUNT(GROUP,h.orig_dl_number <> (TYPEOF(h.orig_dl_number))'');
    populated_orig_dl_number_pcnt := AVE(GROUP,IF(h.orig_dl_number = (TYPEOF(h.orig_dl_number))'',0,100));
    maxlength_orig_dl_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dl_number)));
    avelength_orig_dl_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dl_number)),h.orig_dl_number<>(typeof(h.orig_dl_number))'');
    populated_orig_dob_cnt := COUNT(GROUP,h.orig_dob <> (TYPEOF(h.orig_dob))'');
    populated_orig_dob_pcnt := AVE(GROUP,IF(h.orig_dob = (TYPEOF(h.orig_dob))'',0,100));
    maxlength_orig_dob := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dob)));
    avelength_orig_dob := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dob)),h.orig_dob<>(typeof(h.orig_dob))'');
    populated_orig_code_1_cnt := COUNT(GROUP,h.orig_code_1 <> (TYPEOF(h.orig_code_1))'');
    populated_orig_code_1_pcnt := AVE(GROUP,IF(h.orig_code_1 = (TYPEOF(h.orig_code_1))'',0,100));
    maxlength_orig_code_1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_code_1)));
    avelength_orig_code_1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_code_1)),h.orig_code_1<>(typeof(h.orig_code_1))'');
    populated_orig_code_2_cnt := COUNT(GROUP,h.orig_code_2 <> (TYPEOF(h.orig_code_2))'');
    populated_orig_code_2_pcnt := AVE(GROUP,IF(h.orig_code_2 = (TYPEOF(h.orig_code_2))'',0,100));
    maxlength_orig_code_2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_code_2)));
    avelength_orig_code_2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_code_2)),h.orig_code_2<>(typeof(h.orig_code_2))'');
    populated_orig_code_3_cnt := COUNT(GROUP,h.orig_code_3 <> (TYPEOF(h.orig_code_3))'');
    populated_orig_code_3_pcnt := AVE(GROUP,IF(h.orig_code_3 = (TYPEOF(h.orig_code_3))'',0,100));
    maxlength_orig_code_3 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_code_3)));
    avelength_orig_code_3 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_code_3)),h.orig_code_3<>(typeof(h.orig_code_3))'');
    populated_orig_code_4_cnt := COUNT(GROUP,h.orig_code_4 <> (TYPEOF(h.orig_code_4))'');
    populated_orig_code_4_pcnt := AVE(GROUP,IF(h.orig_code_4 = (TYPEOF(h.orig_code_4))'',0,100));
    maxlength_orig_code_4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_code_4)));
    avelength_orig_code_4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_code_4)),h.orig_code_4<>(typeof(h.orig_code_4))'');
    populated_orig_code_5_cnt := COUNT(GROUP,h.orig_code_5 <> (TYPEOF(h.orig_code_5))'');
    populated_orig_code_5_pcnt := AVE(GROUP,IF(h.orig_code_5 = (TYPEOF(h.orig_code_5))'',0,100));
    maxlength_orig_code_5 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_code_5)));
    avelength_orig_code_5 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_code_5)),h.orig_code_5<>(typeof(h.orig_code_5))'');
    populated_orig_code_6_cnt := COUNT(GROUP,h.orig_code_6 <> (TYPEOF(h.orig_code_6))'');
    populated_orig_code_6_pcnt := AVE(GROUP,IF(h.orig_code_6 = (TYPEOF(h.orig_code_6))'',0,100));
    maxlength_orig_code_6 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_code_6)));
    avelength_orig_code_6 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_code_6)),h.orig_code_6<>(typeof(h.orig_code_6))'');
    populated_orig_code_7_cnt := COUNT(GROUP,h.orig_code_7 <> (TYPEOF(h.orig_code_7))'');
    populated_orig_code_7_pcnt := AVE(GROUP,IF(h.orig_code_7 = (TYPEOF(h.orig_code_7))'',0,100));
    maxlength_orig_code_7 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_code_7)));
    avelength_orig_code_7 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_code_7)),h.orig_code_7<>(typeof(h.orig_code_7))'');
    populated_orig_code_8_cnt := COUNT(GROUP,h.orig_code_8 <> (TYPEOF(h.orig_code_8))'');
    populated_orig_code_8_pcnt := AVE(GROUP,IF(h.orig_code_8 = (TYPEOF(h.orig_code_8))'',0,100));
    maxlength_orig_code_8 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_code_8)));
    avelength_orig_code_8 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_code_8)),h.orig_code_8<>(typeof(h.orig_code_8))'');
    populated_orig_issue_date_cnt := COUNT(GROUP,h.orig_issue_date <> (TYPEOF(h.orig_issue_date))'');
    populated_orig_issue_date_pcnt := AVE(GROUP,IF(h.orig_issue_date = (TYPEOF(h.orig_issue_date))'',0,100));
    maxlength_orig_issue_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_issue_date)));
    avelength_orig_issue_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_issue_date)),h.orig_issue_date<>(typeof(h.orig_issue_date))'');
    populated_orig_expire_date_cnt := COUNT(GROUP,h.orig_expire_date <> (TYPEOF(h.orig_expire_date))'');
    populated_orig_expire_date_pcnt := AVE(GROUP,IF(h.orig_expire_date = (TYPEOF(h.orig_expire_date))'',0,100));
    maxlength_orig_expire_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_expire_date)));
    avelength_orig_expire_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_expire_date)),h.orig_expire_date<>(typeof(h.orig_expire_date))'');
    populated_med_cert_status_cnt := COUNT(GROUP,h.med_cert_status <> (TYPEOF(h.med_cert_status))'');
    populated_med_cert_status_pcnt := AVE(GROUP,IF(h.med_cert_status = (TYPEOF(h.med_cert_status))'',0,100));
    maxlength_med_cert_status := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.med_cert_status)));
    avelength_med_cert_status := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.med_cert_status)),h.med_cert_status<>(typeof(h.med_cert_status))'');
    populated_med_cert_type_cnt := COUNT(GROUP,h.med_cert_type <> (TYPEOF(h.med_cert_type))'');
    populated_med_cert_type_pcnt := AVE(GROUP,IF(h.med_cert_type = (TYPEOF(h.med_cert_type))'',0,100));
    maxlength_med_cert_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.med_cert_type)));
    avelength_med_cert_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.med_cert_type)),h.med_cert_type<>(typeof(h.med_cert_type))'');
    populated_med_cert_expire_date_cnt := COUNT(GROUP,h.med_cert_expire_date <> (TYPEOF(h.med_cert_expire_date))'');
    populated_med_cert_expire_date_pcnt := AVE(GROUP,IF(h.med_cert_expire_date = (TYPEOF(h.med_cert_expire_date))'',0,100));
    maxlength_med_cert_expire_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.med_cert_expire_date)));
    avelength_med_cert_expire_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.med_cert_expire_date)),h.med_cert_expire_date<>(typeof(h.med_cert_expire_date))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_clean_name_prefix_cnt := COUNT(GROUP,h.clean_name_prefix <> (TYPEOF(h.clean_name_prefix))'');
    populated_clean_name_prefix_pcnt := AVE(GROUP,IF(h.clean_name_prefix = (TYPEOF(h.clean_name_prefix))'',0,100));
    maxlength_clean_name_prefix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_prefix)));
    avelength_clean_name_prefix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_prefix)),h.clean_name_prefix<>(typeof(h.clean_name_prefix))'');
    populated_clean_name_first_cnt := COUNT(GROUP,h.clean_name_first <> (TYPEOF(h.clean_name_first))'');
    populated_clean_name_first_pcnt := AVE(GROUP,IF(h.clean_name_first = (TYPEOF(h.clean_name_first))'',0,100));
    maxlength_clean_name_first := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_first)));
    avelength_clean_name_first := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_first)),h.clean_name_first<>(typeof(h.clean_name_first))'');
    populated_clean_name_middle_cnt := COUNT(GROUP,h.clean_name_middle <> (TYPEOF(h.clean_name_middle))'');
    populated_clean_name_middle_pcnt := AVE(GROUP,IF(h.clean_name_middle = (TYPEOF(h.clean_name_middle))'',0,100));
    maxlength_clean_name_middle := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_middle)));
    avelength_clean_name_middle := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_middle)),h.clean_name_middle<>(typeof(h.clean_name_middle))'');
    populated_clean_name_last_cnt := COUNT(GROUP,h.clean_name_last <> (TYPEOF(h.clean_name_last))'');
    populated_clean_name_last_pcnt := AVE(GROUP,IF(h.clean_name_last = (TYPEOF(h.clean_name_last))'',0,100));
    maxlength_clean_name_last := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_last)));
    avelength_clean_name_last := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_last)),h.clean_name_last<>(typeof(h.clean_name_last))'');
    populated_clean_name_suffix_cnt := COUNT(GROUP,h.clean_name_suffix <> (TYPEOF(h.clean_name_suffix))'');
    populated_clean_name_suffix_pcnt := AVE(GROUP,IF(h.clean_name_suffix = (TYPEOF(h.clean_name_suffix))'',0,100));
    maxlength_clean_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_suffix)));
    avelength_clean_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_suffix)),h.clean_name_suffix<>(typeof(h.clean_name_suffix))'');
    populated_clean_name_score_cnt := COUNT(GROUP,h.clean_name_score <> (TYPEOF(h.clean_name_score))'');
    populated_clean_name_score_pcnt := AVE(GROUP,IF(h.clean_name_score = (TYPEOF(h.clean_name_score))'',0,100));
    maxlength_clean_name_score := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_score)));
    avelength_clean_name_score := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_score)),h.clean_name_score<>(typeof(h.clean_name_score))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_append_process_date_pcnt *   0.00 / 100 + T.Populated_orig_first_name_pcnt *   0.00 / 100 + T.Populated_orig_middle_name_pcnt *   0.00 / 100 + T.Populated_orig_last_name_pcnt *   0.00 / 100 + T.Populated_mailing_street_addr_1_pcnt *   0.00 / 100 + T.Populated_mailing_city_1_pcnt *   0.00 / 100 + T.Populated_mailing_state_1_pcnt *   0.00 / 100 + T.Populated_mailing_zip_code_1_pcnt *   0.00 / 100 + T.Populated_phys_street_addr_2_pcnt *   0.00 / 100 + T.Populated_phys_city_2_pcnt *   0.00 / 100 + T.Populated_phys_state_2_pcnt *   0.00 / 100 + T.Populated_phys_zip_code_2_pcnt *   0.00 / 100 + T.Populated_orig_dl_number_pcnt *   0.00 / 100 + T.Populated_orig_dob_pcnt *   0.00 / 100 + T.Populated_orig_code_1_pcnt *   0.00 / 100 + T.Populated_orig_code_2_pcnt *   0.00 / 100 + T.Populated_orig_code_3_pcnt *   0.00 / 100 + T.Populated_orig_code_4_pcnt *   0.00 / 100 + T.Populated_orig_code_5_pcnt *   0.00 / 100 + T.Populated_orig_code_6_pcnt *   0.00 / 100 + T.Populated_orig_code_7_pcnt *   0.00 / 100 + T.Populated_orig_code_8_pcnt *   0.00 / 100 + T.Populated_orig_issue_date_pcnt *   0.00 / 100 + T.Populated_orig_expire_date_pcnt *   0.00 / 100 + T.Populated_med_cert_status_pcnt *   0.00 / 100 + T.Populated_med_cert_type_pcnt *   0.00 / 100 + T.Populated_med_cert_expire_date_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_clean_name_prefix_pcnt *   0.00 / 100 + T.Populated_clean_name_first_pcnt *   0.00 / 100 + T.Populated_clean_name_middle_pcnt *   0.00 / 100 + T.Populated_clean_name_last_pcnt *   0.00 / 100 + T.Populated_clean_name_suffix_pcnt *   0.00 / 100 + T.Populated_clean_name_score_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT38.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'append_process_date','orig_first_name','orig_middle_name','orig_last_name','mailing_street_addr_1','mailing_city_1','mailing_state_1','mailing_zip_code_1','phys_street_addr_2','phys_city_2','phys_state_2','phys_zip_code_2','orig_dl_number','orig_dob','orig_code_1','orig_code_2','orig_code_3','orig_code_4','orig_code_5','orig_code_6','orig_code_7','orig_code_8','orig_issue_date','orig_expire_date','med_cert_status','med_cert_type','med_cert_expire_date','name_suffix','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score');
  SELF.populated_pcnt := CHOOSE(C,le.populated_append_process_date_pcnt,le.populated_orig_first_name_pcnt,le.populated_orig_middle_name_pcnt,le.populated_orig_last_name_pcnt,le.populated_mailing_street_addr_1_pcnt,le.populated_mailing_city_1_pcnt,le.populated_mailing_state_1_pcnt,le.populated_mailing_zip_code_1_pcnt,le.populated_phys_street_addr_2_pcnt,le.populated_phys_city_2_pcnt,le.populated_phys_state_2_pcnt,le.populated_phys_zip_code_2_pcnt,le.populated_orig_dl_number_pcnt,le.populated_orig_dob_pcnt,le.populated_orig_code_1_pcnt,le.populated_orig_code_2_pcnt,le.populated_orig_code_3_pcnt,le.populated_orig_code_4_pcnt,le.populated_orig_code_5_pcnt,le.populated_orig_code_6_pcnt,le.populated_orig_code_7_pcnt,le.populated_orig_code_8_pcnt,le.populated_orig_issue_date_pcnt,le.populated_orig_expire_date_pcnt,le.populated_med_cert_status_pcnt,le.populated_med_cert_type_pcnt,le.populated_med_cert_expire_date_pcnt,le.populated_name_suffix_pcnt,le.populated_clean_name_prefix_pcnt,le.populated_clean_name_first_pcnt,le.populated_clean_name_middle_pcnt,le.populated_clean_name_last_pcnt,le.populated_clean_name_suffix_pcnt,le.populated_clean_name_score_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_append_process_date,le.maxlength_orig_first_name,le.maxlength_orig_middle_name,le.maxlength_orig_last_name,le.maxlength_mailing_street_addr_1,le.maxlength_mailing_city_1,le.maxlength_mailing_state_1,le.maxlength_mailing_zip_code_1,le.maxlength_phys_street_addr_2,le.maxlength_phys_city_2,le.maxlength_phys_state_2,le.maxlength_phys_zip_code_2,le.maxlength_orig_dl_number,le.maxlength_orig_dob,le.maxlength_orig_code_1,le.maxlength_orig_code_2,le.maxlength_orig_code_3,le.maxlength_orig_code_4,le.maxlength_orig_code_5,le.maxlength_orig_code_6,le.maxlength_orig_code_7,le.maxlength_orig_code_8,le.maxlength_orig_issue_date,le.maxlength_orig_expire_date,le.maxlength_med_cert_status,le.maxlength_med_cert_type,le.maxlength_med_cert_expire_date,le.maxlength_name_suffix,le.maxlength_clean_name_prefix,le.maxlength_clean_name_first,le.maxlength_clean_name_middle,le.maxlength_clean_name_last,le.maxlength_clean_name_suffix,le.maxlength_clean_name_score);
  SELF.avelength := CHOOSE(C,le.avelength_append_process_date,le.avelength_orig_first_name,le.avelength_orig_middle_name,le.avelength_orig_last_name,le.avelength_mailing_street_addr_1,le.avelength_mailing_city_1,le.avelength_mailing_state_1,le.avelength_mailing_zip_code_1,le.avelength_phys_street_addr_2,le.avelength_phys_city_2,le.avelength_phys_state_2,le.avelength_phys_zip_code_2,le.avelength_orig_dl_number,le.avelength_orig_dob,le.avelength_orig_code_1,le.avelength_orig_code_2,le.avelength_orig_code_3,le.avelength_orig_code_4,le.avelength_orig_code_5,le.avelength_orig_code_6,le.avelength_orig_code_7,le.avelength_orig_code_8,le.avelength_orig_issue_date,le.avelength_orig_expire_date,le.avelength_med_cert_status,le.avelength_med_cert_type,le.avelength_med_cert_expire_date,le.avelength_name_suffix,le.avelength_clean_name_prefix,le.avelength_clean_name_first,le.avelength_clean_name_middle,le.avelength_clean_name_last,le.avelength_clean_name_suffix,le.avelength_clean_name_score);
END;
EXPORT invSummary := NORMALIZE(summary0, 34, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.append_process_date),TRIM((SALT38.StrType)le.orig_first_name),TRIM((SALT38.StrType)le.orig_middle_name),TRIM((SALT38.StrType)le.orig_last_name),TRIM((SALT38.StrType)le.mailing_street_addr_1),TRIM((SALT38.StrType)le.mailing_city_1),TRIM((SALT38.StrType)le.mailing_state_1),TRIM((SALT38.StrType)le.mailing_zip_code_1),TRIM((SALT38.StrType)le.phys_street_addr_2),TRIM((SALT38.StrType)le.phys_city_2),TRIM((SALT38.StrType)le.phys_state_2),TRIM((SALT38.StrType)le.phys_zip_code_2),TRIM((SALT38.StrType)le.orig_dl_number),TRIM((SALT38.StrType)le.orig_dob),TRIM((SALT38.StrType)le.orig_code_1),TRIM((SALT38.StrType)le.orig_code_2),TRIM((SALT38.StrType)le.orig_code_3),TRIM((SALT38.StrType)le.orig_code_4),TRIM((SALT38.StrType)le.orig_code_5),TRIM((SALT38.StrType)le.orig_code_6),TRIM((SALT38.StrType)le.orig_code_7),TRIM((SALT38.StrType)le.orig_code_8),TRIM((SALT38.StrType)le.orig_issue_date),TRIM((SALT38.StrType)le.orig_expire_date),TRIM((SALT38.StrType)le.med_cert_status),TRIM((SALT38.StrType)le.med_cert_type),TRIM((SALT38.StrType)le.med_cert_expire_date),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.clean_name_prefix),TRIM((SALT38.StrType)le.clean_name_first),TRIM((SALT38.StrType)le.clean_name_middle),TRIM((SALT38.StrType)le.clean_name_last),TRIM((SALT38.StrType)le.clean_name_suffix),TRIM((SALT38.StrType)le.clean_name_score)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,34,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 34);
  SELF.FldNo2 := 1 + (C % 34);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.append_process_date),TRIM((SALT38.StrType)le.orig_first_name),TRIM((SALT38.StrType)le.orig_middle_name),TRIM((SALT38.StrType)le.orig_last_name),TRIM((SALT38.StrType)le.mailing_street_addr_1),TRIM((SALT38.StrType)le.mailing_city_1),TRIM((SALT38.StrType)le.mailing_state_1),TRIM((SALT38.StrType)le.mailing_zip_code_1),TRIM((SALT38.StrType)le.phys_street_addr_2),TRIM((SALT38.StrType)le.phys_city_2),TRIM((SALT38.StrType)le.phys_state_2),TRIM((SALT38.StrType)le.phys_zip_code_2),TRIM((SALT38.StrType)le.orig_dl_number),TRIM((SALT38.StrType)le.orig_dob),TRIM((SALT38.StrType)le.orig_code_1),TRIM((SALT38.StrType)le.orig_code_2),TRIM((SALT38.StrType)le.orig_code_3),TRIM((SALT38.StrType)le.orig_code_4),TRIM((SALT38.StrType)le.orig_code_5),TRIM((SALT38.StrType)le.orig_code_6),TRIM((SALT38.StrType)le.orig_code_7),TRIM((SALT38.StrType)le.orig_code_8),TRIM((SALT38.StrType)le.orig_issue_date),TRIM((SALT38.StrType)le.orig_expire_date),TRIM((SALT38.StrType)le.med_cert_status),TRIM((SALT38.StrType)le.med_cert_type),TRIM((SALT38.StrType)le.med_cert_expire_date),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.clean_name_prefix),TRIM((SALT38.StrType)le.clean_name_first),TRIM((SALT38.StrType)le.clean_name_middle),TRIM((SALT38.StrType)le.clean_name_last),TRIM((SALT38.StrType)le.clean_name_suffix),TRIM((SALT38.StrType)le.clean_name_score)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.append_process_date),TRIM((SALT38.StrType)le.orig_first_name),TRIM((SALT38.StrType)le.orig_middle_name),TRIM((SALT38.StrType)le.orig_last_name),TRIM((SALT38.StrType)le.mailing_street_addr_1),TRIM((SALT38.StrType)le.mailing_city_1),TRIM((SALT38.StrType)le.mailing_state_1),TRIM((SALT38.StrType)le.mailing_zip_code_1),TRIM((SALT38.StrType)le.phys_street_addr_2),TRIM((SALT38.StrType)le.phys_city_2),TRIM((SALT38.StrType)le.phys_state_2),TRIM((SALT38.StrType)le.phys_zip_code_2),TRIM((SALT38.StrType)le.orig_dl_number),TRIM((SALT38.StrType)le.orig_dob),TRIM((SALT38.StrType)le.orig_code_1),TRIM((SALT38.StrType)le.orig_code_2),TRIM((SALT38.StrType)le.orig_code_3),TRIM((SALT38.StrType)le.orig_code_4),TRIM((SALT38.StrType)le.orig_code_5),TRIM((SALT38.StrType)le.orig_code_6),TRIM((SALT38.StrType)le.orig_code_7),TRIM((SALT38.StrType)le.orig_code_8),TRIM((SALT38.StrType)le.orig_issue_date),TRIM((SALT38.StrType)le.orig_expire_date),TRIM((SALT38.StrType)le.med_cert_status),TRIM((SALT38.StrType)le.med_cert_type),TRIM((SALT38.StrType)le.med_cert_expire_date),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.clean_name_prefix),TRIM((SALT38.StrType)le.clean_name_first),TRIM((SALT38.StrType)le.clean_name_middle),TRIM((SALT38.StrType)le.clean_name_last),TRIM((SALT38.StrType)le.clean_name_suffix),TRIM((SALT38.StrType)le.clean_name_score)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),34*34,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'append_process_date'}
      ,{2,'orig_first_name'}
      ,{3,'orig_middle_name'}
      ,{4,'orig_last_name'}
      ,{5,'mailing_street_addr_1'}
      ,{6,'mailing_city_1'}
      ,{7,'mailing_state_1'}
      ,{8,'mailing_zip_code_1'}
      ,{9,'phys_street_addr_2'}
      ,{10,'phys_city_2'}
      ,{11,'phys_state_2'}
      ,{12,'phys_zip_code_2'}
      ,{13,'orig_dl_number'}
      ,{14,'orig_dob'}
      ,{15,'orig_code_1'}
      ,{16,'orig_code_2'}
      ,{17,'orig_code_3'}
      ,{18,'orig_code_4'}
      ,{19,'orig_code_5'}
      ,{20,'orig_code_6'}
      ,{21,'orig_code_7'}
      ,{22,'orig_code_8'}
      ,{23,'orig_issue_date'}
      ,{24,'orig_expire_date'}
      ,{25,'med_cert_status'}
      ,{26,'med_cert_type'}
      ,{27,'med_cert_expire_date'}
      ,{28,'name_suffix'}
      ,{29,'clean_name_prefix'}
      ,{30,'clean_name_first'}
      ,{31,'clean_name_middle'}
      ,{32,'clean_name_last'}
      ,{33,'clean_name_suffix'}
      ,{34,'clean_name_score'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_append_process_date((SALT38.StrType)le.append_process_date),
    Fields.InValid_orig_first_name((SALT38.StrType)le.orig_first_name,(SALT38.StrType)le.orig_middle_name,(SALT38.StrType)le.orig_last_name),
    Fields.InValid_orig_middle_name((SALT38.StrType)le.orig_middle_name),
    Fields.InValid_orig_last_name((SALT38.StrType)le.orig_last_name),
    Fields.InValid_mailing_street_addr_1((SALT38.StrType)le.mailing_street_addr_1),
    Fields.InValid_mailing_city_1((SALT38.StrType)le.mailing_city_1),
    Fields.InValid_mailing_state_1((SALT38.StrType)le.mailing_state_1),
    Fields.InValid_mailing_zip_code_1((SALT38.StrType)le.mailing_zip_code_1),
    Fields.InValid_phys_street_addr_2((SALT38.StrType)le.phys_street_addr_2),
    Fields.InValid_phys_city_2((SALT38.StrType)le.phys_city_2),
    Fields.InValid_phys_state_2((SALT38.StrType)le.phys_state_2),
    Fields.InValid_phys_zip_code_2((SALT38.StrType)le.phys_zip_code_2),
    Fields.InValid_orig_dl_number((SALT38.StrType)le.orig_dl_number),
    Fields.InValid_orig_dob((SALT38.StrType)le.orig_dob),
    Fields.InValid_orig_code_1((SALT38.StrType)le.orig_code_1),
    Fields.InValid_orig_code_2((SALT38.StrType)le.orig_code_2),
    Fields.InValid_orig_code_3((SALT38.StrType)le.orig_code_3),
    Fields.InValid_orig_code_4((SALT38.StrType)le.orig_code_4),
    Fields.InValid_orig_code_5((SALT38.StrType)le.orig_code_5),
    Fields.InValid_orig_code_6((SALT38.StrType)le.orig_code_6),
    Fields.InValid_orig_code_7((SALT38.StrType)le.orig_code_7),
    Fields.InValid_orig_code_8((SALT38.StrType)le.orig_code_8),
    Fields.InValid_orig_issue_date((SALT38.StrType)le.orig_issue_date),
    Fields.InValid_orig_expire_date((SALT38.StrType)le.orig_expire_date),
    Fields.InValid_med_cert_status((SALT38.StrType)le.med_cert_status),
    Fields.InValid_med_cert_type((SALT38.StrType)le.med_cert_type),
    Fields.InValid_med_cert_expire_date((SALT38.StrType)le.med_cert_expire_date),
    Fields.InValid_name_suffix((SALT38.StrType)le.name_suffix),
    Fields.InValid_clean_name_prefix((SALT38.StrType)le.clean_name_prefix),
    Fields.InValid_clean_name_first((SALT38.StrType)le.clean_name_first,(SALT38.StrType)le.clean_name_middle,(SALT38.StrType)le.clean_name_last),
    Fields.InValid_clean_name_middle((SALT38.StrType)le.clean_name_middle),
    Fields.InValid_clean_name_last((SALT38.StrType)le.clean_name_last),
    Fields.InValid_clean_name_suffix((SALT38.StrType)le.clean_name_suffix),
    Fields.InValid_clean_name_score((SALT38.StrType)le.clean_name_score),
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
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_Past_Date','invalid_orig_name','Unknown','Unknown','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip5','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip5','invalid_numeric','invalid_Past_Date','invalid_orig_code','invalid_orig_code','invalid_orig_code','invalid_orig_code','invalid_orig_code','invalid_orig_code','invalid_orig_code','invalid_orig_code','invalid_Past_Date','invalid_General_Date','invalid_med_cert_status','invalid_med_cert_type','invalid_General_Date','Unknown','Unknown','invalid_clean_name','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_append_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_street_addr_1(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_city_1(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_state_1(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_zip_code_1(TotalErrors.ErrorNum),Fields.InValidMessage_phys_street_addr_2(TotalErrors.ErrorNum),Fields.InValidMessage_phys_city_2(TotalErrors.ErrorNum),Fields.InValidMessage_phys_state_2(TotalErrors.ErrorNum),Fields.InValidMessage_phys_zip_code_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dl_number(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_code_1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_code_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_code_3(TotalErrors.ErrorNum),Fields.InValidMessage_orig_code_4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_code_5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_code_6(TotalErrors.ErrorNum),Fields.InValidMessage_orig_code_7(TotalErrors.ErrorNum),Fields.InValidMessage_orig_code_8(TotalErrors.ErrorNum),Fields.InValidMessage_orig_issue_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_expire_date(TotalErrors.ErrorNum),Fields.InValidMessage_med_cert_status(TotalErrors.ErrorNum),Fields.InValidMessage_med_cert_type(TotalErrors.ErrorNum),Fields.InValidMessage_med_cert_expire_date(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_prefix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_first(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_middle(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_last(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_score(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DL_WY_MEDCERT, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
