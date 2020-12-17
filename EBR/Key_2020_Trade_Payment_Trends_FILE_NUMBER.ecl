import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_2020_delta_rid
// ---------------------------------------------------------------

f := File_2020_Trade_Payment_Trends_Base_bdid(FILE_NUMBER <> '');

export Key_2020_Trade_Payment_Trends_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_2020_Trade_Payment_Trends_FILE_NUMBER + '_' + doxie.Version_SuperKey);
