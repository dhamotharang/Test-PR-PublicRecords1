IMPORT SALT38,STD;
EXPORT raw_file_hygiene(dataset(raw_file_layout_Certegy) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dl_state_cnt := COUNT(GROUP,h.dl_state <> (TYPEOF(h.dl_state))'');
    populated_dl_state_pcnt := AVE(GROUP,IF(h.dl_state = (TYPEOF(h.dl_state))'',0,100));
    maxlength_dl_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dl_state)));
    avelength_dl_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dl_state)),h.dl_state<>(typeof(h.dl_state))'');
    populated_dl_num_cnt := COUNT(GROUP,h.dl_num <> (TYPEOF(h.dl_num))'');
    populated_dl_num_pcnt := AVE(GROUP,IF(h.dl_num = (TYPEOF(h.dl_num))'',0,100));
    maxlength_dl_num := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dl_num)));
    avelength_dl_num := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dl_num)),h.dl_num<>(typeof(h.dl_num))'');
    populated_ssn_cnt := COUNT(GROUP,h.ssn <> (TYPEOF(h.ssn))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_dl_issue_dte_cnt := COUNT(GROUP,h.dl_issue_dte <> (TYPEOF(h.dl_issue_dte))'');
    populated_dl_issue_dte_pcnt := AVE(GROUP,IF(h.dl_issue_dte = (TYPEOF(h.dl_issue_dte))'',0,100));
    maxlength_dl_issue_dte := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dl_issue_dte)));
    avelength_dl_issue_dte := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dl_issue_dte)),h.dl_issue_dte<>(typeof(h.dl_issue_dte))'');
    populated_dl_expire_dte_cnt := COUNT(GROUP,h.dl_expire_dte <> (TYPEOF(h.dl_expire_dte))'');
    populated_dl_expire_dte_pcnt := AVE(GROUP,IF(h.dl_expire_dte = (TYPEOF(h.dl_expire_dte))'',0,100));
    maxlength_dl_expire_dte := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dl_expire_dte)));
    avelength_dl_expire_dte := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dl_expire_dte)),h.dl_expire_dte<>(typeof(h.dl_expire_dte))'');
    populated_house_bldg_num_cnt := COUNT(GROUP,h.house_bldg_num <> (TYPEOF(h.house_bldg_num))'');
    populated_house_bldg_num_pcnt := AVE(GROUP,IF(h.house_bldg_num = (TYPEOF(h.house_bldg_num))'',0,100));
    maxlength_house_bldg_num := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.house_bldg_num)));
    avelength_house_bldg_num := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.house_bldg_num)),h.house_bldg_num<>(typeof(h.house_bldg_num))'');
    populated_street_suffix_cnt := COUNT(GROUP,h.street_suffix <> (TYPEOF(h.street_suffix))'');
    populated_street_suffix_pcnt := AVE(GROUP,IF(h.street_suffix = (TYPEOF(h.street_suffix))'',0,100));
    maxlength_street_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.street_suffix)));
    avelength_street_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.street_suffix)),h.street_suffix<>(typeof(h.street_suffix))'');
    populated_apt_num_cnt := COUNT(GROUP,h.apt_num <> (TYPEOF(h.apt_num))'');
    populated_apt_num_pcnt := AVE(GROUP,IF(h.apt_num = (TYPEOF(h.apt_num))'',0,100));
    maxlength_apt_num := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.apt_num)));
    avelength_apt_num := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.apt_num)),h.apt_num<>(typeof(h.apt_num))'');
    populated_unit_desc_cnt := COUNT(GROUP,h.unit_desc <> (TYPEOF(h.unit_desc))'');
    populated_unit_desc_pcnt := AVE(GROUP,IF(h.unit_desc = (TYPEOF(h.unit_desc))'',0,100));
    maxlength_unit_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_desc)));
    avelength_unit_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_desc)),h.unit_desc<>(typeof(h.unit_desc))'');
    populated_street_post_dir_cnt := COUNT(GROUP,h.street_post_dir <> (TYPEOF(h.street_post_dir))'');
    populated_street_post_dir_pcnt := AVE(GROUP,IF(h.street_post_dir = (TYPEOF(h.street_post_dir))'',0,100));
    maxlength_street_post_dir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.street_post_dir)));
    avelength_street_post_dir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.street_post_dir)),h.street_post_dir<>(typeof(h.street_post_dir))'');
    populated_street_pre_dir_cnt := COUNT(GROUP,h.street_pre_dir <> (TYPEOF(h.street_pre_dir))'');
    populated_street_pre_dir_pcnt := AVE(GROUP,IF(h.street_pre_dir = (TYPEOF(h.street_pre_dir))'',0,100));
    maxlength_street_pre_dir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.street_pre_dir)));
    avelength_street_pre_dir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.street_pre_dir)),h.street_pre_dir<>(typeof(h.street_pre_dir))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_deceased_dte_cnt := COUNT(GROUP,h.deceased_dte <> (TYPEOF(h.deceased_dte))'');
    populated_deceased_dte_pcnt := AVE(GROUP,IF(h.deceased_dte = (TYPEOF(h.deceased_dte))'',0,100));
    maxlength_deceased_dte := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.deceased_dte)));
    avelength_deceased_dte := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.deceased_dte)),h.deceased_dte<>(typeof(h.deceased_dte))'');
    populated_home_tel_area_cnt := COUNT(GROUP,h.home_tel_area <> (TYPEOF(h.home_tel_area))'');
    populated_home_tel_area_pcnt := AVE(GROUP,IF(h.home_tel_area = (TYPEOF(h.home_tel_area))'',0,100));
    maxlength_home_tel_area := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.home_tel_area)));
    avelength_home_tel_area := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.home_tel_area)),h.home_tel_area<>(typeof(h.home_tel_area))'');
    populated_home_tel_num_cnt := COUNT(GROUP,h.home_tel_num <> (TYPEOF(h.home_tel_num))'');
    populated_home_tel_num_pcnt := AVE(GROUP,IF(h.home_tel_num = (TYPEOF(h.home_tel_num))'',0,100));
    maxlength_home_tel_num := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.home_tel_num)));
    avelength_home_tel_num := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.home_tel_num)),h.home_tel_num<>(typeof(h.home_tel_num))'');
    populated_work_tel_area_cnt := COUNT(GROUP,h.work_tel_area <> (TYPEOF(h.work_tel_area))'');
    populated_work_tel_area_pcnt := AVE(GROUP,IF(h.work_tel_area = (TYPEOF(h.work_tel_area))'',0,100));
    maxlength_work_tel_area := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.work_tel_area)));
    avelength_work_tel_area := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.work_tel_area)),h.work_tel_area<>(typeof(h.work_tel_area))'');
    populated_work_tel_num_cnt := COUNT(GROUP,h.work_tel_num <> (TYPEOF(h.work_tel_num))'');
    populated_work_tel_num_pcnt := AVE(GROUP,IF(h.work_tel_num = (TYPEOF(h.work_tel_num))'',0,100));
    maxlength_work_tel_num := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.work_tel_num)));
    avelength_work_tel_num := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.work_tel_num)),h.work_tel_num<>(typeof(h.work_tel_num))'');
    populated_work_tel_ext_cnt := COUNT(GROUP,h.work_tel_ext <> (TYPEOF(h.work_tel_ext))'');
    populated_work_tel_ext_pcnt := AVE(GROUP,IF(h.work_tel_ext = (TYPEOF(h.work_tel_ext))'',0,100));
    maxlength_work_tel_ext := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.work_tel_ext)));
    avelength_work_tel_ext := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.work_tel_ext)),h.work_tel_ext<>(typeof(h.work_tel_ext))'');
    populated_upd_dte_time_cnt := COUNT(GROUP,h.upd_dte_time <> (TYPEOF(h.upd_dte_time))'');
    populated_upd_dte_time_pcnt := AVE(GROUP,IF(h.upd_dte_time = (TYPEOF(h.upd_dte_time))'',0,100));
    maxlength_upd_dte_time := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.upd_dte_time)));
    avelength_upd_dte_time := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.upd_dte_time)),h.upd_dte_time<>(typeof(h.upd_dte_time))'');
    populated_first_name_cnt := COUNT(GROUP,h.first_name <> (TYPEOF(h.first_name))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_mid_name_cnt := COUNT(GROUP,h.mid_name <> (TYPEOF(h.mid_name))'');
    populated_mid_name_pcnt := AVE(GROUP,IF(h.mid_name = (TYPEOF(h.mid_name))'',0,100));
    maxlength_mid_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mid_name)));
    avelength_mid_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mid_name)),h.mid_name<>(typeof(h.mid_name))'');
    populated_last_name_cnt := COUNT(GROUP,h.last_name <> (TYPEOF(h.last_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_gen_delivery_cnt := COUNT(GROUP,h.gen_delivery <> (TYPEOF(h.gen_delivery))'');
    populated_gen_delivery_pcnt := AVE(GROUP,IF(h.gen_delivery = (TYPEOF(h.gen_delivery))'',0,100));
    maxlength_gen_delivery := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.gen_delivery)));
    avelength_gen_delivery := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.gen_delivery)),h.gen_delivery<>(typeof(h.gen_delivery))'');
    populated_street_name_cnt := COUNT(GROUP,h.street_name <> (TYPEOF(h.street_name))'');
    populated_street_name_pcnt := AVE(GROUP,IF(h.street_name = (TYPEOF(h.street_name))'',0,100));
    maxlength_street_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.street_name)));
    avelength_street_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.street_name)),h.street_name<>(typeof(h.street_name))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_foreign_cntry_cnt := COUNT(GROUP,h.foreign_cntry <> (TYPEOF(h.foreign_cntry))'');
    populated_foreign_cntry_pcnt := AVE(GROUP,IF(h.foreign_cntry = (TYPEOF(h.foreign_cntry))'',0,100));
    maxlength_foreign_cntry := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.foreign_cntry)));
    avelength_foreign_cntry := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.foreign_cntry)),h.foreign_cntry<>(typeof(h.foreign_cntry))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dl_state_pcnt *   0.00 / 100 + T.Populated_dl_num_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_dl_issue_dte_pcnt *   0.00 / 100 + T.Populated_dl_expire_dte_pcnt *   0.00 / 100 + T.Populated_house_bldg_num_pcnt *   0.00 / 100 + T.Populated_street_suffix_pcnt *   0.00 / 100 + T.Populated_apt_num_pcnt *   0.00 / 100 + T.Populated_unit_desc_pcnt *   0.00 / 100 + T.Populated_street_post_dir_pcnt *   0.00 / 100 + T.Populated_street_pre_dir_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_deceased_dte_pcnt *   0.00 / 100 + T.Populated_home_tel_area_pcnt *   0.00 / 100 + T.Populated_home_tel_num_pcnt *   0.00 / 100 + T.Populated_work_tel_area_pcnt *   0.00 / 100 + T.Populated_work_tel_num_pcnt *   0.00 / 100 + T.Populated_work_tel_ext_pcnt *   0.00 / 100 + T.Populated_upd_dte_time_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_mid_name_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_gen_delivery_pcnt *   0.00 / 100 + T.Populated_street_name_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_foreign_cntry_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dl_state','dl_num','ssn','dl_issue_dte','dl_expire_dte','house_bldg_num','street_suffix','apt_num','unit_desc','street_post_dir','street_pre_dir','state','zip','zip4','dob','deceased_dte','home_tel_area','home_tel_num','work_tel_area','work_tel_num','work_tel_ext','upd_dte_time','first_name','mid_name','last_name','gen_delivery','street_name','city','foreign_cntry');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dl_state_pcnt,le.populated_dl_num_pcnt,le.populated_ssn_pcnt,le.populated_dl_issue_dte_pcnt,le.populated_dl_expire_dte_pcnt,le.populated_house_bldg_num_pcnt,le.populated_street_suffix_pcnt,le.populated_apt_num_pcnt,le.populated_unit_desc_pcnt,le.populated_street_post_dir_pcnt,le.populated_street_pre_dir_pcnt,le.populated_state_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_dob_pcnt,le.populated_deceased_dte_pcnt,le.populated_home_tel_area_pcnt,le.populated_home_tel_num_pcnt,le.populated_work_tel_area_pcnt,le.populated_work_tel_num_pcnt,le.populated_work_tel_ext_pcnt,le.populated_upd_dte_time_pcnt,le.populated_first_name_pcnt,le.populated_mid_name_pcnt,le.populated_last_name_pcnt,le.populated_gen_delivery_pcnt,le.populated_street_name_pcnt,le.populated_city_pcnt,le.populated_foreign_cntry_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dl_state,le.maxlength_dl_num,le.maxlength_ssn,le.maxlength_dl_issue_dte,le.maxlength_dl_expire_dte,le.maxlength_house_bldg_num,le.maxlength_street_suffix,le.maxlength_apt_num,le.maxlength_unit_desc,le.maxlength_street_post_dir,le.maxlength_street_pre_dir,le.maxlength_state,le.maxlength_zip,le.maxlength_zip4,le.maxlength_dob,le.maxlength_deceased_dte,le.maxlength_home_tel_area,le.maxlength_home_tel_num,le.maxlength_work_tel_area,le.maxlength_work_tel_num,le.maxlength_work_tel_ext,le.maxlength_upd_dte_time,le.maxlength_first_name,le.maxlength_mid_name,le.maxlength_last_name,le.maxlength_gen_delivery,le.maxlength_street_name,le.maxlength_city,le.maxlength_foreign_cntry);
  SELF.avelength := CHOOSE(C,le.avelength_dl_state,le.avelength_dl_num,le.avelength_ssn,le.avelength_dl_issue_dte,le.avelength_dl_expire_dte,le.avelength_house_bldg_num,le.avelength_street_suffix,le.avelength_apt_num,le.avelength_unit_desc,le.avelength_street_post_dir,le.avelength_street_pre_dir,le.avelength_state,le.avelength_zip,le.avelength_zip4,le.avelength_dob,le.avelength_deceased_dte,le.avelength_home_tel_area,le.avelength_home_tel_num,le.avelength_work_tel_area,le.avelength_work_tel_num,le.avelength_work_tel_ext,le.avelength_upd_dte_time,le.avelength_first_name,le.avelength_mid_name,le.avelength_last_name,le.avelength_gen_delivery,le.avelength_street_name,le.avelength_city,le.avelength_foreign_cntry);
END;
EXPORT invSummary := NORMALIZE(summary0, 29, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.dl_state),TRIM((SALT38.StrType)le.dl_num),TRIM((SALT38.StrType)le.ssn),TRIM((SALT38.StrType)le.dl_issue_dte),TRIM((SALT38.StrType)le.dl_expire_dte),TRIM((SALT38.StrType)le.house_bldg_num),TRIM((SALT38.StrType)le.street_suffix),TRIM((SALT38.StrType)le.apt_num),TRIM((SALT38.StrType)le.unit_desc),TRIM((SALT38.StrType)le.street_post_dir),TRIM((SALT38.StrType)le.street_pre_dir),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.dob),TRIM((SALT38.StrType)le.deceased_dte),TRIM((SALT38.StrType)le.home_tel_area),TRIM((SALT38.StrType)le.home_tel_num),TRIM((SALT38.StrType)le.work_tel_area),TRIM((SALT38.StrType)le.work_tel_num),TRIM((SALT38.StrType)le.work_tel_ext),TRIM((SALT38.StrType)le.upd_dte_time),TRIM((SALT38.StrType)le.first_name),TRIM((SALT38.StrType)le.mid_name),TRIM((SALT38.StrType)le.last_name),TRIM((SALT38.StrType)le.gen_delivery),TRIM((SALT38.StrType)le.street_name),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.foreign_cntry)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,29,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 29);
  SELF.FldNo2 := 1 + (C % 29);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.dl_state),TRIM((SALT38.StrType)le.dl_num),TRIM((SALT38.StrType)le.ssn),TRIM((SALT38.StrType)le.dl_issue_dte),TRIM((SALT38.StrType)le.dl_expire_dte),TRIM((SALT38.StrType)le.house_bldg_num),TRIM((SALT38.StrType)le.street_suffix),TRIM((SALT38.StrType)le.apt_num),TRIM((SALT38.StrType)le.unit_desc),TRIM((SALT38.StrType)le.street_post_dir),TRIM((SALT38.StrType)le.street_pre_dir),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.dob),TRIM((SALT38.StrType)le.deceased_dte),TRIM((SALT38.StrType)le.home_tel_area),TRIM((SALT38.StrType)le.home_tel_num),TRIM((SALT38.StrType)le.work_tel_area),TRIM((SALT38.StrType)le.work_tel_num),TRIM((SALT38.StrType)le.work_tel_ext),TRIM((SALT38.StrType)le.upd_dte_time),TRIM((SALT38.StrType)le.first_name),TRIM((SALT38.StrType)le.mid_name),TRIM((SALT38.StrType)le.last_name),TRIM((SALT38.StrType)le.gen_delivery),TRIM((SALT38.StrType)le.street_name),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.foreign_cntry)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.dl_state),TRIM((SALT38.StrType)le.dl_num),TRIM((SALT38.StrType)le.ssn),TRIM((SALT38.StrType)le.dl_issue_dte),TRIM((SALT38.StrType)le.dl_expire_dte),TRIM((SALT38.StrType)le.house_bldg_num),TRIM((SALT38.StrType)le.street_suffix),TRIM((SALT38.StrType)le.apt_num),TRIM((SALT38.StrType)le.unit_desc),TRIM((SALT38.StrType)le.street_post_dir),TRIM((SALT38.StrType)le.street_pre_dir),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.dob),TRIM((SALT38.StrType)le.deceased_dte),TRIM((SALT38.StrType)le.home_tel_area),TRIM((SALT38.StrType)le.home_tel_num),TRIM((SALT38.StrType)le.work_tel_area),TRIM((SALT38.StrType)le.work_tel_num),TRIM((SALT38.StrType)le.work_tel_ext),TRIM((SALT38.StrType)le.upd_dte_time),TRIM((SALT38.StrType)le.first_name),TRIM((SALT38.StrType)le.mid_name),TRIM((SALT38.StrType)le.last_name),TRIM((SALT38.StrType)le.gen_delivery),TRIM((SALT38.StrType)le.street_name),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.foreign_cntry)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),29*29,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dl_state'}
      ,{2,'dl_num'}
      ,{3,'ssn'}
      ,{4,'dl_issue_dte'}
      ,{5,'dl_expire_dte'}
      ,{6,'house_bldg_num'}
      ,{7,'street_suffix'}
      ,{8,'apt_num'}
      ,{9,'unit_desc'}
      ,{10,'street_post_dir'}
      ,{11,'street_pre_dir'}
      ,{12,'state'}
      ,{13,'zip'}
      ,{14,'zip4'}
      ,{15,'dob'}
      ,{16,'deceased_dte'}
      ,{17,'home_tel_area'}
      ,{18,'home_tel_num'}
      ,{19,'work_tel_area'}
      ,{20,'work_tel_num'}
      ,{21,'work_tel_ext'}
      ,{22,'upd_dte_time'}
      ,{23,'first_name'}
      ,{24,'mid_name'}
      ,{25,'last_name'}
      ,{26,'gen_delivery'}
      ,{27,'street_name'}
      ,{28,'city'}
      ,{29,'foreign_cntry'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    raw_file_Fields.InValid_dl_state((SALT38.StrType)le.dl_state),
    raw_file_Fields.InValid_dl_num((SALT38.StrType)le.dl_num),
    raw_file_Fields.InValid_ssn((SALT38.StrType)le.ssn),
    raw_file_Fields.InValid_dl_issue_dte((SALT38.StrType)le.dl_issue_dte),
    raw_file_Fields.InValid_dl_expire_dte((SALT38.StrType)le.dl_expire_dte),
    raw_file_Fields.InValid_house_bldg_num((SALT38.StrType)le.house_bldg_num),
    raw_file_Fields.InValid_street_suffix((SALT38.StrType)le.street_suffix),
    raw_file_Fields.InValid_apt_num((SALT38.StrType)le.apt_num),
    raw_file_Fields.InValid_unit_desc((SALT38.StrType)le.unit_desc),
    raw_file_Fields.InValid_street_post_dir((SALT38.StrType)le.street_post_dir),
    raw_file_Fields.InValid_street_pre_dir((SALT38.StrType)le.street_pre_dir),
    raw_file_Fields.InValid_state((SALT38.StrType)le.state),
    raw_file_Fields.InValid_zip((SALT38.StrType)le.zip),
    raw_file_Fields.InValid_zip4((SALT38.StrType)le.zip4),
    raw_file_Fields.InValid_dob((SALT38.StrType)le.dob),
    raw_file_Fields.InValid_deceased_dte((SALT38.StrType)le.deceased_dte,(SALT38.StrType)le.deceased_dte,(SALT38.StrType)le.dob),
    raw_file_Fields.InValid_home_tel_area((SALT38.StrType)le.home_tel_area,(SALT38.StrType)le.home_tel_area,(SALT38.StrType)le.home_tel_num),
    raw_file_Fields.InValid_home_tel_num((SALT38.StrType)le.home_tel_num,(SALT38.StrType)le.home_tel_area,(SALT38.StrType)le.home_tel_num),
    raw_file_Fields.InValid_work_tel_area((SALT38.StrType)le.work_tel_area,(SALT38.StrType)le.work_tel_area,(SALT38.StrType)le.work_tel_num),
    raw_file_Fields.InValid_work_tel_num((SALT38.StrType)le.work_tel_num,(SALT38.StrType)le.work_tel_area,(SALT38.StrType)le.work_tel_num),
    raw_file_Fields.InValid_work_tel_ext((SALT38.StrType)le.work_tel_ext,(SALT38.StrType)le.work_tel_ext),
    raw_file_Fields.InValid_upd_dte_time((SALT38.StrType)le.upd_dte_time),
    raw_file_Fields.InValid_first_name((SALT38.StrType)le.first_name,(SALT38.StrType)le.first_name,(SALT38.StrType)le.mid_name,(SALT38.StrType)le.last_name),
    raw_file_Fields.InValid_mid_name((SALT38.StrType)le.mid_name,(SALT38.StrType)le.first_name,(SALT38.StrType)le.mid_name,(SALT38.StrType)le.last_name),
    raw_file_Fields.InValid_last_name((SALT38.StrType)le.last_name,(SALT38.StrType)le.first_name,(SALT38.StrType)le.mid_name,(SALT38.StrType)le.last_name),
    raw_file_Fields.InValid_gen_delivery((SALT38.StrType)le.gen_delivery),
    raw_file_Fields.InValid_street_name((SALT38.StrType)le.street_name),
    raw_file_Fields.InValid_city((SALT38.StrType)le.city),
    raw_file_Fields.InValid_foreign_cntry((SALT38.StrType)le.foreign_cntry),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,29,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := raw_file_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_dl_state','invalid_dl_num','invalid_ssn','invalid_dl_issue_dte','invalid_dl_expire_dte','invalid_house_bldg_num','invalid_street_suffix','invalid_apt_num','invalid_unit_desc','invalid_street_post_dir','invalid_street_pre_dir','invalid_state','invalid_zip','invalid_zip4','invalid_dob','invalid_deceased_dte','invalid_home_tel_area','invalid_home_tel_num','invalid_work_tel_area','invalid_work_tel_num','invalid_work_tel_ext','invalid_upd_dte_time','invalid_first_name','invalid_mid_name','invalid_last_name','invalid_gen_delivery','invalid_street_name','invalid_city','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,raw_file_Fields.InValidMessage_dl_state(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_dl_num(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_ssn(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_dl_issue_dte(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_dl_expire_dte(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_house_bldg_num(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_street_suffix(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_apt_num(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_unit_desc(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_street_post_dir(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_street_pre_dir(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_state(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_zip(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_dob(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_deceased_dte(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_home_tel_area(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_home_tel_num(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_work_tel_area(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_work_tel_num(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_work_tel_ext(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_upd_dte_time(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_first_name(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_mid_name(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_last_name(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_gen_delivery(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_street_name(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_city(TotalErrors.ErrorNum),raw_file_Fields.InValidMessage_foreign_cntry(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Certegy, raw_file_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
