EXPORT Key_HealthFacility_ := MODULE
IMPORT SALT29,ut,std;
//CNAME:CNP_NAME:?:CNP_NUMBER:CNP_STORE_NUMBER:+:CNP_BTYPE:CNP_LOWV:PRIM_RANGE:PRIM_NAME:SEC_RANGE:V_CITY_NAME:ST:ZIP:TAX_ID:FEIN:PHONE:FAX:LIC_STATE:C_LIC_NBR:DEA_NUMBER:VENDOR_ID:NPI_NUMBER:CLIA_NUMBER:MEDICARE_FACILITY_NUMBER:MEDICAID_NUMBER:NCPDP_NUMBER:TAXONOMY:TAXONOMY_CODE:BDID:SRC:SOURCE_RID:FAC_NAME:ADDR1:LOCALE:ADDRES
EXPORT KeyName := PRTE_Health_Facility_Services.Files.FILE_Header_Refs; //'~'+'key::PRTE_Health_Facility_Services::LNPID::Refs';
SHARED h := CandidatesForKey;//The input file - distributed by LNPID
SALT29.Layout_Uber_Plus IntoInversion(h le,unsigned2 c) := TRANSFORM
  SELF.word := CHOOSE(c,Fields.Make_CNAME((SALT29.StrType)le.CNAME),'',Fields.Make_CNP_NUMBER((SALT29.StrType)le.CNP_NUMBER),Fields.Make_CNP_STORE_NUMBER((SALT29.StrType)le.CNP_STORE_NUMBER),Fields.Make_CNP_BTYPE((SALT29.StrType)le.CNP_BTYPE),Fields.Make_CNP_LOWV((SALT29.StrType)le.CNP_LOWV),(SALT29.StrType)le.PRIM_RANGE,(SALT29.StrType)le.PRIM_NAME,(SALT29.StrType)le.SEC_RANGE,(SALT29.StrType)le.V_CITY_NAME,(SALT29.StrType)le.ST,(SALT29.StrType)le.ZIP,(SALT29.StrType)le.TAX_ID,(SALT29.StrType)le.FEIN,Fields.Make_PHONE((SALT29.StrType)le.PHONE),Fields.Make_FAX((SALT29.StrType)le.FAX),Fields.Make_LIC_STATE((SALT29.StrType)le.LIC_STATE),Fields.Make_C_LIC_NBR((SALT29.StrType)le.C_LIC_NBR),Fields.Make_DEA_NUMBER((SALT29.StrType)le.DEA_NUMBER),Fields.Make_VENDOR_ID((SALT29.StrType)le.VENDOR_ID),Fields.Make_NPI_NUMBER((SALT29.StrType)le.NPI_NUMBER),Fields.Make_CLIA_NUMBER((SALT29.StrType)le.CLIA_NUMBER),Fields.Make_MEDICARE_FACILITY_NUMBER((SALT29.StrType)le.MEDICARE_FACILITY_NUMBER),Fields.Make_MEDICAID_NUMBER((SALT29.StrType)le.MEDICAID_NUMBER),Fields.Make_NCPDP_NUMBER((SALT29.StrType)le.NCPDP_NUMBER),Fields.Make_TAXONOMY((SALT29.StrType)le.TAXONOMY),Fields.Make_TAXONOMY_CODE((SALT29.StrType)le.TAXONOMY_CODE),Fields.Make_BDID((SALT29.StrType)le.BDID),Fields.Make_SRC((SALT29.StrType)le.SRC),Fields.Make_SOURCE_RID((SALT29.StrType)le.SOURCE_RID),SKIP,SKIP,SKIP,SKIP,SKIP);
  SELF.field := c;
  SELF.uid := le.LNPID
END;
nfields_r := SALT29.Fn_Reduce_UBER_Local(NORMALIZE(h,34,IntoInversion(LEFT,COUNTER))(word<>''));
SALT29.MAC_Expand_Wordbag_Field(h,CNP_NAME,2,LNPID,nfields2);
SALT29.MAC_Expand_Wordbag_Field(h,CNP_NAME,31,LNPID,nfields7936);
SALT29.MAC_Expand_Normal_Field(h,CNP_NUMBER,31,LNPID,nfields7937);
SALT29.MAC_Expand_Normal_Field(h,CNP_STORE_NUMBER,31,LNPID,nfields7938);
SALT29.MAC_Expand_Normal_Field(h,CNP_BTYPE,31,LNPID,nfields7939);
SALT29.MAC_Expand_Normal_Field(h,CNP_LOWV,31,LNPID,nfields7940);
nfields31 := nfields7936+nfields7937+nfields7938+nfields7939+nfields7940;//Collect wordbags for parts of concept field
SALT29.MAC_Expand_Normal_Field(h,PRIM_RANGE,32,LNPID,nfields8192);
SALT29.MAC_Expand_Normal_Field(h,SEC_RANGE,32,LNPID,nfields8193);
SALT29.MAC_Expand_Normal_Field(h,PRIM_NAME,32,LNPID,nfields8194);
nfields32 := nfields8192+nfields8193+nfields8194;//Collect wordbags for parts of concept field
SALT29.MAC_Expand_Normal_Field(h,V_CITY_NAME,33,LNPID,nfields8448);
SALT29.MAC_Expand_Normal_Field(h,ST,33,LNPID,nfields8449);
SALT29.MAC_Expand_Normal_Field(h,ZIP,33,LNPID,nfields8450);
nfields33 := nfields8448+nfields8449+nfields8450;//Collect wordbags for parts of concept field
SALT29.MAC_Expand_Normal_Field(h,PRIM_RANGE,34,LNPID,nfields2228224);
SALT29.MAC_Expand_Normal_Field(h,SEC_RANGE,34,LNPID,nfields2228225);
SALT29.MAC_Expand_Normal_Field(h,PRIM_NAME,34,LNPID,nfields2228226);
nfields8704 := nfields2228224+nfields2228225+nfields2228226;//Collect wordbags for parts of concept field
SALT29.MAC_Expand_Normal_Field(h,V_CITY_NAME,34,LNPID,nfields2228480);
SALT29.MAC_Expand_Normal_Field(h,ST,34,LNPID,nfields2228481);
SALT29.MAC_Expand_Normal_Field(h,ZIP,34,LNPID,nfields2228482);
nfields8705 := nfields2228480+nfields2228481+nfields2228482;//Collect wordbags for parts of concept field
nfields34 := nfields8704+nfields8705;//Collect wordbags for parts of concept field
invert_records := nfields_r + nfields2;
shared DataForKey0 := SALT29.Fn_Reduce_UBER_Local( invert_records );
EXPORT ValueKeyName := PRTE_Health_Facility_Services.Files.FILE_Header_Words; //'~'+'key::PRTE_Health_Facility_Services::LNPID::Words';
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
EXPORT RawFetch(TYPEOF(h.CNAME) param_CNAME,TYPEOF(h.CNP_NAME) param_CNP_NAME,TYPEOF(h.CNP_NUMBER) param_CNP_NUMBER,TYPEOF(h.CNP_STORE_NUMBER) param_CNP_STORE_NUMBER,TYPEOF(h.CNP_BTYPE) param_CNP_BTYPE,TYPEOF(h.CNP_LOWV) param_CNP_LOWV,TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE,TYPEOF(h.PRIM_NAME) param_PRIM_NAME,TYPEOF(h.SEC_RANGE) param_SEC_RANGE,TYPEOF(h.V_CITY_NAME) param_V_CITY_NAME,TYPEOF(h.ST) param_ST,TYPEOF(h.ZIP) param_ZIP,TYPEOF(h.TAX_ID) param_TAX_ID,TYPEOF(h.FEIN) param_FEIN,TYPEOF(h.PHONE) param_PHONE,TYPEOF(h.FAX) param_FAX,TYPEOF(h.LIC_STATE) param_LIC_STATE,TYPEOF(h.C_LIC_NBR) param_C_LIC_NBR,TYPEOF(h.DEA_NUMBER) param_DEA_NUMBER,TYPEOF(h.VENDOR_ID) param_VENDOR_ID,TYPEOF(h.NPI_NUMBER) param_NPI_NUMBER,TYPEOF(h.CLIA_NUMBER) param_CLIA_NUMBER,TYPEOF(h.MEDICARE_FACILITY_NUMBER) param_MEDICARE_FACILITY_NUMBER,TYPEOF(h.MEDICAID_NUMBER) param_MEDICAID_NUMBER,TYPEOF(h.NCPDP_NUMBER) param_NCPDP_NUMBER,TYPEOF(h.TAXONOMY) param_TAXONOMY,TYPEOF(h.TAXONOMY_CODE) param_TAXONOMY_CODE,TYPEOF(h.BDID) param_BDID,TYPEOF(h.SRC) param_SRC,TYPEOF(h.SOURCE_RID) param_SOURCE_RID,SALT29.StrType param_FAC_NAME,SALT29.StrType param_ADDR1,SALT29.StrType param_LOCALE,SALT29.StrType param_ADDRES) := 
  FUNCTION
 //Create wordstream from parameters
    SALT29.MAC_Field_To_UberStream(param_CNAME,1,ValueKey,WS1);
    SALT29.MAC_FieldWordBag_To_UberStream(param_CNP_NAME,2,ValueKey,WS2);
    SALT29.MAC_Field_To_UberStream(param_CNP_NUMBER,3,ValueKey,WS3);
    SALT29.MAC_Field_To_UberStream(param_CNP_STORE_NUMBER,4,ValueKey,WS4);
    SALT29.MAC_Field_To_UberStream(param_CNP_BTYPE,5,ValueKey,WS5);
    SALT29.MAC_Field_To_UberStream(param_CNP_LOWV,6,ValueKey,WS6);
    SALT29.MAC_Field_To_UberStream(param_PRIM_RANGE,7,ValueKey,WS7);
    SALT29.MAC_Field_To_UberStream(param_PRIM_NAME,8,ValueKey,WS8);
    SALT29.MAC_Field_To_UberStream(param_SEC_RANGE,9,ValueKey,WS9);
    SALT29.MAC_Field_To_UberStream(param_V_CITY_NAME,10,ValueKey,WS10);
    SALT29.MAC_Field_To_UberStream(param_ST,11,ValueKey,WS11);
    SALT29.MAC_Field_To_UberStream(param_ZIP,12,ValueKey,WS12);
    SALT29.MAC_Field_To_UberStream(param_TAX_ID,13,ValueKey,WS13);
    SALT29.MAC_Field_To_UberStream(param_FEIN,14,ValueKey,WS14);
    SALT29.MAC_Field_To_UberStream(param_PHONE,15,ValueKey,WS15);
    SALT29.MAC_Field_To_UberStream(param_FAX,16,ValueKey,WS16);
    SALT29.MAC_Field_To_UberStream(param_LIC_STATE,17,ValueKey,WS17);
    SALT29.MAC_Field_To_UberStream(param_C_LIC_NBR,18,ValueKey,WS18);
    SALT29.MAC_Field_To_UberStream(param_DEA_NUMBER,19,ValueKey,WS19);
    SALT29.MAC_Field_To_UberStream(param_VENDOR_ID,20,ValueKey,WS20);
    SALT29.MAC_Field_To_UberStream(param_NPI_NUMBER,21,ValueKey,WS21);
    SALT29.MAC_Field_To_UberStream(param_CLIA_NUMBER,22,ValueKey,WS22);
    SALT29.MAC_Field_To_UberStream(param_MEDICARE_FACILITY_NUMBER,23,ValueKey,WS23);
    SALT29.MAC_Field_To_UberStream(param_MEDICAID_NUMBER,24,ValueKey,WS24);
    SALT29.MAC_Field_To_UberStream(param_NCPDP_NUMBER,25,ValueKey,WS25);
    SALT29.MAC_Field_To_UberStream(param_TAXONOMY,26,ValueKey,WS26);
    SALT29.MAC_Field_To_UberStream(param_TAXONOMY_CODE,27,ValueKey,WS27);
    SALT29.MAC_Field_To_UberStream(param_BDID,28,ValueKey,WS28);
    SALT29.MAC_Field_To_UberStream(param_SRC,29,ValueKey,WS29);
    SALT29.MAC_Field_To_UberStream(param_SOURCE_RID,30,ValueKey,WS30);
    SALT29.MAC_Field_To_UberStream(param_FAC_NAME,31,ValueKey,WS31);
    SALT29.MAC_Field_To_UberStream(param_ADDR1,32,ValueKey,WS32);
    SALT29.MAC_Field_To_UberStream(param_LOCALE,33,ValueKey,WS33);
    SALT29.MAC_Field_To_UberStream(param_ADDRES,34,ValueKey,WS34);
    wds := WS1+WS2+WS3+WS4+WS5+WS6+WS7+WS8+WS9+WS10+WS11+WS12+WS13+WS14+WS15+WS16+WS17+WS18+WS19+WS20+WS21+WS22+WS23+WS24+WS25+WS26+WS27+WS28+WS29+WS30+WS31+WS32+WS33+WS34;
    SALT29.MAC_Collate_Uber_Matches(Key,Wds,steppedmatches);
    RETURN steppedmatches;
  END;
EXPORT ScoredLNPIDFetch(TYPEOF(h.CNAME) param_CNAME,TYPEOF(h.CNP_NAME) param_CNP_NAME,TYPEOF(h.CNP_NUMBER) param_CNP_NUMBER,TYPEOF(h.CNP_STORE_NUMBER) param_CNP_STORE_NUMBER,TYPEOF(h.CNP_BTYPE) param_CNP_BTYPE,TYPEOF(h.CNP_LOWV) param_CNP_LOWV,TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE,TYPEOF(h.PRIM_NAME) param_PRIM_NAME,TYPEOF(h.SEC_RANGE) param_SEC_RANGE,TYPEOF(h.V_CITY_NAME) param_V_CITY_NAME,TYPEOF(h.ST) param_ST,TYPEOF(h.ZIP) param_ZIP,TYPEOF(h.TAX_ID) param_TAX_ID,TYPEOF(h.FEIN) param_FEIN,TYPEOF(h.PHONE) param_PHONE,TYPEOF(h.FAX) param_FAX,TYPEOF(h.LIC_STATE) param_LIC_STATE,TYPEOF(h.C_LIC_NBR) param_C_LIC_NBR,TYPEOF(h.DEA_NUMBER) param_DEA_NUMBER,TYPEOF(h.VENDOR_ID) param_VENDOR_ID,TYPEOF(h.NPI_NUMBER) param_NPI_NUMBER,TYPEOF(h.CLIA_NUMBER) param_CLIA_NUMBER,TYPEOF(h.MEDICARE_FACILITY_NUMBER) param_MEDICARE_FACILITY_NUMBER,TYPEOF(h.MEDICAID_NUMBER) param_MEDICAID_NUMBER,TYPEOF(h.NCPDP_NUMBER) param_NCPDP_NUMBER,TYPEOF(h.TAXONOMY) param_TAXONOMY,TYPEOF(h.TAXONOMY_CODE) param_TAXONOMY_CODE,TYPEOF(h.BDID) param_BDID,TYPEOF(h.SRC) param_SRC,TYPEOF(h.SOURCE_RID) param_SOURCE_RID,SALT29.StrType param_FAC_NAME,SALT29.StrType param_ADDR1,SALT29.StrType param_LOCALE,SALT29.StrType param_ADDRES) := FUNCTION
  RawData := RawFetch(param_CNAME,param_CNP_NAME,param_CNP_NUMBER,param_CNP_STORE_NUMBER,param_CNP_BTYPE,param_CNP_LOWV,param_PRIM_RANGE,param_PRIM_NAME,param_SEC_RANGE,param_V_CITY_NAME,param_ST,param_ZIP,param_TAX_ID,param_FEIN,param_PHONE,param_FAX,param_LIC_STATE,param_C_LIC_NBR,param_DEA_NUMBER,param_VENDOR_ID,param_NPI_NUMBER,param_CLIA_NUMBER,param_MEDICARE_FACILITY_NUMBER,param_MEDICAID_NUMBER,param_NCPDP_NUMBER,param_TAXONOMY,param_TAXONOMY_CODE,param_BDID,param_SRC,param_SOURCE_RID,param_FAC_NAME,param_ADDR1,param_LOCALE,param_ADDRES);
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
