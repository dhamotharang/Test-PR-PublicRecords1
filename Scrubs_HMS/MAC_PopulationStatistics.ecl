EXPORT MAC_PopulationStatistics(infile,Ref='',Input_hms_piid = '',Input_first = '',Input_middle = '',Input_last = '',Input_suffix = '',Input_cred = '',Input_practitioner_type = '',Input_active = '',Input_vendible = '',Input_npi_num = '',Input_npi_enumeration_date = '',Input_npi_deactivation_date = '',Input_npi_reactivation_date = '',Input_npi_taxonomy_code = '',Input_upin = '',Input_medicare_participation_flag = '',Input_date_born = '',Input_date_died = '',Input_pid = '',Input_src = '',Input_date_vendor_first_reported = '',Input_date_vendor_last_reported = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_record_type = '',Input_source_rid = '',Input_lnpid = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_nametype = '',Input_nid = '',Input_clean_npi_enumeration_date = '',Input_clean_npi_deactivation_date = '',Input_clean_npi_reactivation_date = '',Input_clean_date_born = '',Input_clean_date_died = '',Input_clean_company_name = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_fips_st = '',Input_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_rawaid = '',Input_aceaid = '',Input_firm_name = '',Input_lid = '',Input_agid = '',Input_address_std_code = '',Input_latitude = '',Input_longitude = '',Input_prepped_addr1 = '',Input_prepped_addr2 = '',Input_addr_type = '',Input_state_license_state = '',Input_state_license_number = '',Input_state_license_type = '',Input_state_license_active = '',Input_state_license_expire = '',Input_state_license_qualifier = '',Input_state_license_sub_qualifier = '',Input_state_license_issued = '',Input_clean_state_license_expire = '',Input_clean_state_license_issued = '',Input_dea_num = '',Input_dea_bac = '',Input_dea_sub_bac = '',Input_dea_schedule = '',Input_dea_expire = '',Input_dea_active = '',Input_clean_dea_expire = '',Input_csr_number = '',Input_csr_state = '',Input_csr_expire_date = '',Input_csr_issue_date = '',Input_dsa_lvl_2 = '',Input_dsa_lvl_2n = '',Input_dsa_lvl_3 = '',Input_dsa_lvl_3n = '',Input_dsa_lvl_4 = '',Input_dsa_lvl_5 = '',Input_csr_raw1 = '',Input_csr_raw2 = '',Input_csr_raw3 = '',Input_csr_raw4 = '',Input_clean_csr_expire_date = '',Input_clean_csr_issue_date = '',Input_sanction_id = '',Input_sanction_action_code = '',Input_sanction_action_description = '',Input_sanction_board_code = '',Input_sanction_board_description = '',Input_action_date = '',Input_sanction_period_start_date = '',Input_sanction_period_end_date = '',Input_month_duration = '',Input_fine_amount = '',Input_offense_code = '',Input_offense_description = '',Input_offense_date = '',Input_clean_offense_date = '',Input_clean_action_date = '',Input_clean_sanction_period_start_date = '',Input_clean_sanction_period_end_date = '',Input_gsa_sanction_id = '',Input_gsa_first = '',Input_gsa_middle = '',Input_gsa_last = '',Input_gsa_suffix = '',Input_gsa_city = '',Input_gsa_state = '',Input_gsa_zip = '',Input_date = '',Input_agency = '',Input_confidence = '',Input_clean_gsa_first = '',Input_clean_gsa_middle = '',Input_clean_gsa_last = '',Input_clean_gsa_suffix = '',Input_clean_gsa_city = '',Input_clean_gsa_state = '',Input_clean_gsa_zip = '',Input_clean_gsa_action_date = '',Input_clean_gsa_date = '',Input_fax = '',Input_phone = '',Input_certification_code = '',Input_certification_description = '',Input_board_code = '',Input_board_description = '',Input_expiration_year = '',Input_issue_year = '',Input_renewal_year = '',Input_lifetime_flag = '',Input_covered_recipient_id = '',Input_cov_rcp_raw_state_code = '',Input_cov_rcp_raw_full_name = '',Input_cov_rcp_raw_attribute1 = '',Input_cov_rcp_raw_attribute2 = '',Input_cov_rcp_raw_attribute3 = '',Input_cov_rcp_raw_attribute4 = '',Input_hms_scid = '',Input_school_name = '',Input_grad_year = '',Input_lang_code = '',Input_language = '',Input_specialty_description = '',Input_clean_phone = '',Input_bdid = '',Input_bdid_score = '',Input_did = '',Input_did_score = '',Input_clean_dob = '',Input_best_dob = '',Input_best_ssn = '',Input_rec_deactivated_date = '',Input_superceeding_piid = '',Input_dotid = '',Input_dotscore = '',Input_dotweight = '',Input_empid = '',Input_empscore = '',Input_empweight = '',Input_powid = '',Input_powscore = '',Input_powweight = '',Input_proxid = '',Input_proxscore = '',Input_proxweight = '',Input_seleid = '',Input_selescore = '',Input_seleweight = '',Input_orgid = '',Input_orgscore = '',Input_orgweight = '',Input_ultid = '',Input_ultscore = '',Input_ultweight = '',OutFile) := MACRO
  IMPORT SALT31,Scrubs_HMS;
  #uniquename(of)
  %of% := RECORD
    SALT31.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_hms_piid)='' )
      '' 
    #ELSE
        IF( le.Input_hms_piid = (TYPEOF(le.Input_hms_piid))'','',':hms_piid')
    #END
+    #IF( #TEXT(Input_first)='' )
      '' 
    #ELSE
        IF( le.Input_first = (TYPEOF(le.Input_first))'','',':first')
    #END
+    #IF( #TEXT(Input_middle)='' )
      '' 
    #ELSE
        IF( le.Input_middle = (TYPEOF(le.Input_middle))'','',':middle')
    #END
+    #IF( #TEXT(Input_last)='' )
      '' 
    #ELSE
        IF( le.Input_last = (TYPEOF(le.Input_last))'','',':last')
    #END
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
+    #IF( #TEXT(Input_cred)='' )
      '' 
    #ELSE
        IF( le.Input_cred = (TYPEOF(le.Input_cred))'','',':cred')
    #END
+    #IF( #TEXT(Input_practitioner_type)='' )
      '' 
    #ELSE
        IF( le.Input_practitioner_type = (TYPEOF(le.Input_practitioner_type))'','',':practitioner_type')
    #END
+    #IF( #TEXT(Input_active)='' )
      '' 
    #ELSE
        IF( le.Input_active = (TYPEOF(le.Input_active))'','',':active')
    #END
+    #IF( #TEXT(Input_vendible)='' )
      '' 
    #ELSE
        IF( le.Input_vendible = (TYPEOF(le.Input_vendible))'','',':vendible')
    #END
+    #IF( #TEXT(Input_npi_num)='' )
      '' 
    #ELSE
        IF( le.Input_npi_num = (TYPEOF(le.Input_npi_num))'','',':npi_num')
    #END
+    #IF( #TEXT(Input_npi_enumeration_date)='' )
      '' 
    #ELSE
        IF( le.Input_npi_enumeration_date = (TYPEOF(le.Input_npi_enumeration_date))'','',':npi_enumeration_date')
    #END
+    #IF( #TEXT(Input_npi_deactivation_date)='' )
      '' 
    #ELSE
        IF( le.Input_npi_deactivation_date = (TYPEOF(le.Input_npi_deactivation_date))'','',':npi_deactivation_date')
    #END
+    #IF( #TEXT(Input_npi_reactivation_date)='' )
      '' 
    #ELSE
        IF( le.Input_npi_reactivation_date = (TYPEOF(le.Input_npi_reactivation_date))'','',':npi_reactivation_date')
    #END
+    #IF( #TEXT(Input_npi_taxonomy_code)='' )
      '' 
    #ELSE
        IF( le.Input_npi_taxonomy_code = (TYPEOF(le.Input_npi_taxonomy_code))'','',':npi_taxonomy_code')
    #END
+    #IF( #TEXT(Input_upin)='' )
      '' 
    #ELSE
        IF( le.Input_upin = (TYPEOF(le.Input_upin))'','',':upin')
    #END
+    #IF( #TEXT(Input_medicare_participation_flag)='' )
      '' 
    #ELSE
        IF( le.Input_medicare_participation_flag = (TYPEOF(le.Input_medicare_participation_flag))'','',':medicare_participation_flag')
    #END
+    #IF( #TEXT(Input_date_born)='' )
      '' 
    #ELSE
        IF( le.Input_date_born = (TYPEOF(le.Input_date_born))'','',':date_born')
    #END
+    #IF( #TEXT(Input_date_died)='' )
      '' 
    #ELSE
        IF( le.Input_date_died = (TYPEOF(le.Input_date_died))'','',':date_died')
    #END
+    #IF( #TEXT(Input_pid)='' )
      '' 
    #ELSE
        IF( le.Input_pid = (TYPEOF(le.Input_pid))'','',':pid')
    #END
+    #IF( #TEXT(Input_src)='' )
      '' 
    #ELSE
        IF( le.Input_src = (TYPEOF(le.Input_src))'','',':src')
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
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
+    #IF( #TEXT(Input_source_rid)='' )
      '' 
    #ELSE
        IF( le.Input_source_rid = (TYPEOF(le.Input_source_rid))'','',':source_rid')
    #END
+    #IF( #TEXT(Input_lnpid)='' )
      '' 
    #ELSE
        IF( le.Input_lnpid = (TYPEOF(le.Input_lnpid))'','',':lnpid')
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
+    #IF( #TEXT(Input_nametype)='' )
      '' 
    #ELSE
        IF( le.Input_nametype = (TYPEOF(le.Input_nametype))'','',':nametype')
    #END
+    #IF( #TEXT(Input_nid)='' )
      '' 
    #ELSE
        IF( le.Input_nid = (TYPEOF(le.Input_nid))'','',':nid')
    #END
+    #IF( #TEXT(Input_clean_npi_enumeration_date)='' )
      '' 
    #ELSE
        IF( le.Input_clean_npi_enumeration_date = (TYPEOF(le.Input_clean_npi_enumeration_date))'','',':clean_npi_enumeration_date')
    #END
+    #IF( #TEXT(Input_clean_npi_deactivation_date)='' )
      '' 
    #ELSE
        IF( le.Input_clean_npi_deactivation_date = (TYPEOF(le.Input_clean_npi_deactivation_date))'','',':clean_npi_deactivation_date')
    #END
+    #IF( #TEXT(Input_clean_npi_reactivation_date)='' )
      '' 
    #ELSE
        IF( le.Input_clean_npi_reactivation_date = (TYPEOF(le.Input_clean_npi_reactivation_date))'','',':clean_npi_reactivation_date')
    #END
+    #IF( #TEXT(Input_clean_date_born)='' )
      '' 
    #ELSE
        IF( le.Input_clean_date_born = (TYPEOF(le.Input_clean_date_born))'','',':clean_date_born')
    #END
+    #IF( #TEXT(Input_clean_date_died)='' )
      '' 
    #ELSE
        IF( le.Input_clean_date_died = (TYPEOF(le.Input_clean_date_died))'','',':clean_date_died')
    #END
+    #IF( #TEXT(Input_clean_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_company_name = (TYPEOF(le.Input_clean_company_name))'','',':clean_company_name')
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
+    #IF( #TEXT(Input_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_fips_st = (TYPEOF(le.Input_fips_st))'','',':fips_st')
    #END
+    #IF( #TEXT(Input_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_fips_county = (TYPEOF(le.Input_fips_county))'','',':fips_county')
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
+    #IF( #TEXT(Input_firm_name)='' )
      '' 
    #ELSE
        IF( le.Input_firm_name = (TYPEOF(le.Input_firm_name))'','',':firm_name')
    #END
+    #IF( #TEXT(Input_lid)='' )
      '' 
    #ELSE
        IF( le.Input_lid = (TYPEOF(le.Input_lid))'','',':lid')
    #END
+    #IF( #TEXT(Input_agid)='' )
      '' 
    #ELSE
        IF( le.Input_agid = (TYPEOF(le.Input_agid))'','',':agid')
    #END
+    #IF( #TEXT(Input_address_std_code)='' )
      '' 
    #ELSE
        IF( le.Input_address_std_code = (TYPEOF(le.Input_address_std_code))'','',':address_std_code')
    #END
+    #IF( #TEXT(Input_latitude)='' )
      '' 
    #ELSE
        IF( le.Input_latitude = (TYPEOF(le.Input_latitude))'','',':latitude')
    #END
+    #IF( #TEXT(Input_longitude)='' )
      '' 
    #ELSE
        IF( le.Input_longitude = (TYPEOF(le.Input_longitude))'','',':longitude')
    #END
+    #IF( #TEXT(Input_prepped_addr1)='' )
      '' 
    #ELSE
        IF( le.Input_prepped_addr1 = (TYPEOF(le.Input_prepped_addr1))'','',':prepped_addr1')
    #END
+    #IF( #TEXT(Input_prepped_addr2)='' )
      '' 
    #ELSE
        IF( le.Input_prepped_addr2 = (TYPEOF(le.Input_prepped_addr2))'','',':prepped_addr2')
    #END
+    #IF( #TEXT(Input_addr_type)='' )
      '' 
    #ELSE
        IF( le.Input_addr_type = (TYPEOF(le.Input_addr_type))'','',':addr_type')
    #END
+    #IF( #TEXT(Input_state_license_state)='' )
      '' 
    #ELSE
        IF( le.Input_state_license_state = (TYPEOF(le.Input_state_license_state))'','',':state_license_state')
    #END
+    #IF( #TEXT(Input_state_license_number)='' )
      '' 
    #ELSE
        IF( le.Input_state_license_number = (TYPEOF(le.Input_state_license_number))'','',':state_license_number')
    #END
+    #IF( #TEXT(Input_state_license_type)='' )
      '' 
    #ELSE
        IF( le.Input_state_license_type = (TYPEOF(le.Input_state_license_type))'','',':state_license_type')
    #END
+    #IF( #TEXT(Input_state_license_active)='' )
      '' 
    #ELSE
        IF( le.Input_state_license_active = (TYPEOF(le.Input_state_license_active))'','',':state_license_active')
    #END
+    #IF( #TEXT(Input_state_license_expire)='' )
      '' 
    #ELSE
        IF( le.Input_state_license_expire = (TYPEOF(le.Input_state_license_expire))'','',':state_license_expire')
    #END
+    #IF( #TEXT(Input_state_license_qualifier)='' )
      '' 
    #ELSE
        IF( le.Input_state_license_qualifier = (TYPEOF(le.Input_state_license_qualifier))'','',':state_license_qualifier')
    #END
+    #IF( #TEXT(Input_state_license_sub_qualifier)='' )
      '' 
    #ELSE
        IF( le.Input_state_license_sub_qualifier = (TYPEOF(le.Input_state_license_sub_qualifier))'','',':state_license_sub_qualifier')
    #END
+    #IF( #TEXT(Input_state_license_issued)='' )
      '' 
    #ELSE
        IF( le.Input_state_license_issued = (TYPEOF(le.Input_state_license_issued))'','',':state_license_issued')
    #END
+    #IF( #TEXT(Input_clean_state_license_expire)='' )
      '' 
    #ELSE
        IF( le.Input_clean_state_license_expire = (TYPEOF(le.Input_clean_state_license_expire))'','',':clean_state_license_expire')
    #END
+    #IF( #TEXT(Input_clean_state_license_issued)='' )
      '' 
    #ELSE
        IF( le.Input_clean_state_license_issued = (TYPEOF(le.Input_clean_state_license_issued))'','',':clean_state_license_issued')
    #END
+    #IF( #TEXT(Input_dea_num)='' )
      '' 
    #ELSE
        IF( le.Input_dea_num = (TYPEOF(le.Input_dea_num))'','',':dea_num')
    #END
+    #IF( #TEXT(Input_dea_bac)='' )
      '' 
    #ELSE
        IF( le.Input_dea_bac = (TYPEOF(le.Input_dea_bac))'','',':dea_bac')
    #END
+    #IF( #TEXT(Input_dea_sub_bac)='' )
      '' 
    #ELSE
        IF( le.Input_dea_sub_bac = (TYPEOF(le.Input_dea_sub_bac))'','',':dea_sub_bac')
    #END
+    #IF( #TEXT(Input_dea_schedule)='' )
      '' 
    #ELSE
        IF( le.Input_dea_schedule = (TYPEOF(le.Input_dea_schedule))'','',':dea_schedule')
    #END
+    #IF( #TEXT(Input_dea_expire)='' )
      '' 
    #ELSE
        IF( le.Input_dea_expire = (TYPEOF(le.Input_dea_expire))'','',':dea_expire')
    #END
+    #IF( #TEXT(Input_dea_active)='' )
      '' 
    #ELSE
        IF( le.Input_dea_active = (TYPEOF(le.Input_dea_active))'','',':dea_active')
    #END
+    #IF( #TEXT(Input_clean_dea_expire)='' )
      '' 
    #ELSE
        IF( le.Input_clean_dea_expire = (TYPEOF(le.Input_clean_dea_expire))'','',':clean_dea_expire')
    #END
+    #IF( #TEXT(Input_csr_number)='' )
      '' 
    #ELSE
        IF( le.Input_csr_number = (TYPEOF(le.Input_csr_number))'','',':csr_number')
    #END
+    #IF( #TEXT(Input_csr_state)='' )
      '' 
    #ELSE
        IF( le.Input_csr_state = (TYPEOF(le.Input_csr_state))'','',':csr_state')
    #END
+    #IF( #TEXT(Input_csr_expire_date)='' )
      '' 
    #ELSE
        IF( le.Input_csr_expire_date = (TYPEOF(le.Input_csr_expire_date))'','',':csr_expire_date')
    #END
+    #IF( #TEXT(Input_csr_issue_date)='' )
      '' 
    #ELSE
        IF( le.Input_csr_issue_date = (TYPEOF(le.Input_csr_issue_date))'','',':csr_issue_date')
    #END
+    #IF( #TEXT(Input_dsa_lvl_2)='' )
      '' 
    #ELSE
        IF( le.Input_dsa_lvl_2 = (TYPEOF(le.Input_dsa_lvl_2))'','',':dsa_lvl_2')
    #END
+    #IF( #TEXT(Input_dsa_lvl_2n)='' )
      '' 
    #ELSE
        IF( le.Input_dsa_lvl_2n = (TYPEOF(le.Input_dsa_lvl_2n))'','',':dsa_lvl_2n')
    #END
+    #IF( #TEXT(Input_dsa_lvl_3)='' )
      '' 
    #ELSE
        IF( le.Input_dsa_lvl_3 = (TYPEOF(le.Input_dsa_lvl_3))'','',':dsa_lvl_3')
    #END
+    #IF( #TEXT(Input_dsa_lvl_3n)='' )
      '' 
    #ELSE
        IF( le.Input_dsa_lvl_3n = (TYPEOF(le.Input_dsa_lvl_3n))'','',':dsa_lvl_3n')
    #END
+    #IF( #TEXT(Input_dsa_lvl_4)='' )
      '' 
    #ELSE
        IF( le.Input_dsa_lvl_4 = (TYPEOF(le.Input_dsa_lvl_4))'','',':dsa_lvl_4')
    #END
+    #IF( #TEXT(Input_dsa_lvl_5)='' )
      '' 
    #ELSE
        IF( le.Input_dsa_lvl_5 = (TYPEOF(le.Input_dsa_lvl_5))'','',':dsa_lvl_5')
    #END
+    #IF( #TEXT(Input_csr_raw1)='' )
      '' 
    #ELSE
        IF( le.Input_csr_raw1 = (TYPEOF(le.Input_csr_raw1))'','',':csr_raw1')
    #END
+    #IF( #TEXT(Input_csr_raw2)='' )
      '' 
    #ELSE
        IF( le.Input_csr_raw2 = (TYPEOF(le.Input_csr_raw2))'','',':csr_raw2')
    #END
+    #IF( #TEXT(Input_csr_raw3)='' )
      '' 
    #ELSE
        IF( le.Input_csr_raw3 = (TYPEOF(le.Input_csr_raw3))'','',':csr_raw3')
    #END
+    #IF( #TEXT(Input_csr_raw4)='' )
      '' 
    #ELSE
        IF( le.Input_csr_raw4 = (TYPEOF(le.Input_csr_raw4))'','',':csr_raw4')
    #END
+    #IF( #TEXT(Input_clean_csr_expire_date)='' )
      '' 
    #ELSE
        IF( le.Input_clean_csr_expire_date = (TYPEOF(le.Input_clean_csr_expire_date))'','',':clean_csr_expire_date')
    #END
+    #IF( #TEXT(Input_clean_csr_issue_date)='' )
      '' 
    #ELSE
        IF( le.Input_clean_csr_issue_date = (TYPEOF(le.Input_clean_csr_issue_date))'','',':clean_csr_issue_date')
    #END
+    #IF( #TEXT(Input_sanction_id)='' )
      '' 
    #ELSE
        IF( le.Input_sanction_id = (TYPEOF(le.Input_sanction_id))'','',':sanction_id')
    #END
+    #IF( #TEXT(Input_sanction_action_code)='' )
      '' 
    #ELSE
        IF( le.Input_sanction_action_code = (TYPEOF(le.Input_sanction_action_code))'','',':sanction_action_code')
    #END
+    #IF( #TEXT(Input_sanction_action_description)='' )
      '' 
    #ELSE
        IF( le.Input_sanction_action_description = (TYPEOF(le.Input_sanction_action_description))'','',':sanction_action_description')
    #END
+    #IF( #TEXT(Input_sanction_board_code)='' )
      '' 
    #ELSE
        IF( le.Input_sanction_board_code = (TYPEOF(le.Input_sanction_board_code))'','',':sanction_board_code')
    #END
+    #IF( #TEXT(Input_sanction_board_description)='' )
      '' 
    #ELSE
        IF( le.Input_sanction_board_description = (TYPEOF(le.Input_sanction_board_description))'','',':sanction_board_description')
    #END
+    #IF( #TEXT(Input_action_date)='' )
      '' 
    #ELSE
        IF( le.Input_action_date = (TYPEOF(le.Input_action_date))'','',':action_date')
    #END
+    #IF( #TEXT(Input_sanction_period_start_date)='' )
      '' 
    #ELSE
        IF( le.Input_sanction_period_start_date = (TYPEOF(le.Input_sanction_period_start_date))'','',':sanction_period_start_date')
    #END
+    #IF( #TEXT(Input_sanction_period_end_date)='' )
      '' 
    #ELSE
        IF( le.Input_sanction_period_end_date = (TYPEOF(le.Input_sanction_period_end_date))'','',':sanction_period_end_date')
    #END
+    #IF( #TEXT(Input_month_duration)='' )
      '' 
    #ELSE
        IF( le.Input_month_duration = (TYPEOF(le.Input_month_duration))'','',':month_duration')
    #END
+    #IF( #TEXT(Input_fine_amount)='' )
      '' 
    #ELSE
        IF( le.Input_fine_amount = (TYPEOF(le.Input_fine_amount))'','',':fine_amount')
    #END
+    #IF( #TEXT(Input_offense_code)='' )
      '' 
    #ELSE
        IF( le.Input_offense_code = (TYPEOF(le.Input_offense_code))'','',':offense_code')
    #END
+    #IF( #TEXT(Input_offense_description)='' )
      '' 
    #ELSE
        IF( le.Input_offense_description = (TYPEOF(le.Input_offense_description))'','',':offense_description')
    #END
+    #IF( #TEXT(Input_offense_date)='' )
      '' 
    #ELSE
        IF( le.Input_offense_date = (TYPEOF(le.Input_offense_date))'','',':offense_date')
    #END
+    #IF( #TEXT(Input_clean_offense_date)='' )
      '' 
    #ELSE
        IF( le.Input_clean_offense_date = (TYPEOF(le.Input_clean_offense_date))'','',':clean_offense_date')
    #END
+    #IF( #TEXT(Input_clean_action_date)='' )
      '' 
    #ELSE
        IF( le.Input_clean_action_date = (TYPEOF(le.Input_clean_action_date))'','',':clean_action_date')
    #END
+    #IF( #TEXT(Input_clean_sanction_period_start_date)='' )
      '' 
    #ELSE
        IF( le.Input_clean_sanction_period_start_date = (TYPEOF(le.Input_clean_sanction_period_start_date))'','',':clean_sanction_period_start_date')
    #END
+    #IF( #TEXT(Input_clean_sanction_period_end_date)='' )
      '' 
    #ELSE
        IF( le.Input_clean_sanction_period_end_date = (TYPEOF(le.Input_clean_sanction_period_end_date))'','',':clean_sanction_period_end_date')
    #END
+    #IF( #TEXT(Input_gsa_sanction_id)='' )
      '' 
    #ELSE
        IF( le.Input_gsa_sanction_id = (TYPEOF(le.Input_gsa_sanction_id))'','',':gsa_sanction_id')
    #END
+    #IF( #TEXT(Input_gsa_first)='' )
      '' 
    #ELSE
        IF( le.Input_gsa_first = (TYPEOF(le.Input_gsa_first))'','',':gsa_first')
    #END
+    #IF( #TEXT(Input_gsa_middle)='' )
      '' 
    #ELSE
        IF( le.Input_gsa_middle = (TYPEOF(le.Input_gsa_middle))'','',':gsa_middle')
    #END
+    #IF( #TEXT(Input_gsa_last)='' )
      '' 
    #ELSE
        IF( le.Input_gsa_last = (TYPEOF(le.Input_gsa_last))'','',':gsa_last')
    #END
+    #IF( #TEXT(Input_gsa_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_gsa_suffix = (TYPEOF(le.Input_gsa_suffix))'','',':gsa_suffix')
    #END
+    #IF( #TEXT(Input_gsa_city)='' )
      '' 
    #ELSE
        IF( le.Input_gsa_city = (TYPEOF(le.Input_gsa_city))'','',':gsa_city')
    #END
+    #IF( #TEXT(Input_gsa_state)='' )
      '' 
    #ELSE
        IF( le.Input_gsa_state = (TYPEOF(le.Input_gsa_state))'','',':gsa_state')
    #END
+    #IF( #TEXT(Input_gsa_zip)='' )
      '' 
    #ELSE
        IF( le.Input_gsa_zip = (TYPEOF(le.Input_gsa_zip))'','',':gsa_zip')
    #END
+    #IF( #TEXT(Input_date)='' )
      '' 
    #ELSE
        IF( le.Input_date = (TYPEOF(le.Input_date))'','',':date')
    #END
+    #IF( #TEXT(Input_agency)='' )
      '' 
    #ELSE
        IF( le.Input_agency = (TYPEOF(le.Input_agency))'','',':agency')
    #END
+    #IF( #TEXT(Input_confidence)='' )
      '' 
    #ELSE
        IF( le.Input_confidence = (TYPEOF(le.Input_confidence))'','',':confidence')
    #END
+    #IF( #TEXT(Input_clean_gsa_first)='' )
      '' 
    #ELSE
        IF( le.Input_clean_gsa_first = (TYPEOF(le.Input_clean_gsa_first))'','',':clean_gsa_first')
    #END
+    #IF( #TEXT(Input_clean_gsa_middle)='' )
      '' 
    #ELSE
        IF( le.Input_clean_gsa_middle = (TYPEOF(le.Input_clean_gsa_middle))'','',':clean_gsa_middle')
    #END
+    #IF( #TEXT(Input_clean_gsa_last)='' )
      '' 
    #ELSE
        IF( le.Input_clean_gsa_last = (TYPEOF(le.Input_clean_gsa_last))'','',':clean_gsa_last')
    #END
+    #IF( #TEXT(Input_clean_gsa_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_gsa_suffix = (TYPEOF(le.Input_clean_gsa_suffix))'','',':clean_gsa_suffix')
    #END
+    #IF( #TEXT(Input_clean_gsa_city)='' )
      '' 
    #ELSE
        IF( le.Input_clean_gsa_city = (TYPEOF(le.Input_clean_gsa_city))'','',':clean_gsa_city')
    #END
+    #IF( #TEXT(Input_clean_gsa_state)='' )
      '' 
    #ELSE
        IF( le.Input_clean_gsa_state = (TYPEOF(le.Input_clean_gsa_state))'','',':clean_gsa_state')
    #END
+    #IF( #TEXT(Input_clean_gsa_zip)='' )
      '' 
    #ELSE
        IF( le.Input_clean_gsa_zip = (TYPEOF(le.Input_clean_gsa_zip))'','',':clean_gsa_zip')
    #END
+    #IF( #TEXT(Input_clean_gsa_action_date)='' )
      '' 
    #ELSE
        IF( le.Input_clean_gsa_action_date = (TYPEOF(le.Input_clean_gsa_action_date))'','',':clean_gsa_action_date')
    #END
+    #IF( #TEXT(Input_clean_gsa_date)='' )
      '' 
    #ELSE
        IF( le.Input_clean_gsa_date = (TYPEOF(le.Input_clean_gsa_date))'','',':clean_gsa_date')
    #END
+    #IF( #TEXT(Input_fax)='' )
      '' 
    #ELSE
        IF( le.Input_fax = (TYPEOF(le.Input_fax))'','',':fax')
    #END
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
+    #IF( #TEXT(Input_certification_code)='' )
      '' 
    #ELSE
        IF( le.Input_certification_code = (TYPEOF(le.Input_certification_code))'','',':certification_code')
    #END
+    #IF( #TEXT(Input_certification_description)='' )
      '' 
    #ELSE
        IF( le.Input_certification_description = (TYPEOF(le.Input_certification_description))'','',':certification_description')
    #END
+    #IF( #TEXT(Input_board_code)='' )
      '' 
    #ELSE
        IF( le.Input_board_code = (TYPEOF(le.Input_board_code))'','',':board_code')
    #END
+    #IF( #TEXT(Input_board_description)='' )
      '' 
    #ELSE
        IF( le.Input_board_description = (TYPEOF(le.Input_board_description))'','',':board_description')
    #END
+    #IF( #TEXT(Input_expiration_year)='' )
      '' 
    #ELSE
        IF( le.Input_expiration_year = (TYPEOF(le.Input_expiration_year))'','',':expiration_year')
    #END
+    #IF( #TEXT(Input_issue_year)='' )
      '' 
    #ELSE
        IF( le.Input_issue_year = (TYPEOF(le.Input_issue_year))'','',':issue_year')
    #END
+    #IF( #TEXT(Input_renewal_year)='' )
      '' 
    #ELSE
        IF( le.Input_renewal_year = (TYPEOF(le.Input_renewal_year))'','',':renewal_year')
    #END
+    #IF( #TEXT(Input_lifetime_flag)='' )
      '' 
    #ELSE
        IF( le.Input_lifetime_flag = (TYPEOF(le.Input_lifetime_flag))'','',':lifetime_flag')
    #END
+    #IF( #TEXT(Input_covered_recipient_id)='' )
      '' 
    #ELSE
        IF( le.Input_covered_recipient_id = (TYPEOF(le.Input_covered_recipient_id))'','',':covered_recipient_id')
    #END
+    #IF( #TEXT(Input_cov_rcp_raw_state_code)='' )
      '' 
    #ELSE
        IF( le.Input_cov_rcp_raw_state_code = (TYPEOF(le.Input_cov_rcp_raw_state_code))'','',':cov_rcp_raw_state_code')
    #END
+    #IF( #TEXT(Input_cov_rcp_raw_full_name)='' )
      '' 
    #ELSE
        IF( le.Input_cov_rcp_raw_full_name = (TYPEOF(le.Input_cov_rcp_raw_full_name))'','',':cov_rcp_raw_full_name')
    #END
+    #IF( #TEXT(Input_cov_rcp_raw_attribute1)='' )
      '' 
    #ELSE
        IF( le.Input_cov_rcp_raw_attribute1 = (TYPEOF(le.Input_cov_rcp_raw_attribute1))'','',':cov_rcp_raw_attribute1')
    #END
+    #IF( #TEXT(Input_cov_rcp_raw_attribute2)='' )
      '' 
    #ELSE
        IF( le.Input_cov_rcp_raw_attribute2 = (TYPEOF(le.Input_cov_rcp_raw_attribute2))'','',':cov_rcp_raw_attribute2')
    #END
+    #IF( #TEXT(Input_cov_rcp_raw_attribute3)='' )
      '' 
    #ELSE
        IF( le.Input_cov_rcp_raw_attribute3 = (TYPEOF(le.Input_cov_rcp_raw_attribute3))'','',':cov_rcp_raw_attribute3')
    #END
+    #IF( #TEXT(Input_cov_rcp_raw_attribute4)='' )
      '' 
    #ELSE
        IF( le.Input_cov_rcp_raw_attribute4 = (TYPEOF(le.Input_cov_rcp_raw_attribute4))'','',':cov_rcp_raw_attribute4')
    #END
+    #IF( #TEXT(Input_hms_scid)='' )
      '' 
    #ELSE
        IF( le.Input_hms_scid = (TYPEOF(le.Input_hms_scid))'','',':hms_scid')
    #END
+    #IF( #TEXT(Input_school_name)='' )
      '' 
    #ELSE
        IF( le.Input_school_name = (TYPEOF(le.Input_school_name))'','',':school_name')
    #END
+    #IF( #TEXT(Input_grad_year)='' )
      '' 
    #ELSE
        IF( le.Input_grad_year = (TYPEOF(le.Input_grad_year))'','',':grad_year')
    #END
+    #IF( #TEXT(Input_lang_code)='' )
      '' 
    #ELSE
        IF( le.Input_lang_code = (TYPEOF(le.Input_lang_code))'','',':lang_code')
    #END
+    #IF( #TEXT(Input_language)='' )
      '' 
    #ELSE
        IF( le.Input_language = (TYPEOF(le.Input_language))'','',':language')
    #END
+    #IF( #TEXT(Input_specialty_description)='' )
      '' 
    #ELSE
        IF( le.Input_specialty_description = (TYPEOF(le.Input_specialty_description))'','',':specialty_description')
    #END
+    #IF( #TEXT(Input_clean_phone)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phone = (TYPEOF(le.Input_clean_phone))'','',':clean_phone')
    #END
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
+    #IF( #TEXT(Input_bdid_score)='' )
      '' 
    #ELSE
        IF( le.Input_bdid_score = (TYPEOF(le.Input_bdid_score))'','',':bdid_score')
    #END
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
+    #IF( #TEXT(Input_did_score)='' )
      '' 
    #ELSE
        IF( le.Input_did_score = (TYPEOF(le.Input_did_score))'','',':did_score')
    #END
+    #IF( #TEXT(Input_clean_dob)='' )
      '' 
    #ELSE
        IF( le.Input_clean_dob = (TYPEOF(le.Input_clean_dob))'','',':clean_dob')
    #END
+    #IF( #TEXT(Input_best_dob)='' )
      '' 
    #ELSE
        IF( le.Input_best_dob = (TYPEOF(le.Input_best_dob))'','',':best_dob')
    #END
+    #IF( #TEXT(Input_best_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_best_ssn = (TYPEOF(le.Input_best_ssn))'','',':best_ssn')
    #END
+    #IF( #TEXT(Input_rec_deactivated_date)='' )
      '' 
    #ELSE
        IF( le.Input_rec_deactivated_date = (TYPEOF(le.Input_rec_deactivated_date))'','',':rec_deactivated_date')
    #END
+    #IF( #TEXT(Input_superceeding_piid)='' )
      '' 
    #ELSE
        IF( le.Input_superceeding_piid = (TYPEOF(le.Input_superceeding_piid))'','',':superceeding_piid')
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
