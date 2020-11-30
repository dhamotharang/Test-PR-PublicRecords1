import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_6510_delta_rid
// ---------------------------------------------------------------

f := File_6510_Government_Debarred_Contractor_Base_bdid(FILE_NUMBER <> '');
export Key_6510_Government_Debarred_Contractor_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_6510_Government_Debarred_Contractor_FILE_NUMBER + '_' + doxie.Version_SuperKey);
