 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_dea_registration_number = '',Input_business_activity_code = '',Input_drug_schedules = '',Input_expiration_date = '',Input_address1 = '',Input_address2 = '',Input_address3 = '',Input_address4 = '',Input_address5 = '',Input_state = '',Input_zip_code = '',Input_bus_activity_sub_code = '',Input_exp_of_payment_indicator = '',Input_activity = '',Input_crlf = '',OutFile) := MACRO
  IMPORT SALT32,Scrubs_DEA;
  #uniquename(of)
  %of% := RECORD
    SALT32.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dea_registration_number)='' )
      '' 
    #ELSE
        IF( le.Input_dea_registration_number = (TYPEOF(le.Input_dea_registration_number))'','',':dea_registration_number')
    #END
 
+    #IF( #TEXT(Input_business_activity_code)='' )
      '' 
    #ELSE
        IF( le.Input_business_activity_code = (TYPEOF(le.Input_business_activity_code))'','',':business_activity_code')
    #END
 
+    #IF( #TEXT(Input_drug_schedules)='' )
      '' 
    #ELSE
        IF( le.Input_drug_schedules = (TYPEOF(le.Input_drug_schedules))'','',':drug_schedules')
    #END
 
+    #IF( #TEXT(Input_expiration_date)='' )
      '' 
    #ELSE
        IF( le.Input_expiration_date = (TYPEOF(le.Input_expiration_date))'','',':expiration_date')
    #END
 
+    #IF( #TEXT(Input_address1)='' )
      '' 
    #ELSE
        IF( le.Input_address1 = (TYPEOF(le.Input_address1))'','',':address1')
    #END
 
+    #IF( #TEXT(Input_address2)='' )
      '' 
    #ELSE
        IF( le.Input_address2 = (TYPEOF(le.Input_address2))'','',':address2')
    #END
 
+    #IF( #TEXT(Input_address3)='' )
      '' 
    #ELSE
        IF( le.Input_address3 = (TYPEOF(le.Input_address3))'','',':address3')
    #END
 
+    #IF( #TEXT(Input_address4)='' )
      '' 
    #ELSE
        IF( le.Input_address4 = (TYPEOF(le.Input_address4))'','',':address4')
    #END
 
+    #IF( #TEXT(Input_address5)='' )
      '' 
    #ELSE
        IF( le.Input_address5 = (TYPEOF(le.Input_address5))'','',':address5')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_zip_code = (TYPEOF(le.Input_zip_code))'','',':zip_code')
    #END
 
+    #IF( #TEXT(Input_bus_activity_sub_code)='' )
      '' 
    #ELSE
        IF( le.Input_bus_activity_sub_code = (TYPEOF(le.Input_bus_activity_sub_code))'','',':bus_activity_sub_code')
    #END
 
+    #IF( #TEXT(Input_exp_of_payment_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_exp_of_payment_indicator = (TYPEOF(le.Input_exp_of_payment_indicator))'','',':exp_of_payment_indicator')
    #END
 
+    #IF( #TEXT(Input_activity)='' )
      '' 
    #ELSE
        IF( le.Input_activity = (TYPEOF(le.Input_activity))'','',':activity')
    #END
 
+    #IF( #TEXT(Input_crlf)='' )
      '' 
    #ELSE
        IF( le.Input_crlf = (TYPEOF(le.Input_crlf))'','',':crlf')
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
