IMPORT SALT37;
EXPORT Input_CA_Santa_Clara_hygiene(dataset(Input_CA_Santa_Clara_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_business_name_pcnt := AVE(GROUP,IF(h.business_name = (TYPEOF(h.business_name))'',0,100));
    maxlength_business_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_name)));
    avelength_business_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_name)),h.business_name<>(typeof(h.business_name))'');
    populated_filed_date_pcnt := AVE(GROUP,IF(h.filed_date = (TYPEOF(h.filed_date))'',0,100));
    maxlength_filed_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.filed_date)));
    avelength_filed_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.filed_date)),h.filed_date<>(typeof(h.filed_date))'');
    populated_orig_filed_date_pcnt := AVE(GROUP,IF(h.orig_filed_date = (TYPEOF(h.orig_filed_date))'',0,100));
    maxlength_orig_filed_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_filed_date)));
    avelength_orig_filed_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_filed_date)),h.orig_filed_date<>(typeof(h.orig_filed_date))'');
    populated_fbn_num_pcnt := AVE(GROUP,IF(h.fbn_num = (TYPEOF(h.fbn_num))'',0,100));
    maxlength_fbn_num := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fbn_num)));
    avelength_fbn_num := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fbn_num)),h.fbn_num<>(typeof(h.fbn_num))'');
    populated_filing_type_pcnt := AVE(GROUP,IF(h.filing_type = (TYPEOF(h.filing_type))'',0,100));
    maxlength_filing_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.filing_type)));
    avelength_filing_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.filing_type)),h.filing_type<>(typeof(h.filing_type))'');
    populated_owner_name_pcnt := AVE(GROUP,IF(h.owner_name = (TYPEOF(h.owner_name))'',0,100));
    maxlength_owner_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_name)));
    avelength_owner_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_name)),h.owner_name<>(typeof(h.owner_name))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_addr_line_last = (TYPEOF(h.prep_addr_line_last))'',0,100));
    maxlength_prep_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line_last)));
    avelength_prep_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line_last)),h.prep_addr_line_last<>(typeof(h.prep_addr_line_last))'');
    populated_status_pcnt := AVE(GROUP,IF(h.status = (TYPEOF(h.status))'',0,100));
    maxlength_status := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.status)));
    avelength_status := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.status)),h.status<>(typeof(h.status))'');
    populated_FBN_TYPE_pcnt := AVE(GROUP,IF(h.FBN_TYPE = (TYPEOF(h.FBN_TYPE))'',0,100));
    maxlength_FBN_TYPE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FBN_TYPE)));
    avelength_FBN_TYPE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FBN_TYPE)),h.FBN_TYPE<>(typeof(h.FBN_TYPE))'');
    populated_BUSINESS_TYPE_pcnt := AVE(GROUP,IF(h.BUSINESS_TYPE = (TYPEOF(h.BUSINESS_TYPE))'',0,100));
    maxlength_BUSINESS_TYPE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUSINESS_TYPE)));
    avelength_BUSINESS_TYPE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUSINESS_TYPE)),h.BUSINESS_TYPE<>(typeof(h.BUSINESS_TYPE))'');
    populated_ORIG_FBN_NUM_pcnt := AVE(GROUP,IF(h.ORIG_FBN_NUM = (TYPEOF(h.ORIG_FBN_NUM))'',0,100));
    maxlength_ORIG_FBN_NUM := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ORIG_FBN_NUM)));
    avelength_ORIG_FBN_NUM := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ORIG_FBN_NUM)),h.ORIG_FBN_NUM<>(typeof(h.ORIG_FBN_NUM))'');
    populated_RECORD_CODE1_pcnt := AVE(GROUP,IF(h.RECORD_CODE1 = (TYPEOF(h.RECORD_CODE1))'',0,100));
    maxlength_RECORD_CODE1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.RECORD_CODE1)));
    avelength_RECORD_CODE1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.RECORD_CODE1)),h.RECORD_CODE1<>(typeof(h.RECORD_CODE1))'');
    populated_BUSINESS_ADDR1_pcnt := AVE(GROUP,IF(h.BUSINESS_ADDR1 = (TYPEOF(h.BUSINESS_ADDR1))'',0,100));
    maxlength_BUSINESS_ADDR1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUSINESS_ADDR1)));
    avelength_BUSINESS_ADDR1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUSINESS_ADDR1)),h.BUSINESS_ADDR1<>(typeof(h.BUSINESS_ADDR1))'');
    populated_RECORD_CODE2_pcnt := AVE(GROUP,IF(h.RECORD_CODE2 = (TYPEOF(h.RECORD_CODE2))'',0,100));
    maxlength_RECORD_CODE2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.RECORD_CODE2)));
    avelength_RECORD_CODE2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.RECORD_CODE2)),h.RECORD_CODE2<>(typeof(h.RECORD_CODE2))'');
    populated_BUSINESS_ADDR2_pcnt := AVE(GROUP,IF(h.BUSINESS_ADDR2 = (TYPEOF(h.BUSINESS_ADDR2))'',0,100));
    maxlength_BUSINESS_ADDR2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUSINESS_ADDR2)));
    avelength_BUSINESS_ADDR2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUSINESS_ADDR2)),h.BUSINESS_ADDR2<>(typeof(h.BUSINESS_ADDR2))'');
    populated_RECORD_CODE3_pcnt := AVE(GROUP,IF(h.RECORD_CODE3 = (TYPEOF(h.RECORD_CODE3))'',0,100));
    maxlength_RECORD_CODE3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.RECORD_CODE3)));
    avelength_RECORD_CODE3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.RECORD_CODE3)),h.RECORD_CODE3<>(typeof(h.RECORD_CODE3))'');
    populated_BUS_CITY_pcnt := AVE(GROUP,IF(h.BUS_CITY = (TYPEOF(h.BUS_CITY))'',0,100));
    maxlength_BUS_CITY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUS_CITY)));
    avelength_BUS_CITY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUS_CITY)),h.BUS_CITY<>(typeof(h.BUS_CITY))'');
    populated_BUS_ST_pcnt := AVE(GROUP,IF(h.BUS_ST = (TYPEOF(h.BUS_ST))'',0,100));
    maxlength_BUS_ST := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUS_ST)));
    avelength_BUS_ST := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUS_ST)),h.BUS_ST<>(typeof(h.BUS_ST))'');
    populated_BUS_ZIP_pcnt := AVE(GROUP,IF(h.BUS_ZIP = (TYPEOF(h.BUS_ZIP))'',0,100));
    maxlength_BUS_ZIP := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUS_ZIP)));
    avelength_BUS_ZIP := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUS_ZIP)),h.BUS_ZIP<>(typeof(h.BUS_ZIP))'');
    populated_RECORD_CODE4_pcnt := AVE(GROUP,IF(h.RECORD_CODE4 = (TYPEOF(h.RECORD_CODE4))'',0,100));
    maxlength_RECORD_CODE4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.RECORD_CODE4)));
    avelength_RECORD_CODE4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.RECORD_CODE4)),h.RECORD_CODE4<>(typeof(h.RECORD_CODE4))'');
    populated_ADDTL_BUSINESS_pcnt := AVE(GROUP,IF(h.ADDTL_BUSINESS = (TYPEOF(h.ADDTL_BUSINESS))'',0,100));
    maxlength_ADDTL_BUSINESS := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ADDTL_BUSINESS)));
    avelength_ADDTL_BUSINESS := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ADDTL_BUSINESS)),h.ADDTL_BUSINESS<>(typeof(h.ADDTL_BUSINESS))'');
    populated_RECORD_CODE5_pcnt := AVE(GROUP,IF(h.RECORD_CODE5 = (TYPEOF(h.RECORD_CODE5))'',0,100));
    maxlength_RECORD_CODE5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.RECORD_CODE5)));
    avelength_RECORD_CODE5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.RECORD_CODE5)),h.RECORD_CODE5<>(typeof(h.RECORD_CODE5))'');
    populated_OWNER_TYPE_pcnt := AVE(GROUP,IF(h.OWNER_TYPE = (TYPEOF(h.OWNER_TYPE))'',0,100));
    maxlength_OWNER_TYPE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_TYPE)));
    avelength_OWNER_TYPE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_TYPE)),h.OWNER_TYPE<>(typeof(h.OWNER_TYPE))'');
    populated_RECORD_CODE6_pcnt := AVE(GROUP,IF(h.RECORD_CODE6 = (TYPEOF(h.RECORD_CODE6))'',0,100));
    maxlength_RECORD_CODE6 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.RECORD_CODE6)));
    avelength_RECORD_CODE6 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.RECORD_CODE6)),h.RECORD_CODE6<>(typeof(h.RECORD_CODE6))'');
    populated_OWNER_ADDR1_pcnt := AVE(GROUP,IF(h.OWNER_ADDR1 = (TYPEOF(h.OWNER_ADDR1))'',0,100));
    maxlength_OWNER_ADDR1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_ADDR1)));
    avelength_OWNER_ADDR1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_ADDR1)),h.OWNER_ADDR1<>(typeof(h.OWNER_ADDR1))'');
    populated_OWNER_CITY_pcnt := AVE(GROUP,IF(h.OWNER_CITY = (TYPEOF(h.OWNER_CITY))'',0,100));
    maxlength_OWNER_CITY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_CITY)));
    avelength_OWNER_CITY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_CITY)),h.OWNER_CITY<>(typeof(h.OWNER_CITY))'');
    populated_OWNER_ST_pcnt := AVE(GROUP,IF(h.OWNER_ST = (TYPEOF(h.OWNER_ST))'',0,100));
    maxlength_OWNER_ST := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_ST)));
    avelength_OWNER_ST := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_ST)),h.OWNER_ST<>(typeof(h.OWNER_ST))'');
    populated_OWNER_ZIP_pcnt := AVE(GROUP,IF(h.OWNER_ZIP = (TYPEOF(h.OWNER_ZIP))'',0,100));
    maxlength_OWNER_ZIP := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_ZIP)));
    avelength_OWNER_ZIP := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_ZIP)),h.OWNER_ZIP<>(typeof(h.OWNER_ZIP))'');
    populated_Owner_title_pcnt := AVE(GROUP,IF(h.Owner_title = (TYPEOF(h.Owner_title))'',0,100));
    maxlength_Owner_title := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_title)));
    avelength_Owner_title := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_title)),h.Owner_title<>(typeof(h.Owner_title))'');
    populated_Owner_fname_pcnt := AVE(GROUP,IF(h.Owner_fname = (TYPEOF(h.Owner_fname))'',0,100));
    maxlength_Owner_fname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_fname)));
    avelength_Owner_fname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_fname)),h.Owner_fname<>(typeof(h.Owner_fname))'');
    populated_Owner_mname_pcnt := AVE(GROUP,IF(h.Owner_mname = (TYPEOF(h.Owner_mname))'',0,100));
    maxlength_Owner_mname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_mname)));
    avelength_Owner_mname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_mname)),h.Owner_mname<>(typeof(h.Owner_mname))'');
    populated_Owner_lname_pcnt := AVE(GROUP,IF(h.Owner_lname = (TYPEOF(h.Owner_lname))'',0,100));
    maxlength_Owner_lname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_lname)));
    avelength_Owner_lname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_lname)),h.Owner_lname<>(typeof(h.Owner_lname))'');
    populated_Owner_name_suffix_pcnt := AVE(GROUP,IF(h.Owner_name_suffix = (TYPEOF(h.Owner_name_suffix))'',0,100));
    maxlength_Owner_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_name_suffix)));
    avelength_Owner_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_name_suffix)),h.Owner_name_suffix<>(typeof(h.Owner_name_suffix))'');
    populated_Owner_name_score_pcnt := AVE(GROUP,IF(h.Owner_name_score = (TYPEOF(h.Owner_name_score))'',0,100));
    maxlength_Owner_name_score := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_name_score)));
    avelength_Owner_name_score := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_name_score)),h.Owner_name_score<>(typeof(h.Owner_name_score))'');
    populated_prep_owner_addr_line1_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line1 = (TYPEOF(h.prep_owner_addr_line1))'',0,100));
    maxlength_prep_owner_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line1)));
    avelength_prep_owner_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line1)),h.prep_owner_addr_line1<>(typeof(h.prep_owner_addr_line1))'');
    populated_prep_owner_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line_last = (TYPEOF(h.prep_owner_addr_line_last))'',0,100));
    maxlength_prep_owner_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line_last)));
    avelength_prep_owner_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line_last)),h.prep_owner_addr_line_last<>(typeof(h.prep_owner_addr_line_last))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_business_name_pcnt *   0.00 / 100 + T.Populated_filed_date_pcnt *   0.00 / 100 + T.Populated_orig_filed_date_pcnt *   0.00 / 100 + T.Populated_fbn_num_pcnt *   0.00 / 100 + T.Populated_filing_type_pcnt *   0.00 / 100 + T.Populated_owner_name_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_line_last_pcnt *   0.00 / 100 + T.Populated_status_pcnt *   0.00 / 100 + T.Populated_FBN_TYPE_pcnt *   0.00 / 100 + T.Populated_BUSINESS_TYPE_pcnt *   0.00 / 100 + T.Populated_ORIG_FBN_NUM_pcnt *   0.00 / 100 + T.Populated_RECORD_CODE1_pcnt *   0.00 / 100 + T.Populated_BUSINESS_ADDR1_pcnt *   0.00 / 100 + T.Populated_RECORD_CODE2_pcnt *   0.00 / 100 + T.Populated_BUSINESS_ADDR2_pcnt *   0.00 / 100 + T.Populated_RECORD_CODE3_pcnt *   0.00 / 100 + T.Populated_BUS_CITY_pcnt *   0.00 / 100 + T.Populated_BUS_ST_pcnt *   0.00 / 100 + T.Populated_BUS_ZIP_pcnt *   0.00 / 100 + T.Populated_RECORD_CODE4_pcnt *   0.00 / 100 + T.Populated_ADDTL_BUSINESS_pcnt *   0.00 / 100 + T.Populated_RECORD_CODE5_pcnt *   0.00 / 100 + T.Populated_OWNER_TYPE_pcnt *   0.00 / 100 + T.Populated_RECORD_CODE6_pcnt *   0.00 / 100 + T.Populated_OWNER_ADDR1_pcnt *   0.00 / 100 + T.Populated_OWNER_CITY_pcnt *   0.00 / 100 + T.Populated_OWNER_ST_pcnt *   0.00 / 100 + T.Populated_OWNER_ZIP_pcnt *   0.00 / 100 + T.Populated_Owner_title_pcnt *   0.00 / 100 + T.Populated_Owner_fname_pcnt *   0.00 / 100 + T.Populated_Owner_mname_pcnt *   0.00 / 100 + T.Populated_Owner_lname_pcnt *   0.00 / 100 + T.Populated_Owner_name_suffix_pcnt *   0.00 / 100 + T.Populated_Owner_name_score_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line_last_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'business_name','filed_date','orig_filed_date','fbn_num','filing_type','owner_name','prep_addr_line1','prep_addr_line_last','status','FBN_TYPE','BUSINESS_TYPE','ORIG_FBN_NUM','RECORD_CODE1','BUSINESS_ADDR1','RECORD_CODE2','BUSINESS_ADDR2','RECORD_CODE3','BUS_CITY','BUS_ST','BUS_ZIP','RECORD_CODE4','ADDTL_BUSINESS','RECORD_CODE5','OWNER_TYPE','RECORD_CODE6','OWNER_ADDR1','OWNER_CITY','OWNER_ST','OWNER_ZIP','Owner_title','Owner_fname','Owner_mname','Owner_lname','Owner_name_suffix','Owner_name_score','prep_owner_addr_line1','prep_owner_addr_line_last');
  SELF.populated_pcnt := CHOOSE(C,le.populated_business_name_pcnt,le.populated_filed_date_pcnt,le.populated_orig_filed_date_pcnt,le.populated_fbn_num_pcnt,le.populated_filing_type_pcnt,le.populated_owner_name_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_line_last_pcnt,le.populated_status_pcnt,le.populated_FBN_TYPE_pcnt,le.populated_BUSINESS_TYPE_pcnt,le.populated_ORIG_FBN_NUM_pcnt,le.populated_RECORD_CODE1_pcnt,le.populated_BUSINESS_ADDR1_pcnt,le.populated_RECORD_CODE2_pcnt,le.populated_BUSINESS_ADDR2_pcnt,le.populated_RECORD_CODE3_pcnt,le.populated_BUS_CITY_pcnt,le.populated_BUS_ST_pcnt,le.populated_BUS_ZIP_pcnt,le.populated_RECORD_CODE4_pcnt,le.populated_ADDTL_BUSINESS_pcnt,le.populated_RECORD_CODE5_pcnt,le.populated_OWNER_TYPE_pcnt,le.populated_RECORD_CODE6_pcnt,le.populated_OWNER_ADDR1_pcnt,le.populated_OWNER_CITY_pcnt,le.populated_OWNER_ST_pcnt,le.populated_OWNER_ZIP_pcnt,le.populated_Owner_title_pcnt,le.populated_Owner_fname_pcnt,le.populated_Owner_mname_pcnt,le.populated_Owner_lname_pcnt,le.populated_Owner_name_suffix_pcnt,le.populated_Owner_name_score_pcnt,le.populated_prep_owner_addr_line1_pcnt,le.populated_prep_owner_addr_line_last_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_business_name,le.maxlength_filed_date,le.maxlength_orig_filed_date,le.maxlength_fbn_num,le.maxlength_filing_type,le.maxlength_owner_name,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_line_last,le.maxlength_status,le.maxlength_FBN_TYPE,le.maxlength_BUSINESS_TYPE,le.maxlength_ORIG_FBN_NUM,le.maxlength_RECORD_CODE1,le.maxlength_BUSINESS_ADDR1,le.maxlength_RECORD_CODE2,le.maxlength_BUSINESS_ADDR2,le.maxlength_RECORD_CODE3,le.maxlength_BUS_CITY,le.maxlength_BUS_ST,le.maxlength_BUS_ZIP,le.maxlength_RECORD_CODE4,le.maxlength_ADDTL_BUSINESS,le.maxlength_RECORD_CODE5,le.maxlength_OWNER_TYPE,le.maxlength_RECORD_CODE6,le.maxlength_OWNER_ADDR1,le.maxlength_OWNER_CITY,le.maxlength_OWNER_ST,le.maxlength_OWNER_ZIP,le.maxlength_Owner_title,le.maxlength_Owner_fname,le.maxlength_Owner_mname,le.maxlength_Owner_lname,le.maxlength_Owner_name_suffix,le.maxlength_Owner_name_score,le.maxlength_prep_owner_addr_line1,le.maxlength_prep_owner_addr_line_last);
  SELF.avelength := CHOOSE(C,le.avelength_business_name,le.avelength_filed_date,le.avelength_orig_filed_date,le.avelength_fbn_num,le.avelength_filing_type,le.avelength_owner_name,le.avelength_prep_addr_line1,le.avelength_prep_addr_line_last,le.avelength_status,le.avelength_FBN_TYPE,le.avelength_BUSINESS_TYPE,le.avelength_ORIG_FBN_NUM,le.avelength_RECORD_CODE1,le.avelength_BUSINESS_ADDR1,le.avelength_RECORD_CODE2,le.avelength_BUSINESS_ADDR2,le.avelength_RECORD_CODE3,le.avelength_BUS_CITY,le.avelength_BUS_ST,le.avelength_BUS_ZIP,le.avelength_RECORD_CODE4,le.avelength_ADDTL_BUSINESS,le.avelength_RECORD_CODE5,le.avelength_OWNER_TYPE,le.avelength_RECORD_CODE6,le.avelength_OWNER_ADDR1,le.avelength_OWNER_CITY,le.avelength_OWNER_ST,le.avelength_OWNER_ZIP,le.avelength_Owner_title,le.avelength_Owner_fname,le.avelength_Owner_mname,le.avelength_Owner_lname,le.avelength_Owner_name_suffix,le.avelength_Owner_name_score,le.avelength_prep_owner_addr_line1,le.avelength_prep_owner_addr_line_last);
END;
EXPORT invSummary := NORMALIZE(summary0, 37, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.business_name),TRIM((SALT37.StrType)le.filed_date),TRIM((SALT37.StrType)le.orig_filed_date),TRIM((SALT37.StrType)le.fbn_num),TRIM((SALT37.StrType)le.filing_type),TRIM((SALT37.StrType)le.owner_name),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last),TRIM((SALT37.StrType)le.status),TRIM((SALT37.StrType)le.FBN_TYPE),TRIM((SALT37.StrType)le.BUSINESS_TYPE),TRIM((SALT37.StrType)le.ORIG_FBN_NUM),TRIM((SALT37.StrType)le.RECORD_CODE1),TRIM((SALT37.StrType)le.BUSINESS_ADDR1),TRIM((SALT37.StrType)le.RECORD_CODE2),TRIM((SALT37.StrType)le.BUSINESS_ADDR2),TRIM((SALT37.StrType)le.RECORD_CODE3),TRIM((SALT37.StrType)le.BUS_CITY),TRIM((SALT37.StrType)le.BUS_ST),TRIM((SALT37.StrType)le.BUS_ZIP),TRIM((SALT37.StrType)le.RECORD_CODE4),TRIM((SALT37.StrType)le.ADDTL_BUSINESS),TRIM((SALT37.StrType)le.RECORD_CODE5),TRIM((SALT37.StrType)le.OWNER_TYPE),TRIM((SALT37.StrType)le.RECORD_CODE6),TRIM((SALT37.StrType)le.OWNER_ADDR1),TRIM((SALT37.StrType)le.OWNER_CITY),TRIM((SALT37.StrType)le.OWNER_ST),TRIM((SALT37.StrType)le.OWNER_ZIP),TRIM((SALT37.StrType)le.Owner_title),TRIM((SALT37.StrType)le.Owner_fname),TRIM((SALT37.StrType)le.Owner_mname),TRIM((SALT37.StrType)le.Owner_lname),TRIM((SALT37.StrType)le.Owner_name_suffix),TRIM((SALT37.StrType)le.Owner_name_score),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,37,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 37);
  SELF.FldNo2 := 1 + (C % 37);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.business_name),TRIM((SALT37.StrType)le.filed_date),TRIM((SALT37.StrType)le.orig_filed_date),TRIM((SALT37.StrType)le.fbn_num),TRIM((SALT37.StrType)le.filing_type),TRIM((SALT37.StrType)le.owner_name),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last),TRIM((SALT37.StrType)le.status),TRIM((SALT37.StrType)le.FBN_TYPE),TRIM((SALT37.StrType)le.BUSINESS_TYPE),TRIM((SALT37.StrType)le.ORIG_FBN_NUM),TRIM((SALT37.StrType)le.RECORD_CODE1),TRIM((SALT37.StrType)le.BUSINESS_ADDR1),TRIM((SALT37.StrType)le.RECORD_CODE2),TRIM((SALT37.StrType)le.BUSINESS_ADDR2),TRIM((SALT37.StrType)le.RECORD_CODE3),TRIM((SALT37.StrType)le.BUS_CITY),TRIM((SALT37.StrType)le.BUS_ST),TRIM((SALT37.StrType)le.BUS_ZIP),TRIM((SALT37.StrType)le.RECORD_CODE4),TRIM((SALT37.StrType)le.ADDTL_BUSINESS),TRIM((SALT37.StrType)le.RECORD_CODE5),TRIM((SALT37.StrType)le.OWNER_TYPE),TRIM((SALT37.StrType)le.RECORD_CODE6),TRIM((SALT37.StrType)le.OWNER_ADDR1),TRIM((SALT37.StrType)le.OWNER_CITY),TRIM((SALT37.StrType)le.OWNER_ST),TRIM((SALT37.StrType)le.OWNER_ZIP),TRIM((SALT37.StrType)le.Owner_title),TRIM((SALT37.StrType)le.Owner_fname),TRIM((SALT37.StrType)le.Owner_mname),TRIM((SALT37.StrType)le.Owner_lname),TRIM((SALT37.StrType)le.Owner_name_suffix),TRIM((SALT37.StrType)le.Owner_name_score),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.business_name),TRIM((SALT37.StrType)le.filed_date),TRIM((SALT37.StrType)le.orig_filed_date),TRIM((SALT37.StrType)le.fbn_num),TRIM((SALT37.StrType)le.filing_type),TRIM((SALT37.StrType)le.owner_name),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last),TRIM((SALT37.StrType)le.status),TRIM((SALT37.StrType)le.FBN_TYPE),TRIM((SALT37.StrType)le.BUSINESS_TYPE),TRIM((SALT37.StrType)le.ORIG_FBN_NUM),TRIM((SALT37.StrType)le.RECORD_CODE1),TRIM((SALT37.StrType)le.BUSINESS_ADDR1),TRIM((SALT37.StrType)le.RECORD_CODE2),TRIM((SALT37.StrType)le.BUSINESS_ADDR2),TRIM((SALT37.StrType)le.RECORD_CODE3),TRIM((SALT37.StrType)le.BUS_CITY),TRIM((SALT37.StrType)le.BUS_ST),TRIM((SALT37.StrType)le.BUS_ZIP),TRIM((SALT37.StrType)le.RECORD_CODE4),TRIM((SALT37.StrType)le.ADDTL_BUSINESS),TRIM((SALT37.StrType)le.RECORD_CODE5),TRIM((SALT37.StrType)le.OWNER_TYPE),TRIM((SALT37.StrType)le.RECORD_CODE6),TRIM((SALT37.StrType)le.OWNER_ADDR1),TRIM((SALT37.StrType)le.OWNER_CITY),TRIM((SALT37.StrType)le.OWNER_ST),TRIM((SALT37.StrType)le.OWNER_ZIP),TRIM((SALT37.StrType)le.Owner_title),TRIM((SALT37.StrType)le.Owner_fname),TRIM((SALT37.StrType)le.Owner_mname),TRIM((SALT37.StrType)le.Owner_lname),TRIM((SALT37.StrType)le.Owner_name_suffix),TRIM((SALT37.StrType)le.Owner_name_score),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),37*37,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'business_name'}
      ,{2,'filed_date'}
      ,{3,'orig_filed_date'}
      ,{4,'fbn_num'}
      ,{5,'filing_type'}
      ,{6,'owner_name'}
      ,{7,'prep_addr_line1'}
      ,{8,'prep_addr_line_last'}
      ,{9,'status'}
      ,{10,'FBN_TYPE'}
      ,{11,'BUSINESS_TYPE'}
      ,{12,'ORIG_FBN_NUM'}
      ,{13,'RECORD_CODE1'}
      ,{14,'BUSINESS_ADDR1'}
      ,{15,'RECORD_CODE2'}
      ,{16,'BUSINESS_ADDR2'}
      ,{17,'RECORD_CODE3'}
      ,{18,'BUS_CITY'}
      ,{19,'BUS_ST'}
      ,{20,'BUS_ZIP'}
      ,{21,'RECORD_CODE4'}
      ,{22,'ADDTL_BUSINESS'}
      ,{23,'RECORD_CODE5'}
      ,{24,'OWNER_TYPE'}
      ,{25,'RECORD_CODE6'}
      ,{26,'OWNER_ADDR1'}
      ,{27,'OWNER_CITY'}
      ,{28,'OWNER_ST'}
      ,{29,'OWNER_ZIP'}
      ,{30,'Owner_title'}
      ,{31,'Owner_fname'}
      ,{32,'Owner_mname'}
      ,{33,'Owner_lname'}
      ,{34,'Owner_name_suffix'}
      ,{35,'Owner_name_score'}
      ,{36,'prep_owner_addr_line1'}
      ,{37,'prep_owner_addr_line_last'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_CA_Santa_Clara_Fields.InValid_business_name((SALT37.StrType)le.business_name),
    Input_CA_Santa_Clara_Fields.InValid_filed_date((SALT37.StrType)le.filed_date),
    Input_CA_Santa_Clara_Fields.InValid_orig_filed_date((SALT37.StrType)le.orig_filed_date),
    Input_CA_Santa_Clara_Fields.InValid_fbn_num((SALT37.StrType)le.fbn_num),
    Input_CA_Santa_Clara_Fields.InValid_filing_type((SALT37.StrType)le.filing_type),
    Input_CA_Santa_Clara_Fields.InValid_owner_name((SALT37.StrType)le.owner_name),
    Input_CA_Santa_Clara_Fields.InValid_prep_addr_line1((SALT37.StrType)le.prep_addr_line1),
    Input_CA_Santa_Clara_Fields.InValid_prep_addr_line_last((SALT37.StrType)le.prep_addr_line_last),
    Input_CA_Santa_Clara_Fields.InValid_status((SALT37.StrType)le.status),
    Input_CA_Santa_Clara_Fields.InValid_FBN_TYPE((SALT37.StrType)le.FBN_TYPE),
    Input_CA_Santa_Clara_Fields.InValid_BUSINESS_TYPE((SALT37.StrType)le.BUSINESS_TYPE),
    Input_CA_Santa_Clara_Fields.InValid_ORIG_FBN_NUM((SALT37.StrType)le.ORIG_FBN_NUM),
    Input_CA_Santa_Clara_Fields.InValid_RECORD_CODE1((SALT37.StrType)le.RECORD_CODE1),
    Input_CA_Santa_Clara_Fields.InValid_BUSINESS_ADDR1((SALT37.StrType)le.BUSINESS_ADDR1),
    Input_CA_Santa_Clara_Fields.InValid_RECORD_CODE2((SALT37.StrType)le.RECORD_CODE2),
    Input_CA_Santa_Clara_Fields.InValid_BUSINESS_ADDR2((SALT37.StrType)le.BUSINESS_ADDR2),
    Input_CA_Santa_Clara_Fields.InValid_RECORD_CODE3((SALT37.StrType)le.RECORD_CODE3),
    Input_CA_Santa_Clara_Fields.InValid_BUS_CITY((SALT37.StrType)le.BUS_CITY),
    Input_CA_Santa_Clara_Fields.InValid_BUS_ST((SALT37.StrType)le.BUS_ST),
    Input_CA_Santa_Clara_Fields.InValid_BUS_ZIP((SALT37.StrType)le.BUS_ZIP),
    Input_CA_Santa_Clara_Fields.InValid_RECORD_CODE4((SALT37.StrType)le.RECORD_CODE4),
    Input_CA_Santa_Clara_Fields.InValid_ADDTL_BUSINESS((SALT37.StrType)le.ADDTL_BUSINESS),
    Input_CA_Santa_Clara_Fields.InValid_RECORD_CODE5((SALT37.StrType)le.RECORD_CODE5),
    Input_CA_Santa_Clara_Fields.InValid_OWNER_TYPE((SALT37.StrType)le.OWNER_TYPE),
    Input_CA_Santa_Clara_Fields.InValid_RECORD_CODE6((SALT37.StrType)le.RECORD_CODE6),
    Input_CA_Santa_Clara_Fields.InValid_OWNER_ADDR1((SALT37.StrType)le.OWNER_ADDR1),
    Input_CA_Santa_Clara_Fields.InValid_OWNER_CITY((SALT37.StrType)le.OWNER_CITY),
    Input_CA_Santa_Clara_Fields.InValid_OWNER_ST((SALT37.StrType)le.OWNER_ST),
    Input_CA_Santa_Clara_Fields.InValid_OWNER_ZIP((SALT37.StrType)le.OWNER_ZIP),
    Input_CA_Santa_Clara_Fields.InValid_Owner_title((SALT37.StrType)le.Owner_title),
    Input_CA_Santa_Clara_Fields.InValid_Owner_fname((SALT37.StrType)le.Owner_fname),
    Input_CA_Santa_Clara_Fields.InValid_Owner_mname((SALT37.StrType)le.Owner_mname),
    Input_CA_Santa_Clara_Fields.InValid_Owner_lname((SALT37.StrType)le.Owner_lname),
    Input_CA_Santa_Clara_Fields.InValid_Owner_name_suffix((SALT37.StrType)le.Owner_name_suffix),
    Input_CA_Santa_Clara_Fields.InValid_Owner_name_score((SALT37.StrType)le.Owner_name_score),
    Input_CA_Santa_Clara_Fields.InValid_prep_owner_addr_line1((SALT37.StrType)le.prep_owner_addr_line1),
    Input_CA_Santa_Clara_Fields.InValid_prep_owner_addr_line_last((SALT37.StrType)le.prep_owner_addr_line_last),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,37,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_CA_Santa_Clara_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_general_date','invalid_general_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_CA_Santa_Clara_Fields.InValidMessage_business_name(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_filed_date(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_orig_filed_date(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_fbn_num(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_filing_type(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_owner_name(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_prep_addr_line_last(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_status(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_FBN_TYPE(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_BUSINESS_TYPE(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_ORIG_FBN_NUM(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_RECORD_CODE1(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_BUSINESS_ADDR1(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_RECORD_CODE2(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_BUSINESS_ADDR2(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_RECORD_CODE3(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_BUS_CITY(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_BUS_ST(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_BUS_ZIP(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_RECORD_CODE4(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_ADDTL_BUSINESS(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_RECORD_CODE5(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_OWNER_TYPE(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_RECORD_CODE6(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_OWNER_ADDR1(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_OWNER_CITY(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_OWNER_ST(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_OWNER_ZIP(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_Owner_title(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_Owner_fname(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_Owner_mname(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_Owner_lname(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_Owner_name_suffix(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_Owner_name_score(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_prep_owner_addr_line1(TotalErrors.ErrorNum),Input_CA_Santa_Clara_Fields.InValidMessage_prep_owner_addr_line_last(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
