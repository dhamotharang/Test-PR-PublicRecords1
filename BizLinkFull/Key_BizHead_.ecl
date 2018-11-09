IMPORT SALT37,std;
EXPORT Key_BizHead_ := MODULE
 
//parent_proxid:?:sele_proxid:org_proxid:+:ultimate_proxid:has_lgid:empid:source:source_record_id:source_docid:company_name:company_name_prefix:cnp_name:cnp_number:cnp_btype:cnp_lowv:company_phone:company_phone_3:company_phone_3_ex:company_phone_7:company_fein:company_sic_code1:active_duns_number:prim_range:prim_name:sec_range:city:city_clean:st:zip:company_url:isContact:contact_did:title:fname:fname_preferred:mname:lname:name_suffix:contact_ssn:contact_email:sele_flag:org_flag:ult_flag:fallback_value:CONTACTNAME:STREETADDRESS
EXPORT KeyName := BizLinkFull.Filename_keys.Refs; /*HACK07Refs*/
SHARED h := CandidatesForKey;//The input file - distributed by proxid
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
  SELF.word := CHOOSE(c,(SALT37.StrType)le.parent_proxid,(SALT37.StrType)le.sele_proxid,(SALT37.StrType)le.org_proxid,(SALT37.StrType)le.ultimate_proxid,(SALT37.StrType)le.has_lgid,(SALT37.StrType)le.empid,(SALT37.StrType)le.source,(SALT37.StrType)le.source_record_id,(SALT37.StrType)le.source_docid,Fields.Make_company_name((SALT37.StrType)le.company_name),Fields.Make_company_name_prefix((SALT37.StrType)le.company_name_prefix),'',(SALT37.StrType)le.cnp_number,(SALT37.StrType)le.cnp_btype,(SALT37.StrType)le.cnp_lowv,(SALT37.StrType)le.company_phone,(SALT37.StrType)le.company_phone_3,(SALT37.StrType)le.company_phone_3_ex,(SALT37.StrType)le.company_phone_7,(SALT37.StrType)le.company_fein,(SALT37.StrType)le.company_sic_code1,(SALT37.StrType)le.active_duns_number,(SALT37.StrType)le.prim_range,Fields.Make_prim_name((SALT37.StrType)le.prim_name),Fields.Make_sec_range((SALT37.StrType)le.sec_range),Fields.Make_city((SALT37.StrType)le.city),Fields.Make_city_clean((SALT37.StrType)le.city_clean),Fields.Make_st((SALT37.StrType)le.st),Fields.Make_zip((SALT37.StrType)le.zip),'',(SALT37.StrType)le.isContact,(SALT37.StrType)le.contact_did,(SALT37.StrType)le.title,Fields.Make_fname((SALT37.StrType)le.fname),Fields.Make_fname_preferred((SALT37.StrType)le.fname_preferred),Fields.Make_mname((SALT37.StrType)le.mname),Fields.Make_lname((SALT37.StrType)le.lname),Fields.Make_name_suffix((SALT37.StrType)le.name_suffix),(SALT37.StrType)le.contact_ssn,Fields.Make_contact_email((SALT37.StrType)le.contact_email),(SALT37.StrType)le.sele_flag,(SALT37.StrType)le.org_flag,(SALT37.StrType)le.ult_flag,(SALT37.StrType)le.fallback_value,SKIP,SKIP,SKIP);
  SELF.field := c;
  SELF.uid := le.proxid;
  SELF := le;
END;
nfields_r := Fn_Reduce_UBER_Local(NORMALIZE(h,46,IntoInversion(LEFT,COUNTER))(word<>''));
SALT37.MAC_Expand_Wordbag_Field(h,cnp_name,12,proxid,layout_uber_plus,nfields12);
SALT37.MAC_Expand_Wordbag_Field(h,company_url,30,proxid,layout_uber_plus,nfields30);
SALT37.MAC_Expand_Normal_Field(h,fname,45,proxid,layout_uber_plus,nfields10485);
SALT37.MAC_Expand_Normal_Field(h,mname,45,proxid,layout_uber_plus,nfields10486);
SALT37.MAC_Expand_Normal_Field(h,lname,45,proxid,layout_uber_plus,nfields10487);
nfields45 := nfields10485+nfields10486+nfields10487;//Collect wordbags for parts of concept field
SALT37.MAC_Expand_Normal_Field(h,prim_range,46,proxid,layout_uber_plus,nfields10718);
SALT37.MAC_Expand_Normal_Field(h,prim_name,46,proxid,layout_uber_plus,nfields10719);
SALT37.MAC_Expand_Normal_Field(h,sec_range,46,proxid,layout_uber_plus,nfields10720);
nfields46 := nfields10718+nfields10719+nfields10720;//Collect wordbags for parts of concept field
invert_records := nfields_r + nfields12 + nfields30;
SHARED DataForKey0 := Fn_Reduce_UBER_Local( invert_records );
 
EXPORT ValueKeyName := BizLinkFull.Filename_keys.Words; /*HACK07Words*/
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
 
EXPORT RawFetch(TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.has_lgid) param_has_lgid = (TYPEOF(h.has_lgid))'',TYPEOF(h.empid) param_empid = (TYPEOF(h.empid))'',TYPEOF(h.source) param_source = (TYPEOF(h.source))'',TYPEOF(h.source_record_id) param_source_record_id = (TYPEOF(h.source_record_id))'',TYPEOF(h.source_docid) param_source_docid = (TYPEOF(h.source_docid))'',TYPEOF(h.company_name) param_company_name = (TYPEOF(h.company_name))'',TYPEOF(h.company_name_prefix) param_company_name_prefix = (TYPEOF(h.company_name_prefix))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',TYPEOF(h.company_phone) param_company_phone = (TYPEOF(h.company_phone))'',TYPEOF(h.company_phone_3) param_company_phone_3 = (TYPEOF(h.company_phone_3))'',TYPEOF(h.company_phone_3_ex) param_company_phone_3_ex = (TYPEOF(h.company_phone_3_ex))'',TYPEOF(h.company_phone_7) param_company_phone_7 = (TYPEOF(h.company_phone_7))'',TYPEOF(h.company_fein) param_company_fein = (TYPEOF(h.company_fein))'',TYPEOF(h.company_fein_len) param_company_fein_len = (TYPEOF(h.company_fein_len))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.active_duns_number) param_active_duns_number = (TYPEOF(h.active_duns_number))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.city_clean) param_city_clean = (TYPEOF(h.city_clean))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',DATASET(process_Biz_layouts.layout_zip_cases) param_zip,TYPEOF(h.company_url) param_company_url = (TYPEOF(h.company_url))'',TYPEOF(h.isContact) param_isContact = (TYPEOF(h.isContact))'',TYPEOF(h.contact_did) param_contact_did = (TYPEOF(h.contact_did))'',TYPEOF(h.title) param_title = (TYPEOF(h.title))'',TYPEOF(h.fname) param_fname = (TYPEOF(h.fname))'',TYPEOF(h.fname_len) param_fname_len = (TYPEOF(h.fname_len))'',TYPEOF(h.fname_preferred) param_fname_preferred = (TYPEOF(h.fname_preferred))'',TYPEOF(h.mname) param_mname = (TYPEOF(h.mname))'',TYPEOF(h.mname_len) param_mname_len = (TYPEOF(h.mname_len))'',TYPEOF(h.lname) param_lname = (TYPEOF(h.lname))'',TYPEOF(h.lname_len) param_lname_len = (TYPEOF(h.lname_len))'',TYPEOF(h.name_suffix) param_name_suffix = (TYPEOF(h.name_suffix))'',TYPEOF(h.contact_ssn) param_contact_ssn = (TYPEOF(h.contact_ssn))'',TYPEOF(h.contact_email) param_contact_email = (TYPEOF(h.contact_email))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',SALT37.StrType param_CONTACTNAME,TYPEOF(h.fname_len) param_fname_len = (TYPEOF(h.fname_len))'',TYPEOF(h.mname_len) param_mname_len = (TYPEOF(h.mname_len))'',TYPEOF(h.lname_len) param_lname_len = (TYPEOF(h.lname_len))'',SALT37.StrType param_STREETADDRESS,TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'') := 
  FUNCTION
 //Create wordstream from parameters
    SALT37.MAC_Field_To_UberStream(param_parent_proxid,1,ValueKey,WS1);
    SALT37.MAC_Field_To_UberStream(param_sele_proxid,2,ValueKey,WS2);
    SALT37.MAC_Field_To_UberStream(param_org_proxid,3,ValueKey,WS3);
    SALT37.MAC_Field_To_UberStream(param_ultimate_proxid,4,ValueKey,WS4);
    SALT37.MAC_Field_To_UberStream(param_has_lgid,5,ValueKey,WS5);
    SALT37.MAC_Field_To_UberStream(param_empid,6,ValueKey,WS6);
    SALT37.MAC_Field_To_UberStream(param_source,7,ValueKey,WS7);
    SALT37.MAC_Field_To_UberStream(param_source_record_id,8,ValueKey,WS8);
    SALT37.MAC_Field_To_UberStream(param_source_docid,9,ValueKey,WS9);
    SALT37.MAC_Field_To_UberStream(param_company_name,10,ValueKey,WS10);
    SALT37.MAC_Field_To_UberStream(param_company_name_prefix,11,ValueKey,WS11);
    SALT37.MAC_FieldWordBag_To_UberStream(param_cnp_name,12,ValueKey,WS12);
    SALT37.MAC_Field_To_UberStream(param_cnp_number,13,ValueKey,WS13);
    SALT37.MAC_Field_To_UberStream(param_cnp_btype,14,ValueKey,WS14);
    SALT37.MAC_Field_To_UberStream(param_cnp_lowv,15,ValueKey,WS15);
    SALT37.MAC_Field_To_UberStream(param_company_phone,16,ValueKey,WS16);
    SALT37.MAC_Field_To_UberStream(param_company_phone_3,17,ValueKey,WS17);
    SALT37.MAC_Field_To_UberStream(param_company_phone_3_ex,18,ValueKey,WS18);
    SALT37.MAC_Field_To_UberStream(param_company_phone_7,19,ValueKey,WS19);
    SALT37.MAC_Field_To_UberStream(param_company_fein,20,ValueKey,WS20);
    SALT37.MAC_Field_To_UberStream(param_company_sic_code1,21,ValueKey,WS21);
    SALT37.MAC_Field_To_UberStream(param_active_duns_number,22,ValueKey,WS22);
    SALT37.MAC_Field_To_UberStream(param_prim_range,23,ValueKey,WS23);
    SALT37.MAC_Field_To_UberStream(param_prim_name,24,ValueKey,WS24);
    SALT37.MAC_Field_To_UberStream(param_sec_range,25,ValueKey,WS25);
    SALT37.MAC_Field_To_UberStream(param_city,26,ValueKey,WS26);
    SALT37.MAC_Field_To_UberStream(param_city_clean,27,ValueKey,WS27);
    SALT37.MAC_Field_To_UberStream(param_st,28,ValueKey,WS28);
    SALT37.MAC_FieldSet_To_UberStream(SET(param_zip,zip),29,ValueKey,WS29);
    SALT37.MAC_FieldWordBag_To_UberStream(param_company_url,30,ValueKey,WS30);
    SALT37.MAC_Field_To_UberStream(param_isContact,31,ValueKey,WS31);
    SALT37.MAC_Field_To_UberStream(param_contact_did,32,ValueKey,WS32);
    SALT37.MAC_Field_To_UberStream(param_title,33,ValueKey,WS33);
    SALT37.MAC_Field_To_UberStream(param_fname,34,ValueKey,WS34);
    SALT37.MAC_Field_To_UberStream(param_fname_preferred,35,ValueKey,WS35);
    SALT37.MAC_Field_To_UberStream(param_mname,36,ValueKey,WS36);
    SALT37.MAC_Field_To_UberStream(param_lname,37,ValueKey,WS37);
    SALT37.MAC_Field_To_UberStream(param_name_suffix,38,ValueKey,WS38);
    SALT37.MAC_Field_To_UberStream(param_contact_ssn,39,ValueKey,WS39);
    SALT37.MAC_Field_To_UberStream(param_contact_email,40,ValueKey,WS40);
    SALT37.MAC_Field_To_UberStream(param_sele_flag,41,ValueKey,WS41);
    SALT37.MAC_Field_To_UberStream(param_org_flag,42,ValueKey,WS42);
    SALT37.MAC_Field_To_UberStream(param_ult_flag,43,ValueKey,WS43);
    SALT37.MAC_Field_To_UberStream(param_fallback_value,44,ValueKey,WS44);
    SALT37.MAC_Field_To_UberStream(param_CONTACTNAME,45,ValueKey,WS45);
    SALT37.MAC_Field_To_UberStream(param_STREETADDRESS,46,ValueKey,WS46);
    wds := WS1+WS2+WS3+WS4+WS5+WS6+WS7+WS8+WS9+WS10+WS11+WS12+WS13+WS14+WS15+WS16+WS17+WS18+WS19+WS20+WS21+WS22+WS23+WS24+WS25+WS26+WS27+WS28+WS29+WS30+WS31+WS32+WS33+WS34+WS35+WS36+WS37+WS38+WS39+WS40+WS41+WS42+WS43+WS44+WS45+WS46;
    SALT37.MAC_Collate_Uber_Matches(Key,Wds,steppedmatches,Layout_Uber_Record,,,,,,,);
    RETURN steppedmatches;
  END;
 
EXPORT ScoredproxidFetch(TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.has_lgid) param_has_lgid = (TYPEOF(h.has_lgid))'',TYPEOF(h.empid) param_empid = (TYPEOF(h.empid))'',TYPEOF(h.source) param_source = (TYPEOF(h.source))'',TYPEOF(h.source_record_id) param_source_record_id = (TYPEOF(h.source_record_id))'',TYPEOF(h.source_docid) param_source_docid = (TYPEOF(h.source_docid))'',TYPEOF(h.company_name) param_company_name = (TYPEOF(h.company_name))'',TYPEOF(h.company_name_prefix) param_company_name_prefix = (TYPEOF(h.company_name_prefix))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',TYPEOF(h.company_phone) param_company_phone = (TYPEOF(h.company_phone))'',TYPEOF(h.company_phone_3) param_company_phone_3 = (TYPEOF(h.company_phone_3))'',TYPEOF(h.company_phone_3_ex) param_company_phone_3_ex = (TYPEOF(h.company_phone_3_ex))'',TYPEOF(h.company_phone_7) param_company_phone_7 = (TYPEOF(h.company_phone_7))'',TYPEOF(h.company_fein) param_company_fein = (TYPEOF(h.company_fein))'',TYPEOF(h.company_fein_len) param_company_fein_len = (TYPEOF(h.company_fein_len))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.active_duns_number) param_active_duns_number = (TYPEOF(h.active_duns_number))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.city_clean) param_city_clean = (TYPEOF(h.city_clean))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',DATASET(process_Biz_layouts.layout_zip_cases) param_zip,TYPEOF(h.company_url) param_company_url = (TYPEOF(h.company_url))'',TYPEOF(h.isContact) param_isContact = (TYPEOF(h.isContact))'',TYPEOF(h.contact_did) param_contact_did = (TYPEOF(h.contact_did))'',TYPEOF(h.title) param_title = (TYPEOF(h.title))'',TYPEOF(h.fname) param_fname = (TYPEOF(h.fname))'',TYPEOF(h.fname_len) param_fname_len = (TYPEOF(h.fname_len))'',TYPEOF(h.fname_preferred) param_fname_preferred = (TYPEOF(h.fname_preferred))'',TYPEOF(h.mname) param_mname = (TYPEOF(h.mname))'',TYPEOF(h.mname_len) param_mname_len = (TYPEOF(h.mname_len))'',TYPEOF(h.lname) param_lname = (TYPEOF(h.lname))'',TYPEOF(h.lname_len) param_lname_len = (TYPEOF(h.lname_len))'',TYPEOF(h.name_suffix) param_name_suffix = (TYPEOF(h.name_suffix))'',TYPEOF(h.contact_ssn) param_contact_ssn = (TYPEOF(h.contact_ssn))'',TYPEOF(h.contact_email) param_contact_email = (TYPEOF(h.contact_email))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',SALT37.StrType param_CONTACTNAME,TYPEOF(h.fname_len) param_fname_len = (TYPEOF(h.fname_len))'',TYPEOF(h.mname_len) param_mname_len = (TYPEOF(h.mname_len))'',TYPEOF(h.lname_len) param_lname_len = (TYPEOF(h.lname_len))'',SALT37.StrType param_STREETADDRESS,TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetch(param_parent_proxid,param_sele_proxid,param_org_proxid,param_ultimate_proxid,param_has_lgid,param_empid,param_source,param_source_record_id,param_source_docid,param_company_name,param_company_name_prefix,param_cnp_name,param_cnp_number,param_cnp_btype,param_cnp_lowv,param_company_phone,param_company_phone_3,param_company_phone_3_ex,param_company_phone_7,param_company_fein,param_company_fein_len,param_company_sic_code1,param_active_duns_number,param_prim_range,param_prim_range_len,param_prim_name,param_prim_name_len,param_sec_range,param_sec_range_len,param_city,param_city_len,param_city_clean,param_st,param_zip,param_company_url,param_isContact,param_contact_did,param_title,param_fname,param_fname_len,param_fname_preferred,param_mname,param_mname_len,param_lname,param_lname_len,param_name_suffix,param_contact_ssn,param_contact_email,param_sele_flag,param_org_flag,param_ult_flag,param_fallback_value,param_CONTACTNAME,param_fname_len,param_mname_len,param_lname_len,param_STREETADDRESS,param_prim_range_len,param_prim_name_len,param_sec_range_len);
 
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 0; // Set bitmap for keys used
    SELF.keys_failed := 0; // Set bitmap for keys failed
    SELF.seleid := 0; // Id hierarchy does not work with uberkey
    SELF.orgid := 0; // Id hierarchy does not work with uberkey
    SELF.ultid := 0; // Id hierarchy does not work with uberkey
    SELF.powid := 0; // Id hierarchy does not work with uberkey
    SELF.proxid := le.uid;
    SELF.Weight := le.Weight; // Already rolled up in collate_uber
    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));
  result1 := ROLLUP(result0,LEFT.proxid = RIGHT.proxid,Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));
  RETURN result1;
END;
END;
