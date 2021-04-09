/*
  ** DO NOT USE THIS MACRO DIRECTLY, it should be called from the appropriate dx_EBR.Read function.
  **
  ** Common macro to grab records from EBR keys via keyed filter indexed by file_number.
  ** Currently there is an issue in converting keyed filters to keyed joins that results in a performance loss.
  ** This automatically applies the necessary incremental rollups.
  **
  ** @param inf_file_number        File Number of records to retrieve as a string. REQUIRED.
  ** @param k_ebr                  The EBR key to retrieve data from.
  ** @param k_delta_rid            Delta RID key associated with input dataset.
  ** @param choosen_number         Number of records to keep. REQUIRED. If < 1 it sets it to 100.
  ** @param inf_process_date       Adds a filter before the CHOOSEN to match a value for the process_date field. OPTIONAL, will be excluded if not supplied.
  ** @param excluded_record_types  Set of STRING1 of record types to exclude. OPTIONAL, will be excluded if not supplied.
  ** @returns                      Dataset in key layout with incremental updates rolled up.
  **
*/

EXPORT mac_read_by_file_number(
  inf_file_number,
  k_ebr,
  k_delta_rid,
  choosen_number,
  inf_process_date = '',
  excluded_record_types = ''
  ) := FUNCTIONMACRO

  IMPORT dx_common;
  LOCAL CHOOSEN_SAFEGUARD := 10000;
  LOCAL key_recs := k_ebr(KEYED(file_number = inf_file_number));
  LOCAL filtered_key_recs := key_recs

  #IF(#TEXT(inf_process_date) != '')
    ((unsigned)process_date = inf_process_date)
  #END

  #IF(#TEXT(excluded_record_types) != '')
    (record_type NOT IN excluded_record_types)
  #END
  ; // Finishes filter statement for template langauge, do not remove.

  LOCAL safe_choosen := IF(choosen_number > CHOOSEN_SAFEGUARD, CHOOSEN_SAFEGUARD, choosen_number);
  LOCAL limited_key_recs := CHOOSEN(filtered_key_recs, safe_choosen * 1.1); // Add 10% of desired chooseN to account for records removed after rollup.
  LOCAL rolled_recs := dx_common.Incrementals.mac_Rollup(limited_key_recs, k_delta_rid);
  RETURN CHOOSEN(rolled_recs, safe_choosen);

ENDMACRO;
