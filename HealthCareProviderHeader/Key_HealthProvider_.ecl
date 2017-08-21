EXPORT Key_HealthProvider_ := MODULE
IMPORT SALT27,ut,std;
//DID:?:DOB:PHONE:+:SNAME:FNAME:MNAME:LNAME:GENDER:DERIVED_GENDER:LIC_NBR:ADDRESS_ID:PRIM_NAME:PRIM_RANGE:SEC_RANGE:V_CITY_NAME:ST:ZIP:CNAME:TAX_ID:UPIN:DEA_NUMBER:VENDOR_ID:NPI_NUMBER:DT_FIRST_SEEN:DT_LAST_SEEN:DT_LIC_EXPIRATION:DT_DEA_EXPIRATION:MAINNAME:FULLNAME:FULLNAME_DOB:ADDR:LOCALE:ADDRESS:LIC_STATE:SRC
EXPORT KeyName := '~'+'key::HealthCareProviderHeader::LNPID::Refs';
SHARED h := CandidatesForKey;//The input file - distributed by LNPID
SALT27.Layout_Uber_Plus IntoInversion(h le,unsigned2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT27.StrType)le.DID,(SALT27.StrType)(le.DOB_year*10000+le.DOB_month*100+le.DOB_day),Fields.Make_PHONE((SALT27.StrType)le.PHONE),Fields.Make_SNAME((SALT27.StrType)le.SNAME),Fields.Make_FNAME((SALT27.StrType)le.FNAME),Fields.Make_MNAME((SALT27.StrType)le.MNAME),Fields.Make_LNAME((SALT27.StrType)le.LNAME),Fields.Make_GENDER((SALT27.StrType)le.GENDER),Fields.Make_DERIVED_GENDER((SALT27.StrType)le.DERIVED_GENDER),Fields.Make_LIC_NBR((SALT27.StrType)le.LIC_NBR),(SALT27.StrType)le.ADDRESS_ID,Fields.Make_PRIM_NAME((SALT27.StrType)le.PRIM_NAME),Fields.Make_PRIM_RANGE((SALT27.StrType)le.PRIM_RANGE),Fields.Make_SEC_RANGE((SALT27.StrType)le.SEC_RANGE),Fields.Make_V_CITY_NAME((SALT27.StrType)le.V_CITY_NAME),Fields.Make_ST((SALT27.StrType)le.ST),Fields.Make_ZIP((SALT27.StrType)le.ZIP),Fields.Make_CNAME((SALT27.StrType)le.CNAME),Fields.Make_TAX_ID((SALT27.StrType)le.TAX_ID),Fields.Make_UPIN((SALT27.StrType)le.UPIN),Fields.Make_DEA_NUMBER((SALT27.StrType)le.DEA_NUMBER),Fields.Make_VENDOR_ID((SALT27.StrType)le.VENDOR_ID),Fields.Make_NPI_NUMBER((SALT27.StrType)le.NPI_NUMBER),'','',Fields.Make_DT_LIC_EXPIRATION((SALT27.StrType)le.DT_LIC_EXPIRATION),Fields.Make_DT_DEA_EXPIRATION((SALT27.StrType)le.DT_DEA_EXPIRATION),SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,(SALT27.StrType)le.LIC_STATE,(SALT27.StrType)le.SRC,SKIP);
  SELF.field := c;
  SELF.uid := le.LNPID
END;
nfields_r := SALT27.Fn_Reduce_UBER_Local(NORMALIZE(h,35,IntoInversion(LEFT,COUNTER))(word<>''));
SALT27.MAC_Expand_Normal_Field(h,FNAME,28,LNPID,nfields7168);
SALT27.MAC_Expand_Normal_Field(h,MNAME,28,LNPID,nfields7169);
SALT27.MAC_Expand_Normal_Field(h,LNAME,28,LNPID,nfields7170);
nfields28 := nfields7168+nfields7169+nfields7170;//Collect wordbags for parts of concept field
SALT27.MAC_Expand_Normal_Field(h,FNAME,29,LNPID,nfields1900544);
SALT27.MAC_Expand_Normal_Field(h,MNAME,29,LNPID,nfields1900545);
SALT27.MAC_Expand_Normal_Field(h,LNAME,29,LNPID,nfields1900546);
nfields7424 := nfields1900544+nfields1900545+nfields1900546;//Collect wordbags for parts of concept field
SALT27.MAC_Expand_Normal_Field(h,SNAME,29,LNPID,nfields7425);
nfields29 := nfields7424+nfields7425;//Collect wordbags for parts of concept field
SALT27.MAC_Expand_Normal_Field(h,FNAME,30,LNPID,nfields503316480);
SALT27.MAC_Expand_Normal_Field(h,MNAME,30,LNPID,nfields503316481);
SALT27.MAC_Expand_Normal_Field(h,LNAME,30,LNPID,nfields503316482);
nfields1966080 := nfields503316480+nfields503316481+nfields503316482;//Collect wordbags for parts of concept field
SALT27.MAC_Expand_Normal_Field(h,SNAME,30,LNPID,nfields1966081);
nfields7680 := nfields1966080+nfields1966081;//Collect wordbags for parts of concept field
SALT27.MAC_Expand_Date_Field(h,DOB_year,DOB_month,DOB_day,30,LNPID,nfields7681);
nfields30 := nfields7680+nfields7681;//Collect wordbags for parts of concept field
SALT27.MAC_Expand_Normal_Field(h,PRIM_RANGE,31,LNPID,nfields7936);
SALT27.MAC_Expand_Normal_Field(h,SEC_RANGE,31,LNPID,nfields7937);
SALT27.MAC_Expand_Normal_Field(h,PRIM_NAME,31,LNPID,nfields7938);
nfields31 := nfields7936+nfields7937+nfields7938;//Collect wordbags for parts of concept field
SALT27.MAC_Expand_Normal_Field(h,V_CITY_NAME,32,LNPID,nfields8192);
SALT27.MAC_Expand_Normal_Field(h,ST,32,LNPID,nfields8193);
SALT27.MAC_Expand_Normal_Field(h,ZIP,32,LNPID,nfields8194);
nfields32 := nfields8192+nfields8193+nfields8194;//Collect wordbags for parts of concept field
SALT27.MAC_Expand_Normal_Field(h,PRIM_RANGE,33,LNPID,nfields2162688);
SALT27.MAC_Expand_Normal_Field(h,SEC_RANGE,33,LNPID,nfields2162689);
SALT27.MAC_Expand_Normal_Field(h,PRIM_NAME,33,LNPID,nfields2162690);
nfields8448 := nfields2162688+nfields2162689+nfields2162690;//Collect wordbags for parts of concept field
SALT27.MAC_Expand_Normal_Field(h,V_CITY_NAME,33,LNPID,nfields2162944);
SALT27.MAC_Expand_Normal_Field(h,ST,33,LNPID,nfields2162945);
SALT27.MAC_Expand_Normal_Field(h,ZIP,33,LNPID,nfields2162946);
nfields8449 := nfields2162944+nfields2162945+nfields2162946;//Collect wordbags for parts of concept field
nfields33 := nfields8448+nfields8449;//Collect wordbags for parts of concept field
invert_records := nfields_r;
shared DataForKey0 := SALT27.Fn_Reduce_UBER_Local( invert_records );
EXPORT ValueKeyName := '~'+'key::HealthCareProviderHeader::LNPID::Words';
  r0 := RECORD
    DataForKey0.uid;
    UNSIGNED6 InCluster := COUNT(GROUP);
  END;
  SHARED ClusterSizes := TABLE(DataForKey0,r0,uid,LOCAL);// Set up for Specificity_Local
  SHARED TotalClusters := COUNT(ClusterSizes);
  SALT27.MAC_Specificity_Local(DataForKey0,word,uid,word_nulls,SALT27.Layout_Uber_Nulls,word_specificity,word_switch,word_values);
EXPORT ValueKey := INDEX(word_values,{word},{word_values},ValueKeyName);
  SALT27.Layout_Uber_Plus add_id(SALT27.Layout_Uber_Plus le,word_values ri,boolean patch_default) := transform
    SELF.word_id := ri.id;
    SELF := le;
  END;
  SALT27.Mac_Choose_JoinType(DataForKey0,word_nulls,word_values,word,word_weight100,add_id,DataForKey1);
  SALT27.Layout_Uber_Record slim(DataForKey1 le) := TRANSFORM
    self := le;
  end;
  DataForKey2 := sort(project(DataForKey1,slim(left)),whole record,skew(1));
EXPORT Key := INDEX(DataForKey2,{DataForKey2},{},KeyName);
KeyRec := RECORDOF(Key);
EXPORT RawFetch( typeof(h.DID) param_DID,UNSIGNED4 param_DOB, typeof(h.PHONE) param_PHONE, typeof(h.SNAME) param_SNAME, typeof(h.FNAME) param_FNAME, typeof(h.MNAME) param_MNAME, typeof(h.LNAME) param_LNAME, typeof(h.GENDER) param_GENDER, typeof(h.DERIVED_GENDER) param_DERIVED_GENDER, typeof(h.LIC_NBR) param_LIC_NBR, typeof(h.ADDRESS_ID) param_ADDRESS_ID, typeof(h.PRIM_NAME) param_PRIM_NAME, typeof(h.PRIM_RANGE) param_PRIM_RANGE, typeof(h.SEC_RANGE) param_SEC_RANGE, typeof(h.V_CITY_NAME) param_V_CITY_NAME, typeof(h.ST) param_ST, typeof(h.ZIP) param_ZIP, typeof(h.CNAME) param_CNAME, typeof(h.TAX_ID) param_TAX_ID, typeof(h.UPIN) param_UPIN, typeof(h.DEA_NUMBER) param_DEA_NUMBER, typeof(h.VENDOR_ID) param_VENDOR_ID, typeof(h.NPI_NUMBER) param_NPI_NUMBER, typeof(h.DT_LIC_EXPIRATION) param_DT_LIC_EXPIRATION, typeof(h.DT_DEA_EXPIRATION) param_DT_DEA_EXPIRATION,SALT27.StrType param_MAINNAME,SALT27.StrType param_FULLNAME,SALT27.StrType param_FULLNAME_DOB,SALT27.StrType param_ADDR,SALT27.StrType param_LOCALE,SALT27.StrType param_ADDRESS, typeof(h.LIC_STATE) param_LIC_STATE, typeof(h.SRC) param_SRC) := 
  FUNCTION
 //Create wordstream from parameters
    SALT27.MAC_Field_To_UberStream(param_DID,1,ValueKey,WS1);
    SALT27.MAC_Field_To_UberStream(param_DOB,2,ValueKey,WS2);
    SALT27.MAC_Field_To_UberStream(param_PHONE,3,ValueKey,WS3);
    SALT27.MAC_Field_To_UberStream(param_SNAME,4,ValueKey,WS4);
    SALT27.MAC_Field_To_UberStream(param_FNAME,5,ValueKey,WS5);
    SALT27.MAC_Field_To_UberStream(param_MNAME,6,ValueKey,WS6);
    SALT27.MAC_Field_To_UberStream(param_LNAME,7,ValueKey,WS7);
    SALT27.MAC_Field_To_UberStream(param_GENDER,8,ValueKey,WS8);
    SALT27.MAC_Field_To_UberStream(param_DERIVED_GENDER,9,ValueKey,WS9);
    SALT27.MAC_Field_To_UberStream(param_LIC_NBR,10,ValueKey,WS10);
    SALT27.MAC_Field_To_UberStream(param_ADDRESS_ID,11,ValueKey,WS11);
    SALT27.MAC_Field_To_UberStream(param_PRIM_NAME,12,ValueKey,WS12);
    SALT27.MAC_Field_To_UberStream(param_PRIM_RANGE,13,ValueKey,WS13);
    SALT27.MAC_Field_To_UberStream(param_SEC_RANGE,14,ValueKey,WS14);
    SALT27.MAC_Field_To_UberStream(param_V_CITY_NAME,15,ValueKey,WS15);
    SALT27.MAC_Field_To_UberStream(param_ST,16,ValueKey,WS16);
    SALT27.MAC_Field_To_UberStream(param_ZIP,17,ValueKey,WS17);
    SALT27.MAC_Field_To_UberStream(param_CNAME,18,ValueKey,WS18);
    SALT27.MAC_Field_To_UberStream(param_TAX_ID,19,ValueKey,WS19);
    SALT27.MAC_Field_To_UberStream(param_UPIN,20,ValueKey,WS20);
    SALT27.MAC_Field_To_UberStream(param_DEA_NUMBER,21,ValueKey,WS21);
    SALT27.MAC_Field_To_UberStream(param_VENDOR_ID,22,ValueKey,WS22);
    SALT27.MAC_Field_To_UberStream(param_NPI_NUMBER,23,ValueKey,WS23);
    SALT27.MAC_Field_To_UberStream(param_DT_LIC_EXPIRATION,26,ValueKey,WS26);
    SALT27.MAC_Field_To_UberStream(param_DT_DEA_EXPIRATION,27,ValueKey,WS27);
    SALT27.MAC_Field_To_UberStream(param_MAINNAME,28,ValueKey,WS28);
    SALT27.MAC_Field_To_UberStream(param_FULLNAME,29,ValueKey,WS29);
    SALT27.MAC_Field_To_UberStream(param_FULLNAME_DOB,30,ValueKey,WS30);
    SALT27.MAC_Field_To_UberStream(param_ADDR,31,ValueKey,WS31);
    SALT27.MAC_Field_To_UberStream(param_LOCALE,32,ValueKey,WS32);
    SALT27.MAC_Field_To_UberStream(param_ADDRESS,33,ValueKey,WS33);
    SALT27.MAC_Field_To_UberStream(param_LIC_STATE,34,ValueKey,WS34);
    SALT27.MAC_Field_To_UberStream(param_SRC,35,ValueKey,WS35);
    wds := WS1+WS2+WS3+WS4+WS5+WS6+WS7+WS8+WS9+WS10+WS11+WS12+WS13+WS14+WS15+WS16+WS17+WS18+WS19+WS20+WS21+WS22+WS23+WS26+WS27+WS28+WS29+WS30+WS31+WS32+WS33+WS34+WS35;
    SALT27.MAC_Collate_Uber_Matches(Key,Wds,steppedmatches);
    RETURN steppedmatches;
  END;
EXPORT ScoredLNPIDFetch( typeof(h.DID) param_DID,UNSIGNED4 param_DOB, typeof(h.PHONE) param_PHONE, typeof(h.SNAME) param_SNAME, typeof(h.FNAME) param_FNAME, typeof(h.MNAME) param_MNAME, typeof(h.LNAME) param_LNAME, typeof(h.GENDER) param_GENDER, typeof(h.DERIVED_GENDER) param_DERIVED_GENDER, typeof(h.LIC_NBR) param_LIC_NBR, typeof(h.ADDRESS_ID) param_ADDRESS_ID, typeof(h.PRIM_NAME) param_PRIM_NAME, typeof(h.PRIM_RANGE) param_PRIM_RANGE, typeof(h.SEC_RANGE) param_SEC_RANGE, typeof(h.V_CITY_NAME) param_V_CITY_NAME, typeof(h.ST) param_ST, typeof(h.ZIP) param_ZIP, typeof(h.CNAME) param_CNAME, typeof(h.TAX_ID) param_TAX_ID, typeof(h.UPIN) param_UPIN, typeof(h.DEA_NUMBER) param_DEA_NUMBER, typeof(h.VENDOR_ID) param_VENDOR_ID, typeof(h.NPI_NUMBER) param_NPI_NUMBER, typeof(h.DT_LIC_EXPIRATION) param_DT_LIC_EXPIRATION, typeof(h.DT_DEA_EXPIRATION) param_DT_DEA_EXPIRATION,SALT27.StrType param_MAINNAME,SALT27.StrType param_FULLNAME,SALT27.StrType param_FULLNAME_DOB,SALT27.StrType param_ADDR,SALT27.StrType param_LOCALE,SALT27.StrType param_ADDRESS, typeof(h.LIC_STATE) param_LIC_STATE, typeof(h.SRC) param_SRC) := FUNCTION
  RawData := RawFetch(param_DID,param_DOB,param_PHONE,param_SNAME,param_FNAME,param_MNAME,param_LNAME,param_GENDER,param_DERIVED_GENDER,param_LIC_NBR,param_ADDRESS_ID,param_PRIM_NAME,param_PRIM_RANGE,param_SEC_RANGE,param_V_CITY_NAME,param_ST,param_ZIP,param_CNAME,param_TAX_ID,param_UPIN,param_DEA_NUMBER,param_VENDOR_ID,param_NPI_NUMBER,param_DT_LIC_EXPIRATION,param_DT_DEA_EXPIRATION,param_MAINNAME,param_FULLNAME,param_FULLNAME_DOB,param_ADDR,param_LOCALE,param_ADDRESS,param_LIC_STATE,param_SRC);
  Process_LNPID_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 0; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key used
    SELF.LNPID := le.uid;
    SELF.Weight := le.Weight; // Already rolled up in collate_uber
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(NOFOLD(RawData),Score(LEFT)),LEFT.LNPID = RIGHT.LNPID,Process_LNPID_Layouts.combine_scores(LEFT,RIGHT));
END;
END;
