﻿// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Corp2_Mapping_ND_Main';
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
  EXPORT spc_FILENAME := 'In_ND';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dt_vendor_first_reported,dt_vendor_last_reported,dt_first_seen,dt_last_seen,corp_ra_dt_first_seen,corp_ra_dt_last_seen,corp_trademark_filing_date,corp_key,corp_vendor,corp_state_origin,corp_process_date,corp_orig_sos_charter_nbr,corp_legal_name,corp_filing_date,corp_status_date,corp_status_desc,corp_inc_state,corp_inc_date,corp_foreign_domestic_ind,corp_forgn_date,corp_for_profit_ind,corp_ln_name_type_cd,corp_ln_name_type_desc,corp_delayed_effective_date,corp_term_exist_exp,corp_trademark_expiration_date,recordorigin';
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
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Corp2_Mapping_ND_Main\n'
    + 'FILENAME:In_ND\n'
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
    + 'FIELDTYPE:invalid_corp_key:ALLOW(0123456789-):LENGTHS(13)\n'
    + 'FIELDTYPE:invalid_charter:ALLOW(0123456789):LENGTHS(10)\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_date:ALLOW(0123456789):LENGTHS(8):CUSTOM(Scrubs.fn_valid_pastDate>0)\n'
    + 'FIELDTYPE:invalid_optional_date:ALLOW(0123456789):LENGTHS(0,1,8):CUSTOM(Scrubs.fn_valid_GeneralDate>0)\n'
    + 'FIELDTYPE:invalid_corp_vendor:ENUM(38|38)\n'
    + 'FIELDTYPE:invalid_state_origin:ENUM(ND|ND)\n'
    + 'FIELDTYPE:invalid_forgn_dom_code:ENUM(D|F| )\n'
    + 'FIELDTYPE:invalid_for_profit_ind:ENUM(N| )\n'
    + 'FIELDTYPE:invalid_status:ENUM(Scrubs_Corp2_Mapping_ND_Main.Functions.set_valid_status)\n'
    + 'FIELDTYPE:invalid_name_type_desc:CUSTOM(Scrubs_Corp2_Mapping_ND_Main.Functions.invalid_name_type_desc>0,recordorigin)\n'
    + 'FIELDTYPE:invalid_name_type_cd:ENUM(01|03|04|F| )\n'
    + 'FIELDTYPE:invalid_recordorigin:ENUM(C|T)\n'
    + '\n'
    + '//FIELD DEFINITIONS\n'
    + 'DATEFIELD:dt_vendor_first_reported:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'DATEFIELD:dt_vendor_last_reported:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'DATEFIELD:dt_first_seen:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'DATEFIELD:dt_last_seen:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'DATEFIELD:corp_ra_dt_first_seen:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'DATEFIELD:corp_ra_dt_last_seen:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'DATEFIELD:corp_trademark_filing_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + 'FIELD:corp_key:TYPE(STRING30):LIKE(invalid_corp_key):0,0\n'
    + 'FIELD:corp_vendor:TYPE(STRING2):LIKE(invalid_corp_vendor):0,0\n'
    + 'FIELD:corp_state_origin:TYPE(STRING2):LIKE(invalid_state_origin):0,0\n'
    + 'DATEFIELD:corp_process_date:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:corp_orig_sos_charter_nbr:TYPE(STRING32):LIKE(invalid_charter):0,0\n'
    + 'FIELD:corp_legal_name:TYPE(STRING350):LIKE(invalid_mandatory):0,0\n'
    + 'DATEFIELD:corp_filing_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + 'DATEFIELD:corp_status_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + 'FIELD:corp_status_desc:TYPE(STRING60):LIKE(invalid_status):0,0\n'
    + 'FIELD:corp_inc_state:TYPE(STRING2):LIKE(invalid_state_origin):0,0\n'
    + 'DATEFIELD:corp_inc_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + 'FIELD:corp_foreign_domestic_ind:TYPE(STRING1):LIKE(invalid_forgn_dom_code):0,0\n'
    + 'DATEFIELD:corp_forgn_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + 'FIELD:corp_for_profit_ind:TYPE(STRING1):LIKE(invalid_for_profit_ind):0,0\n'
    + 'FIELD:corp_ln_name_type_cd:TYPE(STRING2):LIKE(invalid_name_type_cd):0,0\n'
    + 'FIELD:corp_ln_name_type_desc:TYPE(STRING30):LIKE(invalid_name_type_desc):0,0\n'
    + 'DATEFIELD:corp_delayed_effective_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0 \n'
    + 'DATEFIELD:corp_term_exist_exp:TYPE(STRING60):LIKE(invalid_optional_date):0,0    \n'
    + 'DATEFIELD:corp_trademark_expiration_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + 'FIELD:recordorigin:TYPE(STRING1):LIKE(invalid_recordorigin):0,0\n'
    + '\n'
    + '\n'
    + '//FIELDS NOT BEING SCRUBBED\n'
    + '// FIELD:corp_trademark_renewal_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + '// FIELD:corp_orig_org_structure_cd:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_last_renewal_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + '// DATEFIELD:corp_ra_effective_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + '// DATEFIELD:corp_ra_resign_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + '// DATEFIELD:cont_effective_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + '// DATEFIELD:corp_merger_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + '// FIELD:corp_merger_indicator:TYPE(STRING1):LIKE(invalid_merger_indicator):0,0\n'
    + '// DATEFIELD:corp_name_effective_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + '// FIELD:corp_merger_id:TYPE(STRING32):LIKE(invalid_merger_id):0,0\n'
    + '// DATEFIELD:corp_name_reservation_expiration_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + '// FIELD:corp_name_status_cd:TYPE(STRING2):LIKE(invalid_corp_name_status_cd):0,0\n'
    + '// DATEFIELD:corp_name_status_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + '// FIELD:corp_name_status_description:TYPE(STRING50):LIKE(invalid_corp_name_status_desc):0,0\n'
    + '// FIELD:corp_orig_org_structure_desc:TYPE(STRING60):LIKE(invalid_corp_orig_org_structure_desc):0,0\n'
    + '// DATEFIELD:corp_merger_effective_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + '// FIELD:corp_fed_tax_id:TYPE(STRING32):LIKE(invalid_fein):0,0\n'
    + '// FIELD:cont_status_cd:TYPE(STRING8):LIKE(invalid_cont_status_cd):0,0 \n'
    + '// DATEFIELD:corp_status_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + '// FIELD:corp_status_cd:TYPE(STRING8):LIKE(invalid_corp_status_cd):0,0\n'
    + '// DATEFIELD:corp_merger_effective_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + '// FIELD:corp_forgn_state_desc:TYPE(STRING60):0,0\n'
    + '// FIELD:corp_forgn_state_cd:TYPE(STRING3):0,0\n'
    + '// FIELD:corp_address1_type_cd:TYPE(STRING8):LIKE(invalid_address1_type_cd):0,0\n'
    + '// FIELD:corp_address1_type_desc:TYPE(STRING60):LIKE(invalid_address1_type_desc):0,0\n'
    + '// FIELD:corp_term_exist_cd:TYPE(STRING8):LIKE(invalid_corp_term_exist_cd):0,0\n'
    + '// FIELD:corp_term_exist_desc:TYPE(STRING8):LIKE(invalid_corp_term_exist_desc):0,0\n'
    + '// FIELD:corp_ra_full_name:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:corp_ra_address_type_cd:TYPE(STRING8):LIKE(invalid_ra_addr_type_cd):0,0\n'
    + '// FIELD:corp_ra_address_type_desc:TYPE(STRING60):LIKE(invalid_ra_addr_type_desc):0,0\n'
    + '// FIELD:cont_type_cd:TYPE(STRING8):LIKE(invalid_cont_type_cd):0,0\n'
    + '// FIELD:cont_type_desc:TYPE(STRING60):LIKE(invalid_cont_type_desc):0,0\n'
    + '// FIELD:cont_title1_desc:TYPE(STRING60):LIKE(invalid_cont_title1_desc):0,0\n'
    + '// FIELD:cont_address_type_cd:TYPE(STRING8):LIKE(invalid_cont_type_cd):0,0\n'
    + '// FIELD:cont_address_type_desc:TYPE(STRING60):LIKE(invalid_cont_type_desc):0,0\n'
    + '// FIELD:corp_supp_key:TYPE(STRING30):0,0\n'
    + '// FIELD:corp_vendor_county:TYPE(STRING3):0,0\n'
    + '// FIELD:corp_vendor_subcode:TYPE(STRING5):0,0\n'
    + '// FIELD:corp_supp_nbr:TYPE(STRING32):0,0\n'
    + '// FIELD:corp_country_of_formation:TYPE(STRING50):0,0\n'
    + '// FIELD:corp_name_comment:TYPE(STRING250):0,0\n'
    + '// DATEFIELD:corp_address1_effective_date:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_address2_type_cd:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_address2_type_desc:TYPE(STRING60):0,0\n'
    + '// DATEFIELD:corp_address2_effective_date:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_phone_number:TYPE(STRING30):0,0\n'
    + '// FIELD:corp_phone_number_type_cd:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_phone_number_type_desc:TYPE(STRING60):0,0\n'
    + '// FIELD:corp_fax_nbr:TYPE(STRING15):0,0\n'
    + '// FIELD:corp_email_address:TYPE(STRING30):0,0\n'
    + '// FIELD:corp_web_address:TYPE(STRING30):0,0\n'
    + '// FIELD:corp_filing_reference_nbr:TYPE(STRING30):0,0\n'
    + '// FIELD:corp_filing_cd:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_filing_desc:TYPE(STRING60):0,0\n'
    + '// FIELD:corp_standing:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_status_comment:TYPE(STRING350):0,0\n'
    + '// FIELD:corp_ticker_symbol:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_stock_exchange:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_inc_county:TYPE(STRING30):0,0\n'
    + '// FIELD:corp_anniversary_month:TYPE(STRING15):0,0\n'
    + '// FIELD:corp_state_tax_id:TYPE(STRING32):0,0\n'
    + '// FIELD:corp_forgn_sos_charter_nbr:TYPE(STRING32):0,0\n'
    + '// FIELD:corp_forgn_fed_tax_id:TYPE(STRING32):0,0\n'
    + '// FIELD:corp_forgn_state_tax_id:TYPE(STRING32):0,0\n'
    + '// FIELD:corp_forgn_term_exist_cd:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_forgn_term_exist_exp:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_forgn_term_exist_desc:TYPE(STRING60):0,0\n'
    + '// FIELD:corp_public_or_private_ind:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_sic_code:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_naic_code:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_orig_bus_type_cd:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_orig_bus_type_desc:TYPE(STRING350):0,0\n'
    + '// FIELD:corp_entity_desc:TYPE(STRING350):0,0\n'
    + '// FIELD:corp_certificate_nbr:TYPE(STRING32):0,0\n'
    + '// FIELD:corp_internal_nbr:TYPE(STRING32):0,0\n'
    + '// FIELD:corp_previous_nbr:TYPE(STRING32):0,0\n'
    + '// FIELD:corp_microfilm_nbr:TYPE(STRING32):0,0\n'
    + '// FIELD:corp_amendments_filed:TYPE(STRING5):0,0\n'
    + '// FIELD:corp_acts:TYPE(STRING50):0,0\n'
    + '// FIELD:corp_partnership_ind:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_mfg_ind:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_addl_info:TYPE(STRING250):0,0\n'
    + '// FIELD:corp_taxes:TYPE(STRING10):0,0\n'
    + '// FIELD:corp_franchise_taxes:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_tax_program_cd:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_tax_program_desc:TYPE(STRING30):0,0\n'
    + '// FIELD:corp_ra_title_cd:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_ra_title_desc:TYPE(STRING60):0,0\n'
    + '// FIELD:corp_ra_fein:TYPE(STRING10):0,0\n'
    + '// FIELD:corp_ra_ssn:TYPE(STRING9):0,0\n'
    + '// FIELD:corp_ra_dob:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_ra_no_comp:TYPE(STRING5):0,0\n'
    + '// FIELD:corp_ra_no_comp_igs:TYPE(STRING5):0,0\n'
    + '// FIELD:corp_ra_addl_info:TYPE(STRING250):0,0\n'
    + '// FIELD:corp_ra_phone_number:TYPE(STRING30):0,0\n'
    + '// FIELD:corp_ra_phone_number_type_cd:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_ra_phone_number_type_desc:TYPE(STRING60):0,0\n'
    + '// FIELD:corp_ra_fax_nbr:TYPE(STRING15):0,0\n'
    + '// FIELD:corp_ra_email_address:TYPE(STRING30):0,0\n'
    + '// FIELD:corp_ra_web_address:TYPE(STRING30):0,0\n'
    + '// FIELD:cont_filing_reference_nbr:TYPE(STRING30):0,0\n'
    + '// FIELD:cont_filing_cd:TYPE(STRING8):0,0\n'
    + '// FIELD:cont_filing_desc:TYPE(STRING60):0,0\n'
    + '// FIELD:cont_title2_desc:TYPE(STRING60):0,0\n'
    + '// FIELD:cont_title3_desc:TYPE(STRING60):0,0\n'
    + '// FIELD:cont_title4_desc:TYPE(STRING60):0,0\n'
    + '// FIELD:cont_title5_desc:TYPE(STRING60):0,0\n'
    + '// FIELD:cont_fein:TYPE(STRING10):0,0\n'
    + '// FIELD:cont_ssn:TYPE(STRING9):0,0\n'
    + '// FIELD:cont_dob:TYPE(STRING8):0,0\n'
    + '// FIELD:cont_status_desc:TYPE(STRING60):0,0\n'
    + '// FIELD:cont_effective_cd:TYPE(STRING1):0,0\n'
    + '// FIELD:cont_effective_desc:TYPE(STRING60):0,0\n'
    + '// FIELD:cont_addl_info:TYPE(STRING350):0,0\n'
    + '// DATEFIELD:cont_address_effective_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + '// DATEFIELD:cont_filing_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0\n'
    + '// FIELD:cont_address_county:TYPE(STRING30):0,0\n'
    + '// FIELD:cont_phone_number:TYPE(STRING30):0,0\n'
    + '// FIELD:cont_phone_number_type_cd:TYPE(STRING8):0,0\n'
    + '// FIELD:cont_phone_number_type_desc:TYPE(STRING60):0,0\n'
    + '// FIELD:cont_fax_nbr:TYPE(STRING15):0,0\n'
    + '// FIELD:cont_email_address:TYPE(STRING30):0,0\n'
    + '// FIELD:cont_web_address:TYPE(STRING30):0,0\n'
    + '// FIELD:corp_acres:TYPE(STRING50):0,0\n'
    + '// FIELD:corp_action:TYPE(STRING10):0,0\n'
    + '// DATEFIELD:corp_action_date:TYPE(STRING10):0,0\n'
    + '// DATEFIELD:corp_action_employment_security_approval_date:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_action_pending_code:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_action_pending_description:TYPE(STRING50):0,0\n'
    + '// DATEFIELD:corp_action_statement_of_intent_date:TYPE(STRING8):0,0\n'
    + '// DATEFIELD:corp_action_tax_dept_approval_date:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_acts2:TYPE(STRING50):0,0\n'
    + '// FIELD:corp_acts3:TYPE(STRING50):0,0\n'
    + '// FIELD:corp_additional_principals:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_address_office_type:TYPE(STRING50):0,0\n'
    + '// FIELD:corp_agent_commercial:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_agent_country:TYPE(STRING50):0,0\n'
    + '// FIELD:corp_agent_county:TYPE(STRING20):0,0\n'
    + '// FIELD:corp_agent_status:TYPE(STRING2):0,0\n'
    + '// FIELD:corp_agent_status_description:TYPE(STRING50):0,0\n'
    + '// FIELD:corp_agent_id:TYPE(STRING8):0,0\n'
    + '// DATEFIELD:corp_agent_assign_date:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_agriculture_flag:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_authorized_partners:TYPE(STRING):0,0\n'
    + '// FIELD:corp_cmt:TYPE(STRING2):0,0\n'
    + '// FIELD:corp_consent_flag_for_protected_name:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_converted:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_converted_from:TYPE(STRING50):0,0\n'
    + '// DATEFIELD:corp_date_of_organization_meeting:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_directors_from_to:TYPE(STRING10):0,0\n'
    + '// FIELD:corp_farm_exemptions:TYPE(STRING30):0,0\n'
    + '// DATEFIELD:corp_farm_qual_date:TYPE(STRING10):0,0\n'
    + '// FIELD:corp_farm_status_cd:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_farm_status_desc:TYPE(STRING100):0,0\n'
    + '// DATEFIELD:corp_farm_status_date:TYPE(STRING10):0,0\n'
    + '// FIELD:corp_fiscal_year_month:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_foreign_fiduciary_capacity_in_state:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_governing_statute:TYPE(STRING20):0,0\n'
    + '// FIELD:corp_hasmembers:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_hasvestedmanagers:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_home_incorporated_county:TYPE(STRING60):0,0\n'
    + '// FIELD:corp_home_state_name:TYPE(STRING30):0,0\n'
    + '// FIELD:corp_is_professional:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_isnonprofitirsapproved:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_last_renewal_year:TYPE(STRING4):0,0\n'
    + '// FIELD:corp_license_type:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_llc_managed_cd:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_llc_managed_desc:TYPE(STRING100):0,0\n'
    + '// FIELD:corp_management_description:TYPE(STRING50):0,0\n'
    + '// FIELD:corp_management_type:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_manager_managed:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_merged_fein:TYPE(STRING9):0,0\n'
    + '// FIELD:corp_merger_allowed_flag:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_merger_description:TYPE(STRING250):0,0\n'
    + '// FIELD:corp_merger_name:TYPE(STRING100):0,0\n'
    + '// FIELD:corp_merger_type_converted_to_code:TYPE(STRING4):0,0\n'
    + '// FIELD:corp_merger_type_converted_to_description:TYPE(STRING100):0,0\n'
    + '// FIELD:corp_naics_description:TYPE(STRING60):0,0\n'
    + '// DATEFIELD:corp_name_reservation_date:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_name_reservation_number:TYPE(STRING32):0,0\n'
    + '// FIELD:corp_name_reservation_type:TYPE(STRING100):0,0\n'
    + '// FIELD:corp_nonprofitirsapprovedpurpose:TYPE(STRING):0,0\n'
    + '// FIELD:corp_nonprofitsolicitdonations:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_number_of_amendments:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:corp_number_of_initial_llc_members:TYPE(STRING):0,0\n'
    + '// FIELD:corp_number_of_partners:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:corp_operatingagreement:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_opt_in_llc_act_description:TYPE(STRING50):0,0\n'
    + '// FIELD:corp_opt_in_llc_act_ind:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_organizational_comments:TYPE(STRING250):0,0\n'
    + '// FIELD:corp_original_business_type:TYPE(STRING2):0,0\n'
    + '// FIELD:corp_partner_contributions_total:TYPE(INTEGER8):0,0\n'
    + '// FIELD:corp_partner_terms:TYPE(STRING):0,0\n'
    + '// FIELD:corp_percentage_voters_required_to_approve_amendments:TYPE(STRING):0,0\n'
    + '// FIELD:corp_profession:TYPE(STRING250):0,0\n'
    + '// FIELD:corp_province:TYPE(STRING20):0,0\n'
    + '// FIELD:corp_public_mutual_corporation:TYPE(STRING10):0,0\n'
    + '// FIELD:corp_purpose:TYPE(STRING250):0,0\n'
    + '// FIELD:corp_ra_required_flag:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_registered_counties:TYPE(STRING):0,0\n'
    + '// FIELD:corp_regulated_ind:TYPE(STRING1):0,0\n'
    + '// DATEFIELD:corp_renewal_date:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_standing_other:TYPE(STRING50):0,0\n'
    + '// FIELD:corp_survivor_corporation_id:TYPE(STRING32):0,0\n'
    + '// FIELD:corp_tax_base:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_tax_standing:TYPE(STRING50):0,0\n'
    + '// FIELD:corp_termination_code:TYPE(STRING2):0,0\n'
    + '// FIELD:corp_termination_description:TYPE(STRING100):0,0\n'
    + '// DATEFIELD:corp_termination_date:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_trademark_classification_number:TYPE(STRING10):0,0\n'
    + '// DATEFIELD:corp_trademark_first_use_date:TYPE(STRING8):0,0\n'
    + '// DATEFIELD:corp_trademark_first_use_date_in_state:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_trademark_business_mark_type:TYPE(STRING20):0,0\n'
    + '// DATEFIELD:corp_trademark_cancelled_date:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_trademark_class_description1:TYPE(STRING250):0,0\n'
    + '// FIELD:corp_trademark_class_description2:TYPE(STRING250):0,0\n'
    + '// FIELD:corp_trademark_class_description3:TYPE(STRING250):0,0\n'
    + '// FIELD:corp_trademark_class_description4:TYPE(STRING250):0,0\n'
    + '// FIELD:corp_trademark_class_description5:TYPE(STRING250):0,0\n'
    + '// FIELD:corp_trademark_class_description6:TYPE(STRING250):0,0\n'
    + '// FIELD:corp_trademark_disclaimer1:TYPE(STRING50):0,0\n'
    + '// FIELD:corp_trademark_disclaimer2:TYPE(STRING50):0,0\n'
    + '// FIELD:corp_trademark_keywords:TYPE(STRING250):0,0\n'
    + '// FIELD:corp_trademark_logo:TYPE(STRING250):0,0\n'
    + '// FIELD:corp_trademark_name_expiration_date:TYPE(STRING8):0,0\n'
    + '// FIELD:corp_trademark_number:TYPE(STRING12):0,0\n'
    + '// FIELD:corp_trademark_status:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_trademark_used_1:TYPE(STRING50):0,0\n'
    + '// FIELD:corp_trademark_used_2:TYPE(STRING50):0,0\n'
    + '// FIELD:corp_trademark_used_3:TYPE(STRING50):0,0\n'
    + '// FIELD:cont_owner_percentage:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:cont_country:TYPE(STRING50):0,0\n'
    + '// FIELD:cont_country_mailing:TYPE(STRING50):0,0\n'
    + '// FIELD:cont_nondislosure:TYPE(STRING1):0,0\n'
    + '// FIELD:corp_prep_addr1_line1:TYPE(STRING100):0,0\n'
    + '// FIELD:corp_prep_addr1_last_line:TYPE(STRING50):0,0\n'
    + '// FIELD:corp_prep_addr2_line1:TYPE(STRING100):0,0\n'
    + '// FIELD:corp_prep_addr2_last_line:TYPE(STRING50):0,0\n'
    + '// FIELD:ra_prep_addr_line1:TYPE(STRING100):0,0\n'
    + '// FIELD:ra_prep_addr_last_line:TYPE(STRING50):0,0\n'
    + '// FIELD:corp_ra_address_line1:TYPE(STRING70):0,0\n'
    + '// FIELD:corp_ra_address_line2:TYPE(STRING70):0,0\n'
    + '// FIELD:corp_ra_address_line3:TYPE(STRING70):0,0\n'
    + '// FIELD:corp_ra_fname:TYPE(STRING20):0,0\n'
    + '// FIELD:corp_ra_mname:TYPE(STRING20):0,0\n'
    + '// FIELD:corp_ra_lname:TYPE(STRING20):0,0\n'
    + '// FIELD:corp_ra_suffix:TYPE(STRING5):0,0\n'
    + '// FIELD:cont_prep_addr_line1:TYPE(STRING100):0,0\n'
    + '// FIELD:cont_prep_addr_last_line:TYPE(STRING50):0,0\n'
    + '// FIELD:corp_address1_line1:TYPE(STRING70):0,0\n'
    + '// FIELD:corp_address1_line2:TYPE(STRING70):0,0\n'
    + '// FIELD:corp_address1_line3:TYPE(STRING70):0,0\n'
    + '// FIELD:cont_full_name:TYPE(STRING100):0,0\n'
    + '// FIELD:cont_fname:TYPE(STRING20):0,0\n'
    + '// FIELD:cont_mname:TYPE(STRING20):0,0\n'
    + '// FIELD:cont_lname:TYPE(STRING20):0,0\n'
    + '// FIELD:cont_suffix:TYPE(STRING5):0,0\n'
    + '// FIELD:cont_address_line1:TYPE(STRING70):0,0\n'
    + '// FIELD:cont_address_line2:TYPE(STRING70):0,0\n'
    + '// FIELD:cont_address_line3:TYPE(STRING70):0,0\n'
    + '// FIELD:corp_address2_line1:TYPE(STRING70):0,0\n'
    + '// FIELD:corp_address2_line2:TYPE(STRING70):0,0\n'
    + '// FIELD:corp_address2_line3:TYPE(STRING70):0,0\n'
    + '\n'
    + '//CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '//RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '//SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '//LINKPATH is used to define access paths for external linking'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

