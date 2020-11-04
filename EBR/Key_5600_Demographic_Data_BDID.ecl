import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_5600_delta_rid
// ---------------------------------------------------------------

f := File_5600_Demographic_Data_Base_bdid(bdid <> 0);
export Key_5600_Demographic_Data_BDID := index(f,{bdid},{f},KeyName_5600_Demographic_Data_BDID + '_' + doxie.Version_SuperKey);
