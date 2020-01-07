 
EXPORT MAC_PopulationStatistics(infile,Ref='',source='',Input_source = '',Input_source_record_id = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_dt_first_seen_company_name = '',Input_dt_last_seen_company_name = '',Input_dt_first_seen_company_address = '',Input_dt_last_seen_company_address = '',Input_dt_first_seen_contact = '',Input_dt_last_seen_contact = '',Input_isContact = '',Input_iscorp = '',Input_cnp_hasnumber = '',Input_cnp_name = '',Input_cnp_number = '',Input_cnp_btype = '',Input_cnp_lowv = '',Input_cnp_translated = '',Input_cnp_classid = '',Input_company_aceaid = '',Input_corp_legal_name = '',Input_dba_name = '',Input_active_duns_number = '',Input_hist_duns_number = '',Input_active_enterprise_number = '',Input_hist_enterprise_number = '',Input_ebr_file_number = '',Input_active_domestic_corp_key = '',Input_hist_domestic_corp_key = '',Input_foreign_corp_key = '',Input_unk_corp_key = '',Input_global_sid = '',Input_record_sid = '',Input_employee_count_org_raw = '',Input_employee_count_org_derived = '',Input_revenue_org_raw = '',Input_revenue_org_derived = '',Input_employee_count_local_raw = '',Input_employee_count_local_derived = '',Input_revenue_local_raw = '',Input_revenue_local_derived = '',Input_locid = '',Input_source_docid = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_company_name = '',Input_company_name_type_raw = '',Input_company_name_type_derived = '',Input_company_rawaid = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_fips_state = '',Input_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_company_bdid = '',Input_company_address_type_raw = '',Input_company_fein = '',Input_best_fein_indicator = '',Input_company_phone = '',Input_phone_type = '',Input_phone_score = '',Input_company_org_structure_raw = '',Input_company_incorporation_date = '',Input_company_sic_code1 = '',Input_company_sic_code2 = '',Input_company_sic_code3 = '',Input_company_sic_code4 = '',Input_company_sic_code5 = '',Input_company_naics_code1 = '',Input_company_naics_code2 = '',Input_company_naics_code3 = '',Input_company_naics_code4 = '',Input_company_naics_code5 = '',Input_company_ticker = '',Input_company_ticker_exchange = '',Input_company_foreign_domestic = '',Input_company_url = '',Input_company_inc_state = '',Input_company_charter_number = '',Input_company_filing_date = '',Input_company_status_date = '',Input_company_foreign_date = '',Input_event_filing_date = '',Input_company_name_status_raw = '',Input_company_status_raw = '',Input_vl_id = '',Input_current = '',Input_contact_did = '',Input_contact_type_raw = '',Input_contact_job_title_raw = '',Input_contact_ssn = '',Input_contact_dob = '',Input_contact_status_raw = '',Input_contact_email = '',Input_contact_email_username = '',Input_contact_email_domain = '',Input_contact_phone = '',Input_from_hdr = '',Input_company_department = '',Input_company_address_type_derived = '',Input_company_org_structure_derived = '',Input_company_name_status_derived = '',Input_company_status_derived = '',Input_contact_type_derived = '',Input_contact_job_title_derived = '',Input_contact_status_derived = '',OutFile) := MACRO
  IMPORT SALT35,BIPV2_Ingest;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(source)<>'')
    SALT35.StrType source;
    #END
    SALT35.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
    #END
 
+    #IF( #TEXT(Input_source_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_record_id = (TYPEOF(le.Input_source_record_id))'','',':source_record_id')
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
 
+    #IF( #TEXT(Input_dt_first_seen_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen_company_name = (TYPEOF(le.Input_dt_first_seen_company_name))'','',':dt_first_seen_company_name')
    #END
 
+    #IF( #TEXT(Input_dt_last_seen_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen_company_name = (TYPEOF(le.Input_dt_last_seen_company_name))'','',':dt_last_seen_company_name')
    #END
 
+    #IF( #TEXT(Input_dt_first_seen_company_address)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen_company_address = (TYPEOF(le.Input_dt_first_seen_company_address))'','',':dt_first_seen_company_address')
    #END
 
+    #IF( #TEXT(Input_dt_last_seen_company_address)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen_company_address = (TYPEOF(le.Input_dt_last_seen_company_address))'','',':dt_last_seen_company_address')
    #END
 
+    #IF( #TEXT(Input_dt_first_seen_contact)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen_contact = (TYPEOF(le.Input_dt_first_seen_contact))'','',':dt_first_seen_contact')
    #END
 
+    #IF( #TEXT(Input_dt_last_seen_contact)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen_contact = (TYPEOF(le.Input_dt_last_seen_contact))'','',':dt_last_seen_contact')
    #END
 
+    #IF( #TEXT(Input_isContact)='' )
      '' 
    #ELSE
        IF( le.Input_isContact = (TYPEOF(le.Input_isContact))'','',':isContact')
    #END
 
+    #IF( #TEXT(Input_iscorp)='' )
      '' 
    #ELSE
        IF( le.Input_iscorp = (TYPEOF(le.Input_iscorp))'','',':iscorp')
    #END
 
+    #IF( #TEXT(Input_cnp_hasnumber)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_hasnumber = (TYPEOF(le.Input_cnp_hasnumber))'','',':cnp_hasnumber')
    #END
 
+    #IF( #TEXT(Input_cnp_name)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_name = (TYPEOF(le.Input_cnp_name))'','',':cnp_name')
    #END
 
+    #IF( #TEXT(Input_cnp_number)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_number = (TYPEOF(le.Input_cnp_number))'','',':cnp_number')
    #END
 
+    #IF( #TEXT(Input_cnp_btype)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_btype = (TYPEOF(le.Input_cnp_btype))'','',':cnp_btype')
    #END
 
+    #IF( #TEXT(Input_cnp_lowv)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_lowv = (TYPEOF(le.Input_cnp_lowv))'','',':cnp_lowv')
    #END
 
+    #IF( #TEXT(Input_cnp_translated)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_translated = (TYPEOF(le.Input_cnp_translated))'','',':cnp_translated')
    #END
 
+    #IF( #TEXT(Input_cnp_classid)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_classid = (TYPEOF(le.Input_cnp_classid))'','',':cnp_classid')
    #END
 
+    #IF( #TEXT(Input_company_aceaid)='' )
      '' 
    #ELSE
        IF( le.Input_company_aceaid = (TYPEOF(le.Input_company_aceaid))'','',':company_aceaid')
    #END
 
+    #IF( #TEXT(Input_corp_legal_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_legal_name = (TYPEOF(le.Input_corp_legal_name))'','',':corp_legal_name')
    #END
 
+    #IF( #TEXT(Input_dba_name)='' )
      '' 
    #ELSE
        IF( le.Input_dba_name = (TYPEOF(le.Input_dba_name))'','',':dba_name')
    #END
 
+    #IF( #TEXT(Input_active_duns_number)='' )
      '' 
    #ELSE
        IF( le.Input_active_duns_number = (TYPEOF(le.Input_active_duns_number))'','',':active_duns_number')
    #END
 
+    #IF( #TEXT(Input_hist_duns_number)='' )
      '' 
    #ELSE
        IF( le.Input_hist_duns_number = (TYPEOF(le.Input_hist_duns_number))'','',':hist_duns_number')
    #END
 
+    #IF( #TEXT(Input_active_enterprise_number)='' )
      '' 
    #ELSE
        IF( le.Input_active_enterprise_number = (TYPEOF(le.Input_active_enterprise_number))'','',':active_enterprise_number')
    #END
 
+    #IF( #TEXT(Input_hist_enterprise_number)='' )
      '' 
    #ELSE
        IF( le.Input_hist_enterprise_number = (TYPEOF(le.Input_hist_enterprise_number))'','',':hist_enterprise_number')
    #END
 
+    #IF( #TEXT(Input_ebr_file_number)='' )
      '' 
    #ELSE
        IF( le.Input_ebr_file_number = (TYPEOF(le.Input_ebr_file_number))'','',':ebr_file_number')
    #END
 
+    #IF( #TEXT(Input_active_domestic_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_active_domestic_corp_key = (TYPEOF(le.Input_active_domestic_corp_key))'','',':active_domestic_corp_key')
    #END
 
+    #IF( #TEXT(Input_hist_domestic_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_hist_domestic_corp_key = (TYPEOF(le.Input_hist_domestic_corp_key))'','',':hist_domestic_corp_key')
    #END
 
+    #IF( #TEXT(Input_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_foreign_corp_key = (TYPEOF(le.Input_foreign_corp_key))'','',':foreign_corp_key')
    #END
 
+    #IF( #TEXT(Input_unk_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_unk_corp_key = (TYPEOF(le.Input_unk_corp_key))'','',':unk_corp_key')
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
 
+    #IF( #TEXT(Input_employee_count_org_raw)='' )
      '' 
    #ELSE
        IF( le.Input_employee_count_org_raw = (TYPEOF(le.Input_employee_count_org_raw))'','',':employee_count_org_raw')
    #END
 
+    #IF( #TEXT(Input_employee_count_org_derived)='' )
      '' 
    #ELSE
        IF( le.Input_employee_count_org_derived = (TYPEOF(le.Input_employee_count_org_derived))'','',':employee_count_org_derived')
    #END
 
+    #IF( #TEXT(Input_revenue_org_raw)='' )
      '' 
    #ELSE
        IF( le.Input_revenue_org_raw = (TYPEOF(le.Input_revenue_org_raw))'','',':revenue_org_raw')
    #END
 
+    #IF( #TEXT(Input_revenue_org_derived)='' )
      '' 
    #ELSE
        IF( le.Input_revenue_org_derived = (TYPEOF(le.Input_revenue_org_derived))'','',':revenue_org_derived')
    #END
 
+    #IF( #TEXT(Input_employee_count_local_raw)='' )
      '' 
    #ELSE
        IF( le.Input_employee_count_local_raw = (TYPEOF(le.Input_employee_count_local_raw))'','',':employee_count_local_raw')
    #END
 
+    #IF( #TEXT(Input_employee_count_local_derived)='' )
      '' 
    #ELSE
        IF( le.Input_employee_count_local_derived = (TYPEOF(le.Input_employee_count_local_derived))'','',':employee_count_local_derived')
    #END
 
+    #IF( #TEXT(Input_revenue_local_raw)='' )
      '' 
    #ELSE
        IF( le.Input_revenue_local_raw = (TYPEOF(le.Input_revenue_local_raw))'','',':revenue_local_raw')
    #END
 
+    #IF( #TEXT(Input_revenue_local_derived)='' )
      '' 
    #ELSE
        IF( le.Input_revenue_local_derived = (TYPEOF(le.Input_revenue_local_derived))'','',':revenue_local_derived')
    #END
 
+    #IF( #TEXT(Input_locid)='' )
      '' 
    #ELSE
        IF( le.Input_locid = (TYPEOF(le.Input_locid))'','',':locid')
    #END
 
+    #IF( #TEXT(Input_source_docid)='' )
      '' 
    #ELSE
        IF( le.Input_source_docid = (TYPEOF(le.Input_source_docid))'','',':source_docid')
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
 
+    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (TYPEOF(le.Input_company_name))'','',':company_name')
    #END
 
+    #IF( #TEXT(Input_company_name_type_raw)='' )
      '' 
    #ELSE
        IF( le.Input_company_name_type_raw = (TYPEOF(le.Input_company_name_type_raw))'','',':company_name_type_raw')
    #END
 
+    #IF( #TEXT(Input_company_name_type_derived)='' )
      '' 
    #ELSE
        IF( le.Input_company_name_type_derived = (TYPEOF(le.Input_company_name_type_derived))'','',':company_name_type_derived')
    #END
 
+    #IF( #TEXT(Input_company_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_company_rawaid = (TYPEOF(le.Input_company_rawaid))'','',':company_rawaid')
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
 
+    #IF( #TEXT(Input_company_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_company_bdid = (TYPEOF(le.Input_company_bdid))'','',':company_bdid')
    #END
 
+    #IF( #TEXT(Input_company_address_type_raw)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_type_raw = (TYPEOF(le.Input_company_address_type_raw))'','',':company_address_type_raw')
    #END
 
+    #IF( #TEXT(Input_company_fein)='' )
      '' 
    #ELSE
        IF( le.Input_company_fein = (TYPEOF(le.Input_company_fein))'','',':company_fein')
    #END
 
+    #IF( #TEXT(Input_best_fein_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_best_fein_indicator = (TYPEOF(le.Input_best_fein_indicator))'','',':best_fein_indicator')
    #END
 
+    #IF( #TEXT(Input_company_phone)='' )
      '' 
    #ELSE
        IF( le.Input_company_phone = (TYPEOF(le.Input_company_phone))'','',':company_phone')
    #END
 
+    #IF( #TEXT(Input_phone_type)='' )
      '' 
    #ELSE
        IF( le.Input_phone_type = (TYPEOF(le.Input_phone_type))'','',':phone_type')
    #END
 
+    #IF( #TEXT(Input_phone_score)='' )
      '' 
    #ELSE
        IF( le.Input_phone_score = (TYPEOF(le.Input_phone_score))'','',':phone_score')
    #END
 
+    #IF( #TEXT(Input_company_org_structure_raw)='' )
      '' 
    #ELSE
        IF( le.Input_company_org_structure_raw = (TYPEOF(le.Input_company_org_structure_raw))'','',':company_org_structure_raw')
    #END
 
+    #IF( #TEXT(Input_company_incorporation_date)='' )
      '' 
    #ELSE
        IF( le.Input_company_incorporation_date = (TYPEOF(le.Input_company_incorporation_date))'','',':company_incorporation_date')
    #END
 
+    #IF( #TEXT(Input_company_sic_code1)='' )
      '' 
    #ELSE
        IF( le.Input_company_sic_code1 = (TYPEOF(le.Input_company_sic_code1))'','',':company_sic_code1')
    #END
 
+    #IF( #TEXT(Input_company_sic_code2)='' )
      '' 
    #ELSE
        IF( le.Input_company_sic_code2 = (TYPEOF(le.Input_company_sic_code2))'','',':company_sic_code2')
    #END
 
+    #IF( #TEXT(Input_company_sic_code3)='' )
      '' 
    #ELSE
        IF( le.Input_company_sic_code3 = (TYPEOF(le.Input_company_sic_code3))'','',':company_sic_code3')
    #END
 
+    #IF( #TEXT(Input_company_sic_code4)='' )
      '' 
    #ELSE
        IF( le.Input_company_sic_code4 = (TYPEOF(le.Input_company_sic_code4))'','',':company_sic_code4')
    #END
 
+    #IF( #TEXT(Input_company_sic_code5)='' )
      '' 
    #ELSE
        IF( le.Input_company_sic_code5 = (TYPEOF(le.Input_company_sic_code5))'','',':company_sic_code5')
    #END
 
+    #IF( #TEXT(Input_company_naics_code1)='' )
      '' 
    #ELSE
        IF( le.Input_company_naics_code1 = (TYPEOF(le.Input_company_naics_code1))'','',':company_naics_code1')
    #END
 
+    #IF( #TEXT(Input_company_naics_code2)='' )
      '' 
    #ELSE
        IF( le.Input_company_naics_code2 = (TYPEOF(le.Input_company_naics_code2))'','',':company_naics_code2')
    #END
 
+    #IF( #TEXT(Input_company_naics_code3)='' )
      '' 
    #ELSE
        IF( le.Input_company_naics_code3 = (TYPEOF(le.Input_company_naics_code3))'','',':company_naics_code3')
    #END
 
+    #IF( #TEXT(Input_company_naics_code4)='' )
      '' 
    #ELSE
        IF( le.Input_company_naics_code4 = (TYPEOF(le.Input_company_naics_code4))'','',':company_naics_code4')
    #END
 
+    #IF( #TEXT(Input_company_naics_code5)='' )
      '' 
    #ELSE
        IF( le.Input_company_naics_code5 = (TYPEOF(le.Input_company_naics_code5))'','',':company_naics_code5')
    #END
 
+    #IF( #TEXT(Input_company_ticker)='' )
      '' 
    #ELSE
        IF( le.Input_company_ticker = (TYPEOF(le.Input_company_ticker))'','',':company_ticker')
    #END
 
+    #IF( #TEXT(Input_company_ticker_exchange)='' )
      '' 
    #ELSE
        IF( le.Input_company_ticker_exchange = (TYPEOF(le.Input_company_ticker_exchange))'','',':company_ticker_exchange')
    #END
 
+    #IF( #TEXT(Input_company_foreign_domestic)='' )
      '' 
    #ELSE
        IF( le.Input_company_foreign_domestic = (TYPEOF(le.Input_company_foreign_domestic))'','',':company_foreign_domestic')
    #END
 
+    #IF( #TEXT(Input_company_url)='' )
      '' 
    #ELSE
        IF( le.Input_company_url = (TYPEOF(le.Input_company_url))'','',':company_url')
    #END
 
+    #IF( #TEXT(Input_company_inc_state)='' )
      '' 
    #ELSE
        IF( le.Input_company_inc_state = (TYPEOF(le.Input_company_inc_state))'','',':company_inc_state')
    #END
 
+    #IF( #TEXT(Input_company_charter_number)='' )
      '' 
    #ELSE
        IF( le.Input_company_charter_number = (TYPEOF(le.Input_company_charter_number))'','',':company_charter_number')
    #END
 
+    #IF( #TEXT(Input_company_filing_date)='' )
      '' 
    #ELSE
        IF( le.Input_company_filing_date = (TYPEOF(le.Input_company_filing_date))'','',':company_filing_date')
    #END
 
+    #IF( #TEXT(Input_company_status_date)='' )
      '' 
    #ELSE
        IF( le.Input_company_status_date = (TYPEOF(le.Input_company_status_date))'','',':company_status_date')
    #END
 
+    #IF( #TEXT(Input_company_foreign_date)='' )
      '' 
    #ELSE
        IF( le.Input_company_foreign_date = (TYPEOF(le.Input_company_foreign_date))'','',':company_foreign_date')
    #END
 
+    #IF( #TEXT(Input_event_filing_date)='' )
      '' 
    #ELSE
        IF( le.Input_event_filing_date = (TYPEOF(le.Input_event_filing_date))'','',':event_filing_date')
    #END
 
+    #IF( #TEXT(Input_company_name_status_raw)='' )
      '' 
    #ELSE
        IF( le.Input_company_name_status_raw = (TYPEOF(le.Input_company_name_status_raw))'','',':company_name_status_raw')
    #END
 
+    #IF( #TEXT(Input_company_status_raw)='' )
      '' 
    #ELSE
        IF( le.Input_company_status_raw = (TYPEOF(le.Input_company_status_raw))'','',':company_status_raw')
    #END
 
+    #IF( #TEXT(Input_vl_id)='' )
      '' 
    #ELSE
        IF( le.Input_vl_id = (TYPEOF(le.Input_vl_id))'','',':vl_id')
    #END
 
+    #IF( #TEXT(Input_current)='' )
      '' 
    #ELSE
        IF( le.Input_current = (TYPEOF(le.Input_current))'','',':current')
    #END
 
+    #IF( #TEXT(Input_contact_did)='' )
      '' 
    #ELSE
        IF( le.Input_contact_did = (TYPEOF(le.Input_contact_did))'','',':contact_did')
    #END
 
+    #IF( #TEXT(Input_contact_type_raw)='' )
      '' 
    #ELSE
        IF( le.Input_contact_type_raw = (TYPEOF(le.Input_contact_type_raw))'','',':contact_type_raw')
    #END
 
+    #IF( #TEXT(Input_contact_job_title_raw)='' )
      '' 
    #ELSE
        IF( le.Input_contact_job_title_raw = (TYPEOF(le.Input_contact_job_title_raw))'','',':contact_job_title_raw')
    #END
 
+    #IF( #TEXT(Input_contact_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_contact_ssn = (TYPEOF(le.Input_contact_ssn))'','',':contact_ssn')
    #END
 
+    #IF( #TEXT(Input_contact_dob)='' )
      '' 
    #ELSE
        IF( le.Input_contact_dob = (TYPEOF(le.Input_contact_dob))'','',':contact_dob')
    #END
 
+    #IF( #TEXT(Input_contact_status_raw)='' )
      '' 
    #ELSE
        IF( le.Input_contact_status_raw = (TYPEOF(le.Input_contact_status_raw))'','',':contact_status_raw')
    #END
 
+    #IF( #TEXT(Input_contact_email)='' )
      '' 
    #ELSE
        IF( le.Input_contact_email = (TYPEOF(le.Input_contact_email))'','',':contact_email')
    #END
 
+    #IF( #TEXT(Input_contact_email_username)='' )
      '' 
    #ELSE
        IF( le.Input_contact_email_username = (TYPEOF(le.Input_contact_email_username))'','',':contact_email_username')
    #END
 
+    #IF( #TEXT(Input_contact_email_domain)='' )
      '' 
    #ELSE
        IF( le.Input_contact_email_domain = (TYPEOF(le.Input_contact_email_domain))'','',':contact_email_domain')
    #END
 
+    #IF( #TEXT(Input_contact_phone)='' )
      '' 
    #ELSE
        IF( le.Input_contact_phone = (TYPEOF(le.Input_contact_phone))'','',':contact_phone')
    #END
 
+    #IF( #TEXT(Input_from_hdr)='' )
      '' 
    #ELSE
        IF( le.Input_from_hdr = (TYPEOF(le.Input_from_hdr))'','',':from_hdr')
    #END
 
+    #IF( #TEXT(Input_company_department)='' )
      '' 
    #ELSE
        IF( le.Input_company_department = (TYPEOF(le.Input_company_department))'','',':company_department')
    #END
 
+    #IF( #TEXT(Input_company_address_type_derived)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_type_derived = (TYPEOF(le.Input_company_address_type_derived))'','',':company_address_type_derived')
    #END
 
+    #IF( #TEXT(Input_company_org_structure_derived)='' )
      '' 
    #ELSE
        IF( le.Input_company_org_structure_derived = (TYPEOF(le.Input_company_org_structure_derived))'','',':company_org_structure_derived')
    #END
 
+    #IF( #TEXT(Input_company_name_status_derived)='' )
      '' 
    #ELSE
        IF( le.Input_company_name_status_derived = (TYPEOF(le.Input_company_name_status_derived))'','',':company_name_status_derived')
    #END
 
+    #IF( #TEXT(Input_company_status_derived)='' )
      '' 
    #ELSE
        IF( le.Input_company_status_derived = (TYPEOF(le.Input_company_status_derived))'','',':company_status_derived')
    #END
 
+    #IF( #TEXT(Input_contact_type_derived)='' )
      '' 
    #ELSE
        IF( le.Input_contact_type_derived = (TYPEOF(le.Input_contact_type_derived))'','',':contact_type_derived')
    #END
 
+    #IF( #TEXT(Input_contact_job_title_derived)='' )
      '' 
    #ELSE
        IF( le.Input_contact_job_title_derived = (TYPEOF(le.Input_contact_job_title_derived))'','',':contact_job_title_derived')
    #END
 
+    #IF( #TEXT(Input_contact_status_derived)='' )
      '' 
    #ELSE
        IF( le.Input_contact_status_derived = (TYPEOF(le.Input_contact_status_derived))'','',':contact_status_derived')
    #END
;
    #IF (#TEXT(source)<>'')
    SELF.source := le.source;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(source)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(source)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(source)<>'' ) source, #END -cnt );
ENDMACRO;
