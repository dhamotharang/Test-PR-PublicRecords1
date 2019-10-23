 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_orig_end_user_id = '',Input_orig_loginid = '',Input_orig_billing_code = '',Input_orig_transaction_id = '',Input_orig_transaction_type = '',Input_orig_neighbors = '',Input_orig_relatives = '',Input_orig_associates = '',Input_orig_property = '',Input_orig_company_id = '',Input_orig_reference_code = '',Input_orig_fname = '',Input_orig_mname = '',Input_orig_lname = '',Input_orig_address = '',Input_orig_city = '',Input_orig_state = '',Input_orig_zip = '',Input_orig_zip4 = '',Input_orig_phone = '',Input_orig_ssn = '',Input_orig_free = '',Input_orig_record_count = '',Input_orig_price = '',Input_orig_bankruptcy = '',Input_orig_transaction_code = '',Input_orig_dateadded = '',Input_orig_full_name = '',Input_orig_billingdate = '',Input_orig_business_name = '',Input_orig_pricing_error_code = '',Input_orig_dl_purpose = '',Input_orig_result_format = '',Input_orig_dob = '',Input_orig_unique_id = '',Input_orig_dls = '',Input_orig_mvs = '',Input_orig_function_name = '',Input_orig_response_time = '',Input_orig_data_source = '',Input_orig_glb_purpose = '',Input_orig_report_options = '',Input_orig_unused = '',Input_orig_login_history_id = '',Input_orig_aseid = '',Input_orig_years = '',Input_orig_ip_address = '',Input_orig_source_code = '',Input_orig_retail_price = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_Inql_Nfcra_Accurint;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_orig_end_user_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_end_user_id = (TYPEOF(le.Input_orig_end_user_id))'','',':orig_end_user_id')
    #END
 
+    #IF( #TEXT(Input_orig_loginid)='' )
      '' 
    #ELSE
        IF( le.Input_orig_loginid = (TYPEOF(le.Input_orig_loginid))'','',':orig_loginid')
    #END
 
+    #IF( #TEXT(Input_orig_billing_code)='' )
      '' 
    #ELSE
        IF( le.Input_orig_billing_code = (TYPEOF(le.Input_orig_billing_code))'','',':orig_billing_code')
    #END
 
+    #IF( #TEXT(Input_orig_transaction_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_transaction_id = (TYPEOF(le.Input_orig_transaction_id))'','',':orig_transaction_id')
    #END
 
+    #IF( #TEXT(Input_orig_transaction_type)='' )
      '' 
    #ELSE
        IF( le.Input_orig_transaction_type = (TYPEOF(le.Input_orig_transaction_type))'','',':orig_transaction_type')
    #END
 
+    #IF( #TEXT(Input_orig_neighbors)='' )
      '' 
    #ELSE
        IF( le.Input_orig_neighbors = (TYPEOF(le.Input_orig_neighbors))'','',':orig_neighbors')
    #END
 
+    #IF( #TEXT(Input_orig_relatives)='' )
      '' 
    #ELSE
        IF( le.Input_orig_relatives = (TYPEOF(le.Input_orig_relatives))'','',':orig_relatives')
    #END
 
+    #IF( #TEXT(Input_orig_associates)='' )
      '' 
    #ELSE
        IF( le.Input_orig_associates = (TYPEOF(le.Input_orig_associates))'','',':orig_associates')
    #END
 
+    #IF( #TEXT(Input_orig_property)='' )
      '' 
    #ELSE
        IF( le.Input_orig_property = (TYPEOF(le.Input_orig_property))'','',':orig_property')
    #END
 
+    #IF( #TEXT(Input_orig_company_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_company_id = (TYPEOF(le.Input_orig_company_id))'','',':orig_company_id')
    #END
 
+    #IF( #TEXT(Input_orig_reference_code)='' )
      '' 
    #ELSE
        IF( le.Input_orig_reference_code = (TYPEOF(le.Input_orig_reference_code))'','',':orig_reference_code')
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
 
+    #IF( #TEXT(Input_orig_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip4 = (TYPEOF(le.Input_orig_zip4))'','',':orig_zip4')
    #END
 
+    #IF( #TEXT(Input_orig_phone)='' )
      '' 
    #ELSE
        IF( le.Input_orig_phone = (TYPEOF(le.Input_orig_phone))'','',':orig_phone')
    #END
 
+    #IF( #TEXT(Input_orig_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_orig_ssn = (TYPEOF(le.Input_orig_ssn))'','',':orig_ssn')
    #END
 
+    #IF( #TEXT(Input_orig_free)='' )
      '' 
    #ELSE
        IF( le.Input_orig_free = (TYPEOF(le.Input_orig_free))'','',':orig_free')
    #END
 
+    #IF( #TEXT(Input_orig_record_count)='' )
      '' 
    #ELSE
        IF( le.Input_orig_record_count = (TYPEOF(le.Input_orig_record_count))'','',':orig_record_count')
    #END
 
+    #IF( #TEXT(Input_orig_price)='' )
      '' 
    #ELSE
        IF( le.Input_orig_price = (TYPEOF(le.Input_orig_price))'','',':orig_price')
    #END
 
+    #IF( #TEXT(Input_orig_bankruptcy)='' )
      '' 
    #ELSE
        IF( le.Input_orig_bankruptcy = (TYPEOF(le.Input_orig_bankruptcy))'','',':orig_bankruptcy')
    #END
 
+    #IF( #TEXT(Input_orig_transaction_code)='' )
      '' 
    #ELSE
        IF( le.Input_orig_transaction_code = (TYPEOF(le.Input_orig_transaction_code))'','',':orig_transaction_code')
    #END
 
+    #IF( #TEXT(Input_orig_dateadded)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dateadded = (TYPEOF(le.Input_orig_dateadded))'','',':orig_dateadded')
    #END
 
+    #IF( #TEXT(Input_orig_full_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_full_name = (TYPEOF(le.Input_orig_full_name))'','',':orig_full_name')
    #END
 
+    #IF( #TEXT(Input_orig_billingdate)='' )
      '' 
    #ELSE
        IF( le.Input_orig_billingdate = (TYPEOF(le.Input_orig_billingdate))'','',':orig_billingdate')
    #END
 
+    #IF( #TEXT(Input_orig_business_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_business_name = (TYPEOF(le.Input_orig_business_name))'','',':orig_business_name')
    #END
 
+    #IF( #TEXT(Input_orig_pricing_error_code)='' )
      '' 
    #ELSE
        IF( le.Input_orig_pricing_error_code = (TYPEOF(le.Input_orig_pricing_error_code))'','',':orig_pricing_error_code')
    #END
 
+    #IF( #TEXT(Input_orig_dl_purpose)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dl_purpose = (TYPEOF(le.Input_orig_dl_purpose))'','',':orig_dl_purpose')
    #END
 
+    #IF( #TEXT(Input_orig_result_format)='' )
      '' 
    #ELSE
        IF( le.Input_orig_result_format = (TYPEOF(le.Input_orig_result_format))'','',':orig_result_format')
    #END
 
+    #IF( #TEXT(Input_orig_dob)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dob = (TYPEOF(le.Input_orig_dob))'','',':orig_dob')
    #END
 
+    #IF( #TEXT(Input_orig_unique_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_unique_id = (TYPEOF(le.Input_orig_unique_id))'','',':orig_unique_id')
    #END
 
+    #IF( #TEXT(Input_orig_dls)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dls = (TYPEOF(le.Input_orig_dls))'','',':orig_dls')
    #END
 
+    #IF( #TEXT(Input_orig_mvs)='' )
      '' 
    #ELSE
        IF( le.Input_orig_mvs = (TYPEOF(le.Input_orig_mvs))'','',':orig_mvs')
    #END
 
+    #IF( #TEXT(Input_orig_function_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_function_name = (TYPEOF(le.Input_orig_function_name))'','',':orig_function_name')
    #END
 
+    #IF( #TEXT(Input_orig_response_time)='' )
      '' 
    #ELSE
        IF( le.Input_orig_response_time = (TYPEOF(le.Input_orig_response_time))'','',':orig_response_time')
    #END
 
+    #IF( #TEXT(Input_orig_data_source)='' )
      '' 
    #ELSE
        IF( le.Input_orig_data_source = (TYPEOF(le.Input_orig_data_source))'','',':orig_data_source')
    #END
 
+    #IF( #TEXT(Input_orig_glb_purpose)='' )
      '' 
    #ELSE
        IF( le.Input_orig_glb_purpose = (TYPEOF(le.Input_orig_glb_purpose))'','',':orig_glb_purpose')
    #END
 
+    #IF( #TEXT(Input_orig_report_options)='' )
      '' 
    #ELSE
        IF( le.Input_orig_report_options = (TYPEOF(le.Input_orig_report_options))'','',':orig_report_options')
    #END
 
+    #IF( #TEXT(Input_orig_unused)='' )
      '' 
    #ELSE
        IF( le.Input_orig_unused = (TYPEOF(le.Input_orig_unused))'','',':orig_unused')
    #END
 
+    #IF( #TEXT(Input_orig_login_history_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_login_history_id = (TYPEOF(le.Input_orig_login_history_id))'','',':orig_login_history_id')
    #END
 
+    #IF( #TEXT(Input_orig_aseid)='' )
      '' 
    #ELSE
        IF( le.Input_orig_aseid = (TYPEOF(le.Input_orig_aseid))'','',':orig_aseid')
    #END
 
+    #IF( #TEXT(Input_orig_years)='' )
      '' 
    #ELSE
        IF( le.Input_orig_years = (TYPEOF(le.Input_orig_years))'','',':orig_years')
    #END
 
+    #IF( #TEXT(Input_orig_ip_address)='' )
      '' 
    #ELSE
        IF( le.Input_orig_ip_address = (TYPEOF(le.Input_orig_ip_address))'','',':orig_ip_address')
    #END
 
+    #IF( #TEXT(Input_orig_source_code)='' )
      '' 
    #ELSE
        IF( le.Input_orig_source_code = (TYPEOF(le.Input_orig_source_code))'','',':orig_source_code')
    #END
 
+    #IF( #TEXT(Input_orig_retail_price)='' )
      '' 
    #ELSE
        IF( le.Input_orig_retail_price = (TYPEOF(le.Input_orig_retail_price))'','',':orig_retail_price')
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
