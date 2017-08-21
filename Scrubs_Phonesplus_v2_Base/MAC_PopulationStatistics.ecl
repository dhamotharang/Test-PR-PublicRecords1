EXPORT MAC_PopulationStatistics(infile,Ref='',vendor='',Input_in_flag = '',Input_confidencescore = '',Input_rules = '',Input_npa = '',Input_phone7 = '',Input_cellphone = '',Input_cellphoneidkey = '',Input_phone7_did_key = '',Input_pdid = '',Input_did = '',Input_did_score = '',Input_datefirstseen = '',Input_datelastseen = '',Input_datevendorlastreported = '',Input_datevendorfirstreported = '',Input_dt_nonglb_last_seen = '',Input_glb_dppa_flag = '',Input_glb_dppa_all = '',Input_vendor = '',Input_src = '',Input_src_all = '',Input_src_cnt = '',Input_src_rule = '',Input_append_avg_source_conf = '',Input_append_max_source_conf = '',Input_append_min_source_conf = '',Input_append_total_source_conf = '',Input_orig_dt_last_seen = '',Input_did_type = '',Input_origname = '',Input_address1 = '',Input_address2 = '',Input_address3 = '',Input_origcity = '',Input_origstate = '',Input_origzip = '',Input_orig_phone = '',Input_dob = '',Input_agegroup = '',Input_gender = '',Input_email = '',Input_orig_listing_type = '',Input_listingtype = '',Input_orig_publish_code = '',Input_orig_phone_type = '',Input_orig_phone_usage = '',Input_company = '',Input_orig_phone_reg_dt = '',Input_orig_carrier_code = '',Input_orig_carrier_name = '',Input_orig_conf_score = '',Input_orig_rec_type = '',Input_clean_company = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_state = '',Input_zip5 = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dpbc = '',Input_chk_digit = '',Input_rec_type = '',Input_ace_fips_st = '',Input_ace_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_bdid = '',Input_bdid_score = '',Input_append_npa_effective_dt = '',Input_append_npa_last_change_dt = '',Input_append_dialable_ind = '',Input_append_place_name = '',Input_append_portability_indicator = '',Input_append_prior_area_code = '',Input_append_nonpublished_match = '',Input_append_ocn = '',Input_append_time_zone = '',Input_append_nxx_type = '',Input_append_coctype = '',Input_append_scc = '',Input_append_phone_type = '',Input_append_company_type = '',Input_append_phone_use = '',Input_agreg_listing_type = '',Input_max_orig_conf_score = '',Input_min_orig_conf_score = '',Input_cur_orig_conf_score = '',Input_activeflag = '',Input_eda_active_flag = '',Input_eda_match = '',Input_eda_phone_dt = '',Input_eda_did_dt = '',Input_eda_nm_addr_dt = '',Input_eda_hist_match = '',Input_eda_hist_phone_dt = '',Input_eda_hist_did_dt = '',Input_eda_hist_nm_addr_dt = '',Input_append_feedback_phone = '',Input_append_feedback_phone_dt = '',Input_append_feedback_phone7_did = '',Input_append_feedback_phone7_did_dt = '',Input_append_feedback_phone7_nm_addr = '',Input_append_feedback_phone7_nm_addr_dt = '',Input_append_ported_match = '',Input_append_seen_once_ind = '',Input_append_indiv_phone_cnt = '',Input_append_indiv_has_active_eda_phone_flag = '',Input_append_latest_phone_owner_flag = '',Input_hhid = '',Input_hhid_score = '',Input_phone7_hhid_key = '',Input_append_best_addr_match_flag = '',Input_append_best_nm_match_flag = '',Input_rawaid = '',Input_cleanaid = '',Input_current_rec = '',Input_first_build_date = '',Input_last_build_date = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_Phonesplus_v2_Base;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(vendor)<>'')
    SALT30.StrType source;
    #END
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_in_flag)='' )
      '' 
    #ELSE
        IF( le.Input_in_flag = (TYPEOF(le.Input_in_flag))'','',':in_flag')
    #END
+    #IF( #TEXT(Input_confidencescore)='' )
      '' 
    #ELSE
        IF( le.Input_confidencescore = (TYPEOF(le.Input_confidencescore))'','',':confidencescore')
    #END
+    #IF( #TEXT(Input_rules)='' )
      '' 
    #ELSE
        IF( le.Input_rules = (TYPEOF(le.Input_rules))'','',':rules')
    #END
+    #IF( #TEXT(Input_npa)='' )
      '' 
    #ELSE
        IF( le.Input_npa = (TYPEOF(le.Input_npa))'','',':npa')
    #END
+    #IF( #TEXT(Input_phone7)='' )
      '' 
    #ELSE
        IF( le.Input_phone7 = (TYPEOF(le.Input_phone7))'','',':phone7')
    #END
+    #IF( #TEXT(Input_cellphone)='' )
      '' 
    #ELSE
        IF( le.Input_cellphone = (TYPEOF(le.Input_cellphone))'','',':cellphone')
    #END
+    #IF( #TEXT(Input_cellphoneidkey)='' )
      '' 
    #ELSE
        IF( le.Input_cellphoneidkey = (TYPEOF(le.Input_cellphoneidkey))'','',':cellphoneidkey')
    #END
+    #IF( #TEXT(Input_phone7_did_key)='' )
      '' 
    #ELSE
        IF( le.Input_phone7_did_key = (TYPEOF(le.Input_phone7_did_key))'','',':phone7_did_key')
    #END
+    #IF( #TEXT(Input_pdid)='' )
      '' 
    #ELSE
        IF( le.Input_pdid = (TYPEOF(le.Input_pdid))'','',':pdid')
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
+    #IF( #TEXT(Input_datefirstseen)='' )
      '' 
    #ELSE
        IF( le.Input_datefirstseen = (TYPEOF(le.Input_datefirstseen))'','',':datefirstseen')
    #END
+    #IF( #TEXT(Input_datelastseen)='' )
      '' 
    #ELSE
        IF( le.Input_datelastseen = (TYPEOF(le.Input_datelastseen))'','',':datelastseen')
    #END
+    #IF( #TEXT(Input_datevendorlastreported)='' )
      '' 
    #ELSE
        IF( le.Input_datevendorlastreported = (TYPEOF(le.Input_datevendorlastreported))'','',':datevendorlastreported')
    #END
+    #IF( #TEXT(Input_datevendorfirstreported)='' )
      '' 
    #ELSE
        IF( le.Input_datevendorfirstreported = (TYPEOF(le.Input_datevendorfirstreported))'','',':datevendorfirstreported')
    #END
+    #IF( #TEXT(Input_dt_nonglb_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_nonglb_last_seen = (TYPEOF(le.Input_dt_nonglb_last_seen))'','',':dt_nonglb_last_seen')
    #END
+    #IF( #TEXT(Input_glb_dppa_flag)='' )
      '' 
    #ELSE
        IF( le.Input_glb_dppa_flag = (TYPEOF(le.Input_glb_dppa_flag))'','',':glb_dppa_flag')
    #END
+    #IF( #TEXT(Input_glb_dppa_all)='' )
      '' 
    #ELSE
        IF( le.Input_glb_dppa_all = (TYPEOF(le.Input_glb_dppa_all))'','',':glb_dppa_all')
    #END
+    #IF( #TEXT(Input_vendor)='' )
      '' 
    #ELSE
        IF( le.Input_vendor = (TYPEOF(le.Input_vendor))'','',':vendor')
    #END
+    #IF( #TEXT(Input_src)='' )
      '' 
    #ELSE
        IF( le.Input_src = (TYPEOF(le.Input_src))'','',':src')
    #END
+    #IF( #TEXT(Input_src_all)='' )
      '' 
    #ELSE
        IF( le.Input_src_all = (TYPEOF(le.Input_src_all))'','',':src_all')
    #END
+    #IF( #TEXT(Input_src_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_src_cnt = (TYPEOF(le.Input_src_cnt))'','',':src_cnt')
    #END
+    #IF( #TEXT(Input_src_rule)='' )
      '' 
    #ELSE
        IF( le.Input_src_rule = (TYPEOF(le.Input_src_rule))'','',':src_rule')
    #END
+    #IF( #TEXT(Input_append_avg_source_conf)='' )
      '' 
    #ELSE
        IF( le.Input_append_avg_source_conf = (TYPEOF(le.Input_append_avg_source_conf))'','',':append_avg_source_conf')
    #END
+    #IF( #TEXT(Input_append_max_source_conf)='' )
      '' 
    #ELSE
        IF( le.Input_append_max_source_conf = (TYPEOF(le.Input_append_max_source_conf))'','',':append_max_source_conf')
    #END
+    #IF( #TEXT(Input_append_min_source_conf)='' )
      '' 
    #ELSE
        IF( le.Input_append_min_source_conf = (TYPEOF(le.Input_append_min_source_conf))'','',':append_min_source_conf')
    #END
+    #IF( #TEXT(Input_append_total_source_conf)='' )
      '' 
    #ELSE
        IF( le.Input_append_total_source_conf = (TYPEOF(le.Input_append_total_source_conf))'','',':append_total_source_conf')
    #END
+    #IF( #TEXT(Input_orig_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dt_last_seen = (TYPEOF(le.Input_orig_dt_last_seen))'','',':orig_dt_last_seen')
    #END
+    #IF( #TEXT(Input_did_type)='' )
      '' 
    #ELSE
        IF( le.Input_did_type = (TYPEOF(le.Input_did_type))'','',':did_type')
    #END
+    #IF( #TEXT(Input_origname)='' )
      '' 
    #ELSE
        IF( le.Input_origname = (TYPEOF(le.Input_origname))'','',':origname')
    #END
+    #IF( #TEXT(Input_address1)='' )
      '' 
    #ELSE
        IF( le.Input_address1 = (TYPEOF(le.Input_address1))'','',':address1')
    #END
+    #IF( #TEXT(Input_address2)='' )
      '' 
    #ELSE
        IF( le.Input_address2 = (TYPEOF(le.Input_address2))'','',':address2')
    #END
+    #IF( #TEXT(Input_address3)='' )
      '' 
    #ELSE
        IF( le.Input_address3 = (TYPEOF(le.Input_address3))'','',':address3')
    #END
+    #IF( #TEXT(Input_origcity)='' )
      '' 
    #ELSE
        IF( le.Input_origcity = (TYPEOF(le.Input_origcity))'','',':origcity')
    #END
+    #IF( #TEXT(Input_origstate)='' )
      '' 
    #ELSE
        IF( le.Input_origstate = (TYPEOF(le.Input_origstate))'','',':origstate')
    #END
+    #IF( #TEXT(Input_origzip)='' )
      '' 
    #ELSE
        IF( le.Input_origzip = (TYPEOF(le.Input_origzip))'','',':origzip')
    #END
+    #IF( #TEXT(Input_orig_phone)='' )
      '' 
    #ELSE
        IF( le.Input_orig_phone = (TYPEOF(le.Input_orig_phone))'','',':orig_phone')
    #END
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
+    #IF( #TEXT(Input_agegroup)='' )
      '' 
    #ELSE
        IF( le.Input_agegroup = (TYPEOF(le.Input_agegroup))'','',':agegroup')
    #END
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
+    #IF( #TEXT(Input_email)='' )
      '' 
    #ELSE
        IF( le.Input_email = (TYPEOF(le.Input_email))'','',':email')
    #END
+    #IF( #TEXT(Input_orig_listing_type)='' )
      '' 
    #ELSE
        IF( le.Input_orig_listing_type = (TYPEOF(le.Input_orig_listing_type))'','',':orig_listing_type')
    #END
+    #IF( #TEXT(Input_listingtype)='' )
      '' 
    #ELSE
        IF( le.Input_listingtype = (TYPEOF(le.Input_listingtype))'','',':listingtype')
    #END
+    #IF( #TEXT(Input_orig_publish_code)='' )
      '' 
    #ELSE
        IF( le.Input_orig_publish_code = (TYPEOF(le.Input_orig_publish_code))'','',':orig_publish_code')
    #END
+    #IF( #TEXT(Input_orig_phone_type)='' )
      '' 
    #ELSE
        IF( le.Input_orig_phone_type = (TYPEOF(le.Input_orig_phone_type))'','',':orig_phone_type')
    #END
+    #IF( #TEXT(Input_orig_phone_usage)='' )
      '' 
    #ELSE
        IF( le.Input_orig_phone_usage = (TYPEOF(le.Input_orig_phone_usage))'','',':orig_phone_usage')
    #END
+    #IF( #TEXT(Input_company)='' )
      '' 
    #ELSE
        IF( le.Input_company = (TYPEOF(le.Input_company))'','',':company')
    #END
+    #IF( #TEXT(Input_orig_phone_reg_dt)='' )
      '' 
    #ELSE
        IF( le.Input_orig_phone_reg_dt = (TYPEOF(le.Input_orig_phone_reg_dt))'','',':orig_phone_reg_dt')
    #END
+    #IF( #TEXT(Input_orig_carrier_code)='' )
      '' 
    #ELSE
        IF( le.Input_orig_carrier_code = (TYPEOF(le.Input_orig_carrier_code))'','',':orig_carrier_code')
    #END
+    #IF( #TEXT(Input_orig_carrier_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_carrier_name = (TYPEOF(le.Input_orig_carrier_name))'','',':orig_carrier_name')
    #END
+    #IF( #TEXT(Input_orig_conf_score)='' )
      '' 
    #ELSE
        IF( le.Input_orig_conf_score = (TYPEOF(le.Input_orig_conf_score))'','',':orig_conf_score')
    #END
+    #IF( #TEXT(Input_orig_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_orig_rec_type = (TYPEOF(le.Input_orig_rec_type))'','',':orig_rec_type')
    #END
+    #IF( #TEXT(Input_clean_company)='' )
      '' 
    #ELSE
        IF( le.Input_clean_company = (TYPEOF(le.Input_clean_company))'','',':clean_company')
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
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
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
+    #IF( #TEXT(Input_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_rec_type = (TYPEOF(le.Input_rec_type))'','',':rec_type')
    #END
+    #IF( #TEXT(Input_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_ace_fips_st = (TYPEOF(le.Input_ace_fips_st))'','',':ace_fips_st')
    #END
+    #IF( #TEXT(Input_ace_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_ace_fips_county = (TYPEOF(le.Input_ace_fips_county))'','',':ace_fips_county')
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
+    #IF( #TEXT(Input_name_score)='' )
      '' 
    #ELSE
        IF( le.Input_name_score = (TYPEOF(le.Input_name_score))'','',':name_score')
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
+    #IF( #TEXT(Input_append_npa_effective_dt)='' )
      '' 
    #ELSE
        IF( le.Input_append_npa_effective_dt = (TYPEOF(le.Input_append_npa_effective_dt))'','',':append_npa_effective_dt')
    #END
+    #IF( #TEXT(Input_append_npa_last_change_dt)='' )
      '' 
    #ELSE
        IF( le.Input_append_npa_last_change_dt = (TYPEOF(le.Input_append_npa_last_change_dt))'','',':append_npa_last_change_dt')
    #END
+    #IF( #TEXT(Input_append_dialable_ind)='' )
      '' 
    #ELSE
        IF( le.Input_append_dialable_ind = (TYPEOF(le.Input_append_dialable_ind))'','',':append_dialable_ind')
    #END
+    #IF( #TEXT(Input_append_place_name)='' )
      '' 
    #ELSE
        IF( le.Input_append_place_name = (TYPEOF(le.Input_append_place_name))'','',':append_place_name')
    #END
+    #IF( #TEXT(Input_append_portability_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_append_portability_indicator = (TYPEOF(le.Input_append_portability_indicator))'','',':append_portability_indicator')
    #END
+    #IF( #TEXT(Input_append_prior_area_code)='' )
      '' 
    #ELSE
        IF( le.Input_append_prior_area_code = (TYPEOF(le.Input_append_prior_area_code))'','',':append_prior_area_code')
    #END
+    #IF( #TEXT(Input_append_nonpublished_match)='' )
      '' 
    #ELSE
        IF( le.Input_append_nonpublished_match = (TYPEOF(le.Input_append_nonpublished_match))'','',':append_nonpublished_match')
    #END
+    #IF( #TEXT(Input_append_ocn)='' )
      '' 
    #ELSE
        IF( le.Input_append_ocn = (TYPEOF(le.Input_append_ocn))'','',':append_ocn')
    #END
+    #IF( #TEXT(Input_append_time_zone)='' )
      '' 
    #ELSE
        IF( le.Input_append_time_zone = (TYPEOF(le.Input_append_time_zone))'','',':append_time_zone')
    #END
+    #IF( #TEXT(Input_append_nxx_type)='' )
      '' 
    #ELSE
        IF( le.Input_append_nxx_type = (TYPEOF(le.Input_append_nxx_type))'','',':append_nxx_type')
    #END
+    #IF( #TEXT(Input_append_coctype)='' )
      '' 
    #ELSE
        IF( le.Input_append_coctype = (TYPEOF(le.Input_append_coctype))'','',':append_coctype')
    #END
+    #IF( #TEXT(Input_append_scc)='' )
      '' 
    #ELSE
        IF( le.Input_append_scc = (TYPEOF(le.Input_append_scc))'','',':append_scc')
    #END
+    #IF( #TEXT(Input_append_phone_type)='' )
      '' 
    #ELSE
        IF( le.Input_append_phone_type = (TYPEOF(le.Input_append_phone_type))'','',':append_phone_type')
    #END
+    #IF( #TEXT(Input_append_company_type)='' )
      '' 
    #ELSE
        IF( le.Input_append_company_type = (TYPEOF(le.Input_append_company_type))'','',':append_company_type')
    #END
+    #IF( #TEXT(Input_append_phone_use)='' )
      '' 
    #ELSE
        IF( le.Input_append_phone_use = (TYPEOF(le.Input_append_phone_use))'','',':append_phone_use')
    #END
+    #IF( #TEXT(Input_agreg_listing_type)='' )
      '' 
    #ELSE
        IF( le.Input_agreg_listing_type = (TYPEOF(le.Input_agreg_listing_type))'','',':agreg_listing_type')
    #END
+    #IF( #TEXT(Input_max_orig_conf_score)='' )
      '' 
    #ELSE
        IF( le.Input_max_orig_conf_score = (TYPEOF(le.Input_max_orig_conf_score))'','',':max_orig_conf_score')
    #END
+    #IF( #TEXT(Input_min_orig_conf_score)='' )
      '' 
    #ELSE
        IF( le.Input_min_orig_conf_score = (TYPEOF(le.Input_min_orig_conf_score))'','',':min_orig_conf_score')
    #END
+    #IF( #TEXT(Input_cur_orig_conf_score)='' )
      '' 
    #ELSE
        IF( le.Input_cur_orig_conf_score = (TYPEOF(le.Input_cur_orig_conf_score))'','',':cur_orig_conf_score')
    #END
+    #IF( #TEXT(Input_activeflag)='' )
      '' 
    #ELSE
        IF( le.Input_activeflag = (TYPEOF(le.Input_activeflag))'','',':activeflag')
    #END
+    #IF( #TEXT(Input_eda_active_flag)='' )
      '' 
    #ELSE
        IF( le.Input_eda_active_flag = (TYPEOF(le.Input_eda_active_flag))'','',':eda_active_flag')
    #END
+    #IF( #TEXT(Input_eda_match)='' )
      '' 
    #ELSE
        IF( le.Input_eda_match = (TYPEOF(le.Input_eda_match))'','',':eda_match')
    #END
+    #IF( #TEXT(Input_eda_phone_dt)='' )
      '' 
    #ELSE
        IF( le.Input_eda_phone_dt = (TYPEOF(le.Input_eda_phone_dt))'','',':eda_phone_dt')
    #END
+    #IF( #TEXT(Input_eda_did_dt)='' )
      '' 
    #ELSE
        IF( le.Input_eda_did_dt = (TYPEOF(le.Input_eda_did_dt))'','',':eda_did_dt')
    #END
+    #IF( #TEXT(Input_eda_nm_addr_dt)='' )
      '' 
    #ELSE
        IF( le.Input_eda_nm_addr_dt = (TYPEOF(le.Input_eda_nm_addr_dt))'','',':eda_nm_addr_dt')
    #END
+    #IF( #TEXT(Input_eda_hist_match)='' )
      '' 
    #ELSE
        IF( le.Input_eda_hist_match = (TYPEOF(le.Input_eda_hist_match))'','',':eda_hist_match')
    #END
+    #IF( #TEXT(Input_eda_hist_phone_dt)='' )
      '' 
    #ELSE
        IF( le.Input_eda_hist_phone_dt = (TYPEOF(le.Input_eda_hist_phone_dt))'','',':eda_hist_phone_dt')
    #END
+    #IF( #TEXT(Input_eda_hist_did_dt)='' )
      '' 
    #ELSE
        IF( le.Input_eda_hist_did_dt = (TYPEOF(le.Input_eda_hist_did_dt))'','',':eda_hist_did_dt')
    #END
+    #IF( #TEXT(Input_eda_hist_nm_addr_dt)='' )
      '' 
    #ELSE
        IF( le.Input_eda_hist_nm_addr_dt = (TYPEOF(le.Input_eda_hist_nm_addr_dt))'','',':eda_hist_nm_addr_dt')
    #END
+    #IF( #TEXT(Input_append_feedback_phone)='' )
      '' 
    #ELSE
        IF( le.Input_append_feedback_phone = (TYPEOF(le.Input_append_feedback_phone))'','',':append_feedback_phone')
    #END
+    #IF( #TEXT(Input_append_feedback_phone_dt)='' )
      '' 
    #ELSE
        IF( le.Input_append_feedback_phone_dt = (TYPEOF(le.Input_append_feedback_phone_dt))'','',':append_feedback_phone_dt')
    #END
+    #IF( #TEXT(Input_append_feedback_phone7_did)='' )
      '' 
    #ELSE
        IF( le.Input_append_feedback_phone7_did = (TYPEOF(le.Input_append_feedback_phone7_did))'','',':append_feedback_phone7_did')
    #END
+    #IF( #TEXT(Input_append_feedback_phone7_did_dt)='' )
      '' 
    #ELSE
        IF( le.Input_append_feedback_phone7_did_dt = (TYPEOF(le.Input_append_feedback_phone7_did_dt))'','',':append_feedback_phone7_did_dt')
    #END
+    #IF( #TEXT(Input_append_feedback_phone7_nm_addr)='' )
      '' 
    #ELSE
        IF( le.Input_append_feedback_phone7_nm_addr = (TYPEOF(le.Input_append_feedback_phone7_nm_addr))'','',':append_feedback_phone7_nm_addr')
    #END
+    #IF( #TEXT(Input_append_feedback_phone7_nm_addr_dt)='' )
      '' 
    #ELSE
        IF( le.Input_append_feedback_phone7_nm_addr_dt = (TYPEOF(le.Input_append_feedback_phone7_nm_addr_dt))'','',':append_feedback_phone7_nm_addr_dt')
    #END
+    #IF( #TEXT(Input_append_ported_match)='' )
      '' 
    #ELSE
        IF( le.Input_append_ported_match = (TYPEOF(le.Input_append_ported_match))'','',':append_ported_match')
    #END
+    #IF( #TEXT(Input_append_seen_once_ind)='' )
      '' 
    #ELSE
        IF( le.Input_append_seen_once_ind = (TYPEOF(le.Input_append_seen_once_ind))'','',':append_seen_once_ind')
    #END
+    #IF( #TEXT(Input_append_indiv_phone_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_append_indiv_phone_cnt = (TYPEOF(le.Input_append_indiv_phone_cnt))'','',':append_indiv_phone_cnt')
    #END
+    #IF( #TEXT(Input_append_indiv_has_active_eda_phone_flag)='' )
      '' 
    #ELSE
        IF( le.Input_append_indiv_has_active_eda_phone_flag = (TYPEOF(le.Input_append_indiv_has_active_eda_phone_flag))'','',':append_indiv_has_active_eda_phone_flag')
    #END
+    #IF( #TEXT(Input_append_latest_phone_owner_flag)='' )
      '' 
    #ELSE
        IF( le.Input_append_latest_phone_owner_flag = (TYPEOF(le.Input_append_latest_phone_owner_flag))'','',':append_latest_phone_owner_flag')
    #END
+    #IF( #TEXT(Input_hhid)='' )
      '' 
    #ELSE
        IF( le.Input_hhid = (TYPEOF(le.Input_hhid))'','',':hhid')
    #END
+    #IF( #TEXT(Input_hhid_score)='' )
      '' 
    #ELSE
        IF( le.Input_hhid_score = (TYPEOF(le.Input_hhid_score))'','',':hhid_score')
    #END
+    #IF( #TEXT(Input_phone7_hhid_key)='' )
      '' 
    #ELSE
        IF( le.Input_phone7_hhid_key = (TYPEOF(le.Input_phone7_hhid_key))'','',':phone7_hhid_key')
    #END
+    #IF( #TEXT(Input_append_best_addr_match_flag)='' )
      '' 
    #ELSE
        IF( le.Input_append_best_addr_match_flag = (TYPEOF(le.Input_append_best_addr_match_flag))'','',':append_best_addr_match_flag')
    #END
+    #IF( #TEXT(Input_append_best_nm_match_flag)='' )
      '' 
    #ELSE
        IF( le.Input_append_best_nm_match_flag = (TYPEOF(le.Input_append_best_nm_match_flag))'','',':append_best_nm_match_flag')
    #END
+    #IF( #TEXT(Input_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_rawaid = (TYPEOF(le.Input_rawaid))'','',':rawaid')
    #END
+    #IF( #TEXT(Input_cleanaid)='' )
      '' 
    #ELSE
        IF( le.Input_cleanaid = (TYPEOF(le.Input_cleanaid))'','',':cleanaid')
    #END
+    #IF( #TEXT(Input_current_rec)='' )
      '' 
    #ELSE
        IF( le.Input_current_rec = (TYPEOF(le.Input_current_rec))'','',':current_rec')
    #END
+    #IF( #TEXT(Input_first_build_date)='' )
      '' 
    #ELSE
        IF( le.Input_first_build_date = (TYPEOF(le.Input_first_build_date))'','',':first_build_date')
    #END
+    #IF( #TEXT(Input_last_build_date)='' )
      '' 
    #ELSE
        IF( le.Input_last_build_date = (TYPEOF(le.Input_last_build_date))'','',':last_build_date')
    #END
;
    #IF (#TEXT(vendor)<>'')
    SELF.source := le.vendor;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(vendor)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(vendor)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(vendor)<>'' ) source, #END -cnt );
ENDMACRO;
