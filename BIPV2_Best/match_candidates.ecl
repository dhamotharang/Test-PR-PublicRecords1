// Begin code to produce match candidates
IMPORT SALT24,ut;
EXPORT match_candidates(DATASET(layout_Base) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := Specificities(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00,{dt_first_seen,dt_last_seen,source,company_name,company_fein,company_phone,company_url,company_prim_range,company_predir,company_prim_name,company_addr_suffix,company_postdir,company_unit_desig,company_sec_range,company_p_city_name,company_v_city_name,company_st,company_zip5,company_zip4,company_csz,company_addr1,company_address,rcid,Proxid}),HASH(Proxid));
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 company_name_pop := AVE(GROUP,IF(thin_table.company_name IN SET(s.nulls_company_name,company_name),0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF(thin_table.company_fein IN SET(s.nulls_company_fein,company_fein),0,100));
  REAL8 company_phone_pop := AVE(GROUP,IF(thin_table.company_phone IN SET(s.nulls_company_phone,company_phone),0,100));
  REAL8 company_url_pop := AVE(GROUP,IF(thin_table.company_url IN SET(s.nulls_company_url,company_url),0,100));
  REAL8 company_prim_range_pop := AVE(GROUP,IF(thin_table.company_prim_range IN SET(s.nulls_company_prim_range,company_prim_range),0,100));
  REAL8 company_predir_pop := AVE(GROUP,IF(thin_table.company_predir IN SET(s.nulls_company_predir,company_predir),0,100));
  REAL8 company_prim_name_pop := AVE(GROUP,IF(thin_table.company_prim_name IN SET(s.nulls_company_prim_name,company_prim_name),0,100));
  REAL8 company_addr_suffix_pop := AVE(GROUP,IF(thin_table.company_addr_suffix IN SET(s.nulls_company_addr_suffix,company_addr_suffix),0,100));
  REAL8 company_postdir_pop := AVE(GROUP,IF(thin_table.company_postdir IN SET(s.nulls_company_postdir,company_postdir),0,100));
  REAL8 company_unit_desig_pop := AVE(GROUP,IF(thin_table.company_unit_desig IN SET(s.nulls_company_unit_desig,company_unit_desig),0,100));
  REAL8 company_sec_range_pop := AVE(GROUP,IF(thin_table.company_sec_range IN SET(s.nulls_company_sec_range,company_sec_range),0,100));
  REAL8 company_p_city_name_pop := AVE(GROUP,IF(thin_table.company_p_city_name IN SET(s.nulls_company_p_city_name,company_p_city_name),0,100));
  REAL8 company_v_city_name_pop := AVE(GROUP,IF(thin_table.company_v_city_name IN SET(s.nulls_company_v_city_name,company_v_city_name),0,100));
  REAL8 company_st_pop := AVE(GROUP,IF(thin_table.company_st IN SET(s.nulls_company_st,company_st),0,100));
  REAL8 company_zip5_pop := AVE(GROUP,IF(thin_table.company_zip5 IN SET(s.nulls_company_zip5,company_zip5),0,100));
  REAL8 company_zip4_pop := AVE(GROUP,IF(thin_table.company_zip4 IN SET(s.nulls_company_zip4,company_zip4),0,100));
  REAL8 company_csz_pop := AVE(GROUP,IF(thin_table.company_csz IN SET(s.nulls_company_csz,company_csz),0,100));
  REAL8 company_addr1_pop := AVE(GROUP,IF(thin_table.company_addr1 IN SET(s.nulls_company_addr1,company_addr1),0,100));
  REAL8 company_address_pop := AVE(GROUP,IF(thin_table.company_address IN SET(s.nulls_company_address,company_address),0,100));
END;
EXPORT PrePropogationStats := TABLE(thin_table,PrePropCounts);
SHARED layout_withpropvars := RECORD
  thin_table;
  unsigned1 company_name_prop := 0;
  integer1 company_name_prop_method := 0;
  unsigned1 company_fein_prop := 0;
  integer1 company_fein_prop_method := 0;
  unsigned1 company_phone_prop := 0;
  integer1 company_phone_prop_method := 0;
  unsigned1 company_url_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
// Now generate code for basis :Proxid,source,data_permits
// There are 9 best types that we can propogate from this basis which means we will not need to use this basis again
  Layout_WithPropVars T_BestCompanyNameCommon_9_0(Layout_WithPropVars le,Best(ih).BestBy_Proxid_best ri) := TRANSFORM
    SELF.company_name_prop_method := MAP ( ri.company_name_method = 0 OR le.company_name_prop_method <> 0 OR le.company_name = ri.company_name => le.company_name_prop_method, // No propogation
      ri.company_name_method = 1 AND ri.company_name[1..length(trim(le.company_name))] = le.company_name  => 1, // This field is extensible
      ri.company_name_method = 2 AND ri.company_name[1..length(trim(le.company_name))] = le.company_name  => 2, // This field is extensible
      ri.company_name_method = 3 AND ri.company_name[1..length(trim(le.company_name))] = le.company_name  => 3, // This field is extensible
      le.company_name_prop_method);
    SELF.company_name := MAP ( le.company_name_prop > 0 OR le.company_name = ri.company_name OR ri.company_name  IN SET(s.nulls_company_name,company_name) => le.company_name, // No propogation
      ri.company_name_method = 1 AND ri.company_name[1..length(trim(le.company_name))] = le.company_name  => ri.company_name, // This field is extensible
      ri.company_name_method = 2 AND ri.company_name[1..length(trim(le.company_name))] = le.company_name  => ri.company_name, // This field is extensible
      ri.company_name_method = 3 AND ri.company_name[1..length(trim(le.company_name))] = le.company_name  => ri.company_name, // This field is extensible
      le.company_name);
    SELF.company_name_prop := IF ( le.company_name = SELF.company_name, le.company_name_prop,1); // Flag the propagation for sliceouts
    SELF.company_fein_prop_method := MAP ( ri.company_fein_method = 0 OR le.company_fein_prop_method <> 0 OR le.company_fein = ri.company_fein => le.company_fein_prop_method, // No propogation
      ri.company_fein_method = 1 AND ri.company_fein[1..length(trim(le.company_fein))] = le.company_fein  => 1, // This field is extensible
      ri.company_fein_method = 2 AND ri.company_fein[1..length(trim(le.company_fein))] = le.company_fein  => 2, // This field is extensible
      le.company_fein_prop_method);
    SELF.company_fein := MAP ( le.company_fein_prop > 0 OR le.company_fein = ri.company_fein OR ri.company_fein  IN SET(s.nulls_company_fein,company_fein) => le.company_fein, // No propogation
      ri.company_fein_method = 1 AND ri.company_fein[1..length(trim(le.company_fein))] = le.company_fein  => ri.company_fein, // This field is extensible
      ri.company_fein_method = 2 AND ri.company_fein[1..length(trim(le.company_fein))] = le.company_fein  => ri.company_fein, // This field is extensible
      le.company_fein);
    SELF.company_fein_prop := IF ( le.company_fein = SELF.company_fein, le.company_fein_prop,1); // Flag the propagation for sliceouts
    SELF.company_phone_prop_method := MAP ( ri.company_phone_method = 0 OR le.company_phone_prop_method <> 0 OR le.company_phone = ri.company_phone => le.company_phone_prop_method, // No propogation
      ri.company_phone_method = 1 AND ri.company_phone[1..length(trim(le.company_phone))] = le.company_phone  => 1, // This field is extensible
      ri.company_phone_method = 2 AND ri.company_phone[1..length(trim(le.company_phone))] = le.company_phone  => 2, // This field is extensible
      le.company_phone_prop_method);
    SELF.company_phone := MAP ( le.company_phone_prop > 0 OR le.company_phone = ri.company_phone OR ri.company_phone  IN SET(s.nulls_company_phone,company_phone) => le.company_phone, // No propogation
      ri.company_phone_method = 1 AND ri.company_phone[1..length(trim(le.company_phone))] = le.company_phone  => ri.company_phone, // This field is extensible
      ri.company_phone_method = 2 AND ri.company_phone[1..length(trim(le.company_phone))] = le.company_phone  => ri.company_phone, // This field is extensible
      le.company_phone);
    SELF.company_phone_prop := IF ( le.company_phone = SELF.company_phone, le.company_phone_prop,1); // Flag the propagation for sliceouts
    SELF.company_url := MAP ( le.company_url_prop > 0 OR le.company_url = ri.company_url OR ri.company_url  IN SET(s.nulls_company_url,company_url) => le.company_url, // No propogation
      ri.company_url[1..length(trim(le.company_url))] = le.company_url  => ri.company_url, // This field is extensible
      le.company_url);
    SELF.company_url_prop := IF ( le.company_url = SELF.company_url, le.company_url_prop,1); // Flag the propagation for sliceouts
    SELF := le;
  END;
SHARED P_BestCompanyNameCommon_9_0 := JOIN(with_props(Proxid <> 0),Best(ih).BestBy_Proxid_best, LEFT.Proxid = RIGHT.Proxid ,T_BestCompanyNameCommon_9_0(LEFT,RIGHT),LEFT OUTER,HASH)
                 + with_props(Proxid = 0);
// Now perform a propogation on the concept company_address using BestType BestCompanyAddressCurrent
//First find the propogation candidates; and translate into normal field names 
  PC := TABLE(Best(ih).BestBy_Proxid_best(Proxid <> 0),{Proxid,TYPEOF(company_address_company_addr1_company_prim_range) company_prim_range := company_address_company_addr1_company_prim_range,TYPEOF(company_address_company_addr1_company_predir) company_predir := company_address_company_addr1_company_predir,TYPEOF(company_address_company_addr1_company_prim_name) company_prim_name := company_address_company_addr1_company_prim_name,TYPEOF(company_address_company_addr1_company_addr_suffix) company_addr_suffix := company_address_company_addr1_company_addr_suffix,TYPEOF(company_address_company_addr1_company_postdir) company_postdir := company_address_company_addr1_company_postdir,TYPEOF(company_address_company_addr1_company_unit_desig) company_unit_desig := company_address_company_addr1_company_unit_desig,TYPEOF(company_address_company_addr1_company_sec_range) company_sec_range := company_address_company_addr1_company_sec_range,TYPEOF(company_address_company_csz_company_v_city_name) company_v_city_name := company_address_company_csz_company_v_city_name,TYPEOF(company_address_company_csz_company_st) company_st := company_address_company_csz_company_st,TYPEOF(company_address_company_csz_company_zip5) company_zip5 := company_address_company_csz_company_zip5,TYPEOF(company_address_company_csz_company_zip4) company_zip4 := company_address_company_csz_company_zip4})(~((company_prim_range  IN SET(s.nulls_company_prim_range,company_prim_range) AND company_predir  IN SET(s.nulls_company_predir,company_predir) AND company_prim_name  IN SET(s.nulls_company_prim_name,company_prim_name) AND company_addr_suffix  IN SET(s.nulls_company_addr_suffix,company_addr_suffix) AND company_postdir  IN SET(s.nulls_company_postdir,company_postdir) AND company_unit_desig  IN SET(s.nulls_company_unit_desig,company_unit_desig) AND company_sec_range  IN SET(s.nulls_company_sec_range,company_sec_range)) AND (company_v_city_name  IN SET(s.nulls_company_v_city_name,company_v_city_name) AND company_st  IN SET(s.nulls_company_st,company_st) AND company_zip5  IN SET(s.nulls_company_zip5,company_zip5) AND company_zip4  IN SET(s.nulls_company_zip4,company_zip4))));
  layout_withpropvars T_company_address_BestCompanyAddressCurrent(layout_withpropvars le,PC ri) := TRANSFORM
  // By the time we are in here - if 'ri' has a value then any fields that need to match do
    BOOLEAN null_rhs := ((ri.company_prim_range  IN SET(s.nulls_company_prim_range,company_prim_range) AND ri.company_predir  IN SET(s.nulls_company_predir,company_predir) AND ri.company_prim_name  IN SET(s.nulls_company_prim_name,company_prim_name) AND ri.company_addr_suffix  IN SET(s.nulls_company_addr_suffix,company_addr_suffix) AND ri.company_postdir  IN SET(s.nulls_company_postdir,company_postdir) AND ri.company_unit_desig  IN SET(s.nulls_company_unit_desig,company_unit_desig) AND ri.company_sec_range  IN SET(s.nulls_company_sec_range,company_sec_range)) AND (ri.company_v_city_name  IN SET(s.nulls_company_v_city_name,company_v_city_name) AND ri.company_st  IN SET(s.nulls_company_st,company_st) AND ri.company_zip5  IN SET(s.nulls_company_zip5,company_zip5) AND ri.company_zip4  IN SET(s.nulls_company_zip4,company_zip4))) OR le.company_address_prop > 0;
    SELF.company_prim_range := IF ( null_rhs OR le.company_prim_range_prop > 0, le.company_prim_range, ri.company_prim_range );
    SELF.company_prim_range_prop := IF ( le.company_prim_range = SELF.company_prim_range, le.company_prim_range_prop,1); // Flag the propagation for sliceouts
    SELF.company_predir := IF ( null_rhs OR le.company_predir_prop > 0, le.company_predir, ri.company_predir );
    SELF.company_predir_prop := IF ( le.company_predir = SELF.company_predir, le.company_predir_prop,1); // Flag the propagation for sliceouts
    SELF.company_prim_name := IF ( null_rhs OR le.company_prim_name_prop > 0, le.company_prim_name, ri.company_prim_name );
    SELF.company_prim_name_prop := IF ( le.company_prim_name = SELF.company_prim_name, le.company_prim_name_prop,1); // Flag the propagation for sliceouts
    SELF.company_addr_suffix := IF ( null_rhs OR le.company_addr_suffix_prop > 0, le.company_addr_suffix, ri.company_addr_suffix );
    SELF.company_addr_suffix_prop := IF ( le.company_addr_suffix = SELF.company_addr_suffix, le.company_addr_suffix_prop,1); // Flag the propagation for sliceouts
    SELF.company_postdir := IF ( null_rhs OR le.company_postdir_prop > 0, le.company_postdir, ri.company_postdir );
    SELF.company_postdir_prop := IF ( le.company_postdir = SELF.company_postdir, le.company_postdir_prop,1); // Flag the propagation for sliceouts
    SELF.company_unit_desig := IF ( null_rhs OR le.company_unit_desig_prop > 0, le.company_unit_desig, ri.company_unit_desig );
    SELF.company_unit_desig_prop := IF ( le.company_unit_desig = SELF.company_unit_desig, le.company_unit_desig_prop,1); // Flag the propagation for sliceouts
    SELF.company_sec_range := IF ( null_rhs OR le.company_sec_range_prop > 0, le.company_sec_range, ri.company_sec_range );
    SELF.company_sec_range_prop := IF ( le.company_sec_range = SELF.company_sec_range, le.company_sec_range_prop,1); // Flag the propagation for sliceouts
    SELF.company_v_city_name := IF ( null_rhs OR le.company_v_city_name_prop > 0, le.company_v_city_name, ri.company_v_city_name );
    SELF.company_v_city_name_prop := IF ( le.company_v_city_name = SELF.company_v_city_name, le.company_v_city_name_prop,1); // Flag the propagation for sliceouts
    SELF.company_st := IF ( null_rhs OR le.company_st_prop > 0, le.company_st, ri.company_st );
    SELF.company_st_prop := IF ( le.company_st = SELF.company_st, le.company_st_prop,1); // Flag the propagation for sliceouts
    SELF.company_zip5 := IF ( null_rhs OR le.company_zip5_prop > 0, le.company_zip5, ri.company_zip5 );
    SELF.company_zip5_prop := IF ( le.company_zip5 = SELF.company_zip5, le.company_zip5_prop,1); // Flag the propagation for sliceouts
    SELF.company_zip4 := IF ( null_rhs OR le.company_zip4_prop > 0, le.company_zip4, ri.company_zip4 );
    SELF.company_zip4_prop := IF ( le.company_zip4 = SELF.company_zip4, le.company_zip4_prop,1); // Flag the propagation for sliceouts
    SELF.company_address_prop := IF( le.company_prim_range_prop = SELF.company_prim_range_prop, 0, 1 ) + IF( le.company_predir_prop = SELF.company_predir_prop, 0, 2 ) + IF( le.company_prim_name_prop = SELF.company_prim_name_prop, 0, 4 ) + IF( le.company_addr_suffix_prop = SELF.company_addr_suffix_prop, 0, 8 ) + IF( le.company_postdir_prop = SELF.company_postdir_prop, 0, 16 ) + IF( le.company_unit_desig_prop = SELF.company_unit_desig_prop, 0, 32 ) + IF( le.company_sec_range_prop = SELF.company_sec_range_prop, 0, 64 ) + IF( le.company_v_city_name_prop = SELF.company_v_city_name_prop, 0, 128 ) + IF( le.company_st_prop = SELF.company_st_prop, 0, 256 ) + IF( le.company_zip5_prop = SELF.company_zip5_prop, 0, 512 ) + IF( le.company_zip4_prop = SELF.company_zip4_prop, 0, 1024 ); // One bit for each propogated field
    SELF := le;
  END;
SHARED J_company_address_BestCompanyAddressCurrent := JOIN(P_BestCompanyNameCommon_9_0,PC, LEFT.Proxid = RIGHT.Proxid  AND ((RIGHT.company_prim_range[1..length(trim(LEFT.company_prim_range))] = LEFT.company_prim_range ) AND (RIGHT.company_predir[1..length(trim(LEFT.company_predir))] = LEFT.company_predir ) AND (RIGHT.company_prim_name[1..length(trim(LEFT.company_prim_name))] = LEFT.company_prim_name ) AND (RIGHT.company_addr_suffix[1..length(trim(LEFT.company_addr_suffix))] = LEFT.company_addr_suffix ) AND (RIGHT.company_postdir[1..length(trim(LEFT.company_postdir))] = LEFT.company_postdir ) AND (RIGHT.company_unit_desig[1..length(trim(LEFT.company_unit_desig))] = LEFT.company_unit_desig ) AND (RIGHT.company_sec_range[1..length(trim(LEFT.company_sec_range))] = LEFT.company_sec_range )) AND ((RIGHT.company_v_city_name[1..length(trim(LEFT.company_v_city_name))] = LEFT.company_v_city_name ) AND (RIGHT.company_st[1..length(trim(LEFT.company_st))] = LEFT.company_st ) AND (RIGHT.company_zip5[1..length(trim(LEFT.company_zip5))] = LEFT.company_zip5 ) AND (RIGHT.company_zip4[1..length(trim(LEFT.company_zip4))] = LEFT.company_zip4 )),T_company_address_BestCompanyAddressCurrent(LEFT,RIGHT),LEFT OUTER);
J_company_address_BestCompanyAddressCurrent do_computes(J_company_address_BestCompanyAddressCurrent le) := TRANSFORM
  SELF.company_csz := HASH32((SALT24.StrType)le.company_v_city_name,(SALT24.StrType)le.company_st,(SALT24.StrType)le.company_zip5,(SALT24.StrType)le.company_zip4); // Combine child fields into 1 for specificity counting
  SELF.company_addr1 := HASH32((SALT24.StrType)le.company_prim_range,(SALT24.StrType)le.company_predir,(SALT24.StrType)le.company_prim_name,(SALT24.StrType)le.company_addr_suffix,(SALT24.StrType)le.company_postdir,(SALT24.StrType)le.company_unit_desig,(SALT24.StrType)le.company_sec_range); // Combine child fields into 1 for specificity counting
  SELF.company_address := HASH32((SALT24.StrType)SELF.company_addr1,(SALT24.StrType)SELF.company_csz); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
SHARED propogated := PROJECT(J_company_address_BestCompanyAddressCurrent,do_computes(left)) : PERSIST('temp::BIPV2_Best_Proxid_Base_mc_props'); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 company_name_pop := AVE(GROUP,IF(propogated.company_name IN SET(s.nulls_company_name,company_name),0,100));
  REAL8 company_name_method_1 := AVE(GROUP,IF(propogated.company_name_prop_method = 1, 100, 0));
  REAL8 company_name_method_2 := AVE(GROUP,IF(propogated.company_name_prop_method = 2, 100, 0));
  REAL8 company_name_method_3 := AVE(GROUP,IF(propogated.company_name_prop_method = 3, 100, 0));
  REAL8 company_fein_pop := AVE(GROUP,IF(propogated.company_fein IN SET(s.nulls_company_fein,company_fein),0,100));
  REAL8 company_fein_method_1 := AVE(GROUP,IF(propogated.company_fein_prop_method = 1, 100, 0));
  REAL8 company_fein_method_2 := AVE(GROUP,IF(propogated.company_fein_prop_method = 2, 100, 0));
  REAL8 company_phone_pop := AVE(GROUP,IF(propogated.company_phone IN SET(s.nulls_company_phone,company_phone),0,100));
  REAL8 company_phone_method_1 := AVE(GROUP,IF(propogated.company_phone_prop_method = 1, 100, 0));
  REAL8 company_phone_method_2 := AVE(GROUP,IF(propogated.company_phone_prop_method = 2, 100, 0));
  REAL8 company_url_pop := AVE(GROUP,IF(propogated.company_url IN SET(s.nulls_company_url,company_url),0,100));
  REAL8 company_prim_range_pop := AVE(GROUP,IF(propogated.company_prim_range IN SET(s.nulls_company_prim_range,company_prim_range),0,100));
  REAL8 company_predir_pop := AVE(GROUP,IF(propogated.company_predir IN SET(s.nulls_company_predir,company_predir),0,100));
  REAL8 company_prim_name_pop := AVE(GROUP,IF(propogated.company_prim_name IN SET(s.nulls_company_prim_name,company_prim_name),0,100));
  REAL8 company_addr_suffix_pop := AVE(GROUP,IF(propogated.company_addr_suffix IN SET(s.nulls_company_addr_suffix,company_addr_suffix),0,100));
  REAL8 company_postdir_pop := AVE(GROUP,IF(propogated.company_postdir IN SET(s.nulls_company_postdir,company_postdir),0,100));
  REAL8 company_unit_desig_pop := AVE(GROUP,IF(propogated.company_unit_desig IN SET(s.nulls_company_unit_desig,company_unit_desig),0,100));
  REAL8 company_sec_range_pop := AVE(GROUP,IF(propogated.company_sec_range IN SET(s.nulls_company_sec_range,company_sec_range),0,100));
  REAL8 company_p_city_name_pop := AVE(GROUP,IF(propogated.company_p_city_name IN SET(s.nulls_company_p_city_name,company_p_city_name),0,100));
  REAL8 company_v_city_name_pop := AVE(GROUP,IF(propogated.company_v_city_name IN SET(s.nulls_company_v_city_name,company_v_city_name),0,100));
  REAL8 company_st_pop := AVE(GROUP,IF(propogated.company_st IN SET(s.nulls_company_st,company_st),0,100));
  REAL8 company_zip5_pop := AVE(GROUP,IF(propogated.company_zip5 IN SET(s.nulls_company_zip5,company_zip5),0,100));
  REAL8 company_zip4_pop := AVE(GROUP,IF(propogated.company_zip4 IN SET(s.nulls_company_zip4,company_zip4),0,100));
  REAL8 company_csz_pop := AVE(GROUP,IF(propogated.company_csz IN SET(s.nulls_company_csz,company_csz),0,100));
  REAL8 company_addr1_pop := AVE(GROUP,IF(propogated.company_addr1 IN SET(s.nulls_company_addr1,company_addr1),0,100));
  REAL8 company_address_pop := AVE(GROUP,IF(propogated.company_address IN SET(s.nulls_company_address,company_address),0,100));
END;
EXPORT PostPropogationStats := TABLE(propogated,PostPropCounts);
SHARED h0 := DEDUP( SORT ( DISTRIBUTE(propogated,HASH(Proxid)), WHOLE RECORD, LOCAL ), WHOLE RECORD, LOCAL );// Only one copy of each record
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT24.UIDType Proxid1;
  SALT24.UIDType Proxid2;
  SALT24.UIDType rcid1 := 0;
  SALT24.UIDType rcid2 := 0;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0};
  INTEGER2 company_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_name_isnull := h0.company_name  IN SET(s.nulls_company_name,company_name); // Simplify later processing 
  UNSIGNED company_name_cnt := 0; // Number of instances with this particular field value
  UNSIGNED company_name_p_cnt := 0; // Number of names instances matching this one phonetically
  UNSIGNED company_name_e1_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED company_name_e1p_cnt := 0; // Number of names instances matching this one by edit distance and phonetics
  INTEGER2 company_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_fein_isnull := h0.company_fein  IN SET(s.nulls_company_fein,company_fein); // Simplify later processing 
  UNSIGNED company_fein_cnt := 0; // Number of instances with this particular field value
  UNSIGNED company_fein_e1_cnt := 0; // Number of names instances matching this one by edit distance
  STRING4 company_fein_Right4 := (STRING4)'';
  UNSIGNED company_fein_Right4_cnt := 0; // Number of names instances matching this one using Right4
  INTEGER2 company_phone_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_phone_isnull := h0.company_phone  IN SET(s.nulls_company_phone,company_phone); // Simplify later processing 
  UNSIGNED company_phone_cnt := 0; // Number of instances with this particular field value
  UNSIGNED company_phone_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 company_url_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_url_isnull := h0.company_url  IN SET(s.nulls_company_url,company_url); // Simplify later processing 
  UNSIGNED company_url_cnt := 0; // Number of instances with this particular field value
  UNSIGNED company_url_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 company_prim_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_prim_range_isnull := h0.company_prim_range  IN SET(s.nulls_company_prim_range,company_prim_range); // Simplify later processing 
  INTEGER2 company_predir_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_predir_isnull := h0.company_predir  IN SET(s.nulls_company_predir,company_predir); // Simplify later processing 
  INTEGER2 company_prim_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_prim_name_isnull := h0.company_prim_name  IN SET(s.nulls_company_prim_name,company_prim_name); // Simplify later processing 
  INTEGER2 company_addr_suffix_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_addr_suffix_isnull := h0.company_addr_suffix  IN SET(s.nulls_company_addr_suffix,company_addr_suffix); // Simplify later processing 
  INTEGER2 company_postdir_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_postdir_isnull := h0.company_postdir  IN SET(s.nulls_company_postdir,company_postdir); // Simplify later processing 
  INTEGER2 company_unit_desig_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_unit_desig_isnull := h0.company_unit_desig  IN SET(s.nulls_company_unit_desig,company_unit_desig); // Simplify later processing 
  INTEGER2 company_sec_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_sec_range_isnull := h0.company_sec_range  IN SET(s.nulls_company_sec_range,company_sec_range); // Simplify later processing 
  INTEGER2 company_p_city_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_p_city_name_isnull := h0.company_p_city_name  IN SET(s.nulls_company_p_city_name,company_p_city_name); // Simplify later processing 
  INTEGER2 company_v_city_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_v_city_name_isnull := h0.company_v_city_name  IN SET(s.nulls_company_v_city_name,company_v_city_name); // Simplify later processing 
  INTEGER2 company_st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_st_isnull := h0.company_st  IN SET(s.nulls_company_st,company_st); // Simplify later processing 
  INTEGER2 company_zip5_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_zip5_isnull := h0.company_zip5  IN SET(s.nulls_company_zip5,company_zip5); // Simplify later processing 
  INTEGER2 company_zip4_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_zip4_isnull := h0.company_zip4  IN SET(s.nulls_company_zip4,company_zip4); // Simplify later processing 
  INTEGER2 company_csz_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_csz_isnull := (h0.company_v_city_name  IN SET(s.nulls_company_v_city_name,company_v_city_name) AND h0.company_st  IN SET(s.nulls_company_st,company_st) AND h0.company_zip5  IN SET(s.nulls_company_zip5,company_zip5) AND h0.company_zip4  IN SET(s.nulls_company_zip4,company_zip4)); // Simplify later processing 
  INTEGER2 company_addr1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_addr1_isnull := (h0.company_prim_range  IN SET(s.nulls_company_prim_range,company_prim_range) AND h0.company_predir  IN SET(s.nulls_company_predir,company_predir) AND h0.company_prim_name  IN SET(s.nulls_company_prim_name,company_prim_name) AND h0.company_addr_suffix  IN SET(s.nulls_company_addr_suffix,company_addr_suffix) AND h0.company_postdir  IN SET(s.nulls_company_postdir,company_postdir) AND h0.company_unit_desig  IN SET(s.nulls_company_unit_desig,company_unit_desig) AND h0.company_sec_range  IN SET(s.nulls_company_sec_range,company_sec_range)); // Simplify later processing 
  INTEGER2 company_address_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_address_isnull := ((h0.company_prim_range  IN SET(s.nulls_company_prim_range,company_prim_range) AND h0.company_predir  IN SET(s.nulls_company_predir,company_predir) AND h0.company_prim_name  IN SET(s.nulls_company_prim_name,company_prim_name) AND h0.company_addr_suffix  IN SET(s.nulls_company_addr_suffix,company_addr_suffix) AND h0.company_postdir  IN SET(s.nulls_company_postdir,company_postdir) AND h0.company_unit_desig  IN SET(s.nulls_company_unit_desig,company_unit_desig) AND h0.company_sec_range  IN SET(s.nulls_company_sec_range,company_sec_range)) AND (h0.company_v_city_name  IN SET(s.nulls_company_v_city_name,company_v_city_name) AND h0.company_st  IN SET(s.nulls_company_st,company_st) AND h0.company_zip5  IN SET(s.nulls_company_zip5,company_zip5) AND h0.company_zip4  IN SET(s.nulls_company_zip4,company_zip4))); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
//Would also create auto-id fields here
layout_candidates add_company_v_city_name(layout_candidates le,Specificities(ih).company_v_city_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_v_city_name_weight100 := MAP (le.company_v_city_name_isnull => 0, patch_default and ri.field_specificity=0 => s.company_v_city_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j18 := JOIN(h1,PULL(Specificities(ih).company_v_city_name_values_persisted),LEFT.company_v_city_name=RIGHT.company_v_city_name,add_company_v_city_name(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_company_addr_suffix(layout_candidates le,Specificities(ih).company_addr_suffix_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_addr_suffix_weight100 := MAP (le.company_addr_suffix_isnull => 0, patch_default and ri.field_specificity=0 => s.company_addr_suffix_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j17 := JOIN(j18,PULL(Specificities(ih).company_addr_suffix_values_persisted),LEFT.company_addr_suffix=RIGHT.company_addr_suffix,add_company_addr_suffix(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_company_st(layout_candidates le,Specificities(ih).company_st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_st_weight100 := MAP (le.company_st_isnull => 0, patch_default and ri.field_specificity=0 => s.company_st_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j16 := JOIN(j17,PULL(Specificities(ih).company_st_values_persisted),LEFT.company_st=RIGHT.company_st,add_company_st(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_company_unit_desig(layout_candidates le,Specificities(ih).company_unit_desig_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_unit_desig_weight100 := MAP (le.company_unit_desig_isnull => 0, patch_default and ri.field_specificity=0 => s.company_unit_desig_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j15 := JOIN(j16,PULL(Specificities(ih).company_unit_desig_values_persisted),LEFT.company_unit_desig=RIGHT.company_unit_desig,add_company_unit_desig(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_company_predir(layout_candidates le,Specificities(ih).company_predir_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_predir_weight100 := MAP (le.company_predir_isnull => 0, patch_default and ri.field_specificity=0 => s.company_predir_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j14 := JOIN(j15,PULL(Specificities(ih).company_predir_values_persisted),LEFT.company_predir=RIGHT.company_predir,add_company_predir(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_company_zip5(layout_candidates le,Specificities(ih).company_zip5_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_zip5_weight100 := MAP (le.company_zip5_isnull => 0, patch_default and ri.field_specificity=0 => s.company_zip5_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j13 := JOIN(j14,PULL(Specificities(ih).company_zip5_values_persisted),LEFT.company_zip5=RIGHT.company_zip5,add_company_zip5(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_company_postdir(layout_candidates le,Specificities(ih).company_postdir_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_postdir_weight100 := MAP (le.company_postdir_isnull => 0, patch_default and ri.field_specificity=0 => s.company_postdir_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j12 := JOIN(j13,PULL(Specificities(ih).company_postdir_values_persisted),LEFT.company_postdir=RIGHT.company_postdir,add_company_postdir(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_company_p_city_name(layout_candidates le,Specificities(ih).company_p_city_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_p_city_name_weight100 := MAP (le.company_p_city_name_isnull => 0, patch_default and ri.field_specificity=0 => s.company_p_city_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT24.MAC_Choose_JoinType(j12,s.nulls_company_p_city_name,Specificities(ih).company_p_city_name_values_persisted,company_p_city_name,company_p_city_name_weight100,add_company_p_city_name,j11);
layout_candidates add_company_sec_range(layout_candidates le,Specificities(ih).company_sec_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_sec_range_weight100 := MAP (le.company_sec_range_isnull => 0, patch_default and ri.field_specificity=0 => s.company_sec_range_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT24.MAC_Choose_JoinType(j11,s.nulls_company_sec_range,Specificities(ih).company_sec_range_values_persisted,company_sec_range,company_sec_range_weight100,add_company_sec_range,j10);
layout_candidates add_company_prim_range(layout_candidates le,Specificities(ih).company_prim_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_prim_range_weight100 := MAP (le.company_prim_range_isnull => 0, patch_default and ri.field_specificity=0 => s.company_prim_range_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT24.MAC_Choose_JoinType(j10,s.nulls_company_prim_range,Specificities(ih).company_prim_range_values_persisted,company_prim_range,company_prim_range_weight100,add_company_prim_range,j9);
layout_candidates add_company_zip4(layout_candidates le,Specificities(ih).company_zip4_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_zip4_weight100 := MAP (le.company_zip4_isnull => 0, patch_default and ri.field_specificity=0 => s.company_zip4_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT24.MAC_Choose_JoinType(j9,s.nulls_company_zip4,Specificities(ih).company_zip4_values_persisted,company_zip4,company_zip4_weight100,add_company_zip4,j8);
layout_candidates add_company_prim_name(layout_candidates le,Specificities(ih).company_prim_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_prim_name_weight100 := MAP (le.company_prim_name_isnull => 0, patch_default and ri.field_specificity=0 => s.company_prim_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT24.MAC_Choose_JoinType(j8,s.nulls_company_prim_name,Specificities(ih).company_prim_name_values_persisted,company_prim_name,company_prim_name_weight100,add_company_prim_name,j7);
layout_candidates add_company_address(layout_candidates le,Specificities(ih).company_address_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_address_weight100 := MAP (le.company_address_isnull => 0, patch_default and ri.field_specificity=0 => s.company_address_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT24.MAC_Choose_JoinType(j7,s.nulls_company_address,Specificities(ih).company_address_values_persisted,company_address,company_address_weight100,add_company_address,j6);
layout_candidates add_company_addr1(layout_candidates le,Specificities(ih).company_addr1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_addr1_weight100 := MAP (le.company_addr1_isnull => 0, patch_default and ri.field_specificity=0 => s.company_addr1_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT24.MAC_Choose_JoinType(j6,s.nulls_company_addr1,Specificities(ih).company_addr1_values_persisted,company_addr1,company_addr1_weight100,add_company_addr1,j5);
layout_candidates add_company_csz(layout_candidates le,Specificities(ih).company_csz_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_csz_weight100 := MAP (le.company_csz_isnull => 0, patch_default and ri.field_specificity=0 => s.company_csz_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT24.MAC_Choose_JoinType(j5,s.nulls_company_csz,Specificities(ih).company_csz_values_persisted,company_csz,company_csz_weight100,add_company_csz,j4);
layout_candidates add_company_phone(layout_candidates le,Specificities(ih).company_phone_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_phone_cnt := ri.cnt;
  SELF.company_phone_e1_cnt := ri.e1_cnt;
  SELF.company_phone_weight100 := MAP (le.company_phone_isnull => 0, patch_default and ri.field_specificity=0 => s.company_phone_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT24.MAC_Choose_JoinType(j4,s.nulls_company_phone,Specificities(ih).company_phone_values_persisted,company_phone,company_phone_weight100,add_company_phone,j3);
layout_candidates add_company_name(layout_candidates le,Specificities(ih).company_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_name_cnt := ri.cnt;
  SELF.company_name_p_cnt := ri.p_cnt;
  SELF.company_name_e1_cnt := ri.e1_cnt;
  SELF.company_name_e1p_cnt := ri.e1p_cnt;
  SELF.company_name_weight100 := MAP (le.company_name_isnull => 0, patch_default and ri.field_specificity=0 => s.company_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT24.MAC_Choose_JoinType(j3,s.nulls_company_name,Specificities(ih).company_name_values_persisted,company_name,company_name_weight100,add_company_name,j2);
layout_candidates add_company_url(layout_candidates le,Specificities(ih).company_url_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_url_cnt := ri.cnt;
  SELF.company_url_e1_cnt := ri.e1_cnt;
  SELF.company_url_weight100 := MAP (le.company_url_isnull => 0, patch_default and ri.field_specificity=0 => s.company_url_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT24.MAC_Choose_JoinType(j2,s.nulls_company_url,Specificities(ih).company_url_values_persisted,company_url,company_url_weight100,add_company_url,j1);
layout_candidates add_company_fein(layout_candidates le,Specificities(ih).company_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_fein_cnt := ri.cnt;
  SELF.company_fein_e1_cnt := ri.e1_cnt;
  self.company_fein_Right4_cnt := ri.Right4_cnt; // Copy in count of matching Right4 values for field company_fein
  self.company_fein_Right4 := ri.company_fein_Right4; // Copy Right4 value for field company_fein
  SELF.company_fein_weight100 := MAP (le.company_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.company_fein_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT24.MAC_Choose_JoinType(j1,s.nulls_company_fein,Specificities(ih).company_fein_values_persisted,company_fein,company_fein_weight100,add_company_fein,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(Proxid)) : PERSIST('temp::BIPV2_Best_Base_mc'); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.company_fein_weight100 + Annotated.company_url_weight100 + Annotated.company_name_weight100 + Annotated.company_phone_weight100 + Annotated.company_address_weight100 + Annotated.company_p_city_name_weight100;
SHARED Linkable := TotalWeight >= 32;
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
