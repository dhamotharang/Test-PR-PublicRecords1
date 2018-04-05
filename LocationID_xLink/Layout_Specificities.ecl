IMPORT SALT37;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_LocationId;
EXPORT prim_range_ChildRec := RECORD
  TYPEOF(l.prim_range) prim_range;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT predir_ChildRec := RECORD
  TYPEOF(l.predir) predir;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT prim_name_ChildRec := RECORD
  TYPEOF(l.prim_name) prim_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT addr_suffix_ChildRec := RECORD
  TYPEOF(l.addr_suffix) addr_suffix;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT postdir_ChildRec := RECORD
  TYPEOF(l.postdir) postdir;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT unit_desig_ChildRec := RECORD
  TYPEOF(l.unit_desig) unit_desig;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT sec_range_ChildRec := RECORD
  TYPEOF(l.sec_range) sec_range;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT v_city_name_ChildRec := RECORD
  TYPEOF(l.v_city_name) v_city_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT st_ChildRec := RECORD
  TYPEOF(l.st) st;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT zip5_ChildRec := RECORD
  TYPEOF(l.zip5) zip5;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  REAL4 prim_range_specificity;
  REAL4 prim_range_switch;
  REAL4 prim_range_maximum;
  DATASET(prim_range_ChildRec) nulls_prim_range {MAXCOUNT(100)};
  REAL4 predir_specificity;
  REAL4 predir_switch;
  REAL4 predir_maximum;
  DATASET(predir_ChildRec) nulls_predir {MAXCOUNT(100)};
  REAL4 prim_name_specificity;
  REAL4 prim_name_switch;
  REAL4 prim_name_maximum;
  DATASET(prim_name_ChildRec) nulls_prim_name {MAXCOUNT(100)};
  REAL4 addr_suffix_specificity;
  REAL4 addr_suffix_switch;
  REAL4 addr_suffix_maximum;
  DATASET(addr_suffix_ChildRec) nulls_addr_suffix {MAXCOUNT(100)};
  REAL4 postdir_specificity;
  REAL4 postdir_switch;
  REAL4 postdir_maximum;
  DATASET(postdir_ChildRec) nulls_postdir {MAXCOUNT(100)};
  REAL4 unit_desig_specificity;
  REAL4 unit_desig_switch;
  REAL4 unit_desig_maximum;
  DATASET(unit_desig_ChildRec) nulls_unit_desig {MAXCOUNT(100)};
  REAL4 sec_range_specificity;
  REAL4 sec_range_switch;
  REAL4 sec_range_maximum;
  DATASET(sec_range_ChildRec) nulls_sec_range {MAXCOUNT(100)};
  REAL4 v_city_name_specificity;
  REAL4 v_city_name_switch;
  REAL4 v_city_name_maximum;
  DATASET(v_city_name_ChildRec) nulls_v_city_name {MAXCOUNT(100)};
  REAL4 st_specificity;
  REAL4 st_switch;
  REAL4 st_maximum;
  DATASET(st_ChildRec) nulls_st {MAXCOUNT(100)};
  REAL4 zip5_specificity;
  REAL4 zip5_switch;
  REAL4 zip5_maximum;
  DATASET(zip5_ChildRec) nulls_zip5 {MAXCOUNT(100)};
END;
END;
