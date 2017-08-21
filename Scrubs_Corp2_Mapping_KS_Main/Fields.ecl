IMPORT ut,SALT34;
IMPORT Scrubs,Scrubs_Corp2_Mapping_KS_Main; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT34.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_mandatory','invalid_date','invalid_future_date','invalid_charter_nbr','invalid_Y_N','invalid_type_cd','invalid_type_desc','invalid_addr_type_cd','invalid_addr_type_desc','invalid_fed_tax_id','invalid_term_exist_cd','invalid_for_dom_ind','invalid_recordorigin','invalid_status','invalid_org_structure_cd','invalid_alphablank','invalid_forgn_state_desc','invalid_numeric','invalid_numblank');
EXPORT FieldTypeNum(SALT34.StrType fn) := CASE(fn,'invalid_corp_key' => 1,'invalid_corp_vendor' => 2,'invalid_state_origin' => 3,'invalid_mandatory' => 4,'invalid_date' => 5,'invalid_future_date' => 6,'invalid_charter_nbr' => 7,'invalid_Y_N' => 8,'invalid_type_cd' => 9,'invalid_type_desc' => 10,'invalid_addr_type_cd' => 11,'invalid_addr_type_desc' => 12,'invalid_fed_tax_id' => 13,'invalid_term_exist_cd' => 14,'invalid_for_dom_ind' => 15,'invalid_recordorigin' => 16,'invalid_status' => 17,'invalid_org_structure_cd' => 18,'invalid_alphablank' => 19,'invalid_forgn_state_desc' => 20,'invalid_numeric' => 21,'invalid_numblank' => 22,0);
 
EXPORT MakeFT_invalid_corp_key(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'-0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_corp_key(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'-0123456789'))),~(LENGTH(TRIM(s)) >= 4));
EXPORT InValidMessageFT_invalid_corp_key(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('-0123456789'),SALT34.HygieneErrors.NotLength('4..'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_vendor(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_vendor(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['20']);
EXPORT InValidMessageFT_invalid_corp_vendor(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('20'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state_origin(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state_origin(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['KS']);
EXPORT InValidMessageFT_invalid_state_origin(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('KS'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT34.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLength('1..'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_pastDate(s)>0);
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_future_date(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_future_date(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_GeneralDate(s)>0);
EXPORT InValidMessageFT_invalid_future_date(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.CustomFail('Scrubs.fn_valid_GeneralDate'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_charter_nbr(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_charter_nbr(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_charter_nbr(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.NotLength('1..'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_Y_N(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_Y_N(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['Y','N',' ']);
EXPORT InValidMessageFT_invalid_Y_N(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('Y|N| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_type_cd(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_type_cd(SALT34.StrType s,SALT34.StrType recordorigin) := WHICH(~Scrubs_Corp2_Mapping_KS_Main.Functions.invalid_ln_name_type_cd(s,recordorigin)>0);
EXPORT InValidMessageFT_invalid_type_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_Corp2_Mapping_KS_Main.Functions.invalid_ln_name_type_cd'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_type_desc(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_type_desc(SALT34.StrType s,SALT34.StrType recordorigin) := WHICH(~Scrubs_Corp2_Mapping_KS_Main.Functions.invalid_ln_name_type_desc(s,recordorigin)>0);
EXPORT InValidMessageFT_invalid_type_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_Corp2_Mapping_KS_Main.Functions.invalid_ln_name_type_desc'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_addr_type_cd(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_addr_type_cd(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['B',' '],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_addr_type_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('B| '),SALT34.HygieneErrors.NotLength('1,0'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_addr_type_desc(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_addr_type_desc(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['BUSINESS',' ']);
EXPORT InValidMessageFT_invalid_addr_type_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('BUSINESS| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fed_tax_id(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' -0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_fed_tax_id(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' -0123456789'))));
EXPORT InValidMessageFT_invalid_fed_tax_id(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars(' -0123456789'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_term_exist_cd(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_term_exist_cd(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['D','P',' ']);
EXPORT InValidMessageFT_invalid_term_exist_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('D|P| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_for_dom_ind(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_for_dom_ind(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['F','D',' ']);
EXPORT InValidMessageFT_invalid_for_dom_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('F|D| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_recordorigin(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_recordorigin(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['C','T']);
EXPORT InValidMessageFT_invalid_recordorigin(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('C|T'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_status(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_status(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['EN','NN',' ']);
EXPORT InValidMessageFT_invalid_status(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('EN|NN| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_org_structure_cd(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_org_structure_cd(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_org_structure_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphablank(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphablank(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_alphablank(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_forgn_state_desc(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_forgn_state_desc(SALT34.StrType s) := WHICH(~Scrubs_Corp2_Mapping_KS_Main.Functions.invalid_forgn_state_desc(s)>0);
EXPORT InValidMessageFT_invalid_forgn_state_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_Corp2_Mapping_KS_Main.Functions.invalid_forgn_state_desc'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numblank(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numblank(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_numblank(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.NotLength('0,1..'),SALT34.HygieneErrors.Good);
 
EXPORT SALT34.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_key','corp_supp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_orig_sos_charter_nbr','corp_legal_name','corp_ln_name_type_cd','corp_ln_name_type_desc','corp_supp_nbr','corp_name_comment','corp_address1_type_cd','corp_address1_type_desc','corp_address1_line1','corp_address1_line2','corp_address1_line3','corp_address1_effective_date','corp_address2_type_cd','corp_address2_type_desc','corp_address2_line1','corp_address2_line2','corp_address2_line3','corp_address2_effective_date','corp_phone_number','corp_phone_number_type_cd','corp_phone_number_type_desc','corp_fax_nbr','corp_email_address','corp_web_address','corp_filing_reference_nbr','corp_filing_date','corp_filing_cd','corp_filing_desc','corp_status_cd','corp_status_desc','corp_inc_state','corp_inc_county','corp_inc_date','corp_anniversary_month','corp_fed_tax_id','corp_state_tax_id','corp_term_exist_cd','corp_term_exist_exp','corp_term_exist_desc','corp_foreign_domestic_ind','corp_forgn_state_cd','corp_forgn_state_desc','corp_forgn_sos_charter_nbr','corp_forgn_date','corp_forgn_fed_tax_id','corp_forgn_state_tax_id','corp_forgn_term_exist_cd','corp_forgn_term_exist_exp','corp_forgn_term_exist_desc','corp_orig_org_structure_cd','corp_orig_org_structure_desc','corp_for_profit_ind','corp_public_or_private_ind','corp_sic_code','corp_naic_code','corp_orig_bus_type_cd','corp_orig_bus_type_desc','corp_entity_desc','corp_certificate_nbr','corp_internal_nbr','corp_previous_nbr','corp_microfilm_nbr','corp_amendments_filed','corp_acts','corp_partnership_ind','corp_mfg_ind','corp_addl_info','corp_taxes','corp_franchise_taxes','corp_tax_program_cd','corp_tax_program_desc','corp_ra_full_name','corp_ra_fname','corp_ra_mname','corp_ra_lname','corp_ra_suffix','corp_ra_title_cd','corp_ra_title_desc','corp_ra_fein','corp_ra_ssn','corp_ra_dob','corp_ra_effective_date','corp_ra_resign_date','corp_ra_no_comp','corp_ra_no_comp_igs','corp_ra_addl_info','corp_ra_address_type_cd','corp_ra_address_type_desc','corp_ra_address_line1','corp_ra_address_line2','corp_ra_address_line3','corp_ra_phone_number','corp_ra_phone_number_type_cd','corp_ra_phone_number_type_desc','corp_ra_fax_nbr','corp_ra_email_address','corp_ra_web_address','corp_prep_addr1_line1','corp_prep_addr1_last_line','corp_prep_addr2_line1','corp_prep_addr2_last_line','ra_prep_addr_line1','ra_prep_addr_last_line','cont_filing_reference_nbr','cont_filing_date','cont_filing_cd','cont_filing_desc','cont_type_cd','cont_type_desc','cont_full_name','cont_fname','cont_mname','cont_lname','cont_suffix','cont_title1_desc','cont_title2_desc','cont_title3_desc','cont_title4_desc','cont_title5_desc','cont_fein','cont_ssn','cont_dob','cont_status_cd','cont_status_desc','cont_effective_date','cont_effective_cd','cont_effective_desc','cont_addl_info','cont_address_type_cd','cont_address_type_desc','cont_address_line1','cont_address_line2','cont_address_line3','cont_address_effective_date','cont_address_county','cont_phone_number','cont_phone_number_type_cd','cont_phone_number_type_desc','cont_fax_nbr','cont_email_address','cont_web_address','corp_acres','corp_action','corp_action_date','corp_action_employment_security_approval_date','corp_action_pending_code','corp_action_pending_description','corp_action_statement_of_intent_date','corp_action_tax_dept_approval_date','corp_acts2','corp_acts3','corp_additional_principals','corp_address_office_type','corp_agent_commercial','corp_agent_country','corp_agent_county','corp_agent_status_cd','corp_agent_status_desc','corp_agent_id','corp_agent_assign_date','corp_agriculture_flag','corp_authorized_partners','corp_cmt','corp_consent_flag_for_protected_name','corp_converted','corp_converted_from','corp_country_of_formation','corp_date_of_organization_meeting','corp_delayed_effective_date','corp_directors_from_to','corp_dissolved_date','corp_farm_exemptions','corp_farm_qual_date','corp_farm_status_cd','corp_farm_status_desc','corp_farm_status_date','corp_fiscal_year_month','corp_foreign_fiduciary_capacity_in_state','corp_governing_statute','corp_hasmembers','corp_hasvestedmanagers','corp_home_incorporated_county','corp_home_state_name','corp_is_professional','corp_isnonprofitirsapproved','corp_last_renewal_date','corp_last_renewal_year','corp_license_type','corp_llc_managed_cd','corp_llc_managed_desc','corp_management_description','corp_management_type','corp_manager_managed','corp_merged_corporation_id','corp_merged_fein','corp_merger_allowed_flag','corp_merger_date','corp_merger_description','corp_merger_effective_date','corp_merger_id','corp_merger_indicator','corp_merger_name','corp_merger_type_converted_to_code','corp_merger_type_converted_to_description','corp_naics_description','corp_name_effective_date','corp_name_reservation_date','corp_name_reservation_expiration_date','corp_name_reservation_number','corp_name_reservation_type','corp_name_status_cd','corp_name_status_date','corp_name_status_description','corp_nonprofitirsapprovedpurpose','corp_nonprofitsolicitdonations','corp_number_of_amendments','corp_number_of_initial_llc_members','corp_number_of_partners','corp_operatingagreement','corp_opt_in_llc_act_description','corp_opt_in_llc_act_ind','corp_organizational_comments','corp_original_business_type','corp_partner_contributions_total','corp_partner_terms','corp_percentage_voters_required_to_approve_amendments','corp_profession','corp_province','corp_public_mutual_corporation','corp_purpose','corp_ra_required_flag','corp_registered_counties','corp_regulated_ind','corp_renewal_date','corp_standing_other','corp_survivor_corporation_id','corp_tax_base','corp_tax_standing','corp_termination_code','corp_termination_description','corp_termination_date','corp_trademark_classification_number','corp_trademark_first_use_date','corp_trademark_first_use_date_in_state','corp_trademark_business_mark_type','corp_trademark_cancelled_date','corp_trademark_class_description1','corp_trademark_class_description2','corp_trademark_class_description3','corp_trademark_class_description4','corp_trademark_class_description5','corp_trademark_class_description6','corp_trademark_disclaimer1','corp_trademark_disclaimer2','corp_trademark_expiration_date','corp_trademark_filing_date','corp_trademark_keywords','corp_trademark_logo','corp_trademark_name_expiration_date','corp_trademark_number','corp_trademark_renewal_date','corp_trademark_status','corp_trademark_used_1','corp_trademark_used_2','corp_trademark_used_3','cont_owner_percentage','cont_country','cont_country_mailing','cont_nondislosure','cont_prep_addr_line1','cont_prep_addr_last_line','recordorigin');
EXPORT FieldNum(SALT34.StrType fn) := CASE(fn,'dt_vendor_first_reported' => 0,'dt_vendor_last_reported' => 1,'dt_first_seen' => 2,'dt_last_seen' => 3,'corp_ra_dt_first_seen' => 4,'corp_ra_dt_last_seen' => 5,'corp_key' => 6,'corp_supp_key' => 7,'corp_vendor' => 8,'corp_vendor_county' => 9,'corp_vendor_subcode' => 10,'corp_state_origin' => 11,'corp_process_date' => 12,'corp_orig_sos_charter_nbr' => 13,'corp_legal_name' => 14,'corp_ln_name_type_cd' => 15,'corp_ln_name_type_desc' => 16,'corp_supp_nbr' => 17,'corp_name_comment' => 18,'corp_address1_type_cd' => 19,'corp_address1_type_desc' => 20,'corp_address1_line1' => 21,'corp_address1_line2' => 22,'corp_address1_line3' => 23,'corp_address1_effective_date' => 24,'corp_address2_type_cd' => 25,'corp_address2_type_desc' => 26,'corp_address2_line1' => 27,'corp_address2_line2' => 28,'corp_address2_line3' => 29,'corp_address2_effective_date' => 30,'corp_phone_number' => 31,'corp_phone_number_type_cd' => 32,'corp_phone_number_type_desc' => 33,'corp_fax_nbr' => 34,'corp_email_address' => 35,'corp_web_address' => 36,'corp_filing_reference_nbr' => 37,'corp_filing_date' => 38,'corp_filing_cd' => 39,'corp_filing_desc' => 40,'corp_status_cd' => 41,'corp_status_desc' => 42,'corp_inc_state' => 43,'corp_inc_county' => 44,'corp_inc_date' => 45,'corp_anniversary_month' => 46,'corp_fed_tax_id' => 47,'corp_state_tax_id' => 48,'corp_term_exist_cd' => 49,'corp_term_exist_exp' => 50,'corp_term_exist_desc' => 51,'corp_foreign_domestic_ind' => 52,'corp_forgn_state_cd' => 53,'corp_forgn_state_desc' => 54,'corp_forgn_sos_charter_nbr' => 55,'corp_forgn_date' => 56,'corp_forgn_fed_tax_id' => 57,'corp_forgn_state_tax_id' => 58,'corp_forgn_term_exist_cd' => 59,'corp_forgn_term_exist_exp' => 60,'corp_forgn_term_exist_desc' => 61,'corp_orig_org_structure_cd' => 62,'corp_orig_org_structure_desc' => 63,'corp_for_profit_ind' => 64,'corp_public_or_private_ind' => 65,'corp_sic_code' => 66,'corp_naic_code' => 67,'corp_orig_bus_type_cd' => 68,'corp_orig_bus_type_desc' => 69,'corp_entity_desc' => 70,'corp_certificate_nbr' => 71,'corp_internal_nbr' => 72,'corp_previous_nbr' => 73,'corp_microfilm_nbr' => 74,'corp_amendments_filed' => 75,'corp_acts' => 76,'corp_partnership_ind' => 77,'corp_mfg_ind' => 78,'corp_addl_info' => 79,'corp_taxes' => 80,'corp_franchise_taxes' => 81,'corp_tax_program_cd' => 82,'corp_tax_program_desc' => 83,'corp_ra_full_name' => 84,'corp_ra_fname' => 85,'corp_ra_mname' => 86,'corp_ra_lname' => 87,'corp_ra_suffix' => 88,'corp_ra_title_cd' => 89,'corp_ra_title_desc' => 90,'corp_ra_fein' => 91,'corp_ra_ssn' => 92,'corp_ra_dob' => 93,'corp_ra_effective_date' => 94,'corp_ra_resign_date' => 95,'corp_ra_no_comp' => 96,'corp_ra_no_comp_igs' => 97,'corp_ra_addl_info' => 98,'corp_ra_address_type_cd' => 99,'corp_ra_address_type_desc' => 100,'corp_ra_address_line1' => 101,'corp_ra_address_line2' => 102,'corp_ra_address_line3' => 103,'corp_ra_phone_number' => 104,'corp_ra_phone_number_type_cd' => 105,'corp_ra_phone_number_type_desc' => 106,'corp_ra_fax_nbr' => 107,'corp_ra_email_address' => 108,'corp_ra_web_address' => 109,'corp_prep_addr1_line1' => 110,'corp_prep_addr1_last_line' => 111,'corp_prep_addr2_line1' => 112,'corp_prep_addr2_last_line' => 113,'ra_prep_addr_line1' => 114,'ra_prep_addr_last_line' => 115,'cont_filing_reference_nbr' => 116,'cont_filing_date' => 117,'cont_filing_cd' => 118,'cont_filing_desc' => 119,'cont_type_cd' => 120,'cont_type_desc' => 121,'cont_full_name' => 122,'cont_fname' => 123,'cont_mname' => 124,'cont_lname' => 125,'cont_suffix' => 126,'cont_title1_desc' => 127,'cont_title2_desc' => 128,'cont_title3_desc' => 129,'cont_title4_desc' => 130,'cont_title5_desc' => 131,'cont_fein' => 132,'cont_ssn' => 133,'cont_dob' => 134,'cont_status_cd' => 135,'cont_status_desc' => 136,'cont_effective_date' => 137,'cont_effective_cd' => 138,'cont_effective_desc' => 139,'cont_addl_info' => 140,'cont_address_type_cd' => 141,'cont_address_type_desc' => 142,'cont_address_line1' => 143,'cont_address_line2' => 144,'cont_address_line3' => 145,'cont_address_effective_date' => 146,'cont_address_county' => 147,'cont_phone_number' => 148,'cont_phone_number_type_cd' => 149,'cont_phone_number_type_desc' => 150,'cont_fax_nbr' => 151,'cont_email_address' => 152,'cont_web_address' => 153,'corp_acres' => 154,'corp_action' => 155,'corp_action_date' => 156,'corp_action_employment_security_approval_date' => 157,'corp_action_pending_code' => 158,'corp_action_pending_description' => 159,'corp_action_statement_of_intent_date' => 160,'corp_action_tax_dept_approval_date' => 161,'corp_acts2' => 162,'corp_acts3' => 163,'corp_additional_principals' => 164,'corp_address_office_type' => 165,'corp_agent_commercial' => 166,'corp_agent_country' => 167,'corp_agent_county' => 168,'corp_agent_status_cd' => 169,'corp_agent_status_desc' => 170,'corp_agent_id' => 171,'corp_agent_assign_date' => 172,'corp_agriculture_flag' => 173,'corp_authorized_partners' => 174,'corp_cmt' => 175,'corp_consent_flag_for_protected_name' => 176,'corp_converted' => 177,'corp_converted_from' => 178,'corp_country_of_formation' => 179,'corp_date_of_organization_meeting' => 180,'corp_delayed_effective_date' => 181,'corp_directors_from_to' => 182,'corp_dissolved_date' => 183,'corp_farm_exemptions' => 184,'corp_farm_qual_date' => 185,'corp_farm_status_cd' => 186,'corp_farm_status_desc' => 187,'corp_farm_status_date' => 188,'corp_fiscal_year_month' => 189,'corp_foreign_fiduciary_capacity_in_state' => 190,'corp_governing_statute' => 191,'corp_hasmembers' => 192,'corp_hasvestedmanagers' => 193,'corp_home_incorporated_county' => 194,'corp_home_state_name' => 195,'corp_is_professional' => 196,'corp_isnonprofitirsapproved' => 197,'corp_last_renewal_date' => 198,'corp_last_renewal_year' => 199,'corp_license_type' => 200,'corp_llc_managed_cd' => 201,'corp_llc_managed_desc' => 202,'corp_management_description' => 203,'corp_management_type' => 204,'corp_manager_managed' => 205,'corp_merged_corporation_id' => 206,'corp_merged_fein' => 207,'corp_merger_allowed_flag' => 208,'corp_merger_date' => 209,'corp_merger_description' => 210,'corp_merger_effective_date' => 211,'corp_merger_id' => 212,'corp_merger_indicator' => 213,'corp_merger_name' => 214,'corp_merger_type_converted_to_code' => 215,'corp_merger_type_converted_to_description' => 216,'corp_naics_description' => 217,'corp_name_effective_date' => 218,'corp_name_reservation_date' => 219,'corp_name_reservation_expiration_date' => 220,'corp_name_reservation_number' => 221,'corp_name_reservation_type' => 222,'corp_name_status_cd' => 223,'corp_name_status_date' => 224,'corp_name_status_description' => 225,'corp_nonprofitirsapprovedpurpose' => 226,'corp_nonprofitsolicitdonations' => 227,'corp_number_of_amendments' => 228,'corp_number_of_initial_llc_members' => 229,'corp_number_of_partners' => 230,'corp_operatingagreement' => 231,'corp_opt_in_llc_act_description' => 232,'corp_opt_in_llc_act_ind' => 233,'corp_organizational_comments' => 234,'corp_original_business_type' => 235,'corp_partner_contributions_total' => 236,'corp_partner_terms' => 237,'corp_percentage_voters_required_to_approve_amendments' => 238,'corp_profession' => 239,'corp_province' => 240,'corp_public_mutual_corporation' => 241,'corp_purpose' => 242,'corp_ra_required_flag' => 243,'corp_registered_counties' => 244,'corp_regulated_ind' => 245,'corp_renewal_date' => 246,'corp_standing_other' => 247,'corp_survivor_corporation_id' => 248,'corp_tax_base' => 249,'corp_tax_standing' => 250,'corp_termination_code' => 251,'corp_termination_description' => 252,'corp_termination_date' => 253,'corp_trademark_classification_number' => 254,'corp_trademark_first_use_date' => 255,'corp_trademark_first_use_date_in_state' => 256,'corp_trademark_business_mark_type' => 257,'corp_trademark_cancelled_date' => 258,'corp_trademark_class_description1' => 259,'corp_trademark_class_description2' => 260,'corp_trademark_class_description3' => 261,'corp_trademark_class_description4' => 262,'corp_trademark_class_description5' => 263,'corp_trademark_class_description6' => 264,'corp_trademark_disclaimer1' => 265,'corp_trademark_disclaimer2' => 266,'corp_trademark_expiration_date' => 267,'corp_trademark_filing_date' => 268,'corp_trademark_keywords' => 269,'corp_trademark_logo' => 270,'corp_trademark_name_expiration_date' => 271,'corp_trademark_number' => 272,'corp_trademark_renewal_date' => 273,'corp_trademark_status' => 274,'corp_trademark_used_1' => 275,'corp_trademark_used_2' => 276,'corp_trademark_used_3' => 277,'cont_owner_percentage' => 278,'cont_country' => 279,'cont_country_mailing' => 280,'cont_nondislosure' => 281,'cont_prep_addr_line1' => 282,'cont_prep_addr_last_line' => 283,'recordorigin' => 284,0);
 
//Individual field level validation
 
EXPORT Make_dt_vendor_first_reported(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_vendor_first_reported(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_vendor_last_reported(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dt_first_seen(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_first_seen(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dt_last_seen(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_last_seen(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_ra_dt_first_seen(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_ra_dt_first_seen(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_ra_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_ra_dt_last_seen(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_ra_dt_last_seen(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_ra_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_key(SALT34.StrType s0) := MakeFT_invalid_corp_key(s0);
EXPORT InValid_corp_key(SALT34.StrType s) := InValidFT_invalid_corp_key(s);
EXPORT InValidMessage_corp_key(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_key(wh);
 
EXPORT Make_corp_supp_key(SALT34.StrType s0) := s0;
EXPORT InValid_corp_supp_key(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_supp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_vendor(SALT34.StrType s0) := MakeFT_invalid_corp_vendor(s0);
EXPORT InValid_corp_vendor(SALT34.StrType s) := InValidFT_invalid_corp_vendor(s);
EXPORT InValidMessage_corp_vendor(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_vendor(wh);
 
EXPORT Make_corp_vendor_county(SALT34.StrType s0) := s0;
EXPORT InValid_corp_vendor_county(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_vendor_county(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_vendor_subcode(SALT34.StrType s0) := s0;
EXPORT InValid_corp_vendor_subcode(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_vendor_subcode(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_state_origin(SALT34.StrType s0) := MakeFT_invalid_state_origin(s0);
EXPORT InValid_corp_state_origin(SALT34.StrType s) := InValidFT_invalid_state_origin(s);
EXPORT InValidMessage_corp_state_origin(UNSIGNED1 wh) := InValidMessageFT_invalid_state_origin(wh);
 
EXPORT Make_corp_process_date(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_process_date(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_orig_sos_charter_nbr(SALT34.StrType s0) := MakeFT_invalid_charter_nbr(s0);
EXPORT InValid_corp_orig_sos_charter_nbr(SALT34.StrType s) := InValidFT_invalid_charter_nbr(s);
EXPORT InValidMessage_corp_orig_sos_charter_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_charter_nbr(wh);
 
EXPORT Make_corp_legal_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_corp_legal_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_corp_legal_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_corp_ln_name_type_cd(SALT34.StrType s0) := MakeFT_invalid_type_cd(s0);
EXPORT InValid_corp_ln_name_type_cd(SALT34.StrType s,SALT34.StrType recordorigin) := InValidFT_invalid_type_cd(s,recordorigin);
EXPORT InValidMessage_corp_ln_name_type_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_type_cd(wh);
 
EXPORT Make_corp_ln_name_type_desc(SALT34.StrType s0) := MakeFT_invalid_type_desc(s0);
EXPORT InValid_corp_ln_name_type_desc(SALT34.StrType s,SALT34.StrType recordorigin) := InValidFT_invalid_type_desc(s,recordorigin);
EXPORT InValidMessage_corp_ln_name_type_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_type_desc(wh);
 
EXPORT Make_corp_supp_nbr(SALT34.StrType s0) := s0;
EXPORT InValid_corp_supp_nbr(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_supp_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_name_comment(SALT34.StrType s0) := s0;
EXPORT InValid_corp_name_comment(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_name_comment(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address1_type_cd(SALT34.StrType s0) := MakeFT_invalid_addr_type_cd(s0);
EXPORT InValid_corp_address1_type_cd(SALT34.StrType s) := InValidFT_invalid_addr_type_cd(s);
EXPORT InValidMessage_corp_address1_type_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_addr_type_cd(wh);
 
EXPORT Make_corp_address1_type_desc(SALT34.StrType s0) := MakeFT_invalid_addr_type_desc(s0);
EXPORT InValid_corp_address1_type_desc(SALT34.StrType s) := InValidFT_invalid_addr_type_desc(s);
EXPORT InValidMessage_corp_address1_type_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_addr_type_desc(wh);
 
EXPORT Make_corp_address1_line1(SALT34.StrType s0) := s0;
EXPORT InValid_corp_address1_line1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_address1_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address1_line2(SALT34.StrType s0) := s0;
EXPORT InValid_corp_address1_line2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_address1_line2(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address1_line3(SALT34.StrType s0) := s0;
EXPORT InValid_corp_address1_line3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_address1_line3(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address1_effective_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_address1_effective_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_address1_effective_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address2_type_cd(SALT34.StrType s0) := s0;
EXPORT InValid_corp_address2_type_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_address2_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address2_type_desc(SALT34.StrType s0) := s0;
EXPORT InValid_corp_address2_type_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_address2_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address2_line1(SALT34.StrType s0) := s0;
EXPORT InValid_corp_address2_line1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_address2_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address2_line2(SALT34.StrType s0) := s0;
EXPORT InValid_corp_address2_line2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_address2_line2(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address2_line3(SALT34.StrType s0) := s0;
EXPORT InValid_corp_address2_line3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_address2_line3(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address2_effective_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_address2_effective_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_address2_effective_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_phone_number(SALT34.StrType s0) := s0;
EXPORT InValid_corp_phone_number(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_phone_number(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_phone_number_type_cd(SALT34.StrType s0) := s0;
EXPORT InValid_corp_phone_number_type_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_phone_number_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_phone_number_type_desc(SALT34.StrType s0) := s0;
EXPORT InValid_corp_phone_number_type_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_phone_number_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_fax_nbr(SALT34.StrType s0) := s0;
EXPORT InValid_corp_fax_nbr(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_fax_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_email_address(SALT34.StrType s0) := s0;
EXPORT InValid_corp_email_address(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_email_address(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_web_address(SALT34.StrType s0) := s0;
EXPORT InValid_corp_web_address(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_web_address(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_filing_reference_nbr(SALT34.StrType s0) := s0;
EXPORT InValid_corp_filing_reference_nbr(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_filing_reference_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_filing_date(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_filing_date(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_filing_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_filing_cd(SALT34.StrType s0) := s0;
EXPORT InValid_corp_filing_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_filing_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_filing_desc(SALT34.StrType s0) := s0;
EXPORT InValid_corp_filing_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_filing_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_status_cd(SALT34.StrType s0) := s0;
EXPORT InValid_corp_status_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_status_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_status_desc(SALT34.StrType s0) := s0;
EXPORT InValid_corp_status_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_status_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_inc_state(SALT34.StrType s0) := MakeFT_invalid_state_origin(s0);
EXPORT InValid_corp_inc_state(SALT34.StrType s) := InValidFT_invalid_state_origin(s);
EXPORT InValidMessage_corp_inc_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state_origin(wh);
 
EXPORT Make_corp_inc_county(SALT34.StrType s0) := s0;
EXPORT InValid_corp_inc_county(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_inc_county(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_inc_date(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_inc_date(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_inc_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_anniversary_month(SALT34.StrType s0) := s0;
EXPORT InValid_corp_anniversary_month(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_anniversary_month(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_fed_tax_id(SALT34.StrType s0) := MakeFT_invalid_fed_tax_id(s0);
EXPORT InValid_corp_fed_tax_id(SALT34.StrType s) := InValidFT_invalid_fed_tax_id(s);
EXPORT InValidMessage_corp_fed_tax_id(UNSIGNED1 wh) := InValidMessageFT_invalid_fed_tax_id(wh);
 
EXPORT Make_corp_state_tax_id(SALT34.StrType s0) := s0;
EXPORT InValid_corp_state_tax_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_state_tax_id(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_term_exist_cd(SALT34.StrType s0) := MakeFT_invalid_term_exist_cd(s0);
EXPORT InValid_corp_term_exist_cd(SALT34.StrType s) := InValidFT_invalid_term_exist_cd(s);
EXPORT InValidMessage_corp_term_exist_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_term_exist_cd(wh);
 
EXPORT Make_corp_term_exist_exp(SALT34.StrType s0) := MakeFT_invalid_numblank(s0);
EXPORT InValid_corp_term_exist_exp(SALT34.StrType s) := InValidFT_invalid_numblank(s);
EXPORT InValidMessage_corp_term_exist_exp(UNSIGNED1 wh) := InValidMessageFT_invalid_numblank(wh);
 
EXPORT Make_corp_term_exist_desc(SALT34.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_corp_term_exist_desc(SALT34.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_corp_term_exist_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_corp_foreign_domestic_ind(SALT34.StrType s0) := MakeFT_invalid_for_dom_ind(s0);
EXPORT InValid_corp_foreign_domestic_ind(SALT34.StrType s) := InValidFT_invalid_for_dom_ind(s);
EXPORT InValidMessage_corp_foreign_domestic_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_for_dom_ind(wh);
 
EXPORT Make_corp_forgn_state_cd(SALT34.StrType s0) := s0;
EXPORT InValid_corp_forgn_state_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_forgn_state_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_forgn_state_desc(SALT34.StrType s0) := MakeFT_invalid_forgn_state_desc(s0);
EXPORT InValid_corp_forgn_state_desc(SALT34.StrType s) := InValidFT_invalid_forgn_state_desc(s);
EXPORT InValidMessage_corp_forgn_state_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_forgn_state_desc(wh);
 
EXPORT Make_corp_forgn_sos_charter_nbr(SALT34.StrType s0) := s0;
EXPORT InValid_corp_forgn_sos_charter_nbr(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_forgn_sos_charter_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_forgn_date(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_forgn_date(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_forgn_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_forgn_fed_tax_id(SALT34.StrType s0) := s0;
EXPORT InValid_corp_forgn_fed_tax_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_forgn_fed_tax_id(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_forgn_state_tax_id(SALT34.StrType s0) := s0;
EXPORT InValid_corp_forgn_state_tax_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_forgn_state_tax_id(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_forgn_term_exist_cd(SALT34.StrType s0) := s0;
EXPORT InValid_corp_forgn_term_exist_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_forgn_term_exist_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_forgn_term_exist_exp(SALT34.StrType s0) := s0;
EXPORT InValid_corp_forgn_term_exist_exp(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_forgn_term_exist_exp(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_forgn_term_exist_desc(SALT34.StrType s0) := s0;
EXPORT InValid_corp_forgn_term_exist_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_forgn_term_exist_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_orig_org_structure_cd(SALT34.StrType s0) := MakeFT_invalid_org_structure_cd(s0);
EXPORT InValid_corp_orig_org_structure_cd(SALT34.StrType s) := InValidFT_invalid_org_structure_cd(s);
EXPORT InValidMessage_corp_orig_org_structure_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_org_structure_cd(wh);
 
EXPORT Make_corp_orig_org_structure_desc(SALT34.StrType s0) := s0;
EXPORT InValid_corp_orig_org_structure_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_orig_org_structure_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_for_profit_ind(SALT34.StrType s0) := MakeFT_invalid_Y_N(s0);
EXPORT InValid_corp_for_profit_ind(SALT34.StrType s) := InValidFT_invalid_Y_N(s);
EXPORT InValidMessage_corp_for_profit_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_Y_N(wh);
 
EXPORT Make_corp_public_or_private_ind(SALT34.StrType s0) := s0;
EXPORT InValid_corp_public_or_private_ind(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_public_or_private_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_sic_code(SALT34.StrType s0) := s0;
EXPORT InValid_corp_sic_code(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_sic_code(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_naic_code(SALT34.StrType s0) := s0;
EXPORT InValid_corp_naic_code(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_naic_code(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_orig_bus_type_cd(SALT34.StrType s0) := s0;
EXPORT InValid_corp_orig_bus_type_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_orig_bus_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_orig_bus_type_desc(SALT34.StrType s0) := s0;
EXPORT InValid_corp_orig_bus_type_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_orig_bus_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_entity_desc(SALT34.StrType s0) := s0;
EXPORT InValid_corp_entity_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_entity_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_certificate_nbr(SALT34.StrType s0) := s0;
EXPORT InValid_corp_certificate_nbr(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_certificate_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_internal_nbr(SALT34.StrType s0) := s0;
EXPORT InValid_corp_internal_nbr(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_internal_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_previous_nbr(SALT34.StrType s0) := s0;
EXPORT InValid_corp_previous_nbr(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_previous_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_microfilm_nbr(SALT34.StrType s0) := s0;
EXPORT InValid_corp_microfilm_nbr(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_microfilm_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_amendments_filed(SALT34.StrType s0) := s0;
EXPORT InValid_corp_amendments_filed(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_amendments_filed(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_acts(SALT34.StrType s0) := s0;
EXPORT InValid_corp_acts(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_acts(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_partnership_ind(SALT34.StrType s0) := s0;
EXPORT InValid_corp_partnership_ind(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_partnership_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_mfg_ind(SALT34.StrType s0) := s0;
EXPORT InValid_corp_mfg_ind(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_mfg_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addl_info(SALT34.StrType s0) := s0;
EXPORT InValid_corp_addl_info(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_addl_info(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_taxes(SALT34.StrType s0) := s0;
EXPORT InValid_corp_taxes(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_taxes(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_franchise_taxes(SALT34.StrType s0) := s0;
EXPORT InValid_corp_franchise_taxes(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_franchise_taxes(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_tax_program_cd(SALT34.StrType s0) := s0;
EXPORT InValid_corp_tax_program_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_tax_program_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_tax_program_desc(SALT34.StrType s0) := s0;
EXPORT InValid_corp_tax_program_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_tax_program_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_full_name(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_full_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_full_name(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_fname(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_fname(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_mname(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_mname(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_lname(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_lname(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_suffix(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_suffix(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_title_cd(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_title_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_title_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_title_desc(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_title_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_title_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_fein(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_fein(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_ssn(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_ssn(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_dob(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_dob(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_dob(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_effective_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_effective_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_effective_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_resign_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_resign_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_resign_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_no_comp(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_no_comp(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_no_comp(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_no_comp_igs(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_no_comp_igs(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_no_comp_igs(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_addl_info(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_addl_info(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_addl_info(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_address_type_cd(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_address_type_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_address_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_address_type_desc(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_address_type_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_address_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_address_line1(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_address_line1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_address_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_address_line2(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_address_line2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_address_line2(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_address_line3(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_address_line3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_address_line3(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_phone_number(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_phone_number(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_phone_number(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_phone_number_type_cd(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_phone_number_type_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_phone_number_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_phone_number_type_desc(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_phone_number_type_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_phone_number_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_fax_nbr(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_fax_nbr(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_fax_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_email_address(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_email_address(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_email_address(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_web_address(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_web_address(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_web_address(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_prep_addr1_line1(SALT34.StrType s0) := s0;
EXPORT InValid_corp_prep_addr1_line1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_prep_addr1_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_prep_addr1_last_line(SALT34.StrType s0) := s0;
EXPORT InValid_corp_prep_addr1_last_line(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_prep_addr1_last_line(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_prep_addr2_line1(SALT34.StrType s0) := s0;
EXPORT InValid_corp_prep_addr2_line1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_prep_addr2_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_prep_addr2_last_line(SALT34.StrType s0) := s0;
EXPORT InValid_corp_prep_addr2_last_line(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_prep_addr2_last_line(UNSIGNED1 wh) := '';
 
EXPORT Make_ra_prep_addr_line1(SALT34.StrType s0) := s0;
EXPORT InValid_ra_prep_addr_line1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ra_prep_addr_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_ra_prep_addr_last_line(SALT34.StrType s0) := s0;
EXPORT InValid_ra_prep_addr_last_line(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ra_prep_addr_last_line(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_filing_reference_nbr(SALT34.StrType s0) := s0;
EXPORT InValid_cont_filing_reference_nbr(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_filing_reference_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_filing_date(SALT34.StrType s0) := s0;
EXPORT InValid_cont_filing_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_filing_date(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_filing_cd(SALT34.StrType s0) := s0;
EXPORT InValid_cont_filing_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_filing_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_filing_desc(SALT34.StrType s0) := s0;
EXPORT InValid_cont_filing_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_filing_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_type_cd(SALT34.StrType s0) := s0;
EXPORT InValid_cont_type_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_type_desc(SALT34.StrType s0) := s0;
EXPORT InValid_cont_type_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_full_name(SALT34.StrType s0) := s0;
EXPORT InValid_cont_full_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_full_name(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_fname(SALT34.StrType s0) := s0;
EXPORT InValid_cont_fname(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_mname(SALT34.StrType s0) := s0;
EXPORT InValid_cont_mname(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_lname(SALT34.StrType s0) := s0;
EXPORT InValid_cont_lname(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_suffix(SALT34.StrType s0) := s0;
EXPORT InValid_cont_suffix(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_title1_desc(SALT34.StrType s0) := s0;
EXPORT InValid_cont_title1_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_title1_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_title2_desc(SALT34.StrType s0) := s0;
EXPORT InValid_cont_title2_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_title2_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_title3_desc(SALT34.StrType s0) := s0;
EXPORT InValid_cont_title3_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_title3_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_title4_desc(SALT34.StrType s0) := s0;
EXPORT InValid_cont_title4_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_title4_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_title5_desc(SALT34.StrType s0) := s0;
EXPORT InValid_cont_title5_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_title5_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_fein(SALT34.StrType s0) := s0;
EXPORT InValid_cont_fein(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_ssn(SALT34.StrType s0) := s0;
EXPORT InValid_cont_ssn(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_dob(SALT34.StrType s0) := s0;
EXPORT InValid_cont_dob(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_dob(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_status_cd(SALT34.StrType s0) := s0;
EXPORT InValid_cont_status_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_status_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_status_desc(SALT34.StrType s0) := s0;
EXPORT InValid_cont_status_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_status_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_effective_date(SALT34.StrType s0) := s0;
EXPORT InValid_cont_effective_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_effective_date(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_effective_cd(SALT34.StrType s0) := s0;
EXPORT InValid_cont_effective_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_effective_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_effective_desc(SALT34.StrType s0) := s0;
EXPORT InValid_cont_effective_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_effective_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_addl_info(SALT34.StrType s0) := s0;
EXPORT InValid_cont_addl_info(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_addl_info(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_address_type_cd(SALT34.StrType s0) := s0;
EXPORT InValid_cont_address_type_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_address_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_address_type_desc(SALT34.StrType s0) := s0;
EXPORT InValid_cont_address_type_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_address_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_address_line1(SALT34.StrType s0) := s0;
EXPORT InValid_cont_address_line1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_address_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_address_line2(SALT34.StrType s0) := s0;
EXPORT InValid_cont_address_line2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_address_line2(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_address_line3(SALT34.StrType s0) := s0;
EXPORT InValid_cont_address_line3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_address_line3(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_address_effective_date(SALT34.StrType s0) := s0;
EXPORT InValid_cont_address_effective_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_address_effective_date(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_address_county(SALT34.StrType s0) := s0;
EXPORT InValid_cont_address_county(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_address_county(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_phone_number(SALT34.StrType s0) := s0;
EXPORT InValid_cont_phone_number(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_phone_number(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_phone_number_type_cd(SALT34.StrType s0) := s0;
EXPORT InValid_cont_phone_number_type_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_phone_number_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_phone_number_type_desc(SALT34.StrType s0) := s0;
EXPORT InValid_cont_phone_number_type_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_phone_number_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_fax_nbr(SALT34.StrType s0) := s0;
EXPORT InValid_cont_fax_nbr(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_fax_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_email_address(SALT34.StrType s0) := s0;
EXPORT InValid_cont_email_address(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_email_address(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_web_address(SALT34.StrType s0) := s0;
EXPORT InValid_cont_web_address(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_web_address(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_acres(SALT34.StrType s0) := s0;
EXPORT InValid_corp_acres(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_acres(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_action(SALT34.StrType s0) := s0;
EXPORT InValid_corp_action(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_action(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_action_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_action_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_action_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_action_employment_security_approval_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_action_employment_security_approval_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_action_employment_security_approval_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_action_pending_code(SALT34.StrType s0) := s0;
EXPORT InValid_corp_action_pending_code(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_action_pending_code(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_action_pending_description(SALT34.StrType s0) := s0;
EXPORT InValid_corp_action_pending_description(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_action_pending_description(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_action_statement_of_intent_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_action_statement_of_intent_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_action_statement_of_intent_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_action_tax_dept_approval_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_action_tax_dept_approval_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_action_tax_dept_approval_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_acts2(SALT34.StrType s0) := s0;
EXPORT InValid_corp_acts2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_acts2(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_acts3(SALT34.StrType s0) := s0;
EXPORT InValid_corp_acts3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_acts3(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_additional_principals(SALT34.StrType s0) := s0;
EXPORT InValid_corp_additional_principals(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_additional_principals(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address_office_type(SALT34.StrType s0) := s0;
EXPORT InValid_corp_address_office_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_address_office_type(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_agent_commercial(SALT34.StrType s0) := s0;
EXPORT InValid_corp_agent_commercial(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_agent_commercial(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_agent_country(SALT34.StrType s0) := s0;
EXPORT InValid_corp_agent_country(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_agent_country(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_agent_county(SALT34.StrType s0) := s0;
EXPORT InValid_corp_agent_county(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_agent_county(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_agent_status_cd(SALT34.StrType s0) := s0;
EXPORT InValid_corp_agent_status_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_agent_status_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_agent_status_desc(SALT34.StrType s0) := s0;
EXPORT InValid_corp_agent_status_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_agent_status_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_agent_id(SALT34.StrType s0) := s0;
EXPORT InValid_corp_agent_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_agent_id(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_agent_assign_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_agent_assign_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_agent_assign_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_agriculture_flag(SALT34.StrType s0) := s0;
EXPORT InValid_corp_agriculture_flag(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_agriculture_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_authorized_partners(SALT34.StrType s0) := s0;
EXPORT InValid_corp_authorized_partners(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_authorized_partners(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_cmt(SALT34.StrType s0) := s0;
EXPORT InValid_corp_cmt(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_cmt(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_consent_flag_for_protected_name(SALT34.StrType s0) := s0;
EXPORT InValid_corp_consent_flag_for_protected_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_consent_flag_for_protected_name(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_converted(SALT34.StrType s0) := s0;
EXPORT InValid_corp_converted(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_converted(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_converted_from(SALT34.StrType s0) := s0;
EXPORT InValid_corp_converted_from(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_converted_from(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_country_of_formation(SALT34.StrType s0) := s0;
EXPORT InValid_corp_country_of_formation(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_country_of_formation(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_date_of_organization_meeting(SALT34.StrType s0) := s0;
EXPORT InValid_corp_date_of_organization_meeting(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_date_of_organization_meeting(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_delayed_effective_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_delayed_effective_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_delayed_effective_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_directors_from_to(SALT34.StrType s0) := s0;
EXPORT InValid_corp_directors_from_to(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_directors_from_to(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_dissolved_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_dissolved_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_dissolved_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_farm_exemptions(SALT34.StrType s0) := s0;
EXPORT InValid_corp_farm_exemptions(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_farm_exemptions(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_farm_qual_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_farm_qual_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_farm_qual_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_farm_status_cd(SALT34.StrType s0) := s0;
EXPORT InValid_corp_farm_status_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_farm_status_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_farm_status_desc(SALT34.StrType s0) := s0;
EXPORT InValid_corp_farm_status_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_farm_status_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_farm_status_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_farm_status_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_farm_status_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_fiscal_year_month(SALT34.StrType s0) := MakeFT_invalid_numblank(s0);
EXPORT InValid_corp_fiscal_year_month(SALT34.StrType s) := InValidFT_invalid_numblank(s);
EXPORT InValidMessage_corp_fiscal_year_month(UNSIGNED1 wh) := InValidMessageFT_invalid_numblank(wh);
 
EXPORT Make_corp_foreign_fiduciary_capacity_in_state(SALT34.StrType s0) := s0;
EXPORT InValid_corp_foreign_fiduciary_capacity_in_state(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_foreign_fiduciary_capacity_in_state(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_governing_statute(SALT34.StrType s0) := s0;
EXPORT InValid_corp_governing_statute(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_governing_statute(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_hasmembers(SALT34.StrType s0) := s0;
EXPORT InValid_corp_hasmembers(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_hasmembers(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_hasvestedmanagers(SALT34.StrType s0) := s0;
EXPORT InValid_corp_hasvestedmanagers(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_hasvestedmanagers(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_home_incorporated_county(SALT34.StrType s0) := s0;
EXPORT InValid_corp_home_incorporated_county(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_home_incorporated_county(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_home_state_name(SALT34.StrType s0) := s0;
EXPORT InValid_corp_home_state_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_home_state_name(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_is_professional(SALT34.StrType s0) := s0;
EXPORT InValid_corp_is_professional(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_is_professional(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_isnonprofitirsapproved(SALT34.StrType s0) := s0;
EXPORT InValid_corp_isnonprofitirsapproved(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_isnonprofitirsapproved(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_last_renewal_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_last_renewal_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_last_renewal_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_last_renewal_year(SALT34.StrType s0) := s0;
EXPORT InValid_corp_last_renewal_year(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_last_renewal_year(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_license_type(SALT34.StrType s0) := s0;
EXPORT InValid_corp_license_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_license_type(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_llc_managed_cd(SALT34.StrType s0) := s0;
EXPORT InValid_corp_llc_managed_cd(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_llc_managed_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_llc_managed_desc(SALT34.StrType s0) := s0;
EXPORT InValid_corp_llc_managed_desc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_llc_managed_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_management_description(SALT34.StrType s0) := s0;
EXPORT InValid_corp_management_description(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_management_description(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_management_type(SALT34.StrType s0) := s0;
EXPORT InValid_corp_management_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_management_type(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_manager_managed(SALT34.StrType s0) := s0;
EXPORT InValid_corp_manager_managed(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_manager_managed(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_merged_corporation_id(SALT34.StrType s0) := s0;
EXPORT InValid_corp_merged_corporation_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_merged_corporation_id(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_merged_fein(SALT34.StrType s0) := s0;
EXPORT InValid_corp_merged_fein(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_merged_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_merger_allowed_flag(SALT34.StrType s0) := s0;
EXPORT InValid_corp_merger_allowed_flag(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_merger_allowed_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_merger_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_merger_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_merger_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_merger_description(SALT34.StrType s0) := s0;
EXPORT InValid_corp_merger_description(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_merger_description(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_merger_effective_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_merger_effective_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_merger_effective_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_merger_id(SALT34.StrType s0) := s0;
EXPORT InValid_corp_merger_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_merger_id(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_merger_indicator(SALT34.StrType s0) := s0;
EXPORT InValid_corp_merger_indicator(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_merger_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_merger_name(SALT34.StrType s0) := s0;
EXPORT InValid_corp_merger_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_merger_name(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_merger_type_converted_to_code(SALT34.StrType s0) := s0;
EXPORT InValid_corp_merger_type_converted_to_code(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_merger_type_converted_to_code(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_merger_type_converted_to_description(SALT34.StrType s0) := s0;
EXPORT InValid_corp_merger_type_converted_to_description(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_merger_type_converted_to_description(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_naics_description(SALT34.StrType s0) := s0;
EXPORT InValid_corp_naics_description(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_naics_description(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_name_effective_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_name_effective_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_name_effective_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_name_reservation_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_name_reservation_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_name_reservation_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_name_reservation_expiration_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_name_reservation_expiration_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_name_reservation_expiration_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_name_reservation_number(SALT34.StrType s0) := s0;
EXPORT InValid_corp_name_reservation_number(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_name_reservation_number(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_name_reservation_type(SALT34.StrType s0) := s0;
EXPORT InValid_corp_name_reservation_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_name_reservation_type(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_name_status_cd(SALT34.StrType s0) := MakeFT_invalid_status(s0);
EXPORT InValid_corp_name_status_cd(SALT34.StrType s) := InValidFT_invalid_status(s);
EXPORT InValidMessage_corp_name_status_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_status(wh);
 
EXPORT Make_corp_name_status_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_name_status_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_name_status_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_name_status_description(SALT34.StrType s0) := s0;
EXPORT InValid_corp_name_status_description(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_name_status_description(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_nonprofitirsapprovedpurpose(SALT34.StrType s0) := s0;
EXPORT InValid_corp_nonprofitirsapprovedpurpose(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_nonprofitirsapprovedpurpose(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_nonprofitsolicitdonations(SALT34.StrType s0) := s0;
EXPORT InValid_corp_nonprofitsolicitdonations(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_nonprofitsolicitdonations(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_number_of_amendments(SALT34.StrType s0) := s0;
EXPORT InValid_corp_number_of_amendments(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_number_of_amendments(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_number_of_initial_llc_members(SALT34.StrType s0) := s0;
EXPORT InValid_corp_number_of_initial_llc_members(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_number_of_initial_llc_members(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_number_of_partners(SALT34.StrType s0) := s0;
EXPORT InValid_corp_number_of_partners(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_number_of_partners(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_operatingagreement(SALT34.StrType s0) := s0;
EXPORT InValid_corp_operatingagreement(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_operatingagreement(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_opt_in_llc_act_description(SALT34.StrType s0) := s0;
EXPORT InValid_corp_opt_in_llc_act_description(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_opt_in_llc_act_description(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_opt_in_llc_act_ind(SALT34.StrType s0) := s0;
EXPORT InValid_corp_opt_in_llc_act_ind(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_opt_in_llc_act_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_organizational_comments(SALT34.StrType s0) := s0;
EXPORT InValid_corp_organizational_comments(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_organizational_comments(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_original_business_type(SALT34.StrType s0) := s0;
EXPORT InValid_corp_original_business_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_original_business_type(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_partner_contributions_total(SALT34.StrType s0) := s0;
EXPORT InValid_corp_partner_contributions_total(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_partner_contributions_total(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_partner_terms(SALT34.StrType s0) := s0;
EXPORT InValid_corp_partner_terms(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_partner_terms(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_percentage_voters_required_to_approve_amendments(SALT34.StrType s0) := s0;
EXPORT InValid_corp_percentage_voters_required_to_approve_amendments(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_percentage_voters_required_to_approve_amendments(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_profession(SALT34.StrType s0) := s0;
EXPORT InValid_corp_profession(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_profession(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_province(SALT34.StrType s0) := s0;
EXPORT InValid_corp_province(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_province(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_public_mutual_corporation(SALT34.StrType s0) := s0;
EXPORT InValid_corp_public_mutual_corporation(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_public_mutual_corporation(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_purpose(SALT34.StrType s0) := s0;
EXPORT InValid_corp_purpose(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_purpose(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_required_flag(SALT34.StrType s0) := s0;
EXPORT InValid_corp_ra_required_flag(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_required_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_registered_counties(SALT34.StrType s0) := s0;
EXPORT InValid_corp_registered_counties(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_registered_counties(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_regulated_ind(SALT34.StrType s0) := s0;
EXPORT InValid_corp_regulated_ind(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_regulated_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_renewal_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_renewal_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_renewal_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_standing_other(SALT34.StrType s0) := s0;
EXPORT InValid_corp_standing_other(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_standing_other(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_survivor_corporation_id(SALT34.StrType s0) := s0;
EXPORT InValid_corp_survivor_corporation_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_survivor_corporation_id(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_tax_base(SALT34.StrType s0) := s0;
EXPORT InValid_corp_tax_base(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_tax_base(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_tax_standing(SALT34.StrType s0) := s0;
EXPORT InValid_corp_tax_standing(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_tax_standing(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_termination_code(SALT34.StrType s0) := s0;
EXPORT InValid_corp_termination_code(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_termination_code(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_termination_description(SALT34.StrType s0) := s0;
EXPORT InValid_corp_termination_description(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_termination_description(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_termination_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_termination_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_termination_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_classification_number(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_classification_number(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_classification_number(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_first_use_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_first_use_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_first_use_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_first_use_date_in_state(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_first_use_date_in_state(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_first_use_date_in_state(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_business_mark_type(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_business_mark_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_business_mark_type(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_cancelled_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_cancelled_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_cancelled_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_class_description1(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_class_description1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_class_description1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_class_description2(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_class_description2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_class_description2(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_class_description3(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_class_description3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_class_description3(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_class_description4(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_class_description4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_class_description4(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_class_description5(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_class_description5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_class_description5(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_class_description6(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_class_description6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_class_description6(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_disclaimer1(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_disclaimer1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_disclaimer1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_disclaimer2(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_disclaimer2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_disclaimer2(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_expiration_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_expiration_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_expiration_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_filing_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_filing_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_filing_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_keywords(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_keywords(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_keywords(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_logo(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_logo(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_logo(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_name_expiration_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_name_expiration_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_name_expiration_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_number(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_number(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_number(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_renewal_date(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_renewal_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_renewal_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_status(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_status(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_status(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_used_1(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_used_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_used_1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_used_2(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_used_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_used_2(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_trademark_used_3(SALT34.StrType s0) := s0;
EXPORT InValid_corp_trademark_used_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corp_trademark_used_3(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_owner_percentage(SALT34.StrType s0) := s0;
EXPORT InValid_cont_owner_percentage(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_owner_percentage(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_country(SALT34.StrType s0) := s0;
EXPORT InValid_cont_country(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_country(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_country_mailing(SALT34.StrType s0) := s0;
EXPORT InValid_cont_country_mailing(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_country_mailing(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_nondislosure(SALT34.StrType s0) := s0;
EXPORT InValid_cont_nondislosure(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_nondislosure(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_prep_addr_line1(SALT34.StrType s0) := s0;
EXPORT InValid_cont_prep_addr_line1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_prep_addr_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_prep_addr_last_line(SALT34.StrType s0) := s0;
EXPORT InValid_cont_prep_addr_last_line(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cont_prep_addr_last_line(UNSIGNED1 wh) := '';
 
EXPORT Make_recordorigin(SALT34.StrType s0) := MakeFT_invalid_recordorigin(s0);
EXPORT InValid_recordorigin(SALT34.StrType s) := InValidFT_invalid_recordorigin(s);
EXPORT InValidMessage_recordorigin(UNSIGNED1 wh) := InValidMessageFT_invalid_recordorigin(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT34,Scrubs_Corp2_Mapping_KS_Main;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_corp_ra_dt_first_seen;
    BOOLEAN Diff_corp_ra_dt_last_seen;
    BOOLEAN Diff_corp_key;
    BOOLEAN Diff_corp_supp_key;
    BOOLEAN Diff_corp_vendor;
    BOOLEAN Diff_corp_vendor_county;
    BOOLEAN Diff_corp_vendor_subcode;
    BOOLEAN Diff_corp_state_origin;
    BOOLEAN Diff_corp_process_date;
    BOOLEAN Diff_corp_orig_sos_charter_nbr;
    BOOLEAN Diff_corp_legal_name;
    BOOLEAN Diff_corp_ln_name_type_cd;
    BOOLEAN Diff_corp_ln_name_type_desc;
    BOOLEAN Diff_corp_supp_nbr;
    BOOLEAN Diff_corp_name_comment;
    BOOLEAN Diff_corp_address1_type_cd;
    BOOLEAN Diff_corp_address1_type_desc;
    BOOLEAN Diff_corp_address1_line1;
    BOOLEAN Diff_corp_address1_line2;
    BOOLEAN Diff_corp_address1_line3;
    BOOLEAN Diff_corp_address1_effective_date;
    BOOLEAN Diff_corp_address2_type_cd;
    BOOLEAN Diff_corp_address2_type_desc;
    BOOLEAN Diff_corp_address2_line1;
    BOOLEAN Diff_corp_address2_line2;
    BOOLEAN Diff_corp_address2_line3;
    BOOLEAN Diff_corp_address2_effective_date;
    BOOLEAN Diff_corp_phone_number;
    BOOLEAN Diff_corp_phone_number_type_cd;
    BOOLEAN Diff_corp_phone_number_type_desc;
    BOOLEAN Diff_corp_fax_nbr;
    BOOLEAN Diff_corp_email_address;
    BOOLEAN Diff_corp_web_address;
    BOOLEAN Diff_corp_filing_reference_nbr;
    BOOLEAN Diff_corp_filing_date;
    BOOLEAN Diff_corp_filing_cd;
    BOOLEAN Diff_corp_filing_desc;
    BOOLEAN Diff_corp_status_cd;
    BOOLEAN Diff_corp_status_desc;
    BOOLEAN Diff_corp_inc_state;
    BOOLEAN Diff_corp_inc_county;
    BOOLEAN Diff_corp_inc_date;
    BOOLEAN Diff_corp_anniversary_month;
    BOOLEAN Diff_corp_fed_tax_id;
    BOOLEAN Diff_corp_state_tax_id;
    BOOLEAN Diff_corp_term_exist_cd;
    BOOLEAN Diff_corp_term_exist_exp;
    BOOLEAN Diff_corp_term_exist_desc;
    BOOLEAN Diff_corp_foreign_domestic_ind;
    BOOLEAN Diff_corp_forgn_state_cd;
    BOOLEAN Diff_corp_forgn_state_desc;
    BOOLEAN Diff_corp_forgn_sos_charter_nbr;
    BOOLEAN Diff_corp_forgn_date;
    BOOLEAN Diff_corp_forgn_fed_tax_id;
    BOOLEAN Diff_corp_forgn_state_tax_id;
    BOOLEAN Diff_corp_forgn_term_exist_cd;
    BOOLEAN Diff_corp_forgn_term_exist_exp;
    BOOLEAN Diff_corp_forgn_term_exist_desc;
    BOOLEAN Diff_corp_orig_org_structure_cd;
    BOOLEAN Diff_corp_orig_org_structure_desc;
    BOOLEAN Diff_corp_for_profit_ind;
    BOOLEAN Diff_corp_public_or_private_ind;
    BOOLEAN Diff_corp_sic_code;
    BOOLEAN Diff_corp_naic_code;
    BOOLEAN Diff_corp_orig_bus_type_cd;
    BOOLEAN Diff_corp_orig_bus_type_desc;
    BOOLEAN Diff_corp_entity_desc;
    BOOLEAN Diff_corp_certificate_nbr;
    BOOLEAN Diff_corp_internal_nbr;
    BOOLEAN Diff_corp_previous_nbr;
    BOOLEAN Diff_corp_microfilm_nbr;
    BOOLEAN Diff_corp_amendments_filed;
    BOOLEAN Diff_corp_acts;
    BOOLEAN Diff_corp_partnership_ind;
    BOOLEAN Diff_corp_mfg_ind;
    BOOLEAN Diff_corp_addl_info;
    BOOLEAN Diff_corp_taxes;
    BOOLEAN Diff_corp_franchise_taxes;
    BOOLEAN Diff_corp_tax_program_cd;
    BOOLEAN Diff_corp_tax_program_desc;
    BOOLEAN Diff_corp_ra_full_name;
    BOOLEAN Diff_corp_ra_fname;
    BOOLEAN Diff_corp_ra_mname;
    BOOLEAN Diff_corp_ra_lname;
    BOOLEAN Diff_corp_ra_suffix;
    BOOLEAN Diff_corp_ra_title_cd;
    BOOLEAN Diff_corp_ra_title_desc;
    BOOLEAN Diff_corp_ra_fein;
    BOOLEAN Diff_corp_ra_ssn;
    BOOLEAN Diff_corp_ra_dob;
    BOOLEAN Diff_corp_ra_effective_date;
    BOOLEAN Diff_corp_ra_resign_date;
    BOOLEAN Diff_corp_ra_no_comp;
    BOOLEAN Diff_corp_ra_no_comp_igs;
    BOOLEAN Diff_corp_ra_addl_info;
    BOOLEAN Diff_corp_ra_address_type_cd;
    BOOLEAN Diff_corp_ra_address_type_desc;
    BOOLEAN Diff_corp_ra_address_line1;
    BOOLEAN Diff_corp_ra_address_line2;
    BOOLEAN Diff_corp_ra_address_line3;
    BOOLEAN Diff_corp_ra_phone_number;
    BOOLEAN Diff_corp_ra_phone_number_type_cd;
    BOOLEAN Diff_corp_ra_phone_number_type_desc;
    BOOLEAN Diff_corp_ra_fax_nbr;
    BOOLEAN Diff_corp_ra_email_address;
    BOOLEAN Diff_corp_ra_web_address;
    BOOLEAN Diff_corp_prep_addr1_line1;
    BOOLEAN Diff_corp_prep_addr1_last_line;
    BOOLEAN Diff_corp_prep_addr2_line1;
    BOOLEAN Diff_corp_prep_addr2_last_line;
    BOOLEAN Diff_ra_prep_addr_line1;
    BOOLEAN Diff_ra_prep_addr_last_line;
    BOOLEAN Diff_cont_filing_reference_nbr;
    BOOLEAN Diff_cont_filing_date;
    BOOLEAN Diff_cont_filing_cd;
    BOOLEAN Diff_cont_filing_desc;
    BOOLEAN Diff_cont_type_cd;
    BOOLEAN Diff_cont_type_desc;
    BOOLEAN Diff_cont_full_name;
    BOOLEAN Diff_cont_fname;
    BOOLEAN Diff_cont_mname;
    BOOLEAN Diff_cont_lname;
    BOOLEAN Diff_cont_suffix;
    BOOLEAN Diff_cont_title1_desc;
    BOOLEAN Diff_cont_title2_desc;
    BOOLEAN Diff_cont_title3_desc;
    BOOLEAN Diff_cont_title4_desc;
    BOOLEAN Diff_cont_title5_desc;
    BOOLEAN Diff_cont_fein;
    BOOLEAN Diff_cont_ssn;
    BOOLEAN Diff_cont_dob;
    BOOLEAN Diff_cont_status_cd;
    BOOLEAN Diff_cont_status_desc;
    BOOLEAN Diff_cont_effective_date;
    BOOLEAN Diff_cont_effective_cd;
    BOOLEAN Diff_cont_effective_desc;
    BOOLEAN Diff_cont_addl_info;
    BOOLEAN Diff_cont_address_type_cd;
    BOOLEAN Diff_cont_address_type_desc;
    BOOLEAN Diff_cont_address_line1;
    BOOLEAN Diff_cont_address_line2;
    BOOLEAN Diff_cont_address_line3;
    BOOLEAN Diff_cont_address_effective_date;
    BOOLEAN Diff_cont_address_county;
    BOOLEAN Diff_cont_phone_number;
    BOOLEAN Diff_cont_phone_number_type_cd;
    BOOLEAN Diff_cont_phone_number_type_desc;
    BOOLEAN Diff_cont_fax_nbr;
    BOOLEAN Diff_cont_email_address;
    BOOLEAN Diff_cont_web_address;
    BOOLEAN Diff_corp_acres;
    BOOLEAN Diff_corp_action;
    BOOLEAN Diff_corp_action_date;
    BOOLEAN Diff_corp_action_employment_security_approval_date;
    BOOLEAN Diff_corp_action_pending_code;
    BOOLEAN Diff_corp_action_pending_description;
    BOOLEAN Diff_corp_action_statement_of_intent_date;
    BOOLEAN Diff_corp_action_tax_dept_approval_date;
    BOOLEAN Diff_corp_acts2;
    BOOLEAN Diff_corp_acts3;
    BOOLEAN Diff_corp_additional_principals;
    BOOLEAN Diff_corp_address_office_type;
    BOOLEAN Diff_corp_agent_commercial;
    BOOLEAN Diff_corp_agent_country;
    BOOLEAN Diff_corp_agent_county;
    BOOLEAN Diff_corp_agent_status_cd;
    BOOLEAN Diff_corp_agent_status_desc;
    BOOLEAN Diff_corp_agent_id;
    BOOLEAN Diff_corp_agent_assign_date;
    BOOLEAN Diff_corp_agriculture_flag;
    BOOLEAN Diff_corp_authorized_partners;
    BOOLEAN Diff_corp_cmt;
    BOOLEAN Diff_corp_consent_flag_for_protected_name;
    BOOLEAN Diff_corp_converted;
    BOOLEAN Diff_corp_converted_from;
    BOOLEAN Diff_corp_country_of_formation;
    BOOLEAN Diff_corp_date_of_organization_meeting;
    BOOLEAN Diff_corp_delayed_effective_date;
    BOOLEAN Diff_corp_directors_from_to;
    BOOLEAN Diff_corp_dissolved_date;
    BOOLEAN Diff_corp_farm_exemptions;
    BOOLEAN Diff_corp_farm_qual_date;
    BOOLEAN Diff_corp_farm_status_cd;
    BOOLEAN Diff_corp_farm_status_desc;
    BOOLEAN Diff_corp_farm_status_date;
    BOOLEAN Diff_corp_fiscal_year_month;
    BOOLEAN Diff_corp_foreign_fiduciary_capacity_in_state;
    BOOLEAN Diff_corp_governing_statute;
    BOOLEAN Diff_corp_hasmembers;
    BOOLEAN Diff_corp_hasvestedmanagers;
    BOOLEAN Diff_corp_home_incorporated_county;
    BOOLEAN Diff_corp_home_state_name;
    BOOLEAN Diff_corp_is_professional;
    BOOLEAN Diff_corp_isnonprofitirsapproved;
    BOOLEAN Diff_corp_last_renewal_date;
    BOOLEAN Diff_corp_last_renewal_year;
    BOOLEAN Diff_corp_license_type;
    BOOLEAN Diff_corp_llc_managed_cd;
    BOOLEAN Diff_corp_llc_managed_desc;
    BOOLEAN Diff_corp_management_description;
    BOOLEAN Diff_corp_management_type;
    BOOLEAN Diff_corp_manager_managed;
    BOOLEAN Diff_corp_merged_corporation_id;
    BOOLEAN Diff_corp_merged_fein;
    BOOLEAN Diff_corp_merger_allowed_flag;
    BOOLEAN Diff_corp_merger_date;
    BOOLEAN Diff_corp_merger_description;
    BOOLEAN Diff_corp_merger_effective_date;
    BOOLEAN Diff_corp_merger_id;
    BOOLEAN Diff_corp_merger_indicator;
    BOOLEAN Diff_corp_merger_name;
    BOOLEAN Diff_corp_merger_type_converted_to_code;
    BOOLEAN Diff_corp_merger_type_converted_to_description;
    BOOLEAN Diff_corp_naics_description;
    BOOLEAN Diff_corp_name_effective_date;
    BOOLEAN Diff_corp_name_reservation_date;
    BOOLEAN Diff_corp_name_reservation_expiration_date;
    BOOLEAN Diff_corp_name_reservation_number;
    BOOLEAN Diff_corp_name_reservation_type;
    BOOLEAN Diff_corp_name_status_cd;
    BOOLEAN Diff_corp_name_status_date;
    BOOLEAN Diff_corp_name_status_description;
    BOOLEAN Diff_corp_nonprofitirsapprovedpurpose;
    BOOLEAN Diff_corp_nonprofitsolicitdonations;
    BOOLEAN Diff_corp_number_of_amendments;
    BOOLEAN Diff_corp_number_of_initial_llc_members;
    BOOLEAN Diff_corp_number_of_partners;
    BOOLEAN Diff_corp_operatingagreement;
    BOOLEAN Diff_corp_opt_in_llc_act_description;
    BOOLEAN Diff_corp_opt_in_llc_act_ind;
    BOOLEAN Diff_corp_organizational_comments;
    BOOLEAN Diff_corp_original_business_type;
    BOOLEAN Diff_corp_partner_contributions_total;
    BOOLEAN Diff_corp_partner_terms;
    BOOLEAN Diff_corp_percentage_voters_required_to_approve_amendments;
    BOOLEAN Diff_corp_profession;
    BOOLEAN Diff_corp_province;
    BOOLEAN Diff_corp_public_mutual_corporation;
    BOOLEAN Diff_corp_purpose;
    BOOLEAN Diff_corp_ra_required_flag;
    BOOLEAN Diff_corp_registered_counties;
    BOOLEAN Diff_corp_regulated_ind;
    BOOLEAN Diff_corp_renewal_date;
    BOOLEAN Diff_corp_standing_other;
    BOOLEAN Diff_corp_survivor_corporation_id;
    BOOLEAN Diff_corp_tax_base;
    BOOLEAN Diff_corp_tax_standing;
    BOOLEAN Diff_corp_termination_code;
    BOOLEAN Diff_corp_termination_description;
    BOOLEAN Diff_corp_termination_date;
    BOOLEAN Diff_corp_trademark_classification_number;
    BOOLEAN Diff_corp_trademark_first_use_date;
    BOOLEAN Diff_corp_trademark_first_use_date_in_state;
    BOOLEAN Diff_corp_trademark_business_mark_type;
    BOOLEAN Diff_corp_trademark_cancelled_date;
    BOOLEAN Diff_corp_trademark_class_description1;
    BOOLEAN Diff_corp_trademark_class_description2;
    BOOLEAN Diff_corp_trademark_class_description3;
    BOOLEAN Diff_corp_trademark_class_description4;
    BOOLEAN Diff_corp_trademark_class_description5;
    BOOLEAN Diff_corp_trademark_class_description6;
    BOOLEAN Diff_corp_trademark_disclaimer1;
    BOOLEAN Diff_corp_trademark_disclaimer2;
    BOOLEAN Diff_corp_trademark_expiration_date;
    BOOLEAN Diff_corp_trademark_filing_date;
    BOOLEAN Diff_corp_trademark_keywords;
    BOOLEAN Diff_corp_trademark_logo;
    BOOLEAN Diff_corp_trademark_name_expiration_date;
    BOOLEAN Diff_corp_trademark_number;
    BOOLEAN Diff_corp_trademark_renewal_date;
    BOOLEAN Diff_corp_trademark_status;
    BOOLEAN Diff_corp_trademark_used_1;
    BOOLEAN Diff_corp_trademark_used_2;
    BOOLEAN Diff_corp_trademark_used_3;
    BOOLEAN Diff_cont_owner_percentage;
    BOOLEAN Diff_cont_country;
    BOOLEAN Diff_cont_country_mailing;
    BOOLEAN Diff_cont_nondislosure;
    BOOLEAN Diff_cont_prep_addr_line1;
    BOOLEAN Diff_cont_prep_addr_last_line;
    BOOLEAN Diff_recordorigin;
    UNSIGNED Num_Diffs;
    SALT34.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_corp_ra_dt_first_seen := le.corp_ra_dt_first_seen <> ri.corp_ra_dt_first_seen;
    SELF.Diff_corp_ra_dt_last_seen := le.corp_ra_dt_last_seen <> ri.corp_ra_dt_last_seen;
    SELF.Diff_corp_key := le.corp_key <> ri.corp_key;
    SELF.Diff_corp_supp_key := le.corp_supp_key <> ri.corp_supp_key;
    SELF.Diff_corp_vendor := le.corp_vendor <> ri.corp_vendor;
    SELF.Diff_corp_vendor_county := le.corp_vendor_county <> ri.corp_vendor_county;
    SELF.Diff_corp_vendor_subcode := le.corp_vendor_subcode <> ri.corp_vendor_subcode;
    SELF.Diff_corp_state_origin := le.corp_state_origin <> ri.corp_state_origin;
    SELF.Diff_corp_process_date := le.corp_process_date <> ri.corp_process_date;
    SELF.Diff_corp_orig_sos_charter_nbr := le.corp_orig_sos_charter_nbr <> ri.corp_orig_sos_charter_nbr;
    SELF.Diff_corp_legal_name := le.corp_legal_name <> ri.corp_legal_name;
    SELF.Diff_corp_ln_name_type_cd := le.corp_ln_name_type_cd <> ri.corp_ln_name_type_cd;
    SELF.Diff_corp_ln_name_type_desc := le.corp_ln_name_type_desc <> ri.corp_ln_name_type_desc;
    SELF.Diff_corp_supp_nbr := le.corp_supp_nbr <> ri.corp_supp_nbr;
    SELF.Diff_corp_name_comment := le.corp_name_comment <> ri.corp_name_comment;
    SELF.Diff_corp_address1_type_cd := le.corp_address1_type_cd <> ri.corp_address1_type_cd;
    SELF.Diff_corp_address1_type_desc := le.corp_address1_type_desc <> ri.corp_address1_type_desc;
    SELF.Diff_corp_address1_line1 := le.corp_address1_line1 <> ri.corp_address1_line1;
    SELF.Diff_corp_address1_line2 := le.corp_address1_line2 <> ri.corp_address1_line2;
    SELF.Diff_corp_address1_line3 := le.corp_address1_line3 <> ri.corp_address1_line3;
    SELF.Diff_corp_address1_effective_date := le.corp_address1_effective_date <> ri.corp_address1_effective_date;
    SELF.Diff_corp_address2_type_cd := le.corp_address2_type_cd <> ri.corp_address2_type_cd;
    SELF.Diff_corp_address2_type_desc := le.corp_address2_type_desc <> ri.corp_address2_type_desc;
    SELF.Diff_corp_address2_line1 := le.corp_address2_line1 <> ri.corp_address2_line1;
    SELF.Diff_corp_address2_line2 := le.corp_address2_line2 <> ri.corp_address2_line2;
    SELF.Diff_corp_address2_line3 := le.corp_address2_line3 <> ri.corp_address2_line3;
    SELF.Diff_corp_address2_effective_date := le.corp_address2_effective_date <> ri.corp_address2_effective_date;
    SELF.Diff_corp_phone_number := le.corp_phone_number <> ri.corp_phone_number;
    SELF.Diff_corp_phone_number_type_cd := le.corp_phone_number_type_cd <> ri.corp_phone_number_type_cd;
    SELF.Diff_corp_phone_number_type_desc := le.corp_phone_number_type_desc <> ri.corp_phone_number_type_desc;
    SELF.Diff_corp_fax_nbr := le.corp_fax_nbr <> ri.corp_fax_nbr;
    SELF.Diff_corp_email_address := le.corp_email_address <> ri.corp_email_address;
    SELF.Diff_corp_web_address := le.corp_web_address <> ri.corp_web_address;
    SELF.Diff_corp_filing_reference_nbr := le.corp_filing_reference_nbr <> ri.corp_filing_reference_nbr;
    SELF.Diff_corp_filing_date := le.corp_filing_date <> ri.corp_filing_date;
    SELF.Diff_corp_filing_cd := le.corp_filing_cd <> ri.corp_filing_cd;
    SELF.Diff_corp_filing_desc := le.corp_filing_desc <> ri.corp_filing_desc;
    SELF.Diff_corp_status_cd := le.corp_status_cd <> ri.corp_status_cd;
    SELF.Diff_corp_status_desc := le.corp_status_desc <> ri.corp_status_desc;
    SELF.Diff_corp_inc_state := le.corp_inc_state <> ri.corp_inc_state;
    SELF.Diff_corp_inc_county := le.corp_inc_county <> ri.corp_inc_county;
    SELF.Diff_corp_inc_date := le.corp_inc_date <> ri.corp_inc_date;
    SELF.Diff_corp_anniversary_month := le.corp_anniversary_month <> ri.corp_anniversary_month;
    SELF.Diff_corp_fed_tax_id := le.corp_fed_tax_id <> ri.corp_fed_tax_id;
    SELF.Diff_corp_state_tax_id := le.corp_state_tax_id <> ri.corp_state_tax_id;
    SELF.Diff_corp_term_exist_cd := le.corp_term_exist_cd <> ri.corp_term_exist_cd;
    SELF.Diff_corp_term_exist_exp := le.corp_term_exist_exp <> ri.corp_term_exist_exp;
    SELF.Diff_corp_term_exist_desc := le.corp_term_exist_desc <> ri.corp_term_exist_desc;
    SELF.Diff_corp_foreign_domestic_ind := le.corp_foreign_domestic_ind <> ri.corp_foreign_domestic_ind;
    SELF.Diff_corp_forgn_state_cd := le.corp_forgn_state_cd <> ri.corp_forgn_state_cd;
    SELF.Diff_corp_forgn_state_desc := le.corp_forgn_state_desc <> ri.corp_forgn_state_desc;
    SELF.Diff_corp_forgn_sos_charter_nbr := le.corp_forgn_sos_charter_nbr <> ri.corp_forgn_sos_charter_nbr;
    SELF.Diff_corp_forgn_date := le.corp_forgn_date <> ri.corp_forgn_date;
    SELF.Diff_corp_forgn_fed_tax_id := le.corp_forgn_fed_tax_id <> ri.corp_forgn_fed_tax_id;
    SELF.Diff_corp_forgn_state_tax_id := le.corp_forgn_state_tax_id <> ri.corp_forgn_state_tax_id;
    SELF.Diff_corp_forgn_term_exist_cd := le.corp_forgn_term_exist_cd <> ri.corp_forgn_term_exist_cd;
    SELF.Diff_corp_forgn_term_exist_exp := le.corp_forgn_term_exist_exp <> ri.corp_forgn_term_exist_exp;
    SELF.Diff_corp_forgn_term_exist_desc := le.corp_forgn_term_exist_desc <> ri.corp_forgn_term_exist_desc;
    SELF.Diff_corp_orig_org_structure_cd := le.corp_orig_org_structure_cd <> ri.corp_orig_org_structure_cd;
    SELF.Diff_corp_orig_org_structure_desc := le.corp_orig_org_structure_desc <> ri.corp_orig_org_structure_desc;
    SELF.Diff_corp_for_profit_ind := le.corp_for_profit_ind <> ri.corp_for_profit_ind;
    SELF.Diff_corp_public_or_private_ind := le.corp_public_or_private_ind <> ri.corp_public_or_private_ind;
    SELF.Diff_corp_sic_code := le.corp_sic_code <> ri.corp_sic_code;
    SELF.Diff_corp_naic_code := le.corp_naic_code <> ri.corp_naic_code;
    SELF.Diff_corp_orig_bus_type_cd := le.corp_orig_bus_type_cd <> ri.corp_orig_bus_type_cd;
    SELF.Diff_corp_orig_bus_type_desc := le.corp_orig_bus_type_desc <> ri.corp_orig_bus_type_desc;
    SELF.Diff_corp_entity_desc := le.corp_entity_desc <> ri.corp_entity_desc;
    SELF.Diff_corp_certificate_nbr := le.corp_certificate_nbr <> ri.corp_certificate_nbr;
    SELF.Diff_corp_internal_nbr := le.corp_internal_nbr <> ri.corp_internal_nbr;
    SELF.Diff_corp_previous_nbr := le.corp_previous_nbr <> ri.corp_previous_nbr;
    SELF.Diff_corp_microfilm_nbr := le.corp_microfilm_nbr <> ri.corp_microfilm_nbr;
    SELF.Diff_corp_amendments_filed := le.corp_amendments_filed <> ri.corp_amendments_filed;
    SELF.Diff_corp_acts := le.corp_acts <> ri.corp_acts;
    SELF.Diff_corp_partnership_ind := le.corp_partnership_ind <> ri.corp_partnership_ind;
    SELF.Diff_corp_mfg_ind := le.corp_mfg_ind <> ri.corp_mfg_ind;
    SELF.Diff_corp_addl_info := le.corp_addl_info <> ri.corp_addl_info;
    SELF.Diff_corp_taxes := le.corp_taxes <> ri.corp_taxes;
    SELF.Diff_corp_franchise_taxes := le.corp_franchise_taxes <> ri.corp_franchise_taxes;
    SELF.Diff_corp_tax_program_cd := le.corp_tax_program_cd <> ri.corp_tax_program_cd;
    SELF.Diff_corp_tax_program_desc := le.corp_tax_program_desc <> ri.corp_tax_program_desc;
    SELF.Diff_corp_ra_full_name := le.corp_ra_full_name <> ri.corp_ra_full_name;
    SELF.Diff_corp_ra_fname := le.corp_ra_fname <> ri.corp_ra_fname;
    SELF.Diff_corp_ra_mname := le.corp_ra_mname <> ri.corp_ra_mname;
    SELF.Diff_corp_ra_lname := le.corp_ra_lname <> ri.corp_ra_lname;
    SELF.Diff_corp_ra_suffix := le.corp_ra_suffix <> ri.corp_ra_suffix;
    SELF.Diff_corp_ra_title_cd := le.corp_ra_title_cd <> ri.corp_ra_title_cd;
    SELF.Diff_corp_ra_title_desc := le.corp_ra_title_desc <> ri.corp_ra_title_desc;
    SELF.Diff_corp_ra_fein := le.corp_ra_fein <> ri.corp_ra_fein;
    SELF.Diff_corp_ra_ssn := le.corp_ra_ssn <> ri.corp_ra_ssn;
    SELF.Diff_corp_ra_dob := le.corp_ra_dob <> ri.corp_ra_dob;
    SELF.Diff_corp_ra_effective_date := le.corp_ra_effective_date <> ri.corp_ra_effective_date;
    SELF.Diff_corp_ra_resign_date := le.corp_ra_resign_date <> ri.corp_ra_resign_date;
    SELF.Diff_corp_ra_no_comp := le.corp_ra_no_comp <> ri.corp_ra_no_comp;
    SELF.Diff_corp_ra_no_comp_igs := le.corp_ra_no_comp_igs <> ri.corp_ra_no_comp_igs;
    SELF.Diff_corp_ra_addl_info := le.corp_ra_addl_info <> ri.corp_ra_addl_info;
    SELF.Diff_corp_ra_address_type_cd := le.corp_ra_address_type_cd <> ri.corp_ra_address_type_cd;
    SELF.Diff_corp_ra_address_type_desc := le.corp_ra_address_type_desc <> ri.corp_ra_address_type_desc;
    SELF.Diff_corp_ra_address_line1 := le.corp_ra_address_line1 <> ri.corp_ra_address_line1;
    SELF.Diff_corp_ra_address_line2 := le.corp_ra_address_line2 <> ri.corp_ra_address_line2;
    SELF.Diff_corp_ra_address_line3 := le.corp_ra_address_line3 <> ri.corp_ra_address_line3;
    SELF.Diff_corp_ra_phone_number := le.corp_ra_phone_number <> ri.corp_ra_phone_number;
    SELF.Diff_corp_ra_phone_number_type_cd := le.corp_ra_phone_number_type_cd <> ri.corp_ra_phone_number_type_cd;
    SELF.Diff_corp_ra_phone_number_type_desc := le.corp_ra_phone_number_type_desc <> ri.corp_ra_phone_number_type_desc;
    SELF.Diff_corp_ra_fax_nbr := le.corp_ra_fax_nbr <> ri.corp_ra_fax_nbr;
    SELF.Diff_corp_ra_email_address := le.corp_ra_email_address <> ri.corp_ra_email_address;
    SELF.Diff_corp_ra_web_address := le.corp_ra_web_address <> ri.corp_ra_web_address;
    SELF.Diff_corp_prep_addr1_line1 := le.corp_prep_addr1_line1 <> ri.corp_prep_addr1_line1;
    SELF.Diff_corp_prep_addr1_last_line := le.corp_prep_addr1_last_line <> ri.corp_prep_addr1_last_line;
    SELF.Diff_corp_prep_addr2_line1 := le.corp_prep_addr2_line1 <> ri.corp_prep_addr2_line1;
    SELF.Diff_corp_prep_addr2_last_line := le.corp_prep_addr2_last_line <> ri.corp_prep_addr2_last_line;
    SELF.Diff_ra_prep_addr_line1 := le.ra_prep_addr_line1 <> ri.ra_prep_addr_line1;
    SELF.Diff_ra_prep_addr_last_line := le.ra_prep_addr_last_line <> ri.ra_prep_addr_last_line;
    SELF.Diff_cont_filing_reference_nbr := le.cont_filing_reference_nbr <> ri.cont_filing_reference_nbr;
    SELF.Diff_cont_filing_date := le.cont_filing_date <> ri.cont_filing_date;
    SELF.Diff_cont_filing_cd := le.cont_filing_cd <> ri.cont_filing_cd;
    SELF.Diff_cont_filing_desc := le.cont_filing_desc <> ri.cont_filing_desc;
    SELF.Diff_cont_type_cd := le.cont_type_cd <> ri.cont_type_cd;
    SELF.Diff_cont_type_desc := le.cont_type_desc <> ri.cont_type_desc;
    SELF.Diff_cont_full_name := le.cont_full_name <> ri.cont_full_name;
    SELF.Diff_cont_fname := le.cont_fname <> ri.cont_fname;
    SELF.Diff_cont_mname := le.cont_mname <> ri.cont_mname;
    SELF.Diff_cont_lname := le.cont_lname <> ri.cont_lname;
    SELF.Diff_cont_suffix := le.cont_suffix <> ri.cont_suffix;
    SELF.Diff_cont_title1_desc := le.cont_title1_desc <> ri.cont_title1_desc;
    SELF.Diff_cont_title2_desc := le.cont_title2_desc <> ri.cont_title2_desc;
    SELF.Diff_cont_title3_desc := le.cont_title3_desc <> ri.cont_title3_desc;
    SELF.Diff_cont_title4_desc := le.cont_title4_desc <> ri.cont_title4_desc;
    SELF.Diff_cont_title5_desc := le.cont_title5_desc <> ri.cont_title5_desc;
    SELF.Diff_cont_fein := le.cont_fein <> ri.cont_fein;
    SELF.Diff_cont_ssn := le.cont_ssn <> ri.cont_ssn;
    SELF.Diff_cont_dob := le.cont_dob <> ri.cont_dob;
    SELF.Diff_cont_status_cd := le.cont_status_cd <> ri.cont_status_cd;
    SELF.Diff_cont_status_desc := le.cont_status_desc <> ri.cont_status_desc;
    SELF.Diff_cont_effective_date := le.cont_effective_date <> ri.cont_effective_date;
    SELF.Diff_cont_effective_cd := le.cont_effective_cd <> ri.cont_effective_cd;
    SELF.Diff_cont_effective_desc := le.cont_effective_desc <> ri.cont_effective_desc;
    SELF.Diff_cont_addl_info := le.cont_addl_info <> ri.cont_addl_info;
    SELF.Diff_cont_address_type_cd := le.cont_address_type_cd <> ri.cont_address_type_cd;
    SELF.Diff_cont_address_type_desc := le.cont_address_type_desc <> ri.cont_address_type_desc;
    SELF.Diff_cont_address_line1 := le.cont_address_line1 <> ri.cont_address_line1;
    SELF.Diff_cont_address_line2 := le.cont_address_line2 <> ri.cont_address_line2;
    SELF.Diff_cont_address_line3 := le.cont_address_line3 <> ri.cont_address_line3;
    SELF.Diff_cont_address_effective_date := le.cont_address_effective_date <> ri.cont_address_effective_date;
    SELF.Diff_cont_address_county := le.cont_address_county <> ri.cont_address_county;
    SELF.Diff_cont_phone_number := le.cont_phone_number <> ri.cont_phone_number;
    SELF.Diff_cont_phone_number_type_cd := le.cont_phone_number_type_cd <> ri.cont_phone_number_type_cd;
    SELF.Diff_cont_phone_number_type_desc := le.cont_phone_number_type_desc <> ri.cont_phone_number_type_desc;
    SELF.Diff_cont_fax_nbr := le.cont_fax_nbr <> ri.cont_fax_nbr;
    SELF.Diff_cont_email_address := le.cont_email_address <> ri.cont_email_address;
    SELF.Diff_cont_web_address := le.cont_web_address <> ri.cont_web_address;
    SELF.Diff_corp_acres := le.corp_acres <> ri.corp_acres;
    SELF.Diff_corp_action := le.corp_action <> ri.corp_action;
    SELF.Diff_corp_action_date := le.corp_action_date <> ri.corp_action_date;
    SELF.Diff_corp_action_employment_security_approval_date := le.corp_action_employment_security_approval_date <> ri.corp_action_employment_security_approval_date;
    SELF.Diff_corp_action_pending_code := le.corp_action_pending_code <> ri.corp_action_pending_code;
    SELF.Diff_corp_action_pending_description := le.corp_action_pending_description <> ri.corp_action_pending_description;
    SELF.Diff_corp_action_statement_of_intent_date := le.corp_action_statement_of_intent_date <> ri.corp_action_statement_of_intent_date;
    SELF.Diff_corp_action_tax_dept_approval_date := le.corp_action_tax_dept_approval_date <> ri.corp_action_tax_dept_approval_date;
    SELF.Diff_corp_acts2 := le.corp_acts2 <> ri.corp_acts2;
    SELF.Diff_corp_acts3 := le.corp_acts3 <> ri.corp_acts3;
    SELF.Diff_corp_additional_principals := le.corp_additional_principals <> ri.corp_additional_principals;
    SELF.Diff_corp_address_office_type := le.corp_address_office_type <> ri.corp_address_office_type;
    SELF.Diff_corp_agent_commercial := le.corp_agent_commercial <> ri.corp_agent_commercial;
    SELF.Diff_corp_agent_country := le.corp_agent_country <> ri.corp_agent_country;
    SELF.Diff_corp_agent_county := le.corp_agent_county <> ri.corp_agent_county;
    SELF.Diff_corp_agent_status_cd := le.corp_agent_status_cd <> ri.corp_agent_status_cd;
    SELF.Diff_corp_agent_status_desc := le.corp_agent_status_desc <> ri.corp_agent_status_desc;
    SELF.Diff_corp_agent_id := le.corp_agent_id <> ri.corp_agent_id;
    SELF.Diff_corp_agent_assign_date := le.corp_agent_assign_date <> ri.corp_agent_assign_date;
    SELF.Diff_corp_agriculture_flag := le.corp_agriculture_flag <> ri.corp_agriculture_flag;
    SELF.Diff_corp_authorized_partners := le.corp_authorized_partners <> ri.corp_authorized_partners;
    SELF.Diff_corp_cmt := le.corp_cmt <> ri.corp_cmt;
    SELF.Diff_corp_consent_flag_for_protected_name := le.corp_consent_flag_for_protected_name <> ri.corp_consent_flag_for_protected_name;
    SELF.Diff_corp_converted := le.corp_converted <> ri.corp_converted;
    SELF.Diff_corp_converted_from := le.corp_converted_from <> ri.corp_converted_from;
    SELF.Diff_corp_country_of_formation := le.corp_country_of_formation <> ri.corp_country_of_formation;
    SELF.Diff_corp_date_of_organization_meeting := le.corp_date_of_organization_meeting <> ri.corp_date_of_organization_meeting;
    SELF.Diff_corp_delayed_effective_date := le.corp_delayed_effective_date <> ri.corp_delayed_effective_date;
    SELF.Diff_corp_directors_from_to := le.corp_directors_from_to <> ri.corp_directors_from_to;
    SELF.Diff_corp_dissolved_date := le.corp_dissolved_date <> ri.corp_dissolved_date;
    SELF.Diff_corp_farm_exemptions := le.corp_farm_exemptions <> ri.corp_farm_exemptions;
    SELF.Diff_corp_farm_qual_date := le.corp_farm_qual_date <> ri.corp_farm_qual_date;
    SELF.Diff_corp_farm_status_cd := le.corp_farm_status_cd <> ri.corp_farm_status_cd;
    SELF.Diff_corp_farm_status_desc := le.corp_farm_status_desc <> ri.corp_farm_status_desc;
    SELF.Diff_corp_farm_status_date := le.corp_farm_status_date <> ri.corp_farm_status_date;
    SELF.Diff_corp_fiscal_year_month := le.corp_fiscal_year_month <> ri.corp_fiscal_year_month;
    SELF.Diff_corp_foreign_fiduciary_capacity_in_state := le.corp_foreign_fiduciary_capacity_in_state <> ri.corp_foreign_fiduciary_capacity_in_state;
    SELF.Diff_corp_governing_statute := le.corp_governing_statute <> ri.corp_governing_statute;
    SELF.Diff_corp_hasmembers := le.corp_hasmembers <> ri.corp_hasmembers;
    SELF.Diff_corp_hasvestedmanagers := le.corp_hasvestedmanagers <> ri.corp_hasvestedmanagers;
    SELF.Diff_corp_home_incorporated_county := le.corp_home_incorporated_county <> ri.corp_home_incorporated_county;
    SELF.Diff_corp_home_state_name := le.corp_home_state_name <> ri.corp_home_state_name;
    SELF.Diff_corp_is_professional := le.corp_is_professional <> ri.corp_is_professional;
    SELF.Diff_corp_isnonprofitirsapproved := le.corp_isnonprofitirsapproved <> ri.corp_isnonprofitirsapproved;
    SELF.Diff_corp_last_renewal_date := le.corp_last_renewal_date <> ri.corp_last_renewal_date;
    SELF.Diff_corp_last_renewal_year := le.corp_last_renewal_year <> ri.corp_last_renewal_year;
    SELF.Diff_corp_license_type := le.corp_license_type <> ri.corp_license_type;
    SELF.Diff_corp_llc_managed_cd := le.corp_llc_managed_cd <> ri.corp_llc_managed_cd;
    SELF.Diff_corp_llc_managed_desc := le.corp_llc_managed_desc <> ri.corp_llc_managed_desc;
    SELF.Diff_corp_management_description := le.corp_management_description <> ri.corp_management_description;
    SELF.Diff_corp_management_type := le.corp_management_type <> ri.corp_management_type;
    SELF.Diff_corp_manager_managed := le.corp_manager_managed <> ri.corp_manager_managed;
    SELF.Diff_corp_merged_corporation_id := le.corp_merged_corporation_id <> ri.corp_merged_corporation_id;
    SELF.Diff_corp_merged_fein := le.corp_merged_fein <> ri.corp_merged_fein;
    SELF.Diff_corp_merger_allowed_flag := le.corp_merger_allowed_flag <> ri.corp_merger_allowed_flag;
    SELF.Diff_corp_merger_date := le.corp_merger_date <> ri.corp_merger_date;
    SELF.Diff_corp_merger_description := le.corp_merger_description <> ri.corp_merger_description;
    SELF.Diff_corp_merger_effective_date := le.corp_merger_effective_date <> ri.corp_merger_effective_date;
    SELF.Diff_corp_merger_id := le.corp_merger_id <> ri.corp_merger_id;
    SELF.Diff_corp_merger_indicator := le.corp_merger_indicator <> ri.corp_merger_indicator;
    SELF.Diff_corp_merger_name := le.corp_merger_name <> ri.corp_merger_name;
    SELF.Diff_corp_merger_type_converted_to_code := le.corp_merger_type_converted_to_code <> ri.corp_merger_type_converted_to_code;
    SELF.Diff_corp_merger_type_converted_to_description := le.corp_merger_type_converted_to_description <> ri.corp_merger_type_converted_to_description;
    SELF.Diff_corp_naics_description := le.corp_naics_description <> ri.corp_naics_description;
    SELF.Diff_corp_name_effective_date := le.corp_name_effective_date <> ri.corp_name_effective_date;
    SELF.Diff_corp_name_reservation_date := le.corp_name_reservation_date <> ri.corp_name_reservation_date;
    SELF.Diff_corp_name_reservation_expiration_date := le.corp_name_reservation_expiration_date <> ri.corp_name_reservation_expiration_date;
    SELF.Diff_corp_name_reservation_number := le.corp_name_reservation_number <> ri.corp_name_reservation_number;
    SELF.Diff_corp_name_reservation_type := le.corp_name_reservation_type <> ri.corp_name_reservation_type;
    SELF.Diff_corp_name_status_cd := le.corp_name_status_cd <> ri.corp_name_status_cd;
    SELF.Diff_corp_name_status_date := le.corp_name_status_date <> ri.corp_name_status_date;
    SELF.Diff_corp_name_status_description := le.corp_name_status_description <> ri.corp_name_status_description;
    SELF.Diff_corp_nonprofitirsapprovedpurpose := le.corp_nonprofitirsapprovedpurpose <> ri.corp_nonprofitirsapprovedpurpose;
    SELF.Diff_corp_nonprofitsolicitdonations := le.corp_nonprofitsolicitdonations <> ri.corp_nonprofitsolicitdonations;
    SELF.Diff_corp_number_of_amendments := le.corp_number_of_amendments <> ri.corp_number_of_amendments;
    SELF.Diff_corp_number_of_initial_llc_members := le.corp_number_of_initial_llc_members <> ri.corp_number_of_initial_llc_members;
    SELF.Diff_corp_number_of_partners := le.corp_number_of_partners <> ri.corp_number_of_partners;
    SELF.Diff_corp_operatingagreement := le.corp_operatingagreement <> ri.corp_operatingagreement;
    SELF.Diff_corp_opt_in_llc_act_description := le.corp_opt_in_llc_act_description <> ri.corp_opt_in_llc_act_description;
    SELF.Diff_corp_opt_in_llc_act_ind := le.corp_opt_in_llc_act_ind <> ri.corp_opt_in_llc_act_ind;
    SELF.Diff_corp_organizational_comments := le.corp_organizational_comments <> ri.corp_organizational_comments;
    SELF.Diff_corp_original_business_type := le.corp_original_business_type <> ri.corp_original_business_type;
    SELF.Diff_corp_partner_contributions_total := le.corp_partner_contributions_total <> ri.corp_partner_contributions_total;
    SELF.Diff_corp_partner_terms := le.corp_partner_terms <> ri.corp_partner_terms;
    SELF.Diff_corp_percentage_voters_required_to_approve_amendments := le.corp_percentage_voters_required_to_approve_amendments <> ri.corp_percentage_voters_required_to_approve_amendments;
    SELF.Diff_corp_profession := le.corp_profession <> ri.corp_profession;
    SELF.Diff_corp_province := le.corp_province <> ri.corp_province;
    SELF.Diff_corp_public_mutual_corporation := le.corp_public_mutual_corporation <> ri.corp_public_mutual_corporation;
    SELF.Diff_corp_purpose := le.corp_purpose <> ri.corp_purpose;
    SELF.Diff_corp_ra_required_flag := le.corp_ra_required_flag <> ri.corp_ra_required_flag;
    SELF.Diff_corp_registered_counties := le.corp_registered_counties <> ri.corp_registered_counties;
    SELF.Diff_corp_regulated_ind := le.corp_regulated_ind <> ri.corp_regulated_ind;
    SELF.Diff_corp_renewal_date := le.corp_renewal_date <> ri.corp_renewal_date;
    SELF.Diff_corp_standing_other := le.corp_standing_other <> ri.corp_standing_other;
    SELF.Diff_corp_survivor_corporation_id := le.corp_survivor_corporation_id <> ri.corp_survivor_corporation_id;
    SELF.Diff_corp_tax_base := le.corp_tax_base <> ri.corp_tax_base;
    SELF.Diff_corp_tax_standing := le.corp_tax_standing <> ri.corp_tax_standing;
    SELF.Diff_corp_termination_code := le.corp_termination_code <> ri.corp_termination_code;
    SELF.Diff_corp_termination_description := le.corp_termination_description <> ri.corp_termination_description;
    SELF.Diff_corp_termination_date := le.corp_termination_date <> ri.corp_termination_date;
    SELF.Diff_corp_trademark_classification_number := le.corp_trademark_classification_number <> ri.corp_trademark_classification_number;
    SELF.Diff_corp_trademark_first_use_date := le.corp_trademark_first_use_date <> ri.corp_trademark_first_use_date;
    SELF.Diff_corp_trademark_first_use_date_in_state := le.corp_trademark_first_use_date_in_state <> ri.corp_trademark_first_use_date_in_state;
    SELF.Diff_corp_trademark_business_mark_type := le.corp_trademark_business_mark_type <> ri.corp_trademark_business_mark_type;
    SELF.Diff_corp_trademark_cancelled_date := le.corp_trademark_cancelled_date <> ri.corp_trademark_cancelled_date;
    SELF.Diff_corp_trademark_class_description1 := le.corp_trademark_class_description1 <> ri.corp_trademark_class_description1;
    SELF.Diff_corp_trademark_class_description2 := le.corp_trademark_class_description2 <> ri.corp_trademark_class_description2;
    SELF.Diff_corp_trademark_class_description3 := le.corp_trademark_class_description3 <> ri.corp_trademark_class_description3;
    SELF.Diff_corp_trademark_class_description4 := le.corp_trademark_class_description4 <> ri.corp_trademark_class_description4;
    SELF.Diff_corp_trademark_class_description5 := le.corp_trademark_class_description5 <> ri.corp_trademark_class_description5;
    SELF.Diff_corp_trademark_class_description6 := le.corp_trademark_class_description6 <> ri.corp_trademark_class_description6;
    SELF.Diff_corp_trademark_disclaimer1 := le.corp_trademark_disclaimer1 <> ri.corp_trademark_disclaimer1;
    SELF.Diff_corp_trademark_disclaimer2 := le.corp_trademark_disclaimer2 <> ri.corp_trademark_disclaimer2;
    SELF.Diff_corp_trademark_expiration_date := le.corp_trademark_expiration_date <> ri.corp_trademark_expiration_date;
    SELF.Diff_corp_trademark_filing_date := le.corp_trademark_filing_date <> ri.corp_trademark_filing_date;
    SELF.Diff_corp_trademark_keywords := le.corp_trademark_keywords <> ri.corp_trademark_keywords;
    SELF.Diff_corp_trademark_logo := le.corp_trademark_logo <> ri.corp_trademark_logo;
    SELF.Diff_corp_trademark_name_expiration_date := le.corp_trademark_name_expiration_date <> ri.corp_trademark_name_expiration_date;
    SELF.Diff_corp_trademark_number := le.corp_trademark_number <> ri.corp_trademark_number;
    SELF.Diff_corp_trademark_renewal_date := le.corp_trademark_renewal_date <> ri.corp_trademark_renewal_date;
    SELF.Diff_corp_trademark_status := le.corp_trademark_status <> ri.corp_trademark_status;
    SELF.Diff_corp_trademark_used_1 := le.corp_trademark_used_1 <> ri.corp_trademark_used_1;
    SELF.Diff_corp_trademark_used_2 := le.corp_trademark_used_2 <> ri.corp_trademark_used_2;
    SELF.Diff_corp_trademark_used_3 := le.corp_trademark_used_3 <> ri.corp_trademark_used_3;
    SELF.Diff_cont_owner_percentage := le.cont_owner_percentage <> ri.cont_owner_percentage;
    SELF.Diff_cont_country := le.cont_country <> ri.cont_country;
    SELF.Diff_cont_country_mailing := le.cont_country_mailing <> ri.cont_country_mailing;
    SELF.Diff_cont_nondislosure := le.cont_nondislosure <> ri.cont_nondislosure;
    SELF.Diff_cont_prep_addr_line1 := le.cont_prep_addr_line1 <> ri.cont_prep_addr_line1;
    SELF.Diff_cont_prep_addr_last_line := le.cont_prep_addr_last_line <> ri.cont_prep_addr_last_line;
    SELF.Diff_recordorigin := le.recordorigin <> ri.recordorigin;
    SELF.Val := (SALT34.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_corp_ra_dt_first_seen,1,0)+ IF( SELF.Diff_corp_ra_dt_last_seen,1,0)+ IF( SELF.Diff_corp_key,1,0)+ IF( SELF.Diff_corp_supp_key,1,0)+ IF( SELF.Diff_corp_vendor,1,0)+ IF( SELF.Diff_corp_vendor_county,1,0)+ IF( SELF.Diff_corp_vendor_subcode,1,0)+ IF( SELF.Diff_corp_state_origin,1,0)+ IF( SELF.Diff_corp_process_date,1,0)+ IF( SELF.Diff_corp_orig_sos_charter_nbr,1,0)+ IF( SELF.Diff_corp_legal_name,1,0)+ IF( SELF.Diff_corp_ln_name_type_cd,1,0)+ IF( SELF.Diff_corp_ln_name_type_desc,1,0)+ IF( SELF.Diff_corp_supp_nbr,1,0)+ IF( SELF.Diff_corp_name_comment,1,0)+ IF( SELF.Diff_corp_address1_type_cd,1,0)+ IF( SELF.Diff_corp_address1_type_desc,1,0)+ IF( SELF.Diff_corp_address1_line1,1,0)+ IF( SELF.Diff_corp_address1_line2,1,0)+ IF( SELF.Diff_corp_address1_line3,1,0)+ IF( SELF.Diff_corp_address1_effective_date,1,0)+ IF( SELF.Diff_corp_address2_type_cd,1,0)+ IF( SELF.Diff_corp_address2_type_desc,1,0)+ IF( SELF.Diff_corp_address2_line1,1,0)+ IF( SELF.Diff_corp_address2_line2,1,0)+ IF( SELF.Diff_corp_address2_line3,1,0)+ IF( SELF.Diff_corp_address2_effective_date,1,0)+ IF( SELF.Diff_corp_phone_number,1,0)+ IF( SELF.Diff_corp_phone_number_type_cd,1,0)+ IF( SELF.Diff_corp_phone_number_type_desc,1,0)+ IF( SELF.Diff_corp_fax_nbr,1,0)+ IF( SELF.Diff_corp_email_address,1,0)+ IF( SELF.Diff_corp_web_address,1,0)+ IF( SELF.Diff_corp_filing_reference_nbr,1,0)+ IF( SELF.Diff_corp_filing_date,1,0)+ IF( SELF.Diff_corp_filing_cd,1,0)+ IF( SELF.Diff_corp_filing_desc,1,0)+ IF( SELF.Diff_corp_status_cd,1,0)+ IF( SELF.Diff_corp_status_desc,1,0)+ IF( SELF.Diff_corp_inc_state,1,0)+ IF( SELF.Diff_corp_inc_county,1,0)+ IF( SELF.Diff_corp_inc_date,1,0)+ IF( SELF.Diff_corp_anniversary_month,1,0)+ IF( SELF.Diff_corp_fed_tax_id,1,0)+ IF( SELF.Diff_corp_state_tax_id,1,0)+ IF( SELF.Diff_corp_term_exist_cd,1,0)+ IF( SELF.Diff_corp_term_exist_exp,1,0)+ IF( SELF.Diff_corp_term_exist_desc,1,0)+ IF( SELF.Diff_corp_foreign_domestic_ind,1,0)+ IF( SELF.Diff_corp_forgn_state_cd,1,0)+ IF( SELF.Diff_corp_forgn_state_desc,1,0)+ IF( SELF.Diff_corp_forgn_sos_charter_nbr,1,0)+ IF( SELF.Diff_corp_forgn_date,1,0)+ IF( SELF.Diff_corp_forgn_fed_tax_id,1,0)+ IF( SELF.Diff_corp_forgn_state_tax_id,1,0)+ IF( SELF.Diff_corp_forgn_term_exist_cd,1,0)+ IF( SELF.Diff_corp_forgn_term_exist_exp,1,0)+ IF( SELF.Diff_corp_forgn_term_exist_desc,1,0)+ IF( SELF.Diff_corp_orig_org_structure_cd,1,0)+ IF( SELF.Diff_corp_orig_org_structure_desc,1,0)+ IF( SELF.Diff_corp_for_profit_ind,1,0)+ IF( SELF.Diff_corp_public_or_private_ind,1,0)+ IF( SELF.Diff_corp_sic_code,1,0)+ IF( SELF.Diff_corp_naic_code,1,0)+ IF( SELF.Diff_corp_orig_bus_type_cd,1,0)+ IF( SELF.Diff_corp_orig_bus_type_desc,1,0)+ IF( SELF.Diff_corp_entity_desc,1,0)+ IF( SELF.Diff_corp_certificate_nbr,1,0)+ IF( SELF.Diff_corp_internal_nbr,1,0)+ IF( SELF.Diff_corp_previous_nbr,1,0)+ IF( SELF.Diff_corp_microfilm_nbr,1,0)+ IF( SELF.Diff_corp_amendments_filed,1,0)+ IF( SELF.Diff_corp_acts,1,0)+ IF( SELF.Diff_corp_partnership_ind,1,0)+ IF( SELF.Diff_corp_mfg_ind,1,0)+ IF( SELF.Diff_corp_addl_info,1,0)+ IF( SELF.Diff_corp_taxes,1,0)+ IF( SELF.Diff_corp_franchise_taxes,1,0)+ IF( SELF.Diff_corp_tax_program_cd,1,0)+ IF( SELF.Diff_corp_tax_program_desc,1,0)+ IF( SELF.Diff_corp_ra_full_name,1,0)+ IF( SELF.Diff_corp_ra_fname,1,0)+ IF( SELF.Diff_corp_ra_mname,1,0)+ IF( SELF.Diff_corp_ra_lname,1,0)+ IF( SELF.Diff_corp_ra_suffix,1,0)+ IF( SELF.Diff_corp_ra_title_cd,1,0)+ IF( SELF.Diff_corp_ra_title_desc,1,0)+ IF( SELF.Diff_corp_ra_fein,1,0)+ IF( SELF.Diff_corp_ra_ssn,1,0)+ IF( SELF.Diff_corp_ra_dob,1,0)+ IF( SELF.Diff_corp_ra_effective_date,1,0)+ IF( SELF.Diff_corp_ra_resign_date,1,0)+ IF( SELF.Diff_corp_ra_no_comp,1,0)+ IF( SELF.Diff_corp_ra_no_comp_igs,1,0)+ IF( SELF.Diff_corp_ra_addl_info,1,0)+ IF( SELF.Diff_corp_ra_address_type_cd,1,0)+ IF( SELF.Diff_corp_ra_address_type_desc,1,0)+ IF( SELF.Diff_corp_ra_address_line1,1,0)+ IF( SELF.Diff_corp_ra_address_line2,1,0)+ IF( SELF.Diff_corp_ra_address_line3,1,0)+ IF( SELF.Diff_corp_ra_phone_number,1,0)+ IF( SELF.Diff_corp_ra_phone_number_type_cd,1,0)+ IF( SELF.Diff_corp_ra_phone_number_type_desc,1,0)+ IF( SELF.Diff_corp_ra_fax_nbr,1,0)+ IF( SELF.Diff_corp_ra_email_address,1,0)+ IF( SELF.Diff_corp_ra_web_address,1,0)+ IF( SELF.Diff_corp_prep_addr1_line1,1,0)+ IF( SELF.Diff_corp_prep_addr1_last_line,1,0)+ IF( SELF.Diff_corp_prep_addr2_line1,1,0)+ IF( SELF.Diff_corp_prep_addr2_last_line,1,0)+ IF( SELF.Diff_ra_prep_addr_line1,1,0)+ IF( SELF.Diff_ra_prep_addr_last_line,1,0)+ IF( SELF.Diff_cont_filing_reference_nbr,1,0)+ IF( SELF.Diff_cont_filing_date,1,0)+ IF( SELF.Diff_cont_filing_cd,1,0)+ IF( SELF.Diff_cont_filing_desc,1,0)+ IF( SELF.Diff_cont_type_cd,1,0)+ IF( SELF.Diff_cont_type_desc,1,0)+ IF( SELF.Diff_cont_full_name,1,0)+ IF( SELF.Diff_cont_fname,1,0)+ IF( SELF.Diff_cont_mname,1,0)+ IF( SELF.Diff_cont_lname,1,0)+ IF( SELF.Diff_cont_suffix,1,0)+ IF( SELF.Diff_cont_title1_desc,1,0)+ IF( SELF.Diff_cont_title2_desc,1,0)+ IF( SELF.Diff_cont_title3_desc,1,0)+ IF( SELF.Diff_cont_title4_desc,1,0)+ IF( SELF.Diff_cont_title5_desc,1,0)+ IF( SELF.Diff_cont_fein,1,0)+ IF( SELF.Diff_cont_ssn,1,0)+ IF( SELF.Diff_cont_dob,1,0)+ IF( SELF.Diff_cont_status_cd,1,0)+ IF( SELF.Diff_cont_status_desc,1,0)+ IF( SELF.Diff_cont_effective_date,1,0)+ IF( SELF.Diff_cont_effective_cd,1,0)+ IF( SELF.Diff_cont_effective_desc,1,0)+ IF( SELF.Diff_cont_addl_info,1,0)+ IF( SELF.Diff_cont_address_type_cd,1,0)+ IF( SELF.Diff_cont_address_type_desc,1,0)+ IF( SELF.Diff_cont_address_line1,1,0)+ IF( SELF.Diff_cont_address_line2,1,0)+ IF( SELF.Diff_cont_address_line3,1,0)+ IF( SELF.Diff_cont_address_effective_date,1,0)+ IF( SELF.Diff_cont_address_county,1,0)+ IF( SELF.Diff_cont_phone_number,1,0)+ IF( SELF.Diff_cont_phone_number_type_cd,1,0)+ IF( SELF.Diff_cont_phone_number_type_desc,1,0)+ IF( SELF.Diff_cont_fax_nbr,1,0)+ IF( SELF.Diff_cont_email_address,1,0)+ IF( SELF.Diff_cont_web_address,1,0)+ IF( SELF.Diff_corp_acres,1,0)+ IF( SELF.Diff_corp_action,1,0)+ IF( SELF.Diff_corp_action_date,1,0)+ IF( SELF.Diff_corp_action_employment_security_approval_date,1,0)+ IF( SELF.Diff_corp_action_pending_code,1,0)+ IF( SELF.Diff_corp_action_pending_description,1,0)+ IF( SELF.Diff_corp_action_statement_of_intent_date,1,0)+ IF( SELF.Diff_corp_action_tax_dept_approval_date,1,0)+ IF( SELF.Diff_corp_acts2,1,0)+ IF( SELF.Diff_corp_acts3,1,0)+ IF( SELF.Diff_corp_additional_principals,1,0)+ IF( SELF.Diff_corp_address_office_type,1,0)+ IF( SELF.Diff_corp_agent_commercial,1,0)+ IF( SELF.Diff_corp_agent_country,1,0)+ IF( SELF.Diff_corp_agent_county,1,0)+ IF( SELF.Diff_corp_agent_status_cd,1,0)+ IF( SELF.Diff_corp_agent_status_desc,1,0)+ IF( SELF.Diff_corp_agent_id,1,0)+ IF( SELF.Diff_corp_agent_assign_date,1,0)+ IF( SELF.Diff_corp_agriculture_flag,1,0)+ IF( SELF.Diff_corp_authorized_partners,1,0)+ IF( SELF.Diff_corp_cmt,1,0)+ IF( SELF.Diff_corp_consent_flag_for_protected_name,1,0)+ IF( SELF.Diff_corp_converted,1,0)+ IF( SELF.Diff_corp_converted_from,1,0)+ IF( SELF.Diff_corp_country_of_formation,1,0)+ IF( SELF.Diff_corp_date_of_organization_meeting,1,0)+ IF( SELF.Diff_corp_delayed_effective_date,1,0)+ IF( SELF.Diff_corp_directors_from_to,1,0)+ IF( SELF.Diff_corp_dissolved_date,1,0)+ IF( SELF.Diff_corp_farm_exemptions,1,0)+ IF( SELF.Diff_corp_farm_qual_date,1,0)+ IF( SELF.Diff_corp_farm_status_cd,1,0)+ IF( SELF.Diff_corp_farm_status_desc,1,0)+ IF( SELF.Diff_corp_farm_status_date,1,0)+ IF( SELF.Diff_corp_fiscal_year_month,1,0)+ IF( SELF.Diff_corp_foreign_fiduciary_capacity_in_state,1,0)+ IF( SELF.Diff_corp_governing_statute,1,0)+ IF( SELF.Diff_corp_hasmembers,1,0)+ IF( SELF.Diff_corp_hasvestedmanagers,1,0)+ IF( SELF.Diff_corp_home_incorporated_county,1,0)+ IF( SELF.Diff_corp_home_state_name,1,0)+ IF( SELF.Diff_corp_is_professional,1,0)+ IF( SELF.Diff_corp_isnonprofitirsapproved,1,0)+ IF( SELF.Diff_corp_last_renewal_date,1,0)+ IF( SELF.Diff_corp_last_renewal_year,1,0)+ IF( SELF.Diff_corp_license_type,1,0)+ IF( SELF.Diff_corp_llc_managed_cd,1,0)+ IF( SELF.Diff_corp_llc_managed_desc,1,0)+ IF( SELF.Diff_corp_management_description,1,0)+ IF( SELF.Diff_corp_management_type,1,0)+ IF( SELF.Diff_corp_manager_managed,1,0)+ IF( SELF.Diff_corp_merged_corporation_id,1,0)+ IF( SELF.Diff_corp_merged_fein,1,0)+ IF( SELF.Diff_corp_merger_allowed_flag,1,0)+ IF( SELF.Diff_corp_merger_date,1,0)+ IF( SELF.Diff_corp_merger_description,1,0)+ IF( SELF.Diff_corp_merger_effective_date,1,0)+ IF( SELF.Diff_corp_merger_id,1,0)+ IF( SELF.Diff_corp_merger_indicator,1,0)+ IF( SELF.Diff_corp_merger_name,1,0)+ IF( SELF.Diff_corp_merger_type_converted_to_code,1,0)+ IF( SELF.Diff_corp_merger_type_converted_to_description,1,0)+ IF( SELF.Diff_corp_naics_description,1,0)+ IF( SELF.Diff_corp_name_effective_date,1,0)+ IF( SELF.Diff_corp_name_reservation_date,1,0)+ IF( SELF.Diff_corp_name_reservation_expiration_date,1,0)+ IF( SELF.Diff_corp_name_reservation_number,1,0)+ IF( SELF.Diff_corp_name_reservation_type,1,0)+ IF( SELF.Diff_corp_name_status_cd,1,0)+ IF( SELF.Diff_corp_name_status_date,1,0)+ IF( SELF.Diff_corp_name_status_description,1,0)+ IF( SELF.Diff_corp_nonprofitirsapprovedpurpose,1,0)+ IF( SELF.Diff_corp_nonprofitsolicitdonations,1,0)+ IF( SELF.Diff_corp_number_of_amendments,1,0)+ IF( SELF.Diff_corp_number_of_initial_llc_members,1,0)+ IF( SELF.Diff_corp_number_of_partners,1,0)+ IF( SELF.Diff_corp_operatingagreement,1,0)+ IF( SELF.Diff_corp_opt_in_llc_act_description,1,0)+ IF( SELF.Diff_corp_opt_in_llc_act_ind,1,0)+ IF( SELF.Diff_corp_organizational_comments,1,0)+ IF( SELF.Diff_corp_original_business_type,1,0)+ IF( SELF.Diff_corp_partner_contributions_total,1,0)+ IF( SELF.Diff_corp_partner_terms,1,0)+ IF( SELF.Diff_corp_percentage_voters_required_to_approve_amendments,1,0)+ IF( SELF.Diff_corp_profession,1,0)+ IF( SELF.Diff_corp_province,1,0)+ IF( SELF.Diff_corp_public_mutual_corporation,1,0)+ IF( SELF.Diff_corp_purpose,1,0)+ IF( SELF.Diff_corp_ra_required_flag,1,0)+ IF( SELF.Diff_corp_registered_counties,1,0)+ IF( SELF.Diff_corp_regulated_ind,1,0)+ IF( SELF.Diff_corp_renewal_date,1,0)+ IF( SELF.Diff_corp_standing_other,1,0)+ IF( SELF.Diff_corp_survivor_corporation_id,1,0)+ IF( SELF.Diff_corp_tax_base,1,0)+ IF( SELF.Diff_corp_tax_standing,1,0)+ IF( SELF.Diff_corp_termination_code,1,0)+ IF( SELF.Diff_corp_termination_description,1,0)+ IF( SELF.Diff_corp_termination_date,1,0)+ IF( SELF.Diff_corp_trademark_classification_number,1,0)+ IF( SELF.Diff_corp_trademark_first_use_date,1,0)+ IF( SELF.Diff_corp_trademark_first_use_date_in_state,1,0)+ IF( SELF.Diff_corp_trademark_business_mark_type,1,0)+ IF( SELF.Diff_corp_trademark_cancelled_date,1,0)+ IF( SELF.Diff_corp_trademark_class_description1,1,0)+ IF( SELF.Diff_corp_trademark_class_description2,1,0)+ IF( SELF.Diff_corp_trademark_class_description3,1,0)+ IF( SELF.Diff_corp_trademark_class_description4,1,0)+ IF( SELF.Diff_corp_trademark_class_description5,1,0)+ IF( SELF.Diff_corp_trademark_class_description6,1,0)+ IF( SELF.Diff_corp_trademark_disclaimer1,1,0)+ IF( SELF.Diff_corp_trademark_disclaimer2,1,0)+ IF( SELF.Diff_corp_trademark_expiration_date,1,0)+ IF( SELF.Diff_corp_trademark_filing_date,1,0)+ IF( SELF.Diff_corp_trademark_keywords,1,0)+ IF( SELF.Diff_corp_trademark_logo,1,0)+ IF( SELF.Diff_corp_trademark_name_expiration_date,1,0)+ IF( SELF.Diff_corp_trademark_number,1,0)+ IF( SELF.Diff_corp_trademark_renewal_date,1,0)+ IF( SELF.Diff_corp_trademark_status,1,0)+ IF( SELF.Diff_corp_trademark_used_1,1,0)+ IF( SELF.Diff_corp_trademark_used_2,1,0)+ IF( SELF.Diff_corp_trademark_used_3,1,0)+ IF( SELF.Diff_cont_owner_percentage,1,0)+ IF( SELF.Diff_cont_country,1,0)+ IF( SELF.Diff_cont_country_mailing,1,0)+ IF( SELF.Diff_cont_nondislosure,1,0)+ IF( SELF.Diff_cont_prep_addr_line1,1,0)+ IF( SELF.Diff_cont_prep_addr_last_line,1,0)+ IF( SELF.Diff_recordorigin,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_corp_ra_dt_first_seen := COUNT(GROUP,%Closest%.Diff_corp_ra_dt_first_seen);
    Count_Diff_corp_ra_dt_last_seen := COUNT(GROUP,%Closest%.Diff_corp_ra_dt_last_seen);
    Count_Diff_corp_key := COUNT(GROUP,%Closest%.Diff_corp_key);
    Count_Diff_corp_supp_key := COUNT(GROUP,%Closest%.Diff_corp_supp_key);
    Count_Diff_corp_vendor := COUNT(GROUP,%Closest%.Diff_corp_vendor);
    Count_Diff_corp_vendor_county := COUNT(GROUP,%Closest%.Diff_corp_vendor_county);
    Count_Diff_corp_vendor_subcode := COUNT(GROUP,%Closest%.Diff_corp_vendor_subcode);
    Count_Diff_corp_state_origin := COUNT(GROUP,%Closest%.Diff_corp_state_origin);
    Count_Diff_corp_process_date := COUNT(GROUP,%Closest%.Diff_corp_process_date);
    Count_Diff_corp_orig_sos_charter_nbr := COUNT(GROUP,%Closest%.Diff_corp_orig_sos_charter_nbr);
    Count_Diff_corp_legal_name := COUNT(GROUP,%Closest%.Diff_corp_legal_name);
    Count_Diff_corp_ln_name_type_cd := COUNT(GROUP,%Closest%.Diff_corp_ln_name_type_cd);
    Count_Diff_corp_ln_name_type_desc := COUNT(GROUP,%Closest%.Diff_corp_ln_name_type_desc);
    Count_Diff_corp_supp_nbr := COUNT(GROUP,%Closest%.Diff_corp_supp_nbr);
    Count_Diff_corp_name_comment := COUNT(GROUP,%Closest%.Diff_corp_name_comment);
    Count_Diff_corp_address1_type_cd := COUNT(GROUP,%Closest%.Diff_corp_address1_type_cd);
    Count_Diff_corp_address1_type_desc := COUNT(GROUP,%Closest%.Diff_corp_address1_type_desc);
    Count_Diff_corp_address1_line1 := COUNT(GROUP,%Closest%.Diff_corp_address1_line1);
    Count_Diff_corp_address1_line2 := COUNT(GROUP,%Closest%.Diff_corp_address1_line2);
    Count_Diff_corp_address1_line3 := COUNT(GROUP,%Closest%.Diff_corp_address1_line3);
    Count_Diff_corp_address1_effective_date := COUNT(GROUP,%Closest%.Diff_corp_address1_effective_date);
    Count_Diff_corp_address2_type_cd := COUNT(GROUP,%Closest%.Diff_corp_address2_type_cd);
    Count_Diff_corp_address2_type_desc := COUNT(GROUP,%Closest%.Diff_corp_address2_type_desc);
    Count_Diff_corp_address2_line1 := COUNT(GROUP,%Closest%.Diff_corp_address2_line1);
    Count_Diff_corp_address2_line2 := COUNT(GROUP,%Closest%.Diff_corp_address2_line2);
    Count_Diff_corp_address2_line3 := COUNT(GROUP,%Closest%.Diff_corp_address2_line3);
    Count_Diff_corp_address2_effective_date := COUNT(GROUP,%Closest%.Diff_corp_address2_effective_date);
    Count_Diff_corp_phone_number := COUNT(GROUP,%Closest%.Diff_corp_phone_number);
    Count_Diff_corp_phone_number_type_cd := COUNT(GROUP,%Closest%.Diff_corp_phone_number_type_cd);
    Count_Diff_corp_phone_number_type_desc := COUNT(GROUP,%Closest%.Diff_corp_phone_number_type_desc);
    Count_Diff_corp_fax_nbr := COUNT(GROUP,%Closest%.Diff_corp_fax_nbr);
    Count_Diff_corp_email_address := COUNT(GROUP,%Closest%.Diff_corp_email_address);
    Count_Diff_corp_web_address := COUNT(GROUP,%Closest%.Diff_corp_web_address);
    Count_Diff_corp_filing_reference_nbr := COUNT(GROUP,%Closest%.Diff_corp_filing_reference_nbr);
    Count_Diff_corp_filing_date := COUNT(GROUP,%Closest%.Diff_corp_filing_date);
    Count_Diff_corp_filing_cd := COUNT(GROUP,%Closest%.Diff_corp_filing_cd);
    Count_Diff_corp_filing_desc := COUNT(GROUP,%Closest%.Diff_corp_filing_desc);
    Count_Diff_corp_status_cd := COUNT(GROUP,%Closest%.Diff_corp_status_cd);
    Count_Diff_corp_status_desc := COUNT(GROUP,%Closest%.Diff_corp_status_desc);
    Count_Diff_corp_inc_state := COUNT(GROUP,%Closest%.Diff_corp_inc_state);
    Count_Diff_corp_inc_county := COUNT(GROUP,%Closest%.Diff_corp_inc_county);
    Count_Diff_corp_inc_date := COUNT(GROUP,%Closest%.Diff_corp_inc_date);
    Count_Diff_corp_anniversary_month := COUNT(GROUP,%Closest%.Diff_corp_anniversary_month);
    Count_Diff_corp_fed_tax_id := COUNT(GROUP,%Closest%.Diff_corp_fed_tax_id);
    Count_Diff_corp_state_tax_id := COUNT(GROUP,%Closest%.Diff_corp_state_tax_id);
    Count_Diff_corp_term_exist_cd := COUNT(GROUP,%Closest%.Diff_corp_term_exist_cd);
    Count_Diff_corp_term_exist_exp := COUNT(GROUP,%Closest%.Diff_corp_term_exist_exp);
    Count_Diff_corp_term_exist_desc := COUNT(GROUP,%Closest%.Diff_corp_term_exist_desc);
    Count_Diff_corp_foreign_domestic_ind := COUNT(GROUP,%Closest%.Diff_corp_foreign_domestic_ind);
    Count_Diff_corp_forgn_state_cd := COUNT(GROUP,%Closest%.Diff_corp_forgn_state_cd);
    Count_Diff_corp_forgn_state_desc := COUNT(GROUP,%Closest%.Diff_corp_forgn_state_desc);
    Count_Diff_corp_forgn_sos_charter_nbr := COUNT(GROUP,%Closest%.Diff_corp_forgn_sos_charter_nbr);
    Count_Diff_corp_forgn_date := COUNT(GROUP,%Closest%.Diff_corp_forgn_date);
    Count_Diff_corp_forgn_fed_tax_id := COUNT(GROUP,%Closest%.Diff_corp_forgn_fed_tax_id);
    Count_Diff_corp_forgn_state_tax_id := COUNT(GROUP,%Closest%.Diff_corp_forgn_state_tax_id);
    Count_Diff_corp_forgn_term_exist_cd := COUNT(GROUP,%Closest%.Diff_corp_forgn_term_exist_cd);
    Count_Diff_corp_forgn_term_exist_exp := COUNT(GROUP,%Closest%.Diff_corp_forgn_term_exist_exp);
    Count_Diff_corp_forgn_term_exist_desc := COUNT(GROUP,%Closest%.Diff_corp_forgn_term_exist_desc);
    Count_Diff_corp_orig_org_structure_cd := COUNT(GROUP,%Closest%.Diff_corp_orig_org_structure_cd);
    Count_Diff_corp_orig_org_structure_desc := COUNT(GROUP,%Closest%.Diff_corp_orig_org_structure_desc);
    Count_Diff_corp_for_profit_ind := COUNT(GROUP,%Closest%.Diff_corp_for_profit_ind);
    Count_Diff_corp_public_or_private_ind := COUNT(GROUP,%Closest%.Diff_corp_public_or_private_ind);
    Count_Diff_corp_sic_code := COUNT(GROUP,%Closest%.Diff_corp_sic_code);
    Count_Diff_corp_naic_code := COUNT(GROUP,%Closest%.Diff_corp_naic_code);
    Count_Diff_corp_orig_bus_type_cd := COUNT(GROUP,%Closest%.Diff_corp_orig_bus_type_cd);
    Count_Diff_corp_orig_bus_type_desc := COUNT(GROUP,%Closest%.Diff_corp_orig_bus_type_desc);
    Count_Diff_corp_entity_desc := COUNT(GROUP,%Closest%.Diff_corp_entity_desc);
    Count_Diff_corp_certificate_nbr := COUNT(GROUP,%Closest%.Diff_corp_certificate_nbr);
    Count_Diff_corp_internal_nbr := COUNT(GROUP,%Closest%.Diff_corp_internal_nbr);
    Count_Diff_corp_previous_nbr := COUNT(GROUP,%Closest%.Diff_corp_previous_nbr);
    Count_Diff_corp_microfilm_nbr := COUNT(GROUP,%Closest%.Diff_corp_microfilm_nbr);
    Count_Diff_corp_amendments_filed := COUNT(GROUP,%Closest%.Diff_corp_amendments_filed);
    Count_Diff_corp_acts := COUNT(GROUP,%Closest%.Diff_corp_acts);
    Count_Diff_corp_partnership_ind := COUNT(GROUP,%Closest%.Diff_corp_partnership_ind);
    Count_Diff_corp_mfg_ind := COUNT(GROUP,%Closest%.Diff_corp_mfg_ind);
    Count_Diff_corp_addl_info := COUNT(GROUP,%Closest%.Diff_corp_addl_info);
    Count_Diff_corp_taxes := COUNT(GROUP,%Closest%.Diff_corp_taxes);
    Count_Diff_corp_franchise_taxes := COUNT(GROUP,%Closest%.Diff_corp_franchise_taxes);
    Count_Diff_corp_tax_program_cd := COUNT(GROUP,%Closest%.Diff_corp_tax_program_cd);
    Count_Diff_corp_tax_program_desc := COUNT(GROUP,%Closest%.Diff_corp_tax_program_desc);
    Count_Diff_corp_ra_full_name := COUNT(GROUP,%Closest%.Diff_corp_ra_full_name);
    Count_Diff_corp_ra_fname := COUNT(GROUP,%Closest%.Diff_corp_ra_fname);
    Count_Diff_corp_ra_mname := COUNT(GROUP,%Closest%.Diff_corp_ra_mname);
    Count_Diff_corp_ra_lname := COUNT(GROUP,%Closest%.Diff_corp_ra_lname);
    Count_Diff_corp_ra_suffix := COUNT(GROUP,%Closest%.Diff_corp_ra_suffix);
    Count_Diff_corp_ra_title_cd := COUNT(GROUP,%Closest%.Diff_corp_ra_title_cd);
    Count_Diff_corp_ra_title_desc := COUNT(GROUP,%Closest%.Diff_corp_ra_title_desc);
    Count_Diff_corp_ra_fein := COUNT(GROUP,%Closest%.Diff_corp_ra_fein);
    Count_Diff_corp_ra_ssn := COUNT(GROUP,%Closest%.Diff_corp_ra_ssn);
    Count_Diff_corp_ra_dob := COUNT(GROUP,%Closest%.Diff_corp_ra_dob);
    Count_Diff_corp_ra_effective_date := COUNT(GROUP,%Closest%.Diff_corp_ra_effective_date);
    Count_Diff_corp_ra_resign_date := COUNT(GROUP,%Closest%.Diff_corp_ra_resign_date);
    Count_Diff_corp_ra_no_comp := COUNT(GROUP,%Closest%.Diff_corp_ra_no_comp);
    Count_Diff_corp_ra_no_comp_igs := COUNT(GROUP,%Closest%.Diff_corp_ra_no_comp_igs);
    Count_Diff_corp_ra_addl_info := COUNT(GROUP,%Closest%.Diff_corp_ra_addl_info);
    Count_Diff_corp_ra_address_type_cd := COUNT(GROUP,%Closest%.Diff_corp_ra_address_type_cd);
    Count_Diff_corp_ra_address_type_desc := COUNT(GROUP,%Closest%.Diff_corp_ra_address_type_desc);
    Count_Diff_corp_ra_address_line1 := COUNT(GROUP,%Closest%.Diff_corp_ra_address_line1);
    Count_Diff_corp_ra_address_line2 := COUNT(GROUP,%Closest%.Diff_corp_ra_address_line2);
    Count_Diff_corp_ra_address_line3 := COUNT(GROUP,%Closest%.Diff_corp_ra_address_line3);
    Count_Diff_corp_ra_phone_number := COUNT(GROUP,%Closest%.Diff_corp_ra_phone_number);
    Count_Diff_corp_ra_phone_number_type_cd := COUNT(GROUP,%Closest%.Diff_corp_ra_phone_number_type_cd);
    Count_Diff_corp_ra_phone_number_type_desc := COUNT(GROUP,%Closest%.Diff_corp_ra_phone_number_type_desc);
    Count_Diff_corp_ra_fax_nbr := COUNT(GROUP,%Closest%.Diff_corp_ra_fax_nbr);
    Count_Diff_corp_ra_email_address := COUNT(GROUP,%Closest%.Diff_corp_ra_email_address);
    Count_Diff_corp_ra_web_address := COUNT(GROUP,%Closest%.Diff_corp_ra_web_address);
    Count_Diff_corp_prep_addr1_line1 := COUNT(GROUP,%Closest%.Diff_corp_prep_addr1_line1);
    Count_Diff_corp_prep_addr1_last_line := COUNT(GROUP,%Closest%.Diff_corp_prep_addr1_last_line);
    Count_Diff_corp_prep_addr2_line1 := COUNT(GROUP,%Closest%.Diff_corp_prep_addr2_line1);
    Count_Diff_corp_prep_addr2_last_line := COUNT(GROUP,%Closest%.Diff_corp_prep_addr2_last_line);
    Count_Diff_ra_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_ra_prep_addr_line1);
    Count_Diff_ra_prep_addr_last_line := COUNT(GROUP,%Closest%.Diff_ra_prep_addr_last_line);
    Count_Diff_cont_filing_reference_nbr := COUNT(GROUP,%Closest%.Diff_cont_filing_reference_nbr);
    Count_Diff_cont_filing_date := COUNT(GROUP,%Closest%.Diff_cont_filing_date);
    Count_Diff_cont_filing_cd := COUNT(GROUP,%Closest%.Diff_cont_filing_cd);
    Count_Diff_cont_filing_desc := COUNT(GROUP,%Closest%.Diff_cont_filing_desc);
    Count_Diff_cont_type_cd := COUNT(GROUP,%Closest%.Diff_cont_type_cd);
    Count_Diff_cont_type_desc := COUNT(GROUP,%Closest%.Diff_cont_type_desc);
    Count_Diff_cont_full_name := COUNT(GROUP,%Closest%.Diff_cont_full_name);
    Count_Diff_cont_fname := COUNT(GROUP,%Closest%.Diff_cont_fname);
    Count_Diff_cont_mname := COUNT(GROUP,%Closest%.Diff_cont_mname);
    Count_Diff_cont_lname := COUNT(GROUP,%Closest%.Diff_cont_lname);
    Count_Diff_cont_suffix := COUNT(GROUP,%Closest%.Diff_cont_suffix);
    Count_Diff_cont_title1_desc := COUNT(GROUP,%Closest%.Diff_cont_title1_desc);
    Count_Diff_cont_title2_desc := COUNT(GROUP,%Closest%.Diff_cont_title2_desc);
    Count_Diff_cont_title3_desc := COUNT(GROUP,%Closest%.Diff_cont_title3_desc);
    Count_Diff_cont_title4_desc := COUNT(GROUP,%Closest%.Diff_cont_title4_desc);
    Count_Diff_cont_title5_desc := COUNT(GROUP,%Closest%.Diff_cont_title5_desc);
    Count_Diff_cont_fein := COUNT(GROUP,%Closest%.Diff_cont_fein);
    Count_Diff_cont_ssn := COUNT(GROUP,%Closest%.Diff_cont_ssn);
    Count_Diff_cont_dob := COUNT(GROUP,%Closest%.Diff_cont_dob);
    Count_Diff_cont_status_cd := COUNT(GROUP,%Closest%.Diff_cont_status_cd);
    Count_Diff_cont_status_desc := COUNT(GROUP,%Closest%.Diff_cont_status_desc);
    Count_Diff_cont_effective_date := COUNT(GROUP,%Closest%.Diff_cont_effective_date);
    Count_Diff_cont_effective_cd := COUNT(GROUP,%Closest%.Diff_cont_effective_cd);
    Count_Diff_cont_effective_desc := COUNT(GROUP,%Closest%.Diff_cont_effective_desc);
    Count_Diff_cont_addl_info := COUNT(GROUP,%Closest%.Diff_cont_addl_info);
    Count_Diff_cont_address_type_cd := COUNT(GROUP,%Closest%.Diff_cont_address_type_cd);
    Count_Diff_cont_address_type_desc := COUNT(GROUP,%Closest%.Diff_cont_address_type_desc);
    Count_Diff_cont_address_line1 := COUNT(GROUP,%Closest%.Diff_cont_address_line1);
    Count_Diff_cont_address_line2 := COUNT(GROUP,%Closest%.Diff_cont_address_line2);
    Count_Diff_cont_address_line3 := COUNT(GROUP,%Closest%.Diff_cont_address_line3);
    Count_Diff_cont_address_effective_date := COUNT(GROUP,%Closest%.Diff_cont_address_effective_date);
    Count_Diff_cont_address_county := COUNT(GROUP,%Closest%.Diff_cont_address_county);
    Count_Diff_cont_phone_number := COUNT(GROUP,%Closest%.Diff_cont_phone_number);
    Count_Diff_cont_phone_number_type_cd := COUNT(GROUP,%Closest%.Diff_cont_phone_number_type_cd);
    Count_Diff_cont_phone_number_type_desc := COUNT(GROUP,%Closest%.Diff_cont_phone_number_type_desc);
    Count_Diff_cont_fax_nbr := COUNT(GROUP,%Closest%.Diff_cont_fax_nbr);
    Count_Diff_cont_email_address := COUNT(GROUP,%Closest%.Diff_cont_email_address);
    Count_Diff_cont_web_address := COUNT(GROUP,%Closest%.Diff_cont_web_address);
    Count_Diff_corp_acres := COUNT(GROUP,%Closest%.Diff_corp_acres);
    Count_Diff_corp_action := COUNT(GROUP,%Closest%.Diff_corp_action);
    Count_Diff_corp_action_date := COUNT(GROUP,%Closest%.Diff_corp_action_date);
    Count_Diff_corp_action_employment_security_approval_date := COUNT(GROUP,%Closest%.Diff_corp_action_employment_security_approval_date);
    Count_Diff_corp_action_pending_code := COUNT(GROUP,%Closest%.Diff_corp_action_pending_code);
    Count_Diff_corp_action_pending_description := COUNT(GROUP,%Closest%.Diff_corp_action_pending_description);
    Count_Diff_corp_action_statement_of_intent_date := COUNT(GROUP,%Closest%.Diff_corp_action_statement_of_intent_date);
    Count_Diff_corp_action_tax_dept_approval_date := COUNT(GROUP,%Closest%.Diff_corp_action_tax_dept_approval_date);
    Count_Diff_corp_acts2 := COUNT(GROUP,%Closest%.Diff_corp_acts2);
    Count_Diff_corp_acts3 := COUNT(GROUP,%Closest%.Diff_corp_acts3);
    Count_Diff_corp_additional_principals := COUNT(GROUP,%Closest%.Diff_corp_additional_principals);
    Count_Diff_corp_address_office_type := COUNT(GROUP,%Closest%.Diff_corp_address_office_type);
    Count_Diff_corp_agent_commercial := COUNT(GROUP,%Closest%.Diff_corp_agent_commercial);
    Count_Diff_corp_agent_country := COUNT(GROUP,%Closest%.Diff_corp_agent_country);
    Count_Diff_corp_agent_county := COUNT(GROUP,%Closest%.Diff_corp_agent_county);
    Count_Diff_corp_agent_status_cd := COUNT(GROUP,%Closest%.Diff_corp_agent_status_cd);
    Count_Diff_corp_agent_status_desc := COUNT(GROUP,%Closest%.Diff_corp_agent_status_desc);
    Count_Diff_corp_agent_id := COUNT(GROUP,%Closest%.Diff_corp_agent_id);
    Count_Diff_corp_agent_assign_date := COUNT(GROUP,%Closest%.Diff_corp_agent_assign_date);
    Count_Diff_corp_agriculture_flag := COUNT(GROUP,%Closest%.Diff_corp_agriculture_flag);
    Count_Diff_corp_authorized_partners := COUNT(GROUP,%Closest%.Diff_corp_authorized_partners);
    Count_Diff_corp_cmt := COUNT(GROUP,%Closest%.Diff_corp_cmt);
    Count_Diff_corp_consent_flag_for_protected_name := COUNT(GROUP,%Closest%.Diff_corp_consent_flag_for_protected_name);
    Count_Diff_corp_converted := COUNT(GROUP,%Closest%.Diff_corp_converted);
    Count_Diff_corp_converted_from := COUNT(GROUP,%Closest%.Diff_corp_converted_from);
    Count_Diff_corp_country_of_formation := COUNT(GROUP,%Closest%.Diff_corp_country_of_formation);
    Count_Diff_corp_date_of_organization_meeting := COUNT(GROUP,%Closest%.Diff_corp_date_of_organization_meeting);
    Count_Diff_corp_delayed_effective_date := COUNT(GROUP,%Closest%.Diff_corp_delayed_effective_date);
    Count_Diff_corp_directors_from_to := COUNT(GROUP,%Closest%.Diff_corp_directors_from_to);
    Count_Diff_corp_dissolved_date := COUNT(GROUP,%Closest%.Diff_corp_dissolved_date);
    Count_Diff_corp_farm_exemptions := COUNT(GROUP,%Closest%.Diff_corp_farm_exemptions);
    Count_Diff_corp_farm_qual_date := COUNT(GROUP,%Closest%.Diff_corp_farm_qual_date);
    Count_Diff_corp_farm_status_cd := COUNT(GROUP,%Closest%.Diff_corp_farm_status_cd);
    Count_Diff_corp_farm_status_desc := COUNT(GROUP,%Closest%.Diff_corp_farm_status_desc);
    Count_Diff_corp_farm_status_date := COUNT(GROUP,%Closest%.Diff_corp_farm_status_date);
    Count_Diff_corp_fiscal_year_month := COUNT(GROUP,%Closest%.Diff_corp_fiscal_year_month);
    Count_Diff_corp_foreign_fiduciary_capacity_in_state := COUNT(GROUP,%Closest%.Diff_corp_foreign_fiduciary_capacity_in_state);
    Count_Diff_corp_governing_statute := COUNT(GROUP,%Closest%.Diff_corp_governing_statute);
    Count_Diff_corp_hasmembers := COUNT(GROUP,%Closest%.Diff_corp_hasmembers);
    Count_Diff_corp_hasvestedmanagers := COUNT(GROUP,%Closest%.Diff_corp_hasvestedmanagers);
    Count_Diff_corp_home_incorporated_county := COUNT(GROUP,%Closest%.Diff_corp_home_incorporated_county);
    Count_Diff_corp_home_state_name := COUNT(GROUP,%Closest%.Diff_corp_home_state_name);
    Count_Diff_corp_is_professional := COUNT(GROUP,%Closest%.Diff_corp_is_professional);
    Count_Diff_corp_isnonprofitirsapproved := COUNT(GROUP,%Closest%.Diff_corp_isnonprofitirsapproved);
    Count_Diff_corp_last_renewal_date := COUNT(GROUP,%Closest%.Diff_corp_last_renewal_date);
    Count_Diff_corp_last_renewal_year := COUNT(GROUP,%Closest%.Diff_corp_last_renewal_year);
    Count_Diff_corp_license_type := COUNT(GROUP,%Closest%.Diff_corp_license_type);
    Count_Diff_corp_llc_managed_cd := COUNT(GROUP,%Closest%.Diff_corp_llc_managed_cd);
    Count_Diff_corp_llc_managed_desc := COUNT(GROUP,%Closest%.Diff_corp_llc_managed_desc);
    Count_Diff_corp_management_description := COUNT(GROUP,%Closest%.Diff_corp_management_description);
    Count_Diff_corp_management_type := COUNT(GROUP,%Closest%.Diff_corp_management_type);
    Count_Diff_corp_manager_managed := COUNT(GROUP,%Closest%.Diff_corp_manager_managed);
    Count_Diff_corp_merged_corporation_id := COUNT(GROUP,%Closest%.Diff_corp_merged_corporation_id);
    Count_Diff_corp_merged_fein := COUNT(GROUP,%Closest%.Diff_corp_merged_fein);
    Count_Diff_corp_merger_allowed_flag := COUNT(GROUP,%Closest%.Diff_corp_merger_allowed_flag);
    Count_Diff_corp_merger_date := COUNT(GROUP,%Closest%.Diff_corp_merger_date);
    Count_Diff_corp_merger_description := COUNT(GROUP,%Closest%.Diff_corp_merger_description);
    Count_Diff_corp_merger_effective_date := COUNT(GROUP,%Closest%.Diff_corp_merger_effective_date);
    Count_Diff_corp_merger_id := COUNT(GROUP,%Closest%.Diff_corp_merger_id);
    Count_Diff_corp_merger_indicator := COUNT(GROUP,%Closest%.Diff_corp_merger_indicator);
    Count_Diff_corp_merger_name := COUNT(GROUP,%Closest%.Diff_corp_merger_name);
    Count_Diff_corp_merger_type_converted_to_code := COUNT(GROUP,%Closest%.Diff_corp_merger_type_converted_to_code);
    Count_Diff_corp_merger_type_converted_to_description := COUNT(GROUP,%Closest%.Diff_corp_merger_type_converted_to_description);
    Count_Diff_corp_naics_description := COUNT(GROUP,%Closest%.Diff_corp_naics_description);
    Count_Diff_corp_name_effective_date := COUNT(GROUP,%Closest%.Diff_corp_name_effective_date);
    Count_Diff_corp_name_reservation_date := COUNT(GROUP,%Closest%.Diff_corp_name_reservation_date);
    Count_Diff_corp_name_reservation_expiration_date := COUNT(GROUP,%Closest%.Diff_corp_name_reservation_expiration_date);
    Count_Diff_corp_name_reservation_number := COUNT(GROUP,%Closest%.Diff_corp_name_reservation_number);
    Count_Diff_corp_name_reservation_type := COUNT(GROUP,%Closest%.Diff_corp_name_reservation_type);
    Count_Diff_corp_name_status_cd := COUNT(GROUP,%Closest%.Diff_corp_name_status_cd);
    Count_Diff_corp_name_status_date := COUNT(GROUP,%Closest%.Diff_corp_name_status_date);
    Count_Diff_corp_name_status_description := COUNT(GROUP,%Closest%.Diff_corp_name_status_description);
    Count_Diff_corp_nonprofitirsapprovedpurpose := COUNT(GROUP,%Closest%.Diff_corp_nonprofitirsapprovedpurpose);
    Count_Diff_corp_nonprofitsolicitdonations := COUNT(GROUP,%Closest%.Diff_corp_nonprofitsolicitdonations);
    Count_Diff_corp_number_of_amendments := COUNT(GROUP,%Closest%.Diff_corp_number_of_amendments);
    Count_Diff_corp_number_of_initial_llc_members := COUNT(GROUP,%Closest%.Diff_corp_number_of_initial_llc_members);
    Count_Diff_corp_number_of_partners := COUNT(GROUP,%Closest%.Diff_corp_number_of_partners);
    Count_Diff_corp_operatingagreement := COUNT(GROUP,%Closest%.Diff_corp_operatingagreement);
    Count_Diff_corp_opt_in_llc_act_description := COUNT(GROUP,%Closest%.Diff_corp_opt_in_llc_act_description);
    Count_Diff_corp_opt_in_llc_act_ind := COUNT(GROUP,%Closest%.Diff_corp_opt_in_llc_act_ind);
    Count_Diff_corp_organizational_comments := COUNT(GROUP,%Closest%.Diff_corp_organizational_comments);
    Count_Diff_corp_original_business_type := COUNT(GROUP,%Closest%.Diff_corp_original_business_type);
    Count_Diff_corp_partner_contributions_total := COUNT(GROUP,%Closest%.Diff_corp_partner_contributions_total);
    Count_Diff_corp_partner_terms := COUNT(GROUP,%Closest%.Diff_corp_partner_terms);
    Count_Diff_corp_percentage_voters_required_to_approve_amendments := COUNT(GROUP,%Closest%.Diff_corp_percentage_voters_required_to_approve_amendments);
    Count_Diff_corp_profession := COUNT(GROUP,%Closest%.Diff_corp_profession);
    Count_Diff_corp_province := COUNT(GROUP,%Closest%.Diff_corp_province);
    Count_Diff_corp_public_mutual_corporation := COUNT(GROUP,%Closest%.Diff_corp_public_mutual_corporation);
    Count_Diff_corp_purpose := COUNT(GROUP,%Closest%.Diff_corp_purpose);
    Count_Diff_corp_ra_required_flag := COUNT(GROUP,%Closest%.Diff_corp_ra_required_flag);
    Count_Diff_corp_registered_counties := COUNT(GROUP,%Closest%.Diff_corp_registered_counties);
    Count_Diff_corp_regulated_ind := COUNT(GROUP,%Closest%.Diff_corp_regulated_ind);
    Count_Diff_corp_renewal_date := COUNT(GROUP,%Closest%.Diff_corp_renewal_date);
    Count_Diff_corp_standing_other := COUNT(GROUP,%Closest%.Diff_corp_standing_other);
    Count_Diff_corp_survivor_corporation_id := COUNT(GROUP,%Closest%.Diff_corp_survivor_corporation_id);
    Count_Diff_corp_tax_base := COUNT(GROUP,%Closest%.Diff_corp_tax_base);
    Count_Diff_corp_tax_standing := COUNT(GROUP,%Closest%.Diff_corp_tax_standing);
    Count_Diff_corp_termination_code := COUNT(GROUP,%Closest%.Diff_corp_termination_code);
    Count_Diff_corp_termination_description := COUNT(GROUP,%Closest%.Diff_corp_termination_description);
    Count_Diff_corp_termination_date := COUNT(GROUP,%Closest%.Diff_corp_termination_date);
    Count_Diff_corp_trademark_classification_number := COUNT(GROUP,%Closest%.Diff_corp_trademark_classification_number);
    Count_Diff_corp_trademark_first_use_date := COUNT(GROUP,%Closest%.Diff_corp_trademark_first_use_date);
    Count_Diff_corp_trademark_first_use_date_in_state := COUNT(GROUP,%Closest%.Diff_corp_trademark_first_use_date_in_state);
    Count_Diff_corp_trademark_business_mark_type := COUNT(GROUP,%Closest%.Diff_corp_trademark_business_mark_type);
    Count_Diff_corp_trademark_cancelled_date := COUNT(GROUP,%Closest%.Diff_corp_trademark_cancelled_date);
    Count_Diff_corp_trademark_class_description1 := COUNT(GROUP,%Closest%.Diff_corp_trademark_class_description1);
    Count_Diff_corp_trademark_class_description2 := COUNT(GROUP,%Closest%.Diff_corp_trademark_class_description2);
    Count_Diff_corp_trademark_class_description3 := COUNT(GROUP,%Closest%.Diff_corp_trademark_class_description3);
    Count_Diff_corp_trademark_class_description4 := COUNT(GROUP,%Closest%.Diff_corp_trademark_class_description4);
    Count_Diff_corp_trademark_class_description5 := COUNT(GROUP,%Closest%.Diff_corp_trademark_class_description5);
    Count_Diff_corp_trademark_class_description6 := COUNT(GROUP,%Closest%.Diff_corp_trademark_class_description6);
    Count_Diff_corp_trademark_disclaimer1 := COUNT(GROUP,%Closest%.Diff_corp_trademark_disclaimer1);
    Count_Diff_corp_trademark_disclaimer2 := COUNT(GROUP,%Closest%.Diff_corp_trademark_disclaimer2);
    Count_Diff_corp_trademark_expiration_date := COUNT(GROUP,%Closest%.Diff_corp_trademark_expiration_date);
    Count_Diff_corp_trademark_filing_date := COUNT(GROUP,%Closest%.Diff_corp_trademark_filing_date);
    Count_Diff_corp_trademark_keywords := COUNT(GROUP,%Closest%.Diff_corp_trademark_keywords);
    Count_Diff_corp_trademark_logo := COUNT(GROUP,%Closest%.Diff_corp_trademark_logo);
    Count_Diff_corp_trademark_name_expiration_date := COUNT(GROUP,%Closest%.Diff_corp_trademark_name_expiration_date);
    Count_Diff_corp_trademark_number := COUNT(GROUP,%Closest%.Diff_corp_trademark_number);
    Count_Diff_corp_trademark_renewal_date := COUNT(GROUP,%Closest%.Diff_corp_trademark_renewal_date);
    Count_Diff_corp_trademark_status := COUNT(GROUP,%Closest%.Diff_corp_trademark_status);
    Count_Diff_corp_trademark_used_1 := COUNT(GROUP,%Closest%.Diff_corp_trademark_used_1);
    Count_Diff_corp_trademark_used_2 := COUNT(GROUP,%Closest%.Diff_corp_trademark_used_2);
    Count_Diff_corp_trademark_used_3 := COUNT(GROUP,%Closest%.Diff_corp_trademark_used_3);
    Count_Diff_cont_owner_percentage := COUNT(GROUP,%Closest%.Diff_cont_owner_percentage);
    Count_Diff_cont_country := COUNT(GROUP,%Closest%.Diff_cont_country);
    Count_Diff_cont_country_mailing := COUNT(GROUP,%Closest%.Diff_cont_country_mailing);
    Count_Diff_cont_nondislosure := COUNT(GROUP,%Closest%.Diff_cont_nondislosure);
    Count_Diff_cont_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_cont_prep_addr_line1);
    Count_Diff_cont_prep_addr_last_line := COUNT(GROUP,%Closest%.Diff_cont_prep_addr_last_line);
    Count_Diff_recordorigin := COUNT(GROUP,%Closest%.Diff_recordorigin);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
