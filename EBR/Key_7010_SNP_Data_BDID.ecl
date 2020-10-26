import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_7010_delta_rid
// ---------------------------------------------------------------

f := File_7010_SNP_Data_Base_bdid(bdid <> 0);
export Key_7010_SNP_Data_BDID := index(f,{bdid},{f},KeyName_7010_SNP_Data_BDID + '_' + doxie.Version_SuperKey);

