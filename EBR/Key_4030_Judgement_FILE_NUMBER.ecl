import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_4030_delta_rid
// ---------------------------------------------------------------

f := File_4030_Judgement_Base_bdid(FILE_NUMBER <> '');

export Key_4030_Judgement_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_4030_Judgement_FILE_NUMBER + '_' + doxie.Version_SuperKey);
