IMPORT SALT311,std;
EXPORT Key_HealthProvider_ := MODULE
 
//FNAME:MNAME:?:LNAME:SNAME:+:GENDER:PRIM_RANGE:PRIM_NAME:SEC_RANGE:V_CITY_NAME:ST:ZIP:SSN:CNSMR_SSN:DOB:CNSMR_DOB:PHONE:LIC_STATE:C_LIC_NBR:TAX_ID:BILLING_TAX_ID:DEA_NUMBER:VENDOR_ID:NPI_NUMBER:BILLING_NPI_NUMBER:UPIN:DID:BDID:SRC:SOURCE_RID:RID:MAINNAME:FULLNAME:ADDR1:LOCALE:ADDRESS
EXPORT KeyName := Health_Provider_Services.Files.FILE_Header_Refs_SF; //'~'+'key::Health_Provider_Services::LNPID::Refs';
SHARED h := CandidatesForKey;//The input file - distributed by LNPID
 
SHARED s := Specificities(File_HealthProvider).Specificities[1];
SHARED s_index := Keys(File_HealthProvider).Specificities_Key[1]; // Index access for MEOW queries
SHARED specMod := Specificities(File_HealthProvider);
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
  SELF.word := CHOOSE(c,Fields.Make_FNAME((SALT311.StrType)le.FNAME),Fields.Make_MNAME((SALT311.StrType)le.MNAME),Fields.Make_LNAME((SALT311.StrType)le.LNAME),Fields.Make_SNAME((SALT311.StrType)le.SNAME),Fields.Make_GENDER((SALT311.StrType)le.GENDER),Fields.Make_PRIM_RANGE((SALT311.StrType)le.PRIM_RANGE),Fields.Make_PRIM_NAME((SALT311.StrType)le.PRIM_NAME),Fields.Make_SEC_RANGE((SALT311.StrType)le.SEC_RANGE),Fields.Make_V_CITY_NAME((SALT311.StrType)le.V_CITY_NAME),Fields.Make_ST((SALT311.StrType)le.ST),Fields.Make_ZIP((SALT311.StrType)le.ZIP),Fields.Make_SSN((SALT311.StrType)le.SSN),Fields.Make_CNSMR_SSN((SALT311.StrType)le.CNSMR_SSN),(SALT311.StrType)(le.DOB_year*10000+le.DOB_month*100+le.DOB_day),(SALT311.StrType)(le.CNSMR_DOB_year*10000+le.CNSMR_DOB_month*100+le.CNSMR_DOB_day),Fields.Make_PHONE((SALT311.StrType)le.PHONE),Fields.Make_LIC_STATE((SALT311.StrType)le.LIC_STATE),Fields.Make_C_LIC_NBR((SALT311.StrType)le.C_LIC_NBR),Fields.Make_TAX_ID((SALT311.StrType)le.TAX_ID),Fields.Make_BILLING_TAX_ID((SALT311.StrType)le.BILLING_TAX_ID),Fields.Make_DEA_NUMBER((SALT311.StrType)le.DEA_NUMBER),Fields.Make_VENDOR_ID((SALT311.StrType)le.VENDOR_ID),Fields.Make_NPI_NUMBER((SALT311.StrType)le.NPI_NUMBER),Fields.Make_BILLING_NPI_NUMBER((SALT311.StrType)le.BILLING_NPI_NUMBER),Fields.Make_UPIN((SALT311.StrType)le.UPIN),Fields.Make_DID((SALT311.StrType)le.DID),Fields.Make_BDID((SALT311.StrType)le.BDID),Fields.Make_SRC((SALT311.StrType)le.SRC),Fields.Make_SOURCE_RID((SALT311.StrType)le.SOURCE_RID),Fields.Make_RID((SALT311.StrType)le.RID),SKIP,SKIP,SKIP,SKIP,SKIP,SKIP);
  SELF.field := c;
  SELF.uid := le.LNPID;
  SELF := le;
END;
nfields_r := Fn_Reduce_UBER_Local(NORMALIZE(h,35,IntoInversion(LEFT,COUNTER))(word<>''));
SALT311.MAC_Expand_Normal_Field(h,FNAME,31,LNPID,layout_uber_plus,nfields7223);
SALT311.MAC_Expand_Normal_Field(h,MNAME,31,LNPID,layout_uber_plus,nfields7224);
SALT311.MAC_Expand_Normal_Field(h,LNAME,31,LNPID,layout_uber_plus,nfields7225);
nfields31 := nfields7223+nfields7224+nfields7225;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(h,FNAME,32,LNPID,layout_uber_plus,nfields1737248);
SALT311.MAC_Expand_Normal_Field(h,MNAME,32,LNPID,layout_uber_plus,nfields1737249);
SALT311.MAC_Expand_Normal_Field(h,LNAME,32,LNPID,layout_uber_plus,nfields1737250);
nfields7456 := nfields1737248+nfields1737249+nfields1737250;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(h,SNAME,32,LNPID,layout_uber_plus,nfields7457);
nfields32 := nfields7456+nfields7457;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(h,PRIM_NAME,33,LNPID,layout_uber_plus,nfields7689);
SALT311.MAC_Expand_Normal_Field(h,PRIM_RANGE,33,LNPID,layout_uber_plus,nfields7690);
SALT311.MAC_Expand_Normal_Field(h,SEC_RANGE,33,LNPID,layout_uber_plus,nfields7691);
nfields33 := nfields7689+nfields7690+nfields7691;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(h,V_CITY_NAME,34,LNPID,layout_uber_plus,nfields7922);
SALT311.MAC_Expand_Normal_Field(h,ST,34,LNPID,layout_uber_plus,nfields7923);
SALT311.MAC_Expand_Normal_Field(h,ZIP,34,LNPID,layout_uber_plus,nfields7924);
nfields34 := nfields7922+nfields7923+nfields7924;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(h,PRIM_NAME,35,LNPID,layout_uber_plus,nfields1900115);
SALT311.MAC_Expand_Normal_Field(h,PRIM_RANGE,35,LNPID,layout_uber_plus,nfields1900116);
SALT311.MAC_Expand_Normal_Field(h,SEC_RANGE,35,LNPID,layout_uber_plus,nfields1900117);
nfields8155 := nfields1900115+nfields1900116+nfields1900117;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(h,V_CITY_NAME,35,LNPID,layout_uber_plus,nfields1900348);
SALT311.MAC_Expand_Normal_Field(h,ST,35,LNPID,layout_uber_plus,nfields1900349);
SALT311.MAC_Expand_Normal_Field(h,ZIP,35,LNPID,layout_uber_plus,nfields1900350);
nfields8156 := nfields1900348+nfields1900349+nfields1900350;//Collect wordbags for parts of concept field
nfields35 := nfields8155+nfields8156;//Collect wordbags for parts of concept field
SHARED invert_records := nfields_r + nfields31;
SHARED DataForKey0 := Fn_Reduce_UBER_Local( invert_records );
SHARED DataForValueKey0 := DEDUP(SORT(DISTRIBUTE(TABLE(invert_records,{word}),HASH(word)),word,LOCAL),word,LOCAL);
 
EXPORT ValueKeyName := Health_Provider_Services.Files.FILE_Header_Words_SF; //'~'+'key::Health_Provider_Services::LNPID::Words';
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
 
EXPORT RawFetch(TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',TYPEOF(h.SNAME) param_SNAME = (TYPEOF(h.SNAME))'',TYPEOF(h.GENDER) param_GENDER = (TYPEOF(h.GENDER))'',TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',TYPEOF(h.PRIM_NAME) param_PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',TYPEOF(h.SEC_RANGE) param_SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',TYPEOF(h.V_CITY_NAME) param_V_CITY_NAME = (TYPEOF(h.V_CITY_NAME))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.ZIP) param_ZIP = (TYPEOF(h.ZIP))'',TYPEOF(h.SSN) param_SSN = (TYPEOF(h.SSN))'',TYPEOF(h.SSN_len) param_SSN_len = (TYPEOF(h.SSN_len))'',TYPEOF(h.CNSMR_SSN) param_CNSMR_SSN = (TYPEOF(h.CNSMR_SSN))'',TYPEOF(h.CNSMR_SSN_len) param_CNSMR_SSN_len = (TYPEOF(h.CNSMR_SSN_len))'',UNSIGNED4 param_DOB,UNSIGNED4 param_CNSMR_DOB,TYPEOF(h.PHONE) param_PHONE = (TYPEOF(h.PHONE))'',TYPEOF(h.LIC_STATE) param_LIC_STATE = (TYPEOF(h.LIC_STATE))'',TYPEOF(h.C_LIC_NBR) param_C_LIC_NBR = (TYPEOF(h.C_LIC_NBR))'',TYPEOF(h.C_LIC_NBR_len) param_C_LIC_NBR_len = (TYPEOF(h.C_LIC_NBR_len))'',TYPEOF(h.TAX_ID) param_TAX_ID = (TYPEOF(h.TAX_ID))'',TYPEOF(h.BILLING_TAX_ID) param_BILLING_TAX_ID = (TYPEOF(h.BILLING_TAX_ID))'',TYPEOF(h.DEA_NUMBER) param_DEA_NUMBER = (TYPEOF(h.DEA_NUMBER))'',TYPEOF(h.VENDOR_ID) param_VENDOR_ID = (TYPEOF(h.VENDOR_ID))'',TYPEOF(h.NPI_NUMBER) param_NPI_NUMBER = (TYPEOF(h.NPI_NUMBER))'',TYPEOF(h.BILLING_NPI_NUMBER) param_BILLING_NPI_NUMBER = (TYPEOF(h.BILLING_NPI_NUMBER))'',TYPEOF(h.UPIN) param_UPIN = (TYPEOF(h.UPIN))'',TYPEOF(h.DID) param_DID = (TYPEOF(h.DID))'',TYPEOF(h.BDID) param_BDID = (TYPEOF(h.BDID))'',TYPEOF(h.SRC) param_SRC = (TYPEOF(h.SRC))'',TYPEOF(h.SOURCE_RID) param_SOURCE_RID = (TYPEOF(h.SOURCE_RID))'',TYPEOF(h.RID) param_RID = (TYPEOF(h.RID))'',SALT311.StrType param_MAINNAME,SALT311.StrType param_FULLNAME,SALT311.StrType param_ADDR1,SALT311.StrType param_LOCALE,SALT311.StrType param_ADDRESS) := 
  FUNCTION
 //Create wordstream from parameters
    SALT311.MAC_Field_To_UberStream(param_FNAME,1,ValueKey,WS1);
    SALT311.MAC_Field_To_UberStream(param_MNAME,2,ValueKey,WS2);
    SALT311.MAC_Field_To_UberStream(param_LNAME,3,ValueKey,WS3);
    SALT311.MAC_Field_To_UberStream(param_SNAME,4,ValueKey,WS4);
    SALT311.MAC_Field_To_UberStream(param_GENDER,5,ValueKey,WS5);
    SALT311.MAC_Field_To_UberStream(param_PRIM_RANGE,6,ValueKey,WS6);
    SALT311.MAC_Field_To_UberStream(param_PRIM_NAME,7,ValueKey,WS7);
    SALT311.MAC_Field_To_UberStream(param_SEC_RANGE,8,ValueKey,WS8);
    SALT311.MAC_Field_To_UberStream(param_V_CITY_NAME,9,ValueKey,WS9);
    SALT311.MAC_Field_To_UberStream(param_ST,10,ValueKey,WS10);
    SALT311.MAC_Field_To_UberStream(param_ZIP,11,ValueKey,WS11);
    SALT311.MAC_Field_To_UberStream(param_SSN,12,ValueKey,WS12);
    SALT311.MAC_Field_To_UberStream(param_CNSMR_SSN,13,ValueKey,WS13);
    SALT311.MAC_Field_To_UberStream(param_DOB,14,ValueKey,WS14);
    SALT311.MAC_Field_To_UberStream(param_CNSMR_DOB,15,ValueKey,WS15);
    SALT311.MAC_Field_To_UberStream(param_PHONE,16,ValueKey,WS16);
    SALT311.MAC_Field_To_UberStream(param_LIC_STATE,17,ValueKey,WS17);
    SALT311.MAC_Field_To_UberStream(param_C_LIC_NBR,18,ValueKey,WS18);
    SALT311.MAC_Field_To_UberStream(param_TAX_ID,19,ValueKey,WS19);
    SALT311.MAC_Field_To_UberStream(param_BILLING_TAX_ID,20,ValueKey,WS20);
    SALT311.MAC_Field_To_UberStream(param_DEA_NUMBER,21,ValueKey,WS21);
    SALT311.MAC_Field_To_UberStream(param_VENDOR_ID,22,ValueKey,WS22);
    SALT311.MAC_Field_To_UberStream(param_NPI_NUMBER,23,ValueKey,WS23);
    SALT311.MAC_Field_To_UberStream(param_BILLING_NPI_NUMBER,24,ValueKey,WS24);
    SALT311.MAC_Field_To_UberStream(param_UPIN,25,ValueKey,WS25);
    SALT311.MAC_Field_To_UberStream(param_DID,26,ValueKey,WS26);
    SALT311.MAC_Field_To_UberStream(param_BDID,27,ValueKey,WS27);
    SALT311.MAC_Field_To_UberStream(param_SRC,28,ValueKey,WS28);
    SALT311.MAC_Field_To_UberStream(param_SOURCE_RID,29,ValueKey,WS29);
    SALT311.MAC_Field_To_UberStream(param_RID,30,ValueKey,WS30);
    SALT311.MAC_Field_To_UberStream(param_MAINNAME,31,ValueKey,WS31);
    SALT311.MAC_Field_To_UberStream(param_FULLNAME,32,ValueKey,WS32);
    SALT311.MAC_Field_To_UberStream(param_ADDR1,33,ValueKey,WS33);
    SALT311.MAC_Field_To_UberStream(param_LOCALE,34,ValueKey,WS34);
    SALT311.MAC_Field_To_UberStream(param_ADDRESS,35,ValueKey,WS35);
    wds := WS1+WS2+WS3+WS4+WS5+WS6+WS7+WS8+WS9+WS10+WS11+WS12+WS13+WS14+WS15+WS16+WS17+WS18+WS19+WS20+WS21+WS22+WS23+WS24+WS25+WS26+WS27+WS28+WS29+WS30+WS31+WS32+WS33+WS34+WS35;
    SALT311.MAC_Collate_Uber_Matches(Key,Wds,steppedmatches,Layout_Uber_Record,,,,,,,,);
    RETURN steppedmatches;
  END;
 
EXPORT ScoredLNPIDFetch(TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',TYPEOF(h.SNAME) param_SNAME = (TYPEOF(h.SNAME))'',TYPEOF(h.GENDER) param_GENDER = (TYPEOF(h.GENDER))'',TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',TYPEOF(h.PRIM_NAME) param_PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',TYPEOF(h.SEC_RANGE) param_SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',TYPEOF(h.V_CITY_NAME) param_V_CITY_NAME = (TYPEOF(h.V_CITY_NAME))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.ZIP) param_ZIP = (TYPEOF(h.ZIP))'',TYPEOF(h.SSN) param_SSN = (TYPEOF(h.SSN))'',TYPEOF(h.SSN_len) param_SSN_len = (TYPEOF(h.SSN_len))'',TYPEOF(h.CNSMR_SSN) param_CNSMR_SSN = (TYPEOF(h.CNSMR_SSN))'',TYPEOF(h.CNSMR_SSN_len) param_CNSMR_SSN_len = (TYPEOF(h.CNSMR_SSN_len))'',UNSIGNED4 param_DOB,UNSIGNED4 param_CNSMR_DOB,TYPEOF(h.PHONE) param_PHONE = (TYPEOF(h.PHONE))'',TYPEOF(h.LIC_STATE) param_LIC_STATE = (TYPEOF(h.LIC_STATE))'',TYPEOF(h.C_LIC_NBR) param_C_LIC_NBR = (TYPEOF(h.C_LIC_NBR))'',TYPEOF(h.C_LIC_NBR_len) param_C_LIC_NBR_len = (TYPEOF(h.C_LIC_NBR_len))'',TYPEOF(h.TAX_ID) param_TAX_ID = (TYPEOF(h.TAX_ID))'',TYPEOF(h.BILLING_TAX_ID) param_BILLING_TAX_ID = (TYPEOF(h.BILLING_TAX_ID))'',TYPEOF(h.DEA_NUMBER) param_DEA_NUMBER = (TYPEOF(h.DEA_NUMBER))'',TYPEOF(h.VENDOR_ID) param_VENDOR_ID = (TYPEOF(h.VENDOR_ID))'',TYPEOF(h.NPI_NUMBER) param_NPI_NUMBER = (TYPEOF(h.NPI_NUMBER))'',TYPEOF(h.BILLING_NPI_NUMBER) param_BILLING_NPI_NUMBER = (TYPEOF(h.BILLING_NPI_NUMBER))'',TYPEOF(h.UPIN) param_UPIN = (TYPEOF(h.UPIN))'',TYPEOF(h.DID) param_DID = (TYPEOF(h.DID))'',TYPEOF(h.BDID) param_BDID = (TYPEOF(h.BDID))'',TYPEOF(h.SRC) param_SRC = (TYPEOF(h.SRC))'',TYPEOF(h.SOURCE_RID) param_SOURCE_RID = (TYPEOF(h.SOURCE_RID))'',TYPEOF(h.RID) param_RID = (TYPEOF(h.RID))'',SALT311.StrType param_MAINNAME,SALT311.StrType param_FULLNAME,SALT311.StrType param_ADDR1,SALT311.StrType param_LOCALE,SALT311.StrType param_ADDRESS) := FUNCTION
  RawData := RawFetch(param_FNAME,param_FNAME_len,param_MNAME,param_MNAME_len,param_LNAME,param_LNAME_len,param_SNAME,param_GENDER,param_PRIM_RANGE,param_PRIM_NAME,param_SEC_RANGE,param_V_CITY_NAME,param_ST,param_ZIP,param_SSN,param_SSN_len,param_CNSMR_SSN,param_CNSMR_SSN_len,param_DOB,param_CNSMR_DOB,param_PHONE,param_LIC_STATE,param_C_LIC_NBR,param_C_LIC_NBR_len,param_TAX_ID,param_BILLING_TAX_ID,param_DEA_NUMBER,param_VENDOR_ID,param_NPI_NUMBER,param_BILLING_NPI_NUMBER,param_UPIN,param_DID,param_BDID,param_SRC,param_SOURCE_RID,param_RID,param_MAINNAME,param_FULLNAME,param_ADDR1,param_LOCALE,param_ADDRESS);
 
  Process_xLNPID_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 0; // Set bitmap for keys used
    SELF.keys_failed := 0; // Set bitmap for keys failed
    SELF.LNPID := le.uid;
    SELF.Weight := le.Weight; // Already rolled up in collate_uber
    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));
  result1 := ROLLUP(result0,LEFT.LNPID = RIGHT.LNPID,Process_xLNPID_Layouts.combine_scores(LEFT,RIGHT));
  RETURN result1;
END;
END;
