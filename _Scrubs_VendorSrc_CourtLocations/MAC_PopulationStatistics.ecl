 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_fipscode = '',Input_statefips = '',Input_countyfips = '',Input_courtid = '',Input_consolidatedcourtid = '',Input_masterid = '',Input_stateofservice = '',Input_countyofservice = '',Input_courtname = '',Input_phone = '',Input_address1 = '',Input_address2 = '',Input_city = '',Input_state = '',Input_zipcode = '',Input_zip4 = '',Input_mailaddress1 = '',Input_mailaddress2 = '',Input_mailcity = '',Input_mailctate = '',Input_mailzipcode = '',Input_mailzip4 = '',OutFile) := MACRO
  IMPORT SALT311,_Scrubs_VendorSrc_CourtLocations;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_fipscode)='' )
      '' 
    #ELSE
        IF( le.Input_fipscode = (TYPEOF(le.Input_fipscode))'','',':fipscode')
    #END
 
+    #IF( #TEXT(Input_statefips)='' )
      '' 
    #ELSE
        IF( le.Input_statefips = (TYPEOF(le.Input_statefips))'','',':statefips')
    #END
 
+    #IF( #TEXT(Input_countyfips)='' )
      '' 
    #ELSE
        IF( le.Input_countyfips = (TYPEOF(le.Input_countyfips))'','',':countyfips')
    #END
 
+    #IF( #TEXT(Input_courtid)='' )
      '' 
    #ELSE
        IF( le.Input_courtid = (TYPEOF(le.Input_courtid))'','',':courtid')
    #END
 
+    #IF( #TEXT(Input_consolidatedcourtid)='' )
      '' 
    #ELSE
        IF( le.Input_consolidatedcourtid = (TYPEOF(le.Input_consolidatedcourtid))'','',':consolidatedcourtid')
    #END
 
+    #IF( #TEXT(Input_masterid)='' )
      '' 
    #ELSE
        IF( le.Input_masterid = (TYPEOF(le.Input_masterid))'','',':masterid')
    #END
 
+    #IF( #TEXT(Input_stateofservice)='' )
      '' 
    #ELSE
        IF( le.Input_stateofservice = (TYPEOF(le.Input_stateofservice))'','',':stateofservice')
    #END
 
+    #IF( #TEXT(Input_countyofservice)='' )
      '' 
    #ELSE
        IF( le.Input_countyofservice = (TYPEOF(le.Input_countyofservice))'','',':countyofservice')
    #END
 
+    #IF( #TEXT(Input_courtname)='' )
      '' 
    #ELSE
        IF( le.Input_courtname = (TYPEOF(le.Input_courtname))'','',':courtname')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
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
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_zipcode)='' )
      '' 
    #ELSE
        IF( le.Input_zipcode = (TYPEOF(le.Input_zipcode))'','',':zipcode')
    #END
 
+    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
 
+    #IF( #TEXT(Input_mailaddress1)='' )
      '' 
    #ELSE
        IF( le.Input_mailaddress1 = (TYPEOF(le.Input_mailaddress1))'','',':mailaddress1')
    #END
 
+    #IF( #TEXT(Input_mailaddress2)='' )
      '' 
    #ELSE
        IF( le.Input_mailaddress2 = (TYPEOF(le.Input_mailaddress2))'','',':mailaddress2')
    #END
 
+    #IF( #TEXT(Input_mailcity)='' )
      '' 
    #ELSE
        IF( le.Input_mailcity = (TYPEOF(le.Input_mailcity))'','',':mailcity')
    #END
 
+    #IF( #TEXT(Input_mailctate)='' )
      '' 
    #ELSE
        IF( le.Input_mailctate = (TYPEOF(le.Input_mailctate))'','',':mailctate')
    #END
 
+    #IF( #TEXT(Input_mailzipcode)='' )
      '' 
    #ELSE
        IF( le.Input_mailzipcode = (TYPEOF(le.Input_mailzipcode))'','',':mailzipcode')
    #END
 
+    #IF( #TEXT(Input_mailzip4)='' )
      '' 
    #ELSE
        IF( le.Input_mailzip4 = (TYPEOF(le.Input_mailzip4))'','',':mailzip4')
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
