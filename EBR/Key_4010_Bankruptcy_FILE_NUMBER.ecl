import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_4010_delta_rid
// ---------------------------------------------------------------

f := File_4010_Bankruptcy_Base_bdid(FILE_NUMBER <> '');

export Key_4010_Bankruptcy_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_4010_Bankruptcy_FILE_NUMBER + '_' + doxie.Version_SuperKey);
