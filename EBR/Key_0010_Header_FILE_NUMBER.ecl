import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_0010_delta_rid
// ---------------------------------------------------------------

f := File_0010_Header_Base(FILE_NUMBER <> '');

export Key_0010_Header_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_0010_Header_FILE_NUMBER + '_' + doxie.Version_SuperKey);
