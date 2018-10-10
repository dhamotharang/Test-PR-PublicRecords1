 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_process_date = '',Input_unique_key = '',Input_license_number = '',Input_last_name = '',Input_first_name = '',Input_middle_name = '',Input_suffix = '',Input_date_of_birth = '',Input_gender = '',Input_address = '',Input_city = '',Input_state = '',Input_zip5 = '',Input_zip4 = '',Input_mailing_address1 = '',Input_mailing_address2 = '',Input_mailing_city = '',Input_mailing_state = '',Input_mailing_zip = '',Input_height = '',Input_eye_color = '',Input_operator_status = '',Input_commercial_status = '',Input_sch_bus_status = '',Input_pending_act_code = '',Input_must_test_ind = '',Input_deceased_ind = '',Input_prev_cdl_class = '',Input_cdl_ptr = '',Input_pdps_ptr = '',Input_mvr_privacy_code = '',Input_brc_status_code = '',Input_brc_status_date = '',Input_lic_iss_code = '',Input_license_class = '',Input_lic_exp_date = '',Input_lic_seq_number = '',Input_lic_surrender_to = '',Input_new_out_of_st_dl_num = '',Input_license_endorsements = '',Input_license_restrictions = '',Input_license_trans_type = '',Input_lic_print_date = '',Input_permit_iss_code = '',Input_permit_class = '',Input_permit_exp_date = '',Input_permit_seq_number = '',Input_permit_endorse_codes = '',Input_permit_restric_codes = '',Input_permit_trans_type = '',Input_permit_print_date = '',Input_non_driver_code = '',Input_non_driver_exp_date = '',Input_non_driver_seq_num = '',Input_non_driver_trans_type = '',Input_non_driver_print_date = '',Input_action_surrender_date = '',Input_action_counts = '',Input_driv_priv_counts = '',Input_conv_counts = '',Input_accidents_counts = '',Input_aka_counts = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_cleaning_score = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_cln_zip5 = '',Input_cln_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dpbc = '',Input_chk_digit = '',Input_rec_type = '',Input_ace_fips_st = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_previous_dl_number = '',Input_previous_st = '',Input_old_dl_number = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_DL_MO_MEDCERT;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_unique_key)='' )
      '' 
    #ELSE
        IF( le.Input_unique_key = (TYPEOF(le.Input_unique_key))'','',':unique_key')
    #END
 
+    #IF( #TEXT(Input_license_number)='' )
      '' 
    #ELSE
        IF( le.Input_license_number = (TYPEOF(le.Input_license_number))'','',':license_number')
    #END
 
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
    #END
 
+    #IF( #TEXT(Input_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_name = (TYPEOF(le.Input_first_name))'','',':first_name')
    #END
 
+    #IF( #TEXT(Input_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_middle_name = (TYPEOF(le.Input_middle_name))'','',':middle_name')
    #END
 
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
 
+    #IF( #TEXT(Input_date_of_birth)='' )
      '' 
    #ELSE
        IF( le.Input_date_of_birth = (TYPEOF(le.Input_date_of_birth))'','',':date_of_birth')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_address)='' )
      '' 
    #ELSE
        IF( le.Input_address = (TYPEOF(le.Input_address))'','',':address')
    #END
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
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
 
+    #IF( #TEXT(Input_mailing_address1)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_address1 = (TYPEOF(le.Input_mailing_address1))'','',':mailing_address1')
    #END
 
+    #IF( #TEXT(Input_mailing_address2)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_address2 = (TYPEOF(le.Input_mailing_address2))'','',':mailing_address2')
    #END
 
+    #IF( #TEXT(Input_mailing_city)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_city = (TYPEOF(le.Input_mailing_city))'','',':mailing_city')
    #END
 
+    #IF( #TEXT(Input_mailing_state)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_state = (TYPEOF(le.Input_mailing_state))'','',':mailing_state')
    #END
 
+    #IF( #TEXT(Input_mailing_zip)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_zip = (TYPEOF(le.Input_mailing_zip))'','',':mailing_zip')
    #END
 
+    #IF( #TEXT(Input_height)='' )
      '' 
    #ELSE
        IF( le.Input_height = (TYPEOF(le.Input_height))'','',':height')
    #END
 
+    #IF( #TEXT(Input_eye_color)='' )
      '' 
    #ELSE
        IF( le.Input_eye_color = (TYPEOF(le.Input_eye_color))'','',':eye_color')
    #END
 
+    #IF( #TEXT(Input_operator_status)='' )
      '' 
    #ELSE
        IF( le.Input_operator_status = (TYPEOF(le.Input_operator_status))'','',':operator_status')
    #END
 
+    #IF( #TEXT(Input_commercial_status)='' )
      '' 
    #ELSE
        IF( le.Input_commercial_status = (TYPEOF(le.Input_commercial_status))'','',':commercial_status')
    #END
 
+    #IF( #TEXT(Input_sch_bus_status)='' )
      '' 
    #ELSE
        IF( le.Input_sch_bus_status = (TYPEOF(le.Input_sch_bus_status))'','',':sch_bus_status')
    #END
 
+    #IF( #TEXT(Input_pending_act_code)='' )
      '' 
    #ELSE
        IF( le.Input_pending_act_code = (TYPEOF(le.Input_pending_act_code))'','',':pending_act_code')
    #END
 
+    #IF( #TEXT(Input_must_test_ind)='' )
      '' 
    #ELSE
        IF( le.Input_must_test_ind = (TYPEOF(le.Input_must_test_ind))'','',':must_test_ind')
    #END
 
+    #IF( #TEXT(Input_deceased_ind)='' )
      '' 
    #ELSE
        IF( le.Input_deceased_ind = (TYPEOF(le.Input_deceased_ind))'','',':deceased_ind')
    #END
 
+    #IF( #TEXT(Input_prev_cdl_class)='' )
      '' 
    #ELSE
        IF( le.Input_prev_cdl_class = (TYPEOF(le.Input_prev_cdl_class))'','',':prev_cdl_class')
    #END
 
+    #IF( #TEXT(Input_cdl_ptr)='' )
      '' 
    #ELSE
        IF( le.Input_cdl_ptr = (TYPEOF(le.Input_cdl_ptr))'','',':cdl_ptr')
    #END
 
+    #IF( #TEXT(Input_pdps_ptr)='' )
      '' 
    #ELSE
        IF( le.Input_pdps_ptr = (TYPEOF(le.Input_pdps_ptr))'','',':pdps_ptr')
    #END
 
+    #IF( #TEXT(Input_mvr_privacy_code)='' )
      '' 
    #ELSE
        IF( le.Input_mvr_privacy_code = (TYPEOF(le.Input_mvr_privacy_code))'','',':mvr_privacy_code')
    #END
 
+    #IF( #TEXT(Input_brc_status_code)='' )
      '' 
    #ELSE
        IF( le.Input_brc_status_code = (TYPEOF(le.Input_brc_status_code))'','',':brc_status_code')
    #END
 
+    #IF( #TEXT(Input_brc_status_date)='' )
      '' 
    #ELSE
        IF( le.Input_brc_status_date = (TYPEOF(le.Input_brc_status_date))'','',':brc_status_date')
    #END
 
+    #IF( #TEXT(Input_lic_iss_code)='' )
      '' 
    #ELSE
        IF( le.Input_lic_iss_code = (TYPEOF(le.Input_lic_iss_code))'','',':lic_iss_code')
    #END
 
+    #IF( #TEXT(Input_license_class)='' )
      '' 
    #ELSE
        IF( le.Input_license_class = (TYPEOF(le.Input_license_class))'','',':license_class')
    #END
 
+    #IF( #TEXT(Input_lic_exp_date)='' )
      '' 
    #ELSE
        IF( le.Input_lic_exp_date = (TYPEOF(le.Input_lic_exp_date))'','',':lic_exp_date')
    #END
 
+    #IF( #TEXT(Input_lic_seq_number)='' )
      '' 
    #ELSE
        IF( le.Input_lic_seq_number = (TYPEOF(le.Input_lic_seq_number))'','',':lic_seq_number')
    #END
 
+    #IF( #TEXT(Input_lic_surrender_to)='' )
      '' 
    #ELSE
        IF( le.Input_lic_surrender_to = (TYPEOF(le.Input_lic_surrender_to))'','',':lic_surrender_to')
    #END
 
+    #IF( #TEXT(Input_new_out_of_st_dl_num)='' )
      '' 
    #ELSE
        IF( le.Input_new_out_of_st_dl_num = (TYPEOF(le.Input_new_out_of_st_dl_num))'','',':new_out_of_st_dl_num')
    #END
 
+    #IF( #TEXT(Input_license_endorsements)='' )
      '' 
    #ELSE
        IF( le.Input_license_endorsements = (TYPEOF(le.Input_license_endorsements))'','',':license_endorsements')
    #END
 
+    #IF( #TEXT(Input_license_restrictions)='' )
      '' 
    #ELSE
        IF( le.Input_license_restrictions = (TYPEOF(le.Input_license_restrictions))'','',':license_restrictions')
    #END
 
+    #IF( #TEXT(Input_license_trans_type)='' )
      '' 
    #ELSE
        IF( le.Input_license_trans_type = (TYPEOF(le.Input_license_trans_type))'','',':license_trans_type')
    #END
 
+    #IF( #TEXT(Input_lic_print_date)='' )
      '' 
    #ELSE
        IF( le.Input_lic_print_date = (TYPEOF(le.Input_lic_print_date))'','',':lic_print_date')
    #END
 
+    #IF( #TEXT(Input_permit_iss_code)='' )
      '' 
    #ELSE
        IF( le.Input_permit_iss_code = (TYPEOF(le.Input_permit_iss_code))'','',':permit_iss_code')
    #END
 
+    #IF( #TEXT(Input_permit_class)='' )
      '' 
    #ELSE
        IF( le.Input_permit_class = (TYPEOF(le.Input_permit_class))'','',':permit_class')
    #END
 
+    #IF( #TEXT(Input_permit_exp_date)='' )
      '' 
    #ELSE
        IF( le.Input_permit_exp_date = (TYPEOF(le.Input_permit_exp_date))'','',':permit_exp_date')
    #END
 
+    #IF( #TEXT(Input_permit_seq_number)='' )
      '' 
    #ELSE
        IF( le.Input_permit_seq_number = (TYPEOF(le.Input_permit_seq_number))'','',':permit_seq_number')
    #END
 
+    #IF( #TEXT(Input_permit_endorse_codes)='' )
      '' 
    #ELSE
        IF( le.Input_permit_endorse_codes = (TYPEOF(le.Input_permit_endorse_codes))'','',':permit_endorse_codes')
    #END
 
+    #IF( #TEXT(Input_permit_restric_codes)='' )
      '' 
    #ELSE
        IF( le.Input_permit_restric_codes = (TYPEOF(le.Input_permit_restric_codes))'','',':permit_restric_codes')
    #END
 
+    #IF( #TEXT(Input_permit_trans_type)='' )
      '' 
    #ELSE
        IF( le.Input_permit_trans_type = (TYPEOF(le.Input_permit_trans_type))'','',':permit_trans_type')
    #END
 
+    #IF( #TEXT(Input_permit_print_date)='' )
      '' 
    #ELSE
        IF( le.Input_permit_print_date = (TYPEOF(le.Input_permit_print_date))'','',':permit_print_date')
    #END
 
+    #IF( #TEXT(Input_non_driver_code)='' )
      '' 
    #ELSE
        IF( le.Input_non_driver_code = (TYPEOF(le.Input_non_driver_code))'','',':non_driver_code')
    #END
 
+    #IF( #TEXT(Input_non_driver_exp_date)='' )
      '' 
    #ELSE
        IF( le.Input_non_driver_exp_date = (TYPEOF(le.Input_non_driver_exp_date))'','',':non_driver_exp_date')
    #END
 
+    #IF( #TEXT(Input_non_driver_seq_num)='' )
      '' 
    #ELSE
        IF( le.Input_non_driver_seq_num = (TYPEOF(le.Input_non_driver_seq_num))'','',':non_driver_seq_num')
    #END
 
+    #IF( #TEXT(Input_non_driver_trans_type)='' )
      '' 
    #ELSE
        IF( le.Input_non_driver_trans_type = (TYPEOF(le.Input_non_driver_trans_type))'','',':non_driver_trans_type')
    #END
 
+    #IF( #TEXT(Input_non_driver_print_date)='' )
      '' 
    #ELSE
        IF( le.Input_non_driver_print_date = (TYPEOF(le.Input_non_driver_print_date))'','',':non_driver_print_date')
    #END
 
+    #IF( #TEXT(Input_action_surrender_date)='' )
      '' 
    #ELSE
        IF( le.Input_action_surrender_date = (TYPEOF(le.Input_action_surrender_date))'','',':action_surrender_date')
    #END
 
+    #IF( #TEXT(Input_action_counts)='' )
      '' 
    #ELSE
        IF( le.Input_action_counts = (TYPEOF(le.Input_action_counts))'','',':action_counts')
    #END
 
+    #IF( #TEXT(Input_driv_priv_counts)='' )
      '' 
    #ELSE
        IF( le.Input_driv_priv_counts = (TYPEOF(le.Input_driv_priv_counts))'','',':driv_priv_counts')
    #END
 
+    #IF( #TEXT(Input_conv_counts)='' )
      '' 
    #ELSE
        IF( le.Input_conv_counts = (TYPEOF(le.Input_conv_counts))'','',':conv_counts')
    #END
 
+    #IF( #TEXT(Input_accidents_counts)='' )
      '' 
    #ELSE
        IF( le.Input_accidents_counts = (TYPEOF(le.Input_accidents_counts))'','',':accidents_counts')
    #END
 
+    #IF( #TEXT(Input_aka_counts)='' )
      '' 
    #ELSE
        IF( le.Input_aka_counts = (TYPEOF(le.Input_aka_counts))'','',':aka_counts')
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
 
+    #IF( #TEXT(Input_cleaning_score)='' )
      '' 
    #ELSE
        IF( le.Input_cleaning_score = (TYPEOF(le.Input_cleaning_score))'','',':cleaning_score')
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
 
+    #IF( #TEXT(Input_cln_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_cln_zip5 = (TYPEOF(le.Input_cln_zip5))'','',':cln_zip5')
    #END
 
+    #IF( #TEXT(Input_cln_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_cln_zip4 = (TYPEOF(le.Input_cln_zip4))'','',':cln_zip4')
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
 
+    #IF( #TEXT(Input_previous_dl_number)='' )
      '' 
    #ELSE
        IF( le.Input_previous_dl_number = (TYPEOF(le.Input_previous_dl_number))'','',':previous_dl_number')
    #END
 
+    #IF( #TEXT(Input_previous_st)='' )
      '' 
    #ELSE
        IF( le.Input_previous_st = (TYPEOF(le.Input_previous_st))'','',':previous_st')
    #END
 
+    #IF( #TEXT(Input_old_dl_number)='' )
      '' 
    #ELSE
        IF( le.Input_old_dl_number = (TYPEOF(le.Input_old_dl_number))'','',':old_dl_number')
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
