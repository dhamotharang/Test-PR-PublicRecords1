import ut;
ut.mac_patch_id(header.FCRA_hhid_table,hhid_indiv,header.FCRA_HHID_Indiv_Joins,le_hhid,ri_hhid,outfile)

export FCRA_HHID_Table_i := outfile : persist('FCRA_HHID_Table_i');