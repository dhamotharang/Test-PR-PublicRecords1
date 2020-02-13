 
EXPORT raw_MAC_PopulationStatistics(infile,Ref='',Input_employee_name = '',Input_duty_station = '',Input_country = '',Input_state = '',Input_city = '',Input_county = '',Input_agency = '',Input_agency_sub_element = '',Input_computation_date = '',Input_occupational_series = '',Input_file_date = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_OPM;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_employee_name)='' )
      '' 
    #ELSE
        IF( le.Input_employee_name = (TYPEOF(le.Input_employee_name))'','',':employee_name')
    #END
 
+    #IF( #TEXT(Input_duty_station)='' )
      '' 
    #ELSE
        IF( le.Input_duty_station = (TYPEOF(le.Input_duty_station))'','',':duty_station')
    #END
 
+    #IF( #TEXT(Input_country)='' )
      '' 
    #ELSE
        IF( le.Input_country = (TYPEOF(le.Input_country))'','',':country')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
 
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
    #END
 
+    #IF( #TEXT(Input_agency)='' )
      '' 
    #ELSE
        IF( le.Input_agency = (TYPEOF(le.Input_agency))'','',':agency')
    #END
 
+    #IF( #TEXT(Input_agency_sub_element)='' )
      '' 
    #ELSE
        IF( le.Input_agency_sub_element = (TYPEOF(le.Input_agency_sub_element))'','',':agency_sub_element')
    #END
 
+    #IF( #TEXT(Input_computation_date)='' )
      '' 
    #ELSE
        IF( le.Input_computation_date = (TYPEOF(le.Input_computation_date))'','',':computation_date')
    #END
 
+    #IF( #TEXT(Input_occupational_series)='' )
      '' 
    #ELSE
        IF( le.Input_occupational_series = (TYPEOF(le.Input_occupational_series))'','',':occupational_series')
    #END
 
+    #IF( #TEXT(Input_file_date)='' )
      '' 
    #ELSE
        IF( le.Input_file_date = (TYPEOF(le.Input_file_date))'','',':file_date')
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
