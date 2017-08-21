import ut,prte2_header;
ut.mac_patch_id(header.hhid_table,hhid_indiv,header.HHID_Indiv_Joins,le_hhid,ri_hhid,outfile)

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export HHID_Table_i := outfile;
#ELSE
export HHID_Table_i := outfile : persist('HHID_Table_i');
#END