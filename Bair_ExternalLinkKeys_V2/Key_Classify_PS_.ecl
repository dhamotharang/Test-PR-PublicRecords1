IMPORT SALT37,std;
EXPORT Key_Classify_PS_ := MODULE
 
//NAME_SUFFIX:FNAME:MNAME:?:LNAME:PRIM_RANGE:+:PRIM_NAME:SEC_RANGE:P_CITY_NAME:ST:ZIP:DOB:PHONE:DL_ST:DL:LEXID:POSSIBLE_SSN:CRIME:NAME_TYPE:CLEAN_GENDER:CLASS_CODE:DT_FIRST_SEEN:DT_LAST_SEEN:DATA_PROVIDER_ORI:VIN:PLATE:LATITUDE:LONGITUDE:SEARCH_ADDR1:SEARCH_ADDR2:CLEAN_COMPANY_NAME:MAINNAME:FULLNAME
EXPORT KeyName := '~'+KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+Config.KeyInfix+'::EID_HASH::Refs';
 
EXPORT KeyName_sf := '~'+KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+KeySuperfile+'::EID_HASH::Refs';
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
SHARED h := CandidatesForKey;//The input file - distributed by EID_HASH
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
  SELF.word := CHOOSE(c,Fields.Make_NAME_SUFFIX((SALT37.StrType)le.NAME_SUFFIX),Fields.Make_FNAME((SALT37.StrType)le.FNAME),Fields.Make_MNAME((SALT37.StrType)le.MNAME),'',Fields.Make_PRIM_RANGE((SALT37.StrType)le.PRIM_RANGE),Fields.Make_PRIM_NAME((SALT37.StrType)le.PRIM_NAME),Fields.Make_SEC_RANGE((SALT37.StrType)le.SEC_RANGE),Fields.Make_P_CITY_NAME((SALT37.StrType)le.P_CITY_NAME),Fields.Make_ST((SALT37.StrType)le.ST),(SALT37.StrType)le.ZIP,(SALT37.StrType)(le.DOB_year*10000+le.DOB_month*100+le.DOB_day),(SALT37.StrType)le.PHONE,Fields.Make_DL_ST((SALT37.StrType)le.DL_ST),Fields.Make_DL((SALT37.StrType)le.DL),Fields.Make_LEXID((SALT37.StrType)le.LEXID),Fields.Make_POSSIBLE_SSN((SALT37.StrType)le.POSSIBLE_SSN),Fields.Make_CRIME((SALT37.StrType)le.CRIME),Fields.Make_NAME_TYPE((SALT37.StrType)le.NAME_TYPE),Fields.Make_CLEAN_GENDER((SALT37.StrType)le.CLEAN_GENDER),Fields.Make_CLASS_CODE((SALT37.StrType)le.CLASS_CODE),Fields.Make_DT_FIRST_SEEN((SALT37.StrType)le.DT_FIRST_SEEN),Fields.Make_DT_LAST_SEEN((SALT37.StrType)le.DT_LAST_SEEN),Fields.Make_DATA_PROVIDER_ORI((SALT37.StrType)le.DATA_PROVIDER_ORI),Fields.Make_VIN((SALT37.StrType)le.VIN),Fields.Make_PLATE((SALT37.StrType)le.PLATE),Fields.Make_LATITUDE((SALT37.StrType)le.LATITUDE),Fields.Make_LONGITUDE((SALT37.StrType)le.LONGITUDE),Fields.Make_SEARCH_ADDR1((SALT37.StrType)le.SEARCH_ADDR1),Fields.Make_SEARCH_ADDR2((SALT37.StrType)le.SEARCH_ADDR2),Fields.Make_CLEAN_COMPANY_NAME((SALT37.StrType)le.CLEAN_COMPANY_NAME),SKIP,SKIP,SKIP);
  SELF.field := c;
  SELF.uid := le.EID_HASH;
  SELF := le;
END;
nfields_r := Fn_Reduce_UBER_Local(NORMALIZE(h,32,IntoInversion(LEFT,COUNTER))(word<>''));
SALT37.MAC_Expand_Wordbag_Field(h,LNAME,4,EID_HASH,layout_uber_plus,nfields4);
SALT37.MAC_Expand_Normal_Field(h,FNAME,31,EID_HASH,layout_uber_plus,nfields7223);
SALT37.MAC_Expand_Normal_Field(h,MNAME,31,EID_HASH,layout_uber_plus,nfields7224);
SALT37.MAC_Expand_Wordbag_Field(h,LNAME,31,EID_HASH,layout_uber_plus,nfields7225);
nfields31 := nfields7223+nfields7224+nfields7225;//Collect wordbags for parts of concept field
SALT37.MAC_Expand_Normal_Field(h,FNAME,32,EID_HASH,layout_uber_plus,nfields1737248);
SALT37.MAC_Expand_Normal_Field(h,MNAME,32,EID_HASH,layout_uber_plus,nfields1737249);
SALT37.MAC_Expand_Wordbag_Field(h,LNAME,32,EID_HASH,layout_uber_plus,nfields1737250);
nfields7456 := nfields1737248+nfields1737249+nfields1737250;//Collect wordbags for parts of concept field
SALT37.MAC_Expand_Normal_Field(h,NAME_SUFFIX,32,EID_HASH,layout_uber_plus,nfields7457);
nfields32 := nfields7456+nfields7457;//Collect wordbags for parts of concept field
invert_records := nfields_r + nfields4;
SHARED DataForKey0 := Fn_Reduce_UBER_Local( invert_records );
 
EXPORT ValueKeyName := '~'+KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+Config.KeyInfix+'::EID_HASH::Words';
 
EXPORT ValueKeyName_sf := '~'+KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+KeySuperfile+'::EID_HASH::Words';
 
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
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.NAME_SUFFIX) param_NAME_SUFFIX = (TYPEOF(h.NAME_SUFFIX))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',TYPEOF(h.PRIM_RANGE_len) param_PRIM_RANGE_len = (TYPEOF(h.PRIM_RANGE_len))'',TYPEOF(h.PRIM_NAME) param_PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',TYPEOF(h.PRIM_NAME_len) param_PRIM_NAME_len = (TYPEOF(h.PRIM_NAME_len))'',TYPEOF(h.SEC_RANGE) param_SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',TYPEOF(h.P_CITY_NAME) param_P_CITY_NAME = (TYPEOF(h.P_CITY_NAME))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.ZIP) param_ZIP = (TYPEOF(h.ZIP))'',UNSIGNED4 param_DOB,TYPEOF(h.PHONE) param_PHONE = (TYPEOF(h.PHONE))'',TYPEOF(h.DL_ST) param_DL_ST = (TYPEOF(h.DL_ST))'',TYPEOF(h.DL) param_DL = (TYPEOF(h.DL))'',TYPEOF(h.LEXID) param_LEXID = (TYPEOF(h.LEXID))'',TYPEOF(h.POSSIBLE_SSN) param_POSSIBLE_SSN = (TYPEOF(h.POSSIBLE_SSN))'',TYPEOF(h.POSSIBLE_SSN_len) param_POSSIBLE_SSN_len = (TYPEOF(h.POSSIBLE_SSN_len))'',TYPEOF(h.CRIME) param_CRIME = (TYPEOF(h.CRIME))'',TYPEOF(h.NAME_TYPE) param_NAME_TYPE = (TYPEOF(h.NAME_TYPE))'',TYPEOF(h.CLEAN_GENDER) param_CLEAN_GENDER = (TYPEOF(h.CLEAN_GENDER))'',TYPEOF(h.CLASS_CODE) param_CLASS_CODE = (TYPEOF(h.CLASS_CODE))'',TYPEOF(h.DT_FIRST_SEEN) param_DT_FIRST_SEEN = (TYPEOF(h.DT_FIRST_SEEN))'',TYPEOF(h.DT_LAST_SEEN) param_DT_LAST_SEEN = (TYPEOF(h.DT_LAST_SEEN))'',TYPEOF(h.DATA_PROVIDER_ORI) param_DATA_PROVIDER_ORI = (TYPEOF(h.DATA_PROVIDER_ORI))'',TYPEOF(h.VIN) param_VIN = (TYPEOF(h.VIN))'',TYPEOF(h.PLATE) param_PLATE = (TYPEOF(h.PLATE))'',TYPEOF(h.LATITUDE) param_LATITUDE = (TYPEOF(h.LATITUDE))'',TYPEOF(h.LONGITUDE) param_LONGITUDE = (TYPEOF(h.LONGITUDE))'',TYPEOF(h.SEARCH_ADDR1) param_SEARCH_ADDR1 = (TYPEOF(h.SEARCH_ADDR1))'',TYPEOF(h.SEARCH_ADDR2) param_SEARCH_ADDR2 = (TYPEOF(h.SEARCH_ADDR2))'',TYPEOF(h.CLEAN_COMPANY_NAME) param_CLEAN_COMPANY_NAME = (TYPEOF(h.CLEAN_COMPANY_NAME))'',SALT37.StrType param_MAINNAME,TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',SALT37.StrType param_FULLNAME,TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'') := 
  FUNCTION
 //Create wordstream from parameters
    SALT37.MAC_Field_To_UberStream(param_NAME_SUFFIX,1,ValueKey,WS1);
    SALT37.MAC_Field_To_UberStream(param_FNAME,2,ValueKey,WS2);
    SALT37.MAC_Field_To_UberStream(param_MNAME,3,ValueKey,WS3);
    SALT37.MAC_FieldWordBag_To_UberStream(param_LNAME,4,ValueKey,WS4);
    SALT37.MAC_Field_To_UberStream(param_PRIM_RANGE,5,ValueKey,WS5);
    SALT37.MAC_Field_To_UberStream(param_PRIM_NAME,6,ValueKey,WS6);
    SALT37.MAC_Field_To_UberStream(param_SEC_RANGE,7,ValueKey,WS7);
    SALT37.MAC_Field_To_UberStream(param_P_CITY_NAME,8,ValueKey,WS8);
    SALT37.MAC_Field_To_UberStream(param_ST,9,ValueKey,WS9);
    SALT37.MAC_Field_To_UberStream(param_ZIP,10,ValueKey,WS10);
    SALT37.MAC_Field_To_UberStream(param_DOB,11,ValueKey,WS11);
    SALT37.MAC_Field_To_UberStream(param_PHONE,12,ValueKey,WS12);
    SALT37.MAC_Field_To_UberStream(param_DL_ST,13,ValueKey,WS13);
    SALT37.MAC_Field_To_UberStream(param_DL,14,ValueKey,WS14);
    SALT37.MAC_Field_To_UberStream(param_LEXID,15,ValueKey,WS15);
    SALT37.MAC_Field_To_UberStream(param_POSSIBLE_SSN,16,ValueKey,WS16);
    SALT37.MAC_Field_To_UberStream(param_CRIME,17,ValueKey,WS17);
    SALT37.MAC_Field_To_UberStream(param_NAME_TYPE,18,ValueKey,WS18);
    SALT37.MAC_Field_To_UberStream(param_CLEAN_GENDER,19,ValueKey,WS19);
    SALT37.MAC_Field_To_UberStream(param_CLASS_CODE,20,ValueKey,WS20);
    SALT37.MAC_Field_To_UberStream(param_DT_FIRST_SEEN,21,ValueKey,WS21);
    SALT37.MAC_Field_To_UberStream(param_DT_LAST_SEEN,22,ValueKey,WS22);
    SALT37.MAC_Field_To_UberStream(param_DATA_PROVIDER_ORI,23,ValueKey,WS23);
    SALT37.MAC_Field_To_UberStream(param_VIN,24,ValueKey,WS24);
    SALT37.MAC_Field_To_UberStream(param_PLATE,25,ValueKey,WS25);
    SALT37.MAC_Field_To_UberStream(param_LATITUDE,26,ValueKey,WS26);
    SALT37.MAC_Field_To_UberStream(param_LONGITUDE,27,ValueKey,WS27);
    SALT37.MAC_Field_To_UberStream(param_SEARCH_ADDR1,28,ValueKey,WS28);
    SALT37.MAC_Field_To_UberStream(param_SEARCH_ADDR2,29,ValueKey,WS29);
    SALT37.MAC_Field_To_UberStream(param_CLEAN_COMPANY_NAME,30,ValueKey,WS30);
    SALT37.MAC_Field_To_UberStream(param_MAINNAME,31,ValueKey,WS31);
    SALT37.MAC_Field_To_UberStream(param_FULLNAME,32,ValueKey,WS32);
    wds := WS1+WS2+WS3+WS4+WS5+WS6+WS7+WS8+WS9+WS10+WS11+WS12+WS13+WS14+WS15+WS16+WS17+WS18+WS19+WS20+WS21+WS22+WS23+WS24+WS25+WS26+WS27+WS28+WS29+WS30+WS31+WS32;
    SALT37.MAC_Collate_Uber_Matches(Key,Wds,steppedmatches,Layout_Uber_Record,,,,,,,);
    RETURN steppedmatches;
  END;
 
EXPORT ScoredEID_HASHFetch(TYPEOF(h.NAME_SUFFIX) param_NAME_SUFFIX = (TYPEOF(h.NAME_SUFFIX))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',TYPEOF(h.PRIM_RANGE_len) param_PRIM_RANGE_len = (TYPEOF(h.PRIM_RANGE_len))'',TYPEOF(h.PRIM_NAME) param_PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',TYPEOF(h.PRIM_NAME_len) param_PRIM_NAME_len = (TYPEOF(h.PRIM_NAME_len))'',TYPEOF(h.SEC_RANGE) param_SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',TYPEOF(h.P_CITY_NAME) param_P_CITY_NAME = (TYPEOF(h.P_CITY_NAME))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.ZIP) param_ZIP = (TYPEOF(h.ZIP))'',UNSIGNED4 param_DOB,TYPEOF(h.PHONE) param_PHONE = (TYPEOF(h.PHONE))'',TYPEOF(h.DL_ST) param_DL_ST = (TYPEOF(h.DL_ST))'',TYPEOF(h.DL) param_DL = (TYPEOF(h.DL))'',TYPEOF(h.LEXID) param_LEXID = (TYPEOF(h.LEXID))'',TYPEOF(h.POSSIBLE_SSN) param_POSSIBLE_SSN = (TYPEOF(h.POSSIBLE_SSN))'',TYPEOF(h.POSSIBLE_SSN_len) param_POSSIBLE_SSN_len = (TYPEOF(h.POSSIBLE_SSN_len))'',TYPEOF(h.CRIME) param_CRIME = (TYPEOF(h.CRIME))'',TYPEOF(h.NAME_TYPE) param_NAME_TYPE = (TYPEOF(h.NAME_TYPE))'',TYPEOF(h.CLEAN_GENDER) param_CLEAN_GENDER = (TYPEOF(h.CLEAN_GENDER))'',TYPEOF(h.CLASS_CODE) param_CLASS_CODE = (TYPEOF(h.CLASS_CODE))'',TYPEOF(h.DT_FIRST_SEEN) param_DT_FIRST_SEEN = (TYPEOF(h.DT_FIRST_SEEN))'',TYPEOF(h.DT_LAST_SEEN) param_DT_LAST_SEEN = (TYPEOF(h.DT_LAST_SEEN))'',TYPEOF(h.DATA_PROVIDER_ORI) param_DATA_PROVIDER_ORI = (TYPEOF(h.DATA_PROVIDER_ORI))'',TYPEOF(h.VIN) param_VIN = (TYPEOF(h.VIN))'',TYPEOF(h.PLATE) param_PLATE = (TYPEOF(h.PLATE))'',TYPEOF(h.LATITUDE) param_LATITUDE = (TYPEOF(h.LATITUDE))'',TYPEOF(h.LONGITUDE) param_LONGITUDE = (TYPEOF(h.LONGITUDE))'',TYPEOF(h.SEARCH_ADDR1) param_SEARCH_ADDR1 = (TYPEOF(h.SEARCH_ADDR1))'',TYPEOF(h.SEARCH_ADDR2) param_SEARCH_ADDR2 = (TYPEOF(h.SEARCH_ADDR2))'',TYPEOF(h.CLEAN_COMPANY_NAME) param_CLEAN_COMPANY_NAME = (TYPEOF(h.CLEAN_COMPANY_NAME))'',SALT37.StrType param_MAINNAME,TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',SALT37.StrType param_FULLNAME,TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetch(param_NAME_SUFFIX,param_FNAME,param_FNAME_len,param_MNAME,param_MNAME_len,param_LNAME,param_PRIM_RANGE,param_PRIM_RANGE_len,param_PRIM_NAME,param_PRIM_NAME_len,param_SEC_RANGE,param_P_CITY_NAME,param_ST,param_ZIP,param_DOB,param_PHONE,param_DL_ST,param_DL,param_LEXID,param_POSSIBLE_SSN,param_POSSIBLE_SSN_len,param_CRIME,param_NAME_TYPE,param_CLEAN_GENDER,param_CLASS_CODE,param_DT_FIRST_SEEN,param_DT_LAST_SEEN,param_DATA_PROVIDER_ORI,param_VIN,param_PLATE,param_LATITUDE,param_LONGITUDE,param_SEARCH_ADDR1,param_SEARCH_ADDR2,param_CLEAN_COMPANY_NAME,param_MAINNAME,param_FNAME_len,param_MNAME_len,param_FULLNAME,param_FNAME_len,param_MNAME_len);
 
  Process_PS_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 0; // Set bitmap for keys used
    SELF.keys_failed := 0; // Set bitmap for keys failed
    SELF.EID_HASH := le.uid;
    SELF.Weight := le.Weight; // Already rolled up in collate_uber
    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));
  result1 := ROLLUP(result0,LEFT.EID_HASH = RIGHT.EID_HASH,Process_PS_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));
  RETURN result1;
END;
END;
