 
EXPORT Raw_MAC_PopulationStatistics(infile,Ref='',Input_taxpayer_number = '',Input_outlet_number = '',Input_taxpayer_name = '',Input_taxpayer_address = '',Input_taxpayer_city = '',Input_taxpayer_state = '',Input_taxpayer_zipcode = '',Input_taxpayer_county_code = '',Input_taxpayer_phone = '',Input_taxpayer_org_type = '',Input_outlet_name = '',Input_outlet_address = '',Input_outlet_city = '',Input_outlet_state = '',Input_outlet_zipcode = '',Input_outlet_county_code = '',Input_outlet_phone = '',Input_outlet_naics_code = '',Input_outlet_city_limits_indicator = '',Input_outlet_permit_issue_date = '',Input_outlet_first_sales_date = '',Input_crlf = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Txbus;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_taxpayer_number)='' )
      '' 
    #ELSE
        IF( le.Input_taxpayer_number = (TYPEOF(le.Input_taxpayer_number))'','',':taxpayer_number')
    #END
 
+    #IF( #TEXT(Input_outlet_number)='' )
      '' 
    #ELSE
        IF( le.Input_outlet_number = (TYPEOF(le.Input_outlet_number))'','',':outlet_number')
    #END
 
+    #IF( #TEXT(Input_taxpayer_name)='' )
      '' 
    #ELSE
        IF( le.Input_taxpayer_name = (TYPEOF(le.Input_taxpayer_name))'','',':taxpayer_name')
    #END
 
+    #IF( #TEXT(Input_taxpayer_address)='' )
      '' 
    #ELSE
        IF( le.Input_taxpayer_address = (TYPEOF(le.Input_taxpayer_address))'','',':taxpayer_address')
    #END
 
+    #IF( #TEXT(Input_taxpayer_city)='' )
      '' 
    #ELSE
        IF( le.Input_taxpayer_city = (TYPEOF(le.Input_taxpayer_city))'','',':taxpayer_city')
    #END
 
+    #IF( #TEXT(Input_taxpayer_state)='' )
      '' 
    #ELSE
        IF( le.Input_taxpayer_state = (TYPEOF(le.Input_taxpayer_state))'','',':taxpayer_state')
    #END
 
+    #IF( #TEXT(Input_taxpayer_zipcode)='' )
      '' 
    #ELSE
        IF( le.Input_taxpayer_zipcode = (TYPEOF(le.Input_taxpayer_zipcode))'','',':taxpayer_zipcode')
    #END
 
+    #IF( #TEXT(Input_taxpayer_county_code)='' )
      '' 
    #ELSE
        IF( le.Input_taxpayer_county_code = (TYPEOF(le.Input_taxpayer_county_code))'','',':taxpayer_county_code')
    #END
 
+    #IF( #TEXT(Input_taxpayer_phone)='' )
      '' 
    #ELSE
        IF( le.Input_taxpayer_phone = (TYPEOF(le.Input_taxpayer_phone))'','',':taxpayer_phone')
    #END
 
+    #IF( #TEXT(Input_taxpayer_org_type)='' )
      '' 
    #ELSE
        IF( le.Input_taxpayer_org_type = (TYPEOF(le.Input_taxpayer_org_type))'','',':taxpayer_org_type')
    #END
 
+    #IF( #TEXT(Input_outlet_name)='' )
      '' 
    #ELSE
        IF( le.Input_outlet_name = (TYPEOF(le.Input_outlet_name))'','',':outlet_name')
    #END
 
+    #IF( #TEXT(Input_outlet_address)='' )
      '' 
    #ELSE
        IF( le.Input_outlet_address = (TYPEOF(le.Input_outlet_address))'','',':outlet_address')
    #END
 
+    #IF( #TEXT(Input_outlet_city)='' )
      '' 
    #ELSE
        IF( le.Input_outlet_city = (TYPEOF(le.Input_outlet_city))'','',':outlet_city')
    #END
 
+    #IF( #TEXT(Input_outlet_state)='' )
      '' 
    #ELSE
        IF( le.Input_outlet_state = (TYPEOF(le.Input_outlet_state))'','',':outlet_state')
    #END
 
+    #IF( #TEXT(Input_outlet_zipcode)='' )
      '' 
    #ELSE
        IF( le.Input_outlet_zipcode = (TYPEOF(le.Input_outlet_zipcode))'','',':outlet_zipcode')
    #END
 
+    #IF( #TEXT(Input_outlet_county_code)='' )
      '' 
    #ELSE
        IF( le.Input_outlet_county_code = (TYPEOF(le.Input_outlet_county_code))'','',':outlet_county_code')
    #END
 
+    #IF( #TEXT(Input_outlet_phone)='' )
      '' 
    #ELSE
        IF( le.Input_outlet_phone = (TYPEOF(le.Input_outlet_phone))'','',':outlet_phone')
    #END
 
+    #IF( #TEXT(Input_outlet_naics_code)='' )
      '' 
    #ELSE
        IF( le.Input_outlet_naics_code = (TYPEOF(le.Input_outlet_naics_code))'','',':outlet_naics_code')
    #END
 
+    #IF( #TEXT(Input_outlet_city_limits_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_outlet_city_limits_indicator = (TYPEOF(le.Input_outlet_city_limits_indicator))'','',':outlet_city_limits_indicator')
    #END
 
+    #IF( #TEXT(Input_outlet_permit_issue_date)='' )
      '' 
    #ELSE
        IF( le.Input_outlet_permit_issue_date = (TYPEOF(le.Input_outlet_permit_issue_date))'','',':outlet_permit_issue_date')
    #END
 
+    #IF( #TEXT(Input_outlet_first_sales_date)='' )
      '' 
    #ELSE
        IF( le.Input_outlet_first_sales_date = (TYPEOF(le.Input_outlet_first_sales_date))'','',':outlet_first_sales_date')
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
