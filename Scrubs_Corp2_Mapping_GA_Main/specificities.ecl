IMPORT ut,SALT34;
EXPORT specificities(DATASET(layout_in_file) ih) := MODULE
 
EXPORT ih_init := ih;
 
SHARED h := ih_init;
 
EXPORT input_layout := RECORD // project out required fields
  SALT34.UIDType  := 0; // Fill in the value later
  UNSIGNED2 dt_vendor_first_reported_year := ((UNSIGNED)h.dt_vendor_first_reported) DIV 10000;
  UNSIGNED1 dt_vendor_first_reported_month := (((UNSIGNED)h.dt_vendor_first_reported) DIV 100 ) % 100;
  UNSIGNED1 dt_vendor_first_reported_day := ((UNSIGNED)h.dt_vendor_first_reported) % 100;
  UNSIGNED2 dt_vendor_last_reported_year := ((UNSIGNED)h.dt_vendor_last_reported) DIV 10000;
  UNSIGNED1 dt_vendor_last_reported_month := (((UNSIGNED)h.dt_vendor_last_reported) DIV 100 ) % 100;
  UNSIGNED1 dt_vendor_last_reported_day := ((UNSIGNED)h.dt_vendor_last_reported) % 100;
  UNSIGNED2 dt_first_seen_year := ((UNSIGNED)h.dt_first_seen) DIV 10000;
  UNSIGNED1 dt_first_seen_month := (((UNSIGNED)h.dt_first_seen) DIV 100 ) % 100;
  UNSIGNED1 dt_first_seen_day := ((UNSIGNED)h.dt_first_seen) % 100;
  UNSIGNED2 dt_last_seen_year := ((UNSIGNED)h.dt_last_seen) DIV 10000;
  UNSIGNED1 dt_last_seen_month := (((UNSIGNED)h.dt_last_seen) DIV 100 ) % 100;
  UNSIGNED1 dt_last_seen_day := ((UNSIGNED)h.dt_last_seen) % 100;
  UNSIGNED2 corp_ra_dt_first_seen_year := ((UNSIGNED)h.corp_ra_dt_first_seen) DIV 10000;
  UNSIGNED1 corp_ra_dt_first_seen_month := (((UNSIGNED)h.corp_ra_dt_first_seen) DIV 100 ) % 100;
  UNSIGNED1 corp_ra_dt_first_seen_day := ((UNSIGNED)h.corp_ra_dt_first_seen) % 100;
  UNSIGNED2 corp_ra_dt_last_seen_year := ((UNSIGNED)h.corp_ra_dt_last_seen) DIV 10000;
  UNSIGNED1 corp_ra_dt_last_seen_month := (((UNSIGNED)h.corp_ra_dt_last_seen) DIV 100 ) % 100;
  UNSIGNED1 corp_ra_dt_last_seen_day := ((UNSIGNED)h.corp_ra_dt_last_seen) % 100;
  h.corp_key;
  h.corp_supp_key;
  h.corp_vendor;
  h.corp_vendor_county;
  h.corp_vendor_subcode;
  h.corp_state_origin;
  UNSIGNED2 corp_process_date_year := ((UNSIGNED)h.corp_process_date) DIV 10000;
  UNSIGNED1 corp_process_date_month := (((UNSIGNED)h.corp_process_date) DIV 100 ) % 100;
  UNSIGNED1 corp_process_date_day := ((UNSIGNED)h.corp_process_date) % 100;
  h.corp_orig_sos_charter_nbr;
  h.corp_legal_name;
  h.corp_ln_name_type_cd;
  h.corp_ln_name_type_desc;
  h.corp_supp_nbr;
  h.corp_name_comment;
  h.corp_address1_type_cd;
  h.corp_address1_type_desc;
  h.corp_address1_line1;
  h.corp_address1_line2;
  h.corp_address1_line3;
  h.corp_address1_effective_date;
  h.corp_address2_type_cd;
  h.corp_address2_type_desc;
  h.corp_address2_line1;
  h.corp_address2_line2;
  h.corp_address2_line3;
  h.corp_address2_effective_date;
  h.corp_phone_number;
  h.corp_phone_number_type_cd;
  h.corp_phone_number_type_desc;
  h.corp_fax_nbr;
  h.corp_email_address;
  h.corp_web_address;
  h.corp_filing_reference_nbr;
  h.corp_filing_date;
  h.corp_filing_cd;
  h.corp_filing_desc;
  h.corp_status_cd;
  h.corp_status_desc;
  h.corp_status_date;
  h.corp_standing;
  h.corp_status_comment;
  h.corp_ticker_symbol;
  h.corp_stock_exchange;
  h.corp_inc_state;
  h.corp_inc_county;
  h.corp_inc_date;
  h.corp_anniversary_month;
  h.corp_fed_tax_id;
  h.corp_state_tax_id;
  h.corp_term_exist_cd;
  h.corp_term_exist_exp;
  h.corp_term_exist_desc;
  h.corp_foreign_domestic_ind;
  h.corp_forgn_state_cd;
  h.corp_forgn_state_desc;
  h.corp_forgn_sos_charter_nbr;
  h.corp_forgn_date;
  h.corp_forgn_fed_tax_id;
  h.corp_forgn_state_tax_id;
  h.corp_forgn_term_exist_cd;
  h.corp_forgn_term_exist_exp;
  h.corp_forgn_term_exist_desc;
  h.corp_orig_org_structure_cd;
  h.corp_orig_org_structure_desc;
  h.corp_for_profit_ind;
  h.corp_public_or_private_ind;
  h.corp_sic_code;
  h.corp_naic_code;
  h.corp_orig_bus_type_cd;
  h.corp_orig_bus_type_desc;
  h.corp_entity_desc;
  h.corp_certificate_nbr;
  h.corp_internal_nbr;
  h.corp_previous_nbr;
  h.corp_microfilm_nbr;
  h.corp_amendments_filed;
  h.corp_acts;
  h.corp_partnership_ind;
  h.corp_mfg_ind;
  h.corp_addl_info;
  h.corp_taxes;
  h.corp_franchise_taxes;
  h.corp_tax_program_cd;
  h.corp_tax_program_desc;
  h.corp_ra_full_name;
  h.corp_ra_fname;
  h.corp_ra_mname;
  h.corp_ra_lname;
  h.corp_ra_suffix;
  h.corp_ra_title_cd;
  h.corp_ra_title_desc;
  h.corp_ra_fein;
  h.corp_ra_ssn;
  h.corp_ra_dob;
  h.corp_ra_effective_date;
  h.corp_ra_resign_date;
  h.corp_ra_no_comp;
  h.corp_ra_no_comp_igs;
  h.corp_ra_addl_info;
  h.corp_ra_address_type_cd;
  h.corp_ra_address_type_desc;
  h.corp_ra_address_line1;
  h.corp_ra_address_line2;
  h.corp_ra_address_line3;
  h.corp_ra_phone_number;
  h.corp_ra_phone_number_type_cd;
  h.corp_ra_phone_number_type_desc;
  h.corp_ra_fax_nbr;
  h.corp_ra_email_address;
  h.corp_ra_web_address;
  h.corp_prep_addr1_line1;
  h.corp_prep_addr1_last_line;
  h.corp_prep_addr2_line1;
  h.corp_prep_addr2_last_line;
  h.ra_prep_addr_line1;
  h.ra_prep_addr_last_line;
  h.cont_filing_reference_nbr;
  h.cont_filing_date;
  h.cont_filing_cd;
  h.cont_filing_desc;
  h.cont_type_cd;
  h.cont_type_desc;
  h.cont_full_name;
  h.cont_fname;
  h.cont_mname;
  h.cont_lname;
  h.cont_suffix;
  h.cont_title1_desc;
  h.cont_title2_desc;
  h.cont_title3_desc;
  h.cont_title4_desc;
  h.cont_title5_desc;
  h.cont_fein;
  h.cont_ssn;
  h.cont_dob;
  h.cont_status_cd;
  h.cont_status_desc;
  h.cont_effective_date;
  h.cont_effective_cd;
  h.cont_effective_desc;
  h.cont_addl_info;
  h.cont_address_type_cd;
  h.cont_address_type_desc;
  h.cont_address_line1;
  h.cont_address_line2;
  h.cont_address_line3;
  h.cont_address_effective_date;
  h.cont_address_county;
  h.cont_phone_number;
  h.cont_phone_number_type_cd;
  h.cont_phone_number_type_desc;
  h.cont_fax_nbr;
  h.cont_email_address;
  h.cont_web_address;
  h.corp_acres;
  h.corp_action;
  h.corp_action_date;
  h.corp_action_employment_security_approval_date;
  h.corp_action_pending_cd;
  h.corp_action_pending_desc;
  h.corp_action_statement_of_intent_date;
  h.corp_action_tax_dept_approval_date;
  h.corp_acts2;
  h.corp_acts3;
  h.corp_additional_principals;
  h.corp_address_office_type;
  h.corp_agent_assign_date;
  h.corp_agent_commercial;
  h.corp_agent_country;
  h.corp_agent_county;
  h.corp_agent_status_cd;
  h.corp_agent_status_desc;
  h.corp_agent_id;
  h.corp_agriculture_flag;
  h.corp_authorized_partners;
  h.corp_comment;
  h.corp_consent_flag_for_protected_name;
  h.corp_converted;
  h.corp_converted_from;
  h.corp_country_of_formation;
  h.corp_date_of_organization_meeting;
  h.corp_delayed_effective_date;
  h.corp_directors_from_to;
  h.corp_dissolved_date;
  h.corp_farm_exemptions;
  h.corp_farm_qual_date;
  h.corp_farm_status_cd;
  h.corp_farm_status_desc;
  h.corp_fiscal_year_month;
  h.corp_foreign_fiduciary_capacity_in_state;
  h.corp_governing_statute;
  h.corp_has_members;
  h.corp_has_vested_managers;
  h.corp_home_incorporated_county;
  h.corp_home_state_name;
  h.corp_is_professional;
  h.corp_is_non_profit_irs_approved;
  h.corp_last_renewal_date;
  h.corp_last_renewal_year;
  h.corp_license_type;
  h.corp_llc_managed_desc;
  h.corp_llc_managed_ind;
  h.corp_management_desc;
  h.corp_management_type;
  h.corp_manager_managed;
  h.corp_merged_corporation_id;
  h.corp_merged_fein;
  h.corp_merger_allowed_flag;
  h.corp_merger_date;
  h.corp_merger_desc;
  h.corp_merger_effective_date;
  h.corp_merger_id;
  h.corp_merger_indicator;
  h.corp_merger_name;
  h.corp_merger_type_converted_to_cd;
  h.corp_merger_type_converted_to_desc;
  h.corp_naics_desc;
  h.corp_name_effective_date;
  h.corp_name_reservation_date;
  h.corp_name_reservation_desc;
  h.corp_name_reservation_expiration_date;
  h.corp_name_reservation_nbr;
  h.corp_name_reservation_type;
  h.corp_name_status_cd;
  h.corp_name_status_date;
  h.corp_name_status_desc;
  h.corp_non_profit_irs_approved_purpose;
  h.corp_non_profit_solicit_donations;
  h.corp_nbr_of_amendments;
  h.corp_nbr_of_initial_llc_members;
  h.corp_nbr_of_partners;
  h.corp_operating_agreement;
  h.corp_opt_in_llc_act_desc;
  h.corp_opt_in_llc_act_ind;
  h.corp_organizational_comments;
  h.corp_partner_contributions_total;
  h.corp_partner_terms;
  h.corp_percentage_voters_required_to_approve_amendments;
  h.corp_profession;
  h.corp_province;
  h.corp_public_mutual_corporation;
  h.corp_purpose;
  h.corp_ra_required_flag;
  h.corp_registered_counties;
  h.corp_regulated_ind;
  h.corp_renewal_date;
  h.corp_standing_other;
  h.corp_survivor_corporation_id;
  h.corp_tax_base;
  h.corp_tax_standing;
  h.corp_termination_cd;
  h.corp_termination_desc;
  h.corp_termination_date;
  h.corp_trademark_business_mark_type;
  h.corp_trademark_cancelled_date;
  h.corp_trademark_class_desc1;
  h.corp_trademark_class_desc2;
  h.corp_trademark_class_desc3;
  h.corp_trademark_class_desc4;
  h.corp_trademark_class_desc5;
  h.corp_trademark_class_desc6;
  h.corp_trademark_classification_nbr;
  h.corp_trademark_disclaimer1;
  h.corp_trademark_disclaimer2;
  h.corp_trademark_expiration_date;
  h.corp_trademark_filing_date;
  h.corp_trademark_first_use_date;
  h.corp_trademark_first_use_date_in_state;
  h.corp_trademark_keywords;
  h.corp_trademark_logo;
  h.corp_trademark_name_expiration_date;
  h.corp_trademark_nbr;
  h.corp_trademark_renewal_date;
  h.corp_trademark_status;
  h.corp_trademark_used_1;
  h.corp_trademark_used_2;
  h.corp_trademark_used_3;
  h.cont_owner_percentage;
  h.cont_country;
  h.cont_country_mailing;
  h.cont_nondislosure;
  h.cont_prep_addr_line1;
  h.cont_prep_addr_last_line;
  h.recordorigin;
END;
r := input_layout;
 
tab := TABLE(h,r);
ut.mac_sequence_records(tab,,h00);
h01 := DISTRIBUTE(h00,); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 :=  h02;
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0 : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::Specificities_Cache',EXPIRE(Config.PersistExpire));
//We have  specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,,LOCAL) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::Cluster_Sizes',EXPIRE(Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  dt_vendor_first_reported_year_deduped := SALT34.MAC_Field_By_UID(input_file,,dt_vendor_first_reported_year) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::dt_vendor_first_reported_year',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(dt_vendor_first_reported_year_deduped,dt_vendor_first_reported_year,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_vendor_first_reported_year_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::dt_vendor_first_reported_year',EXPIRE(Config.PersistExpire));
 
EXPORT  dt_vendor_first_reported_month_deduped := SALT34.MAC_Field_By_UID(input_file,,dt_vendor_first_reported_month) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::dt_vendor_first_reported_month',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(dt_vendor_first_reported_month_deduped,dt_vendor_first_reported_month,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_vendor_first_reported_month_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::dt_vendor_first_reported_month',EXPIRE(Config.PersistExpire));
 
EXPORT  dt_vendor_first_reported_day_deduped := SALT34.MAC_Field_By_UID(input_file,,dt_vendor_first_reported_day) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::dt_vendor_first_reported_day',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(dt_vendor_first_reported_day_deduped,dt_vendor_first_reported_day,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_vendor_first_reported_day_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::dt_vendor_first_reported_day',EXPIRE(Config.PersistExpire));
 
EXPORT  dt_vendor_last_reported_year_deduped := SALT34.MAC_Field_By_UID(input_file,,dt_vendor_last_reported_year) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::dt_vendor_last_reported_year',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(dt_vendor_last_reported_year_deduped,dt_vendor_last_reported_year,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_vendor_last_reported_year_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::dt_vendor_last_reported_year',EXPIRE(Config.PersistExpire));
 
EXPORT  dt_vendor_last_reported_month_deduped := SALT34.MAC_Field_By_UID(input_file,,dt_vendor_last_reported_month) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::dt_vendor_last_reported_month',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(dt_vendor_last_reported_month_deduped,dt_vendor_last_reported_month,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_vendor_last_reported_month_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::dt_vendor_last_reported_month',EXPIRE(Config.PersistExpire));
 
EXPORT  dt_vendor_last_reported_day_deduped := SALT34.MAC_Field_By_UID(input_file,,dt_vendor_last_reported_day) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::dt_vendor_last_reported_day',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(dt_vendor_last_reported_day_deduped,dt_vendor_last_reported_day,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_vendor_last_reported_day_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::dt_vendor_last_reported_day',EXPIRE(Config.PersistExpire));
 
EXPORT  dt_first_seen_year_deduped := SALT34.MAC_Field_By_UID(input_file,,dt_first_seen_year) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::dt_first_seen_year',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(dt_first_seen_year_deduped,dt_first_seen_year,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_first_seen_year_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::dt_first_seen_year',EXPIRE(Config.PersistExpire));
 
EXPORT  dt_first_seen_month_deduped := SALT34.MAC_Field_By_UID(input_file,,dt_first_seen_month) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::dt_first_seen_month',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(dt_first_seen_month_deduped,dt_first_seen_month,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_first_seen_month_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::dt_first_seen_month',EXPIRE(Config.PersistExpire));
 
EXPORT  dt_first_seen_day_deduped := SALT34.MAC_Field_By_UID(input_file,,dt_first_seen_day) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::dt_first_seen_day',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(dt_first_seen_day_deduped,dt_first_seen_day,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_first_seen_day_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::dt_first_seen_day',EXPIRE(Config.PersistExpire));
 
EXPORT  dt_last_seen_year_deduped := SALT34.MAC_Field_By_UID(input_file,,dt_last_seen_year) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::dt_last_seen_year',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(dt_last_seen_year_deduped,dt_last_seen_year,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_last_seen_year_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::dt_last_seen_year',EXPIRE(Config.PersistExpire));
 
EXPORT  dt_last_seen_month_deduped := SALT34.MAC_Field_By_UID(input_file,,dt_last_seen_month) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::dt_last_seen_month',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(dt_last_seen_month_deduped,dt_last_seen_month,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_last_seen_month_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::dt_last_seen_month',EXPIRE(Config.PersistExpire));
 
EXPORT  dt_last_seen_day_deduped := SALT34.MAC_Field_By_UID(input_file,,dt_last_seen_day) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::dt_last_seen_day',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(dt_last_seen_day_deduped,dt_last_seen_day,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_last_seen_day_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::dt_last_seen_day',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_dt_first_seen_year_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_dt_first_seen_year) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_dt_first_seen_year',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_dt_first_seen_year_deduped,corp_ra_dt_first_seen_year,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_dt_first_seen_year_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_dt_first_seen_year',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_dt_first_seen_month_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_dt_first_seen_month) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_dt_first_seen_month',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_dt_first_seen_month_deduped,corp_ra_dt_first_seen_month,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_dt_first_seen_month_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_dt_first_seen_month',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_dt_first_seen_day_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_dt_first_seen_day) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_dt_first_seen_day',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_dt_first_seen_day_deduped,corp_ra_dt_first_seen_day,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_dt_first_seen_day_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_dt_first_seen_day',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_dt_last_seen_year_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_dt_last_seen_year) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_dt_last_seen_year',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_dt_last_seen_year_deduped,corp_ra_dt_last_seen_year,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_dt_last_seen_year_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_dt_last_seen_year',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_dt_last_seen_month_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_dt_last_seen_month) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_dt_last_seen_month',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_dt_last_seen_month_deduped,corp_ra_dt_last_seen_month,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_dt_last_seen_month_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_dt_last_seen_month',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_dt_last_seen_day_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_dt_last_seen_day) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_dt_last_seen_day',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_dt_last_seen_day_deduped,corp_ra_dt_last_seen_day,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_dt_last_seen_day_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_dt_last_seen_day',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_key_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_key) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_key',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_key_deduped,corp_key,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_key_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_key',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_supp_key_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_supp_key) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_supp_key',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_supp_key_deduped,corp_supp_key,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_supp_key_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_supp_key',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_vendor_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_vendor) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_vendor',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_vendor_deduped,corp_vendor,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_vendor_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_vendor',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_vendor_county_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_vendor_county) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_vendor_county',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_vendor_county_deduped,corp_vendor_county,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_vendor_county_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_vendor_county',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_vendor_subcode_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_vendor_subcode) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_vendor_subcode',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_vendor_subcode_deduped,corp_vendor_subcode,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_vendor_subcode_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_vendor_subcode',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_state_origin_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_state_origin) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_state_origin',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_state_origin_deduped,corp_state_origin,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_state_origin_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_state_origin',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_process_date_year_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_process_date_year) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_process_date_year',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_process_date_year_deduped,corp_process_date_year,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_process_date_year_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_process_date_year',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_process_date_month_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_process_date_month) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_process_date_month',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_process_date_month_deduped,corp_process_date_month,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_process_date_month_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_process_date_month',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_process_date_day_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_process_date_day) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_process_date_day',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_process_date_day_deduped,corp_process_date_day,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_process_date_day_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_process_date_day',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_orig_sos_charter_nbr_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_orig_sos_charter_nbr) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_orig_sos_charter_nbr',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_orig_sos_charter_nbr_deduped,corp_orig_sos_charter_nbr,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_orig_sos_charter_nbr_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_orig_sos_charter_nbr',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_legal_name_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_legal_name) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_legal_name',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_legal_name_deduped,corp_legal_name,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_legal_name_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_legal_name',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ln_name_type_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ln_name_type_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ln_name_type_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ln_name_type_cd_deduped,corp_ln_name_type_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ln_name_type_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ln_name_type_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ln_name_type_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ln_name_type_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ln_name_type_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ln_name_type_desc_deduped,corp_ln_name_type_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ln_name_type_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ln_name_type_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_supp_nbr_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_supp_nbr) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_supp_nbr',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_supp_nbr_deduped,corp_supp_nbr,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_supp_nbr_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_supp_nbr',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_name_comment_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_name_comment) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_name_comment',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_name_comment_deduped,corp_name_comment,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_name_comment_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_name_comment',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_address1_type_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_address1_type_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_address1_type_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_address1_type_cd_deduped,corp_address1_type_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_address1_type_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_address1_type_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_address1_type_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_address1_type_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_address1_type_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_address1_type_desc_deduped,corp_address1_type_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_address1_type_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_address1_type_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_address1_line1_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_address1_line1) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_address1_line1',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_address1_line1_deduped,corp_address1_line1,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_address1_line1_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_address1_line1',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_address1_line2_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_address1_line2) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_address1_line2',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_address1_line2_deduped,corp_address1_line2,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_address1_line2_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_address1_line2',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_address1_line3_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_address1_line3) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_address1_line3',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_address1_line3_deduped,corp_address1_line3,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_address1_line3_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_address1_line3',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_address1_effective_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_address1_effective_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_address1_effective_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_address1_effective_date_deduped,corp_address1_effective_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_address1_effective_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_address1_effective_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_address2_type_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_address2_type_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_address2_type_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_address2_type_cd_deduped,corp_address2_type_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_address2_type_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_address2_type_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_address2_type_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_address2_type_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_address2_type_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_address2_type_desc_deduped,corp_address2_type_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_address2_type_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_address2_type_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_address2_line1_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_address2_line1) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_address2_line1',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_address2_line1_deduped,corp_address2_line1,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_address2_line1_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_address2_line1',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_address2_line2_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_address2_line2) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_address2_line2',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_address2_line2_deduped,corp_address2_line2,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_address2_line2_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_address2_line2',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_address2_line3_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_address2_line3) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_address2_line3',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_address2_line3_deduped,corp_address2_line3,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_address2_line3_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_address2_line3',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_address2_effective_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_address2_effective_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_address2_effective_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_address2_effective_date_deduped,corp_address2_effective_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_address2_effective_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_address2_effective_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_phone_number_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_phone_number) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_phone_number',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_phone_number_deduped,corp_phone_number,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_phone_number_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_phone_number',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_phone_number_type_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_phone_number_type_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_phone_number_type_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_phone_number_type_cd_deduped,corp_phone_number_type_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_phone_number_type_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_phone_number_type_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_phone_number_type_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_phone_number_type_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_phone_number_type_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_phone_number_type_desc_deduped,corp_phone_number_type_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_phone_number_type_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_phone_number_type_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_fax_nbr_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_fax_nbr) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_fax_nbr',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_fax_nbr_deduped,corp_fax_nbr,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_fax_nbr_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_fax_nbr',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_email_address_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_email_address) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_email_address',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_email_address_deduped,corp_email_address,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_email_address_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_email_address',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_web_address_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_web_address) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_web_address',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_web_address_deduped,corp_web_address,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_web_address_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_web_address',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_filing_reference_nbr_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_filing_reference_nbr) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_filing_reference_nbr',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_filing_reference_nbr_deduped,corp_filing_reference_nbr,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_filing_reference_nbr_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_filing_reference_nbr',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_filing_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_filing_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_filing_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_filing_date_deduped,corp_filing_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_filing_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_filing_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_filing_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_filing_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_filing_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_filing_cd_deduped,corp_filing_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_filing_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_filing_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_filing_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_filing_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_filing_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_filing_desc_deduped,corp_filing_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_filing_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_filing_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_status_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_status_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_status_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_status_cd_deduped,corp_status_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_status_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_status_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_status_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_status_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_status_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_status_desc_deduped,corp_status_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_status_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_status_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_status_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_status_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_status_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_status_date_deduped,corp_status_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_status_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_status_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_standing_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_standing) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_standing',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_standing_deduped,corp_standing,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_standing_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_standing',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_status_comment_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_status_comment) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_status_comment',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_status_comment_deduped,corp_status_comment,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_status_comment_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_status_comment',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ticker_symbol_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ticker_symbol) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ticker_symbol',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ticker_symbol_deduped,corp_ticker_symbol,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ticker_symbol_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ticker_symbol',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_stock_exchange_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_stock_exchange) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_stock_exchange',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_stock_exchange_deduped,corp_stock_exchange,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_stock_exchange_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_stock_exchange',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_inc_state_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_inc_state) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_inc_state',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_inc_state_deduped,corp_inc_state,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_inc_state_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_inc_state',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_inc_county_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_inc_county) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_inc_county',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_inc_county_deduped,corp_inc_county,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_inc_county_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_inc_county',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_inc_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_inc_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_inc_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_inc_date_deduped,corp_inc_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_inc_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_inc_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_anniversary_month_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_anniversary_month) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_anniversary_month',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_anniversary_month_deduped,corp_anniversary_month,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_anniversary_month_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_anniversary_month',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_fed_tax_id_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_fed_tax_id) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_fed_tax_id',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_fed_tax_id_deduped,corp_fed_tax_id,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_fed_tax_id_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_fed_tax_id',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_state_tax_id_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_state_tax_id) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_state_tax_id',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_state_tax_id_deduped,corp_state_tax_id,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_state_tax_id_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_state_tax_id',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_term_exist_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_term_exist_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_term_exist_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_term_exist_cd_deduped,corp_term_exist_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_term_exist_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_term_exist_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_term_exist_exp_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_term_exist_exp) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_term_exist_exp',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_term_exist_exp_deduped,corp_term_exist_exp,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_term_exist_exp_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_term_exist_exp',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_term_exist_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_term_exist_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_term_exist_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_term_exist_desc_deduped,corp_term_exist_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_term_exist_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_term_exist_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_foreign_domestic_ind_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_foreign_domestic_ind) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_foreign_domestic_ind',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_foreign_domestic_ind_deduped,corp_foreign_domestic_ind,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_foreign_domestic_ind_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_foreign_domestic_ind',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_forgn_state_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_forgn_state_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_forgn_state_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_forgn_state_cd_deduped,corp_forgn_state_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_forgn_state_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_forgn_state_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_forgn_state_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_forgn_state_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_forgn_state_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_forgn_state_desc_deduped,corp_forgn_state_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_forgn_state_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_forgn_state_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_forgn_sos_charter_nbr_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_forgn_sos_charter_nbr) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_forgn_sos_charter_nbr',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_forgn_sos_charter_nbr_deduped,corp_forgn_sos_charter_nbr,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_forgn_sos_charter_nbr_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_forgn_sos_charter_nbr',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_forgn_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_forgn_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_forgn_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_forgn_date_deduped,corp_forgn_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_forgn_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_forgn_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_forgn_fed_tax_id_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_forgn_fed_tax_id) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_forgn_fed_tax_id',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_forgn_fed_tax_id_deduped,corp_forgn_fed_tax_id,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_forgn_fed_tax_id_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_forgn_fed_tax_id',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_forgn_state_tax_id_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_forgn_state_tax_id) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_forgn_state_tax_id',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_forgn_state_tax_id_deduped,corp_forgn_state_tax_id,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_forgn_state_tax_id_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_forgn_state_tax_id',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_forgn_term_exist_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_forgn_term_exist_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_forgn_term_exist_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_forgn_term_exist_cd_deduped,corp_forgn_term_exist_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_forgn_term_exist_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_forgn_term_exist_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_forgn_term_exist_exp_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_forgn_term_exist_exp) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_forgn_term_exist_exp',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_forgn_term_exist_exp_deduped,corp_forgn_term_exist_exp,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_forgn_term_exist_exp_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_forgn_term_exist_exp',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_forgn_term_exist_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_forgn_term_exist_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_forgn_term_exist_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_forgn_term_exist_desc_deduped,corp_forgn_term_exist_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_forgn_term_exist_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_forgn_term_exist_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_orig_org_structure_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_orig_org_structure_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_orig_org_structure_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_orig_org_structure_cd_deduped,corp_orig_org_structure_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_orig_org_structure_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_orig_org_structure_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_orig_org_structure_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_orig_org_structure_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_orig_org_structure_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_orig_org_structure_desc_deduped,corp_orig_org_structure_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_orig_org_structure_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_orig_org_structure_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_for_profit_ind_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_for_profit_ind) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_for_profit_ind',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_for_profit_ind_deduped,corp_for_profit_ind,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_for_profit_ind_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_for_profit_ind',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_public_or_private_ind_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_public_or_private_ind) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_public_or_private_ind',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_public_or_private_ind_deduped,corp_public_or_private_ind,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_public_or_private_ind_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_public_or_private_ind',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_sic_code_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_sic_code) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_sic_code',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_sic_code_deduped,corp_sic_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_sic_code_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_sic_code',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_naic_code_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_naic_code) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_naic_code',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_naic_code_deduped,corp_naic_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_naic_code_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_naic_code',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_orig_bus_type_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_orig_bus_type_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_orig_bus_type_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_orig_bus_type_cd_deduped,corp_orig_bus_type_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_orig_bus_type_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_orig_bus_type_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_orig_bus_type_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_orig_bus_type_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_orig_bus_type_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_orig_bus_type_desc_deduped,corp_orig_bus_type_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_orig_bus_type_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_orig_bus_type_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_entity_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_entity_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_entity_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_entity_desc_deduped,corp_entity_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_entity_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_entity_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_certificate_nbr_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_certificate_nbr) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_certificate_nbr',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_certificate_nbr_deduped,corp_certificate_nbr,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_certificate_nbr_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_certificate_nbr',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_internal_nbr_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_internal_nbr) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_internal_nbr',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_internal_nbr_deduped,corp_internal_nbr,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_internal_nbr_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_internal_nbr',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_previous_nbr_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_previous_nbr) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_previous_nbr',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_previous_nbr_deduped,corp_previous_nbr,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_previous_nbr_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_previous_nbr',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_microfilm_nbr_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_microfilm_nbr) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_microfilm_nbr',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_microfilm_nbr_deduped,corp_microfilm_nbr,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_microfilm_nbr_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_microfilm_nbr',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_amendments_filed_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_amendments_filed) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_amendments_filed',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_amendments_filed_deduped,corp_amendments_filed,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_amendments_filed_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_amendments_filed',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_acts_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_acts) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_acts',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_acts_deduped,corp_acts,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_acts_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_acts',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_partnership_ind_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_partnership_ind) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_partnership_ind',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_partnership_ind_deduped,corp_partnership_ind,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_partnership_ind_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_partnership_ind',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_mfg_ind_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_mfg_ind) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_mfg_ind',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_mfg_ind_deduped,corp_mfg_ind,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_mfg_ind_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_mfg_ind',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_addl_info_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_addl_info) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_addl_info',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_addl_info_deduped,corp_addl_info,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_addl_info_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_addl_info',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_taxes_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_taxes) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_taxes',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_taxes_deduped,corp_taxes,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_taxes_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_taxes',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_franchise_taxes_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_franchise_taxes) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_franchise_taxes',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_franchise_taxes_deduped,corp_franchise_taxes,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_franchise_taxes_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_franchise_taxes',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_tax_program_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_tax_program_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_tax_program_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_tax_program_cd_deduped,corp_tax_program_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_tax_program_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_tax_program_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_tax_program_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_tax_program_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_tax_program_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_tax_program_desc_deduped,corp_tax_program_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_tax_program_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_tax_program_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_full_name_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_full_name) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_full_name',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_full_name_deduped,corp_ra_full_name,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_full_name_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_full_name',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_fname_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_fname) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_fname',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_fname_deduped,corp_ra_fname,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_fname_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_fname',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_mname_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_mname) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_mname',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_mname_deduped,corp_ra_mname,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_mname_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_mname',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_lname_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_lname) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_lname',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_lname_deduped,corp_ra_lname,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_lname_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_lname',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_suffix_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_suffix) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_suffix',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_suffix_deduped,corp_ra_suffix,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_suffix_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_suffix',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_title_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_title_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_title_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_title_cd_deduped,corp_ra_title_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_title_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_title_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_title_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_title_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_title_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_title_desc_deduped,corp_ra_title_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_title_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_title_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_fein_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_fein) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_fein',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_fein_deduped,corp_ra_fein,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_fein_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_fein',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_ssn_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_ssn) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_ssn',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_ssn_deduped,corp_ra_ssn,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_ssn_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_ssn',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_dob_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_dob) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_dob',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_dob_deduped,corp_ra_dob,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_dob_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_dob',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_effective_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_effective_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_effective_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_effective_date_deduped,corp_ra_effective_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_effective_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_effective_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_resign_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_resign_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_resign_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_resign_date_deduped,corp_ra_resign_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_resign_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_resign_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_no_comp_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_no_comp) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_no_comp',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_no_comp_deduped,corp_ra_no_comp,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_no_comp_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_no_comp',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_no_comp_igs_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_no_comp_igs) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_no_comp_igs',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_no_comp_igs_deduped,corp_ra_no_comp_igs,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_no_comp_igs_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_no_comp_igs',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_addl_info_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_addl_info) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_addl_info',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_addl_info_deduped,corp_ra_addl_info,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_addl_info_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_addl_info',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_address_type_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_address_type_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_address_type_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_address_type_cd_deduped,corp_ra_address_type_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_address_type_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_address_type_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_address_type_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_address_type_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_address_type_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_address_type_desc_deduped,corp_ra_address_type_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_address_type_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_address_type_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_address_line1_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_address_line1) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_address_line1',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_address_line1_deduped,corp_ra_address_line1,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_address_line1_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_address_line1',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_address_line2_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_address_line2) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_address_line2',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_address_line2_deduped,corp_ra_address_line2,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_address_line2_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_address_line2',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_address_line3_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_address_line3) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_address_line3',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_address_line3_deduped,corp_ra_address_line3,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_address_line3_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_address_line3',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_phone_number_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_phone_number) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_phone_number',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_phone_number_deduped,corp_ra_phone_number,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_phone_number_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_phone_number',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_phone_number_type_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_phone_number_type_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_phone_number_type_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_phone_number_type_cd_deduped,corp_ra_phone_number_type_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_phone_number_type_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_phone_number_type_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_phone_number_type_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_phone_number_type_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_phone_number_type_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_phone_number_type_desc_deduped,corp_ra_phone_number_type_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_phone_number_type_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_phone_number_type_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_fax_nbr_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_fax_nbr) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_fax_nbr',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_fax_nbr_deduped,corp_ra_fax_nbr,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_fax_nbr_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_fax_nbr',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_email_address_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_email_address) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_email_address',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_email_address_deduped,corp_ra_email_address,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_email_address_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_email_address',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_web_address_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_web_address) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_web_address',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_web_address_deduped,corp_ra_web_address,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_web_address_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_web_address',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_prep_addr1_line1_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_prep_addr1_line1) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_prep_addr1_line1',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_prep_addr1_line1_deduped,corp_prep_addr1_line1,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_prep_addr1_line1_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_prep_addr1_line1',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_prep_addr1_last_line_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_prep_addr1_last_line) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_prep_addr1_last_line',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_prep_addr1_last_line_deduped,corp_prep_addr1_last_line,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_prep_addr1_last_line_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_prep_addr1_last_line',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_prep_addr2_line1_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_prep_addr2_line1) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_prep_addr2_line1',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_prep_addr2_line1_deduped,corp_prep_addr2_line1,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_prep_addr2_line1_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_prep_addr2_line1',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_prep_addr2_last_line_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_prep_addr2_last_line) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_prep_addr2_last_line',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_prep_addr2_last_line_deduped,corp_prep_addr2_last_line,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_prep_addr2_last_line_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_prep_addr2_last_line',EXPIRE(Config.PersistExpire));
 
EXPORT  ra_prep_addr_line1_deduped := SALT34.MAC_Field_By_UID(input_file,,ra_prep_addr_line1) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::ra_prep_addr_line1',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(ra_prep_addr_line1_deduped,ra_prep_addr_line1,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ra_prep_addr_line1_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::ra_prep_addr_line1',EXPIRE(Config.PersistExpire));
 
EXPORT  ra_prep_addr_last_line_deduped := SALT34.MAC_Field_By_UID(input_file,,ra_prep_addr_last_line) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::ra_prep_addr_last_line',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(ra_prep_addr_last_line_deduped,ra_prep_addr_last_line,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ra_prep_addr_last_line_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::ra_prep_addr_last_line',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_filing_reference_nbr_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_filing_reference_nbr) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_filing_reference_nbr',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_filing_reference_nbr_deduped,cont_filing_reference_nbr,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_filing_reference_nbr_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_filing_reference_nbr',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_filing_date_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_filing_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_filing_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_filing_date_deduped,cont_filing_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_filing_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_filing_date',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_filing_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_filing_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_filing_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_filing_cd_deduped,cont_filing_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_filing_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_filing_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_filing_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_filing_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_filing_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_filing_desc_deduped,cont_filing_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_filing_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_filing_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_type_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_type_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_type_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_type_cd_deduped,cont_type_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_type_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_type_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_type_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_type_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_type_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_type_desc_deduped,cont_type_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_type_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_type_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_full_name_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_full_name) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_full_name',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_full_name_deduped,cont_full_name,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_full_name_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_full_name',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_fname_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_fname) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_fname',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_fname_deduped,cont_fname,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_fname_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_fname',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_mname_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_mname) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_mname',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_mname_deduped,cont_mname,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_mname_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_mname',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_lname_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_lname) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_lname',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_lname_deduped,cont_lname,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_lname_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_lname',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_suffix_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_suffix) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_suffix',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_suffix_deduped,cont_suffix,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_suffix_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_suffix',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_title1_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_title1_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_title1_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_title1_desc_deduped,cont_title1_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_title1_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_title1_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_title2_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_title2_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_title2_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_title2_desc_deduped,cont_title2_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_title2_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_title2_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_title3_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_title3_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_title3_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_title3_desc_deduped,cont_title3_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_title3_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_title3_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_title4_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_title4_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_title4_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_title4_desc_deduped,cont_title4_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_title4_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_title4_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_title5_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_title5_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_title5_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_title5_desc_deduped,cont_title5_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_title5_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_title5_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_fein_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_fein) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_fein',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_fein_deduped,cont_fein,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_fein_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_fein',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_ssn_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_ssn) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_ssn',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_ssn_deduped,cont_ssn,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_ssn_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_ssn',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_dob_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_dob) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_dob',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_dob_deduped,cont_dob,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_dob_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_dob',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_status_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_status_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_status_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_status_cd_deduped,cont_status_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_status_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_status_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_status_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_status_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_status_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_status_desc_deduped,cont_status_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_status_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_status_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_effective_date_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_effective_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_effective_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_effective_date_deduped,cont_effective_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_effective_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_effective_date',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_effective_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_effective_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_effective_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_effective_cd_deduped,cont_effective_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_effective_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_effective_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_effective_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_effective_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_effective_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_effective_desc_deduped,cont_effective_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_effective_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_effective_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_addl_info_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_addl_info) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_addl_info',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_addl_info_deduped,cont_addl_info,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_addl_info_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_addl_info',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_address_type_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_address_type_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_address_type_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_address_type_cd_deduped,cont_address_type_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_address_type_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_address_type_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_address_type_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_address_type_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_address_type_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_address_type_desc_deduped,cont_address_type_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_address_type_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_address_type_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_address_line1_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_address_line1) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_address_line1',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_address_line1_deduped,cont_address_line1,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_address_line1_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_address_line1',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_address_line2_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_address_line2) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_address_line2',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_address_line2_deduped,cont_address_line2,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_address_line2_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_address_line2',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_address_line3_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_address_line3) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_address_line3',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_address_line3_deduped,cont_address_line3,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_address_line3_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_address_line3',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_address_effective_date_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_address_effective_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_address_effective_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_address_effective_date_deduped,cont_address_effective_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_address_effective_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_address_effective_date',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_address_county_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_address_county) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_address_county',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_address_county_deduped,cont_address_county,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_address_county_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_address_county',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_phone_number_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_phone_number) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_phone_number',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_phone_number_deduped,cont_phone_number,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_phone_number_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_phone_number',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_phone_number_type_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_phone_number_type_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_phone_number_type_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_phone_number_type_cd_deduped,cont_phone_number_type_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_phone_number_type_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_phone_number_type_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_phone_number_type_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_phone_number_type_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_phone_number_type_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_phone_number_type_desc_deduped,cont_phone_number_type_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_phone_number_type_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_phone_number_type_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_fax_nbr_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_fax_nbr) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_fax_nbr',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_fax_nbr_deduped,cont_fax_nbr,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_fax_nbr_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_fax_nbr',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_email_address_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_email_address) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_email_address',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_email_address_deduped,cont_email_address,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_email_address_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_email_address',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_web_address_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_web_address) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_web_address',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_web_address_deduped,cont_web_address,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_web_address_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_web_address',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_acres_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_acres) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_acres',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_acres_deduped,corp_acres,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_acres_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_acres',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_action_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_action) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_action',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_action_deduped,corp_action,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_action_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_action',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_action_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_action_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_action_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_action_date_deduped,corp_action_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_action_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_action_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_action_employment_security_approval_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_action_employment_security_approval_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_action_employment_security_approval_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_action_employment_security_approval_date_deduped,corp_action_employment_security_approval_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_action_employment_security_approval_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_action_employment_security_approval_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_action_pending_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_action_pending_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_action_pending_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_action_pending_cd_deduped,corp_action_pending_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_action_pending_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_action_pending_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_action_pending_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_action_pending_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_action_pending_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_action_pending_desc_deduped,corp_action_pending_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_action_pending_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_action_pending_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_action_statement_of_intent_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_action_statement_of_intent_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_action_statement_of_intent_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_action_statement_of_intent_date_deduped,corp_action_statement_of_intent_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_action_statement_of_intent_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_action_statement_of_intent_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_action_tax_dept_approval_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_action_tax_dept_approval_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_action_tax_dept_approval_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_action_tax_dept_approval_date_deduped,corp_action_tax_dept_approval_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_action_tax_dept_approval_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_action_tax_dept_approval_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_acts2_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_acts2) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_acts2',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_acts2_deduped,corp_acts2,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_acts2_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_acts2',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_acts3_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_acts3) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_acts3',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_acts3_deduped,corp_acts3,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_acts3_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_acts3',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_additional_principals_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_additional_principals) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_additional_principals',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_additional_principals_deduped,corp_additional_principals,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_additional_principals_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_additional_principals',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_address_office_type_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_address_office_type) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_address_office_type',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_address_office_type_deduped,corp_address_office_type,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_address_office_type_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_address_office_type',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_agent_assign_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_agent_assign_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_agent_assign_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_agent_assign_date_deduped,corp_agent_assign_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_agent_assign_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_agent_assign_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_agent_commercial_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_agent_commercial) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_agent_commercial',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_agent_commercial_deduped,corp_agent_commercial,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_agent_commercial_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_agent_commercial',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_agent_country_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_agent_country) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_agent_country',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_agent_country_deduped,corp_agent_country,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_agent_country_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_agent_country',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_agent_county_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_agent_county) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_agent_county',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_agent_county_deduped,corp_agent_county,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_agent_county_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_agent_county',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_agent_status_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_agent_status_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_agent_status_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_agent_status_cd_deduped,corp_agent_status_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_agent_status_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_agent_status_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_agent_status_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_agent_status_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_agent_status_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_agent_status_desc_deduped,corp_agent_status_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_agent_status_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_agent_status_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_agent_id_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_agent_id) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_agent_id',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_agent_id_deduped,corp_agent_id,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_agent_id_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_agent_id',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_agriculture_flag_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_agriculture_flag) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_agriculture_flag',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_agriculture_flag_deduped,corp_agriculture_flag,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_agriculture_flag_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_agriculture_flag',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_authorized_partners_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_authorized_partners) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_authorized_partners',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_authorized_partners_deduped,corp_authorized_partners,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_authorized_partners_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_authorized_partners',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_comment_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_comment) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_comment',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_comment_deduped,corp_comment,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_comment_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_comment',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_consent_flag_for_protected_name_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_consent_flag_for_protected_name) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_consent_flag_for_protected_name',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_consent_flag_for_protected_name_deduped,corp_consent_flag_for_protected_name,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_consent_flag_for_protected_name_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_consent_flag_for_protected_name',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_converted_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_converted) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_converted',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_converted_deduped,corp_converted,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_converted_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_converted',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_converted_from_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_converted_from) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_converted_from',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_converted_from_deduped,corp_converted_from,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_converted_from_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_converted_from',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_country_of_formation_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_country_of_formation) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_country_of_formation',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_country_of_formation_deduped,corp_country_of_formation,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_country_of_formation_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_country_of_formation',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_date_of_organization_meeting_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_date_of_organization_meeting) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_date_of_organization_meeting',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_date_of_organization_meeting_deduped,corp_date_of_organization_meeting,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_date_of_organization_meeting_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_date_of_organization_meeting',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_delayed_effective_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_delayed_effective_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_delayed_effective_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_delayed_effective_date_deduped,corp_delayed_effective_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_delayed_effective_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_delayed_effective_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_directors_from_to_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_directors_from_to) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_directors_from_to',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_directors_from_to_deduped,corp_directors_from_to,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_directors_from_to_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_directors_from_to',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_dissolved_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_dissolved_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_dissolved_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_dissolved_date_deduped,corp_dissolved_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_dissolved_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_dissolved_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_farm_exemptions_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_farm_exemptions) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_farm_exemptions',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_farm_exemptions_deduped,corp_farm_exemptions,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_farm_exemptions_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_farm_exemptions',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_farm_qual_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_farm_qual_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_farm_qual_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_farm_qual_date_deduped,corp_farm_qual_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_farm_qual_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_farm_qual_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_farm_status_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_farm_status_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_farm_status_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_farm_status_cd_deduped,corp_farm_status_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_farm_status_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_farm_status_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_farm_status_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_farm_status_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_farm_status_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_farm_status_desc_deduped,corp_farm_status_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_farm_status_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_farm_status_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_fiscal_year_month_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_fiscal_year_month) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_fiscal_year_month',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_fiscal_year_month_deduped,corp_fiscal_year_month,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_fiscal_year_month_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_fiscal_year_month',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_foreign_fiduciary_capacity_in_state_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_foreign_fiduciary_capacity_in_state) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_foreign_fiduciary_capacity_in_state',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_foreign_fiduciary_capacity_in_state_deduped,corp_foreign_fiduciary_capacity_in_state,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_foreign_fiduciary_capacity_in_state_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_foreign_fiduciary_capacity_in_state',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_governing_statute_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_governing_statute) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_governing_statute',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_governing_statute_deduped,corp_governing_statute,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_governing_statute_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_governing_statute',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_has_members_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_has_members) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_has_members',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_has_members_deduped,corp_has_members,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_has_members_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_has_members',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_has_vested_managers_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_has_vested_managers) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_has_vested_managers',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_has_vested_managers_deduped,corp_has_vested_managers,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_has_vested_managers_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_has_vested_managers',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_home_incorporated_county_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_home_incorporated_county) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_home_incorporated_county',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_home_incorporated_county_deduped,corp_home_incorporated_county,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_home_incorporated_county_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_home_incorporated_county',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_home_state_name_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_home_state_name) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_home_state_name',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_home_state_name_deduped,corp_home_state_name,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_home_state_name_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_home_state_name',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_is_professional_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_is_professional) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_is_professional',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_is_professional_deduped,corp_is_professional,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_is_professional_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_is_professional',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_is_non_profit_irs_approved_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_is_non_profit_irs_approved) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_is_non_profit_irs_approved',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_is_non_profit_irs_approved_deduped,corp_is_non_profit_irs_approved,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_is_non_profit_irs_approved_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_is_non_profit_irs_approved',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_last_renewal_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_last_renewal_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_last_renewal_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_last_renewal_date_deduped,corp_last_renewal_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_last_renewal_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_last_renewal_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_last_renewal_year_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_last_renewal_year) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_last_renewal_year',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_last_renewal_year_deduped,corp_last_renewal_year,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_last_renewal_year_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_last_renewal_year',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_license_type_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_license_type) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_license_type',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_license_type_deduped,corp_license_type,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_license_type_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_license_type',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_llc_managed_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_llc_managed_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_llc_managed_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_llc_managed_desc_deduped,corp_llc_managed_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_llc_managed_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_llc_managed_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_llc_managed_ind_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_llc_managed_ind) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_llc_managed_ind',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_llc_managed_ind_deduped,corp_llc_managed_ind,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_llc_managed_ind_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_llc_managed_ind',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_management_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_management_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_management_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_management_desc_deduped,corp_management_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_management_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_management_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_management_type_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_management_type) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_management_type',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_management_type_deduped,corp_management_type,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_management_type_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_management_type',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_manager_managed_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_manager_managed) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_manager_managed',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_manager_managed_deduped,corp_manager_managed,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_manager_managed_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_manager_managed',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_merged_corporation_id_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_merged_corporation_id) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_merged_corporation_id',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_merged_corporation_id_deduped,corp_merged_corporation_id,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_merged_corporation_id_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_merged_corporation_id',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_merged_fein_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_merged_fein) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_merged_fein',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_merged_fein_deduped,corp_merged_fein,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_merged_fein_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_merged_fein',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_merger_allowed_flag_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_merger_allowed_flag) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_merger_allowed_flag',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_merger_allowed_flag_deduped,corp_merger_allowed_flag,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_merger_allowed_flag_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_merger_allowed_flag',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_merger_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_merger_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_merger_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_merger_date_deduped,corp_merger_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_merger_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_merger_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_merger_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_merger_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_merger_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_merger_desc_deduped,corp_merger_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_merger_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_merger_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_merger_effective_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_merger_effective_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_merger_effective_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_merger_effective_date_deduped,corp_merger_effective_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_merger_effective_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_merger_effective_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_merger_id_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_merger_id) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_merger_id',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_merger_id_deduped,corp_merger_id,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_merger_id_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_merger_id',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_merger_indicator_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_merger_indicator) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_merger_indicator',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_merger_indicator_deduped,corp_merger_indicator,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_merger_indicator_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_merger_indicator',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_merger_name_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_merger_name) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_merger_name',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_merger_name_deduped,corp_merger_name,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_merger_name_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_merger_name',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_merger_type_converted_to_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_merger_type_converted_to_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_merger_type_converted_to_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_merger_type_converted_to_cd_deduped,corp_merger_type_converted_to_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_merger_type_converted_to_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_merger_type_converted_to_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_merger_type_converted_to_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_merger_type_converted_to_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_merger_type_converted_to_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_merger_type_converted_to_desc_deduped,corp_merger_type_converted_to_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_merger_type_converted_to_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_merger_type_converted_to_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_naics_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_naics_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_naics_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_naics_desc_deduped,corp_naics_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_naics_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_naics_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_name_effective_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_name_effective_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_name_effective_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_name_effective_date_deduped,corp_name_effective_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_name_effective_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_name_effective_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_name_reservation_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_name_reservation_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_name_reservation_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_name_reservation_date_deduped,corp_name_reservation_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_name_reservation_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_name_reservation_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_name_reservation_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_name_reservation_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_name_reservation_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_name_reservation_desc_deduped,corp_name_reservation_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_name_reservation_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_name_reservation_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_name_reservation_expiration_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_name_reservation_expiration_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_name_reservation_expiration_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_name_reservation_expiration_date_deduped,corp_name_reservation_expiration_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_name_reservation_expiration_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_name_reservation_expiration_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_name_reservation_nbr_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_name_reservation_nbr) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_name_reservation_nbr',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_name_reservation_nbr_deduped,corp_name_reservation_nbr,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_name_reservation_nbr_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_name_reservation_nbr',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_name_reservation_type_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_name_reservation_type) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_name_reservation_type',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_name_reservation_type_deduped,corp_name_reservation_type,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_name_reservation_type_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_name_reservation_type',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_name_status_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_name_status_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_name_status_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_name_status_cd_deduped,corp_name_status_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_name_status_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_name_status_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_name_status_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_name_status_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_name_status_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_name_status_date_deduped,corp_name_status_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_name_status_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_name_status_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_name_status_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_name_status_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_name_status_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_name_status_desc_deduped,corp_name_status_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_name_status_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_name_status_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_non_profit_irs_approved_purpose_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_non_profit_irs_approved_purpose) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_non_profit_irs_approved_purpose',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_non_profit_irs_approved_purpose_deduped,corp_non_profit_irs_approved_purpose,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_non_profit_irs_approved_purpose_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_non_profit_irs_approved_purpose',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_non_profit_solicit_donations_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_non_profit_solicit_donations) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_non_profit_solicit_donations',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_non_profit_solicit_donations_deduped,corp_non_profit_solicit_donations,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_non_profit_solicit_donations_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_non_profit_solicit_donations',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_nbr_of_amendments_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_nbr_of_amendments) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_nbr_of_amendments',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_nbr_of_amendments_deduped,corp_nbr_of_amendments,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_nbr_of_amendments_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_nbr_of_amendments',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_nbr_of_initial_llc_members_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_nbr_of_initial_llc_members) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_nbr_of_initial_llc_members',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_nbr_of_initial_llc_members_deduped,corp_nbr_of_initial_llc_members,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_nbr_of_initial_llc_members_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_nbr_of_initial_llc_members',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_nbr_of_partners_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_nbr_of_partners) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_nbr_of_partners',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_nbr_of_partners_deduped,corp_nbr_of_partners,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_nbr_of_partners_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_nbr_of_partners',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_operating_agreement_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_operating_agreement) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_operating_agreement',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_operating_agreement_deduped,corp_operating_agreement,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_operating_agreement_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_operating_agreement',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_opt_in_llc_act_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_opt_in_llc_act_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_opt_in_llc_act_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_opt_in_llc_act_desc_deduped,corp_opt_in_llc_act_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_opt_in_llc_act_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_opt_in_llc_act_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_opt_in_llc_act_ind_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_opt_in_llc_act_ind) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_opt_in_llc_act_ind',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_opt_in_llc_act_ind_deduped,corp_opt_in_llc_act_ind,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_opt_in_llc_act_ind_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_opt_in_llc_act_ind',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_organizational_comments_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_organizational_comments) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_organizational_comments',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_organizational_comments_deduped,corp_organizational_comments,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_organizational_comments_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_organizational_comments',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_partner_contributions_total_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_partner_contributions_total) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_partner_contributions_total',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_partner_contributions_total_deduped,corp_partner_contributions_total,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_partner_contributions_total_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_partner_contributions_total',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_partner_terms_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_partner_terms) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_partner_terms',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_partner_terms_deduped,corp_partner_terms,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_partner_terms_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_partner_terms',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_percentage_voters_required_to_approve_amendments_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_percentage_voters_required_to_approve_amendments) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_percentage_voters_required_to_approve_amendments',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_percentage_voters_required_to_approve_amendments_deduped,corp_percentage_voters_required_to_approve_amendments,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_percentage_voters_required_to_approve_amendments_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_percentage_voters_required_to_approve_amendments',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_profession_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_profession) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_profession',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_profession_deduped,corp_profession,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_profession_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_profession',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_province_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_province) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_province',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_province_deduped,corp_province,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_province_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_province',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_public_mutual_corporation_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_public_mutual_corporation) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_public_mutual_corporation',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_public_mutual_corporation_deduped,corp_public_mutual_corporation,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_public_mutual_corporation_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_public_mutual_corporation',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_purpose_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_purpose) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_purpose',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_purpose_deduped,corp_purpose,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_purpose_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_purpose',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_ra_required_flag_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_ra_required_flag) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_ra_required_flag',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_ra_required_flag_deduped,corp_ra_required_flag,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_ra_required_flag_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_ra_required_flag',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_registered_counties_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_registered_counties) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_registered_counties',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_registered_counties_deduped,corp_registered_counties,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_registered_counties_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_registered_counties',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_regulated_ind_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_regulated_ind) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_regulated_ind',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_regulated_ind_deduped,corp_regulated_ind,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_regulated_ind_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_regulated_ind',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_renewal_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_renewal_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_renewal_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_renewal_date_deduped,corp_renewal_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_renewal_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_renewal_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_standing_other_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_standing_other) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_standing_other',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_standing_other_deduped,corp_standing_other,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_standing_other_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_standing_other',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_survivor_corporation_id_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_survivor_corporation_id) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_survivor_corporation_id',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_survivor_corporation_id_deduped,corp_survivor_corporation_id,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_survivor_corporation_id_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_survivor_corporation_id',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_tax_base_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_tax_base) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_tax_base',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_tax_base_deduped,corp_tax_base,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_tax_base_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_tax_base',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_tax_standing_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_tax_standing) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_tax_standing',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_tax_standing_deduped,corp_tax_standing,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_tax_standing_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_tax_standing',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_termination_cd_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_termination_cd) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_termination_cd',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_termination_cd_deduped,corp_termination_cd,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_termination_cd_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_termination_cd',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_termination_desc_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_termination_desc) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_termination_desc',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_termination_desc_deduped,corp_termination_desc,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_termination_desc_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_termination_desc',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_termination_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_termination_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_termination_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_termination_date_deduped,corp_termination_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_termination_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_termination_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_business_mark_type_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_business_mark_type) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_business_mark_type',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_business_mark_type_deduped,corp_trademark_business_mark_type,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_business_mark_type_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_business_mark_type',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_cancelled_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_cancelled_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_cancelled_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_cancelled_date_deduped,corp_trademark_cancelled_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_cancelled_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_cancelled_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_class_desc1_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_class_desc1) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_class_desc1',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_class_desc1_deduped,corp_trademark_class_desc1,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_class_desc1_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_class_desc1',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_class_desc2_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_class_desc2) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_class_desc2',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_class_desc2_deduped,corp_trademark_class_desc2,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_class_desc2_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_class_desc2',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_class_desc3_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_class_desc3) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_class_desc3',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_class_desc3_deduped,corp_trademark_class_desc3,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_class_desc3_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_class_desc3',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_class_desc4_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_class_desc4) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_class_desc4',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_class_desc4_deduped,corp_trademark_class_desc4,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_class_desc4_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_class_desc4',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_class_desc5_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_class_desc5) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_class_desc5',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_class_desc5_deduped,corp_trademark_class_desc5,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_class_desc5_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_class_desc5',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_class_desc6_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_class_desc6) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_class_desc6',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_class_desc6_deduped,corp_trademark_class_desc6,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_class_desc6_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_class_desc6',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_classification_nbr_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_classification_nbr) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_classification_nbr',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_classification_nbr_deduped,corp_trademark_classification_nbr,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_classification_nbr_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_classification_nbr',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_disclaimer1_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_disclaimer1) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_disclaimer1',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_disclaimer1_deduped,corp_trademark_disclaimer1,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_disclaimer1_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_disclaimer1',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_disclaimer2_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_disclaimer2) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_disclaimer2',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_disclaimer2_deduped,corp_trademark_disclaimer2,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_disclaimer2_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_disclaimer2',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_expiration_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_expiration_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_expiration_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_expiration_date_deduped,corp_trademark_expiration_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_expiration_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_expiration_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_filing_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_filing_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_filing_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_filing_date_deduped,corp_trademark_filing_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_filing_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_filing_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_first_use_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_first_use_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_first_use_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_first_use_date_deduped,corp_trademark_first_use_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_first_use_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_first_use_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_first_use_date_in_state_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_first_use_date_in_state) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_first_use_date_in_state',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_first_use_date_in_state_deduped,corp_trademark_first_use_date_in_state,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_first_use_date_in_state_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_first_use_date_in_state',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_keywords_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_keywords) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_keywords',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_keywords_deduped,corp_trademark_keywords,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_keywords_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_keywords',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_logo_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_logo) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_logo',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_logo_deduped,corp_trademark_logo,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_logo_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_logo',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_name_expiration_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_name_expiration_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_name_expiration_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_name_expiration_date_deduped,corp_trademark_name_expiration_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_name_expiration_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_name_expiration_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_nbr_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_nbr) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_nbr',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_nbr_deduped,corp_trademark_nbr,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_nbr_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_nbr',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_renewal_date_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_renewal_date) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_renewal_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_renewal_date_deduped,corp_trademark_renewal_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_renewal_date_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_renewal_date',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_status_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_status) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_status',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_status_deduped,corp_trademark_status,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_status_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_status',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_used_1_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_used_1) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_used_1',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_used_1_deduped,corp_trademark_used_1,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_used_1_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_used_1',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_used_2_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_used_2) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_used_2',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_used_2_deduped,corp_trademark_used_2,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_used_2_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_used_2',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_trademark_used_3_deduped := SALT34.MAC_Field_By_UID(input_file,,corp_trademark_used_3) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::corp_trademark_used_3',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(corp_trademark_used_3_deduped,corp_trademark_used_3,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT corp_trademark_used_3_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::corp_trademark_used_3',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_owner_percentage_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_owner_percentage) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_owner_percentage',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_owner_percentage_deduped,cont_owner_percentage,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_owner_percentage_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_owner_percentage',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_country_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_country) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_country',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_country_deduped,cont_country,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_country_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_country',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_country_mailing_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_country_mailing) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_country_mailing',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_country_mailing_deduped,cont_country_mailing,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_country_mailing_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_country_mailing',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_nondislosure_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_nondislosure) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_nondislosure',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_nondislosure_deduped,cont_nondislosure,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_nondislosure_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_nondislosure',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_prep_addr_line1_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_prep_addr_line1) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_prep_addr_line1',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_prep_addr_line1_deduped,cont_prep_addr_line1,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_prep_addr_line1_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_prep_addr_line1',EXPIRE(Config.PersistExpire));
 
EXPORT  cont_prep_addr_last_line_deduped := SALT34.MAC_Field_By_UID(input_file,,cont_prep_addr_last_line) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::cont_prep_addr_last_line',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(cont_prep_addr_last_line_deduped,cont_prep_addr_last_line,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cont_prep_addr_last_line_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::cont_prep_addr_last_line',EXPIRE(Config.PersistExpire));
 
EXPORT  recordorigin_deduped := SALT34.MAC_Field_By_UID(input_file,,recordorigin) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::dedups::recordorigin',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(recordorigin_deduped,recordorigin,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT recordorigin_values_persisted := specs_added : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::values::recordorigin',EXPIRE(Config.PersistExpire));
SALT34.MAC_Field_Nulls(dt_vendor_first_reported_year_values_persisted,Layout_Specificities.dt_vendor_first_reported_year_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_vendor_first_reported_year_nulls := nv;
SALT34.MAC_Field_Bfoul(dt_vendor_first_reported_year_deduped,dt_vendor_first_reported_year,,dt_vendor_first_reported_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_vendor_first_reported_year_switch := bf;
EXPORT dt_vendor_first_reported_year_max := MAX(dt_vendor_first_reported_year_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(dt_vendor_first_reported_year_values_persisted,dt_vendor_first_reported_year,dt_vendor_first_reported_year_nulls,ol) // Compute column level specificity
EXPORT dt_vendor_first_reported_year_specificity := ol;
SALT34.MAC_Field_Nulls(dt_vendor_first_reported_month_values_persisted,Layout_Specificities.dt_vendor_first_reported_month_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_vendor_first_reported_month_nulls := nv;
SALT34.MAC_Field_Bfoul(dt_vendor_first_reported_month_deduped,dt_vendor_first_reported_month,,dt_vendor_first_reported_month_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_vendor_first_reported_month_switch := bf;
EXPORT dt_vendor_first_reported_month_max := MAX(dt_vendor_first_reported_month_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(dt_vendor_first_reported_month_values_persisted,dt_vendor_first_reported_month,dt_vendor_first_reported_month_nulls,ol) // Compute column level specificity
EXPORT dt_vendor_first_reported_month_specificity := ol;
SALT34.MAC_Field_Nulls(dt_vendor_first_reported_day_values_persisted,Layout_Specificities.dt_vendor_first_reported_day_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_vendor_first_reported_day_nulls := nv;
SALT34.MAC_Field_Bfoul(dt_vendor_first_reported_day_deduped,dt_vendor_first_reported_day,,dt_vendor_first_reported_day_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_vendor_first_reported_day_switch := bf;
EXPORT dt_vendor_first_reported_day_max := MAX(dt_vendor_first_reported_day_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(dt_vendor_first_reported_day_values_persisted,dt_vendor_first_reported_day,dt_vendor_first_reported_day_nulls,ol) // Compute column level specificity
EXPORT dt_vendor_first_reported_day_specificity := ol;
SALT34.MAC_Field_Nulls(dt_vendor_last_reported_year_values_persisted,Layout_Specificities.dt_vendor_last_reported_year_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_vendor_last_reported_year_nulls := nv;
SALT34.MAC_Field_Bfoul(dt_vendor_last_reported_year_deduped,dt_vendor_last_reported_year,,dt_vendor_last_reported_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_vendor_last_reported_year_switch := bf;
EXPORT dt_vendor_last_reported_year_max := MAX(dt_vendor_last_reported_year_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(dt_vendor_last_reported_year_values_persisted,dt_vendor_last_reported_year,dt_vendor_last_reported_year_nulls,ol) // Compute column level specificity
EXPORT dt_vendor_last_reported_year_specificity := ol;
SALT34.MAC_Field_Nulls(dt_vendor_last_reported_month_values_persisted,Layout_Specificities.dt_vendor_last_reported_month_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_vendor_last_reported_month_nulls := nv;
SALT34.MAC_Field_Bfoul(dt_vendor_last_reported_month_deduped,dt_vendor_last_reported_month,,dt_vendor_last_reported_month_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_vendor_last_reported_month_switch := bf;
EXPORT dt_vendor_last_reported_month_max := MAX(dt_vendor_last_reported_month_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(dt_vendor_last_reported_month_values_persisted,dt_vendor_last_reported_month,dt_vendor_last_reported_month_nulls,ol) // Compute column level specificity
EXPORT dt_vendor_last_reported_month_specificity := ol;
SALT34.MAC_Field_Nulls(dt_vendor_last_reported_day_values_persisted,Layout_Specificities.dt_vendor_last_reported_day_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_vendor_last_reported_day_nulls := nv;
SALT34.MAC_Field_Bfoul(dt_vendor_last_reported_day_deduped,dt_vendor_last_reported_day,,dt_vendor_last_reported_day_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_vendor_last_reported_day_switch := bf;
EXPORT dt_vendor_last_reported_day_max := MAX(dt_vendor_last_reported_day_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(dt_vendor_last_reported_day_values_persisted,dt_vendor_last_reported_day,dt_vendor_last_reported_day_nulls,ol) // Compute column level specificity
EXPORT dt_vendor_last_reported_day_specificity := ol;
SALT34.MAC_Field_Nulls(dt_first_seen_year_values_persisted,Layout_Specificities.dt_first_seen_year_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_first_seen_year_nulls := nv;
SALT34.MAC_Field_Bfoul(dt_first_seen_year_deduped,dt_first_seen_year,,dt_first_seen_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_first_seen_year_switch := bf;
EXPORT dt_first_seen_year_max := MAX(dt_first_seen_year_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(dt_first_seen_year_values_persisted,dt_first_seen_year,dt_first_seen_year_nulls,ol) // Compute column level specificity
EXPORT dt_first_seen_year_specificity := ol;
SALT34.MAC_Field_Nulls(dt_first_seen_month_values_persisted,Layout_Specificities.dt_first_seen_month_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_first_seen_month_nulls := nv;
SALT34.MAC_Field_Bfoul(dt_first_seen_month_deduped,dt_first_seen_month,,dt_first_seen_month_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_first_seen_month_switch := bf;
EXPORT dt_first_seen_month_max := MAX(dt_first_seen_month_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(dt_first_seen_month_values_persisted,dt_first_seen_month,dt_first_seen_month_nulls,ol) // Compute column level specificity
EXPORT dt_first_seen_month_specificity := ol;
SALT34.MAC_Field_Nulls(dt_first_seen_day_values_persisted,Layout_Specificities.dt_first_seen_day_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_first_seen_day_nulls := nv;
SALT34.MAC_Field_Bfoul(dt_first_seen_day_deduped,dt_first_seen_day,,dt_first_seen_day_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_first_seen_day_switch := bf;
EXPORT dt_first_seen_day_max := MAX(dt_first_seen_day_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(dt_first_seen_day_values_persisted,dt_first_seen_day,dt_first_seen_day_nulls,ol) // Compute column level specificity
EXPORT dt_first_seen_day_specificity := ol;
SALT34.MAC_Field_Nulls(dt_last_seen_year_values_persisted,Layout_Specificities.dt_last_seen_year_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_last_seen_year_nulls := nv;
SALT34.MAC_Field_Bfoul(dt_last_seen_year_deduped,dt_last_seen_year,,dt_last_seen_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_last_seen_year_switch := bf;
EXPORT dt_last_seen_year_max := MAX(dt_last_seen_year_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(dt_last_seen_year_values_persisted,dt_last_seen_year,dt_last_seen_year_nulls,ol) // Compute column level specificity
EXPORT dt_last_seen_year_specificity := ol;
SALT34.MAC_Field_Nulls(dt_last_seen_month_values_persisted,Layout_Specificities.dt_last_seen_month_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_last_seen_month_nulls := nv;
SALT34.MAC_Field_Bfoul(dt_last_seen_month_deduped,dt_last_seen_month,,dt_last_seen_month_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_last_seen_month_switch := bf;
EXPORT dt_last_seen_month_max := MAX(dt_last_seen_month_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(dt_last_seen_month_values_persisted,dt_last_seen_month,dt_last_seen_month_nulls,ol) // Compute column level specificity
EXPORT dt_last_seen_month_specificity := ol;
SALT34.MAC_Field_Nulls(dt_last_seen_day_values_persisted,Layout_Specificities.dt_last_seen_day_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_last_seen_day_nulls := nv;
SALT34.MAC_Field_Bfoul(dt_last_seen_day_deduped,dt_last_seen_day,,dt_last_seen_day_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_last_seen_day_switch := bf;
EXPORT dt_last_seen_day_max := MAX(dt_last_seen_day_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(dt_last_seen_day_values_persisted,dt_last_seen_day,dt_last_seen_day_nulls,ol) // Compute column level specificity
EXPORT dt_last_seen_day_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_dt_first_seen_year_values_persisted,Layout_Specificities.corp_ra_dt_first_seen_year_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_dt_first_seen_year_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_dt_first_seen_year_deduped,corp_ra_dt_first_seen_year,,corp_ra_dt_first_seen_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_dt_first_seen_year_switch := bf;
EXPORT corp_ra_dt_first_seen_year_max := MAX(corp_ra_dt_first_seen_year_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_dt_first_seen_year_values_persisted,corp_ra_dt_first_seen_year,corp_ra_dt_first_seen_year_nulls,ol) // Compute column level specificity
EXPORT corp_ra_dt_first_seen_year_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_dt_first_seen_month_values_persisted,Layout_Specificities.corp_ra_dt_first_seen_month_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_dt_first_seen_month_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_dt_first_seen_month_deduped,corp_ra_dt_first_seen_month,,corp_ra_dt_first_seen_month_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_dt_first_seen_month_switch := bf;
EXPORT corp_ra_dt_first_seen_month_max := MAX(corp_ra_dt_first_seen_month_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_dt_first_seen_month_values_persisted,corp_ra_dt_first_seen_month,corp_ra_dt_first_seen_month_nulls,ol) // Compute column level specificity
EXPORT corp_ra_dt_first_seen_month_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_dt_first_seen_day_values_persisted,Layout_Specificities.corp_ra_dt_first_seen_day_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_dt_first_seen_day_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_dt_first_seen_day_deduped,corp_ra_dt_first_seen_day,,corp_ra_dt_first_seen_day_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_dt_first_seen_day_switch := bf;
EXPORT corp_ra_dt_first_seen_day_max := MAX(corp_ra_dt_first_seen_day_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_dt_first_seen_day_values_persisted,corp_ra_dt_first_seen_day,corp_ra_dt_first_seen_day_nulls,ol) // Compute column level specificity
EXPORT corp_ra_dt_first_seen_day_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_dt_last_seen_year_values_persisted,Layout_Specificities.corp_ra_dt_last_seen_year_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_dt_last_seen_year_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_dt_last_seen_year_deduped,corp_ra_dt_last_seen_year,,corp_ra_dt_last_seen_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_dt_last_seen_year_switch := bf;
EXPORT corp_ra_dt_last_seen_year_max := MAX(corp_ra_dt_last_seen_year_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_dt_last_seen_year_values_persisted,corp_ra_dt_last_seen_year,corp_ra_dt_last_seen_year_nulls,ol) // Compute column level specificity
EXPORT corp_ra_dt_last_seen_year_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_dt_last_seen_month_values_persisted,Layout_Specificities.corp_ra_dt_last_seen_month_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_dt_last_seen_month_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_dt_last_seen_month_deduped,corp_ra_dt_last_seen_month,,corp_ra_dt_last_seen_month_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_dt_last_seen_month_switch := bf;
EXPORT corp_ra_dt_last_seen_month_max := MAX(corp_ra_dt_last_seen_month_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_dt_last_seen_month_values_persisted,corp_ra_dt_last_seen_month,corp_ra_dt_last_seen_month_nulls,ol) // Compute column level specificity
EXPORT corp_ra_dt_last_seen_month_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_dt_last_seen_day_values_persisted,Layout_Specificities.corp_ra_dt_last_seen_day_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_dt_last_seen_day_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_dt_last_seen_day_deduped,corp_ra_dt_last_seen_day,,corp_ra_dt_last_seen_day_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_dt_last_seen_day_switch := bf;
EXPORT corp_ra_dt_last_seen_day_max := MAX(corp_ra_dt_last_seen_day_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_dt_last_seen_day_values_persisted,corp_ra_dt_last_seen_day,corp_ra_dt_last_seen_day_nulls,ol) // Compute column level specificity
EXPORT corp_ra_dt_last_seen_day_specificity := ol;
SALT34.MAC_Field_Nulls(corp_key_values_persisted,Layout_Specificities.corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_key_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_key_deduped,corp_key,,corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_key_switch := bf;
EXPORT corp_key_max := MAX(corp_key_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_key_values_persisted,corp_key,corp_key_nulls,ol) // Compute column level specificity
EXPORT corp_key_specificity := ol;
SALT34.MAC_Field_Nulls(corp_supp_key_values_persisted,Layout_Specificities.corp_supp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_supp_key_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_supp_key_deduped,corp_supp_key,,corp_supp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_supp_key_switch := bf;
EXPORT corp_supp_key_max := MAX(corp_supp_key_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_supp_key_values_persisted,corp_supp_key,corp_supp_key_nulls,ol) // Compute column level specificity
EXPORT corp_supp_key_specificity := ol;
SALT34.MAC_Field_Nulls(corp_vendor_values_persisted,Layout_Specificities.corp_vendor_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_vendor_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_vendor_deduped,corp_vendor,,corp_vendor_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_vendor_switch := bf;
EXPORT corp_vendor_max := MAX(corp_vendor_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_vendor_values_persisted,corp_vendor,corp_vendor_nulls,ol) // Compute column level specificity
EXPORT corp_vendor_specificity := ol;
SALT34.MAC_Field_Nulls(corp_vendor_county_values_persisted,Layout_Specificities.corp_vendor_county_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_vendor_county_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_vendor_county_deduped,corp_vendor_county,,corp_vendor_county_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_vendor_county_switch := bf;
EXPORT corp_vendor_county_max := MAX(corp_vendor_county_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_vendor_county_values_persisted,corp_vendor_county,corp_vendor_county_nulls,ol) // Compute column level specificity
EXPORT corp_vendor_county_specificity := ol;
SALT34.MAC_Field_Nulls(corp_vendor_subcode_values_persisted,Layout_Specificities.corp_vendor_subcode_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_vendor_subcode_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_vendor_subcode_deduped,corp_vendor_subcode,,corp_vendor_subcode_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_vendor_subcode_switch := bf;
EXPORT corp_vendor_subcode_max := MAX(corp_vendor_subcode_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_vendor_subcode_values_persisted,corp_vendor_subcode,corp_vendor_subcode_nulls,ol) // Compute column level specificity
EXPORT corp_vendor_subcode_specificity := ol;
SALT34.MAC_Field_Nulls(corp_state_origin_values_persisted,Layout_Specificities.corp_state_origin_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_state_origin_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_state_origin_deduped,corp_state_origin,,corp_state_origin_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_state_origin_switch := bf;
EXPORT corp_state_origin_max := MAX(corp_state_origin_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_state_origin_values_persisted,corp_state_origin,corp_state_origin_nulls,ol) // Compute column level specificity
EXPORT corp_state_origin_specificity := ol;
SALT34.MAC_Field_Nulls(corp_process_date_year_values_persisted,Layout_Specificities.corp_process_date_year_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_process_date_year_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_process_date_year_deduped,corp_process_date_year,,corp_process_date_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_process_date_year_switch := bf;
EXPORT corp_process_date_year_max := MAX(corp_process_date_year_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_process_date_year_values_persisted,corp_process_date_year,corp_process_date_year_nulls,ol) // Compute column level specificity
EXPORT corp_process_date_year_specificity := ol;
SALT34.MAC_Field_Nulls(corp_process_date_month_values_persisted,Layout_Specificities.corp_process_date_month_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_process_date_month_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_process_date_month_deduped,corp_process_date_month,,corp_process_date_month_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_process_date_month_switch := bf;
EXPORT corp_process_date_month_max := MAX(corp_process_date_month_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_process_date_month_values_persisted,corp_process_date_month,corp_process_date_month_nulls,ol) // Compute column level specificity
EXPORT corp_process_date_month_specificity := ol;
SALT34.MAC_Field_Nulls(corp_process_date_day_values_persisted,Layout_Specificities.corp_process_date_day_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_process_date_day_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_process_date_day_deduped,corp_process_date_day,,corp_process_date_day_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_process_date_day_switch := bf;
EXPORT corp_process_date_day_max := MAX(corp_process_date_day_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_process_date_day_values_persisted,corp_process_date_day,corp_process_date_day_nulls,ol) // Compute column level specificity
EXPORT corp_process_date_day_specificity := ol;
SALT34.MAC_Field_Nulls(corp_orig_sos_charter_nbr_values_persisted,Layout_Specificities.corp_orig_sos_charter_nbr_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_orig_sos_charter_nbr_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_orig_sos_charter_nbr_deduped,corp_orig_sos_charter_nbr,,corp_orig_sos_charter_nbr_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_orig_sos_charter_nbr_switch := bf;
EXPORT corp_orig_sos_charter_nbr_max := MAX(corp_orig_sos_charter_nbr_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_orig_sos_charter_nbr_values_persisted,corp_orig_sos_charter_nbr,corp_orig_sos_charter_nbr_nulls,ol) // Compute column level specificity
EXPORT corp_orig_sos_charter_nbr_specificity := ol;
SALT34.MAC_Field_Nulls(corp_legal_name_values_persisted,Layout_Specificities.corp_legal_name_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_legal_name_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_legal_name_deduped,corp_legal_name,,corp_legal_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_legal_name_switch := bf;
EXPORT corp_legal_name_max := MAX(corp_legal_name_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_legal_name_values_persisted,corp_legal_name,corp_legal_name_nulls,ol) // Compute column level specificity
EXPORT corp_legal_name_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ln_name_type_cd_values_persisted,Layout_Specificities.corp_ln_name_type_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ln_name_type_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ln_name_type_cd_deduped,corp_ln_name_type_cd,,corp_ln_name_type_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ln_name_type_cd_switch := bf;
EXPORT corp_ln_name_type_cd_max := MAX(corp_ln_name_type_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ln_name_type_cd_values_persisted,corp_ln_name_type_cd,corp_ln_name_type_cd_nulls,ol) // Compute column level specificity
EXPORT corp_ln_name_type_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ln_name_type_desc_values_persisted,Layout_Specificities.corp_ln_name_type_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ln_name_type_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ln_name_type_desc_deduped,corp_ln_name_type_desc,,corp_ln_name_type_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ln_name_type_desc_switch := bf;
EXPORT corp_ln_name_type_desc_max := MAX(corp_ln_name_type_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ln_name_type_desc_values_persisted,corp_ln_name_type_desc,corp_ln_name_type_desc_nulls,ol) // Compute column level specificity
EXPORT corp_ln_name_type_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_supp_nbr_values_persisted,Layout_Specificities.corp_supp_nbr_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_supp_nbr_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_supp_nbr_deduped,corp_supp_nbr,,corp_supp_nbr_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_supp_nbr_switch := bf;
EXPORT corp_supp_nbr_max := MAX(corp_supp_nbr_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_supp_nbr_values_persisted,corp_supp_nbr,corp_supp_nbr_nulls,ol) // Compute column level specificity
EXPORT corp_supp_nbr_specificity := ol;
SALT34.MAC_Field_Nulls(corp_name_comment_values_persisted,Layout_Specificities.corp_name_comment_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_name_comment_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_name_comment_deduped,corp_name_comment,,corp_name_comment_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_name_comment_switch := bf;
EXPORT corp_name_comment_max := MAX(corp_name_comment_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_name_comment_values_persisted,corp_name_comment,corp_name_comment_nulls,ol) // Compute column level specificity
EXPORT corp_name_comment_specificity := ol;
SALT34.MAC_Field_Nulls(corp_address1_type_cd_values_persisted,Layout_Specificities.corp_address1_type_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_address1_type_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_address1_type_cd_deduped,corp_address1_type_cd,,corp_address1_type_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_address1_type_cd_switch := bf;
EXPORT corp_address1_type_cd_max := MAX(corp_address1_type_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_address1_type_cd_values_persisted,corp_address1_type_cd,corp_address1_type_cd_nulls,ol) // Compute column level specificity
EXPORT corp_address1_type_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_address1_type_desc_values_persisted,Layout_Specificities.corp_address1_type_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_address1_type_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_address1_type_desc_deduped,corp_address1_type_desc,,corp_address1_type_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_address1_type_desc_switch := bf;
EXPORT corp_address1_type_desc_max := MAX(corp_address1_type_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_address1_type_desc_values_persisted,corp_address1_type_desc,corp_address1_type_desc_nulls,ol) // Compute column level specificity
EXPORT corp_address1_type_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_address1_line1_values_persisted,Layout_Specificities.corp_address1_line1_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_address1_line1_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_address1_line1_deduped,corp_address1_line1,,corp_address1_line1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_address1_line1_switch := bf;
EXPORT corp_address1_line1_max := MAX(corp_address1_line1_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_address1_line1_values_persisted,corp_address1_line1,corp_address1_line1_nulls,ol) // Compute column level specificity
EXPORT corp_address1_line1_specificity := ol;
SALT34.MAC_Field_Nulls(corp_address1_line2_values_persisted,Layout_Specificities.corp_address1_line2_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_address1_line2_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_address1_line2_deduped,corp_address1_line2,,corp_address1_line2_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_address1_line2_switch := bf;
EXPORT corp_address1_line2_max := MAX(corp_address1_line2_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_address1_line2_values_persisted,corp_address1_line2,corp_address1_line2_nulls,ol) // Compute column level specificity
EXPORT corp_address1_line2_specificity := ol;
SALT34.MAC_Field_Nulls(corp_address1_line3_values_persisted,Layout_Specificities.corp_address1_line3_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_address1_line3_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_address1_line3_deduped,corp_address1_line3,,corp_address1_line3_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_address1_line3_switch := bf;
EXPORT corp_address1_line3_max := MAX(corp_address1_line3_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_address1_line3_values_persisted,corp_address1_line3,corp_address1_line3_nulls,ol) // Compute column level specificity
EXPORT corp_address1_line3_specificity := ol;
SALT34.MAC_Field_Nulls(corp_address1_effective_date_values_persisted,Layout_Specificities.corp_address1_effective_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_address1_effective_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_address1_effective_date_deduped,corp_address1_effective_date,,corp_address1_effective_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_address1_effective_date_switch := bf;
EXPORT corp_address1_effective_date_max := MAX(corp_address1_effective_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_address1_effective_date_values_persisted,corp_address1_effective_date,corp_address1_effective_date_nulls,ol) // Compute column level specificity
EXPORT corp_address1_effective_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_address2_type_cd_values_persisted,Layout_Specificities.corp_address2_type_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_address2_type_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_address2_type_cd_deduped,corp_address2_type_cd,,corp_address2_type_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_address2_type_cd_switch := bf;
EXPORT corp_address2_type_cd_max := MAX(corp_address2_type_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_address2_type_cd_values_persisted,corp_address2_type_cd,corp_address2_type_cd_nulls,ol) // Compute column level specificity
EXPORT corp_address2_type_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_address2_type_desc_values_persisted,Layout_Specificities.corp_address2_type_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_address2_type_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_address2_type_desc_deduped,corp_address2_type_desc,,corp_address2_type_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_address2_type_desc_switch := bf;
EXPORT corp_address2_type_desc_max := MAX(corp_address2_type_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_address2_type_desc_values_persisted,corp_address2_type_desc,corp_address2_type_desc_nulls,ol) // Compute column level specificity
EXPORT corp_address2_type_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_address2_line1_values_persisted,Layout_Specificities.corp_address2_line1_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_address2_line1_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_address2_line1_deduped,corp_address2_line1,,corp_address2_line1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_address2_line1_switch := bf;
EXPORT corp_address2_line1_max := MAX(corp_address2_line1_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_address2_line1_values_persisted,corp_address2_line1,corp_address2_line1_nulls,ol) // Compute column level specificity
EXPORT corp_address2_line1_specificity := ol;
SALT34.MAC_Field_Nulls(corp_address2_line2_values_persisted,Layout_Specificities.corp_address2_line2_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_address2_line2_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_address2_line2_deduped,corp_address2_line2,,corp_address2_line2_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_address2_line2_switch := bf;
EXPORT corp_address2_line2_max := MAX(corp_address2_line2_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_address2_line2_values_persisted,corp_address2_line2,corp_address2_line2_nulls,ol) // Compute column level specificity
EXPORT corp_address2_line2_specificity := ol;
SALT34.MAC_Field_Nulls(corp_address2_line3_values_persisted,Layout_Specificities.corp_address2_line3_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_address2_line3_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_address2_line3_deduped,corp_address2_line3,,corp_address2_line3_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_address2_line3_switch := bf;
EXPORT corp_address2_line3_max := MAX(corp_address2_line3_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_address2_line3_values_persisted,corp_address2_line3,corp_address2_line3_nulls,ol) // Compute column level specificity
EXPORT corp_address2_line3_specificity := ol;
SALT34.MAC_Field_Nulls(corp_address2_effective_date_values_persisted,Layout_Specificities.corp_address2_effective_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_address2_effective_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_address2_effective_date_deduped,corp_address2_effective_date,,corp_address2_effective_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_address2_effective_date_switch := bf;
EXPORT corp_address2_effective_date_max := MAX(corp_address2_effective_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_address2_effective_date_values_persisted,corp_address2_effective_date,corp_address2_effective_date_nulls,ol) // Compute column level specificity
EXPORT corp_address2_effective_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_phone_number_values_persisted,Layout_Specificities.corp_phone_number_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_phone_number_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_phone_number_deduped,corp_phone_number,,corp_phone_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_phone_number_switch := bf;
EXPORT corp_phone_number_max := MAX(corp_phone_number_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_phone_number_values_persisted,corp_phone_number,corp_phone_number_nulls,ol) // Compute column level specificity
EXPORT corp_phone_number_specificity := ol;
SALT34.MAC_Field_Nulls(corp_phone_number_type_cd_values_persisted,Layout_Specificities.corp_phone_number_type_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_phone_number_type_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_phone_number_type_cd_deduped,corp_phone_number_type_cd,,corp_phone_number_type_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_phone_number_type_cd_switch := bf;
EXPORT corp_phone_number_type_cd_max := MAX(corp_phone_number_type_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_phone_number_type_cd_values_persisted,corp_phone_number_type_cd,corp_phone_number_type_cd_nulls,ol) // Compute column level specificity
EXPORT corp_phone_number_type_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_phone_number_type_desc_values_persisted,Layout_Specificities.corp_phone_number_type_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_phone_number_type_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_phone_number_type_desc_deduped,corp_phone_number_type_desc,,corp_phone_number_type_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_phone_number_type_desc_switch := bf;
EXPORT corp_phone_number_type_desc_max := MAX(corp_phone_number_type_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_phone_number_type_desc_values_persisted,corp_phone_number_type_desc,corp_phone_number_type_desc_nulls,ol) // Compute column level specificity
EXPORT corp_phone_number_type_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_fax_nbr_values_persisted,Layout_Specificities.corp_fax_nbr_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_fax_nbr_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_fax_nbr_deduped,corp_fax_nbr,,corp_fax_nbr_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_fax_nbr_switch := bf;
EXPORT corp_fax_nbr_max := MAX(corp_fax_nbr_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_fax_nbr_values_persisted,corp_fax_nbr,corp_fax_nbr_nulls,ol) // Compute column level specificity
EXPORT corp_fax_nbr_specificity := ol;
SALT34.MAC_Field_Nulls(corp_email_address_values_persisted,Layout_Specificities.corp_email_address_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_email_address_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_email_address_deduped,corp_email_address,,corp_email_address_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_email_address_switch := bf;
EXPORT corp_email_address_max := MAX(corp_email_address_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_email_address_values_persisted,corp_email_address,corp_email_address_nulls,ol) // Compute column level specificity
EXPORT corp_email_address_specificity := ol;
SALT34.MAC_Field_Nulls(corp_web_address_values_persisted,Layout_Specificities.corp_web_address_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_web_address_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_web_address_deduped,corp_web_address,,corp_web_address_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_web_address_switch := bf;
EXPORT corp_web_address_max := MAX(corp_web_address_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_web_address_values_persisted,corp_web_address,corp_web_address_nulls,ol) // Compute column level specificity
EXPORT corp_web_address_specificity := ol;
SALT34.MAC_Field_Nulls(corp_filing_reference_nbr_values_persisted,Layout_Specificities.corp_filing_reference_nbr_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_filing_reference_nbr_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_filing_reference_nbr_deduped,corp_filing_reference_nbr,,corp_filing_reference_nbr_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_filing_reference_nbr_switch := bf;
EXPORT corp_filing_reference_nbr_max := MAX(corp_filing_reference_nbr_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_filing_reference_nbr_values_persisted,corp_filing_reference_nbr,corp_filing_reference_nbr_nulls,ol) // Compute column level specificity
EXPORT corp_filing_reference_nbr_specificity := ol;
SALT34.MAC_Field_Nulls(corp_filing_date_values_persisted,Layout_Specificities.corp_filing_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_filing_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_filing_date_deduped,corp_filing_date,,corp_filing_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_filing_date_switch := bf;
EXPORT corp_filing_date_max := MAX(corp_filing_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_filing_date_values_persisted,corp_filing_date,corp_filing_date_nulls,ol) // Compute column level specificity
EXPORT corp_filing_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_filing_cd_values_persisted,Layout_Specificities.corp_filing_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_filing_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_filing_cd_deduped,corp_filing_cd,,corp_filing_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_filing_cd_switch := bf;
EXPORT corp_filing_cd_max := MAX(corp_filing_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_filing_cd_values_persisted,corp_filing_cd,corp_filing_cd_nulls,ol) // Compute column level specificity
EXPORT corp_filing_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_filing_desc_values_persisted,Layout_Specificities.corp_filing_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_filing_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_filing_desc_deduped,corp_filing_desc,,corp_filing_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_filing_desc_switch := bf;
EXPORT corp_filing_desc_max := MAX(corp_filing_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_filing_desc_values_persisted,corp_filing_desc,corp_filing_desc_nulls,ol) // Compute column level specificity
EXPORT corp_filing_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_status_cd_values_persisted,Layout_Specificities.corp_status_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_status_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_status_cd_deduped,corp_status_cd,,corp_status_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_status_cd_switch := bf;
EXPORT corp_status_cd_max := MAX(corp_status_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_status_cd_values_persisted,corp_status_cd,corp_status_cd_nulls,ol) // Compute column level specificity
EXPORT corp_status_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_status_desc_values_persisted,Layout_Specificities.corp_status_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_status_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_status_desc_deduped,corp_status_desc,,corp_status_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_status_desc_switch := bf;
EXPORT corp_status_desc_max := MAX(corp_status_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_status_desc_values_persisted,corp_status_desc,corp_status_desc_nulls,ol) // Compute column level specificity
EXPORT corp_status_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_status_date_values_persisted,Layout_Specificities.corp_status_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_status_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_status_date_deduped,corp_status_date,,corp_status_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_status_date_switch := bf;
EXPORT corp_status_date_max := MAX(corp_status_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_status_date_values_persisted,corp_status_date,corp_status_date_nulls,ol) // Compute column level specificity
EXPORT corp_status_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_standing_values_persisted,Layout_Specificities.corp_standing_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_standing_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_standing_deduped,corp_standing,,corp_standing_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_standing_switch := bf;
EXPORT corp_standing_max := MAX(corp_standing_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_standing_values_persisted,corp_standing,corp_standing_nulls,ol) // Compute column level specificity
EXPORT corp_standing_specificity := ol;
SALT34.MAC_Field_Nulls(corp_status_comment_values_persisted,Layout_Specificities.corp_status_comment_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_status_comment_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_status_comment_deduped,corp_status_comment,,corp_status_comment_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_status_comment_switch := bf;
EXPORT corp_status_comment_max := MAX(corp_status_comment_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_status_comment_values_persisted,corp_status_comment,corp_status_comment_nulls,ol) // Compute column level specificity
EXPORT corp_status_comment_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ticker_symbol_values_persisted,Layout_Specificities.corp_ticker_symbol_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ticker_symbol_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ticker_symbol_deduped,corp_ticker_symbol,,corp_ticker_symbol_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ticker_symbol_switch := bf;
EXPORT corp_ticker_symbol_max := MAX(corp_ticker_symbol_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ticker_symbol_values_persisted,corp_ticker_symbol,corp_ticker_symbol_nulls,ol) // Compute column level specificity
EXPORT corp_ticker_symbol_specificity := ol;
SALT34.MAC_Field_Nulls(corp_stock_exchange_values_persisted,Layout_Specificities.corp_stock_exchange_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_stock_exchange_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_stock_exchange_deduped,corp_stock_exchange,,corp_stock_exchange_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_stock_exchange_switch := bf;
EXPORT corp_stock_exchange_max := MAX(corp_stock_exchange_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_stock_exchange_values_persisted,corp_stock_exchange,corp_stock_exchange_nulls,ol) // Compute column level specificity
EXPORT corp_stock_exchange_specificity := ol;
SALT34.MAC_Field_Nulls(corp_inc_state_values_persisted,Layout_Specificities.corp_inc_state_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_inc_state_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_inc_state_deduped,corp_inc_state,,corp_inc_state_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_inc_state_switch := bf;
EXPORT corp_inc_state_max := MAX(corp_inc_state_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_inc_state_values_persisted,corp_inc_state,corp_inc_state_nulls,ol) // Compute column level specificity
EXPORT corp_inc_state_specificity := ol;
SALT34.MAC_Field_Nulls(corp_inc_county_values_persisted,Layout_Specificities.corp_inc_county_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_inc_county_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_inc_county_deduped,corp_inc_county,,corp_inc_county_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_inc_county_switch := bf;
EXPORT corp_inc_county_max := MAX(corp_inc_county_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_inc_county_values_persisted,corp_inc_county,corp_inc_county_nulls,ol) // Compute column level specificity
EXPORT corp_inc_county_specificity := ol;
SALT34.MAC_Field_Nulls(corp_inc_date_values_persisted,Layout_Specificities.corp_inc_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_inc_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_inc_date_deduped,corp_inc_date,,corp_inc_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_inc_date_switch := bf;
EXPORT corp_inc_date_max := MAX(corp_inc_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_inc_date_values_persisted,corp_inc_date,corp_inc_date_nulls,ol) // Compute column level specificity
EXPORT corp_inc_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_anniversary_month_values_persisted,Layout_Specificities.corp_anniversary_month_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_anniversary_month_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_anniversary_month_deduped,corp_anniversary_month,,corp_anniversary_month_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_anniversary_month_switch := bf;
EXPORT corp_anniversary_month_max := MAX(corp_anniversary_month_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_anniversary_month_values_persisted,corp_anniversary_month,corp_anniversary_month_nulls,ol) // Compute column level specificity
EXPORT corp_anniversary_month_specificity := ol;
SALT34.MAC_Field_Nulls(corp_fed_tax_id_values_persisted,Layout_Specificities.corp_fed_tax_id_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_fed_tax_id_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_fed_tax_id_deduped,corp_fed_tax_id,,corp_fed_tax_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_fed_tax_id_switch := bf;
EXPORT corp_fed_tax_id_max := MAX(corp_fed_tax_id_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_fed_tax_id_values_persisted,corp_fed_tax_id,corp_fed_tax_id_nulls,ol) // Compute column level specificity
EXPORT corp_fed_tax_id_specificity := ol;
SALT34.MAC_Field_Nulls(corp_state_tax_id_values_persisted,Layout_Specificities.corp_state_tax_id_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_state_tax_id_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_state_tax_id_deduped,corp_state_tax_id,,corp_state_tax_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_state_tax_id_switch := bf;
EXPORT corp_state_tax_id_max := MAX(corp_state_tax_id_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_state_tax_id_values_persisted,corp_state_tax_id,corp_state_tax_id_nulls,ol) // Compute column level specificity
EXPORT corp_state_tax_id_specificity := ol;
SALT34.MAC_Field_Nulls(corp_term_exist_cd_values_persisted,Layout_Specificities.corp_term_exist_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_term_exist_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_term_exist_cd_deduped,corp_term_exist_cd,,corp_term_exist_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_term_exist_cd_switch := bf;
EXPORT corp_term_exist_cd_max := MAX(corp_term_exist_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_term_exist_cd_values_persisted,corp_term_exist_cd,corp_term_exist_cd_nulls,ol) // Compute column level specificity
EXPORT corp_term_exist_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_term_exist_exp_values_persisted,Layout_Specificities.corp_term_exist_exp_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_term_exist_exp_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_term_exist_exp_deduped,corp_term_exist_exp,,corp_term_exist_exp_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_term_exist_exp_switch := bf;
EXPORT corp_term_exist_exp_max := MAX(corp_term_exist_exp_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_term_exist_exp_values_persisted,corp_term_exist_exp,corp_term_exist_exp_nulls,ol) // Compute column level specificity
EXPORT corp_term_exist_exp_specificity := ol;
SALT34.MAC_Field_Nulls(corp_term_exist_desc_values_persisted,Layout_Specificities.corp_term_exist_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_term_exist_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_term_exist_desc_deduped,corp_term_exist_desc,,corp_term_exist_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_term_exist_desc_switch := bf;
EXPORT corp_term_exist_desc_max := MAX(corp_term_exist_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_term_exist_desc_values_persisted,corp_term_exist_desc,corp_term_exist_desc_nulls,ol) // Compute column level specificity
EXPORT corp_term_exist_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_foreign_domestic_ind_values_persisted,Layout_Specificities.corp_foreign_domestic_ind_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_foreign_domestic_ind_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_foreign_domestic_ind_deduped,corp_foreign_domestic_ind,,corp_foreign_domestic_ind_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_foreign_domestic_ind_switch := bf;
EXPORT corp_foreign_domestic_ind_max := MAX(corp_foreign_domestic_ind_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_foreign_domestic_ind_values_persisted,corp_foreign_domestic_ind,corp_foreign_domestic_ind_nulls,ol) // Compute column level specificity
EXPORT corp_foreign_domestic_ind_specificity := ol;
SALT34.MAC_Field_Nulls(corp_forgn_state_cd_values_persisted,Layout_Specificities.corp_forgn_state_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_forgn_state_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_forgn_state_cd_deduped,corp_forgn_state_cd,,corp_forgn_state_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_forgn_state_cd_switch := bf;
EXPORT corp_forgn_state_cd_max := MAX(corp_forgn_state_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_forgn_state_cd_values_persisted,corp_forgn_state_cd,corp_forgn_state_cd_nulls,ol) // Compute column level specificity
EXPORT corp_forgn_state_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_forgn_state_desc_values_persisted,Layout_Specificities.corp_forgn_state_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_forgn_state_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_forgn_state_desc_deduped,corp_forgn_state_desc,,corp_forgn_state_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_forgn_state_desc_switch := bf;
EXPORT corp_forgn_state_desc_max := MAX(corp_forgn_state_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_forgn_state_desc_values_persisted,corp_forgn_state_desc,corp_forgn_state_desc_nulls,ol) // Compute column level specificity
EXPORT corp_forgn_state_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_forgn_sos_charter_nbr_values_persisted,Layout_Specificities.corp_forgn_sos_charter_nbr_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_forgn_sos_charter_nbr_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_forgn_sos_charter_nbr_deduped,corp_forgn_sos_charter_nbr,,corp_forgn_sos_charter_nbr_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_forgn_sos_charter_nbr_switch := bf;
EXPORT corp_forgn_sos_charter_nbr_max := MAX(corp_forgn_sos_charter_nbr_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_forgn_sos_charter_nbr_values_persisted,corp_forgn_sos_charter_nbr,corp_forgn_sos_charter_nbr_nulls,ol) // Compute column level specificity
EXPORT corp_forgn_sos_charter_nbr_specificity := ol;
SALT34.MAC_Field_Nulls(corp_forgn_date_values_persisted,Layout_Specificities.corp_forgn_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_forgn_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_forgn_date_deduped,corp_forgn_date,,corp_forgn_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_forgn_date_switch := bf;
EXPORT corp_forgn_date_max := MAX(corp_forgn_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_forgn_date_values_persisted,corp_forgn_date,corp_forgn_date_nulls,ol) // Compute column level specificity
EXPORT corp_forgn_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_forgn_fed_tax_id_values_persisted,Layout_Specificities.corp_forgn_fed_tax_id_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_forgn_fed_tax_id_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_forgn_fed_tax_id_deduped,corp_forgn_fed_tax_id,,corp_forgn_fed_tax_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_forgn_fed_tax_id_switch := bf;
EXPORT corp_forgn_fed_tax_id_max := MAX(corp_forgn_fed_tax_id_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_forgn_fed_tax_id_values_persisted,corp_forgn_fed_tax_id,corp_forgn_fed_tax_id_nulls,ol) // Compute column level specificity
EXPORT corp_forgn_fed_tax_id_specificity := ol;
SALT34.MAC_Field_Nulls(corp_forgn_state_tax_id_values_persisted,Layout_Specificities.corp_forgn_state_tax_id_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_forgn_state_tax_id_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_forgn_state_tax_id_deduped,corp_forgn_state_tax_id,,corp_forgn_state_tax_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_forgn_state_tax_id_switch := bf;
EXPORT corp_forgn_state_tax_id_max := MAX(corp_forgn_state_tax_id_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_forgn_state_tax_id_values_persisted,corp_forgn_state_tax_id,corp_forgn_state_tax_id_nulls,ol) // Compute column level specificity
EXPORT corp_forgn_state_tax_id_specificity := ol;
SALT34.MAC_Field_Nulls(corp_forgn_term_exist_cd_values_persisted,Layout_Specificities.corp_forgn_term_exist_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_forgn_term_exist_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_forgn_term_exist_cd_deduped,corp_forgn_term_exist_cd,,corp_forgn_term_exist_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_forgn_term_exist_cd_switch := bf;
EXPORT corp_forgn_term_exist_cd_max := MAX(corp_forgn_term_exist_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_forgn_term_exist_cd_values_persisted,corp_forgn_term_exist_cd,corp_forgn_term_exist_cd_nulls,ol) // Compute column level specificity
EXPORT corp_forgn_term_exist_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_forgn_term_exist_exp_values_persisted,Layout_Specificities.corp_forgn_term_exist_exp_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_forgn_term_exist_exp_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_forgn_term_exist_exp_deduped,corp_forgn_term_exist_exp,,corp_forgn_term_exist_exp_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_forgn_term_exist_exp_switch := bf;
EXPORT corp_forgn_term_exist_exp_max := MAX(corp_forgn_term_exist_exp_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_forgn_term_exist_exp_values_persisted,corp_forgn_term_exist_exp,corp_forgn_term_exist_exp_nulls,ol) // Compute column level specificity
EXPORT corp_forgn_term_exist_exp_specificity := ol;
SALT34.MAC_Field_Nulls(corp_forgn_term_exist_desc_values_persisted,Layout_Specificities.corp_forgn_term_exist_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_forgn_term_exist_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_forgn_term_exist_desc_deduped,corp_forgn_term_exist_desc,,corp_forgn_term_exist_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_forgn_term_exist_desc_switch := bf;
EXPORT corp_forgn_term_exist_desc_max := MAX(corp_forgn_term_exist_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_forgn_term_exist_desc_values_persisted,corp_forgn_term_exist_desc,corp_forgn_term_exist_desc_nulls,ol) // Compute column level specificity
EXPORT corp_forgn_term_exist_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_orig_org_structure_cd_values_persisted,Layout_Specificities.corp_orig_org_structure_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_orig_org_structure_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_orig_org_structure_cd_deduped,corp_orig_org_structure_cd,,corp_orig_org_structure_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_orig_org_structure_cd_switch := bf;
EXPORT corp_orig_org_structure_cd_max := MAX(corp_orig_org_structure_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_orig_org_structure_cd_values_persisted,corp_orig_org_structure_cd,corp_orig_org_structure_cd_nulls,ol) // Compute column level specificity
EXPORT corp_orig_org_structure_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_orig_org_structure_desc_values_persisted,Layout_Specificities.corp_orig_org_structure_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_orig_org_structure_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_orig_org_structure_desc_deduped,corp_orig_org_structure_desc,,corp_orig_org_structure_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_orig_org_structure_desc_switch := bf;
EXPORT corp_orig_org_structure_desc_max := MAX(corp_orig_org_structure_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_orig_org_structure_desc_values_persisted,corp_orig_org_structure_desc,corp_orig_org_structure_desc_nulls,ol) // Compute column level specificity
EXPORT corp_orig_org_structure_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_for_profit_ind_values_persisted,Layout_Specificities.corp_for_profit_ind_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_for_profit_ind_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_for_profit_ind_deduped,corp_for_profit_ind,,corp_for_profit_ind_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_for_profit_ind_switch := bf;
EXPORT corp_for_profit_ind_max := MAX(corp_for_profit_ind_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_for_profit_ind_values_persisted,corp_for_profit_ind,corp_for_profit_ind_nulls,ol) // Compute column level specificity
EXPORT corp_for_profit_ind_specificity := ol;
SALT34.MAC_Field_Nulls(corp_public_or_private_ind_values_persisted,Layout_Specificities.corp_public_or_private_ind_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_public_or_private_ind_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_public_or_private_ind_deduped,corp_public_or_private_ind,,corp_public_or_private_ind_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_public_or_private_ind_switch := bf;
EXPORT corp_public_or_private_ind_max := MAX(corp_public_or_private_ind_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_public_or_private_ind_values_persisted,corp_public_or_private_ind,corp_public_or_private_ind_nulls,ol) // Compute column level specificity
EXPORT corp_public_or_private_ind_specificity := ol;
SALT34.MAC_Field_Nulls(corp_sic_code_values_persisted,Layout_Specificities.corp_sic_code_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_sic_code_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_sic_code_deduped,corp_sic_code,,corp_sic_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_sic_code_switch := bf;
EXPORT corp_sic_code_max := MAX(corp_sic_code_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_sic_code_values_persisted,corp_sic_code,corp_sic_code_nulls,ol) // Compute column level specificity
EXPORT corp_sic_code_specificity := ol;
SALT34.MAC_Field_Nulls(corp_naic_code_values_persisted,Layout_Specificities.corp_naic_code_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_naic_code_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_naic_code_deduped,corp_naic_code,,corp_naic_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_naic_code_switch := bf;
EXPORT corp_naic_code_max := MAX(corp_naic_code_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_naic_code_values_persisted,corp_naic_code,corp_naic_code_nulls,ol) // Compute column level specificity
EXPORT corp_naic_code_specificity := ol;
SALT34.MAC_Field_Nulls(corp_orig_bus_type_cd_values_persisted,Layout_Specificities.corp_orig_bus_type_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_orig_bus_type_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_orig_bus_type_cd_deduped,corp_orig_bus_type_cd,,corp_orig_bus_type_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_orig_bus_type_cd_switch := bf;
EXPORT corp_orig_bus_type_cd_max := MAX(corp_orig_bus_type_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_orig_bus_type_cd_values_persisted,corp_orig_bus_type_cd,corp_orig_bus_type_cd_nulls,ol) // Compute column level specificity
EXPORT corp_orig_bus_type_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_orig_bus_type_desc_values_persisted,Layout_Specificities.corp_orig_bus_type_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_orig_bus_type_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_orig_bus_type_desc_deduped,corp_orig_bus_type_desc,,corp_orig_bus_type_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_orig_bus_type_desc_switch := bf;
EXPORT corp_orig_bus_type_desc_max := MAX(corp_orig_bus_type_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_orig_bus_type_desc_values_persisted,corp_orig_bus_type_desc,corp_orig_bus_type_desc_nulls,ol) // Compute column level specificity
EXPORT corp_orig_bus_type_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_entity_desc_values_persisted,Layout_Specificities.corp_entity_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_entity_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_entity_desc_deduped,corp_entity_desc,,corp_entity_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_entity_desc_switch := bf;
EXPORT corp_entity_desc_max := MAX(corp_entity_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_entity_desc_values_persisted,corp_entity_desc,corp_entity_desc_nulls,ol) // Compute column level specificity
EXPORT corp_entity_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_certificate_nbr_values_persisted,Layout_Specificities.corp_certificate_nbr_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_certificate_nbr_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_certificate_nbr_deduped,corp_certificate_nbr,,corp_certificate_nbr_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_certificate_nbr_switch := bf;
EXPORT corp_certificate_nbr_max := MAX(corp_certificate_nbr_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_certificate_nbr_values_persisted,corp_certificate_nbr,corp_certificate_nbr_nulls,ol) // Compute column level specificity
EXPORT corp_certificate_nbr_specificity := ol;
SALT34.MAC_Field_Nulls(corp_internal_nbr_values_persisted,Layout_Specificities.corp_internal_nbr_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_internal_nbr_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_internal_nbr_deduped,corp_internal_nbr,,corp_internal_nbr_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_internal_nbr_switch := bf;
EXPORT corp_internal_nbr_max := MAX(corp_internal_nbr_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_internal_nbr_values_persisted,corp_internal_nbr,corp_internal_nbr_nulls,ol) // Compute column level specificity
EXPORT corp_internal_nbr_specificity := ol;
SALT34.MAC_Field_Nulls(corp_previous_nbr_values_persisted,Layout_Specificities.corp_previous_nbr_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_previous_nbr_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_previous_nbr_deduped,corp_previous_nbr,,corp_previous_nbr_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_previous_nbr_switch := bf;
EXPORT corp_previous_nbr_max := MAX(corp_previous_nbr_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_previous_nbr_values_persisted,corp_previous_nbr,corp_previous_nbr_nulls,ol) // Compute column level specificity
EXPORT corp_previous_nbr_specificity := ol;
SALT34.MAC_Field_Nulls(corp_microfilm_nbr_values_persisted,Layout_Specificities.corp_microfilm_nbr_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_microfilm_nbr_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_microfilm_nbr_deduped,corp_microfilm_nbr,,corp_microfilm_nbr_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_microfilm_nbr_switch := bf;
EXPORT corp_microfilm_nbr_max := MAX(corp_microfilm_nbr_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_microfilm_nbr_values_persisted,corp_microfilm_nbr,corp_microfilm_nbr_nulls,ol) // Compute column level specificity
EXPORT corp_microfilm_nbr_specificity := ol;
SALT34.MAC_Field_Nulls(corp_amendments_filed_values_persisted,Layout_Specificities.corp_amendments_filed_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_amendments_filed_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_amendments_filed_deduped,corp_amendments_filed,,corp_amendments_filed_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_amendments_filed_switch := bf;
EXPORT corp_amendments_filed_max := MAX(corp_amendments_filed_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_amendments_filed_values_persisted,corp_amendments_filed,corp_amendments_filed_nulls,ol) // Compute column level specificity
EXPORT corp_amendments_filed_specificity := ol;
SALT34.MAC_Field_Nulls(corp_acts_values_persisted,Layout_Specificities.corp_acts_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_acts_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_acts_deduped,corp_acts,,corp_acts_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_acts_switch := bf;
EXPORT corp_acts_max := MAX(corp_acts_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_acts_values_persisted,corp_acts,corp_acts_nulls,ol) // Compute column level specificity
EXPORT corp_acts_specificity := ol;
SALT34.MAC_Field_Nulls(corp_partnership_ind_values_persisted,Layout_Specificities.corp_partnership_ind_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_partnership_ind_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_partnership_ind_deduped,corp_partnership_ind,,corp_partnership_ind_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_partnership_ind_switch := bf;
EXPORT corp_partnership_ind_max := MAX(corp_partnership_ind_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_partnership_ind_values_persisted,corp_partnership_ind,corp_partnership_ind_nulls,ol) // Compute column level specificity
EXPORT corp_partnership_ind_specificity := ol;
SALT34.MAC_Field_Nulls(corp_mfg_ind_values_persisted,Layout_Specificities.corp_mfg_ind_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_mfg_ind_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_mfg_ind_deduped,corp_mfg_ind,,corp_mfg_ind_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_mfg_ind_switch := bf;
EXPORT corp_mfg_ind_max := MAX(corp_mfg_ind_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_mfg_ind_values_persisted,corp_mfg_ind,corp_mfg_ind_nulls,ol) // Compute column level specificity
EXPORT corp_mfg_ind_specificity := ol;
SALT34.MAC_Field_Nulls(corp_addl_info_values_persisted,Layout_Specificities.corp_addl_info_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_addl_info_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_addl_info_deduped,corp_addl_info,,corp_addl_info_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_addl_info_switch := bf;
EXPORT corp_addl_info_max := MAX(corp_addl_info_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_addl_info_values_persisted,corp_addl_info,corp_addl_info_nulls,ol) // Compute column level specificity
EXPORT corp_addl_info_specificity := ol;
SALT34.MAC_Field_Nulls(corp_taxes_values_persisted,Layout_Specificities.corp_taxes_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_taxes_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_taxes_deduped,corp_taxes,,corp_taxes_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_taxes_switch := bf;
EXPORT corp_taxes_max := MAX(corp_taxes_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_taxes_values_persisted,corp_taxes,corp_taxes_nulls,ol) // Compute column level specificity
EXPORT corp_taxes_specificity := ol;
SALT34.MAC_Field_Nulls(corp_franchise_taxes_values_persisted,Layout_Specificities.corp_franchise_taxes_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_franchise_taxes_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_franchise_taxes_deduped,corp_franchise_taxes,,corp_franchise_taxes_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_franchise_taxes_switch := bf;
EXPORT corp_franchise_taxes_max := MAX(corp_franchise_taxes_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_franchise_taxes_values_persisted,corp_franchise_taxes,corp_franchise_taxes_nulls,ol) // Compute column level specificity
EXPORT corp_franchise_taxes_specificity := ol;
SALT34.MAC_Field_Nulls(corp_tax_program_cd_values_persisted,Layout_Specificities.corp_tax_program_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_tax_program_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_tax_program_cd_deduped,corp_tax_program_cd,,corp_tax_program_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_tax_program_cd_switch := bf;
EXPORT corp_tax_program_cd_max := MAX(corp_tax_program_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_tax_program_cd_values_persisted,corp_tax_program_cd,corp_tax_program_cd_nulls,ol) // Compute column level specificity
EXPORT corp_tax_program_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_tax_program_desc_values_persisted,Layout_Specificities.corp_tax_program_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_tax_program_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_tax_program_desc_deduped,corp_tax_program_desc,,corp_tax_program_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_tax_program_desc_switch := bf;
EXPORT corp_tax_program_desc_max := MAX(corp_tax_program_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_tax_program_desc_values_persisted,corp_tax_program_desc,corp_tax_program_desc_nulls,ol) // Compute column level specificity
EXPORT corp_tax_program_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_full_name_values_persisted,Layout_Specificities.corp_ra_full_name_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_full_name_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_full_name_deduped,corp_ra_full_name,,corp_ra_full_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_full_name_switch := bf;
EXPORT corp_ra_full_name_max := MAX(corp_ra_full_name_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_full_name_values_persisted,corp_ra_full_name,corp_ra_full_name_nulls,ol) // Compute column level specificity
EXPORT corp_ra_full_name_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_fname_values_persisted,Layout_Specificities.corp_ra_fname_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_fname_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_fname_deduped,corp_ra_fname,,corp_ra_fname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_fname_switch := bf;
EXPORT corp_ra_fname_max := MAX(corp_ra_fname_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_fname_values_persisted,corp_ra_fname,corp_ra_fname_nulls,ol) // Compute column level specificity
EXPORT corp_ra_fname_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_mname_values_persisted,Layout_Specificities.corp_ra_mname_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_mname_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_mname_deduped,corp_ra_mname,,corp_ra_mname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_mname_switch := bf;
EXPORT corp_ra_mname_max := MAX(corp_ra_mname_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_mname_values_persisted,corp_ra_mname,corp_ra_mname_nulls,ol) // Compute column level specificity
EXPORT corp_ra_mname_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_lname_values_persisted,Layout_Specificities.corp_ra_lname_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_lname_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_lname_deduped,corp_ra_lname,,corp_ra_lname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_lname_switch := bf;
EXPORT corp_ra_lname_max := MAX(corp_ra_lname_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_lname_values_persisted,corp_ra_lname,corp_ra_lname_nulls,ol) // Compute column level specificity
EXPORT corp_ra_lname_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_suffix_values_persisted,Layout_Specificities.corp_ra_suffix_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_suffix_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_suffix_deduped,corp_ra_suffix,,corp_ra_suffix_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_suffix_switch := bf;
EXPORT corp_ra_suffix_max := MAX(corp_ra_suffix_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_suffix_values_persisted,corp_ra_suffix,corp_ra_suffix_nulls,ol) // Compute column level specificity
EXPORT corp_ra_suffix_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_title_cd_values_persisted,Layout_Specificities.corp_ra_title_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_title_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_title_cd_deduped,corp_ra_title_cd,,corp_ra_title_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_title_cd_switch := bf;
EXPORT corp_ra_title_cd_max := MAX(corp_ra_title_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_title_cd_values_persisted,corp_ra_title_cd,corp_ra_title_cd_nulls,ol) // Compute column level specificity
EXPORT corp_ra_title_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_title_desc_values_persisted,Layout_Specificities.corp_ra_title_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_title_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_title_desc_deduped,corp_ra_title_desc,,corp_ra_title_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_title_desc_switch := bf;
EXPORT corp_ra_title_desc_max := MAX(corp_ra_title_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_title_desc_values_persisted,corp_ra_title_desc,corp_ra_title_desc_nulls,ol) // Compute column level specificity
EXPORT corp_ra_title_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_fein_values_persisted,Layout_Specificities.corp_ra_fein_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_fein_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_fein_deduped,corp_ra_fein,,corp_ra_fein_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_fein_switch := bf;
EXPORT corp_ra_fein_max := MAX(corp_ra_fein_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_fein_values_persisted,corp_ra_fein,corp_ra_fein_nulls,ol) // Compute column level specificity
EXPORT corp_ra_fein_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_ssn_values_persisted,Layout_Specificities.corp_ra_ssn_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_ssn_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_ssn_deduped,corp_ra_ssn,,corp_ra_ssn_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_ssn_switch := bf;
EXPORT corp_ra_ssn_max := MAX(corp_ra_ssn_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_ssn_values_persisted,corp_ra_ssn,corp_ra_ssn_nulls,ol) // Compute column level specificity
EXPORT corp_ra_ssn_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_dob_values_persisted,Layout_Specificities.corp_ra_dob_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_dob_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_dob_deduped,corp_ra_dob,,corp_ra_dob_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_dob_switch := bf;
EXPORT corp_ra_dob_max := MAX(corp_ra_dob_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_dob_values_persisted,corp_ra_dob,corp_ra_dob_nulls,ol) // Compute column level specificity
EXPORT corp_ra_dob_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_effective_date_values_persisted,Layout_Specificities.corp_ra_effective_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_effective_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_effective_date_deduped,corp_ra_effective_date,,corp_ra_effective_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_effective_date_switch := bf;
EXPORT corp_ra_effective_date_max := MAX(corp_ra_effective_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_effective_date_values_persisted,corp_ra_effective_date,corp_ra_effective_date_nulls,ol) // Compute column level specificity
EXPORT corp_ra_effective_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_resign_date_values_persisted,Layout_Specificities.corp_ra_resign_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_resign_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_resign_date_deduped,corp_ra_resign_date,,corp_ra_resign_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_resign_date_switch := bf;
EXPORT corp_ra_resign_date_max := MAX(corp_ra_resign_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_resign_date_values_persisted,corp_ra_resign_date,corp_ra_resign_date_nulls,ol) // Compute column level specificity
EXPORT corp_ra_resign_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_no_comp_values_persisted,Layout_Specificities.corp_ra_no_comp_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_no_comp_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_no_comp_deduped,corp_ra_no_comp,,corp_ra_no_comp_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_no_comp_switch := bf;
EXPORT corp_ra_no_comp_max := MAX(corp_ra_no_comp_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_no_comp_values_persisted,corp_ra_no_comp,corp_ra_no_comp_nulls,ol) // Compute column level specificity
EXPORT corp_ra_no_comp_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_no_comp_igs_values_persisted,Layout_Specificities.corp_ra_no_comp_igs_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_no_comp_igs_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_no_comp_igs_deduped,corp_ra_no_comp_igs,,corp_ra_no_comp_igs_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_no_comp_igs_switch := bf;
EXPORT corp_ra_no_comp_igs_max := MAX(corp_ra_no_comp_igs_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_no_comp_igs_values_persisted,corp_ra_no_comp_igs,corp_ra_no_comp_igs_nulls,ol) // Compute column level specificity
EXPORT corp_ra_no_comp_igs_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_addl_info_values_persisted,Layout_Specificities.corp_ra_addl_info_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_addl_info_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_addl_info_deduped,corp_ra_addl_info,,corp_ra_addl_info_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_addl_info_switch := bf;
EXPORT corp_ra_addl_info_max := MAX(corp_ra_addl_info_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_addl_info_values_persisted,corp_ra_addl_info,corp_ra_addl_info_nulls,ol) // Compute column level specificity
EXPORT corp_ra_addl_info_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_address_type_cd_values_persisted,Layout_Specificities.corp_ra_address_type_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_address_type_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_address_type_cd_deduped,corp_ra_address_type_cd,,corp_ra_address_type_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_address_type_cd_switch := bf;
EXPORT corp_ra_address_type_cd_max := MAX(corp_ra_address_type_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_address_type_cd_values_persisted,corp_ra_address_type_cd,corp_ra_address_type_cd_nulls,ol) // Compute column level specificity
EXPORT corp_ra_address_type_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_address_type_desc_values_persisted,Layout_Specificities.corp_ra_address_type_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_address_type_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_address_type_desc_deduped,corp_ra_address_type_desc,,corp_ra_address_type_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_address_type_desc_switch := bf;
EXPORT corp_ra_address_type_desc_max := MAX(corp_ra_address_type_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_address_type_desc_values_persisted,corp_ra_address_type_desc,corp_ra_address_type_desc_nulls,ol) // Compute column level specificity
EXPORT corp_ra_address_type_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_address_line1_values_persisted,Layout_Specificities.corp_ra_address_line1_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_address_line1_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_address_line1_deduped,corp_ra_address_line1,,corp_ra_address_line1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_address_line1_switch := bf;
EXPORT corp_ra_address_line1_max := MAX(corp_ra_address_line1_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_address_line1_values_persisted,corp_ra_address_line1,corp_ra_address_line1_nulls,ol) // Compute column level specificity
EXPORT corp_ra_address_line1_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_address_line2_values_persisted,Layout_Specificities.corp_ra_address_line2_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_address_line2_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_address_line2_deduped,corp_ra_address_line2,,corp_ra_address_line2_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_address_line2_switch := bf;
EXPORT corp_ra_address_line2_max := MAX(corp_ra_address_line2_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_address_line2_values_persisted,corp_ra_address_line2,corp_ra_address_line2_nulls,ol) // Compute column level specificity
EXPORT corp_ra_address_line2_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_address_line3_values_persisted,Layout_Specificities.corp_ra_address_line3_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_address_line3_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_address_line3_deduped,corp_ra_address_line3,,corp_ra_address_line3_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_address_line3_switch := bf;
EXPORT corp_ra_address_line3_max := MAX(corp_ra_address_line3_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_address_line3_values_persisted,corp_ra_address_line3,corp_ra_address_line3_nulls,ol) // Compute column level specificity
EXPORT corp_ra_address_line3_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_phone_number_values_persisted,Layout_Specificities.corp_ra_phone_number_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_phone_number_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_phone_number_deduped,corp_ra_phone_number,,corp_ra_phone_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_phone_number_switch := bf;
EXPORT corp_ra_phone_number_max := MAX(corp_ra_phone_number_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_phone_number_values_persisted,corp_ra_phone_number,corp_ra_phone_number_nulls,ol) // Compute column level specificity
EXPORT corp_ra_phone_number_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_phone_number_type_cd_values_persisted,Layout_Specificities.corp_ra_phone_number_type_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_phone_number_type_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_phone_number_type_cd_deduped,corp_ra_phone_number_type_cd,,corp_ra_phone_number_type_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_phone_number_type_cd_switch := bf;
EXPORT corp_ra_phone_number_type_cd_max := MAX(corp_ra_phone_number_type_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_phone_number_type_cd_values_persisted,corp_ra_phone_number_type_cd,corp_ra_phone_number_type_cd_nulls,ol) // Compute column level specificity
EXPORT corp_ra_phone_number_type_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_phone_number_type_desc_values_persisted,Layout_Specificities.corp_ra_phone_number_type_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_phone_number_type_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_phone_number_type_desc_deduped,corp_ra_phone_number_type_desc,,corp_ra_phone_number_type_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_phone_number_type_desc_switch := bf;
EXPORT corp_ra_phone_number_type_desc_max := MAX(corp_ra_phone_number_type_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_phone_number_type_desc_values_persisted,corp_ra_phone_number_type_desc,corp_ra_phone_number_type_desc_nulls,ol) // Compute column level specificity
EXPORT corp_ra_phone_number_type_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_fax_nbr_values_persisted,Layout_Specificities.corp_ra_fax_nbr_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_fax_nbr_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_fax_nbr_deduped,corp_ra_fax_nbr,,corp_ra_fax_nbr_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_fax_nbr_switch := bf;
EXPORT corp_ra_fax_nbr_max := MAX(corp_ra_fax_nbr_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_fax_nbr_values_persisted,corp_ra_fax_nbr,corp_ra_fax_nbr_nulls,ol) // Compute column level specificity
EXPORT corp_ra_fax_nbr_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_email_address_values_persisted,Layout_Specificities.corp_ra_email_address_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_email_address_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_email_address_deduped,corp_ra_email_address,,corp_ra_email_address_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_email_address_switch := bf;
EXPORT corp_ra_email_address_max := MAX(corp_ra_email_address_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_email_address_values_persisted,corp_ra_email_address,corp_ra_email_address_nulls,ol) // Compute column level specificity
EXPORT corp_ra_email_address_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_web_address_values_persisted,Layout_Specificities.corp_ra_web_address_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_web_address_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_web_address_deduped,corp_ra_web_address,,corp_ra_web_address_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_web_address_switch := bf;
EXPORT corp_ra_web_address_max := MAX(corp_ra_web_address_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_web_address_values_persisted,corp_ra_web_address,corp_ra_web_address_nulls,ol) // Compute column level specificity
EXPORT corp_ra_web_address_specificity := ol;
SALT34.MAC_Field_Nulls(corp_prep_addr1_line1_values_persisted,Layout_Specificities.corp_prep_addr1_line1_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_prep_addr1_line1_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_prep_addr1_line1_deduped,corp_prep_addr1_line1,,corp_prep_addr1_line1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_prep_addr1_line1_switch := bf;
EXPORT corp_prep_addr1_line1_max := MAX(corp_prep_addr1_line1_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_prep_addr1_line1_values_persisted,corp_prep_addr1_line1,corp_prep_addr1_line1_nulls,ol) // Compute column level specificity
EXPORT corp_prep_addr1_line1_specificity := ol;
SALT34.MAC_Field_Nulls(corp_prep_addr1_last_line_values_persisted,Layout_Specificities.corp_prep_addr1_last_line_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_prep_addr1_last_line_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_prep_addr1_last_line_deduped,corp_prep_addr1_last_line,,corp_prep_addr1_last_line_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_prep_addr1_last_line_switch := bf;
EXPORT corp_prep_addr1_last_line_max := MAX(corp_prep_addr1_last_line_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_prep_addr1_last_line_values_persisted,corp_prep_addr1_last_line,corp_prep_addr1_last_line_nulls,ol) // Compute column level specificity
EXPORT corp_prep_addr1_last_line_specificity := ol;
SALT34.MAC_Field_Nulls(corp_prep_addr2_line1_values_persisted,Layout_Specificities.corp_prep_addr2_line1_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_prep_addr2_line1_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_prep_addr2_line1_deduped,corp_prep_addr2_line1,,corp_prep_addr2_line1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_prep_addr2_line1_switch := bf;
EXPORT corp_prep_addr2_line1_max := MAX(corp_prep_addr2_line1_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_prep_addr2_line1_values_persisted,corp_prep_addr2_line1,corp_prep_addr2_line1_nulls,ol) // Compute column level specificity
EXPORT corp_prep_addr2_line1_specificity := ol;
SALT34.MAC_Field_Nulls(corp_prep_addr2_last_line_values_persisted,Layout_Specificities.corp_prep_addr2_last_line_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_prep_addr2_last_line_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_prep_addr2_last_line_deduped,corp_prep_addr2_last_line,,corp_prep_addr2_last_line_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_prep_addr2_last_line_switch := bf;
EXPORT corp_prep_addr2_last_line_max := MAX(corp_prep_addr2_last_line_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_prep_addr2_last_line_values_persisted,corp_prep_addr2_last_line,corp_prep_addr2_last_line_nulls,ol) // Compute column level specificity
EXPORT corp_prep_addr2_last_line_specificity := ol;
SALT34.MAC_Field_Nulls(ra_prep_addr_line1_values_persisted,Layout_Specificities.ra_prep_addr_line1_ChildRec,nv) // Use automated NULL spotting
EXPORT ra_prep_addr_line1_nulls := nv;
SALT34.MAC_Field_Bfoul(ra_prep_addr_line1_deduped,ra_prep_addr_line1,,ra_prep_addr_line1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ra_prep_addr_line1_switch := bf;
EXPORT ra_prep_addr_line1_max := MAX(ra_prep_addr_line1_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(ra_prep_addr_line1_values_persisted,ra_prep_addr_line1,ra_prep_addr_line1_nulls,ol) // Compute column level specificity
EXPORT ra_prep_addr_line1_specificity := ol;
SALT34.MAC_Field_Nulls(ra_prep_addr_last_line_values_persisted,Layout_Specificities.ra_prep_addr_last_line_ChildRec,nv) // Use automated NULL spotting
EXPORT ra_prep_addr_last_line_nulls := nv;
SALT34.MAC_Field_Bfoul(ra_prep_addr_last_line_deduped,ra_prep_addr_last_line,,ra_prep_addr_last_line_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ra_prep_addr_last_line_switch := bf;
EXPORT ra_prep_addr_last_line_max := MAX(ra_prep_addr_last_line_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(ra_prep_addr_last_line_values_persisted,ra_prep_addr_last_line,ra_prep_addr_last_line_nulls,ol) // Compute column level specificity
EXPORT ra_prep_addr_last_line_specificity := ol;
SALT34.MAC_Field_Nulls(cont_filing_reference_nbr_values_persisted,Layout_Specificities.cont_filing_reference_nbr_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_filing_reference_nbr_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_filing_reference_nbr_deduped,cont_filing_reference_nbr,,cont_filing_reference_nbr_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_filing_reference_nbr_switch := bf;
EXPORT cont_filing_reference_nbr_max := MAX(cont_filing_reference_nbr_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_filing_reference_nbr_values_persisted,cont_filing_reference_nbr,cont_filing_reference_nbr_nulls,ol) // Compute column level specificity
EXPORT cont_filing_reference_nbr_specificity := ol;
SALT34.MAC_Field_Nulls(cont_filing_date_values_persisted,Layout_Specificities.cont_filing_date_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_filing_date_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_filing_date_deduped,cont_filing_date,,cont_filing_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_filing_date_switch := bf;
EXPORT cont_filing_date_max := MAX(cont_filing_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_filing_date_values_persisted,cont_filing_date,cont_filing_date_nulls,ol) // Compute column level specificity
EXPORT cont_filing_date_specificity := ol;
SALT34.MAC_Field_Nulls(cont_filing_cd_values_persisted,Layout_Specificities.cont_filing_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_filing_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_filing_cd_deduped,cont_filing_cd,,cont_filing_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_filing_cd_switch := bf;
EXPORT cont_filing_cd_max := MAX(cont_filing_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_filing_cd_values_persisted,cont_filing_cd,cont_filing_cd_nulls,ol) // Compute column level specificity
EXPORT cont_filing_cd_specificity := ol;
SALT34.MAC_Field_Nulls(cont_filing_desc_values_persisted,Layout_Specificities.cont_filing_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_filing_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_filing_desc_deduped,cont_filing_desc,,cont_filing_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_filing_desc_switch := bf;
EXPORT cont_filing_desc_max := MAX(cont_filing_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_filing_desc_values_persisted,cont_filing_desc,cont_filing_desc_nulls,ol) // Compute column level specificity
EXPORT cont_filing_desc_specificity := ol;
SALT34.MAC_Field_Nulls(cont_type_cd_values_persisted,Layout_Specificities.cont_type_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_type_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_type_cd_deduped,cont_type_cd,,cont_type_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_type_cd_switch := bf;
EXPORT cont_type_cd_max := MAX(cont_type_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_type_cd_values_persisted,cont_type_cd,cont_type_cd_nulls,ol) // Compute column level specificity
EXPORT cont_type_cd_specificity := ol;
SALT34.MAC_Field_Nulls(cont_type_desc_values_persisted,Layout_Specificities.cont_type_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_type_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_type_desc_deduped,cont_type_desc,,cont_type_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_type_desc_switch := bf;
EXPORT cont_type_desc_max := MAX(cont_type_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_type_desc_values_persisted,cont_type_desc,cont_type_desc_nulls,ol) // Compute column level specificity
EXPORT cont_type_desc_specificity := ol;
SALT34.MAC_Field_Nulls(cont_full_name_values_persisted,Layout_Specificities.cont_full_name_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_full_name_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_full_name_deduped,cont_full_name,,cont_full_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_full_name_switch := bf;
EXPORT cont_full_name_max := MAX(cont_full_name_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_full_name_values_persisted,cont_full_name,cont_full_name_nulls,ol) // Compute column level specificity
EXPORT cont_full_name_specificity := ol;
SALT34.MAC_Field_Nulls(cont_fname_values_persisted,Layout_Specificities.cont_fname_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_fname_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_fname_deduped,cont_fname,,cont_fname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_fname_switch := bf;
EXPORT cont_fname_max := MAX(cont_fname_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_fname_values_persisted,cont_fname,cont_fname_nulls,ol) // Compute column level specificity
EXPORT cont_fname_specificity := ol;
SALT34.MAC_Field_Nulls(cont_mname_values_persisted,Layout_Specificities.cont_mname_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_mname_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_mname_deduped,cont_mname,,cont_mname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_mname_switch := bf;
EXPORT cont_mname_max := MAX(cont_mname_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_mname_values_persisted,cont_mname,cont_mname_nulls,ol) // Compute column level specificity
EXPORT cont_mname_specificity := ol;
SALT34.MAC_Field_Nulls(cont_lname_values_persisted,Layout_Specificities.cont_lname_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_lname_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_lname_deduped,cont_lname,,cont_lname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_lname_switch := bf;
EXPORT cont_lname_max := MAX(cont_lname_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_lname_values_persisted,cont_lname,cont_lname_nulls,ol) // Compute column level specificity
EXPORT cont_lname_specificity := ol;
SALT34.MAC_Field_Nulls(cont_suffix_values_persisted,Layout_Specificities.cont_suffix_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_suffix_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_suffix_deduped,cont_suffix,,cont_suffix_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_suffix_switch := bf;
EXPORT cont_suffix_max := MAX(cont_suffix_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_suffix_values_persisted,cont_suffix,cont_suffix_nulls,ol) // Compute column level specificity
EXPORT cont_suffix_specificity := ol;
SALT34.MAC_Field_Nulls(cont_title1_desc_values_persisted,Layout_Specificities.cont_title1_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_title1_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_title1_desc_deduped,cont_title1_desc,,cont_title1_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_title1_desc_switch := bf;
EXPORT cont_title1_desc_max := MAX(cont_title1_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_title1_desc_values_persisted,cont_title1_desc,cont_title1_desc_nulls,ol) // Compute column level specificity
EXPORT cont_title1_desc_specificity := ol;
SALT34.MAC_Field_Nulls(cont_title2_desc_values_persisted,Layout_Specificities.cont_title2_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_title2_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_title2_desc_deduped,cont_title2_desc,,cont_title2_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_title2_desc_switch := bf;
EXPORT cont_title2_desc_max := MAX(cont_title2_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_title2_desc_values_persisted,cont_title2_desc,cont_title2_desc_nulls,ol) // Compute column level specificity
EXPORT cont_title2_desc_specificity := ol;
SALT34.MAC_Field_Nulls(cont_title3_desc_values_persisted,Layout_Specificities.cont_title3_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_title3_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_title3_desc_deduped,cont_title3_desc,,cont_title3_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_title3_desc_switch := bf;
EXPORT cont_title3_desc_max := MAX(cont_title3_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_title3_desc_values_persisted,cont_title3_desc,cont_title3_desc_nulls,ol) // Compute column level specificity
EXPORT cont_title3_desc_specificity := ol;
SALT34.MAC_Field_Nulls(cont_title4_desc_values_persisted,Layout_Specificities.cont_title4_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_title4_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_title4_desc_deduped,cont_title4_desc,,cont_title4_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_title4_desc_switch := bf;
EXPORT cont_title4_desc_max := MAX(cont_title4_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_title4_desc_values_persisted,cont_title4_desc,cont_title4_desc_nulls,ol) // Compute column level specificity
EXPORT cont_title4_desc_specificity := ol;
SALT34.MAC_Field_Nulls(cont_title5_desc_values_persisted,Layout_Specificities.cont_title5_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_title5_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_title5_desc_deduped,cont_title5_desc,,cont_title5_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_title5_desc_switch := bf;
EXPORT cont_title5_desc_max := MAX(cont_title5_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_title5_desc_values_persisted,cont_title5_desc,cont_title5_desc_nulls,ol) // Compute column level specificity
EXPORT cont_title5_desc_specificity := ol;
SALT34.MAC_Field_Nulls(cont_fein_values_persisted,Layout_Specificities.cont_fein_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_fein_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_fein_deduped,cont_fein,,cont_fein_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_fein_switch := bf;
EXPORT cont_fein_max := MAX(cont_fein_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_fein_values_persisted,cont_fein,cont_fein_nulls,ol) // Compute column level specificity
EXPORT cont_fein_specificity := ol;
SALT34.MAC_Field_Nulls(cont_ssn_values_persisted,Layout_Specificities.cont_ssn_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_ssn_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_ssn_deduped,cont_ssn,,cont_ssn_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_ssn_switch := bf;
EXPORT cont_ssn_max := MAX(cont_ssn_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_ssn_values_persisted,cont_ssn,cont_ssn_nulls,ol) // Compute column level specificity
EXPORT cont_ssn_specificity := ol;
SALT34.MAC_Field_Nulls(cont_dob_values_persisted,Layout_Specificities.cont_dob_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_dob_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_dob_deduped,cont_dob,,cont_dob_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_dob_switch := bf;
EXPORT cont_dob_max := MAX(cont_dob_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_dob_values_persisted,cont_dob,cont_dob_nulls,ol) // Compute column level specificity
EXPORT cont_dob_specificity := ol;
SALT34.MAC_Field_Nulls(cont_status_cd_values_persisted,Layout_Specificities.cont_status_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_status_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_status_cd_deduped,cont_status_cd,,cont_status_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_status_cd_switch := bf;
EXPORT cont_status_cd_max := MAX(cont_status_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_status_cd_values_persisted,cont_status_cd,cont_status_cd_nulls,ol) // Compute column level specificity
EXPORT cont_status_cd_specificity := ol;
SALT34.MAC_Field_Nulls(cont_status_desc_values_persisted,Layout_Specificities.cont_status_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_status_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_status_desc_deduped,cont_status_desc,,cont_status_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_status_desc_switch := bf;
EXPORT cont_status_desc_max := MAX(cont_status_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_status_desc_values_persisted,cont_status_desc,cont_status_desc_nulls,ol) // Compute column level specificity
EXPORT cont_status_desc_specificity := ol;
SALT34.MAC_Field_Nulls(cont_effective_date_values_persisted,Layout_Specificities.cont_effective_date_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_effective_date_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_effective_date_deduped,cont_effective_date,,cont_effective_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_effective_date_switch := bf;
EXPORT cont_effective_date_max := MAX(cont_effective_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_effective_date_values_persisted,cont_effective_date,cont_effective_date_nulls,ol) // Compute column level specificity
EXPORT cont_effective_date_specificity := ol;
SALT34.MAC_Field_Nulls(cont_effective_cd_values_persisted,Layout_Specificities.cont_effective_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_effective_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_effective_cd_deduped,cont_effective_cd,,cont_effective_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_effective_cd_switch := bf;
EXPORT cont_effective_cd_max := MAX(cont_effective_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_effective_cd_values_persisted,cont_effective_cd,cont_effective_cd_nulls,ol) // Compute column level specificity
EXPORT cont_effective_cd_specificity := ol;
SALT34.MAC_Field_Nulls(cont_effective_desc_values_persisted,Layout_Specificities.cont_effective_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_effective_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_effective_desc_deduped,cont_effective_desc,,cont_effective_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_effective_desc_switch := bf;
EXPORT cont_effective_desc_max := MAX(cont_effective_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_effective_desc_values_persisted,cont_effective_desc,cont_effective_desc_nulls,ol) // Compute column level specificity
EXPORT cont_effective_desc_specificity := ol;
SALT34.MAC_Field_Nulls(cont_addl_info_values_persisted,Layout_Specificities.cont_addl_info_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_addl_info_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_addl_info_deduped,cont_addl_info,,cont_addl_info_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_addl_info_switch := bf;
EXPORT cont_addl_info_max := MAX(cont_addl_info_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_addl_info_values_persisted,cont_addl_info,cont_addl_info_nulls,ol) // Compute column level specificity
EXPORT cont_addl_info_specificity := ol;
SALT34.MAC_Field_Nulls(cont_address_type_cd_values_persisted,Layout_Specificities.cont_address_type_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_address_type_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_address_type_cd_deduped,cont_address_type_cd,,cont_address_type_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_address_type_cd_switch := bf;
EXPORT cont_address_type_cd_max := MAX(cont_address_type_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_address_type_cd_values_persisted,cont_address_type_cd,cont_address_type_cd_nulls,ol) // Compute column level specificity
EXPORT cont_address_type_cd_specificity := ol;
SALT34.MAC_Field_Nulls(cont_address_type_desc_values_persisted,Layout_Specificities.cont_address_type_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_address_type_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_address_type_desc_deduped,cont_address_type_desc,,cont_address_type_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_address_type_desc_switch := bf;
EXPORT cont_address_type_desc_max := MAX(cont_address_type_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_address_type_desc_values_persisted,cont_address_type_desc,cont_address_type_desc_nulls,ol) // Compute column level specificity
EXPORT cont_address_type_desc_specificity := ol;
SALT34.MAC_Field_Nulls(cont_address_line1_values_persisted,Layout_Specificities.cont_address_line1_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_address_line1_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_address_line1_deduped,cont_address_line1,,cont_address_line1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_address_line1_switch := bf;
EXPORT cont_address_line1_max := MAX(cont_address_line1_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_address_line1_values_persisted,cont_address_line1,cont_address_line1_nulls,ol) // Compute column level specificity
EXPORT cont_address_line1_specificity := ol;
SALT34.MAC_Field_Nulls(cont_address_line2_values_persisted,Layout_Specificities.cont_address_line2_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_address_line2_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_address_line2_deduped,cont_address_line2,,cont_address_line2_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_address_line2_switch := bf;
EXPORT cont_address_line2_max := MAX(cont_address_line2_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_address_line2_values_persisted,cont_address_line2,cont_address_line2_nulls,ol) // Compute column level specificity
EXPORT cont_address_line2_specificity := ol;
SALT34.MAC_Field_Nulls(cont_address_line3_values_persisted,Layout_Specificities.cont_address_line3_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_address_line3_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_address_line3_deduped,cont_address_line3,,cont_address_line3_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_address_line3_switch := bf;
EXPORT cont_address_line3_max := MAX(cont_address_line3_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_address_line3_values_persisted,cont_address_line3,cont_address_line3_nulls,ol) // Compute column level specificity
EXPORT cont_address_line3_specificity := ol;
SALT34.MAC_Field_Nulls(cont_address_effective_date_values_persisted,Layout_Specificities.cont_address_effective_date_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_address_effective_date_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_address_effective_date_deduped,cont_address_effective_date,,cont_address_effective_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_address_effective_date_switch := bf;
EXPORT cont_address_effective_date_max := MAX(cont_address_effective_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_address_effective_date_values_persisted,cont_address_effective_date,cont_address_effective_date_nulls,ol) // Compute column level specificity
EXPORT cont_address_effective_date_specificity := ol;
SALT34.MAC_Field_Nulls(cont_address_county_values_persisted,Layout_Specificities.cont_address_county_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_address_county_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_address_county_deduped,cont_address_county,,cont_address_county_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_address_county_switch := bf;
EXPORT cont_address_county_max := MAX(cont_address_county_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_address_county_values_persisted,cont_address_county,cont_address_county_nulls,ol) // Compute column level specificity
EXPORT cont_address_county_specificity := ol;
SALT34.MAC_Field_Nulls(cont_phone_number_values_persisted,Layout_Specificities.cont_phone_number_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_phone_number_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_phone_number_deduped,cont_phone_number,,cont_phone_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_phone_number_switch := bf;
EXPORT cont_phone_number_max := MAX(cont_phone_number_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_phone_number_values_persisted,cont_phone_number,cont_phone_number_nulls,ol) // Compute column level specificity
EXPORT cont_phone_number_specificity := ol;
SALT34.MAC_Field_Nulls(cont_phone_number_type_cd_values_persisted,Layout_Specificities.cont_phone_number_type_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_phone_number_type_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_phone_number_type_cd_deduped,cont_phone_number_type_cd,,cont_phone_number_type_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_phone_number_type_cd_switch := bf;
EXPORT cont_phone_number_type_cd_max := MAX(cont_phone_number_type_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_phone_number_type_cd_values_persisted,cont_phone_number_type_cd,cont_phone_number_type_cd_nulls,ol) // Compute column level specificity
EXPORT cont_phone_number_type_cd_specificity := ol;
SALT34.MAC_Field_Nulls(cont_phone_number_type_desc_values_persisted,Layout_Specificities.cont_phone_number_type_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_phone_number_type_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_phone_number_type_desc_deduped,cont_phone_number_type_desc,,cont_phone_number_type_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_phone_number_type_desc_switch := bf;
EXPORT cont_phone_number_type_desc_max := MAX(cont_phone_number_type_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_phone_number_type_desc_values_persisted,cont_phone_number_type_desc,cont_phone_number_type_desc_nulls,ol) // Compute column level specificity
EXPORT cont_phone_number_type_desc_specificity := ol;
SALT34.MAC_Field_Nulls(cont_fax_nbr_values_persisted,Layout_Specificities.cont_fax_nbr_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_fax_nbr_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_fax_nbr_deduped,cont_fax_nbr,,cont_fax_nbr_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_fax_nbr_switch := bf;
EXPORT cont_fax_nbr_max := MAX(cont_fax_nbr_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_fax_nbr_values_persisted,cont_fax_nbr,cont_fax_nbr_nulls,ol) // Compute column level specificity
EXPORT cont_fax_nbr_specificity := ol;
SALT34.MAC_Field_Nulls(cont_email_address_values_persisted,Layout_Specificities.cont_email_address_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_email_address_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_email_address_deduped,cont_email_address,,cont_email_address_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_email_address_switch := bf;
EXPORT cont_email_address_max := MAX(cont_email_address_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_email_address_values_persisted,cont_email_address,cont_email_address_nulls,ol) // Compute column level specificity
EXPORT cont_email_address_specificity := ol;
SALT34.MAC_Field_Nulls(cont_web_address_values_persisted,Layout_Specificities.cont_web_address_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_web_address_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_web_address_deduped,cont_web_address,,cont_web_address_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_web_address_switch := bf;
EXPORT cont_web_address_max := MAX(cont_web_address_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_web_address_values_persisted,cont_web_address,cont_web_address_nulls,ol) // Compute column level specificity
EXPORT cont_web_address_specificity := ol;
SALT34.MAC_Field_Nulls(corp_acres_values_persisted,Layout_Specificities.corp_acres_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_acres_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_acres_deduped,corp_acres,,corp_acres_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_acres_switch := bf;
EXPORT corp_acres_max := MAX(corp_acres_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_acres_values_persisted,corp_acres,corp_acres_nulls,ol) // Compute column level specificity
EXPORT corp_acres_specificity := ol;
SALT34.MAC_Field_Nulls(corp_action_values_persisted,Layout_Specificities.corp_action_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_action_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_action_deduped,corp_action,,corp_action_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_action_switch := bf;
EXPORT corp_action_max := MAX(corp_action_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_action_values_persisted,corp_action,corp_action_nulls,ol) // Compute column level specificity
EXPORT corp_action_specificity := ol;
SALT34.MAC_Field_Nulls(corp_action_date_values_persisted,Layout_Specificities.corp_action_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_action_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_action_date_deduped,corp_action_date,,corp_action_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_action_date_switch := bf;
EXPORT corp_action_date_max := MAX(corp_action_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_action_date_values_persisted,corp_action_date,corp_action_date_nulls,ol) // Compute column level specificity
EXPORT corp_action_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_action_employment_security_approval_date_values_persisted,Layout_Specificities.corp_action_employment_security_approval_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_action_employment_security_approval_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_action_employment_security_approval_date_deduped,corp_action_employment_security_approval_date,,corp_action_employment_security_approval_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_action_employment_security_approval_date_switch := bf;
EXPORT corp_action_employment_security_approval_date_max := MAX(corp_action_employment_security_approval_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_action_employment_security_approval_date_values_persisted,corp_action_employment_security_approval_date,corp_action_employment_security_approval_date_nulls,ol) // Compute column level specificity
EXPORT corp_action_employment_security_approval_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_action_pending_cd_values_persisted,Layout_Specificities.corp_action_pending_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_action_pending_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_action_pending_cd_deduped,corp_action_pending_cd,,corp_action_pending_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_action_pending_cd_switch := bf;
EXPORT corp_action_pending_cd_max := MAX(corp_action_pending_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_action_pending_cd_values_persisted,corp_action_pending_cd,corp_action_pending_cd_nulls,ol) // Compute column level specificity
EXPORT corp_action_pending_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_action_pending_desc_values_persisted,Layout_Specificities.corp_action_pending_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_action_pending_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_action_pending_desc_deduped,corp_action_pending_desc,,corp_action_pending_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_action_pending_desc_switch := bf;
EXPORT corp_action_pending_desc_max := MAX(corp_action_pending_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_action_pending_desc_values_persisted,corp_action_pending_desc,corp_action_pending_desc_nulls,ol) // Compute column level specificity
EXPORT corp_action_pending_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_action_statement_of_intent_date_values_persisted,Layout_Specificities.corp_action_statement_of_intent_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_action_statement_of_intent_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_action_statement_of_intent_date_deduped,corp_action_statement_of_intent_date,,corp_action_statement_of_intent_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_action_statement_of_intent_date_switch := bf;
EXPORT corp_action_statement_of_intent_date_max := MAX(corp_action_statement_of_intent_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_action_statement_of_intent_date_values_persisted,corp_action_statement_of_intent_date,corp_action_statement_of_intent_date_nulls,ol) // Compute column level specificity
EXPORT corp_action_statement_of_intent_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_action_tax_dept_approval_date_values_persisted,Layout_Specificities.corp_action_tax_dept_approval_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_action_tax_dept_approval_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_action_tax_dept_approval_date_deduped,corp_action_tax_dept_approval_date,,corp_action_tax_dept_approval_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_action_tax_dept_approval_date_switch := bf;
EXPORT corp_action_tax_dept_approval_date_max := MAX(corp_action_tax_dept_approval_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_action_tax_dept_approval_date_values_persisted,corp_action_tax_dept_approval_date,corp_action_tax_dept_approval_date_nulls,ol) // Compute column level specificity
EXPORT corp_action_tax_dept_approval_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_acts2_values_persisted,Layout_Specificities.corp_acts2_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_acts2_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_acts2_deduped,corp_acts2,,corp_acts2_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_acts2_switch := bf;
EXPORT corp_acts2_max := MAX(corp_acts2_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_acts2_values_persisted,corp_acts2,corp_acts2_nulls,ol) // Compute column level specificity
EXPORT corp_acts2_specificity := ol;
SALT34.MAC_Field_Nulls(corp_acts3_values_persisted,Layout_Specificities.corp_acts3_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_acts3_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_acts3_deduped,corp_acts3,,corp_acts3_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_acts3_switch := bf;
EXPORT corp_acts3_max := MAX(corp_acts3_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_acts3_values_persisted,corp_acts3,corp_acts3_nulls,ol) // Compute column level specificity
EXPORT corp_acts3_specificity := ol;
SALT34.MAC_Field_Nulls(corp_additional_principals_values_persisted,Layout_Specificities.corp_additional_principals_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_additional_principals_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_additional_principals_deduped,corp_additional_principals,,corp_additional_principals_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_additional_principals_switch := bf;
EXPORT corp_additional_principals_max := MAX(corp_additional_principals_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_additional_principals_values_persisted,corp_additional_principals,corp_additional_principals_nulls,ol) // Compute column level specificity
EXPORT corp_additional_principals_specificity := ol;
SALT34.MAC_Field_Nulls(corp_address_office_type_values_persisted,Layout_Specificities.corp_address_office_type_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_address_office_type_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_address_office_type_deduped,corp_address_office_type,,corp_address_office_type_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_address_office_type_switch := bf;
EXPORT corp_address_office_type_max := MAX(corp_address_office_type_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_address_office_type_values_persisted,corp_address_office_type,corp_address_office_type_nulls,ol) // Compute column level specificity
EXPORT corp_address_office_type_specificity := ol;
SALT34.MAC_Field_Nulls(corp_agent_assign_date_values_persisted,Layout_Specificities.corp_agent_assign_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_agent_assign_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_agent_assign_date_deduped,corp_agent_assign_date,,corp_agent_assign_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_agent_assign_date_switch := bf;
EXPORT corp_agent_assign_date_max := MAX(corp_agent_assign_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_agent_assign_date_values_persisted,corp_agent_assign_date,corp_agent_assign_date_nulls,ol) // Compute column level specificity
EXPORT corp_agent_assign_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_agent_commercial_values_persisted,Layout_Specificities.corp_agent_commercial_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_agent_commercial_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_agent_commercial_deduped,corp_agent_commercial,,corp_agent_commercial_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_agent_commercial_switch := bf;
EXPORT corp_agent_commercial_max := MAX(corp_agent_commercial_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_agent_commercial_values_persisted,corp_agent_commercial,corp_agent_commercial_nulls,ol) // Compute column level specificity
EXPORT corp_agent_commercial_specificity := ol;
SALT34.MAC_Field_Nulls(corp_agent_country_values_persisted,Layout_Specificities.corp_agent_country_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_agent_country_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_agent_country_deduped,corp_agent_country,,corp_agent_country_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_agent_country_switch := bf;
EXPORT corp_agent_country_max := MAX(corp_agent_country_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_agent_country_values_persisted,corp_agent_country,corp_agent_country_nulls,ol) // Compute column level specificity
EXPORT corp_agent_country_specificity := ol;
SALT34.MAC_Field_Nulls(corp_agent_county_values_persisted,Layout_Specificities.corp_agent_county_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_agent_county_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_agent_county_deduped,corp_agent_county,,corp_agent_county_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_agent_county_switch := bf;
EXPORT corp_agent_county_max := MAX(corp_agent_county_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_agent_county_values_persisted,corp_agent_county,corp_agent_county_nulls,ol) // Compute column level specificity
EXPORT corp_agent_county_specificity := ol;
SALT34.MAC_Field_Nulls(corp_agent_status_cd_values_persisted,Layout_Specificities.corp_agent_status_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_agent_status_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_agent_status_cd_deduped,corp_agent_status_cd,,corp_agent_status_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_agent_status_cd_switch := bf;
EXPORT corp_agent_status_cd_max := MAX(corp_agent_status_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_agent_status_cd_values_persisted,corp_agent_status_cd,corp_agent_status_cd_nulls,ol) // Compute column level specificity
EXPORT corp_agent_status_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_agent_status_desc_values_persisted,Layout_Specificities.corp_agent_status_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_agent_status_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_agent_status_desc_deduped,corp_agent_status_desc,,corp_agent_status_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_agent_status_desc_switch := bf;
EXPORT corp_agent_status_desc_max := MAX(corp_agent_status_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_agent_status_desc_values_persisted,corp_agent_status_desc,corp_agent_status_desc_nulls,ol) // Compute column level specificity
EXPORT corp_agent_status_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_agent_id_values_persisted,Layout_Specificities.corp_agent_id_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_agent_id_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_agent_id_deduped,corp_agent_id,,corp_agent_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_agent_id_switch := bf;
EXPORT corp_agent_id_max := MAX(corp_agent_id_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_agent_id_values_persisted,corp_agent_id,corp_agent_id_nulls,ol) // Compute column level specificity
EXPORT corp_agent_id_specificity := ol;
SALT34.MAC_Field_Nulls(corp_agriculture_flag_values_persisted,Layout_Specificities.corp_agriculture_flag_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_agriculture_flag_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_agriculture_flag_deduped,corp_agriculture_flag,,corp_agriculture_flag_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_agriculture_flag_switch := bf;
EXPORT corp_agriculture_flag_max := MAX(corp_agriculture_flag_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_agriculture_flag_values_persisted,corp_agriculture_flag,corp_agriculture_flag_nulls,ol) // Compute column level specificity
EXPORT corp_agriculture_flag_specificity := ol;
SALT34.MAC_Field_Nulls(corp_authorized_partners_values_persisted,Layout_Specificities.corp_authorized_partners_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_authorized_partners_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_authorized_partners_deduped,corp_authorized_partners,,corp_authorized_partners_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_authorized_partners_switch := bf;
EXPORT corp_authorized_partners_max := MAX(corp_authorized_partners_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_authorized_partners_values_persisted,corp_authorized_partners,corp_authorized_partners_nulls,ol) // Compute column level specificity
EXPORT corp_authorized_partners_specificity := ol;
SALT34.MAC_Field_Nulls(corp_comment_values_persisted,Layout_Specificities.corp_comment_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_comment_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_comment_deduped,corp_comment,,corp_comment_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_comment_switch := bf;
EXPORT corp_comment_max := MAX(corp_comment_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_comment_values_persisted,corp_comment,corp_comment_nulls,ol) // Compute column level specificity
EXPORT corp_comment_specificity := ol;
SALT34.MAC_Field_Nulls(corp_consent_flag_for_protected_name_values_persisted,Layout_Specificities.corp_consent_flag_for_protected_name_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_consent_flag_for_protected_name_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_consent_flag_for_protected_name_deduped,corp_consent_flag_for_protected_name,,corp_consent_flag_for_protected_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_consent_flag_for_protected_name_switch := bf;
EXPORT corp_consent_flag_for_protected_name_max := MAX(corp_consent_flag_for_protected_name_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_consent_flag_for_protected_name_values_persisted,corp_consent_flag_for_protected_name,corp_consent_flag_for_protected_name_nulls,ol) // Compute column level specificity
EXPORT corp_consent_flag_for_protected_name_specificity := ol;
SALT34.MAC_Field_Nulls(corp_converted_values_persisted,Layout_Specificities.corp_converted_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_converted_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_converted_deduped,corp_converted,,corp_converted_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_converted_switch := bf;
EXPORT corp_converted_max := MAX(corp_converted_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_converted_values_persisted,corp_converted,corp_converted_nulls,ol) // Compute column level specificity
EXPORT corp_converted_specificity := ol;
SALT34.MAC_Field_Nulls(corp_converted_from_values_persisted,Layout_Specificities.corp_converted_from_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_converted_from_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_converted_from_deduped,corp_converted_from,,corp_converted_from_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_converted_from_switch := bf;
EXPORT corp_converted_from_max := MAX(corp_converted_from_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_converted_from_values_persisted,corp_converted_from,corp_converted_from_nulls,ol) // Compute column level specificity
EXPORT corp_converted_from_specificity := ol;
SALT34.MAC_Field_Nulls(corp_country_of_formation_values_persisted,Layout_Specificities.corp_country_of_formation_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_country_of_formation_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_country_of_formation_deduped,corp_country_of_formation,,corp_country_of_formation_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_country_of_formation_switch := bf;
EXPORT corp_country_of_formation_max := MAX(corp_country_of_formation_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_country_of_formation_values_persisted,corp_country_of_formation,corp_country_of_formation_nulls,ol) // Compute column level specificity
EXPORT corp_country_of_formation_specificity := ol;
SALT34.MAC_Field_Nulls(corp_date_of_organization_meeting_values_persisted,Layout_Specificities.corp_date_of_organization_meeting_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_date_of_organization_meeting_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_date_of_organization_meeting_deduped,corp_date_of_organization_meeting,,corp_date_of_organization_meeting_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_date_of_organization_meeting_switch := bf;
EXPORT corp_date_of_organization_meeting_max := MAX(corp_date_of_organization_meeting_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_date_of_organization_meeting_values_persisted,corp_date_of_organization_meeting,corp_date_of_organization_meeting_nulls,ol) // Compute column level specificity
EXPORT corp_date_of_organization_meeting_specificity := ol;
SALT34.MAC_Field_Nulls(corp_delayed_effective_date_values_persisted,Layout_Specificities.corp_delayed_effective_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_delayed_effective_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_delayed_effective_date_deduped,corp_delayed_effective_date,,corp_delayed_effective_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_delayed_effective_date_switch := bf;
EXPORT corp_delayed_effective_date_max := MAX(corp_delayed_effective_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_delayed_effective_date_values_persisted,corp_delayed_effective_date,corp_delayed_effective_date_nulls,ol) // Compute column level specificity
EXPORT corp_delayed_effective_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_directors_from_to_values_persisted,Layout_Specificities.corp_directors_from_to_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_directors_from_to_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_directors_from_to_deduped,corp_directors_from_to,,corp_directors_from_to_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_directors_from_to_switch := bf;
EXPORT corp_directors_from_to_max := MAX(corp_directors_from_to_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_directors_from_to_values_persisted,corp_directors_from_to,corp_directors_from_to_nulls,ol) // Compute column level specificity
EXPORT corp_directors_from_to_specificity := ol;
SALT34.MAC_Field_Nulls(corp_dissolved_date_values_persisted,Layout_Specificities.corp_dissolved_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_dissolved_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_dissolved_date_deduped,corp_dissolved_date,,corp_dissolved_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_dissolved_date_switch := bf;
EXPORT corp_dissolved_date_max := MAX(corp_dissolved_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_dissolved_date_values_persisted,corp_dissolved_date,corp_dissolved_date_nulls,ol) // Compute column level specificity
EXPORT corp_dissolved_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_farm_exemptions_values_persisted,Layout_Specificities.corp_farm_exemptions_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_farm_exemptions_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_farm_exemptions_deduped,corp_farm_exemptions,,corp_farm_exemptions_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_farm_exemptions_switch := bf;
EXPORT corp_farm_exemptions_max := MAX(corp_farm_exemptions_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_farm_exemptions_values_persisted,corp_farm_exemptions,corp_farm_exemptions_nulls,ol) // Compute column level specificity
EXPORT corp_farm_exemptions_specificity := ol;
SALT34.MAC_Field_Nulls(corp_farm_qual_date_values_persisted,Layout_Specificities.corp_farm_qual_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_farm_qual_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_farm_qual_date_deduped,corp_farm_qual_date,,corp_farm_qual_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_farm_qual_date_switch := bf;
EXPORT corp_farm_qual_date_max := MAX(corp_farm_qual_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_farm_qual_date_values_persisted,corp_farm_qual_date,corp_farm_qual_date_nulls,ol) // Compute column level specificity
EXPORT corp_farm_qual_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_farm_status_cd_values_persisted,Layout_Specificities.corp_farm_status_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_farm_status_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_farm_status_cd_deduped,corp_farm_status_cd,,corp_farm_status_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_farm_status_cd_switch := bf;
EXPORT corp_farm_status_cd_max := MAX(corp_farm_status_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_farm_status_cd_values_persisted,corp_farm_status_cd,corp_farm_status_cd_nulls,ol) // Compute column level specificity
EXPORT corp_farm_status_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_farm_status_desc_values_persisted,Layout_Specificities.corp_farm_status_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_farm_status_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_farm_status_desc_deduped,corp_farm_status_desc,,corp_farm_status_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_farm_status_desc_switch := bf;
EXPORT corp_farm_status_desc_max := MAX(corp_farm_status_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_farm_status_desc_values_persisted,corp_farm_status_desc,corp_farm_status_desc_nulls,ol) // Compute column level specificity
EXPORT corp_farm_status_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_fiscal_year_month_values_persisted,Layout_Specificities.corp_fiscal_year_month_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_fiscal_year_month_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_fiscal_year_month_deduped,corp_fiscal_year_month,,corp_fiscal_year_month_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_fiscal_year_month_switch := bf;
EXPORT corp_fiscal_year_month_max := MAX(corp_fiscal_year_month_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_fiscal_year_month_values_persisted,corp_fiscal_year_month,corp_fiscal_year_month_nulls,ol) // Compute column level specificity
EXPORT corp_fiscal_year_month_specificity := ol;
SALT34.MAC_Field_Nulls(corp_foreign_fiduciary_capacity_in_state_values_persisted,Layout_Specificities.corp_foreign_fiduciary_capacity_in_state_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_foreign_fiduciary_capacity_in_state_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_foreign_fiduciary_capacity_in_state_deduped,corp_foreign_fiduciary_capacity_in_state,,corp_foreign_fiduciary_capacity_in_state_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_foreign_fiduciary_capacity_in_state_switch := bf;
EXPORT corp_foreign_fiduciary_capacity_in_state_max := MAX(corp_foreign_fiduciary_capacity_in_state_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_foreign_fiduciary_capacity_in_state_values_persisted,corp_foreign_fiduciary_capacity_in_state,corp_foreign_fiduciary_capacity_in_state_nulls,ol) // Compute column level specificity
EXPORT corp_foreign_fiduciary_capacity_in_state_specificity := ol;
SALT34.MAC_Field_Nulls(corp_governing_statute_values_persisted,Layout_Specificities.corp_governing_statute_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_governing_statute_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_governing_statute_deduped,corp_governing_statute,,corp_governing_statute_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_governing_statute_switch := bf;
EXPORT corp_governing_statute_max := MAX(corp_governing_statute_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_governing_statute_values_persisted,corp_governing_statute,corp_governing_statute_nulls,ol) // Compute column level specificity
EXPORT corp_governing_statute_specificity := ol;
SALT34.MAC_Field_Nulls(corp_has_members_values_persisted,Layout_Specificities.corp_has_members_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_has_members_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_has_members_deduped,corp_has_members,,corp_has_members_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_has_members_switch := bf;
EXPORT corp_has_members_max := MAX(corp_has_members_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_has_members_values_persisted,corp_has_members,corp_has_members_nulls,ol) // Compute column level specificity
EXPORT corp_has_members_specificity := ol;
SALT34.MAC_Field_Nulls(corp_has_vested_managers_values_persisted,Layout_Specificities.corp_has_vested_managers_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_has_vested_managers_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_has_vested_managers_deduped,corp_has_vested_managers,,corp_has_vested_managers_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_has_vested_managers_switch := bf;
EXPORT corp_has_vested_managers_max := MAX(corp_has_vested_managers_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_has_vested_managers_values_persisted,corp_has_vested_managers,corp_has_vested_managers_nulls,ol) // Compute column level specificity
EXPORT corp_has_vested_managers_specificity := ol;
SALT34.MAC_Field_Nulls(corp_home_incorporated_county_values_persisted,Layout_Specificities.corp_home_incorporated_county_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_home_incorporated_county_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_home_incorporated_county_deduped,corp_home_incorporated_county,,corp_home_incorporated_county_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_home_incorporated_county_switch := bf;
EXPORT corp_home_incorporated_county_max := MAX(corp_home_incorporated_county_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_home_incorporated_county_values_persisted,corp_home_incorporated_county,corp_home_incorporated_county_nulls,ol) // Compute column level specificity
EXPORT corp_home_incorporated_county_specificity := ol;
SALT34.MAC_Field_Nulls(corp_home_state_name_values_persisted,Layout_Specificities.corp_home_state_name_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_home_state_name_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_home_state_name_deduped,corp_home_state_name,,corp_home_state_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_home_state_name_switch := bf;
EXPORT corp_home_state_name_max := MAX(corp_home_state_name_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_home_state_name_values_persisted,corp_home_state_name,corp_home_state_name_nulls,ol) // Compute column level specificity
EXPORT corp_home_state_name_specificity := ol;
SALT34.MAC_Field_Nulls(corp_is_professional_values_persisted,Layout_Specificities.corp_is_professional_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_is_professional_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_is_professional_deduped,corp_is_professional,,corp_is_professional_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_is_professional_switch := bf;
EXPORT corp_is_professional_max := MAX(corp_is_professional_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_is_professional_values_persisted,corp_is_professional,corp_is_professional_nulls,ol) // Compute column level specificity
EXPORT corp_is_professional_specificity := ol;
SALT34.MAC_Field_Nulls(corp_is_non_profit_irs_approved_values_persisted,Layout_Specificities.corp_is_non_profit_irs_approved_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_is_non_profit_irs_approved_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_is_non_profit_irs_approved_deduped,corp_is_non_profit_irs_approved,,corp_is_non_profit_irs_approved_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_is_non_profit_irs_approved_switch := bf;
EXPORT corp_is_non_profit_irs_approved_max := MAX(corp_is_non_profit_irs_approved_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_is_non_profit_irs_approved_values_persisted,corp_is_non_profit_irs_approved,corp_is_non_profit_irs_approved_nulls,ol) // Compute column level specificity
EXPORT corp_is_non_profit_irs_approved_specificity := ol;
SALT34.MAC_Field_Nulls(corp_last_renewal_date_values_persisted,Layout_Specificities.corp_last_renewal_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_last_renewal_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_last_renewal_date_deduped,corp_last_renewal_date,,corp_last_renewal_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_last_renewal_date_switch := bf;
EXPORT corp_last_renewal_date_max := MAX(corp_last_renewal_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_last_renewal_date_values_persisted,corp_last_renewal_date,corp_last_renewal_date_nulls,ol) // Compute column level specificity
EXPORT corp_last_renewal_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_last_renewal_year_values_persisted,Layout_Specificities.corp_last_renewal_year_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_last_renewal_year_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_last_renewal_year_deduped,corp_last_renewal_year,,corp_last_renewal_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_last_renewal_year_switch := bf;
EXPORT corp_last_renewal_year_max := MAX(corp_last_renewal_year_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_last_renewal_year_values_persisted,corp_last_renewal_year,corp_last_renewal_year_nulls,ol) // Compute column level specificity
EXPORT corp_last_renewal_year_specificity := ol;
SALT34.MAC_Field_Nulls(corp_license_type_values_persisted,Layout_Specificities.corp_license_type_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_license_type_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_license_type_deduped,corp_license_type,,corp_license_type_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_license_type_switch := bf;
EXPORT corp_license_type_max := MAX(corp_license_type_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_license_type_values_persisted,corp_license_type,corp_license_type_nulls,ol) // Compute column level specificity
EXPORT corp_license_type_specificity := ol;
SALT34.MAC_Field_Nulls(corp_llc_managed_desc_values_persisted,Layout_Specificities.corp_llc_managed_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_llc_managed_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_llc_managed_desc_deduped,corp_llc_managed_desc,,corp_llc_managed_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_llc_managed_desc_switch := bf;
EXPORT corp_llc_managed_desc_max := MAX(corp_llc_managed_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_llc_managed_desc_values_persisted,corp_llc_managed_desc,corp_llc_managed_desc_nulls,ol) // Compute column level specificity
EXPORT corp_llc_managed_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_llc_managed_ind_values_persisted,Layout_Specificities.corp_llc_managed_ind_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_llc_managed_ind_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_llc_managed_ind_deduped,corp_llc_managed_ind,,corp_llc_managed_ind_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_llc_managed_ind_switch := bf;
EXPORT corp_llc_managed_ind_max := MAX(corp_llc_managed_ind_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_llc_managed_ind_values_persisted,corp_llc_managed_ind,corp_llc_managed_ind_nulls,ol) // Compute column level specificity
EXPORT corp_llc_managed_ind_specificity := ol;
SALT34.MAC_Field_Nulls(corp_management_desc_values_persisted,Layout_Specificities.corp_management_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_management_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_management_desc_deduped,corp_management_desc,,corp_management_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_management_desc_switch := bf;
EXPORT corp_management_desc_max := MAX(corp_management_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_management_desc_values_persisted,corp_management_desc,corp_management_desc_nulls,ol) // Compute column level specificity
EXPORT corp_management_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_management_type_values_persisted,Layout_Specificities.corp_management_type_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_management_type_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_management_type_deduped,corp_management_type,,corp_management_type_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_management_type_switch := bf;
EXPORT corp_management_type_max := MAX(corp_management_type_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_management_type_values_persisted,corp_management_type,corp_management_type_nulls,ol) // Compute column level specificity
EXPORT corp_management_type_specificity := ol;
SALT34.MAC_Field_Nulls(corp_manager_managed_values_persisted,Layout_Specificities.corp_manager_managed_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_manager_managed_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_manager_managed_deduped,corp_manager_managed,,corp_manager_managed_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_manager_managed_switch := bf;
EXPORT corp_manager_managed_max := MAX(corp_manager_managed_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_manager_managed_values_persisted,corp_manager_managed,corp_manager_managed_nulls,ol) // Compute column level specificity
EXPORT corp_manager_managed_specificity := ol;
SALT34.MAC_Field_Nulls(corp_merged_corporation_id_values_persisted,Layout_Specificities.corp_merged_corporation_id_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_merged_corporation_id_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_merged_corporation_id_deduped,corp_merged_corporation_id,,corp_merged_corporation_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_merged_corporation_id_switch := bf;
EXPORT corp_merged_corporation_id_max := MAX(corp_merged_corporation_id_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_merged_corporation_id_values_persisted,corp_merged_corporation_id,corp_merged_corporation_id_nulls,ol) // Compute column level specificity
EXPORT corp_merged_corporation_id_specificity := ol;
SALT34.MAC_Field_Nulls(corp_merged_fein_values_persisted,Layout_Specificities.corp_merged_fein_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_merged_fein_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_merged_fein_deduped,corp_merged_fein,,corp_merged_fein_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_merged_fein_switch := bf;
EXPORT corp_merged_fein_max := MAX(corp_merged_fein_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_merged_fein_values_persisted,corp_merged_fein,corp_merged_fein_nulls,ol) // Compute column level specificity
EXPORT corp_merged_fein_specificity := ol;
SALT34.MAC_Field_Nulls(corp_merger_allowed_flag_values_persisted,Layout_Specificities.corp_merger_allowed_flag_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_merger_allowed_flag_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_merger_allowed_flag_deduped,corp_merger_allowed_flag,,corp_merger_allowed_flag_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_merger_allowed_flag_switch := bf;
EXPORT corp_merger_allowed_flag_max := MAX(corp_merger_allowed_flag_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_merger_allowed_flag_values_persisted,corp_merger_allowed_flag,corp_merger_allowed_flag_nulls,ol) // Compute column level specificity
EXPORT corp_merger_allowed_flag_specificity := ol;
SALT34.MAC_Field_Nulls(corp_merger_date_values_persisted,Layout_Specificities.corp_merger_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_merger_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_merger_date_deduped,corp_merger_date,,corp_merger_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_merger_date_switch := bf;
EXPORT corp_merger_date_max := MAX(corp_merger_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_merger_date_values_persisted,corp_merger_date,corp_merger_date_nulls,ol) // Compute column level specificity
EXPORT corp_merger_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_merger_desc_values_persisted,Layout_Specificities.corp_merger_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_merger_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_merger_desc_deduped,corp_merger_desc,,corp_merger_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_merger_desc_switch := bf;
EXPORT corp_merger_desc_max := MAX(corp_merger_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_merger_desc_values_persisted,corp_merger_desc,corp_merger_desc_nulls,ol) // Compute column level specificity
EXPORT corp_merger_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_merger_effective_date_values_persisted,Layout_Specificities.corp_merger_effective_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_merger_effective_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_merger_effective_date_deduped,corp_merger_effective_date,,corp_merger_effective_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_merger_effective_date_switch := bf;
EXPORT corp_merger_effective_date_max := MAX(corp_merger_effective_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_merger_effective_date_values_persisted,corp_merger_effective_date,corp_merger_effective_date_nulls,ol) // Compute column level specificity
EXPORT corp_merger_effective_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_merger_id_values_persisted,Layout_Specificities.corp_merger_id_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_merger_id_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_merger_id_deduped,corp_merger_id,,corp_merger_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_merger_id_switch := bf;
EXPORT corp_merger_id_max := MAX(corp_merger_id_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_merger_id_values_persisted,corp_merger_id,corp_merger_id_nulls,ol) // Compute column level specificity
EXPORT corp_merger_id_specificity := ol;
SALT34.MAC_Field_Nulls(corp_merger_indicator_values_persisted,Layout_Specificities.corp_merger_indicator_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_merger_indicator_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_merger_indicator_deduped,corp_merger_indicator,,corp_merger_indicator_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_merger_indicator_switch := bf;
EXPORT corp_merger_indicator_max := MAX(corp_merger_indicator_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_merger_indicator_values_persisted,corp_merger_indicator,corp_merger_indicator_nulls,ol) // Compute column level specificity
EXPORT corp_merger_indicator_specificity := ol;
SALT34.MAC_Field_Nulls(corp_merger_name_values_persisted,Layout_Specificities.corp_merger_name_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_merger_name_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_merger_name_deduped,corp_merger_name,,corp_merger_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_merger_name_switch := bf;
EXPORT corp_merger_name_max := MAX(corp_merger_name_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_merger_name_values_persisted,corp_merger_name,corp_merger_name_nulls,ol) // Compute column level specificity
EXPORT corp_merger_name_specificity := ol;
SALT34.MAC_Field_Nulls(corp_merger_type_converted_to_cd_values_persisted,Layout_Specificities.corp_merger_type_converted_to_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_merger_type_converted_to_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_merger_type_converted_to_cd_deduped,corp_merger_type_converted_to_cd,,corp_merger_type_converted_to_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_merger_type_converted_to_cd_switch := bf;
EXPORT corp_merger_type_converted_to_cd_max := MAX(corp_merger_type_converted_to_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_merger_type_converted_to_cd_values_persisted,corp_merger_type_converted_to_cd,corp_merger_type_converted_to_cd_nulls,ol) // Compute column level specificity
EXPORT corp_merger_type_converted_to_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_merger_type_converted_to_desc_values_persisted,Layout_Specificities.corp_merger_type_converted_to_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_merger_type_converted_to_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_merger_type_converted_to_desc_deduped,corp_merger_type_converted_to_desc,,corp_merger_type_converted_to_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_merger_type_converted_to_desc_switch := bf;
EXPORT corp_merger_type_converted_to_desc_max := MAX(corp_merger_type_converted_to_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_merger_type_converted_to_desc_values_persisted,corp_merger_type_converted_to_desc,corp_merger_type_converted_to_desc_nulls,ol) // Compute column level specificity
EXPORT corp_merger_type_converted_to_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_naics_desc_values_persisted,Layout_Specificities.corp_naics_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_naics_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_naics_desc_deduped,corp_naics_desc,,corp_naics_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_naics_desc_switch := bf;
EXPORT corp_naics_desc_max := MAX(corp_naics_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_naics_desc_values_persisted,corp_naics_desc,corp_naics_desc_nulls,ol) // Compute column level specificity
EXPORT corp_naics_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_name_effective_date_values_persisted,Layout_Specificities.corp_name_effective_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_name_effective_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_name_effective_date_deduped,corp_name_effective_date,,corp_name_effective_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_name_effective_date_switch := bf;
EXPORT corp_name_effective_date_max := MAX(corp_name_effective_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_name_effective_date_values_persisted,corp_name_effective_date,corp_name_effective_date_nulls,ol) // Compute column level specificity
EXPORT corp_name_effective_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_name_reservation_date_values_persisted,Layout_Specificities.corp_name_reservation_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_name_reservation_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_name_reservation_date_deduped,corp_name_reservation_date,,corp_name_reservation_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_name_reservation_date_switch := bf;
EXPORT corp_name_reservation_date_max := MAX(corp_name_reservation_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_name_reservation_date_values_persisted,corp_name_reservation_date,corp_name_reservation_date_nulls,ol) // Compute column level specificity
EXPORT corp_name_reservation_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_name_reservation_desc_values_persisted,Layout_Specificities.corp_name_reservation_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_name_reservation_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_name_reservation_desc_deduped,corp_name_reservation_desc,,corp_name_reservation_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_name_reservation_desc_switch := bf;
EXPORT corp_name_reservation_desc_max := MAX(corp_name_reservation_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_name_reservation_desc_values_persisted,corp_name_reservation_desc,corp_name_reservation_desc_nulls,ol) // Compute column level specificity
EXPORT corp_name_reservation_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_name_reservation_expiration_date_values_persisted,Layout_Specificities.corp_name_reservation_expiration_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_name_reservation_expiration_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_name_reservation_expiration_date_deduped,corp_name_reservation_expiration_date,,corp_name_reservation_expiration_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_name_reservation_expiration_date_switch := bf;
EXPORT corp_name_reservation_expiration_date_max := MAX(corp_name_reservation_expiration_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_name_reservation_expiration_date_values_persisted,corp_name_reservation_expiration_date,corp_name_reservation_expiration_date_nulls,ol) // Compute column level specificity
EXPORT corp_name_reservation_expiration_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_name_reservation_nbr_values_persisted,Layout_Specificities.corp_name_reservation_nbr_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_name_reservation_nbr_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_name_reservation_nbr_deduped,corp_name_reservation_nbr,,corp_name_reservation_nbr_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_name_reservation_nbr_switch := bf;
EXPORT corp_name_reservation_nbr_max := MAX(corp_name_reservation_nbr_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_name_reservation_nbr_values_persisted,corp_name_reservation_nbr,corp_name_reservation_nbr_nulls,ol) // Compute column level specificity
EXPORT corp_name_reservation_nbr_specificity := ol;
SALT34.MAC_Field_Nulls(corp_name_reservation_type_values_persisted,Layout_Specificities.corp_name_reservation_type_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_name_reservation_type_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_name_reservation_type_deduped,corp_name_reservation_type,,corp_name_reservation_type_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_name_reservation_type_switch := bf;
EXPORT corp_name_reservation_type_max := MAX(corp_name_reservation_type_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_name_reservation_type_values_persisted,corp_name_reservation_type,corp_name_reservation_type_nulls,ol) // Compute column level specificity
EXPORT corp_name_reservation_type_specificity := ol;
SALT34.MAC_Field_Nulls(corp_name_status_cd_values_persisted,Layout_Specificities.corp_name_status_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_name_status_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_name_status_cd_deduped,corp_name_status_cd,,corp_name_status_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_name_status_cd_switch := bf;
EXPORT corp_name_status_cd_max := MAX(corp_name_status_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_name_status_cd_values_persisted,corp_name_status_cd,corp_name_status_cd_nulls,ol) // Compute column level specificity
EXPORT corp_name_status_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_name_status_date_values_persisted,Layout_Specificities.corp_name_status_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_name_status_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_name_status_date_deduped,corp_name_status_date,,corp_name_status_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_name_status_date_switch := bf;
EXPORT corp_name_status_date_max := MAX(corp_name_status_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_name_status_date_values_persisted,corp_name_status_date,corp_name_status_date_nulls,ol) // Compute column level specificity
EXPORT corp_name_status_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_name_status_desc_values_persisted,Layout_Specificities.corp_name_status_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_name_status_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_name_status_desc_deduped,corp_name_status_desc,,corp_name_status_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_name_status_desc_switch := bf;
EXPORT corp_name_status_desc_max := MAX(corp_name_status_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_name_status_desc_values_persisted,corp_name_status_desc,corp_name_status_desc_nulls,ol) // Compute column level specificity
EXPORT corp_name_status_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_non_profit_irs_approved_purpose_values_persisted,Layout_Specificities.corp_non_profit_irs_approved_purpose_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_non_profit_irs_approved_purpose_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_non_profit_irs_approved_purpose_deduped,corp_non_profit_irs_approved_purpose,,corp_non_profit_irs_approved_purpose_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_non_profit_irs_approved_purpose_switch := bf;
EXPORT corp_non_profit_irs_approved_purpose_max := MAX(corp_non_profit_irs_approved_purpose_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_non_profit_irs_approved_purpose_values_persisted,corp_non_profit_irs_approved_purpose,corp_non_profit_irs_approved_purpose_nulls,ol) // Compute column level specificity
EXPORT corp_non_profit_irs_approved_purpose_specificity := ol;
SALT34.MAC_Field_Nulls(corp_non_profit_solicit_donations_values_persisted,Layout_Specificities.corp_non_profit_solicit_donations_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_non_profit_solicit_donations_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_non_profit_solicit_donations_deduped,corp_non_profit_solicit_donations,,corp_non_profit_solicit_donations_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_non_profit_solicit_donations_switch := bf;
EXPORT corp_non_profit_solicit_donations_max := MAX(corp_non_profit_solicit_donations_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_non_profit_solicit_donations_values_persisted,corp_non_profit_solicit_donations,corp_non_profit_solicit_donations_nulls,ol) // Compute column level specificity
EXPORT corp_non_profit_solicit_donations_specificity := ol;
SALT34.MAC_Field_Nulls(corp_nbr_of_amendments_values_persisted,Layout_Specificities.corp_nbr_of_amendments_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_nbr_of_amendments_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_nbr_of_amendments_deduped,corp_nbr_of_amendments,,corp_nbr_of_amendments_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_nbr_of_amendments_switch := bf;
EXPORT corp_nbr_of_amendments_max := MAX(corp_nbr_of_amendments_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_nbr_of_amendments_values_persisted,corp_nbr_of_amendments,corp_nbr_of_amendments_nulls,ol) // Compute column level specificity
EXPORT corp_nbr_of_amendments_specificity := ol;
SALT34.MAC_Field_Nulls(corp_nbr_of_initial_llc_members_values_persisted,Layout_Specificities.corp_nbr_of_initial_llc_members_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_nbr_of_initial_llc_members_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_nbr_of_initial_llc_members_deduped,corp_nbr_of_initial_llc_members,,corp_nbr_of_initial_llc_members_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_nbr_of_initial_llc_members_switch := bf;
EXPORT corp_nbr_of_initial_llc_members_max := MAX(corp_nbr_of_initial_llc_members_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_nbr_of_initial_llc_members_values_persisted,corp_nbr_of_initial_llc_members,corp_nbr_of_initial_llc_members_nulls,ol) // Compute column level specificity
EXPORT corp_nbr_of_initial_llc_members_specificity := ol;
SALT34.MAC_Field_Nulls(corp_nbr_of_partners_values_persisted,Layout_Specificities.corp_nbr_of_partners_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_nbr_of_partners_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_nbr_of_partners_deduped,corp_nbr_of_partners,,corp_nbr_of_partners_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_nbr_of_partners_switch := bf;
EXPORT corp_nbr_of_partners_max := MAX(corp_nbr_of_partners_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_nbr_of_partners_values_persisted,corp_nbr_of_partners,corp_nbr_of_partners_nulls,ol) // Compute column level specificity
EXPORT corp_nbr_of_partners_specificity := ol;
SALT34.MAC_Field_Nulls(corp_operating_agreement_values_persisted,Layout_Specificities.corp_operating_agreement_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_operating_agreement_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_operating_agreement_deduped,corp_operating_agreement,,corp_operating_agreement_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_operating_agreement_switch := bf;
EXPORT corp_operating_agreement_max := MAX(corp_operating_agreement_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_operating_agreement_values_persisted,corp_operating_agreement,corp_operating_agreement_nulls,ol) // Compute column level specificity
EXPORT corp_operating_agreement_specificity := ol;
SALT34.MAC_Field_Nulls(corp_opt_in_llc_act_desc_values_persisted,Layout_Specificities.corp_opt_in_llc_act_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_opt_in_llc_act_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_opt_in_llc_act_desc_deduped,corp_opt_in_llc_act_desc,,corp_opt_in_llc_act_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_opt_in_llc_act_desc_switch := bf;
EXPORT corp_opt_in_llc_act_desc_max := MAX(corp_opt_in_llc_act_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_opt_in_llc_act_desc_values_persisted,corp_opt_in_llc_act_desc,corp_opt_in_llc_act_desc_nulls,ol) // Compute column level specificity
EXPORT corp_opt_in_llc_act_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_opt_in_llc_act_ind_values_persisted,Layout_Specificities.corp_opt_in_llc_act_ind_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_opt_in_llc_act_ind_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_opt_in_llc_act_ind_deduped,corp_opt_in_llc_act_ind,,corp_opt_in_llc_act_ind_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_opt_in_llc_act_ind_switch := bf;
EXPORT corp_opt_in_llc_act_ind_max := MAX(corp_opt_in_llc_act_ind_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_opt_in_llc_act_ind_values_persisted,corp_opt_in_llc_act_ind,corp_opt_in_llc_act_ind_nulls,ol) // Compute column level specificity
EXPORT corp_opt_in_llc_act_ind_specificity := ol;
SALT34.MAC_Field_Nulls(corp_organizational_comments_values_persisted,Layout_Specificities.corp_organizational_comments_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_organizational_comments_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_organizational_comments_deduped,corp_organizational_comments,,corp_organizational_comments_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_organizational_comments_switch := bf;
EXPORT corp_organizational_comments_max := MAX(corp_organizational_comments_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_organizational_comments_values_persisted,corp_organizational_comments,corp_organizational_comments_nulls,ol) // Compute column level specificity
EXPORT corp_organizational_comments_specificity := ol;
SALT34.MAC_Field_Nulls(corp_partner_contributions_total_values_persisted,Layout_Specificities.corp_partner_contributions_total_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_partner_contributions_total_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_partner_contributions_total_deduped,corp_partner_contributions_total,,corp_partner_contributions_total_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_partner_contributions_total_switch := bf;
EXPORT corp_partner_contributions_total_max := MAX(corp_partner_contributions_total_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_partner_contributions_total_values_persisted,corp_partner_contributions_total,corp_partner_contributions_total_nulls,ol) // Compute column level specificity
EXPORT corp_partner_contributions_total_specificity := ol;
SALT34.MAC_Field_Nulls(corp_partner_terms_values_persisted,Layout_Specificities.corp_partner_terms_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_partner_terms_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_partner_terms_deduped,corp_partner_terms,,corp_partner_terms_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_partner_terms_switch := bf;
EXPORT corp_partner_terms_max := MAX(corp_partner_terms_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_partner_terms_values_persisted,corp_partner_terms,corp_partner_terms_nulls,ol) // Compute column level specificity
EXPORT corp_partner_terms_specificity := ol;
SALT34.MAC_Field_Nulls(corp_percentage_voters_required_to_approve_amendments_values_persisted,Layout_Specificities.corp_percentage_voters_required_to_approve_amendments_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_percentage_voters_required_to_approve_amendments_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_percentage_voters_required_to_approve_amendments_deduped,corp_percentage_voters_required_to_approve_amendments,,corp_percentage_voters_required_to_approve_amendments_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_percentage_voters_required_to_approve_amendments_switch := bf;
EXPORT corp_percentage_voters_required_to_approve_amendments_max := MAX(corp_percentage_voters_required_to_approve_amendments_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_percentage_voters_required_to_approve_amendments_values_persisted,corp_percentage_voters_required_to_approve_amendments,corp_percentage_voters_required_to_approve_amendments_nulls,ol) // Compute column level specificity
EXPORT corp_percentage_voters_required_to_approve_amendments_specificity := ol;
SALT34.MAC_Field_Nulls(corp_profession_values_persisted,Layout_Specificities.corp_profession_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_profession_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_profession_deduped,corp_profession,,corp_profession_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_profession_switch := bf;
EXPORT corp_profession_max := MAX(corp_profession_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_profession_values_persisted,corp_profession,corp_profession_nulls,ol) // Compute column level specificity
EXPORT corp_profession_specificity := ol;
SALT34.MAC_Field_Nulls(corp_province_values_persisted,Layout_Specificities.corp_province_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_province_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_province_deduped,corp_province,,corp_province_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_province_switch := bf;
EXPORT corp_province_max := MAX(corp_province_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_province_values_persisted,corp_province,corp_province_nulls,ol) // Compute column level specificity
EXPORT corp_province_specificity := ol;
SALT34.MAC_Field_Nulls(corp_public_mutual_corporation_values_persisted,Layout_Specificities.corp_public_mutual_corporation_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_public_mutual_corporation_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_public_mutual_corporation_deduped,corp_public_mutual_corporation,,corp_public_mutual_corporation_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_public_mutual_corporation_switch := bf;
EXPORT corp_public_mutual_corporation_max := MAX(corp_public_mutual_corporation_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_public_mutual_corporation_values_persisted,corp_public_mutual_corporation,corp_public_mutual_corporation_nulls,ol) // Compute column level specificity
EXPORT corp_public_mutual_corporation_specificity := ol;
SALT34.MAC_Field_Nulls(corp_purpose_values_persisted,Layout_Specificities.corp_purpose_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_purpose_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_purpose_deduped,corp_purpose,,corp_purpose_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_purpose_switch := bf;
EXPORT corp_purpose_max := MAX(corp_purpose_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_purpose_values_persisted,corp_purpose,corp_purpose_nulls,ol) // Compute column level specificity
EXPORT corp_purpose_specificity := ol;
SALT34.MAC_Field_Nulls(corp_ra_required_flag_values_persisted,Layout_Specificities.corp_ra_required_flag_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_ra_required_flag_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_ra_required_flag_deduped,corp_ra_required_flag,,corp_ra_required_flag_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_ra_required_flag_switch := bf;
EXPORT corp_ra_required_flag_max := MAX(corp_ra_required_flag_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_ra_required_flag_values_persisted,corp_ra_required_flag,corp_ra_required_flag_nulls,ol) // Compute column level specificity
EXPORT corp_ra_required_flag_specificity := ol;
SALT34.MAC_Field_Nulls(corp_registered_counties_values_persisted,Layout_Specificities.corp_registered_counties_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_registered_counties_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_registered_counties_deduped,corp_registered_counties,,corp_registered_counties_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_registered_counties_switch := bf;
EXPORT corp_registered_counties_max := MAX(corp_registered_counties_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_registered_counties_values_persisted,corp_registered_counties,corp_registered_counties_nulls,ol) // Compute column level specificity
EXPORT corp_registered_counties_specificity := ol;
SALT34.MAC_Field_Nulls(corp_regulated_ind_values_persisted,Layout_Specificities.corp_regulated_ind_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_regulated_ind_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_regulated_ind_deduped,corp_regulated_ind,,corp_regulated_ind_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_regulated_ind_switch := bf;
EXPORT corp_regulated_ind_max := MAX(corp_regulated_ind_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_regulated_ind_values_persisted,corp_regulated_ind,corp_regulated_ind_nulls,ol) // Compute column level specificity
EXPORT corp_regulated_ind_specificity := ol;
SALT34.MAC_Field_Nulls(corp_renewal_date_values_persisted,Layout_Specificities.corp_renewal_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_renewal_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_renewal_date_deduped,corp_renewal_date,,corp_renewal_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_renewal_date_switch := bf;
EXPORT corp_renewal_date_max := MAX(corp_renewal_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_renewal_date_values_persisted,corp_renewal_date,corp_renewal_date_nulls,ol) // Compute column level specificity
EXPORT corp_renewal_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_standing_other_values_persisted,Layout_Specificities.corp_standing_other_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_standing_other_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_standing_other_deduped,corp_standing_other,,corp_standing_other_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_standing_other_switch := bf;
EXPORT corp_standing_other_max := MAX(corp_standing_other_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_standing_other_values_persisted,corp_standing_other,corp_standing_other_nulls,ol) // Compute column level specificity
EXPORT corp_standing_other_specificity := ol;
SALT34.MAC_Field_Nulls(corp_survivor_corporation_id_values_persisted,Layout_Specificities.corp_survivor_corporation_id_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_survivor_corporation_id_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_survivor_corporation_id_deduped,corp_survivor_corporation_id,,corp_survivor_corporation_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_survivor_corporation_id_switch := bf;
EXPORT corp_survivor_corporation_id_max := MAX(corp_survivor_corporation_id_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_survivor_corporation_id_values_persisted,corp_survivor_corporation_id,corp_survivor_corporation_id_nulls,ol) // Compute column level specificity
EXPORT corp_survivor_corporation_id_specificity := ol;
SALT34.MAC_Field_Nulls(corp_tax_base_values_persisted,Layout_Specificities.corp_tax_base_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_tax_base_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_tax_base_deduped,corp_tax_base,,corp_tax_base_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_tax_base_switch := bf;
EXPORT corp_tax_base_max := MAX(corp_tax_base_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_tax_base_values_persisted,corp_tax_base,corp_tax_base_nulls,ol) // Compute column level specificity
EXPORT corp_tax_base_specificity := ol;
SALT34.MAC_Field_Nulls(corp_tax_standing_values_persisted,Layout_Specificities.corp_tax_standing_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_tax_standing_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_tax_standing_deduped,corp_tax_standing,,corp_tax_standing_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_tax_standing_switch := bf;
EXPORT corp_tax_standing_max := MAX(corp_tax_standing_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_tax_standing_values_persisted,corp_tax_standing,corp_tax_standing_nulls,ol) // Compute column level specificity
EXPORT corp_tax_standing_specificity := ol;
SALT34.MAC_Field_Nulls(corp_termination_cd_values_persisted,Layout_Specificities.corp_termination_cd_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_termination_cd_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_termination_cd_deduped,corp_termination_cd,,corp_termination_cd_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_termination_cd_switch := bf;
EXPORT corp_termination_cd_max := MAX(corp_termination_cd_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_termination_cd_values_persisted,corp_termination_cd,corp_termination_cd_nulls,ol) // Compute column level specificity
EXPORT corp_termination_cd_specificity := ol;
SALT34.MAC_Field_Nulls(corp_termination_desc_values_persisted,Layout_Specificities.corp_termination_desc_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_termination_desc_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_termination_desc_deduped,corp_termination_desc,,corp_termination_desc_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_termination_desc_switch := bf;
EXPORT corp_termination_desc_max := MAX(corp_termination_desc_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_termination_desc_values_persisted,corp_termination_desc,corp_termination_desc_nulls,ol) // Compute column level specificity
EXPORT corp_termination_desc_specificity := ol;
SALT34.MAC_Field_Nulls(corp_termination_date_values_persisted,Layout_Specificities.corp_termination_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_termination_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_termination_date_deduped,corp_termination_date,,corp_termination_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_termination_date_switch := bf;
EXPORT corp_termination_date_max := MAX(corp_termination_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_termination_date_values_persisted,corp_termination_date,corp_termination_date_nulls,ol) // Compute column level specificity
EXPORT corp_termination_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_business_mark_type_values_persisted,Layout_Specificities.corp_trademark_business_mark_type_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_business_mark_type_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_business_mark_type_deduped,corp_trademark_business_mark_type,,corp_trademark_business_mark_type_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_business_mark_type_switch := bf;
EXPORT corp_trademark_business_mark_type_max := MAX(corp_trademark_business_mark_type_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_business_mark_type_values_persisted,corp_trademark_business_mark_type,corp_trademark_business_mark_type_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_business_mark_type_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_cancelled_date_values_persisted,Layout_Specificities.corp_trademark_cancelled_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_cancelled_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_cancelled_date_deduped,corp_trademark_cancelled_date,,corp_trademark_cancelled_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_cancelled_date_switch := bf;
EXPORT corp_trademark_cancelled_date_max := MAX(corp_trademark_cancelled_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_cancelled_date_values_persisted,corp_trademark_cancelled_date,corp_trademark_cancelled_date_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_cancelled_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_class_desc1_values_persisted,Layout_Specificities.corp_trademark_class_desc1_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_class_desc1_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_class_desc1_deduped,corp_trademark_class_desc1,,corp_trademark_class_desc1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_class_desc1_switch := bf;
EXPORT corp_trademark_class_desc1_max := MAX(corp_trademark_class_desc1_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_class_desc1_values_persisted,corp_trademark_class_desc1,corp_trademark_class_desc1_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_class_desc1_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_class_desc2_values_persisted,Layout_Specificities.corp_trademark_class_desc2_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_class_desc2_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_class_desc2_deduped,corp_trademark_class_desc2,,corp_trademark_class_desc2_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_class_desc2_switch := bf;
EXPORT corp_trademark_class_desc2_max := MAX(corp_trademark_class_desc2_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_class_desc2_values_persisted,corp_trademark_class_desc2,corp_trademark_class_desc2_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_class_desc2_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_class_desc3_values_persisted,Layout_Specificities.corp_trademark_class_desc3_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_class_desc3_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_class_desc3_deduped,corp_trademark_class_desc3,,corp_trademark_class_desc3_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_class_desc3_switch := bf;
EXPORT corp_trademark_class_desc3_max := MAX(corp_trademark_class_desc3_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_class_desc3_values_persisted,corp_trademark_class_desc3,corp_trademark_class_desc3_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_class_desc3_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_class_desc4_values_persisted,Layout_Specificities.corp_trademark_class_desc4_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_class_desc4_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_class_desc4_deduped,corp_trademark_class_desc4,,corp_trademark_class_desc4_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_class_desc4_switch := bf;
EXPORT corp_trademark_class_desc4_max := MAX(corp_trademark_class_desc4_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_class_desc4_values_persisted,corp_trademark_class_desc4,corp_trademark_class_desc4_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_class_desc4_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_class_desc5_values_persisted,Layout_Specificities.corp_trademark_class_desc5_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_class_desc5_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_class_desc5_deduped,corp_trademark_class_desc5,,corp_trademark_class_desc5_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_class_desc5_switch := bf;
EXPORT corp_trademark_class_desc5_max := MAX(corp_trademark_class_desc5_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_class_desc5_values_persisted,corp_trademark_class_desc5,corp_trademark_class_desc5_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_class_desc5_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_class_desc6_values_persisted,Layout_Specificities.corp_trademark_class_desc6_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_class_desc6_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_class_desc6_deduped,corp_trademark_class_desc6,,corp_trademark_class_desc6_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_class_desc6_switch := bf;
EXPORT corp_trademark_class_desc6_max := MAX(corp_trademark_class_desc6_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_class_desc6_values_persisted,corp_trademark_class_desc6,corp_trademark_class_desc6_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_class_desc6_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_classification_nbr_values_persisted,Layout_Specificities.corp_trademark_classification_nbr_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_classification_nbr_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_classification_nbr_deduped,corp_trademark_classification_nbr,,corp_trademark_classification_nbr_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_classification_nbr_switch := bf;
EXPORT corp_trademark_classification_nbr_max := MAX(corp_trademark_classification_nbr_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_classification_nbr_values_persisted,corp_trademark_classification_nbr,corp_trademark_classification_nbr_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_classification_nbr_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_disclaimer1_values_persisted,Layout_Specificities.corp_trademark_disclaimer1_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_disclaimer1_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_disclaimer1_deduped,corp_trademark_disclaimer1,,corp_trademark_disclaimer1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_disclaimer1_switch := bf;
EXPORT corp_trademark_disclaimer1_max := MAX(corp_trademark_disclaimer1_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_disclaimer1_values_persisted,corp_trademark_disclaimer1,corp_trademark_disclaimer1_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_disclaimer1_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_disclaimer2_values_persisted,Layout_Specificities.corp_trademark_disclaimer2_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_disclaimer2_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_disclaimer2_deduped,corp_trademark_disclaimer2,,corp_trademark_disclaimer2_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_disclaimer2_switch := bf;
EXPORT corp_trademark_disclaimer2_max := MAX(corp_trademark_disclaimer2_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_disclaimer2_values_persisted,corp_trademark_disclaimer2,corp_trademark_disclaimer2_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_disclaimer2_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_expiration_date_values_persisted,Layout_Specificities.corp_trademark_expiration_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_expiration_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_expiration_date_deduped,corp_trademark_expiration_date,,corp_trademark_expiration_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_expiration_date_switch := bf;
EXPORT corp_trademark_expiration_date_max := MAX(corp_trademark_expiration_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_expiration_date_values_persisted,corp_trademark_expiration_date,corp_trademark_expiration_date_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_expiration_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_filing_date_values_persisted,Layout_Specificities.corp_trademark_filing_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_filing_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_filing_date_deduped,corp_trademark_filing_date,,corp_trademark_filing_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_filing_date_switch := bf;
EXPORT corp_trademark_filing_date_max := MAX(corp_trademark_filing_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_filing_date_values_persisted,corp_trademark_filing_date,corp_trademark_filing_date_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_filing_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_first_use_date_values_persisted,Layout_Specificities.corp_trademark_first_use_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_first_use_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_first_use_date_deduped,corp_trademark_first_use_date,,corp_trademark_first_use_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_first_use_date_switch := bf;
EXPORT corp_trademark_first_use_date_max := MAX(corp_trademark_first_use_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_first_use_date_values_persisted,corp_trademark_first_use_date,corp_trademark_first_use_date_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_first_use_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_first_use_date_in_state_values_persisted,Layout_Specificities.corp_trademark_first_use_date_in_state_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_first_use_date_in_state_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_first_use_date_in_state_deduped,corp_trademark_first_use_date_in_state,,corp_trademark_first_use_date_in_state_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_first_use_date_in_state_switch := bf;
EXPORT corp_trademark_first_use_date_in_state_max := MAX(corp_trademark_first_use_date_in_state_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_first_use_date_in_state_values_persisted,corp_trademark_first_use_date_in_state,corp_trademark_first_use_date_in_state_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_first_use_date_in_state_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_keywords_values_persisted,Layout_Specificities.corp_trademark_keywords_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_keywords_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_keywords_deduped,corp_trademark_keywords,,corp_trademark_keywords_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_keywords_switch := bf;
EXPORT corp_trademark_keywords_max := MAX(corp_trademark_keywords_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_keywords_values_persisted,corp_trademark_keywords,corp_trademark_keywords_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_keywords_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_logo_values_persisted,Layout_Specificities.corp_trademark_logo_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_logo_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_logo_deduped,corp_trademark_logo,,corp_trademark_logo_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_logo_switch := bf;
EXPORT corp_trademark_logo_max := MAX(corp_trademark_logo_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_logo_values_persisted,corp_trademark_logo,corp_trademark_logo_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_logo_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_name_expiration_date_values_persisted,Layout_Specificities.corp_trademark_name_expiration_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_name_expiration_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_name_expiration_date_deduped,corp_trademark_name_expiration_date,,corp_trademark_name_expiration_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_name_expiration_date_switch := bf;
EXPORT corp_trademark_name_expiration_date_max := MAX(corp_trademark_name_expiration_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_name_expiration_date_values_persisted,corp_trademark_name_expiration_date,corp_trademark_name_expiration_date_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_name_expiration_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_nbr_values_persisted,Layout_Specificities.corp_trademark_nbr_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_nbr_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_nbr_deduped,corp_trademark_nbr,,corp_trademark_nbr_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_nbr_switch := bf;
EXPORT corp_trademark_nbr_max := MAX(corp_trademark_nbr_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_nbr_values_persisted,corp_trademark_nbr,corp_trademark_nbr_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_nbr_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_renewal_date_values_persisted,Layout_Specificities.corp_trademark_renewal_date_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_renewal_date_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_renewal_date_deduped,corp_trademark_renewal_date,,corp_trademark_renewal_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_renewal_date_switch := bf;
EXPORT corp_trademark_renewal_date_max := MAX(corp_trademark_renewal_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_renewal_date_values_persisted,corp_trademark_renewal_date,corp_trademark_renewal_date_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_renewal_date_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_status_values_persisted,Layout_Specificities.corp_trademark_status_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_status_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_status_deduped,corp_trademark_status,,corp_trademark_status_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_status_switch := bf;
EXPORT corp_trademark_status_max := MAX(corp_trademark_status_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_status_values_persisted,corp_trademark_status,corp_trademark_status_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_status_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_used_1_values_persisted,Layout_Specificities.corp_trademark_used_1_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_used_1_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_used_1_deduped,corp_trademark_used_1,,corp_trademark_used_1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_used_1_switch := bf;
EXPORT corp_trademark_used_1_max := MAX(corp_trademark_used_1_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_used_1_values_persisted,corp_trademark_used_1,corp_trademark_used_1_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_used_1_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_used_2_values_persisted,Layout_Specificities.corp_trademark_used_2_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_used_2_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_used_2_deduped,corp_trademark_used_2,,corp_trademark_used_2_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_used_2_switch := bf;
EXPORT corp_trademark_used_2_max := MAX(corp_trademark_used_2_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_used_2_values_persisted,corp_trademark_used_2,corp_trademark_used_2_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_used_2_specificity := ol;
SALT34.MAC_Field_Nulls(corp_trademark_used_3_values_persisted,Layout_Specificities.corp_trademark_used_3_ChildRec,nv) // Use automated NULL spotting
EXPORT corp_trademark_used_3_nulls := nv;
SALT34.MAC_Field_Bfoul(corp_trademark_used_3_deduped,corp_trademark_used_3,,corp_trademark_used_3_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_trademark_used_3_switch := bf;
EXPORT corp_trademark_used_3_max := MAX(corp_trademark_used_3_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(corp_trademark_used_3_values_persisted,corp_trademark_used_3,corp_trademark_used_3_nulls,ol) // Compute column level specificity
EXPORT corp_trademark_used_3_specificity := ol;
SALT34.MAC_Field_Nulls(cont_owner_percentage_values_persisted,Layout_Specificities.cont_owner_percentage_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_owner_percentage_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_owner_percentage_deduped,cont_owner_percentage,,cont_owner_percentage_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_owner_percentage_switch := bf;
EXPORT cont_owner_percentage_max := MAX(cont_owner_percentage_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_owner_percentage_values_persisted,cont_owner_percentage,cont_owner_percentage_nulls,ol) // Compute column level specificity
EXPORT cont_owner_percentage_specificity := ol;
SALT34.MAC_Field_Nulls(cont_country_values_persisted,Layout_Specificities.cont_country_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_country_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_country_deduped,cont_country,,cont_country_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_country_switch := bf;
EXPORT cont_country_max := MAX(cont_country_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_country_values_persisted,cont_country,cont_country_nulls,ol) // Compute column level specificity
EXPORT cont_country_specificity := ol;
SALT34.MAC_Field_Nulls(cont_country_mailing_values_persisted,Layout_Specificities.cont_country_mailing_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_country_mailing_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_country_mailing_deduped,cont_country_mailing,,cont_country_mailing_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_country_mailing_switch := bf;
EXPORT cont_country_mailing_max := MAX(cont_country_mailing_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_country_mailing_values_persisted,cont_country_mailing,cont_country_mailing_nulls,ol) // Compute column level specificity
EXPORT cont_country_mailing_specificity := ol;
SALT34.MAC_Field_Nulls(cont_nondislosure_values_persisted,Layout_Specificities.cont_nondislosure_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_nondislosure_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_nondislosure_deduped,cont_nondislosure,,cont_nondislosure_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_nondislosure_switch := bf;
EXPORT cont_nondislosure_max := MAX(cont_nondislosure_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_nondislosure_values_persisted,cont_nondislosure,cont_nondislosure_nulls,ol) // Compute column level specificity
EXPORT cont_nondislosure_specificity := ol;
SALT34.MAC_Field_Nulls(cont_prep_addr_line1_values_persisted,Layout_Specificities.cont_prep_addr_line1_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_prep_addr_line1_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_prep_addr_line1_deduped,cont_prep_addr_line1,,cont_prep_addr_line1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_prep_addr_line1_switch := bf;
EXPORT cont_prep_addr_line1_max := MAX(cont_prep_addr_line1_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_prep_addr_line1_values_persisted,cont_prep_addr_line1,cont_prep_addr_line1_nulls,ol) // Compute column level specificity
EXPORT cont_prep_addr_line1_specificity := ol;
SALT34.MAC_Field_Nulls(cont_prep_addr_last_line_values_persisted,Layout_Specificities.cont_prep_addr_last_line_ChildRec,nv) // Use automated NULL spotting
EXPORT cont_prep_addr_last_line_nulls := nv;
SALT34.MAC_Field_Bfoul(cont_prep_addr_last_line_deduped,cont_prep_addr_last_line,,cont_prep_addr_last_line_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cont_prep_addr_last_line_switch := bf;
EXPORT cont_prep_addr_last_line_max := MAX(cont_prep_addr_last_line_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(cont_prep_addr_last_line_values_persisted,cont_prep_addr_last_line,cont_prep_addr_last_line_nulls,ol) // Compute column level specificity
EXPORT cont_prep_addr_last_line_specificity := ol;
SALT34.MAC_Field_Nulls(recordorigin_values_persisted,Layout_Specificities.recordorigin_ChildRec,nv) // Use automated NULL spotting
EXPORT recordorigin_nulls := nv;
SALT34.MAC_Field_Bfoul(recordorigin_deduped,recordorigin,,recordorigin_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT recordorigin_switch := bf;
EXPORT recordorigin_max := MAX(recordorigin_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(recordorigin_values_persisted,recordorigin,recordorigin_nulls,ol) // Compute column level specificity
EXPORT recordorigin_specificity := ol;
iSpecificities := DATASET([{0,dt_vendor_first_reported_year_specificity,dt_vendor_first_reported_year_switch,dt_vendor_first_reported_year_max,dt_vendor_first_reported_year_nulls,dt_vendor_first_reported_month_specificity,dt_vendor_first_reported_month_switch,dt_vendor_first_reported_month_max,dt_vendor_first_reported_month_nulls,dt_vendor_first_reported_day_specificity,dt_vendor_first_reported_day_switch,dt_vendor_first_reported_day_max,dt_vendor_first_reported_day_nulls,dt_vendor_last_reported_year_specificity,dt_vendor_last_reported_year_switch,dt_vendor_last_reported_year_max,dt_vendor_last_reported_year_nulls,dt_vendor_last_reported_month_specificity,dt_vendor_last_reported_month_switch,dt_vendor_last_reported_month_max,dt_vendor_last_reported_month_nulls,dt_vendor_last_reported_day_specificity,dt_vendor_last_reported_day_switch,dt_vendor_last_reported_day_max,dt_vendor_last_reported_day_nulls,dt_first_seen_year_specificity,dt_first_seen_year_switch,dt_first_seen_year_max,dt_first_seen_year_nulls,dt_first_seen_month_specificity,dt_first_seen_month_switch,dt_first_seen_month_max,dt_first_seen_month_nulls,dt_first_seen_day_specificity,dt_first_seen_day_switch,dt_first_seen_day_max,dt_first_seen_day_nulls,dt_last_seen_year_specificity,dt_last_seen_year_switch,dt_last_seen_year_max,dt_last_seen_year_nulls,dt_last_seen_month_specificity,dt_last_seen_month_switch,dt_last_seen_month_max,dt_last_seen_month_nulls,dt_last_seen_day_specificity,dt_last_seen_day_switch,dt_last_seen_day_max,dt_last_seen_day_nulls,corp_ra_dt_first_seen_year_specificity,corp_ra_dt_first_seen_year_switch,corp_ra_dt_first_seen_year_max,corp_ra_dt_first_seen_year_nulls,corp_ra_dt_first_seen_month_specificity,corp_ra_dt_first_seen_month_switch,corp_ra_dt_first_seen_month_max,corp_ra_dt_first_seen_month_nulls,corp_ra_dt_first_seen_day_specificity,corp_ra_dt_first_seen_day_switch,corp_ra_dt_first_seen_day_max,corp_ra_dt_first_seen_day_nulls,corp_ra_dt_last_seen_year_specificity,corp_ra_dt_last_seen_year_switch,corp_ra_dt_last_seen_year_max,corp_ra_dt_last_seen_year_nulls,corp_ra_dt_last_seen_month_specificity,corp_ra_dt_last_seen_month_switch,corp_ra_dt_last_seen_month_max,corp_ra_dt_last_seen_month_nulls,corp_ra_dt_last_seen_day_specificity,corp_ra_dt_last_seen_day_switch,corp_ra_dt_last_seen_day_max,corp_ra_dt_last_seen_day_nulls,corp_key_specificity,corp_key_switch,corp_key_max,corp_key_nulls,corp_supp_key_specificity,corp_supp_key_switch,corp_supp_key_max,corp_supp_key_nulls,corp_vendor_specificity,corp_vendor_switch,corp_vendor_max,corp_vendor_nulls,corp_vendor_county_specificity,corp_vendor_county_switch,corp_vendor_county_max,corp_vendor_county_nulls,corp_vendor_subcode_specificity,corp_vendor_subcode_switch,corp_vendor_subcode_max,corp_vendor_subcode_nulls,corp_state_origin_specificity,corp_state_origin_switch,corp_state_origin_max,corp_state_origin_nulls,corp_process_date_year_specificity,corp_process_date_year_switch,corp_process_date_year_max,corp_process_date_year_nulls,corp_process_date_month_specificity,corp_process_date_month_switch,corp_process_date_month_max,corp_process_date_month_nulls,corp_process_date_day_specificity,corp_process_date_day_switch,corp_process_date_day_max,corp_process_date_day_nulls,corp_orig_sos_charter_nbr_specificity,corp_orig_sos_charter_nbr_switch,corp_orig_sos_charter_nbr_max,corp_orig_sos_charter_nbr_nulls,corp_legal_name_specificity,corp_legal_name_switch,corp_legal_name_max,corp_legal_name_nulls,corp_ln_name_type_cd_specificity,corp_ln_name_type_cd_switch,corp_ln_name_type_cd_max,corp_ln_name_type_cd_nulls,corp_ln_name_type_desc_specificity,corp_ln_name_type_desc_switch,corp_ln_name_type_desc_max,corp_ln_name_type_desc_nulls,corp_supp_nbr_specificity,corp_supp_nbr_switch,corp_supp_nbr_max,corp_supp_nbr_nulls,corp_name_comment_specificity,corp_name_comment_switch,corp_name_comment_max,corp_name_comment_nulls,corp_address1_type_cd_specificity,corp_address1_type_cd_switch,corp_address1_type_cd_max,corp_address1_type_cd_nulls,corp_address1_type_desc_specificity,corp_address1_type_desc_switch,corp_address1_type_desc_max,corp_address1_type_desc_nulls,corp_address1_line1_specificity,corp_address1_line1_switch,corp_address1_line1_max,corp_address1_line1_nulls,corp_address1_line2_specificity,corp_address1_line2_switch,corp_address1_line2_max,corp_address1_line2_nulls,corp_address1_line3_specificity,corp_address1_line3_switch,corp_address1_line3_max,corp_address1_line3_nulls,corp_address1_effective_date_specificity,corp_address1_effective_date_switch,corp_address1_effective_date_max,corp_address1_effective_date_nulls,corp_address2_type_cd_specificity,corp_address2_type_cd_switch,corp_address2_type_cd_max,corp_address2_type_cd_nulls,corp_address2_type_desc_specificity,corp_address2_type_desc_switch,corp_address2_type_desc_max,corp_address2_type_desc_nulls,corp_address2_line1_specificity,corp_address2_line1_switch,corp_address2_line1_max,corp_address2_line1_nulls,corp_address2_line2_specificity,corp_address2_line2_switch,corp_address2_line2_max,corp_address2_line2_nulls,corp_address2_line3_specificity,corp_address2_line3_switch,corp_address2_line3_max,corp_address2_line3_nulls,corp_address2_effective_date_specificity,corp_address2_effective_date_switch,corp_address2_effective_date_max,corp_address2_effective_date_nulls,corp_phone_number_specificity,corp_phone_number_switch,corp_phone_number_max,corp_phone_number_nulls,corp_phone_number_type_cd_specificity,corp_phone_number_type_cd_switch,corp_phone_number_type_cd_max,corp_phone_number_type_cd_nulls,corp_phone_number_type_desc_specificity,corp_phone_number_type_desc_switch,corp_phone_number_type_desc_max,corp_phone_number_type_desc_nulls,corp_fax_nbr_specificity,corp_fax_nbr_switch,corp_fax_nbr_max,corp_fax_nbr_nulls,corp_email_address_specificity,corp_email_address_switch,corp_email_address_max,corp_email_address_nulls,corp_web_address_specificity,corp_web_address_switch,corp_web_address_max,corp_web_address_nulls,corp_filing_reference_nbr_specificity,corp_filing_reference_nbr_switch,corp_filing_reference_nbr_max,corp_filing_reference_nbr_nulls,corp_filing_date_specificity,corp_filing_date_switch,corp_filing_date_max,corp_filing_date_nulls,corp_filing_cd_specificity,corp_filing_cd_switch,corp_filing_cd_max,corp_filing_cd_nulls,corp_filing_desc_specificity,corp_filing_desc_switch,corp_filing_desc_max,corp_filing_desc_nulls,corp_status_cd_specificity,corp_status_cd_switch,corp_status_cd_max,corp_status_cd_nulls,corp_status_desc_specificity,corp_status_desc_switch,corp_status_desc_max,corp_status_desc_nulls,corp_status_date_specificity,corp_status_date_switch,corp_status_date_max,corp_status_date_nulls,corp_standing_specificity,corp_standing_switch,corp_standing_max,corp_standing_nulls,corp_status_comment_specificity,corp_status_comment_switch,corp_status_comment_max,corp_status_comment_nulls,corp_ticker_symbol_specificity,corp_ticker_symbol_switch,corp_ticker_symbol_max,corp_ticker_symbol_nulls,corp_stock_exchange_specificity,corp_stock_exchange_switch,corp_stock_exchange_max,corp_stock_exchange_nulls,corp_inc_state_specificity,corp_inc_state_switch,corp_inc_state_max,corp_inc_state_nulls,corp_inc_county_specificity,corp_inc_county_switch,corp_inc_county_max,corp_inc_county_nulls,corp_inc_date_specificity,corp_inc_date_switch,corp_inc_date_max,corp_inc_date_nulls,corp_anniversary_month_specificity,corp_anniversary_month_switch,corp_anniversary_month_max,corp_anniversary_month_nulls,corp_fed_tax_id_specificity,corp_fed_tax_id_switch,corp_fed_tax_id_max,corp_fed_tax_id_nulls,corp_state_tax_id_specificity,corp_state_tax_id_switch,corp_state_tax_id_max,corp_state_tax_id_nulls,corp_term_exist_cd_specificity,corp_term_exist_cd_switch,corp_term_exist_cd_max,corp_term_exist_cd_nulls,corp_term_exist_exp_specificity,corp_term_exist_exp_switch,corp_term_exist_exp_max,corp_term_exist_exp_nulls,corp_term_exist_desc_specificity,corp_term_exist_desc_switch,corp_term_exist_desc_max,corp_term_exist_desc_nulls,corp_foreign_domestic_ind_specificity,corp_foreign_domestic_ind_switch,corp_foreign_domestic_ind_max,corp_foreign_domestic_ind_nulls,corp_forgn_state_cd_specificity,corp_forgn_state_cd_switch,corp_forgn_state_cd_max,corp_forgn_state_cd_nulls,corp_forgn_state_desc_specificity,corp_forgn_state_desc_switch,corp_forgn_state_desc_max,corp_forgn_state_desc_nulls,corp_forgn_sos_charter_nbr_specificity,corp_forgn_sos_charter_nbr_switch,corp_forgn_sos_charter_nbr_max,corp_forgn_sos_charter_nbr_nulls,corp_forgn_date_specificity,corp_forgn_date_switch,corp_forgn_date_max,corp_forgn_date_nulls,corp_forgn_fed_tax_id_specificity,corp_forgn_fed_tax_id_switch,corp_forgn_fed_tax_id_max,corp_forgn_fed_tax_id_nulls,corp_forgn_state_tax_id_specificity,corp_forgn_state_tax_id_switch,corp_forgn_state_tax_id_max,corp_forgn_state_tax_id_nulls,corp_forgn_term_exist_cd_specificity,corp_forgn_term_exist_cd_switch,corp_forgn_term_exist_cd_max,corp_forgn_term_exist_cd_nulls,corp_forgn_term_exist_exp_specificity,corp_forgn_term_exist_exp_switch,corp_forgn_term_exist_exp_max,corp_forgn_term_exist_exp_nulls,corp_forgn_term_exist_desc_specificity,corp_forgn_term_exist_desc_switch,corp_forgn_term_exist_desc_max,corp_forgn_term_exist_desc_nulls,corp_orig_org_structure_cd_specificity,corp_orig_org_structure_cd_switch,corp_orig_org_structure_cd_max,corp_orig_org_structure_cd_nulls,corp_orig_org_structure_desc_specificity,corp_orig_org_structure_desc_switch,corp_orig_org_structure_desc_max,corp_orig_org_structure_desc_nulls,corp_for_profit_ind_specificity,corp_for_profit_ind_switch,corp_for_profit_ind_max,corp_for_profit_ind_nulls,corp_public_or_private_ind_specificity,corp_public_or_private_ind_switch,corp_public_or_private_ind_max,corp_public_or_private_ind_nulls,corp_sic_code_specificity,corp_sic_code_switch,corp_sic_code_max,corp_sic_code_nulls,corp_naic_code_specificity,corp_naic_code_switch,corp_naic_code_max,corp_naic_code_nulls,corp_orig_bus_type_cd_specificity,corp_orig_bus_type_cd_switch,corp_orig_bus_type_cd_max,corp_orig_bus_type_cd_nulls,corp_orig_bus_type_desc_specificity,corp_orig_bus_type_desc_switch,corp_orig_bus_type_desc_max,corp_orig_bus_type_desc_nulls,corp_entity_desc_specificity,corp_entity_desc_switch,corp_entity_desc_max,corp_entity_desc_nulls,corp_certificate_nbr_specificity,corp_certificate_nbr_switch,corp_certificate_nbr_max,corp_certificate_nbr_nulls,corp_internal_nbr_specificity,corp_internal_nbr_switch,corp_internal_nbr_max,corp_internal_nbr_nulls,corp_previous_nbr_specificity,corp_previous_nbr_switch,corp_previous_nbr_max,corp_previous_nbr_nulls,corp_microfilm_nbr_specificity,corp_microfilm_nbr_switch,corp_microfilm_nbr_max,corp_microfilm_nbr_nulls,corp_amendments_filed_specificity,corp_amendments_filed_switch,corp_amendments_filed_max,corp_amendments_filed_nulls,corp_acts_specificity,corp_acts_switch,corp_acts_max,corp_acts_nulls,corp_partnership_ind_specificity,corp_partnership_ind_switch,corp_partnership_ind_max,corp_partnership_ind_nulls,corp_mfg_ind_specificity,corp_mfg_ind_switch,corp_mfg_ind_max,corp_mfg_ind_nulls,corp_addl_info_specificity,corp_addl_info_switch,corp_addl_info_max,corp_addl_info_nulls,corp_taxes_specificity,corp_taxes_switch,corp_taxes_max,corp_taxes_nulls,corp_franchise_taxes_specificity,corp_franchise_taxes_switch,corp_franchise_taxes_max,corp_franchise_taxes_nulls,corp_tax_program_cd_specificity,corp_tax_program_cd_switch,corp_tax_program_cd_max,corp_tax_program_cd_nulls,corp_tax_program_desc_specificity,corp_tax_program_desc_switch,corp_tax_program_desc_max,corp_tax_program_desc_nulls,corp_ra_full_name_specificity,corp_ra_full_name_switch,corp_ra_full_name_max,corp_ra_full_name_nulls,corp_ra_fname_specificity,corp_ra_fname_switch,corp_ra_fname_max,corp_ra_fname_nulls,corp_ra_mname_specificity,corp_ra_mname_switch,corp_ra_mname_max,corp_ra_mname_nulls,corp_ra_lname_specificity,corp_ra_lname_switch,corp_ra_lname_max,corp_ra_lname_nulls,corp_ra_suffix_specificity,corp_ra_suffix_switch,corp_ra_suffix_max,corp_ra_suffix_nulls,corp_ra_title_cd_specificity,corp_ra_title_cd_switch,corp_ra_title_cd_max,corp_ra_title_cd_nulls,corp_ra_title_desc_specificity,corp_ra_title_desc_switch,corp_ra_title_desc_max,corp_ra_title_desc_nulls,corp_ra_fein_specificity,corp_ra_fein_switch,corp_ra_fein_max,corp_ra_fein_nulls,corp_ra_ssn_specificity,corp_ra_ssn_switch,corp_ra_ssn_max,corp_ra_ssn_nulls,corp_ra_dob_specificity,corp_ra_dob_switch,corp_ra_dob_max,corp_ra_dob_nulls,corp_ra_effective_date_specificity,corp_ra_effective_date_switch,corp_ra_effective_date_max,corp_ra_effective_date_nulls,corp_ra_resign_date_specificity,corp_ra_resign_date_switch,corp_ra_resign_date_max,corp_ra_resign_date_nulls,corp_ra_no_comp_specificity,corp_ra_no_comp_switch,corp_ra_no_comp_max,corp_ra_no_comp_nulls,corp_ra_no_comp_igs_specificity,corp_ra_no_comp_igs_switch,corp_ra_no_comp_igs_max,corp_ra_no_comp_igs_nulls,corp_ra_addl_info_specificity,corp_ra_addl_info_switch,corp_ra_addl_info_max,corp_ra_addl_info_nulls,corp_ra_address_type_cd_specificity,corp_ra_address_type_cd_switch,corp_ra_address_type_cd_max,corp_ra_address_type_cd_nulls,corp_ra_address_type_desc_specificity,corp_ra_address_type_desc_switch,corp_ra_address_type_desc_max,corp_ra_address_type_desc_nulls,corp_ra_address_line1_specificity,corp_ra_address_line1_switch,corp_ra_address_line1_max,corp_ra_address_line1_nulls,corp_ra_address_line2_specificity,corp_ra_address_line2_switch,corp_ra_address_line2_max,corp_ra_address_line2_nulls,corp_ra_address_line3_specificity,corp_ra_address_line3_switch,corp_ra_address_line3_max,corp_ra_address_line3_nulls,corp_ra_phone_number_specificity,corp_ra_phone_number_switch,corp_ra_phone_number_max,corp_ra_phone_number_nulls,corp_ra_phone_number_type_cd_specificity,corp_ra_phone_number_type_cd_switch,corp_ra_phone_number_type_cd_max,corp_ra_phone_number_type_cd_nulls,corp_ra_phone_number_type_desc_specificity,corp_ra_phone_number_type_desc_switch,corp_ra_phone_number_type_desc_max,corp_ra_phone_number_type_desc_nulls,corp_ra_fax_nbr_specificity,corp_ra_fax_nbr_switch,corp_ra_fax_nbr_max,corp_ra_fax_nbr_nulls,corp_ra_email_address_specificity,corp_ra_email_address_switch,corp_ra_email_address_max,corp_ra_email_address_nulls,corp_ra_web_address_specificity,corp_ra_web_address_switch,corp_ra_web_address_max,corp_ra_web_address_nulls,corp_prep_addr1_line1_specificity,corp_prep_addr1_line1_switch,corp_prep_addr1_line1_max,corp_prep_addr1_line1_nulls,corp_prep_addr1_last_line_specificity,corp_prep_addr1_last_line_switch,corp_prep_addr1_last_line_max,corp_prep_addr1_last_line_nulls,corp_prep_addr2_line1_specificity,corp_prep_addr2_line1_switch,corp_prep_addr2_line1_max,corp_prep_addr2_line1_nulls,corp_prep_addr2_last_line_specificity,corp_prep_addr2_last_line_switch,corp_prep_addr2_last_line_max,corp_prep_addr2_last_line_nulls,ra_prep_addr_line1_specificity,ra_prep_addr_line1_switch,ra_prep_addr_line1_max,ra_prep_addr_line1_nulls,ra_prep_addr_last_line_specificity,ra_prep_addr_last_line_switch,ra_prep_addr_last_line_max,ra_prep_addr_last_line_nulls,cont_filing_reference_nbr_specificity,cont_filing_reference_nbr_switch,cont_filing_reference_nbr_max,cont_filing_reference_nbr_nulls,cont_filing_date_specificity,cont_filing_date_switch,cont_filing_date_max,cont_filing_date_nulls,cont_filing_cd_specificity,cont_filing_cd_switch,cont_filing_cd_max,cont_filing_cd_nulls,cont_filing_desc_specificity,cont_filing_desc_switch,cont_filing_desc_max,cont_filing_desc_nulls,cont_type_cd_specificity,cont_type_cd_switch,cont_type_cd_max,cont_type_cd_nulls,cont_type_desc_specificity,cont_type_desc_switch,cont_type_desc_max,cont_type_desc_nulls,cont_full_name_specificity,cont_full_name_switch,cont_full_name_max,cont_full_name_nulls,cont_fname_specificity,cont_fname_switch,cont_fname_max,cont_fname_nulls,cont_mname_specificity,cont_mname_switch,cont_mname_max,cont_mname_nulls,cont_lname_specificity,cont_lname_switch,cont_lname_max,cont_lname_nulls,cont_suffix_specificity,cont_suffix_switch,cont_suffix_max,cont_suffix_nulls,cont_title1_desc_specificity,cont_title1_desc_switch,cont_title1_desc_max,cont_title1_desc_nulls,cont_title2_desc_specificity,cont_title2_desc_switch,cont_title2_desc_max,cont_title2_desc_nulls,cont_title3_desc_specificity,cont_title3_desc_switch,cont_title3_desc_max,cont_title3_desc_nulls,cont_title4_desc_specificity,cont_title4_desc_switch,cont_title4_desc_max,cont_title4_desc_nulls,cont_title5_desc_specificity,cont_title5_desc_switch,cont_title5_desc_max,cont_title5_desc_nulls,cont_fein_specificity,cont_fein_switch,cont_fein_max,cont_fein_nulls,cont_ssn_specificity,cont_ssn_switch,cont_ssn_max,cont_ssn_nulls,cont_dob_specificity,cont_dob_switch,cont_dob_max,cont_dob_nulls,cont_status_cd_specificity,cont_status_cd_switch,cont_status_cd_max,cont_status_cd_nulls,cont_status_desc_specificity,cont_status_desc_switch,cont_status_desc_max,cont_status_desc_nulls,cont_effective_date_specificity,cont_effective_date_switch,cont_effective_date_max,cont_effective_date_nulls,cont_effective_cd_specificity,cont_effective_cd_switch,cont_effective_cd_max,cont_effective_cd_nulls,cont_effective_desc_specificity,cont_effective_desc_switch,cont_effective_desc_max,cont_effective_desc_nulls,cont_addl_info_specificity,cont_addl_info_switch,cont_addl_info_max,cont_addl_info_nulls,cont_address_type_cd_specificity,cont_address_type_cd_switch,cont_address_type_cd_max,cont_address_type_cd_nulls,cont_address_type_desc_specificity,cont_address_type_desc_switch,cont_address_type_desc_max,cont_address_type_desc_nulls,cont_address_line1_specificity,cont_address_line1_switch,cont_address_line1_max,cont_address_line1_nulls,cont_address_line2_specificity,cont_address_line2_switch,cont_address_line2_max,cont_address_line2_nulls,cont_address_line3_specificity,cont_address_line3_switch,cont_address_line3_max,cont_address_line3_nulls,cont_address_effective_date_specificity,cont_address_effective_date_switch,cont_address_effective_date_max,cont_address_effective_date_nulls,cont_address_county_specificity,cont_address_county_switch,cont_address_county_max,cont_address_county_nulls,cont_phone_number_specificity,cont_phone_number_switch,cont_phone_number_max,cont_phone_number_nulls,cont_phone_number_type_cd_specificity,cont_phone_number_type_cd_switch,cont_phone_number_type_cd_max,cont_phone_number_type_cd_nulls,cont_phone_number_type_desc_specificity,cont_phone_number_type_desc_switch,cont_phone_number_type_desc_max,cont_phone_number_type_desc_nulls,cont_fax_nbr_specificity,cont_fax_nbr_switch,cont_fax_nbr_max,cont_fax_nbr_nulls,cont_email_address_specificity,cont_email_address_switch,cont_email_address_max,cont_email_address_nulls,cont_web_address_specificity,cont_web_address_switch,cont_web_address_max,cont_web_address_nulls,corp_acres_specificity,corp_acres_switch,corp_acres_max,corp_acres_nulls,corp_action_specificity,corp_action_switch,corp_action_max,corp_action_nulls,corp_action_date_specificity,corp_action_date_switch,corp_action_date_max,corp_action_date_nulls,corp_action_employment_security_approval_date_specificity,corp_action_employment_security_approval_date_switch,corp_action_employment_security_approval_date_max,corp_action_employment_security_approval_date_nulls,corp_action_pending_cd_specificity,corp_action_pending_cd_switch,corp_action_pending_cd_max,corp_action_pending_cd_nulls,corp_action_pending_desc_specificity,corp_action_pending_desc_switch,corp_action_pending_desc_max,corp_action_pending_desc_nulls,corp_action_statement_of_intent_date_specificity,corp_action_statement_of_intent_date_switch,corp_action_statement_of_intent_date_max,corp_action_statement_of_intent_date_nulls,corp_action_tax_dept_approval_date_specificity,corp_action_tax_dept_approval_date_switch,corp_action_tax_dept_approval_date_max,corp_action_tax_dept_approval_date_nulls,corp_acts2_specificity,corp_acts2_switch,corp_acts2_max,corp_acts2_nulls,corp_acts3_specificity,corp_acts3_switch,corp_acts3_max,corp_acts3_nulls,corp_additional_principals_specificity,corp_additional_principals_switch,corp_additional_principals_max,corp_additional_principals_nulls,corp_address_office_type_specificity,corp_address_office_type_switch,corp_address_office_type_max,corp_address_office_type_nulls,corp_agent_assign_date_specificity,corp_agent_assign_date_switch,corp_agent_assign_date_max,corp_agent_assign_date_nulls,corp_agent_commercial_specificity,corp_agent_commercial_switch,corp_agent_commercial_max,corp_agent_commercial_nulls,corp_agent_country_specificity,corp_agent_country_switch,corp_agent_country_max,corp_agent_country_nulls,corp_agent_county_specificity,corp_agent_county_switch,corp_agent_county_max,corp_agent_county_nulls,corp_agent_status_cd_specificity,corp_agent_status_cd_switch,corp_agent_status_cd_max,corp_agent_status_cd_nulls,corp_agent_status_desc_specificity,corp_agent_status_desc_switch,corp_agent_status_desc_max,corp_agent_status_desc_nulls,corp_agent_id_specificity,corp_agent_id_switch,corp_agent_id_max,corp_agent_id_nulls,corp_agriculture_flag_specificity,corp_agriculture_flag_switch,corp_agriculture_flag_max,corp_agriculture_flag_nulls,corp_authorized_partners_specificity,corp_authorized_partners_switch,corp_authorized_partners_max,corp_authorized_partners_nulls,corp_comment_specificity,corp_comment_switch,corp_comment_max,corp_comment_nulls,corp_consent_flag_for_protected_name_specificity,corp_consent_flag_for_protected_name_switch,corp_consent_flag_for_protected_name_max,corp_consent_flag_for_protected_name_nulls,corp_converted_specificity,corp_converted_switch,corp_converted_max,corp_converted_nulls,corp_converted_from_specificity,corp_converted_from_switch,corp_converted_from_max,corp_converted_from_nulls,corp_country_of_formation_specificity,corp_country_of_formation_switch,corp_country_of_formation_max,corp_country_of_formation_nulls,corp_date_of_organization_meeting_specificity,corp_date_of_organization_meeting_switch,corp_date_of_organization_meeting_max,corp_date_of_organization_meeting_nulls,corp_delayed_effective_date_specificity,corp_delayed_effective_date_switch,corp_delayed_effective_date_max,corp_delayed_effective_date_nulls,corp_directors_from_to_specificity,corp_directors_from_to_switch,corp_directors_from_to_max,corp_directors_from_to_nulls,corp_dissolved_date_specificity,corp_dissolved_date_switch,corp_dissolved_date_max,corp_dissolved_date_nulls,corp_farm_exemptions_specificity,corp_farm_exemptions_switch,corp_farm_exemptions_max,corp_farm_exemptions_nulls,corp_farm_qual_date_specificity,corp_farm_qual_date_switch,corp_farm_qual_date_max,corp_farm_qual_date_nulls,corp_farm_status_cd_specificity,corp_farm_status_cd_switch,corp_farm_status_cd_max,corp_farm_status_cd_nulls,corp_farm_status_desc_specificity,corp_farm_status_desc_switch,corp_farm_status_desc_max,corp_farm_status_desc_nulls,corp_fiscal_year_month_specificity,corp_fiscal_year_month_switch,corp_fiscal_year_month_max,corp_fiscal_year_month_nulls,corp_foreign_fiduciary_capacity_in_state_specificity,corp_foreign_fiduciary_capacity_in_state_switch,corp_foreign_fiduciary_capacity_in_state_max,corp_foreign_fiduciary_capacity_in_state_nulls,corp_governing_statute_specificity,corp_governing_statute_switch,corp_governing_statute_max,corp_governing_statute_nulls,corp_has_members_specificity,corp_has_members_switch,corp_has_members_max,corp_has_members_nulls,corp_has_vested_managers_specificity,corp_has_vested_managers_switch,corp_has_vested_managers_max,corp_has_vested_managers_nulls,corp_home_incorporated_county_specificity,corp_home_incorporated_county_switch,corp_home_incorporated_county_max,corp_home_incorporated_county_nulls,corp_home_state_name_specificity,corp_home_state_name_switch,corp_home_state_name_max,corp_home_state_name_nulls,corp_is_professional_specificity,corp_is_professional_switch,corp_is_professional_max,corp_is_professional_nulls,corp_is_non_profit_irs_approved_specificity,corp_is_non_profit_irs_approved_switch,corp_is_non_profit_irs_approved_max,corp_is_non_profit_irs_approved_nulls,corp_last_renewal_date_specificity,corp_last_renewal_date_switch,corp_last_renewal_date_max,corp_last_renewal_date_nulls,corp_last_renewal_year_specificity,corp_last_renewal_year_switch,corp_last_renewal_year_max,corp_last_renewal_year_nulls,corp_license_type_specificity,corp_license_type_switch,corp_license_type_max,corp_license_type_nulls,corp_llc_managed_desc_specificity,corp_llc_managed_desc_switch,corp_llc_managed_desc_max,corp_llc_managed_desc_nulls,corp_llc_managed_ind_specificity,corp_llc_managed_ind_switch,corp_llc_managed_ind_max,corp_llc_managed_ind_nulls,corp_management_desc_specificity,corp_management_desc_switch,corp_management_desc_max,corp_management_desc_nulls,corp_management_type_specificity,corp_management_type_switch,corp_management_type_max,corp_management_type_nulls,corp_manager_managed_specificity,corp_manager_managed_switch,corp_manager_managed_max,corp_manager_managed_nulls,corp_merged_corporation_id_specificity,corp_merged_corporation_id_switch,corp_merged_corporation_id_max,corp_merged_corporation_id_nulls,corp_merged_fein_specificity,corp_merged_fein_switch,corp_merged_fein_max,corp_merged_fein_nulls,corp_merger_allowed_flag_specificity,corp_merger_allowed_flag_switch,corp_merger_allowed_flag_max,corp_merger_allowed_flag_nulls,corp_merger_date_specificity,corp_merger_date_switch,corp_merger_date_max,corp_merger_date_nulls,corp_merger_desc_specificity,corp_merger_desc_switch,corp_merger_desc_max,corp_merger_desc_nulls,corp_merger_effective_date_specificity,corp_merger_effective_date_switch,corp_merger_effective_date_max,corp_merger_effective_date_nulls,corp_merger_id_specificity,corp_merger_id_switch,corp_merger_id_max,corp_merger_id_nulls,corp_merger_indicator_specificity,corp_merger_indicator_switch,corp_merger_indicator_max,corp_merger_indicator_nulls,corp_merger_name_specificity,corp_merger_name_switch,corp_merger_name_max,corp_merger_name_nulls,corp_merger_type_converted_to_cd_specificity,corp_merger_type_converted_to_cd_switch,corp_merger_type_converted_to_cd_max,corp_merger_type_converted_to_cd_nulls,corp_merger_type_converted_to_desc_specificity,corp_merger_type_converted_to_desc_switch,corp_merger_type_converted_to_desc_max,corp_merger_type_converted_to_desc_nulls,corp_naics_desc_specificity,corp_naics_desc_switch,corp_naics_desc_max,corp_naics_desc_nulls,corp_name_effective_date_specificity,corp_name_effective_date_switch,corp_name_effective_date_max,corp_name_effective_date_nulls,corp_name_reservation_date_specificity,corp_name_reservation_date_switch,corp_name_reservation_date_max,corp_name_reservation_date_nulls,corp_name_reservation_desc_specificity,corp_name_reservation_desc_switch,corp_name_reservation_desc_max,corp_name_reservation_desc_nulls,corp_name_reservation_expiration_date_specificity,corp_name_reservation_expiration_date_switch,corp_name_reservation_expiration_date_max,corp_name_reservation_expiration_date_nulls,corp_name_reservation_nbr_specificity,corp_name_reservation_nbr_switch,corp_name_reservation_nbr_max,corp_name_reservation_nbr_nulls,corp_name_reservation_type_specificity,corp_name_reservation_type_switch,corp_name_reservation_type_max,corp_name_reservation_type_nulls,corp_name_status_cd_specificity,corp_name_status_cd_switch,corp_name_status_cd_max,corp_name_status_cd_nulls,corp_name_status_date_specificity,corp_name_status_date_switch,corp_name_status_date_max,corp_name_status_date_nulls,corp_name_status_desc_specificity,corp_name_status_desc_switch,corp_name_status_desc_max,corp_name_status_desc_nulls,corp_non_profit_irs_approved_purpose_specificity,corp_non_profit_irs_approved_purpose_switch,corp_non_profit_irs_approved_purpose_max,corp_non_profit_irs_approved_purpose_nulls,corp_non_profit_solicit_donations_specificity,corp_non_profit_solicit_donations_switch,corp_non_profit_solicit_donations_max,corp_non_profit_solicit_donations_nulls,corp_nbr_of_amendments_specificity,corp_nbr_of_amendments_switch,corp_nbr_of_amendments_max,corp_nbr_of_amendments_nulls,corp_nbr_of_initial_llc_members_specificity,corp_nbr_of_initial_llc_members_switch,corp_nbr_of_initial_llc_members_max,corp_nbr_of_initial_llc_members_nulls,corp_nbr_of_partners_specificity,corp_nbr_of_partners_switch,corp_nbr_of_partners_max,corp_nbr_of_partners_nulls,corp_operating_agreement_specificity,corp_operating_agreement_switch,corp_operating_agreement_max,corp_operating_agreement_nulls,corp_opt_in_llc_act_desc_specificity,corp_opt_in_llc_act_desc_switch,corp_opt_in_llc_act_desc_max,corp_opt_in_llc_act_desc_nulls,corp_opt_in_llc_act_ind_specificity,corp_opt_in_llc_act_ind_switch,corp_opt_in_llc_act_ind_max,corp_opt_in_llc_act_ind_nulls,corp_organizational_comments_specificity,corp_organizational_comments_switch,corp_organizational_comments_max,corp_organizational_comments_nulls,corp_partner_contributions_total_specificity,corp_partner_contributions_total_switch,corp_partner_contributions_total_max,corp_partner_contributions_total_nulls,corp_partner_terms_specificity,corp_partner_terms_switch,corp_partner_terms_max,corp_partner_terms_nulls,corp_percentage_voters_required_to_approve_amendments_specificity,corp_percentage_voters_required_to_approve_amendments_switch,corp_percentage_voters_required_to_approve_amendments_max,corp_percentage_voters_required_to_approve_amendments_nulls,corp_profession_specificity,corp_profession_switch,corp_profession_max,corp_profession_nulls,corp_province_specificity,corp_province_switch,corp_province_max,corp_province_nulls,corp_public_mutual_corporation_specificity,corp_public_mutual_corporation_switch,corp_public_mutual_corporation_max,corp_public_mutual_corporation_nulls,corp_purpose_specificity,corp_purpose_switch,corp_purpose_max,corp_purpose_nulls,corp_ra_required_flag_specificity,corp_ra_required_flag_switch,corp_ra_required_flag_max,corp_ra_required_flag_nulls,corp_registered_counties_specificity,corp_registered_counties_switch,corp_registered_counties_max,corp_registered_counties_nulls,corp_regulated_ind_specificity,corp_regulated_ind_switch,corp_regulated_ind_max,corp_regulated_ind_nulls,corp_renewal_date_specificity,corp_renewal_date_switch,corp_renewal_date_max,corp_renewal_date_nulls,corp_standing_other_specificity,corp_standing_other_switch,corp_standing_other_max,corp_standing_other_nulls,corp_survivor_corporation_id_specificity,corp_survivor_corporation_id_switch,corp_survivor_corporation_id_max,corp_survivor_corporation_id_nulls,corp_tax_base_specificity,corp_tax_base_switch,corp_tax_base_max,corp_tax_base_nulls,corp_tax_standing_specificity,corp_tax_standing_switch,corp_tax_standing_max,corp_tax_standing_nulls,corp_termination_cd_specificity,corp_termination_cd_switch,corp_termination_cd_max,corp_termination_cd_nulls,corp_termination_desc_specificity,corp_termination_desc_switch,corp_termination_desc_max,corp_termination_desc_nulls,corp_termination_date_specificity,corp_termination_date_switch,corp_termination_date_max,corp_termination_date_nulls,corp_trademark_business_mark_type_specificity,corp_trademark_business_mark_type_switch,corp_trademark_business_mark_type_max,corp_trademark_business_mark_type_nulls,corp_trademark_cancelled_date_specificity,corp_trademark_cancelled_date_switch,corp_trademark_cancelled_date_max,corp_trademark_cancelled_date_nulls,corp_trademark_class_desc1_specificity,corp_trademark_class_desc1_switch,corp_trademark_class_desc1_max,corp_trademark_class_desc1_nulls,corp_trademark_class_desc2_specificity,corp_trademark_class_desc2_switch,corp_trademark_class_desc2_max,corp_trademark_class_desc2_nulls,corp_trademark_class_desc3_specificity,corp_trademark_class_desc3_switch,corp_trademark_class_desc3_max,corp_trademark_class_desc3_nulls,corp_trademark_class_desc4_specificity,corp_trademark_class_desc4_switch,corp_trademark_class_desc4_max,corp_trademark_class_desc4_nulls,corp_trademark_class_desc5_specificity,corp_trademark_class_desc5_switch,corp_trademark_class_desc5_max,corp_trademark_class_desc5_nulls,corp_trademark_class_desc6_specificity,corp_trademark_class_desc6_switch,corp_trademark_class_desc6_max,corp_trademark_class_desc6_nulls,corp_trademark_classification_nbr_specificity,corp_trademark_classification_nbr_switch,corp_trademark_classification_nbr_max,corp_trademark_classification_nbr_nulls,corp_trademark_disclaimer1_specificity,corp_trademark_disclaimer1_switch,corp_trademark_disclaimer1_max,corp_trademark_disclaimer1_nulls,corp_trademark_disclaimer2_specificity,corp_trademark_disclaimer2_switch,corp_trademark_disclaimer2_max,corp_trademark_disclaimer2_nulls,corp_trademark_expiration_date_specificity,corp_trademark_expiration_date_switch,corp_trademark_expiration_date_max,corp_trademark_expiration_date_nulls,corp_trademark_filing_date_specificity,corp_trademark_filing_date_switch,corp_trademark_filing_date_max,corp_trademark_filing_date_nulls,corp_trademark_first_use_date_specificity,corp_trademark_first_use_date_switch,corp_trademark_first_use_date_max,corp_trademark_first_use_date_nulls,corp_trademark_first_use_date_in_state_specificity,corp_trademark_first_use_date_in_state_switch,corp_trademark_first_use_date_in_state_max,corp_trademark_first_use_date_in_state_nulls,corp_trademark_keywords_specificity,corp_trademark_keywords_switch,corp_trademark_keywords_max,corp_trademark_keywords_nulls,corp_trademark_logo_specificity,corp_trademark_logo_switch,corp_trademark_logo_max,corp_trademark_logo_nulls,corp_trademark_name_expiration_date_specificity,corp_trademark_name_expiration_date_switch,corp_trademark_name_expiration_date_max,corp_trademark_name_expiration_date_nulls,corp_trademark_nbr_specificity,corp_trademark_nbr_switch,corp_trademark_nbr_max,corp_trademark_nbr_nulls,corp_trademark_renewal_date_specificity,corp_trademark_renewal_date_switch,corp_trademark_renewal_date_max,corp_trademark_renewal_date_nulls,corp_trademark_status_specificity,corp_trademark_status_switch,corp_trademark_status_max,corp_trademark_status_nulls,corp_trademark_used_1_specificity,corp_trademark_used_1_switch,corp_trademark_used_1_max,corp_trademark_used_1_nulls,corp_trademark_used_2_specificity,corp_trademark_used_2_switch,corp_trademark_used_2_max,corp_trademark_used_2_nulls,corp_trademark_used_3_specificity,corp_trademark_used_3_switch,corp_trademark_used_3_max,corp_trademark_used_3_nulls,cont_owner_percentage_specificity,cont_owner_percentage_switch,cont_owner_percentage_max,cont_owner_percentage_nulls,cont_country_specificity,cont_country_switch,cont_country_max,cont_country_nulls,cont_country_mailing_specificity,cont_country_mailing_switch,cont_country_mailing_max,cont_country_mailing_nulls,cont_nondislosure_specificity,cont_nondislosure_switch,cont_nondislosure_max,cont_nondislosure_nulls,cont_prep_addr_line1_specificity,cont_prep_addr_line1_switch,cont_prep_addr_line1_max,cont_prep_addr_line1_nulls,cont_prep_addr_last_line_specificity,cont_prep_addr_last_line_switch,cont_prep_addr_last_line_max,cont_prep_addr_last_line_nulls,recordorigin_specificity,recordorigin_switch,recordorigin_max,recordorigin_nulls}],Layout_Specificities.R) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::Specificities',EXPIRE(Config.PersistExpire));
EXPORT Specificities := iSpecificities;
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 dt_vendor_first_reported_shift0 := ROUND(Specificities[1].dt_vendor_first_reported_year_specificity+Specificities[1].dt_vendor_first_reported_month_specificity+Specificities[1].dt_vendor_first_reported_day_specificity - 0);
// Not sure what to do amount a DATE switch yet - MAX of all? 
  integer1 dt_vendor_last_reported_shift0 := ROUND(Specificities[1].dt_vendor_last_reported_year_specificity+Specificities[1].dt_vendor_last_reported_month_specificity+Specificities[1].dt_vendor_last_reported_day_specificity - 0);
// Not sure what to do amount a DATE switch yet - MAX of all? 
  integer1 dt_first_seen_shift0 := ROUND(Specificities[1].dt_first_seen_year_specificity+Specificities[1].dt_first_seen_month_specificity+Specificities[1].dt_first_seen_day_specificity - 0);
// Not sure what to do amount a DATE switch yet - MAX of all? 
  integer1 dt_last_seen_shift0 := ROUND(Specificities[1].dt_last_seen_year_specificity+Specificities[1].dt_last_seen_month_specificity+Specificities[1].dt_last_seen_day_specificity - 0);
// Not sure what to do amount a DATE switch yet - MAX of all? 
  integer1 corp_ra_dt_first_seen_shift0 := ROUND(Specificities[1].corp_ra_dt_first_seen_year_specificity+Specificities[1].corp_ra_dt_first_seen_month_specificity+Specificities[1].corp_ra_dt_first_seen_day_specificity - 0);
// Not sure what to do amount a DATE switch yet - MAX of all? 
  integer1 corp_ra_dt_last_seen_shift0 := ROUND(Specificities[1].corp_ra_dt_last_seen_year_specificity+Specificities[1].corp_ra_dt_last_seen_month_specificity+Specificities[1].corp_ra_dt_last_seen_day_specificity - 0);
// Not sure what to do amount a DATE switch yet - MAX of all? 
  integer1 corp_key_shift0 := ROUND(Specificities[1].corp_key_specificity - 0);
  integer2 corp_key_switch_shift0 := ROUND(1000*Specificities[1].corp_key_switch - 0);
  integer1 corp_supp_key_shift0 := ROUND(Specificities[1].corp_supp_key_specificity - 0);
  integer2 corp_supp_key_switch_shift0 := ROUND(1000*Specificities[1].corp_supp_key_switch - 0);
  integer1 corp_vendor_shift0 := ROUND(Specificities[1].corp_vendor_specificity - 0);
  integer2 corp_vendor_switch_shift0 := ROUND(1000*Specificities[1].corp_vendor_switch - 0);
  integer1 corp_vendor_county_shift0 := ROUND(Specificities[1].corp_vendor_county_specificity - 0);
  integer2 corp_vendor_county_switch_shift0 := ROUND(1000*Specificities[1].corp_vendor_county_switch - 0);
  integer1 corp_vendor_subcode_shift0 := ROUND(Specificities[1].corp_vendor_subcode_specificity - 0);
  integer2 corp_vendor_subcode_switch_shift0 := ROUND(1000*Specificities[1].corp_vendor_subcode_switch - 0);
  integer1 corp_state_origin_shift0 := ROUND(Specificities[1].corp_state_origin_specificity - 0);
  integer2 corp_state_origin_switch_shift0 := ROUND(1000*Specificities[1].corp_state_origin_switch - 0);
  integer1 corp_process_date_shift0 := ROUND(Specificities[1].corp_process_date_year_specificity+Specificities[1].corp_process_date_month_specificity+Specificities[1].corp_process_date_day_specificity - 0);
// Not sure what to do amount a DATE switch yet - MAX of all? 
  integer1 corp_orig_sos_charter_nbr_shift0 := ROUND(Specificities[1].corp_orig_sos_charter_nbr_specificity - 0);
  integer2 corp_orig_sos_charter_nbr_switch_shift0 := ROUND(1000*Specificities[1].corp_orig_sos_charter_nbr_switch - 0);
  integer1 corp_legal_name_shift0 := ROUND(Specificities[1].corp_legal_name_specificity - 0);
  integer2 corp_legal_name_switch_shift0 := ROUND(1000*Specificities[1].corp_legal_name_switch - 0);
  integer1 corp_ln_name_type_cd_shift0 := ROUND(Specificities[1].corp_ln_name_type_cd_specificity - 0);
  integer2 corp_ln_name_type_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_ln_name_type_cd_switch - 0);
  integer1 corp_ln_name_type_desc_shift0 := ROUND(Specificities[1].corp_ln_name_type_desc_specificity - 0);
  integer2 corp_ln_name_type_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_ln_name_type_desc_switch - 0);
  integer1 corp_supp_nbr_shift0 := ROUND(Specificities[1].corp_supp_nbr_specificity - 0);
  integer2 corp_supp_nbr_switch_shift0 := ROUND(1000*Specificities[1].corp_supp_nbr_switch - 0);
  integer1 corp_name_comment_shift0 := ROUND(Specificities[1].corp_name_comment_specificity - 0);
  integer2 corp_name_comment_switch_shift0 := ROUND(1000*Specificities[1].corp_name_comment_switch - 0);
  integer1 corp_address1_type_cd_shift0 := ROUND(Specificities[1].corp_address1_type_cd_specificity - 0);
  integer2 corp_address1_type_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_address1_type_cd_switch - 0);
  integer1 corp_address1_type_desc_shift0 := ROUND(Specificities[1].corp_address1_type_desc_specificity - 0);
  integer2 corp_address1_type_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_address1_type_desc_switch - 0);
  integer1 corp_address1_line1_shift0 := ROUND(Specificities[1].corp_address1_line1_specificity - 0);
  integer2 corp_address1_line1_switch_shift0 := ROUND(1000*Specificities[1].corp_address1_line1_switch - 0);
  integer1 corp_address1_line2_shift0 := ROUND(Specificities[1].corp_address1_line2_specificity - 0);
  integer2 corp_address1_line2_switch_shift0 := ROUND(1000*Specificities[1].corp_address1_line2_switch - 0);
  integer1 corp_address1_line3_shift0 := ROUND(Specificities[1].corp_address1_line3_specificity - 0);
  integer2 corp_address1_line3_switch_shift0 := ROUND(1000*Specificities[1].corp_address1_line3_switch - 0);
  integer1 corp_address1_effective_date_shift0 := ROUND(Specificities[1].corp_address1_effective_date_specificity - 0);
  integer2 corp_address1_effective_date_switch_shift0 := ROUND(1000*Specificities[1].corp_address1_effective_date_switch - 0);
  integer1 corp_address2_type_cd_shift0 := ROUND(Specificities[1].corp_address2_type_cd_specificity - 0);
  integer2 corp_address2_type_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_address2_type_cd_switch - 0);
  integer1 corp_address2_type_desc_shift0 := ROUND(Specificities[1].corp_address2_type_desc_specificity - 0);
  integer2 corp_address2_type_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_address2_type_desc_switch - 0);
  integer1 corp_address2_line1_shift0 := ROUND(Specificities[1].corp_address2_line1_specificity - 0);
  integer2 corp_address2_line1_switch_shift0 := ROUND(1000*Specificities[1].corp_address2_line1_switch - 0);
  integer1 corp_address2_line2_shift0 := ROUND(Specificities[1].corp_address2_line2_specificity - 0);
  integer2 corp_address2_line2_switch_shift0 := ROUND(1000*Specificities[1].corp_address2_line2_switch - 0);
  integer1 corp_address2_line3_shift0 := ROUND(Specificities[1].corp_address2_line3_specificity - 0);
  integer2 corp_address2_line3_switch_shift0 := ROUND(1000*Specificities[1].corp_address2_line3_switch - 0);
  integer1 corp_address2_effective_date_shift0 := ROUND(Specificities[1].corp_address2_effective_date_specificity - 0);
  integer2 corp_address2_effective_date_switch_shift0 := ROUND(1000*Specificities[1].corp_address2_effective_date_switch - 0);
  integer1 corp_phone_number_shift0 := ROUND(Specificities[1].corp_phone_number_specificity - 0);
  integer2 corp_phone_number_switch_shift0 := ROUND(1000*Specificities[1].corp_phone_number_switch - 0);
  integer1 corp_phone_number_type_cd_shift0 := ROUND(Specificities[1].corp_phone_number_type_cd_specificity - 0);
  integer2 corp_phone_number_type_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_phone_number_type_cd_switch - 0);
  integer1 corp_phone_number_type_desc_shift0 := ROUND(Specificities[1].corp_phone_number_type_desc_specificity - 0);
  integer2 corp_phone_number_type_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_phone_number_type_desc_switch - 0);
  integer1 corp_fax_nbr_shift0 := ROUND(Specificities[1].corp_fax_nbr_specificity - 0);
  integer2 corp_fax_nbr_switch_shift0 := ROUND(1000*Specificities[1].corp_fax_nbr_switch - 0);
  integer1 corp_email_address_shift0 := ROUND(Specificities[1].corp_email_address_specificity - 0);
  integer2 corp_email_address_switch_shift0 := ROUND(1000*Specificities[1].corp_email_address_switch - 0);
  integer1 corp_web_address_shift0 := ROUND(Specificities[1].corp_web_address_specificity - 0);
  integer2 corp_web_address_switch_shift0 := ROUND(1000*Specificities[1].corp_web_address_switch - 0);
  integer1 corp_filing_reference_nbr_shift0 := ROUND(Specificities[1].corp_filing_reference_nbr_specificity - 0);
  integer2 corp_filing_reference_nbr_switch_shift0 := ROUND(1000*Specificities[1].corp_filing_reference_nbr_switch - 0);
  integer1 corp_filing_date_shift0 := ROUND(Specificities[1].corp_filing_date_specificity - 0);
  integer2 corp_filing_date_switch_shift0 := ROUND(1000*Specificities[1].corp_filing_date_switch - 0);
  integer1 corp_filing_cd_shift0 := ROUND(Specificities[1].corp_filing_cd_specificity - 0);
  integer2 corp_filing_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_filing_cd_switch - 0);
  integer1 corp_filing_desc_shift0 := ROUND(Specificities[1].corp_filing_desc_specificity - 0);
  integer2 corp_filing_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_filing_desc_switch - 0);
  integer1 corp_status_cd_shift0 := ROUND(Specificities[1].corp_status_cd_specificity - 0);
  integer2 corp_status_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_status_cd_switch - 0);
  integer1 corp_status_desc_shift0 := ROUND(Specificities[1].corp_status_desc_specificity - 0);
  integer2 corp_status_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_status_desc_switch - 0);
  integer1 corp_status_date_shift0 := ROUND(Specificities[1].corp_status_date_specificity - 0);
  integer2 corp_status_date_switch_shift0 := ROUND(1000*Specificities[1].corp_status_date_switch - 0);
  integer1 corp_standing_shift0 := ROUND(Specificities[1].corp_standing_specificity - 0);
  integer2 corp_standing_switch_shift0 := ROUND(1000*Specificities[1].corp_standing_switch - 0);
  integer1 corp_status_comment_shift0 := ROUND(Specificities[1].corp_status_comment_specificity - 0);
  integer2 corp_status_comment_switch_shift0 := ROUND(1000*Specificities[1].corp_status_comment_switch - 0);
  integer1 corp_ticker_symbol_shift0 := ROUND(Specificities[1].corp_ticker_symbol_specificity - 0);
  integer2 corp_ticker_symbol_switch_shift0 := ROUND(1000*Specificities[1].corp_ticker_symbol_switch - 0);
  integer1 corp_stock_exchange_shift0 := ROUND(Specificities[1].corp_stock_exchange_specificity - 0);
  integer2 corp_stock_exchange_switch_shift0 := ROUND(1000*Specificities[1].corp_stock_exchange_switch - 0);
  integer1 corp_inc_state_shift0 := ROUND(Specificities[1].corp_inc_state_specificity - 0);
  integer2 corp_inc_state_switch_shift0 := ROUND(1000*Specificities[1].corp_inc_state_switch - 0);
  integer1 corp_inc_county_shift0 := ROUND(Specificities[1].corp_inc_county_specificity - 0);
  integer2 corp_inc_county_switch_shift0 := ROUND(1000*Specificities[1].corp_inc_county_switch - 0);
  integer1 corp_inc_date_shift0 := ROUND(Specificities[1].corp_inc_date_specificity - 0);
  integer2 corp_inc_date_switch_shift0 := ROUND(1000*Specificities[1].corp_inc_date_switch - 0);
  integer1 corp_anniversary_month_shift0 := ROUND(Specificities[1].corp_anniversary_month_specificity - 0);
  integer2 corp_anniversary_month_switch_shift0 := ROUND(1000*Specificities[1].corp_anniversary_month_switch - 0);
  integer1 corp_fed_tax_id_shift0 := ROUND(Specificities[1].corp_fed_tax_id_specificity - 0);
  integer2 corp_fed_tax_id_switch_shift0 := ROUND(1000*Specificities[1].corp_fed_tax_id_switch - 0);
  integer1 corp_state_tax_id_shift0 := ROUND(Specificities[1].corp_state_tax_id_specificity - 0);
  integer2 corp_state_tax_id_switch_shift0 := ROUND(1000*Specificities[1].corp_state_tax_id_switch - 0);
  integer1 corp_term_exist_cd_shift0 := ROUND(Specificities[1].corp_term_exist_cd_specificity - 0);
  integer2 corp_term_exist_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_term_exist_cd_switch - 0);
  integer1 corp_term_exist_exp_shift0 := ROUND(Specificities[1].corp_term_exist_exp_specificity - 0);
  integer2 corp_term_exist_exp_switch_shift0 := ROUND(1000*Specificities[1].corp_term_exist_exp_switch - 0);
  integer1 corp_term_exist_desc_shift0 := ROUND(Specificities[1].corp_term_exist_desc_specificity - 0);
  integer2 corp_term_exist_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_term_exist_desc_switch - 0);
  integer1 corp_foreign_domestic_ind_shift0 := ROUND(Specificities[1].corp_foreign_domestic_ind_specificity - 0);
  integer2 corp_foreign_domestic_ind_switch_shift0 := ROUND(1000*Specificities[1].corp_foreign_domestic_ind_switch - 0);
  integer1 corp_forgn_state_cd_shift0 := ROUND(Specificities[1].corp_forgn_state_cd_specificity - 0);
  integer2 corp_forgn_state_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_forgn_state_cd_switch - 0);
  integer1 corp_forgn_state_desc_shift0 := ROUND(Specificities[1].corp_forgn_state_desc_specificity - 0);
  integer2 corp_forgn_state_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_forgn_state_desc_switch - 0);
  integer1 corp_forgn_sos_charter_nbr_shift0 := ROUND(Specificities[1].corp_forgn_sos_charter_nbr_specificity - 0);
  integer2 corp_forgn_sos_charter_nbr_switch_shift0 := ROUND(1000*Specificities[1].corp_forgn_sos_charter_nbr_switch - 0);
  integer1 corp_forgn_date_shift0 := ROUND(Specificities[1].corp_forgn_date_specificity - 0);
  integer2 corp_forgn_date_switch_shift0 := ROUND(1000*Specificities[1].corp_forgn_date_switch - 0);
  integer1 corp_forgn_fed_tax_id_shift0 := ROUND(Specificities[1].corp_forgn_fed_tax_id_specificity - 0);
  integer2 corp_forgn_fed_tax_id_switch_shift0 := ROUND(1000*Specificities[1].corp_forgn_fed_tax_id_switch - 0);
  integer1 corp_forgn_state_tax_id_shift0 := ROUND(Specificities[1].corp_forgn_state_tax_id_specificity - 0);
  integer2 corp_forgn_state_tax_id_switch_shift0 := ROUND(1000*Specificities[1].corp_forgn_state_tax_id_switch - 0);
  integer1 corp_forgn_term_exist_cd_shift0 := ROUND(Specificities[1].corp_forgn_term_exist_cd_specificity - 0);
  integer2 corp_forgn_term_exist_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_forgn_term_exist_cd_switch - 0);
  integer1 corp_forgn_term_exist_exp_shift0 := ROUND(Specificities[1].corp_forgn_term_exist_exp_specificity - 0);
  integer2 corp_forgn_term_exist_exp_switch_shift0 := ROUND(1000*Specificities[1].corp_forgn_term_exist_exp_switch - 0);
  integer1 corp_forgn_term_exist_desc_shift0 := ROUND(Specificities[1].corp_forgn_term_exist_desc_specificity - 0);
  integer2 corp_forgn_term_exist_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_forgn_term_exist_desc_switch - 0);
  integer1 corp_orig_org_structure_cd_shift0 := ROUND(Specificities[1].corp_orig_org_structure_cd_specificity - 0);
  integer2 corp_orig_org_structure_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_orig_org_structure_cd_switch - 0);
  integer1 corp_orig_org_structure_desc_shift0 := ROUND(Specificities[1].corp_orig_org_structure_desc_specificity - 0);
  integer2 corp_orig_org_structure_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_orig_org_structure_desc_switch - 0);
  integer1 corp_for_profit_ind_shift0 := ROUND(Specificities[1].corp_for_profit_ind_specificity - 0);
  integer2 corp_for_profit_ind_switch_shift0 := ROUND(1000*Specificities[1].corp_for_profit_ind_switch - 0);
  integer1 corp_public_or_private_ind_shift0 := ROUND(Specificities[1].corp_public_or_private_ind_specificity - 0);
  integer2 corp_public_or_private_ind_switch_shift0 := ROUND(1000*Specificities[1].corp_public_or_private_ind_switch - 0);
  integer1 corp_sic_code_shift0 := ROUND(Specificities[1].corp_sic_code_specificity - 0);
  integer2 corp_sic_code_switch_shift0 := ROUND(1000*Specificities[1].corp_sic_code_switch - 0);
  integer1 corp_naic_code_shift0 := ROUND(Specificities[1].corp_naic_code_specificity - 0);
  integer2 corp_naic_code_switch_shift0 := ROUND(1000*Specificities[1].corp_naic_code_switch - 0);
  integer1 corp_orig_bus_type_cd_shift0 := ROUND(Specificities[1].corp_orig_bus_type_cd_specificity - 0);
  integer2 corp_orig_bus_type_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_orig_bus_type_cd_switch - 0);
  integer1 corp_orig_bus_type_desc_shift0 := ROUND(Specificities[1].corp_orig_bus_type_desc_specificity - 0);
  integer2 corp_orig_bus_type_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_orig_bus_type_desc_switch - 0);
  integer1 corp_entity_desc_shift0 := ROUND(Specificities[1].corp_entity_desc_specificity - 0);
  integer2 corp_entity_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_entity_desc_switch - 0);
  integer1 corp_certificate_nbr_shift0 := ROUND(Specificities[1].corp_certificate_nbr_specificity - 0);
  integer2 corp_certificate_nbr_switch_shift0 := ROUND(1000*Specificities[1].corp_certificate_nbr_switch - 0);
  integer1 corp_internal_nbr_shift0 := ROUND(Specificities[1].corp_internal_nbr_specificity - 0);
  integer2 corp_internal_nbr_switch_shift0 := ROUND(1000*Specificities[1].corp_internal_nbr_switch - 0);
  integer1 corp_previous_nbr_shift0 := ROUND(Specificities[1].corp_previous_nbr_specificity - 0);
  integer2 corp_previous_nbr_switch_shift0 := ROUND(1000*Specificities[1].corp_previous_nbr_switch - 0);
  integer1 corp_microfilm_nbr_shift0 := ROUND(Specificities[1].corp_microfilm_nbr_specificity - 0);
  integer2 corp_microfilm_nbr_switch_shift0 := ROUND(1000*Specificities[1].corp_microfilm_nbr_switch - 0);
  integer1 corp_amendments_filed_shift0 := ROUND(Specificities[1].corp_amendments_filed_specificity - 0);
  integer2 corp_amendments_filed_switch_shift0 := ROUND(1000*Specificities[1].corp_amendments_filed_switch - 0);
  integer1 corp_acts_shift0 := ROUND(Specificities[1].corp_acts_specificity - 0);
  integer2 corp_acts_switch_shift0 := ROUND(1000*Specificities[1].corp_acts_switch - 0);
  integer1 corp_partnership_ind_shift0 := ROUND(Specificities[1].corp_partnership_ind_specificity - 0);
  integer2 corp_partnership_ind_switch_shift0 := ROUND(1000*Specificities[1].corp_partnership_ind_switch - 0);
  integer1 corp_mfg_ind_shift0 := ROUND(Specificities[1].corp_mfg_ind_specificity - 0);
  integer2 corp_mfg_ind_switch_shift0 := ROUND(1000*Specificities[1].corp_mfg_ind_switch - 0);
  integer1 corp_addl_info_shift0 := ROUND(Specificities[1].corp_addl_info_specificity - 0);
  integer2 corp_addl_info_switch_shift0 := ROUND(1000*Specificities[1].corp_addl_info_switch - 0);
  integer1 corp_taxes_shift0 := ROUND(Specificities[1].corp_taxes_specificity - 0);
  integer2 corp_taxes_switch_shift0 := ROUND(1000*Specificities[1].corp_taxes_switch - 0);
  integer1 corp_franchise_taxes_shift0 := ROUND(Specificities[1].corp_franchise_taxes_specificity - 0);
  integer2 corp_franchise_taxes_switch_shift0 := ROUND(1000*Specificities[1].corp_franchise_taxes_switch - 0);
  integer1 corp_tax_program_cd_shift0 := ROUND(Specificities[1].corp_tax_program_cd_specificity - 0);
  integer2 corp_tax_program_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_tax_program_cd_switch - 0);
  integer1 corp_tax_program_desc_shift0 := ROUND(Specificities[1].corp_tax_program_desc_specificity - 0);
  integer2 corp_tax_program_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_tax_program_desc_switch - 0);
  integer1 corp_ra_full_name_shift0 := ROUND(Specificities[1].corp_ra_full_name_specificity - 0);
  integer2 corp_ra_full_name_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_full_name_switch - 0);
  integer1 corp_ra_fname_shift0 := ROUND(Specificities[1].corp_ra_fname_specificity - 0);
  integer2 corp_ra_fname_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_fname_switch - 0);
  integer1 corp_ra_mname_shift0 := ROUND(Specificities[1].corp_ra_mname_specificity - 0);
  integer2 corp_ra_mname_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_mname_switch - 0);
  integer1 corp_ra_lname_shift0 := ROUND(Specificities[1].corp_ra_lname_specificity - 0);
  integer2 corp_ra_lname_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_lname_switch - 0);
  integer1 corp_ra_suffix_shift0 := ROUND(Specificities[1].corp_ra_suffix_specificity - 0);
  integer2 corp_ra_suffix_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_suffix_switch - 0);
  integer1 corp_ra_title_cd_shift0 := ROUND(Specificities[1].corp_ra_title_cd_specificity - 0);
  integer2 corp_ra_title_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_title_cd_switch - 0);
  integer1 corp_ra_title_desc_shift0 := ROUND(Specificities[1].corp_ra_title_desc_specificity - 0);
  integer2 corp_ra_title_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_title_desc_switch - 0);
  integer1 corp_ra_fein_shift0 := ROUND(Specificities[1].corp_ra_fein_specificity - 0);
  integer2 corp_ra_fein_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_fein_switch - 0);
  integer1 corp_ra_ssn_shift0 := ROUND(Specificities[1].corp_ra_ssn_specificity - 0);
  integer2 corp_ra_ssn_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_ssn_switch - 0);
  integer1 corp_ra_dob_shift0 := ROUND(Specificities[1].corp_ra_dob_specificity - 0);
  integer2 corp_ra_dob_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_dob_switch - 0);
  integer1 corp_ra_effective_date_shift0 := ROUND(Specificities[1].corp_ra_effective_date_specificity - 0);
  integer2 corp_ra_effective_date_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_effective_date_switch - 0);
  integer1 corp_ra_resign_date_shift0 := ROUND(Specificities[1].corp_ra_resign_date_specificity - 0);
  integer2 corp_ra_resign_date_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_resign_date_switch - 0);
  integer1 corp_ra_no_comp_shift0 := ROUND(Specificities[1].corp_ra_no_comp_specificity - 0);
  integer2 corp_ra_no_comp_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_no_comp_switch - 0);
  integer1 corp_ra_no_comp_igs_shift0 := ROUND(Specificities[1].corp_ra_no_comp_igs_specificity - 0);
  integer2 corp_ra_no_comp_igs_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_no_comp_igs_switch - 0);
  integer1 corp_ra_addl_info_shift0 := ROUND(Specificities[1].corp_ra_addl_info_specificity - 0);
  integer2 corp_ra_addl_info_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_addl_info_switch - 0);
  integer1 corp_ra_address_type_cd_shift0 := ROUND(Specificities[1].corp_ra_address_type_cd_specificity - 0);
  integer2 corp_ra_address_type_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_address_type_cd_switch - 0);
  integer1 corp_ra_address_type_desc_shift0 := ROUND(Specificities[1].corp_ra_address_type_desc_specificity - 0);
  integer2 corp_ra_address_type_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_address_type_desc_switch - 0);
  integer1 corp_ra_address_line1_shift0 := ROUND(Specificities[1].corp_ra_address_line1_specificity - 0);
  integer2 corp_ra_address_line1_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_address_line1_switch - 0);
  integer1 corp_ra_address_line2_shift0 := ROUND(Specificities[1].corp_ra_address_line2_specificity - 0);
  integer2 corp_ra_address_line2_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_address_line2_switch - 0);
  integer1 corp_ra_address_line3_shift0 := ROUND(Specificities[1].corp_ra_address_line3_specificity - 0);
  integer2 corp_ra_address_line3_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_address_line3_switch - 0);
  integer1 corp_ra_phone_number_shift0 := ROUND(Specificities[1].corp_ra_phone_number_specificity - 0);
  integer2 corp_ra_phone_number_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_phone_number_switch - 0);
  integer1 corp_ra_phone_number_type_cd_shift0 := ROUND(Specificities[1].corp_ra_phone_number_type_cd_specificity - 0);
  integer2 corp_ra_phone_number_type_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_phone_number_type_cd_switch - 0);
  integer1 corp_ra_phone_number_type_desc_shift0 := ROUND(Specificities[1].corp_ra_phone_number_type_desc_specificity - 0);
  integer2 corp_ra_phone_number_type_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_phone_number_type_desc_switch - 0);
  integer1 corp_ra_fax_nbr_shift0 := ROUND(Specificities[1].corp_ra_fax_nbr_specificity - 0);
  integer2 corp_ra_fax_nbr_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_fax_nbr_switch - 0);
  integer1 corp_ra_email_address_shift0 := ROUND(Specificities[1].corp_ra_email_address_specificity - 0);
  integer2 corp_ra_email_address_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_email_address_switch - 0);
  integer1 corp_ra_web_address_shift0 := ROUND(Specificities[1].corp_ra_web_address_specificity - 0);
  integer2 corp_ra_web_address_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_web_address_switch - 0);
  integer1 corp_prep_addr1_line1_shift0 := ROUND(Specificities[1].corp_prep_addr1_line1_specificity - 0);
  integer2 corp_prep_addr1_line1_switch_shift0 := ROUND(1000*Specificities[1].corp_prep_addr1_line1_switch - 0);
  integer1 corp_prep_addr1_last_line_shift0 := ROUND(Specificities[1].corp_prep_addr1_last_line_specificity - 0);
  integer2 corp_prep_addr1_last_line_switch_shift0 := ROUND(1000*Specificities[1].corp_prep_addr1_last_line_switch - 0);
  integer1 corp_prep_addr2_line1_shift0 := ROUND(Specificities[1].corp_prep_addr2_line1_specificity - 0);
  integer2 corp_prep_addr2_line1_switch_shift0 := ROUND(1000*Specificities[1].corp_prep_addr2_line1_switch - 0);
  integer1 corp_prep_addr2_last_line_shift0 := ROUND(Specificities[1].corp_prep_addr2_last_line_specificity - 0);
  integer2 corp_prep_addr2_last_line_switch_shift0 := ROUND(1000*Specificities[1].corp_prep_addr2_last_line_switch - 0);
  integer1 ra_prep_addr_line1_shift0 := ROUND(Specificities[1].ra_prep_addr_line1_specificity - 0);
  integer2 ra_prep_addr_line1_switch_shift0 := ROUND(1000*Specificities[1].ra_prep_addr_line1_switch - 0);
  integer1 ra_prep_addr_last_line_shift0 := ROUND(Specificities[1].ra_prep_addr_last_line_specificity - 0);
  integer2 ra_prep_addr_last_line_switch_shift0 := ROUND(1000*Specificities[1].ra_prep_addr_last_line_switch - 0);
  integer1 cont_filing_reference_nbr_shift0 := ROUND(Specificities[1].cont_filing_reference_nbr_specificity - 0);
  integer2 cont_filing_reference_nbr_switch_shift0 := ROUND(1000*Specificities[1].cont_filing_reference_nbr_switch - 0);
  integer1 cont_filing_date_shift0 := ROUND(Specificities[1].cont_filing_date_specificity - 0);
  integer2 cont_filing_date_switch_shift0 := ROUND(1000*Specificities[1].cont_filing_date_switch - 0);
  integer1 cont_filing_cd_shift0 := ROUND(Specificities[1].cont_filing_cd_specificity - 0);
  integer2 cont_filing_cd_switch_shift0 := ROUND(1000*Specificities[1].cont_filing_cd_switch - 0);
  integer1 cont_filing_desc_shift0 := ROUND(Specificities[1].cont_filing_desc_specificity - 0);
  integer2 cont_filing_desc_switch_shift0 := ROUND(1000*Specificities[1].cont_filing_desc_switch - 0);
  integer1 cont_type_cd_shift0 := ROUND(Specificities[1].cont_type_cd_specificity - 0);
  integer2 cont_type_cd_switch_shift0 := ROUND(1000*Specificities[1].cont_type_cd_switch - 0);
  integer1 cont_type_desc_shift0 := ROUND(Specificities[1].cont_type_desc_specificity - 0);
  integer2 cont_type_desc_switch_shift0 := ROUND(1000*Specificities[1].cont_type_desc_switch - 0);
  integer1 cont_full_name_shift0 := ROUND(Specificities[1].cont_full_name_specificity - 0);
  integer2 cont_full_name_switch_shift0 := ROUND(1000*Specificities[1].cont_full_name_switch - 0);
  integer1 cont_fname_shift0 := ROUND(Specificities[1].cont_fname_specificity - 0);
  integer2 cont_fname_switch_shift0 := ROUND(1000*Specificities[1].cont_fname_switch - 0);
  integer1 cont_mname_shift0 := ROUND(Specificities[1].cont_mname_specificity - 0);
  integer2 cont_mname_switch_shift0 := ROUND(1000*Specificities[1].cont_mname_switch - 0);
  integer1 cont_lname_shift0 := ROUND(Specificities[1].cont_lname_specificity - 0);
  integer2 cont_lname_switch_shift0 := ROUND(1000*Specificities[1].cont_lname_switch - 0);
  integer1 cont_suffix_shift0 := ROUND(Specificities[1].cont_suffix_specificity - 0);
  integer2 cont_suffix_switch_shift0 := ROUND(1000*Specificities[1].cont_suffix_switch - 0);
  integer1 cont_title1_desc_shift0 := ROUND(Specificities[1].cont_title1_desc_specificity - 0);
  integer2 cont_title1_desc_switch_shift0 := ROUND(1000*Specificities[1].cont_title1_desc_switch - 0);
  integer1 cont_title2_desc_shift0 := ROUND(Specificities[1].cont_title2_desc_specificity - 0);
  integer2 cont_title2_desc_switch_shift0 := ROUND(1000*Specificities[1].cont_title2_desc_switch - 0);
  integer1 cont_title3_desc_shift0 := ROUND(Specificities[1].cont_title3_desc_specificity - 0);
  integer2 cont_title3_desc_switch_shift0 := ROUND(1000*Specificities[1].cont_title3_desc_switch - 0);
  integer1 cont_title4_desc_shift0 := ROUND(Specificities[1].cont_title4_desc_specificity - 0);
  integer2 cont_title4_desc_switch_shift0 := ROUND(1000*Specificities[1].cont_title4_desc_switch - 0);
  integer1 cont_title5_desc_shift0 := ROUND(Specificities[1].cont_title5_desc_specificity - 0);
  integer2 cont_title5_desc_switch_shift0 := ROUND(1000*Specificities[1].cont_title5_desc_switch - 0);
  integer1 cont_fein_shift0 := ROUND(Specificities[1].cont_fein_specificity - 0);
  integer2 cont_fein_switch_shift0 := ROUND(1000*Specificities[1].cont_fein_switch - 0);
  integer1 cont_ssn_shift0 := ROUND(Specificities[1].cont_ssn_specificity - 0);
  integer2 cont_ssn_switch_shift0 := ROUND(1000*Specificities[1].cont_ssn_switch - 0);
  integer1 cont_dob_shift0 := ROUND(Specificities[1].cont_dob_specificity - 0);
  integer2 cont_dob_switch_shift0 := ROUND(1000*Specificities[1].cont_dob_switch - 0);
  integer1 cont_status_cd_shift0 := ROUND(Specificities[1].cont_status_cd_specificity - 0);
  integer2 cont_status_cd_switch_shift0 := ROUND(1000*Specificities[1].cont_status_cd_switch - 0);
  integer1 cont_status_desc_shift0 := ROUND(Specificities[1].cont_status_desc_specificity - 0);
  integer2 cont_status_desc_switch_shift0 := ROUND(1000*Specificities[1].cont_status_desc_switch - 0);
  integer1 cont_effective_date_shift0 := ROUND(Specificities[1].cont_effective_date_specificity - 0);
  integer2 cont_effective_date_switch_shift0 := ROUND(1000*Specificities[1].cont_effective_date_switch - 0);
  integer1 cont_effective_cd_shift0 := ROUND(Specificities[1].cont_effective_cd_specificity - 0);
  integer2 cont_effective_cd_switch_shift0 := ROUND(1000*Specificities[1].cont_effective_cd_switch - 0);
  integer1 cont_effective_desc_shift0 := ROUND(Specificities[1].cont_effective_desc_specificity - 0);
  integer2 cont_effective_desc_switch_shift0 := ROUND(1000*Specificities[1].cont_effective_desc_switch - 0);
  integer1 cont_addl_info_shift0 := ROUND(Specificities[1].cont_addl_info_specificity - 0);
  integer2 cont_addl_info_switch_shift0 := ROUND(1000*Specificities[1].cont_addl_info_switch - 0);
  integer1 cont_address_type_cd_shift0 := ROUND(Specificities[1].cont_address_type_cd_specificity - 0);
  integer2 cont_address_type_cd_switch_shift0 := ROUND(1000*Specificities[1].cont_address_type_cd_switch - 0);
  integer1 cont_address_type_desc_shift0 := ROUND(Specificities[1].cont_address_type_desc_specificity - 0);
  integer2 cont_address_type_desc_switch_shift0 := ROUND(1000*Specificities[1].cont_address_type_desc_switch - 0);
  integer1 cont_address_line1_shift0 := ROUND(Specificities[1].cont_address_line1_specificity - 0);
  integer2 cont_address_line1_switch_shift0 := ROUND(1000*Specificities[1].cont_address_line1_switch - 0);
  integer1 cont_address_line2_shift0 := ROUND(Specificities[1].cont_address_line2_specificity - 0);
  integer2 cont_address_line2_switch_shift0 := ROUND(1000*Specificities[1].cont_address_line2_switch - 0);
  integer1 cont_address_line3_shift0 := ROUND(Specificities[1].cont_address_line3_specificity - 0);
  integer2 cont_address_line3_switch_shift0 := ROUND(1000*Specificities[1].cont_address_line3_switch - 0);
  integer1 cont_address_effective_date_shift0 := ROUND(Specificities[1].cont_address_effective_date_specificity - 0);
  integer2 cont_address_effective_date_switch_shift0 := ROUND(1000*Specificities[1].cont_address_effective_date_switch - 0);
  integer1 cont_address_county_shift0 := ROUND(Specificities[1].cont_address_county_specificity - 0);
  integer2 cont_address_county_switch_shift0 := ROUND(1000*Specificities[1].cont_address_county_switch - 0);
  integer1 cont_phone_number_shift0 := ROUND(Specificities[1].cont_phone_number_specificity - 0);
  integer2 cont_phone_number_switch_shift0 := ROUND(1000*Specificities[1].cont_phone_number_switch - 0);
  integer1 cont_phone_number_type_cd_shift0 := ROUND(Specificities[1].cont_phone_number_type_cd_specificity - 0);
  integer2 cont_phone_number_type_cd_switch_shift0 := ROUND(1000*Specificities[1].cont_phone_number_type_cd_switch - 0);
  integer1 cont_phone_number_type_desc_shift0 := ROUND(Specificities[1].cont_phone_number_type_desc_specificity - 0);
  integer2 cont_phone_number_type_desc_switch_shift0 := ROUND(1000*Specificities[1].cont_phone_number_type_desc_switch - 0);
  integer1 cont_fax_nbr_shift0 := ROUND(Specificities[1].cont_fax_nbr_specificity - 0);
  integer2 cont_fax_nbr_switch_shift0 := ROUND(1000*Specificities[1].cont_fax_nbr_switch - 0);
  integer1 cont_email_address_shift0 := ROUND(Specificities[1].cont_email_address_specificity - 0);
  integer2 cont_email_address_switch_shift0 := ROUND(1000*Specificities[1].cont_email_address_switch - 0);
  integer1 cont_web_address_shift0 := ROUND(Specificities[1].cont_web_address_specificity - 0);
  integer2 cont_web_address_switch_shift0 := ROUND(1000*Specificities[1].cont_web_address_switch - 0);
  integer1 corp_acres_shift0 := ROUND(Specificities[1].corp_acres_specificity - 0);
  integer2 corp_acres_switch_shift0 := ROUND(1000*Specificities[1].corp_acres_switch - 0);
  integer1 corp_action_shift0 := ROUND(Specificities[1].corp_action_specificity - 0);
  integer2 corp_action_switch_shift0 := ROUND(1000*Specificities[1].corp_action_switch - 0);
  integer1 corp_action_date_shift0 := ROUND(Specificities[1].corp_action_date_specificity - 0);
  integer2 corp_action_date_switch_shift0 := ROUND(1000*Specificities[1].corp_action_date_switch - 0);
  integer1 corp_action_employment_security_approval_date_shift0 := ROUND(Specificities[1].corp_action_employment_security_approval_date_specificity - 0);
  integer2 corp_action_employment_security_approval_date_switch_shift0 := ROUND(1000*Specificities[1].corp_action_employment_security_approval_date_switch - 0);
  integer1 corp_action_pending_cd_shift0 := ROUND(Specificities[1].corp_action_pending_cd_specificity - 0);
  integer2 corp_action_pending_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_action_pending_cd_switch - 0);
  integer1 corp_action_pending_desc_shift0 := ROUND(Specificities[1].corp_action_pending_desc_specificity - 0);
  integer2 corp_action_pending_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_action_pending_desc_switch - 0);
  integer1 corp_action_statement_of_intent_date_shift0 := ROUND(Specificities[1].corp_action_statement_of_intent_date_specificity - 0);
  integer2 corp_action_statement_of_intent_date_switch_shift0 := ROUND(1000*Specificities[1].corp_action_statement_of_intent_date_switch - 0);
  integer1 corp_action_tax_dept_approval_date_shift0 := ROUND(Specificities[1].corp_action_tax_dept_approval_date_specificity - 0);
  integer2 corp_action_tax_dept_approval_date_switch_shift0 := ROUND(1000*Specificities[1].corp_action_tax_dept_approval_date_switch - 0);
  integer1 corp_acts2_shift0 := ROUND(Specificities[1].corp_acts2_specificity - 0);
  integer2 corp_acts2_switch_shift0 := ROUND(1000*Specificities[1].corp_acts2_switch - 0);
  integer1 corp_acts3_shift0 := ROUND(Specificities[1].corp_acts3_specificity - 0);
  integer2 corp_acts3_switch_shift0 := ROUND(1000*Specificities[1].corp_acts3_switch - 0);
  integer1 corp_additional_principals_shift0 := ROUND(Specificities[1].corp_additional_principals_specificity - 0);
  integer2 corp_additional_principals_switch_shift0 := ROUND(1000*Specificities[1].corp_additional_principals_switch - 0);
  integer1 corp_address_office_type_shift0 := ROUND(Specificities[1].corp_address_office_type_specificity - 0);
  integer2 corp_address_office_type_switch_shift0 := ROUND(1000*Specificities[1].corp_address_office_type_switch - 0);
  integer1 corp_agent_assign_date_shift0 := ROUND(Specificities[1].corp_agent_assign_date_specificity - 0);
  integer2 corp_agent_assign_date_switch_shift0 := ROUND(1000*Specificities[1].corp_agent_assign_date_switch - 0);
  integer1 corp_agent_commercial_shift0 := ROUND(Specificities[1].corp_agent_commercial_specificity - 0);
  integer2 corp_agent_commercial_switch_shift0 := ROUND(1000*Specificities[1].corp_agent_commercial_switch - 0);
  integer1 corp_agent_country_shift0 := ROUND(Specificities[1].corp_agent_country_specificity - 0);
  integer2 corp_agent_country_switch_shift0 := ROUND(1000*Specificities[1].corp_agent_country_switch - 0);
  integer1 corp_agent_county_shift0 := ROUND(Specificities[1].corp_agent_county_specificity - 0);
  integer2 corp_agent_county_switch_shift0 := ROUND(1000*Specificities[1].corp_agent_county_switch - 0);
  integer1 corp_agent_status_cd_shift0 := ROUND(Specificities[1].corp_agent_status_cd_specificity - 0);
  integer2 corp_agent_status_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_agent_status_cd_switch - 0);
  integer1 corp_agent_status_desc_shift0 := ROUND(Specificities[1].corp_agent_status_desc_specificity - 0);
  integer2 corp_agent_status_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_agent_status_desc_switch - 0);
  integer1 corp_agent_id_shift0 := ROUND(Specificities[1].corp_agent_id_specificity - 0);
  integer2 corp_agent_id_switch_shift0 := ROUND(1000*Specificities[1].corp_agent_id_switch - 0);
  integer1 corp_agriculture_flag_shift0 := ROUND(Specificities[1].corp_agriculture_flag_specificity - 0);
  integer2 corp_agriculture_flag_switch_shift0 := ROUND(1000*Specificities[1].corp_agriculture_flag_switch - 0);
  integer1 corp_authorized_partners_shift0 := ROUND(Specificities[1].corp_authorized_partners_specificity - 0);
  integer2 corp_authorized_partners_switch_shift0 := ROUND(1000*Specificities[1].corp_authorized_partners_switch - 0);
  integer1 corp_comment_shift0 := ROUND(Specificities[1].corp_comment_specificity - 0);
  integer2 corp_comment_switch_shift0 := ROUND(1000*Specificities[1].corp_comment_switch - 0);
  integer1 corp_consent_flag_for_protected_name_shift0 := ROUND(Specificities[1].corp_consent_flag_for_protected_name_specificity - 0);
  integer2 corp_consent_flag_for_protected_name_switch_shift0 := ROUND(1000*Specificities[1].corp_consent_flag_for_protected_name_switch - 0);
  integer1 corp_converted_shift0 := ROUND(Specificities[1].corp_converted_specificity - 0);
  integer2 corp_converted_switch_shift0 := ROUND(1000*Specificities[1].corp_converted_switch - 0);
  integer1 corp_converted_from_shift0 := ROUND(Specificities[1].corp_converted_from_specificity - 0);
  integer2 corp_converted_from_switch_shift0 := ROUND(1000*Specificities[1].corp_converted_from_switch - 0);
  integer1 corp_country_of_formation_shift0 := ROUND(Specificities[1].corp_country_of_formation_specificity - 0);
  integer2 corp_country_of_formation_switch_shift0 := ROUND(1000*Specificities[1].corp_country_of_formation_switch - 0);
  integer1 corp_date_of_organization_meeting_shift0 := ROUND(Specificities[1].corp_date_of_organization_meeting_specificity - 0);
  integer2 corp_date_of_organization_meeting_switch_shift0 := ROUND(1000*Specificities[1].corp_date_of_organization_meeting_switch - 0);
  integer1 corp_delayed_effective_date_shift0 := ROUND(Specificities[1].corp_delayed_effective_date_specificity - 0);
  integer2 corp_delayed_effective_date_switch_shift0 := ROUND(1000*Specificities[1].corp_delayed_effective_date_switch - 0);
  integer1 corp_directors_from_to_shift0 := ROUND(Specificities[1].corp_directors_from_to_specificity - 0);
  integer2 corp_directors_from_to_switch_shift0 := ROUND(1000*Specificities[1].corp_directors_from_to_switch - 0);
  integer1 corp_dissolved_date_shift0 := ROUND(Specificities[1].corp_dissolved_date_specificity - 0);
  integer2 corp_dissolved_date_switch_shift0 := ROUND(1000*Specificities[1].corp_dissolved_date_switch - 0);
  integer1 corp_farm_exemptions_shift0 := ROUND(Specificities[1].corp_farm_exemptions_specificity - 0);
  integer2 corp_farm_exemptions_switch_shift0 := ROUND(1000*Specificities[1].corp_farm_exemptions_switch - 0);
  integer1 corp_farm_qual_date_shift0 := ROUND(Specificities[1].corp_farm_qual_date_specificity - 0);
  integer2 corp_farm_qual_date_switch_shift0 := ROUND(1000*Specificities[1].corp_farm_qual_date_switch - 0);
  integer1 corp_farm_status_cd_shift0 := ROUND(Specificities[1].corp_farm_status_cd_specificity - 0);
  integer2 corp_farm_status_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_farm_status_cd_switch - 0);
  integer1 corp_farm_status_desc_shift0 := ROUND(Specificities[1].corp_farm_status_desc_specificity - 0);
  integer2 corp_farm_status_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_farm_status_desc_switch - 0);
  integer1 corp_fiscal_year_month_shift0 := ROUND(Specificities[1].corp_fiscal_year_month_specificity - 0);
  integer2 corp_fiscal_year_month_switch_shift0 := ROUND(1000*Specificities[1].corp_fiscal_year_month_switch - 0);
  integer1 corp_foreign_fiduciary_capacity_in_state_shift0 := ROUND(Specificities[1].corp_foreign_fiduciary_capacity_in_state_specificity - 0);
  integer2 corp_foreign_fiduciary_capacity_in_state_switch_shift0 := ROUND(1000*Specificities[1].corp_foreign_fiduciary_capacity_in_state_switch - 0);
  integer1 corp_governing_statute_shift0 := ROUND(Specificities[1].corp_governing_statute_specificity - 0);
  integer2 corp_governing_statute_switch_shift0 := ROUND(1000*Specificities[1].corp_governing_statute_switch - 0);
  integer1 corp_has_members_shift0 := ROUND(Specificities[1].corp_has_members_specificity - 0);
  integer2 corp_has_members_switch_shift0 := ROUND(1000*Specificities[1].corp_has_members_switch - 0);
  integer1 corp_has_vested_managers_shift0 := ROUND(Specificities[1].corp_has_vested_managers_specificity - 0);
  integer2 corp_has_vested_managers_switch_shift0 := ROUND(1000*Specificities[1].corp_has_vested_managers_switch - 0);
  integer1 corp_home_incorporated_county_shift0 := ROUND(Specificities[1].corp_home_incorporated_county_specificity - 0);
  integer2 corp_home_incorporated_county_switch_shift0 := ROUND(1000*Specificities[1].corp_home_incorporated_county_switch - 0);
  integer1 corp_home_state_name_shift0 := ROUND(Specificities[1].corp_home_state_name_specificity - 0);
  integer2 corp_home_state_name_switch_shift0 := ROUND(1000*Specificities[1].corp_home_state_name_switch - 0);
  integer1 corp_is_professional_shift0 := ROUND(Specificities[1].corp_is_professional_specificity - 0);
  integer2 corp_is_professional_switch_shift0 := ROUND(1000*Specificities[1].corp_is_professional_switch - 0);
  integer1 corp_is_non_profit_irs_approved_shift0 := ROUND(Specificities[1].corp_is_non_profit_irs_approved_specificity - 0);
  integer2 corp_is_non_profit_irs_approved_switch_shift0 := ROUND(1000*Specificities[1].corp_is_non_profit_irs_approved_switch - 0);
  integer1 corp_last_renewal_date_shift0 := ROUND(Specificities[1].corp_last_renewal_date_specificity - 0);
  integer2 corp_last_renewal_date_switch_shift0 := ROUND(1000*Specificities[1].corp_last_renewal_date_switch - 0);
  integer1 corp_last_renewal_year_shift0 := ROUND(Specificities[1].corp_last_renewal_year_specificity - 0);
  integer2 corp_last_renewal_year_switch_shift0 := ROUND(1000*Specificities[1].corp_last_renewal_year_switch - 0);
  integer1 corp_license_type_shift0 := ROUND(Specificities[1].corp_license_type_specificity - 0);
  integer2 corp_license_type_switch_shift0 := ROUND(1000*Specificities[1].corp_license_type_switch - 0);
  integer1 corp_llc_managed_desc_shift0 := ROUND(Specificities[1].corp_llc_managed_desc_specificity - 0);
  integer2 corp_llc_managed_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_llc_managed_desc_switch - 0);
  integer1 corp_llc_managed_ind_shift0 := ROUND(Specificities[1].corp_llc_managed_ind_specificity - 0);
  integer2 corp_llc_managed_ind_switch_shift0 := ROUND(1000*Specificities[1].corp_llc_managed_ind_switch - 0);
  integer1 corp_management_desc_shift0 := ROUND(Specificities[1].corp_management_desc_specificity - 0);
  integer2 corp_management_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_management_desc_switch - 0);
  integer1 corp_management_type_shift0 := ROUND(Specificities[1].corp_management_type_specificity - 0);
  integer2 corp_management_type_switch_shift0 := ROUND(1000*Specificities[1].corp_management_type_switch - 0);
  integer1 corp_manager_managed_shift0 := ROUND(Specificities[1].corp_manager_managed_specificity - 0);
  integer2 corp_manager_managed_switch_shift0 := ROUND(1000*Specificities[1].corp_manager_managed_switch - 0);
  integer1 corp_merged_corporation_id_shift0 := ROUND(Specificities[1].corp_merged_corporation_id_specificity - 0);
  integer2 corp_merged_corporation_id_switch_shift0 := ROUND(1000*Specificities[1].corp_merged_corporation_id_switch - 0);
  integer1 corp_merged_fein_shift0 := ROUND(Specificities[1].corp_merged_fein_specificity - 0);
  integer2 corp_merged_fein_switch_shift0 := ROUND(1000*Specificities[1].corp_merged_fein_switch - 0);
  integer1 corp_merger_allowed_flag_shift0 := ROUND(Specificities[1].corp_merger_allowed_flag_specificity - 0);
  integer2 corp_merger_allowed_flag_switch_shift0 := ROUND(1000*Specificities[1].corp_merger_allowed_flag_switch - 0);
  integer1 corp_merger_date_shift0 := ROUND(Specificities[1].corp_merger_date_specificity - 0);
  integer2 corp_merger_date_switch_shift0 := ROUND(1000*Specificities[1].corp_merger_date_switch - 0);
  integer1 corp_merger_desc_shift0 := ROUND(Specificities[1].corp_merger_desc_specificity - 0);
  integer2 corp_merger_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_merger_desc_switch - 0);
  integer1 corp_merger_effective_date_shift0 := ROUND(Specificities[1].corp_merger_effective_date_specificity - 0);
  integer2 corp_merger_effective_date_switch_shift0 := ROUND(1000*Specificities[1].corp_merger_effective_date_switch - 0);
  integer1 corp_merger_id_shift0 := ROUND(Specificities[1].corp_merger_id_specificity - 0);
  integer2 corp_merger_id_switch_shift0 := ROUND(1000*Specificities[1].corp_merger_id_switch - 0);
  integer1 corp_merger_indicator_shift0 := ROUND(Specificities[1].corp_merger_indicator_specificity - 0);
  integer2 corp_merger_indicator_switch_shift0 := ROUND(1000*Specificities[1].corp_merger_indicator_switch - 0);
  integer1 corp_merger_name_shift0 := ROUND(Specificities[1].corp_merger_name_specificity - 0);
  integer2 corp_merger_name_switch_shift0 := ROUND(1000*Specificities[1].corp_merger_name_switch - 0);
  integer1 corp_merger_type_converted_to_cd_shift0 := ROUND(Specificities[1].corp_merger_type_converted_to_cd_specificity - 0);
  integer2 corp_merger_type_converted_to_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_merger_type_converted_to_cd_switch - 0);
  integer1 corp_merger_type_converted_to_desc_shift0 := ROUND(Specificities[1].corp_merger_type_converted_to_desc_specificity - 0);
  integer2 corp_merger_type_converted_to_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_merger_type_converted_to_desc_switch - 0);
  integer1 corp_naics_desc_shift0 := ROUND(Specificities[1].corp_naics_desc_specificity - 0);
  integer2 corp_naics_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_naics_desc_switch - 0);
  integer1 corp_name_effective_date_shift0 := ROUND(Specificities[1].corp_name_effective_date_specificity - 0);
  integer2 corp_name_effective_date_switch_shift0 := ROUND(1000*Specificities[1].corp_name_effective_date_switch - 0);
  integer1 corp_name_reservation_date_shift0 := ROUND(Specificities[1].corp_name_reservation_date_specificity - 0);
  integer2 corp_name_reservation_date_switch_shift0 := ROUND(1000*Specificities[1].corp_name_reservation_date_switch - 0);
  integer1 corp_name_reservation_desc_shift0 := ROUND(Specificities[1].corp_name_reservation_desc_specificity - 0);
  integer2 corp_name_reservation_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_name_reservation_desc_switch - 0);
  integer1 corp_name_reservation_expiration_date_shift0 := ROUND(Specificities[1].corp_name_reservation_expiration_date_specificity - 0);
  integer2 corp_name_reservation_expiration_date_switch_shift0 := ROUND(1000*Specificities[1].corp_name_reservation_expiration_date_switch - 0);
  integer1 corp_name_reservation_nbr_shift0 := ROUND(Specificities[1].corp_name_reservation_nbr_specificity - 0);
  integer2 corp_name_reservation_nbr_switch_shift0 := ROUND(1000*Specificities[1].corp_name_reservation_nbr_switch - 0);
  integer1 corp_name_reservation_type_shift0 := ROUND(Specificities[1].corp_name_reservation_type_specificity - 0);
  integer2 corp_name_reservation_type_switch_shift0 := ROUND(1000*Specificities[1].corp_name_reservation_type_switch - 0);
  integer1 corp_name_status_cd_shift0 := ROUND(Specificities[1].corp_name_status_cd_specificity - 0);
  integer2 corp_name_status_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_name_status_cd_switch - 0);
  integer1 corp_name_status_date_shift0 := ROUND(Specificities[1].corp_name_status_date_specificity - 0);
  integer2 corp_name_status_date_switch_shift0 := ROUND(1000*Specificities[1].corp_name_status_date_switch - 0);
  integer1 corp_name_status_desc_shift0 := ROUND(Specificities[1].corp_name_status_desc_specificity - 0);
  integer2 corp_name_status_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_name_status_desc_switch - 0);
  integer1 corp_non_profit_irs_approved_purpose_shift0 := ROUND(Specificities[1].corp_non_profit_irs_approved_purpose_specificity - 0);
  integer2 corp_non_profit_irs_approved_purpose_switch_shift0 := ROUND(1000*Specificities[1].corp_non_profit_irs_approved_purpose_switch - 0);
  integer1 corp_non_profit_solicit_donations_shift0 := ROUND(Specificities[1].corp_non_profit_solicit_donations_specificity - 0);
  integer2 corp_non_profit_solicit_donations_switch_shift0 := ROUND(1000*Specificities[1].corp_non_profit_solicit_donations_switch - 0);
  integer1 corp_nbr_of_amendments_shift0 := ROUND(Specificities[1].corp_nbr_of_amendments_specificity - 0);
  integer2 corp_nbr_of_amendments_switch_shift0 := ROUND(1000*Specificities[1].corp_nbr_of_amendments_switch - 0);
  integer1 corp_nbr_of_initial_llc_members_shift0 := ROUND(Specificities[1].corp_nbr_of_initial_llc_members_specificity - 0);
  integer2 corp_nbr_of_initial_llc_members_switch_shift0 := ROUND(1000*Specificities[1].corp_nbr_of_initial_llc_members_switch - 0);
  integer1 corp_nbr_of_partners_shift0 := ROUND(Specificities[1].corp_nbr_of_partners_specificity - 0);
  integer2 corp_nbr_of_partners_switch_shift0 := ROUND(1000*Specificities[1].corp_nbr_of_partners_switch - 0);
  integer1 corp_operating_agreement_shift0 := ROUND(Specificities[1].corp_operating_agreement_specificity - 0);
  integer2 corp_operating_agreement_switch_shift0 := ROUND(1000*Specificities[1].corp_operating_agreement_switch - 0);
  integer1 corp_opt_in_llc_act_desc_shift0 := ROUND(Specificities[1].corp_opt_in_llc_act_desc_specificity - 0);
  integer2 corp_opt_in_llc_act_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_opt_in_llc_act_desc_switch - 0);
  integer1 corp_opt_in_llc_act_ind_shift0 := ROUND(Specificities[1].corp_opt_in_llc_act_ind_specificity - 0);
  integer2 corp_opt_in_llc_act_ind_switch_shift0 := ROUND(1000*Specificities[1].corp_opt_in_llc_act_ind_switch - 0);
  integer1 corp_organizational_comments_shift0 := ROUND(Specificities[1].corp_organizational_comments_specificity - 0);
  integer2 corp_organizational_comments_switch_shift0 := ROUND(1000*Specificities[1].corp_organizational_comments_switch - 0);
  integer1 corp_partner_contributions_total_shift0 := ROUND(Specificities[1].corp_partner_contributions_total_specificity - 0);
  integer2 corp_partner_contributions_total_switch_shift0 := ROUND(1000*Specificities[1].corp_partner_contributions_total_switch - 0);
  integer1 corp_partner_terms_shift0 := ROUND(Specificities[1].corp_partner_terms_specificity - 0);
  integer2 corp_partner_terms_switch_shift0 := ROUND(1000*Specificities[1].corp_partner_terms_switch - 0);
  integer1 corp_percentage_voters_required_to_approve_amendments_shift0 := ROUND(Specificities[1].corp_percentage_voters_required_to_approve_amendments_specificity - 0);
  integer2 corp_percentage_voters_required_to_approve_amendments_switch_shift0 := ROUND(1000*Specificities[1].corp_percentage_voters_required_to_approve_amendments_switch - 0);
  integer1 corp_profession_shift0 := ROUND(Specificities[1].corp_profession_specificity - 0);
  integer2 corp_profession_switch_shift0 := ROUND(1000*Specificities[1].corp_profession_switch - 0);
  integer1 corp_province_shift0 := ROUND(Specificities[1].corp_province_specificity - 0);
  integer2 corp_province_switch_shift0 := ROUND(1000*Specificities[1].corp_province_switch - 0);
  integer1 corp_public_mutual_corporation_shift0 := ROUND(Specificities[1].corp_public_mutual_corporation_specificity - 0);
  integer2 corp_public_mutual_corporation_switch_shift0 := ROUND(1000*Specificities[1].corp_public_mutual_corporation_switch - 0);
  integer1 corp_purpose_shift0 := ROUND(Specificities[1].corp_purpose_specificity - 0);
  integer2 corp_purpose_switch_shift0 := ROUND(1000*Specificities[1].corp_purpose_switch - 0);
  integer1 corp_ra_required_flag_shift0 := ROUND(Specificities[1].corp_ra_required_flag_specificity - 0);
  integer2 corp_ra_required_flag_switch_shift0 := ROUND(1000*Specificities[1].corp_ra_required_flag_switch - 0);
  integer1 corp_registered_counties_shift0 := ROUND(Specificities[1].corp_registered_counties_specificity - 0);
  integer2 corp_registered_counties_switch_shift0 := ROUND(1000*Specificities[1].corp_registered_counties_switch - 0);
  integer1 corp_regulated_ind_shift0 := ROUND(Specificities[1].corp_regulated_ind_specificity - 0);
  integer2 corp_regulated_ind_switch_shift0 := ROUND(1000*Specificities[1].corp_regulated_ind_switch - 0);
  integer1 corp_renewal_date_shift0 := ROUND(Specificities[1].corp_renewal_date_specificity - 0);
  integer2 corp_renewal_date_switch_shift0 := ROUND(1000*Specificities[1].corp_renewal_date_switch - 0);
  integer1 corp_standing_other_shift0 := ROUND(Specificities[1].corp_standing_other_specificity - 0);
  integer2 corp_standing_other_switch_shift0 := ROUND(1000*Specificities[1].corp_standing_other_switch - 0);
  integer1 corp_survivor_corporation_id_shift0 := ROUND(Specificities[1].corp_survivor_corporation_id_specificity - 0);
  integer2 corp_survivor_corporation_id_switch_shift0 := ROUND(1000*Specificities[1].corp_survivor_corporation_id_switch - 0);
  integer1 corp_tax_base_shift0 := ROUND(Specificities[1].corp_tax_base_specificity - 0);
  integer2 corp_tax_base_switch_shift0 := ROUND(1000*Specificities[1].corp_tax_base_switch - 0);
  integer1 corp_tax_standing_shift0 := ROUND(Specificities[1].corp_tax_standing_specificity - 0);
  integer2 corp_tax_standing_switch_shift0 := ROUND(1000*Specificities[1].corp_tax_standing_switch - 0);
  integer1 corp_termination_cd_shift0 := ROUND(Specificities[1].corp_termination_cd_specificity - 0);
  integer2 corp_termination_cd_switch_shift0 := ROUND(1000*Specificities[1].corp_termination_cd_switch - 0);
  integer1 corp_termination_desc_shift0 := ROUND(Specificities[1].corp_termination_desc_specificity - 0);
  integer2 corp_termination_desc_switch_shift0 := ROUND(1000*Specificities[1].corp_termination_desc_switch - 0);
  integer1 corp_termination_date_shift0 := ROUND(Specificities[1].corp_termination_date_specificity - 0);
  integer2 corp_termination_date_switch_shift0 := ROUND(1000*Specificities[1].corp_termination_date_switch - 0);
  integer1 corp_trademark_business_mark_type_shift0 := ROUND(Specificities[1].corp_trademark_business_mark_type_specificity - 0);
  integer2 corp_trademark_business_mark_type_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_business_mark_type_switch - 0);
  integer1 corp_trademark_cancelled_date_shift0 := ROUND(Specificities[1].corp_trademark_cancelled_date_specificity - 0);
  integer2 corp_trademark_cancelled_date_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_cancelled_date_switch - 0);
  integer1 corp_trademark_class_desc1_shift0 := ROUND(Specificities[1].corp_trademark_class_desc1_specificity - 0);
  integer2 corp_trademark_class_desc1_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_class_desc1_switch - 0);
  integer1 corp_trademark_class_desc2_shift0 := ROUND(Specificities[1].corp_trademark_class_desc2_specificity - 0);
  integer2 corp_trademark_class_desc2_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_class_desc2_switch - 0);
  integer1 corp_trademark_class_desc3_shift0 := ROUND(Specificities[1].corp_trademark_class_desc3_specificity - 0);
  integer2 corp_trademark_class_desc3_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_class_desc3_switch - 0);
  integer1 corp_trademark_class_desc4_shift0 := ROUND(Specificities[1].corp_trademark_class_desc4_specificity - 0);
  integer2 corp_trademark_class_desc4_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_class_desc4_switch - 0);
  integer1 corp_trademark_class_desc5_shift0 := ROUND(Specificities[1].corp_trademark_class_desc5_specificity - 0);
  integer2 corp_trademark_class_desc5_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_class_desc5_switch - 0);
  integer1 corp_trademark_class_desc6_shift0 := ROUND(Specificities[1].corp_trademark_class_desc6_specificity - 0);
  integer2 corp_trademark_class_desc6_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_class_desc6_switch - 0);
  integer1 corp_trademark_classification_nbr_shift0 := ROUND(Specificities[1].corp_trademark_classification_nbr_specificity - 0);
  integer2 corp_trademark_classification_nbr_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_classification_nbr_switch - 0);
  integer1 corp_trademark_disclaimer1_shift0 := ROUND(Specificities[1].corp_trademark_disclaimer1_specificity - 0);
  integer2 corp_trademark_disclaimer1_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_disclaimer1_switch - 0);
  integer1 corp_trademark_disclaimer2_shift0 := ROUND(Specificities[1].corp_trademark_disclaimer2_specificity - 0);
  integer2 corp_trademark_disclaimer2_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_disclaimer2_switch - 0);
  integer1 corp_trademark_expiration_date_shift0 := ROUND(Specificities[1].corp_trademark_expiration_date_specificity - 0);
  integer2 corp_trademark_expiration_date_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_expiration_date_switch - 0);
  integer1 corp_trademark_filing_date_shift0 := ROUND(Specificities[1].corp_trademark_filing_date_specificity - 0);
  integer2 corp_trademark_filing_date_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_filing_date_switch - 0);
  integer1 corp_trademark_first_use_date_shift0 := ROUND(Specificities[1].corp_trademark_first_use_date_specificity - 0);
  integer2 corp_trademark_first_use_date_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_first_use_date_switch - 0);
  integer1 corp_trademark_first_use_date_in_state_shift0 := ROUND(Specificities[1].corp_trademark_first_use_date_in_state_specificity - 0);
  integer2 corp_trademark_first_use_date_in_state_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_first_use_date_in_state_switch - 0);
  integer1 corp_trademark_keywords_shift0 := ROUND(Specificities[1].corp_trademark_keywords_specificity - 0);
  integer2 corp_trademark_keywords_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_keywords_switch - 0);
  integer1 corp_trademark_logo_shift0 := ROUND(Specificities[1].corp_trademark_logo_specificity - 0);
  integer2 corp_trademark_logo_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_logo_switch - 0);
  integer1 corp_trademark_name_expiration_date_shift0 := ROUND(Specificities[1].corp_trademark_name_expiration_date_specificity - 0);
  integer2 corp_trademark_name_expiration_date_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_name_expiration_date_switch - 0);
  integer1 corp_trademark_nbr_shift0 := ROUND(Specificities[1].corp_trademark_nbr_specificity - 0);
  integer2 corp_trademark_nbr_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_nbr_switch - 0);
  integer1 corp_trademark_renewal_date_shift0 := ROUND(Specificities[1].corp_trademark_renewal_date_specificity - 0);
  integer2 corp_trademark_renewal_date_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_renewal_date_switch - 0);
  integer1 corp_trademark_status_shift0 := ROUND(Specificities[1].corp_trademark_status_specificity - 0);
  integer2 corp_trademark_status_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_status_switch - 0);
  integer1 corp_trademark_used_1_shift0 := ROUND(Specificities[1].corp_trademark_used_1_specificity - 0);
  integer2 corp_trademark_used_1_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_used_1_switch - 0);
  integer1 corp_trademark_used_2_shift0 := ROUND(Specificities[1].corp_trademark_used_2_specificity - 0);
  integer2 corp_trademark_used_2_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_used_2_switch - 0);
  integer1 corp_trademark_used_3_shift0 := ROUND(Specificities[1].corp_trademark_used_3_specificity - 0);
  integer2 corp_trademark_used_3_switch_shift0 := ROUND(1000*Specificities[1].corp_trademark_used_3_switch - 0);
  integer1 cont_owner_percentage_shift0 := ROUND(Specificities[1].cont_owner_percentage_specificity - 0);
  integer2 cont_owner_percentage_switch_shift0 := ROUND(1000*Specificities[1].cont_owner_percentage_switch - 0);
  integer1 cont_country_shift0 := ROUND(Specificities[1].cont_country_specificity - 0);
  integer2 cont_country_switch_shift0 := ROUND(1000*Specificities[1].cont_country_switch - 0);
  integer1 cont_country_mailing_shift0 := ROUND(Specificities[1].cont_country_mailing_specificity - 0);
  integer2 cont_country_mailing_switch_shift0 := ROUND(1000*Specificities[1].cont_country_mailing_switch - 0);
  integer1 cont_nondislosure_shift0 := ROUND(Specificities[1].cont_nondislosure_specificity - 0);
  integer2 cont_nondislosure_switch_shift0 := ROUND(1000*Specificities[1].cont_nondislosure_switch - 0);
  integer1 cont_prep_addr_line1_shift0 := ROUND(Specificities[1].cont_prep_addr_line1_specificity - 0);
  integer2 cont_prep_addr_line1_switch_shift0 := ROUND(1000*Specificities[1].cont_prep_addr_line1_switch - 0);
  integer1 cont_prep_addr_last_line_shift0 := ROUND(Specificities[1].cont_prep_addr_last_line_specificity - 0);
  integer2 cont_prep_addr_last_line_switch_shift0 := ROUND(1000*Specificities[1].cont_prep_addr_last_line_switch - 0);
  integer1 recordorigin_shift0 := ROUND(Specificities[1].recordorigin_specificity - 0);
  integer2 recordorigin_switch_shift0 := ROUND(1000*Specificities[1].recordorigin_switch - 0);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT34.MAC_Specificity_Values(corp_key_values_persisted,corp_key,'corp_key',corp_key_specificity,corp_key_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_supp_key_values_persisted,corp_supp_key,'corp_supp_key',corp_supp_key_specificity,corp_supp_key_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_vendor_values_persisted,corp_vendor,'corp_vendor',corp_vendor_specificity,corp_vendor_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_vendor_county_values_persisted,corp_vendor_county,'corp_vendor_county',corp_vendor_county_specificity,corp_vendor_county_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_vendor_subcode_values_persisted,corp_vendor_subcode,'corp_vendor_subcode',corp_vendor_subcode_specificity,corp_vendor_subcode_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_state_origin_values_persisted,corp_state_origin,'corp_state_origin',corp_state_origin_specificity,corp_state_origin_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_orig_sos_charter_nbr_values_persisted,corp_orig_sos_charter_nbr,'corp_orig_sos_charter_nbr',corp_orig_sos_charter_nbr_specificity,corp_orig_sos_charter_nbr_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_legal_name_values_persisted,corp_legal_name,'corp_legal_name',corp_legal_name_specificity,corp_legal_name_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ln_name_type_cd_values_persisted,corp_ln_name_type_cd,'corp_ln_name_type_cd',corp_ln_name_type_cd_specificity,corp_ln_name_type_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ln_name_type_desc_values_persisted,corp_ln_name_type_desc,'corp_ln_name_type_desc',corp_ln_name_type_desc_specificity,corp_ln_name_type_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_supp_nbr_values_persisted,corp_supp_nbr,'corp_supp_nbr',corp_supp_nbr_specificity,corp_supp_nbr_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_name_comment_values_persisted,corp_name_comment,'corp_name_comment',corp_name_comment_specificity,corp_name_comment_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_address1_type_cd_values_persisted,corp_address1_type_cd,'corp_address1_type_cd',corp_address1_type_cd_specificity,corp_address1_type_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_address1_type_desc_values_persisted,corp_address1_type_desc,'corp_address1_type_desc',corp_address1_type_desc_specificity,corp_address1_type_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_address1_line1_values_persisted,corp_address1_line1,'corp_address1_line1',corp_address1_line1_specificity,corp_address1_line1_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_address1_line2_values_persisted,corp_address1_line2,'corp_address1_line2',corp_address1_line2_specificity,corp_address1_line2_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_address1_line3_values_persisted,corp_address1_line3,'corp_address1_line3',corp_address1_line3_specificity,corp_address1_line3_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_address1_effective_date_values_persisted,corp_address1_effective_date,'corp_address1_effective_date',corp_address1_effective_date_specificity,corp_address1_effective_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_address2_type_cd_values_persisted,corp_address2_type_cd,'corp_address2_type_cd',corp_address2_type_cd_specificity,corp_address2_type_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_address2_type_desc_values_persisted,corp_address2_type_desc,'corp_address2_type_desc',corp_address2_type_desc_specificity,corp_address2_type_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_address2_line1_values_persisted,corp_address2_line1,'corp_address2_line1',corp_address2_line1_specificity,corp_address2_line1_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_address2_line2_values_persisted,corp_address2_line2,'corp_address2_line2',corp_address2_line2_specificity,corp_address2_line2_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_address2_line3_values_persisted,corp_address2_line3,'corp_address2_line3',corp_address2_line3_specificity,corp_address2_line3_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_address2_effective_date_values_persisted,corp_address2_effective_date,'corp_address2_effective_date',corp_address2_effective_date_specificity,corp_address2_effective_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_phone_number_values_persisted,corp_phone_number,'corp_phone_number',corp_phone_number_specificity,corp_phone_number_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_phone_number_type_cd_values_persisted,corp_phone_number_type_cd,'corp_phone_number_type_cd',corp_phone_number_type_cd_specificity,corp_phone_number_type_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_phone_number_type_desc_values_persisted,corp_phone_number_type_desc,'corp_phone_number_type_desc',corp_phone_number_type_desc_specificity,corp_phone_number_type_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_fax_nbr_values_persisted,corp_fax_nbr,'corp_fax_nbr',corp_fax_nbr_specificity,corp_fax_nbr_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_email_address_values_persisted,corp_email_address,'corp_email_address',corp_email_address_specificity,corp_email_address_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_web_address_values_persisted,corp_web_address,'corp_web_address',corp_web_address_specificity,corp_web_address_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_filing_reference_nbr_values_persisted,corp_filing_reference_nbr,'corp_filing_reference_nbr',corp_filing_reference_nbr_specificity,corp_filing_reference_nbr_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_filing_date_values_persisted,corp_filing_date,'corp_filing_date',corp_filing_date_specificity,corp_filing_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_filing_cd_values_persisted,corp_filing_cd,'corp_filing_cd',corp_filing_cd_specificity,corp_filing_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_filing_desc_values_persisted,corp_filing_desc,'corp_filing_desc',corp_filing_desc_specificity,corp_filing_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_status_cd_values_persisted,corp_status_cd,'corp_status_cd',corp_status_cd_specificity,corp_status_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_status_desc_values_persisted,corp_status_desc,'corp_status_desc',corp_status_desc_specificity,corp_status_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_status_date_values_persisted,corp_status_date,'corp_status_date',corp_status_date_specificity,corp_status_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_standing_values_persisted,corp_standing,'corp_standing',corp_standing_specificity,corp_standing_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_status_comment_values_persisted,corp_status_comment,'corp_status_comment',corp_status_comment_specificity,corp_status_comment_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ticker_symbol_values_persisted,corp_ticker_symbol,'corp_ticker_symbol',corp_ticker_symbol_specificity,corp_ticker_symbol_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_stock_exchange_values_persisted,corp_stock_exchange,'corp_stock_exchange',corp_stock_exchange_specificity,corp_stock_exchange_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_inc_state_values_persisted,corp_inc_state,'corp_inc_state',corp_inc_state_specificity,corp_inc_state_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_inc_county_values_persisted,corp_inc_county,'corp_inc_county',corp_inc_county_specificity,corp_inc_county_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_inc_date_values_persisted,corp_inc_date,'corp_inc_date',corp_inc_date_specificity,corp_inc_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_anniversary_month_values_persisted,corp_anniversary_month,'corp_anniversary_month',corp_anniversary_month_specificity,corp_anniversary_month_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_fed_tax_id_values_persisted,corp_fed_tax_id,'corp_fed_tax_id',corp_fed_tax_id_specificity,corp_fed_tax_id_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_state_tax_id_values_persisted,corp_state_tax_id,'corp_state_tax_id',corp_state_tax_id_specificity,corp_state_tax_id_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_term_exist_cd_values_persisted,corp_term_exist_cd,'corp_term_exist_cd',corp_term_exist_cd_specificity,corp_term_exist_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_term_exist_exp_values_persisted,corp_term_exist_exp,'corp_term_exist_exp',corp_term_exist_exp_specificity,corp_term_exist_exp_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_term_exist_desc_values_persisted,corp_term_exist_desc,'corp_term_exist_desc',corp_term_exist_desc_specificity,corp_term_exist_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_foreign_domestic_ind_values_persisted,corp_foreign_domestic_ind,'corp_foreign_domestic_ind',corp_foreign_domestic_ind_specificity,corp_foreign_domestic_ind_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_forgn_state_cd_values_persisted,corp_forgn_state_cd,'corp_forgn_state_cd',corp_forgn_state_cd_specificity,corp_forgn_state_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_forgn_state_desc_values_persisted,corp_forgn_state_desc,'corp_forgn_state_desc',corp_forgn_state_desc_specificity,corp_forgn_state_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_forgn_sos_charter_nbr_values_persisted,corp_forgn_sos_charter_nbr,'corp_forgn_sos_charter_nbr',corp_forgn_sos_charter_nbr_specificity,corp_forgn_sos_charter_nbr_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_forgn_date_values_persisted,corp_forgn_date,'corp_forgn_date',corp_forgn_date_specificity,corp_forgn_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_forgn_fed_tax_id_values_persisted,corp_forgn_fed_tax_id,'corp_forgn_fed_tax_id',corp_forgn_fed_tax_id_specificity,corp_forgn_fed_tax_id_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_forgn_state_tax_id_values_persisted,corp_forgn_state_tax_id,'corp_forgn_state_tax_id',corp_forgn_state_tax_id_specificity,corp_forgn_state_tax_id_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_forgn_term_exist_cd_values_persisted,corp_forgn_term_exist_cd,'corp_forgn_term_exist_cd',corp_forgn_term_exist_cd_specificity,corp_forgn_term_exist_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_forgn_term_exist_exp_values_persisted,corp_forgn_term_exist_exp,'corp_forgn_term_exist_exp',corp_forgn_term_exist_exp_specificity,corp_forgn_term_exist_exp_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_forgn_term_exist_desc_values_persisted,corp_forgn_term_exist_desc,'corp_forgn_term_exist_desc',corp_forgn_term_exist_desc_specificity,corp_forgn_term_exist_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_orig_org_structure_cd_values_persisted,corp_orig_org_structure_cd,'corp_orig_org_structure_cd',corp_orig_org_structure_cd_specificity,corp_orig_org_structure_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_orig_org_structure_desc_values_persisted,corp_orig_org_structure_desc,'corp_orig_org_structure_desc',corp_orig_org_structure_desc_specificity,corp_orig_org_structure_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_for_profit_ind_values_persisted,corp_for_profit_ind,'corp_for_profit_ind',corp_for_profit_ind_specificity,corp_for_profit_ind_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_public_or_private_ind_values_persisted,corp_public_or_private_ind,'corp_public_or_private_ind',corp_public_or_private_ind_specificity,corp_public_or_private_ind_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_sic_code_values_persisted,corp_sic_code,'corp_sic_code',corp_sic_code_specificity,corp_sic_code_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_naic_code_values_persisted,corp_naic_code,'corp_naic_code',corp_naic_code_specificity,corp_naic_code_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_orig_bus_type_cd_values_persisted,corp_orig_bus_type_cd,'corp_orig_bus_type_cd',corp_orig_bus_type_cd_specificity,corp_orig_bus_type_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_orig_bus_type_desc_values_persisted,corp_orig_bus_type_desc,'corp_orig_bus_type_desc',corp_orig_bus_type_desc_specificity,corp_orig_bus_type_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_entity_desc_values_persisted,corp_entity_desc,'corp_entity_desc',corp_entity_desc_specificity,corp_entity_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_certificate_nbr_values_persisted,corp_certificate_nbr,'corp_certificate_nbr',corp_certificate_nbr_specificity,corp_certificate_nbr_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_internal_nbr_values_persisted,corp_internal_nbr,'corp_internal_nbr',corp_internal_nbr_specificity,corp_internal_nbr_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_previous_nbr_values_persisted,corp_previous_nbr,'corp_previous_nbr',corp_previous_nbr_specificity,corp_previous_nbr_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_microfilm_nbr_values_persisted,corp_microfilm_nbr,'corp_microfilm_nbr',corp_microfilm_nbr_specificity,corp_microfilm_nbr_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_amendments_filed_values_persisted,corp_amendments_filed,'corp_amendments_filed',corp_amendments_filed_specificity,corp_amendments_filed_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_acts_values_persisted,corp_acts,'corp_acts',corp_acts_specificity,corp_acts_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_partnership_ind_values_persisted,corp_partnership_ind,'corp_partnership_ind',corp_partnership_ind_specificity,corp_partnership_ind_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_mfg_ind_values_persisted,corp_mfg_ind,'corp_mfg_ind',corp_mfg_ind_specificity,corp_mfg_ind_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_addl_info_values_persisted,corp_addl_info,'corp_addl_info',corp_addl_info_specificity,corp_addl_info_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_taxes_values_persisted,corp_taxes,'corp_taxes',corp_taxes_specificity,corp_taxes_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_franchise_taxes_values_persisted,corp_franchise_taxes,'corp_franchise_taxes',corp_franchise_taxes_specificity,corp_franchise_taxes_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_tax_program_cd_values_persisted,corp_tax_program_cd,'corp_tax_program_cd',corp_tax_program_cd_specificity,corp_tax_program_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_tax_program_desc_values_persisted,corp_tax_program_desc,'corp_tax_program_desc',corp_tax_program_desc_specificity,corp_tax_program_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_full_name_values_persisted,corp_ra_full_name,'corp_ra_full_name',corp_ra_full_name_specificity,corp_ra_full_name_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_fname_values_persisted,corp_ra_fname,'corp_ra_fname',corp_ra_fname_specificity,corp_ra_fname_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_mname_values_persisted,corp_ra_mname,'corp_ra_mname',corp_ra_mname_specificity,corp_ra_mname_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_lname_values_persisted,corp_ra_lname,'corp_ra_lname',corp_ra_lname_specificity,corp_ra_lname_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_suffix_values_persisted,corp_ra_suffix,'corp_ra_suffix',corp_ra_suffix_specificity,corp_ra_suffix_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_title_cd_values_persisted,corp_ra_title_cd,'corp_ra_title_cd',corp_ra_title_cd_specificity,corp_ra_title_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_title_desc_values_persisted,corp_ra_title_desc,'corp_ra_title_desc',corp_ra_title_desc_specificity,corp_ra_title_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_fein_values_persisted,corp_ra_fein,'corp_ra_fein',corp_ra_fein_specificity,corp_ra_fein_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_ssn_values_persisted,corp_ra_ssn,'corp_ra_ssn',corp_ra_ssn_specificity,corp_ra_ssn_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_dob_values_persisted,corp_ra_dob,'corp_ra_dob',corp_ra_dob_specificity,corp_ra_dob_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_effective_date_values_persisted,corp_ra_effective_date,'corp_ra_effective_date',corp_ra_effective_date_specificity,corp_ra_effective_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_resign_date_values_persisted,corp_ra_resign_date,'corp_ra_resign_date',corp_ra_resign_date_specificity,corp_ra_resign_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_no_comp_values_persisted,corp_ra_no_comp,'corp_ra_no_comp',corp_ra_no_comp_specificity,corp_ra_no_comp_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_no_comp_igs_values_persisted,corp_ra_no_comp_igs,'corp_ra_no_comp_igs',corp_ra_no_comp_igs_specificity,corp_ra_no_comp_igs_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_addl_info_values_persisted,corp_ra_addl_info,'corp_ra_addl_info',corp_ra_addl_info_specificity,corp_ra_addl_info_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_address_type_cd_values_persisted,corp_ra_address_type_cd,'corp_ra_address_type_cd',corp_ra_address_type_cd_specificity,corp_ra_address_type_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_address_type_desc_values_persisted,corp_ra_address_type_desc,'corp_ra_address_type_desc',corp_ra_address_type_desc_specificity,corp_ra_address_type_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_address_line1_values_persisted,corp_ra_address_line1,'corp_ra_address_line1',corp_ra_address_line1_specificity,corp_ra_address_line1_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_address_line2_values_persisted,corp_ra_address_line2,'corp_ra_address_line2',corp_ra_address_line2_specificity,corp_ra_address_line2_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_address_line3_values_persisted,corp_ra_address_line3,'corp_ra_address_line3',corp_ra_address_line3_specificity,corp_ra_address_line3_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_phone_number_values_persisted,corp_ra_phone_number,'corp_ra_phone_number',corp_ra_phone_number_specificity,corp_ra_phone_number_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_phone_number_type_cd_values_persisted,corp_ra_phone_number_type_cd,'corp_ra_phone_number_type_cd',corp_ra_phone_number_type_cd_specificity,corp_ra_phone_number_type_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_phone_number_type_desc_values_persisted,corp_ra_phone_number_type_desc,'corp_ra_phone_number_type_desc',corp_ra_phone_number_type_desc_specificity,corp_ra_phone_number_type_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_fax_nbr_values_persisted,corp_ra_fax_nbr,'corp_ra_fax_nbr',corp_ra_fax_nbr_specificity,corp_ra_fax_nbr_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_email_address_values_persisted,corp_ra_email_address,'corp_ra_email_address',corp_ra_email_address_specificity,corp_ra_email_address_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_web_address_values_persisted,corp_ra_web_address,'corp_ra_web_address',corp_ra_web_address_specificity,corp_ra_web_address_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_prep_addr1_line1_values_persisted,corp_prep_addr1_line1,'corp_prep_addr1_line1',corp_prep_addr1_line1_specificity,corp_prep_addr1_line1_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_prep_addr1_last_line_values_persisted,corp_prep_addr1_last_line,'corp_prep_addr1_last_line',corp_prep_addr1_last_line_specificity,corp_prep_addr1_last_line_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_prep_addr2_line1_values_persisted,corp_prep_addr2_line1,'corp_prep_addr2_line1',corp_prep_addr2_line1_specificity,corp_prep_addr2_line1_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_prep_addr2_last_line_values_persisted,corp_prep_addr2_last_line,'corp_prep_addr2_last_line',corp_prep_addr2_last_line_specificity,corp_prep_addr2_last_line_specificity_profile);
  SALT34.MAC_Specificity_Values(ra_prep_addr_line1_values_persisted,ra_prep_addr_line1,'ra_prep_addr_line1',ra_prep_addr_line1_specificity,ra_prep_addr_line1_specificity_profile);
  SALT34.MAC_Specificity_Values(ra_prep_addr_last_line_values_persisted,ra_prep_addr_last_line,'ra_prep_addr_last_line',ra_prep_addr_last_line_specificity,ra_prep_addr_last_line_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_filing_reference_nbr_values_persisted,cont_filing_reference_nbr,'cont_filing_reference_nbr',cont_filing_reference_nbr_specificity,cont_filing_reference_nbr_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_filing_date_values_persisted,cont_filing_date,'cont_filing_date',cont_filing_date_specificity,cont_filing_date_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_filing_cd_values_persisted,cont_filing_cd,'cont_filing_cd',cont_filing_cd_specificity,cont_filing_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_filing_desc_values_persisted,cont_filing_desc,'cont_filing_desc',cont_filing_desc_specificity,cont_filing_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_type_cd_values_persisted,cont_type_cd,'cont_type_cd',cont_type_cd_specificity,cont_type_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_type_desc_values_persisted,cont_type_desc,'cont_type_desc',cont_type_desc_specificity,cont_type_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_full_name_values_persisted,cont_full_name,'cont_full_name',cont_full_name_specificity,cont_full_name_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_fname_values_persisted,cont_fname,'cont_fname',cont_fname_specificity,cont_fname_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_mname_values_persisted,cont_mname,'cont_mname',cont_mname_specificity,cont_mname_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_lname_values_persisted,cont_lname,'cont_lname',cont_lname_specificity,cont_lname_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_suffix_values_persisted,cont_suffix,'cont_suffix',cont_suffix_specificity,cont_suffix_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_title1_desc_values_persisted,cont_title1_desc,'cont_title1_desc',cont_title1_desc_specificity,cont_title1_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_title2_desc_values_persisted,cont_title2_desc,'cont_title2_desc',cont_title2_desc_specificity,cont_title2_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_title3_desc_values_persisted,cont_title3_desc,'cont_title3_desc',cont_title3_desc_specificity,cont_title3_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_title4_desc_values_persisted,cont_title4_desc,'cont_title4_desc',cont_title4_desc_specificity,cont_title4_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_title5_desc_values_persisted,cont_title5_desc,'cont_title5_desc',cont_title5_desc_specificity,cont_title5_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_fein_values_persisted,cont_fein,'cont_fein',cont_fein_specificity,cont_fein_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_ssn_values_persisted,cont_ssn,'cont_ssn',cont_ssn_specificity,cont_ssn_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_dob_values_persisted,cont_dob,'cont_dob',cont_dob_specificity,cont_dob_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_status_cd_values_persisted,cont_status_cd,'cont_status_cd',cont_status_cd_specificity,cont_status_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_status_desc_values_persisted,cont_status_desc,'cont_status_desc',cont_status_desc_specificity,cont_status_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_effective_date_values_persisted,cont_effective_date,'cont_effective_date',cont_effective_date_specificity,cont_effective_date_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_effective_cd_values_persisted,cont_effective_cd,'cont_effective_cd',cont_effective_cd_specificity,cont_effective_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_effective_desc_values_persisted,cont_effective_desc,'cont_effective_desc',cont_effective_desc_specificity,cont_effective_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_addl_info_values_persisted,cont_addl_info,'cont_addl_info',cont_addl_info_specificity,cont_addl_info_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_address_type_cd_values_persisted,cont_address_type_cd,'cont_address_type_cd',cont_address_type_cd_specificity,cont_address_type_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_address_type_desc_values_persisted,cont_address_type_desc,'cont_address_type_desc',cont_address_type_desc_specificity,cont_address_type_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_address_line1_values_persisted,cont_address_line1,'cont_address_line1',cont_address_line1_specificity,cont_address_line1_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_address_line2_values_persisted,cont_address_line2,'cont_address_line2',cont_address_line2_specificity,cont_address_line2_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_address_line3_values_persisted,cont_address_line3,'cont_address_line3',cont_address_line3_specificity,cont_address_line3_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_address_effective_date_values_persisted,cont_address_effective_date,'cont_address_effective_date',cont_address_effective_date_specificity,cont_address_effective_date_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_address_county_values_persisted,cont_address_county,'cont_address_county',cont_address_county_specificity,cont_address_county_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_phone_number_values_persisted,cont_phone_number,'cont_phone_number',cont_phone_number_specificity,cont_phone_number_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_phone_number_type_cd_values_persisted,cont_phone_number_type_cd,'cont_phone_number_type_cd',cont_phone_number_type_cd_specificity,cont_phone_number_type_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_phone_number_type_desc_values_persisted,cont_phone_number_type_desc,'cont_phone_number_type_desc',cont_phone_number_type_desc_specificity,cont_phone_number_type_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_fax_nbr_values_persisted,cont_fax_nbr,'cont_fax_nbr',cont_fax_nbr_specificity,cont_fax_nbr_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_email_address_values_persisted,cont_email_address,'cont_email_address',cont_email_address_specificity,cont_email_address_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_web_address_values_persisted,cont_web_address,'cont_web_address',cont_web_address_specificity,cont_web_address_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_acres_values_persisted,corp_acres,'corp_acres',corp_acres_specificity,corp_acres_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_action_values_persisted,corp_action,'corp_action',corp_action_specificity,corp_action_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_action_date_values_persisted,corp_action_date,'corp_action_date',corp_action_date_specificity,corp_action_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_action_employment_security_approval_date_values_persisted,corp_action_employment_security_approval_date,'corp_action_employment_security_approval_date',corp_action_employment_security_approval_date_specificity,corp_action_employment_security_approval_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_action_pending_cd_values_persisted,corp_action_pending_cd,'corp_action_pending_cd',corp_action_pending_cd_specificity,corp_action_pending_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_action_pending_desc_values_persisted,corp_action_pending_desc,'corp_action_pending_desc',corp_action_pending_desc_specificity,corp_action_pending_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_action_statement_of_intent_date_values_persisted,corp_action_statement_of_intent_date,'corp_action_statement_of_intent_date',corp_action_statement_of_intent_date_specificity,corp_action_statement_of_intent_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_action_tax_dept_approval_date_values_persisted,corp_action_tax_dept_approval_date,'corp_action_tax_dept_approval_date',corp_action_tax_dept_approval_date_specificity,corp_action_tax_dept_approval_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_acts2_values_persisted,corp_acts2,'corp_acts2',corp_acts2_specificity,corp_acts2_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_acts3_values_persisted,corp_acts3,'corp_acts3',corp_acts3_specificity,corp_acts3_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_additional_principals_values_persisted,corp_additional_principals,'corp_additional_principals',corp_additional_principals_specificity,corp_additional_principals_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_address_office_type_values_persisted,corp_address_office_type,'corp_address_office_type',corp_address_office_type_specificity,corp_address_office_type_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_agent_assign_date_values_persisted,corp_agent_assign_date,'corp_agent_assign_date',corp_agent_assign_date_specificity,corp_agent_assign_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_agent_commercial_values_persisted,corp_agent_commercial,'corp_agent_commercial',corp_agent_commercial_specificity,corp_agent_commercial_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_agent_country_values_persisted,corp_agent_country,'corp_agent_country',corp_agent_country_specificity,corp_agent_country_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_agent_county_values_persisted,corp_agent_county,'corp_agent_county',corp_agent_county_specificity,corp_agent_county_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_agent_status_cd_values_persisted,corp_agent_status_cd,'corp_agent_status_cd',corp_agent_status_cd_specificity,corp_agent_status_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_agent_status_desc_values_persisted,corp_agent_status_desc,'corp_agent_status_desc',corp_agent_status_desc_specificity,corp_agent_status_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_agent_id_values_persisted,corp_agent_id,'corp_agent_id',corp_agent_id_specificity,corp_agent_id_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_agriculture_flag_values_persisted,corp_agriculture_flag,'corp_agriculture_flag',corp_agriculture_flag_specificity,corp_agriculture_flag_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_authorized_partners_values_persisted,corp_authorized_partners,'corp_authorized_partners',corp_authorized_partners_specificity,corp_authorized_partners_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_comment_values_persisted,corp_comment,'corp_comment',corp_comment_specificity,corp_comment_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_consent_flag_for_protected_name_values_persisted,corp_consent_flag_for_protected_name,'corp_consent_flag_for_protected_name',corp_consent_flag_for_protected_name_specificity,corp_consent_flag_for_protected_name_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_converted_values_persisted,corp_converted,'corp_converted',corp_converted_specificity,corp_converted_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_converted_from_values_persisted,corp_converted_from,'corp_converted_from',corp_converted_from_specificity,corp_converted_from_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_country_of_formation_values_persisted,corp_country_of_formation,'corp_country_of_formation',corp_country_of_formation_specificity,corp_country_of_formation_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_date_of_organization_meeting_values_persisted,corp_date_of_organization_meeting,'corp_date_of_organization_meeting',corp_date_of_organization_meeting_specificity,corp_date_of_organization_meeting_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_delayed_effective_date_values_persisted,corp_delayed_effective_date,'corp_delayed_effective_date',corp_delayed_effective_date_specificity,corp_delayed_effective_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_directors_from_to_values_persisted,corp_directors_from_to,'corp_directors_from_to',corp_directors_from_to_specificity,corp_directors_from_to_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_dissolved_date_values_persisted,corp_dissolved_date,'corp_dissolved_date',corp_dissolved_date_specificity,corp_dissolved_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_farm_exemptions_values_persisted,corp_farm_exemptions,'corp_farm_exemptions',corp_farm_exemptions_specificity,corp_farm_exemptions_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_farm_qual_date_values_persisted,corp_farm_qual_date,'corp_farm_qual_date',corp_farm_qual_date_specificity,corp_farm_qual_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_farm_status_cd_values_persisted,corp_farm_status_cd,'corp_farm_status_cd',corp_farm_status_cd_specificity,corp_farm_status_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_farm_status_desc_values_persisted,corp_farm_status_desc,'corp_farm_status_desc',corp_farm_status_desc_specificity,corp_farm_status_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_fiscal_year_month_values_persisted,corp_fiscal_year_month,'corp_fiscal_year_month',corp_fiscal_year_month_specificity,corp_fiscal_year_month_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_foreign_fiduciary_capacity_in_state_values_persisted,corp_foreign_fiduciary_capacity_in_state,'corp_foreign_fiduciary_capacity_in_state',corp_foreign_fiduciary_capacity_in_state_specificity,corp_foreign_fiduciary_capacity_in_state_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_governing_statute_values_persisted,corp_governing_statute,'corp_governing_statute',corp_governing_statute_specificity,corp_governing_statute_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_has_members_values_persisted,corp_has_members,'corp_has_members',corp_has_members_specificity,corp_has_members_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_has_vested_managers_values_persisted,corp_has_vested_managers,'corp_has_vested_managers',corp_has_vested_managers_specificity,corp_has_vested_managers_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_home_incorporated_county_values_persisted,corp_home_incorporated_county,'corp_home_incorporated_county',corp_home_incorporated_county_specificity,corp_home_incorporated_county_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_home_state_name_values_persisted,corp_home_state_name,'corp_home_state_name',corp_home_state_name_specificity,corp_home_state_name_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_is_professional_values_persisted,corp_is_professional,'corp_is_professional',corp_is_professional_specificity,corp_is_professional_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_is_non_profit_irs_approved_values_persisted,corp_is_non_profit_irs_approved,'corp_is_non_profit_irs_approved',corp_is_non_profit_irs_approved_specificity,corp_is_non_profit_irs_approved_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_last_renewal_date_values_persisted,corp_last_renewal_date,'corp_last_renewal_date',corp_last_renewal_date_specificity,corp_last_renewal_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_last_renewal_year_values_persisted,corp_last_renewal_year,'corp_last_renewal_year',corp_last_renewal_year_specificity,corp_last_renewal_year_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_license_type_values_persisted,corp_license_type,'corp_license_type',corp_license_type_specificity,corp_license_type_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_llc_managed_desc_values_persisted,corp_llc_managed_desc,'corp_llc_managed_desc',corp_llc_managed_desc_specificity,corp_llc_managed_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_llc_managed_ind_values_persisted,corp_llc_managed_ind,'corp_llc_managed_ind',corp_llc_managed_ind_specificity,corp_llc_managed_ind_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_management_desc_values_persisted,corp_management_desc,'corp_management_desc',corp_management_desc_specificity,corp_management_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_management_type_values_persisted,corp_management_type,'corp_management_type',corp_management_type_specificity,corp_management_type_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_manager_managed_values_persisted,corp_manager_managed,'corp_manager_managed',corp_manager_managed_specificity,corp_manager_managed_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_merged_corporation_id_values_persisted,corp_merged_corporation_id,'corp_merged_corporation_id',corp_merged_corporation_id_specificity,corp_merged_corporation_id_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_merged_fein_values_persisted,corp_merged_fein,'corp_merged_fein',corp_merged_fein_specificity,corp_merged_fein_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_merger_allowed_flag_values_persisted,corp_merger_allowed_flag,'corp_merger_allowed_flag',corp_merger_allowed_flag_specificity,corp_merger_allowed_flag_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_merger_date_values_persisted,corp_merger_date,'corp_merger_date',corp_merger_date_specificity,corp_merger_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_merger_desc_values_persisted,corp_merger_desc,'corp_merger_desc',corp_merger_desc_specificity,corp_merger_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_merger_effective_date_values_persisted,corp_merger_effective_date,'corp_merger_effective_date',corp_merger_effective_date_specificity,corp_merger_effective_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_merger_id_values_persisted,corp_merger_id,'corp_merger_id',corp_merger_id_specificity,corp_merger_id_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_merger_indicator_values_persisted,corp_merger_indicator,'corp_merger_indicator',corp_merger_indicator_specificity,corp_merger_indicator_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_merger_name_values_persisted,corp_merger_name,'corp_merger_name',corp_merger_name_specificity,corp_merger_name_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_merger_type_converted_to_cd_values_persisted,corp_merger_type_converted_to_cd,'corp_merger_type_converted_to_cd',corp_merger_type_converted_to_cd_specificity,corp_merger_type_converted_to_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_merger_type_converted_to_desc_values_persisted,corp_merger_type_converted_to_desc,'corp_merger_type_converted_to_desc',corp_merger_type_converted_to_desc_specificity,corp_merger_type_converted_to_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_naics_desc_values_persisted,corp_naics_desc,'corp_naics_desc',corp_naics_desc_specificity,corp_naics_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_name_effective_date_values_persisted,corp_name_effective_date,'corp_name_effective_date',corp_name_effective_date_specificity,corp_name_effective_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_name_reservation_date_values_persisted,corp_name_reservation_date,'corp_name_reservation_date',corp_name_reservation_date_specificity,corp_name_reservation_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_name_reservation_desc_values_persisted,corp_name_reservation_desc,'corp_name_reservation_desc',corp_name_reservation_desc_specificity,corp_name_reservation_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_name_reservation_expiration_date_values_persisted,corp_name_reservation_expiration_date,'corp_name_reservation_expiration_date',corp_name_reservation_expiration_date_specificity,corp_name_reservation_expiration_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_name_reservation_nbr_values_persisted,corp_name_reservation_nbr,'corp_name_reservation_nbr',corp_name_reservation_nbr_specificity,corp_name_reservation_nbr_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_name_reservation_type_values_persisted,corp_name_reservation_type,'corp_name_reservation_type',corp_name_reservation_type_specificity,corp_name_reservation_type_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_name_status_cd_values_persisted,corp_name_status_cd,'corp_name_status_cd',corp_name_status_cd_specificity,corp_name_status_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_name_status_date_values_persisted,corp_name_status_date,'corp_name_status_date',corp_name_status_date_specificity,corp_name_status_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_name_status_desc_values_persisted,corp_name_status_desc,'corp_name_status_desc',corp_name_status_desc_specificity,corp_name_status_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_non_profit_irs_approved_purpose_values_persisted,corp_non_profit_irs_approved_purpose,'corp_non_profit_irs_approved_purpose',corp_non_profit_irs_approved_purpose_specificity,corp_non_profit_irs_approved_purpose_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_non_profit_solicit_donations_values_persisted,corp_non_profit_solicit_donations,'corp_non_profit_solicit_donations',corp_non_profit_solicit_donations_specificity,corp_non_profit_solicit_donations_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_nbr_of_amendments_values_persisted,corp_nbr_of_amendments,'corp_nbr_of_amendments',corp_nbr_of_amendments_specificity,corp_nbr_of_amendments_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_nbr_of_initial_llc_members_values_persisted,corp_nbr_of_initial_llc_members,'corp_nbr_of_initial_llc_members',corp_nbr_of_initial_llc_members_specificity,corp_nbr_of_initial_llc_members_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_nbr_of_partners_values_persisted,corp_nbr_of_partners,'corp_nbr_of_partners',corp_nbr_of_partners_specificity,corp_nbr_of_partners_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_operating_agreement_values_persisted,corp_operating_agreement,'corp_operating_agreement',corp_operating_agreement_specificity,corp_operating_agreement_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_opt_in_llc_act_desc_values_persisted,corp_opt_in_llc_act_desc,'corp_opt_in_llc_act_desc',corp_opt_in_llc_act_desc_specificity,corp_opt_in_llc_act_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_opt_in_llc_act_ind_values_persisted,corp_opt_in_llc_act_ind,'corp_opt_in_llc_act_ind',corp_opt_in_llc_act_ind_specificity,corp_opt_in_llc_act_ind_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_organizational_comments_values_persisted,corp_organizational_comments,'corp_organizational_comments',corp_organizational_comments_specificity,corp_organizational_comments_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_partner_contributions_total_values_persisted,corp_partner_contributions_total,'corp_partner_contributions_total',corp_partner_contributions_total_specificity,corp_partner_contributions_total_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_partner_terms_values_persisted,corp_partner_terms,'corp_partner_terms',corp_partner_terms_specificity,corp_partner_terms_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_percentage_voters_required_to_approve_amendments_values_persisted,corp_percentage_voters_required_to_approve_amendments,'corp_percentage_voters_required_to_approve_amendments',corp_percentage_voters_required_to_approve_amendments_specificity,corp_percentage_voters_required_to_approve_amendments_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_profession_values_persisted,corp_profession,'corp_profession',corp_profession_specificity,corp_profession_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_province_values_persisted,corp_province,'corp_province',corp_province_specificity,corp_province_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_public_mutual_corporation_values_persisted,corp_public_mutual_corporation,'corp_public_mutual_corporation',corp_public_mutual_corporation_specificity,corp_public_mutual_corporation_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_purpose_values_persisted,corp_purpose,'corp_purpose',corp_purpose_specificity,corp_purpose_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_ra_required_flag_values_persisted,corp_ra_required_flag,'corp_ra_required_flag',corp_ra_required_flag_specificity,corp_ra_required_flag_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_registered_counties_values_persisted,corp_registered_counties,'corp_registered_counties',corp_registered_counties_specificity,corp_registered_counties_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_regulated_ind_values_persisted,corp_regulated_ind,'corp_regulated_ind',corp_regulated_ind_specificity,corp_regulated_ind_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_renewal_date_values_persisted,corp_renewal_date,'corp_renewal_date',corp_renewal_date_specificity,corp_renewal_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_standing_other_values_persisted,corp_standing_other,'corp_standing_other',corp_standing_other_specificity,corp_standing_other_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_survivor_corporation_id_values_persisted,corp_survivor_corporation_id,'corp_survivor_corporation_id',corp_survivor_corporation_id_specificity,corp_survivor_corporation_id_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_tax_base_values_persisted,corp_tax_base,'corp_tax_base',corp_tax_base_specificity,corp_tax_base_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_tax_standing_values_persisted,corp_tax_standing,'corp_tax_standing',corp_tax_standing_specificity,corp_tax_standing_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_termination_cd_values_persisted,corp_termination_cd,'corp_termination_cd',corp_termination_cd_specificity,corp_termination_cd_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_termination_desc_values_persisted,corp_termination_desc,'corp_termination_desc',corp_termination_desc_specificity,corp_termination_desc_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_termination_date_values_persisted,corp_termination_date,'corp_termination_date',corp_termination_date_specificity,corp_termination_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_business_mark_type_values_persisted,corp_trademark_business_mark_type,'corp_trademark_business_mark_type',corp_trademark_business_mark_type_specificity,corp_trademark_business_mark_type_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_cancelled_date_values_persisted,corp_trademark_cancelled_date,'corp_trademark_cancelled_date',corp_trademark_cancelled_date_specificity,corp_trademark_cancelled_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_class_desc1_values_persisted,corp_trademark_class_desc1,'corp_trademark_class_desc1',corp_trademark_class_desc1_specificity,corp_trademark_class_desc1_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_class_desc2_values_persisted,corp_trademark_class_desc2,'corp_trademark_class_desc2',corp_trademark_class_desc2_specificity,corp_trademark_class_desc2_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_class_desc3_values_persisted,corp_trademark_class_desc3,'corp_trademark_class_desc3',corp_trademark_class_desc3_specificity,corp_trademark_class_desc3_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_class_desc4_values_persisted,corp_trademark_class_desc4,'corp_trademark_class_desc4',corp_trademark_class_desc4_specificity,corp_trademark_class_desc4_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_class_desc5_values_persisted,corp_trademark_class_desc5,'corp_trademark_class_desc5',corp_trademark_class_desc5_specificity,corp_trademark_class_desc5_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_class_desc6_values_persisted,corp_trademark_class_desc6,'corp_trademark_class_desc6',corp_trademark_class_desc6_specificity,corp_trademark_class_desc6_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_classification_nbr_values_persisted,corp_trademark_classification_nbr,'corp_trademark_classification_nbr',corp_trademark_classification_nbr_specificity,corp_trademark_classification_nbr_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_disclaimer1_values_persisted,corp_trademark_disclaimer1,'corp_trademark_disclaimer1',corp_trademark_disclaimer1_specificity,corp_trademark_disclaimer1_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_disclaimer2_values_persisted,corp_trademark_disclaimer2,'corp_trademark_disclaimer2',corp_trademark_disclaimer2_specificity,corp_trademark_disclaimer2_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_expiration_date_values_persisted,corp_trademark_expiration_date,'corp_trademark_expiration_date',corp_trademark_expiration_date_specificity,corp_trademark_expiration_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_filing_date_values_persisted,corp_trademark_filing_date,'corp_trademark_filing_date',corp_trademark_filing_date_specificity,corp_trademark_filing_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_first_use_date_values_persisted,corp_trademark_first_use_date,'corp_trademark_first_use_date',corp_trademark_first_use_date_specificity,corp_trademark_first_use_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_first_use_date_in_state_values_persisted,corp_trademark_first_use_date_in_state,'corp_trademark_first_use_date_in_state',corp_trademark_first_use_date_in_state_specificity,corp_trademark_first_use_date_in_state_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_keywords_values_persisted,corp_trademark_keywords,'corp_trademark_keywords',corp_trademark_keywords_specificity,corp_trademark_keywords_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_logo_values_persisted,corp_trademark_logo,'corp_trademark_logo',corp_trademark_logo_specificity,corp_trademark_logo_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_name_expiration_date_values_persisted,corp_trademark_name_expiration_date,'corp_trademark_name_expiration_date',corp_trademark_name_expiration_date_specificity,corp_trademark_name_expiration_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_nbr_values_persisted,corp_trademark_nbr,'corp_trademark_nbr',corp_trademark_nbr_specificity,corp_trademark_nbr_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_renewal_date_values_persisted,corp_trademark_renewal_date,'corp_trademark_renewal_date',corp_trademark_renewal_date_specificity,corp_trademark_renewal_date_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_status_values_persisted,corp_trademark_status,'corp_trademark_status',corp_trademark_status_specificity,corp_trademark_status_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_used_1_values_persisted,corp_trademark_used_1,'corp_trademark_used_1',corp_trademark_used_1_specificity,corp_trademark_used_1_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_used_2_values_persisted,corp_trademark_used_2,'corp_trademark_used_2',corp_trademark_used_2_specificity,corp_trademark_used_2_specificity_profile);
  SALT34.MAC_Specificity_Values(corp_trademark_used_3_values_persisted,corp_trademark_used_3,'corp_trademark_used_3',corp_trademark_used_3_specificity,corp_trademark_used_3_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_owner_percentage_values_persisted,cont_owner_percentage,'cont_owner_percentage',cont_owner_percentage_specificity,cont_owner_percentage_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_country_values_persisted,cont_country,'cont_country',cont_country_specificity,cont_country_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_country_mailing_values_persisted,cont_country_mailing,'cont_country_mailing',cont_country_mailing_specificity,cont_country_mailing_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_nondislosure_values_persisted,cont_nondislosure,'cont_nondislosure',cont_nondislosure_specificity,cont_nondislosure_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_prep_addr_line1_values_persisted,cont_prep_addr_line1,'cont_prep_addr_line1',cont_prep_addr_line1_specificity,cont_prep_addr_line1_specificity_profile);
  SALT34.MAC_Specificity_Values(cont_prep_addr_last_line_values_persisted,cont_prep_addr_last_line,'cont_prep_addr_last_line',cont_prep_addr_last_line_specificity,cont_prep_addr_last_line_specificity_profile);
  SALT34.MAC_Specificity_Values(recordorigin_values_persisted,recordorigin,'recordorigin',recordorigin_specificity,recordorigin_specificity_profile);
EXPORT AllProfiles := corp_key_specificity_profile + corp_supp_key_specificity_profile + corp_vendor_specificity_profile + corp_vendor_county_specificity_profile + corp_vendor_subcode_specificity_profile + corp_state_origin_specificity_profile + corp_orig_sos_charter_nbr_specificity_profile + corp_legal_name_specificity_profile + corp_ln_name_type_cd_specificity_profile + corp_ln_name_type_desc_specificity_profile + corp_supp_nbr_specificity_profile + corp_name_comment_specificity_profile + corp_address1_type_cd_specificity_profile + corp_address1_type_desc_specificity_profile + corp_address1_line1_specificity_profile + corp_address1_line2_specificity_profile + corp_address1_line3_specificity_profile + corp_address1_effective_date_specificity_profile + corp_address2_type_cd_specificity_profile + corp_address2_type_desc_specificity_profile + corp_address2_line1_specificity_profile + corp_address2_line2_specificity_profile + corp_address2_line3_specificity_profile + corp_address2_effective_date_specificity_profile + corp_phone_number_specificity_profile + corp_phone_number_type_cd_specificity_profile + corp_phone_number_type_desc_specificity_profile + corp_fax_nbr_specificity_profile + corp_email_address_specificity_profile + corp_web_address_specificity_profile + corp_filing_reference_nbr_specificity_profile + corp_filing_date_specificity_profile + corp_filing_cd_specificity_profile + corp_filing_desc_specificity_profile + corp_status_cd_specificity_profile + corp_status_desc_specificity_profile + corp_status_date_specificity_profile + corp_standing_specificity_profile + corp_status_comment_specificity_profile + corp_ticker_symbol_specificity_profile + corp_stock_exchange_specificity_profile + corp_inc_state_specificity_profile + corp_inc_county_specificity_profile + corp_inc_date_specificity_profile + corp_anniversary_month_specificity_profile + corp_fed_tax_id_specificity_profile + corp_state_tax_id_specificity_profile + corp_term_exist_cd_specificity_profile + corp_term_exist_exp_specificity_profile + corp_term_exist_desc_specificity_profile + corp_foreign_domestic_ind_specificity_profile + corp_forgn_state_cd_specificity_profile + corp_forgn_state_desc_specificity_profile + corp_forgn_sos_charter_nbr_specificity_profile + corp_forgn_date_specificity_profile + corp_forgn_fed_tax_id_specificity_profile + corp_forgn_state_tax_id_specificity_profile + corp_forgn_term_exist_cd_specificity_profile + corp_forgn_term_exist_exp_specificity_profile + corp_forgn_term_exist_desc_specificity_profile + corp_orig_org_structure_cd_specificity_profile + corp_orig_org_structure_desc_specificity_profile + corp_for_profit_ind_specificity_profile + corp_public_or_private_ind_specificity_profile + corp_sic_code_specificity_profile + corp_naic_code_specificity_profile + corp_orig_bus_type_cd_specificity_profile + corp_orig_bus_type_desc_specificity_profile + corp_entity_desc_specificity_profile + corp_certificate_nbr_specificity_profile + corp_internal_nbr_specificity_profile + corp_previous_nbr_specificity_profile + corp_microfilm_nbr_specificity_profile + corp_amendments_filed_specificity_profile + corp_acts_specificity_profile + corp_partnership_ind_specificity_profile + corp_mfg_ind_specificity_profile + corp_addl_info_specificity_profile + corp_taxes_specificity_profile + corp_franchise_taxes_specificity_profile + corp_tax_program_cd_specificity_profile + corp_tax_program_desc_specificity_profile + corp_ra_full_name_specificity_profile + corp_ra_fname_specificity_profile + corp_ra_mname_specificity_profile + corp_ra_lname_specificity_profile + corp_ra_suffix_specificity_profile + corp_ra_title_cd_specificity_profile + corp_ra_title_desc_specificity_profile + corp_ra_fein_specificity_profile + corp_ra_ssn_specificity_profile + corp_ra_dob_specificity_profile + corp_ra_effective_date_specificity_profile + corp_ra_resign_date_specificity_profile + corp_ra_no_comp_specificity_profile + corp_ra_no_comp_igs_specificity_profile + corp_ra_addl_info_specificity_profile + corp_ra_address_type_cd_specificity_profile + corp_ra_address_type_desc_specificity_profile + corp_ra_address_line1_specificity_profile + corp_ra_address_line2_specificity_profile + corp_ra_address_line3_specificity_profile + corp_ra_phone_number_specificity_profile + corp_ra_phone_number_type_cd_specificity_profile + corp_ra_phone_number_type_desc_specificity_profile + corp_ra_fax_nbr_specificity_profile + corp_ra_email_address_specificity_profile + corp_ra_web_address_specificity_profile + corp_prep_addr1_line1_specificity_profile + corp_prep_addr1_last_line_specificity_profile + corp_prep_addr2_line1_specificity_profile + corp_prep_addr2_last_line_specificity_profile + ra_prep_addr_line1_specificity_profile + ra_prep_addr_last_line_specificity_profile + cont_filing_reference_nbr_specificity_profile + cont_filing_date_specificity_profile + cont_filing_cd_specificity_profile + cont_filing_desc_specificity_profile + cont_type_cd_specificity_profile + cont_type_desc_specificity_profile + cont_full_name_specificity_profile + cont_fname_specificity_profile + cont_mname_specificity_profile + cont_lname_specificity_profile + cont_suffix_specificity_profile + cont_title1_desc_specificity_profile + cont_title2_desc_specificity_profile + cont_title3_desc_specificity_profile + cont_title4_desc_specificity_profile + cont_title5_desc_specificity_profile + cont_fein_specificity_profile + cont_ssn_specificity_profile + cont_dob_specificity_profile + cont_status_cd_specificity_profile + cont_status_desc_specificity_profile + cont_effective_date_specificity_profile + cont_effective_cd_specificity_profile + cont_effective_desc_specificity_profile + cont_addl_info_specificity_profile + cont_address_type_cd_specificity_profile + cont_address_type_desc_specificity_profile + cont_address_line1_specificity_profile + cont_address_line2_specificity_profile + cont_address_line3_specificity_profile + cont_address_effective_date_specificity_profile + cont_address_county_specificity_profile + cont_phone_number_specificity_profile + cont_phone_number_type_cd_specificity_profile + cont_phone_number_type_desc_specificity_profile + cont_fax_nbr_specificity_profile + cont_email_address_specificity_profile + cont_web_address_specificity_profile + corp_acres_specificity_profile + corp_action_specificity_profile + corp_action_date_specificity_profile + corp_action_employment_security_approval_date_specificity_profile + corp_action_pending_cd_specificity_profile + corp_action_pending_desc_specificity_profile + corp_action_statement_of_intent_date_specificity_profile + corp_action_tax_dept_approval_date_specificity_profile + corp_acts2_specificity_profile + corp_acts3_specificity_profile + corp_additional_principals_specificity_profile + corp_address_office_type_specificity_profile + corp_agent_assign_date_specificity_profile + corp_agent_commercial_specificity_profile + corp_agent_country_specificity_profile + corp_agent_county_specificity_profile + corp_agent_status_cd_specificity_profile + corp_agent_status_desc_specificity_profile + corp_agent_id_specificity_profile + corp_agriculture_flag_specificity_profile + corp_authorized_partners_specificity_profile + corp_comment_specificity_profile + corp_consent_flag_for_protected_name_specificity_profile + corp_converted_specificity_profile + corp_converted_from_specificity_profile + corp_country_of_formation_specificity_profile + corp_date_of_organization_meeting_specificity_profile + corp_delayed_effective_date_specificity_profile + corp_directors_from_to_specificity_profile + corp_dissolved_date_specificity_profile + corp_farm_exemptions_specificity_profile + corp_farm_qual_date_specificity_profile + corp_farm_status_cd_specificity_profile + corp_farm_status_desc_specificity_profile + corp_fiscal_year_month_specificity_profile + corp_foreign_fiduciary_capacity_in_state_specificity_profile + corp_governing_statute_specificity_profile + corp_has_members_specificity_profile + corp_has_vested_managers_specificity_profile + corp_home_incorporated_county_specificity_profile + corp_home_state_name_specificity_profile + corp_is_professional_specificity_profile + corp_is_non_profit_irs_approved_specificity_profile + corp_last_renewal_date_specificity_profile + corp_last_renewal_year_specificity_profile + corp_license_type_specificity_profile + corp_llc_managed_desc_specificity_profile + corp_llc_managed_ind_specificity_profile + corp_management_desc_specificity_profile + corp_management_type_specificity_profile + corp_manager_managed_specificity_profile + corp_merged_corporation_id_specificity_profile + corp_merged_fein_specificity_profile + corp_merger_allowed_flag_specificity_profile + corp_merger_date_specificity_profile + corp_merger_desc_specificity_profile + corp_merger_effective_date_specificity_profile + corp_merger_id_specificity_profile + corp_merger_indicator_specificity_profile + corp_merger_name_specificity_profile + corp_merger_type_converted_to_cd_specificity_profile + corp_merger_type_converted_to_desc_specificity_profile + corp_naics_desc_specificity_profile + corp_name_effective_date_specificity_profile + corp_name_reservation_date_specificity_profile + corp_name_reservation_desc_specificity_profile + corp_name_reservation_expiration_date_specificity_profile + corp_name_reservation_nbr_specificity_profile + corp_name_reservation_type_specificity_profile + corp_name_status_cd_specificity_profile + corp_name_status_date_specificity_profile + corp_name_status_desc_specificity_profile + corp_non_profit_irs_approved_purpose_specificity_profile + corp_non_profit_solicit_donations_specificity_profile + corp_nbr_of_amendments_specificity_profile + corp_nbr_of_initial_llc_members_specificity_profile + corp_nbr_of_partners_specificity_profile + corp_operating_agreement_specificity_profile + corp_opt_in_llc_act_desc_specificity_profile + corp_opt_in_llc_act_ind_specificity_profile + corp_organizational_comments_specificity_profile + corp_partner_contributions_total_specificity_profile + corp_partner_terms_specificity_profile + corp_percentage_voters_required_to_approve_amendments_specificity_profile + corp_profession_specificity_profile + corp_province_specificity_profile + corp_public_mutual_corporation_specificity_profile + corp_purpose_specificity_profile + corp_ra_required_flag_specificity_profile + corp_registered_counties_specificity_profile + corp_regulated_ind_specificity_profile + corp_renewal_date_specificity_profile + corp_standing_other_specificity_profile + corp_survivor_corporation_id_specificity_profile + corp_tax_base_specificity_profile + corp_tax_standing_specificity_profile + corp_termination_cd_specificity_profile + corp_termination_desc_specificity_profile + corp_termination_date_specificity_profile + corp_trademark_business_mark_type_specificity_profile + corp_trademark_cancelled_date_specificity_profile + corp_trademark_class_desc1_specificity_profile + corp_trademark_class_desc2_specificity_profile + corp_trademark_class_desc3_specificity_profile + corp_trademark_class_desc4_specificity_profile + corp_trademark_class_desc5_specificity_profile + corp_trademark_class_desc6_specificity_profile + corp_trademark_classification_nbr_specificity_profile + corp_trademark_disclaimer1_specificity_profile + corp_trademark_disclaimer2_specificity_profile + corp_trademark_expiration_date_specificity_profile + corp_trademark_filing_date_specificity_profile + corp_trademark_first_use_date_specificity_profile + corp_trademark_first_use_date_in_state_specificity_profile + corp_trademark_keywords_specificity_profile + corp_trademark_logo_specificity_profile + corp_trademark_name_expiration_date_specificity_profile + corp_trademark_nbr_specificity_profile + corp_trademark_renewal_date_specificity_profile + corp_trademark_status_specificity_profile + corp_trademark_used_1_specificity_profile + corp_trademark_used_2_specificity_profile + corp_trademark_used_3_specificity_profile + cont_owner_percentage_specificity_profile + cont_country_specificity_profile + cont_country_mailing_specificity_profile + cont_nondislosure_specificity_profile + cont_prep_addr_line1_specificity_profile + cont_prep_addr_last_line_specificity_profile + recordorigin_specificity_profile;
END;
 
