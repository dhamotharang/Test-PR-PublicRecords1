 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_first_name = '',Input_last_name = '',Input_job_title = '',Input_company_name = '',Input_validation_date = '',Input_company_street_address = '',Input_company_city = '',Input_company_state = '',Input_company_postal_code = '',Input_company_phone_number = '',Input_company_annual_revenue = '',Input_company_business_description = '',Input_lf = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Spoke;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_name = (TYPEOF(le.Input_first_name))'','',':first_name')
    #END
 
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
    #END
 
+    #IF( #TEXT(Input_job_title)='' )
      '' 
    #ELSE
        IF( le.Input_job_title = (TYPEOF(le.Input_job_title))'','',':job_title')
    #END
 
+    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (TYPEOF(le.Input_company_name))'','',':company_name')
    #END
 
+    #IF( #TEXT(Input_validation_date)='' )
      '' 
    #ELSE
        IF( le.Input_validation_date = (TYPEOF(le.Input_validation_date))'','',':validation_date')
    #END
 
+    #IF( #TEXT(Input_company_street_address)='' )
      '' 
    #ELSE
        IF( le.Input_company_street_address = (TYPEOF(le.Input_company_street_address))'','',':company_street_address')
    #END
 
+    #IF( #TEXT(Input_company_city)='' )
      '' 
    #ELSE
        IF( le.Input_company_city = (TYPEOF(le.Input_company_city))'','',':company_city')
    #END
 
+    #IF( #TEXT(Input_company_state)='' )
      '' 
    #ELSE
        IF( le.Input_company_state = (TYPEOF(le.Input_company_state))'','',':company_state')
    #END
 
+    #IF( #TEXT(Input_company_postal_code)='' )
      '' 
    #ELSE
        IF( le.Input_company_postal_code = (TYPEOF(le.Input_company_postal_code))'','',':company_postal_code')
    #END
 
+    #IF( #TEXT(Input_company_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_company_phone_number = (TYPEOF(le.Input_company_phone_number))'','',':company_phone_number')
    #END
 
+    #IF( #TEXT(Input_company_annual_revenue)='' )
      '' 
    #ELSE
        IF( le.Input_company_annual_revenue = (TYPEOF(le.Input_company_annual_revenue))'','',':company_annual_revenue')
    #END
 
+    #IF( #TEXT(Input_company_business_description)='' )
      '' 
    #ELSE
        IF( le.Input_company_business_description = (TYPEOF(le.Input_company_business_description))'','',':company_business_description')
    #END
 
+    #IF( #TEXT(Input_lf)='' )
      '' 
    #ELSE
        IF( le.Input_lf = (TYPEOF(le.Input_lf))'','',':lf')
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
