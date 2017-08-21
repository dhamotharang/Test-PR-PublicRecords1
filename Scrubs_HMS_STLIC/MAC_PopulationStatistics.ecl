EXPORT MAC_PopulationStatistics(infile,Ref='',Input_ln_key = '',Input_hms_src = '',Input_key = '',Input_id = '',Input_entityid = '',Input_license_number = '',Input_license_class_type = '',Input_license_state = '',Input_status = '',Input_issue_date = '',Input_expiration_date = '',Input_qualifier1 = '',Input_qualifier2 = '',Input_qualifier3 = '',Input_qualifier4 = '',Input_qualifier5 = '',Input_rawclass = '',Input_rawissue_date = '',Input_rawexpiration_date = '',Input_rawstatus = '',Input_raw_number = '',Input_name = '',Input_first = '',Input_middle = '',Input_last = '',Input_suffix = '',Input_cred = '',Input_age = '',Input_dateofbirth = '',Input_email = '',Input_gender = '',Input_dateofdeath = '',Input_firmname = '',Input_street1 = '',Input_street2 = '',Input_street3 = '',Input_city = '',Input_address_state = '',Input_orig_zip = '',Input_orig_county = '',Input_country = '',Input_address_type = '',Input_phone1 = '',Input_phone2 = '',Input_phone3 = '',Input_fax1 = '',Input_fax2 = '',Input_fax3 = '',Input_other_phone1 = '',Input_description = '',Input_specialty_class_type = '',Input_phone_number = '',Input_phone_type = '',Input_language = '',Input_graduated = '',Input_school = '',Input_location = '',Input_board = '',Input_offense = '',Input_offense_date = '',Input_action = '',Input_action_date = '',Input_action_start = '',Input_action_end = '',Input_npi_number = '',Input_csr_number = '',Input_dea_number = '',Input_prepped_addr1 = '',Input_prepped_addr2 = '',Input_clean_phone = '',Input_clean_phone1 = '',Input_clean_phone2 = '',Input_clean_phone3 = '',Input_clean_fax1 = '',Input_clean_fax2 = '',Input_clean_fax3 = '',Input_clean_other_phone1 = '',Input_clean_dateofbirth = '',Input_clean_dateofdeath = '',Input_clean_company_name = '',Input_clean_issue_date = '',Input_clean_expiration_date = '',Input_clean_offense_date = '',Input_clean_action_date = '',Input_src = '',Input_zip = '',Input_zip4 = '',Input_bdid = '',Input_bdid_score = '',Input_lnpid = '',Input_did = '',Input_did_score = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_in_state = '',Input_in_class = '',Input_in_status = '',Input_in_qualifier1 = '',Input_in_qualifier2 = '',Input_mapped_class = '',Input_mapped_status = '',Input_mapped_qualifier1 = '',Input_mapped_qualifier2 = '',Input_mapped_pdma = '',Input_mapped_pract_type = '',Input_source_code = '',Input_taxonomy_code = '',OutFile) := MACRO
  IMPORT SALT31,Scrubs_HMS_STLIC;
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
+    #IF( #TEXT(Input_csr_number)='' )
      '' 
    #ELSE
        IF( le.Input_csr_number = (TYPEOF(le.Input_csr_number))'','',':csr_number')
    #END
+    #IF( #TEXT(Input_dea_number)='' )
      '' 
    #ELSE
        IF( le.Input_dea_number = (TYPEOF(le.Input_dea_number))'','',':dea_number')
    #END
+    #IF( #TEXT(Input_prepped_addr1)='' )
      '' 
    #ELSE
        IF( le.Input_prepped_addr1 = (TYPEOF(le.Input_prepped_addr1))'','',':prepped_addr1')
    #END
+    #IF( #TEXT(Input_prepped_addr2)='' )
      '' 
    #ELSE
        IF( le.Input_prepped_addr2 = (TYPEOF(le.Input_prepped_addr2))'','',':prepped_addr2')
    #END
+    #IF( #TEXT(Input_clean_phone)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phone = (TYPEOF(le.Input_clean_phone))'','',':clean_phone')
    #END
+    #IF( #TEXT(Input_clean_phone1)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phone1 = (TYPEOF(le.Input_clean_phone1))'','',':clean_phone1')
    #END
+    #IF( #TEXT(Input_clean_phone2)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phone2 = (TYPEOF(le.Input_clean_phone2))'','',':clean_phone2')
    #END
+    #IF( #TEXT(Input_clean_phone3)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phone3 = (TYPEOF(le.Input_clean_phone3))'','',':clean_phone3')
    #END
+    #IF( #TEXT(Input_clean_fax1)='' )
      '' 
    #ELSE
        IF( le.Input_clean_fax1 = (TYPEOF(le.Input_clean_fax1))'','',':clean_fax1')
    #END
+    #IF( #TEXT(Input_clean_fax2)='' )
      '' 
    #ELSE
        IF( le.Input_clean_fax2 = (TYPEOF(le.Input_clean_fax2))'','',':clean_fax2')
    #END
+    #IF( #TEXT(Input_clean_fax3)='' )
      '' 
    #ELSE
        IF( le.Input_clean_fax3 = (TYPEOF(le.Input_clean_fax3))'','',':clean_fax3')
    #END
+    #IF( #TEXT(Input_clean_other_phone1)='' )
      '' 
    #ELSE
        IF( le.Input_clean_other_phone1 = (TYPEOF(le.Input_clean_other_phone1))'','',':clean_other_phone1')
    #END
+    #IF( #TEXT(Input_clean_dateofbirth)='' )
      '' 
    #ELSE
        IF( le.Input_clean_dateofbirth = (TYPEOF(le.Input_clean_dateofbirth))'','',':clean_dateofbirth')
    #END
+    #IF( #TEXT(Input_clean_dateofdeath)='' )
      '' 
    #ELSE
        IF( le.Input_clean_dateofdeath = (TYPEOF(le.Input_clean_dateofdeath))'','',':clean_dateofdeath')
    #END
+    #IF( #TEXT(Input_clean_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_company_name = (TYPEOF(le.Input_clean_company_name))'','',':clean_company_name')
    #END
+    #IF( #TEXT(Input_clean_issue_date)='' )
      '' 
    #ELSE
        IF( le.Input_clean_issue_date = (TYPEOF(le.Input_clean_issue_date))'','',':clean_issue_date')
    #END
+    #IF( #TEXT(Input_clean_expiration_date)='' )
      '' 
    #ELSE
        IF( le.Input_clean_expiration_date = (TYPEOF(le.Input_clean_expiration_date))'','',':clean_expiration_date')
    #END
+    #IF( #TEXT(Input_clean_offense_date)='' )
      '' 
    #ELSE
        IF( le.Input_clean_offense_date = (TYPEOF(le.Input_clean_offense_date))'','',':clean_offense_date')
    #END
+    #IF( #TEXT(Input_clean_action_date)='' )
      '' 
    #ELSE
        IF( le.Input_clean_action_date = (TYPEOF(le.Input_clean_action_date))'','',':clean_action_date')
    #END
+    #IF( #TEXT(Input_src)='' )
      '' 
    #ELSE
        IF( le.Input_src = (TYPEOF(le.Input_src))'','',':src')
    #END
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
+    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
+    #IF( #TEXT(Input_bdid_score)='' )
      '' 
    #ELSE
        IF( le.Input_bdid_score = (TYPEOF(le.Input_bdid_score))'','',':bdid_score')
    #END
+    #IF( #TEXT(Input_lnpid)='' )
      '' 
    #ELSE
        IF( le.Input_lnpid = (TYPEOF(le.Input_lnpid))'','',':lnpid')
    #END
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
+    #IF( #TEXT(Input_did_score)='' )
      '' 
    #ELSE
        IF( le.Input_did_score = (TYPEOF(le.Input_did_score))'','',':did_score')
    #END
+    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_first_reported = (TYPEOF(le.Input_dt_vendor_first_reported))'','',':dt_vendor_first_reported')
    #END
+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_last_reported = (TYPEOF(le.Input_dt_vendor_last_reported))'','',':dt_vendor_last_reported')
    #END
+    #IF( #TEXT(Input_in_state)='' )
      '' 
    #ELSE
        IF( le.Input_in_state = (TYPEOF(le.Input_in_state))'','',':in_state')
    #END
+    #IF( #TEXT(Input_in_class)='' )
      '' 
    #ELSE
        IF( le.Input_in_class = (TYPEOF(le.Input_in_class))'','',':in_class')
    #END
+    #IF( #TEXT(Input_in_status)='' )
      '' 
    #ELSE
        IF( le.Input_in_status = (TYPEOF(le.Input_in_status))'','',':in_status')
    #END
+    #IF( #TEXT(Input_in_qualifier1)='' )
      '' 
    #ELSE
        IF( le.Input_in_qualifier1 = (TYPEOF(le.Input_in_qualifier1))'','',':in_qualifier1')
    #END
+    #IF( #TEXT(Input_in_qualifier2)='' )
      '' 
    #ELSE
        IF( le.Input_in_qualifier2 = (TYPEOF(le.Input_in_qualifier2))'','',':in_qualifier2')
    #END
+    #IF( #TEXT(Input_mapped_class)='' )
      '' 
    #ELSE
        IF( le.Input_mapped_class = (TYPEOF(le.Input_mapped_class))'','',':mapped_class')
    #END
+    #IF( #TEXT(Input_mapped_status)='' )
      '' 
    #ELSE
        IF( le.Input_mapped_status = (TYPEOF(le.Input_mapped_status))'','',':mapped_status')
    #END
+    #IF( #TEXT(Input_mapped_qualifier1)='' )
      '' 
    #ELSE
        IF( le.Input_mapped_qualifier1 = (TYPEOF(le.Input_mapped_qualifier1))'','',':mapped_qualifier1')
    #END
+    #IF( #TEXT(Input_mapped_qualifier2)='' )
      '' 
    #ELSE
        IF( le.Input_mapped_qualifier2 = (TYPEOF(le.Input_mapped_qualifier2))'','',':mapped_qualifier2')
    #END
+    #IF( #TEXT(Input_mapped_pdma)='' )
      '' 
    #ELSE
        IF( le.Input_mapped_pdma = (TYPEOF(le.Input_mapped_pdma))'','',':mapped_pdma')
    #END
+    #IF( #TEXT(Input_mapped_pract_type)='' )
      '' 
    #ELSE
        IF( le.Input_mapped_pract_type = (TYPEOF(le.Input_mapped_pract_type))'','',':mapped_pract_type')
    #END
+    #IF( #TEXT(Input_source_code)='' )
      '' 
    #ELSE
        IF( le.Input_source_code = (TYPEOF(le.Input_source_code))'','',':source_code')
    #END
+    #IF( #TEXT(Input_taxonomy_code)='' )
      '' 
    #ELSE
        IF( le.Input_taxonomy_code = (TYPEOF(le.Input_taxonomy_code))'','',':taxonomy_code')
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
