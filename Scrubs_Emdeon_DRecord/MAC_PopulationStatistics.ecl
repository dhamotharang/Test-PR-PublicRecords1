 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_claim_num = '',Input_claim_rec_type = '',Input_diag_code9 = '',Input_diag_code10 = '',Input_diag_code11 = '',Input_diag_code12 = '',Input_diag_code13 = '',Input_diag_code14 = '',Input_diag_code15 = '',Input_diag_code16 = '',Input_diag_code17 = '',Input_diag_code18 = '',Input_diag_code19 = '',Input_diag_code20 = '',Input_diag_code21 = '',Input_diag_code22 = '',Input_diag_code23 = '',Input_diag_code24 = '',Input_other_proc7 = '',Input_other_proc8 = '',Input_other_proc9 = '',Input_other_proc10 = '',Input_other_proc11 = '',Input_other_proc12 = '',Input_other_proc13 = '',Input_other_proc14 = '',Input_other_proc15 = '',Input_other_proc16 = '',Input_other_proc17 = '',Input_other_proc18 = '',Input_other_proc19 = '',Input_other_proc20 = '',Input_other_proc21 = '',Input_other_proc22 = '',Input_claim_indicator_code = '',Input_ref_prov_state_lic = '',Input_ref_prov_upin = '',Input_ref_prov_commercial_id = '',Input_pay_to_address1 = '',Input_pay_to_address2 = '',Input_pay_to_city = '',Input_pay_to_zip = '',Input_pay_to_state = '',Input_supervising_prov_org_name = '',Input_supervising_prov_last_name = '',Input_supervising_prov_first_name = '',Input_supervising_prov_middle_name = '',Input_supervising_prov_npi = '',Input_supervising_prov_state_lic = '',Input_supervising_prov_upin = '',Input_supervising_prov_commercial_id = '',Input_supervising_prov_location = '',Input_operating_prov_org_name = '',Input_operating_prov_last_name = '',Input_operating_prov_first_name = '',Input_operating_prov_middle_name = '',Input_operating_prov_npi = '',Input_operating_prov_state_lic = '',Input_operating_prov_upin = '',Input_operating_prov_commercial_id = '',Input_operating_prov_location = '',Input_other_operating_prov_org_name = '',Input_other_operating_prov_last_name = '',Input_other_operating_prov_first_name = '',Input_other_operating_prov_middle_name = '',Input_other_operating_prov_npi = '',Input_other_operating_prov_state_lic = '',Input_other_operating_prov_upin = '',Input_other_operating_prov_commercial_id = '',Input_other_operating_prov_location = '',Input_pay_to_plan_name = '',Input_pay_to_plan_address1 = '',Input_pay_to_plan_address2 = '',Input_pay_to_plan_city = '',Input_pay_to_plan_zip = '',Input_pay_to_plan_state = '',Input_pay_to_plan_naic_id = '',Input_pay_to_plan_payer_id = '',Input_pay_to_plan_plan_id = '',Input_pay_to_plan_claim_ofc_num = '',Input_pay_to_plan_tax_id = '',Input_cob1_payer_name = '',Input_cob1_payer_id = '',Input_cob1_hpid = '',Input_cob1_resp_seq_code = '',Input_cob1_relationship_code = '',Input_cob1_group_policy_num = '',Input_cob1_group_name = '',Input_cob1_ins_type_code = '',Input_cob1_claim_filing_indicator = '',OutFile) := MACRO
  IMPORT SALT31,Scrubs_Emdeon_DRecord;
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
 
+    #IF( #TEXT(Input_diag_code9)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code9 = (TYPEOF(le.Input_diag_code9))'','',':diag_code9')
    #END
 
+    #IF( #TEXT(Input_diag_code10)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code10 = (TYPEOF(le.Input_diag_code10))'','',':diag_code10')
    #END
 
+    #IF( #TEXT(Input_diag_code11)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code11 = (TYPEOF(le.Input_diag_code11))'','',':diag_code11')
    #END
 
+    #IF( #TEXT(Input_diag_code12)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code12 = (TYPEOF(le.Input_diag_code12))'','',':diag_code12')
    #END
 
+    #IF( #TEXT(Input_diag_code13)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code13 = (TYPEOF(le.Input_diag_code13))'','',':diag_code13')
    #END
 
+    #IF( #TEXT(Input_diag_code14)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code14 = (TYPEOF(le.Input_diag_code14))'','',':diag_code14')
    #END
 
+    #IF( #TEXT(Input_diag_code15)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code15 = (TYPEOF(le.Input_diag_code15))'','',':diag_code15')
    #END
 
+    #IF( #TEXT(Input_diag_code16)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code16 = (TYPEOF(le.Input_diag_code16))'','',':diag_code16')
    #END
 
+    #IF( #TEXT(Input_diag_code17)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code17 = (TYPEOF(le.Input_diag_code17))'','',':diag_code17')
    #END
 
+    #IF( #TEXT(Input_diag_code18)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code18 = (TYPEOF(le.Input_diag_code18))'','',':diag_code18')
    #END
 
+    #IF( #TEXT(Input_diag_code19)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code19 = (TYPEOF(le.Input_diag_code19))'','',':diag_code19')
    #END
 
+    #IF( #TEXT(Input_diag_code20)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code20 = (TYPEOF(le.Input_diag_code20))'','',':diag_code20')
    #END
 
+    #IF( #TEXT(Input_diag_code21)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code21 = (TYPEOF(le.Input_diag_code21))'','',':diag_code21')
    #END
 
+    #IF( #TEXT(Input_diag_code22)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code22 = (TYPEOF(le.Input_diag_code22))'','',':diag_code22')
    #END
 
+    #IF( #TEXT(Input_diag_code23)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code23 = (TYPEOF(le.Input_diag_code23))'','',':diag_code23')
    #END
 
+    #IF( #TEXT(Input_diag_code24)='' )
      '' 
    #ELSE
        IF( le.Input_diag_code24 = (TYPEOF(le.Input_diag_code24))'','',':diag_code24')
    #END
 
+    #IF( #TEXT(Input_other_proc7)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc7 = (TYPEOF(le.Input_other_proc7))'','',':other_proc7')
    #END
 
+    #IF( #TEXT(Input_other_proc8)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc8 = (TYPEOF(le.Input_other_proc8))'','',':other_proc8')
    #END
 
+    #IF( #TEXT(Input_other_proc9)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc9 = (TYPEOF(le.Input_other_proc9))'','',':other_proc9')
    #END
 
+    #IF( #TEXT(Input_other_proc10)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc10 = (TYPEOF(le.Input_other_proc10))'','',':other_proc10')
    #END
 
+    #IF( #TEXT(Input_other_proc11)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc11 = (TYPEOF(le.Input_other_proc11))'','',':other_proc11')
    #END
 
+    #IF( #TEXT(Input_other_proc12)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc12 = (TYPEOF(le.Input_other_proc12))'','',':other_proc12')
    #END
 
+    #IF( #TEXT(Input_other_proc13)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc13 = (TYPEOF(le.Input_other_proc13))'','',':other_proc13')
    #END
 
+    #IF( #TEXT(Input_other_proc14)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc14 = (TYPEOF(le.Input_other_proc14))'','',':other_proc14')
    #END
 
+    #IF( #TEXT(Input_other_proc15)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc15 = (TYPEOF(le.Input_other_proc15))'','',':other_proc15')
    #END
 
+    #IF( #TEXT(Input_other_proc16)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc16 = (TYPEOF(le.Input_other_proc16))'','',':other_proc16')
    #END
 
+    #IF( #TEXT(Input_other_proc17)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc17 = (TYPEOF(le.Input_other_proc17))'','',':other_proc17')
    #END
 
+    #IF( #TEXT(Input_other_proc18)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc18 = (TYPEOF(le.Input_other_proc18))'','',':other_proc18')
    #END
 
+    #IF( #TEXT(Input_other_proc19)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc19 = (TYPEOF(le.Input_other_proc19))'','',':other_proc19')
    #END
 
+    #IF( #TEXT(Input_other_proc20)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc20 = (TYPEOF(le.Input_other_proc20))'','',':other_proc20')
    #END
 
+    #IF( #TEXT(Input_other_proc21)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc21 = (TYPEOF(le.Input_other_proc21))'','',':other_proc21')
    #END
 
+    #IF( #TEXT(Input_other_proc22)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc22 = (TYPEOF(le.Input_other_proc22))'','',':other_proc22')
    #END
 
+    #IF( #TEXT(Input_claim_indicator_code)='' )
      '' 
    #ELSE
        IF( le.Input_claim_indicator_code = (TYPEOF(le.Input_claim_indicator_code))'','',':claim_indicator_code')
    #END
 
+    #IF( #TEXT(Input_ref_prov_state_lic)='' )
      '' 
    #ELSE
        IF( le.Input_ref_prov_state_lic = (TYPEOF(le.Input_ref_prov_state_lic))'','',':ref_prov_state_lic')
    #END
 
+    #IF( #TEXT(Input_ref_prov_upin)='' )
      '' 
    #ELSE
        IF( le.Input_ref_prov_upin = (TYPEOF(le.Input_ref_prov_upin))'','',':ref_prov_upin')
    #END
 
+    #IF( #TEXT(Input_ref_prov_commercial_id)='' )
      '' 
    #ELSE
        IF( le.Input_ref_prov_commercial_id = (TYPEOF(le.Input_ref_prov_commercial_id))'','',':ref_prov_commercial_id')
    #END
 
+    #IF( #TEXT(Input_pay_to_address1)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_address1 = (TYPEOF(le.Input_pay_to_address1))'','',':pay_to_address1')
    #END
 
+    #IF( #TEXT(Input_pay_to_address2)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_address2 = (TYPEOF(le.Input_pay_to_address2))'','',':pay_to_address2')
    #END
 
+    #IF( #TEXT(Input_pay_to_city)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_city = (TYPEOF(le.Input_pay_to_city))'','',':pay_to_city')
    #END
 
+    #IF( #TEXT(Input_pay_to_zip)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_zip = (TYPEOF(le.Input_pay_to_zip))'','',':pay_to_zip')
    #END
 
+    #IF( #TEXT(Input_pay_to_state)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_state = (TYPEOF(le.Input_pay_to_state))'','',':pay_to_state')
    #END
 
+    #IF( #TEXT(Input_supervising_prov_org_name)='' )
      '' 
    #ELSE
        IF( le.Input_supervising_prov_org_name = (TYPEOF(le.Input_supervising_prov_org_name))'','',':supervising_prov_org_name')
    #END
 
+    #IF( #TEXT(Input_supervising_prov_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_supervising_prov_last_name = (TYPEOF(le.Input_supervising_prov_last_name))'','',':supervising_prov_last_name')
    #END
 
+    #IF( #TEXT(Input_supervising_prov_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_supervising_prov_first_name = (TYPEOF(le.Input_supervising_prov_first_name))'','',':supervising_prov_first_name')
    #END
 
+    #IF( #TEXT(Input_supervising_prov_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_supervising_prov_middle_name = (TYPEOF(le.Input_supervising_prov_middle_name))'','',':supervising_prov_middle_name')
    #END
 
+    #IF( #TEXT(Input_supervising_prov_npi)='' )
      '' 
    #ELSE
        IF( le.Input_supervising_prov_npi = (TYPEOF(le.Input_supervising_prov_npi))'','',':supervising_prov_npi')
    #END
 
+    #IF( #TEXT(Input_supervising_prov_state_lic)='' )
      '' 
    #ELSE
        IF( le.Input_supervising_prov_state_lic = (TYPEOF(le.Input_supervising_prov_state_lic))'','',':supervising_prov_state_lic')
    #END
 
+    #IF( #TEXT(Input_supervising_prov_upin)='' )
      '' 
    #ELSE
        IF( le.Input_supervising_prov_upin = (TYPEOF(le.Input_supervising_prov_upin))'','',':supervising_prov_upin')
    #END
 
+    #IF( #TEXT(Input_supervising_prov_commercial_id)='' )
      '' 
    #ELSE
        IF( le.Input_supervising_prov_commercial_id = (TYPEOF(le.Input_supervising_prov_commercial_id))'','',':supervising_prov_commercial_id')
    #END
 
+    #IF( #TEXT(Input_supervising_prov_location)='' )
      '' 
    #ELSE
        IF( le.Input_supervising_prov_location = (TYPEOF(le.Input_supervising_prov_location))'','',':supervising_prov_location')
    #END
 
+    #IF( #TEXT(Input_operating_prov_org_name)='' )
      '' 
    #ELSE
        IF( le.Input_operating_prov_org_name = (TYPEOF(le.Input_operating_prov_org_name))'','',':operating_prov_org_name')
    #END
 
+    #IF( #TEXT(Input_operating_prov_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_operating_prov_last_name = (TYPEOF(le.Input_operating_prov_last_name))'','',':operating_prov_last_name')
    #END
 
+    #IF( #TEXT(Input_operating_prov_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_operating_prov_first_name = (TYPEOF(le.Input_operating_prov_first_name))'','',':operating_prov_first_name')
    #END
 
+    #IF( #TEXT(Input_operating_prov_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_operating_prov_middle_name = (TYPEOF(le.Input_operating_prov_middle_name))'','',':operating_prov_middle_name')
    #END
 
+    #IF( #TEXT(Input_operating_prov_npi)='' )
      '' 
    #ELSE
        IF( le.Input_operating_prov_npi = (TYPEOF(le.Input_operating_prov_npi))'','',':operating_prov_npi')
    #END
 
+    #IF( #TEXT(Input_operating_prov_state_lic)='' )
      '' 
    #ELSE
        IF( le.Input_operating_prov_state_lic = (TYPEOF(le.Input_operating_prov_state_lic))'','',':operating_prov_state_lic')
    #END
 
+    #IF( #TEXT(Input_operating_prov_upin)='' )
      '' 
    #ELSE
        IF( le.Input_operating_prov_upin = (TYPEOF(le.Input_operating_prov_upin))'','',':operating_prov_upin')
    #END
 
+    #IF( #TEXT(Input_operating_prov_commercial_id)='' )
      '' 
    #ELSE
        IF( le.Input_operating_prov_commercial_id = (TYPEOF(le.Input_operating_prov_commercial_id))'','',':operating_prov_commercial_id')
    #END
 
+    #IF( #TEXT(Input_operating_prov_location)='' )
      '' 
    #ELSE
        IF( le.Input_operating_prov_location = (TYPEOF(le.Input_operating_prov_location))'','',':operating_prov_location')
    #END
 
+    #IF( #TEXT(Input_other_operating_prov_org_name)='' )
      '' 
    #ELSE
        IF( le.Input_other_operating_prov_org_name = (TYPEOF(le.Input_other_operating_prov_org_name))'','',':other_operating_prov_org_name')
    #END
 
+    #IF( #TEXT(Input_other_operating_prov_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_other_operating_prov_last_name = (TYPEOF(le.Input_other_operating_prov_last_name))'','',':other_operating_prov_last_name')
    #END
 
+    #IF( #TEXT(Input_other_operating_prov_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_other_operating_prov_first_name = (TYPEOF(le.Input_other_operating_prov_first_name))'','',':other_operating_prov_first_name')
    #END
 
+    #IF( #TEXT(Input_other_operating_prov_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_other_operating_prov_middle_name = (TYPEOF(le.Input_other_operating_prov_middle_name))'','',':other_operating_prov_middle_name')
    #END
 
+    #IF( #TEXT(Input_other_operating_prov_npi)='' )
      '' 
    #ELSE
        IF( le.Input_other_operating_prov_npi = (TYPEOF(le.Input_other_operating_prov_npi))'','',':other_operating_prov_npi')
    #END
 
+    #IF( #TEXT(Input_other_operating_prov_state_lic)='' )
      '' 
    #ELSE
        IF( le.Input_other_operating_prov_state_lic = (TYPEOF(le.Input_other_operating_prov_state_lic))'','',':other_operating_prov_state_lic')
    #END
 
+    #IF( #TEXT(Input_other_operating_prov_upin)='' )
      '' 
    #ELSE
        IF( le.Input_other_operating_prov_upin = (TYPEOF(le.Input_other_operating_prov_upin))'','',':other_operating_prov_upin')
    #END
 
+    #IF( #TEXT(Input_other_operating_prov_commercial_id)='' )
      '' 
    #ELSE
        IF( le.Input_other_operating_prov_commercial_id = (TYPEOF(le.Input_other_operating_prov_commercial_id))'','',':other_operating_prov_commercial_id')
    #END
 
+    #IF( #TEXT(Input_other_operating_prov_location)='' )
      '' 
    #ELSE
        IF( le.Input_other_operating_prov_location = (TYPEOF(le.Input_other_operating_prov_location))'','',':other_operating_prov_location')
    #END
 
+    #IF( #TEXT(Input_pay_to_plan_name)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_plan_name = (TYPEOF(le.Input_pay_to_plan_name))'','',':pay_to_plan_name')
    #END
 
+    #IF( #TEXT(Input_pay_to_plan_address1)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_plan_address1 = (TYPEOF(le.Input_pay_to_plan_address1))'','',':pay_to_plan_address1')
    #END
 
+    #IF( #TEXT(Input_pay_to_plan_address2)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_plan_address2 = (TYPEOF(le.Input_pay_to_plan_address2))'','',':pay_to_plan_address2')
    #END
 
+    #IF( #TEXT(Input_pay_to_plan_city)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_plan_city = (TYPEOF(le.Input_pay_to_plan_city))'','',':pay_to_plan_city')
    #END
 
+    #IF( #TEXT(Input_pay_to_plan_zip)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_plan_zip = (TYPEOF(le.Input_pay_to_plan_zip))'','',':pay_to_plan_zip')
    #END
 
+    #IF( #TEXT(Input_pay_to_plan_state)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_plan_state = (TYPEOF(le.Input_pay_to_plan_state))'','',':pay_to_plan_state')
    #END
 
+    #IF( #TEXT(Input_pay_to_plan_naic_id)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_plan_naic_id = (TYPEOF(le.Input_pay_to_plan_naic_id))'','',':pay_to_plan_naic_id')
    #END
 
+    #IF( #TEXT(Input_pay_to_plan_payer_id)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_plan_payer_id = (TYPEOF(le.Input_pay_to_plan_payer_id))'','',':pay_to_plan_payer_id')
    #END
 
+    #IF( #TEXT(Input_pay_to_plan_plan_id)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_plan_plan_id = (TYPEOF(le.Input_pay_to_plan_plan_id))'','',':pay_to_plan_plan_id')
    #END
 
+    #IF( #TEXT(Input_pay_to_plan_claim_ofc_num)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_plan_claim_ofc_num = (TYPEOF(le.Input_pay_to_plan_claim_ofc_num))'','',':pay_to_plan_claim_ofc_num')
    #END
 
+    #IF( #TEXT(Input_pay_to_plan_tax_id)='' )
      '' 
    #ELSE
        IF( le.Input_pay_to_plan_tax_id = (TYPEOF(le.Input_pay_to_plan_tax_id))'','',':pay_to_plan_tax_id')
    #END
 
+    #IF( #TEXT(Input_cob1_payer_name)='' )
      '' 
    #ELSE
        IF( le.Input_cob1_payer_name = (TYPEOF(le.Input_cob1_payer_name))'','',':cob1_payer_name')
    #END
 
+    #IF( #TEXT(Input_cob1_payer_id)='' )
      '' 
    #ELSE
        IF( le.Input_cob1_payer_id = (TYPEOF(le.Input_cob1_payer_id))'','',':cob1_payer_id')
    #END
 
+    #IF( #TEXT(Input_cob1_hpid)='' )
      '' 
    #ELSE
        IF( le.Input_cob1_hpid = (TYPEOF(le.Input_cob1_hpid))'','',':cob1_hpid')
    #END
 
+    #IF( #TEXT(Input_cob1_resp_seq_code)='' )
      '' 
    #ELSE
        IF( le.Input_cob1_resp_seq_code = (TYPEOF(le.Input_cob1_resp_seq_code))'','',':cob1_resp_seq_code')
    #END
 
+    #IF( #TEXT(Input_cob1_relationship_code)='' )
      '' 
    #ELSE
        IF( le.Input_cob1_relationship_code = (TYPEOF(le.Input_cob1_relationship_code))'','',':cob1_relationship_code')
    #END
 
+    #IF( #TEXT(Input_cob1_group_policy_num)='' )
      '' 
    #ELSE
        IF( le.Input_cob1_group_policy_num = (TYPEOF(le.Input_cob1_group_policy_num))'','',':cob1_group_policy_num')
    #END
 
+    #IF( #TEXT(Input_cob1_group_name)='' )
      '' 
    #ELSE
        IF( le.Input_cob1_group_name = (TYPEOF(le.Input_cob1_group_name))'','',':cob1_group_name')
    #END
 
+    #IF( #TEXT(Input_cob1_ins_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_cob1_ins_type_code = (TYPEOF(le.Input_cob1_ins_type_code))'','',':cob1_ins_type_code')
    #END
 
+    #IF( #TEXT(Input_cob1_claim_filing_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_cob1_claim_filing_indicator = (TYPEOF(le.Input_cob1_claim_filing_indicator))'','',':cob1_claim_filing_indicator')
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
