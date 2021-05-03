import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_2000_delta_rid
// ---------------------------------------------------------------

f := File_2000_Trade_Base_bdid(FILE_NUMBER <> '');

export Key_2000_Trade_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_2000_Trade_FILE_NUMBER + '_' + doxie.Version_SuperKey);
