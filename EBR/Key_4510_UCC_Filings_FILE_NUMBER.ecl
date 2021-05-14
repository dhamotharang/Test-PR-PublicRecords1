import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_4510_delta_rid
// ---------------------------------------------------------------

f := File_4510_UCC_Filings_Base_bdid(FILE_NUMBER <> '');

export Key_4510_UCC_Filings_FILE_NUMBER := index(f,{FILE_NUMBER},{f},KeyName_4510_UCC_Filings_FILE_NUMBER + '_' + doxie.Version_SuperKey);
