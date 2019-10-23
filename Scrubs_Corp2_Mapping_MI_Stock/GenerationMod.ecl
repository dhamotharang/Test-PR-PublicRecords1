// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.1';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Corp2_Mapping_MI_Stock';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'In_MI';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,corp_key,corp_vendor,corp_vendor_county,corp_vendor_subcode,corp_state_origin,corp_process_date,corp_sos_charter_nbr,stock_ticker_symbol,stock_exchange,stock_type,stock_class,stock_shares_issued,stock_authorized_nbr,stock_par_value,stock_nbr_par_shares,stock_change_ind,stock_change_date,stock_voting_rights_ind,stock_convert_ind,stock_convert_date,stock_change_in_cap,stock_tax_capital,stock_total_capital,stock_addl_info,stock_stock_description,stock_stock_series,stock_non_par_value_flag,stock_additional_stock,stock_shares_proportion_to_ohio_for_foreign_license,stock_share_credits,stock_authorized_capital,stock_stock_paid_in_capital,stock_pay_higher_stock_fees,stock_actual_amt_invested_in_state,stock_share_exchange_during_merger,stock_date_stock_limit_approved,stock_number_of_shares_paid_for,stock_total_value_of_shares_paid_for,stock_sharesofbeneficialinterest,stock_beneficialsharevalue';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
  EXPORT spc_HAS_CONSISTENT := FALSE;
  EXPORT spc_HAS_EXTERNAL := FALSE;
  EXPORT spc_HAS_PARENTS := FALSE;
  EXPORT spc_HAS_FORCE := FALSE;
  EXPORT spc_HAS_BLOCKLINK := FALSE;
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh \n'
    + 'MODULE:Scrubs_Corp2_Mapping_MI_Stock\n'
    + 'FILENAME:In_MI\n'
    + '//Uncomment up to NINES for internal or external adl\n'
    + '//IDFIELD:EXISTS:<NameOfIDField>\n'
    + '//RIDFIELD:<NameOfRidField>\n'
    + '//RECORDS:<NumberOfRecordsInDataFile>\n'
    + '//POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '//Uncomment Process if doing external adl\n'
    + '//PROCESS:<ProcessName>\n'
    + '//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '//FUZZY can be used to create new types of FUZZY linking\n'
    + '\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + 'FIELDTYPE:invalid_corp_key:ALLOW(-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(4..)\n'
    + 'FIELDTYPE:invalid_corp_vendor:ENUM(26)\n'
    + 'FIELDTYPE:invalid_state_origin:ENUM(MI)\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_date:ALLOW(0123456789):CUSTOM(Scrubs.fn_valid_pastDate>0)\n'
    + 'FIELDTYPE:invalid_charter_nbr:ALLOW(-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_stock_authorized_nbr:ALLOW(0123456789ABDEFGHILMNORSTQUWX )\n'
    + '\n'
    + '//FIELD DEFINITIONS\n'
    + 'FIELD:corp_key:TYPE(STRING30):LIKE(invalid_corp_key):0,0\n'
    + 'FIELD:corp_vendor:TYPE(STRING2):LIKE(invalid_corp_vendor):0,0\n'
    + 'FIELD:corp_vendor_county:TYPE(STRING3):0,0\n'
    + 'FIELD:corp_vendor_subcode:TYPE(STRING5):0,0\n'
    + 'FIELD:corp_state_origin:TYPE(STRING2):LIKE(invalid_state_origin):0,0\n'
    + 'FIELD:corp_process_date:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:corp_sos_charter_nbr:TYPE(STRING32):LIKE(invalid_charter_nbr):0,0\n'
    + 'FIELD:stock_ticker_symbol:TYPE(STRING5):0,0\n'
    + 'FIELD:stock_exchange:TYPE(STRING5):0,0\n'
    + 'FIELD:stock_type:TYPE(STRING20):0,0\n'
    + 'FIELD:stock_class:TYPE(STRING20):0,0\n'
    + 'FIELD:stock_shares_issued:TYPE(STRING15):0,0\n'
    + 'FIELD:stock_authorized_nbr:TYPE(STRING50):LIKE(invalid_stock_authorized_nbr):0,0\n'
    + 'FIELD:stock_par_value:TYPE(STRING15):0,0\n'
    + 'FIELD:stock_nbr_par_shares:TYPE(STRING15):0,0\n'
    + 'FIELD:stock_change_ind:TYPE(STRING1):0,0\n'
    + 'FIELD:stock_change_date:TYPE(STRING8):0,0\n'
    + 'FIELD:stock_voting_rights_ind:TYPE(STRING1):0,0\n'
    + 'FIELD:stock_convert_ind:TYPE(STRING1):0,0\n'
    + 'FIELD:stock_convert_date:TYPE(STRING8):0,0\n'
    + 'FIELD:stock_change_in_cap:TYPE(STRING8):0,0\n'
    + 'FIELD:stock_tax_capital:TYPE(STRING15):0,0\n'
    + 'FIELD:stock_total_capital:TYPE(STRING15):0,0\n'
    + 'FIELD:stock_addl_info:TYPE(STRING250):0,0\n'
    + 'FIELD:stock_stock_description:TYPE(STRING250):0,0\n'
    + 'FIELD:stock_stock_series:TYPE(STRING250):0,0\n'
    + 'FIELD:stock_non_par_value_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:stock_additional_stock:TYPE(STRING1):0,0\n'
    + 'FIELD:stock_shares_proportion_to_ohio_for_foreign_license:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:stock_share_credits:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:stock_authorized_capital:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:stock_stock_paid_in_capital:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:stock_pay_higher_stock_fees:TYPE(STRING1):0,0\n'
    + 'FIELD:stock_actual_amt_invested_in_state:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:stock_share_exchange_during_merger:TYPE(STRING1):0,0\n'
    + 'FIELD:stock_date_stock_limit_approved:TYPE(STRING8):0,0\n'
    + 'FIELD:stock_number_of_shares_paid_for:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:stock_total_value_of_shares_paid_for:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:stock_sharesofbeneficialinterest:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:stock_beneficialsharevalue:TYPE(UNSIGNED8):0,0\n'
    + '//CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '//RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '//SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '//LINKPATH is used to define access paths for external linking'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

