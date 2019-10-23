 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_firstname = '',Input_lastname = '',Input_address_1 = '',Input_address_2 = '',Input_city = '',Input_state = '',Input_zipcode = '',Input_sourceurl = '',Input_ipaddress = '',Input_optindate = '',Input_emailaddress = '',Input_anchorinternalcode = '',Input_addresstype = '',Input_dob = '',Input_latitude = '',Input_longitude = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_Anchor;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_firstname)='' )
      '' 
    #ELSE
        IF( le.Input_firstname = (TYPEOF(le.Input_firstname))'','',':firstname')
    #END
 
+    #IF( #TEXT(Input_lastname)='' )
      '' 
    #ELSE
        IF( le.Input_lastname = (TYPEOF(le.Input_lastname))'','',':lastname')
    #END
 
+    #IF( #TEXT(Input_address_1)='' )
      '' 
    #ELSE
        IF( le.Input_address_1 = (TYPEOF(le.Input_address_1))'','',':address_1')
    #END
 
+    #IF( #TEXT(Input_address_2)='' )
      '' 
    #ELSE
        IF( le.Input_address_2 = (TYPEOF(le.Input_address_2))'','',':address_2')
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
 
+    #IF( #TEXT(Input_sourceurl)='' )
      '' 
    #ELSE
        IF( le.Input_sourceurl = (TYPEOF(le.Input_sourceurl))'','',':sourceurl')
    #END
 
+    #IF( #TEXT(Input_ipaddress)='' )
      '' 
    #ELSE
        IF( le.Input_ipaddress = (TYPEOF(le.Input_ipaddress))'','',':ipaddress')
    #END
 
+    #IF( #TEXT(Input_optindate)='' )
      '' 
    #ELSE
        IF( le.Input_optindate = (TYPEOF(le.Input_optindate))'','',':optindate')
    #END
 
+    #IF( #TEXT(Input_emailaddress)='' )
      '' 
    #ELSE
        IF( le.Input_emailaddress = (TYPEOF(le.Input_emailaddress))'','',':emailaddress')
    #END
 
+    #IF( #TEXT(Input_anchorinternalcode)='' )
      '' 
    #ELSE
        IF( le.Input_anchorinternalcode = (TYPEOF(le.Input_anchorinternalcode))'','',':anchorinternalcode')
    #END
 
+    #IF( #TEXT(Input_addresstype)='' )
      '' 
    #ELSE
        IF( le.Input_addresstype = (TYPEOF(le.Input_addresstype))'','',':addresstype')
    #END
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_latitude)='' )
      '' 
    #ELSE
        IF( le.Input_latitude = (TYPEOF(le.Input_latitude))'','',':latitude')
    #END
 
+    #IF( #TEXT(Input_longitude)='' )
      '' 
    #ELSE
        IF( le.Input_longitude = (TYPEOF(le.Input_longitude))'','',':longitude')
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
