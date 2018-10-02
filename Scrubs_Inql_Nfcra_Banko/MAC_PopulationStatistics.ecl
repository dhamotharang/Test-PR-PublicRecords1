 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_orig_transaction_id = '',Input_orig_function_name = '',Input_orig_company_id = '',Input_orig_login_id = '',Input_orig_billing_code = '',Input_orig_record_count = '',Input_orig_fcra_purpose = '',Input_orig_glb_purpose = '',Input_orig_dppa_purpose = '',Input_orig_ip_address = '',Input_orig_reference_code = '',Input_orig_login_history_id = '',Input_orig_date_added = '',Input_orig_price = '',Input_orig_pricing_error_code = '',Input_orig_free = '',Input_orig_business_name = '',Input_orig_name_first = '',Input_orig_name_last = '',Input_orig_ssn = '',Input_orig_case_number = '',Input_orig_address = '',Input_orig_city = '',Input_orig_state = '',Input_orig_zip = '',Input_orig_dob = '',Input_orig_phone = '',Input_orig_tmsid = '',Input_orig_unique_id = '',Input_orig_out_tmsid = '',Input_orig_out_business_name = '',Input_orig_out_first_name = '',Input_orig_out_last_name = '',Input_orig_out_ssn = '',Input_orig_out_address = '',Input_orig_out_city = '',Input_orig_out_state = '',Input_orig_out_zip = '',Input_orig_out_case_number = '',Input_orig_transaction_type = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_Inql_Nfcra_Banko;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_orig_transaction_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_transaction_id = (TYPEOF(le.Input_orig_transaction_id))'','',':orig_transaction_id')
    #END
 
+    #IF( #TEXT(Input_orig_function_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_function_name = (TYPEOF(le.Input_orig_function_name))'','',':orig_function_name')
    #END
 
+    #IF( #TEXT(Input_orig_company_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_company_id = (TYPEOF(le.Input_orig_company_id))'','',':orig_company_id')
    #END
 
+    #IF( #TEXT(Input_orig_login_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_login_id = (TYPEOF(le.Input_orig_login_id))'','',':orig_login_id')
    #END
 
+    #IF( #TEXT(Input_orig_billing_code)='' )
      '' 
    #ELSE
        IF( le.Input_orig_billing_code = (TYPEOF(le.Input_orig_billing_code))'','',':orig_billing_code')
    #END
 
+    #IF( #TEXT(Input_orig_record_count)='' )
      '' 
    #ELSE
        IF( le.Input_orig_record_count = (TYPEOF(le.Input_orig_record_count))'','',':orig_record_count')
    #END
 
+    #IF( #TEXT(Input_orig_fcra_purpose)='' )
      '' 
    #ELSE
        IF( le.Input_orig_fcra_purpose = (TYPEOF(le.Input_orig_fcra_purpose))'','',':orig_fcra_purpose')
    #END
 
+    #IF( #TEXT(Input_orig_glb_purpose)='' )
      '' 
    #ELSE
        IF( le.Input_orig_glb_purpose = (TYPEOF(le.Input_orig_glb_purpose))'','',':orig_glb_purpose')
    #END
 
+    #IF( #TEXT(Input_orig_dppa_purpose)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dppa_purpose = (TYPEOF(le.Input_orig_dppa_purpose))'','',':orig_dppa_purpose')
    #END
 
+    #IF( #TEXT(Input_orig_ip_address)='' )
      '' 
    #ELSE
        IF( le.Input_orig_ip_address = (TYPEOF(le.Input_orig_ip_address))'','',':orig_ip_address')
    #END
 
+    #IF( #TEXT(Input_orig_reference_code)='' )
      '' 
    #ELSE
        IF( le.Input_orig_reference_code = (TYPEOF(le.Input_orig_reference_code))'','',':orig_reference_code')
    #END
 
+    #IF( #TEXT(Input_orig_login_history_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_login_history_id = (TYPEOF(le.Input_orig_login_history_id))'','',':orig_login_history_id')
    #END
 
+    #IF( #TEXT(Input_orig_date_added)='' )
      '' 
    #ELSE
        IF( le.Input_orig_date_added = (TYPEOF(le.Input_orig_date_added))'','',':orig_date_added')
    #END
 
+    #IF( #TEXT(Input_orig_price)='' )
      '' 
    #ELSE
        IF( le.Input_orig_price = (TYPEOF(le.Input_orig_price))'','',':orig_price')
    #END
 
+    #IF( #TEXT(Input_orig_pricing_error_code)='' )
      '' 
    #ELSE
        IF( le.Input_orig_pricing_error_code = (TYPEOF(le.Input_orig_pricing_error_code))'','',':orig_pricing_error_code')
    #END
 
+    #IF( #TEXT(Input_orig_free)='' )
      '' 
    #ELSE
        IF( le.Input_orig_free = (TYPEOF(le.Input_orig_free))'','',':orig_free')
    #END
 
+    #IF( #TEXT(Input_orig_business_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_business_name = (TYPEOF(le.Input_orig_business_name))'','',':orig_business_name')
    #END
 
+    #IF( #TEXT(Input_orig_name_first)='' )
      '' 
    #ELSE
        IF( le.Input_orig_name_first = (TYPEOF(le.Input_orig_name_first))'','',':orig_name_first')
    #END
 
+    #IF( #TEXT(Input_orig_name_last)='' )
      '' 
    #ELSE
        IF( le.Input_orig_name_last = (TYPEOF(le.Input_orig_name_last))'','',':orig_name_last')
    #END
 
+    #IF( #TEXT(Input_orig_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_orig_ssn = (TYPEOF(le.Input_orig_ssn))'','',':orig_ssn')
    #END
 
+    #IF( #TEXT(Input_orig_case_number)='' )
      '' 
    #ELSE
        IF( le.Input_orig_case_number = (TYPEOF(le.Input_orig_case_number))'','',':orig_case_number')
    #END
 
+    #IF( #TEXT(Input_orig_address)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address = (TYPEOF(le.Input_orig_address))'','',':orig_address')
    #END
 
+    #IF( #TEXT(Input_orig_city)='' )
      '' 
    #ELSE
        IF( le.Input_orig_city = (TYPEOF(le.Input_orig_city))'','',':orig_city')
    #END
 
+    #IF( #TEXT(Input_orig_state)='' )
      '' 
    #ELSE
        IF( le.Input_orig_state = (TYPEOF(le.Input_orig_state))'','',':orig_state')
    #END
 
+    #IF( #TEXT(Input_orig_zip)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip = (TYPEOF(le.Input_orig_zip))'','',':orig_zip')
    #END
 
+    #IF( #TEXT(Input_orig_dob)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dob = (TYPEOF(le.Input_orig_dob))'','',':orig_dob')
    #END
 
+    #IF( #TEXT(Input_orig_phone)='' )
      '' 
    #ELSE
        IF( le.Input_orig_phone = (TYPEOF(le.Input_orig_phone))'','',':orig_phone')
    #END
 
+    #IF( #TEXT(Input_orig_tmsid)='' )
      '' 
    #ELSE
        IF( le.Input_orig_tmsid = (TYPEOF(le.Input_orig_tmsid))'','',':orig_tmsid')
    #END
 
+    #IF( #TEXT(Input_orig_unique_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_unique_id = (TYPEOF(le.Input_orig_unique_id))'','',':orig_unique_id')
    #END
 
+    #IF( #TEXT(Input_orig_out_tmsid)='' )
      '' 
    #ELSE
        IF( le.Input_orig_out_tmsid = (TYPEOF(le.Input_orig_out_tmsid))'','',':orig_out_tmsid')
    #END
 
+    #IF( #TEXT(Input_orig_out_business_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_out_business_name = (TYPEOF(le.Input_orig_out_business_name))'','',':orig_out_business_name')
    #END
 
+    #IF( #TEXT(Input_orig_out_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_out_first_name = (TYPEOF(le.Input_orig_out_first_name))'','',':orig_out_first_name')
    #END
 
+    #IF( #TEXT(Input_orig_out_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_out_last_name = (TYPEOF(le.Input_orig_out_last_name))'','',':orig_out_last_name')
    #END
 
+    #IF( #TEXT(Input_orig_out_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_orig_out_ssn = (TYPEOF(le.Input_orig_out_ssn))'','',':orig_out_ssn')
    #END
 
+    #IF( #TEXT(Input_orig_out_address)='' )
      '' 
    #ELSE
        IF( le.Input_orig_out_address = (TYPEOF(le.Input_orig_out_address))'','',':orig_out_address')
    #END
 
+    #IF( #TEXT(Input_orig_out_city)='' )
      '' 
    #ELSE
        IF( le.Input_orig_out_city = (TYPEOF(le.Input_orig_out_city))'','',':orig_out_city')
    #END
 
+    #IF( #TEXT(Input_orig_out_state)='' )
      '' 
    #ELSE
        IF( le.Input_orig_out_state = (TYPEOF(le.Input_orig_out_state))'','',':orig_out_state')
    #END
 
+    #IF( #TEXT(Input_orig_out_zip)='' )
      '' 
    #ELSE
        IF( le.Input_orig_out_zip = (TYPEOF(le.Input_orig_out_zip))'','',':orig_out_zip')
    #END
 
+    #IF( #TEXT(Input_orig_out_case_number)='' )
      '' 
    #ELSE
        IF( le.Input_orig_out_case_number = (TYPEOF(le.Input_orig_out_case_number))'','',':orig_out_case_number')
    #END
 
+    #IF( #TEXT(Input_orig_transaction_type)='' )
      '' 
    #ELSE
        IF( le.Input_orig_transaction_type = (TYPEOF(le.Input_orig_transaction_type))'','',':orig_transaction_type')
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
