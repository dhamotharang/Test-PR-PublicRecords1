 
EXPORT Ingest_MAC_PopulationStatistics(infile,Ref='',source_expanded='',Input_source_expanded = '',Input_source = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_rcid = '',Input_company_bdid = '',Input_company_name = '',Input_company_name_type_raw = '',Input_company_rawaid = '',Input_company_address_prim_range = '',Input_company_address_predir = '',Input_company_address_prim_name = '',Input_company_address_addr_suffix = '',Input_company_address_postdir = '',Input_company_address_unit_desig = '',Input_company_address_sec_range = '',Input_company_address_p_city_name = '',Input_company_address_v_city_name = '',Input_company_address_st = '',Input_company_address_zip = '',Input_company_address_zip4 = '',Input_company_address_cart = '',Input_company_address_cr_sort_sz = '',Input_company_address_lot = '',Input_company_address_lot_order = '',Input_company_address_dbpc = '',Input_company_address_chk_digit = '',Input_company_address_rec_type = '',Input_company_address_fips_state = '',Input_company_address_fips_county = '',Input_company_address_geo_lat = '',Input_company_address_geo_long = '',Input_company_address_msa = '',Input_company_address_geo_blk = '',Input_company_address_geo_match = '',Input_company_address_err_stat = '',Input_company_address_type_raw = '',Input_company_address_category = '',Input_company_address_country_code = '',Input_company_fein = '',Input_best_fein_indicator = '',Input_company_phone = '',Input_phone_type = '',Input_company_org_structure_raw = '',Input_company_incorporation_date = '',Input_company_sic_code1 = '',Input_company_sic_code2 = '',Input_company_sic_code3 = '',Input_company_sic_code4 = '',Input_company_sic_code5 = '',Input_company_naics_code1 = '',Input_company_naics_code2 = '',Input_company_naics_code3 = '',Input_company_naics_code4 = '',Input_company_naics_code5 = '',Input_company_ticker = '',Input_company_ticker_exchange = '',Input_company_foreign_domestic = '',Input_company_url = '',Input_company_inc_state = '',Input_company_charter_number = '',Input_company_filing_date = '',Input_company_status_date = '',Input_company_foreign_date = '',Input_event_filing_date = '',Input_company_name_status_raw = '',Input_company_status_raw = '',Input_dt_first_seen_company_name = '',Input_dt_last_seen_company_name = '',Input_dt_first_seen_company_address = '',Input_dt_last_seen_company_address = '',Input_vl_id = '',Input_current = '',Input_source_record_id = '',Input_glb = '',Input_dppa = '',Input_phone_score = '',Input_match_company_name = '',Input_match_branch_city = '',Input_match_geo_city = '',Input_duns_number = '',Input_source_docid = '',Input_is_contact = '',Input_dt_first_seen_contact = '',Input_dt_last_seen_contact = '',Input_contact_did = '',Input_contact_name_title = '',Input_contact_name_fname = '',Input_contact_name_lname = '',Input_contact_name_name_suffix = '',Input_contact_name_name_score = '',Input_contact_type_raw = '',Input_contact_job_title_raw = '',Input_contact_ssn = '',Input_contact_dob = '',Input_contact_status_raw = '',Input_contact_email = '',Input_contact_email_username = '',Input_contact_email_domain = '',Input_contact_phone = '',Input_cid = '',Input_contact_score = '',Input_from_hdr = '',Input_company_department = '',Input_company_aceaid = '',Input_company_name_type_derived = '',Input_company_address_type_derived = '',Input_company_org_structure_derived = '',Input_company_name_status_derived = '',Input_company_status_derived = '',Input_proxid_status_private = '',Input_powid_status_private = '',Input_seleid_status_private = '',Input_orgid_status_private = '',Input_ultid_status_private = '',Input_proxid_status_public = '',Input_powid_status_public = '',Input_seleid_status_public = '',Input_orgid_status_public = '',Input_ultid_status_public = '',Input_contact_type_derived = '',Input_contact_job_title_derived = '',Input_contact_status_derived = '',Input_address_type_derived = '',Input_is_vanity_name_derived = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_BIPV2;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(source_expanded)<>'')
    SALT311.StrType source;
    #END
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_source_expanded)='' )
      '' 
    #ELSE
        IF( le.Input_source_expanded = (TYPEOF(le.Input_source_expanded))'','',':source_expanded')
    #END
 
+    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
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
 
+    #IF( #TEXT(Input_rcid)='' )
      '' 
    #ELSE
        IF( le.Input_rcid = (TYPEOF(le.Input_rcid))'','',':rcid')
    #END
 
+    #IF( #TEXT(Input_company_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_company_bdid = (TYPEOF(le.Input_company_bdid))'','',':company_bdid')
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
 
+    #IF( #TEXT(Input_company_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_company_rawaid = (TYPEOF(le.Input_company_rawaid))'','',':company_rawaid')
    #END
 
+    #IF( #TEXT(Input_company_address_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_prim_range = (TYPEOF(le.Input_company_address_prim_range))'','',':company_address_prim_range')
    #END
 
+    #IF( #TEXT(Input_company_address_predir)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_predir = (TYPEOF(le.Input_company_address_predir))'','',':company_address_predir')
    #END
 
+    #IF( #TEXT(Input_company_address_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_prim_name = (TYPEOF(le.Input_company_address_prim_name))'','',':company_address_prim_name')
    #END
 
+    #IF( #TEXT(Input_company_address_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_addr_suffix = (TYPEOF(le.Input_company_address_addr_suffix))'','',':company_address_addr_suffix')
    #END
 
+    #IF( #TEXT(Input_company_address_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_postdir = (TYPEOF(le.Input_company_address_postdir))'','',':company_address_postdir')
    #END
 
+    #IF( #TEXT(Input_company_address_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_unit_desig = (TYPEOF(le.Input_company_address_unit_desig))'','',':company_address_unit_desig')
    #END
 
+    #IF( #TEXT(Input_company_address_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_sec_range = (TYPEOF(le.Input_company_address_sec_range))'','',':company_address_sec_range')
    #END
 
+    #IF( #TEXT(Input_company_address_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_p_city_name = (TYPEOF(le.Input_company_address_p_city_name))'','',':company_address_p_city_name')
    #END
 
+    #IF( #TEXT(Input_company_address_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_v_city_name = (TYPEOF(le.Input_company_address_v_city_name))'','',':company_address_v_city_name')
    #END
 
+    #IF( #TEXT(Input_company_address_st)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_st = (TYPEOF(le.Input_company_address_st))'','',':company_address_st')
    #END
 
+    #IF( #TEXT(Input_company_address_zip)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_zip = (TYPEOF(le.Input_company_address_zip))'','',':company_address_zip')
    #END
 
+    #IF( #TEXT(Input_company_address_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_zip4 = (TYPEOF(le.Input_company_address_zip4))'','',':company_address_zip4')
    #END
 
+    #IF( #TEXT(Input_company_address_cart)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_cart = (TYPEOF(le.Input_company_address_cart))'','',':company_address_cart')
    #END
 
+    #IF( #TEXT(Input_company_address_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_cr_sort_sz = (TYPEOF(le.Input_company_address_cr_sort_sz))'','',':company_address_cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_company_address_lot)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_lot = (TYPEOF(le.Input_company_address_lot))'','',':company_address_lot')
    #END
 
+    #IF( #TEXT(Input_company_address_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_lot_order = (TYPEOF(le.Input_company_address_lot_order))'','',':company_address_lot_order')
    #END
 
+    #IF( #TEXT(Input_company_address_dbpc)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_dbpc = (TYPEOF(le.Input_company_address_dbpc))'','',':company_address_dbpc')
    #END
 
+    #IF( #TEXT(Input_company_address_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_chk_digit = (TYPEOF(le.Input_company_address_chk_digit))'','',':company_address_chk_digit')
    #END
 
+    #IF( #TEXT(Input_company_address_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_rec_type = (TYPEOF(le.Input_company_address_rec_type))'','',':company_address_rec_type')
    #END
 
+    #IF( #TEXT(Input_company_address_fips_state)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_fips_state = (TYPEOF(le.Input_company_address_fips_state))'','',':company_address_fips_state')
    #END
 
+    #IF( #TEXT(Input_company_address_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_fips_county = (TYPEOF(le.Input_company_address_fips_county))'','',':company_address_fips_county')
    #END
 
+    #IF( #TEXT(Input_company_address_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_geo_lat = (TYPEOF(le.Input_company_address_geo_lat))'','',':company_address_geo_lat')
    #END
 
+    #IF( #TEXT(Input_company_address_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_geo_long = (TYPEOF(le.Input_company_address_geo_long))'','',':company_address_geo_long')
    #END
 
+    #IF( #TEXT(Input_company_address_msa)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_msa = (TYPEOF(le.Input_company_address_msa))'','',':company_address_msa')
    #END
 
+    #IF( #TEXT(Input_company_address_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_geo_blk = (TYPEOF(le.Input_company_address_geo_blk))'','',':company_address_geo_blk')
    #END
 
+    #IF( #TEXT(Input_company_address_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_geo_match = (TYPEOF(le.Input_company_address_geo_match))'','',':company_address_geo_match')
    #END
 
+    #IF( #TEXT(Input_company_address_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_err_stat = (TYPEOF(le.Input_company_address_err_stat))'','',':company_address_err_stat')
    #END
 
+    #IF( #TEXT(Input_company_address_type_raw)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_type_raw = (TYPEOF(le.Input_company_address_type_raw))'','',':company_address_type_raw')
    #END
 
+    #IF( #TEXT(Input_company_address_category)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_category = (TYPEOF(le.Input_company_address_category))'','',':company_address_category')
    #END
 
+    #IF( #TEXT(Input_company_address_country_code)='' )
      '' 
    #ELSE
        IF( le.Input_company_address_country_code = (TYPEOF(le.Input_company_address_country_code))'','',':company_address_country_code')
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
 
+    #IF( #TEXT(Input_source_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_record_id = (TYPEOF(le.Input_source_record_id))'','',':source_record_id')
    #END
 
+    #IF( #TEXT(Input_glb)='' )
      '' 
    #ELSE
        IF( le.Input_glb = (TYPEOF(le.Input_glb))'','',':glb')
    #END
 
+    #IF( #TEXT(Input_dppa)='' )
      '' 
    #ELSE
        IF( le.Input_dppa = (TYPEOF(le.Input_dppa))'','',':dppa')
    #END
 
+    #IF( #TEXT(Input_phone_score)='' )
      '' 
    #ELSE
        IF( le.Input_phone_score = (TYPEOF(le.Input_phone_score))'','',':phone_score')
    #END
 
+    #IF( #TEXT(Input_match_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_match_company_name = (TYPEOF(le.Input_match_company_name))'','',':match_company_name')
    #END
 
+    #IF( #TEXT(Input_match_branch_city)='' )
      '' 
    #ELSE
        IF( le.Input_match_branch_city = (TYPEOF(le.Input_match_branch_city))'','',':match_branch_city')
    #END
 
+    #IF( #TEXT(Input_match_geo_city)='' )
      '' 
    #ELSE
        IF( le.Input_match_geo_city = (TYPEOF(le.Input_match_geo_city))'','',':match_geo_city')
    #END
 
+    #IF( #TEXT(Input_duns_number)='' )
      '' 
    #ELSE
        IF( le.Input_duns_number = (TYPEOF(le.Input_duns_number))'','',':duns_number')
    #END
 
+    #IF( #TEXT(Input_source_docid)='' )
      '' 
    #ELSE
        IF( le.Input_source_docid = (TYPEOF(le.Input_source_docid))'','',':source_docid')
    #END
 
+    #IF( #TEXT(Input_is_contact)='' )
      '' 
    #ELSE
        IF( le.Input_is_contact = (TYPEOF(le.Input_is_contact))'','',':is_contact')
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
 
+    #IF( #TEXT(Input_contact_did)='' )
      '' 
    #ELSE
        IF( le.Input_contact_did = (TYPEOF(le.Input_contact_did))'','',':contact_did')
    #END
 
+    #IF( #TEXT(Input_contact_name_title)='' )
      '' 
    #ELSE
        IF( le.Input_contact_name_title = (TYPEOF(le.Input_contact_name_title))'','',':contact_name_title')
    #END
 
+    #IF( #TEXT(Input_contact_name_fname)='' )
      '' 
    #ELSE
        IF( le.Input_contact_name_fname = (TYPEOF(le.Input_contact_name_fname))'','',':contact_name_fname')
    #END
 
+    #IF( #TEXT(Input_contact_name_lname)='' )
      '' 
    #ELSE
        IF( le.Input_contact_name_lname = (TYPEOF(le.Input_contact_name_lname))'','',':contact_name_lname')
    #END
 
+    #IF( #TEXT(Input_contact_name_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_contact_name_name_suffix = (TYPEOF(le.Input_contact_name_name_suffix))'','',':contact_name_name_suffix')
    #END
 
+    #IF( #TEXT(Input_contact_name_name_score)='' )
      '' 
    #ELSE
        IF( le.Input_contact_name_name_score = (TYPEOF(le.Input_contact_name_name_score))'','',':contact_name_name_score')
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
 
+    #IF( #TEXT(Input_cid)='' )
      '' 
    #ELSE
        IF( le.Input_cid = (TYPEOF(le.Input_cid))'','',':cid')
    #END
 
+    #IF( #TEXT(Input_contact_score)='' )
      '' 
    #ELSE
        IF( le.Input_contact_score = (TYPEOF(le.Input_contact_score))'','',':contact_score')
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
 
+    #IF( #TEXT(Input_company_aceaid)='' )
      '' 
    #ELSE
        IF( le.Input_company_aceaid = (TYPEOF(le.Input_company_aceaid))'','',':company_aceaid')
    #END
 
+    #IF( #TEXT(Input_company_name_type_derived)='' )
      '' 
    #ELSE
        IF( le.Input_company_name_type_derived = (TYPEOF(le.Input_company_name_type_derived))'','',':company_name_type_derived')
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
 
+    #IF( #TEXT(Input_proxid_status_private)='' )
      '' 
    #ELSE
        IF( le.Input_proxid_status_private = (TYPEOF(le.Input_proxid_status_private))'','',':proxid_status_private')
    #END
 
+    #IF( #TEXT(Input_powid_status_private)='' )
      '' 
    #ELSE
        IF( le.Input_powid_status_private = (TYPEOF(le.Input_powid_status_private))'','',':powid_status_private')
    #END
 
+    #IF( #TEXT(Input_seleid_status_private)='' )
      '' 
    #ELSE
        IF( le.Input_seleid_status_private = (TYPEOF(le.Input_seleid_status_private))'','',':seleid_status_private')
    #END
 
+    #IF( #TEXT(Input_orgid_status_private)='' )
      '' 
    #ELSE
        IF( le.Input_orgid_status_private = (TYPEOF(le.Input_orgid_status_private))'','',':orgid_status_private')
    #END
 
+    #IF( #TEXT(Input_ultid_status_private)='' )
      '' 
    #ELSE
        IF( le.Input_ultid_status_private = (TYPEOF(le.Input_ultid_status_private))'','',':ultid_status_private')
    #END
 
+    #IF( #TEXT(Input_proxid_status_public)='' )
      '' 
    #ELSE
        IF( le.Input_proxid_status_public = (TYPEOF(le.Input_proxid_status_public))'','',':proxid_status_public')
    #END
 
+    #IF( #TEXT(Input_powid_status_public)='' )
      '' 
    #ELSE
        IF( le.Input_powid_status_public = (TYPEOF(le.Input_powid_status_public))'','',':powid_status_public')
    #END
 
+    #IF( #TEXT(Input_seleid_status_public)='' )
      '' 
    #ELSE
        IF( le.Input_seleid_status_public = (TYPEOF(le.Input_seleid_status_public))'','',':seleid_status_public')
    #END
 
+    #IF( #TEXT(Input_orgid_status_public)='' )
      '' 
    #ELSE
        IF( le.Input_orgid_status_public = (TYPEOF(le.Input_orgid_status_public))'','',':orgid_status_public')
    #END
 
+    #IF( #TEXT(Input_ultid_status_public)='' )
      '' 
    #ELSE
        IF( le.Input_ultid_status_public = (TYPEOF(le.Input_ultid_status_public))'','',':ultid_status_public')
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
 
+    #IF( #TEXT(Input_address_type_derived)='' )
      '' 
    #ELSE
        IF( le.Input_address_type_derived = (TYPEOF(le.Input_address_type_derived))'','',':address_type_derived')
    #END
 
+    #IF( #TEXT(Input_is_vanity_name_derived)='' )
      '' 
    #ELSE
        IF( le.Input_is_vanity_name_derived = (TYPEOF(le.Input_is_vanity_name_derived))'','',':is_vanity_name_derived')
    #END
;
    #IF (#TEXT(source_expanded)<>'')
    SELF.source := le.source_expanded;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(source_expanded)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(source_expanded)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(source_expanded)<>'' ) source, #END -cnt );
ENDMACRO;
