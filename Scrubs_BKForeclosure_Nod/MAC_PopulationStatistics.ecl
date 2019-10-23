 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_foreclosure_id = '',Input_ln_filedate = '',Input_bk_infile_type = '',Input_src_county = '',Input_src_state = '',Input_fips_cd = '',Input_doc_type = '',Input_recording_dt = '',Input_recording_doc_num = '',Input_book_number = '',Input_page_number = '',Input_loan_number = '',Input_trustee_sale_number = '',Input_case_number = '',Input_orig_contract_date = '',Input_unpaid_balance = '',Input_past_due_amt = '',Input_as_of_dt = '',Input_contact_fname = '',Input_contact_lname = '',Input_attention_to = '',Input_contact_mail_full_addr = '',Input_contact_mail_unit = '',Input_contact_mail_city = '',Input_contact_mail_state = '',Input_contact_mail_zip5 = '',Input_contact_mail_zip4 = '',Input_contact_telephone = '',Input_due_date = '',Input_trustee_fname = '',Input_trustee_lname = '',Input_trustee_mail_full_addr = '',Input_trustee_mail_unit = '',Input_trustee_mail_city = '',Input_trustee_mail_state = '',Input_trustee_mail_zip5 = '',Input_trustee_mail_zip4 = '',Input_trustee_telephone = '',Input_borrower1_fname = '',Input_borrower1_lname = '',Input_borrower1_id_cd = '',Input_borrower2_fname = '',Input_borrower2_lname = '',Input_borrower2_id_cd = '',Input_orig_lender_name = '',Input_orig_lender_type = '',Input_curr_lender_name = '',Input_curr_lender_type = '',Input_mers_indicator = '',Input_loan_recording_date = '',Input_loan_doc_num = '',Input_loan_book = '',Input_loan_page = '',Input_orig_loan_amt = '',Input_legal_lot_num = '',Input_legal_block = '',Input_legal_subdivision_name = '',Input_legal_brief_desc = '',Input_auction_date = '',Input_auction_time = '',Input_auction_location = '',Input_auction_min_bid_amt = '',Input_trustee_mail_careof = '',Input_property_addr_cd = '',Input_auction_city = '',Input_original_nod_recording_date = '',Input_original_nod_doc_num = '',Input_original_nod_book = '',Input_original_nod_page = '',Input_nod_apn = '',Input_property_full_addr = '',Input_prop_addr_unit_type = '',Input_prop_addr_unit_no = '',Input_prop_addr_city = '',Input_prop_addr_state = '',Input_prop_addr_zip5 = '',Input_prop_addr_zip4 = '',Input_apn = '',Input_sam_pid = '',Input_deed_pid = '',Input_lps_internal_pid = '',Input_nod_source = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_BKForeclosure_Nod;
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
 
+    #IF( #TEXT(Input_src_county)='' )
      '' 
    #ELSE
        IF( le.Input_src_county = (TYPEOF(le.Input_src_county))'','',':src_county')
    #END
 
+    #IF( #TEXT(Input_src_state)='' )
      '' 
    #ELSE
        IF( le.Input_src_state = (TYPEOF(le.Input_src_state))'','',':src_state')
    #END
 
+    #IF( #TEXT(Input_fips_cd)='' )
      '' 
    #ELSE
        IF( le.Input_fips_cd = (TYPEOF(le.Input_fips_cd))'','',':fips_cd')
    #END
 
+    #IF( #TEXT(Input_doc_type)='' )
      '' 
    #ELSE
        IF( le.Input_doc_type = (TYPEOF(le.Input_doc_type))'','',':doc_type')
    #END
 
+    #IF( #TEXT(Input_recording_dt)='' )
      '' 
    #ELSE
        IF( le.Input_recording_dt = (TYPEOF(le.Input_recording_dt))'','',':recording_dt')
    #END
 
+    #IF( #TEXT(Input_recording_doc_num)='' )
      '' 
    #ELSE
        IF( le.Input_recording_doc_num = (TYPEOF(le.Input_recording_doc_num))'','',':recording_doc_num')
    #END
 
+    #IF( #TEXT(Input_book_number)='' )
      '' 
    #ELSE
        IF( le.Input_book_number = (TYPEOF(le.Input_book_number))'','',':book_number')
    #END
 
+    #IF( #TEXT(Input_page_number)='' )
      '' 
    #ELSE
        IF( le.Input_page_number = (TYPEOF(le.Input_page_number))'','',':page_number')
    #END
 
+    #IF( #TEXT(Input_loan_number)='' )
      '' 
    #ELSE
        IF( le.Input_loan_number = (TYPEOF(le.Input_loan_number))'','',':loan_number')
    #END
 
+    #IF( #TEXT(Input_trustee_sale_number)='' )
      '' 
    #ELSE
        IF( le.Input_trustee_sale_number = (TYPEOF(le.Input_trustee_sale_number))'','',':trustee_sale_number')
    #END
 
+    #IF( #TEXT(Input_case_number)='' )
      '' 
    #ELSE
        IF( le.Input_case_number = (TYPEOF(le.Input_case_number))'','',':case_number')
    #END
 
+    #IF( #TEXT(Input_orig_contract_date)='' )
      '' 
    #ELSE
        IF( le.Input_orig_contract_date = (TYPEOF(le.Input_orig_contract_date))'','',':orig_contract_date')
    #END
 
+    #IF( #TEXT(Input_unpaid_balance)='' )
      '' 
    #ELSE
        IF( le.Input_unpaid_balance = (TYPEOF(le.Input_unpaid_balance))'','',':unpaid_balance')
    #END
 
+    #IF( #TEXT(Input_past_due_amt)='' )
      '' 
    #ELSE
        IF( le.Input_past_due_amt = (TYPEOF(le.Input_past_due_amt))'','',':past_due_amt')
    #END
 
+    #IF( #TEXT(Input_as_of_dt)='' )
      '' 
    #ELSE
        IF( le.Input_as_of_dt = (TYPEOF(le.Input_as_of_dt))'','',':as_of_dt')
    #END
 
+    #IF( #TEXT(Input_contact_fname)='' )
      '' 
    #ELSE
        IF( le.Input_contact_fname = (TYPEOF(le.Input_contact_fname))'','',':contact_fname')
    #END
 
+    #IF( #TEXT(Input_contact_lname)='' )
      '' 
    #ELSE
        IF( le.Input_contact_lname = (TYPEOF(le.Input_contact_lname))'','',':contact_lname')
    #END
 
+    #IF( #TEXT(Input_attention_to)='' )
      '' 
    #ELSE
        IF( le.Input_attention_to = (TYPEOF(le.Input_attention_to))'','',':attention_to')
    #END
 
+    #IF( #TEXT(Input_contact_mail_full_addr)='' )
      '' 
    #ELSE
        IF( le.Input_contact_mail_full_addr = (TYPEOF(le.Input_contact_mail_full_addr))'','',':contact_mail_full_addr')
    #END
 
+    #IF( #TEXT(Input_contact_mail_unit)='' )
      '' 
    #ELSE
        IF( le.Input_contact_mail_unit = (TYPEOF(le.Input_contact_mail_unit))'','',':contact_mail_unit')
    #END
 
+    #IF( #TEXT(Input_contact_mail_city)='' )
      '' 
    #ELSE
        IF( le.Input_contact_mail_city = (TYPEOF(le.Input_contact_mail_city))'','',':contact_mail_city')
    #END
 
+    #IF( #TEXT(Input_contact_mail_state)='' )
      '' 
    #ELSE
        IF( le.Input_contact_mail_state = (TYPEOF(le.Input_contact_mail_state))'','',':contact_mail_state')
    #END
 
+    #IF( #TEXT(Input_contact_mail_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_contact_mail_zip5 = (TYPEOF(le.Input_contact_mail_zip5))'','',':contact_mail_zip5')
    #END
 
+    #IF( #TEXT(Input_contact_mail_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_contact_mail_zip4 = (TYPEOF(le.Input_contact_mail_zip4))'','',':contact_mail_zip4')
    #END
 
+    #IF( #TEXT(Input_contact_telephone)='' )
      '' 
    #ELSE
        IF( le.Input_contact_telephone = (TYPEOF(le.Input_contact_telephone))'','',':contact_telephone')
    #END
 
+    #IF( #TEXT(Input_due_date)='' )
      '' 
    #ELSE
        IF( le.Input_due_date = (TYPEOF(le.Input_due_date))'','',':due_date')
    #END
 
+    #IF( #TEXT(Input_trustee_fname)='' )
      '' 
    #ELSE
        IF( le.Input_trustee_fname = (TYPEOF(le.Input_trustee_fname))'','',':trustee_fname')
    #END
 
+    #IF( #TEXT(Input_trustee_lname)='' )
      '' 
    #ELSE
        IF( le.Input_trustee_lname = (TYPEOF(le.Input_trustee_lname))'','',':trustee_lname')
    #END
 
+    #IF( #TEXT(Input_trustee_mail_full_addr)='' )
      '' 
    #ELSE
        IF( le.Input_trustee_mail_full_addr = (TYPEOF(le.Input_trustee_mail_full_addr))'','',':trustee_mail_full_addr')
    #END
 
+    #IF( #TEXT(Input_trustee_mail_unit)='' )
      '' 
    #ELSE
        IF( le.Input_trustee_mail_unit = (TYPEOF(le.Input_trustee_mail_unit))'','',':trustee_mail_unit')
    #END
 
+    #IF( #TEXT(Input_trustee_mail_city)='' )
      '' 
    #ELSE
        IF( le.Input_trustee_mail_city = (TYPEOF(le.Input_trustee_mail_city))'','',':trustee_mail_city')
    #END
 
+    #IF( #TEXT(Input_trustee_mail_state)='' )
      '' 
    #ELSE
        IF( le.Input_trustee_mail_state = (TYPEOF(le.Input_trustee_mail_state))'','',':trustee_mail_state')
    #END
 
+    #IF( #TEXT(Input_trustee_mail_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_trustee_mail_zip5 = (TYPEOF(le.Input_trustee_mail_zip5))'','',':trustee_mail_zip5')
    #END
 
+    #IF( #TEXT(Input_trustee_mail_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_trustee_mail_zip4 = (TYPEOF(le.Input_trustee_mail_zip4))'','',':trustee_mail_zip4')
    #END
 
+    #IF( #TEXT(Input_trustee_telephone)='' )
      '' 
    #ELSE
        IF( le.Input_trustee_telephone = (TYPEOF(le.Input_trustee_telephone))'','',':trustee_telephone')
    #END
 
+    #IF( #TEXT(Input_borrower1_fname)='' )
      '' 
    #ELSE
        IF( le.Input_borrower1_fname = (TYPEOF(le.Input_borrower1_fname))'','',':borrower1_fname')
    #END
 
+    #IF( #TEXT(Input_borrower1_lname)='' )
      '' 
    #ELSE
        IF( le.Input_borrower1_lname = (TYPEOF(le.Input_borrower1_lname))'','',':borrower1_lname')
    #END
 
+    #IF( #TEXT(Input_borrower1_id_cd)='' )
      '' 
    #ELSE
        IF( le.Input_borrower1_id_cd = (TYPEOF(le.Input_borrower1_id_cd))'','',':borrower1_id_cd')
    #END
 
+    #IF( #TEXT(Input_borrower2_fname)='' )
      '' 
    #ELSE
        IF( le.Input_borrower2_fname = (TYPEOF(le.Input_borrower2_fname))'','',':borrower2_fname')
    #END
 
+    #IF( #TEXT(Input_borrower2_lname)='' )
      '' 
    #ELSE
        IF( le.Input_borrower2_lname = (TYPEOF(le.Input_borrower2_lname))'','',':borrower2_lname')
    #END
 
+    #IF( #TEXT(Input_borrower2_id_cd)='' )
      '' 
    #ELSE
        IF( le.Input_borrower2_id_cd = (TYPEOF(le.Input_borrower2_id_cd))'','',':borrower2_id_cd')
    #END
 
+    #IF( #TEXT(Input_orig_lender_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_lender_name = (TYPEOF(le.Input_orig_lender_name))'','',':orig_lender_name')
    #END
 
+    #IF( #TEXT(Input_orig_lender_type)='' )
      '' 
    #ELSE
        IF( le.Input_orig_lender_type = (TYPEOF(le.Input_orig_lender_type))'','',':orig_lender_type')
    #END
 
+    #IF( #TEXT(Input_curr_lender_name)='' )
      '' 
    #ELSE
        IF( le.Input_curr_lender_name = (TYPEOF(le.Input_curr_lender_name))'','',':curr_lender_name')
    #END
 
+    #IF( #TEXT(Input_curr_lender_type)='' )
      '' 
    #ELSE
        IF( le.Input_curr_lender_type = (TYPEOF(le.Input_curr_lender_type))'','',':curr_lender_type')
    #END
 
+    #IF( #TEXT(Input_mers_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_mers_indicator = (TYPEOF(le.Input_mers_indicator))'','',':mers_indicator')
    #END
 
+    #IF( #TEXT(Input_loan_recording_date)='' )
      '' 
    #ELSE
        IF( le.Input_loan_recording_date = (TYPEOF(le.Input_loan_recording_date))'','',':loan_recording_date')
    #END
 
+    #IF( #TEXT(Input_loan_doc_num)='' )
      '' 
    #ELSE
        IF( le.Input_loan_doc_num = (TYPEOF(le.Input_loan_doc_num))'','',':loan_doc_num')
    #END
 
+    #IF( #TEXT(Input_loan_book)='' )
      '' 
    #ELSE
        IF( le.Input_loan_book = (TYPEOF(le.Input_loan_book))'','',':loan_book')
    #END
 
+    #IF( #TEXT(Input_loan_page)='' )
      '' 
    #ELSE
        IF( le.Input_loan_page = (TYPEOF(le.Input_loan_page))'','',':loan_page')
    #END
 
+    #IF( #TEXT(Input_orig_loan_amt)='' )
      '' 
    #ELSE
        IF( le.Input_orig_loan_amt = (TYPEOF(le.Input_orig_loan_amt))'','',':orig_loan_amt')
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
 
+    #IF( #TEXT(Input_legal_subdivision_name)='' )
      '' 
    #ELSE
        IF( le.Input_legal_subdivision_name = (TYPEOF(le.Input_legal_subdivision_name))'','',':legal_subdivision_name')
    #END
 
+    #IF( #TEXT(Input_legal_brief_desc)='' )
      '' 
    #ELSE
        IF( le.Input_legal_brief_desc = (TYPEOF(le.Input_legal_brief_desc))'','',':legal_brief_desc')
    #END
 
+    #IF( #TEXT(Input_auction_date)='' )
      '' 
    #ELSE
        IF( le.Input_auction_date = (TYPEOF(le.Input_auction_date))'','',':auction_date')
    #END
 
+    #IF( #TEXT(Input_auction_time)='' )
      '' 
    #ELSE
        IF( le.Input_auction_time = (TYPEOF(le.Input_auction_time))'','',':auction_time')
    #END
 
+    #IF( #TEXT(Input_auction_location)='' )
      '' 
    #ELSE
        IF( le.Input_auction_location = (TYPEOF(le.Input_auction_location))'','',':auction_location')
    #END
 
+    #IF( #TEXT(Input_auction_min_bid_amt)='' )
      '' 
    #ELSE
        IF( le.Input_auction_min_bid_amt = (TYPEOF(le.Input_auction_min_bid_amt))'','',':auction_min_bid_amt')
    #END
 
+    #IF( #TEXT(Input_trustee_mail_careof)='' )
      '' 
    #ELSE
        IF( le.Input_trustee_mail_careof = (TYPEOF(le.Input_trustee_mail_careof))'','',':trustee_mail_careof')
    #END
 
+    #IF( #TEXT(Input_property_addr_cd)='' )
      '' 
    #ELSE
        IF( le.Input_property_addr_cd = (TYPEOF(le.Input_property_addr_cd))'','',':property_addr_cd')
    #END
 
+    #IF( #TEXT(Input_auction_city)='' )
      '' 
    #ELSE
        IF( le.Input_auction_city = (TYPEOF(le.Input_auction_city))'','',':auction_city')
    #END
 
+    #IF( #TEXT(Input_original_nod_recording_date)='' )
      '' 
    #ELSE
        IF( le.Input_original_nod_recording_date = (TYPEOF(le.Input_original_nod_recording_date))'','',':original_nod_recording_date')
    #END
 
+    #IF( #TEXT(Input_original_nod_doc_num)='' )
      '' 
    #ELSE
        IF( le.Input_original_nod_doc_num = (TYPEOF(le.Input_original_nod_doc_num))'','',':original_nod_doc_num')
    #END
 
+    #IF( #TEXT(Input_original_nod_book)='' )
      '' 
    #ELSE
        IF( le.Input_original_nod_book = (TYPEOF(le.Input_original_nod_book))'','',':original_nod_book')
    #END
 
+    #IF( #TEXT(Input_original_nod_page)='' )
      '' 
    #ELSE
        IF( le.Input_original_nod_page = (TYPEOF(le.Input_original_nod_page))'','',':original_nod_page')
    #END
 
+    #IF( #TEXT(Input_nod_apn)='' )
      '' 
    #ELSE
        IF( le.Input_nod_apn = (TYPEOF(le.Input_nod_apn))'','',':nod_apn')
    #END
 
+    #IF( #TEXT(Input_property_full_addr)='' )
      '' 
    #ELSE
        IF( le.Input_property_full_addr = (TYPEOF(le.Input_property_full_addr))'','',':property_full_addr')
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
 
+    #IF( #TEXT(Input_apn)='' )
      '' 
    #ELSE
        IF( le.Input_apn = (TYPEOF(le.Input_apn))'','',':apn')
    #END
 
+    #IF( #TEXT(Input_sam_pid)='' )
      '' 
    #ELSE
        IF( le.Input_sam_pid = (TYPEOF(le.Input_sam_pid))'','',':sam_pid')
    #END
 
+    #IF( #TEXT(Input_deed_pid)='' )
      '' 
    #ELSE
        IF( le.Input_deed_pid = (TYPEOF(le.Input_deed_pid))'','',':deed_pid')
    #END
 
+    #IF( #TEXT(Input_lps_internal_pid)='' )
      '' 
    #ELSE
        IF( le.Input_lps_internal_pid = (TYPEOF(le.Input_lps_internal_pid))'','',':lps_internal_pid')
    #END
 
+    #IF( #TEXT(Input_nod_source)='' )
      '' 
    #ELSE
        IF( le.Input_nod_source = (TYPEOF(le.Input_nod_source))'','',':nod_source')
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
