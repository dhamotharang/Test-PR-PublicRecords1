IMPORT dx_EBR;

/*
  ** A set of macros to "get" data from EBR keys.
*/

EXPORT Get := MODULE

  /*
    **
    ** Macro to grab data from EBR.Key_0010_Header_BDID
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_bdid_field         Field to use as bdid for input. OPTIONAL, defaults to 'bdid'.
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param excluded_sics          Sic codes from key to exclude from join condition. OPTIONAL, will be omitted if not supplied.
    ** @returns                      Records from ebr.Key_0010_Header_BDID with matching bdid in key layout.
    **
  */

  EXPORT Header_0010_By_Bdid(
    inf,
    inf_bdid_field = 'bdid',
    keep_number = '',
    atmost_number = '',
    excluded_sics = '')
  := FUNCTIONMACRO

    IMPORT EBR;
    LOCAL header_0010_recs := dx_EBR.mac_fetch_by_bdid(
      inf,
      EBR.Key_0010_Header_BDID,
      dx_EBR.mod_delta_rid.key_0010_delta_rid,
      inf_bdid_field,
      keep_number,
      atmost_number,
      excluded_sics);

    RETURN header_0010_recs;
  ENDMACRO;

  /*
    **
    ** Macro to grab data from ebr.Key_5600_Demographic_Data_BDI
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_bdid_field         Field to use as bdid for input. OPTIONAL, defaults to 'bdid'.
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param excluded_sics          Sic codes from key to exclude from join condition. OPTIONAL, will be omitted if not supplied.
    ** @returns                      Records from ebr.Key_5600_Demographic_Data_BDI with matching bdid in key layout.
    **
  */

  EXPORT Demographic_5600_By_Bdid(
    inf,
    inf_bdid_field = 'bdid',
    keep_number = '',
    atmost_number = '',
    excluded_sics = '')
  := FUNCTIONMACRO

    IMPORT EBR;
    LOCAL demographic_5600_recs := dx_EBR.mac_fetch_by_bdid(
      inf,
      EBR.Key_5600_Demographic_Data_BDID,
      dx_EBR.mod_delta_rid.key_5600_delta_rid,
      inf_bdid_field,
      keep_number,
      atmost_number,
      excluded_sics);

    RETURN demographic_5600_recs;
  ENDMACRO;

END;
