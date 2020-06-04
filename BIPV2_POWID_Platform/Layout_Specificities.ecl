IMPORT SALT32;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_POWID;
EXPORT RID_If_Big_Biz_ChildRec := RECORD
  TYPEOF(l.RID_If_Big_Biz) RID_If_Big_Biz;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_name_ChildRec := RECORD
  TYPEOF(l.company_name) company_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cnp_name_ChildRec := RECORD
  TYPEOF(l.cnp_name) cnp_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cnp_number_ChildRec := RECORD
  TYPEOF(l.cnp_number) cnp_number;
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
EXPORT zip_ChildRec := RECORD
  TYPEOF(l.zip) zip;
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
EXPORT charter_ChildRec := RECORD
  SALT32.StrType Basis;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  REAL4 RID_If_Big_Biz_specificity;
  REAL4 RID_If_Big_Biz_switch;
  REAL4 RID_If_Big_Biz_maximum;
  DATASET(RID_If_Big_Biz_ChildRec) nulls_RID_If_Big_Biz {MAXCOUNT(100)};
  REAL4 company_name_specificity;
  REAL4 company_name_switch;
  REAL4 company_name_maximum;
  DATASET(company_name_ChildRec) nulls_company_name {MAXCOUNT(100)};
  REAL4 cnp_name_specificity;
  REAL4 cnp_name_switch;
  REAL4 cnp_name_maximum;
  DATASET(cnp_name_ChildRec) nulls_cnp_name {MAXCOUNT(100)};
  REAL4 cnp_number_specificity;
  REAL4 cnp_number_switch;
  REAL4 cnp_number_maximum;
  DATASET(cnp_number_ChildRec) nulls_cnp_number {MAXCOUNT(100)};
  REAL4 prim_range_specificity;
  REAL4 prim_range_switch;
  REAL4 prim_range_maximum;
  DATASET(prim_range_ChildRec) nulls_prim_range {MAXCOUNT(100)};
  REAL4 prim_name_specificity;
  REAL4 prim_name_switch;
  REAL4 prim_name_maximum;
  DATASET(prim_name_ChildRec) nulls_prim_name {MAXCOUNT(100)};
  REAL4 zip_specificity;
  REAL4 zip_switch;
  REAL4 zip_maximum;
  DATASET(zip_ChildRec) nulls_zip {MAXCOUNT(100)};
  REAL4 dt_first_seen_specificity;
  REAL4 dt_first_seen_switch;
  REAL4 dt_first_seen_maximum;
  DATASET(dt_first_seen_ChildRec) nulls_dt_first_seen {MAXCOUNT(100)};
  REAL4 dt_last_seen_specificity;
  REAL4 dt_last_seen_switch;
  REAL4 dt_last_seen_maximum;
  DATASET(dt_last_seen_ChildRec) nulls_dt_last_seen {MAXCOUNT(100)};
  REAL4 charter_specificity;
  REAL4 charter_switch;
  REAL4 charter_max;
  DATASET(charter_ChildRec) nulls_charter {MAXCOUNT(100)};
END;
END;
