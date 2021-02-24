import dx_death_master, data_services;

//*** A set of macros to append EBR information to a dataset.*****

EXPORT Append := MODULE
  /*
    **
    ** Macro to append data from EBR.Key_0010_Header_BDID
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_bdid_field         Field to use as bdid for input. OPTIONAL, defaults to 'bdid'.
    ** @param excluded_sics          Sic codes from key to exclude from join condition. OPTIONAL, will be omitted if not supplied.
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param is_left_outer          Boolean to turn the appending join into a LEFT OUTER. Deafaults to false.
    ** @returns                      Records from ebr.Key_0010_Header_BDID appended to input layout under ebr_data
    **
  */

  EXPORT Header_0010_By_Bdid(
    inf,
    inf_bdid_field = 'bdid',
    excluded_sics = '',
    keep_number = '',
    atmost_number = '',
    is_left_outer = 'false')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL appended_inf := dx_EBR.mac_append_by_bdid(
      inf,
      EBR.Key_0010_Header_BDID,
      dx_EBR.mod_delta_rid.key_0010_delta_rid,
      inf_bdid_field,
      excluded_sics,
      keep_number,
      atmost_number,
      is_left_outer);

    RETURN appended_inf;
  ENDMACRO;

  /*
    **
    ** Macro to append data from EBR.Key_0010_Header_File_Number
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain file_number field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'.
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param is_left_outer          Boolean to turn the appending join into a LEFT OUTER. Deafaults to false.
    ** @returns                      Records from ebr.Key_0010_Header_File_Number appended to input layout under ebr_data
    **
  */

  EXPORT Header_0010_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '',
    is_left_outer = 'false')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL appended_inf := dx_EBR.mac_append_by_file_number(
      inf,
      EBR.Key_0010_Header_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_0010_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number,
      is_left_outer);

    RETURN appended_inf;
  ENDMACRO;

    /*
    **
    ** Macro to append data from EBR.Key_1000_Executive_Summary_FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain file_number field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'.
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param is_left_outer          Boolean to turn the appending join into a LEFT OUTER. Defaults to false.
    ** @param is_few                 Boolean to add 'few' to the join. Defaults to false.
    ** @param match_process_dt_field Field to match against the key record date in join condition. Optional, will be omitted from join  if not supplied.
    ** @returns                      Records from ebr.Key_1000_Executive_Summary_FILE_NUMBER appended to input layout under ebr_data
    **
  */

  EXPORT Executive_Summary_1000_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '',
    is_left_outer = 'false',
    is_few = 'false',
    match_process_dt_field = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL appended_inf := dx_EBR.mac_append_by_file_number(
      inf,
      EBR.Key_1000_Executive_Summary_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_1000_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number,
      is_left_outer,
      is_few,
      match_process_dt_field);

    RETURN appended_inf;
  ENDMACRO;

  /*
    **
    ** Macro to append data from EBR.Key_2015_Trade_Payment_Totals_FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain file_number field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'.
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param is_left_outer          Boolean to turn the appending join into a LEFT OUTER. Defaults to false.
    ** @param is_few                 Boolean to add 'few' to the join. Defaults to false.
    ** @param match_process_dt_field Field to match against the key record date in join condition. Optional, will be omitted from join  if not supplied.
    ** @returns                      Records from ebr.Key_2015_Trade_Payment_Totals_FILE_NUMBER appended to input layout under ebr_data
    **
  */

  EXPORT Trade_Payment_Totals_2015_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '',
    is_left_outer = 'false',
    is_few = 'false',
    match_process_dt_field = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL appended_inf := dx_EBR.mac_append_by_file_number(
      inf,
      EBR.Key_2015_Trade_Payment_Totals_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_2015_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number,
      is_left_outer,
      is_few,
      match_process_dt_field);

    RETURN appended_inf;
  ENDMACRO;

END;
