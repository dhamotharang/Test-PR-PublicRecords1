 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_append_process_date = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_lst_name = '',Input_fst_name = '',Input_mid_name = '',Input_dob = '',Input_dln = '',Input_perm_cd_1 = '',Input_perm_cd_2 = '',Input_perm_cd_3 = '',Input_perm_cd_4 = '',Input_eff_dt = '',Input_m_addr = '',Input_m_city = '',Input_m_state = '',Input_m_zip = '',Input_p_addr = '',Input_p_city = '',Input_p_state = '',Input_p_zip = '',Input_lf = '',Input_clean_name_prefix = '',Input_clean_name_first = '',Input_clean_name_middle = '',Input_clean_name_last = '',Input_clean_name_suffix = '',Input_clean_name_score = '',Input_clean_m_prim_range = '',Input_clean_m_predir = '',Input_clean_m_prim_name = '',Input_clean_m_addr_suffix = '',Input_clean_m_postdir = '',Input_clean_m_unit_desig = '',Input_clean_m_sec_range = '',Input_clean_m_p_city_name = '',Input_clean_m_v_city_name = '',Input_clean_m_st = '',Input_clean_m_zip = '',Input_clean_m_zip4 = '',Input_clean_m_cart = '',Input_clean_m_cr_sort_sz = '',Input_clean_m_lot = '',Input_clean_m_lot_order = '',Input_clean_m_dpbc = '',Input_clean_m_chk_digit = '',Input_clean_m_record_type = '',Input_clean_m_ace_fips_st = '',Input_clean_m_fipscounty = '',Input_clean_m_geo_lat = '',Input_clean_m_geo_long = '',Input_clean_m_msa = '',Input_clean_m_geo_blk = '',Input_clean_m_geo_match = '',Input_clean_m_err_stat = '',Input_clean_p_prim_range = '',Input_clean_p_predir = '',Input_clean_p_prim_name = '',Input_clean_p_addr_suffix = '',Input_clean_p_postdir = '',Input_clean_p_unit_desig = '',Input_clean_p_sec_range = '',Input_clean_p_p_city_name = '',Input_clean_p_v_city_name = '',Input_clean_p_st = '',Input_clean_p_zip = '',Input_clean_p_zip4 = '',Input_clean_p_cart = '',Input_clean_p_cr_sort_sz = '',Input_clean_p_lot = '',Input_clean_p_lot_order = '',Input_clean_p_dpbc = '',Input_clean_p_chk_digit = '',Input_clean_p_record_type = '',Input_clean_p_ace_fips_st = '',Input_clean_p_fipscounty = '',Input_clean_p_geo_lat = '',Input_clean_p_geo_long = '',Input_clean_p_msa = '',Input_clean_p_geo_blk = '',Input_clean_p_geo_match = '',Input_clean_p_err_stat = '',OutFile) := MACRO
  IMPORT SALT35,Scrubs_DL_NV;
  #uniquename(of)
  %of% := RECORD
    SALT35.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_append_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_append_process_date = (TYPEOF(le.Input_append_process_date))'','',':append_process_date')
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
 
+    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_first_reported = (TYPEOF(le.Input_dt_vendor_first_reported))'','',':dt_vendor_first_reported')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_last_reported = (TYPEOF(le.Input_dt_vendor_last_reported))'','',':dt_vendor_last_reported')
    #END
 
+    #IF( #TEXT(Input_lst_name)='' )
      '' 
    #ELSE
        IF( le.Input_lst_name = (TYPEOF(le.Input_lst_name))'','',':lst_name')
    #END
 
+    #IF( #TEXT(Input_fst_name)='' )
      '' 
    #ELSE
        IF( le.Input_fst_name = (TYPEOF(le.Input_fst_name))'','',':fst_name')
    #END
 
+    #IF( #TEXT(Input_mid_name)='' )
      '' 
    #ELSE
        IF( le.Input_mid_name = (TYPEOF(le.Input_mid_name))'','',':mid_name')
    #END
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_dln)='' )
      '' 
    #ELSE
        IF( le.Input_dln = (TYPEOF(le.Input_dln))'','',':dln')
    #END
 
+    #IF( #TEXT(Input_perm_cd_1)='' )
      '' 
    #ELSE
        IF( le.Input_perm_cd_1 = (TYPEOF(le.Input_perm_cd_1))'','',':perm_cd_1')
    #END
 
+    #IF( #TEXT(Input_perm_cd_2)='' )
      '' 
    #ELSE
        IF( le.Input_perm_cd_2 = (TYPEOF(le.Input_perm_cd_2))'','',':perm_cd_2')
    #END
 
+    #IF( #TEXT(Input_perm_cd_3)='' )
      '' 
    #ELSE
        IF( le.Input_perm_cd_3 = (TYPEOF(le.Input_perm_cd_3))'','',':perm_cd_3')
    #END
 
+    #IF( #TEXT(Input_perm_cd_4)='' )
      '' 
    #ELSE
        IF( le.Input_perm_cd_4 = (TYPEOF(le.Input_perm_cd_4))'','',':perm_cd_4')
    #END
 
+    #IF( #TEXT(Input_eff_dt)='' )
      '' 
    #ELSE
        IF( le.Input_eff_dt = (TYPEOF(le.Input_eff_dt))'','',':eff_dt')
    #END
 
+    #IF( #TEXT(Input_m_addr)='' )
      '' 
    #ELSE
        IF( le.Input_m_addr = (TYPEOF(le.Input_m_addr))'','',':m_addr')
    #END
 
+    #IF( #TEXT(Input_m_city)='' )
      '' 
    #ELSE
        IF( le.Input_m_city = (TYPEOF(le.Input_m_city))'','',':m_city')
    #END
 
+    #IF( #TEXT(Input_m_state)='' )
      '' 
    #ELSE
        IF( le.Input_m_state = (TYPEOF(le.Input_m_state))'','',':m_state')
    #END
 
+    #IF( #TEXT(Input_m_zip)='' )
      '' 
    #ELSE
        IF( le.Input_m_zip = (TYPEOF(le.Input_m_zip))'','',':m_zip')
    #END
 
+    #IF( #TEXT(Input_p_addr)='' )
      '' 
    #ELSE
        IF( le.Input_p_addr = (TYPEOF(le.Input_p_addr))'','',':p_addr')
    #END
 
+    #IF( #TEXT(Input_p_city)='' )
      '' 
    #ELSE
        IF( le.Input_p_city = (TYPEOF(le.Input_p_city))'','',':p_city')
    #END
 
+    #IF( #TEXT(Input_p_state)='' )
      '' 
    #ELSE
        IF( le.Input_p_state = (TYPEOF(le.Input_p_state))'','',':p_state')
    #END
 
+    #IF( #TEXT(Input_p_zip)='' )
      '' 
    #ELSE
        IF( le.Input_p_zip = (TYPEOF(le.Input_p_zip))'','',':p_zip')
    #END
 
+    #IF( #TEXT(Input_lf)='' )
      '' 
    #ELSE
        IF( le.Input_lf = (TYPEOF(le.Input_lf))'','',':lf')
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
 
+    #IF( #TEXT(Input_clean_name_score)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_score = (TYPEOF(le.Input_clean_name_score))'','',':clean_name_score')
    #END
 
+    #IF( #TEXT(Input_clean_m_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_prim_range = (TYPEOF(le.Input_clean_m_prim_range))'','',':clean_m_prim_range')
    #END
 
+    #IF( #TEXT(Input_clean_m_predir)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_predir = (TYPEOF(le.Input_clean_m_predir))'','',':clean_m_predir')
    #END
 
+    #IF( #TEXT(Input_clean_m_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_prim_name = (TYPEOF(le.Input_clean_m_prim_name))'','',':clean_m_prim_name')
    #END
 
+    #IF( #TEXT(Input_clean_m_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_addr_suffix = (TYPEOF(le.Input_clean_m_addr_suffix))'','',':clean_m_addr_suffix')
    #END
 
+    #IF( #TEXT(Input_clean_m_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_postdir = (TYPEOF(le.Input_clean_m_postdir))'','',':clean_m_postdir')
    #END
 
+    #IF( #TEXT(Input_clean_m_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_unit_desig = (TYPEOF(le.Input_clean_m_unit_desig))'','',':clean_m_unit_desig')
    #END
 
+    #IF( #TEXT(Input_clean_m_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_sec_range = (TYPEOF(le.Input_clean_m_sec_range))'','',':clean_m_sec_range')
    #END
 
+    #IF( #TEXT(Input_clean_m_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_p_city_name = (TYPEOF(le.Input_clean_m_p_city_name))'','',':clean_m_p_city_name')
    #END
 
+    #IF( #TEXT(Input_clean_m_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_v_city_name = (TYPEOF(le.Input_clean_m_v_city_name))'','',':clean_m_v_city_name')
    #END
 
+    #IF( #TEXT(Input_clean_m_st)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_st = (TYPEOF(le.Input_clean_m_st))'','',':clean_m_st')
    #END
 
+    #IF( #TEXT(Input_clean_m_zip)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_zip = (TYPEOF(le.Input_clean_m_zip))'','',':clean_m_zip')
    #END
 
+    #IF( #TEXT(Input_clean_m_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_zip4 = (TYPEOF(le.Input_clean_m_zip4))'','',':clean_m_zip4')
    #END
 
+    #IF( #TEXT(Input_clean_m_cart)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_cart = (TYPEOF(le.Input_clean_m_cart))'','',':clean_m_cart')
    #END
 
+    #IF( #TEXT(Input_clean_m_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_cr_sort_sz = (TYPEOF(le.Input_clean_m_cr_sort_sz))'','',':clean_m_cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_clean_m_lot)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_lot = (TYPEOF(le.Input_clean_m_lot))'','',':clean_m_lot')
    #END
 
+    #IF( #TEXT(Input_clean_m_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_lot_order = (TYPEOF(le.Input_clean_m_lot_order))'','',':clean_m_lot_order')
    #END
 
+    #IF( #TEXT(Input_clean_m_dpbc)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_dpbc = (TYPEOF(le.Input_clean_m_dpbc))'','',':clean_m_dpbc')
    #END
 
+    #IF( #TEXT(Input_clean_m_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_chk_digit = (TYPEOF(le.Input_clean_m_chk_digit))'','',':clean_m_chk_digit')
    #END
 
+    #IF( #TEXT(Input_clean_m_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_record_type = (TYPEOF(le.Input_clean_m_record_type))'','',':clean_m_record_type')
    #END
 
+    #IF( #TEXT(Input_clean_m_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_ace_fips_st = (TYPEOF(le.Input_clean_m_ace_fips_st))'','',':clean_m_ace_fips_st')
    #END
 
+    #IF( #TEXT(Input_clean_m_fipscounty)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_fipscounty = (TYPEOF(le.Input_clean_m_fipscounty))'','',':clean_m_fipscounty')
    #END
 
+    #IF( #TEXT(Input_clean_m_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_geo_lat = (TYPEOF(le.Input_clean_m_geo_lat))'','',':clean_m_geo_lat')
    #END
 
+    #IF( #TEXT(Input_clean_m_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_geo_long = (TYPEOF(le.Input_clean_m_geo_long))'','',':clean_m_geo_long')
    #END
 
+    #IF( #TEXT(Input_clean_m_msa)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_msa = (TYPEOF(le.Input_clean_m_msa))'','',':clean_m_msa')
    #END
 
+    #IF( #TEXT(Input_clean_m_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_geo_blk = (TYPEOF(le.Input_clean_m_geo_blk))'','',':clean_m_geo_blk')
    #END
 
+    #IF( #TEXT(Input_clean_m_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_geo_match = (TYPEOF(le.Input_clean_m_geo_match))'','',':clean_m_geo_match')
    #END
 
+    #IF( #TEXT(Input_clean_m_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_clean_m_err_stat = (TYPEOF(le.Input_clean_m_err_stat))'','',':clean_m_err_stat')
    #END
 
+    #IF( #TEXT(Input_clean_p_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_prim_range = (TYPEOF(le.Input_clean_p_prim_range))'','',':clean_p_prim_range')
    #END
 
+    #IF( #TEXT(Input_clean_p_predir)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_predir = (TYPEOF(le.Input_clean_p_predir))'','',':clean_p_predir')
    #END
 
+    #IF( #TEXT(Input_clean_p_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_prim_name = (TYPEOF(le.Input_clean_p_prim_name))'','',':clean_p_prim_name')
    #END
 
+    #IF( #TEXT(Input_clean_p_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_addr_suffix = (TYPEOF(le.Input_clean_p_addr_suffix))'','',':clean_p_addr_suffix')
    #END
 
+    #IF( #TEXT(Input_clean_p_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_postdir = (TYPEOF(le.Input_clean_p_postdir))'','',':clean_p_postdir')
    #END
 
+    #IF( #TEXT(Input_clean_p_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_unit_desig = (TYPEOF(le.Input_clean_p_unit_desig))'','',':clean_p_unit_desig')
    #END
 
+    #IF( #TEXT(Input_clean_p_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_sec_range = (TYPEOF(le.Input_clean_p_sec_range))'','',':clean_p_sec_range')
    #END
 
+    #IF( #TEXT(Input_clean_p_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_p_city_name = (TYPEOF(le.Input_clean_p_p_city_name))'','',':clean_p_p_city_name')
    #END
 
+    #IF( #TEXT(Input_clean_p_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_v_city_name = (TYPEOF(le.Input_clean_p_v_city_name))'','',':clean_p_v_city_name')
    #END
 
+    #IF( #TEXT(Input_clean_p_st)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_st = (TYPEOF(le.Input_clean_p_st))'','',':clean_p_st')
    #END
 
+    #IF( #TEXT(Input_clean_p_zip)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_zip = (TYPEOF(le.Input_clean_p_zip))'','',':clean_p_zip')
    #END
 
+    #IF( #TEXT(Input_clean_p_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_zip4 = (TYPEOF(le.Input_clean_p_zip4))'','',':clean_p_zip4')
    #END
 
+    #IF( #TEXT(Input_clean_p_cart)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_cart = (TYPEOF(le.Input_clean_p_cart))'','',':clean_p_cart')
    #END
 
+    #IF( #TEXT(Input_clean_p_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_cr_sort_sz = (TYPEOF(le.Input_clean_p_cr_sort_sz))'','',':clean_p_cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_clean_p_lot)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_lot = (TYPEOF(le.Input_clean_p_lot))'','',':clean_p_lot')
    #END
 
+    #IF( #TEXT(Input_clean_p_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_lot_order = (TYPEOF(le.Input_clean_p_lot_order))'','',':clean_p_lot_order')
    #END
 
+    #IF( #TEXT(Input_clean_p_dpbc)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_dpbc = (TYPEOF(le.Input_clean_p_dpbc))'','',':clean_p_dpbc')
    #END
 
+    #IF( #TEXT(Input_clean_p_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_chk_digit = (TYPEOF(le.Input_clean_p_chk_digit))'','',':clean_p_chk_digit')
    #END
 
+    #IF( #TEXT(Input_clean_p_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_record_type = (TYPEOF(le.Input_clean_p_record_type))'','',':clean_p_record_type')
    #END
 
+    #IF( #TEXT(Input_clean_p_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_ace_fips_st = (TYPEOF(le.Input_clean_p_ace_fips_st))'','',':clean_p_ace_fips_st')
    #END
 
+    #IF( #TEXT(Input_clean_p_fipscounty)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_fipscounty = (TYPEOF(le.Input_clean_p_fipscounty))'','',':clean_p_fipscounty')
    #END
 
+    #IF( #TEXT(Input_clean_p_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_geo_lat = (TYPEOF(le.Input_clean_p_geo_lat))'','',':clean_p_geo_lat')
    #END
 
+    #IF( #TEXT(Input_clean_p_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_geo_long = (TYPEOF(le.Input_clean_p_geo_long))'','',':clean_p_geo_long')
    #END
 
+    #IF( #TEXT(Input_clean_p_msa)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_msa = (TYPEOF(le.Input_clean_p_msa))'','',':clean_p_msa')
    #END
 
+    #IF( #TEXT(Input_clean_p_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_geo_blk = (TYPEOF(le.Input_clean_p_geo_blk))'','',':clean_p_geo_blk')
    #END
 
+    #IF( #TEXT(Input_clean_p_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_geo_match = (TYPEOF(le.Input_clean_p_geo_match))'','',':clean_p_geo_match')
    #END
 
+    #IF( #TEXT(Input_clean_p_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_err_stat = (TYPEOF(le.Input_clean_p_err_stat))'','',':clean_p_err_stat')
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
