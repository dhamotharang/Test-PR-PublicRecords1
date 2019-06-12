IMPORT SALT37;
EXPORT Input_FL_Filing_hygiene(dataset(Input_FL_Filing_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_fic_fil_name_pcnt := AVE(GROUP,IF(h.fic_fil_name = (TYPEOF(h.fic_fil_name))'',0,100));
    maxlength_fic_fil_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_fil_name)));
    avelength_fic_fil_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_fil_name)),h.fic_fil_name<>(typeof(h.fic_fil_name))'');
    populated_fic_owner_name_pcnt := AVE(GROUP,IF(h.fic_owner_name = (TYPEOF(h.fic_owner_name))'',0,100));
    maxlength_fic_owner_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_owner_name)));
    avelength_fic_owner_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_owner_name)),h.fic_owner_name<>(typeof(h.fic_owner_name))'');
    populated_fic_fil_date_pcnt := AVE(GROUP,IF(h.fic_fil_date = (TYPEOF(h.fic_fil_date))'',0,100));
    maxlength_fic_fil_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_fil_date)));
    avelength_fic_fil_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_fil_date)),h.fic_fil_date<>(typeof(h.fic_fil_date))'');
    populated_fic_fil_doc_num_pcnt := AVE(GROUP,IF(h.fic_fil_doc_num = (TYPEOF(h.fic_fil_doc_num))'',0,100));
    maxlength_fic_fil_doc_num := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_fil_doc_num)));
    avelength_fic_fil_doc_num := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_fil_doc_num)),h.fic_fil_doc_num<>(typeof(h.fic_fil_doc_num))'');
    populated_fic_owner_doc_num_pcnt := AVE(GROUP,IF(h.fic_owner_doc_num = (TYPEOF(h.fic_owner_doc_num))'',0,100));
    maxlength_fic_owner_doc_num := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_owner_doc_num)));
    avelength_fic_owner_doc_num := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_owner_doc_num)),h.fic_owner_doc_num<>(typeof(h.fic_owner_doc_num))'');
    populated_p_owner_name_pcnt := AVE(GROUP,IF(h.p_owner_name = (TYPEOF(h.p_owner_name))'',0,100));
    maxlength_p_owner_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.p_owner_name)));
    avelength_p_owner_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.p_owner_name)),h.p_owner_name<>(typeof(h.p_owner_name))'');
    populated_c_owner_name_pcnt := AVE(GROUP,IF(h.c_owner_name = (TYPEOF(h.c_owner_name))'',0,100));
    maxlength_c_owner_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.c_owner_name)));
    avelength_c_owner_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.c_owner_name)),h.c_owner_name<>(typeof(h.c_owner_name))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_addr_line_last = (TYPEOF(h.prep_addr_line_last))'',0,100));
    maxlength_prep_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line_last)));
    avelength_prep_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line_last)),h.prep_addr_line_last<>(typeof(h.prep_addr_line_last))'');
    populated_prep_owner_addr_line1_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line1 = (TYPEOF(h.prep_owner_addr_line1))'',0,100));
    maxlength_prep_owner_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line1)));
    avelength_prep_owner_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line1)),h.prep_owner_addr_line1<>(typeof(h.prep_owner_addr_line1))'');
    populated_prep_owner_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line_last = (TYPEOF(h.prep_owner_addr_line_last))'',0,100));
    maxlength_prep_owner_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line_last)));
    avelength_prep_owner_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line_last)),h.prep_owner_addr_line_last<>(typeof(h.prep_owner_addr_line_last))'');
    populated_seq_pcnt := AVE(GROUP,IF(h.seq = (TYPEOF(h.seq))'',0,100));
    maxlength_seq := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.seq)));
    avelength_seq := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.seq)),h.seq<>(typeof(h.seq))'');
    populated_FIC_FIL_COUNTY_pcnt := AVE(GROUP,IF(h.FIC_FIL_COUNTY = (TYPEOF(h.FIC_FIL_COUNTY))'',0,100));
    maxlength_FIC_FIL_COUNTY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_COUNTY)));
    avelength_FIC_FIL_COUNTY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_COUNTY)),h.FIC_FIL_COUNTY<>(typeof(h.FIC_FIL_COUNTY))'');
    populated_FIC_FIL_ADDR1_pcnt := AVE(GROUP,IF(h.FIC_FIL_ADDR1 = (TYPEOF(h.FIC_FIL_ADDR1))'',0,100));
    maxlength_FIC_FIL_ADDR1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_ADDR1)));
    avelength_FIC_FIL_ADDR1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_ADDR1)),h.FIC_FIL_ADDR1<>(typeof(h.FIC_FIL_ADDR1))'');
    populated_FIC_FIL_ADDR2_pcnt := AVE(GROUP,IF(h.FIC_FIL_ADDR2 = (TYPEOF(h.FIC_FIL_ADDR2))'',0,100));
    maxlength_FIC_FIL_ADDR2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_ADDR2)));
    avelength_FIC_FIL_ADDR2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_ADDR2)),h.FIC_FIL_ADDR2<>(typeof(h.FIC_FIL_ADDR2))'');
    populated_FIC_FIL_CITY_pcnt := AVE(GROUP,IF(h.FIC_FIL_CITY = (TYPEOF(h.FIC_FIL_CITY))'',0,100));
    maxlength_FIC_FIL_CITY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_CITY)));
    avelength_FIC_FIL_CITY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_CITY)),h.FIC_FIL_CITY<>(typeof(h.FIC_FIL_CITY))'');
    populated_FIC_FIL_STATE_pcnt := AVE(GROUP,IF(h.FIC_FIL_STATE = (TYPEOF(h.FIC_FIL_STATE))'',0,100));
    maxlength_FIC_FIL_STATE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_STATE)));
    avelength_FIC_FIL_STATE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_STATE)),h.FIC_FIL_STATE<>(typeof(h.FIC_FIL_STATE))'');
    populated_FIC_FIL_ZIP5_pcnt := AVE(GROUP,IF(h.FIC_FIL_ZIP5 = (TYPEOF(h.FIC_FIL_ZIP5))'',0,100));
    maxlength_FIC_FIL_ZIP5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_ZIP5)));
    avelength_FIC_FIL_ZIP5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_ZIP5)),h.FIC_FIL_ZIP5<>(typeof(h.FIC_FIL_ZIP5))'');
    populated_FIC_FIL_ZIP4_pcnt := AVE(GROUP,IF(h.FIC_FIL_ZIP4 = (TYPEOF(h.FIC_FIL_ZIP4))'',0,100));
    maxlength_FIC_FIL_ZIP4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_ZIP4)));
    avelength_FIC_FIL_ZIP4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_ZIP4)),h.FIC_FIL_ZIP4<>(typeof(h.FIC_FIL_ZIP4))'');
    populated_FIC_FIL_COUNTRY_pcnt := AVE(GROUP,IF(h.FIC_FIL_COUNTRY = (TYPEOF(h.FIC_FIL_COUNTRY))'',0,100));
    maxlength_FIC_FIL_COUNTRY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_COUNTRY)));
    avelength_FIC_FIL_COUNTRY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_COUNTRY)),h.FIC_FIL_COUNTRY<>(typeof(h.FIC_FIL_COUNTRY))'');
    populated_FIC_FIL_COUNTRY_DEC_pcnt := AVE(GROUP,IF(h.FIC_FIL_COUNTRY_DEC = (TYPEOF(h.FIC_FIL_COUNTRY_DEC))'',0,100));
    maxlength_FIC_FIL_COUNTRY_DEC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_COUNTRY_DEC)));
    avelength_FIC_FIL_COUNTRY_DEC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_COUNTRY_DEC)),h.FIC_FIL_COUNTRY_DEC<>(typeof(h.FIC_FIL_COUNTRY_DEC))'');
    populated_FIC_FIL_PAGES_pcnt := AVE(GROUP,IF(h.FIC_FIL_PAGES = (TYPEOF(h.FIC_FIL_PAGES))'',0,100));
    maxlength_FIC_FIL_PAGES := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_PAGES)));
    avelength_FIC_FIL_PAGES := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_PAGES)),h.FIC_FIL_PAGES<>(typeof(h.FIC_FIL_PAGES))'');
    populated_FIC_FIL_STATUS_pcnt := AVE(GROUP,IF(h.FIC_FIL_STATUS = (TYPEOF(h.FIC_FIL_STATUS))'',0,100));
    maxlength_FIC_FIL_STATUS := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_STATUS)));
    avelength_FIC_FIL_STATUS := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_STATUS)),h.FIC_FIL_STATUS<>(typeof(h.FIC_FIL_STATUS))'');
    populated_FIC_FIL_STATUS_DEC_pcnt := AVE(GROUP,IF(h.FIC_FIL_STATUS_DEC = (TYPEOF(h.FIC_FIL_STATUS_DEC))'',0,100));
    maxlength_FIC_FIL_STATUS_DEC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_STATUS_DEC)));
    avelength_FIC_FIL_STATUS_DEC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_STATUS_DEC)),h.FIC_FIL_STATUS_DEC<>(typeof(h.FIC_FIL_STATUS_DEC))'');
    populated_FIC_FIL_CANCELLATION_DATE_pcnt := AVE(GROUP,IF(h.FIC_FIL_CANCELLATION_DATE = (TYPEOF(h.FIC_FIL_CANCELLATION_DATE))'',0,100));
    maxlength_FIC_FIL_CANCELLATION_DATE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_CANCELLATION_DATE)));
    avelength_FIC_FIL_CANCELLATION_DATE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_CANCELLATION_DATE)),h.FIC_FIL_CANCELLATION_DATE<>(typeof(h.FIC_FIL_CANCELLATION_DATE))'');
    populated_FIC_FIL_EXPIRATION_DATE_pcnt := AVE(GROUP,IF(h.FIC_FIL_EXPIRATION_DATE = (TYPEOF(h.FIC_FIL_EXPIRATION_DATE))'',0,100));
    maxlength_FIC_FIL_EXPIRATION_DATE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_EXPIRATION_DATE)));
    avelength_FIC_FIL_EXPIRATION_DATE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_EXPIRATION_DATE)),h.FIC_FIL_EXPIRATION_DATE<>(typeof(h.FIC_FIL_EXPIRATION_DATE))'');
    populated_FIC_FIL_TOTAL_OWN_CUR_CTR_pcnt := AVE(GROUP,IF(h.FIC_FIL_TOTAL_OWN_CUR_CTR = (TYPEOF(h.FIC_FIL_TOTAL_OWN_CUR_CTR))'',0,100));
    maxlength_FIC_FIL_TOTAL_OWN_CUR_CTR := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_TOTAL_OWN_CUR_CTR)));
    avelength_FIC_FIL_TOTAL_OWN_CUR_CTR := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_TOTAL_OWN_CUR_CTR)),h.FIC_FIL_TOTAL_OWN_CUR_CTR<>(typeof(h.FIC_FIL_TOTAL_OWN_CUR_CTR))'');
    populated_FIC_FIL_FEI_NUM_pcnt := AVE(GROUP,IF(h.FIC_FIL_FEI_NUM = (TYPEOF(h.FIC_FIL_FEI_NUM))'',0,100));
    maxlength_FIC_FIL_FEI_NUM := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_FEI_NUM)));
    avelength_FIC_FIL_FEI_NUM := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_FIL_FEI_NUM)),h.FIC_FIL_FEI_NUM<>(typeof(h.FIC_FIL_FEI_NUM))'');
    populated_FIC_GREATER_THAN__OWNERS_pcnt := AVE(GROUP,IF(h.FIC_GREATER_THAN__OWNERS = (TYPEOF(h.FIC_GREATER_THAN__OWNERS))'',0,100));
    maxlength_FIC_GREATER_THAN__OWNERS := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_GREATER_THAN__OWNERS)));
    avelength_FIC_GREATER_THAN__OWNERS := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_GREATER_THAN__OWNERS)),h.FIC_GREATER_THAN__OWNERS<>(typeof(h.FIC_GREATER_THAN__OWNERS))'');
    populated_FIC_OWNER_NAME_FORMAT_pcnt := AVE(GROUP,IF(h.FIC_OWNER_NAME_FORMAT = (TYPEOF(h.FIC_OWNER_NAME_FORMAT))'',0,100));
    maxlength_FIC_OWNER_NAME_FORMAT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_NAME_FORMAT)));
    avelength_FIC_OWNER_NAME_FORMAT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_NAME_FORMAT)),h.FIC_OWNER_NAME_FORMAT<>(typeof(h.FIC_OWNER_NAME_FORMAT))'');
    populated_FIC_OWNER_ADDR_pcnt := AVE(GROUP,IF(h.FIC_OWNER_ADDR = (TYPEOF(h.FIC_OWNER_ADDR))'',0,100));
    maxlength_FIC_OWNER_ADDR := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_ADDR)));
    avelength_FIC_OWNER_ADDR := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_ADDR)),h.FIC_OWNER_ADDR<>(typeof(h.FIC_OWNER_ADDR))'');
    populated_FIC_OWNER_CITY_pcnt := AVE(GROUP,IF(h.FIC_OWNER_CITY = (TYPEOF(h.FIC_OWNER_CITY))'',0,100));
    maxlength_FIC_OWNER_CITY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_CITY)));
    avelength_FIC_OWNER_CITY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_CITY)),h.FIC_OWNER_CITY<>(typeof(h.FIC_OWNER_CITY))'');
    populated_FIC_OWNER_STATE_pcnt := AVE(GROUP,IF(h.FIC_OWNER_STATE = (TYPEOF(h.FIC_OWNER_STATE))'',0,100));
    maxlength_FIC_OWNER_STATE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_STATE)));
    avelength_FIC_OWNER_STATE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_STATE)),h.FIC_OWNER_STATE<>(typeof(h.FIC_OWNER_STATE))'');
    populated_FIC_OWNER_ZIP5_pcnt := AVE(GROUP,IF(h.FIC_OWNER_ZIP5 = (TYPEOF(h.FIC_OWNER_ZIP5))'',0,100));
    maxlength_FIC_OWNER_ZIP5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_ZIP5)));
    avelength_FIC_OWNER_ZIP5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_ZIP5)),h.FIC_OWNER_ZIP5<>(typeof(h.FIC_OWNER_ZIP5))'');
    populated_FIC_OWNER_ZIP4_pcnt := AVE(GROUP,IF(h.FIC_OWNER_ZIP4 = (TYPEOF(h.FIC_OWNER_ZIP4))'',0,100));
    maxlength_FIC_OWNER_ZIP4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_ZIP4)));
    avelength_FIC_OWNER_ZIP4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_ZIP4)),h.FIC_OWNER_ZIP4<>(typeof(h.FIC_OWNER_ZIP4))'');
    populated_FIC_OWNER_COUNTRY_pcnt := AVE(GROUP,IF(h.FIC_OWNER_COUNTRY = (TYPEOF(h.FIC_OWNER_COUNTRY))'',0,100));
    maxlength_FIC_OWNER_COUNTRY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_COUNTRY)));
    avelength_FIC_OWNER_COUNTRY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_COUNTRY)),h.FIC_OWNER_COUNTRY<>(typeof(h.FIC_OWNER_COUNTRY))'');
    populated_FIC_OWNER_COUNTRY_DEC_pcnt := AVE(GROUP,IF(h.FIC_OWNER_COUNTRY_DEC = (TYPEOF(h.FIC_OWNER_COUNTRY_DEC))'',0,100));
    maxlength_FIC_OWNER_COUNTRY_DEC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_COUNTRY_DEC)));
    avelength_FIC_OWNER_COUNTRY_DEC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_COUNTRY_DEC)),h.FIC_OWNER_COUNTRY_DEC<>(typeof(h.FIC_OWNER_COUNTRY_DEC))'');
    populated_FIC_OWNER_FEI_NUM_pcnt := AVE(GROUP,IF(h.FIC_OWNER_FEI_NUM = (TYPEOF(h.FIC_OWNER_FEI_NUM))'',0,100));
    maxlength_FIC_OWNER_FEI_NUM := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_FEI_NUM)));
    avelength_FIC_OWNER_FEI_NUM := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_FEI_NUM)),h.FIC_OWNER_FEI_NUM<>(typeof(h.FIC_OWNER_FEI_NUM))'');
    populated_FIC_OWNER_CHARTER_NUM_pcnt := AVE(GROUP,IF(h.FIC_OWNER_CHARTER_NUM = (TYPEOF(h.FIC_OWNER_CHARTER_NUM))'',0,100));
    maxlength_FIC_OWNER_CHARTER_NUM := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_CHARTER_NUM)));
    avelength_FIC_OWNER_CHARTER_NUM := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FIC_OWNER_CHARTER_NUM)),h.FIC_OWNER_CHARTER_NUM<>(typeof(h.FIC_OWNER_CHARTER_NUM))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_fic_fil_name_pcnt *   0.00 / 100 + T.Populated_fic_owner_name_pcnt *   0.00 / 100 + T.Populated_fic_fil_date_pcnt *   0.00 / 100 + T.Populated_fic_fil_doc_num_pcnt *   0.00 / 100 + T.Populated_fic_owner_doc_num_pcnt *   0.00 / 100 + T.Populated_p_owner_name_pcnt *   0.00 / 100 + T.Populated_c_owner_name_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_line_last_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line_last_pcnt *   0.00 / 100 + T.Populated_seq_pcnt *   0.00 / 100 + T.Populated_FIC_FIL_COUNTY_pcnt *   0.00 / 100 + T.Populated_FIC_FIL_ADDR1_pcnt *   0.00 / 100 + T.Populated_FIC_FIL_ADDR2_pcnt *   0.00 / 100 + T.Populated_FIC_FIL_CITY_pcnt *   0.00 / 100 + T.Populated_FIC_FIL_STATE_pcnt *   0.00 / 100 + T.Populated_FIC_FIL_ZIP5_pcnt *   0.00 / 100 + T.Populated_FIC_FIL_ZIP4_pcnt *   0.00 / 100 + T.Populated_FIC_FIL_COUNTRY_pcnt *   0.00 / 100 + T.Populated_FIC_FIL_COUNTRY_DEC_pcnt *   0.00 / 100 + T.Populated_FIC_FIL_PAGES_pcnt *   0.00 / 100 + T.Populated_FIC_FIL_STATUS_pcnt *   0.00 / 100 + T.Populated_FIC_FIL_STATUS_DEC_pcnt *   0.00 / 100 + T.Populated_FIC_FIL_CANCELLATION_DATE_pcnt *   0.00 / 100 + T.Populated_FIC_FIL_EXPIRATION_DATE_pcnt *   0.00 / 100 + T.Populated_FIC_FIL_TOTAL_OWN_CUR_CTR_pcnt *   0.00 / 100 + T.Populated_FIC_FIL_FEI_NUM_pcnt *   0.00 / 100 + T.Populated_FIC_GREATER_THAN__OWNERS_pcnt *   0.00 / 100 + T.Populated_FIC_OWNER_NAME_FORMAT_pcnt *   0.00 / 100 + T.Populated_FIC_OWNER_ADDR_pcnt *   0.00 / 100 + T.Populated_FIC_OWNER_CITY_pcnt *   0.00 / 100 + T.Populated_FIC_OWNER_STATE_pcnt *   0.00 / 100 + T.Populated_FIC_OWNER_ZIP5_pcnt *   0.00 / 100 + T.Populated_FIC_OWNER_ZIP4_pcnt *   0.00 / 100 + T.Populated_FIC_OWNER_COUNTRY_pcnt *   0.00 / 100 + T.Populated_FIC_OWNER_COUNTRY_DEC_pcnt *   0.00 / 100 + T.Populated_FIC_OWNER_FEI_NUM_pcnt *   0.00 / 100 + T.Populated_FIC_OWNER_CHARTER_NUM_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT37.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'fic_fil_name','fic_owner_name','fic_fil_date','fic_fil_doc_num','fic_owner_doc_num','p_owner_name','c_owner_name','prep_addr_line1','prep_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last','seq','FIC_FIL_COUNTY','FIC_FIL_ADDR1','FIC_FIL_ADDR2','FIC_FIL_CITY','FIC_FIL_STATE','FIC_FIL_ZIP5','FIC_FIL_ZIP4','FIC_FIL_COUNTRY','FIC_FIL_COUNTRY_DEC','FIC_FIL_PAGES','FIC_FIL_STATUS','FIC_FIL_STATUS_DEC','FIC_FIL_CANCELLATION_DATE','FIC_FIL_EXPIRATION_DATE','FIC_FIL_TOTAL_OWN_CUR_CTR','FIC_FIL_FEI_NUM','FIC_GREATER_THAN__OWNERS','FIC_OWNER_NAME_FORMAT','FIC_OWNER_ADDR','FIC_OWNER_CITY','FIC_OWNER_STATE','FIC_OWNER_ZIP5','FIC_OWNER_ZIP4','FIC_OWNER_COUNTRY','FIC_OWNER_COUNTRY_DEC','FIC_OWNER_FEI_NUM','FIC_OWNER_CHARTER_NUM');
  SELF.populated_pcnt := CHOOSE(C,le.populated_fic_fil_name_pcnt,le.populated_fic_owner_name_pcnt,le.populated_fic_fil_date_pcnt,le.populated_fic_fil_doc_num_pcnt,le.populated_fic_owner_doc_num_pcnt,le.populated_p_owner_name_pcnt,le.populated_c_owner_name_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_line_last_pcnt,le.populated_prep_owner_addr_line1_pcnt,le.populated_prep_owner_addr_line_last_pcnt,le.populated_seq_pcnt,le.populated_FIC_FIL_COUNTY_pcnt,le.populated_FIC_FIL_ADDR1_pcnt,le.populated_FIC_FIL_ADDR2_pcnt,le.populated_FIC_FIL_CITY_pcnt,le.populated_FIC_FIL_STATE_pcnt,le.populated_FIC_FIL_ZIP5_pcnt,le.populated_FIC_FIL_ZIP4_pcnt,le.populated_FIC_FIL_COUNTRY_pcnt,le.populated_FIC_FIL_COUNTRY_DEC_pcnt,le.populated_FIC_FIL_PAGES_pcnt,le.populated_FIC_FIL_STATUS_pcnt,le.populated_FIC_FIL_STATUS_DEC_pcnt,le.populated_FIC_FIL_CANCELLATION_DATE_pcnt,le.populated_FIC_FIL_EXPIRATION_DATE_pcnt,le.populated_FIC_FIL_TOTAL_OWN_CUR_CTR_pcnt,le.populated_FIC_FIL_FEI_NUM_pcnt,le.populated_FIC_GREATER_THAN__OWNERS_pcnt,le.populated_FIC_OWNER_NAME_FORMAT_pcnt,le.populated_FIC_OWNER_ADDR_pcnt,le.populated_FIC_OWNER_CITY_pcnt,le.populated_FIC_OWNER_STATE_pcnt,le.populated_FIC_OWNER_ZIP5_pcnt,le.populated_FIC_OWNER_ZIP4_pcnt,le.populated_FIC_OWNER_COUNTRY_pcnt,le.populated_FIC_OWNER_COUNTRY_DEC_pcnt,le.populated_FIC_OWNER_FEI_NUM_pcnt,le.populated_FIC_OWNER_CHARTER_NUM_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_fic_fil_name,le.maxlength_fic_owner_name,le.maxlength_fic_fil_date,le.maxlength_fic_fil_doc_num,le.maxlength_fic_owner_doc_num,le.maxlength_p_owner_name,le.maxlength_c_owner_name,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_line_last,le.maxlength_prep_owner_addr_line1,le.maxlength_prep_owner_addr_line_last,le.maxlength_seq,le.maxlength_FIC_FIL_COUNTY,le.maxlength_FIC_FIL_ADDR1,le.maxlength_FIC_FIL_ADDR2,le.maxlength_FIC_FIL_CITY,le.maxlength_FIC_FIL_STATE,le.maxlength_FIC_FIL_ZIP5,le.maxlength_FIC_FIL_ZIP4,le.maxlength_FIC_FIL_COUNTRY,le.maxlength_FIC_FIL_COUNTRY_DEC,le.maxlength_FIC_FIL_PAGES,le.maxlength_FIC_FIL_STATUS,le.maxlength_FIC_FIL_STATUS_DEC,le.maxlength_FIC_FIL_CANCELLATION_DATE,le.maxlength_FIC_FIL_EXPIRATION_DATE,le.maxlength_FIC_FIL_TOTAL_OWN_CUR_CTR,le.maxlength_FIC_FIL_FEI_NUM,le.maxlength_FIC_GREATER_THAN__OWNERS,le.maxlength_FIC_OWNER_NAME_FORMAT,le.maxlength_FIC_OWNER_ADDR,le.maxlength_FIC_OWNER_CITY,le.maxlength_FIC_OWNER_STATE,le.maxlength_FIC_OWNER_ZIP5,le.maxlength_FIC_OWNER_ZIP4,le.maxlength_FIC_OWNER_COUNTRY,le.maxlength_FIC_OWNER_COUNTRY_DEC,le.maxlength_FIC_OWNER_FEI_NUM,le.maxlength_FIC_OWNER_CHARTER_NUM);
  SELF.avelength := CHOOSE(C,le.avelength_fic_fil_name,le.avelength_fic_owner_name,le.avelength_fic_fil_date,le.avelength_fic_fil_doc_num,le.avelength_fic_owner_doc_num,le.avelength_p_owner_name,le.avelength_c_owner_name,le.avelength_prep_addr_line1,le.avelength_prep_addr_line_last,le.avelength_prep_owner_addr_line1,le.avelength_prep_owner_addr_line_last,le.avelength_seq,le.avelength_FIC_FIL_COUNTY,le.avelength_FIC_FIL_ADDR1,le.avelength_FIC_FIL_ADDR2,le.avelength_FIC_FIL_CITY,le.avelength_FIC_FIL_STATE,le.avelength_FIC_FIL_ZIP5,le.avelength_FIC_FIL_ZIP4,le.avelength_FIC_FIL_COUNTRY,le.avelength_FIC_FIL_COUNTRY_DEC,le.avelength_FIC_FIL_PAGES,le.avelength_FIC_FIL_STATUS,le.avelength_FIC_FIL_STATUS_DEC,le.avelength_FIC_FIL_CANCELLATION_DATE,le.avelength_FIC_FIL_EXPIRATION_DATE,le.avelength_FIC_FIL_TOTAL_OWN_CUR_CTR,le.avelength_FIC_FIL_FEI_NUM,le.avelength_FIC_GREATER_THAN__OWNERS,le.avelength_FIC_OWNER_NAME_FORMAT,le.avelength_FIC_OWNER_ADDR,le.avelength_FIC_OWNER_CITY,le.avelength_FIC_OWNER_STATE,le.avelength_FIC_OWNER_ZIP5,le.avelength_FIC_OWNER_ZIP4,le.avelength_FIC_OWNER_COUNTRY,le.avelength_FIC_OWNER_COUNTRY_DEC,le.avelength_FIC_OWNER_FEI_NUM,le.avelength_FIC_OWNER_CHARTER_NUM);
END;
EXPORT invSummary := NORMALIZE(summary0, 39, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.fic_fil_name),TRIM((SALT37.StrType)le.fic_owner_name),TRIM((SALT37.StrType)le.fic_fil_date),TRIM((SALT37.StrType)le.fic_fil_doc_num),TRIM((SALT37.StrType)le.fic_owner_doc_num),TRIM((SALT37.StrType)le.p_owner_name),TRIM((SALT37.StrType)le.c_owner_name),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last),TRIM((SALT37.StrType)le.seq),TRIM((SALT37.StrType)le.FIC_FIL_COUNTY),TRIM((SALT37.StrType)le.FIC_FIL_ADDR1),TRIM((SALT37.StrType)le.FIC_FIL_ADDR2),TRIM((SALT37.StrType)le.FIC_FIL_CITY),TRIM((SALT37.StrType)le.FIC_FIL_STATE),TRIM((SALT37.StrType)le.FIC_FIL_ZIP5),TRIM((SALT37.StrType)le.FIC_FIL_ZIP4),TRIM((SALT37.StrType)le.FIC_FIL_COUNTRY),TRIM((SALT37.StrType)le.FIC_FIL_COUNTRY_DEC),TRIM((SALT37.StrType)le.FIC_FIL_PAGES),TRIM((SALT37.StrType)le.FIC_FIL_STATUS),TRIM((SALT37.StrType)le.FIC_FIL_STATUS_DEC),TRIM((SALT37.StrType)le.FIC_FIL_CANCELLATION_DATE),TRIM((SALT37.StrType)le.FIC_FIL_EXPIRATION_DATE),TRIM((SALT37.StrType)le.FIC_FIL_TOTAL_OWN_CUR_CTR),TRIM((SALT37.StrType)le.FIC_FIL_FEI_NUM),TRIM((SALT37.StrType)le.FIC_GREATER_THAN__OWNERS),TRIM((SALT37.StrType)le.FIC_OWNER_NAME_FORMAT),TRIM((SALT37.StrType)le.FIC_OWNER_ADDR),TRIM((SALT37.StrType)le.FIC_OWNER_CITY),TRIM((SALT37.StrType)le.FIC_OWNER_STATE),TRIM((SALT37.StrType)le.FIC_OWNER_ZIP5),TRIM((SALT37.StrType)le.FIC_OWNER_ZIP4),TRIM((SALT37.StrType)le.FIC_OWNER_COUNTRY),TRIM((SALT37.StrType)le.FIC_OWNER_COUNTRY_DEC),TRIM((SALT37.StrType)le.FIC_OWNER_FEI_NUM),TRIM((SALT37.StrType)le.FIC_OWNER_CHARTER_NUM)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,39,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 39);
  SELF.FldNo2 := 1 + (C % 39);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.fic_fil_name),TRIM((SALT37.StrType)le.fic_owner_name),TRIM((SALT37.StrType)le.fic_fil_date),TRIM((SALT37.StrType)le.fic_fil_doc_num),TRIM((SALT37.StrType)le.fic_owner_doc_num),TRIM((SALT37.StrType)le.p_owner_name),TRIM((SALT37.StrType)le.c_owner_name),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last),TRIM((SALT37.StrType)le.seq),TRIM((SALT37.StrType)le.FIC_FIL_COUNTY),TRIM((SALT37.StrType)le.FIC_FIL_ADDR1),TRIM((SALT37.StrType)le.FIC_FIL_ADDR2),TRIM((SALT37.StrType)le.FIC_FIL_CITY),TRIM((SALT37.StrType)le.FIC_FIL_STATE),TRIM((SALT37.StrType)le.FIC_FIL_ZIP5),TRIM((SALT37.StrType)le.FIC_FIL_ZIP4),TRIM((SALT37.StrType)le.FIC_FIL_COUNTRY),TRIM((SALT37.StrType)le.FIC_FIL_COUNTRY_DEC),TRIM((SALT37.StrType)le.FIC_FIL_PAGES),TRIM((SALT37.StrType)le.FIC_FIL_STATUS),TRIM((SALT37.StrType)le.FIC_FIL_STATUS_DEC),TRIM((SALT37.StrType)le.FIC_FIL_CANCELLATION_DATE),TRIM((SALT37.StrType)le.FIC_FIL_EXPIRATION_DATE),TRIM((SALT37.StrType)le.FIC_FIL_TOTAL_OWN_CUR_CTR),TRIM((SALT37.StrType)le.FIC_FIL_FEI_NUM),TRIM((SALT37.StrType)le.FIC_GREATER_THAN__OWNERS),TRIM((SALT37.StrType)le.FIC_OWNER_NAME_FORMAT),TRIM((SALT37.StrType)le.FIC_OWNER_ADDR),TRIM((SALT37.StrType)le.FIC_OWNER_CITY),TRIM((SALT37.StrType)le.FIC_OWNER_STATE),TRIM((SALT37.StrType)le.FIC_OWNER_ZIP5),TRIM((SALT37.StrType)le.FIC_OWNER_ZIP4),TRIM((SALT37.StrType)le.FIC_OWNER_COUNTRY),TRIM((SALT37.StrType)le.FIC_OWNER_COUNTRY_DEC),TRIM((SALT37.StrType)le.FIC_OWNER_FEI_NUM),TRIM((SALT37.StrType)le.FIC_OWNER_CHARTER_NUM)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.fic_fil_name),TRIM((SALT37.StrType)le.fic_owner_name),TRIM((SALT37.StrType)le.fic_fil_date),TRIM((SALT37.StrType)le.fic_fil_doc_num),TRIM((SALT37.StrType)le.fic_owner_doc_num),TRIM((SALT37.StrType)le.p_owner_name),TRIM((SALT37.StrType)le.c_owner_name),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last),TRIM((SALT37.StrType)le.seq),TRIM((SALT37.StrType)le.FIC_FIL_COUNTY),TRIM((SALT37.StrType)le.FIC_FIL_ADDR1),TRIM((SALT37.StrType)le.FIC_FIL_ADDR2),TRIM((SALT37.StrType)le.FIC_FIL_CITY),TRIM((SALT37.StrType)le.FIC_FIL_STATE),TRIM((SALT37.StrType)le.FIC_FIL_ZIP5),TRIM((SALT37.StrType)le.FIC_FIL_ZIP4),TRIM((SALT37.StrType)le.FIC_FIL_COUNTRY),TRIM((SALT37.StrType)le.FIC_FIL_COUNTRY_DEC),TRIM((SALT37.StrType)le.FIC_FIL_PAGES),TRIM((SALT37.StrType)le.FIC_FIL_STATUS),TRIM((SALT37.StrType)le.FIC_FIL_STATUS_DEC),TRIM((SALT37.StrType)le.FIC_FIL_CANCELLATION_DATE),TRIM((SALT37.StrType)le.FIC_FIL_EXPIRATION_DATE),TRIM((SALT37.StrType)le.FIC_FIL_TOTAL_OWN_CUR_CTR),TRIM((SALT37.StrType)le.FIC_FIL_FEI_NUM),TRIM((SALT37.StrType)le.FIC_GREATER_THAN__OWNERS),TRIM((SALT37.StrType)le.FIC_OWNER_NAME_FORMAT),TRIM((SALT37.StrType)le.FIC_OWNER_ADDR),TRIM((SALT37.StrType)le.FIC_OWNER_CITY),TRIM((SALT37.StrType)le.FIC_OWNER_STATE),TRIM((SALT37.StrType)le.FIC_OWNER_ZIP5),TRIM((SALT37.StrType)le.FIC_OWNER_ZIP4),TRIM((SALT37.StrType)le.FIC_OWNER_COUNTRY),TRIM((SALT37.StrType)le.FIC_OWNER_COUNTRY_DEC),TRIM((SALT37.StrType)le.FIC_OWNER_FEI_NUM),TRIM((SALT37.StrType)le.FIC_OWNER_CHARTER_NUM)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),39*39,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'fic_fil_name'}
      ,{2,'fic_owner_name'}
      ,{3,'fic_fil_date'}
      ,{4,'fic_fil_doc_num'}
      ,{5,'fic_owner_doc_num'}
      ,{6,'p_owner_name'}
      ,{7,'c_owner_name'}
      ,{8,'prep_addr_line1'}
      ,{9,'prep_addr_line_last'}
      ,{10,'prep_owner_addr_line1'}
      ,{11,'prep_owner_addr_line_last'}
      ,{12,'seq'}
      ,{13,'FIC_FIL_COUNTY'}
      ,{14,'FIC_FIL_ADDR1'}
      ,{15,'FIC_FIL_ADDR2'}
      ,{16,'FIC_FIL_CITY'}
      ,{17,'FIC_FIL_STATE'}
      ,{18,'FIC_FIL_ZIP5'}
      ,{19,'FIC_FIL_ZIP4'}
      ,{20,'FIC_FIL_COUNTRY'}
      ,{21,'FIC_FIL_COUNTRY_DEC'}
      ,{22,'FIC_FIL_PAGES'}
      ,{23,'FIC_FIL_STATUS'}
      ,{24,'FIC_FIL_STATUS_DEC'}
      ,{25,'FIC_FIL_CANCELLATION_DATE'}
      ,{26,'FIC_FIL_EXPIRATION_DATE'}
      ,{27,'FIC_FIL_TOTAL_OWN_CUR_CTR'}
      ,{28,'FIC_FIL_FEI_NUM'}
      ,{29,'FIC_GREATER_THAN__OWNERS'}
      ,{30,'FIC_OWNER_NAME_FORMAT'}
      ,{31,'FIC_OWNER_ADDR'}
      ,{32,'FIC_OWNER_CITY'}
      ,{33,'FIC_OWNER_STATE'}
      ,{34,'FIC_OWNER_ZIP5'}
      ,{35,'FIC_OWNER_ZIP4'}
      ,{36,'FIC_OWNER_COUNTRY'}
      ,{37,'FIC_OWNER_COUNTRY_DEC'}
      ,{38,'FIC_OWNER_FEI_NUM'}
      ,{39,'FIC_OWNER_CHARTER_NUM'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_FL_Filing_Fields.InValid_fic_fil_name((SALT37.StrType)le.fic_fil_name),
    Input_FL_Filing_Fields.InValid_fic_owner_name((SALT37.StrType)le.fic_owner_name),
    Input_FL_Filing_Fields.InValid_fic_fil_date((SALT37.StrType)le.fic_fil_date),
    Input_FL_Filing_Fields.InValid_fic_fil_doc_num((SALT37.StrType)le.fic_fil_doc_num),
    Input_FL_Filing_Fields.InValid_fic_owner_doc_num((SALT37.StrType)le.fic_owner_doc_num),
    Input_FL_Filing_Fields.InValid_p_owner_name((SALT37.StrType)le.p_owner_name),
    Input_FL_Filing_Fields.InValid_c_owner_name((SALT37.StrType)le.c_owner_name),
    Input_FL_Filing_Fields.InValid_prep_addr_line1((SALT37.StrType)le.prep_addr_line1),
    Input_FL_Filing_Fields.InValid_prep_addr_line_last((SALT37.StrType)le.prep_addr_line_last),
    Input_FL_Filing_Fields.InValid_prep_owner_addr_line1((SALT37.StrType)le.prep_owner_addr_line1),
    Input_FL_Filing_Fields.InValid_prep_owner_addr_line_last((SALT37.StrType)le.prep_owner_addr_line_last),
    Input_FL_Filing_Fields.InValid_seq((SALT37.StrType)le.seq),
    Input_FL_Filing_Fields.InValid_FIC_FIL_COUNTY((SALT37.StrType)le.FIC_FIL_COUNTY),
    Input_FL_Filing_Fields.InValid_FIC_FIL_ADDR1((SALT37.StrType)le.FIC_FIL_ADDR1),
    Input_FL_Filing_Fields.InValid_FIC_FIL_ADDR2((SALT37.StrType)le.FIC_FIL_ADDR2),
    Input_FL_Filing_Fields.InValid_FIC_FIL_CITY((SALT37.StrType)le.FIC_FIL_CITY),
    Input_FL_Filing_Fields.InValid_FIC_FIL_STATE((SALT37.StrType)le.FIC_FIL_STATE),
    Input_FL_Filing_Fields.InValid_FIC_FIL_ZIP5((SALT37.StrType)le.FIC_FIL_ZIP5),
    Input_FL_Filing_Fields.InValid_FIC_FIL_ZIP4((SALT37.StrType)le.FIC_FIL_ZIP4),
    Input_FL_Filing_Fields.InValid_FIC_FIL_COUNTRY((SALT37.StrType)le.FIC_FIL_COUNTRY),
    Input_FL_Filing_Fields.InValid_FIC_FIL_COUNTRY_DEC((SALT37.StrType)le.FIC_FIL_COUNTRY_DEC),
    Input_FL_Filing_Fields.InValid_FIC_FIL_PAGES((SALT37.StrType)le.FIC_FIL_PAGES),
    Input_FL_Filing_Fields.InValid_FIC_FIL_STATUS((SALT37.StrType)le.FIC_FIL_STATUS),
    Input_FL_Filing_Fields.InValid_FIC_FIL_STATUS_DEC((SALT37.StrType)le.FIC_FIL_STATUS_DEC),
    Input_FL_Filing_Fields.InValid_FIC_FIL_CANCELLATION_DATE((SALT37.StrType)le.FIC_FIL_CANCELLATION_DATE),
    Input_FL_Filing_Fields.InValid_FIC_FIL_EXPIRATION_DATE((SALT37.StrType)le.FIC_FIL_EXPIRATION_DATE),
    Input_FL_Filing_Fields.InValid_FIC_FIL_TOTAL_OWN_CUR_CTR((SALT37.StrType)le.FIC_FIL_TOTAL_OWN_CUR_CTR),
    Input_FL_Filing_Fields.InValid_FIC_FIL_FEI_NUM((SALT37.StrType)le.FIC_FIL_FEI_NUM),
    Input_FL_Filing_Fields.InValid_FIC_GREATER_THAN__OWNERS((SALT37.StrType)le.FIC_GREATER_THAN__OWNERS),
    Input_FL_Filing_Fields.InValid_FIC_OWNER_NAME_FORMAT((SALT37.StrType)le.FIC_OWNER_NAME_FORMAT),
    Input_FL_Filing_Fields.InValid_FIC_OWNER_ADDR((SALT37.StrType)le.FIC_OWNER_ADDR),
    Input_FL_Filing_Fields.InValid_FIC_OWNER_CITY((SALT37.StrType)le.FIC_OWNER_CITY),
    Input_FL_Filing_Fields.InValid_FIC_OWNER_STATE((SALT37.StrType)le.FIC_OWNER_STATE),
    Input_FL_Filing_Fields.InValid_FIC_OWNER_ZIP5((SALT37.StrType)le.FIC_OWNER_ZIP5),
    Input_FL_Filing_Fields.InValid_FIC_OWNER_ZIP4((SALT37.StrType)le.FIC_OWNER_ZIP4),
    Input_FL_Filing_Fields.InValid_FIC_OWNER_COUNTRY((SALT37.StrType)le.FIC_OWNER_COUNTRY),
    Input_FL_Filing_Fields.InValid_FIC_OWNER_COUNTRY_DEC((SALT37.StrType)le.FIC_OWNER_COUNTRY_DEC),
    Input_FL_Filing_Fields.InValid_FIC_OWNER_FEI_NUM((SALT37.StrType)le.FIC_OWNER_FEI_NUM),
    Input_FL_Filing_Fields.InValid_FIC_OWNER_CHARTER_NUM((SALT37.StrType)le.FIC_OWNER_CHARTER_NUM),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,39,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_FL_Filing_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_general_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_FL_Filing_Fields.InValidMessage_fic_fil_name(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_fic_owner_name(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_fic_fil_date(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_fic_fil_doc_num(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_fic_owner_doc_num(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_p_owner_name(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_c_owner_name(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_prep_addr_line_last(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_prep_owner_addr_line1(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_prep_owner_addr_line_last(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_seq(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_FIL_COUNTY(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_FIL_ADDR1(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_FIL_ADDR2(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_FIL_CITY(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_FIL_STATE(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_FIL_ZIP5(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_FIL_ZIP4(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_FIL_COUNTRY(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_FIL_COUNTRY_DEC(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_FIL_PAGES(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_FIL_STATUS(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_FIL_STATUS_DEC(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_FIL_CANCELLATION_DATE(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_FIL_EXPIRATION_DATE(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_FIL_TOTAL_OWN_CUR_CTR(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_FIL_FEI_NUM(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_GREATER_THAN__OWNERS(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_OWNER_NAME_FORMAT(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_OWNER_ADDR(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_OWNER_CITY(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_OWNER_STATE(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_OWNER_ZIP5(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_OWNER_ZIP4(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_OWNER_COUNTRY(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_OWNER_COUNTRY_DEC(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_OWNER_FEI_NUM(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_OWNER_CHARTER_NUM(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
