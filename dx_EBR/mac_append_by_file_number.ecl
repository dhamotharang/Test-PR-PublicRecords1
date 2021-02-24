/*
  **
  ** Common macro to append records from EBR keys indexed by file_number.
  ** This automatically applies the necessary incremental rollups.
  **
  ** @param inf                    Input dataset, must contain file_number field.
  ** @param k_ebr                  The EBR key to retrieve data from.
  ** @param k_delta_rid            Delta RID key associated with input dataset.
  ** @param inf_bdid_field         Field to use as bdid for input. OPTIONAL, defaults to 'bdid'.
  ** @param excluded_sics          Sic codes from key to exclude from join condition. OPTIONAL, will be omitted if not supplied.
  ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
  ** @param atmost                 Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
  ** @param is_left_outer          Boolean for using LEFT OUTER in join, OPTIONAL,defaults to FALSE
  ** @param is_few                 Boolean to add 'few' to the join. Defaults to false.
  ** @param match_process_dt_field Field to match against the key record date in join condition. Optional, will be omitted from join  if not supplied.
  ** @returns                      Dataset with related EBR records under EBR_data
  **
*/

EXPORT mac_append_by_file_number(
  inf,
  k_ebr,
  k_delta_rid,
  inf_file_number_field = 'file_number',
  keep_number = '',
  atmost_number = '',
  is_left_outer = 'false',
  is_few = 'false',
  match_process_dt_field = ''
  ) := FUNCTIONMACRO

  IMPORT dx_common, dx_ebr;

  LOCAL return_layout := RECORD(RECORDOF(inf))
    RECORDOF(k_ebr) ebr_data;

    // metadata fields cannot be in a child field for dx_common.Incrementals.mac_rollup
    dx_common.layout_metadata;
  END;

  LOCAL key_recs := JOIN(inf, k_ebr,
    LEFT.file_number != '' AND
    KEYED(LEFT.inf_file_number_field = RIGHT.file_number)

    #IF(#TEXT(match_process_dt_field) != '')
      AND LEFT.match_process_dt_field = (TYPEOF(LEFT.match_process_dt_field))RIGHT.process_date
    #END

    , TRANSFORM(return_layout,
        dx_common.Incrementals.mac_CopyMetadata(SELF, RIGHT),
        SELF.ebr_data := RIGHT,
        SELF := LEFT)

    #IF(#TEXT(keep_number) != '')
      , KEEP(keep_number)
    #END

    #IF (is_left_outer)
      , LEFT OUTER
    #END

    #IF(#TEXT(atmost_number) != '')
      , ATMOST(atmost_number)
    #END

    #IF(#TEXT(keep_number) != '')
      , KEEP(keep_number)
    #END

    #IF (is_few)
      , FEW
    #END

    );

  LOCAL rolled_recs := dx_common.Incrementals.mac_Rollup(key_recs, k_delta_rid);
  RETURN rolled_recs;

ENDMACRO;
