import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_5600_delta_rid
// ---------------------------------------------------------------

f := File_5600_Demographic_Data_Base_bdid(FILE_NUMBER <> '');
export Key_5600_Demographic_Data_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_5600_Demographic_Data_FILE_NUMBER + '_' + doxie.Version_SuperKey);
