IMPORT SALT37;
EXPORT hygiene(dataset(layout_HEADER) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.SRC);    NumberOfRecords := COUNT(GROUP);
    populated_SSN_pcnt := AVE(GROUP,IF(h.SSN = (TYPEOF(h.SSN))'',0,100));
    maxlength_SSN := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.SSN)));
    avelength_SSN := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.SSN)),h.SSN<>(typeof(h.SSN))'');
    populated_POLICY_NUMBER_pcnt := AVE(GROUP,IF(h.POLICY_NUMBER = (TYPEOF(h.POLICY_NUMBER))'',0,100));
    maxlength_POLICY_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.POLICY_NUMBER)));
    avelength_POLICY_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.POLICY_NUMBER)),h.POLICY_NUMBER<>(typeof(h.POLICY_NUMBER))'');
    populated_CLAIM_NUMBER_pcnt := AVE(GROUP,IF(h.CLAIM_NUMBER = (TYPEOF(h.CLAIM_NUMBER))'',0,100));
    maxlength_CLAIM_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.CLAIM_NUMBER)));
    avelength_CLAIM_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.CLAIM_NUMBER)),h.CLAIM_NUMBER<>(typeof(h.CLAIM_NUMBER))'');
    populated_DL_NBR_pcnt := AVE(GROUP,IF(h.DL_NBR = (TYPEOF(h.DL_NBR))'',0,100));
    maxlength_DL_NBR := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.DL_NBR)));
    avelength_DL_NBR := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.DL_NBR)),h.DL_NBR<>(typeof(h.DL_NBR))'');
    populated_DOB_pcnt := AVE(GROUP,IF(h.DOB = (TYPEOF(h.DOB))'',0,100));
    maxlength_DOB := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.DOB)));
    avelength_DOB := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.DOB)),h.DOB<>(typeof(h.DOB))'');
    populated_ZIP_pcnt := AVE(GROUP,IF(h.ZIP = (TYPEOF(h.ZIP))'',0,100));
    maxlength_ZIP := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ZIP)));
    avelength_ZIP := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ZIP)),h.ZIP<>(typeof(h.ZIP))'');
    populated_PRIM_NAME_pcnt := AVE(GROUP,IF(h.PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',0,100));
    maxlength_PRIM_NAME := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.PRIM_NAME)));
    avelength_PRIM_NAME := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.PRIM_NAME)),h.PRIM_NAME<>(typeof(h.PRIM_NAME))'');
    populated_LNAME_pcnt := AVE(GROUP,IF(h.LNAME = (TYPEOF(h.LNAME))'',0,100));
    maxlength_LNAME := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.LNAME)));
    avelength_LNAME := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.LNAME)),h.LNAME<>(typeof(h.LNAME))'');
    populated_PRIM_RANGE_pcnt := AVE(GROUP,IF(h.PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',0,100));
    maxlength_PRIM_RANGE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.PRIM_RANGE)));
    avelength_PRIM_RANGE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.PRIM_RANGE)),h.PRIM_RANGE<>(typeof(h.PRIM_RANGE))'');
    populated_CITY_pcnt := AVE(GROUP,IF(h.CITY = (TYPEOF(h.CITY))'',0,100));
    maxlength_CITY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.CITY)));
    avelength_CITY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.CITY)),h.CITY<>(typeof(h.CITY))'');
    populated_FNAME_pcnt := AVE(GROUP,IF(h.FNAME = (TYPEOF(h.FNAME))'',0,100));
    maxlength_FNAME := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.FNAME)));
    avelength_FNAME := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.FNAME)),h.FNAME<>(typeof(h.FNAME))'');
    populated_SEC_RANGE_pcnt := AVE(GROUP,IF(h.SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',0,100));
    maxlength_SEC_RANGE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.SEC_RANGE)));
    avelength_SEC_RANGE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.SEC_RANGE)),h.SEC_RANGE<>(typeof(h.SEC_RANGE))'');
    populated_MNAME_pcnt := AVE(GROUP,IF(h.MNAME = (TYPEOF(h.MNAME))'',0,100));
    maxlength_MNAME := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.MNAME)));
    avelength_MNAME := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.MNAME)),h.MNAME<>(typeof(h.MNAME))'');
    populated_ST_pcnt := AVE(GROUP,IF(h.ST = (TYPEOF(h.ST))'',0,100));
    maxlength_ST := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ST)));
    avelength_ST := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ST)),h.ST<>(typeof(h.ST))'');
    populated_SNAME_pcnt := AVE(GROUP,IF(h.SNAME = (TYPEOF(h.SNAME))'',0,100));
    maxlength_SNAME := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.SNAME)));
    avelength_SNAME := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.SNAME)),h.SNAME<>(typeof(h.SNAME))'');
    populated_GENDER_pcnt := AVE(GROUP,IF(h.GENDER = (TYPEOF(h.GENDER))'',0,100));
    maxlength_GENDER := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.GENDER)));
    avelength_GENDER := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.GENDER)),h.GENDER<>(typeof(h.GENDER))'');
    populated_DERIVED_GENDER_pcnt := AVE(GROUP,IF(h.DERIVED_GENDER = (TYPEOF(h.DERIVED_GENDER))'',0,100));
    maxlength_DERIVED_GENDER := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.DERIVED_GENDER)));
    avelength_DERIVED_GENDER := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.DERIVED_GENDER)),h.DERIVED_GENDER<>(typeof(h.DERIVED_GENDER))'');
    populated_VENDOR_ID_pcnt := AVE(GROUP,IF(h.VENDOR_ID = (TYPEOF(h.VENDOR_ID))'',0,100));
    maxlength_VENDOR_ID := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.VENDOR_ID)));
    avelength_VENDOR_ID := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.VENDOR_ID)),h.VENDOR_ID<>(typeof(h.VENDOR_ID))'');
    populated_BOCA_DID_pcnt := AVE(GROUP,IF(h.BOCA_DID = (TYPEOF(h.BOCA_DID))'',0,100));
    maxlength_BOCA_DID := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.BOCA_DID)));
    avelength_BOCA_DID := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.BOCA_DID)),h.BOCA_DID<>(typeof(h.BOCA_DID))'');
    populated_SRC_pcnt := AVE(GROUP,IF(h.SRC = (TYPEOF(h.SRC))'',0,100));
    maxlength_SRC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.SRC)));
    avelength_SRC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.SRC)),h.SRC<>(typeof(h.SRC))'');
    populated_DT_FIRST_SEEN_pcnt := AVE(GROUP,IF(h.DT_FIRST_SEEN = (TYPEOF(h.DT_FIRST_SEEN))'',0,100));
    maxlength_DT_FIRST_SEEN := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.DT_FIRST_SEEN)));
    avelength_DT_FIRST_SEEN := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.DT_FIRST_SEEN)),h.DT_FIRST_SEEN<>(typeof(h.DT_FIRST_SEEN))'');
    populated_DT_LAST_SEEN_pcnt := AVE(GROUP,IF(h.DT_LAST_SEEN = (TYPEOF(h.DT_LAST_SEEN))'',0,100));
    maxlength_DT_LAST_SEEN := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.DT_LAST_SEEN)));
    avelength_DT_LAST_SEEN := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.DT_LAST_SEEN)),h.DT_LAST_SEEN<>(typeof(h.DT_LAST_SEEN))'');
    populated_DL_STATE_pcnt := AVE(GROUP,IF(h.DL_STATE = (TYPEOF(h.DL_STATE))'',0,100));
    maxlength_DL_STATE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.DL_STATE)));
    avelength_DL_STATE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.DL_STATE)),h.DL_STATE<>(typeof(h.DL_STATE))'');
    populated_AMBEST_pcnt := AVE(GROUP,IF(h.AMBEST = (TYPEOF(h.AMBEST))'',0,100));
    maxlength_AMBEST := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AMBEST)));
    avelength_AMBEST := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AMBEST)),h.AMBEST<>(typeof(h.AMBEST))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,SRC,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_SSN_pcnt *  28.00 / 100 + T.Populated_POLICY_NUMBER_pcnt *  28.00 / 100 + T.Populated_CLAIM_NUMBER_pcnt *  28.00 / 100 + T.Populated_DL_NBR_pcnt *  26.00 / 100 + T.Populated_DOB_pcnt *  15.00 / 100 + T.Populated_ZIP_pcnt *  14.00 / 100 + T.Populated_PRIM_NAME_pcnt *  12.00 / 100 + T.Populated_LNAME_pcnt *  11.00 / 100 + T.Populated_PRIM_RANGE_pcnt *  11.00 / 100 + T.Populated_CITY_pcnt *  10.00 / 100 + T.Populated_FNAME_pcnt *   9.00 / 100 + T.Populated_SEC_RANGE_pcnt *   8.00 / 100 + T.Populated_MNAME_pcnt *   6.00 / 100 + T.Populated_ST_pcnt *   5.00 / 100 + T.Populated_SNAME_pcnt *   2.00 / 100 + T.Populated_GENDER_pcnt *   1.00 / 100 + T.Populated_DERIVED_GENDER_pcnt *   1.00 / 100 + T.Populated_VENDOR_ID_pcnt *   0.00 / 100 + T.Populated_BOCA_DID_pcnt *   0.00 / 100 + T.Populated_SRC_pcnt *   0.00 / 100 + T.Populated_DT_FIRST_SEEN_pcnt *   0.00 / 100 + T.Populated_DT_LAST_SEEN_pcnt *   0.00 / 100 + T.Populated_DL_STATE_pcnt *   0.00 / 100 + T.Populated_AMBEST_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING SRC1;
    STRING SRC2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.SRC1 := le.Source;
    SELF.SRC2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_SSN_pcnt*ri.Populated_SSN_pcnt *  28.00 / 10000 + le.Populated_POLICY_NUMBER_pcnt*ri.Populated_POLICY_NUMBER_pcnt *  28.00 / 10000 + le.Populated_CLAIM_NUMBER_pcnt*ri.Populated_CLAIM_NUMBER_pcnt *  28.00 / 10000 + le.Populated_DL_NBR_pcnt*ri.Populated_DL_NBR_pcnt *  26.00 / 10000 + le.Populated_DOB_pcnt*ri.Populated_DOB_pcnt *  15.00 / 10000 + le.Populated_ZIP_pcnt*ri.Populated_ZIP_pcnt *  14.00 / 10000 + le.Populated_PRIM_NAME_pcnt*ri.Populated_PRIM_NAME_pcnt *  12.00 / 10000 + le.Populated_LNAME_pcnt*ri.Populated_LNAME_pcnt *  11.00 / 10000 + le.Populated_PRIM_RANGE_pcnt*ri.Populated_PRIM_RANGE_pcnt *  11.00 / 10000 + le.Populated_CITY_pcnt*ri.Populated_CITY_pcnt *  10.00 / 10000 + le.Populated_FNAME_pcnt*ri.Populated_FNAME_pcnt *   9.00 / 10000 + le.Populated_SEC_RANGE_pcnt*ri.Populated_SEC_RANGE_pcnt *   8.00 / 10000 + le.Populated_MNAME_pcnt*ri.Populated_MNAME_pcnt *   6.00 / 10000 + le.Populated_ST_pcnt*ri.Populated_ST_pcnt *   5.00 / 10000 + le.Populated_SNAME_pcnt*ri.Populated_SNAME_pcnt *   2.00 / 10000 + le.Populated_GENDER_pcnt*ri.Populated_GENDER_pcnt *   1.00 / 10000 + le.Populated_DERIVED_GENDER_pcnt*ri.Populated_DERIVED_GENDER_pcnt *   1.00 / 10000 + le.Populated_VENDOR_ID_pcnt*ri.Populated_VENDOR_ID_pcnt *   0.00 / 10000 + le.Populated_BOCA_DID_pcnt*ri.Populated_BOCA_DID_pcnt *   0.00 / 10000 + le.Populated_SRC_pcnt*ri.Populated_SRC_pcnt *   0.00 / 10000 + le.Populated_DT_FIRST_SEEN_pcnt*ri.Populated_DT_FIRST_SEEN_pcnt *   0.00 / 10000 + le.Populated_DT_LAST_SEEN_pcnt*ri.Populated_DT_LAST_SEEN_pcnt *   0.00 / 10000 + le.Populated_DL_STATE_pcnt*ri.Populated_DL_STATE_pcnt *   0.00 / 10000 + le.Populated_AMBEST_pcnt*ri.Populated_AMBEST_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'SSN','POLICY_NUMBER','CLAIM_NUMBER','DL_NBR','DOB','ZIP','PRIM_NAME','LNAME','PRIM_RANGE','CITY','FNAME','SEC_RANGE','MNAME','ST','SNAME','GENDER','DERIVED_GENDER','VENDOR_ID','BOCA_DID','SRC','DT_FIRST_SEEN','DT_LAST_SEEN','DL_STATE','AMBEST');
  SELF.populated_pcnt := CHOOSE(C,le.populated_SSN_pcnt,le.populated_POLICY_NUMBER_pcnt,le.populated_CLAIM_NUMBER_pcnt,le.populated_DL_NBR_pcnt,le.populated_DOB_pcnt,le.populated_ZIP_pcnt,le.populated_PRIM_NAME_pcnt,le.populated_LNAME_pcnt,le.populated_PRIM_RANGE_pcnt,le.populated_CITY_pcnt,le.populated_FNAME_pcnt,le.populated_SEC_RANGE_pcnt,le.populated_MNAME_pcnt,le.populated_ST_pcnt,le.populated_SNAME_pcnt,le.populated_GENDER_pcnt,le.populated_DERIVED_GENDER_pcnt,le.populated_VENDOR_ID_pcnt,le.populated_BOCA_DID_pcnt,le.populated_SRC_pcnt,le.populated_DT_FIRST_SEEN_pcnt,le.populated_DT_LAST_SEEN_pcnt,le.populated_DL_STATE_pcnt,le.populated_AMBEST_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_SSN,le.maxlength_POLICY_NUMBER,le.maxlength_CLAIM_NUMBER,le.maxlength_DL_NBR,le.maxlength_DOB,le.maxlength_ZIP,le.maxlength_PRIM_NAME,le.maxlength_LNAME,le.maxlength_PRIM_RANGE,le.maxlength_CITY,le.maxlength_FNAME,le.maxlength_SEC_RANGE,le.maxlength_MNAME,le.maxlength_ST,le.maxlength_SNAME,le.maxlength_GENDER,le.maxlength_DERIVED_GENDER,le.maxlength_VENDOR_ID,le.maxlength_BOCA_DID,le.maxlength_SRC,le.maxlength_DT_FIRST_SEEN,le.maxlength_DT_LAST_SEEN,le.maxlength_DL_STATE,le.maxlength_AMBEST);
  SELF.avelength := CHOOSE(C,le.avelength_SSN,le.avelength_POLICY_NUMBER,le.avelength_CLAIM_NUMBER,le.avelength_DL_NBR,le.avelength_DOB,le.avelength_ZIP,le.avelength_PRIM_NAME,le.avelength_LNAME,le.avelength_PRIM_RANGE,le.avelength_CITY,le.avelength_FNAME,le.avelength_SEC_RANGE,le.avelength_MNAME,le.avelength_ST,le.avelength_SNAME,le.avelength_GENDER,le.avelength_DERIVED_GENDER,le.avelength_VENDOR_ID,le.avelength_BOCA_DID,le.avelength_SRC,le.avelength_DT_FIRST_SEEN,le.avelength_DT_LAST_SEEN,le.avelength_DL_STATE,le.avelength_AMBEST);
END;
EXPORT invSummary := NORMALIZE(summary0, 24, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.DID;
  SELF.Src := le.SRC;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.SSN),TRIM((SALT37.StrType)le.POLICY_NUMBER),TRIM((SALT37.StrType)le.CLAIM_NUMBER),TRIM((SALT37.StrType)le.DL_NBR),TRIM((SALT37.StrType)le.DOB),TRIM((SALT37.StrType)le.ZIP),TRIM((SALT37.StrType)le.PRIM_NAME),TRIM((SALT37.StrType)le.LNAME),TRIM((SALT37.StrType)le.PRIM_RANGE),TRIM((SALT37.StrType)le.CITY),TRIM((SALT37.StrType)le.FNAME),TRIM((SALT37.StrType)le.SEC_RANGE),TRIM((SALT37.StrType)le.MNAME),TRIM((SALT37.StrType)le.ST),TRIM((SALT37.StrType)le.SNAME),TRIM((SALT37.StrType)le.GENDER),TRIM((SALT37.StrType)le.DERIVED_GENDER),TRIM((SALT37.StrType)le.VENDOR_ID),TRIM((SALT37.StrType)le.BOCA_DID),TRIM((SALT37.StrType)le.SRC),TRIM((SALT37.StrType)le.DT_FIRST_SEEN),TRIM((SALT37.StrType)le.DT_LAST_SEEN),TRIM((SALT37.StrType)le.DL_STATE),TRIM((SALT37.StrType)le.AMBEST)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,24,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 24);
  SELF.FldNo2 := 1 + (C % 24);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.SSN),TRIM((SALT37.StrType)le.POLICY_NUMBER),TRIM((SALT37.StrType)le.CLAIM_NUMBER),TRIM((SALT37.StrType)le.DL_NBR),TRIM((SALT37.StrType)le.DOB),TRIM((SALT37.StrType)le.ZIP),TRIM((SALT37.StrType)le.PRIM_NAME),TRIM((SALT37.StrType)le.LNAME),TRIM((SALT37.StrType)le.PRIM_RANGE),TRIM((SALT37.StrType)le.CITY),TRIM((SALT37.StrType)le.FNAME),TRIM((SALT37.StrType)le.SEC_RANGE),TRIM((SALT37.StrType)le.MNAME),TRIM((SALT37.StrType)le.ST),TRIM((SALT37.StrType)le.SNAME),TRIM((SALT37.StrType)le.GENDER),TRIM((SALT37.StrType)le.DERIVED_GENDER),TRIM((SALT37.StrType)le.VENDOR_ID),TRIM((SALT37.StrType)le.BOCA_DID),TRIM((SALT37.StrType)le.SRC),TRIM((SALT37.StrType)le.DT_FIRST_SEEN),TRIM((SALT37.StrType)le.DT_LAST_SEEN),TRIM((SALT37.StrType)le.DL_STATE),TRIM((SALT37.StrType)le.AMBEST)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.SSN),TRIM((SALT37.StrType)le.POLICY_NUMBER),TRIM((SALT37.StrType)le.CLAIM_NUMBER),TRIM((SALT37.StrType)le.DL_NBR),TRIM((SALT37.StrType)le.DOB),TRIM((SALT37.StrType)le.ZIP),TRIM((SALT37.StrType)le.PRIM_NAME),TRIM((SALT37.StrType)le.LNAME),TRIM((SALT37.StrType)le.PRIM_RANGE),TRIM((SALT37.StrType)le.CITY),TRIM((SALT37.StrType)le.FNAME),TRIM((SALT37.StrType)le.SEC_RANGE),TRIM((SALT37.StrType)le.MNAME),TRIM((SALT37.StrType)le.ST),TRIM((SALT37.StrType)le.SNAME),TRIM((SALT37.StrType)le.GENDER),TRIM((SALT37.StrType)le.DERIVED_GENDER),TRIM((SALT37.StrType)le.VENDOR_ID),TRIM((SALT37.StrType)le.BOCA_DID),TRIM((SALT37.StrType)le.SRC),TRIM((SALT37.StrType)le.DT_FIRST_SEEN),TRIM((SALT37.StrType)le.DT_LAST_SEEN),TRIM((SALT37.StrType)le.DL_STATE),TRIM((SALT37.StrType)le.AMBEST)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),24*24,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'SSN'}
      ,{2,'POLICY_NUMBER'}
      ,{3,'CLAIM_NUMBER'}
      ,{4,'DL_NBR'}
      ,{5,'DOB'}
      ,{6,'ZIP'}
      ,{7,'PRIM_NAME'}
      ,{8,'LNAME'}
      ,{9,'PRIM_RANGE'}
      ,{10,'CITY'}
      ,{11,'FNAME'}
      ,{12,'SEC_RANGE'}
      ,{13,'MNAME'}
      ,{14,'ST'}
      ,{15,'SNAME'}
      ,{16,'GENDER'}
      ,{17,'DERIVED_GENDER'}
      ,{18,'VENDOR_ID'}
      ,{19,'BOCA_DID'}
      ,{20,'SRC'}
      ,{21,'DT_FIRST_SEEN'}
      ,{22,'DT_LAST_SEEN'}
      ,{23,'DL_STATE'}
      ,{24,'AMBEST'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.SRC) SRC; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    0, // Uncleanable field
    Fields.InValid_SSN((SALT37.StrType)le.SSN),
    Fields.InValid_POLICY_NUMBER((SALT37.StrType)le.POLICY_NUMBER),
    Fields.InValid_CLAIM_NUMBER((SALT37.StrType)le.CLAIM_NUMBER),
    Fields.InValid_DL_NBR((SALT37.StrType)le.DL_NBR),
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    Fields.InValid_DOB((SALT37.StrType)le.DOB),
    Fields.InValid_ZIP((SALT37.StrType)le.ZIP),
    0, // Uncleanable field
    Fields.InValid_PRIM_NAME((SALT37.StrType)le.PRIM_NAME),
    Fields.InValid_LNAME((SALT37.StrType)le.LNAME),
    Fields.InValid_PRIM_RANGE((SALT37.StrType)le.PRIM_RANGE),
    Fields.InValid_CITY((SALT37.StrType)le.CITY),
    Fields.InValid_FNAME((SALT37.StrType)le.FNAME),
    Fields.InValid_SEC_RANGE((SALT37.StrType)le.SEC_RANGE),
    Fields.InValid_MNAME((SALT37.StrType)le.MNAME),
    Fields.InValid_ST((SALT37.StrType)le.ST),
    Fields.InValid_SNAME((SALT37.StrType)le.SNAME),
    Fields.InValid_GENDER((SALT37.StrType)le.GENDER),
    Fields.InValid_DERIVED_GENDER((SALT37.StrType)le.DERIVED_GENDER),
    Fields.InValid_VENDOR_ID((SALT37.StrType)le.VENDOR_ID),
    Fields.InValid_BOCA_DID((SALT37.StrType)le.BOCA_DID),
    Fields.InValid_SRC((SALT37.StrType)le.SRC),
    Fields.InValid_DT_FIRST_SEEN((SALT37.StrType)le.DT_FIRST_SEEN),
    Fields.InValid_DT_LAST_SEEN((SALT37.StrType)le.DT_LAST_SEEN),
    Fields.InValid_DL_STATE((SALT37.StrType)le.DL_STATE),
    Fields.InValid_AMBEST((SALT37.StrType)le.AMBEST),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.SRC := le.SRC;
END;
Errors := NORMALIZE(h,29,NoteErrors(LEFT,COUNTER));
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
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','NUMBER','DEFAULT','DEFAULT','DEFAULT','Unknown','Unknown','Unknown','DEFAULT','DEFAULT','Unknown','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,'',Fields.InValidMessage_SSN(TotalErrors.ErrorNum),Fields.InValidMessage_POLICY_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_CLAIM_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_DL_NBR(TotalErrors.ErrorNum),'','','',Fields.InValidMessage_DOB(TotalErrors.ErrorNum),Fields.InValidMessage_ZIP(TotalErrors.ErrorNum),'',Fields.InValidMessage_PRIM_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_LNAME(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_CITY(TotalErrors.ErrorNum),Fields.InValidMessage_FNAME(TotalErrors.ErrorNum),Fields.InValidMessage_SEC_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_MNAME(TotalErrors.ErrorNum),Fields.InValidMessage_ST(TotalErrors.ErrorNum),Fields.InValidMessage_SNAME(TotalErrors.ErrorNum),Fields.InValidMessage_GENDER(TotalErrors.ErrorNum),Fields.InValidMessage_DERIVED_GENDER(TotalErrors.ErrorNum),Fields.InValidMessage_VENDOR_ID(TotalErrors.ErrorNum),Fields.InValidMessage_BOCA_DID(TotalErrors.ErrorNum),Fields.InValidMessage_SRC(TotalErrors.ErrorNum),Fields.InValidMessage_DT_FIRST_SEEN(TotalErrors.ErrorNum),Fields.InValidMessage_DT_LAST_SEEN(TotalErrors.ErrorNum),Fields.InValidMessage_DL_STATE(TotalErrors.ErrorNum),Fields.InValidMessage_AMBEST(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.SRC=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//We have DID specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT37.MOD_ClusterStats.Counts(h,DID);
EXPORT ClusterSrc := SALT37.MOD_ClusterStats.Sources(h,DID,SRC);
END;
