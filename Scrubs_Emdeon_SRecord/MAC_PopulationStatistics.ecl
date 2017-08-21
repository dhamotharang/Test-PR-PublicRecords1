EXPORT MAC_PopulationStatistics(infile,Ref='',Input_claim_num = '',Input_claim_rec_type = '',Input_line_number = '',Input_service_from = '',Input_service_to = '',Input_place_service = '',Input_cpt_code = '',Input_proc_qual = '',Input_proc_mod1 = '',Input_proc_mod2 = '',Input_proc_mod3 = '',Input_proc_mod4 = '',Input_line_charge = '',Input_line_allowed = '',Input_units = '',Input_revenue_code = '',Input_diag_code1 = '',Input_diag_code2 = '',Input_diag_code3 = '',Input_diag_code4 = '',Input_diag_code5 = '',Input_diag_code6 = '',Input_diag_code7 = '',Input_diag_code8 = '',Input_ndc = '',Input_ambulance_to_hosp = '',Input_emergency = '',Input_tooth_surface = '',Input_oral_cavity = '',Input_service_type = '',Input_copay = '',Input_paid_amount = '',Input_paid_date = '',Input_bene_not_entitled = '',Input_patient_reach_max = '',Input_svc_during_postop = '',Input_adjudicated_proc = '',Input_adjudicated_proc_qual = '',Input_adjudicated_proc_mod1 = '',Input_adjudicated_proc_mod2 = '',Input_adjudicated_proc_mod3 = '',Input_adjudicated_proc_mod4 = '',Input_pid = '',Input_src = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_ln_record_type = '',Input_clean_service_from = '',Input_clean_service_to = '',Input_clean_paid_date = '',OutFile) := MACRO
  IMPORT SALT31,Scrubs_Emdeon_SRecord;
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
+    #IF( #TEXT(Input_line_number)='' )
      '' 
    #ELSE
        IF( le.Input_line_number = (TYPEOF(le.Input_line_number))'','',':line_number')
    #END
+    #IF( #TEXT(Input_service_from)='' )
      '' 
    #ELSE
        IF( le.Input_service_from = (TYPEOF(le.Input_service_from))'','',':service_from')
    #END
+    #IF( #TEXT(Input_service_to)='' )
      '' 
    #ELSE
        IF( le.Input_service_to = (TYPEOF(le.Input_service_to))'','',':service_to')
    #END
+    #IF( #TEXT(Input_place_service)='' )
      '' 
    #ELSE
        IF( le.Input_place_service = (TYPEOF(le.Input_place_service))'','',':place_service')
    #END
+    #IF( #TEXT(Input_cpt_code)='' )
      '' 
    #ELSE
        IF( le.Input_cpt_code = (TYPEOF(le.Input_cpt_code))'','',':cpt_code')
    #END
+    #IF( #TEXT(Input_proc_qual)='' )
      '' 
    #ELSE
        IF( le.Input_proc_qual = (TYPEOF(le.Input_proc_qual))'','',':proc_qual')
    #END
+    #IF( #TEXT(Input_proc_mod1)='' )
      '' 
    #ELSE
        IF( le.Input_proc_mod1 = (TYPEOF(le.Input_proc_mod1))'','',':proc_mod1')
    #END
+    #IF( #TEXT(Input_proc_mod2)='' )
      '' 
    #ELSE
        IF( le.Input_proc_mod2 = (TYPEOF(le.Input_proc_mod2))'','',':proc_mod2')
    #END
+    #IF( #TEXT(Input_proc_mod3)='' )
      '' 
    #ELSE
        IF( le.Input_proc_mod3 = (TYPEOF(le.Input_proc_mod3))'','',':proc_mod3')
    #END
+    #IF( #TEXT(Input_proc_mod4)='' )
      '' 
    #ELSE
        IF( le.Input_proc_mod4 = (TYPEOF(le.Input_proc_mod4))'','',':proc_mod4')
    #END
+    #IF( #TEXT(Input_line_charge)='' )
      '' 
    #ELSE
        IF( le.Input_line_charge = (TYPEOF(le.Input_line_charge))'','',':line_charge')
    #END
+    #IF( #TEXT(Input_line_allowed)='' )
      '' 
    #ELSE
        IF( le.Input_line_allowed = (TYPEOF(le.Input_line_allowed))'','',':line_allowed')
    #END
+    #IF( #TEXT(Input_units)='' )
      '' 
    #ELSE
        IF( le.Input_units = (TYPEOF(le.Input_units))'','',':units')
    #END
+    #IF( #TEXT(Input_revenue_code)='' )
      '' 
    #ELSE
        IF( le.Input_revenue_code = (TYPEOF(le.Input_revenue_code))'','',':revenue_code')
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
+    #IF( #TEXT(Input_ndc)='' )
      '' 
    #ELSE
        IF( le.Input_ndc = (TYPEOF(le.Input_ndc))'','',':ndc')
    #END
+    #IF( #TEXT(Input_ambulance_to_hosp)='' )
      '' 
    #ELSE
        IF( le.Input_ambulance_to_hosp = (TYPEOF(le.Input_ambulance_to_hosp))'','',':ambulance_to_hosp')
    #END
+    #IF( #TEXT(Input_emergency)='' )
      '' 
    #ELSE
        IF( le.Input_emergency = (TYPEOF(le.Input_emergency))'','',':emergency')
    #END
+    #IF( #TEXT(Input_tooth_surface)='' )
      '' 
    #ELSE
        IF( le.Input_tooth_surface = (TYPEOF(le.Input_tooth_surface))'','',':tooth_surface')
    #END
+    #IF( #TEXT(Input_oral_cavity)='' )
      '' 
    #ELSE
        IF( le.Input_oral_cavity = (TYPEOF(le.Input_oral_cavity))'','',':oral_cavity')
    #END
+    #IF( #TEXT(Input_service_type)='' )
      '' 
    #ELSE
        IF( le.Input_service_type = (TYPEOF(le.Input_service_type))'','',':service_type')
    #END
+    #IF( #TEXT(Input_copay)='' )
      '' 
    #ELSE
        IF( le.Input_copay = (TYPEOF(le.Input_copay))'','',':copay')
    #END
+    #IF( #TEXT(Input_paid_amount)='' )
      '' 
    #ELSE
        IF( le.Input_paid_amount = (TYPEOF(le.Input_paid_amount))'','',':paid_amount')
    #END
+    #IF( #TEXT(Input_paid_date)='' )
      '' 
    #ELSE
        IF( le.Input_paid_date = (TYPEOF(le.Input_paid_date))'','',':paid_date')
    #END
+    #IF( #TEXT(Input_bene_not_entitled)='' )
      '' 
    #ELSE
        IF( le.Input_bene_not_entitled = (TYPEOF(le.Input_bene_not_entitled))'','',':bene_not_entitled')
    #END
+    #IF( #TEXT(Input_patient_reach_max)='' )
      '' 
    #ELSE
        IF( le.Input_patient_reach_max = (TYPEOF(le.Input_patient_reach_max))'','',':patient_reach_max')
    #END
+    #IF( #TEXT(Input_svc_during_postop)='' )
      '' 
    #ELSE
        IF( le.Input_svc_during_postop = (TYPEOF(le.Input_svc_during_postop))'','',':svc_during_postop')
    #END
+    #IF( #TEXT(Input_adjudicated_proc)='' )
      '' 
    #ELSE
        IF( le.Input_adjudicated_proc = (TYPEOF(le.Input_adjudicated_proc))'','',':adjudicated_proc')
    #END
+    #IF( #TEXT(Input_adjudicated_proc_qual)='' )
      '' 
    #ELSE
        IF( le.Input_adjudicated_proc_qual = (TYPEOF(le.Input_adjudicated_proc_qual))'','',':adjudicated_proc_qual')
    #END
+    #IF( #TEXT(Input_adjudicated_proc_mod1)='' )
      '' 
    #ELSE
        IF( le.Input_adjudicated_proc_mod1 = (TYPEOF(le.Input_adjudicated_proc_mod1))'','',':adjudicated_proc_mod1')
    #END
+    #IF( #TEXT(Input_adjudicated_proc_mod2)='' )
      '' 
    #ELSE
        IF( le.Input_adjudicated_proc_mod2 = (TYPEOF(le.Input_adjudicated_proc_mod2))'','',':adjudicated_proc_mod2')
    #END
+    #IF( #TEXT(Input_adjudicated_proc_mod3)='' )
      '' 
    #ELSE
        IF( le.Input_adjudicated_proc_mod3 = (TYPEOF(le.Input_adjudicated_proc_mod3))'','',':adjudicated_proc_mod3')
    #END
+    #IF( #TEXT(Input_adjudicated_proc_mod4)='' )
      '' 
    #ELSE
        IF( le.Input_adjudicated_proc_mod4 = (TYPEOF(le.Input_adjudicated_proc_mod4))'','',':adjudicated_proc_mod4')
    #END
+    #IF( #TEXT(Input_pid)='' )
      '' 
    #ELSE
        IF( le.Input_pid = (TYPEOF(le.Input_pid))'','',':pid')
    #END
+    #IF( #TEXT(Input_src)='' )
      '' 
    #ELSE
        IF( le.Input_src = (TYPEOF(le.Input_src))'','',':src')
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
+    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
+    #IF( #TEXT(Input_ln_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_ln_record_type = (TYPEOF(le.Input_ln_record_type))'','',':ln_record_type')
    #END
+    #IF( #TEXT(Input_clean_service_from)='' )
      '' 
    #ELSE
        IF( le.Input_clean_service_from = (TYPEOF(le.Input_clean_service_from))'','',':clean_service_from')
    #END
+    #IF( #TEXT(Input_clean_service_to)='' )
      '' 
    #ELSE
        IF( le.Input_clean_service_to = (TYPEOF(le.Input_clean_service_to))'','',':clean_service_to')
    #END
+    #IF( #TEXT(Input_clean_paid_date)='' )
      '' 
    #ELSE
        IF( le.Input_clean_paid_date = (TYPEOF(le.Input_clean_paid_date))'','',':clean_paid_date')
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
