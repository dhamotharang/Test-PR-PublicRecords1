EXPORT Key_HealthProvider_ := MODULE
IMPORT SALT29,ut,std;
//FNAME:MNAME:?:LNAME:SNAME:+:GENDER:PRIM_RANGE:PRIM_NAME:SEC_RANGE:V_CITY_NAME:ST:ZIP:SSN:CNSMR_SSN:DOB:CNSMR_DOB:PHONE:LIC_STATE:C_LIC_NBR:TAX_ID:BILLING_TAX_ID:DEA_NUMBER:VENDOR_ID:NPI_NUMBER:BILLING_NPI_NUMBER:UPIN:DID:BDID:SRC:SOURCE_RID:RID:MAINNAME:FULLNAME:ADDR1:LOCALE:ADDRESS
EXPORT KeyName := Health_Provider_Services.Files.FILE_Header_Refs_SF; //'~'+'key::Health_Provider_Services::LNPID::Refs';
SHARED h := CandidatesForKey;//The input file - distributed by LNPID
SALT29.Layout_Uber_Plus IntoInversion(h le,unsigned2 c) := TRANSFORM
  SELF.word := CHOOSE(c,Fields.Make_FNAME((SALT29.StrType)le.FNAME),Fields.Make_MNAME((SALT29.StrType)le.MNAME),Fields.Make_LNAME((SALT29.StrType)le.LNAME),Fields.Make_SNAME((SALT29.StrType)le.SNAME),Fields.Make_GENDER((SALT29.StrType)le.GENDER),Fields.Make_PRIM_RANGE((SALT29.StrType)le.PRIM_RANGE),Fields.Make_PRIM_NAME((SALT29.StrType)le.PRIM_NAME),Fields.Make_SEC_RANGE((SALT29.StrType)le.SEC_RANGE),Fields.Make_V_CITY_NAME((SALT29.StrType)le.V_CITY_NAME),Fields.Make_ST((SALT29.StrType)le.ST),Fields.Make_ZIP((SALT29.StrType)le.ZIP),Fields.Make_SSN((SALT29.StrType)le.SSN),Fields.Make_CNSMR_SSN((SALT29.StrType)le.CNSMR_SSN),(SALT29.StrType)(le.DOB_year*10000+le.DOB_month*100+le.DOB_day),(SALT29.StrType)(le.CNSMR_DOB_year*10000+le.CNSMR_DOB_month*100+le.CNSMR_DOB_day),Fields.Make_PHONE((SALT29.StrType)le.PHONE),Fields.Make_LIC_STATE((SALT29.StrType)le.LIC_STATE),Fields.Make_C_LIC_NBR((SALT29.StrType)le.C_LIC_NBR),Fields.Make_TAX_ID((SALT29.StrType)le.TAX_ID),Fields.Make_BILLING_TAX_ID((SALT29.StrType)le.BILLING_TAX_ID),Fields.Make_DEA_NUMBER((SALT29.StrType)le.DEA_NUMBER),Fields.Make_VENDOR_ID((SALT29.StrType)le.VENDOR_ID),Fields.Make_NPI_NUMBER((SALT29.StrType)le.NPI_NUMBER),Fields.Make_BILLING_NPI_NUMBER((SALT29.StrType)le.BILLING_NPI_NUMBER),Fields.Make_UPIN((SALT29.StrType)le.UPIN),Fields.Make_DID((SALT29.StrType)le.DID),Fields.Make_BDID((SALT29.StrType)le.BDID),Fields.Make_SRC((SALT29.StrType)le.SRC),Fields.Make_SOURCE_RID((SALT29.StrType)le.SOURCE_RID),Fields.Make_RID((SALT29.StrType)le.RID),SKIP,SKIP,SKIP,SKIP,SKIP,SKIP);
  SELF.field := c;
  SELF.uid := le.LNPID
END;
nfields_r := SALT29.Fn_Reduce_UBER_Local(NORMALIZE(h,35,IntoInversion(LEFT,COUNTER))(word<>''));
SALT29.MAC_Expand_Normal_Field(h,FNAME,31,LNPID,nfields7936);
SALT29.MAC_Expand_Normal_Field(h,MNAME,31,LNPID,nfields7937);
SALT29.MAC_Expand_Normal_Field(h,LNAME,31,LNPID,nfields7938);
nfields31 := nfields7936+nfields7937+nfields7938;//Collect wordbags for parts of concept field
SALT29.MAC_Expand_Normal_Field(h,FNAME,32,LNPID,nfields2097152);
SALT29.MAC_Expand_Normal_Field(h,MNAME,32,LNPID,nfields2097153);
SALT29.MAC_Expand_Normal_Field(h,LNAME,32,LNPID,nfields2097154);
nfields8192 := nfields2097152+nfields2097153+nfields2097154;//Collect wordbags for parts of concept field
SALT29.MAC_Expand_Normal_Field(h,SNAME,32,LNPID,nfields8193);
nfields32 := nfields8192+nfields8193;//Collect wordbags for parts of concept field
SALT29.MAC_Expand_Normal_Field(h,PRIM_NAME,33,LNPID,nfields8448);
SALT29.MAC_Expand_Normal_Field(h,PRIM_RANGE,33,LNPID,nfields8449);
SALT29.MAC_Expand_Normal_Field(h,SEC_RANGE,33,LNPID,nfields8450);
nfields33 := nfields8448+nfields8449+nfields8450;//Collect wordbags for parts of concept field
SALT29.MAC_Expand_Normal_Field(h,V_CITY_NAME,34,LNPID,nfields8704);
SALT29.MAC_Expand_Normal_Field(h,ST,34,LNPID,nfields8705);
SALT29.MAC_Expand_Normal_Field(h,ZIP,34,LNPID,nfields8706);
nfields34 := nfields8704+nfields8705+nfields8706;//Collect wordbags for parts of concept field
SALT29.MAC_Expand_Normal_Field(h,PRIM_NAME,35,LNPID,nfields2293760);
SALT29.MAC_Expand_Normal_Field(h,PRIM_RANGE,35,LNPID,nfields2293761);
SALT29.MAC_Expand_Normal_Field(h,SEC_RANGE,35,LNPID,nfields2293762);
nfields8960 := nfields2293760+nfields2293761+nfields2293762;//Collect wordbags for parts of concept field
SALT29.MAC_Expand_Normal_Field(h,V_CITY_NAME,35,LNPID,nfields2294016);
SALT29.MAC_Expand_Normal_Field(h,ST,35,LNPID,nfields2294017);
SALT29.MAC_Expand_Normal_Field(h,ZIP,35,LNPID,nfields2294018);
nfields8961 := nfields2294016+nfields2294017+nfields2294018;//Collect wordbags for parts of concept field
nfields35 := nfields8960+nfields8961;//Collect wordbags for parts of concept field
invert_records := nfields_r;
shared DataForKey0 := SALT29.Fn_Reduce_UBER_Local( invert_records );
EXPORT ValueKeyName := Health_Provider_Services.Files.FILE_Header_Words_SF; //'~'+'key::Health_Provider_Services::LNPID::Words';
  r0 := RECORD
    DataForKey0.uid;
    UNSIGNED6 InCluster := COUNT(GROUP);
  END;
  SHARED ClusterSizes := TABLE(DataForKey0,r0,uid,LOCAL);// Set up for Specificity_Local
  SHARED TotalClusters := COUNT(ClusterSizes);
  SALT29.MAC_Specificity_Local(DataForKey0,word,uid,word_nulls,SALT29.Layout_Uber_Nulls,word_specificity,word_switch,word_values);
EXPORT ValueKey := INDEX(word_values,{word},{word_values},ValueKeyName);
  SALT29.Layout_Uber_Plus add_id(SALT29.Layout_Uber_Plus le,word_values ri,boolean patch_default) := transform
    SELF.word_id := ri.id;
    SELF := le;
  END;
  SALT29.Mac_Choose_JoinType(DataForKey0,word_nulls,word_values,word,word_weight100,add_id,DataForKey1);
  SALT29.Layout_Uber_Record slim(DataForKey1 le) := TRANSFORM
    self := le;
  end;
  DataForKey2 := sort(project(DataForKey1,slim(left)),whole record,skew(1));
EXPORT Key := INDEX(DataForKey2,{DataForKey2},{},KeyName);
KeyRec := RECORDOF(Key);
EXPORT RawFetch(TYPEOF(h.FNAME) param_FNAME,TYPEOF(h.MNAME) param_MNAME,TYPEOF(h.LNAME) param_LNAME,TYPEOF(h.SNAME) param_SNAME,TYPEOF(h.GENDER) param_GENDER,TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE,TYPEOF(h.PRIM_NAME) param_PRIM_NAME,TYPEOF(h.SEC_RANGE) param_SEC_RANGE,TYPEOF(h.V_CITY_NAME) param_V_CITY_NAME,TYPEOF(h.ST) param_ST,TYPEOF(h.ZIP) param_ZIP,TYPEOF(h.SSN) param_SSN,TYPEOF(h.CNSMR_SSN) param_CNSMR_SSN,UNSIGNED4 param_DOB,UNSIGNED4 param_CNSMR_DOB,TYPEOF(h.PHONE) param_PHONE,TYPEOF(h.LIC_STATE) param_LIC_STATE,TYPEOF(h.C_LIC_NBR) param_C_LIC_NBR,TYPEOF(h.TAX_ID) param_TAX_ID,TYPEOF(h.BILLING_TAX_ID) param_BILLING_TAX_ID,TYPEOF(h.DEA_NUMBER) param_DEA_NUMBER,TYPEOF(h.VENDOR_ID) param_VENDOR_ID,TYPEOF(h.NPI_NUMBER) param_NPI_NUMBER,TYPEOF(h.BILLING_NPI_NUMBER) param_BILLING_NPI_NUMBER,TYPEOF(h.UPIN) param_UPIN,TYPEOF(h.DID) param_DID,TYPEOF(h.BDID) param_BDID,TYPEOF(h.SRC) param_SRC,TYPEOF(h.SOURCE_RID) param_SOURCE_RID,TYPEOF(h.RID) param_RID,SALT29.StrType param_MAINNAME,SALT29.StrType param_FULLNAME,SALT29.StrType param_ADDR1,SALT29.StrType param_LOCALE,SALT29.StrType param_ADDRESS) := 
  FUNCTION
 //Create wordstream from parameters
    SALT29.MAC_Field_To_UberStream(param_FNAME,1,ValueKey,WS1);
    SALT29.MAC_Field_To_UberStream(param_MNAME,2,ValueKey,WS2);
    SALT29.MAC_Field_To_UberStream(param_LNAME,3,ValueKey,WS3);
    SALT29.MAC_Field_To_UberStream(param_SNAME,4,ValueKey,WS4);
    SALT29.MAC_Field_To_UberStream(param_GENDER,5,ValueKey,WS5);
    SALT29.MAC_Field_To_UberStream(param_PRIM_RANGE,6,ValueKey,WS6);
    SALT29.MAC_Field_To_UberStream(param_PRIM_NAME,7,ValueKey,WS7);
    SALT29.MAC_Field_To_UberStream(param_SEC_RANGE,8,ValueKey,WS8);
    SALT29.MAC_Field_To_UberStream(param_V_CITY_NAME,9,ValueKey,WS9);
    SALT29.MAC_Field_To_UberStream(param_ST,10,ValueKey,WS10);
    SALT29.MAC_Field_To_UberStream(param_ZIP,11,ValueKey,WS11);
    SALT29.MAC_Field_To_UberStream(param_SSN,12,ValueKey,WS12);
    SALT29.MAC_Field_To_UberStream(param_CNSMR_SSN,13,ValueKey,WS13);
    SALT29.MAC_Field_To_UberStream(param_DOB,14,ValueKey,WS14);
    SALT29.MAC_Field_To_UberStream(param_CNSMR_DOB,15,ValueKey,WS15);
    SALT29.MAC_Field_To_UberStream(param_PHONE,16,ValueKey,WS16);
    SALT29.MAC_Field_To_UberStream(param_LIC_STATE,17,ValueKey,WS17);
    SALT29.MAC_Field_To_UberStream(param_C_LIC_NBR,18,ValueKey,WS18);
    SALT29.MAC_Field_To_UberStream(param_TAX_ID,19,ValueKey,WS19);
    SALT29.MAC_Field_To_UberStream(param_BILLING_TAX_ID,20,ValueKey,WS20);
    SALT29.MAC_Field_To_UberStream(param_DEA_NUMBER,21,ValueKey,WS21);
    SALT29.MAC_Field_To_UberStream(param_VENDOR_ID,22,ValueKey,WS22);
    SALT29.MAC_Field_To_UberStream(param_NPI_NUMBER,23,ValueKey,WS23);
    SALT29.MAC_Field_To_UberStream(param_BILLING_NPI_NUMBER,24,ValueKey,WS24);
    SALT29.MAC_Field_To_UberStream(param_UPIN,25,ValueKey,WS25);
    SALT29.MAC_Field_To_UberStream(param_DID,26,ValueKey,WS26);
    SALT29.MAC_Field_To_UberStream(param_BDID,27,ValueKey,WS27);
    SALT29.MAC_Field_To_UberStream(param_SRC,28,ValueKey,WS28);
    SALT29.MAC_Field_To_UberStream(param_SOURCE_RID,29,ValueKey,WS29);
    SALT29.MAC_Field_To_UberStream(param_RID,30,ValueKey,WS30);
    SALT29.MAC_Field_To_UberStream(param_MAINNAME,31,ValueKey,WS31);
    SALT29.MAC_Field_To_UberStream(param_FULLNAME,32,ValueKey,WS32);
    SALT29.MAC_Field_To_UberStream(param_ADDR1,33,ValueKey,WS33);
    SALT29.MAC_Field_To_UberStream(param_LOCALE,34,ValueKey,WS34);
    SALT29.MAC_Field_To_UberStream(param_ADDRESS,35,ValueKey,WS35);
    wds := WS1+WS2+WS3+WS4+WS5+WS6+WS7+WS8+WS9+WS10+WS11+WS12+WS13+WS14+WS15+WS16+WS17+WS18+WS19+WS20+WS21+WS22+WS23+WS24+WS25+WS26+WS27+WS28+WS29+WS30+WS31+WS32+WS33+WS34+WS35;
    SALT29.MAC_Collate_Uber_Matches(Key,Wds,steppedmatches);
    RETURN steppedmatches;
  END;
EXPORT ScoredLNPIDFetch(TYPEOF(h.FNAME) param_FNAME,TYPEOF(h.MNAME) param_MNAME,TYPEOF(h.LNAME) param_LNAME,TYPEOF(h.SNAME) param_SNAME,TYPEOF(h.GENDER) param_GENDER,TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE,TYPEOF(h.PRIM_NAME) param_PRIM_NAME,TYPEOF(h.SEC_RANGE) param_SEC_RANGE,TYPEOF(h.V_CITY_NAME) param_V_CITY_NAME,TYPEOF(h.ST) param_ST,TYPEOF(h.ZIP) param_ZIP,TYPEOF(h.SSN) param_SSN,TYPEOF(h.CNSMR_SSN) param_CNSMR_SSN,UNSIGNED4 param_DOB,UNSIGNED4 param_CNSMR_DOB,TYPEOF(h.PHONE) param_PHONE,TYPEOF(h.LIC_STATE) param_LIC_STATE,TYPEOF(h.C_LIC_NBR) param_C_LIC_NBR,TYPEOF(h.TAX_ID) param_TAX_ID,TYPEOF(h.BILLING_TAX_ID) param_BILLING_TAX_ID,TYPEOF(h.DEA_NUMBER) param_DEA_NUMBER,TYPEOF(h.VENDOR_ID) param_VENDOR_ID,TYPEOF(h.NPI_NUMBER) param_NPI_NUMBER,TYPEOF(h.BILLING_NPI_NUMBER) param_BILLING_NPI_NUMBER,TYPEOF(h.UPIN) param_UPIN,TYPEOF(h.DID) param_DID,TYPEOF(h.BDID) param_BDID,TYPEOF(h.SRC) param_SRC,TYPEOF(h.SOURCE_RID) param_SOURCE_RID,TYPEOF(h.RID) param_RID,SALT29.StrType param_MAINNAME,SALT29.StrType param_FULLNAME,SALT29.StrType param_ADDR1,SALT29.StrType param_LOCALE,SALT29.StrType param_ADDRESS) := FUNCTION
  RawData := RawFetch(param_FNAME,param_MNAME,param_LNAME,param_SNAME,param_GENDER,param_PRIM_RANGE,param_PRIM_NAME,param_SEC_RANGE,param_V_CITY_NAME,param_ST,param_ZIP,param_SSN,param_CNSMR_SSN,param_DOB,param_CNSMR_DOB,param_PHONE,param_LIC_STATE,param_C_LIC_NBR,param_TAX_ID,param_BILLING_TAX_ID,param_DEA_NUMBER,param_VENDOR_ID,param_NPI_NUMBER,param_BILLING_NPI_NUMBER,param_UPIN,param_DID,param_BDID,param_SRC,param_SOURCE_RID,param_RID,param_MAINNAME,param_FULLNAME,param_ADDR1,param_LOCALE,param_ADDRESS);
  Process_xLNPID_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 0; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key used
    SELF.LNPID := le.uid;
    SELF.Weight := le.Weight; // Already rolled up in collate_uber
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(NOFOLD(RawData),Score(LEFT)),LEFT.LNPID = RIGHT.LNPID,Process_xLNPID_Layouts.combine_scores(LEFT,RIGHT));
END;
END;
