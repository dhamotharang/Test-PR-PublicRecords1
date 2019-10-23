
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_corp_ra_dt_first_seen = '',Input_corp_ra_dt_last_seen = '',Input_corp_key = '',Input_corp_supp_key = '',Input_corp_vendor = '',Input_corp_vendor_county = '',Input_corp_vendor_subcode = '',Input_corp_state_origin = '',Input_corp_process_date = '',Input_corp_orig_sos_charter_nbr = '',Input_corp_legal_name = '',Input_corp_ln_name_type_cd = '',Input_corp_ln_name_type_desc = '',Input_corp_supp_nbr = '',Input_corp_name_comment = '',Input_corp_address1_type_cd = '',Input_corp_address1_type_desc = '',Input_corp_address1_line1 = '',Input_corp_address1_line2 = '',Input_corp_address1_line3 = '',Input_corp_address1_effective_date = '',Input_corp_address2_type_cd = '',Input_corp_address2_type_desc = '',Input_corp_address2_line1 = '',Input_corp_address2_line2 = '',Input_corp_address2_line3 = '',Input_corp_address2_effective_date = '',Input_corp_phone_number = '',Input_corp_phone_number_type_cd = '',Input_corp_phone_number_type_desc = '',Input_corp_fax_nbr = '',Input_corp_email_address = '',Input_corp_web_address = '',Input_corp_filing_reference_nbr = '',Input_corp_filing_date = '',Input_corp_filing_cd = '',Input_corp_filing_desc = '',Input_corp_status_cd = '',Input_corp_status_desc = '',Input_corp_status_date = '',Input_corp_standing = '',Input_corp_status_comment = '',Input_corp_ticker_symbol = '',Input_corp_stock_exchange = '',Input_corp_inc_state = '',Input_corp_inc_county = '',Input_corp_inc_date = '',Input_corp_anniversary_month = '',Input_corp_fed_tax_id = '',Input_corp_state_tax_id = '',Input_corp_term_exist_cd = '',Input_corp_term_exist_exp = '',Input_corp_term_exist_desc = '',Input_corp_foreign_domestic_ind = '',Input_corp_forgn_state_cd = '',Input_corp_forgn_state_desc = '',Input_corp_forgn_sos_charter_nbr = '',Input_corp_forgn_date = '',Input_corp_forgn_fed_tax_id = '',Input_corp_forgn_state_tax_id = '',Input_corp_forgn_term_exist_cd = '',Input_corp_forgn_term_exist_exp = '',Input_corp_forgn_term_exist_desc = '',Input_corp_orig_org_structure_cd = '',Input_corp_orig_org_structure_desc = '',Input_corp_for_profit_ind = '',Input_corp_public_or_private_ind = '',Input_corp_sic_code = '',Input_corp_naic_code = '',Input_corp_orig_bus_type_cd = '',Input_corp_orig_bus_type_desc = '',Input_corp_entity_desc = '',Input_corp_certificate_nbr = '',Input_corp_internal_nbr = '',Input_corp_previous_nbr = '',Input_corp_microfilm_nbr = '',Input_corp_amendments_filed = '',Input_corp_acts = '',Input_corp_partnership_ind = '',Input_corp_mfg_ind = '',Input_corp_addl_info = '',Input_corp_taxes = '',Input_corp_franchise_taxes = '',Input_corp_tax_program_cd = '',Input_corp_tax_program_desc = '',Input_corp_ra_full_name = '',Input_corp_ra_fname = '',Input_corp_ra_mname = '',Input_corp_ra_lname = '',Input_corp_ra_suffix = '',Input_corp_ra_title_cd = '',Input_corp_ra_title_desc = '',Input_corp_ra_fein = '',Input_corp_ra_ssn = '',Input_corp_ra_dob = '',Input_corp_ra_effective_date = '',Input_corp_ra_resign_date = '',Input_corp_ra_no_comp = '',Input_corp_ra_no_comp_igs = '',Input_corp_ra_addl_info = '',Input_corp_ra_address_type_cd = '',Input_corp_ra_address_type_desc = '',Input_corp_ra_address_line1 = '',Input_corp_ra_address_line2 = '',Input_corp_ra_address_line3 = '',Input_corp_ra_phone_number = '',Input_corp_ra_phone_number_type_cd = '',Input_corp_ra_phone_number_type_desc = '',Input_corp_ra_fax_nbr = '',Input_corp_ra_email_address = '',Input_corp_ra_web_address = '',Input_corp_prep_addr1_line1 = '',Input_corp_prep_addr1_last_line = '',Input_corp_prep_addr2_line1 = '',Input_corp_prep_addr2_last_line = '',Input_ra_prep_addr_line1 = '',Input_ra_prep_addr_last_line = '',Input_cont_filing_reference_nbr = '',Input_cont_filing_date = '',Input_cont_filing_cd = '',Input_cont_filing_desc = '',Input_cont_type_cd = '',Input_cont_type_desc = '',Input_cont_full_name = '',Input_cont_fname = '',Input_cont_mname = '',Input_cont_lname = '',Input_cont_suffix = '',Input_cont_title1_desc = '',Input_cont_title2_desc = '',Input_cont_title3_desc = '',Input_cont_title4_desc = '',Input_cont_title5_desc = '',Input_cont_fein = '',Input_cont_ssn = '',Input_cont_dob = '',Input_cont_status_cd = '',Input_cont_status_desc = '',Input_cont_effective_date = '',Input_cont_effective_cd = '',Input_cont_effective_desc = '',Input_cont_addl_info = '',Input_cont_address_type_cd = '',Input_cont_address_type_desc = '',Input_cont_address_line1 = '',Input_cont_address_line2 = '',Input_cont_address_line3 = '',Input_cont_address_effective_date = '',Input_cont_address_county = '',Input_cont_phone_number = '',Input_cont_phone_number_type_cd = '',Input_cont_phone_number_type_desc = '',Input_cont_fax_nbr = '',Input_cont_email_address = '',Input_cont_web_address = '',Input_corp_acres = '',Input_corp_action = '',Input_corp_action_date = '',Input_corp_action_employment_security_approval_date = '',Input_corp_action_pending_cd = '',Input_corp_action_pending_desc = '',Input_corp_action_statement_of_intent_date = '',Input_corp_action_tax_dept_approval_date = '',Input_corp_acts2 = '',Input_corp_acts3 = '',Input_corp_additional_principals = '',Input_corp_address_office_type = '',Input_corp_agent_commercial = '',Input_corp_agent_country = '',Input_corp_agent_county = '',Input_corp_agent_status_cd = '',Input_corp_agent_status_desc = '',Input_corp_agent_id = '',Input_corp_agent_assign_date = '',Input_corp_agriculture_flag = '',Input_corp_authorized_partners = '',Input_corp_comment = '',Input_corp_consent_flag_for_protected_name = '',Input_corp_converted = '',Input_corp_converted_from = '',Input_corp_country_of_formation = '',Input_corp_date_of_organization_meeting = '',Input_corp_delayed_effective_date = '',Input_corp_directors_from_to = '',Input_corp_dissolved_date = '',Input_corp_farm_exemptions = '',Input_corp_farm_qual_date = '',Input_corp_farm_status_cd = '',Input_corp_farm_status_desc = '',Input_corp_farm_status_date = '',Input_corp_fiscal_year_month = '',Input_corp_foreign_fiduciary_capacity_in_state = '',Input_corp_governing_statute = '',Input_corp_has_members = '',Input_corp_has_vested_managers = '',Input_corp_home_incorporated_county = '',Input_corp_home_state_name = '',Input_corp_is_professional = '',Input_corp_is_non_profit_irs_approved = '',Input_corp_last_renewal_date = '',Input_corp_last_renewal_year = '',Input_corp_license_type = '',Input_corp_llc_managed_ind = '',Input_corp_llc_managed_desc = '',Input_corp_management_desc = '',Input_corp_management_type = '',Input_corp_manager_managed = '',Input_corp_merged_corporation_id = '',Input_corp_merged_fein = '',Input_corp_merger_allowed_flag = '',Input_corp_merger_date = '',Input_corp_merger_desc = '',Input_corp_merger_effective_date = '',Input_corp_merger_id = '',Input_corp_merger_indicator = '',Input_corp_merger_name = '',Input_corp_merger_type_converted_to_cd = '',Input_corp_merger_type_converted_to_desc = '',Input_corp_naics_desc = '',Input_corp_name_effective_date = '',Input_corp_name_reservation_date = '',Input_corp_name_reservation_expiration_date = '',Input_corp_name_reservation_nbr = '',Input_corp_name_reservation_type = '',Input_corp_name_status_cd = '',Input_corp_name_status_date = '',Input_corp_name_status_desc = '',Input_corp_non_profit_irs_approved_purpose = '',Input_corp_non_profit_solicit_donations = '',Input_corp_nbr_of_amendments = '',Input_corp_nbr_of_initial_llc_members = '',Input_corp_nbr_of_partners = '',Input_corp_operating_agreement = '',Input_corp_opt_in_llc_act_desc = '',Input_corp_opt_in_llc_act_ind = '',Input_corp_organizational_comments = '',Input_corp_partner_contributions_total = '',Input_corp_partner_terms = '',Input_corp_percentage_voters_required_to_approve_amendments = '',Input_corp_profession = '',Input_corp_province = '',Input_corp_public_mutual_corporation = '',Input_corp_purpose = '',Input_corp_ra_required_flag = '',Input_corp_registered_counties = '',Input_corp_regulated_ind = '',Input_corp_renewal_date = '',Input_corp_standing_other = '',Input_corp_survivor_corporation_id = '',Input_corp_tax_base = '',Input_corp_tax_standing = '',Input_corp_termination_cd = '',Input_corp_termination_desc = '',Input_corp_termination_date = '',Input_corp_trademark_classification_nbr = '',Input_corp_trademark_first_use_date = '',Input_corp_trademark_first_use_date_in_state = '',Input_corp_trademark_business_mark_type = '',Input_corp_trademark_cancelled_date = '',Input_corp_trademark_class_desc1 = '',Input_corp_trademark_class_desc2 = '',Input_corp_trademark_class_desc3 = '',Input_corp_trademark_class_desc4 = '',Input_corp_trademark_class_desc5 = '',Input_corp_trademark_class_desc6 = '',Input_corp_trademark_disclaimer1 = '',Input_corp_trademark_disclaimer2 = '',Input_corp_trademark_expiration_date = '',Input_corp_trademark_filing_date = '',Input_corp_trademark_keywords = '',Input_corp_trademark_logo = '',Input_corp_trademark_name_expiration_date = '',Input_corp_trademark_nbr = '',Input_corp_trademark_renewal_date = '',Input_corp_trademark_status = '',Input_corp_trademark_used_1 = '',Input_corp_trademark_used_2 = '',Input_corp_trademark_used_3 = '',Input_cont_owner_percentage = '',Input_cont_country = '',Input_cont_country_mailing = '',Input_cont_nondislosure = '',Input_cont_prep_addr_line1 = '',Input_cont_prep_addr_last_line = '',Input_recordorigin = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Corp2_Mapping_MI_Main;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_first_reported = (TYPEOF(le.Input_dt_vendor_first_reported))'','',':dt_vendor_first_reported')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_last_reported = (TYPEOF(le.Input_dt_vendor_last_reported))'','',':dt_vendor_last_reported')
    #END
 
+    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
 
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
 
+    #IF( #TEXT(Input_corp_ra_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_dt_first_seen = (TYPEOF(le.Input_corp_ra_dt_first_seen))'','',':corp_ra_dt_first_seen')
    #END
 
+    #IF( #TEXT(Input_corp_ra_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_dt_last_seen = (TYPEOF(le.Input_corp_ra_dt_last_seen))'','',':corp_ra_dt_last_seen')
    #END
 
+    #IF( #TEXT(Input_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_corp_key = (TYPEOF(le.Input_corp_key))'','',':corp_key')
    #END
 
+    #IF( #TEXT(Input_corp_supp_key)='' )
      '' 
    #ELSE
        IF( le.Input_corp_supp_key = (TYPEOF(le.Input_corp_supp_key))'','',':corp_supp_key')
    #END
 
+    #IF( #TEXT(Input_corp_vendor)='' )
      '' 
    #ELSE
        IF( le.Input_corp_vendor = (TYPEOF(le.Input_corp_vendor))'','',':corp_vendor')
    #END
 
+    #IF( #TEXT(Input_corp_vendor_county)='' )
      '' 
    #ELSE
        IF( le.Input_corp_vendor_county = (TYPEOF(le.Input_corp_vendor_county))'','',':corp_vendor_county')
    #END
 
+    #IF( #TEXT(Input_corp_vendor_subcode)='' )
      '' 
    #ELSE
        IF( le.Input_corp_vendor_subcode = (TYPEOF(le.Input_corp_vendor_subcode))'','',':corp_vendor_subcode')
    #END
 
+    #IF( #TEXT(Input_corp_state_origin)='' )
      '' 
    #ELSE
        IF( le.Input_corp_state_origin = (TYPEOF(le.Input_corp_state_origin))'','',':corp_state_origin')
    #END
 
+    #IF( #TEXT(Input_corp_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_process_date = (TYPEOF(le.Input_corp_process_date))'','',':corp_process_date')
    #END
 
+    #IF( #TEXT(Input_corp_orig_sos_charter_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_orig_sos_charter_nbr = (TYPEOF(le.Input_corp_orig_sos_charter_nbr))'','',':corp_orig_sos_charter_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_legal_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_legal_name = (TYPEOF(le.Input_corp_legal_name))'','',':corp_legal_name')
    #END
 
+    #IF( #TEXT(Input_corp_ln_name_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ln_name_type_cd = (TYPEOF(le.Input_corp_ln_name_type_cd))'','',':corp_ln_name_type_cd')
    #END
 
+    #IF( #TEXT(Input_corp_ln_name_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ln_name_type_desc = (TYPEOF(le.Input_corp_ln_name_type_desc))'','',':corp_ln_name_type_desc')
    #END
 
+    #IF( #TEXT(Input_corp_supp_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_supp_nbr = (TYPEOF(le.Input_corp_supp_nbr))'','',':corp_supp_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_name_comment)='' )
      '' 
    #ELSE
        IF( le.Input_corp_name_comment = (TYPEOF(le.Input_corp_name_comment))'','',':corp_name_comment')
    #END
 
+    #IF( #TEXT(Input_corp_address1_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address1_type_cd = (TYPEOF(le.Input_corp_address1_type_cd))'','',':corp_address1_type_cd')
    #END
 
+    #IF( #TEXT(Input_corp_address1_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address1_type_desc = (TYPEOF(le.Input_corp_address1_type_desc))'','',':corp_address1_type_desc')
    #END
 
+    #IF( #TEXT(Input_corp_address1_line1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address1_line1 = (TYPEOF(le.Input_corp_address1_line1))'','',':corp_address1_line1')
    #END
 
+    #IF( #TEXT(Input_corp_address1_line2)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address1_line2 = (TYPEOF(le.Input_corp_address1_line2))'','',':corp_address1_line2')
    #END
 
+    #IF( #TEXT(Input_corp_address1_line3)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address1_line3 = (TYPEOF(le.Input_corp_address1_line3))'','',':corp_address1_line3')
    #END
 
+    #IF( #TEXT(Input_corp_address1_effective_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address1_effective_date = (TYPEOF(le.Input_corp_address1_effective_date))'','',':corp_address1_effective_date')
    #END
 
+    #IF( #TEXT(Input_corp_address2_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address2_type_cd = (TYPEOF(le.Input_corp_address2_type_cd))'','',':corp_address2_type_cd')
    #END
 
+    #IF( #TEXT(Input_corp_address2_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address2_type_desc = (TYPEOF(le.Input_corp_address2_type_desc))'','',':corp_address2_type_desc')
    #END
 
+    #IF( #TEXT(Input_corp_address2_line1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address2_line1 = (TYPEOF(le.Input_corp_address2_line1))'','',':corp_address2_line1')
    #END
 
+    #IF( #TEXT(Input_corp_address2_line2)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address2_line2 = (TYPEOF(le.Input_corp_address2_line2))'','',':corp_address2_line2')
    #END
 
+    #IF( #TEXT(Input_corp_address2_line3)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address2_line3 = (TYPEOF(le.Input_corp_address2_line3))'','',':corp_address2_line3')
    #END
 
+    #IF( #TEXT(Input_corp_address2_effective_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address2_effective_date = (TYPEOF(le.Input_corp_address2_effective_date))'','',':corp_address2_effective_date')
    #END
 
+    #IF( #TEXT(Input_corp_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_corp_phone_number = (TYPEOF(le.Input_corp_phone_number))'','',':corp_phone_number')
    #END
 
+    #IF( #TEXT(Input_corp_phone_number_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_phone_number_type_cd = (TYPEOF(le.Input_corp_phone_number_type_cd))'','',':corp_phone_number_type_cd')
    #END
 
+    #IF( #TEXT(Input_corp_phone_number_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_phone_number_type_desc = (TYPEOF(le.Input_corp_phone_number_type_desc))'','',':corp_phone_number_type_desc')
    #END
 
+    #IF( #TEXT(Input_corp_fax_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_fax_nbr = (TYPEOF(le.Input_corp_fax_nbr))'','',':corp_fax_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_email_address)='' )
      '' 
    #ELSE
        IF( le.Input_corp_email_address = (TYPEOF(le.Input_corp_email_address))'','',':corp_email_address')
    #END
 
+    #IF( #TEXT(Input_corp_web_address)='' )
      '' 
    #ELSE
        IF( le.Input_corp_web_address = (TYPEOF(le.Input_corp_web_address))'','',':corp_web_address')
    #END
 
+    #IF( #TEXT(Input_corp_filing_reference_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_filing_reference_nbr = (TYPEOF(le.Input_corp_filing_reference_nbr))'','',':corp_filing_reference_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_filing_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_filing_date = (TYPEOF(le.Input_corp_filing_date))'','',':corp_filing_date')
    #END
 
+    #IF( #TEXT(Input_corp_filing_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_filing_cd = (TYPEOF(le.Input_corp_filing_cd))'','',':corp_filing_cd')
    #END
 
+    #IF( #TEXT(Input_corp_filing_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_filing_desc = (TYPEOF(le.Input_corp_filing_desc))'','',':corp_filing_desc')
    #END
 
+    #IF( #TEXT(Input_corp_status_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_status_cd = (TYPEOF(le.Input_corp_status_cd))'','',':corp_status_cd')
    #END
 
+    #IF( #TEXT(Input_corp_status_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_status_desc = (TYPEOF(le.Input_corp_status_desc))'','',':corp_status_desc')
    #END
 
+    #IF( #TEXT(Input_corp_status_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_status_date = (TYPEOF(le.Input_corp_status_date))'','',':corp_status_date')
    #END
 
+    #IF( #TEXT(Input_corp_standing)='' )
      '' 
    #ELSE
        IF( le.Input_corp_standing = (TYPEOF(le.Input_corp_standing))'','',':corp_standing')
    #END
 
+    #IF( #TEXT(Input_corp_status_comment)='' )
      '' 
    #ELSE
        IF( le.Input_corp_status_comment = (TYPEOF(le.Input_corp_status_comment))'','',':corp_status_comment')
    #END
 
+    #IF( #TEXT(Input_corp_ticker_symbol)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ticker_symbol = (TYPEOF(le.Input_corp_ticker_symbol))'','',':corp_ticker_symbol')
    #END
 
+    #IF( #TEXT(Input_corp_stock_exchange)='' )
      '' 
    #ELSE
        IF( le.Input_corp_stock_exchange = (TYPEOF(le.Input_corp_stock_exchange))'','',':corp_stock_exchange')
    #END
 
+    #IF( #TEXT(Input_corp_inc_state)='' )
      '' 
    #ELSE
        IF( le.Input_corp_inc_state = (TYPEOF(le.Input_corp_inc_state))'','',':corp_inc_state')
    #END
 
+    #IF( #TEXT(Input_corp_inc_county)='' )
      '' 
    #ELSE
        IF( le.Input_corp_inc_county = (TYPEOF(le.Input_corp_inc_county))'','',':corp_inc_county')
    #END
 
+    #IF( #TEXT(Input_corp_inc_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_inc_date = (TYPEOF(le.Input_corp_inc_date))'','',':corp_inc_date')
    #END
 
+    #IF( #TEXT(Input_corp_anniversary_month)='' )
      '' 
    #ELSE
        IF( le.Input_corp_anniversary_month = (TYPEOF(le.Input_corp_anniversary_month))'','',':corp_anniversary_month')
    #END
 
+    #IF( #TEXT(Input_corp_fed_tax_id)='' )
      '' 
    #ELSE
        IF( le.Input_corp_fed_tax_id = (TYPEOF(le.Input_corp_fed_tax_id))'','',':corp_fed_tax_id')
    #END
 
+    #IF( #TEXT(Input_corp_state_tax_id)='' )
      '' 
    #ELSE
        IF( le.Input_corp_state_tax_id = (TYPEOF(le.Input_corp_state_tax_id))'','',':corp_state_tax_id')
    #END
 
+    #IF( #TEXT(Input_corp_term_exist_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_term_exist_cd = (TYPEOF(le.Input_corp_term_exist_cd))'','',':corp_term_exist_cd')
    #END
 
+    #IF( #TEXT(Input_corp_term_exist_exp)='' )
      '' 
    #ELSE
        IF( le.Input_corp_term_exist_exp = (TYPEOF(le.Input_corp_term_exist_exp))'','',':corp_term_exist_exp')
    #END
 
+    #IF( #TEXT(Input_corp_term_exist_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_term_exist_desc = (TYPEOF(le.Input_corp_term_exist_desc))'','',':corp_term_exist_desc')
    #END
 
+    #IF( #TEXT(Input_corp_foreign_domestic_ind)='' )
      '' 
    #ELSE
        IF( le.Input_corp_foreign_domestic_ind = (TYPEOF(le.Input_corp_foreign_domestic_ind))'','',':corp_foreign_domestic_ind')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_state_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_state_cd = (TYPEOF(le.Input_corp_forgn_state_cd))'','',':corp_forgn_state_cd')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_state_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_state_desc = (TYPEOF(le.Input_corp_forgn_state_desc))'','',':corp_forgn_state_desc')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_sos_charter_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_sos_charter_nbr = (TYPEOF(le.Input_corp_forgn_sos_charter_nbr))'','',':corp_forgn_sos_charter_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_date = (TYPEOF(le.Input_corp_forgn_date))'','',':corp_forgn_date')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_fed_tax_id)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_fed_tax_id = (TYPEOF(le.Input_corp_forgn_fed_tax_id))'','',':corp_forgn_fed_tax_id')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_state_tax_id)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_state_tax_id = (TYPEOF(le.Input_corp_forgn_state_tax_id))'','',':corp_forgn_state_tax_id')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_term_exist_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_term_exist_cd = (TYPEOF(le.Input_corp_forgn_term_exist_cd))'','',':corp_forgn_term_exist_cd')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_term_exist_exp)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_term_exist_exp = (TYPEOF(le.Input_corp_forgn_term_exist_exp))'','',':corp_forgn_term_exist_exp')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_term_exist_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_term_exist_desc = (TYPEOF(le.Input_corp_forgn_term_exist_desc))'','',':corp_forgn_term_exist_desc')
    #END
 
+    #IF( #TEXT(Input_corp_orig_org_structure_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_orig_org_structure_cd = (TYPEOF(le.Input_corp_orig_org_structure_cd))'','',':corp_orig_org_structure_cd')
    #END
 
+    #IF( #TEXT(Input_corp_orig_org_structure_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_orig_org_structure_desc = (TYPEOF(le.Input_corp_orig_org_structure_desc))'','',':corp_orig_org_structure_desc')
    #END
 
+    #IF( #TEXT(Input_corp_for_profit_ind)='' )
      '' 
    #ELSE
        IF( le.Input_corp_for_profit_ind = (TYPEOF(le.Input_corp_for_profit_ind))'','',':corp_for_profit_ind')
    #END
 
+    #IF( #TEXT(Input_corp_public_or_private_ind)='' )
      '' 
    #ELSE
        IF( le.Input_corp_public_or_private_ind = (TYPEOF(le.Input_corp_public_or_private_ind))'','',':corp_public_or_private_ind')
    #END
 
+    #IF( #TEXT(Input_corp_sic_code)='' )
      '' 
    #ELSE
        IF( le.Input_corp_sic_code = (TYPEOF(le.Input_corp_sic_code))'','',':corp_sic_code')
    #END
 
+    #IF( #TEXT(Input_corp_naic_code)='' )
      '' 
    #ELSE
        IF( le.Input_corp_naic_code = (TYPEOF(le.Input_corp_naic_code))'','',':corp_naic_code')
    #END
 
+    #IF( #TEXT(Input_corp_orig_bus_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_orig_bus_type_cd = (TYPEOF(le.Input_corp_orig_bus_type_cd))'','',':corp_orig_bus_type_cd')
    #END
 
+    #IF( #TEXT(Input_corp_orig_bus_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_orig_bus_type_desc = (TYPEOF(le.Input_corp_orig_bus_type_desc))'','',':corp_orig_bus_type_desc')
    #END
 
+    #IF( #TEXT(Input_corp_entity_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_entity_desc = (TYPEOF(le.Input_corp_entity_desc))'','',':corp_entity_desc')
    #END
 
+    #IF( #TEXT(Input_corp_certificate_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_certificate_nbr = (TYPEOF(le.Input_corp_certificate_nbr))'','',':corp_certificate_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_internal_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_internal_nbr = (TYPEOF(le.Input_corp_internal_nbr))'','',':corp_internal_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_previous_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_previous_nbr = (TYPEOF(le.Input_corp_previous_nbr))'','',':corp_previous_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_microfilm_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_microfilm_nbr = (TYPEOF(le.Input_corp_microfilm_nbr))'','',':corp_microfilm_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_amendments_filed)='' )
      '' 
    #ELSE
        IF( le.Input_corp_amendments_filed = (TYPEOF(le.Input_corp_amendments_filed))'','',':corp_amendments_filed')
    #END
 
+    #IF( #TEXT(Input_corp_acts)='' )
      '' 
    #ELSE
        IF( le.Input_corp_acts = (TYPEOF(le.Input_corp_acts))'','',':corp_acts')
    #END
 
+    #IF( #TEXT(Input_corp_partnership_ind)='' )
      '' 
    #ELSE
        IF( le.Input_corp_partnership_ind = (TYPEOF(le.Input_corp_partnership_ind))'','',':corp_partnership_ind')
    #END
 
+    #IF( #TEXT(Input_corp_mfg_ind)='' )
      '' 
    #ELSE
        IF( le.Input_corp_mfg_ind = (TYPEOF(le.Input_corp_mfg_ind))'','',':corp_mfg_ind')
    #END
 
+    #IF( #TEXT(Input_corp_addl_info)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addl_info = (TYPEOF(le.Input_corp_addl_info))'','',':corp_addl_info')
    #END
 
+    #IF( #TEXT(Input_corp_taxes)='' )
      '' 
    #ELSE
        IF( le.Input_corp_taxes = (TYPEOF(le.Input_corp_taxes))'','',':corp_taxes')
    #END
 
+    #IF( #TEXT(Input_corp_franchise_taxes)='' )
      '' 
    #ELSE
        IF( le.Input_corp_franchise_taxes = (TYPEOF(le.Input_corp_franchise_taxes))'','',':corp_franchise_taxes')
    #END
 
+    #IF( #TEXT(Input_corp_tax_program_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_tax_program_cd = (TYPEOF(le.Input_corp_tax_program_cd))'','',':corp_tax_program_cd')
    #END
 
+    #IF( #TEXT(Input_corp_tax_program_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_tax_program_desc = (TYPEOF(le.Input_corp_tax_program_desc))'','',':corp_tax_program_desc')
    #END
 
+    #IF( #TEXT(Input_corp_ra_full_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_full_name = (TYPEOF(le.Input_corp_ra_full_name))'','',':corp_ra_full_name')
    #END
 
+    #IF( #TEXT(Input_corp_ra_fname)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_fname = (TYPEOF(le.Input_corp_ra_fname))'','',':corp_ra_fname')
    #END
 
+    #IF( #TEXT(Input_corp_ra_mname)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_mname = (TYPEOF(le.Input_corp_ra_mname))'','',':corp_ra_mname')
    #END
 
+    #IF( #TEXT(Input_corp_ra_lname)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_lname = (TYPEOF(le.Input_corp_ra_lname))'','',':corp_ra_lname')
    #END
 
+    #IF( #TEXT(Input_corp_ra_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_suffix = (TYPEOF(le.Input_corp_ra_suffix))'','',':corp_ra_suffix')
    #END
 
+    #IF( #TEXT(Input_corp_ra_title_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_title_cd = (TYPEOF(le.Input_corp_ra_title_cd))'','',':corp_ra_title_cd')
    #END
 
+    #IF( #TEXT(Input_corp_ra_title_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_title_desc = (TYPEOF(le.Input_corp_ra_title_desc))'','',':corp_ra_title_desc')
    #END
 
+    #IF( #TEXT(Input_corp_ra_fein)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_fein = (TYPEOF(le.Input_corp_ra_fein))'','',':corp_ra_fein')
    #END
 
+    #IF( #TEXT(Input_corp_ra_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_ssn = (TYPEOF(le.Input_corp_ra_ssn))'','',':corp_ra_ssn')
    #END
 
+    #IF( #TEXT(Input_corp_ra_dob)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_dob = (TYPEOF(le.Input_corp_ra_dob))'','',':corp_ra_dob')
    #END
 
+    #IF( #TEXT(Input_corp_ra_effective_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_effective_date = (TYPEOF(le.Input_corp_ra_effective_date))'','',':corp_ra_effective_date')
    #END
 
+    #IF( #TEXT(Input_corp_ra_resign_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_resign_date = (TYPEOF(le.Input_corp_ra_resign_date))'','',':corp_ra_resign_date')
    #END
 
+    #IF( #TEXT(Input_corp_ra_no_comp)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_no_comp = (TYPEOF(le.Input_corp_ra_no_comp))'','',':corp_ra_no_comp')
    #END
 
+    #IF( #TEXT(Input_corp_ra_no_comp_igs)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_no_comp_igs = (TYPEOF(le.Input_corp_ra_no_comp_igs))'','',':corp_ra_no_comp_igs')
    #END
 
+    #IF( #TEXT(Input_corp_ra_addl_info)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_addl_info = (TYPEOF(le.Input_corp_ra_addl_info))'','',':corp_ra_addl_info')
    #END
 
+    #IF( #TEXT(Input_corp_ra_address_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_address_type_cd = (TYPEOF(le.Input_corp_ra_address_type_cd))'','',':corp_ra_address_type_cd')
    #END
 
+    #IF( #TEXT(Input_corp_ra_address_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_address_type_desc = (TYPEOF(le.Input_corp_ra_address_type_desc))'','',':corp_ra_address_type_desc')
    #END
 
+    #IF( #TEXT(Input_corp_ra_address_line1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_address_line1 = (TYPEOF(le.Input_corp_ra_address_line1))'','',':corp_ra_address_line1')
    #END
 
+    #IF( #TEXT(Input_corp_ra_address_line2)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_address_line2 = (TYPEOF(le.Input_corp_ra_address_line2))'','',':corp_ra_address_line2')
    #END
 
+    #IF( #TEXT(Input_corp_ra_address_line3)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_address_line3 = (TYPEOF(le.Input_corp_ra_address_line3))'','',':corp_ra_address_line3')
    #END
 
+    #IF( #TEXT(Input_corp_ra_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_phone_number = (TYPEOF(le.Input_corp_ra_phone_number))'','',':corp_ra_phone_number')
    #END
 
+    #IF( #TEXT(Input_corp_ra_phone_number_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_phone_number_type_cd = (TYPEOF(le.Input_corp_ra_phone_number_type_cd))'','',':corp_ra_phone_number_type_cd')
    #END
 
+    #IF( #TEXT(Input_corp_ra_phone_number_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_phone_number_type_desc = (TYPEOF(le.Input_corp_ra_phone_number_type_desc))'','',':corp_ra_phone_number_type_desc')
    #END
 
+    #IF( #TEXT(Input_corp_ra_fax_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_fax_nbr = (TYPEOF(le.Input_corp_ra_fax_nbr))'','',':corp_ra_fax_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_ra_email_address)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_email_address = (TYPEOF(le.Input_corp_ra_email_address))'','',':corp_ra_email_address')
    #END
 
+    #IF( #TEXT(Input_corp_ra_web_address)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_web_address = (TYPEOF(le.Input_corp_ra_web_address))'','',':corp_ra_web_address')
    #END
 
+    #IF( #TEXT(Input_corp_prep_addr1_line1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_prep_addr1_line1 = (TYPEOF(le.Input_corp_prep_addr1_line1))'','',':corp_prep_addr1_line1')
    #END
 
+    #IF( #TEXT(Input_corp_prep_addr1_last_line)='' )
      '' 
    #ELSE
        IF( le.Input_corp_prep_addr1_last_line = (TYPEOF(le.Input_corp_prep_addr1_last_line))'','',':corp_prep_addr1_last_line')
    #END
 
+    #IF( #TEXT(Input_corp_prep_addr2_line1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_prep_addr2_line1 = (TYPEOF(le.Input_corp_prep_addr2_line1))'','',':corp_prep_addr2_line1')
    #END
 
+    #IF( #TEXT(Input_corp_prep_addr2_last_line)='' )
      '' 
    #ELSE
        IF( le.Input_corp_prep_addr2_last_line = (TYPEOF(le.Input_corp_prep_addr2_last_line))'','',':corp_prep_addr2_last_line')
    #END
 
+    #IF( #TEXT(Input_ra_prep_addr_line1)='' )
      '' 
    #ELSE
        IF( le.Input_ra_prep_addr_line1 = (TYPEOF(le.Input_ra_prep_addr_line1))'','',':ra_prep_addr_line1')
    #END
 
+    #IF( #TEXT(Input_ra_prep_addr_last_line)='' )
      '' 
    #ELSE
        IF( le.Input_ra_prep_addr_last_line = (TYPEOF(le.Input_ra_prep_addr_last_line))'','',':ra_prep_addr_last_line')
    #END
 
+    #IF( #TEXT(Input_cont_filing_reference_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_cont_filing_reference_nbr = (TYPEOF(le.Input_cont_filing_reference_nbr))'','',':cont_filing_reference_nbr')
    #END
 
+    #IF( #TEXT(Input_cont_filing_date)='' )
      '' 
    #ELSE
        IF( le.Input_cont_filing_date = (TYPEOF(le.Input_cont_filing_date))'','',':cont_filing_date')
    #END
 
+    #IF( #TEXT(Input_cont_filing_cd)='' )
      '' 
    #ELSE
        IF( le.Input_cont_filing_cd = (TYPEOF(le.Input_cont_filing_cd))'','',':cont_filing_cd')
    #END
 
+    #IF( #TEXT(Input_cont_filing_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_filing_desc = (TYPEOF(le.Input_cont_filing_desc))'','',':cont_filing_desc')
    #END
 
+    #IF( #TEXT(Input_cont_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_cont_type_cd = (TYPEOF(le.Input_cont_type_cd))'','',':cont_type_cd')
    #END
 
+    #IF( #TEXT(Input_cont_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_type_desc = (TYPEOF(le.Input_cont_type_desc))'','',':cont_type_desc')
    #END
 
+    #IF( #TEXT(Input_cont_full_name)='' )
      '' 
    #ELSE
        IF( le.Input_cont_full_name = (TYPEOF(le.Input_cont_full_name))'','',':cont_full_name')
    #END
 
+    #IF( #TEXT(Input_cont_fname)='' )
      '' 
    #ELSE
        IF( le.Input_cont_fname = (TYPEOF(le.Input_cont_fname))'','',':cont_fname')
    #END
 
+    #IF( #TEXT(Input_cont_mname)='' )
      '' 
    #ELSE
        IF( le.Input_cont_mname = (TYPEOF(le.Input_cont_mname))'','',':cont_mname')
    #END
 
+    #IF( #TEXT(Input_cont_lname)='' )
      '' 
    #ELSE
        IF( le.Input_cont_lname = (TYPEOF(le.Input_cont_lname))'','',':cont_lname')
    #END
 
+    #IF( #TEXT(Input_cont_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_cont_suffix = (TYPEOF(le.Input_cont_suffix))'','',':cont_suffix')
    #END
 
+    #IF( #TEXT(Input_cont_title1_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_title1_desc = (TYPEOF(le.Input_cont_title1_desc))'','',':cont_title1_desc')
    #END
 
+    #IF( #TEXT(Input_cont_title2_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_title2_desc = (TYPEOF(le.Input_cont_title2_desc))'','',':cont_title2_desc')
    #END
 
+    #IF( #TEXT(Input_cont_title3_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_title3_desc = (TYPEOF(le.Input_cont_title3_desc))'','',':cont_title3_desc')
    #END
 
+    #IF( #TEXT(Input_cont_title4_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_title4_desc = (TYPEOF(le.Input_cont_title4_desc))'','',':cont_title4_desc')
    #END
 
+    #IF( #TEXT(Input_cont_title5_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_title5_desc = (TYPEOF(le.Input_cont_title5_desc))'','',':cont_title5_desc')
    #END
 
+    #IF( #TEXT(Input_cont_fein)='' )
      '' 
    #ELSE
        IF( le.Input_cont_fein = (TYPEOF(le.Input_cont_fein))'','',':cont_fein')
    #END
 
+    #IF( #TEXT(Input_cont_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_cont_ssn = (TYPEOF(le.Input_cont_ssn))'','',':cont_ssn')
    #END
 
+    #IF( #TEXT(Input_cont_dob)='' )
      '' 
    #ELSE
        IF( le.Input_cont_dob = (TYPEOF(le.Input_cont_dob))'','',':cont_dob')
    #END
 
+    #IF( #TEXT(Input_cont_status_cd)='' )
      '' 
    #ELSE
        IF( le.Input_cont_status_cd = (TYPEOF(le.Input_cont_status_cd))'','',':cont_status_cd')
    #END
 
+    #IF( #TEXT(Input_cont_status_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_status_desc = (TYPEOF(le.Input_cont_status_desc))'','',':cont_status_desc')
    #END
 
+    #IF( #TEXT(Input_cont_effective_date)='' )
      '' 
    #ELSE
        IF( le.Input_cont_effective_date = (TYPEOF(le.Input_cont_effective_date))'','',':cont_effective_date')
    #END
 
+    #IF( #TEXT(Input_cont_effective_cd)='' )
      '' 
    #ELSE
        IF( le.Input_cont_effective_cd = (TYPEOF(le.Input_cont_effective_cd))'','',':cont_effective_cd')
    #END
 
+    #IF( #TEXT(Input_cont_effective_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_effective_desc = (TYPEOF(le.Input_cont_effective_desc))'','',':cont_effective_desc')
    #END
 
+    #IF( #TEXT(Input_cont_addl_info)='' )
      '' 
    #ELSE
        IF( le.Input_cont_addl_info = (TYPEOF(le.Input_cont_addl_info))'','',':cont_addl_info')
    #END
 
+    #IF( #TEXT(Input_cont_address_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_cont_address_type_cd = (TYPEOF(le.Input_cont_address_type_cd))'','',':cont_address_type_cd')
    #END
 
+    #IF( #TEXT(Input_cont_address_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_address_type_desc = (TYPEOF(le.Input_cont_address_type_desc))'','',':cont_address_type_desc')
    #END
 
+    #IF( #TEXT(Input_cont_address_line1)='' )
      '' 
    #ELSE
        IF( le.Input_cont_address_line1 = (TYPEOF(le.Input_cont_address_line1))'','',':cont_address_line1')
    #END
 
+    #IF( #TEXT(Input_cont_address_line2)='' )
      '' 
    #ELSE
        IF( le.Input_cont_address_line2 = (TYPEOF(le.Input_cont_address_line2))'','',':cont_address_line2')
    #END
 
+    #IF( #TEXT(Input_cont_address_line3)='' )
      '' 
    #ELSE
        IF( le.Input_cont_address_line3 = (TYPEOF(le.Input_cont_address_line3))'','',':cont_address_line3')
    #END
 
+    #IF( #TEXT(Input_cont_address_effective_date)='' )
      '' 
    #ELSE
        IF( le.Input_cont_address_effective_date = (TYPEOF(le.Input_cont_address_effective_date))'','',':cont_address_effective_date')
    #END
 
+    #IF( #TEXT(Input_cont_address_county)='' )
      '' 
    #ELSE
        IF( le.Input_cont_address_county = (TYPEOF(le.Input_cont_address_county))'','',':cont_address_county')
    #END
 
+    #IF( #TEXT(Input_cont_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_cont_phone_number = (TYPEOF(le.Input_cont_phone_number))'','',':cont_phone_number')
    #END
 
+    #IF( #TEXT(Input_cont_phone_number_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_cont_phone_number_type_cd = (TYPEOF(le.Input_cont_phone_number_type_cd))'','',':cont_phone_number_type_cd')
    #END
 
+    #IF( #TEXT(Input_cont_phone_number_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_phone_number_type_desc = (TYPEOF(le.Input_cont_phone_number_type_desc))'','',':cont_phone_number_type_desc')
    #END
 
+    #IF( #TEXT(Input_cont_fax_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_cont_fax_nbr = (TYPEOF(le.Input_cont_fax_nbr))'','',':cont_fax_nbr')
    #END
 
+    #IF( #TEXT(Input_cont_email_address)='' )
      '' 
    #ELSE
        IF( le.Input_cont_email_address = (TYPEOF(le.Input_cont_email_address))'','',':cont_email_address')
    #END
 
+    #IF( #TEXT(Input_cont_web_address)='' )
      '' 
    #ELSE
        IF( le.Input_cont_web_address = (TYPEOF(le.Input_cont_web_address))'','',':cont_web_address')
    #END
 
+    #IF( #TEXT(Input_corp_acres)='' )
      '' 
    #ELSE
        IF( le.Input_corp_acres = (TYPEOF(le.Input_corp_acres))'','',':corp_acres')
    #END
 
+    #IF( #TEXT(Input_corp_action)='' )
      '' 
    #ELSE
        IF( le.Input_corp_action = (TYPEOF(le.Input_corp_action))'','',':corp_action')
    #END
 
+    #IF( #TEXT(Input_corp_action_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_action_date = (TYPEOF(le.Input_corp_action_date))'','',':corp_action_date')
    #END
 
+    #IF( #TEXT(Input_corp_action_employment_security_approval_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_action_employment_security_approval_date = (TYPEOF(le.Input_corp_action_employment_security_approval_date))'','',':corp_action_employment_security_approval_date')
    #END
 
+    #IF( #TEXT(Input_corp_action_pending_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_action_pending_cd = (TYPEOF(le.Input_corp_action_pending_cd))'','',':corp_action_pending_cd')
    #END
 
+    #IF( #TEXT(Input_corp_action_pending_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_action_pending_desc = (TYPEOF(le.Input_corp_action_pending_desc))'','',':corp_action_pending_desc')
    #END
 
+    #IF( #TEXT(Input_corp_action_statement_of_intent_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_action_statement_of_intent_date = (TYPEOF(le.Input_corp_action_statement_of_intent_date))'','',':corp_action_statement_of_intent_date')
    #END
 
+    #IF( #TEXT(Input_corp_action_tax_dept_approval_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_action_tax_dept_approval_date = (TYPEOF(le.Input_corp_action_tax_dept_approval_date))'','',':corp_action_tax_dept_approval_date')
    #END
 
+    #IF( #TEXT(Input_corp_acts2)='' )
      '' 
    #ELSE
        IF( le.Input_corp_acts2 = (TYPEOF(le.Input_corp_acts2))'','',':corp_acts2')
    #END
 
+    #IF( #TEXT(Input_corp_acts3)='' )
      '' 
    #ELSE
        IF( le.Input_corp_acts3 = (TYPEOF(le.Input_corp_acts3))'','',':corp_acts3')
    #END
 
+    #IF( #TEXT(Input_corp_additional_principals)='' )
      '' 
    #ELSE
        IF( le.Input_corp_additional_principals = (TYPEOF(le.Input_corp_additional_principals))'','',':corp_additional_principals')
    #END
 
+    #IF( #TEXT(Input_corp_address_office_type)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address_office_type = (TYPEOF(le.Input_corp_address_office_type))'','',':corp_address_office_type')
    #END
 
+    #IF( #TEXT(Input_corp_agent_commercial)='' )
      '' 
    #ELSE
        IF( le.Input_corp_agent_commercial = (TYPEOF(le.Input_corp_agent_commercial))'','',':corp_agent_commercial')
    #END
 
+    #IF( #TEXT(Input_corp_agent_country)='' )
      '' 
    #ELSE
        IF( le.Input_corp_agent_country = (TYPEOF(le.Input_corp_agent_country))'','',':corp_agent_country')
    #END
 
+    #IF( #TEXT(Input_corp_agent_county)='' )
      '' 
    #ELSE
        IF( le.Input_corp_agent_county = (TYPEOF(le.Input_corp_agent_county))'','',':corp_agent_county')
    #END
 
+    #IF( #TEXT(Input_corp_agent_status_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_agent_status_cd = (TYPEOF(le.Input_corp_agent_status_cd))'','',':corp_agent_status_cd')
    #END
 
+    #IF( #TEXT(Input_corp_agent_status_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_agent_status_desc = (TYPEOF(le.Input_corp_agent_status_desc))'','',':corp_agent_status_desc')
    #END
 
+    #IF( #TEXT(Input_corp_agent_id)='' )
      '' 
    #ELSE
        IF( le.Input_corp_agent_id = (TYPEOF(le.Input_corp_agent_id))'','',':corp_agent_id')
    #END
 
+    #IF( #TEXT(Input_corp_agent_assign_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_agent_assign_date = (TYPEOF(le.Input_corp_agent_assign_date))'','',':corp_agent_assign_date')
    #END
 
+    #IF( #TEXT(Input_corp_agriculture_flag)='' )
      '' 
    #ELSE
        IF( le.Input_corp_agriculture_flag = (TYPEOF(le.Input_corp_agriculture_flag))'','',':corp_agriculture_flag')
    #END
 
+    #IF( #TEXT(Input_corp_authorized_partners)='' )
      '' 
    #ELSE
        IF( le.Input_corp_authorized_partners = (TYPEOF(le.Input_corp_authorized_partners))'','',':corp_authorized_partners')
    #END
 
+    #IF( #TEXT(Input_corp_comment)='' )
      '' 
    #ELSE
        IF( le.Input_corp_comment = (TYPEOF(le.Input_corp_comment))'','',':corp_comment')
    #END
 
+    #IF( #TEXT(Input_corp_consent_flag_for_protected_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_consent_flag_for_protected_name = (TYPEOF(le.Input_corp_consent_flag_for_protected_name))'','',':corp_consent_flag_for_protected_name')
    #END
 
+    #IF( #TEXT(Input_corp_converted)='' )
      '' 
    #ELSE
        IF( le.Input_corp_converted = (TYPEOF(le.Input_corp_converted))'','',':corp_converted')
    #END
 
+    #IF( #TEXT(Input_corp_converted_from)='' )
      '' 
    #ELSE
        IF( le.Input_corp_converted_from = (TYPEOF(le.Input_corp_converted_from))'','',':corp_converted_from')
    #END
 
+    #IF( #TEXT(Input_corp_country_of_formation)='' )
      '' 
    #ELSE
        IF( le.Input_corp_country_of_formation = (TYPEOF(le.Input_corp_country_of_formation))'','',':corp_country_of_formation')
    #END
 
+    #IF( #TEXT(Input_corp_date_of_organization_meeting)='' )
      '' 
    #ELSE
        IF( le.Input_corp_date_of_organization_meeting = (TYPEOF(le.Input_corp_date_of_organization_meeting))'','',':corp_date_of_organization_meeting')
    #END
 
+    #IF( #TEXT(Input_corp_delayed_effective_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_delayed_effective_date = (TYPEOF(le.Input_corp_delayed_effective_date))'','',':corp_delayed_effective_date')
    #END
 
+    #IF( #TEXT(Input_corp_directors_from_to)='' )
      '' 
    #ELSE
        IF( le.Input_corp_directors_from_to = (TYPEOF(le.Input_corp_directors_from_to))'','',':corp_directors_from_to')
    #END
 
+    #IF( #TEXT(Input_corp_dissolved_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_dissolved_date = (TYPEOF(le.Input_corp_dissolved_date))'','',':corp_dissolved_date')
    #END
 
+    #IF( #TEXT(Input_corp_farm_exemptions)='' )
      '' 
    #ELSE
        IF( le.Input_corp_farm_exemptions = (TYPEOF(le.Input_corp_farm_exemptions))'','',':corp_farm_exemptions')
    #END
 
+    #IF( #TEXT(Input_corp_farm_qual_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_farm_qual_date = (TYPEOF(le.Input_corp_farm_qual_date))'','',':corp_farm_qual_date')
    #END
 
+    #IF( #TEXT(Input_corp_farm_status_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_farm_status_cd = (TYPEOF(le.Input_corp_farm_status_cd))'','',':corp_farm_status_cd')
    #END
 
+    #IF( #TEXT(Input_corp_farm_status_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_farm_status_desc = (TYPEOF(le.Input_corp_farm_status_desc))'','',':corp_farm_status_desc')
    #END
 
+    #IF( #TEXT(Input_corp_farm_status_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_farm_status_date = (TYPEOF(le.Input_corp_farm_status_date))'','',':corp_farm_status_date')
    #END
 
+    #IF( #TEXT(Input_corp_fiscal_year_month)='' )
      '' 
    #ELSE
        IF( le.Input_corp_fiscal_year_month = (TYPEOF(le.Input_corp_fiscal_year_month))'','',':corp_fiscal_year_month')
    #END
 
+    #IF( #TEXT(Input_corp_foreign_fiduciary_capacity_in_state)='' )
      '' 
    #ELSE
        IF( le.Input_corp_foreign_fiduciary_capacity_in_state = (TYPEOF(le.Input_corp_foreign_fiduciary_capacity_in_state))'','',':corp_foreign_fiduciary_capacity_in_state')
    #END
 
+    #IF( #TEXT(Input_corp_governing_statute)='' )
      '' 
    #ELSE
        IF( le.Input_corp_governing_statute = (TYPEOF(le.Input_corp_governing_statute))'','',':corp_governing_statute')
    #END
 
+    #IF( #TEXT(Input_corp_has_members)='' )
      '' 
    #ELSE
        IF( le.Input_corp_has_members = (TYPEOF(le.Input_corp_has_members))'','',':corp_has_members')
    #END
 
+    #IF( #TEXT(Input_corp_has_vested_managers)='' )
      '' 
    #ELSE
        IF( le.Input_corp_has_vested_managers = (TYPEOF(le.Input_corp_has_vested_managers))'','',':corp_has_vested_managers')
    #END
 
+    #IF( #TEXT(Input_corp_home_incorporated_county)='' )
      '' 
    #ELSE
        IF( le.Input_corp_home_incorporated_county = (TYPEOF(le.Input_corp_home_incorporated_county))'','',':corp_home_incorporated_county')
    #END
 
+    #IF( #TEXT(Input_corp_home_state_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_home_state_name = (TYPEOF(le.Input_corp_home_state_name))'','',':corp_home_state_name')
    #END
 
+    #IF( #TEXT(Input_corp_is_professional)='' )
      '' 
    #ELSE
        IF( le.Input_corp_is_professional = (TYPEOF(le.Input_corp_is_professional))'','',':corp_is_professional')
    #END
 
+    #IF( #TEXT(Input_corp_is_non_profit_irs_approved)='' )
      '' 
    #ELSE
        IF( le.Input_corp_is_non_profit_irs_approved = (TYPEOF(le.Input_corp_is_non_profit_irs_approved))'','',':corp_is_non_profit_irs_approved')
    #END
 
+    #IF( #TEXT(Input_corp_last_renewal_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_last_renewal_date = (TYPEOF(le.Input_corp_last_renewal_date))'','',':corp_last_renewal_date')
    #END
 
+    #IF( #TEXT(Input_corp_last_renewal_year)='' )
      '' 
    #ELSE
        IF( le.Input_corp_last_renewal_year = (TYPEOF(le.Input_corp_last_renewal_year))'','',':corp_last_renewal_year')
    #END
 
+    #IF( #TEXT(Input_corp_license_type)='' )
      '' 
    #ELSE
        IF( le.Input_corp_license_type = (TYPEOF(le.Input_corp_license_type))'','',':corp_license_type')
    #END
 
+    #IF( #TEXT(Input_corp_llc_managed_ind)='' )
      '' 
    #ELSE
        IF( le.Input_corp_llc_managed_ind = (TYPEOF(le.Input_corp_llc_managed_ind))'','',':corp_llc_managed_ind')
    #END
 
+    #IF( #TEXT(Input_corp_llc_managed_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_llc_managed_desc = (TYPEOF(le.Input_corp_llc_managed_desc))'','',':corp_llc_managed_desc')
    #END
 
+    #IF( #TEXT(Input_corp_management_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_management_desc = (TYPEOF(le.Input_corp_management_desc))'','',':corp_management_desc')
    #END
 
+    #IF( #TEXT(Input_corp_management_type)='' )
      '' 
    #ELSE
        IF( le.Input_corp_management_type = (TYPEOF(le.Input_corp_management_type))'','',':corp_management_type')
    #END
 
+    #IF( #TEXT(Input_corp_manager_managed)='' )
      '' 
    #ELSE
        IF( le.Input_corp_manager_managed = (TYPEOF(le.Input_corp_manager_managed))'','',':corp_manager_managed')
    #END
 
+    #IF( #TEXT(Input_corp_merged_corporation_id)='' )
      '' 
    #ELSE
        IF( le.Input_corp_merged_corporation_id = (TYPEOF(le.Input_corp_merged_corporation_id))'','',':corp_merged_corporation_id')
    #END
 
+    #IF( #TEXT(Input_corp_merged_fein)='' )
      '' 
    #ELSE
        IF( le.Input_corp_merged_fein = (TYPEOF(le.Input_corp_merged_fein))'','',':corp_merged_fein')
    #END
 
+    #IF( #TEXT(Input_corp_merger_allowed_flag)='' )
      '' 
    #ELSE
        IF( le.Input_corp_merger_allowed_flag = (TYPEOF(le.Input_corp_merger_allowed_flag))'','',':corp_merger_allowed_flag')
    #END
 
+    #IF( #TEXT(Input_corp_merger_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_merger_date = (TYPEOF(le.Input_corp_merger_date))'','',':corp_merger_date')
    #END
 
+    #IF( #TEXT(Input_corp_merger_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_merger_desc = (TYPEOF(le.Input_corp_merger_desc))'','',':corp_merger_desc')
    #END
 
+    #IF( #TEXT(Input_corp_merger_effective_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_merger_effective_date = (TYPEOF(le.Input_corp_merger_effective_date))'','',':corp_merger_effective_date')
    #END
 
+    #IF( #TEXT(Input_corp_merger_id)='' )
      '' 
    #ELSE
        IF( le.Input_corp_merger_id = (TYPEOF(le.Input_corp_merger_id))'','',':corp_merger_id')
    #END
 
+    #IF( #TEXT(Input_corp_merger_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_corp_merger_indicator = (TYPEOF(le.Input_corp_merger_indicator))'','',':corp_merger_indicator')
    #END
 
+    #IF( #TEXT(Input_corp_merger_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_merger_name = (TYPEOF(le.Input_corp_merger_name))'','',':corp_merger_name')
    #END
 
+    #IF( #TEXT(Input_corp_merger_type_converted_to_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_merger_type_converted_to_cd = (TYPEOF(le.Input_corp_merger_type_converted_to_cd))'','',':corp_merger_type_converted_to_cd')
    #END
 
+    #IF( #TEXT(Input_corp_merger_type_converted_to_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_merger_type_converted_to_desc = (TYPEOF(le.Input_corp_merger_type_converted_to_desc))'','',':corp_merger_type_converted_to_desc')
    #END
 
+    #IF( #TEXT(Input_corp_naics_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_naics_desc = (TYPEOF(le.Input_corp_naics_desc))'','',':corp_naics_desc')
    #END
 
+    #IF( #TEXT(Input_corp_name_effective_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_name_effective_date = (TYPEOF(le.Input_corp_name_effective_date))'','',':corp_name_effective_date')
    #END
 
+    #IF( #TEXT(Input_corp_name_reservation_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_name_reservation_date = (TYPEOF(le.Input_corp_name_reservation_date))'','',':corp_name_reservation_date')
    #END
 
+    #IF( #TEXT(Input_corp_name_reservation_expiration_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_name_reservation_expiration_date = (TYPEOF(le.Input_corp_name_reservation_expiration_date))'','',':corp_name_reservation_expiration_date')
    #END
 
+    #IF( #TEXT(Input_corp_name_reservation_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_name_reservation_nbr = (TYPEOF(le.Input_corp_name_reservation_nbr))'','',':corp_name_reservation_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_name_reservation_type)='' )
      '' 
    #ELSE
        IF( le.Input_corp_name_reservation_type = (TYPEOF(le.Input_corp_name_reservation_type))'','',':corp_name_reservation_type')
    #END
 
+    #IF( #TEXT(Input_corp_name_status_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_name_status_cd = (TYPEOF(le.Input_corp_name_status_cd))'','',':corp_name_status_cd')
    #END
 
+    #IF( #TEXT(Input_corp_name_status_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_name_status_date = (TYPEOF(le.Input_corp_name_status_date))'','',':corp_name_status_date')
    #END
 
+    #IF( #TEXT(Input_corp_name_status_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_name_status_desc = (TYPEOF(le.Input_corp_name_status_desc))'','',':corp_name_status_desc')
    #END
 
+    #IF( #TEXT(Input_corp_non_profit_irs_approved_purpose)='' )
      '' 
    #ELSE
        IF( le.Input_corp_non_profit_irs_approved_purpose = (TYPEOF(le.Input_corp_non_profit_irs_approved_purpose))'','',':corp_non_profit_irs_approved_purpose')
    #END
 
+    #IF( #TEXT(Input_corp_non_profit_solicit_donations)='' )
      '' 
    #ELSE
        IF( le.Input_corp_non_profit_solicit_donations = (TYPEOF(le.Input_corp_non_profit_solicit_donations))'','',':corp_non_profit_solicit_donations')
    #END
 
+    #IF( #TEXT(Input_corp_nbr_of_amendments)='' )
      '' 
    #ELSE
        IF( le.Input_corp_nbr_of_amendments = (TYPEOF(le.Input_corp_nbr_of_amendments))'','',':corp_nbr_of_amendments')
    #END
 
+    #IF( #TEXT(Input_corp_nbr_of_initial_llc_members)='' )
      '' 
    #ELSE
        IF( le.Input_corp_nbr_of_initial_llc_members = (TYPEOF(le.Input_corp_nbr_of_initial_llc_members))'','',':corp_nbr_of_initial_llc_members')
    #END
 
+    #IF( #TEXT(Input_corp_nbr_of_partners)='' )
      '' 
    #ELSE
        IF( le.Input_corp_nbr_of_partners = (TYPEOF(le.Input_corp_nbr_of_partners))'','',':corp_nbr_of_partners')
    #END
 
+    #IF( #TEXT(Input_corp_operating_agreement)='' )
      '' 
    #ELSE
        IF( le.Input_corp_operating_agreement = (TYPEOF(le.Input_corp_operating_agreement))'','',':corp_operating_agreement')
    #END
 
+    #IF( #TEXT(Input_corp_opt_in_llc_act_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_opt_in_llc_act_desc = (TYPEOF(le.Input_corp_opt_in_llc_act_desc))'','',':corp_opt_in_llc_act_desc')
    #END
 
+    #IF( #TEXT(Input_corp_opt_in_llc_act_ind)='' )
      '' 
    #ELSE
        IF( le.Input_corp_opt_in_llc_act_ind = (TYPEOF(le.Input_corp_opt_in_llc_act_ind))'','',':corp_opt_in_llc_act_ind')
    #END
 
+    #IF( #TEXT(Input_corp_organizational_comments)='' )
      '' 
    #ELSE
        IF( le.Input_corp_organizational_comments = (TYPEOF(le.Input_corp_organizational_comments))'','',':corp_organizational_comments')
    #END
 
+    #IF( #TEXT(Input_corp_partner_contributions_total)='' )
      '' 
    #ELSE
        IF( le.Input_corp_partner_contributions_total = (TYPEOF(le.Input_corp_partner_contributions_total))'','',':corp_partner_contributions_total')
    #END
 
+    #IF( #TEXT(Input_corp_partner_terms)='' )
      '' 
    #ELSE
        IF( le.Input_corp_partner_terms = (TYPEOF(le.Input_corp_partner_terms))'','',':corp_partner_terms')
    #END
 
+    #IF( #TEXT(Input_corp_percentage_voters_required_to_approve_amendments)='' )
      '' 
    #ELSE
        IF( le.Input_corp_percentage_voters_required_to_approve_amendments = (TYPEOF(le.Input_corp_percentage_voters_required_to_approve_amendments))'','',':corp_percentage_voters_required_to_approve_amendments')
    #END
 
+    #IF( #TEXT(Input_corp_profession)='' )
      '' 
    #ELSE
        IF( le.Input_corp_profession = (TYPEOF(le.Input_corp_profession))'','',':corp_profession')
    #END
 
+    #IF( #TEXT(Input_corp_province)='' )
      '' 
    #ELSE
        IF( le.Input_corp_province = (TYPEOF(le.Input_corp_province))'','',':corp_province')
    #END
 
+    #IF( #TEXT(Input_corp_public_mutual_corporation)='' )
      '' 
    #ELSE
        IF( le.Input_corp_public_mutual_corporation = (TYPEOF(le.Input_corp_public_mutual_corporation))'','',':corp_public_mutual_corporation')
    #END
 
+    #IF( #TEXT(Input_corp_purpose)='' )
      '' 
    #ELSE
        IF( le.Input_corp_purpose = (TYPEOF(le.Input_corp_purpose))'','',':corp_purpose')
    #END
 
+    #IF( #TEXT(Input_corp_ra_required_flag)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_required_flag = (TYPEOF(le.Input_corp_ra_required_flag))'','',':corp_ra_required_flag')
    #END
 
+    #IF( #TEXT(Input_corp_registered_counties)='' )
      '' 
    #ELSE
        IF( le.Input_corp_registered_counties = (TYPEOF(le.Input_corp_registered_counties))'','',':corp_registered_counties')
    #END
 
+    #IF( #TEXT(Input_corp_regulated_ind)='' )
      '' 
    #ELSE
        IF( le.Input_corp_regulated_ind = (TYPEOF(le.Input_corp_regulated_ind))'','',':corp_regulated_ind')
    #END
 
+    #IF( #TEXT(Input_corp_renewal_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_renewal_date = (TYPEOF(le.Input_corp_renewal_date))'','',':corp_renewal_date')
    #END
 
+    #IF( #TEXT(Input_corp_standing_other)='' )
      '' 
    #ELSE
        IF( le.Input_corp_standing_other = (TYPEOF(le.Input_corp_standing_other))'','',':corp_standing_other')
    #END
 
+    #IF( #TEXT(Input_corp_survivor_corporation_id)='' )
      '' 
    #ELSE
        IF( le.Input_corp_survivor_corporation_id = (TYPEOF(le.Input_corp_survivor_corporation_id))'','',':corp_survivor_corporation_id')
    #END
 
+    #IF( #TEXT(Input_corp_tax_base)='' )
      '' 
    #ELSE
        IF( le.Input_corp_tax_base = (TYPEOF(le.Input_corp_tax_base))'','',':corp_tax_base')
    #END
 
+    #IF( #TEXT(Input_corp_tax_standing)='' )
      '' 
    #ELSE
        IF( le.Input_corp_tax_standing = (TYPEOF(le.Input_corp_tax_standing))'','',':corp_tax_standing')
    #END
 
+    #IF( #TEXT(Input_corp_termination_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_termination_cd = (TYPEOF(le.Input_corp_termination_cd))'','',':corp_termination_cd')
    #END
 
+    #IF( #TEXT(Input_corp_termination_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_termination_desc = (TYPEOF(le.Input_corp_termination_desc))'','',':corp_termination_desc')
    #END
 
+    #IF( #TEXT(Input_corp_termination_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_termination_date = (TYPEOF(le.Input_corp_termination_date))'','',':corp_termination_date')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_classification_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_classification_nbr = (TYPEOF(le.Input_corp_trademark_classification_nbr))'','',':corp_trademark_classification_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_first_use_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_first_use_date = (TYPEOF(le.Input_corp_trademark_first_use_date))'','',':corp_trademark_first_use_date')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_first_use_date_in_state)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_first_use_date_in_state = (TYPEOF(le.Input_corp_trademark_first_use_date_in_state))'','',':corp_trademark_first_use_date_in_state')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_business_mark_type)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_business_mark_type = (TYPEOF(le.Input_corp_trademark_business_mark_type))'','',':corp_trademark_business_mark_type')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_cancelled_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_cancelled_date = (TYPEOF(le.Input_corp_trademark_cancelled_date))'','',':corp_trademark_cancelled_date')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_class_desc1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_class_desc1 = (TYPEOF(le.Input_corp_trademark_class_desc1))'','',':corp_trademark_class_desc1')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_class_desc2)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_class_desc2 = (TYPEOF(le.Input_corp_trademark_class_desc2))'','',':corp_trademark_class_desc2')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_class_desc3)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_class_desc3 = (TYPEOF(le.Input_corp_trademark_class_desc3))'','',':corp_trademark_class_desc3')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_class_desc4)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_class_desc4 = (TYPEOF(le.Input_corp_trademark_class_desc4))'','',':corp_trademark_class_desc4')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_class_desc5)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_class_desc5 = (TYPEOF(le.Input_corp_trademark_class_desc5))'','',':corp_trademark_class_desc5')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_class_desc6)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_class_desc6 = (TYPEOF(le.Input_corp_trademark_class_desc6))'','',':corp_trademark_class_desc6')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_disclaimer1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_disclaimer1 = (TYPEOF(le.Input_corp_trademark_disclaimer1))'','',':corp_trademark_disclaimer1')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_disclaimer2)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_disclaimer2 = (TYPEOF(le.Input_corp_trademark_disclaimer2))'','',':corp_trademark_disclaimer2')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_expiration_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_expiration_date = (TYPEOF(le.Input_corp_trademark_expiration_date))'','',':corp_trademark_expiration_date')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_filing_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_filing_date = (TYPEOF(le.Input_corp_trademark_filing_date))'','',':corp_trademark_filing_date')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_keywords)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_keywords = (TYPEOF(le.Input_corp_trademark_keywords))'','',':corp_trademark_keywords')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_logo)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_logo = (TYPEOF(le.Input_corp_trademark_logo))'','',':corp_trademark_logo')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_name_expiration_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_name_expiration_date = (TYPEOF(le.Input_corp_trademark_name_expiration_date))'','',':corp_trademark_name_expiration_date')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_nbr = (TYPEOF(le.Input_corp_trademark_nbr))'','',':corp_trademark_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_renewal_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_renewal_date = (TYPEOF(le.Input_corp_trademark_renewal_date))'','',':corp_trademark_renewal_date')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_status)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_status = (TYPEOF(le.Input_corp_trademark_status))'','',':corp_trademark_status')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_used_1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_used_1 = (TYPEOF(le.Input_corp_trademark_used_1))'','',':corp_trademark_used_1')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_used_2)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_used_2 = (TYPEOF(le.Input_corp_trademark_used_2))'','',':corp_trademark_used_2')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_used_3)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_used_3 = (TYPEOF(le.Input_corp_trademark_used_3))'','',':corp_trademark_used_3')
    #END
 
+    #IF( #TEXT(Input_cont_owner_percentage)='' )
      '' 
    #ELSE
        IF( le.Input_cont_owner_percentage = (TYPEOF(le.Input_cont_owner_percentage))'','',':cont_owner_percentage')
    #END
 
+    #IF( #TEXT(Input_cont_country)='' )
      '' 
    #ELSE
        IF( le.Input_cont_country = (TYPEOF(le.Input_cont_country))'','',':cont_country')
    #END
 
+    #IF( #TEXT(Input_cont_country_mailing)='' )
      '' 
    #ELSE
        IF( le.Input_cont_country_mailing = (TYPEOF(le.Input_cont_country_mailing))'','',':cont_country_mailing')
    #END
 
+    #IF( #TEXT(Input_cont_nondislosure)='' )
      '' 
    #ELSE
        IF( le.Input_cont_nondislosure = (TYPEOF(le.Input_cont_nondislosure))'','',':cont_nondislosure')
    #END
 
+    #IF( #TEXT(Input_cont_prep_addr_line1)='' )
      '' 
    #ELSE
        IF( le.Input_cont_prep_addr_line1 = (TYPEOF(le.Input_cont_prep_addr_line1))'','',':cont_prep_addr_line1')
    #END
 
+    #IF( #TEXT(Input_cont_prep_addr_last_line)='' )
      '' 
    #ELSE
        IF( le.Input_cont_prep_addr_last_line = (TYPEOF(le.Input_cont_prep_addr_last_line))'','',':cont_prep_addr_last_line')
    #END
 
+    #IF( #TEXT(Input_recordorigin)='' )
      '' 
    #ELSE
        IF( le.Input_recordorigin = (TYPEOF(le.Input_recordorigin))'','',':recordorigin')
    #END
;
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%, fields, FEW ), 1000, -cnt );
ENDMACRO;
