 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_process_date = '',Input_orig_last_name = '',Input_orig_first_name = '',Input_orig_middle_name = '',Input_orig_name_suffix = '',Input_orig_street_address1 = '',Input_orig_street_address2 = '',Input_orig_city = '',Input_orig_state = '',Input_orig_zip_code = '',Input_orig_dl_number = '',Input_orig_license_type = '',Input_orig_sex = '',Input_orig_height_ft = '',Input_orig_height_in = '',Input_orig_weight = '',Input_orig_eye_color = '',Input_orig_hair_color = '',Input_orig_restrictions1 = '',Input_orig_restrictions2 = '',Input_orig_restrictions3 = '',Input_orig_restrictions4 = '',Input_orig_restrictions5 = '',Input_orig_endorsements1 = '',Input_orig_endorsements2 = '',Input_orig_endorsements3 = '',Input_orig_endorsements4 = '',Input_orig_endorsements5 = '',Input_orig_dob = '',Input_orig_issue_date = '',Input_orig_expire_date = '',Input_orig_non_cdl_status = '',Input_orig_cdl_status = '',Input_orig_race = '',Input_orig_crlf = '',Input_clean_name_prefix = '',Input_clean_name_first = '',Input_clean_name_middle = '',Input_clean_name_last = '',Input_clean_name_suffix = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_cln_zip5 = '',Input_cln_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dpbc = '',Input_chk_digit = '',Input_rec_type = '',Input_ace_fips_st = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',OutFile) := MACRO
  IMPORT SALT35,Scrubs_DL_TN;
  #uniquename(of)
  %of% := RECORD
    SALT35.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_orig_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_last_name = (TYPEOF(le.Input_orig_last_name))'','',':orig_last_name')
    #END
 
+    #IF( #TEXT(Input_orig_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_first_name = (TYPEOF(le.Input_orig_first_name))'','',':orig_first_name')
    #END
 
+    #IF( #TEXT(Input_orig_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_middle_name = (TYPEOF(le.Input_orig_middle_name))'','',':orig_middle_name')
    #END
 
+    #IF( #TEXT(Input_orig_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_orig_name_suffix = (TYPEOF(le.Input_orig_name_suffix))'','',':orig_name_suffix')
    #END
 
+    #IF( #TEXT(Input_orig_street_address1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_street_address1 = (TYPEOF(le.Input_orig_street_address1))'','',':orig_street_address1')
    #END
 
+    #IF( #TEXT(Input_orig_street_address2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_street_address2 = (TYPEOF(le.Input_orig_street_address2))'','',':orig_street_address2')
    #END
 
+    #IF( #TEXT(Input_orig_city)='' )
      '' 
    #ELSE
        IF( le.Input_orig_city = (TYPEOF(le.Input_orig_city))'','',':orig_city')
    #END
 
+    #IF( #TEXT(Input_orig_state)='' )
      '' 
    #ELSE
        IF( le.Input_orig_state = (TYPEOF(le.Input_orig_state))'','',':orig_state')
    #END
 
+    #IF( #TEXT(Input_orig_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip_code = (TYPEOF(le.Input_orig_zip_code))'','',':orig_zip_code')
    #END
 
+    #IF( #TEXT(Input_orig_dl_number)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dl_number = (TYPEOF(le.Input_orig_dl_number))'','',':orig_dl_number')
    #END
 
+    #IF( #TEXT(Input_orig_license_type)='' )
      '' 
    #ELSE
        IF( le.Input_orig_license_type = (TYPEOF(le.Input_orig_license_type))'','',':orig_license_type')
    #END
 
+    #IF( #TEXT(Input_orig_sex)='' )
      '' 
    #ELSE
        IF( le.Input_orig_sex = (TYPEOF(le.Input_orig_sex))'','',':orig_sex')
    #END
 
+    #IF( #TEXT(Input_orig_height_ft)='' )
      '' 
    #ELSE
        IF( le.Input_orig_height_ft = (TYPEOF(le.Input_orig_height_ft))'','',':orig_height_ft')
    #END
 
+    #IF( #TEXT(Input_orig_height_in)='' )
      '' 
    #ELSE
        IF( le.Input_orig_height_in = (TYPEOF(le.Input_orig_height_in))'','',':orig_height_in')
    #END
 
+    #IF( #TEXT(Input_orig_weight)='' )
      '' 
    #ELSE
        IF( le.Input_orig_weight = (TYPEOF(le.Input_orig_weight))'','',':orig_weight')
    #END
 
+    #IF( #TEXT(Input_orig_eye_color)='' )
      '' 
    #ELSE
        IF( le.Input_orig_eye_color = (TYPEOF(le.Input_orig_eye_color))'','',':orig_eye_color')
    #END
 
+    #IF( #TEXT(Input_orig_hair_color)='' )
      '' 
    #ELSE
        IF( le.Input_orig_hair_color = (TYPEOF(le.Input_orig_hair_color))'','',':orig_hair_color')
    #END
 
+    #IF( #TEXT(Input_orig_restrictions1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_restrictions1 = (TYPEOF(le.Input_orig_restrictions1))'','',':orig_restrictions1')
    #END
 
+    #IF( #TEXT(Input_orig_restrictions2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_restrictions2 = (TYPEOF(le.Input_orig_restrictions2))'','',':orig_restrictions2')
    #END
 
+    #IF( #TEXT(Input_orig_restrictions3)='' )
      '' 
    #ELSE
        IF( le.Input_orig_restrictions3 = (TYPEOF(le.Input_orig_restrictions3))'','',':orig_restrictions3')
    #END
 
+    #IF( #TEXT(Input_orig_restrictions4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_restrictions4 = (TYPEOF(le.Input_orig_restrictions4))'','',':orig_restrictions4')
    #END
 
+    #IF( #TEXT(Input_orig_restrictions5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_restrictions5 = (TYPEOF(le.Input_orig_restrictions5))'','',':orig_restrictions5')
    #END
 
+    #IF( #TEXT(Input_orig_endorsements1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_endorsements1 = (TYPEOF(le.Input_orig_endorsements1))'','',':orig_endorsements1')
    #END
 
+    #IF( #TEXT(Input_orig_endorsements2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_endorsements2 = (TYPEOF(le.Input_orig_endorsements2))'','',':orig_endorsements2')
    #END
 
+    #IF( #TEXT(Input_orig_endorsements3)='' )
      '' 
    #ELSE
        IF( le.Input_orig_endorsements3 = (TYPEOF(le.Input_orig_endorsements3))'','',':orig_endorsements3')
    #END
 
+    #IF( #TEXT(Input_orig_endorsements4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_endorsements4 = (TYPEOF(le.Input_orig_endorsements4))'','',':orig_endorsements4')
    #END
 
+    #IF( #TEXT(Input_orig_endorsements5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_endorsements5 = (TYPEOF(le.Input_orig_endorsements5))'','',':orig_endorsements5')
    #END
 
+    #IF( #TEXT(Input_orig_dob)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dob = (TYPEOF(le.Input_orig_dob))'','',':orig_dob')
    #END
 
+    #IF( #TEXT(Input_orig_issue_date)='' )
      '' 
    #ELSE
        IF( le.Input_orig_issue_date = (TYPEOF(le.Input_orig_issue_date))'','',':orig_issue_date')
    #END
 
+    #IF( #TEXT(Input_orig_expire_date)='' )
      '' 
    #ELSE
        IF( le.Input_orig_expire_date = (TYPEOF(le.Input_orig_expire_date))'','',':orig_expire_date')
    #END
 
+    #IF( #TEXT(Input_orig_non_cdl_status)='' )
      '' 
    #ELSE
        IF( le.Input_orig_non_cdl_status = (TYPEOF(le.Input_orig_non_cdl_status))'','',':orig_non_cdl_status')
    #END
 
+    #IF( #TEXT(Input_orig_cdl_status)='' )
      '' 
    #ELSE
        IF( le.Input_orig_cdl_status = (TYPEOF(le.Input_orig_cdl_status))'','',':orig_cdl_status')
    #END
 
+    #IF( #TEXT(Input_orig_race)='' )
      '' 
    #ELSE
        IF( le.Input_orig_race = (TYPEOF(le.Input_orig_race))'','',':orig_race')
    #END
 
+    #IF( #TEXT(Input_orig_crlf)='' )
      '' 
    #ELSE
        IF( le.Input_orig_crlf = (TYPEOF(le.Input_orig_crlf))'','',':orig_crlf')
    #END
 
+    #IF( #TEXT(Input_clean_name_prefix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_prefix = (TYPEOF(le.Input_clean_name_prefix))'','',':clean_name_prefix')
    #END
 
+    #IF( #TEXT(Input_clean_name_first)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_first = (TYPEOF(le.Input_clean_name_first))'','',':clean_name_first')
    #END
 
+    #IF( #TEXT(Input_clean_name_middle)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_middle = (TYPEOF(le.Input_clean_name_middle))'','',':clean_name_middle')
    #END
 
+    #IF( #TEXT(Input_clean_name_last)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_last = (TYPEOF(le.Input_clean_name_last))'','',':clean_name_last')
    #END
 
+    #IF( #TEXT(Input_clean_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_suffix = (TYPEOF(le.Input_clean_name_suffix))'','',':clean_name_suffix')
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
