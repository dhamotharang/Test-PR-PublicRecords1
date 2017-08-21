EXPORT MAC_PopulationStatistics(infile,Ref='',Input_claim_type = '',Input_claim_num = '',Input_attend_prov_id = '',Input_attend_prov_name = '',Input_billing_addr = '',Input_billing_city = '',Input_billing_npi = '',Input_billing_org_name = '',Input_billing_state = '',Input_billing_tax_id = '',Input_billing_zip = '',Input_ext_injury_diag_code = '',Input_inpatient_proc1 = '',Input_inpatient_proc2 = '',Input_inpatient_proc3 = '',Input_operating_prov_id = '',Input_operating_prov_name = '',Input_other_diag1 = '',Input_other_diag2 = '',Input_other_diag3 = '',Input_other_diag4 = '',Input_other_diag5 = '',Input_other_diag6 = '',Input_other_diag7 = '',Input_other_diag8 = '',Input_other_proc1 = '',Input_other_proc2 = '',Input_other_proc3 = '',Input_other_proc4 = '',Input_other_proc5 = '',Input_other_proc_method_code = '',Input_other_prov_id1 = '',Input_other_prov_id2 = '',Input_other_prov_name1 = '',Input_other_prov_name2 = '',Input_outpatient_proc1 = '',Input_outpatient_proc2 = '',Input_outpatient_proc3 = '',Input_principle_diag = '',Input_principle_proc = '',Input_service_from = '',Input_service_line = '',Input_service_to = '',Input_submitted_date = '',OutFile) := MACRO
  IMPORT SALT31,Scrubs_HX;
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
+    #IF( #TEXT(Input_attend_prov_id)='' )
      '' 
    #ELSE
        IF( le.Input_attend_prov_id = (TYPEOF(le.Input_attend_prov_id))'','',':attend_prov_id')
    #END
+    #IF( #TEXT(Input_attend_prov_name)='' )
      '' 
    #ELSE
        IF( le.Input_attend_prov_name = (TYPEOF(le.Input_attend_prov_name))'','',':attend_prov_name')
    #END
+    #IF( #TEXT(Input_billing_addr)='' )
      '' 
    #ELSE
        IF( le.Input_billing_addr = (TYPEOF(le.Input_billing_addr))'','',':billing_addr')
    #END
+    #IF( #TEXT(Input_billing_city)='' )
      '' 
    #ELSE
        IF( le.Input_billing_city = (TYPEOF(le.Input_billing_city))'','',':billing_city')
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
+    #IF( #TEXT(Input_billing_state)='' )
      '' 
    #ELSE
        IF( le.Input_billing_state = (TYPEOF(le.Input_billing_state))'','',':billing_state')
    #END
+    #IF( #TEXT(Input_billing_tax_id)='' )
      '' 
    #ELSE
        IF( le.Input_billing_tax_id = (TYPEOF(le.Input_billing_tax_id))'','',':billing_tax_id')
    #END
+    #IF( #TEXT(Input_billing_zip)='' )
      '' 
    #ELSE
        IF( le.Input_billing_zip = (TYPEOF(le.Input_billing_zip))'','',':billing_zip')
    #END
+    #IF( #TEXT(Input_ext_injury_diag_code)='' )
      '' 
    #ELSE
        IF( le.Input_ext_injury_diag_code = (TYPEOF(le.Input_ext_injury_diag_code))'','',':ext_injury_diag_code')
    #END
+    #IF( #TEXT(Input_inpatient_proc1)='' )
      '' 
    #ELSE
        IF( le.Input_inpatient_proc1 = (TYPEOF(le.Input_inpatient_proc1))'','',':inpatient_proc1')
    #END
+    #IF( #TEXT(Input_inpatient_proc2)='' )
      '' 
    #ELSE
        IF( le.Input_inpatient_proc2 = (TYPEOF(le.Input_inpatient_proc2))'','',':inpatient_proc2')
    #END
+    #IF( #TEXT(Input_inpatient_proc3)='' )
      '' 
    #ELSE
        IF( le.Input_inpatient_proc3 = (TYPEOF(le.Input_inpatient_proc3))'','',':inpatient_proc3')
    #END
+    #IF( #TEXT(Input_operating_prov_id)='' )
      '' 
    #ELSE
        IF( le.Input_operating_prov_id = (TYPEOF(le.Input_operating_prov_id))'','',':operating_prov_id')
    #END
+    #IF( #TEXT(Input_operating_prov_name)='' )
      '' 
    #ELSE
        IF( le.Input_operating_prov_name = (TYPEOF(le.Input_operating_prov_name))'','',':operating_prov_name')
    #END
+    #IF( #TEXT(Input_other_diag1)='' )
      '' 
    #ELSE
        IF( le.Input_other_diag1 = (TYPEOF(le.Input_other_diag1))'','',':other_diag1')
    #END
+    #IF( #TEXT(Input_other_diag2)='' )
      '' 
    #ELSE
        IF( le.Input_other_diag2 = (TYPEOF(le.Input_other_diag2))'','',':other_diag2')
    #END
+    #IF( #TEXT(Input_other_diag3)='' )
      '' 
    #ELSE
        IF( le.Input_other_diag3 = (TYPEOF(le.Input_other_diag3))'','',':other_diag3')
    #END
+    #IF( #TEXT(Input_other_diag4)='' )
      '' 
    #ELSE
        IF( le.Input_other_diag4 = (TYPEOF(le.Input_other_diag4))'','',':other_diag4')
    #END
+    #IF( #TEXT(Input_other_diag5)='' )
      '' 
    #ELSE
        IF( le.Input_other_diag5 = (TYPEOF(le.Input_other_diag5))'','',':other_diag5')
    #END
+    #IF( #TEXT(Input_other_diag6)='' )
      '' 
    #ELSE
        IF( le.Input_other_diag6 = (TYPEOF(le.Input_other_diag6))'','',':other_diag6')
    #END
+    #IF( #TEXT(Input_other_diag7)='' )
      '' 
    #ELSE
        IF( le.Input_other_diag7 = (TYPEOF(le.Input_other_diag7))'','',':other_diag7')
    #END
+    #IF( #TEXT(Input_other_diag8)='' )
      '' 
    #ELSE
        IF( le.Input_other_diag8 = (TYPEOF(le.Input_other_diag8))'','',':other_diag8')
    #END
+    #IF( #TEXT(Input_other_proc1)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc1 = (TYPEOF(le.Input_other_proc1))'','',':other_proc1')
    #END
+    #IF( #TEXT(Input_other_proc2)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc2 = (TYPEOF(le.Input_other_proc2))'','',':other_proc2')
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
+    #IF( #TEXT(Input_other_proc_method_code)='' )
      '' 
    #ELSE
        IF( le.Input_other_proc_method_code = (TYPEOF(le.Input_other_proc_method_code))'','',':other_proc_method_code')
    #END
+    #IF( #TEXT(Input_other_prov_id1)='' )
      '' 
    #ELSE
        IF( le.Input_other_prov_id1 = (TYPEOF(le.Input_other_prov_id1))'','',':other_prov_id1')
    #END
+    #IF( #TEXT(Input_other_prov_id2)='' )
      '' 
    #ELSE
        IF( le.Input_other_prov_id2 = (TYPEOF(le.Input_other_prov_id2))'','',':other_prov_id2')
    #END
+    #IF( #TEXT(Input_other_prov_name1)='' )
      '' 
    #ELSE
        IF( le.Input_other_prov_name1 = (TYPEOF(le.Input_other_prov_name1))'','',':other_prov_name1')
    #END
+    #IF( #TEXT(Input_other_prov_name2)='' )
      '' 
    #ELSE
        IF( le.Input_other_prov_name2 = (TYPEOF(le.Input_other_prov_name2))'','',':other_prov_name2')
    #END
+    #IF( #TEXT(Input_outpatient_proc1)='' )
      '' 
    #ELSE
        IF( le.Input_outpatient_proc1 = (TYPEOF(le.Input_outpatient_proc1))'','',':outpatient_proc1')
    #END
+    #IF( #TEXT(Input_outpatient_proc2)='' )
      '' 
    #ELSE
        IF( le.Input_outpatient_proc2 = (TYPEOF(le.Input_outpatient_proc2))'','',':outpatient_proc2')
    #END
+    #IF( #TEXT(Input_outpatient_proc3)='' )
      '' 
    #ELSE
        IF( le.Input_outpatient_proc3 = (TYPEOF(le.Input_outpatient_proc3))'','',':outpatient_proc3')
    #END
+    #IF( #TEXT(Input_principle_diag)='' )
      '' 
    #ELSE
        IF( le.Input_principle_diag = (TYPEOF(le.Input_principle_diag))'','',':principle_diag')
    #END
+    #IF( #TEXT(Input_principle_proc)='' )
      '' 
    #ELSE
        IF( le.Input_principle_proc = (TYPEOF(le.Input_principle_proc))'','',':principle_proc')
    #END
+    #IF( #TEXT(Input_service_from)='' )
      '' 
    #ELSE
        IF( le.Input_service_from = (TYPEOF(le.Input_service_from))'','',':service_from')
    #END
+    #IF( #TEXT(Input_service_line)='' )
      '' 
    #ELSE
        IF( le.Input_service_line = (TYPEOF(le.Input_service_line))'','',':service_line')
    #END
+    #IF( #TEXT(Input_service_to)='' )
      '' 
    #ELSE
        IF( le.Input_service_to = (TYPEOF(le.Input_service_to))'','',':service_to')
    #END
+    #IF( #TEXT(Input_submitted_date)='' )
      '' 
    #ELSE
        IF( le.Input_submitted_date = (TYPEOF(le.Input_submitted_date))'','',':submitted_date')
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
