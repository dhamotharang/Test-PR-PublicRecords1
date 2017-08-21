IMPORT ut,SALT33;
EXPORT hygiene(dataset(layout_Classify_PS) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT33.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_NAME_SUFFIX_pcnt := AVE(GROUP,IF(h.NAME_SUFFIX = (TYPEOF(h.NAME_SUFFIX))'',0,100));
    maxlength_NAME_SUFFIX := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.NAME_SUFFIX)));
    avelength_NAME_SUFFIX := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.NAME_SUFFIX)),h.NAME_SUFFIX<>(typeof(h.NAME_SUFFIX))'');
    populated_FNAME_pcnt := AVE(GROUP,IF(h.FNAME = (TYPEOF(h.FNAME))'',0,100));
    maxlength_FNAME := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.FNAME)));
    avelength_FNAME := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.FNAME)),h.FNAME<>(typeof(h.FNAME))'');
    populated_MNAME_pcnt := AVE(GROUP,IF(h.MNAME = (TYPEOF(h.MNAME))'',0,100));
    maxlength_MNAME := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.MNAME)));
    avelength_MNAME := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.MNAME)),h.MNAME<>(typeof(h.MNAME))'');
    populated_LNAME_pcnt := AVE(GROUP,IF(h.LNAME = (TYPEOF(h.LNAME))'',0,100));
    maxlength_LNAME := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.LNAME)));
    avelength_LNAME := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.LNAME)),h.LNAME<>(typeof(h.LNAME))'');
    populated_PRIM_RANGE_pcnt := AVE(GROUP,IF(h.PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',0,100));
    maxlength_PRIM_RANGE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.PRIM_RANGE)));
    avelength_PRIM_RANGE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.PRIM_RANGE)),h.PRIM_RANGE<>(typeof(h.PRIM_RANGE))'');
    populated_PRIM_NAME_pcnt := AVE(GROUP,IF(h.PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',0,100));
    maxlength_PRIM_NAME := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.PRIM_NAME)));
    avelength_PRIM_NAME := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.PRIM_NAME)),h.PRIM_NAME<>(typeof(h.PRIM_NAME))'');
    populated_SEC_RANGE_pcnt := AVE(GROUP,IF(h.SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',0,100));
    maxlength_SEC_RANGE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.SEC_RANGE)));
    avelength_SEC_RANGE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.SEC_RANGE)),h.SEC_RANGE<>(typeof(h.SEC_RANGE))'');
    populated_P_CITY_NAME_pcnt := AVE(GROUP,IF(h.P_CITY_NAME = (TYPEOF(h.P_CITY_NAME))'',0,100));
    maxlength_P_CITY_NAME := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.P_CITY_NAME)));
    avelength_P_CITY_NAME := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.P_CITY_NAME)),h.P_CITY_NAME<>(typeof(h.P_CITY_NAME))'');
    populated_ST_pcnt := AVE(GROUP,IF(h.ST = (TYPEOF(h.ST))'',0,100));
    maxlength_ST := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ST)));
    avelength_ST := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ST)),h.ST<>(typeof(h.ST))'');
    populated_ZIP_pcnt := AVE(GROUP,IF(h.ZIP = (TYPEOF(h.ZIP))'',0,100));
    maxlength_ZIP := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ZIP)));
    avelength_ZIP := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ZIP)),h.ZIP<>(typeof(h.ZIP))'');
    populated_DOB_pcnt := AVE(GROUP,IF(h.DOB = (TYPEOF(h.DOB))'',0,100));
    maxlength_DOB := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.DOB)));
    avelength_DOB := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.DOB)),h.DOB<>(typeof(h.DOB))'');
    populated_PHONE_pcnt := AVE(GROUP,IF(h.PHONE = (TYPEOF(h.PHONE))'',0,100));
    maxlength_PHONE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.PHONE)));
    avelength_PHONE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.PHONE)),h.PHONE<>(typeof(h.PHONE))'');
    populated_DL_ST_pcnt := AVE(GROUP,IF(h.DL_ST = (TYPEOF(h.DL_ST))'',0,100));
    maxlength_DL_ST := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.DL_ST)));
    avelength_DL_ST := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.DL_ST)),h.DL_ST<>(typeof(h.DL_ST))'');
    populated_DL_pcnt := AVE(GROUP,IF(h.DL = (TYPEOF(h.DL))'',0,100));
    maxlength_DL := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.DL)));
    avelength_DL := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.DL)),h.DL<>(typeof(h.DL))'');
    populated_LEXID_pcnt := AVE(GROUP,IF(h.LEXID = (TYPEOF(h.LEXID))'',0,100));
    maxlength_LEXID := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.LEXID)));
    avelength_LEXID := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.LEXID)),h.LEXID<>(typeof(h.LEXID))'');
    populated_POSSIBLE_SSN_pcnt := AVE(GROUP,IF(h.POSSIBLE_SSN = (TYPEOF(h.POSSIBLE_SSN))'',0,100));
    maxlength_POSSIBLE_SSN := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.POSSIBLE_SSN)));
    avelength_POSSIBLE_SSN := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.POSSIBLE_SSN)),h.POSSIBLE_SSN<>(typeof(h.POSSIBLE_SSN))'');
    populated_CRIME_pcnt := AVE(GROUP,IF(h.CRIME = (TYPEOF(h.CRIME))'',0,100));
    maxlength_CRIME := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.CRIME)));
    avelength_CRIME := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.CRIME)),h.CRIME<>(typeof(h.CRIME))'');
    populated_NAME_TYPE_pcnt := AVE(GROUP,IF(h.NAME_TYPE = (TYPEOF(h.NAME_TYPE))'',0,100));
    maxlength_NAME_TYPE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.NAME_TYPE)));
    avelength_NAME_TYPE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.NAME_TYPE)),h.NAME_TYPE<>(typeof(h.NAME_TYPE))'');
    populated_CLEAN_GENDER_pcnt := AVE(GROUP,IF(h.CLEAN_GENDER = (TYPEOF(h.CLEAN_GENDER))'',0,100));
    maxlength_CLEAN_GENDER := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.CLEAN_GENDER)));
    avelength_CLEAN_GENDER := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.CLEAN_GENDER)),h.CLEAN_GENDER<>(typeof(h.CLEAN_GENDER))'');
    populated_CLASS_CODE_pcnt := AVE(GROUP,IF(h.CLASS_CODE = (TYPEOF(h.CLASS_CODE))'',0,100));
    maxlength_CLASS_CODE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.CLASS_CODE)));
    avelength_CLASS_CODE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.CLASS_CODE)),h.CLASS_CODE<>(typeof(h.CLASS_CODE))'');
    populated_DT_FIRST_SEEN_pcnt := AVE(GROUP,IF(h.DT_FIRST_SEEN = (TYPEOF(h.DT_FIRST_SEEN))'',0,100));
    maxlength_DT_FIRST_SEEN := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.DT_FIRST_SEEN)));
    avelength_DT_FIRST_SEEN := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.DT_FIRST_SEEN)),h.DT_FIRST_SEEN<>(typeof(h.DT_FIRST_SEEN))'');
    populated_DT_LAST_SEEN_pcnt := AVE(GROUP,IF(h.DT_LAST_SEEN = (TYPEOF(h.DT_LAST_SEEN))'',0,100));
    maxlength_DT_LAST_SEEN := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.DT_LAST_SEEN)));
    avelength_DT_LAST_SEEN := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.DT_LAST_SEEN)),h.DT_LAST_SEEN<>(typeof(h.DT_LAST_SEEN))'');
    populated_DATA_PROVIDER_ORI_pcnt := AVE(GROUP,IF(h.DATA_PROVIDER_ORI = (TYPEOF(h.DATA_PROVIDER_ORI))'',0,100));
    maxlength_DATA_PROVIDER_ORI := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.DATA_PROVIDER_ORI)));
    avelength_DATA_PROVIDER_ORI := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.DATA_PROVIDER_ORI)),h.DATA_PROVIDER_ORI<>(typeof(h.DATA_PROVIDER_ORI))'');
    populated_VIN_pcnt := AVE(GROUP,IF(h.VIN = (TYPEOF(h.VIN))'',0,100));
    maxlength_VIN := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.VIN)));
    avelength_VIN := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.VIN)),h.VIN<>(typeof(h.VIN))'');
    populated_PLATE_pcnt := AVE(GROUP,IF(h.PLATE = (TYPEOF(h.PLATE))'',0,100));
    maxlength_PLATE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.PLATE)));
    avelength_PLATE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.PLATE)),h.PLATE<>(typeof(h.PLATE))'');
    populated_LATITUDE_pcnt := AVE(GROUP,IF(h.LATITUDE = (TYPEOF(h.LATITUDE))'',0,100));
    maxlength_LATITUDE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.LATITUDE)));
    avelength_LATITUDE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.LATITUDE)),h.LATITUDE<>(typeof(h.LATITUDE))'');
    populated_LONGITUDE_pcnt := AVE(GROUP,IF(h.LONGITUDE = (TYPEOF(h.LONGITUDE))'',0,100));
    maxlength_LONGITUDE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.LONGITUDE)));
    avelength_LONGITUDE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.LONGITUDE)),h.LONGITUDE<>(typeof(h.LONGITUDE))'');
    populated_SEARCH_ADDR1_pcnt := AVE(GROUP,IF(h.SEARCH_ADDR1 = (TYPEOF(h.SEARCH_ADDR1))'',0,100));
    maxlength_SEARCH_ADDR1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.SEARCH_ADDR1)));
    avelength_SEARCH_ADDR1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.SEARCH_ADDR1)),h.SEARCH_ADDR1<>(typeof(h.SEARCH_ADDR1))'');
    populated_SEARCH_ADDR2_pcnt := AVE(GROUP,IF(h.SEARCH_ADDR2 = (TYPEOF(h.SEARCH_ADDR2))'',0,100));
    maxlength_SEARCH_ADDR2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.SEARCH_ADDR2)));
    avelength_SEARCH_ADDR2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.SEARCH_ADDR2)),h.SEARCH_ADDR2<>(typeof(h.SEARCH_ADDR2))'');
    populated_CLEAN_COMPANY_NAME_pcnt := AVE(GROUP,IF(h.CLEAN_COMPANY_NAME = (TYPEOF(h.CLEAN_COMPANY_NAME))'',0,100));
    maxlength_CLEAN_COMPANY_NAME := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.CLEAN_COMPANY_NAME)));
    avelength_CLEAN_COMPANY_NAME := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.CLEAN_COMPANY_NAME)),h.CLEAN_COMPANY_NAME<>(typeof(h.CLEAN_COMPANY_NAME))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_NAME_SUFFIX_pcnt *   6.00 / 100 + T.Populated_FNAME_pcnt *   9.00 / 100 + T.Populated_MNAME_pcnt *   8.00 / 100 + T.Populated_LNAME_pcnt *  11.00 / 100 + T.Populated_PRIM_RANGE_pcnt *  11.00 / 100 + T.Populated_PRIM_NAME_pcnt *  11.00 / 100 + T.Populated_SEC_RANGE_pcnt *   8.00 / 100 + T.Populated_P_CITY_NAME_pcnt *  10.00 / 100 + T.Populated_ST_pcnt *   5.00 / 100 + T.Populated_ZIP_pcnt *  14.00 / 100 + T.Populated_DOB_pcnt *  15.00 / 100 + T.Populated_PHONE_pcnt *  21.00 / 100 + T.Populated_DL_ST_pcnt *   9.00 / 100 + T.Populated_DL_pcnt *  23.00 / 100 + T.Populated_LEXID_pcnt *  15.00 / 100 + T.Populated_POSSIBLE_SSN_pcnt *  24.00 / 100 + T.Populated_CRIME_pcnt *  10.00 / 100 + T.Populated_NAME_TYPE_pcnt *  10.00 / 100 + T.Populated_CLEAN_GENDER_pcnt *  10.00 / 100 + T.Populated_CLASS_CODE_pcnt *  10.00 / 100 + T.Populated_DT_FIRST_SEEN_pcnt *   1.00 / 100 + T.Populated_DT_LAST_SEEN_pcnt *   1.00 / 100 + T.Populated_DATA_PROVIDER_ORI_pcnt *  10.00 / 100 + T.Populated_VIN_pcnt *  12.00 / 100 + T.Populated_PLATE_pcnt *   1.00 / 100 + T.Populated_LATITUDE_pcnt *   1.00 / 100 + T.Populated_LONGITUDE_pcnt *   1.00 / 100 + T.Populated_SEARCH_ADDR1_pcnt *  18.00 / 100 + T.Populated_SEARCH_ADDR2_pcnt *  20.00 / 100 + T.Populated_CLEAN_COMPANY_NAME_pcnt *  22.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT33.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'NAME_SUFFIX','FNAME','MNAME','LNAME','PRIM_RANGE','PRIM_NAME','SEC_RANGE','P_CITY_NAME','ST','ZIP','DOB','PHONE','DL_ST','DL','LEXID','POSSIBLE_SSN','CRIME','NAME_TYPE','CLEAN_GENDER','CLASS_CODE','DT_FIRST_SEEN','DT_LAST_SEEN','DATA_PROVIDER_ORI','VIN','PLATE','LATITUDE','LONGITUDE','SEARCH_ADDR1','SEARCH_ADDR2','CLEAN_COMPANY_NAME');
  SELF.populated_pcnt := CHOOSE(C,le.populated_NAME_SUFFIX_pcnt,le.populated_FNAME_pcnt,le.populated_MNAME_pcnt,le.populated_LNAME_pcnt,le.populated_PRIM_RANGE_pcnt,le.populated_PRIM_NAME_pcnt,le.populated_SEC_RANGE_pcnt,le.populated_P_CITY_NAME_pcnt,le.populated_ST_pcnt,le.populated_ZIP_pcnt,le.populated_DOB_pcnt,le.populated_PHONE_pcnt,le.populated_DL_ST_pcnt,le.populated_DL_pcnt,le.populated_LEXID_pcnt,le.populated_POSSIBLE_SSN_pcnt,le.populated_CRIME_pcnt,le.populated_NAME_TYPE_pcnt,le.populated_CLEAN_GENDER_pcnt,le.populated_CLASS_CODE_pcnt,le.populated_DT_FIRST_SEEN_pcnt,le.populated_DT_LAST_SEEN_pcnt,le.populated_DATA_PROVIDER_ORI_pcnt,le.populated_VIN_pcnt,le.populated_PLATE_pcnt,le.populated_LATITUDE_pcnt,le.populated_LONGITUDE_pcnt,le.populated_SEARCH_ADDR1_pcnt,le.populated_SEARCH_ADDR2_pcnt,le.populated_CLEAN_COMPANY_NAME_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_NAME_SUFFIX,le.maxlength_FNAME,le.maxlength_MNAME,le.maxlength_LNAME,le.maxlength_PRIM_RANGE,le.maxlength_PRIM_NAME,le.maxlength_SEC_RANGE,le.maxlength_P_CITY_NAME,le.maxlength_ST,le.maxlength_ZIP,le.maxlength_DOB,le.maxlength_PHONE,le.maxlength_DL_ST,le.maxlength_DL,le.maxlength_LEXID,le.maxlength_POSSIBLE_SSN,le.maxlength_CRIME,le.maxlength_NAME_TYPE,le.maxlength_CLEAN_GENDER,le.maxlength_CLASS_CODE,le.maxlength_DT_FIRST_SEEN,le.maxlength_DT_LAST_SEEN,le.maxlength_DATA_PROVIDER_ORI,le.maxlength_VIN,le.maxlength_PLATE,le.maxlength_LATITUDE,le.maxlength_LONGITUDE,le.maxlength_SEARCH_ADDR1,le.maxlength_SEARCH_ADDR2,le.maxlength_CLEAN_COMPANY_NAME);
  SELF.avelength := CHOOSE(C,le.avelength_NAME_SUFFIX,le.avelength_FNAME,le.avelength_MNAME,le.avelength_LNAME,le.avelength_PRIM_RANGE,le.avelength_PRIM_NAME,le.avelength_SEC_RANGE,le.avelength_P_CITY_NAME,le.avelength_ST,le.avelength_ZIP,le.avelength_DOB,le.avelength_PHONE,le.avelength_DL_ST,le.avelength_DL,le.avelength_LEXID,le.avelength_POSSIBLE_SSN,le.avelength_CRIME,le.avelength_NAME_TYPE,le.avelength_CLEAN_GENDER,le.avelength_CLASS_CODE,le.avelength_DT_FIRST_SEEN,le.avelength_DT_LAST_SEEN,le.avelength_DATA_PROVIDER_ORI,le.avelength_VIN,le.avelength_PLATE,le.avelength_LATITUDE,le.avelength_LONGITUDE,le.avelength_SEARCH_ADDR1,le.avelength_SEARCH_ADDR2,le.avelength_CLEAN_COMPANY_NAME);
END;
EXPORT invSummary := NORMALIZE(summary0, 30, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.EID_HASH;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.NAME_SUFFIX),TRIM((SALT33.StrType)le.FNAME),TRIM((SALT33.StrType)le.MNAME),TRIM((SALT33.StrType)le.LNAME),TRIM((SALT33.StrType)le.PRIM_RANGE),TRIM((SALT33.StrType)le.PRIM_NAME),TRIM((SALT33.StrType)le.SEC_RANGE),TRIM((SALT33.StrType)le.P_CITY_NAME),TRIM((SALT33.StrType)le.ST),TRIM((SALT33.StrType)le.ZIP),TRIM((SALT33.StrType)le.DOB),TRIM((SALT33.StrType)le.PHONE),TRIM((SALT33.StrType)le.DL_ST),TRIM((SALT33.StrType)le.DL),TRIM((SALT33.StrType)le.LEXID),TRIM((SALT33.StrType)le.POSSIBLE_SSN),TRIM((SALT33.StrType)le.CRIME),TRIM((SALT33.StrType)le.NAME_TYPE),TRIM((SALT33.StrType)le.CLEAN_GENDER),TRIM((SALT33.StrType)le.CLASS_CODE),TRIM((SALT33.StrType)le.DT_FIRST_SEEN),TRIM((SALT33.StrType)le.DT_LAST_SEEN),TRIM((SALT33.StrType)le.DATA_PROVIDER_ORI),TRIM((SALT33.StrType)le.VIN),TRIM((SALT33.StrType)le.PLATE),TRIM((SALT33.StrType)le.LATITUDE),TRIM((SALT33.StrType)le.LONGITUDE),TRIM((SALT33.StrType)le.SEARCH_ADDR1),TRIM((SALT33.StrType)le.SEARCH_ADDR2),TRIM((SALT33.StrType)le.CLEAN_COMPANY_NAME)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,30,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 30);
  SELF.FldNo2 := 1 + (C % 30);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.NAME_SUFFIX),TRIM((SALT33.StrType)le.FNAME),TRIM((SALT33.StrType)le.MNAME),TRIM((SALT33.StrType)le.LNAME),TRIM((SALT33.StrType)le.PRIM_RANGE),TRIM((SALT33.StrType)le.PRIM_NAME),TRIM((SALT33.StrType)le.SEC_RANGE),TRIM((SALT33.StrType)le.P_CITY_NAME),TRIM((SALT33.StrType)le.ST),TRIM((SALT33.StrType)le.ZIP),TRIM((SALT33.StrType)le.DOB),TRIM((SALT33.StrType)le.PHONE),TRIM((SALT33.StrType)le.DL_ST),TRIM((SALT33.StrType)le.DL),TRIM((SALT33.StrType)le.LEXID),TRIM((SALT33.StrType)le.POSSIBLE_SSN),TRIM((SALT33.StrType)le.CRIME),TRIM((SALT33.StrType)le.NAME_TYPE),TRIM((SALT33.StrType)le.CLEAN_GENDER),TRIM((SALT33.StrType)le.CLASS_CODE),TRIM((SALT33.StrType)le.DT_FIRST_SEEN),TRIM((SALT33.StrType)le.DT_LAST_SEEN),TRIM((SALT33.StrType)le.DATA_PROVIDER_ORI),TRIM((SALT33.StrType)le.VIN),TRIM((SALT33.StrType)le.PLATE),TRIM((SALT33.StrType)le.LATITUDE),TRIM((SALT33.StrType)le.LONGITUDE),TRIM((SALT33.StrType)le.SEARCH_ADDR1),TRIM((SALT33.StrType)le.SEARCH_ADDR2),TRIM((SALT33.StrType)le.CLEAN_COMPANY_NAME)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.NAME_SUFFIX),TRIM((SALT33.StrType)le.FNAME),TRIM((SALT33.StrType)le.MNAME),TRIM((SALT33.StrType)le.LNAME),TRIM((SALT33.StrType)le.PRIM_RANGE),TRIM((SALT33.StrType)le.PRIM_NAME),TRIM((SALT33.StrType)le.SEC_RANGE),TRIM((SALT33.StrType)le.P_CITY_NAME),TRIM((SALT33.StrType)le.ST),TRIM((SALT33.StrType)le.ZIP),TRIM((SALT33.StrType)le.DOB),TRIM((SALT33.StrType)le.PHONE),TRIM((SALT33.StrType)le.DL_ST),TRIM((SALT33.StrType)le.DL),TRIM((SALT33.StrType)le.LEXID),TRIM((SALT33.StrType)le.POSSIBLE_SSN),TRIM((SALT33.StrType)le.CRIME),TRIM((SALT33.StrType)le.NAME_TYPE),TRIM((SALT33.StrType)le.CLEAN_GENDER),TRIM((SALT33.StrType)le.CLASS_CODE),TRIM((SALT33.StrType)le.DT_FIRST_SEEN),TRIM((SALT33.StrType)le.DT_LAST_SEEN),TRIM((SALT33.StrType)le.DATA_PROVIDER_ORI),TRIM((SALT33.StrType)le.VIN),TRIM((SALT33.StrType)le.PLATE),TRIM((SALT33.StrType)le.LATITUDE),TRIM((SALT33.StrType)le.LONGITUDE),TRIM((SALT33.StrType)le.SEARCH_ADDR1),TRIM((SALT33.StrType)le.SEARCH_ADDR2),TRIM((SALT33.StrType)le.CLEAN_COMPANY_NAME)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),30*30,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'NAME_SUFFIX'}
      ,{2,'FNAME'}
      ,{3,'MNAME'}
      ,{4,'LNAME'}
      ,{5,'PRIM_RANGE'}
      ,{6,'PRIM_NAME'}
      ,{7,'SEC_RANGE'}
      ,{8,'P_CITY_NAME'}
      ,{9,'ST'}
      ,{10,'ZIP'}
      ,{11,'DOB'}
      ,{12,'PHONE'}
      ,{13,'DL_ST'}
      ,{14,'DL'}
      ,{15,'LEXID'}
      ,{16,'POSSIBLE_SSN'}
      ,{17,'CRIME'}
      ,{18,'NAME_TYPE'}
      ,{19,'CLEAN_GENDER'}
      ,{20,'CLASS_CODE'}
      ,{21,'DT_FIRST_SEEN'}
      ,{22,'DT_LAST_SEEN'}
      ,{23,'DATA_PROVIDER_ORI'}
      ,{24,'VIN'}
      ,{25,'PLATE'}
      ,{26,'LATITUDE'}
      ,{27,'LONGITUDE'}
      ,{28,'SEARCH_ADDR1'}
      ,{29,'SEARCH_ADDR2'}
      ,{30,'CLEAN_COMPANY_NAME'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_NAME_SUFFIX((SALT33.StrType)le.NAME_SUFFIX),
    Fields.InValid_FNAME((SALT33.StrType)le.FNAME),
    Fields.InValid_MNAME((SALT33.StrType)le.MNAME),
    Fields.InValid_LNAME((SALT33.StrType)le.LNAME),
    Fields.InValid_PRIM_RANGE((SALT33.StrType)le.PRIM_RANGE),
    Fields.InValid_PRIM_NAME((SALT33.StrType)le.PRIM_NAME),
    Fields.InValid_SEC_RANGE((SALT33.StrType)le.SEC_RANGE),
    Fields.InValid_P_CITY_NAME((SALT33.StrType)le.P_CITY_NAME),
    Fields.InValid_ST((SALT33.StrType)le.ST),
    Fields.InValid_ZIP((SALT33.StrType)le.ZIP),
    Fields.InValid_DOB((SALT33.StrType)le.DOB),
    Fields.InValid_PHONE((SALT33.StrType)le.PHONE),
    Fields.InValid_DL_ST((SALT33.StrType)le.DL_ST),
    Fields.InValid_DL((SALT33.StrType)le.DL),
    Fields.InValid_LEXID((SALT33.StrType)le.LEXID),
    Fields.InValid_POSSIBLE_SSN((SALT33.StrType)le.POSSIBLE_SSN),
    Fields.InValid_CRIME((SALT33.StrType)le.CRIME),
    Fields.InValid_NAME_TYPE((SALT33.StrType)le.NAME_TYPE),
    Fields.InValid_CLEAN_GENDER((SALT33.StrType)le.CLEAN_GENDER),
    Fields.InValid_CLASS_CODE((SALT33.StrType)le.CLASS_CODE),
    Fields.InValid_DT_FIRST_SEEN((SALT33.StrType)le.DT_FIRST_SEEN),
    Fields.InValid_DT_LAST_SEEN((SALT33.StrType)le.DT_LAST_SEEN),
    Fields.InValid_DATA_PROVIDER_ORI((SALT33.StrType)le.DATA_PROVIDER_ORI),
    Fields.InValid_VIN((SALT33.StrType)le.VIN),
    Fields.InValid_PLATE((SALT33.StrType)le.PLATE),
    Fields.InValid_LATITUDE((SALT33.StrType)le.LATITUDE),
    Fields.InValid_LONGITUDE((SALT33.StrType)le.LONGITUDE),
    Fields.InValid_SEARCH_ADDR1((SALT33.StrType)le.SEARCH_ADDR1),
    Fields.InValid_SEARCH_ADDR2((SALT33.StrType)le.SEARCH_ADDR2),
    Fields.InValid_CLEAN_COMPANY_NAME((SALT33.StrType)le.CLEAN_COMPANY_NAME),
    0, // Uncleanable field
    0, // Uncleanable field
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,32,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','NUMBER','DEFAULT','NUMBER','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_NAME_SUFFIX(TotalErrors.ErrorNum),Fields.InValidMessage_FNAME(TotalErrors.ErrorNum),Fields.InValidMessage_MNAME(TotalErrors.ErrorNum),Fields.InValidMessage_LNAME(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_SEC_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_P_CITY_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_ST(TotalErrors.ErrorNum),Fields.InValidMessage_ZIP(TotalErrors.ErrorNum),Fields.InValidMessage_DOB(TotalErrors.ErrorNum),Fields.InValidMessage_PHONE(TotalErrors.ErrorNum),Fields.InValidMessage_DL_ST(TotalErrors.ErrorNum),Fields.InValidMessage_DL(TotalErrors.ErrorNum),Fields.InValidMessage_LEXID(TotalErrors.ErrorNum),Fields.InValidMessage_POSSIBLE_SSN(TotalErrors.ErrorNum),Fields.InValidMessage_CRIME(TotalErrors.ErrorNum),Fields.InValidMessage_NAME_TYPE(TotalErrors.ErrorNum),Fields.InValidMessage_CLEAN_GENDER(TotalErrors.ErrorNum),Fields.InValidMessage_CLASS_CODE(TotalErrors.ErrorNum),Fields.InValidMessage_DT_FIRST_SEEN(TotalErrors.ErrorNum),Fields.InValidMessage_DT_LAST_SEEN(TotalErrors.ErrorNum),Fields.InValidMessage_DATA_PROVIDER_ORI(TotalErrors.ErrorNum),Fields.InValidMessage_VIN(TotalErrors.ErrorNum),Fields.InValidMessage_PLATE(TotalErrors.ErrorNum),Fields.InValidMessage_LATITUDE(TotalErrors.ErrorNum),Fields.InValidMessage_LONGITUDE(TotalErrors.ErrorNum),Fields.InValidMessage_SEARCH_ADDR1(TotalErrors.ErrorNum),Fields.InValidMessage_SEARCH_ADDR2(TotalErrors.ErrorNum),Fields.InValidMessage_CLEAN_COMPANY_NAME(TotalErrors.ErrorNum),'','');
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
//We have EID_HASH specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT33.MOD_ClusterStats.Counts(h,EID_HASH);
END;
