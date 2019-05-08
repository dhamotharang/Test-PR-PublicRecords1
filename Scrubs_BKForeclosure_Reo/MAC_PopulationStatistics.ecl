 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_foreclosure_id = '',Input_ln_filedate = '',Input_bk_infile_type = '',Input_fips_cd = '',Input_prop_full_addr = '',Input_prop_addr_city = '',Input_prop_addr_state = '',Input_prop_addr_zip5 = '',Input_prop_addr_zip4 = '',Input_prop_addr_unit_type = '',Input_prop_addr_unit_no = '',Input_prop_addr_house_no = '',Input_prop_addr_predir = '',Input_prop_addr_street = '',Input_prop_addr_suffix = '',Input_prop_addr_postdir = '',Input_prop_addr_carrier_rt = '',Input_recording_date = '',Input_recording_book_num = '',Input_recording_page_num = '',Input_recording_doc_num = '',Input_doc_type_cd = '',Input_apn = '',Input_multi_apn = '',Input_partial_interest_trans = '',Input_seller1_fname = '',Input_seller1_lname = '',Input_seller1_id = '',Input_seller2_fname = '',Input_seller2_lname = '',Input_buyer1_fname = '',Input_buyer1_lname = '',Input_buyer1_id_cd = '',Input_buyer2_fname = '',Input_buyer2_lname = '',Input_buyer_vesting_cd = '',Input_concurrent_doc_num = '',Input_buyer_mail_city = '',Input_buyer_mail_state = '',Input_buyer_mail_zip5 = '',Input_buyer_mail_zip4 = '',Input_legal_lot_cd = '',Input_legal_lot_num = '',Input_legal_block = '',Input_legal_section = '',Input_legal_district = '',Input_legal_land_lot = '',Input_legal_unit = '',Input_legacl_city = '',Input_legal_subdivision = '',Input_legal_phase_num = '',Input_legal_tract_num = '',Input_legal_brief_desc = '',Input_legal_township = '',Input_recorder_map_ref = '',Input_prop_buyer_mail_addr_cd = '',Input_property_use_cd = '',Input_orig_contract_date = '',Input_sales_price = '',Input_sales_price_cd = '',Input_city_xfer_tax = '',Input_county_xfer_tax = '',Input_total_xfer_tax = '',Input_concurrent_lender_name = '',Input_concurrent_lender_type = '',Input_concurrent_loan_amt = '',Input_concurrent_loan_type = '',Input_concurrent_type_fin = '',Input_concurrent_interest_rate = '',Input_concurrent_due_dt = '',Input_concurrent_2nd_loan_amt = '',Input_buyer_mail_full_addr = '',Input_buyer_mail_unit_type = '',Input_buyer_mail_unit_no = '',Input_lps_internal_pid = '',Input_buyer_mail_careof = '',Input_title_co_name = '',Input_legal_desc_cd = '',Input_adj_rate_rider = '',Input_adj_rate_index = '',Input_change_index = '',Input_rate_change_freq = '',Input_int_rate_ngt = '',Input_int_rate_nlt = '',Input_max_int_rate = '',Input_int_only_period = '',Input_fixed_rate_rider = '',Input_first_chg_dt_yy = '',Input_first_chg_dt_mmdd = '',Input_prepayment_rider = '',Input_prepayment_term = '',Input_asses_land_use = '',Input_res_indicator = '',Input_construction_loan = '',Input_inter_family = '',Input_cash_purchase = '',Input_stand_alone_refi = '',Input_equity_credit_line = '',Input_reo_flag = '',Input_distressedsaleflag = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_BKForeclosure_Reo;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_foreclosure_id)='' )
      '' 
    #ELSE
        IF( le.Input_foreclosure_id = (TYPEOF(le.Input_foreclosure_id))'','',':foreclosure_id')
    #END
 
+    #IF( #TEXT(Input_ln_filedate)='' )
      '' 
    #ELSE
        IF( le.Input_ln_filedate = (TYPEOF(le.Input_ln_filedate))'','',':ln_filedate')
    #END
 
+    #IF( #TEXT(Input_bk_infile_type)='' )
      '' 
    #ELSE
        IF( le.Input_bk_infile_type = (TYPEOF(le.Input_bk_infile_type))'','',':bk_infile_type')
    #END
 
+    #IF( #TEXT(Input_fips_cd)='' )
      '' 
    #ELSE
        IF( le.Input_fips_cd = (TYPEOF(le.Input_fips_cd))'','',':fips_cd')
    #END
 
+    #IF( #TEXT(Input_prop_full_addr)='' )
      '' 
    #ELSE
        IF( le.Input_prop_full_addr = (TYPEOF(le.Input_prop_full_addr))'','',':prop_full_addr')
    #END
 
+    #IF( #TEXT(Input_prop_addr_city)='' )
      '' 
    #ELSE
        IF( le.Input_prop_addr_city = (TYPEOF(le.Input_prop_addr_city))'','',':prop_addr_city')
    #END
 
+    #IF( #TEXT(Input_prop_addr_state)='' )
      '' 
    #ELSE
        IF( le.Input_prop_addr_state = (TYPEOF(le.Input_prop_addr_state))'','',':prop_addr_state')
    #END
 
+    #IF( #TEXT(Input_prop_addr_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_prop_addr_zip5 = (TYPEOF(le.Input_prop_addr_zip5))'','',':prop_addr_zip5')
    #END
 
+    #IF( #TEXT(Input_prop_addr_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_prop_addr_zip4 = (TYPEOF(le.Input_prop_addr_zip4))'','',':prop_addr_zip4')
    #END
 
+    #IF( #TEXT(Input_prop_addr_unit_type)='' )
      '' 
    #ELSE
        IF( le.Input_prop_addr_unit_type = (TYPEOF(le.Input_prop_addr_unit_type))'','',':prop_addr_unit_type')
    #END
 
+    #IF( #TEXT(Input_prop_addr_unit_no)='' )
      '' 
    #ELSE
        IF( le.Input_prop_addr_unit_no = (TYPEOF(le.Input_prop_addr_unit_no))'','',':prop_addr_unit_no')
    #END
 
+    #IF( #TEXT(Input_prop_addr_house_no)='' )
      '' 
    #ELSE
        IF( le.Input_prop_addr_house_no = (TYPEOF(le.Input_prop_addr_house_no))'','',':prop_addr_house_no')
    #END
 
+    #IF( #TEXT(Input_prop_addr_predir)='' )
      '' 
    #ELSE
        IF( le.Input_prop_addr_predir = (TYPEOF(le.Input_prop_addr_predir))'','',':prop_addr_predir')
    #END
 
+    #IF( #TEXT(Input_prop_addr_street)='' )
      '' 
    #ELSE
        IF( le.Input_prop_addr_street = (TYPEOF(le.Input_prop_addr_street))'','',':prop_addr_street')
    #END
 
+    #IF( #TEXT(Input_prop_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_prop_addr_suffix = (TYPEOF(le.Input_prop_addr_suffix))'','',':prop_addr_suffix')
    #END
 
+    #IF( #TEXT(Input_prop_addr_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_prop_addr_postdir = (TYPEOF(le.Input_prop_addr_postdir))'','',':prop_addr_postdir')
    #END
 
+    #IF( #TEXT(Input_prop_addr_carrier_rt)='' )
      '' 
    #ELSE
        IF( le.Input_prop_addr_carrier_rt = (TYPEOF(le.Input_prop_addr_carrier_rt))'','',':prop_addr_carrier_rt')
    #END
 
+    #IF( #TEXT(Input_recording_date)='' )
      '' 
    #ELSE
        IF( le.Input_recording_date = (TYPEOF(le.Input_recording_date))'','',':recording_date')
    #END
 
+    #IF( #TEXT(Input_recording_book_num)='' )
      '' 
    #ELSE
        IF( le.Input_recording_book_num = (TYPEOF(le.Input_recording_book_num))'','',':recording_book_num')
    #END
 
+    #IF( #TEXT(Input_recording_page_num)='' )
      '' 
    #ELSE
        IF( le.Input_recording_page_num = (TYPEOF(le.Input_recording_page_num))'','',':recording_page_num')
    #END
 
+    #IF( #TEXT(Input_recording_doc_num)='' )
      '' 
    #ELSE
        IF( le.Input_recording_doc_num = (TYPEOF(le.Input_recording_doc_num))'','',':recording_doc_num')
    #END
 
+    #IF( #TEXT(Input_doc_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_doc_type_cd = (TYPEOF(le.Input_doc_type_cd))'','',':doc_type_cd')
    #END
 
+    #IF( #TEXT(Input_apn)='' )
      '' 
    #ELSE
        IF( le.Input_apn = (TYPEOF(le.Input_apn))'','',':apn')
    #END
 
+    #IF( #TEXT(Input_multi_apn)='' )
      '' 
    #ELSE
        IF( le.Input_multi_apn = (TYPEOF(le.Input_multi_apn))'','',':multi_apn')
    #END
 
+    #IF( #TEXT(Input_partial_interest_trans)='' )
      '' 
    #ELSE
        IF( le.Input_partial_interest_trans = (TYPEOF(le.Input_partial_interest_trans))'','',':partial_interest_trans')
    #END
 
+    #IF( #TEXT(Input_seller1_fname)='' )
      '' 
    #ELSE
        IF( le.Input_seller1_fname = (TYPEOF(le.Input_seller1_fname))'','',':seller1_fname')
    #END
 
+    #IF( #TEXT(Input_seller1_lname)='' )
      '' 
    #ELSE
        IF( le.Input_seller1_lname = (TYPEOF(le.Input_seller1_lname))'','',':seller1_lname')
    #END
 
+    #IF( #TEXT(Input_seller1_id)='' )
      '' 
    #ELSE
        IF( le.Input_seller1_id = (TYPEOF(le.Input_seller1_id))'','',':seller1_id')
    #END
 
+    #IF( #TEXT(Input_seller2_fname)='' )
      '' 
    #ELSE
        IF( le.Input_seller2_fname = (TYPEOF(le.Input_seller2_fname))'','',':seller2_fname')
    #END
 
+    #IF( #TEXT(Input_seller2_lname)='' )
      '' 
    #ELSE
        IF( le.Input_seller2_lname = (TYPEOF(le.Input_seller2_lname))'','',':seller2_lname')
    #END
 
+    #IF( #TEXT(Input_buyer1_fname)='' )
      '' 
    #ELSE
        IF( le.Input_buyer1_fname = (TYPEOF(le.Input_buyer1_fname))'','',':buyer1_fname')
    #END
 
+    #IF( #TEXT(Input_buyer1_lname)='' )
      '' 
    #ELSE
        IF( le.Input_buyer1_lname = (TYPEOF(le.Input_buyer1_lname))'','',':buyer1_lname')
    #END
 
+    #IF( #TEXT(Input_buyer1_id_cd)='' )
      '' 
    #ELSE
        IF( le.Input_buyer1_id_cd = (TYPEOF(le.Input_buyer1_id_cd))'','',':buyer1_id_cd')
    #END
 
+    #IF( #TEXT(Input_buyer2_fname)='' )
      '' 
    #ELSE
        IF( le.Input_buyer2_fname = (TYPEOF(le.Input_buyer2_fname))'','',':buyer2_fname')
    #END
 
+    #IF( #TEXT(Input_buyer2_lname)='' )
      '' 
    #ELSE
        IF( le.Input_buyer2_lname = (TYPEOF(le.Input_buyer2_lname))'','',':buyer2_lname')
    #END
 
+    #IF( #TEXT(Input_buyer_vesting_cd)='' )
      '' 
    #ELSE
        IF( le.Input_buyer_vesting_cd = (TYPEOF(le.Input_buyer_vesting_cd))'','',':buyer_vesting_cd')
    #END
 
+    #IF( #TEXT(Input_concurrent_doc_num)='' )
      '' 
    #ELSE
        IF( le.Input_concurrent_doc_num = (TYPEOF(le.Input_concurrent_doc_num))'','',':concurrent_doc_num')
    #END
 
+    #IF( #TEXT(Input_buyer_mail_city)='' )
      '' 
    #ELSE
        IF( le.Input_buyer_mail_city = (TYPEOF(le.Input_buyer_mail_city))'','',':buyer_mail_city')
    #END
 
+    #IF( #TEXT(Input_buyer_mail_state)='' )
      '' 
    #ELSE
        IF( le.Input_buyer_mail_state = (TYPEOF(le.Input_buyer_mail_state))'','',':buyer_mail_state')
    #END
 
+    #IF( #TEXT(Input_buyer_mail_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_buyer_mail_zip5 = (TYPEOF(le.Input_buyer_mail_zip5))'','',':buyer_mail_zip5')
    #END
 
+    #IF( #TEXT(Input_buyer_mail_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_buyer_mail_zip4 = (TYPEOF(le.Input_buyer_mail_zip4))'','',':buyer_mail_zip4')
    #END
 
+    #IF( #TEXT(Input_legal_lot_cd)='' )
      '' 
    #ELSE
        IF( le.Input_legal_lot_cd = (TYPEOF(le.Input_legal_lot_cd))'','',':legal_lot_cd')
    #END
 
+    #IF( #TEXT(Input_legal_lot_num)='' )
      '' 
    #ELSE
        IF( le.Input_legal_lot_num = (TYPEOF(le.Input_legal_lot_num))'','',':legal_lot_num')
    #END
 
+    #IF( #TEXT(Input_legal_block)='' )
      '' 
    #ELSE
        IF( le.Input_legal_block = (TYPEOF(le.Input_legal_block))'','',':legal_block')
    #END
 
+    #IF( #TEXT(Input_legal_section)='' )
      '' 
    #ELSE
        IF( le.Input_legal_section = (TYPEOF(le.Input_legal_section))'','',':legal_section')
    #END
 
+    #IF( #TEXT(Input_legal_district)='' )
      '' 
    #ELSE
        IF( le.Input_legal_district = (TYPEOF(le.Input_legal_district))'','',':legal_district')
    #END
 
+    #IF( #TEXT(Input_legal_land_lot)='' )
      '' 
    #ELSE
        IF( le.Input_legal_land_lot = (TYPEOF(le.Input_legal_land_lot))'','',':legal_land_lot')
    #END
 
+    #IF( #TEXT(Input_legal_unit)='' )
      '' 
    #ELSE
        IF( le.Input_legal_unit = (TYPEOF(le.Input_legal_unit))'','',':legal_unit')
    #END
 
+    #IF( #TEXT(Input_legacl_city)='' )
      '' 
    #ELSE
        IF( le.Input_legacl_city = (TYPEOF(le.Input_legacl_city))'','',':legacl_city')
    #END
 
+    #IF( #TEXT(Input_legal_subdivision)='' )
      '' 
    #ELSE
        IF( le.Input_legal_subdivision = (TYPEOF(le.Input_legal_subdivision))'','',':legal_subdivision')
    #END
 
+    #IF( #TEXT(Input_legal_phase_num)='' )
      '' 
    #ELSE
        IF( le.Input_legal_phase_num = (TYPEOF(le.Input_legal_phase_num))'','',':legal_phase_num')
    #END
 
+    #IF( #TEXT(Input_legal_tract_num)='' )
      '' 
    #ELSE
        IF( le.Input_legal_tract_num = (TYPEOF(le.Input_legal_tract_num))'','',':legal_tract_num')
    #END
 
+    #IF( #TEXT(Input_legal_brief_desc)='' )
      '' 
    #ELSE
        IF( le.Input_legal_brief_desc = (TYPEOF(le.Input_legal_brief_desc))'','',':legal_brief_desc')
    #END
 
+    #IF( #TEXT(Input_legal_township)='' )
      '' 
    #ELSE
        IF( le.Input_legal_township = (TYPEOF(le.Input_legal_township))'','',':legal_township')
    #END
 
+    #IF( #TEXT(Input_recorder_map_ref)='' )
      '' 
    #ELSE
        IF( le.Input_recorder_map_ref = (TYPEOF(le.Input_recorder_map_ref))'','',':recorder_map_ref')
    #END
 
+    #IF( #TEXT(Input_prop_buyer_mail_addr_cd)='' )
      '' 
    #ELSE
        IF( le.Input_prop_buyer_mail_addr_cd = (TYPEOF(le.Input_prop_buyer_mail_addr_cd))'','',':prop_buyer_mail_addr_cd')
    #END
 
+    #IF( #TEXT(Input_property_use_cd)='' )
      '' 
    #ELSE
        IF( le.Input_property_use_cd = (TYPEOF(le.Input_property_use_cd))'','',':property_use_cd')
    #END
 
+    #IF( #TEXT(Input_orig_contract_date)='' )
      '' 
    #ELSE
        IF( le.Input_orig_contract_date = (TYPEOF(le.Input_orig_contract_date))'','',':orig_contract_date')
    #END
 
+    #IF( #TEXT(Input_sales_price)='' )
      '' 
    #ELSE
        IF( le.Input_sales_price = (TYPEOF(le.Input_sales_price))'','',':sales_price')
    #END
 
+    #IF( #TEXT(Input_sales_price_cd)='' )
      '' 
    #ELSE
        IF( le.Input_sales_price_cd = (TYPEOF(le.Input_sales_price_cd))'','',':sales_price_cd')
    #END
 
+    #IF( #TEXT(Input_city_xfer_tax)='' )
      '' 
    #ELSE
        IF( le.Input_city_xfer_tax = (TYPEOF(le.Input_city_xfer_tax))'','',':city_xfer_tax')
    #END
 
+    #IF( #TEXT(Input_county_xfer_tax)='' )
      '' 
    #ELSE
        IF( le.Input_county_xfer_tax = (TYPEOF(le.Input_county_xfer_tax))'','',':county_xfer_tax')
    #END
 
+    #IF( #TEXT(Input_total_xfer_tax)='' )
      '' 
    #ELSE
        IF( le.Input_total_xfer_tax = (TYPEOF(le.Input_total_xfer_tax))'','',':total_xfer_tax')
    #END
 
+    #IF( #TEXT(Input_concurrent_lender_name)='' )
      '' 
    #ELSE
        IF( le.Input_concurrent_lender_name = (TYPEOF(le.Input_concurrent_lender_name))'','',':concurrent_lender_name')
    #END
 
+    #IF( #TEXT(Input_concurrent_lender_type)='' )
      '' 
    #ELSE
        IF( le.Input_concurrent_lender_type = (TYPEOF(le.Input_concurrent_lender_type))'','',':concurrent_lender_type')
    #END
 
+    #IF( #TEXT(Input_concurrent_loan_amt)='' )
      '' 
    #ELSE
        IF( le.Input_concurrent_loan_amt = (TYPEOF(le.Input_concurrent_loan_amt))'','',':concurrent_loan_amt')
    #END
 
+    #IF( #TEXT(Input_concurrent_loan_type)='' )
      '' 
    #ELSE
        IF( le.Input_concurrent_loan_type = (TYPEOF(le.Input_concurrent_loan_type))'','',':concurrent_loan_type')
    #END
 
+    #IF( #TEXT(Input_concurrent_type_fin)='' )
      '' 
    #ELSE
        IF( le.Input_concurrent_type_fin = (TYPEOF(le.Input_concurrent_type_fin))'','',':concurrent_type_fin')
    #END
 
+    #IF( #TEXT(Input_concurrent_interest_rate)='' )
      '' 
    #ELSE
        IF( le.Input_concurrent_interest_rate = (TYPEOF(le.Input_concurrent_interest_rate))'','',':concurrent_interest_rate')
    #END
 
+    #IF( #TEXT(Input_concurrent_due_dt)='' )
      '' 
    #ELSE
        IF( le.Input_concurrent_due_dt = (TYPEOF(le.Input_concurrent_due_dt))'','',':concurrent_due_dt')
    #END
 
+    #IF( #TEXT(Input_concurrent_2nd_loan_amt)='' )
      '' 
    #ELSE
        IF( le.Input_concurrent_2nd_loan_amt = (TYPEOF(le.Input_concurrent_2nd_loan_amt))'','',':concurrent_2nd_loan_amt')
    #END
 
+    #IF( #TEXT(Input_buyer_mail_full_addr)='' )
      '' 
    #ELSE
        IF( le.Input_buyer_mail_full_addr = (TYPEOF(le.Input_buyer_mail_full_addr))'','',':buyer_mail_full_addr')
    #END
 
+    #IF( #TEXT(Input_buyer_mail_unit_type)='' )
      '' 
    #ELSE
        IF( le.Input_buyer_mail_unit_type = (TYPEOF(le.Input_buyer_mail_unit_type))'','',':buyer_mail_unit_type')
    #END
 
+    #IF( #TEXT(Input_buyer_mail_unit_no)='' )
      '' 
    #ELSE
        IF( le.Input_buyer_mail_unit_no = (TYPEOF(le.Input_buyer_mail_unit_no))'','',':buyer_mail_unit_no')
    #END
 
+    #IF( #TEXT(Input_lps_internal_pid)='' )
      '' 
    #ELSE
        IF( le.Input_lps_internal_pid = (TYPEOF(le.Input_lps_internal_pid))'','',':lps_internal_pid')
    #END
 
+    #IF( #TEXT(Input_buyer_mail_careof)='' )
      '' 
    #ELSE
        IF( le.Input_buyer_mail_careof = (TYPEOF(le.Input_buyer_mail_careof))'','',':buyer_mail_careof')
    #END
 
+    #IF( #TEXT(Input_title_co_name)='' )
      '' 
    #ELSE
        IF( le.Input_title_co_name = (TYPEOF(le.Input_title_co_name))'','',':title_co_name')
    #END
 
+    #IF( #TEXT(Input_legal_desc_cd)='' )
      '' 
    #ELSE
        IF( le.Input_legal_desc_cd = (TYPEOF(le.Input_legal_desc_cd))'','',':legal_desc_cd')
    #END
 
+    #IF( #TEXT(Input_adj_rate_rider)='' )
      '' 
    #ELSE
        IF( le.Input_adj_rate_rider = (TYPEOF(le.Input_adj_rate_rider))'','',':adj_rate_rider')
    #END
 
+    #IF( #TEXT(Input_adj_rate_index)='' )
      '' 
    #ELSE
        IF( le.Input_adj_rate_index = (TYPEOF(le.Input_adj_rate_index))'','',':adj_rate_index')
    #END
 
+    #IF( #TEXT(Input_change_index)='' )
      '' 
    #ELSE
        IF( le.Input_change_index = (TYPEOF(le.Input_change_index))'','',':change_index')
    #END
 
+    #IF( #TEXT(Input_rate_change_freq)='' )
      '' 
    #ELSE
        IF( le.Input_rate_change_freq = (TYPEOF(le.Input_rate_change_freq))'','',':rate_change_freq')
    #END
 
+    #IF( #TEXT(Input_int_rate_ngt)='' )
      '' 
    #ELSE
        IF( le.Input_int_rate_ngt = (TYPEOF(le.Input_int_rate_ngt))'','',':int_rate_ngt')
    #END
 
+    #IF( #TEXT(Input_int_rate_nlt)='' )
      '' 
    #ELSE
        IF( le.Input_int_rate_nlt = (TYPEOF(le.Input_int_rate_nlt))'','',':int_rate_nlt')
    #END
 
+    #IF( #TEXT(Input_max_int_rate)='' )
      '' 
    #ELSE
        IF( le.Input_max_int_rate = (TYPEOF(le.Input_max_int_rate))'','',':max_int_rate')
    #END
 
+    #IF( #TEXT(Input_int_only_period)='' )
      '' 
    #ELSE
        IF( le.Input_int_only_period = (TYPEOF(le.Input_int_only_period))'','',':int_only_period')
    #END
 
+    #IF( #TEXT(Input_fixed_rate_rider)='' )
      '' 
    #ELSE
        IF( le.Input_fixed_rate_rider = (TYPEOF(le.Input_fixed_rate_rider))'','',':fixed_rate_rider')
    #END
 
+    #IF( #TEXT(Input_first_chg_dt_yy)='' )
      '' 
    #ELSE
        IF( le.Input_first_chg_dt_yy = (TYPEOF(le.Input_first_chg_dt_yy))'','',':first_chg_dt_yy')
    #END
 
+    #IF( #TEXT(Input_first_chg_dt_mmdd)='' )
      '' 
    #ELSE
        IF( le.Input_first_chg_dt_mmdd = (TYPEOF(le.Input_first_chg_dt_mmdd))'','',':first_chg_dt_mmdd')
    #END
 
+    #IF( #TEXT(Input_prepayment_rider)='' )
      '' 
    #ELSE
        IF( le.Input_prepayment_rider = (TYPEOF(le.Input_prepayment_rider))'','',':prepayment_rider')
    #END
 
+    #IF( #TEXT(Input_prepayment_term)='' )
      '' 
    #ELSE
        IF( le.Input_prepayment_term = (TYPEOF(le.Input_prepayment_term))'','',':prepayment_term')
    #END
 
+    #IF( #TEXT(Input_asses_land_use)='' )
      '' 
    #ELSE
        IF( le.Input_asses_land_use = (TYPEOF(le.Input_asses_land_use))'','',':asses_land_use')
    #END
 
+    #IF( #TEXT(Input_res_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_res_indicator = (TYPEOF(le.Input_res_indicator))'','',':res_indicator')
    #END
 
+    #IF( #TEXT(Input_construction_loan)='' )
      '' 
    #ELSE
        IF( le.Input_construction_loan = (TYPEOF(le.Input_construction_loan))'','',':construction_loan')
    #END
 
+    #IF( #TEXT(Input_inter_family)='' )
      '' 
    #ELSE
        IF( le.Input_inter_family = (TYPEOF(le.Input_inter_family))'','',':inter_family')
    #END
 
+    #IF( #TEXT(Input_cash_purchase)='' )
      '' 
    #ELSE
        IF( le.Input_cash_purchase = (TYPEOF(le.Input_cash_purchase))'','',':cash_purchase')
    #END
 
+    #IF( #TEXT(Input_stand_alone_refi)='' )
      '' 
    #ELSE
        IF( le.Input_stand_alone_refi = (TYPEOF(le.Input_stand_alone_refi))'','',':stand_alone_refi')
    #END
 
+    #IF( #TEXT(Input_equity_credit_line)='' )
      '' 
    #ELSE
        IF( le.Input_equity_credit_line = (TYPEOF(le.Input_equity_credit_line))'','',':equity_credit_line')
    #END
 
+    #IF( #TEXT(Input_reo_flag)='' )
      '' 
    #ELSE
        IF( le.Input_reo_flag = (TYPEOF(le.Input_reo_flag))'','',':reo_flag')
    #END
 
+    #IF( #TEXT(Input_distressedsaleflag)='' )
      '' 
    #ELSE
        IF( le.Input_distressedsaleflag = (TYPEOF(le.Input_distressedsaleflag))'','',':distressedsaleflag')
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
