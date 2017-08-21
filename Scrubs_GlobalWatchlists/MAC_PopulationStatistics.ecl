 
EXPORT MAC_PopulationStatistics(infile,Ref='',src_key='',Input_pty_key = '',Input_source = '',Input_orig_pty_name = '',Input_orig_vessel_name = '',Input_country = '',Input_name_type = '',Input_addr_1 = '',Input_addr_2 = '',Input_addr_3 = '',Input_addr_4 = '',Input_addr_5 = '',Input_addr_6 = '',Input_addr_7 = '',Input_addr_8 = '',Input_addr_9 = '',Input_addr_10 = '',Input_remarks_1 = '',Input_remarks_2 = '',Input_remarks_3 = '',Input_remarks_4 = '',Input_remarks_5 = '',Input_remarks_6 = '',Input_remarks_7 = '',Input_remarks_8 = '',Input_remarks_9 = '',Input_remarks_10 = '',Input_remarks_11 = '',Input_remarks_12 = '',Input_remarks_13 = '',Input_remarks_14 = '',Input_remarks_15 = '',Input_remarks_16 = '',Input_remarks_17 = '',Input_remarks_18 = '',Input_remarks_19 = '',Input_remarks_20 = '',Input_remarks_21 = '',Input_remarks_22 = '',Input_remarks_23 = '',Input_remarks_24 = '',Input_remarks_25 = '',Input_remarks_26 = '',Input_remarks_27 = '',Input_remarks_28 = '',Input_remarks_29 = '',Input_remarks_30 = '',Input_cname = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_suffix = '',Input_a_score = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dpbc = '',Input_chk_digit = '',Input_record_type = '',Input_ace_fips_st = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_date_vendor_first_reported = '',Input_date_vendor_last_reported = '',Input_entity_id = '',Input_first_name = '',Input_last_name = '',Input_title_1 = '',Input_title_2 = '',Input_title_3 = '',Input_title_4 = '',Input_title_5 = '',Input_title_6 = '',Input_title_7 = '',Input_title_8 = '',Input_title_9 = '',Input_title_10 = '',Input_aka_id = '',Input_aka_type = '',Input_aka_category = '',Input_giv_designator = '',Input_entity_type = '',Input_address_id = '',Input_address_line_1 = '',Input_address_line_2 = '',Input_address_line_3 = '',Input_address_city = '',Input_address_state_province = '',Input_address_postal_code = '',Input_address_country = '',Input_remarks = '',Input_call_sign = '',Input_vessel_type = '',Input_tonnage = '',Input_gross_registered_tonnage = '',Input_vessel_flag = '',Input_vessel_owner = '',Input_sanctions_program_1 = '',Input_sanctions_program_2 = '',Input_sanctions_program_3 = '',Input_sanctions_program_4 = '',Input_sanctions_program_5 = '',Input_sanctions_program_6 = '',Input_sanctions_program_7 = '',Input_sanctions_program_8 = '',Input_sanctions_program_9 = '',Input_sanctions_program_10 = '',Input_passport_details = '',Input_ni_number_details = '',Input_id_id_1 = '',Input_id_id_2 = '',Input_id_id_3 = '',Input_id_id_4 = '',Input_id_id_5 = '',Input_id_id_6 = '',Input_id_id_7 = '',Input_id_id_8 = '',Input_id_id_9 = '',Input_id_id_10 = '',Input_id_type_1 = '',Input_id_type_2 = '',Input_id_type_3 = '',Input_id_type_4 = '',Input_id_type_5 = '',Input_id_type_6 = '',Input_id_type_7 = '',Input_id_type_8 = '',Input_id_type_9 = '',Input_id_type_10 = '',Input_id_number_1 = '',Input_id_number_2 = '',Input_id_number_3 = '',Input_id_number_4 = '',Input_id_number_5 = '',Input_id_number_6 = '',Input_id_number_7 = '',Input_id_number_8 = '',Input_id_number_9 = '',Input_id_number_10 = '',Input_id_country_1 = '',Input_id_country_2 = '',Input_id_country_3 = '',Input_id_country_4 = '',Input_id_country_5 = '',Input_id_country_6 = '',Input_id_country_7 = '',Input_id_country_8 = '',Input_id_country_9 = '',Input_id_country_10 = '',Input_id_issue_date_1 = '',Input_id_issue_date_2 = '',Input_id_issue_date_3 = '',Input_id_issue_date_4 = '',Input_id_issue_date_5 = '',Input_id_issue_date_6 = '',Input_id_issue_date_7 = '',Input_id_issue_date_8 = '',Input_id_issue_date_9 = '',Input_id_issue_date_10 = '',Input_id_expiration_date_1 = '',Input_id_expiration_date_2 = '',Input_id_expiration_date_3 = '',Input_id_expiration_date_4 = '',Input_id_expiration_date_5 = '',Input_id_expiration_date_6 = '',Input_id_expiration_date_7 = '',Input_id_expiration_date_8 = '',Input_id_expiration_date_9 = '',Input_id_expiration_date_10 = '',Input_nationality_id_1 = '',Input_nationality_id_2 = '',Input_nationality_id_3 = '',Input_nationality_id_4 = '',Input_nationality_id_5 = '',Input_nationality_id_6 = '',Input_nationality_id_7 = '',Input_nationality_id_8 = '',Input_nationality_id_9 = '',Input_nationality_id_10 = '',Input_nationality_1 = '',Input_nationality_2 = '',Input_nationality_3 = '',Input_nationality_4 = '',Input_nationality_5 = '',Input_nationality_6 = '',Input_nationality_7 = '',Input_nationality_8 = '',Input_nationality_9 = '',Input_nationality_10 = '',Input_primary_nationality_flag_1 = '',Input_primary_nationality_flag_2 = '',Input_primary_nationality_flag_3 = '',Input_primary_nationality_flag_4 = '',Input_primary_nationality_flag_5 = '',Input_primary_nationality_flag_6 = '',Input_primary_nationality_flag_7 = '',Input_primary_nationality_flag_8 = '',Input_primary_nationality_flag_9 = '',Input_primary_nationality_flag_10 = '',Input_citizenship_id_1 = '',Input_citizenship_id_2 = '',Input_citizenship_id_3 = '',Input_citizenship_id_4 = '',Input_citizenship_id_5 = '',Input_citizenship_id_6 = '',Input_citizenship_id_7 = '',Input_citizenship_id_8 = '',Input_citizenship_id_9 = '',Input_citizenship_id_10 = '',Input_citizenship_1 = '',Input_citizenship_2 = '',Input_citizenship_3 = '',Input_citizenship_4 = '',Input_citizenship_5 = '',Input_citizenship_6 = '',Input_citizenship_7 = '',Input_citizenship_8 = '',Input_citizenship_9 = '',Input_citizenship_10 = '',Input_primary_citizenship_flag_1 = '',Input_primary_citizenship_flag_2 = '',Input_primary_citizenship_flag_3 = '',Input_primary_citizenship_flag_4 = '',Input_primary_citizenship_flag_5 = '',Input_primary_citizenship_flag_6 = '',Input_primary_citizenship_flag_7 = '',Input_primary_citizenship_flag_8 = '',Input_primary_citizenship_flag_9 = '',Input_primary_citizenship_flag_10 = '',Input_dob_id_1 = '',Input_dob_id_2 = '',Input_dob_id_3 = '',Input_dob_id_4 = '',Input_dob_id_5 = '',Input_dob_id_6 = '',Input_dob_id_7 = '',Input_dob_id_8 = '',Input_dob_id_9 = '',Input_dob_id_10 = '',Input_dob_1 = '',Input_dob_2 = '',Input_dob_3 = '',Input_dob_4 = '',Input_dob_5 = '',Input_dob_6 = '',Input_dob_7 = '',Input_dob_8 = '',Input_dob_9 = '',Input_dob_10 = '',Input_primary_dob_flag_1 = '',Input_primary_dob_flag_2 = '',Input_primary_dob_flag_3 = '',Input_primary_dob_flag_4 = '',Input_primary_dob_flag_5 = '',Input_primary_dob_flag_6 = '',Input_primary_dob_flag_7 = '',Input_primary_dob_flag_8 = '',Input_primary_dob_flag_9 = '',Input_primary_dob_flag_10 = '',Input_pob_id_1 = '',Input_pob_id_2 = '',Input_pob_id_3 = '',Input_pob_id_4 = '',Input_pob_id_5 = '',Input_pob_id_6 = '',Input_pob_id_7 = '',Input_pob_id_8 = '',Input_pob_id_9 = '',Input_pob_id_10 = '',Input_pob_1 = '',Input_pob_2 = '',Input_pob_3 = '',Input_pob_4 = '',Input_pob_5 = '',Input_pob_6 = '',Input_pob_7 = '',Input_pob_8 = '',Input_pob_9 = '',Input_pob_10 = '',Input_country_of_birth_1 = '',Input_country_of_birth_2 = '',Input_country_of_birth_3 = '',Input_country_of_birth_4 = '',Input_country_of_birth_5 = '',Input_country_of_birth_6 = '',Input_country_of_birth_7 = '',Input_country_of_birth_8 = '',Input_country_of_birth_9 = '',Input_country_of_birth_10 = '',Input_primary_pob_flag_1 = '',Input_primary_pob_flag_2 = '',Input_primary_pob_flag_3 = '',Input_primary_pob_flag_4 = '',Input_primary_pob_flag_5 = '',Input_primary_pob_flag_6 = '',Input_primary_pob_flag_7 = '',Input_primary_pob_flag_8 = '',Input_primary_pob_flag_9 = '',Input_primary_pob_flag_10 = '',Input_language_1 = '',Input_language_2 = '',Input_language_3 = '',Input_language_4 = '',Input_language_5 = '',Input_language_6 = '',Input_language_7 = '',Input_language_8 = '',Input_language_9 = '',Input_language_10 = '',Input_membership_1 = '',Input_membership_2 = '',Input_membership_3 = '',Input_membership_4 = '',Input_membership_5 = '',Input_membership_6 = '',Input_membership_7 = '',Input_membership_8 = '',Input_membership_9 = '',Input_membership_10 = '',Input_position_1 = '',Input_position_2 = '',Input_position_3 = '',Input_position_4 = '',Input_position_5 = '',Input_position_6 = '',Input_position_7 = '',Input_position_8 = '',Input_position_9 = '',Input_position_10 = '',Input_occupation_1 = '',Input_occupation_2 = '',Input_occupation_3 = '',Input_occupation_4 = '',Input_occupation_5 = '',Input_occupation_6 = '',Input_occupation_7 = '',Input_occupation_8 = '',Input_occupation_9 = '',Input_occupation_10 = '',Input_date_added_to_list = '',Input_date_last_updated = '',Input_effective_date = '',Input_expiration_date = '',Input_gender = '',Input_grounds = '',Input_subj_to_common_pos_2001_931_cfsp_fl = '',Input_federal_register_citation_1 = '',Input_federal_register_citation_2 = '',Input_federal_register_citation_3 = '',Input_federal_register_citation_4 = '',Input_federal_register_citation_5 = '',Input_federal_register_citation_6 = '',Input_federal_register_citation_7 = '',Input_federal_register_citation_8 = '',Input_federal_register_citation_9 = '',Input_federal_register_citation_10 = '',Input_federal_register_citation_date_1 = '',Input_federal_register_citation_date_2 = '',Input_federal_register_citation_date_3 = '',Input_federal_register_citation_date_4 = '',Input_federal_register_citation_date_5 = '',Input_federal_register_citation_date_6 = '',Input_federal_register_citation_date_7 = '',Input_federal_register_citation_date_8 = '',Input_federal_register_citation_date_9 = '',Input_federal_register_citation_date_10 = '',Input_license_requirement = '',Input_license_review_policy = '',Input_subordinate_status = '',Input_height = '',Input_weight = '',Input_physique = '',Input_hair_color = '',Input_eyes = '',Input_complexion = '',Input_race = '',Input_scars_marks = '',Input_photo_file = '',Input_offenses = '',Input_ncic = '',Input_warrant_by = '',Input_caution = '',Input_reward = '',Input_type_of_denial = '',Input_linked_with_1 = '',Input_linked_with_2 = '',Input_linked_with_3 = '',Input_linked_with_4 = '',Input_linked_with_5 = '',Input_linked_with_6 = '',Input_linked_with_7 = '',Input_linked_with_8 = '',Input_linked_with_9 = '',Input_linked_with_10 = '',Input_linked_with_id_1 = '',Input_linked_with_id_2 = '',Input_linked_with_id_3 = '',Input_linked_with_id_4 = '',Input_linked_with_id_5 = '',Input_linked_with_id_6 = '',Input_linked_with_id_7 = '',Input_linked_with_id_8 = '',Input_linked_with_id_9 = '',Input_linked_with_id_10 = '',Input_listing_information = '',Input_foreign_principal = '',Input_nature_of_service = '',Input_activities = '',Input_finances = '',Input_registrant_terminated_flag = '',Input_foreign_principal_terminated_flag = '',Input_short_form_terminated_flag = '',Input_src_key = '',OutFile) := MACRO
  IMPORT SALT34,Scrubs_GlobalWatchlists;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(src_key)<>'')
    SALT34.StrType source;
    #END
    SALT34.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_pty_key)='' )
      '' 
    #ELSE
        IF( le.Input_pty_key = (TYPEOF(le.Input_pty_key))'','',':pty_key')
    #END
 
+    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
    #END
 
+    #IF( #TEXT(Input_orig_pty_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_pty_name = (TYPEOF(le.Input_orig_pty_name))'','',':orig_pty_name')
    #END
 
+    #IF( #TEXT(Input_orig_vessel_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_vessel_name = (TYPEOF(le.Input_orig_vessel_name))'','',':orig_vessel_name')
    #END
 
+    #IF( #TEXT(Input_country)='' )
      '' 
    #ELSE
        IF( le.Input_country = (TYPEOF(le.Input_country))'','',':country')
    #END
 
+    #IF( #TEXT(Input_name_type)='' )
      '' 
    #ELSE
        IF( le.Input_name_type = (TYPEOF(le.Input_name_type))'','',':name_type')
    #END
 
+    #IF( #TEXT(Input_addr_1)='' )
      '' 
    #ELSE
        IF( le.Input_addr_1 = (TYPEOF(le.Input_addr_1))'','',':addr_1')
    #END
 
+    #IF( #TEXT(Input_addr_2)='' )
      '' 
    #ELSE
        IF( le.Input_addr_2 = (TYPEOF(le.Input_addr_2))'','',':addr_2')
    #END
 
+    #IF( #TEXT(Input_addr_3)='' )
      '' 
    #ELSE
        IF( le.Input_addr_3 = (TYPEOF(le.Input_addr_3))'','',':addr_3')
    #END
 
+    #IF( #TEXT(Input_addr_4)='' )
      '' 
    #ELSE
        IF( le.Input_addr_4 = (TYPEOF(le.Input_addr_4))'','',':addr_4')
    #END
 
+    #IF( #TEXT(Input_addr_5)='' )
      '' 
    #ELSE
        IF( le.Input_addr_5 = (TYPEOF(le.Input_addr_5))'','',':addr_5')
    #END
 
+    #IF( #TEXT(Input_addr_6)='' )
      '' 
    #ELSE
        IF( le.Input_addr_6 = (TYPEOF(le.Input_addr_6))'','',':addr_6')
    #END
 
+    #IF( #TEXT(Input_addr_7)='' )
      '' 
    #ELSE
        IF( le.Input_addr_7 = (TYPEOF(le.Input_addr_7))'','',':addr_7')
    #END
 
+    #IF( #TEXT(Input_addr_8)='' )
      '' 
    #ELSE
        IF( le.Input_addr_8 = (TYPEOF(le.Input_addr_8))'','',':addr_8')
    #END
 
+    #IF( #TEXT(Input_addr_9)='' )
      '' 
    #ELSE
        IF( le.Input_addr_9 = (TYPEOF(le.Input_addr_9))'','',':addr_9')
    #END
 
+    #IF( #TEXT(Input_addr_10)='' )
      '' 
    #ELSE
        IF( le.Input_addr_10 = (TYPEOF(le.Input_addr_10))'','',':addr_10')
    #END
 
+    #IF( #TEXT(Input_remarks_1)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_1 = (TYPEOF(le.Input_remarks_1))'','',':remarks_1')
    #END
 
+    #IF( #TEXT(Input_remarks_2)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_2 = (TYPEOF(le.Input_remarks_2))'','',':remarks_2')
    #END
 
+    #IF( #TEXT(Input_remarks_3)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_3 = (TYPEOF(le.Input_remarks_3))'','',':remarks_3')
    #END
 
+    #IF( #TEXT(Input_remarks_4)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_4 = (TYPEOF(le.Input_remarks_4))'','',':remarks_4')
    #END
 
+    #IF( #TEXT(Input_remarks_5)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_5 = (TYPEOF(le.Input_remarks_5))'','',':remarks_5')
    #END
 
+    #IF( #TEXT(Input_remarks_6)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_6 = (TYPEOF(le.Input_remarks_6))'','',':remarks_6')
    #END
 
+    #IF( #TEXT(Input_remarks_7)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_7 = (TYPEOF(le.Input_remarks_7))'','',':remarks_7')
    #END
 
+    #IF( #TEXT(Input_remarks_8)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_8 = (TYPEOF(le.Input_remarks_8))'','',':remarks_8')
    #END
 
+    #IF( #TEXT(Input_remarks_9)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_9 = (TYPEOF(le.Input_remarks_9))'','',':remarks_9')
    #END
 
+    #IF( #TEXT(Input_remarks_10)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_10 = (TYPEOF(le.Input_remarks_10))'','',':remarks_10')
    #END
 
+    #IF( #TEXT(Input_remarks_11)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_11 = (TYPEOF(le.Input_remarks_11))'','',':remarks_11')
    #END
 
+    #IF( #TEXT(Input_remarks_12)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_12 = (TYPEOF(le.Input_remarks_12))'','',':remarks_12')
    #END
 
+    #IF( #TEXT(Input_remarks_13)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_13 = (TYPEOF(le.Input_remarks_13))'','',':remarks_13')
    #END
 
+    #IF( #TEXT(Input_remarks_14)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_14 = (TYPEOF(le.Input_remarks_14))'','',':remarks_14')
    #END
 
+    #IF( #TEXT(Input_remarks_15)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_15 = (TYPEOF(le.Input_remarks_15))'','',':remarks_15')
    #END
 
+    #IF( #TEXT(Input_remarks_16)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_16 = (TYPEOF(le.Input_remarks_16))'','',':remarks_16')
    #END
 
+    #IF( #TEXT(Input_remarks_17)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_17 = (TYPEOF(le.Input_remarks_17))'','',':remarks_17')
    #END
 
+    #IF( #TEXT(Input_remarks_18)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_18 = (TYPEOF(le.Input_remarks_18))'','',':remarks_18')
    #END
 
+    #IF( #TEXT(Input_remarks_19)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_19 = (TYPEOF(le.Input_remarks_19))'','',':remarks_19')
    #END
 
+    #IF( #TEXT(Input_remarks_20)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_20 = (TYPEOF(le.Input_remarks_20))'','',':remarks_20')
    #END
 
+    #IF( #TEXT(Input_remarks_21)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_21 = (TYPEOF(le.Input_remarks_21))'','',':remarks_21')
    #END
 
+    #IF( #TEXT(Input_remarks_22)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_22 = (TYPEOF(le.Input_remarks_22))'','',':remarks_22')
    #END
 
+    #IF( #TEXT(Input_remarks_23)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_23 = (TYPEOF(le.Input_remarks_23))'','',':remarks_23')
    #END
 
+    #IF( #TEXT(Input_remarks_24)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_24 = (TYPEOF(le.Input_remarks_24))'','',':remarks_24')
    #END
 
+    #IF( #TEXT(Input_remarks_25)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_25 = (TYPEOF(le.Input_remarks_25))'','',':remarks_25')
    #END
 
+    #IF( #TEXT(Input_remarks_26)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_26 = (TYPEOF(le.Input_remarks_26))'','',':remarks_26')
    #END
 
+    #IF( #TEXT(Input_remarks_27)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_27 = (TYPEOF(le.Input_remarks_27))'','',':remarks_27')
    #END
 
+    #IF( #TEXT(Input_remarks_28)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_28 = (TYPEOF(le.Input_remarks_28))'','',':remarks_28')
    #END
 
+    #IF( #TEXT(Input_remarks_29)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_29 = (TYPEOF(le.Input_remarks_29))'','',':remarks_29')
    #END
 
+    #IF( #TEXT(Input_remarks_30)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_30 = (TYPEOF(le.Input_remarks_30))'','',':remarks_30')
    #END
 
+    #IF( #TEXT(Input_cname)='' )
      '' 
    #ELSE
        IF( le.Input_cname = (TYPEOF(le.Input_cname))'','',':cname')
    #END
 
+    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (TYPEOF(le.Input_title))'','',':title')
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
 
+    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
    #END
 
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
 
+    #IF( #TEXT(Input_a_score)='' )
      '' 
    #ELSE
        IF( le.Input_a_score = (TYPEOF(le.Input_a_score))'','',':a_score')
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
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
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
 
+    #IF( #TEXT(Input_dpbc)='' )
      '' 
    #ELSE
        IF( le.Input_dpbc = (TYPEOF(le.Input_dpbc))'','',':dpbc')
    #END
 
+    #IF( #TEXT(Input_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_chk_digit = (TYPEOF(le.Input_chk_digit))'','',':chk_digit')
    #END
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_ace_fips_st = (TYPEOF(le.Input_ace_fips_st))'','',':ace_fips_st')
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
 
+    #IF( #TEXT(Input_date_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_first_seen = (TYPEOF(le.Input_date_first_seen))'','',':date_first_seen')
    #END
 
+    #IF( #TEXT(Input_date_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_last_seen = (TYPEOF(le.Input_date_last_seen))'','',':date_last_seen')
    #END
 
+    #IF( #TEXT(Input_date_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_date_vendor_first_reported = (TYPEOF(le.Input_date_vendor_first_reported))'','',':date_vendor_first_reported')
    #END
 
+    #IF( #TEXT(Input_date_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_date_vendor_last_reported = (TYPEOF(le.Input_date_vendor_last_reported))'','',':date_vendor_last_reported')
    #END
 
+    #IF( #TEXT(Input_entity_id)='' )
      '' 
    #ELSE
        IF( le.Input_entity_id = (TYPEOF(le.Input_entity_id))'','',':entity_id')
    #END
 
+    #IF( #TEXT(Input_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_name = (TYPEOF(le.Input_first_name))'','',':first_name')
    #END
 
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
    #END
 
+    #IF( #TEXT(Input_title_1)='' )
      '' 
    #ELSE
        IF( le.Input_title_1 = (TYPEOF(le.Input_title_1))'','',':title_1')
    #END
 
+    #IF( #TEXT(Input_title_2)='' )
      '' 
    #ELSE
        IF( le.Input_title_2 = (TYPEOF(le.Input_title_2))'','',':title_2')
    #END
 
+    #IF( #TEXT(Input_title_3)='' )
      '' 
    #ELSE
        IF( le.Input_title_3 = (TYPEOF(le.Input_title_3))'','',':title_3')
    #END
 
+    #IF( #TEXT(Input_title_4)='' )
      '' 
    #ELSE
        IF( le.Input_title_4 = (TYPEOF(le.Input_title_4))'','',':title_4')
    #END
 
+    #IF( #TEXT(Input_title_5)='' )
      '' 
    #ELSE
        IF( le.Input_title_5 = (TYPEOF(le.Input_title_5))'','',':title_5')
    #END
 
+    #IF( #TEXT(Input_title_6)='' )
      '' 
    #ELSE
        IF( le.Input_title_6 = (TYPEOF(le.Input_title_6))'','',':title_6')
    #END
 
+    #IF( #TEXT(Input_title_7)='' )
      '' 
    #ELSE
        IF( le.Input_title_7 = (TYPEOF(le.Input_title_7))'','',':title_7')
    #END
 
+    #IF( #TEXT(Input_title_8)='' )
      '' 
    #ELSE
        IF( le.Input_title_8 = (TYPEOF(le.Input_title_8))'','',':title_8')
    #END
 
+    #IF( #TEXT(Input_title_9)='' )
      '' 
    #ELSE
        IF( le.Input_title_9 = (TYPEOF(le.Input_title_9))'','',':title_9')
    #END
 
+    #IF( #TEXT(Input_title_10)='' )
      '' 
    #ELSE
        IF( le.Input_title_10 = (TYPEOF(le.Input_title_10))'','',':title_10')
    #END
 
+    #IF( #TEXT(Input_aka_id)='' )
      '' 
    #ELSE
        IF( le.Input_aka_id = (TYPEOF(le.Input_aka_id))'','',':aka_id')
    #END
 
+    #IF( #TEXT(Input_aka_type)='' )
      '' 
    #ELSE
        IF( le.Input_aka_type = (TYPEOF(le.Input_aka_type))'','',':aka_type')
    #END
 
+    #IF( #TEXT(Input_aka_category)='' )
      '' 
    #ELSE
        IF( le.Input_aka_category = (TYPEOF(le.Input_aka_category))'','',':aka_category')
    #END
 
+    #IF( #TEXT(Input_giv_designator)='' )
      '' 
    #ELSE
        IF( le.Input_giv_designator = (TYPEOF(le.Input_giv_designator))'','',':giv_designator')
    #END
 
+    #IF( #TEXT(Input_entity_type)='' )
      '' 
    #ELSE
        IF( le.Input_entity_type = (TYPEOF(le.Input_entity_type))'','',':entity_type')
    #END
 
+    #IF( #TEXT(Input_address_id)='' )
      '' 
    #ELSE
        IF( le.Input_address_id = (TYPEOF(le.Input_address_id))'','',':address_id')
    #END
 
+    #IF( #TEXT(Input_address_line_1)='' )
      '' 
    #ELSE
        IF( le.Input_address_line_1 = (TYPEOF(le.Input_address_line_1))'','',':address_line_1')
    #END
 
+    #IF( #TEXT(Input_address_line_2)='' )
      '' 
    #ELSE
        IF( le.Input_address_line_2 = (TYPEOF(le.Input_address_line_2))'','',':address_line_2')
    #END
 
+    #IF( #TEXT(Input_address_line_3)='' )
      '' 
    #ELSE
        IF( le.Input_address_line_3 = (TYPEOF(le.Input_address_line_3))'','',':address_line_3')
    #END
 
+    #IF( #TEXT(Input_address_city)='' )
      '' 
    #ELSE
        IF( le.Input_address_city = (TYPEOF(le.Input_address_city))'','',':address_city')
    #END
 
+    #IF( #TEXT(Input_address_state_province)='' )
      '' 
    #ELSE
        IF( le.Input_address_state_province = (TYPEOF(le.Input_address_state_province))'','',':address_state_province')
    #END
 
+    #IF( #TEXT(Input_address_postal_code)='' )
      '' 
    #ELSE
        IF( le.Input_address_postal_code = (TYPEOF(le.Input_address_postal_code))'','',':address_postal_code')
    #END
 
+    #IF( #TEXT(Input_address_country)='' )
      '' 
    #ELSE
        IF( le.Input_address_country = (TYPEOF(le.Input_address_country))'','',':address_country')
    #END
 
+    #IF( #TEXT(Input_remarks)='' )
      '' 
    #ELSE
        IF( le.Input_remarks = (TYPEOF(le.Input_remarks))'','',':remarks')
    #END
 
+    #IF( #TEXT(Input_call_sign)='' )
      '' 
    #ELSE
        IF( le.Input_call_sign = (TYPEOF(le.Input_call_sign))'','',':call_sign')
    #END
 
+    #IF( #TEXT(Input_vessel_type)='' )
      '' 
    #ELSE
        IF( le.Input_vessel_type = (TYPEOF(le.Input_vessel_type))'','',':vessel_type')
    #END
 
+    #IF( #TEXT(Input_tonnage)='' )
      '' 
    #ELSE
        IF( le.Input_tonnage = (TYPEOF(le.Input_tonnage))'','',':tonnage')
    #END
 
+    #IF( #TEXT(Input_gross_registered_tonnage)='' )
      '' 
    #ELSE
        IF( le.Input_gross_registered_tonnage = (TYPEOF(le.Input_gross_registered_tonnage))'','',':gross_registered_tonnage')
    #END
 
+    #IF( #TEXT(Input_vessel_flag)='' )
      '' 
    #ELSE
        IF( le.Input_vessel_flag = (TYPEOF(le.Input_vessel_flag))'','',':vessel_flag')
    #END
 
+    #IF( #TEXT(Input_vessel_owner)='' )
      '' 
    #ELSE
        IF( le.Input_vessel_owner = (TYPEOF(le.Input_vessel_owner))'','',':vessel_owner')
    #END
 
+    #IF( #TEXT(Input_sanctions_program_1)='' )
      '' 
    #ELSE
        IF( le.Input_sanctions_program_1 = (TYPEOF(le.Input_sanctions_program_1))'','',':sanctions_program_1')
    #END
 
+    #IF( #TEXT(Input_sanctions_program_2)='' )
      '' 
    #ELSE
        IF( le.Input_sanctions_program_2 = (TYPEOF(le.Input_sanctions_program_2))'','',':sanctions_program_2')
    #END
 
+    #IF( #TEXT(Input_sanctions_program_3)='' )
      '' 
    #ELSE
        IF( le.Input_sanctions_program_3 = (TYPEOF(le.Input_sanctions_program_3))'','',':sanctions_program_3')
    #END
 
+    #IF( #TEXT(Input_sanctions_program_4)='' )
      '' 
    #ELSE
        IF( le.Input_sanctions_program_4 = (TYPEOF(le.Input_sanctions_program_4))'','',':sanctions_program_4')
    #END
 
+    #IF( #TEXT(Input_sanctions_program_5)='' )
      '' 
    #ELSE
        IF( le.Input_sanctions_program_5 = (TYPEOF(le.Input_sanctions_program_5))'','',':sanctions_program_5')
    #END
 
+    #IF( #TEXT(Input_sanctions_program_6)='' )
      '' 
    #ELSE
        IF( le.Input_sanctions_program_6 = (TYPEOF(le.Input_sanctions_program_6))'','',':sanctions_program_6')
    #END
 
+    #IF( #TEXT(Input_sanctions_program_7)='' )
      '' 
    #ELSE
        IF( le.Input_sanctions_program_7 = (TYPEOF(le.Input_sanctions_program_7))'','',':sanctions_program_7')
    #END
 
+    #IF( #TEXT(Input_sanctions_program_8)='' )
      '' 
    #ELSE
        IF( le.Input_sanctions_program_8 = (TYPEOF(le.Input_sanctions_program_8))'','',':sanctions_program_8')
    #END
 
+    #IF( #TEXT(Input_sanctions_program_9)='' )
      '' 
    #ELSE
        IF( le.Input_sanctions_program_9 = (TYPEOF(le.Input_sanctions_program_9))'','',':sanctions_program_9')
    #END
 
+    #IF( #TEXT(Input_sanctions_program_10)='' )
      '' 
    #ELSE
        IF( le.Input_sanctions_program_10 = (TYPEOF(le.Input_sanctions_program_10))'','',':sanctions_program_10')
    #END
 
+    #IF( #TEXT(Input_passport_details)='' )
      '' 
    #ELSE
        IF( le.Input_passport_details = (TYPEOF(le.Input_passport_details))'','',':passport_details')
    #END
 
+    #IF( #TEXT(Input_ni_number_details)='' )
      '' 
    #ELSE
        IF( le.Input_ni_number_details = (TYPEOF(le.Input_ni_number_details))'','',':ni_number_details')
    #END
 
+    #IF( #TEXT(Input_id_id_1)='' )
      '' 
    #ELSE
        IF( le.Input_id_id_1 = (TYPEOF(le.Input_id_id_1))'','',':id_id_1')
    #END
 
+    #IF( #TEXT(Input_id_id_2)='' )
      '' 
    #ELSE
        IF( le.Input_id_id_2 = (TYPEOF(le.Input_id_id_2))'','',':id_id_2')
    #END
 
+    #IF( #TEXT(Input_id_id_3)='' )
      '' 
    #ELSE
        IF( le.Input_id_id_3 = (TYPEOF(le.Input_id_id_3))'','',':id_id_3')
    #END
 
+    #IF( #TEXT(Input_id_id_4)='' )
      '' 
    #ELSE
        IF( le.Input_id_id_4 = (TYPEOF(le.Input_id_id_4))'','',':id_id_4')
    #END
 
+    #IF( #TEXT(Input_id_id_5)='' )
      '' 
    #ELSE
        IF( le.Input_id_id_5 = (TYPEOF(le.Input_id_id_5))'','',':id_id_5')
    #END
 
+    #IF( #TEXT(Input_id_id_6)='' )
      '' 
    #ELSE
        IF( le.Input_id_id_6 = (TYPEOF(le.Input_id_id_6))'','',':id_id_6')
    #END
 
+    #IF( #TEXT(Input_id_id_7)='' )
      '' 
    #ELSE
        IF( le.Input_id_id_7 = (TYPEOF(le.Input_id_id_7))'','',':id_id_7')
    #END
 
+    #IF( #TEXT(Input_id_id_8)='' )
      '' 
    #ELSE
        IF( le.Input_id_id_8 = (TYPEOF(le.Input_id_id_8))'','',':id_id_8')
    #END
 
+    #IF( #TEXT(Input_id_id_9)='' )
      '' 
    #ELSE
        IF( le.Input_id_id_9 = (TYPEOF(le.Input_id_id_9))'','',':id_id_9')
    #END
 
+    #IF( #TEXT(Input_id_id_10)='' )
      '' 
    #ELSE
        IF( le.Input_id_id_10 = (TYPEOF(le.Input_id_id_10))'','',':id_id_10')
    #END
 
+    #IF( #TEXT(Input_id_type_1)='' )
      '' 
    #ELSE
        IF( le.Input_id_type_1 = (TYPEOF(le.Input_id_type_1))'','',':id_type_1')
    #END
 
+    #IF( #TEXT(Input_id_type_2)='' )
      '' 
    #ELSE
        IF( le.Input_id_type_2 = (TYPEOF(le.Input_id_type_2))'','',':id_type_2')
    #END
 
+    #IF( #TEXT(Input_id_type_3)='' )
      '' 
    #ELSE
        IF( le.Input_id_type_3 = (TYPEOF(le.Input_id_type_3))'','',':id_type_3')
    #END
 
+    #IF( #TEXT(Input_id_type_4)='' )
      '' 
    #ELSE
        IF( le.Input_id_type_4 = (TYPEOF(le.Input_id_type_4))'','',':id_type_4')
    #END
 
+    #IF( #TEXT(Input_id_type_5)='' )
      '' 
    #ELSE
        IF( le.Input_id_type_5 = (TYPEOF(le.Input_id_type_5))'','',':id_type_5')
    #END
 
+    #IF( #TEXT(Input_id_type_6)='' )
      '' 
    #ELSE
        IF( le.Input_id_type_6 = (TYPEOF(le.Input_id_type_6))'','',':id_type_6')
    #END
 
+    #IF( #TEXT(Input_id_type_7)='' )
      '' 
    #ELSE
        IF( le.Input_id_type_7 = (TYPEOF(le.Input_id_type_7))'','',':id_type_7')
    #END
 
+    #IF( #TEXT(Input_id_type_8)='' )
      '' 
    #ELSE
        IF( le.Input_id_type_8 = (TYPEOF(le.Input_id_type_8))'','',':id_type_8')
    #END
 
+    #IF( #TEXT(Input_id_type_9)='' )
      '' 
    #ELSE
        IF( le.Input_id_type_9 = (TYPEOF(le.Input_id_type_9))'','',':id_type_9')
    #END
 
+    #IF( #TEXT(Input_id_type_10)='' )
      '' 
    #ELSE
        IF( le.Input_id_type_10 = (TYPEOF(le.Input_id_type_10))'','',':id_type_10')
    #END
 
+    #IF( #TEXT(Input_id_number_1)='' )
      '' 
    #ELSE
        IF( le.Input_id_number_1 = (TYPEOF(le.Input_id_number_1))'','',':id_number_1')
    #END
 
+    #IF( #TEXT(Input_id_number_2)='' )
      '' 
    #ELSE
        IF( le.Input_id_number_2 = (TYPEOF(le.Input_id_number_2))'','',':id_number_2')
    #END
 
+    #IF( #TEXT(Input_id_number_3)='' )
      '' 
    #ELSE
        IF( le.Input_id_number_3 = (TYPEOF(le.Input_id_number_3))'','',':id_number_3')
    #END
 
+    #IF( #TEXT(Input_id_number_4)='' )
      '' 
    #ELSE
        IF( le.Input_id_number_4 = (TYPEOF(le.Input_id_number_4))'','',':id_number_4')
    #END
 
+    #IF( #TEXT(Input_id_number_5)='' )
      '' 
    #ELSE
        IF( le.Input_id_number_5 = (TYPEOF(le.Input_id_number_5))'','',':id_number_5')
    #END
 
+    #IF( #TEXT(Input_id_number_6)='' )
      '' 
    #ELSE
        IF( le.Input_id_number_6 = (TYPEOF(le.Input_id_number_6))'','',':id_number_6')
    #END
 
+    #IF( #TEXT(Input_id_number_7)='' )
      '' 
    #ELSE
        IF( le.Input_id_number_7 = (TYPEOF(le.Input_id_number_7))'','',':id_number_7')
    #END
 
+    #IF( #TEXT(Input_id_number_8)='' )
      '' 
    #ELSE
        IF( le.Input_id_number_8 = (TYPEOF(le.Input_id_number_8))'','',':id_number_8')
    #END
 
+    #IF( #TEXT(Input_id_number_9)='' )
      '' 
    #ELSE
        IF( le.Input_id_number_9 = (TYPEOF(le.Input_id_number_9))'','',':id_number_9')
    #END
 
+    #IF( #TEXT(Input_id_number_10)='' )
      '' 
    #ELSE
        IF( le.Input_id_number_10 = (TYPEOF(le.Input_id_number_10))'','',':id_number_10')
    #END
 
+    #IF( #TEXT(Input_id_country_1)='' )
      '' 
    #ELSE
        IF( le.Input_id_country_1 = (TYPEOF(le.Input_id_country_1))'','',':id_country_1')
    #END
 
+    #IF( #TEXT(Input_id_country_2)='' )
      '' 
    #ELSE
        IF( le.Input_id_country_2 = (TYPEOF(le.Input_id_country_2))'','',':id_country_2')
    #END
 
+    #IF( #TEXT(Input_id_country_3)='' )
      '' 
    #ELSE
        IF( le.Input_id_country_3 = (TYPEOF(le.Input_id_country_3))'','',':id_country_3')
    #END
 
+    #IF( #TEXT(Input_id_country_4)='' )
      '' 
    #ELSE
        IF( le.Input_id_country_4 = (TYPEOF(le.Input_id_country_4))'','',':id_country_4')
    #END
 
+    #IF( #TEXT(Input_id_country_5)='' )
      '' 
    #ELSE
        IF( le.Input_id_country_5 = (TYPEOF(le.Input_id_country_5))'','',':id_country_5')
    #END
 
+    #IF( #TEXT(Input_id_country_6)='' )
      '' 
    #ELSE
        IF( le.Input_id_country_6 = (TYPEOF(le.Input_id_country_6))'','',':id_country_6')
    #END
 
+    #IF( #TEXT(Input_id_country_7)='' )
      '' 
    #ELSE
        IF( le.Input_id_country_7 = (TYPEOF(le.Input_id_country_7))'','',':id_country_7')
    #END
 
+    #IF( #TEXT(Input_id_country_8)='' )
      '' 
    #ELSE
        IF( le.Input_id_country_8 = (TYPEOF(le.Input_id_country_8))'','',':id_country_8')
    #END
 
+    #IF( #TEXT(Input_id_country_9)='' )
      '' 
    #ELSE
        IF( le.Input_id_country_9 = (TYPEOF(le.Input_id_country_9))'','',':id_country_9')
    #END
 
+    #IF( #TEXT(Input_id_country_10)='' )
      '' 
    #ELSE
        IF( le.Input_id_country_10 = (TYPEOF(le.Input_id_country_10))'','',':id_country_10')
    #END
 
+    #IF( #TEXT(Input_id_issue_date_1)='' )
      '' 
    #ELSE
        IF( le.Input_id_issue_date_1 = (TYPEOF(le.Input_id_issue_date_1))'','',':id_issue_date_1')
    #END
 
+    #IF( #TEXT(Input_id_issue_date_2)='' )
      '' 
    #ELSE
        IF( le.Input_id_issue_date_2 = (TYPEOF(le.Input_id_issue_date_2))'','',':id_issue_date_2')
    #END
 
+    #IF( #TEXT(Input_id_issue_date_3)='' )
      '' 
    #ELSE
        IF( le.Input_id_issue_date_3 = (TYPEOF(le.Input_id_issue_date_3))'','',':id_issue_date_3')
    #END
 
+    #IF( #TEXT(Input_id_issue_date_4)='' )
      '' 
    #ELSE
        IF( le.Input_id_issue_date_4 = (TYPEOF(le.Input_id_issue_date_4))'','',':id_issue_date_4')
    #END
 
+    #IF( #TEXT(Input_id_issue_date_5)='' )
      '' 
    #ELSE
        IF( le.Input_id_issue_date_5 = (TYPEOF(le.Input_id_issue_date_5))'','',':id_issue_date_5')
    #END
 
+    #IF( #TEXT(Input_id_issue_date_6)='' )
      '' 
    #ELSE
        IF( le.Input_id_issue_date_6 = (TYPEOF(le.Input_id_issue_date_6))'','',':id_issue_date_6')
    #END
 
+    #IF( #TEXT(Input_id_issue_date_7)='' )
      '' 
    #ELSE
        IF( le.Input_id_issue_date_7 = (TYPEOF(le.Input_id_issue_date_7))'','',':id_issue_date_7')
    #END
 
+    #IF( #TEXT(Input_id_issue_date_8)='' )
      '' 
    #ELSE
        IF( le.Input_id_issue_date_8 = (TYPEOF(le.Input_id_issue_date_8))'','',':id_issue_date_8')
    #END
 
+    #IF( #TEXT(Input_id_issue_date_9)='' )
      '' 
    #ELSE
        IF( le.Input_id_issue_date_9 = (TYPEOF(le.Input_id_issue_date_9))'','',':id_issue_date_9')
    #END
 
+    #IF( #TEXT(Input_id_issue_date_10)='' )
      '' 
    #ELSE
        IF( le.Input_id_issue_date_10 = (TYPEOF(le.Input_id_issue_date_10))'','',':id_issue_date_10')
    #END
 
+    #IF( #TEXT(Input_id_expiration_date_1)='' )
      '' 
    #ELSE
        IF( le.Input_id_expiration_date_1 = (TYPEOF(le.Input_id_expiration_date_1))'','',':id_expiration_date_1')
    #END
 
+    #IF( #TEXT(Input_id_expiration_date_2)='' )
      '' 
    #ELSE
        IF( le.Input_id_expiration_date_2 = (TYPEOF(le.Input_id_expiration_date_2))'','',':id_expiration_date_2')
    #END
 
+    #IF( #TEXT(Input_id_expiration_date_3)='' )
      '' 
    #ELSE
        IF( le.Input_id_expiration_date_3 = (TYPEOF(le.Input_id_expiration_date_3))'','',':id_expiration_date_3')
    #END
 
+    #IF( #TEXT(Input_id_expiration_date_4)='' )
      '' 
    #ELSE
        IF( le.Input_id_expiration_date_4 = (TYPEOF(le.Input_id_expiration_date_4))'','',':id_expiration_date_4')
    #END
 
+    #IF( #TEXT(Input_id_expiration_date_5)='' )
      '' 
    #ELSE
        IF( le.Input_id_expiration_date_5 = (TYPEOF(le.Input_id_expiration_date_5))'','',':id_expiration_date_5')
    #END
 
+    #IF( #TEXT(Input_id_expiration_date_6)='' )
      '' 
    #ELSE
        IF( le.Input_id_expiration_date_6 = (TYPEOF(le.Input_id_expiration_date_6))'','',':id_expiration_date_6')
    #END
 
+    #IF( #TEXT(Input_id_expiration_date_7)='' )
      '' 
    #ELSE
        IF( le.Input_id_expiration_date_7 = (TYPEOF(le.Input_id_expiration_date_7))'','',':id_expiration_date_7')
    #END
 
+    #IF( #TEXT(Input_id_expiration_date_8)='' )
      '' 
    #ELSE
        IF( le.Input_id_expiration_date_8 = (TYPEOF(le.Input_id_expiration_date_8))'','',':id_expiration_date_8')
    #END
 
+    #IF( #TEXT(Input_id_expiration_date_9)='' )
      '' 
    #ELSE
        IF( le.Input_id_expiration_date_9 = (TYPEOF(le.Input_id_expiration_date_9))'','',':id_expiration_date_9')
    #END
 
+    #IF( #TEXT(Input_id_expiration_date_10)='' )
      '' 
    #ELSE
        IF( le.Input_id_expiration_date_10 = (TYPEOF(le.Input_id_expiration_date_10))'','',':id_expiration_date_10')
    #END
 
+    #IF( #TEXT(Input_nationality_id_1)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_id_1 = (TYPEOF(le.Input_nationality_id_1))'','',':nationality_id_1')
    #END
 
+    #IF( #TEXT(Input_nationality_id_2)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_id_2 = (TYPEOF(le.Input_nationality_id_2))'','',':nationality_id_2')
    #END
 
+    #IF( #TEXT(Input_nationality_id_3)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_id_3 = (TYPEOF(le.Input_nationality_id_3))'','',':nationality_id_3')
    #END
 
+    #IF( #TEXT(Input_nationality_id_4)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_id_4 = (TYPEOF(le.Input_nationality_id_4))'','',':nationality_id_4')
    #END
 
+    #IF( #TEXT(Input_nationality_id_5)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_id_5 = (TYPEOF(le.Input_nationality_id_5))'','',':nationality_id_5')
    #END
 
+    #IF( #TEXT(Input_nationality_id_6)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_id_6 = (TYPEOF(le.Input_nationality_id_6))'','',':nationality_id_6')
    #END
 
+    #IF( #TEXT(Input_nationality_id_7)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_id_7 = (TYPEOF(le.Input_nationality_id_7))'','',':nationality_id_7')
    #END
 
+    #IF( #TEXT(Input_nationality_id_8)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_id_8 = (TYPEOF(le.Input_nationality_id_8))'','',':nationality_id_8')
    #END
 
+    #IF( #TEXT(Input_nationality_id_9)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_id_9 = (TYPEOF(le.Input_nationality_id_9))'','',':nationality_id_9')
    #END
 
+    #IF( #TEXT(Input_nationality_id_10)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_id_10 = (TYPEOF(le.Input_nationality_id_10))'','',':nationality_id_10')
    #END
 
+    #IF( #TEXT(Input_nationality_1)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_1 = (TYPEOF(le.Input_nationality_1))'','',':nationality_1')
    #END
 
+    #IF( #TEXT(Input_nationality_2)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_2 = (TYPEOF(le.Input_nationality_2))'','',':nationality_2')
    #END
 
+    #IF( #TEXT(Input_nationality_3)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_3 = (TYPEOF(le.Input_nationality_3))'','',':nationality_3')
    #END
 
+    #IF( #TEXT(Input_nationality_4)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_4 = (TYPEOF(le.Input_nationality_4))'','',':nationality_4')
    #END
 
+    #IF( #TEXT(Input_nationality_5)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_5 = (TYPEOF(le.Input_nationality_5))'','',':nationality_5')
    #END
 
+    #IF( #TEXT(Input_nationality_6)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_6 = (TYPEOF(le.Input_nationality_6))'','',':nationality_6')
    #END
 
+    #IF( #TEXT(Input_nationality_7)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_7 = (TYPEOF(le.Input_nationality_7))'','',':nationality_7')
    #END
 
+    #IF( #TEXT(Input_nationality_8)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_8 = (TYPEOF(le.Input_nationality_8))'','',':nationality_8')
    #END
 
+    #IF( #TEXT(Input_nationality_9)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_9 = (TYPEOF(le.Input_nationality_9))'','',':nationality_9')
    #END
 
+    #IF( #TEXT(Input_nationality_10)='' )
      '' 
    #ELSE
        IF( le.Input_nationality_10 = (TYPEOF(le.Input_nationality_10))'','',':nationality_10')
    #END
 
+    #IF( #TEXT(Input_primary_nationality_flag_1)='' )
      '' 
    #ELSE
        IF( le.Input_primary_nationality_flag_1 = (TYPEOF(le.Input_primary_nationality_flag_1))'','',':primary_nationality_flag_1')
    #END
 
+    #IF( #TEXT(Input_primary_nationality_flag_2)='' )
      '' 
    #ELSE
        IF( le.Input_primary_nationality_flag_2 = (TYPEOF(le.Input_primary_nationality_flag_2))'','',':primary_nationality_flag_2')
    #END
 
+    #IF( #TEXT(Input_primary_nationality_flag_3)='' )
      '' 
    #ELSE
        IF( le.Input_primary_nationality_flag_3 = (TYPEOF(le.Input_primary_nationality_flag_3))'','',':primary_nationality_flag_3')
    #END
 
+    #IF( #TEXT(Input_primary_nationality_flag_4)='' )
      '' 
    #ELSE
        IF( le.Input_primary_nationality_flag_4 = (TYPEOF(le.Input_primary_nationality_flag_4))'','',':primary_nationality_flag_4')
    #END
 
+    #IF( #TEXT(Input_primary_nationality_flag_5)='' )
      '' 
    #ELSE
        IF( le.Input_primary_nationality_flag_5 = (TYPEOF(le.Input_primary_nationality_flag_5))'','',':primary_nationality_flag_5')
    #END
 
+    #IF( #TEXT(Input_primary_nationality_flag_6)='' )
      '' 
    #ELSE
        IF( le.Input_primary_nationality_flag_6 = (TYPEOF(le.Input_primary_nationality_flag_6))'','',':primary_nationality_flag_6')
    #END
 
+    #IF( #TEXT(Input_primary_nationality_flag_7)='' )
      '' 
    #ELSE
        IF( le.Input_primary_nationality_flag_7 = (TYPEOF(le.Input_primary_nationality_flag_7))'','',':primary_nationality_flag_7')
    #END
 
+    #IF( #TEXT(Input_primary_nationality_flag_8)='' )
      '' 
    #ELSE
        IF( le.Input_primary_nationality_flag_8 = (TYPEOF(le.Input_primary_nationality_flag_8))'','',':primary_nationality_flag_8')
    #END
 
+    #IF( #TEXT(Input_primary_nationality_flag_9)='' )
      '' 
    #ELSE
        IF( le.Input_primary_nationality_flag_9 = (TYPEOF(le.Input_primary_nationality_flag_9))'','',':primary_nationality_flag_9')
    #END
 
+    #IF( #TEXT(Input_primary_nationality_flag_10)='' )
      '' 
    #ELSE
        IF( le.Input_primary_nationality_flag_10 = (TYPEOF(le.Input_primary_nationality_flag_10))'','',':primary_nationality_flag_10')
    #END
 
+    #IF( #TEXT(Input_citizenship_id_1)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_id_1 = (TYPEOF(le.Input_citizenship_id_1))'','',':citizenship_id_1')
    #END
 
+    #IF( #TEXT(Input_citizenship_id_2)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_id_2 = (TYPEOF(le.Input_citizenship_id_2))'','',':citizenship_id_2')
    #END
 
+    #IF( #TEXT(Input_citizenship_id_3)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_id_3 = (TYPEOF(le.Input_citizenship_id_3))'','',':citizenship_id_3')
    #END
 
+    #IF( #TEXT(Input_citizenship_id_4)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_id_4 = (TYPEOF(le.Input_citizenship_id_4))'','',':citizenship_id_4')
    #END
 
+    #IF( #TEXT(Input_citizenship_id_5)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_id_5 = (TYPEOF(le.Input_citizenship_id_5))'','',':citizenship_id_5')
    #END
 
+    #IF( #TEXT(Input_citizenship_id_6)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_id_6 = (TYPEOF(le.Input_citizenship_id_6))'','',':citizenship_id_6')
    #END
 
+    #IF( #TEXT(Input_citizenship_id_7)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_id_7 = (TYPEOF(le.Input_citizenship_id_7))'','',':citizenship_id_7')
    #END
 
+    #IF( #TEXT(Input_citizenship_id_8)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_id_8 = (TYPEOF(le.Input_citizenship_id_8))'','',':citizenship_id_8')
    #END
 
+    #IF( #TEXT(Input_citizenship_id_9)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_id_9 = (TYPEOF(le.Input_citizenship_id_9))'','',':citizenship_id_9')
    #END
 
+    #IF( #TEXT(Input_citizenship_id_10)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_id_10 = (TYPEOF(le.Input_citizenship_id_10))'','',':citizenship_id_10')
    #END
 
+    #IF( #TEXT(Input_citizenship_1)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_1 = (TYPEOF(le.Input_citizenship_1))'','',':citizenship_1')
    #END
 
+    #IF( #TEXT(Input_citizenship_2)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_2 = (TYPEOF(le.Input_citizenship_2))'','',':citizenship_2')
    #END
 
+    #IF( #TEXT(Input_citizenship_3)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_3 = (TYPEOF(le.Input_citizenship_3))'','',':citizenship_3')
    #END
 
+    #IF( #TEXT(Input_citizenship_4)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_4 = (TYPEOF(le.Input_citizenship_4))'','',':citizenship_4')
    #END
 
+    #IF( #TEXT(Input_citizenship_5)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_5 = (TYPEOF(le.Input_citizenship_5))'','',':citizenship_5')
    #END
 
+    #IF( #TEXT(Input_citizenship_6)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_6 = (TYPEOF(le.Input_citizenship_6))'','',':citizenship_6')
    #END
 
+    #IF( #TEXT(Input_citizenship_7)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_7 = (TYPEOF(le.Input_citizenship_7))'','',':citizenship_7')
    #END
 
+    #IF( #TEXT(Input_citizenship_8)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_8 = (TYPEOF(le.Input_citizenship_8))'','',':citizenship_8')
    #END
 
+    #IF( #TEXT(Input_citizenship_9)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_9 = (TYPEOF(le.Input_citizenship_9))'','',':citizenship_9')
    #END
 
+    #IF( #TEXT(Input_citizenship_10)='' )
      '' 
    #ELSE
        IF( le.Input_citizenship_10 = (TYPEOF(le.Input_citizenship_10))'','',':citizenship_10')
    #END
 
+    #IF( #TEXT(Input_primary_citizenship_flag_1)='' )
      '' 
    #ELSE
        IF( le.Input_primary_citizenship_flag_1 = (TYPEOF(le.Input_primary_citizenship_flag_1))'','',':primary_citizenship_flag_1')
    #END
 
+    #IF( #TEXT(Input_primary_citizenship_flag_2)='' )
      '' 
    #ELSE
        IF( le.Input_primary_citizenship_flag_2 = (TYPEOF(le.Input_primary_citizenship_flag_2))'','',':primary_citizenship_flag_2')
    #END
 
+    #IF( #TEXT(Input_primary_citizenship_flag_3)='' )
      '' 
    #ELSE
        IF( le.Input_primary_citizenship_flag_3 = (TYPEOF(le.Input_primary_citizenship_flag_3))'','',':primary_citizenship_flag_3')
    #END
 
+    #IF( #TEXT(Input_primary_citizenship_flag_4)='' )
      '' 
    #ELSE
        IF( le.Input_primary_citizenship_flag_4 = (TYPEOF(le.Input_primary_citizenship_flag_4))'','',':primary_citizenship_flag_4')
    #END
 
+    #IF( #TEXT(Input_primary_citizenship_flag_5)='' )
      '' 
    #ELSE
        IF( le.Input_primary_citizenship_flag_5 = (TYPEOF(le.Input_primary_citizenship_flag_5))'','',':primary_citizenship_flag_5')
    #END
 
+    #IF( #TEXT(Input_primary_citizenship_flag_6)='' )
      '' 
    #ELSE
        IF( le.Input_primary_citizenship_flag_6 = (TYPEOF(le.Input_primary_citizenship_flag_6))'','',':primary_citizenship_flag_6')
    #END
 
+    #IF( #TEXT(Input_primary_citizenship_flag_7)='' )
      '' 
    #ELSE
        IF( le.Input_primary_citizenship_flag_7 = (TYPEOF(le.Input_primary_citizenship_flag_7))'','',':primary_citizenship_flag_7')
    #END
 
+    #IF( #TEXT(Input_primary_citizenship_flag_8)='' )
      '' 
    #ELSE
        IF( le.Input_primary_citizenship_flag_8 = (TYPEOF(le.Input_primary_citizenship_flag_8))'','',':primary_citizenship_flag_8')
    #END
 
+    #IF( #TEXT(Input_primary_citizenship_flag_9)='' )
      '' 
    #ELSE
        IF( le.Input_primary_citizenship_flag_9 = (TYPEOF(le.Input_primary_citizenship_flag_9))'','',':primary_citizenship_flag_9')
    #END
 
+    #IF( #TEXT(Input_primary_citizenship_flag_10)='' )
      '' 
    #ELSE
        IF( le.Input_primary_citizenship_flag_10 = (TYPEOF(le.Input_primary_citizenship_flag_10))'','',':primary_citizenship_flag_10')
    #END
 
+    #IF( #TEXT(Input_dob_id_1)='' )
      '' 
    #ELSE
        IF( le.Input_dob_id_1 = (TYPEOF(le.Input_dob_id_1))'','',':dob_id_1')
    #END
 
+    #IF( #TEXT(Input_dob_id_2)='' )
      '' 
    #ELSE
        IF( le.Input_dob_id_2 = (TYPEOF(le.Input_dob_id_2))'','',':dob_id_2')
    #END
 
+    #IF( #TEXT(Input_dob_id_3)='' )
      '' 
    #ELSE
        IF( le.Input_dob_id_3 = (TYPEOF(le.Input_dob_id_3))'','',':dob_id_3')
    #END
 
+    #IF( #TEXT(Input_dob_id_4)='' )
      '' 
    #ELSE
        IF( le.Input_dob_id_4 = (TYPEOF(le.Input_dob_id_4))'','',':dob_id_4')
    #END
 
+    #IF( #TEXT(Input_dob_id_5)='' )
      '' 
    #ELSE
        IF( le.Input_dob_id_5 = (TYPEOF(le.Input_dob_id_5))'','',':dob_id_5')
    #END
 
+    #IF( #TEXT(Input_dob_id_6)='' )
      '' 
    #ELSE
        IF( le.Input_dob_id_6 = (TYPEOF(le.Input_dob_id_6))'','',':dob_id_6')
    #END
 
+    #IF( #TEXT(Input_dob_id_7)='' )
      '' 
    #ELSE
        IF( le.Input_dob_id_7 = (TYPEOF(le.Input_dob_id_7))'','',':dob_id_7')
    #END
 
+    #IF( #TEXT(Input_dob_id_8)='' )
      '' 
    #ELSE
        IF( le.Input_dob_id_8 = (TYPEOF(le.Input_dob_id_8))'','',':dob_id_8')
    #END
 
+    #IF( #TEXT(Input_dob_id_9)='' )
      '' 
    #ELSE
        IF( le.Input_dob_id_9 = (TYPEOF(le.Input_dob_id_9))'','',':dob_id_9')
    #END
 
+    #IF( #TEXT(Input_dob_id_10)='' )
      '' 
    #ELSE
        IF( le.Input_dob_id_10 = (TYPEOF(le.Input_dob_id_10))'','',':dob_id_10')
    #END
 
+    #IF( #TEXT(Input_dob_1)='' )
      '' 
    #ELSE
        IF( le.Input_dob_1 = (TYPEOF(le.Input_dob_1))'','',':dob_1')
    #END
 
+    #IF( #TEXT(Input_dob_2)='' )
      '' 
    #ELSE
        IF( le.Input_dob_2 = (TYPEOF(le.Input_dob_2))'','',':dob_2')
    #END
 
+    #IF( #TEXT(Input_dob_3)='' )
      '' 
    #ELSE
        IF( le.Input_dob_3 = (TYPEOF(le.Input_dob_3))'','',':dob_3')
    #END
 
+    #IF( #TEXT(Input_dob_4)='' )
      '' 
    #ELSE
        IF( le.Input_dob_4 = (TYPEOF(le.Input_dob_4))'','',':dob_4')
    #END
 
+    #IF( #TEXT(Input_dob_5)='' )
      '' 
    #ELSE
        IF( le.Input_dob_5 = (TYPEOF(le.Input_dob_5))'','',':dob_5')
    #END
 
+    #IF( #TEXT(Input_dob_6)='' )
      '' 
    #ELSE
        IF( le.Input_dob_6 = (TYPEOF(le.Input_dob_6))'','',':dob_6')
    #END
 
+    #IF( #TEXT(Input_dob_7)='' )
      '' 
    #ELSE
        IF( le.Input_dob_7 = (TYPEOF(le.Input_dob_7))'','',':dob_7')
    #END
 
+    #IF( #TEXT(Input_dob_8)='' )
      '' 
    #ELSE
        IF( le.Input_dob_8 = (TYPEOF(le.Input_dob_8))'','',':dob_8')
    #END
 
+    #IF( #TEXT(Input_dob_9)='' )
      '' 
    #ELSE
        IF( le.Input_dob_9 = (TYPEOF(le.Input_dob_9))'','',':dob_9')
    #END
 
+    #IF( #TEXT(Input_dob_10)='' )
      '' 
    #ELSE
        IF( le.Input_dob_10 = (TYPEOF(le.Input_dob_10))'','',':dob_10')
    #END
 
+    #IF( #TEXT(Input_primary_dob_flag_1)='' )
      '' 
    #ELSE
        IF( le.Input_primary_dob_flag_1 = (TYPEOF(le.Input_primary_dob_flag_1))'','',':primary_dob_flag_1')
    #END
 
+    #IF( #TEXT(Input_primary_dob_flag_2)='' )
      '' 
    #ELSE
        IF( le.Input_primary_dob_flag_2 = (TYPEOF(le.Input_primary_dob_flag_2))'','',':primary_dob_flag_2')
    #END
 
+    #IF( #TEXT(Input_primary_dob_flag_3)='' )
      '' 
    #ELSE
        IF( le.Input_primary_dob_flag_3 = (TYPEOF(le.Input_primary_dob_flag_3))'','',':primary_dob_flag_3')
    #END
 
+    #IF( #TEXT(Input_primary_dob_flag_4)='' )
      '' 
    #ELSE
        IF( le.Input_primary_dob_flag_4 = (TYPEOF(le.Input_primary_dob_flag_4))'','',':primary_dob_flag_4')
    #END
 
+    #IF( #TEXT(Input_primary_dob_flag_5)='' )
      '' 
    #ELSE
        IF( le.Input_primary_dob_flag_5 = (TYPEOF(le.Input_primary_dob_flag_5))'','',':primary_dob_flag_5')
    #END
 
+    #IF( #TEXT(Input_primary_dob_flag_6)='' )
      '' 
    #ELSE
        IF( le.Input_primary_dob_flag_6 = (TYPEOF(le.Input_primary_dob_flag_6))'','',':primary_dob_flag_6')
    #END
 
+    #IF( #TEXT(Input_primary_dob_flag_7)='' )
      '' 
    #ELSE
        IF( le.Input_primary_dob_flag_7 = (TYPEOF(le.Input_primary_dob_flag_7))'','',':primary_dob_flag_7')
    #END
 
+    #IF( #TEXT(Input_primary_dob_flag_8)='' )
      '' 
    #ELSE
        IF( le.Input_primary_dob_flag_8 = (TYPEOF(le.Input_primary_dob_flag_8))'','',':primary_dob_flag_8')
    #END
 
+    #IF( #TEXT(Input_primary_dob_flag_9)='' )
      '' 
    #ELSE
        IF( le.Input_primary_dob_flag_9 = (TYPEOF(le.Input_primary_dob_flag_9))'','',':primary_dob_flag_9')
    #END
 
+    #IF( #TEXT(Input_primary_dob_flag_10)='' )
      '' 
    #ELSE
        IF( le.Input_primary_dob_flag_10 = (TYPEOF(le.Input_primary_dob_flag_10))'','',':primary_dob_flag_10')
    #END
 
+    #IF( #TEXT(Input_pob_id_1)='' )
      '' 
    #ELSE
        IF( le.Input_pob_id_1 = (TYPEOF(le.Input_pob_id_1))'','',':pob_id_1')
    #END
 
+    #IF( #TEXT(Input_pob_id_2)='' )
      '' 
    #ELSE
        IF( le.Input_pob_id_2 = (TYPEOF(le.Input_pob_id_2))'','',':pob_id_2')
    #END
 
+    #IF( #TEXT(Input_pob_id_3)='' )
      '' 
    #ELSE
        IF( le.Input_pob_id_3 = (TYPEOF(le.Input_pob_id_3))'','',':pob_id_3')
    #END
 
+    #IF( #TEXT(Input_pob_id_4)='' )
      '' 
    #ELSE
        IF( le.Input_pob_id_4 = (TYPEOF(le.Input_pob_id_4))'','',':pob_id_4')
    #END
 
+    #IF( #TEXT(Input_pob_id_5)='' )
      '' 
    #ELSE
        IF( le.Input_pob_id_5 = (TYPEOF(le.Input_pob_id_5))'','',':pob_id_5')
    #END
 
+    #IF( #TEXT(Input_pob_id_6)='' )
      '' 
    #ELSE
        IF( le.Input_pob_id_6 = (TYPEOF(le.Input_pob_id_6))'','',':pob_id_6')
    #END
 
+    #IF( #TEXT(Input_pob_id_7)='' )
      '' 
    #ELSE
        IF( le.Input_pob_id_7 = (TYPEOF(le.Input_pob_id_7))'','',':pob_id_7')
    #END
 
+    #IF( #TEXT(Input_pob_id_8)='' )
      '' 
    #ELSE
        IF( le.Input_pob_id_8 = (TYPEOF(le.Input_pob_id_8))'','',':pob_id_8')
    #END
 
+    #IF( #TEXT(Input_pob_id_9)='' )
      '' 
    #ELSE
        IF( le.Input_pob_id_9 = (TYPEOF(le.Input_pob_id_9))'','',':pob_id_9')
    #END
 
+    #IF( #TEXT(Input_pob_id_10)='' )
      '' 
    #ELSE
        IF( le.Input_pob_id_10 = (TYPEOF(le.Input_pob_id_10))'','',':pob_id_10')
    #END
 
+    #IF( #TEXT(Input_pob_1)='' )
      '' 
    #ELSE
        IF( le.Input_pob_1 = (TYPEOF(le.Input_pob_1))'','',':pob_1')
    #END
 
+    #IF( #TEXT(Input_pob_2)='' )
      '' 
    #ELSE
        IF( le.Input_pob_2 = (TYPEOF(le.Input_pob_2))'','',':pob_2')
    #END
 
+    #IF( #TEXT(Input_pob_3)='' )
      '' 
    #ELSE
        IF( le.Input_pob_3 = (TYPEOF(le.Input_pob_3))'','',':pob_3')
    #END
 
+    #IF( #TEXT(Input_pob_4)='' )
      '' 
    #ELSE
        IF( le.Input_pob_4 = (TYPEOF(le.Input_pob_4))'','',':pob_4')
    #END
 
+    #IF( #TEXT(Input_pob_5)='' )
      '' 
    #ELSE
        IF( le.Input_pob_5 = (TYPEOF(le.Input_pob_5))'','',':pob_5')
    #END
 
+    #IF( #TEXT(Input_pob_6)='' )
      '' 
    #ELSE
        IF( le.Input_pob_6 = (TYPEOF(le.Input_pob_6))'','',':pob_6')
    #END
 
+    #IF( #TEXT(Input_pob_7)='' )
      '' 
    #ELSE
        IF( le.Input_pob_7 = (TYPEOF(le.Input_pob_7))'','',':pob_7')
    #END
 
+    #IF( #TEXT(Input_pob_8)='' )
      '' 
    #ELSE
        IF( le.Input_pob_8 = (TYPEOF(le.Input_pob_8))'','',':pob_8')
    #END
 
+    #IF( #TEXT(Input_pob_9)='' )
      '' 
    #ELSE
        IF( le.Input_pob_9 = (TYPEOF(le.Input_pob_9))'','',':pob_9')
    #END
 
+    #IF( #TEXT(Input_pob_10)='' )
      '' 
    #ELSE
        IF( le.Input_pob_10 = (TYPEOF(le.Input_pob_10))'','',':pob_10')
    #END
 
+    #IF( #TEXT(Input_country_of_birth_1)='' )
      '' 
    #ELSE
        IF( le.Input_country_of_birth_1 = (TYPEOF(le.Input_country_of_birth_1))'','',':country_of_birth_1')
    #END
 
+    #IF( #TEXT(Input_country_of_birth_2)='' )
      '' 
    #ELSE
        IF( le.Input_country_of_birth_2 = (TYPEOF(le.Input_country_of_birth_2))'','',':country_of_birth_2')
    #END
 
+    #IF( #TEXT(Input_country_of_birth_3)='' )
      '' 
    #ELSE
        IF( le.Input_country_of_birth_3 = (TYPEOF(le.Input_country_of_birth_3))'','',':country_of_birth_3')
    #END
 
+    #IF( #TEXT(Input_country_of_birth_4)='' )
      '' 
    #ELSE
        IF( le.Input_country_of_birth_4 = (TYPEOF(le.Input_country_of_birth_4))'','',':country_of_birth_4')
    #END
 
+    #IF( #TEXT(Input_country_of_birth_5)='' )
      '' 
    #ELSE
        IF( le.Input_country_of_birth_5 = (TYPEOF(le.Input_country_of_birth_5))'','',':country_of_birth_5')
    #END
 
+    #IF( #TEXT(Input_country_of_birth_6)='' )
      '' 
    #ELSE
        IF( le.Input_country_of_birth_6 = (TYPEOF(le.Input_country_of_birth_6))'','',':country_of_birth_6')
    #END
 
+    #IF( #TEXT(Input_country_of_birth_7)='' )
      '' 
    #ELSE
        IF( le.Input_country_of_birth_7 = (TYPEOF(le.Input_country_of_birth_7))'','',':country_of_birth_7')
    #END
 
+    #IF( #TEXT(Input_country_of_birth_8)='' )
      '' 
    #ELSE
        IF( le.Input_country_of_birth_8 = (TYPEOF(le.Input_country_of_birth_8))'','',':country_of_birth_8')
    #END
 
+    #IF( #TEXT(Input_country_of_birth_9)='' )
      '' 
    #ELSE
        IF( le.Input_country_of_birth_9 = (TYPEOF(le.Input_country_of_birth_9))'','',':country_of_birth_9')
    #END
 
+    #IF( #TEXT(Input_country_of_birth_10)='' )
      '' 
    #ELSE
        IF( le.Input_country_of_birth_10 = (TYPEOF(le.Input_country_of_birth_10))'','',':country_of_birth_10')
    #END
 
+    #IF( #TEXT(Input_primary_pob_flag_1)='' )
      '' 
    #ELSE
        IF( le.Input_primary_pob_flag_1 = (TYPEOF(le.Input_primary_pob_flag_1))'','',':primary_pob_flag_1')
    #END
 
+    #IF( #TEXT(Input_primary_pob_flag_2)='' )
      '' 
    #ELSE
        IF( le.Input_primary_pob_flag_2 = (TYPEOF(le.Input_primary_pob_flag_2))'','',':primary_pob_flag_2')
    #END
 
+    #IF( #TEXT(Input_primary_pob_flag_3)='' )
      '' 
    #ELSE
        IF( le.Input_primary_pob_flag_3 = (TYPEOF(le.Input_primary_pob_flag_3))'','',':primary_pob_flag_3')
    #END
 
+    #IF( #TEXT(Input_primary_pob_flag_4)='' )
      '' 
    #ELSE
        IF( le.Input_primary_pob_flag_4 = (TYPEOF(le.Input_primary_pob_flag_4))'','',':primary_pob_flag_4')
    #END
 
+    #IF( #TEXT(Input_primary_pob_flag_5)='' )
      '' 
    #ELSE
        IF( le.Input_primary_pob_flag_5 = (TYPEOF(le.Input_primary_pob_flag_5))'','',':primary_pob_flag_5')
    #END
 
+    #IF( #TEXT(Input_primary_pob_flag_6)='' )
      '' 
    #ELSE
        IF( le.Input_primary_pob_flag_6 = (TYPEOF(le.Input_primary_pob_flag_6))'','',':primary_pob_flag_6')
    #END
 
+    #IF( #TEXT(Input_primary_pob_flag_7)='' )
      '' 
    #ELSE
        IF( le.Input_primary_pob_flag_7 = (TYPEOF(le.Input_primary_pob_flag_7))'','',':primary_pob_flag_7')
    #END
 
+    #IF( #TEXT(Input_primary_pob_flag_8)='' )
      '' 
    #ELSE
        IF( le.Input_primary_pob_flag_8 = (TYPEOF(le.Input_primary_pob_flag_8))'','',':primary_pob_flag_8')
    #END
 
+    #IF( #TEXT(Input_primary_pob_flag_9)='' )
      '' 
    #ELSE
        IF( le.Input_primary_pob_flag_9 = (TYPEOF(le.Input_primary_pob_flag_9))'','',':primary_pob_flag_9')
    #END
 
+    #IF( #TEXT(Input_primary_pob_flag_10)='' )
      '' 
    #ELSE
        IF( le.Input_primary_pob_flag_10 = (TYPEOF(le.Input_primary_pob_flag_10))'','',':primary_pob_flag_10')
    #END
 
+    #IF( #TEXT(Input_language_1)='' )
      '' 
    #ELSE
        IF( le.Input_language_1 = (TYPEOF(le.Input_language_1))'','',':language_1')
    #END
 
+    #IF( #TEXT(Input_language_2)='' )
      '' 
    #ELSE
        IF( le.Input_language_2 = (TYPEOF(le.Input_language_2))'','',':language_2')
    #END
 
+    #IF( #TEXT(Input_language_3)='' )
      '' 
    #ELSE
        IF( le.Input_language_3 = (TYPEOF(le.Input_language_3))'','',':language_3')
    #END
 
+    #IF( #TEXT(Input_language_4)='' )
      '' 
    #ELSE
        IF( le.Input_language_4 = (TYPEOF(le.Input_language_4))'','',':language_4')
    #END
 
+    #IF( #TEXT(Input_language_5)='' )
      '' 
    #ELSE
        IF( le.Input_language_5 = (TYPEOF(le.Input_language_5))'','',':language_5')
    #END
 
+    #IF( #TEXT(Input_language_6)='' )
      '' 
    #ELSE
        IF( le.Input_language_6 = (TYPEOF(le.Input_language_6))'','',':language_6')
    #END
 
+    #IF( #TEXT(Input_language_7)='' )
      '' 
    #ELSE
        IF( le.Input_language_7 = (TYPEOF(le.Input_language_7))'','',':language_7')
    #END
 
+    #IF( #TEXT(Input_language_8)='' )
      '' 
    #ELSE
        IF( le.Input_language_8 = (TYPEOF(le.Input_language_8))'','',':language_8')
    #END
 
+    #IF( #TEXT(Input_language_9)='' )
      '' 
    #ELSE
        IF( le.Input_language_9 = (TYPEOF(le.Input_language_9))'','',':language_9')
    #END
 
+    #IF( #TEXT(Input_language_10)='' )
      '' 
    #ELSE
        IF( le.Input_language_10 = (TYPEOF(le.Input_language_10))'','',':language_10')
    #END
 
+    #IF( #TEXT(Input_membership_1)='' )
      '' 
    #ELSE
        IF( le.Input_membership_1 = (TYPEOF(le.Input_membership_1))'','',':membership_1')
    #END
 
+    #IF( #TEXT(Input_membership_2)='' )
      '' 
    #ELSE
        IF( le.Input_membership_2 = (TYPEOF(le.Input_membership_2))'','',':membership_2')
    #END
 
+    #IF( #TEXT(Input_membership_3)='' )
      '' 
    #ELSE
        IF( le.Input_membership_3 = (TYPEOF(le.Input_membership_3))'','',':membership_3')
    #END
 
+    #IF( #TEXT(Input_membership_4)='' )
      '' 
    #ELSE
        IF( le.Input_membership_4 = (TYPEOF(le.Input_membership_4))'','',':membership_4')
    #END
 
+    #IF( #TEXT(Input_membership_5)='' )
      '' 
    #ELSE
        IF( le.Input_membership_5 = (TYPEOF(le.Input_membership_5))'','',':membership_5')
    #END
 
+    #IF( #TEXT(Input_membership_6)='' )
      '' 
    #ELSE
        IF( le.Input_membership_6 = (TYPEOF(le.Input_membership_6))'','',':membership_6')
    #END
 
+    #IF( #TEXT(Input_membership_7)='' )
      '' 
    #ELSE
        IF( le.Input_membership_7 = (TYPEOF(le.Input_membership_7))'','',':membership_7')
    #END
 
+    #IF( #TEXT(Input_membership_8)='' )
      '' 
    #ELSE
        IF( le.Input_membership_8 = (TYPEOF(le.Input_membership_8))'','',':membership_8')
    #END
 
+    #IF( #TEXT(Input_membership_9)='' )
      '' 
    #ELSE
        IF( le.Input_membership_9 = (TYPEOF(le.Input_membership_9))'','',':membership_9')
    #END
 
+    #IF( #TEXT(Input_membership_10)='' )
      '' 
    #ELSE
        IF( le.Input_membership_10 = (TYPEOF(le.Input_membership_10))'','',':membership_10')
    #END
 
+    #IF( #TEXT(Input_position_1)='' )
      '' 
    #ELSE
        IF( le.Input_position_1 = (TYPEOF(le.Input_position_1))'','',':position_1')
    #END
 
+    #IF( #TEXT(Input_position_2)='' )
      '' 
    #ELSE
        IF( le.Input_position_2 = (TYPEOF(le.Input_position_2))'','',':position_2')
    #END
 
+    #IF( #TEXT(Input_position_3)='' )
      '' 
    #ELSE
        IF( le.Input_position_3 = (TYPEOF(le.Input_position_3))'','',':position_3')
    #END
 
+    #IF( #TEXT(Input_position_4)='' )
      '' 
    #ELSE
        IF( le.Input_position_4 = (TYPEOF(le.Input_position_4))'','',':position_4')
    #END
 
+    #IF( #TEXT(Input_position_5)='' )
      '' 
    #ELSE
        IF( le.Input_position_5 = (TYPEOF(le.Input_position_5))'','',':position_5')
    #END
 
+    #IF( #TEXT(Input_position_6)='' )
      '' 
    #ELSE
        IF( le.Input_position_6 = (TYPEOF(le.Input_position_6))'','',':position_6')
    #END
 
+    #IF( #TEXT(Input_position_7)='' )
      '' 
    #ELSE
        IF( le.Input_position_7 = (TYPEOF(le.Input_position_7))'','',':position_7')
    #END
 
+    #IF( #TEXT(Input_position_8)='' )
      '' 
    #ELSE
        IF( le.Input_position_8 = (TYPEOF(le.Input_position_8))'','',':position_8')
    #END
 
+    #IF( #TEXT(Input_position_9)='' )
      '' 
    #ELSE
        IF( le.Input_position_9 = (TYPEOF(le.Input_position_9))'','',':position_9')
    #END
 
+    #IF( #TEXT(Input_position_10)='' )
      '' 
    #ELSE
        IF( le.Input_position_10 = (TYPEOF(le.Input_position_10))'','',':position_10')
    #END
 
+    #IF( #TEXT(Input_occupation_1)='' )
      '' 
    #ELSE
        IF( le.Input_occupation_1 = (TYPEOF(le.Input_occupation_1))'','',':occupation_1')
    #END
 
+    #IF( #TEXT(Input_occupation_2)='' )
      '' 
    #ELSE
        IF( le.Input_occupation_2 = (TYPEOF(le.Input_occupation_2))'','',':occupation_2')
    #END
 
+    #IF( #TEXT(Input_occupation_3)='' )
      '' 
    #ELSE
        IF( le.Input_occupation_3 = (TYPEOF(le.Input_occupation_3))'','',':occupation_3')
    #END
 
+    #IF( #TEXT(Input_occupation_4)='' )
      '' 
    #ELSE
        IF( le.Input_occupation_4 = (TYPEOF(le.Input_occupation_4))'','',':occupation_4')
    #END
 
+    #IF( #TEXT(Input_occupation_5)='' )
      '' 
    #ELSE
        IF( le.Input_occupation_5 = (TYPEOF(le.Input_occupation_5))'','',':occupation_5')
    #END
 
+    #IF( #TEXT(Input_occupation_6)='' )
      '' 
    #ELSE
        IF( le.Input_occupation_6 = (TYPEOF(le.Input_occupation_6))'','',':occupation_6')
    #END
 
+    #IF( #TEXT(Input_occupation_7)='' )
      '' 
    #ELSE
        IF( le.Input_occupation_7 = (TYPEOF(le.Input_occupation_7))'','',':occupation_7')
    #END
 
+    #IF( #TEXT(Input_occupation_8)='' )
      '' 
    #ELSE
        IF( le.Input_occupation_8 = (TYPEOF(le.Input_occupation_8))'','',':occupation_8')
    #END
 
+    #IF( #TEXT(Input_occupation_9)='' )
      '' 
    #ELSE
        IF( le.Input_occupation_9 = (TYPEOF(le.Input_occupation_9))'','',':occupation_9')
    #END
 
+    #IF( #TEXT(Input_occupation_10)='' )
      '' 
    #ELSE
        IF( le.Input_occupation_10 = (TYPEOF(le.Input_occupation_10))'','',':occupation_10')
    #END
 
+    #IF( #TEXT(Input_date_added_to_list)='' )
      '' 
    #ELSE
        IF( le.Input_date_added_to_list = (TYPEOF(le.Input_date_added_to_list))'','',':date_added_to_list')
    #END
 
+    #IF( #TEXT(Input_date_last_updated)='' )
      '' 
    #ELSE
        IF( le.Input_date_last_updated = (TYPEOF(le.Input_date_last_updated))'','',':date_last_updated')
    #END
 
+    #IF( #TEXT(Input_effective_date)='' )
      '' 
    #ELSE
        IF( le.Input_effective_date = (TYPEOF(le.Input_effective_date))'','',':effective_date')
    #END
 
+    #IF( #TEXT(Input_expiration_date)='' )
      '' 
    #ELSE
        IF( le.Input_expiration_date = (TYPEOF(le.Input_expiration_date))'','',':expiration_date')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_grounds)='' )
      '' 
    #ELSE
        IF( le.Input_grounds = (TYPEOF(le.Input_grounds))'','',':grounds')
    #END
 
+    #IF( #TEXT(Input_subj_to_common_pos_2001_931_cfsp_fl)='' )
      '' 
    #ELSE
        IF( le.Input_subj_to_common_pos_2001_931_cfsp_fl = (TYPEOF(le.Input_subj_to_common_pos_2001_931_cfsp_fl))'','',':subj_to_common_pos_2001_931_cfsp_fl')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_1)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_1 = (TYPEOF(le.Input_federal_register_citation_1))'','',':federal_register_citation_1')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_2)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_2 = (TYPEOF(le.Input_federal_register_citation_2))'','',':federal_register_citation_2')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_3)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_3 = (TYPEOF(le.Input_federal_register_citation_3))'','',':federal_register_citation_3')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_4)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_4 = (TYPEOF(le.Input_federal_register_citation_4))'','',':federal_register_citation_4')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_5)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_5 = (TYPEOF(le.Input_federal_register_citation_5))'','',':federal_register_citation_5')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_6)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_6 = (TYPEOF(le.Input_federal_register_citation_6))'','',':federal_register_citation_6')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_7)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_7 = (TYPEOF(le.Input_federal_register_citation_7))'','',':federal_register_citation_7')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_8)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_8 = (TYPEOF(le.Input_federal_register_citation_8))'','',':federal_register_citation_8')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_9)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_9 = (TYPEOF(le.Input_federal_register_citation_9))'','',':federal_register_citation_9')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_10)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_10 = (TYPEOF(le.Input_federal_register_citation_10))'','',':federal_register_citation_10')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_date_1)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_date_1 = (TYPEOF(le.Input_federal_register_citation_date_1))'','',':federal_register_citation_date_1')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_date_2)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_date_2 = (TYPEOF(le.Input_federal_register_citation_date_2))'','',':federal_register_citation_date_2')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_date_3)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_date_3 = (TYPEOF(le.Input_federal_register_citation_date_3))'','',':federal_register_citation_date_3')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_date_4)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_date_4 = (TYPEOF(le.Input_federal_register_citation_date_4))'','',':federal_register_citation_date_4')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_date_5)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_date_5 = (TYPEOF(le.Input_federal_register_citation_date_5))'','',':federal_register_citation_date_5')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_date_6)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_date_6 = (TYPEOF(le.Input_federal_register_citation_date_6))'','',':federal_register_citation_date_6')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_date_7)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_date_7 = (TYPEOF(le.Input_federal_register_citation_date_7))'','',':federal_register_citation_date_7')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_date_8)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_date_8 = (TYPEOF(le.Input_federal_register_citation_date_8))'','',':federal_register_citation_date_8')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_date_9)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_date_9 = (TYPEOF(le.Input_federal_register_citation_date_9))'','',':federal_register_citation_date_9')
    #END
 
+    #IF( #TEXT(Input_federal_register_citation_date_10)='' )
      '' 
    #ELSE
        IF( le.Input_federal_register_citation_date_10 = (TYPEOF(le.Input_federal_register_citation_date_10))'','',':federal_register_citation_date_10')
    #END
 
+    #IF( #TEXT(Input_license_requirement)='' )
      '' 
    #ELSE
        IF( le.Input_license_requirement = (TYPEOF(le.Input_license_requirement))'','',':license_requirement')
    #END
 
+    #IF( #TEXT(Input_license_review_policy)='' )
      '' 
    #ELSE
        IF( le.Input_license_review_policy = (TYPEOF(le.Input_license_review_policy))'','',':license_review_policy')
    #END
 
+    #IF( #TEXT(Input_subordinate_status)='' )
      '' 
    #ELSE
        IF( le.Input_subordinate_status = (TYPEOF(le.Input_subordinate_status))'','',':subordinate_status')
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
 
+    #IF( #TEXT(Input_physique)='' )
      '' 
    #ELSE
        IF( le.Input_physique = (TYPEOF(le.Input_physique))'','',':physique')
    #END
 
+    #IF( #TEXT(Input_hair_color)='' )
      '' 
    #ELSE
        IF( le.Input_hair_color = (TYPEOF(le.Input_hair_color))'','',':hair_color')
    #END
 
+    #IF( #TEXT(Input_eyes)='' )
      '' 
    #ELSE
        IF( le.Input_eyes = (TYPEOF(le.Input_eyes))'','',':eyes')
    #END
 
+    #IF( #TEXT(Input_complexion)='' )
      '' 
    #ELSE
        IF( le.Input_complexion = (TYPEOF(le.Input_complexion))'','',':complexion')
    #END
 
+    #IF( #TEXT(Input_race)='' )
      '' 
    #ELSE
        IF( le.Input_race = (TYPEOF(le.Input_race))'','',':race')
    #END
 
+    #IF( #TEXT(Input_scars_marks)='' )
      '' 
    #ELSE
        IF( le.Input_scars_marks = (TYPEOF(le.Input_scars_marks))'','',':scars_marks')
    #END
 
+    #IF( #TEXT(Input_photo_file)='' )
      '' 
    #ELSE
        IF( le.Input_photo_file = (TYPEOF(le.Input_photo_file))'','',':photo_file')
    #END
 
+    #IF( #TEXT(Input_offenses)='' )
      '' 
    #ELSE
        IF( le.Input_offenses = (TYPEOF(le.Input_offenses))'','',':offenses')
    #END
 
+    #IF( #TEXT(Input_ncic)='' )
      '' 
    #ELSE
        IF( le.Input_ncic = (TYPEOF(le.Input_ncic))'','',':ncic')
    #END
 
+    #IF( #TEXT(Input_warrant_by)='' )
      '' 
    #ELSE
        IF( le.Input_warrant_by = (TYPEOF(le.Input_warrant_by))'','',':warrant_by')
    #END
 
+    #IF( #TEXT(Input_caution)='' )
      '' 
    #ELSE
        IF( le.Input_caution = (TYPEOF(le.Input_caution))'','',':caution')
    #END
 
+    #IF( #TEXT(Input_reward)='' )
      '' 
    #ELSE
        IF( le.Input_reward = (TYPEOF(le.Input_reward))'','',':reward')
    #END
 
+    #IF( #TEXT(Input_type_of_denial)='' )
      '' 
    #ELSE
        IF( le.Input_type_of_denial = (TYPEOF(le.Input_type_of_denial))'','',':type_of_denial')
    #END
 
+    #IF( #TEXT(Input_linked_with_1)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_1 = (TYPEOF(le.Input_linked_with_1))'','',':linked_with_1')
    #END
 
+    #IF( #TEXT(Input_linked_with_2)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_2 = (TYPEOF(le.Input_linked_with_2))'','',':linked_with_2')
    #END
 
+    #IF( #TEXT(Input_linked_with_3)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_3 = (TYPEOF(le.Input_linked_with_3))'','',':linked_with_3')
    #END
 
+    #IF( #TEXT(Input_linked_with_4)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_4 = (TYPEOF(le.Input_linked_with_4))'','',':linked_with_4')
    #END
 
+    #IF( #TEXT(Input_linked_with_5)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_5 = (TYPEOF(le.Input_linked_with_5))'','',':linked_with_5')
    #END
 
+    #IF( #TEXT(Input_linked_with_6)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_6 = (TYPEOF(le.Input_linked_with_6))'','',':linked_with_6')
    #END
 
+    #IF( #TEXT(Input_linked_with_7)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_7 = (TYPEOF(le.Input_linked_with_7))'','',':linked_with_7')
    #END
 
+    #IF( #TEXT(Input_linked_with_8)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_8 = (TYPEOF(le.Input_linked_with_8))'','',':linked_with_8')
    #END
 
+    #IF( #TEXT(Input_linked_with_9)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_9 = (TYPEOF(le.Input_linked_with_9))'','',':linked_with_9')
    #END
 
+    #IF( #TEXT(Input_linked_with_10)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_10 = (TYPEOF(le.Input_linked_with_10))'','',':linked_with_10')
    #END
 
+    #IF( #TEXT(Input_linked_with_id_1)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_id_1 = (TYPEOF(le.Input_linked_with_id_1))'','',':linked_with_id_1')
    #END
 
+    #IF( #TEXT(Input_linked_with_id_2)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_id_2 = (TYPEOF(le.Input_linked_with_id_2))'','',':linked_with_id_2')
    #END
 
+    #IF( #TEXT(Input_linked_with_id_3)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_id_3 = (TYPEOF(le.Input_linked_with_id_3))'','',':linked_with_id_3')
    #END
 
+    #IF( #TEXT(Input_linked_with_id_4)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_id_4 = (TYPEOF(le.Input_linked_with_id_4))'','',':linked_with_id_4')
    #END
 
+    #IF( #TEXT(Input_linked_with_id_5)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_id_5 = (TYPEOF(le.Input_linked_with_id_5))'','',':linked_with_id_5')
    #END
 
+    #IF( #TEXT(Input_linked_with_id_6)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_id_6 = (TYPEOF(le.Input_linked_with_id_6))'','',':linked_with_id_6')
    #END
 
+    #IF( #TEXT(Input_linked_with_id_7)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_id_7 = (TYPEOF(le.Input_linked_with_id_7))'','',':linked_with_id_7')
    #END
 
+    #IF( #TEXT(Input_linked_with_id_8)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_id_8 = (TYPEOF(le.Input_linked_with_id_8))'','',':linked_with_id_8')
    #END
 
+    #IF( #TEXT(Input_linked_with_id_9)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_id_9 = (TYPEOF(le.Input_linked_with_id_9))'','',':linked_with_id_9')
    #END
 
+    #IF( #TEXT(Input_linked_with_id_10)='' )
      '' 
    #ELSE
        IF( le.Input_linked_with_id_10 = (TYPEOF(le.Input_linked_with_id_10))'','',':linked_with_id_10')
    #END
 
+    #IF( #TEXT(Input_listing_information)='' )
      '' 
    #ELSE
        IF( le.Input_listing_information = (TYPEOF(le.Input_listing_information))'','',':listing_information')
    #END
 
+    #IF( #TEXT(Input_foreign_principal)='' )
      '' 
    #ELSE
        IF( le.Input_foreign_principal = (TYPEOF(le.Input_foreign_principal))'','',':foreign_principal')
    #END
 
+    #IF( #TEXT(Input_nature_of_service)='' )
      '' 
    #ELSE
        IF( le.Input_nature_of_service = (TYPEOF(le.Input_nature_of_service))'','',':nature_of_service')
    #END
 
+    #IF( #TEXT(Input_activities)='' )
      '' 
    #ELSE
        IF( le.Input_activities = (TYPEOF(le.Input_activities))'','',':activities')
    #END
 
+    #IF( #TEXT(Input_finances)='' )
      '' 
    #ELSE
        IF( le.Input_finances = (TYPEOF(le.Input_finances))'','',':finances')
    #END
 
+    #IF( #TEXT(Input_registrant_terminated_flag)='' )
      '' 
    #ELSE
        IF( le.Input_registrant_terminated_flag = (TYPEOF(le.Input_registrant_terminated_flag))'','',':registrant_terminated_flag')
    #END
 
+    #IF( #TEXT(Input_foreign_principal_terminated_flag)='' )
      '' 
    #ELSE
        IF( le.Input_foreign_principal_terminated_flag = (TYPEOF(le.Input_foreign_principal_terminated_flag))'','',':foreign_principal_terminated_flag')
    #END
 
+    #IF( #TEXT(Input_short_form_terminated_flag)='' )
      '' 
    #ELSE
        IF( le.Input_short_form_terminated_flag = (TYPEOF(le.Input_short_form_terminated_flag))'','',':short_form_terminated_flag')
    #END
 
+    #IF( #TEXT(Input_src_key)='' )
      '' 
    #ELSE
        IF( le.Input_src_key = (TYPEOF(le.Input_src_key))'','',':src_key')
    #END
;
    #IF (#TEXT(src_key)<>'')
    SELF.source := le.src_key;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(src_key)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(src_key)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(src_key)<>'' ) source, #END -cnt );
ENDMACRO;
