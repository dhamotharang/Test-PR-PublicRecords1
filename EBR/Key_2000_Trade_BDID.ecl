import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_2000_delta_rid
// ---------------------------------------------------------------

f := File_2000_Trade_Base_bdid(bdid <> 0);

export Key_2000_Trade_BDID := index(f,{bdid},{f},KeyName_2000_Trade_BDID + '_' + doxie.Version_SuperKey);
