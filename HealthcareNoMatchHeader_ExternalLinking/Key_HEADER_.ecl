IMPORT SALT311,std,HealthcareNoMatchHeader_InternalLinking,HealthcareNoMatchHeader_Ingest;
EXPORT Key_HEADER_(
    STRING	pSrc        = ''
    , STRING  pVersion  = (STRING)STD.Date.Today()
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pInfile = HealthcareNoMatchHeader_Ingest.Files(pSrc).AllRecords
  ) := MODULE
 
//SRC:SSN:DOB:LEXID:?:SUFFIX:+:FNAME:MNAME:LNAME:GENDER:PRIM_NAME:PRIM_RANGE:SEC_RANGE:CITY_NAME:ST:ZIP:DT_FIRST_SEEN:DT_LAST_SEEN:MAINNAME:ADDR1:LOCALE:ADDRESS:FULLNAME
EXPORT KeyName := HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).ExternalKeys.Refs.New;
SHARED h := CandidatesForKey(pSrc,pVersion,pInfile);//The input file - distributed by nomatch_id
 
SHARED s := HealthcareNoMatchHeader_InternalLinking.Specificities(pSrc,pVersion,pInfile).Specificities[1];
SHARED s_index := Keys(pSrc,pVersion,pInfile).Specificities_Key[1]; // Index access for MEOW queries
SHARED specMod := HealthcareNoMatchHeader_InternalLinking.Specificities(pSrc,pVersion,pInfile);
EXPORT Layout_Uber_Record := RECORD(SALT311.Layout_Uber_Record0)
END;
EXPORT Layout_Uber_Plus := RECORD(Layout_Uber_Record)
  SALT311.Str30Type word;
  UNSIGNED2 word_weight100 := 0;
END;
SHARED Fn_Reduce_Uber_Local(DATASET(Layout_Uber_Plus) in_ds) := FUNCTION
// The file need NOT be distributed at this point; it will still reduce the record count ...
  RETURN DEDUP(SORT(in_ds,uid,word,field,LOCAL),uid,word,field,LOCAL);
END;
Layout_Uber_Plus IntoInversion(h le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,Fields.Make_SRC((SALT311.StrType)le.SRC),Fields.Make_SSN((SALT311.StrType)le.SSN),(SALT311.StrType)(le.DOB_year*10000+le.DOB_month*100+le.DOB_day),Fields.Make_LEXID((SALT311.StrType)le.LEXID),Fields.Make_SUFFIX((SALT311.StrType)le.SUFFIX),Fields.Make_FNAME((SALT311.StrType)le.FNAME),Fields.Make_MNAME((SALT311.StrType)le.MNAME),Fields.Make_LNAME((SALT311.StrType)le.LNAME),Fields.Make_GENDER((SALT311.StrType)le.GENDER),Fields.Make_PRIM_NAME((SALT311.StrType)le.PRIM_NAME),Fields.Make_PRIM_RANGE((SALT311.StrType)le.PRIM_RANGE),Fields.Make_SEC_RANGE((SALT311.StrType)le.SEC_RANGE),Fields.Make_CITY_NAME((SALT311.StrType)le.CITY_NAME),Fields.Make_ST((SALT311.StrType)le.ST),Fields.Make_ZIP((SALT311.StrType)le.ZIP),'','',SKIP,SKIP,SKIP,SKIP,SKIP,SKIP);
  SELF.field := c;
  SELF.uid := le.nomatch_id;
  SELF := le;
END;
nfields_r := Fn_Reduce_UBER_Local(NORMALIZE(h,22,IntoInversion(LEFT,COUNTER))(word<>''));
SALT311.MAC_Expand_Normal_Field(h,FNAME,18,nomatch_id,layout_uber_plus,nfields4194);
SALT311.MAC_Expand_Normal_Field(h,MNAME,18,nomatch_id,layout_uber_plus,nfields4195);
SALT311.MAC_Expand_Normal_Field(h,LNAME,18,nomatch_id,layout_uber_plus,nfields4196);
nfields18 := nfields4194+nfields4195+nfields4196;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(h,PRIM_RANGE,19,nomatch_id,layout_uber_plus,nfields4427);
SALT311.MAC_Expand_Normal_Field(h,SEC_RANGE,19,nomatch_id,layout_uber_plus,nfields4428);
SALT311.MAC_Expand_Normal_Field(h,PRIM_NAME,19,nomatch_id,layout_uber_plus,nfields4429);
nfields19 := nfields4427+nfields4428+nfields4429;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(h,CITY_NAME,20,nomatch_id,layout_uber_plus,nfields4660);
SALT311.MAC_Expand_Normal_Field(h,ST,20,nomatch_id,layout_uber_plus,nfields4661);
SALT311.MAC_Expand_Normal_Field(h,ZIP,20,nomatch_id,layout_uber_plus,nfields4662);
nfields20 := nfields4660+nfields4661+nfields4662;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(h,PRIM_RANGE,21,nomatch_id,layout_uber_plus,nfields1140069);
SALT311.MAC_Expand_Normal_Field(h,SEC_RANGE,21,nomatch_id,layout_uber_plus,nfields1140070);
SALT311.MAC_Expand_Normal_Field(h,PRIM_NAME,21,nomatch_id,layout_uber_plus,nfields1140071);
nfields4893 := nfields1140069+nfields1140070+nfields1140071;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(h,CITY_NAME,21,nomatch_id,layout_uber_plus,nfields1140302);
SALT311.MAC_Expand_Normal_Field(h,ST,21,nomatch_id,layout_uber_plus,nfields1140303);
SALT311.MAC_Expand_Normal_Field(h,ZIP,21,nomatch_id,layout_uber_plus,nfields1140304);
nfields4894 := nfields1140302+nfields1140303+nfields1140304;//Collect wordbags for parts of concept field
nfields21 := nfields4893+nfields4894;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(h,FNAME,22,nomatch_id,layout_uber_plus,nfields1194358);
SALT311.MAC_Expand_Normal_Field(h,MNAME,22,nomatch_id,layout_uber_plus,nfields1194359);
SALT311.MAC_Expand_Normal_Field(h,LNAME,22,nomatch_id,layout_uber_plus,nfields1194360);
nfields5126 := nfields1194358+nfields1194359+nfields1194360;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(h,SUFFIX,22,nomatch_id,layout_uber_plus,nfields5127);
nfields22 := nfields5126+nfields5127;//Collect wordbags for parts of concept field
SHARED invert_records := nfields_r + nfields18;
SHARED DataForKey0 := Fn_Reduce_UBER_Local( invert_records );
SHARED DataForValueKey0 := DEDUP(SORT(DISTRIBUTE(TABLE(invert_records,{word}),HASH(word)),word,LOCAL),word,LOCAL);
 
EXPORT ValueKeyName := HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).ExternalKeys.Words.New;
SHARED word_values := specMod.uber_values_persisted;
 
EXPORT ValueKey := INDEX(word_values,{word},{word_values},ValueKeyName,OPT);
  Layout_Uber_Plus add_id(Layout_Uber_Plus le,word_values ri,BOOLEAN patch_default) := TRANSFORM
    SELF.word_id := ri.id;
    SELF := le;
  END;
  SALT311.Mac_Choose_JoinType(DataForKey0,s.nulls_uber,word_values,word,word_weight100,add_id,DataForKey1);
  DataForKey2 := Fn_Reduce_UBER_Local( DataForKey1 );
  Layout_Uber_record slim(DataForKey2 le) := TRANSFORM
    SELF := le;
  END;
  SHARED DataForKey3 := DEDUP(SORT(PROJECT(DataForKey2,slim(LEFT)),WHOLE RECORD,SKEW(1)),WHOLE RECORD);
 
EXPORT Key := INDEX(DataForKey3,{DataForKey3},{},KeyName);
 
EXPORT BuildAll := PARALLEL(BUILDINDEX(ValueKey, OVERWRITE),BUILDINDEX(Key, OVERWRITE));
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.SRC) param_SRC = (TYPEOF(h.SRC))'',TYPEOF(h.SSN) param_SSN = (TYPEOF(h.SSN))'',TYPEOF(h.SSN_len) param_SSN_len = (TYPEOF(h.SSN_len))'',UNSIGNED4 param_DOB,TYPEOF(h.LEXID) param_LEXID = (TYPEOF(h.LEXID))'',TYPEOF(h.SUFFIX) param_SUFFIX = (TYPEOF(h.SUFFIX))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',TYPEOF(h.GENDER) param_GENDER = (TYPEOF(h.GENDER))'',TYPEOF(h.PRIM_NAME) param_PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',TYPEOF(h.SEC_RANGE) param_SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',TYPEOF(h.CITY_NAME) param_CITY_NAME = (TYPEOF(h.CITY_NAME))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.ZIP) param_ZIP = (TYPEOF(h.ZIP))'',SALT311.StrType param_MAINNAME,SALT311.StrType param_ADDR1,SALT311.StrType param_LOCALE,SALT311.StrType param_ADDRESS,SALT311.StrType param_FULLNAME) := 
  FUNCTION
 //Create wordstream from parameters
    SALT311.MAC_Field_To_UberStream(param_SRC,1,ValueKey,WS1);
    SALT311.MAC_Field_To_UberStream(param_SSN,2,ValueKey,WS2);
    SALT311.MAC_Field_To_UberStream(param_DOB,3,ValueKey,WS3);
    SALT311.MAC_Field_To_UberStream(param_LEXID,4,ValueKey,WS4);
    SALT311.MAC_Field_To_UberStream(param_SUFFIX,5,ValueKey,WS5);
    SALT311.MAC_Field_To_UberStream(param_FNAME,6,ValueKey,WS6);
    SALT311.MAC_Field_To_UberStream(param_MNAME,7,ValueKey,WS7);
    SALT311.MAC_Field_To_UberStream(param_LNAME,8,ValueKey,WS8);
    SALT311.MAC_Field_To_UberStream(param_GENDER,9,ValueKey,WS9);
    SALT311.MAC_Field_To_UberStream(param_PRIM_NAME,10,ValueKey,WS10);
    SALT311.MAC_Field_To_UberStream(param_PRIM_RANGE,11,ValueKey,WS11);
    SALT311.MAC_Field_To_UberStream(param_SEC_RANGE,12,ValueKey,WS12);
    SALT311.MAC_Field_To_UberStream(param_CITY_NAME,13,ValueKey,WS13);
    SALT311.MAC_Field_To_UberStream(param_ST,14,ValueKey,WS14);
    SALT311.MAC_Field_To_UberStream(param_ZIP,15,ValueKey,WS15);
    SALT311.MAC_Field_To_UberStream(param_MAINNAME,18,ValueKey,WS18);
    SALT311.MAC_Field_To_UberStream(param_ADDR1,19,ValueKey,WS19);
    SALT311.MAC_Field_To_UberStream(param_LOCALE,20,ValueKey,WS20);
    SALT311.MAC_Field_To_UberStream(param_ADDRESS,21,ValueKey,WS21);
    SALT311.MAC_Field_To_UberStream(param_FULLNAME,22,ValueKey,WS22);
    wds := WS1+WS2+WS3+WS4+WS5+WS6+WS7+WS8+WS9+WS10+WS11+WS12+WS13+WS14+WS15+WS18+WS19+WS20+WS21+WS22;
    SALT311.MAC_Collate_Uber_Matches(Key,Wds,steppedmatches,Layout_Uber_Record,,,,,,,,);
    RETURN steppedmatches;
  END;
 
EXPORT Scorednomatch_idFetch(TYPEOF(h.SRC) param_SRC = (TYPEOF(h.SRC))'',TYPEOF(h.SSN) param_SSN = (TYPEOF(h.SSN))'',TYPEOF(h.SSN_len) param_SSN_len = (TYPEOF(h.SSN_len))'',UNSIGNED4 param_DOB,TYPEOF(h.LEXID) param_LEXID = (TYPEOF(h.LEXID))'',TYPEOF(h.SUFFIX) param_SUFFIX = (TYPEOF(h.SUFFIX))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',TYPEOF(h.GENDER) param_GENDER = (TYPEOF(h.GENDER))'',TYPEOF(h.PRIM_NAME) param_PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',TYPEOF(h.SEC_RANGE) param_SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',TYPEOF(h.CITY_NAME) param_CITY_NAME = (TYPEOF(h.CITY_NAME))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.ZIP) param_ZIP = (TYPEOF(h.ZIP))'',SALT311.StrType param_MAINNAME,SALT311.StrType param_ADDR1,SALT311.StrType param_LOCALE,SALT311.StrType param_ADDRESS,SALT311.StrType param_FULLNAME,BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetch(param_SRC,param_SSN,param_SSN_len,param_DOB,param_LEXID,param_SUFFIX,param_FNAME,param_FNAME_len,param_MNAME,param_MNAME_len,param_LNAME,param_LNAME_len,param_GENDER,param_PRIM_NAME,param_PRIM_RANGE,param_SEC_RANGE,param_CITY_NAME,param_ST,param_ZIP,param_MAINNAME,param_ADDR1,param_LOCALE,param_ADDRESS,param_FULLNAME);
 
  Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 0; // Set bitmap for keys used
    SELF.keys_failed := 0; // Set bitmap for keys failed
    SELF.nomatch_id := le.uid;
    SELF.Weight := le.Weight; // Already rolled up in collate_uber
    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));
  result1 := ROLLUP(result0,LEFT.nomatch_id = RIGHT.nomatch_id,Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).combine_scores(LEFT,RIGHT,param_disableForce));
  RETURN result1;
END;
END;
