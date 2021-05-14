 
EXPORT Transactions_MAC_PopulationStatistics(infile,Ref='',Input_transaction_id = '',Input_transaction_date = '',Input_user_id = '',Input_product_code = '',Input_company_id = '',Input_source_code = '',Input_batch_job_id = '',Input_batch_acctno = '',Input_response_time = '',Input_reference_code = '',Input_phonefinder_type = '',Input_submitted_lexid = '',Input_submitted_phonenumber = '',Input_submitted_firstname = '',Input_submitted_lastname = '',Input_submitted_middlename = '',Input_submitted_streetaddress1 = '',Input_submitted_city = '',Input_submitted_state = '',Input_submitted_zip = '',Input_phonenumber = '',Input_data_source = '',Input_royalty_used = '',Input_carrier = '',Input_risk_indicator = '',Input_phone_type = '',Input_phone_status = '',Input_ported_count = '',Input_last_ported_date = '',Input_otp_count = '',Input_last_otp_date = '',Input_spoof_count = '',Input_last_spoof_date = '',Input_phone_forwarded = '',Input_date_added = '',Input_filename = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_PhoneFinder;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_transaction_id)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_id = (TYPEOF(le.Input_transaction_id))'','',':transaction_id')
    #END
 
+    #IF( #TEXT(Input_transaction_date)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_date = (TYPEOF(le.Input_transaction_date))'','',':transaction_date')
    #END
 
+    #IF( #TEXT(Input_user_id)='' )
      '' 
    #ELSE
        IF( le.Input_user_id = (TYPEOF(le.Input_user_id))'','',':user_id')
    #END
 
+    #IF( #TEXT(Input_product_code)='' )
      '' 
    #ELSE
        IF( le.Input_product_code = (TYPEOF(le.Input_product_code))'','',':product_code')
    #END
 
+    #IF( #TEXT(Input_company_id)='' )
      '' 
    #ELSE
        IF( le.Input_company_id = (TYPEOF(le.Input_company_id))'','',':company_id')
    #END
 
+    #IF( #TEXT(Input_source_code)='' )
      '' 
    #ELSE
        IF( le.Input_source_code = (TYPEOF(le.Input_source_code))'','',':source_code')
    #END
 
+    #IF( #TEXT(Input_batch_job_id)='' )
      '' 
    #ELSE
        IF( le.Input_batch_job_id = (TYPEOF(le.Input_batch_job_id))'','',':batch_job_id')
    #END
 
+    #IF( #TEXT(Input_batch_acctno)='' )
      '' 
    #ELSE
        IF( le.Input_batch_acctno = (TYPEOF(le.Input_batch_acctno))'','',':batch_acctno')
    #END
 
+    #IF( #TEXT(Input_response_time)='' )
      '' 
    #ELSE
        IF( le.Input_response_time = (TYPEOF(le.Input_response_time))'','',':response_time')
    #END
 
+    #IF( #TEXT(Input_reference_code)='' )
      '' 
    #ELSE
        IF( le.Input_reference_code = (TYPEOF(le.Input_reference_code))'','',':reference_code')
    #END
 
+    #IF( #TEXT(Input_phonefinder_type)='' )
      '' 
    #ELSE
        IF( le.Input_phonefinder_type = (TYPEOF(le.Input_phonefinder_type))'','',':phonefinder_type')
    #END
 
+    #IF( #TEXT(Input_submitted_lexid)='' )
      '' 
    #ELSE
        IF( le.Input_submitted_lexid = (TYPEOF(le.Input_submitted_lexid))'','',':submitted_lexid')
    #END
 
+    #IF( #TEXT(Input_submitted_phonenumber)='' )
      '' 
    #ELSE
        IF( le.Input_submitted_phonenumber = (TYPEOF(le.Input_submitted_phonenumber))'','',':submitted_phonenumber')
    #END
 
+    #IF( #TEXT(Input_submitted_firstname)='' )
      '' 
    #ELSE
        IF( le.Input_submitted_firstname = (TYPEOF(le.Input_submitted_firstname))'','',':submitted_firstname')
    #END
 
+    #IF( #TEXT(Input_submitted_lastname)='' )
      '' 
    #ELSE
        IF( le.Input_submitted_lastname = (TYPEOF(le.Input_submitted_lastname))'','',':submitted_lastname')
    #END
 
+    #IF( #TEXT(Input_submitted_middlename)='' )
      '' 
    #ELSE
        IF( le.Input_submitted_middlename = (TYPEOF(le.Input_submitted_middlename))'','',':submitted_middlename')
    #END
 
+    #IF( #TEXT(Input_submitted_streetaddress1)='' )
      '' 
    #ELSE
        IF( le.Input_submitted_streetaddress1 = (TYPEOF(le.Input_submitted_streetaddress1))'','',':submitted_streetaddress1')
    #END
 
+    #IF( #TEXT(Input_submitted_city)='' )
      '' 
    #ELSE
        IF( le.Input_submitted_city = (TYPEOF(le.Input_submitted_city))'','',':submitted_city')
    #END
 
+    #IF( #TEXT(Input_submitted_state)='' )
      '' 
    #ELSE
        IF( le.Input_submitted_state = (TYPEOF(le.Input_submitted_state))'','',':submitted_state')
    #END
 
+    #IF( #TEXT(Input_submitted_zip)='' )
      '' 
    #ELSE
        IF( le.Input_submitted_zip = (TYPEOF(le.Input_submitted_zip))'','',':submitted_zip')
    #END
 
+    #IF( #TEXT(Input_phonenumber)='' )
      '' 
    #ELSE
        IF( le.Input_phonenumber = (TYPEOF(le.Input_phonenumber))'','',':phonenumber')
    #END
 
+    #IF( #TEXT(Input_data_source)='' )
      '' 
    #ELSE
        IF( le.Input_data_source = (TYPEOF(le.Input_data_source))'','',':data_source')
    #END
 
+    #IF( #TEXT(Input_royalty_used)='' )
      '' 
    #ELSE
        IF( le.Input_royalty_used = (TYPEOF(le.Input_royalty_used))'','',':royalty_used')
    #END
 
+    #IF( #TEXT(Input_carrier)='' )
      '' 
    #ELSE
        IF( le.Input_carrier = (TYPEOF(le.Input_carrier))'','',':carrier')
    #END
 
+    #IF( #TEXT(Input_risk_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_risk_indicator = (TYPEOF(le.Input_risk_indicator))'','',':risk_indicator')
    #END
 
+    #IF( #TEXT(Input_phone_type)='' )
      '' 
    #ELSE
        IF( le.Input_phone_type = (TYPEOF(le.Input_phone_type))'','',':phone_type')
    #END
 
+    #IF( #TEXT(Input_phone_status)='' )
      '' 
    #ELSE
        IF( le.Input_phone_status = (TYPEOF(le.Input_phone_status))'','',':phone_status')
    #END
 
+    #IF( #TEXT(Input_ported_count)='' )
      '' 
    #ELSE
        IF( le.Input_ported_count = (TYPEOF(le.Input_ported_count))'','',':ported_count')
    #END
 
+    #IF( #TEXT(Input_last_ported_date)='' )
      '' 
    #ELSE
        IF( le.Input_last_ported_date = (TYPEOF(le.Input_last_ported_date))'','',':last_ported_date')
    #END
 
+    #IF( #TEXT(Input_otp_count)='' )
      '' 
    #ELSE
        IF( le.Input_otp_count = (TYPEOF(le.Input_otp_count))'','',':otp_count')
    #END
 
+    #IF( #TEXT(Input_last_otp_date)='' )
      '' 
    #ELSE
        IF( le.Input_last_otp_date = (TYPEOF(le.Input_last_otp_date))'','',':last_otp_date')
    #END
 
+    #IF( #TEXT(Input_spoof_count)='' )
      '' 
    #ELSE
        IF( le.Input_spoof_count = (TYPEOF(le.Input_spoof_count))'','',':spoof_count')
    #END
 
+    #IF( #TEXT(Input_last_spoof_date)='' )
      '' 
    #ELSE
        IF( le.Input_last_spoof_date = (TYPEOF(le.Input_last_spoof_date))'','',':last_spoof_date')
    #END
 
+    #IF( #TEXT(Input_phone_forwarded)='' )
      '' 
    #ELSE
        IF( le.Input_phone_forwarded = (TYPEOF(le.Input_phone_forwarded))'','',':phone_forwarded')
    #END
 
+    #IF( #TEXT(Input_date_added)='' )
      '' 
    #ELSE
        IF( le.Input_date_added = (TYPEOF(le.Input_date_added))'','',':date_added')
    #END
 
+    #IF( #TEXT(Input_filename)='' )
      '' 
    #ELSE
        IF( le.Input_filename = (TYPEOF(le.Input_filename))'','',':filename')
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
