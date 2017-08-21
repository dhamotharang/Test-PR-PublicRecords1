export Layout_Specificities := module
shared L := layout_as_bh;
export rcid_ChildRec := record
  typeof(l.rcid) rcid;
  unsigned8 cnt;
  unsigned4 id;
end;
export bdid_ChildRec := record
  typeof(l.bdid) bdid;
  unsigned8 cnt;
  unsigned4 id;
end;
export source_ChildRec := record
  typeof(l.source) source;
  unsigned8 cnt;
  unsigned4 id;
end;
export source_group_ChildRec := record
  typeof(l.source_group) source_group;
  unsigned8 cnt;
  unsigned4 id;
end;
export pflag_ChildRec := record
  typeof(l.pflag) pflag;
  unsigned8 cnt;
  unsigned4 id;
end;
export group1_id_ChildRec := record
  typeof(l.group1_id) group1_id;
  unsigned8 cnt;
  unsigned4 id;
end;
export vendor_id_ChildRec := record
  typeof(l.vendor_id) vendor_id;
  unsigned8 cnt;
  unsigned4 id;
end;
export dt_first_seen_ChildRec := record
  typeof(l.dt_first_seen) dt_first_seen;
  unsigned8 cnt;
  unsigned4 id;
end;
export dt_last_seen_ChildRec := record
  typeof(l.dt_last_seen) dt_last_seen;
  unsigned8 cnt;
  unsigned4 id;
end;
export dt_vendor_first_reported_ChildRec := record
  typeof(l.dt_vendor_first_reported) dt_vendor_first_reported;
  unsigned8 cnt;
  unsigned4 id;
end;
export dt_vendor_last_reported_ChildRec := record
  typeof(l.dt_vendor_last_reported) dt_vendor_last_reported;
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
export city_ChildRec := record
  typeof(l.city) city;
  unsigned8 cnt;
  unsigned4 id;
end;
export state_ChildRec := record
  typeof(l.state) state;
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
export county_ChildRec := record
  typeof(l.county) county;
  unsigned8 cnt;
  unsigned4 id;
end;
export msa_ChildRec := record
  typeof(l.msa) msa;
  unsigned8 cnt;
  unsigned4 id;
end;
export geo_lat_ChildRec := record
  typeof(l.geo_lat) geo_lat;
  unsigned8 cnt;
  unsigned4 id;
end;
export geo_long_ChildRec := record
  typeof(l.geo_long) geo_long;
  unsigned8 cnt;
  unsigned4 id;
end;
export phone_ChildRec := record
  typeof(l.phone) phone;
  unsigned8 cnt;
  unsigned4 id;
end;
export phone_score_ChildRec := record
  typeof(l.phone_score) phone_score;
  unsigned8 cnt;
  unsigned4 id;
end;
export fein_ChildRec := record
  typeof(l.fein) fein;
  unsigned8 cnt;
  unsigned4 id;
end;
export current_ChildRec := record
  typeof(l.current) current;
  unsigned8 cnt;
  unsigned4 id;
end;
export dppa_ChildRec := record
  typeof(l.dppa) dppa;
  unsigned8 cnt;
  unsigned4 id;
end;
export vl_id_ChildRec := record
  typeof(l.vl_id) vl_id;
  unsigned8 cnt;
  unsigned4 id;
end;
export RawAID_ChildRec := record
  typeof(l.RawAID) RawAID;
  unsigned8 cnt;
  unsigned4 id;
end;
export R := RECORD,MAXLENGTH(32000)
 unsigned1 dummy;
  real4 rcid_specificity;
  real4 rcid_switch;
  real4 rcid_max;
  dataset(rcid_ChildRec) nulls_rcid {MAXCOUNT(100)};
  real4 bdid_specificity;
  real4 bdid_switch;
  real4 bdid_max;
  dataset(bdid_ChildRec) nulls_bdid {MAXCOUNT(100)};
  real4 source_specificity;
  real4 source_switch;
  real4 source_max;
  dataset(source_ChildRec) nulls_source {MAXCOUNT(100)};
  real4 source_group_specificity;
  real4 source_group_switch;
  real4 source_group_max;
  dataset(source_group_ChildRec) nulls_source_group {MAXCOUNT(100)};
  real4 pflag_specificity;
  real4 pflag_switch;
  real4 pflag_max;
  dataset(pflag_ChildRec) nulls_pflag {MAXCOUNT(100)};
  real4 group1_id_specificity;
  real4 group1_id_switch;
  real4 group1_id_max;
  dataset(group1_id_ChildRec) nulls_group1_id {MAXCOUNT(100)};
  real4 vendor_id_specificity;
  real4 vendor_id_switch;
  real4 vendor_id_max;
  dataset(vendor_id_ChildRec) nulls_vendor_id {MAXCOUNT(100)};
  real4 dt_first_seen_specificity;
  real4 dt_first_seen_switch;
  real4 dt_first_seen_max;
  dataset(dt_first_seen_ChildRec) nulls_dt_first_seen {MAXCOUNT(100)};
  real4 dt_last_seen_specificity;
  real4 dt_last_seen_switch;
  real4 dt_last_seen_max;
  dataset(dt_last_seen_ChildRec) nulls_dt_last_seen {MAXCOUNT(100)};
  real4 dt_vendor_first_reported_specificity;
  real4 dt_vendor_first_reported_switch;
  real4 dt_vendor_first_reported_max;
  dataset(dt_vendor_first_reported_ChildRec) nulls_dt_vendor_first_reported {MAXCOUNT(100)};
  real4 dt_vendor_last_reported_specificity;
  real4 dt_vendor_last_reported_switch;
  real4 dt_vendor_last_reported_max;
  dataset(dt_vendor_last_reported_ChildRec) nulls_dt_vendor_last_reported {MAXCOUNT(100)};
  real4 company_name_specificity;
  real4 company_name_switch;
  real4 company_name_max;
  dataset(company_name_ChildRec) nulls_company_name {MAXCOUNT(100)};
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
  real4 city_specificity;
  real4 city_switch;
  real4 city_max;
  dataset(city_ChildRec) nulls_city {MAXCOUNT(100)};
  real4 state_specificity;
  real4 state_switch;
  real4 state_max;
  dataset(state_ChildRec) nulls_state {MAXCOUNT(100)};
  real4 zip_specificity;
  real4 zip_switch;
  real4 zip_max;
  dataset(zip_ChildRec) nulls_zip {MAXCOUNT(100)};
  real4 zip4_specificity;
  real4 zip4_switch;
  real4 zip4_max;
  dataset(zip4_ChildRec) nulls_zip4 {MAXCOUNT(100)};
  real4 county_specificity;
  real4 county_switch;
  real4 county_max;
  dataset(county_ChildRec) nulls_county {MAXCOUNT(100)};
  real4 msa_specificity;
  real4 msa_switch;
  real4 msa_max;
  dataset(msa_ChildRec) nulls_msa {MAXCOUNT(100)};
  real4 geo_lat_specificity;
  real4 geo_lat_switch;
  real4 geo_lat_max;
  dataset(geo_lat_ChildRec) nulls_geo_lat {MAXCOUNT(100)};
  real4 geo_long_specificity;
  real4 geo_long_switch;
  real4 geo_long_max;
  dataset(geo_long_ChildRec) nulls_geo_long {MAXCOUNT(100)};
  real4 phone_specificity;
  real4 phone_switch;
  real4 phone_max;
  dataset(phone_ChildRec) nulls_phone {MAXCOUNT(100)};
  real4 phone_score_specificity;
  real4 phone_score_switch;
  real4 phone_score_max;
  dataset(phone_score_ChildRec) nulls_phone_score {MAXCOUNT(100)};
  real4 fein_specificity;
  real4 fein_switch;
  real4 fein_max;
  dataset(fein_ChildRec) nulls_fein {MAXCOUNT(100)};
  real4 current_specificity;
  real4 current_switch;
  real4 current_max;
  dataset(current_ChildRec) nulls_current {MAXCOUNT(100)};
  real4 dppa_specificity;
  real4 dppa_switch;
  real4 dppa_max;
  dataset(dppa_ChildRec) nulls_dppa {MAXCOUNT(100)};
  real4 vl_id_specificity;
  real4 vl_id_switch;
  real4 vl_id_max;
  dataset(vl_id_ChildRec) nulls_vl_id {MAXCOUNT(100)};
  real4 RawAID_specificity;
  real4 RawAID_switch;
  real4 RawAID_max;
  dataset(RawAID_ChildRec) nulls_RawAID {MAXCOUNT(100)};
end;
end;
