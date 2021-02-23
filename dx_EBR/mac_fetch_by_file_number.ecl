/*
  **
  ** Common macro to grab records from EBR keys indexed by BDID.
  ** This automatically applies the necessary incremental rollups.
  **
  ** @param inf                    Input dataset, must contain file_number field.
  ** @param k_ebr                  The EBR key to retrieve data from.
  ** @param k_delta_rid            Delta RID key associated with input dataset.
  ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'.
  ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
  ** @param atmost                 Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
  ** @param excluded_record_types  Set of strings in record_type field to exclude from the join.
  ** @returns                      Dataset in key layout with incremental updates rolled up.
  **
*/

EXPORT mac_fetch_by_file_number(
  inf,
  k_ebr,
  k_delta_rid,
  inf_file_number_field = 'file_number',
  keep_number = '',
  atmost_number = '',
  excluded_record_types = ''
  ) := FUNCTIONMACRO

  IMPORT dx_common;

  LOCAL key_recs := JOIN(inf, k_ebr,
    LEFT.inf_file_number_field != '' AND
    KEYED(LEFT.inf_file_number_field = RIGHT.file_number)

    #IF(#TEXT(excluded_record_types) != '')
      AND RIGHT.record_type NOT IN excluded_record_types
    #END

    ,TRANSFORM(RIGHT)

    #IF(#TEXT(atmost_number) != '')
      , ATMOST(atmost_number)
    #END

    #IF(#TEXT(keep_number) != '')
      , KEEP(keep_number)
    #END
    );

  LOCAL rolled_recs := dx_common.Incrementals.mac_Rollup(key_recs, k_delta_rid);
  RETURN rolled_recs;
ENDMACRO;
