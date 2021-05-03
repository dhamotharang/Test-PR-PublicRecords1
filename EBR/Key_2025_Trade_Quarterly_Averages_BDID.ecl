import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_2025_delta_rid
// ---------------------------------------------------------------

f := File_2025_Trade_Quarterly_Averages_Base_bdid(bdid <> 0);

export Key_2025_Trade_Quarterly_Averages_BDID := index(f,{bdid},{f},KeyName_2025_Trade_Quarterly_Averages_BDID + '_' + doxie.Version_SuperKey);
