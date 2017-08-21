EXPORT MAC_PopulationStatistics(infile,Ref='',Input_recording_date = '',Input_SourceType = '',Input_did = '',Input_apnt_or_pin_number = '',Input_recorder_book_number = '',Input_primname = '',Input_zip = '',Input_sales_price = '',Input_first_td_loan_amount = '',Input_primrange = '',Input_secrange = '',Input_contract_date = '',Input_document_number = '',Input_recorder_page_number = '',Input_prim_range_alpha = '',Input_sec_range_alpha = '',Input_name = '',Input_prim_name_num = '',Input_prim_name_alpha = '',Input_sec_range_num = '',Input_fips_code = '',Input_county_name = '',Input_lender_name = '',Input_prim_range_num = '',Input_city = '',Input_st = '',Input_ln_fares_id = '',Input_prim_range = '',Input_prim_name = '',Input_sec_range = '',Input_document_type_code = '',Input_locale = '',Input_address = '',OutFile) := MACRO
  IMPORT SALT34,InsuranceHeader_Property_Transactions_DeedsMortgages;
  #uniquename(of)
  %of% := RECORD
    SALT34.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_recording_date)='' )
      '' 
    #ELSE
        IF( le.Input_recording_date = (TYPEOF(le.Input_recording_date))'','',':recording_date')
    #END
+    #IF( #TEXT(Input_SourceType)='' )
      '' 
    #ELSE
        IF( le.Input_SourceType = (TYPEOF(le.Input_SourceType))'','',':SourceType')
    #END
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
+    #IF( #TEXT(Input_apnt_or_pin_number)='' )
      '' 
    #ELSE
        IF( le.Input_apnt_or_pin_number = (TYPEOF(le.Input_apnt_or_pin_number))'','',':apnt_or_pin_number')
    #END
+    #IF( #TEXT(Input_recorder_book_number)='' )
      '' 
    #ELSE
        IF( le.Input_recorder_book_number = (TYPEOF(le.Input_recorder_book_number))'','',':recorder_book_number')
    #END
+    #IF( #TEXT(Input_primname)='' )
      '' 
    #ELSE
        IF( le.Input_primname = (TYPEOF(le.Input_primname))'','',':primname')
    #END
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
+    #IF( #TEXT(Input_sales_price)='' )
      '' 
    #ELSE
        IF( le.Input_sales_price = (TYPEOF(le.Input_sales_price))'','',':sales_price')
    #END
+    #IF( #TEXT(Input_first_td_loan_amount)='' )
      '' 
    #ELSE
        IF( le.Input_first_td_loan_amount = (TYPEOF(le.Input_first_td_loan_amount))'','',':first_td_loan_amount')
    #END
+    #IF( #TEXT(Input_primrange)='' )
      '' 
    #ELSE
        IF( le.Input_primrange = (TYPEOF(le.Input_primrange))'','',':primrange')
    #END
+    #IF( #TEXT(Input_secrange)='' )
      '' 
    #ELSE
        IF( le.Input_secrange = (TYPEOF(le.Input_secrange))'','',':secrange')
    #END
+    #IF( #TEXT(Input_contract_date)='' )
      '' 
    #ELSE
        IF( le.Input_contract_date = (TYPEOF(le.Input_contract_date))'','',':contract_date')
    #END
+    #IF( #TEXT(Input_document_number)='' )
      '' 
    #ELSE
        IF( le.Input_document_number = (TYPEOF(le.Input_document_number))'','',':document_number')
    #END
+    #IF( #TEXT(Input_recorder_page_number)='' )
      '' 
    #ELSE
        IF( le.Input_recorder_page_number = (TYPEOF(le.Input_recorder_page_number))'','',':recorder_page_number')
    #END
+    #IF( #TEXT(Input_prim_range_alpha)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range_alpha = (TYPEOF(le.Input_prim_range_alpha))'','',':prim_range_alpha')
    #END
+    #IF( #TEXT(Input_sec_range_alpha)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range_alpha = (TYPEOF(le.Input_sec_range_alpha))'','',':sec_range_alpha')
    #END
+    #IF( #TEXT(Input_name)='' )
      '' 
    #ELSE
        IF( le.Input_name = (TYPEOF(le.Input_name))'','',':name')
    #END
+    #IF( #TEXT(Input_prim_name_num)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name_num = (TYPEOF(le.Input_prim_name_num))'','',':prim_name_num')
    #END
+    #IF( #TEXT(Input_prim_name_alpha)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name_alpha = (TYPEOF(le.Input_prim_name_alpha))'','',':prim_name_alpha')
    #END
+    #IF( #TEXT(Input_sec_range_num)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range_num = (TYPEOF(le.Input_sec_range_num))'','',':sec_range_num')
    #END
+    #IF( #TEXT(Input_fips_code)='' )
      '' 
    #ELSE
        IF( le.Input_fips_code = (TYPEOF(le.Input_fips_code))'','',':fips_code')
    #END
+    #IF( #TEXT(Input_county_name)='' )
      '' 
    #ELSE
        IF( le.Input_county_name = (TYPEOF(le.Input_county_name))'','',':county_name')
    #END
+    #IF( #TEXT(Input_lender_name)='' )
      '' 
    #ELSE
        IF( le.Input_lender_name = (TYPEOF(le.Input_lender_name))'','',':lender_name')
    #END
+    #IF( #TEXT(Input_prim_range_num)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range_num = (TYPEOF(le.Input_prim_range_num))'','',':prim_range_num')
    #END
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
+    #IF( #TEXT(Input_st)='' )
      '' 
    #ELSE
        IF( le.Input_st = (TYPEOF(le.Input_st))'','',':st')
    #END
+    #IF( #TEXT(Input_ln_fares_id)='' )
      '' 
    #ELSE
        IF( le.Input_ln_fares_id = (TYPEOF(le.Input_ln_fares_id))'','',':ln_fares_id')
    #END
+    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
    #END
+    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (TYPEOF(le.Input_prim_name))'','',':prim_name')
    #END
+    #IF( #TEXT(Input_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range = (TYPEOF(le.Input_sec_range))'','',':sec_range')
    #END
+    #IF( #TEXT(Input_document_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_document_type_code = (TYPEOF(le.Input_document_type_code))'','',':document_type_code')
    #END
+    #IF( #TEXT(Input_locale)='' )
      '' 
    #ELSE
        IF( le.Input_locale = (TYPEOF(le.Input_locale))'','',':locale')
    #END
+    #IF( #TEXT(Input_address)='' )
      '' 
    #ELSE
        IF( le.Input_address = (TYPEOF(le.Input_address))'','',':address')
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
