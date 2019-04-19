 
EXPORT Base_MAC_PopulationStatistics(infile,Ref='',Input_powid = '',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_bdid = '',Input_did = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_process_date = '',Input_record_type = '',Input_clean_company_name = '',Input_clean_area_code = '',Input_clean_telephone_num = '',Input_mail_score_desc = '',Input_name_gender_desc = '',Input_title_desc_1 = '',Input_title_desc_2 = '',Input_title_desc_3 = '',Input_title_desc_4 = '',Input_sic8_desc_1 = '',Input_sic8_desc_2 = '',Input_sic8_desc_3 = '',Input_sic8_desc_4 = '',Input_sic6_desc_1 = '',Input_sic6_desc_2 = '',Input_sic6_desc_3 = '',Input_sic6_desc_4 = '',Input_sic6_desc_5 = '',Input_name = '',Input_company = '',Input_address = '',Input_address2 = '',Input_city = '',Input_state = '',Input_scf = '',Input_zip = '',Input_zip4 = '',Input_mail_score = '',Input_area_code = '',Input_telephone_number = '',Input_name_gender = '',Input_name_prefix = '',Input_name_first = '',Input_name_middle_initial = '',Input_name_last = '',Input_suffix = '',Input_title_code_1 = '',Input_title_code_2 = '',Input_title_code_3 = '',Input_title_code_4 = '',Input_web_address = '',Input_sic8_1 = '',Input_sic8_2 = '',Input_sic8_3 = '',Input_sic8_4 = '',Input_sic6_1 = '',Input_sic6_2 = '',Input_sic6_3 = '',Input_sic6_4 = '',Input_sic6_5 = '',Input_transaction_date = '',Input_database_site_id = '',Input_database_individual_id = '',Input_email = '',Input_email_present_flag = '',Input_site_source1 = '',Input_site_source2 = '',Input_site_source3 = '',Input_site_source4 = '',Input_site_source5 = '',Input_site_source6 = '',Input_site_source7 = '',Input_site_source8 = '',Input_site_source9 = '',Input_site_source10 = '',Input_individual_source1 = '',Input_individual_source2 = '',Input_individual_source3 = '',Input_individual_source4 = '',Input_individual_source5 = '',Input_individual_source6 = '',Input_individual_source7 = '',Input_individual_source8 = '',Input_individual_source9 = '',Input_individual_source10 = '',Input_email_status = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_fips_state = '',Input_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_raw_aid = '',Input_ace_aid = '',Input_prep_address_line1 = '',Input_prep_address_line_last = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_DataBridge;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_powid)='' )
      '' 
    #ELSE
        IF( le.Input_powid = (TYPEOF(le.Input_powid))'','',':powid')
    #END
 
+    #IF( #TEXT(Input_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_proxid = (TYPEOF(le.Input_proxid))'','',':proxid')
    #END
 
+    #IF( #TEXT(Input_seleid)='' )
      '' 
    #ELSE
        IF( le.Input_seleid = (TYPEOF(le.Input_seleid))'','',':seleid')
    #END
 
+    #IF( #TEXT(Input_orgid)='' )
      '' 
    #ELSE
        IF( le.Input_orgid = (TYPEOF(le.Input_orgid))'','',':orgid')
    #END
 
+    #IF( #TEXT(Input_ultid)='' )
      '' 
    #ELSE
        IF( le.Input_ultid = (TYPEOF(le.Input_ultid))'','',':ultid')
    #END
 
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
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
 
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_clean_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_company_name = (TYPEOF(le.Input_clean_company_name))'','',':clean_company_name')
    #END
 
+    #IF( #TEXT(Input_clean_area_code)='' )
      '' 
    #ELSE
        IF( le.Input_clean_area_code = (TYPEOF(le.Input_clean_area_code))'','',':clean_area_code')
    #END
 
+    #IF( #TEXT(Input_clean_telephone_num)='' )
      '' 
    #ELSE
        IF( le.Input_clean_telephone_num = (TYPEOF(le.Input_clean_telephone_num))'','',':clean_telephone_num')
    #END
 
+    #IF( #TEXT(Input_mail_score_desc)='' )
      '' 
    #ELSE
        IF( le.Input_mail_score_desc = (TYPEOF(le.Input_mail_score_desc))'','',':mail_score_desc')
    #END
 
+    #IF( #TEXT(Input_name_gender_desc)='' )
      '' 
    #ELSE
        IF( le.Input_name_gender_desc = (TYPEOF(le.Input_name_gender_desc))'','',':name_gender_desc')
    #END
 
+    #IF( #TEXT(Input_title_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_title_desc_1 = (TYPEOF(le.Input_title_desc_1))'','',':title_desc_1')
    #END
 
+    #IF( #TEXT(Input_title_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_title_desc_2 = (TYPEOF(le.Input_title_desc_2))'','',':title_desc_2')
    #END
 
+    #IF( #TEXT(Input_title_desc_3)='' )
      '' 
    #ELSE
        IF( le.Input_title_desc_3 = (TYPEOF(le.Input_title_desc_3))'','',':title_desc_3')
    #END
 
+    #IF( #TEXT(Input_title_desc_4)='' )
      '' 
    #ELSE
        IF( le.Input_title_desc_4 = (TYPEOF(le.Input_title_desc_4))'','',':title_desc_4')
    #END
 
+    #IF( #TEXT(Input_sic8_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_sic8_desc_1 = (TYPEOF(le.Input_sic8_desc_1))'','',':sic8_desc_1')
    #END
 
+    #IF( #TEXT(Input_sic8_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_sic8_desc_2 = (TYPEOF(le.Input_sic8_desc_2))'','',':sic8_desc_2')
    #END
 
+    #IF( #TEXT(Input_sic8_desc_3)='' )
      '' 
    #ELSE
        IF( le.Input_sic8_desc_3 = (TYPEOF(le.Input_sic8_desc_3))'','',':sic8_desc_3')
    #END
 
+    #IF( #TEXT(Input_sic8_desc_4)='' )
      '' 
    #ELSE
        IF( le.Input_sic8_desc_4 = (TYPEOF(le.Input_sic8_desc_4))'','',':sic8_desc_4')
    #END
 
+    #IF( #TEXT(Input_sic6_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_sic6_desc_1 = (TYPEOF(le.Input_sic6_desc_1))'','',':sic6_desc_1')
    #END
 
+    #IF( #TEXT(Input_sic6_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_sic6_desc_2 = (TYPEOF(le.Input_sic6_desc_2))'','',':sic6_desc_2')
    #END
 
+    #IF( #TEXT(Input_sic6_desc_3)='' )
      '' 
    #ELSE
        IF( le.Input_sic6_desc_3 = (TYPEOF(le.Input_sic6_desc_3))'','',':sic6_desc_3')
    #END
 
+    #IF( #TEXT(Input_sic6_desc_4)='' )
      '' 
    #ELSE
        IF( le.Input_sic6_desc_4 = (TYPEOF(le.Input_sic6_desc_4))'','',':sic6_desc_4')
    #END
 
+    #IF( #TEXT(Input_sic6_desc_5)='' )
      '' 
    #ELSE
        IF( le.Input_sic6_desc_5 = (TYPEOF(le.Input_sic6_desc_5))'','',':sic6_desc_5')
    #END
 
+    #IF( #TEXT(Input_name)='' )
      '' 
    #ELSE
        IF( le.Input_name = (TYPEOF(le.Input_name))'','',':name')
    #END
 
+    #IF( #TEXT(Input_company)='' )
      '' 
    #ELSE
        IF( le.Input_company = (TYPEOF(le.Input_company))'','',':company')
    #END
 
+    #IF( #TEXT(Input_address)='' )
      '' 
    #ELSE
        IF( le.Input_address = (TYPEOF(le.Input_address))'','',':address')
    #END
 
+    #IF( #TEXT(Input_address2)='' )
      '' 
    #ELSE
        IF( le.Input_address2 = (TYPEOF(le.Input_address2))'','',':address2')
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
 
+    #IF( #TEXT(Input_scf)='' )
      '' 
    #ELSE
        IF( le.Input_scf = (TYPEOF(le.Input_scf))'','',':scf')
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
 
+    #IF( #TEXT(Input_mail_score)='' )
      '' 
    #ELSE
        IF( le.Input_mail_score = (TYPEOF(le.Input_mail_score))'','',':mail_score')
    #END
 
+    #IF( #TEXT(Input_area_code)='' )
      '' 
    #ELSE
        IF( le.Input_area_code = (TYPEOF(le.Input_area_code))'','',':area_code')
    #END
 
+    #IF( #TEXT(Input_telephone_number)='' )
      '' 
    #ELSE
        IF( le.Input_telephone_number = (TYPEOF(le.Input_telephone_number))'','',':telephone_number')
    #END
 
+    #IF( #TEXT(Input_name_gender)='' )
      '' 
    #ELSE
        IF( le.Input_name_gender = (TYPEOF(le.Input_name_gender))'','',':name_gender')
    #END
 
+    #IF( #TEXT(Input_name_prefix)='' )
      '' 
    #ELSE
        IF( le.Input_name_prefix = (TYPEOF(le.Input_name_prefix))'','',':name_prefix')
    #END
 
+    #IF( #TEXT(Input_name_first)='' )
      '' 
    #ELSE
        IF( le.Input_name_first = (TYPEOF(le.Input_name_first))'','',':name_first')
    #END
 
+    #IF( #TEXT(Input_name_middle_initial)='' )
      '' 
    #ELSE
        IF( le.Input_name_middle_initial = (TYPEOF(le.Input_name_middle_initial))'','',':name_middle_initial')
    #END
 
+    #IF( #TEXT(Input_name_last)='' )
      '' 
    #ELSE
        IF( le.Input_name_last = (TYPEOF(le.Input_name_last))'','',':name_last')
    #END
 
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
 
+    #IF( #TEXT(Input_title_code_1)='' )
      '' 
    #ELSE
        IF( le.Input_title_code_1 = (TYPEOF(le.Input_title_code_1))'','',':title_code_1')
    #END
 
+    #IF( #TEXT(Input_title_code_2)='' )
      '' 
    #ELSE
        IF( le.Input_title_code_2 = (TYPEOF(le.Input_title_code_2))'','',':title_code_2')
    #END
 
+    #IF( #TEXT(Input_title_code_3)='' )
      '' 
    #ELSE
        IF( le.Input_title_code_3 = (TYPEOF(le.Input_title_code_3))'','',':title_code_3')
    #END
 
+    #IF( #TEXT(Input_title_code_4)='' )
      '' 
    #ELSE
        IF( le.Input_title_code_4 = (TYPEOF(le.Input_title_code_4))'','',':title_code_4')
    #END
 
+    #IF( #TEXT(Input_web_address)='' )
      '' 
    #ELSE
        IF( le.Input_web_address = (TYPEOF(le.Input_web_address))'','',':web_address')
    #END
 
+    #IF( #TEXT(Input_sic8_1)='' )
      '' 
    #ELSE
        IF( le.Input_sic8_1 = (TYPEOF(le.Input_sic8_1))'','',':sic8_1')
    #END
 
+    #IF( #TEXT(Input_sic8_2)='' )
      '' 
    #ELSE
        IF( le.Input_sic8_2 = (TYPEOF(le.Input_sic8_2))'','',':sic8_2')
    #END
 
+    #IF( #TEXT(Input_sic8_3)='' )
      '' 
    #ELSE
        IF( le.Input_sic8_3 = (TYPEOF(le.Input_sic8_3))'','',':sic8_3')
    #END
 
+    #IF( #TEXT(Input_sic8_4)='' )
      '' 
    #ELSE
        IF( le.Input_sic8_4 = (TYPEOF(le.Input_sic8_4))'','',':sic8_4')
    #END
 
+    #IF( #TEXT(Input_sic6_1)='' )
      '' 
    #ELSE
        IF( le.Input_sic6_1 = (TYPEOF(le.Input_sic6_1))'','',':sic6_1')
    #END
 
+    #IF( #TEXT(Input_sic6_2)='' )
      '' 
    #ELSE
        IF( le.Input_sic6_2 = (TYPEOF(le.Input_sic6_2))'','',':sic6_2')
    #END
 
+    #IF( #TEXT(Input_sic6_3)='' )
      '' 
    #ELSE
        IF( le.Input_sic6_3 = (TYPEOF(le.Input_sic6_3))'','',':sic6_3')
    #END
 
+    #IF( #TEXT(Input_sic6_4)='' )
      '' 
    #ELSE
        IF( le.Input_sic6_4 = (TYPEOF(le.Input_sic6_4))'','',':sic6_4')
    #END
 
+    #IF( #TEXT(Input_sic6_5)='' )
      '' 
    #ELSE
        IF( le.Input_sic6_5 = (TYPEOF(le.Input_sic6_5))'','',':sic6_5')
    #END
 
+    #IF( #TEXT(Input_transaction_date)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_date = (TYPEOF(le.Input_transaction_date))'','',':transaction_date')
    #END
 
+    #IF( #TEXT(Input_database_site_id)='' )
      '' 
    #ELSE
        IF( le.Input_database_site_id = (TYPEOF(le.Input_database_site_id))'','',':database_site_id')
    #END
 
+    #IF( #TEXT(Input_database_individual_id)='' )
      '' 
    #ELSE
        IF( le.Input_database_individual_id = (TYPEOF(le.Input_database_individual_id))'','',':database_individual_id')
    #END
 
+    #IF( #TEXT(Input_email)='' )
      '' 
    #ELSE
        IF( le.Input_email = (TYPEOF(le.Input_email))'','',':email')
    #END
 
+    #IF( #TEXT(Input_email_present_flag)='' )
      '' 
    #ELSE
        IF( le.Input_email_present_flag = (TYPEOF(le.Input_email_present_flag))'','',':email_present_flag')
    #END
 
+    #IF( #TEXT(Input_site_source1)='' )
      '' 
    #ELSE
        IF( le.Input_site_source1 = (TYPEOF(le.Input_site_source1))'','',':site_source1')
    #END
 
+    #IF( #TEXT(Input_site_source2)='' )
      '' 
    #ELSE
        IF( le.Input_site_source2 = (TYPEOF(le.Input_site_source2))'','',':site_source2')
    #END
 
+    #IF( #TEXT(Input_site_source3)='' )
      '' 
    #ELSE
        IF( le.Input_site_source3 = (TYPEOF(le.Input_site_source3))'','',':site_source3')
    #END
 
+    #IF( #TEXT(Input_site_source4)='' )
      '' 
    #ELSE
        IF( le.Input_site_source4 = (TYPEOF(le.Input_site_source4))'','',':site_source4')
    #END
 
+    #IF( #TEXT(Input_site_source5)='' )
      '' 
    #ELSE
        IF( le.Input_site_source5 = (TYPEOF(le.Input_site_source5))'','',':site_source5')
    #END
 
+    #IF( #TEXT(Input_site_source6)='' )
      '' 
    #ELSE
        IF( le.Input_site_source6 = (TYPEOF(le.Input_site_source6))'','',':site_source6')
    #END
 
+    #IF( #TEXT(Input_site_source7)='' )
      '' 
    #ELSE
        IF( le.Input_site_source7 = (TYPEOF(le.Input_site_source7))'','',':site_source7')
    #END
 
+    #IF( #TEXT(Input_site_source8)='' )
      '' 
    #ELSE
        IF( le.Input_site_source8 = (TYPEOF(le.Input_site_source8))'','',':site_source8')
    #END
 
+    #IF( #TEXT(Input_site_source9)='' )
      '' 
    #ELSE
        IF( le.Input_site_source9 = (TYPEOF(le.Input_site_source9))'','',':site_source9')
    #END
 
+    #IF( #TEXT(Input_site_source10)='' )
      '' 
    #ELSE
        IF( le.Input_site_source10 = (TYPEOF(le.Input_site_source10))'','',':site_source10')
    #END
 
+    #IF( #TEXT(Input_individual_source1)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source1 = (TYPEOF(le.Input_individual_source1))'','',':individual_source1')
    #END
 
+    #IF( #TEXT(Input_individual_source2)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source2 = (TYPEOF(le.Input_individual_source2))'','',':individual_source2')
    #END
 
+    #IF( #TEXT(Input_individual_source3)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source3 = (TYPEOF(le.Input_individual_source3))'','',':individual_source3')
    #END
 
+    #IF( #TEXT(Input_individual_source4)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source4 = (TYPEOF(le.Input_individual_source4))'','',':individual_source4')
    #END
 
+    #IF( #TEXT(Input_individual_source5)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source5 = (TYPEOF(le.Input_individual_source5))'','',':individual_source5')
    #END
 
+    #IF( #TEXT(Input_individual_source6)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source6 = (TYPEOF(le.Input_individual_source6))'','',':individual_source6')
    #END
 
+    #IF( #TEXT(Input_individual_source7)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source7 = (TYPEOF(le.Input_individual_source7))'','',':individual_source7')
    #END
 
+    #IF( #TEXT(Input_individual_source8)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source8 = (TYPEOF(le.Input_individual_source8))'','',':individual_source8')
    #END
 
+    #IF( #TEXT(Input_individual_source9)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source9 = (TYPEOF(le.Input_individual_source9))'','',':individual_source9')
    #END
 
+    #IF( #TEXT(Input_individual_source10)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source10 = (TYPEOF(le.Input_individual_source10))'','',':individual_source10')
    #END
 
+    #IF( #TEXT(Input_email_status)='' )
      '' 
    #ELSE
        IF( le.Input_email_status = (TYPEOF(le.Input_email_status))'','',':email_status')
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
 
+    #IF( #TEXT(Input_fips_state)='' )
      '' 
    #ELSE
        IF( le.Input_fips_state = (TYPEOF(le.Input_fips_state))'','',':fips_state')
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
 
+    #IF( #TEXT(Input_raw_aid)='' )
      '' 
    #ELSE
        IF( le.Input_raw_aid = (TYPEOF(le.Input_raw_aid))'','',':raw_aid')
    #END
 
+    #IF( #TEXT(Input_ace_aid)='' )
      '' 
    #ELSE
        IF( le.Input_ace_aid = (TYPEOF(le.Input_ace_aid))'','',':ace_aid')
    #END
 
+    #IF( #TEXT(Input_prep_address_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_address_line1 = (TYPEOF(le.Input_prep_address_line1))'','',':prep_address_line1')
    #END
 
+    #IF( #TEXT(Input_prep_address_line_last)='' )
      '' 
    #ELSE
        IF( le.Input_prep_address_line_last = (TYPEOF(le.Input_prep_address_line_last))'','',':prep_address_line_last')
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
