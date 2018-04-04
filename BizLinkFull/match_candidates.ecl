// Begin code to produce match candidates
IMPORT SALT37;
EXPORT match_candidates(DATASET(layout_BizHead) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := BizLinkFull.Specificities(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00,{rcid,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,has_lgid,empid,source,source_record_id,source_docid,company_name,company_name_prefix,cnp_name,cnp_number,cnp_btype,cnp_lowv,company_phone,company_phone_3,company_phone_3_ex,company_phone_7,company_fein,company_fein_len,company_sic_code1,active_duns_number,prim_range,prim_range_len,prim_name,prim_name_len,sec_range,sec_range_len,city,city_len,city_clean,st,zip,company_url,isContact,contact_did,title,fname,fname_len,fname_preferred,mname,mname_len,lname,lname_len,name_suffix,contact_ssn,contact_email,sele_flag,org_flag,ult_flag,fallback_value,CONTACTNAME,STREETADDRESS,ultid,orgid,seleid,proxid,powid}),HASH(proxid));
 
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 parent_proxid_pop := AVE(GROUP,IF((thin_table.parent_proxid  IN SET(s.nulls_parent_proxid,parent_proxid) OR thin_table.parent_proxid = (TYPEOF(thin_table.parent_proxid))''),0,100));
  REAL8 sele_proxid_pop := AVE(GROUP,IF((thin_table.sele_proxid  IN SET(s.nulls_sele_proxid,sele_proxid) OR thin_table.sele_proxid = (TYPEOF(thin_table.sele_proxid))''),0,100));
  REAL8 org_proxid_pop := AVE(GROUP,IF((thin_table.org_proxid  IN SET(s.nulls_org_proxid,org_proxid) OR thin_table.org_proxid = (TYPEOF(thin_table.org_proxid))''),0,100));
  REAL8 ultimate_proxid_pop := AVE(GROUP,IF((thin_table.ultimate_proxid  IN SET(s.nulls_ultimate_proxid,ultimate_proxid) OR thin_table.ultimate_proxid = (TYPEOF(thin_table.ultimate_proxid))''),0,100));
  REAL8 source_pop := AVE(GROUP,IF((thin_table.source  IN SET(s.nulls_source,source) OR thin_table.source = (TYPEOF(thin_table.source))''),0,100));
  REAL8 source_record_id_pop := AVE(GROUP,IF((thin_table.source_record_id  IN SET(s.nulls_source_record_id,source_record_id) OR thin_table.source_record_id = (TYPEOF(thin_table.source_record_id))''),0,100));
  REAL8 company_name_pop := AVE(GROUP,IF((thin_table.company_name  IN SET(s.nulls_company_name,company_name) OR thin_table.company_name = (TYPEOF(thin_table.company_name))''),0,100));
  REAL8 company_name_prefix_pop := AVE(GROUP,IF((thin_table.company_name_prefix  IN SET(s.nulls_company_name_prefix,company_name_prefix) OR thin_table.company_name_prefix = (TYPEOF(thin_table.company_name_prefix))''),0,100));
  REAL8 cnp_name_pop := AVE(GROUP,IF((thin_table.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR thin_table.cnp_name = (TYPEOF(thin_table.cnp_name))''),0,100));
  REAL8 cnp_number_pop := AVE(GROUP,IF((thin_table.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR thin_table.cnp_number = (TYPEOF(thin_table.cnp_number))''),0,100));
  REAL8 cnp_btype_pop := AVE(GROUP,IF((thin_table.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR thin_table.cnp_btype = (TYPEOF(thin_table.cnp_btype))''),0,100));
  REAL8 cnp_lowv_pop := AVE(GROUP,IF((thin_table.cnp_lowv  IN SET(s.nulls_cnp_lowv,cnp_lowv) OR thin_table.cnp_lowv = (TYPEOF(thin_table.cnp_lowv))''),0,100));
  REAL8 company_phone_3_pop := AVE(GROUP,IF((thin_table.company_phone_3  IN SET(s.nulls_company_phone_3,company_phone_3) OR thin_table.company_phone_3 = (TYPEOF(thin_table.company_phone_3))''),0,100));
  REAL8 company_phone_3_ex_pop := AVE(GROUP,IF((thin_table.company_phone_3_ex  IN SET(s.nulls_company_phone_3_ex,company_phone_3_ex) OR thin_table.company_phone_3_ex = (TYPEOF(thin_table.company_phone_3_ex))''),0,100));
  REAL8 company_phone_7_pop := AVE(GROUP,IF((thin_table.company_phone_7  IN SET(s.nulls_company_phone_7,company_phone_7) OR thin_table.company_phone_7 = (TYPEOF(thin_table.company_phone_7))''),0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF((thin_table.company_fein  IN SET(s.nulls_company_fein,company_fein) OR thin_table.company_fein = (TYPEOF(thin_table.company_fein))''),0,100));
  REAL8 company_sic_code1_pop := AVE(GROUP,IF((thin_table.company_sic_code1  IN SET(s.nulls_company_sic_code1,company_sic_code1) OR thin_table.company_sic_code1 = (TYPEOF(thin_table.company_sic_code1))''),0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF((thin_table.prim_range  IN SET(s.nulls_prim_range,prim_range) OR thin_table.prim_range = (TYPEOF(thin_table.prim_range))''),0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF((thin_table.prim_name  IN SET(s.nulls_prim_name,prim_name) OR thin_table.prim_name = (TYPEOF(thin_table.prim_name))''),0,100));
  REAL8 sec_range_pop := AVE(GROUP,IF((thin_table.sec_range  IN SET(s.nulls_sec_range,sec_range) OR thin_table.sec_range = (TYPEOF(thin_table.sec_range))''),0,100));
  REAL8 city_pop := AVE(GROUP,IF((thin_table.city  IN SET(s.nulls_city,city) OR thin_table.city = (TYPEOF(thin_table.city))''),0,100));
  REAL8 city_clean_pop := AVE(GROUP,IF((thin_table.city_clean  IN SET(s.nulls_city_clean,city_clean) OR thin_table.city_clean = (TYPEOF(thin_table.city_clean))''),0,100));
  REAL8 st_pop := AVE(GROUP,IF((thin_table.st  IN SET(s.nulls_st,st) OR thin_table.st = (TYPEOF(thin_table.st))''),0,100));
  REAL8 zip_pop := AVE(GROUP,IF((thin_table.zip  IN SET(s.nulls_zip,zip) OR thin_table.zip = (TYPEOF(thin_table.zip))''),0,100));
  REAL8 company_url_pop := AVE(GROUP,IF((thin_table.company_url  IN SET(s.nulls_company_url,company_url) OR thin_table.company_url = (TYPEOF(thin_table.company_url))''),0,100));
  REAL8 isContact_pop := AVE(GROUP,IF((thin_table.isContact  IN SET(s.nulls_isContact,isContact) OR thin_table.isContact = (TYPEOF(thin_table.isContact))''),0,100));
  REAL8 contact_did_pop := AVE(GROUP,IF((thin_table.contact_did  IN SET(s.nulls_contact_did,contact_did) OR thin_table.contact_did = (TYPEOF(thin_table.contact_did))''),0,100));
  REAL8 title_pop := AVE(GROUP,IF((thin_table.title  IN SET(s.nulls_title,title) OR thin_table.title = (TYPEOF(thin_table.title))''),0,100));
  REAL8 fname_pop := AVE(GROUP,IF((thin_table.fname  IN SET(s.nulls_fname,fname) OR thin_table.fname = (TYPEOF(thin_table.fname))''),0,100));
  REAL8 fname_preferred_pop := AVE(GROUP,IF((thin_table.fname_preferred  IN SET(s.nulls_fname_preferred,fname_preferred) OR thin_table.fname_preferred = (TYPEOF(thin_table.fname_preferred))''),0,100));
  REAL8 mname_pop := AVE(GROUP,IF((thin_table.mname  IN SET(s.nulls_mname,mname) OR thin_table.mname = (TYPEOF(thin_table.mname))''),0,100));
  REAL8 lname_pop := AVE(GROUP,IF((thin_table.lname  IN SET(s.nulls_lname,lname) OR thin_table.lname = (TYPEOF(thin_table.lname))''),0,100));
  REAL8 name_suffix_pop := AVE(GROUP,IF((thin_table.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR thin_table.name_suffix = (TYPEOF(thin_table.name_suffix))''),0,100));
  REAL8 contact_ssn_pop := AVE(GROUP,IF((thin_table.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn) OR thin_table.contact_ssn = (TYPEOF(thin_table.contact_ssn))''),0,100));
  REAL8 contact_email_pop := AVE(GROUP,IF((thin_table.contact_email  IN SET(s.nulls_contact_email,contact_email) OR thin_table.contact_email = (TYPEOF(thin_table.contact_email))''),0,100));
  REAL8 sele_flag_pop := AVE(GROUP,IF((thin_table.sele_flag  IN SET(s.nulls_sele_flag,sele_flag) OR thin_table.sele_flag = (TYPEOF(thin_table.sele_flag))''),0,100));
  REAL8 org_flag_pop := AVE(GROUP,IF((thin_table.org_flag  IN SET(s.nulls_org_flag,org_flag) OR thin_table.org_flag = (TYPEOF(thin_table.org_flag))''),0,100));
  REAL8 ult_flag_pop := AVE(GROUP,IF((thin_table.ult_flag  IN SET(s.nulls_ult_flag,ult_flag) OR thin_table.ult_flag = (TYPEOF(thin_table.ult_flag))''),0,100));
  REAL8 fallback_value_pop := AVE(GROUP,IF((thin_table.fallback_value  IN SET(s.nulls_fallback_value,fallback_value) OR thin_table.fallback_value = (TYPEOF(thin_table.fallback_value))''),0,100));
  REAL8 CONTACTNAME_pop := AVE(GROUP,IF(((thin_table.fname  IN SET(s.nulls_fname,fname) OR thin_table.fname = (TYPEOF(thin_table.fname))'') AND (thin_table.mname  IN SET(s.nulls_mname,mname) OR thin_table.mname = (TYPEOF(thin_table.mname))'') AND (thin_table.lname  IN SET(s.nulls_lname,lname) OR thin_table.lname = (TYPEOF(thin_table.lname))'')),0,100));
  REAL8 STREETADDRESS_pop := AVE(GROUP,IF(((thin_table.prim_range  IN SET(s.nulls_prim_range,prim_range) OR thin_table.prim_range = (TYPEOF(thin_table.prim_range))'') AND (thin_table.prim_name  IN SET(s.nulls_prim_name,prim_name) OR thin_table.prim_name = (TYPEOF(thin_table.prim_name))'') AND (thin_table.sec_range  IN SET(s.nulls_sec_range,sec_range) OR thin_table.sec_range = (TYPEOF(thin_table.sec_range))'')),0,100));
END;
EXPORT PPS := TABLE(thin_table,PrePropCounts);
EXPORT poprec := RECORD
	STRING label;
		REAL8 pop;
	END;
EXPORT PrePropogationStats := SALT37.MAC_Pivot(PPS, poprec);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 cnp_btype_prop := 0;
  UNSIGNED1 company_fein_prop := 0;
  UNSIGNED1 company_sic_code1_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
 
SALT37.mac_prop_field(with_props(cnp_btype NOT IN SET(s.nulls_cnp_btype,cnp_btype)),cnp_btype,proxid,cnp_btype_props); // For every DID find the best FULL cnp_btype
layout_withpropvars take_cnp_btype(with_props le,cnp_btype_props ri) := TRANSFORM
  SELF.cnp_btype := IF ( le.cnp_btype IN SET(s.nulls_cnp_btype,cnp_btype) and ri.proxid<>(TYPEOF(ri.proxid))'', ri.cnp_btype, le.cnp_btype );
  SELF.cnp_btype_prop := le.cnp_btype_prop + IF ( le.cnp_btype IN SET(s.nulls_cnp_btype,cnp_btype) and ri.cnp_btype NOT IN SET(s.nulls_cnp_btype,cnp_btype) and ri.proxid<>(TYPEOF(ri.proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj13 := JOIN(with_props,cnp_btype_props,left.proxid=right.proxid,take_cnp_btype(left,right),LEFT OUTER,HASH/*HACK21 ,HINT(parallel_match)*/);
 
SALT37.mac_prop_field(with_props(company_fein NOT IN SET(s.nulls_company_fein,company_fein)),company_fein,proxid,company_fein_props); // For every DID find the best FULL company_fein
layout_withpropvars take_company_fein(with_props le,company_fein_props ri) := TRANSFORM
  SELF.company_fein := IF ( le.company_fein IN SET(s.nulls_company_fein,company_fein) and ri.proxid<>(TYPEOF(ri.proxid))'', ri.company_fein, le.company_fein );
  SELF.company_fein_prop := le.company_fein_prop + IF ( le.company_fein IN SET(s.nulls_company_fein,company_fein) and ri.company_fein NOT IN SET(s.nulls_company_fein,company_fein) and ri.proxid<>(TYPEOF(ri.proxid))'', 1, 0 ); // <>0 => propogation
  SELF.company_fein_len := IF ( le.company_fein IN SET(s.nulls_company_fein,company_fein) and ri.proxid<>(TYPEOF(ri.proxid))'', LENGTH(TRIM(ri.company_fein)), le.company_fein_len );
  SELF := le;
  END;
SHARED pj19 := JOIN(pj13,company_fein_props,left.proxid=right.proxid,take_company_fein(left,right),LEFT OUTER,HASH/*HACK21 ,HINT(parallel_match)*/);
 
SALT37.mac_prop_field(with_props(company_sic_code1 NOT IN SET(s.nulls_company_sic_code1,company_sic_code1)),company_sic_code1,proxid,company_sic_code1_props); // For every DID find the best FULL company_sic_code1
layout_withpropvars take_company_sic_code1(with_props le,company_sic_code1_props ri) := TRANSFORM
  SELF.company_sic_code1 := IF ( le.company_sic_code1 IN SET(s.nulls_company_sic_code1,company_sic_code1) and ri.proxid<>(TYPEOF(ri.proxid))'', ri.company_sic_code1, le.company_sic_code1 );
  SELF.company_sic_code1_prop := le.company_sic_code1_prop + IF ( le.company_sic_code1 IN SET(s.nulls_company_sic_code1,company_sic_code1) and ri.company_sic_code1 NOT IN SET(s.nulls_company_sic_code1,company_sic_code1) and ri.proxid<>(TYPEOF(ri.proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj20 := JOIN(pj19,company_sic_code1_props,left.proxid=right.proxid,take_company_sic_code1(left,right),LEFT OUTER,HASH/*HACK21 ,HINT(parallel_match)*/);
 
pj20 do_computes(pj20 le) := TRANSFORM
  SELF.CONTACTNAME := IF (Fields.InValid_CONTACTNAME((SALT37.StrType)le.fname,(SALT37.StrType)le.mname,(SALT37.StrType)le.lname)>0,0,HASH32((SALT37.StrType)le.fname,(SALT37.StrType)le.mname,(SALT37.StrType)le.lname)); // Combine child fields into 1 for specificity counting
  SELF.STREETADDRESS := IF (Fields.InValid_STREETADDRESS((SALT37.StrType)le.prim_range,(SALT37.StrType)le.prim_name,(SALT37.StrType)le.sec_range)>0,0,HASH32((SALT37.StrType)le.prim_range,(SALT37.StrType)le.prim_name,(SALT37.StrType)le.sec_range)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
SHARED propogated := PROJECT(pj20,do_computes(left)) : PERSIST('~temp::proxid::BizLinkFull::mc_props::BizHead',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 parent_proxid_pop := AVE(GROUP,IF((propogated.parent_proxid  IN SET(s.nulls_parent_proxid,parent_proxid) OR propogated.parent_proxid = (TYPEOF(propogated.parent_proxid))''),0,100));
  REAL8 sele_proxid_pop := AVE(GROUP,IF((propogated.sele_proxid  IN SET(s.nulls_sele_proxid,sele_proxid) OR propogated.sele_proxid = (TYPEOF(propogated.sele_proxid))''),0,100));
  REAL8 org_proxid_pop := AVE(GROUP,IF((propogated.org_proxid  IN SET(s.nulls_org_proxid,org_proxid) OR propogated.org_proxid = (TYPEOF(propogated.org_proxid))''),0,100));
  REAL8 ultimate_proxid_pop := AVE(GROUP,IF((propogated.ultimate_proxid  IN SET(s.nulls_ultimate_proxid,ultimate_proxid) OR propogated.ultimate_proxid = (TYPEOF(propogated.ultimate_proxid))''),0,100));
  REAL8 source_pop := AVE(GROUP,IF((propogated.source  IN SET(s.nulls_source,source) OR propogated.source = (TYPEOF(propogated.source))''),0,100));
  REAL8 source_record_id_pop := AVE(GROUP,IF((propogated.source_record_id  IN SET(s.nulls_source_record_id,source_record_id) OR propogated.source_record_id = (TYPEOF(propogated.source_record_id))''),0,100));
  REAL8 company_name_pop := AVE(GROUP,IF((propogated.company_name  IN SET(s.nulls_company_name,company_name) OR propogated.company_name = (TYPEOF(propogated.company_name))''),0,100));
  REAL8 company_name_prefix_pop := AVE(GROUP,IF((propogated.company_name_prefix  IN SET(s.nulls_company_name_prefix,company_name_prefix) OR propogated.company_name_prefix = (TYPEOF(propogated.company_name_prefix))''),0,100));
  REAL8 cnp_name_pop := AVE(GROUP,IF((propogated.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR propogated.cnp_name = (TYPEOF(propogated.cnp_name))''),0,100));
  REAL8 cnp_number_pop := AVE(GROUP,IF((propogated.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR propogated.cnp_number = (TYPEOF(propogated.cnp_number))''),0,100));
  REAL8 cnp_btype_pop := AVE(GROUP,IF((propogated.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR propogated.cnp_btype = (TYPEOF(propogated.cnp_btype))''),0,100));
  REAL8 cnp_lowv_pop := AVE(GROUP,IF((propogated.cnp_lowv  IN SET(s.nulls_cnp_lowv,cnp_lowv) OR propogated.cnp_lowv = (TYPEOF(propogated.cnp_lowv))''),0,100));
  REAL8 company_phone_3_pop := AVE(GROUP,IF((propogated.company_phone_3  IN SET(s.nulls_company_phone_3,company_phone_3) OR propogated.company_phone_3 = (TYPEOF(propogated.company_phone_3))''),0,100));
  REAL8 company_phone_3_ex_pop := AVE(GROUP,IF((propogated.company_phone_3_ex  IN SET(s.nulls_company_phone_3_ex,company_phone_3_ex) OR propogated.company_phone_3_ex = (TYPEOF(propogated.company_phone_3_ex))''),0,100));
  REAL8 company_phone_7_pop := AVE(GROUP,IF((propogated.company_phone_7  IN SET(s.nulls_company_phone_7,company_phone_7) OR propogated.company_phone_7 = (TYPEOF(propogated.company_phone_7))''),0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF((propogated.company_fein  IN SET(s.nulls_company_fein,company_fein) OR propogated.company_fein = (TYPEOF(propogated.company_fein))''),0,100));
  REAL8 company_sic_code1_pop := AVE(GROUP,IF((propogated.company_sic_code1  IN SET(s.nulls_company_sic_code1,company_sic_code1) OR propogated.company_sic_code1 = (TYPEOF(propogated.company_sic_code1))''),0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF((propogated.prim_range  IN SET(s.nulls_prim_range,prim_range) OR propogated.prim_range = (TYPEOF(propogated.prim_range))''),0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF((propogated.prim_name  IN SET(s.nulls_prim_name,prim_name) OR propogated.prim_name = (TYPEOF(propogated.prim_name))''),0,100));
  REAL8 sec_range_pop := AVE(GROUP,IF((propogated.sec_range  IN SET(s.nulls_sec_range,sec_range) OR propogated.sec_range = (TYPEOF(propogated.sec_range))''),0,100));
  REAL8 city_pop := AVE(GROUP,IF((propogated.city  IN SET(s.nulls_city,city) OR propogated.city = (TYPEOF(propogated.city))''),0,100));
  REAL8 city_clean_pop := AVE(GROUP,IF((propogated.city_clean  IN SET(s.nulls_city_clean,city_clean) OR propogated.city_clean = (TYPEOF(propogated.city_clean))''),0,100));
  REAL8 st_pop := AVE(GROUP,IF((propogated.st  IN SET(s.nulls_st,st) OR propogated.st = (TYPEOF(propogated.st))''),0,100));
  REAL8 zip_pop := AVE(GROUP,IF((propogated.zip  IN SET(s.nulls_zip,zip) OR propogated.zip = (TYPEOF(propogated.zip))''),0,100));
  REAL8 company_url_pop := AVE(GROUP,IF((propogated.company_url  IN SET(s.nulls_company_url,company_url) OR propogated.company_url = (TYPEOF(propogated.company_url))''),0,100));
  REAL8 isContact_pop := AVE(GROUP,IF((propogated.isContact  IN SET(s.nulls_isContact,isContact) OR propogated.isContact = (TYPEOF(propogated.isContact))''),0,100));
  REAL8 contact_did_pop := AVE(GROUP,IF((propogated.contact_did  IN SET(s.nulls_contact_did,contact_did) OR propogated.contact_did = (TYPEOF(propogated.contact_did))''),0,100));
  REAL8 title_pop := AVE(GROUP,IF((propogated.title  IN SET(s.nulls_title,title) OR propogated.title = (TYPEOF(propogated.title))''),0,100));
  REAL8 fname_pop := AVE(GROUP,IF((propogated.fname  IN SET(s.nulls_fname,fname) OR propogated.fname = (TYPEOF(propogated.fname))''),0,100));
  REAL8 fname_preferred_pop := AVE(GROUP,IF((propogated.fname_preferred  IN SET(s.nulls_fname_preferred,fname_preferred) OR propogated.fname_preferred = (TYPEOF(propogated.fname_preferred))''),0,100));
  REAL8 mname_pop := AVE(GROUP,IF((propogated.mname  IN SET(s.nulls_mname,mname) OR propogated.mname = (TYPEOF(propogated.mname))''),0,100));
  REAL8 lname_pop := AVE(GROUP,IF((propogated.lname  IN SET(s.nulls_lname,lname) OR propogated.lname = (TYPEOF(propogated.lname))''),0,100));
  REAL8 name_suffix_pop := AVE(GROUP,IF((propogated.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR propogated.name_suffix = (TYPEOF(propogated.name_suffix))''),0,100));
  REAL8 contact_ssn_pop := AVE(GROUP,IF((propogated.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn) OR propogated.contact_ssn = (TYPEOF(propogated.contact_ssn))''),0,100));
  REAL8 contact_email_pop := AVE(GROUP,IF((propogated.contact_email  IN SET(s.nulls_contact_email,contact_email) OR propogated.contact_email = (TYPEOF(propogated.contact_email))''),0,100));
  REAL8 sele_flag_pop := AVE(GROUP,IF((propogated.sele_flag  IN SET(s.nulls_sele_flag,sele_flag) OR propogated.sele_flag = (TYPEOF(propogated.sele_flag))''),0,100));
  REAL8 org_flag_pop := AVE(GROUP,IF((propogated.org_flag  IN SET(s.nulls_org_flag,org_flag) OR propogated.org_flag = (TYPEOF(propogated.org_flag))''),0,100));
  REAL8 ult_flag_pop := AVE(GROUP,IF((propogated.ult_flag  IN SET(s.nulls_ult_flag,ult_flag) OR propogated.ult_flag = (TYPEOF(propogated.ult_flag))''),0,100));
  REAL8 fallback_value_pop := AVE(GROUP,IF((propogated.fallback_value  IN SET(s.nulls_fallback_value,fallback_value) OR propogated.fallback_value = (TYPEOF(propogated.fallback_value))''),0,100));
  REAL8 CONTACTNAME_pop := AVE(GROUP,IF(((propogated.fname  IN SET(s.nulls_fname,fname) OR propogated.fname = (TYPEOF(propogated.fname))'') AND (propogated.mname  IN SET(s.nulls_mname,mname) OR propogated.mname = (TYPEOF(propogated.mname))'') AND (propogated.lname  IN SET(s.nulls_lname,lname) OR propogated.lname = (TYPEOF(propogated.lname))'')),0,100));
  REAL8 STREETADDRESS_pop := AVE(GROUP,IF(((propogated.prim_range  IN SET(s.nulls_prim_range,prim_range) OR propogated.prim_range = (TYPEOF(propogated.prim_range))'') AND (propogated.prim_name  IN SET(s.nulls_prim_name,prim_name) OR propogated.prim_name = (TYPEOF(propogated.prim_name))'') AND (propogated.sec_range  IN SET(s.nulls_sec_range,sec_range) OR propogated.sec_range = (TYPEOF(propogated.sec_range))'')),0,100));
END;
 PoPS := TABLE(propogated,PostPropCounts);
EXPORT PostPropogationStats := SALT37.MAC_Pivot(PoPS, poprec);
  Grpd := GROUP( SORT(
    DISTRIBUTE( TABLE( propogated, { propogated, UNSIGNED2 Buddies := 0 }),HASH(proxid)),
    proxid,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,source,source_record_id,company_name,company_name_prefix,cnp_name,cnp_number,cnp_btype,cnp_lowv,company_phone_3,company_phone_3_ex,company_phone_7,company_fein,company_sic_code1,prim_range,prim_name,sec_range,city,city_clean,st,zip,company_url,isContact,contact_did,title,fname,fname_preferred,mname,lname,name_suffix,contact_ssn,contact_email,sele_flag,org_flag,ult_flag,fallback_value, LOCAL),
    proxid,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,source,source_record_id,company_name,company_name_prefix,cnp_name,cnp_number,cnp_btype,cnp_lowv,company_phone_3,company_phone_3_ex,company_phone_7,company_fein,company_sic_code1,prim_range,prim_name,sec_range,city,city_clean,st,zip,company_url,isContact,contact_did,title,fname,fname_preferred,mname,lname,name_suffix,contact_ssn,contact_email,sele_flag,org_flag,ult_flag,fallback_value, LOCAL);
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
  SALT37.UIDType proxid1;
  SALT37.UIDType proxid2;
  SALT37.UIDType rcid1 := 0;
  SALT37.UIDType rcid2 := 0;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0} AND NOT [cnp_name,company_url]; // remove wordbag fields which need to be expanded
  INTEGER2 parent_proxid_weight100 := 0; // Contains 100x the specificity
  BOOLEAN parent_proxid_isnull := (h0.parent_proxid  IN SET(s.nulls_parent_proxid,parent_proxid) OR h0.parent_proxid = (TYPEOF(h0.parent_proxid))''); // Simplify later processing 
  INTEGER2 sele_proxid_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sele_proxid_isnull := (h0.sele_proxid  IN SET(s.nulls_sele_proxid,sele_proxid) OR h0.sele_proxid = (TYPEOF(h0.sele_proxid))''); // Simplify later processing 
  INTEGER2 org_proxid_weight100 := 0; // Contains 100x the specificity
  BOOLEAN org_proxid_isnull := (h0.org_proxid  IN SET(s.nulls_org_proxid,org_proxid) OR h0.org_proxid = (TYPEOF(h0.org_proxid))''); // Simplify later processing 
  INTEGER2 ultimate_proxid_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ultimate_proxid_isnull := (h0.ultimate_proxid  IN SET(s.nulls_ultimate_proxid,ultimate_proxid) OR h0.ultimate_proxid = (TYPEOF(h0.ultimate_proxid))''); // Simplify later processing 
  INTEGER2 source_weight100 := 0; // Contains 100x the specificity
  BOOLEAN source_isnull := (h0.source  IN SET(s.nulls_source,source) OR h0.source = (TYPEOF(h0.source))''); // Simplify later processing 
  INTEGER2 source_record_id_weight100 := 0; // Contains 100x the specificity
  BOOLEAN source_record_id_isnull := (h0.source_record_id  IN SET(s.nulls_source_record_id,source_record_id) OR h0.source_record_id = (TYPEOF(h0.source_record_id))''); // Simplify later processing 
  INTEGER2 company_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_name_isnull := (h0.company_name  IN SET(s.nulls_company_name,company_name) OR h0.company_name = (TYPEOF(h0.company_name))''); // Simplify later processing 
  INTEGER2 company_name_prefix_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_name_prefix_isnull := (h0.company_name_prefix  IN SET(s.nulls_company_name_prefix,company_name_prefix) OR h0.company_name_prefix = (TYPEOF(h0.company_name_prefix))''); // Simplify later processing 
  STRING240 cnp_name := h0.cnp_name; // Expanded wordbag field
  INTEGER2 cnp_name_weight100 := 0; // Contains 100x the specificity
  INTEGER2 cnp_name_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_name_isnull := (h0.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR h0.cnp_name = (TYPEOF(h0.cnp_name))''); // Simplify later processing 
  INTEGER2 cnp_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_number_isnull := (h0.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR h0.cnp_number = (TYPEOF(h0.cnp_number))''); // Simplify later processing 
  INTEGER2 cnp_btype_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_btype_isnull := (h0.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR h0.cnp_btype = (TYPEOF(h0.cnp_btype))''); // Simplify later processing 
  INTEGER2 cnp_lowv_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_lowv_isnull := (h0.cnp_lowv  IN SET(s.nulls_cnp_lowv,cnp_lowv) OR h0.cnp_lowv = (TYPEOF(h0.cnp_lowv))''); // Simplify later processing 
  INTEGER2 company_phone_3_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_phone_3_isnull := (h0.company_phone_3  IN SET(s.nulls_company_phone_3,company_phone_3) OR h0.company_phone_3 = (TYPEOF(h0.company_phone_3))''); // Simplify later processing 
  INTEGER2 company_phone_3_ex_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_phone_3_ex_isnull := (h0.company_phone_3_ex  IN SET(s.nulls_company_phone_3_ex,company_phone_3_ex) OR h0.company_phone_3_ex = (TYPEOF(h0.company_phone_3_ex))''); // Simplify later processing 
  INTEGER2 company_phone_7_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_phone_7_isnull := (h0.company_phone_7  IN SET(s.nulls_company_phone_7,company_phone_7) OR h0.company_phone_7 = (TYPEOF(h0.company_phone_7))''); // Simplify later processing 
  INTEGER2 company_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_fein_isnull := (h0.company_fein  IN SET(s.nulls_company_fein,company_fein) OR h0.company_fein = (TYPEOF(h0.company_fein))''); // Simplify later processing 
  UNSIGNED company_fein_cnt := 0; // Number of instances with this particular field value
  UNSIGNED company_fein_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 company_sic_code1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_sic_code1_isnull := (h0.company_sic_code1  IN SET(s.nulls_company_sic_code1,company_sic_code1) OR h0.company_sic_code1 = (TYPEOF(h0.company_sic_code1))''); // Simplify later processing 
  INTEGER2 prim_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_isnull := (h0.prim_range  IN SET(s.nulls_prim_range,prim_range) OR h0.prim_range = (TYPEOF(h0.prim_range))''); // Simplify later processing 
  UNSIGNED prim_range_cnt := 0; // Number of instances with this particular field value
  UNSIGNED prim_range_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 prim_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_isnull := (h0.prim_name  IN SET(s.nulls_prim_name,prim_name) OR h0.prim_name = (TYPEOF(h0.prim_name))''); // Simplify later processing 
  UNSIGNED prim_name_cnt := 0; // Number of instances with this particular field value
  UNSIGNED prim_name_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 sec_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sec_range_isnull := (h0.sec_range  IN SET(s.nulls_sec_range,sec_range) OR h0.sec_range = (TYPEOF(h0.sec_range))''); // Simplify later processing 
  UNSIGNED sec_range_cnt := 0; // Number of instances with this particular field value
  UNSIGNED sec_range_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 city_weight100 := 0; // Contains 100x the specificity
  BOOLEAN city_isnull := (h0.city  IN SET(s.nulls_city,city) OR h0.city = (TYPEOF(h0.city))''); // Simplify later processing 
  UNSIGNED city_cnt := 0; // Number of instances with this particular field value
  UNSIGNED city_p_cnt := 0; // Number of names instances matching this one phonetically
  UNSIGNED city_e2_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED city_e2p_cnt := 0; // Number of names instances matching this one by edit distance and phonetics
  INTEGER2 city_clean_weight100 := 0; // Contains 100x the specificity
  BOOLEAN city_clean_isnull := (h0.city_clean  IN SET(s.nulls_city_clean,city_clean) OR h0.city_clean = (TYPEOF(h0.city_clean))''); // Simplify later processing 
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := (h0.st  IN SET(s.nulls_st,st) OR h0.st = (TYPEOF(h0.st))''); // Simplify later processing 
  INTEGER2 zip_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip_isnull := (h0.zip  IN SET(s.nulls_zip,zip) OR h0.zip = (TYPEOF(h0.zip))''); // Simplify later processing 
  STRING240 company_url := h0.company_url; // Expanded wordbag field
  INTEGER2 company_url_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_url_isnull := (h0.company_url  IN SET(s.nulls_company_url,company_url) OR h0.company_url = (TYPEOF(h0.company_url))''); // Simplify later processing 
  INTEGER2 isContact_weight100 := 0; // Contains 100x the specificity
  BOOLEAN isContact_isnull := (h0.isContact  IN SET(s.nulls_isContact,isContact) OR h0.isContact = (TYPEOF(h0.isContact))''); // Simplify later processing 
  INTEGER2 contact_did_weight100 := 0; // Contains 100x the specificity
  BOOLEAN contact_did_isnull := (h0.contact_did  IN SET(s.nulls_contact_did,contact_did) OR h0.contact_did = (TYPEOF(h0.contact_did))''); // Simplify later processing 
  INTEGER2 title_weight100 := 0; // Contains 100x the specificity
  BOOLEAN title_isnull := (h0.title  IN SET(s.nulls_title,title) OR h0.title = (TYPEOF(h0.title))''); // Simplify later processing 
  INTEGER2 fname_weight100 := 0; // Contains 100x the specificity
  INTEGER2 fname_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN fname_isnull := (h0.fname  IN SET(s.nulls_fname,fname) OR h0.fname = (TYPEOF(h0.fname))''); // Simplify later processing 
  UNSIGNED fname_cnt := 0; // Number of instances with this particular field value
  UNSIGNED fname_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 fname_preferred_weight100 := 0; // Contains 100x the specificity
  BOOLEAN fname_preferred_isnull := (h0.fname_preferred  IN SET(s.nulls_fname_preferred,fname_preferred) OR h0.fname_preferred = (TYPEOF(h0.fname_preferred))''); // Simplify later processing 
  INTEGER2 mname_weight100 := 0; // Contains 100x the specificity
  INTEGER2 mname_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN mname_isnull := (h0.mname  IN SET(s.nulls_mname,mname) OR h0.mname = (TYPEOF(h0.mname))''); // Simplify later processing 
  UNSIGNED mname_cnt := 0; // Number of instances with this particular field value
  UNSIGNED mname_e2_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 lname_weight100 := 0; // Contains 100x the specificity
  INTEGER2 lname_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN lname_isnull := (h0.lname  IN SET(s.nulls_lname,lname) OR h0.lname = (TYPEOF(h0.lname))''); // Simplify later processing 
  UNSIGNED lname_cnt := 0; // Number of instances with this particular field value
  UNSIGNED lname_e2_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 name_suffix_weight100 := 0; // Contains 100x the specificity
  BOOLEAN name_suffix_isnull := (h0.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR h0.name_suffix = (TYPEOF(h0.name_suffix))''); // Simplify later processing 
  UNSIGNED name_suffix_cnt := 0; // Number of instances with this particular field value
  STRING5 name_suffix_NormSuffix := (STRING5)'';
  UNSIGNED name_suffix_NormSuffix_cnt := 0; // Number of names instances matching this one using NormSuffix
  INTEGER2 contact_ssn_weight100 := 0; // Contains 100x the specificity
  BOOLEAN contact_ssn_isnull := (h0.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn) OR h0.contact_ssn = (TYPEOF(h0.contact_ssn))''); // Simplify later processing 
  INTEGER2 contact_email_weight100 := 0; // Contains 100x the specificity
  BOOLEAN contact_email_isnull := (h0.contact_email  IN SET(s.nulls_contact_email,contact_email) OR h0.contact_email = (TYPEOF(h0.contact_email))''); // Simplify later processing 
  INTEGER2 sele_flag_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sele_flag_isnull := (h0.sele_flag  IN SET(s.nulls_sele_flag,sele_flag) OR h0.sele_flag = (TYPEOF(h0.sele_flag))''); // Simplify later processing 
  INTEGER2 org_flag_weight100 := 0; // Contains 100x the specificity
  BOOLEAN org_flag_isnull := (h0.org_flag  IN SET(s.nulls_org_flag,org_flag) OR h0.org_flag = (TYPEOF(h0.org_flag))''); // Simplify later processing 
  INTEGER2 ult_flag_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ult_flag_isnull := (h0.ult_flag  IN SET(s.nulls_ult_flag,ult_flag) OR h0.ult_flag = (TYPEOF(h0.ult_flag))''); // Simplify later processing 
  INTEGER2 fallback_value_weight100 := 0; // Contains 100x the specificity
  BOOLEAN fallback_value_isnull := (h0.fallback_value  IN SET(s.nulls_fallback_value,fallback_value) OR h0.fallback_value = (TYPEOF(h0.fallback_value))''); // Simplify later processing 
  INTEGER2 CONTACTNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CONTACTNAME_isnull := ((h0.fname  IN SET(s.nulls_fname,fname) OR h0.fname = (TYPEOF(h0.fname))'') AND (h0.mname  IN SET(s.nulls_mname,mname) OR h0.mname = (TYPEOF(h0.mname))'') AND (h0.lname  IN SET(s.nulls_lname,lname) OR h0.lname = (TYPEOF(h0.lname))'')); // Simplify later processing 
  INTEGER2 STREETADDRESS_weight100 := 0; // Contains 100x the specificity
  BOOLEAN STREETADDRESS_isnull := ((h0.prim_range  IN SET(s.nulls_prim_range,prim_range) OR h0.prim_range = (TYPEOF(h0.prim_range))'') AND (h0.prim_name  IN SET(s.nulls_prim_name,prim_name) OR h0.prim_name = (TYPEOF(h0.prim_name))'') AND (h0.sec_range  IN SET(s.nulls_sec_range,sec_range) OR h0.sec_range = (TYPEOF(h0.sec_range))'')); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
 
//Would also create auto-id fields here
 
layout_candidates add_ult_flag(layout_candidates le,Specificities(ih).ult_flag_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ult_flag_weight100 := MAP (le.ult_flag_isnull => 0, patch_default and ri.field_specificity=0 => s.ult_flag_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j45 := JOIN(h1,PULL(Specificities(ih).ult_flag_values_persisted),LEFT.ult_flag=RIGHT.ult_flag,add_ult_flag(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_org_flag(layout_candidates le,Specificities(ih).org_flag_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.org_flag_weight100 := MAP (le.org_flag_isnull => 0, patch_default and ri.field_specificity=0 => s.org_flag_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j44 := JOIN(j45,PULL(Specificities(ih).org_flag_values_persisted),LEFT.org_flag=RIGHT.org_flag,add_org_flag(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_sele_flag(layout_candidates le,Specificities(ih).sele_flag_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sele_flag_weight100 := MAP (le.sele_flag_isnull => 0, patch_default and ri.field_specificity=0 => s.sele_flag_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j43 := JOIN(j44,PULL(Specificities(ih).sele_flag_values_persisted),LEFT.sele_flag=RIGHT.sele_flag,add_sele_flag(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_fallback_value(layout_candidates le,Specificities(ih).fallback_value_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.fallback_value_weight100 := MAP (le.fallback_value_isnull => 0, patch_default and ri.field_specificity=0 => s.fallback_value_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j37 := JOIN(j43,PULL(Specificities(ih).fallback_value_values_persisted),LEFT.fallback_value=RIGHT.fallback_value,add_fallback_value(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_title(layout_candidates le,Specificities(ih).title_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.title_weight100 := MAP (le.title_isnull => 0, patch_default and ri.field_specificity=0 => s.title_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j36 := JOIN(j37,PULL(Specificities(ih).title_values_persisted),LEFT.title=RIGHT.title,add_title(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_isContact(layout_candidates le,Specificities(ih).isContact_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.isContact_weight100 := MAP (le.isContact_isnull => 0, patch_default and ri.field_specificity=0 => s.isContact_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j35 := JOIN(j36,PULL(Specificities(ih).isContact_values_persisted),LEFT.isContact=RIGHT.isContact,add_isContact(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cnp_btype(layout_candidates le,Specificities(ih).cnp_btype_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_btype_weight100 := MAP (le.cnp_btype_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_btype_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j34 := JOIN(j35,PULL(Specificities(ih).cnp_btype_values_persisted),LEFT.cnp_btype=RIGHT.cnp_btype,add_cnp_btype(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_source(layout_candidates le,Specificities(ih).source_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.source_weight100 := MAP (le.source_isnull => 0, patch_default and ri.field_specificity=0 => s.source_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j33 := JOIN(j34,PULL(Specificities(ih).source_values_persisted),LEFT.source=RIGHT.source,add_source(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_st(layout_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j32 := JOIN(j33,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_st(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cnp_lowv(layout_candidates le,Specificities(ih).cnp_lowv_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_lowv_weight100 := MAP (le.cnp_lowv_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_lowv_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j31 := JOIN(j32,PULL(Specificities(ih).cnp_lowv_values_persisted),LEFT.cnp_lowv=RIGHT.cnp_lowv,add_cnp_lowv(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_name_suffix(layout_candidates le,Specificities(ih).name_suffix_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.name_suffix_cnt := ri.cnt;
  SELF.name_suffix_NormSuffix_cnt := ri.NormSuffix_cnt; // Copy in count of matching NormSuffix values for field name_suffix
  SELF.name_suffix_NormSuffix := ri.name_suffix_NormSuffix; // Copy NormSuffix value for field name_suffix
  SELF.name_suffix_weight100 := MAP (le.name_suffix_isnull => 0, patch_default and ri.field_specificity=0 => s.name_suffix_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j31,s.nulls_name_suffix,Specificities(ih).name_suffix_values_persisted,name_suffix,name_suffix_weight100,add_name_suffix,j30);
layout_candidates add_fname(layout_candidates le,Specificities(ih).fname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.fname_cnt := ri.cnt;
  SELF.fname_e1_cnt := ri.e1_cnt;
  SELF.fname_weight100 := MAP (le.fname_isnull => 0, patch_default and ri.field_specificity=0 => s.fname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.fname_initial_char_weight100 := MAP (le.fname_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j30,s.nulls_fname,Specificities(ih).fname_values_persisted,fname,fname_weight100,add_fname,j29);
layout_candidates add_mname(layout_candidates le,Specificities(ih).mname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.mname_cnt := ri.cnt;
  SELF.mname_e2_cnt := ri.e2_cnt;
  SELF.mname_weight100 := MAP (le.mname_isnull => 0, patch_default and ri.field_specificity=0 => s.mname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.mname_initial_char_weight100 := MAP (le.mname_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j29,s.nulls_mname,Specificities(ih).mname_values_persisted,mname,mname_weight100,add_mname,j28);
layout_candidates add_fname_preferred(layout_candidates le,Specificities(ih).fname_preferred_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.fname_preferred_weight100 := MAP (le.fname_preferred_isnull => 0, patch_default and ri.field_specificity=0 => s.fname_preferred_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j28,s.nulls_fname_preferred,Specificities(ih).fname_preferred_values_persisted,fname_preferred,fname_preferred_weight100,add_fname_preferred,j27);
layout_candidates add_company_phone_3_ex(layout_candidates le,Specificities(ih).company_phone_3_ex_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_phone_3_ex_weight100 := MAP (le.company_phone_3_ex_isnull => 0, patch_default and ri.field_specificity=0 => s.company_phone_3_ex_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j27,s.nulls_company_phone_3_ex,Specificities(ih).company_phone_3_ex_values_persisted,company_phone_3_ex,company_phone_3_ex_weight100,add_company_phone_3_ex,j26);
layout_candidates add_company_phone_3(layout_candidates le,Specificities(ih).company_phone_3_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_phone_3_weight100 := MAP (le.company_phone_3_isnull => 0, patch_default and ri.field_specificity=0 => s.company_phone_3_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j26,s.nulls_company_phone_3,Specificities(ih).company_phone_3_values_persisted,company_phone_3,company_phone_3_weight100,add_company_phone_3,j25);
layout_candidates add_lname(layout_candidates le,Specificities(ih).lname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.lname_cnt := ri.cnt;
  SELF.lname_e2_cnt := ri.e2_cnt;
  SELF.lname_weight100 := MAP (le.lname_isnull => 0, patch_default and ri.field_specificity=0 => s.lname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.lname_initial_char_weight100 := MAP (le.lname_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j25,s.nulls_lname,Specificities(ih).lname_values_persisted,lname,lname_weight100,add_lname,j24);
layout_candidates add_company_sic_code1(layout_candidates le,Specificities(ih).company_sic_code1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_sic_code1_weight100 := MAP (le.company_sic_code1_isnull => 0, patch_default and ri.field_specificity=0 => s.company_sic_code1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j24,s.nulls_company_sic_code1,Specificities(ih).company_sic_code1_values_persisted,company_sic_code1,company_sic_code1_weight100,add_company_sic_code1,j23);
layout_candidates add_city_clean(layout_candidates le,Specificities(ih).city_clean_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.city_clean_weight100 := MAP (le.city_clean_isnull => 0, patch_default and ri.field_specificity=0 => s.city_clean_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j23,s.nulls_city_clean,Specificities(ih).city_clean_values_persisted,city_clean,city_clean_weight100,add_city_clean,j22);
layout_candidates add_city(layout_candidates le,Specificities(ih).city_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.city_cnt := ri.cnt;
  SELF.city_p_cnt := ri.p_cnt;
  SELF.city_e2_cnt := ri.e2_cnt;
  SELF.city_e2p_cnt := ri.e2p_cnt;
  SELF.city_weight100 := MAP (le.city_isnull => 0, patch_default and ri.field_specificity=0 => s.city_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j22,s.nulls_city,Specificities(ih).city_values_persisted,city,city_weight100,add_city,j21);
layout_candidates add_sec_range(layout_candidates le,Specificities(ih).sec_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sec_range_cnt := ri.cnt;
  SELF.sec_range_e1_cnt := ri.e1_cnt;
  SELF.sec_range_weight100 := MAP (le.sec_range_isnull => 0, patch_default and ri.field_specificity=0 => s.sec_range_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j21,s.nulls_sec_range,Specificities(ih).sec_range_values_persisted,sec_range,sec_range_weight100,add_sec_range,j20);
layout_candidates add_prim_range(layout_candidates le,Specificities(ih).prim_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_cnt := ri.cnt;
  SELF.prim_range_e1_cnt := ri.e1_cnt;
  SELF.prim_range_weight100 := MAP (le.prim_range_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j20,s.nulls_prim_range,Specificities(ih).prim_range_values_persisted,prim_range,prim_range_weight100,add_prim_range,j19);
layout_candidates add_cnp_number(layout_candidates le,Specificities(ih).cnp_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_number_weight100 := MAP (le.cnp_number_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j19,s.nulls_cnp_number,Specificities(ih).cnp_number_values_persisted,cnp_number,cnp_number_weight100,add_cnp_number,j18);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip_weight100 := MAP (le.zip_isnull => 0, patch_default and ri.field_specificity=0 => s.zip_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j18,s.nulls_zip,Specificities(ih).zip_values_persisted,zip,zip_weight100,add_zip,j17);
layout_candidates add_prim_name(layout_candidates le,Specificities(ih).prim_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_cnt := ri.cnt;
  SELF.prim_name_e1_cnt := ri.e1_cnt;
  SELF.prim_name_weight100 := MAP (le.prim_name_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j17,s.nulls_prim_name,Specificities(ih).prim_name_values_persisted,prim_name,prim_name_weight100,add_prim_name,j16);
layout_candidates add_company_name_prefix(layout_candidates le,Specificities(ih).company_name_prefix_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_name_prefix_weight100 := MAP (le.company_name_prefix_isnull => 0, patch_default and ri.field_specificity=0 => s.company_name_prefix_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j16,s.nulls_company_name_prefix,Specificities(ih).company_name_prefix_values_persisted,company_name_prefix,company_name_prefix_weight100,add_company_name_prefix,j15);
layout_candidates add_STREETADDRESS(layout_candidates le,Specificities(ih).STREETADDRESS_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.STREETADDRESS_weight100 := MAP (le.STREETADDRESS_isnull => 0, patch_default and ri.field_specificity=0 => s.STREETADDRESS_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j15,s.nulls_STREETADDRESS,Specificities(ih).STREETADDRESS_values_persisted,STREETADDRESS,STREETADDRESS_weight100,add_STREETADDRESS,j14);
layout_candidates add_CONTACTNAME(layout_candidates le,Specificities(ih).CONTACTNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.CONTACTNAME_weight100 := MAP (le.CONTACTNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.CONTACTNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j14,s.nulls_CONTACTNAME,Specificities(ih).CONTACTNAME_values_persisted,CONTACTNAME,CONTACTNAME_weight100,add_CONTACTNAME,j13);
layout_candidates add_company_phone_7(layout_candidates le,Specificities(ih).company_phone_7_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_phone_7_weight100 := MAP (le.company_phone_7_isnull => 0, patch_default and ri.field_specificity=0 => s.company_phone_7_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j13,s.nulls_company_phone_7,Specificities(ih).company_phone_7_values_persisted,company_phone_7,company_phone_7_weight100,add_company_phone_7,j12);
layout_candidates add_contact_did(layout_candidates le,Specificities(ih).contact_did_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.contact_did_weight100 := MAP (le.contact_did_isnull => 0, patch_default and ri.field_specificity=0 => s.contact_did_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j12,s.nulls_contact_did,Specificities(ih).contact_did_values_persisted,contact_did,contact_did_weight100,add_contact_did,j11);
layout_candidates add_company_fein(layout_candidates le,Specificities(ih).company_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_fein_cnt := ri.cnt;
  SELF.company_fein_e1_cnt := ri.e1_cnt;
  SELF.company_fein_weight100 := MAP (le.company_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.company_fein_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j11,s.nulls_company_fein,Specificities(ih).company_fein_values_persisted,company_fein,company_fein_weight100,add_company_fein,j10);
layout_candidates add_cnp_name(layout_candidates le,Specificities(ih).cnp_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_name_weight100 := MAP (le.cnp_name_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.cnp_name_initial_char_weight100 := MAP (le.cnp_name_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF.cnp_name := IF( ri.field_specificity<>0 or ri.word<>'',SELF.cnp_name_weight100+' '+ri.word,SALT37.Fn_WordBag_AppendSpecs_Fake(le.cnp_name, s.cnp_name_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j10,s.nulls_cnp_name,Specificities(ih).cnp_name_values_persisted,cnp_name,cnp_name_weight100,add_cnp_name,j9);
layout_candidates add_company_name(layout_candidates le,Specificities(ih).company_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_name_weight100 := MAP (le.company_name_isnull => 0, patch_default and ri.field_specificity=0 => s.company_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j9,s.nulls_company_name,Specificities(ih).company_name_values_persisted,company_name,company_name_weight100,add_company_name,j8);
layout_candidates add_contact_email(layout_candidates le,Specificities(ih).contact_email_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.contact_email_weight100 := MAP (le.contact_email_isnull => 0, patch_default and ri.field_specificity=0 => s.contact_email_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j8,s.nulls_contact_email,Specificities(ih).contact_email_values_persisted,contact_email,contact_email_weight100,add_contact_email,j7);
layout_candidates add_contact_ssn(layout_candidates le,Specificities(ih).contact_ssn_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.contact_ssn_weight100 := MAP (le.contact_ssn_isnull => 0, patch_default and ri.field_specificity=0 => s.contact_ssn_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j7,s.nulls_contact_ssn,Specificities(ih).contact_ssn_values_persisted,contact_ssn,contact_ssn_weight100,add_contact_ssn,j6);
layout_candidates add_company_url(layout_candidates le,Specificities(ih).company_url_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_url_weight100 := MAP (le.company_url_isnull => 0, patch_default and ri.field_specificity=0 => s.company_url_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.company_url := IF( ri.field_specificity<>0 or ri.word<>'',SELF.company_url_weight100+' '+ri.word,SALT37.Fn_WordBag_AppendSpecs_Fake(le.company_url, s.company_url_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j6,s.nulls_company_url,Specificities(ih).company_url_values_persisted,company_url,company_url_weight100,add_company_url,j5);
layout_candidates add_source_record_id(layout_candidates le,Specificities(ih).source_record_id_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.source_record_id_weight100 := MAP (le.source_record_id_isnull => 0, patch_default and ri.field_specificity=0 => s.source_record_id_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j5,s.nulls_source_record_id,Specificities(ih).source_record_id_values_persisted,source_record_id,source_record_id_weight100,add_source_record_id,j4);
layout_candidates add_ultimate_proxid(layout_candidates le,Specificities(ih).ultimate_proxid_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ultimate_proxid_weight100 := MAP (le.ultimate_proxid_isnull => 0, patch_default and ri.field_specificity=0 => s.ultimate_proxid_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j4,s.nulls_ultimate_proxid,Specificities(ih).ultimate_proxid_values_persisted,ultimate_proxid,ultimate_proxid_weight100,add_ultimate_proxid,j3);
layout_candidates add_org_proxid(layout_candidates le,Specificities(ih).org_proxid_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.org_proxid_weight100 := MAP (le.org_proxid_isnull => 0, patch_default and ri.field_specificity=0 => s.org_proxid_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j3,s.nulls_org_proxid,Specificities(ih).org_proxid_values_persisted,org_proxid,org_proxid_weight100,add_org_proxid,j2);
layout_candidates add_sele_proxid(layout_candidates le,Specificities(ih).sele_proxid_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sele_proxid_weight100 := MAP (le.sele_proxid_isnull => 0, patch_default and ri.field_specificity=0 => s.sele_proxid_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j2,s.nulls_sele_proxid,Specificities(ih).sele_proxid_values_persisted,sele_proxid,sele_proxid_weight100,add_sele_proxid,j1);
layout_candidates add_parent_proxid(layout_candidates le,Specificities(ih).parent_proxid_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.parent_proxid_weight100 := MAP (le.parent_proxid_isnull => 0, patch_default and ri.field_specificity=0 => s.parent_proxid_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j1,s.nulls_parent_proxid,Specificities(ih).parent_proxid_values_persisted,parent_proxid,parent_proxid_weight100,add_parent_proxid,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(proxid)) : PERSIST('~temp::proxid::BizLinkFull::mc',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.parent_proxid_weight100 + Annotated.sele_proxid_weight100 + Annotated.org_proxid_weight100 + Annotated.ultimate_proxid_weight100 + Annotated.source_record_id_weight100 + Annotated.company_url_weight100 + Annotated.contact_ssn_weight100 + Annotated.contact_email_weight100 + Annotated.company_name_weight100 + Annotated.cnp_name_weight100 + Annotated.company_fein_weight100 + Annotated.contact_did_weight100 + Annotated.company_phone_7_weight100 + Annotated.CONTACTNAME_weight100 + Annotated.STREETADDRESS_weight100 + Annotated.company_name_prefix_weight100 + Annotated.zip_weight100 + Annotated.cnp_number_weight100 + Annotated.city_weight100 + Annotated.city_clean_weight100 + Annotated.company_sic_code1_weight100 + Annotated.company_phone_3_weight100 + Annotated.company_phone_3_ex_weight100 + Annotated.fname_preferred_weight100 + Annotated.name_suffix_weight100 + Annotated.cnp_lowv_weight100 + Annotated.st_weight100 + Annotated.source_weight100 + Annotated.cnp_btype_weight100 + Annotated.isContact_weight100 + Annotated.title_weight100 + Annotated.fallback_value_weight100 + Annotated.sele_flag_weight100 + Annotated.org_flag_weight100 + Annotated.ult_flag_weight100;
SHARED Linkable := TotalWeight >= Config_BIP.MatchThreshold;
EXPORT BuddyCounts := TABLE(Annotated,{ buddies, Cnt := COUNT(GROUP) }, buddies, FEW);
EXPORT HasBuddies := TABLE(Annotated(buddies>0), { rcid });
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
