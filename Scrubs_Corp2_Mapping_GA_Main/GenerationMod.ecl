﻿// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Corp2_Mapping_GA_Main';
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
  EXPORT spc_FILENAME := 'in_file';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dt_vendor_first_reported,dt_vendor_last_reported,dt_first_seen,dt_last_seen,corp_ra_dt_first_seen,corp_ra_dt_last_seen,corp_key,corp_supp_key,corp_vendor,corp_vendor_county,corp_vendor_subcode,corp_state_origin,corp_process_date,corp_orig_sos_charter_nbr,corp_legal_name,corp_ln_name_type_cd,corp_ln_name_type_desc,corp_supp_nbr,corp_name_comment,corp_address1_type_cd,corp_address1_type_desc,corp_address1_line1,corp_address1_line2,corp_address1_line3,corp_address1_effective_date,corp_address2_type_cd,corp_address2_type_desc,corp_address2_line1,corp_address2_line2,corp_address2_line3,corp_address2_effective_date,corp_phone_number,corp_phone_number_type_cd,corp_phone_number_type_desc,corp_fax_nbr,corp_email_address,corp_web_address,corp_filing_reference_nbr,corp_filing_date,corp_filing_cd,corp_filing_desc,corp_status_cd,corp_status_desc,corp_status_date,corp_standing,corp_status_comment,corp_ticker_symbol,corp_stock_exchange,corp_inc_state,corp_inc_county,corp_inc_date,corp_anniversary_month,corp_fed_tax_id,corp_state_tax_id,corp_term_exist_cd,corp_term_exist_exp,corp_term_exist_desc,corp_foreign_domestic_ind,corp_forgn_state_cd,corp_forgn_state_desc,corp_forgn_sos_charter_nbr,corp_forgn_date,corp_forgn_fed_tax_id,corp_forgn_state_tax_id,corp_forgn_term_exist_cd,corp_forgn_term_exist_exp,corp_forgn_term_exist_desc,corp_orig_org_structure_cd,corp_orig_org_structure_desc,corp_for_profit_ind,corp_public_or_private_ind,corp_sic_code,corp_naic_code,corp_orig_bus_type_cd,corp_orig_bus_type_desc,corp_entity_desc,corp_certificate_nbr,corp_internal_nbr,corp_previous_nbr,corp_microfilm_nbr,corp_amendments_filed,corp_acts,corp_partnership_ind,corp_mfg_ind,corp_addl_info,corp_taxes,corp_franchise_taxes,corp_tax_program_cd,corp_tax_program_desc,corp_ra_full_name,corp_ra_fname,corp_ra_mname,corp_ra_lname,corp_ra_suffix,corp_ra_title_cd,corp_ra_title_desc,corp_ra_fein,corp_ra_ssn,corp_ra_dob,corp_ra_effective_date,corp_ra_resign_date,corp_ra_no_comp,corp_ra_no_comp_igs,corp_ra_addl_info,corp_ra_address_type_cd,corp_ra_address_type_desc,corp_ra_address_line1,corp_ra_address_line2,corp_ra_address_line3,corp_ra_phone_number,corp_ra_phone_number_type_cd,corp_ra_phone_number_type_desc,corp_ra_fax_nbr,corp_ra_email_address,corp_ra_web_address,corp_prep_addr1_line1,corp_prep_addr1_last_line,corp_prep_addr2_line1,corp_prep_addr2_last_line,ra_prep_addr_line1,ra_prep_addr_last_line,cont_filing_reference_nbr,cont_filing_date,cont_filing_cd,cont_filing_desc,cont_type_cd,cont_type_desc,cont_full_name,cont_fname,cont_mname,cont_lname,cont_suffix,cont_title1_desc,cont_title2_desc,cont_title3_desc,cont_title4_desc,cont_title5_desc,cont_fein,cont_ssn,cont_dob,cont_status_cd,cont_status_desc,cont_effective_date,cont_effective_cd,cont_effective_desc,cont_addl_info,cont_address_type_cd,cont_address_type_desc,cont_address_line1,cont_address_line2,cont_address_line3,cont_address_effective_date,cont_address_county,cont_phone_number,cont_phone_number_type_cd,cont_phone_number_type_desc,cont_fax_nbr,cont_email_address,cont_web_address,corp_acres,corp_action,corp_action_date,corp_action_employment_security_approval_date,corp_action_pending_cd,corp_action_pending_desc,corp_action_statement_of_intent_date,corp_action_tax_dept_approval_date,corp_acts2,corp_acts3,corp_additional_principals,corp_address_office_type,corp_agent_assign_date,corp_agent_commercial,corp_agent_country,corp_agent_county,corp_agent_status_cd,corp_agent_status_desc,corp_agent_id,corp_agriculture_flag,corp_authorized_partners,corp_comment,corp_consent_flag_for_protected_name,corp_converted,corp_converted_from,corp_country_of_formation,corp_date_of_organization_meeting,corp_delayed_effective_date,corp_directors_from_to,corp_dissolved_date,corp_farm_exemptions,corp_farm_qual_date,corp_farm_status_cd,corp_farm_status_desc,corp_fiscal_year_month,corp_foreign_fiduciary_capacity_in_state,corp_governing_statute,corp_has_members,corp_has_vested_managers,corp_home_incorporated_county,corp_home_state_name,corp_is_professional,corp_is_non_profit_irs_approved,corp_last_renewal_date,corp_last_renewal_year,corp_license_type,corp_llc_managed_desc,corp_llc_managed_ind,corp_management_desc,corp_management_type,corp_manager_managed,corp_merged_corporation_id,corp_merged_fein,corp_merger_allowed_flag,corp_merger_date,corp_merger_desc,corp_merger_effective_date,corp_merger_id,corp_merger_indicator,corp_merger_name,corp_merger_type_converted_to_cd,corp_merger_type_converted_to_desc,corp_naics_desc,corp_name_effective_date,corp_name_reservation_date,corp_name_reservation_desc,corp_name_reservation_expiration_date,corp_name_reservation_nbr,corp_name_reservation_type,corp_name_status_cd,corp_name_status_date,corp_name_status_desc,corp_non_profit_irs_approved_purpose,corp_non_profit_solicit_donations,corp_nbr_of_amendments,corp_nbr_of_initial_llc_members,corp_nbr_of_partners,corp_operating_agreement,corp_opt_in_llc_act_desc,corp_opt_in_llc_act_ind,corp_organizational_comments,corp_partner_contributions_total,corp_partner_terms,corp_percentage_voters_required_to_approve_amendments,corp_profession,corp_province,corp_public_mutual_corporation,corp_purpose,corp_ra_required_flag,corp_registered_counties,corp_regulated_ind,corp_renewal_date,corp_standing_other,corp_survivor_corporation_id,corp_tax_base,corp_tax_standing,corp_termination_cd,corp_termination_desc,corp_termination_date,corp_trademark_business_mark_type,corp_trademark_cancelled_date,corp_trademark_class_desc1,corp_trademark_class_desc2,corp_trademark_class_desc3,corp_trademark_class_desc4,corp_trademark_class_desc5,corp_trademark_class_desc6,corp_trademark_classification_nbr,corp_trademark_disclaimer1,corp_trademark_disclaimer2,corp_trademark_expiration_date,corp_trademark_filing_date,corp_trademark_first_use_date,corp_trademark_first_use_date_in_state,corp_trademark_keywords,corp_trademark_logo,corp_trademark_name_expiration_date,corp_trademark_nbr,corp_trademark_renewal_date,corp_trademark_status,corp_trademark_used_1,corp_trademark_used_2,corp_trademark_used_3,cont_owner_percentage,cont_country,cont_country_mailing,cont_nondislosure,cont_prep_addr_line1,cont_prep_addr_last_line,recordorigin';
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
    + 'MODULE:Scrubs_Corp2_Mapping_GA_Main\n'
    + 'FILENAME:in_file\n'
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
    + 'FIELDTYPE:invalid_corp_key:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-):LENGTHS(4..)\n'
    + 'FIELDTYPE:invalid_corp_vendor:ENUM(13|13)\n'
    + 'FIELDTYPE:invalid_state_origin:ENUM(GA|GA)\n'
    + 'FIELDTYPE:invalid_name_type_code:CUSTOM(Scrubs_Corp2_Mapping_GA_Main.Functions.invalid_ln_name_type_cd>0,recordorigin)\n'
    + 'FIELDTYPE:invalid_name_type_desc:CUSTOM(Scrubs_Corp2_Mapping_GA_Main.Functions.invalid_ln_name_type_desc>0,recordorigin)\n'
    + 'FIELDTYPE:invalid_forgn_dom_code:ENUM(D|F| )\n'
    + 'FIELDTYPE:invalid_flag_code:ENUM(N|Y| )\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_numeric:ALLOW(0123456789):LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_charter:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-):LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_date:ALLOW(0123456789):LENGTHS(0..8):CUSTOM(Scrubs.fn_valid_pastDate>0)\n'
    + 'FIELDTYPE:invalid_future_date:ALLOW(0123456789):CUSTOM(Scrubs.fn_valid_GeneralDate>0)\n'
    + 'FIELDTYPE:invalid_zip:ALLOW(0123456789):LENGTHS(5,9)\n'
    + 'FIELDTYPE:invalid_phone:ALLOW(0123456789-):LENGTHS(0..12):SPACES( )\n'
    + 'FIELDTYPE:invalid_recordorigin:ENUM(C|T|)\n'
    + 'FIELDTYPE:invalid_alphablank:ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_characters:ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXYZ/-()&.\')\n'
    + 'FIELDTYPE:invalid_State_Desc:ALLOW( &ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + '\n'
    + 'DATEFIELD:dt_vendor_first_reported:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'DATEFIELD:dt_vendor_last_reported:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'DATEFIELD:dt_first_seen:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'DATEFIELD:dt_last_seen:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'DATEFIELD:corp_ra_dt_first_seen:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'DATEFIELD:corp_ra_dt_last_seen:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:corp_key:TYPE(STRING30):LIKE(invalid_corp_key):0,0\n'
    + 'FIELD:corp_supp_key:TYPE(STRING30):0,0\n'
    + 'FIELD:corp_vendor:TYPE(STRING2):LIKE(invalid_corp_vendor):0,0\n'
    + 'FIELD:corp_vendor_county:TYPE(STRING3):0,0\n'
    + 'FIELD:corp_vendor_subcode:TYPE(STRING5):0,0\n'
    + 'FIELD:corp_state_origin:TYPE(STRING2):LIKE(invalid_state_origin):0,0\n'
    + 'DATEFIELD:corp_process_date:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:corp_orig_sos_charter_nbr:TYPE(STRING32):LIKE(invalid_charter):0,0\n'
    + 'FIELD:corp_legal_name:TYPE(STRING350):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:corp_ln_name_type_cd:TYPE(STRING2):LIKE(invalid_name_type_code):0,0\n'
    + 'FIELD:corp_ln_name_type_desc:TYPE(STRING30):LIKE(invalid_name_type_desc):0,0\n'
    + 'FIELD:corp_supp_nbr:TYPE(STRING32):0,0\n'
    + 'FIELD:corp_name_comment:TYPE(STRING250):0,0\n'
    + 'FIELD:corp_address1_type_cd:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_address1_type_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:corp_address1_line1:TYPE(STRING70):0,0\n'
    + 'FIELD:corp_address1_line2:TYPE(STRING70):0,0\n'
    + 'FIELD:corp_address1_line3:TYPE(STRING70):0,0\n'
    + 'FIELD:corp_address1_effective_date:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:corp_address2_type_cd:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_address2_type_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:corp_address2_line1:TYPE(STRING70):0,0\n'
    + 'FIELD:corp_address2_line2:TYPE(STRING70):0,0\n'
    + 'FIELD:corp_address2_line3:TYPE(STRING70):0,0\n'
    + 'FIELD:corp_address2_effective_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_phone_number:TYPE(STRING30):LIKE(invalid_phone):0,0\n'
    + 'FIELD:corp_phone_number_type_cd:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_phone_number_type_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:corp_fax_nbr:TYPE(STRING15):0,0\n'
    + 'FIELD:corp_email_address:TYPE(STRING30):0,0\n'
    + 'FIELD:corp_web_address:TYPE(STRING30):0,0\n'
    + 'FIELD:corp_filing_reference_nbr:TYPE(STRING30):0,0\n'
    + 'FIELD:corp_filing_date:TYPE(STRING8):LIKE(invalid_future_date):0,0\n'
    + 'FIELD:corp_filing_cd:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_filing_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:corp_status_cd:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_status_desc:TYPE(STRING60):LIKE(invalid_characters):0,0\n'
    + 'FIELD:corp_status_date:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:corp_standing:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_status_comment:TYPE(STRING350):0,0\n'
    + 'FIELD:corp_ticker_symbol:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_stock_exchange:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_inc_state:TYPE(STRING2):LIKE(invalid_state_origin):0,0\n'
    + 'FIELD:corp_inc_county:TYPE(STRING30):0,0\n'
    + 'FIELD:corp_inc_date:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:corp_anniversary_month:TYPE(STRING15):0,0\n'
    + 'FIELD:corp_fed_tax_id:TYPE(STRING32):0,0\n'
    + 'FIELD:corp_state_tax_id:TYPE(STRING32):0,0\n'
    + 'FIELD:corp_term_exist_cd:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_term_exist_exp:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_term_exist_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:corp_foreign_domestic_ind:TYPE(STRING1):LIKE(invalid_forgn_dom_code):0,0\n'
    + 'FIELD:corp_forgn_state_cd:TYPE(STRING3):LIKE(invalid_alphablank):0,0\n'
    + 'FIELD:corp_forgn_state_desc:TYPE(STRING60):LIKE(invalid_State_Desc):0,0\n'
    + 'FIELD:corp_forgn_sos_charter_nbr:TYPE(STRING32):0,0\n'
    + 'FIELD:corp_forgn_date:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:corp_forgn_fed_tax_id:TYPE(STRING32):0,0\n'
    + 'FIELD:corp_forgn_state_tax_id:TYPE(STRING32):0,0\n'
    + 'FIELD:corp_forgn_term_exist_cd:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_forgn_term_exist_exp:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_forgn_term_exist_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:corp_orig_org_structure_cd:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_orig_org_structure_desc:TYPE(STRING60):LIKE(invalid_characters):0,0\n'
    + 'FIELD:corp_for_profit_ind:TYPE(STRING1):LIKE(invalid_flag_code):0,0\n'
    + 'FIELD:corp_public_or_private_ind:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_sic_code:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_naic_code:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_orig_bus_type_cd:0,0\n'
    + 'FIELD:corp_orig_bus_type_desc:TYPE(STRING350):0,0\n'
    + 'FIELD:corp_entity_desc:TYPE(STRING350):0,0\n'
    + 'FIELD:corp_certificate_nbr:TYPE(STRING32):0,0\n'
    + 'FIELD:corp_internal_nbr:TYPE(STRING32):0,0\n'
    + 'FIELD:corp_previous_nbr:TYPE(STRING32):0,0\n'
    + 'FIELD:corp_microfilm_nbr:TYPE(STRING32):0,0\n'
    + 'FIELD:corp_amendments_filed:TYPE(STRING5):0,0\n'
    + 'FIELD:corp_acts:TYPE(STRING50):0,0\n'
    + 'FIELD:corp_partnership_ind:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_mfg_ind:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_addl_info:TYPE(STRING250):0,0\n'
    + 'FIELD:corp_taxes:TYPE(STRING10):0,0\n'
    + 'FIELD:corp_franchise_taxes:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_tax_program_cd:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_tax_program_desc:TYPE(STRING30):0,0\n'
    + 'FIELD:corp_ra_full_name:TYPE(STRING100):0,0\n'
    + 'FIELD:corp_ra_fname:TYPE(STRING20):0,0\n'
    + 'FIELD:corp_ra_mname:TYPE(STRING20):0,0\n'
    + 'FIELD:corp_ra_lname:TYPE(STRING20):0,0\n'
    + 'FIELD:corp_ra_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:corp_ra_title_cd:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_ra_title_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:corp_ra_fein:TYPE(STRING10):0,0\n'
    + 'FIELD:corp_ra_ssn:TYPE(STRING9):0,0\n'
    + 'FIELD:corp_ra_dob:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_ra_effective_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_ra_resign_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_ra_no_comp:TYPE(STRING5):0,0\n'
    + 'FIELD:corp_ra_no_comp_igs:TYPE(STRING5):0,0\n'
    + 'FIELD:corp_ra_addl_info:TYPE(STRING250):0,0\n'
    + 'FIELD:corp_ra_address_type_cd:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_ra_address_type_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:corp_ra_address_line1:TYPE(STRING70):0,0\n'
    + 'FIELD:corp_ra_address_line2:TYPE(STRING70):0,0\n'
    + 'FIELD:corp_ra_address_line3:TYPE(STRING70):0,0\n'
    + 'FIELD:corp_ra_phone_number:TYPE(STRING30):LIKE(invalid_phone):0,0\n'
    + 'FIELD:corp_ra_phone_number_type_cd:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_ra_phone_number_type_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:corp_ra_fax_nbr:TYPE(STRING15):0,0\n'
    + 'FIELD:corp_ra_email_address:TYPE(STRING30):0,0\n'
    + 'FIELD:corp_ra_web_address:TYPE(STRING30):0,0\n'
    + 'FIELD:corp_prep_addr1_line1:TYPE(STRING100):0,0\n'
    + 'FIELD:corp_prep_addr1_last_line:TYPE(STRING50):0,0\n'
    + 'FIELD:corp_prep_addr2_line1:TYPE(STRING100):0,0\n'
    + 'FIELD:corp_prep_addr2_last_line:TYPE(STRING50):0,0\n'
    + 'FIELD:ra_prep_addr_line1:TYPE(STRING100):0,0\n'
    + 'FIELD:ra_prep_addr_last_line:TYPE(STRING50):0,0\n'
    + 'FIELD:cont_filing_reference_nbr:TYPE(STRING30):0,0\n'
    + 'FIELD:cont_filing_date:TYPE(STRING8):0,0\n'
    + 'FIELD:cont_filing_cd:TYPE(STRING8):0,0\n'
    + 'FIELD:cont_filing_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:cont_type_cd:TYPE(STRING8):0,0\n'
    + 'FIELD:cont_type_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:cont_full_name:TYPE(STRING100):0,0\n'
    + 'FIELD:cont_fname:TYPE(STRING20):0,0\n'
    + 'FIELD:cont_mname:TYPE(STRING20):0,0\n'
    + 'FIELD:cont_lname:TYPE(STRING20):0,0\n'
    + 'FIELD:cont_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:cont_title1_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:cont_title2_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:cont_title3_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:cont_title4_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:cont_title5_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:cont_fein:TYPE(STRING10):0,0\n'
    + 'FIELD:cont_ssn:TYPE(STRING9):0,0\n'
    + 'FIELD:cont_dob:TYPE(STRING8):0,0\n'
    + 'FIELD:cont_status_cd:TYPE(STRING8):0,0\n'
    + 'FIELD:cont_status_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:cont_effective_date:TYPE(STRING8):0,0\n'
    + 'FIELD:cont_effective_cd:TYPE(STRING1):0,0\n'
    + 'FIELD:cont_effective_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:cont_addl_info:TYPE(STRING350):0,0\n'
    + 'FIELD:cont_address_type_cd:TYPE(STRING8):0,0\n'
    + 'FIELD:cont_address_type_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:cont_address_line1:TYPE(STRING70):0,0\n'
    + 'FIELD:cont_address_line2:TYPE(STRING70):0,0\n'
    + 'FIELD:cont_address_line3:TYPE(STRING70):0,0\n'
    + 'FIELD:cont_address_effective_date:TYPE(STRING8):0,0\n'
    + 'FIELD:cont_address_county:TYPE(STRING30):0,0\n'
    + 'FIELD:cont_phone_number:TYPE(STRING30):0,0\n'
    + 'FIELD:cont_phone_number_type_cd:TYPE(STRING8):0,0\n'
    + 'FIELD:cont_phone_number_type_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:cont_fax_nbr:TYPE(STRING15):0,0\n'
    + 'FIELD:cont_email_address:TYPE(STRING30):0,0\n'
    + 'FIELD:cont_web_address:TYPE(STRING30):0,0\n'
    + 'FIELD:corp_acres:TYPE(STRING50):0,0\n'
    + 'FIELD:corp_action:TYPE(STRING10):0,0\n'
    + 'FIELD:corp_action_date:TYPE(STRING10):0,0\n'
    + 'FIELD:corp_action_employment_security_approval_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_action_pending_cd:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_action_pending_desc:TYPE(STRING50):0,0\n'
    + 'FIELD:corp_action_statement_of_intent_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_action_tax_dept_approval_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_acts2:TYPE(STRING50):0,0\n'
    + 'FIELD:corp_acts3:TYPE(STRING50):0,0\n'
    + 'FIELD:corp_additional_principals:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_address_office_type:TYPE(STRING50):0,0\n'
    + 'FIELD:corp_agent_assign_date:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:corp_agent_commercial:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_agent_country:TYPE(STRING50):0,0\n'
    + 'FIELD:corp_agent_county:TYPE(STRING20):0,0\n'
    + 'FIELD:corp_agent_status_cd:TYPE(STRING5):0,0\n'
    + 'FIELD:corp_agent_status_desc:TYPE(STRING50):0,0\n'
    + 'FIELD:corp_agent_id:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_agriculture_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_authorized_partners:TYPE(STRING100):0,0\n'
    + 'FIELD:corp_comment:TYPE(STRING300):0,0\n'
    + 'FIELD:corp_consent_flag_for_protected_name:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_converted:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_converted_from:TYPE(STRING50):0,0\n'
    + 'FIELD:corp_country_of_formation:TYPE(STRING50):LIKE(invalid_characters):0,0\n'
    + 'FIELD:corp_date_of_organization_meeting:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_delayed_effective_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_directors_from_to:TYPE(STRING10):0,0\n'
    + 'FIELD:corp_dissolved_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_farm_exemptions:TYPE(STRING30):0,0\n'
    + 'FIELD:corp_farm_qual_date:TYPE(STRING10):0,0\n'
    + 'FIELD:corp_farm_status_cd:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_farm_status_desc:TYPE(STRING100):0,0\n'
    + 'FIELD:corp_fiscal_year_month:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_foreign_fiduciary_capacity_in_state:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_governing_statute:TYPE(STRING20):0,0\n'
    + 'FIELD:corp_has_members:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_has_vested_managers:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_home_incorporated_county:TYPE(STRING60):0,0\n'
    + 'FIELD:corp_home_state_name:TYPE(STRING30):0,0\n'
    + 'FIELD:corp_is_professional:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_is_non_profit_irs_approved:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_last_renewal_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_last_renewal_year:TYPE(STRING4):0,0\n'
    + 'FIELD:corp_license_type:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_llc_managed_desc:TYPE(STRING100):0,0\n'
    + 'FIELD:corp_llc_managed_ind:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_management_desc:TYPE(STRING50):0,0\n'
    + 'FIELD:corp_management_type:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_manager_managed:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_merged_corporation_id:TYPE(STRING32):0,0\n'
    + 'FIELD:corp_merged_fein:TYPE(STRING9):0,0\n'
    + 'FIELD:corp_merger_allowed_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_merger_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_merger_desc:TYPE(STRING250):0,0\n'
    + 'FIELD:corp_merger_effective_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_merger_id:TYPE(STRING32):0,0\n'
    + 'FIELD:corp_merger_indicator:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_merger_name:TYPE(STRING100):0,0\n'
    + 'FIELD:corp_merger_type_converted_to_cd:TYPE(STRING4):0,0\n'
    + 'FIELD:corp_merger_type_converted_to_desc:TYPE(STRING100):0,0\n'
    + 'FIELD:corp_naics_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:corp_name_effective_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_name_reservation_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_name_reservation_desc:TYPE(STRING250):0,0\n'
    + 'FIELD:corp_name_reservation_expiration_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_name_reservation_nbr:TYPE(STRING32):0,0\n'
    + 'FIELD:corp_name_reservation_type:TYPE(STRING100):0,0\n'
    + 'FIELD:corp_name_status_cd:TYPE(STRING5):0,0\n'
    + 'FIELD:corp_name_status_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_name_status_desc:TYPE(STRING100):0,0\n'
    + 'FIELD:corp_non_profit_irs_approved_purpose:TYPE(STRING50):0,0\n'
    + 'FIELD:corp_non_profit_solicit_donations:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_nbr_of_amendments:TYPE(STRING10):0,0\n'
    + 'FIELD:corp_nbr_of_initial_llc_members:TYPE(STRING10):0,0\n'
    + 'FIELD:corp_nbr_of_partners:TYPE(STRING10):0,0\n'
    + 'FIELD:corp_operating_agreement:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_opt_in_llc_act_desc:TYPE(STRING50):0,0\n'
    + 'FIELD:corp_opt_in_llc_act_ind:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_organizational_comments:TYPE(STRING250):0,0\n'
    + 'FIELD:corp_partner_contributions_total:TYPE(STRING15):0,0\n'
    + 'FIELD:corp_partner_terms:TYPE(STRING200):0,0\n'
    + 'FIELD:corp_percentage_voters_required_to_approve_amendments:TYPE(STRING10):0,0\n'
    + 'FIELD:corp_profession:TYPE(STRING250):0,0\n'
    + 'FIELD:corp_province:TYPE(STRING20):0,0\n'
    + 'FIELD:corp_public_mutual_corporation:TYPE(STRING10):0,0\n'
    + 'FIELD:corp_purpose:TYPE(STRING250):0,0\n'
    + 'FIELD:corp_ra_required_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_registered_counties:TYPE(STRING500):0,0\n'
    + 'FIELD:corp_regulated_ind:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_renewal_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_standing_other:TYPE(STRING50):0,0\n'
    + 'FIELD:corp_survivor_corporation_id:TYPE(STRING32):0,0\n'
    + 'FIELD:corp_tax_base:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_tax_standing:TYPE(STRING50):0,0\n'
    + 'FIELD:corp_termination_cd:TYPE(STRING2):0,0\n'
    + 'FIELD:corp_termination_desc:TYPE(STRING100):0,0\n'
    + 'FIELD:corp_termination_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_trademark_business_mark_type:TYPE(STRING20):0,0\n'
    + 'FIELD:corp_trademark_cancelled_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_trademark_class_desc1:TYPE(STRING250):0,0\n'
    + 'FIELD:corp_trademark_class_desc2:TYPE(STRING250):0,0\n'
    + 'FIELD:corp_trademark_class_desc3:TYPE(STRING250):0,0\n'
    + 'FIELD:corp_trademark_class_desc4:TYPE(STRING250):0,0\n'
    + 'FIELD:corp_trademark_class_desc5:TYPE(STRING250):0,0\n'
    + 'FIELD:corp_trademark_class_desc6:TYPE(STRING250):0,0\n'
    + 'FIELD:corp_trademark_classification_nbr:TYPE(STRING10):0,0\n'
    + 'FIELD:corp_trademark_disclaimer1:TYPE(STRING50):0,0\n'
    + 'FIELD:corp_trademark_disclaimer2:TYPE(STRING50):0,0\n'
    + 'FIELD:corp_trademark_expiration_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_trademark_filing_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_trademark_first_use_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_trademark_first_use_date_in_state:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_trademark_keywords:TYPE(STRING250):0,0\n'
    + 'FIELD:corp_trademark_logo:TYPE(STRING250):0,0\n'
    + 'FIELD:corp_trademark_name_expiration_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_trademark_nbr:TYPE(STRING12):0,0\n'
    + 'FIELD:corp_trademark_renewal_date:TYPE(STRING8):0,0\n'
    + 'FIELD:corp_trademark_status:TYPE(STRING1):0,0\n'
    + 'FIELD:corp_trademark_used_1:TYPE(STRING50):0,0\n'
    + 'FIELD:corp_trademark_used_2:TYPE(STRING50):0,0\n'
    + 'FIELD:corp_trademark_used_3:TYPE(STRING50):0,0\n'
    + 'FIELD:cont_owner_percentage:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:cont_country:TYPE(STRING50):0,0\n'
    + 'FIELD:cont_country_mailing:TYPE(STRING50):0,0\n'
    + 'FIELD:cont_nondislosure:TYPE(STRING1):0,0\n'
    + 'FIELD:cont_prep_addr_line1:TYPE(STRING100):0,0\n'
    + 'FIELD:cont_prep_addr_last_line:TYPE(STRING50):0,0\n'
    + 'FIELD:recordorigin:TYPE(STRING1):LIKE(invalid_recordorigin):0,0\n'
    + '//CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '//RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '//SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '//LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

