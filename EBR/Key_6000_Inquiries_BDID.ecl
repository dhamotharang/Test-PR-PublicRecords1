import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_6000_delta_rid
// ---------------------------------------------------------------

f := File_6000_Inquiries_Base_bdid(bdid <> 0);
export Key_6000_Inquiries_BDID := index(f,{bdid},{f},KeyName_6000_Inquiries_BDID + '_' + doxie.Version_SuperKey);
