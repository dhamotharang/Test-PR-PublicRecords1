IMPORT SALT35;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_POWID_Down;
EXPORT orgid_ChildRec := RECORD
  TYPEOF(l.orgid) orgid;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT prim_range_ChildRec := RECORD
  TYPEOF(l.prim_range) prim_range;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT prim_name_ChildRec := RECORD
  TYPEOF(l.prim_name) prim_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT st_ChildRec := RECORD
  TYPEOF(l.st) st;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT v_city_name_ChildRec := RECORD
  TYPEOF(l.v_city_name) v_city_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT zip_ChildRec := RECORD
  TYPEOF(l.zip) zip;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT csz_ChildRec := RECORD
  UNSIGNED4 csz;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT addr1_ChildRec := RECORD
  UNSIGNED4 addr1;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT address_ChildRec := RECORD
  UNSIGNED4 address;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT dt_first_seen_ChildRec := RECORD
  TYPEOF(l.dt_first_seen) dt_first_seen;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT dt_last_seen_ChildRec := RECORD
  TYPEOF(l.dt_last_seen) dt_last_seen;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  REAL4 orgid_specificity;
  REAL4 orgid_switch;
  REAL4 orgid_maximum;
  DATASET(orgid_ChildRec) nulls_orgid {MAXCOUNT(100)};
  REAL4 prim_range_specificity;
  REAL4 prim_range_switch;
  REAL4 prim_range_maximum;
  DATASET(prim_range_ChildRec) nulls_prim_range {MAXCOUNT(100)};
  REAL4 prim_name_specificity;
  REAL4 prim_name_switch;
  REAL4 prim_name_maximum;
  DATASET(prim_name_ChildRec) nulls_prim_name {MAXCOUNT(100)};
  REAL4 st_specificity;
  REAL4 st_switch;
  REAL4 st_maximum;
  DATASET(st_ChildRec) nulls_st {MAXCOUNT(100)};
  REAL4 v_city_name_specificity;
  REAL4 v_city_name_switch;
  REAL4 v_city_name_maximum;
  DATASET(v_city_name_ChildRec) nulls_v_city_name {MAXCOUNT(100)};
  REAL4 zip_specificity;
  REAL4 zip_switch;
  REAL4 zip_maximum;
  DATASET(zip_ChildRec) nulls_zip {MAXCOUNT(100)};
  REAL4 csz_specificity;
  REAL4 csz_switch;
  REAL4 csz_maximum;
  DATASET(csz_ChildRec) nulls_csz {MAXCOUNT(100)};
  REAL4 addr1_specificity;
  REAL4 addr1_switch;
  REAL4 addr1_maximum;
  DATASET(addr1_ChildRec) nulls_addr1 {MAXCOUNT(100)};
  REAL4 address_specificity;
  REAL4 address_switch;
  REAL4 address_maximum;
  DATASET(address_ChildRec) nulls_address {MAXCOUNT(100)};
  REAL4 dt_first_seen_specificity;
  REAL4 dt_first_seen_switch;
  REAL4 dt_first_seen_maximum;
  DATASET(dt_first_seen_ChildRec) nulls_dt_first_seen {MAXCOUNT(100)};
  REAL4 dt_last_seen_specificity;
  REAL4 dt_last_seen_switch;
  REAL4 dt_last_seen_maximum;
  DATASET(dt_last_seen_ChildRec) nulls_dt_last_seen {MAXCOUNT(100)};
END;
END;
