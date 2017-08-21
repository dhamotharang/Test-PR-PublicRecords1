import ut,SALT27;
export hygiene(dataset(layout_HealthProvider) h) := MODULE

//A simple summary record
export Summary(SALT27.Str30Type txt) := FUNCTION
SummaryLayout := RECORD
txt;
NumberOfRecords := COUNT(GROUP);
populated_VENDOR_ID_pcnt := AVE(GROUP,IF(h.VENDOR_ID = (TYPEOF(h.VENDOR_ID))'',0,100));
maxlength_VENDOR_ID := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.VENDOR_ID)));
avelength_VENDOR_ID := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.VENDOR_ID)),h.VENDOR_ID<>(typeof(h.VENDOR_ID))'');
populated_DID_pcnt := AVE(GROUP,IF(h.DID = (TYPEOF(h.DID))'',0,100));
maxlength_DID := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.DID)));
avelength_DID := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.DID)),h.DID<>(typeof(h.DID))'');
populated_NPI_NUMBER_pcnt := AVE(GROUP,IF(h.NPI_NUMBER = (TYPEOF(h.NPI_NUMBER))'',0,100));
maxlength_NPI_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.NPI_NUMBER)));
avelength_NPI_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.NPI_NUMBER)),h.NPI_NUMBER<>(typeof(h.NPI_NUMBER))'');
populated_DEA_NUMBER_pcnt := AVE(GROUP,IF(h.DEA_NUMBER = (TYPEOF(h.DEA_NUMBER))'',0,100));
maxlength_DEA_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.DEA_NUMBER)));
avelength_DEA_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.DEA_NUMBER)),h.DEA_NUMBER<>(typeof(h.DEA_NUMBER))'');
populated_LIC_NBR_pcnt := AVE(GROUP,IF(h.LIC_NBR = (TYPEOF(h.LIC_NBR))'',0,100));
maxlength_LIC_NBR := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.LIC_NBR)));
avelength_LIC_NBR := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.LIC_NBR)),h.LIC_NBR<>(typeof(h.LIC_NBR))'');
populated_UPIN_pcnt := AVE(GROUP,IF(h.UPIN = (TYPEOF(h.UPIN))'',0,100));
maxlength_UPIN := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.UPIN)));
avelength_UPIN := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.UPIN)),h.UPIN<>(typeof(h.UPIN))'');
populated_TAX_ID_pcnt := AVE(GROUP,IF(h.TAX_ID = (TYPEOF(h.TAX_ID))'',0,100));
maxlength_TAX_ID := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.TAX_ID)));
avelength_TAX_ID := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.TAX_ID)),h.TAX_ID<>(typeof(h.TAX_ID))'');
populated_DOB_pcnt := AVE(GROUP,IF(h.DOB = (TYPEOF(h.DOB))'',0,100));
maxlength_DOB := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.DOB)));
avelength_DOB := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.DOB)),h.DOB<>(typeof(h.DOB))'');
populated_PRIM_NAME_pcnt := AVE(GROUP,IF(h.PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',0,100));
maxlength_PRIM_NAME := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.PRIM_NAME)));
avelength_PRIM_NAME := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.PRIM_NAME)),h.PRIM_NAME<>(typeof(h.PRIM_NAME))'');
populated_ZIP_pcnt := AVE(GROUP,IF(h.ZIP = (TYPEOF(h.ZIP))'',0,100));
maxlength_ZIP := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.ZIP)));
avelength_ZIP := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.ZIP)),h.ZIP<>(typeof(h.ZIP))'');
populated_PRIM_RANGE_pcnt := AVE(GROUP,IF(h.PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',0,100));
maxlength_PRIM_RANGE := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.PRIM_RANGE)));
avelength_PRIM_RANGE := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.PRIM_RANGE)),h.PRIM_RANGE<>(typeof(h.PRIM_RANGE))'');
populated_LNAME_pcnt := AVE(GROUP,IF(h.LNAME = (TYPEOF(h.LNAME))'',0,100));
maxlength_LNAME := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.LNAME)));
avelength_LNAME := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.LNAME)),h.LNAME<>(typeof(h.LNAME))'');
populated_V_CITY_NAME_pcnt := AVE(GROUP,IF(h.V_CITY_NAME = (TYPEOF(h.V_CITY_NAME))'',0,100));
maxlength_V_CITY_NAME := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.V_CITY_NAME)));
avelength_V_CITY_NAME := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.V_CITY_NAME)),h.V_CITY_NAME<>(typeof(h.V_CITY_NAME))'');
populated_MNAME_pcnt := AVE(GROUP,IF(h.MNAME = (TYPEOF(h.MNAME))'',0,100));
maxlength_MNAME := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.MNAME)));
avelength_MNAME := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.MNAME)),h.MNAME<>(typeof(h.MNAME))'');
populated_FNAME_pcnt := AVE(GROUP,IF(h.FNAME = (TYPEOF(h.FNAME))'',0,100));
maxlength_FNAME := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.FNAME)));
avelength_FNAME := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.FNAME)),h.FNAME<>(typeof(h.FNAME))'');
populated_SEC_RANGE_pcnt := AVE(GROUP,IF(h.SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',0,100));
maxlength_SEC_RANGE := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.SEC_RANGE)));
avelength_SEC_RANGE := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.SEC_RANGE)),h.SEC_RANGE<>(typeof(h.SEC_RANGE))'');
populated_SNAME_pcnt := AVE(GROUP,IF(h.SNAME = (TYPEOF(h.SNAME))'',0,100));
maxlength_SNAME := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.SNAME)));
avelength_SNAME := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.SNAME)),h.SNAME<>(typeof(h.SNAME))'');
populated_ST_pcnt := AVE(GROUP,IF(h.ST = (TYPEOF(h.ST))'',0,100));
maxlength_ST := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.ST)));
avelength_ST := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.ST)),h.ST<>(typeof(h.ST))'');
populated_GENDER_pcnt := AVE(GROUP,IF(h.GENDER = (TYPEOF(h.GENDER))'',0,100));
maxlength_GENDER := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.GENDER)));
avelength_GENDER := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.GENDER)),h.GENDER<>(typeof(h.GENDER))'');
populated_PHONE_pcnt := AVE(GROUP,IF(h.PHONE = (TYPEOF(h.PHONE))'',0,100));
maxlength_PHONE := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.PHONE)));
avelength_PHONE := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.PHONE)),h.PHONE<>(typeof(h.PHONE))'');
populated_LIC_STATE_pcnt := AVE(GROUP,IF(h.LIC_STATE = (TYPEOF(h.LIC_STATE))'',0,100));
maxlength_LIC_STATE := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.LIC_STATE)));
avelength_LIC_STATE := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.LIC_STATE)),h.LIC_STATE<>(typeof(h.LIC_STATE))'');
populated_ADDRESS_ID_pcnt := AVE(GROUP,IF(h.ADDRESS_ID = (TYPEOF(h.ADDRESS_ID))'',0,100));
maxlength_ADDRESS_ID := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.ADDRESS_ID)));
avelength_ADDRESS_ID := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.ADDRESS_ID)),h.ADDRESS_ID<>(typeof(h.ADDRESS_ID))'');
populated_CNAME_pcnt := AVE(GROUP,IF(h.CNAME = (TYPEOF(h.CNAME))'',0,100));
maxlength_CNAME := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.CNAME)));
avelength_CNAME := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.CNAME)),h.CNAME<>(typeof(h.CNAME))'');
populated_SRC_pcnt := AVE(GROUP,IF(h.SRC = (TYPEOF(h.SRC))'',0,100));
maxlength_SRC := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.SRC)));
avelength_SRC := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.SRC)),h.SRC<>(typeof(h.SRC))'');
populated_DT_FIRST_SEEN_pcnt := AVE(GROUP,IF(h.DT_FIRST_SEEN = (TYPEOF(h.DT_FIRST_SEEN))'',0,100));
maxlength_DT_FIRST_SEEN := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.DT_FIRST_SEEN)));
avelength_DT_FIRST_SEEN := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.DT_FIRST_SEEN)),h.DT_FIRST_SEEN<>(typeof(h.DT_FIRST_SEEN))'');
populated_DT_LAST_SEEN_pcnt := AVE(GROUP,IF(h.DT_LAST_SEEN = (TYPEOF(h.DT_LAST_SEEN))'',0,100));
maxlength_DT_LAST_SEEN := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.DT_LAST_SEEN)));
avelength_DT_LAST_SEEN := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.DT_LAST_SEEN)),h.DT_LAST_SEEN<>(typeof(h.DT_LAST_SEEN))'');
populated_DT_LIC_EXPIRATION_pcnt := AVE(GROUP,IF(h.DT_LIC_EXPIRATION = (TYPEOF(h.DT_LIC_EXPIRATION))'',0,100));
maxlength_DT_LIC_EXPIRATION := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.DT_LIC_EXPIRATION)));
avelength_DT_LIC_EXPIRATION := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.DT_LIC_EXPIRATION)),h.DT_LIC_EXPIRATION<>(typeof(h.DT_LIC_EXPIRATION))'');
populated_DT_DEA_EXPIRATION_pcnt := AVE(GROUP,IF(h.DT_DEA_EXPIRATION = (TYPEOF(h.DT_DEA_EXPIRATION))'',0,100));
maxlength_DT_DEA_EXPIRATION := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.DT_DEA_EXPIRATION)));
avelength_DT_DEA_EXPIRATION := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.DT_DEA_EXPIRATION)),h.DT_DEA_EXPIRATION<>(typeof(h.DT_DEA_EXPIRATION))'');
populated_GEO_LAT_pcnt := AVE(GROUP,IF(h.GEO_LAT = (TYPEOF(h.GEO_LAT))'',0,100));
maxlength_GEO_LAT := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.GEO_LAT)));
avelength_GEO_LAT := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.GEO_LAT)),h.GEO_LAT<>(typeof(h.GEO_LAT))'');
populated_GEO_LONG_pcnt := AVE(GROUP,IF(h.GEO_LONG = (TYPEOF(h.GEO_LONG))'',0,100));
maxlength_GEO_LONG := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.GEO_LONG)));
avelength_GEO_LONG := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.GEO_LONG)),h.GEO_LONG<>(typeof(h.GEO_LONG))'');
END;
RETURN table(h,SummaryLayout);
END;

SrcCntRec := record
h.SRC;  // Source Group Identifier
unsigned SourceGroupCount := count(group);
end;
export SourceCounts := table(h,SrcCntRec,SRC,few);

// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT27.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
SELF.id := le.LNPID;
SELF.Src := le.SRC;
SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT27.StrType)le.VENDOR_ID),TRIM((SALT27.StrType)le.DID),TRIM((SALT27.StrType)le.NPI_NUMBER),TRIM((SALT27.StrType)le.DEA_NUMBER),TRIM((SALT27.StrType)le.LIC_NBR),TRIM((SALT27.StrType)le.UPIN),TRIM((SALT27.StrType)le.TAX_ID),TRIM((SALT27.StrType)le.DOB),TRIM((SALT27.StrType)le.PRIM_NAME),TRIM((SALT27.StrType)le.ZIP),TRIM((SALT27.StrType)le.PRIM_RANGE),TRIM((SALT27.StrType)le.LNAME),TRIM((SALT27.StrType)le.V_CITY_NAME),TRIM((SALT27.StrType)le.GEO_LAT)+' '+TRIM((SALT27.StrType)le.GEO_LONG),TRIM((SALT27.StrType)le.MNAME),TRIM((SALT27.StrType)le.FNAME),TRIM((SALT27.StrType)le.SEC_RANGE),TRIM((SALT27.StrType)le.SNAME),TRIM((SALT27.StrType)le.ST),TRIM((SALT27.StrType)le.GENDER),TRIM((SALT27.StrType)le.PHONE),TRIM((SALT27.StrType)le.LIC_STATE),TRIM((SALT27.StrType)le.ADDRESS_ID),TRIM((SALT27.StrType)le.CNAME),TRIM((SALT27.StrType)le.SRC),TRIM((SALT27.StrType)le.DT_FIRST_SEEN),TRIM((SALT27.StrType)le.DT_LAST_SEEN),TRIM((SALT27.StrType)le.DT_LIC_EXPIRATION),TRIM((SALT27.StrType)le.DT_DEA_EXPIRATION),TRIM((SALT27.StrType)le.GEO_LAT),TRIM((SALT27.StrType)le.GEO_LONG)));
SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,31,Into(LEFT,COUNTER));
SHARED FldIds := DATASET([{1,'VENDOR_ID'}
,{2,'DID'}
,{3,'NPI_NUMBER'}
,{4,'DEA_NUMBER'}
,{7,'LIC_NBR'}
,{8,'UPIN'}
,{11,'TAX_ID'}
,{12,'DOB'}
,{13,'PRIM_NAME'}
,{14,'ZIP'}
,{16,'PRIM_RANGE'}
,{17,'LNAME'}
,{18,'V_CITY_NAME'}
,{19,'LAT_LONG'}
,{20,'MNAME'}
,{21,'FNAME'}
,{22,'SEC_RANGE'}
,{23,'SNAME'}
,{24,'ST'}
,{25,'GENDER'}
,{26,'PHONE'}
,{27,'LIC_STATE'}
,{28,'ADDRESS_ID'}
,{29,'CNAME'}
,{30,'SRC'}
,{31,'DT_FIRST_SEEN'}
,{32,'DT_LAST_SEEN'}
,{33,'DT_LIC_EXPIRATION'}
,{34,'DT_DEA_EXPIRATION'}
,{35,'GEO_LAT'}
,{36,'GEO_LONG'}],SALT27.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT27.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);

EXPORT SrcProfiles := SALT27.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);

ErrorRecord := record
unsigned1 FieldNum;
unsigned1 ErrorNum;
typeof(h.SRC) SRC; // Track errors by source
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
self.ErrorNum := CHOOSE(c,
Fields.InValid_VENDOR_ID((SALT27.StrType)le.VENDOR_ID),
Fields.InValid_DID((SALT27.StrType)le.DID),
Fields.InValid_NPI_NUMBER((SALT27.StrType)le.NPI_NUMBER),
Fields.InValid_DEA_NUMBER((SALT27.StrType)le.DEA_NUMBER),
0, // Uncleanable field
0, // Uncleanable field
Fields.InValid_LIC_NBR((SALT27.StrType)le.LIC_NBR),
Fields.InValid_UPIN((SALT27.StrType)le.UPIN),
0, // Uncleanable field
0, // Uncleanable field
Fields.InValid_TAX_ID((SALT27.StrType)le.TAX_ID),
Fields.InValid_DOB((SALT27.StrType)le.DOB),
Fields.InValid_PRIM_NAME((SALT27.StrType)le.PRIM_NAME),
Fields.InValid_ZIP((SALT27.StrType)le.ZIP),
0, // Uncleanable field
Fields.InValid_PRIM_RANGE((SALT27.StrType)le.PRIM_RANGE),
Fields.InValid_LNAME((SALT27.StrType)le.LNAME),
Fields.InValid_V_CITY_NAME((SALT27.StrType)le.V_CITY_NAME),
0, // Uncleanable field
Fields.InValid_MNAME((SALT27.StrType)le.MNAME),
Fields.InValid_FNAME((SALT27.StrType)le.FNAME),
Fields.InValid_SEC_RANGE((SALT27.StrType)le.SEC_RANGE),
Fields.InValid_SNAME((SALT27.StrType)le.SNAME),
Fields.InValid_ST((SALT27.StrType)le.ST),
Fields.InValid_GENDER((SALT27.StrType)le.GENDER),
Fields.InValid_PHONE((SALT27.StrType)le.PHONE),
Fields.InValid_LIC_STATE((SALT27.StrType)le.LIC_STATE),
Fields.InValid_ADDRESS_ID((SALT27.StrType)le.ADDRESS_ID),
Fields.InValid_CNAME((SALT27.StrType)le.CNAME),
Fields.InValid_SRC((SALT27.StrType)le.SRC),
Fields.InValid_DT_FIRST_SEEN((SALT27.StrType)le.DT_FIRST_SEEN),
Fields.InValid_DT_LAST_SEEN((SALT27.StrType)le.DT_LAST_SEEN),
Fields.InValid_DT_LIC_EXPIRATION((SALT27.StrType)le.DT_LIC_EXPIRATION),
Fields.InValid_DT_DEA_EXPIRATION((SALT27.StrType)le.DT_DEA_EXPIRATION),
Fields.InValid_GEO_LAT((SALT27.StrType)le.GEO_LAT),
Fields.InValid_GEO_LONG((SALT27.StrType)le.GEO_LONG),
0);
self.FieldNum := IF(self.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
self.SRC := le.SRC;
end;
Errors := normalize(h,36,NoteErrors(left,counter));
ErrorRecordsTotals := record
Errors.FieldNum;
Errors.ErrorNum;
unsigned Cnt := count(group);
Errors.SRC;
end;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,SRC,FEW);
PrettyErrorTotals := record
TotalErrors.SRC;
FieldNme := Fields.FieldName(TotalErrors.FieldNum);
ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_VENDOR_ID(TotalErrors.ErrorNum),Fields.InValidMessage_DID(TotalErrors.ErrorNum),Fields.InValidMessage_NPI_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_DEA_NUMBER(TotalErrors.ErrorNum),'','',Fields.InValidMessage_LIC_NBR(TotalErrors.ErrorNum),Fields.InValidMessage_UPIN(TotalErrors.ErrorNum),'','',Fields.InValidMessage_TAX_ID(TotalErrors.ErrorNum),Fields.InValidMessage_DOB(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_ZIP(TotalErrors.ErrorNum),'',Fields.InValidMessage_PRIM_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_LNAME(TotalErrors.ErrorNum),Fields.InValidMessage_V_CITY_NAME(TotalErrors.ErrorNum),'',Fields.InValidMessage_MNAME(TotalErrors.ErrorNum),Fields.InValidMessage_FNAME(TotalErrors.ErrorNum),Fields.InValidMessage_SEC_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_SNAME(TotalErrors.ErrorNum),Fields.InValidMessage_ST(TotalErrors.ErrorNum),Fields.InValidMessage_GENDER(TotalErrors.ErrorNum),Fields.InValidMessage_PHONE(TotalErrors.ErrorNum),Fields.InValidMessage_LIC_STATE(TotalErrors.ErrorNum),Fields.InValidMessage_ADDRESS_ID(TotalErrors.ErrorNum),Fields.InValidMessage_CNAME(TotalErrors.ErrorNum),Fields.InValidMessage_SRC(TotalErrors.ErrorNum),Fields.InValidMessage_DT_FIRST_SEEN(TotalErrors.ErrorNum),Fields.InValidMessage_DT_LAST_SEEN(TotalErrors.ErrorNum),Fields.InValidMessage_DT_LIC_EXPIRATION(TotalErrors.ErrorNum),Fields.InValidMessage_DT_DEA_EXPIRATION(TotalErrors.ErrorNum),Fields.InValidMessage_GEO_LAT(TotalErrors.ErrorNum),Fields.InValidMessage_GEO_LONG(TotalErrors.ErrorNum));
TotalErrors.Cnt;
end;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
export ValidityErrors := join(ValErr,SourceCounts,left.SRC=right.SRC,lookup); // Add source group counts for STRATA compliance
//We have LNPID specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT27.MOD_ClusterStats.Counts(h,LNPID);
EXPORT ClusterSrc := SALT27.MOD_ClusterStats.Sources(h,LNPID,SRC);
end;
