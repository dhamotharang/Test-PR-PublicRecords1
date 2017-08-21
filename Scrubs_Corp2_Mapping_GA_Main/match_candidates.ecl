// Begin code to produce match candidates
IMPORT SALT34,ut;
EXPORT match_candidates(DATASET(layout_in_file) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := BasicMatch(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00,{dt_vendor_first_reported_year,dt_vendor_first_reported_month,dt_vendor_first_reported_day,dt_vendor_last_reported_year,dt_vendor_last_reported_month,dt_vendor_last_reported_day,dt_first_seen_year,dt_first_seen_month,dt_first_seen_day,dt_last_seen_year,dt_last_seen_month,dt_last_seen_day,corp_ra_dt_first_seen_year,corp_ra_dt_first_seen_month,corp_ra_dt_first_seen_day,corp_ra_dt_last_seen_year,corp_ra_dt_last_seen_month,corp_ra_dt_last_seen_day,corp_key,corp_supp_key,corp_vendor,corp_vendor_county,corp_vendor_subcode,corp_state_origin,corp_process_date_year,corp_process_date_month,corp_process_date_day,corp_orig_sos_charter_nbr,corp_legal_name,corp_ln_name_type_cd,corp_ln_name_type_desc,corp_supp_nbr,corp_name_comment,corp_address1_type_cd,corp_address1_type_desc,corp_address1_line1,corp_address1_line2,corp_address1_line3,corp_address1_effective_date,corp_address2_type_cd,corp_address2_type_desc,corp_address2_line1,corp_address2_line2,corp_address2_line3,corp_address2_effective_date,corp_phone_number,corp_phone_number_type_cd,corp_phone_number_type_desc,corp_fax_nbr,corp_email_address,corp_web_address,corp_filing_reference_nbr,corp_filing_date,corp_filing_cd,corp_filing_desc,corp_status_cd,corp_status_desc,corp_status_date,corp_standing,corp_status_comment,corp_ticker_symbol,corp_stock_exchange,corp_inc_state,corp_inc_county,corp_inc_date,corp_anniversary_month,corp_fed_tax_id,corp_state_tax_id,corp_term_exist_cd,corp_term_exist_exp,corp_term_exist_desc,corp_foreign_domestic_ind,corp_forgn_state_cd,corp_forgn_state_desc,corp_forgn_sos_charter_nbr,corp_forgn_date,corp_forgn_fed_tax_id,corp_forgn_state_tax_id,corp_forgn_term_exist_cd,corp_forgn_term_exist_exp,corp_forgn_term_exist_desc,corp_orig_org_structure_cd,corp_orig_org_structure_desc,corp_for_profit_ind,corp_public_or_private_ind,corp_sic_code,corp_naic_code,corp_orig_bus_type_cd,corp_orig_bus_type_desc,corp_entity_desc,corp_certificate_nbr,corp_internal_nbr,corp_previous_nbr,corp_microfilm_nbr,corp_amendments_filed,corp_acts,corp_partnership_ind,corp_mfg_ind,corp_addl_info,corp_taxes,corp_franchise_taxes,corp_tax_program_cd,corp_tax_program_desc,corp_ra_full_name,corp_ra_fname,corp_ra_mname,corp_ra_lname,corp_ra_suffix,corp_ra_title_cd,corp_ra_title_desc,corp_ra_fein,corp_ra_ssn,corp_ra_dob,corp_ra_effective_date,corp_ra_resign_date,corp_ra_no_comp,corp_ra_no_comp_igs,corp_ra_addl_info,corp_ra_address_type_cd,corp_ra_address_type_desc,corp_ra_address_line1,corp_ra_address_line2,corp_ra_address_line3,corp_ra_phone_number,corp_ra_phone_number_type_cd,corp_ra_phone_number_type_desc,corp_ra_fax_nbr,corp_ra_email_address,corp_ra_web_address,corp_prep_addr1_line1,corp_prep_addr1_last_line,corp_prep_addr2_line1,corp_prep_addr2_last_line,ra_prep_addr_line1,ra_prep_addr_last_line,cont_filing_reference_nbr,cont_filing_date,cont_filing_cd,cont_filing_desc,cont_type_cd,cont_type_desc,cont_full_name,cont_fname,cont_mname,cont_lname,cont_suffix,cont_title1_desc,cont_title2_desc,cont_title3_desc,cont_title4_desc,cont_title5_desc,cont_fein,cont_ssn,cont_dob,cont_status_cd,cont_status_desc,cont_effective_date,cont_effective_cd,cont_effective_desc,cont_addl_info,cont_address_type_cd,cont_address_type_desc,cont_address_line1,cont_address_line2,cont_address_line3,cont_address_effective_date,cont_address_county,cont_phone_number,cont_phone_number_type_cd,cont_phone_number_type_desc,cont_fax_nbr,cont_email_address,cont_web_address,corp_acres,corp_action,corp_action_date,corp_action_employment_security_approval_date,corp_action_pending_cd,corp_action_pending_desc,corp_action_statement_of_intent_date,corp_action_tax_dept_approval_date,corp_acts2,corp_acts3,corp_additional_principals,corp_address_office_type,corp_agent_assign_date,corp_agent_commercial,corp_agent_country,corp_agent_county,corp_agent_status_cd,corp_agent_status_desc,corp_agent_id,corp_agriculture_flag,corp_authorized_partners,corp_comment,corp_consent_flag_for_protected_name,corp_converted,corp_converted_from,corp_country_of_formation,corp_date_of_organization_meeting,corp_delayed_effective_date,corp_directors_from_to,corp_dissolved_date,corp_farm_exemptions,corp_farm_qual_date,corp_farm_status_cd,corp_farm_status_desc,corp_fiscal_year_month,corp_foreign_fiduciary_capacity_in_state,corp_governing_statute,corp_has_members,corp_has_vested_managers,corp_home_incorporated_county,corp_home_state_name,corp_is_professional,corp_is_non_profit_irs_approved,corp_last_renewal_date,corp_last_renewal_year,corp_license_type,corp_llc_managed_desc,corp_llc_managed_ind,corp_management_desc,corp_management_type,corp_manager_managed,corp_merged_corporation_id,corp_merged_fein,corp_merger_allowed_flag,corp_merger_date,corp_merger_desc,corp_merger_effective_date,corp_merger_id,corp_merger_indicator,corp_merger_name,corp_merger_type_converted_to_cd,corp_merger_type_converted_to_desc,corp_naics_desc,corp_name_effective_date,corp_name_reservation_date,corp_name_reservation_desc,corp_name_reservation_expiration_date,corp_name_reservation_nbr,corp_name_reservation_type,corp_name_status_cd,corp_name_status_date,corp_name_status_desc,corp_non_profit_irs_approved_purpose,corp_non_profit_solicit_donations,corp_nbr_of_amendments,corp_nbr_of_initial_llc_members,corp_nbr_of_partners,corp_operating_agreement,corp_opt_in_llc_act_desc,corp_opt_in_llc_act_ind,corp_organizational_comments,corp_partner_contributions_total,corp_partner_terms,corp_percentage_voters_required_to_approve_amendments,corp_profession,corp_province,corp_public_mutual_corporation,corp_purpose,corp_ra_required_flag,corp_registered_counties,corp_regulated_ind,corp_renewal_date,corp_standing_other,corp_survivor_corporation_id,corp_tax_base,corp_tax_standing,corp_termination_cd,corp_termination_desc,corp_termination_date,corp_trademark_business_mark_type,corp_trademark_cancelled_date,corp_trademark_class_desc1,corp_trademark_class_desc2,corp_trademark_class_desc3,corp_trademark_class_desc4,corp_trademark_class_desc5,corp_trademark_class_desc6,corp_trademark_classification_nbr,corp_trademark_disclaimer1,corp_trademark_disclaimer2,corp_trademark_expiration_date,corp_trademark_filing_date,corp_trademark_first_use_date,corp_trademark_first_use_date_in_state,corp_trademark_keywords,corp_trademark_logo,corp_trademark_name_expiration_date,corp_trademark_nbr,corp_trademark_renewal_date,corp_trademark_status,corp_trademark_used_1,corp_trademark_used_2,corp_trademark_used_3,cont_owner_percentage,cont_country,cont_country_mailing,cont_nondislosure,cont_prep_addr_line1,cont_prep_addr_last_line,recordorigin,}),HASH());
 
  Grpd := GROUP( SORT(
    DISTRIBUTE( TABLE( thin_table, { thin_table, UNSIGNED2 Buddies := 0 }),HASH()),
    ,dt_vendor_first_reported_year,dt_vendor_first_reported_month,dt_vendor_first_reported_day,dt_vendor_last_reported_year,dt_vendor_last_reported_month,dt_vendor_last_reported_day,dt_first_seen_year,dt_first_seen_month,dt_first_seen_day,dt_last_seen_year,dt_last_seen_month,dt_last_seen_day,corp_ra_dt_first_seen_year,corp_ra_dt_first_seen_month,corp_ra_dt_first_seen_day,corp_ra_dt_last_seen_year,corp_ra_dt_last_seen_month,corp_ra_dt_last_seen_day,corp_key,corp_supp_key,corp_vendor,corp_vendor_county,corp_vendor_subcode,corp_state_origin,corp_process_date_year,corp_process_date_month,corp_process_date_day,corp_orig_sos_charter_nbr,corp_legal_name,corp_ln_name_type_cd,corp_ln_name_type_desc,corp_supp_nbr,corp_name_comment,corp_address1_type_cd,corp_address1_type_desc,corp_address1_line1,corp_address1_line2,corp_address1_line3,corp_address1_effective_date,corp_address2_type_cd,corp_address2_type_desc,corp_address2_line1,corp_address2_line2,corp_address2_line3,corp_address2_effective_date,corp_phone_number,corp_phone_number_type_cd,corp_phone_number_type_desc,corp_fax_nbr,corp_email_address,corp_web_address,corp_filing_reference_nbr,corp_filing_date,corp_filing_cd,corp_filing_desc,corp_status_cd,corp_status_desc,corp_status_date,corp_standing,corp_status_comment,corp_ticker_symbol,corp_stock_exchange,corp_inc_state,corp_inc_county,corp_inc_date,corp_anniversary_month,corp_fed_tax_id,corp_state_tax_id,corp_term_exist_cd,corp_term_exist_exp,corp_term_exist_desc,corp_foreign_domestic_ind,corp_forgn_state_cd,corp_forgn_state_desc,corp_forgn_sos_charter_nbr,corp_forgn_date,corp_forgn_fed_tax_id,corp_forgn_state_tax_id,corp_forgn_term_exist_cd,corp_forgn_term_exist_exp,corp_forgn_term_exist_desc,corp_orig_org_structure_cd,corp_orig_org_structure_desc,corp_for_profit_ind,corp_public_or_private_ind,corp_sic_code,corp_naic_code,corp_orig_bus_type_cd,corp_orig_bus_type_desc,corp_entity_desc,corp_certificate_nbr,corp_internal_nbr,corp_previous_nbr,corp_microfilm_nbr,corp_amendments_filed,corp_acts,corp_partnership_ind,corp_mfg_ind,corp_addl_info,corp_taxes,corp_franchise_taxes,corp_tax_program_cd,corp_tax_program_desc,corp_ra_full_name,corp_ra_fname,corp_ra_mname,corp_ra_lname,corp_ra_suffix,corp_ra_title_cd,corp_ra_title_desc,corp_ra_fein,corp_ra_ssn,corp_ra_dob,corp_ra_effective_date,corp_ra_resign_date,corp_ra_no_comp,corp_ra_no_comp_igs,corp_ra_addl_info,corp_ra_address_type_cd,corp_ra_address_type_desc,corp_ra_address_line1,corp_ra_address_line2,corp_ra_address_line3,corp_ra_phone_number,corp_ra_phone_number_type_cd,corp_ra_phone_number_type_desc,corp_ra_fax_nbr,corp_ra_email_address,corp_ra_web_address,corp_prep_addr1_line1,corp_prep_addr1_last_line,corp_prep_addr2_line1,corp_prep_addr2_last_line,ra_prep_addr_line1,ra_prep_addr_last_line,cont_filing_reference_nbr,cont_filing_date,cont_filing_cd,cont_filing_desc,cont_type_cd,cont_type_desc,cont_full_name,cont_fname,cont_mname,cont_lname,cont_suffix,cont_title1_desc,cont_title2_desc,cont_title3_desc,cont_title4_desc,cont_title5_desc,cont_fein,cont_ssn,cont_dob,cont_status_cd,cont_status_desc,cont_effective_date,cont_effective_cd,cont_effective_desc,cont_addl_info,cont_address_type_cd,cont_address_type_desc,cont_address_line1,cont_address_line2,cont_address_line3,cont_address_effective_date,cont_address_county,cont_phone_number,cont_phone_number_type_cd,cont_phone_number_type_desc,cont_fax_nbr,cont_email_address,cont_web_address,corp_acres,corp_action,corp_action_date,corp_action_employment_security_approval_date,corp_action_pending_cd,corp_action_pending_desc,corp_action_statement_of_intent_date,corp_action_tax_dept_approval_date,corp_acts2,corp_acts3,corp_additional_principals,corp_address_office_type,corp_agent_assign_date,corp_agent_commercial,corp_agent_country,corp_agent_county,corp_agent_status_cd,corp_agent_status_desc,corp_agent_id,corp_agriculture_flag,corp_authorized_partners,corp_comment,corp_consent_flag_for_protected_name,corp_converted,corp_converted_from,corp_country_of_formation,corp_date_of_organization_meeting,corp_delayed_effective_date,corp_directors_from_to,corp_dissolved_date,corp_farm_exemptions,corp_farm_qual_date,corp_farm_status_cd,corp_farm_status_desc,corp_fiscal_year_month,corp_foreign_fiduciary_capacity_in_state,corp_governing_statute,corp_has_members,corp_has_vested_managers,corp_home_incorporated_county,corp_home_state_name,corp_is_professional,corp_is_non_profit_irs_approved,corp_last_renewal_date,corp_last_renewal_year,corp_license_type,corp_llc_managed_desc,corp_llc_managed_ind,corp_management_desc,corp_management_type,corp_manager_managed,corp_merged_corporation_id,corp_merged_fein,corp_merger_allowed_flag,corp_merger_date,corp_merger_desc,corp_merger_effective_date,corp_merger_id,corp_merger_indicator,corp_merger_name,corp_merger_type_converted_to_cd,corp_merger_type_converted_to_desc,corp_naics_desc,corp_name_effective_date,corp_name_reservation_date,corp_name_reservation_desc,corp_name_reservation_expiration_date,corp_name_reservation_nbr,corp_name_reservation_type,corp_name_status_cd,corp_name_status_date,corp_name_status_desc,corp_non_profit_irs_approved_purpose,corp_non_profit_solicit_donations,corp_nbr_of_amendments,corp_nbr_of_initial_llc_members,corp_nbr_of_partners,corp_operating_agreement,corp_opt_in_llc_act_desc,corp_opt_in_llc_act_ind,corp_organizational_comments,corp_partner_contributions_total,corp_partner_terms,corp_percentage_voters_required_to_approve_amendments,corp_profession,corp_province,corp_public_mutual_corporation,corp_purpose,corp_ra_required_flag,corp_registered_counties,corp_regulated_ind,corp_renewal_date,corp_standing_other,corp_survivor_corporation_id,corp_tax_base,corp_tax_standing,corp_termination_cd,corp_termination_desc,corp_termination_date,corp_trademark_business_mark_type,corp_trademark_cancelled_date,corp_trademark_class_desc1,corp_trademark_class_desc2,corp_trademark_class_desc3,corp_trademark_class_desc4,corp_trademark_class_desc5,corp_trademark_class_desc6,corp_trademark_classification_nbr,corp_trademark_disclaimer1,corp_trademark_disclaimer2,corp_trademark_expiration_date,corp_trademark_filing_date,corp_trademark_first_use_date,corp_trademark_first_use_date_in_state,corp_trademark_keywords,corp_trademark_logo,corp_trademark_name_expiration_date,corp_trademark_nbr,corp_trademark_renewal_date,corp_trademark_status,corp_trademark_used_1,corp_trademark_used_2,corp_trademark_used_3,cont_owner_percentage,cont_country,cont_country_mailing,cont_nondislosure,cont_prep_addr_line1,cont_prep_addr_last_line,recordorigin, LOCAL),
    ,dt_vendor_first_reported_year,dt_vendor_first_reported_month,dt_vendor_first_reported_day,dt_vendor_last_reported_year,dt_vendor_last_reported_month,dt_vendor_last_reported_day,dt_first_seen_year,dt_first_seen_month,dt_first_seen_day,dt_last_seen_year,dt_last_seen_month,dt_last_seen_day,corp_ra_dt_first_seen_year,corp_ra_dt_first_seen_month,corp_ra_dt_first_seen_day,corp_ra_dt_last_seen_year,corp_ra_dt_last_seen_month,corp_ra_dt_last_seen_day,corp_key,corp_supp_key,corp_vendor,corp_vendor_county,corp_vendor_subcode,corp_state_origin,corp_process_date_year,corp_process_date_month,corp_process_date_day,corp_orig_sos_charter_nbr,corp_legal_name,corp_ln_name_type_cd,corp_ln_name_type_desc,corp_supp_nbr,corp_name_comment,corp_address1_type_cd,corp_address1_type_desc,corp_address1_line1,corp_address1_line2,corp_address1_line3,corp_address1_effective_date,corp_address2_type_cd,corp_address2_type_desc,corp_address2_line1,corp_address2_line2,corp_address2_line3,corp_address2_effective_date,corp_phone_number,corp_phone_number_type_cd,corp_phone_number_type_desc,corp_fax_nbr,corp_email_address,corp_web_address,corp_filing_reference_nbr,corp_filing_date,corp_filing_cd,corp_filing_desc,corp_status_cd,corp_status_desc,corp_status_date,corp_standing,corp_status_comment,corp_ticker_symbol,corp_stock_exchange,corp_inc_state,corp_inc_county,corp_inc_date,corp_anniversary_month,corp_fed_tax_id,corp_state_tax_id,corp_term_exist_cd,corp_term_exist_exp,corp_term_exist_desc,corp_foreign_domestic_ind,corp_forgn_state_cd,corp_forgn_state_desc,corp_forgn_sos_charter_nbr,corp_forgn_date,corp_forgn_fed_tax_id,corp_forgn_state_tax_id,corp_forgn_term_exist_cd,corp_forgn_term_exist_exp,corp_forgn_term_exist_desc,corp_orig_org_structure_cd,corp_orig_org_structure_desc,corp_for_profit_ind,corp_public_or_private_ind,corp_sic_code,corp_naic_code,corp_orig_bus_type_cd,corp_orig_bus_type_desc,corp_entity_desc,corp_certificate_nbr,corp_internal_nbr,corp_previous_nbr,corp_microfilm_nbr,corp_amendments_filed,corp_acts,corp_partnership_ind,corp_mfg_ind,corp_addl_info,corp_taxes,corp_franchise_taxes,corp_tax_program_cd,corp_tax_program_desc,corp_ra_full_name,corp_ra_fname,corp_ra_mname,corp_ra_lname,corp_ra_suffix,corp_ra_title_cd,corp_ra_title_desc,corp_ra_fein,corp_ra_ssn,corp_ra_dob,corp_ra_effective_date,corp_ra_resign_date,corp_ra_no_comp,corp_ra_no_comp_igs,corp_ra_addl_info,corp_ra_address_type_cd,corp_ra_address_type_desc,corp_ra_address_line1,corp_ra_address_line2,corp_ra_address_line3,corp_ra_phone_number,corp_ra_phone_number_type_cd,corp_ra_phone_number_type_desc,corp_ra_fax_nbr,corp_ra_email_address,corp_ra_web_address,corp_prep_addr1_line1,corp_prep_addr1_last_line,corp_prep_addr2_line1,corp_prep_addr2_last_line,ra_prep_addr_line1,ra_prep_addr_last_line,cont_filing_reference_nbr,cont_filing_date,cont_filing_cd,cont_filing_desc,cont_type_cd,cont_type_desc,cont_full_name,cont_fname,cont_mname,cont_lname,cont_suffix,cont_title1_desc,cont_title2_desc,cont_title3_desc,cont_title4_desc,cont_title5_desc,cont_fein,cont_ssn,cont_dob,cont_status_cd,cont_status_desc,cont_effective_date,cont_effective_cd,cont_effective_desc,cont_addl_info,cont_address_type_cd,cont_address_type_desc,cont_address_line1,cont_address_line2,cont_address_line3,cont_address_effective_date,cont_address_county,cont_phone_number,cont_phone_number_type_cd,cont_phone_number_type_desc,cont_fax_nbr,cont_email_address,cont_web_address,corp_acres,corp_action,corp_action_date,corp_action_employment_security_approval_date,corp_action_pending_cd,corp_action_pending_desc,corp_action_statement_of_intent_date,corp_action_tax_dept_approval_date,corp_acts2,corp_acts3,corp_additional_principals,corp_address_office_type,corp_agent_assign_date,corp_agent_commercial,corp_agent_country,corp_agent_county,corp_agent_status_cd,corp_agent_status_desc,corp_agent_id,corp_agriculture_flag,corp_authorized_partners,corp_comment,corp_consent_flag_for_protected_name,corp_converted,corp_converted_from,corp_country_of_formation,corp_date_of_organization_meeting,corp_delayed_effective_date,corp_directors_from_to,corp_dissolved_date,corp_farm_exemptions,corp_farm_qual_date,corp_farm_status_cd,corp_farm_status_desc,corp_fiscal_year_month,corp_foreign_fiduciary_capacity_in_state,corp_governing_statute,corp_has_members,corp_has_vested_managers,corp_home_incorporated_county,corp_home_state_name,corp_is_professional,corp_is_non_profit_irs_approved,corp_last_renewal_date,corp_last_renewal_year,corp_license_type,corp_llc_managed_desc,corp_llc_managed_ind,corp_management_desc,corp_management_type,corp_manager_managed,corp_merged_corporation_id,corp_merged_fein,corp_merger_allowed_flag,corp_merger_date,corp_merger_desc,corp_merger_effective_date,corp_merger_id,corp_merger_indicator,corp_merger_name,corp_merger_type_converted_to_cd,corp_merger_type_converted_to_desc,corp_naics_desc,corp_name_effective_date,corp_name_reservation_date,corp_name_reservation_desc,corp_name_reservation_expiration_date,corp_name_reservation_nbr,corp_name_reservation_type,corp_name_status_cd,corp_name_status_date,corp_name_status_desc,corp_non_profit_irs_approved_purpose,corp_non_profit_solicit_donations,corp_nbr_of_amendments,corp_nbr_of_initial_llc_members,corp_nbr_of_partners,corp_operating_agreement,corp_opt_in_llc_act_desc,corp_opt_in_llc_act_ind,corp_organizational_comments,corp_partner_contributions_total,corp_partner_terms,corp_percentage_voters_required_to_approve_amendments,corp_profession,corp_province,corp_public_mutual_corporation,corp_purpose,corp_ra_required_flag,corp_registered_counties,corp_regulated_ind,corp_renewal_date,corp_standing_other,corp_survivor_corporation_id,corp_tax_base,corp_tax_standing,corp_termination_cd,corp_termination_desc,corp_termination_date,corp_trademark_business_mark_type,corp_trademark_cancelled_date,corp_trademark_class_desc1,corp_trademark_class_desc2,corp_trademark_class_desc3,corp_trademark_class_desc4,corp_trademark_class_desc5,corp_trademark_class_desc6,corp_trademark_classification_nbr,corp_trademark_disclaimer1,corp_trademark_disclaimer2,corp_trademark_expiration_date,corp_trademark_filing_date,corp_trademark_first_use_date,corp_trademark_first_use_date_in_state,corp_trademark_keywords,corp_trademark_logo,corp_trademark_name_expiration_date,corp_trademark_nbr,corp_trademark_renewal_date,corp_trademark_status,corp_trademark_used_1,corp_trademark_used_2,corp_trademark_used_3,cont_owner_percentage,cont_country,cont_country_mailing,cont_nondislosure,cont_prep_addr_line1,cont_prep_addr_last_line,recordorigin, LOCAL);
  Grpd Tr(Grpd le, Grpd ri) := TRANSFORM
    SELF.Buddies := le.Buddies+1;
    SELF := le;
  END;
SHARED h0 := UNGROUP(ROLLUP(Grpd,TRUE,Tr(LEFT,RIGHT)));// Only one copy of each record
 
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT34.UIDType 1;
  SALT34.UIDType 2;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0};
  BOOLEAN dt_vendor_first_reported_year_isnull := h0.dt_vendor_first_reported_year IN SET(s.nulls_dt_vendor_first_reported_year,dt_vendor_first_reported_year); // Simplifies later processing
  BOOLEAN dt_vendor_first_reported_month_isnull := h0.dt_vendor_first_reported_month IN SET(s.nulls_dt_vendor_first_reported_month,dt_vendor_first_reported_month); // Do for each of three parts of date
  BOOLEAN dt_vendor_first_reported_day_isnull := h0.dt_vendor_first_reported_day IN SET(s.nulls_dt_vendor_first_reported_day,dt_vendor_first_reported_day);
  UNSIGNED2 dt_vendor_first_reported_year_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 dt_vendor_first_reported_month_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 dt_vendor_first_reported_day_weight100 := 0; // Contains 100x the specificity
  BOOLEAN dt_vendor_last_reported_year_isnull := h0.dt_vendor_last_reported_year IN SET(s.nulls_dt_vendor_last_reported_year,dt_vendor_last_reported_year); // Simplifies later processing
  BOOLEAN dt_vendor_last_reported_month_isnull := h0.dt_vendor_last_reported_month IN SET(s.nulls_dt_vendor_last_reported_month,dt_vendor_last_reported_month); // Do for each of three parts of date
  BOOLEAN dt_vendor_last_reported_day_isnull := h0.dt_vendor_last_reported_day IN SET(s.nulls_dt_vendor_last_reported_day,dt_vendor_last_reported_day);
  UNSIGNED2 dt_vendor_last_reported_year_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 dt_vendor_last_reported_month_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 dt_vendor_last_reported_day_weight100 := 0; // Contains 100x the specificity
  BOOLEAN dt_first_seen_year_isnull := h0.dt_first_seen_year IN SET(s.nulls_dt_first_seen_year,dt_first_seen_year); // Simplifies later processing
  BOOLEAN dt_first_seen_month_isnull := h0.dt_first_seen_month IN SET(s.nulls_dt_first_seen_month,dt_first_seen_month); // Do for each of three parts of date
  BOOLEAN dt_first_seen_day_isnull := h0.dt_first_seen_day IN SET(s.nulls_dt_first_seen_day,dt_first_seen_day);
  UNSIGNED2 dt_first_seen_year_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 dt_first_seen_month_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 dt_first_seen_day_weight100 := 0; // Contains 100x the specificity
  BOOLEAN dt_last_seen_year_isnull := h0.dt_last_seen_year IN SET(s.nulls_dt_last_seen_year,dt_last_seen_year); // Simplifies later processing
  BOOLEAN dt_last_seen_month_isnull := h0.dt_last_seen_month IN SET(s.nulls_dt_last_seen_month,dt_last_seen_month); // Do for each of three parts of date
  BOOLEAN dt_last_seen_day_isnull := h0.dt_last_seen_day IN SET(s.nulls_dt_last_seen_day,dt_last_seen_day);
  UNSIGNED2 dt_last_seen_year_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 dt_last_seen_month_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 dt_last_seen_day_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_dt_first_seen_year_isnull := h0.corp_ra_dt_first_seen_year IN SET(s.nulls_corp_ra_dt_first_seen_year,corp_ra_dt_first_seen_year); // Simplifies later processing
  BOOLEAN corp_ra_dt_first_seen_month_isnull := h0.corp_ra_dt_first_seen_month IN SET(s.nulls_corp_ra_dt_first_seen_month,corp_ra_dt_first_seen_month); // Do for each of three parts of date
  BOOLEAN corp_ra_dt_first_seen_day_isnull := h0.corp_ra_dt_first_seen_day IN SET(s.nulls_corp_ra_dt_first_seen_day,corp_ra_dt_first_seen_day);
  UNSIGNED2 corp_ra_dt_first_seen_year_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 corp_ra_dt_first_seen_month_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 corp_ra_dt_first_seen_day_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_dt_last_seen_year_isnull := h0.corp_ra_dt_last_seen_year IN SET(s.nulls_corp_ra_dt_last_seen_year,corp_ra_dt_last_seen_year); // Simplifies later processing
  BOOLEAN corp_ra_dt_last_seen_month_isnull := h0.corp_ra_dt_last_seen_month IN SET(s.nulls_corp_ra_dt_last_seen_month,corp_ra_dt_last_seen_month); // Do for each of three parts of date
  BOOLEAN corp_ra_dt_last_seen_day_isnull := h0.corp_ra_dt_last_seen_day IN SET(s.nulls_corp_ra_dt_last_seen_day,corp_ra_dt_last_seen_day);
  UNSIGNED2 corp_ra_dt_last_seen_year_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 corp_ra_dt_last_seen_month_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 corp_ra_dt_last_seen_day_weight100 := 0; // Contains 100x the specificity
  INTEGER2 corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_key_isnull := (h0.corp_key  IN SET(s.nulls_corp_key,corp_key) OR h0.corp_key = (TYPEOF(h0.corp_key))''); // Simplify later processing 
  INTEGER2 corp_supp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_supp_key_isnull := (h0.corp_supp_key  IN SET(s.nulls_corp_supp_key,corp_supp_key) OR h0.corp_supp_key = (TYPEOF(h0.corp_supp_key))''); // Simplify later processing 
  INTEGER2 corp_vendor_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_vendor_isnull := (h0.corp_vendor  IN SET(s.nulls_corp_vendor,corp_vendor) OR h0.corp_vendor = (TYPEOF(h0.corp_vendor))''); // Simplify later processing 
  INTEGER2 corp_vendor_county_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_vendor_county_isnull := (h0.corp_vendor_county  IN SET(s.nulls_corp_vendor_county,corp_vendor_county) OR h0.corp_vendor_county = (TYPEOF(h0.corp_vendor_county))''); // Simplify later processing 
  INTEGER2 corp_vendor_subcode_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_vendor_subcode_isnull := (h0.corp_vendor_subcode  IN SET(s.nulls_corp_vendor_subcode,corp_vendor_subcode) OR h0.corp_vendor_subcode = (TYPEOF(h0.corp_vendor_subcode))''); // Simplify later processing 
  INTEGER2 corp_state_origin_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_state_origin_isnull := (h0.corp_state_origin  IN SET(s.nulls_corp_state_origin,corp_state_origin) OR h0.corp_state_origin = (TYPEOF(h0.corp_state_origin))''); // Simplify later processing 
  BOOLEAN corp_process_date_year_isnull := h0.corp_process_date_year IN SET(s.nulls_corp_process_date_year,corp_process_date_year); // Simplifies later processing
  BOOLEAN corp_process_date_month_isnull := h0.corp_process_date_month IN SET(s.nulls_corp_process_date_month,corp_process_date_month); // Do for each of three parts of date
  BOOLEAN corp_process_date_day_isnull := h0.corp_process_date_day IN SET(s.nulls_corp_process_date_day,corp_process_date_day);
  UNSIGNED2 corp_process_date_year_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 corp_process_date_month_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 corp_process_date_day_weight100 := 0; // Contains 100x the specificity
  INTEGER2 corp_orig_sos_charter_nbr_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_orig_sos_charter_nbr_isnull := (h0.corp_orig_sos_charter_nbr  IN SET(s.nulls_corp_orig_sos_charter_nbr,corp_orig_sos_charter_nbr) OR h0.corp_orig_sos_charter_nbr = (TYPEOF(h0.corp_orig_sos_charter_nbr))''); // Simplify later processing 
  INTEGER2 corp_legal_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_legal_name_isnull := (h0.corp_legal_name  IN SET(s.nulls_corp_legal_name,corp_legal_name) OR h0.corp_legal_name = (TYPEOF(h0.corp_legal_name))''); // Simplify later processing 
  INTEGER2 corp_ln_name_type_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ln_name_type_cd_isnull := (h0.corp_ln_name_type_cd  IN SET(s.nulls_corp_ln_name_type_cd,corp_ln_name_type_cd) OR h0.corp_ln_name_type_cd = (TYPEOF(h0.corp_ln_name_type_cd))''); // Simplify later processing 
  INTEGER2 corp_ln_name_type_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ln_name_type_desc_isnull := (h0.corp_ln_name_type_desc  IN SET(s.nulls_corp_ln_name_type_desc,corp_ln_name_type_desc) OR h0.corp_ln_name_type_desc = (TYPEOF(h0.corp_ln_name_type_desc))''); // Simplify later processing 
  INTEGER2 corp_supp_nbr_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_supp_nbr_isnull := (h0.corp_supp_nbr  IN SET(s.nulls_corp_supp_nbr,corp_supp_nbr) OR h0.corp_supp_nbr = (TYPEOF(h0.corp_supp_nbr))''); // Simplify later processing 
  INTEGER2 corp_name_comment_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_name_comment_isnull := (h0.corp_name_comment  IN SET(s.nulls_corp_name_comment,corp_name_comment) OR h0.corp_name_comment = (TYPEOF(h0.corp_name_comment))''); // Simplify later processing 
  INTEGER2 corp_address1_type_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_address1_type_cd_isnull := (h0.corp_address1_type_cd  IN SET(s.nulls_corp_address1_type_cd,corp_address1_type_cd) OR h0.corp_address1_type_cd = (TYPEOF(h0.corp_address1_type_cd))''); // Simplify later processing 
  INTEGER2 corp_address1_type_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_address1_type_desc_isnull := (h0.corp_address1_type_desc  IN SET(s.nulls_corp_address1_type_desc,corp_address1_type_desc) OR h0.corp_address1_type_desc = (TYPEOF(h0.corp_address1_type_desc))''); // Simplify later processing 
  INTEGER2 corp_address1_line1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_address1_line1_isnull := (h0.corp_address1_line1  IN SET(s.nulls_corp_address1_line1,corp_address1_line1) OR h0.corp_address1_line1 = (TYPEOF(h0.corp_address1_line1))''); // Simplify later processing 
  INTEGER2 corp_address1_line2_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_address1_line2_isnull := (h0.corp_address1_line2  IN SET(s.nulls_corp_address1_line2,corp_address1_line2) OR h0.corp_address1_line2 = (TYPEOF(h0.corp_address1_line2))''); // Simplify later processing 
  INTEGER2 corp_address1_line3_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_address1_line3_isnull := (h0.corp_address1_line3  IN SET(s.nulls_corp_address1_line3,corp_address1_line3) OR h0.corp_address1_line3 = (TYPEOF(h0.corp_address1_line3))''); // Simplify later processing 
  INTEGER2 corp_address1_effective_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_address1_effective_date_isnull := (h0.corp_address1_effective_date  IN SET(s.nulls_corp_address1_effective_date,corp_address1_effective_date) OR h0.corp_address1_effective_date = (TYPEOF(h0.corp_address1_effective_date))''); // Simplify later processing 
  INTEGER2 corp_address2_type_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_address2_type_cd_isnull := (h0.corp_address2_type_cd  IN SET(s.nulls_corp_address2_type_cd,corp_address2_type_cd) OR h0.corp_address2_type_cd = (TYPEOF(h0.corp_address2_type_cd))''); // Simplify later processing 
  INTEGER2 corp_address2_type_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_address2_type_desc_isnull := (h0.corp_address2_type_desc  IN SET(s.nulls_corp_address2_type_desc,corp_address2_type_desc) OR h0.corp_address2_type_desc = (TYPEOF(h0.corp_address2_type_desc))''); // Simplify later processing 
  INTEGER2 corp_address2_line1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_address2_line1_isnull := (h0.corp_address2_line1  IN SET(s.nulls_corp_address2_line1,corp_address2_line1) OR h0.corp_address2_line1 = (TYPEOF(h0.corp_address2_line1))''); // Simplify later processing 
  INTEGER2 corp_address2_line2_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_address2_line2_isnull := (h0.corp_address2_line2  IN SET(s.nulls_corp_address2_line2,corp_address2_line2) OR h0.corp_address2_line2 = (TYPEOF(h0.corp_address2_line2))''); // Simplify later processing 
  INTEGER2 corp_address2_line3_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_address2_line3_isnull := (h0.corp_address2_line3  IN SET(s.nulls_corp_address2_line3,corp_address2_line3) OR h0.corp_address2_line3 = (TYPEOF(h0.corp_address2_line3))''); // Simplify later processing 
  INTEGER2 corp_address2_effective_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_address2_effective_date_isnull := (h0.corp_address2_effective_date  IN SET(s.nulls_corp_address2_effective_date,corp_address2_effective_date) OR h0.corp_address2_effective_date = (TYPEOF(h0.corp_address2_effective_date))''); // Simplify later processing 
  INTEGER2 corp_phone_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_phone_number_isnull := (h0.corp_phone_number  IN SET(s.nulls_corp_phone_number,corp_phone_number) OR h0.corp_phone_number = (TYPEOF(h0.corp_phone_number))''); // Simplify later processing 
  INTEGER2 corp_phone_number_type_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_phone_number_type_cd_isnull := (h0.corp_phone_number_type_cd  IN SET(s.nulls_corp_phone_number_type_cd,corp_phone_number_type_cd) OR h0.corp_phone_number_type_cd = (TYPEOF(h0.corp_phone_number_type_cd))''); // Simplify later processing 
  INTEGER2 corp_phone_number_type_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_phone_number_type_desc_isnull := (h0.corp_phone_number_type_desc  IN SET(s.nulls_corp_phone_number_type_desc,corp_phone_number_type_desc) OR h0.corp_phone_number_type_desc = (TYPEOF(h0.corp_phone_number_type_desc))''); // Simplify later processing 
  INTEGER2 corp_fax_nbr_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_fax_nbr_isnull := (h0.corp_fax_nbr  IN SET(s.nulls_corp_fax_nbr,corp_fax_nbr) OR h0.corp_fax_nbr = (TYPEOF(h0.corp_fax_nbr))''); // Simplify later processing 
  INTEGER2 corp_email_address_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_email_address_isnull := (h0.corp_email_address  IN SET(s.nulls_corp_email_address,corp_email_address) OR h0.corp_email_address = (TYPEOF(h0.corp_email_address))''); // Simplify later processing 
  INTEGER2 corp_web_address_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_web_address_isnull := (h0.corp_web_address  IN SET(s.nulls_corp_web_address,corp_web_address) OR h0.corp_web_address = (TYPEOF(h0.corp_web_address))''); // Simplify later processing 
  INTEGER2 corp_filing_reference_nbr_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_filing_reference_nbr_isnull := (h0.corp_filing_reference_nbr  IN SET(s.nulls_corp_filing_reference_nbr,corp_filing_reference_nbr) OR h0.corp_filing_reference_nbr = (TYPEOF(h0.corp_filing_reference_nbr))''); // Simplify later processing 
  INTEGER2 corp_filing_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_filing_date_isnull := (h0.corp_filing_date  IN SET(s.nulls_corp_filing_date,corp_filing_date) OR h0.corp_filing_date = (TYPEOF(h0.corp_filing_date))''); // Simplify later processing 
  INTEGER2 corp_filing_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_filing_cd_isnull := (h0.corp_filing_cd  IN SET(s.nulls_corp_filing_cd,corp_filing_cd) OR h0.corp_filing_cd = (TYPEOF(h0.corp_filing_cd))''); // Simplify later processing 
  INTEGER2 corp_filing_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_filing_desc_isnull := (h0.corp_filing_desc  IN SET(s.nulls_corp_filing_desc,corp_filing_desc) OR h0.corp_filing_desc = (TYPEOF(h0.corp_filing_desc))''); // Simplify later processing 
  INTEGER2 corp_status_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_status_cd_isnull := (h0.corp_status_cd  IN SET(s.nulls_corp_status_cd,corp_status_cd) OR h0.corp_status_cd = (TYPEOF(h0.corp_status_cd))''); // Simplify later processing 
  INTEGER2 corp_status_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_status_desc_isnull := (h0.corp_status_desc  IN SET(s.nulls_corp_status_desc,corp_status_desc) OR h0.corp_status_desc = (TYPEOF(h0.corp_status_desc))''); // Simplify later processing 
  INTEGER2 corp_status_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_status_date_isnull := (h0.corp_status_date  IN SET(s.nulls_corp_status_date,corp_status_date) OR h0.corp_status_date = (TYPEOF(h0.corp_status_date))''); // Simplify later processing 
  INTEGER2 corp_standing_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_standing_isnull := (h0.corp_standing  IN SET(s.nulls_corp_standing,corp_standing) OR h0.corp_standing = (TYPEOF(h0.corp_standing))''); // Simplify later processing 
  INTEGER2 corp_status_comment_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_status_comment_isnull := (h0.corp_status_comment  IN SET(s.nulls_corp_status_comment,corp_status_comment) OR h0.corp_status_comment = (TYPEOF(h0.corp_status_comment))''); // Simplify later processing 
  INTEGER2 corp_ticker_symbol_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ticker_symbol_isnull := (h0.corp_ticker_symbol  IN SET(s.nulls_corp_ticker_symbol,corp_ticker_symbol) OR h0.corp_ticker_symbol = (TYPEOF(h0.corp_ticker_symbol))''); // Simplify later processing 
  INTEGER2 corp_stock_exchange_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_stock_exchange_isnull := (h0.corp_stock_exchange  IN SET(s.nulls_corp_stock_exchange,corp_stock_exchange) OR h0.corp_stock_exchange = (TYPEOF(h0.corp_stock_exchange))''); // Simplify later processing 
  INTEGER2 corp_inc_state_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_inc_state_isnull := (h0.corp_inc_state  IN SET(s.nulls_corp_inc_state,corp_inc_state) OR h0.corp_inc_state = (TYPEOF(h0.corp_inc_state))''); // Simplify later processing 
  INTEGER2 corp_inc_county_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_inc_county_isnull := (h0.corp_inc_county  IN SET(s.nulls_corp_inc_county,corp_inc_county) OR h0.corp_inc_county = (TYPEOF(h0.corp_inc_county))''); // Simplify later processing 
  INTEGER2 corp_inc_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_inc_date_isnull := (h0.corp_inc_date  IN SET(s.nulls_corp_inc_date,corp_inc_date) OR h0.corp_inc_date = (TYPEOF(h0.corp_inc_date))''); // Simplify later processing 
  INTEGER2 corp_anniversary_month_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_anniversary_month_isnull := (h0.corp_anniversary_month  IN SET(s.nulls_corp_anniversary_month,corp_anniversary_month) OR h0.corp_anniversary_month = (TYPEOF(h0.corp_anniversary_month))''); // Simplify later processing 
  INTEGER2 corp_fed_tax_id_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_fed_tax_id_isnull := (h0.corp_fed_tax_id  IN SET(s.nulls_corp_fed_tax_id,corp_fed_tax_id) OR h0.corp_fed_tax_id = (TYPEOF(h0.corp_fed_tax_id))''); // Simplify later processing 
  INTEGER2 corp_state_tax_id_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_state_tax_id_isnull := (h0.corp_state_tax_id  IN SET(s.nulls_corp_state_tax_id,corp_state_tax_id) OR h0.corp_state_tax_id = (TYPEOF(h0.corp_state_tax_id))''); // Simplify later processing 
  INTEGER2 corp_term_exist_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_term_exist_cd_isnull := (h0.corp_term_exist_cd  IN SET(s.nulls_corp_term_exist_cd,corp_term_exist_cd) OR h0.corp_term_exist_cd = (TYPEOF(h0.corp_term_exist_cd))''); // Simplify later processing 
  INTEGER2 corp_term_exist_exp_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_term_exist_exp_isnull := (h0.corp_term_exist_exp  IN SET(s.nulls_corp_term_exist_exp,corp_term_exist_exp) OR h0.corp_term_exist_exp = (TYPEOF(h0.corp_term_exist_exp))''); // Simplify later processing 
  INTEGER2 corp_term_exist_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_term_exist_desc_isnull := (h0.corp_term_exist_desc  IN SET(s.nulls_corp_term_exist_desc,corp_term_exist_desc) OR h0.corp_term_exist_desc = (TYPEOF(h0.corp_term_exist_desc))''); // Simplify later processing 
  INTEGER2 corp_foreign_domestic_ind_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_foreign_domestic_ind_isnull := (h0.corp_foreign_domestic_ind  IN SET(s.nulls_corp_foreign_domestic_ind,corp_foreign_domestic_ind) OR h0.corp_foreign_domestic_ind = (TYPEOF(h0.corp_foreign_domestic_ind))''); // Simplify later processing 
  INTEGER2 corp_forgn_state_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_forgn_state_cd_isnull := (h0.corp_forgn_state_cd  IN SET(s.nulls_corp_forgn_state_cd,corp_forgn_state_cd) OR h0.corp_forgn_state_cd = (TYPEOF(h0.corp_forgn_state_cd))''); // Simplify later processing 
  INTEGER2 corp_forgn_state_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_forgn_state_desc_isnull := (h0.corp_forgn_state_desc  IN SET(s.nulls_corp_forgn_state_desc,corp_forgn_state_desc) OR h0.corp_forgn_state_desc = (TYPEOF(h0.corp_forgn_state_desc))''); // Simplify later processing 
  INTEGER2 corp_forgn_sos_charter_nbr_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_forgn_sos_charter_nbr_isnull := (h0.corp_forgn_sos_charter_nbr  IN SET(s.nulls_corp_forgn_sos_charter_nbr,corp_forgn_sos_charter_nbr) OR h0.corp_forgn_sos_charter_nbr = (TYPEOF(h0.corp_forgn_sos_charter_nbr))''); // Simplify later processing 
  INTEGER2 corp_forgn_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_forgn_date_isnull := (h0.corp_forgn_date  IN SET(s.nulls_corp_forgn_date,corp_forgn_date) OR h0.corp_forgn_date = (TYPEOF(h0.corp_forgn_date))''); // Simplify later processing 
  INTEGER2 corp_forgn_fed_tax_id_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_forgn_fed_tax_id_isnull := (h0.corp_forgn_fed_tax_id  IN SET(s.nulls_corp_forgn_fed_tax_id,corp_forgn_fed_tax_id) OR h0.corp_forgn_fed_tax_id = (TYPEOF(h0.corp_forgn_fed_tax_id))''); // Simplify later processing 
  INTEGER2 corp_forgn_state_tax_id_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_forgn_state_tax_id_isnull := (h0.corp_forgn_state_tax_id  IN SET(s.nulls_corp_forgn_state_tax_id,corp_forgn_state_tax_id) OR h0.corp_forgn_state_tax_id = (TYPEOF(h0.corp_forgn_state_tax_id))''); // Simplify later processing 
  INTEGER2 corp_forgn_term_exist_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_forgn_term_exist_cd_isnull := (h0.corp_forgn_term_exist_cd  IN SET(s.nulls_corp_forgn_term_exist_cd,corp_forgn_term_exist_cd) OR h0.corp_forgn_term_exist_cd = (TYPEOF(h0.corp_forgn_term_exist_cd))''); // Simplify later processing 
  INTEGER2 corp_forgn_term_exist_exp_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_forgn_term_exist_exp_isnull := (h0.corp_forgn_term_exist_exp  IN SET(s.nulls_corp_forgn_term_exist_exp,corp_forgn_term_exist_exp) OR h0.corp_forgn_term_exist_exp = (TYPEOF(h0.corp_forgn_term_exist_exp))''); // Simplify later processing 
  INTEGER2 corp_forgn_term_exist_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_forgn_term_exist_desc_isnull := (h0.corp_forgn_term_exist_desc  IN SET(s.nulls_corp_forgn_term_exist_desc,corp_forgn_term_exist_desc) OR h0.corp_forgn_term_exist_desc = (TYPEOF(h0.corp_forgn_term_exist_desc))''); // Simplify later processing 
  INTEGER2 corp_orig_org_structure_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_orig_org_structure_cd_isnull := (h0.corp_orig_org_structure_cd  IN SET(s.nulls_corp_orig_org_structure_cd,corp_orig_org_structure_cd) OR h0.corp_orig_org_structure_cd = (TYPEOF(h0.corp_orig_org_structure_cd))''); // Simplify later processing 
  INTEGER2 corp_orig_org_structure_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_orig_org_structure_desc_isnull := (h0.corp_orig_org_structure_desc  IN SET(s.nulls_corp_orig_org_structure_desc,corp_orig_org_structure_desc) OR h0.corp_orig_org_structure_desc = (TYPEOF(h0.corp_orig_org_structure_desc))''); // Simplify later processing 
  INTEGER2 corp_for_profit_ind_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_for_profit_ind_isnull := (h0.corp_for_profit_ind  IN SET(s.nulls_corp_for_profit_ind,corp_for_profit_ind) OR h0.corp_for_profit_ind = (TYPEOF(h0.corp_for_profit_ind))''); // Simplify later processing 
  INTEGER2 corp_public_or_private_ind_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_public_or_private_ind_isnull := (h0.corp_public_or_private_ind  IN SET(s.nulls_corp_public_or_private_ind,corp_public_or_private_ind) OR h0.corp_public_or_private_ind = (TYPEOF(h0.corp_public_or_private_ind))''); // Simplify later processing 
  INTEGER2 corp_sic_code_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_sic_code_isnull := (h0.corp_sic_code  IN SET(s.nulls_corp_sic_code,corp_sic_code) OR h0.corp_sic_code = (TYPEOF(h0.corp_sic_code))''); // Simplify later processing 
  INTEGER2 corp_naic_code_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_naic_code_isnull := (h0.corp_naic_code  IN SET(s.nulls_corp_naic_code,corp_naic_code) OR h0.corp_naic_code = (TYPEOF(h0.corp_naic_code))''); // Simplify later processing 
  INTEGER2 corp_orig_bus_type_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_orig_bus_type_cd_isnull := (h0.corp_orig_bus_type_cd  IN SET(s.nulls_corp_orig_bus_type_cd,corp_orig_bus_type_cd) OR h0.corp_orig_bus_type_cd = (TYPEOF(h0.corp_orig_bus_type_cd))''); // Simplify later processing 
  INTEGER2 corp_orig_bus_type_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_orig_bus_type_desc_isnull := (h0.corp_orig_bus_type_desc  IN SET(s.nulls_corp_orig_bus_type_desc,corp_orig_bus_type_desc) OR h0.corp_orig_bus_type_desc = (TYPEOF(h0.corp_orig_bus_type_desc))''); // Simplify later processing 
  INTEGER2 corp_entity_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_entity_desc_isnull := (h0.corp_entity_desc  IN SET(s.nulls_corp_entity_desc,corp_entity_desc) OR h0.corp_entity_desc = (TYPEOF(h0.corp_entity_desc))''); // Simplify later processing 
  INTEGER2 corp_certificate_nbr_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_certificate_nbr_isnull := (h0.corp_certificate_nbr  IN SET(s.nulls_corp_certificate_nbr,corp_certificate_nbr) OR h0.corp_certificate_nbr = (TYPEOF(h0.corp_certificate_nbr))''); // Simplify later processing 
  INTEGER2 corp_internal_nbr_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_internal_nbr_isnull := (h0.corp_internal_nbr  IN SET(s.nulls_corp_internal_nbr,corp_internal_nbr) OR h0.corp_internal_nbr = (TYPEOF(h0.corp_internal_nbr))''); // Simplify later processing 
  INTEGER2 corp_previous_nbr_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_previous_nbr_isnull := (h0.corp_previous_nbr  IN SET(s.nulls_corp_previous_nbr,corp_previous_nbr) OR h0.corp_previous_nbr = (TYPEOF(h0.corp_previous_nbr))''); // Simplify later processing 
  INTEGER2 corp_microfilm_nbr_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_microfilm_nbr_isnull := (h0.corp_microfilm_nbr  IN SET(s.nulls_corp_microfilm_nbr,corp_microfilm_nbr) OR h0.corp_microfilm_nbr = (TYPEOF(h0.corp_microfilm_nbr))''); // Simplify later processing 
  INTEGER2 corp_amendments_filed_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_amendments_filed_isnull := (h0.corp_amendments_filed  IN SET(s.nulls_corp_amendments_filed,corp_amendments_filed) OR h0.corp_amendments_filed = (TYPEOF(h0.corp_amendments_filed))''); // Simplify later processing 
  INTEGER2 corp_acts_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_acts_isnull := (h0.corp_acts  IN SET(s.nulls_corp_acts,corp_acts) OR h0.corp_acts = (TYPEOF(h0.corp_acts))''); // Simplify later processing 
  INTEGER2 corp_partnership_ind_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_partnership_ind_isnull := (h0.corp_partnership_ind  IN SET(s.nulls_corp_partnership_ind,corp_partnership_ind) OR h0.corp_partnership_ind = (TYPEOF(h0.corp_partnership_ind))''); // Simplify later processing 
  INTEGER2 corp_mfg_ind_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_mfg_ind_isnull := (h0.corp_mfg_ind  IN SET(s.nulls_corp_mfg_ind,corp_mfg_ind) OR h0.corp_mfg_ind = (TYPEOF(h0.corp_mfg_ind))''); // Simplify later processing 
  INTEGER2 corp_addl_info_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_addl_info_isnull := (h0.corp_addl_info  IN SET(s.nulls_corp_addl_info,corp_addl_info) OR h0.corp_addl_info = (TYPEOF(h0.corp_addl_info))''); // Simplify later processing 
  INTEGER2 corp_taxes_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_taxes_isnull := (h0.corp_taxes  IN SET(s.nulls_corp_taxes,corp_taxes) OR h0.corp_taxes = (TYPEOF(h0.corp_taxes))''); // Simplify later processing 
  INTEGER2 corp_franchise_taxes_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_franchise_taxes_isnull := (h0.corp_franchise_taxes  IN SET(s.nulls_corp_franchise_taxes,corp_franchise_taxes) OR h0.corp_franchise_taxes = (TYPEOF(h0.corp_franchise_taxes))''); // Simplify later processing 
  INTEGER2 corp_tax_program_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_tax_program_cd_isnull := (h0.corp_tax_program_cd  IN SET(s.nulls_corp_tax_program_cd,corp_tax_program_cd) OR h0.corp_tax_program_cd = (TYPEOF(h0.corp_tax_program_cd))''); // Simplify later processing 
  INTEGER2 corp_tax_program_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_tax_program_desc_isnull := (h0.corp_tax_program_desc  IN SET(s.nulls_corp_tax_program_desc,corp_tax_program_desc) OR h0.corp_tax_program_desc = (TYPEOF(h0.corp_tax_program_desc))''); // Simplify later processing 
  INTEGER2 corp_ra_full_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_full_name_isnull := (h0.corp_ra_full_name  IN SET(s.nulls_corp_ra_full_name,corp_ra_full_name) OR h0.corp_ra_full_name = (TYPEOF(h0.corp_ra_full_name))''); // Simplify later processing 
  INTEGER2 corp_ra_fname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_fname_isnull := (h0.corp_ra_fname  IN SET(s.nulls_corp_ra_fname,corp_ra_fname) OR h0.corp_ra_fname = (TYPEOF(h0.corp_ra_fname))''); // Simplify later processing 
  INTEGER2 corp_ra_mname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_mname_isnull := (h0.corp_ra_mname  IN SET(s.nulls_corp_ra_mname,corp_ra_mname) OR h0.corp_ra_mname = (TYPEOF(h0.corp_ra_mname))''); // Simplify later processing 
  INTEGER2 corp_ra_lname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_lname_isnull := (h0.corp_ra_lname  IN SET(s.nulls_corp_ra_lname,corp_ra_lname) OR h0.corp_ra_lname = (TYPEOF(h0.corp_ra_lname))''); // Simplify later processing 
  INTEGER2 corp_ra_suffix_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_suffix_isnull := (h0.corp_ra_suffix  IN SET(s.nulls_corp_ra_suffix,corp_ra_suffix) OR h0.corp_ra_suffix = (TYPEOF(h0.corp_ra_suffix))''); // Simplify later processing 
  INTEGER2 corp_ra_title_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_title_cd_isnull := (h0.corp_ra_title_cd  IN SET(s.nulls_corp_ra_title_cd,corp_ra_title_cd) OR h0.corp_ra_title_cd = (TYPEOF(h0.corp_ra_title_cd))''); // Simplify later processing 
  INTEGER2 corp_ra_title_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_title_desc_isnull := (h0.corp_ra_title_desc  IN SET(s.nulls_corp_ra_title_desc,corp_ra_title_desc) OR h0.corp_ra_title_desc = (TYPEOF(h0.corp_ra_title_desc))''); // Simplify later processing 
  INTEGER2 corp_ra_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_fein_isnull := (h0.corp_ra_fein  IN SET(s.nulls_corp_ra_fein,corp_ra_fein) OR h0.corp_ra_fein = (TYPEOF(h0.corp_ra_fein))''); // Simplify later processing 
  INTEGER2 corp_ra_ssn_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_ssn_isnull := (h0.corp_ra_ssn  IN SET(s.nulls_corp_ra_ssn,corp_ra_ssn) OR h0.corp_ra_ssn = (TYPEOF(h0.corp_ra_ssn))''); // Simplify later processing 
  INTEGER2 corp_ra_dob_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_dob_isnull := (h0.corp_ra_dob  IN SET(s.nulls_corp_ra_dob,corp_ra_dob) OR h0.corp_ra_dob = (TYPEOF(h0.corp_ra_dob))''); // Simplify later processing 
  INTEGER2 corp_ra_effective_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_effective_date_isnull := (h0.corp_ra_effective_date  IN SET(s.nulls_corp_ra_effective_date,corp_ra_effective_date) OR h0.corp_ra_effective_date = (TYPEOF(h0.corp_ra_effective_date))''); // Simplify later processing 
  INTEGER2 corp_ra_resign_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_resign_date_isnull := (h0.corp_ra_resign_date  IN SET(s.nulls_corp_ra_resign_date,corp_ra_resign_date) OR h0.corp_ra_resign_date = (TYPEOF(h0.corp_ra_resign_date))''); // Simplify later processing 
  INTEGER2 corp_ra_no_comp_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_no_comp_isnull := (h0.corp_ra_no_comp  IN SET(s.nulls_corp_ra_no_comp,corp_ra_no_comp) OR h0.corp_ra_no_comp = (TYPEOF(h0.corp_ra_no_comp))''); // Simplify later processing 
  INTEGER2 corp_ra_no_comp_igs_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_no_comp_igs_isnull := (h0.corp_ra_no_comp_igs  IN SET(s.nulls_corp_ra_no_comp_igs,corp_ra_no_comp_igs) OR h0.corp_ra_no_comp_igs = (TYPEOF(h0.corp_ra_no_comp_igs))''); // Simplify later processing 
  INTEGER2 corp_ra_addl_info_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_addl_info_isnull := (h0.corp_ra_addl_info  IN SET(s.nulls_corp_ra_addl_info,corp_ra_addl_info) OR h0.corp_ra_addl_info = (TYPEOF(h0.corp_ra_addl_info))''); // Simplify later processing 
  INTEGER2 corp_ra_address_type_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_address_type_cd_isnull := (h0.corp_ra_address_type_cd  IN SET(s.nulls_corp_ra_address_type_cd,corp_ra_address_type_cd) OR h0.corp_ra_address_type_cd = (TYPEOF(h0.corp_ra_address_type_cd))''); // Simplify later processing 
  INTEGER2 corp_ra_address_type_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_address_type_desc_isnull := (h0.corp_ra_address_type_desc  IN SET(s.nulls_corp_ra_address_type_desc,corp_ra_address_type_desc) OR h0.corp_ra_address_type_desc = (TYPEOF(h0.corp_ra_address_type_desc))''); // Simplify later processing 
  INTEGER2 corp_ra_address_line1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_address_line1_isnull := (h0.corp_ra_address_line1  IN SET(s.nulls_corp_ra_address_line1,corp_ra_address_line1) OR h0.corp_ra_address_line1 = (TYPEOF(h0.corp_ra_address_line1))''); // Simplify later processing 
  INTEGER2 corp_ra_address_line2_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_address_line2_isnull := (h0.corp_ra_address_line2  IN SET(s.nulls_corp_ra_address_line2,corp_ra_address_line2) OR h0.corp_ra_address_line2 = (TYPEOF(h0.corp_ra_address_line2))''); // Simplify later processing 
  INTEGER2 corp_ra_address_line3_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_address_line3_isnull := (h0.corp_ra_address_line3  IN SET(s.nulls_corp_ra_address_line3,corp_ra_address_line3) OR h0.corp_ra_address_line3 = (TYPEOF(h0.corp_ra_address_line3))''); // Simplify later processing 
  INTEGER2 corp_ra_phone_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_phone_number_isnull := (h0.corp_ra_phone_number  IN SET(s.nulls_corp_ra_phone_number,corp_ra_phone_number) OR h0.corp_ra_phone_number = (TYPEOF(h0.corp_ra_phone_number))''); // Simplify later processing 
  INTEGER2 corp_ra_phone_number_type_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_phone_number_type_cd_isnull := (h0.corp_ra_phone_number_type_cd  IN SET(s.nulls_corp_ra_phone_number_type_cd,corp_ra_phone_number_type_cd) OR h0.corp_ra_phone_number_type_cd = (TYPEOF(h0.corp_ra_phone_number_type_cd))''); // Simplify later processing 
  INTEGER2 corp_ra_phone_number_type_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_phone_number_type_desc_isnull := (h0.corp_ra_phone_number_type_desc  IN SET(s.nulls_corp_ra_phone_number_type_desc,corp_ra_phone_number_type_desc) OR h0.corp_ra_phone_number_type_desc = (TYPEOF(h0.corp_ra_phone_number_type_desc))''); // Simplify later processing 
  INTEGER2 corp_ra_fax_nbr_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_fax_nbr_isnull := (h0.corp_ra_fax_nbr  IN SET(s.nulls_corp_ra_fax_nbr,corp_ra_fax_nbr) OR h0.corp_ra_fax_nbr = (TYPEOF(h0.corp_ra_fax_nbr))''); // Simplify later processing 
  INTEGER2 corp_ra_email_address_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_email_address_isnull := (h0.corp_ra_email_address  IN SET(s.nulls_corp_ra_email_address,corp_ra_email_address) OR h0.corp_ra_email_address = (TYPEOF(h0.corp_ra_email_address))''); // Simplify later processing 
  INTEGER2 corp_ra_web_address_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_web_address_isnull := (h0.corp_ra_web_address  IN SET(s.nulls_corp_ra_web_address,corp_ra_web_address) OR h0.corp_ra_web_address = (TYPEOF(h0.corp_ra_web_address))''); // Simplify later processing 
  INTEGER2 corp_prep_addr1_line1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_prep_addr1_line1_isnull := (h0.corp_prep_addr1_line1  IN SET(s.nulls_corp_prep_addr1_line1,corp_prep_addr1_line1) OR h0.corp_prep_addr1_line1 = (TYPEOF(h0.corp_prep_addr1_line1))''); // Simplify later processing 
  INTEGER2 corp_prep_addr1_last_line_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_prep_addr1_last_line_isnull := (h0.corp_prep_addr1_last_line  IN SET(s.nulls_corp_prep_addr1_last_line,corp_prep_addr1_last_line) OR h0.corp_prep_addr1_last_line = (TYPEOF(h0.corp_prep_addr1_last_line))''); // Simplify later processing 
  INTEGER2 corp_prep_addr2_line1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_prep_addr2_line1_isnull := (h0.corp_prep_addr2_line1  IN SET(s.nulls_corp_prep_addr2_line1,corp_prep_addr2_line1) OR h0.corp_prep_addr2_line1 = (TYPEOF(h0.corp_prep_addr2_line1))''); // Simplify later processing 
  INTEGER2 corp_prep_addr2_last_line_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_prep_addr2_last_line_isnull := (h0.corp_prep_addr2_last_line  IN SET(s.nulls_corp_prep_addr2_last_line,corp_prep_addr2_last_line) OR h0.corp_prep_addr2_last_line = (TYPEOF(h0.corp_prep_addr2_last_line))''); // Simplify later processing 
  INTEGER2 ra_prep_addr_line1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ra_prep_addr_line1_isnull := (h0.ra_prep_addr_line1  IN SET(s.nulls_ra_prep_addr_line1,ra_prep_addr_line1) OR h0.ra_prep_addr_line1 = (TYPEOF(h0.ra_prep_addr_line1))''); // Simplify later processing 
  INTEGER2 ra_prep_addr_last_line_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ra_prep_addr_last_line_isnull := (h0.ra_prep_addr_last_line  IN SET(s.nulls_ra_prep_addr_last_line,ra_prep_addr_last_line) OR h0.ra_prep_addr_last_line = (TYPEOF(h0.ra_prep_addr_last_line))''); // Simplify later processing 
  INTEGER2 cont_filing_reference_nbr_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_filing_reference_nbr_isnull := (h0.cont_filing_reference_nbr  IN SET(s.nulls_cont_filing_reference_nbr,cont_filing_reference_nbr) OR h0.cont_filing_reference_nbr = (TYPEOF(h0.cont_filing_reference_nbr))''); // Simplify later processing 
  INTEGER2 cont_filing_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_filing_date_isnull := (h0.cont_filing_date  IN SET(s.nulls_cont_filing_date,cont_filing_date) OR h0.cont_filing_date = (TYPEOF(h0.cont_filing_date))''); // Simplify later processing 
  INTEGER2 cont_filing_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_filing_cd_isnull := (h0.cont_filing_cd  IN SET(s.nulls_cont_filing_cd,cont_filing_cd) OR h0.cont_filing_cd = (TYPEOF(h0.cont_filing_cd))''); // Simplify later processing 
  INTEGER2 cont_filing_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_filing_desc_isnull := (h0.cont_filing_desc  IN SET(s.nulls_cont_filing_desc,cont_filing_desc) OR h0.cont_filing_desc = (TYPEOF(h0.cont_filing_desc))''); // Simplify later processing 
  INTEGER2 cont_type_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_type_cd_isnull := (h0.cont_type_cd  IN SET(s.nulls_cont_type_cd,cont_type_cd) OR h0.cont_type_cd = (TYPEOF(h0.cont_type_cd))''); // Simplify later processing 
  INTEGER2 cont_type_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_type_desc_isnull := (h0.cont_type_desc  IN SET(s.nulls_cont_type_desc,cont_type_desc) OR h0.cont_type_desc = (TYPEOF(h0.cont_type_desc))''); // Simplify later processing 
  INTEGER2 cont_full_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_full_name_isnull := (h0.cont_full_name  IN SET(s.nulls_cont_full_name,cont_full_name) OR h0.cont_full_name = (TYPEOF(h0.cont_full_name))''); // Simplify later processing 
  INTEGER2 cont_fname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_fname_isnull := (h0.cont_fname  IN SET(s.nulls_cont_fname,cont_fname) OR h0.cont_fname = (TYPEOF(h0.cont_fname))''); // Simplify later processing 
  INTEGER2 cont_mname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_mname_isnull := (h0.cont_mname  IN SET(s.nulls_cont_mname,cont_mname) OR h0.cont_mname = (TYPEOF(h0.cont_mname))''); // Simplify later processing 
  INTEGER2 cont_lname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_lname_isnull := (h0.cont_lname  IN SET(s.nulls_cont_lname,cont_lname) OR h0.cont_lname = (TYPEOF(h0.cont_lname))''); // Simplify later processing 
  INTEGER2 cont_suffix_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_suffix_isnull := (h0.cont_suffix  IN SET(s.nulls_cont_suffix,cont_suffix) OR h0.cont_suffix = (TYPEOF(h0.cont_suffix))''); // Simplify later processing 
  INTEGER2 cont_title1_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_title1_desc_isnull := (h0.cont_title1_desc  IN SET(s.nulls_cont_title1_desc,cont_title1_desc) OR h0.cont_title1_desc = (TYPEOF(h0.cont_title1_desc))''); // Simplify later processing 
  INTEGER2 cont_title2_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_title2_desc_isnull := (h0.cont_title2_desc  IN SET(s.nulls_cont_title2_desc,cont_title2_desc) OR h0.cont_title2_desc = (TYPEOF(h0.cont_title2_desc))''); // Simplify later processing 
  INTEGER2 cont_title3_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_title3_desc_isnull := (h0.cont_title3_desc  IN SET(s.nulls_cont_title3_desc,cont_title3_desc) OR h0.cont_title3_desc = (TYPEOF(h0.cont_title3_desc))''); // Simplify later processing 
  INTEGER2 cont_title4_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_title4_desc_isnull := (h0.cont_title4_desc  IN SET(s.nulls_cont_title4_desc,cont_title4_desc) OR h0.cont_title4_desc = (TYPEOF(h0.cont_title4_desc))''); // Simplify later processing 
  INTEGER2 cont_title5_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_title5_desc_isnull := (h0.cont_title5_desc  IN SET(s.nulls_cont_title5_desc,cont_title5_desc) OR h0.cont_title5_desc = (TYPEOF(h0.cont_title5_desc))''); // Simplify later processing 
  INTEGER2 cont_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_fein_isnull := (h0.cont_fein  IN SET(s.nulls_cont_fein,cont_fein) OR h0.cont_fein = (TYPEOF(h0.cont_fein))''); // Simplify later processing 
  INTEGER2 cont_ssn_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_ssn_isnull := (h0.cont_ssn  IN SET(s.nulls_cont_ssn,cont_ssn) OR h0.cont_ssn = (TYPEOF(h0.cont_ssn))''); // Simplify later processing 
  INTEGER2 cont_dob_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_dob_isnull := (h0.cont_dob  IN SET(s.nulls_cont_dob,cont_dob) OR h0.cont_dob = (TYPEOF(h0.cont_dob))''); // Simplify later processing 
  INTEGER2 cont_status_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_status_cd_isnull := (h0.cont_status_cd  IN SET(s.nulls_cont_status_cd,cont_status_cd) OR h0.cont_status_cd = (TYPEOF(h0.cont_status_cd))''); // Simplify later processing 
  INTEGER2 cont_status_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_status_desc_isnull := (h0.cont_status_desc  IN SET(s.nulls_cont_status_desc,cont_status_desc) OR h0.cont_status_desc = (TYPEOF(h0.cont_status_desc))''); // Simplify later processing 
  INTEGER2 cont_effective_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_effective_date_isnull := (h0.cont_effective_date  IN SET(s.nulls_cont_effective_date,cont_effective_date) OR h0.cont_effective_date = (TYPEOF(h0.cont_effective_date))''); // Simplify later processing 
  INTEGER2 cont_effective_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_effective_cd_isnull := (h0.cont_effective_cd  IN SET(s.nulls_cont_effective_cd,cont_effective_cd) OR h0.cont_effective_cd = (TYPEOF(h0.cont_effective_cd))''); // Simplify later processing 
  INTEGER2 cont_effective_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_effective_desc_isnull := (h0.cont_effective_desc  IN SET(s.nulls_cont_effective_desc,cont_effective_desc) OR h0.cont_effective_desc = (TYPEOF(h0.cont_effective_desc))''); // Simplify later processing 
  INTEGER2 cont_addl_info_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_addl_info_isnull := (h0.cont_addl_info  IN SET(s.nulls_cont_addl_info,cont_addl_info) OR h0.cont_addl_info = (TYPEOF(h0.cont_addl_info))''); // Simplify later processing 
  INTEGER2 cont_address_type_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_address_type_cd_isnull := (h0.cont_address_type_cd  IN SET(s.nulls_cont_address_type_cd,cont_address_type_cd) OR h0.cont_address_type_cd = (TYPEOF(h0.cont_address_type_cd))''); // Simplify later processing 
  INTEGER2 cont_address_type_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_address_type_desc_isnull := (h0.cont_address_type_desc  IN SET(s.nulls_cont_address_type_desc,cont_address_type_desc) OR h0.cont_address_type_desc = (TYPEOF(h0.cont_address_type_desc))''); // Simplify later processing 
  INTEGER2 cont_address_line1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_address_line1_isnull := (h0.cont_address_line1  IN SET(s.nulls_cont_address_line1,cont_address_line1) OR h0.cont_address_line1 = (TYPEOF(h0.cont_address_line1))''); // Simplify later processing 
  INTEGER2 cont_address_line2_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_address_line2_isnull := (h0.cont_address_line2  IN SET(s.nulls_cont_address_line2,cont_address_line2) OR h0.cont_address_line2 = (TYPEOF(h0.cont_address_line2))''); // Simplify later processing 
  INTEGER2 cont_address_line3_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_address_line3_isnull := (h0.cont_address_line3  IN SET(s.nulls_cont_address_line3,cont_address_line3) OR h0.cont_address_line3 = (TYPEOF(h0.cont_address_line3))''); // Simplify later processing 
  INTEGER2 cont_address_effective_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_address_effective_date_isnull := (h0.cont_address_effective_date  IN SET(s.nulls_cont_address_effective_date,cont_address_effective_date) OR h0.cont_address_effective_date = (TYPEOF(h0.cont_address_effective_date))''); // Simplify later processing 
  INTEGER2 cont_address_county_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_address_county_isnull := (h0.cont_address_county  IN SET(s.nulls_cont_address_county,cont_address_county) OR h0.cont_address_county = (TYPEOF(h0.cont_address_county))''); // Simplify later processing 
  INTEGER2 cont_phone_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_phone_number_isnull := (h0.cont_phone_number  IN SET(s.nulls_cont_phone_number,cont_phone_number) OR h0.cont_phone_number = (TYPEOF(h0.cont_phone_number))''); // Simplify later processing 
  INTEGER2 cont_phone_number_type_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_phone_number_type_cd_isnull := (h0.cont_phone_number_type_cd  IN SET(s.nulls_cont_phone_number_type_cd,cont_phone_number_type_cd) OR h0.cont_phone_number_type_cd = (TYPEOF(h0.cont_phone_number_type_cd))''); // Simplify later processing 
  INTEGER2 cont_phone_number_type_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_phone_number_type_desc_isnull := (h0.cont_phone_number_type_desc  IN SET(s.nulls_cont_phone_number_type_desc,cont_phone_number_type_desc) OR h0.cont_phone_number_type_desc = (TYPEOF(h0.cont_phone_number_type_desc))''); // Simplify later processing 
  INTEGER2 cont_fax_nbr_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_fax_nbr_isnull := (h0.cont_fax_nbr  IN SET(s.nulls_cont_fax_nbr,cont_fax_nbr) OR h0.cont_fax_nbr = (TYPEOF(h0.cont_fax_nbr))''); // Simplify later processing 
  INTEGER2 cont_email_address_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_email_address_isnull := (h0.cont_email_address  IN SET(s.nulls_cont_email_address,cont_email_address) OR h0.cont_email_address = (TYPEOF(h0.cont_email_address))''); // Simplify later processing 
  INTEGER2 cont_web_address_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_web_address_isnull := (h0.cont_web_address  IN SET(s.nulls_cont_web_address,cont_web_address) OR h0.cont_web_address = (TYPEOF(h0.cont_web_address))''); // Simplify later processing 
  INTEGER2 corp_acres_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_acres_isnull := (h0.corp_acres  IN SET(s.nulls_corp_acres,corp_acres) OR h0.corp_acres = (TYPEOF(h0.corp_acres))''); // Simplify later processing 
  INTEGER2 corp_action_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_action_isnull := (h0.corp_action  IN SET(s.nulls_corp_action,corp_action) OR h0.corp_action = (TYPEOF(h0.corp_action))''); // Simplify later processing 
  INTEGER2 corp_action_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_action_date_isnull := (h0.corp_action_date  IN SET(s.nulls_corp_action_date,corp_action_date) OR h0.corp_action_date = (TYPEOF(h0.corp_action_date))''); // Simplify later processing 
  INTEGER2 corp_action_employment_security_approval_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_action_employment_security_approval_date_isnull := (h0.corp_action_employment_security_approval_date  IN SET(s.nulls_corp_action_employment_security_approval_date,corp_action_employment_security_approval_date) OR h0.corp_action_employment_security_approval_date = (TYPEOF(h0.corp_action_employment_security_approval_date))''); // Simplify later processing 
  INTEGER2 corp_action_pending_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_action_pending_cd_isnull := (h0.corp_action_pending_cd  IN SET(s.nulls_corp_action_pending_cd,corp_action_pending_cd) OR h0.corp_action_pending_cd = (TYPEOF(h0.corp_action_pending_cd))''); // Simplify later processing 
  INTEGER2 corp_action_pending_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_action_pending_desc_isnull := (h0.corp_action_pending_desc  IN SET(s.nulls_corp_action_pending_desc,corp_action_pending_desc) OR h0.corp_action_pending_desc = (TYPEOF(h0.corp_action_pending_desc))''); // Simplify later processing 
  INTEGER2 corp_action_statement_of_intent_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_action_statement_of_intent_date_isnull := (h0.corp_action_statement_of_intent_date  IN SET(s.nulls_corp_action_statement_of_intent_date,corp_action_statement_of_intent_date) OR h0.corp_action_statement_of_intent_date = (TYPEOF(h0.corp_action_statement_of_intent_date))''); // Simplify later processing 
  INTEGER2 corp_action_tax_dept_approval_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_action_tax_dept_approval_date_isnull := (h0.corp_action_tax_dept_approval_date  IN SET(s.nulls_corp_action_tax_dept_approval_date,corp_action_tax_dept_approval_date) OR h0.corp_action_tax_dept_approval_date = (TYPEOF(h0.corp_action_tax_dept_approval_date))''); // Simplify later processing 
  INTEGER2 corp_acts2_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_acts2_isnull := (h0.corp_acts2  IN SET(s.nulls_corp_acts2,corp_acts2) OR h0.corp_acts2 = (TYPEOF(h0.corp_acts2))''); // Simplify later processing 
  INTEGER2 corp_acts3_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_acts3_isnull := (h0.corp_acts3  IN SET(s.nulls_corp_acts3,corp_acts3) OR h0.corp_acts3 = (TYPEOF(h0.corp_acts3))''); // Simplify later processing 
  INTEGER2 corp_additional_principals_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_additional_principals_isnull := (h0.corp_additional_principals  IN SET(s.nulls_corp_additional_principals,corp_additional_principals) OR h0.corp_additional_principals = (TYPEOF(h0.corp_additional_principals))''); // Simplify later processing 
  INTEGER2 corp_address_office_type_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_address_office_type_isnull := (h0.corp_address_office_type  IN SET(s.nulls_corp_address_office_type,corp_address_office_type) OR h0.corp_address_office_type = (TYPEOF(h0.corp_address_office_type))''); // Simplify later processing 
  INTEGER2 corp_agent_assign_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_agent_assign_date_isnull := (h0.corp_agent_assign_date  IN SET(s.nulls_corp_agent_assign_date,corp_agent_assign_date) OR h0.corp_agent_assign_date = (TYPEOF(h0.corp_agent_assign_date))''); // Simplify later processing 
  INTEGER2 corp_agent_commercial_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_agent_commercial_isnull := (h0.corp_agent_commercial  IN SET(s.nulls_corp_agent_commercial,corp_agent_commercial) OR h0.corp_agent_commercial = (TYPEOF(h0.corp_agent_commercial))''); // Simplify later processing 
  INTEGER2 corp_agent_country_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_agent_country_isnull := (h0.corp_agent_country  IN SET(s.nulls_corp_agent_country,corp_agent_country) OR h0.corp_agent_country = (TYPEOF(h0.corp_agent_country))''); // Simplify later processing 
  INTEGER2 corp_agent_county_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_agent_county_isnull := (h0.corp_agent_county  IN SET(s.nulls_corp_agent_county,corp_agent_county) OR h0.corp_agent_county = (TYPEOF(h0.corp_agent_county))''); // Simplify later processing 
  INTEGER2 corp_agent_status_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_agent_status_cd_isnull := (h0.corp_agent_status_cd  IN SET(s.nulls_corp_agent_status_cd,corp_agent_status_cd) OR h0.corp_agent_status_cd = (TYPEOF(h0.corp_agent_status_cd))''); // Simplify later processing 
  INTEGER2 corp_agent_status_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_agent_status_desc_isnull := (h0.corp_agent_status_desc  IN SET(s.nulls_corp_agent_status_desc,corp_agent_status_desc) OR h0.corp_agent_status_desc = (TYPEOF(h0.corp_agent_status_desc))''); // Simplify later processing 
  INTEGER2 corp_agent_id_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_agent_id_isnull := (h0.corp_agent_id  IN SET(s.nulls_corp_agent_id,corp_agent_id) OR h0.corp_agent_id = (TYPEOF(h0.corp_agent_id))''); // Simplify later processing 
  INTEGER2 corp_agriculture_flag_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_agriculture_flag_isnull := (h0.corp_agriculture_flag  IN SET(s.nulls_corp_agriculture_flag,corp_agriculture_flag) OR h0.corp_agriculture_flag = (TYPEOF(h0.corp_agriculture_flag))''); // Simplify later processing 
  INTEGER2 corp_authorized_partners_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_authorized_partners_isnull := (h0.corp_authorized_partners  IN SET(s.nulls_corp_authorized_partners,corp_authorized_partners) OR h0.corp_authorized_partners = (TYPEOF(h0.corp_authorized_partners))''); // Simplify later processing 
  INTEGER2 corp_comment_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_comment_isnull := (h0.corp_comment  IN SET(s.nulls_corp_comment,corp_comment) OR h0.corp_comment = (TYPEOF(h0.corp_comment))''); // Simplify later processing 
  INTEGER2 corp_consent_flag_for_protected_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_consent_flag_for_protected_name_isnull := (h0.corp_consent_flag_for_protected_name  IN SET(s.nulls_corp_consent_flag_for_protected_name,corp_consent_flag_for_protected_name) OR h0.corp_consent_flag_for_protected_name = (TYPEOF(h0.corp_consent_flag_for_protected_name))''); // Simplify later processing 
  INTEGER2 corp_converted_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_converted_isnull := (h0.corp_converted  IN SET(s.nulls_corp_converted,corp_converted) OR h0.corp_converted = (TYPEOF(h0.corp_converted))''); // Simplify later processing 
  INTEGER2 corp_converted_from_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_converted_from_isnull := (h0.corp_converted_from  IN SET(s.nulls_corp_converted_from,corp_converted_from) OR h0.corp_converted_from = (TYPEOF(h0.corp_converted_from))''); // Simplify later processing 
  INTEGER2 corp_country_of_formation_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_country_of_formation_isnull := (h0.corp_country_of_formation  IN SET(s.nulls_corp_country_of_formation,corp_country_of_formation) OR h0.corp_country_of_formation = (TYPEOF(h0.corp_country_of_formation))''); // Simplify later processing 
  INTEGER2 corp_date_of_organization_meeting_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_date_of_organization_meeting_isnull := (h0.corp_date_of_organization_meeting  IN SET(s.nulls_corp_date_of_organization_meeting,corp_date_of_organization_meeting) OR h0.corp_date_of_organization_meeting = (TYPEOF(h0.corp_date_of_organization_meeting))''); // Simplify later processing 
  INTEGER2 corp_delayed_effective_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_delayed_effective_date_isnull := (h0.corp_delayed_effective_date  IN SET(s.nulls_corp_delayed_effective_date,corp_delayed_effective_date) OR h0.corp_delayed_effective_date = (TYPEOF(h0.corp_delayed_effective_date))''); // Simplify later processing 
  INTEGER2 corp_directors_from_to_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_directors_from_to_isnull := (h0.corp_directors_from_to  IN SET(s.nulls_corp_directors_from_to,corp_directors_from_to) OR h0.corp_directors_from_to = (TYPEOF(h0.corp_directors_from_to))''); // Simplify later processing 
  INTEGER2 corp_dissolved_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_dissolved_date_isnull := (h0.corp_dissolved_date  IN SET(s.nulls_corp_dissolved_date,corp_dissolved_date) OR h0.corp_dissolved_date = (TYPEOF(h0.corp_dissolved_date))''); // Simplify later processing 
  INTEGER2 corp_farm_exemptions_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_farm_exemptions_isnull := (h0.corp_farm_exemptions  IN SET(s.nulls_corp_farm_exemptions,corp_farm_exemptions) OR h0.corp_farm_exemptions = (TYPEOF(h0.corp_farm_exemptions))''); // Simplify later processing 
  INTEGER2 corp_farm_qual_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_farm_qual_date_isnull := (h0.corp_farm_qual_date  IN SET(s.nulls_corp_farm_qual_date,corp_farm_qual_date) OR h0.corp_farm_qual_date = (TYPEOF(h0.corp_farm_qual_date))''); // Simplify later processing 
  INTEGER2 corp_farm_status_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_farm_status_cd_isnull := (h0.corp_farm_status_cd  IN SET(s.nulls_corp_farm_status_cd,corp_farm_status_cd) OR h0.corp_farm_status_cd = (TYPEOF(h0.corp_farm_status_cd))''); // Simplify later processing 
  INTEGER2 corp_farm_status_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_farm_status_desc_isnull := (h0.corp_farm_status_desc  IN SET(s.nulls_corp_farm_status_desc,corp_farm_status_desc) OR h0.corp_farm_status_desc = (TYPEOF(h0.corp_farm_status_desc))''); // Simplify later processing 
  INTEGER2 corp_fiscal_year_month_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_fiscal_year_month_isnull := (h0.corp_fiscal_year_month  IN SET(s.nulls_corp_fiscal_year_month,corp_fiscal_year_month) OR h0.corp_fiscal_year_month = (TYPEOF(h0.corp_fiscal_year_month))''); // Simplify later processing 
  INTEGER2 corp_foreign_fiduciary_capacity_in_state_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_foreign_fiduciary_capacity_in_state_isnull := (h0.corp_foreign_fiduciary_capacity_in_state  IN SET(s.nulls_corp_foreign_fiduciary_capacity_in_state,corp_foreign_fiduciary_capacity_in_state) OR h0.corp_foreign_fiduciary_capacity_in_state = (TYPEOF(h0.corp_foreign_fiduciary_capacity_in_state))''); // Simplify later processing 
  INTEGER2 corp_governing_statute_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_governing_statute_isnull := (h0.corp_governing_statute  IN SET(s.nulls_corp_governing_statute,corp_governing_statute) OR h0.corp_governing_statute = (TYPEOF(h0.corp_governing_statute))''); // Simplify later processing 
  INTEGER2 corp_has_members_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_has_members_isnull := (h0.corp_has_members  IN SET(s.nulls_corp_has_members,corp_has_members) OR h0.corp_has_members = (TYPEOF(h0.corp_has_members))''); // Simplify later processing 
  INTEGER2 corp_has_vested_managers_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_has_vested_managers_isnull := (h0.corp_has_vested_managers  IN SET(s.nulls_corp_has_vested_managers,corp_has_vested_managers) OR h0.corp_has_vested_managers = (TYPEOF(h0.corp_has_vested_managers))''); // Simplify later processing 
  INTEGER2 corp_home_incorporated_county_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_home_incorporated_county_isnull := (h0.corp_home_incorporated_county  IN SET(s.nulls_corp_home_incorporated_county,corp_home_incorporated_county) OR h0.corp_home_incorporated_county = (TYPEOF(h0.corp_home_incorporated_county))''); // Simplify later processing 
  INTEGER2 corp_home_state_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_home_state_name_isnull := (h0.corp_home_state_name  IN SET(s.nulls_corp_home_state_name,corp_home_state_name) OR h0.corp_home_state_name = (TYPEOF(h0.corp_home_state_name))''); // Simplify later processing 
  INTEGER2 corp_is_professional_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_is_professional_isnull := (h0.corp_is_professional  IN SET(s.nulls_corp_is_professional,corp_is_professional) OR h0.corp_is_professional = (TYPEOF(h0.corp_is_professional))''); // Simplify later processing 
  INTEGER2 corp_is_non_profit_irs_approved_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_is_non_profit_irs_approved_isnull := (h0.corp_is_non_profit_irs_approved  IN SET(s.nulls_corp_is_non_profit_irs_approved,corp_is_non_profit_irs_approved) OR h0.corp_is_non_profit_irs_approved = (TYPEOF(h0.corp_is_non_profit_irs_approved))''); // Simplify later processing 
  INTEGER2 corp_last_renewal_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_last_renewal_date_isnull := (h0.corp_last_renewal_date  IN SET(s.nulls_corp_last_renewal_date,corp_last_renewal_date) OR h0.corp_last_renewal_date = (TYPEOF(h0.corp_last_renewal_date))''); // Simplify later processing 
  INTEGER2 corp_last_renewal_year_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_last_renewal_year_isnull := (h0.corp_last_renewal_year  IN SET(s.nulls_corp_last_renewal_year,corp_last_renewal_year) OR h0.corp_last_renewal_year = (TYPEOF(h0.corp_last_renewal_year))''); // Simplify later processing 
  INTEGER2 corp_license_type_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_license_type_isnull := (h0.corp_license_type  IN SET(s.nulls_corp_license_type,corp_license_type) OR h0.corp_license_type = (TYPEOF(h0.corp_license_type))''); // Simplify later processing 
  INTEGER2 corp_llc_managed_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_llc_managed_desc_isnull := (h0.corp_llc_managed_desc  IN SET(s.nulls_corp_llc_managed_desc,corp_llc_managed_desc) OR h0.corp_llc_managed_desc = (TYPEOF(h0.corp_llc_managed_desc))''); // Simplify later processing 
  INTEGER2 corp_llc_managed_ind_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_llc_managed_ind_isnull := (h0.corp_llc_managed_ind  IN SET(s.nulls_corp_llc_managed_ind,corp_llc_managed_ind) OR h0.corp_llc_managed_ind = (TYPEOF(h0.corp_llc_managed_ind))''); // Simplify later processing 
  INTEGER2 corp_management_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_management_desc_isnull := (h0.corp_management_desc  IN SET(s.nulls_corp_management_desc,corp_management_desc) OR h0.corp_management_desc = (TYPEOF(h0.corp_management_desc))''); // Simplify later processing 
  INTEGER2 corp_management_type_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_management_type_isnull := (h0.corp_management_type  IN SET(s.nulls_corp_management_type,corp_management_type) OR h0.corp_management_type = (TYPEOF(h0.corp_management_type))''); // Simplify later processing 
  INTEGER2 corp_manager_managed_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_manager_managed_isnull := (h0.corp_manager_managed  IN SET(s.nulls_corp_manager_managed,corp_manager_managed) OR h0.corp_manager_managed = (TYPEOF(h0.corp_manager_managed))''); // Simplify later processing 
  INTEGER2 corp_merged_corporation_id_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_merged_corporation_id_isnull := (h0.corp_merged_corporation_id  IN SET(s.nulls_corp_merged_corporation_id,corp_merged_corporation_id) OR h0.corp_merged_corporation_id = (TYPEOF(h0.corp_merged_corporation_id))''); // Simplify later processing 
  INTEGER2 corp_merged_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_merged_fein_isnull := (h0.corp_merged_fein  IN SET(s.nulls_corp_merged_fein,corp_merged_fein) OR h0.corp_merged_fein = (TYPEOF(h0.corp_merged_fein))''); // Simplify later processing 
  INTEGER2 corp_merger_allowed_flag_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_merger_allowed_flag_isnull := (h0.corp_merger_allowed_flag  IN SET(s.nulls_corp_merger_allowed_flag,corp_merger_allowed_flag) OR h0.corp_merger_allowed_flag = (TYPEOF(h0.corp_merger_allowed_flag))''); // Simplify later processing 
  INTEGER2 corp_merger_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_merger_date_isnull := (h0.corp_merger_date  IN SET(s.nulls_corp_merger_date,corp_merger_date) OR h0.corp_merger_date = (TYPEOF(h0.corp_merger_date))''); // Simplify later processing 
  INTEGER2 corp_merger_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_merger_desc_isnull := (h0.corp_merger_desc  IN SET(s.nulls_corp_merger_desc,corp_merger_desc) OR h0.corp_merger_desc = (TYPEOF(h0.corp_merger_desc))''); // Simplify later processing 
  INTEGER2 corp_merger_effective_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_merger_effective_date_isnull := (h0.corp_merger_effective_date  IN SET(s.nulls_corp_merger_effective_date,corp_merger_effective_date) OR h0.corp_merger_effective_date = (TYPEOF(h0.corp_merger_effective_date))''); // Simplify later processing 
  INTEGER2 corp_merger_id_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_merger_id_isnull := (h0.corp_merger_id  IN SET(s.nulls_corp_merger_id,corp_merger_id) OR h0.corp_merger_id = (TYPEOF(h0.corp_merger_id))''); // Simplify later processing 
  INTEGER2 corp_merger_indicator_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_merger_indicator_isnull := (h0.corp_merger_indicator  IN SET(s.nulls_corp_merger_indicator,corp_merger_indicator) OR h0.corp_merger_indicator = (TYPEOF(h0.corp_merger_indicator))''); // Simplify later processing 
  INTEGER2 corp_merger_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_merger_name_isnull := (h0.corp_merger_name  IN SET(s.nulls_corp_merger_name,corp_merger_name) OR h0.corp_merger_name = (TYPEOF(h0.corp_merger_name))''); // Simplify later processing 
  INTEGER2 corp_merger_type_converted_to_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_merger_type_converted_to_cd_isnull := (h0.corp_merger_type_converted_to_cd  IN SET(s.nulls_corp_merger_type_converted_to_cd,corp_merger_type_converted_to_cd) OR h0.corp_merger_type_converted_to_cd = (TYPEOF(h0.corp_merger_type_converted_to_cd))''); // Simplify later processing 
  INTEGER2 corp_merger_type_converted_to_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_merger_type_converted_to_desc_isnull := (h0.corp_merger_type_converted_to_desc  IN SET(s.nulls_corp_merger_type_converted_to_desc,corp_merger_type_converted_to_desc) OR h0.corp_merger_type_converted_to_desc = (TYPEOF(h0.corp_merger_type_converted_to_desc))''); // Simplify later processing 
  INTEGER2 corp_naics_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_naics_desc_isnull := (h0.corp_naics_desc  IN SET(s.nulls_corp_naics_desc,corp_naics_desc) OR h0.corp_naics_desc = (TYPEOF(h0.corp_naics_desc))''); // Simplify later processing 
  INTEGER2 corp_name_effective_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_name_effective_date_isnull := (h0.corp_name_effective_date  IN SET(s.nulls_corp_name_effective_date,corp_name_effective_date) OR h0.corp_name_effective_date = (TYPEOF(h0.corp_name_effective_date))''); // Simplify later processing 
  INTEGER2 corp_name_reservation_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_name_reservation_date_isnull := (h0.corp_name_reservation_date  IN SET(s.nulls_corp_name_reservation_date,corp_name_reservation_date) OR h0.corp_name_reservation_date = (TYPEOF(h0.corp_name_reservation_date))''); // Simplify later processing 
  INTEGER2 corp_name_reservation_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_name_reservation_desc_isnull := (h0.corp_name_reservation_desc  IN SET(s.nulls_corp_name_reservation_desc,corp_name_reservation_desc) OR h0.corp_name_reservation_desc = (TYPEOF(h0.corp_name_reservation_desc))''); // Simplify later processing 
  INTEGER2 corp_name_reservation_expiration_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_name_reservation_expiration_date_isnull := (h0.corp_name_reservation_expiration_date  IN SET(s.nulls_corp_name_reservation_expiration_date,corp_name_reservation_expiration_date) OR h0.corp_name_reservation_expiration_date = (TYPEOF(h0.corp_name_reservation_expiration_date))''); // Simplify later processing 
  INTEGER2 corp_name_reservation_nbr_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_name_reservation_nbr_isnull := (h0.corp_name_reservation_nbr  IN SET(s.nulls_corp_name_reservation_nbr,corp_name_reservation_nbr) OR h0.corp_name_reservation_nbr = (TYPEOF(h0.corp_name_reservation_nbr))''); // Simplify later processing 
  INTEGER2 corp_name_reservation_type_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_name_reservation_type_isnull := (h0.corp_name_reservation_type  IN SET(s.nulls_corp_name_reservation_type,corp_name_reservation_type) OR h0.corp_name_reservation_type = (TYPEOF(h0.corp_name_reservation_type))''); // Simplify later processing 
  INTEGER2 corp_name_status_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_name_status_cd_isnull := (h0.corp_name_status_cd  IN SET(s.nulls_corp_name_status_cd,corp_name_status_cd) OR h0.corp_name_status_cd = (TYPEOF(h0.corp_name_status_cd))''); // Simplify later processing 
  INTEGER2 corp_name_status_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_name_status_date_isnull := (h0.corp_name_status_date  IN SET(s.nulls_corp_name_status_date,corp_name_status_date) OR h0.corp_name_status_date = (TYPEOF(h0.corp_name_status_date))''); // Simplify later processing 
  INTEGER2 corp_name_status_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_name_status_desc_isnull := (h0.corp_name_status_desc  IN SET(s.nulls_corp_name_status_desc,corp_name_status_desc) OR h0.corp_name_status_desc = (TYPEOF(h0.corp_name_status_desc))''); // Simplify later processing 
  INTEGER2 corp_non_profit_irs_approved_purpose_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_non_profit_irs_approved_purpose_isnull := (h0.corp_non_profit_irs_approved_purpose  IN SET(s.nulls_corp_non_profit_irs_approved_purpose,corp_non_profit_irs_approved_purpose) OR h0.corp_non_profit_irs_approved_purpose = (TYPEOF(h0.corp_non_profit_irs_approved_purpose))''); // Simplify later processing 
  INTEGER2 corp_non_profit_solicit_donations_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_non_profit_solicit_donations_isnull := (h0.corp_non_profit_solicit_donations  IN SET(s.nulls_corp_non_profit_solicit_donations,corp_non_profit_solicit_donations) OR h0.corp_non_profit_solicit_donations = (TYPEOF(h0.corp_non_profit_solicit_donations))''); // Simplify later processing 
  INTEGER2 corp_nbr_of_amendments_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_nbr_of_amendments_isnull := (h0.corp_nbr_of_amendments  IN SET(s.nulls_corp_nbr_of_amendments,corp_nbr_of_amendments) OR h0.corp_nbr_of_amendments = (TYPEOF(h0.corp_nbr_of_amendments))''); // Simplify later processing 
  INTEGER2 corp_nbr_of_initial_llc_members_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_nbr_of_initial_llc_members_isnull := (h0.corp_nbr_of_initial_llc_members  IN SET(s.nulls_corp_nbr_of_initial_llc_members,corp_nbr_of_initial_llc_members) OR h0.corp_nbr_of_initial_llc_members = (TYPEOF(h0.corp_nbr_of_initial_llc_members))''); // Simplify later processing 
  INTEGER2 corp_nbr_of_partners_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_nbr_of_partners_isnull := (h0.corp_nbr_of_partners  IN SET(s.nulls_corp_nbr_of_partners,corp_nbr_of_partners) OR h0.corp_nbr_of_partners = (TYPEOF(h0.corp_nbr_of_partners))''); // Simplify later processing 
  INTEGER2 corp_operating_agreement_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_operating_agreement_isnull := (h0.corp_operating_agreement  IN SET(s.nulls_corp_operating_agreement,corp_operating_agreement) OR h0.corp_operating_agreement = (TYPEOF(h0.corp_operating_agreement))''); // Simplify later processing 
  INTEGER2 corp_opt_in_llc_act_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_opt_in_llc_act_desc_isnull := (h0.corp_opt_in_llc_act_desc  IN SET(s.nulls_corp_opt_in_llc_act_desc,corp_opt_in_llc_act_desc) OR h0.corp_opt_in_llc_act_desc = (TYPEOF(h0.corp_opt_in_llc_act_desc))''); // Simplify later processing 
  INTEGER2 corp_opt_in_llc_act_ind_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_opt_in_llc_act_ind_isnull := (h0.corp_opt_in_llc_act_ind  IN SET(s.nulls_corp_opt_in_llc_act_ind,corp_opt_in_llc_act_ind) OR h0.corp_opt_in_llc_act_ind = (TYPEOF(h0.corp_opt_in_llc_act_ind))''); // Simplify later processing 
  INTEGER2 corp_organizational_comments_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_organizational_comments_isnull := (h0.corp_organizational_comments  IN SET(s.nulls_corp_organizational_comments,corp_organizational_comments) OR h0.corp_organizational_comments = (TYPEOF(h0.corp_organizational_comments))''); // Simplify later processing 
  INTEGER2 corp_partner_contributions_total_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_partner_contributions_total_isnull := (h0.corp_partner_contributions_total  IN SET(s.nulls_corp_partner_contributions_total,corp_partner_contributions_total) OR h0.corp_partner_contributions_total = (TYPEOF(h0.corp_partner_contributions_total))''); // Simplify later processing 
  INTEGER2 corp_partner_terms_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_partner_terms_isnull := (h0.corp_partner_terms  IN SET(s.nulls_corp_partner_terms,corp_partner_terms) OR h0.corp_partner_terms = (TYPEOF(h0.corp_partner_terms))''); // Simplify later processing 
  INTEGER2 corp_percentage_voters_required_to_approve_amendments_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_percentage_voters_required_to_approve_amendments_isnull := (h0.corp_percentage_voters_required_to_approve_amendments  IN SET(s.nulls_corp_percentage_voters_required_to_approve_amendments,corp_percentage_voters_required_to_approve_amendments) OR h0.corp_percentage_voters_required_to_approve_amendments = (TYPEOF(h0.corp_percentage_voters_required_to_approve_amendments))''); // Simplify later processing 
  INTEGER2 corp_profession_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_profession_isnull := (h0.corp_profession  IN SET(s.nulls_corp_profession,corp_profession) OR h0.corp_profession = (TYPEOF(h0.corp_profession))''); // Simplify later processing 
  INTEGER2 corp_province_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_province_isnull := (h0.corp_province  IN SET(s.nulls_corp_province,corp_province) OR h0.corp_province = (TYPEOF(h0.corp_province))''); // Simplify later processing 
  INTEGER2 corp_public_mutual_corporation_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_public_mutual_corporation_isnull := (h0.corp_public_mutual_corporation  IN SET(s.nulls_corp_public_mutual_corporation,corp_public_mutual_corporation) OR h0.corp_public_mutual_corporation = (TYPEOF(h0.corp_public_mutual_corporation))''); // Simplify later processing 
  INTEGER2 corp_purpose_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_purpose_isnull := (h0.corp_purpose  IN SET(s.nulls_corp_purpose,corp_purpose) OR h0.corp_purpose = (TYPEOF(h0.corp_purpose))''); // Simplify later processing 
  INTEGER2 corp_ra_required_flag_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_ra_required_flag_isnull := (h0.corp_ra_required_flag  IN SET(s.nulls_corp_ra_required_flag,corp_ra_required_flag) OR h0.corp_ra_required_flag = (TYPEOF(h0.corp_ra_required_flag))''); // Simplify later processing 
  INTEGER2 corp_registered_counties_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_registered_counties_isnull := (h0.corp_registered_counties  IN SET(s.nulls_corp_registered_counties,corp_registered_counties) OR h0.corp_registered_counties = (TYPEOF(h0.corp_registered_counties))''); // Simplify later processing 
  INTEGER2 corp_regulated_ind_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_regulated_ind_isnull := (h0.corp_regulated_ind  IN SET(s.nulls_corp_regulated_ind,corp_regulated_ind) OR h0.corp_regulated_ind = (TYPEOF(h0.corp_regulated_ind))''); // Simplify later processing 
  INTEGER2 corp_renewal_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_renewal_date_isnull := (h0.corp_renewal_date  IN SET(s.nulls_corp_renewal_date,corp_renewal_date) OR h0.corp_renewal_date = (TYPEOF(h0.corp_renewal_date))''); // Simplify later processing 
  INTEGER2 corp_standing_other_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_standing_other_isnull := (h0.corp_standing_other  IN SET(s.nulls_corp_standing_other,corp_standing_other) OR h0.corp_standing_other = (TYPEOF(h0.corp_standing_other))''); // Simplify later processing 
  INTEGER2 corp_survivor_corporation_id_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_survivor_corporation_id_isnull := (h0.corp_survivor_corporation_id  IN SET(s.nulls_corp_survivor_corporation_id,corp_survivor_corporation_id) OR h0.corp_survivor_corporation_id = (TYPEOF(h0.corp_survivor_corporation_id))''); // Simplify later processing 
  INTEGER2 corp_tax_base_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_tax_base_isnull := (h0.corp_tax_base  IN SET(s.nulls_corp_tax_base,corp_tax_base) OR h0.corp_tax_base = (TYPEOF(h0.corp_tax_base))''); // Simplify later processing 
  INTEGER2 corp_tax_standing_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_tax_standing_isnull := (h0.corp_tax_standing  IN SET(s.nulls_corp_tax_standing,corp_tax_standing) OR h0.corp_tax_standing = (TYPEOF(h0.corp_tax_standing))''); // Simplify later processing 
  INTEGER2 corp_termination_cd_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_termination_cd_isnull := (h0.corp_termination_cd  IN SET(s.nulls_corp_termination_cd,corp_termination_cd) OR h0.corp_termination_cd = (TYPEOF(h0.corp_termination_cd))''); // Simplify later processing 
  INTEGER2 corp_termination_desc_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_termination_desc_isnull := (h0.corp_termination_desc  IN SET(s.nulls_corp_termination_desc,corp_termination_desc) OR h0.corp_termination_desc = (TYPEOF(h0.corp_termination_desc))''); // Simplify later processing 
  INTEGER2 corp_termination_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_termination_date_isnull := (h0.corp_termination_date  IN SET(s.nulls_corp_termination_date,corp_termination_date) OR h0.corp_termination_date = (TYPEOF(h0.corp_termination_date))''); // Simplify later processing 
  INTEGER2 corp_trademark_business_mark_type_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_business_mark_type_isnull := (h0.corp_trademark_business_mark_type  IN SET(s.nulls_corp_trademark_business_mark_type,corp_trademark_business_mark_type) OR h0.corp_trademark_business_mark_type = (TYPEOF(h0.corp_trademark_business_mark_type))''); // Simplify later processing 
  INTEGER2 corp_trademark_cancelled_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_cancelled_date_isnull := (h0.corp_trademark_cancelled_date  IN SET(s.nulls_corp_trademark_cancelled_date,corp_trademark_cancelled_date) OR h0.corp_trademark_cancelled_date = (TYPEOF(h0.corp_trademark_cancelled_date))''); // Simplify later processing 
  INTEGER2 corp_trademark_class_desc1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_class_desc1_isnull := (h0.corp_trademark_class_desc1  IN SET(s.nulls_corp_trademark_class_desc1,corp_trademark_class_desc1) OR h0.corp_trademark_class_desc1 = (TYPEOF(h0.corp_trademark_class_desc1))''); // Simplify later processing 
  INTEGER2 corp_trademark_class_desc2_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_class_desc2_isnull := (h0.corp_trademark_class_desc2  IN SET(s.nulls_corp_trademark_class_desc2,corp_trademark_class_desc2) OR h0.corp_trademark_class_desc2 = (TYPEOF(h0.corp_trademark_class_desc2))''); // Simplify later processing 
  INTEGER2 corp_trademark_class_desc3_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_class_desc3_isnull := (h0.corp_trademark_class_desc3  IN SET(s.nulls_corp_trademark_class_desc3,corp_trademark_class_desc3) OR h0.corp_trademark_class_desc3 = (TYPEOF(h0.corp_trademark_class_desc3))''); // Simplify later processing 
  INTEGER2 corp_trademark_class_desc4_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_class_desc4_isnull := (h0.corp_trademark_class_desc4  IN SET(s.nulls_corp_trademark_class_desc4,corp_trademark_class_desc4) OR h0.corp_trademark_class_desc4 = (TYPEOF(h0.corp_trademark_class_desc4))''); // Simplify later processing 
  INTEGER2 corp_trademark_class_desc5_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_class_desc5_isnull := (h0.corp_trademark_class_desc5  IN SET(s.nulls_corp_trademark_class_desc5,corp_trademark_class_desc5) OR h0.corp_trademark_class_desc5 = (TYPEOF(h0.corp_trademark_class_desc5))''); // Simplify later processing 
  INTEGER2 corp_trademark_class_desc6_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_class_desc6_isnull := (h0.corp_trademark_class_desc6  IN SET(s.nulls_corp_trademark_class_desc6,corp_trademark_class_desc6) OR h0.corp_trademark_class_desc6 = (TYPEOF(h0.corp_trademark_class_desc6))''); // Simplify later processing 
  INTEGER2 corp_trademark_classification_nbr_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_classification_nbr_isnull := (h0.corp_trademark_classification_nbr  IN SET(s.nulls_corp_trademark_classification_nbr,corp_trademark_classification_nbr) OR h0.corp_trademark_classification_nbr = (TYPEOF(h0.corp_trademark_classification_nbr))''); // Simplify later processing 
  INTEGER2 corp_trademark_disclaimer1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_disclaimer1_isnull := (h0.corp_trademark_disclaimer1  IN SET(s.nulls_corp_trademark_disclaimer1,corp_trademark_disclaimer1) OR h0.corp_trademark_disclaimer1 = (TYPEOF(h0.corp_trademark_disclaimer1))''); // Simplify later processing 
  INTEGER2 corp_trademark_disclaimer2_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_disclaimer2_isnull := (h0.corp_trademark_disclaimer2  IN SET(s.nulls_corp_trademark_disclaimer2,corp_trademark_disclaimer2) OR h0.corp_trademark_disclaimer2 = (TYPEOF(h0.corp_trademark_disclaimer2))''); // Simplify later processing 
  INTEGER2 corp_trademark_expiration_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_expiration_date_isnull := (h0.corp_trademark_expiration_date  IN SET(s.nulls_corp_trademark_expiration_date,corp_trademark_expiration_date) OR h0.corp_trademark_expiration_date = (TYPEOF(h0.corp_trademark_expiration_date))''); // Simplify later processing 
  INTEGER2 corp_trademark_filing_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_filing_date_isnull := (h0.corp_trademark_filing_date  IN SET(s.nulls_corp_trademark_filing_date,corp_trademark_filing_date) OR h0.corp_trademark_filing_date = (TYPEOF(h0.corp_trademark_filing_date))''); // Simplify later processing 
  INTEGER2 corp_trademark_first_use_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_first_use_date_isnull := (h0.corp_trademark_first_use_date  IN SET(s.nulls_corp_trademark_first_use_date,corp_trademark_first_use_date) OR h0.corp_trademark_first_use_date = (TYPEOF(h0.corp_trademark_first_use_date))''); // Simplify later processing 
  INTEGER2 corp_trademark_first_use_date_in_state_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_first_use_date_in_state_isnull := (h0.corp_trademark_first_use_date_in_state  IN SET(s.nulls_corp_trademark_first_use_date_in_state,corp_trademark_first_use_date_in_state) OR h0.corp_trademark_first_use_date_in_state = (TYPEOF(h0.corp_trademark_first_use_date_in_state))''); // Simplify later processing 
  INTEGER2 corp_trademark_keywords_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_keywords_isnull := (h0.corp_trademark_keywords  IN SET(s.nulls_corp_trademark_keywords,corp_trademark_keywords) OR h0.corp_trademark_keywords = (TYPEOF(h0.corp_trademark_keywords))''); // Simplify later processing 
  INTEGER2 corp_trademark_logo_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_logo_isnull := (h0.corp_trademark_logo  IN SET(s.nulls_corp_trademark_logo,corp_trademark_logo) OR h0.corp_trademark_logo = (TYPEOF(h0.corp_trademark_logo))''); // Simplify later processing 
  INTEGER2 corp_trademark_name_expiration_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_name_expiration_date_isnull := (h0.corp_trademark_name_expiration_date  IN SET(s.nulls_corp_trademark_name_expiration_date,corp_trademark_name_expiration_date) OR h0.corp_trademark_name_expiration_date = (TYPEOF(h0.corp_trademark_name_expiration_date))''); // Simplify later processing 
  INTEGER2 corp_trademark_nbr_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_nbr_isnull := (h0.corp_trademark_nbr  IN SET(s.nulls_corp_trademark_nbr,corp_trademark_nbr) OR h0.corp_trademark_nbr = (TYPEOF(h0.corp_trademark_nbr))''); // Simplify later processing 
  INTEGER2 corp_trademark_renewal_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_renewal_date_isnull := (h0.corp_trademark_renewal_date  IN SET(s.nulls_corp_trademark_renewal_date,corp_trademark_renewal_date) OR h0.corp_trademark_renewal_date = (TYPEOF(h0.corp_trademark_renewal_date))''); // Simplify later processing 
  INTEGER2 corp_trademark_status_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_status_isnull := (h0.corp_trademark_status  IN SET(s.nulls_corp_trademark_status,corp_trademark_status) OR h0.corp_trademark_status = (TYPEOF(h0.corp_trademark_status))''); // Simplify later processing 
  INTEGER2 corp_trademark_used_1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_used_1_isnull := (h0.corp_trademark_used_1  IN SET(s.nulls_corp_trademark_used_1,corp_trademark_used_1) OR h0.corp_trademark_used_1 = (TYPEOF(h0.corp_trademark_used_1))''); // Simplify later processing 
  INTEGER2 corp_trademark_used_2_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_used_2_isnull := (h0.corp_trademark_used_2  IN SET(s.nulls_corp_trademark_used_2,corp_trademark_used_2) OR h0.corp_trademark_used_2 = (TYPEOF(h0.corp_trademark_used_2))''); // Simplify later processing 
  INTEGER2 corp_trademark_used_3_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_trademark_used_3_isnull := (h0.corp_trademark_used_3  IN SET(s.nulls_corp_trademark_used_3,corp_trademark_used_3) OR h0.corp_trademark_used_3 = (TYPEOF(h0.corp_trademark_used_3))''); // Simplify later processing 
  INTEGER2 cont_owner_percentage_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_owner_percentage_isnull := (h0.cont_owner_percentage  IN SET(s.nulls_cont_owner_percentage,cont_owner_percentage) OR h0.cont_owner_percentage = (TYPEOF(h0.cont_owner_percentage))''); // Simplify later processing 
  INTEGER2 cont_country_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_country_isnull := (h0.cont_country  IN SET(s.nulls_cont_country,cont_country) OR h0.cont_country = (TYPEOF(h0.cont_country))''); // Simplify later processing 
  INTEGER2 cont_country_mailing_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_country_mailing_isnull := (h0.cont_country_mailing  IN SET(s.nulls_cont_country_mailing,cont_country_mailing) OR h0.cont_country_mailing = (TYPEOF(h0.cont_country_mailing))''); // Simplify later processing 
  INTEGER2 cont_nondislosure_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_nondislosure_isnull := (h0.cont_nondislosure  IN SET(s.nulls_cont_nondislosure,cont_nondislosure) OR h0.cont_nondislosure = (TYPEOF(h0.cont_nondislosure))''); // Simplify later processing 
  INTEGER2 cont_prep_addr_line1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_prep_addr_line1_isnull := (h0.cont_prep_addr_line1  IN SET(s.nulls_cont_prep_addr_line1,cont_prep_addr_line1) OR h0.cont_prep_addr_line1 = (TYPEOF(h0.cont_prep_addr_line1))''); // Simplify later processing 
  INTEGER2 cont_prep_addr_last_line_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cont_prep_addr_last_line_isnull := (h0.cont_prep_addr_last_line  IN SET(s.nulls_cont_prep_addr_last_line,cont_prep_addr_last_line) OR h0.cont_prep_addr_last_line = (TYPEOF(h0.cont_prep_addr_last_line))''); // Simplify later processing 
  INTEGER2 recordorigin_weight100 := 0; // Contains 100x the specificity
  BOOLEAN recordorigin_isnull := (h0.recordorigin  IN SET(s.nulls_recordorigin,recordorigin) OR h0.recordorigin = (TYPEOF(h0.recordorigin))''); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
 
//Would also create auto-id fields here
 
layout_candidates add_recordorigin(layout_candidates le,Specificities(ih).recordorigin_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.recordorigin_weight100 := MAP (le.recordorigin_isnull => 0, patch_default and ri.field_specificity=0 => s.recordorigin_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j288 := JOIN(h1,PULL(Specificities(ih).recordorigin_values_persisted),LEFT.recordorigin=RIGHT.recordorigin,add_recordorigin(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_prep_addr_last_line(layout_candidates le,Specificities(ih).cont_prep_addr_last_line_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_prep_addr_last_line_weight100 := MAP (le.cont_prep_addr_last_line_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_prep_addr_last_line_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j287 := JOIN(j288,PULL(Specificities(ih).cont_prep_addr_last_line_values_persisted),LEFT.cont_prep_addr_last_line=RIGHT.cont_prep_addr_last_line,add_cont_prep_addr_last_line(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_prep_addr_line1(layout_candidates le,Specificities(ih).cont_prep_addr_line1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_prep_addr_line1_weight100 := MAP (le.cont_prep_addr_line1_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_prep_addr_line1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j286 := JOIN(j287,PULL(Specificities(ih).cont_prep_addr_line1_values_persisted),LEFT.cont_prep_addr_line1=RIGHT.cont_prep_addr_line1,add_cont_prep_addr_line1(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_nondislosure(layout_candidates le,Specificities(ih).cont_nondislosure_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_nondislosure_weight100 := MAP (le.cont_nondislosure_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_nondislosure_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j285 := JOIN(j286,PULL(Specificities(ih).cont_nondislosure_values_persisted),LEFT.cont_nondislosure=RIGHT.cont_nondislosure,add_cont_nondislosure(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_country_mailing(layout_candidates le,Specificities(ih).cont_country_mailing_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_country_mailing_weight100 := MAP (le.cont_country_mailing_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_country_mailing_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j284 := JOIN(j285,PULL(Specificities(ih).cont_country_mailing_values_persisted),LEFT.cont_country_mailing=RIGHT.cont_country_mailing,add_cont_country_mailing(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_country(layout_candidates le,Specificities(ih).cont_country_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_country_weight100 := MAP (le.cont_country_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_country_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j283 := JOIN(j284,PULL(Specificities(ih).cont_country_values_persisted),LEFT.cont_country=RIGHT.cont_country,add_cont_country(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_owner_percentage(layout_candidates le,Specificities(ih).cont_owner_percentage_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_owner_percentage_weight100 := MAP (le.cont_owner_percentage_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_owner_percentage_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j282 := JOIN(j283,PULL(Specificities(ih).cont_owner_percentage_values_persisted),LEFT.cont_owner_percentage=RIGHT.cont_owner_percentage,add_cont_owner_percentage(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_used_3(layout_candidates le,Specificities(ih).corp_trademark_used_3_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_used_3_weight100 := MAP (le.corp_trademark_used_3_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_used_3_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j281 := JOIN(j282,PULL(Specificities(ih).corp_trademark_used_3_values_persisted),LEFT.corp_trademark_used_3=RIGHT.corp_trademark_used_3,add_corp_trademark_used_3(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_used_2(layout_candidates le,Specificities(ih).corp_trademark_used_2_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_used_2_weight100 := MAP (le.corp_trademark_used_2_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_used_2_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j280 := JOIN(j281,PULL(Specificities(ih).corp_trademark_used_2_values_persisted),LEFT.corp_trademark_used_2=RIGHT.corp_trademark_used_2,add_corp_trademark_used_2(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_used_1(layout_candidates le,Specificities(ih).corp_trademark_used_1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_used_1_weight100 := MAP (le.corp_trademark_used_1_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_used_1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j279 := JOIN(j280,PULL(Specificities(ih).corp_trademark_used_1_values_persisted),LEFT.corp_trademark_used_1=RIGHT.corp_trademark_used_1,add_corp_trademark_used_1(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_status(layout_candidates le,Specificities(ih).corp_trademark_status_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_status_weight100 := MAP (le.corp_trademark_status_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_status_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j278 := JOIN(j279,PULL(Specificities(ih).corp_trademark_status_values_persisted),LEFT.corp_trademark_status=RIGHT.corp_trademark_status,add_corp_trademark_status(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_renewal_date(layout_candidates le,Specificities(ih).corp_trademark_renewal_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_renewal_date_weight100 := MAP (le.corp_trademark_renewal_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_renewal_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j277 := JOIN(j278,PULL(Specificities(ih).corp_trademark_renewal_date_values_persisted),LEFT.corp_trademark_renewal_date=RIGHT.corp_trademark_renewal_date,add_corp_trademark_renewal_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_nbr(layout_candidates le,Specificities(ih).corp_trademark_nbr_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_nbr_weight100 := MAP (le.corp_trademark_nbr_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_nbr_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j276 := JOIN(j277,PULL(Specificities(ih).corp_trademark_nbr_values_persisted),LEFT.corp_trademark_nbr=RIGHT.corp_trademark_nbr,add_corp_trademark_nbr(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_name_expiration_date(layout_candidates le,Specificities(ih).corp_trademark_name_expiration_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_name_expiration_date_weight100 := MAP (le.corp_trademark_name_expiration_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_name_expiration_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j275 := JOIN(j276,PULL(Specificities(ih).corp_trademark_name_expiration_date_values_persisted),LEFT.corp_trademark_name_expiration_date=RIGHT.corp_trademark_name_expiration_date,add_corp_trademark_name_expiration_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_logo(layout_candidates le,Specificities(ih).corp_trademark_logo_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_logo_weight100 := MAP (le.corp_trademark_logo_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_logo_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j274 := JOIN(j275,PULL(Specificities(ih).corp_trademark_logo_values_persisted),LEFT.corp_trademark_logo=RIGHT.corp_trademark_logo,add_corp_trademark_logo(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_keywords(layout_candidates le,Specificities(ih).corp_trademark_keywords_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_keywords_weight100 := MAP (le.corp_trademark_keywords_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_keywords_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j273 := JOIN(j274,PULL(Specificities(ih).corp_trademark_keywords_values_persisted),LEFT.corp_trademark_keywords=RIGHT.corp_trademark_keywords,add_corp_trademark_keywords(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_first_use_date_in_state(layout_candidates le,Specificities(ih).corp_trademark_first_use_date_in_state_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_first_use_date_in_state_weight100 := MAP (le.corp_trademark_first_use_date_in_state_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_first_use_date_in_state_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j272 := JOIN(j273,PULL(Specificities(ih).corp_trademark_first_use_date_in_state_values_persisted),LEFT.corp_trademark_first_use_date_in_state=RIGHT.corp_trademark_first_use_date_in_state,add_corp_trademark_first_use_date_in_state(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_first_use_date(layout_candidates le,Specificities(ih).corp_trademark_first_use_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_first_use_date_weight100 := MAP (le.corp_trademark_first_use_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_first_use_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j271 := JOIN(j272,PULL(Specificities(ih).corp_trademark_first_use_date_values_persisted),LEFT.corp_trademark_first_use_date=RIGHT.corp_trademark_first_use_date,add_corp_trademark_first_use_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_filing_date(layout_candidates le,Specificities(ih).corp_trademark_filing_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_filing_date_weight100 := MAP (le.corp_trademark_filing_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_filing_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j270 := JOIN(j271,PULL(Specificities(ih).corp_trademark_filing_date_values_persisted),LEFT.corp_trademark_filing_date=RIGHT.corp_trademark_filing_date,add_corp_trademark_filing_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_expiration_date(layout_candidates le,Specificities(ih).corp_trademark_expiration_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_expiration_date_weight100 := MAP (le.corp_trademark_expiration_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_expiration_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j269 := JOIN(j270,PULL(Specificities(ih).corp_trademark_expiration_date_values_persisted),LEFT.corp_trademark_expiration_date=RIGHT.corp_trademark_expiration_date,add_corp_trademark_expiration_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_disclaimer2(layout_candidates le,Specificities(ih).corp_trademark_disclaimer2_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_disclaimer2_weight100 := MAP (le.corp_trademark_disclaimer2_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_disclaimer2_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j268 := JOIN(j269,PULL(Specificities(ih).corp_trademark_disclaimer2_values_persisted),LEFT.corp_trademark_disclaimer2=RIGHT.corp_trademark_disclaimer2,add_corp_trademark_disclaimer2(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_disclaimer1(layout_candidates le,Specificities(ih).corp_trademark_disclaimer1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_disclaimer1_weight100 := MAP (le.corp_trademark_disclaimer1_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_disclaimer1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j267 := JOIN(j268,PULL(Specificities(ih).corp_trademark_disclaimer1_values_persisted),LEFT.corp_trademark_disclaimer1=RIGHT.corp_trademark_disclaimer1,add_corp_trademark_disclaimer1(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_classification_nbr(layout_candidates le,Specificities(ih).corp_trademark_classification_nbr_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_classification_nbr_weight100 := MAP (le.corp_trademark_classification_nbr_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_classification_nbr_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j266 := JOIN(j267,PULL(Specificities(ih).corp_trademark_classification_nbr_values_persisted),LEFT.corp_trademark_classification_nbr=RIGHT.corp_trademark_classification_nbr,add_corp_trademark_classification_nbr(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_class_desc6(layout_candidates le,Specificities(ih).corp_trademark_class_desc6_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_class_desc6_weight100 := MAP (le.corp_trademark_class_desc6_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_class_desc6_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j265 := JOIN(j266,PULL(Specificities(ih).corp_trademark_class_desc6_values_persisted),LEFT.corp_trademark_class_desc6=RIGHT.corp_trademark_class_desc6,add_corp_trademark_class_desc6(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_class_desc5(layout_candidates le,Specificities(ih).corp_trademark_class_desc5_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_class_desc5_weight100 := MAP (le.corp_trademark_class_desc5_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_class_desc5_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j264 := JOIN(j265,PULL(Specificities(ih).corp_trademark_class_desc5_values_persisted),LEFT.corp_trademark_class_desc5=RIGHT.corp_trademark_class_desc5,add_corp_trademark_class_desc5(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_class_desc4(layout_candidates le,Specificities(ih).corp_trademark_class_desc4_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_class_desc4_weight100 := MAP (le.corp_trademark_class_desc4_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_class_desc4_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j263 := JOIN(j264,PULL(Specificities(ih).corp_trademark_class_desc4_values_persisted),LEFT.corp_trademark_class_desc4=RIGHT.corp_trademark_class_desc4,add_corp_trademark_class_desc4(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_class_desc3(layout_candidates le,Specificities(ih).corp_trademark_class_desc3_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_class_desc3_weight100 := MAP (le.corp_trademark_class_desc3_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_class_desc3_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j262 := JOIN(j263,PULL(Specificities(ih).corp_trademark_class_desc3_values_persisted),LEFT.corp_trademark_class_desc3=RIGHT.corp_trademark_class_desc3,add_corp_trademark_class_desc3(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_class_desc2(layout_candidates le,Specificities(ih).corp_trademark_class_desc2_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_class_desc2_weight100 := MAP (le.corp_trademark_class_desc2_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_class_desc2_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j261 := JOIN(j262,PULL(Specificities(ih).corp_trademark_class_desc2_values_persisted),LEFT.corp_trademark_class_desc2=RIGHT.corp_trademark_class_desc2,add_corp_trademark_class_desc2(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_class_desc1(layout_candidates le,Specificities(ih).corp_trademark_class_desc1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_class_desc1_weight100 := MAP (le.corp_trademark_class_desc1_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_class_desc1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j260 := JOIN(j261,PULL(Specificities(ih).corp_trademark_class_desc1_values_persisted),LEFT.corp_trademark_class_desc1=RIGHT.corp_trademark_class_desc1,add_corp_trademark_class_desc1(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_cancelled_date(layout_candidates le,Specificities(ih).corp_trademark_cancelled_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_cancelled_date_weight100 := MAP (le.corp_trademark_cancelled_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_cancelled_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j259 := JOIN(j260,PULL(Specificities(ih).corp_trademark_cancelled_date_values_persisted),LEFT.corp_trademark_cancelled_date=RIGHT.corp_trademark_cancelled_date,add_corp_trademark_cancelled_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_trademark_business_mark_type(layout_candidates le,Specificities(ih).corp_trademark_business_mark_type_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_trademark_business_mark_type_weight100 := MAP (le.corp_trademark_business_mark_type_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_trademark_business_mark_type_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j258 := JOIN(j259,PULL(Specificities(ih).corp_trademark_business_mark_type_values_persisted),LEFT.corp_trademark_business_mark_type=RIGHT.corp_trademark_business_mark_type,add_corp_trademark_business_mark_type(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_termination_date(layout_candidates le,Specificities(ih).corp_termination_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_termination_date_weight100 := MAP (le.corp_termination_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_termination_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j257 := JOIN(j258,PULL(Specificities(ih).corp_termination_date_values_persisted),LEFT.corp_termination_date=RIGHT.corp_termination_date,add_corp_termination_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_termination_desc(layout_candidates le,Specificities(ih).corp_termination_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_termination_desc_weight100 := MAP (le.corp_termination_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_termination_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j256 := JOIN(j257,PULL(Specificities(ih).corp_termination_desc_values_persisted),LEFT.corp_termination_desc=RIGHT.corp_termination_desc,add_corp_termination_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_termination_cd(layout_candidates le,Specificities(ih).corp_termination_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_termination_cd_weight100 := MAP (le.corp_termination_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_termination_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j255 := JOIN(j256,PULL(Specificities(ih).corp_termination_cd_values_persisted),LEFT.corp_termination_cd=RIGHT.corp_termination_cd,add_corp_termination_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_tax_standing(layout_candidates le,Specificities(ih).corp_tax_standing_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_tax_standing_weight100 := MAP (le.corp_tax_standing_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_tax_standing_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j254 := JOIN(j255,PULL(Specificities(ih).corp_tax_standing_values_persisted),LEFT.corp_tax_standing=RIGHT.corp_tax_standing,add_corp_tax_standing(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_tax_base(layout_candidates le,Specificities(ih).corp_tax_base_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_tax_base_weight100 := MAP (le.corp_tax_base_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_tax_base_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j253 := JOIN(j254,PULL(Specificities(ih).corp_tax_base_values_persisted),LEFT.corp_tax_base=RIGHT.corp_tax_base,add_corp_tax_base(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_survivor_corporation_id(layout_candidates le,Specificities(ih).corp_survivor_corporation_id_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_survivor_corporation_id_weight100 := MAP (le.corp_survivor_corporation_id_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_survivor_corporation_id_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j252 := JOIN(j253,PULL(Specificities(ih).corp_survivor_corporation_id_values_persisted),LEFT.corp_survivor_corporation_id=RIGHT.corp_survivor_corporation_id,add_corp_survivor_corporation_id(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_standing_other(layout_candidates le,Specificities(ih).corp_standing_other_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_standing_other_weight100 := MAP (le.corp_standing_other_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_standing_other_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j251 := JOIN(j252,PULL(Specificities(ih).corp_standing_other_values_persisted),LEFT.corp_standing_other=RIGHT.corp_standing_other,add_corp_standing_other(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_renewal_date(layout_candidates le,Specificities(ih).corp_renewal_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_renewal_date_weight100 := MAP (le.corp_renewal_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_renewal_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j250 := JOIN(j251,PULL(Specificities(ih).corp_renewal_date_values_persisted),LEFT.corp_renewal_date=RIGHT.corp_renewal_date,add_corp_renewal_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_regulated_ind(layout_candidates le,Specificities(ih).corp_regulated_ind_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_regulated_ind_weight100 := MAP (le.corp_regulated_ind_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_regulated_ind_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j249 := JOIN(j250,PULL(Specificities(ih).corp_regulated_ind_values_persisted),LEFT.corp_regulated_ind=RIGHT.corp_regulated_ind,add_corp_regulated_ind(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_registered_counties(layout_candidates le,Specificities(ih).corp_registered_counties_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_registered_counties_weight100 := MAP (le.corp_registered_counties_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_registered_counties_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j248 := JOIN(j249,PULL(Specificities(ih).corp_registered_counties_values_persisted),LEFT.corp_registered_counties=RIGHT.corp_registered_counties,add_corp_registered_counties(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_required_flag(layout_candidates le,Specificities(ih).corp_ra_required_flag_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_required_flag_weight100 := MAP (le.corp_ra_required_flag_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_required_flag_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j247 := JOIN(j248,PULL(Specificities(ih).corp_ra_required_flag_values_persisted),LEFT.corp_ra_required_flag=RIGHT.corp_ra_required_flag,add_corp_ra_required_flag(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_purpose(layout_candidates le,Specificities(ih).corp_purpose_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_purpose_weight100 := MAP (le.corp_purpose_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_purpose_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j246 := JOIN(j247,PULL(Specificities(ih).corp_purpose_values_persisted),LEFT.corp_purpose=RIGHT.corp_purpose,add_corp_purpose(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_public_mutual_corporation(layout_candidates le,Specificities(ih).corp_public_mutual_corporation_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_public_mutual_corporation_weight100 := MAP (le.corp_public_mutual_corporation_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_public_mutual_corporation_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j245 := JOIN(j246,PULL(Specificities(ih).corp_public_mutual_corporation_values_persisted),LEFT.corp_public_mutual_corporation=RIGHT.corp_public_mutual_corporation,add_corp_public_mutual_corporation(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_province(layout_candidates le,Specificities(ih).corp_province_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_province_weight100 := MAP (le.corp_province_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_province_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j244 := JOIN(j245,PULL(Specificities(ih).corp_province_values_persisted),LEFT.corp_province=RIGHT.corp_province,add_corp_province(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_profession(layout_candidates le,Specificities(ih).corp_profession_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_profession_weight100 := MAP (le.corp_profession_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_profession_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j243 := JOIN(j244,PULL(Specificities(ih).corp_profession_values_persisted),LEFT.corp_profession=RIGHT.corp_profession,add_corp_profession(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_percentage_voters_required_to_approve_amendments(layout_candidates le,Specificities(ih).corp_percentage_voters_required_to_approve_amendments_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_percentage_voters_required_to_approve_amendments_weight100 := MAP (le.corp_percentage_voters_required_to_approve_amendments_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_percentage_voters_required_to_approve_amendments_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j242 := JOIN(j243,PULL(Specificities(ih).corp_percentage_voters_required_to_approve_amendments_values_persisted),LEFT.corp_percentage_voters_required_to_approve_amendments=RIGHT.corp_percentage_voters_required_to_approve_amendments,add_corp_percentage_voters_required_to_approve_amendments(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_partner_terms(layout_candidates le,Specificities(ih).corp_partner_terms_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_partner_terms_weight100 := MAP (le.corp_partner_terms_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_partner_terms_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j241 := JOIN(j242,PULL(Specificities(ih).corp_partner_terms_values_persisted),LEFT.corp_partner_terms=RIGHT.corp_partner_terms,add_corp_partner_terms(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_partner_contributions_total(layout_candidates le,Specificities(ih).corp_partner_contributions_total_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_partner_contributions_total_weight100 := MAP (le.corp_partner_contributions_total_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_partner_contributions_total_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j240 := JOIN(j241,PULL(Specificities(ih).corp_partner_contributions_total_values_persisted),LEFT.corp_partner_contributions_total=RIGHT.corp_partner_contributions_total,add_corp_partner_contributions_total(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_organizational_comments(layout_candidates le,Specificities(ih).corp_organizational_comments_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_organizational_comments_weight100 := MAP (le.corp_organizational_comments_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_organizational_comments_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j239 := JOIN(j240,PULL(Specificities(ih).corp_organizational_comments_values_persisted),LEFT.corp_organizational_comments=RIGHT.corp_organizational_comments,add_corp_organizational_comments(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_opt_in_llc_act_ind(layout_candidates le,Specificities(ih).corp_opt_in_llc_act_ind_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_opt_in_llc_act_ind_weight100 := MAP (le.corp_opt_in_llc_act_ind_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_opt_in_llc_act_ind_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j238 := JOIN(j239,PULL(Specificities(ih).corp_opt_in_llc_act_ind_values_persisted),LEFT.corp_opt_in_llc_act_ind=RIGHT.corp_opt_in_llc_act_ind,add_corp_opt_in_llc_act_ind(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_opt_in_llc_act_desc(layout_candidates le,Specificities(ih).corp_opt_in_llc_act_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_opt_in_llc_act_desc_weight100 := MAP (le.corp_opt_in_llc_act_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_opt_in_llc_act_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j237 := JOIN(j238,PULL(Specificities(ih).corp_opt_in_llc_act_desc_values_persisted),LEFT.corp_opt_in_llc_act_desc=RIGHT.corp_opt_in_llc_act_desc,add_corp_opt_in_llc_act_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_operating_agreement(layout_candidates le,Specificities(ih).corp_operating_agreement_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_operating_agreement_weight100 := MAP (le.corp_operating_agreement_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_operating_agreement_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j236 := JOIN(j237,PULL(Specificities(ih).corp_operating_agreement_values_persisted),LEFT.corp_operating_agreement=RIGHT.corp_operating_agreement,add_corp_operating_agreement(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_nbr_of_partners(layout_candidates le,Specificities(ih).corp_nbr_of_partners_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_nbr_of_partners_weight100 := MAP (le.corp_nbr_of_partners_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_nbr_of_partners_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j235 := JOIN(j236,PULL(Specificities(ih).corp_nbr_of_partners_values_persisted),LEFT.corp_nbr_of_partners=RIGHT.corp_nbr_of_partners,add_corp_nbr_of_partners(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_nbr_of_initial_llc_members(layout_candidates le,Specificities(ih).corp_nbr_of_initial_llc_members_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_nbr_of_initial_llc_members_weight100 := MAP (le.corp_nbr_of_initial_llc_members_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_nbr_of_initial_llc_members_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j234 := JOIN(j235,PULL(Specificities(ih).corp_nbr_of_initial_llc_members_values_persisted),LEFT.corp_nbr_of_initial_llc_members=RIGHT.corp_nbr_of_initial_llc_members,add_corp_nbr_of_initial_llc_members(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_nbr_of_amendments(layout_candidates le,Specificities(ih).corp_nbr_of_amendments_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_nbr_of_amendments_weight100 := MAP (le.corp_nbr_of_amendments_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_nbr_of_amendments_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j233 := JOIN(j234,PULL(Specificities(ih).corp_nbr_of_amendments_values_persisted),LEFT.corp_nbr_of_amendments=RIGHT.corp_nbr_of_amendments,add_corp_nbr_of_amendments(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_non_profit_solicit_donations(layout_candidates le,Specificities(ih).corp_non_profit_solicit_donations_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_non_profit_solicit_donations_weight100 := MAP (le.corp_non_profit_solicit_donations_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_non_profit_solicit_donations_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j232 := JOIN(j233,PULL(Specificities(ih).corp_non_profit_solicit_donations_values_persisted),LEFT.corp_non_profit_solicit_donations=RIGHT.corp_non_profit_solicit_donations,add_corp_non_profit_solicit_donations(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_non_profit_irs_approved_purpose(layout_candidates le,Specificities(ih).corp_non_profit_irs_approved_purpose_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_non_profit_irs_approved_purpose_weight100 := MAP (le.corp_non_profit_irs_approved_purpose_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_non_profit_irs_approved_purpose_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j231 := JOIN(j232,PULL(Specificities(ih).corp_non_profit_irs_approved_purpose_values_persisted),LEFT.corp_non_profit_irs_approved_purpose=RIGHT.corp_non_profit_irs_approved_purpose,add_corp_non_profit_irs_approved_purpose(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_name_status_desc(layout_candidates le,Specificities(ih).corp_name_status_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_name_status_desc_weight100 := MAP (le.corp_name_status_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_name_status_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j230 := JOIN(j231,PULL(Specificities(ih).corp_name_status_desc_values_persisted),LEFT.corp_name_status_desc=RIGHT.corp_name_status_desc,add_corp_name_status_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_name_status_date(layout_candidates le,Specificities(ih).corp_name_status_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_name_status_date_weight100 := MAP (le.corp_name_status_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_name_status_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j229 := JOIN(j230,PULL(Specificities(ih).corp_name_status_date_values_persisted),LEFT.corp_name_status_date=RIGHT.corp_name_status_date,add_corp_name_status_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_name_status_cd(layout_candidates le,Specificities(ih).corp_name_status_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_name_status_cd_weight100 := MAP (le.corp_name_status_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_name_status_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j228 := JOIN(j229,PULL(Specificities(ih).corp_name_status_cd_values_persisted),LEFT.corp_name_status_cd=RIGHT.corp_name_status_cd,add_corp_name_status_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_name_reservation_type(layout_candidates le,Specificities(ih).corp_name_reservation_type_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_name_reservation_type_weight100 := MAP (le.corp_name_reservation_type_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_name_reservation_type_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j227 := JOIN(j228,PULL(Specificities(ih).corp_name_reservation_type_values_persisted),LEFT.corp_name_reservation_type=RIGHT.corp_name_reservation_type,add_corp_name_reservation_type(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_name_reservation_nbr(layout_candidates le,Specificities(ih).corp_name_reservation_nbr_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_name_reservation_nbr_weight100 := MAP (le.corp_name_reservation_nbr_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_name_reservation_nbr_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j226 := JOIN(j227,PULL(Specificities(ih).corp_name_reservation_nbr_values_persisted),LEFT.corp_name_reservation_nbr=RIGHT.corp_name_reservation_nbr,add_corp_name_reservation_nbr(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_name_reservation_expiration_date(layout_candidates le,Specificities(ih).corp_name_reservation_expiration_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_name_reservation_expiration_date_weight100 := MAP (le.corp_name_reservation_expiration_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_name_reservation_expiration_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j225 := JOIN(j226,PULL(Specificities(ih).corp_name_reservation_expiration_date_values_persisted),LEFT.corp_name_reservation_expiration_date=RIGHT.corp_name_reservation_expiration_date,add_corp_name_reservation_expiration_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_name_reservation_desc(layout_candidates le,Specificities(ih).corp_name_reservation_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_name_reservation_desc_weight100 := MAP (le.corp_name_reservation_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_name_reservation_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j224 := JOIN(j225,PULL(Specificities(ih).corp_name_reservation_desc_values_persisted),LEFT.corp_name_reservation_desc=RIGHT.corp_name_reservation_desc,add_corp_name_reservation_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_name_reservation_date(layout_candidates le,Specificities(ih).corp_name_reservation_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_name_reservation_date_weight100 := MAP (le.corp_name_reservation_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_name_reservation_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j223 := JOIN(j224,PULL(Specificities(ih).corp_name_reservation_date_values_persisted),LEFT.corp_name_reservation_date=RIGHT.corp_name_reservation_date,add_corp_name_reservation_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_name_effective_date(layout_candidates le,Specificities(ih).corp_name_effective_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_name_effective_date_weight100 := MAP (le.corp_name_effective_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_name_effective_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j222 := JOIN(j223,PULL(Specificities(ih).corp_name_effective_date_values_persisted),LEFT.corp_name_effective_date=RIGHT.corp_name_effective_date,add_corp_name_effective_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_naics_desc(layout_candidates le,Specificities(ih).corp_naics_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_naics_desc_weight100 := MAP (le.corp_naics_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_naics_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j221 := JOIN(j222,PULL(Specificities(ih).corp_naics_desc_values_persisted),LEFT.corp_naics_desc=RIGHT.corp_naics_desc,add_corp_naics_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_merger_type_converted_to_desc(layout_candidates le,Specificities(ih).corp_merger_type_converted_to_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_merger_type_converted_to_desc_weight100 := MAP (le.corp_merger_type_converted_to_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_merger_type_converted_to_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j220 := JOIN(j221,PULL(Specificities(ih).corp_merger_type_converted_to_desc_values_persisted),LEFT.corp_merger_type_converted_to_desc=RIGHT.corp_merger_type_converted_to_desc,add_corp_merger_type_converted_to_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_merger_type_converted_to_cd(layout_candidates le,Specificities(ih).corp_merger_type_converted_to_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_merger_type_converted_to_cd_weight100 := MAP (le.corp_merger_type_converted_to_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_merger_type_converted_to_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j219 := JOIN(j220,PULL(Specificities(ih).corp_merger_type_converted_to_cd_values_persisted),LEFT.corp_merger_type_converted_to_cd=RIGHT.corp_merger_type_converted_to_cd,add_corp_merger_type_converted_to_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_merger_name(layout_candidates le,Specificities(ih).corp_merger_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_merger_name_weight100 := MAP (le.corp_merger_name_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_merger_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j218 := JOIN(j219,PULL(Specificities(ih).corp_merger_name_values_persisted),LEFT.corp_merger_name=RIGHT.corp_merger_name,add_corp_merger_name(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_merger_indicator(layout_candidates le,Specificities(ih).corp_merger_indicator_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_merger_indicator_weight100 := MAP (le.corp_merger_indicator_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_merger_indicator_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j217 := JOIN(j218,PULL(Specificities(ih).corp_merger_indicator_values_persisted),LEFT.corp_merger_indicator=RIGHT.corp_merger_indicator,add_corp_merger_indicator(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_merger_id(layout_candidates le,Specificities(ih).corp_merger_id_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_merger_id_weight100 := MAP (le.corp_merger_id_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_merger_id_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j216 := JOIN(j217,PULL(Specificities(ih).corp_merger_id_values_persisted),LEFT.corp_merger_id=RIGHT.corp_merger_id,add_corp_merger_id(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_merger_effective_date(layout_candidates le,Specificities(ih).corp_merger_effective_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_merger_effective_date_weight100 := MAP (le.corp_merger_effective_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_merger_effective_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j215 := JOIN(j216,PULL(Specificities(ih).corp_merger_effective_date_values_persisted),LEFT.corp_merger_effective_date=RIGHT.corp_merger_effective_date,add_corp_merger_effective_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_merger_desc(layout_candidates le,Specificities(ih).corp_merger_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_merger_desc_weight100 := MAP (le.corp_merger_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_merger_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j214 := JOIN(j215,PULL(Specificities(ih).corp_merger_desc_values_persisted),LEFT.corp_merger_desc=RIGHT.corp_merger_desc,add_corp_merger_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_merger_date(layout_candidates le,Specificities(ih).corp_merger_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_merger_date_weight100 := MAP (le.corp_merger_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_merger_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j213 := JOIN(j214,PULL(Specificities(ih).corp_merger_date_values_persisted),LEFT.corp_merger_date=RIGHT.corp_merger_date,add_corp_merger_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_merger_allowed_flag(layout_candidates le,Specificities(ih).corp_merger_allowed_flag_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_merger_allowed_flag_weight100 := MAP (le.corp_merger_allowed_flag_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_merger_allowed_flag_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j212 := JOIN(j213,PULL(Specificities(ih).corp_merger_allowed_flag_values_persisted),LEFT.corp_merger_allowed_flag=RIGHT.corp_merger_allowed_flag,add_corp_merger_allowed_flag(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_merged_fein(layout_candidates le,Specificities(ih).corp_merged_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_merged_fein_weight100 := MAP (le.corp_merged_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_merged_fein_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j211 := JOIN(j212,PULL(Specificities(ih).corp_merged_fein_values_persisted),LEFT.corp_merged_fein=RIGHT.corp_merged_fein,add_corp_merged_fein(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_merged_corporation_id(layout_candidates le,Specificities(ih).corp_merged_corporation_id_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_merged_corporation_id_weight100 := MAP (le.corp_merged_corporation_id_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_merged_corporation_id_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j210 := JOIN(j211,PULL(Specificities(ih).corp_merged_corporation_id_values_persisted),LEFT.corp_merged_corporation_id=RIGHT.corp_merged_corporation_id,add_corp_merged_corporation_id(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_manager_managed(layout_candidates le,Specificities(ih).corp_manager_managed_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_manager_managed_weight100 := MAP (le.corp_manager_managed_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_manager_managed_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j209 := JOIN(j210,PULL(Specificities(ih).corp_manager_managed_values_persisted),LEFT.corp_manager_managed=RIGHT.corp_manager_managed,add_corp_manager_managed(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_management_type(layout_candidates le,Specificities(ih).corp_management_type_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_management_type_weight100 := MAP (le.corp_management_type_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_management_type_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j208 := JOIN(j209,PULL(Specificities(ih).corp_management_type_values_persisted),LEFT.corp_management_type=RIGHT.corp_management_type,add_corp_management_type(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_management_desc(layout_candidates le,Specificities(ih).corp_management_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_management_desc_weight100 := MAP (le.corp_management_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_management_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j207 := JOIN(j208,PULL(Specificities(ih).corp_management_desc_values_persisted),LEFT.corp_management_desc=RIGHT.corp_management_desc,add_corp_management_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_llc_managed_ind(layout_candidates le,Specificities(ih).corp_llc_managed_ind_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_llc_managed_ind_weight100 := MAP (le.corp_llc_managed_ind_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_llc_managed_ind_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j206 := JOIN(j207,PULL(Specificities(ih).corp_llc_managed_ind_values_persisted),LEFT.corp_llc_managed_ind=RIGHT.corp_llc_managed_ind,add_corp_llc_managed_ind(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_llc_managed_desc(layout_candidates le,Specificities(ih).corp_llc_managed_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_llc_managed_desc_weight100 := MAP (le.corp_llc_managed_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_llc_managed_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j205 := JOIN(j206,PULL(Specificities(ih).corp_llc_managed_desc_values_persisted),LEFT.corp_llc_managed_desc=RIGHT.corp_llc_managed_desc,add_corp_llc_managed_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_license_type(layout_candidates le,Specificities(ih).corp_license_type_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_license_type_weight100 := MAP (le.corp_license_type_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_license_type_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j204 := JOIN(j205,PULL(Specificities(ih).corp_license_type_values_persisted),LEFT.corp_license_type=RIGHT.corp_license_type,add_corp_license_type(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_last_renewal_year(layout_candidates le,Specificities(ih).corp_last_renewal_year_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_last_renewal_year_weight100 := MAP (le.corp_last_renewal_year_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_last_renewal_year_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j203 := JOIN(j204,PULL(Specificities(ih).corp_last_renewal_year_values_persisted),LEFT.corp_last_renewal_year=RIGHT.corp_last_renewal_year,add_corp_last_renewal_year(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_last_renewal_date(layout_candidates le,Specificities(ih).corp_last_renewal_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_last_renewal_date_weight100 := MAP (le.corp_last_renewal_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_last_renewal_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j202 := JOIN(j203,PULL(Specificities(ih).corp_last_renewal_date_values_persisted),LEFT.corp_last_renewal_date=RIGHT.corp_last_renewal_date,add_corp_last_renewal_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_is_non_profit_irs_approved(layout_candidates le,Specificities(ih).corp_is_non_profit_irs_approved_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_is_non_profit_irs_approved_weight100 := MAP (le.corp_is_non_profit_irs_approved_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_is_non_profit_irs_approved_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j201 := JOIN(j202,PULL(Specificities(ih).corp_is_non_profit_irs_approved_values_persisted),LEFT.corp_is_non_profit_irs_approved=RIGHT.corp_is_non_profit_irs_approved,add_corp_is_non_profit_irs_approved(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_is_professional(layout_candidates le,Specificities(ih).corp_is_professional_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_is_professional_weight100 := MAP (le.corp_is_professional_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_is_professional_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j200 := JOIN(j201,PULL(Specificities(ih).corp_is_professional_values_persisted),LEFT.corp_is_professional=RIGHT.corp_is_professional,add_corp_is_professional(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_home_state_name(layout_candidates le,Specificities(ih).corp_home_state_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_home_state_name_weight100 := MAP (le.corp_home_state_name_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_home_state_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j199 := JOIN(j200,PULL(Specificities(ih).corp_home_state_name_values_persisted),LEFT.corp_home_state_name=RIGHT.corp_home_state_name,add_corp_home_state_name(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_home_incorporated_county(layout_candidates le,Specificities(ih).corp_home_incorporated_county_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_home_incorporated_county_weight100 := MAP (le.corp_home_incorporated_county_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_home_incorporated_county_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j198 := JOIN(j199,PULL(Specificities(ih).corp_home_incorporated_county_values_persisted),LEFT.corp_home_incorporated_county=RIGHT.corp_home_incorporated_county,add_corp_home_incorporated_county(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_has_vested_managers(layout_candidates le,Specificities(ih).corp_has_vested_managers_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_has_vested_managers_weight100 := MAP (le.corp_has_vested_managers_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_has_vested_managers_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j197 := JOIN(j198,PULL(Specificities(ih).corp_has_vested_managers_values_persisted),LEFT.corp_has_vested_managers=RIGHT.corp_has_vested_managers,add_corp_has_vested_managers(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_has_members(layout_candidates le,Specificities(ih).corp_has_members_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_has_members_weight100 := MAP (le.corp_has_members_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_has_members_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j196 := JOIN(j197,PULL(Specificities(ih).corp_has_members_values_persisted),LEFT.corp_has_members=RIGHT.corp_has_members,add_corp_has_members(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_governing_statute(layout_candidates le,Specificities(ih).corp_governing_statute_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_governing_statute_weight100 := MAP (le.corp_governing_statute_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_governing_statute_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j195 := JOIN(j196,PULL(Specificities(ih).corp_governing_statute_values_persisted),LEFT.corp_governing_statute=RIGHT.corp_governing_statute,add_corp_governing_statute(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_foreign_fiduciary_capacity_in_state(layout_candidates le,Specificities(ih).corp_foreign_fiduciary_capacity_in_state_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_foreign_fiduciary_capacity_in_state_weight100 := MAP (le.corp_foreign_fiduciary_capacity_in_state_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_foreign_fiduciary_capacity_in_state_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j194 := JOIN(j195,PULL(Specificities(ih).corp_foreign_fiduciary_capacity_in_state_values_persisted),LEFT.corp_foreign_fiduciary_capacity_in_state=RIGHT.corp_foreign_fiduciary_capacity_in_state,add_corp_foreign_fiduciary_capacity_in_state(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_fiscal_year_month(layout_candidates le,Specificities(ih).corp_fiscal_year_month_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_fiscal_year_month_weight100 := MAP (le.corp_fiscal_year_month_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_fiscal_year_month_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j193 := JOIN(j194,PULL(Specificities(ih).corp_fiscal_year_month_values_persisted),LEFT.corp_fiscal_year_month=RIGHT.corp_fiscal_year_month,add_corp_fiscal_year_month(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_farm_status_desc(layout_candidates le,Specificities(ih).corp_farm_status_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_farm_status_desc_weight100 := MAP (le.corp_farm_status_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_farm_status_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j192 := JOIN(j193,PULL(Specificities(ih).corp_farm_status_desc_values_persisted),LEFT.corp_farm_status_desc=RIGHT.corp_farm_status_desc,add_corp_farm_status_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_farm_status_cd(layout_candidates le,Specificities(ih).corp_farm_status_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_farm_status_cd_weight100 := MAP (le.corp_farm_status_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_farm_status_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j191 := JOIN(j192,PULL(Specificities(ih).corp_farm_status_cd_values_persisted),LEFT.corp_farm_status_cd=RIGHT.corp_farm_status_cd,add_corp_farm_status_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_farm_qual_date(layout_candidates le,Specificities(ih).corp_farm_qual_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_farm_qual_date_weight100 := MAP (le.corp_farm_qual_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_farm_qual_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j190 := JOIN(j191,PULL(Specificities(ih).corp_farm_qual_date_values_persisted),LEFT.corp_farm_qual_date=RIGHT.corp_farm_qual_date,add_corp_farm_qual_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_farm_exemptions(layout_candidates le,Specificities(ih).corp_farm_exemptions_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_farm_exemptions_weight100 := MAP (le.corp_farm_exemptions_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_farm_exemptions_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j189 := JOIN(j190,PULL(Specificities(ih).corp_farm_exemptions_values_persisted),LEFT.corp_farm_exemptions=RIGHT.corp_farm_exemptions,add_corp_farm_exemptions(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_dissolved_date(layout_candidates le,Specificities(ih).corp_dissolved_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_dissolved_date_weight100 := MAP (le.corp_dissolved_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_dissolved_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j188 := JOIN(j189,PULL(Specificities(ih).corp_dissolved_date_values_persisted),LEFT.corp_dissolved_date=RIGHT.corp_dissolved_date,add_corp_dissolved_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_directors_from_to(layout_candidates le,Specificities(ih).corp_directors_from_to_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_directors_from_to_weight100 := MAP (le.corp_directors_from_to_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_directors_from_to_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j187 := JOIN(j188,PULL(Specificities(ih).corp_directors_from_to_values_persisted),LEFT.corp_directors_from_to=RIGHT.corp_directors_from_to,add_corp_directors_from_to(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_delayed_effective_date(layout_candidates le,Specificities(ih).corp_delayed_effective_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_delayed_effective_date_weight100 := MAP (le.corp_delayed_effective_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_delayed_effective_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j186 := JOIN(j187,PULL(Specificities(ih).corp_delayed_effective_date_values_persisted),LEFT.corp_delayed_effective_date=RIGHT.corp_delayed_effective_date,add_corp_delayed_effective_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_date_of_organization_meeting(layout_candidates le,Specificities(ih).corp_date_of_organization_meeting_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_date_of_organization_meeting_weight100 := MAP (le.corp_date_of_organization_meeting_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_date_of_organization_meeting_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j185 := JOIN(j186,PULL(Specificities(ih).corp_date_of_organization_meeting_values_persisted),LEFT.corp_date_of_organization_meeting=RIGHT.corp_date_of_organization_meeting,add_corp_date_of_organization_meeting(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_country_of_formation(layout_candidates le,Specificities(ih).corp_country_of_formation_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_country_of_formation_weight100 := MAP (le.corp_country_of_formation_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_country_of_formation_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j184 := JOIN(j185,PULL(Specificities(ih).corp_country_of_formation_values_persisted),LEFT.corp_country_of_formation=RIGHT.corp_country_of_formation,add_corp_country_of_formation(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_converted_from(layout_candidates le,Specificities(ih).corp_converted_from_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_converted_from_weight100 := MAP (le.corp_converted_from_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_converted_from_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j183 := JOIN(j184,PULL(Specificities(ih).corp_converted_from_values_persisted),LEFT.corp_converted_from=RIGHT.corp_converted_from,add_corp_converted_from(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_converted(layout_candidates le,Specificities(ih).corp_converted_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_converted_weight100 := MAP (le.corp_converted_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_converted_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j182 := JOIN(j183,PULL(Specificities(ih).corp_converted_values_persisted),LEFT.corp_converted=RIGHT.corp_converted,add_corp_converted(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_consent_flag_for_protected_name(layout_candidates le,Specificities(ih).corp_consent_flag_for_protected_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_consent_flag_for_protected_name_weight100 := MAP (le.corp_consent_flag_for_protected_name_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_consent_flag_for_protected_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j181 := JOIN(j182,PULL(Specificities(ih).corp_consent_flag_for_protected_name_values_persisted),LEFT.corp_consent_flag_for_protected_name=RIGHT.corp_consent_flag_for_protected_name,add_corp_consent_flag_for_protected_name(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_comment(layout_candidates le,Specificities(ih).corp_comment_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_comment_weight100 := MAP (le.corp_comment_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_comment_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j180 := JOIN(j181,PULL(Specificities(ih).corp_comment_values_persisted),LEFT.corp_comment=RIGHT.corp_comment,add_corp_comment(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_authorized_partners(layout_candidates le,Specificities(ih).corp_authorized_partners_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_authorized_partners_weight100 := MAP (le.corp_authorized_partners_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_authorized_partners_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j179 := JOIN(j180,PULL(Specificities(ih).corp_authorized_partners_values_persisted),LEFT.corp_authorized_partners=RIGHT.corp_authorized_partners,add_corp_authorized_partners(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_agriculture_flag(layout_candidates le,Specificities(ih).corp_agriculture_flag_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_agriculture_flag_weight100 := MAP (le.corp_agriculture_flag_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_agriculture_flag_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j178 := JOIN(j179,PULL(Specificities(ih).corp_agriculture_flag_values_persisted),LEFT.corp_agriculture_flag=RIGHT.corp_agriculture_flag,add_corp_agriculture_flag(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_agent_id(layout_candidates le,Specificities(ih).corp_agent_id_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_agent_id_weight100 := MAP (le.corp_agent_id_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_agent_id_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j177 := JOIN(j178,PULL(Specificities(ih).corp_agent_id_values_persisted),LEFT.corp_agent_id=RIGHT.corp_agent_id,add_corp_agent_id(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_agent_status_desc(layout_candidates le,Specificities(ih).corp_agent_status_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_agent_status_desc_weight100 := MAP (le.corp_agent_status_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_agent_status_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j176 := JOIN(j177,PULL(Specificities(ih).corp_agent_status_desc_values_persisted),LEFT.corp_agent_status_desc=RIGHT.corp_agent_status_desc,add_corp_agent_status_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_agent_status_cd(layout_candidates le,Specificities(ih).corp_agent_status_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_agent_status_cd_weight100 := MAP (le.corp_agent_status_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_agent_status_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j175 := JOIN(j176,PULL(Specificities(ih).corp_agent_status_cd_values_persisted),LEFT.corp_agent_status_cd=RIGHT.corp_agent_status_cd,add_corp_agent_status_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_agent_county(layout_candidates le,Specificities(ih).corp_agent_county_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_agent_county_weight100 := MAP (le.corp_agent_county_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_agent_county_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j174 := JOIN(j175,PULL(Specificities(ih).corp_agent_county_values_persisted),LEFT.corp_agent_county=RIGHT.corp_agent_county,add_corp_agent_county(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_agent_country(layout_candidates le,Specificities(ih).corp_agent_country_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_agent_country_weight100 := MAP (le.corp_agent_country_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_agent_country_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j173 := JOIN(j174,PULL(Specificities(ih).corp_agent_country_values_persisted),LEFT.corp_agent_country=RIGHT.corp_agent_country,add_corp_agent_country(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_agent_commercial(layout_candidates le,Specificities(ih).corp_agent_commercial_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_agent_commercial_weight100 := MAP (le.corp_agent_commercial_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_agent_commercial_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j172 := JOIN(j173,PULL(Specificities(ih).corp_agent_commercial_values_persisted),LEFT.corp_agent_commercial=RIGHT.corp_agent_commercial,add_corp_agent_commercial(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_agent_assign_date(layout_candidates le,Specificities(ih).corp_agent_assign_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_agent_assign_date_weight100 := MAP (le.corp_agent_assign_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_agent_assign_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j171 := JOIN(j172,PULL(Specificities(ih).corp_agent_assign_date_values_persisted),LEFT.corp_agent_assign_date=RIGHT.corp_agent_assign_date,add_corp_agent_assign_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_address_office_type(layout_candidates le,Specificities(ih).corp_address_office_type_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_address_office_type_weight100 := MAP (le.corp_address_office_type_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_address_office_type_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j170 := JOIN(j171,PULL(Specificities(ih).corp_address_office_type_values_persisted),LEFT.corp_address_office_type=RIGHT.corp_address_office_type,add_corp_address_office_type(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_additional_principals(layout_candidates le,Specificities(ih).corp_additional_principals_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_additional_principals_weight100 := MAP (le.corp_additional_principals_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_additional_principals_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j169 := JOIN(j170,PULL(Specificities(ih).corp_additional_principals_values_persisted),LEFT.corp_additional_principals=RIGHT.corp_additional_principals,add_corp_additional_principals(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_acts3(layout_candidates le,Specificities(ih).corp_acts3_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_acts3_weight100 := MAP (le.corp_acts3_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_acts3_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j168 := JOIN(j169,PULL(Specificities(ih).corp_acts3_values_persisted),LEFT.corp_acts3=RIGHT.corp_acts3,add_corp_acts3(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_acts2(layout_candidates le,Specificities(ih).corp_acts2_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_acts2_weight100 := MAP (le.corp_acts2_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_acts2_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j167 := JOIN(j168,PULL(Specificities(ih).corp_acts2_values_persisted),LEFT.corp_acts2=RIGHT.corp_acts2,add_corp_acts2(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_action_tax_dept_approval_date(layout_candidates le,Specificities(ih).corp_action_tax_dept_approval_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_action_tax_dept_approval_date_weight100 := MAP (le.corp_action_tax_dept_approval_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_action_tax_dept_approval_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j166 := JOIN(j167,PULL(Specificities(ih).corp_action_tax_dept_approval_date_values_persisted),LEFT.corp_action_tax_dept_approval_date=RIGHT.corp_action_tax_dept_approval_date,add_corp_action_tax_dept_approval_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_action_statement_of_intent_date(layout_candidates le,Specificities(ih).corp_action_statement_of_intent_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_action_statement_of_intent_date_weight100 := MAP (le.corp_action_statement_of_intent_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_action_statement_of_intent_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j165 := JOIN(j166,PULL(Specificities(ih).corp_action_statement_of_intent_date_values_persisted),LEFT.corp_action_statement_of_intent_date=RIGHT.corp_action_statement_of_intent_date,add_corp_action_statement_of_intent_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_action_pending_desc(layout_candidates le,Specificities(ih).corp_action_pending_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_action_pending_desc_weight100 := MAP (le.corp_action_pending_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_action_pending_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j164 := JOIN(j165,PULL(Specificities(ih).corp_action_pending_desc_values_persisted),LEFT.corp_action_pending_desc=RIGHT.corp_action_pending_desc,add_corp_action_pending_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_action_pending_cd(layout_candidates le,Specificities(ih).corp_action_pending_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_action_pending_cd_weight100 := MAP (le.corp_action_pending_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_action_pending_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j163 := JOIN(j164,PULL(Specificities(ih).corp_action_pending_cd_values_persisted),LEFT.corp_action_pending_cd=RIGHT.corp_action_pending_cd,add_corp_action_pending_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_action_employment_security_approval_date(layout_candidates le,Specificities(ih).corp_action_employment_security_approval_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_action_employment_security_approval_date_weight100 := MAP (le.corp_action_employment_security_approval_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_action_employment_security_approval_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j162 := JOIN(j163,PULL(Specificities(ih).corp_action_employment_security_approval_date_values_persisted),LEFT.corp_action_employment_security_approval_date=RIGHT.corp_action_employment_security_approval_date,add_corp_action_employment_security_approval_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_action_date(layout_candidates le,Specificities(ih).corp_action_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_action_date_weight100 := MAP (le.corp_action_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_action_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j161 := JOIN(j162,PULL(Specificities(ih).corp_action_date_values_persisted),LEFT.corp_action_date=RIGHT.corp_action_date,add_corp_action_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_action(layout_candidates le,Specificities(ih).corp_action_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_action_weight100 := MAP (le.corp_action_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_action_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j160 := JOIN(j161,PULL(Specificities(ih).corp_action_values_persisted),LEFT.corp_action=RIGHT.corp_action,add_corp_action(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_acres(layout_candidates le,Specificities(ih).corp_acres_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_acres_weight100 := MAP (le.corp_acres_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_acres_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j159 := JOIN(j160,PULL(Specificities(ih).corp_acres_values_persisted),LEFT.corp_acres=RIGHT.corp_acres,add_corp_acres(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_web_address(layout_candidates le,Specificities(ih).cont_web_address_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_web_address_weight100 := MAP (le.cont_web_address_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_web_address_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j158 := JOIN(j159,PULL(Specificities(ih).cont_web_address_values_persisted),LEFT.cont_web_address=RIGHT.cont_web_address,add_cont_web_address(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_email_address(layout_candidates le,Specificities(ih).cont_email_address_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_email_address_weight100 := MAP (le.cont_email_address_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_email_address_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j157 := JOIN(j158,PULL(Specificities(ih).cont_email_address_values_persisted),LEFT.cont_email_address=RIGHT.cont_email_address,add_cont_email_address(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_fax_nbr(layout_candidates le,Specificities(ih).cont_fax_nbr_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_fax_nbr_weight100 := MAP (le.cont_fax_nbr_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_fax_nbr_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j156 := JOIN(j157,PULL(Specificities(ih).cont_fax_nbr_values_persisted),LEFT.cont_fax_nbr=RIGHT.cont_fax_nbr,add_cont_fax_nbr(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_phone_number_type_desc(layout_candidates le,Specificities(ih).cont_phone_number_type_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_phone_number_type_desc_weight100 := MAP (le.cont_phone_number_type_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_phone_number_type_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j155 := JOIN(j156,PULL(Specificities(ih).cont_phone_number_type_desc_values_persisted),LEFT.cont_phone_number_type_desc=RIGHT.cont_phone_number_type_desc,add_cont_phone_number_type_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_phone_number_type_cd(layout_candidates le,Specificities(ih).cont_phone_number_type_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_phone_number_type_cd_weight100 := MAP (le.cont_phone_number_type_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_phone_number_type_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j154 := JOIN(j155,PULL(Specificities(ih).cont_phone_number_type_cd_values_persisted),LEFT.cont_phone_number_type_cd=RIGHT.cont_phone_number_type_cd,add_cont_phone_number_type_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_phone_number(layout_candidates le,Specificities(ih).cont_phone_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_phone_number_weight100 := MAP (le.cont_phone_number_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_phone_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j153 := JOIN(j154,PULL(Specificities(ih).cont_phone_number_values_persisted),LEFT.cont_phone_number=RIGHT.cont_phone_number,add_cont_phone_number(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_address_county(layout_candidates le,Specificities(ih).cont_address_county_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_address_county_weight100 := MAP (le.cont_address_county_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_address_county_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j152 := JOIN(j153,PULL(Specificities(ih).cont_address_county_values_persisted),LEFT.cont_address_county=RIGHT.cont_address_county,add_cont_address_county(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_address_effective_date(layout_candidates le,Specificities(ih).cont_address_effective_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_address_effective_date_weight100 := MAP (le.cont_address_effective_date_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_address_effective_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j151 := JOIN(j152,PULL(Specificities(ih).cont_address_effective_date_values_persisted),LEFT.cont_address_effective_date=RIGHT.cont_address_effective_date,add_cont_address_effective_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_address_line3(layout_candidates le,Specificities(ih).cont_address_line3_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_address_line3_weight100 := MAP (le.cont_address_line3_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_address_line3_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j150 := JOIN(j151,PULL(Specificities(ih).cont_address_line3_values_persisted),LEFT.cont_address_line3=RIGHT.cont_address_line3,add_cont_address_line3(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_address_line2(layout_candidates le,Specificities(ih).cont_address_line2_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_address_line2_weight100 := MAP (le.cont_address_line2_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_address_line2_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j149 := JOIN(j150,PULL(Specificities(ih).cont_address_line2_values_persisted),LEFT.cont_address_line2=RIGHT.cont_address_line2,add_cont_address_line2(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_address_line1(layout_candidates le,Specificities(ih).cont_address_line1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_address_line1_weight100 := MAP (le.cont_address_line1_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_address_line1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j148 := JOIN(j149,PULL(Specificities(ih).cont_address_line1_values_persisted),LEFT.cont_address_line1=RIGHT.cont_address_line1,add_cont_address_line1(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_address_type_desc(layout_candidates le,Specificities(ih).cont_address_type_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_address_type_desc_weight100 := MAP (le.cont_address_type_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_address_type_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j147 := JOIN(j148,PULL(Specificities(ih).cont_address_type_desc_values_persisted),LEFT.cont_address_type_desc=RIGHT.cont_address_type_desc,add_cont_address_type_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_address_type_cd(layout_candidates le,Specificities(ih).cont_address_type_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_address_type_cd_weight100 := MAP (le.cont_address_type_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_address_type_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j146 := JOIN(j147,PULL(Specificities(ih).cont_address_type_cd_values_persisted),LEFT.cont_address_type_cd=RIGHT.cont_address_type_cd,add_cont_address_type_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_addl_info(layout_candidates le,Specificities(ih).cont_addl_info_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_addl_info_weight100 := MAP (le.cont_addl_info_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_addl_info_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j145 := JOIN(j146,PULL(Specificities(ih).cont_addl_info_values_persisted),LEFT.cont_addl_info=RIGHT.cont_addl_info,add_cont_addl_info(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_effective_desc(layout_candidates le,Specificities(ih).cont_effective_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_effective_desc_weight100 := MAP (le.cont_effective_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_effective_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j144 := JOIN(j145,PULL(Specificities(ih).cont_effective_desc_values_persisted),LEFT.cont_effective_desc=RIGHT.cont_effective_desc,add_cont_effective_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_effective_cd(layout_candidates le,Specificities(ih).cont_effective_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_effective_cd_weight100 := MAP (le.cont_effective_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_effective_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j143 := JOIN(j144,PULL(Specificities(ih).cont_effective_cd_values_persisted),LEFT.cont_effective_cd=RIGHT.cont_effective_cd,add_cont_effective_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_effective_date(layout_candidates le,Specificities(ih).cont_effective_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_effective_date_weight100 := MAP (le.cont_effective_date_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_effective_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j142 := JOIN(j143,PULL(Specificities(ih).cont_effective_date_values_persisted),LEFT.cont_effective_date=RIGHT.cont_effective_date,add_cont_effective_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_status_desc(layout_candidates le,Specificities(ih).cont_status_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_status_desc_weight100 := MAP (le.cont_status_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_status_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j141 := JOIN(j142,PULL(Specificities(ih).cont_status_desc_values_persisted),LEFT.cont_status_desc=RIGHT.cont_status_desc,add_cont_status_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_status_cd(layout_candidates le,Specificities(ih).cont_status_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_status_cd_weight100 := MAP (le.cont_status_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_status_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j140 := JOIN(j141,PULL(Specificities(ih).cont_status_cd_values_persisted),LEFT.cont_status_cd=RIGHT.cont_status_cd,add_cont_status_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_dob(layout_candidates le,Specificities(ih).cont_dob_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_dob_weight100 := MAP (le.cont_dob_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_dob_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j139 := JOIN(j140,PULL(Specificities(ih).cont_dob_values_persisted),LEFT.cont_dob=RIGHT.cont_dob,add_cont_dob(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_ssn(layout_candidates le,Specificities(ih).cont_ssn_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_ssn_weight100 := MAP (le.cont_ssn_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_ssn_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j138 := JOIN(j139,PULL(Specificities(ih).cont_ssn_values_persisted),LEFT.cont_ssn=RIGHT.cont_ssn,add_cont_ssn(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_fein(layout_candidates le,Specificities(ih).cont_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_fein_weight100 := MAP (le.cont_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_fein_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j137 := JOIN(j138,PULL(Specificities(ih).cont_fein_values_persisted),LEFT.cont_fein=RIGHT.cont_fein,add_cont_fein(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_title5_desc(layout_candidates le,Specificities(ih).cont_title5_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_title5_desc_weight100 := MAP (le.cont_title5_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_title5_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j136 := JOIN(j137,PULL(Specificities(ih).cont_title5_desc_values_persisted),LEFT.cont_title5_desc=RIGHT.cont_title5_desc,add_cont_title5_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_title4_desc(layout_candidates le,Specificities(ih).cont_title4_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_title4_desc_weight100 := MAP (le.cont_title4_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_title4_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j135 := JOIN(j136,PULL(Specificities(ih).cont_title4_desc_values_persisted),LEFT.cont_title4_desc=RIGHT.cont_title4_desc,add_cont_title4_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_title3_desc(layout_candidates le,Specificities(ih).cont_title3_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_title3_desc_weight100 := MAP (le.cont_title3_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_title3_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j134 := JOIN(j135,PULL(Specificities(ih).cont_title3_desc_values_persisted),LEFT.cont_title3_desc=RIGHT.cont_title3_desc,add_cont_title3_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_title2_desc(layout_candidates le,Specificities(ih).cont_title2_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_title2_desc_weight100 := MAP (le.cont_title2_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_title2_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j133 := JOIN(j134,PULL(Specificities(ih).cont_title2_desc_values_persisted),LEFT.cont_title2_desc=RIGHT.cont_title2_desc,add_cont_title2_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_title1_desc(layout_candidates le,Specificities(ih).cont_title1_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_title1_desc_weight100 := MAP (le.cont_title1_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_title1_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j132 := JOIN(j133,PULL(Specificities(ih).cont_title1_desc_values_persisted),LEFT.cont_title1_desc=RIGHT.cont_title1_desc,add_cont_title1_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_suffix(layout_candidates le,Specificities(ih).cont_suffix_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_suffix_weight100 := MAP (le.cont_suffix_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_suffix_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j131 := JOIN(j132,PULL(Specificities(ih).cont_suffix_values_persisted),LEFT.cont_suffix=RIGHT.cont_suffix,add_cont_suffix(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_lname(layout_candidates le,Specificities(ih).cont_lname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_lname_weight100 := MAP (le.cont_lname_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_lname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j130 := JOIN(j131,PULL(Specificities(ih).cont_lname_values_persisted),LEFT.cont_lname=RIGHT.cont_lname,add_cont_lname(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_mname(layout_candidates le,Specificities(ih).cont_mname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_mname_weight100 := MAP (le.cont_mname_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_mname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j129 := JOIN(j130,PULL(Specificities(ih).cont_mname_values_persisted),LEFT.cont_mname=RIGHT.cont_mname,add_cont_mname(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_fname(layout_candidates le,Specificities(ih).cont_fname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_fname_weight100 := MAP (le.cont_fname_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_fname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j128 := JOIN(j129,PULL(Specificities(ih).cont_fname_values_persisted),LEFT.cont_fname=RIGHT.cont_fname,add_cont_fname(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_full_name(layout_candidates le,Specificities(ih).cont_full_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_full_name_weight100 := MAP (le.cont_full_name_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_full_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j127 := JOIN(j128,PULL(Specificities(ih).cont_full_name_values_persisted),LEFT.cont_full_name=RIGHT.cont_full_name,add_cont_full_name(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_type_desc(layout_candidates le,Specificities(ih).cont_type_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_type_desc_weight100 := MAP (le.cont_type_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_type_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j126 := JOIN(j127,PULL(Specificities(ih).cont_type_desc_values_persisted),LEFT.cont_type_desc=RIGHT.cont_type_desc,add_cont_type_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_type_cd(layout_candidates le,Specificities(ih).cont_type_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_type_cd_weight100 := MAP (le.cont_type_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_type_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j125 := JOIN(j126,PULL(Specificities(ih).cont_type_cd_values_persisted),LEFT.cont_type_cd=RIGHT.cont_type_cd,add_cont_type_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_filing_desc(layout_candidates le,Specificities(ih).cont_filing_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_filing_desc_weight100 := MAP (le.cont_filing_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_filing_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j124 := JOIN(j125,PULL(Specificities(ih).cont_filing_desc_values_persisted),LEFT.cont_filing_desc=RIGHT.cont_filing_desc,add_cont_filing_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_filing_cd(layout_candidates le,Specificities(ih).cont_filing_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_filing_cd_weight100 := MAP (le.cont_filing_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_filing_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j123 := JOIN(j124,PULL(Specificities(ih).cont_filing_cd_values_persisted),LEFT.cont_filing_cd=RIGHT.cont_filing_cd,add_cont_filing_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_filing_date(layout_candidates le,Specificities(ih).cont_filing_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_filing_date_weight100 := MAP (le.cont_filing_date_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_filing_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j122 := JOIN(j123,PULL(Specificities(ih).cont_filing_date_values_persisted),LEFT.cont_filing_date=RIGHT.cont_filing_date,add_cont_filing_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cont_filing_reference_nbr(layout_candidates le,Specificities(ih).cont_filing_reference_nbr_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cont_filing_reference_nbr_weight100 := MAP (le.cont_filing_reference_nbr_isnull => 0, patch_default and ri.field_specificity=0 => s.cont_filing_reference_nbr_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j121 := JOIN(j122,PULL(Specificities(ih).cont_filing_reference_nbr_values_persisted),LEFT.cont_filing_reference_nbr=RIGHT.cont_filing_reference_nbr,add_cont_filing_reference_nbr(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_ra_prep_addr_last_line(layout_candidates le,Specificities(ih).ra_prep_addr_last_line_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ra_prep_addr_last_line_weight100 := MAP (le.ra_prep_addr_last_line_isnull => 0, patch_default and ri.field_specificity=0 => s.ra_prep_addr_last_line_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j120 := JOIN(j121,PULL(Specificities(ih).ra_prep_addr_last_line_values_persisted),LEFT.ra_prep_addr_last_line=RIGHT.ra_prep_addr_last_line,add_ra_prep_addr_last_line(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_ra_prep_addr_line1(layout_candidates le,Specificities(ih).ra_prep_addr_line1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ra_prep_addr_line1_weight100 := MAP (le.ra_prep_addr_line1_isnull => 0, patch_default and ri.field_specificity=0 => s.ra_prep_addr_line1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j119 := JOIN(j120,PULL(Specificities(ih).ra_prep_addr_line1_values_persisted),LEFT.ra_prep_addr_line1=RIGHT.ra_prep_addr_line1,add_ra_prep_addr_line1(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_prep_addr2_last_line(layout_candidates le,Specificities(ih).corp_prep_addr2_last_line_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_prep_addr2_last_line_weight100 := MAP (le.corp_prep_addr2_last_line_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_prep_addr2_last_line_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j118 := JOIN(j119,PULL(Specificities(ih).corp_prep_addr2_last_line_values_persisted),LEFT.corp_prep_addr2_last_line=RIGHT.corp_prep_addr2_last_line,add_corp_prep_addr2_last_line(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_prep_addr2_line1(layout_candidates le,Specificities(ih).corp_prep_addr2_line1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_prep_addr2_line1_weight100 := MAP (le.corp_prep_addr2_line1_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_prep_addr2_line1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j117 := JOIN(j118,PULL(Specificities(ih).corp_prep_addr2_line1_values_persisted),LEFT.corp_prep_addr2_line1=RIGHT.corp_prep_addr2_line1,add_corp_prep_addr2_line1(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_prep_addr1_last_line(layout_candidates le,Specificities(ih).corp_prep_addr1_last_line_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_prep_addr1_last_line_weight100 := MAP (le.corp_prep_addr1_last_line_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_prep_addr1_last_line_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j116 := JOIN(j117,PULL(Specificities(ih).corp_prep_addr1_last_line_values_persisted),LEFT.corp_prep_addr1_last_line=RIGHT.corp_prep_addr1_last_line,add_corp_prep_addr1_last_line(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_prep_addr1_line1(layout_candidates le,Specificities(ih).corp_prep_addr1_line1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_prep_addr1_line1_weight100 := MAP (le.corp_prep_addr1_line1_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_prep_addr1_line1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j115 := JOIN(j116,PULL(Specificities(ih).corp_prep_addr1_line1_values_persisted),LEFT.corp_prep_addr1_line1=RIGHT.corp_prep_addr1_line1,add_corp_prep_addr1_line1(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_web_address(layout_candidates le,Specificities(ih).corp_ra_web_address_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_web_address_weight100 := MAP (le.corp_ra_web_address_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_web_address_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j114 := JOIN(j115,PULL(Specificities(ih).corp_ra_web_address_values_persisted),LEFT.corp_ra_web_address=RIGHT.corp_ra_web_address,add_corp_ra_web_address(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_email_address(layout_candidates le,Specificities(ih).corp_ra_email_address_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_email_address_weight100 := MAP (le.corp_ra_email_address_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_email_address_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j113 := JOIN(j114,PULL(Specificities(ih).corp_ra_email_address_values_persisted),LEFT.corp_ra_email_address=RIGHT.corp_ra_email_address,add_corp_ra_email_address(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_fax_nbr(layout_candidates le,Specificities(ih).corp_ra_fax_nbr_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_fax_nbr_weight100 := MAP (le.corp_ra_fax_nbr_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_fax_nbr_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j112 := JOIN(j113,PULL(Specificities(ih).corp_ra_fax_nbr_values_persisted),LEFT.corp_ra_fax_nbr=RIGHT.corp_ra_fax_nbr,add_corp_ra_fax_nbr(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_phone_number_type_desc(layout_candidates le,Specificities(ih).corp_ra_phone_number_type_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_phone_number_type_desc_weight100 := MAP (le.corp_ra_phone_number_type_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_phone_number_type_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j111 := JOIN(j112,PULL(Specificities(ih).corp_ra_phone_number_type_desc_values_persisted),LEFT.corp_ra_phone_number_type_desc=RIGHT.corp_ra_phone_number_type_desc,add_corp_ra_phone_number_type_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_phone_number_type_cd(layout_candidates le,Specificities(ih).corp_ra_phone_number_type_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_phone_number_type_cd_weight100 := MAP (le.corp_ra_phone_number_type_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_phone_number_type_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j110 := JOIN(j111,PULL(Specificities(ih).corp_ra_phone_number_type_cd_values_persisted),LEFT.corp_ra_phone_number_type_cd=RIGHT.corp_ra_phone_number_type_cd,add_corp_ra_phone_number_type_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_phone_number(layout_candidates le,Specificities(ih).corp_ra_phone_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_phone_number_weight100 := MAP (le.corp_ra_phone_number_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_phone_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j109 := JOIN(j110,PULL(Specificities(ih).corp_ra_phone_number_values_persisted),LEFT.corp_ra_phone_number=RIGHT.corp_ra_phone_number,add_corp_ra_phone_number(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_address_line3(layout_candidates le,Specificities(ih).corp_ra_address_line3_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_address_line3_weight100 := MAP (le.corp_ra_address_line3_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_address_line3_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j108 := JOIN(j109,PULL(Specificities(ih).corp_ra_address_line3_values_persisted),LEFT.corp_ra_address_line3=RIGHT.corp_ra_address_line3,add_corp_ra_address_line3(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_address_line2(layout_candidates le,Specificities(ih).corp_ra_address_line2_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_address_line2_weight100 := MAP (le.corp_ra_address_line2_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_address_line2_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j107 := JOIN(j108,PULL(Specificities(ih).corp_ra_address_line2_values_persisted),LEFT.corp_ra_address_line2=RIGHT.corp_ra_address_line2,add_corp_ra_address_line2(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_address_line1(layout_candidates le,Specificities(ih).corp_ra_address_line1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_address_line1_weight100 := MAP (le.corp_ra_address_line1_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_address_line1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j106 := JOIN(j107,PULL(Specificities(ih).corp_ra_address_line1_values_persisted),LEFT.corp_ra_address_line1=RIGHT.corp_ra_address_line1,add_corp_ra_address_line1(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_address_type_desc(layout_candidates le,Specificities(ih).corp_ra_address_type_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_address_type_desc_weight100 := MAP (le.corp_ra_address_type_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_address_type_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j105 := JOIN(j106,PULL(Specificities(ih).corp_ra_address_type_desc_values_persisted),LEFT.corp_ra_address_type_desc=RIGHT.corp_ra_address_type_desc,add_corp_ra_address_type_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_address_type_cd(layout_candidates le,Specificities(ih).corp_ra_address_type_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_address_type_cd_weight100 := MAP (le.corp_ra_address_type_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_address_type_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j104 := JOIN(j105,PULL(Specificities(ih).corp_ra_address_type_cd_values_persisted),LEFT.corp_ra_address_type_cd=RIGHT.corp_ra_address_type_cd,add_corp_ra_address_type_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_addl_info(layout_candidates le,Specificities(ih).corp_ra_addl_info_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_addl_info_weight100 := MAP (le.corp_ra_addl_info_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_addl_info_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j103 := JOIN(j104,PULL(Specificities(ih).corp_ra_addl_info_values_persisted),LEFT.corp_ra_addl_info=RIGHT.corp_ra_addl_info,add_corp_ra_addl_info(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_no_comp_igs(layout_candidates le,Specificities(ih).corp_ra_no_comp_igs_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_no_comp_igs_weight100 := MAP (le.corp_ra_no_comp_igs_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_no_comp_igs_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j102 := JOIN(j103,PULL(Specificities(ih).corp_ra_no_comp_igs_values_persisted),LEFT.corp_ra_no_comp_igs=RIGHT.corp_ra_no_comp_igs,add_corp_ra_no_comp_igs(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_no_comp(layout_candidates le,Specificities(ih).corp_ra_no_comp_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_no_comp_weight100 := MAP (le.corp_ra_no_comp_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_no_comp_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j101 := JOIN(j102,PULL(Specificities(ih).corp_ra_no_comp_values_persisted),LEFT.corp_ra_no_comp=RIGHT.corp_ra_no_comp,add_corp_ra_no_comp(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_resign_date(layout_candidates le,Specificities(ih).corp_ra_resign_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_resign_date_weight100 := MAP (le.corp_ra_resign_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_resign_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j100 := JOIN(j101,PULL(Specificities(ih).corp_ra_resign_date_values_persisted),LEFT.corp_ra_resign_date=RIGHT.corp_ra_resign_date,add_corp_ra_resign_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_effective_date(layout_candidates le,Specificities(ih).corp_ra_effective_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_effective_date_weight100 := MAP (le.corp_ra_effective_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_effective_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j99 := JOIN(j100,PULL(Specificities(ih).corp_ra_effective_date_values_persisted),LEFT.corp_ra_effective_date=RIGHT.corp_ra_effective_date,add_corp_ra_effective_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_dob(layout_candidates le,Specificities(ih).corp_ra_dob_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_dob_weight100 := MAP (le.corp_ra_dob_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_dob_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j98 := JOIN(j99,PULL(Specificities(ih).corp_ra_dob_values_persisted),LEFT.corp_ra_dob=RIGHT.corp_ra_dob,add_corp_ra_dob(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_ssn(layout_candidates le,Specificities(ih).corp_ra_ssn_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_ssn_weight100 := MAP (le.corp_ra_ssn_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_ssn_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j97 := JOIN(j98,PULL(Specificities(ih).corp_ra_ssn_values_persisted),LEFT.corp_ra_ssn=RIGHT.corp_ra_ssn,add_corp_ra_ssn(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_fein(layout_candidates le,Specificities(ih).corp_ra_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_fein_weight100 := MAP (le.corp_ra_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_fein_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j96 := JOIN(j97,PULL(Specificities(ih).corp_ra_fein_values_persisted),LEFT.corp_ra_fein=RIGHT.corp_ra_fein,add_corp_ra_fein(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_title_desc(layout_candidates le,Specificities(ih).corp_ra_title_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_title_desc_weight100 := MAP (le.corp_ra_title_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_title_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j95 := JOIN(j96,PULL(Specificities(ih).corp_ra_title_desc_values_persisted),LEFT.corp_ra_title_desc=RIGHT.corp_ra_title_desc,add_corp_ra_title_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_title_cd(layout_candidates le,Specificities(ih).corp_ra_title_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_title_cd_weight100 := MAP (le.corp_ra_title_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_title_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j94 := JOIN(j95,PULL(Specificities(ih).corp_ra_title_cd_values_persisted),LEFT.corp_ra_title_cd=RIGHT.corp_ra_title_cd,add_corp_ra_title_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_suffix(layout_candidates le,Specificities(ih).corp_ra_suffix_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_suffix_weight100 := MAP (le.corp_ra_suffix_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_suffix_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j93 := JOIN(j94,PULL(Specificities(ih).corp_ra_suffix_values_persisted),LEFT.corp_ra_suffix=RIGHT.corp_ra_suffix,add_corp_ra_suffix(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_lname(layout_candidates le,Specificities(ih).corp_ra_lname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_lname_weight100 := MAP (le.corp_ra_lname_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_lname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j92 := JOIN(j93,PULL(Specificities(ih).corp_ra_lname_values_persisted),LEFT.corp_ra_lname=RIGHT.corp_ra_lname,add_corp_ra_lname(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_mname(layout_candidates le,Specificities(ih).corp_ra_mname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_mname_weight100 := MAP (le.corp_ra_mname_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_mname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j91 := JOIN(j92,PULL(Specificities(ih).corp_ra_mname_values_persisted),LEFT.corp_ra_mname=RIGHT.corp_ra_mname,add_corp_ra_mname(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_fname(layout_candidates le,Specificities(ih).corp_ra_fname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_fname_weight100 := MAP (le.corp_ra_fname_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_fname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j90 := JOIN(j91,PULL(Specificities(ih).corp_ra_fname_values_persisted),LEFT.corp_ra_fname=RIGHT.corp_ra_fname,add_corp_ra_fname(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_full_name(layout_candidates le,Specificities(ih).corp_ra_full_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_full_name_weight100 := MAP (le.corp_ra_full_name_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_full_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j89 := JOIN(j90,PULL(Specificities(ih).corp_ra_full_name_values_persisted),LEFT.corp_ra_full_name=RIGHT.corp_ra_full_name,add_corp_ra_full_name(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_tax_program_desc(layout_candidates le,Specificities(ih).corp_tax_program_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_tax_program_desc_weight100 := MAP (le.corp_tax_program_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_tax_program_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j88 := JOIN(j89,PULL(Specificities(ih).corp_tax_program_desc_values_persisted),LEFT.corp_tax_program_desc=RIGHT.corp_tax_program_desc,add_corp_tax_program_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_tax_program_cd(layout_candidates le,Specificities(ih).corp_tax_program_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_tax_program_cd_weight100 := MAP (le.corp_tax_program_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_tax_program_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j87 := JOIN(j88,PULL(Specificities(ih).corp_tax_program_cd_values_persisted),LEFT.corp_tax_program_cd=RIGHT.corp_tax_program_cd,add_corp_tax_program_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_franchise_taxes(layout_candidates le,Specificities(ih).corp_franchise_taxes_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_franchise_taxes_weight100 := MAP (le.corp_franchise_taxes_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_franchise_taxes_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j86 := JOIN(j87,PULL(Specificities(ih).corp_franchise_taxes_values_persisted),LEFT.corp_franchise_taxes=RIGHT.corp_franchise_taxes,add_corp_franchise_taxes(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_taxes(layout_candidates le,Specificities(ih).corp_taxes_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_taxes_weight100 := MAP (le.corp_taxes_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_taxes_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j85 := JOIN(j86,PULL(Specificities(ih).corp_taxes_values_persisted),LEFT.corp_taxes=RIGHT.corp_taxes,add_corp_taxes(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_addl_info(layout_candidates le,Specificities(ih).corp_addl_info_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_addl_info_weight100 := MAP (le.corp_addl_info_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_addl_info_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j84 := JOIN(j85,PULL(Specificities(ih).corp_addl_info_values_persisted),LEFT.corp_addl_info=RIGHT.corp_addl_info,add_corp_addl_info(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_mfg_ind(layout_candidates le,Specificities(ih).corp_mfg_ind_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_mfg_ind_weight100 := MAP (le.corp_mfg_ind_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_mfg_ind_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j83 := JOIN(j84,PULL(Specificities(ih).corp_mfg_ind_values_persisted),LEFT.corp_mfg_ind=RIGHT.corp_mfg_ind,add_corp_mfg_ind(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_partnership_ind(layout_candidates le,Specificities(ih).corp_partnership_ind_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_partnership_ind_weight100 := MAP (le.corp_partnership_ind_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_partnership_ind_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j82 := JOIN(j83,PULL(Specificities(ih).corp_partnership_ind_values_persisted),LEFT.corp_partnership_ind=RIGHT.corp_partnership_ind,add_corp_partnership_ind(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_acts(layout_candidates le,Specificities(ih).corp_acts_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_acts_weight100 := MAP (le.corp_acts_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_acts_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j81 := JOIN(j82,PULL(Specificities(ih).corp_acts_values_persisted),LEFT.corp_acts=RIGHT.corp_acts,add_corp_acts(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_amendments_filed(layout_candidates le,Specificities(ih).corp_amendments_filed_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_amendments_filed_weight100 := MAP (le.corp_amendments_filed_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_amendments_filed_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j80 := JOIN(j81,PULL(Specificities(ih).corp_amendments_filed_values_persisted),LEFT.corp_amendments_filed=RIGHT.corp_amendments_filed,add_corp_amendments_filed(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_microfilm_nbr(layout_candidates le,Specificities(ih).corp_microfilm_nbr_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_microfilm_nbr_weight100 := MAP (le.corp_microfilm_nbr_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_microfilm_nbr_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j79 := JOIN(j80,PULL(Specificities(ih).corp_microfilm_nbr_values_persisted),LEFT.corp_microfilm_nbr=RIGHT.corp_microfilm_nbr,add_corp_microfilm_nbr(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_previous_nbr(layout_candidates le,Specificities(ih).corp_previous_nbr_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_previous_nbr_weight100 := MAP (le.corp_previous_nbr_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_previous_nbr_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j78 := JOIN(j79,PULL(Specificities(ih).corp_previous_nbr_values_persisted),LEFT.corp_previous_nbr=RIGHT.corp_previous_nbr,add_corp_previous_nbr(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_internal_nbr(layout_candidates le,Specificities(ih).corp_internal_nbr_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_internal_nbr_weight100 := MAP (le.corp_internal_nbr_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_internal_nbr_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j77 := JOIN(j78,PULL(Specificities(ih).corp_internal_nbr_values_persisted),LEFT.corp_internal_nbr=RIGHT.corp_internal_nbr,add_corp_internal_nbr(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_certificate_nbr(layout_candidates le,Specificities(ih).corp_certificate_nbr_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_certificate_nbr_weight100 := MAP (le.corp_certificate_nbr_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_certificate_nbr_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j76 := JOIN(j77,PULL(Specificities(ih).corp_certificate_nbr_values_persisted),LEFT.corp_certificate_nbr=RIGHT.corp_certificate_nbr,add_corp_certificate_nbr(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_entity_desc(layout_candidates le,Specificities(ih).corp_entity_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_entity_desc_weight100 := MAP (le.corp_entity_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_entity_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j75 := JOIN(j76,PULL(Specificities(ih).corp_entity_desc_values_persisted),LEFT.corp_entity_desc=RIGHT.corp_entity_desc,add_corp_entity_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_orig_bus_type_desc(layout_candidates le,Specificities(ih).corp_orig_bus_type_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_orig_bus_type_desc_weight100 := MAP (le.corp_orig_bus_type_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_orig_bus_type_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j74 := JOIN(j75,PULL(Specificities(ih).corp_orig_bus_type_desc_values_persisted),LEFT.corp_orig_bus_type_desc=RIGHT.corp_orig_bus_type_desc,add_corp_orig_bus_type_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_orig_bus_type_cd(layout_candidates le,Specificities(ih).corp_orig_bus_type_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_orig_bus_type_cd_weight100 := MAP (le.corp_orig_bus_type_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_orig_bus_type_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j73 := JOIN(j74,PULL(Specificities(ih).corp_orig_bus_type_cd_values_persisted),LEFT.corp_orig_bus_type_cd=RIGHT.corp_orig_bus_type_cd,add_corp_orig_bus_type_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_naic_code(layout_candidates le,Specificities(ih).corp_naic_code_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_naic_code_weight100 := MAP (le.corp_naic_code_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_naic_code_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j72 := JOIN(j73,PULL(Specificities(ih).corp_naic_code_values_persisted),LEFT.corp_naic_code=RIGHT.corp_naic_code,add_corp_naic_code(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_sic_code(layout_candidates le,Specificities(ih).corp_sic_code_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_sic_code_weight100 := MAP (le.corp_sic_code_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_sic_code_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j71 := JOIN(j72,PULL(Specificities(ih).corp_sic_code_values_persisted),LEFT.corp_sic_code=RIGHT.corp_sic_code,add_corp_sic_code(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_public_or_private_ind(layout_candidates le,Specificities(ih).corp_public_or_private_ind_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_public_or_private_ind_weight100 := MAP (le.corp_public_or_private_ind_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_public_or_private_ind_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j70 := JOIN(j71,PULL(Specificities(ih).corp_public_or_private_ind_values_persisted),LEFT.corp_public_or_private_ind=RIGHT.corp_public_or_private_ind,add_corp_public_or_private_ind(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_for_profit_ind(layout_candidates le,Specificities(ih).corp_for_profit_ind_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_for_profit_ind_weight100 := MAP (le.corp_for_profit_ind_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_for_profit_ind_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j69 := JOIN(j70,PULL(Specificities(ih).corp_for_profit_ind_values_persisted),LEFT.corp_for_profit_ind=RIGHT.corp_for_profit_ind,add_corp_for_profit_ind(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_orig_org_structure_desc(layout_candidates le,Specificities(ih).corp_orig_org_structure_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_orig_org_structure_desc_weight100 := MAP (le.corp_orig_org_structure_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_orig_org_structure_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j68 := JOIN(j69,PULL(Specificities(ih).corp_orig_org_structure_desc_values_persisted),LEFT.corp_orig_org_structure_desc=RIGHT.corp_orig_org_structure_desc,add_corp_orig_org_structure_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_orig_org_structure_cd(layout_candidates le,Specificities(ih).corp_orig_org_structure_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_orig_org_structure_cd_weight100 := MAP (le.corp_orig_org_structure_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_orig_org_structure_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j67 := JOIN(j68,PULL(Specificities(ih).corp_orig_org_structure_cd_values_persisted),LEFT.corp_orig_org_structure_cd=RIGHT.corp_orig_org_structure_cd,add_corp_orig_org_structure_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_forgn_term_exist_desc(layout_candidates le,Specificities(ih).corp_forgn_term_exist_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_forgn_term_exist_desc_weight100 := MAP (le.corp_forgn_term_exist_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_forgn_term_exist_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j66 := JOIN(j67,PULL(Specificities(ih).corp_forgn_term_exist_desc_values_persisted),LEFT.corp_forgn_term_exist_desc=RIGHT.corp_forgn_term_exist_desc,add_corp_forgn_term_exist_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_forgn_term_exist_exp(layout_candidates le,Specificities(ih).corp_forgn_term_exist_exp_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_forgn_term_exist_exp_weight100 := MAP (le.corp_forgn_term_exist_exp_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_forgn_term_exist_exp_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j65 := JOIN(j66,PULL(Specificities(ih).corp_forgn_term_exist_exp_values_persisted),LEFT.corp_forgn_term_exist_exp=RIGHT.corp_forgn_term_exist_exp,add_corp_forgn_term_exist_exp(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_forgn_term_exist_cd(layout_candidates le,Specificities(ih).corp_forgn_term_exist_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_forgn_term_exist_cd_weight100 := MAP (le.corp_forgn_term_exist_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_forgn_term_exist_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j64 := JOIN(j65,PULL(Specificities(ih).corp_forgn_term_exist_cd_values_persisted),LEFT.corp_forgn_term_exist_cd=RIGHT.corp_forgn_term_exist_cd,add_corp_forgn_term_exist_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_forgn_state_tax_id(layout_candidates le,Specificities(ih).corp_forgn_state_tax_id_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_forgn_state_tax_id_weight100 := MAP (le.corp_forgn_state_tax_id_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_forgn_state_tax_id_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j63 := JOIN(j64,PULL(Specificities(ih).corp_forgn_state_tax_id_values_persisted),LEFT.corp_forgn_state_tax_id=RIGHT.corp_forgn_state_tax_id,add_corp_forgn_state_tax_id(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_forgn_fed_tax_id(layout_candidates le,Specificities(ih).corp_forgn_fed_tax_id_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_forgn_fed_tax_id_weight100 := MAP (le.corp_forgn_fed_tax_id_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_forgn_fed_tax_id_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j62 := JOIN(j63,PULL(Specificities(ih).corp_forgn_fed_tax_id_values_persisted),LEFT.corp_forgn_fed_tax_id=RIGHT.corp_forgn_fed_tax_id,add_corp_forgn_fed_tax_id(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_forgn_date(layout_candidates le,Specificities(ih).corp_forgn_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_forgn_date_weight100 := MAP (le.corp_forgn_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_forgn_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j61 := JOIN(j62,PULL(Specificities(ih).corp_forgn_date_values_persisted),LEFT.corp_forgn_date=RIGHT.corp_forgn_date,add_corp_forgn_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_forgn_sos_charter_nbr(layout_candidates le,Specificities(ih).corp_forgn_sos_charter_nbr_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_forgn_sos_charter_nbr_weight100 := MAP (le.corp_forgn_sos_charter_nbr_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_forgn_sos_charter_nbr_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j60 := JOIN(j61,PULL(Specificities(ih).corp_forgn_sos_charter_nbr_values_persisted),LEFT.corp_forgn_sos_charter_nbr=RIGHT.corp_forgn_sos_charter_nbr,add_corp_forgn_sos_charter_nbr(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_forgn_state_desc(layout_candidates le,Specificities(ih).corp_forgn_state_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_forgn_state_desc_weight100 := MAP (le.corp_forgn_state_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_forgn_state_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j59 := JOIN(j60,PULL(Specificities(ih).corp_forgn_state_desc_values_persisted),LEFT.corp_forgn_state_desc=RIGHT.corp_forgn_state_desc,add_corp_forgn_state_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_forgn_state_cd(layout_candidates le,Specificities(ih).corp_forgn_state_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_forgn_state_cd_weight100 := MAP (le.corp_forgn_state_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_forgn_state_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j58 := JOIN(j59,PULL(Specificities(ih).corp_forgn_state_cd_values_persisted),LEFT.corp_forgn_state_cd=RIGHT.corp_forgn_state_cd,add_corp_forgn_state_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_foreign_domestic_ind(layout_candidates le,Specificities(ih).corp_foreign_domestic_ind_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_foreign_domestic_ind_weight100 := MAP (le.corp_foreign_domestic_ind_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_foreign_domestic_ind_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j57 := JOIN(j58,PULL(Specificities(ih).corp_foreign_domestic_ind_values_persisted),LEFT.corp_foreign_domestic_ind=RIGHT.corp_foreign_domestic_ind,add_corp_foreign_domestic_ind(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_term_exist_desc(layout_candidates le,Specificities(ih).corp_term_exist_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_term_exist_desc_weight100 := MAP (le.corp_term_exist_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_term_exist_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j56 := JOIN(j57,PULL(Specificities(ih).corp_term_exist_desc_values_persisted),LEFT.corp_term_exist_desc=RIGHT.corp_term_exist_desc,add_corp_term_exist_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_term_exist_exp(layout_candidates le,Specificities(ih).corp_term_exist_exp_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_term_exist_exp_weight100 := MAP (le.corp_term_exist_exp_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_term_exist_exp_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j55 := JOIN(j56,PULL(Specificities(ih).corp_term_exist_exp_values_persisted),LEFT.corp_term_exist_exp=RIGHT.corp_term_exist_exp,add_corp_term_exist_exp(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_term_exist_cd(layout_candidates le,Specificities(ih).corp_term_exist_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_term_exist_cd_weight100 := MAP (le.corp_term_exist_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_term_exist_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j54 := JOIN(j55,PULL(Specificities(ih).corp_term_exist_cd_values_persisted),LEFT.corp_term_exist_cd=RIGHT.corp_term_exist_cd,add_corp_term_exist_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_state_tax_id(layout_candidates le,Specificities(ih).corp_state_tax_id_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_state_tax_id_weight100 := MAP (le.corp_state_tax_id_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_state_tax_id_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j53 := JOIN(j54,PULL(Specificities(ih).corp_state_tax_id_values_persisted),LEFT.corp_state_tax_id=RIGHT.corp_state_tax_id,add_corp_state_tax_id(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_fed_tax_id(layout_candidates le,Specificities(ih).corp_fed_tax_id_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_fed_tax_id_weight100 := MAP (le.corp_fed_tax_id_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_fed_tax_id_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j52 := JOIN(j53,PULL(Specificities(ih).corp_fed_tax_id_values_persisted),LEFT.corp_fed_tax_id=RIGHT.corp_fed_tax_id,add_corp_fed_tax_id(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_anniversary_month(layout_candidates le,Specificities(ih).corp_anniversary_month_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_anniversary_month_weight100 := MAP (le.corp_anniversary_month_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_anniversary_month_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j51 := JOIN(j52,PULL(Specificities(ih).corp_anniversary_month_values_persisted),LEFT.corp_anniversary_month=RIGHT.corp_anniversary_month,add_corp_anniversary_month(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_inc_date(layout_candidates le,Specificities(ih).corp_inc_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_inc_date_weight100 := MAP (le.corp_inc_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_inc_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j50 := JOIN(j51,PULL(Specificities(ih).corp_inc_date_values_persisted),LEFT.corp_inc_date=RIGHT.corp_inc_date,add_corp_inc_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_inc_county(layout_candidates le,Specificities(ih).corp_inc_county_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_inc_county_weight100 := MAP (le.corp_inc_county_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_inc_county_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j49 := JOIN(j50,PULL(Specificities(ih).corp_inc_county_values_persisted),LEFT.corp_inc_county=RIGHT.corp_inc_county,add_corp_inc_county(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_inc_state(layout_candidates le,Specificities(ih).corp_inc_state_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_inc_state_weight100 := MAP (le.corp_inc_state_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_inc_state_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j48 := JOIN(j49,PULL(Specificities(ih).corp_inc_state_values_persisted),LEFT.corp_inc_state=RIGHT.corp_inc_state,add_corp_inc_state(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_stock_exchange(layout_candidates le,Specificities(ih).corp_stock_exchange_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_stock_exchange_weight100 := MAP (le.corp_stock_exchange_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_stock_exchange_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j47 := JOIN(j48,PULL(Specificities(ih).corp_stock_exchange_values_persisted),LEFT.corp_stock_exchange=RIGHT.corp_stock_exchange,add_corp_stock_exchange(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ticker_symbol(layout_candidates le,Specificities(ih).corp_ticker_symbol_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ticker_symbol_weight100 := MAP (le.corp_ticker_symbol_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ticker_symbol_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j46 := JOIN(j47,PULL(Specificities(ih).corp_ticker_symbol_values_persisted),LEFT.corp_ticker_symbol=RIGHT.corp_ticker_symbol,add_corp_ticker_symbol(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_status_comment(layout_candidates le,Specificities(ih).corp_status_comment_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_status_comment_weight100 := MAP (le.corp_status_comment_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_status_comment_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j45 := JOIN(j46,PULL(Specificities(ih).corp_status_comment_values_persisted),LEFT.corp_status_comment=RIGHT.corp_status_comment,add_corp_status_comment(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_standing(layout_candidates le,Specificities(ih).corp_standing_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_standing_weight100 := MAP (le.corp_standing_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_standing_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j44 := JOIN(j45,PULL(Specificities(ih).corp_standing_values_persisted),LEFT.corp_standing=RIGHT.corp_standing,add_corp_standing(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_status_date(layout_candidates le,Specificities(ih).corp_status_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_status_date_weight100 := MAP (le.corp_status_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_status_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j43 := JOIN(j44,PULL(Specificities(ih).corp_status_date_values_persisted),LEFT.corp_status_date=RIGHT.corp_status_date,add_corp_status_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_status_desc(layout_candidates le,Specificities(ih).corp_status_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_status_desc_weight100 := MAP (le.corp_status_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_status_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j42 := JOIN(j43,PULL(Specificities(ih).corp_status_desc_values_persisted),LEFT.corp_status_desc=RIGHT.corp_status_desc,add_corp_status_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_status_cd(layout_candidates le,Specificities(ih).corp_status_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_status_cd_weight100 := MAP (le.corp_status_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_status_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j41 := JOIN(j42,PULL(Specificities(ih).corp_status_cd_values_persisted),LEFT.corp_status_cd=RIGHT.corp_status_cd,add_corp_status_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_filing_desc(layout_candidates le,Specificities(ih).corp_filing_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_filing_desc_weight100 := MAP (le.corp_filing_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_filing_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j40 := JOIN(j41,PULL(Specificities(ih).corp_filing_desc_values_persisted),LEFT.corp_filing_desc=RIGHT.corp_filing_desc,add_corp_filing_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_filing_cd(layout_candidates le,Specificities(ih).corp_filing_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_filing_cd_weight100 := MAP (le.corp_filing_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_filing_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j39 := JOIN(j40,PULL(Specificities(ih).corp_filing_cd_values_persisted),LEFT.corp_filing_cd=RIGHT.corp_filing_cd,add_corp_filing_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_filing_date(layout_candidates le,Specificities(ih).corp_filing_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_filing_date_weight100 := MAP (le.corp_filing_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_filing_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j38 := JOIN(j39,PULL(Specificities(ih).corp_filing_date_values_persisted),LEFT.corp_filing_date=RIGHT.corp_filing_date,add_corp_filing_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_filing_reference_nbr(layout_candidates le,Specificities(ih).corp_filing_reference_nbr_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_filing_reference_nbr_weight100 := MAP (le.corp_filing_reference_nbr_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_filing_reference_nbr_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j37 := JOIN(j38,PULL(Specificities(ih).corp_filing_reference_nbr_values_persisted),LEFT.corp_filing_reference_nbr=RIGHT.corp_filing_reference_nbr,add_corp_filing_reference_nbr(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_web_address(layout_candidates le,Specificities(ih).corp_web_address_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_web_address_weight100 := MAP (le.corp_web_address_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_web_address_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j36 := JOIN(j37,PULL(Specificities(ih).corp_web_address_values_persisted),LEFT.corp_web_address=RIGHT.corp_web_address,add_corp_web_address(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_email_address(layout_candidates le,Specificities(ih).corp_email_address_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_email_address_weight100 := MAP (le.corp_email_address_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_email_address_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j35 := JOIN(j36,PULL(Specificities(ih).corp_email_address_values_persisted),LEFT.corp_email_address=RIGHT.corp_email_address,add_corp_email_address(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_fax_nbr(layout_candidates le,Specificities(ih).corp_fax_nbr_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_fax_nbr_weight100 := MAP (le.corp_fax_nbr_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_fax_nbr_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j34 := JOIN(j35,PULL(Specificities(ih).corp_fax_nbr_values_persisted),LEFT.corp_fax_nbr=RIGHT.corp_fax_nbr,add_corp_fax_nbr(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_phone_number_type_desc(layout_candidates le,Specificities(ih).corp_phone_number_type_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_phone_number_type_desc_weight100 := MAP (le.corp_phone_number_type_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_phone_number_type_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j33 := JOIN(j34,PULL(Specificities(ih).corp_phone_number_type_desc_values_persisted),LEFT.corp_phone_number_type_desc=RIGHT.corp_phone_number_type_desc,add_corp_phone_number_type_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_phone_number_type_cd(layout_candidates le,Specificities(ih).corp_phone_number_type_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_phone_number_type_cd_weight100 := MAP (le.corp_phone_number_type_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_phone_number_type_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j32 := JOIN(j33,PULL(Specificities(ih).corp_phone_number_type_cd_values_persisted),LEFT.corp_phone_number_type_cd=RIGHT.corp_phone_number_type_cd,add_corp_phone_number_type_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_phone_number(layout_candidates le,Specificities(ih).corp_phone_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_phone_number_weight100 := MAP (le.corp_phone_number_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_phone_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j31 := JOIN(j32,PULL(Specificities(ih).corp_phone_number_values_persisted),LEFT.corp_phone_number=RIGHT.corp_phone_number,add_corp_phone_number(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_address2_effective_date(layout_candidates le,Specificities(ih).corp_address2_effective_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_address2_effective_date_weight100 := MAP (le.corp_address2_effective_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_address2_effective_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j30 := JOIN(j31,PULL(Specificities(ih).corp_address2_effective_date_values_persisted),LEFT.corp_address2_effective_date=RIGHT.corp_address2_effective_date,add_corp_address2_effective_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_address2_line3(layout_candidates le,Specificities(ih).corp_address2_line3_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_address2_line3_weight100 := MAP (le.corp_address2_line3_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_address2_line3_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j29 := JOIN(j30,PULL(Specificities(ih).corp_address2_line3_values_persisted),LEFT.corp_address2_line3=RIGHT.corp_address2_line3,add_corp_address2_line3(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_address2_line2(layout_candidates le,Specificities(ih).corp_address2_line2_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_address2_line2_weight100 := MAP (le.corp_address2_line2_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_address2_line2_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j28 := JOIN(j29,PULL(Specificities(ih).corp_address2_line2_values_persisted),LEFT.corp_address2_line2=RIGHT.corp_address2_line2,add_corp_address2_line2(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_address2_line1(layout_candidates le,Specificities(ih).corp_address2_line1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_address2_line1_weight100 := MAP (le.corp_address2_line1_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_address2_line1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j27 := JOIN(j28,PULL(Specificities(ih).corp_address2_line1_values_persisted),LEFT.corp_address2_line1=RIGHT.corp_address2_line1,add_corp_address2_line1(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_address2_type_desc(layout_candidates le,Specificities(ih).corp_address2_type_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_address2_type_desc_weight100 := MAP (le.corp_address2_type_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_address2_type_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j26 := JOIN(j27,PULL(Specificities(ih).corp_address2_type_desc_values_persisted),LEFT.corp_address2_type_desc=RIGHT.corp_address2_type_desc,add_corp_address2_type_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_address2_type_cd(layout_candidates le,Specificities(ih).corp_address2_type_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_address2_type_cd_weight100 := MAP (le.corp_address2_type_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_address2_type_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j25 := JOIN(j26,PULL(Specificities(ih).corp_address2_type_cd_values_persisted),LEFT.corp_address2_type_cd=RIGHT.corp_address2_type_cd,add_corp_address2_type_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_address1_effective_date(layout_candidates le,Specificities(ih).corp_address1_effective_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_address1_effective_date_weight100 := MAP (le.corp_address1_effective_date_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_address1_effective_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j24 := JOIN(j25,PULL(Specificities(ih).corp_address1_effective_date_values_persisted),LEFT.corp_address1_effective_date=RIGHT.corp_address1_effective_date,add_corp_address1_effective_date(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_address1_line3(layout_candidates le,Specificities(ih).corp_address1_line3_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_address1_line3_weight100 := MAP (le.corp_address1_line3_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_address1_line3_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j23 := JOIN(j24,PULL(Specificities(ih).corp_address1_line3_values_persisted),LEFT.corp_address1_line3=RIGHT.corp_address1_line3,add_corp_address1_line3(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_address1_line2(layout_candidates le,Specificities(ih).corp_address1_line2_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_address1_line2_weight100 := MAP (le.corp_address1_line2_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_address1_line2_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j22 := JOIN(j23,PULL(Specificities(ih).corp_address1_line2_values_persisted),LEFT.corp_address1_line2=RIGHT.corp_address1_line2,add_corp_address1_line2(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_address1_line1(layout_candidates le,Specificities(ih).corp_address1_line1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_address1_line1_weight100 := MAP (le.corp_address1_line1_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_address1_line1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j21 := JOIN(j22,PULL(Specificities(ih).corp_address1_line1_values_persisted),LEFT.corp_address1_line1=RIGHT.corp_address1_line1,add_corp_address1_line1(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_address1_type_desc(layout_candidates le,Specificities(ih).corp_address1_type_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_address1_type_desc_weight100 := MAP (le.corp_address1_type_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_address1_type_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j20 := JOIN(j21,PULL(Specificities(ih).corp_address1_type_desc_values_persisted),LEFT.corp_address1_type_desc=RIGHT.corp_address1_type_desc,add_corp_address1_type_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_address1_type_cd(layout_candidates le,Specificities(ih).corp_address1_type_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_address1_type_cd_weight100 := MAP (le.corp_address1_type_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_address1_type_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j19 := JOIN(j20,PULL(Specificities(ih).corp_address1_type_cd_values_persisted),LEFT.corp_address1_type_cd=RIGHT.corp_address1_type_cd,add_corp_address1_type_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_name_comment(layout_candidates le,Specificities(ih).corp_name_comment_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_name_comment_weight100 := MAP (le.corp_name_comment_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_name_comment_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j18 := JOIN(j19,PULL(Specificities(ih).corp_name_comment_values_persisted),LEFT.corp_name_comment=RIGHT.corp_name_comment,add_corp_name_comment(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_supp_nbr(layout_candidates le,Specificities(ih).corp_supp_nbr_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_supp_nbr_weight100 := MAP (le.corp_supp_nbr_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_supp_nbr_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j17 := JOIN(j18,PULL(Specificities(ih).corp_supp_nbr_values_persisted),LEFT.corp_supp_nbr=RIGHT.corp_supp_nbr,add_corp_supp_nbr(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ln_name_type_desc(layout_candidates le,Specificities(ih).corp_ln_name_type_desc_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ln_name_type_desc_weight100 := MAP (le.corp_ln_name_type_desc_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ln_name_type_desc_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j16 := JOIN(j17,PULL(Specificities(ih).corp_ln_name_type_desc_values_persisted),LEFT.corp_ln_name_type_desc=RIGHT.corp_ln_name_type_desc,add_corp_ln_name_type_desc(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ln_name_type_cd(layout_candidates le,Specificities(ih).corp_ln_name_type_cd_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ln_name_type_cd_weight100 := MAP (le.corp_ln_name_type_cd_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ln_name_type_cd_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j15 := JOIN(j16,PULL(Specificities(ih).corp_ln_name_type_cd_values_persisted),LEFT.corp_ln_name_type_cd=RIGHT.corp_ln_name_type_cd,add_corp_ln_name_type_cd(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_legal_name(layout_candidates le,Specificities(ih).corp_legal_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_legal_name_weight100 := MAP (le.corp_legal_name_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_legal_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j14 := JOIN(j15,PULL(Specificities(ih).corp_legal_name_values_persisted),LEFT.corp_legal_name=RIGHT.corp_legal_name,add_corp_legal_name(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_orig_sos_charter_nbr(layout_candidates le,Specificities(ih).corp_orig_sos_charter_nbr_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_orig_sos_charter_nbr_weight100 := MAP (le.corp_orig_sos_charter_nbr_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_orig_sos_charter_nbr_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j13 := JOIN(j14,PULL(Specificities(ih).corp_orig_sos_charter_nbr_values_persisted),LEFT.corp_orig_sos_charter_nbr=RIGHT.corp_orig_sos_charter_nbr,add_corp_orig_sos_charter_nbr(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_process_date_year(layout_candidates le,Specificities(ih).corp_process_date_year_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_process_date_year_weight100 := MAP (le.corp_process_date_year_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_process_date_year_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j13000 := JOIN(j13,PULL(Specificities(ih).corp_process_date_year_values_persisted),LEFT.corp_process_date_year=RIGHT.corp_process_date_year,add_corp_process_date_year(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_corp_process_date_month(layout_candidates le,Specificities(ih).corp_process_date_month_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_process_date_month_weight100 := MAP (le.corp_process_date_month_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_process_date_month_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j13001 := JOIN(j13000,PULL(Specificities(ih).corp_process_date_month_values_persisted),LEFT.corp_process_date_month=RIGHT.corp_process_date_month,add_corp_process_date_month(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_process_date_day(layout_candidates le,Specificities(ih).corp_process_date_day_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_process_date_day_weight100 := MAP (le.corp_process_date_day_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_process_date_day_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j13002 := JOIN(j13001,PULL(Specificities(ih).corp_process_date_day_values_persisted),LEFT.corp_process_date_day=RIGHT.corp_process_date_day,add_corp_process_date_day(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_state_origin(layout_candidates le,Specificities(ih).corp_state_origin_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_state_origin_weight100 := MAP (le.corp_state_origin_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_state_origin_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j11 := JOIN(j13002,PULL(Specificities(ih).corp_state_origin_values_persisted),LEFT.corp_state_origin=RIGHT.corp_state_origin,add_corp_state_origin(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_vendor_subcode(layout_candidates le,Specificities(ih).corp_vendor_subcode_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_vendor_subcode_weight100 := MAP (le.corp_vendor_subcode_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_vendor_subcode_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j10 := JOIN(j11,PULL(Specificities(ih).corp_vendor_subcode_values_persisted),LEFT.corp_vendor_subcode=RIGHT.corp_vendor_subcode,add_corp_vendor_subcode(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_vendor_county(layout_candidates le,Specificities(ih).corp_vendor_county_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_vendor_county_weight100 := MAP (le.corp_vendor_county_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_vendor_county_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j9 := JOIN(j10,PULL(Specificities(ih).corp_vendor_county_values_persisted),LEFT.corp_vendor_county=RIGHT.corp_vendor_county,add_corp_vendor_county(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_vendor(layout_candidates le,Specificities(ih).corp_vendor_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_vendor_weight100 := MAP (le.corp_vendor_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_vendor_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j8 := JOIN(j9,PULL(Specificities(ih).corp_vendor_values_persisted),LEFT.corp_vendor=RIGHT.corp_vendor,add_corp_vendor(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_supp_key(layout_candidates le,Specificities(ih).corp_supp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_supp_key_weight100 := MAP (le.corp_supp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_supp_key_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j7 := JOIN(j8,PULL(Specificities(ih).corp_supp_key_values_persisted),LEFT.corp_supp_key=RIGHT.corp_supp_key,add_corp_supp_key(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_key(layout_candidates le,Specificities(ih).corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_key_weight100 := MAP (le.corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_key_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j6 := JOIN(j7,PULL(Specificities(ih).corp_key_values_persisted),LEFT.corp_key=RIGHT.corp_key,add_corp_key(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_dt_last_seen_year(layout_candidates le,Specificities(ih).corp_ra_dt_last_seen_year_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_dt_last_seen_year_weight100 := MAP (le.corp_ra_dt_last_seen_year_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_dt_last_seen_year_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j6000 := JOIN(j6,PULL(Specificities(ih).corp_ra_dt_last_seen_year_values_persisted),LEFT.corp_ra_dt_last_seen_year=RIGHT.corp_ra_dt_last_seen_year,add_corp_ra_dt_last_seen_year(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_corp_ra_dt_last_seen_month(layout_candidates le,Specificities(ih).corp_ra_dt_last_seen_month_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_dt_last_seen_month_weight100 := MAP (le.corp_ra_dt_last_seen_month_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_dt_last_seen_month_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j6001 := JOIN(j6000,PULL(Specificities(ih).corp_ra_dt_last_seen_month_values_persisted),LEFT.corp_ra_dt_last_seen_month=RIGHT.corp_ra_dt_last_seen_month,add_corp_ra_dt_last_seen_month(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_dt_last_seen_day(layout_candidates le,Specificities(ih).corp_ra_dt_last_seen_day_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_dt_last_seen_day_weight100 := MAP (le.corp_ra_dt_last_seen_day_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_dt_last_seen_day_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j6002 := JOIN(j6001,PULL(Specificities(ih).corp_ra_dt_last_seen_day_values_persisted),LEFT.corp_ra_dt_last_seen_day=RIGHT.corp_ra_dt_last_seen_day,add_corp_ra_dt_last_seen_day(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_dt_first_seen_year(layout_candidates le,Specificities(ih).corp_ra_dt_first_seen_year_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_dt_first_seen_year_weight100 := MAP (le.corp_ra_dt_first_seen_year_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_dt_first_seen_year_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j5000 := JOIN(j6002,PULL(Specificities(ih).corp_ra_dt_first_seen_year_values_persisted),LEFT.corp_ra_dt_first_seen_year=RIGHT.corp_ra_dt_first_seen_year,add_corp_ra_dt_first_seen_year(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_corp_ra_dt_first_seen_month(layout_candidates le,Specificities(ih).corp_ra_dt_first_seen_month_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_dt_first_seen_month_weight100 := MAP (le.corp_ra_dt_first_seen_month_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_dt_first_seen_month_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j5001 := JOIN(j5000,PULL(Specificities(ih).corp_ra_dt_first_seen_month_values_persisted),LEFT.corp_ra_dt_first_seen_month=RIGHT.corp_ra_dt_first_seen_month,add_corp_ra_dt_first_seen_month(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_corp_ra_dt_first_seen_day(layout_candidates le,Specificities(ih).corp_ra_dt_first_seen_day_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_ra_dt_first_seen_day_weight100 := MAP (le.corp_ra_dt_first_seen_day_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_ra_dt_first_seen_day_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j5002 := JOIN(j5001,PULL(Specificities(ih).corp_ra_dt_first_seen_day_values_persisted),LEFT.corp_ra_dt_first_seen_day=RIGHT.corp_ra_dt_first_seen_day,add_corp_ra_dt_first_seen_day(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_dt_last_seen_year(layout_candidates le,Specificities(ih).dt_last_seen_year_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dt_last_seen_year_weight100 := MAP (le.dt_last_seen_year_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_last_seen_year_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j4000 := JOIN(j5002,PULL(Specificities(ih).dt_last_seen_year_values_persisted),LEFT.dt_last_seen_year=RIGHT.dt_last_seen_year,add_dt_last_seen_year(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_dt_last_seen_month(layout_candidates le,Specificities(ih).dt_last_seen_month_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dt_last_seen_month_weight100 := MAP (le.dt_last_seen_month_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_last_seen_month_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j4001 := JOIN(j4000,PULL(Specificities(ih).dt_last_seen_month_values_persisted),LEFT.dt_last_seen_month=RIGHT.dt_last_seen_month,add_dt_last_seen_month(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_dt_last_seen_day(layout_candidates le,Specificities(ih).dt_last_seen_day_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dt_last_seen_day_weight100 := MAP (le.dt_last_seen_day_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_last_seen_day_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j4002 := JOIN(j4001,PULL(Specificities(ih).dt_last_seen_day_values_persisted),LEFT.dt_last_seen_day=RIGHT.dt_last_seen_day,add_dt_last_seen_day(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_dt_first_seen_year(layout_candidates le,Specificities(ih).dt_first_seen_year_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dt_first_seen_year_weight100 := MAP (le.dt_first_seen_year_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_first_seen_year_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j3000 := JOIN(j4002,PULL(Specificities(ih).dt_first_seen_year_values_persisted),LEFT.dt_first_seen_year=RIGHT.dt_first_seen_year,add_dt_first_seen_year(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_dt_first_seen_month(layout_candidates le,Specificities(ih).dt_first_seen_month_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dt_first_seen_month_weight100 := MAP (le.dt_first_seen_month_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_first_seen_month_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j3001 := JOIN(j3000,PULL(Specificities(ih).dt_first_seen_month_values_persisted),LEFT.dt_first_seen_month=RIGHT.dt_first_seen_month,add_dt_first_seen_month(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_dt_first_seen_day(layout_candidates le,Specificities(ih).dt_first_seen_day_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dt_first_seen_day_weight100 := MAP (le.dt_first_seen_day_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_first_seen_day_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j3002 := JOIN(j3001,PULL(Specificities(ih).dt_first_seen_day_values_persisted),LEFT.dt_first_seen_day=RIGHT.dt_first_seen_day,add_dt_first_seen_day(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_dt_vendor_last_reported_year(layout_candidates le,Specificities(ih).dt_vendor_last_reported_year_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dt_vendor_last_reported_year_weight100 := MAP (le.dt_vendor_last_reported_year_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_vendor_last_reported_year_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j2000 := JOIN(j3002,PULL(Specificities(ih).dt_vendor_last_reported_year_values_persisted),LEFT.dt_vendor_last_reported_year=RIGHT.dt_vendor_last_reported_year,add_dt_vendor_last_reported_year(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_dt_vendor_last_reported_month(layout_candidates le,Specificities(ih).dt_vendor_last_reported_month_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dt_vendor_last_reported_month_weight100 := MAP (le.dt_vendor_last_reported_month_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_vendor_last_reported_month_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j2001 := JOIN(j2000,PULL(Specificities(ih).dt_vendor_last_reported_month_values_persisted),LEFT.dt_vendor_last_reported_month=RIGHT.dt_vendor_last_reported_month,add_dt_vendor_last_reported_month(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_dt_vendor_last_reported_day(layout_candidates le,Specificities(ih).dt_vendor_last_reported_day_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dt_vendor_last_reported_day_weight100 := MAP (le.dt_vendor_last_reported_day_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_vendor_last_reported_day_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j2002 := JOIN(j2001,PULL(Specificities(ih).dt_vendor_last_reported_day_values_persisted),LEFT.dt_vendor_last_reported_day=RIGHT.dt_vendor_last_reported_day,add_dt_vendor_last_reported_day(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_dt_vendor_first_reported_year(layout_candidates le,Specificities(ih).dt_vendor_first_reported_year_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dt_vendor_first_reported_year_weight100 := MAP (le.dt_vendor_first_reported_year_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_vendor_first_reported_year_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j1000 := JOIN(j2002,PULL(Specificities(ih).dt_vendor_first_reported_year_values_persisted),LEFT.dt_vendor_first_reported_year=RIGHT.dt_vendor_first_reported_year,add_dt_vendor_first_reported_year(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_dt_vendor_first_reported_month(layout_candidates le,Specificities(ih).dt_vendor_first_reported_month_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dt_vendor_first_reported_month_weight100 := MAP (le.dt_vendor_first_reported_month_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_vendor_first_reported_month_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j1001 := JOIN(j1000,PULL(Specificities(ih).dt_vendor_first_reported_month_values_persisted),LEFT.dt_vendor_first_reported_month=RIGHT.dt_vendor_first_reported_month,add_dt_vendor_first_reported_month(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_dt_vendor_first_reported_day(layout_candidates le,Specificities(ih).dt_vendor_first_reported_day_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dt_vendor_first_reported_day_weight100 := MAP (le.dt_vendor_first_reported_day_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_vendor_first_reported_day_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j1002 := JOIN(j1001,PULL(Specificities(ih).dt_vendor_first_reported_day_values_persisted),LEFT.dt_vendor_first_reported_day=RIGHT.dt_vendor_first_reported_day,add_dt_vendor_first_reported_day(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j1002,hash()) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::mc',EXPIRE(Config.PersistExpire)); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.dt_vendor_first_reported_year_weight100 + Annotated.dt_vendor_first_reported_month_weight100 + Annotated.dt_vendor_first_reported_day_weight100 + Annotated.dt_vendor_last_reported_year_weight100 + Annotated.dt_vendor_last_reported_month_weight100 + Annotated.dt_vendor_last_reported_day_weight100 + Annotated.dt_first_seen_year_weight100 + Annotated.dt_first_seen_month_weight100 + Annotated.dt_first_seen_day_weight100 + Annotated.dt_last_seen_year_weight100 + Annotated.dt_last_seen_month_weight100 + Annotated.dt_last_seen_day_weight100 + Annotated.corp_ra_dt_first_seen_year_weight100 + Annotated.corp_ra_dt_first_seen_month_weight100 + Annotated.corp_ra_dt_first_seen_day_weight100 + Annotated.corp_ra_dt_last_seen_year_weight100 + Annotated.corp_ra_dt_last_seen_month_weight100 + Annotated.corp_ra_dt_last_seen_day_weight100 + Annotated.corp_key_weight100 + Annotated.corp_supp_key_weight100 + Annotated.corp_vendor_weight100 + Annotated.corp_vendor_county_weight100 + Annotated.corp_vendor_subcode_weight100 + Annotated.corp_state_origin_weight100 + Annotated.corp_process_date_year_weight100 + Annotated.corp_process_date_month_weight100 + Annotated.corp_process_date_day_weight100 + Annotated.corp_orig_sos_charter_nbr_weight100 + Annotated.corp_legal_name_weight100 + Annotated.corp_ln_name_type_cd_weight100 + Annotated.corp_ln_name_type_desc_weight100 + Annotated.corp_supp_nbr_weight100 + Annotated.corp_name_comment_weight100 + Annotated.corp_address1_type_cd_weight100 + Annotated.corp_address1_type_desc_weight100 + Annotated.corp_address1_line1_weight100 + Annotated.corp_address1_line2_weight100 + Annotated.corp_address1_line3_weight100 + Annotated.corp_address1_effective_date_weight100 + Annotated.corp_address2_type_cd_weight100 + Annotated.corp_address2_type_desc_weight100 + Annotated.corp_address2_line1_weight100 + Annotated.corp_address2_line2_weight100 + Annotated.corp_address2_line3_weight100 + Annotated.corp_address2_effective_date_weight100 + Annotated.corp_phone_number_weight100 + Annotated.corp_phone_number_type_cd_weight100 + Annotated.corp_phone_number_type_desc_weight100 + Annotated.corp_fax_nbr_weight100 + Annotated.corp_email_address_weight100 + Annotated.corp_web_address_weight100 + Annotated.corp_filing_reference_nbr_weight100 + Annotated.corp_filing_date_weight100 + Annotated.corp_filing_cd_weight100 + Annotated.corp_filing_desc_weight100 + Annotated.corp_status_cd_weight100 + Annotated.corp_status_desc_weight100 + Annotated.corp_status_date_weight100 + Annotated.corp_standing_weight100 + Annotated.corp_status_comment_weight100 + Annotated.corp_ticker_symbol_weight100 + Annotated.corp_stock_exchange_weight100 + Annotated.corp_inc_state_weight100 + Annotated.corp_inc_county_weight100 + Annotated.corp_inc_date_weight100 + Annotated.corp_anniversary_month_weight100 + Annotated.corp_fed_tax_id_weight100 + Annotated.corp_state_tax_id_weight100 + Annotated.corp_term_exist_cd_weight100 + Annotated.corp_term_exist_exp_weight100 + Annotated.corp_term_exist_desc_weight100 + Annotated.corp_foreign_domestic_ind_weight100 + Annotated.corp_forgn_state_cd_weight100 + Annotated.corp_forgn_state_desc_weight100 + Annotated.corp_forgn_sos_charter_nbr_weight100 + Annotated.corp_forgn_date_weight100 + Annotated.corp_forgn_fed_tax_id_weight100 + Annotated.corp_forgn_state_tax_id_weight100 + Annotated.corp_forgn_term_exist_cd_weight100 + Annotated.corp_forgn_term_exist_exp_weight100 + Annotated.corp_forgn_term_exist_desc_weight100 + Annotated.corp_orig_org_structure_cd_weight100 + Annotated.corp_orig_org_structure_desc_weight100 + Annotated.corp_for_profit_ind_weight100 + Annotated.corp_public_or_private_ind_weight100 + Annotated.corp_sic_code_weight100 + Annotated.corp_naic_code_weight100 + Annotated.corp_orig_bus_type_cd_weight100 + Annotated.corp_orig_bus_type_desc_weight100 + Annotated.corp_entity_desc_weight100 + Annotated.corp_certificate_nbr_weight100 + Annotated.corp_internal_nbr_weight100 + Annotated.corp_previous_nbr_weight100 + Annotated.corp_microfilm_nbr_weight100 + Annotated.corp_amendments_filed_weight100 + Annotated.corp_acts_weight100 + Annotated.corp_partnership_ind_weight100 + Annotated.corp_mfg_ind_weight100 + Annotated.corp_addl_info_weight100 + Annotated.corp_taxes_weight100 + Annotated.corp_franchise_taxes_weight100 + Annotated.corp_tax_program_cd_weight100 + Annotated.corp_tax_program_desc_weight100 + Annotated.corp_ra_full_name_weight100 + Annotated.corp_ra_fname_weight100 + Annotated.corp_ra_mname_weight100 + Annotated.corp_ra_lname_weight100 + Annotated.corp_ra_suffix_weight100 + Annotated.corp_ra_title_cd_weight100 + Annotated.corp_ra_title_desc_weight100 + Annotated.corp_ra_fein_weight100 + Annotated.corp_ra_ssn_weight100 + Annotated.corp_ra_dob_weight100 + Annotated.corp_ra_effective_date_weight100 + Annotated.corp_ra_resign_date_weight100 + Annotated.corp_ra_no_comp_weight100 + Annotated.corp_ra_no_comp_igs_weight100 + Annotated.corp_ra_addl_info_weight100 + Annotated.corp_ra_address_type_cd_weight100 + Annotated.corp_ra_address_type_desc_weight100 + Annotated.corp_ra_address_line1_weight100 + Annotated.corp_ra_address_line2_weight100 + Annotated.corp_ra_address_line3_weight100 + Annotated.corp_ra_phone_number_weight100 + Annotated.corp_ra_phone_number_type_cd_weight100 + Annotated.corp_ra_phone_number_type_desc_weight100 + Annotated.corp_ra_fax_nbr_weight100 + Annotated.corp_ra_email_address_weight100 + Annotated.corp_ra_web_address_weight100 + Annotated.corp_prep_addr1_line1_weight100 + Annotated.corp_prep_addr1_last_line_weight100 + Annotated.corp_prep_addr2_line1_weight100 + Annotated.corp_prep_addr2_last_line_weight100 + Annotated.ra_prep_addr_line1_weight100 + Annotated.ra_prep_addr_last_line_weight100 + Annotated.cont_filing_reference_nbr_weight100 + Annotated.cont_filing_date_weight100 + Annotated.cont_filing_cd_weight100 + Annotated.cont_filing_desc_weight100 + Annotated.cont_type_cd_weight100 + Annotated.cont_type_desc_weight100 + Annotated.cont_full_name_weight100 + Annotated.cont_fname_weight100 + Annotated.cont_mname_weight100 + Annotated.cont_lname_weight100 + Annotated.cont_suffix_weight100 + Annotated.cont_title1_desc_weight100 + Annotated.cont_title2_desc_weight100 + Annotated.cont_title3_desc_weight100 + Annotated.cont_title4_desc_weight100 + Annotated.cont_title5_desc_weight100 + Annotated.cont_fein_weight100 + Annotated.cont_ssn_weight100 + Annotated.cont_dob_weight100 + Annotated.cont_status_cd_weight100 + Annotated.cont_status_desc_weight100 + Annotated.cont_effective_date_weight100 + Annotated.cont_effective_cd_weight100 + Annotated.cont_effective_desc_weight100 + Annotated.cont_addl_info_weight100 + Annotated.cont_address_type_cd_weight100 + Annotated.cont_address_type_desc_weight100 + Annotated.cont_address_line1_weight100 + Annotated.cont_address_line2_weight100 + Annotated.cont_address_line3_weight100 + Annotated.cont_address_effective_date_weight100 + Annotated.cont_address_county_weight100 + Annotated.cont_phone_number_weight100 + Annotated.cont_phone_number_type_cd_weight100 + Annotated.cont_phone_number_type_desc_weight100 + Annotated.cont_fax_nbr_weight100 + Annotated.cont_email_address_weight100 + Annotated.cont_web_address_weight100 + Annotated.corp_acres_weight100 + Annotated.corp_action_weight100 + Annotated.corp_action_date_weight100 + Annotated.corp_action_employment_security_approval_date_weight100 + Annotated.corp_action_pending_cd_weight100 + Annotated.corp_action_pending_desc_weight100 + Annotated.corp_action_statement_of_intent_date_weight100 + Annotated.corp_action_tax_dept_approval_date_weight100 + Annotated.corp_acts2_weight100 + Annotated.corp_acts3_weight100 + Annotated.corp_additional_principals_weight100 + Annotated.corp_address_office_type_weight100 + Annotated.corp_agent_assign_date_weight100 + Annotated.corp_agent_commercial_weight100 + Annotated.corp_agent_country_weight100 + Annotated.corp_agent_county_weight100 + Annotated.corp_agent_status_cd_weight100 + Annotated.corp_agent_status_desc_weight100 + Annotated.corp_agent_id_weight100 + Annotated.corp_agriculture_flag_weight100 + Annotated.corp_authorized_partners_weight100 + Annotated.corp_comment_weight100 + Annotated.corp_consent_flag_for_protected_name_weight100 + Annotated.corp_converted_weight100 + Annotated.corp_converted_from_weight100 + Annotated.corp_country_of_formation_weight100 + Annotated.corp_date_of_organization_meeting_weight100 + Annotated.corp_delayed_effective_date_weight100 + Annotated.corp_directors_from_to_weight100 + Annotated.corp_dissolved_date_weight100 + Annotated.corp_farm_exemptions_weight100 + Annotated.corp_farm_qual_date_weight100 + Annotated.corp_farm_status_cd_weight100 + Annotated.corp_farm_status_desc_weight100 + Annotated.corp_fiscal_year_month_weight100 + Annotated.corp_foreign_fiduciary_capacity_in_state_weight100 + Annotated.corp_governing_statute_weight100 + Annotated.corp_has_members_weight100 + Annotated.corp_has_vested_managers_weight100 + Annotated.corp_home_incorporated_county_weight100 + Annotated.corp_home_state_name_weight100 + Annotated.corp_is_professional_weight100 + Annotated.corp_is_non_profit_irs_approved_weight100 + Annotated.corp_last_renewal_date_weight100 + Annotated.corp_last_renewal_year_weight100 + Annotated.corp_license_type_weight100 + Annotated.corp_llc_managed_desc_weight100 + Annotated.corp_llc_managed_ind_weight100 + Annotated.corp_management_desc_weight100 + Annotated.corp_management_type_weight100 + Annotated.corp_manager_managed_weight100 + Annotated.corp_merged_corporation_id_weight100 + Annotated.corp_merged_fein_weight100 + Annotated.corp_merger_allowed_flag_weight100 + Annotated.corp_merger_date_weight100 + Annotated.corp_merger_desc_weight100 + Annotated.corp_merger_effective_date_weight100 + Annotated.corp_merger_id_weight100 + Annotated.corp_merger_indicator_weight100 + Annotated.corp_merger_name_weight100 + Annotated.corp_merger_type_converted_to_cd_weight100 + Annotated.corp_merger_type_converted_to_desc_weight100 + Annotated.corp_naics_desc_weight100 + Annotated.corp_name_effective_date_weight100 + Annotated.corp_name_reservation_date_weight100 + Annotated.corp_name_reservation_desc_weight100 + Annotated.corp_name_reservation_expiration_date_weight100 + Annotated.corp_name_reservation_nbr_weight100 + Annotated.corp_name_reservation_type_weight100 + Annotated.corp_name_status_cd_weight100 + Annotated.corp_name_status_date_weight100 + Annotated.corp_name_status_desc_weight100 + Annotated.corp_non_profit_irs_approved_purpose_weight100 + Annotated.corp_non_profit_solicit_donations_weight100 + Annotated.corp_nbr_of_amendments_weight100 + Annotated.corp_nbr_of_initial_llc_members_weight100 + Annotated.corp_nbr_of_partners_weight100 + Annotated.corp_operating_agreement_weight100 + Annotated.corp_opt_in_llc_act_desc_weight100 + Annotated.corp_opt_in_llc_act_ind_weight100 + Annotated.corp_organizational_comments_weight100 + Annotated.corp_partner_contributions_total_weight100 + Annotated.corp_partner_terms_weight100 + Annotated.corp_percentage_voters_required_to_approve_amendments_weight100 + Annotated.corp_profession_weight100 + Annotated.corp_province_weight100 + Annotated.corp_public_mutual_corporation_weight100 + Annotated.corp_purpose_weight100 + Annotated.corp_ra_required_flag_weight100 + Annotated.corp_registered_counties_weight100 + Annotated.corp_regulated_ind_weight100 + Annotated.corp_renewal_date_weight100 + Annotated.corp_standing_other_weight100 + Annotated.corp_survivor_corporation_id_weight100 + Annotated.corp_tax_base_weight100 + Annotated.corp_tax_standing_weight100 + Annotated.corp_termination_cd_weight100 + Annotated.corp_termination_desc_weight100 + Annotated.corp_termination_date_weight100 + Annotated.corp_trademark_business_mark_type_weight100 + Annotated.corp_trademark_cancelled_date_weight100 + Annotated.corp_trademark_class_desc1_weight100 + Annotated.corp_trademark_class_desc2_weight100 + Annotated.corp_trademark_class_desc3_weight100 + Annotated.corp_trademark_class_desc4_weight100 + Annotated.corp_trademark_class_desc5_weight100 + Annotated.corp_trademark_class_desc6_weight100 + Annotated.corp_trademark_classification_nbr_weight100 + Annotated.corp_trademark_disclaimer1_weight100 + Annotated.corp_trademark_disclaimer2_weight100 + Annotated.corp_trademark_expiration_date_weight100 + Annotated.corp_trademark_filing_date_weight100 + Annotated.corp_trademark_first_use_date_weight100 + Annotated.corp_trademark_first_use_date_in_state_weight100 + Annotated.corp_trademark_keywords_weight100 + Annotated.corp_trademark_logo_weight100 + Annotated.corp_trademark_name_expiration_date_weight100 + Annotated.corp_trademark_nbr_weight100 + Annotated.corp_trademark_renewal_date_weight100 + Annotated.corp_trademark_status_weight100 + Annotated.corp_trademark_used_1_weight100 + Annotated.corp_trademark_used_2_weight100 + Annotated.corp_trademark_used_3_weight100 + Annotated.cont_owner_percentage_weight100 + Annotated.cont_country_weight100 + Annotated.cont_country_mailing_weight100 + Annotated.cont_nondislosure_weight100 + Annotated.cont_prep_addr_line1_weight100 + Annotated.cont_prep_addr_last_line_weight100 + Annotated.recordorigin_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
EXPORT BuddyCounts := TABLE(Annotated,{ buddies, Cnt := COUNT(GROUP) }, buddies, FEW);
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
