 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_append_process_date = '',Input_orig_reccode = '',Input_orig_clientidnum = '',Input_orig_dlnum = '',Input_orig_personalidnum = '',Input_orig_name = '',Input_orig_street = '',Input_orig_city = '',Input_orig_state = '',Input_orig_zip = '',Input_orig_dob = '',Input_orig_sex = '',Input_orig_county = '',Input_orig_dlnorpidindicator = '',Input_orig_mailingstreet = '',Input_orig_mailingcity = '',Input_orig_mailingstate = '',Input_orig_mailingzip = '',Input_orig_optoutindicator = '',Input_orig_lf = '',Input_clean_name_prefix = '',Input_clean_name_first = '',Input_clean_name_middle = '',Input_clean_name_last = '',Input_clean_name_suffix = '',Input_clean_name_score = '',Input_clean_prim_range = '',Input_clean_predir = '',Input_clean_prim_name = '',Input_clean_addr_suffix = '',Input_clean_postdir = '',Input_clean_unit_desig = '',Input_clean_sec_range = '',Input_clean_p_city_name = '',Input_clean_v_city_name = '',Input_clean_st = '',Input_clean_zip = '',Input_clean_zip4 = '',Input_clean_cart = '',Input_clean_cr_sort_sz = '',Input_clean_lot = '',Input_clean_lot_order = '',Input_clean_dpbc = '',Input_clean_chk_digit = '',Input_clean_record_type = '',Input_clean_ace_fips_st = '',Input_clean_fipscounty = '',Input_clean_geo_lat = '',Input_clean_geo_long = '',Input_clean_msa = '',Input_clean_geo_blk = '',Input_clean_geo_match = '',Input_clean_err_stat = '',Input_addr_type = '',OutFile) := MACRO
  IMPORT SALT35,Scrubs_DL_MI;
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
 
+    #IF( #TEXT(Input_orig_reccode)='' )
      '' 
    #ELSE
        IF( le.Input_orig_reccode = (TYPEOF(le.Input_orig_reccode))'','',':orig_reccode')
    #END
 
+    #IF( #TEXT(Input_orig_clientidnum)='' )
      '' 
    #ELSE
        IF( le.Input_orig_clientidnum = (TYPEOF(le.Input_orig_clientidnum))'','',':orig_clientidnum')
    #END
 
+    #IF( #TEXT(Input_orig_dlnum)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dlnum = (TYPEOF(le.Input_orig_dlnum))'','',':orig_dlnum')
    #END
 
+    #IF( #TEXT(Input_orig_personalidnum)='' )
      '' 
    #ELSE
        IF( le.Input_orig_personalidnum = (TYPEOF(le.Input_orig_personalidnum))'','',':orig_personalidnum')
    #END
 
+    #IF( #TEXT(Input_orig_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_name = (TYPEOF(le.Input_orig_name))'','',':orig_name')
    #END
 
+    #IF( #TEXT(Input_orig_street)='' )
      '' 
    #ELSE
        IF( le.Input_orig_street = (TYPEOF(le.Input_orig_street))'','',':orig_street')
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
 
+    #IF( #TEXT(Input_orig_zip)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip = (TYPEOF(le.Input_orig_zip))'','',':orig_zip')
    #END
 
+    #IF( #TEXT(Input_orig_dob)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dob = (TYPEOF(le.Input_orig_dob))'','',':orig_dob')
    #END
 
+    #IF( #TEXT(Input_orig_sex)='' )
      '' 
    #ELSE
        IF( le.Input_orig_sex = (TYPEOF(le.Input_orig_sex))'','',':orig_sex')
    #END
 
+    #IF( #TEXT(Input_orig_county)='' )
      '' 
    #ELSE
        IF( le.Input_orig_county = (TYPEOF(le.Input_orig_county))'','',':orig_county')
    #END
 
+    #IF( #TEXT(Input_orig_dlnorpidindicator)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dlnorpidindicator = (TYPEOF(le.Input_orig_dlnorpidindicator))'','',':orig_dlnorpidindicator')
    #END
 
+    #IF( #TEXT(Input_orig_mailingstreet)='' )
      '' 
    #ELSE
        IF( le.Input_orig_mailingstreet = (TYPEOF(le.Input_orig_mailingstreet))'','',':orig_mailingstreet')
    #END
 
+    #IF( #TEXT(Input_orig_mailingcity)='' )
      '' 
    #ELSE
        IF( le.Input_orig_mailingcity = (TYPEOF(le.Input_orig_mailingcity))'','',':orig_mailingcity')
    #END
 
+    #IF( #TEXT(Input_orig_mailingstate)='' )
      '' 
    #ELSE
        IF( le.Input_orig_mailingstate = (TYPEOF(le.Input_orig_mailingstate))'','',':orig_mailingstate')
    #END
 
+    #IF( #TEXT(Input_orig_mailingzip)='' )
      '' 
    #ELSE
        IF( le.Input_orig_mailingzip = (TYPEOF(le.Input_orig_mailingzip))'','',':orig_mailingzip')
    #END
 
+    #IF( #TEXT(Input_orig_optoutindicator)='' )
      '' 
    #ELSE
        IF( le.Input_orig_optoutindicator = (TYPEOF(le.Input_orig_optoutindicator))'','',':orig_optoutindicator')
    #END
 
+    #IF( #TEXT(Input_orig_lf)='' )
      '' 
    #ELSE
        IF( le.Input_orig_lf = (TYPEOF(le.Input_orig_lf))'','',':orig_lf')
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
 
+    #IF( #TEXT(Input_clean_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_clean_prim_range = (TYPEOF(le.Input_clean_prim_range))'','',':clean_prim_range')
    #END
 
+    #IF( #TEXT(Input_clean_predir)='' )
      '' 
    #ELSE
        IF( le.Input_clean_predir = (TYPEOF(le.Input_clean_predir))'','',':clean_predir')
    #END
 
+    #IF( #TEXT(Input_clean_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_prim_name = (TYPEOF(le.Input_clean_prim_name))'','',':clean_prim_name')
    #END
 
+    #IF( #TEXT(Input_clean_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_addr_suffix = (TYPEOF(le.Input_clean_addr_suffix))'','',':clean_addr_suffix')
    #END
 
+    #IF( #TEXT(Input_clean_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_clean_postdir = (TYPEOF(le.Input_clean_postdir))'','',':clean_postdir')
    #END
 
+    #IF( #TEXT(Input_clean_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_clean_unit_desig = (TYPEOF(le.Input_clean_unit_desig))'','',':clean_unit_desig')
    #END
 
+    #IF( #TEXT(Input_clean_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_clean_sec_range = (TYPEOF(le.Input_clean_sec_range))'','',':clean_sec_range')
    #END
 
+    #IF( #TEXT(Input_clean_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_city_name = (TYPEOF(le.Input_clean_p_city_name))'','',':clean_p_city_name')
    #END
 
+    #IF( #TEXT(Input_clean_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_v_city_name = (TYPEOF(le.Input_clean_v_city_name))'','',':clean_v_city_name')
    #END
 
+    #IF( #TEXT(Input_clean_st)='' )
      '' 
    #ELSE
        IF( le.Input_clean_st = (TYPEOF(le.Input_clean_st))'','',':clean_st')
    #END
 
+    #IF( #TEXT(Input_clean_zip)='' )
      '' 
    #ELSE
        IF( le.Input_clean_zip = (TYPEOF(le.Input_clean_zip))'','',':clean_zip')
    #END
 
+    #IF( #TEXT(Input_clean_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_clean_zip4 = (TYPEOF(le.Input_clean_zip4))'','',':clean_zip4')
    #END
 
+    #IF( #TEXT(Input_clean_cart)='' )
      '' 
    #ELSE
        IF( le.Input_clean_cart = (TYPEOF(le.Input_clean_cart))'','',':clean_cart')
    #END
 
+    #IF( #TEXT(Input_clean_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_clean_cr_sort_sz = (TYPEOF(le.Input_clean_cr_sort_sz))'','',':clean_cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_clean_lot)='' )
      '' 
    #ELSE
        IF( le.Input_clean_lot = (TYPEOF(le.Input_clean_lot))'','',':clean_lot')
    #END
 
+    #IF( #TEXT(Input_clean_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_clean_lot_order = (TYPEOF(le.Input_clean_lot_order))'','',':clean_lot_order')
    #END
 
+    #IF( #TEXT(Input_clean_dpbc)='' )
      '' 
    #ELSE
        IF( le.Input_clean_dpbc = (TYPEOF(le.Input_clean_dpbc))'','',':clean_dpbc')
    #END
 
+    #IF( #TEXT(Input_clean_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_clean_chk_digit = (TYPEOF(le.Input_clean_chk_digit))'','',':clean_chk_digit')
    #END
 
+    #IF( #TEXT(Input_clean_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_clean_record_type = (TYPEOF(le.Input_clean_record_type))'','',':clean_record_type')
    #END
 
+    #IF( #TEXT(Input_clean_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_clean_ace_fips_st = (TYPEOF(le.Input_clean_ace_fips_st))'','',':clean_ace_fips_st')
    #END
 
+    #IF( #TEXT(Input_clean_fipscounty)='' )
      '' 
    #ELSE
        IF( le.Input_clean_fipscounty = (TYPEOF(le.Input_clean_fipscounty))'','',':clean_fipscounty')
    #END
 
+    #IF( #TEXT(Input_clean_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_clean_geo_lat = (TYPEOF(le.Input_clean_geo_lat))'','',':clean_geo_lat')
    #END
 
+    #IF( #TEXT(Input_clean_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_clean_geo_long = (TYPEOF(le.Input_clean_geo_long))'','',':clean_geo_long')
    #END
 
+    #IF( #TEXT(Input_clean_msa)='' )
      '' 
    #ELSE
        IF( le.Input_clean_msa = (TYPEOF(le.Input_clean_msa))'','',':clean_msa')
    #END
 
+    #IF( #TEXT(Input_clean_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_clean_geo_blk = (TYPEOF(le.Input_clean_geo_blk))'','',':clean_geo_blk')
    #END
 
+    #IF( #TEXT(Input_clean_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_clean_geo_match = (TYPEOF(le.Input_clean_geo_match))'','',':clean_geo_match')
    #END
 
+    #IF( #TEXT(Input_clean_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_clean_err_stat = (TYPEOF(le.Input_clean_err_stat))'','',':clean_err_stat')
    #END
 
+    #IF( #TEXT(Input_addr_type)='' )
      '' 
    #ELSE
        IF( le.Input_addr_type = (TYPEOF(le.Input_addr_type))'','',':addr_type')
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
