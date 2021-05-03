 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_carrier_id = '',Input_crash_id = '',Input_carrier_source_code = '',Input_carrier_name = '',Input_carrier_street = '',Input_carrier_city = '',Input_carrier_city_code = '',Input_carrier_state = '',Input_carrier_zip_code = '',Input_crash_colonia = '',Input_docket_number = '',Input_interstate = '',Input_no_id_flag = '',Input_state_number = '',Input_state_issuing_number = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_CrashCarrier;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_carrier_id)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_id = (TYPEOF(le.Input_carrier_id))'','',':carrier_id')
    #END
 
+    #IF( #TEXT(Input_crash_id)='' )
      '' 
    #ELSE
        IF( le.Input_crash_id = (TYPEOF(le.Input_crash_id))'','',':crash_id')
    #END
 
+    #IF( #TEXT(Input_carrier_source_code)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_source_code = (TYPEOF(le.Input_carrier_source_code))'','',':carrier_source_code')
    #END
 
+    #IF( #TEXT(Input_carrier_name)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_name = (TYPEOF(le.Input_carrier_name))'','',':carrier_name')
    #END
 
+    #IF( #TEXT(Input_carrier_street)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_street = (TYPEOF(le.Input_carrier_street))'','',':carrier_street')
    #END
 
+    #IF( #TEXT(Input_carrier_city)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_city = (TYPEOF(le.Input_carrier_city))'','',':carrier_city')
    #END
 
+    #IF( #TEXT(Input_carrier_city_code)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_city_code = (TYPEOF(le.Input_carrier_city_code))'','',':carrier_city_code')
    #END
 
+    #IF( #TEXT(Input_carrier_state)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_state = (TYPEOF(le.Input_carrier_state))'','',':carrier_state')
    #END
 
+    #IF( #TEXT(Input_carrier_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_zip_code = (TYPEOF(le.Input_carrier_zip_code))'','',':carrier_zip_code')
    #END
 
+    #IF( #TEXT(Input_crash_colonia)='' )
      '' 
    #ELSE
        IF( le.Input_crash_colonia = (TYPEOF(le.Input_crash_colonia))'','',':crash_colonia')
    #END
 
+    #IF( #TEXT(Input_docket_number)='' )
      '' 
    #ELSE
        IF( le.Input_docket_number = (TYPEOF(le.Input_docket_number))'','',':docket_number')
    #END
 
+    #IF( #TEXT(Input_interstate)='' )
      '' 
    #ELSE
        IF( le.Input_interstate = (TYPEOF(le.Input_interstate))'','',':interstate')
    #END
 
+    #IF( #TEXT(Input_no_id_flag)='' )
      '' 
    #ELSE
        IF( le.Input_no_id_flag = (TYPEOF(le.Input_no_id_flag))'','',':no_id_flag')
    #END
 
+    #IF( #TEXT(Input_state_number)='' )
      '' 
    #ELSE
        IF( le.Input_state_number = (TYPEOF(le.Input_state_number))'','',':state_number')
    #END
 
+    #IF( #TEXT(Input_state_issuing_number)='' )
      '' 
    #ELSE
        IF( le.Input_state_issuing_number = (TYPEOF(le.Input_state_issuing_number))'','',':state_issuing_number')
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
