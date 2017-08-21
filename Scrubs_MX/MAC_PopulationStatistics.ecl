EXPORT MAC_PopulationStatistics(infile,Ref='',Input_claim_type = '',Input_claim_num = '',Input_billing_pay_to_taxonomy = '',Input_billing_addr = '',Input_billing_anesth_lic = '',Input_billing_city = '',Input_billing_dentist_lic = '',Input_billing_first_name = '',Input_billing_last_name = '',Input_billing_middle_name = '',Input_billing_npi = '',Input_billing_org_name = '',Input_billing_service_phone = '',Input_billing_specialty_code = '',Input_billing_specialty_lic = '',Input_billing_state = '',Input_billing_state_lic = '',Input_billing_tax_id = '',Input_billing_upin = '',Input_billing_zip = '',Input_diag_code1 = '',Input_diag_code2 = '',Input_diag_code3 = '',Input_diag_code4 = '',Input_diag_code5 = '',Input_diag_code6 = '',Input_diag_code7 = '',Input_diag_code8 = '',Input_dme_hcpcs_proc_code = '',Input_emt_paramedic_first_name = '',Input_emt_paramedic_last_name = '',Input_emt_paramedic_middle_name = '',Input_ext_injury_diag_code = '',Input_facility_lab_addr = '',Input_facility_lab_city = '',Input_facility_lab_name = '',Input_facility_lab_npi = '',Input_facility_lab_state = '',Input_facility_lab_tax_id = '',Input_facility_lab_type_code = '',Input_facility_lab_zip = '',Input_ordering_prov_addr = '',Input_ordering_prov_city = '',Input_ordering_prov_first_name = '',Input_ordering_prov_last_name = '',Input_ordering_prov_middle_name = '',Input_ordering_prov_npi = '',Input_ordering_prov_state = '',Input_ordering_prov_upin = '',Input_ordering_prov_zip = '',Input_pay_to_addr = '',Input_pay_to_city = '',Input_pay_to_first_name = '',Input_pay_to_last_name = '',Input_pay_to_middle_name = '',Input_pay_to_npi = '',Input_pay_to_service_phone = '',Input_pay_to_state = '',Input_pay_to_tax_id = '',Input_pay_to_zip = '',Input_performing_prov_phone = '',Input_performing_prov_specialty = '',Input_performing_prov_tax_id = '',Input_place_of_service_code = '',Input_place_of_service_name = '',Input_prov_a_addr = '',Input_prov_a_city = '',Input_prov_a_service_role_code = '',Input_prov_a_state = '',Input_prov_a_zip = '',Input_prov_b_addr = '',Input_prov_b_city = '',Input_prov_b_service_role_code = '',Input_prov_b_state = '',Input_prov_b_zip = '',Input_prov_c_addr = '',Input_prov_c_city = '',Input_prov_c_service_role_code = '',Input_prov_c_state = '',Input_prov_c_zip = '',Input_purch_service_first_name = '',Input_purch_service_last_name = '',Input_purch_service_middle_name = '',Input_purch_service_npi = '',Input_purch_service_prov_addr = '',Input_purch_service_prov_city = '',Input_purch_service_prov_name = '',Input_purch_service_prov_phone = '',Input_purch_service_prov_state = '',Input_purch_service_prov_zip = '',OutFile) := MACRO
  IMPORT SALT31,Scrubs_MX;
  #uniquename(of)
  %of% := RECORD
    SALT31.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_claim_type)='' )
      '' 
    #ELSE
        IF( le.Input_claim_type = (TYPEOF(le.Input_claim_type))'','',':claim_type')
    #END
+    #IF( #TEXT(Input_claim_num)='' )
      '' 
    #ELSE
        IF( le.Input_claim_num = (TYPEOF(le.Input_claim_num))'','',':claim_num')
    #END
+    #IF( #TEXT(Input_billing_pay_to_taxonomy)='' )
      '' 
    #ELSE
        IF( le.Input_billing_pay_to_taxonomy = (TYPEOF(le.Input_billing_pay_to_taxonomy))'','',':billing_pay_to_taxonomy')
    #END
+    #IF( #TEXT(Input_billing_addr)='' )
      '' 
    #ELSE
        IF( le.Input_billing_addr = (TYPEOF(le.Input_billing_addr))'','',':billing_addr')
    #END
+    #IF( #TEXT(Input_billing_anesth_lic)='' )
      '' 
    #ELSE
        IF( le.Input_billing_anesth_lic = (TYPEOF(le.Input_billing_anesth_lic))'','',':billing_anesth_lic')
    #END
+    #IF( #TEXT(Input_billing_city)='' )
      '' 
    #ELSE
        IF( le.Input_billing_city = (TYPEOF(le.Input_billing_city))'','',':billing_city')
    #END
+    #IF( #TEXT(Input_billing_dentist_lic)='' )
      '' 
    #ELSE
        IF( le.Input_billing_dentist_lic = (TYPEOF(le.Input_billing_dentist_lic))'','',':billing_dentist_lic')
    #END
+    #IF( #TEXT(Input_billing_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_billing_first_name = (TYPEOF(le.Input_billing_first_name))'','',':billing_first_name')
    #END
+    #IF( #TEXT(Input_billing_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_billing_last_name = (TYPEOF(le.Input_billing_last_name))'','',':billing_last_name')
    #END
+    #IF( #TEXT(Input_billing_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_billing_middle_name = (TYPEOF(le.Input_billing_middle_name))'','',':billing_middle_name')
    #END
+    #IF( #TEXT(Input_billing_npi)='' )
      '' 
    #ELSE
        IF( le.Input_billing_npi = (TYPEOF(le.Input_billing_npi))'','',':billing_npi')
    #END
+    #IF( #TEXT(Input_billing_org_name)='' )
      '' 
    #ELSE
        IF( le.Input_billing_org_name = (TYPEOF(le.Input_billing_org_name))'','',':billing_org_name')
    #END
+    #IF( #TEXT(Input_billing_service_phone)='' )
      '' 
    #ELSE
        IF( le.Input_billing_service_phone = (TYPEOF(le.Input_billing_service_phone))'','',':billing_service_phone')
    #END
+    #IF( #TEXT(Input_billing_specialty_code)='' )
      '' 
    #ELSE
        IF( le.Input_billing_specialty_code = (TYPEOF(le.Input_billing_specialty_code))'','',':billing_specialty_code')
    #END
+    #IF( #TEXT(Input_billing_specialty_lic)='' )
      '' 
    #ELSE
        IF( le.Input_billing_specialty_lic = (TYPEOF(le.Input_billing_specialty_lic))'','',':billing_specialty_lic')
    #END
+    #IF( #TEXT(Input_billing_state)='' )
      '' 
    #ELSE
        IF( le.Input_billing_state = (TYPEOF(le.Input_billing_state))'','',':billing_state')
    #END
+    #IF( #TEXT(Input_billing_state_lic)='' )
      '' 
    #ELSE
        IF( le.Input_billing_state_lic = (TYPEOF(le.Input_billing_state_lic))'','',':billing_state_lic')
    #END
+    #IF( #TEXT(Input_billing_tax_id)='' )
      '' 
    #ELSE
        IF( le.Input_billing_tax_id = (TYPEOF(le.Input_billing_tax_id))'','',':billing_tax_id')
    #END
+    #IF( #TEXT(Input_billing_upin)='' )
      '' 
    #ELSE
        IF( le.Input_billing_upin = (TYPEOF(le.Input_billing_upin))'','',':billing_upin')
    #END
+    #IF( #TEXT(Input_billing_zip)='' )
      '' 
    #ELSE
        IF( le.Input_billing_zip = (TYPEOF(le.Input_billing_zip))'','',':billing_zip')
    #END
+    #IF( #TEXT(Input_diag_code1)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code1 = (TYPEOF(le.Input_diag_code1))'','',':diag_code1')
    #END
+    #IF( #TEXT(Input_diag_code2)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code2 = (TYPEOF(le.Input_diag_code2))'','',':diag_code2')
    #END
+    #IF( #TEXT(Input_diag_code3)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code3 = (TYPEOF(le.Input_diag_code3))'','',':diag_code3')
    #END
+    #IF( #TEXT(Input_diag_code4)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code4 = (TYPEOF(le.Input_diag_code4))'','',':diag_code4')
    #END
+    #IF( #TEXT(Input_diag_code5)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code5 = (TYPEOF(le.Input_diag_code5))'','',':diag_code5')
    #END
+    #IF( #TEXT(Input_diag_code6)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code6 = (TYPEOF(le.Input_diag_code6))'','',':diag_code6')
    #END
+    #IF( #TEXT(Input_diag_code7)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code7 = (TYPEOF(le.Input_diag_code7))'','',':diag_code7')
    #END
+    #IF( #TEXT(Input_diag_code8)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code8 = (TYPEOF(le.Input_diag_code8))'','',':diag_code8')
    #END
+    #IF( #TEXT(Input_dme_hcpcs_proc_code)='' )
      '' 
    #ELSE
        IF( le.Input_dme_hcpcs_proc_code = (TYPEOF(le.Input_dme_hcpcs_proc_code))'','',':dme_hcpcs_proc_code')
    #END
+    #IF( #TEXT(Input_emt_paramedic_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_emt_paramedic_first_name = (TYPEOF(le.Input_emt_paramedic_first_name))'','',':emt_paramedic_first_name')
    #END
+    #IF( #TEXT(Input_emt_paramedic_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_emt_paramedic_last_name = (TYPEOF(le.Input_emt_paramedic_last_name))'','',':emt_paramedic_last_name')
    #END
+    #IF( #TEXT(Input_emt_paramedic_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_emt_paramedic_middle_name = (TYPEOF(le.Input_emt_paramedic_middle_name))'','',':emt_paramedic_middle_name')
    #END
+    #IF( #TEXT(Input_ext_injury_diag_code)='' )
      '' 
    #ELSE
        IF( le.Input_ext_injury_diag_code = (TYPEOF(le.Input_ext_injury_diag_code))'','',':ext_injury_diag_code')
    #END
+    #IF( #TEXT(Input_facility_lab_addr)='' )
      '' 
    #ELSE
        IF( le.Input_facility_lab_addr = (TYPEOF(le.Input_facility_lab_addr))'','',':facility_lab_addr')
    #END
+    #IF( #TEXT(Input_facility_lab_city)='' )
      '' 
    #ELSE
        IF( le.Input_facility_lab_city = (TYPEOF(le.Input_facility_lab_city))'','',':facility_lab_city')
    #END
+    #IF( #TEXT(Input_facility_lab_name)='' )
      '' 
    #ELSE
        IF( le.Input_facility_lab_name = (TYPEOF(le.Input_facility_lab_name))'','',':facility_lab_name')
    #END
+    #IF( #TEXT(Input_facility_lab_npi)='' )
      '' 
    #ELSE
        IF( le.Input_facility_lab_npi = (TYPEOF(le.Input_facility_lab_npi))'','',':facility_lab_npi')
    #END
+    #IF( #TEXT(Input_facility_lab_state)='' )
      '' 
    #ELSE
        IF( le.Input_facility_lab_state = (TYPEOF(le.Input_facility_lab_state))'','',':facility_lab_state')
    #END
+    #IF( #TEXT(Input_facility_lab_tax_id)='' )
      '' 
    #ELSE
        IF( le.Input_facility_lab_tax_id = (TYPEOF(le.Input_facility_lab_tax_id))'','',':facility_lab_tax_id')
    #END
+    #IF( #TEXT(Input_facility_lab_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_facility_lab_type_code = (TYPEOF(le.Input_facility_lab_type_code))'','',':facility_lab_type_code')
    #END
+    #IF( #TEXT(Input_facility_lab_zip)='' )
      '' 
    #ELSE
        IF( le.Input_facility_lab_zip = (TYPEOF(le.Input_facility_lab_zip))'','',':facility_lab_zip')
    #END
+    #IF( #TEXT(Input_ordering_prov_addr)='' )
      '' 
    #ELSE
        IF( le.Input_ordering_prov_addr = (TYPEOF(le.Input_ordering_prov_addr))'','',':ordering_prov_addr')
    #END
+    #IF( #TEXT(Input_ordering_prov_city)='' )
      '' 
    #ELSE
        IF( le.Input_ordering_prov_city = (TYPEOF(le.Input_ordering_prov_city))'','',':ordering_prov_city')
    #END
+    #IF( #TEXT(Input_ordering_prov_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_ordering_prov_first_name = (TYPEOF(le.Input_ordering_prov_first_name))'','',':ordering_prov_first_name')
    #END
+    #IF( #TEXT(Input_ordering_prov_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_ordering_prov_last_name = (TYPEOF(le.Input_ordering_prov_last_name))'','',':ordering_prov_last_name')
    #END
+    #IF( #TEXT(Input_ordering_prov_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_ordering_prov_middle_name = (TYPEOF(le.Input_ordering_prov_middle_name))'','',':ordering_prov_middle_name')
    #END
+    #IF( #TEXT(Input_ordering_prov_npi)='' )
      '' 
    #ELSE
        IF( le.Input_ordering_prov_npi = (TYPEOF(le.Input_ordering_prov_npi))'','',':ordering_prov_npi')
    #END
+    #IF( #TEXT(Input_ordering_prov_state)='' )
      '' 
    #ELSE
        IF( le.Input_ordering_prov_state = (TYPEOF(le.Input_ordering_prov_state))'','',':ordering_prov_state')
    #END
+    #IF( #TEXT(Input_ordering_prov_upin)='' )
      '' 
    #ELSE
        IF( le.Input_ordering_prov_upin = (TYPEOF(le.Input_ordering_prov_upin))'','',':ordering_prov_upin')
    #END
+    #IF( #TEXT(Input_ordering_prov_zip)='' )
      '' 
    #ELSE
        IF( le.Input_ordering_prov_zip = (TYPEOF(le.Input_ordering_prov_zip))'','',':ordering_prov_zip')
    #END
+    #IF( #TEXT(Input_pay_to_addr)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_addr = (TYPEOF(le.Input_pay_to_addr))'','',':pay_to_addr')
    #END
+    #IF( #TEXT(Input_pay_to_city)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_city = (TYPEOF(le.Input_pay_to_city))'','',':pay_to_city')
    #END
+    #IF( #TEXT(Input_pay_to_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_first_name = (TYPEOF(le.Input_pay_to_first_name))'','',':pay_to_first_name')
    #END
+    #IF( #TEXT(Input_pay_to_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_last_name = (TYPEOF(le.Input_pay_to_last_name))'','',':pay_to_last_name')
    #END
+    #IF( #TEXT(Input_pay_to_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_middle_name = (TYPEOF(le.Input_pay_to_middle_name))'','',':pay_to_middle_name')
    #END
+    #IF( #TEXT(Input_pay_to_npi)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_npi = (TYPEOF(le.Input_pay_to_npi))'','',':pay_to_npi')
    #END
+    #IF( #TEXT(Input_pay_to_service_phone)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_service_phone = (TYPEOF(le.Input_pay_to_service_phone))'','',':pay_to_service_phone')
    #END
+    #IF( #TEXT(Input_pay_to_state)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_state = (TYPEOF(le.Input_pay_to_state))'','',':pay_to_state')
    #END
+    #IF( #TEXT(Input_pay_to_tax_id)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_tax_id = (TYPEOF(le.Input_pay_to_tax_id))'','',':pay_to_tax_id')
    #END
+    #IF( #TEXT(Input_pay_to_zip)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_zip = (TYPEOF(le.Input_pay_to_zip))'','',':pay_to_zip')
    #END
+    #IF( #TEXT(Input_performing_prov_phone)='' )
      '' 
    #ELSE
        IF( le.Input_performing_prov_phone = (TYPEOF(le.Input_performing_prov_phone))'','',':performing_prov_phone')
    #END
+    #IF( #TEXT(Input_performing_prov_specialty)='' )
      '' 
    #ELSE
        IF( le.Input_performing_prov_specialty = (TYPEOF(le.Input_performing_prov_specialty))'','',':performing_prov_specialty')
    #END
+    #IF( #TEXT(Input_performing_prov_tax_id)='' )
      '' 
    #ELSE
        IF( le.Input_performing_prov_tax_id = (TYPEOF(le.Input_performing_prov_tax_id))'','',':performing_prov_tax_id')
    #END
+    #IF( #TEXT(Input_place_of_service_code)='' )
      '' 
    #ELSE
        IF( le.Input_place_of_service_code = (TYPEOF(le.Input_place_of_service_code))'','',':place_of_service_code')
    #END
+    #IF( #TEXT(Input_place_of_service_name)='' )
      '' 
    #ELSE
        IF( le.Input_place_of_service_name = (TYPEOF(le.Input_place_of_service_name))'','',':place_of_service_name')
    #END
+    #IF( #TEXT(Input_prov_a_addr)='' )
      '' 
    #ELSE
        IF( le.Input_prov_a_addr = (TYPEOF(le.Input_prov_a_addr))'','',':prov_a_addr')
    #END
+    #IF( #TEXT(Input_prov_a_city)='' )
      '' 
    #ELSE
        IF( le.Input_prov_a_city = (TYPEOF(le.Input_prov_a_city))'','',':prov_a_city')
    #END
+    #IF( #TEXT(Input_prov_a_service_role_code)='' )
      '' 
    #ELSE
        IF( le.Input_prov_a_service_role_code = (TYPEOF(le.Input_prov_a_service_role_code))'','',':prov_a_service_role_code')
    #END
+    #IF( #TEXT(Input_prov_a_state)='' )
      '' 
    #ELSE
        IF( le.Input_prov_a_state = (TYPEOF(le.Input_prov_a_state))'','',':prov_a_state')
    #END
+    #IF( #TEXT(Input_prov_a_zip)='' )
      '' 
    #ELSE
        IF( le.Input_prov_a_zip = (TYPEOF(le.Input_prov_a_zip))'','',':prov_a_zip')
    #END
+    #IF( #TEXT(Input_prov_b_addr)='' )
      '' 
    #ELSE
        IF( le.Input_prov_b_addr = (TYPEOF(le.Input_prov_b_addr))'','',':prov_b_addr')
    #END
+    #IF( #TEXT(Input_prov_b_city)='' )
      '' 
    #ELSE
        IF( le.Input_prov_b_city = (TYPEOF(le.Input_prov_b_city))'','',':prov_b_city')
    #END
+    #IF( #TEXT(Input_prov_b_service_role_code)='' )
      '' 
    #ELSE
        IF( le.Input_prov_b_service_role_code = (TYPEOF(le.Input_prov_b_service_role_code))'','',':prov_b_service_role_code')
    #END
+    #IF( #TEXT(Input_prov_b_state)='' )
      '' 
    #ELSE
        IF( le.Input_prov_b_state = (TYPEOF(le.Input_prov_b_state))'','',':prov_b_state')
    #END
+    #IF( #TEXT(Input_prov_b_zip)='' )
      '' 
    #ELSE
        IF( le.Input_prov_b_zip = (TYPEOF(le.Input_prov_b_zip))'','',':prov_b_zip')
    #END
+    #IF( #TEXT(Input_prov_c_addr)='' )
      '' 
    #ELSE
        IF( le.Input_prov_c_addr = (TYPEOF(le.Input_prov_c_addr))'','',':prov_c_addr')
    #END
+    #IF( #TEXT(Input_prov_c_city)='' )
      '' 
    #ELSE
        IF( le.Input_prov_c_city = (TYPEOF(le.Input_prov_c_city))'','',':prov_c_city')
    #END
+    #IF( #TEXT(Input_prov_c_service_role_code)='' )
      '' 
    #ELSE
        IF( le.Input_prov_c_service_role_code = (TYPEOF(le.Input_prov_c_service_role_code))'','',':prov_c_service_role_code')
    #END
+    #IF( #TEXT(Input_prov_c_state)='' )
      '' 
    #ELSE
        IF( le.Input_prov_c_state = (TYPEOF(le.Input_prov_c_state))'','',':prov_c_state')
    #END
+    #IF( #TEXT(Input_prov_c_zip)='' )
      '' 
    #ELSE
        IF( le.Input_prov_c_zip = (TYPEOF(le.Input_prov_c_zip))'','',':prov_c_zip')
    #END
+    #IF( #TEXT(Input_purch_service_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_purch_service_first_name = (TYPEOF(le.Input_purch_service_first_name))'','',':purch_service_first_name')
    #END
+    #IF( #TEXT(Input_purch_service_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_purch_service_last_name = (TYPEOF(le.Input_purch_service_last_name))'','',':purch_service_last_name')
    #END
+    #IF( #TEXT(Input_purch_service_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_purch_service_middle_name = (TYPEOF(le.Input_purch_service_middle_name))'','',':purch_service_middle_name')
    #END
+    #IF( #TEXT(Input_purch_service_npi)='' )
      '' 
    #ELSE
        IF( le.Input_purch_service_npi = (TYPEOF(le.Input_purch_service_npi))'','',':purch_service_npi')
    #END
+    #IF( #TEXT(Input_purch_service_prov_addr)='' )
      '' 
    #ELSE
        IF( le.Input_purch_service_prov_addr = (TYPEOF(le.Input_purch_service_prov_addr))'','',':purch_service_prov_addr')
    #END
+    #IF( #TEXT(Input_purch_service_prov_city)='' )
      '' 
    #ELSE
        IF( le.Input_purch_service_prov_city = (TYPEOF(le.Input_purch_service_prov_city))'','',':purch_service_prov_city')
    #END
+    #IF( #TEXT(Input_purch_service_prov_name)='' )
      '' 
    #ELSE
        IF( le.Input_purch_service_prov_name = (TYPEOF(le.Input_purch_service_prov_name))'','',':purch_service_prov_name')
    #END
+    #IF( #TEXT(Input_purch_service_prov_phone)='' )
      '' 
    #ELSE
        IF( le.Input_purch_service_prov_phone = (TYPEOF(le.Input_purch_service_prov_phone))'','',':purch_service_prov_phone')
    #END
+    #IF( #TEXT(Input_purch_service_prov_state)='' )
      '' 
    #ELSE
        IF( le.Input_purch_service_prov_state = (TYPEOF(le.Input_purch_service_prov_state))'','',':purch_service_prov_state')
    #END
+    #IF( #TEXT(Input_purch_service_prov_zip)='' )
      '' 
    #ELSE
        IF( le.Input_purch_service_prov_zip = (TYPEOF(le.Input_purch_service_prov_zip))'','',':purch_service_prov_zip')
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
