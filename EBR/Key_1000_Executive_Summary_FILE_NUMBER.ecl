import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_1000_delta_rid
// ---------------------------------------------------------------

f := File_1000_Executive_Summary_Base_bdid(bdid <> 0);

export Key_1000_Executive_Summary_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_1000_Executive_Summary_FILE_NUMBER + '_' + doxie.Version_SuperKey);
