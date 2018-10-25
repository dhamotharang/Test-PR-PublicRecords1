IMPORT SALT30;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_LGID3;
export sbfe_id_ChildRec := record
  typeof(l.sbfe_id) sbfe_id;
  unsigned8 cnt;
  unsigned4 id;
end;
export Lgid3IfHrchy_ChildRec := record
  typeof(l.Lgid3IfHrchy) Lgid3IfHrchy;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_name_ChildRec := record
  typeof(l.company_name) company_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export cnp_number_ChildRec := record
  typeof(l.cnp_number) cnp_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export active_duns_number_ChildRec := record
  typeof(l.active_duns_number) active_duns_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export duns_number_ChildRec := record
  typeof(l.duns_number) duns_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export duns_number_concept_ChildRec := record
  UNSIGNED4 duns_number_concept;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_fein_ChildRec := record
  typeof(l.company_fein) company_fein;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_inc_state_ChildRec := record
  typeof(l.company_inc_state) company_inc_state;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_charter_number_ChildRec := record
  typeof(l.company_charter_number) company_charter_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export cnp_btype_ChildRec := record
  typeof(l.cnp_btype) cnp_btype;
  unsigned8 cnt;
  unsigned4 id;
end;
EXPORT UnderLinks_ChildRec := RECORD
  SALT30.StrType Basis;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  real4 sbfe_id_specificity;
  real4 sbfe_id_switch;
  real4 sbfe_id_max;
  dataset(sbfe_id_ChildRec) nulls_sbfe_id {MAXCOUNT(100)};
  real4 Lgid3IfHrchy_specificity;
  real4 Lgid3IfHrchy_switch;
  real4 Lgid3IfHrchy_max;
  dataset(Lgid3IfHrchy_ChildRec) nulls_Lgid3IfHrchy {MAXCOUNT(100)};
  real4 company_name_specificity;
  real4 company_name_switch;
  real4 company_name_max;
  dataset(company_name_ChildRec) nulls_company_name {MAXCOUNT(100)};
  real4 cnp_number_specificity;
  real4 cnp_number_switch;
  real4 cnp_number_max;
  dataset(cnp_number_ChildRec) nulls_cnp_number {MAXCOUNT(100)};
  real4 active_duns_number_specificity;
  real4 active_duns_number_switch;
  real4 active_duns_number_max;
  dataset(active_duns_number_ChildRec) nulls_active_duns_number {MAXCOUNT(100)};
  real4 duns_number_specificity;
  real4 duns_number_switch;
  real4 duns_number_max;
  dataset(duns_number_ChildRec) nulls_duns_number {MAXCOUNT(100)};
  real4 duns_number_concept_specificity;
  real4 duns_number_concept_switch;
  real4 duns_number_concept_max;
  dataset(duns_number_concept_ChildRec) nulls_duns_number_concept {MAXCOUNT(100)};
  real4 company_fein_specificity;
  real4 company_fein_switch;
  real4 company_fein_max;
  dataset(company_fein_ChildRec) nulls_company_fein {MAXCOUNT(100)};
  real4 company_inc_state_specificity;
  real4 company_inc_state_switch;
  real4 company_inc_state_max;
  dataset(company_inc_state_ChildRec) nulls_company_inc_state {MAXCOUNT(100)};
  real4 company_charter_number_specificity;
  real4 company_charter_number_switch;
  real4 company_charter_number_max;
  dataset(company_charter_number_ChildRec) nulls_company_charter_number {MAXCOUNT(100)};
  real4 cnp_btype_specificity;
  real4 cnp_btype_switch;
  real4 cnp_btype_max;
  dataset(cnp_btype_ChildRec) nulls_cnp_btype {MAXCOUNT(100)};
  REAL4 UnderLinks_specificity;
  REAL4 UnderLinks_switch;
  REAL4 UnderLinks_max;
  DATASET(UnderLinks_ChildRec) nulls_UnderLinks {MAXCOUNT(100)};
END;
END;
