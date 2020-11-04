import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_6000_delta_rid
// ---------------------------------------------------------------

f := File_6000_Inquiries_Base_bdid(FILE_NUMBER <> '');
export Key_6000_Inquiries_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_6000_Inquiries_FILE_NUMBER + '_' + doxie.Version_SuperKey);
