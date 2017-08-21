IMPORT BIPV2, Address;
EXPORT Layouts := MODULE
	EXPORT NCPDP_REC := RECORD
		unsigned6 dotid;
		unsigned2 dotscore;
		unsigned2 dotweight;
		unsigned6 empid;
		unsigned2 empscore;
		unsigned2 empweight;
		unsigned6 powid;
		unsigned2 powscore;
		unsigned2 powweight;
		unsigned6 proxid;
		unsigned2 proxscore;
		unsigned2 proxweight;
		unsigned6 seleid;
		unsigned2 selescore;
		unsigned2 seleweight;
		unsigned6 orgid;
		unsigned2 orgscore;
		unsigned2 orgweight;
		unsigned6 ultid;
		unsigned2 ultscore;
		unsigned2 ultweight;
		unsigned6 dt_first_seen;
		unsigned6 dt_last_seen;
		unsigned6 bdid;
		unsigned6 did;
		unsigned6 pid;
		string2 src;
		unsigned8 source_rid;
		unsigned8 lnpid;
		string1 record_type;
		string7 ncpdp_provider_id;
		string60 prov_info_legal_business_name;
		string60 prov_info_dba;
		string60 prov_info_doctor_name;
		string10 prov_info_store_number;
		string55 prov_info_phys_loc_address1;
		string55 prov_info_phys_loc_address2;
		string30 prov_info_phys_loc_city;
		string2 prov_info_phys_loc_state;
		string9 prov_info_phys_loc_full_zip;
		string10 prov_info_phys_loc_phone;
		string5 prov_info_phys_loc_phone_ext;
		string10 prov_info_phys_loc_fax_number;
		string50 prov_info_phys_loc_email;
		string50 prov_info_phys_loc_cross_street;
		string5 prov_info_phys_loc_fips;
		string4 prov_info_phys_loc_msa;
		string4 prov_info_phys_loc_pmsa;
		string1 prov_info_phys_loc_24hr_operation;
		string35 prov_info_phys_loc_provider_hours;
		string4 prov_info_phys_loc_voting_district;
		string2 prov_info_phys_loc_language_code1;
		string2 prov_info_phys_loc_language_code2;
		string2 prov_info_phys_loc_language_code3;
		string2 prov_info_phys_loc_language_code4;
		string2 prov_info_phys_loc_language_code5;
		string8 prov_info_phys_loc_store_open_date;
		string8 prov_info_phys_loc_store_close_date;
		string55 prov_info_address1;
		string55 prov_info_address2;
		string30 prov_info_city;
		string2 prov_info_state;
		string9 prov_info_full_zip;
		string20 prov_info_contact_last_name;
		string20 prov_info_contact_first_name;
		string1 prov_info_contact_middle_initial;
		string30 prov_info_contact_title;
		string10 prov_info_contact_phone;
		string5 prov_info_contact_phone_ext;
		string50 prov_info_contact_email;
		string2 prov_info_dispenser_class_code;
		string2 prov_info_primary_dispenser_type_code;
		string2 prov_info_secondary_dispenser_type_code;
		string2 prov_info_tertiary_dispenser_type_code;
		string10 prov_info_medicare_provider_id;
		string10 prov_info_national_provider_id;
		string12 prov_info_dea_registration_id;
		string15 prov_info_federal_tax_id;
		string15 prov_info_state_income_tax_id;
		string2 prov_info_deactivation_code;
		string2 prov_info_reinstatement_code;
		string1 prov_info_transaction_code;
		string20 prov_info_sundayhours;
		string20 prov_info_mondayhours;
		string20 prov_info_tuesdayhours;
		string20 prov_info_wednesdayhours;
		string20 prov_info_thursdayhours;
		string20 prov_info_fridayhours;
		string20 prov_info_saturdayhours;
		string20 prov_info_languagecode1desc;
		string20 prov_info_languagecode2desc;
		string20 prov_info_languagecode3desc;
		string20 prov_info_languagecode4desc;
		string20 prov_info_languagecode5desc;
		string25 prov_info_dispensingclassdesc;
		string70 prov_info_primarydispensingtypedesc;
		string70 prov_info_secondarydispensingtypedesc;
		string70 prov_info_tertiarydispensingtypedesc;
		unsigned6 prov_info_clean_dea_expiration_date;
		unsigned6 prov_info_clean_phys_loc_store_open_date;
		unsigned6 prov_info_clean_phys_loc_store_close_date;
		unsigned6 prov_info_clean_reinstatement_date;
		unsigned6 prov_info_clean_transaction_date;
		string100 prov_info_append_phyaddr1;
		string50 prov_info_append_phyaddrlast;
		unsigned8 prov_info_append_phyrawaid;
		unsigned8 prov_info_append_phyaceaid;
		string100 prov_info_append_mailaddr1;
		string50 prov_info_append_mailaddrlast;
		unsigned8 prov_info_append_mailrawaid;
		unsigned8 prov_info_append_mailaceaid;
		string20 prov_info_clean_dr_fname;
		string20 prov_info_clean_dr_mname;
		string20 prov_info_clean_dr_lname;
		string5 prov_info_clean_dr_suffix;
		string20 prov_info_clean_fname;
		string20 prov_info_clean_mname;
		string20 prov_info_clean_lname;
		string5 prov_info_clean_suffix;
		string10 prov_info_phys_prim_range;
		string2 prov_info_phys_predir;
		string28 prov_info_phys_prim_name;
		string4 prov_info_phys_addr_suffix;
		string2 prov_info_phys_postdir;
		string10 prov_info_phys_unit_desig;
		string8 prov_info_phys_sec_range;
		string25 prov_info_phys_p_city_name;
		string25 prov_info_phys_v_city_name;
		string2 prov_info_phys_state;
		string5 prov_info_phys_zip5;
		string4 prov_info_phys_zip4;
		string4 prov_info_phys_cart;
		string1 prov_info_phys_cr_sort_sz;
		string4 prov_info_phys_lot;
		string1 prov_info_phys_lot_order;
		string2 prov_info_phys_dpbc;
		string1 prov_info_phys_chk_digit;
		string2 prov_info_phys_rec_type;
		string2 prov_info_phys_ace_fips_st;
		string3 prov_info_phys_county;
		string10 prov_info_phys_geo_lat;
		string11 prov_info_phys_geo_long;
		string4 prov_info_phys_msa;
		string7 prov_info_phys_geo_blk;
		string1 prov_info_phys_geo_match;
		string4 prov_info_phys_err_stat;
		string10 prov_info_mail_prim_range;
		string2 prov_info_mail_predir;
		string28 prov_info_mail_prim_name;
		string4 prov_info_mail_addr_suffix;
		string2 prov_info_mail_postdir;
		string10 prov_info_mail_unit_desig;
		string8 prov_info_mail_sec_range;
		string25 prov_info_mail_p_city_name;
		string25 prov_info_mail_v_city_name;
		string2 prov_info_mail_state;
		string5 prov_info_mail_zip5;
		string4 prov_info_mail_zip4;
		string4 prov_info_mail_cart;
		string1 prov_info_mail_cr_sort_sz;
		string4 prov_info_mail_lot;
		string1 prov_info_mail_lot_order;
		string2 prov_info_mail_dpbc;
		string1 prov_info_mail_chk_digit;
		string2 prov_info_mail_rec_type;
		string2 prov_info_mail_ace_fips_st;
		string3 prov_info_mail_county;
		string10 prov_info_mail_geo_lat;
		string11 prov_info_mail_geo_long;
		string4 prov_info_mail_msa;
		string7 prov_info_mail_geo_blk;
		string1 prov_info_mail_geo_match;
		string4 prov_info_mail_err_stat;
		string3 prov_relat_relationship_id;
		string6 prov_relat_payment_center_id;
		string6 prov_relat_remit_and_reconciliation_id;
		string2 prov_relat_provider_type;
		string1 prov_relat_is_primary;
		string8 prov_relat_effective_from_date;
		string8 prov_relat_effective_through_date;
		unsigned6 prov_relat_clean_effect_from_date;
		unsigned6 prov_relat_clean_effect_through_date;
		string2 medicaid_state_code;
		string20 medicaid_id;
		unsigned6 medicaid_clean_delete_date;
		string10 taxonomy_code;
		string2 taxonomy_provider_type_code;
		unsigned6 taxonomy_clean_delete_date;
		string3 demographic_id;
		string2 demographic_type;
		string35 demographic_name;
		string10 demographic_phone_number;
		string5 demographic_extension;
		string10 demographic_fax_number;
		string10 demographic_npi;
		string15 demographic_federal_tax_id;
		string30 demographic_contact_name;
		string30 demographic_contact_title;
		string50 demographic_contact_email;
		string30 demographic_contractual_contact_name;
		string30 demographic_contractual_contact_title;
		string50 demographic_contractual_contact_email;
		string30 demographic_operational_contact_name;
		string30 demographic_operational_contact_title;
		string50 demographic_operational_contact_email;
		string30 demographic_technical_contact_name;
		string30 demographic_technical_contact_title;
		string50 demographic_technical_contact_email;
		string30 demographic_audit_contact_name;
		string30 demographic_audit_contact_title;
		string50 demographic_audit_contact_email;
		string6 demographic_parent_organization_id;
		unsigned6 demographic_clean_effect_from_date;
		unsigned6 demographic_clean_delete_date;
		string100 demographic_append_addr1;
		string50 demographic_append_addrlast;
		unsigned8 demographic_append_rawaid;
		unsigned8 demographic_append_aceaid;
		string20 demographic_clean_contact_fname;
		string20 demographic_clean_contact_mname;
		string20 demographic_clean_contact_lname;
		string5 demographic_clean_contact_suffix;
		string20 demographic_clean_contractual_contact_fname;
		string20 demographic_clean_contractual_contact_mname;
		string20 demographic_clean_contractual_contact_lname;
		string5 demographic_clean_contractual_contact_suffix;
		string20 demographic_clean_operational_contact_fname;
		string20 demographic_clean_operational_contact_mname;
		string20 demographic_clean_operational_contact_lname;
		string5 demographic_clean_operational_contact_suffix;
		string20 demographic_clean_technical_contact_fname;
		string20 demographic_clean_technical_contact_mname;
		string20 demographic_clean_technical_contact_lname;
		string5 demographic_clean_technical_contact_suffix;
		string20 demographic_clean_audit_contact_fname;
		string20 demographic_clean_audit_contact_mname;
		string20 demographic_clean_audit_contact_lname;
		string5 demographic_clean_audit_contact_suffix;
		string10 demographic_prim_range;
		string2 demographic_predir;
		string28 demographic_prim_name;
		string4 demographic_addr_suffix;
		string2 demographic_postdir;
		string10 demographic_unit_desig;
		string8 demographic_sec_range;
		string25 demographic_p_city_name;
		string25 demographic_v_city_name;
		string2 demographic_state;
		string5 demographic_zip5;
		string4 demographic_zip4;
		string4 demographic_cart;
		string1 demographic_cr_sort_sz;
		string4 demographic_lot;
		string1 demographic_lot_order;
		string2 demographic_dpbc;
		string1 demographic_chk_digit;
		string2 demographic_rec_type;
		string2 demographic_fips_st;
		string3 demographic_fips_county;
		string10 demographic_geo_lat;
		string11 demographic_geo_long;
		string4 demographic_msa;
		string7 demographic_geo_blk;
		string1 demographic_geo_match;
		string4 demographic_err_stat;
		string35 pay_center_name;
		string55 pay_center_address_1;
		string55 pay_center_address_2;
		string30 pay_center_city;
		string2 pay_center_state_code;
		string9 pay_center_zip_code;
		string10 pay_center_phone;
		string5 pay_center_extension;
		string10 pay_center_fax;
		string10 pay_center_npi;
		string15 pay_center_federal_tax_id;
		string30 pay_center_contact_name;
		string30 pay_center_contact_title;
		string50 pay_center_contact_email;
		unsigned6 pay_center_clean_delete_date;
		string100 pay_center_append_addr1;
		string50 pay_center_append_addrlast;
		unsigned8 pay_center_append_rawaid;
		unsigned8 pay_center_append_aceaid;
		string20 pay_center_contact_fname;
		string20 pay_center_contact_mname;
		string20 pay_center_contact_lname;
		string5 pay_center_contact_suffix;
		string10 pay_center_prim_range;
		string2 pay_center_predir;
		string28 pay_center_prim_name;
		string4 pay_center_addr_suffix;
		string2 pay_center_postdir;
		string10 pay_center_unit_desig;
		string8 pay_center_sec_range;
		string25 pay_center_p_city_name;
		string25 pay_center_v_city_name;
		string2 pay_center_state;
		string5 pay_center_zip5;
		string4 pay_center_zip4;
		string4 pay_center_cart;
		string1 pay_center_cr_sort_sz;
		string4 pay_center_lot;
		string1 pay_center_lot_order;
		string2 pay_center_dpbc;
		string1 pay_center_chk_digit;
		string2 pay_center_rec_type;
		string2 pay_center_fips_st;
		string3 pay_center_fips_county;
		string10 pay_center_geo_lat;
		string11 pay_center_geo_long;
		string4 pay_center_msa;
		string7 pay_center_geo_blk;
		string1 pay_center_geo_match;
		string4 pay_center_err_stat;
		string35 parent_org_name;
		string55 parent_org_address_1;
		string55 parent_org_address_2;
		string30 parent_org_city;
		string2 parent_org_state_code;
		string9 parent_org_zip_code;
		string10 parent_org_phone;
		string5 parent_org_extension;
		string10 parent_org_fax;
		string10 parent_org_npi;
		string15 parent_org_federal_tax_id;
		string30 parent_org_contact_name;
		string30 parent_org_contact_title;
		string50 parent_org_contact_email;
		unsigned6 parent_org_clean_delete_date;
		string100 parent_org_append_addr1;
		string50 parent_org_append_addrlast;
		unsigned8 parent_org_append_rawaid;
		unsigned8 parent_org_append_aceaid;
		string20 parent_org_contact_fname;
		string20 parent_org_contact_mname;
		string20 parent_org_contact_lname;
		string5 parent_org_contact_suffix;
		string10 parent_org_prim_range;
		string2 parent_org_predir;
		string28 parent_org_prim_name;
		string4 parent_org_addr_suffix;
		string2 parent_org_postdir;
		string10 parent_org_unit_desig;
		string8 parent_org_sec_range;
		string25 parent_org_p_city_name;
		string25 parent_org_v_city_name;
		string2 parent_org_state;
		string5 parent_org_zip5;
		string4 parent_org_zip4;
		string4 parent_org_cart;
		string1 parent_org_cr_sort_sz;
		string4 parent_org_lot;
		string1 parent_org_lot_order;
		string2 parent_org_dpbc;
		string1 parent_org_chk_digit;
		string2 parent_org_rec_type;
		string2 parent_org_fips_st;
		string3 parent_org_fips_county;
		string10 parent_org_geo_lat;
		string11 parent_org_geo_long;
		string4 parent_org_msa;
		string7 parent_org_geo_blk;
		string1 parent_org_geo_match;
		string4 parent_org_err_stat;
		string3 eprescribe_network_id;
		string100 eprescribe_service_level_codes;
		unsigned6 eprescribe_clean_effect_from_date;
		unsigned6 eprescribe_clean_effect_through_date;
		string6 remit_id;
		string35 remit_name;
		string55 remit_address_1;
		string55 remit_address_2;
		string30 remit_city;
		string2 remit_state_code;
		string9 remit_zip_code;
		string10 remit_phone;
		string5 remit_extension;
		string10 remit_fax;
		string10 remit_npi;
		string15 remit_federal_tax_id;
		string30 remit_contact_name;
		string30 remit_contact_title;
		string50 remit_contact_email;
		unsigned6 remit_clean_delete_date;
		string100 remit_append_addr1;
		string50 remit_append_addrlast;
		unsigned8 remit_append_rawaid;
		unsigned8 remit_append_aceaid;
		string20 remit_contact_fname;
		string20 remit_contact_mname;
		string20 remit_contact_lname;
		string5 remit_contact_suffix;
		string10 remit_prim_range;
		string2 remit_predir;
		string28 remit_prim_name;
		string4 remit_addr_suffix;
		string2 remit_postdir;
		string10 remit_unit_desig;
		string8 remit_sec_range;
		string25 remit_p_city_name;
		string25 remit_v_city_name;
		string2 remit_state;
		string5 remit_zip5;
		string4 remit_zip4;
		string4 remit_cart;
		string1 remit_cr_sort_sz;
		string4 remit_lot;
		string1 remit_lot_order;
		string2 remit_dpbc;
		string1 remit_chk_digit;
		string2 remit_rec_type;
		string2 remit_fips_st;
		string3 remit_fips_county;
		string10 remit_geo_lat;
		string11 remit_geo_long;
		string4 remit_msa;
		string7 remit_geo_blk;
		string1 remit_geo_match;
		string4 remit_err_stat;
		string2 state_code;
		string20 state_license_number;
		unsigned6 state_license_clean_expiration_date;
		unsigned6 state_license_clean_delete_date;
		string1 service_accepts_eprescribe_indicator;
		string2 service_accepts_eprescribe_code;
		string1 service_delivery_service_indicator;
		string2 service_delivery_service_code;
		string1 service_compounding_service_indicator;
		string2 service_compounding_service_code;
		string1 service_driveup_window_indicator;
		string2 service_driveup_window_code;
		string1 service_dme_indicator;
		string2 service_dme_code;
		string1 service_walkin_clinic_indicator;
		string2 service_walkin_code;
		string1 service_emergency_24hr_service_indicator;
		string2 service_emergency_24hr_service_code;
		string1 service_multi_dose_compliance_indicator;
		string2 service_multi_dose_compliance_code;
		string1 service_immunizations_provided_indicator;
		string2 service_immunizations_provided_code;
		string1 service_handicapped_accessible_indicator;
		string2 service_handicapped_accessible_code;
		string1 service_status_340b_indicator;
		string2 service_status_340b_code;
		string1 service_closed_door_facility_indicator;
		string2 service_closed_door_facility_code;
		string7 change_ownership_old_ncpdp_provider_id;
		unsigned6 change_ownership_clean_old_store_close_date;
		unsigned6 change_ownership_clean_change_owner_effect_date;
	END;

	export layout_clean182_fips := RECORD
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 p_city_name;
   string25 v_city_name;
   string2 st;
   string5 zip;
   string4 zip4;
   string4 cart;
   string1 cr_sort_sz;
   string4 lot;
   string1 lot_order;
   string2 dbpc;
   string1 chk_digit;
   string2 rec_type;
   string2 fips_state;
   string3 fips_county;
   string10 geo_lat;
   string11 geo_long;
   string4 msa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
 END;

	export cleaned_phones := RECORD
   string10 phone;
  END;

	EXPORT CLIA_REC := RECORD
		unsigned6 dotid;
		unsigned2 dotscore;
		unsigned2 dotweight;
		unsigned6 empid;
		unsigned2 empscore;
		unsigned2 empweight;
		unsigned6 powid;
		unsigned2 powscore;
		unsigned2 powweight;
		unsigned6 proxid;
		unsigned2 proxscore;
		unsigned2 proxweight;
		unsigned6 seleid;
		unsigned2 selescore;
		unsigned2 seleweight;
		unsigned6 orgid;
		unsigned2 orgscore;
		unsigned2 orgweight;
		unsigned6 ultid;
		unsigned2 ultscore;
		unsigned2 ultweight;
		string10 clia_number;
		string1 certificate_type_code;
		string50 facility_name;
		string50 facility_name2;
		string50 address1;
		string50 address2;
		string28 city;
		string2 state;
		string5 zip;
		string4 zip4;
		string10 facility_phone;
		string8 expiration_date;
		string2 lab_type_code;
		string2 lab_term_code;
		string50 lab_type;
		string50 certificate_type;
		unsigned4 dt_vendor_first_reported;
		unsigned4 dt_vendor_last_reported;
		string1 record_type;
		unsigned8 raw_aid;
		unsigned8 ace_aid;
		unsigned6 did;
		unsigned6 bdid;
		unsigned1 bdid_score;
		layout_clean182_fips clean_company_address;
		cleaned_phones clean_phones;
		unsigned8 lnpid;
		unsigned8 source_rec_id;
	END;

	EXPORT Enclarity_REC := RECORD
		string38 group_key;
		string10 dept_group_key;
		string100 prac_company_name;
		string20 addr_key;
		string1 pv_addr_ind;
		string10 phone1;
		string10 fax1;
		string10 last_verified_date;
		string9 dea_num;
		string10 dea_num_exp;
		string1 dea_bus_act_ind;
		string25 lic_num_in;
		string2 lic_state;
		string25 lic_num;
		string10 lic_type;
		string1 lic_status;
		string10 lic_begin_date;
		string10 lic_end_date;
		string1 lic_src_ind;
		string10 npi_num;
		string10 taxonomy;
		string80 type1;
		string100 classification;
		string80 specialization;
		string10 medicare_fac_num;
		string1 oig_flag;
		string10 sanc1_date;
		string10 sanc1_code;
		string10 medicare_fac_num1;
		string2 clia_status_code;
		string10 clia_num;
		string10 clia_end_date;
		string1 clia_cert_type_code;
		string10 clia_cert_eff_date;
		string7 ncpdp_id;
		string10 tin1;
		unsigned6 pid;
		string2 src;
		unsigned4 dt_vendor_first_reported;
		unsigned4 dt_vendor_last_reported;
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen;
		string1 record_type;
		unsigned8 source_rid;
		unsigned8 lnpid;
		unsigned6 bdid;
		unsigned1 bdid_score;
		unsigned4 clean_last_verify_date;
		unsigned4 clean_lic_begin_date;
		unsigned4 clean_lic_end_date;
		unsigned4 clean_sanc1_date;
		unsigned4 clean_dea_num_exp;
		string100 clean_company_name;
		unsigned4 clean_clia_end_date;
		unsigned4 clean_clia_cert_eff_date;
		string1 normed_addr_rec_type;
		string50 prepped_addr1;
		string39 prepped_addr2;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2 st;
		string5 zip;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dbpc;
		string1 chk_digit;
		string2 rec_type;
		string2 fips_st;
		string3 fips_county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		unsigned8 rawaid;
		unsigned8 aceaid;
		string10 clean_phone;
		string10 clean_fax;
		unsigned6 dotid;
		unsigned2 dotscore;
		unsigned2 dotweight;
		unsigned6 empid;
		unsigned2 empscore;
		unsigned2 empweight;
		unsigned6 powid;
		unsigned2 powscore;
		unsigned2 powweight;
		unsigned6 proxid;
		unsigned2 proxscore;
		unsigned2 proxweight;
		unsigned6 seleid;
		unsigned2 selescore;
		unsigned2 seleweight;
		unsigned6 orgid;
		unsigned2 orgscore;
		unsigned2 orgweight;
		unsigned6 ultid;
		unsigned2 ultscore;
		unsigned2 ultweight;
 END;
 
 EXPORT ENCLARITY_ASSOC_REC := RECORD
  string38 group_key;
  string11 prac_addr_confidence_score;
  string11 bill_addr_confidence_score;
  string20 addr_key;
  string10 addr_phone;
  string10 sloc_phone;
  string38 sloc_group_key;
  string38 billing_group_key;
  string50 bill_npi;
  string50 bill_tin;
  string10 cam_latest;
  string10 cam_earliest;
  unsigned5 cbm1;
  unsigned5 cbm3;
  unsigned5 cbm6;
  unsigned5 cbm12;
  unsigned5 cbm18;
  string1 pgk_works_for;
  string1 pgk_is_affiliated_to;
  string80 sloc_type;
  string80 billing_type;
  unsigned6 pid;
  string2 src;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  string1 record_type;
  unsigned8 source_rid;
  unsigned8 lnpid;
  unsigned6 did;
  unsigned1 did_score;
  unsigned6 bdid;
  unsigned1 bdid_score;
  string100 prepped_name;
  string1 normed_name_rec_type;
  string100 clean_company_name;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string1 nametype;
  unsigned8 nid;
  string50 prepped_addr1;
  string39 prepped_addr2;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string2 fips_st;
  string3 fips_county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  unsigned8 rawaid;
  unsigned8 aceaid;
  unsigned4 clean_cam_latest;
  unsigned4 clean_cam_earliest;
  string10 clean_phone;
  string10 clean_sloc_phone;
  string8 clean_dob;
  unsigned4 best_dob;
  string9 clean_ssn;
  string9 best_ssn;
  unsigned6 dotid;
  unsigned2 dotscore;
  unsigned2 dotweight;
  unsigned6 empid;
  unsigned2 empscore;
  unsigned2 empweight;
  unsigned6 powid;
  unsigned2 powscore;
  unsigned2 powweight;
  unsigned6 proxid;
  unsigned2 proxscore;
  unsigned2 proxweight;
  unsigned6 seleid;
  unsigned2 selescore;
  unsigned2 seleweight;
  unsigned6 orgid;
  unsigned2 orgscore;
  unsigned2 orgweight;
  unsigned6 ultid;
  unsigned2 ultscore;
  unsigned2 ultweight; 
	END;
	
	EXPORT Enclarity_NPI_REC := RECORD
		string38 group_key;
		string10 npi_num;
		string10 taxonomy;
		string80 type1;
		string100 classification;
		string80 specialization;
		string1 taxonomy_primary_ind;
		string50 last_name;
		string50 first_name;
		string50 middle_name;
		string50 other_last_name;
		string50 other_first_name;
		string50 other_middle_name;
		string1 other_name_type;
		string100 company_name;
		string100 other_company_name;
		string1 other_company_name_type;
		string100 parent_organization_name;
		string20 addr_key;
		string10 phone1;
		string1 npi_type;
		string1 npi_sole_proprietor;
		string10 npi_deact_date;
		string10 npi_enum_date;
		unsigned6 pid;
		string2 src;
		unsigned4 dt_vendor_first_reported;
		unsigned4 dt_vendor_last_reported;
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen;
		string1 record_type;
		unsigned8 source_rid;
		unsigned8 lnpid;
		unsigned6 did;
		unsigned2 did_score;
		unsigned6 bdid;
		unsigned1 bdid_score;
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 name_suffix;
		string1 nametype;
		unsigned8 nid;
		string1 normed_addr_rec_type;
		string50 prepped_addr1;
		string39 prepped_addr2;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2 st;
		string5 zip;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dbpc;
		string1 chk_digit;
		string2 rec_type;
		string2 fips_st;
		string3 fips_county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		unsigned8 rawaid;
		unsigned8 aceaid;
		string8 clean_phone;
		string8 clean_npi_deact_date;
		string8 clean_npi_enum_date;
		string8 clean_dob;
		unsigned4 best_dob;
		string9 clean_ssn;
		string9 best_ssn;
		unsigned6 dotid;
		unsigned2 dotscore;
		unsigned2 dotweight;
		unsigned6 empid;
		unsigned2 empscore;
		unsigned2 empweight;
		unsigned6 powid;
		unsigned2 powscore;
		unsigned2 powweight;
		unsigned6 proxid;
		unsigned2 proxscore;
		unsigned2 proxweight;
		unsigned6 seleid;
		unsigned2 selescore;
		unsigned2 seleweight;
		unsigned6 orgid;
		unsigned2 orgscore;
		unsigned2 orgweight;
		unsigned6 ultid;
		unsigned2 ultscore;
		unsigned2 ultweight;
	END;
END;