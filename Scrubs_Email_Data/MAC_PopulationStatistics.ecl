EXPORT MAC_PopulationStatistics(infile,Ref='',email_src='',Input_clean_email = '',Input_append_email_username = '',Input_append_domain = '',Input_append_domain_type = '',Input_append_domain_root = '',Input_append_domain_ext = '',Input_append_is_tld_state = '',Input_append_is_tld_generic = '',Input_append_is_tld_country = '',Input_append_is_valid_domain_ext = '',Input_email_rec_key = '',Input_email_src = '',Input_rec_src_all = '',Input_email_src_all = '',Input_email_src_num = '',Input_num_email_per_did = '',Input_num_did_per_email = '',Input_orig_pmghousehold_id = '',Input_orig_pmgindividual_id = '',Input_orig_first_name = '',Input_orig_last_name = '',Input_orig_address = '',Input_orig_city = '',Input_orig_state = '',Input_orig_zip = '',Input_orig_zip4 = '',Input_orig_email = '',Input_orig_ip = '',Input_orig_login_date = '',Input_orig_site = '',Input_orig_e360_id = '',Input_orig_teramedia_id = '',Input_did = '',Input_did_score = '',Input_did_type = '',Input_is_did_prop = '',Input_hhid = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_append_rawaid = '',Input_best_ssn = '',Input_best_dob = '',Input_process_date = '',Input_activecode = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_date_vendor_first_reported = '',Input_date_vendor_last_reported = '',Input_current_rec = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_Email_Data;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(email_src)<>'')
    SALT30.StrType source;
    #END
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_clean_email)='' )
      '' 
    #ELSE
        IF( le.Input_clean_email = (TYPEOF(le.Input_clean_email))'','',':clean_email')
    #END
+    #IF( #TEXT(Input_append_email_username)='' )
      '' 
    #ELSE
        IF( le.Input_append_email_username = (TYPEOF(le.Input_append_email_username))'','',':append_email_username')
    #END
+    #IF( #TEXT(Input_append_domain)='' )
      '' 
    #ELSE
        IF( le.Input_append_domain = (TYPEOF(le.Input_append_domain))'','',':append_domain')
    #END
+    #IF( #TEXT(Input_append_domain_type)='' )
      '' 
    #ELSE
        IF( le.Input_append_domain_type = (TYPEOF(le.Input_append_domain_type))'','',':append_domain_type')
    #END
+    #IF( #TEXT(Input_append_domain_root)='' )
      '' 
    #ELSE
        IF( le.Input_append_domain_root = (TYPEOF(le.Input_append_domain_root))'','',':append_domain_root')
    #END
+    #IF( #TEXT(Input_append_domain_ext)='' )
      '' 
    #ELSE
        IF( le.Input_append_domain_ext = (TYPEOF(le.Input_append_domain_ext))'','',':append_domain_ext')
    #END
+    #IF( #TEXT(Input_append_is_tld_state)='' )
      '' 
    #ELSE
        IF( le.Input_append_is_tld_state = (TYPEOF(le.Input_append_is_tld_state))'','',':append_is_tld_state')
    #END
+    #IF( #TEXT(Input_append_is_tld_generic)='' )
      '' 
    #ELSE
        IF( le.Input_append_is_tld_generic = (TYPEOF(le.Input_append_is_tld_generic))'','',':append_is_tld_generic')
    #END
+    #IF( #TEXT(Input_append_is_tld_country)='' )
      '' 
    #ELSE
        IF( le.Input_append_is_tld_country = (TYPEOF(le.Input_append_is_tld_country))'','',':append_is_tld_country')
    #END
+    #IF( #TEXT(Input_append_is_valid_domain_ext)='' )
      '' 
    #ELSE
        IF( le.Input_append_is_valid_domain_ext = (TYPEOF(le.Input_append_is_valid_domain_ext))'','',':append_is_valid_domain_ext')
    #END
+    #IF( #TEXT(Input_email_rec_key)='' )
      '' 
    #ELSE
        IF( le.Input_email_rec_key = (TYPEOF(le.Input_email_rec_key))'','',':email_rec_key')
    #END
+    #IF( #TEXT(Input_email_src)='' )
      '' 
    #ELSE
        IF( le.Input_email_src = (TYPEOF(le.Input_email_src))'','',':email_src')
    #END
+    #IF( #TEXT(Input_rec_src_all)='' )
      '' 
    #ELSE
        IF( le.Input_rec_src_all = (TYPEOF(le.Input_rec_src_all))'','',':rec_src_all')
    #END
+    #IF( #TEXT(Input_email_src_all)='' )
      '' 
    #ELSE
        IF( le.Input_email_src_all = (TYPEOF(le.Input_email_src_all))'','',':email_src_all')
    #END
+    #IF( #TEXT(Input_email_src_num)='' )
      '' 
    #ELSE
        IF( le.Input_email_src_num = (TYPEOF(le.Input_email_src_num))'','',':email_src_num')
    #END
+    #IF( #TEXT(Input_num_email_per_did)='' )
      '' 
    #ELSE
        IF( le.Input_num_email_per_did = (TYPEOF(le.Input_num_email_per_did))'','',':num_email_per_did')
    #END
+    #IF( #TEXT(Input_num_did_per_email)='' )
      '' 
    #ELSE
        IF( le.Input_num_did_per_email = (TYPEOF(le.Input_num_did_per_email))'','',':num_did_per_email')
    #END
+    #IF( #TEXT(Input_orig_pmghousehold_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_pmghousehold_id = (TYPEOF(le.Input_orig_pmghousehold_id))'','',':orig_pmghousehold_id')
    #END
+    #IF( #TEXT(Input_orig_pmgindividual_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_pmgindividual_id = (TYPEOF(le.Input_orig_pmgindividual_id))'','',':orig_pmgindividual_id')
    #END
+    #IF( #TEXT(Input_orig_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_first_name = (TYPEOF(le.Input_orig_first_name))'','',':orig_first_name')
    #END
+    #IF( #TEXT(Input_orig_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_last_name = (TYPEOF(le.Input_orig_last_name))'','',':orig_last_name')
    #END
+    #IF( #TEXT(Input_orig_address)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address = (TYPEOF(le.Input_orig_address))'','',':orig_address')
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
+    #IF( #TEXT(Input_orig_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip4 = (TYPEOF(le.Input_orig_zip4))'','',':orig_zip4')
    #END
+    #IF( #TEXT(Input_orig_email)='' )
      '' 
    #ELSE
        IF( le.Input_orig_email = (TYPEOF(le.Input_orig_email))'','',':orig_email')
    #END
+    #IF( #TEXT(Input_orig_ip)='' )
      '' 
    #ELSE
        IF( le.Input_orig_ip = (TYPEOF(le.Input_orig_ip))'','',':orig_ip')
    #END
+    #IF( #TEXT(Input_orig_login_date)='' )
      '' 
    #ELSE
        IF( le.Input_orig_login_date = (TYPEOF(le.Input_orig_login_date))'','',':orig_login_date')
    #END
+    #IF( #TEXT(Input_orig_site)='' )
      '' 
    #ELSE
        IF( le.Input_orig_site = (TYPEOF(le.Input_orig_site))'','',':orig_site')
    #END
+    #IF( #TEXT(Input_orig_e360_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_e360_id = (TYPEOF(le.Input_orig_e360_id))'','',':orig_e360_id')
    #END
+    #IF( #TEXT(Input_orig_teramedia_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_teramedia_id = (TYPEOF(le.Input_orig_teramedia_id))'','',':orig_teramedia_id')
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
+    #IF( #TEXT(Input_did_type)='' )
      '' 
    #ELSE
        IF( le.Input_did_type = (TYPEOF(le.Input_did_type))'','',':did_type')
    #END
+    #IF( #TEXT(Input_is_did_prop)='' )
      '' 
    #ELSE
        IF( le.Input_is_did_prop = (TYPEOF(le.Input_is_did_prop))'','',':is_did_prop')
    #END
+    #IF( #TEXT(Input_hhid)='' )
      '' 
    #ELSE
        IF( le.Input_hhid = (TYPEOF(le.Input_hhid))'','',':hhid')
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
+    #IF( #TEXT(Input_append_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_append_rawaid = (TYPEOF(le.Input_append_rawaid))'','',':append_rawaid')
    #END
+    #IF( #TEXT(Input_best_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_best_ssn = (TYPEOF(le.Input_best_ssn))'','',':best_ssn')
    #END
+    #IF( #TEXT(Input_best_dob)='' )
      '' 
    #ELSE
        IF( le.Input_best_dob = (TYPEOF(le.Input_best_dob))'','',':best_dob')
    #END
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
+    #IF( #TEXT(Input_activecode)='' )
      '' 
    #ELSE
        IF( le.Input_activecode = (TYPEOF(le.Input_activecode))'','',':activecode')
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
+    #IF( #TEXT(Input_current_rec)='' )
      '' 
    #ELSE
        IF( le.Input_current_rec = (TYPEOF(le.Input_current_rec))'','',':current_rec')
    #END
;
    #IF (#TEXT(email_src)<>'')
    SELF.source := le.email_src;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(email_src)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(email_src)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(email_src)<>'' ) source, #END -cnt );
ENDMACRO;
