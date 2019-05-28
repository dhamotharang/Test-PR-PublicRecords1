 
EXPORT MAC_PopulationStatistics(infile,Ref='',email_src='',Input_clean_email = '',Input_append_email_username = '',Input_append_domain = '',Input_append_domain_type = '',Input_append_domain_root = '',Input_append_domain_ext = '',Input_append_is_tld_state = '',Input_append_is_tld_generic = '',Input_append_is_tld_country = '',Input_append_is_valid_domain_ext = '',Input_email_rec_key = '',Input_email_src = '',Input_orig_pmghousehold_id = '',Input_orig_pmgindividual_id = '',Input_orig_first_name = '',Input_orig_last_name = '',Input_orig_middle_name = '',Input_orig_name_suffix = '',Input_orig_address = '',Input_orig_city = '',Input_orig_state = '',Input_orig_zip = '',Input_orig_zip4 = '',Input_orig_email = '',Input_orig_ip = '',Input_orig_login_date = '',Input_orig_site = '',Input_orig_e360_id = '',Input_orig_teramedia_id = '',Input_orig_phone = '',Input_orig_ssn = '',Input_orig_dob = '',Input_did = '',Input_did_score = '',Input_did_type = '',Input_hhid = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_append_rawaid = '',Input_clean_phone = '',Input_clean_ssn = '',Input_clean_dob = '',Input_process_date = '',Input_activecode = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_date_vendor_first_reported = '',Input_date_vendor_last_reported = '',Input_current_rec = '',Input_orig_companyname = '',Input_cln_companyname = '',Input_companytitle = '',Input_rules = '',Input_dotid = '',Input_dotscore = '',Input_dotweight = '',Input_empid = '',Input_empscore = '',Input_empweight = '',Input_powid = '',Input_powscore = '',Input_powweight = '',Input_proxid = '',Input_proxscore = '',Input_proxweight = '',Input_seleid = '',Input_selescore = '',Input_seleweight = '',Input_orgid = '',Input_orgscore = '',Input_orgweight = '',Input_ultid = '',Input_ultscore = '',Input_ultweight = '',Input_global_sid = '',Input_record_sid = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Email_DataV2;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(email_src)<>'')
    SALT311.StrType source;
    #END
    SALT311.Str512Type fields;
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
 
+    #IF( #TEXT(Input_orig_phone)='' )
      '' 
    #ELSE
        IF( le.Input_orig_phone = (TYPEOF(le.Input_orig_phone))'','',':orig_phone')
    #END
 
+    #IF( #TEXT(Input_orig_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_orig_ssn = (TYPEOF(le.Input_orig_ssn))'','',':orig_ssn')
    #END
 
+    #IF( #TEXT(Input_orig_dob)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dob = (TYPEOF(le.Input_orig_dob))'','',':orig_dob')
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
 
+    #IF( #TEXT(Input_orig_companyname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_companyname = (TYPEOF(le.Input_orig_companyname))'','',':orig_companyname')
    #END
 
+    #IF( #TEXT(Input_cln_companyname)='' )
      '' 
    #ELSE
        IF( le.Input_cln_companyname = (TYPEOF(le.Input_cln_companyname))'','',':cln_companyname')
    #END
 
+    #IF( #TEXT(Input_companytitle)='' )
      '' 
    #ELSE
        IF( le.Input_companytitle = (TYPEOF(le.Input_companytitle))'','',':companytitle')
    #END
 
+    #IF( #TEXT(Input_rules)='' )
      '' 
    #ELSE
        IF( le.Input_rules = (TYPEOF(le.Input_rules))'','',':rules')
    #END
 
+    #IF( #TEXT(Input_dotid)='' )
      '' 
    #ELSE
        IF( le.Input_dotid = (TYPEOF(le.Input_dotid))'','',':dotid')
    #END
 
+    #IF( #TEXT(Input_dotscore)='' )
      '' 
    #ELSE
        IF( le.Input_dotscore = (TYPEOF(le.Input_dotscore))'','',':dotscore')
    #END
 
+    #IF( #TEXT(Input_dotweight)='' )
      '' 
    #ELSE
        IF( le.Input_dotweight = (TYPEOF(le.Input_dotweight))'','',':dotweight')
    #END
 
+    #IF( #TEXT(Input_empid)='' )
      '' 
    #ELSE
        IF( le.Input_empid = (TYPEOF(le.Input_empid))'','',':empid')
    #END
 
+    #IF( #TEXT(Input_empscore)='' )
      '' 
    #ELSE
        IF( le.Input_empscore = (TYPEOF(le.Input_empscore))'','',':empscore')
    #END
 
+    #IF( #TEXT(Input_empweight)='' )
      '' 
    #ELSE
        IF( le.Input_empweight = (TYPEOF(le.Input_empweight))'','',':empweight')
    #END
 
+    #IF( #TEXT(Input_powid)='' )
      '' 
    #ELSE
        IF( le.Input_powid = (TYPEOF(le.Input_powid))'','',':powid')
    #END
 
+    #IF( #TEXT(Input_powscore)='' )
      '' 
    #ELSE
        IF( le.Input_powscore = (TYPEOF(le.Input_powscore))'','',':powscore')
    #END
 
+    #IF( #TEXT(Input_powweight)='' )
      '' 
    #ELSE
        IF( le.Input_powweight = (TYPEOF(le.Input_powweight))'','',':powweight')
    #END
 
+    #IF( #TEXT(Input_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_proxid = (TYPEOF(le.Input_proxid))'','',':proxid')
    #END
 
+    #IF( #TEXT(Input_proxscore)='' )
      '' 
    #ELSE
        IF( le.Input_proxscore = (TYPEOF(le.Input_proxscore))'','',':proxscore')
    #END
 
+    #IF( #TEXT(Input_proxweight)='' )
      '' 
    #ELSE
        IF( le.Input_proxweight = (TYPEOF(le.Input_proxweight))'','',':proxweight')
    #END
 
+    #IF( #TEXT(Input_seleid)='' )
      '' 
    #ELSE
        IF( le.Input_seleid = (TYPEOF(le.Input_seleid))'','',':seleid')
    #END
 
+    #IF( #TEXT(Input_selescore)='' )
      '' 
    #ELSE
        IF( le.Input_selescore = (TYPEOF(le.Input_selescore))'','',':selescore')
    #END
 
+    #IF( #TEXT(Input_seleweight)='' )
      '' 
    #ELSE
        IF( le.Input_seleweight = (TYPEOF(le.Input_seleweight))'','',':seleweight')
    #END
 
+    #IF( #TEXT(Input_orgid)='' )
      '' 
    #ELSE
        IF( le.Input_orgid = (TYPEOF(le.Input_orgid))'','',':orgid')
    #END
 
+    #IF( #TEXT(Input_orgscore)='' )
      '' 
    #ELSE
        IF( le.Input_orgscore = (TYPEOF(le.Input_orgscore))'','',':orgscore')
    #END
 
+    #IF( #TEXT(Input_orgweight)='' )
      '' 
    #ELSE
        IF( le.Input_orgweight = (TYPEOF(le.Input_orgweight))'','',':orgweight')
    #END
 
+    #IF( #TEXT(Input_ultid)='' )
      '' 
    #ELSE
        IF( le.Input_ultid = (TYPEOF(le.Input_ultid))'','',':ultid')
    #END
 
+    #IF( #TEXT(Input_ultscore)='' )
      '' 
    #ELSE
        IF( le.Input_ultscore = (TYPEOF(le.Input_ultscore))'','',':ultscore')
    #END
 
+    #IF( #TEXT(Input_ultweight)='' )
      '' 
    #ELSE
        IF( le.Input_ultweight = (TYPEOF(le.Input_ultweight))'','',':ultweight')
    #END
 
+    #IF( #TEXT(Input_global_sid)='' )
      '' 
    #ELSE
        IF( le.Input_global_sid = (TYPEOF(le.Input_global_sid))'','',':global_sid')
    #END
 
+    #IF( #TEXT(Input_record_sid)='' )
      '' 
    #ELSE
        IF( le.Input_record_sid = (TYPEOF(le.Input_record_sid))'','',':record_sid')
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
