 
EXPORT Input_CA_Ventura_MAC_PopulationStatistics(infile,Ref='',Input_recorded_date = '',Input_business_name = '',Input_owner_name = '',Input_start_date = '',Input_abandondate = '',Input_file_number = '',Input_prep_bus_addr_line1 = '',Input_prep_bus_addr_line_last = '',Input_prep_owner_addr_line1 = '',Input_prep_owner_addr_line_last = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_FBNV2;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_recorded_date)='' )
      '' 
    #ELSE
        IF( le.Input_recorded_date = (TYPEOF(le.Input_recorded_date))'','',':recorded_date')
    #END
 
+    #IF( #TEXT(Input_business_name)='' )
      '' 
    #ELSE
        IF( le.Input_business_name = (TYPEOF(le.Input_business_name))'','',':business_name')
    #END
 
+    #IF( #TEXT(Input_owner_name)='' )
      '' 
    #ELSE
        IF( le.Input_owner_name = (TYPEOF(le.Input_owner_name))'','',':owner_name')
    #END
 
+    #IF( #TEXT(Input_start_date)='' )
      '' 
    #ELSE
        IF( le.Input_start_date = (TYPEOF(le.Input_start_date))'','',':start_date')
    #END
 
+    #IF( #TEXT(Input_abandondate)='' )
      '' 
    #ELSE
        IF( le.Input_abandondate = (TYPEOF(le.Input_abandondate))'','',':abandondate')
    #END
 
+    #IF( #TEXT(Input_file_number)='' )
      '' 
    #ELSE
        IF( le.Input_file_number = (TYPEOF(le.Input_file_number))'','',':file_number')
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
