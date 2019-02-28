 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_lncourtcode = '',Input_rmscourt_code = '',Input_court_name = '',Input_address1 = '',Input_address2 = '',Input_city = '',Input_state = '',Input_zip = '',Input_phone = '',OutFile) := MACRO
  IMPORT SALT311,_Scrubs_VendorSrc_Bankruptcy;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_lncourtcode)='' )
      '' 
    #ELSE
        IF( le.Input_lncourtcode = (TYPEOF(le.Input_lncourtcode))'','',':lncourtcode')
    #END
 
+    #IF( #TEXT(Input_rmscourt_code)='' )
      '' 
    #ELSE
        IF( le.Input_rmscourt_code = (TYPEOF(le.Input_rmscourt_code))'','',':rmscourt_code')
    #END
 
+    #IF( #TEXT(Input_court_name)='' )
      '' 
    #ELSE
        IF( le.Input_court_name = (TYPEOF(le.Input_court_name))'','',':court_name')
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
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
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
