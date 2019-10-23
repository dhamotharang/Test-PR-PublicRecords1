// Begin code to produce match candidates
IMPORT SALT30,ut;
EXPORT match_candidates(DATASET(layout_Base) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := BasicMatch(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00,{rcid,dt_first_seen,dt_last_seen,source_for_votes,company_name,company_fein,company_phone,company_url,duns_number,company_sic_code1,company_naics_code1,dba_name,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,fips_state,fips_county,address,Proxid}),HASH(Proxid));
 
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 company_name_pop := AVE(GROUP,IF(thin_table.company_name IN SET(s.nulls_company_name,company_name),0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF(thin_table.company_fein IN SET(s.nulls_company_fein,company_fein),0,100));
  REAL8 company_phone_pop := AVE(GROUP,IF(thin_table.company_phone IN SET(s.nulls_company_phone,company_phone),0,100));
  REAL8 company_url_pop := AVE(GROUP,IF(thin_table.company_url IN SET(s.nulls_company_url,company_url),0,100));
  REAL8 duns_number_pop := AVE(GROUP,IF(thin_table.duns_number IN SET(s.nulls_duns_number,duns_number),0,100));
  REAL8 company_sic_code1_pop := AVE(GROUP,IF(thin_table.company_sic_code1 IN SET(s.nulls_company_sic_code1,company_sic_code1),0,100));
  REAL8 company_naics_code1_pop := AVE(GROUP,IF(thin_table.company_naics_code1 IN SET(s.nulls_company_naics_code1,company_naics_code1),0,100));
  REAL8 dba_name_pop := AVE(GROUP,IF(thin_table.dba_name IN SET(s.nulls_dba_name,dba_name),0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF(thin_table.prim_range IN SET(s.nulls_prim_range,prim_range),0,100));
  REAL8 predir_pop := AVE(GROUP,IF(thin_table.predir IN SET(s.nulls_predir,predir),0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF(thin_table.prim_name IN SET(s.nulls_prim_name,prim_name),0,100));
  REAL8 addr_suffix_pop := AVE(GROUP,IF(thin_table.addr_suffix IN SET(s.nulls_addr_suffix,addr_suffix),0,100));
  REAL8 postdir_pop := AVE(GROUP,IF(thin_table.postdir IN SET(s.nulls_postdir,postdir),0,100));
  REAL8 unit_desig_pop := AVE(GROUP,IF(thin_table.unit_desig IN SET(s.nulls_unit_desig,unit_desig),0,100));
  REAL8 sec_range_pop := AVE(GROUP,IF(thin_table.sec_range IN SET(s.nulls_sec_range,sec_range),0,100));
  REAL8 p_city_name_pop := AVE(GROUP,IF(thin_table.p_city_name IN SET(s.nulls_p_city_name,p_city_name),0,100));
  REAL8 v_city_name_pop := AVE(GROUP,IF(thin_table.v_city_name IN SET(s.nulls_v_city_name,v_city_name),0,100));
  REAL8 st_pop := AVE(GROUP,IF(thin_table.st IN SET(s.nulls_st,st),0,100));
  REAL8 zip_pop := AVE(GROUP,IF(thin_table.zip IN SET(s.nulls_zip,zip),0,100));
  REAL8 zip4_pop := AVE(GROUP,IF(thin_table.zip4 IN SET(s.nulls_zip4,zip4),0,100));
  REAL8 fips_state_pop := AVE(GROUP,IF(thin_table.fips_state IN SET(s.nulls_fips_state,fips_state),0,100));
  REAL8 fips_county_pop := AVE(GROUP,IF(thin_table.fips_county IN SET(s.nulls_fips_county,fips_county),0,100));
  REAL8 address_pop := AVE(GROUP,IF(thin_table.address IN SET(s.nulls_address,address),0,100));
END;
EXPORT PrePropogationStats := TABLE(thin_table,PrePropCounts);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 company_name_prop := 0;
  INTEGER1 company_name_prop_method := 0;
  UNSIGNED1 company_fein_prop := 0;
  INTEGER1 company_fein_prop_method := 0;
  UNSIGNED1 company_phone_prop := 0;
  INTEGER1 company_phone_prop_method := 0;
  UNSIGNED1 company_url_prop := 0;
  INTEGER1 company_url_prop_method := 0;
  UNSIGNED1 duns_number_prop := 0;
  INTEGER1 duns_number_prop_method := 0;
  UNSIGNED1 company_sic_code1_prop := 0;
  INTEGER1 company_sic_code1_prop_method := 0;
  UNSIGNED1 company_naics_code1_prop := 0;
  INTEGER1 company_naics_code1_prop_method := 0;
  UNSIGNED1 dba_name_prop := 0;
  INTEGER1 dba_name_prop_method := 0;
  UNSIGNED1 prim_range_prop := 0;
  UNSIGNED1 predir_prop := 0;
  UNSIGNED1 prim_name_prop := 0;
  UNSIGNED1 addr_suffix_prop := 0;
  UNSIGNED1 postdir_prop := 0;
  UNSIGNED1 unit_desig_prop := 0;
  UNSIGNED1 sec_range_prop := 0;
  UNSIGNED1 st_prop := 0;
  UNSIGNED1 zip_prop := 0;
  UNSIGNED1 address_prop := 0;
  INTEGER1 address_prop_method := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
// Now generate code for basis :Proxid,source_for_votes,data_permits
// There are 49 best types that we can propogate from this basis which means we will not need to use this basis again
  Layout_WithPropVars T_BestCompanyNameLegal_49_0(Layout_WithPropVars le,Best(ih).BestBy_Proxid_best ri) := TRANSFORM
    SELF.company_name_prop_method := MAP ( ri.company_name_method = 0 OR le.company_name_prop_method <> 0 OR le.company_name = ri.company_name => le.company_name_prop_method, // No propogation
      ri.company_name_method = 1 AND (SALT30.StrType)ri.company_name[1..length(trim((SALT30.StrType)le.company_name))] = (SALT30.StrType)le.company_name  => 1, // This field is extensible
      ri.company_name_method = 2 AND (SALT30.StrType)ri.company_name[1..length(trim((SALT30.StrType)le.company_name))] = (SALT30.StrType)le.company_name  => 2, // This field is extensible
      ri.company_name_method = 3 AND (SALT30.StrType)ri.company_name[1..length(trim((SALT30.StrType)le.company_name))] = (SALT30.StrType)le.company_name  => 3, // This field is extensible
      ri.company_name_method = 4 AND (SALT30.StrType)ri.company_name[1..length(trim((SALT30.StrType)le.company_name))] = (SALT30.StrType)le.company_name  => 4, // This field is extensible
      ri.company_name_method = 5 AND (SALT30.StrType)ri.company_name[1..length(trim((SALT30.StrType)le.company_name))] = (SALT30.StrType)le.company_name  => 5, // This field is extensible
      ri.company_name_method = 6 AND (SALT30.StrType)ri.company_name[1..length(trim((SALT30.StrType)le.company_name))] = (SALT30.StrType)le.company_name  => 6, // This field is extensible
      ri.company_name_method = 7 AND (SALT30.StrType)ri.company_name[1..length(trim((SALT30.StrType)le.company_name))] = (SALT30.StrType)le.company_name  => 7, // This field is extensible
      ri.company_name_method = 8 AND (SALT30.StrType)ri.company_name[1..length(trim((SALT30.StrType)le.company_name))] = (SALT30.StrType)le.company_name  => 8, // This field is extensible
      le.company_name_prop_method);
    SELF.company_name := MAP ( le.company_name_prop > 0 OR le.company_name = ri.company_name OR ri.company_name  IN SET(s.nulls_company_name,company_name) => le.company_name, // No propogation
      ri.company_name_method = 1 AND (SALT30.StrType)ri.company_name[1..length(trim((SALT30.StrType)le.company_name))] = (SALT30.StrType)le.company_name  => ri.company_name, // This field is extensible
      ri.company_name_method = 2 AND (SALT30.StrType)ri.company_name[1..length(trim((SALT30.StrType)le.company_name))] = (SALT30.StrType)le.company_name  => ri.company_name, // This field is extensible
      ri.company_name_method = 3 AND (SALT30.StrType)ri.company_name[1..length(trim((SALT30.StrType)le.company_name))] = (SALT30.StrType)le.company_name  => ri.company_name, // This field is extensible
      ri.company_name_method = 4 AND (SALT30.StrType)ri.company_name[1..length(trim((SALT30.StrType)le.company_name))] = (SALT30.StrType)le.company_name  => ri.company_name, // This field is extensible
      ri.company_name_method = 5 AND (SALT30.StrType)ri.company_name[1..length(trim((SALT30.StrType)le.company_name))] = (SALT30.StrType)le.company_name  => ri.company_name, // This field is extensible
      ri.company_name_method = 6 AND (SALT30.StrType)ri.company_name[1..length(trim((SALT30.StrType)le.company_name))] = (SALT30.StrType)le.company_name  => ri.company_name, // This field is extensible
      ri.company_name_method = 7 AND (SALT30.StrType)ri.company_name[1..length(trim((SALT30.StrType)le.company_name))] = (SALT30.StrType)le.company_name  => ri.company_name, // This field is extensible
      ri.company_name_method = 8 AND (SALT30.StrType)ri.company_name[1..length(trim((SALT30.StrType)le.company_name))] = (SALT30.StrType)le.company_name  => ri.company_name, // This field is extensible
      le.company_name);
    SELF.company_name_prop := IF ( le.company_name = SELF.company_name, le.company_name_prop,1); // Flag the propagation for sliceouts
    SELF.company_fein_prop_method := MAP ( ri.company_fein_method = 0 OR le.company_fein_prop_method <> 0 OR le.company_fein = ri.company_fein => le.company_fein_prop_method, // No propogation
      ri.company_fein_method = 1 AND (SALT30.StrType)ri.company_fein[1..length(trim((SALT30.StrType)le.company_fein))] = (SALT30.StrType)le.company_fein  => 1, // This field is extensible
      ri.company_fein_method = 2 AND (SALT30.StrType)ri.company_fein[1..length(trim((SALT30.StrType)le.company_fein))] = (SALT30.StrType)le.company_fein  => 2, // This field is extensible
      ri.company_fein_method = 3 AND (SALT30.StrType)ri.company_fein[1..length(trim((SALT30.StrType)le.company_fein))] = (SALT30.StrType)le.company_fein  => 3, // This field is extensible
      ri.company_fein_method = 4 AND (SALT30.StrType)ri.company_fein[1..length(trim((SALT30.StrType)le.company_fein))] = (SALT30.StrType)le.company_fein  => 4, // This field is extensible
      ri.company_fein_method = 5 AND (SALT30.StrType)ri.company_fein[1..length(trim((SALT30.StrType)le.company_fein))] = (SALT30.StrType)le.company_fein  => 5, // This field is extensible
      ri.company_fein_method = 6 AND (SALT30.StrType)ri.company_fein[1..length(trim((SALT30.StrType)le.company_fein))] = (SALT30.StrType)le.company_fein  => 6, // This field is extensible
      le.company_fein_prop_method);
    SELF.company_fein := MAP ( le.company_fein_prop > 0 OR le.company_fein = ri.company_fein OR ri.company_fein  IN SET(s.nulls_company_fein,company_fein) => le.company_fein, // No propogation
      ri.company_fein_method = 1 AND (SALT30.StrType)ri.company_fein[1..length(trim((SALT30.StrType)le.company_fein))] = (SALT30.StrType)le.company_fein  => ri.company_fein, // This field is extensible
      ri.company_fein_method = 2 AND (SALT30.StrType)ri.company_fein[1..length(trim((SALT30.StrType)le.company_fein))] = (SALT30.StrType)le.company_fein  => ri.company_fein, // This field is extensible
      ri.company_fein_method = 3 AND (SALT30.StrType)ri.company_fein[1..length(trim((SALT30.StrType)le.company_fein))] = (SALT30.StrType)le.company_fein  => ri.company_fein, // This field is extensible
      ri.company_fein_method = 4 AND (SALT30.StrType)ri.company_fein[1..length(trim((SALT30.StrType)le.company_fein))] = (SALT30.StrType)le.company_fein  => ri.company_fein, // This field is extensible
      ri.company_fein_method = 5 AND (SALT30.StrType)ri.company_fein[1..length(trim((SALT30.StrType)le.company_fein))] = (SALT30.StrType)le.company_fein  => ri.company_fein, // This field is extensible
      ri.company_fein_method = 6 AND (SALT30.StrType)ri.company_fein[1..length(trim((SALT30.StrType)le.company_fein))] = (SALT30.StrType)le.company_fein  => ri.company_fein, // This field is extensible
      le.company_fein);
    SELF.company_fein_prop := IF ( le.company_fein = SELF.company_fein, le.company_fein_prop,1); // Flag the propagation for sliceouts
    SELF.company_phone_prop_method := MAP ( ri.company_phone_method = 0 OR le.company_phone_prop_method <> 0 OR le.company_phone = ri.company_phone => le.company_phone_prop_method, // No propogation
      ri.company_phone_method = 1 AND (SALT30.StrType)ri.company_phone[1..length(trim((SALT30.StrType)le.company_phone))] = (SALT30.StrType)le.company_phone  => 1, // This field is extensible
      ri.company_phone_method = 2 AND (SALT30.StrType)ri.company_phone[1..length(trim((SALT30.StrType)le.company_phone))] = (SALT30.StrType)le.company_phone  => 2, // This field is extensible
      ri.company_phone_method = 3 AND (SALT30.StrType)ri.company_phone[1..length(trim((SALT30.StrType)le.company_phone))] = (SALT30.StrType)le.company_phone  => 3, // This field is extensible
      ri.company_phone_method = 4 AND (SALT30.StrType)ri.company_phone[1..length(trim((SALT30.StrType)le.company_phone))] = (SALT30.StrType)le.company_phone  => 4, // This field is extensible
      ri.company_phone_method = 5 AND (SALT30.StrType)ri.company_phone[1..length(trim((SALT30.StrType)le.company_phone))] = (SALT30.StrType)le.company_phone  => 5, // This field is extensible
      ri.company_phone_method = 6 AND (SALT30.StrType)ri.company_phone[1..length(trim((SALT30.StrType)le.company_phone))] = (SALT30.StrType)le.company_phone  => 6, // This field is extensible
      ri.company_phone_method = 7 AND (SALT30.StrType)ri.company_phone[1..length(trim((SALT30.StrType)le.company_phone))] = (SALT30.StrType)le.company_phone  => 7, // This field is extensible
      le.company_phone_prop_method);
    SELF.company_phone := MAP ( le.company_phone_prop > 0 OR le.company_phone = ri.company_phone OR ri.company_phone  IN SET(s.nulls_company_phone,company_phone) => le.company_phone, // No propogation
      ri.company_phone_method = 1 AND (SALT30.StrType)ri.company_phone[1..length(trim((SALT30.StrType)le.company_phone))] = (SALT30.StrType)le.company_phone  => ri.company_phone, // This field is extensible
      ri.company_phone_method = 2 AND (SALT30.StrType)ri.company_phone[1..length(trim((SALT30.StrType)le.company_phone))] = (SALT30.StrType)le.company_phone  => ri.company_phone, // This field is extensible
      ri.company_phone_method = 3 AND (SALT30.StrType)ri.company_phone[1..length(trim((SALT30.StrType)le.company_phone))] = (SALT30.StrType)le.company_phone  => ri.company_phone, // This field is extensible
      ri.company_phone_method = 4 AND (SALT30.StrType)ri.company_phone[1..length(trim((SALT30.StrType)le.company_phone))] = (SALT30.StrType)le.company_phone  => ri.company_phone, // This field is extensible
      ri.company_phone_method = 5 AND (SALT30.StrType)ri.company_phone[1..length(trim((SALT30.StrType)le.company_phone))] = (SALT30.StrType)le.company_phone  => ri.company_phone, // This field is extensible
      ri.company_phone_method = 6 AND (SALT30.StrType)ri.company_phone[1..length(trim((SALT30.StrType)le.company_phone))] = (SALT30.StrType)le.company_phone  => ri.company_phone, // This field is extensible
      ri.company_phone_method = 7 AND (SALT30.StrType)ri.company_phone[1..length(trim((SALT30.StrType)le.company_phone))] = (SALT30.StrType)le.company_phone  => ri.company_phone, // This field is extensible
      le.company_phone);
    SELF.company_phone_prop := IF ( le.company_phone = SELF.company_phone, le.company_phone_prop,1); // Flag the propagation for sliceouts
    SELF.company_url_prop_method := MAP ( ri.company_url_method = 0 OR le.company_url_prop_method <> 0 OR le.company_url = ri.company_url => le.company_url_prop_method, // No propogation
      ri.company_url_method = 1 AND (SALT30.StrType)ri.company_url[1..length(trim((SALT30.StrType)le.company_url))] = (SALT30.StrType)le.company_url  => 1, // This field is extensible
      ri.company_url_method = 2 AND (SALT30.StrType)ri.company_url[1..length(trim((SALT30.StrType)le.company_url))] = (SALT30.StrType)le.company_url  => 2, // This field is extensible
      ri.company_url_method = 3 AND (SALT30.StrType)ri.company_url[1..length(trim((SALT30.StrType)le.company_url))] = (SALT30.StrType)le.company_url  => 3, // This field is extensible
      ri.company_url_method = 4 AND (SALT30.StrType)ri.company_url[1..length(trim((SALT30.StrType)le.company_url))] = (SALT30.StrType)le.company_url  => 4, // This field is extensible
      ri.company_url_method = 5 AND (SALT30.StrType)ri.company_url[1..length(trim((SALT30.StrType)le.company_url))] = (SALT30.StrType)le.company_url  => 5, // This field is extensible
      le.company_url_prop_method);
    SELF.company_url := MAP ( le.company_url_prop > 0 OR le.company_url = ri.company_url OR ri.company_url  IN SET(s.nulls_company_url,company_url) => le.company_url, // No propogation
      ri.company_url_method = 1 AND (SALT30.StrType)ri.company_url[1..length(trim((SALT30.StrType)le.company_url))] = (SALT30.StrType)le.company_url  => ri.company_url, // This field is extensible
      ri.company_url_method = 2 AND (SALT30.StrType)ri.company_url[1..length(trim((SALT30.StrType)le.company_url))] = (SALT30.StrType)le.company_url  => ri.company_url, // This field is extensible
      ri.company_url_method = 3 AND (SALT30.StrType)ri.company_url[1..length(trim((SALT30.StrType)le.company_url))] = (SALT30.StrType)le.company_url  => ri.company_url, // This field is extensible
      ri.company_url_method = 4 AND (SALT30.StrType)ri.company_url[1..length(trim((SALT30.StrType)le.company_url))] = (SALT30.StrType)le.company_url  => ri.company_url, // This field is extensible
      ri.company_url_method = 5 AND (SALT30.StrType)ri.company_url[1..length(trim((SALT30.StrType)le.company_url))] = (SALT30.StrType)le.company_url  => ri.company_url, // This field is extensible
      le.company_url);
    SELF.company_url_prop := IF ( le.company_url = SELF.company_url, le.company_url_prop,1); // Flag the propagation for sliceouts
    SELF.duns_number_prop_method := MAP ( ri.duns_number_method = 0 OR le.duns_number_prop_method <> 0 OR le.duns_number = ri.duns_number => le.duns_number_prop_method, // No propogation
      ri.duns_number_method = 1 AND (SALT30.StrType)ri.duns_number[1..length(trim((SALT30.StrType)le.duns_number))] = (SALT30.StrType)le.duns_number  => 1, // This field is extensible
      ri.duns_number_method = 2 AND (SALT30.StrType)ri.duns_number[1..length(trim((SALT30.StrType)le.duns_number))] = (SALT30.StrType)le.duns_number  => 2, // This field is extensible
      ri.duns_number_method = 3 AND (SALT30.StrType)ri.duns_number[1..length(trim((SALT30.StrType)le.duns_number))] = (SALT30.StrType)le.duns_number  => 3, // This field is extensible
      ri.duns_number_method = 4 AND (SALT30.StrType)ri.duns_number[1..length(trim((SALT30.StrType)le.duns_number))] = (SALT30.StrType)le.duns_number  => 4, // This field is extensible
      le.duns_number_prop_method);
    SELF.duns_number := MAP ( le.duns_number_prop > 0 OR le.duns_number = ri.duns_number OR ri.duns_number  IN SET(s.nulls_duns_number,duns_number) => le.duns_number, // No propogation
      ri.duns_number_method = 1 AND (SALT30.StrType)ri.duns_number[1..length(trim((SALT30.StrType)le.duns_number))] = (SALT30.StrType)le.duns_number  => ri.duns_number, // This field is extensible
      ri.duns_number_method = 2 AND (SALT30.StrType)ri.duns_number[1..length(trim((SALT30.StrType)le.duns_number))] = (SALT30.StrType)le.duns_number  => ri.duns_number, // This field is extensible
      ri.duns_number_method = 3 AND (SALT30.StrType)ri.duns_number[1..length(trim((SALT30.StrType)le.duns_number))] = (SALT30.StrType)le.duns_number  => ri.duns_number, // This field is extensible
      ri.duns_number_method = 4 AND (SALT30.StrType)ri.duns_number[1..length(trim((SALT30.StrType)le.duns_number))] = (SALT30.StrType)le.duns_number  => ri.duns_number, // This field is extensible
      le.duns_number);
    SELF.duns_number_prop := IF ( le.duns_number = SELF.duns_number, le.duns_number_prop,1); // Flag the propagation for sliceouts
    SELF.company_sic_code1_prop_method := MAP ( ri.company_sic_code1_method = 0 OR le.company_sic_code1_prop_method <> 0 OR le.company_sic_code1 = ri.company_sic_code1 => le.company_sic_code1_prop_method, // No propogation
      ri.company_sic_code1_method = 1 AND (SALT30.StrType)ri.company_sic_code1[1..length(trim((SALT30.StrType)le.company_sic_code1))] = (SALT30.StrType)le.company_sic_code1  => 1, // This field is extensible
      ri.company_sic_code1_method = 2 AND (SALT30.StrType)ri.company_sic_code1[1..length(trim((SALT30.StrType)le.company_sic_code1))] = (SALT30.StrType)le.company_sic_code1  => 2, // This field is extensible
      le.company_sic_code1_prop_method);
    SELF.company_sic_code1 := MAP ( le.company_sic_code1_prop > 0 OR le.company_sic_code1 = ri.company_sic_code1 OR ri.company_sic_code1  IN SET(s.nulls_company_sic_code1,company_sic_code1) => le.company_sic_code1, // No propogation
      ri.company_sic_code1_method = 1 AND (SALT30.StrType)ri.company_sic_code1[1..length(trim((SALT30.StrType)le.company_sic_code1))] = (SALT30.StrType)le.company_sic_code1  => ri.company_sic_code1, // This field is extensible
      ri.company_sic_code1_method = 2 AND (SALT30.StrType)ri.company_sic_code1[1..length(trim((SALT30.StrType)le.company_sic_code1))] = (SALT30.StrType)le.company_sic_code1  => ri.company_sic_code1, // This field is extensible
      le.company_sic_code1);
    SELF.company_sic_code1_prop := IF ( le.company_sic_code1 = SELF.company_sic_code1, le.company_sic_code1_prop,1); // Flag the propagation for sliceouts
    SELF.company_naics_code1_prop_method := MAP ( ri.company_naics_code1_method = 0 OR le.company_naics_code1_prop_method <> 0 OR le.company_naics_code1 = ri.company_naics_code1 => le.company_naics_code1_prop_method, // No propogation
      ri.company_naics_code1_method = 1 AND (SALT30.StrType)ri.company_naics_code1[1..length(trim((SALT30.StrType)le.company_naics_code1))] = (SALT30.StrType)le.company_naics_code1  => 1, // This field is extensible
      ri.company_naics_code1_method = 2 AND (SALT30.StrType)ri.company_naics_code1[1..length(trim((SALT30.StrType)le.company_naics_code1))] = (SALT30.StrType)le.company_naics_code1  => 2, // This field is extensible
      le.company_naics_code1_prop_method);
    SELF.company_naics_code1 := MAP ( le.company_naics_code1_prop > 0 OR le.company_naics_code1 = ri.company_naics_code1 OR ri.company_naics_code1  IN SET(s.nulls_company_naics_code1,company_naics_code1) => le.company_naics_code1, // No propogation
      ri.company_naics_code1_method = 1 AND (SALT30.StrType)ri.company_naics_code1[1..length(trim((SALT30.StrType)le.company_naics_code1))] = (SALT30.StrType)le.company_naics_code1  => ri.company_naics_code1, // This field is extensible
      ri.company_naics_code1_method = 2 AND (SALT30.StrType)ri.company_naics_code1[1..length(trim((SALT30.StrType)le.company_naics_code1))] = (SALT30.StrType)le.company_naics_code1  => ri.company_naics_code1, // This field is extensible
      le.company_naics_code1);
    SELF.company_naics_code1_prop := IF ( le.company_naics_code1 = SELF.company_naics_code1, le.company_naics_code1_prop,1); // Flag the propagation for sliceouts
    SELF.dba_name_prop_method := MAP ( ri.dba_name_method = 0 OR le.dba_name_prop_method <> 0 OR le.dba_name = ri.dba_name => le.dba_name_prop_method, // No propogation
      ri.dba_name_method = 1 AND (SALT30.StrType)ri.dba_name[1..length(trim((SALT30.StrType)le.dba_name))] = (SALT30.StrType)le.dba_name  => 1, // This field is extensible
      ri.dba_name_method = 2 AND (SALT30.StrType)ri.dba_name[1..length(trim((SALT30.StrType)le.dba_name))] = (SALT30.StrType)le.dba_name  => 2, // This field is extensible
      ri.dba_name_method = 3 AND (SALT30.StrType)ri.dba_name[1..length(trim((SALT30.StrType)le.dba_name))] = (SALT30.StrType)le.dba_name  => 3, // This field is extensible
      ri.dba_name_method = 4 AND (SALT30.StrType)ri.dba_name[1..length(trim((SALT30.StrType)le.dba_name))] = (SALT30.StrType)le.dba_name  => 4, // This field is extensible
      ri.dba_name_method = 5 AND (SALT30.StrType)ri.dba_name[1..length(trim((SALT30.StrType)le.dba_name))] = (SALT30.StrType)le.dba_name  => 5, // This field is extensible
      ri.dba_name_method = 6 AND (SALT30.StrType)ri.dba_name[1..length(trim((SALT30.StrType)le.dba_name))] = (SALT30.StrType)le.dba_name  => 6, // This field is extensible
      ri.dba_name_method = 7 AND (SALT30.StrType)ri.dba_name[1..length(trim((SALT30.StrType)le.dba_name))] = (SALT30.StrType)le.dba_name  => 7, // This field is extensible
      ri.dba_name_method = 8 AND (SALT30.StrType)ri.dba_name[1..length(trim((SALT30.StrType)le.dba_name))] = (SALT30.StrType)le.dba_name  => 8, // This field is extensible
      le.dba_name_prop_method);
    SELF.dba_name := MAP ( le.dba_name_prop > 0 OR le.dba_name = ri.dba_name OR ri.dba_name  IN SET(s.nulls_dba_name,dba_name) => le.dba_name, // No propogation
      ri.dba_name_method = 1 AND (SALT30.StrType)ri.dba_name[1..length(trim((SALT30.StrType)le.dba_name))] = (SALT30.StrType)le.dba_name  => ri.dba_name, // This field is extensible
      ri.dba_name_method = 2 AND (SALT30.StrType)ri.dba_name[1..length(trim((SALT30.StrType)le.dba_name))] = (SALT30.StrType)le.dba_name  => ri.dba_name, // This field is extensible
      ri.dba_name_method = 3 AND (SALT30.StrType)ri.dba_name[1..length(trim((SALT30.StrType)le.dba_name))] = (SALT30.StrType)le.dba_name  => ri.dba_name, // This field is extensible
      ri.dba_name_method = 4 AND (SALT30.StrType)ri.dba_name[1..length(trim((SALT30.StrType)le.dba_name))] = (SALT30.StrType)le.dba_name  => ri.dba_name, // This field is extensible
      ri.dba_name_method = 5 AND (SALT30.StrType)ri.dba_name[1..length(trim((SALT30.StrType)le.dba_name))] = (SALT30.StrType)le.dba_name  => ri.dba_name, // This field is extensible
      ri.dba_name_method = 6 AND (SALT30.StrType)ri.dba_name[1..length(trim((SALT30.StrType)le.dba_name))] = (SALT30.StrType)le.dba_name  => ri.dba_name, // This field is extensible
      ri.dba_name_method = 7 AND (SALT30.StrType)ri.dba_name[1..length(trim((SALT30.StrType)le.dba_name))] = (SALT30.StrType)le.dba_name  => ri.dba_name, // This field is extensible
      ri.dba_name_method = 8 AND (SALT30.StrType)ri.dba_name[1..length(trim((SALT30.StrType)le.dba_name))] = (SALT30.StrType)le.dba_name  => ri.dba_name, // This field is extensible
      le.dba_name);
    SELF.dba_name_prop := IF ( le.dba_name = SELF.dba_name, le.dba_name_prop,1); // Flag the propagation for sliceouts
    SELF := le;
  END;
SHARED P_BestCompanyNameLegal_49_0 := JOIN(with_props(Proxid <> 0),Best(ih).BestBy_Proxid_best, LEFT.Proxid = RIGHT.Proxid ,T_BestCompanyNameLegal_49_0(LEFT,RIGHT),LEFT OUTER,HASH)
                 + with_props(Proxid = 0);
// Now perform a propogation on the concept address using BestType BestCompanyAddressVoted
//First find the propogation candidates; and translate into normal field names 
  PC := TABLE(Best(ih).BestBy_Proxid_best(Proxid <> 0,address_method = 1),{Proxid,TYPEOF(address_prim_range) prim_range := address_prim_range,TYPEOF(address_predir) predir := address_predir,TYPEOF(address_prim_name) prim_name := address_prim_name,TYPEOF(address_addr_suffix) addr_suffix := address_addr_suffix,TYPEOF(address_postdir) postdir := address_postdir,TYPEOF(address_unit_desig) unit_desig := address_unit_desig,TYPEOF(address_sec_range) sec_range := address_sec_range,TYPEOF(address_st) st := address_st,TYPEOF(address_zip) zip := address_zip})(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)));
  layout_withpropvars T_address_BestCompanyAddressVoted(layout_withpropvars le,PC ri) := TRANSFORM
  // By the time we are in here - if 'ri' has a value then any fields that need to match do
    BOOLEAN null_rhs := (ri.prim_range  IN SET(s.nulls_prim_range,prim_range) AND ri.predir  IN SET(s.nulls_predir,predir) AND ri.prim_name  IN SET(s.nulls_prim_name,prim_name) AND ri.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND ri.postdir  IN SET(s.nulls_postdir,postdir) AND ri.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND ri.sec_range  IN SET(s.nulls_sec_range,sec_range) AND ri.st  IN SET(s.nulls_st,st) AND ri.zip  IN SET(s.nulls_zip,zip)) OR le.address_prop > 0;
    SELF.prim_range := IF ( null_rhs OR le.prim_range_prop > 0, le.prim_range, ri.prim_range );
    SELF.prim_range_prop := IF ( le.prim_range = SELF.prim_range, le.prim_range_prop,1); // Flag the propagation for sliceouts
    SELF.predir := IF ( null_rhs OR le.predir_prop > 0, le.predir, ri.predir );
    SELF.predir_prop := IF ( le.predir = SELF.predir, le.predir_prop,1); // Flag the propagation for sliceouts
    SELF.prim_name := IF ( null_rhs OR le.prim_name_prop > 0, le.prim_name, ri.prim_name );
    SELF.prim_name_prop := IF ( le.prim_name = SELF.prim_name, le.prim_name_prop,1); // Flag the propagation for sliceouts
    SELF.addr_suffix := IF ( null_rhs OR le.addr_suffix_prop > 0, le.addr_suffix, ri.addr_suffix );
    SELF.addr_suffix_prop := IF ( le.addr_suffix = SELF.addr_suffix, le.addr_suffix_prop,1); // Flag the propagation for sliceouts
    SELF.postdir := IF ( null_rhs OR le.postdir_prop > 0, le.postdir, ri.postdir );
    SELF.postdir_prop := IF ( le.postdir = SELF.postdir, le.postdir_prop,1); // Flag the propagation for sliceouts
    SELF.unit_desig := IF ( null_rhs OR le.unit_desig_prop > 0, le.unit_desig, ri.unit_desig );
    SELF.unit_desig_prop := IF ( le.unit_desig = SELF.unit_desig, le.unit_desig_prop,1); // Flag the propagation for sliceouts
    SELF.sec_range := IF ( null_rhs OR le.sec_range_prop > 0, le.sec_range, ri.sec_range );
    SELF.sec_range_prop := IF ( le.sec_range = SELF.sec_range, le.sec_range_prop,1); // Flag the propagation for sliceouts
    SELF.st := IF ( null_rhs OR le.st_prop > 0, le.st, ri.st );
    SELF.st_prop := IF ( le.st = SELF.st, le.st_prop,1); // Flag the propagation for sliceouts
    SELF.zip := IF ( null_rhs OR le.zip_prop > 0, le.zip, ri.zip );
    SELF.zip_prop := IF ( le.zip = SELF.zip, le.zip_prop,1); // Flag the propagation for sliceouts
    SELF.address_prop := IF( le.prim_range_prop = SELF.prim_range_prop, 0, 1 ) + IF( le.predir_prop = SELF.predir_prop, 0, 2 ) + IF( le.prim_name_prop = SELF.prim_name_prop, 0, 4 ) + IF( le.addr_suffix_prop = SELF.addr_suffix_prop, 0, 8 ) + IF( le.postdir_prop = SELF.postdir_prop, 0, 16 ) + IF( le.unit_desig_prop = SELF.unit_desig_prop, 0, 32 ) + IF( le.sec_range_prop = SELF.sec_range_prop, 0, 64 ) + IF( le.st_prop = SELF.st_prop, 0, 128 ) + IF( le.zip_prop = SELF.zip_prop, 0, 256 ); // One bit for each propogated field
    SELF.address_prop_method := IF( null_rhs OR SELF.address_prop = 0, le.address_prop_method, 1 );
    SELF := le;
  END;
SHARED J_address_BestCompanyAddressVoted := JOIN(P_BestCompanyNameLegal_49_0,PC, LEFT.Proxid = RIGHT.Proxid  AND ((SALT30.StrType)RIGHT.prim_range[1..length(trim((SALT30.StrType)LEFT.prim_range))] = (SALT30.StrType)LEFT.prim_range ) AND ((SALT30.StrType)RIGHT.predir[1..length(trim((SALT30.StrType)LEFT.predir))] = (SALT30.StrType)LEFT.predir ) AND ((SALT30.StrType)RIGHT.prim_name[1..length(trim((SALT30.StrType)LEFT.prim_name))] = (SALT30.StrType)LEFT.prim_name ) AND ((SALT30.StrType)RIGHT.addr_suffix[1..length(trim((SALT30.StrType)LEFT.addr_suffix))] = (SALT30.StrType)LEFT.addr_suffix ) AND ((SALT30.StrType)RIGHT.postdir[1..length(trim((SALT30.StrType)LEFT.postdir))] = (SALT30.StrType)LEFT.postdir ) AND ((SALT30.StrType)RIGHT.unit_desig[1..length(trim((SALT30.StrType)LEFT.unit_desig))] = (SALT30.StrType)LEFT.unit_desig ) AND ((SALT30.StrType)RIGHT.sec_range[1..length(trim((SALT30.StrType)LEFT.sec_range))] = (SALT30.StrType)LEFT.sec_range ) AND ((SALT30.StrType)RIGHT.st[1..length(trim((SALT30.StrType)LEFT.st))] = (SALT30.StrType)LEFT.st ) AND ((SALT30.StrType)RIGHT.zip[1..length(trim((SALT30.StrType)LEFT.zip))] = (SALT30.StrType)LEFT.zip ),T_address_BestCompanyAddressVoted(LEFT,RIGHT),LEFT OUTER,HASH,HINT(parallel_match));
// Now perform a propogation on the concept address using BestType BestCompanyAddressCurrent
//First find the propogation candidates; and translate into normal field names 
  PC := TABLE(Best(ih).BestBy_Proxid_best(Proxid <> 0,address_method = 2),{Proxid,TYPEOF(address_prim_range) prim_range := address_prim_range,TYPEOF(address_predir) predir := address_predir,TYPEOF(address_prim_name) prim_name := address_prim_name,TYPEOF(address_addr_suffix) addr_suffix := address_addr_suffix,TYPEOF(address_postdir) postdir := address_postdir,TYPEOF(address_unit_desig) unit_desig := address_unit_desig,TYPEOF(address_sec_range) sec_range := address_sec_range,TYPEOF(address_st) st := address_st,TYPEOF(address_zip) zip := address_zip})(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)));
  layout_withpropvars T_address_BestCompanyAddressCurrent(layout_withpropvars le,PC ri) := TRANSFORM
  // By the time we are in here - if 'ri' has a value then any fields that need to match do
    BOOLEAN null_rhs := (ri.prim_range  IN SET(s.nulls_prim_range,prim_range) AND ri.predir  IN SET(s.nulls_predir,predir) AND ri.prim_name  IN SET(s.nulls_prim_name,prim_name) AND ri.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND ri.postdir  IN SET(s.nulls_postdir,postdir) AND ri.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND ri.sec_range  IN SET(s.nulls_sec_range,sec_range) AND ri.st  IN SET(s.nulls_st,st) AND ri.zip  IN SET(s.nulls_zip,zip)) OR le.address_prop > 0;
    SELF.prim_range := IF ( null_rhs OR le.prim_range_prop > 0, le.prim_range, ri.prim_range );
    SELF.prim_range_prop := IF ( le.prim_range = SELF.prim_range, le.prim_range_prop,1); // Flag the propagation for sliceouts
    SELF.predir := IF ( null_rhs OR le.predir_prop > 0, le.predir, ri.predir );
    SELF.predir_prop := IF ( le.predir = SELF.predir, le.predir_prop,1); // Flag the propagation for sliceouts
    SELF.prim_name := IF ( null_rhs OR le.prim_name_prop > 0, le.prim_name, ri.prim_name );
    SELF.prim_name_prop := IF ( le.prim_name = SELF.prim_name, le.prim_name_prop,1); // Flag the propagation for sliceouts
    SELF.addr_suffix := IF ( null_rhs OR le.addr_suffix_prop > 0, le.addr_suffix, ri.addr_suffix );
    SELF.addr_suffix_prop := IF ( le.addr_suffix = SELF.addr_suffix, le.addr_suffix_prop,1); // Flag the propagation for sliceouts
    SELF.postdir := IF ( null_rhs OR le.postdir_prop > 0, le.postdir, ri.postdir );
    SELF.postdir_prop := IF ( le.postdir = SELF.postdir, le.postdir_prop,1); // Flag the propagation for sliceouts
    SELF.unit_desig := IF ( null_rhs OR le.unit_desig_prop > 0, le.unit_desig, ri.unit_desig );
    SELF.unit_desig_prop := IF ( le.unit_desig = SELF.unit_desig, le.unit_desig_prop,1); // Flag the propagation for sliceouts
    SELF.sec_range := IF ( null_rhs OR le.sec_range_prop > 0, le.sec_range, ri.sec_range );
    SELF.sec_range_prop := IF ( le.sec_range = SELF.sec_range, le.sec_range_prop,1); // Flag the propagation for sliceouts
    SELF.st := IF ( null_rhs OR le.st_prop > 0, le.st, ri.st );
    SELF.st_prop := IF ( le.st = SELF.st, le.st_prop,1); // Flag the propagation for sliceouts
    SELF.zip := IF ( null_rhs OR le.zip_prop > 0, le.zip, ri.zip );
    SELF.zip_prop := IF ( le.zip = SELF.zip, le.zip_prop,1); // Flag the propagation for sliceouts
    SELF.address_prop := IF( le.prim_range_prop = SELF.prim_range_prop, 0, 1 ) + IF( le.predir_prop = SELF.predir_prop, 0, 2 ) + IF( le.prim_name_prop = SELF.prim_name_prop, 0, 4 ) + IF( le.addr_suffix_prop = SELF.addr_suffix_prop, 0, 8 ) + IF( le.postdir_prop = SELF.postdir_prop, 0, 16 ) + IF( le.unit_desig_prop = SELF.unit_desig_prop, 0, 32 ) + IF( le.sec_range_prop = SELF.sec_range_prop, 0, 64 ) + IF( le.st_prop = SELF.st_prop, 0, 128 ) + IF( le.zip_prop = SELF.zip_prop, 0, 256 ); // One bit for each propogated field
    SELF.address_prop_method := IF( null_rhs OR SELF.address_prop = 0, le.address_prop_method, 2 );
    SELF := le;
  END;
SHARED J_address_BestCompanyAddressCurrent := JOIN(J_address_BestCompanyAddressVoted,PC, LEFT.Proxid = RIGHT.Proxid  AND ((SALT30.StrType)RIGHT.prim_range[1..length(trim((SALT30.StrType)LEFT.prim_range))] = (SALT30.StrType)LEFT.prim_range ) AND ((SALT30.StrType)RIGHT.predir[1..length(trim((SALT30.StrType)LEFT.predir))] = (SALT30.StrType)LEFT.predir ) AND ((SALT30.StrType)RIGHT.prim_name[1..length(trim((SALT30.StrType)LEFT.prim_name))] = (SALT30.StrType)LEFT.prim_name ) AND ((SALT30.StrType)RIGHT.addr_suffix[1..length(trim((SALT30.StrType)LEFT.addr_suffix))] = (SALT30.StrType)LEFT.addr_suffix ) AND ((SALT30.StrType)RIGHT.postdir[1..length(trim((SALT30.StrType)LEFT.postdir))] = (SALT30.StrType)LEFT.postdir ) AND ((SALT30.StrType)RIGHT.unit_desig[1..length(trim((SALT30.StrType)LEFT.unit_desig))] = (SALT30.StrType)LEFT.unit_desig ) AND ((SALT30.StrType)RIGHT.sec_range[1..length(trim((SALT30.StrType)LEFT.sec_range))] = (SALT30.StrType)LEFT.sec_range ) AND ((SALT30.StrType)RIGHT.st[1..length(trim((SALT30.StrType)LEFT.st))] = (SALT30.StrType)LEFT.st ) AND ((SALT30.StrType)RIGHT.zip[1..length(trim((SALT30.StrType)LEFT.zip))] = (SALT30.StrType)LEFT.zip ),T_address_BestCompanyAddressCurrent(LEFT,RIGHT),LEFT OUTER,HASH,HINT(parallel_match));
// Now perform a propogation on the concept address using BestType BestCompanyAddressVotedSrc
//First find the propogation candidates; and translate into normal field names 
  PC := TABLE(Best(ih).BestBy_Proxid_best(Proxid <> 0,address_method = 3),{Proxid,TYPEOF(address_prim_range) prim_range := address_prim_range,TYPEOF(address_predir) predir := address_predir,TYPEOF(address_prim_name) prim_name := address_prim_name,TYPEOF(address_addr_suffix) addr_suffix := address_addr_suffix,TYPEOF(address_postdir) postdir := address_postdir,TYPEOF(address_unit_desig) unit_desig := address_unit_desig,TYPEOF(address_sec_range) sec_range := address_sec_range,TYPEOF(address_st) st := address_st,TYPEOF(address_zip) zip := address_zip})(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)));
  layout_withpropvars T_address_BestCompanyAddressVotedSrc(layout_withpropvars le,PC ri) := TRANSFORM
  // By the time we are in here - if 'ri' has a value then any fields that need to match do
    BOOLEAN null_rhs := (ri.prim_range  IN SET(s.nulls_prim_range,prim_range) AND ri.predir  IN SET(s.nulls_predir,predir) AND ri.prim_name  IN SET(s.nulls_prim_name,prim_name) AND ri.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND ri.postdir  IN SET(s.nulls_postdir,postdir) AND ri.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND ri.sec_range  IN SET(s.nulls_sec_range,sec_range) AND ri.st  IN SET(s.nulls_st,st) AND ri.zip  IN SET(s.nulls_zip,zip)) OR le.address_prop > 0;
    SELF.prim_range := IF ( null_rhs OR le.prim_range_prop > 0, le.prim_range, ri.prim_range );
    SELF.prim_range_prop := IF ( le.prim_range = SELF.prim_range, le.prim_range_prop,1); // Flag the propagation for sliceouts
    SELF.predir := IF ( null_rhs OR le.predir_prop > 0, le.predir, ri.predir );
    SELF.predir_prop := IF ( le.predir = SELF.predir, le.predir_prop,1); // Flag the propagation for sliceouts
    SELF.prim_name := IF ( null_rhs OR le.prim_name_prop > 0, le.prim_name, ri.prim_name );
    SELF.prim_name_prop := IF ( le.prim_name = SELF.prim_name, le.prim_name_prop,1); // Flag the propagation for sliceouts
    SELF.addr_suffix := IF ( null_rhs OR le.addr_suffix_prop > 0, le.addr_suffix, ri.addr_suffix );
    SELF.addr_suffix_prop := IF ( le.addr_suffix = SELF.addr_suffix, le.addr_suffix_prop,1); // Flag the propagation for sliceouts
    SELF.postdir := IF ( null_rhs OR le.postdir_prop > 0, le.postdir, ri.postdir );
    SELF.postdir_prop := IF ( le.postdir = SELF.postdir, le.postdir_prop,1); // Flag the propagation for sliceouts
    SELF.unit_desig := IF ( null_rhs OR le.unit_desig_prop > 0, le.unit_desig, ri.unit_desig );
    SELF.unit_desig_prop := IF ( le.unit_desig = SELF.unit_desig, le.unit_desig_prop,1); // Flag the propagation for sliceouts
    SELF.sec_range := IF ( null_rhs OR le.sec_range_prop > 0, le.sec_range, ri.sec_range );
    SELF.sec_range_prop := IF ( le.sec_range = SELF.sec_range, le.sec_range_prop,1); // Flag the propagation for sliceouts
    SELF.st := IF ( null_rhs OR le.st_prop > 0, le.st, ri.st );
    SELF.st_prop := IF ( le.st = SELF.st, le.st_prop,1); // Flag the propagation for sliceouts
    SELF.zip := IF ( null_rhs OR le.zip_prop > 0, le.zip, ri.zip );
    SELF.zip_prop := IF ( le.zip = SELF.zip, le.zip_prop,1); // Flag the propagation for sliceouts
    SELF.address_prop := IF( le.prim_range_prop = SELF.prim_range_prop, 0, 1 ) + IF( le.predir_prop = SELF.predir_prop, 0, 2 ) + IF( le.prim_name_prop = SELF.prim_name_prop, 0, 4 ) + IF( le.addr_suffix_prop = SELF.addr_suffix_prop, 0, 8 ) + IF( le.postdir_prop = SELF.postdir_prop, 0, 16 ) + IF( le.unit_desig_prop = SELF.unit_desig_prop, 0, 32 ) + IF( le.sec_range_prop = SELF.sec_range_prop, 0, 64 ) + IF( le.st_prop = SELF.st_prop, 0, 128 ) + IF( le.zip_prop = SELF.zip_prop, 0, 256 ); // One bit for each propogated field
    SELF.address_prop_method := IF( null_rhs OR SELF.address_prop = 0, le.address_prop_method, 3 );
    SELF := le;
  END;
SHARED J_address_BestCompanyAddressVotedSrc := JOIN(J_address_BestCompanyAddressCurrent,PC, LEFT.Proxid = RIGHT.Proxid  AND ((SALT30.StrType)RIGHT.prim_range[1..length(trim((SALT30.StrType)LEFT.prim_range))] = (SALT30.StrType)LEFT.prim_range ) AND ((SALT30.StrType)RIGHT.predir[1..length(trim((SALT30.StrType)LEFT.predir))] = (SALT30.StrType)LEFT.predir ) AND ((SALT30.StrType)RIGHT.prim_name[1..length(trim((SALT30.StrType)LEFT.prim_name))] = (SALT30.StrType)LEFT.prim_name ) AND ((SALT30.StrType)RIGHT.addr_suffix[1..length(trim((SALT30.StrType)LEFT.addr_suffix))] = (SALT30.StrType)LEFT.addr_suffix ) AND ((SALT30.StrType)RIGHT.postdir[1..length(trim((SALT30.StrType)LEFT.postdir))] = (SALT30.StrType)LEFT.postdir ) AND ((SALT30.StrType)RIGHT.unit_desig[1..length(trim((SALT30.StrType)LEFT.unit_desig))] = (SALT30.StrType)LEFT.unit_desig ) AND ((SALT30.StrType)RIGHT.sec_range[1..length(trim((SALT30.StrType)LEFT.sec_range))] = (SALT30.StrType)LEFT.sec_range ) AND ((SALT30.StrType)RIGHT.st[1..length(trim((SALT30.StrType)LEFT.st))] = (SALT30.StrType)LEFT.st ) AND ((SALT30.StrType)RIGHT.zip[1..length(trim((SALT30.StrType)LEFT.zip))] = (SALT30.StrType)LEFT.zip ),T_address_BestCompanyAddressVotedSrc(LEFT,RIGHT),LEFT OUTER,HASH,HINT(parallel_match));
// Now perform a propogation on the concept address using BestType BestCompanyAddressCommon
//First find the propogation candidates; and translate into normal field names 
  PC := TABLE(Best(ih).BestBy_Proxid_best(Proxid <> 0,address_method = 4),{Proxid,TYPEOF(address_prim_range) prim_range := address_prim_range,TYPEOF(address_predir) predir := address_predir,TYPEOF(address_prim_name) prim_name := address_prim_name,TYPEOF(address_addr_suffix) addr_suffix := address_addr_suffix,TYPEOF(address_postdir) postdir := address_postdir,TYPEOF(address_unit_desig) unit_desig := address_unit_desig,TYPEOF(address_sec_range) sec_range := address_sec_range,TYPEOF(address_st) st := address_st,TYPEOF(address_zip) zip := address_zip})(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)));
  layout_withpropvars T_address_BestCompanyAddressCommon(layout_withpropvars le,PC ri) := TRANSFORM
  // By the time we are in here - if 'ri' has a value then any fields that need to match do
    BOOLEAN null_rhs := (ri.prim_range  IN SET(s.nulls_prim_range,prim_range) AND ri.predir  IN SET(s.nulls_predir,predir) AND ri.prim_name  IN SET(s.nulls_prim_name,prim_name) AND ri.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND ri.postdir  IN SET(s.nulls_postdir,postdir) AND ri.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND ri.sec_range  IN SET(s.nulls_sec_range,sec_range) AND ri.st  IN SET(s.nulls_st,st) AND ri.zip  IN SET(s.nulls_zip,zip)) OR le.address_prop > 0;
    SELF.prim_range := IF ( null_rhs OR le.prim_range_prop > 0, le.prim_range, ri.prim_range );
    SELF.prim_range_prop := IF ( le.prim_range = SELF.prim_range, le.prim_range_prop,1); // Flag the propagation for sliceouts
    SELF.predir := IF ( null_rhs OR le.predir_prop > 0, le.predir, ri.predir );
    SELF.predir_prop := IF ( le.predir = SELF.predir, le.predir_prop,1); // Flag the propagation for sliceouts
    SELF.prim_name := IF ( null_rhs OR le.prim_name_prop > 0, le.prim_name, ri.prim_name );
    SELF.prim_name_prop := IF ( le.prim_name = SELF.prim_name, le.prim_name_prop,1); // Flag the propagation for sliceouts
    SELF.addr_suffix := IF ( null_rhs OR le.addr_suffix_prop > 0, le.addr_suffix, ri.addr_suffix );
    SELF.addr_suffix_prop := IF ( le.addr_suffix = SELF.addr_suffix, le.addr_suffix_prop,1); // Flag the propagation for sliceouts
    SELF.postdir := IF ( null_rhs OR le.postdir_prop > 0, le.postdir, ri.postdir );
    SELF.postdir_prop := IF ( le.postdir = SELF.postdir, le.postdir_prop,1); // Flag the propagation for sliceouts
    SELF.unit_desig := IF ( null_rhs OR le.unit_desig_prop > 0, le.unit_desig, ri.unit_desig );
    SELF.unit_desig_prop := IF ( le.unit_desig = SELF.unit_desig, le.unit_desig_prop,1); // Flag the propagation for sliceouts
    SELF.sec_range := IF ( null_rhs OR le.sec_range_prop > 0, le.sec_range, ri.sec_range );
    SELF.sec_range_prop := IF ( le.sec_range = SELF.sec_range, le.sec_range_prop,1); // Flag the propagation for sliceouts
    SELF.st := IF ( null_rhs OR le.st_prop > 0, le.st, ri.st );
    SELF.st_prop := IF ( le.st = SELF.st, le.st_prop,1); // Flag the propagation for sliceouts
    SELF.zip := IF ( null_rhs OR le.zip_prop > 0, le.zip, ri.zip );
    SELF.zip_prop := IF ( le.zip = SELF.zip, le.zip_prop,1); // Flag the propagation for sliceouts
    SELF.address_prop := IF( le.prim_range_prop = SELF.prim_range_prop, 0, 1 ) + IF( le.predir_prop = SELF.predir_prop, 0, 2 ) + IF( le.prim_name_prop = SELF.prim_name_prop, 0, 4 ) + IF( le.addr_suffix_prop = SELF.addr_suffix_prop, 0, 8 ) + IF( le.postdir_prop = SELF.postdir_prop, 0, 16 ) + IF( le.unit_desig_prop = SELF.unit_desig_prop, 0, 32 ) + IF( le.sec_range_prop = SELF.sec_range_prop, 0, 64 ) + IF( le.st_prop = SELF.st_prop, 0, 128 ) + IF( le.zip_prop = SELF.zip_prop, 0, 256 ); // One bit for each propogated field
    SELF.address_prop_method := IF( null_rhs OR SELF.address_prop = 0, le.address_prop_method, 4 );
    SELF := le;
  END;
SHARED J_address_BestCompanyAddressCommon := JOIN(J_address_BestCompanyAddressVotedSrc,PC, LEFT.Proxid = RIGHT.Proxid  AND ((SALT30.StrType)RIGHT.prim_range[1..length(trim((SALT30.StrType)LEFT.prim_range))] = (SALT30.StrType)LEFT.prim_range ) AND ((SALT30.StrType)RIGHT.predir[1..length(trim((SALT30.StrType)LEFT.predir))] = (SALT30.StrType)LEFT.predir ) AND ((SALT30.StrType)RIGHT.prim_name[1..length(trim((SALT30.StrType)LEFT.prim_name))] = (SALT30.StrType)LEFT.prim_name ) AND ((SALT30.StrType)RIGHT.addr_suffix[1..length(trim((SALT30.StrType)LEFT.addr_suffix))] = (SALT30.StrType)LEFT.addr_suffix ) AND ((SALT30.StrType)RIGHT.postdir[1..length(trim((SALT30.StrType)LEFT.postdir))] = (SALT30.StrType)LEFT.postdir ) AND ((SALT30.StrType)RIGHT.unit_desig[1..length(trim((SALT30.StrType)LEFT.unit_desig))] = (SALT30.StrType)LEFT.unit_desig ) AND ((SALT30.StrType)RIGHT.sec_range[1..length(trim((SALT30.StrType)LEFT.sec_range))] = (SALT30.StrType)LEFT.sec_range ) AND ((SALT30.StrType)RIGHT.st[1..length(trim((SALT30.StrType)LEFT.st))] = (SALT30.StrType)LEFT.st ) AND ((SALT30.StrType)RIGHT.zip[1..length(trim((SALT30.StrType)LEFT.zip))] = (SALT30.StrType)LEFT.zip ),T_address_BestCompanyAddressCommon(LEFT,RIGHT),LEFT OUTER,HASH,HINT(parallel_match));
// Now perform a propogation on the concept address using BestType BestCompanyAddressStrong
//First find the propogation candidates; and translate into normal field names 
  PC := TABLE(Best(ih).BestBy_Proxid_best(Proxid <> 0,address_method = 5),{Proxid,TYPEOF(address_prim_range) prim_range := address_prim_range,TYPEOF(address_predir) predir := address_predir,TYPEOF(address_prim_name) prim_name := address_prim_name,TYPEOF(address_addr_suffix) addr_suffix := address_addr_suffix,TYPEOF(address_postdir) postdir := address_postdir,TYPEOF(address_unit_desig) unit_desig := address_unit_desig,TYPEOF(address_sec_range) sec_range := address_sec_range,TYPEOF(address_st) st := address_st,TYPEOF(address_zip) zip := address_zip})(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)));
  layout_withpropvars T_address_BestCompanyAddressStrong(layout_withpropvars le,PC ri) := TRANSFORM
  // By the time we are in here - if 'ri' has a value then any fields that need to match do
    BOOLEAN null_rhs := (ri.prim_range  IN SET(s.nulls_prim_range,prim_range) AND ri.predir  IN SET(s.nulls_predir,predir) AND ri.prim_name  IN SET(s.nulls_prim_name,prim_name) AND ri.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND ri.postdir  IN SET(s.nulls_postdir,postdir) AND ri.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND ri.sec_range  IN SET(s.nulls_sec_range,sec_range) AND ri.st  IN SET(s.nulls_st,st) AND ri.zip  IN SET(s.nulls_zip,zip)) OR le.address_prop > 0;
    SELF.prim_range := IF ( null_rhs OR le.prim_range_prop > 0, le.prim_range, ri.prim_range );
    SELF.prim_range_prop := IF ( le.prim_range = SELF.prim_range, le.prim_range_prop,1); // Flag the propagation for sliceouts
    SELF.predir := IF ( null_rhs OR le.predir_prop > 0, le.predir, ri.predir );
    SELF.predir_prop := IF ( le.predir = SELF.predir, le.predir_prop,1); // Flag the propagation for sliceouts
    SELF.prim_name := IF ( null_rhs OR le.prim_name_prop > 0, le.prim_name, ri.prim_name );
    SELF.prim_name_prop := IF ( le.prim_name = SELF.prim_name, le.prim_name_prop,1); // Flag the propagation for sliceouts
    SELF.addr_suffix := IF ( null_rhs OR le.addr_suffix_prop > 0, le.addr_suffix, ri.addr_suffix );
    SELF.addr_suffix_prop := IF ( le.addr_suffix = SELF.addr_suffix, le.addr_suffix_prop,1); // Flag the propagation for sliceouts
    SELF.postdir := IF ( null_rhs OR le.postdir_prop > 0, le.postdir, ri.postdir );
    SELF.postdir_prop := IF ( le.postdir = SELF.postdir, le.postdir_prop,1); // Flag the propagation for sliceouts
    SELF.unit_desig := IF ( null_rhs OR le.unit_desig_prop > 0, le.unit_desig, ri.unit_desig );
    SELF.unit_desig_prop := IF ( le.unit_desig = SELF.unit_desig, le.unit_desig_prop,1); // Flag the propagation for sliceouts
    SELF.sec_range := IF ( null_rhs OR le.sec_range_prop > 0, le.sec_range, ri.sec_range );
    SELF.sec_range_prop := IF ( le.sec_range = SELF.sec_range, le.sec_range_prop,1); // Flag the propagation for sliceouts
    SELF.st := IF ( null_rhs OR le.st_prop > 0, le.st, ri.st );
    SELF.st_prop := IF ( le.st = SELF.st, le.st_prop,1); // Flag the propagation for sliceouts
    SELF.zip := IF ( null_rhs OR le.zip_prop > 0, le.zip, ri.zip );
    SELF.zip_prop := IF ( le.zip = SELF.zip, le.zip_prop,1); // Flag the propagation for sliceouts
    SELF.address_prop := IF( le.prim_range_prop = SELF.prim_range_prop, 0, 1 ) + IF( le.predir_prop = SELF.predir_prop, 0, 2 ) + IF( le.prim_name_prop = SELF.prim_name_prop, 0, 4 ) + IF( le.addr_suffix_prop = SELF.addr_suffix_prop, 0, 8 ) + IF( le.postdir_prop = SELF.postdir_prop, 0, 16 ) + IF( le.unit_desig_prop = SELF.unit_desig_prop, 0, 32 ) + IF( le.sec_range_prop = SELF.sec_range_prop, 0, 64 ) + IF( le.st_prop = SELF.st_prop, 0, 128 ) + IF( le.zip_prop = SELF.zip_prop, 0, 256 ); // One bit for each propogated field
    SELF.address_prop_method := IF( null_rhs OR SELF.address_prop = 0, le.address_prop_method, 5 );
    SELF := le;
  END;
SHARED J_address_BestCompanyAddressStrong := JOIN(J_address_BestCompanyAddressCommon,PC, LEFT.Proxid = RIGHT.Proxid  AND ((SALT30.StrType)RIGHT.prim_range[1..length(trim((SALT30.StrType)LEFT.prim_range))] = (SALT30.StrType)LEFT.prim_range ) AND ((SALT30.StrType)RIGHT.predir[1..length(trim((SALT30.StrType)LEFT.predir))] = (SALT30.StrType)LEFT.predir ) AND ((SALT30.StrType)RIGHT.prim_name[1..length(trim((SALT30.StrType)LEFT.prim_name))] = (SALT30.StrType)LEFT.prim_name ) AND ((SALT30.StrType)RIGHT.addr_suffix[1..length(trim((SALT30.StrType)LEFT.addr_suffix))] = (SALT30.StrType)LEFT.addr_suffix ) AND ((SALT30.StrType)RIGHT.postdir[1..length(trim((SALT30.StrType)LEFT.postdir))] = (SALT30.StrType)LEFT.postdir ) AND ((SALT30.StrType)RIGHT.unit_desig[1..length(trim((SALT30.StrType)LEFT.unit_desig))] = (SALT30.StrType)LEFT.unit_desig ) AND ((SALT30.StrType)RIGHT.sec_range[1..length(trim((SALT30.StrType)LEFT.sec_range))] = (SALT30.StrType)LEFT.sec_range ) AND ((SALT30.StrType)RIGHT.st[1..length(trim((SALT30.StrType)LEFT.st))] = (SALT30.StrType)LEFT.st ) AND ((SALT30.StrType)RIGHT.zip[1..length(trim((SALT30.StrType)LEFT.zip))] = (SALT30.StrType)LEFT.zip ),T_address_BestCompanyAddressStrong(LEFT,RIGHT),LEFT OUTER,HASH,HINT(parallel_match));
// Now perform a propogation on the concept address using BestType BestCompanyAddressCurrent2
//First find the propogation candidates; and translate into normal field names 
  PC := TABLE(Best(ih).BestBy_Proxid_best(Proxid <> 0,address_method = 6),{Proxid,TYPEOF(address_prim_range) prim_range := address_prim_range,TYPEOF(address_predir) predir := address_predir,TYPEOF(address_prim_name) prim_name := address_prim_name,TYPEOF(address_addr_suffix) addr_suffix := address_addr_suffix,TYPEOF(address_postdir) postdir := address_postdir,TYPEOF(address_unit_desig) unit_desig := address_unit_desig,TYPEOF(address_sec_range) sec_range := address_sec_range,TYPEOF(address_st) st := address_st,TYPEOF(address_zip) zip := address_zip})(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)));
  layout_withpropvars T_address_BestCompanyAddressCurrent2(layout_withpropvars le,PC ri) := TRANSFORM
  // By the time we are in here - if 'ri' has a value then any fields that need to match do
    BOOLEAN null_rhs := (ri.prim_range  IN SET(s.nulls_prim_range,prim_range) AND ri.predir  IN SET(s.nulls_predir,predir) AND ri.prim_name  IN SET(s.nulls_prim_name,prim_name) AND ri.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND ri.postdir  IN SET(s.nulls_postdir,postdir) AND ri.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND ri.sec_range  IN SET(s.nulls_sec_range,sec_range) AND ri.st  IN SET(s.nulls_st,st) AND ri.zip  IN SET(s.nulls_zip,zip)) OR le.address_prop > 0;
    SELF.prim_range := IF ( null_rhs OR le.prim_range_prop > 0, le.prim_range, ri.prim_range );
    SELF.prim_range_prop := IF ( le.prim_range = SELF.prim_range, le.prim_range_prop,1); // Flag the propagation for sliceouts
    SELF.predir := IF ( null_rhs OR le.predir_prop > 0, le.predir, ri.predir );
    SELF.predir_prop := IF ( le.predir = SELF.predir, le.predir_prop,1); // Flag the propagation for sliceouts
    SELF.prim_name := IF ( null_rhs OR le.prim_name_prop > 0, le.prim_name, ri.prim_name );
    SELF.prim_name_prop := IF ( le.prim_name = SELF.prim_name, le.prim_name_prop,1); // Flag the propagation for sliceouts
    SELF.addr_suffix := IF ( null_rhs OR le.addr_suffix_prop > 0, le.addr_suffix, ri.addr_suffix );
    SELF.addr_suffix_prop := IF ( le.addr_suffix = SELF.addr_suffix, le.addr_suffix_prop,1); // Flag the propagation for sliceouts
    SELF.postdir := IF ( null_rhs OR le.postdir_prop > 0, le.postdir, ri.postdir );
    SELF.postdir_prop := IF ( le.postdir = SELF.postdir, le.postdir_prop,1); // Flag the propagation for sliceouts
    SELF.unit_desig := IF ( null_rhs OR le.unit_desig_prop > 0, le.unit_desig, ri.unit_desig );
    SELF.unit_desig_prop := IF ( le.unit_desig = SELF.unit_desig, le.unit_desig_prop,1); // Flag the propagation for sliceouts
    SELF.sec_range := IF ( null_rhs OR le.sec_range_prop > 0, le.sec_range, ri.sec_range );
    SELF.sec_range_prop := IF ( le.sec_range = SELF.sec_range, le.sec_range_prop,1); // Flag the propagation for sliceouts
    SELF.st := IF ( null_rhs OR le.st_prop > 0, le.st, ri.st );
    SELF.st_prop := IF ( le.st = SELF.st, le.st_prop,1); // Flag the propagation for sliceouts
    SELF.zip := IF ( null_rhs OR le.zip_prop > 0, le.zip, ri.zip );
    SELF.zip_prop := IF ( le.zip = SELF.zip, le.zip_prop,1); // Flag the propagation for sliceouts
    SELF.address_prop := IF( le.prim_range_prop = SELF.prim_range_prop, 0, 1 ) + IF( le.predir_prop = SELF.predir_prop, 0, 2 ) + IF( le.prim_name_prop = SELF.prim_name_prop, 0, 4 ) + IF( le.addr_suffix_prop = SELF.addr_suffix_prop, 0, 8 ) + IF( le.postdir_prop = SELF.postdir_prop, 0, 16 ) + IF( le.unit_desig_prop = SELF.unit_desig_prop, 0, 32 ) + IF( le.sec_range_prop = SELF.sec_range_prop, 0, 64 ) + IF( le.st_prop = SELF.st_prop, 0, 128 ) + IF( le.zip_prop = SELF.zip_prop, 0, 256 ); // One bit for each propogated field
    SELF.address_prop_method := IF( null_rhs OR SELF.address_prop = 0, le.address_prop_method, 6 );
    SELF := le;
  END;
SHARED J_address_BestCompanyAddressCurrent2 := JOIN(J_address_BestCompanyAddressStrong,PC, LEFT.Proxid = RIGHT.Proxid  AND ((SALT30.StrType)RIGHT.prim_range[1..length(trim((SALT30.StrType)LEFT.prim_range))] = (SALT30.StrType)LEFT.prim_range ) AND ((SALT30.StrType)RIGHT.predir[1..length(trim((SALT30.StrType)LEFT.predir))] = (SALT30.StrType)LEFT.predir ) AND ((SALT30.StrType)RIGHT.prim_name[1..length(trim((SALT30.StrType)LEFT.prim_name))] = (SALT30.StrType)LEFT.prim_name ) AND ((SALT30.StrType)RIGHT.addr_suffix[1..length(trim((SALT30.StrType)LEFT.addr_suffix))] = (SALT30.StrType)LEFT.addr_suffix ) AND ((SALT30.StrType)RIGHT.postdir[1..length(trim((SALT30.StrType)LEFT.postdir))] = (SALT30.StrType)LEFT.postdir ) AND ((SALT30.StrType)RIGHT.unit_desig[1..length(trim((SALT30.StrType)LEFT.unit_desig))] = (SALT30.StrType)LEFT.unit_desig ) AND ((SALT30.StrType)RIGHT.sec_range[1..length(trim((SALT30.StrType)LEFT.sec_range))] = (SALT30.StrType)LEFT.sec_range ) AND ((SALT30.StrType)RIGHT.st[1..length(trim((SALT30.StrType)LEFT.st))] = (SALT30.StrType)LEFT.st ) AND ((SALT30.StrType)RIGHT.zip[1..length(trim((SALT30.StrType)LEFT.zip))] = (SALT30.StrType)LEFT.zip ),T_address_BestCompanyAddressCurrent2(LEFT,RIGHT),LEFT OUTER,HASH,HINT(parallel_match));
// Now perform a propogation on the concept address using BestType BestCompanyAddressVotedUnrestricted
//First find the propogation candidates; and translate into normal field names 
  PC := TABLE(Best(ih).BestBy_Proxid_best(Proxid <> 0,address_method = 7),{Proxid,TYPEOF(address_prim_range) prim_range := address_prim_range,TYPEOF(address_predir) predir := address_predir,TYPEOF(address_prim_name) prim_name := address_prim_name,TYPEOF(address_addr_suffix) addr_suffix := address_addr_suffix,TYPEOF(address_postdir) postdir := address_postdir,TYPEOF(address_unit_desig) unit_desig := address_unit_desig,TYPEOF(address_sec_range) sec_range := address_sec_range,TYPEOF(address_st) st := address_st,TYPEOF(address_zip) zip := address_zip})(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)));
  layout_withpropvars T_address_BestCompanyAddressVotedUnrestricted(layout_withpropvars le,PC ri) := TRANSFORM
  // By the time we are in here - if 'ri' has a value then any fields that need to match do
    BOOLEAN null_rhs := (ri.prim_range  IN SET(s.nulls_prim_range,prim_range) AND ri.predir  IN SET(s.nulls_predir,predir) AND ri.prim_name  IN SET(s.nulls_prim_name,prim_name) AND ri.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND ri.postdir  IN SET(s.nulls_postdir,postdir) AND ri.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND ri.sec_range  IN SET(s.nulls_sec_range,sec_range) AND ri.st  IN SET(s.nulls_st,st) AND ri.zip  IN SET(s.nulls_zip,zip)) OR le.address_prop > 0;
    SELF.prim_range := IF ( null_rhs OR le.prim_range_prop > 0, le.prim_range, ri.prim_range );
    SELF.prim_range_prop := IF ( le.prim_range = SELF.prim_range, le.prim_range_prop,1); // Flag the propagation for sliceouts
    SELF.predir := IF ( null_rhs OR le.predir_prop > 0, le.predir, ri.predir );
    SELF.predir_prop := IF ( le.predir = SELF.predir, le.predir_prop,1); // Flag the propagation for sliceouts
    SELF.prim_name := IF ( null_rhs OR le.prim_name_prop > 0, le.prim_name, ri.prim_name );
    SELF.prim_name_prop := IF ( le.prim_name = SELF.prim_name, le.prim_name_prop,1); // Flag the propagation for sliceouts
    SELF.addr_suffix := IF ( null_rhs OR le.addr_suffix_prop > 0, le.addr_suffix, ri.addr_suffix );
    SELF.addr_suffix_prop := IF ( le.addr_suffix = SELF.addr_suffix, le.addr_suffix_prop,1); // Flag the propagation for sliceouts
    SELF.postdir := IF ( null_rhs OR le.postdir_prop > 0, le.postdir, ri.postdir );
    SELF.postdir_prop := IF ( le.postdir = SELF.postdir, le.postdir_prop,1); // Flag the propagation for sliceouts
    SELF.unit_desig := IF ( null_rhs OR le.unit_desig_prop > 0, le.unit_desig, ri.unit_desig );
    SELF.unit_desig_prop := IF ( le.unit_desig = SELF.unit_desig, le.unit_desig_prop,1); // Flag the propagation for sliceouts
    SELF.sec_range := IF ( null_rhs OR le.sec_range_prop > 0, le.sec_range, ri.sec_range );
    SELF.sec_range_prop := IF ( le.sec_range = SELF.sec_range, le.sec_range_prop,1); // Flag the propagation for sliceouts
    SELF.st := IF ( null_rhs OR le.st_prop > 0, le.st, ri.st );
    SELF.st_prop := IF ( le.st = SELF.st, le.st_prop,1); // Flag the propagation for sliceouts
    SELF.zip := IF ( null_rhs OR le.zip_prop > 0, le.zip, ri.zip );
    SELF.zip_prop := IF ( le.zip = SELF.zip, le.zip_prop,1); // Flag the propagation for sliceouts
    SELF.address_prop := IF( le.prim_range_prop = SELF.prim_range_prop, 0, 1 ) + IF( le.predir_prop = SELF.predir_prop, 0, 2 ) + IF( le.prim_name_prop = SELF.prim_name_prop, 0, 4 ) + IF( le.addr_suffix_prop = SELF.addr_suffix_prop, 0, 8 ) + IF( le.postdir_prop = SELF.postdir_prop, 0, 16 ) + IF( le.unit_desig_prop = SELF.unit_desig_prop, 0, 32 ) + IF( le.sec_range_prop = SELF.sec_range_prop, 0, 64 ) + IF( le.st_prop = SELF.st_prop, 0, 128 ) + IF( le.zip_prop = SELF.zip_prop, 0, 256 ); // One bit for each propogated field
    SELF.address_prop_method := IF( null_rhs OR SELF.address_prop = 0, le.address_prop_method, 7 );
    SELF := le;
  END;
SHARED J_address_BestCompanyAddressVotedUnrestricted := JOIN(J_address_BestCompanyAddressCurrent2,PC, LEFT.Proxid = RIGHT.Proxid  AND ((SALT30.StrType)RIGHT.prim_range[1..length(trim((SALT30.StrType)LEFT.prim_range))] = (SALT30.StrType)LEFT.prim_range ) AND ((SALT30.StrType)RIGHT.predir[1..length(trim((SALT30.StrType)LEFT.predir))] = (SALT30.StrType)LEFT.predir ) AND ((SALT30.StrType)RIGHT.prim_name[1..length(trim((SALT30.StrType)LEFT.prim_name))] = (SALT30.StrType)LEFT.prim_name ) AND ((SALT30.StrType)RIGHT.addr_suffix[1..length(trim((SALT30.StrType)LEFT.addr_suffix))] = (SALT30.StrType)LEFT.addr_suffix ) AND ((SALT30.StrType)RIGHT.postdir[1..length(trim((SALT30.StrType)LEFT.postdir))] = (SALT30.StrType)LEFT.postdir ) AND ((SALT30.StrType)RIGHT.unit_desig[1..length(trim((SALT30.StrType)LEFT.unit_desig))] = (SALT30.StrType)LEFT.unit_desig ) AND ((SALT30.StrType)RIGHT.sec_range[1..length(trim((SALT30.StrType)LEFT.sec_range))] = (SALT30.StrType)LEFT.sec_range ) AND ((SALT30.StrType)RIGHT.st[1..length(trim((SALT30.StrType)LEFT.st))] = (SALT30.StrType)LEFT.st ) AND ((SALT30.StrType)RIGHT.zip[1..length(trim((SALT30.StrType)LEFT.zip))] = (SALT30.StrType)LEFT.zip ),T_address_BestCompanyAddressVotedUnrestricted(LEFT,RIGHT),LEFT OUTER,HASH,HINT(parallel_match));
 
J_address_BestCompanyAddressVotedUnrestricted do_computes(J_address_BestCompanyAddressVotedUnrestricted le) := TRANSFORM
  SELF.address := IF (Fields.InValid_address((SALT30.StrType)le.prim_range,(SALT30.StrType)le.predir,(SALT30.StrType)le.prim_name,(SALT30.StrType)le.addr_suffix,(SALT30.StrType)le.postdir,(SALT30.StrType)le.unit_desig,(SALT30.StrType)le.sec_range,(SALT30.StrType)le.st,(SALT30.StrType)le.zip),0,HASH32((SALT30.StrType)le.prim_range,(SALT30.StrType)le.predir,(SALT30.StrType)le.prim_name,(SALT30.StrType)le.addr_suffix,(SALT30.StrType)le.postdir,(SALT30.StrType)le.unit_desig,(SALT30.StrType)le.sec_range,(SALT30.StrType)le.st,(SALT30.StrType)le.zip)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
SHARED propogated := PROJECT(J_address_BestCompanyAddressVotedUnrestricted,do_computes(left)) : PERSIST('~temp::Proxid::BIPV2_Best_Proxid::mc_props::Base',EXPIRE(Config.PersistExpire)); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 company_name_pop := AVE(GROUP,IF(propogated.company_name IN SET(s.nulls_company_name,company_name),0,100));
  REAL8 company_name_method_1 := AVE(GROUP,IF(propogated.company_name_prop_method = 1, 100, 0));
  REAL8 company_name_method_2 := AVE(GROUP,IF(propogated.company_name_prop_method = 2, 100, 0));
  REAL8 company_name_method_3 := AVE(GROUP,IF(propogated.company_name_prop_method = 3, 100, 0));
  REAL8 company_name_method_4 := AVE(GROUP,IF(propogated.company_name_prop_method = 4, 100, 0));
  REAL8 company_name_method_5 := AVE(GROUP,IF(propogated.company_name_prop_method = 5, 100, 0));
  REAL8 company_name_method_6 := AVE(GROUP,IF(propogated.company_name_prop_method = 6, 100, 0));
  REAL8 company_name_method_7 := AVE(GROUP,IF(propogated.company_name_prop_method = 7, 100, 0));
  REAL8 company_name_method_8 := AVE(GROUP,IF(propogated.company_name_prop_method = 8, 100, 0));
  REAL8 company_fein_pop := AVE(GROUP,IF(propogated.company_fein IN SET(s.nulls_company_fein,company_fein),0,100));
  REAL8 company_fein_method_1 := AVE(GROUP,IF(propogated.company_fein_prop_method = 1, 100, 0));
  REAL8 company_fein_method_2 := AVE(GROUP,IF(propogated.company_fein_prop_method = 2, 100, 0));
  REAL8 company_fein_method_3 := AVE(GROUP,IF(propogated.company_fein_prop_method = 3, 100, 0));
  REAL8 company_fein_method_4 := AVE(GROUP,IF(propogated.company_fein_prop_method = 4, 100, 0));
  REAL8 company_fein_method_5 := AVE(GROUP,IF(propogated.company_fein_prop_method = 5, 100, 0));
  REAL8 company_fein_method_6 := AVE(GROUP,IF(propogated.company_fein_prop_method = 6, 100, 0));
  REAL8 company_phone_pop := AVE(GROUP,IF(propogated.company_phone IN SET(s.nulls_company_phone,company_phone),0,100));
  REAL8 company_phone_method_1 := AVE(GROUP,IF(propogated.company_phone_prop_method = 1, 100, 0));
  REAL8 company_phone_method_2 := AVE(GROUP,IF(propogated.company_phone_prop_method = 2, 100, 0));
  REAL8 company_phone_method_3 := AVE(GROUP,IF(propogated.company_phone_prop_method = 3, 100, 0));
  REAL8 company_phone_method_4 := AVE(GROUP,IF(propogated.company_phone_prop_method = 4, 100, 0));
  REAL8 company_phone_method_5 := AVE(GROUP,IF(propogated.company_phone_prop_method = 5, 100, 0));
  REAL8 company_phone_method_6 := AVE(GROUP,IF(propogated.company_phone_prop_method = 6, 100, 0));
  REAL8 company_phone_method_7 := AVE(GROUP,IF(propogated.company_phone_prop_method = 7, 100, 0));
  REAL8 company_url_pop := AVE(GROUP,IF(propogated.company_url IN SET(s.nulls_company_url,company_url),0,100));
  REAL8 company_url_method_1 := AVE(GROUP,IF(propogated.company_url_prop_method = 1, 100, 0));
  REAL8 company_url_method_2 := AVE(GROUP,IF(propogated.company_url_prop_method = 2, 100, 0));
  REAL8 company_url_method_3 := AVE(GROUP,IF(propogated.company_url_prop_method = 3, 100, 0));
  REAL8 company_url_method_4 := AVE(GROUP,IF(propogated.company_url_prop_method = 4, 100, 0));
  REAL8 company_url_method_5 := AVE(GROUP,IF(propogated.company_url_prop_method = 5, 100, 0));
  REAL8 duns_number_pop := AVE(GROUP,IF(propogated.duns_number IN SET(s.nulls_duns_number,duns_number),0,100));
  REAL8 duns_number_method_1 := AVE(GROUP,IF(propogated.duns_number_prop_method = 1, 100, 0));
  REAL8 duns_number_method_2 := AVE(GROUP,IF(propogated.duns_number_prop_method = 2, 100, 0));
  REAL8 duns_number_method_3 := AVE(GROUP,IF(propogated.duns_number_prop_method = 3, 100, 0));
  REAL8 duns_number_method_4 := AVE(GROUP,IF(propogated.duns_number_prop_method = 4, 100, 0));
  REAL8 company_sic_code1_pop := AVE(GROUP,IF(propogated.company_sic_code1 IN SET(s.nulls_company_sic_code1,company_sic_code1),0,100));
  REAL8 company_sic_code1_method_1 := AVE(GROUP,IF(propogated.company_sic_code1_prop_method = 1, 100, 0));
  REAL8 company_sic_code1_method_2 := AVE(GROUP,IF(propogated.company_sic_code1_prop_method = 2, 100, 0));
  REAL8 company_naics_code1_pop := AVE(GROUP,IF(propogated.company_naics_code1 IN SET(s.nulls_company_naics_code1,company_naics_code1),0,100));
  REAL8 company_naics_code1_method_1 := AVE(GROUP,IF(propogated.company_naics_code1_prop_method = 1, 100, 0));
  REAL8 company_naics_code1_method_2 := AVE(GROUP,IF(propogated.company_naics_code1_prop_method = 2, 100, 0));
  REAL8 dba_name_pop := AVE(GROUP,IF(propogated.dba_name IN SET(s.nulls_dba_name,dba_name),0,100));
  REAL8 dba_name_method_1 := AVE(GROUP,IF(propogated.dba_name_prop_method = 1, 100, 0));
  REAL8 dba_name_method_2 := AVE(GROUP,IF(propogated.dba_name_prop_method = 2, 100, 0));
  REAL8 dba_name_method_3 := AVE(GROUP,IF(propogated.dba_name_prop_method = 3, 100, 0));
  REAL8 dba_name_method_4 := AVE(GROUP,IF(propogated.dba_name_prop_method = 4, 100, 0));
  REAL8 dba_name_method_5 := AVE(GROUP,IF(propogated.dba_name_prop_method = 5, 100, 0));
  REAL8 dba_name_method_6 := AVE(GROUP,IF(propogated.dba_name_prop_method = 6, 100, 0));
  REAL8 dba_name_method_7 := AVE(GROUP,IF(propogated.dba_name_prop_method = 7, 100, 0));
  REAL8 dba_name_method_8 := AVE(GROUP,IF(propogated.dba_name_prop_method = 8, 100, 0));
  REAL8 prim_range_pop := AVE(GROUP,IF(propogated.prim_range IN SET(s.nulls_prim_range,prim_range),0,100));
  REAL8 predir_pop := AVE(GROUP,IF(propogated.predir IN SET(s.nulls_predir,predir),0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF(propogated.prim_name IN SET(s.nulls_prim_name,prim_name),0,100));
  REAL8 addr_suffix_pop := AVE(GROUP,IF(propogated.addr_suffix IN SET(s.nulls_addr_suffix,addr_suffix),0,100));
  REAL8 postdir_pop := AVE(GROUP,IF(propogated.postdir IN SET(s.nulls_postdir,postdir),0,100));
  REAL8 unit_desig_pop := AVE(GROUP,IF(propogated.unit_desig IN SET(s.nulls_unit_desig,unit_desig),0,100));
  REAL8 sec_range_pop := AVE(GROUP,IF(propogated.sec_range IN SET(s.nulls_sec_range,sec_range),0,100));
  REAL8 p_city_name_pop := AVE(GROUP,IF(propogated.p_city_name IN SET(s.nulls_p_city_name,p_city_name),0,100));
  REAL8 v_city_name_pop := AVE(GROUP,IF(propogated.v_city_name IN SET(s.nulls_v_city_name,v_city_name),0,100));
  REAL8 st_pop := AVE(GROUP,IF(propogated.st IN SET(s.nulls_st,st),0,100));
  REAL8 zip_pop := AVE(GROUP,IF(propogated.zip IN SET(s.nulls_zip,zip),0,100));
  REAL8 zip4_pop := AVE(GROUP,IF(propogated.zip4 IN SET(s.nulls_zip4,zip4),0,100));
  REAL8 fips_state_pop := AVE(GROUP,IF(propogated.fips_state IN SET(s.nulls_fips_state,fips_state),0,100));
  REAL8 fips_county_pop := AVE(GROUP,IF(propogated.fips_county IN SET(s.nulls_fips_county,fips_county),0,100));
  REAL8 address_pop := AVE(GROUP,IF(propogated.address IN SET(s.nulls_address,address),0,100));
  REAL8 address_method_1 := AVE(GROUP,IF(propogated.address_prop_method = 1, 100, 0));
  REAL8 address_method_2 := AVE(GROUP,IF(propogated.address_prop_method = 2, 100, 0));
  REAL8 address_method_3 := AVE(GROUP,IF(propogated.address_prop_method = 3, 100, 0));
  REAL8 address_method_4 := AVE(GROUP,IF(propogated.address_prop_method = 4, 100, 0));
  REAL8 address_method_5 := AVE(GROUP,IF(propogated.address_prop_method = 5, 100, 0));
  REAL8 address_method_6 := AVE(GROUP,IF(propogated.address_prop_method = 6, 100, 0));
  REAL8 address_method_7 := AVE(GROUP,IF(propogated.address_prop_method = 7, 100, 0));
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
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0};
  INTEGER2 company_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_name_isnull := h0.company_name  IN SET(s.nulls_company_name,company_name); // Simplify later processing 
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
  INTEGER2 duns_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN duns_number_isnull := h0.duns_number  IN SET(s.nulls_duns_number,duns_number); // Simplify later processing 
  UNSIGNED duns_number_cnt := 0; // Number of instances with this particular field value
  UNSIGNED duns_number_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 company_sic_code1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_sic_code1_isnull := h0.company_sic_code1  IN SET(s.nulls_company_sic_code1,company_sic_code1); // Simplify later processing 
  INTEGER2 company_naics_code1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_naics_code1_isnull := h0.company_naics_code1  IN SET(s.nulls_company_naics_code1,company_naics_code1); // Simplify later processing 
  INTEGER2 dba_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN dba_name_isnull := h0.dba_name  IN SET(s.nulls_dba_name,dba_name); // Simplify later processing 
  INTEGER2 prim_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_isnull := h0.prim_range  IN SET(s.nulls_prim_range,prim_range); // Simplify later processing 
  INTEGER2 predir_weight100 := 0; // Contains 100x the specificity
  BOOLEAN predir_isnull := h0.predir  IN SET(s.nulls_predir,predir); // Simplify later processing 
  INTEGER2 prim_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_isnull := h0.prim_name  IN SET(s.nulls_prim_name,prim_name); // Simplify later processing 
  INTEGER2 addr_suffix_weight100 := 0; // Contains 100x the specificity
  BOOLEAN addr_suffix_isnull := h0.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix); // Simplify later processing 
  INTEGER2 postdir_weight100 := 0; // Contains 100x the specificity
  BOOLEAN postdir_isnull := h0.postdir  IN SET(s.nulls_postdir,postdir); // Simplify later processing 
  INTEGER2 unit_desig_weight100 := 0; // Contains 100x the specificity
  BOOLEAN unit_desig_isnull := h0.unit_desig  IN SET(s.nulls_unit_desig,unit_desig); // Simplify later processing 
  INTEGER2 sec_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sec_range_isnull := h0.sec_range  IN SET(s.nulls_sec_range,sec_range); // Simplify later processing 
  INTEGER2 p_city_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN p_city_name_isnull := h0.p_city_name  IN SET(s.nulls_p_city_name,p_city_name); // Simplify later processing 
  INTEGER2 v_city_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN v_city_name_isnull := h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name); // Simplify later processing 
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := h0.st  IN SET(s.nulls_st,st); // Simplify later processing 
  INTEGER2 zip_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip_isnull := h0.zip  IN SET(s.nulls_zip,zip); // Simplify later processing 
  INTEGER2 zip4_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip4_isnull := h0.zip4  IN SET(s.nulls_zip4,zip4); // Simplify later processing 
  INTEGER2 fips_state_weight100 := 0; // Contains 100x the specificity
  BOOLEAN fips_state_isnull := h0.fips_state  IN SET(s.nulls_fips_state,fips_state); // Simplify later processing 
  INTEGER2 fips_county_weight100 := 0; // Contains 100x the specificity
  BOOLEAN fips_county_isnull := h0.fips_county  IN SET(s.nulls_fips_county,fips_county); // Simplify later processing 
  INTEGER2 address_weight100 := 0; // Contains 100x the specificity
  BOOLEAN address_isnull := (h0.prim_range  IN SET(s.nulls_prim_range,prim_range) AND h0.predir  IN SET(s.nulls_predir,predir) AND h0.prim_name  IN SET(s.nulls_prim_name,prim_name) AND h0.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND h0.postdir  IN SET(s.nulls_postdir,postdir) AND h0.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND h0.sec_range  IN SET(s.nulls_sec_range,sec_range) AND h0.st  IN SET(s.nulls_st,st) AND h0.zip  IN SET(s.nulls_zip,zip)); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
 
//Would also create auto-id fields here
 
layout_candidates add_addr_suffix(layout_candidates le,Specificities(ih).addr_suffix_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.addr_suffix_weight100 := MAP (le.addr_suffix_isnull => 0, patch_default and ri.field_specificity=0 => s.addr_suffix_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j22 := JOIN(h1,PULL(Specificities(ih).addr_suffix_values_persisted),LEFT.addr_suffix=RIGHT.addr_suffix,add_addr_suffix(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_fips_state(layout_candidates le,Specificities(ih).fips_state_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.fips_state_weight100 := MAP (le.fips_state_isnull => 0, patch_default and ri.field_specificity=0 => s.fips_state_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j21 := JOIN(j22,PULL(Specificities(ih).fips_state_values_persisted),LEFT.fips_state=RIGHT.fips_state,add_fips_state(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_st(layout_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j20 := JOIN(j21,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_st(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_unit_desig(layout_candidates le,Specificities(ih).unit_desig_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.unit_desig_weight100 := MAP (le.unit_desig_isnull => 0, patch_default and ri.field_specificity=0 => s.unit_desig_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j19 := JOIN(j20,PULL(Specificities(ih).unit_desig_values_persisted),LEFT.unit_desig=RIGHT.unit_desig,add_unit_desig(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_predir(layout_candidates le,Specificities(ih).predir_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.predir_weight100 := MAP (le.predir_isnull => 0, patch_default and ri.field_specificity=0 => s.predir_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j18 := JOIN(j19,PULL(Specificities(ih).predir_values_persisted),LEFT.predir=RIGHT.predir,add_predir(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_fips_county(layout_candidates le,Specificities(ih).fips_county_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.fips_county_weight100 := MAP (le.fips_county_isnull => 0, patch_default and ri.field_specificity=0 => s.fips_county_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j17 := JOIN(j18,PULL(Specificities(ih).fips_county_values_persisted),LEFT.fips_county=RIGHT.fips_county,add_fips_county(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_postdir(layout_candidates le,Specificities(ih).postdir_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.postdir_weight100 := MAP (le.postdir_isnull => 0, patch_default and ri.field_specificity=0 => s.postdir_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j16 := JOIN(j17,PULL(Specificities(ih).postdir_values_persisted),LEFT.postdir=RIGHT.postdir,add_postdir(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_v_city_name(layout_candidates le,Specificities(ih).v_city_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.v_city_name_weight100 := MAP (le.v_city_name_isnull => 0, patch_default and ri.field_specificity=0 => s.v_city_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j16,s.nulls_v_city_name,Specificities(ih).v_city_name_values_persisted,v_city_name,v_city_name_weight100,add_v_city_name,j15);
layout_candidates add_company_naics_code1(layout_candidates le,Specificities(ih).company_naics_code1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_naics_code1_weight100 := MAP (le.company_naics_code1_isnull => 0, patch_default and ri.field_specificity=0 => s.company_naics_code1_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j15,s.nulls_company_naics_code1,Specificities(ih).company_naics_code1_values_persisted,company_naics_code1,company_naics_code1_weight100,add_company_naics_code1,j14);
layout_candidates add_company_sic_code1(layout_candidates le,Specificities(ih).company_sic_code1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_sic_code1_weight100 := MAP (le.company_sic_code1_isnull => 0, patch_default and ri.field_specificity=0 => s.company_sic_code1_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j14,s.nulls_company_sic_code1,Specificities(ih).company_sic_code1_values_persisted,company_sic_code1,company_sic_code1_weight100,add_company_sic_code1,j13);
layout_candidates add_p_city_name(layout_candidates le,Specificities(ih).p_city_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.p_city_name_weight100 := MAP (le.p_city_name_isnull => 0, patch_default and ri.field_specificity=0 => s.p_city_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j13,s.nulls_p_city_name,Specificities(ih).p_city_name_values_persisted,p_city_name,p_city_name_weight100,add_p_city_name,j12);
layout_candidates add_sec_range(layout_candidates le,Specificities(ih).sec_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sec_range_weight100 := MAP (le.sec_range_isnull => 0, patch_default and ri.field_specificity=0 => s.sec_range_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j12,s.nulls_sec_range,Specificities(ih).sec_range_values_persisted,sec_range,sec_range_weight100,add_sec_range,j11);
layout_candidates add_zip4(layout_candidates le,Specificities(ih).zip4_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip4_weight100 := MAP (le.zip4_isnull => 0, patch_default and ri.field_specificity=0 => s.zip4_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j11,s.nulls_zip4,Specificities(ih).zip4_values_persisted,zip4,zip4_weight100,add_zip4,j10);
layout_candidates add_prim_range(layout_candidates le,Specificities(ih).prim_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_weight100 := MAP (le.prim_range_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j10,s.nulls_prim_range,Specificities(ih).prim_range_values_persisted,prim_range,prim_range_weight100,add_prim_range,j9);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip_weight100 := MAP (le.zip_isnull => 0, patch_default and ri.field_specificity=0 => s.zip_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j9,s.nulls_zip,Specificities(ih).zip_values_persisted,zip,zip_weight100,add_zip,j8);
layout_candidates add_prim_name(layout_candidates le,Specificities(ih).prim_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_weight100 := MAP (le.prim_name_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j8,s.nulls_prim_name,Specificities(ih).prim_name_values_persisted,prim_name,prim_name_weight100,add_prim_name,j7);
layout_candidates add_address(layout_candidates le,Specificities(ih).address_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.address_weight100 := MAP (le.address_isnull => 0, patch_default and ri.field_specificity=0 => s.address_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j7,s.nulls_address,Specificities(ih).address_values_persisted,address,address_weight100,add_address,j6);
layout_candidates add_dba_name(layout_candidates le,Specificities(ih).dba_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dba_name_weight100 := MAP (le.dba_name_isnull => 0, patch_default and ri.field_specificity=0 => s.dba_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j6,s.nulls_dba_name,Specificities(ih).dba_name_values_persisted,dba_name,dba_name_weight100,add_dba_name,j5);
layout_candidates add_company_phone(layout_candidates le,Specificities(ih).company_phone_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_phone_cnt := ri.cnt;
  SELF.company_phone_e1_cnt := ri.e1_cnt;
  SELF.company_phone_weight100 := MAP (le.company_phone_isnull => 0, patch_default and ri.field_specificity=0 => s.company_phone_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j5,s.nulls_company_phone,Specificities(ih).company_phone_values_persisted,company_phone,company_phone_weight100,add_company_phone,j4);
layout_candidates add_company_fein(layout_candidates le,Specificities(ih).company_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_fein_cnt := ri.cnt;
  SELF.company_fein_e1_cnt := ri.e1_cnt;
  SELF.company_fein_Right4_cnt := ri.Right4_cnt; // Copy in count of matching Right4 values for field company_fein
  SELF.company_fein_Right4 := ri.company_fein_Right4; // Copy Right4 value for field company_fein
  SELF.company_fein_weight100 := MAP (le.company_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.company_fein_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j4,s.nulls_company_fein,Specificities(ih).company_fein_values_persisted,company_fein,company_fein_weight100,add_company_fein,j3);
layout_candidates add_company_name(layout_candidates le,Specificities(ih).company_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_name_weight100 := MAP (le.company_name_isnull => 0, patch_default and ri.field_specificity=0 => s.company_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j3,s.nulls_company_name,Specificities(ih).company_name_values_persisted,company_name,company_name_weight100,add_company_name,j2);
layout_candidates add_duns_number(layout_candidates le,Specificities(ih).duns_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.duns_number_cnt := ri.cnt;
  SELF.duns_number_e1_cnt := ri.e1_cnt;
  SELF.duns_number_weight100 := MAP (le.duns_number_isnull => 0, patch_default and ri.field_specificity=0 => s.duns_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j2,s.nulls_duns_number,Specificities(ih).duns_number_values_persisted,duns_number,duns_number_weight100,add_duns_number,j1);
layout_candidates add_company_url(layout_candidates le,Specificities(ih).company_url_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_url_weight100 := MAP (le.company_url_isnull => 0, patch_default and ri.field_specificity=0 => s.company_url_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j1,s.nulls_company_url,Specificities(ih).company_url_values_persisted,company_url,company_url_weight100,add_company_url,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(Proxid)) : PERSIST('~temp::Proxid::BIPV2_Best_Proxid::mc',EXPIRE(Config.PersistExpire)); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.company_url_weight100 + Annotated.duns_number_weight100 + Annotated.company_name_weight100 + Annotated.company_fein_weight100 + Annotated.company_phone_weight100 + Annotated.dba_name_weight100 + Annotated.address_weight100 + Annotated.zip4_weight100 + Annotated.p_city_name_weight100 + Annotated.company_sic_code1_weight100 + Annotated.company_naics_code1_weight100 + Annotated.v_city_name_weight100 + Annotated.fips_county_weight100 + Annotated.fips_state_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
