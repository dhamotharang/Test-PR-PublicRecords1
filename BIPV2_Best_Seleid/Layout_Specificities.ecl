IMPORT SALT30;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_Base;
export company_name_ChildRec := record
  typeof(l.company_name) company_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_fein_ChildRec := record
  typeof(l.company_fein) company_fein;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_phone_ChildRec := record
  typeof(l.company_phone) company_phone;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_url_ChildRec := record
  typeof(l.company_url) company_url;
  unsigned8 cnt;
  unsigned4 id;
end;
export duns_number_ChildRec := record
  typeof(l.duns_number) duns_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_sic_code1_ChildRec := record
  typeof(l.company_sic_code1) company_sic_code1;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_naics_code1_ChildRec := record
  typeof(l.company_naics_code1) company_naics_code1;
  unsigned8 cnt;
  unsigned4 id;
end;
export prim_range_ChildRec := record
  typeof(l.prim_range) prim_range;
  unsigned8 cnt;
  unsigned4 id;
end;
export predir_ChildRec := record
  typeof(l.predir) predir;
  unsigned8 cnt;
  unsigned4 id;
end;
export prim_name_ChildRec := record
  typeof(l.prim_name) prim_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export addr_suffix_ChildRec := record
  typeof(l.addr_suffix) addr_suffix;
  unsigned8 cnt;
  unsigned4 id;
end;
export postdir_ChildRec := record
  typeof(l.postdir) postdir;
  unsigned8 cnt;
  unsigned4 id;
end;
export unit_desig_ChildRec := record
  typeof(l.unit_desig) unit_desig;
  unsigned8 cnt;
  unsigned4 id;
end;
export sec_range_ChildRec := record
  typeof(l.sec_range) sec_range;
  unsigned8 cnt;
  unsigned4 id;
end;
export p_city_name_ChildRec := record
  typeof(l.p_city_name) p_city_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export v_city_name_ChildRec := record
  typeof(l.v_city_name) v_city_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export st_ChildRec := record
  typeof(l.st) st;
  unsigned8 cnt;
  unsigned4 id;
end;
export zip_ChildRec := record
  typeof(l.zip) zip;
  unsigned8 cnt;
  unsigned4 id;
end;
export zip4_ChildRec := record
  typeof(l.zip4) zip4;
  unsigned8 cnt;
  unsigned4 id;
end;
export fips_state_ChildRec := record
  typeof(l.fips_state) fips_state;
  unsigned8 cnt;
  unsigned4 id;
end;
export fips_county_ChildRec := record
  typeof(l.fips_county) fips_county;
  unsigned8 cnt;
  unsigned4 id;
end;
export address_ChildRec := record
  UNSIGNED4 address;
  unsigned8 cnt;
  unsigned4 id;
end;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  real4 company_name_specificity;
  real4 company_name_switch;
  real4 company_name_max;
  dataset(company_name_ChildRec) nulls_company_name {MAXCOUNT(100)};
  real4 company_fein_specificity;
  real4 company_fein_switch;
  real4 company_fein_max;
  dataset(company_fein_ChildRec) nulls_company_fein {MAXCOUNT(100)};
  real4 company_phone_specificity;
  real4 company_phone_switch;
  real4 company_phone_max;
  dataset(company_phone_ChildRec) nulls_company_phone {MAXCOUNT(100)};
  real4 company_url_specificity;
  real4 company_url_switch;
  real4 company_url_max;
  dataset(company_url_ChildRec) nulls_company_url {MAXCOUNT(100)};
  real4 duns_number_specificity;
  real4 duns_number_switch;
  real4 duns_number_max;
  dataset(duns_number_ChildRec) nulls_duns_number {MAXCOUNT(100)};
  real4 company_sic_code1_specificity;
  real4 company_sic_code1_switch;
  real4 company_sic_code1_max;
  dataset(company_sic_code1_ChildRec) nulls_company_sic_code1 {MAXCOUNT(100)};
  real4 company_naics_code1_specificity;
  real4 company_naics_code1_switch;
  real4 company_naics_code1_max;
  dataset(company_naics_code1_ChildRec) nulls_company_naics_code1 {MAXCOUNT(100)};
  real4 prim_range_specificity;
  real4 prim_range_switch;
  real4 prim_range_max;
  dataset(prim_range_ChildRec) nulls_prim_range {MAXCOUNT(100)};
  real4 predir_specificity;
  real4 predir_switch;
  real4 predir_max;
  dataset(predir_ChildRec) nulls_predir {MAXCOUNT(100)};
  real4 prim_name_specificity;
  real4 prim_name_switch;
  real4 prim_name_max;
  dataset(prim_name_ChildRec) nulls_prim_name {MAXCOUNT(100)};
  real4 addr_suffix_specificity;
  real4 addr_suffix_switch;
  real4 addr_suffix_max;
  dataset(addr_suffix_ChildRec) nulls_addr_suffix {MAXCOUNT(100)};
  real4 postdir_specificity;
  real4 postdir_switch;
  real4 postdir_max;
  dataset(postdir_ChildRec) nulls_postdir {MAXCOUNT(100)};
  real4 unit_desig_specificity;
  real4 unit_desig_switch;
  real4 unit_desig_max;
  dataset(unit_desig_ChildRec) nulls_unit_desig {MAXCOUNT(100)};
  real4 sec_range_specificity;
  real4 sec_range_switch;
  real4 sec_range_max;
  dataset(sec_range_ChildRec) nulls_sec_range {MAXCOUNT(100)};
  real4 p_city_name_specificity;
  real4 p_city_name_switch;
  real4 p_city_name_max;
  dataset(p_city_name_ChildRec) nulls_p_city_name {MAXCOUNT(100)};
  real4 v_city_name_specificity;
  real4 v_city_name_switch;
  real4 v_city_name_max;
  dataset(v_city_name_ChildRec) nulls_v_city_name {MAXCOUNT(100)};
  real4 st_specificity;
  real4 st_switch;
  real4 st_max;
  dataset(st_ChildRec) nulls_st {MAXCOUNT(100)};
  real4 zip_specificity;
  real4 zip_switch;
  real4 zip_max;
  dataset(zip_ChildRec) nulls_zip {MAXCOUNT(100)};
  real4 zip4_specificity;
  real4 zip4_switch;
  real4 zip4_max;
  dataset(zip4_ChildRec) nulls_zip4 {MAXCOUNT(100)};
  real4 fips_state_specificity;
  real4 fips_state_switch;
  real4 fips_state_max;
  dataset(fips_state_ChildRec) nulls_fips_state {MAXCOUNT(100)};
  real4 fips_county_specificity;
  real4 fips_county_switch;
  real4 fips_county_max;
  dataset(fips_county_ChildRec) nulls_fips_county {MAXCOUNT(100)};
  real4 address_specificity;
  real4 address_switch;
  real4 address_max;
  dataset(address_ChildRec) nulls_address {MAXCOUNT(100)};
END;
END;