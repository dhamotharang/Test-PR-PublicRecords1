IMPORT SALT38,std;
EXPORT Key_BizHead_ := MODULE
 
//parent_proxid:ultimate_proxid:has_lgid:empid:powid:source:source_record_id:?:cnp_number:cnp_btype:cnp_lowv:cnp_name:company_phone:+:company_fein:company_sic_code1:prim_range:prim_name:sec_range:p_city_name:st:zip:company_url:isContact:title:fname:mname:lname:name_suffix:contact_email:CONTACTNAME:STREETADDRESS
EXPORT KeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Refs';
SHARED h := CandidatesForKey;//The input file - distributed by proxid
 
SHARED s := Specificities(File_BizHead).Specificities[1];
SHARED s_index := Keys(File_BizHead).Specificities_Key[1]; // Index access for MEOW queries
SHARED specMod := specificities(File_BizHead);
EXPORT Layout_Uber_Record := RECORD(SALT38.Layout_Uber_Record0)
 UNSIGNED4 EFR_BMap := 0;
END;
EXPORT Layout_Uber_Plus := RECORD(Layout_Uber_Record)
  SALT38.Str30Type word;
  UNSIGNED2 word_weight100 := 0;
END;
SHARED Fn_Reduce_Uber_Local(DATASET(Layout_Uber_Plus) in_ds) := FUNCTION
// The file need NOT be distributed at this point; it will still reduce the record count ...
  RETURN DEDUP(SORT(in_ds,uid,word,field,EFR_BMap,LOCAL),uid,word,field,EFR_BMap,LOCAL);
END;
Layout_Uber_Plus IntoInversion(h le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT38.StrType)le.parent_proxid,(SALT38.StrType)le.ultimate_proxid,(SALT38.StrType)le.has_lgid,(SALT38.StrType)le.empid,(SALT38.StrType)le.powid,(SALT38.StrType)le.source,(SALT38.StrType)le.source_record_id,(SALT38.StrType)le.cnp_number,(SALT38.StrType)le.cnp_btype,(SALT38.StrType)le.cnp_lowv,'',(SALT38.StrType)le.company_phone,Fields.Make_company_fein((SALT38.StrType)le.company_fein),(SALT38.StrType)le.company_sic_code1,(SALT38.StrType)le.prim_range,Fields.Make_prim_name((SALT38.StrType)le.prim_name),Fields.Make_sec_range((SALT38.StrType)le.sec_range),Fields.Make_p_city_name((SALT38.StrType)le.p_city_name),Fields.Make_st((SALT38.StrType)le.st),Fields.Make_zip((SALT38.StrType)le.zip),'',(SALT38.StrType)le.isContact,(SALT38.StrType)le.title,Fields.Make_fname((SALT38.StrType)le.fname),Fields.Make_mname((SALT38.StrType)le.mname),Fields.Make_lname((SALT38.StrType)le.lname),Fields.Make_name_suffix((SALT38.StrType)le.name_suffix),(SALT38.StrType)le.contact_email,SKIP,SKIP,SKIP);
  SELF.field := c;
  SELF.uid := le.proxid;
  SELF := le;
END;
nfields_r := Fn_Reduce_UBER_Local(NORMALIZE(h,30,IntoInversion(LEFT,COUNTER))(word<>''));
SALT38.MAC_Expand_Wordbag_Field(h,cnp_name,11,proxid,layout_uber_plus,nfields11);
SALT38.MAC_Expand_Wordbag_Field(h,company_url,21,proxid,layout_uber_plus,nfields21);
SALT38.MAC_Expand_Normal_Field(h,fname,29,proxid,layout_uber_plus,nfields6757);
SALT38.MAC_Expand_Normal_Field(h,mname,29,proxid,layout_uber_plus,nfields6758);
SALT38.MAC_Expand_Normal_Field(h,lname,29,proxid,layout_uber_plus,nfields6759);
nfields29 := nfields6757+nfields6758+nfields6759;//Collect wordbags for parts of concept field
SALT38.MAC_Expand_Normal_Field(h,prim_range,30,proxid,layout_uber_plus,nfields6990);
SALT38.MAC_Expand_Normal_Field(h,prim_name,30,proxid,layout_uber_plus,nfields6991);
SALT38.MAC_Expand_Normal_Field(h,sec_range,30,proxid,layout_uber_plus,nfields6992);
nfields30 := nfields6990+nfields6991+nfields6992;//Collect wordbags for parts of concept field
SHARED invert_records := nfields_r + nfields11 + nfields21;
SHARED DataForKey0 := Fn_Reduce_UBER_Local( invert_records );
SHARED DataForValueKey0 := DEDUP(SORT(DISTRIBUTE(TABLE(invert_records,{word}),HASH(word)),word,LOCAL),word,LOCAL);
 
EXPORT ValueKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Words';
SHARED word_values := specMod.uber_values_persisted;
 
EXPORT ValueKey := INDEX(word_values,{word},{word_values},ValueKeyName,OPT);
  Layout_Uber_Plus add_id(Layout_Uber_Plus le,word_values ri,BOOLEAN patch_default) := TRANSFORM
    SELF.word_id := ri.id;
    SELF := le;
  END;
  SALT38.Mac_Choose_JoinType(DataForKey0,s.nulls_uber,word_values,word,word_weight100,add_id,DataForKey1);
  DataForKey2 := Fn_Reduce_UBER_Local( DataForKey1 );
  Layout_Uber_record slim(DataForKey2 le) := TRANSFORM
    SELF := le;
  END;
  SHARED DataForKey3 := DEDUP(SORT(PROJECT(DataForKey2,slim(LEFT)),WHOLE RECORD,SKEW(1)),WHOLE RECORD);
 
EXPORT Key := INDEX(DataForKey3,{DataForKey3},{},KeyName);
 
EXPORT BuildAll := PARALLEL(BUILDINDEX(ValueKey, OVERWRITE),BUILDINDEX(Key, OVERWRITE));
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.has_lgid) param_has_lgid = (TYPEOF(h.has_lgid))'',TYPEOF(h.empid) param_empid = (TYPEOF(h.empid))'',TYPEOF(h.powid) param_powid = (TYPEOF(h.powid))'',TYPEOF(h.source) param_source = (TYPEOF(h.source))'',TYPEOF(h.source_record_id) param_source_record_id = (TYPEOF(h.source_record_id))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.company_phone) param_company_phone = (TYPEOF(h.company_phone))'',TYPEOF(h.company_fein) param_company_fein = (TYPEOF(h.company_fein))'',TYPEOF(h.company_fein_len) param_company_fein_len = (TYPEOF(h.company_fein_len))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.p_city_name) param_p_city_name = (TYPEOF(h.p_city_name))'',TYPEOF(h.p_city_name_len) param_p_city_name_len = (TYPEOF(h.p_city_name_len))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',SET OF TYPEOF(h.zip) param_zip = [],TYPEOF(h.company_url) param_company_url = (TYPEOF(h.company_url))'',TYPEOF(h.isContact) param_isContact = (TYPEOF(h.isContact))'',TYPEOF(h.title) param_title = (TYPEOF(h.title))'',TYPEOF(h.fname) param_fname = (TYPEOF(h.fname))'',TYPEOF(h.fname_len) param_fname_len = (TYPEOF(h.fname_len))'',TYPEOF(h.mname) param_mname = (TYPEOF(h.mname))'',TYPEOF(h.mname_len) param_mname_len = (TYPEOF(h.mname_len))'',TYPEOF(h.lname) param_lname = (TYPEOF(h.lname))'',TYPEOF(h.lname_len) param_lname_len = (TYPEOF(h.lname_len))'',TYPEOF(h.name_suffix) param_name_suffix = (TYPEOF(h.name_suffix))'',TYPEOF(h.contact_email) param_contact_email = (TYPEOF(h.contact_email))'',SALT38.StrType param_CONTACTNAME,TYPEOF(h.fname_len) param_fname_len = (TYPEOF(h.fname_len))'',TYPEOF(h.mname_len) param_mname_len = (TYPEOF(h.mname_len))'',TYPEOF(h.lname_len) param_lname_len = (TYPEOF(h.lname_len))'',SALT38.StrType param_STREETADDRESS,TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',UNSIGNED4 param_efr_bitmap = 0) := 
  FUNCTION
 //Create wordstream from parameters
    SALT38.MAC_Field_To_UberStream(param_parent_proxid,1,ValueKey,WS1);
    SALT38.MAC_Field_To_UberStream(param_ultimate_proxid,2,ValueKey,WS2);
    SALT38.MAC_Field_To_UberStream(param_has_lgid,3,ValueKey,WS3);
    SALT38.MAC_Field_To_UberStream(param_empid,4,ValueKey,WS4);
    SALT38.MAC_Field_To_UberStream(param_powid,5,ValueKey,WS5);
    SALT38.MAC_Field_To_UberStream(param_source,6,ValueKey,WS6);
    SALT38.MAC_Field_To_UberStream(param_source_record_id,7,ValueKey,WS7);
    SALT38.MAC_Field_To_UberStream(param_cnp_number,8,ValueKey,WS8);
    SALT38.MAC_Field_To_UberStream(param_cnp_btype,9,ValueKey,WS9);
    SALT38.MAC_Field_To_UberStream(param_cnp_lowv,10,ValueKey,WS10);
    SALT38.MAC_FieldWordBag_To_UberStream(param_cnp_name,11,ValueKey,WS11);
    SALT38.MAC_Field_To_UberStream(param_company_phone,12,ValueKey,WS12);
    SALT38.MAC_Field_To_UberStream(param_company_fein,13,ValueKey,WS13);
    SALT38.MAC_Field_To_UberStream(param_company_sic_code1,14,ValueKey,WS14);
    SALT38.MAC_Field_To_UberStream(param_prim_range,15,ValueKey,WS15);
    SALT38.MAC_Field_To_UberStream(param_prim_name,16,ValueKey,WS16);
    SALT38.MAC_Field_To_UberStream(param_sec_range,17,ValueKey,WS17);
    SALT38.MAC_Field_To_UberStream(param_p_city_name,18,ValueKey,WS18);
    SALT38.MAC_Field_To_UberStream(param_st,19,ValueKey,WS19);
    SALT38.MAC_FieldSet_To_UberStream(param_zip,20,ValueKey,WS20);
    SALT38.MAC_FieldWordBag_To_UberStream(param_company_url,21,ValueKey,WS21);
    SALT38.MAC_Field_To_UberStream(param_isContact,22,ValueKey,WS22);
    SALT38.MAC_Field_To_UberStream(param_title,23,ValueKey,WS23);
    SALT38.MAC_Field_To_UberStream(param_fname,24,ValueKey,WS24);
    SALT38.MAC_Field_To_UberStream(param_mname,25,ValueKey,WS25);
    SALT38.MAC_Field_To_UberStream(param_lname,26,ValueKey,WS26);
    SALT38.MAC_Field_To_UberStream(param_name_suffix,27,ValueKey,WS27);
    SALT38.MAC_Field_To_UberStream(param_contact_email,28,ValueKey,WS28);
    SALT38.MAC_Field_To_UberStream(param_CONTACTNAME,29,ValueKey,WS29);
    SALT38.MAC_Field_To_UberStream(param_STREETADDRESS,30,ValueKey,WS30);
    wds := WS1+WS2+WS3+WS4+WS5+WS6+WS7+WS8+WS9+WS10+WS11+WS12+WS13+WS14+WS15+WS16+WS17+WS18+WS19+WS20+WS21+WS22+WS23+WS24+WS25+WS26+WS27+WS28+WS29+WS30;
    SALT38.MAC_Collate_Uber_Matches(Key,Wds,steppedmatches,Layout_Uber_Record,,,,,,,EFR_BMap,param_EFR_bitmap);
    RETURN steppedmatches;
  END;
 
EXPORT ScoredproxidFetch(TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.has_lgid) param_has_lgid = (TYPEOF(h.has_lgid))'',TYPEOF(h.empid) param_empid = (TYPEOF(h.empid))'',TYPEOF(h.powid) param_powid = (TYPEOF(h.powid))'',TYPEOF(h.source) param_source = (TYPEOF(h.source))'',TYPEOF(h.source_record_id) param_source_record_id = (TYPEOF(h.source_record_id))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.company_phone) param_company_phone = (TYPEOF(h.company_phone))'',TYPEOF(h.company_fein) param_company_fein = (TYPEOF(h.company_fein))'',TYPEOF(h.company_fein_len) param_company_fein_len = (TYPEOF(h.company_fein_len))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.p_city_name) param_p_city_name = (TYPEOF(h.p_city_name))'',TYPEOF(h.p_city_name_len) param_p_city_name_len = (TYPEOF(h.p_city_name_len))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',SET OF TYPEOF(h.zip) param_zip = [],TYPEOF(h.company_url) param_company_url = (TYPEOF(h.company_url))'',TYPEOF(h.isContact) param_isContact = (TYPEOF(h.isContact))'',TYPEOF(h.title) param_title = (TYPEOF(h.title))'',TYPEOF(h.fname) param_fname = (TYPEOF(h.fname))'',TYPEOF(h.fname_len) param_fname_len = (TYPEOF(h.fname_len))'',TYPEOF(h.mname) param_mname = (TYPEOF(h.mname))'',TYPEOF(h.mname_len) param_mname_len = (TYPEOF(h.mname_len))'',TYPEOF(h.lname) param_lname = (TYPEOF(h.lname))'',TYPEOF(h.lname_len) param_lname_len = (TYPEOF(h.lname_len))'',TYPEOF(h.name_suffix) param_name_suffix = (TYPEOF(h.name_suffix))'',TYPEOF(h.contact_email) param_contact_email = (TYPEOF(h.contact_email))'',SALT38.StrType param_CONTACTNAME,TYPEOF(h.fname_len) param_fname_len = (TYPEOF(h.fname_len))'',TYPEOF(h.mname_len) param_mname_len = (TYPEOF(h.mname_len))'',TYPEOF(h.lname_len) param_lname_len = (TYPEOF(h.lname_len))'',SALT38.StrType param_STREETADDRESS,TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',UNSIGNED4 param_efr_bitmap = 0) := FUNCTION
  RawData := RawFetch(param_parent_proxid,param_ultimate_proxid,param_has_lgid,param_empid,param_powid,param_source,param_source_record_id,param_cnp_number,param_cnp_btype,param_cnp_lowv,param_cnp_name,param_company_phone,param_company_fein,param_company_fein_len,param_company_sic_code1,param_prim_range,param_prim_range_len,param_prim_name,param_prim_name_len,param_sec_range,param_sec_range_len,param_p_city_name,param_p_city_name_len,param_st,param_zip,param_company_url,param_isContact,param_title,param_fname,param_fname_len,param_mname,param_mname_len,param_lname,param_lname_len,param_name_suffix,param_contact_email,param_CONTACTNAME,param_fname_len,param_mname_len,param_lname_len,param_STREETADDRESS,param_prim_range_len,param_prim_name_len,param_sec_range_len,param_efr_bitmap);
 
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 0; // Set bitmap for keys used
    SELF.keys_failed := 0; // Set bitmap for keys failed
    SELF.seleid := 0; // Id hierarchy does not work with uberkey
    SELF.orgid := 0; // Id hierarchy does not work with uberkey
    SELF.ultid := 0; // Id hierarchy does not work with uberkey
    SELF.proxid := le.uid;
    SELF.Weight := le.Weight; // Already rolled up in collate_uber
    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));
  result1 := ROLLUP(result0,LEFT.proxid = RIGHT.proxid,Process_Biz_Layouts.combine_scores(LEFT,RIGHT));
  RETURN result1;
END;
END;
