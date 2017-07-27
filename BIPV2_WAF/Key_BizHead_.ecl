EXPORT Key_BizHead_ := MODULE
 
IMPORT SALT29,ut,std;
//parent_proxid:ultimate_proxid:has_lgid:empid:powid:source:source_record_id:?:cnp_number:cnp_btype:cnp_lowv:cnp_name:company_phone:+:company_fein:company_sic_code1:prim_range:prim_name:sec_range:p_city_name:st:zip:company_url:isContact:title:fname:mname:lname:name_suffix:contact_email:CONTACTNAME:STREETADDRESS
 
EXPORT KeyName := '~'+'key::BIPV2_WAF::proxid::Refs';
SHARED h := CandidatesForKey;//The input file - distributed by proxid
SALT29.Layout_Uber_Plus IntoInversion(h le,unsigned2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT29.StrType)le.parent_proxid,(SALT29.StrType)le.ultimate_proxid,(SALT29.StrType)le.has_lgid,(SALT29.StrType)le.empid,(SALT29.StrType)le.powid,(SALT29.StrType)le.source,(SALT29.StrType)le.source_record_id,(SALT29.StrType)le.cnp_number,(SALT29.StrType)le.cnp_btype,(SALT29.StrType)le.cnp_lowv,'',(SALT29.StrType)le.company_phone,Fields.Make_company_fein((SALT29.StrType)le.company_fein),(SALT29.StrType)le.company_sic_code1,(SALT29.StrType)le.prim_range,Fields.Make_prim_name((SALT29.StrType)le.prim_name),Fields.Make_sec_range((SALT29.StrType)le.sec_range),Fields.Make_p_city_name((SALT29.StrType)le.p_city_name),Fields.Make_st((SALT29.StrType)le.st),Fields.Make_zip((SALT29.StrType)le.zip),'',(SALT29.StrType)le.isContact,(SALT29.StrType)le.title,Fields.Make_fname((SALT29.StrType)le.fname),Fields.Make_mname((SALT29.StrType)le.mname),Fields.Make_lname((SALT29.StrType)le.lname),Fields.Make_name_suffix((SALT29.StrType)le.name_suffix),(SALT29.StrType)le.contact_email,SKIP,SKIP,SKIP);
  SELF.field := c;
  SELF.uid := le.proxid
END;
nfields_r := SALT29.Fn_Reduce_UBER_Local(NORMALIZE(h,30,IntoInversion(LEFT,COUNTER))(word<>''));
SALT29.MAC_Expand_Wordbag_Field(h,cnp_name,11,proxid,nfields11);
SALT29.MAC_Expand_Wordbag_Field(h,company_url,21,proxid,nfields21);
SALT29.MAC_Expand_Normal_Field(h,fname,29,proxid,nfields7424);
SALT29.MAC_Expand_Normal_Field(h,mname,29,proxid,nfields7425);
SALT29.MAC_Expand_Normal_Field(h,lname,29,proxid,nfields7426);
nfields29 := nfields7424+nfields7425+nfields7426;//Collect wordbags for parts of concept field
SALT29.MAC_Expand_Normal_Field(h,prim_range,30,proxid,nfields7680);
SALT29.MAC_Expand_Normal_Field(h,prim_name,30,proxid,nfields7681);
SALT29.MAC_Expand_Normal_Field(h,sec_range,30,proxid,nfields7682);
nfields30 := nfields7680+nfields7681+nfields7682;//Collect wordbags for parts of concept field
invert_records := nfields_r + nfields11 + nfields21;
shared DataForKey0 := SALT29.Fn_Reduce_UBER_Local( invert_records );
 
EXPORT ValueKeyName := '~'+'key::BIPV2_WAF::proxid::Words';
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
 
EXPORT RawFetch(TYPEOF(h.parent_proxid) param_parent_proxid,TYPEOF(h.ultimate_proxid) param_ultimate_proxid,TYPEOF(h.has_lgid) param_has_lgid,TYPEOF(h.empid) param_empid,TYPEOF(h.powid) param_powid,TYPEOF(h.source) param_source,TYPEOF(h.source_record_id) param_source_record_id,TYPEOF(h.cnp_number) param_cnp_number,TYPEOF(h.cnp_btype) param_cnp_btype,TYPEOF(h.cnp_lowv) param_cnp_lowv,TYPEOF(h.cnp_name) param_cnp_name,TYPEOF(h.company_phone) param_company_phone,TYPEOF(h.company_fein) param_company_fein,TYPEOF(h.company_sic_code1) param_company_sic_code1,TYPEOF(h.prim_range) param_prim_range,TYPEOF(h.prim_name) param_prim_name,TYPEOF(h.sec_range) param_sec_range,TYPEOF(h.p_city_name) param_p_city_name,TYPEOF(h.st) param_st,SET OF TYPEOF(h.zip) param_zip,TYPEOF(h.company_url) param_company_url,TYPEOF(h.isContact) param_isContact,TYPEOF(h.title) param_title,TYPEOF(h.fname) param_fname,TYPEOF(h.mname) param_mname,TYPEOF(h.lname) param_lname,TYPEOF(h.name_suffix) param_name_suffix,TYPEOF(h.contact_email) param_contact_email,SALT29.StrType param_CONTACTNAME,SALT29.StrType param_STREETADDRESS) := 
  FUNCTION
 //Create wordstream from parameters
    SALT29.MAC_Field_To_UberStream(param_parent_proxid,1,ValueKey,WS1);
    SALT29.MAC_Field_To_UberStream(param_ultimate_proxid,2,ValueKey,WS2);
    SALT29.MAC_Field_To_UberStream(param_has_lgid,3,ValueKey,WS3);
    SALT29.MAC_Field_To_UberStream(param_empid,4,ValueKey,WS4);
    SALT29.MAC_Field_To_UberStream(param_powid,5,ValueKey,WS5);
    SALT29.MAC_Field_To_UberStream(param_source,6,ValueKey,WS6);
    SALT29.MAC_Field_To_UberStream(param_source_record_id,7,ValueKey,WS7);
    SALT29.MAC_Field_To_UberStream(param_cnp_number,8,ValueKey,WS8);
    SALT29.MAC_Field_To_UberStream(param_cnp_btype,9,ValueKey,WS9);
    SALT29.MAC_Field_To_UberStream(param_cnp_lowv,10,ValueKey,WS10);
    SALT29.MAC_FieldWordBag_To_UberStream(param_cnp_name,11,ValueKey,WS11);
    SALT29.MAC_Field_To_UberStream(param_company_phone,12,ValueKey,WS12);
    SALT29.MAC_Field_To_UberStream(param_company_fein,13,ValueKey,WS13);
    SALT29.MAC_Field_To_UberStream(param_company_sic_code1,14,ValueKey,WS14);
    SALT29.MAC_Field_To_UberStream(param_prim_range,15,ValueKey,WS15);
    SALT29.MAC_Field_To_UberStream(param_prim_name,16,ValueKey,WS16);
    SALT29.MAC_Field_To_UberStream(param_sec_range,17,ValueKey,WS17);
    SALT29.MAC_Field_To_UberStream(param_p_city_name,18,ValueKey,WS18);
    SALT29.MAC_Field_To_UberStream(param_st,19,ValueKey,WS19);
    SALT29.MAC_FieldSet_To_UberStream(param_zip,20,ValueKey,WS20);
    SALT29.MAC_FieldWordBag_To_UberStream(param_company_url,21,ValueKey,WS21);
    SALT29.MAC_Field_To_UberStream(param_isContact,22,ValueKey,WS22);
    SALT29.MAC_Field_To_UberStream(param_title,23,ValueKey,WS23);
    SALT29.MAC_Field_To_UberStream(param_fname,24,ValueKey,WS24);
    SALT29.MAC_Field_To_UberStream(param_mname,25,ValueKey,WS25);
    SALT29.MAC_Field_To_UberStream(param_lname,26,ValueKey,WS26);
    SALT29.MAC_Field_To_UberStream(param_name_suffix,27,ValueKey,WS27);
    SALT29.MAC_Field_To_UberStream(param_contact_email,28,ValueKey,WS28);
    SALT29.MAC_Field_To_UberStream(param_CONTACTNAME,29,ValueKey,WS29);
    SALT29.MAC_Field_To_UberStream(param_STREETADDRESS,30,ValueKey,WS30);
    wds := WS1+WS2+WS3+WS4+WS5+WS6+WS7+WS8+WS9+WS10+WS11+WS12+WS13+WS14+WS15+WS16+WS17+WS18+WS19+WS20+WS21+WS22+WS23+WS24+WS25+WS26+WS27+WS28+WS29+WS30;
    SALT29.MAC_Collate_Uber_Matches(Key,Wds,steppedmatches);
    RETURN steppedmatches;
  END;
 
EXPORT ScoredproxidFetch(TYPEOF(h.parent_proxid) param_parent_proxid,TYPEOF(h.ultimate_proxid) param_ultimate_proxid,TYPEOF(h.has_lgid) param_has_lgid,TYPEOF(h.empid) param_empid,TYPEOF(h.powid) param_powid,TYPEOF(h.source) param_source,TYPEOF(h.source_record_id) param_source_record_id,TYPEOF(h.cnp_number) param_cnp_number,TYPEOF(h.cnp_btype) param_cnp_btype,TYPEOF(h.cnp_lowv) param_cnp_lowv,TYPEOF(h.cnp_name) param_cnp_name,TYPEOF(h.company_phone) param_company_phone,TYPEOF(h.company_fein) param_company_fein,TYPEOF(h.company_sic_code1) param_company_sic_code1,TYPEOF(h.prim_range) param_prim_range,TYPEOF(h.prim_name) param_prim_name,TYPEOF(h.sec_range) param_sec_range,TYPEOF(h.p_city_name) param_p_city_name,TYPEOF(h.st) param_st,SET OF TYPEOF(h.zip) param_zip,TYPEOF(h.company_url) param_company_url,TYPEOF(h.isContact) param_isContact,TYPEOF(h.title) param_title,TYPEOF(h.fname) param_fname,TYPEOF(h.mname) param_mname,TYPEOF(h.lname) param_lname,TYPEOF(h.name_suffix) param_name_suffix,TYPEOF(h.contact_email) param_contact_email,SALT29.StrType param_CONTACTNAME,SALT29.StrType param_STREETADDRESS) := FUNCTION
  RawData := RawFetch(param_parent_proxid,param_ultimate_proxid,param_has_lgid,param_empid,param_powid,param_source,param_source_record_id,param_cnp_number,param_cnp_btype,param_cnp_lowv,param_cnp_name,param_company_phone,param_company_fein,param_company_sic_code1,param_prim_range,param_prim_name,param_sec_range,param_p_city_name,param_st,param_zip,param_company_url,param_isContact,param_title,param_fname,param_mname,param_lname,param_name_suffix,param_contact_email,param_CONTACTNAME,param_STREETADDRESS);
 
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 0; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key used
    SELF.seleid := 0; // Id hierarchy does not work with uberkey
    SELF.orgid := 0; // Id hierarchy does not work with uberkey
    SELF.ultid := 0; // Id hierarchy does not work with uberkey
    SELF.proxid := le.uid;
    SELF.Weight := le.Weight; // Already rolled up in collate_uber
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(NOFOLD(RawData),Score(LEFT)),LEFT.proxid = RIGHT.proxid,Process_Biz_Layouts.combine_scores(LEFT,RIGHT));
END;
END;
