 
EXPORT Activity_MAC_PopulationStatistics(infile,Ref='',Input_dt_first_reported = '',Input_dt_last_reported = '',Input_process_date = '',Input_vendor = '',Input_state_origin = '',Input_source_file = '',Input_case_key = '',Input_court_code = '',Input_court = '',Input_case_number = '',Input_event_date = '',Input_event_type_code = '',Input_event_type_description_1 = '',Input_event_type_description_2 = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_Civil_Court;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dt_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_reported = (TYPEOF(le.Input_dt_first_reported))'','',':dt_first_reported')
    #END
 
+    #IF( #TEXT(Input_dt_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_reported = (TYPEOF(le.Input_dt_last_reported))'','',':dt_last_reported')
    #END
 
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_vendor)='' )
      '' 
    #ELSE
        IF( le.Input_vendor = (TYPEOF(le.Input_vendor))'','',':vendor')
    #END
 
+    #IF( #TEXT(Input_state_origin)='' )
      '' 
    #ELSE
        IF( le.Input_state_origin = (TYPEOF(le.Input_state_origin))'','',':state_origin')
    #END
 
+    #IF( #TEXT(Input_source_file)='' )
      '' 
    #ELSE
        IF( le.Input_source_file = (TYPEOF(le.Input_source_file))'','',':source_file')
    #END
 
+    #IF( #TEXT(Input_case_key)='' )
      '' 
    #ELSE
        IF( le.Input_case_key = (TYPEOF(le.Input_case_key))'','',':case_key')
    #END
 
+    #IF( #TEXT(Input_court_code)='' )
      '' 
    #ELSE
        IF( le.Input_court_code = (TYPEOF(le.Input_court_code))'','',':court_code')
    #END
 
+    #IF( #TEXT(Input_court)='' )
      '' 
    #ELSE
        IF( le.Input_court = (TYPEOF(le.Input_court))'','',':court')
    #END
 
+    #IF( #TEXT(Input_case_number)='' )
      '' 
    #ELSE
        IF( le.Input_case_number = (TYPEOF(le.Input_case_number))'','',':case_number')
    #END
 
+    #IF( #TEXT(Input_event_date)='' )
      '' 
    #ELSE
        IF( le.Input_event_date = (TYPEOF(le.Input_event_date))'','',':event_date')
    #END
 
+    #IF( #TEXT(Input_event_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_event_type_code = (TYPEOF(le.Input_event_type_code))'','',':event_type_code')
    #END
 
+    #IF( #TEXT(Input_event_type_description_1)='' )
      '' 
    #ELSE
        IF( le.Input_event_type_description_1 = (TYPEOF(le.Input_event_type_description_1))'','',':event_type_description_1')
    #END
 
+    #IF( #TEXT(Input_event_type_description_2)='' )
      '' 
    #ELSE
        IF( le.Input_event_type_description_2 = (TYPEOF(le.Input_event_type_description_2))'','',':event_type_description_2')
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
