 
EXPORT raw_MAC_PopulationStatistics(infile,Ref='',Input_district_branch = '',Input_account_number = '',Input_sub_account_number = '',Input_district = '',Input_account_type = '',Input_firm_name = '',Input_owner_name = '',Input_business_street = '',Input_business_city = '',Input_business_state = '',Input_business_zip_5 = '',Input_business_zip_plus_4 = '',Input_business_country_name = '',Input_start_date = '',Input_ownership_code = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Calbus;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_district_branch)='' )
      '' 
    #ELSE
        IF( le.Input_district_branch = (TYPEOF(le.Input_district_branch))'','',':district_branch')
    #END
 
+    #IF( #TEXT(Input_account_number)='' )
      '' 
    #ELSE
        IF( le.Input_account_number = (TYPEOF(le.Input_account_number))'','',':account_number')
    #END
 
+    #IF( #TEXT(Input_sub_account_number)='' )
      '' 
    #ELSE
        IF( le.Input_sub_account_number = (TYPEOF(le.Input_sub_account_number))'','',':sub_account_number')
    #END
 
+    #IF( #TEXT(Input_district)='' )
      '' 
    #ELSE
        IF( le.Input_district = (TYPEOF(le.Input_district))'','',':district')
    #END
 
+    #IF( #TEXT(Input_account_type)='' )
      '' 
    #ELSE
        IF( le.Input_account_type = (TYPEOF(le.Input_account_type))'','',':account_type')
    #END
 
+    #IF( #TEXT(Input_firm_name)='' )
      '' 
    #ELSE
        IF( le.Input_firm_name = (TYPEOF(le.Input_firm_name))'','',':firm_name')
    #END
 
+    #IF( #TEXT(Input_owner_name)='' )
      '' 
    #ELSE
        IF( le.Input_owner_name = (TYPEOF(le.Input_owner_name))'','',':owner_name')
    #END
 
+    #IF( #TEXT(Input_business_street)='' )
      '' 
    #ELSE
        IF( le.Input_business_street = (TYPEOF(le.Input_business_street))'','',':business_street')
    #END
 
+    #IF( #TEXT(Input_business_city)='' )
      '' 
    #ELSE
        IF( le.Input_business_city = (TYPEOF(le.Input_business_city))'','',':business_city')
    #END
 
+    #IF( #TEXT(Input_business_state)='' )
      '' 
    #ELSE
        IF( le.Input_business_state = (TYPEOF(le.Input_business_state))'','',':business_state')
    #END
 
+    #IF( #TEXT(Input_business_zip_5)='' )
      '' 
    #ELSE
        IF( le.Input_business_zip_5 = (TYPEOF(le.Input_business_zip_5))'','',':business_zip_5')
    #END
 
+    #IF( #TEXT(Input_business_zip_plus_4)='' )
      '' 
    #ELSE
        IF( le.Input_business_zip_plus_4 = (TYPEOF(le.Input_business_zip_plus_4))'','',':business_zip_plus_4')
    #END
 
+    #IF( #TEXT(Input_business_country_name)='' )
      '' 
    #ELSE
        IF( le.Input_business_country_name = (TYPEOF(le.Input_business_country_name))'','',':business_country_name')
    #END
 
+    #IF( #TEXT(Input_start_date)='' )
      '' 
    #ELSE
        IF( le.Input_start_date = (TYPEOF(le.Input_start_date))'','',':start_date')
    #END
 
+    #IF( #TEXT(Input_ownership_code)='' )
      '' 
    #ELSE
        IF( le.Input_ownership_code = (TYPEOF(le.Input_ownership_code))'','',':ownership_code')
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
