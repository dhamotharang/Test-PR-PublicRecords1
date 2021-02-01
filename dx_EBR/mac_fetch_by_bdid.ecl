/*
  **
  ** Common macro to grab records from EBR keys indexed by BDID.
  ** This automatically applies the necessary incremental rollups.
  **
  ** @param inf                    Input dataset, must contain bdid field.
  ** @param k_ebr                  The EBR key to retrieve data from.
  ** @param k_delta_rid            Delta RID key associated with input dataset.
  ** @param inf_bdid_field         Field to use as bdid for input. OPTIONAL, defaults to 'bdid'.
  ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
  ** @param atmost                 Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
  ** @param excluded_sics          Sic codes from key to exclude from join condition. OPTIONAL, will be omitted if not supplied.
  ** @returns                      Dataset in key layout with incremental updates rolled up.
  **
*/

EXPORT mac_fetch_by_bdid(
  inf,
  k_ebr,
  k_delta_rid,
  inf_bdid_field = 'bdid',
  keep_number = '',
  atmost_number = '',
  excluded_sics = ''
  ) := FUNCTIONMACRO

  IMPORT dx_common;

  LOCAL key_recs := JOIN(inf, k_ebr,
    LEFT.bdid != 0 AND
    KEYED(LEFT.inf_bdid_field = RIGHT.bdid)
    #IF(#TEXT(excluded_sics) != '')
      AND RIGHT.sic_code NOT IN excluded_sics
    #END
    , TRANSFORM(RIGHT)

    #IF(#TEXT(atmost_number) != '')
      , ATMOST(atmost_number)
    #END

    #IF(#TEXT(keep_number) != '')
      , KEEP(keep_number)
    #END
    );

  LOCAL rolled_recs := dx_common.Incrementals.mac_Rollup(key_recs , k_delta_rid);
  RETURN rolled_recs;
ENDMACRO;
