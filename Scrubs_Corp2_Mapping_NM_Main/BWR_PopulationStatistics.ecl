﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Mapping_NM_Main.BWR_PopulationStatistics - Population Statistics - SALT V3.8.0');
IMPORT Scrubs_Corp2_Mapping_NM_Main,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Corp2_Mapping_NM_Main.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* dt_vendor_first_reported_field */,/* dt_vendor_last_reported_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,/* corp_ra_dt_first_seen_field */,/* corp_ra_dt_last_seen_field */,/* corp_key_field */,/* corp_supp_key_field */,/* corp_vendor_field */,/* corp_vendor_county_field */,/* corp_vendor_subcode_field */,/* corp_state_origin_field */,/* corp_process_date_field */,/* corp_orig_sos_charter_nbr_field */,/* corp_legal_name_field */,/* corp_ln_name_type_cd_field */,/* corp_ln_name_type_desc_field */,/* corp_supp_nbr_field */,/* corp_name_comment_field */,/* corp_address1_type_cd_field */,/* corp_address1_type_desc_field */,/* corp_address1_line1_field */,/* corp_address1_line2_field */,/* corp_address1_line3_field */,/* corp_address1_effective_date_field */,/* corp_address2_type_cd_field */,/* corp_address2_type_desc_field */,/* corp_address2_line1_field */,/* corp_address2_line2_field */,/* corp_address2_line3_field */,/* corp_address2_effective_date_field */,/* corp_phone_number_field */,/* corp_phone_number_type_cd_field */,/* corp_phone_number_type_desc_field */,/* corp_fax_nbr_field */,/* corp_email_address_field */,/* corp_web_address_field */,/* corp_filing_reference_nbr_field */,/* corp_filing_date_field */,/* corp_filing_cd_field */,/* corp_filing_desc_field */,/* corp_status_cd_field */,/* corp_status_desc_field */,/* corp_status_date_field */,/* corp_standing_field */,/* corp_status_comment_field */,/* corp_ticker_symbol_field */,/* corp_stock_exchange_field */,/* corp_inc_state_field */,/* corp_inc_county_field */,/* corp_inc_date_field */,/* corp_anniversary_month_field */,/* corp_fed_tax_id_field */,/* corp_state_tax_id_field */,/* corp_term_exist_cd_field */,/* corp_term_exist_exp_field */,/* corp_term_exist_desc_field */,/* corp_foreign_domestic_ind_field */,/* corp_forgn_state_cd_field */,/* corp_forgn_state_desc_field */,/* corp_forgn_sos_charter_nbr_field */,/* corp_forgn_date_field */,/* corp_forgn_fed_tax_id_field */,/* corp_forgn_state_tax_id_field */,/* corp_forgn_term_exist_cd_field */,/* corp_forgn_term_exist_exp_field */,/* corp_forgn_term_exist_desc_field */,/* corp_orig_org_structure_cd_field */,/* corp_orig_org_structure_desc_field */,/* corp_for_profit_ind_field */,/* corp_public_or_private_ind_field */,/* corp_sic_code_field */,/* corp_naic_code_field */,/* corp_orig_bus_type_cd_field */,/* corp_orig_bus_type_desc_field */,/* corp_entity_desc_field */,/* corp_certificate_nbr_field */,/* corp_internal_nbr_field */,/* corp_previous_nbr_field */,/* corp_microfilm_nbr_field */,/* corp_amendments_filed_field */,/* corp_acts_field */,/* corp_partnership_ind_field */,/* corp_mfg_ind_field */,/* corp_addl_info_field */,/* corp_taxes_field */,/* corp_franchise_taxes_field */,/* corp_tax_program_cd_field */,/* corp_tax_program_desc_field */,/* corp_ra_full_name_field */,/* corp_ra_fname_field */,/* corp_ra_mname_field */,/* corp_ra_lname_field */,/* corp_ra_title_cd_field */,/* corp_ra_title_desc_field */,/* corp_ra_fein_field */,/* corp_ra_ssn_field */,/* corp_ra_dob_field */,/* corp_ra_effective_date_field */,/* corp_ra_resign_date_field */,/* corp_ra_no_comp_field */,/* corp_ra_no_comp_igs_field */,/* corp_ra_addl_info_field */,/* corp_ra_address_type_cd_field */,/* corp_ra_address_type_desc_field */,/* corp_ra_address_line1_field */,/* corp_ra_address_line2_field */,/* corp_ra_address_line3_field */,/* corp_ra_phone_number_field */,/* corp_ra_phone_number_type_cd_field */,/* corp_ra_phone_number_type_desc_field */,/* corp_ra_fax_nbr_field */,/* corp_ra_email_address_field */,/* corp_ra_web_address_field */,/* corp_prep_addr1_line1_field */,/* corp_prep_addr1_last_line_field */,/* corp_prep_addr2_line1_field */,/* corp_prep_addr2_last_line_field */,/* ra_prep_addr_line1_field */,/* ra_prep_addr_last_line_field */,/* cont_filing_reference_nbr_field */,/* cont_filing_date_field */,/* cont_filing_cd_field */,/* cont_filing_desc_field */,/* cont_type_cd_field */,/* cont_type_desc_field */,/* cont_full_name_field */,/* cont_fname_field */,/* cont_mname_field */,/* cont_lname_field */,/* cont_title1_desc_field */,/* cont_title2_desc_field */,/* cont_title3_desc_field */,/* cont_title4_desc_field */,/* cont_title5_desc_field */,/* cont_fein_field */,/* cont_ssn_field */,/* cont_dob_field */,/* cont_status_cd_field */,/* cont_status_desc_field */,/* cont_effective_date_field */,/* cont_effective_cd_field */,/* cont_effective_desc_field */,/* cont_addl_info_field */,/* cont_address_type_cd_field */,/* cont_address_type_desc_field */,/* cont_address_line1_field */,/* cont_address_line2_field */,/* cont_address_line3_field */,/* cont_address_effective_date_field */,/* cont_address_county_field */,/* cont_phone_number_field */,/* cont_phone_number_type_cd_field */,/* cont_phone_number_type_desc_field */,/* cont_fax_nbr_field */,/* cont_email_address_field */,/* cont_web_address_field */,/* corp_acres_field */,/* corp_action_field */,/* corp_action_date_field */,/* corp_action_employment_security_approval_date_field */,/* corp_action_pending_cd_field */,/* corp_action_pending_desc_field */,/* corp_action_statement_of_intent_date_field */,/* corp_action_tax_dept_approval_date_field */,/* corp_acts2_field */,/* corp_acts3_field */,/* corp_additional_principals_field */,/* corp_address_office_type_field */,/* corp_agent_commercial_field */,/* corp_agent_country_field */,/* corp_agent_county_field */,/* corp_agent_status_cd_field */,/* corp_agent_status_desc_field */,/* corp_agent_id_field */,/* corp_agent_assign_date_field */,/* corp_agriculture_flag_field */,/* corp_authorized_partners_field */,/* corp_comment_field */,/* corp_consent_flag_for_protected_name_field */,/* corp_converted_field */,/* corp_converted_from_field */,/* corp_country_of_formation_field */,/* corp_date_of_organization_meeting_field */,/* corp_delayed_effective_date_field */,/* corp_directors_from_to_field */,/* corp_dissolved_date_field */,/* corp_farm_exemptions_field */,/* corp_farm_qual_date_field */,/* corp_farm_status_cd_field */,/* corp_farm_status_desc_field */,/* corp_fiscal_year_month_field */,/* corp_foreign_fiduciary_capacity_in_state_field */,/* corp_governing_statute_field */,/* corp_has_members_field */,/* corp_has_vested_managers_field */,/* corp_home_incorporated_county_field */,/* corp_home_state_name_field */,/* corp_is_professional_field */,/* corp_is_non_profit_irs_approved_field */,/* corp_last_renewal_date_field */,/* corp_last_renewal_year_field */,/* corp_license_type_field */,/* corp_llc_managed_desc_field */,/* corp_llc_managed_ind_field */,/* corp_management_desc_field */,/* corp_management_type_field */,/* corp_manager_managed_field */,/* corp_merged_corporation_id_field */,/* corp_merged_fein_field */,/* corp_merger_allowed_flag_field */,/* corp_merger_date_field */,/* corp_merger_desc_field */,/* corp_merger_effective_date_field */,/* corp_merger_id_field */,/* corp_merger_indicator_field */,/* corp_merger_name_field */,/* corp_merger_type_converted_to_cd_field */,/* corp_merger_type_converted_to_desc_field */,/* corp_naics_desc_field */,/* corp_name_effective_date_field */,/* corp_name_reservation_date_field */,/* corp_name_reservation_desc_field */,/* corp_name_reservation_expiration_date_field */,/* corp_name_reservation_nbr_field */,/* corp_name_reservation_type_field */,/* corp_name_status_cd_field */,/* corp_name_status_date_field */,/* corp_name_status_desc_field */,/* corp_non_profit_irs_approved_purpose_field */,/* corp_non_profit_solicit_donations_field */,/* corp_nbr_of_amendments_field */,/* corp_nbr_of_initial_llc_members_field */,/* corp_nbr_of_partners_field */,/* corp_operating_agreement_field */,/* corp_opt_in_llc_act_desc_field */,/* corp_opt_in_llc_act_ind_field */,/* corp_organizational_comments_field */,/* corp_partner_contributions_total_field */,/* corp_partner_terms_field */,/* corp_percentage_voters_required_to_approve_amendments_field */,/* corp_profession_field */,/* corp_province_field */,/* corp_public_mutual_corporation_field */,/* corp_purpose_field */,/* corp_ra_required_flag_field */,/* corp_registered_counties_field */,/* corp_regulated_ind_field */,/* corp_renewal_date_field */,/* corp_standing_other_field */,/* corp_survivor_corporation_id_field */,/* corp_tax_base_field */,/* corp_tax_standing_field */,/* corp_termination_cd_field */,/* corp_termination_desc_field */,/* corp_termination_date_field */,/* corp_trademark_business_mark_type_field */,/* corp_trademark_cancelled_date_field */,/* corp_trademark_class_desc1_field */,/* corp_trademark_class_desc2_field */,/* corp_trademark_class_desc3_field */,/* corp_trademark_class_desc4_field */,/* corp_trademark_class_desc5_field */,/* corp_trademark_class_desc6_field */,/* corp_trademark_classification_nbr_field */,/* corp_trademark_disclaimer1_field */,/* corp_trademark_disclaimer2_field */,/* corp_trademark_expiration_date_field */,/* corp_trademark_filing_date_field */,/* corp_trademark_first_use_date_field */,/* corp_trademark_first_use_date_in_state_field */,/* corp_trademark_keywords_field */,/* corp_trademark_logo_field */,/* corp_trademark_name_expiration_date_field */,/* corp_trademark_nbr_field */,/* corp_trademark_renewal_date_field */,/* corp_trademark_status_field */,/* corp_trademark_used_1_field */,/* corp_trademark_used_2_field */,/* corp_trademark_used_3_field */,/* cont_owner_percentage_field */,/* cont_country_field */,/* cont_country_mailing_field */,/* cont_nondislosure_field */,/* cont_prep_addr_line1_field */,/* cont_prep_addr_last_line_field */,/* recordorigin_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
