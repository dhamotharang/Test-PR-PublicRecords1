 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_fname_orig = '',Input_mname_orig = '',Input_lname_orig = '',Input_name_suffix_orig = '',Input_title_orig = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_hhid = '',Input_did = '',Input_did_score = '',Input_phone_fordid = '',Input_gender = '',Input_date_of_birth = '',Input_address_type = '',Input_demographic_level_indicator = '',Input_length_of_residence = '',Input_location_type = '',Input_dqi2_occupancy_count = '',Input_delivery_unit_size = '',Input_household_arrival_date = '',Input_area_code = '',Input_phone_number = '',Input_telephone_number_type = '',Input_phone2_number = '',Input_telephone2_number_type = '',Input_time_zone = '',Input_refresh_date = '',Input_name_address_verification_source = '',Input_drop_indicator = '',Input_do_not_mail_flag = '',Input_do_not_call_flag = '',Input_business_file_hit_flag = '',Input_spouse_title = '',Input_spouse_fname = '',Input_spouse_mname = '',Input_spouse_lname = '',Input_spouse_name_suffix = '',Input_spouse_fname_orig = '',Input_spouse_mname_orig = '',Input_spouse_lname_orig = '',Input_spouse_name_suffix_orig = '',Input_spouse_title_orig = '',Input_spouse_gender = '',Input_spouse_date_of_birth = '',Input_spouse_indicator = '',Input_household_income = '',Input_find_income_in_1000s = '',Input_phhincomeunder25k = '',Input_phhincome50kplus = '',Input_phhincome200kplus = '',Input_medianhhincome = '',Input_own_rent = '',Input_homeowner_source_code = '',Input_telephone_acquisition_date = '',Input_recency_date = '',Input_source = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_PCNSR;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_title)='' )
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
 
+    #IF( #TEXT(Input_fname_orig)='' )
      '' 
    #ELSE
        IF( le.Input_fname_orig = (TYPEOF(le.Input_fname_orig))'','',':fname_orig')
    #END
 
+    #IF( #TEXT(Input_mname_orig)='' )
      '' 
    #ELSE
        IF( le.Input_mname_orig = (TYPEOF(le.Input_mname_orig))'','',':mname_orig')
    #END
 
+    #IF( #TEXT(Input_lname_orig)='' )
      '' 
    #ELSE
        IF( le.Input_lname_orig = (TYPEOF(le.Input_lname_orig))'','',':lname_orig')
    #END
 
+    #IF( #TEXT(Input_name_suffix_orig)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix_orig = (TYPEOF(le.Input_name_suffix_orig))'','',':name_suffix_orig')
    #END
 
+    #IF( #TEXT(Input_title_orig)='' )
      '' 
    #ELSE
        IF( le.Input_title_orig = (TYPEOF(le.Input_title_orig))'','',':title_orig')
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
 
+    #IF( #TEXT(Input_hhid)='' )
      '' 
    #ELSE
        IF( le.Input_hhid = (TYPEOF(le.Input_hhid))'','',':hhid')
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
 
+    #IF( #TEXT(Input_phone_fordid)='' )
      '' 
    #ELSE
        IF( le.Input_phone_fordid = (TYPEOF(le.Input_phone_fordid))'','',':phone_fordid')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_date_of_birth)='' )
      '' 
    #ELSE
        IF( le.Input_date_of_birth = (TYPEOF(le.Input_date_of_birth))'','',':date_of_birth')
    #END
 
+    #IF( #TEXT(Input_address_type)='' )
      '' 
    #ELSE
        IF( le.Input_address_type = (TYPEOF(le.Input_address_type))'','',':address_type')
    #END
 
+    #IF( #TEXT(Input_demographic_level_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_demographic_level_indicator = (TYPEOF(le.Input_demographic_level_indicator))'','',':demographic_level_indicator')
    #END
 
+    #IF( #TEXT(Input_length_of_residence)='' )
      '' 
    #ELSE
        IF( le.Input_length_of_residence = (TYPEOF(le.Input_length_of_residence))'','',':length_of_residence')
    #END
 
+    #IF( #TEXT(Input_location_type)='' )
      '' 
    #ELSE
        IF( le.Input_location_type = (TYPEOF(le.Input_location_type))'','',':location_type')
    #END
 
+    #IF( #TEXT(Input_dqi2_occupancy_count)='' )
      '' 
    #ELSE
        IF( le.Input_dqi2_occupancy_count = (TYPEOF(le.Input_dqi2_occupancy_count))'','',':dqi2_occupancy_count')
    #END
 
+    #IF( #TEXT(Input_delivery_unit_size)='' )
      '' 
    #ELSE
        IF( le.Input_delivery_unit_size = (TYPEOF(le.Input_delivery_unit_size))'','',':delivery_unit_size')
    #END
 
+    #IF( #TEXT(Input_household_arrival_date)='' )
      '' 
    #ELSE
        IF( le.Input_household_arrival_date = (TYPEOF(le.Input_household_arrival_date))'','',':household_arrival_date')
    #END
 
+    #IF( #TEXT(Input_area_code)='' )
      '' 
    #ELSE
        IF( le.Input_area_code = (TYPEOF(le.Input_area_code))'','',':area_code')
    #END
 
+    #IF( #TEXT(Input_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_phone_number = (TYPEOF(le.Input_phone_number))'','',':phone_number')
    #END
 
+    #IF( #TEXT(Input_telephone_number_type)='' )
      '' 
    #ELSE
        IF( le.Input_telephone_number_type = (TYPEOF(le.Input_telephone_number_type))'','',':telephone_number_type')
    #END
 
+    #IF( #TEXT(Input_phone2_number)='' )
      '' 
    #ELSE
        IF( le.Input_phone2_number = (TYPEOF(le.Input_phone2_number))'','',':phone2_number')
    #END
 
+    #IF( #TEXT(Input_telephone2_number_type)='' )
      '' 
    #ELSE
        IF( le.Input_telephone2_number_type = (TYPEOF(le.Input_telephone2_number_type))'','',':telephone2_number_type')
    #END
 
+    #IF( #TEXT(Input_time_zone)='' )
      '' 
    #ELSE
        IF( le.Input_time_zone = (TYPEOF(le.Input_time_zone))'','',':time_zone')
    #END
 
+    #IF( #TEXT(Input_refresh_date)='' )
      '' 
    #ELSE
        IF( le.Input_refresh_date = (TYPEOF(le.Input_refresh_date))'','',':refresh_date')
    #END
 
+    #IF( #TEXT(Input_name_address_verification_source)='' )
      '' 
    #ELSE
        IF( le.Input_name_address_verification_source = (TYPEOF(le.Input_name_address_verification_source))'','',':name_address_verification_source')
    #END
 
+    #IF( #TEXT(Input_drop_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_drop_indicator = (TYPEOF(le.Input_drop_indicator))'','',':drop_indicator')
    #END
 
+    #IF( #TEXT(Input_do_not_mail_flag)='' )
      '' 
    #ELSE
        IF( le.Input_do_not_mail_flag = (TYPEOF(le.Input_do_not_mail_flag))'','',':do_not_mail_flag')
    #END
 
+    #IF( #TEXT(Input_do_not_call_flag)='' )
      '' 
    #ELSE
        IF( le.Input_do_not_call_flag = (TYPEOF(le.Input_do_not_call_flag))'','',':do_not_call_flag')
    #END
 
+    #IF( #TEXT(Input_business_file_hit_flag)='' )
      '' 
    #ELSE
        IF( le.Input_business_file_hit_flag = (TYPEOF(le.Input_business_file_hit_flag))'','',':business_file_hit_flag')
    #END
 
+    #IF( #TEXT(Input_spouse_title)='' )
      '' 
    #ELSE
        IF( le.Input_spouse_title = (TYPEOF(le.Input_spouse_title))'','',':spouse_title')
    #END
 
+    #IF( #TEXT(Input_spouse_fname)='' )
      '' 
    #ELSE
        IF( le.Input_spouse_fname = (TYPEOF(le.Input_spouse_fname))'','',':spouse_fname')
    #END
 
+    #IF( #TEXT(Input_spouse_mname)='' )
      '' 
    #ELSE
        IF( le.Input_spouse_mname = (TYPEOF(le.Input_spouse_mname))'','',':spouse_mname')
    #END
 
+    #IF( #TEXT(Input_spouse_lname)='' )
      '' 
    #ELSE
        IF( le.Input_spouse_lname = (TYPEOF(le.Input_spouse_lname))'','',':spouse_lname')
    #END
 
+    #IF( #TEXT(Input_spouse_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_spouse_name_suffix = (TYPEOF(le.Input_spouse_name_suffix))'','',':spouse_name_suffix')
    #END
 
+    #IF( #TEXT(Input_spouse_fname_orig)='' )
      '' 
    #ELSE
        IF( le.Input_spouse_fname_orig = (TYPEOF(le.Input_spouse_fname_orig))'','',':spouse_fname_orig')
    #END
 
+    #IF( #TEXT(Input_spouse_mname_orig)='' )
      '' 
    #ELSE
        IF( le.Input_spouse_mname_orig = (TYPEOF(le.Input_spouse_mname_orig))'','',':spouse_mname_orig')
    #END
 
+    #IF( #TEXT(Input_spouse_lname_orig)='' )
      '' 
    #ELSE
        IF( le.Input_spouse_lname_orig = (TYPEOF(le.Input_spouse_lname_orig))'','',':spouse_lname_orig')
    #END
 
+    #IF( #TEXT(Input_spouse_name_suffix_orig)='' )
      '' 
    #ELSE
        IF( le.Input_spouse_name_suffix_orig = (TYPEOF(le.Input_spouse_name_suffix_orig))'','',':spouse_name_suffix_orig')
    #END
 
+    #IF( #TEXT(Input_spouse_title_orig)='' )
      '' 
    #ELSE
        IF( le.Input_spouse_title_orig = (TYPEOF(le.Input_spouse_title_orig))'','',':spouse_title_orig')
    #END
 
+    #IF( #TEXT(Input_spouse_gender)='' )
      '' 
    #ELSE
        IF( le.Input_spouse_gender = (TYPEOF(le.Input_spouse_gender))'','',':spouse_gender')
    #END
 
+    #IF( #TEXT(Input_spouse_date_of_birth)='' )
      '' 
    #ELSE
        IF( le.Input_spouse_date_of_birth = (TYPEOF(le.Input_spouse_date_of_birth))'','',':spouse_date_of_birth')
    #END
 
+    #IF( #TEXT(Input_spouse_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_spouse_indicator = (TYPEOF(le.Input_spouse_indicator))'','',':spouse_indicator')
    #END
 
+    #IF( #TEXT(Input_household_income)='' )
      '' 
    #ELSE
        IF( le.Input_household_income = (TYPEOF(le.Input_household_income))'','',':household_income')
    #END
 
+    #IF( #TEXT(Input_find_income_in_1000s)='' )
      '' 
    #ELSE
        IF( le.Input_find_income_in_1000s = (TYPEOF(le.Input_find_income_in_1000s))'','',':find_income_in_1000s')
    #END
 
+    #IF( #TEXT(Input_phhincomeunder25k)='' )
      '' 
    #ELSE
        IF( le.Input_phhincomeunder25k = (TYPEOF(le.Input_phhincomeunder25k))'','',':phhincomeunder25k')
    #END
 
+    #IF( #TEXT(Input_phhincome50kplus)='' )
      '' 
    #ELSE
        IF( le.Input_phhincome50kplus = (TYPEOF(le.Input_phhincome50kplus))'','',':phhincome50kplus')
    #END
 
+    #IF( #TEXT(Input_phhincome200kplus)='' )
      '' 
    #ELSE
        IF( le.Input_phhincome200kplus = (TYPEOF(le.Input_phhincome200kplus))'','',':phhincome200kplus')
    #END
 
+    #IF( #TEXT(Input_medianhhincome)='' )
      '' 
    #ELSE
        IF( le.Input_medianhhincome = (TYPEOF(le.Input_medianhhincome))'','',':medianhhincome')
    #END
 
+    #IF( #TEXT(Input_own_rent)='' )
      '' 
    #ELSE
        IF( le.Input_own_rent = (TYPEOF(le.Input_own_rent))'','',':own_rent')
    #END
 
+    #IF( #TEXT(Input_homeowner_source_code)='' )
      '' 
    #ELSE
        IF( le.Input_homeowner_source_code = (TYPEOF(le.Input_homeowner_source_code))'','',':homeowner_source_code')
    #END
 
+    #IF( #TEXT(Input_telephone_acquisition_date)='' )
      '' 
    #ELSE
        IF( le.Input_telephone_acquisition_date = (TYPEOF(le.Input_telephone_acquisition_date))'','',':telephone_acquisition_date')
    #END
 
+    #IF( #TEXT(Input_recency_date)='' )
      '' 
    #ELSE
        IF( le.Input_recency_date = (TYPEOF(le.Input_recency_date))'','',':recency_date')
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
