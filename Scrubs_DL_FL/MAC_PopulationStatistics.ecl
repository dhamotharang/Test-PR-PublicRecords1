 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_process_date = '',Input_issuance = '',Input_address_change = '',Input_name_change = '',Input_dob_change = '',Input_sex_change = '',Input_name = '',Input_addr1 = '',Input_city = '',Input_state = '',Input_zip = '',Input_dob = '',Input_race = '',Input_sex_flag = '',Input_license_type = '',Input_attention_flag = '',Input_dod = '',Input_restrictions = '',Input_orig_expiration_date = '',Input_lic_issue_date = '',Input_lic_endorsement = '',Input_dl_number = '',Input_ssn = '',Input_age = '',Input_new_dl_number = '',Input_personal_info_flag = '',Input_dl_orig_issue_date = '',Input_height = '',Input_oos_previous_dl_number = '',Input_oos_previous_st = '',Input_filler2 = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_cleaning_score = '',Input_addr_fix_flag = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip5 = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dpbc = '',Input_chk_digit = '',Input_rec_type = '',Input_ace_fips_st = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',OutFile) := MACRO
  IMPORT SALT34,Scrubs_DL_FL;
  #uniquename(of)
  %of% := RECORD
    SALT34.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_issuance)='' )
      '' 
    #ELSE
        IF( le.Input_issuance = (TYPEOF(le.Input_issuance))'','',':issuance')
    #END
 
+    #IF( #TEXT(Input_address_change)='' )
      '' 
    #ELSE
        IF( le.Input_address_change = (TYPEOF(le.Input_address_change))'','',':address_change')
    #END
 
+    #IF( #TEXT(Input_name_change)='' )
      '' 
    #ELSE
        IF( le.Input_name_change = (TYPEOF(le.Input_name_change))'','',':name_change')
    #END
 
+    #IF( #TEXT(Input_dob_change)='' )
      '' 
    #ELSE
        IF( le.Input_dob_change = (TYPEOF(le.Input_dob_change))'','',':dob_change')
    #END
 
+    #IF( #TEXT(Input_sex_change)='' )
      '' 
    #ELSE
        IF( le.Input_sex_change = (TYPEOF(le.Input_sex_change))'','',':sex_change')
    #END
 
+    #IF( #TEXT(Input_name)='' )
      '' 
    #ELSE
        IF( le.Input_name = (TYPEOF(le.Input_name))'','',':name')
    #END
 
+    #IF( #TEXT(Input_addr1)='' )
      '' 
    #ELSE
        IF( le.Input_addr1 = (TYPEOF(le.Input_addr1))'','',':addr1')
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
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_race)='' )
      '' 
    #ELSE
        IF( le.Input_race = (TYPEOF(le.Input_race))'','',':race')
    #END
 
+    #IF( #TEXT(Input_sex_flag)='' )
      '' 
    #ELSE
        IF( le.Input_sex_flag = (TYPEOF(le.Input_sex_flag))'','',':sex_flag')
    #END
 
+    #IF( #TEXT(Input_license_type)='' )
      '' 
    #ELSE
        IF( le.Input_license_type = (TYPEOF(le.Input_license_type))'','',':license_type')
    #END
 
+    #IF( #TEXT(Input_attention_flag)='' )
      '' 
    #ELSE
        IF( le.Input_attention_flag = (TYPEOF(le.Input_attention_flag))'','',':attention_flag')
    #END
 
+    #IF( #TEXT(Input_dod)='' )
      '' 
    #ELSE
        IF( le.Input_dod = (TYPEOF(le.Input_dod))'','',':dod')
    #END
 
+    #IF( #TEXT(Input_restrictions)='' )
      '' 
    #ELSE
        IF( le.Input_restrictions = (TYPEOF(le.Input_restrictions))'','',':restrictions')
    #END
 
+    #IF( #TEXT(Input_orig_expiration_date)='' )
      '' 
    #ELSE
        IF( le.Input_orig_expiration_date = (TYPEOF(le.Input_orig_expiration_date))'','',':orig_expiration_date')
    #END
 
+    #IF( #TEXT(Input_lic_issue_date)='' )
      '' 
    #ELSE
        IF( le.Input_lic_issue_date = (TYPEOF(le.Input_lic_issue_date))'','',':lic_issue_date')
    #END
 
+    #IF( #TEXT(Input_lic_endorsement)='' )
      '' 
    #ELSE
        IF( le.Input_lic_endorsement = (TYPEOF(le.Input_lic_endorsement))'','',':lic_endorsement')
    #END
 
+    #IF( #TEXT(Input_dl_number)='' )
      '' 
    #ELSE
        IF( le.Input_dl_number = (TYPEOF(le.Input_dl_number))'','',':dl_number')
    #END
 
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
 
+    #IF( #TEXT(Input_age)='' )
      '' 
    #ELSE
        IF( le.Input_age = (TYPEOF(le.Input_age))'','',':age')
    #END
 
+    #IF( #TEXT(Input_new_dl_number)='' )
      '' 
    #ELSE
        IF( le.Input_new_dl_number = (TYPEOF(le.Input_new_dl_number))'','',':new_dl_number')
    #END
 
+    #IF( #TEXT(Input_personal_info_flag)='' )
      '' 
    #ELSE
        IF( le.Input_personal_info_flag = (TYPEOF(le.Input_personal_info_flag))'','',':personal_info_flag')
    #END
 
+    #IF( #TEXT(Input_dl_orig_issue_date)='' )
      '' 
    #ELSE
        IF( le.Input_dl_orig_issue_date = (TYPEOF(le.Input_dl_orig_issue_date))'','',':dl_orig_issue_date')
    #END
 
+    #IF( #TEXT(Input_height)='' )
      '' 
    #ELSE
        IF( le.Input_height = (TYPEOF(le.Input_height))'','',':height')
    #END
 
+    #IF( #TEXT(Input_oos_previous_dl_number)='' )
      '' 
    #ELSE
        IF( le.Input_oos_previous_dl_number = (TYPEOF(le.Input_oos_previous_dl_number))'','',':oos_previous_dl_number')
    #END
 
+    #IF( #TEXT(Input_oos_previous_st)='' )
      '' 
    #ELSE
        IF( le.Input_oos_previous_st = (TYPEOF(le.Input_oos_previous_st))'','',':oos_previous_st')
    #END
 
+    #IF( #TEXT(Input_filler2)='' )
      '' 
    #ELSE
        IF( le.Input_filler2 = (TYPEOF(le.Input_filler2))'','',':filler2')
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
 
+    #IF( #TEXT(Input_addr_fix_flag)='' )
      '' 
    #ELSE
        IF( le.Input_addr_fix_flag = (TYPEOF(le.Input_addr_fix_flag))'','',':addr_fix_flag')
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
