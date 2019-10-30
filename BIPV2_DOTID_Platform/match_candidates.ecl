// Begin code to produce match candidates
IMPORT SALT32,ut;
EXPORT match_candidates(DATASET(layout_DOT) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := Cleave(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00(SALT_Partition<>'*'),{rcid,company_name,cnp_name,cnp_name_len,corp_legal_name,corp_legal_name_len,cnp_number,cnp_btype,cnp_lowv,cnp_translated,cnp_classid,company_fein,active_duns_number,active_enterprise_number,active_domestic_corp_key,company_bdid,company_phone,prim_range,prim_name,sec_range,st,v_city_name,zip,csz,addr1,address,isContact,title,fname,fname_len,mname,mname_len,lname,lname_len,name_suffix,contact_ssn,contact_ssn_len,contact_phone,contact_email,contact_job_title_raw,company_department,dt_first_seen,dt_last_seen,SALT_Partition,ultid,orgid,lgid3,proxid,DOTid}),HASH(DOTid));
 
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 cnp_name_pop := AVE(GROUP,IF(thin_table.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR thin_table.cnp_name = (TYPEOF(thin_table.cnp_name))'',0,100));
  REAL8 corp_legal_name_pop := AVE(GROUP,IF(thin_table.corp_legal_name  IN SET(s.nulls_corp_legal_name,corp_legal_name) OR thin_table.corp_legal_name = (TYPEOF(thin_table.corp_legal_name))'',0,100));
  REAL8 cnp_number_pop := AVE(GROUP,IF(thin_table.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR thin_table.cnp_number = (TYPEOF(thin_table.cnp_number))'',0,100));
  REAL8 cnp_btype_pop := AVE(GROUP,IF(thin_table.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR thin_table.cnp_btype = (TYPEOF(thin_table.cnp_btype))'',0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF(thin_table.company_fein  IN SET(s.nulls_company_fein,company_fein) OR thin_table.company_fein = (TYPEOF(thin_table.company_fein))'',0,100));
  REAL8 active_duns_number_pop := AVE(GROUP,IF(thin_table.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR thin_table.active_duns_number = (TYPEOF(thin_table.active_duns_number))'',0,100));
  REAL8 active_enterprise_number_pop := AVE(GROUP,IF(thin_table.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number) OR thin_table.active_enterprise_number = (TYPEOF(thin_table.active_enterprise_number))'',0,100));
  REAL8 active_domestic_corp_key_pop := AVE(GROUP,IF(thin_table.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) OR thin_table.active_domestic_corp_key = (TYPEOF(thin_table.active_domestic_corp_key))'',0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF(thin_table.prim_range  IN SET(s.nulls_prim_range,prim_range) OR thin_table.prim_range = (TYPEOF(thin_table.prim_range))'',0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF(thin_table.prim_name  IN SET(s.nulls_prim_name,prim_name) OR thin_table.prim_name = (TYPEOF(thin_table.prim_name))'',0,100));
  REAL8 sec_range_pop := AVE(GROUP,IF(thin_table.sec_range  IN SET(s.nulls_sec_range,sec_range) OR thin_table.sec_range = (TYPEOF(thin_table.sec_range))'',0,100));
  REAL8 st_pop := AVE(GROUP,IF(thin_table.st  IN SET(s.nulls_st,st) OR thin_table.st = (TYPEOF(thin_table.st))'',0,100));
  REAL8 v_city_name_pop := AVE(GROUP,IF(thin_table.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR thin_table.v_city_name = (TYPEOF(thin_table.v_city_name))'',0,100));
  REAL8 zip_pop := AVE(GROUP,IF(thin_table.zip  IN SET(s.nulls_zip,zip) OR thin_table.zip = (TYPEOF(thin_table.zip))'',0,100));
  REAL8 csz_pop := AVE(GROUP,IF((thin_table.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR thin_table.v_city_name = (TYPEOF(thin_table.v_city_name))'' AND thin_table.st  IN SET(s.nulls_st,st) OR thin_table.st = (TYPEOF(thin_table.st))'' AND thin_table.zip  IN SET(s.nulls_zip,zip) OR thin_table.zip = (TYPEOF(thin_table.zip))''),0,100));
  REAL8 addr1_pop := AVE(GROUP,IF((thin_table.prim_range  IN SET(s.nulls_prim_range,prim_range) OR thin_table.prim_range = (TYPEOF(thin_table.prim_range))'' AND thin_table.prim_name  IN SET(s.nulls_prim_name,prim_name) OR thin_table.prim_name = (TYPEOF(thin_table.prim_name))'' AND thin_table.sec_range  IN SET(s.nulls_sec_range,sec_range) OR thin_table.sec_range = (TYPEOF(thin_table.sec_range))''),0,100));
  REAL8 address_pop := AVE(GROUP,IF(((thin_table.prim_range  IN SET(s.nulls_prim_range,prim_range) OR thin_table.prim_range = (TYPEOF(thin_table.prim_range))'' AND thin_table.prim_name  IN SET(s.nulls_prim_name,prim_name) OR thin_table.prim_name = (TYPEOF(thin_table.prim_name))'' AND thin_table.sec_range  IN SET(s.nulls_sec_range,sec_range) OR thin_table.sec_range = (TYPEOF(thin_table.sec_range))'') AND (thin_table.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR thin_table.v_city_name = (TYPEOF(thin_table.v_city_name))'' AND thin_table.st  IN SET(s.nulls_st,st) OR thin_table.st = (TYPEOF(thin_table.st))'' AND thin_table.zip  IN SET(s.nulls_zip,zip) OR thin_table.zip = (TYPEOF(thin_table.zip))'')),0,100));
  REAL8 isContact_pop := AVE(GROUP,IF(thin_table.isContact  IN SET(s.nulls_isContact,isContact) OR thin_table.isContact = (TYPEOF(thin_table.isContact))'',0,100));
  REAL8 fname_pop := AVE(GROUP,IF(thin_table.fname  IN SET(s.nulls_fname,fname) OR thin_table.fname = (TYPEOF(thin_table.fname))'',0,100));
  REAL8 mname_pop := AVE(GROUP,IF(thin_table.mname  IN SET(s.nulls_mname,mname) OR thin_table.mname = (TYPEOF(thin_table.mname))'',0,100));
  REAL8 lname_pop := AVE(GROUP,IF(thin_table.lname  IN SET(s.nulls_lname,lname) OR thin_table.lname = (TYPEOF(thin_table.lname))'',0,100));
  REAL8 name_suffix_pop := AVE(GROUP,IF(thin_table.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR thin_table.name_suffix = (TYPEOF(thin_table.name_suffix))'',0,100));
  REAL8 contact_ssn_pop := AVE(GROUP,IF(thin_table.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn) OR thin_table.contact_ssn = (TYPEOF(thin_table.contact_ssn))'',0,100));
END;
EXPORT PrePropogationStats := TABLE(thin_table,PrePropCounts);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 corp_legal_name_prop := 0;
  UNSIGNED1 cnp_btype_prop := 0;
  UNSIGNED1 company_fein_prop := 0;
  UNSIGNED1 active_duns_number_prop := 0;
  UNSIGNED1 active_enterprise_number_prop := 0;
  UNSIGNED1 active_domestic_corp_key_prop := 0;
  UNSIGNED1 prim_range_prop := 0;
  UNSIGNED1 prim_name_prop := 0;
  UNSIGNED1 sec_range_prop := 0;
  UNSIGNED1 st_prop := 0;
  UNSIGNED1 v_city_name_prop := 0;
  UNSIGNED1 zip_prop := 0;
  UNSIGNED1 csz_prop := 0;
  UNSIGNED1 addr1_prop := 0;
  UNSIGNED1 address_prop := 0;
  UNSIGNED1 mname_prop := 0;
  UNSIGNED1 name_suffix_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
SHARED ForeignCorpkey_prop0 := DISTRIBUTE( Specificities(ih).ForeignCorpkey_values_persisted(Basis_cnt<10000), HASH(DOTid)); // Not guaranteed distributed by DOTid :(
 
SALT32.mac_prop_field(with_props(cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name)),cnp_name,DOTid,cnp_name_props); // For every DID find the best FULL cnp_name
SHARED ForeignCorpkey_prop1 := JOIN(ForeignCorpkey_prop0,cnp_name_props,left.DOTid=right.DOTid,LOCAL);
 
SALT32.mac_prop_field(with_props(corp_legal_name NOT IN SET(s.nulls_corp_legal_name,corp_legal_name)),corp_legal_name,DOTid,corp_legal_name_props); // For every DID find the best FULL corp_legal_name
layout_withpropvars take_corp_legal_name(with_props le,corp_legal_name_props ri) := TRANSFORM
  SELF.corp_legal_name := IF ( le.corp_legal_name IN SET(s.nulls_corp_legal_name,corp_legal_name) and ri.DOTid<>(TYPEOF(ri.DOTid))'', ri.corp_legal_name, le.corp_legal_name );
  SELF.corp_legal_name_prop := le.corp_legal_name_prop + IF ( le.corp_legal_name IN SET(s.nulls_corp_legal_name,corp_legal_name) and ri.corp_legal_name NOT IN SET(s.nulls_corp_legal_name,corp_legal_name) and ri.DOTid<>(TYPEOF(ri.DOTid))'', 1, 0 ); // <>0 => propogation
  SELF.corp_legal_name_len := IF ( le.corp_legal_name IN SET(s.nulls_corp_legal_name,corp_legal_name) and ri.DOTid<>(TYPEOF(ri.DOTid))'', LENGTH(TRIM(ri.corp_legal_name)), le.corp_legal_name_len );
  SELF := le;
  END;
SHARED pj2 := JOIN(with_props,corp_legal_name_props,left.DOTid=right.DOTid,take_corp_legal_name(left,right),LEFT OUTER,HASH);
SHARED ForeignCorpkey_prop2 := JOIN(ForeignCorpkey_prop1,corp_legal_name_props,left.DOTid=right.DOTid,LEFT OUTER,LOCAL);
 
SALT32.mac_prop_field(with_props(cnp_number NOT IN SET(s.nulls_cnp_number,cnp_number)),cnp_number,DOTid,cnp_number_props); // For every DID find the best FULL cnp_number
SHARED ForeignCorpkey_prop3 := JOIN(ForeignCorpkey_prop2,cnp_number_props,left.DOTid=right.DOTid,LEFT OUTER,LOCAL);
 
SALT32.mac_prop_field(with_props(cnp_btype NOT IN SET(s.nulls_cnp_btype,cnp_btype)),cnp_btype,DOTid,cnp_btype_props); // For every DID find the best FULL cnp_btype
layout_withpropvars take_cnp_btype(with_props le,cnp_btype_props ri) := TRANSFORM
  SELF.cnp_btype := IF ( le.cnp_btype IN SET(s.nulls_cnp_btype,cnp_btype) and ri.DOTid<>(TYPEOF(ri.DOTid))'', ri.cnp_btype, le.cnp_btype );
  SELF.cnp_btype_prop := le.cnp_btype_prop + IF ( le.cnp_btype IN SET(s.nulls_cnp_btype,cnp_btype) and ri.cnp_btype NOT IN SET(s.nulls_cnp_btype,cnp_btype) and ri.DOTid<>(TYPEOF(ri.DOTid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj4 := JOIN(pj2,cnp_btype_props,left.DOTid=right.DOTid,take_cnp_btype(left,right),LEFT OUTER,HASH);
 
SALT32.mac_prop_field(with_props(company_fein NOT IN SET(s.nulls_company_fein,company_fein)),company_fein,DOTid,company_fein_props); // For every DID find the best FULL company_fein
layout_withpropvars take_company_fein(with_props le,company_fein_props ri) := TRANSFORM
  SELF.company_fein := IF ( le.company_fein IN SET(s.nulls_company_fein,company_fein) and ri.DOTid<>(TYPEOF(ri.DOTid))'', ri.company_fein, le.company_fein );
  SELF.company_fein_prop := le.company_fein_prop + IF ( le.company_fein IN SET(s.nulls_company_fein,company_fein) and ri.company_fein NOT IN SET(s.nulls_company_fein,company_fein) and ri.DOTid<>(TYPEOF(ri.DOTid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj8 := JOIN(pj4,company_fein_props,left.DOTid=right.DOTid,take_company_fein(left,right),LEFT OUTER,HASH);
SHARED ForeignCorpkey_prop4 := JOIN(ForeignCorpkey_prop3,company_fein_props,left.DOTid=right.DOTid,LEFT OUTER,LOCAL);
 
SALT32.mac_prop_field(with_props(active_duns_number NOT IN SET(s.nulls_active_duns_number,active_duns_number)),active_duns_number,DOTid,active_duns_number_props); // For every DID find the best FULL active_duns_number
layout_withpropvars take_active_duns_number(with_props le,active_duns_number_props ri) := TRANSFORM
  SELF.active_duns_number := IF ( le.active_duns_number IN SET(s.nulls_active_duns_number,active_duns_number) and ri.DOTid<>(TYPEOF(ri.DOTid))'', ri.active_duns_number, le.active_duns_number );
  SELF.active_duns_number_prop := le.active_duns_number_prop + IF ( le.active_duns_number IN SET(s.nulls_active_duns_number,active_duns_number) and ri.active_duns_number NOT IN SET(s.nulls_active_duns_number,active_duns_number) and ri.DOTid<>(TYPEOF(ri.DOTid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj9 := JOIN(pj8,active_duns_number_props,left.DOTid=right.DOTid,take_active_duns_number(left,right),LEFT OUTER,HASH);
 
SALT32.mac_prop_field(with_props(active_enterprise_number NOT IN SET(s.nulls_active_enterprise_number,active_enterprise_number)),active_enterprise_number,DOTid,active_enterprise_number_props); // For every DID find the best FULL active_enterprise_number
layout_withpropvars take_active_enterprise_number(with_props le,active_enterprise_number_props ri) := TRANSFORM
  SELF.active_enterprise_number := IF ( le.active_enterprise_number IN SET(s.nulls_active_enterprise_number,active_enterprise_number) and ri.DOTid<>(TYPEOF(ri.DOTid))'', ri.active_enterprise_number, le.active_enterprise_number );
  SELF.active_enterprise_number_prop := le.active_enterprise_number_prop + IF ( le.active_enterprise_number IN SET(s.nulls_active_enterprise_number,active_enterprise_number) and ri.active_enterprise_number NOT IN SET(s.nulls_active_enterprise_number,active_enterprise_number) and ri.DOTid<>(TYPEOF(ri.DOTid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj10 := JOIN(pj9,active_enterprise_number_props,left.DOTid=right.DOTid,take_active_enterprise_number(left,right),LEFT OUTER,HASH);
SHARED ForeignCorpkey_prop5 := JOIN(ForeignCorpkey_prop4,active_enterprise_number_props,left.DOTid=right.DOTid,LEFT OUTER,LOCAL);
 
SALT32.mac_prop_field(with_props(active_domestic_corp_key NOT IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key)),active_domestic_corp_key,DOTid,active_domestic_corp_key_props); // For every DID find the best FULL active_domestic_corp_key
layout_withpropvars take_active_domestic_corp_key(with_props le,active_domestic_corp_key_props ri) := TRANSFORM
  SELF.active_domestic_corp_key := IF ( le.active_domestic_corp_key IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) and ri.DOTid<>(TYPEOF(ri.DOTid))'', ri.active_domestic_corp_key, le.active_domestic_corp_key );
  SELF.active_domestic_corp_key_prop := le.active_domestic_corp_key_prop + IF ( le.active_domestic_corp_key IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) and ri.active_domestic_corp_key NOT IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) and ri.DOTid<>(TYPEOF(ri.DOTid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj11 := JOIN(pj10,active_domestic_corp_key_props,left.DOTid=right.DOTid,take_active_domestic_corp_key(left,right),LEFT OUTER,HASH);
SHARED ForeignCorpkey_prop6 := JOIN(ForeignCorpkey_prop5,active_domestic_corp_key_props,left.DOTid=right.DOTid,LEFT OUTER,LOCAL);
 
SALT32.mac_prop_field(with_props(prim_range NOT IN SET(s.nulls_prim_range,prim_range)),prim_range,DOTid,prim_range_props); // For every DID find the best FULL prim_range
layout_withpropvars take_prim_range(with_props le,prim_range_props ri) := TRANSFORM
  SELF.prim_range := IF ( le.prim_range IN SET(s.nulls_prim_range,prim_range) and ri.DOTid<>(TYPEOF(ri.DOTid))'', ri.prim_range, le.prim_range );
  SELF.prim_range_prop := le.prim_range_prop + IF ( le.prim_range IN SET(s.nulls_prim_range,prim_range) and ri.prim_range NOT IN SET(s.nulls_prim_range,prim_range) and ri.DOTid<>(TYPEOF(ri.DOTid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj14 := JOIN(pj11,prim_range_props,left.DOTid=right.DOTid,take_prim_range(left,right),LEFT OUTER,HASH);
SHARED ForeignCorpkey_prop7 := JOIN(ForeignCorpkey_prop6,prim_range_props,left.DOTid=right.DOTid,LEFT OUTER,LOCAL);
 
SALT32.mac_prop_field(with_props(prim_name NOT IN SET(s.nulls_prim_name,prim_name)),prim_name,DOTid,prim_name_props); // For every DID find the best FULL prim_name
layout_withpropvars take_prim_name(with_props le,prim_name_props ri) := TRANSFORM
  SELF.prim_name := IF ( le.prim_name IN SET(s.nulls_prim_name,prim_name) and ri.DOTid<>(TYPEOF(ri.DOTid))'', ri.prim_name, le.prim_name );
  SELF.prim_name_prop := le.prim_name_prop + IF ( le.prim_name IN SET(s.nulls_prim_name,prim_name) and ri.prim_name NOT IN SET(s.nulls_prim_name,prim_name) and ri.DOTid<>(TYPEOF(ri.DOTid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj15 := JOIN(pj14,prim_name_props,left.DOTid=right.DOTid,take_prim_name(left,right),LEFT OUTER,HASH);
SHARED ForeignCorpkey_prop8 := JOIN(ForeignCorpkey_prop7,prim_name_props,left.DOTid=right.DOTid,LOCAL);
 
SALT32.mac_prop_field(with_props(sec_range NOT IN SET(s.nulls_sec_range,sec_range)),sec_range,DOTid,sec_range_props); // For every DID find the best FULL sec_range
layout_withpropvars take_sec_range(with_props le,sec_range_props ri) := TRANSFORM
  SELF.sec_range := IF ( le.sec_range IN SET(s.nulls_sec_range,sec_range) and ri.DOTid<>(TYPEOF(ri.DOTid))'', ri.sec_range, le.sec_range );
  SELF.sec_range_prop := le.sec_range_prop + IF ( le.sec_range IN SET(s.nulls_sec_range,sec_range) and ri.sec_range NOT IN SET(s.nulls_sec_range,sec_range) and ri.DOTid<>(TYPEOF(ri.DOTid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj16 := JOIN(pj15,sec_range_props,left.DOTid=right.DOTid,take_sec_range(left,right),LEFT OUTER,HASH);
SHARED ForeignCorpkey_prop9 := JOIN(ForeignCorpkey_prop8,sec_range_props,left.DOTid=right.DOTid,LEFT OUTER,LOCAL);
 
SALT32.mac_prop_field(with_props(st NOT IN SET(s.nulls_st,st)),st,DOTid,st_props); // For every DID find the best FULL st
SHARED ForeignCorpkey_prop10 := JOIN(ForeignCorpkey_prop9,st_props,left.DOTid=right.DOTid,LOCAL);
 
SALT32.mac_prop_field(with_props(isContact NOT IN SET(s.nulls_isContact,isContact)),isContact,DOTid,isContact_props); // For every DID find the best FULL isContact
SHARED ForeignCorpkey_prop11 := JOIN(ForeignCorpkey_prop10,isContact_props,left.DOTid=right.DOTid,LEFT OUTER,LOCAL);
 
SALT32.mac_prop_field_init(with_props(fname NOT IN SET(s.nulls_fname,fname)),fname,DOTid,fname_props); // For every DID find the best FULL fname
SHARED ForeignCorpkey_prop12 := JOIN(ForeignCorpkey_prop11,fname_props,left.DOTid=right.DOTid,LOCAL);
 
SALT32.mac_prop_field_init(with_props(mname NOT IN SET(s.nulls_mname,mname)),mname,DOTid,mname_props); // For every DID find the best FULL mname
layout_withpropvars take_mname(with_props le,mname_props ri) := TRANSFORM
  SELF.mname := IF ( le.mname = ri.mname[1..LENGTH(TRIM(le.mname))], ri.mname, le.mname );
  SELF.mname_prop := IF ( LENGTH(TRIM(le.mname)) < LENGTH(TRIM(ri.mname)) and le.mname=ri.mname[1..LENGTH(TRIM(le.mname))],LENGTH(TRIM(ri.mname)) - LENGTH(TRIM(le.mname)) , le.mname_prop ); // Store the amount propogated
  SELF.mname_len := IF ( le.mname = ri.mname[1..LENGTH(TRIM(le.mname))], LENGTH(TRIM(ri.mname)), le.mname_len );
  SELF := le;
  END;
SHARED pj26 := JOIN(pj16,mname_props,left.DOTid=right.DOTid AND (left.mname='' OR left.mname[1]=right.mname[1]),take_mname(left,right),LEFT OUTER,HASH);
SHARED ForeignCorpkey_prop13 := JOIN(ForeignCorpkey_prop12,mname_props,left.DOTid=right.DOTid,LEFT OUTER,LOCAL);
 
SALT32.mac_prop_field(with_props(lname NOT IN SET(s.nulls_lname,lname)),lname,DOTid,lname_props); // For every DID find the best FULL lname
SHARED ForeignCorpkey_prop14 := JOIN(ForeignCorpkey_prop13,lname_props,left.DOTid=right.DOTid,LOCAL);
 
SALT32.mac_prop_field(with_props(name_suffix NOT IN SET(s.nulls_name_suffix,name_suffix)),name_suffix,DOTid,name_suffix_props); // For every DID find the best FULL name_suffix
layout_withpropvars take_name_suffix(with_props le,name_suffix_props ri) := TRANSFORM
  SELF.name_suffix := IF ( le.name_suffix IN SET(s.nulls_name_suffix,name_suffix) and ri.DOTid<>(TYPEOF(ri.DOTid))'', ri.name_suffix, le.name_suffix );
  SELF.name_suffix_prop := le.name_suffix_prop + IF ( le.name_suffix IN SET(s.nulls_name_suffix,name_suffix) and ri.name_suffix NOT IN SET(s.nulls_name_suffix,name_suffix) and ri.DOTid<>(TYPEOF(ri.DOTid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj28 := JOIN(pj26,name_suffix_props,left.DOTid=right.DOTid,take_name_suffix(left,right),LEFT OUTER,HASH);
SHARED ForeignCorpkey_prop15 := JOIN(ForeignCorpkey_prop14,name_suffix_props,left.DOTid=right.DOTid,LEFT OUTER,LOCAL);
SHARED ForeignCorpkey_prp := ForeignCorpkey_prop15;
 
pj28 do_computes(pj28 le) := TRANSFORM
  SELF.csz := IF (Fields.InValid_csz((SALT32.StrType)le.v_city_name,(SALT32.StrType)le.st,(SALT32.StrType)le.zip),0,HASH32((SALT32.StrType)le.v_city_name,(SALT32.StrType)le.st,(SALT32.StrType)le.zip)); // Combine child fields into 1 for specificity counting
  SELF.addr1 := IF (Fields.InValid_addr1((SALT32.StrType)le.prim_range,(SALT32.StrType)le.prim_name,(SALT32.StrType)le.sec_range),0,HASH32((SALT32.StrType)le.prim_range,(SALT32.StrType)le.prim_name,(SALT32.StrType)le.sec_range)); // Combine child fields into 1 for specificity counting
  SELF.addr1_prop := IF( le.prim_range_prop > 0, 1, 0 ) + IF( le.prim_name_prop > 0, 2, 0 ) + IF( le.sec_range_prop > 0, 4, 0 );
  SELF.address := IF (Fields.InValid_address((SALT32.StrType)SELF.addr1,(SALT32.StrType)SELF.csz),0,HASH32((SALT32.StrType)SELF.addr1,(SALT32.StrType)SELF.csz)); // Combine child fields into 1 for specificity counting
  SELF.address_prop := IF( SELF.addr1_prop > 0, 1, 0 );
  SELF := le;
END;
SHARED propogated := PROJECT(pj28,do_computes(left)) : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::mc_props::DOT',EXPIRE(Config.PersistExpire)); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 cnp_name_pop := AVE(GROUP,IF(propogated.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR propogated.cnp_name = (TYPEOF(propogated.cnp_name))'',0,100));
  REAL8 corp_legal_name_pop := AVE(GROUP,IF(propogated.corp_legal_name  IN SET(s.nulls_corp_legal_name,corp_legal_name) OR propogated.corp_legal_name = (TYPEOF(propogated.corp_legal_name))'',0,100));
  REAL8 cnp_number_pop := AVE(GROUP,IF(propogated.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR propogated.cnp_number = (TYPEOF(propogated.cnp_number))'',0,100));
  REAL8 cnp_btype_pop := AVE(GROUP,IF(propogated.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR propogated.cnp_btype = (TYPEOF(propogated.cnp_btype))'',0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF(propogated.company_fein  IN SET(s.nulls_company_fein,company_fein) OR propogated.company_fein = (TYPEOF(propogated.company_fein))'',0,100));
  REAL8 active_duns_number_pop := AVE(GROUP,IF(propogated.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR propogated.active_duns_number = (TYPEOF(propogated.active_duns_number))'',0,100));
  REAL8 active_enterprise_number_pop := AVE(GROUP,IF(propogated.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number) OR propogated.active_enterprise_number = (TYPEOF(propogated.active_enterprise_number))'',0,100));
  REAL8 active_domestic_corp_key_pop := AVE(GROUP,IF(propogated.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) OR propogated.active_domestic_corp_key = (TYPEOF(propogated.active_domestic_corp_key))'',0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF(propogated.prim_range  IN SET(s.nulls_prim_range,prim_range) OR propogated.prim_range = (TYPEOF(propogated.prim_range))'',0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF(propogated.prim_name  IN SET(s.nulls_prim_name,prim_name) OR propogated.prim_name = (TYPEOF(propogated.prim_name))'',0,100));
  REAL8 sec_range_pop := AVE(GROUP,IF(propogated.sec_range  IN SET(s.nulls_sec_range,sec_range) OR propogated.sec_range = (TYPEOF(propogated.sec_range))'',0,100));
  REAL8 st_pop := AVE(GROUP,IF(propogated.st  IN SET(s.nulls_st,st) OR propogated.st = (TYPEOF(propogated.st))'',0,100));
  REAL8 v_city_name_pop := AVE(GROUP,IF(propogated.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR propogated.v_city_name = (TYPEOF(propogated.v_city_name))'',0,100));
  REAL8 zip_pop := AVE(GROUP,IF(propogated.zip  IN SET(s.nulls_zip,zip) OR propogated.zip = (TYPEOF(propogated.zip))'',0,100));
  REAL8 csz_pop := AVE(GROUP,IF((propogated.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR propogated.v_city_name = (TYPEOF(propogated.v_city_name))'' AND propogated.st  IN SET(s.nulls_st,st) OR propogated.st = (TYPEOF(propogated.st))'' AND propogated.zip  IN SET(s.nulls_zip,zip) OR propogated.zip = (TYPEOF(propogated.zip))''),0,100));
  REAL8 addr1_pop := AVE(GROUP,IF((propogated.prim_range  IN SET(s.nulls_prim_range,prim_range) OR propogated.prim_range = (TYPEOF(propogated.prim_range))'' AND propogated.prim_name  IN SET(s.nulls_prim_name,prim_name) OR propogated.prim_name = (TYPEOF(propogated.prim_name))'' AND propogated.sec_range  IN SET(s.nulls_sec_range,sec_range) OR propogated.sec_range = (TYPEOF(propogated.sec_range))''),0,100));
  REAL8 address_pop := AVE(GROUP,IF(((propogated.prim_range  IN SET(s.nulls_prim_range,prim_range) OR propogated.prim_range = (TYPEOF(propogated.prim_range))'' AND propogated.prim_name  IN SET(s.nulls_prim_name,prim_name) OR propogated.prim_name = (TYPEOF(propogated.prim_name))'' AND propogated.sec_range  IN SET(s.nulls_sec_range,sec_range) OR propogated.sec_range = (TYPEOF(propogated.sec_range))'') AND (propogated.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR propogated.v_city_name = (TYPEOF(propogated.v_city_name))'' AND propogated.st  IN SET(s.nulls_st,st) OR propogated.st = (TYPEOF(propogated.st))'' AND propogated.zip  IN SET(s.nulls_zip,zip) OR propogated.zip = (TYPEOF(propogated.zip))'')),0,100));
  REAL8 isContact_pop := AVE(GROUP,IF(propogated.isContact  IN SET(s.nulls_isContact,isContact) OR propogated.isContact = (TYPEOF(propogated.isContact))'',0,100));
  REAL8 fname_pop := AVE(GROUP,IF(propogated.fname  IN SET(s.nulls_fname,fname) OR propogated.fname = (TYPEOF(propogated.fname))'',0,100));
  REAL8 mname_pop := AVE(GROUP,IF(propogated.mname  IN SET(s.nulls_mname,mname) OR propogated.mname = (TYPEOF(propogated.mname))'',0,100));
  REAL8 lname_pop := AVE(GROUP,IF(propogated.lname  IN SET(s.nulls_lname,lname) OR propogated.lname = (TYPEOF(propogated.lname))'',0,100));
  REAL8 name_suffix_pop := AVE(GROUP,IF(propogated.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR propogated.name_suffix = (TYPEOF(propogated.name_suffix))'',0,100));
  REAL8 contact_ssn_pop := AVE(GROUP,IF(propogated.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn) OR propogated.contact_ssn = (TYPEOF(propogated.contact_ssn))'',0,100));
END;
EXPORT PostPropogationStats := TABLE(propogated,PostPropCounts);
  Grpd := GROUP( DISTRIBUTE( TABLE( propogated, { propogated, UNSIGNED2 Buddies := 0 }),HASH(DOTid)),cnp_name,corp_legal_name,cnp_number,cnp_btype,company_fein,active_duns_number,active_enterprise_number,active_domestic_corp_key,prim_range,prim_name,sec_range,st,v_city_name,zip,isContact,fname,mname,lname,name_suffix,contact_ssn,dt_first_seen,dt_last_seen);
  Grpd Tr(Grpd le, Grpd ri) := TRANSFORM
    SELF.Buddies := le.Buddies+1;
    SELF := le;
  END;
SHARED h0 := UNGROUP(ROLLUP(Grpd,TRUE,Tr(LEFT,RIGHT)));// Only one copy of each record
 
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT32.UIDType DOTid1;
  SALT32.UIDType DOTid2;
  SALT32.UIDType rcid1 := 0;
  SALT32.UIDType rcid2 := 0;
END;
EXPORT Layout_Attribute_Matches := RECORD(layout_matches),MAXLENGTH(32000)
  SALT32.StrType source_id;
END;
EXPORT Layout_ForeignCorpkey_Candidates := RECORD
  {ForeignCorpkey_prp} AND NOT [corp_legal_name];
  INTEGER2 cnp_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_name_isnull := ForeignCorpkey_prp.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR ForeignCorpkey_prp.cnp_name = (TYPEOF(ForeignCorpkey_prp.cnp_name))''; // Simplify later processing 
  UNSIGNED cnp_name_cnt := 0; // Number of instances with this particular field value
  UNSIGNED cnp_name_e1_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED1 cnp_name_len := LENGTH(TRIM(ForeignCorpkey_prp.cnp_name));
  STRING500 corp_legal_name := ForeignCorpkey_prp.corp_legal_name; // Expanded wordbag field
  INTEGER2 corp_legal_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_legal_name_isnull := ForeignCorpkey_prp.corp_legal_name  IN SET(s.nulls_corp_legal_name,corp_legal_name) OR ForeignCorpkey_prp.corp_legal_name = (TYPEOF(ForeignCorpkey_prp.corp_legal_name))''; // Simplify later processing 
  UNSIGNED1 corp_legal_name_len := LENGTH(TRIM(ForeignCorpkey_prp.corp_legal_name));
  INTEGER2 cnp_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_number_isnull := ForeignCorpkey_prp.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR ForeignCorpkey_prp.cnp_number = (TYPEOF(ForeignCorpkey_prp.cnp_number))''; // Simplify later processing 
  INTEGER2 company_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_fein_isnull := ForeignCorpkey_prp.company_fein  IN SET(s.nulls_company_fein,company_fein) OR ForeignCorpkey_prp.company_fein = (TYPEOF(ForeignCorpkey_prp.company_fein))''; // Simplify later processing 
  INTEGER2 active_enterprise_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_enterprise_number_isnull := ForeignCorpkey_prp.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number) OR ForeignCorpkey_prp.active_enterprise_number = (TYPEOF(ForeignCorpkey_prp.active_enterprise_number))''; // Simplify later processing 
  INTEGER2 active_domestic_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_domestic_corp_key_isnull := ForeignCorpkey_prp.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) OR ForeignCorpkey_prp.active_domestic_corp_key = (TYPEOF(ForeignCorpkey_prp.active_domestic_corp_key))''; // Simplify later processing 
  INTEGER2 prim_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_isnull := ForeignCorpkey_prp.prim_range  IN SET(s.nulls_prim_range,prim_range) OR ForeignCorpkey_prp.prim_range = (TYPEOF(ForeignCorpkey_prp.prim_range))''; // Simplify later processing 
  INTEGER2 prim_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_isnull := ForeignCorpkey_prp.prim_name  IN SET(s.nulls_prim_name,prim_name) OR ForeignCorpkey_prp.prim_name = (TYPEOF(ForeignCorpkey_prp.prim_name))''; // Simplify later processing 
  INTEGER2 sec_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sec_range_isnull := ForeignCorpkey_prp.sec_range  IN SET(s.nulls_sec_range,sec_range) OR ForeignCorpkey_prp.sec_range = (TYPEOF(ForeignCorpkey_prp.sec_range))''; // Simplify later processing 
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := ForeignCorpkey_prp.st  IN SET(s.nulls_st,st) OR ForeignCorpkey_prp.st = (TYPEOF(ForeignCorpkey_prp.st))''; // Simplify later processing 
  INTEGER2 isContact_weight100 := 0; // Contains 100x the specificity
  BOOLEAN isContact_isnull := ForeignCorpkey_prp.isContact  IN SET(s.nulls_isContact,isContact) OR ForeignCorpkey_prp.isContact = (TYPEOF(ForeignCorpkey_prp.isContact))''; // Simplify later processing 
  INTEGER2 fname_weight100 := 0; // Contains 100x the specificity
  INTEGER2 fname_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN fname_isnull := ForeignCorpkey_prp.fname  IN SET(s.nulls_fname,fname) OR ForeignCorpkey_prp.fname = (TYPEOF(ForeignCorpkey_prp.fname))''; // Simplify later processing 
  UNSIGNED fname_cnt := 0; // Number of instances with this particular field value
  UNSIGNED fname_e1_cnt := 0; // Number of names instances matching this one by edit distance
  STRING20 fname_PreferredName := (STRING20)'';
  UNSIGNED fname_PreferredName_cnt := 0; // Number of names instances matching this one using PreferredName
  UNSIGNED1 fname_len := LENGTH(TRIM(ForeignCorpkey_prp.fname));
  INTEGER2 mname_weight100 := 0; // Contains 100x the specificity
  INTEGER2 mname_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN mname_isnull := ForeignCorpkey_prp.mname  IN SET(s.nulls_mname,mname) OR ForeignCorpkey_prp.mname = (TYPEOF(ForeignCorpkey_prp.mname))''; // Simplify later processing 
  UNSIGNED mname_cnt := 0; // Number of instances with this particular field value
  UNSIGNED mname_e1_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED1 mname_len := LENGTH(TRIM(ForeignCorpkey_prp.mname));
  INTEGER2 lname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN lname_isnull := ForeignCorpkey_prp.lname  IN SET(s.nulls_lname,lname) OR ForeignCorpkey_prp.lname = (TYPEOF(ForeignCorpkey_prp.lname))''; // Simplify later processing 
  UNSIGNED lname_cnt := 0; // Number of instances with this particular field value
  UNSIGNED lname_e1_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED1 lname_len := LENGTH(TRIM(ForeignCorpkey_prp.lname));
  INTEGER2 name_suffix_weight100 := 0; // Contains 100x the specificity
  BOOLEAN name_suffix_isnull := ForeignCorpkey_prp.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR ForeignCorpkey_prp.name_suffix = (TYPEOF(ForeignCorpkey_prp.name_suffix))''; // Simplify later processing 
  UNSIGNED name_suffix_cnt := 0; // Number of instances with this particular field value
  STRING5 name_suffix_NormSuffix := (STRING5)'';
  UNSIGNED name_suffix_NormSuffix_cnt := 0; // Number of names instances matching this one using NormSuffix
END;
SHARED ForeignCorpkey_pp := TABLE(ForeignCorpkey_prp,Layout_ForeignCorpkey_Candidates);
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0} AND NOT [corp_legal_name]; // remove wordbag fields which need to be expanded
  INTEGER2 cnp_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_name_isnull := h0.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR h0.cnp_name = (TYPEOF(h0.cnp_name))''; // Simplify later processing 
  UNSIGNED cnp_name_cnt := 0; // Number of instances with this particular field value
  UNSIGNED cnp_name_e1_cnt := 0; // Number of names instances matching this one by edit distance
  STRING500 corp_legal_name := h0.corp_legal_name; // Expanded wordbag field
  INTEGER2 corp_legal_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_legal_name_isnull := h0.corp_legal_name  IN SET(s.nulls_corp_legal_name,corp_legal_name) OR h0.corp_legal_name = (TYPEOF(h0.corp_legal_name))''; // Simplify later processing 
  INTEGER2 cnp_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_number_isnull := h0.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR h0.cnp_number = (TYPEOF(h0.cnp_number))''; // Simplify later processing 
  INTEGER2 cnp_btype_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_btype_isnull := h0.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR h0.cnp_btype = (TYPEOF(h0.cnp_btype))''; // Simplify later processing 
  INTEGER2 company_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_fein_isnull := h0.company_fein  IN SET(s.nulls_company_fein,company_fein) OR h0.company_fein = (TYPEOF(h0.company_fein))''; // Simplify later processing 
  INTEGER2 active_duns_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_duns_number_isnull := h0.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR h0.active_duns_number = (TYPEOF(h0.active_duns_number))''; // Simplify later processing 
  INTEGER2 active_enterprise_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_enterprise_number_isnull := h0.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number) OR h0.active_enterprise_number = (TYPEOF(h0.active_enterprise_number))''; // Simplify later processing 
  INTEGER2 active_domestic_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_domestic_corp_key_isnull := h0.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) OR h0.active_domestic_corp_key = (TYPEOF(h0.active_domestic_corp_key))''; // Simplify later processing 
  INTEGER2 prim_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_isnull := h0.prim_range  IN SET(s.nulls_prim_range,prim_range) OR h0.prim_range = (TYPEOF(h0.prim_range))''; // Simplify later processing 
  INTEGER2 prim_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_isnull := h0.prim_name  IN SET(s.nulls_prim_name,prim_name) OR h0.prim_name = (TYPEOF(h0.prim_name))''; // Simplify later processing 
  INTEGER2 sec_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sec_range_isnull := h0.sec_range  IN SET(s.nulls_sec_range,sec_range) OR h0.sec_range = (TYPEOF(h0.sec_range))''; // Simplify later processing 
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := h0.st  IN SET(s.nulls_st,st) OR h0.st = (TYPEOF(h0.st))''; // Simplify later processing 
  INTEGER2 v_city_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN v_city_name_isnull := h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR h0.v_city_name = (TYPEOF(h0.v_city_name))''; // Simplify later processing 
  INTEGER2 zip_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip_isnull := h0.zip  IN SET(s.nulls_zip,zip) OR h0.zip = (TYPEOF(h0.zip))''; // Simplify later processing 
  INTEGER2 csz_weight100 := 0; // Contains 100x the specificity
  BOOLEAN csz_isnull := (h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR h0.v_city_name = (TYPEOF(h0.v_city_name))'' AND h0.st  IN SET(s.nulls_st,st) OR h0.st = (TYPEOF(h0.st))'' AND h0.zip  IN SET(s.nulls_zip,zip) OR h0.zip = (TYPEOF(h0.zip))''); // Simplify later processing 
  INTEGER2 addr1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN addr1_isnull := (h0.prim_range  IN SET(s.nulls_prim_range,prim_range) OR h0.prim_range = (TYPEOF(h0.prim_range))'' AND h0.prim_name  IN SET(s.nulls_prim_name,prim_name) OR h0.prim_name = (TYPEOF(h0.prim_name))'' AND h0.sec_range  IN SET(s.nulls_sec_range,sec_range) OR h0.sec_range = (TYPEOF(h0.sec_range))''); // Simplify later processing 
  INTEGER2 address_weight100 := 0; // Contains 100x the specificity
  BOOLEAN address_isnull := ((h0.prim_range  IN SET(s.nulls_prim_range,prim_range) OR h0.prim_range = (TYPEOF(h0.prim_range))'' AND h0.prim_name  IN SET(s.nulls_prim_name,prim_name) OR h0.prim_name = (TYPEOF(h0.prim_name))'' AND h0.sec_range  IN SET(s.nulls_sec_range,sec_range) OR h0.sec_range = (TYPEOF(h0.sec_range))'') AND (h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR h0.v_city_name = (TYPEOF(h0.v_city_name))'' AND h0.st  IN SET(s.nulls_st,st) OR h0.st = (TYPEOF(h0.st))'' AND h0.zip  IN SET(s.nulls_zip,zip) OR h0.zip = (TYPEOF(h0.zip))'')); // Simplify later processing 
  INTEGER2 isContact_weight100 := 0; // Contains 100x the specificity
  BOOLEAN isContact_isnull := h0.isContact  IN SET(s.nulls_isContact,isContact) OR h0.isContact = (TYPEOF(h0.isContact))''; // Simplify later processing 
  INTEGER2 fname_weight100 := 0; // Contains 100x the specificity
  INTEGER2 fname_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN fname_isnull := h0.fname  IN SET(s.nulls_fname,fname) OR h0.fname = (TYPEOF(h0.fname))''; // Simplify later processing 
  UNSIGNED fname_cnt := 0; // Number of instances with this particular field value
  UNSIGNED fname_e1_cnt := 0; // Number of names instances matching this one by edit distance
  STRING20 fname_PreferredName := (STRING20)'';
  UNSIGNED fname_PreferredName_cnt := 0; // Number of names instances matching this one using PreferredName
  INTEGER2 mname_weight100 := 0; // Contains 100x the specificity
  INTEGER2 mname_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN mname_isnull := h0.mname  IN SET(s.nulls_mname,mname) OR h0.mname = (TYPEOF(h0.mname))''; // Simplify later processing 
  UNSIGNED mname_cnt := 0; // Number of instances with this particular field value
  UNSIGNED mname_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 lname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN lname_isnull := h0.lname  IN SET(s.nulls_lname,lname) OR h0.lname = (TYPEOF(h0.lname))''; // Simplify later processing 
  UNSIGNED lname_cnt := 0; // Number of instances with this particular field value
  UNSIGNED lname_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 name_suffix_weight100 := 0; // Contains 100x the specificity
  BOOLEAN name_suffix_isnull := h0.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR h0.name_suffix = (TYPEOF(h0.name_suffix))''; // Simplify later processing 
  UNSIGNED name_suffix_cnt := 0; // Number of instances with this particular field value
  STRING5 name_suffix_NormSuffix := (STRING5)'';
  UNSIGNED name_suffix_NormSuffix_cnt := 0; // Number of names instances matching this one using NormSuffix
  INTEGER2 contact_ssn_weight100 := 0; // Contains 100x the specificity
  BOOLEAN contact_ssn_isnull := h0.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn) OR h0.contact_ssn = (TYPEOF(h0.contact_ssn))''; // Simplify later processing 
  UNSIGNED contact_ssn_cnt := 0; // Number of instances with this particular field value
  UNSIGNED contact_ssn_e1_cnt := 0; // Number of names instances matching this one by edit distance
  STRING4 contact_ssn_Right4 := (STRING4)'';
  UNSIGNED contact_ssn_Right4_cnt := 0; // Number of names instances matching this one using Right4
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
 
//Would also create auto-id fields here
 
layout_candidates add_isContact(layout_candidates le,Specificities(ih).isContact_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.isContact_weight100 := MAP (le.isContact_isnull => 0, patch_default and ri.field_specificity=0 => s.isContact_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j22 := JOIN(h1,PULL(Specificities(ih).isContact_values_persisted),LEFT.isContact=RIGHT.isContact,add_isContact(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cnp_btype(layout_candidates le,Specificities(ih).cnp_btype_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_btype_weight100 := MAP (le.cnp_btype_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_btype_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j21 := JOIN(j22,PULL(Specificities(ih).cnp_btype_values_persisted),LEFT.cnp_btype=RIGHT.cnp_btype,add_cnp_btype(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_st(layout_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j20 := JOIN(j21,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_st(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_name_suffix(layout_candidates le,Specificities(ih).name_suffix_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.name_suffix_cnt := ri.cnt;
  SELF.name_suffix_NormSuffix_cnt := ri.NormSuffix_cnt; // Copy in count of matching NormSuffix values for field name_suffix
  SELF.name_suffix_NormSuffix := ri.name_suffix_NormSuffix; // Copy NormSuffix value for field name_suffix
  SELF.name_suffix_weight100 := MAP (le.name_suffix_isnull => 0, patch_default and ri.field_specificity=0 => s.name_suffix_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j20,s.nulls_name_suffix,Specificities(ih).name_suffix_values_persisted,name_suffix,name_suffix_weight100,add_name_suffix,j19);
layout_candidates add_fname(layout_candidates le,Specificities(ih).fname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.fname_cnt := ri.cnt;
  SELF.fname_e1_cnt := ri.e1_cnt;
  SELF.fname_PreferredName_cnt := ri.PreferredName_cnt; // Copy in count of matching PreferredName values for field fname
  SELF.fname_PreferredName := ri.fname_PreferredName; // Copy PreferredName value for field fname
  SELF.fname_weight100 := MAP (le.fname_isnull => 0, patch_default and ri.field_specificity=0 => s.fname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.fname_initial_char_weight100 := MAP (le.fname_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j19,s.nulls_fname,Specificities(ih).fname_values_persisted,fname,fname_weight100,add_fname,j18);
layout_candidates add_mname(layout_candidates le,Specificities(ih).mname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.mname_cnt := ri.cnt;
  SELF.mname_e1_cnt := ri.e1_cnt;
  SELF.mname_weight100 := MAP (le.mname_isnull => 0, patch_default and ri.field_specificity=0 => s.mname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.mname_initial_char_weight100 := MAP (le.mname_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j18,s.nulls_mname,Specificities(ih).mname_values_persisted,mname,mname_weight100,add_mname,j17);
layout_candidates add_lname(layout_candidates le,Specificities(ih).lname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.lname_cnt := ri.cnt;
  SELF.lname_e1_cnt := ri.e1_cnt;
  SELF.lname_weight100 := MAP (le.lname_isnull => 0, patch_default and ri.field_specificity=0 => s.lname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j17,s.nulls_lname,Specificities(ih).lname_values_persisted,lname,lname_weight100,add_lname,j16);
layout_candidates add_v_city_name(layout_candidates le,Specificities(ih).v_city_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.v_city_name_weight100 := MAP (le.v_city_name_isnull => 0, patch_default and ri.field_specificity=0 => s.v_city_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j16,s.nulls_v_city_name,Specificities(ih).v_city_name_values_persisted,v_city_name,v_city_name_weight100,add_v_city_name,j15);
layout_candidates add_sec_range(layout_candidates le,Specificities(ih).sec_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sec_range_weight100 := MAP (le.sec_range_isnull => 0, patch_default and ri.field_specificity=0 => s.sec_range_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j15,s.nulls_sec_range,Specificities(ih).sec_range_values_persisted,sec_range,sec_range_weight100,add_sec_range,j14);
layout_candidates add_prim_range(layout_candidates le,Specificities(ih).prim_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_weight100 := MAP (le.prim_range_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j14,s.nulls_prim_range,Specificities(ih).prim_range_values_persisted,prim_range,prim_range_weight100,add_prim_range,j13);
layout_candidates add_csz(layout_candidates le,Specificities(ih).csz_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.csz_weight100 := MAP (le.csz_isnull => 0, patch_default and ri.field_specificity=0 => s.csz_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j13,s.nulls_csz,Specificities(ih).csz_values_persisted,csz,csz_weight100,add_csz,j12);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip_weight100 := MAP (le.zip_isnull => 0, patch_default and ri.field_specificity=0 => s.zip_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j12,s.nulls_zip,Specificities(ih).zip_values_persisted,zip,zip_weight100,add_zip,j11);
layout_candidates add_cnp_number(layout_candidates le,Specificities(ih).cnp_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_number_weight100 := MAP (le.cnp_number_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j11,s.nulls_cnp_number,Specificities(ih).cnp_number_values_persisted,cnp_number,cnp_number_weight100,add_cnp_number,j10);
layout_candidates add_prim_name(layout_candidates le,Specificities(ih).prim_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_weight100 := MAP (le.prim_name_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j10,s.nulls_prim_name,Specificities(ih).prim_name_values_persisted,prim_name,prim_name_weight100,add_prim_name,j9);
layout_candidates add_addr1(layout_candidates le,Specificities(ih).addr1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.addr1_weight100 := MAP (le.addr1_isnull => 0, patch_default and ri.field_specificity=0 => s.addr1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j9,s.nulls_addr1,Specificities(ih).addr1_values_persisted,addr1,addr1_weight100,add_addr1,j8);
layout_candidates add_active_duns_number(layout_candidates le,Specificities(ih).active_duns_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_duns_number_weight100 := MAP (le.active_duns_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_duns_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j8,s.nulls_active_duns_number,Specificities(ih).active_duns_number_values_persisted,active_duns_number,active_duns_number_weight100,add_active_duns_number,j7);
layout_candidates add_address(layout_candidates le,Specificities(ih).address_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.address_weight100 := MAP (le.address_isnull => 0, patch_default and ri.field_specificity=0 => s.address_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j7,s.nulls_address,Specificities(ih).address_values_persisted,address,address_weight100,add_address,j6);
layout_candidates add_corp_legal_name(layout_candidates le,Specificities(ih).corp_legal_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_legal_name_weight100 := MAP (le.corp_legal_name_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_legal_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.corp_legal_name := IF( ri.field_specificity<>0 or ri.word<>'',SELF.corp_legal_name_weight100+' '+ri.word,SALT32.Fn_WordBag_AppendSpecs_Fake(le.corp_legal_name, s.corp_legal_name_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j6,s.nulls_corp_legal_name,Specificities(ih).corp_legal_name_values_persisted,corp_legal_name,corp_legal_name_weight100,add_corp_legal_name,j5);
layout_candidates add_cnp_name(layout_candidates le,Specificities(ih).cnp_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_name_cnt := ri.cnt;
  SELF.cnp_name_e1_cnt := ri.e1_cnt;
  SELF.cnp_name_weight100 := MAP (le.cnp_name_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j5,s.nulls_cnp_name,Specificities(ih).cnp_name_values_persisted,cnp_name,cnp_name_weight100,add_cnp_name,j4);
layout_candidates add_active_domestic_corp_key(layout_candidates le,Specificities(ih).active_domestic_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_domestic_corp_key_weight100 := MAP (le.active_domestic_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.active_domestic_corp_key_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j4,s.nulls_active_domestic_corp_key,Specificities(ih).active_domestic_corp_key_values_persisted,active_domestic_corp_key,active_domestic_corp_key_weight100,add_active_domestic_corp_key,j3);
layout_candidates add_active_enterprise_number(layout_candidates le,Specificities(ih).active_enterprise_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_enterprise_number_weight100 := MAP (le.active_enterprise_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_enterprise_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j3,s.nulls_active_enterprise_number,Specificities(ih).active_enterprise_number_values_persisted,active_enterprise_number,active_enterprise_number_weight100,add_active_enterprise_number,j2);
layout_candidates add_company_fein(layout_candidates le,Specificities(ih).company_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_fein_weight100 := MAP (le.company_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.company_fein_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j2,s.nulls_company_fein,Specificities(ih).company_fein_values_persisted,company_fein,company_fein_weight100,add_company_fein,j1);
layout_candidates add_contact_ssn(layout_candidates le,Specificities(ih).contact_ssn_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.contact_ssn_cnt := ri.cnt;
  SELF.contact_ssn_e1_cnt := ri.e1_cnt;
  SELF.contact_ssn_Right4_cnt := ri.Right4_cnt; // Copy in count of matching Right4 values for field contact_ssn
  SELF.contact_ssn_Right4 := ri.contact_ssn_Right4; // Copy Right4 value for field contact_ssn
  SELF.contact_ssn_weight100 := MAP (le.contact_ssn_isnull => 0, patch_default and ri.field_specificity=0 => s.contact_ssn_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j1,s.nulls_contact_ssn,Specificities(ih).contact_ssn_values_persisted,contact_ssn,contact_ssn_weight100,add_contact_ssn,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(DOTid)) : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::mc',EXPIRE(Config.PersistExpire)); // Distributed for keybuild case
 
//Now prepare candidate file for ForeignCorpkey attribute file
layout_ForeignCorpkey_candidates add_ForeignCorpkey_company_fein(layout_ForeignCorpkey_candidates le,Specificities(ih).company_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_fein_weight100 := MAP (le.company_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.company_fein_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(ForeignCorpkey_pp,s.nulls_company_fein,Specificities(ih).company_fein_values_persisted,company_fein,company_fein_weight100,add_ForeignCorpkey_company_fein,jForeignCorpkey_1);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_active_enterprise_number(layout_ForeignCorpkey_candidates le,Specificities(ih).active_enterprise_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_enterprise_number_weight100 := MAP (le.active_enterprise_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_enterprise_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(jForeignCorpkey_1,s.nulls_active_enterprise_number,Specificities(ih).active_enterprise_number_values_persisted,active_enterprise_number,active_enterprise_number_weight100,add_ForeignCorpkey_active_enterprise_number,jForeignCorpkey_2);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_active_domestic_corp_key(layout_ForeignCorpkey_candidates le,Specificities(ih).active_domestic_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_domestic_corp_key_weight100 := MAP (le.active_domestic_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.active_domestic_corp_key_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(jForeignCorpkey_2,s.nulls_active_domestic_corp_key,Specificities(ih).active_domestic_corp_key_values_persisted,active_domestic_corp_key,active_domestic_corp_key_weight100,add_ForeignCorpkey_active_domestic_corp_key,jForeignCorpkey_3);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_cnp_name(layout_ForeignCorpkey_candidates le,Specificities(ih).cnp_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_name_cnt := ri.cnt;
  SELF.cnp_name_e1_cnt := ri.e1_cnt;
  SELF.cnp_name_weight100 := MAP (le.cnp_name_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(jForeignCorpkey_3,s.nulls_cnp_name,Specificities(ih).cnp_name_values_persisted,cnp_name,cnp_name_weight100,add_ForeignCorpkey_cnp_name,jForeignCorpkey_4);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_corp_legal_name(layout_ForeignCorpkey_candidates le,Specificities(ih).corp_legal_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_legal_name_weight100 := MAP (le.corp_legal_name_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_legal_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.corp_legal_name := IF( ri.field_specificity<>0 or ri.word<>'',SELF.corp_legal_name_weight100+' '+ri.word,SALT32.Fn_WordBag_AppendSpecs_Fake(le.corp_legal_name, s.corp_legal_name_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(jForeignCorpkey_4,s.nulls_corp_legal_name,Specificities(ih).corp_legal_name_values_persisted,corp_legal_name,corp_legal_name_weight100,add_ForeignCorpkey_corp_legal_name,jForeignCorpkey_5);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_prim_name(layout_ForeignCorpkey_candidates le,Specificities(ih).prim_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_weight100 := MAP (le.prim_name_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(jForeignCorpkey_5,s.nulls_prim_name,Specificities(ih).prim_name_values_persisted,prim_name,prim_name_weight100,add_ForeignCorpkey_prim_name,jForeignCorpkey_9);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_cnp_number(layout_ForeignCorpkey_candidates le,Specificities(ih).cnp_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_number_weight100 := MAP (le.cnp_number_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(jForeignCorpkey_9,s.nulls_cnp_number,Specificities(ih).cnp_number_values_persisted,cnp_number,cnp_number_weight100,add_ForeignCorpkey_cnp_number,jForeignCorpkey_10);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_prim_range(layout_ForeignCorpkey_candidates le,Specificities(ih).prim_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_weight100 := MAP (le.prim_range_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(jForeignCorpkey_10,s.nulls_prim_range,Specificities(ih).prim_range_values_persisted,prim_range,prim_range_weight100,add_ForeignCorpkey_prim_range,jForeignCorpkey_13);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_sec_range(layout_ForeignCorpkey_candidates le,Specificities(ih).sec_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sec_range_weight100 := MAP (le.sec_range_isnull => 0, patch_default and ri.field_specificity=0 => s.sec_range_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(jForeignCorpkey_13,s.nulls_sec_range,Specificities(ih).sec_range_values_persisted,sec_range,sec_range_weight100,add_ForeignCorpkey_sec_range,jForeignCorpkey_14);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_lname(layout_ForeignCorpkey_candidates le,Specificities(ih).lname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.lname_cnt := ri.cnt;
  SELF.lname_e1_cnt := ri.e1_cnt;
  SELF.lname_weight100 := MAP (le.lname_isnull => 0, patch_default and ri.field_specificity=0 => s.lname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(jForeignCorpkey_14,s.nulls_lname,Specificities(ih).lname_values_persisted,lname,lname_weight100,add_ForeignCorpkey_lname,jForeignCorpkey_16);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_mname(layout_ForeignCorpkey_candidates le,Specificities(ih).mname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.mname_cnt := ri.cnt;
  SELF.mname_e1_cnt := ri.e1_cnt;
  SELF.mname_weight100 := MAP (le.mname_isnull => 0, patch_default and ri.field_specificity=0 => s.mname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.mname_initial_char_weight100 := MAP (le.mname_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(jForeignCorpkey_16,s.nulls_mname,Specificities(ih).mname_values_persisted,mname,mname_weight100,add_ForeignCorpkey_mname,jForeignCorpkey_17);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_fname(layout_ForeignCorpkey_candidates le,Specificities(ih).fname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.fname_cnt := ri.cnt;
  SELF.fname_e1_cnt := ri.e1_cnt;
  SELF.fname_PreferredName_cnt := ri.PreferredName_cnt; // Copy in count of matching PreferredName values for field fname
  SELF.fname_PreferredName := ri.fname_PreferredName; // Copy PreferredName value for field fname
  SELF.fname_weight100 := MAP (le.fname_isnull => 0, patch_default and ri.field_specificity=0 => s.fname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.fname_initial_char_weight100 := MAP (le.fname_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(jForeignCorpkey_17,s.nulls_fname,Specificities(ih).fname_values_persisted,fname,fname_weight100,add_ForeignCorpkey_fname,jForeignCorpkey_18);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_name_suffix(layout_ForeignCorpkey_candidates le,Specificities(ih).name_suffix_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.name_suffix_cnt := ri.cnt;
  SELF.name_suffix_NormSuffix_cnt := ri.NormSuffix_cnt; // Copy in count of matching NormSuffix values for field name_suffix
  SELF.name_suffix_NormSuffix := ri.name_suffix_NormSuffix; // Copy NormSuffix value for field name_suffix
  SELF.name_suffix_weight100 := MAP (le.name_suffix_isnull => 0, patch_default and ri.field_specificity=0 => s.name_suffix_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(jForeignCorpkey_18,s.nulls_name_suffix,Specificities(ih).name_suffix_values_persisted,name_suffix,name_suffix_weight100,add_ForeignCorpkey_name_suffix,jForeignCorpkey_19);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_st(layout_ForeignCorpkey_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
jForeignCorpkey_20 := JOIN(jForeignCorpkey_19,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_ForeignCorpkey_st(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_isContact(layout_ForeignCorpkey_candidates le,Specificities(ih).isContact_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.isContact_weight100 := MAP (le.isContact_isnull => 0, patch_default and ri.field_specificity=0 => s.isContact_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
jForeignCorpkey_22 := JOIN(jForeignCorpkey_20,PULL(Specificities(ih).isContact_values_persisted),LEFT.isContact=RIGHT.isContact,add_ForeignCorpkey_isContact(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
EXPORT ForeignCorpkey_candidates := jForeignCorpkey_22 : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::mc::ForeignCorpkey',EXPIRE(Config.PersistExpire));
//Now see if these records are actually linkable
TotalWeight := Annotated.contact_ssn_weight100 + Annotated.company_fein_weight100 + Annotated.active_enterprise_number_weight100 + Annotated.active_domestic_corp_key_weight100 + Annotated.cnp_name_weight100 + Annotated.corp_legal_name_weight100 + Annotated.address_weight100 + Annotated.active_duns_number_weight100 + Annotated.cnp_number_weight100 + Annotated.lname_weight100 + Annotated.mname_weight100 + Annotated.fname_weight100 + Annotated.name_suffix_weight100 + Annotated.cnp_btype_weight100 + Annotated.isContact_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
EXPORT BuddyCounts := TABLE(Annotated,{ buddies, Cnt := COUNT(GROUP) }, buddies, FEW);
EXPORT HasBuddies := TABLE(Annotated(buddies>0), { rcid });
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(); //Attribute Files might bring total score up to threshold
END;
