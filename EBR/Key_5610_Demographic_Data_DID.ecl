import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_5610_delta_rid
// ---------------------------------------------------------------

f := File_5610_Demographic_Data_Base_bdid(did <> 0);
export Key_5610_Demographic_Data_DID := index(f,{did},{f},KeyName_5610_Demographic_Data_DID + '_' + doxie.Version_SuperKey);
