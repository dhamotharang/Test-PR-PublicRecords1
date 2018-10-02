 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_orig_login_id = '',Input_orig_billing_code = '',Input_orig_transaction_id = '',Input_orig_function_name = '',Input_orig_company_id = '',Input_orig_reference_code = '',Input_orig_fname = '',Input_orig_mname = '',Input_orig_lname = '',Input_orig_name_suffix = '',Input_orig_fname_2 = '',Input_orig_mname_2 = '',Input_orig_lname_2 = '',Input_orig_name_suffix_2 = '',Input_orig_address = '',Input_orig_city = '',Input_orig_state = '',Input_orig_zip = '',Input_orig_zip4 = '',Input_orig_address_2 = '',Input_orig_city_2 = '',Input_orig_state_2 = '',Input_orig_zip_2 = '',Input_orig_zip4_2 = '',Input_orig_clean_address = '',Input_orig_clean_city = '',Input_orig_clean_state = '',Input_orig_clean_zip = '',Input_orig_clean_zip4 = '',Input_orig_phone = '',Input_orig_homephone = '',Input_orig_homephone_2 = '',Input_orig_workphone = '',Input_orig_workphone_2 = '',Input_orig_ssn = '',Input_orig_ssn_2 = '',Input_orig_free = '',Input_orig_record_count = '',Input_orig_price = '',Input_orig_revenue = '',Input_orig_full_name = '',Input_orig_business_name = '',Input_orig_business_name_2 = '',Input_orig_years = '',Input_orig_pricing_error_code = '',Input_orig_fcra_purpose = '',Input_orig_result_format = '',Input_orig_dob = '',Input_orig_dob_2 = '',Input_orig_unique_id = '',Input_orig_response_time = '',Input_orig_data_source = '',Input_orig_report_options = '',Input_orig_end_user_name = '',Input_orig_end_user_address_1 = '',Input_orig_end_user_address_2 = '',Input_orig_end_user_city = '',Input_orig_end_user_state = '',Input_orig_end_user_zip = '',Input_orig_login_history_id = '',Input_orig_employment_state = '',Input_orig_end_user_industry_class = '',Input_orig_function_specific_data = '',Input_orig_date_added = '',Input_orig_retail_price = '',Input_orig_country_code = '',Input_orig_email = '',Input_orig_email_2 = '',Input_orig_dl_number = '',Input_orig_dl_number_2 = '',Input_orig_sub_id = '',Input_orig_neighbors = '',Input_orig_relatives = '',Input_orig_associates = '',Input_orig_property = '',Input_orig_bankruptcy = '',Input_orig_dls = '',Input_orig_mvs = '',Input_orig_ip_address = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_Inql_Nfcra_Riskwise;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_orig_login_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_login_id = (TYPEOF(le.Input_orig_login_id))'','',':orig_login_id')
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
 
+    #IF( #TEXT(Input_orig_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_orig_name_suffix = (TYPEOF(le.Input_orig_name_suffix))'','',':orig_name_suffix')
    #END
 
+    #IF( #TEXT(Input_orig_fname_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_fname_2 = (TYPEOF(le.Input_orig_fname_2))'','',':orig_fname_2')
    #END
 
+    #IF( #TEXT(Input_orig_mname_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_mname_2 = (TYPEOF(le.Input_orig_mname_2))'','',':orig_mname_2')
    #END
 
+    #IF( #TEXT(Input_orig_lname_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_lname_2 = (TYPEOF(le.Input_orig_lname_2))'','',':orig_lname_2')
    #END
 
+    #IF( #TEXT(Input_orig_name_suffix_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_name_suffix_2 = (TYPEOF(le.Input_orig_name_suffix_2))'','',':orig_name_suffix_2')
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
 
+    #IF( #TEXT(Input_orig_address_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address_2 = (TYPEOF(le.Input_orig_address_2))'','',':orig_address_2')
    #END
 
+    #IF( #TEXT(Input_orig_city_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_city_2 = (TYPEOF(le.Input_orig_city_2))'','',':orig_city_2')
    #END
 
+    #IF( #TEXT(Input_orig_state_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_state_2 = (TYPEOF(le.Input_orig_state_2))'','',':orig_state_2')
    #END
 
+    #IF( #TEXT(Input_orig_zip_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip_2 = (TYPEOF(le.Input_orig_zip_2))'','',':orig_zip_2')
    #END
 
+    #IF( #TEXT(Input_orig_zip4_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip4_2 = (TYPEOF(le.Input_orig_zip4_2))'','',':orig_zip4_2')
    #END
 
+    #IF( #TEXT(Input_orig_clean_address)='' )
      '' 
    #ELSE
        IF( le.Input_orig_clean_address = (TYPEOF(le.Input_orig_clean_address))'','',':orig_clean_address')
    #END
 
+    #IF( #TEXT(Input_orig_clean_city)='' )
      '' 
    #ELSE
        IF( le.Input_orig_clean_city = (TYPEOF(le.Input_orig_clean_city))'','',':orig_clean_city')
    #END
 
+    #IF( #TEXT(Input_orig_clean_state)='' )
      '' 
    #ELSE
        IF( le.Input_orig_clean_state = (TYPEOF(le.Input_orig_clean_state))'','',':orig_clean_state')
    #END
 
+    #IF( #TEXT(Input_orig_clean_zip)='' )
      '' 
    #ELSE
        IF( le.Input_orig_clean_zip = (TYPEOF(le.Input_orig_clean_zip))'','',':orig_clean_zip')
    #END
 
+    #IF( #TEXT(Input_orig_clean_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_clean_zip4 = (TYPEOF(le.Input_orig_clean_zip4))'','',':orig_clean_zip4')
    #END
 
+    #IF( #TEXT(Input_orig_phone)='' )
      '' 
    #ELSE
        IF( le.Input_orig_phone = (TYPEOF(le.Input_orig_phone))'','',':orig_phone')
    #END
 
+    #IF( #TEXT(Input_orig_homephone)='' )
      '' 
    #ELSE
        IF( le.Input_orig_homephone = (TYPEOF(le.Input_orig_homephone))'','',':orig_homephone')
    #END
 
+    #IF( #TEXT(Input_orig_homephone_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_homephone_2 = (TYPEOF(le.Input_orig_homephone_2))'','',':orig_homephone_2')
    #END
 
+    #IF( #TEXT(Input_orig_workphone)='' )
      '' 
    #ELSE
        IF( le.Input_orig_workphone = (TYPEOF(le.Input_orig_workphone))'','',':orig_workphone')
    #END
 
+    #IF( #TEXT(Input_orig_workphone_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_workphone_2 = (TYPEOF(le.Input_orig_workphone_2))'','',':orig_workphone_2')
    #END
 
+    #IF( #TEXT(Input_orig_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_orig_ssn = (TYPEOF(le.Input_orig_ssn))'','',':orig_ssn')
    #END
 
+    #IF( #TEXT(Input_orig_ssn_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_ssn_2 = (TYPEOF(le.Input_orig_ssn_2))'','',':orig_ssn_2')
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
 
+    #IF( #TEXT(Input_orig_revenue)='' )
      '' 
    #ELSE
        IF( le.Input_orig_revenue = (TYPEOF(le.Input_orig_revenue))'','',':orig_revenue')
    #END
 
+    #IF( #TEXT(Input_orig_full_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_full_name = (TYPEOF(le.Input_orig_full_name))'','',':orig_full_name')
    #END
 
+    #IF( #TEXT(Input_orig_business_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_business_name = (TYPEOF(le.Input_orig_business_name))'','',':orig_business_name')
    #END
 
+    #IF( #TEXT(Input_orig_business_name_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_business_name_2 = (TYPEOF(le.Input_orig_business_name_2))'','',':orig_business_name_2')
    #END
 
+    #IF( #TEXT(Input_orig_years)='' )
      '' 
    #ELSE
        IF( le.Input_orig_years = (TYPEOF(le.Input_orig_years))'','',':orig_years')
    #END
 
+    #IF( #TEXT(Input_orig_pricing_error_code)='' )
      '' 
    #ELSE
        IF( le.Input_orig_pricing_error_code = (TYPEOF(le.Input_orig_pricing_error_code))'','',':orig_pricing_error_code')
    #END
 
+    #IF( #TEXT(Input_orig_fcra_purpose)='' )
      '' 
    #ELSE
        IF( le.Input_orig_fcra_purpose = (TYPEOF(le.Input_orig_fcra_purpose))'','',':orig_fcra_purpose')
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
 
+    #IF( #TEXT(Input_orig_dob_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dob_2 = (TYPEOF(le.Input_orig_dob_2))'','',':orig_dob_2')
    #END
 
+    #IF( #TEXT(Input_orig_unique_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_unique_id = (TYPEOF(le.Input_orig_unique_id))'','',':orig_unique_id')
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
 
+    #IF( #TEXT(Input_orig_report_options)='' )
      '' 
    #ELSE
        IF( le.Input_orig_report_options = (TYPEOF(le.Input_orig_report_options))'','',':orig_report_options')
    #END
 
+    #IF( #TEXT(Input_orig_end_user_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_end_user_name = (TYPEOF(le.Input_orig_end_user_name))'','',':orig_end_user_name')
    #END
 
+    #IF( #TEXT(Input_orig_end_user_address_1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_end_user_address_1 = (TYPEOF(le.Input_orig_end_user_address_1))'','',':orig_end_user_address_1')
    #END
 
+    #IF( #TEXT(Input_orig_end_user_address_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_end_user_address_2 = (TYPEOF(le.Input_orig_end_user_address_2))'','',':orig_end_user_address_2')
    #END
 
+    #IF( #TEXT(Input_orig_end_user_city)='' )
      '' 
    #ELSE
        IF( le.Input_orig_end_user_city = (TYPEOF(le.Input_orig_end_user_city))'','',':orig_end_user_city')
    #END
 
+    #IF( #TEXT(Input_orig_end_user_state)='' )
      '' 
    #ELSE
        IF( le.Input_orig_end_user_state = (TYPEOF(le.Input_orig_end_user_state))'','',':orig_end_user_state')
    #END
 
+    #IF( #TEXT(Input_orig_end_user_zip)='' )
      '' 
    #ELSE
        IF( le.Input_orig_end_user_zip = (TYPEOF(le.Input_orig_end_user_zip))'','',':orig_end_user_zip')
    #END
 
+    #IF( #TEXT(Input_orig_login_history_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_login_history_id = (TYPEOF(le.Input_orig_login_history_id))'','',':orig_login_history_id')
    #END
 
+    #IF( #TEXT(Input_orig_employment_state)='' )
      '' 
    #ELSE
        IF( le.Input_orig_employment_state = (TYPEOF(le.Input_orig_employment_state))'','',':orig_employment_state')
    #END
 
+    #IF( #TEXT(Input_orig_end_user_industry_class)='' )
      '' 
    #ELSE
        IF( le.Input_orig_end_user_industry_class = (TYPEOF(le.Input_orig_end_user_industry_class))'','',':orig_end_user_industry_class')
    #END
 
+    #IF( #TEXT(Input_orig_function_specific_data)='' )
      '' 
    #ELSE
        IF( le.Input_orig_function_specific_data = (TYPEOF(le.Input_orig_function_specific_data))'','',':orig_function_specific_data')
    #END
 
+    #IF( #TEXT(Input_orig_date_added)='' )
      '' 
    #ELSE
        IF( le.Input_orig_date_added = (TYPEOF(le.Input_orig_date_added))'','',':orig_date_added')
    #END
 
+    #IF( #TEXT(Input_orig_retail_price)='' )
      '' 
    #ELSE
        IF( le.Input_orig_retail_price = (TYPEOF(le.Input_orig_retail_price))'','',':orig_retail_price')
    #END
 
+    #IF( #TEXT(Input_orig_country_code)='' )
      '' 
    #ELSE
        IF( le.Input_orig_country_code = (TYPEOF(le.Input_orig_country_code))'','',':orig_country_code')
    #END
 
+    #IF( #TEXT(Input_orig_email)='' )
      '' 
    #ELSE
        IF( le.Input_orig_email = (TYPEOF(le.Input_orig_email))'','',':orig_email')
    #END
 
+    #IF( #TEXT(Input_orig_email_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_email_2 = (TYPEOF(le.Input_orig_email_2))'','',':orig_email_2')
    #END
 
+    #IF( #TEXT(Input_orig_dl_number)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dl_number = (TYPEOF(le.Input_orig_dl_number))'','',':orig_dl_number')
    #END
 
+    #IF( #TEXT(Input_orig_dl_number_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dl_number_2 = (TYPEOF(le.Input_orig_dl_number_2))'','',':orig_dl_number_2')
    #END
 
+    #IF( #TEXT(Input_orig_sub_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_sub_id = (TYPEOF(le.Input_orig_sub_id))'','',':orig_sub_id')
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
 
+    #IF( #TEXT(Input_orig_bankruptcy)='' )
      '' 
    #ELSE
        IF( le.Input_orig_bankruptcy = (TYPEOF(le.Input_orig_bankruptcy))'','',':orig_bankruptcy')
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
 
+    #IF( #TEXT(Input_orig_ip_address)='' )
      '' 
    #ELSE
        IF( le.Input_orig_ip_address = (TYPEOF(le.Input_orig_ip_address))'','',':orig_ip_address')
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
