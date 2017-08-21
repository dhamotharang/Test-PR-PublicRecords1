export Layout_Specificities := module
shared L := Layout_file_business_header;
export fein_ChildRec := record
  typeof(l.fein) fein;
  unsigned8 cnt;
  unsigned4 id;
end;
export phone_ChildRec := record
  typeof(l.phone) phone;
  unsigned8 cnt;
  unsigned4 id;
end;
export vendor_id_ChildRec := record
  typeof(l.vendor_id) vendor_id;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_name_ChildRec := record
  typeof(l.company_name) company_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export prim_range_ChildRec := record
  typeof(l.prim_range) prim_range;
  unsigned8 cnt;
  unsigned4 id;
end;
export zip_ChildRec := record
  typeof(l.zip) zip;
  unsigned8 cnt;
  unsigned4 id;
end;
export sec_range_ChildRec := record
  typeof(l.sec_range) sec_range;
  unsigned8 cnt;
  unsigned4 id;
end;
export zip4_ChildRec := record
  typeof(l.zip4) zip4;
  unsigned8 cnt;
  unsigned4 id;
end;
export CITY_ChildRec := record
  typeof(l.CITY) CITY;
  unsigned8 cnt;
  unsigned4 id;
end;
export unit_desig_ChildRec := record
  typeof(l.unit_desig) unit_desig;
  unsigned8 cnt;
  unsigned4 id;
end;
export county_ChildRec := record
  typeof(l.county) county;
  unsigned8 cnt;
  unsigned4 id;
end;
export prim_name_ChildRec := record
  typeof(l.prim_name) prim_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export state_ChildRec := record
  typeof(l.state) state;
  unsigned8 cnt;
  unsigned4 id;
end;
export msa_ChildRec := record
  typeof(l.msa) msa;
  unsigned8 cnt;
  unsigned4 id;
end;
export SOURCE_ChildRec := record
  typeof(l.SOURCE) SOURCE;
  unsigned8 cnt;
  unsigned4 id;
end;
export addr_suffix_ChildRec := record
  typeof(l.addr_suffix) addr_suffix;
  unsigned8 cnt;
  unsigned4 id;
end;
export locale_ChildRec := record
  unsigned4 locale;
  unsigned8 cnt;
  unsigned4 id;
end;
export address_ChildRec := record
  unsigned4 address;
  unsigned8 cnt;
  unsigned4 id;
end;
export R := RECORD,MAXLENGTH(32000)
 unsigned1 dummy;
  real4 fein_specificity;
  real4 fein_switch;
  dataset(fein_ChildRec) nulls_fein;
  real4 phone_specificity;
  real4 phone_switch;
  dataset(phone_ChildRec) nulls_phone;
  real4 vendor_id_specificity;
  real4 vendor_id_switch;
  dataset(vendor_id_ChildRec) nulls_vendor_id;
  real4 company_name_specificity;
  real4 company_name_switch;
  dataset(company_name_ChildRec) nulls_company_name;
  real4 prim_range_specificity;
  real4 prim_range_switch;
  dataset(prim_range_ChildRec) nulls_prim_range;
  real4 zip_specificity;
  real4 zip_switch;
  dataset(zip_ChildRec) nulls_zip;
  real4 sec_range_specificity;
  real4 sec_range_switch;
  dataset(sec_range_ChildRec) nulls_sec_range;
  real4 zip4_specificity;
  real4 zip4_switch;
  dataset(zip4_ChildRec) nulls_zip4;
  real4 CITY_specificity;
  real4 CITY_switch;
  dataset(CITY_ChildRec) nulls_CITY;
  real4 unit_desig_specificity;
  real4 unit_desig_switch;
  dataset(unit_desig_ChildRec) nulls_unit_desig;
  real4 county_specificity;
  real4 county_switch;
  dataset(county_ChildRec) nulls_county;
  real4 prim_name_specificity;
  real4 prim_name_switch;
  dataset(prim_name_ChildRec) nulls_prim_name;
  real4 state_specificity;
  real4 state_switch;
  dataset(state_ChildRec) nulls_state;
  real4 msa_specificity;
  real4 msa_switch;
  dataset(msa_ChildRec) nulls_msa;
  real4 SOURCE_specificity;
  real4 SOURCE_switch;
  dataset(SOURCE_ChildRec) nulls_SOURCE;
  real4 addr_suffix_specificity;
  real4 addr_suffix_switch;
  dataset(addr_suffix_ChildRec) nulls_addr_suffix;
  real4 locale_specificity;
  real4 locale_switch;
  dataset(locale_ChildRec) nulls_locale;
  real4 address_specificity;
  real4 address_switch;
  dataset(address_ChildRec) nulls_address;
end;
end;
