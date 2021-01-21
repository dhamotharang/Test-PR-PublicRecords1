EXPORT Deltabase_MAC_PopulationStatistics(infile,Ref='',Input_inqlog_id = '',Input_customer_id = '',Input_transaction_id = '',Input_date_of_transaction = '',Input_household_id = '',Input_customer_person_id = '',Input_customer_program = '',Input_reason_for_transaction_activity = '',Input_inquiry_source = '',Input_customer_county = '',Input_customer_state = '',Input_customer_agency_vertical_type = '',Input_ssn = '',Input_dob = '',Input_rawlinkid = '',Input_raw_full_name = '',Input_raw_title = '',Input_raw_first_name = '',Input_raw_middle_name = '',Input_raw_last_name = '',Input_raw_orig_suffix = '',Input_full_address = '',Input_street_1 = '',Input_city = '',Input_state = '',Input_zip = '',Input_county = '',Input_mailing_street_1 = '',Input_mailing_city = '',Input_mailing_state = '',Input_mailing_zip = '',Input_mailing_county = '',Input_phone_number = '',Input_ultid = '',Input_orgid = '',Input_seleid = '',Input_tin = '',Input_email_address = '',Input_appended_provider_id = '',Input_lnpid = '',Input_npi = '',Input_ip_address = '',Input_device_id = '',Input_professional_id = '',Input_bank_routing_number_1 = '',Input_bank_account_number_1 = '',Input_drivers_license_state = '',Input_drivers_license = '',Input_geo_lat = '',Input_geo_long = '',Input_reported_date = '',Input_file_type = '',Input_deceitful_confidence = '',Input_reported_by = '',Input_reason_description = '',Input_event_type_1 = '',Input_event_entity_1 = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_FraudGov;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_inqlog_id)='' )
      '' 
    #ELSE
        IF( le.Input_inqlog_id = (TYPEOF(le.Input_inqlog_id))'','',':inqlog_id')
    #END
+    #IF( #TEXT(Input_customer_id)='' )
      '' 
    #ELSE
        IF( le.Input_customer_id = (TYPEOF(le.Input_customer_id))'','',':customer_id')
    #END
+    #IF( #TEXT(Input_transaction_id)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_id = (TYPEOF(le.Input_transaction_id))'','',':transaction_id')
    #END
+    #IF( #TEXT(Input_date_of_transaction)='' )
      '' 
    #ELSE
        IF( le.Input_date_of_transaction = (TYPEOF(le.Input_date_of_transaction))'','',':date_of_transaction')
    #END
+    #IF( #TEXT(Input_household_id)='' )
      '' 
    #ELSE
        IF( le.Input_household_id = (TYPEOF(le.Input_household_id))'','',':household_id')
    #END
+    #IF( #TEXT(Input_customer_person_id)='' )
      '' 
    #ELSE
        IF( le.Input_customer_person_id = (TYPEOF(le.Input_customer_person_id))'','',':customer_person_id')
    #END
+    #IF( #TEXT(Input_customer_program)='' )
      '' 
    #ELSE
        IF( le.Input_customer_program = (TYPEOF(le.Input_customer_program))'','',':customer_program')
    #END
+    #IF( #TEXT(Input_reason_for_transaction_activity)='' )
      '' 
    #ELSE
        IF( le.Input_reason_for_transaction_activity = (TYPEOF(le.Input_reason_for_transaction_activity))'','',':reason_for_transaction_activity')
    #END
+    #IF( #TEXT(Input_inquiry_source)='' )
      '' 
    #ELSE
        IF( le.Input_inquiry_source = (TYPEOF(le.Input_inquiry_source))'','',':inquiry_source')
    #END
+    #IF( #TEXT(Input_customer_county)='' )
      '' 
    #ELSE
        IF( le.Input_customer_county = (TYPEOF(le.Input_customer_county))'','',':customer_county')
    #END
+    #IF( #TEXT(Input_customer_state)='' )
      '' 
    #ELSE
        IF( le.Input_customer_state = (TYPEOF(le.Input_customer_state))'','',':customer_state')
    #END
+    #IF( #TEXT(Input_customer_agency_vertical_type)='' )
      '' 
    #ELSE
        IF( le.Input_customer_agency_vertical_type = (TYPEOF(le.Input_customer_agency_vertical_type))'','',':customer_agency_vertical_type')
    #END
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
+    #IF( #TEXT(Input_rawlinkid)='' )
      '' 
    #ELSE
        IF( le.Input_rawlinkid = (TYPEOF(le.Input_rawlinkid))'','',':rawlinkid')
    #END
+    #IF( #TEXT(Input_raw_full_name)='' )
      '' 
    #ELSE
        IF( le.Input_raw_full_name = (TYPEOF(le.Input_raw_full_name))'','',':raw_full_name')
    #END
+    #IF( #TEXT(Input_raw_title)='' )
      '' 
    #ELSE
        IF( le.Input_raw_title = (TYPEOF(le.Input_raw_title))'','',':raw_title')
    #END
+    #IF( #TEXT(Input_raw_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_raw_first_name = (TYPEOF(le.Input_raw_first_name))'','',':raw_first_name')
    #END
+    #IF( #TEXT(Input_raw_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_raw_middle_name = (TYPEOF(le.Input_raw_middle_name))'','',':raw_middle_name')
    #END
+    #IF( #TEXT(Input_raw_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_raw_last_name = (TYPEOF(le.Input_raw_last_name))'','',':raw_last_name')
    #END
+    #IF( #TEXT(Input_raw_orig_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_raw_orig_suffix = (TYPEOF(le.Input_raw_orig_suffix))'','',':raw_orig_suffix')
    #END
+    #IF( #TEXT(Input_full_address)='' )
      '' 
    #ELSE
        IF( le.Input_full_address = (TYPEOF(le.Input_full_address))'','',':full_address')
    #END
+    #IF( #TEXT(Input_street_1)='' )
      '' 
    #ELSE
        IF( le.Input_street_1 = (TYPEOF(le.Input_street_1))'','',':street_1')
    #END
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
    #END
+    #IF( #TEXT(Input_mailing_street_1)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_street_1 = (TYPEOF(le.Input_mailing_street_1))'','',':mailing_street_1')
    #END
+    #IF( #TEXT(Input_mailing_city)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_city = (TYPEOF(le.Input_mailing_city))'','',':mailing_city')
    #END
+    #IF( #TEXT(Input_mailing_state)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_state = (TYPEOF(le.Input_mailing_state))'','',':mailing_state')
    #END
+    #IF( #TEXT(Input_mailing_zip)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_zip = (TYPEOF(le.Input_mailing_zip))'','',':mailing_zip')
    #END
+    #IF( #TEXT(Input_mailing_county)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_county = (TYPEOF(le.Input_mailing_county))'','',':mailing_county')
    #END
+    #IF( #TEXT(Input_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_phone_number = (TYPEOF(le.Input_phone_number))'','',':phone_number')
    #END
+    #IF( #TEXT(Input_ultid)='' )
      '' 
    #ELSE
        IF( le.Input_ultid = (TYPEOF(le.Input_ultid))'','',':ultid')
    #END
+    #IF( #TEXT(Input_orgid)='' )
      '' 
    #ELSE
        IF( le.Input_orgid = (TYPEOF(le.Input_orgid))'','',':orgid')
    #END
+    #IF( #TEXT(Input_seleid)='' )
      '' 
    #ELSE
        IF( le.Input_seleid = (TYPEOF(le.Input_seleid))'','',':seleid')
    #END
+    #IF( #TEXT(Input_tin)='' )
      '' 
    #ELSE
        IF( le.Input_tin = (TYPEOF(le.Input_tin))'','',':tin')
    #END
+    #IF( #TEXT(Input_email_address)='' )
      '' 
    #ELSE
        IF( le.Input_email_address = (TYPEOF(le.Input_email_address))'','',':email_address')
    #END
+    #IF( #TEXT(Input_appended_provider_id)='' )
      '' 
    #ELSE
        IF( le.Input_appended_provider_id = (TYPEOF(le.Input_appended_provider_id))'','',':appended_provider_id')
    #END
+    #IF( #TEXT(Input_lnpid)='' )
      '' 
    #ELSE
        IF( le.Input_lnpid = (TYPEOF(le.Input_lnpid))'','',':lnpid')
    #END
+    #IF( #TEXT(Input_npi)='' )
      '' 
    #ELSE
        IF( le.Input_npi = (TYPEOF(le.Input_npi))'','',':npi')
    #END
+    #IF( #TEXT(Input_ip_address)='' )
      '' 
    #ELSE
        IF( le.Input_ip_address = (TYPEOF(le.Input_ip_address))'','',':ip_address')
    #END
+    #IF( #TEXT(Input_device_id)='' )
      '' 
    #ELSE
        IF( le.Input_device_id = (TYPEOF(le.Input_device_id))'','',':device_id')
    #END
+    #IF( #TEXT(Input_professional_id)='' )
      '' 
    #ELSE
        IF( le.Input_professional_id = (TYPEOF(le.Input_professional_id))'','',':professional_id')
    #END
+    #IF( #TEXT(Input_bank_routing_number_1)='' )
      '' 
    #ELSE
        IF( le.Input_bank_routing_number_1 = (TYPEOF(le.Input_bank_routing_number_1))'','',':bank_routing_number_1')
    #END
+    #IF( #TEXT(Input_bank_account_number_1)='' )
      '' 
    #ELSE
        IF( le.Input_bank_account_number_1 = (TYPEOF(le.Input_bank_account_number_1))'','',':bank_account_number_1')
    #END
+    #IF( #TEXT(Input_drivers_license_state)='' )
      '' 
    #ELSE
        IF( le.Input_drivers_license_state = (TYPEOF(le.Input_drivers_license_state))'','',':drivers_license_state')
    #END
+    #IF( #TEXT(Input_drivers_license)='' )
      '' 
    #ELSE
        IF( le.Input_drivers_license = (TYPEOF(le.Input_drivers_license))'','',':drivers_license')
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
+    #IF( #TEXT(Input_reported_date)='' )
      '' 
    #ELSE
        IF( le.Input_reported_date = (TYPEOF(le.Input_reported_date))'','',':reported_date')
    #END
+    #IF( #TEXT(Input_file_type)='' )
      '' 
    #ELSE
        IF( le.Input_file_type = (TYPEOF(le.Input_file_type))'','',':file_type')
    #END
+    #IF( #TEXT(Input_deceitful_confidence)='' )
      '' 
    #ELSE
        IF( le.Input_deceitful_confidence = (TYPEOF(le.Input_deceitful_confidence))'','',':deceitful_confidence')
    #END
+    #IF( #TEXT(Input_reported_by)='' )
      '' 
    #ELSE
        IF( le.Input_reported_by = (TYPEOF(le.Input_reported_by))'','',':reported_by')
    #END
+    #IF( #TEXT(Input_reason_description)='' )
      '' 
    #ELSE
        IF( le.Input_reason_description = (TYPEOF(le.Input_reason_description))'','',':reason_description')
    #END
+    #IF( #TEXT(Input_event_type_1)='' )
      '' 
    #ELSE
        IF( le.Input_event_type_1 = (TYPEOF(le.Input_event_type_1))'','',':event_type_1')
    #END
+    #IF( #TEXT(Input_event_entity_1)='' )
      '' 
    #ELSE
        IF( le.Input_event_entity_1 = (TYPEOF(le.Input_event_entity_1))'','',':event_entity_1')
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
