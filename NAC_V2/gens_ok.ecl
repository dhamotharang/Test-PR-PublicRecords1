import header;

export gens_ok(string5 le_su,integer le_do,string5 ri_su,integer ri_do) :=
  header.sig_near_dob(le_do,ri_do) or NNEQ_suffix(le_su,ri_su);	