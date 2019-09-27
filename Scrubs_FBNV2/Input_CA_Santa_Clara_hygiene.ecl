IMPORT SALT311,STD;
EXPORT Input_CA_Santa_Clara_hygiene(dataset(Input_CA_Santa_Clara_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_status_cnt := COUNT(GROUP,h.status <> (TYPEOF(h.status))'');
    populated_status_pcnt := AVE(GROUP,IF(h.status = (TYPEOF(h.status))'',0,100));
    maxlength_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.status)));
    avelength_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.status)),h.status<>(typeof(h.status))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_FIlED_DATE_cnt := COUNT(GROUP,h.FIlED_DATE <> (TYPEOF(h.FIlED_DATE))'');
    populated_FIlED_DATE_pcnt := AVE(GROUP,IF(h.FIlED_DATE = (TYPEOF(h.FIlED_DATE))'',0,100));
    maxlength_FIlED_DATE := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.FIlED_DATE)));
    avelength_FIlED_DATE := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.FIlED_DATE)),h.FIlED_DATE<>(typeof(h.FIlED_DATE))'');
    populated_FBN_TYPE_cnt := COUNT(GROUP,h.FBN_TYPE <> (TYPEOF(h.FBN_TYPE))'');
    populated_FBN_TYPE_pcnt := AVE(GROUP,IF(h.FBN_TYPE = (TYPEOF(h.FBN_TYPE))'',0,100));
    maxlength_FBN_TYPE := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.FBN_TYPE)));
    avelength_FBN_TYPE := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.FBN_TYPE)),h.FBN_TYPE<>(typeof(h.FBN_TYPE))'');
    populated_FILING_TYPE_cnt := COUNT(GROUP,h.FILING_TYPE <> (TYPEOF(h.FILING_TYPE))'');
    populated_FILING_TYPE_pcnt := AVE(GROUP,IF(h.FILING_TYPE = (TYPEOF(h.FILING_TYPE))'',0,100));
    maxlength_FILING_TYPE := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.FILING_TYPE)));
    avelength_FILING_TYPE := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.FILING_TYPE)),h.FILING_TYPE<>(typeof(h.FILING_TYPE))'');
    populated_BUSINESS_NAME_cnt := COUNT(GROUP,h.BUSINESS_NAME <> (TYPEOF(h.BUSINESS_NAME))'');
    populated_BUSINESS_NAME_pcnt := AVE(GROUP,IF(h.BUSINESS_NAME = (TYPEOF(h.BUSINESS_NAME))'',0,100));
    maxlength_BUSINESS_NAME := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.BUSINESS_NAME)));
    avelength_BUSINESS_NAME := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.BUSINESS_NAME)),h.BUSINESS_NAME<>(typeof(h.BUSINESS_NAME))'');
    populated_BUSINESS_TYPE_cnt := COUNT(GROUP,h.BUSINESS_TYPE <> (TYPEOF(h.BUSINESS_TYPE))'');
    populated_BUSINESS_TYPE_pcnt := AVE(GROUP,IF(h.BUSINESS_TYPE = (TYPEOF(h.BUSINESS_TYPE))'',0,100));
    maxlength_BUSINESS_TYPE := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.BUSINESS_TYPE)));
    avelength_BUSINESS_TYPE := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.BUSINESS_TYPE)),h.BUSINESS_TYPE<>(typeof(h.BUSINESS_TYPE))'');
    populated_ORIG_FILED_DATE_cnt := COUNT(GROUP,h.ORIG_FILED_DATE <> (TYPEOF(h.ORIG_FILED_DATE))'');
    populated_ORIG_FILED_DATE_pcnt := AVE(GROUP,IF(h.ORIG_FILED_DATE = (TYPEOF(h.ORIG_FILED_DATE))'',0,100));
    maxlength_ORIG_FILED_DATE := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ORIG_FILED_DATE)));
    avelength_ORIG_FILED_DATE := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ORIG_FILED_DATE)),h.ORIG_FILED_DATE<>(typeof(h.ORIG_FILED_DATE))'');
    populated_ORIG_FBN_NUM_cnt := COUNT(GROUP,h.ORIG_FBN_NUM <> (TYPEOF(h.ORIG_FBN_NUM))'');
    populated_ORIG_FBN_NUM_pcnt := AVE(GROUP,IF(h.ORIG_FBN_NUM = (TYPEOF(h.ORIG_FBN_NUM))'',0,100));
    maxlength_ORIG_FBN_NUM := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ORIG_FBN_NUM)));
    avelength_ORIG_FBN_NUM := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ORIG_FBN_NUM)),h.ORIG_FBN_NUM<>(typeof(h.ORIG_FBN_NUM))'');
    populated_RECORD_CODE1_cnt := COUNT(GROUP,h.RECORD_CODE1 <> (TYPEOF(h.RECORD_CODE1))'');
    populated_RECORD_CODE1_pcnt := AVE(GROUP,IF(h.RECORD_CODE1 = (TYPEOF(h.RECORD_CODE1))'',0,100));
    maxlength_RECORD_CODE1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.RECORD_CODE1)));
    avelength_RECORD_CODE1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.RECORD_CODE1)),h.RECORD_CODE1<>(typeof(h.RECORD_CODE1))'');
    populated_FBN_NUM_cnt := COUNT(GROUP,h.FBN_NUM <> (TYPEOF(h.FBN_NUM))'');
    populated_FBN_NUM_pcnt := AVE(GROUP,IF(h.FBN_NUM = (TYPEOF(h.FBN_NUM))'',0,100));
    maxlength_FBN_NUM := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.FBN_NUM)));
    avelength_FBN_NUM := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.FBN_NUM)),h.FBN_NUM<>(typeof(h.FBN_NUM))'');
    populated_BUSINESS_ADDR1_cnt := COUNT(GROUP,h.BUSINESS_ADDR1 <> (TYPEOF(h.BUSINESS_ADDR1))'');
    populated_BUSINESS_ADDR1_pcnt := AVE(GROUP,IF(h.BUSINESS_ADDR1 = (TYPEOF(h.BUSINESS_ADDR1))'',0,100));
    maxlength_BUSINESS_ADDR1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.BUSINESS_ADDR1)));
    avelength_BUSINESS_ADDR1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.BUSINESS_ADDR1)),h.BUSINESS_ADDR1<>(typeof(h.BUSINESS_ADDR1))'');
    populated_RECORD_CODE2_cnt := COUNT(GROUP,h.RECORD_CODE2 <> (TYPEOF(h.RECORD_CODE2))'');
    populated_RECORD_CODE2_pcnt := AVE(GROUP,IF(h.RECORD_CODE2 = (TYPEOF(h.RECORD_CODE2))'',0,100));
    maxlength_RECORD_CODE2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.RECORD_CODE2)));
    avelength_RECORD_CODE2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.RECORD_CODE2)),h.RECORD_CODE2<>(typeof(h.RECORD_CODE2))'');
    populated_BUSINESS_ADDR2_cnt := COUNT(GROUP,h.BUSINESS_ADDR2 <> (TYPEOF(h.BUSINESS_ADDR2))'');
    populated_BUSINESS_ADDR2_pcnt := AVE(GROUP,IF(h.BUSINESS_ADDR2 = (TYPEOF(h.BUSINESS_ADDR2))'',0,100));
    maxlength_BUSINESS_ADDR2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.BUSINESS_ADDR2)));
    avelength_BUSINESS_ADDR2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.BUSINESS_ADDR2)),h.BUSINESS_ADDR2<>(typeof(h.BUSINESS_ADDR2))'');
    populated_RECORD_CODE3_cnt := COUNT(GROUP,h.RECORD_CODE3 <> (TYPEOF(h.RECORD_CODE3))'');
    populated_RECORD_CODE3_pcnt := AVE(GROUP,IF(h.RECORD_CODE3 = (TYPEOF(h.RECORD_CODE3))'',0,100));
    maxlength_RECORD_CODE3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.RECORD_CODE3)));
    avelength_RECORD_CODE3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.RECORD_CODE3)),h.RECORD_CODE3<>(typeof(h.RECORD_CODE3))'');
    populated_BUS_CITY_cnt := COUNT(GROUP,h.BUS_CITY <> (TYPEOF(h.BUS_CITY))'');
    populated_BUS_CITY_pcnt := AVE(GROUP,IF(h.BUS_CITY = (TYPEOF(h.BUS_CITY))'',0,100));
    maxlength_BUS_CITY := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.BUS_CITY)));
    avelength_BUS_CITY := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.BUS_CITY)),h.BUS_CITY<>(typeof(h.BUS_CITY))'');
    populated_BUS_ST_cnt := COUNT(GROUP,h.BUS_ST <> (TYPEOF(h.BUS_ST))'');
    populated_BUS_ST_pcnt := AVE(GROUP,IF(h.BUS_ST = (TYPEOF(h.BUS_ST))'',0,100));
    maxlength_BUS_ST := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.BUS_ST)));
    avelength_BUS_ST := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.BUS_ST)),h.BUS_ST<>(typeof(h.BUS_ST))'');
    populated_BUS_ZIP_cnt := COUNT(GROUP,h.BUS_ZIP <> (TYPEOF(h.BUS_ZIP))'');
    populated_BUS_ZIP_pcnt := AVE(GROUP,IF(h.BUS_ZIP = (TYPEOF(h.BUS_ZIP))'',0,100));
    maxlength_BUS_ZIP := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.BUS_ZIP)));
    avelength_BUS_ZIP := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.BUS_ZIP)),h.BUS_ZIP<>(typeof(h.BUS_ZIP))'');
    populated_RECORD_CODE4_cnt := COUNT(GROUP,h.RECORD_CODE4 <> (TYPEOF(h.RECORD_CODE4))'');
    populated_RECORD_CODE4_pcnt := AVE(GROUP,IF(h.RECORD_CODE4 = (TYPEOF(h.RECORD_CODE4))'',0,100));
    maxlength_RECORD_CODE4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.RECORD_CODE4)));
    avelength_RECORD_CODE4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.RECORD_CODE4)),h.RECORD_CODE4<>(typeof(h.RECORD_CODE4))'');
    populated_ADDTL_BUSINESS_cnt := COUNT(GROUP,h.ADDTL_BUSINESS <> (TYPEOF(h.ADDTL_BUSINESS))'');
    populated_ADDTL_BUSINESS_pcnt := AVE(GROUP,IF(h.ADDTL_BUSINESS = (TYPEOF(h.ADDTL_BUSINESS))'',0,100));
    maxlength_ADDTL_BUSINESS := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ADDTL_BUSINESS)));
    avelength_ADDTL_BUSINESS := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ADDTL_BUSINESS)),h.ADDTL_BUSINESS<>(typeof(h.ADDTL_BUSINESS))'');
    populated_RECORD_CODE5_cnt := COUNT(GROUP,h.RECORD_CODE5 <> (TYPEOF(h.RECORD_CODE5))'');
    populated_RECORD_CODE5_pcnt := AVE(GROUP,IF(h.RECORD_CODE5 = (TYPEOF(h.RECORD_CODE5))'',0,100));
    maxlength_RECORD_CODE5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.RECORD_CODE5)));
    avelength_RECORD_CODE5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.RECORD_CODE5)),h.RECORD_CODE5<>(typeof(h.RECORD_CODE5))'');
    populated_owner_name_cnt := COUNT(GROUP,h.owner_name <> (TYPEOF(h.owner_name))'');
    populated_owner_name_pcnt := AVE(GROUP,IF(h.owner_name = (TYPEOF(h.owner_name))'',0,100));
    maxlength_owner_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner_name)));
    avelength_owner_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner_name)),h.owner_name<>(typeof(h.owner_name))'');
    populated_OWNER_TYPE_cnt := COUNT(GROUP,h.OWNER_TYPE <> (TYPEOF(h.OWNER_TYPE))'');
    populated_OWNER_TYPE_pcnt := AVE(GROUP,IF(h.OWNER_TYPE = (TYPEOF(h.OWNER_TYPE))'',0,100));
    maxlength_OWNER_TYPE := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.OWNER_TYPE)));
    avelength_OWNER_TYPE := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.OWNER_TYPE)),h.OWNER_TYPE<>(typeof(h.OWNER_TYPE))'');
    populated_RECORD_CODE6_cnt := COUNT(GROUP,h.RECORD_CODE6 <> (TYPEOF(h.RECORD_CODE6))'');
    populated_RECORD_CODE6_pcnt := AVE(GROUP,IF(h.RECORD_CODE6 = (TYPEOF(h.RECORD_CODE6))'',0,100));
    maxlength_RECORD_CODE6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.RECORD_CODE6)));
    avelength_RECORD_CODE6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.RECORD_CODE6)),h.RECORD_CODE6<>(typeof(h.RECORD_CODE6))'');
    populated_OWNER_ADDR1_cnt := COUNT(GROUP,h.OWNER_ADDR1 <> (TYPEOF(h.OWNER_ADDR1))'');
    populated_OWNER_ADDR1_pcnt := AVE(GROUP,IF(h.OWNER_ADDR1 = (TYPEOF(h.OWNER_ADDR1))'',0,100));
    maxlength_OWNER_ADDR1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.OWNER_ADDR1)));
    avelength_OWNER_ADDR1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.OWNER_ADDR1)),h.OWNER_ADDR1<>(typeof(h.OWNER_ADDR1))'');
    populated_OWNER_CITY_cnt := COUNT(GROUP,h.OWNER_CITY <> (TYPEOF(h.OWNER_CITY))'');
    populated_OWNER_CITY_pcnt := AVE(GROUP,IF(h.OWNER_CITY = (TYPEOF(h.OWNER_CITY))'',0,100));
    maxlength_OWNER_CITY := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.OWNER_CITY)));
    avelength_OWNER_CITY := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.OWNER_CITY)),h.OWNER_CITY<>(typeof(h.OWNER_CITY))'');
    populated_OWNER_ST_cnt := COUNT(GROUP,h.OWNER_ST <> (TYPEOF(h.OWNER_ST))'');
    populated_OWNER_ST_pcnt := AVE(GROUP,IF(h.OWNER_ST = (TYPEOF(h.OWNER_ST))'',0,100));
    maxlength_OWNER_ST := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.OWNER_ST)));
    avelength_OWNER_ST := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.OWNER_ST)),h.OWNER_ST<>(typeof(h.OWNER_ST))'');
    populated_OWNER_ZIP_cnt := COUNT(GROUP,h.OWNER_ZIP <> (TYPEOF(h.OWNER_ZIP))'');
    populated_OWNER_ZIP_pcnt := AVE(GROUP,IF(h.OWNER_ZIP = (TYPEOF(h.OWNER_ZIP))'',0,100));
    maxlength_OWNER_ZIP := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.OWNER_ZIP)));
    avelength_OWNER_ZIP := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.OWNER_ZIP)),h.OWNER_ZIP<>(typeof(h.OWNER_ZIP))'');
    populated_Owner_title_cnt := COUNT(GROUP,h.Owner_title <> (TYPEOF(h.Owner_title))'');
    populated_Owner_title_pcnt := AVE(GROUP,IF(h.Owner_title = (TYPEOF(h.Owner_title))'',0,100));
    maxlength_Owner_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Owner_title)));
    avelength_Owner_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Owner_title)),h.Owner_title<>(typeof(h.Owner_title))'');
    populated_Owner_fname_cnt := COUNT(GROUP,h.Owner_fname <> (TYPEOF(h.Owner_fname))'');
    populated_Owner_fname_pcnt := AVE(GROUP,IF(h.Owner_fname = (TYPEOF(h.Owner_fname))'',0,100));
    maxlength_Owner_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Owner_fname)));
    avelength_Owner_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Owner_fname)),h.Owner_fname<>(typeof(h.Owner_fname))'');
    populated_Owner_mname_cnt := COUNT(GROUP,h.Owner_mname <> (TYPEOF(h.Owner_mname))'');
    populated_Owner_mname_pcnt := AVE(GROUP,IF(h.Owner_mname = (TYPEOF(h.Owner_mname))'',0,100));
    maxlength_Owner_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Owner_mname)));
    avelength_Owner_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Owner_mname)),h.Owner_mname<>(typeof(h.Owner_mname))'');
    populated_Owner_lname_cnt := COUNT(GROUP,h.Owner_lname <> (TYPEOF(h.Owner_lname))'');
    populated_Owner_lname_pcnt := AVE(GROUP,IF(h.Owner_lname = (TYPEOF(h.Owner_lname))'',0,100));
    maxlength_Owner_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Owner_lname)));
    avelength_Owner_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Owner_lname)),h.Owner_lname<>(typeof(h.Owner_lname))'');
    populated_Owner_name_suffix_cnt := COUNT(GROUP,h.Owner_name_suffix <> (TYPEOF(h.Owner_name_suffix))'');
    populated_Owner_name_suffix_pcnt := AVE(GROUP,IF(h.Owner_name_suffix = (TYPEOF(h.Owner_name_suffix))'',0,100));
    maxlength_Owner_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Owner_name_suffix)));
    avelength_Owner_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Owner_name_suffix)),h.Owner_name_suffix<>(typeof(h.Owner_name_suffix))'');
    populated_Owner_name_score_cnt := COUNT(GROUP,h.Owner_name_score <> (TYPEOF(h.Owner_name_score))'');
    populated_Owner_name_score_pcnt := AVE(GROUP,IF(h.Owner_name_score = (TYPEOF(h.Owner_name_score))'',0,100));
    maxlength_Owner_name_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Owner_name_score)));
    avelength_Owner_name_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Owner_name_score)),h.Owner_name_score<>(typeof(h.Owner_name_score))'');
    populated_prep_addr_line1_cnt := COUNT(GROUP,h.prep_addr_line1 <> (TYPEOF(h.prep_addr_line1))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_line_last_cnt := COUNT(GROUP,h.prep_addr_line_last <> (TYPEOF(h.prep_addr_line_last))'');
    populated_prep_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_addr_line_last = (TYPEOF(h.prep_addr_line_last))'',0,100));
    maxlength_prep_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line_last)));
    avelength_prep_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line_last)),h.prep_addr_line_last<>(typeof(h.prep_addr_line_last))'');
    populated_prep_owner_addr_line1_cnt := COUNT(GROUP,h.prep_owner_addr_line1 <> (TYPEOF(h.prep_owner_addr_line1))'');
    populated_prep_owner_addr_line1_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line1 = (TYPEOF(h.prep_owner_addr_line1))'',0,100));
    maxlength_prep_owner_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line1)));
    avelength_prep_owner_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line1)),h.prep_owner_addr_line1<>(typeof(h.prep_owner_addr_line1))'');
    populated_prep_owner_addr_line_last_cnt := COUNT(GROUP,h.prep_owner_addr_line_last <> (TYPEOF(h.prep_owner_addr_line_last))'');
    populated_prep_owner_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line_last = (TYPEOF(h.prep_owner_addr_line_last))'',0,100));
    maxlength_prep_owner_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line_last)));
    avelength_prep_owner_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line_last)),h.prep_owner_addr_line_last<>(typeof(h.prep_owner_addr_line_last))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_status_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_FIlED_DATE_pcnt *   0.00 / 100 + T.Populated_FBN_TYPE_pcnt *   0.00 / 100 + T.Populated_FILING_TYPE_pcnt *   0.00 / 100 + T.Populated_BUSINESS_NAME_pcnt *   0.00 / 100 + T.Populated_BUSINESS_TYPE_pcnt *   0.00 / 100 + T.Populated_ORIG_FILED_DATE_pcnt *   0.00 / 100 + T.Populated_ORIG_FBN_NUM_pcnt *   0.00 / 100 + T.Populated_RECORD_CODE1_pcnt *   0.00 / 100 + T.Populated_FBN_NUM_pcnt *   0.00 / 100 + T.Populated_BUSINESS_ADDR1_pcnt *   0.00 / 100 + T.Populated_RECORD_CODE2_pcnt *   0.00 / 100 + T.Populated_BUSINESS_ADDR2_pcnt *   0.00 / 100 + T.Populated_RECORD_CODE3_pcnt *   0.00 / 100 + T.Populated_BUS_CITY_pcnt *   0.00 / 100 + T.Populated_BUS_ST_pcnt *   0.00 / 100 + T.Populated_BUS_ZIP_pcnt *   0.00 / 100 + T.Populated_RECORD_CODE4_pcnt *   0.00 / 100 + T.Populated_ADDTL_BUSINESS_pcnt *   0.00 / 100 + T.Populated_RECORD_CODE5_pcnt *   0.00 / 100 + T.Populated_owner_name_pcnt *   0.00 / 100 + T.Populated_OWNER_TYPE_pcnt *   0.00 / 100 + T.Populated_RECORD_CODE6_pcnt *   0.00 / 100 + T.Populated_OWNER_ADDR1_pcnt *   0.00 / 100 + T.Populated_OWNER_CITY_pcnt *   0.00 / 100 + T.Populated_OWNER_ST_pcnt *   0.00 / 100 + T.Populated_OWNER_ZIP_pcnt *   0.00 / 100 + T.Populated_Owner_title_pcnt *   0.00 / 100 + T.Populated_Owner_fname_pcnt *   0.00 / 100 + T.Populated_Owner_mname_pcnt *   0.00 / 100 + T.Populated_Owner_lname_pcnt *   0.00 / 100 + T.Populated_Owner_name_suffix_pcnt *   0.00 / 100 + T.Populated_Owner_name_score_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_line_last_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line_last_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'status','process_date','FIlED_DATE','FBN_TYPE','FILING_TYPE','BUSINESS_NAME','BUSINESS_TYPE','ORIG_FILED_DATE','ORIG_FBN_NUM','RECORD_CODE1','FBN_NUM','BUSINESS_ADDR1','RECORD_CODE2','BUSINESS_ADDR2','RECORD_CODE3','BUS_CITY','BUS_ST','BUS_ZIP','RECORD_CODE4','ADDTL_BUSINESS','RECORD_CODE5','owner_name','OWNER_TYPE','RECORD_CODE6','OWNER_ADDR1','OWNER_CITY','OWNER_ST','OWNER_ZIP','Owner_title','Owner_fname','Owner_mname','Owner_lname','Owner_name_suffix','Owner_name_score','prep_addr_line1','prep_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last');
  SELF.populated_pcnt := CHOOSE(C,le.populated_status_pcnt,le.populated_process_date_pcnt,le.populated_FIlED_DATE_pcnt,le.populated_FBN_TYPE_pcnt,le.populated_FILING_TYPE_pcnt,le.populated_BUSINESS_NAME_pcnt,le.populated_BUSINESS_TYPE_pcnt,le.populated_ORIG_FILED_DATE_pcnt,le.populated_ORIG_FBN_NUM_pcnt,le.populated_RECORD_CODE1_pcnt,le.populated_FBN_NUM_pcnt,le.populated_BUSINESS_ADDR1_pcnt,le.populated_RECORD_CODE2_pcnt,le.populated_BUSINESS_ADDR2_pcnt,le.populated_RECORD_CODE3_pcnt,le.populated_BUS_CITY_pcnt,le.populated_BUS_ST_pcnt,le.populated_BUS_ZIP_pcnt,le.populated_RECORD_CODE4_pcnt,le.populated_ADDTL_BUSINESS_pcnt,le.populated_RECORD_CODE5_pcnt,le.populated_owner_name_pcnt,le.populated_OWNER_TYPE_pcnt,le.populated_RECORD_CODE6_pcnt,le.populated_OWNER_ADDR1_pcnt,le.populated_OWNER_CITY_pcnt,le.populated_OWNER_ST_pcnt,le.populated_OWNER_ZIP_pcnt,le.populated_Owner_title_pcnt,le.populated_Owner_fname_pcnt,le.populated_Owner_mname_pcnt,le.populated_Owner_lname_pcnt,le.populated_Owner_name_suffix_pcnt,le.populated_Owner_name_score_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_line_last_pcnt,le.populated_prep_owner_addr_line1_pcnt,le.populated_prep_owner_addr_line_last_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_status,le.maxlength_process_date,le.maxlength_FIlED_DATE,le.maxlength_FBN_TYPE,le.maxlength_FILING_TYPE,le.maxlength_BUSINESS_NAME,le.maxlength_BUSINESS_TYPE,le.maxlength_ORIG_FILED_DATE,le.maxlength_ORIG_FBN_NUM,le.maxlength_RECORD_CODE1,le.maxlength_FBN_NUM,le.maxlength_BUSINESS_ADDR1,le.maxlength_RECORD_CODE2,le.maxlength_BUSINESS_ADDR2,le.maxlength_RECORD_CODE3,le.maxlength_BUS_CITY,le.maxlength_BUS_ST,le.maxlength_BUS_ZIP,le.maxlength_RECORD_CODE4,le.maxlength_ADDTL_BUSINESS,le.maxlength_RECORD_CODE5,le.maxlength_owner_name,le.maxlength_OWNER_TYPE,le.maxlength_RECORD_CODE6,le.maxlength_OWNER_ADDR1,le.maxlength_OWNER_CITY,le.maxlength_OWNER_ST,le.maxlength_OWNER_ZIP,le.maxlength_Owner_title,le.maxlength_Owner_fname,le.maxlength_Owner_mname,le.maxlength_Owner_lname,le.maxlength_Owner_name_suffix,le.maxlength_Owner_name_score,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_line_last,le.maxlength_prep_owner_addr_line1,le.maxlength_prep_owner_addr_line_last);
  SELF.avelength := CHOOSE(C,le.avelength_status,le.avelength_process_date,le.avelength_FIlED_DATE,le.avelength_FBN_TYPE,le.avelength_FILING_TYPE,le.avelength_BUSINESS_NAME,le.avelength_BUSINESS_TYPE,le.avelength_ORIG_FILED_DATE,le.avelength_ORIG_FBN_NUM,le.avelength_RECORD_CODE1,le.avelength_FBN_NUM,le.avelength_BUSINESS_ADDR1,le.avelength_RECORD_CODE2,le.avelength_BUSINESS_ADDR2,le.avelength_RECORD_CODE3,le.avelength_BUS_CITY,le.avelength_BUS_ST,le.avelength_BUS_ZIP,le.avelength_RECORD_CODE4,le.avelength_ADDTL_BUSINESS,le.avelength_RECORD_CODE5,le.avelength_owner_name,le.avelength_OWNER_TYPE,le.avelength_RECORD_CODE6,le.avelength_OWNER_ADDR1,le.avelength_OWNER_CITY,le.avelength_OWNER_ST,le.avelength_OWNER_ZIP,le.avelength_Owner_title,le.avelength_Owner_fname,le.avelength_Owner_mname,le.avelength_Owner_lname,le.avelength_Owner_name_suffix,le.avelength_Owner_name_score,le.avelength_prep_addr_line1,le.avelength_prep_addr_line_last,le.avelength_prep_owner_addr_line1,le.avelength_prep_owner_addr_line_last);
END;
EXPORT invSummary := NORMALIZE(summary0, 38, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.FIlED_DATE),TRIM((SALT311.StrType)le.FBN_TYPE),TRIM((SALT311.StrType)le.FILING_TYPE),TRIM((SALT311.StrType)le.BUSINESS_NAME),TRIM((SALT311.StrType)le.BUSINESS_TYPE),TRIM((SALT311.StrType)le.ORIG_FILED_DATE),TRIM((SALT311.StrType)le.ORIG_FBN_NUM),TRIM((SALT311.StrType)le.RECORD_CODE1),TRIM((SALT311.StrType)le.FBN_NUM),TRIM((SALT311.StrType)le.BUSINESS_ADDR1),TRIM((SALT311.StrType)le.RECORD_CODE2),TRIM((SALT311.StrType)le.BUSINESS_ADDR2),TRIM((SALT311.StrType)le.RECORD_CODE3),TRIM((SALT311.StrType)le.BUS_CITY),TRIM((SALT311.StrType)le.BUS_ST),TRIM((SALT311.StrType)le.BUS_ZIP),TRIM((SALT311.StrType)le.RECORD_CODE4),TRIM((SALT311.StrType)le.ADDTL_BUSINESS),TRIM((SALT311.StrType)le.RECORD_CODE5),TRIM((SALT311.StrType)le.owner_name),TRIM((SALT311.StrType)le.OWNER_TYPE),TRIM((SALT311.StrType)le.RECORD_CODE6),TRIM((SALT311.StrType)le.OWNER_ADDR1),TRIM((SALT311.StrType)le.OWNER_CITY),TRIM((SALT311.StrType)le.OWNER_ST),TRIM((SALT311.StrType)le.OWNER_ZIP),TRIM((SALT311.StrType)le.Owner_title),TRIM((SALT311.StrType)le.Owner_fname),TRIM((SALT311.StrType)le.Owner_mname),TRIM((SALT311.StrType)le.Owner_lname),TRIM((SALT311.StrType)le.Owner_name_suffix),TRIM((SALT311.StrType)le.Owner_name_score),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_line_last),TRIM((SALT311.StrType)le.prep_owner_addr_line1),TRIM((SALT311.StrType)le.prep_owner_addr_line_last)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,38,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 38);
  SELF.FldNo2 := 1 + (C % 38);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.FIlED_DATE),TRIM((SALT311.StrType)le.FBN_TYPE),TRIM((SALT311.StrType)le.FILING_TYPE),TRIM((SALT311.StrType)le.BUSINESS_NAME),TRIM((SALT311.StrType)le.BUSINESS_TYPE),TRIM((SALT311.StrType)le.ORIG_FILED_DATE),TRIM((SALT311.StrType)le.ORIG_FBN_NUM),TRIM((SALT311.StrType)le.RECORD_CODE1),TRIM((SALT311.StrType)le.FBN_NUM),TRIM((SALT311.StrType)le.BUSINESS_ADDR1),TRIM((SALT311.StrType)le.RECORD_CODE2),TRIM((SALT311.StrType)le.BUSINESS_ADDR2),TRIM((SALT311.StrType)le.RECORD_CODE3),TRIM((SALT311.StrType)le.BUS_CITY),TRIM((SALT311.StrType)le.BUS_ST),TRIM((SALT311.StrType)le.BUS_ZIP),TRIM((SALT311.StrType)le.RECORD_CODE4),TRIM((SALT311.StrType)le.ADDTL_BUSINESS),TRIM((SALT311.StrType)le.RECORD_CODE5),TRIM((SALT311.StrType)le.owner_name),TRIM((SALT311.StrType)le.OWNER_TYPE),TRIM((SALT311.StrType)le.RECORD_CODE6),TRIM((SALT311.StrType)le.OWNER_ADDR1),TRIM((SALT311.StrType)le.OWNER_CITY),TRIM((SALT311.StrType)le.OWNER_ST),TRIM((SALT311.StrType)le.OWNER_ZIP),TRIM((SALT311.StrType)le.Owner_title),TRIM((SALT311.StrType)le.Owner_fname),TRIM((SALT311.StrType)le.Owner_mname),TRIM((SALT311.StrType)le.Owner_lname),TRIM((SALT311.StrType)le.Owner_name_suffix),TRIM((SALT311.StrType)le.Owner_name_score),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_line_last),TRIM((SALT311.StrType)le.prep_owner_addr_line1),TRIM((SALT311.StrType)le.prep_owner_addr_line_last)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.FIlED_DATE),TRIM((SALT311.StrType)le.FBN_TYPE),TRIM((SALT311.StrType)le.FILING_TYPE),TRIM((SALT311.StrType)le.BUSINESS_NAME),TRIM((SALT311.StrType)le.BUSINESS_TYPE),TRIM((SALT311.StrType)le.ORIG_FILED_DATE),TRIM((SALT311.StrType)le.ORIG_FBN_NUM),TRIM((SALT311.StrType)le.RECORD_CODE1),TRIM((SALT311.StrType)le.FBN_NUM),TRIM((SALT311.StrType)le.BUSINESS_ADDR1),TRIM((SALT311.StrType)le.RECORD_CODE2),TRIM((SALT311.StrType)le.BUSINESS_ADDR2),TRIM((SALT311.StrType)le.RECORD_CODE3),TRIM((SALT311.StrType)le.BUS_CITY),TRIM((SALT311.StrType)le.BUS_ST),TRIM((SALT311.StrType)le.BUS_ZIP),TRIM((SALT311.StrType)le.RECORD_CODE4),TRIM((SALT311.StrType)le.ADDTL_BUSINESS),TRIM((SALT311.StrType)le.RECORD_CODE5),TRIM((SALT311.StrType)le.owner_name),TRIM((SALT311.StrType)le.OWNER_TYPE),TRIM((SALT311.StrType)le.RECORD_CODE6),TRIM((SALT311.StrType)le.OWNER_ADDR1),TRIM((SALT311.StrType)le.OWNER_CITY),TRIM((SALT311.StrType)le.OWNER_ST),TRIM((SALT311.StrType)le.OWNER_ZIP),TRIM((SALT311.StrType)le.Owner_title),TRIM((SALT311.StrType)le.Owner_fname),TRIM((SALT311.StrType)le.Owner_mname),TRIM((SALT311.StrType)le.Owner_lname),TRIM((SALT311.StrType)le.Owner_name_suffix),TRIM((SALT311.StrType)le.Owner_name_score),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_line_last),TRIM((SALT311.StrType)le.prep_owner_addr_line1),TRIM((SALT311.StrType)le.prep_owner_addr_line_last)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),38*38,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'status'}
      ,{2,'process_date'}
      ,{3,'FIlED_DATE'}
      ,{4,'FBN_TYPE'}
      ,{5,'FILING_TYPE'}
      ,{6,'BUSINESS_NAME'}
      ,{7,'BUSINESS_TYPE'}
      ,{8,'ORIG_FILED_DATE'}
      ,{9,'ORIG_FBN_NUM'}
      ,{10,'RECORD_CODE1'}
      ,{11,'FBN_NUM'}
      ,{12,'BUSINESS_ADDR1'}
      ,{13,'RECORD_CODE2'}
      ,{14,'BUSINESS_ADDR2'}
      ,{15,'RECORD_CODE3'}
      ,{16,'BUS_CITY'}
      ,{17,'BUS_ST'}
      ,{18,'BUS_ZIP'}
      ,{19,'RECORD_CODE4'}
      ,{20,'ADDTL_BUSINESS'}
      ,{21,'RECORD_CODE5'}
      ,{22,'owner_name'}
      ,{23,'OWNER_TYPE'}
      ,{24,'RECORD_CODE6'}
      ,{25,'OWNER_ADDR1'}
      ,{26,'OWNER_CITY'}
      ,{27,'OWNER_ST'}
      ,{28,'OWNER_ZIP'}
      ,{29,'Owner_title'}
      ,{30,'Owner_fname'}
      ,{31,'Owner_mname'}
      ,{32,'Owner_lname'}
      ,{33,'Owner_name_suffix'}
      ,{34,'Owner_name_score'}
      ,{35,'prep_addr_line1'}
      ,{36,'prep_addr_line_last'}
      ,{37,'prep_owner_addr_line1'}
      ,{38,'prep_owner_addr_line_last'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_CA_Santa_Clara_Fields.InValid_status((SALT311.StrType)le.status),
    Input_CA_Santa_Clara_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Input_CA_Santa_Clara_Fields.InValid_FIlED_DATE((SALT311.StrType)le.FIlED_DATE),
    Input_CA_Santa_Clara_Fields.InValid_FBN_TYPE((SALT311.StrType)le.FBN_TYPE),
    Input_CA_Santa_Clara_Fields.InValid_FILING_TYPE((SALT311.StrType)le.FILING_TYPE),
    Input_CA_Santa_Clara_Fields.InValid_BUSINESS_NAME((SALT311.StrType)le.BUSINESS_NAME),
    Input_CA_Santa_Clara_Fields.InValid_BUSINESS_TYPE((SALT311.StrType)le.BUSINESS_TYPE),
    Input_CA_Santa_Clara_Fields.InValid_ORIG_FILED_DATE((SALT311.StrType)le.ORIG_FILED_DATE),
    Input_CA_Santa_Clara_Fields.InValid_ORIG_FBN_NUM((SALT311.StrType)le.ORIG_FBN_NUM),
    Input_CA_Santa_Clara_Fields.InValid_RECORD_CODE1((SALT311.StrType)le.RECORD_CODE1),
    Input_CA_Santa_Clara_Fields.InValid_FBN_NUM((SALT311.StrType)le.FBN_NUM),
    Input_CA_Santa_Clara_Fields.InValid_BUSINESS_ADDR1((SALT311.StrType)le.BUSINESS_ADDR1),
    Input_CA_Santa_Clara_Fields.InValid_RECORD_CODE2((SALT311.StrType)le.RECORD_CODE2),
    Input_CA_Santa_Clara_Fields.InValid_BUSINESS_ADDR2((SALT311.StrType)le.BUSINESS_ADDR2),
    Input_CA_Santa_Clara_Fields.InValid_RECORD_CODE3((SALT311.StrType)le.RECORD_CODE3),
    Input_CA_Santa_Clara_Fields.InValid_BUS_CITY((SALT311.StrType)le.BUS_CITY),
    Input_CA_Santa_Clara_Fields.InValid_BUS_ST((SALT311.StrType)le.BUS_ST),
    Input_CA_Santa_Clara_Fields.InValid_BUS_ZIP((SALT311.StrType)le.BUS_ZIP),
    Input_CA_Santa_Clara_Fields.InValid_RECORD_CODE4((SALT311.StrType)le.RECORD_CODE4),
    Input_CA_Santa_Clara_Fields.InValid_ADDTL_BUSINESS((SALT311.StrType)le.ADDTL_BUSINESS),
    Input_CA_Santa_Clara_Fields.InValid_RECORD_CODE5((SALT311.StrType)le.RECORD_CODE5),
    Input_CA_Santa_Clara_Fields.InValid_owner_name((SALT311.StrType)le.owner_name),
    Input_CA_Santa_Clara_Fields.InValid_OWNER_TYPE((SALT311.StrType)le.OWNER_TYPE),
    Input_CA_Santa_Clara_Fields.InValid_RECORD_CODE6((SALT311.StrType)le.RECORD_CODE6),
    Input_CA_Santa_Clara_Fields.InValid_OWNER_ADDR1((SALT311.StrType)le.OWNER_ADDR1),
    Input_CA_Santa_Clara_Fields.InValid_OWNER_CITY((SALT311.StrType)le.OWNER_CITY),
    Input_CA_Santa_Clara_Fields.InValid_OWNER_ST((SALT311.StrType)le.OWNER_ST),
    Input_CA_Santa_Clara_Fields.InValid_OWNER_ZIP((SALT311.StrType)le.OWNER_ZIP),
    Input_CA_Santa_Clara_Fields.InValid_Owner_title((SALT311.StrType)le.Owner_title),
    Input_CA_Santa_Clara_Fields.InValid_Owner_fname((SALT311.StrType)le.Owner_fname),
    Input_CA_Santa_Clara_Fields.InValid_Owner_mname((SALT311.StrType)le.Owner_mname),
    Input_CA_Santa_Clara_Fields.InValid_Owner_lname((SALT311.StrType)le.Owner_lname),
    Input_CA_Santa_Clara_Fields.InValid_Owner_name_suffix((SALT311.StrType)le.Owner_name_suffix),
    Input_CA_Santa_Clara_Fields.InValid_Owner_name_score((SALT311.StrType)le.Owner_name_score),
    Input_CA_Santa_Clara_Fields.InValid_prep_addr_line1((SALT311.StrType)le.prep_addr_line1),
    Input_CA_Santa_Clara_Fields.InValid_prep_addr_line_last((SALT311.StrType)le.prep_addr_line_last),
    Input_CA_Santa_Clara_Fields.InValid_prep_owner_addr_line1((SALT311.StrType)le.prep_owner_addr_line1),
    Input_CA_Santa_Clara_Fields.InValid_prep_owner_addr_line_last((SALT311.StrType)le.prep_owner_addr_line_last),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,38,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_CA_Santa_Clara_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','invalid_past_date','Unknown','invalid_mandatory','invalid_mandatory','Unknown','invalid_past_date','Unknown','Unknown','invalid_mandatory','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_mandatory','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_mandatory','invalid_mandatory','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_CA_Santa_Clara_Fields.InValidMessage_status(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_FIlED_DATE(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_FBN_TYPE(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_FILING_TYPE(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_BUSINESS_NAME(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_BUSINESS_TYPE(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_ORIG_FILED_DATE(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_ORIG_FBN_NUM(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_RECORD_CODE1(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_FBN_NUM(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_BUSINESS_ADDR1(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_RECORD_CODE2(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_BUSINESS_ADDR2(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_RECORD_CODE3(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_BUS_CITY(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_BUS_ST(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_BUS_ZIP(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_RECORD_CODE4(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_ADDTL_BUSINESS(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_RECORD_CODE5(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_owner_name(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_OWNER_TYPE(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_RECORD_CODE6(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_OWNER_ADDR1(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_OWNER_CITY(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_OWNER_ST(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_OWNER_ZIP(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_Owner_title(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_Owner_fname(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_Owner_mname(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_Owner_lname(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_Owner_name_suffix(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_Owner_name_score(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_prep_addr_line_last(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_prep_owner_addr_line1(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_prep_owner_addr_line_last(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FBNV2, Input_CA_Santa_Clara_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
