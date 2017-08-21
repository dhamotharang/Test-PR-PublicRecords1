 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_source_rec_id = '',Input_bdid = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_corp_ra_dt_first_seen = '',Input_corp_ra_dt_last_seen = '',Input_corp_key = '',Input_corp_supp_key = '',Input_corp_vendor = '',Input_corp_vendor_county = '',Input_corp_vendor_subcode = '',Input_corp_state_origin = '',Input_corp_process_date = '',Input_corp_orig_sos_charter_nbr = '',Input_corp_sos_charter_nbr = '',Input_corp_src_type = '',Input_corp_legal_name = '',Input_corp_ln_name_type_cd = '',Input_corp_ln_name_type_desc = '',Input_corp_supp_nbr = '',Input_corp_name_comment = '',Input_corp_address1_type_cd = '',Input_corp_address1_type_desc = '',Input_corp_address1_line1 = '',Input_corp_address1_line2 = '',Input_corp_address1_line3 = '',Input_corp_address1_line4 = '',Input_corp_address1_line5 = '',Input_corp_address1_line6 = '',Input_corp_address1_effective_date = '',Input_corp_address2_type_cd = '',Input_corp_address2_type_desc = '',Input_corp_address2_line1 = '',Input_corp_address2_line2 = '',Input_corp_address2_line3 = '',Input_corp_address2_line4 = '',Input_corp_address2_line5 = '',Input_corp_address2_line6 = '',Input_corp_address2_effective_date = '',Input_corp_phone_number = '',Input_corp_phone_number_type_cd = '',Input_corp_phone_number_type_desc = '',Input_corp_fax_nbr = '',Input_corp_email_address = '',Input_corp_web_address = '',Input_corp_filing_reference_nbr = '',Input_corp_filing_date = '',Input_corp_filing_cd = '',Input_corp_filing_desc = '',Input_corp_status_cd = '',Input_corp_status_desc = '',Input_corp_status_date = '',Input_corp_standing = '',Input_corp_status_comment = '',Input_corp_ticker_symbol = '',Input_corp_stock_exchange = '',Input_corp_inc_state = '',Input_corp_inc_county = '',Input_corp_inc_date = '',Input_corp_anniversary_month = '',Input_corp_fed_tax_id = '',Input_corp_state_tax_id = '',Input_corp_term_exist_cd = '',Input_corp_term_exist_exp = '',Input_corp_term_exist_desc = '',Input_corp_foreign_domestic_ind = '',Input_corp_forgn_state_cd = '',Input_corp_forgn_state_desc = '',Input_corp_forgn_sos_charter_nbr = '',Input_corp_forgn_date = '',Input_corp_forgn_fed_tax_id = '',Input_corp_forgn_state_tax_id = '',Input_corp_forgn_term_exist_cd = '',Input_corp_forgn_term_exist_exp = '',Input_corp_forgn_term_exist_desc = '',Input_corp_orig_org_structure_cd = '',Input_corp_orig_org_structure_desc = '',Input_corp_for_profit_ind = '',Input_corp_public_or_private_ind = '',Input_corp_sic_code = '',Input_corp_naic_code = '',Input_corp_orig_bus_type_cd = '',Input_corp_orig_bus_type_desc = '',Input_corp_entity_desc = '',Input_corp_certificate_nbr = '',Input_corp_internal_nbr = '',Input_corp_previous_nbr = '',Input_corp_microfilm_nbr = '',Input_corp_amendments_filed = '',Input_corp_acts = '',Input_corp_partnership_ind = '',Input_corp_mfg_ind = '',Input_corp_addl_info = '',Input_corp_taxes = '',Input_corp_franchise_taxes = '',Input_corp_tax_program_cd = '',Input_corp_tax_program_desc = '',Input_corp_ra_name = '',Input_corp_ra_title_cd = '',Input_corp_ra_title_desc = '',Input_corp_ra_fein = '',Input_corp_ra_ssn = '',Input_corp_ra_dob = '',Input_corp_ra_effective_date = '',Input_corp_ra_resign_date = '',Input_corp_ra_no_comp = '',Input_corp_ra_no_comp_igs = '',Input_corp_ra_addl_info = '',Input_corp_ra_address_type_cd = '',Input_corp_ra_address_type_desc = '',Input_corp_ra_address_line1 = '',Input_corp_ra_address_line2 = '',Input_corp_ra_address_line3 = '',Input_corp_ra_address_line4 = '',Input_corp_ra_address_line5 = '',Input_corp_ra_address_line6 = '',Input_corp_ra_phone_number = '',Input_corp_ra_phone_number_type_cd = '',Input_corp_ra_phone_number_type_desc = '',Input_corp_ra_fax_nbr = '',Input_corp_ra_email_address = '',Input_corp_ra_web_address = '',Input_corp_addr1_prim_range = '',Input_corp_addr1_predir = '',Input_corp_addr1_prim_name = '',Input_corp_addr1_addr_suffix = '',Input_corp_addr1_postdir = '',Input_corp_addr1_unit_desig = '',Input_corp_addr1_sec_range = '',Input_corp_addr1_p_city_name = '',Input_corp_addr1_v_city_name = '',Input_corp_addr1_state = '',Input_corp_addr1_zip5 = '',Input_corp_addr1_zip4 = '',Input_corp_addr1_cart = '',Input_corp_addr1_cr_sort_sz = '',Input_corp_addr1_lot = '',Input_corp_addr1_lot_order = '',Input_corp_addr1_dpbc = '',Input_corp_addr1_chk_digit = '',Input_corp_addr1_rec_type = '',Input_corp_addr1_ace_fips_st = '',Input_corp_addr1_county = '',Input_corp_addr1_geo_lat = '',Input_corp_addr1_geo_long = '',Input_corp_addr1_msa = '',Input_corp_addr1_geo_blk = '',Input_corp_addr1_geo_match = '',Input_corp_addr1_err_stat = '',Input_corp_addr2_prim_range = '',Input_corp_addr2_predir = '',Input_corp_addr2_prim_name = '',Input_corp_addr2_addr_suffix = '',Input_corp_addr2_postdir = '',Input_corp_addr2_unit_desig = '',Input_corp_addr2_sec_range = '',Input_corp_addr2_p_city_name = '',Input_corp_addr2_v_city_name = '',Input_corp_addr2_state = '',Input_corp_addr2_zip5 = '',Input_corp_addr2_zip4 = '',Input_corp_addr2_cart = '',Input_corp_addr2_cr_sort_sz = '',Input_corp_addr2_lot = '',Input_corp_addr2_lot_order = '',Input_corp_addr2_dpbc = '',Input_corp_addr2_chk_digit = '',Input_corp_addr2_rec_type = '',Input_corp_addr2_ace_fips_st = '',Input_corp_addr2_county = '',Input_corp_addr2_geo_lat = '',Input_corp_addr2_geo_long = '',Input_corp_addr2_msa = '',Input_corp_addr2_geo_blk = '',Input_corp_addr2_geo_match = '',Input_corp_addr2_err_stat = '',Input_corp_ra_title1 = '',Input_corp_ra_fname1 = '',Input_corp_ra_mname1 = '',Input_corp_ra_lname1 = '',Input_corp_ra_name_suffix1 = '',Input_corp_ra_score1 = '',Input_corp_ra_title2 = '',Input_corp_ra_fname2 = '',Input_corp_ra_mname2 = '',Input_corp_ra_lname2 = '',Input_corp_ra_name_suffix2 = '',Input_corp_ra_score2 = '',Input_corp_ra_cname1 = '',Input_corp_ra_cname1_score = '',Input_corp_ra_cname2 = '',Input_corp_ra_cname2_score = '',Input_corp_ra_prim_range = '',Input_corp_ra_predir = '',Input_corp_ra_prim_name = '',Input_corp_ra_addr_suffix = '',Input_corp_ra_postdir = '',Input_corp_ra_unit_desig = '',Input_corp_ra_sec_range = '',Input_corp_ra_p_city_name = '',Input_corp_ra_v_city_name = '',Input_corp_ra_state = '',Input_corp_ra_zip5 = '',Input_corp_ra_zip4 = '',Input_corp_ra_cart = '',Input_corp_ra_cr_sort_sz = '',Input_corp_ra_lot = '',Input_corp_ra_lot_order = '',Input_corp_ra_dpbc = '',Input_corp_ra_chk_digit = '',Input_corp_ra_rec_type = '',Input_corp_ra_ace_fips_st = '',Input_corp_ra_county = '',Input_corp_ra_geo_lat = '',Input_corp_ra_geo_long = '',Input_corp_ra_msa = '',Input_corp_ra_geo_blk = '',Input_corp_ra_geo_match = '',Input_corp_ra_err_stat = '',Input_corp_phone10 = '',Input_corp_ra_phone10 = '',Input_record_type = '',Input_append_addr1_rawaid = '',Input_append_addr1_aceaid = '',Input_corp_prep_addr1_line1 = '',Input_corp_prep_addr1_last_line = '',Input_append_addr2_rawaid = '',Input_append_addr2_aceaid = '',Input_corp_prep_addr2_line1 = '',Input_corp_prep_addr2_last_line = '',Input_append_ra_rawaid = '',Input_append_ra_aceaid = '',Input_ra_prep_addr_line1 = '',Input_ra_prep_addr_last_line = '',Input_dotid = '',Input_dotscore = '',Input_dotweight = '',Input_empid = '',Input_empscore = '',Input_empweight = '',Input_powid = '',Input_powscore = '',Input_powweight = '',Input_proxid = '',Input_proxscore = '',Input_proxweight = '',Input_seleid = '',Input_selescore = '',Input_seleweight = '',Input_orgid = '',Input_orgscore = '',Input_orgweight = '',Input_ultid = '',Input_ultscore = '',Input_ultweight = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_Corp2_Build_Corp_Base;
  #uniquename(of)
  %of% := RECORD
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_source_rec_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_rec_id = (TYPEOF(le.Input_source_rec_id))'','',':source_rec_id')
    #END
 
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
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
 
+    #IF( #TEXT(Input_corp_ra_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_dt_first_seen = (TYPEOF(le.Input_corp_ra_dt_first_seen))'','',':corp_ra_dt_first_seen')
    #END
 
+    #IF( #TEXT(Input_corp_ra_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_dt_last_seen = (TYPEOF(le.Input_corp_ra_dt_last_seen))'','',':corp_ra_dt_last_seen')
    #END
 
+    #IF( #TEXT(Input_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_corp_key = (TYPEOF(le.Input_corp_key))'','',':corp_key')
    #END
 
+    #IF( #TEXT(Input_corp_supp_key)='' )
      '' 
    #ELSE
        IF( le.Input_corp_supp_key = (TYPEOF(le.Input_corp_supp_key))'','',':corp_supp_key')
    #END
 
+    #IF( #TEXT(Input_corp_vendor)='' )
      '' 
    #ELSE
        IF( le.Input_corp_vendor = (TYPEOF(le.Input_corp_vendor))'','',':corp_vendor')
    #END
 
+    #IF( #TEXT(Input_corp_vendor_county)='' )
      '' 
    #ELSE
        IF( le.Input_corp_vendor_county = (TYPEOF(le.Input_corp_vendor_county))'','',':corp_vendor_county')
    #END
 
+    #IF( #TEXT(Input_corp_vendor_subcode)='' )
      '' 
    #ELSE
        IF( le.Input_corp_vendor_subcode = (TYPEOF(le.Input_corp_vendor_subcode))'','',':corp_vendor_subcode')
    #END
 
+    #IF( #TEXT(Input_corp_state_origin)='' )
      '' 
    #ELSE
        IF( le.Input_corp_state_origin = (TYPEOF(le.Input_corp_state_origin))'','',':corp_state_origin')
    #END
 
+    #IF( #TEXT(Input_corp_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_process_date = (TYPEOF(le.Input_corp_process_date))'','',':corp_process_date')
    #END
 
+    #IF( #TEXT(Input_corp_orig_sos_charter_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_orig_sos_charter_nbr = (TYPEOF(le.Input_corp_orig_sos_charter_nbr))'','',':corp_orig_sos_charter_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_sos_charter_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_sos_charter_nbr = (TYPEOF(le.Input_corp_sos_charter_nbr))'','',':corp_sos_charter_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_src_type)='' )
      '' 
    #ELSE
        IF( le.Input_corp_src_type = (TYPEOF(le.Input_corp_src_type))'','',':corp_src_type')
    #END
 
+    #IF( #TEXT(Input_corp_legal_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_legal_name = (TYPEOF(le.Input_corp_legal_name))'','',':corp_legal_name')
    #END
 
+    #IF( #TEXT(Input_corp_ln_name_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ln_name_type_cd = (TYPEOF(le.Input_corp_ln_name_type_cd))'','',':corp_ln_name_type_cd')
    #END
 
+    #IF( #TEXT(Input_corp_ln_name_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ln_name_type_desc = (TYPEOF(le.Input_corp_ln_name_type_desc))'','',':corp_ln_name_type_desc')
    #END
 
+    #IF( #TEXT(Input_corp_supp_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_supp_nbr = (TYPEOF(le.Input_corp_supp_nbr))'','',':corp_supp_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_name_comment)='' )
      '' 
    #ELSE
        IF( le.Input_corp_name_comment = (TYPEOF(le.Input_corp_name_comment))'','',':corp_name_comment')
    #END
 
+    #IF( #TEXT(Input_corp_address1_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address1_type_cd = (TYPEOF(le.Input_corp_address1_type_cd))'','',':corp_address1_type_cd')
    #END
 
+    #IF( #TEXT(Input_corp_address1_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address1_type_desc = (TYPEOF(le.Input_corp_address1_type_desc))'','',':corp_address1_type_desc')
    #END
 
+    #IF( #TEXT(Input_corp_address1_line1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address1_line1 = (TYPEOF(le.Input_corp_address1_line1))'','',':corp_address1_line1')
    #END
 
+    #IF( #TEXT(Input_corp_address1_line2)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address1_line2 = (TYPEOF(le.Input_corp_address1_line2))'','',':corp_address1_line2')
    #END
 
+    #IF( #TEXT(Input_corp_address1_line3)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address1_line3 = (TYPEOF(le.Input_corp_address1_line3))'','',':corp_address1_line3')
    #END
 
+    #IF( #TEXT(Input_corp_address1_line4)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address1_line4 = (TYPEOF(le.Input_corp_address1_line4))'','',':corp_address1_line4')
    #END
 
+    #IF( #TEXT(Input_corp_address1_line5)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address1_line5 = (TYPEOF(le.Input_corp_address1_line5))'','',':corp_address1_line5')
    #END
 
+    #IF( #TEXT(Input_corp_address1_line6)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address1_line6 = (TYPEOF(le.Input_corp_address1_line6))'','',':corp_address1_line6')
    #END
 
+    #IF( #TEXT(Input_corp_address1_effective_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address1_effective_date = (TYPEOF(le.Input_corp_address1_effective_date))'','',':corp_address1_effective_date')
    #END
 
+    #IF( #TEXT(Input_corp_address2_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address2_type_cd = (TYPEOF(le.Input_corp_address2_type_cd))'','',':corp_address2_type_cd')
    #END
 
+    #IF( #TEXT(Input_corp_address2_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address2_type_desc = (TYPEOF(le.Input_corp_address2_type_desc))'','',':corp_address2_type_desc')
    #END
 
+    #IF( #TEXT(Input_corp_address2_line1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address2_line1 = (TYPEOF(le.Input_corp_address2_line1))'','',':corp_address2_line1')
    #END
 
+    #IF( #TEXT(Input_corp_address2_line2)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address2_line2 = (TYPEOF(le.Input_corp_address2_line2))'','',':corp_address2_line2')
    #END
 
+    #IF( #TEXT(Input_corp_address2_line3)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address2_line3 = (TYPEOF(le.Input_corp_address2_line3))'','',':corp_address2_line3')
    #END
 
+    #IF( #TEXT(Input_corp_address2_line4)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address2_line4 = (TYPEOF(le.Input_corp_address2_line4))'','',':corp_address2_line4')
    #END
 
+    #IF( #TEXT(Input_corp_address2_line5)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address2_line5 = (TYPEOF(le.Input_corp_address2_line5))'','',':corp_address2_line5')
    #END
 
+    #IF( #TEXT(Input_corp_address2_line6)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address2_line6 = (TYPEOF(le.Input_corp_address2_line6))'','',':corp_address2_line6')
    #END
 
+    #IF( #TEXT(Input_corp_address2_effective_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_address2_effective_date = (TYPEOF(le.Input_corp_address2_effective_date))'','',':corp_address2_effective_date')
    #END
 
+    #IF( #TEXT(Input_corp_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_corp_phone_number = (TYPEOF(le.Input_corp_phone_number))'','',':corp_phone_number')
    #END
 
+    #IF( #TEXT(Input_corp_phone_number_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_phone_number_type_cd = (TYPEOF(le.Input_corp_phone_number_type_cd))'','',':corp_phone_number_type_cd')
    #END
 
+    #IF( #TEXT(Input_corp_phone_number_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_phone_number_type_desc = (TYPEOF(le.Input_corp_phone_number_type_desc))'','',':corp_phone_number_type_desc')
    #END
 
+    #IF( #TEXT(Input_corp_fax_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_fax_nbr = (TYPEOF(le.Input_corp_fax_nbr))'','',':corp_fax_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_email_address)='' )
      '' 
    #ELSE
        IF( le.Input_corp_email_address = (TYPEOF(le.Input_corp_email_address))'','',':corp_email_address')
    #END
 
+    #IF( #TEXT(Input_corp_web_address)='' )
      '' 
    #ELSE
        IF( le.Input_corp_web_address = (TYPEOF(le.Input_corp_web_address))'','',':corp_web_address')
    #END
 
+    #IF( #TEXT(Input_corp_filing_reference_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_filing_reference_nbr = (TYPEOF(le.Input_corp_filing_reference_nbr))'','',':corp_filing_reference_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_filing_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_filing_date = (TYPEOF(le.Input_corp_filing_date))'','',':corp_filing_date')
    #END
 
+    #IF( #TEXT(Input_corp_filing_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_filing_cd = (TYPEOF(le.Input_corp_filing_cd))'','',':corp_filing_cd')
    #END
 
+    #IF( #TEXT(Input_corp_filing_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_filing_desc = (TYPEOF(le.Input_corp_filing_desc))'','',':corp_filing_desc')
    #END
 
+    #IF( #TEXT(Input_corp_status_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_status_cd = (TYPEOF(le.Input_corp_status_cd))'','',':corp_status_cd')
    #END
 
+    #IF( #TEXT(Input_corp_status_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_status_desc = (TYPEOF(le.Input_corp_status_desc))'','',':corp_status_desc')
    #END
 
+    #IF( #TEXT(Input_corp_status_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_status_date = (TYPEOF(le.Input_corp_status_date))'','',':corp_status_date')
    #END
 
+    #IF( #TEXT(Input_corp_standing)='' )
      '' 
    #ELSE
        IF( le.Input_corp_standing = (TYPEOF(le.Input_corp_standing))'','',':corp_standing')
    #END
 
+    #IF( #TEXT(Input_corp_status_comment)='' )
      '' 
    #ELSE
        IF( le.Input_corp_status_comment = (TYPEOF(le.Input_corp_status_comment))'','',':corp_status_comment')
    #END
 
+    #IF( #TEXT(Input_corp_ticker_symbol)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ticker_symbol = (TYPEOF(le.Input_corp_ticker_symbol))'','',':corp_ticker_symbol')
    #END
 
+    #IF( #TEXT(Input_corp_stock_exchange)='' )
      '' 
    #ELSE
        IF( le.Input_corp_stock_exchange = (TYPEOF(le.Input_corp_stock_exchange))'','',':corp_stock_exchange')
    #END
 
+    #IF( #TEXT(Input_corp_inc_state)='' )
      '' 
    #ELSE
        IF( le.Input_corp_inc_state = (TYPEOF(le.Input_corp_inc_state))'','',':corp_inc_state')
    #END
 
+    #IF( #TEXT(Input_corp_inc_county)='' )
      '' 
    #ELSE
        IF( le.Input_corp_inc_county = (TYPEOF(le.Input_corp_inc_county))'','',':corp_inc_county')
    #END
 
+    #IF( #TEXT(Input_corp_inc_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_inc_date = (TYPEOF(le.Input_corp_inc_date))'','',':corp_inc_date')
    #END
 
+    #IF( #TEXT(Input_corp_anniversary_month)='' )
      '' 
    #ELSE
        IF( le.Input_corp_anniversary_month = (TYPEOF(le.Input_corp_anniversary_month))'','',':corp_anniversary_month')
    #END
 
+    #IF( #TEXT(Input_corp_fed_tax_id)='' )
      '' 
    #ELSE
        IF( le.Input_corp_fed_tax_id = (TYPEOF(le.Input_corp_fed_tax_id))'','',':corp_fed_tax_id')
    #END
 
+    #IF( #TEXT(Input_corp_state_tax_id)='' )
      '' 
    #ELSE
        IF( le.Input_corp_state_tax_id = (TYPEOF(le.Input_corp_state_tax_id))'','',':corp_state_tax_id')
    #END
 
+    #IF( #TEXT(Input_corp_term_exist_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_term_exist_cd = (TYPEOF(le.Input_corp_term_exist_cd))'','',':corp_term_exist_cd')
    #END
 
+    #IF( #TEXT(Input_corp_term_exist_exp)='' )
      '' 
    #ELSE
        IF( le.Input_corp_term_exist_exp = (TYPEOF(le.Input_corp_term_exist_exp))'','',':corp_term_exist_exp')
    #END
 
+    #IF( #TEXT(Input_corp_term_exist_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_term_exist_desc = (TYPEOF(le.Input_corp_term_exist_desc))'','',':corp_term_exist_desc')
    #END
 
+    #IF( #TEXT(Input_corp_foreign_domestic_ind)='' )
      '' 
    #ELSE
        IF( le.Input_corp_foreign_domestic_ind = (TYPEOF(le.Input_corp_foreign_domestic_ind))'','',':corp_foreign_domestic_ind')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_state_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_state_cd = (TYPEOF(le.Input_corp_forgn_state_cd))'','',':corp_forgn_state_cd')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_state_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_state_desc = (TYPEOF(le.Input_corp_forgn_state_desc))'','',':corp_forgn_state_desc')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_sos_charter_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_sos_charter_nbr = (TYPEOF(le.Input_corp_forgn_sos_charter_nbr))'','',':corp_forgn_sos_charter_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_date = (TYPEOF(le.Input_corp_forgn_date))'','',':corp_forgn_date')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_fed_tax_id)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_fed_tax_id = (TYPEOF(le.Input_corp_forgn_fed_tax_id))'','',':corp_forgn_fed_tax_id')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_state_tax_id)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_state_tax_id = (TYPEOF(le.Input_corp_forgn_state_tax_id))'','',':corp_forgn_state_tax_id')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_term_exist_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_term_exist_cd = (TYPEOF(le.Input_corp_forgn_term_exist_cd))'','',':corp_forgn_term_exist_cd')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_term_exist_exp)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_term_exist_exp = (TYPEOF(le.Input_corp_forgn_term_exist_exp))'','',':corp_forgn_term_exist_exp')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_term_exist_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_term_exist_desc = (TYPEOF(le.Input_corp_forgn_term_exist_desc))'','',':corp_forgn_term_exist_desc')
    #END
 
+    #IF( #TEXT(Input_corp_orig_org_structure_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_orig_org_structure_cd = (TYPEOF(le.Input_corp_orig_org_structure_cd))'','',':corp_orig_org_structure_cd')
    #END
 
+    #IF( #TEXT(Input_corp_orig_org_structure_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_orig_org_structure_desc = (TYPEOF(le.Input_corp_orig_org_structure_desc))'','',':corp_orig_org_structure_desc')
    #END
 
+    #IF( #TEXT(Input_corp_for_profit_ind)='' )
      '' 
    #ELSE
        IF( le.Input_corp_for_profit_ind = (TYPEOF(le.Input_corp_for_profit_ind))'','',':corp_for_profit_ind')
    #END
 
+    #IF( #TEXT(Input_corp_public_or_private_ind)='' )
      '' 
    #ELSE
        IF( le.Input_corp_public_or_private_ind = (TYPEOF(le.Input_corp_public_or_private_ind))'','',':corp_public_or_private_ind')
    #END
 
+    #IF( #TEXT(Input_corp_sic_code)='' )
      '' 
    #ELSE
        IF( le.Input_corp_sic_code = (TYPEOF(le.Input_corp_sic_code))'','',':corp_sic_code')
    #END
 
+    #IF( #TEXT(Input_corp_naic_code)='' )
      '' 
    #ELSE
        IF( le.Input_corp_naic_code = (TYPEOF(le.Input_corp_naic_code))'','',':corp_naic_code')
    #END
 
+    #IF( #TEXT(Input_corp_orig_bus_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_orig_bus_type_cd = (TYPEOF(le.Input_corp_orig_bus_type_cd))'','',':corp_orig_bus_type_cd')
    #END
 
+    #IF( #TEXT(Input_corp_orig_bus_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_orig_bus_type_desc = (TYPEOF(le.Input_corp_orig_bus_type_desc))'','',':corp_orig_bus_type_desc')
    #END
 
+    #IF( #TEXT(Input_corp_entity_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_entity_desc = (TYPEOF(le.Input_corp_entity_desc))'','',':corp_entity_desc')
    #END
 
+    #IF( #TEXT(Input_corp_certificate_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_certificate_nbr = (TYPEOF(le.Input_corp_certificate_nbr))'','',':corp_certificate_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_internal_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_internal_nbr = (TYPEOF(le.Input_corp_internal_nbr))'','',':corp_internal_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_previous_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_previous_nbr = (TYPEOF(le.Input_corp_previous_nbr))'','',':corp_previous_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_microfilm_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_microfilm_nbr = (TYPEOF(le.Input_corp_microfilm_nbr))'','',':corp_microfilm_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_amendments_filed)='' )
      '' 
    #ELSE
        IF( le.Input_corp_amendments_filed = (TYPEOF(le.Input_corp_amendments_filed))'','',':corp_amendments_filed')
    #END
 
+    #IF( #TEXT(Input_corp_acts)='' )
      '' 
    #ELSE
        IF( le.Input_corp_acts = (TYPEOF(le.Input_corp_acts))'','',':corp_acts')
    #END
 
+    #IF( #TEXT(Input_corp_partnership_ind)='' )
      '' 
    #ELSE
        IF( le.Input_corp_partnership_ind = (TYPEOF(le.Input_corp_partnership_ind))'','',':corp_partnership_ind')
    #END
 
+    #IF( #TEXT(Input_corp_mfg_ind)='' )
      '' 
    #ELSE
        IF( le.Input_corp_mfg_ind = (TYPEOF(le.Input_corp_mfg_ind))'','',':corp_mfg_ind')
    #END
 
+    #IF( #TEXT(Input_corp_addl_info)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addl_info = (TYPEOF(le.Input_corp_addl_info))'','',':corp_addl_info')
    #END
 
+    #IF( #TEXT(Input_corp_taxes)='' )
      '' 
    #ELSE
        IF( le.Input_corp_taxes = (TYPEOF(le.Input_corp_taxes))'','',':corp_taxes')
    #END
 
+    #IF( #TEXT(Input_corp_franchise_taxes)='' )
      '' 
    #ELSE
        IF( le.Input_corp_franchise_taxes = (TYPEOF(le.Input_corp_franchise_taxes))'','',':corp_franchise_taxes')
    #END
 
+    #IF( #TEXT(Input_corp_tax_program_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_tax_program_cd = (TYPEOF(le.Input_corp_tax_program_cd))'','',':corp_tax_program_cd')
    #END
 
+    #IF( #TEXT(Input_corp_tax_program_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_tax_program_desc = (TYPEOF(le.Input_corp_tax_program_desc))'','',':corp_tax_program_desc')
    #END
 
+    #IF( #TEXT(Input_corp_ra_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_name = (TYPEOF(le.Input_corp_ra_name))'','',':corp_ra_name')
    #END
 
+    #IF( #TEXT(Input_corp_ra_title_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_title_cd = (TYPEOF(le.Input_corp_ra_title_cd))'','',':corp_ra_title_cd')
    #END
 
+    #IF( #TEXT(Input_corp_ra_title_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_title_desc = (TYPEOF(le.Input_corp_ra_title_desc))'','',':corp_ra_title_desc')
    #END
 
+    #IF( #TEXT(Input_corp_ra_fein)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_fein = (TYPEOF(le.Input_corp_ra_fein))'','',':corp_ra_fein')
    #END
 
+    #IF( #TEXT(Input_corp_ra_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_ssn = (TYPEOF(le.Input_corp_ra_ssn))'','',':corp_ra_ssn')
    #END
 
+    #IF( #TEXT(Input_corp_ra_dob)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_dob = (TYPEOF(le.Input_corp_ra_dob))'','',':corp_ra_dob')
    #END
 
+    #IF( #TEXT(Input_corp_ra_effective_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_effective_date = (TYPEOF(le.Input_corp_ra_effective_date))'','',':corp_ra_effective_date')
    #END
 
+    #IF( #TEXT(Input_corp_ra_resign_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_resign_date = (TYPEOF(le.Input_corp_ra_resign_date))'','',':corp_ra_resign_date')
    #END
 
+    #IF( #TEXT(Input_corp_ra_no_comp)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_no_comp = (TYPEOF(le.Input_corp_ra_no_comp))'','',':corp_ra_no_comp')
    #END
 
+    #IF( #TEXT(Input_corp_ra_no_comp_igs)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_no_comp_igs = (TYPEOF(le.Input_corp_ra_no_comp_igs))'','',':corp_ra_no_comp_igs')
    #END
 
+    #IF( #TEXT(Input_corp_ra_addl_info)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_addl_info = (TYPEOF(le.Input_corp_ra_addl_info))'','',':corp_ra_addl_info')
    #END
 
+    #IF( #TEXT(Input_corp_ra_address_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_address_type_cd = (TYPEOF(le.Input_corp_ra_address_type_cd))'','',':corp_ra_address_type_cd')
    #END
 
+    #IF( #TEXT(Input_corp_ra_address_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_address_type_desc = (TYPEOF(le.Input_corp_ra_address_type_desc))'','',':corp_ra_address_type_desc')
    #END
 
+    #IF( #TEXT(Input_corp_ra_address_line1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_address_line1 = (TYPEOF(le.Input_corp_ra_address_line1))'','',':corp_ra_address_line1')
    #END
 
+    #IF( #TEXT(Input_corp_ra_address_line2)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_address_line2 = (TYPEOF(le.Input_corp_ra_address_line2))'','',':corp_ra_address_line2')
    #END
 
+    #IF( #TEXT(Input_corp_ra_address_line3)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_address_line3 = (TYPEOF(le.Input_corp_ra_address_line3))'','',':corp_ra_address_line3')
    #END
 
+    #IF( #TEXT(Input_corp_ra_address_line4)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_address_line4 = (TYPEOF(le.Input_corp_ra_address_line4))'','',':corp_ra_address_line4')
    #END
 
+    #IF( #TEXT(Input_corp_ra_address_line5)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_address_line5 = (TYPEOF(le.Input_corp_ra_address_line5))'','',':corp_ra_address_line5')
    #END
 
+    #IF( #TEXT(Input_corp_ra_address_line6)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_address_line6 = (TYPEOF(le.Input_corp_ra_address_line6))'','',':corp_ra_address_line6')
    #END
 
+    #IF( #TEXT(Input_corp_ra_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_phone_number = (TYPEOF(le.Input_corp_ra_phone_number))'','',':corp_ra_phone_number')
    #END
 
+    #IF( #TEXT(Input_corp_ra_phone_number_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_phone_number_type_cd = (TYPEOF(le.Input_corp_ra_phone_number_type_cd))'','',':corp_ra_phone_number_type_cd')
    #END
 
+    #IF( #TEXT(Input_corp_ra_phone_number_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_phone_number_type_desc = (TYPEOF(le.Input_corp_ra_phone_number_type_desc))'','',':corp_ra_phone_number_type_desc')
    #END
 
+    #IF( #TEXT(Input_corp_ra_fax_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_fax_nbr = (TYPEOF(le.Input_corp_ra_fax_nbr))'','',':corp_ra_fax_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_ra_email_address)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_email_address = (TYPEOF(le.Input_corp_ra_email_address))'','',':corp_ra_email_address')
    #END
 
+    #IF( #TEXT(Input_corp_ra_web_address)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_web_address = (TYPEOF(le.Input_corp_ra_web_address))'','',':corp_ra_web_address')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_prim_range = (TYPEOF(le.Input_corp_addr1_prim_range))'','',':corp_addr1_prim_range')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_predir)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_predir = (TYPEOF(le.Input_corp_addr1_predir))'','',':corp_addr1_predir')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_prim_name = (TYPEOF(le.Input_corp_addr1_prim_name))'','',':corp_addr1_prim_name')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_addr_suffix = (TYPEOF(le.Input_corp_addr1_addr_suffix))'','',':corp_addr1_addr_suffix')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_postdir = (TYPEOF(le.Input_corp_addr1_postdir))'','',':corp_addr1_postdir')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_unit_desig = (TYPEOF(le.Input_corp_addr1_unit_desig))'','',':corp_addr1_unit_desig')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_sec_range = (TYPEOF(le.Input_corp_addr1_sec_range))'','',':corp_addr1_sec_range')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_p_city_name = (TYPEOF(le.Input_corp_addr1_p_city_name))'','',':corp_addr1_p_city_name')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_v_city_name = (TYPEOF(le.Input_corp_addr1_v_city_name))'','',':corp_addr1_v_city_name')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_state)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_state = (TYPEOF(le.Input_corp_addr1_state))'','',':corp_addr1_state')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_zip5 = (TYPEOF(le.Input_corp_addr1_zip5))'','',':corp_addr1_zip5')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_zip4 = (TYPEOF(le.Input_corp_addr1_zip4))'','',':corp_addr1_zip4')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_cart)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_cart = (TYPEOF(le.Input_corp_addr1_cart))'','',':corp_addr1_cart')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_cr_sort_sz = (TYPEOF(le.Input_corp_addr1_cr_sort_sz))'','',':corp_addr1_cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_lot)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_lot = (TYPEOF(le.Input_corp_addr1_lot))'','',':corp_addr1_lot')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_lot_order = (TYPEOF(le.Input_corp_addr1_lot_order))'','',':corp_addr1_lot_order')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_dpbc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_dpbc = (TYPEOF(le.Input_corp_addr1_dpbc))'','',':corp_addr1_dpbc')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_chk_digit = (TYPEOF(le.Input_corp_addr1_chk_digit))'','',':corp_addr1_chk_digit')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_rec_type = (TYPEOF(le.Input_corp_addr1_rec_type))'','',':corp_addr1_rec_type')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_ace_fips_st = (TYPEOF(le.Input_corp_addr1_ace_fips_st))'','',':corp_addr1_ace_fips_st')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_county)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_county = (TYPEOF(le.Input_corp_addr1_county))'','',':corp_addr1_county')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_geo_lat = (TYPEOF(le.Input_corp_addr1_geo_lat))'','',':corp_addr1_geo_lat')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_geo_long = (TYPEOF(le.Input_corp_addr1_geo_long))'','',':corp_addr1_geo_long')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_msa)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_msa = (TYPEOF(le.Input_corp_addr1_msa))'','',':corp_addr1_msa')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_geo_blk = (TYPEOF(le.Input_corp_addr1_geo_blk))'','',':corp_addr1_geo_blk')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_geo_match = (TYPEOF(le.Input_corp_addr1_geo_match))'','',':corp_addr1_geo_match')
    #END
 
+    #IF( #TEXT(Input_corp_addr1_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr1_err_stat = (TYPEOF(le.Input_corp_addr1_err_stat))'','',':corp_addr1_err_stat')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_prim_range = (TYPEOF(le.Input_corp_addr2_prim_range))'','',':corp_addr2_prim_range')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_predir)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_predir = (TYPEOF(le.Input_corp_addr2_predir))'','',':corp_addr2_predir')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_prim_name = (TYPEOF(le.Input_corp_addr2_prim_name))'','',':corp_addr2_prim_name')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_addr_suffix = (TYPEOF(le.Input_corp_addr2_addr_suffix))'','',':corp_addr2_addr_suffix')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_postdir = (TYPEOF(le.Input_corp_addr2_postdir))'','',':corp_addr2_postdir')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_unit_desig = (TYPEOF(le.Input_corp_addr2_unit_desig))'','',':corp_addr2_unit_desig')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_sec_range = (TYPEOF(le.Input_corp_addr2_sec_range))'','',':corp_addr2_sec_range')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_p_city_name = (TYPEOF(le.Input_corp_addr2_p_city_name))'','',':corp_addr2_p_city_name')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_v_city_name = (TYPEOF(le.Input_corp_addr2_v_city_name))'','',':corp_addr2_v_city_name')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_state)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_state = (TYPEOF(le.Input_corp_addr2_state))'','',':corp_addr2_state')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_zip5 = (TYPEOF(le.Input_corp_addr2_zip5))'','',':corp_addr2_zip5')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_zip4 = (TYPEOF(le.Input_corp_addr2_zip4))'','',':corp_addr2_zip4')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_cart)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_cart = (TYPEOF(le.Input_corp_addr2_cart))'','',':corp_addr2_cart')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_cr_sort_sz = (TYPEOF(le.Input_corp_addr2_cr_sort_sz))'','',':corp_addr2_cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_lot)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_lot = (TYPEOF(le.Input_corp_addr2_lot))'','',':corp_addr2_lot')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_lot_order = (TYPEOF(le.Input_corp_addr2_lot_order))'','',':corp_addr2_lot_order')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_dpbc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_dpbc = (TYPEOF(le.Input_corp_addr2_dpbc))'','',':corp_addr2_dpbc')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_chk_digit = (TYPEOF(le.Input_corp_addr2_chk_digit))'','',':corp_addr2_chk_digit')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_rec_type = (TYPEOF(le.Input_corp_addr2_rec_type))'','',':corp_addr2_rec_type')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_ace_fips_st = (TYPEOF(le.Input_corp_addr2_ace_fips_st))'','',':corp_addr2_ace_fips_st')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_county)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_county = (TYPEOF(le.Input_corp_addr2_county))'','',':corp_addr2_county')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_geo_lat = (TYPEOF(le.Input_corp_addr2_geo_lat))'','',':corp_addr2_geo_lat')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_geo_long = (TYPEOF(le.Input_corp_addr2_geo_long))'','',':corp_addr2_geo_long')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_msa)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_msa = (TYPEOF(le.Input_corp_addr2_msa))'','',':corp_addr2_msa')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_geo_blk = (TYPEOF(le.Input_corp_addr2_geo_blk))'','',':corp_addr2_geo_blk')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_geo_match = (TYPEOF(le.Input_corp_addr2_geo_match))'','',':corp_addr2_geo_match')
    #END
 
+    #IF( #TEXT(Input_corp_addr2_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_corp_addr2_err_stat = (TYPEOF(le.Input_corp_addr2_err_stat))'','',':corp_addr2_err_stat')
    #END
 
+    #IF( #TEXT(Input_corp_ra_title1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_title1 = (TYPEOF(le.Input_corp_ra_title1))'','',':corp_ra_title1')
    #END
 
+    #IF( #TEXT(Input_corp_ra_fname1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_fname1 = (TYPEOF(le.Input_corp_ra_fname1))'','',':corp_ra_fname1')
    #END
 
+    #IF( #TEXT(Input_corp_ra_mname1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_mname1 = (TYPEOF(le.Input_corp_ra_mname1))'','',':corp_ra_mname1')
    #END
 
+    #IF( #TEXT(Input_corp_ra_lname1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_lname1 = (TYPEOF(le.Input_corp_ra_lname1))'','',':corp_ra_lname1')
    #END
 
+    #IF( #TEXT(Input_corp_ra_name_suffix1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_name_suffix1 = (TYPEOF(le.Input_corp_ra_name_suffix1))'','',':corp_ra_name_suffix1')
    #END
 
+    #IF( #TEXT(Input_corp_ra_score1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_score1 = (TYPEOF(le.Input_corp_ra_score1))'','',':corp_ra_score1')
    #END
 
+    #IF( #TEXT(Input_corp_ra_title2)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_title2 = (TYPEOF(le.Input_corp_ra_title2))'','',':corp_ra_title2')
    #END
 
+    #IF( #TEXT(Input_corp_ra_fname2)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_fname2 = (TYPEOF(le.Input_corp_ra_fname2))'','',':corp_ra_fname2')
    #END
 
+    #IF( #TEXT(Input_corp_ra_mname2)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_mname2 = (TYPEOF(le.Input_corp_ra_mname2))'','',':corp_ra_mname2')
    #END
 
+    #IF( #TEXT(Input_corp_ra_lname2)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_lname2 = (TYPEOF(le.Input_corp_ra_lname2))'','',':corp_ra_lname2')
    #END
 
+    #IF( #TEXT(Input_corp_ra_name_suffix2)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_name_suffix2 = (TYPEOF(le.Input_corp_ra_name_suffix2))'','',':corp_ra_name_suffix2')
    #END
 
+    #IF( #TEXT(Input_corp_ra_score2)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_score2 = (TYPEOF(le.Input_corp_ra_score2))'','',':corp_ra_score2')
    #END
 
+    #IF( #TEXT(Input_corp_ra_cname1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_cname1 = (TYPEOF(le.Input_corp_ra_cname1))'','',':corp_ra_cname1')
    #END
 
+    #IF( #TEXT(Input_corp_ra_cname1_score)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_cname1_score = (TYPEOF(le.Input_corp_ra_cname1_score))'','',':corp_ra_cname1_score')
    #END
 
+    #IF( #TEXT(Input_corp_ra_cname2)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_cname2 = (TYPEOF(le.Input_corp_ra_cname2))'','',':corp_ra_cname2')
    #END
 
+    #IF( #TEXT(Input_corp_ra_cname2_score)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_cname2_score = (TYPEOF(le.Input_corp_ra_cname2_score))'','',':corp_ra_cname2_score')
    #END
 
+    #IF( #TEXT(Input_corp_ra_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_prim_range = (TYPEOF(le.Input_corp_ra_prim_range))'','',':corp_ra_prim_range')
    #END
 
+    #IF( #TEXT(Input_corp_ra_predir)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_predir = (TYPEOF(le.Input_corp_ra_predir))'','',':corp_ra_predir')
    #END
 
+    #IF( #TEXT(Input_corp_ra_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_prim_name = (TYPEOF(le.Input_corp_ra_prim_name))'','',':corp_ra_prim_name')
    #END
 
+    #IF( #TEXT(Input_corp_ra_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_addr_suffix = (TYPEOF(le.Input_corp_ra_addr_suffix))'','',':corp_ra_addr_suffix')
    #END
 
+    #IF( #TEXT(Input_corp_ra_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_postdir = (TYPEOF(le.Input_corp_ra_postdir))'','',':corp_ra_postdir')
    #END
 
+    #IF( #TEXT(Input_corp_ra_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_unit_desig = (TYPEOF(le.Input_corp_ra_unit_desig))'','',':corp_ra_unit_desig')
    #END
 
+    #IF( #TEXT(Input_corp_ra_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_sec_range = (TYPEOF(le.Input_corp_ra_sec_range))'','',':corp_ra_sec_range')
    #END
 
+    #IF( #TEXT(Input_corp_ra_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_p_city_name = (TYPEOF(le.Input_corp_ra_p_city_name))'','',':corp_ra_p_city_name')
    #END
 
+    #IF( #TEXT(Input_corp_ra_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_v_city_name = (TYPEOF(le.Input_corp_ra_v_city_name))'','',':corp_ra_v_city_name')
    #END
 
+    #IF( #TEXT(Input_corp_ra_state)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_state = (TYPEOF(le.Input_corp_ra_state))'','',':corp_ra_state')
    #END
 
+    #IF( #TEXT(Input_corp_ra_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_zip5 = (TYPEOF(le.Input_corp_ra_zip5))'','',':corp_ra_zip5')
    #END
 
+    #IF( #TEXT(Input_corp_ra_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_zip4 = (TYPEOF(le.Input_corp_ra_zip4))'','',':corp_ra_zip4')
    #END
 
+    #IF( #TEXT(Input_corp_ra_cart)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_cart = (TYPEOF(le.Input_corp_ra_cart))'','',':corp_ra_cart')
    #END
 
+    #IF( #TEXT(Input_corp_ra_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_cr_sort_sz = (TYPEOF(le.Input_corp_ra_cr_sort_sz))'','',':corp_ra_cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_corp_ra_lot)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_lot = (TYPEOF(le.Input_corp_ra_lot))'','',':corp_ra_lot')
    #END
 
+    #IF( #TEXT(Input_corp_ra_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_lot_order = (TYPEOF(le.Input_corp_ra_lot_order))'','',':corp_ra_lot_order')
    #END
 
+    #IF( #TEXT(Input_corp_ra_dpbc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_dpbc = (TYPEOF(le.Input_corp_ra_dpbc))'','',':corp_ra_dpbc')
    #END
 
+    #IF( #TEXT(Input_corp_ra_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_chk_digit = (TYPEOF(le.Input_corp_ra_chk_digit))'','',':corp_ra_chk_digit')
    #END
 
+    #IF( #TEXT(Input_corp_ra_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_rec_type = (TYPEOF(le.Input_corp_ra_rec_type))'','',':corp_ra_rec_type')
    #END
 
+    #IF( #TEXT(Input_corp_ra_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_ace_fips_st = (TYPEOF(le.Input_corp_ra_ace_fips_st))'','',':corp_ra_ace_fips_st')
    #END
 
+    #IF( #TEXT(Input_corp_ra_county)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_county = (TYPEOF(le.Input_corp_ra_county))'','',':corp_ra_county')
    #END
 
+    #IF( #TEXT(Input_corp_ra_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_geo_lat = (TYPEOF(le.Input_corp_ra_geo_lat))'','',':corp_ra_geo_lat')
    #END
 
+    #IF( #TEXT(Input_corp_ra_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_geo_long = (TYPEOF(le.Input_corp_ra_geo_long))'','',':corp_ra_geo_long')
    #END
 
+    #IF( #TEXT(Input_corp_ra_msa)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_msa = (TYPEOF(le.Input_corp_ra_msa))'','',':corp_ra_msa')
    #END
 
+    #IF( #TEXT(Input_corp_ra_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_geo_blk = (TYPEOF(le.Input_corp_ra_geo_blk))'','',':corp_ra_geo_blk')
    #END
 
+    #IF( #TEXT(Input_corp_ra_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_geo_match = (TYPEOF(le.Input_corp_ra_geo_match))'','',':corp_ra_geo_match')
    #END
 
+    #IF( #TEXT(Input_corp_ra_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_err_stat = (TYPEOF(le.Input_corp_ra_err_stat))'','',':corp_ra_err_stat')
    #END
 
+    #IF( #TEXT(Input_corp_phone10)='' )
      '' 
    #ELSE
        IF( le.Input_corp_phone10 = (TYPEOF(le.Input_corp_phone10))'','',':corp_phone10')
    #END
 
+    #IF( #TEXT(Input_corp_ra_phone10)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ra_phone10 = (TYPEOF(le.Input_corp_ra_phone10))'','',':corp_ra_phone10')
    #END
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_append_addr1_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_append_addr1_rawaid = (TYPEOF(le.Input_append_addr1_rawaid))'','',':append_addr1_rawaid')
    #END
 
+    #IF( #TEXT(Input_append_addr1_aceaid)='' )
      '' 
    #ELSE
        IF( le.Input_append_addr1_aceaid = (TYPEOF(le.Input_append_addr1_aceaid))'','',':append_addr1_aceaid')
    #END
 
+    #IF( #TEXT(Input_corp_prep_addr1_line1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_prep_addr1_line1 = (TYPEOF(le.Input_corp_prep_addr1_line1))'','',':corp_prep_addr1_line1')
    #END
 
+    #IF( #TEXT(Input_corp_prep_addr1_last_line)='' )
      '' 
    #ELSE
        IF( le.Input_corp_prep_addr1_last_line = (TYPEOF(le.Input_corp_prep_addr1_last_line))'','',':corp_prep_addr1_last_line')
    #END
 
+    #IF( #TEXT(Input_append_addr2_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_append_addr2_rawaid = (TYPEOF(le.Input_append_addr2_rawaid))'','',':append_addr2_rawaid')
    #END
 
+    #IF( #TEXT(Input_append_addr2_aceaid)='' )
      '' 
    #ELSE
        IF( le.Input_append_addr2_aceaid = (TYPEOF(le.Input_append_addr2_aceaid))'','',':append_addr2_aceaid')
    #END
 
+    #IF( #TEXT(Input_corp_prep_addr2_line1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_prep_addr2_line1 = (TYPEOF(le.Input_corp_prep_addr2_line1))'','',':corp_prep_addr2_line1')
    #END
 
+    #IF( #TEXT(Input_corp_prep_addr2_last_line)='' )
      '' 
    #ELSE
        IF( le.Input_corp_prep_addr2_last_line = (TYPEOF(le.Input_corp_prep_addr2_last_line))'','',':corp_prep_addr2_last_line')
    #END
 
+    #IF( #TEXT(Input_append_ra_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_append_ra_rawaid = (TYPEOF(le.Input_append_ra_rawaid))'','',':append_ra_rawaid')
    #END
 
+    #IF( #TEXT(Input_append_ra_aceaid)='' )
      '' 
    #ELSE
        IF( le.Input_append_ra_aceaid = (TYPEOF(le.Input_append_ra_aceaid))'','',':append_ra_aceaid')
    #END
 
+    #IF( #TEXT(Input_ra_prep_addr_line1)='' )
      '' 
    #ELSE
        IF( le.Input_ra_prep_addr_line1 = (TYPEOF(le.Input_ra_prep_addr_line1))'','',':ra_prep_addr_line1')
    #END
 
+    #IF( #TEXT(Input_ra_prep_addr_last_line)='' )
      '' 
    #ELSE
        IF( le.Input_ra_prep_addr_last_line = (TYPEOF(le.Input_ra_prep_addr_last_line))'','',':ra_prep_addr_last_line')
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
