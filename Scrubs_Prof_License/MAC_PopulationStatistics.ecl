 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_prolic_key = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_profession_or_board = '',Input_license_type = '',Input_status = '',Input_orig_license_number = '',Input_license_number = '',Input_previous_license_number = '',Input_previous_license_type = '',Input_company_name = '',Input_orig_name = '',Input_name_order = '',Input_orig_former_name = '',Input_former_name_order = '',Input_orig_addr_1 = '',Input_orig_addr_2 = '',Input_orig_addr_3 = '',Input_orig_addr_4 = '',Input_orig_city = '',Input_orig_st = '',Input_orig_zip = '',Input_county_str = '',Input_country_str = '',Input_business_flag = '',Input_phone = '',Input_sex = '',Input_dob = '',Input_issue_date = '',Input_expiration_date = '',Input_last_renewal_date = '',Input_license_obtained_by = '',Input_board_action_indicator = '',Input_source_st = '',Input_vendor = '',Input_action_record_type = '',Input_action_complaint_violation_cds = '',Input_action_complaint_violation_desc = '',Input_action_complaint_violation_dt = '',Input_action_case_number = '',Input_action_effective_dt = '',Input_action_cds = '',Input_action_desc = '',Input_action_final_order_no = '',Input_action_status = '',Input_action_posting_status_dt = '',Input_action_original_filename_or_url = '',Input_additional_name_addr_type = '',Input_additional_orig_name = '',Input_additional_name_order = '',Input_additional_orig_additional_1 = '',Input_additional_orig_additional_2 = '',Input_additional_orig_additional_3 = '',Input_additional_orig_additional_4 = '',Input_additional_orig_city = '',Input_additional_orig_st = '',Input_additional_orig_zip = '',Input_additional_phone = '',Input_misc_occupation = '',Input_misc_practice_hours = '',Input_misc_practice_type = '',Input_misc_email = '',Input_misc_fax = '',Input_misc_web_site = '',Input_misc_other_id = '',Input_misc_other_id_type = '',Input_education_continuing_education = '',Input_education_1_school_attended = '',Input_education_1_dates_attended = '',Input_education_1_curriculum = '',Input_education_1_degree = '',Input_education_2_school_attended = '',Input_education_2_dates_attended = '',Input_education_2_curriculum = '',Input_education_2_degree = '',Input_education_3_school_attended = '',Input_education_3_dates_attended = '',Input_education_3_curriculum = '',Input_education_3_degree = '',Input_additional_licensing_specifics = '',Input_personal_pob_cd = '',Input_personal_pob_desc = '',Input_personal_race_cd = '',Input_personal_race_desc = '',Input_status_status_cds = '',Input_status_effective_dt = '',Input_status_renewal_desc = '',Input_status_other_agency = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dpbc = '',Input_chk_digit = '',Input_record_type = '',Input_ace_fips_st = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_pl_score_in = '',Input_prep_addr_line1 = '',Input_prep_addr_last_line = '',Input_rawaid = '',Input_aceaid = '',Input_county_name = '',Input_did = '',Input_score = '',Input_best_ssn = '',Input_bdid = '',Input_source_rec_id = '',Input_dotid = '',Input_dotscore = '',Input_dotweight = '',Input_empid = '',Input_empscore = '',Input_empweight = '',Input_powid = '',Input_powscore = '',Input_powweight = '',Input_proxid = '',Input_proxscore = '',Input_proxweight = '',Input_seleid = '',Input_selescore = '',Input_seleweight = '',Input_orgid = '',Input_orgscore = '',Input_orgweight = '',Input_ultid = '',Input_ultscore = '',Input_ultweight = '',Input_lnpid = '',OutFile) := MACRO
  IMPORT SALT37,Scrubs_Prof_License;
  #uniquename(of)
  %of% := RECORD
    SALT37.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_prolic_key)='' )
      '' 
    #ELSE
        IF( le.Input_prolic_key = (TYPEOF(le.Input_prolic_key))'','',':prolic_key')
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
 
+    #IF( #TEXT(Input_profession_or_board)='' )
      '' 
    #ELSE
        IF( le.Input_profession_or_board = (TYPEOF(le.Input_profession_or_board))'','',':profession_or_board')
    #END
 
+    #IF( #TEXT(Input_license_type)='' )
      '' 
    #ELSE
        IF( le.Input_license_type = (TYPEOF(le.Input_license_type))'','',':license_type')
    #END
 
+    #IF( #TEXT(Input_status)='' )
      '' 
    #ELSE
        IF( le.Input_status = (TYPEOF(le.Input_status))'','',':status')
    #END
 
+    #IF( #TEXT(Input_orig_license_number)='' )
      '' 
    #ELSE
        IF( le.Input_orig_license_number = (TYPEOF(le.Input_orig_license_number))'','',':orig_license_number')
    #END
 
+    #IF( #TEXT(Input_license_number)='' )
      '' 
    #ELSE
        IF( le.Input_license_number = (TYPEOF(le.Input_license_number))'','',':license_number')
    #END
 
+    #IF( #TEXT(Input_previous_license_number)='' )
      '' 
    #ELSE
        IF( le.Input_previous_license_number = (TYPEOF(le.Input_previous_license_number))'','',':previous_license_number')
    #END
 
+    #IF( #TEXT(Input_previous_license_type)='' )
      '' 
    #ELSE
        IF( le.Input_previous_license_type = (TYPEOF(le.Input_previous_license_type))'','',':previous_license_type')
    #END
 
+    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (TYPEOF(le.Input_company_name))'','',':company_name')
    #END
 
+    #IF( #TEXT(Input_orig_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_name = (TYPEOF(le.Input_orig_name))'','',':orig_name')
    #END
 
+    #IF( #TEXT(Input_name_order)='' )
      '' 
    #ELSE
        IF( le.Input_name_order = (TYPEOF(le.Input_name_order))'','',':name_order')
    #END
 
+    #IF( #TEXT(Input_orig_former_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_former_name = (TYPEOF(le.Input_orig_former_name))'','',':orig_former_name')
    #END
 
+    #IF( #TEXT(Input_former_name_order)='' )
      '' 
    #ELSE
        IF( le.Input_former_name_order = (TYPEOF(le.Input_former_name_order))'','',':former_name_order')
    #END
 
+    #IF( #TEXT(Input_orig_addr_1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_addr_1 = (TYPEOF(le.Input_orig_addr_1))'','',':orig_addr_1')
    #END
 
+    #IF( #TEXT(Input_orig_addr_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_addr_2 = (TYPEOF(le.Input_orig_addr_2))'','',':orig_addr_2')
    #END
 
+    #IF( #TEXT(Input_orig_addr_3)='' )
      '' 
    #ELSE
        IF( le.Input_orig_addr_3 = (TYPEOF(le.Input_orig_addr_3))'','',':orig_addr_3')
    #END
 
+    #IF( #TEXT(Input_orig_addr_4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_addr_4 = (TYPEOF(le.Input_orig_addr_4))'','',':orig_addr_4')
    #END
 
+    #IF( #TEXT(Input_orig_city)='' )
      '' 
    #ELSE
        IF( le.Input_orig_city = (TYPEOF(le.Input_orig_city))'','',':orig_city')
    #END
 
+    #IF( #TEXT(Input_orig_st)='' )
      '' 
    #ELSE
        IF( le.Input_orig_st = (TYPEOF(le.Input_orig_st))'','',':orig_st')
    #END
 
+    #IF( #TEXT(Input_orig_zip)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip = (TYPEOF(le.Input_orig_zip))'','',':orig_zip')
    #END
 
+    #IF( #TEXT(Input_county_str)='' )
      '' 
    #ELSE
        IF( le.Input_county_str = (TYPEOF(le.Input_county_str))'','',':county_str')
    #END
 
+    #IF( #TEXT(Input_country_str)='' )
      '' 
    #ELSE
        IF( le.Input_country_str = (TYPEOF(le.Input_country_str))'','',':country_str')
    #END
 
+    #IF( #TEXT(Input_business_flag)='' )
      '' 
    #ELSE
        IF( le.Input_business_flag = (TYPEOF(le.Input_business_flag))'','',':business_flag')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_sex)='' )
      '' 
    #ELSE
        IF( le.Input_sex = (TYPEOF(le.Input_sex))'','',':sex')
    #END
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_issue_date)='' )
      '' 
    #ELSE
        IF( le.Input_issue_date = (TYPEOF(le.Input_issue_date))'','',':issue_date')
    #END
 
+    #IF( #TEXT(Input_expiration_date)='' )
      '' 
    #ELSE
        IF( le.Input_expiration_date = (TYPEOF(le.Input_expiration_date))'','',':expiration_date')
    #END
 
+    #IF( #TEXT(Input_last_renewal_date)='' )
      '' 
    #ELSE
        IF( le.Input_last_renewal_date = (TYPEOF(le.Input_last_renewal_date))'','',':last_renewal_date')
    #END
 
+    #IF( #TEXT(Input_license_obtained_by)='' )
      '' 
    #ELSE
        IF( le.Input_license_obtained_by = (TYPEOF(le.Input_license_obtained_by))'','',':license_obtained_by')
    #END
 
+    #IF( #TEXT(Input_board_action_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_board_action_indicator = (TYPEOF(le.Input_board_action_indicator))'','',':board_action_indicator')
    #END
 
+    #IF( #TEXT(Input_source_st)='' )
      '' 
    #ELSE
        IF( le.Input_source_st = (TYPEOF(le.Input_source_st))'','',':source_st')
    #END
 
+    #IF( #TEXT(Input_vendor)='' )
      '' 
    #ELSE
        IF( le.Input_vendor = (TYPEOF(le.Input_vendor))'','',':vendor')
    #END
 
+    #IF( #TEXT(Input_action_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_action_record_type = (TYPEOF(le.Input_action_record_type))'','',':action_record_type')
    #END
 
+    #IF( #TEXT(Input_action_complaint_violation_cds)='' )
      '' 
    #ELSE
        IF( le.Input_action_complaint_violation_cds = (TYPEOF(le.Input_action_complaint_violation_cds))'','',':action_complaint_violation_cds')
    #END
 
+    #IF( #TEXT(Input_action_complaint_violation_desc)='' )
      '' 
    #ELSE
        IF( le.Input_action_complaint_violation_desc = (TYPEOF(le.Input_action_complaint_violation_desc))'','',':action_complaint_violation_desc')
    #END
 
+    #IF( #TEXT(Input_action_complaint_violation_dt)='' )
      '' 
    #ELSE
        IF( le.Input_action_complaint_violation_dt = (TYPEOF(le.Input_action_complaint_violation_dt))'','',':action_complaint_violation_dt')
    #END
 
+    #IF( #TEXT(Input_action_case_number)='' )
      '' 
    #ELSE
        IF( le.Input_action_case_number = (TYPEOF(le.Input_action_case_number))'','',':action_case_number')
    #END
 
+    #IF( #TEXT(Input_action_effective_dt)='' )
      '' 
    #ELSE
        IF( le.Input_action_effective_dt = (TYPEOF(le.Input_action_effective_dt))'','',':action_effective_dt')
    #END
 
+    #IF( #TEXT(Input_action_cds)='' )
      '' 
    #ELSE
        IF( le.Input_action_cds = (TYPEOF(le.Input_action_cds))'','',':action_cds')
    #END
 
+    #IF( #TEXT(Input_action_desc)='' )
      '' 
    #ELSE
        IF( le.Input_action_desc = (TYPEOF(le.Input_action_desc))'','',':action_desc')
    #END
 
+    #IF( #TEXT(Input_action_final_order_no)='' )
      '' 
    #ELSE
        IF( le.Input_action_final_order_no = (TYPEOF(le.Input_action_final_order_no))'','',':action_final_order_no')
    #END
 
+    #IF( #TEXT(Input_action_status)='' )
      '' 
    #ELSE
        IF( le.Input_action_status = (TYPEOF(le.Input_action_status))'','',':action_status')
    #END
 
+    #IF( #TEXT(Input_action_posting_status_dt)='' )
      '' 
    #ELSE
        IF( le.Input_action_posting_status_dt = (TYPEOF(le.Input_action_posting_status_dt))'','',':action_posting_status_dt')
    #END
 
+    #IF( #TEXT(Input_action_original_filename_or_url)='' )
      '' 
    #ELSE
        IF( le.Input_action_original_filename_or_url = (TYPEOF(le.Input_action_original_filename_or_url))'','',':action_original_filename_or_url')
    #END
 
+    #IF( #TEXT(Input_additional_name_addr_type)='' )
      '' 
    #ELSE
        IF( le.Input_additional_name_addr_type = (TYPEOF(le.Input_additional_name_addr_type))'','',':additional_name_addr_type')
    #END
 
+    #IF( #TEXT(Input_additional_orig_name)='' )
      '' 
    #ELSE
        IF( le.Input_additional_orig_name = (TYPEOF(le.Input_additional_orig_name))'','',':additional_orig_name')
    #END
 
+    #IF( #TEXT(Input_additional_name_order)='' )
      '' 
    #ELSE
        IF( le.Input_additional_name_order = (TYPEOF(le.Input_additional_name_order))'','',':additional_name_order')
    #END
 
+    #IF( #TEXT(Input_additional_orig_additional_1)='' )
      '' 
    #ELSE
        IF( le.Input_additional_orig_additional_1 = (TYPEOF(le.Input_additional_orig_additional_1))'','',':additional_orig_additional_1')
    #END
 
+    #IF( #TEXT(Input_additional_orig_additional_2)='' )
      '' 
    #ELSE
        IF( le.Input_additional_orig_additional_2 = (TYPEOF(le.Input_additional_orig_additional_2))'','',':additional_orig_additional_2')
    #END
 
+    #IF( #TEXT(Input_additional_orig_additional_3)='' )
      '' 
    #ELSE
        IF( le.Input_additional_orig_additional_3 = (TYPEOF(le.Input_additional_orig_additional_3))'','',':additional_orig_additional_3')
    #END
 
+    #IF( #TEXT(Input_additional_orig_additional_4)='' )
      '' 
    #ELSE
        IF( le.Input_additional_orig_additional_4 = (TYPEOF(le.Input_additional_orig_additional_4))'','',':additional_orig_additional_4')
    #END
 
+    #IF( #TEXT(Input_additional_orig_city)='' )
      '' 
    #ELSE
        IF( le.Input_additional_orig_city = (TYPEOF(le.Input_additional_orig_city))'','',':additional_orig_city')
    #END
 
+    #IF( #TEXT(Input_additional_orig_st)='' )
      '' 
    #ELSE
        IF( le.Input_additional_orig_st = (TYPEOF(le.Input_additional_orig_st))'','',':additional_orig_st')
    #END
 
+    #IF( #TEXT(Input_additional_orig_zip)='' )
      '' 
    #ELSE
        IF( le.Input_additional_orig_zip = (TYPEOF(le.Input_additional_orig_zip))'','',':additional_orig_zip')
    #END
 
+    #IF( #TEXT(Input_additional_phone)='' )
      '' 
    #ELSE
        IF( le.Input_additional_phone = (TYPEOF(le.Input_additional_phone))'','',':additional_phone')
    #END
 
+    #IF( #TEXT(Input_misc_occupation)='' )
      '' 
    #ELSE
        IF( le.Input_misc_occupation = (TYPEOF(le.Input_misc_occupation))'','',':misc_occupation')
    #END
 
+    #IF( #TEXT(Input_misc_practice_hours)='' )
      '' 
    #ELSE
        IF( le.Input_misc_practice_hours = (TYPEOF(le.Input_misc_practice_hours))'','',':misc_practice_hours')
    #END
 
+    #IF( #TEXT(Input_misc_practice_type)='' )
      '' 
    #ELSE
        IF( le.Input_misc_practice_type = (TYPEOF(le.Input_misc_practice_type))'','',':misc_practice_type')
    #END
 
+    #IF( #TEXT(Input_misc_email)='' )
      '' 
    #ELSE
        IF( le.Input_misc_email = (TYPEOF(le.Input_misc_email))'','',':misc_email')
    #END
 
+    #IF( #TEXT(Input_misc_fax)='' )
      '' 
    #ELSE
        IF( le.Input_misc_fax = (TYPEOF(le.Input_misc_fax))'','',':misc_fax')
    #END
 
+    #IF( #TEXT(Input_misc_web_site)='' )
      '' 
    #ELSE
        IF( le.Input_misc_web_site = (TYPEOF(le.Input_misc_web_site))'','',':misc_web_site')
    #END
 
+    #IF( #TEXT(Input_misc_other_id)='' )
      '' 
    #ELSE
        IF( le.Input_misc_other_id = (TYPEOF(le.Input_misc_other_id))'','',':misc_other_id')
    #END
 
+    #IF( #TEXT(Input_misc_other_id_type)='' )
      '' 
    #ELSE
        IF( le.Input_misc_other_id_type = (TYPEOF(le.Input_misc_other_id_type))'','',':misc_other_id_type')
    #END
 
+    #IF( #TEXT(Input_education_continuing_education)='' )
      '' 
    #ELSE
        IF( le.Input_education_continuing_education = (TYPEOF(le.Input_education_continuing_education))'','',':education_continuing_education')
    #END
 
+    #IF( #TEXT(Input_education_1_school_attended)='' )
      '' 
    #ELSE
        IF( le.Input_education_1_school_attended = (TYPEOF(le.Input_education_1_school_attended))'','',':education_1_school_attended')
    #END
 
+    #IF( #TEXT(Input_education_1_dates_attended)='' )
      '' 
    #ELSE
        IF( le.Input_education_1_dates_attended = (TYPEOF(le.Input_education_1_dates_attended))'','',':education_1_dates_attended')
    #END
 
+    #IF( #TEXT(Input_education_1_curriculum)='' )
      '' 
    #ELSE
        IF( le.Input_education_1_curriculum = (TYPEOF(le.Input_education_1_curriculum))'','',':education_1_curriculum')
    #END
 
+    #IF( #TEXT(Input_education_1_degree)='' )
      '' 
    #ELSE
        IF( le.Input_education_1_degree = (TYPEOF(le.Input_education_1_degree))'','',':education_1_degree')
    #END
 
+    #IF( #TEXT(Input_education_2_school_attended)='' )
      '' 
    #ELSE
        IF( le.Input_education_2_school_attended = (TYPEOF(le.Input_education_2_school_attended))'','',':education_2_school_attended')
    #END
 
+    #IF( #TEXT(Input_education_2_dates_attended)='' )
      '' 
    #ELSE
        IF( le.Input_education_2_dates_attended = (TYPEOF(le.Input_education_2_dates_attended))'','',':education_2_dates_attended')
    #END
 
+    #IF( #TEXT(Input_education_2_curriculum)='' )
      '' 
    #ELSE
        IF( le.Input_education_2_curriculum = (TYPEOF(le.Input_education_2_curriculum))'','',':education_2_curriculum')
    #END
 
+    #IF( #TEXT(Input_education_2_degree)='' )
      '' 
    #ELSE
        IF( le.Input_education_2_degree = (TYPEOF(le.Input_education_2_degree))'','',':education_2_degree')
    #END
 
+    #IF( #TEXT(Input_education_3_school_attended)='' )
      '' 
    #ELSE
        IF( le.Input_education_3_school_attended = (TYPEOF(le.Input_education_3_school_attended))'','',':education_3_school_attended')
    #END
 
+    #IF( #TEXT(Input_education_3_dates_attended)='' )
      '' 
    #ELSE
        IF( le.Input_education_3_dates_attended = (TYPEOF(le.Input_education_3_dates_attended))'','',':education_3_dates_attended')
    #END
 
+    #IF( #TEXT(Input_education_3_curriculum)='' )
      '' 
    #ELSE
        IF( le.Input_education_3_curriculum = (TYPEOF(le.Input_education_3_curriculum))'','',':education_3_curriculum')
    #END
 
+    #IF( #TEXT(Input_education_3_degree)='' )
      '' 
    #ELSE
        IF( le.Input_education_3_degree = (TYPEOF(le.Input_education_3_degree))'','',':education_3_degree')
    #END
 
+    #IF( #TEXT(Input_additional_licensing_specifics)='' )
      '' 
    #ELSE
        IF( le.Input_additional_licensing_specifics = (TYPEOF(le.Input_additional_licensing_specifics))'','',':additional_licensing_specifics')
    #END
 
+    #IF( #TEXT(Input_personal_pob_cd)='' )
      '' 
    #ELSE
        IF( le.Input_personal_pob_cd = (TYPEOF(le.Input_personal_pob_cd))'','',':personal_pob_cd')
    #END
 
+    #IF( #TEXT(Input_personal_pob_desc)='' )
      '' 
    #ELSE
        IF( le.Input_personal_pob_desc = (TYPEOF(le.Input_personal_pob_desc))'','',':personal_pob_desc')
    #END
 
+    #IF( #TEXT(Input_personal_race_cd)='' )
      '' 
    #ELSE
        IF( le.Input_personal_race_cd = (TYPEOF(le.Input_personal_race_cd))'','',':personal_race_cd')
    #END
 
+    #IF( #TEXT(Input_personal_race_desc)='' )
      '' 
    #ELSE
        IF( le.Input_personal_race_desc = (TYPEOF(le.Input_personal_race_desc))'','',':personal_race_desc')
    #END
 
+    #IF( #TEXT(Input_status_status_cds)='' )
      '' 
    #ELSE
        IF( le.Input_status_status_cds = (TYPEOF(le.Input_status_status_cds))'','',':status_status_cds')
    #END
 
+    #IF( #TEXT(Input_status_effective_dt)='' )
      '' 
    #ELSE
        IF( le.Input_status_effective_dt = (TYPEOF(le.Input_status_effective_dt))'','',':status_effective_dt')
    #END
 
+    #IF( #TEXT(Input_status_renewal_desc)='' )
      '' 
    #ELSE
        IF( le.Input_status_renewal_desc = (TYPEOF(le.Input_status_renewal_desc))'','',':status_renewal_desc')
    #END
 
+    #IF( #TEXT(Input_status_other_agency)='' )
      '' 
    #ELSE
        IF( le.Input_status_other_agency = (TYPEOF(le.Input_status_other_agency))'','',':status_other_agency')
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
 
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
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
 
+    #IF( #TEXT(Input_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix = (TYPEOF(le.Input_name_suffix))'','',':name_suffix')
    #END
 
+    #IF( #TEXT(Input_pl_score_in)='' )
      '' 
    #ELSE
        IF( le.Input_pl_score_in = (TYPEOF(le.Input_pl_score_in))'','',':pl_score_in')
    #END
 
+    #IF( #TEXT(Input_prep_addr_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr_line1 = (TYPEOF(le.Input_prep_addr_line1))'','',':prep_addr_line1')
    #END
 
+    #IF( #TEXT(Input_prep_addr_last_line)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr_last_line = (TYPEOF(le.Input_prep_addr_last_line))'','',':prep_addr_last_line')
    #END
 
+    #IF( #TEXT(Input_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_rawaid = (TYPEOF(le.Input_rawaid))'','',':rawaid')
    #END
 
+    #IF( #TEXT(Input_aceaid)='' )
      '' 
    #ELSE
        IF( le.Input_aceaid = (TYPEOF(le.Input_aceaid))'','',':aceaid')
    #END
 
+    #IF( #TEXT(Input_county_name)='' )
      '' 
    #ELSE
        IF( le.Input_county_name = (TYPEOF(le.Input_county_name))'','',':county_name')
    #END
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_score)='' )
      '' 
    #ELSE
        IF( le.Input_score = (TYPEOF(le.Input_score))'','',':score')
    #END
 
+    #IF( #TEXT(Input_best_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_best_ssn = (TYPEOF(le.Input_best_ssn))'','',':best_ssn')
    #END
 
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
 
+    #IF( #TEXT(Input_source_rec_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_rec_id = (TYPEOF(le.Input_source_rec_id))'','',':source_rec_id')
    #END
 
+    #IF( #TEXT(Input_dotid)='' )
      '' 
    #ELSE
        IF( le.Input_dotid = (TYPEOF(le.Input_dotid))'','',':dotid')
    #END
 
+    #IF( #TEXT(Input_dotscore)='' )
      '' 
    #ELSE
        IF( le.Input_dotscore = (TYPEOF(le.Input_dotscore))'','',':dotscore')
    #END
 
+    #IF( #TEXT(Input_dotweight)='' )
      '' 
    #ELSE
        IF( le.Input_dotweight = (TYPEOF(le.Input_dotweight))'','',':dotweight')
    #END
 
+    #IF( #TEXT(Input_empid)='' )
      '' 
    #ELSE
        IF( le.Input_empid = (TYPEOF(le.Input_empid))'','',':empid')
    #END
 
+    #IF( #TEXT(Input_empscore)='' )
      '' 
    #ELSE
        IF( le.Input_empscore = (TYPEOF(le.Input_empscore))'','',':empscore')
    #END
 
+    #IF( #TEXT(Input_empweight)='' )
      '' 
    #ELSE
        IF( le.Input_empweight = (TYPEOF(le.Input_empweight))'','',':empweight')
    #END
 
+    #IF( #TEXT(Input_powid)='' )
      '' 
    #ELSE
        IF( le.Input_powid = (TYPEOF(le.Input_powid))'','',':powid')
    #END
 
+    #IF( #TEXT(Input_powscore)='' )
      '' 
    #ELSE
        IF( le.Input_powscore = (TYPEOF(le.Input_powscore))'','',':powscore')
    #END
 
+    #IF( #TEXT(Input_powweight)='' )
      '' 
    #ELSE
        IF( le.Input_powweight = (TYPEOF(le.Input_powweight))'','',':powweight')
    #END
 
+    #IF( #TEXT(Input_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_proxid = (TYPEOF(le.Input_proxid))'','',':proxid')
    #END
 
+    #IF( #TEXT(Input_proxscore)='' )
      '' 
    #ELSE
        IF( le.Input_proxscore = (TYPEOF(le.Input_proxscore))'','',':proxscore')
    #END
 
+    #IF( #TEXT(Input_proxweight)='' )
      '' 
    #ELSE
        IF( le.Input_proxweight = (TYPEOF(le.Input_proxweight))'','',':proxweight')
    #END
 
+    #IF( #TEXT(Input_seleid)='' )
      '' 
    #ELSE
        IF( le.Input_seleid = (TYPEOF(le.Input_seleid))'','',':seleid')
    #END
 
+    #IF( #TEXT(Input_selescore)='' )
      '' 
    #ELSE
        IF( le.Input_selescore = (TYPEOF(le.Input_selescore))'','',':selescore')
    #END
 
+    #IF( #TEXT(Input_seleweight)='' )
      '' 
    #ELSE
        IF( le.Input_seleweight = (TYPEOF(le.Input_seleweight))'','',':seleweight')
    #END
 
+    #IF( #TEXT(Input_orgid)='' )
      '' 
    #ELSE
        IF( le.Input_orgid = (TYPEOF(le.Input_orgid))'','',':orgid')
    #END
 
+    #IF( #TEXT(Input_orgscore)='' )
      '' 
    #ELSE
        IF( le.Input_orgscore = (TYPEOF(le.Input_orgscore))'','',':orgscore')
    #END
 
+    #IF( #TEXT(Input_orgweight)='' )
      '' 
    #ELSE
        IF( le.Input_orgweight = (TYPEOF(le.Input_orgweight))'','',':orgweight')
    #END
 
+    #IF( #TEXT(Input_ultid)='' )
      '' 
    #ELSE
        IF( le.Input_ultid = (TYPEOF(le.Input_ultid))'','',':ultid')
    #END
 
+    #IF( #TEXT(Input_ultscore)='' )
      '' 
    #ELSE
        IF( le.Input_ultscore = (TYPEOF(le.Input_ultscore))'','',':ultscore')
    #END
 
+    #IF( #TEXT(Input_ultweight)='' )
      '' 
    #ELSE
        IF( le.Input_ultweight = (TYPEOF(le.Input_ultweight))'','',':ultweight')
    #END
 
+    #IF( #TEXT(Input_lnpid)='' )
      '' 
    #ELSE
        IF( le.Input_lnpid = (TYPEOF(le.Input_lnpid))'','',':lnpid')
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
