IMPORT SALT311;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_Address_Link;
EXPORT DID_ChildRec := RECORD
  TYPEOF(l.DID) DID;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT prim_range_alpha_ChildRec := RECORD
  TYPEOF(l.prim_range_alpha) prim_range_alpha;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT prim_range_num_ChildRec := RECORD
  TYPEOF(l.prim_range_num) prim_range_num;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT prim_range_fract_ChildRec := RECORD
  TYPEOF(l.prim_range_fract) prim_range_fract;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT prim_name_num_ChildRec := RECORD
  TYPEOF(l.prim_name_num) prim_name_num;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT prim_name_alpha_ChildRec := RECORD
  TYPEOF(l.prim_name_alpha) prim_name_alpha;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT sec_range_alpha_ChildRec := RECORD
  TYPEOF(l.sec_range_alpha) sec_range_alpha;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT sec_range_num_ChildRec := RECORD
  TYPEOF(l.sec_range_num) sec_range_num;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT city_ChildRec := RECORD
  TYPEOF(l.city) city;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT st_ChildRec := RECORD
  TYPEOF(l.st) st;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT zip_ChildRec := RECORD
  TYPEOF(l.zip) zip;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT addr_ChildRec := RECORD
  UNSIGNED4 addr;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT locale_ChildRec := RECORD
  UNSIGNED4 locale;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT Uber_ChildRec := RECORD
  SALT311.Str30Type word;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  REAL4 DID_specificity;
  REAL4 DID_switch;
  REAL4 DID_maximum;
  DATASET(DID_ChildRec) nulls_DID {MAXCOUNT(100)};
  REAL4 prim_range_alpha_specificity;
  REAL4 prim_range_alpha_switch;
  REAL4 prim_range_alpha_maximum;
  DATASET(prim_range_alpha_ChildRec) nulls_prim_range_alpha {MAXCOUNT(100)};
  REAL4 prim_range_num_specificity;
  REAL4 prim_range_num_switch;
  REAL4 prim_range_num_maximum;
  DATASET(prim_range_num_ChildRec) nulls_prim_range_num {MAXCOUNT(100)};
  REAL4 prim_range_fract_specificity;
  REAL4 prim_range_fract_switch;
  REAL4 prim_range_fract_maximum;
  DATASET(prim_range_fract_ChildRec) nulls_prim_range_fract {MAXCOUNT(100)};
  REAL4 prim_name_num_specificity;
  REAL4 prim_name_num_switch;
  REAL4 prim_name_num_maximum;
  DATASET(prim_name_num_ChildRec) nulls_prim_name_num {MAXCOUNT(100)};
  REAL4 prim_name_alpha_specificity;
  REAL4 prim_name_alpha_switch;
  REAL4 prim_name_alpha_maximum;
  DATASET(prim_name_alpha_ChildRec) nulls_prim_name_alpha {MAXCOUNT(100)};
  REAL4 sec_range_alpha_specificity;
  REAL4 sec_range_alpha_switch;
  REAL4 sec_range_alpha_maximum;
  DATASET(sec_range_alpha_ChildRec) nulls_sec_range_alpha {MAXCOUNT(100)};
  REAL4 sec_range_num_specificity;
  REAL4 sec_range_num_switch;
  REAL4 sec_range_num_maximum;
  DATASET(sec_range_num_ChildRec) nulls_sec_range_num {MAXCOUNT(100)};
  REAL4 city_specificity;
  REAL4 city_switch;
  REAL4 city_maximum;
  DATASET(city_ChildRec) nulls_city {MAXCOUNT(100)};
  REAL4 st_specificity;
  REAL4 st_switch;
  REAL4 st_maximum;
  DATASET(st_ChildRec) nulls_st {MAXCOUNT(100)};
  REAL4 zip_specificity;
  REAL4 zip_switch;
  REAL4 zip_maximum;
  DATASET(zip_ChildRec) nulls_zip {MAXCOUNT(100)};
  REAL4 addr_specificity;
  REAL4 addr_switch;
  REAL4 addr_maximum;
  DATASET(addr_ChildRec) nulls_addr {MAXCOUNT(100)};
  REAL4 locale_specificity;
  REAL4 locale_switch;
  REAL4 locale_maximum;
  DATASET(locale_ChildRec) nulls_locale {MAXCOUNT(100)};
  REAL4 uber_specificity;
  REAL4 uber_switch;
  REAL4 uber_maximum;
  DATASET(Uber_ChildRec) nulls_uber {MAXCOUNT(100)};
END;
END;
