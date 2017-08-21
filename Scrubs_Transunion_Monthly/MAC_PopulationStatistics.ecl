 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_record_type = '',Input_first_name = '',Input_middle_name = '',Input_last_name = '',Input_name_prefix = '',Input_name_suffix_ = '',Input_perm_id = '',Input_ssn = '',Input_aka1 = '',Input_aka2 = '',Input_aka3 = '',Input_new_subject_flag = '',Input_name_change_flag = '',Input_address_change_flag = '',Input_ssn_change_flag = '',Input_file_since_date_change_flag = '',Input_deceased_indicator_flag = '',Input_dob_change_flag = '',Input_phone_change_flag = '',Input_filler2 = '',Input_gender = '',Input_mfdu_indicator = '',Input_file_since_date = '',Input_house_number = '',Input_street_direction = '',Input_street_name = '',Input_street_type = '',Input_street_post_direction = '',Input_unit_type = '',Input_unit_number = '',Input_cty = '',Input_state = '',Input_zip_code = '',Input_zp4 = '',Input_address_standardization_indicator = '',Input_date_address_reported = '',Input_party_id = '',Input_deceased_indicator = '',Input_date_of_birth = '',Input_date_of_birth_estimated_ind = '',Input_phone = '',Input_filler3 = '',Input_prepped_name = '',Input_prepped_addr1 = '',Input_prepped_addr2 = '',Input_prepped_rec_type = '',Input_isupdating = '',Input_iscurrent = '',Input_did = '',Input_did_score = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_last_reported = '',Input_dt_vendor_first_reported = '',Input_clean_phone = '',Input_clean_ssn = '',Input_clean_dob = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_fips_county = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_rawaid = '',Input_isdelete = '',OutFile) := MACRO
  IMPORT SALT32,Scrubs_Transunion_Monthly;
  #uniquename(of)
  %of% := RECORD
    SALT32.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
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
 
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
    #END
 
+    #IF( #TEXT(Input_name_prefix)='' )
      '' 
    #ELSE
        IF( le.Input_name_prefix = (TYPEOF(le.Input_name_prefix))'','',':name_prefix')
    #END
 
+    #IF( #TEXT(Input_name_suffix_)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix_ = (TYPEOF(le.Input_name_suffix_))'','',':name_suffix_')
    #END
 
+    #IF( #TEXT(Input_perm_id)='' )
      '' 
    #ELSE
        IF( le.Input_perm_id = (TYPEOF(le.Input_perm_id))'','',':perm_id')
    #END
 
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
 
+    #IF( #TEXT(Input_aka1)='' )
      '' 
    #ELSE
        IF( le.Input_aka1 = (TYPEOF(le.Input_aka1))'','',':aka1')
    #END
 
+    #IF( #TEXT(Input_aka2)='' )
      '' 
    #ELSE
        IF( le.Input_aka2 = (TYPEOF(le.Input_aka2))'','',':aka2')
    #END
 
+    #IF( #TEXT(Input_aka3)='' )
      '' 
    #ELSE
        IF( le.Input_aka3 = (TYPEOF(le.Input_aka3))'','',':aka3')
    #END
 
+    #IF( #TEXT(Input_new_subject_flag)='' )
      '' 
    #ELSE
        IF( le.Input_new_subject_flag = (TYPEOF(le.Input_new_subject_flag))'','',':new_subject_flag')
    #END
 
+    #IF( #TEXT(Input_name_change_flag)='' )
      '' 
    #ELSE
        IF( le.Input_name_change_flag = (TYPEOF(le.Input_name_change_flag))'','',':name_change_flag')
    #END
 
+    #IF( #TEXT(Input_address_change_flag)='' )
      '' 
    #ELSE
        IF( le.Input_address_change_flag = (TYPEOF(le.Input_address_change_flag))'','',':address_change_flag')
    #END
 
+    #IF( #TEXT(Input_ssn_change_flag)='' )
      '' 
    #ELSE
        IF( le.Input_ssn_change_flag = (TYPEOF(le.Input_ssn_change_flag))'','',':ssn_change_flag')
    #END
 
+    #IF( #TEXT(Input_file_since_date_change_flag)='' )
      '' 
    #ELSE
        IF( le.Input_file_since_date_change_flag = (TYPEOF(le.Input_file_since_date_change_flag))'','',':file_since_date_change_flag')
    #END
 
+    #IF( #TEXT(Input_deceased_indicator_flag)='' )
      '' 
    #ELSE
        IF( le.Input_deceased_indicator_flag = (TYPEOF(le.Input_deceased_indicator_flag))'','',':deceased_indicator_flag')
    #END
 
+    #IF( #TEXT(Input_dob_change_flag)='' )
      '' 
    #ELSE
        IF( le.Input_dob_change_flag = (TYPEOF(le.Input_dob_change_flag))'','',':dob_change_flag')
    #END
 
+    #IF( #TEXT(Input_phone_change_flag)='' )
      '' 
    #ELSE
        IF( le.Input_phone_change_flag = (TYPEOF(le.Input_phone_change_flag))'','',':phone_change_flag')
    #END
 
+    #IF( #TEXT(Input_filler2)='' )
      '' 
    #ELSE
        IF( le.Input_filler2 = (TYPEOF(le.Input_filler2))'','',':filler2')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_mfdu_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_mfdu_indicator = (TYPEOF(le.Input_mfdu_indicator))'','',':mfdu_indicator')
    #END
 
+    #IF( #TEXT(Input_file_since_date)='' )
      '' 
    #ELSE
        IF( le.Input_file_since_date = (TYPEOF(le.Input_file_since_date))'','',':file_since_date')
    #END
 
+    #IF( #TEXT(Input_house_number)='' )
      '' 
    #ELSE
        IF( le.Input_house_number = (TYPEOF(le.Input_house_number))'','',':house_number')
    #END
 
+    #IF( #TEXT(Input_street_direction)='' )
      '' 
    #ELSE
        IF( le.Input_street_direction = (TYPEOF(le.Input_street_direction))'','',':street_direction')
    #END
 
+    #IF( #TEXT(Input_street_name)='' )
      '' 
    #ELSE
        IF( le.Input_street_name = (TYPEOF(le.Input_street_name))'','',':street_name')
    #END
 
+    #IF( #TEXT(Input_street_type)='' )
      '' 
    #ELSE
        IF( le.Input_street_type = (TYPEOF(le.Input_street_type))'','',':street_type')
    #END
 
+    #IF( #TEXT(Input_street_post_direction)='' )
      '' 
    #ELSE
        IF( le.Input_street_post_direction = (TYPEOF(le.Input_street_post_direction))'','',':street_post_direction')
    #END
 
+    #IF( #TEXT(Input_unit_type)='' )
      '' 
    #ELSE
        IF( le.Input_unit_type = (TYPEOF(le.Input_unit_type))'','',':unit_type')
    #END
 
+    #IF( #TEXT(Input_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_unit_number = (TYPEOF(le.Input_unit_number))'','',':unit_number')
    #END
 
+    #IF( #TEXT(Input_cty)='' )
      '' 
    #ELSE
        IF( le.Input_cty = (TYPEOF(le.Input_cty))'','',':cty')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_zip_code = (TYPEOF(le.Input_zip_code))'','',':zip_code')
    #END
 
+    #IF( #TEXT(Input_zp4)='' )
      '' 
    #ELSE
        IF( le.Input_zp4 = (TYPEOF(le.Input_zp4))'','',':zp4')
    #END
 
+    #IF( #TEXT(Input_address_standardization_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_address_standardization_indicator = (TYPEOF(le.Input_address_standardization_indicator))'','',':address_standardization_indicator')
    #END
 
+    #IF( #TEXT(Input_date_address_reported)='' )
      '' 
    #ELSE
        IF( le.Input_date_address_reported = (TYPEOF(le.Input_date_address_reported))'','',':date_address_reported')
    #END
 
+    #IF( #TEXT(Input_party_id)='' )
      '' 
    #ELSE
        IF( le.Input_party_id = (TYPEOF(le.Input_party_id))'','',':party_id')
    #END
 
+    #IF( #TEXT(Input_deceased_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_deceased_indicator = (TYPEOF(le.Input_deceased_indicator))'','',':deceased_indicator')
    #END
 
+    #IF( #TEXT(Input_date_of_birth)='' )
      '' 
    #ELSE
        IF( le.Input_date_of_birth = (TYPEOF(le.Input_date_of_birth))'','',':date_of_birth')
    #END
 
+    #IF( #TEXT(Input_date_of_birth_estimated_ind)='' )
      '' 
    #ELSE
        IF( le.Input_date_of_birth_estimated_ind = (TYPEOF(le.Input_date_of_birth_estimated_ind))'','',':date_of_birth_estimated_ind')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_filler3)='' )
      '' 
    #ELSE
        IF( le.Input_filler3 = (TYPEOF(le.Input_filler3))'','',':filler3')
    #END
 
+    #IF( #TEXT(Input_prepped_name)='' )
      '' 
    #ELSE
        IF( le.Input_prepped_name = (TYPEOF(le.Input_prepped_name))'','',':prepped_name')
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
 
+    #IF( #TEXT(Input_prepped_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_prepped_rec_type = (TYPEOF(le.Input_prepped_rec_type))'','',':prepped_rec_type')
    #END
 
+    #IF( #TEXT(Input_isupdating)='' )
      '' 
    #ELSE
        IF( le.Input_isupdating = (TYPEOF(le.Input_isupdating))'','',':isupdating')
    #END
 
+    #IF( #TEXT(Input_iscurrent)='' )
      '' 
    #ELSE
        IF( le.Input_iscurrent = (TYPEOF(le.Input_iscurrent))'','',':iscurrent')
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
 
+    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
 
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_last_reported = (TYPEOF(le.Input_dt_vendor_last_reported))'','',':dt_vendor_last_reported')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_first_reported = (TYPEOF(le.Input_dt_vendor_first_reported))'','',':dt_vendor_first_reported')
    #END
 
+    #IF( #TEXT(Input_clean_phone)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phone = (TYPEOF(le.Input_clean_phone))'','',':clean_phone')
    #END
 
+    #IF( #TEXT(Input_clean_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_clean_ssn = (TYPEOF(le.Input_clean_ssn))'','',':clean_ssn')
    #END
 
+    #IF( #TEXT(Input_clean_dob)='' )
      '' 
    #ELSE
        IF( le.Input_clean_dob = (TYPEOF(le.Input_clean_dob))'','',':clean_dob')
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
 
+    #IF( #TEXT(Input_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_fips_county = (TYPEOF(le.Input_fips_county))'','',':fips_county')
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
 
+    #IF( #TEXT(Input_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_rawaid = (TYPEOF(le.Input_rawaid))'','',':rawaid')
    #END
 
+    #IF( #TEXT(Input_isdelete)='' )
      '' 
    #ELSE
        IF( le.Input_isdelete = (TYPEOF(le.Input_isdelete))'','',':isdelete')
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
