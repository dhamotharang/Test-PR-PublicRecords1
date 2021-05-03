import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_4500_delta_rid
// ---------------------------------------------------------------

f := File_4500_Collateral_Accounts_Base_bdid(bdid <> 0);

export Key_4500_Collateral_Accounts_BDID := index(f,{bdid},{f},KeyName_4500_Collateral_Accounts_BDID + '_' + doxie.Version_SuperKey);

