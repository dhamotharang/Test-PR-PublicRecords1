// Begin code to produce match candidates
IMPORT SALT30,ut;
EXPORT match_candidates(DATASET(layout_DOT_Base) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := BasicMatch(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00(SALT_Partition<>'*'),{rcid,cnp_name,cnp_number,active_duns_number,active_enterprise_number,active_domestic_corp_key,hist_enterprise_number,hist_duns_number,hist_domestic_corp_key,foreign_corp_key,unk_corp_key,ebr_file_number,company_fein,company_phone,prim_range,prim_name_derived,sec_range,v_city_name,st,zip,company_csz,company_addr1,company_address,dt_first_seen,dt_last_seen,SALT_Partition,ultid,orgid,lgid3,Proxid}),HASH(Proxid));
 
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 cnp_name_pop := AVE(GROUP,IF(thin_table.cnp_name IN SET(s.nulls_cnp_name,cnp_name),0,100));
  REAL8 cnp_number_pop := AVE(GROUP,IF(thin_table.cnp_number IN SET(s.nulls_cnp_number,cnp_number),0,100));
  REAL8 active_duns_number_pop := AVE(GROUP,IF(thin_table.active_duns_number IN SET(s.nulls_active_duns_number,active_duns_number),0,100));
  REAL8 active_enterprise_number_pop := AVE(GROUP,IF(thin_table.active_enterprise_number IN SET(s.nulls_active_enterprise_number,active_enterprise_number),0,100));
  REAL8 active_domestic_corp_key_pop := AVE(GROUP,IF(thin_table.active_domestic_corp_key IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key),0,100));
  REAL8 hist_enterprise_number_pop := AVE(GROUP,IF(thin_table.hist_enterprise_number IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number),0,100));
  REAL8 hist_duns_number_pop := AVE(GROUP,IF(thin_table.hist_duns_number IN SET(s.nulls_hist_duns_number,hist_duns_number),0,100));
  REAL8 hist_domestic_corp_key_pop := AVE(GROUP,IF(thin_table.hist_domestic_corp_key IN SET(s.nulls_hist_domestic_corp_key,hist_domestic_corp_key),0,100));
  REAL8 foreign_corp_key_pop := AVE(GROUP,IF(thin_table.foreign_corp_key IN SET(s.nulls_foreign_corp_key,foreign_corp_key),0,100));
  REAL8 unk_corp_key_pop := AVE(GROUP,IF(thin_table.unk_corp_key IN SET(s.nulls_unk_corp_key,unk_corp_key),0,100));
  REAL8 ebr_file_number_pop := AVE(GROUP,IF(thin_table.ebr_file_number IN SET(s.nulls_ebr_file_number,ebr_file_number),0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF(thin_table.company_fein IN SET(s.nulls_company_fein,company_fein),0,100));
  REAL8 company_phone_pop := AVE(GROUP,IF(thin_table.company_phone IN SET(s.nulls_company_phone,company_phone),0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF(thin_table.prim_range IN SET(s.nulls_prim_range,prim_range),0,100));
  REAL8 prim_name_derived_pop := AVE(GROUP,IF(thin_table.prim_name_derived IN SET(s.nulls_prim_name_derived,prim_name_derived),0,100));
  REAL8 sec_range_pop := AVE(GROUP,IF(thin_table.sec_range IN SET(s.nulls_sec_range,sec_range),0,100));
  REAL8 v_city_name_pop := AVE(GROUP,IF(thin_table.v_city_name IN SET(s.nulls_v_city_name,v_city_name),0,100));
  REAL8 st_pop := AVE(GROUP,IF(thin_table.st IN SET(s.nulls_st,st),0,100));
  REAL8 zip_pop := AVE(GROUP,IF(thin_table.zip IN SET(s.nulls_zip,zip),0,100));
  REAL8 company_csz_pop := AVE(GROUP,IF(thin_table.company_csz IN SET(s.nulls_company_csz,company_csz),0,100));
  REAL8 company_addr1_pop := AVE(GROUP,IF(thin_table.company_addr1 IN SET(s.nulls_company_addr1,company_addr1),0,100));
  REAL8 company_address_pop := AVE(GROUP,IF(thin_table.company_address IN SET(s.nulls_company_address,company_address),0,100));
END;
EXPORT PrePropogationStats := TABLE(thin_table,PrePropCounts);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 cnp_number_prop := 0;
  UNSIGNED1 active_duns_number_prop := 0;
  UNSIGNED1 active_enterprise_number_prop := 0;
  UNSIGNED1 active_domestic_corp_key_prop := 0;
  UNSIGNED1 hist_enterprise_number_prop := 0;
  UNSIGNED1 hist_duns_number_prop := 0;
  UNSIGNED1 hist_domestic_corp_key_prop := 0;
  UNSIGNED1 foreign_corp_key_prop := 0;
  UNSIGNED1 unk_corp_key_prop := 0;
  UNSIGNED1 ebr_file_number_prop := 0;
  UNSIGNED1 company_fein_prop := 0;
  UNSIGNED1 company_phone_prop := 0;
  UNSIGNED1 prim_range_prop := 0;
  UNSIGNED1 prim_name_derived_prop := 0;
  UNSIGNED1 sec_range_prop := 0;
  UNSIGNED1 v_city_name_prop := 0;
  UNSIGNED1 st_prop := 0;
  UNSIGNED1 zip_prop := 0;
  UNSIGNED1 company_csz_prop := 0;
  UNSIGNED1 company_addr1_prop := 0;
  UNSIGNED1 company_address_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
SHARED ForeignCorpkey_prop0 := DISTRIBUTE( specificities(ih).ForeignCorpkey_values_persisted(Basis_cnt<20000), HASH(Proxid)); // Not guaranteed distributed by Proxid :(
 
SALT30.mac_prop_field(with_props(cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name)),cnp_name,Proxid,cnp_name_props); // For every DID find the best FULL cnp_name
SHARED ForeignCorpkey_prop1 := JOIN(ForeignCorpkey_prop0,cnp_name_props,left.Proxid=right.Proxid,LOCAL);
 
SALT30.mac_prop_field(with_props(cnp_number NOT IN SET(s.nulls_cnp_number,cnp_number)),cnp_number,Proxid,cnp_number_props); // For every DID find the best FULL cnp_number
layout_withpropvars take_cnp_number(with_props le,cnp_number_props ri) := TRANSFORM
  SELF.cnp_number := IF ( le.cnp_number IN SET(s.nulls_cnp_number,cnp_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.cnp_number, le.cnp_number );
  SELF.cnp_number_prop := le.cnp_number_prop + IF ( le.cnp_number IN SET(s.nulls_cnp_number,cnp_number) and ri.cnp_number NOT IN SET(s.nulls_cnp_number,cnp_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj1 := JOIN(with_props,cnp_number_props,left.Proxid=right.Proxid,take_cnp_number(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*/);  //HACK comment out hint(parallel_match) for now

SHARED ForeignCorpkey_prop2 := JOIN(ForeignCorpkey_prop1,cnp_number_props,left.Proxid=right.Proxid,LOCAL);
 
SALT30.mac_prop_field(with_props(active_duns_number NOT IN SET(s.nulls_active_duns_number,active_duns_number)),active_duns_number,Proxid,active_duns_number_props); // For every DID find the best FULL active_duns_number
layout_withpropvars take_active_duns_number(with_props le,active_duns_number_props ri) := TRANSFORM
  SELF.active_duns_number := IF ( le.active_duns_number IN SET(s.nulls_active_duns_number,active_duns_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.active_duns_number, le.active_duns_number );
  SELF.active_duns_number_prop := le.active_duns_number_prop + IF ( le.active_duns_number IN SET(s.nulls_active_duns_number,active_duns_number) and ri.active_duns_number NOT IN SET(s.nulls_active_duns_number,active_duns_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj2 := JOIN(pj1,active_duns_number_props,left.Proxid=right.Proxid,take_active_duns_number(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*/);  //HACK comment out hint(parallel_match) for now

 
SALT30.mac_prop_field(with_props(active_enterprise_number NOT IN SET(s.nulls_active_enterprise_number,active_enterprise_number)),active_enterprise_number,Proxid,active_enterprise_number_props); // For every DID find the best FULL active_enterprise_number
layout_withpropvars take_active_enterprise_number(with_props le,active_enterprise_number_props ri) := TRANSFORM
  SELF.active_enterprise_number := IF ( le.active_enterprise_number IN SET(s.nulls_active_enterprise_number,active_enterprise_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.active_enterprise_number, le.active_enterprise_number );
  SELF.active_enterprise_number_prop := le.active_enterprise_number_prop + IF ( le.active_enterprise_number IN SET(s.nulls_active_enterprise_number,active_enterprise_number) and ri.active_enterprise_number NOT IN SET(s.nulls_active_enterprise_number,active_enterprise_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj3 := JOIN(pj2,active_enterprise_number_props,left.Proxid=right.Proxid,take_active_enterprise_number(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*/);  //HACK comment out hint(parallel_match) for now

SHARED ForeignCorpkey_prop3 := JOIN(ForeignCorpkey_prop2,active_enterprise_number_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
 
SALT30.mac_prop_field(with_props(active_domestic_corp_key NOT IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key)),active_domestic_corp_key,Proxid,active_domestic_corp_key_props); // For every DID find the best FULL active_domestic_corp_key
layout_withpropvars take_active_domestic_corp_key(with_props le,active_domestic_corp_key_props ri) := TRANSFORM
  SELF.active_domestic_corp_key := IF ( le.active_domestic_corp_key IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.active_domestic_corp_key, le.active_domestic_corp_key );
  SELF.active_domestic_corp_key_prop := le.active_domestic_corp_key_prop + IF ( le.active_domestic_corp_key IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) and ri.active_domestic_corp_key NOT IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj4 := JOIN(pj3,active_domestic_corp_key_props,left.Proxid=right.Proxid,take_active_domestic_corp_key(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*/);  //HACK comment out hint(parallel_match) for now

SHARED ForeignCorpkey_prop4 := JOIN(ForeignCorpkey_prop3,active_domestic_corp_key_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
 
SALT30.mac_prop_field(with_props(hist_enterprise_number NOT IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number)),hist_enterprise_number,Proxid,hist_enterprise_number_props); // For every DID find the best FULL hist_enterprise_number
layout_withpropvars take_hist_enterprise_number(with_props le,hist_enterprise_number_props ri) := TRANSFORM
  SELF.hist_enterprise_number := IF ( le.hist_enterprise_number IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.hist_enterprise_number, le.hist_enterprise_number );
  SELF.hist_enterprise_number_prop := le.hist_enterprise_number_prop + IF ( le.hist_enterprise_number IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number) and ri.hist_enterprise_number NOT IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj5 := JOIN(pj4,hist_enterprise_number_props,left.Proxid=right.Proxid,take_hist_enterprise_number(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*/);  //HACK comment out hint(parallel_match) for now

 
SALT30.mac_prop_field(with_props(hist_duns_number NOT IN SET(s.nulls_hist_duns_number,hist_duns_number)),hist_duns_number,Proxid,hist_duns_number_props); // For every DID find the best FULL hist_duns_number
layout_withpropvars take_hist_duns_number(with_props le,hist_duns_number_props ri) := TRANSFORM
  SELF.hist_duns_number := IF ( le.hist_duns_number IN SET(s.nulls_hist_duns_number,hist_duns_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.hist_duns_number, le.hist_duns_number );
  SELF.hist_duns_number_prop := le.hist_duns_number_prop + IF ( le.hist_duns_number IN SET(s.nulls_hist_duns_number,hist_duns_number) and ri.hist_duns_number NOT IN SET(s.nulls_hist_duns_number,hist_duns_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj6 := JOIN(pj5,hist_duns_number_props,left.Proxid=right.Proxid,take_hist_duns_number(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*/);  //HACK comment out hint(parallel_match) for now

 
SALT30.mac_prop_field(with_props(hist_domestic_corp_key NOT IN SET(s.nulls_hist_domestic_corp_key,hist_domestic_corp_key)),hist_domestic_corp_key,Proxid,hist_domestic_corp_key_props); // For every DID find the best FULL hist_domestic_corp_key
layout_withpropvars take_hist_domestic_corp_key(with_props le,hist_domestic_corp_key_props ri) := TRANSFORM
  SELF.hist_domestic_corp_key := IF ( le.hist_domestic_corp_key IN SET(s.nulls_hist_domestic_corp_key,hist_domestic_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.hist_domestic_corp_key, le.hist_domestic_corp_key );
  SELF.hist_domestic_corp_key_prop := le.hist_domestic_corp_key_prop + IF ( le.hist_domestic_corp_key IN SET(s.nulls_hist_domestic_corp_key,hist_domestic_corp_key) and ri.hist_domestic_corp_key NOT IN SET(s.nulls_hist_domestic_corp_key,hist_domestic_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj7 := JOIN(pj6,hist_domestic_corp_key_props,left.Proxid=right.Proxid,take_hist_domestic_corp_key(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*/);  //HACK comment out hint(parallel_match) for now

 
SALT30.mac_prop_field(with_props(foreign_corp_key NOT IN SET(s.nulls_foreign_corp_key,foreign_corp_key)),foreign_corp_key,Proxid,foreign_corp_key_props); // For every DID find the best FULL foreign_corp_key
layout_withpropvars take_foreign_corp_key(with_props le,foreign_corp_key_props ri) := TRANSFORM
  SELF.foreign_corp_key := IF ( le.foreign_corp_key IN SET(s.nulls_foreign_corp_key,foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.foreign_corp_key, le.foreign_corp_key );
  SELF.foreign_corp_key_prop := le.foreign_corp_key_prop + IF ( le.foreign_corp_key IN SET(s.nulls_foreign_corp_key,foreign_corp_key) and ri.foreign_corp_key NOT IN SET(s.nulls_foreign_corp_key,foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj8 := JOIN(pj7,foreign_corp_key_props,left.Proxid=right.Proxid,take_foreign_corp_key(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*/);  //HACK comment out hint(parallel_match) for now

 
SALT30.mac_prop_field(with_props(unk_corp_key NOT IN SET(s.nulls_unk_corp_key,unk_corp_key)),unk_corp_key,Proxid,unk_corp_key_props); // For every DID find the best FULL unk_corp_key
layout_withpropvars take_unk_corp_key(with_props le,unk_corp_key_props ri) := TRANSFORM
  SELF.unk_corp_key := IF ( le.unk_corp_key IN SET(s.nulls_unk_corp_key,unk_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.unk_corp_key, le.unk_corp_key );
  SELF.unk_corp_key_prop := le.unk_corp_key_prop + IF ( le.unk_corp_key IN SET(s.nulls_unk_corp_key,unk_corp_key) and ri.unk_corp_key NOT IN SET(s.nulls_unk_corp_key,unk_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj9 := JOIN(pj8,unk_corp_key_props,left.Proxid=right.Proxid,take_unk_corp_key(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*/);  //HACK comment out hint(parallel_match) for now

 
SALT30.mac_prop_field(with_props(ebr_file_number NOT IN SET(s.nulls_ebr_file_number,ebr_file_number)),ebr_file_number,Proxid,ebr_file_number_props); // For every DID find the best FULL ebr_file_number
layout_withpropvars take_ebr_file_number(with_props le,ebr_file_number_props ri) := TRANSFORM
  SELF.ebr_file_number := IF ( le.ebr_file_number IN SET(s.nulls_ebr_file_number,ebr_file_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.ebr_file_number, le.ebr_file_number );
  SELF.ebr_file_number_prop := le.ebr_file_number_prop + IF ( le.ebr_file_number IN SET(s.nulls_ebr_file_number,ebr_file_number) and ri.ebr_file_number NOT IN SET(s.nulls_ebr_file_number,ebr_file_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj10 := JOIN(pj9,ebr_file_number_props,left.Proxid=right.Proxid,take_ebr_file_number(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*/);  //HACK comment out hint(parallel_match) for now

 
SALT30.mac_prop_field(with_props(company_fein NOT IN SET(s.nulls_company_fein,company_fein)),company_fein,Proxid,company_fein_props); // For every DID find the best FULL company_fein
layout_withpropvars take_company_fein(with_props le,company_fein_props ri) := TRANSFORM
  SELF.company_fein := IF ( le.company_fein IN SET(s.nulls_company_fein,company_fein) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.company_fein, le.company_fein );
  SELF.company_fein_prop := le.company_fein_prop + IF ( le.company_fein IN SET(s.nulls_company_fein,company_fein) and ri.company_fein NOT IN SET(s.nulls_company_fein,company_fein) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj11 := JOIN(pj10,company_fein_props,left.Proxid=right.Proxid,take_company_fein(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*/);  //HACK comment out hint(parallel_match) for now

 
SALT30.mac_prop_field(with_props(company_phone NOT IN SET(s.nulls_company_phone,company_phone)),company_phone,Proxid,company_phone_props); // For every DID find the best FULL company_phone
layout_withpropvars take_company_phone(with_props le,company_phone_props ri) := TRANSFORM
  SELF.company_phone := IF ( le.company_phone IN SET(s.nulls_company_phone,company_phone) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.company_phone, le.company_phone );
  SELF.company_phone_prop := le.company_phone_prop + IF ( le.company_phone IN SET(s.nulls_company_phone,company_phone) and ri.company_phone NOT IN SET(s.nulls_company_phone,company_phone) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj12 := JOIN(pj11,company_phone_props,left.Proxid=right.Proxid,take_company_phone(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*/);  //HACK comment out hint(parallel_match) for now

 
SALT30.mac_prop_field(with_props(prim_range NOT IN SET(s.nulls_prim_range,prim_range)),prim_range,Proxid,prim_range_props); // For every DID find the best FULL prim_range
SHARED ForeignCorpkey_prop5 := JOIN(ForeignCorpkey_prop4,prim_range_props,left.Proxid=right.Proxid,LOCAL);
 
SALT30.mac_prop_field(with_props(prim_name_derived NOT IN SET(s.nulls_prim_name_derived,prim_name_derived)),prim_name_derived,Proxid,prim_name_derived_props); // For every DID find the best FULL prim_name_derived
SHARED ForeignCorpkey_prop6 := JOIN(ForeignCorpkey_prop5,prim_name_derived_props,left.Proxid=right.Proxid,LOCAL);
 
SALT30.mac_prop_field(with_props(sec_range NOT IN SET(s.nulls_sec_range,sec_range)),sec_range,Proxid,sec_range_props); // For every DID find the best FULL sec_range
layout_withpropvars take_sec_range(with_props le,sec_range_props ri) := TRANSFORM
  SELF.sec_range := IF ( le.sec_range IN SET(s.nulls_sec_range,sec_range) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.sec_range, le.sec_range );
  SELF.sec_range_prop := le.sec_range_prop + IF ( le.sec_range IN SET(s.nulls_sec_range,sec_range) and ri.sec_range NOT IN SET(s.nulls_sec_range,sec_range) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj15 := JOIN(pj12,sec_range_props,left.Proxid=right.Proxid,take_sec_range(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*/);  //HACK comment out hint(parallel_match) for now

 
SALT30.mac_prop_field(with_props(v_city_name NOT IN SET(s.nulls_v_city_name,v_city_name)),v_city_name,Proxid,v_city_name_props); // For every DID find the best FULL v_city_name
 
SALT30.mac_prop_field(with_props((SALT30.StrType)st<>(SALT30.StrType)''),st,Proxid,st_props_context); // For every DID find the best FULL st
SHARED ForeignCorpkey_prop7 := JOIN(ForeignCorpkey_prop6,v_city_name_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED ForeignCorpkey_prop8 := JOIN(ForeignCorpkey_prop7,st_props_context,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
 
SALT30.mac_prop_field(with_props(st NOT IN SET(s.nulls_st,st)),st,Proxid,st_props); // For every DID find the best FULL st
SHARED ForeignCorpkey_prop9 := JOIN(ForeignCorpkey_prop8,st_props,left.Proxid=right.Proxid,LOCAL);
 
SALT30.mac_prop_field(with_props(zip NOT IN SET(s.nulls_zip,zip)),zip,Proxid,zip_props); // For every DID find the best FULL zip
SHARED ForeignCorpkey_prop10 := JOIN(ForeignCorpkey_prop9,zip_props,left.Proxid=right.Proxid,LOCAL);
 
SALT30.mac_prop_field(with_props(company_csz NOT IN SET(s.nulls_company_csz,company_csz)),company_csz,Proxid,company_csz_props); // For every DID find the best FULL company_csz
ForeignCorpkey_prop11_layout := RECORD
  ForeignCorpkey_prop10;
  UNSIGNED4 company_csz;
END;
ForeignCorpkey_prop11_layout ForeignCorpkey_addconceptcompany_csz(ForeignCorpkey_prop10 le) := TRANSFORM
  SELF := le;
  self.company_csz := hash32((SALT30.StrType)le.v_city_name,(SALT30.StrType)le.st,(SALT30.StrType)le.zip); // Need to recompute hash as children have changed
END;
SHARED ForeignCorpkey_prop11 := PROJECT(ForeignCorpkey_prop10,ForeignCorpkey_addconceptcompany_csz(LEFT));
SHARED ForeignCorpkey_prp := ForeignCorpkey_prop11;
 
pj15 do_computes(pj15 le) := TRANSFORM
  SELF.company_csz := IF (Fields.InValid_company_csz((SALT30.StrType)le.v_city_name,(SALT30.StrType)le.st,(SALT30.StrType)le.zip),0,HASH32((SALT30.StrType)le.v_city_name,(SALT30.StrType)le.st,(SALT30.StrType)le.zip)); // Combine child fields into 1 for specificity counting
  SELF.company_addr1 := IF (Fields.InValid_company_addr1((SALT30.StrType)le.prim_range,(SALT30.StrType)le.prim_name_derived,(SALT30.StrType)le.sec_range),0,HASH32((SALT30.StrType)le.prim_range,(SALT30.StrType)le.prim_name_derived,(SALT30.StrType)le.sec_range)); // Combine child fields into 1 for specificity counting
  SELF.company_addr1_prop := IF( le.sec_range_prop > 0, 4, 0 );
  SELF.company_address := IF (Fields.InValid_company_address((SALT30.StrType)SELF.company_addr1,(SALT30.StrType)SELF.company_csz),0,HASH32((SALT30.StrType)SELF.company_addr1,(SALT30.StrType)SELF.company_csz)); // Combine child fields into 1 for specificity counting
  SELF.company_address_prop := IF( SELF.company_addr1_prop > 0, 1, 0 );
  SELF := le;
END;
SHARED propogated := PROJECT(pj15,do_computes(left)) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::mc_props::DOT_Base',EXPIRE(Config.PersistExpire)); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 cnp_name_pop := AVE(GROUP,IF(propogated.cnp_name IN SET(s.nulls_cnp_name,cnp_name),0,100));
  REAL8 cnp_number_pop := AVE(GROUP,IF(propogated.cnp_number IN SET(s.nulls_cnp_number,cnp_number),0,100));
  REAL8 active_duns_number_pop := AVE(GROUP,IF(propogated.active_duns_number IN SET(s.nulls_active_duns_number,active_duns_number),0,100));
  REAL8 active_enterprise_number_pop := AVE(GROUP,IF(propogated.active_enterprise_number IN SET(s.nulls_active_enterprise_number,active_enterprise_number),0,100));
  REAL8 active_domestic_corp_key_pop := AVE(GROUP,IF(propogated.active_domestic_corp_key IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key),0,100));
  REAL8 hist_enterprise_number_pop := AVE(GROUP,IF(propogated.hist_enterprise_number IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number),0,100));
  REAL8 hist_duns_number_pop := AVE(GROUP,IF(propogated.hist_duns_number IN SET(s.nulls_hist_duns_number,hist_duns_number),0,100));
  REAL8 hist_domestic_corp_key_pop := AVE(GROUP,IF(propogated.hist_domestic_corp_key IN SET(s.nulls_hist_domestic_corp_key,hist_domestic_corp_key),0,100));
  REAL8 foreign_corp_key_pop := AVE(GROUP,IF(propogated.foreign_corp_key IN SET(s.nulls_foreign_corp_key,foreign_corp_key),0,100));
  REAL8 unk_corp_key_pop := AVE(GROUP,IF(propogated.unk_corp_key IN SET(s.nulls_unk_corp_key,unk_corp_key),0,100));
  REAL8 ebr_file_number_pop := AVE(GROUP,IF(propogated.ebr_file_number IN SET(s.nulls_ebr_file_number,ebr_file_number),0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF(propogated.company_fein IN SET(s.nulls_company_fein,company_fein),0,100));
  REAL8 company_phone_pop := AVE(GROUP,IF(propogated.company_phone IN SET(s.nulls_company_phone,company_phone),0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF(propogated.prim_range IN SET(s.nulls_prim_range,prim_range),0,100));
  REAL8 prim_name_derived_pop := AVE(GROUP,IF(propogated.prim_name_derived IN SET(s.nulls_prim_name_derived,prim_name_derived),0,100));
  REAL8 sec_range_pop := AVE(GROUP,IF(propogated.sec_range IN SET(s.nulls_sec_range,sec_range),0,100));
  REAL8 v_city_name_pop := AVE(GROUP,IF(propogated.v_city_name IN SET(s.nulls_v_city_name,v_city_name),0,100));
  REAL8 st_pop := AVE(GROUP,IF(propogated.st IN SET(s.nulls_st,st),0,100));
  REAL8 zip_pop := AVE(GROUP,IF(propogated.zip IN SET(s.nulls_zip,zip),0,100));
  REAL8 company_csz_pop := AVE(GROUP,IF(propogated.company_csz IN SET(s.nulls_company_csz,company_csz),0,100));
  REAL8 company_addr1_pop := AVE(GROUP,IF(propogated.company_addr1 IN SET(s.nulls_company_addr1,company_addr1),0,100));
  REAL8 company_address_pop := AVE(GROUP,IF(propogated.company_address IN SET(s.nulls_company_address,company_address),0,100));
END;
EXPORT PostPropogationStats := TABLE(propogated,PostPropCounts);
SHARED h0 := DEDUP( SORT ( DISTRIBUTE(propogated,HASH(Proxid)),  EXCEPT rcid, LOCAL ), EXCEPT rcid, LOCAL );// Only one copy of each record
 
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT30.UIDType Proxid1;
  SALT30.UIDType Proxid2;
  SALT30.UIDType rcid1 := 0;
  SALT30.UIDType rcid2 := 0;
END;
EXPORT Layout_Attribute_Matches := RECORD(layout_matches),MAXLENGTH(32000)
  SALT30.StrType source_id;
END;
EXPORT Layout_ForeignCorpkey_Candidates := RECORD
  {ForeignCorpkey_prp};
  INTEGER2 cnp_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_name_isnull := ForeignCorpkey_prp.cnp_name  IN SET(s.nulls_cnp_name,cnp_name); // Simplify later processing 
  INTEGER2 cnp_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_number_isnull := ForeignCorpkey_prp.cnp_number  IN SET(s.nulls_cnp_number,cnp_number); // Simplify later processing 
  INTEGER2 active_enterprise_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_enterprise_number_isnull := ForeignCorpkey_prp.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number); // Simplify later processing 
  INTEGER2 active_domestic_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_domestic_corp_key_isnull := ForeignCorpkey_prp.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key); // Simplify later processing 
  INTEGER2 prim_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_isnull := ForeignCorpkey_prp.prim_range  IN SET(s.nulls_prim_range,prim_range); // Simplify later processing 
  INTEGER2 prim_name_derived_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_derived_isnull := ForeignCorpkey_prp.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived); // Simplify later processing 
  INTEGER2 v_city_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN v_city_name_isnull := ForeignCorpkey_prp.v_city_name  IN SET(s.nulls_v_city_name,v_city_name); // Simplify later processing 
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := ForeignCorpkey_prp.st  IN SET(s.nulls_st,st); // Simplify later processing 
  INTEGER2 zip_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip_isnull := ForeignCorpkey_prp.zip  IN SET(s.nulls_zip,zip); // Simplify later processing 
  INTEGER2 company_csz_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_csz_isnull := (ForeignCorpkey_prp.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) AND ForeignCorpkey_prp.st  IN SET(s.nulls_st,st) AND ForeignCorpkey_prp.zip  IN SET(s.nulls_zip,zip)); // Simplify later processing 
END;
SHARED ForeignCorpkey_pp := TABLE(ForeignCorpkey_prp,Layout_ForeignCorpkey_Candidates);
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0};
  INTEGER2 cnp_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_name_isnull := h0.cnp_name  IN SET(s.nulls_cnp_name,cnp_name); // Simplify later processing 
  INTEGER2 cnp_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_number_isnull := h0.cnp_number  IN SET(s.nulls_cnp_number,cnp_number); // Simplify later processing 
  INTEGER2 active_duns_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_duns_number_isnull := h0.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number); // Simplify later processing 
  INTEGER2 active_enterprise_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_enterprise_number_isnull := h0.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number); // Simplify later processing 
  INTEGER2 active_domestic_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_domestic_corp_key_isnull := h0.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key); // Simplify later processing 
  INTEGER2 hist_enterprise_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN hist_enterprise_number_isnull := h0.hist_enterprise_number  IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number); // Simplify later processing 
  INTEGER2 hist_duns_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN hist_duns_number_isnull := h0.hist_duns_number  IN SET(s.nulls_hist_duns_number,hist_duns_number); // Simplify later processing 
  INTEGER2 hist_domestic_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN hist_domestic_corp_key_isnull := h0.hist_domestic_corp_key  IN SET(s.nulls_hist_domestic_corp_key,hist_domestic_corp_key); // Simplify later processing 
  INTEGER2 foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN foreign_corp_key_isnull := h0.foreign_corp_key  IN SET(s.nulls_foreign_corp_key,foreign_corp_key); // Simplify later processing 
  INTEGER2 unk_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN unk_corp_key_isnull := h0.unk_corp_key  IN SET(s.nulls_unk_corp_key,unk_corp_key); // Simplify later processing 
  INTEGER2 ebr_file_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ebr_file_number_isnull := h0.ebr_file_number  IN SET(s.nulls_ebr_file_number,ebr_file_number); // Simplify later processing 
  INTEGER2 company_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_fein_isnull := h0.company_fein  IN SET(s.nulls_company_fein,company_fein); // Simplify later processing 
  INTEGER2 company_phone_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_phone_isnull := h0.company_phone  IN SET(s.nulls_company_phone,company_phone); // Simplify later processing 
  INTEGER2 prim_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_isnull := h0.prim_range  IN SET(s.nulls_prim_range,prim_range); // Simplify later processing 
  INTEGER2 prim_name_derived_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_derived_isnull := h0.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived); // Simplify later processing 
  INTEGER2 sec_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sec_range_isnull := h0.sec_range  IN SET(s.nulls_sec_range,sec_range); // Simplify later processing 
  INTEGER2 v_city_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN v_city_name_isnull := h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name); // Simplify later processing 
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := h0.st  IN SET(s.nulls_st,st); // Simplify later processing 
  INTEGER2 zip_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip_isnull := h0.zip  IN SET(s.nulls_zip,zip); // Simplify later processing 
  INTEGER2 company_csz_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_csz_isnull := (h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) AND h0.st  IN SET(s.nulls_st,st) AND h0.zip  IN SET(s.nulls_zip,zip)); // Simplify later processing 
  INTEGER2 company_addr1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_addr1_isnull := (h0.prim_range  IN SET(s.nulls_prim_range,prim_range) AND h0.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived) AND h0.sec_range  IN SET(s.nulls_sec_range,sec_range)); // Simplify later processing 
  INTEGER2 company_address_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_address_isnull := ((h0.prim_range  IN SET(s.nulls_prim_range,prim_range) AND h0.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived) AND h0.sec_range  IN SET(s.nulls_sec_range,sec_range)) AND (h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) AND h0.st  IN SET(s.nulls_st,st) AND h0.zip  IN SET(s.nulls_zip,zip))); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
 
//Would also create auto-id fields here
 
layout_candidates add_st(layout_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j21 := JOIN(h1,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_st(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_v_city_name(layout_candidates le,Specificities(ih).v_city_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.v_city_name_weight100 := MAP (le.v_city_name_isnull => 0, patch_default and ri.field_specificity=0 => s.v_city_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j21,s.nulls_v_city_name,Specificities(ih).v_city_name_values_persisted,v_city_name,v_city_name_weight100,add_v_city_name,j20);
layout_candidates add_sec_range(layout_candidates le,Specificities(ih).sec_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sec_range_weight100 := MAP (le.sec_range_isnull => 0, patch_default and ri.field_specificity=0 => s.sec_range_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j20,s.nulls_sec_range,Specificities(ih).sec_range_values_persisted,sec_range,sec_range_weight100,add_sec_range,j19);
layout_candidates add_prim_range(layout_candidates le,Specificities(ih).prim_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_weight100 := MAP (le.prim_range_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j19,s.nulls_prim_range,Specificities(ih).prim_range_values_persisted,prim_range,prim_range_weight100,add_prim_range,j18);
layout_candidates add_company_csz(layout_candidates le,Specificities(ih).company_csz_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_csz_weight100 := MAP (le.company_csz_isnull => 0, patch_default and ri.field_specificity=0 => s.company_csz_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j18,s.nulls_company_csz,Specificities(ih).company_csz_values_persisted,company_csz,company_csz_weight100,add_company_csz,j17);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip_weight100 := MAP (le.zip_isnull => 0, patch_default and ri.field_specificity=0 => s.zip_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j17,s.nulls_zip,Specificities(ih).zip_values_persisted,zip,zip_weight100,add_zip,j16);
layout_candidates add_cnp_number(layout_candidates le,Specificities(ih).cnp_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_number_weight100 := MAP (le.cnp_number_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j16,s.nulls_cnp_number,Specificities(ih).cnp_number_values_persisted,cnp_number,cnp_number_weight100,add_cnp_number,j15);
layout_candidates add_prim_name_derived(layout_candidates le,Specificities(ih).prim_name_derived_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_derived_weight100 := MAP (le.prim_name_derived_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_derived_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j15,s.nulls_prim_name_derived,Specificities(ih).prim_name_derived_values_persisted,prim_name_derived,prim_name_derived_weight100,add_prim_name_derived,j14);
layout_candidates add_company_addr1(layout_candidates le,Specificities(ih).company_addr1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_addr1_weight100 := MAP (le.company_addr1_isnull => 0, patch_default and ri.field_specificity=0 => s.company_addr1_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j14,s.nulls_company_addr1,Specificities(ih).company_addr1_values_persisted,company_addr1,company_addr1_weight100,add_company_addr1,j13);
layout_candidates add_company_address(layout_candidates le,Specificities(ih).company_address_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_address_weight100 := MAP (le.company_address_isnull => 0, patch_default and ri.field_specificity=0 => s.company_address_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j13,s.nulls_company_address,Specificities(ih).company_address_values_persisted,company_address,company_address_weight100,add_company_address,j12);
layout_candidates add_cnp_name(layout_candidates le,Specificities(ih).cnp_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_name_weight100 := MAP (le.cnp_name_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j12,s.nulls_cnp_name,Specificities(ih).cnp_name_values_persisted,cnp_name,cnp_name_weight100,add_cnp_name,j11);
layout_candidates add_company_fein(layout_candidates le,Specificities(ih).company_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_fein_weight100 := MAP (le.company_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.company_fein_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j11,s.nulls_company_fein,Specificities(ih).company_fein_values_persisted,company_fein,company_fein_weight100,add_company_fein,j10);
layout_candidates add_active_enterprise_number(layout_candidates le,Specificities(ih).active_enterprise_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_enterprise_number_weight100 := MAP (le.active_enterprise_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_enterprise_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j10,s.nulls_active_enterprise_number,Specificities(ih).active_enterprise_number_values_persisted,active_enterprise_number,active_enterprise_number_weight100,add_active_enterprise_number,j9);
layout_candidates add_company_phone(layout_candidates le,Specificities(ih).company_phone_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_phone_weight100 := MAP (le.company_phone_isnull => 0, patch_default and ri.field_specificity=0 => s.company_phone_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j9,s.nulls_company_phone,Specificities(ih).company_phone_values_persisted,company_phone,company_phone_weight100,add_company_phone,j8);
layout_candidates add_unk_corp_key(layout_candidates le,Specificities(ih).unk_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.unk_corp_key_weight100 := MAP (le.unk_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.unk_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j8,s.nulls_unk_corp_key,Specificities(ih).unk_corp_key_values_persisted,unk_corp_key,unk_corp_key_weight100,add_unk_corp_key,j7);
layout_candidates add_foreign_corp_key(layout_candidates le,Specificities(ih).foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.foreign_corp_key_weight100 := MAP (le.foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j7,s.nulls_foreign_corp_key,Specificities(ih).foreign_corp_key_values_persisted,foreign_corp_key,foreign_corp_key_weight100,add_foreign_corp_key,j6);
layout_candidates add_hist_domestic_corp_key(layout_candidates le,Specificities(ih).hist_domestic_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.hist_domestic_corp_key_weight100 := MAP (le.hist_domestic_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.hist_domestic_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j6,s.nulls_hist_domestic_corp_key,Specificities(ih).hist_domestic_corp_key_values_persisted,hist_domestic_corp_key,hist_domestic_corp_key_weight100,add_hist_domestic_corp_key,j5);
layout_candidates add_hist_duns_number(layout_candidates le,Specificities(ih).hist_duns_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.hist_duns_number_weight100 := MAP (le.hist_duns_number_isnull => 0, patch_default and ri.field_specificity=0 => s.hist_duns_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j5,s.nulls_hist_duns_number,Specificities(ih).hist_duns_number_values_persisted,hist_duns_number,hist_duns_number_weight100,add_hist_duns_number,j4);
layout_candidates add_active_domestic_corp_key(layout_candidates le,Specificities(ih).active_domestic_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_domestic_corp_key_weight100 := MAP (le.active_domestic_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.active_domestic_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j4,s.nulls_active_domestic_corp_key,Specificities(ih).active_domestic_corp_key_values_persisted,active_domestic_corp_key,active_domestic_corp_key_weight100,add_active_domestic_corp_key,j3);
layout_candidates add_active_duns_number(layout_candidates le,Specificities(ih).active_duns_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_duns_number_weight100 := MAP (le.active_duns_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_duns_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j3,s.nulls_active_duns_number,Specificities(ih).active_duns_number_values_persisted,active_duns_number,active_duns_number_weight100,add_active_duns_number,j2);
layout_candidates add_ebr_file_number(layout_candidates le,Specificities(ih).ebr_file_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ebr_file_number_weight100 := MAP (le.ebr_file_number_isnull => 0, patch_default and ri.field_specificity=0 => s.ebr_file_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j2,s.nulls_ebr_file_number,Specificities(ih).ebr_file_number_values_persisted,ebr_file_number,ebr_file_number_weight100,add_ebr_file_number,j1);
layout_candidates add_hist_enterprise_number(layout_candidates le,Specificities(ih).hist_enterprise_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.hist_enterprise_number_weight100 := MAP (le.hist_enterprise_number_isnull => 0, patch_default and ri.field_specificity=0 => s.hist_enterprise_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j1,s.nulls_hist_enterprise_number,Specificities(ih).hist_enterprise_number_values_persisted,hist_enterprise_number,hist_enterprise_number_weight100,add_hist_enterprise_number,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(Proxid)) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::mc',EXPIRE(Config.PersistExpire)); // Distributed for keybuild case
 
//Now prepare candidate file for ForeignCorpkey attribute file
layout_ForeignCorpkey_candidates add_ForeignCorpkey_active_domestic_corp_key(layout_ForeignCorpkey_candidates le,Specificities(ih).active_domestic_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_domestic_corp_key_weight100 := MAP (le.active_domestic_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.active_domestic_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(ForeignCorpkey_pp,s.nulls_active_domestic_corp_key,Specificities(ih).active_domestic_corp_key_values_persisted,active_domestic_corp_key,active_domestic_corp_key_weight100,add_ForeignCorpkey_active_domestic_corp_key,jForeignCorpkey_3);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_active_enterprise_number(layout_ForeignCorpkey_candidates le,Specificities(ih).active_enterprise_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_enterprise_number_weight100 := MAP (le.active_enterprise_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_enterprise_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(jForeignCorpkey_3,s.nulls_active_enterprise_number,Specificities(ih).active_enterprise_number_values_persisted,active_enterprise_number,active_enterprise_number_weight100,add_ForeignCorpkey_active_enterprise_number,jForeignCorpkey_9);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_cnp_name(layout_ForeignCorpkey_candidates le,Specificities(ih).cnp_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_name_weight100 := MAP (le.cnp_name_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(jForeignCorpkey_9,s.nulls_cnp_name,Specificities(ih).cnp_name_values_persisted,cnp_name,cnp_name_weight100,add_ForeignCorpkey_cnp_name,jForeignCorpkey_11);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_prim_name_derived(layout_ForeignCorpkey_candidates le,Specificities(ih).prim_name_derived_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_derived_weight100 := MAP (le.prim_name_derived_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_derived_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(jForeignCorpkey_11,s.nulls_prim_name_derived,Specificities(ih).prim_name_derived_values_persisted,prim_name_derived,prim_name_derived_weight100,add_ForeignCorpkey_prim_name_derived,jForeignCorpkey_14);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_cnp_number(layout_ForeignCorpkey_candidates le,Specificities(ih).cnp_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_number_weight100 := MAP (le.cnp_number_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(jForeignCorpkey_14,s.nulls_cnp_number,Specificities(ih).cnp_number_values_persisted,cnp_number,cnp_number_weight100,add_ForeignCorpkey_cnp_number,jForeignCorpkey_15);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_zip(layout_ForeignCorpkey_candidates le,Specificities(ih).zip_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip_weight100 := MAP (le.zip_isnull => 0, patch_default and ri.field_specificity=0 => s.zip_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(jForeignCorpkey_15,s.nulls_zip,Specificities(ih).zip_values_persisted,zip,zip_weight100,add_ForeignCorpkey_zip,jForeignCorpkey_16);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_company_csz(layout_ForeignCorpkey_candidates le,Specificities(ih).company_csz_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_csz_weight100 := MAP (le.company_csz_isnull => 0, patch_default and ri.field_specificity=0 => s.company_csz_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(jForeignCorpkey_16,s.nulls_company_csz,Specificities(ih).company_csz_values_persisted,company_csz,company_csz_weight100,add_ForeignCorpkey_company_csz,jForeignCorpkey_17);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_prim_range(layout_ForeignCorpkey_candidates le,Specificities(ih).prim_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_weight100 := MAP (le.prim_range_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(jForeignCorpkey_17,s.nulls_prim_range,Specificities(ih).prim_range_values_persisted,prim_range,prim_range_weight100,add_ForeignCorpkey_prim_range,jForeignCorpkey_18);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_v_city_name(layout_ForeignCorpkey_candidates le,Specificities(ih).v_city_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.v_city_name_weight100 := MAP (le.v_city_name_isnull => 0, patch_default and ri.field_specificity=0 => s.v_city_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(jForeignCorpkey_18,s.nulls_v_city_name,Specificities(ih).v_city_name_values_persisted,v_city_name,v_city_name_weight100,add_ForeignCorpkey_v_city_name,jForeignCorpkey_20);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_st(layout_ForeignCorpkey_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
jForeignCorpkey_21 := JOIN(jForeignCorpkey_20,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_ForeignCorpkey_st(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
EXPORT ForeignCorpkey_candidates := jForeignCorpkey_21 : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::mc::ForeignCorpkey',EXPIRE(Config.PersistExpire));
//Now see if these records are actually linkable
TotalWeight := Annotated.hist_enterprise_number_weight100 + Annotated.ebr_file_number_weight100 + Annotated.active_duns_number_weight100 + Annotated.active_domestic_corp_key_weight100 + Annotated.hist_duns_number_weight100 + Annotated.hist_domestic_corp_key_weight100 + Annotated.foreign_corp_key_weight100 + Annotated.unk_corp_key_weight100 + Annotated.company_phone_weight100 + Annotated.active_enterprise_number_weight100 + Annotated.company_fein_weight100 + Annotated.cnp_name_weight100 + Annotated.company_address_weight100 + Annotated.cnp_number_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(); //Attribute Files might bring total score up to threshold
END;
