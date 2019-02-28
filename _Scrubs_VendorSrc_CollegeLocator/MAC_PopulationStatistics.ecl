 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_lnfilecategory = '',Input_lnsourcetcode = '',Input_vendorname = '',Input_address1 = '',Input_address2 = '',Input_city = '',Input_state = '',Input_zipcode = '',Input_phone = '',OutFile) := MACRO
  IMPORT SALT311,_Scrubs_VendorSrc_CollegeLocator;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_lnfilecategory)='' )
      '' 
    #ELSE
        IF( le.Input_lnfilecategory = (TYPEOF(le.Input_lnfilecategory))'','',':lnfilecategory')
    #END
 
+    #IF( #TEXT(Input_lnsourcetcode)='' )
      '' 
    #ELSE
        IF( le.Input_lnsourcetcode = (TYPEOF(le.Input_lnsourcetcode))'','',':lnsourcetcode')
    #END
 
+    #IF( #TEXT(Input_vendorname)='' )
      '' 
    #ELSE
        IF( le.Input_vendorname = (TYPEOF(le.Input_vendorname))'','',':vendorname')
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
