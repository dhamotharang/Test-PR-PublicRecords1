import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_4030_delta_rid
// ---------------------------------------------------------------

f := File_4030_Judgement_Base_bdid(bdid <> 0);

export Key_4030_Judgement_BDID := index(f,{bdid},{f},KeyName_4030_Judgement_BDID + '_' + doxie.Version_SuperKey);
