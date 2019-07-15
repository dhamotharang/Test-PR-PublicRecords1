 
EXPORT Document_MAC_PopulationStatistics(infile,Ref='',Input_process_date = '',Input_vendor = '',Input_state_origin = '',Input_county_name = '',Input_official_record_key = '',Input_fips_st = '',Input_fips_county = '',Input_batch_id = '',Input_doc_serial_num = '',Input_doc_instrument_or_clerk_filing_num = '',Input_doc_num_dummy_flag = '',Input_doc_filed_dt = '',Input_doc_record_dt = '',Input_doc_type_cd = '',Input_doc_type_desc = '',Input_doc_other_desc = '',Input_doc_page_count = '',Input_doc_names_count = '',Input_doc_status_cd = '',Input_doc_status_desc = '',Input_doc_amend_cd = '',Input_doc_amend_desc = '',Input_execution_dt = '',Input_consideration_amt = '',Input_assumption_amt = '',Input_certified_mail_fee = '',Input_service_charge = '',Input_trust_amt = '',Input_transfer_ = '',Input_mortgage = '',Input_intangible_tax_amt = '',Input_intangible_tax_penalty = '',Input_excise_tax_amt = '',Input_recording_fee = '',Input_documentary_stamps_fee = '',Input_doc_stamps_mtg_fee = '',Input_book_num = '',Input_page_num = '',Input_book_type_cd = '',Input_book_type_desc = '',Input_parcel_or_case_num = '',Input_formatted_parcel_num = '',Input_legal_desc_1 = '',Input_legal_desc_2 = '',Input_legal_desc_3 = '',Input_legal_desc_4 = '',Input_legal_desc_5 = '',Input_verified_flag = '',Input_address_1 = '',Input_address_2 = '',Input_address_3 = '',Input_address_4 = '',Input_prior_doc_file_num = '',Input_prior_doc_type_cd = '',Input_prior_doc_type_desc = '',Input_prior_book_num = '',Input_prior_page_num = '',Input_prior_book_type_cd = '',Input_prior_book_type_desc = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dpbc = '',Input_chk_digit = '',Input_rec_type = '',Input_ace_fips_st = '',Input_ace_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Official_Records;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_vendor)='' )
      '' 
    #ELSE
        IF( le.Input_vendor = (TYPEOF(le.Input_vendor))'','',':vendor')
    #END
 
+    #IF( #TEXT(Input_state_origin)='' )
      '' 
    #ELSE
        IF( le.Input_state_origin = (TYPEOF(le.Input_state_origin))'','',':state_origin')
    #END
 
+    #IF( #TEXT(Input_county_name)='' )
      '' 
    #ELSE
        IF( le.Input_county_name = (TYPEOF(le.Input_county_name))'','',':county_name')
    #END
 
+    #IF( #TEXT(Input_official_record_key)='' )
      '' 
    #ELSE
        IF( le.Input_official_record_key = (TYPEOF(le.Input_official_record_key))'','',':official_record_key')
    #END
 
+    #IF( #TEXT(Input_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_fips_st = (TYPEOF(le.Input_fips_st))'','',':fips_st')
    #END
 
+    #IF( #TEXT(Input_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_fips_county = (TYPEOF(le.Input_fips_county))'','',':fips_county')
    #END
 
+    #IF( #TEXT(Input_batch_id)='' )
      '' 
    #ELSE
        IF( le.Input_batch_id = (TYPEOF(le.Input_batch_id))'','',':batch_id')
    #END
 
+    #IF( #TEXT(Input_doc_serial_num)='' )
      '' 
    #ELSE
        IF( le.Input_doc_serial_num = (TYPEOF(le.Input_doc_serial_num))'','',':doc_serial_num')
    #END
 
+    #IF( #TEXT(Input_doc_instrument_or_clerk_filing_num)='' )
      '' 
    #ELSE
        IF( le.Input_doc_instrument_or_clerk_filing_num = (TYPEOF(le.Input_doc_instrument_or_clerk_filing_num))'','',':doc_instrument_or_clerk_filing_num')
    #END
 
+    #IF( #TEXT(Input_doc_num_dummy_flag)='' )
      '' 
    #ELSE
        IF( le.Input_doc_num_dummy_flag = (TYPEOF(le.Input_doc_num_dummy_flag))'','',':doc_num_dummy_flag')
    #END
 
+    #IF( #TEXT(Input_doc_filed_dt)='' )
      '' 
    #ELSE
        IF( le.Input_doc_filed_dt = (TYPEOF(le.Input_doc_filed_dt))'','',':doc_filed_dt')
    #END
 
+    #IF( #TEXT(Input_doc_record_dt)='' )
      '' 
    #ELSE
        IF( le.Input_doc_record_dt = (TYPEOF(le.Input_doc_record_dt))'','',':doc_record_dt')
    #END
 
+    #IF( #TEXT(Input_doc_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_doc_type_cd = (TYPEOF(le.Input_doc_type_cd))'','',':doc_type_cd')
    #END
 
+    #IF( #TEXT(Input_doc_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_doc_type_desc = (TYPEOF(le.Input_doc_type_desc))'','',':doc_type_desc')
    #END
 
+    #IF( #TEXT(Input_doc_other_desc)='' )
      '' 
    #ELSE
        IF( le.Input_doc_other_desc = (TYPEOF(le.Input_doc_other_desc))'','',':doc_other_desc')
    #END
 
+    #IF( #TEXT(Input_doc_page_count)='' )
      '' 
    #ELSE
        IF( le.Input_doc_page_count = (TYPEOF(le.Input_doc_page_count))'','',':doc_page_count')
    #END
 
+    #IF( #TEXT(Input_doc_names_count)='' )
      '' 
    #ELSE
        IF( le.Input_doc_names_count = (TYPEOF(le.Input_doc_names_count))'','',':doc_names_count')
    #END
 
+    #IF( #TEXT(Input_doc_status_cd)='' )
      '' 
    #ELSE
        IF( le.Input_doc_status_cd = (TYPEOF(le.Input_doc_status_cd))'','',':doc_status_cd')
    #END
 
+    #IF( #TEXT(Input_doc_status_desc)='' )
      '' 
    #ELSE
        IF( le.Input_doc_status_desc = (TYPEOF(le.Input_doc_status_desc))'','',':doc_status_desc')
    #END
 
+    #IF( #TEXT(Input_doc_amend_cd)='' )
      '' 
    #ELSE
        IF( le.Input_doc_amend_cd = (TYPEOF(le.Input_doc_amend_cd))'','',':doc_amend_cd')
    #END
 
+    #IF( #TEXT(Input_doc_amend_desc)='' )
      '' 
    #ELSE
        IF( le.Input_doc_amend_desc = (TYPEOF(le.Input_doc_amend_desc))'','',':doc_amend_desc')
    #END
 
+    #IF( #TEXT(Input_execution_dt)='' )
      '' 
    #ELSE
        IF( le.Input_execution_dt = (TYPEOF(le.Input_execution_dt))'','',':execution_dt')
    #END
 
+    #IF( #TEXT(Input_consideration_amt)='' )
      '' 
    #ELSE
        IF( le.Input_consideration_amt = (TYPEOF(le.Input_consideration_amt))'','',':consideration_amt')
    #END
 
+    #IF( #TEXT(Input_assumption_amt)='' )
      '' 
    #ELSE
        IF( le.Input_assumption_amt = (TYPEOF(le.Input_assumption_amt))'','',':assumption_amt')
    #END
 
+    #IF( #TEXT(Input_certified_mail_fee)='' )
      '' 
    #ELSE
        IF( le.Input_certified_mail_fee = (TYPEOF(le.Input_certified_mail_fee))'','',':certified_mail_fee')
    #END
 
+    #IF( #TEXT(Input_service_charge)='' )
      '' 
    #ELSE
        IF( le.Input_service_charge = (TYPEOF(le.Input_service_charge))'','',':service_charge')
    #END
 
+    #IF( #TEXT(Input_trust_amt)='' )
      '' 
    #ELSE
        IF( le.Input_trust_amt = (TYPEOF(le.Input_trust_amt))'','',':trust_amt')
    #END
 
+    #IF( #TEXT(Input_transfer_)='' )
      '' 
    #ELSE
        IF( le.Input_transfer_ = (TYPEOF(le.Input_transfer_))'','',':transfer_')
    #END
 
+    #IF( #TEXT(Input_mortgage)='' )
      '' 
    #ELSE
        IF( le.Input_mortgage = (TYPEOF(le.Input_mortgage))'','',':mortgage')
    #END
 
+    #IF( #TEXT(Input_intangible_tax_amt)='' )
      '' 
    #ELSE
        IF( le.Input_intangible_tax_amt = (TYPEOF(le.Input_intangible_tax_amt))'','',':intangible_tax_amt')
    #END
 
+    #IF( #TEXT(Input_intangible_tax_penalty)='' )
      '' 
    #ELSE
        IF( le.Input_intangible_tax_penalty = (TYPEOF(le.Input_intangible_tax_penalty))'','',':intangible_tax_penalty')
    #END
 
+    #IF( #TEXT(Input_excise_tax_amt)='' )
      '' 
    #ELSE
        IF( le.Input_excise_tax_amt = (TYPEOF(le.Input_excise_tax_amt))'','',':excise_tax_amt')
    #END
 
+    #IF( #TEXT(Input_recording_fee)='' )
      '' 
    #ELSE
        IF( le.Input_recording_fee = (TYPEOF(le.Input_recording_fee))'','',':recording_fee')
    #END
 
+    #IF( #TEXT(Input_documentary_stamps_fee)='' )
      '' 
    #ELSE
        IF( le.Input_documentary_stamps_fee = (TYPEOF(le.Input_documentary_stamps_fee))'','',':documentary_stamps_fee')
    #END
 
+    #IF( #TEXT(Input_doc_stamps_mtg_fee)='' )
      '' 
    #ELSE
        IF( le.Input_doc_stamps_mtg_fee = (TYPEOF(le.Input_doc_stamps_mtg_fee))'','',':doc_stamps_mtg_fee')
    #END
 
+    #IF( #TEXT(Input_book_num)='' )
      '' 
    #ELSE
        IF( le.Input_book_num = (TYPEOF(le.Input_book_num))'','',':book_num')
    #END
 
+    #IF( #TEXT(Input_page_num)='' )
      '' 
    #ELSE
        IF( le.Input_page_num = (TYPEOF(le.Input_page_num))'','',':page_num')
    #END
 
+    #IF( #TEXT(Input_book_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_book_type_cd = (TYPEOF(le.Input_book_type_cd))'','',':book_type_cd')
    #END
 
+    #IF( #TEXT(Input_book_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_book_type_desc = (TYPEOF(le.Input_book_type_desc))'','',':book_type_desc')
    #END
 
+    #IF( #TEXT(Input_parcel_or_case_num)='' )
      '' 
    #ELSE
        IF( le.Input_parcel_or_case_num = (TYPEOF(le.Input_parcel_or_case_num))'','',':parcel_or_case_num')
    #END
 
+    #IF( #TEXT(Input_formatted_parcel_num)='' )
      '' 
    #ELSE
        IF( le.Input_formatted_parcel_num = (TYPEOF(le.Input_formatted_parcel_num))'','',':formatted_parcel_num')
    #END
 
+    #IF( #TEXT(Input_legal_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_legal_desc_1 = (TYPEOF(le.Input_legal_desc_1))'','',':legal_desc_1')
    #END
 
+    #IF( #TEXT(Input_legal_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_legal_desc_2 = (TYPEOF(le.Input_legal_desc_2))'','',':legal_desc_2')
    #END
 
+    #IF( #TEXT(Input_legal_desc_3)='' )
      '' 
    #ELSE
        IF( le.Input_legal_desc_3 = (TYPEOF(le.Input_legal_desc_3))'','',':legal_desc_3')
    #END
 
+    #IF( #TEXT(Input_legal_desc_4)='' )
      '' 
    #ELSE
        IF( le.Input_legal_desc_4 = (TYPEOF(le.Input_legal_desc_4))'','',':legal_desc_4')
    #END
 
+    #IF( #TEXT(Input_legal_desc_5)='' )
      '' 
    #ELSE
        IF( le.Input_legal_desc_5 = (TYPEOF(le.Input_legal_desc_5))'','',':legal_desc_5')
    #END
 
+    #IF( #TEXT(Input_verified_flag)='' )
      '' 
    #ELSE
        IF( le.Input_verified_flag = (TYPEOF(le.Input_verified_flag))'','',':verified_flag')
    #END
 
+    #IF( #TEXT(Input_address_1)='' )
      '' 
    #ELSE
        IF( le.Input_address_1 = (TYPEOF(le.Input_address_1))'','',':address_1')
    #END
 
+    #IF( #TEXT(Input_address_2)='' )
      '' 
    #ELSE
        IF( le.Input_address_2 = (TYPEOF(le.Input_address_2))'','',':address_2')
    #END
 
+    #IF( #TEXT(Input_address_3)='' )
      '' 
    #ELSE
        IF( le.Input_address_3 = (TYPEOF(le.Input_address_3))'','',':address_3')
    #END
 
+    #IF( #TEXT(Input_address_4)='' )
      '' 
    #ELSE
        IF( le.Input_address_4 = (TYPEOF(le.Input_address_4))'','',':address_4')
    #END
 
+    #IF( #TEXT(Input_prior_doc_file_num)='' )
      '' 
    #ELSE
        IF( le.Input_prior_doc_file_num = (TYPEOF(le.Input_prior_doc_file_num))'','',':prior_doc_file_num')
    #END
 
+    #IF( #TEXT(Input_prior_doc_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_prior_doc_type_cd = (TYPEOF(le.Input_prior_doc_type_cd))'','',':prior_doc_type_cd')
    #END
 
+    #IF( #TEXT(Input_prior_doc_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_prior_doc_type_desc = (TYPEOF(le.Input_prior_doc_type_desc))'','',':prior_doc_type_desc')
    #END
 
+    #IF( #TEXT(Input_prior_book_num)='' )
      '' 
    #ELSE
        IF( le.Input_prior_book_num = (TYPEOF(le.Input_prior_book_num))'','',':prior_book_num')
    #END
 
+    #IF( #TEXT(Input_prior_page_num)='' )
      '' 
    #ELSE
        IF( le.Input_prior_page_num = (TYPEOF(le.Input_prior_page_num))'','',':prior_page_num')
    #END
 
+    #IF( #TEXT(Input_prior_book_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_prior_book_type_cd = (TYPEOF(le.Input_prior_book_type_cd))'','',':prior_book_type_cd')
    #END
 
+    #IF( #TEXT(Input_prior_book_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_prior_book_type_desc = (TYPEOF(le.Input_prior_book_type_desc))'','',':prior_book_type_desc')
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
 
+    #IF( #TEXT(Input_dpbc)='' )
      '' 
    #ELSE
        IF( le.Input_dpbc = (TYPEOF(le.Input_dpbc))'','',':dpbc')
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
 
+    #IF( #TEXT(Input_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_ace_fips_st = (TYPEOF(le.Input_ace_fips_st))'','',':ace_fips_st')
    #END
 
+    #IF( #TEXT(Input_ace_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_ace_fips_county = (TYPEOF(le.Input_ace_fips_county))'','',':ace_fips_county')
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
