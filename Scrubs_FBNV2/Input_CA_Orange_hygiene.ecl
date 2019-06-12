IMPORT SALT37;
EXPORT Input_CA_Orange_hygiene(dataset(Input_CA_Orange_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_business_name_pcnt := AVE(GROUP,IF(h.business_name = (TYPEOF(h.business_name))'',0,100));
    maxlength_business_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_name)));
    avelength_business_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_name)),h.business_name<>(typeof(h.business_name))'');
    populated_file_date_pcnt := AVE(GROUP,IF(h.file_date = (TYPEOF(h.file_date))'',0,100));
    maxlength_file_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_date)));
    avelength_file_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_date)),h.file_date<>(typeof(h.file_date))'');
    populated_regis_nbr_pcnt := AVE(GROUP,IF(h.regis_nbr = (TYPEOF(h.regis_nbr))'',0,100));
    maxlength_regis_nbr := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.regis_nbr)));
    avelength_regis_nbr := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.regis_nbr)),h.regis_nbr<>(typeof(h.regis_nbr))'');
    populated_prep_bus_addr_line1_pcnt := AVE(GROUP,IF(h.prep_bus_addr_line1 = (TYPEOF(h.prep_bus_addr_line1))'',0,100));
    maxlength_prep_bus_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_bus_addr_line1)));
    avelength_prep_bus_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_bus_addr_line1)),h.prep_bus_addr_line1<>(typeof(h.prep_bus_addr_line1))'');
    populated_prep_bus_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_bus_addr_line_last = (TYPEOF(h.prep_bus_addr_line_last))'',0,100));
    maxlength_prep_bus_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_bus_addr_line_last)));
    avelength_prep_bus_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_bus_addr_line_last)),h.prep_bus_addr_line_last<>(typeof(h.prep_bus_addr_line_last))'');
    populated_prep_owner_addr_line1_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line1 = (TYPEOF(h.prep_owner_addr_line1))'',0,100));
    maxlength_prep_owner_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line1)));
    avelength_prep_owner_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line1)),h.prep_owner_addr_line1<>(typeof(h.prep_owner_addr_line1))'');
    populated_prep_owner_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line_last = (TYPEOF(h.prep_owner_addr_line_last))'',0,100));
    maxlength_prep_owner_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line_last)));
    avelength_prep_owner_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line_last)),h.prep_owner_addr_line_last<>(typeof(h.prep_owner_addr_line_last))'');
    populated_cname_pcnt := AVE(GROUP,IF(h.cname = (TYPEOF(h.cname))'',0,100));
    maxlength_cname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.cname)));
    avelength_cname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.cname)),h.cname<>(typeof(h.cname))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_middle_name_pcnt := AVE(GROUP,IF(h.middle_name = (TYPEOF(h.middle_name))'',0,100));
    maxlength_middle_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.middle_name)));
    avelength_middle_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.middle_name)),h.middle_name<>(typeof(h.middle_name))'');
    populated_last_name_company_pcnt := AVE(GROUP,IF(h.last_name_company = (TYPEOF(h.last_name_company))'',0,100));
    maxlength_last_name_company := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.last_name_company)));
    avelength_last_name_company := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.last_name_company)),h.last_name_company<>(typeof(h.last_name_company))'');
    populated_owner_address_pcnt := AVE(GROUP,IF(h.owner_address = (TYPEOF(h.owner_address))'',0,100));
    maxlength_owner_address := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_address)));
    avelength_owner_address := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_address)),h.owner_address<>(typeof(h.owner_address))'');
    populated_phone_nbr_pcnt := AVE(GROUP,IF(h.phone_nbr = (TYPEOF(h.phone_nbr))'',0,100));
    maxlength_phone_nbr := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.phone_nbr)));
    avelength_phone_nbr := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.phone_nbr)),h.phone_nbr<>(typeof(h.phone_nbr))'');
    populated_BUSINESS_LETTER_pcnt := AVE(GROUP,IF(h.BUSINESS_LETTER = (TYPEOF(h.BUSINESS_LETTER))'',0,100));
    maxlength_BUSINESS_LETTER := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUSINESS_LETTER)));
    avelength_BUSINESS_LETTER := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUSINESS_LETTER)),h.BUSINESS_LETTER<>(typeof(h.BUSINESS_LETTER))'');
    populated_ADDRESS_pcnt := AVE(GROUP,IF(h.ADDRESS = (TYPEOF(h.ADDRESS))'',0,100));
    maxlength_ADDRESS := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ADDRESS)));
    avelength_ADDRESS := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ADDRESS)),h.ADDRESS<>(typeof(h.ADDRESS))'');
    populated_CITY_pcnt := AVE(GROUP,IF(h.CITY = (TYPEOF(h.CITY))'',0,100));
    maxlength_CITY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.CITY)));
    avelength_CITY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.CITY)),h.CITY<>(typeof(h.CITY))'');
    populated_STATE_pcnt := AVE(GROUP,IF(h.STATE = (TYPEOF(h.STATE))'',0,100));
    maxlength_STATE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.STATE)));
    avelength_STATE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.STATE)),h.STATE<>(typeof(h.STATE))'');
    populated_ZIP_CODE_pcnt := AVE(GROUP,IF(h.ZIP_CODE = (TYPEOF(h.ZIP_CODE))'',0,100));
    maxlength_ZIP_CODE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ZIP_CODE)));
    avelength_ZIP_CODE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ZIP_CODE)),h.ZIP_CODE<>(typeof(h.ZIP_CODE))'');
    populated_DOCETYEP_pcnt := AVE(GROUP,IF(h.DOCETYEP = (TYPEOF(h.DOCETYEP))'',0,100));
    maxlength_DOCETYEP := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.DOCETYEP)));
    avelength_DOCETYEP := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.DOCETYEP)),h.DOCETYEP<>(typeof(h.DOCETYEP))'');
    populated_OWNER_NBR_pcnt := AVE(GROUP,IF(h.OWNER_NBR = (TYPEOF(h.OWNER_NBR))'',0,100));
    maxlength_OWNER_NBR := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_NBR)));
    avelength_OWNER_NBR := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_NBR)),h.OWNER_NBR<>(typeof(h.OWNER_NBR))'');
    populated_OWNER_CITY_pcnt := AVE(GROUP,IF(h.OWNER_CITY = (TYPEOF(h.OWNER_CITY))'',0,100));
    maxlength_OWNER_CITY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_CITY)));
    avelength_OWNER_CITY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_CITY)),h.OWNER_CITY<>(typeof(h.OWNER_CITY))'');
    populated_OWNER_STATE_pcnt := AVE(GROUP,IF(h.OWNER_STATE = (TYPEOF(h.OWNER_STATE))'',0,100));
    maxlength_OWNER_STATE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_STATE)));
    avelength_OWNER_STATE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_STATE)),h.OWNER_STATE<>(typeof(h.OWNER_STATE))'');
    populated_OWNER_ZIP_CODE_pcnt := AVE(GROUP,IF(h.OWNER_ZIP_CODE = (TYPEOF(h.OWNER_ZIP_CODE))'',0,100));
    maxlength_OWNER_ZIP_CODE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_ZIP_CODE)));
    avelength_OWNER_ZIP_CODE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_ZIP_CODE)),h.OWNER_ZIP_CODE<>(typeof(h.OWNER_ZIP_CODE))'');
    populated_BUSINESS_TYPE_pcnt := AVE(GROUP,IF(h.BUSINESS_TYPE = (TYPEOF(h.BUSINESS_TYPE))'',0,100));
    maxlength_BUSINESS_TYPE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUSINESS_TYPE)));
    avelength_BUSINESS_TYPE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUSINESS_TYPE)),h.BUSINESS_TYPE<>(typeof(h.BUSINESS_TYPE))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_business_name_pcnt *   0.00 / 100 + T.Populated_file_date_pcnt *   0.00 / 100 + T.Populated_regis_nbr_pcnt *   0.00 / 100 + T.Populated_prep_bus_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_bus_addr_line_last_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line_last_pcnt *   0.00 / 100 + T.Populated_cname_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_middle_name_pcnt *   0.00 / 100 + T.Populated_last_name_company_pcnt *   0.00 / 100 + T.Populated_owner_address_pcnt *   0.00 / 100 + T.Populated_phone_nbr_pcnt *   0.00 / 100 + T.Populated_BUSINESS_LETTER_pcnt *   0.00 / 100 + T.Populated_ADDRESS_pcnt *   0.00 / 100 + T.Populated_CITY_pcnt *   0.00 / 100 + T.Populated_STATE_pcnt *   0.00 / 100 + T.Populated_ZIP_CODE_pcnt *   0.00 / 100 + T.Populated_DOCETYEP_pcnt *   0.00 / 100 + T.Populated_OWNER_NBR_pcnt *   0.00 / 100 + T.Populated_OWNER_CITY_pcnt *   0.00 / 100 + T.Populated_OWNER_STATE_pcnt *   0.00 / 100 + T.Populated_OWNER_ZIP_CODE_pcnt *   0.00 / 100 + T.Populated_BUSINESS_TYPE_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'business_name','file_date','regis_nbr','prep_bus_addr_line1','prep_bus_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last','cname','first_name','middle_name','last_name_company','owner_address','phone_nbr','BUSINESS_LETTER','ADDRESS','CITY','STATE','ZIP_CODE','DOCETYEP','OWNER_NBR','OWNER_CITY','OWNER_STATE','OWNER_ZIP_CODE','BUSINESS_TYPE','title','fname','mname','lname','name_suffix','name_score');
  SELF.populated_pcnt := CHOOSE(C,le.populated_business_name_pcnt,le.populated_file_date_pcnt,le.populated_regis_nbr_pcnt,le.populated_prep_bus_addr_line1_pcnt,le.populated_prep_bus_addr_line_last_pcnt,le.populated_prep_owner_addr_line1_pcnt,le.populated_prep_owner_addr_line_last_pcnt,le.populated_cname_pcnt,le.populated_first_name_pcnt,le.populated_middle_name_pcnt,le.populated_last_name_company_pcnt,le.populated_owner_address_pcnt,le.populated_phone_nbr_pcnt,le.populated_BUSINESS_LETTER_pcnt,le.populated_ADDRESS_pcnt,le.populated_CITY_pcnt,le.populated_STATE_pcnt,le.populated_ZIP_CODE_pcnt,le.populated_DOCETYEP_pcnt,le.populated_OWNER_NBR_pcnt,le.populated_OWNER_CITY_pcnt,le.populated_OWNER_STATE_pcnt,le.populated_OWNER_ZIP_CODE_pcnt,le.populated_BUSINESS_TYPE_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_business_name,le.maxlength_file_date,le.maxlength_regis_nbr,le.maxlength_prep_bus_addr_line1,le.maxlength_prep_bus_addr_line_last,le.maxlength_prep_owner_addr_line1,le.maxlength_prep_owner_addr_line_last,le.maxlength_cname,le.maxlength_first_name,le.maxlength_middle_name,le.maxlength_last_name_company,le.maxlength_owner_address,le.maxlength_phone_nbr,le.maxlength_BUSINESS_LETTER,le.maxlength_ADDRESS,le.maxlength_CITY,le.maxlength_STATE,le.maxlength_ZIP_CODE,le.maxlength_DOCETYEP,le.maxlength_OWNER_NBR,le.maxlength_OWNER_CITY,le.maxlength_OWNER_STATE,le.maxlength_OWNER_ZIP_CODE,le.maxlength_BUSINESS_TYPE,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score);
  SELF.avelength := CHOOSE(C,le.avelength_business_name,le.avelength_file_date,le.avelength_regis_nbr,le.avelength_prep_bus_addr_line1,le.avelength_prep_bus_addr_line_last,le.avelength_prep_owner_addr_line1,le.avelength_prep_owner_addr_line_last,le.avelength_cname,le.avelength_first_name,le.avelength_middle_name,le.avelength_last_name_company,le.avelength_owner_address,le.avelength_phone_nbr,le.avelength_BUSINESS_LETTER,le.avelength_ADDRESS,le.avelength_CITY,le.avelength_STATE,le.avelength_ZIP_CODE,le.avelength_DOCETYEP,le.avelength_OWNER_NBR,le.avelength_OWNER_CITY,le.avelength_OWNER_STATE,le.avelength_OWNER_ZIP_CODE,le.avelength_BUSINESS_TYPE,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score);
END;
EXPORT invSummary := NORMALIZE(summary0, 30, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.business_name),TRIM((SALT37.StrType)le.file_date),TRIM((SALT37.StrType)le.regis_nbr),TRIM((SALT37.StrType)le.prep_bus_addr_line1),TRIM((SALT37.StrType)le.prep_bus_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last),TRIM((SALT37.StrType)le.cname),TRIM((SALT37.StrType)le.first_name),TRIM((SALT37.StrType)le.middle_name),TRIM((SALT37.StrType)le.last_name_company),TRIM((SALT37.StrType)le.owner_address),TRIM((SALT37.StrType)le.phone_nbr),TRIM((SALT37.StrType)le.BUSINESS_LETTER),TRIM((SALT37.StrType)le.ADDRESS),TRIM((SALT37.StrType)le.CITY),TRIM((SALT37.StrType)le.STATE),TRIM((SALT37.StrType)le.ZIP_CODE),TRIM((SALT37.StrType)le.DOCETYEP),TRIM((SALT37.StrType)le.OWNER_NBR),TRIM((SALT37.StrType)le.OWNER_CITY),TRIM((SALT37.StrType)le.OWNER_STATE),TRIM((SALT37.StrType)le.OWNER_ZIP_CODE),TRIM((SALT37.StrType)le.BUSINESS_TYPE),TRIM((SALT37.StrType)le.title),TRIM((SALT37.StrType)le.fname),TRIM((SALT37.StrType)le.mname),TRIM((SALT37.StrType)le.lname),TRIM((SALT37.StrType)le.name_suffix),TRIM((SALT37.StrType)le.name_score)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,30,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 30);
  SELF.FldNo2 := 1 + (C % 30);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.business_name),TRIM((SALT37.StrType)le.file_date),TRIM((SALT37.StrType)le.regis_nbr),TRIM((SALT37.StrType)le.prep_bus_addr_line1),TRIM((SALT37.StrType)le.prep_bus_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last),TRIM((SALT37.StrType)le.cname),TRIM((SALT37.StrType)le.first_name),TRIM((SALT37.StrType)le.middle_name),TRIM((SALT37.StrType)le.last_name_company),TRIM((SALT37.StrType)le.owner_address),TRIM((SALT37.StrType)le.phone_nbr),TRIM((SALT37.StrType)le.BUSINESS_LETTER),TRIM((SALT37.StrType)le.ADDRESS),TRIM((SALT37.StrType)le.CITY),TRIM((SALT37.StrType)le.STATE),TRIM((SALT37.StrType)le.ZIP_CODE),TRIM((SALT37.StrType)le.DOCETYEP),TRIM((SALT37.StrType)le.OWNER_NBR),TRIM((SALT37.StrType)le.OWNER_CITY),TRIM((SALT37.StrType)le.OWNER_STATE),TRIM((SALT37.StrType)le.OWNER_ZIP_CODE),TRIM((SALT37.StrType)le.BUSINESS_TYPE),TRIM((SALT37.StrType)le.title),TRIM((SALT37.StrType)le.fname),TRIM((SALT37.StrType)le.mname),TRIM((SALT37.StrType)le.lname),TRIM((SALT37.StrType)le.name_suffix),TRIM((SALT37.StrType)le.name_score)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.business_name),TRIM((SALT37.StrType)le.file_date),TRIM((SALT37.StrType)le.regis_nbr),TRIM((SALT37.StrType)le.prep_bus_addr_line1),TRIM((SALT37.StrType)le.prep_bus_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last),TRIM((SALT37.StrType)le.cname),TRIM((SALT37.StrType)le.first_name),TRIM((SALT37.StrType)le.middle_name),TRIM((SALT37.StrType)le.last_name_company),TRIM((SALT37.StrType)le.owner_address),TRIM((SALT37.StrType)le.phone_nbr),TRIM((SALT37.StrType)le.BUSINESS_LETTER),TRIM((SALT37.StrType)le.ADDRESS),TRIM((SALT37.StrType)le.CITY),TRIM((SALT37.StrType)le.STATE),TRIM((SALT37.StrType)le.ZIP_CODE),TRIM((SALT37.StrType)le.DOCETYEP),TRIM((SALT37.StrType)le.OWNER_NBR),TRIM((SALT37.StrType)le.OWNER_CITY),TRIM((SALT37.StrType)le.OWNER_STATE),TRIM((SALT37.StrType)le.OWNER_ZIP_CODE),TRIM((SALT37.StrType)le.BUSINESS_TYPE),TRIM((SALT37.StrType)le.title),TRIM((SALT37.StrType)le.fname),TRIM((SALT37.StrType)le.mname),TRIM((SALT37.StrType)le.lname),TRIM((SALT37.StrType)le.name_suffix),TRIM((SALT37.StrType)le.name_score)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),30*30,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'business_name'}
      ,{2,'file_date'}
      ,{3,'regis_nbr'}
      ,{4,'prep_bus_addr_line1'}
      ,{5,'prep_bus_addr_line_last'}
      ,{6,'prep_owner_addr_line1'}
      ,{7,'prep_owner_addr_line_last'}
      ,{8,'cname'}
      ,{9,'first_name'}
      ,{10,'middle_name'}
      ,{11,'last_name_company'}
      ,{12,'owner_address'}
      ,{13,'phone_nbr'}
      ,{14,'BUSINESS_LETTER'}
      ,{15,'ADDRESS'}
      ,{16,'CITY'}
      ,{17,'STATE'}
      ,{18,'ZIP_CODE'}
      ,{19,'DOCETYEP'}
      ,{20,'OWNER_NBR'}
      ,{21,'OWNER_CITY'}
      ,{22,'OWNER_STATE'}
      ,{23,'OWNER_ZIP_CODE'}
      ,{24,'BUSINESS_TYPE'}
      ,{25,'title'}
      ,{26,'fname'}
      ,{27,'mname'}
      ,{28,'lname'}
      ,{29,'name_suffix'}
      ,{30,'name_score'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_CA_Orange_Fields.InValid_business_name((SALT37.StrType)le.business_name),
    Input_CA_Orange_Fields.InValid_file_date((SALT37.StrType)le.file_date),
    Input_CA_Orange_Fields.InValid_regis_nbr((SALT37.StrType)le.regis_nbr),
    Input_CA_Orange_Fields.InValid_prep_bus_addr_line1((SALT37.StrType)le.prep_bus_addr_line1),
    Input_CA_Orange_Fields.InValid_prep_bus_addr_line_last((SALT37.StrType)le.prep_bus_addr_line_last),
    Input_CA_Orange_Fields.InValid_prep_owner_addr_line1((SALT37.StrType)le.prep_owner_addr_line1),
    Input_CA_Orange_Fields.InValid_prep_owner_addr_line_last((SALT37.StrType)le.prep_owner_addr_line_last),
    Input_CA_Orange_Fields.InValid_cname((SALT37.StrType)le.cname),
    Input_CA_Orange_Fields.InValid_first_name((SALT37.StrType)le.first_name),
    Input_CA_Orange_Fields.InValid_middle_name((SALT37.StrType)le.middle_name),
    Input_CA_Orange_Fields.InValid_last_name_company((SALT37.StrType)le.last_name_company),
    Input_CA_Orange_Fields.InValid_owner_address((SALT37.StrType)le.owner_address),
    Input_CA_Orange_Fields.InValid_phone_nbr((SALT37.StrType)le.phone_nbr),
    Input_CA_Orange_Fields.InValid_BUSINESS_LETTER((SALT37.StrType)le.BUSINESS_LETTER),
    Input_CA_Orange_Fields.InValid_ADDRESS((SALT37.StrType)le.ADDRESS),
    Input_CA_Orange_Fields.InValid_CITY((SALT37.StrType)le.CITY),
    Input_CA_Orange_Fields.InValid_STATE((SALT37.StrType)le.STATE),
    Input_CA_Orange_Fields.InValid_ZIP_CODE((SALT37.StrType)le.ZIP_CODE),
    Input_CA_Orange_Fields.InValid_DOCETYEP((SALT37.StrType)le.DOCETYEP),
    Input_CA_Orange_Fields.InValid_OWNER_NBR((SALT37.StrType)le.OWNER_NBR),
    Input_CA_Orange_Fields.InValid_OWNER_CITY((SALT37.StrType)le.OWNER_CITY),
    Input_CA_Orange_Fields.InValid_OWNER_STATE((SALT37.StrType)le.OWNER_STATE),
    Input_CA_Orange_Fields.InValid_OWNER_ZIP_CODE((SALT37.StrType)le.OWNER_ZIP_CODE),
    Input_CA_Orange_Fields.InValid_BUSINESS_TYPE((SALT37.StrType)le.BUSINESS_TYPE),
    Input_CA_Orange_Fields.InValid_title((SALT37.StrType)le.title),
    Input_CA_Orange_Fields.InValid_fname((SALT37.StrType)le.fname),
    Input_CA_Orange_Fields.InValid_mname((SALT37.StrType)le.mname),
    Input_CA_Orange_Fields.InValid_lname((SALT37.StrType)le.lname),
    Input_CA_Orange_Fields.InValid_name_suffix((SALT37.StrType)le.name_suffix),
    Input_CA_Orange_Fields.InValid_name_score((SALT37.StrType)le.name_score),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,30,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_CA_Orange_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_general_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_phone','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_CA_Orange_Fields.InValidMessage_business_name(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_file_date(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_regis_nbr(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_prep_bus_addr_line1(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_prep_bus_addr_line_last(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_prep_owner_addr_line1(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_prep_owner_addr_line_last(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_cname(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_middle_name(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_last_name_company(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_owner_address(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_phone_nbr(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_BUSINESS_LETTER(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_ADDRESS(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_CITY(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_STATE(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_ZIP_CODE(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_DOCETYEP(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_OWNER_NBR(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_OWNER_CITY(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_OWNER_STATE(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_OWNER_ZIP_CODE(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_BUSINESS_TYPE(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_title(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_name_score(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
