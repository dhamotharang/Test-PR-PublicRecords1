IMPORT SALT37,std;
EXPORT Key_InsuranceHeader_(BOOLEAN incremental=FALSE) := MODULE
 
//SNAME:FNAME:MNAME:?:LNAME:DERIVED_GENDER:+:PRIM_RANGE:PRIM_NAME:SEC_RANGE:CITY:ST:ZIP:SSN5:SSN4:DOB:PHONE:DL_STATE:DL_NBR:SRC:SOURCE_RID:DT_FIRST_SEEN:DT_LAST_SEEN:DT_EFFECTIVE_FIRST:DT_EFFECTIVE_LAST:MAINNAME:FULLNAME:ADDR1:LOCALE:ADDRESS
EXPORT KeyName := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+Config.KeyInfix+'::DID::Refs';
 
EXPORT KeyName_sf := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+KeySuperfile+'::DID::Refs';
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
STRING csv_fields := 'SNAME,FNAME,MNAME,LNAME,DERIVED_GENDER,PRIM_RANGE,PRIM_NAME,SEC_RANGE,CITY,ST,ZIP,SSN5,SSN4,DOB_year,DOB_month,DOB_day,PHONE,DL_STATE,DL_NBR,SRC,SOURCE_RID,DID';
SHARED h := CandidatesForKey(csv_fields,incremental);//The input file - distributed by DID
EXPORT Layout_Uber_Record := RECORD(SALT37.Layout_Uber_Record0)
END;
EXPORT Layout_Uber_Plus := RECORD(Layout_Uber_Record)
  SALT37.Str30Type word;
  UNSIGNED2 word_weight100 := 0;
END;
EXPORT Fn_Reduce_Uber_Local(DATASET(Layout_Uber_Plus) in_ds) := FUNCTION
// The file need NOT be distributed at this point; it will still reduce the record count ...
  RETURN DEDUP(SORT(in_ds,uid,word,field,LOCAL),uid,word,field,LOCAL);
END;
Layout_Uber_Plus IntoInversion(h le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,Fields.Make_SNAME((SALT37.StrType)le.SNAME),Fields.Make_FNAME((SALT37.StrType)le.FNAME),Fields.Make_MNAME((SALT37.StrType)le.MNAME),Fields.Make_LNAME((SALT37.StrType)le.LNAME),Fields.Make_DERIVED_GENDER((SALT37.StrType)le.DERIVED_GENDER),Fields.Make_PRIM_RANGE((SALT37.StrType)le.PRIM_RANGE),Fields.Make_PRIM_NAME((SALT37.StrType)le.PRIM_NAME),Fields.Make_SEC_RANGE((SALT37.StrType)le.SEC_RANGE),Fields.Make_CITY((SALT37.StrType)le.CITY),Fields.Make_ST((SALT37.StrType)le.ST),(SALT37.StrType)le.ZIP,Fields.Make_SSN5((SALT37.StrType)le.SSN5),Fields.Make_SSN4((SALT37.StrType)le.SSN4),(SALT37.StrType)(le.DOB_year*10000+le.DOB_month*100+le.DOB_day),(SALT37.StrType)le.PHONE,Fields.Make_DL_STATE((SALT37.StrType)le.DL_STATE),Fields.Make_DL_NBR((SALT37.StrType)le.DL_NBR),Fields.Make_SRC((SALT37.StrType)le.SRC),Fields.Make_SOURCE_RID((SALT37.StrType)le.SOURCE_RID),'','','','',SKIP,SKIP,SKIP,SKIP,SKIP,SKIP);
  SELF.field := c;
  SELF.uid := le.DID;
  SELF := le;
END;
nfields_r := Fn_Reduce_UBER_Local(NORMALIZE(h,28,IntoInversion(LEFT,COUNTER))(word<>''));
SALT37.MAC_Expand_Normal_Field(h,FNAME,24,DID,layout_uber_plus,nfields5592);
SALT37.MAC_Expand_Normal_Field(h,MNAME,24,DID,layout_uber_plus,nfields5593);
SALT37.MAC_Expand_Normal_Field(h,LNAME,24,DID,layout_uber_plus,nfields5594);
nfields24 := nfields5592+nfields5593+nfields5594;//Collect wordbags for parts of concept field
SALT37.MAC_Expand_Normal_Field(h,FNAME,25,DID,layout_uber_plus,nfields1357225);
SALT37.MAC_Expand_Normal_Field(h,MNAME,25,DID,layout_uber_plus,nfields1357226);
SALT37.MAC_Expand_Normal_Field(h,LNAME,25,DID,layout_uber_plus,nfields1357227);
nfields5825 := nfields1357225+nfields1357226+nfields1357227;//Collect wordbags for parts of concept field
SALT37.MAC_Expand_Normal_Field(h,SNAME,25,DID,layout_uber_plus,nfields5826);
nfields25 := nfields5825+nfields5826;//Collect wordbags for parts of concept field
SALT37.MAC_Expand_Normal_Field(h,PRIM_RANGE,26,DID,layout_uber_plus,nfields6058);
SALT37.MAC_Expand_Normal_Field(h,SEC_RANGE,26,DID,layout_uber_plus,nfields6059);
SALT37.MAC_Expand_Normal_Field(h,PRIM_NAME,26,DID,layout_uber_plus,nfields6060);
nfields26 := nfields6058+nfields6059+nfields6060;//Collect wordbags for parts of concept field
SALT37.MAC_Expand_Normal_Field(h,CITY,27,DID,layout_uber_plus,nfields6291);
SALT37.MAC_Expand_Normal_Field(h,ST,27,DID,layout_uber_plus,nfields6292);
SALT37.MAC_Expand_Normal_Field(h,ZIP,27,DID,layout_uber_plus,nfields6293);
nfields27 := nfields6291+nfields6292+nfields6293;//Collect wordbags for parts of concept field
SALT37.MAC_Expand_Normal_Field(h,PRIM_RANGE,28,DID,layout_uber_plus,nfields1520092);
SALT37.MAC_Expand_Normal_Field(h,SEC_RANGE,28,DID,layout_uber_plus,nfields1520093);
SALT37.MAC_Expand_Normal_Field(h,PRIM_NAME,28,DID,layout_uber_plus,nfields1520094);
nfields6524 := nfields1520092+nfields1520093+nfields1520094;//Collect wordbags for parts of concept field
SALT37.MAC_Expand_Normal_Field(h,CITY,28,DID,layout_uber_plus,nfields1520325);
SALT37.MAC_Expand_Normal_Field(h,ST,28,DID,layout_uber_plus,nfields1520326);
SALT37.MAC_Expand_Normal_Field(h,ZIP,28,DID,layout_uber_plus,nfields1520327);
nfields6525 := nfields1520325+nfields1520326+nfields1520327;//Collect wordbags for parts of concept field
nfields28 := nfields6524+nfields6525;//Collect wordbags for parts of concept field
NumberBaseFields := 28;
 
  infile := Relatives;
Layout_Uber_Plus IntoInversion0(infile le,UNSIGNED2 c,UNSIGNED el=1) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT37.StrType)le.fname2,(SALT37.StrType)le.lname2,SKIP);
  SELF.field := c+0+NumberBaseFields; // Field number is attr file + Fields from attr files + BaseFields
  SELF.uid := le.DID;
  SELF := le;
END;
afields0 := NORMALIZE(infile,2,IntoInversion0(LEFT,COUNTER))(word<>'');
invert_records := nfields_r + nfields24 + afields0;
SHARED DataForKey0 := Fn_Reduce_UBER_Local( DISTRIBUTE(invert_records,HASH(uid)) );
 
EXPORT ValueKeyName := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+Config.KeyInfix+'::DID::Words';
 
EXPORT ValueKeyName_sf := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+KeySuperfile+'::DID::Words';
 
EXPORT AssignCurrentValueKeyToSuperFile := FileServices.AddSuperFile(ValueKeyName_sf,ValueKeyName);
 
EXPORT ClearValueKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(ValueKeyName_sf,,TRUE),FileServices.ClearSuperFile(ValueKeyName_sf));
  r0 := RECORD
    DataForKey0.uid;
    UNSIGNED6 InCluster := COUNT(GROUP);
  END;
  SHARED ClusterSizes := TABLE(DataForKey0,r0,uid,LOCAL);// Set up for Specificity_Local
  SHARED TotalClusters := COUNT(ClusterSizes);
  SALT37.MAC_Specificity_Local(DataForKey0,word,uid,word_nulls,SALT37.Layout_Uber_Nulls,word_specificity,word_switch,word_values);
 
EXPORT ValueKey := INDEX(word_values,{word},{word_values},ValueKeyName);
  Layout_Uber_Plus add_id(Layout_Uber_Plus le,word_values ri,BOOLEAN patch_default) := TRANSFORM
    SELF.word_id := ri.id;
    SELF := le;
  END;
  SALT37.Mac_Choose_JoinType(DataForKey0,word_nulls,word_values,word,word_weight100,add_id,DataForKey1);
  DataForKey2:=DEDUP( SORT(DataForKey1,uid,word,field,LOCAL),uid,word,field,LOCAL );
  Layout_Uber_record slim(DataForKey2 le) := TRANSFORM
    SELF := le;
  END;
  SHARED DataForKey3 := DEDUP(SORT(PROJECT(DataForKey2,slim(LEFT)),WHOLE RECORD,SKEW(1)),WHOLE RECORD);
 
EXPORT Key := INDEX(DataForKey3,{DataForKey3},{},KeyName);
 
EXPORT BuildAll := PARALLEL(BUILDINDEX(ValueKey, OVERWRITE),BUILDINDEX(Key, OVERWRITE));
EXPORT MergeKeyFiles(STRING superFileIn, STRING outfileName, UNSIGNED4 minDate = 0, BOOLEAN replaceExisting = FALSE) := FUNCTION
  fieldListIndex := SALT37.MAC_FieldListCSVFromDataset(DataForKey3,[],',');
  fieldListPayload := '';
  RETURN Process_xIDL_Layouts().MAC_GenerateMergedKey(superFileIn, outfileName, minDate, replaceExisting, fieldListIndex, fieldListPayload, 'Key');
END;
EXPORT MergeKeyValueFiles(STRING superFileIn, STRING outfileName, UNSIGNED4 minDate = 0, BOOLEAN replaceExisting = FALSE) := FUNCTION
  fieldListIndex := 'word';
  fieldListPayload := SALT37.MAC_FieldListCSVFromDataset(word_values,['word'],',');
  RETURN Process_xIDL_Layouts().MAC_GenerateMergedKey(superFileIn, outfileName, minDate, replaceExisting, fieldListIndex, fieldListPayload, 'ValueKey');
END;
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.SNAME) param_SNAME = (TYPEOF(h.SNAME))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',TYPEOF(h.DERIVED_GENDER) param_DERIVED_GENDER = (TYPEOF(h.DERIVED_GENDER))'',TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',TYPEOF(h.PRIM_RANGE_len) param_PRIM_RANGE_len = (TYPEOF(h.PRIM_RANGE_len))'',TYPEOF(h.PRIM_NAME) param_PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',TYPEOF(h.PRIM_NAME_len) param_PRIM_NAME_len = (TYPEOF(h.PRIM_NAME_len))'',TYPEOF(h.SEC_RANGE) param_SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',TYPEOF(h.CITY) param_CITY = (TYPEOF(h.CITY))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.ZIP) param_ZIP = (TYPEOF(h.ZIP))'',TYPEOF(h.SSN5) param_SSN5 = (TYPEOF(h.SSN5))'',TYPEOF(h.SSN5_len) param_SSN5_len = (TYPEOF(h.SSN5_len))'',TYPEOF(h.SSN4) param_SSN4 = (TYPEOF(h.SSN4))'',TYPEOF(h.SSN4_len) param_SSN4_len = (TYPEOF(h.SSN4_len))'',UNSIGNED4 param_DOB,TYPEOF(h.PHONE) param_PHONE = (TYPEOF(h.PHONE))'',TYPEOF(h.DL_STATE) param_DL_STATE = (TYPEOF(h.DL_STATE))'',TYPEOF(h.DL_NBR) param_DL_NBR = (TYPEOF(h.DL_NBR))'',TYPEOF(h.DL_NBR_len) param_DL_NBR_len = (TYPEOF(h.DL_NBR_len))'',TYPEOF(h.SRC) param_SRC = (TYPEOF(h.SRC))'',TYPEOF(h.SOURCE_RID) param_SOURCE_RID = (TYPEOF(h.SOURCE_RID))'',SALT37.StrType param_MAINNAME,TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',SALT37.StrType param_FULLNAME,TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',SALT37.StrType param_ADDR1,TYPEOF(h.PRIM_RANGE_len) param_PRIM_RANGE_len = (TYPEOF(h.PRIM_RANGE_len))'',TYPEOF(h.PRIM_NAME_len) param_PRIM_NAME_len = (TYPEOF(h.PRIM_NAME_len))'',SALT37.StrType param_LOCALE,SALT37.StrType param_ADDRESS,TYPEOF(h.PRIM_RANGE_len) param_PRIM_RANGE_len = (TYPEOF(h.PRIM_RANGE_len))'',TYPEOF(h.PRIM_NAME_len) param_PRIM_NAME_len = (TYPEOF(h.PRIM_NAME_len))'',SALT37.StrType param_fname2,SALT37.StrType param_lname2) := 
  FUNCTION
 //Create wordstream from parameters
    SALT37.MAC_Field_To_UberStream(param_SNAME,1,ValueKey,WS1);
    SALT37.MAC_Field_To_UberStream(param_FNAME,2,ValueKey,WS2);
    SALT37.MAC_Field_To_UberStream(param_MNAME,3,ValueKey,WS3);
    SALT37.MAC_Field_To_UberStream(param_LNAME,4,ValueKey,WS4);
    SALT37.MAC_Field_To_UberStream(param_DERIVED_GENDER,5,ValueKey,WS5);
    SALT37.MAC_Field_To_UberStream(param_PRIM_RANGE,6,ValueKey,WS6);
    SALT37.MAC_Field_To_UberStream(param_PRIM_NAME,7,ValueKey,WS7);
    SALT37.MAC_Field_To_UberStream(param_SEC_RANGE,8,ValueKey,WS8);
    SALT37.MAC_Field_To_UberStream(param_CITY,9,ValueKey,WS9);
    SALT37.MAC_Field_To_UberStream(param_ST,10,ValueKey,WS10);
    SALT37.MAC_Field_To_UberStream(param_ZIP,11,ValueKey,WS11);
    SALT37.MAC_Field_To_UberStream(param_SSN5,12,ValueKey,WS12);
    SALT37.MAC_Field_To_UberStream(param_SSN4,13,ValueKey,WS13);
    SALT37.MAC_Field_To_UberStream(param_DOB,14,ValueKey,WS14);
    SALT37.MAC_Field_To_UberStream(param_PHONE,15,ValueKey,WS15);
    SALT37.MAC_Field_To_UberStream(param_DL_STATE,16,ValueKey,WS16);
    SALT37.MAC_Field_To_UberStream(param_DL_NBR,17,ValueKey,WS17);
    SALT37.MAC_Field_To_UberStream(param_SRC,18,ValueKey,WS18);
    SALT37.MAC_Field_To_UberStream(param_SOURCE_RID,19,ValueKey,WS19);
    SALT37.MAC_Field_To_UberStream(param_MAINNAME,24,ValueKey,WS24);
    SALT37.MAC_Field_To_UberStream(param_FULLNAME,25,ValueKey,WS25);
    SALT37.MAC_Field_To_UberStream(param_ADDR1,26,ValueKey,WS26);
    SALT37.MAC_Field_To_UberStream(param_LOCALE,27,ValueKey,WS27);
    SALT37.MAC_Field_To_UberStream(param_ADDRESS,28,ValueKey,WS28);
    SALT37.MAC_Field_To_UberStream(param_fname2,29,ValueKey,WS29);
    SALT37.MAC_Field_To_UberStream(param_lname2,30,ValueKey,WS30);
    wds := WS1+WS2+WS3+WS4+WS5+WS6+WS7+WS8+WS9+WS10+WS11+WS12+WS13+WS14+WS15+WS16+WS17+WS18+WS19+WS24+WS25+WS26+WS27+WS28+WS29+WS30;
    SALT37.MAC_Collate_Uber_Matches(Key,Wds,steppedmatches,Layout_Uber_Record,,,,,,,);
    RETURN steppedmatches;
  END;
 
EXPORT ScoredDIDFetch(TYPEOF(h.SNAME) param_SNAME = (TYPEOF(h.SNAME))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',TYPEOF(h.DERIVED_GENDER) param_DERIVED_GENDER = (TYPEOF(h.DERIVED_GENDER))'',TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',TYPEOF(h.PRIM_RANGE_len) param_PRIM_RANGE_len = (TYPEOF(h.PRIM_RANGE_len))'',TYPEOF(h.PRIM_NAME) param_PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',TYPEOF(h.PRIM_NAME_len) param_PRIM_NAME_len = (TYPEOF(h.PRIM_NAME_len))'',TYPEOF(h.SEC_RANGE) param_SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',TYPEOF(h.CITY) param_CITY = (TYPEOF(h.CITY))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.ZIP) param_ZIP = (TYPEOF(h.ZIP))'',TYPEOF(h.SSN5) param_SSN5 = (TYPEOF(h.SSN5))'',TYPEOF(h.SSN5_len) param_SSN5_len = (TYPEOF(h.SSN5_len))'',TYPEOF(h.SSN4) param_SSN4 = (TYPEOF(h.SSN4))'',TYPEOF(h.SSN4_len) param_SSN4_len = (TYPEOF(h.SSN4_len))'',UNSIGNED4 param_DOB,TYPEOF(h.PHONE) param_PHONE = (TYPEOF(h.PHONE))'',TYPEOF(h.DL_STATE) param_DL_STATE = (TYPEOF(h.DL_STATE))'',TYPEOF(h.DL_NBR) param_DL_NBR = (TYPEOF(h.DL_NBR))'',TYPEOF(h.DL_NBR_len) param_DL_NBR_len = (TYPEOF(h.DL_NBR_len))'',TYPEOF(h.SRC) param_SRC = (TYPEOF(h.SRC))'',TYPEOF(h.SOURCE_RID) param_SOURCE_RID = (TYPEOF(h.SOURCE_RID))'',SALT37.StrType param_MAINNAME,TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',SALT37.StrType param_FULLNAME,TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',SALT37.StrType param_ADDR1,TYPEOF(h.PRIM_RANGE_len) param_PRIM_RANGE_len = (TYPEOF(h.PRIM_RANGE_len))'',TYPEOF(h.PRIM_NAME_len) param_PRIM_NAME_len = (TYPEOF(h.PRIM_NAME_len))'',SALT37.StrType param_LOCALE,SALT37.StrType param_ADDRESS,TYPEOF(h.PRIM_RANGE_len) param_PRIM_RANGE_len = (TYPEOF(h.PRIM_RANGE_len))'',TYPEOF(h.PRIM_NAME_len) param_PRIM_NAME_len = (TYPEOF(h.PRIM_NAME_len))'',SALT37.StrType param_fname2,SALT37.StrType param_lname2,BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetch(param_SNAME,param_FNAME,param_FNAME_len,param_MNAME,param_MNAME_len,param_LNAME,param_LNAME_len,param_DERIVED_GENDER,param_PRIM_RANGE,param_PRIM_RANGE_len,param_PRIM_NAME,param_PRIM_NAME_len,param_SEC_RANGE,param_CITY,param_ST,param_ZIP,param_SSN5,param_SSN5_len,param_SSN4,param_SSN4_len,param_DOB,param_PHONE,param_DL_STATE,param_DL_NBR,param_DL_NBR_len,param_SRC,param_SOURCE_RID,param_MAINNAME,param_FNAME_len,param_MNAME_len,param_LNAME_len,param_FULLNAME,param_FNAME_len,param_MNAME_len,param_LNAME_len,param_ADDR1,param_PRIM_RANGE_len,param_PRIM_NAME_len,param_LOCALE,param_ADDRESS,param_PRIM_RANGE_len,param_PRIM_NAME_len,param_fname2,param_lname2);
 
  Process_xIDL_Layouts().LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 0; // Set bitmap for keys used
    SELF.keys_failed := 0; // Set bitmap for keys failed
    SELF.DID := le.uid;
    SELF.Weight := le.Weight; // Already rolled up in collate_uber
    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));
  result1 := ROLLUP(result0,LEFT.DID = RIGHT.DID,Process_xIDL_Layouts().combine_scores(LEFT,RIGHT,param_disableForce));
  RETURN result1;
END;
END;
