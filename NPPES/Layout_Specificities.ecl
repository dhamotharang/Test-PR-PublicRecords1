export Layout_Specificities := module
shared L := Layout_FileIN;
export did_ChildRec := record
  typeof(l.did) did;
  unsigned8 cnt;
  unsigned4 id;
end;
export src_ChildRec := record
  typeof(l.src) src;
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
export vendor_id_ChildRec := record
  typeof(l.vendor_id) vendor_id;
  unsigned8 cnt;
  unsigned4 id;
end;
export phone_ChildRec := record
  typeof(l.phone) phone;
  unsigned8 cnt;
  unsigned4 id;
end;
export title_ChildRec := record
  typeof(l.title) title;
  unsigned8 cnt;
  unsigned4 id;
end;
export fname_ChildRec := record
  typeof(l.fname) fname;
  unsigned8 cnt;
  unsigned4 id;
end;
export mname_ChildRec := record
  typeof(l.mname) mname;
  unsigned8 cnt;
  unsigned4 id;
end;
export lname_ChildRec := record
  typeof(l.lname) lname;
  unsigned8 cnt;
  unsigned4 id;
end;
export name_suffix_ChildRec := record
  typeof(l.name_suffix) name_suffix;
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
export suffix_ChildRec := record
  typeof(l.suffix) suffix;
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
export city_name_ChildRec := record
  typeof(l.city_name) city_name;
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
export geo_blk_ChildRec := record
  typeof(l.geo_blk) geo_blk;
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
  real4 did_specificity;
  real4 did_switch;
  real4 did_max;
  dataset(did_ChildRec) nulls_did {MAXCOUNT(100)};
  real4 src_specificity;
  real4 src_switch;
  real4 src_max;
  dataset(src_ChildRec) nulls_src {MAXCOUNT(100)};
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
  real4 vendor_id_specificity;
  real4 vendor_id_switch;
  real4 vendor_id_max;
  dataset(vendor_id_ChildRec) nulls_vendor_id {MAXCOUNT(100)};
  real4 phone_specificity;
  real4 phone_switch;
  real4 phone_max;
  dataset(phone_ChildRec) nulls_phone {MAXCOUNT(100)};
  real4 title_specificity;
  real4 title_switch;
  real4 title_max;
  dataset(title_ChildRec) nulls_title {MAXCOUNT(100)};
  real4 fname_specificity;
  real4 fname_switch;
  real4 fname_max;
  dataset(fname_ChildRec) nulls_fname {MAXCOUNT(100)};
  real4 mname_specificity;
  real4 mname_switch;
  real4 mname_max;
  dataset(mname_ChildRec) nulls_mname {MAXCOUNT(100)};
  real4 lname_specificity;
  real4 lname_switch;
  real4 lname_max;
  dataset(lname_ChildRec) nulls_lname {MAXCOUNT(100)};
  real4 name_suffix_specificity;
  real4 name_suffix_switch;
  real4 name_suffix_max;
  dataset(name_suffix_ChildRec) nulls_name_suffix {MAXCOUNT(100)};
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
  real4 suffix_specificity;
  real4 suffix_switch;
  real4 suffix_max;
  dataset(suffix_ChildRec) nulls_suffix {MAXCOUNT(100)};
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
  real4 city_name_specificity;
  real4 city_name_switch;
  real4 city_name_max;
  dataset(city_name_ChildRec) nulls_city_name {MAXCOUNT(100)};
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
  real4 county_specificity;
  real4 county_switch;
  real4 county_max;
  dataset(county_ChildRec) nulls_county {MAXCOUNT(100)};
  real4 msa_specificity;
  real4 msa_switch;
  real4 msa_max;
  dataset(msa_ChildRec) nulls_msa {MAXCOUNT(100)};
  real4 geo_blk_specificity;
  real4 geo_blk_switch;
  real4 geo_blk_max;
  dataset(geo_blk_ChildRec) nulls_geo_blk {MAXCOUNT(100)};
  real4 RawAID_specificity;
  real4 RawAID_switch;
  real4 RawAID_max;
  dataset(RawAID_ChildRec) nulls_RawAID {MAXCOUNT(100)};
end;
end;
