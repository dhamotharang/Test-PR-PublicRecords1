import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_2020_delta_rid
// ---------------------------------------------------------------

f := File_2020_Trade_Payment_Trends_Base_bdid(bdid <> 0);

export Key_2020_Trade_Payment_Trends_BDID := index(f,{bdid},{f},KeyName_2020_Trade_Payment_Trends_BDID + '_' + doxie.Version_SuperKey);
