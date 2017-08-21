 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_mbslayout_company_id = '',Input_mbslayout_global_company_id = '',Input_allowlayout_allowflags = '',Input_businfolayout_primary_market_code = '',Input_businfolayout_secondary_market_code = '',Input_businfolayout_industry_1_code = '',Input_businfolayout_industry_2_code = '',Input_businfolayout_sub_market = '',Input_businfolayout_vertical = '',Input_businfolayout_use = '',Input_businfolayout_industry = '',Input_persondatalayout_full_name = '',Input_persondatalayout_first_name = '',Input_persondatalayout_middle_name = '',Input_persondatalayout_last_name = '',Input_persondatalayout_address = '',Input_persondatalayout_city = '',Input_persondatalayout_state = '',Input_persondatalayout_zip = '',Input_persondatalayout_personal_phone = '',Input_persondatalayout_work_phone = '',Input_persondatalayout_dob = '',Input_persondatalayout_dl = '',Input_persondatalayout_dl_st = '',Input_persondatalayout_email_address = '',Input_persondatalayout_ssn = '',Input_persondatalayout_linkid = '',Input_persondatalayout_ipaddr = '',Input_persondatalayout_title = '',Input_persondatalayout_fname = '',Input_persondatalayout_mname = '',Input_persondatalayout_lname = '',Input_persondatalayout_name_suffix = '',Input_persondatalayout_prim_range = '',Input_persondatalayout_predir = '',Input_persondatalayout_prim_name = '',Input_persondatalayout_addr_suffix = '',Input_persondatalayout_postdir = '',Input_persondatalayout_unit_desig = '',Input_persondatalayout_sec_range = '',Input_persondatalayout_v_city_name = '',Input_persondatalayout_st = '',Input_persondatalayout_zip5 = '',Input_persondatalayout_zip4 = '',Input_persondatalayout_addr_rec_type = '',Input_persondatalayout_fips_state = '',Input_persondatalayout_fips_county = '',Input_persondatalayout_geo_lat = '',Input_persondatalayout_geo_long = '',Input_persondatalayout_cbsa = '',Input_persondatalayout_geo_blk = '',Input_persondatalayout_geo_match = '',Input_persondatalayout_err_stat = '',Input_persondatalayout_appended_ssn = '',Input_persondatalayout_appended_adl = '',Input_permissablelayout_glb_purpose = '',Input_permissablelayout_dppa_purpose = '',Input_permissablelayout_fcra_purpose = '',Input_searchlayout_datetime = '',Input_searchlayout_start_monitor = '',Input_searchlayout_stop_monitor = '',Input_searchlayout_login_history_id = '',Input_searchlayout_transaction_id = '',Input_searchlayout_sequence_number = '',Input_searchlayout_method = '',Input_searchlayout_product_code = '',Input_searchlayout_transaction_type = '',Input_searchlayout_function_description = '',Input_searchlayout_ipaddr = '',Input_fraudpoint_score = '',OutFile) := MACRO
  IMPORT SALT32,Scrubs_Inquiry_AccLogs_Update;
  #uniquename(of)
  %of% := RECORD
    SALT32.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_mbslayout_company_id)='' )
      '' 
    #ELSE
        IF( le.Input_mbslayout_company_id = (TYPEOF(le.Input_mbslayout_company_id))'','',':mbslayout_company_id')
    #END
 
+    #IF( #TEXT(Input_mbslayout_global_company_id)='' )
      '' 
    #ELSE
        IF( le.Input_mbslayout_global_company_id = (TYPEOF(le.Input_mbslayout_global_company_id))'','',':mbslayout_global_company_id')
    #END
 
+    #IF( #TEXT(Input_allowlayout_allowflags)='' )
      '' 
    #ELSE
        IF( le.Input_allowlayout_allowflags = (TYPEOF(le.Input_allowlayout_allowflags))'','',':allowlayout_allowflags')
    #END
 
+    #IF( #TEXT(Input_businfolayout_primary_market_code)='' )
      '' 
    #ELSE
        IF( le.Input_businfolayout_primary_market_code = (TYPEOF(le.Input_businfolayout_primary_market_code))'','',':businfolayout_primary_market_code')
    #END
 
+    #IF( #TEXT(Input_businfolayout_secondary_market_code)='' )
      '' 
    #ELSE
        IF( le.Input_businfolayout_secondary_market_code = (TYPEOF(le.Input_businfolayout_secondary_market_code))'','',':businfolayout_secondary_market_code')
    #END
 
+    #IF( #TEXT(Input_businfolayout_industry_1_code)='' )
      '' 
    #ELSE
        IF( le.Input_businfolayout_industry_1_code = (TYPEOF(le.Input_businfolayout_industry_1_code))'','',':businfolayout_industry_1_code')
    #END
 
+    #IF( #TEXT(Input_businfolayout_industry_2_code)='' )
      '' 
    #ELSE
        IF( le.Input_businfolayout_industry_2_code = (TYPEOF(le.Input_businfolayout_industry_2_code))'','',':businfolayout_industry_2_code')
    #END
 
+    #IF( #TEXT(Input_businfolayout_sub_market)='' )
      '' 
    #ELSE
        IF( le.Input_businfolayout_sub_market = (TYPEOF(le.Input_businfolayout_sub_market))'','',':businfolayout_sub_market')
    #END
 
+    #IF( #TEXT(Input_businfolayout_vertical)='' )
      '' 
    #ELSE
        IF( le.Input_businfolayout_vertical = (TYPEOF(le.Input_businfolayout_vertical))'','',':businfolayout_vertical')
    #END
 
+    #IF( #TEXT(Input_businfolayout_use)='' )
      '' 
    #ELSE
        IF( le.Input_businfolayout_use = (TYPEOF(le.Input_businfolayout_use))'','',':businfolayout_use')
    #END
 
+    #IF( #TEXT(Input_businfolayout_industry)='' )
      '' 
    #ELSE
        IF( le.Input_businfolayout_industry = (TYPEOF(le.Input_businfolayout_industry))'','',':businfolayout_industry')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_full_name)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_full_name = (TYPEOF(le.Input_persondatalayout_full_name))'','',':persondatalayout_full_name')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_first_name = (TYPEOF(le.Input_persondatalayout_first_name))'','',':persondatalayout_first_name')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_middle_name = (TYPEOF(le.Input_persondatalayout_middle_name))'','',':persondatalayout_middle_name')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_last_name = (TYPEOF(le.Input_persondatalayout_last_name))'','',':persondatalayout_last_name')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_address)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_address = (TYPEOF(le.Input_persondatalayout_address))'','',':persondatalayout_address')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_city)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_city = (TYPEOF(le.Input_persondatalayout_city))'','',':persondatalayout_city')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_state)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_state = (TYPEOF(le.Input_persondatalayout_state))'','',':persondatalayout_state')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_zip)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_zip = (TYPEOF(le.Input_persondatalayout_zip))'','',':persondatalayout_zip')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_personal_phone)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_personal_phone = (TYPEOF(le.Input_persondatalayout_personal_phone))'','',':persondatalayout_personal_phone')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_work_phone)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_work_phone = (TYPEOF(le.Input_persondatalayout_work_phone))'','',':persondatalayout_work_phone')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_dob)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_dob = (TYPEOF(le.Input_persondatalayout_dob))'','',':persondatalayout_dob')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_dl)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_dl = (TYPEOF(le.Input_persondatalayout_dl))'','',':persondatalayout_dl')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_dl_st)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_dl_st = (TYPEOF(le.Input_persondatalayout_dl_st))'','',':persondatalayout_dl_st')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_email_address)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_email_address = (TYPEOF(le.Input_persondatalayout_email_address))'','',':persondatalayout_email_address')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_ssn = (TYPEOF(le.Input_persondatalayout_ssn))'','',':persondatalayout_ssn')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_linkid)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_linkid = (TYPEOF(le.Input_persondatalayout_linkid))'','',':persondatalayout_linkid')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_ipaddr)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_ipaddr = (TYPEOF(le.Input_persondatalayout_ipaddr))'','',':persondatalayout_ipaddr')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_title)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_title = (TYPEOF(le.Input_persondatalayout_title))'','',':persondatalayout_title')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_fname)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_fname = (TYPEOF(le.Input_persondatalayout_fname))'','',':persondatalayout_fname')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_mname)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_mname = (TYPEOF(le.Input_persondatalayout_mname))'','',':persondatalayout_mname')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_lname)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_lname = (TYPEOF(le.Input_persondatalayout_lname))'','',':persondatalayout_lname')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_name_suffix = (TYPEOF(le.Input_persondatalayout_name_suffix))'','',':persondatalayout_name_suffix')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_prim_range = (TYPEOF(le.Input_persondatalayout_prim_range))'','',':persondatalayout_prim_range')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_predir)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_predir = (TYPEOF(le.Input_persondatalayout_predir))'','',':persondatalayout_predir')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_prim_name = (TYPEOF(le.Input_persondatalayout_prim_name))'','',':persondatalayout_prim_name')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_addr_suffix = (TYPEOF(le.Input_persondatalayout_addr_suffix))'','',':persondatalayout_addr_suffix')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_postdir = (TYPEOF(le.Input_persondatalayout_postdir))'','',':persondatalayout_postdir')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_unit_desig = (TYPEOF(le.Input_persondatalayout_unit_desig))'','',':persondatalayout_unit_desig')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_sec_range = (TYPEOF(le.Input_persondatalayout_sec_range))'','',':persondatalayout_sec_range')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_v_city_name = (TYPEOF(le.Input_persondatalayout_v_city_name))'','',':persondatalayout_v_city_name')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_st)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_st = (TYPEOF(le.Input_persondatalayout_st))'','',':persondatalayout_st')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_zip5 = (TYPEOF(le.Input_persondatalayout_zip5))'','',':persondatalayout_zip5')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_zip4 = (TYPEOF(le.Input_persondatalayout_zip4))'','',':persondatalayout_zip4')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_addr_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_addr_rec_type = (TYPEOF(le.Input_persondatalayout_addr_rec_type))'','',':persondatalayout_addr_rec_type')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_fips_state)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_fips_state = (TYPEOF(le.Input_persondatalayout_fips_state))'','',':persondatalayout_fips_state')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_fips_county = (TYPEOF(le.Input_persondatalayout_fips_county))'','',':persondatalayout_fips_county')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_geo_lat = (TYPEOF(le.Input_persondatalayout_geo_lat))'','',':persondatalayout_geo_lat')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_geo_long = (TYPEOF(le.Input_persondatalayout_geo_long))'','',':persondatalayout_geo_long')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_cbsa)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_cbsa = (TYPEOF(le.Input_persondatalayout_cbsa))'','',':persondatalayout_cbsa')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_geo_blk = (TYPEOF(le.Input_persondatalayout_geo_blk))'','',':persondatalayout_geo_blk')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_geo_match = (TYPEOF(le.Input_persondatalayout_geo_match))'','',':persondatalayout_geo_match')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_err_stat = (TYPEOF(le.Input_persondatalayout_err_stat))'','',':persondatalayout_err_stat')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_appended_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_appended_ssn = (TYPEOF(le.Input_persondatalayout_appended_ssn))'','',':persondatalayout_appended_ssn')
    #END
 
+    #IF( #TEXT(Input_persondatalayout_appended_adl)='' )
      '' 
    #ELSE
        IF( le.Input_persondatalayout_appended_adl = (TYPEOF(le.Input_persondatalayout_appended_adl))'','',':persondatalayout_appended_adl')
    #END
 
+    #IF( #TEXT(Input_permissablelayout_glb_purpose)='' )
      '' 
    #ELSE
        IF( le.Input_permissablelayout_glb_purpose = (TYPEOF(le.Input_permissablelayout_glb_purpose))'','',':permissablelayout_glb_purpose')
    #END
 
+    #IF( #TEXT(Input_permissablelayout_dppa_purpose)='' )
      '' 
    #ELSE
        IF( le.Input_permissablelayout_dppa_purpose = (TYPEOF(le.Input_permissablelayout_dppa_purpose))'','',':permissablelayout_dppa_purpose')
    #END
 
+    #IF( #TEXT(Input_permissablelayout_fcra_purpose)='' )
      '' 
    #ELSE
        IF( le.Input_permissablelayout_fcra_purpose = (TYPEOF(le.Input_permissablelayout_fcra_purpose))'','',':permissablelayout_fcra_purpose')
    #END
 
+    #IF( #TEXT(Input_searchlayout_datetime)='' )
      '' 
    #ELSE
        IF( le.Input_searchlayout_datetime = (TYPEOF(le.Input_searchlayout_datetime))'','',':searchlayout_datetime')
    #END
 
+    #IF( #TEXT(Input_searchlayout_start_monitor)='' )
      '' 
    #ELSE
        IF( le.Input_searchlayout_start_monitor = (TYPEOF(le.Input_searchlayout_start_monitor))'','',':searchlayout_start_monitor')
    #END
 
+    #IF( #TEXT(Input_searchlayout_stop_monitor)='' )
      '' 
    #ELSE
        IF( le.Input_searchlayout_stop_monitor = (TYPEOF(le.Input_searchlayout_stop_monitor))'','',':searchlayout_stop_monitor')
    #END
 
+    #IF( #TEXT(Input_searchlayout_login_history_id)='' )
      '' 
    #ELSE
        IF( le.Input_searchlayout_login_history_id = (TYPEOF(le.Input_searchlayout_login_history_id))'','',':searchlayout_login_history_id')
    #END
 
+    #IF( #TEXT(Input_searchlayout_transaction_id)='' )
      '' 
    #ELSE
        IF( le.Input_searchlayout_transaction_id = (TYPEOF(le.Input_searchlayout_transaction_id))'','',':searchlayout_transaction_id')
    #END
 
+    #IF( #TEXT(Input_searchlayout_sequence_number)='' )
      '' 
    #ELSE
        IF( le.Input_searchlayout_sequence_number = (TYPEOF(le.Input_searchlayout_sequence_number))'','',':searchlayout_sequence_number')
    #END
 
+    #IF( #TEXT(Input_searchlayout_method)='' )
      '' 
    #ELSE
        IF( le.Input_searchlayout_method = (TYPEOF(le.Input_searchlayout_method))'','',':searchlayout_method')
    #END
 
+    #IF( #TEXT(Input_searchlayout_product_code)='' )
      '' 
    #ELSE
        IF( le.Input_searchlayout_product_code = (TYPEOF(le.Input_searchlayout_product_code))'','',':searchlayout_product_code')
    #END
 
+    #IF( #TEXT(Input_searchlayout_transaction_type)='' )
      '' 
    #ELSE
        IF( le.Input_searchlayout_transaction_type = (TYPEOF(le.Input_searchlayout_transaction_type))'','',':searchlayout_transaction_type')
    #END
 
+    #IF( #TEXT(Input_searchlayout_function_description)='' )
      '' 
    #ELSE
        IF( le.Input_searchlayout_function_description = (TYPEOF(le.Input_searchlayout_function_description))'','',':searchlayout_function_description')
    #END
 
+    #IF( #TEXT(Input_searchlayout_ipaddr)='' )
      '' 
    #ELSE
        IF( le.Input_searchlayout_ipaddr = (TYPEOF(le.Input_searchlayout_ipaddr))'','',':searchlayout_ipaddr')
    #END
 
+    #IF( #TEXT(Input_fraudpoint_score)='' )
      '' 
    #ELSE
        IF( le.Input_fraudpoint_score = (TYPEOF(le.Input_fraudpoint_score))'','',':fraudpoint_score')
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
