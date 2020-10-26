import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_5000_delta_rid
// ---------------------------------------------------------------

f := File_5000_Bank_Details_Base_bdid(bdid <> 0);

export Key_5000_Bank_Details_BDID := index(f,{bdid},{f},KeyName_5000_Bank_Details_BDID + '_' + doxie.Version_SuperKey);
