 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_key = '',Input_ssn = '',Input_did = '',Input_process_date = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_date_vendor_first_reported = '',Input_date_vendor_last_reported = '',Input_historical_flag = '',Input_full_name = '',Input_first_name = '',Input_last_name = '',Input_address_1 = '',Input_address_2 = '',Input_city = '',Input_state = '',Input_zip = '',Input_zip_4 = '',Input_crrt_code = '',Input_delivery_point_barcode = '',Input_zip4_check_digit = '',Input_address_type_code = '',Input_address_type = '',Input_county_number = '',Input_county_name = '',Input_gender_code = '',Input_gender = '',Input_age = '',Input_birth_date = '',Input_dob_formatted = '',Input_telephone = '',Input_class = '',Input_college_class = '',Input_college_name = '',Input_ln_college_name = '',Input_college_major = '',Input_new_college_major = '',Input_college_code = '',Input_college_code_exploded = '',Input_college_type = '',Input_college_type_exploded = '',Input_head_of_household_first_name = '',Input_head_of_household_gender_code = '',Input_head_of_household_gender = '',Input_income_level_code = '',Input_income_level = '',Input_new_income_level_code = '',Input_new_income_level = '',Input_file_type = '',Input_tier = '',Input_school_size_code = '',Input_competitive_code = '',Input_tuition_code = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_rawaid = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_z5 = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dpbc = '',Input_chk_digit = '',Input_rec_type = '',Input_county = '',Input_ace_fips_st = '',Input_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_tier2 = '',Input_source = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_American_Student_List;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_key)='' )
      '' 
    #ELSE
        IF( le.Input_key = (TYPEOF(le.Input_key))'','',':key')
    #END
 
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
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
 
+    #IF( #TEXT(Input_historical_flag)='' )
      '' 
    #ELSE
        IF( le.Input_historical_flag = (TYPEOF(le.Input_historical_flag))'','',':historical_flag')
    #END
 
+    #IF( #TEXT(Input_full_name)='' )
      '' 
    #ELSE
        IF( le.Input_full_name = (TYPEOF(le.Input_full_name))'','',':full_name')
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
 
+    #IF( #TEXT(Input_address_1)='' )
      '' 
    #ELSE
        IF( le.Input_address_1 = (TYPEOF(le.Input_address_1))'','',':address_1')
    #END
 
+    #IF( #TEXT(Input_address_2)='' )
      '' 
    #ELSE
        IF( le.Input_address_2 = (TYPEOF(le.Input_address_2))'','',':address_2')
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
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_zip_4)='' )
      '' 
    #ELSE
        IF( le.Input_zip_4 = (TYPEOF(le.Input_zip_4))'','',':zip_4')
    #END
 
+    #IF( #TEXT(Input_crrt_code)='' )
      '' 
    #ELSE
        IF( le.Input_crrt_code = (TYPEOF(le.Input_crrt_code))'','',':crrt_code')
    #END
 
+    #IF( #TEXT(Input_delivery_point_barcode)='' )
      '' 
    #ELSE
        IF( le.Input_delivery_point_barcode = (TYPEOF(le.Input_delivery_point_barcode))'','',':delivery_point_barcode')
    #END
 
+    #IF( #TEXT(Input_zip4_check_digit)='' )
      '' 
    #ELSE
        IF( le.Input_zip4_check_digit = (TYPEOF(le.Input_zip4_check_digit))'','',':zip4_check_digit')
    #END
 
+    #IF( #TEXT(Input_address_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_address_type_code = (TYPEOF(le.Input_address_type_code))'','',':address_type_code')
    #END
 
+    #IF( #TEXT(Input_address_type)='' )
      '' 
    #ELSE
        IF( le.Input_address_type = (TYPEOF(le.Input_address_type))'','',':address_type')
    #END
 
+    #IF( #TEXT(Input_county_number)='' )
      '' 
    #ELSE
        IF( le.Input_county_number = (TYPEOF(le.Input_county_number))'','',':county_number')
    #END
 
+    #IF( #TEXT(Input_county_name)='' )
      '' 
    #ELSE
        IF( le.Input_county_name = (TYPEOF(le.Input_county_name))'','',':county_name')
    #END
 
+    #IF( #TEXT(Input_gender_code)='' )
      '' 
    #ELSE
        IF( le.Input_gender_code = (TYPEOF(le.Input_gender_code))'','',':gender_code')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_age)='' )
      '' 
    #ELSE
        IF( le.Input_age = (TYPEOF(le.Input_age))'','',':age')
    #END
 
+    #IF( #TEXT(Input_birth_date)='' )
      '' 
    #ELSE
        IF( le.Input_birth_date = (TYPEOF(le.Input_birth_date))'','',':birth_date')
    #END
 
+    #IF( #TEXT(Input_dob_formatted)='' )
      '' 
    #ELSE
        IF( le.Input_dob_formatted = (TYPEOF(le.Input_dob_formatted))'','',':dob_formatted')
    #END
 
+    #IF( #TEXT(Input_telephone)='' )
      '' 
    #ELSE
        IF( le.Input_telephone = (TYPEOF(le.Input_telephone))'','',':telephone')
    #END
 
+    #IF( #TEXT(Input_class)='' )
      '' 
    #ELSE
        IF( le.Input_class = (TYPEOF(le.Input_class))'','',':class')
    #END
 
+    #IF( #TEXT(Input_college_class)='' )
      '' 
    #ELSE
        IF( le.Input_college_class = (TYPEOF(le.Input_college_class))'','',':college_class')
    #END
 
+    #IF( #TEXT(Input_college_name)='' )
      '' 
    #ELSE
        IF( le.Input_college_name = (TYPEOF(le.Input_college_name))'','',':college_name')
    #END
 
+    #IF( #TEXT(Input_ln_college_name)='' )
      '' 
    #ELSE
        IF( le.Input_ln_college_name = (TYPEOF(le.Input_ln_college_name))'','',':ln_college_name')
    #END
 
+    #IF( #TEXT(Input_college_major)='' )
      '' 
    #ELSE
        IF( le.Input_college_major = (TYPEOF(le.Input_college_major))'','',':college_major')
    #END
 
+    #IF( #TEXT(Input_new_college_major)='' )
      '' 
    #ELSE
        IF( le.Input_new_college_major = (TYPEOF(le.Input_new_college_major))'','',':new_college_major')
    #END
 
+    #IF( #TEXT(Input_college_code)='' )
      '' 
    #ELSE
        IF( le.Input_college_code = (TYPEOF(le.Input_college_code))'','',':college_code')
    #END
 
+    #IF( #TEXT(Input_college_code_exploded)='' )
      '' 
    #ELSE
        IF( le.Input_college_code_exploded = (TYPEOF(le.Input_college_code_exploded))'','',':college_code_exploded')
    #END
 
+    #IF( #TEXT(Input_college_type)='' )
      '' 
    #ELSE
        IF( le.Input_college_type = (TYPEOF(le.Input_college_type))'','',':college_type')
    #END
 
+    #IF( #TEXT(Input_college_type_exploded)='' )
      '' 
    #ELSE
        IF( le.Input_college_type_exploded = (TYPEOF(le.Input_college_type_exploded))'','',':college_type_exploded')
    #END
 
+    #IF( #TEXT(Input_head_of_household_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_head_of_household_first_name = (TYPEOF(le.Input_head_of_household_first_name))'','',':head_of_household_first_name')
    #END
 
+    #IF( #TEXT(Input_head_of_household_gender_code)='' )
      '' 
    #ELSE
        IF( le.Input_head_of_household_gender_code = (TYPEOF(le.Input_head_of_household_gender_code))'','',':head_of_household_gender_code')
    #END
 
+    #IF( #TEXT(Input_head_of_household_gender)='' )
      '' 
    #ELSE
        IF( le.Input_head_of_household_gender = (TYPEOF(le.Input_head_of_household_gender))'','',':head_of_household_gender')
    #END
 
+    #IF( #TEXT(Input_income_level_code)='' )
      '' 
    #ELSE
        IF( le.Input_income_level_code = (TYPEOF(le.Input_income_level_code))'','',':income_level_code')
    #END
 
+    #IF( #TEXT(Input_income_level)='' )
      '' 
    #ELSE
        IF( le.Input_income_level = (TYPEOF(le.Input_income_level))'','',':income_level')
    #END
 
+    #IF( #TEXT(Input_new_income_level_code)='' )
      '' 
    #ELSE
        IF( le.Input_new_income_level_code = (TYPEOF(le.Input_new_income_level_code))'','',':new_income_level_code')
    #END
 
+    #IF( #TEXT(Input_new_income_level)='' )
      '' 
    #ELSE
        IF( le.Input_new_income_level = (TYPEOF(le.Input_new_income_level))'','',':new_income_level')
    #END
 
+    #IF( #TEXT(Input_file_type)='' )
      '' 
    #ELSE
        IF( le.Input_file_type = (TYPEOF(le.Input_file_type))'','',':file_type')
    #END
 
+    #IF( #TEXT(Input_tier)='' )
      '' 
    #ELSE
        IF( le.Input_tier = (TYPEOF(le.Input_tier))'','',':tier')
    #END
 
+    #IF( #TEXT(Input_school_size_code)='' )
      '' 
    #ELSE
        IF( le.Input_school_size_code = (TYPEOF(le.Input_school_size_code))'','',':school_size_code')
    #END
 
+    #IF( #TEXT(Input_competitive_code)='' )
      '' 
    #ELSE
        IF( le.Input_competitive_code = (TYPEOF(le.Input_competitive_code))'','',':competitive_code')
    #END
 
+    #IF( #TEXT(Input_tuition_code)='' )
      '' 
    #ELSE
        IF( le.Input_tuition_code = (TYPEOF(le.Input_tuition_code))'','',':tuition_code')
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
 
+    #IF( #TEXT(Input_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_rawaid = (TYPEOF(le.Input_rawaid))'','',':rawaid')
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
 
+    #IF( #TEXT(Input_z5)='' )
      '' 
    #ELSE
        IF( le.Input_z5 = (TYPEOF(le.Input_z5))'','',':z5')
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
 
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
    #END
 
+    #IF( #TEXT(Input_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_ace_fips_st = (TYPEOF(le.Input_ace_fips_st))'','',':ace_fips_st')
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
 
+    #IF( #TEXT(Input_tier2)='' )
      '' 
    #ELSE
        IF( le.Input_tier2 = (TYPEOF(le.Input_tier2))'','',':tier2')
    #END
 
+    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
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
