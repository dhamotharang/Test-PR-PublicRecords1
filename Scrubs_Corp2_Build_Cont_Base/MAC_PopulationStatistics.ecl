 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_bdid = '',Input_did = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_corp_key = '',Input_corp_supp_key = '',Input_corp_vendor = '',Input_corp_vendor_county = '',Input_corp_vendor_subcode = '',Input_corp_state_origin = '',Input_corp_process_date = '',Input_corp_orig_sos_charter_nbr = '',Input_corp_sos_charter_nbr = '',Input_corp_legal_name = '',Input_corp_address1_type_cd = '',Input_corp_address1_type_desc = '',Input_corp_address1_line1 = '',Input_corp_address1_line2 = '',Input_corp_address1_line3 = '',Input_corp_address1_line4 = '',Input_corp_address1_line5 = '',Input_corp_address1_line6 = '',Input_corp_address1_effective_date = '',Input_corp_phone_number = '',Input_corp_phone_number_type_cd = '',Input_corp_phone_number_type_desc = '',Input_corp_fax_nbr = '',Input_corp_email_address = '',Input_corp_web_address = '',Input_cont_filing_reference_nbr = '',Input_cont_filing_date = '',Input_cont_filing_cd = '',Input_cont_filing_desc = '',Input_cont_type_cd = '',Input_cont_type_desc = '',Input_cont_name = '',Input_cont_title_desc = '',Input_cont_sos_charter_nbr = '',Input_cont_fein = '',Input_cont_ssn = '',Input_cont_dob = '',Input_cont_status_cd = '',Input_cont_status_desc = '',Input_cont_effective_date = '',Input_cont_effective_cd = '',Input_cont_effective_desc = '',Input_cont_addl_info = '',Input_cont_address_type_cd = '',Input_cont_address_type_desc = '',Input_cont_address_line1 = '',Input_cont_address_line2 = '',Input_cont_address_line3 = '',Input_cont_address_line4 = '',Input_cont_address_line5 = '',Input_cont_address_line6 = '',Input_cont_address_effective_date = '',Input_cont_address_county = '',Input_cont_phone_number = '',Input_cont_phone_number_type_cd = '',Input_cont_phone_number_type_desc = '',Input_cont_fax_nbr = '',Input_cont_email_address = '',Input_cont_web_address = '',Input_corp_addr1_prim_range = '',Input_corp_addr1_predir = '',Input_corp_addr1_prim_name = '',Input_corp_addr1_addr_suffix = '',Input_corp_addr1_postdir = '',Input_corp_addr1_unit_desig = '',Input_corp_addr1_sec_range = '',Input_corp_addr1_p_city_name = '',Input_corp_addr1_v_city_name = '',Input_corp_addr1_state = '',Input_corp_addr1_zip5 = '',Input_corp_addr1_zip4 = '',Input_corp_addr1_cart = '',Input_corp_addr1_cr_sort_sz = '',Input_corp_addr1_lot = '',Input_corp_addr1_lot_order = '',Input_corp_addr1_dpbc = '',Input_corp_addr1_chk_digit = '',Input_corp_addr1_rec_type = '',Input_corp_addr1_ace_fips_st = '',Input_corp_addr1_county = '',Input_corp_addr1_geo_lat = '',Input_corp_addr1_geo_long = '',Input_corp_addr1_msa = '',Input_corp_addr1_geo_blk = '',Input_corp_addr1_geo_match = '',Input_corp_addr1_err_stat = '',Input_cont_title = '',Input_cont_fname = '',Input_cont_mname = '',Input_cont_lname = '',Input_cont_name_suffix = '',Input_cont_score = '',Input_cont_cname = '',Input_cont_cname_score = '',Input_cont_prim_range = '',Input_cont_predir = '',Input_cont_prim_name = '',Input_cont_addr_suffix = '',Input_cont_postdir = '',Input_cont_unit_desig = '',Input_cont_sec_range = '',Input_cont_p_city_name = '',Input_cont_v_city_name = '',Input_cont_state = '',Input_cont_zip5 = '',Input_cont_zip4 = '',Input_cont_cart = '',Input_cont_cr_sort_sz = '',Input_cont_lot = '',Input_cont_lot_order = '',Input_cont_dpbc = '',Input_cont_chk_digit = '',Input_cont_rec_type = '',Input_cont_ace_fips_st = '',Input_cont_county = '',Input_cont_geo_lat = '',Input_cont_geo_long = '',Input_cont_msa = '',Input_cont_geo_blk = '',Input_cont_geo_match = '',Input_cont_err_stat = '',Input_corp_phone10 = '',Input_cont_phone10 = '',Input_record_type = '',Input_append_corp_addr_rawaid = '',Input_append_corp_addr_aceaid = '',Input_corp_prep_addr_line1 = '',Input_corp_prep_addr_last_line = '',Input_append_cont_addr_rawaid = '',Input_append_cont_addr_aceaid = '',Input_cont_prep_addr_line1 = '',Input_cont_prep_addr_last_line = '',Input_dotid = '',Input_dotscore = '',Input_dotweight = '',Input_empid = '',Input_empscore = '',Input_empweight = '',Input_powid = '',Input_powscore = '',Input_powweight = '',Input_proxid = '',Input_proxscore = '',Input_proxweight = '',Input_seleid = '',Input_selescore = '',Input_seleweight = '',Input_orgid = '',Input_orgscore = '',Input_orgweight = '',Input_ultid = '',Input_ultscore = '',Input_ultweight = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_Corp2_Build_Cont_Base;
  #uniquename(of)
  %of% := RECORD
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_bdid)='' )
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
 
+    #IF( #TEXT(Input_corp_legal_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_legal_name = (TYPEOF(le.Input_corp_legal_name))'','',':corp_legal_name')
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
 
+    #IF( #TEXT(Input_cont_filing_reference_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_cont_filing_reference_nbr = (TYPEOF(le.Input_cont_filing_reference_nbr))'','',':cont_filing_reference_nbr')
    #END
 
+    #IF( #TEXT(Input_cont_filing_date)='' )
      '' 
    #ELSE
        IF( le.Input_cont_filing_date = (TYPEOF(le.Input_cont_filing_date))'','',':cont_filing_date')
    #END
 
+    #IF( #TEXT(Input_cont_filing_cd)='' )
      '' 
    #ELSE
        IF( le.Input_cont_filing_cd = (TYPEOF(le.Input_cont_filing_cd))'','',':cont_filing_cd')
    #END
 
+    #IF( #TEXT(Input_cont_filing_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_filing_desc = (TYPEOF(le.Input_cont_filing_desc))'','',':cont_filing_desc')
    #END
 
+    #IF( #TEXT(Input_cont_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_cont_type_cd = (TYPEOF(le.Input_cont_type_cd))'','',':cont_type_cd')
    #END
 
+    #IF( #TEXT(Input_cont_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_type_desc = (TYPEOF(le.Input_cont_type_desc))'','',':cont_type_desc')
    #END
 
+    #IF( #TEXT(Input_cont_name)='' )
      '' 
    #ELSE
        IF( le.Input_cont_name = (TYPEOF(le.Input_cont_name))'','',':cont_name')
    #END
 
+    #IF( #TEXT(Input_cont_title_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_title_desc = (TYPEOF(le.Input_cont_title_desc))'','',':cont_title_desc')
    #END
 
+    #IF( #TEXT(Input_cont_sos_charter_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_cont_sos_charter_nbr = (TYPEOF(le.Input_cont_sos_charter_nbr))'','',':cont_sos_charter_nbr')
    #END
 
+    #IF( #TEXT(Input_cont_fein)='' )
      '' 
    #ELSE
        IF( le.Input_cont_fein = (TYPEOF(le.Input_cont_fein))'','',':cont_fein')
    #END
 
+    #IF( #TEXT(Input_cont_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_cont_ssn = (TYPEOF(le.Input_cont_ssn))'','',':cont_ssn')
    #END
 
+    #IF( #TEXT(Input_cont_dob)='' )
      '' 
    #ELSE
        IF( le.Input_cont_dob = (TYPEOF(le.Input_cont_dob))'','',':cont_dob')
    #END
 
+    #IF( #TEXT(Input_cont_status_cd)='' )
      '' 
    #ELSE
        IF( le.Input_cont_status_cd = (TYPEOF(le.Input_cont_status_cd))'','',':cont_status_cd')
    #END
 
+    #IF( #TEXT(Input_cont_status_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_status_desc = (TYPEOF(le.Input_cont_status_desc))'','',':cont_status_desc')
    #END
 
+    #IF( #TEXT(Input_cont_effective_date)='' )
      '' 
    #ELSE
        IF( le.Input_cont_effective_date = (TYPEOF(le.Input_cont_effective_date))'','',':cont_effective_date')
    #END
 
+    #IF( #TEXT(Input_cont_effective_cd)='' )
      '' 
    #ELSE
        IF( le.Input_cont_effective_cd = (TYPEOF(le.Input_cont_effective_cd))'','',':cont_effective_cd')
    #END
 
+    #IF( #TEXT(Input_cont_effective_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_effective_desc = (TYPEOF(le.Input_cont_effective_desc))'','',':cont_effective_desc')
    #END
 
+    #IF( #TEXT(Input_cont_addl_info)='' )
      '' 
    #ELSE
        IF( le.Input_cont_addl_info = (TYPEOF(le.Input_cont_addl_info))'','',':cont_addl_info')
    #END
 
+    #IF( #TEXT(Input_cont_address_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_cont_address_type_cd = (TYPEOF(le.Input_cont_address_type_cd))'','',':cont_address_type_cd')
    #END
 
+    #IF( #TEXT(Input_cont_address_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_address_type_desc = (TYPEOF(le.Input_cont_address_type_desc))'','',':cont_address_type_desc')
    #END
 
+    #IF( #TEXT(Input_cont_address_line1)='' )
      '' 
    #ELSE
        IF( le.Input_cont_address_line1 = (TYPEOF(le.Input_cont_address_line1))'','',':cont_address_line1')
    #END
 
+    #IF( #TEXT(Input_cont_address_line2)='' )
      '' 
    #ELSE
        IF( le.Input_cont_address_line2 = (TYPEOF(le.Input_cont_address_line2))'','',':cont_address_line2')
    #END
 
+    #IF( #TEXT(Input_cont_address_line3)='' )
      '' 
    #ELSE
        IF( le.Input_cont_address_line3 = (TYPEOF(le.Input_cont_address_line3))'','',':cont_address_line3')
    #END
 
+    #IF( #TEXT(Input_cont_address_line4)='' )
      '' 
    #ELSE
        IF( le.Input_cont_address_line4 = (TYPEOF(le.Input_cont_address_line4))'','',':cont_address_line4')
    #END
 
+    #IF( #TEXT(Input_cont_address_line5)='' )
      '' 
    #ELSE
        IF( le.Input_cont_address_line5 = (TYPEOF(le.Input_cont_address_line5))'','',':cont_address_line5')
    #END
 
+    #IF( #TEXT(Input_cont_address_line6)='' )
      '' 
    #ELSE
        IF( le.Input_cont_address_line6 = (TYPEOF(le.Input_cont_address_line6))'','',':cont_address_line6')
    #END
 
+    #IF( #TEXT(Input_cont_address_effective_date)='' )
      '' 
    #ELSE
        IF( le.Input_cont_address_effective_date = (TYPEOF(le.Input_cont_address_effective_date))'','',':cont_address_effective_date')
    #END
 
+    #IF( #TEXT(Input_cont_address_county)='' )
      '' 
    #ELSE
        IF( le.Input_cont_address_county = (TYPEOF(le.Input_cont_address_county))'','',':cont_address_county')
    #END
 
+    #IF( #TEXT(Input_cont_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_cont_phone_number = (TYPEOF(le.Input_cont_phone_number))'','',':cont_phone_number')
    #END
 
+    #IF( #TEXT(Input_cont_phone_number_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_cont_phone_number_type_cd = (TYPEOF(le.Input_cont_phone_number_type_cd))'','',':cont_phone_number_type_cd')
    #END
 
+    #IF( #TEXT(Input_cont_phone_number_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_phone_number_type_desc = (TYPEOF(le.Input_cont_phone_number_type_desc))'','',':cont_phone_number_type_desc')
    #END
 
+    #IF( #TEXT(Input_cont_fax_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_cont_fax_nbr = (TYPEOF(le.Input_cont_fax_nbr))'','',':cont_fax_nbr')
    #END
 
+    #IF( #TEXT(Input_cont_email_address)='' )
      '' 
    #ELSE
        IF( le.Input_cont_email_address = (TYPEOF(le.Input_cont_email_address))'','',':cont_email_address')
    #END
 
+    #IF( #TEXT(Input_cont_web_address)='' )
      '' 
    #ELSE
        IF( le.Input_cont_web_address = (TYPEOF(le.Input_cont_web_address))'','',':cont_web_address')
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
 
+    #IF( #TEXT(Input_cont_title)='' )
      '' 
    #ELSE
        IF( le.Input_cont_title = (TYPEOF(le.Input_cont_title))'','',':cont_title')
    #END
 
+    #IF( #TEXT(Input_cont_fname)='' )
      '' 
    #ELSE
        IF( le.Input_cont_fname = (TYPEOF(le.Input_cont_fname))'','',':cont_fname')
    #END
 
+    #IF( #TEXT(Input_cont_mname)='' )
      '' 
    #ELSE
        IF( le.Input_cont_mname = (TYPEOF(le.Input_cont_mname))'','',':cont_mname')
    #END
 
+    #IF( #TEXT(Input_cont_lname)='' )
      '' 
    #ELSE
        IF( le.Input_cont_lname = (TYPEOF(le.Input_cont_lname))'','',':cont_lname')
    #END
 
+    #IF( #TEXT(Input_cont_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_cont_name_suffix = (TYPEOF(le.Input_cont_name_suffix))'','',':cont_name_suffix')
    #END
 
+    #IF( #TEXT(Input_cont_score)='' )
      '' 
    #ELSE
        IF( le.Input_cont_score = (TYPEOF(le.Input_cont_score))'','',':cont_score')
    #END
 
+    #IF( #TEXT(Input_cont_cname)='' )
      '' 
    #ELSE
        IF( le.Input_cont_cname = (TYPEOF(le.Input_cont_cname))'','',':cont_cname')
    #END
 
+    #IF( #TEXT(Input_cont_cname_score)='' )
      '' 
    #ELSE
        IF( le.Input_cont_cname_score = (TYPEOF(le.Input_cont_cname_score))'','',':cont_cname_score')
    #END
 
+    #IF( #TEXT(Input_cont_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_cont_prim_range = (TYPEOF(le.Input_cont_prim_range))'','',':cont_prim_range')
    #END
 
+    #IF( #TEXT(Input_cont_predir)='' )
      '' 
    #ELSE
        IF( le.Input_cont_predir = (TYPEOF(le.Input_cont_predir))'','',':cont_predir')
    #END
 
+    #IF( #TEXT(Input_cont_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_cont_prim_name = (TYPEOF(le.Input_cont_prim_name))'','',':cont_prim_name')
    #END
 
+    #IF( #TEXT(Input_cont_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_cont_addr_suffix = (TYPEOF(le.Input_cont_addr_suffix))'','',':cont_addr_suffix')
    #END
 
+    #IF( #TEXT(Input_cont_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_cont_postdir = (TYPEOF(le.Input_cont_postdir))'','',':cont_postdir')
    #END
 
+    #IF( #TEXT(Input_cont_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_cont_unit_desig = (TYPEOF(le.Input_cont_unit_desig))'','',':cont_unit_desig')
    #END
 
+    #IF( #TEXT(Input_cont_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_cont_sec_range = (TYPEOF(le.Input_cont_sec_range))'','',':cont_sec_range')
    #END
 
+    #IF( #TEXT(Input_cont_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_cont_p_city_name = (TYPEOF(le.Input_cont_p_city_name))'','',':cont_p_city_name')
    #END
 
+    #IF( #TEXT(Input_cont_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_cont_v_city_name = (TYPEOF(le.Input_cont_v_city_name))'','',':cont_v_city_name')
    #END
 
+    #IF( #TEXT(Input_cont_state)='' )
      '' 
    #ELSE
        IF( le.Input_cont_state = (TYPEOF(le.Input_cont_state))'','',':cont_state')
    #END
 
+    #IF( #TEXT(Input_cont_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_cont_zip5 = (TYPEOF(le.Input_cont_zip5))'','',':cont_zip5')
    #END
 
+    #IF( #TEXT(Input_cont_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_cont_zip4 = (TYPEOF(le.Input_cont_zip4))'','',':cont_zip4')
    #END
 
+    #IF( #TEXT(Input_cont_cart)='' )
      '' 
    #ELSE
        IF( le.Input_cont_cart = (TYPEOF(le.Input_cont_cart))'','',':cont_cart')
    #END
 
+    #IF( #TEXT(Input_cont_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_cont_cr_sort_sz = (TYPEOF(le.Input_cont_cr_sort_sz))'','',':cont_cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_cont_lot)='' )
      '' 
    #ELSE
        IF( le.Input_cont_lot = (TYPEOF(le.Input_cont_lot))'','',':cont_lot')
    #END
 
+    #IF( #TEXT(Input_cont_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_cont_lot_order = (TYPEOF(le.Input_cont_lot_order))'','',':cont_lot_order')
    #END
 
+    #IF( #TEXT(Input_cont_dpbc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_dpbc = (TYPEOF(le.Input_cont_dpbc))'','',':cont_dpbc')
    #END
 
+    #IF( #TEXT(Input_cont_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_cont_chk_digit = (TYPEOF(le.Input_cont_chk_digit))'','',':cont_chk_digit')
    #END
 
+    #IF( #TEXT(Input_cont_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_cont_rec_type = (TYPEOF(le.Input_cont_rec_type))'','',':cont_rec_type')
    #END
 
+    #IF( #TEXT(Input_cont_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_cont_ace_fips_st = (TYPEOF(le.Input_cont_ace_fips_st))'','',':cont_ace_fips_st')
    #END
 
+    #IF( #TEXT(Input_cont_county)='' )
      '' 
    #ELSE
        IF( le.Input_cont_county = (TYPEOF(le.Input_cont_county))'','',':cont_county')
    #END
 
+    #IF( #TEXT(Input_cont_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_cont_geo_lat = (TYPEOF(le.Input_cont_geo_lat))'','',':cont_geo_lat')
    #END
 
+    #IF( #TEXT(Input_cont_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_cont_geo_long = (TYPEOF(le.Input_cont_geo_long))'','',':cont_geo_long')
    #END
 
+    #IF( #TEXT(Input_cont_msa)='' )
      '' 
    #ELSE
        IF( le.Input_cont_msa = (TYPEOF(le.Input_cont_msa))'','',':cont_msa')
    #END
 
+    #IF( #TEXT(Input_cont_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_cont_geo_blk = (TYPEOF(le.Input_cont_geo_blk))'','',':cont_geo_blk')
    #END
 
+    #IF( #TEXT(Input_cont_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_cont_geo_match = (TYPEOF(le.Input_cont_geo_match))'','',':cont_geo_match')
    #END
 
+    #IF( #TEXT(Input_cont_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_cont_err_stat = (TYPEOF(le.Input_cont_err_stat))'','',':cont_err_stat')
    #END
 
+    #IF( #TEXT(Input_corp_phone10)='' )
      '' 
    #ELSE
        IF( le.Input_corp_phone10 = (TYPEOF(le.Input_corp_phone10))'','',':corp_phone10')
    #END
 
+    #IF( #TEXT(Input_cont_phone10)='' )
      '' 
    #ELSE
        IF( le.Input_cont_phone10 = (TYPEOF(le.Input_cont_phone10))'','',':cont_phone10')
    #END
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_append_corp_addr_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_append_corp_addr_rawaid = (TYPEOF(le.Input_append_corp_addr_rawaid))'','',':append_corp_addr_rawaid')
    #END
 
+    #IF( #TEXT(Input_append_corp_addr_aceaid)='' )
      '' 
    #ELSE
        IF( le.Input_append_corp_addr_aceaid = (TYPEOF(le.Input_append_corp_addr_aceaid))'','',':append_corp_addr_aceaid')
    #END
 
+    #IF( #TEXT(Input_corp_prep_addr_line1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_prep_addr_line1 = (TYPEOF(le.Input_corp_prep_addr_line1))'','',':corp_prep_addr_line1')
    #END
 
+    #IF( #TEXT(Input_corp_prep_addr_last_line)='' )
      '' 
    #ELSE
        IF( le.Input_corp_prep_addr_last_line = (TYPEOF(le.Input_corp_prep_addr_last_line))'','',':corp_prep_addr_last_line')
    #END
 
+    #IF( #TEXT(Input_append_cont_addr_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_append_cont_addr_rawaid = (TYPEOF(le.Input_append_cont_addr_rawaid))'','',':append_cont_addr_rawaid')
    #END
 
+    #IF( #TEXT(Input_append_cont_addr_aceaid)='' )
      '' 
    #ELSE
        IF( le.Input_append_cont_addr_aceaid = (TYPEOF(le.Input_append_cont_addr_aceaid))'','',':append_cont_addr_aceaid')
    #END
 
+    #IF( #TEXT(Input_cont_prep_addr_line1)='' )
      '' 
    #ELSE
        IF( le.Input_cont_prep_addr_line1 = (TYPEOF(le.Input_cont_prep_addr_line1))'','',':cont_prep_addr_line1')
    #END
 
+    #IF( #TEXT(Input_cont_prep_addr_last_line)='' )
      '' 
    #ELSE
        IF( le.Input_cont_prep_addr_last_line = (TYPEOF(le.Input_cont_prep_addr_last_line))'','',':cont_prep_addr_last_line')
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
