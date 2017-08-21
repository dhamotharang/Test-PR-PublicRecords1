EXPORT MAC_PopulationStatistics(infile,Ref='',Input_ln_key = '',Input_hms_src = '',Input_key = '',Input_id = '',Input_entityid = '',Input_license_number = '',Input_license_class_type = '',Input_license_state = '',Input_status = '',Input_issue_date = '',Input_renewal_date = '',Input_expiration_date = '',Input_qualifier1 = '',Input_qualifier2 = '',Input_qualifier3 = '',Input_qualifier4 = '',Input_qualifier5 = '',Input_rawclass = '',Input_rawissue_date = '',Input_rawexpiration_date = '',Input_rawstatus = '',Input_raw_number = '',Input_name = '',Input_prefix = '',Input_first = '',Input_middle = '',Input_last = '',Input_suffix = '',Input_cred = '',Input_age = '',Input_dateofbirth = '',Input_email = '',Input_gender = '',Input_dateofdeath = '',Input_employer_identification_number = '',Input_raw_full_address = '',Input_firmname = '',Input_street1 = '',Input_street2 = '',Input_street3 = '',Input_city = '',Input_address_state = '',Input_orig_zip = '',Input_orig_county = '',Input_country = '',Input_address_type = '',Input_phone1 = '',Input_phone2 = '',Input_phone3 = '',Input_fax1 = '',Input_fax2 = '',Input_fax3 = '',Input_other_phone1 = '',Input_description = '',Input_specialty_class_type = '',Input_phone_number = '',Input_phone_type = '',Input_language = '',Input_degree = '',Input_graduated = '',Input_school = '',Input_location = '',Input_fine = '',Input_board = '',Input_offense = '',Input_offense_date = '',Input_action = '',Input_action_date = '',Input_action_start = '',Input_action_end = '',Input_npi_number = '',Input_replacement_number = '',Input_enumeration_date = '',Input_last_update_date = '',Input_deactivation_date = '',Input_reactivation_date = '',Input_deactivation_reason = '',Input_csr_number = '',Input_credential_type = '',Input_csr_status = '',Input_sub_status = '',Input_csr_state = '',Input_csr_issue_date = '',Input_effective_date = '',Input_csr_expiration_date = '',Input_discipline = '',Input_all_schedules = '',Input_schedule_1 = '',Input_schedule_2 = '',Input_schedule_2n = '',Input_schedule_3 = '',Input_schedule_3n = '',Input_schedule_4 = '',Input_schedule_5 = '',Input_schedule_6 = '',Input_raw_status = '',Input_raw_sub_status1 = '',Input_raw_sub_status2 = '',Input_dea_number = '',Input_schedules = '',Input_dea_expiration_date = '',Input_activity = '',Input_bac = '',Input_bac_subcode = '',Input_payment = '',Input_medicaid_number = '',Input_medicaid_status = '',Input_medicaid_state = '',Input_participation_flag = '',Input_taxonomy_npi_number = '',Input_taxonomy_code = '',Input_taxonomy_order_number = '',Input_license_number_state_code = '',OutFile) := MACRO
  IMPORT SALT31,Scrubs_HMS_Csr;
  #uniquename(of)
  %of% := RECORD
    SALT31.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_ln_key)='' )
      '' 
    #ELSE
        IF( le.Input_ln_key = (TYPEOF(le.Input_ln_key))'','',':ln_key')
    #END
+    #IF( #TEXT(Input_hms_src)='' )
      '' 
    #ELSE
        IF( le.Input_hms_src = (TYPEOF(le.Input_hms_src))'','',':hms_src')
    #END
+    #IF( #TEXT(Input_key)='' )
      '' 
    #ELSE
        IF( le.Input_key = (TYPEOF(le.Input_key))'','',':key')
    #END
+    #IF( #TEXT(Input_id)='' )
      '' 
    #ELSE
        IF( le.Input_id = (TYPEOF(le.Input_id))'','',':id')
    #END
+    #IF( #TEXT(Input_entityid)='' )
      '' 
    #ELSE
        IF( le.Input_entityid = (TYPEOF(le.Input_entityid))'','',':entityid')
    #END
+    #IF( #TEXT(Input_license_number)='' )
      '' 
    #ELSE
        IF( le.Input_license_number = (TYPEOF(le.Input_license_number))'','',':license_number')
    #END
+    #IF( #TEXT(Input_license_class_type)='' )
      '' 
    #ELSE
        IF( le.Input_license_class_type = (TYPEOF(le.Input_license_class_type))'','',':license_class_type')
    #END
+    #IF( #TEXT(Input_license_state)='' )
      '' 
    #ELSE
        IF( le.Input_license_state = (TYPEOF(le.Input_license_state))'','',':license_state')
    #END
+    #IF( #TEXT(Input_status)='' )
      '' 
    #ELSE
        IF( le.Input_status = (TYPEOF(le.Input_status))'','',':status')
    #END
+    #IF( #TEXT(Input_issue_date)='' )
      '' 
    #ELSE
        IF( le.Input_issue_date = (TYPEOF(le.Input_issue_date))'','',':issue_date')
    #END
+    #IF( #TEXT(Input_renewal_date)='' )
      '' 
    #ELSE
        IF( le.Input_renewal_date = (TYPEOF(le.Input_renewal_date))'','',':renewal_date')
    #END
+    #IF( #TEXT(Input_expiration_date)='' )
      '' 
    #ELSE
        IF( le.Input_expiration_date = (TYPEOF(le.Input_expiration_date))'','',':expiration_date')
    #END
+    #IF( #TEXT(Input_qualifier1)='' )
      '' 
    #ELSE
        IF( le.Input_qualifier1 = (TYPEOF(le.Input_qualifier1))'','',':qualifier1')
    #END
+    #IF( #TEXT(Input_qualifier2)='' )
      '' 
    #ELSE
        IF( le.Input_qualifier2 = (TYPEOF(le.Input_qualifier2))'','',':qualifier2')
    #END
+    #IF( #TEXT(Input_qualifier3)='' )
      '' 
    #ELSE
        IF( le.Input_qualifier3 = (TYPEOF(le.Input_qualifier3))'','',':qualifier3')
    #END
+    #IF( #TEXT(Input_qualifier4)='' )
      '' 
    #ELSE
        IF( le.Input_qualifier4 = (TYPEOF(le.Input_qualifier4))'','',':qualifier4')
    #END
+    #IF( #TEXT(Input_qualifier5)='' )
      '' 
    #ELSE
        IF( le.Input_qualifier5 = (TYPEOF(le.Input_qualifier5))'','',':qualifier5')
    #END
+    #IF( #TEXT(Input_rawclass)='' )
      '' 
    #ELSE
        IF( le.Input_rawclass = (TYPEOF(le.Input_rawclass))'','',':rawclass')
    #END
+    #IF( #TEXT(Input_rawissue_date)='' )
      '' 
    #ELSE
        IF( le.Input_rawissue_date = (TYPEOF(le.Input_rawissue_date))'','',':rawissue_date')
    #END
+    #IF( #TEXT(Input_rawexpiration_date)='' )
      '' 
    #ELSE
        IF( le.Input_rawexpiration_date = (TYPEOF(le.Input_rawexpiration_date))'','',':rawexpiration_date')
    #END
+    #IF( #TEXT(Input_rawstatus)='' )
      '' 
    #ELSE
        IF( le.Input_rawstatus = (TYPEOF(le.Input_rawstatus))'','',':rawstatus')
    #END
+    #IF( #TEXT(Input_raw_number)='' )
      '' 
    #ELSE
        IF( le.Input_raw_number = (TYPEOF(le.Input_raw_number))'','',':raw_number')
    #END
+    #IF( #TEXT(Input_name)='' )
      '' 
    #ELSE
        IF( le.Input_name = (TYPEOF(le.Input_name))'','',':name')
    #END
+    #IF( #TEXT(Input_prefix)='' )
      '' 
    #ELSE
        IF( le.Input_prefix = (TYPEOF(le.Input_prefix))'','',':prefix')
    #END
+    #IF( #TEXT(Input_first)='' )
      '' 
    #ELSE
        IF( le.Input_first = (TYPEOF(le.Input_first))'','',':first')
    #END
+    #IF( #TEXT(Input_middle)='' )
      '' 
    #ELSE
        IF( le.Input_middle = (TYPEOF(le.Input_middle))'','',':middle')
    #END
+    #IF( #TEXT(Input_last)='' )
      '' 
    #ELSE
        IF( le.Input_last = (TYPEOF(le.Input_last))'','',':last')
    #END
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
+    #IF( #TEXT(Input_cred)='' )
      '' 
    #ELSE
        IF( le.Input_cred = (TYPEOF(le.Input_cred))'','',':cred')
    #END
+    #IF( #TEXT(Input_age)='' )
      '' 
    #ELSE
        IF( le.Input_age = (TYPEOF(le.Input_age))'','',':age')
    #END
+    #IF( #TEXT(Input_dateofbirth)='' )
      '' 
    #ELSE
        IF( le.Input_dateofbirth = (TYPEOF(le.Input_dateofbirth))'','',':dateofbirth')
    #END
+    #IF( #TEXT(Input_email)='' )
      '' 
    #ELSE
        IF( le.Input_email = (TYPEOF(le.Input_email))'','',':email')
    #END
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
+    #IF( #TEXT(Input_dateofdeath)='' )
      '' 
    #ELSE
        IF( le.Input_dateofdeath = (TYPEOF(le.Input_dateofdeath))'','',':dateofdeath')
    #END
+    #IF( #TEXT(Input_employer_identification_number)='' )
      '' 
    #ELSE
        IF( le.Input_employer_identification_number = (TYPEOF(le.Input_employer_identification_number))'','',':employer_identification_number')
    #END
+    #IF( #TEXT(Input_raw_full_address)='' )
      '' 
    #ELSE
        IF( le.Input_raw_full_address = (TYPEOF(le.Input_raw_full_address))'','',':raw_full_address')
    #END
+    #IF( #TEXT(Input_firmname)='' )
      '' 
    #ELSE
        IF( le.Input_firmname = (TYPEOF(le.Input_firmname))'','',':firmname')
    #END
+    #IF( #TEXT(Input_street1)='' )
      '' 
    #ELSE
        IF( le.Input_street1 = (TYPEOF(le.Input_street1))'','',':street1')
    #END
+    #IF( #TEXT(Input_street2)='' )
      '' 
    #ELSE
        IF( le.Input_street2 = (TYPEOF(le.Input_street2))'','',':street2')
    #END
+    #IF( #TEXT(Input_street3)='' )
      '' 
    #ELSE
        IF( le.Input_street3 = (TYPEOF(le.Input_street3))'','',':street3')
    #END
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
+    #IF( #TEXT(Input_address_state)='' )
      '' 
    #ELSE
        IF( le.Input_address_state = (TYPEOF(le.Input_address_state))'','',':address_state')
    #END
+    #IF( #TEXT(Input_orig_zip)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip = (TYPEOF(le.Input_orig_zip))'','',':orig_zip')
    #END
+    #IF( #TEXT(Input_orig_county)='' )
      '' 
    #ELSE
        IF( le.Input_orig_county = (TYPEOF(le.Input_orig_county))'','',':orig_county')
    #END
+    #IF( #TEXT(Input_country)='' )
      '' 
    #ELSE
        IF( le.Input_country = (TYPEOF(le.Input_country))'','',':country')
    #END
+    #IF( #TEXT(Input_address_type)='' )
      '' 
    #ELSE
        IF( le.Input_address_type = (TYPEOF(le.Input_address_type))'','',':address_type')
    #END
+    #IF( #TEXT(Input_phone1)='' )
      '' 
    #ELSE
        IF( le.Input_phone1 = (TYPEOF(le.Input_phone1))'','',':phone1')
    #END
+    #IF( #TEXT(Input_phone2)='' )
      '' 
    #ELSE
        IF( le.Input_phone2 = (TYPEOF(le.Input_phone2))'','',':phone2')
    #END
+    #IF( #TEXT(Input_phone3)='' )
      '' 
    #ELSE
        IF( le.Input_phone3 = (TYPEOF(le.Input_phone3))'','',':phone3')
    #END
+    #IF( #TEXT(Input_fax1)='' )
      '' 
    #ELSE
        IF( le.Input_fax1 = (TYPEOF(le.Input_fax1))'','',':fax1')
    #END
+    #IF( #TEXT(Input_fax2)='' )
      '' 
    #ELSE
        IF( le.Input_fax2 = (TYPEOF(le.Input_fax2))'','',':fax2')
    #END
+    #IF( #TEXT(Input_fax3)='' )
      '' 
    #ELSE
        IF( le.Input_fax3 = (TYPEOF(le.Input_fax3))'','',':fax3')
    #END
+    #IF( #TEXT(Input_other_phone1)='' )
      '' 
    #ELSE
        IF( le.Input_other_phone1 = (TYPEOF(le.Input_other_phone1))'','',':other_phone1')
    #END
+    #IF( #TEXT(Input_description)='' )
      '' 
    #ELSE
        IF( le.Input_description = (TYPEOF(le.Input_description))'','',':description')
    #END
+    #IF( #TEXT(Input_specialty_class_type)='' )
      '' 
    #ELSE
        IF( le.Input_specialty_class_type = (TYPEOF(le.Input_specialty_class_type))'','',':specialty_class_type')
    #END
+    #IF( #TEXT(Input_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_phone_number = (TYPEOF(le.Input_phone_number))'','',':phone_number')
    #END
+    #IF( #TEXT(Input_phone_type)='' )
      '' 
    #ELSE
        IF( le.Input_phone_type = (TYPEOF(le.Input_phone_type))'','',':phone_type')
    #END
+    #IF( #TEXT(Input_language)='' )
      '' 
    #ELSE
        IF( le.Input_language = (TYPEOF(le.Input_language))'','',':language')
    #END
+    #IF( #TEXT(Input_degree)='' )
      '' 
    #ELSE
        IF( le.Input_degree = (TYPEOF(le.Input_degree))'','',':degree')
    #END
+    #IF( #TEXT(Input_graduated)='' )
      '' 
    #ELSE
        IF( le.Input_graduated = (TYPEOF(le.Input_graduated))'','',':graduated')
    #END
+    #IF( #TEXT(Input_school)='' )
      '' 
    #ELSE
        IF( le.Input_school = (TYPEOF(le.Input_school))'','',':school')
    #END
+    #IF( #TEXT(Input_location)='' )
      '' 
    #ELSE
        IF( le.Input_location = (TYPEOF(le.Input_location))'','',':location')
    #END
+    #IF( #TEXT(Input_fine)='' )
      '' 
    #ELSE
        IF( le.Input_fine = (TYPEOF(le.Input_fine))'','',':fine')
    #END
+    #IF( #TEXT(Input_board)='' )
      '' 
    #ELSE
        IF( le.Input_board = (TYPEOF(le.Input_board))'','',':board')
    #END
+    #IF( #TEXT(Input_offense)='' )
      '' 
    #ELSE
        IF( le.Input_offense = (TYPEOF(le.Input_offense))'','',':offense')
    #END
+    #IF( #TEXT(Input_offense_date)='' )
      '' 
    #ELSE
        IF( le.Input_offense_date = (TYPEOF(le.Input_offense_date))'','',':offense_date')
    #END
+    #IF( #TEXT(Input_action)='' )
      '' 
    #ELSE
        IF( le.Input_action = (TYPEOF(le.Input_action))'','',':action')
    #END
+    #IF( #TEXT(Input_action_date)='' )
      '' 
    #ELSE
        IF( le.Input_action_date = (TYPEOF(le.Input_action_date))'','',':action_date')
    #END
+    #IF( #TEXT(Input_action_start)='' )
      '' 
    #ELSE
        IF( le.Input_action_start = (TYPEOF(le.Input_action_start))'','',':action_start')
    #END
+    #IF( #TEXT(Input_action_end)='' )
      '' 
    #ELSE
        IF( le.Input_action_end = (TYPEOF(le.Input_action_end))'','',':action_end')
    #END
+    #IF( #TEXT(Input_npi_number)='' )
      '' 
    #ELSE
        IF( le.Input_npi_number = (TYPEOF(le.Input_npi_number))'','',':npi_number')
    #END
+    #IF( #TEXT(Input_replacement_number)='' )
      '' 
    #ELSE
        IF( le.Input_replacement_number = (TYPEOF(le.Input_replacement_number))'','',':replacement_number')
    #END
+    #IF( #TEXT(Input_enumeration_date)='' )
      '' 
    #ELSE
        IF( le.Input_enumeration_date = (TYPEOF(le.Input_enumeration_date))'','',':enumeration_date')
    #END
+    #IF( #TEXT(Input_last_update_date)='' )
      '' 
    #ELSE
        IF( le.Input_last_update_date = (TYPEOF(le.Input_last_update_date))'','',':last_update_date')
    #END
+    #IF( #TEXT(Input_deactivation_date)='' )
      '' 
    #ELSE
        IF( le.Input_deactivation_date = (TYPEOF(le.Input_deactivation_date))'','',':deactivation_date')
    #END
+    #IF( #TEXT(Input_reactivation_date)='' )
      '' 
    #ELSE
        IF( le.Input_reactivation_date = (TYPEOF(le.Input_reactivation_date))'','',':reactivation_date')
    #END
+    #IF( #TEXT(Input_deactivation_reason)='' )
      '' 
    #ELSE
        IF( le.Input_deactivation_reason = (TYPEOF(le.Input_deactivation_reason))'','',':deactivation_reason')
    #END
+    #IF( #TEXT(Input_csr_number)='' )
      '' 
    #ELSE
        IF( le.Input_csr_number = (TYPEOF(le.Input_csr_number))'','',':csr_number')
    #END
+    #IF( #TEXT(Input_credential_type)='' )
      '' 
    #ELSE
        IF( le.Input_credential_type = (TYPEOF(le.Input_credential_type))'','',':credential_type')
    #END
+    #IF( #TEXT(Input_csr_status)='' )
      '' 
    #ELSE
        IF( le.Input_csr_status = (TYPEOF(le.Input_csr_status))'','',':csr_status')
    #END
+    #IF( #TEXT(Input_sub_status)='' )
      '' 
    #ELSE
        IF( le.Input_sub_status = (TYPEOF(le.Input_sub_status))'','',':sub_status')
    #END
+    #IF( #TEXT(Input_csr_state)='' )
      '' 
    #ELSE
        IF( le.Input_csr_state = (TYPEOF(le.Input_csr_state))'','',':csr_state')
    #END
+    #IF( #TEXT(Input_csr_issue_date)='' )
      '' 
    #ELSE
        IF( le.Input_csr_issue_date = (TYPEOF(le.Input_csr_issue_date))'','',':csr_issue_date')
    #END
+    #IF( #TEXT(Input_effective_date)='' )
      '' 
    #ELSE
        IF( le.Input_effective_date = (TYPEOF(le.Input_effective_date))'','',':effective_date')
    #END
+    #IF( #TEXT(Input_csr_expiration_date)='' )
      '' 
    #ELSE
        IF( le.Input_csr_expiration_date = (TYPEOF(le.Input_csr_expiration_date))'','',':csr_expiration_date')
    #END
+    #IF( #TEXT(Input_discipline)='' )
      '' 
    #ELSE
        IF( le.Input_discipline = (TYPEOF(le.Input_discipline))'','',':discipline')
    #END
+    #IF( #TEXT(Input_all_schedules)='' )
      '' 
    #ELSE
        IF( le.Input_all_schedules = (TYPEOF(le.Input_all_schedules))'','',':all_schedules')
    #END
+    #IF( #TEXT(Input_schedule_1)='' )
      '' 
    #ELSE
        IF( le.Input_schedule_1 = (TYPEOF(le.Input_schedule_1))'','',':schedule_1')
    #END
+    #IF( #TEXT(Input_schedule_2)='' )
      '' 
    #ELSE
        IF( le.Input_schedule_2 = (TYPEOF(le.Input_schedule_2))'','',':schedule_2')
    #END
+    #IF( #TEXT(Input_schedule_2n)='' )
      '' 
    #ELSE
        IF( le.Input_schedule_2n = (TYPEOF(le.Input_schedule_2n))'','',':schedule_2n')
    #END
+    #IF( #TEXT(Input_schedule_3)='' )
      '' 
    #ELSE
        IF( le.Input_schedule_3 = (TYPEOF(le.Input_schedule_3))'','',':schedule_3')
    #END
+    #IF( #TEXT(Input_schedule_3n)='' )
      '' 
    #ELSE
        IF( le.Input_schedule_3n = (TYPEOF(le.Input_schedule_3n))'','',':schedule_3n')
    #END
+    #IF( #TEXT(Input_schedule_4)='' )
      '' 
    #ELSE
        IF( le.Input_schedule_4 = (TYPEOF(le.Input_schedule_4))'','',':schedule_4')
    #END
+    #IF( #TEXT(Input_schedule_5)='' )
      '' 
    #ELSE
        IF( le.Input_schedule_5 = (TYPEOF(le.Input_schedule_5))'','',':schedule_5')
    #END
+    #IF( #TEXT(Input_schedule_6)='' )
      '' 
    #ELSE
        IF( le.Input_schedule_6 = (TYPEOF(le.Input_schedule_6))'','',':schedule_6')
    #END
+    #IF( #TEXT(Input_raw_status)='' )
      '' 
    #ELSE
        IF( le.Input_raw_status = (TYPEOF(le.Input_raw_status))'','',':raw_status')
    #END
+    #IF( #TEXT(Input_raw_sub_status1)='' )
      '' 
    #ELSE
        IF( le.Input_raw_sub_status1 = (TYPEOF(le.Input_raw_sub_status1))'','',':raw_sub_status1')
    #END
+    #IF( #TEXT(Input_raw_sub_status2)='' )
      '' 
    #ELSE
        IF( le.Input_raw_sub_status2 = (TYPEOF(le.Input_raw_sub_status2))'','',':raw_sub_status2')
    #END
+    #IF( #TEXT(Input_dea_number)='' )
      '' 
    #ELSE
        IF( le.Input_dea_number = (TYPEOF(le.Input_dea_number))'','',':dea_number')
    #END
+    #IF( #TEXT(Input_schedules)='' )
      '' 
    #ELSE
        IF( le.Input_schedules = (TYPEOF(le.Input_schedules))'','',':schedules')
    #END
+    #IF( #TEXT(Input_dea_expiration_date)='' )
      '' 
    #ELSE
        IF( le.Input_dea_expiration_date = (TYPEOF(le.Input_dea_expiration_date))'','',':dea_expiration_date')
    #END
+    #IF( #TEXT(Input_activity)='' )
      '' 
    #ELSE
        IF( le.Input_activity = (TYPEOF(le.Input_activity))'','',':activity')
    #END
+    #IF( #TEXT(Input_bac)='' )
      '' 
    #ELSE
        IF( le.Input_bac = (TYPEOF(le.Input_bac))'','',':bac')
    #END
+    #IF( #TEXT(Input_bac_subcode)='' )
      '' 
    #ELSE
        IF( le.Input_bac_subcode = (TYPEOF(le.Input_bac_subcode))'','',':bac_subcode')
    #END
+    #IF( #TEXT(Input_payment)='' )
      '' 
    #ELSE
        IF( le.Input_payment = (TYPEOF(le.Input_payment))'','',':payment')
    #END
+    #IF( #TEXT(Input_medicaid_number)='' )
      '' 
    #ELSE
        IF( le.Input_medicaid_number = (TYPEOF(le.Input_medicaid_number))'','',':medicaid_number')
    #END
+    #IF( #TEXT(Input_medicaid_status)='' )
      '' 
    #ELSE
        IF( le.Input_medicaid_status = (TYPEOF(le.Input_medicaid_status))'','',':medicaid_status')
    #END
+    #IF( #TEXT(Input_medicaid_state)='' )
      '' 
    #ELSE
        IF( le.Input_medicaid_state = (TYPEOF(le.Input_medicaid_state))'','',':medicaid_state')
    #END
+    #IF( #TEXT(Input_participation_flag)='' )
      '' 
    #ELSE
        IF( le.Input_participation_flag = (TYPEOF(le.Input_participation_flag))'','',':participation_flag')
    #END
+    #IF( #TEXT(Input_taxonomy_npi_number)='' )
      '' 
    #ELSE
        IF( le.Input_taxonomy_npi_number = (TYPEOF(le.Input_taxonomy_npi_number))'','',':taxonomy_npi_number')
    #END
+    #IF( #TEXT(Input_taxonomy_code)='' )
      '' 
    #ELSE
        IF( le.Input_taxonomy_code = (TYPEOF(le.Input_taxonomy_code))'','',':taxonomy_code')
    #END
+    #IF( #TEXT(Input_taxonomy_order_number)='' )
      '' 
    #ELSE
        IF( le.Input_taxonomy_order_number = (TYPEOF(le.Input_taxonomy_order_number))'','',':taxonomy_order_number')
    #END
+    #IF( #TEXT(Input_license_number_state_code)='' )
      '' 
    #ELSE
        IF( le.Input_license_number_state_code = (TYPEOF(le.Input_license_number_state_code))'','',':license_number_state_code')
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
