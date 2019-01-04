// Begin code to produce match candidates
IMPORT SALT311,STD;
EXPORT match_candidates(DATASET(layout_DOT_Base) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := BIPV2_ProxID.Cleave(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00(SALT_Partition<>'*'),{rcid,active_duns_number,active_enterprise_number,active_domestic_corp_key,hist_enterprise_number,hist_duns_number,hist_domestic_corp_key,foreign_corp_key,unk_corp_key,ebr_file_number,company_fein,company_fein_len,company_name,cnp_name,company_name_type_raw,company_name_type_derived,cnp_hasnumber,cnp_number,cnp_btype,cnp_lowv,cnp_translated,cnp_classid,company_foreign_domestic,company_bdid,company_phone,prim_name,prim_name_derived,sec_range,v_city_name,st,zip,prim_range,prim_range_derived,company_csz,company_addr1,company_address,dt_first_seen,dt_last_seen,SALT_Partition,ultid,orgid,lgid3,Proxid}),HASH(Proxid));
 
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 active_duns_number_pop := AVE(GROUP,IF((thin_table.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR thin_table.active_duns_number = (TYPEOF(thin_table.active_duns_number))''),0,100));
  REAL8 active_enterprise_number_pop := AVE(GROUP,IF((thin_table.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number) OR thin_table.active_enterprise_number = (TYPEOF(thin_table.active_enterprise_number))''),0,100));
  REAL8 active_domestic_corp_key_pop := AVE(GROUP,IF((thin_table.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) OR thin_table.active_domestic_corp_key = (TYPEOF(thin_table.active_domestic_corp_key))''),0,100));
  REAL8 hist_enterprise_number_pop := AVE(GROUP,IF((thin_table.hist_enterprise_number  IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number) OR thin_table.hist_enterprise_number = (TYPEOF(thin_table.hist_enterprise_number))''),0,100));
  REAL8 hist_duns_number_pop := AVE(GROUP,IF((thin_table.hist_duns_number  IN SET(s.nulls_hist_duns_number,hist_duns_number) OR thin_table.hist_duns_number = (TYPEOF(thin_table.hist_duns_number))''),0,100));
  REAL8 hist_domestic_corp_key_pop := AVE(GROUP,IF((thin_table.hist_domestic_corp_key  IN SET(s.nulls_hist_domestic_corp_key,hist_domestic_corp_key) OR thin_table.hist_domestic_corp_key = (TYPEOF(thin_table.hist_domestic_corp_key))''),0,100));
  REAL8 foreign_corp_key_pop := AVE(GROUP,IF((thin_table.foreign_corp_key  IN SET(s.nulls_foreign_corp_key,foreign_corp_key) OR thin_table.foreign_corp_key = (TYPEOF(thin_table.foreign_corp_key))''),0,100));
  REAL8 unk_corp_key_pop := AVE(GROUP,IF((thin_table.unk_corp_key  IN SET(s.nulls_unk_corp_key,unk_corp_key) OR thin_table.unk_corp_key = (TYPEOF(thin_table.unk_corp_key))''),0,100));
  REAL8 ebr_file_number_pop := AVE(GROUP,IF((thin_table.ebr_file_number  IN SET(s.nulls_ebr_file_number,ebr_file_number) OR thin_table.ebr_file_number = (TYPEOF(thin_table.ebr_file_number))''),0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF((thin_table.company_fein  IN SET(s.nulls_company_fein,company_fein) OR thin_table.company_fein = (TYPEOF(thin_table.company_fein))''),0,100));
  REAL8 cnp_name_pop := AVE(GROUP,IF((thin_table.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR thin_table.cnp_name = (TYPEOF(thin_table.cnp_name))''),0,100));
  REAL8 company_name_type_derived_pop := AVE(GROUP,IF((thin_table.company_name_type_derived  IN SET(s.nulls_company_name_type_derived,company_name_type_derived) OR thin_table.company_name_type_derived = (TYPEOF(thin_table.company_name_type_derived))''),0,100));
  REAL8 cnp_number_pop := AVE(GROUP,IF((thin_table.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR thin_table.cnp_number = (TYPEOF(thin_table.cnp_number))''),0,100));
  REAL8 cnp_btype_pop := AVE(GROUP,IF((thin_table.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR thin_table.cnp_btype = (TYPEOF(thin_table.cnp_btype))''),0,100));
  REAL8 company_phone_pop := AVE(GROUP,IF((thin_table.company_phone  IN SET(s.nulls_company_phone,company_phone) OR thin_table.company_phone = (TYPEOF(thin_table.company_phone))''),0,100));
  REAL8 prim_name_derived_pop := AVE(GROUP,IF((thin_table.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived) OR thin_table.prim_name_derived = (TYPEOF(thin_table.prim_name_derived))''),0,100));
  REAL8 sec_range_pop := AVE(GROUP,IF((thin_table.sec_range  IN SET(s.nulls_sec_range,sec_range) OR thin_table.sec_range = (TYPEOF(thin_table.sec_range))''),0,100));
  REAL8 v_city_name_pop := AVE(GROUP,IF((thin_table.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR thin_table.v_city_name = (TYPEOF(thin_table.v_city_name))''),0,100));
  REAL8 st_pop := AVE(GROUP,IF((thin_table.st  IN SET(s.nulls_st,st) OR thin_table.st = (TYPEOF(thin_table.st))''),0,100));
  REAL8 zip_pop := AVE(GROUP,IF((thin_table.zip  IN SET(s.nulls_zip,zip) OR thin_table.zip = (TYPEOF(thin_table.zip))''),0,100));
  REAL8 prim_range_derived_pop := AVE(GROUP,IF((thin_table.prim_range_derived  IN SET(s.nulls_prim_range_derived,prim_range_derived) OR thin_table.prim_range_derived = (TYPEOF(thin_table.prim_range_derived))''),0,100));
  REAL8 company_csz_pop := AVE(GROUP,IF(((thin_table.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR thin_table.v_city_name = (TYPEOF(thin_table.v_city_name))'') AND (thin_table.st  IN SET(s.nulls_st,st) OR thin_table.st = (TYPEOF(thin_table.st))'') AND (thin_table.zip  IN SET(s.nulls_zip,zip) OR thin_table.zip = (TYPEOF(thin_table.zip))'')),0,100));
  REAL8 company_addr1_pop := AVE(GROUP,IF(((thin_table.prim_range_derived  IN SET(s.nulls_prim_range_derived,prim_range_derived) OR thin_table.prim_range_derived = (TYPEOF(thin_table.prim_range_derived))'') AND (thin_table.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived) OR thin_table.prim_name_derived = (TYPEOF(thin_table.prim_name_derived))'') AND (thin_table.sec_range  IN SET(s.nulls_sec_range,sec_range) OR thin_table.sec_range = (TYPEOF(thin_table.sec_range))'')),0,100));
  REAL8 company_address_pop := AVE(GROUP,IF((((thin_table.prim_range_derived  IN SET(s.nulls_prim_range_derived,prim_range_derived) OR thin_table.prim_range_derived = (TYPEOF(thin_table.prim_range_derived))'') AND (thin_table.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived) OR thin_table.prim_name_derived = (TYPEOF(thin_table.prim_name_derived))'') AND (thin_table.sec_range  IN SET(s.nulls_sec_range,sec_range) OR thin_table.sec_range = (TYPEOF(thin_table.sec_range))'')) AND ((thin_table.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR thin_table.v_city_name = (TYPEOF(thin_table.v_city_name))'') AND (thin_table.st  IN SET(s.nulls_st,st) OR thin_table.st = (TYPEOF(thin_table.st))'') AND (thin_table.zip  IN SET(s.nulls_zip,zip) OR thin_table.zip = (TYPEOF(thin_table.zip))''))),0,100));
END;
EXPORT PPS := TABLE(thin_table,PrePropCounts);
EXPORT poprec := RECORD
	STRING label;
		REAL8 pop;
	END;
EXPORT PrePropogationStats := SALT311.MAC_Pivot(PPS, poprec);
SHARED layout_withpropvars := RECORD
  thin_table;
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
  UNSIGNED1 company_name_type_derived_prop := 0;
  UNSIGNED1 cnp_number_prop := 0;
  UNSIGNED1 company_phone_prop := 0;
  UNSIGNED1 prim_name_derived_prop := 0;
  UNSIGNED1 sec_range_prop := 0;
  UNSIGNED1 v_city_name_prop := 0;
  UNSIGNED1 st_prop := 0;
  UNSIGNED1 zip_prop := 0;
  UNSIGNED1 prim_range_derived_prop := 0;
  UNSIGNED1 company_csz_prop := 0;
  UNSIGNED1 company_addr1_prop := 0;
  UNSIGNED1 company_address_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
SHARED SrcRidVlid_prop0 := DISTRIBUTE( Specificities(ih).SrcRidVlid_values_persisted(Basis_cnt<20000), HASH(Proxid)); // Not guaranteed distributed by Proxid :(
SHARED ForeignCorpkey_prop0 := DISTRIBUTE( Specificities(ih).ForeignCorpkey_values_persisted(Basis_cnt<20000), HASH(Proxid)); // Not guaranteed distributed by Proxid :(
SHARED RAAddresses_prop0 := DISTRIBUTE( Specificities(ih).RAAddresses_values_persisted(Basis_cnt<20000), HASH(Proxid)); // Not guaranteed distributed by Proxid :(
SHARED FilterPrimNames_prop0 := DISTRIBUTE( Specificities(ih).FilterPrimNames_values_persisted(Basis_cnt<20000), HASH(Proxid)); // Not guaranteed distributed by Proxid :(
SHARED BestM := MAC_CreateBest(ih, , );
// Now generate code for basis :cnp_name,prim_name_derived,v_city_name,st,zip
// There are 1 best types that we can propogate from this basis which means we will not need to use this basis again
  Layout_WithPropVars T_SINGLEPRIMRANGE_1_0(Layout_WithPropVars le,BestM.BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_best ri) := TRANSFORM
    SELF.prim_range_derived := MAP ( le.prim_range_derived_prop > 0 OR le.prim_range_derived = ri.prim_range_derived OR (ri.prim_range_derived  IN SET(s.nulls_prim_range_derived,prim_range_derived) OR ri.prim_range_derived = (TYPEOF(ri.prim_range_derived))'') => le.prim_range_derived, // No propogation
      (le.prim_range_derived  IN SET(s.nulls_prim_range_derived,prim_range_derived) OR le.prim_range_derived = (TYPEOF(le.prim_range_derived))'') => ri.prim_range_derived, // If the field is presently null then any prop-method is good enough
      le.prim_range_derived);
    SELF.prim_range_derived_prop := IF ( le.prim_range_derived = SELF.prim_range_derived, le.prim_range_derived_prop,1); // Flag the propagation for sliceouts
    SELF := le;
  END;
SHARED P_SINGLEPRIMRANGE_1_0 := JOIN(with_props((cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name) AND cnp_name <> (TYPEOF(cnp_name))''),(prim_name_derived NOT IN SET(s.nulls_prim_name_derived,prim_name_derived) AND prim_name_derived <> (TYPEOF(prim_name_derived))''),(v_city_name NOT IN SET(s.nulls_v_city_name,v_city_name) AND v_city_name <> (TYPEOF(v_city_name))''),(st NOT IN SET(s.nulls_st,st) AND st <> (TYPEOF(st))''),(zip NOT IN SET(s.nulls_zip,zip) AND zip <> (TYPEOF(zip))'')),BestM.BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_best,LEFT.cnp_name = RIGHT.cnp_name AND LEFT.prim_name_derived = RIGHT.prim_name_derived AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND LEFT.zip = RIGHT.zip,T_SINGLEPRIMRANGE_1_0(LEFT,RIGHT),LEFT OUTER,HASH)
                 + with_props((cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR cnp_name = (TYPEOF(cnp_name))'') OR (prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived) OR prim_name_derived = (TYPEOF(prim_name_derived))'') OR (v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR v_city_name = (TYPEOF(v_city_name))'') OR (st  IN SET(s.nulls_st,st) OR st = (TYPEOF(st))'') OR (zip  IN SET(s.nulls_zip,zip) OR zip = (TYPEOF(zip))''));
 
SALT311.mac_prop_field(thin_table(active_duns_number NOT IN SET(s.nulls_active_duns_number,active_duns_number)),active_duns_number,Proxid,active_duns_number_props); // For every DID find the best FULL active_duns_number
layout_withpropvars take_active_duns_number(with_props le,active_duns_number_props ri) := TRANSFORM
  SELF.active_duns_number := IF ( le.active_duns_number IN SET(s.nulls_active_duns_number,active_duns_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.active_duns_number, le.active_duns_number );
  SELF.active_duns_number_prop := le.active_duns_number_prop + IF ( le.active_duns_number IN SET(s.nulls_active_duns_number,active_duns_number) and ri.active_duns_number NOT IN SET(s.nulls_active_duns_number,active_duns_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj0 := JOIN(P_SINGLEPRIMRANGE_1_0,active_duns_number_props,left.Proxid=right.Proxid,take_active_duns_number(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKMatchCand to prevent memory limit exceeded error*/);
SHARED SrcRidVlid_prop1 := JOIN(SrcRidVlid_prop0,active_duns_number_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED ForeignCorpkey_prop1 := JOIN(ForeignCorpkey_prop0,active_duns_number_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED RAAddresses_prop1 := JOIN(RAAddresses_prop0,active_duns_number_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED FilterPrimNames_prop1 := JOIN(FilterPrimNames_prop0,active_duns_number_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
 
SALT311.mac_prop_field(thin_table(active_enterprise_number NOT IN SET(s.nulls_active_enterprise_number,active_enterprise_number)),active_enterprise_number,Proxid,active_enterprise_number_props); // For every DID find the best FULL active_enterprise_number
layout_withpropvars take_active_enterprise_number(with_props le,active_enterprise_number_props ri) := TRANSFORM
  SELF.active_enterprise_number := IF ( le.active_enterprise_number IN SET(s.nulls_active_enterprise_number,active_enterprise_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.active_enterprise_number, le.active_enterprise_number );
  SELF.active_enterprise_number_prop := le.active_enterprise_number_prop + IF ( le.active_enterprise_number IN SET(s.nulls_active_enterprise_number,active_enterprise_number) and ri.active_enterprise_number NOT IN SET(s.nulls_active_enterprise_number,active_enterprise_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj1 := JOIN(pj0,active_enterprise_number_props,left.Proxid=right.Proxid,take_active_enterprise_number(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKMatchCand to prevent memory limit exceeded error*/);
SHARED SrcRidVlid_prop2 := JOIN(SrcRidVlid_prop1,active_enterprise_number_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED ForeignCorpkey_prop2 := JOIN(ForeignCorpkey_prop1,active_enterprise_number_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED RAAddresses_prop2 := JOIN(RAAddresses_prop1,active_enterprise_number_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED FilterPrimNames_prop2 := JOIN(FilterPrimNames_prop1,active_enterprise_number_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
 
SALT311.mac_prop_field(thin_table(active_domestic_corp_key NOT IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key)),active_domestic_corp_key,Proxid,active_domestic_corp_key_props); // For every DID find the best FULL active_domestic_corp_key
layout_withpropvars take_active_domestic_corp_key(with_props le,active_domestic_corp_key_props ri) := TRANSFORM
  SELF.active_domestic_corp_key := IF ( le.active_domestic_corp_key IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.active_domestic_corp_key, le.active_domestic_corp_key );
  SELF.active_domestic_corp_key_prop := le.active_domestic_corp_key_prop + IF ( le.active_domestic_corp_key IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) and ri.active_domestic_corp_key NOT IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj2 := JOIN(pj1,active_domestic_corp_key_props,left.Proxid=right.Proxid,take_active_domestic_corp_key(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKMatchCand to prevent memory limit exceeded error*/);
SHARED SrcRidVlid_prop3 := JOIN(SrcRidVlid_prop2,active_domestic_corp_key_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED ForeignCorpkey_prop3 := JOIN(ForeignCorpkey_prop2,active_domestic_corp_key_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED RAAddresses_prop3 := JOIN(RAAddresses_prop2,active_domestic_corp_key_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED FilterPrimNames_prop3 := JOIN(FilterPrimNames_prop2,active_domestic_corp_key_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
 
SALT311.mac_prop_field(thin_table(hist_enterprise_number NOT IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number)),hist_enterprise_number,Proxid,hist_enterprise_number_props); // For every DID find the best FULL hist_enterprise_number
layout_withpropvars take_hist_enterprise_number(with_props le,hist_enterprise_number_props ri) := TRANSFORM
  SELF.hist_enterprise_number := IF ( le.hist_enterprise_number IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.hist_enterprise_number, le.hist_enterprise_number );
  SELF.hist_enterprise_number_prop := le.hist_enterprise_number_prop + IF ( le.hist_enterprise_number IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number) and ri.hist_enterprise_number NOT IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj3 := JOIN(pj2,hist_enterprise_number_props,left.Proxid=right.Proxid,take_hist_enterprise_number(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKMatchCand to prevent memory limit exceeded error*/);
 
SALT311.mac_prop_field(thin_table(hist_duns_number NOT IN SET(s.nulls_hist_duns_number,hist_duns_number)),hist_duns_number,Proxid,hist_duns_number_props); // For every DID find the best FULL hist_duns_number
layout_withpropvars take_hist_duns_number(with_props le,hist_duns_number_props ri) := TRANSFORM
  SELF.hist_duns_number := IF ( le.hist_duns_number IN SET(s.nulls_hist_duns_number,hist_duns_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.hist_duns_number, le.hist_duns_number );
  SELF.hist_duns_number_prop := le.hist_duns_number_prop + IF ( le.hist_duns_number IN SET(s.nulls_hist_duns_number,hist_duns_number) and ri.hist_duns_number NOT IN SET(s.nulls_hist_duns_number,hist_duns_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj4 := JOIN(pj3,hist_duns_number_props,left.Proxid=right.Proxid,take_hist_duns_number(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKMatchCand to prevent memory limit exceeded error*/);
 
SALT311.mac_prop_field(thin_table(hist_domestic_corp_key NOT IN SET(s.nulls_hist_domestic_corp_key,hist_domestic_corp_key)),hist_domestic_corp_key,Proxid,hist_domestic_corp_key_props); // For every DID find the best FULL hist_domestic_corp_key
layout_withpropvars take_hist_domestic_corp_key(with_props le,hist_domestic_corp_key_props ri) := TRANSFORM
  SELF.hist_domestic_corp_key := IF ( le.hist_domestic_corp_key IN SET(s.nulls_hist_domestic_corp_key,hist_domestic_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.hist_domestic_corp_key, le.hist_domestic_corp_key );
  SELF.hist_domestic_corp_key_prop := le.hist_domestic_corp_key_prop + IF ( le.hist_domestic_corp_key IN SET(s.nulls_hist_domestic_corp_key,hist_domestic_corp_key) and ri.hist_domestic_corp_key NOT IN SET(s.nulls_hist_domestic_corp_key,hist_domestic_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj5 := JOIN(pj4,hist_domestic_corp_key_props,left.Proxid=right.Proxid,take_hist_domestic_corp_key(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKMatchCand to prevent memory limit exceeded error*/);
 
SALT311.mac_prop_field(thin_table(foreign_corp_key NOT IN SET(s.nulls_foreign_corp_key,foreign_corp_key)),foreign_corp_key,Proxid,foreign_corp_key_props); // For every DID find the best FULL foreign_corp_key
layout_withpropvars take_foreign_corp_key(with_props le,foreign_corp_key_props ri) := TRANSFORM
  SELF.foreign_corp_key := IF ( le.foreign_corp_key IN SET(s.nulls_foreign_corp_key,foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.foreign_corp_key, le.foreign_corp_key );
  SELF.foreign_corp_key_prop := le.foreign_corp_key_prop + IF ( le.foreign_corp_key IN SET(s.nulls_foreign_corp_key,foreign_corp_key) and ri.foreign_corp_key NOT IN SET(s.nulls_foreign_corp_key,foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj6 := JOIN(pj5,foreign_corp_key_props,left.Proxid=right.Proxid,take_foreign_corp_key(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKMatchCand to prevent memory limit exceeded error*/);
 
SALT311.mac_prop_field(thin_table(unk_corp_key NOT IN SET(s.nulls_unk_corp_key,unk_corp_key)),unk_corp_key,Proxid,unk_corp_key_props); // For every DID find the best FULL unk_corp_key
layout_withpropvars take_unk_corp_key(with_props le,unk_corp_key_props ri) := TRANSFORM
  SELF.unk_corp_key := IF ( le.unk_corp_key IN SET(s.nulls_unk_corp_key,unk_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.unk_corp_key, le.unk_corp_key );
  SELF.unk_corp_key_prop := le.unk_corp_key_prop + IF ( le.unk_corp_key IN SET(s.nulls_unk_corp_key,unk_corp_key) and ri.unk_corp_key NOT IN SET(s.nulls_unk_corp_key,unk_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj7 := JOIN(pj6,unk_corp_key_props,left.Proxid=right.Proxid,take_unk_corp_key(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKMatchCand to prevent memory limit exceeded error*/);
 
SALT311.mac_prop_field(thin_table(ebr_file_number NOT IN SET(s.nulls_ebr_file_number,ebr_file_number)),ebr_file_number,Proxid,ebr_file_number_props); // For every DID find the best FULL ebr_file_number
layout_withpropvars take_ebr_file_number(with_props le,ebr_file_number_props ri) := TRANSFORM
  SELF.ebr_file_number := IF ( le.ebr_file_number IN SET(s.nulls_ebr_file_number,ebr_file_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.ebr_file_number, le.ebr_file_number );
  SELF.ebr_file_number_prop := le.ebr_file_number_prop + IF ( le.ebr_file_number IN SET(s.nulls_ebr_file_number,ebr_file_number) and ri.ebr_file_number NOT IN SET(s.nulls_ebr_file_number,ebr_file_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj8 := JOIN(pj7,ebr_file_number_props,left.Proxid=right.Proxid,take_ebr_file_number(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKMatchCand to prevent memory limit exceeded error*/);
 
SALT311.mac_prop_field(thin_table(company_fein NOT IN SET(s.nulls_company_fein,company_fein)),company_fein,Proxid,company_fein_props); // For every DID find the best FULL company_fein
layout_withpropvars take_company_fein(with_props le,company_fein_props ri) := TRANSFORM
  SELF.company_fein := IF ( le.company_fein IN SET(s.nulls_company_fein,company_fein) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.company_fein, le.company_fein );
  SELF.company_fein_prop := le.company_fein_prop + IF ( le.company_fein IN SET(s.nulls_company_fein,company_fein) and ri.company_fein NOT IN SET(s.nulls_company_fein,company_fein) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF.company_fein_len := IF ( le.company_fein IN SET(s.nulls_company_fein,company_fein) and ri.Proxid<>(TYPEOF(ri.Proxid))'', LENGTH(TRIM(ri.company_fein)), le.company_fein_len );
  SELF := le;
  END;
SHARED pj9 := JOIN(pj8,company_fein_props,left.Proxid=right.Proxid,take_company_fein(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKMatchCand to prevent memory limit exceeded error*/);
SHARED SrcRidVlid_prop4 := JOIN(SrcRidVlid_prop3,company_fein_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED ForeignCorpkey_prop4 := JOIN(ForeignCorpkey_prop3,company_fein_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED RAAddresses_prop4 := JOIN(RAAddresses_prop3,company_fein_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED FilterPrimNames_prop4 := JOIN(FilterPrimNames_prop3,company_fein_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
 
SALT311.mac_prop_field(thin_table(cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name)),cnp_name,Proxid,cnp_name_props); // For every DID find the best FULL cnp_name
SHARED SrcRidVlid_prop5 := JOIN(SrcRidVlid_prop4,cnp_name_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED ForeignCorpkey_prop5 := JOIN(ForeignCorpkey_prop4,cnp_name_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED RAAddresses_prop5 := JOIN(RAAddresses_prop4,cnp_name_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED FilterPrimNames_prop5 := JOIN(FilterPrimNames_prop4,cnp_name_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
 
SALT311.mac_prop_field(thin_table(company_name_type_derived NOT IN SET(s.nulls_company_name_type_derived,company_name_type_derived)),company_name_type_derived,Proxid,company_name_type_derived_props); // For every DID find the best FULL company_name_type_derived
layout_withpropvars take_company_name_type_derived(with_props le,company_name_type_derived_props ri) := TRANSFORM
  SELF.company_name_type_derived := IF ( le.company_name_type_derived IN SET(s.nulls_company_name_type_derived,company_name_type_derived) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.company_name_type_derived, le.company_name_type_derived );
  SELF.company_name_type_derived_prop := le.company_name_type_derived_prop + IF ( le.company_name_type_derived IN SET(s.nulls_company_name_type_derived,company_name_type_derived) and ri.company_name_type_derived NOT IN SET(s.nulls_company_name_type_derived,company_name_type_derived) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj13 := JOIN(pj9,company_name_type_derived_props,left.Proxid=right.Proxid,take_company_name_type_derived(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKMatchCand to prevent memory limit exceeded error*/);
 
SALT311.mac_prop_field(thin_table(cnp_number NOT IN SET(s.nulls_cnp_number,cnp_number)),cnp_number,Proxid,cnp_number_props); // For every DID find the best FULL cnp_number
layout_withpropvars take_cnp_number(with_props le,cnp_number_props ri) := TRANSFORM
  SELF.cnp_number := IF ( le.cnp_number IN SET(s.nulls_cnp_number,cnp_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.cnp_number, le.cnp_number );
  SELF.cnp_number_prop := le.cnp_number_prop + IF ( le.cnp_number IN SET(s.nulls_cnp_number,cnp_number) and ri.cnp_number NOT IN SET(s.nulls_cnp_number,cnp_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj15 := JOIN(pj13,cnp_number_props,left.Proxid=right.Proxid,take_cnp_number(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKMatchCand to prevent memory limit exceeded error*/);
SHARED SrcRidVlid_prop6 := JOIN(SrcRidVlid_prop5,cnp_number_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED ForeignCorpkey_prop6 := JOIN(ForeignCorpkey_prop5,cnp_number_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED RAAddresses_prop6 := JOIN(RAAddresses_prop5,cnp_number_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED FilterPrimNames_prop6 := JOIN(FilterPrimNames_prop5,cnp_number_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
 
SALT311.mac_prop_field(thin_table(company_phone NOT IN SET(s.nulls_company_phone,company_phone)),company_phone,Proxid,company_phone_props); // For every DID find the best FULL company_phone
layout_withpropvars take_company_phone(with_props le,company_phone_props ri) := TRANSFORM
  SELF.company_phone := IF ( le.company_phone IN SET(s.nulls_company_phone,company_phone) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.company_phone, le.company_phone );
  SELF.company_phone_prop := le.company_phone_prop + IF ( le.company_phone IN SET(s.nulls_company_phone,company_phone) and ri.company_phone NOT IN SET(s.nulls_company_phone,company_phone) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj22 := JOIN(pj15,company_phone_props,left.Proxid=right.Proxid,take_company_phone(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKMatchCand to prevent memory limit exceeded error*/);
 
SALT311.mac_prop_field(thin_table(prim_name_derived NOT IN SET(s.nulls_prim_name_derived,prim_name_derived)),prim_name_derived,Proxid,prim_name_derived_props); // For every DID find the best FULL prim_name_derived
SHARED SrcRidVlid_prop7 := JOIN(SrcRidVlid_prop6,prim_name_derived_props,left.Proxid=right.Proxid,LOCAL);
SHARED ForeignCorpkey_prop7 := JOIN(ForeignCorpkey_prop6,prim_name_derived_props,left.Proxid=right.Proxid,LOCAL);
SHARED RAAddresses_prop7 := JOIN(RAAddresses_prop6,prim_name_derived_props,left.Proxid=right.Proxid,LOCAL);
SHARED FilterPrimNames_prop7 := JOIN(FilterPrimNames_prop6,prim_name_derived_props,left.Proxid=right.Proxid,LOCAL);
 
SALT311.mac_prop_field(thin_table(sec_range NOT IN SET(s.nulls_sec_range,sec_range)),sec_range,Proxid,sec_range_props); // For every DID find the best FULL sec_range
layout_withpropvars take_sec_range(with_props le,sec_range_props ri) := TRANSFORM
  SELF.sec_range := IF ( le.sec_range IN SET(s.nulls_sec_range,sec_range) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.sec_range, le.sec_range );
  SELF.sec_range_prop := le.sec_range_prop + IF ( le.sec_range IN SET(s.nulls_sec_range,sec_range) and ri.sec_range NOT IN SET(s.nulls_sec_range,sec_range) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj25 := JOIN(pj22,sec_range_props,left.Proxid=right.Proxid,take_sec_range(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKMatchCand to prevent memory limit exceeded error*/);
 
SALT311.mac_prop_field(thin_table(st NOT IN SET(s.nulls_st,st)),st,Proxid,st_props); // For every DID find the best FULL st
SHARED SrcRidVlid_prop8 := JOIN(SrcRidVlid_prop7,st_props,left.Proxid=right.Proxid,LOCAL);
SHARED ForeignCorpkey_prop8 := JOIN(ForeignCorpkey_prop7,st_props,left.Proxid=right.Proxid,LOCAL);
SHARED RAAddresses_prop8 := JOIN(RAAddresses_prop7,st_props,left.Proxid=right.Proxid,LOCAL);
SHARED FilterPrimNames_prop8 := JOIN(FilterPrimNames_prop7,st_props,left.Proxid=right.Proxid,LOCAL);
 
SALT311.mac_prop_field(thin_table(prim_range_derived NOT IN SET(s.nulls_prim_range_derived,prim_range_derived)),prim_range_derived,Proxid,prim_range_derived_props); // For every DID find the best FULL prim_range_derived
layout_withpropvars take_prim_range_derived(with_props le,prim_range_derived_props ri) := TRANSFORM
  SELF.prim_range_derived := IF ( le.prim_range_derived IN SET(s.nulls_prim_range_derived,prim_range_derived) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.prim_range_derived, le.prim_range_derived );
  SELF.prim_range_derived_prop := le.prim_range_derived_prop + IF ( le.prim_range_derived IN SET(s.nulls_prim_range_derived,prim_range_derived) and ri.prim_range_derived NOT IN SET(s.nulls_prim_range_derived,prim_range_derived) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj30 := JOIN(pj25,prim_range_derived_props,left.Proxid=right.Proxid,take_prim_range_derived(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKMatchCand to prevent memory limit exceeded error*/);
SHARED SrcRidVlid_prop9 := JOIN(SrcRidVlid_prop8,prim_range_derived_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED ForeignCorpkey_prop9 := JOIN(ForeignCorpkey_prop8,prim_range_derived_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED RAAddresses_prop9 := JOIN(RAAddresses_prop8,prim_range_derived_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED FilterPrimNames_prop9 := JOIN(FilterPrimNames_prop8,prim_range_derived_props,left.Proxid=right.Proxid,LEFT OUTER,LOCAL);
SHARED SrcRidVlid_prp := SrcRidVlid_prop9;
SHARED ForeignCorpkey_prp := ForeignCorpkey_prop9;
SHARED RAAddresses_prp := RAAddresses_prop9;
SHARED FilterPrimNames_prp := FilterPrimNames_prop9;
 
pj30 do_computes(pj30 le) := TRANSFORM
  SELF.company_csz := IF (Fields.InValid_company_csz((SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip)>0,0,HASH32((SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip)); // Combine child fields into 1 for specificity counting
  SELF.company_addr1 := IF (Fields.InValid_company_addr1((SALT311.StrType)le.prim_range_derived,(SALT311.StrType)le.prim_name_derived,(SALT311.StrType)le.sec_range)>0,0,HASH32((SALT311.StrType)le.prim_range_derived,(SALT311.StrType)le.prim_name_derived,(SALT311.StrType)le.sec_range)); // Combine child fields into 1 for specificity counting
  SELF.company_addr1_prop := IF( le.prim_range_derived_prop > 0, 1, 0 ) + IF( le.sec_range_prop > 0, 4, 0 );
  SELF.company_address := IF (Fields.InValid_company_address((SALT311.StrType)le.prim_range_derived,(SALT311.StrType)le.prim_name_derived,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip)>0,0,HASH32((SALT311.StrType)le.prim_range_derived,(SALT311.StrType)le.prim_name_derived,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip)); // Combine child fields into 1 for specificity counting
  SELF.company_address_prop := IF( SELF.company_addr1_prop > 0, 1, 0 );
  SELF := le;
END;
SHARED propogated := PROJECT(pj30,do_computes(left)) : PERSIST('~temp::Proxid::BIPV2_ProxID::mc_props::DOT_Base',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 active_duns_number_pop := AVE(GROUP,IF((propogated.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR propogated.active_duns_number = (TYPEOF(propogated.active_duns_number))''),0,100));
  REAL8 active_enterprise_number_pop := AVE(GROUP,IF((propogated.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number) OR propogated.active_enterprise_number = (TYPEOF(propogated.active_enterprise_number))''),0,100));
  REAL8 active_domestic_corp_key_pop := AVE(GROUP,IF((propogated.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) OR propogated.active_domestic_corp_key = (TYPEOF(propogated.active_domestic_corp_key))''),0,100));
  REAL8 hist_enterprise_number_pop := AVE(GROUP,IF((propogated.hist_enterprise_number  IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number) OR propogated.hist_enterprise_number = (TYPEOF(propogated.hist_enterprise_number))''),0,100));
  REAL8 hist_duns_number_pop := AVE(GROUP,IF((propogated.hist_duns_number  IN SET(s.nulls_hist_duns_number,hist_duns_number) OR propogated.hist_duns_number = (TYPEOF(propogated.hist_duns_number))''),0,100));
  REAL8 hist_domestic_corp_key_pop := AVE(GROUP,IF((propogated.hist_domestic_corp_key  IN SET(s.nulls_hist_domestic_corp_key,hist_domestic_corp_key) OR propogated.hist_domestic_corp_key = (TYPEOF(propogated.hist_domestic_corp_key))''),0,100));
  REAL8 foreign_corp_key_pop := AVE(GROUP,IF((propogated.foreign_corp_key  IN SET(s.nulls_foreign_corp_key,foreign_corp_key) OR propogated.foreign_corp_key = (TYPEOF(propogated.foreign_corp_key))''),0,100));
  REAL8 unk_corp_key_pop := AVE(GROUP,IF((propogated.unk_corp_key  IN SET(s.nulls_unk_corp_key,unk_corp_key) OR propogated.unk_corp_key = (TYPEOF(propogated.unk_corp_key))''),0,100));
  REAL8 ebr_file_number_pop := AVE(GROUP,IF((propogated.ebr_file_number  IN SET(s.nulls_ebr_file_number,ebr_file_number) OR propogated.ebr_file_number = (TYPEOF(propogated.ebr_file_number))''),0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF((propogated.company_fein  IN SET(s.nulls_company_fein,company_fein) OR propogated.company_fein = (TYPEOF(propogated.company_fein))''),0,100));
  REAL8 cnp_name_pop := AVE(GROUP,IF((propogated.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR propogated.cnp_name = (TYPEOF(propogated.cnp_name))''),0,100));
  REAL8 company_name_type_derived_pop := AVE(GROUP,IF((propogated.company_name_type_derived  IN SET(s.nulls_company_name_type_derived,company_name_type_derived) OR propogated.company_name_type_derived = (TYPEOF(propogated.company_name_type_derived))''),0,100));
  REAL8 cnp_number_pop := AVE(GROUP,IF((propogated.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR propogated.cnp_number = (TYPEOF(propogated.cnp_number))''),0,100));
  REAL8 cnp_btype_pop := AVE(GROUP,IF((propogated.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR propogated.cnp_btype = (TYPEOF(propogated.cnp_btype))''),0,100));
  REAL8 company_phone_pop := AVE(GROUP,IF((propogated.company_phone  IN SET(s.nulls_company_phone,company_phone) OR propogated.company_phone = (TYPEOF(propogated.company_phone))''),0,100));
  REAL8 prim_name_derived_pop := AVE(GROUP,IF((propogated.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived) OR propogated.prim_name_derived = (TYPEOF(propogated.prim_name_derived))''),0,100));
  REAL8 sec_range_pop := AVE(GROUP,IF((propogated.sec_range  IN SET(s.nulls_sec_range,sec_range) OR propogated.sec_range = (TYPEOF(propogated.sec_range))''),0,100));
  REAL8 v_city_name_pop := AVE(GROUP,IF((propogated.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR propogated.v_city_name = (TYPEOF(propogated.v_city_name))''),0,100));
  REAL8 st_pop := AVE(GROUP,IF((propogated.st  IN SET(s.nulls_st,st) OR propogated.st = (TYPEOF(propogated.st))''),0,100));
  REAL8 zip_pop := AVE(GROUP,IF((propogated.zip  IN SET(s.nulls_zip,zip) OR propogated.zip = (TYPEOF(propogated.zip))''),0,100));
  REAL8 prim_range_derived_pop := AVE(GROUP,IF((propogated.prim_range_derived  IN SET(s.nulls_prim_range_derived,prim_range_derived) OR propogated.prim_range_derived = (TYPEOF(propogated.prim_range_derived))''),0,100));
  REAL8 company_csz_pop := AVE(GROUP,IF(((propogated.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR propogated.v_city_name = (TYPEOF(propogated.v_city_name))'') AND (propogated.st  IN SET(s.nulls_st,st) OR propogated.st = (TYPEOF(propogated.st))'') AND (propogated.zip  IN SET(s.nulls_zip,zip) OR propogated.zip = (TYPEOF(propogated.zip))'')),0,100));
  REAL8 company_addr1_pop := AVE(GROUP,IF(((propogated.prim_range_derived  IN SET(s.nulls_prim_range_derived,prim_range_derived) OR propogated.prim_range_derived = (TYPEOF(propogated.prim_range_derived))'') AND (propogated.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived) OR propogated.prim_name_derived = (TYPEOF(propogated.prim_name_derived))'') AND (propogated.sec_range  IN SET(s.nulls_sec_range,sec_range) OR propogated.sec_range = (TYPEOF(propogated.sec_range))'')),0,100));
  REAL8 company_address_pop := AVE(GROUP,IF((((propogated.prim_range_derived  IN SET(s.nulls_prim_range_derived,prim_range_derived) OR propogated.prim_range_derived = (TYPEOF(propogated.prim_range_derived))'') AND (propogated.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived) OR propogated.prim_name_derived = (TYPEOF(propogated.prim_name_derived))'') AND (propogated.sec_range  IN SET(s.nulls_sec_range,sec_range) OR propogated.sec_range = (TYPEOF(propogated.sec_range))'')) AND ((propogated.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR propogated.v_city_name = (TYPEOF(propogated.v_city_name))'') AND (propogated.st  IN SET(s.nulls_st,st) OR propogated.st = (TYPEOF(propogated.st))'') AND (propogated.zip  IN SET(s.nulls_zip,zip) OR propogated.zip = (TYPEOF(propogated.zip))''))),0,100));
END;
 PoPS := TABLE(propogated,PostPropCounts);
EXPORT PostPropogationStats := SALT311.MAC_Pivot(PoPS, poprec);
  SHARED MAC_RollupCandidates(inCandidates, sortFields, groupFields, addBuddies) := FUNCTIONMACRO
    Grpd0 := GROUP(SORT(
      DISTRIBUTE(TABLE(inCandidates, {inCandidates #IF(addBuddies) , UNSIGNED2 Buddies := 0 #END}), HASH(Proxid)),
      Proxid, SALT_Partition, #EXPAND(sortFields), LOCAL),
      Proxid, SALT_Partition, #EXPAND(groupFields), LOCAL);
    Grpd0 Tr0(Grpd0 le, Grpd0 ri) := TRANSFORM
      SELF.Buddies := le.Buddies + ri.Buddies + 1;
      SELF := le;
    END;
    RETURN UNGROUP(ROLLUP(Grpd0,TRUE,Tr0(LEFT,RIGHT)));// Only one copy of each record
  ENDMACRO;
  SHARED fieldList := 'active_duns_number,active_enterprise_number,active_domestic_corp_key,hist_enterprise_number,hist_duns_number,hist_domestic_corp_key,foreign_corp_key,unk_corp_key,ebr_file_number,company_fein,cnp_name,company_name_type_derived,cnp_number,cnp_btype,company_phone,prim_name_derived,sec_range,v_city_name,st,zip,prim_range_derived,dt_first_seen,dt_last_seen';
  SHARED fieldListWithPropFlags := fieldList + ',active_duns_number_prop,active_enterprise_number_prop,active_domestic_corp_key_prop,hist_enterprise_number_prop,hist_duns_number_prop,hist_domestic_corp_key_prop,foreign_corp_key_prop,unk_corp_key_prop,ebr_file_number_prop,company_fein_prop,company_name_type_derived_prop,cnp_number_prop,company_phone_prop,prim_name_derived_prop,sec_range_prop,v_city_name_prop,st_prop,zip_prop,prim_range_derived_prop,company_csz_prop,company_addr1_prop,company_address_prop';
  GrpdRoll_withpropfields := MAC_RollupCandidates(propogated, fieldListWithPropFlags, fieldListWithPropFlags, TRUE);
  GrpdRoll_nopropfields := MAC_RollupCandidates(propogated, fieldListWithPropFlags, fieldList, TRUE);
SHARED h0 := IF(Config.FastSlice, GrpdRoll_nopropFields, GrpdRoll_withpropfields);
 
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT311.UIDType Proxid1;
  SALT311.UIDType Proxid2;
  SALT311.UIDType rcid1 := 0;
  SALT311.UIDType rcid2 := 0;
END;
EXPORT Layout_Attribute_Matches := RECORD(layout_matches),MAXLENGTH(32000)
  SALT311.StrType source_id;
  UNSIGNED2 support_cnp_name := 0; // Add support (either external of field) for cnp_name
END;
EXPORT Layout_SrcRidVlid_Candidates := RECORD
  {SrcRidVlid_prp} AND NOT [cnp_name,prim_name_derived];
  INTEGER2 active_duns_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_duns_number_isnull := (SrcRidVlid_prp.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR SrcRidVlid_prp.active_duns_number = (TYPEOF(SrcRidVlid_prp.active_duns_number))''); // Simplify later processing 
  INTEGER2 active_enterprise_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_enterprise_number_isnull := (SrcRidVlid_prp.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number) OR SrcRidVlid_prp.active_enterprise_number = (TYPEOF(SrcRidVlid_prp.active_enterprise_number))''); // Simplify later processing 
  INTEGER2 active_domestic_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_domestic_corp_key_isnull := (SrcRidVlid_prp.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) OR SrcRidVlid_prp.active_domestic_corp_key = (TYPEOF(SrcRidVlid_prp.active_domestic_corp_key))''); // Simplify later processing 
  INTEGER2 company_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_fein_isnull := (SrcRidVlid_prp.company_fein  IN SET(s.nulls_company_fein,company_fein) OR SrcRidVlid_prp.company_fein = (TYPEOF(SrcRidVlid_prp.company_fein))''); // Simplify later processing 
  UNSIGNED company_fein_cnt := 0; // Number of instances with this particular field value
  UNSIGNED company_fein_e1_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED1 company_fein_len := LENGTH(TRIM(SrcRidVlid_prp.company_fein));
  STRING500 cnp_name := SrcRidVlid_prp.cnp_name; // Expanded wordbag field
  INTEGER2 cnp_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_name_isnull := (SrcRidVlid_prp.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR SrcRidVlid_prp.cnp_name = (TYPEOF(SrcRidVlid_prp.cnp_name))''); // Simplify later processing 
  INTEGER2 cnp_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_number_isnull := (SrcRidVlid_prp.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR SrcRidVlid_prp.cnp_number = (TYPEOF(SrcRidVlid_prp.cnp_number))''); // Simplify later processing 
  STRING500 prim_name_derived := SrcRidVlid_prp.prim_name_derived; // Expanded wordbag field
  INTEGER2 prim_name_derived_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_derived_isnull := (SrcRidVlid_prp.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived) OR SrcRidVlid_prp.prim_name_derived = (TYPEOF(SrcRidVlid_prp.prim_name_derived))''); // Simplify later processing 
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := (SrcRidVlid_prp.st  IN SET(s.nulls_st,st) OR SrcRidVlid_prp.st = (TYPEOF(SrcRidVlid_prp.st))''); // Simplify later processing 
  INTEGER2 prim_range_derived_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_derived_isnull := (SrcRidVlid_prp.prim_range_derived  IN SET(s.nulls_prim_range_derived,prim_range_derived) OR SrcRidVlid_prp.prim_range_derived = (TYPEOF(SrcRidVlid_prp.prim_range_derived))''); // Simplify later processing 
END;
SHARED SrcRidVlid_pp := TABLE(SrcRidVlid_prp,Layout_SrcRidVlid_Candidates)(~prim_name_derived_isnull,~st_isnull);
EXPORT Layout_ForeignCorpkey_Candidates := RECORD
  {ForeignCorpkey_prp} AND NOT [cnp_name,prim_name_derived];
  INTEGER2 active_duns_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_duns_number_isnull := (ForeignCorpkey_prp.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR ForeignCorpkey_prp.active_duns_number = (TYPEOF(ForeignCorpkey_prp.active_duns_number))''); // Simplify later processing 
  INTEGER2 active_enterprise_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_enterprise_number_isnull := (ForeignCorpkey_prp.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number) OR ForeignCorpkey_prp.active_enterprise_number = (TYPEOF(ForeignCorpkey_prp.active_enterprise_number))''); // Simplify later processing 
  INTEGER2 active_domestic_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_domestic_corp_key_isnull := (ForeignCorpkey_prp.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) OR ForeignCorpkey_prp.active_domestic_corp_key = (TYPEOF(ForeignCorpkey_prp.active_domestic_corp_key))''); // Simplify later processing 
  INTEGER2 company_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_fein_isnull := (ForeignCorpkey_prp.company_fein  IN SET(s.nulls_company_fein,company_fein) OR ForeignCorpkey_prp.company_fein = (TYPEOF(ForeignCorpkey_prp.company_fein))''); // Simplify later processing 
  UNSIGNED company_fein_cnt := 0; // Number of instances with this particular field value
  UNSIGNED company_fein_e1_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED1 company_fein_len := LENGTH(TRIM(ForeignCorpkey_prp.company_fein));
  STRING500 cnp_name := ForeignCorpkey_prp.cnp_name; // Expanded wordbag field
  INTEGER2 cnp_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_name_isnull := (ForeignCorpkey_prp.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR ForeignCorpkey_prp.cnp_name = (TYPEOF(ForeignCorpkey_prp.cnp_name))''); // Simplify later processing 
  INTEGER2 cnp_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_number_isnull := (ForeignCorpkey_prp.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR ForeignCorpkey_prp.cnp_number = (TYPEOF(ForeignCorpkey_prp.cnp_number))''); // Simplify later processing 
  STRING500 prim_name_derived := ForeignCorpkey_prp.prim_name_derived; // Expanded wordbag field
  INTEGER2 prim_name_derived_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_derived_isnull := (ForeignCorpkey_prp.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived) OR ForeignCorpkey_prp.prim_name_derived = (TYPEOF(ForeignCorpkey_prp.prim_name_derived))''); // Simplify later processing 
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := (ForeignCorpkey_prp.st  IN SET(s.nulls_st,st) OR ForeignCorpkey_prp.st = (TYPEOF(ForeignCorpkey_prp.st))''); // Simplify later processing 
  INTEGER2 prim_range_derived_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_derived_isnull := (ForeignCorpkey_prp.prim_range_derived  IN SET(s.nulls_prim_range_derived,prim_range_derived) OR ForeignCorpkey_prp.prim_range_derived = (TYPEOF(ForeignCorpkey_prp.prim_range_derived))''); // Simplify later processing 
END;
SHARED ForeignCorpkey_pp := TABLE(ForeignCorpkey_prp,Layout_ForeignCorpkey_Candidates)(~prim_name_derived_isnull,~st_isnull);
EXPORT Layout_RAAddresses_Candidates := RECORD
  {RAAddresses_prp} AND NOT [cnp_name,prim_name_derived];
  INTEGER2 active_duns_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_duns_number_isnull := (RAAddresses_prp.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR RAAddresses_prp.active_duns_number = (TYPEOF(RAAddresses_prp.active_duns_number))''); // Simplify later processing 
  INTEGER2 active_enterprise_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_enterprise_number_isnull := (RAAddresses_prp.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number) OR RAAddresses_prp.active_enterprise_number = (TYPEOF(RAAddresses_prp.active_enterprise_number))''); // Simplify later processing 
  INTEGER2 active_domestic_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_domestic_corp_key_isnull := (RAAddresses_prp.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) OR RAAddresses_prp.active_domestic_corp_key = (TYPEOF(RAAddresses_prp.active_domestic_corp_key))''); // Simplify later processing 
  INTEGER2 company_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_fein_isnull := (RAAddresses_prp.company_fein  IN SET(s.nulls_company_fein,company_fein) OR RAAddresses_prp.company_fein = (TYPEOF(RAAddresses_prp.company_fein))''); // Simplify later processing 
  UNSIGNED company_fein_cnt := 0; // Number of instances with this particular field value
  UNSIGNED company_fein_e1_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED1 company_fein_len := LENGTH(TRIM(RAAddresses_prp.company_fein));
  STRING500 cnp_name := RAAddresses_prp.cnp_name; // Expanded wordbag field
  INTEGER2 cnp_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_name_isnull := (RAAddresses_prp.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR RAAddresses_prp.cnp_name = (TYPEOF(RAAddresses_prp.cnp_name))''); // Simplify later processing 
  INTEGER2 cnp_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_number_isnull := (RAAddresses_prp.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR RAAddresses_prp.cnp_number = (TYPEOF(RAAddresses_prp.cnp_number))''); // Simplify later processing 
  STRING500 prim_name_derived := RAAddresses_prp.prim_name_derived; // Expanded wordbag field
  INTEGER2 prim_name_derived_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_derived_isnull := (RAAddresses_prp.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived) OR RAAddresses_prp.prim_name_derived = (TYPEOF(RAAddresses_prp.prim_name_derived))''); // Simplify later processing 
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := (RAAddresses_prp.st  IN SET(s.nulls_st,st) OR RAAddresses_prp.st = (TYPEOF(RAAddresses_prp.st))''); // Simplify later processing 
  INTEGER2 prim_range_derived_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_derived_isnull := (RAAddresses_prp.prim_range_derived  IN SET(s.nulls_prim_range_derived,prim_range_derived) OR RAAddresses_prp.prim_range_derived = (TYPEOF(RAAddresses_prp.prim_range_derived))''); // Simplify later processing 
END;
SHARED RAAddresses_pp := TABLE(RAAddresses_prp,Layout_RAAddresses_Candidates)(~prim_name_derived_isnull,~st_isnull);
EXPORT Layout_FilterPrimNames_Candidates := RECORD
  {FilterPrimNames_prp} AND NOT [cnp_name,prim_name_derived];
  INTEGER2 active_duns_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_duns_number_isnull := (FilterPrimNames_prp.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR FilterPrimNames_prp.active_duns_number = (TYPEOF(FilterPrimNames_prp.active_duns_number))''); // Simplify later processing 
  INTEGER2 active_enterprise_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_enterprise_number_isnull := (FilterPrimNames_prp.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number) OR FilterPrimNames_prp.active_enterprise_number = (TYPEOF(FilterPrimNames_prp.active_enterprise_number))''); // Simplify later processing 
  INTEGER2 active_domestic_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_domestic_corp_key_isnull := (FilterPrimNames_prp.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) OR FilterPrimNames_prp.active_domestic_corp_key = (TYPEOF(FilterPrimNames_prp.active_domestic_corp_key))''); // Simplify later processing 
  INTEGER2 company_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_fein_isnull := (FilterPrimNames_prp.company_fein  IN SET(s.nulls_company_fein,company_fein) OR FilterPrimNames_prp.company_fein = (TYPEOF(FilterPrimNames_prp.company_fein))''); // Simplify later processing 
  UNSIGNED company_fein_cnt := 0; // Number of instances with this particular field value
  UNSIGNED company_fein_e1_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED1 company_fein_len := LENGTH(TRIM(FilterPrimNames_prp.company_fein));
  STRING500 cnp_name := FilterPrimNames_prp.cnp_name; // Expanded wordbag field
  INTEGER2 cnp_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_name_isnull := (FilterPrimNames_prp.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR FilterPrimNames_prp.cnp_name = (TYPEOF(FilterPrimNames_prp.cnp_name))''); // Simplify later processing 
  INTEGER2 cnp_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_number_isnull := (FilterPrimNames_prp.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR FilterPrimNames_prp.cnp_number = (TYPEOF(FilterPrimNames_prp.cnp_number))''); // Simplify later processing 
  STRING500 prim_name_derived := FilterPrimNames_prp.prim_name_derived; // Expanded wordbag field
  INTEGER2 prim_name_derived_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_derived_isnull := (FilterPrimNames_prp.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived) OR FilterPrimNames_prp.prim_name_derived = (TYPEOF(FilterPrimNames_prp.prim_name_derived))''); // Simplify later processing 
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := (FilterPrimNames_prp.st  IN SET(s.nulls_st,st) OR FilterPrimNames_prp.st = (TYPEOF(FilterPrimNames_prp.st))''); // Simplify later processing 
  INTEGER2 prim_range_derived_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_derived_isnull := (FilterPrimNames_prp.prim_range_derived  IN SET(s.nulls_prim_range_derived,prim_range_derived) OR FilterPrimNames_prp.prim_range_derived = (TYPEOF(FilterPrimNames_prp.prim_range_derived))''); // Simplify later processing 
END;
SHARED FilterPrimNames_pp := TABLE(FilterPrimNames_prp,Layout_FilterPrimNames_Candidates)(~prim_name_derived_isnull,~st_isnull);
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0} AND NOT [cnp_name,prim_name_derived]; // remove wordbag fields which need to be expanded
  INTEGER2 active_duns_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_duns_number_isnull := (h0.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR h0.active_duns_number = (TYPEOF(h0.active_duns_number))''); // Simplify later processing 
  INTEGER2 active_enterprise_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_enterprise_number_isnull := (h0.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number) OR h0.active_enterprise_number = (TYPEOF(h0.active_enterprise_number))''); // Simplify later processing 
  INTEGER2 active_domestic_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_domestic_corp_key_isnull := (h0.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) OR h0.active_domestic_corp_key = (TYPEOF(h0.active_domestic_corp_key))''); // Simplify later processing 
  INTEGER2 hist_enterprise_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN hist_enterprise_number_isnull := (h0.hist_enterprise_number  IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number) OR h0.hist_enterprise_number = (TYPEOF(h0.hist_enterprise_number))''); // Simplify later processing 
  INTEGER2 hist_duns_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN hist_duns_number_isnull := (h0.hist_duns_number  IN SET(s.nulls_hist_duns_number,hist_duns_number) OR h0.hist_duns_number = (TYPEOF(h0.hist_duns_number))''); // Simplify later processing 
  INTEGER2 hist_domestic_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN hist_domestic_corp_key_isnull := (h0.hist_domestic_corp_key  IN SET(s.nulls_hist_domestic_corp_key,hist_domestic_corp_key) OR h0.hist_domestic_corp_key = (TYPEOF(h0.hist_domestic_corp_key))''); // Simplify later processing 
  INTEGER2 foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN foreign_corp_key_isnull := (h0.foreign_corp_key  IN SET(s.nulls_foreign_corp_key,foreign_corp_key) OR h0.foreign_corp_key = (TYPEOF(h0.foreign_corp_key))''); // Simplify later processing 
  INTEGER2 unk_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN unk_corp_key_isnull := (h0.unk_corp_key  IN SET(s.nulls_unk_corp_key,unk_corp_key) OR h0.unk_corp_key = (TYPEOF(h0.unk_corp_key))''); // Simplify later processing 
  INTEGER2 ebr_file_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ebr_file_number_isnull := (h0.ebr_file_number  IN SET(s.nulls_ebr_file_number,ebr_file_number) OR h0.ebr_file_number = (TYPEOF(h0.ebr_file_number))''); // Simplify later processing 
  INTEGER2 company_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_fein_isnull := (h0.company_fein  IN SET(s.nulls_company_fein,company_fein) OR h0.company_fein = (TYPEOF(h0.company_fein))''); // Simplify later processing 
  UNSIGNED company_fein_cnt := 0; // Number of instances with this particular field value
  UNSIGNED company_fein_e1_cnt := 0; // Number of names instances matching this one by edit distance
  STRING500 cnp_name := h0.cnp_name; // Expanded wordbag field
  INTEGER2 cnp_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_name_isnull := (h0.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR h0.cnp_name = (TYPEOF(h0.cnp_name))''); // Simplify later processing 
  INTEGER2 company_name_type_derived_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_name_type_derived_isnull := (h0.company_name_type_derived  IN SET(s.nulls_company_name_type_derived,company_name_type_derived) OR h0.company_name_type_derived = (TYPEOF(h0.company_name_type_derived))''); // Simplify later processing 
  INTEGER2 cnp_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_number_isnull := (h0.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR h0.cnp_number = (TYPEOF(h0.cnp_number))''); // Simplify later processing 
  INTEGER2 cnp_btype_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_btype_isnull := (h0.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR h0.cnp_btype = (TYPEOF(h0.cnp_btype))''); // Simplify later processing 
  INTEGER2 company_phone_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_phone_isnull := (h0.company_phone  IN SET(s.nulls_company_phone,company_phone) OR h0.company_phone = (TYPEOF(h0.company_phone))''); // Simplify later processing 
  STRING500 prim_name_derived := h0.prim_name_derived; // Expanded wordbag field
  INTEGER2 prim_name_derived_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_derived_isnull := (h0.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived) OR h0.prim_name_derived = (TYPEOF(h0.prim_name_derived))''); // Simplify later processing 
  INTEGER2 sec_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sec_range_isnull := (h0.sec_range  IN SET(s.nulls_sec_range,sec_range) OR h0.sec_range = (TYPEOF(h0.sec_range))''); // Simplify later processing 
  INTEGER2 v_city_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN v_city_name_isnull := (h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR h0.v_city_name = (TYPEOF(h0.v_city_name))''); // Simplify later processing 
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := (h0.st  IN SET(s.nulls_st,st) OR h0.st = (TYPEOF(h0.st))''); // Simplify later processing 
  INTEGER2 zip_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip_isnull := (h0.zip  IN SET(s.nulls_zip,zip) OR h0.zip = (TYPEOF(h0.zip))''); // Simplify later processing 
  INTEGER2 prim_range_derived_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_derived_isnull := (h0.prim_range_derived  IN SET(s.nulls_prim_range_derived,prim_range_derived) OR h0.prim_range_derived = (TYPEOF(h0.prim_range_derived))''); // Simplify later processing 
  INTEGER2 company_csz_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_csz_isnull := ((h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR h0.v_city_name = (TYPEOF(h0.v_city_name))'') AND (h0.st  IN SET(s.nulls_st,st) OR h0.st = (TYPEOF(h0.st))'') AND (h0.zip  IN SET(s.nulls_zip,zip) OR h0.zip = (TYPEOF(h0.zip))'')); // Simplify later processing 
  INTEGER2 company_addr1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_addr1_isnull := ((h0.prim_range_derived  IN SET(s.nulls_prim_range_derived,prim_range_derived) OR h0.prim_range_derived = (TYPEOF(h0.prim_range_derived))'') AND (h0.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived) OR h0.prim_name_derived = (TYPEOF(h0.prim_name_derived))'') AND (h0.sec_range  IN SET(s.nulls_sec_range,sec_range) OR h0.sec_range = (TYPEOF(h0.sec_range))'')); // Simplify later processing 
  INTEGER2 company_address_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_address_isnull := (((h0.prim_range_derived  IN SET(s.nulls_prim_range_derived,prim_range_derived) OR h0.prim_range_derived = (TYPEOF(h0.prim_range_derived))'') AND (h0.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived) OR h0.prim_name_derived = (TYPEOF(h0.prim_name_derived))'') AND (h0.sec_range  IN SET(s.nulls_sec_range,sec_range) OR h0.sec_range = (TYPEOF(h0.sec_range))'')) AND ((h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR h0.v_city_name = (TYPEOF(h0.v_city_name))'') AND (h0.st  IN SET(s.nulls_st,st) OR h0.st = (TYPEOF(h0.st))'') AND (h0.zip  IN SET(s.nulls_zip,zip) OR h0.zip = (TYPEOF(h0.zip))''))); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates)(~prim_name_derived_isnull,~st_isnull,~(company_address_isnull OR (company_addr1_isnull OR prim_range_derived_isnull AND prim_name_derived_isnull AND sec_range_isnull) AND (company_csz_isnull OR v_city_name_isnull AND st_isnull AND zip_isnull)));
//Now add the weights of each field one by one
 
//Would also create auto-id fields here
 
layout_candidates add_company_name_type_derived(layout_candidates le,Specificities(ih).company_name_type_derived_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_name_type_derived_weight100 := MAP (le.company_name_type_derived_isnull => 0, patch_default and ri.field_specificity=0 => s.company_name_type_derived_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j23 := JOIN(h1,PULL(Specificities(ih).company_name_type_derived_values_persisted),LEFT.company_name_type_derived=RIGHT.company_name_type_derived,add_company_name_type_derived(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cnp_btype(layout_candidates le,Specificities(ih).cnp_btype_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_btype_weight100 := MAP (le.cnp_btype_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_btype_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j22 := JOIN(j23,PULL(Specificities(ih).cnp_btype_values_persisted),LEFT.cnp_btype=RIGHT.cnp_btype,add_cnp_btype(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_st(layout_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j21 := JOIN(j22,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_st(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_v_city_name(layout_candidates le,Specificities(ih).v_city_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.v_city_name_weight100 := MAP (le.v_city_name_isnull => 0, patch_default and ri.field_specificity=0 => s.v_city_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j21,s.nulls_v_city_name,Specificities(ih).v_city_name_values_persisted,v_city_name,v_city_name_weight100,add_v_city_name,j20);
layout_candidates add_sec_range(layout_candidates le,Specificities(ih).sec_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sec_range_weight100 := MAP (le.sec_range_isnull => 0, patch_default and ri.field_specificity=0 => s.sec_range_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j20,s.nulls_sec_range,Specificities(ih).sec_range_values_persisted,sec_range,sec_range_weight100,add_sec_range,j19);
layout_candidates add_prim_name_derived(layout_candidates le,Specificities(ih).prim_name_derived_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_derived_weight100 := MAP (le.prim_name_derived_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_derived_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.prim_name_derived := IF( ri.field_specificity<>0 or ri.word<>'',SELF.prim_name_derived_weight100+' '+ri.word,SALT311.Fn_WordBag_AppendSpecs_Fake(le.prim_name_derived, s.prim_name_derived_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j19,s.nulls_prim_name_derived,Specificities(ih).prim_name_derived_values_persisted,prim_name_derived,prim_name_derived_weight100,add_prim_name_derived,j18);
layout_candidates add_prim_range_derived(layout_candidates le,Specificities(ih).prim_range_derived_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_derived_weight100 := MAP (le.prim_range_derived_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_derived_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j18,s.nulls_prim_range_derived,Specificities(ih).prim_range_derived_values_persisted,prim_range_derived,prim_range_derived_weight100,add_prim_range_derived,j17);
layout_candidates add_cnp_name(layout_candidates le,Specificities(ih).cnp_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_name_weight100 := MAP (le.cnp_name_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.cnp_name := IF( ri.field_specificity<>0 or ri.word<>'',SELF.cnp_name_weight100+' '+ri.word,SALT311.Fn_WordBag_AppendSpecs_Fake(le.cnp_name, s.cnp_name_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j17,s.nulls_cnp_name,Specificities(ih).cnp_name_values_persisted,cnp_name,cnp_name_weight100,add_cnp_name,j16);
layout_candidates add_company_csz(layout_candidates le,Specificities(ih).company_csz_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_csz_weight100 := MAP (le.company_csz_isnull => 0, patch_default and ri.field_specificity=0 => s.company_csz_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j16,s.nulls_company_csz,Specificities(ih).company_csz_values_persisted,company_csz,company_csz_weight100,add_company_csz,j15);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip_weight100 := MAP (le.zip_isnull => 0, patch_default and ri.field_specificity=0 => s.zip_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j15,s.nulls_zip,Specificities(ih).zip_values_persisted,zip,zip_weight100,add_zip,j14);
layout_candidates add_cnp_number(layout_candidates le,Specificities(ih).cnp_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_number_weight100 := MAP (le.cnp_number_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j14,s.nulls_cnp_number,Specificities(ih).cnp_number_values_persisted,cnp_number,cnp_number_weight100,add_cnp_number,j13);
layout_candidates add_company_addr1(layout_candidates le,Specificities(ih).company_addr1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_addr1_weight100 := MAP (le.company_addr1_isnull => 0, patch_default and ri.field_specificity=0 => s.company_addr1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j13,s.nulls_company_addr1,Specificities(ih).company_addr1_values_persisted,company_addr1,company_addr1_weight100,add_company_addr1,j12);
layout_candidates add_company_fein(layout_candidates le,Specificities(ih).company_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_fein_cnt := ri.cnt;
  SELF.company_fein_e1_cnt := ri.e1_cnt;
  SELF.company_fein_weight100 := MAP (le.company_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.company_fein_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j12,s.nulls_company_fein,Specificities(ih).company_fein_values_persisted,company_fein,company_fein_weight100,add_company_fein,j11);
layout_candidates add_company_address(layout_candidates le,Specificities(ih).company_address_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_address_weight100 := MAP (le.company_address_isnull => 0, patch_default and ri.field_specificity=0 => s.company_address_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j11,s.nulls_company_address,Specificities(ih).company_address_values_persisted,company_address,company_address_weight100,add_company_address,j10);
layout_candidates add_company_phone(layout_candidates le,Specificities(ih).company_phone_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_phone_weight100 := MAP (le.company_phone_isnull => 0, patch_default and ri.field_specificity=0 => s.company_phone_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j10,s.nulls_company_phone,Specificities(ih).company_phone_values_persisted,company_phone,company_phone_weight100,add_company_phone,j9);
layout_candidates add_hist_duns_number(layout_candidates le,Specificities(ih).hist_duns_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.hist_duns_number_weight100 := MAP (le.hist_duns_number_isnull => 0, patch_default and ri.field_specificity=0 => s.hist_duns_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j9,s.nulls_hist_duns_number,Specificities(ih).hist_duns_number_values_persisted,hist_duns_number,hist_duns_number_weight100,add_hist_duns_number,j8);
layout_candidates add_active_duns_number(layout_candidates le,Specificities(ih).active_duns_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_duns_number_weight100 := MAP (le.active_duns_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_duns_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j8,s.nulls_active_duns_number,Specificities(ih).active_duns_number_values_persisted,active_duns_number,active_duns_number_weight100,add_active_duns_number,j7);
layout_candidates add_unk_corp_key(layout_candidates le,Specificities(ih).unk_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.unk_corp_key_weight100 := MAP (le.unk_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.unk_corp_key_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j7,s.nulls_unk_corp_key,Specificities(ih).unk_corp_key_values_persisted,unk_corp_key,unk_corp_key_weight100,add_unk_corp_key,j6);
layout_candidates add_foreign_corp_key(layout_candidates le,Specificities(ih).foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.foreign_corp_key_weight100 := MAP (le.foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.foreign_corp_key_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j6,s.nulls_foreign_corp_key,Specificities(ih).foreign_corp_key_values_persisted,foreign_corp_key,foreign_corp_key_weight100,add_foreign_corp_key,j5);
layout_candidates add_hist_domestic_corp_key(layout_candidates le,Specificities(ih).hist_domestic_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.hist_domestic_corp_key_weight100 := MAP (le.hist_domestic_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.hist_domestic_corp_key_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j5,s.nulls_hist_domestic_corp_key,Specificities(ih).hist_domestic_corp_key_values_persisted,hist_domestic_corp_key,hist_domestic_corp_key_weight100,add_hist_domestic_corp_key,j4);
layout_candidates add_active_domestic_corp_key(layout_candidates le,Specificities(ih).active_domestic_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_domestic_corp_key_weight100 := MAP (le.active_domestic_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.active_domestic_corp_key_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j4,s.nulls_active_domestic_corp_key,Specificities(ih).active_domestic_corp_key_values_persisted,active_domestic_corp_key,active_domestic_corp_key_weight100,add_active_domestic_corp_key,j3);
layout_candidates add_ebr_file_number(layout_candidates le,Specificities(ih).ebr_file_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ebr_file_number_weight100 := MAP (le.ebr_file_number_isnull => 0, patch_default and ri.field_specificity=0 => s.ebr_file_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j3,s.nulls_ebr_file_number,Specificities(ih).ebr_file_number_values_persisted,ebr_file_number,ebr_file_number_weight100,add_ebr_file_number,j2);
layout_candidates add_hist_enterprise_number(layout_candidates le,Specificities(ih).hist_enterprise_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.hist_enterprise_number_weight100 := MAP (le.hist_enterprise_number_isnull => 0, patch_default and ri.field_specificity=0 => s.hist_enterprise_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j2,s.nulls_hist_enterprise_number,Specificities(ih).hist_enterprise_number_values_persisted,hist_enterprise_number,hist_enterprise_number_weight100,add_hist_enterprise_number,j1);
layout_candidates add_active_enterprise_number(layout_candidates le,Specificities(ih).active_enterprise_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_enterprise_number_weight100 := MAP (le.active_enterprise_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_enterprise_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j1,s.nulls_active_enterprise_number,Specificities(ih).active_enterprise_number_values_persisted,active_enterprise_number,active_enterprise_number_weight100,add_active_enterprise_number,j0);
//Using HASH(did) to get smoother distribution
SHARED j0_dist := DISTRIBUTE(j0, HASH(Proxid));
SHARED Annotated_NoDedup := j0_dist : PERSIST('~temp::Proxid::BIPV2_ProxID::mc_nodedup',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // No dedup- for aggressive slicing
SHARED Annotated_Dedup := IF(Config.FastSlice, j0_dist, MAC_RollupCandidates(Annotated_NoDedup, fieldListWithPropFlags, fieldList, FALSE));
export Annotated := Annotated_Dedup : PERSIST('~temp::Proxid::BIPV2_ProxID::mc',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Distributed for keybuild case
 
//Now prepare candidate file for SrcRidVlid attribute file
layout_SrcRidVlid_candidates add_SrcRidVlid_active_enterprise_number(layout_SrcRidVlid_candidates le,Specificities(ih).active_enterprise_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_enterprise_number_weight100 := MAP (le.active_enterprise_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_enterprise_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(SrcRidVlid_pp,s.nulls_active_enterprise_number,Specificities(ih).active_enterprise_number_values_persisted,active_enterprise_number,active_enterprise_number_weight100,add_SrcRidVlid_active_enterprise_number,jSrcRidVlid_0);
layout_SrcRidVlid_candidates add_SrcRidVlid_active_domestic_corp_key(layout_SrcRidVlid_candidates le,Specificities(ih).active_domestic_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_domestic_corp_key_weight100 := MAP (le.active_domestic_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.active_domestic_corp_key_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jSrcRidVlid_0,s.nulls_active_domestic_corp_key,Specificities(ih).active_domestic_corp_key_values_persisted,active_domestic_corp_key,active_domestic_corp_key_weight100,add_SrcRidVlid_active_domestic_corp_key,jSrcRidVlid_3);
layout_SrcRidVlid_candidates add_SrcRidVlid_active_duns_number(layout_SrcRidVlid_candidates le,Specificities(ih).active_duns_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_duns_number_weight100 := MAP (le.active_duns_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_duns_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jSrcRidVlid_3,s.nulls_active_duns_number,Specificities(ih).active_duns_number_values_persisted,active_duns_number,active_duns_number_weight100,add_SrcRidVlid_active_duns_number,jSrcRidVlid_7);
layout_SrcRidVlid_candidates add_SrcRidVlid_company_fein(layout_SrcRidVlid_candidates le,Specificities(ih).company_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_fein_cnt := ri.cnt;
  SELF.company_fein_e1_cnt := ri.e1_cnt;
  SELF.company_fein_weight100 := MAP (le.company_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.company_fein_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jSrcRidVlid_7,s.nulls_company_fein,Specificities(ih).company_fein_values_persisted,company_fein,company_fein_weight100,add_SrcRidVlid_company_fein,jSrcRidVlid_11);
layout_SrcRidVlid_candidates add_SrcRidVlid_cnp_number(layout_SrcRidVlid_candidates le,Specificities(ih).cnp_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_number_weight100 := MAP (le.cnp_number_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jSrcRidVlid_11,s.nulls_cnp_number,Specificities(ih).cnp_number_values_persisted,cnp_number,cnp_number_weight100,add_SrcRidVlid_cnp_number,jSrcRidVlid_13);
layout_SrcRidVlid_candidates add_SrcRidVlid_cnp_name(layout_SrcRidVlid_candidates le,Specificities(ih).cnp_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_name_weight100 := MAP (le.cnp_name_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.cnp_name := IF( ri.field_specificity<>0 or ri.word<>'',SELF.cnp_name_weight100+' '+ri.word,SALT311.Fn_WordBag_AppendSpecs_Fake(le.cnp_name, s.cnp_name_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jSrcRidVlid_13,s.nulls_cnp_name,Specificities(ih).cnp_name_values_persisted,cnp_name,cnp_name_weight100,add_SrcRidVlid_cnp_name,jSrcRidVlid_16);
layout_SrcRidVlid_candidates add_SrcRidVlid_prim_range_derived(layout_SrcRidVlid_candidates le,Specificities(ih).prim_range_derived_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_derived_weight100 := MAP (le.prim_range_derived_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_derived_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jSrcRidVlid_16,s.nulls_prim_range_derived,Specificities(ih).prim_range_derived_values_persisted,prim_range_derived,prim_range_derived_weight100,add_SrcRidVlid_prim_range_derived,jSrcRidVlid_17);
layout_SrcRidVlid_candidates add_SrcRidVlid_prim_name_derived(layout_SrcRidVlid_candidates le,Specificities(ih).prim_name_derived_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_derived_weight100 := MAP (le.prim_name_derived_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_derived_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.prim_name_derived := IF( ri.field_specificity<>0 or ri.word<>'',SELF.prim_name_derived_weight100+' '+ri.word,SALT311.Fn_WordBag_AppendSpecs_Fake(le.prim_name_derived, s.prim_name_derived_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jSrcRidVlid_17,s.nulls_prim_name_derived,Specificities(ih).prim_name_derived_values_persisted,prim_name_derived,prim_name_derived_weight100,add_SrcRidVlid_prim_name_derived,jSrcRidVlid_18);
layout_SrcRidVlid_candidates add_SrcRidVlid_st(layout_SrcRidVlid_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
jSrcRidVlid_21 := JOIN(jSrcRidVlid_18,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_SrcRidVlid_st(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
EXPORT SrcRidVlid_candidates := jSrcRidVlid_21 : PERSIST('~temp::Proxid::BIPV2_ProxID::mc::SrcRidVlid',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
//Now prepare candidate file for ForeignCorpkey attribute file
layout_ForeignCorpkey_candidates add_ForeignCorpkey_active_enterprise_number(layout_ForeignCorpkey_candidates le,Specificities(ih).active_enterprise_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_enterprise_number_weight100 := MAP (le.active_enterprise_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_enterprise_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(ForeignCorpkey_pp,s.nulls_active_enterprise_number,Specificities(ih).active_enterprise_number_values_persisted,active_enterprise_number,active_enterprise_number_weight100,add_ForeignCorpkey_active_enterprise_number,jForeignCorpkey_0);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_active_domestic_corp_key(layout_ForeignCorpkey_candidates le,Specificities(ih).active_domestic_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_domestic_corp_key_weight100 := MAP (le.active_domestic_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.active_domestic_corp_key_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jForeignCorpkey_0,s.nulls_active_domestic_corp_key,Specificities(ih).active_domestic_corp_key_values_persisted,active_domestic_corp_key,active_domestic_corp_key_weight100,add_ForeignCorpkey_active_domestic_corp_key,jForeignCorpkey_3);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_active_duns_number(layout_ForeignCorpkey_candidates le,Specificities(ih).active_duns_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_duns_number_weight100 := MAP (le.active_duns_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_duns_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jForeignCorpkey_3,s.nulls_active_duns_number,Specificities(ih).active_duns_number_values_persisted,active_duns_number,active_duns_number_weight100,add_ForeignCorpkey_active_duns_number,jForeignCorpkey_7);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_company_fein(layout_ForeignCorpkey_candidates le,Specificities(ih).company_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_fein_cnt := ri.cnt;
  SELF.company_fein_e1_cnt := ri.e1_cnt;
  SELF.company_fein_weight100 := MAP (le.company_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.company_fein_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jForeignCorpkey_7,s.nulls_company_fein,Specificities(ih).company_fein_values_persisted,company_fein,company_fein_weight100,add_ForeignCorpkey_company_fein,jForeignCorpkey_11);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_cnp_number(layout_ForeignCorpkey_candidates le,Specificities(ih).cnp_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_number_weight100 := MAP (le.cnp_number_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jForeignCorpkey_11,s.nulls_cnp_number,Specificities(ih).cnp_number_values_persisted,cnp_number,cnp_number_weight100,add_ForeignCorpkey_cnp_number,jForeignCorpkey_13);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_cnp_name(layout_ForeignCorpkey_candidates le,Specificities(ih).cnp_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_name_weight100 := MAP (le.cnp_name_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.cnp_name := IF( ri.field_specificity<>0 or ri.word<>'',SELF.cnp_name_weight100+' '+ri.word,SALT311.Fn_WordBag_AppendSpecs_Fake(le.cnp_name, s.cnp_name_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jForeignCorpkey_13,s.nulls_cnp_name,Specificities(ih).cnp_name_values_persisted,cnp_name,cnp_name_weight100,add_ForeignCorpkey_cnp_name,jForeignCorpkey_16);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_prim_range_derived(layout_ForeignCorpkey_candidates le,Specificities(ih).prim_range_derived_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_derived_weight100 := MAP (le.prim_range_derived_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_derived_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jForeignCorpkey_16,s.nulls_prim_range_derived,Specificities(ih).prim_range_derived_values_persisted,prim_range_derived,prim_range_derived_weight100,add_ForeignCorpkey_prim_range_derived,jForeignCorpkey_17);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_prim_name_derived(layout_ForeignCorpkey_candidates le,Specificities(ih).prim_name_derived_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_derived_weight100 := MAP (le.prim_name_derived_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_derived_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.prim_name_derived := IF( ri.field_specificity<>0 or ri.word<>'',SELF.prim_name_derived_weight100+' '+ri.word,SALT311.Fn_WordBag_AppendSpecs_Fake(le.prim_name_derived, s.prim_name_derived_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jForeignCorpkey_17,s.nulls_prim_name_derived,Specificities(ih).prim_name_derived_values_persisted,prim_name_derived,prim_name_derived_weight100,add_ForeignCorpkey_prim_name_derived,jForeignCorpkey_18);
layout_ForeignCorpkey_candidates add_ForeignCorpkey_st(layout_ForeignCorpkey_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
jForeignCorpkey_21 := JOIN(jForeignCorpkey_18,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_ForeignCorpkey_st(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
EXPORT ForeignCorpkey_candidates := jForeignCorpkey_21 : PERSIST('~temp::Proxid::BIPV2_ProxID::mc::ForeignCorpkey',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
//Now prepare candidate file for RAAddresses attribute file
layout_RAAddresses_candidates add_RAAddresses_active_enterprise_number(layout_RAAddresses_candidates le,Specificities(ih).active_enterprise_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_enterprise_number_weight100 := MAP (le.active_enterprise_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_enterprise_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(RAAddresses_pp,s.nulls_active_enterprise_number,Specificities(ih).active_enterprise_number_values_persisted,active_enterprise_number,active_enterprise_number_weight100,add_RAAddresses_active_enterprise_number,jRAAddresses_0);
layout_RAAddresses_candidates add_RAAddresses_active_domestic_corp_key(layout_RAAddresses_candidates le,Specificities(ih).active_domestic_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_domestic_corp_key_weight100 := MAP (le.active_domestic_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.active_domestic_corp_key_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jRAAddresses_0,s.nulls_active_domestic_corp_key,Specificities(ih).active_domestic_corp_key_values_persisted,active_domestic_corp_key,active_domestic_corp_key_weight100,add_RAAddresses_active_domestic_corp_key,jRAAddresses_3);
layout_RAAddresses_candidates add_RAAddresses_active_duns_number(layout_RAAddresses_candidates le,Specificities(ih).active_duns_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_duns_number_weight100 := MAP (le.active_duns_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_duns_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jRAAddresses_3,s.nulls_active_duns_number,Specificities(ih).active_duns_number_values_persisted,active_duns_number,active_duns_number_weight100,add_RAAddresses_active_duns_number,jRAAddresses_7);
layout_RAAddresses_candidates add_RAAddresses_company_fein(layout_RAAddresses_candidates le,Specificities(ih).company_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_fein_cnt := ri.cnt;
  SELF.company_fein_e1_cnt := ri.e1_cnt;
  SELF.company_fein_weight100 := MAP (le.company_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.company_fein_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jRAAddresses_7,s.nulls_company_fein,Specificities(ih).company_fein_values_persisted,company_fein,company_fein_weight100,add_RAAddresses_company_fein,jRAAddresses_11);
layout_RAAddresses_candidates add_RAAddresses_cnp_number(layout_RAAddresses_candidates le,Specificities(ih).cnp_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_number_weight100 := MAP (le.cnp_number_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jRAAddresses_11,s.nulls_cnp_number,Specificities(ih).cnp_number_values_persisted,cnp_number,cnp_number_weight100,add_RAAddresses_cnp_number,jRAAddresses_13);
layout_RAAddresses_candidates add_RAAddresses_cnp_name(layout_RAAddresses_candidates le,Specificities(ih).cnp_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_name_weight100 := MAP (le.cnp_name_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.cnp_name := IF( ri.field_specificity<>0 or ri.word<>'',SELF.cnp_name_weight100+' '+ri.word,SALT311.Fn_WordBag_AppendSpecs_Fake(le.cnp_name, s.cnp_name_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jRAAddresses_13,s.nulls_cnp_name,Specificities(ih).cnp_name_values_persisted,cnp_name,cnp_name_weight100,add_RAAddresses_cnp_name,jRAAddresses_16);
layout_RAAddresses_candidates add_RAAddresses_prim_range_derived(layout_RAAddresses_candidates le,Specificities(ih).prim_range_derived_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_derived_weight100 := MAP (le.prim_range_derived_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_derived_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jRAAddresses_16,s.nulls_prim_range_derived,Specificities(ih).prim_range_derived_values_persisted,prim_range_derived,prim_range_derived_weight100,add_RAAddresses_prim_range_derived,jRAAddresses_17);
layout_RAAddresses_candidates add_RAAddresses_prim_name_derived(layout_RAAddresses_candidates le,Specificities(ih).prim_name_derived_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_derived_weight100 := MAP (le.prim_name_derived_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_derived_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.prim_name_derived := IF( ri.field_specificity<>0 or ri.word<>'',SELF.prim_name_derived_weight100+' '+ri.word,SALT311.Fn_WordBag_AppendSpecs_Fake(le.prim_name_derived, s.prim_name_derived_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jRAAddresses_17,s.nulls_prim_name_derived,Specificities(ih).prim_name_derived_values_persisted,prim_name_derived,prim_name_derived_weight100,add_RAAddresses_prim_name_derived,jRAAddresses_18);
layout_RAAddresses_candidates add_RAAddresses_st(layout_RAAddresses_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
jRAAddresses_21 := JOIN(jRAAddresses_18,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_RAAddresses_st(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
EXPORT RAAddresses_candidates := jRAAddresses_21 : PERSIST('~temp::Proxid::BIPV2_ProxID::mc::RAAddresses',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
//Now prepare candidate file for FilterPrimNames attribute file
layout_FilterPrimNames_candidates add_FilterPrimNames_active_enterprise_number(layout_FilterPrimNames_candidates le,Specificities(ih).active_enterprise_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_enterprise_number_weight100 := MAP (le.active_enterprise_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_enterprise_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(FilterPrimNames_pp,s.nulls_active_enterprise_number,Specificities(ih).active_enterprise_number_values_persisted,active_enterprise_number,active_enterprise_number_weight100,add_FilterPrimNames_active_enterprise_number,jFilterPrimNames_0);
layout_FilterPrimNames_candidates add_FilterPrimNames_active_domestic_corp_key(layout_FilterPrimNames_candidates le,Specificities(ih).active_domestic_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_domestic_corp_key_weight100 := MAP (le.active_domestic_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.active_domestic_corp_key_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jFilterPrimNames_0,s.nulls_active_domestic_corp_key,Specificities(ih).active_domestic_corp_key_values_persisted,active_domestic_corp_key,active_domestic_corp_key_weight100,add_FilterPrimNames_active_domestic_corp_key,jFilterPrimNames_3);
layout_FilterPrimNames_candidates add_FilterPrimNames_active_duns_number(layout_FilterPrimNames_candidates le,Specificities(ih).active_duns_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_duns_number_weight100 := MAP (le.active_duns_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_duns_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jFilterPrimNames_3,s.nulls_active_duns_number,Specificities(ih).active_duns_number_values_persisted,active_duns_number,active_duns_number_weight100,add_FilterPrimNames_active_duns_number,jFilterPrimNames_7);
layout_FilterPrimNames_candidates add_FilterPrimNames_company_fein(layout_FilterPrimNames_candidates le,Specificities(ih).company_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_fein_cnt := ri.cnt;
  SELF.company_fein_e1_cnt := ri.e1_cnt;
  SELF.company_fein_weight100 := MAP (le.company_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.company_fein_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jFilterPrimNames_7,s.nulls_company_fein,Specificities(ih).company_fein_values_persisted,company_fein,company_fein_weight100,add_FilterPrimNames_company_fein,jFilterPrimNames_11);
layout_FilterPrimNames_candidates add_FilterPrimNames_cnp_number(layout_FilterPrimNames_candidates le,Specificities(ih).cnp_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_number_weight100 := MAP (le.cnp_number_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jFilterPrimNames_11,s.nulls_cnp_number,Specificities(ih).cnp_number_values_persisted,cnp_number,cnp_number_weight100,add_FilterPrimNames_cnp_number,jFilterPrimNames_13);
layout_FilterPrimNames_candidates add_FilterPrimNames_cnp_name(layout_FilterPrimNames_candidates le,Specificities(ih).cnp_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_name_weight100 := MAP (le.cnp_name_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.cnp_name := IF( ri.field_specificity<>0 or ri.word<>'',SELF.cnp_name_weight100+' '+ri.word,SALT311.Fn_WordBag_AppendSpecs_Fake(le.cnp_name, s.cnp_name_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jFilterPrimNames_13,s.nulls_cnp_name,Specificities(ih).cnp_name_values_persisted,cnp_name,cnp_name_weight100,add_FilterPrimNames_cnp_name,jFilterPrimNames_16);
layout_FilterPrimNames_candidates add_FilterPrimNames_prim_range_derived(layout_FilterPrimNames_candidates le,Specificities(ih).prim_range_derived_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_derived_weight100 := MAP (le.prim_range_derived_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_derived_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jFilterPrimNames_16,s.nulls_prim_range_derived,Specificities(ih).prim_range_derived_values_persisted,prim_range_derived,prim_range_derived_weight100,add_FilterPrimNames_prim_range_derived,jFilterPrimNames_17);
layout_FilterPrimNames_candidates add_FilterPrimNames_prim_name_derived(layout_FilterPrimNames_candidates le,Specificities(ih).prim_name_derived_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_derived_weight100 := MAP (le.prim_name_derived_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_derived_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.prim_name_derived := IF( ri.field_specificity<>0 or ri.word<>'',SELF.prim_name_derived_weight100+' '+ri.word,SALT311.Fn_WordBag_AppendSpecs_Fake(le.prim_name_derived, s.prim_name_derived_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jFilterPrimNames_17,s.nulls_prim_name_derived,Specificities(ih).prim_name_derived_values_persisted,prim_name_derived,prim_name_derived_weight100,add_FilterPrimNames_prim_name_derived,jFilterPrimNames_18);
layout_FilterPrimNames_candidates add_FilterPrimNames_st(layout_FilterPrimNames_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
jFilterPrimNames_21 := JOIN(jFilterPrimNames_18,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_FilterPrimNames_st(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
EXPORT FilterPrimNames_candidates := jFilterPrimNames_21 : PERSIST('~temp::Proxid::BIPV2_ProxID::mc::FilterPrimNames',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
//Now see if these records are actually linkable
TotalWeight := Annotated.active_enterprise_number_weight100 + Annotated.hist_enterprise_number_weight100 + Annotated.ebr_file_number_weight100 + Annotated.active_domestic_corp_key_weight100 + Annotated.hist_domestic_corp_key_weight100 + Annotated.foreign_corp_key_weight100 + Annotated.unk_corp_key_weight100 + Annotated.active_duns_number_weight100 + Annotated.hist_duns_number_weight100 + Annotated.company_phone_weight100 + Annotated.company_address_weight100 + Annotated.company_fein_weight100 + Annotated.cnp_number_weight100 + Annotated.cnp_name_weight100 + Annotated.cnp_btype_weight100 + Annotated.company_name_type_derived_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
TotalWeight_NoDedup := Annotated_NoDedup.active_enterprise_number_weight100 + Annotated_NoDedup.hist_enterprise_number_weight100 + Annotated_NoDedup.ebr_file_number_weight100 + Annotated_NoDedup.active_domestic_corp_key_weight100 + Annotated_NoDedup.hist_domestic_corp_key_weight100 + Annotated_NoDedup.foreign_corp_key_weight100 + Annotated_NoDedup.unk_corp_key_weight100 + Annotated_NoDedup.active_duns_number_weight100 + Annotated_NoDedup.hist_duns_number_weight100 + Annotated_NoDedup.company_phone_weight100 + Annotated_NoDedup.company_address_weight100 + Annotated_NoDedup.company_fein_weight100 + Annotated_NoDedup.cnp_number_weight100 + Annotated_NoDedup.cnp_name_weight100 + Annotated_NoDedup.cnp_btype_weight100 + Annotated_NoDedup.company_name_type_derived_weight100;
SHARED Linkable_NoDedup := TotalWeight_NoDedup >= Config.MatchThreshold;
EXPORT BuddyCounts := TABLE(IF(Config.FastSlice, Annotated, Annotated_NoDedup),{ buddies, Cnt := COUNT(GROUP) }, buddies, FEW);
EXPORT HasBuddies := TABLE(IF(Config.FastSlice, Annotated, Annotated_NoDedup)(buddies>0), { rcid });
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(); //Attribute Files might bring total score up to threshold
EXPORT Candidates_ForSlice := IF(Config.FastSlice, Candidates, Annotated_NoDedup());
END;
