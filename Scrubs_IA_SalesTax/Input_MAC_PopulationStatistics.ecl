 
EXPORT Input_MAC_PopulationStatistics(infile,Ref='',Input_permit_nbr = '',Input_issue_date = '',Input_owner_name = '',Input_business_name = '',Input_city_mailing_address = '',Input_mailing_address = '',Input_state_mailing_address = '',Input_mailing_zip_code = '',Input_location_address = '',Input_city_of_location = '',Input_state_of_location = '',Input_location_zip_code = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_IA_SalesTax;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_permit_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_permit_nbr = (TYPEOF(le.Input_permit_nbr))'','',':permit_nbr')
    #END
 
+    #IF( #TEXT(Input_issue_date)='' )
      '' 
    #ELSE
        IF( le.Input_issue_date = (TYPEOF(le.Input_issue_date))'','',':issue_date')
    #END
 
+    #IF( #TEXT(Input_owner_name)='' )
      '' 
    #ELSE
        IF( le.Input_owner_name = (TYPEOF(le.Input_owner_name))'','',':owner_name')
    #END
 
+    #IF( #TEXT(Input_business_name)='' )
      '' 
    #ELSE
        IF( le.Input_business_name = (TYPEOF(le.Input_business_name))'','',':business_name')
    #END
 
+    #IF( #TEXT(Input_city_mailing_address)='' )
      '' 
    #ELSE
        IF( le.Input_city_mailing_address = (TYPEOF(le.Input_city_mailing_address))'','',':city_mailing_address')
    #END
 
+    #IF( #TEXT(Input_mailing_address)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_address = (TYPEOF(le.Input_mailing_address))'','',':mailing_address')
    #END
 
+    #IF( #TEXT(Input_state_mailing_address)='' )
      '' 
    #ELSE
        IF( le.Input_state_mailing_address = (TYPEOF(le.Input_state_mailing_address))'','',':state_mailing_address')
    #END
 
+    #IF( #TEXT(Input_mailing_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_zip_code = (TYPEOF(le.Input_mailing_zip_code))'','',':mailing_zip_code')
    #END
 
+    #IF( #TEXT(Input_location_address)='' )
      '' 
    #ELSE
        IF( le.Input_location_address = (TYPEOF(le.Input_location_address))'','',':location_address')
    #END
 
+    #IF( #TEXT(Input_city_of_location)='' )
      '' 
    #ELSE
        IF( le.Input_city_of_location = (TYPEOF(le.Input_city_of_location))'','',':city_of_location')
    #END
 
+    #IF( #TEXT(Input_state_of_location)='' )
      '' 
    #ELSE
        IF( le.Input_state_of_location = (TYPEOF(le.Input_state_of_location))'','',':state_of_location')
    #END
 
+    #IF( #TEXT(Input_location_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_location_zip_code = (TYPEOF(le.Input_location_zip_code))'','',':location_zip_code')
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
