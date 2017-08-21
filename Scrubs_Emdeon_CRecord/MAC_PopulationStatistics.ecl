EXPORT MAC_PopulationStatistics(infile,Ref='',Input_claim_num = '',Input_claim_rec_type = '',Input_payer_id = '',Input_form_type = '',Input_received_date = '',Input_claim_type = '',Input_adjustment_code = '',Input_prev_claim_number = '',Input_sub_client_id = '',Input_group_name = '',Input_member_id = '',Input_member_fname = '',Input_member_lname = '',Input_member_gender = '',Input_member_dob = '',Input_member_address1 = '',Input_member_address2 = '',Input_member_city = '',Input_member_state = '',Input_member_zip = '',Input_patient_id = '',Input_patient_relation = '',Input_patient_fname = '',Input_patient_lname = '',Input_patient_gender = '',Input_patient_dob = '',Input_patient_age = '',Input_billing_id = '',Input_billing_npi = '',Input_billing_name1 = '',Input_billing_name2 = '',Input_billing_address1 = '',Input_billing_address2 = '',Input_billing_city = '',Input_billing_state = '',Input_billing_zip = '',Input_referring_id = '',Input_referring_npi = '',Input_referring_name1 = '',Input_referring_name2 = '',Input_attending_id = '',Input_attending_npi = '',Input_attending_name1 = '',Input_attending_name2 = '',Input_facility_id = '',Input_facility_name1 = '',Input_facility_name2 = '',Input_facility_address1 = '',Input_facility_address2 = '',Input_facility_city = '',Input_facility_state = '',Input_facility_zip = '',Input_statement_from = '',Input_statement_to = '',Input_total_charge = '',Input_total_allowed = '',Input_drg_code = '',Input_patient_control = '',Input_bill_type = '',Input_release_sign = '',Input_assignment_sign = '',Input_in_out_network = '',Input_principal_proc = '',Input_admit_diag = '',Input_primary_diag = '',Input_diag_code2 = '',Input_diag_code3 = '',Input_diag_code4 = '',Input_diag_code5 = '',Input_diag_code6 = '',Input_diag_code7 = '',Input_diag_code8 = '',Input_other_proc = '',Input_other_proc3 = '',Input_other_proc4 = '',Input_other_proc5 = '',Input_other_proc6 = '',Input_prov_specialty = '',Input_coverage_type = '',Input_explanation_code = '',Input_accident_related = '',Input_esrd_patient = '',Input_hosp_admit_or_er = '',Input_amb_nurse_to_hosp = '',Input_non_covered_specialty = '',Input_electronic_claim = '',Input_dialysis_related = '',Input_new_patient = '',Input_init_proc = '',Input_amb_nurse_to_diag = '',OutFile) := MACRO
  IMPORT SALT31,Scrubs_Emdeon_CRecord;
  #uniquename(of)
  %of% := RECORD
    SALT31.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_claim_num)='' )
      '' 
    #ELSE
        IF( le.Input_claim_num = (TYPEOF(le.Input_claim_num))'','',':claim_num')
    #END
+    #IF( #TEXT(Input_claim_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_claim_rec_type = (TYPEOF(le.Input_claim_rec_type))'','',':claim_rec_type')
    #END
+    #IF( #TEXT(Input_payer_id)='' )
      '' 
    #ELSE
        IF( le.Input_payer_id = (TYPEOF(le.Input_payer_id))'','',':payer_id')
    #END
+    #IF( #TEXT(Input_form_type)='' )
      '' 
    #ELSE
        IF( le.Input_form_type = (TYPEOF(le.Input_form_type))'','',':form_type')
    #END
+    #IF( #TEXT(Input_received_date)='' )
      '' 
    #ELSE
        IF( le.Input_received_date = (TYPEOF(le.Input_received_date))'','',':received_date')
    #END
+    #IF( #TEXT(Input_claim_type)='' )
      '' 
    #ELSE
        IF( le.Input_claim_type = (TYPEOF(le.Input_claim_type))'','',':claim_type')
    #END
+    #IF( #TEXT(Input_adjustment_code)='' )
      '' 
    #ELSE
        IF( le.Input_adjustment_code = (TYPEOF(le.Input_adjustment_code))'','',':adjustment_code')
    #END
+    #IF( #TEXT(Input_prev_claim_number)='' )
      '' 
    #ELSE
        IF( le.Input_prev_claim_number = (TYPEOF(le.Input_prev_claim_number))'','',':prev_claim_number')
    #END
+    #IF( #TEXT(Input_sub_client_id)='' )
      '' 
    #ELSE
        IF( le.Input_sub_client_id = (TYPEOF(le.Input_sub_client_id))'','',':sub_client_id')
    #END
+    #IF( #TEXT(Input_group_name)='' )
      '' 
    #ELSE
        IF( le.Input_group_name = (TYPEOF(le.Input_group_name))'','',':group_name')
    #END
+    #IF( #TEXT(Input_member_id)='' )
      '' 
    #ELSE
        IF( le.Input_member_id = (TYPEOF(le.Input_member_id))'','',':member_id')
    #END
+    #IF( #TEXT(Input_member_fname)='' )
      '' 
    #ELSE
        IF( le.Input_member_fname = (TYPEOF(le.Input_member_fname))'','',':member_fname')
    #END
+    #IF( #TEXT(Input_member_lname)='' )
      '' 
    #ELSE
        IF( le.Input_member_lname = (TYPEOF(le.Input_member_lname))'','',':member_lname')
    #END
+    #IF( #TEXT(Input_member_gender)='' )
      '' 
    #ELSE
        IF( le.Input_member_gender = (TYPEOF(le.Input_member_gender))'','',':member_gender')
    #END
+    #IF( #TEXT(Input_member_dob)='' )
      '' 
    #ELSE
        IF( le.Input_member_dob = (TYPEOF(le.Input_member_dob))'','',':member_dob')
    #END
+    #IF( #TEXT(Input_member_address1)='' )
      '' 
    #ELSE
        IF( le.Input_member_address1 = (TYPEOF(le.Input_member_address1))'','',':member_address1')
    #END
+    #IF( #TEXT(Input_member_address2)='' )
      '' 
    #ELSE
        IF( le.Input_member_address2 = (TYPEOF(le.Input_member_address2))'','',':member_address2')
    #END
+    #IF( #TEXT(Input_member_city)='' )
      '' 
    #ELSE
        IF( le.Input_member_city = (TYPEOF(le.Input_member_city))'','',':member_city')
    #END
+    #IF( #TEXT(Input_member_state)='' )
      '' 
    #ELSE
        IF( le.Input_member_state = (TYPEOF(le.Input_member_state))'','',':member_state')
    #END
+    #IF( #TEXT(Input_member_zip)='' )
      '' 
    #ELSE
        IF( le.Input_member_zip = (TYPEOF(le.Input_member_zip))'','',':member_zip')
    #END
+    #IF( #TEXT(Input_patient_id)='' )
      '' 
    #ELSE
        IF( le.Input_patient_id = (TYPEOF(le.Input_patient_id))'','',':patient_id')
    #END
+    #IF( #TEXT(Input_patient_relation)='' )
      '' 
    #ELSE
        IF( le.Input_patient_relation = (TYPEOF(le.Input_patient_relation))'','',':patient_relation')
    #END
+    #IF( #TEXT(Input_patient_fname)='' )
      '' 
    #ELSE
        IF( le.Input_patient_fname = (TYPEOF(le.Input_patient_fname))'','',':patient_fname')
    #END
+    #IF( #TEXT(Input_patient_lname)='' )
      '' 
    #ELSE
        IF( le.Input_patient_lname = (TYPEOF(le.Input_patient_lname))'','',':patient_lname')
    #END
+    #IF( #TEXT(Input_patient_gender)='' )
      '' 
    #ELSE
        IF( le.Input_patient_gender = (TYPEOF(le.Input_patient_gender))'','',':patient_gender')
    #END
+    #IF( #TEXT(Input_patient_dob)='' )
      '' 
    #ELSE
        IF( le.Input_patient_dob = (TYPEOF(le.Input_patient_dob))'','',':patient_dob')
    #END
+    #IF( #TEXT(Input_patient_age)='' )
      '' 
    #ELSE
        IF( le.Input_patient_age = (TYPEOF(le.Input_patient_age))'','',':patient_age')
    #END
+    #IF( #TEXT(Input_billing_id)='' )
      '' 
    #ELSE
        IF( le.Input_billing_id = (TYPEOF(le.Input_billing_id))'','',':billing_id')
    #END
+    #IF( #TEXT(Input_billing_npi)='' )
      '' 
    #ELSE
        IF( le.Input_billing_npi = (TYPEOF(le.Input_billing_npi))'','',':billing_npi')
    #END
+    #IF( #TEXT(Input_billing_name1)='' )
      '' 
    #ELSE
        IF( le.Input_billing_name1 = (TYPEOF(le.Input_billing_name1))'','',':billing_name1')
    #END
+    #IF( #TEXT(Input_billing_name2)='' )
      '' 
    #ELSE
        IF( le.Input_billing_name2 = (TYPEOF(le.Input_billing_name2))'','',':billing_name2')
    #END
+    #IF( #TEXT(Input_billing_address1)='' )
      '' 
    #ELSE
        IF( le.Input_billing_address1 = (TYPEOF(le.Input_billing_address1))'','',':billing_address1')
    #END
+    #IF( #TEXT(Input_billing_address2)='' )
      '' 
    #ELSE
        IF( le.Input_billing_address2 = (TYPEOF(le.Input_billing_address2))'','',':billing_address2')
    #END
+    #IF( #TEXT(Input_billing_city)='' )
      '' 
    #ELSE
        IF( le.Input_billing_city = (TYPEOF(le.Input_billing_city))'','',':billing_city')
    #END
+    #IF( #TEXT(Input_billing_state)='' )
      '' 
    #ELSE
        IF( le.Input_billing_state = (TYPEOF(le.Input_billing_state))'','',':billing_state')
    #END
+    #IF( #TEXT(Input_billing_zip)='' )
      '' 
    #ELSE
        IF( le.Input_billing_zip = (TYPEOF(le.Input_billing_zip))'','',':billing_zip')
    #END
+    #IF( #TEXT(Input_referring_id)='' )
      '' 
    #ELSE
        IF( le.Input_referring_id = (TYPEOF(le.Input_referring_id))'','',':referring_id')
    #END
+    #IF( #TEXT(Input_referring_npi)='' )
      '' 
    #ELSE
        IF( le.Input_referring_npi = (TYPEOF(le.Input_referring_npi))'','',':referring_npi')
    #END
+    #IF( #TEXT(Input_referring_name1)='' )
      '' 
    #ELSE
        IF( le.Input_referring_name1 = (TYPEOF(le.Input_referring_name1))'','',':referring_name1')
    #END
+    #IF( #TEXT(Input_referring_name2)='' )
      '' 
    #ELSE
        IF( le.Input_referring_name2 = (TYPEOF(le.Input_referring_name2))'','',':referring_name2')
    #END
+    #IF( #TEXT(Input_attending_id)='' )
      '' 
    #ELSE
        IF( le.Input_attending_id = (TYPEOF(le.Input_attending_id))'','',':attending_id')
    #END
+    #IF( #TEXT(Input_attending_npi)='' )
      '' 
    #ELSE
        IF( le.Input_attending_npi = (TYPEOF(le.Input_attending_npi))'','',':attending_npi')
    #END
+    #IF( #TEXT(Input_attending_name1)='' )
      '' 
    #ELSE
        IF( le.Input_attending_name1 = (TYPEOF(le.Input_attending_name1))'','',':attending_name1')
    #END
+    #IF( #TEXT(Input_attending_name2)='' )
      '' 
    #ELSE
        IF( le.Input_attending_name2 = (TYPEOF(le.Input_attending_name2))'','',':attending_name2')
    #END
+    #IF( #TEXT(Input_facility_id)='' )
      '' 
    #ELSE
        IF( le.Input_facility_id = (TYPEOF(le.Input_facility_id))'','',':facility_id')
    #END
+    #IF( #TEXT(Input_facility_name1)='' )
      '' 
    #ELSE
        IF( le.Input_facility_name1 = (TYPEOF(le.Input_facility_name1))'','',':facility_name1')
    #END
+    #IF( #TEXT(Input_facility_name2)='' )
      '' 
    #ELSE
        IF( le.Input_facility_name2 = (TYPEOF(le.Input_facility_name2))'','',':facility_name2')
    #END
+    #IF( #TEXT(Input_facility_address1)='' )
      '' 
    #ELSE
        IF( le.Input_facility_address1 = (TYPEOF(le.Input_facility_address1))'','',':facility_address1')
    #END
+    #IF( #TEXT(Input_facility_address2)='' )
      '' 
    #ELSE
        IF( le.Input_facility_address2 = (TYPEOF(le.Input_facility_address2))'','',':facility_address2')
    #END
+    #IF( #TEXT(Input_facility_city)='' )
      '' 
    #ELSE
        IF( le.Input_facility_city = (TYPEOF(le.Input_facility_city))'','',':facility_city')
    #END
+    #IF( #TEXT(Input_facility_state)='' )
      '' 
    #ELSE
        IF( le.Input_facility_state = (TYPEOF(le.Input_facility_state))'','',':facility_state')
    #END
+    #IF( #TEXT(Input_facility_zip)='' )
      '' 
    #ELSE
        IF( le.Input_facility_zip = (TYPEOF(le.Input_facility_zip))'','',':facility_zip')
    #END
+    #IF( #TEXT(Input_statement_from)='' )
      '' 
    #ELSE
        IF( le.Input_statement_from = (TYPEOF(le.Input_statement_from))'','',':statement_from')
    #END
+    #IF( #TEXT(Input_statement_to)='' )
      '' 
    #ELSE
        IF( le.Input_statement_to = (TYPEOF(le.Input_statement_to))'','',':statement_to')
    #END
+    #IF( #TEXT(Input_total_charge)='' )
      '' 
    #ELSE
        IF( le.Input_total_charge = (TYPEOF(le.Input_total_charge))'','',':total_charge')
    #END
+    #IF( #TEXT(Input_total_allowed)='' )
      '' 
    #ELSE
        IF( le.Input_total_allowed = (TYPEOF(le.Input_total_allowed))'','',':total_allowed')
    #END
+    #IF( #TEXT(Input_drg_code)='' )
      '' 
    #ELSE
        IF( le.Input_drg_code = (TYPEOF(le.Input_drg_code))'','',':drg_code')
    #END
+    #IF( #TEXT(Input_patient_control)='' )
      '' 
    #ELSE
        IF( le.Input_patient_control = (TYPEOF(le.Input_patient_control))'','',':patient_control')
    #END
+    #IF( #TEXT(Input_bill_type)='' )
      '' 
    #ELSE
        IF( le.Input_bill_type = (TYPEOF(le.Input_bill_type))'','',':bill_type')
    #END
+    #IF( #TEXT(Input_release_sign)='' )
      '' 
    #ELSE
        IF( le.Input_release_sign = (TYPEOF(le.Input_release_sign))'','',':release_sign')
    #END
+    #IF( #TEXT(Input_assignment_sign)='' )
      '' 
    #ELSE
        IF( le.Input_assignment_sign = (TYPEOF(le.Input_assignment_sign))'','',':assignment_sign')
    #END
+    #IF( #TEXT(Input_in_out_network)='' )
      '' 
    #ELSE
        IF( le.Input_in_out_network = (TYPEOF(le.Input_in_out_network))'','',':in_out_network')
    #END
+    #IF( #TEXT(Input_principal_proc)='' )
      '' 
    #ELSE
        IF( le.Input_principal_proc = (TYPEOF(le.Input_principal_proc))'','',':principal_proc')
    #END
+    #IF( #TEXT(Input_admit_diag)='' )
      '' 
    #ELSE
        IF( le.Input_admit_diag = (TYPEOF(le.Input_admit_diag))'','',':admit_diag')
    #END
+    #IF( #TEXT(Input_primary_diag)='' )
      '' 
    #ELSE
        IF( le.Input_primary_diag = (TYPEOF(le.Input_primary_diag))'','',':primary_diag')
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
+    #IF( #TEXT(Input_other_proc)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc = (TYPEOF(le.Input_other_proc))'','',':other_proc')
    #END
+    #IF( #TEXT(Input_other_proc3)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc3 = (TYPEOF(le.Input_other_proc3))'','',':other_proc3')
    #END
+    #IF( #TEXT(Input_other_proc4)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc4 = (TYPEOF(le.Input_other_proc4))'','',':other_proc4')
    #END
+    #IF( #TEXT(Input_other_proc5)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc5 = (TYPEOF(le.Input_other_proc5))'','',':other_proc5')
    #END
+    #IF( #TEXT(Input_other_proc6)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc6 = (TYPEOF(le.Input_other_proc6))'','',':other_proc6')
    #END
+    #IF( #TEXT(Input_prov_specialty)='' )
      '' 
    #ELSE
        IF( le.Input_prov_specialty = (TYPEOF(le.Input_prov_specialty))'','',':prov_specialty')
    #END
+    #IF( #TEXT(Input_coverage_type)='' )
      '' 
    #ELSE
        IF( le.Input_coverage_type = (TYPEOF(le.Input_coverage_type))'','',':coverage_type')
    #END
+    #IF( #TEXT(Input_explanation_code)='' )
      '' 
    #ELSE
        IF( le.Input_explanation_code = (TYPEOF(le.Input_explanation_code))'','',':explanation_code')
    #END
+    #IF( #TEXT(Input_accident_related)='' )
      '' 
    #ELSE
        IF( le.Input_accident_related = (TYPEOF(le.Input_accident_related))'','',':accident_related')
    #END
+    #IF( #TEXT(Input_esrd_patient)='' )
      '' 
    #ELSE
        IF( le.Input_esrd_patient = (TYPEOF(le.Input_esrd_patient))'','',':esrd_patient')
    #END
+    #IF( #TEXT(Input_hosp_admit_or_er)='' )
      '' 
    #ELSE
        IF( le.Input_hosp_admit_or_er = (TYPEOF(le.Input_hosp_admit_or_er))'','',':hosp_admit_or_er')
    #END
+    #IF( #TEXT(Input_amb_nurse_to_hosp)='' )
      '' 
    #ELSE
        IF( le.Input_amb_nurse_to_hosp = (TYPEOF(le.Input_amb_nurse_to_hosp))'','',':amb_nurse_to_hosp')
    #END
+    #IF( #TEXT(Input_non_covered_specialty)='' )
      '' 
    #ELSE
        IF( le.Input_non_covered_specialty = (TYPEOF(le.Input_non_covered_specialty))'','',':non_covered_specialty')
    #END
+    #IF( #TEXT(Input_electronic_claim)='' )
      '' 
    #ELSE
        IF( le.Input_electronic_claim = (TYPEOF(le.Input_electronic_claim))'','',':electronic_claim')
    #END
+    #IF( #TEXT(Input_dialysis_related)='' )
      '' 
    #ELSE
        IF( le.Input_dialysis_related = (TYPEOF(le.Input_dialysis_related))'','',':dialysis_related')
    #END
+    #IF( #TEXT(Input_new_patient)='' )
      '' 
    #ELSE
        IF( le.Input_new_patient = (TYPEOF(le.Input_new_patient))'','',':new_patient')
    #END
+    #IF( #TEXT(Input_init_proc)='' )
      '' 
    #ELSE
        IF( le.Input_init_proc = (TYPEOF(le.Input_init_proc))'','',':init_proc')
    #END
+    #IF( #TEXT(Input_amb_nurse_to_diag)='' )
      '' 
    #ELSE
        IF( le.Input_amb_nurse_to_diag = (TYPEOF(le.Input_amb_nurse_to_diag))'','',':amb_nurse_to_diag')
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
