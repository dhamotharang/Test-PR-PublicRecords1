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
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT Header_0010_By_Bdid(
    inf,
    inf_bdid_field = 'bdid',
    keep_number = '',
    atmost_number = '',
    excluded_sics = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
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
    ** Macro to grab data from EBR.Key_0010_Header_FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'.
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param excluded_sics          Sic codes from key to exclude from join condition. OPTIONAL, will be omitted if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT Header_0010_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '',
    excluded_record_types = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL header_0010_recs := dx_EBR.mac_fetch_by_file_number(
      inf,
      EBR.Key_0010_Header_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_0010_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number,
      excluded_record_types);

    RETURN header_0010_recs;
  ENDMACRO;

  /*
    **
    ** Macro to grab data from EBR.Key_1000_Executive_Summary_BDID
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_bdid_field         Field to use as bdid for input. OPTIONAL, defaults to 'bdid'.
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param excluded_sics          Sic codes from key to exclude from join condition. OPTIONAL, will be omitted if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT Executive_Summary_1000_By_Bdid(
    inf,
    inf_bdid_field = 'bdid',
    keep_number = '',
    atmost_number = '',
    excluded_sics = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL header_0010_recs := dx_EBR.mac_fetch_by_bdid(
      inf,
      EBR.Key_1000_Executive_Summary_BDID,
      dx_EBR.mod_delta_rid.key_1000_delta_rid,
      inf_bdid_field,
      keep_number,
      atmost_number,
      excluded_sics);

    RETURN header_0010_recs;
  ENDMACRO;

  /*
    **
    ** Macro to grab data from Key_1000_Executive_Summary_FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT Executive_Summary_1000_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL executive_summary_1000_recs := dx_EBR.mac_fetch_by_file_number(
      inf,
      EBR.Key_1000_Executive_Summary_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_1000_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number);

    RETURN executive_summary_1000_recs;
  ENDMACRO;

  /*
    **
    ** Macro to grab data from Key_2000_Trade FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT Trade_2000_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL trade_2000_recs := dx_EBR.mac_fetch_by_file_number(
      inf,
      ebr.Key_2000_Trade_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_2000_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number);

    RETURN trade_2000_recs;
  ENDMACRO;

  /*
    **
    ** Macro to grab data from Key_2015_Trade_payment_Totals_FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT Trade_Payment_Totals_2015_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL trade_payment_totals_2015_recs := dx_EBR.mac_fetch_by_file_number(
      inf,
      ebr.Key_2015_Trade_Payment_Totals_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_2015_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number);

    RETURN trade_payment_totals_2015_recs;
  ENDMACRO;

  /*
    **
    ** Macro to grab data from Key_2020_Trade_Payment_Trends_FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT Trade_Payment_Trends_2020_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL trade_payment_trends_2020_recs := dx_EBR.mac_fetch_by_file_number(
      inf,
      ebr.Key_2020_Trade_Payment_Trends_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_2020_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number);

    RETURN trade_payment_trends_2020_recs;
  ENDMACRO;

  /*
    **
    ** Macro to grab data from Key_2025_Trade_Quarterly_Averages_FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT Trade_Quarterly_Averages_2025_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL trade_quarterly_averages_2025_recs := dx_EBR.mac_fetch_by_file_number(
      inf,
      ebr.Key_2025_Trade_Quarterly_Averages_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_2025_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number);

    RETURN trade_quarterly_averages_2025_recs;
  ENDMACRO;

  /*
    **
    ** Macro to grab data from Key_4010_Bankruptcy_FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT Bankruptcy_4010_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL bankruptcy_4010_recs := dx_EBR.mac_fetch_by_file_number(
      inf,
      ebr.Key_4010_Bankruptcy_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_4010_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number);

    RETURN bankruptcy_4010_recs;
  ENDMACRO;

  /*
    **
    ** Macro to grab data from Key_4020_Tax_Liens_FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT Tax_Liens_4020_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL tax_liens_4020_recs := dx_EBR.mac_fetch_by_file_number(
      inf,
      ebr.Key_4020_Tax_Liens_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_4020_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number);

    RETURN tax_liens_4020_recs;
  ENDMACRO;

  /*
    **
    ** Macro to grab data from Key_4030_Judgement_FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT Judgement_4030_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL judgement_4030_recs := dx_EBR.mac_fetch_by_file_number(
      inf,
      ebr.Key_4030_Judgement_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_4030_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number);

    RETURN judgement_4030_recs;
  ENDMACRO;

  /*
    **
    ** Macro to grab data from Key_4500_Collateral_Accounts_FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT Collateral_Accounts_4500_by_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL collateral_accounts_4500_recs := dx_EBR.mac_fetch_by_file_number(
      inf,
      ebr.Key_4500_Collateral_Accounts_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_4500_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number);

    RETURN collateral_accounts_4500_recs;
  ENDMACRO;

 /*
    **
    ** Macro to grab data from Key_4510_UCC_Filings_FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT UCC_Filings_4510_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL ucc_filings_4510_recs := dx_EBR.mac_fetch_by_file_number(
      inf,
      ebr.Key_4510_UCC_Filings_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_4510_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number);

    RETURN ucc_filings_4510_recs;
  ENDMACRO;

  /*
    **
    ** Macro to grab data from Key_5000_Bank_Details_FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT Bank_Details_5000_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL bank_details_5000_recs := dx_EBR.mac_fetch_by_file_number(
      inf,
      ebr.Key_5000_Bank_Details_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_5000_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number);

    RETURN bank_details_5000_recs;
  ENDMACRO;

  /*
    **
    ** Macro to grab data from Key_5600_Demographic_Data_FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT Demographic_Data_5600_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL demographic_data_5600_recs := dx_EBR.mac_fetch_by_file_number(
      inf,
      ebr.Key_5600_Demographic_Data_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_5600_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number);

    RETURN demographic_data_5600_recs;
  ENDMACRO;

  /*
    **
    ** Macro to grab data from ebr.Key_5600_Demographic_Data_BDID
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_bdid_field         Field to use as bdid for input. OPTIONAL, defaults to 'bdid'.
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param excluded_sics          Sic codes from key to exclude from join condition. OPTIONAL, will be omitted if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT Demographic_5600_By_Bdid(
    inf,
    inf_bdid_field = 'bdid',
    keep_number = '',
    atmost_number = '',
    excluded_sics = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
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

  /*
    **
    ** Macro to grab data from Key_5610_Demographic_Data_FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT Demographic_Data_5610_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL demographic_data_5610_recs := dx_EBR.mac_fetch_by_file_number(
      inf,
      EBR.Key_5610_Demographic_Data_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_5610_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number);

    RETURN demographic_data_5610_recs;
  ENDMACRO;
  /*
    **
    ** Macro to grab data from Key_6000_Inquiries_FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT Inquiries_6000_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL inquiries_6000_recs := dx_EBR.mac_fetch_by_file_number(
      inf,
      EBR.Key_6000_Inquiries_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_5610_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number);

    RETURN inquiries_6000_recs;
  ENDMACRO;

  /*
    **
    ** Macro to grab data from Key_6500_Government_Trade_FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT Government_Trade_6500_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL government_trade_6500_recs := dx_EBR.mac_fetch_by_file_number(
      inf,
      EBR.Key_6500_Government_Trade_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_6500_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number);

    RETURN government_trade_6500_recs;
  ENDMACRO;

  /*
    **
    ** Macro to grab data from Key_6510_Government_Debarred_Contractor_FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT Government_Debarred_Contractor_5610_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL government_debarred_contractor_6510_recs := dx_EBR.mac_fetch_by_file_number(
      inf,
      EBR.Key_6510_Government_Debarred_Contractor_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_6510_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number);

    RETURN government_debarred_contractor_6510_recs;
  ENDMACRO;

  /*
    **
    ** Macro to grab data from Key_7010_SNP_Data_FILE_NUMBER
    ** This automatically applies the necessary incremental rollups.
    **
    ** @param inf                    Input dataset, must contain bdid field.
    ** @param inf_file_number_field  Field to use as file_number for input. OPTIONAL, defaults to 'file_number'
    ** @param keep_number            Number to use for KEEP(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @param atmost_number          Number to use for atmost(n) in join. OPTIONAL, will be omitted from join if not supplied.
    ** @returns                      DS of matching records from key in key layout.
    **
  */

  EXPORT SNP_Data_7010_By_File_Number(
    inf,
    inf_file_number_field = 'file_number',
    keep_number = '',
    atmost_number = '')
  := FUNCTIONMACRO

    IMPORT dx_EBR, EBR;
    LOCAL SNP_Data_7010_recs := dx_EBR.mac_fetch_by_file_number(
      inf,
      EBR.Key_7010_SNP_Data_FILE_NUMBER,
      dx_EBR.mod_delta_rid.key_7010_delta_rid,
      inf_file_number_field,
      keep_number,
      atmost_number);

    RETURN SNP_Data_7010_recs;
  ENDMACRO;

END;
