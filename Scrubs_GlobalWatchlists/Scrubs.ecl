IMPORT ut,SALT34;
IMPORT Scrubs,Scrubs_GlobalWatchlists,Scrubs_Infutor_NARC; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_GlobalWatchlists)
    UNSIGNED1 pty_key_Invalid;
    UNSIGNED1 source_Invalid;
    UNSIGNED1 orig_pty_name_Invalid;
    UNSIGNED1 orig_vessel_name_Invalid;
    UNSIGNED1 country_Invalid;
    UNSIGNED1 name_type_Invalid;
    UNSIGNED1 addr_1_Invalid;
    UNSIGNED1 addr_2_Invalid;
    UNSIGNED1 addr_3_Invalid;
    UNSIGNED1 addr_4_Invalid;
    UNSIGNED1 addr_5_Invalid;
    UNSIGNED1 addr_6_Invalid;
    UNSIGNED1 addr_7_Invalid;
    UNSIGNED1 addr_8_Invalid;
    UNSIGNED1 addr_9_Invalid;
    UNSIGNED1 addr_10_Invalid;
    UNSIGNED1 cname_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 suffix_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 addr_suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 unit_desig_Invalid;
    UNSIGNED1 sec_range_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 date_vendor_first_reported_Invalid;
    UNSIGNED1 date_vendor_last_reported_Invalid;
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 aka_type_Invalid;
    UNSIGNED1 aka_category_Invalid;
    UNSIGNED1 giv_designator_Invalid;
    UNSIGNED1 entity_type_Invalid;
    UNSIGNED1 address_line_1_Invalid;
    UNSIGNED1 address_line_2_Invalid;
    UNSIGNED1 address_line_3_Invalid;
    UNSIGNED1 address_city_Invalid;
    UNSIGNED1 address_state_province_Invalid;
    UNSIGNED1 address_postal_code_Invalid;
    UNSIGNED1 address_country_Invalid;
    UNSIGNED1 vessel_type_Invalid;
    UNSIGNED1 vessel_flag_Invalid;
    UNSIGNED1 vessel_owner_Invalid;
    UNSIGNED1 id_issue_date_1_Invalid;
    UNSIGNED1 id_issue_date_2_Invalid;
    UNSIGNED1 id_issue_date_3_Invalid;
    UNSIGNED1 id_issue_date_4_Invalid;
    UNSIGNED1 id_issue_date_5_Invalid;
    UNSIGNED1 id_issue_date_6_Invalid;
    UNSIGNED1 id_issue_date_7_Invalid;
    UNSIGNED1 id_issue_date_8_Invalid;
    UNSIGNED1 id_issue_date_9_Invalid;
    UNSIGNED1 id_issue_date_10_Invalid;
    UNSIGNED1 id_expiration_date_1_Invalid;
    UNSIGNED1 id_expiration_date_2_Invalid;
    UNSIGNED1 id_expiration_date_3_Invalid;
    UNSIGNED1 id_expiration_date_4_Invalid;
    UNSIGNED1 id_expiration_date_5_Invalid;
    UNSIGNED1 id_expiration_date_6_Invalid;
    UNSIGNED1 id_expiration_date_7_Invalid;
    UNSIGNED1 id_expiration_date_8_Invalid;
    UNSIGNED1 id_expiration_date_9_Invalid;
    UNSIGNED1 id_expiration_date_10_Invalid;
    UNSIGNED1 primary_nationality_flag_1_Invalid;
    UNSIGNED1 primary_nationality_flag_2_Invalid;
    UNSIGNED1 primary_nationality_flag_3_Invalid;
    UNSIGNED1 primary_nationality_flag_4_Invalid;
    UNSIGNED1 primary_nationality_flag_5_Invalid;
    UNSIGNED1 primary_nationality_flag_6_Invalid;
    UNSIGNED1 primary_nationality_flag_7_Invalid;
    UNSIGNED1 primary_nationality_flag_8_Invalid;
    UNSIGNED1 primary_nationality_flag_9_Invalid;
    UNSIGNED1 primary_nationality_flag_10_Invalid;
    UNSIGNED1 primary_citizenship_flag_1_Invalid;
    UNSIGNED1 primary_citizenship_flag_2_Invalid;
    UNSIGNED1 primary_citizenship_flag_3_Invalid;
    UNSIGNED1 primary_citizenship_flag_4_Invalid;
    UNSIGNED1 primary_citizenship_flag_5_Invalid;
    UNSIGNED1 primary_citizenship_flag_6_Invalid;
    UNSIGNED1 primary_citizenship_flag_7_Invalid;
    UNSIGNED1 primary_citizenship_flag_8_Invalid;
    UNSIGNED1 primary_citizenship_flag_9_Invalid;
    UNSIGNED1 primary_citizenship_flag_10_Invalid;
    UNSIGNED1 dob_1_Invalid;
    UNSIGNED1 dob_2_Invalid;
    UNSIGNED1 dob_3_Invalid;
    UNSIGNED1 dob_4_Invalid;
    UNSIGNED1 dob_5_Invalid;
    UNSIGNED1 dob_6_Invalid;
    UNSIGNED1 dob_7_Invalid;
    UNSIGNED1 dob_8_Invalid;
    UNSIGNED1 dob_9_Invalid;
    UNSIGNED1 dob_10_Invalid;
    UNSIGNED1 primary_dob_flag_1_Invalid;
    UNSIGNED1 primary_dob_flag_2_Invalid;
    UNSIGNED1 primary_dob_flag_3_Invalid;
    UNSIGNED1 primary_dob_flag_4_Invalid;
    UNSIGNED1 primary_dob_flag_5_Invalid;
    UNSIGNED1 primary_dob_flag_6_Invalid;
    UNSIGNED1 primary_dob_flag_7_Invalid;
    UNSIGNED1 primary_dob_flag_8_Invalid;
    UNSIGNED1 primary_dob_flag_9_Invalid;
    UNSIGNED1 primary_dob_flag_10_Invalid;
    UNSIGNED1 primary_pob_flag_1_Invalid;
    UNSIGNED1 primary_pob_flag_2_Invalid;
    UNSIGNED1 primary_pob_flag_3_Invalid;
    UNSIGNED1 primary_pob_flag_4_Invalid;
    UNSIGNED1 primary_pob_flag_5_Invalid;
    UNSIGNED1 primary_pob_flag_6_Invalid;
    UNSIGNED1 primary_pob_flag_7_Invalid;
    UNSIGNED1 primary_pob_flag_8_Invalid;
    UNSIGNED1 primary_pob_flag_9_Invalid;
    UNSIGNED1 primary_pob_flag_10_Invalid;
    UNSIGNED1 date_added_to_list_Invalid;
    UNSIGNED1 date_last_updated_Invalid;
    UNSIGNED1 effective_date_Invalid;
    UNSIGNED1 expiration_date_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 federal_register_citation_date_1_Invalid;
    UNSIGNED1 federal_register_citation_date_2_Invalid;
    UNSIGNED1 federal_register_citation_date_3_Invalid;
    UNSIGNED1 federal_register_citation_date_4_Invalid;
    UNSIGNED1 federal_register_citation_date_5_Invalid;
    UNSIGNED1 federal_register_citation_date_6_Invalid;
    UNSIGNED1 federal_register_citation_date_7_Invalid;
    UNSIGNED1 federal_register_citation_date_8_Invalid;
    UNSIGNED1 federal_register_citation_date_9_Invalid;
    UNSIGNED1 federal_register_citation_date_10_Invalid;
    UNSIGNED1 height_Invalid;
    UNSIGNED1 weight_Invalid;
    UNSIGNED1 physique_Invalid;
    UNSIGNED1 hair_color_Invalid;
    UNSIGNED1 eyes_Invalid;
    UNSIGNED1 complexion_Invalid;
    UNSIGNED1 race_Invalid;
    UNSIGNED1 type_of_denial_Invalid;
    UNSIGNED1 registrant_terminated_flag_Invalid;
    UNSIGNED1 foreign_principal_terminated_flag_Invalid;
    UNSIGNED1 short_form_terminated_flag_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_GlobalWatchlists)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
  END;
EXPORT FromNone(DATASET(Layout_GlobalWatchlists) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.pty_key_Invalid := Fields.InValid_pty_key((SALT34.StrType)le.pty_key);
    SELF.source_Invalid := Fields.InValid_source((SALT34.StrType)le.source);
    SELF.orig_pty_name_Invalid := Fields.InValid_orig_pty_name((SALT34.StrType)le.orig_pty_name);
    SELF.orig_vessel_name_Invalid := Fields.InValid_orig_vessel_name((SALT34.StrType)le.orig_vessel_name);
    SELF.country_Invalid := Fields.InValid_country((SALT34.StrType)le.country);
    SELF.name_type_Invalid := Fields.InValid_name_type((SALT34.StrType)le.name_type);
    SELF.addr_1_Invalid := Fields.InValid_addr_1((SALT34.StrType)le.addr_1);
    SELF.addr_2_Invalid := Fields.InValid_addr_2((SALT34.StrType)le.addr_2);
    SELF.addr_3_Invalid := Fields.InValid_addr_3((SALT34.StrType)le.addr_3);
    SELF.addr_4_Invalid := Fields.InValid_addr_4((SALT34.StrType)le.addr_4);
    SELF.addr_5_Invalid := Fields.InValid_addr_5((SALT34.StrType)le.addr_5);
    SELF.addr_6_Invalid := Fields.InValid_addr_6((SALT34.StrType)le.addr_6);
    SELF.addr_7_Invalid := Fields.InValid_addr_7((SALT34.StrType)le.addr_7);
    SELF.addr_8_Invalid := Fields.InValid_addr_8((SALT34.StrType)le.addr_8);
    SELF.addr_9_Invalid := Fields.InValid_addr_9((SALT34.StrType)le.addr_9);
    SELF.addr_10_Invalid := Fields.InValid_addr_10((SALT34.StrType)le.addr_10);
    SELF.cname_Invalid := Fields.InValid_cname((SALT34.StrType)le.cname);
    SELF.title_Invalid := Fields.InValid_title((SALT34.StrType)le.title);
    SELF.fname_Invalid := Fields.InValid_fname((SALT34.StrType)le.fname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT34.StrType)le.mname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT34.StrType)le.lname);
    SELF.suffix_Invalid := Fields.InValid_suffix((SALT34.StrType)le.suffix);
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT34.StrType)le.prim_range);
    SELF.predir_Invalid := Fields.InValid_predir((SALT34.StrType)le.predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT34.StrType)le.prim_name);
    SELF.addr_suffix_Invalid := Fields.InValid_addr_suffix((SALT34.StrType)le.addr_suffix);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT34.StrType)le.postdir);
    SELF.unit_desig_Invalid := Fields.InValid_unit_desig((SALT34.StrType)le.unit_desig);
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT34.StrType)le.sec_range);
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT34.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT34.StrType)le.v_city_name);
    SELF.st_Invalid := Fields.InValid_st((SALT34.StrType)le.st);
    SELF.zip_Invalid := Fields.InValid_zip((SALT34.StrType)le.zip);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT34.StrType)le.zip4);
    SELF.date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT34.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Fields.InValid_date_last_seen((SALT34.StrType)le.date_last_seen);
    SELF.date_vendor_first_reported_Invalid := Fields.InValid_date_vendor_first_reported((SALT34.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Fields.InValid_date_vendor_last_reported((SALT34.StrType)le.date_vendor_last_reported);
    SELF.first_name_Invalid := Fields.InValid_first_name((SALT34.StrType)le.first_name);
    SELF.last_name_Invalid := Fields.InValid_last_name((SALT34.StrType)le.last_name);
    SELF.aka_type_Invalid := Fields.InValid_aka_type((SALT34.StrType)le.aka_type);
    SELF.aka_category_Invalid := Fields.InValid_aka_category((SALT34.StrType)le.aka_category);
    SELF.giv_designator_Invalid := Fields.InValid_giv_designator((SALT34.StrType)le.giv_designator);
    SELF.entity_type_Invalid := Fields.InValid_entity_type((SALT34.StrType)le.entity_type);
    SELF.address_line_1_Invalid := Fields.InValid_address_line_1((SALT34.StrType)le.address_line_1);
    SELF.address_line_2_Invalid := Fields.InValid_address_line_2((SALT34.StrType)le.address_line_2);
    SELF.address_line_3_Invalid := Fields.InValid_address_line_3((SALT34.StrType)le.address_line_3);
    SELF.address_city_Invalid := Fields.InValid_address_city((SALT34.StrType)le.address_city);
    SELF.address_state_province_Invalid := Fields.InValid_address_state_province((SALT34.StrType)le.address_state_province);
    SELF.address_postal_code_Invalid := Fields.InValid_address_postal_code((SALT34.StrType)le.address_postal_code);
    SELF.address_country_Invalid := Fields.InValid_address_country((SALT34.StrType)le.address_country);
    SELF.vessel_type_Invalid := Fields.InValid_vessel_type((SALT34.StrType)le.vessel_type);
    SELF.vessel_flag_Invalid := Fields.InValid_vessel_flag((SALT34.StrType)le.vessel_flag);
    SELF.vessel_owner_Invalid := Fields.InValid_vessel_owner((SALT34.StrType)le.vessel_owner);
    SELF.id_issue_date_1_Invalid := Fields.InValid_id_issue_date_1((SALT34.StrType)le.id_issue_date_1);
    SELF.id_issue_date_2_Invalid := Fields.InValid_id_issue_date_2((SALT34.StrType)le.id_issue_date_2);
    SELF.id_issue_date_3_Invalid := Fields.InValid_id_issue_date_3((SALT34.StrType)le.id_issue_date_3);
    SELF.id_issue_date_4_Invalid := Fields.InValid_id_issue_date_4((SALT34.StrType)le.id_issue_date_4);
    SELF.id_issue_date_5_Invalid := Fields.InValid_id_issue_date_5((SALT34.StrType)le.id_issue_date_5);
    SELF.id_issue_date_6_Invalid := Fields.InValid_id_issue_date_6((SALT34.StrType)le.id_issue_date_6);
    SELF.id_issue_date_7_Invalid := Fields.InValid_id_issue_date_7((SALT34.StrType)le.id_issue_date_7);
    SELF.id_issue_date_8_Invalid := Fields.InValid_id_issue_date_8((SALT34.StrType)le.id_issue_date_8);
    SELF.id_issue_date_9_Invalid := Fields.InValid_id_issue_date_9((SALT34.StrType)le.id_issue_date_9);
    SELF.id_issue_date_10_Invalid := Fields.InValid_id_issue_date_10((SALT34.StrType)le.id_issue_date_10);
    SELF.id_expiration_date_1_Invalid := Fields.InValid_id_expiration_date_1((SALT34.StrType)le.id_expiration_date_1);
    SELF.id_expiration_date_2_Invalid := Fields.InValid_id_expiration_date_2((SALT34.StrType)le.id_expiration_date_2);
    SELF.id_expiration_date_3_Invalid := Fields.InValid_id_expiration_date_3((SALT34.StrType)le.id_expiration_date_3);
    SELF.id_expiration_date_4_Invalid := Fields.InValid_id_expiration_date_4((SALT34.StrType)le.id_expiration_date_4);
    SELF.id_expiration_date_5_Invalid := Fields.InValid_id_expiration_date_5((SALT34.StrType)le.id_expiration_date_5);
    SELF.id_expiration_date_6_Invalid := Fields.InValid_id_expiration_date_6((SALT34.StrType)le.id_expiration_date_6);
    SELF.id_expiration_date_7_Invalid := Fields.InValid_id_expiration_date_7((SALT34.StrType)le.id_expiration_date_7);
    SELF.id_expiration_date_8_Invalid := Fields.InValid_id_expiration_date_8((SALT34.StrType)le.id_expiration_date_8);
    SELF.id_expiration_date_9_Invalid := Fields.InValid_id_expiration_date_9((SALT34.StrType)le.id_expiration_date_9);
    SELF.id_expiration_date_10_Invalid := Fields.InValid_id_expiration_date_10((SALT34.StrType)le.id_expiration_date_10);
    SELF.primary_nationality_flag_1_Invalid := Fields.InValid_primary_nationality_flag_1((SALT34.StrType)le.primary_nationality_flag_1);
    SELF.primary_nationality_flag_2_Invalid := Fields.InValid_primary_nationality_flag_2((SALT34.StrType)le.primary_nationality_flag_2);
    SELF.primary_nationality_flag_3_Invalid := Fields.InValid_primary_nationality_flag_3((SALT34.StrType)le.primary_nationality_flag_3);
    SELF.primary_nationality_flag_4_Invalid := Fields.InValid_primary_nationality_flag_4((SALT34.StrType)le.primary_nationality_flag_4);
    SELF.primary_nationality_flag_5_Invalid := Fields.InValid_primary_nationality_flag_5((SALT34.StrType)le.primary_nationality_flag_5);
    SELF.primary_nationality_flag_6_Invalid := Fields.InValid_primary_nationality_flag_6((SALT34.StrType)le.primary_nationality_flag_6);
    SELF.primary_nationality_flag_7_Invalid := Fields.InValid_primary_nationality_flag_7((SALT34.StrType)le.primary_nationality_flag_7);
    SELF.primary_nationality_flag_8_Invalid := Fields.InValid_primary_nationality_flag_8((SALT34.StrType)le.primary_nationality_flag_8);
    SELF.primary_nationality_flag_9_Invalid := Fields.InValid_primary_nationality_flag_9((SALT34.StrType)le.primary_nationality_flag_9);
    SELF.primary_nationality_flag_10_Invalid := Fields.InValid_primary_nationality_flag_10((SALT34.StrType)le.primary_nationality_flag_10);
    SELF.primary_citizenship_flag_1_Invalid := Fields.InValid_primary_citizenship_flag_1((SALT34.StrType)le.primary_citizenship_flag_1);
    SELF.primary_citizenship_flag_2_Invalid := Fields.InValid_primary_citizenship_flag_2((SALT34.StrType)le.primary_citizenship_flag_2);
    SELF.primary_citizenship_flag_3_Invalid := Fields.InValid_primary_citizenship_flag_3((SALT34.StrType)le.primary_citizenship_flag_3);
    SELF.primary_citizenship_flag_4_Invalid := Fields.InValid_primary_citizenship_flag_4((SALT34.StrType)le.primary_citizenship_flag_4);
    SELF.primary_citizenship_flag_5_Invalid := Fields.InValid_primary_citizenship_flag_5((SALT34.StrType)le.primary_citizenship_flag_5);
    SELF.primary_citizenship_flag_6_Invalid := Fields.InValid_primary_citizenship_flag_6((SALT34.StrType)le.primary_citizenship_flag_6);
    SELF.primary_citizenship_flag_7_Invalid := Fields.InValid_primary_citizenship_flag_7((SALT34.StrType)le.primary_citizenship_flag_7);
    SELF.primary_citizenship_flag_8_Invalid := Fields.InValid_primary_citizenship_flag_8((SALT34.StrType)le.primary_citizenship_flag_8);
    SELF.primary_citizenship_flag_9_Invalid := Fields.InValid_primary_citizenship_flag_9((SALT34.StrType)le.primary_citizenship_flag_9);
    SELF.primary_citizenship_flag_10_Invalid := Fields.InValid_primary_citizenship_flag_10((SALT34.StrType)le.primary_citizenship_flag_10);
    SELF.dob_1_Invalid := Fields.InValid_dob_1((SALT34.StrType)le.dob_1);
    SELF.dob_2_Invalid := Fields.InValid_dob_2((SALT34.StrType)le.dob_2);
    SELF.dob_3_Invalid := Fields.InValid_dob_3((SALT34.StrType)le.dob_3);
    SELF.dob_4_Invalid := Fields.InValid_dob_4((SALT34.StrType)le.dob_4);
    SELF.dob_5_Invalid := Fields.InValid_dob_5((SALT34.StrType)le.dob_5);
    SELF.dob_6_Invalid := Fields.InValid_dob_6((SALT34.StrType)le.dob_6);
    SELF.dob_7_Invalid := Fields.InValid_dob_7((SALT34.StrType)le.dob_7);
    SELF.dob_8_Invalid := Fields.InValid_dob_8((SALT34.StrType)le.dob_8);
    SELF.dob_9_Invalid := Fields.InValid_dob_9((SALT34.StrType)le.dob_9);
    SELF.dob_10_Invalid := Fields.InValid_dob_10((SALT34.StrType)le.dob_10);
    SELF.primary_dob_flag_1_Invalid := Fields.InValid_primary_dob_flag_1((SALT34.StrType)le.primary_dob_flag_1);
    SELF.primary_dob_flag_2_Invalid := Fields.InValid_primary_dob_flag_2((SALT34.StrType)le.primary_dob_flag_2);
    SELF.primary_dob_flag_3_Invalid := Fields.InValid_primary_dob_flag_3((SALT34.StrType)le.primary_dob_flag_3);
    SELF.primary_dob_flag_4_Invalid := Fields.InValid_primary_dob_flag_4((SALT34.StrType)le.primary_dob_flag_4);
    SELF.primary_dob_flag_5_Invalid := Fields.InValid_primary_dob_flag_5((SALT34.StrType)le.primary_dob_flag_5);
    SELF.primary_dob_flag_6_Invalid := Fields.InValid_primary_dob_flag_6((SALT34.StrType)le.primary_dob_flag_6);
    SELF.primary_dob_flag_7_Invalid := Fields.InValid_primary_dob_flag_7((SALT34.StrType)le.primary_dob_flag_7);
    SELF.primary_dob_flag_8_Invalid := Fields.InValid_primary_dob_flag_8((SALT34.StrType)le.primary_dob_flag_8);
    SELF.primary_dob_flag_9_Invalid := Fields.InValid_primary_dob_flag_9((SALT34.StrType)le.primary_dob_flag_9);
    SELF.primary_dob_flag_10_Invalid := Fields.InValid_primary_dob_flag_10((SALT34.StrType)le.primary_dob_flag_10);
    SELF.primary_pob_flag_1_Invalid := Fields.InValid_primary_pob_flag_1((SALT34.StrType)le.primary_pob_flag_1);
    SELF.primary_pob_flag_2_Invalid := Fields.InValid_primary_pob_flag_2((SALT34.StrType)le.primary_pob_flag_2);
    SELF.primary_pob_flag_3_Invalid := Fields.InValid_primary_pob_flag_3((SALT34.StrType)le.primary_pob_flag_3);
    SELF.primary_pob_flag_4_Invalid := Fields.InValid_primary_pob_flag_4((SALT34.StrType)le.primary_pob_flag_4);
    SELF.primary_pob_flag_5_Invalid := Fields.InValid_primary_pob_flag_5((SALT34.StrType)le.primary_pob_flag_5);
    SELF.primary_pob_flag_6_Invalid := Fields.InValid_primary_pob_flag_6((SALT34.StrType)le.primary_pob_flag_6);
    SELF.primary_pob_flag_7_Invalid := Fields.InValid_primary_pob_flag_7((SALT34.StrType)le.primary_pob_flag_7);
    SELF.primary_pob_flag_8_Invalid := Fields.InValid_primary_pob_flag_8((SALT34.StrType)le.primary_pob_flag_8);
    SELF.primary_pob_flag_9_Invalid := Fields.InValid_primary_pob_flag_9((SALT34.StrType)le.primary_pob_flag_9);
    SELF.primary_pob_flag_10_Invalid := Fields.InValid_primary_pob_flag_10((SALT34.StrType)le.primary_pob_flag_10);
    SELF.date_added_to_list_Invalid := Fields.InValid_date_added_to_list((SALT34.StrType)le.date_added_to_list);
    SELF.date_last_updated_Invalid := Fields.InValid_date_last_updated((SALT34.StrType)le.date_last_updated);
    SELF.effective_date_Invalid := Fields.InValid_effective_date((SALT34.StrType)le.effective_date);
    SELF.expiration_date_Invalid := Fields.InValid_expiration_date((SALT34.StrType)le.expiration_date);
    SELF.gender_Invalid := Fields.InValid_gender((SALT34.StrType)le.gender);
    SELF.federal_register_citation_date_1_Invalid := Fields.InValid_federal_register_citation_date_1((SALT34.StrType)le.federal_register_citation_date_1);
    SELF.federal_register_citation_date_2_Invalid := Fields.InValid_federal_register_citation_date_2((SALT34.StrType)le.federal_register_citation_date_2);
    SELF.federal_register_citation_date_3_Invalid := Fields.InValid_federal_register_citation_date_3((SALT34.StrType)le.federal_register_citation_date_3);
    SELF.federal_register_citation_date_4_Invalid := Fields.InValid_federal_register_citation_date_4((SALT34.StrType)le.federal_register_citation_date_4);
    SELF.federal_register_citation_date_5_Invalid := Fields.InValid_federal_register_citation_date_5((SALT34.StrType)le.federal_register_citation_date_5);
    SELF.federal_register_citation_date_6_Invalid := Fields.InValid_federal_register_citation_date_6((SALT34.StrType)le.federal_register_citation_date_6);
    SELF.federal_register_citation_date_7_Invalid := Fields.InValid_federal_register_citation_date_7((SALT34.StrType)le.federal_register_citation_date_7);
    SELF.federal_register_citation_date_8_Invalid := Fields.InValid_federal_register_citation_date_8((SALT34.StrType)le.federal_register_citation_date_8);
    SELF.federal_register_citation_date_9_Invalid := Fields.InValid_federal_register_citation_date_9((SALT34.StrType)le.federal_register_citation_date_9);
    SELF.federal_register_citation_date_10_Invalid := Fields.InValid_federal_register_citation_date_10((SALT34.StrType)le.federal_register_citation_date_10);
    SELF.height_Invalid := Fields.InValid_height((SALT34.StrType)le.height);
    SELF.weight_Invalid := Fields.InValid_weight((SALT34.StrType)le.weight);
    SELF.physique_Invalid := Fields.InValid_physique((SALT34.StrType)le.physique);
    SELF.hair_color_Invalid := Fields.InValid_hair_color((SALT34.StrType)le.hair_color);
    SELF.eyes_Invalid := Fields.InValid_eyes((SALT34.StrType)le.eyes);
    SELF.complexion_Invalid := Fields.InValid_complexion((SALT34.StrType)le.complexion);
    SELF.race_Invalid := Fields.InValid_race((SALT34.StrType)le.race);
    SELF.type_of_denial_Invalid := Fields.InValid_type_of_denial((SALT34.StrType)le.type_of_denial);
    SELF.registrant_terminated_flag_Invalid := Fields.InValid_registrant_terminated_flag((SALT34.StrType)le.registrant_terminated_flag);
    SELF.foreign_principal_terminated_flag_Invalid := Fields.InValid_foreign_principal_terminated_flag((SALT34.StrType)le.foreign_principal_terminated_flag);
    SELF.short_form_terminated_flag_Invalid := Fields.InValid_short_form_terminated_flag((SALT34.StrType)le.short_form_terminated_flag);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_GlobalWatchlists);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.pty_key_Invalid << 0 ) + ( le.source_Invalid << 2 ) + ( le.orig_pty_name_Invalid << 3 ) + ( le.orig_vessel_name_Invalid << 4 ) + ( le.country_Invalid << 5 ) + ( le.name_type_Invalid << 7 ) + ( le.addr_1_Invalid << 8 ) + ( le.addr_2_Invalid << 9 ) + ( le.addr_3_Invalid << 10 ) + ( le.addr_4_Invalid << 11 ) + ( le.addr_5_Invalid << 12 ) + ( le.addr_6_Invalid << 13 ) + ( le.addr_7_Invalid << 14 ) + ( le.addr_8_Invalid << 15 ) + ( le.addr_9_Invalid << 16 ) + ( le.addr_10_Invalid << 17 ) + ( le.cname_Invalid << 18 ) + ( le.title_Invalid << 19 ) + ( le.fname_Invalid << 20 ) + ( le.mname_Invalid << 21 ) + ( le.lname_Invalid << 22 ) + ( le.suffix_Invalid << 23 ) + ( le.prim_range_Invalid << 24 ) + ( le.predir_Invalid << 25 ) + ( le.prim_name_Invalid << 26 ) + ( le.addr_suffix_Invalid << 27 ) + ( le.postdir_Invalid << 28 ) + ( le.unit_desig_Invalid << 29 ) + ( le.sec_range_Invalid << 30 ) + ( le.p_city_name_Invalid << 31 ) + ( le.v_city_name_Invalid << 32 ) + ( le.st_Invalid << 33 ) + ( le.zip_Invalid << 34 ) + ( le.zip4_Invalid << 36 ) + ( le.date_first_seen_Invalid << 38 ) + ( le.date_last_seen_Invalid << 39 ) + ( le.date_vendor_first_reported_Invalid << 40 ) + ( le.date_vendor_last_reported_Invalid << 41 ) + ( le.first_name_Invalid << 42 ) + ( le.last_name_Invalid << 43 ) + ( le.aka_type_Invalid << 44 ) + ( le.aka_category_Invalid << 45 ) + ( le.giv_designator_Invalid << 46 ) + ( le.entity_type_Invalid << 47 ) + ( le.address_line_1_Invalid << 48 ) + ( le.address_line_2_Invalid << 49 ) + ( le.address_line_3_Invalid << 50 ) + ( le.address_city_Invalid << 51 ) + ( le.address_state_province_Invalid << 52 ) + ( le.address_postal_code_Invalid << 53 ) + ( le.address_country_Invalid << 54 ) + ( le.vessel_type_Invalid << 56 ) + ( le.vessel_flag_Invalid << 57 ) + ( le.vessel_owner_Invalid << 58 ) + ( le.id_issue_date_1_Invalid << 59 ) + ( le.id_issue_date_2_Invalid << 60 ) + ( le.id_issue_date_3_Invalid << 61 ) + ( le.id_issue_date_4_Invalid << 62 ) + ( le.id_issue_date_5_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.id_issue_date_6_Invalid << 0 ) + ( le.id_issue_date_7_Invalid << 1 ) + ( le.id_issue_date_8_Invalid << 2 ) + ( le.id_issue_date_9_Invalid << 3 ) + ( le.id_issue_date_10_Invalid << 4 ) + ( le.id_expiration_date_1_Invalid << 5 ) + ( le.id_expiration_date_2_Invalid << 6 ) + ( le.id_expiration_date_3_Invalid << 7 ) + ( le.id_expiration_date_4_Invalid << 8 ) + ( le.id_expiration_date_5_Invalid << 9 ) + ( le.id_expiration_date_6_Invalid << 10 ) + ( le.id_expiration_date_7_Invalid << 11 ) + ( le.id_expiration_date_8_Invalid << 12 ) + ( le.id_expiration_date_9_Invalid << 13 ) + ( le.id_expiration_date_10_Invalid << 14 ) + ( le.primary_nationality_flag_1_Invalid << 15 ) + ( le.primary_nationality_flag_2_Invalid << 16 ) + ( le.primary_nationality_flag_3_Invalid << 17 ) + ( le.primary_nationality_flag_4_Invalid << 18 ) + ( le.primary_nationality_flag_5_Invalid << 19 ) + ( le.primary_nationality_flag_6_Invalid << 20 ) + ( le.primary_nationality_flag_7_Invalid << 21 ) + ( le.primary_nationality_flag_8_Invalid << 22 ) + ( le.primary_nationality_flag_9_Invalid << 23 ) + ( le.primary_nationality_flag_10_Invalid << 24 ) + ( le.primary_citizenship_flag_1_Invalid << 25 ) + ( le.primary_citizenship_flag_2_Invalid << 26 ) + ( le.primary_citizenship_flag_3_Invalid << 27 ) + ( le.primary_citizenship_flag_4_Invalid << 28 ) + ( le.primary_citizenship_flag_5_Invalid << 29 ) + ( le.primary_citizenship_flag_6_Invalid << 30 ) + ( le.primary_citizenship_flag_7_Invalid << 31 ) + ( le.primary_citizenship_flag_8_Invalid << 32 ) + ( le.primary_citizenship_flag_9_Invalid << 33 ) + ( le.primary_citizenship_flag_10_Invalid << 34 ) + ( le.dob_1_Invalid << 35 ) + ( le.dob_2_Invalid << 36 ) + ( le.dob_3_Invalid << 37 ) + ( le.dob_4_Invalid << 38 ) + ( le.dob_5_Invalid << 39 ) + ( le.dob_6_Invalid << 40 ) + ( le.dob_7_Invalid << 41 ) + ( le.dob_8_Invalid << 42 ) + ( le.dob_9_Invalid << 43 ) + ( le.dob_10_Invalid << 44 ) + ( le.primary_dob_flag_1_Invalid << 45 ) + ( le.primary_dob_flag_2_Invalid << 46 ) + ( le.primary_dob_flag_3_Invalid << 47 ) + ( le.primary_dob_flag_4_Invalid << 48 ) + ( le.primary_dob_flag_5_Invalid << 49 ) + ( le.primary_dob_flag_6_Invalid << 50 ) + ( le.primary_dob_flag_7_Invalid << 51 ) + ( le.primary_dob_flag_8_Invalid << 52 ) + ( le.primary_dob_flag_9_Invalid << 53 ) + ( le.primary_dob_flag_10_Invalid << 54 ) + ( le.primary_pob_flag_1_Invalid << 55 ) + ( le.primary_pob_flag_2_Invalid << 56 ) + ( le.primary_pob_flag_3_Invalid << 57 ) + ( le.primary_pob_flag_4_Invalid << 58 ) + ( le.primary_pob_flag_5_Invalid << 59 ) + ( le.primary_pob_flag_6_Invalid << 60 ) + ( le.primary_pob_flag_7_Invalid << 61 ) + ( le.primary_pob_flag_8_Invalid << 62 ) + ( le.primary_pob_flag_9_Invalid << 63 );
    SELF.ScrubsBits3 := ( le.primary_pob_flag_10_Invalid << 0 ) + ( le.date_added_to_list_Invalid << 1 ) + ( le.date_last_updated_Invalid << 2 ) + ( le.effective_date_Invalid << 3 ) + ( le.expiration_date_Invalid << 4 ) + ( le.gender_Invalid << 5 ) + ( le.federal_register_citation_date_1_Invalid << 6 ) + ( le.federal_register_citation_date_2_Invalid << 7 ) + ( le.federal_register_citation_date_3_Invalid << 8 ) + ( le.federal_register_citation_date_4_Invalid << 9 ) + ( le.federal_register_citation_date_5_Invalid << 10 ) + ( le.federal_register_citation_date_6_Invalid << 11 ) + ( le.federal_register_citation_date_7_Invalid << 12 ) + ( le.federal_register_citation_date_8_Invalid << 13 ) + ( le.federal_register_citation_date_9_Invalid << 14 ) + ( le.federal_register_citation_date_10_Invalid << 15 ) + ( le.height_Invalid << 16 ) + ( le.weight_Invalid << 17 ) + ( le.physique_Invalid << 18 ) + ( le.hair_color_Invalid << 19 ) + ( le.eyes_Invalid << 20 ) + ( le.complexion_Invalid << 21 ) + ( le.race_Invalid << 22 ) + ( le.type_of_denial_Invalid << 23 ) + ( le.registrant_terminated_flag_Invalid << 24 ) + ( le.foreign_principal_terminated_flag_Invalid << 25 ) + ( le.short_form_terminated_flag_Invalid << 26 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_GlobalWatchlists);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.pty_key_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.source_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.orig_pty_name_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.orig_vessel_name_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.country_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.name_type_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.addr_1_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.addr_2_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.addr_3_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.addr_4_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.addr_5_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.addr_6_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.addr_7_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.addr_8_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.addr_9_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.addr_10_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.cname_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.title_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.addr_suffix_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.aka_type_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.aka_category_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.giv_designator_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.entity_type_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.address_line_1_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.address_line_2_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.address_line_3_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.address_city_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.address_state_province_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.address_postal_code_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.address_country_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.vessel_type_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.vessel_flag_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.vessel_owner_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.id_issue_date_1_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.id_issue_date_2_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.id_issue_date_3_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.id_issue_date_4_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.id_issue_date_5_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.id_issue_date_6_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.id_issue_date_7_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.id_issue_date_8_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.id_issue_date_9_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.id_issue_date_10_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.id_expiration_date_1_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.id_expiration_date_2_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.id_expiration_date_3_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.id_expiration_date_4_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.id_expiration_date_5_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.id_expiration_date_6_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.id_expiration_date_7_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.id_expiration_date_8_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.id_expiration_date_9_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.id_expiration_date_10_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.primary_nationality_flag_1_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.primary_nationality_flag_2_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.primary_nationality_flag_3_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.primary_nationality_flag_4_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.primary_nationality_flag_5_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.primary_nationality_flag_6_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.primary_nationality_flag_7_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.primary_nationality_flag_8_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.primary_nationality_flag_9_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.primary_nationality_flag_10_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.primary_citizenship_flag_1_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.primary_citizenship_flag_2_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.primary_citizenship_flag_3_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.primary_citizenship_flag_4_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.primary_citizenship_flag_5_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.primary_citizenship_flag_6_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.primary_citizenship_flag_7_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.primary_citizenship_flag_8_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.primary_citizenship_flag_9_Invalid := (le.ScrubsBits2 >> 33) & 1;
    SELF.primary_citizenship_flag_10_Invalid := (le.ScrubsBits2 >> 34) & 1;
    SELF.dob_1_Invalid := (le.ScrubsBits2 >> 35) & 1;
    SELF.dob_2_Invalid := (le.ScrubsBits2 >> 36) & 1;
    SELF.dob_3_Invalid := (le.ScrubsBits2 >> 37) & 1;
    SELF.dob_4_Invalid := (le.ScrubsBits2 >> 38) & 1;
    SELF.dob_5_Invalid := (le.ScrubsBits2 >> 39) & 1;
    SELF.dob_6_Invalid := (le.ScrubsBits2 >> 40) & 1;
    SELF.dob_7_Invalid := (le.ScrubsBits2 >> 41) & 1;
    SELF.dob_8_Invalid := (le.ScrubsBits2 >> 42) & 1;
    SELF.dob_9_Invalid := (le.ScrubsBits2 >> 43) & 1;
    SELF.dob_10_Invalid := (le.ScrubsBits2 >> 44) & 1;
    SELF.primary_dob_flag_1_Invalid := (le.ScrubsBits2 >> 45) & 1;
    SELF.primary_dob_flag_2_Invalid := (le.ScrubsBits2 >> 46) & 1;
    SELF.primary_dob_flag_3_Invalid := (le.ScrubsBits2 >> 47) & 1;
    SELF.primary_dob_flag_4_Invalid := (le.ScrubsBits2 >> 48) & 1;
    SELF.primary_dob_flag_5_Invalid := (le.ScrubsBits2 >> 49) & 1;
    SELF.primary_dob_flag_6_Invalid := (le.ScrubsBits2 >> 50) & 1;
    SELF.primary_dob_flag_7_Invalid := (le.ScrubsBits2 >> 51) & 1;
    SELF.primary_dob_flag_8_Invalid := (le.ScrubsBits2 >> 52) & 1;
    SELF.primary_dob_flag_9_Invalid := (le.ScrubsBits2 >> 53) & 1;
    SELF.primary_dob_flag_10_Invalid := (le.ScrubsBits2 >> 54) & 1;
    SELF.primary_pob_flag_1_Invalid := (le.ScrubsBits2 >> 55) & 1;
    SELF.primary_pob_flag_2_Invalid := (le.ScrubsBits2 >> 56) & 1;
    SELF.primary_pob_flag_3_Invalid := (le.ScrubsBits2 >> 57) & 1;
    SELF.primary_pob_flag_4_Invalid := (le.ScrubsBits2 >> 58) & 1;
    SELF.primary_pob_flag_5_Invalid := (le.ScrubsBits2 >> 59) & 1;
    SELF.primary_pob_flag_6_Invalid := (le.ScrubsBits2 >> 60) & 1;
    SELF.primary_pob_flag_7_Invalid := (le.ScrubsBits2 >> 61) & 1;
    SELF.primary_pob_flag_8_Invalid := (le.ScrubsBits2 >> 62) & 1;
    SELF.primary_pob_flag_9_Invalid := (le.ScrubsBits2 >> 63) & 1;
    SELF.primary_pob_flag_10_Invalid := (le.ScrubsBits3 >> 0) & 1;
    SELF.date_added_to_list_Invalid := (le.ScrubsBits3 >> 1) & 1;
    SELF.date_last_updated_Invalid := (le.ScrubsBits3 >> 2) & 1;
    SELF.effective_date_Invalid := (le.ScrubsBits3 >> 3) & 1;
    SELF.expiration_date_Invalid := (le.ScrubsBits3 >> 4) & 1;
    SELF.gender_Invalid := (le.ScrubsBits3 >> 5) & 1;
    SELF.federal_register_citation_date_1_Invalid := (le.ScrubsBits3 >> 6) & 1;
    SELF.federal_register_citation_date_2_Invalid := (le.ScrubsBits3 >> 7) & 1;
    SELF.federal_register_citation_date_3_Invalid := (le.ScrubsBits3 >> 8) & 1;
    SELF.federal_register_citation_date_4_Invalid := (le.ScrubsBits3 >> 9) & 1;
    SELF.federal_register_citation_date_5_Invalid := (le.ScrubsBits3 >> 10) & 1;
    SELF.federal_register_citation_date_6_Invalid := (le.ScrubsBits3 >> 11) & 1;
    SELF.federal_register_citation_date_7_Invalid := (le.ScrubsBits3 >> 12) & 1;
    SELF.federal_register_citation_date_8_Invalid := (le.ScrubsBits3 >> 13) & 1;
    SELF.federal_register_citation_date_9_Invalid := (le.ScrubsBits3 >> 14) & 1;
    SELF.federal_register_citation_date_10_Invalid := (le.ScrubsBits3 >> 15) & 1;
    SELF.height_Invalid := (le.ScrubsBits3 >> 16) & 1;
    SELF.weight_Invalid := (le.ScrubsBits3 >> 17) & 1;
    SELF.physique_Invalid := (le.ScrubsBits3 >> 18) & 1;
    SELF.hair_color_Invalid := (le.ScrubsBits3 >> 19) & 1;
    SELF.eyes_Invalid := (le.ScrubsBits3 >> 20) & 1;
    SELF.complexion_Invalid := (le.ScrubsBits3 >> 21) & 1;
    SELF.race_Invalid := (le.ScrubsBits3 >> 22) & 1;
    SELF.type_of_denial_Invalid := (le.ScrubsBits3 >> 23) & 1;
    SELF.registrant_terminated_flag_Invalid := (le.ScrubsBits3 >> 24) & 1;
    SELF.foreign_principal_terminated_flag_Invalid := (le.ScrubsBits3 >> 25) & 1;
    SELF.short_form_terminated_flag_Invalid := (le.ScrubsBits3 >> 26) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.src_key;
    TotalCnt := COUNT(GROUP); // Number of records in total
    pty_key_ALLOW_ErrorCount := COUNT(GROUP,h.pty_key_Invalid=1);
    pty_key_CUSTOM_ErrorCount := COUNT(GROUP,h.pty_key_Invalid=2);
    pty_key_Total_ErrorCount := COUNT(GROUP,h.pty_key_Invalid>0);
    source_CUSTOM_ErrorCount := COUNT(GROUP,h.source_Invalid=1);
    orig_pty_name_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_pty_name_Invalid=1);
    orig_vessel_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_vessel_name_Invalid=1);
    country_QUOTES_ErrorCount := COUNT(GROUP,h.country_Invalid=1);
    country_ALLOW_ErrorCount := COUNT(GROUP,h.country_Invalid=2);
    country_Total_ErrorCount := COUNT(GROUP,h.country_Invalid>0);
    name_type_ENUM_ErrorCount := COUNT(GROUP,h.name_type_Invalid=1);
    addr_1_ALLOW_ErrorCount := COUNT(GROUP,h.addr_1_Invalid=1);
    addr_2_ALLOW_ErrorCount := COUNT(GROUP,h.addr_2_Invalid=1);
    addr_3_ALLOW_ErrorCount := COUNT(GROUP,h.addr_3_Invalid=1);
    addr_4_ALLOW_ErrorCount := COUNT(GROUP,h.addr_4_Invalid=1);
    addr_5_ALLOW_ErrorCount := COUNT(GROUP,h.addr_5_Invalid=1);
    addr_6_ALLOW_ErrorCount := COUNT(GROUP,h.addr_6_Invalid=1);
    addr_7_ALLOW_ErrorCount := COUNT(GROUP,h.addr_7_Invalid=1);
    addr_8_ALLOW_ErrorCount := COUNT(GROUP,h.addr_8_Invalid=1);
    addr_9_ALLOW_ErrorCount := COUNT(GROUP,h.addr_9_Invalid=1);
    addr_10_ALLOW_ErrorCount := COUNT(GROUP,h.addr_10_Invalid=1);
    cname_ALLOW_ErrorCount := COUNT(GROUP,h.cname_Invalid=1);
    title_CUSTOM_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    fname_CUSTOM_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    mname_CUSTOM_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    lname_CUSTOM_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    suffix_ENUM_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    st_CUSTOM_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTH_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_LENGTH_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
    date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    first_name_CUSTOM_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    last_name_CUSTOM_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    aka_type_ENUM_ErrorCount := COUNT(GROUP,h.aka_type_Invalid=1);
    aka_category_ENUM_ErrorCount := COUNT(GROUP,h.aka_category_Invalid=1);
    giv_designator_ENUM_ErrorCount := COUNT(GROUP,h.giv_designator_Invalid=1);
    entity_type_ENUM_ErrorCount := COUNT(GROUP,h.entity_type_Invalid=1);
    address_line_1_ALLOW_ErrorCount := COUNT(GROUP,h.address_line_1_Invalid=1);
    address_line_2_ALLOW_ErrorCount := COUNT(GROUP,h.address_line_2_Invalid=1);
    address_line_3_ALLOW_ErrorCount := COUNT(GROUP,h.address_line_3_Invalid=1);
    address_city_ALLOW_ErrorCount := COUNT(GROUP,h.address_city_Invalid=1);
    address_state_province_ALLOW_ErrorCount := COUNT(GROUP,h.address_state_province_Invalid=1);
    address_postal_code_ALLOW_ErrorCount := COUNT(GROUP,h.address_postal_code_Invalid=1);
    address_country_QUOTES_ErrorCount := COUNT(GROUP,h.address_country_Invalid=1);
    address_country_ALLOW_ErrorCount := COUNT(GROUP,h.address_country_Invalid=2);
    address_country_Total_ErrorCount := COUNT(GROUP,h.address_country_Invalid>0);
    vessel_type_ENUM_ErrorCount := COUNT(GROUP,h.vessel_type_Invalid=1);
    vessel_flag_CUSTOM_ErrorCount := COUNT(GROUP,h.vessel_flag_Invalid=1);
    vessel_owner_ALLOW_ErrorCount := COUNT(GROUP,h.vessel_owner_Invalid=1);
    id_issue_date_1_CUSTOM_ErrorCount := COUNT(GROUP,h.id_issue_date_1_Invalid=1);
    id_issue_date_2_CUSTOM_ErrorCount := COUNT(GROUP,h.id_issue_date_2_Invalid=1);
    id_issue_date_3_CUSTOM_ErrorCount := COUNT(GROUP,h.id_issue_date_3_Invalid=1);
    id_issue_date_4_CUSTOM_ErrorCount := COUNT(GROUP,h.id_issue_date_4_Invalid=1);
    id_issue_date_5_CUSTOM_ErrorCount := COUNT(GROUP,h.id_issue_date_5_Invalid=1);
    id_issue_date_6_CUSTOM_ErrorCount := COUNT(GROUP,h.id_issue_date_6_Invalid=1);
    id_issue_date_7_CUSTOM_ErrorCount := COUNT(GROUP,h.id_issue_date_7_Invalid=1);
    id_issue_date_8_CUSTOM_ErrorCount := COUNT(GROUP,h.id_issue_date_8_Invalid=1);
    id_issue_date_9_CUSTOM_ErrorCount := COUNT(GROUP,h.id_issue_date_9_Invalid=1);
    id_issue_date_10_CUSTOM_ErrorCount := COUNT(GROUP,h.id_issue_date_10_Invalid=1);
    id_expiration_date_1_CUSTOM_ErrorCount := COUNT(GROUP,h.id_expiration_date_1_Invalid=1);
    id_expiration_date_2_CUSTOM_ErrorCount := COUNT(GROUP,h.id_expiration_date_2_Invalid=1);
    id_expiration_date_3_CUSTOM_ErrorCount := COUNT(GROUP,h.id_expiration_date_3_Invalid=1);
    id_expiration_date_4_CUSTOM_ErrorCount := COUNT(GROUP,h.id_expiration_date_4_Invalid=1);
    id_expiration_date_5_CUSTOM_ErrorCount := COUNT(GROUP,h.id_expiration_date_5_Invalid=1);
    id_expiration_date_6_CUSTOM_ErrorCount := COUNT(GROUP,h.id_expiration_date_6_Invalid=1);
    id_expiration_date_7_CUSTOM_ErrorCount := COUNT(GROUP,h.id_expiration_date_7_Invalid=1);
    id_expiration_date_8_CUSTOM_ErrorCount := COUNT(GROUP,h.id_expiration_date_8_Invalid=1);
    id_expiration_date_9_CUSTOM_ErrorCount := COUNT(GROUP,h.id_expiration_date_9_Invalid=1);
    id_expiration_date_10_CUSTOM_ErrorCount := COUNT(GROUP,h.id_expiration_date_10_Invalid=1);
    primary_nationality_flag_1_ENUM_ErrorCount := COUNT(GROUP,h.primary_nationality_flag_1_Invalid=1);
    primary_nationality_flag_2_ENUM_ErrorCount := COUNT(GROUP,h.primary_nationality_flag_2_Invalid=1);
    primary_nationality_flag_3_ENUM_ErrorCount := COUNT(GROUP,h.primary_nationality_flag_3_Invalid=1);
    primary_nationality_flag_4_ENUM_ErrorCount := COUNT(GROUP,h.primary_nationality_flag_4_Invalid=1);
    primary_nationality_flag_5_ENUM_ErrorCount := COUNT(GROUP,h.primary_nationality_flag_5_Invalid=1);
    primary_nationality_flag_6_ENUM_ErrorCount := COUNT(GROUP,h.primary_nationality_flag_6_Invalid=1);
    primary_nationality_flag_7_ENUM_ErrorCount := COUNT(GROUP,h.primary_nationality_flag_7_Invalid=1);
    primary_nationality_flag_8_ENUM_ErrorCount := COUNT(GROUP,h.primary_nationality_flag_8_Invalid=1);
    primary_nationality_flag_9_ENUM_ErrorCount := COUNT(GROUP,h.primary_nationality_flag_9_Invalid=1);
    primary_nationality_flag_10_ENUM_ErrorCount := COUNT(GROUP,h.primary_nationality_flag_10_Invalid=1);
    primary_citizenship_flag_1_ENUM_ErrorCount := COUNT(GROUP,h.primary_citizenship_flag_1_Invalid=1);
    primary_citizenship_flag_2_ENUM_ErrorCount := COUNT(GROUP,h.primary_citizenship_flag_2_Invalid=1);
    primary_citizenship_flag_3_ENUM_ErrorCount := COUNT(GROUP,h.primary_citizenship_flag_3_Invalid=1);
    primary_citizenship_flag_4_ENUM_ErrorCount := COUNT(GROUP,h.primary_citizenship_flag_4_Invalid=1);
    primary_citizenship_flag_5_ENUM_ErrorCount := COUNT(GROUP,h.primary_citizenship_flag_5_Invalid=1);
    primary_citizenship_flag_6_ENUM_ErrorCount := COUNT(GROUP,h.primary_citizenship_flag_6_Invalid=1);
    primary_citizenship_flag_7_ENUM_ErrorCount := COUNT(GROUP,h.primary_citizenship_flag_7_Invalid=1);
    primary_citizenship_flag_8_ENUM_ErrorCount := COUNT(GROUP,h.primary_citizenship_flag_8_Invalid=1);
    primary_citizenship_flag_9_ENUM_ErrorCount := COUNT(GROUP,h.primary_citizenship_flag_9_Invalid=1);
    primary_citizenship_flag_10_ENUM_ErrorCount := COUNT(GROUP,h.primary_citizenship_flag_10_Invalid=1);
    dob_1_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_1_Invalid=1);
    dob_2_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_2_Invalid=1);
    dob_3_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_3_Invalid=1);
    dob_4_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_4_Invalid=1);
    dob_5_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_5_Invalid=1);
    dob_6_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_6_Invalid=1);
    dob_7_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_7_Invalid=1);
    dob_8_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_8_Invalid=1);
    dob_9_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_9_Invalid=1);
    dob_10_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_10_Invalid=1);
    primary_dob_flag_1_ENUM_ErrorCount := COUNT(GROUP,h.primary_dob_flag_1_Invalid=1);
    primary_dob_flag_2_ENUM_ErrorCount := COUNT(GROUP,h.primary_dob_flag_2_Invalid=1);
    primary_dob_flag_3_ENUM_ErrorCount := COUNT(GROUP,h.primary_dob_flag_3_Invalid=1);
    primary_dob_flag_4_ENUM_ErrorCount := COUNT(GROUP,h.primary_dob_flag_4_Invalid=1);
    primary_dob_flag_5_ENUM_ErrorCount := COUNT(GROUP,h.primary_dob_flag_5_Invalid=1);
    primary_dob_flag_6_ENUM_ErrorCount := COUNT(GROUP,h.primary_dob_flag_6_Invalid=1);
    primary_dob_flag_7_ENUM_ErrorCount := COUNT(GROUP,h.primary_dob_flag_7_Invalid=1);
    primary_dob_flag_8_ENUM_ErrorCount := COUNT(GROUP,h.primary_dob_flag_8_Invalid=1);
    primary_dob_flag_9_ENUM_ErrorCount := COUNT(GROUP,h.primary_dob_flag_9_Invalid=1);
    primary_dob_flag_10_ENUM_ErrorCount := COUNT(GROUP,h.primary_dob_flag_10_Invalid=1);
    primary_pob_flag_1_ENUM_ErrorCount := COUNT(GROUP,h.primary_pob_flag_1_Invalid=1);
    primary_pob_flag_2_ENUM_ErrorCount := COUNT(GROUP,h.primary_pob_flag_2_Invalid=1);
    primary_pob_flag_3_ENUM_ErrorCount := COUNT(GROUP,h.primary_pob_flag_3_Invalid=1);
    primary_pob_flag_4_ENUM_ErrorCount := COUNT(GROUP,h.primary_pob_flag_4_Invalid=1);
    primary_pob_flag_5_ENUM_ErrorCount := COUNT(GROUP,h.primary_pob_flag_5_Invalid=1);
    primary_pob_flag_6_ENUM_ErrorCount := COUNT(GROUP,h.primary_pob_flag_6_Invalid=1);
    primary_pob_flag_7_ENUM_ErrorCount := COUNT(GROUP,h.primary_pob_flag_7_Invalid=1);
    primary_pob_flag_8_ENUM_ErrorCount := COUNT(GROUP,h.primary_pob_flag_8_Invalid=1);
    primary_pob_flag_9_ENUM_ErrorCount := COUNT(GROUP,h.primary_pob_flag_9_Invalid=1);
    primary_pob_flag_10_ENUM_ErrorCount := COUNT(GROUP,h.primary_pob_flag_10_Invalid=1);
    date_added_to_list_CUSTOM_ErrorCount := COUNT(GROUP,h.date_added_to_list_Invalid=1);
    date_last_updated_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_updated_Invalid=1);
    effective_date_CUSTOM_ErrorCount := COUNT(GROUP,h.effective_date_Invalid=1);
    expiration_date_CUSTOM_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid=1);
    gender_ENUM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    federal_register_citation_date_1_CUSTOM_ErrorCount := COUNT(GROUP,h.federal_register_citation_date_1_Invalid=1);
    federal_register_citation_date_2_CUSTOM_ErrorCount := COUNT(GROUP,h.federal_register_citation_date_2_Invalid=1);
    federal_register_citation_date_3_CUSTOM_ErrorCount := COUNT(GROUP,h.federal_register_citation_date_3_Invalid=1);
    federal_register_citation_date_4_CUSTOM_ErrorCount := COUNT(GROUP,h.federal_register_citation_date_4_Invalid=1);
    federal_register_citation_date_5_CUSTOM_ErrorCount := COUNT(GROUP,h.federal_register_citation_date_5_Invalid=1);
    federal_register_citation_date_6_CUSTOM_ErrorCount := COUNT(GROUP,h.federal_register_citation_date_6_Invalid=1);
    federal_register_citation_date_7_CUSTOM_ErrorCount := COUNT(GROUP,h.federal_register_citation_date_7_Invalid=1);
    federal_register_citation_date_8_CUSTOM_ErrorCount := COUNT(GROUP,h.federal_register_citation_date_8_Invalid=1);
    federal_register_citation_date_9_CUSTOM_ErrorCount := COUNT(GROUP,h.federal_register_citation_date_9_Invalid=1);
    federal_register_citation_date_10_CUSTOM_ErrorCount := COUNT(GROUP,h.federal_register_citation_date_10_Invalid=1);
    height_ALLOW_ErrorCount := COUNT(GROUP,h.height_Invalid=1);
    weight_ALLOW_ErrorCount := COUNT(GROUP,h.weight_Invalid=1);
    physique_ENUM_ErrorCount := COUNT(GROUP,h.physique_Invalid=1);
    hair_color_CUSTOM_ErrorCount := COUNT(GROUP,h.hair_color_Invalid=1);
    eyes_CUSTOM_ErrorCount := COUNT(GROUP,h.eyes_Invalid=1);
    complexion_ENUM_ErrorCount := COUNT(GROUP,h.complexion_Invalid=1);
    race_ENUM_ErrorCount := COUNT(GROUP,h.race_Invalid=1);
    type_of_denial_ENUM_ErrorCount := COUNT(GROUP,h.type_of_denial_Invalid=1);
    registrant_terminated_flag_ENUM_ErrorCount := COUNT(GROUP,h.registrant_terminated_flag_Invalid=1);
    foreign_principal_terminated_flag_ENUM_ErrorCount := COUNT(GROUP,h.foreign_principal_terminated_flag_Invalid=1);
    short_form_terminated_flag_ENUM_ErrorCount := COUNT(GROUP,h.short_form_terminated_flag_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r,src_key,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT34.StrType ErrorMessage;
    SALT34.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.src_key;
    UNSIGNED1 ErrNum := CHOOSE(c,le.pty_key_Invalid,le.source_Invalid,le.orig_pty_name_Invalid,le.orig_vessel_name_Invalid,le.country_Invalid,le.name_type_Invalid,le.addr_1_Invalid,le.addr_2_Invalid,le.addr_3_Invalid,le.addr_4_Invalid,le.addr_5_Invalid,le.addr_6_Invalid,le.addr_7_Invalid,le.addr_8_Invalid,le.addr_9_Invalid,le.addr_10_Invalid,le.cname_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.suffix_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,le.first_name_Invalid,le.last_name_Invalid,le.aka_type_Invalid,le.aka_category_Invalid,le.giv_designator_Invalid,le.entity_type_Invalid,le.address_line_1_Invalid,le.address_line_2_Invalid,le.address_line_3_Invalid,le.address_city_Invalid,le.address_state_province_Invalid,le.address_postal_code_Invalid,le.address_country_Invalid,le.vessel_type_Invalid,le.vessel_flag_Invalid,le.vessel_owner_Invalid,le.id_issue_date_1_Invalid,le.id_issue_date_2_Invalid,le.id_issue_date_3_Invalid,le.id_issue_date_4_Invalid,le.id_issue_date_5_Invalid,le.id_issue_date_6_Invalid,le.id_issue_date_7_Invalid,le.id_issue_date_8_Invalid,le.id_issue_date_9_Invalid,le.id_issue_date_10_Invalid,le.id_expiration_date_1_Invalid,le.id_expiration_date_2_Invalid,le.id_expiration_date_3_Invalid,le.id_expiration_date_4_Invalid,le.id_expiration_date_5_Invalid,le.id_expiration_date_6_Invalid,le.id_expiration_date_7_Invalid,le.id_expiration_date_8_Invalid,le.id_expiration_date_9_Invalid,le.id_expiration_date_10_Invalid,le.primary_nationality_flag_1_Invalid,le.primary_nationality_flag_2_Invalid,le.primary_nationality_flag_3_Invalid,le.primary_nationality_flag_4_Invalid,le.primary_nationality_flag_5_Invalid,le.primary_nationality_flag_6_Invalid,le.primary_nationality_flag_7_Invalid,le.primary_nationality_flag_8_Invalid,le.primary_nationality_flag_9_Invalid,le.primary_nationality_flag_10_Invalid,le.primary_citizenship_flag_1_Invalid,le.primary_citizenship_flag_2_Invalid,le.primary_citizenship_flag_3_Invalid,le.primary_citizenship_flag_4_Invalid,le.primary_citizenship_flag_5_Invalid,le.primary_citizenship_flag_6_Invalid,le.primary_citizenship_flag_7_Invalid,le.primary_citizenship_flag_8_Invalid,le.primary_citizenship_flag_9_Invalid,le.primary_citizenship_flag_10_Invalid,le.dob_1_Invalid,le.dob_2_Invalid,le.dob_3_Invalid,le.dob_4_Invalid,le.dob_5_Invalid,le.dob_6_Invalid,le.dob_7_Invalid,le.dob_8_Invalid,le.dob_9_Invalid,le.dob_10_Invalid,le.primary_dob_flag_1_Invalid,le.primary_dob_flag_2_Invalid,le.primary_dob_flag_3_Invalid,le.primary_dob_flag_4_Invalid,le.primary_dob_flag_5_Invalid,le.primary_dob_flag_6_Invalid,le.primary_dob_flag_7_Invalid,le.primary_dob_flag_8_Invalid,le.primary_dob_flag_9_Invalid,le.primary_dob_flag_10_Invalid,le.primary_pob_flag_1_Invalid,le.primary_pob_flag_2_Invalid,le.primary_pob_flag_3_Invalid,le.primary_pob_flag_4_Invalid,le.primary_pob_flag_5_Invalid,le.primary_pob_flag_6_Invalid,le.primary_pob_flag_7_Invalid,le.primary_pob_flag_8_Invalid,le.primary_pob_flag_9_Invalid,le.primary_pob_flag_10_Invalid,le.date_added_to_list_Invalid,le.date_last_updated_Invalid,le.effective_date_Invalid,le.expiration_date_Invalid,le.gender_Invalid,le.federal_register_citation_date_1_Invalid,le.federal_register_citation_date_2_Invalid,le.federal_register_citation_date_3_Invalid,le.federal_register_citation_date_4_Invalid,le.federal_register_citation_date_5_Invalid,le.federal_register_citation_date_6_Invalid,le.federal_register_citation_date_7_Invalid,le.federal_register_citation_date_8_Invalid,le.federal_register_citation_date_9_Invalid,le.federal_register_citation_date_10_Invalid,le.height_Invalid,le.weight_Invalid,le.physique_Invalid,le.hair_color_Invalid,le.eyes_Invalid,le.complexion_Invalid,le.race_Invalid,le.type_of_denial_Invalid,le.registrant_terminated_flag_Invalid,le.foreign_principal_terminated_flag_Invalid,le.short_form_terminated_flag_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_pty_key(le.pty_key_Invalid),Fields.InvalidMessage_source(le.source_Invalid),Fields.InvalidMessage_orig_pty_name(le.orig_pty_name_Invalid),Fields.InvalidMessage_orig_vessel_name(le.orig_vessel_name_Invalid),Fields.InvalidMessage_country(le.country_Invalid),Fields.InvalidMessage_name_type(le.name_type_Invalid),Fields.InvalidMessage_addr_1(le.addr_1_Invalid),Fields.InvalidMessage_addr_2(le.addr_2_Invalid),Fields.InvalidMessage_addr_3(le.addr_3_Invalid),Fields.InvalidMessage_addr_4(le.addr_4_Invalid),Fields.InvalidMessage_addr_5(le.addr_5_Invalid),Fields.InvalidMessage_addr_6(le.addr_6_Invalid),Fields.InvalidMessage_addr_7(le.addr_7_Invalid),Fields.InvalidMessage_addr_8(le.addr_8_Invalid),Fields.InvalidMessage_addr_9(le.addr_9_Invalid),Fields.InvalidMessage_addr_10(le.addr_10_Invalid),Fields.InvalidMessage_cname(le.cname_Invalid),Fields.InvalidMessage_title(le.title_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_suffix(le.suffix_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),Fields.InvalidMessage_first_name(le.first_name_Invalid),Fields.InvalidMessage_last_name(le.last_name_Invalid),Fields.InvalidMessage_aka_type(le.aka_type_Invalid),Fields.InvalidMessage_aka_category(le.aka_category_Invalid),Fields.InvalidMessage_giv_designator(le.giv_designator_Invalid),Fields.InvalidMessage_entity_type(le.entity_type_Invalid),Fields.InvalidMessage_address_line_1(le.address_line_1_Invalid),Fields.InvalidMessage_address_line_2(le.address_line_2_Invalid),Fields.InvalidMessage_address_line_3(le.address_line_3_Invalid),Fields.InvalidMessage_address_city(le.address_city_Invalid),Fields.InvalidMessage_address_state_province(le.address_state_province_Invalid),Fields.InvalidMessage_address_postal_code(le.address_postal_code_Invalid),Fields.InvalidMessage_address_country(le.address_country_Invalid),Fields.InvalidMessage_vessel_type(le.vessel_type_Invalid),Fields.InvalidMessage_vessel_flag(le.vessel_flag_Invalid),Fields.InvalidMessage_vessel_owner(le.vessel_owner_Invalid),Fields.InvalidMessage_id_issue_date_1(le.id_issue_date_1_Invalid),Fields.InvalidMessage_id_issue_date_2(le.id_issue_date_2_Invalid),Fields.InvalidMessage_id_issue_date_3(le.id_issue_date_3_Invalid),Fields.InvalidMessage_id_issue_date_4(le.id_issue_date_4_Invalid),Fields.InvalidMessage_id_issue_date_5(le.id_issue_date_5_Invalid),Fields.InvalidMessage_id_issue_date_6(le.id_issue_date_6_Invalid),Fields.InvalidMessage_id_issue_date_7(le.id_issue_date_7_Invalid),Fields.InvalidMessage_id_issue_date_8(le.id_issue_date_8_Invalid),Fields.InvalidMessage_id_issue_date_9(le.id_issue_date_9_Invalid),Fields.InvalidMessage_id_issue_date_10(le.id_issue_date_10_Invalid),Fields.InvalidMessage_id_expiration_date_1(le.id_expiration_date_1_Invalid),Fields.InvalidMessage_id_expiration_date_2(le.id_expiration_date_2_Invalid),Fields.InvalidMessage_id_expiration_date_3(le.id_expiration_date_3_Invalid),Fields.InvalidMessage_id_expiration_date_4(le.id_expiration_date_4_Invalid),Fields.InvalidMessage_id_expiration_date_5(le.id_expiration_date_5_Invalid),Fields.InvalidMessage_id_expiration_date_6(le.id_expiration_date_6_Invalid),Fields.InvalidMessage_id_expiration_date_7(le.id_expiration_date_7_Invalid),Fields.InvalidMessage_id_expiration_date_8(le.id_expiration_date_8_Invalid),Fields.InvalidMessage_id_expiration_date_9(le.id_expiration_date_9_Invalid),Fields.InvalidMessage_id_expiration_date_10(le.id_expiration_date_10_Invalid),Fields.InvalidMessage_primary_nationality_flag_1(le.primary_nationality_flag_1_Invalid),Fields.InvalidMessage_primary_nationality_flag_2(le.primary_nationality_flag_2_Invalid),Fields.InvalidMessage_primary_nationality_flag_3(le.primary_nationality_flag_3_Invalid),Fields.InvalidMessage_primary_nationality_flag_4(le.primary_nationality_flag_4_Invalid),Fields.InvalidMessage_primary_nationality_flag_5(le.primary_nationality_flag_5_Invalid),Fields.InvalidMessage_primary_nationality_flag_6(le.primary_nationality_flag_6_Invalid),Fields.InvalidMessage_primary_nationality_flag_7(le.primary_nationality_flag_7_Invalid),Fields.InvalidMessage_primary_nationality_flag_8(le.primary_nationality_flag_8_Invalid),Fields.InvalidMessage_primary_nationality_flag_9(le.primary_nationality_flag_9_Invalid),Fields.InvalidMessage_primary_nationality_flag_10(le.primary_nationality_flag_10_Invalid),Fields.InvalidMessage_primary_citizenship_flag_1(le.primary_citizenship_flag_1_Invalid),Fields.InvalidMessage_primary_citizenship_flag_2(le.primary_citizenship_flag_2_Invalid),Fields.InvalidMessage_primary_citizenship_flag_3(le.primary_citizenship_flag_3_Invalid),Fields.InvalidMessage_primary_citizenship_flag_4(le.primary_citizenship_flag_4_Invalid),Fields.InvalidMessage_primary_citizenship_flag_5(le.primary_citizenship_flag_5_Invalid),Fields.InvalidMessage_primary_citizenship_flag_6(le.primary_citizenship_flag_6_Invalid),Fields.InvalidMessage_primary_citizenship_flag_7(le.primary_citizenship_flag_7_Invalid),Fields.InvalidMessage_primary_citizenship_flag_8(le.primary_citizenship_flag_8_Invalid),Fields.InvalidMessage_primary_citizenship_flag_9(le.primary_citizenship_flag_9_Invalid),Fields.InvalidMessage_primary_citizenship_flag_10(le.primary_citizenship_flag_10_Invalid),Fields.InvalidMessage_dob_1(le.dob_1_Invalid),Fields.InvalidMessage_dob_2(le.dob_2_Invalid),Fields.InvalidMessage_dob_3(le.dob_3_Invalid),Fields.InvalidMessage_dob_4(le.dob_4_Invalid),Fields.InvalidMessage_dob_5(le.dob_5_Invalid),Fields.InvalidMessage_dob_6(le.dob_6_Invalid),Fields.InvalidMessage_dob_7(le.dob_7_Invalid),Fields.InvalidMessage_dob_8(le.dob_8_Invalid),Fields.InvalidMessage_dob_9(le.dob_9_Invalid),Fields.InvalidMessage_dob_10(le.dob_10_Invalid),Fields.InvalidMessage_primary_dob_flag_1(le.primary_dob_flag_1_Invalid),Fields.InvalidMessage_primary_dob_flag_2(le.primary_dob_flag_2_Invalid),Fields.InvalidMessage_primary_dob_flag_3(le.primary_dob_flag_3_Invalid),Fields.InvalidMessage_primary_dob_flag_4(le.primary_dob_flag_4_Invalid),Fields.InvalidMessage_primary_dob_flag_5(le.primary_dob_flag_5_Invalid),Fields.InvalidMessage_primary_dob_flag_6(le.primary_dob_flag_6_Invalid),Fields.InvalidMessage_primary_dob_flag_7(le.primary_dob_flag_7_Invalid),Fields.InvalidMessage_primary_dob_flag_8(le.primary_dob_flag_8_Invalid),Fields.InvalidMessage_primary_dob_flag_9(le.primary_dob_flag_9_Invalid),Fields.InvalidMessage_primary_dob_flag_10(le.primary_dob_flag_10_Invalid),Fields.InvalidMessage_primary_pob_flag_1(le.primary_pob_flag_1_Invalid),Fields.InvalidMessage_primary_pob_flag_2(le.primary_pob_flag_2_Invalid),Fields.InvalidMessage_primary_pob_flag_3(le.primary_pob_flag_3_Invalid),Fields.InvalidMessage_primary_pob_flag_4(le.primary_pob_flag_4_Invalid),Fields.InvalidMessage_primary_pob_flag_5(le.primary_pob_flag_5_Invalid),Fields.InvalidMessage_primary_pob_flag_6(le.primary_pob_flag_6_Invalid),Fields.InvalidMessage_primary_pob_flag_7(le.primary_pob_flag_7_Invalid),Fields.InvalidMessage_primary_pob_flag_8(le.primary_pob_flag_8_Invalid),Fields.InvalidMessage_primary_pob_flag_9(le.primary_pob_flag_9_Invalid),Fields.InvalidMessage_primary_pob_flag_10(le.primary_pob_flag_10_Invalid),Fields.InvalidMessage_date_added_to_list(le.date_added_to_list_Invalid),Fields.InvalidMessage_date_last_updated(le.date_last_updated_Invalid),Fields.InvalidMessage_effective_date(le.effective_date_Invalid),Fields.InvalidMessage_expiration_date(le.expiration_date_Invalid),Fields.InvalidMessage_gender(le.gender_Invalid),Fields.InvalidMessage_federal_register_citation_date_1(le.federal_register_citation_date_1_Invalid),Fields.InvalidMessage_federal_register_citation_date_2(le.federal_register_citation_date_2_Invalid),Fields.InvalidMessage_federal_register_citation_date_3(le.federal_register_citation_date_3_Invalid),Fields.InvalidMessage_federal_register_citation_date_4(le.federal_register_citation_date_4_Invalid),Fields.InvalidMessage_federal_register_citation_date_5(le.federal_register_citation_date_5_Invalid),Fields.InvalidMessage_federal_register_citation_date_6(le.federal_register_citation_date_6_Invalid),Fields.InvalidMessage_federal_register_citation_date_7(le.federal_register_citation_date_7_Invalid),Fields.InvalidMessage_federal_register_citation_date_8(le.federal_register_citation_date_8_Invalid),Fields.InvalidMessage_federal_register_citation_date_9(le.federal_register_citation_date_9_Invalid),Fields.InvalidMessage_federal_register_citation_date_10(le.federal_register_citation_date_10_Invalid),Fields.InvalidMessage_height(le.height_Invalid),Fields.InvalidMessage_weight(le.weight_Invalid),Fields.InvalidMessage_physique(le.physique_Invalid),Fields.InvalidMessage_hair_color(le.hair_color_Invalid),Fields.InvalidMessage_eyes(le.eyes_Invalid),Fields.InvalidMessage_complexion(le.complexion_Invalid),Fields.InvalidMessage_race(le.race_Invalid),Fields.InvalidMessage_type_of_denial(le.type_of_denial_Invalid),Fields.InvalidMessage_registrant_terminated_flag(le.registrant_terminated_flag_Invalid),Fields.InvalidMessage_foreign_principal_terminated_flag(le.foreign_principal_terminated_flag_Invalid),Fields.InvalidMessage_short_form_terminated_flag(le.short_form_terminated_flag_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.pty_key_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.source_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_pty_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_vessel_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.country_Invalid,'QUOTES','ALLOW','UNKNOWN')
          ,CHOOSE(le.name_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.addr_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_6_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_7_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_8_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_9_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_10_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.aka_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.aka_category_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.giv_designator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.entity_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.address_line_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address_line_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address_line_3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address_state_province_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address_postal_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address_country_Invalid,'QUOTES','ALLOW','UNKNOWN')
          ,CHOOSE(le.vessel_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.vessel_flag_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.vessel_owner_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.id_issue_date_1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.id_issue_date_2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.id_issue_date_3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.id_issue_date_4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.id_issue_date_5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.id_issue_date_6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.id_issue_date_7_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.id_issue_date_8_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.id_issue_date_9_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.id_issue_date_10_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.id_expiration_date_1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.id_expiration_date_2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.id_expiration_date_3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.id_expiration_date_4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.id_expiration_date_5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.id_expiration_date_6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.id_expiration_date_7_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.id_expiration_date_8_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.id_expiration_date_9_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.id_expiration_date_10_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.primary_nationality_flag_1_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_nationality_flag_2_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_nationality_flag_3_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_nationality_flag_4_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_nationality_flag_5_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_nationality_flag_6_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_nationality_flag_7_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_nationality_flag_8_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_nationality_flag_9_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_nationality_flag_10_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_citizenship_flag_1_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_citizenship_flag_2_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_citizenship_flag_3_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_citizenship_flag_4_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_citizenship_flag_5_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_citizenship_flag_6_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_citizenship_flag_7_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_citizenship_flag_8_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_citizenship_flag_9_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_citizenship_flag_10_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dob_1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dob_2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dob_3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dob_4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dob_5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dob_6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dob_7_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dob_8_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dob_9_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dob_10_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.primary_dob_flag_1_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_dob_flag_2_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_dob_flag_3_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_dob_flag_4_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_dob_flag_5_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_dob_flag_6_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_dob_flag_7_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_dob_flag_8_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_dob_flag_9_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_dob_flag_10_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_pob_flag_1_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_pob_flag_2_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_pob_flag_3_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_pob_flag_4_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_pob_flag_5_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_pob_flag_6_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_pob_flag_7_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_pob_flag_8_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_pob_flag_9_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_pob_flag_10_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.date_added_to_list_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_updated_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.effective_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.expiration_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.federal_register_citation_date_1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.federal_register_citation_date_2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.federal_register_citation_date_3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.federal_register_citation_date_4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.federal_register_citation_date_5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.federal_register_citation_date_6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.federal_register_citation_date_7_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.federal_register_citation_date_8_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.federal_register_citation_date_9_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.federal_register_citation_date_10_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.height_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.weight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.physique_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.hair_color_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.eyes_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.complexion_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.race_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.type_of_denial_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.registrant_terminated_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.foreign_principal_terminated_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.short_form_terminated_flag_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'pty_key','source','orig_pty_name','orig_vessel_name','country','name_type','addr_1','addr_2','addr_3','addr_4','addr_5','addr_6','addr_7','addr_8','addr_9','addr_10','cname','title','fname','mname','lname','suffix','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','first_name','last_name','aka_type','aka_category','giv_designator','entity_type','address_line_1','address_line_2','address_line_3','address_city','address_state_province','address_postal_code','address_country','vessel_type','vessel_flag','vessel_owner','id_issue_date_1','id_issue_date_2','id_issue_date_3','id_issue_date_4','id_issue_date_5','id_issue_date_6','id_issue_date_7','id_issue_date_8','id_issue_date_9','id_issue_date_10','id_expiration_date_1','id_expiration_date_2','id_expiration_date_3','id_expiration_date_4','id_expiration_date_5','id_expiration_date_6','id_expiration_date_7','id_expiration_date_8','id_expiration_date_9','id_expiration_date_10','primary_nationality_flag_1','primary_nationality_flag_2','primary_nationality_flag_3','primary_nationality_flag_4','primary_nationality_flag_5','primary_nationality_flag_6','primary_nationality_flag_7','primary_nationality_flag_8','primary_nationality_flag_9','primary_nationality_flag_10','primary_citizenship_flag_1','primary_citizenship_flag_2','primary_citizenship_flag_3','primary_citizenship_flag_4','primary_citizenship_flag_5','primary_citizenship_flag_6','primary_citizenship_flag_7','primary_citizenship_flag_8','primary_citizenship_flag_9','primary_citizenship_flag_10','dob_1','dob_2','dob_3','dob_4','dob_5','dob_6','dob_7','dob_8','dob_9','dob_10','primary_dob_flag_1','primary_dob_flag_2','primary_dob_flag_3','primary_dob_flag_4','primary_dob_flag_5','primary_dob_flag_6','primary_dob_flag_7','primary_dob_flag_8','primary_dob_flag_9','primary_dob_flag_10','primary_pob_flag_1','primary_pob_flag_2','primary_pob_flag_3','primary_pob_flag_4','primary_pob_flag_5','primary_pob_flag_6','primary_pob_flag_7','primary_pob_flag_8','primary_pob_flag_9','primary_pob_flag_10','date_added_to_list','date_last_updated','effective_date','expiration_date','gender','federal_register_citation_date_1','federal_register_citation_date_2','federal_register_citation_date_3','federal_register_citation_date_4','federal_register_citation_date_5','federal_register_citation_date_6','federal_register_citation_date_7','federal_register_citation_date_8','federal_register_citation_date_9','federal_register_citation_date_10','height','weight','physique','hair_color','eyes','complexion','race','type_of_denial','registrant_terminated_flag','foreign_principal_terminated_flag','short_form_terminated_flag','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_source_code','invalid_source','invalid_name','invalid_alphanum','invalid_country_name','invalid_name_type','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_alphanumeric','invalid_name','invalid_name','invalid_name','invalid_name','invalid_suffix','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_alpha','invalid_alpha','invalid_state_abbr','invalid_zip','invalid_zip4','invalid_date','invalid_date','invalid_date','invalid_date','invalid_name','invalid_name','invalid_aka_type','invalid_aka_category','invalid_giv_designator','invalid_entity_type','invalid_address','invalid_address','invalid_address','invalid_alpha','invalid_alphanum','invalid_zipcode','invalid_country_name','invalid_vessel_type','invalid_vessel_flag','invalid_alpha','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_date','invalid_date','invalid_date','invalid_expire_dte','invalid_gender','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_expire_dte','invalid_wgt_hgt','invalid_wgt_hgt','invalid_physique','invalid_hair_color','invalid_hair_color','invalid_complexion','invalid_race','invalid_denial','invalid_flag','invalid_flag','invalid_flag','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT34.StrType)le.pty_key,(SALT34.StrType)le.source,(SALT34.StrType)le.orig_pty_name,(SALT34.StrType)le.orig_vessel_name,(SALT34.StrType)le.country,(SALT34.StrType)le.name_type,(SALT34.StrType)le.addr_1,(SALT34.StrType)le.addr_2,(SALT34.StrType)le.addr_3,(SALT34.StrType)le.addr_4,(SALT34.StrType)le.addr_5,(SALT34.StrType)le.addr_6,(SALT34.StrType)le.addr_7,(SALT34.StrType)le.addr_8,(SALT34.StrType)le.addr_9,(SALT34.StrType)le.addr_10,(SALT34.StrType)le.cname,(SALT34.StrType)le.title,(SALT34.StrType)le.fname,(SALT34.StrType)le.mname,(SALT34.StrType)le.lname,(SALT34.StrType)le.suffix,(SALT34.StrType)le.prim_range,(SALT34.StrType)le.predir,(SALT34.StrType)le.prim_name,(SALT34.StrType)le.addr_suffix,(SALT34.StrType)le.postdir,(SALT34.StrType)le.unit_desig,(SALT34.StrType)le.sec_range,(SALT34.StrType)le.p_city_name,(SALT34.StrType)le.v_city_name,(SALT34.StrType)le.st,(SALT34.StrType)le.zip,(SALT34.StrType)le.zip4,(SALT34.StrType)le.date_first_seen,(SALT34.StrType)le.date_last_seen,(SALT34.StrType)le.date_vendor_first_reported,(SALT34.StrType)le.date_vendor_last_reported,(SALT34.StrType)le.first_name,(SALT34.StrType)le.last_name,(SALT34.StrType)le.aka_type,(SALT34.StrType)le.aka_category,(SALT34.StrType)le.giv_designator,(SALT34.StrType)le.entity_type,(SALT34.StrType)le.address_line_1,(SALT34.StrType)le.address_line_2,(SALT34.StrType)le.address_line_3,(SALT34.StrType)le.address_city,(SALT34.StrType)le.address_state_province,(SALT34.StrType)le.address_postal_code,(SALT34.StrType)le.address_country,(SALT34.StrType)le.vessel_type,(SALT34.StrType)le.vessel_flag,(SALT34.StrType)le.vessel_owner,(SALT34.StrType)le.id_issue_date_1,(SALT34.StrType)le.id_issue_date_2,(SALT34.StrType)le.id_issue_date_3,(SALT34.StrType)le.id_issue_date_4,(SALT34.StrType)le.id_issue_date_5,(SALT34.StrType)le.id_issue_date_6,(SALT34.StrType)le.id_issue_date_7,(SALT34.StrType)le.id_issue_date_8,(SALT34.StrType)le.id_issue_date_9,(SALT34.StrType)le.id_issue_date_10,(SALT34.StrType)le.id_expiration_date_1,(SALT34.StrType)le.id_expiration_date_2,(SALT34.StrType)le.id_expiration_date_3,(SALT34.StrType)le.id_expiration_date_4,(SALT34.StrType)le.id_expiration_date_5,(SALT34.StrType)le.id_expiration_date_6,(SALT34.StrType)le.id_expiration_date_7,(SALT34.StrType)le.id_expiration_date_8,(SALT34.StrType)le.id_expiration_date_9,(SALT34.StrType)le.id_expiration_date_10,(SALT34.StrType)le.primary_nationality_flag_1,(SALT34.StrType)le.primary_nationality_flag_2,(SALT34.StrType)le.primary_nationality_flag_3,(SALT34.StrType)le.primary_nationality_flag_4,(SALT34.StrType)le.primary_nationality_flag_5,(SALT34.StrType)le.primary_nationality_flag_6,(SALT34.StrType)le.primary_nationality_flag_7,(SALT34.StrType)le.primary_nationality_flag_8,(SALT34.StrType)le.primary_nationality_flag_9,(SALT34.StrType)le.primary_nationality_flag_10,(SALT34.StrType)le.primary_citizenship_flag_1,(SALT34.StrType)le.primary_citizenship_flag_2,(SALT34.StrType)le.primary_citizenship_flag_3,(SALT34.StrType)le.primary_citizenship_flag_4,(SALT34.StrType)le.primary_citizenship_flag_5,(SALT34.StrType)le.primary_citizenship_flag_6,(SALT34.StrType)le.primary_citizenship_flag_7,(SALT34.StrType)le.primary_citizenship_flag_8,(SALT34.StrType)le.primary_citizenship_flag_9,(SALT34.StrType)le.primary_citizenship_flag_10,(SALT34.StrType)le.dob_1,(SALT34.StrType)le.dob_2,(SALT34.StrType)le.dob_3,(SALT34.StrType)le.dob_4,(SALT34.StrType)le.dob_5,(SALT34.StrType)le.dob_6,(SALT34.StrType)le.dob_7,(SALT34.StrType)le.dob_8,(SALT34.StrType)le.dob_9,(SALT34.StrType)le.dob_10,(SALT34.StrType)le.primary_dob_flag_1,(SALT34.StrType)le.primary_dob_flag_2,(SALT34.StrType)le.primary_dob_flag_3,(SALT34.StrType)le.primary_dob_flag_4,(SALT34.StrType)le.primary_dob_flag_5,(SALT34.StrType)le.primary_dob_flag_6,(SALT34.StrType)le.primary_dob_flag_7,(SALT34.StrType)le.primary_dob_flag_8,(SALT34.StrType)le.primary_dob_flag_9,(SALT34.StrType)le.primary_dob_flag_10,(SALT34.StrType)le.primary_pob_flag_1,(SALT34.StrType)le.primary_pob_flag_2,(SALT34.StrType)le.primary_pob_flag_3,(SALT34.StrType)le.primary_pob_flag_4,(SALT34.StrType)le.primary_pob_flag_5,(SALT34.StrType)le.primary_pob_flag_6,(SALT34.StrType)le.primary_pob_flag_7,(SALT34.StrType)le.primary_pob_flag_8,(SALT34.StrType)le.primary_pob_flag_9,(SALT34.StrType)le.primary_pob_flag_10,(SALT34.StrType)le.date_added_to_list,(SALT34.StrType)le.date_last_updated,(SALT34.StrType)le.effective_date,(SALT34.StrType)le.expiration_date,(SALT34.StrType)le.gender,(SALT34.StrType)le.federal_register_citation_date_1,(SALT34.StrType)le.federal_register_citation_date_2,(SALT34.StrType)le.federal_register_citation_date_3,(SALT34.StrType)le.federal_register_citation_date_4,(SALT34.StrType)le.federal_register_citation_date_5,(SALT34.StrType)le.federal_register_citation_date_6,(SALT34.StrType)le.federal_register_citation_date_7,(SALT34.StrType)le.federal_register_citation_date_8,(SALT34.StrType)le.federal_register_citation_date_9,(SALT34.StrType)le.federal_register_citation_date_10,(SALT34.StrType)le.height,(SALT34.StrType)le.weight,(SALT34.StrType)le.physique,(SALT34.StrType)le.hair_color,(SALT34.StrType)le.eyes,(SALT34.StrType)le.complexion,(SALT34.StrType)le.race,(SALT34.StrType)le.type_of_denial,(SALT34.StrType)le.registrant_terminated_flag,(SALT34.StrType)le.foreign_principal_terminated_flag,(SALT34.StrType)le.short_form_terminated_flag,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,150,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT34.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.src_key;
      SELF.ruledesc := CHOOSE(c
          ,'pty_key:invalid_source_code:ALLOW','pty_key:invalid_source_code:CUSTOM'
          ,'source:invalid_source:CUSTOM'
          ,'orig_pty_name:invalid_name:CUSTOM'
          ,'orig_vessel_name:invalid_alphanum:ALLOW'
          ,'country:invalid_country_name:QUOTES','country:invalid_country_name:ALLOW'
          ,'name_type:invalid_name_type:ENUM'
          ,'addr_1:invalid_address:ALLOW'
          ,'addr_2:invalid_address:ALLOW'
          ,'addr_3:invalid_address:ALLOW'
          ,'addr_4:invalid_address:ALLOW'
          ,'addr_5:invalid_address:ALLOW'
          ,'addr_6:invalid_address:ALLOW'
          ,'addr_7:invalid_address:ALLOW'
          ,'addr_8:invalid_address:ALLOW'
          ,'addr_9:invalid_address:ALLOW'
          ,'addr_10:invalid_address:ALLOW'
          ,'cname:invalid_alphanumeric:ALLOW'
          ,'title:invalid_name:CUSTOM'
          ,'fname:invalid_name:CUSTOM'
          ,'mname:invalid_name:CUSTOM'
          ,'lname:invalid_name:CUSTOM'
          ,'suffix:invalid_suffix:ENUM'
          ,'prim_range:invalid_address:ALLOW'
          ,'predir:invalid_address:ALLOW'
          ,'prim_name:invalid_address:ALLOW'
          ,'addr_suffix:invalid_address:ALLOW'
          ,'postdir:invalid_address:ALLOW'
          ,'unit_desig:invalid_address:ALLOW'
          ,'sec_range:invalid_address:ALLOW'
          ,'p_city_name:invalid_alpha:ALLOW'
          ,'v_city_name:invalid_alpha:ALLOW'
          ,'st:invalid_state_abbr:CUSTOM'
          ,'zip:invalid_zip:ALLOW','zip:invalid_zip:LENGTH'
          ,'zip4:invalid_zip4:ALLOW','zip4:invalid_zip4:LENGTH'
          ,'date_first_seen:invalid_date:CUSTOM'
          ,'date_last_seen:invalid_date:CUSTOM'
          ,'date_vendor_first_reported:invalid_date:CUSTOM'
          ,'date_vendor_last_reported:invalid_date:CUSTOM'
          ,'first_name:invalid_name:CUSTOM'
          ,'last_name:invalid_name:CUSTOM'
          ,'aka_type:invalid_aka_type:ENUM'
          ,'aka_category:invalid_aka_category:ENUM'
          ,'giv_designator:invalid_giv_designator:ENUM'
          ,'entity_type:invalid_entity_type:ENUM'
          ,'address_line_1:invalid_address:ALLOW'
          ,'address_line_2:invalid_address:ALLOW'
          ,'address_line_3:invalid_address:ALLOW'
          ,'address_city:invalid_alpha:ALLOW'
          ,'address_state_province:invalid_alphanum:ALLOW'
          ,'address_postal_code:invalid_zipcode:ALLOW'
          ,'address_country:invalid_country_name:QUOTES','address_country:invalid_country_name:ALLOW'
          ,'vessel_type:invalid_vessel_type:ENUM'
          ,'vessel_flag:invalid_vessel_flag:CUSTOM'
          ,'vessel_owner:invalid_alpha:ALLOW'
          ,'id_issue_date_1:invalid_date:CUSTOM'
          ,'id_issue_date_2:invalid_date:CUSTOM'
          ,'id_issue_date_3:invalid_date:CUSTOM'
          ,'id_issue_date_4:invalid_date:CUSTOM'
          ,'id_issue_date_5:invalid_date:CUSTOM'
          ,'id_issue_date_6:invalid_date:CUSTOM'
          ,'id_issue_date_7:invalid_date:CUSTOM'
          ,'id_issue_date_8:invalid_date:CUSTOM'
          ,'id_issue_date_9:invalid_date:CUSTOM'
          ,'id_issue_date_10:invalid_date:CUSTOM'
          ,'id_expiration_date_1:invalid_expire_dte:CUSTOM'
          ,'id_expiration_date_2:invalid_expire_dte:CUSTOM'
          ,'id_expiration_date_3:invalid_expire_dte:CUSTOM'
          ,'id_expiration_date_4:invalid_expire_dte:CUSTOM'
          ,'id_expiration_date_5:invalid_expire_dte:CUSTOM'
          ,'id_expiration_date_6:invalid_expire_dte:CUSTOM'
          ,'id_expiration_date_7:invalid_expire_dte:CUSTOM'
          ,'id_expiration_date_8:invalid_expire_dte:CUSTOM'
          ,'id_expiration_date_9:invalid_expire_dte:CUSTOM'
          ,'id_expiration_date_10:invalid_expire_dte:CUSTOM'
          ,'primary_nationality_flag_1:invalid_flag:ENUM'
          ,'primary_nationality_flag_2:invalid_flag:ENUM'
          ,'primary_nationality_flag_3:invalid_flag:ENUM'
          ,'primary_nationality_flag_4:invalid_flag:ENUM'
          ,'primary_nationality_flag_5:invalid_flag:ENUM'
          ,'primary_nationality_flag_6:invalid_flag:ENUM'
          ,'primary_nationality_flag_7:invalid_flag:ENUM'
          ,'primary_nationality_flag_8:invalid_flag:ENUM'
          ,'primary_nationality_flag_9:invalid_flag:ENUM'
          ,'primary_nationality_flag_10:invalid_flag:ENUM'
          ,'primary_citizenship_flag_1:invalid_flag:ENUM'
          ,'primary_citizenship_flag_2:invalid_flag:ENUM'
          ,'primary_citizenship_flag_3:invalid_flag:ENUM'
          ,'primary_citizenship_flag_4:invalid_flag:ENUM'
          ,'primary_citizenship_flag_5:invalid_flag:ENUM'
          ,'primary_citizenship_flag_6:invalid_flag:ENUM'
          ,'primary_citizenship_flag_7:invalid_flag:ENUM'
          ,'primary_citizenship_flag_8:invalid_flag:ENUM'
          ,'primary_citizenship_flag_9:invalid_flag:ENUM'
          ,'primary_citizenship_flag_10:invalid_flag:ENUM'
          ,'dob_1:invalid_date:CUSTOM'
          ,'dob_2:invalid_date:CUSTOM'
          ,'dob_3:invalid_date:CUSTOM'
          ,'dob_4:invalid_date:CUSTOM'
          ,'dob_5:invalid_date:CUSTOM'
          ,'dob_6:invalid_date:CUSTOM'
          ,'dob_7:invalid_date:CUSTOM'
          ,'dob_8:invalid_date:CUSTOM'
          ,'dob_9:invalid_date:CUSTOM'
          ,'dob_10:invalid_date:CUSTOM'
          ,'primary_dob_flag_1:invalid_flag:ENUM'
          ,'primary_dob_flag_2:invalid_flag:ENUM'
          ,'primary_dob_flag_3:invalid_flag:ENUM'
          ,'primary_dob_flag_4:invalid_flag:ENUM'
          ,'primary_dob_flag_5:invalid_flag:ENUM'
          ,'primary_dob_flag_6:invalid_flag:ENUM'
          ,'primary_dob_flag_7:invalid_flag:ENUM'
          ,'primary_dob_flag_8:invalid_flag:ENUM'
          ,'primary_dob_flag_9:invalid_flag:ENUM'
          ,'primary_dob_flag_10:invalid_flag:ENUM'
          ,'primary_pob_flag_1:invalid_flag:ENUM'
          ,'primary_pob_flag_2:invalid_flag:ENUM'
          ,'primary_pob_flag_3:invalid_flag:ENUM'
          ,'primary_pob_flag_4:invalid_flag:ENUM'
          ,'primary_pob_flag_5:invalid_flag:ENUM'
          ,'primary_pob_flag_6:invalid_flag:ENUM'
          ,'primary_pob_flag_7:invalid_flag:ENUM'
          ,'primary_pob_flag_8:invalid_flag:ENUM'
          ,'primary_pob_flag_9:invalid_flag:ENUM'
          ,'primary_pob_flag_10:invalid_flag:ENUM'
          ,'date_added_to_list:invalid_date:CUSTOM'
          ,'date_last_updated:invalid_date:CUSTOM'
          ,'effective_date:invalid_date:CUSTOM'
          ,'expiration_date:invalid_expire_dte:CUSTOM'
          ,'gender:invalid_gender:ENUM'
          ,'federal_register_citation_date_1:invalid_expire_dte:CUSTOM'
          ,'federal_register_citation_date_2:invalid_expire_dte:CUSTOM'
          ,'federal_register_citation_date_3:invalid_expire_dte:CUSTOM'
          ,'federal_register_citation_date_4:invalid_expire_dte:CUSTOM'
          ,'federal_register_citation_date_5:invalid_expire_dte:CUSTOM'
          ,'federal_register_citation_date_6:invalid_expire_dte:CUSTOM'
          ,'federal_register_citation_date_7:invalid_expire_dte:CUSTOM'
          ,'federal_register_citation_date_8:invalid_expire_dte:CUSTOM'
          ,'federal_register_citation_date_9:invalid_expire_dte:CUSTOM'
          ,'federal_register_citation_date_10:invalid_expire_dte:CUSTOM'
          ,'height:invalid_wgt_hgt:ALLOW'
          ,'weight:invalid_wgt_hgt:ALLOW'
          ,'physique:invalid_physique:ENUM'
          ,'hair_color:invalid_hair_color:CUSTOM'
          ,'eyes:invalid_hair_color:CUSTOM'
          ,'complexion:invalid_complexion:ENUM'
          ,'race:invalid_race:ENUM'
          ,'type_of_denial:invalid_denial:ENUM'
          ,'registrant_terminated_flag:invalid_flag:ENUM'
          ,'foreign_principal_terminated_flag:invalid_flag:ENUM'
          ,'short_form_terminated_flag:invalid_flag:ENUM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_pty_key(1),Fields.InvalidMessage_pty_key(2)
          ,Fields.InvalidMessage_source(1)
          ,Fields.InvalidMessage_orig_pty_name(1)
          ,Fields.InvalidMessage_orig_vessel_name(1)
          ,Fields.InvalidMessage_country(1),Fields.InvalidMessage_country(2)
          ,Fields.InvalidMessage_name_type(1)
          ,Fields.InvalidMessage_addr_1(1)
          ,Fields.InvalidMessage_addr_2(1)
          ,Fields.InvalidMessage_addr_3(1)
          ,Fields.InvalidMessage_addr_4(1)
          ,Fields.InvalidMessage_addr_5(1)
          ,Fields.InvalidMessage_addr_6(1)
          ,Fields.InvalidMessage_addr_7(1)
          ,Fields.InvalidMessage_addr_8(1)
          ,Fields.InvalidMessage_addr_9(1)
          ,Fields.InvalidMessage_addr_10(1)
          ,Fields.InvalidMessage_cname(1)
          ,Fields.InvalidMessage_title(1)
          ,Fields.InvalidMessage_fname(1)
          ,Fields.InvalidMessage_mname(1)
          ,Fields.InvalidMessage_lname(1)
          ,Fields.InvalidMessage_suffix(1)
          ,Fields.InvalidMessage_prim_range(1)
          ,Fields.InvalidMessage_predir(1)
          ,Fields.InvalidMessage_prim_name(1)
          ,Fields.InvalidMessage_addr_suffix(1)
          ,Fields.InvalidMessage_postdir(1)
          ,Fields.InvalidMessage_unit_desig(1)
          ,Fields.InvalidMessage_sec_range(1)
          ,Fields.InvalidMessage_p_city_name(1)
          ,Fields.InvalidMessage_v_city_name(1)
          ,Fields.InvalidMessage_st(1)
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2)
          ,Fields.InvalidMessage_zip4(1),Fields.InvalidMessage_zip4(2)
          ,Fields.InvalidMessage_date_first_seen(1)
          ,Fields.InvalidMessage_date_last_seen(1)
          ,Fields.InvalidMessage_date_vendor_first_reported(1)
          ,Fields.InvalidMessage_date_vendor_last_reported(1)
          ,Fields.InvalidMessage_first_name(1)
          ,Fields.InvalidMessage_last_name(1)
          ,Fields.InvalidMessage_aka_type(1)
          ,Fields.InvalidMessage_aka_category(1)
          ,Fields.InvalidMessage_giv_designator(1)
          ,Fields.InvalidMessage_entity_type(1)
          ,Fields.InvalidMessage_address_line_1(1)
          ,Fields.InvalidMessage_address_line_2(1)
          ,Fields.InvalidMessage_address_line_3(1)
          ,Fields.InvalidMessage_address_city(1)
          ,Fields.InvalidMessage_address_state_province(1)
          ,Fields.InvalidMessage_address_postal_code(1)
          ,Fields.InvalidMessage_address_country(1),Fields.InvalidMessage_address_country(2)
          ,Fields.InvalidMessage_vessel_type(1)
          ,Fields.InvalidMessage_vessel_flag(1)
          ,Fields.InvalidMessage_vessel_owner(1)
          ,Fields.InvalidMessage_id_issue_date_1(1)
          ,Fields.InvalidMessage_id_issue_date_2(1)
          ,Fields.InvalidMessage_id_issue_date_3(1)
          ,Fields.InvalidMessage_id_issue_date_4(1)
          ,Fields.InvalidMessage_id_issue_date_5(1)
          ,Fields.InvalidMessage_id_issue_date_6(1)
          ,Fields.InvalidMessage_id_issue_date_7(1)
          ,Fields.InvalidMessage_id_issue_date_8(1)
          ,Fields.InvalidMessage_id_issue_date_9(1)
          ,Fields.InvalidMessage_id_issue_date_10(1)
          ,Fields.InvalidMessage_id_expiration_date_1(1)
          ,Fields.InvalidMessage_id_expiration_date_2(1)
          ,Fields.InvalidMessage_id_expiration_date_3(1)
          ,Fields.InvalidMessage_id_expiration_date_4(1)
          ,Fields.InvalidMessage_id_expiration_date_5(1)
          ,Fields.InvalidMessage_id_expiration_date_6(1)
          ,Fields.InvalidMessage_id_expiration_date_7(1)
          ,Fields.InvalidMessage_id_expiration_date_8(1)
          ,Fields.InvalidMessage_id_expiration_date_9(1)
          ,Fields.InvalidMessage_id_expiration_date_10(1)
          ,Fields.InvalidMessage_primary_nationality_flag_1(1)
          ,Fields.InvalidMessage_primary_nationality_flag_2(1)
          ,Fields.InvalidMessage_primary_nationality_flag_3(1)
          ,Fields.InvalidMessage_primary_nationality_flag_4(1)
          ,Fields.InvalidMessage_primary_nationality_flag_5(1)
          ,Fields.InvalidMessage_primary_nationality_flag_6(1)
          ,Fields.InvalidMessage_primary_nationality_flag_7(1)
          ,Fields.InvalidMessage_primary_nationality_flag_8(1)
          ,Fields.InvalidMessage_primary_nationality_flag_9(1)
          ,Fields.InvalidMessage_primary_nationality_flag_10(1)
          ,Fields.InvalidMessage_primary_citizenship_flag_1(1)
          ,Fields.InvalidMessage_primary_citizenship_flag_2(1)
          ,Fields.InvalidMessage_primary_citizenship_flag_3(1)
          ,Fields.InvalidMessage_primary_citizenship_flag_4(1)
          ,Fields.InvalidMessage_primary_citizenship_flag_5(1)
          ,Fields.InvalidMessage_primary_citizenship_flag_6(1)
          ,Fields.InvalidMessage_primary_citizenship_flag_7(1)
          ,Fields.InvalidMessage_primary_citizenship_flag_8(1)
          ,Fields.InvalidMessage_primary_citizenship_flag_9(1)
          ,Fields.InvalidMessage_primary_citizenship_flag_10(1)
          ,Fields.InvalidMessage_dob_1(1)
          ,Fields.InvalidMessage_dob_2(1)
          ,Fields.InvalidMessage_dob_3(1)
          ,Fields.InvalidMessage_dob_4(1)
          ,Fields.InvalidMessage_dob_5(1)
          ,Fields.InvalidMessage_dob_6(1)
          ,Fields.InvalidMessage_dob_7(1)
          ,Fields.InvalidMessage_dob_8(1)
          ,Fields.InvalidMessage_dob_9(1)
          ,Fields.InvalidMessage_dob_10(1)
          ,Fields.InvalidMessage_primary_dob_flag_1(1)
          ,Fields.InvalidMessage_primary_dob_flag_2(1)
          ,Fields.InvalidMessage_primary_dob_flag_3(1)
          ,Fields.InvalidMessage_primary_dob_flag_4(1)
          ,Fields.InvalidMessage_primary_dob_flag_5(1)
          ,Fields.InvalidMessage_primary_dob_flag_6(1)
          ,Fields.InvalidMessage_primary_dob_flag_7(1)
          ,Fields.InvalidMessage_primary_dob_flag_8(1)
          ,Fields.InvalidMessage_primary_dob_flag_9(1)
          ,Fields.InvalidMessage_primary_dob_flag_10(1)
          ,Fields.InvalidMessage_primary_pob_flag_1(1)
          ,Fields.InvalidMessage_primary_pob_flag_2(1)
          ,Fields.InvalidMessage_primary_pob_flag_3(1)
          ,Fields.InvalidMessage_primary_pob_flag_4(1)
          ,Fields.InvalidMessage_primary_pob_flag_5(1)
          ,Fields.InvalidMessage_primary_pob_flag_6(1)
          ,Fields.InvalidMessage_primary_pob_flag_7(1)
          ,Fields.InvalidMessage_primary_pob_flag_8(1)
          ,Fields.InvalidMessage_primary_pob_flag_9(1)
          ,Fields.InvalidMessage_primary_pob_flag_10(1)
          ,Fields.InvalidMessage_date_added_to_list(1)
          ,Fields.InvalidMessage_date_last_updated(1)
          ,Fields.InvalidMessage_effective_date(1)
          ,Fields.InvalidMessage_expiration_date(1)
          ,Fields.InvalidMessage_gender(1)
          ,Fields.InvalidMessage_federal_register_citation_date_1(1)
          ,Fields.InvalidMessage_federal_register_citation_date_2(1)
          ,Fields.InvalidMessage_federal_register_citation_date_3(1)
          ,Fields.InvalidMessage_federal_register_citation_date_4(1)
          ,Fields.InvalidMessage_federal_register_citation_date_5(1)
          ,Fields.InvalidMessage_federal_register_citation_date_6(1)
          ,Fields.InvalidMessage_federal_register_citation_date_7(1)
          ,Fields.InvalidMessage_federal_register_citation_date_8(1)
          ,Fields.InvalidMessage_federal_register_citation_date_9(1)
          ,Fields.InvalidMessage_federal_register_citation_date_10(1)
          ,Fields.InvalidMessage_height(1)
          ,Fields.InvalidMessage_weight(1)
          ,Fields.InvalidMessage_physique(1)
          ,Fields.InvalidMessage_hair_color(1)
          ,Fields.InvalidMessage_eyes(1)
          ,Fields.InvalidMessage_complexion(1)
          ,Fields.InvalidMessage_race(1)
          ,Fields.InvalidMessage_type_of_denial(1)
          ,Fields.InvalidMessage_registrant_terminated_flag(1)
          ,Fields.InvalidMessage_foreign_principal_terminated_flag(1)
          ,Fields.InvalidMessage_short_form_terminated_flag(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.pty_key_ALLOW_ErrorCount,le.pty_key_CUSTOM_ErrorCount
          ,le.source_CUSTOM_ErrorCount
          ,le.orig_pty_name_CUSTOM_ErrorCount
          ,le.orig_vessel_name_ALLOW_ErrorCount
          ,le.country_QUOTES_ErrorCount,le.country_ALLOW_ErrorCount
          ,le.name_type_ENUM_ErrorCount
          ,le.addr_1_ALLOW_ErrorCount
          ,le.addr_2_ALLOW_ErrorCount
          ,le.addr_3_ALLOW_ErrorCount
          ,le.addr_4_ALLOW_ErrorCount
          ,le.addr_5_ALLOW_ErrorCount
          ,le.addr_6_ALLOW_ErrorCount
          ,le.addr_7_ALLOW_ErrorCount
          ,le.addr_8_ALLOW_ErrorCount
          ,le.addr_9_ALLOW_ErrorCount
          ,le.addr_10_ALLOW_ErrorCount
          ,le.cname_ALLOW_ErrorCount
          ,le.title_CUSTOM_ErrorCount
          ,le.fname_CUSTOM_ErrorCount
          ,le.mname_CUSTOM_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.suffix_ENUM_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.date_vendor_first_reported_CUSTOM_ErrorCount
          ,le.date_vendor_last_reported_CUSTOM_ErrorCount
          ,le.first_name_CUSTOM_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.aka_type_ENUM_ErrorCount
          ,le.aka_category_ENUM_ErrorCount
          ,le.giv_designator_ENUM_ErrorCount
          ,le.entity_type_ENUM_ErrorCount
          ,le.address_line_1_ALLOW_ErrorCount
          ,le.address_line_2_ALLOW_ErrorCount
          ,le.address_line_3_ALLOW_ErrorCount
          ,le.address_city_ALLOW_ErrorCount
          ,le.address_state_province_ALLOW_ErrorCount
          ,le.address_postal_code_ALLOW_ErrorCount
          ,le.address_country_QUOTES_ErrorCount,le.address_country_ALLOW_ErrorCount
          ,le.vessel_type_ENUM_ErrorCount
          ,le.vessel_flag_CUSTOM_ErrorCount
          ,le.vessel_owner_ALLOW_ErrorCount
          ,le.id_issue_date_1_CUSTOM_ErrorCount
          ,le.id_issue_date_2_CUSTOM_ErrorCount
          ,le.id_issue_date_3_CUSTOM_ErrorCount
          ,le.id_issue_date_4_CUSTOM_ErrorCount
          ,le.id_issue_date_5_CUSTOM_ErrorCount
          ,le.id_issue_date_6_CUSTOM_ErrorCount
          ,le.id_issue_date_7_CUSTOM_ErrorCount
          ,le.id_issue_date_8_CUSTOM_ErrorCount
          ,le.id_issue_date_9_CUSTOM_ErrorCount
          ,le.id_issue_date_10_CUSTOM_ErrorCount
          ,le.id_expiration_date_1_CUSTOM_ErrorCount
          ,le.id_expiration_date_2_CUSTOM_ErrorCount
          ,le.id_expiration_date_3_CUSTOM_ErrorCount
          ,le.id_expiration_date_4_CUSTOM_ErrorCount
          ,le.id_expiration_date_5_CUSTOM_ErrorCount
          ,le.id_expiration_date_6_CUSTOM_ErrorCount
          ,le.id_expiration_date_7_CUSTOM_ErrorCount
          ,le.id_expiration_date_8_CUSTOM_ErrorCount
          ,le.id_expiration_date_9_CUSTOM_ErrorCount
          ,le.id_expiration_date_10_CUSTOM_ErrorCount
          ,le.primary_nationality_flag_1_ENUM_ErrorCount
          ,le.primary_nationality_flag_2_ENUM_ErrorCount
          ,le.primary_nationality_flag_3_ENUM_ErrorCount
          ,le.primary_nationality_flag_4_ENUM_ErrorCount
          ,le.primary_nationality_flag_5_ENUM_ErrorCount
          ,le.primary_nationality_flag_6_ENUM_ErrorCount
          ,le.primary_nationality_flag_7_ENUM_ErrorCount
          ,le.primary_nationality_flag_8_ENUM_ErrorCount
          ,le.primary_nationality_flag_9_ENUM_ErrorCount
          ,le.primary_nationality_flag_10_ENUM_ErrorCount
          ,le.primary_citizenship_flag_1_ENUM_ErrorCount
          ,le.primary_citizenship_flag_2_ENUM_ErrorCount
          ,le.primary_citizenship_flag_3_ENUM_ErrorCount
          ,le.primary_citizenship_flag_4_ENUM_ErrorCount
          ,le.primary_citizenship_flag_5_ENUM_ErrorCount
          ,le.primary_citizenship_flag_6_ENUM_ErrorCount
          ,le.primary_citizenship_flag_7_ENUM_ErrorCount
          ,le.primary_citizenship_flag_8_ENUM_ErrorCount
          ,le.primary_citizenship_flag_9_ENUM_ErrorCount
          ,le.primary_citizenship_flag_10_ENUM_ErrorCount
          ,le.dob_1_CUSTOM_ErrorCount
          ,le.dob_2_CUSTOM_ErrorCount
          ,le.dob_3_CUSTOM_ErrorCount
          ,le.dob_4_CUSTOM_ErrorCount
          ,le.dob_5_CUSTOM_ErrorCount
          ,le.dob_6_CUSTOM_ErrorCount
          ,le.dob_7_CUSTOM_ErrorCount
          ,le.dob_8_CUSTOM_ErrorCount
          ,le.dob_9_CUSTOM_ErrorCount
          ,le.dob_10_CUSTOM_ErrorCount
          ,le.primary_dob_flag_1_ENUM_ErrorCount
          ,le.primary_dob_flag_2_ENUM_ErrorCount
          ,le.primary_dob_flag_3_ENUM_ErrorCount
          ,le.primary_dob_flag_4_ENUM_ErrorCount
          ,le.primary_dob_flag_5_ENUM_ErrorCount
          ,le.primary_dob_flag_6_ENUM_ErrorCount
          ,le.primary_dob_flag_7_ENUM_ErrorCount
          ,le.primary_dob_flag_8_ENUM_ErrorCount
          ,le.primary_dob_flag_9_ENUM_ErrorCount
          ,le.primary_dob_flag_10_ENUM_ErrorCount
          ,le.primary_pob_flag_1_ENUM_ErrorCount
          ,le.primary_pob_flag_2_ENUM_ErrorCount
          ,le.primary_pob_flag_3_ENUM_ErrorCount
          ,le.primary_pob_flag_4_ENUM_ErrorCount
          ,le.primary_pob_flag_5_ENUM_ErrorCount
          ,le.primary_pob_flag_6_ENUM_ErrorCount
          ,le.primary_pob_flag_7_ENUM_ErrorCount
          ,le.primary_pob_flag_8_ENUM_ErrorCount
          ,le.primary_pob_flag_9_ENUM_ErrorCount
          ,le.primary_pob_flag_10_ENUM_ErrorCount
          ,le.date_added_to_list_CUSTOM_ErrorCount
          ,le.date_last_updated_CUSTOM_ErrorCount
          ,le.effective_date_CUSTOM_ErrorCount
          ,le.expiration_date_CUSTOM_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.federal_register_citation_date_1_CUSTOM_ErrorCount
          ,le.federal_register_citation_date_2_CUSTOM_ErrorCount
          ,le.federal_register_citation_date_3_CUSTOM_ErrorCount
          ,le.federal_register_citation_date_4_CUSTOM_ErrorCount
          ,le.federal_register_citation_date_5_CUSTOM_ErrorCount
          ,le.federal_register_citation_date_6_CUSTOM_ErrorCount
          ,le.federal_register_citation_date_7_CUSTOM_ErrorCount
          ,le.federal_register_citation_date_8_CUSTOM_ErrorCount
          ,le.federal_register_citation_date_9_CUSTOM_ErrorCount
          ,le.federal_register_citation_date_10_CUSTOM_ErrorCount
          ,le.height_ALLOW_ErrorCount
          ,le.weight_ALLOW_ErrorCount
          ,le.physique_ENUM_ErrorCount
          ,le.hair_color_CUSTOM_ErrorCount
          ,le.eyes_CUSTOM_ErrorCount
          ,le.complexion_ENUM_ErrorCount
          ,le.race_ENUM_ErrorCount
          ,le.type_of_denial_ENUM_ErrorCount
          ,le.registrant_terminated_flag_ENUM_ErrorCount
          ,le.foreign_principal_terminated_flag_ENUM_ErrorCount
          ,le.short_form_terminated_flag_ENUM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.pty_key_ALLOW_ErrorCount,le.pty_key_CUSTOM_ErrorCount
          ,le.source_CUSTOM_ErrorCount
          ,le.orig_pty_name_CUSTOM_ErrorCount
          ,le.orig_vessel_name_ALLOW_ErrorCount
          ,le.country_QUOTES_ErrorCount,le.country_ALLOW_ErrorCount
          ,le.name_type_ENUM_ErrorCount
          ,le.addr_1_ALLOW_ErrorCount
          ,le.addr_2_ALLOW_ErrorCount
          ,le.addr_3_ALLOW_ErrorCount
          ,le.addr_4_ALLOW_ErrorCount
          ,le.addr_5_ALLOW_ErrorCount
          ,le.addr_6_ALLOW_ErrorCount
          ,le.addr_7_ALLOW_ErrorCount
          ,le.addr_8_ALLOW_ErrorCount
          ,le.addr_9_ALLOW_ErrorCount
          ,le.addr_10_ALLOW_ErrorCount
          ,le.cname_ALLOW_ErrorCount
          ,le.title_CUSTOM_ErrorCount
          ,le.fname_CUSTOM_ErrorCount
          ,le.mname_CUSTOM_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.suffix_ENUM_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.date_vendor_first_reported_CUSTOM_ErrorCount
          ,le.date_vendor_last_reported_CUSTOM_ErrorCount
          ,le.first_name_CUSTOM_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.aka_type_ENUM_ErrorCount
          ,le.aka_category_ENUM_ErrorCount
          ,le.giv_designator_ENUM_ErrorCount
          ,le.entity_type_ENUM_ErrorCount
          ,le.address_line_1_ALLOW_ErrorCount
          ,le.address_line_2_ALLOW_ErrorCount
          ,le.address_line_3_ALLOW_ErrorCount
          ,le.address_city_ALLOW_ErrorCount
          ,le.address_state_province_ALLOW_ErrorCount
          ,le.address_postal_code_ALLOW_ErrorCount
          ,le.address_country_QUOTES_ErrorCount,le.address_country_ALLOW_ErrorCount
          ,le.vessel_type_ENUM_ErrorCount
          ,le.vessel_flag_CUSTOM_ErrorCount
          ,le.vessel_owner_ALLOW_ErrorCount
          ,le.id_issue_date_1_CUSTOM_ErrorCount
          ,le.id_issue_date_2_CUSTOM_ErrorCount
          ,le.id_issue_date_3_CUSTOM_ErrorCount
          ,le.id_issue_date_4_CUSTOM_ErrorCount
          ,le.id_issue_date_5_CUSTOM_ErrorCount
          ,le.id_issue_date_6_CUSTOM_ErrorCount
          ,le.id_issue_date_7_CUSTOM_ErrorCount
          ,le.id_issue_date_8_CUSTOM_ErrorCount
          ,le.id_issue_date_9_CUSTOM_ErrorCount
          ,le.id_issue_date_10_CUSTOM_ErrorCount
          ,le.id_expiration_date_1_CUSTOM_ErrorCount
          ,le.id_expiration_date_2_CUSTOM_ErrorCount
          ,le.id_expiration_date_3_CUSTOM_ErrorCount
          ,le.id_expiration_date_4_CUSTOM_ErrorCount
          ,le.id_expiration_date_5_CUSTOM_ErrorCount
          ,le.id_expiration_date_6_CUSTOM_ErrorCount
          ,le.id_expiration_date_7_CUSTOM_ErrorCount
          ,le.id_expiration_date_8_CUSTOM_ErrorCount
          ,le.id_expiration_date_9_CUSTOM_ErrorCount
          ,le.id_expiration_date_10_CUSTOM_ErrorCount
          ,le.primary_nationality_flag_1_ENUM_ErrorCount
          ,le.primary_nationality_flag_2_ENUM_ErrorCount
          ,le.primary_nationality_flag_3_ENUM_ErrorCount
          ,le.primary_nationality_flag_4_ENUM_ErrorCount
          ,le.primary_nationality_flag_5_ENUM_ErrorCount
          ,le.primary_nationality_flag_6_ENUM_ErrorCount
          ,le.primary_nationality_flag_7_ENUM_ErrorCount
          ,le.primary_nationality_flag_8_ENUM_ErrorCount
          ,le.primary_nationality_flag_9_ENUM_ErrorCount
          ,le.primary_nationality_flag_10_ENUM_ErrorCount
          ,le.primary_citizenship_flag_1_ENUM_ErrorCount
          ,le.primary_citizenship_flag_2_ENUM_ErrorCount
          ,le.primary_citizenship_flag_3_ENUM_ErrorCount
          ,le.primary_citizenship_flag_4_ENUM_ErrorCount
          ,le.primary_citizenship_flag_5_ENUM_ErrorCount
          ,le.primary_citizenship_flag_6_ENUM_ErrorCount
          ,le.primary_citizenship_flag_7_ENUM_ErrorCount
          ,le.primary_citizenship_flag_8_ENUM_ErrorCount
          ,le.primary_citizenship_flag_9_ENUM_ErrorCount
          ,le.primary_citizenship_flag_10_ENUM_ErrorCount
          ,le.dob_1_CUSTOM_ErrorCount
          ,le.dob_2_CUSTOM_ErrorCount
          ,le.dob_3_CUSTOM_ErrorCount
          ,le.dob_4_CUSTOM_ErrorCount
          ,le.dob_5_CUSTOM_ErrorCount
          ,le.dob_6_CUSTOM_ErrorCount
          ,le.dob_7_CUSTOM_ErrorCount
          ,le.dob_8_CUSTOM_ErrorCount
          ,le.dob_9_CUSTOM_ErrorCount
          ,le.dob_10_CUSTOM_ErrorCount
          ,le.primary_dob_flag_1_ENUM_ErrorCount
          ,le.primary_dob_flag_2_ENUM_ErrorCount
          ,le.primary_dob_flag_3_ENUM_ErrorCount
          ,le.primary_dob_flag_4_ENUM_ErrorCount
          ,le.primary_dob_flag_5_ENUM_ErrorCount
          ,le.primary_dob_flag_6_ENUM_ErrorCount
          ,le.primary_dob_flag_7_ENUM_ErrorCount
          ,le.primary_dob_flag_8_ENUM_ErrorCount
          ,le.primary_dob_flag_9_ENUM_ErrorCount
          ,le.primary_dob_flag_10_ENUM_ErrorCount
          ,le.primary_pob_flag_1_ENUM_ErrorCount
          ,le.primary_pob_flag_2_ENUM_ErrorCount
          ,le.primary_pob_flag_3_ENUM_ErrorCount
          ,le.primary_pob_flag_4_ENUM_ErrorCount
          ,le.primary_pob_flag_5_ENUM_ErrorCount
          ,le.primary_pob_flag_6_ENUM_ErrorCount
          ,le.primary_pob_flag_7_ENUM_ErrorCount
          ,le.primary_pob_flag_8_ENUM_ErrorCount
          ,le.primary_pob_flag_9_ENUM_ErrorCount
          ,le.primary_pob_flag_10_ENUM_ErrorCount
          ,le.date_added_to_list_CUSTOM_ErrorCount
          ,le.date_last_updated_CUSTOM_ErrorCount
          ,le.effective_date_CUSTOM_ErrorCount
          ,le.expiration_date_CUSTOM_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.federal_register_citation_date_1_CUSTOM_ErrorCount
          ,le.federal_register_citation_date_2_CUSTOM_ErrorCount
          ,le.federal_register_citation_date_3_CUSTOM_ErrorCount
          ,le.federal_register_citation_date_4_CUSTOM_ErrorCount
          ,le.federal_register_citation_date_5_CUSTOM_ErrorCount
          ,le.federal_register_citation_date_6_CUSTOM_ErrorCount
          ,le.federal_register_citation_date_7_CUSTOM_ErrorCount
          ,le.federal_register_citation_date_8_CUSTOM_ErrorCount
          ,le.federal_register_citation_date_9_CUSTOM_ErrorCount
          ,le.federal_register_citation_date_10_CUSTOM_ErrorCount
          ,le.height_ALLOW_ErrorCount
          ,le.weight_ALLOW_ErrorCount
          ,le.physique_ENUM_ErrorCount
          ,le.hair_color_CUSTOM_ErrorCount
          ,le.eyes_CUSTOM_ErrorCount
          ,le.complexion_ENUM_ErrorCount
          ,le.race_ENUM_ErrorCount
          ,le.type_of_denial_ENUM_ErrorCount
          ,le.registrant_terminated_flag_ENUM_ErrorCount
          ,le.foreign_principal_terminated_flag_ENUM_ErrorCount
          ,le.short_form_terminated_flag_ENUM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,155,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT34.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT34.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
