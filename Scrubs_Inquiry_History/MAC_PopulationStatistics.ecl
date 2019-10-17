 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_lex_id = '',Input_product_id = '',Input_inquiry_date = '',Input_transaction_id = '',Input_date_added = '',Input_customer_number = '',Input_customer_account = '',Input_ssn = '',Input_drivers_license_number = '',Input_drivers_license_state = '',Input_name_first = '',Input_name_last = '',Input_name_middle = '',Input_name_suffix = '',Input_addr_street = '',Input_addr_city = '',Input_addr_state = '',Input_addr_zip5 = '',Input_addr_zip4 = '',Input_dob = '',Input_transaction_location = '',Input_ppc = '',Input_internal_identifier = '',Input_eu1_customer_number = '',Input_eu1_customer_account = '',Input_eu2_customer_number = '',Input_eu2_customer_account = '',Input_email_addr = '',Input_ip_address = '',Input_state_id_number = '',Input_state_id_state = '',Input_eu_company_name = '',Input_eu_addr_street = '',Input_eu_addr_city = '',Input_eu_addr_state = '',Input_eu_addr_zip5 = '',Input_eu_phone_nbr = '',Input_product_code = '',Input_transaction_type = '',Input_function_name = '',Input_customer_id = '',Input_company_id = '',Input_global_company_id = '',Input_phone_nbr = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Inquiry_History;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_lex_id)='' )
      '' 
    #ELSE
        IF( le.Input_lex_id = (TYPEOF(le.Input_lex_id))'','',':lex_id')
    #END
 
+    #IF( #TEXT(Input_product_id)='' )
      '' 
    #ELSE
        IF( le.Input_product_id = (TYPEOF(le.Input_product_id))'','',':product_id')
    #END
 
+    #IF( #TEXT(Input_inquiry_date)='' )
      '' 
    #ELSE
        IF( le.Input_inquiry_date = (TYPEOF(le.Input_inquiry_date))'','',':inquiry_date')
    #END
 
+    #IF( #TEXT(Input_transaction_id)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_id = (TYPEOF(le.Input_transaction_id))'','',':transaction_id')
    #END
 
+    #IF( #TEXT(Input_date_added)='' )
      '' 
    #ELSE
        IF( le.Input_date_added = (TYPEOF(le.Input_date_added))'','',':date_added')
    #END
 
+    #IF( #TEXT(Input_customer_number)='' )
      '' 
    #ELSE
        IF( le.Input_customer_number = (TYPEOF(le.Input_customer_number))'','',':customer_number')
    #END
 
+    #IF( #TEXT(Input_customer_account)='' )
      '' 
    #ELSE
        IF( le.Input_customer_account = (TYPEOF(le.Input_customer_account))'','',':customer_account')
    #END
 
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
 
+    #IF( #TEXT(Input_drivers_license_number)='' )
      '' 
    #ELSE
        IF( le.Input_drivers_license_number = (TYPEOF(le.Input_drivers_license_number))'','',':drivers_license_number')
    #END
 
+    #IF( #TEXT(Input_drivers_license_state)='' )
      '' 
    #ELSE
        IF( le.Input_drivers_license_state = (TYPEOF(le.Input_drivers_license_state))'','',':drivers_license_state')
    #END
 
+    #IF( #TEXT(Input_name_first)='' )
      '' 
    #ELSE
        IF( le.Input_name_first = (TYPEOF(le.Input_name_first))'','',':name_first')
    #END
 
+    #IF( #TEXT(Input_name_last)='' )
      '' 
    #ELSE
        IF( le.Input_name_last = (TYPEOF(le.Input_name_last))'','',':name_last')
    #END
 
+    #IF( #TEXT(Input_name_middle)='' )
      '' 
    #ELSE
        IF( le.Input_name_middle = (TYPEOF(le.Input_name_middle))'','',':name_middle')
    #END
 
+    #IF( #TEXT(Input_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix = (TYPEOF(le.Input_name_suffix))'','',':name_suffix')
    #END
 
+    #IF( #TEXT(Input_addr_street)='' )
      '' 
    #ELSE
        IF( le.Input_addr_street = (TYPEOF(le.Input_addr_street))'','',':addr_street')
    #END
 
+    #IF( #TEXT(Input_addr_city)='' )
      '' 
    #ELSE
        IF( le.Input_addr_city = (TYPEOF(le.Input_addr_city))'','',':addr_city')
    #END
 
+    #IF( #TEXT(Input_addr_state)='' )
      '' 
    #ELSE
        IF( le.Input_addr_state = (TYPEOF(le.Input_addr_state))'','',':addr_state')
    #END
 
+    #IF( #TEXT(Input_addr_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_addr_zip5 = (TYPEOF(le.Input_addr_zip5))'','',':addr_zip5')
    #END
 
+    #IF( #TEXT(Input_addr_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_addr_zip4 = (TYPEOF(le.Input_addr_zip4))'','',':addr_zip4')
    #END
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_transaction_location)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_location = (TYPEOF(le.Input_transaction_location))'','',':transaction_location')
    #END
 
+    #IF( #TEXT(Input_ppc)='' )
      '' 
    #ELSE
        IF( le.Input_ppc = (TYPEOF(le.Input_ppc))'','',':ppc')
    #END
 
+    #IF( #TEXT(Input_internal_identifier)='' )
      '' 
    #ELSE
        IF( le.Input_internal_identifier = (TYPEOF(le.Input_internal_identifier))'','',':internal_identifier')
    #END
 
+    #IF( #TEXT(Input_eu1_customer_number)='' )
      '' 
    #ELSE
        IF( le.Input_eu1_customer_number = (TYPEOF(le.Input_eu1_customer_number))'','',':eu1_customer_number')
    #END
 
+    #IF( #TEXT(Input_eu1_customer_account)='' )
      '' 
    #ELSE
        IF( le.Input_eu1_customer_account = (TYPEOF(le.Input_eu1_customer_account))'','',':eu1_customer_account')
    #END
 
+    #IF( #TEXT(Input_eu2_customer_number)='' )
      '' 
    #ELSE
        IF( le.Input_eu2_customer_number = (TYPEOF(le.Input_eu2_customer_number))'','',':eu2_customer_number')
    #END
 
+    #IF( #TEXT(Input_eu2_customer_account)='' )
      '' 
    #ELSE
        IF( le.Input_eu2_customer_account = (TYPEOF(le.Input_eu2_customer_account))'','',':eu2_customer_account')
    #END
 
+    #IF( #TEXT(Input_email_addr)='' )
      '' 
    #ELSE
        IF( le.Input_email_addr = (TYPEOF(le.Input_email_addr))'','',':email_addr')
    #END
 
+    #IF( #TEXT(Input_ip_address)='' )
      '' 
    #ELSE
        IF( le.Input_ip_address = (TYPEOF(le.Input_ip_address))'','',':ip_address')
    #END
 
+    #IF( #TEXT(Input_state_id_number)='' )
      '' 
    #ELSE
        IF( le.Input_state_id_number = (TYPEOF(le.Input_state_id_number))'','',':state_id_number')
    #END
 
+    #IF( #TEXT(Input_state_id_state)='' )
      '' 
    #ELSE
        IF( le.Input_state_id_state = (TYPEOF(le.Input_state_id_state))'','',':state_id_state')
    #END
 
+    #IF( #TEXT(Input_eu_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_eu_company_name = (TYPEOF(le.Input_eu_company_name))'','',':eu_company_name')
    #END
 
+    #IF( #TEXT(Input_eu_addr_street)='' )
      '' 
    #ELSE
        IF( le.Input_eu_addr_street = (TYPEOF(le.Input_eu_addr_street))'','',':eu_addr_street')
    #END
 
+    #IF( #TEXT(Input_eu_addr_city)='' )
      '' 
    #ELSE
        IF( le.Input_eu_addr_city = (TYPEOF(le.Input_eu_addr_city))'','',':eu_addr_city')
    #END
 
+    #IF( #TEXT(Input_eu_addr_state)='' )
      '' 
    #ELSE
        IF( le.Input_eu_addr_state = (TYPEOF(le.Input_eu_addr_state))'','',':eu_addr_state')
    #END
 
+    #IF( #TEXT(Input_eu_addr_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_eu_addr_zip5 = (TYPEOF(le.Input_eu_addr_zip5))'','',':eu_addr_zip5')
    #END
 
+    #IF( #TEXT(Input_eu_phone_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_eu_phone_nbr = (TYPEOF(le.Input_eu_phone_nbr))'','',':eu_phone_nbr')
    #END
 
+    #IF( #TEXT(Input_product_code)='' )
      '' 
    #ELSE
        IF( le.Input_product_code = (TYPEOF(le.Input_product_code))'','',':product_code')
    #END
 
+    #IF( #TEXT(Input_transaction_type)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_type = (TYPEOF(le.Input_transaction_type))'','',':transaction_type')
    #END
 
+    #IF( #TEXT(Input_function_name)='' )
      '' 
    #ELSE
        IF( le.Input_function_name = (TYPEOF(le.Input_function_name))'','',':function_name')
    #END
 
+    #IF( #TEXT(Input_customer_id)='' )
      '' 
    #ELSE
        IF( le.Input_customer_id = (TYPEOF(le.Input_customer_id))'','',':customer_id')
    #END
 
+    #IF( #TEXT(Input_company_id)='' )
      '' 
    #ELSE
        IF( le.Input_company_id = (TYPEOF(le.Input_company_id))'','',':company_id')
    #END
 
+    #IF( #TEXT(Input_global_company_id)='' )
      '' 
    #ELSE
        IF( le.Input_global_company_id = (TYPEOF(le.Input_global_company_id))'','',':global_company_id')
    #END
 
+    #IF( #TEXT(Input_phone_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_phone_nbr = (TYPEOF(le.Input_phone_nbr))'','',':phone_nbr')
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
