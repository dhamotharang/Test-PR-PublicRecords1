EXPORT Key_HealthProvider_ := MODULE

IMPORT SALT27,ut,std;
//VENDOR_ID:DID:NPI_NUMBER:?:DEA_NUMBER:MAINNAME:+:FULLNAME:LIC_NBR:UPIN:ADDR:ADDRESS:TAX_ID:DOB:PRIM_NAME:ZIP:LOCALE:PRIM_RANGE:LNAME:V_CITY_NAME:LAT_LONG:MNAME:FNAME:SEC_RANGE:SNAME:ST:GENDER:PHONE:LIC_STATE:ADDRESS_ID:CNAME:SRC:DT_FIRST_SEEN:DT_LAST_SEEN:DT_LIC_EXPIRATION:DT_DEA_EXPIRATION:GEO_LAT:GEO_LONG

EXPORT KeyName := '~'+'key::HealthCareProviderHeader_prod::LNPID::Refs';
SHARED h := CandidatesForKey;//The input file - distributed by LNPID
SALT27.Layout_Uber_Plus IntoInversion(h le,unsigned2 c) := TRANSFORM
SELF.word := CHOOSE(c,Fields.Make_VENDOR_ID((SALT27.StrType)le.VENDOR_ID),(SALT27.StrType)le.DID,Fields.Make_NPI_NUMBER((SALT27.StrType)le.NPI_NUMBER),Fields.Make_DEA_NUMBER((SALT27.StrType)le.DEA_NUMBER),SKIP,SKIP,Fields.Make_LIC_NBR((SALT27.StrType)le.LIC_NBR),Fields.Make_UPIN((SALT27.StrType)le.UPIN),SKIP,SKIP,Fields.Make_TAX_ID((SALT27.StrType)le.TAX_ID),(SALT27.StrType)(le.DOB_year*10000+le.DOB_month*100+le.DOB_day),Fields.Make_PRIM_NAME((SALT27.StrType)le.PRIM_NAME),Fields.Make_ZIP((SALT27.StrType)le.ZIP),SKIP,Fields.Make_PRIM_RANGE((SALT27.StrType)le.PRIM_RANGE),Fields.Make_LNAME((SALT27.StrType)le.LNAME),Fields.Make_V_CITY_NAME((SALT27.StrType)le.V_CITY_NAME),'',Fields.Make_MNAME((SALT27.StrType)le.MNAME),Fields.Make_FNAME((SALT27.StrType)le.FNAME),Fields.Make_SEC_RANGE((SALT27.StrType)le.SEC_RANGE),Fields.Make_SNAME((SALT27.StrType)le.SNAME),Fields.Make_ST((SALT27.StrType)le.ST),(SALT27.StrType)le.GENDER,Fields.Make_PHONE((SALT27.StrType)le.PHONE),Fields.Make_LIC_STATE((SALT27.StrType)le.LIC_STATE),(SALT27.StrType)le.ADDRESS_ID,Fields.Make_CNAME((SALT27.StrType)le.CNAME),Fields.Make_SRC((SALT27.StrType)le.SRC),'','',Fields.Make_DT_LIC_EXPIRATION((SALT27.StrType)le.DT_LIC_EXPIRATION),Fields.Make_DT_DEA_EXPIRATION((SALT27.StrType)le.DT_DEA_EXPIRATION),Fields.Make_GEO_LAT((SALT27.StrType)le.GEO_LAT),Fields.Make_GEO_LONG((SALT27.StrType)le.GEO_LONG),SKIP);
SELF.field := c;
SELF.uid := le.LNPID
END;
nfields_r := SALT27.Fn_Reduce_UBER_Local(NORMALIZE(h,36,IntoInversion(LEFT,COUNTER))(word<>''));
SALT27.MAC_Expand_Normal_Field(h,FNAME,5,LNPID,nfields1280);
SALT27.MAC_Expand_Normal_Field(h,MNAME,5,LNPID,nfields1281);
SALT27.MAC_Expand_Normal_Field(h,LNAME,5,LNPID,nfields1282);
nfields5 := nfields1280+nfields1281+nfields1282;//Collect wordbags for parts of concept field
SALT27.MAC_Expand_Normal_Field(h,FNAME,6,LNPID,nfields393216);
SALT27.MAC_Expand_Normal_Field(h,MNAME,6,LNPID,nfields393217);
SALT27.MAC_Expand_Normal_Field(h,LNAME,6,LNPID,nfields393218);
nfields1536 := nfields393216+nfields393217+nfields393218;//Collect wordbags for parts of concept field
SALT27.MAC_Expand_Normal_Field(h,SNAME,6,LNPID,nfields1537);
nfields6 := nfields1536+nfields1537;//Collect wordbags for parts of concept field
SALT27.MAC_Expand_Normal_Field(h,PRIM_RANGE,9,LNPID,nfields2304);
SALT27.MAC_Expand_Normal_Field(h,SEC_RANGE,9,LNPID,nfields2305);
SALT27.MAC_Expand_Normal_Field(h,PRIM_NAME,9,LNPID,nfields2306);
nfields9 := nfields2304+nfields2305+nfields2306;//Collect wordbags for parts of concept field
SALT27.MAC_Expand_Normal_Field(h,PRIM_RANGE,10,LNPID,nfields655360);
SALT27.MAC_Expand_Normal_Field(h,SEC_RANGE,10,LNPID,nfields655361);
SALT27.MAC_Expand_Normal_Field(h,PRIM_NAME,10,LNPID,nfields655362);
nfields2560 := nfields655360+nfields655361+nfields655362;//Collect wordbags for parts of concept field
SALT27.MAC_Expand_Normal_Field(h,V_CITY_NAME,10,LNPID,nfields655616);
SALT27.MAC_Expand_Normal_Field(h,ST,10,LNPID,nfields655617);
SALT27.MAC_Expand_Normal_Field(h,ZIP,10,LNPID,nfields655618);
nfields2561 := nfields655616+nfields655617+nfields655618;//Collect wordbags for parts of concept field
nfields10 := nfields2560+nfields2561;//Collect wordbags for parts of concept field
SALT27.MAC_Expand_Normal_Field(h,V_CITY_NAME,15,LNPID,nfields3840);
SALT27.MAC_Expand_Normal_Field(h,ST,15,LNPID,nfields3841);
SALT27.MAC_Expand_Normal_Field(h,ZIP,15,LNPID,nfields3842);
nfields15 := nfields3840+nfields3841+nfields3842;//Collect wordbags for parts of concept field
invert_records := nfields_r;
shared DataForKey0 := SALT27.Fn_Reduce_UBER_Local( invert_records );

EXPORT ValueKeyName := '~'+'key::HealthCareProviderHeader_prod::LNPID::Words';
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

EXPORT RawFetch( typeof(h.VENDOR_ID) param_VENDOR_ID, typeof(h.DID) param_DID, typeof(h.NPI_NUMBER) param_NPI_NUMBER, typeof(h.DEA_NUMBER) param_DEA_NUMBER,SALT27.StrType param_MAINNAME,SALT27.StrType param_FULLNAME, typeof(h.LIC_NBR) param_LIC_NBR, typeof(h.UPIN) param_UPIN,SALT27.StrType param_ADDR,SALT27.StrType param_ADDRESS, typeof(h.TAX_ID) param_TAX_ID,UNSIGNED4 param_DOB, typeof(h.PRIM_NAME) param_PRIM_NAME, typeof(h.ZIP) param_ZIP,SALT27.StrType param_LOCALE, typeof(h.PRIM_RANGE) param_PRIM_RANGE, typeof(h.LNAME) param_LNAME, typeof(h.V_CITY_NAME) param_V_CITY_NAME, typeof(h.MNAME) param_MNAME, typeof(h.FNAME) param_FNAME, typeof(h.SEC_RANGE) param_SEC_RANGE, typeof(h.SNAME) param_SNAME, typeof(h.ST) param_ST, typeof(h.GENDER) param_GENDER, typeof(h.PHONE) param_PHONE, typeof(h.LIC_STATE) param_LIC_STATE, typeof(h.ADDRESS_ID) param_ADDRESS_ID, typeof(h.CNAME) param_CNAME, typeof(h.SRC) param_SRC, typeof(h.DT_LIC_EXPIRATION) param_DT_LIC_EXPIRATION, typeof(h.DT_DEA_EXPIRATION) param_DT_DEA_EXPIRATION, typeof(h.GEO_LAT) param_GEO_LAT, typeof(h.GEO_LONG) param_GEO_LONG) :=
FUNCTION
//Create wordstream from parameters
SALT27.MAC_Field_To_UberStream(param_VENDOR_ID,1,ValueKey,WS1);
SALT27.MAC_Field_To_UberStream(param_DID,2,ValueKey,WS2);
SALT27.MAC_Field_To_UberStream(param_NPI_NUMBER,3,ValueKey,WS3);
SALT27.MAC_Field_To_UberStream(param_DEA_NUMBER,4,ValueKey,WS4);
SALT27.MAC_Field_To_UberStream(param_MAINNAME,5,ValueKey,WS5);
SALT27.MAC_Field_To_UberStream(param_FULLNAME,6,ValueKey,WS6);
SALT27.MAC_Field_To_UberStream(param_LIC_NBR,7,ValueKey,WS7);
SALT27.MAC_Field_To_UberStream(param_UPIN,8,ValueKey,WS8);
SALT27.MAC_Field_To_UberStream(param_ADDR,9,ValueKey,WS9);
SALT27.MAC_Field_To_UberStream(param_ADDRESS,10,ValueKey,WS10);
SALT27.MAC_Field_To_UberStream(param_TAX_ID,11,ValueKey,WS11);
SALT27.MAC_Field_To_UberStream(param_DOB,12,ValueKey,WS12);
SALT27.MAC_Field_To_UberStream(param_PRIM_NAME,13,ValueKey,WS13);
SALT27.MAC_Field_To_UberStream(param_ZIP,14,ValueKey,WS14);
SALT27.MAC_Field_To_UberStream(param_LOCALE,15,ValueKey,WS15);
SALT27.MAC_Field_To_UberStream(param_PRIM_RANGE,16,ValueKey,WS16);
SALT27.MAC_Field_To_UberStream(param_LNAME,17,ValueKey,WS17);
SALT27.MAC_Field_To_UberStream(param_V_CITY_NAME,18,ValueKey,WS18);
SALT27.MAC_Field_To_UberStream(param_MNAME,20,ValueKey,WS20);
SALT27.MAC_Field_To_UberStream(param_FNAME,21,ValueKey,WS21);
SALT27.MAC_Field_To_UberStream(param_SEC_RANGE,22,ValueKey,WS22);
SALT27.MAC_Field_To_UberStream(param_SNAME,23,ValueKey,WS23);
SALT27.MAC_Field_To_UberStream(param_ST,24,ValueKey,WS24);
SALT27.MAC_Field_To_UberStream(param_GENDER,25,ValueKey,WS25);
SALT27.MAC_Field_To_UberStream(param_PHONE,26,ValueKey,WS26);
SALT27.MAC_Field_To_UberStream(param_LIC_STATE,27,ValueKey,WS27);
SALT27.MAC_Field_To_UberStream(param_ADDRESS_ID,28,ValueKey,WS28);
SALT27.MAC_Field_To_UberStream(param_CNAME,29,ValueKey,WS29);
SALT27.MAC_Field_To_UberStream(param_SRC,30,ValueKey,WS30);
SALT27.MAC_Field_To_UberStream(param_DT_LIC_EXPIRATION,33,ValueKey,WS33);
SALT27.MAC_Field_To_UberStream(param_DT_DEA_EXPIRATION,34,ValueKey,WS34);
SALT27.MAC_Field_To_UberStream(param_GEO_LAT,35,ValueKey,WS35);
SALT27.MAC_Field_To_UberStream(param_GEO_LONG,36,ValueKey,WS36);
wds := WS1+WS2+WS3+WS4+WS5+WS6+WS7+WS8+WS9+WS10+WS11+WS12+WS13+WS14+WS15+WS16+WS17+WS18+WS20+WS21+WS22+WS23+WS24+WS25+WS26+WS27+WS28+WS29+WS30+WS33+WS34+WS35+WS36;
SALT27.MAC_Collate_Uber_Matches(Key,Wds,steppedmatches);
RETURN steppedmatches;
END;

EXPORT ScoredLNPIDFetch( typeof(h.VENDOR_ID) param_VENDOR_ID, typeof(h.DID) param_DID, typeof(h.NPI_NUMBER) param_NPI_NUMBER, typeof(h.DEA_NUMBER) param_DEA_NUMBER,SALT27.StrType param_MAINNAME,SALT27.StrType param_FULLNAME, typeof(h.LIC_NBR) param_LIC_NBR, typeof(h.UPIN) param_UPIN,SALT27.StrType param_ADDR,SALT27.StrType param_ADDRESS, typeof(h.TAX_ID) param_TAX_ID,UNSIGNED4 param_DOB, typeof(h.PRIM_NAME) param_PRIM_NAME, typeof(h.ZIP) param_ZIP,SALT27.StrType param_LOCALE, typeof(h.PRIM_RANGE) param_PRIM_RANGE, typeof(h.LNAME) param_LNAME, typeof(h.V_CITY_NAME) param_V_CITY_NAME, typeof(h.MNAME) param_MNAME, typeof(h.FNAME) param_FNAME, typeof(h.SEC_RANGE) param_SEC_RANGE, typeof(h.SNAME) param_SNAME, typeof(h.ST) param_ST, typeof(h.GENDER) param_GENDER, typeof(h.PHONE) param_PHONE, typeof(h.LIC_STATE) param_LIC_STATE, typeof(h.ADDRESS_ID) param_ADDRESS_ID, typeof(h.CNAME) param_CNAME, typeof(h.SRC) param_SRC, typeof(h.DT_LIC_EXPIRATION) param_DT_LIC_EXPIRATION, typeof(h.DT_DEA_EXPIRATION) param_DT_DEA_EXPIRATION, typeof(h.GEO_LAT) param_GEO_LAT, typeof(h.GEO_LONG) param_GEO_LONG) := FUNCTION
RawData := RawFetch(param_VENDOR_ID,param_DID,param_NPI_NUMBER,param_DEA_NUMBER,param_MAINNAME,param_FULLNAME,param_LIC_NBR,param_UPIN,param_ADDR,param_ADDRESS,param_TAX_ID,param_DOB,param_PRIM_NAME,param_ZIP,param_LOCALE,param_PRIM_RANGE,param_LNAME,param_V_CITY_NAME,param_MNAME,param_FNAME,param_SEC_RANGE,param_SNAME,param_ST,param_GENDER,param_PHONE,param_LIC_STATE,param_ADDRESS_ID,param_CNAME,param_SRC,param_DT_LIC_EXPIRATION,param_DT_DEA_EXPIRATION,param_GEO_LAT,param_GEO_LONG);

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
