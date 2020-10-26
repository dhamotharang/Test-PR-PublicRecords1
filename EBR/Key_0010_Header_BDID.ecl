import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_0010_delta_rid
// ---------------------------------------------------------------

f := File_0010_Header_Base(bdid <> 0);

export Key_0010_Header_BDID := index(f,{bdid},{f},KeyName_0010_Header_BDID + '_' + doxie.Version_SuperKey);
