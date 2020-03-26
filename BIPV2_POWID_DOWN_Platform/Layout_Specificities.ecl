IMPORT SALT27;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_POWID_Down;
export orgid_ChildRec := record
  typeof(l.orgid) orgid;
  unsigned8 cnt;
  unsigned4 id;
end;
export prim_range_ChildRec := record
  typeof(l.prim_range) prim_range;
  unsigned8 cnt;
  unsigned4 id;
end;
export prim_name_ChildRec := record
  typeof(l.prim_name) prim_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export st_ChildRec := record
  typeof(l.st) st;
  unsigned8 cnt;
  unsigned4 id;
end;
export v_city_name_ChildRec := record
  typeof(l.v_city_name) v_city_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export zip_ChildRec := record
  typeof(l.zip) zip;
  unsigned8 cnt;
  unsigned4 id;
end;
export csz_ChildRec := record
  UNSIGNED4 csz;
  unsigned8 cnt;
  unsigned4 id;
end;
export addr1_ChildRec := record
  UNSIGNED4 addr1;
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
  real4 orgid_specificity;
  real4 orgid_switch;
  real4 orgid_max;
  dataset(orgid_ChildRec) nulls_orgid {MAXCOUNT(100)};
  real4 prim_range_specificity;
  real4 prim_range_switch;
  real4 prim_range_max;
  dataset(prim_range_ChildRec) nulls_prim_range {MAXCOUNT(100)};
  real4 prim_name_specificity;
  real4 prim_name_switch;
  real4 prim_name_max;
  dataset(prim_name_ChildRec) nulls_prim_name {MAXCOUNT(100)};
  real4 st_specificity;
  real4 st_switch;
  real4 st_max;
  dataset(st_ChildRec) nulls_st {MAXCOUNT(100)};
  real4 v_city_name_specificity;
  real4 v_city_name_switch;
  real4 v_city_name_max;
  dataset(v_city_name_ChildRec) nulls_v_city_name {MAXCOUNT(100)};
  real4 zip_specificity;
  real4 zip_switch;
  real4 zip_max;
  dataset(zip_ChildRec) nulls_zip {MAXCOUNT(100)};
  real4 csz_specificity;
  real4 csz_switch;
  real4 csz_max;
  dataset(csz_ChildRec) nulls_csz {MAXCOUNT(100)};
  real4 addr1_specificity;
  real4 addr1_switch;
  real4 addr1_max;
  dataset(addr1_ChildRec) nulls_addr1 {MAXCOUNT(100)};
  real4 address_specificity;
  real4 address_switch;
  real4 address_max;
  dataset(address_ChildRec) nulls_address {MAXCOUNT(100)};
END;
END;
