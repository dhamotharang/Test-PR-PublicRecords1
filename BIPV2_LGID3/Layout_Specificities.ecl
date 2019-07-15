IMPORT SALT311;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_LGID3;
EXPORT sbfe_id_ChildRec := RECORD
  TYPEOF(l.sbfe_id) sbfe_id;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT Lgid3IfHrchy_ChildRec := RECORD
  TYPEOF(l.Lgid3IfHrchy) Lgid3IfHrchy;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_name_ChildRec := RECORD
  TYPEOF(l.company_name) company_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cnp_number_ChildRec := RECORD
  TYPEOF(l.cnp_number) cnp_number;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT active_duns_number_ChildRec := RECORD
  TYPEOF(l.active_duns_number) active_duns_number;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT duns_number_ChildRec := RECORD
  TYPEOF(l.duns_number) duns_number;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT duns_number_concept_ChildRec := RECORD
  UNSIGNED4 duns_number_concept;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_fein_ChildRec := RECORD
  TYPEOF(l.company_fein) company_fein;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_inc_state_ChildRec := RECORD
  TYPEOF(l.company_inc_state) company_inc_state;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_charter_number_ChildRec := RECORD
  TYPEOF(l.company_charter_number) company_charter_number;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cnp_btype_ChildRec := RECORD
  TYPEOF(l.cnp_btype) cnp_btype;
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
EXPORT UnderLinks_ChildRec := RECORD
  SALT311.StrType Basis;
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
  REAL4 sbfe_id_specificity;
  REAL4 sbfe_id_switch;
  REAL4 sbfe_id_maximum;
  DATASET(sbfe_id_ChildRec) nulls_sbfe_id {MAXCOUNT(100)};
  REAL4 Lgid3IfHrchy_specificity;
  REAL4 Lgid3IfHrchy_switch;
  REAL4 Lgid3IfHrchy_maximum;
  DATASET(Lgid3IfHrchy_ChildRec) nulls_Lgid3IfHrchy {MAXCOUNT(100)};
  REAL4 company_name_specificity;
  REAL4 company_name_switch;
  REAL4 company_name_maximum;
  DATASET(company_name_ChildRec) nulls_company_name {MAXCOUNT(100)};
  REAL4 cnp_number_specificity;
  REAL4 cnp_number_switch;
  REAL4 cnp_number_maximum;
  DATASET(cnp_number_ChildRec) nulls_cnp_number {MAXCOUNT(100)};
  REAL4 active_duns_number_specificity;
  REAL4 active_duns_number_switch;
  REAL4 active_duns_number_maximum;
  DATASET(active_duns_number_ChildRec) nulls_active_duns_number {MAXCOUNT(100)};
  REAL4 duns_number_specificity;
  REAL4 duns_number_switch;
  REAL4 duns_number_maximum;
  DATASET(duns_number_ChildRec) nulls_duns_number {MAXCOUNT(100)};
  REAL4 duns_number_concept_specificity;
  REAL4 duns_number_concept_switch;
  REAL4 duns_number_concept_maximum;
  DATASET(duns_number_concept_ChildRec) nulls_duns_number_concept {MAXCOUNT(100)};
  REAL4 company_fein_specificity;
  REAL4 company_fein_switch;
  REAL4 company_fein_maximum;
  DATASET(company_fein_ChildRec) nulls_company_fein {MAXCOUNT(100)};
  REAL4 company_inc_state_specificity;
  REAL4 company_inc_state_switch;
  REAL4 company_inc_state_maximum;
  DATASET(company_inc_state_ChildRec) nulls_company_inc_state {MAXCOUNT(100)};
  REAL4 company_charter_number_specificity;
  REAL4 company_charter_number_switch;
  REAL4 company_charter_number_maximum;
  DATASET(company_charter_number_ChildRec) nulls_company_charter_number {MAXCOUNT(100)};
  REAL4 cnp_btype_specificity;
  REAL4 cnp_btype_switch;
  REAL4 cnp_btype_maximum;
  DATASET(cnp_btype_ChildRec) nulls_cnp_btype {MAXCOUNT(100)};
  REAL4 dt_first_seen_specificity;
  REAL4 dt_first_seen_switch;
  REAL4 dt_first_seen_maximum;
  DATASET(dt_first_seen_ChildRec) nulls_dt_first_seen {MAXCOUNT(100)};
  REAL4 dt_last_seen_specificity;
  REAL4 dt_last_seen_switch;
  REAL4 dt_last_seen_maximum;
  DATASET(dt_last_seen_ChildRec) nulls_dt_last_seen {MAXCOUNT(100)};
  REAL4 UnderLinks_specificity;
  REAL4 UnderLinks_switch;
  REAL4 UnderLinks_maximum;
  DATASET(UnderLinks_ChildRec) nulls_UnderLinks {MAXCOUNT(100)};
  REAL4 uber_specificity;
  REAL4 uber_switch;
  REAL4 uber_maximum;
  DATASET(Uber_ChildRec) nulls_uber {MAXCOUNT(100)};
END;
END;
