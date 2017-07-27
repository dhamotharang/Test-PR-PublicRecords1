IMPORT SALT33,ut,std;
EXPORT Key_BizHead_ := MODULE
 
//parent_proxid:?:sele_proxid:org_proxid:+:ultimate_proxid:has_lgid:empid:source:source_record_id:source_docid:company_name:company_name_prefix:cnp_name:cnp_number:cnp_btype:cnp_lowv:company_phone:company_phone_3:company_phone_3_ex:company_phone_7:company_fein:company_sic_code1:active_duns_number:prim_range:prim_name:sec_range:city:city_clean:st:zip:company_url:isContact:contact_did:title:fname:fname_preferred:mname:lname:name_suffix:contact_ssn:contact_email:sele_flag:org_flag:ult_flag:fallback_value:CONTACTNAME:STREETADDRESS
 
EXPORT KeyName := BizLinkFull.Filename_keys.Refs; /*HACK07Refs*/
SHARED h := CandidatesForKey;//The input file - distributed by proxid
SALT33.Layout_Uber_Plus IntoInversion(h le,unsigned2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT33.StrType)le.parent_proxid,(SALT33.StrType)le.sele_proxid,(SALT33.StrType)le.org_proxid,(SALT33.StrType)le.ultimate_proxid,(SALT33.StrType)le.has_lgid,(SALT33.StrType)le.empid,(SALT33.StrType)le.source,(SALT33.StrType)le.source_record_id,(SALT33.StrType)le.source_docid,Fields.Make_company_name((SALT33.StrType)le.company_name),Fields.Make_company_name_prefix((SALT33.StrType)le.company_name_prefix),'',(SALT33.StrType)le.cnp_number,(SALT33.StrType)le.cnp_btype,(SALT33.StrType)le.cnp_lowv,(SALT33.StrType)le.company_phone,(SALT33.StrType)le.company_phone_3,(SALT33.StrType)le.company_phone_3_ex,(SALT33.StrType)le.company_phone_7,(SALT33.StrType)le.company_fein,(SALT33.StrType)le.company_sic_code1,(SALT33.StrType)le.active_duns_number,(SALT33.StrType)le.prim_range,Fields.Make_prim_name((SALT33.StrType)le.prim_name),Fields.Make_sec_range((SALT33.StrType)le.sec_range),Fields.Make_city((SALT33.StrType)le.city),Fields.Make_city_clean((SALT33.StrType)le.city_clean),Fields.Make_st((SALT33.StrType)le.st),Fields.Make_zip((SALT33.StrType)le.zip),'',(SALT33.StrType)le.isContact,(SALT33.StrType)le.contact_did,(SALT33.StrType)le.title,Fields.Make_fname((SALT33.StrType)le.fname),Fields.Make_fname_preferred((SALT33.StrType)le.fname_preferred),Fields.Make_mname((SALT33.StrType)le.mname),Fields.Make_lname((SALT33.StrType)le.lname),Fields.Make_name_suffix((SALT33.StrType)le.name_suffix),(SALT33.StrType)le.contact_ssn,Fields.Make_contact_email((SALT33.StrType)le.contact_email),(SALT33.StrType)le.sele_flag,(SALT33.StrType)le.org_flag,(SALT33.StrType)le.ult_flag,(SALT33.StrType)le.fallback_value,SKIP,SKIP,SKIP);
  SELF.field := c;
  SELF.uid := le.proxid
END;
nfields_r := SALT33.Fn_Reduce_UBER_Local(NORMALIZE(h,46,IntoInversion(LEFT,COUNTER))(word<>''));
SALT33.MAC_Expand_Wordbag_Field(h,cnp_name,12,proxid,nfields12);
SALT33.MAC_Expand_Wordbag_Field(h,company_url,30,proxid,nfields30);
SALT33.MAC_Expand_Normal_Field(h,fname,45,proxid,nfields10485);
SALT33.MAC_Expand_Normal_Field(h,mname,45,proxid,nfields10486);
SALT33.MAC_Expand_Normal_Field(h,lname,45,proxid,nfields10487);
nfields45 := nfields10485+nfields10486+nfields10487;//Collect wordbags for parts of concept field
SALT33.MAC_Expand_Normal_Field(h,prim_range,46,proxid,nfields10718);
SALT33.MAC_Expand_Normal_Field(h,prim_name,46,proxid,nfields10719);
SALT33.MAC_Expand_Normal_Field(h,sec_range,46,proxid,nfields10720);
nfields46 := nfields10718+nfields10719+nfields10720;//Collect wordbags for parts of concept field
invert_records := nfields_r + nfields12 + nfields30;
shared DataForKey0 := SALT33.Fn_Reduce_UBER_Local( invert_records );
 
EXPORT ValueKeyName := BizLinkFull.Filename_keys.Words; /*HACK07Words*/
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
 
EXPORT RawFetch(TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.has_lgid) param_has_lgid = (TYPEOF(h.has_lgid))'',TYPEOF(h.empid) param_empid = (TYPEOF(h.empid))'',TYPEOF(h.source) param_source = (TYPEOF(h.source))'',TYPEOF(h.source_record_id) param_source_record_id = (TYPEOF(h.source_record_id))'',TYPEOF(h.source_docid) param_source_docid = (TYPEOF(h.source_docid))'',TYPEOF(h.company_name) param_company_name = (TYPEOF(h.company_name))'',TYPEOF(h.company_name_prefix) param_company_name_prefix = (TYPEOF(h.company_name_prefix))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',TYPEOF(h.company_phone) param_company_phone = (TYPEOF(h.company_phone))'',TYPEOF(h.company_phone_3) param_company_phone_3 = (TYPEOF(h.company_phone_3))'',TYPEOF(h.company_phone_3_ex) param_company_phone_3_ex = (TYPEOF(h.company_phone_3_ex))'',TYPEOF(h.company_phone_7) param_company_phone_7 = (TYPEOF(h.company_phone_7))'',TYPEOF(h.company_fein) param_company_fein = (TYPEOF(h.company_fein))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.active_duns_number) param_active_duns_number = (TYPEOF(h.active_duns_number))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_clean) param_city_clean = (TYPEOF(h.city_clean))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',DATASET(process_Biz_layouts.layout_zip_cases) param_zip,TYPEOF(h.company_url) param_company_url = (TYPEOF(h.company_url))'',TYPEOF(h.isContact) param_isContact = (TYPEOF(h.isContact))'',TYPEOF(h.contact_did) param_contact_did = (TYPEOF(h.contact_did))'',TYPEOF(h.title) param_title = (TYPEOF(h.title))'',TYPEOF(h.fname) param_fname = (TYPEOF(h.fname))'',TYPEOF(h.fname_preferred) param_fname_preferred = (TYPEOF(h.fname_preferred))'',TYPEOF(h.mname) param_mname = (TYPEOF(h.mname))'',TYPEOF(h.lname) param_lname = (TYPEOF(h.lname))'',TYPEOF(h.name_suffix) param_name_suffix = (TYPEOF(h.name_suffix))'',TYPEOF(h.contact_ssn) param_contact_ssn = (TYPEOF(h.contact_ssn))'',TYPEOF(h.contact_email) param_contact_email = (TYPEOF(h.contact_email))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',SALT33.StrType param_CONTACTNAME,SALT33.StrType param_STREETADDRESS,TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
  FUNCTION
 //Create wordstream from parameters
    SALT33.MAC_Field_To_UberStream(param_parent_proxid,1,ValueKey,WS1);
    SALT33.MAC_Field_To_UberStream(param_sele_proxid,2,ValueKey,WS2);
    SALT33.MAC_Field_To_UberStream(param_org_proxid,3,ValueKey,WS3);
    SALT33.MAC_Field_To_UberStream(param_ultimate_proxid,4,ValueKey,WS4);
    SALT33.MAC_Field_To_UberStream(param_has_lgid,5,ValueKey,WS5);
    SALT33.MAC_Field_To_UberStream(param_empid,6,ValueKey,WS6);
    SALT33.MAC_Field_To_UberStream(param_source,7,ValueKey,WS7);
    SALT33.MAC_Field_To_UberStream(param_source_record_id,8,ValueKey,WS8);
    SALT33.MAC_Field_To_UberStream(param_source_docid,9,ValueKey,WS9);
    SALT33.MAC_Field_To_UberStream(param_company_name,10,ValueKey,WS10);
    SALT33.MAC_Field_To_UberStream(param_company_name_prefix,11,ValueKey,WS11);
    SALT33.MAC_FieldWordBag_To_UberStream(param_cnp_name,12,ValueKey,WS12);
    SALT33.MAC_Field_To_UberStream(param_cnp_number,13,ValueKey,WS13);
    SALT33.MAC_Field_To_UberStream(param_cnp_btype,14,ValueKey,WS14);
    SALT33.MAC_Field_To_UberStream(param_cnp_lowv,15,ValueKey,WS15);
    SALT33.MAC_Field_To_UberStream(param_company_phone,16,ValueKey,WS16);
    SALT33.MAC_Field_To_UberStream(param_company_phone_3,17,ValueKey,WS17);
    SALT33.MAC_Field_To_UberStream(param_company_phone_3_ex,18,ValueKey,WS18);
    SALT33.MAC_Field_To_UberStream(param_company_phone_7,19,ValueKey,WS19);
    SALT33.MAC_Field_To_UberStream(param_company_fein,20,ValueKey,WS20);
    SALT33.MAC_Field_To_UberStream(param_company_sic_code1,21,ValueKey,WS21);
    SALT33.MAC_Field_To_UberStream(param_active_duns_number,22,ValueKey,WS22);
    SALT33.MAC_Field_To_UberStream(param_prim_range,23,ValueKey,WS23);
    SALT33.MAC_Field_To_UberStream(param_prim_name,24,ValueKey,WS24);
    SALT33.MAC_Field_To_UberStream(param_sec_range,25,ValueKey,WS25);
    SALT33.MAC_Field_To_UberStream(param_city,26,ValueKey,WS26);
    SALT33.MAC_Field_To_UberStream(param_city_clean,27,ValueKey,WS27);
    SALT33.MAC_Field_To_UberStream(param_st,28,ValueKey,WS28);
    SALT33.MAC_FieldSet_To_UberStream(SET(param_zip,zip),29,ValueKey,WS29);
    SALT33.MAC_FieldWordBag_To_UberStream(param_company_url,30,ValueKey,WS30);
    SALT33.MAC_Field_To_UberStream(param_isContact,31,ValueKey,WS31);
    SALT33.MAC_Field_To_UberStream(param_contact_did,32,ValueKey,WS32);
    SALT33.MAC_Field_To_UberStream(param_title,33,ValueKey,WS33);
    SALT33.MAC_Field_To_UberStream(param_fname,34,ValueKey,WS34);
    SALT33.MAC_Field_To_UberStream(param_fname_preferred,35,ValueKey,WS35);
    SALT33.MAC_Field_To_UberStream(param_mname,36,ValueKey,WS36);
    SALT33.MAC_Field_To_UberStream(param_lname,37,ValueKey,WS37);
    SALT33.MAC_Field_To_UberStream(param_name_suffix,38,ValueKey,WS38);
    SALT33.MAC_Field_To_UberStream(param_contact_ssn,39,ValueKey,WS39);
    SALT33.MAC_Field_To_UberStream(param_contact_email,40,ValueKey,WS40);
    SALT33.MAC_Field_To_UberStream(param_sele_flag,41,ValueKey,WS41);
    SALT33.MAC_Field_To_UberStream(param_org_flag,42,ValueKey,WS42);
    SALT33.MAC_Field_To_UberStream(param_ult_flag,43,ValueKey,WS43);
    SALT33.MAC_Field_To_UberStream(param_fallback_value,44,ValueKey,WS44);
    SALT33.MAC_Field_To_UberStream(param_CONTACTNAME,45,ValueKey,WS45);
    SALT33.MAC_Field_To_UberStream(param_STREETADDRESS,46,ValueKey,WS46);
    wds := WS1+WS2+WS3+WS4+WS5+WS6+WS7+WS8+WS9+WS10+WS11+WS12+WS13+WS14+WS15+WS16+WS17+WS18+WS19+WS20+WS21+WS22+WS23+WS24+WS25+WS26+WS27+WS28+WS29+WS30+WS31+WS32+WS33+WS34+WS35+WS36+WS37+WS38+WS39+WS40+WS41+WS42+WS43+WS44+WS45+WS46;
    SALT33.MAC_Collate_Uber_Matches(Key,Wds,steppedmatches);
    RETURN steppedmatches;
  END;
 
EXPORT ScoredproxidFetch(TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.has_lgid) param_has_lgid = (TYPEOF(h.has_lgid))'',TYPEOF(h.empid) param_empid = (TYPEOF(h.empid))'',TYPEOF(h.source) param_source = (TYPEOF(h.source))'',TYPEOF(h.source_record_id) param_source_record_id = (TYPEOF(h.source_record_id))'',TYPEOF(h.source_docid) param_source_docid = (TYPEOF(h.source_docid))'',TYPEOF(h.company_name) param_company_name = (TYPEOF(h.company_name))'',TYPEOF(h.company_name_prefix) param_company_name_prefix = (TYPEOF(h.company_name_prefix))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',TYPEOF(h.company_phone) param_company_phone = (TYPEOF(h.company_phone))'',TYPEOF(h.company_phone_3) param_company_phone_3 = (TYPEOF(h.company_phone_3))'',TYPEOF(h.company_phone_3_ex) param_company_phone_3_ex = (TYPEOF(h.company_phone_3_ex))'',TYPEOF(h.company_phone_7) param_company_phone_7 = (TYPEOF(h.company_phone_7))'',TYPEOF(h.company_fein) param_company_fein = (TYPEOF(h.company_fein))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.active_duns_number) param_active_duns_number = (TYPEOF(h.active_duns_number))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_clean) param_city_clean = (TYPEOF(h.city_clean))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',DATASET(process_Biz_layouts.layout_zip_cases) param_zip,TYPEOF(h.company_url) param_company_url = (TYPEOF(h.company_url))'',TYPEOF(h.isContact) param_isContact = (TYPEOF(h.isContact))'',TYPEOF(h.contact_did) param_contact_did = (TYPEOF(h.contact_did))'',TYPEOF(h.title) param_title = (TYPEOF(h.title))'',TYPEOF(h.fname) param_fname = (TYPEOF(h.fname))'',TYPEOF(h.fname_preferred) param_fname_preferred = (TYPEOF(h.fname_preferred))'',TYPEOF(h.mname) param_mname = (TYPEOF(h.mname))'',TYPEOF(h.lname) param_lname = (TYPEOF(h.lname))'',TYPEOF(h.name_suffix) param_name_suffix = (TYPEOF(h.name_suffix))'',TYPEOF(h.contact_ssn) param_contact_ssn = (TYPEOF(h.contact_ssn))'',TYPEOF(h.contact_email) param_contact_email = (TYPEOF(h.contact_email))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',SALT33.StrType param_CONTACTNAME,SALT33.StrType param_STREETADDRESS,TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := FUNCTION
  RawData := RawFetch(param_parent_proxid,param_sele_proxid,param_org_proxid,param_ultimate_proxid,param_has_lgid,param_empid,param_source,param_source_record_id,param_source_docid,param_company_name,param_company_name_prefix,param_cnp_name,param_cnp_number,param_cnp_btype,param_cnp_lowv,param_company_phone,param_company_phone_3,param_company_phone_3_ex,param_company_phone_7,param_company_fein,param_company_sic_code1,param_active_duns_number,param_prim_range,param_prim_name,param_sec_range,param_city,param_city_clean,param_st,param_zip,param_company_url,param_isContact,param_contact_did,param_title,param_fname,param_fname_preferred,param_mname,param_lname,param_name_suffix,param_contact_ssn,param_contact_email,param_sele_flag,param_org_flag,param_ult_flag,param_fallback_value,param_CONTACTNAME,param_STREETADDRESS,param_fallback_value);
 
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 0; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key used
    SELF.seleid := 0; // Id hierarchy does not work with uberkey
    SELF.orgid := 0; // Id hierarchy does not work with uberkey
    SELF.ultid := 0; // Id hierarchy does not work with uberkey
    SELF.powid := 0; // Id hierarchy does not work with uberkey
    SELF.proxid := le.uid;
    SELF.Weight := le.Weight; // Already rolled up in collate_uber
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(PROJECT(NOFOLD(RawData),Score(LEFT)),Process_Biz_Layouts.update_forcefailed(LEFT)),LEFT.proxid = RIGHT.proxid,Process_Biz_Layouts.combine_scores(LEFT,RIGHT));
END;
END;
