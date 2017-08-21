 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_date_file_loaded = '',Input_transaction_id = '',Input_event_date = '',Input_event_time = '',Input_function_name = '',Input_account_id = '',Input_subject_id = '',Input_customer_subject_id = '',Input_otp_id = '',Input_verify_passed = '',Input_otp_delivery_method = '',Input_otp_preferred_delivery = '',Input_otp_phone = '',Input_otp_email = '',Input_reference_code = '',Input_product_id = '',Input_sub_product_id = '',Input_subject_unique_id = '',Input_first_name = '',Input_last_name = '',Input_country = '',Input_state = '',Input_otp_type = '',Input_otp_length = '',Input_mobile_phone = '',Input_mobile_phone_country = '',Input_mobile_phone_carrier = '',Input_work_phone = '',Input_work_phone_country = '',Input_home_phone = '',Input_home_phone_country = '',Input_otp_language = '',Input_date_added = '',Input_time_added = '',OutFile) := MACRO
  IMPORT SALT36,Scrubs_PhoneFraud;
  #uniquename(of)
  %of% := RECORD
    SALT36.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_date_file_loaded)='' )
      '' 
    #ELSE
        IF( le.Input_date_file_loaded = (TYPEOF(le.Input_date_file_loaded))'','',':date_file_loaded')
    #END
 
+    #IF( #TEXT(Input_transaction_id)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_id = (TYPEOF(le.Input_transaction_id))'','',':transaction_id')
    #END
 
+    #IF( #TEXT(Input_event_date)='' )
      '' 
    #ELSE
        IF( le.Input_event_date = (TYPEOF(le.Input_event_date))'','',':event_date')
    #END
 
+    #IF( #TEXT(Input_event_time)='' )
      '' 
    #ELSE
        IF( le.Input_event_time = (TYPEOF(le.Input_event_time))'','',':event_time')
    #END
 
+    #IF( #TEXT(Input_function_name)='' )
      '' 
    #ELSE
        IF( le.Input_function_name = (TYPEOF(le.Input_function_name))'','',':function_name')
    #END
 
+    #IF( #TEXT(Input_account_id)='' )
      '' 
    #ELSE
        IF( le.Input_account_id = (TYPEOF(le.Input_account_id))'','',':account_id')
    #END
 
+    #IF( #TEXT(Input_subject_id)='' )
      '' 
    #ELSE
        IF( le.Input_subject_id = (TYPEOF(le.Input_subject_id))'','',':subject_id')
    #END
 
+    #IF( #TEXT(Input_customer_subject_id)='' )
      '' 
    #ELSE
        IF( le.Input_customer_subject_id = (TYPEOF(le.Input_customer_subject_id))'','',':customer_subject_id')
    #END
 
+    #IF( #TEXT(Input_otp_id)='' )
      '' 
    #ELSE
        IF( le.Input_otp_id = (TYPEOF(le.Input_otp_id))'','',':otp_id')
    #END
 
+    #IF( #TEXT(Input_verify_passed)='' )
      '' 
    #ELSE
        IF( le.Input_verify_passed = (TYPEOF(le.Input_verify_passed))'','',':verify_passed')
    #END
 
+    #IF( #TEXT(Input_otp_delivery_method)='' )
      '' 
    #ELSE
        IF( le.Input_otp_delivery_method = (TYPEOF(le.Input_otp_delivery_method))'','',':otp_delivery_method')
    #END
 
+    #IF( #TEXT(Input_otp_preferred_delivery)='' )
      '' 
    #ELSE
        IF( le.Input_otp_preferred_delivery = (TYPEOF(le.Input_otp_preferred_delivery))'','',':otp_preferred_delivery')
    #END
 
+    #IF( #TEXT(Input_otp_phone)='' )
      '' 
    #ELSE
        IF( le.Input_otp_phone = (TYPEOF(le.Input_otp_phone))'','',':otp_phone')
    #END
 
+    #IF( #TEXT(Input_otp_email)='' )
      '' 
    #ELSE
        IF( le.Input_otp_email = (TYPEOF(le.Input_otp_email))'','',':otp_email')
    #END
 
+    #IF( #TEXT(Input_reference_code)='' )
      '' 
    #ELSE
        IF( le.Input_reference_code = (TYPEOF(le.Input_reference_code))'','',':reference_code')
    #END
 
+    #IF( #TEXT(Input_product_id)='' )
      '' 
    #ELSE
        IF( le.Input_product_id = (TYPEOF(le.Input_product_id))'','',':product_id')
    #END
 
+    #IF( #TEXT(Input_sub_product_id)='' )
      '' 
    #ELSE
        IF( le.Input_sub_product_id = (TYPEOF(le.Input_sub_product_id))'','',':sub_product_id')
    #END
 
+    #IF( #TEXT(Input_subject_unique_id)='' )
      '' 
    #ELSE
        IF( le.Input_subject_unique_id = (TYPEOF(le.Input_subject_unique_id))'','',':subject_unique_id')
    #END
 
+    #IF( #TEXT(Input_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_name = (TYPEOF(le.Input_first_name))'','',':first_name')
    #END
 
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
    #END
 
+    #IF( #TEXT(Input_country)='' )
      '' 
    #ELSE
        IF( le.Input_country = (TYPEOF(le.Input_country))'','',':country')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_otp_type)='' )
      '' 
    #ELSE
        IF( le.Input_otp_type = (TYPEOF(le.Input_otp_type))'','',':otp_type')
    #END
 
+    #IF( #TEXT(Input_otp_length)='' )
      '' 
    #ELSE
        IF( le.Input_otp_length = (TYPEOF(le.Input_otp_length))'','',':otp_length')
    #END
 
+    #IF( #TEXT(Input_mobile_phone)='' )
      '' 
    #ELSE
        IF( le.Input_mobile_phone = (TYPEOF(le.Input_mobile_phone))'','',':mobile_phone')
    #END
 
+    #IF( #TEXT(Input_mobile_phone_country)='' )
      '' 
    #ELSE
        IF( le.Input_mobile_phone_country = (TYPEOF(le.Input_mobile_phone_country))'','',':mobile_phone_country')
    #END
 
+    #IF( #TEXT(Input_mobile_phone_carrier)='' )
      '' 
    #ELSE
        IF( le.Input_mobile_phone_carrier = (TYPEOF(le.Input_mobile_phone_carrier))'','',':mobile_phone_carrier')
    #END
 
+    #IF( #TEXT(Input_work_phone)='' )
      '' 
    #ELSE
        IF( le.Input_work_phone = (TYPEOF(le.Input_work_phone))'','',':work_phone')
    #END
 
+    #IF( #TEXT(Input_work_phone_country)='' )
      '' 
    #ELSE
        IF( le.Input_work_phone_country = (TYPEOF(le.Input_work_phone_country))'','',':work_phone_country')
    #END
 
+    #IF( #TEXT(Input_home_phone)='' )
      '' 
    #ELSE
        IF( le.Input_home_phone = (TYPEOF(le.Input_home_phone))'','',':home_phone')
    #END
 
+    #IF( #TEXT(Input_home_phone_country)='' )
      '' 
    #ELSE
        IF( le.Input_home_phone_country = (TYPEOF(le.Input_home_phone_country))'','',':home_phone_country')
    #END
 
+    #IF( #TEXT(Input_otp_language)='' )
      '' 
    #ELSE
        IF( le.Input_otp_language = (TYPEOF(le.Input_otp_language))'','',':otp_language')
    #END
 
+    #IF( #TEXT(Input_date_added)='' )
      '' 
    #ELSE
        IF( le.Input_date_added = (TYPEOF(le.Input_date_added))'','',':date_added')
    #END
 
+    #IF( #TEXT(Input_time_added)='' )
      '' 
    #ELSE
        IF( le.Input_time_added = (TYPEOF(le.Input_time_added))'','',':time_added')
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
