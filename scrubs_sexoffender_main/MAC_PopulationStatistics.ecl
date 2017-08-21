EXPORT MAC_PopulationStatistics(infile,Ref='',orig_state_code='',Input_did = '',Input_score = '',Input_ssn_appended = '',Input_ssn_perms = '',Input_dt_first_reported = '',Input_dt_last_reported = '',Input_orig_state = '',Input_orig_state_code = '',Input_seisint_primary_key = '',Input_vendor_code = '',Input_source_file = '',Input_record_type = '',Input_name_orig = '',Input_lname = '',Input_fname = '',Input_mname = '',Input_name_suffix = '',Input_name_type = '',Input_nid = '',Input_ntype = '',Input_nindicator = '',Input_intnet_email_address_1 = '',Input_intnet_email_address_2 = '',Input_intnet_email_address_3 = '',Input_intnet_email_address_4 = '',Input_intnet_email_address_5 = '',Input_intnet_instant_message_addr_1 = '',Input_intnet_instant_message_addr_2 = '',Input_intnet_instant_message_addr_3 = '',Input_intnet_instant_message_addr_4 = '',Input_intnet_instant_message_addr_5 = '',Input_intnet_user_name_1 = '',Input_intnet_user_name_1_url = '',Input_intnet_user_name_2 = '',Input_intnet_user_name_2_url = '',Input_intnet_user_name_3 = '',Input_intnet_user_name_3_url = '',Input_intnet_user_name_4 = '',Input_intnet_user_name_4_url = '',Input_intnet_user_name_5 = '',Input_intnet_user_name_5_url = '',Input_offender_status = '',Input_offender_category = '',Input_risk_level_code = '',Input_risk_description = '',Input_police_agency = '',Input_police_agency_contact_name = '',Input_police_agency_address_1 = '',Input_police_agency_address_2 = '',Input_police_agency_phone = '',Input_registration_type = '',Input_reg_date_1 = '',Input_reg_date_1_type = '',Input_reg_date_2 = '',Input_reg_date_2_type = '',Input_reg_date_3 = '',Input_reg_date_3_type = '',Input_registration_address_1 = '',Input_registration_address_2 = '',Input_registration_address_3 = '',Input_registration_address_4 = '',Input_registration_address_5 = '',Input_registration_county = '',Input_registration_home_phone = '',Input_registration_cell_phone = '',Input_other_registration_address_1 = '',Input_other_registration_address_2 = '',Input_other_registration_address_3 = '',Input_other_registration_address_4 = '',Input_other_registration_address_5 = '',Input_other_registration_county = '',Input_other_registration_phone = '',Input_temp_lodge_address_1 = '',Input_temp_lodge_address_2 = '',Input_temp_lodge_address_3 = '',Input_temp_lodge_address_4 = '',Input_temp_lodge_address_5 = '',Input_temp_lodge_county = '',Input_temp_lodge_phone = '',Input_employer = '',Input_employer_address_1 = '',Input_employer_address_2 = '',Input_employer_address_3 = '',Input_employer_address_4 = '',Input_employer_address_5 = '',Input_employer_county = '',Input_employer_phone = '',Input_employer_comments = '',Input_professional_licenses_1 = '',Input_professional_licenses_2 = '',Input_professional_licenses_3 = '',Input_professional_licenses_4 = '',Input_professional_licenses_5 = '',Input_school = '',Input_school_address_1 = '',Input_school_address_2 = '',Input_school_address_3 = '',Input_school_address_4 = '',Input_school_address_5 = '',Input_school_county = '',Input_school_phone = '',Input_school_comments = '',Input_offender_id = '',Input_doc_number = '',Input_sor_number = '',Input_st_id_number = '',Input_fbi_number = '',Input_ncic_number = '',Input_ssn = '',Input_dob = '',Input_dob_aka = '',Input_age = '',Input_dna = '',Input_race = '',Input_ethnicity = '',Input_sex = '',Input_hair_color = '',Input_eye_color = '',Input_height = '',Input_weight = '',Input_skin_tone = '',Input_build_type = '',Input_scars_marks_tattoos = '',Input_shoe_size = '',Input_corrective_lense_flag = '',Input_addl_comments_1 = '',Input_addl_comments_2 = '',Input_orig_dl_number = '',Input_orig_dl_state = '',Input_orig_dl_link = '',Input_orig_dl_date = '',Input_passport_type = '',Input_passport_code = '',Input_passport_number = '',Input_passport_first_name = '',Input_passport_given_name = '',Input_passport_nationality = '',Input_passport_dob = '',Input_passport_place_of_birth = '',Input_passport_sex = '',Input_passport_issue_date = '',Input_passport_authority = '',Input_passport_expiration_date = '',Input_passport_endorsement = '',Input_passport_link = '',Input_passport_date = '',Input_orig_veh_year_1 = '',Input_orig_veh_color_1 = '',Input_orig_veh_make_model_1 = '',Input_orig_veh_plate_1 = '',Input_orig_registration_number_1 = '',Input_orig_veh_state_1 = '',Input_orig_veh_location_1 = '',Input_orig_veh_year_2 = '',Input_orig_veh_color_2 = '',Input_orig_veh_make_model_2 = '',Input_orig_veh_plate_2 = '',Input_orig_registration_number_2 = '',Input_orig_veh_state_2 = '',Input_orig_veh_location_2 = '',Input_orig_veh_year_3 = '',Input_orig_veh_color_3 = '',Input_orig_veh_make_model_3 = '',Input_orig_veh_plate_3 = '',Input_orig_registration_number_3 = '',Input_orig_veh_state_3 = '',Input_orig_veh_location_3 = '',Input_orig_veh_year_4 = '',Input_orig_veh_color_4 = '',Input_orig_veh_make_model_4 = '',Input_orig_veh_plate_4 = '',Input_orig_registration_number_4 = '',Input_orig_veh_state_4 = '',Input_orig_veh_location_4 = '',Input_orig_veh_year_5 = '',Input_orig_veh_color_5 = '',Input_orig_veh_make_model_5 = '',Input_orig_veh_plate_5 = '',Input_orig_registration_number_5 = '',Input_orig_veh_state_5 = '',Input_orig_veh_location_5 = '',Input_fingerprint_link = '',Input_fingerprint_date = '',Input_palmprint_link = '',Input_palmprint_date = '',Input_image_link = '',Input_image_date = '',Input_addr_dt_last_seen = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip5 = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_clean_errors = '',Input_rawaid = '',Input_curr_incar_flag = '',Input_curr_parole_flag = '',Input_curr_probation_flag = '',Input_fcra_conviction_flag = '',Input_fcra_traffic_flag = '',Input_fcra_date = '',Input_fcra_date_type = '',Input_conviction_override_date = '',Input_conviction_override_date_type = '',Input_offense_score = '',Input_offender_persistent_id = '',OutFile) := MACRO
  IMPORT SALT33,scrubs_sexoffender_main;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(orig_state_code)<>'')
    SALT33.StrType source;
    #END
    SALT33.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
+    #IF( #TEXT(Input_score)='' )
      '' 
    #ELSE
        IF( le.Input_score = (TYPEOF(le.Input_score))'','',':score')
    #END
+    #IF( #TEXT(Input_ssn_appended)='' )
      '' 
    #ELSE
        IF( le.Input_ssn_appended = (TYPEOF(le.Input_ssn_appended))'','',':ssn_appended')
    #END
+    #IF( #TEXT(Input_ssn_perms)='' )
      '' 
    #ELSE
        IF( le.Input_ssn_perms = (TYPEOF(le.Input_ssn_perms))'','',':ssn_perms')
    #END
+    #IF( #TEXT(Input_dt_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_reported = (TYPEOF(le.Input_dt_first_reported))'','',':dt_first_reported')
    #END
+    #IF( #TEXT(Input_dt_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_reported = (TYPEOF(le.Input_dt_last_reported))'','',':dt_last_reported')
    #END
+    #IF( #TEXT(Input_orig_state)='' )
      '' 
    #ELSE
        IF( le.Input_orig_state = (TYPEOF(le.Input_orig_state))'','',':orig_state')
    #END
+    #IF( #TEXT(Input_orig_state_code)='' )
      '' 
    #ELSE
        IF( le.Input_orig_state_code = (TYPEOF(le.Input_orig_state_code))'','',':orig_state_code')
    #END
+    #IF( #TEXT(Input_seisint_primary_key)='' )
      '' 
    #ELSE
        IF( le.Input_seisint_primary_key = (TYPEOF(le.Input_seisint_primary_key))'','',':seisint_primary_key')
    #END
+    #IF( #TEXT(Input_vendor_code)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_code = (TYPEOF(le.Input_vendor_code))'','',':vendor_code')
    #END
+    #IF( #TEXT(Input_source_file)='' )
      '' 
    #ELSE
        IF( le.Input_source_file = (TYPEOF(le.Input_source_file))'','',':source_file')
    #END
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
+    #IF( #TEXT(Input_name_orig)='' )
      '' 
    #ELSE
        IF( le.Input_name_orig = (TYPEOF(le.Input_name_orig))'','',':name_orig')
    #END
+    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
    #END
+    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (TYPEOF(le.Input_fname))'','',':fname')
    #END
+    #IF( #TEXT(Input_mname)='' )
      '' 
    #ELSE
        IF( le.Input_mname = (TYPEOF(le.Input_mname))'','',':mname')
    #END
+    #IF( #TEXT(Input_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix = (TYPEOF(le.Input_name_suffix))'','',':name_suffix')
    #END
+    #IF( #TEXT(Input_name_type)='' )
      '' 
    #ELSE
        IF( le.Input_name_type = (TYPEOF(le.Input_name_type))'','',':name_type')
    #END
+    #IF( #TEXT(Input_nid)='' )
      '' 
    #ELSE
        IF( le.Input_nid = (TYPEOF(le.Input_nid))'','',':nid')
    #END
+    #IF( #TEXT(Input_ntype)='' )
      '' 
    #ELSE
        IF( le.Input_ntype = (TYPEOF(le.Input_ntype))'','',':ntype')
    #END
+    #IF( #TEXT(Input_nindicator)='' )
      '' 
    #ELSE
        IF( le.Input_nindicator = (TYPEOF(le.Input_nindicator))'','',':nindicator')
    #END
+    #IF( #TEXT(Input_intnet_email_address_1)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_email_address_1 = (TYPEOF(le.Input_intnet_email_address_1))'','',':intnet_email_address_1')
    #END
+    #IF( #TEXT(Input_intnet_email_address_2)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_email_address_2 = (TYPEOF(le.Input_intnet_email_address_2))'','',':intnet_email_address_2')
    #END
+    #IF( #TEXT(Input_intnet_email_address_3)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_email_address_3 = (TYPEOF(le.Input_intnet_email_address_3))'','',':intnet_email_address_3')
    #END
+    #IF( #TEXT(Input_intnet_email_address_4)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_email_address_4 = (TYPEOF(le.Input_intnet_email_address_4))'','',':intnet_email_address_4')
    #END
+    #IF( #TEXT(Input_intnet_email_address_5)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_email_address_5 = (TYPEOF(le.Input_intnet_email_address_5))'','',':intnet_email_address_5')
    #END
+    #IF( #TEXT(Input_intnet_instant_message_addr_1)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_instant_message_addr_1 = (TYPEOF(le.Input_intnet_instant_message_addr_1))'','',':intnet_instant_message_addr_1')
    #END
+    #IF( #TEXT(Input_intnet_instant_message_addr_2)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_instant_message_addr_2 = (TYPEOF(le.Input_intnet_instant_message_addr_2))'','',':intnet_instant_message_addr_2')
    #END
+    #IF( #TEXT(Input_intnet_instant_message_addr_3)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_instant_message_addr_3 = (TYPEOF(le.Input_intnet_instant_message_addr_3))'','',':intnet_instant_message_addr_3')
    #END
+    #IF( #TEXT(Input_intnet_instant_message_addr_4)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_instant_message_addr_4 = (TYPEOF(le.Input_intnet_instant_message_addr_4))'','',':intnet_instant_message_addr_4')
    #END
+    #IF( #TEXT(Input_intnet_instant_message_addr_5)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_instant_message_addr_5 = (TYPEOF(le.Input_intnet_instant_message_addr_5))'','',':intnet_instant_message_addr_5')
    #END
+    #IF( #TEXT(Input_intnet_user_name_1)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_user_name_1 = (TYPEOF(le.Input_intnet_user_name_1))'','',':intnet_user_name_1')
    #END
+    #IF( #TEXT(Input_intnet_user_name_1_url)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_user_name_1_url = (TYPEOF(le.Input_intnet_user_name_1_url))'','',':intnet_user_name_1_url')
    #END
+    #IF( #TEXT(Input_intnet_user_name_2)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_user_name_2 = (TYPEOF(le.Input_intnet_user_name_2))'','',':intnet_user_name_2')
    #END
+    #IF( #TEXT(Input_intnet_user_name_2_url)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_user_name_2_url = (TYPEOF(le.Input_intnet_user_name_2_url))'','',':intnet_user_name_2_url')
    #END
+    #IF( #TEXT(Input_intnet_user_name_3)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_user_name_3 = (TYPEOF(le.Input_intnet_user_name_3))'','',':intnet_user_name_3')
    #END
+    #IF( #TEXT(Input_intnet_user_name_3_url)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_user_name_3_url = (TYPEOF(le.Input_intnet_user_name_3_url))'','',':intnet_user_name_3_url')
    #END
+    #IF( #TEXT(Input_intnet_user_name_4)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_user_name_4 = (TYPEOF(le.Input_intnet_user_name_4))'','',':intnet_user_name_4')
    #END
+    #IF( #TEXT(Input_intnet_user_name_4_url)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_user_name_4_url = (TYPEOF(le.Input_intnet_user_name_4_url))'','',':intnet_user_name_4_url')
    #END
+    #IF( #TEXT(Input_intnet_user_name_5)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_user_name_5 = (TYPEOF(le.Input_intnet_user_name_5))'','',':intnet_user_name_5')
    #END
+    #IF( #TEXT(Input_intnet_user_name_5_url)='' )
      '' 
    #ELSE
        IF( le.Input_intnet_user_name_5_url = (TYPEOF(le.Input_intnet_user_name_5_url))'','',':intnet_user_name_5_url')
    #END
+    #IF( #TEXT(Input_offender_status)='' )
      '' 
    #ELSE
        IF( le.Input_offender_status = (TYPEOF(le.Input_offender_status))'','',':offender_status')
    #END
+    #IF( #TEXT(Input_offender_category)='' )
      '' 
    #ELSE
        IF( le.Input_offender_category = (TYPEOF(le.Input_offender_category))'','',':offender_category')
    #END
+    #IF( #TEXT(Input_risk_level_code)='' )
      '' 
    #ELSE
        IF( le.Input_risk_level_code = (TYPEOF(le.Input_risk_level_code))'','',':risk_level_code')
    #END
+    #IF( #TEXT(Input_risk_description)='' )
      '' 
    #ELSE
        IF( le.Input_risk_description = (TYPEOF(le.Input_risk_description))'','',':risk_description')
    #END
+    #IF( #TEXT(Input_police_agency)='' )
      '' 
    #ELSE
        IF( le.Input_police_agency = (TYPEOF(le.Input_police_agency))'','',':police_agency')
    #END
+    #IF( #TEXT(Input_police_agency_contact_name)='' )
      '' 
    #ELSE
        IF( le.Input_police_agency_contact_name = (TYPEOF(le.Input_police_agency_contact_name))'','',':police_agency_contact_name')
    #END
+    #IF( #TEXT(Input_police_agency_address_1)='' )
      '' 
    #ELSE
        IF( le.Input_police_agency_address_1 = (TYPEOF(le.Input_police_agency_address_1))'','',':police_agency_address_1')
    #END
+    #IF( #TEXT(Input_police_agency_address_2)='' )
      '' 
    #ELSE
        IF( le.Input_police_agency_address_2 = (TYPEOF(le.Input_police_agency_address_2))'','',':police_agency_address_2')
    #END
+    #IF( #TEXT(Input_police_agency_phone)='' )
      '' 
    #ELSE
        IF( le.Input_police_agency_phone = (TYPEOF(le.Input_police_agency_phone))'','',':police_agency_phone')
    #END
+    #IF( #TEXT(Input_registration_type)='' )
      '' 
    #ELSE
        IF( le.Input_registration_type = (TYPEOF(le.Input_registration_type))'','',':registration_type')
    #END
+    #IF( #TEXT(Input_reg_date_1)='' )
      '' 
    #ELSE
        IF( le.Input_reg_date_1 = (TYPEOF(le.Input_reg_date_1))'','',':reg_date_1')
    #END
+    #IF( #TEXT(Input_reg_date_1_type)='' )
      '' 
    #ELSE
        IF( le.Input_reg_date_1_type = (TYPEOF(le.Input_reg_date_1_type))'','',':reg_date_1_type')
    #END
+    #IF( #TEXT(Input_reg_date_2)='' )
      '' 
    #ELSE
        IF( le.Input_reg_date_2 = (TYPEOF(le.Input_reg_date_2))'','',':reg_date_2')
    #END
+    #IF( #TEXT(Input_reg_date_2_type)='' )
      '' 
    #ELSE
        IF( le.Input_reg_date_2_type = (TYPEOF(le.Input_reg_date_2_type))'','',':reg_date_2_type')
    #END
+    #IF( #TEXT(Input_reg_date_3)='' )
      '' 
    #ELSE
        IF( le.Input_reg_date_3 = (TYPEOF(le.Input_reg_date_3))'','',':reg_date_3')
    #END
+    #IF( #TEXT(Input_reg_date_3_type)='' )
      '' 
    #ELSE
        IF( le.Input_reg_date_3_type = (TYPEOF(le.Input_reg_date_3_type))'','',':reg_date_3_type')
    #END
+    #IF( #TEXT(Input_registration_address_1)='' )
      '' 
    #ELSE
        IF( le.Input_registration_address_1 = (TYPEOF(le.Input_registration_address_1))'','',':registration_address_1')
    #END
+    #IF( #TEXT(Input_registration_address_2)='' )
      '' 
    #ELSE
        IF( le.Input_registration_address_2 = (TYPEOF(le.Input_registration_address_2))'','',':registration_address_2')
    #END
+    #IF( #TEXT(Input_registration_address_3)='' )
      '' 
    #ELSE
        IF( le.Input_registration_address_3 = (TYPEOF(le.Input_registration_address_3))'','',':registration_address_3')
    #END
+    #IF( #TEXT(Input_registration_address_4)='' )
      '' 
    #ELSE
        IF( le.Input_registration_address_4 = (TYPEOF(le.Input_registration_address_4))'','',':registration_address_4')
    #END
+    #IF( #TEXT(Input_registration_address_5)='' )
      '' 
    #ELSE
        IF( le.Input_registration_address_5 = (TYPEOF(le.Input_registration_address_5))'','',':registration_address_5')
    #END
+    #IF( #TEXT(Input_registration_county)='' )
      '' 
    #ELSE
        IF( le.Input_registration_county = (TYPEOF(le.Input_registration_county))'','',':registration_county')
    #END
+    #IF( #TEXT(Input_registration_home_phone)='' )
      '' 
    #ELSE
        IF( le.Input_registration_home_phone = (TYPEOF(le.Input_registration_home_phone))'','',':registration_home_phone')
    #END
+    #IF( #TEXT(Input_registration_cell_phone)='' )
      '' 
    #ELSE
        IF( le.Input_registration_cell_phone = (TYPEOF(le.Input_registration_cell_phone))'','',':registration_cell_phone')
    #END
+    #IF( #TEXT(Input_other_registration_address_1)='' )
      '' 
    #ELSE
        IF( le.Input_other_registration_address_1 = (TYPEOF(le.Input_other_registration_address_1))'','',':other_registration_address_1')
    #END
+    #IF( #TEXT(Input_other_registration_address_2)='' )
      '' 
    #ELSE
        IF( le.Input_other_registration_address_2 = (TYPEOF(le.Input_other_registration_address_2))'','',':other_registration_address_2')
    #END
+    #IF( #TEXT(Input_other_registration_address_3)='' )
      '' 
    #ELSE
        IF( le.Input_other_registration_address_3 = (TYPEOF(le.Input_other_registration_address_3))'','',':other_registration_address_3')
    #END
+    #IF( #TEXT(Input_other_registration_address_4)='' )
      '' 
    #ELSE
        IF( le.Input_other_registration_address_4 = (TYPEOF(le.Input_other_registration_address_4))'','',':other_registration_address_4')
    #END
+    #IF( #TEXT(Input_other_registration_address_5)='' )
      '' 
    #ELSE
        IF( le.Input_other_registration_address_5 = (TYPEOF(le.Input_other_registration_address_5))'','',':other_registration_address_5')
    #END
+    #IF( #TEXT(Input_other_registration_county)='' )
      '' 
    #ELSE
        IF( le.Input_other_registration_county = (TYPEOF(le.Input_other_registration_county))'','',':other_registration_county')
    #END
+    #IF( #TEXT(Input_other_registration_phone)='' )
      '' 
    #ELSE
        IF( le.Input_other_registration_phone = (TYPEOF(le.Input_other_registration_phone))'','',':other_registration_phone')
    #END
+    #IF( #TEXT(Input_temp_lodge_address_1)='' )
      '' 
    #ELSE
        IF( le.Input_temp_lodge_address_1 = (TYPEOF(le.Input_temp_lodge_address_1))'','',':temp_lodge_address_1')
    #END
+    #IF( #TEXT(Input_temp_lodge_address_2)='' )
      '' 
    #ELSE
        IF( le.Input_temp_lodge_address_2 = (TYPEOF(le.Input_temp_lodge_address_2))'','',':temp_lodge_address_2')
    #END
+    #IF( #TEXT(Input_temp_lodge_address_3)='' )
      '' 
    #ELSE
        IF( le.Input_temp_lodge_address_3 = (TYPEOF(le.Input_temp_lodge_address_3))'','',':temp_lodge_address_3')
    #END
+    #IF( #TEXT(Input_temp_lodge_address_4)='' )
      '' 
    #ELSE
        IF( le.Input_temp_lodge_address_4 = (TYPEOF(le.Input_temp_lodge_address_4))'','',':temp_lodge_address_4')
    #END
+    #IF( #TEXT(Input_temp_lodge_address_5)='' )
      '' 
    #ELSE
        IF( le.Input_temp_lodge_address_5 = (TYPEOF(le.Input_temp_lodge_address_5))'','',':temp_lodge_address_5')
    #END
+    #IF( #TEXT(Input_temp_lodge_county)='' )
      '' 
    #ELSE
        IF( le.Input_temp_lodge_county = (TYPEOF(le.Input_temp_lodge_county))'','',':temp_lodge_county')
    #END
+    #IF( #TEXT(Input_temp_lodge_phone)='' )
      '' 
    #ELSE
        IF( le.Input_temp_lodge_phone = (TYPEOF(le.Input_temp_lodge_phone))'','',':temp_lodge_phone')
    #END
+    #IF( #TEXT(Input_employer)='' )
      '' 
    #ELSE
        IF( le.Input_employer = (TYPEOF(le.Input_employer))'','',':employer')
    #END
+    #IF( #TEXT(Input_employer_address_1)='' )
      '' 
    #ELSE
        IF( le.Input_employer_address_1 = (TYPEOF(le.Input_employer_address_1))'','',':employer_address_1')
    #END
+    #IF( #TEXT(Input_employer_address_2)='' )
      '' 
    #ELSE
        IF( le.Input_employer_address_2 = (TYPEOF(le.Input_employer_address_2))'','',':employer_address_2')
    #END
+    #IF( #TEXT(Input_employer_address_3)='' )
      '' 
    #ELSE
        IF( le.Input_employer_address_3 = (TYPEOF(le.Input_employer_address_3))'','',':employer_address_3')
    #END
+    #IF( #TEXT(Input_employer_address_4)='' )
      '' 
    #ELSE
        IF( le.Input_employer_address_4 = (TYPEOF(le.Input_employer_address_4))'','',':employer_address_4')
    #END
+    #IF( #TEXT(Input_employer_address_5)='' )
      '' 
    #ELSE
        IF( le.Input_employer_address_5 = (TYPEOF(le.Input_employer_address_5))'','',':employer_address_5')
    #END
+    #IF( #TEXT(Input_employer_county)='' )
      '' 
    #ELSE
        IF( le.Input_employer_county = (TYPEOF(le.Input_employer_county))'','',':employer_county')
    #END
+    #IF( #TEXT(Input_employer_phone)='' )
      '' 
    #ELSE
        IF( le.Input_employer_phone = (TYPEOF(le.Input_employer_phone))'','',':employer_phone')
    #END
+    #IF( #TEXT(Input_employer_comments)='' )
      '' 
    #ELSE
        IF( le.Input_employer_comments = (TYPEOF(le.Input_employer_comments))'','',':employer_comments')
    #END
+    #IF( #TEXT(Input_professional_licenses_1)='' )
      '' 
    #ELSE
        IF( le.Input_professional_licenses_1 = (TYPEOF(le.Input_professional_licenses_1))'','',':professional_licenses_1')
    #END
+    #IF( #TEXT(Input_professional_licenses_2)='' )
      '' 
    #ELSE
        IF( le.Input_professional_licenses_2 = (TYPEOF(le.Input_professional_licenses_2))'','',':professional_licenses_2')
    #END
+    #IF( #TEXT(Input_professional_licenses_3)='' )
      '' 
    #ELSE
        IF( le.Input_professional_licenses_3 = (TYPEOF(le.Input_professional_licenses_3))'','',':professional_licenses_3')
    #END
+    #IF( #TEXT(Input_professional_licenses_4)='' )
      '' 
    #ELSE
        IF( le.Input_professional_licenses_4 = (TYPEOF(le.Input_professional_licenses_4))'','',':professional_licenses_4')
    #END
+    #IF( #TEXT(Input_professional_licenses_5)='' )
      '' 
    #ELSE
        IF( le.Input_professional_licenses_5 = (TYPEOF(le.Input_professional_licenses_5))'','',':professional_licenses_5')
    #END
+    #IF( #TEXT(Input_school)='' )
      '' 
    #ELSE
        IF( le.Input_school = (TYPEOF(le.Input_school))'','',':school')
    #END
+    #IF( #TEXT(Input_school_address_1)='' )
      '' 
    #ELSE
        IF( le.Input_school_address_1 = (TYPEOF(le.Input_school_address_1))'','',':school_address_1')
    #END
+    #IF( #TEXT(Input_school_address_2)='' )
      '' 
    #ELSE
        IF( le.Input_school_address_2 = (TYPEOF(le.Input_school_address_2))'','',':school_address_2')
    #END
+    #IF( #TEXT(Input_school_address_3)='' )
      '' 
    #ELSE
        IF( le.Input_school_address_3 = (TYPEOF(le.Input_school_address_3))'','',':school_address_3')
    #END
+    #IF( #TEXT(Input_school_address_4)='' )
      '' 
    #ELSE
        IF( le.Input_school_address_4 = (TYPEOF(le.Input_school_address_4))'','',':school_address_4')
    #END
+    #IF( #TEXT(Input_school_address_5)='' )
      '' 
    #ELSE
        IF( le.Input_school_address_5 = (TYPEOF(le.Input_school_address_5))'','',':school_address_5')
    #END
+    #IF( #TEXT(Input_school_county)='' )
      '' 
    #ELSE
        IF( le.Input_school_county = (TYPEOF(le.Input_school_county))'','',':school_county')
    #END
+    #IF( #TEXT(Input_school_phone)='' )
      '' 
    #ELSE
        IF( le.Input_school_phone = (TYPEOF(le.Input_school_phone))'','',':school_phone')
    #END
+    #IF( #TEXT(Input_school_comments)='' )
      '' 
    #ELSE
        IF( le.Input_school_comments = (TYPEOF(le.Input_school_comments))'','',':school_comments')
    #END
+    #IF( #TEXT(Input_offender_id)='' )
      '' 
    #ELSE
        IF( le.Input_offender_id = (TYPEOF(le.Input_offender_id))'','',':offender_id')
    #END
+    #IF( #TEXT(Input_doc_number)='' )
      '' 
    #ELSE
        IF( le.Input_doc_number = (TYPEOF(le.Input_doc_number))'','',':doc_number')
    #END
+    #IF( #TEXT(Input_sor_number)='' )
      '' 
    #ELSE
        IF( le.Input_sor_number = (TYPEOF(le.Input_sor_number))'','',':sor_number')
    #END
+    #IF( #TEXT(Input_st_id_number)='' )
      '' 
    #ELSE
        IF( le.Input_st_id_number = (TYPEOF(le.Input_st_id_number))'','',':st_id_number')
    #END
+    #IF( #TEXT(Input_fbi_number)='' )
      '' 
    #ELSE
        IF( le.Input_fbi_number = (TYPEOF(le.Input_fbi_number))'','',':fbi_number')
    #END
+    #IF( #TEXT(Input_ncic_number)='' )
      '' 
    #ELSE
        IF( le.Input_ncic_number = (TYPEOF(le.Input_ncic_number))'','',':ncic_number')
    #END
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
+    #IF( #TEXT(Input_dob_aka)='' )
      '' 
    #ELSE
        IF( le.Input_dob_aka = (TYPEOF(le.Input_dob_aka))'','',':dob_aka')
    #END
+    #IF( #TEXT(Input_age)='' )
      '' 
    #ELSE
        IF( le.Input_age = (TYPEOF(le.Input_age))'','',':age')
    #END
+    #IF( #TEXT(Input_dna)='' )
      '' 
    #ELSE
        IF( le.Input_dna = (TYPEOF(le.Input_dna))'','',':dna')
    #END
+    #IF( #TEXT(Input_race)='' )
      '' 
    #ELSE
        IF( le.Input_race = (TYPEOF(le.Input_race))'','',':race')
    #END
+    #IF( #TEXT(Input_ethnicity)='' )
      '' 
    #ELSE
        IF( le.Input_ethnicity = (TYPEOF(le.Input_ethnicity))'','',':ethnicity')
    #END
+    #IF( #TEXT(Input_sex)='' )
      '' 
    #ELSE
        IF( le.Input_sex = (TYPEOF(le.Input_sex))'','',':sex')
    #END
+    #IF( #TEXT(Input_hair_color)='' )
      '' 
    #ELSE
        IF( le.Input_hair_color = (TYPEOF(le.Input_hair_color))'','',':hair_color')
    #END
+    #IF( #TEXT(Input_eye_color)='' )
      '' 
    #ELSE
        IF( le.Input_eye_color = (TYPEOF(le.Input_eye_color))'','',':eye_color')
    #END
+    #IF( #TEXT(Input_height)='' )
      '' 
    #ELSE
        IF( le.Input_height = (TYPEOF(le.Input_height))'','',':height')
    #END
+    #IF( #TEXT(Input_weight)='' )
      '' 
    #ELSE
        IF( le.Input_weight = (TYPEOF(le.Input_weight))'','',':weight')
    #END
+    #IF( #TEXT(Input_skin_tone)='' )
      '' 
    #ELSE
        IF( le.Input_skin_tone = (TYPEOF(le.Input_skin_tone))'','',':skin_tone')
    #END
+    #IF( #TEXT(Input_build_type)='' )
      '' 
    #ELSE
        IF( le.Input_build_type = (TYPEOF(le.Input_build_type))'','',':build_type')
    #END
+    #IF( #TEXT(Input_scars_marks_tattoos)='' )
      '' 
    #ELSE
        IF( le.Input_scars_marks_tattoos = (TYPEOF(le.Input_scars_marks_tattoos))'','',':scars_marks_tattoos')
    #END
+    #IF( #TEXT(Input_shoe_size)='' )
      '' 
    #ELSE
        IF( le.Input_shoe_size = (TYPEOF(le.Input_shoe_size))'','',':shoe_size')
    #END
+    #IF( #TEXT(Input_corrective_lense_flag)='' )
      '' 
    #ELSE
        IF( le.Input_corrective_lense_flag = (TYPEOF(le.Input_corrective_lense_flag))'','',':corrective_lense_flag')
    #END
+    #IF( #TEXT(Input_addl_comments_1)='' )
      '' 
    #ELSE
        IF( le.Input_addl_comments_1 = (TYPEOF(le.Input_addl_comments_1))'','',':addl_comments_1')
    #END
+    #IF( #TEXT(Input_addl_comments_2)='' )
      '' 
    #ELSE
        IF( le.Input_addl_comments_2 = (TYPEOF(le.Input_addl_comments_2))'','',':addl_comments_2')
    #END
+    #IF( #TEXT(Input_orig_dl_number)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dl_number = (TYPEOF(le.Input_orig_dl_number))'','',':orig_dl_number')
    #END
+    #IF( #TEXT(Input_orig_dl_state)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dl_state = (TYPEOF(le.Input_orig_dl_state))'','',':orig_dl_state')
    #END
+    #IF( #TEXT(Input_orig_dl_link)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dl_link = (TYPEOF(le.Input_orig_dl_link))'','',':orig_dl_link')
    #END
+    #IF( #TEXT(Input_orig_dl_date)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dl_date = (TYPEOF(le.Input_orig_dl_date))'','',':orig_dl_date')
    #END
+    #IF( #TEXT(Input_passport_type)='' )
      '' 
    #ELSE
        IF( le.Input_passport_type = (TYPEOF(le.Input_passport_type))'','',':passport_type')
    #END
+    #IF( #TEXT(Input_passport_code)='' )
      '' 
    #ELSE
        IF( le.Input_passport_code = (TYPEOF(le.Input_passport_code))'','',':passport_code')
    #END
+    #IF( #TEXT(Input_passport_number)='' )
      '' 
    #ELSE
        IF( le.Input_passport_number = (TYPEOF(le.Input_passport_number))'','',':passport_number')
    #END
+    #IF( #TEXT(Input_passport_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_passport_first_name = (TYPEOF(le.Input_passport_first_name))'','',':passport_first_name')
    #END
+    #IF( #TEXT(Input_passport_given_name)='' )
      '' 
    #ELSE
        IF( le.Input_passport_given_name = (TYPEOF(le.Input_passport_given_name))'','',':passport_given_name')
    #END
+    #IF( #TEXT(Input_passport_nationality)='' )
      '' 
    #ELSE
        IF( le.Input_passport_nationality = (TYPEOF(le.Input_passport_nationality))'','',':passport_nationality')
    #END
+    #IF( #TEXT(Input_passport_dob)='' )
      '' 
    #ELSE
        IF( le.Input_passport_dob = (TYPEOF(le.Input_passport_dob))'','',':passport_dob')
    #END
+    #IF( #TEXT(Input_passport_place_of_birth)='' )
      '' 
    #ELSE
        IF( le.Input_passport_place_of_birth = (TYPEOF(le.Input_passport_place_of_birth))'','',':passport_place_of_birth')
    #END
+    #IF( #TEXT(Input_passport_sex)='' )
      '' 
    #ELSE
        IF( le.Input_passport_sex = (TYPEOF(le.Input_passport_sex))'','',':passport_sex')
    #END
+    #IF( #TEXT(Input_passport_issue_date)='' )
      '' 
    #ELSE
        IF( le.Input_passport_issue_date = (TYPEOF(le.Input_passport_issue_date))'','',':passport_issue_date')
    #END
+    #IF( #TEXT(Input_passport_authority)='' )
      '' 
    #ELSE
        IF( le.Input_passport_authority = (TYPEOF(le.Input_passport_authority))'','',':passport_authority')
    #END
+    #IF( #TEXT(Input_passport_expiration_date)='' )
      '' 
    #ELSE
        IF( le.Input_passport_expiration_date = (TYPEOF(le.Input_passport_expiration_date))'','',':passport_expiration_date')
    #END
+    #IF( #TEXT(Input_passport_endorsement)='' )
      '' 
    #ELSE
        IF( le.Input_passport_endorsement = (TYPEOF(le.Input_passport_endorsement))'','',':passport_endorsement')
    #END
+    #IF( #TEXT(Input_passport_link)='' )
      '' 
    #ELSE
        IF( le.Input_passport_link = (TYPEOF(le.Input_passport_link))'','',':passport_link')
    #END
+    #IF( #TEXT(Input_passport_date)='' )
      '' 
    #ELSE
        IF( le.Input_passport_date = (TYPEOF(le.Input_passport_date))'','',':passport_date')
    #END
+    #IF( #TEXT(Input_orig_veh_year_1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_year_1 = (TYPEOF(le.Input_orig_veh_year_1))'','',':orig_veh_year_1')
    #END
+    #IF( #TEXT(Input_orig_veh_color_1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_color_1 = (TYPEOF(le.Input_orig_veh_color_1))'','',':orig_veh_color_1')
    #END
+    #IF( #TEXT(Input_orig_veh_make_model_1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_make_model_1 = (TYPEOF(le.Input_orig_veh_make_model_1))'','',':orig_veh_make_model_1')
    #END
+    #IF( #TEXT(Input_orig_veh_plate_1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_plate_1 = (TYPEOF(le.Input_orig_veh_plate_1))'','',':orig_veh_plate_1')
    #END
+    #IF( #TEXT(Input_orig_registration_number_1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_registration_number_1 = (TYPEOF(le.Input_orig_registration_number_1))'','',':orig_registration_number_1')
    #END
+    #IF( #TEXT(Input_orig_veh_state_1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_state_1 = (TYPEOF(le.Input_orig_veh_state_1))'','',':orig_veh_state_1')
    #END
+    #IF( #TEXT(Input_orig_veh_location_1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_location_1 = (TYPEOF(le.Input_orig_veh_location_1))'','',':orig_veh_location_1')
    #END
+    #IF( #TEXT(Input_orig_veh_year_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_year_2 = (TYPEOF(le.Input_orig_veh_year_2))'','',':orig_veh_year_2')
    #END
+    #IF( #TEXT(Input_orig_veh_color_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_color_2 = (TYPEOF(le.Input_orig_veh_color_2))'','',':orig_veh_color_2')
    #END
+    #IF( #TEXT(Input_orig_veh_make_model_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_make_model_2 = (TYPEOF(le.Input_orig_veh_make_model_2))'','',':orig_veh_make_model_2')
    #END
+    #IF( #TEXT(Input_orig_veh_plate_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_plate_2 = (TYPEOF(le.Input_orig_veh_plate_2))'','',':orig_veh_plate_2')
    #END
+    #IF( #TEXT(Input_orig_registration_number_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_registration_number_2 = (TYPEOF(le.Input_orig_registration_number_2))'','',':orig_registration_number_2')
    #END
+    #IF( #TEXT(Input_orig_veh_state_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_state_2 = (TYPEOF(le.Input_orig_veh_state_2))'','',':orig_veh_state_2')
    #END
+    #IF( #TEXT(Input_orig_veh_location_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_location_2 = (TYPEOF(le.Input_orig_veh_location_2))'','',':orig_veh_location_2')
    #END
+    #IF( #TEXT(Input_orig_veh_year_3)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_year_3 = (TYPEOF(le.Input_orig_veh_year_3))'','',':orig_veh_year_3')
    #END
+    #IF( #TEXT(Input_orig_veh_color_3)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_color_3 = (TYPEOF(le.Input_orig_veh_color_3))'','',':orig_veh_color_3')
    #END
+    #IF( #TEXT(Input_orig_veh_make_model_3)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_make_model_3 = (TYPEOF(le.Input_orig_veh_make_model_3))'','',':orig_veh_make_model_3')
    #END
+    #IF( #TEXT(Input_orig_veh_plate_3)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_plate_3 = (TYPEOF(le.Input_orig_veh_plate_3))'','',':orig_veh_plate_3')
    #END
+    #IF( #TEXT(Input_orig_registration_number_3)='' )
      '' 
    #ELSE
        IF( le.Input_orig_registration_number_3 = (TYPEOF(le.Input_orig_registration_number_3))'','',':orig_registration_number_3')
    #END
+    #IF( #TEXT(Input_orig_veh_state_3)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_state_3 = (TYPEOF(le.Input_orig_veh_state_3))'','',':orig_veh_state_3')
    #END
+    #IF( #TEXT(Input_orig_veh_location_3)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_location_3 = (TYPEOF(le.Input_orig_veh_location_3))'','',':orig_veh_location_3')
    #END
+    #IF( #TEXT(Input_orig_veh_year_4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_year_4 = (TYPEOF(le.Input_orig_veh_year_4))'','',':orig_veh_year_4')
    #END
+    #IF( #TEXT(Input_orig_veh_color_4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_color_4 = (TYPEOF(le.Input_orig_veh_color_4))'','',':orig_veh_color_4')
    #END
+    #IF( #TEXT(Input_orig_veh_make_model_4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_make_model_4 = (TYPEOF(le.Input_orig_veh_make_model_4))'','',':orig_veh_make_model_4')
    #END
+    #IF( #TEXT(Input_orig_veh_plate_4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_plate_4 = (TYPEOF(le.Input_orig_veh_plate_4))'','',':orig_veh_plate_4')
    #END
+    #IF( #TEXT(Input_orig_registration_number_4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_registration_number_4 = (TYPEOF(le.Input_orig_registration_number_4))'','',':orig_registration_number_4')
    #END
+    #IF( #TEXT(Input_orig_veh_state_4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_state_4 = (TYPEOF(le.Input_orig_veh_state_4))'','',':orig_veh_state_4')
    #END
+    #IF( #TEXT(Input_orig_veh_location_4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_location_4 = (TYPEOF(le.Input_orig_veh_location_4))'','',':orig_veh_location_4')
    #END
+    #IF( #TEXT(Input_orig_veh_year_5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_year_5 = (TYPEOF(le.Input_orig_veh_year_5))'','',':orig_veh_year_5')
    #END
+    #IF( #TEXT(Input_orig_veh_color_5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_color_5 = (TYPEOF(le.Input_orig_veh_color_5))'','',':orig_veh_color_5')
    #END
+    #IF( #TEXT(Input_orig_veh_make_model_5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_make_model_5 = (TYPEOF(le.Input_orig_veh_make_model_5))'','',':orig_veh_make_model_5')
    #END
+    #IF( #TEXT(Input_orig_veh_plate_5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_plate_5 = (TYPEOF(le.Input_orig_veh_plate_5))'','',':orig_veh_plate_5')
    #END
+    #IF( #TEXT(Input_orig_registration_number_5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_registration_number_5 = (TYPEOF(le.Input_orig_registration_number_5))'','',':orig_registration_number_5')
    #END
+    #IF( #TEXT(Input_orig_veh_state_5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_state_5 = (TYPEOF(le.Input_orig_veh_state_5))'','',':orig_veh_state_5')
    #END
+    #IF( #TEXT(Input_orig_veh_location_5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_veh_location_5 = (TYPEOF(le.Input_orig_veh_location_5))'','',':orig_veh_location_5')
    #END
+    #IF( #TEXT(Input_fingerprint_link)='' )
      '' 
    #ELSE
        IF( le.Input_fingerprint_link = (TYPEOF(le.Input_fingerprint_link))'','',':fingerprint_link')
    #END
+    #IF( #TEXT(Input_fingerprint_date)='' )
      '' 
    #ELSE
        IF( le.Input_fingerprint_date = (TYPEOF(le.Input_fingerprint_date))'','',':fingerprint_date')
    #END
+    #IF( #TEXT(Input_palmprint_link)='' )
      '' 
    #ELSE
        IF( le.Input_palmprint_link = (TYPEOF(le.Input_palmprint_link))'','',':palmprint_link')
    #END
+    #IF( #TEXT(Input_palmprint_date)='' )
      '' 
    #ELSE
        IF( le.Input_palmprint_date = (TYPEOF(le.Input_palmprint_date))'','',':palmprint_date')
    #END
+    #IF( #TEXT(Input_image_link)='' )
      '' 
    #ELSE
        IF( le.Input_image_link = (TYPEOF(le.Input_image_link))'','',':image_link')
    #END
+    #IF( #TEXT(Input_image_date)='' )
      '' 
    #ELSE
        IF( le.Input_image_date = (TYPEOF(le.Input_image_date))'','',':image_date')
    #END
+    #IF( #TEXT(Input_addr_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_addr_dt_last_seen = (TYPEOF(le.Input_addr_dt_last_seen))'','',':addr_dt_last_seen')
    #END
+    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
    #END
+    #IF( #TEXT(Input_predir)='' )
      '' 
    #ELSE
        IF( le.Input_predir = (TYPEOF(le.Input_predir))'','',':predir')
    #END
+    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (TYPEOF(le.Input_prim_name))'','',':prim_name')
    #END
+    #IF( #TEXT(Input_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_addr_suffix = (TYPEOF(le.Input_addr_suffix))'','',':addr_suffix')
    #END
+    #IF( #TEXT(Input_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_postdir = (TYPEOF(le.Input_postdir))'','',':postdir')
    #END
+    #IF( #TEXT(Input_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_unit_desig = (TYPEOF(le.Input_unit_desig))'','',':unit_desig')
    #END
+    #IF( #TEXT(Input_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range = (TYPEOF(le.Input_sec_range))'','',':sec_range')
    #END
+    #IF( #TEXT(Input_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_p_city_name = (TYPEOF(le.Input_p_city_name))'','',':p_city_name')
    #END
+    #IF( #TEXT(Input_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_v_city_name = (TYPEOF(le.Input_v_city_name))'','',':v_city_name')
    #END
+    #IF( #TEXT(Input_st)='' )
      '' 
    #ELSE
        IF( le.Input_st = (TYPEOF(le.Input_st))'','',':st')
    #END
+    #IF( #TEXT(Input_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_zip5 = (TYPEOF(le.Input_zip5))'','',':zip5')
    #END
+    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
+    #IF( #TEXT(Input_cart)='' )
      '' 
    #ELSE
        IF( le.Input_cart = (TYPEOF(le.Input_cart))'','',':cart')
    #END
+    #IF( #TEXT(Input_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_cr_sort_sz = (TYPEOF(le.Input_cr_sort_sz))'','',':cr_sort_sz')
    #END
+    #IF( #TEXT(Input_lot)='' )
      '' 
    #ELSE
        IF( le.Input_lot = (TYPEOF(le.Input_lot))'','',':lot')
    #END
+    #IF( #TEXT(Input_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_lot_order = (TYPEOF(le.Input_lot_order))'','',':lot_order')
    #END
+    #IF( #TEXT(Input_dbpc)='' )
      '' 
    #ELSE
        IF( le.Input_dbpc = (TYPEOF(le.Input_dbpc))'','',':dbpc')
    #END
+    #IF( #TEXT(Input_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_chk_digit = (TYPEOF(le.Input_chk_digit))'','',':chk_digit')
    #END
+    #IF( #TEXT(Input_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_rec_type = (TYPEOF(le.Input_rec_type))'','',':rec_type')
    #END
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
    #END
+    #IF( #TEXT(Input_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_geo_lat = (TYPEOF(le.Input_geo_lat))'','',':geo_lat')
    #END
+    #IF( #TEXT(Input_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_geo_long = (TYPEOF(le.Input_geo_long))'','',':geo_long')
    #END
+    #IF( #TEXT(Input_msa)='' )
      '' 
    #ELSE
        IF( le.Input_msa = (TYPEOF(le.Input_msa))'','',':msa')
    #END
+    #IF( #TEXT(Input_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_geo_blk = (TYPEOF(le.Input_geo_blk))'','',':geo_blk')
    #END
+    #IF( #TEXT(Input_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_geo_match = (TYPEOF(le.Input_geo_match))'','',':geo_match')
    #END
+    #IF( #TEXT(Input_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_err_stat = (TYPEOF(le.Input_err_stat))'','',':err_stat')
    #END
+    #IF( #TEXT(Input_clean_errors)='' )
      '' 
    #ELSE
        IF( le.Input_clean_errors = (TYPEOF(le.Input_clean_errors))'','',':clean_errors')
    #END
+    #IF( #TEXT(Input_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_rawaid = (TYPEOF(le.Input_rawaid))'','',':rawaid')
    #END
+    #IF( #TEXT(Input_curr_incar_flag)='' )
      '' 
    #ELSE
        IF( le.Input_curr_incar_flag = (TYPEOF(le.Input_curr_incar_flag))'','',':curr_incar_flag')
    #END
+    #IF( #TEXT(Input_curr_parole_flag)='' )
      '' 
    #ELSE
        IF( le.Input_curr_parole_flag = (TYPEOF(le.Input_curr_parole_flag))'','',':curr_parole_flag')
    #END
+    #IF( #TEXT(Input_curr_probation_flag)='' )
      '' 
    #ELSE
        IF( le.Input_curr_probation_flag = (TYPEOF(le.Input_curr_probation_flag))'','',':curr_probation_flag')
    #END
+    #IF( #TEXT(Input_fcra_conviction_flag)='' )
      '' 
    #ELSE
        IF( le.Input_fcra_conviction_flag = (TYPEOF(le.Input_fcra_conviction_flag))'','',':fcra_conviction_flag')
    #END
+    #IF( #TEXT(Input_fcra_traffic_flag)='' )
      '' 
    #ELSE
        IF( le.Input_fcra_traffic_flag = (TYPEOF(le.Input_fcra_traffic_flag))'','',':fcra_traffic_flag')
    #END
+    #IF( #TEXT(Input_fcra_date)='' )
      '' 
    #ELSE
        IF( le.Input_fcra_date = (TYPEOF(le.Input_fcra_date))'','',':fcra_date')
    #END
+    #IF( #TEXT(Input_fcra_date_type)='' )
      '' 
    #ELSE
        IF( le.Input_fcra_date_type = (TYPEOF(le.Input_fcra_date_type))'','',':fcra_date_type')
    #END
+    #IF( #TEXT(Input_conviction_override_date)='' )
      '' 
    #ELSE
        IF( le.Input_conviction_override_date = (TYPEOF(le.Input_conviction_override_date))'','',':conviction_override_date')
    #END
+    #IF( #TEXT(Input_conviction_override_date_type)='' )
      '' 
    #ELSE
        IF( le.Input_conviction_override_date_type = (TYPEOF(le.Input_conviction_override_date_type))'','',':conviction_override_date_type')
    #END
+    #IF( #TEXT(Input_offense_score)='' )
      '' 
    #ELSE
        IF( le.Input_offense_score = (TYPEOF(le.Input_offense_score))'','',':offense_score')
    #END
+    #IF( #TEXT(Input_offender_persistent_id)='' )
      '' 
    #ELSE
        IF( le.Input_offender_persistent_id = (TYPEOF(le.Input_offender_persistent_id))'','',':offender_persistent_id')
    #END
;
    #IF (#TEXT(orig_state_code)<>'')
    SELF.source := le.orig_state_code;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(orig_state_code)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(orig_state_code)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(orig_state_code)<>'' ) source, #END -cnt );
ENDMACRO;
