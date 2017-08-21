EXPORT MAC_PopulationStatistics(infile,Ref='',sourcecode='',Input_process_date = '',Input_caseid = '',Input_defendantid = '',Input_recid = '',Input_tmsid = '',Input_seq_number = '',Input_court_code = '',Input_case_number = '',Input_orig_case_number = '',Input_chapter = '',Input_filing_type = '',Input_business_flag = '',Input_corp_flag = '',Input_discharged = '',Input_disposition = '',Input_pro_se_ind = '',Input_converted_date = '',Input_orig_county = '',Input_debtor_type = '',Input_debtor_seq = '',Input_ssn = '',Input_ssnsrc = '',Input_ssnmatch = '',Input_ssnmsrc = '',Input_screen = '',Input_dcode = '',Input_disptype = '',Input_dispreason = '',Input_statusdate = '',Input_holdcase = '',Input_datevacated = '',Input_datetransferred = '',Input_activityreceipt = '',Input_tax_id = '',Input_name_type = '',Input_orig_name = '',Input_orig_fname = '',Input_orig_mname = '',Input_orig_lname = '',Input_orig_name_suffix = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_cname = '',Input_orig_company = '',Input_orig_addr1 = '',Input_orig_addr2 = '',Input_orig_city = '',Input_orig_st = '',Input_orig_zip5 = '',Input_orig_zip4 = '',Input_orig_email = '',Input_orig_fax = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_phone = '',Input_did = '',Input_bdid = '',Input_app_ssn = '',Input_app_tax_id = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_date_vendor_first_reported = '',Input_date_vendor_last_reported = '',Input_disptypedesc = '',Input_srcdesc = '',Input_srcmtchdesc = '',Input_screendesc = '',Input_dcodedesc = '',Input_date_filed = '',Input_record_type = '',Input_delete_flag = '',Input_dotid = '',Input_dotscore = '',Input_dotweight = '',Input_empid = '',Input_empscore = '',Input_empweight = '',Input_powid = '',Input_powscore = '',Input_powweight = '',Input_proxid = '',Input_proxscore = '',Input_proxweight = '',Input_seleid = '',Input_selescore = '',Input_seleweight = '',Input_orgid = '',Input_orgscore = '',Input_orgweight = '',Input_ultid = '',Input_ultscore = '',Input_ultweight = '',Input_source_rec_id = '',OutFile) := MACRO
  IMPORT SALT33,Scrubs_bk_search;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(sourcecode)<>'')
    SALT33.StrType source;
    #END
    SALT33.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
+    #IF( #TEXT(Input_caseid)='' )
      '' 
    #ELSE
        IF( le.Input_caseid = (TYPEOF(le.Input_caseid))'','',':caseid')
    #END
+    #IF( #TEXT(Input_defendantid)='' )
      '' 
    #ELSE
        IF( le.Input_defendantid = (TYPEOF(le.Input_defendantid))'','',':defendantid')
    #END
+    #IF( #TEXT(Input_recid)='' )
      '' 
    #ELSE
        IF( le.Input_recid = (TYPEOF(le.Input_recid))'','',':recid')
    #END
+    #IF( #TEXT(Input_tmsid)='' )
      '' 
    #ELSE
        IF( le.Input_tmsid = (TYPEOF(le.Input_tmsid))'','',':tmsid')
    #END
+    #IF( #TEXT(Input_seq_number)='' )
      '' 
    #ELSE
        IF( le.Input_seq_number = (TYPEOF(le.Input_seq_number))'','',':seq_number')
    #END
+    #IF( #TEXT(Input_court_code)='' )
      '' 
    #ELSE
        IF( le.Input_court_code = (TYPEOF(le.Input_court_code))'','',':court_code')
    #END
+    #IF( #TEXT(Input_case_number)='' )
      '' 
    #ELSE
        IF( le.Input_case_number = (TYPEOF(le.Input_case_number))'','',':case_number')
    #END
+    #IF( #TEXT(Input_orig_case_number)='' )
      '' 
    #ELSE
        IF( le.Input_orig_case_number = (TYPEOF(le.Input_orig_case_number))'','',':orig_case_number')
    #END
+    #IF( #TEXT(Input_chapter)='' )
      '' 
    #ELSE
        IF( le.Input_chapter = (TYPEOF(le.Input_chapter))'','',':chapter')
    #END
+    #IF( #TEXT(Input_filing_type)='' )
      '' 
    #ELSE
        IF( le.Input_filing_type = (TYPEOF(le.Input_filing_type))'','',':filing_type')
    #END
+    #IF( #TEXT(Input_business_flag)='' )
      '' 
    #ELSE
        IF( le.Input_business_flag = (TYPEOF(le.Input_business_flag))'','',':business_flag')
    #END
+    #IF( #TEXT(Input_corp_flag)='' )
      '' 
    #ELSE
        IF( le.Input_corp_flag = (TYPEOF(le.Input_corp_flag))'','',':corp_flag')
    #END
+    #IF( #TEXT(Input_discharged)='' )
      '' 
    #ELSE
        IF( le.Input_discharged = (TYPEOF(le.Input_discharged))'','',':discharged')
    #END
+    #IF( #TEXT(Input_disposition)='' )
      '' 
    #ELSE
        IF( le.Input_disposition = (TYPEOF(le.Input_disposition))'','',':disposition')
    #END
+    #IF( #TEXT(Input_pro_se_ind)='' )
      '' 
    #ELSE
        IF( le.Input_pro_se_ind = (TYPEOF(le.Input_pro_se_ind))'','',':pro_se_ind')
    #END
+    #IF( #TEXT(Input_converted_date)='' )
      '' 
    #ELSE
        IF( le.Input_converted_date = (TYPEOF(le.Input_converted_date))'','',':converted_date')
    #END
+    #IF( #TEXT(Input_orig_county)='' )
      '' 
    #ELSE
        IF( le.Input_orig_county = (TYPEOF(le.Input_orig_county))'','',':orig_county')
    #END
+    #IF( #TEXT(Input_debtor_type)='' )
      '' 
    #ELSE
        IF( le.Input_debtor_type = (TYPEOF(le.Input_debtor_type))'','',':debtor_type')
    #END
+    #IF( #TEXT(Input_debtor_seq)='' )
      '' 
    #ELSE
        IF( le.Input_debtor_seq = (TYPEOF(le.Input_debtor_seq))'','',':debtor_seq')
    #END
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
+    #IF( #TEXT(Input_ssnsrc)='' )
      '' 
    #ELSE
        IF( le.Input_ssnsrc = (TYPEOF(le.Input_ssnsrc))'','',':ssnsrc')
    #END
+    #IF( #TEXT(Input_ssnmatch)='' )
      '' 
    #ELSE
        IF( le.Input_ssnmatch = (TYPEOF(le.Input_ssnmatch))'','',':ssnmatch')
    #END
+    #IF( #TEXT(Input_ssnmsrc)='' )
      '' 
    #ELSE
        IF( le.Input_ssnmsrc = (TYPEOF(le.Input_ssnmsrc))'','',':ssnmsrc')
    #END
+    #IF( #TEXT(Input_screen)='' )
      '' 
    #ELSE
        IF( le.Input_screen = (TYPEOF(le.Input_screen))'','',':screen')
    #END
+    #IF( #TEXT(Input_dcode)='' )
      '' 
    #ELSE
        IF( le.Input_dcode = (TYPEOF(le.Input_dcode))'','',':dcode')
    #END
+    #IF( #TEXT(Input_disptype)='' )
      '' 
    #ELSE
        IF( le.Input_disptype = (TYPEOF(le.Input_disptype))'','',':disptype')
    #END
+    #IF( #TEXT(Input_dispreason)='' )
      '' 
    #ELSE
        IF( le.Input_dispreason = (TYPEOF(le.Input_dispreason))'','',':dispreason')
    #END
+    #IF( #TEXT(Input_statusdate)='' )
      '' 
    #ELSE
        IF( le.Input_statusdate = (TYPEOF(le.Input_statusdate))'','',':statusdate')
    #END
+    #IF( #TEXT(Input_holdcase)='' )
      '' 
    #ELSE
        IF( le.Input_holdcase = (TYPEOF(le.Input_holdcase))'','',':holdcase')
    #END
+    #IF( #TEXT(Input_datevacated)='' )
      '' 
    #ELSE
        IF( le.Input_datevacated = (TYPEOF(le.Input_datevacated))'','',':datevacated')
    #END
+    #IF( #TEXT(Input_datetransferred)='' )
      '' 
    #ELSE
        IF( le.Input_datetransferred = (TYPEOF(le.Input_datetransferred))'','',':datetransferred')
    #END
+    #IF( #TEXT(Input_activityreceipt)='' )
      '' 
    #ELSE
        IF( le.Input_activityreceipt = (TYPEOF(le.Input_activityreceipt))'','',':activityreceipt')
    #END
+    #IF( #TEXT(Input_tax_id)='' )
      '' 
    #ELSE
        IF( le.Input_tax_id = (TYPEOF(le.Input_tax_id))'','',':tax_id')
    #END
+    #IF( #TEXT(Input_name_type)='' )
      '' 
    #ELSE
        IF( le.Input_name_type = (TYPEOF(le.Input_name_type))'','',':name_type')
    #END
+    #IF( #TEXT(Input_orig_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_name = (TYPEOF(le.Input_orig_name))'','',':orig_name')
    #END
+    #IF( #TEXT(Input_orig_fname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_fname = (TYPEOF(le.Input_orig_fname))'','',':orig_fname')
    #END
+    #IF( #TEXT(Input_orig_mname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_mname = (TYPEOF(le.Input_orig_mname))'','',':orig_mname')
    #END
+    #IF( #TEXT(Input_orig_lname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_lname = (TYPEOF(le.Input_orig_lname))'','',':orig_lname')
    #END
+    #IF( #TEXT(Input_orig_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_orig_name_suffix = (TYPEOF(le.Input_orig_name_suffix))'','',':orig_name_suffix')
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
+    #IF( #TEXT(Input_cname)='' )
      '' 
    #ELSE
        IF( le.Input_cname = (TYPEOF(le.Input_cname))'','',':cname')
    #END
+    #IF( #TEXT(Input_orig_company)='' )
      '' 
    #ELSE
        IF( le.Input_orig_company = (TYPEOF(le.Input_orig_company))'','',':orig_company')
    #END
+    #IF( #TEXT(Input_orig_addr1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_addr1 = (TYPEOF(le.Input_orig_addr1))'','',':orig_addr1')
    #END
+    #IF( #TEXT(Input_orig_addr2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_addr2 = (TYPEOF(le.Input_orig_addr2))'','',':orig_addr2')
    #END
+    #IF( #TEXT(Input_orig_city)='' )
      '' 
    #ELSE
        IF( le.Input_orig_city = (TYPEOF(le.Input_orig_city))'','',':orig_city')
    #END
+    #IF( #TEXT(Input_orig_st)='' )
      '' 
    #ELSE
        IF( le.Input_orig_st = (TYPEOF(le.Input_orig_st))'','',':orig_st')
    #END
+    #IF( #TEXT(Input_orig_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip5 = (TYPEOF(le.Input_orig_zip5))'','',':orig_zip5')
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
+    #IF( #TEXT(Input_orig_fax)='' )
      '' 
    #ELSE
        IF( le.Input_orig_fax = (TYPEOF(le.Input_orig_fax))'','',':orig_fax')
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
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
+    #IF( #TEXT(Input_app_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_app_ssn = (TYPEOF(le.Input_app_ssn))'','',':app_ssn')
    #END
+    #IF( #TEXT(Input_app_tax_id)='' )
      '' 
    #ELSE
        IF( le.Input_app_tax_id = (TYPEOF(le.Input_app_tax_id))'','',':app_tax_id')
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
+    #IF( #TEXT(Input_disptypedesc)='' )
      '' 
    #ELSE
        IF( le.Input_disptypedesc = (TYPEOF(le.Input_disptypedesc))'','',':disptypedesc')
    #END
+    #IF( #TEXT(Input_srcdesc)='' )
      '' 
    #ELSE
        IF( le.Input_srcdesc = (TYPEOF(le.Input_srcdesc))'','',':srcdesc')
    #END
+    #IF( #TEXT(Input_srcmtchdesc)='' )
      '' 
    #ELSE
        IF( le.Input_srcmtchdesc = (TYPEOF(le.Input_srcmtchdesc))'','',':srcmtchdesc')
    #END
+    #IF( #TEXT(Input_screendesc)='' )
      '' 
    #ELSE
        IF( le.Input_screendesc = (TYPEOF(le.Input_screendesc))'','',':screendesc')
    #END
+    #IF( #TEXT(Input_dcodedesc)='' )
      '' 
    #ELSE
        IF( le.Input_dcodedesc = (TYPEOF(le.Input_dcodedesc))'','',':dcodedesc')
    #END
+    #IF( #TEXT(Input_date_filed)='' )
      '' 
    #ELSE
        IF( le.Input_date_filed = (TYPEOF(le.Input_date_filed))'','',':date_filed')
    #END
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
+    #IF( #TEXT(Input_delete_flag)='' )
      '' 
    #ELSE
        IF( le.Input_delete_flag = (TYPEOF(le.Input_delete_flag))'','',':delete_flag')
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
+    #IF( #TEXT(Input_source_rec_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_rec_id = (TYPEOF(le.Input_source_rec_id))'','',':source_rec_id')
    #END
;
    #IF (#TEXT(sourcecode)<>'')
    SELF.source := le.sourcecode;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(sourcecode)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(sourcecode)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(sourcecode)<>'' ) source, #END -cnt );
ENDMACRO;
