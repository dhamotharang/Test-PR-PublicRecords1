/*
  **
  ** Common macro to append records from EBR keys indexed by BDID.
  ** This automatically applies the necessary incremental rollups.
  **
  ** @param inf                    Input dataset, must contain bdid field.
  ** @param k_ebr                  The EBR key to retrieve data from.
  ** @param k_delta_rid            Delta RID key associated with input dataset.
  ** @param inf_bdid_field         Field to use as bdid for input. OPTIONAL, defaults to 'bdid'.
  ** @param excluded_sics          Sic codes from key to exclude from join condition. OPTIONAL, will be omitted if not supplied.
  ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
  ** @param atmost                 Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
  ** @param is_left_outer          Boolean for using LEFT OUTER in join, OPTIONAL,defaults to FALSE
  ** @returns                      Dataset with related EBR records under EBR_data
  **
*/

EXPORT mac_append_by_bdid(
  inf,
  k_ebr,
  k_delta_rid,
  inf_bdid_field = 'bdid',
  excluded_sics = '',
  keep_number = '',
  atmost_number = '',
  is_left_outer = 'false'
  ) := FUNCTIONMACRO

  IMPORT dx_common, dx_ebr;

  LOCAL return_layout := RECORD(RECORDOF(inf))
    dx_ebr.Header_0010_append_layout.slim ebr_data;

    // metadata fields cannot be in a child field for dx_common.Incrementals.mac_rollup
    dx_common.layout_metadata;
  END;

  LOCAL key_recs := JOIN(inf, k_ebr,
    LEFT.bdid != 0 AND
    KEYED(LEFT.inf_bdid_field = RIGHT.bdid)

    #IF(#TEXT(excluded_sics) != '')
      AND RIGHT.sic_code NOT IN excluded_sics
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

    );

  LOCAL rolled_recs := dx_common.Incrementals.mac_Rollup(key_recs, k_delta_rid);
  RETURN rolled_recs;

ENDMACRO;
