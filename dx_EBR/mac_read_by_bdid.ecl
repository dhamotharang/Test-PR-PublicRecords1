/*
  ** DO NOT USE THIS MACRO DIRECTLY, it should be called from the appropriate dx_EBR.Read function.
  **
  ** Common macro to grab records from EBR keys via keyed filter indexed by BDID.
  ** Currently there is an issue in converting keyed filters to keyed joins that results in a performance loss.
  ** This automatically applies the necessary incremental rollups.
  **
  ** @param set_of_bdids           Set of strings to use as bdids for the keyed filter.
  ** @param k_ebr                  The EBR key to retrieve data from.
  ** @param k_delta_rid            Delta RID key associated with input dataset.
  ** @param choosen_number         Number of records to keep. REQUIRED. If < 1 it sets it to 100.
  ** @returns                      Dataset in key layout with incremental updates rolled up.
  **
*/

EXPORT mac_read_by_bdid(
  set_of_bdids,
  k_ebr,
  k_delta_rid,
  choosen_number
  ) := FUNCTIONMACRO

  IMPORT dx_common;
  LOCAL CHOOSEN_SAFEGUARD := 10000;
  LOCAL key_recs := k_ebr(KEYED(bdid in set_of_bdids));
  LOCAL filtered_key_recs := key_recs;

  LOCAL safe_choosen := IF(choosen_number > CHOOSEN_SAFEGUARD, CHOOSEN_SAFEGUARD, choosen_number);
  LOCAL limited_key_recs := CHOOSEN(filtered_key_recs, safe_choosen * 1.1); // Add 10% of desired chooseN to account for records removed after rollup.
  LOCAL rolled_recs := dx_common.Incrementals.mac_Rollup(limited_key_recs, k_delta_rid);
  RETURN CHOOSEN(rolled_recs, safe_choosen);

ENDMACRO;
