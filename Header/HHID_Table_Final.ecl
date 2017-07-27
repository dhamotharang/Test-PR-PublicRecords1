import ut;

typeof(header.hhid_table_i) cu(header.hhid_table_i le) := transform
  self.hhid_relat := le.hhid_indiv;
  self := le;
  end;

p := project(header.HHID_Table_i,cu(left));

ut.mac_patch_id(p,hhid_relat,header.HHID_Rel_Joins,le_hhid,ri_hhid,outfile)

export HHID_Table_Final := outfile : persist('HHID_Table_Final');