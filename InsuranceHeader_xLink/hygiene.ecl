IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_InsuranceHeader) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.SRC))'', MAX(GROUP,h.SRC));
    NumberOfRecords := COUNT(GROUP);
    populated_SNAME_cnt := COUNT(GROUP,h.SNAME <> (TYPEOF(h.SNAME))'');
    populated_SNAME_pcnt := AVE(GROUP,IF(h.SNAME = (TYPEOF(h.SNAME))'',0,100));
    maxlength_SNAME := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.SNAME)));
    avelength_SNAME := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.SNAME)),h.SNAME<>(typeof(h.SNAME))'');
    populated_FNAME_cnt := COUNT(GROUP,h.FNAME <> (TYPEOF(h.FNAME))'');
    populated_FNAME_pcnt := AVE(GROUP,IF(h.FNAME = (TYPEOF(h.FNAME))'',0,100));
    maxlength_FNAME := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.FNAME)));
    avelength_FNAME := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.FNAME)),h.FNAME<>(typeof(h.FNAME))'');
    populated_MNAME_cnt := COUNT(GROUP,h.MNAME <> (TYPEOF(h.MNAME))'');
    populated_MNAME_pcnt := AVE(GROUP,IF(h.MNAME = (TYPEOF(h.MNAME))'',0,100));
    maxlength_MNAME := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.MNAME)));
    avelength_MNAME := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.MNAME)),h.MNAME<>(typeof(h.MNAME))'');
    populated_LNAME_cnt := COUNT(GROUP,h.LNAME <> (TYPEOF(h.LNAME))'');
    populated_LNAME_pcnt := AVE(GROUP,IF(h.LNAME = (TYPEOF(h.LNAME))'',0,100));
    maxlength_LNAME := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.LNAME)));
    avelength_LNAME := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.LNAME)),h.LNAME<>(typeof(h.LNAME))'');
    populated_DERIVED_GENDER_cnt := COUNT(GROUP,h.DERIVED_GENDER <> (TYPEOF(h.DERIVED_GENDER))'');
    populated_DERIVED_GENDER_pcnt := AVE(GROUP,IF(h.DERIVED_GENDER = (TYPEOF(h.DERIVED_GENDER))'',0,100));
    maxlength_DERIVED_GENDER := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.DERIVED_GENDER)));
    avelength_DERIVED_GENDER := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.DERIVED_GENDER)),h.DERIVED_GENDER<>(typeof(h.DERIVED_GENDER))'');
    populated_PRIM_RANGE_cnt := COUNT(GROUP,h.PRIM_RANGE <> (TYPEOF(h.PRIM_RANGE))'');
    populated_PRIM_RANGE_pcnt := AVE(GROUP,IF(h.PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',0,100));
    maxlength_PRIM_RANGE := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.PRIM_RANGE)));
    avelength_PRIM_RANGE := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.PRIM_RANGE)),h.PRIM_RANGE<>(typeof(h.PRIM_RANGE))'');
    populated_PRIM_NAME_cnt := COUNT(GROUP,h.PRIM_NAME <> (TYPEOF(h.PRIM_NAME))'');
    populated_PRIM_NAME_pcnt := AVE(GROUP,IF(h.PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',0,100));
    maxlength_PRIM_NAME := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.PRIM_NAME)));
    avelength_PRIM_NAME := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.PRIM_NAME)),h.PRIM_NAME<>(typeof(h.PRIM_NAME))'');
    populated_SEC_RANGE_cnt := COUNT(GROUP,h.SEC_RANGE <> (TYPEOF(h.SEC_RANGE))'');
    populated_SEC_RANGE_pcnt := AVE(GROUP,IF(h.SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',0,100));
    maxlength_SEC_RANGE := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.SEC_RANGE)));
    avelength_SEC_RANGE := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.SEC_RANGE)),h.SEC_RANGE<>(typeof(h.SEC_RANGE))'');
    populated_CITY_cnt := COUNT(GROUP,h.CITY <> (TYPEOF(h.CITY))'');
    populated_CITY_pcnt := AVE(GROUP,IF(h.CITY = (TYPEOF(h.CITY))'',0,100));
    maxlength_CITY := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.CITY)));
    avelength_CITY := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.CITY)),h.CITY<>(typeof(h.CITY))'');
    populated_ST_cnt := COUNT(GROUP,h.ST <> (TYPEOF(h.ST))'');
    populated_ST_pcnt := AVE(GROUP,IF(h.ST = (TYPEOF(h.ST))'',0,100));
    maxlength_ST := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ST)));
    avelength_ST := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ST)),h.ST<>(typeof(h.ST))'');
    populated_ZIP_cnt := COUNT(GROUP,h.ZIP <> (TYPEOF(h.ZIP))'');
    populated_ZIP_pcnt := AVE(GROUP,IF(h.ZIP = (TYPEOF(h.ZIP))'',0,100));
    maxlength_ZIP := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ZIP)));
    avelength_ZIP := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ZIP)),h.ZIP<>(typeof(h.ZIP))'');
    populated_SSN5_cnt := COUNT(GROUP,h.SSN5 <> (TYPEOF(h.SSN5))'');
    populated_SSN5_pcnt := AVE(GROUP,IF(h.SSN5 = (TYPEOF(h.SSN5))'',0,100));
    maxlength_SSN5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.SSN5)));
    avelength_SSN5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.SSN5)),h.SSN5<>(typeof(h.SSN5))'');
    populated_SSN4_cnt := COUNT(GROUP,h.SSN4 <> (TYPEOF(h.SSN4))'');
    populated_SSN4_pcnt := AVE(GROUP,IF(h.SSN4 = (TYPEOF(h.SSN4))'',0,100));
    maxlength_SSN4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.SSN4)));
    avelength_SSN4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.SSN4)),h.SSN4<>(typeof(h.SSN4))'');
    populated_DOB_cnt := COUNT(GROUP,h.DOB <> (TYPEOF(h.DOB))'');
    populated_DOB_pcnt := AVE(GROUP,IF(h.DOB = (TYPEOF(h.DOB))'',0,100));
    maxlength_DOB := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.DOB)));
    avelength_DOB := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.DOB)),h.DOB<>(typeof(h.DOB))'');
    populated_PHONE_cnt := COUNT(GROUP,h.PHONE <> (TYPEOF(h.PHONE))'');
    populated_PHONE_pcnt := AVE(GROUP,IF(h.PHONE = (TYPEOF(h.PHONE))'',0,100));
    maxlength_PHONE := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.PHONE)));
    avelength_PHONE := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.PHONE)),h.PHONE<>(typeof(h.PHONE))'');
    populated_DL_STATE_cnt := COUNT(GROUP,h.DL_STATE <> (TYPEOF(h.DL_STATE))'');
    populated_DL_STATE_pcnt := AVE(GROUP,IF(h.DL_STATE = (TYPEOF(h.DL_STATE))'',0,100));
    maxlength_DL_STATE := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.DL_STATE)));
    avelength_DL_STATE := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.DL_STATE)),h.DL_STATE<>(typeof(h.DL_STATE))'');
    populated_DL_NBR_cnt := COUNT(GROUP,h.DL_NBR <> (TYPEOF(h.DL_NBR))'');
    populated_DL_NBR_pcnt := AVE(GROUP,IF(h.DL_NBR = (TYPEOF(h.DL_NBR))'',0,100));
    maxlength_DL_NBR := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.DL_NBR)));
    avelength_DL_NBR := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.DL_NBR)),h.DL_NBR<>(typeof(h.DL_NBR))'');
    populated_SRC_cnt := COUNT(GROUP,h.SRC <> (TYPEOF(h.SRC))'');
    populated_SRC_pcnt := AVE(GROUP,IF(h.SRC = (TYPEOF(h.SRC))'',0,100));
    maxlength_SRC := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.SRC)));
    avelength_SRC := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.SRC)),h.SRC<>(typeof(h.SRC))'');
    populated_SOURCE_RID_cnt := COUNT(GROUP,h.SOURCE_RID <> (TYPEOF(h.SOURCE_RID))'');
    populated_SOURCE_RID_pcnt := AVE(GROUP,IF(h.SOURCE_RID = (TYPEOF(h.SOURCE_RID))'',0,100));
    maxlength_SOURCE_RID := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.SOURCE_RID)));
    avelength_SOURCE_RID := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.SOURCE_RID)),h.SOURCE_RID<>(typeof(h.SOURCE_RID))'');
    populated_DT_FIRST_SEEN_cnt := COUNT(GROUP,h.DT_FIRST_SEEN <> (TYPEOF(h.DT_FIRST_SEEN))'');
    populated_DT_FIRST_SEEN_pcnt := AVE(GROUP,IF(h.DT_FIRST_SEEN = (TYPEOF(h.DT_FIRST_SEEN))'',0,100));
    maxlength_DT_FIRST_SEEN := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.DT_FIRST_SEEN)));
    avelength_DT_FIRST_SEEN := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.DT_FIRST_SEEN)),h.DT_FIRST_SEEN<>(typeof(h.DT_FIRST_SEEN))'');
    populated_DT_LAST_SEEN_cnt := COUNT(GROUP,h.DT_LAST_SEEN <> (TYPEOF(h.DT_LAST_SEEN))'');
    populated_DT_LAST_SEEN_pcnt := AVE(GROUP,IF(h.DT_LAST_SEEN = (TYPEOF(h.DT_LAST_SEEN))'',0,100));
    maxlength_DT_LAST_SEEN := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.DT_LAST_SEEN)));
    avelength_DT_LAST_SEEN := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.DT_LAST_SEEN)),h.DT_LAST_SEEN<>(typeof(h.DT_LAST_SEEN))'');
    populated_DT_EFFECTIVE_FIRST_cnt := COUNT(GROUP,h.DT_EFFECTIVE_FIRST <> (TYPEOF(h.DT_EFFECTIVE_FIRST))'');
    populated_DT_EFFECTIVE_FIRST_pcnt := AVE(GROUP,IF(h.DT_EFFECTIVE_FIRST = (TYPEOF(h.DT_EFFECTIVE_FIRST))'',0,100));
    maxlength_DT_EFFECTIVE_FIRST := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.DT_EFFECTIVE_FIRST)));
    avelength_DT_EFFECTIVE_FIRST := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.DT_EFFECTIVE_FIRST)),h.DT_EFFECTIVE_FIRST<>(typeof(h.DT_EFFECTIVE_FIRST))'');
    populated_DT_EFFECTIVE_LAST_cnt := COUNT(GROUP,h.DT_EFFECTIVE_LAST <> (TYPEOF(h.DT_EFFECTIVE_LAST))'');
    populated_DT_EFFECTIVE_LAST_pcnt := AVE(GROUP,IF(h.DT_EFFECTIVE_LAST = (TYPEOF(h.DT_EFFECTIVE_LAST))'',0,100));
    maxlength_DT_EFFECTIVE_LAST := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.DT_EFFECTIVE_LAST)));
    avelength_DT_EFFECTIVE_LAST := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.DT_EFFECTIVE_LAST)),h.DT_EFFECTIVE_LAST<>(typeof(h.DT_EFFECTIVE_LAST))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,SRC,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_SNAME_pcnt *   6.00 / 100 + T.Populated_FNAME_pcnt *   9.00 / 100 + T.Populated_MNAME_pcnt *   8.00 / 100 + T.Populated_LNAME_pcnt *  11.00 / 100 + T.Populated_DERIVED_GENDER_pcnt *   1.00 / 100 + T.Populated_PRIM_RANGE_pcnt *  11.00 / 100 + T.Populated_PRIM_NAME_pcnt *  11.00 / 100 + T.Populated_SEC_RANGE_pcnt *   8.00 / 100 + T.Populated_CITY_pcnt *  10.00 / 100 + T.Populated_ST_pcnt *   5.00 / 100 + T.Populated_ZIP_pcnt *  14.00 / 100 + T.Populated_SSN5_pcnt *  15.00 / 100 + T.Populated_SSN4_pcnt *  13.00 / 100 + T.Populated_DOB_pcnt *  15.00 / 100 + T.Populated_PHONE_pcnt *  21.00 / 100 + T.Populated_DL_STATE_pcnt *   9.00 / 100 + T.Populated_DL_NBR_pcnt *  23.00 / 100 + T.Populated_SRC_pcnt *   3.00 / 100 + T.Populated_SOURCE_RID_pcnt *  23.00 / 100 + T.Populated_DT_FIRST_SEEN_pcnt *   0.00 / 100 + T.Populated_DT_LAST_SEEN_pcnt *   0.00 / 100 + T.Populated_DT_EFFECTIVE_FIRST_pcnt *   0.00 / 100 + T.Populated_DT_EFFECTIVE_LAST_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING SRC1;
    STRING SRC2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.SRC1 := le.Source;
    SELF.SRC2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_SNAME_pcnt*ri.Populated_SNAME_pcnt *   6.00 / 10000 + le.Populated_FNAME_pcnt*ri.Populated_FNAME_pcnt *   9.00 / 10000 + le.Populated_MNAME_pcnt*ri.Populated_MNAME_pcnt *   8.00 / 10000 + le.Populated_LNAME_pcnt*ri.Populated_LNAME_pcnt *  11.00 / 10000 + le.Populated_DERIVED_GENDER_pcnt*ri.Populated_DERIVED_GENDER_pcnt *   1.00 / 10000 + le.Populated_PRIM_RANGE_pcnt*ri.Populated_PRIM_RANGE_pcnt *  11.00 / 10000 + le.Populated_PRIM_NAME_pcnt*ri.Populated_PRIM_NAME_pcnt *  11.00 / 10000 + le.Populated_SEC_RANGE_pcnt*ri.Populated_SEC_RANGE_pcnt *   8.00 / 10000 + le.Populated_CITY_pcnt*ri.Populated_CITY_pcnt *  10.00 / 10000 + le.Populated_ST_pcnt*ri.Populated_ST_pcnt *   5.00 / 10000 + le.Populated_ZIP_pcnt*ri.Populated_ZIP_pcnt *  14.00 / 10000 + le.Populated_SSN5_pcnt*ri.Populated_SSN5_pcnt *  15.00 / 10000 + le.Populated_SSN4_pcnt*ri.Populated_SSN4_pcnt *  13.00 / 10000 + le.Populated_DOB_pcnt*ri.Populated_DOB_pcnt *  15.00 / 10000 + le.Populated_PHONE_pcnt*ri.Populated_PHONE_pcnt *  21.00 / 10000 + le.Populated_DL_STATE_pcnt*ri.Populated_DL_STATE_pcnt *   9.00 / 10000 + le.Populated_DL_NBR_pcnt*ri.Populated_DL_NBR_pcnt *  23.00 / 10000 + le.Populated_SRC_pcnt*ri.Populated_SRC_pcnt *   3.00 / 10000 + le.Populated_SOURCE_RID_pcnt*ri.Populated_SOURCE_RID_pcnt *  23.00 / 10000 + le.Populated_DT_FIRST_SEEN_pcnt*ri.Populated_DT_FIRST_SEEN_pcnt *   0.00 / 10000 + le.Populated_DT_LAST_SEEN_pcnt*ri.Populated_DT_LAST_SEEN_pcnt *   0.00 / 10000 + le.Populated_DT_EFFECTIVE_FIRST_pcnt*ri.Populated_DT_EFFECTIVE_FIRST_pcnt *   0.00 / 10000 + le.Populated_DT_EFFECTIVE_LAST_pcnt*ri.Populated_DT_EFFECTIVE_LAST_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'SNAME','FNAME','MNAME','LNAME','DERIVED_GENDER','PRIM_RANGE','PRIM_NAME','SEC_RANGE','CITY','ST','ZIP','SSN5','SSN4','DOB','PHONE','DL_STATE','DL_NBR','SRC','SOURCE_RID','DT_FIRST_SEEN','DT_LAST_SEEN','DT_EFFECTIVE_FIRST','DT_EFFECTIVE_LAST');
  SELF.populated_pcnt := CHOOSE(C,le.populated_SNAME_pcnt,le.populated_FNAME_pcnt,le.populated_MNAME_pcnt,le.populated_LNAME_pcnt,le.populated_DERIVED_GENDER_pcnt,le.populated_PRIM_RANGE_pcnt,le.populated_PRIM_NAME_pcnt,le.populated_SEC_RANGE_pcnt,le.populated_CITY_pcnt,le.populated_ST_pcnt,le.populated_ZIP_pcnt,le.populated_SSN5_pcnt,le.populated_SSN4_pcnt,le.populated_DOB_pcnt,le.populated_PHONE_pcnt,le.populated_DL_STATE_pcnt,le.populated_DL_NBR_pcnt,le.populated_SRC_pcnt,le.populated_SOURCE_RID_pcnt,le.populated_DT_FIRST_SEEN_pcnt,le.populated_DT_LAST_SEEN_pcnt,le.populated_DT_EFFECTIVE_FIRST_pcnt,le.populated_DT_EFFECTIVE_LAST_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_SNAME,le.maxlength_FNAME,le.maxlength_MNAME,le.maxlength_LNAME,le.maxlength_DERIVED_GENDER,le.maxlength_PRIM_RANGE,le.maxlength_PRIM_NAME,le.maxlength_SEC_RANGE,le.maxlength_CITY,le.maxlength_ST,le.maxlength_ZIP,le.maxlength_SSN5,le.maxlength_SSN4,le.maxlength_DOB,le.maxlength_PHONE,le.maxlength_DL_STATE,le.maxlength_DL_NBR,le.maxlength_SRC,le.maxlength_SOURCE_RID,le.maxlength_DT_FIRST_SEEN,le.maxlength_DT_LAST_SEEN,le.maxlength_DT_EFFECTIVE_FIRST,le.maxlength_DT_EFFECTIVE_LAST);
  SELF.avelength := CHOOSE(C,le.avelength_SNAME,le.avelength_FNAME,le.avelength_MNAME,le.avelength_LNAME,le.avelength_DERIVED_GENDER,le.avelength_PRIM_RANGE,le.avelength_PRIM_NAME,le.avelength_SEC_RANGE,le.avelength_CITY,le.avelength_ST,le.avelength_ZIP,le.avelength_SSN5,le.avelength_SSN4,le.avelength_DOB,le.avelength_PHONE,le.avelength_DL_STATE,le.avelength_DL_NBR,le.avelength_SRC,le.avelength_SOURCE_RID,le.avelength_DT_FIRST_SEEN,le.avelength_DT_LAST_SEEN,le.avelength_DT_EFFECTIVE_FIRST,le.avelength_DT_EFFECTIVE_LAST);
END;
EXPORT invSummary := NORMALIZE(summary0, 23, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.DID;
  SELF.Src := le.SRC;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.SNAME),TRIM((SALT311.StrType)le.FNAME),TRIM((SALT311.StrType)le.MNAME),TRIM((SALT311.StrType)le.LNAME),TRIM((SALT311.StrType)le.DERIVED_GENDER),TRIM((SALT311.StrType)le.PRIM_RANGE),TRIM((SALT311.StrType)le.PRIM_NAME),TRIM((SALT311.StrType)le.SEC_RANGE),TRIM((SALT311.StrType)le.CITY),TRIM((SALT311.StrType)le.ST),TRIM((SALT311.StrType)le.ZIP),TRIM((SALT311.StrType)le.SSN5),TRIM((SALT311.StrType)le.SSN4),TRIM((SALT311.StrType)le.DOB),TRIM((SALT311.StrType)le.PHONE),TRIM((SALT311.StrType)le.DL_STATE),TRIM((SALT311.StrType)le.DL_NBR),TRIM((SALT311.StrType)le.SRC),TRIM((SALT311.StrType)le.SOURCE_RID),TRIM((SALT311.StrType)le.DT_FIRST_SEEN),TRIM((SALT311.StrType)le.DT_LAST_SEEN),TRIM((SALT311.StrType)le.DT_EFFECTIVE_FIRST),TRIM((SALT311.StrType)le.DT_EFFECTIVE_LAST)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,23,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 23);
  SELF.FldNo2 := 1 + (C % 23);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.SNAME),TRIM((SALT311.StrType)le.FNAME),TRIM((SALT311.StrType)le.MNAME),TRIM((SALT311.StrType)le.LNAME),TRIM((SALT311.StrType)le.DERIVED_GENDER),TRIM((SALT311.StrType)le.PRIM_RANGE),TRIM((SALT311.StrType)le.PRIM_NAME),TRIM((SALT311.StrType)le.SEC_RANGE),TRIM((SALT311.StrType)le.CITY),TRIM((SALT311.StrType)le.ST),TRIM((SALT311.StrType)le.ZIP),TRIM((SALT311.StrType)le.SSN5),TRIM((SALT311.StrType)le.SSN4),TRIM((SALT311.StrType)le.DOB),TRIM((SALT311.StrType)le.PHONE),TRIM((SALT311.StrType)le.DL_STATE),TRIM((SALT311.StrType)le.DL_NBR),TRIM((SALT311.StrType)le.SRC),TRIM((SALT311.StrType)le.SOURCE_RID),TRIM((SALT311.StrType)le.DT_FIRST_SEEN),TRIM((SALT311.StrType)le.DT_LAST_SEEN),TRIM((SALT311.StrType)le.DT_EFFECTIVE_FIRST),TRIM((SALT311.StrType)le.DT_EFFECTIVE_LAST)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.SNAME),TRIM((SALT311.StrType)le.FNAME),TRIM((SALT311.StrType)le.MNAME),TRIM((SALT311.StrType)le.LNAME),TRIM((SALT311.StrType)le.DERIVED_GENDER),TRIM((SALT311.StrType)le.PRIM_RANGE),TRIM((SALT311.StrType)le.PRIM_NAME),TRIM((SALT311.StrType)le.SEC_RANGE),TRIM((SALT311.StrType)le.CITY),TRIM((SALT311.StrType)le.ST),TRIM((SALT311.StrType)le.ZIP),TRIM((SALT311.StrType)le.SSN5),TRIM((SALT311.StrType)le.SSN4),TRIM((SALT311.StrType)le.DOB),TRIM((SALT311.StrType)le.PHONE),TRIM((SALT311.StrType)le.DL_STATE),TRIM((SALT311.StrType)le.DL_NBR),TRIM((SALT311.StrType)le.SRC),TRIM((SALT311.StrType)le.SOURCE_RID),TRIM((SALT311.StrType)le.DT_FIRST_SEEN),TRIM((SALT311.StrType)le.DT_LAST_SEEN),TRIM((SALT311.StrType)le.DT_EFFECTIVE_FIRST),TRIM((SALT311.StrType)le.DT_EFFECTIVE_LAST)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),23*23,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'SNAME'}
      ,{2,'FNAME'}
      ,{3,'MNAME'}
      ,{4,'LNAME'}
      ,{5,'DERIVED_GENDER'}
      ,{6,'PRIM_RANGE'}
      ,{7,'PRIM_NAME'}
      ,{8,'SEC_RANGE'}
      ,{9,'CITY'}
      ,{10,'ST'}
      ,{11,'ZIP'}
      ,{12,'SSN5'}
      ,{13,'SSN4'}
      ,{14,'DOB'}
      ,{15,'PHONE'}
      ,{16,'DL_STATE'}
      ,{17,'DL_NBR'}
      ,{18,'SRC'}
      ,{19,'SOURCE_RID'}
      ,{20,'DT_FIRST_SEEN'}
      ,{21,'DT_LAST_SEEN'}
      ,{22,'DT_EFFECTIVE_FIRST'}
      ,{23,'DT_EFFECTIVE_LAST'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.SRC) SRC; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_SNAME((SALT311.StrType)le.SNAME),
    Fields.InValid_FNAME((SALT311.StrType)le.FNAME),
    Fields.InValid_MNAME((SALT311.StrType)le.MNAME),
    Fields.InValid_LNAME((SALT311.StrType)le.LNAME),
    Fields.InValid_DERIVED_GENDER((SALT311.StrType)le.DERIVED_GENDER),
    Fields.InValid_PRIM_RANGE((SALT311.StrType)le.PRIM_RANGE),
    Fields.InValid_PRIM_NAME((SALT311.StrType)le.PRIM_NAME),
    Fields.InValid_SEC_RANGE((SALT311.StrType)le.SEC_RANGE),
    Fields.InValid_CITY((SALT311.StrType)le.CITY),
    Fields.InValid_ST((SALT311.StrType)le.ST),
    Fields.InValid_ZIP((SALT311.StrType)le.ZIP),
    Fields.InValid_SSN5((SALT311.StrType)le.SSN5),
    Fields.InValid_SSN4((SALT311.StrType)le.SSN4),
    Fields.InValid_DOB((SALT311.StrType)le.DOB),
    Fields.InValid_PHONE((SALT311.StrType)le.PHONE),
    Fields.InValid_DL_STATE((SALT311.StrType)le.DL_STATE),
    Fields.InValid_DL_NBR((SALT311.StrType)le.DL_NBR),
    Fields.InValid_SRC((SALT311.StrType)le.SRC),
    Fields.InValid_SOURCE_RID((SALT311.StrType)le.SOURCE_RID),
    Fields.InValid_DT_FIRST_SEEN((SALT311.StrType)le.DT_FIRST_SEEN),
    Fields.InValid_DT_LAST_SEEN((SALT311.StrType)le.DT_LAST_SEEN),
    Fields.InValid_DT_EFFECTIVE_FIRST((SALT311.StrType)le.DT_EFFECTIVE_FIRST),
    Fields.InValid_DT_EFFECTIVE_LAST((SALT311.StrType)le.DT_EFFECTIVE_LAST),
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.SRC := le.SRC;
END;
Errors := NORMALIZE(h,31,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.SRC;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,SRC,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.SRC;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','NUMBER','DEFAULT','DEFAULT','DEFAULT','NUMBER','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_SNAME(TotalErrors.ErrorNum),Fields.InValidMessage_FNAME(TotalErrors.ErrorNum),Fields.InValidMessage_MNAME(TotalErrors.ErrorNum),Fields.InValidMessage_LNAME(TotalErrors.ErrorNum),Fields.InValidMessage_DERIVED_GENDER(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_SEC_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_CITY(TotalErrors.ErrorNum),Fields.InValidMessage_ST(TotalErrors.ErrorNum),Fields.InValidMessage_ZIP(TotalErrors.ErrorNum),Fields.InValidMessage_SSN5(TotalErrors.ErrorNum),Fields.InValidMessage_SSN4(TotalErrors.ErrorNum),Fields.InValidMessage_DOB(TotalErrors.ErrorNum),Fields.InValidMessage_PHONE(TotalErrors.ErrorNum),Fields.InValidMessage_DL_STATE(TotalErrors.ErrorNum),Fields.InValidMessage_DL_NBR(TotalErrors.ErrorNum),Fields.InValidMessage_SRC(TotalErrors.ErrorNum),Fields.InValidMessage_SOURCE_RID(TotalErrors.ErrorNum),Fields.InValidMessage_DT_FIRST_SEEN(TotalErrors.ErrorNum),Fields.InValidMessage_DT_LAST_SEEN(TotalErrors.ErrorNum),Fields.InValidMessage_DT_EFFECTIVE_FIRST(TotalErrors.ErrorNum),Fields.InValidMessage_DT_EFFECTIVE_LAST(TotalErrors.ErrorNum),'','','','','','','','');
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.SRC=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//We have DID specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT311.MOD_ClusterStats.Counts(h,DID);
EXPORT ClusterSrc := SALT311.MOD_ClusterStats.Sources(h,DID,SRC);
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(InsuranceHeader_xLink, Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
