import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_6500_delta_rid
// ---------------------------------------------------------------

f := File_6500_Government_Trade_Base_bdid(bdid <> 0);
export Key_6500_Government_Trade_BDID := index(f,{bdid},{f},KeyName_6500_Government_Trade_BDID + '_' + doxie.Version_SuperKey);
