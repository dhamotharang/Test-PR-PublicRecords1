import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_6500_delta_rid
// ---------------------------------------------------------------

f := File_6500_Government_Trade_Base_bdid(FILE_NUMBER <> '');
export Key_6500_Government_Trade_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_6500_Government_Trade_FILE_NUMBER + '_' + doxie.Version_SuperKey);
