 
EXPORT Input_CA_Orange_MAC_PopulationStatistics(infile,Ref='',Input_REGIS_NBR = '',Input_BUSINESS_NAME = '',Input_PHONE_NBR = '',Input_FILE_DATE = '',Input_FIRST_NAME = '',Input_MIDDLE_NAME = '',Input_LAST_NAME_COMPANY = '',Input_OWNER_ADDRESS = '',Input_prep_bus_addr_line1 = '',Input_prep_bus_addr_line_last = '',Input_prep_owner_addr_line1 = '',Input_prep_owner_addr_line_last = '',Input_cname = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_FBNV2;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_REGIS_NBR)='' )
      '' 
    #ELSE
        IF( le.Input_REGIS_NBR = (TYPEOF(le.Input_REGIS_NBR))'','',':REGIS_NBR')
    #END
 
+    #IF( #TEXT(Input_BUSINESS_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_BUSINESS_NAME = (TYPEOF(le.Input_BUSINESS_NAME))'','',':BUSINESS_NAME')
    #END
 
+    #IF( #TEXT(Input_PHONE_NBR)='' )
      '' 
    #ELSE
        IF( le.Input_PHONE_NBR = (TYPEOF(le.Input_PHONE_NBR))'','',':PHONE_NBR')
    #END
 
+    #IF( #TEXT(Input_FILE_DATE)='' )
      '' 
    #ELSE
        IF( le.Input_FILE_DATE = (TYPEOF(le.Input_FILE_DATE))'','',':FILE_DATE')
    #END
 
+    #IF( #TEXT(Input_FIRST_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_FIRST_NAME = (TYPEOF(le.Input_FIRST_NAME))'','',':FIRST_NAME')
    #END
 
+    #IF( #TEXT(Input_MIDDLE_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_MIDDLE_NAME = (TYPEOF(le.Input_MIDDLE_NAME))'','',':MIDDLE_NAME')
    #END
 
+    #IF( #TEXT(Input_LAST_NAME_COMPANY)='' )
      '' 
    #ELSE
        IF( le.Input_LAST_NAME_COMPANY = (TYPEOF(le.Input_LAST_NAME_COMPANY))'','',':LAST_NAME_COMPANY')
    #END
 
+    #IF( #TEXT(Input_OWNER_ADDRESS)='' )
      '' 
    #ELSE
        IF( le.Input_OWNER_ADDRESS = (TYPEOF(le.Input_OWNER_ADDRESS))'','',':OWNER_ADDRESS')
    #END
 
+    #IF( #TEXT(Input_prep_bus_addr_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_bus_addr_line1 = (TYPEOF(le.Input_prep_bus_addr_line1))'','',':prep_bus_addr_line1')
    #END
 
+    #IF( #TEXT(Input_prep_bus_addr_line_last)='' )
      '' 
    #ELSE
        IF( le.Input_prep_bus_addr_line_last = (TYPEOF(le.Input_prep_bus_addr_line_last))'','',':prep_bus_addr_line_last')
    #END
 
+    #IF( #TEXT(Input_prep_owner_addr_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_owner_addr_line1 = (TYPEOF(le.Input_prep_owner_addr_line1))'','',':prep_owner_addr_line1')
    #END
 
+    #IF( #TEXT(Input_prep_owner_addr_line_last)='' )
      '' 
    #ELSE
        IF( le.Input_prep_owner_addr_line_last = (TYPEOF(le.Input_prep_owner_addr_line_last))'','',':prep_owner_addr_line_last')
    #END
 
+    #IF( #TEXT(Input_cname)='' )
      '' 
    #ELSE
        IF( le.Input_cname = (TYPEOF(le.Input_cname))'','',':cname')
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
