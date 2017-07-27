import ut;

typeof(header.FCRA_hhid_table_i) cu(header.FCRA_hhid_table_i le) := transform
  self.hhid_relat := le.hhid_indiv;
  self := le;
  end;

p := project(header.FCRA_HHID_Table_i,cu(left));

ut.mac_patch_id(p,hhid_relat,header.FCRA_HHID_Rel_Joins,le_hhid,ri_hhid,outfile)

export FCRA_HHID_Table_Final := outfile : persist('FCRA_HHID_Table_Final');