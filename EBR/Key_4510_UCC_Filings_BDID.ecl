import doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_4510_delta_rid
// ---------------------------------------------------------------

f := File_4510_UCC_Filings_Base_bdid(bdid <> 0);

export Key_4510_UCC_Filings_BDID := index(f,{bdid},{f},KeyName_4510_UCC_Filings_BDID + '_' + doxie.Version_SuperKey);
