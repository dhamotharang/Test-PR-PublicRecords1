IMPORT SALT33,ut,std;
EXPORT Key_Classify_PS_ := MODULE
 
//NAME_SUFFIX:FNAME:MNAME:?:LNAME:PRIM_RANGE:+:PRIM_NAME:SEC_RANGE:P_CITY_NAME:ST:ZIP:DOB:PHONE:DL_ST:DL:LEXID:POSSIBLE_SSN:CRIME:NAME_TYPE:CLEAN_GENDER:CLASS_CODE:DT_FIRST_SEEN:DT_LAST_SEEN:DATA_PROVIDER_ORI:VIN:PLATE:LATITUDE:LONGITUDE:SEARCH_ADDR1:SEARCH_ADDR2:MAINNAME:FULLNAME
 
EXPORT KeyName := '~'+KeyPrefix+'::'+'key::Bair_ExternalLinkKeys'+'::'+Config.KeyInfix+'::EID_HASH::Refs';
 
EXPORT KeyName_sf := '~'+KeyPrefix+'::'+'key::Bair_ExternalLinkKeys'+'::'+KeySuperfile+'::EID_HASH::Refs';
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
SHARED h := CandidatesForKey;//The input file - distributed by EID_HASH
SALT33.Layout_Uber_Plus IntoInversion(h le,unsigned2 c) := TRANSFORM
  SELF.word := CHOOSE(c,Fields.Make_NAME_SUFFIX((SALT33.StrType)le.NAME_SUFFIX),Fields.Make_FNAME((SALT33.StrType)le.FNAME),Fields.Make_MNAME((SALT33.StrType)le.MNAME),Fields.Make_LNAME((SALT33.StrType)le.LNAME),Fields.Make_PRIM_RANGE((SALT33.StrType)le.PRIM_RANGE),Fields.Make_PRIM_NAME((SALT33.StrType)le.PRIM_NAME),Fields.Make_SEC_RANGE((SALT33.StrType)le.SEC_RANGE),Fields.Make_P_CITY_NAME((SALT33.StrType)le.P_CITY_NAME),Fields.Make_ST((SALT33.StrType)le.ST),(SALT33.StrType)le.ZIP,(SALT33.StrType)(le.DOB_year*10000+le.DOB_month*100+le.DOB_day),(SALT33.StrType)le.PHONE,Fields.Make_DL_ST((SALT33.StrType)le.DL_ST),Fields.Make_DL((SALT33.StrType)le.DL),Fields.Make_LEXID((SALT33.StrType)le.LEXID),Fields.Make_POSSIBLE_SSN((SALT33.StrType)le.POSSIBLE_SSN),Fields.Make_CRIME((SALT33.StrType)le.CRIME),Fields.Make_NAME_TYPE((SALT33.StrType)le.NAME_TYPE),Fields.Make_CLEAN_GENDER((SALT33.StrType)le.CLEAN_GENDER),Fields.Make_CLASS_CODE((SALT33.StrType)le.CLASS_CODE),Fields.Make_DT_FIRST_SEEN((SALT33.StrType)le.DT_FIRST_SEEN),Fields.Make_DT_LAST_SEEN((SALT33.StrType)le.DT_LAST_SEEN),Fields.Make_DATA_PROVIDER_ORI((SALT33.StrType)le.DATA_PROVIDER_ORI),Fields.Make_VIN((SALT33.StrType)le.VIN),Fields.Make_PLATE((SALT33.StrType)le.PLATE),Fields.Make_LATITUDE((SALT33.StrType)le.LATITUDE),Fields.Make_LONGITUDE((SALT33.StrType)le.LONGITUDE),Fields.Make_SEARCH_ADDR1((SALT33.StrType)le.SEARCH_ADDR1),Fields.Make_SEARCH_ADDR2((SALT33.StrType)le.SEARCH_ADDR2),SKIP,SKIP,SKIP);
  SELF.field := c;
  SELF.uid := le.EID_HASH
END;
nfields_r := SALT33.Fn_Reduce_UBER_Local(NORMALIZE(h,31,IntoInversion(LEFT,COUNTER))(word<>''));
SALT33.MAC_Expand_Normal_Field(h,FNAME,30,EID_HASH,nfields6990);
SALT33.MAC_Expand_Normal_Field(h,MNAME,30,EID_HASH,nfields6991);
SALT33.MAC_Expand_Normal_Field(h,LNAME,30,EID_HASH,nfields6992);
nfields30 := nfields6990+nfields6991+nfields6992;//Collect wordbags for parts of concept field
SALT33.MAC_Expand_Normal_Field(h,FNAME,31,EID_HASH,nfields1682959);
SALT33.MAC_Expand_Normal_Field(h,MNAME,31,EID_HASH,nfields1682960);
SALT33.MAC_Expand_Normal_Field(h,LNAME,31,EID_HASH,nfields1682961);
nfields7223 := nfields1682959+nfields1682960+nfields1682961;//Collect wordbags for parts of concept field
SALT33.MAC_Expand_Normal_Field(h,NAME_SUFFIX,31,EID_HASH,nfields7224);
nfields31 := nfields7223+nfields7224;//Collect wordbags for parts of concept field
invert_records := nfields_r + nfields30;
shared DataForKey0 := SALT33.Fn_Reduce_UBER_Local( invert_records );
 
EXPORT ValueKeyName := '~'+KeyPrefix+'::'+'key::Bair_ExternalLinkKeys'+'::'+Config.KeyInfix+'::EID_HASH::Words';
 
EXPORT ValueKeyName_sf := '~'+KeyPrefix+'::'+'key::Bair_ExternalLinkKeys'+'::'+KeySuperfile+'::EID_HASH::Words';
 
EXPORT AssignCurrentValueKeyToSuperFile := FileServices.AddSuperFile(ValueKeyName_sf,ValueKeyName);
 
EXPORT ClearValueKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(ValueKeyName_sf,,TRUE),FileServices.ClearSuperFile(ValueKeyName_sf));
  r0 := RECORD
    DataForKey0.uid;
    UNSIGNED6 InCluster := COUNT(GROUP);
  END;
  SHARED ClusterSizes := TABLE(DataForKey0,r0,uid,LOCAL);// Set up for Specificity_Local
  SHARED TotalClusters := COUNT(ClusterSizes);
  SALT33.MAC_Specificity_Local(DataForKey0,word,uid,word_nulls,SALT33.Layout_Uber_Nulls,word_specificity,word_switch,word_values);
 
EXPORT ValueKey := INDEX(word_values,{word},{word_values},ValueKeyName);
  SALT33.Layout_Uber_Plus add_id(SALT33.Layout_Uber_Plus le,word_values ri,boolean patch_default) := transform
    SELF.word_id := ri.id;
    SELF := le;
  END;
  SALT33.Mac_Choose_JoinType(DataForKey0,word_nulls,word_values,word,word_weight100,add_id,DataForKey1);
  SALT33.Layout_Uber_Record slim(DataForKey1 le) := TRANSFORM
    self := le;
  end;
  DataForKey2 := sort(project(DataForKey1,slim(left)),whole record,skew(1));
 
EXPORT Key := INDEX(DataForKey2,{DataForKey2},{},KeyName);
 
EXPORT BuildAll := PARALLEL(BUILDINDEX(ValueKey, OVERWRITE),BUILDINDEX(Key, OVERWRITE));
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.NAME_SUFFIX) param_NAME_SUFFIX = (TYPEOF(h.NAME_SUFFIX))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',TYPEOF(h.PRIM_NAME) param_PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',TYPEOF(h.SEC_RANGE) param_SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',TYPEOF(h.P_CITY_NAME) param_P_CITY_NAME = (TYPEOF(h.P_CITY_NAME))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.ZIP) param_ZIP = (TYPEOF(h.ZIP))'',UNSIGNED4 param_DOB,TYPEOF(h.PHONE) param_PHONE = (TYPEOF(h.PHONE))'',TYPEOF(h.DL_ST) param_DL_ST = (TYPEOF(h.DL_ST))'',TYPEOF(h.DL) param_DL = (TYPEOF(h.DL))'',TYPEOF(h.LEXID) param_LEXID = (TYPEOF(h.LEXID))'',TYPEOF(h.POSSIBLE_SSN) param_POSSIBLE_SSN = (TYPEOF(h.POSSIBLE_SSN))'',TYPEOF(h.CRIME) param_CRIME = (TYPEOF(h.CRIME))'',TYPEOF(h.NAME_TYPE) param_NAME_TYPE = (TYPEOF(h.NAME_TYPE))'',TYPEOF(h.CLEAN_GENDER) param_CLEAN_GENDER = (TYPEOF(h.CLEAN_GENDER))'',TYPEOF(h.CLASS_CODE) param_CLASS_CODE = (TYPEOF(h.CLASS_CODE))'',TYPEOF(h.DT_FIRST_SEEN) param_DT_FIRST_SEEN = (TYPEOF(h.DT_FIRST_SEEN))'',TYPEOF(h.DT_LAST_SEEN) param_DT_LAST_SEEN = (TYPEOF(h.DT_LAST_SEEN))'',TYPEOF(h.DATA_PROVIDER_ORI) param_DATA_PROVIDER_ORI = (TYPEOF(h.DATA_PROVIDER_ORI))'',TYPEOF(h.VIN) param_VIN = (TYPEOF(h.VIN))'',TYPEOF(h.PLATE) param_PLATE = (TYPEOF(h.PLATE))'',TYPEOF(h.LATITUDE) param_LATITUDE = (TYPEOF(h.LATITUDE))'',TYPEOF(h.LONGITUDE) param_LONGITUDE = (TYPEOF(h.LONGITUDE))'',TYPEOF(h.SEARCH_ADDR1) param_SEARCH_ADDR1 = (TYPEOF(h.SEARCH_ADDR1))'',TYPEOF(h.SEARCH_ADDR2) param_SEARCH_ADDR2 = (TYPEOF(h.SEARCH_ADDR2))'',SALT33.StrType param_MAINNAME,SALT33.StrType param_FULLNAME) := 
  FUNCTION
 //Create wordstream from parameters
    SALT33.MAC_Field_To_UberStream(param_NAME_SUFFIX,1,ValueKey,WS1);
    SALT33.MAC_Field_To_UberStream(param_FNAME,2,ValueKey,WS2);
    SALT33.MAC_Field_To_UberStream(param_MNAME,3,ValueKey,WS3);
    SALT33.MAC_Field_To_UberStream(param_LNAME,4,ValueKey,WS4);
    SALT33.MAC_Field_To_UberStream(param_PRIM_RANGE,5,ValueKey,WS5);
    SALT33.MAC_Field_To_UberStream(param_PRIM_NAME,6,ValueKey,WS6);
    SALT33.MAC_Field_To_UberStream(param_SEC_RANGE,7,ValueKey,WS7);
    SALT33.MAC_Field_To_UberStream(param_P_CITY_NAME,8,ValueKey,WS8);
    SALT33.MAC_Field_To_UberStream(param_ST,9,ValueKey,WS9);
    SALT33.MAC_Field_To_UberStream(param_ZIP,10,ValueKey,WS10);
    SALT33.MAC_Field_To_UberStream(param_DOB,11,ValueKey,WS11);
    SALT33.MAC_Field_To_UberStream(param_PHONE,12,ValueKey,WS12);
    SALT33.MAC_Field_To_UberStream(param_DL_ST,13,ValueKey,WS13);
    SALT33.MAC_Field_To_UberStream(param_DL,14,ValueKey,WS14);
    SALT33.MAC_Field_To_UberStream(param_LEXID,15,ValueKey,WS15);
    SALT33.MAC_Field_To_UberStream(param_POSSIBLE_SSN,16,ValueKey,WS16);
    SALT33.MAC_Field_To_UberStream(param_CRIME,17,ValueKey,WS17);
    SALT33.MAC_Field_To_UberStream(param_NAME_TYPE,18,ValueKey,WS18);
    SALT33.MAC_Field_To_UberStream(param_CLEAN_GENDER,19,ValueKey,WS19);
    SALT33.MAC_Field_To_UberStream(param_CLASS_CODE,20,ValueKey,WS20);
    SALT33.MAC_Field_To_UberStream(param_DT_FIRST_SEEN,21,ValueKey,WS21);
    SALT33.MAC_Field_To_UberStream(param_DT_LAST_SEEN,22,ValueKey,WS22);
    SALT33.MAC_Field_To_UberStream(param_DATA_PROVIDER_ORI,23,ValueKey,WS23);
    SALT33.MAC_Field_To_UberStream(param_VIN,24,ValueKey,WS24);
    SALT33.MAC_Field_To_UberStream(param_PLATE,25,ValueKey,WS25);
    SALT33.MAC_Field_To_UberStream(param_LATITUDE,26,ValueKey,WS26);
    SALT33.MAC_Field_To_UberStream(param_LONGITUDE,27,ValueKey,WS27);
    SALT33.MAC_Field_To_UberStream(param_SEARCH_ADDR1,28,ValueKey,WS28);
    SALT33.MAC_Field_To_UberStream(param_SEARCH_ADDR2,29,ValueKey,WS29);
    SALT33.MAC_Field_To_UberStream(param_MAINNAME,30,ValueKey,WS30);
    SALT33.MAC_Field_To_UberStream(param_FULLNAME,31,ValueKey,WS31);
    wds := WS1+WS2+WS3+WS4+WS5+WS6+WS7+WS8+WS9+WS10+WS11+WS12+WS13+WS14+WS15+WS16+WS17+WS18+WS19+WS20+WS21+WS22+WS23+WS24+WS25+WS26+WS27+WS28+WS29+WS30+WS31;
    SALT33.MAC_Collate_Uber_Matches(Key,Wds,steppedmatches);
    RETURN steppedmatches;
  END;
 
EXPORT ScoredEID_HASHFetch(TYPEOF(h.NAME_SUFFIX) param_NAME_SUFFIX = (TYPEOF(h.NAME_SUFFIX))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',TYPEOF(h.PRIM_NAME) param_PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',TYPEOF(h.SEC_RANGE) param_SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',TYPEOF(h.P_CITY_NAME) param_P_CITY_NAME = (TYPEOF(h.P_CITY_NAME))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.ZIP) param_ZIP = (TYPEOF(h.ZIP))'',UNSIGNED4 param_DOB,TYPEOF(h.PHONE) param_PHONE = (TYPEOF(h.PHONE))'',TYPEOF(h.DL_ST) param_DL_ST = (TYPEOF(h.DL_ST))'',TYPEOF(h.DL) param_DL = (TYPEOF(h.DL))'',TYPEOF(h.LEXID) param_LEXID = (TYPEOF(h.LEXID))'',TYPEOF(h.POSSIBLE_SSN) param_POSSIBLE_SSN = (TYPEOF(h.POSSIBLE_SSN))'',TYPEOF(h.CRIME) param_CRIME = (TYPEOF(h.CRIME))'',TYPEOF(h.NAME_TYPE) param_NAME_TYPE = (TYPEOF(h.NAME_TYPE))'',TYPEOF(h.CLEAN_GENDER) param_CLEAN_GENDER = (TYPEOF(h.CLEAN_GENDER))'',TYPEOF(h.CLASS_CODE) param_CLASS_CODE = (TYPEOF(h.CLASS_CODE))'',TYPEOF(h.DT_FIRST_SEEN) param_DT_FIRST_SEEN = (TYPEOF(h.DT_FIRST_SEEN))'',TYPEOF(h.DT_LAST_SEEN) param_DT_LAST_SEEN = (TYPEOF(h.DT_LAST_SEEN))'',TYPEOF(h.DATA_PROVIDER_ORI) param_DATA_PROVIDER_ORI = (TYPEOF(h.DATA_PROVIDER_ORI))'',TYPEOF(h.VIN) param_VIN = (TYPEOF(h.VIN))'',TYPEOF(h.PLATE) param_PLATE = (TYPEOF(h.PLATE))'',TYPEOF(h.LATITUDE) param_LATITUDE = (TYPEOF(h.LATITUDE))'',TYPEOF(h.LONGITUDE) param_LONGITUDE = (TYPEOF(h.LONGITUDE))'',TYPEOF(h.SEARCH_ADDR1) param_SEARCH_ADDR1 = (TYPEOF(h.SEARCH_ADDR1))'',TYPEOF(h.SEARCH_ADDR2) param_SEARCH_ADDR2 = (TYPEOF(h.SEARCH_ADDR2))'',SALT33.StrType param_MAINNAME,SALT33.StrType param_FULLNAME) := FUNCTION
  RawData := RawFetch(param_NAME_SUFFIX,param_FNAME,param_MNAME,param_LNAME,param_PRIM_RANGE,param_PRIM_NAME,param_SEC_RANGE,param_P_CITY_NAME,param_ST,param_ZIP,param_DOB,param_PHONE,param_DL_ST,param_DL,param_LEXID,param_POSSIBLE_SSN,param_CRIME,param_NAME_TYPE,param_CLEAN_GENDER,param_CLASS_CODE,param_DT_FIRST_SEEN,param_DT_LAST_SEEN,param_DATA_PROVIDER_ORI,param_VIN,param_PLATE,param_LATITUDE,param_LONGITUDE,param_SEARCH_ADDR1,param_SEARCH_ADDR2,param_MAINNAME,param_FULLNAME);
 
  Process_PS_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 0; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key used
    SELF.EID_HASH := le.uid;
    SELF.Weight := le.Weight; // Already rolled up in collate_uber
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(PROJECT(NOFOLD(RawData),Score(LEFT)),Process_PS_Layouts.update_forcefailed(LEFT)),LEFT.EID_HASH = RIGHT.EID_HASH,Process_PS_Layouts.combine_scores(LEFT,RIGHT));
END;
END;
