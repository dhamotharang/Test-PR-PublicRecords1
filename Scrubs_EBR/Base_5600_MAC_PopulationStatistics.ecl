 
EXPORT Base_5600_MAC_PopulationStatistics(infile,Ref='',Input_powid = '',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_bdid = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_process_date_first_seen = '',Input_process_date_last_seen = '',Input_record_type = '',Input_process_date = '',Input_file_number = '',Input_segment_code = '',Input_sequence_number = '',Input_sic_1_code = '',Input_sic_1_desc = '',Input_sic_2_code = '',Input_sic_2_desc = '',Input_sic_3_code = '',Input_sic_3_desc = '',Input_sic_4_code = '',Input_sic_4_desc = '',Input_yrs_in_bus_actual = '',Input_sales_actual = '',Input_empl_size_actual = '',Input_bus_type_code = '',Input_bus_type_desc = '',Input_owner_type_code = '',Input_owner_type_desc = '',Input_location_code = '',Input_location_desc = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_EBR;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_powid)='' )
      '' 
    #ELSE
        IF( le.Input_powid = (TYPEOF(le.Input_powid))'','',':powid')
    #END
 
+    #IF( #TEXT(Input_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_proxid = (TYPEOF(le.Input_proxid))'','',':proxid')
    #END
 
+    #IF( #TEXT(Input_seleid)='' )
      '' 
    #ELSE
        IF( le.Input_seleid = (TYPEOF(le.Input_seleid))'','',':seleid')
    #END
 
+    #IF( #TEXT(Input_orgid)='' )
      '' 
    #ELSE
        IF( le.Input_orgid = (TYPEOF(le.Input_orgid))'','',':orgid')
    #END
 
+    #IF( #TEXT(Input_ultid)='' )
      '' 
    #ELSE
        IF( le.Input_ultid = (TYPEOF(le.Input_ultid))'','',':ultid')
    #END
 
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
 
+    #IF( #TEXT(Input_date_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_first_seen = (TYPEOF(le.Input_date_first_seen))'','',':date_first_seen')
    #END
 
+    #IF( #TEXT(Input_date_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_last_seen = (TYPEOF(le.Input_date_last_seen))'','',':date_last_seen')
    #END
 
+    #IF( #TEXT(Input_process_date_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_process_date_first_seen = (TYPEOF(le.Input_process_date_first_seen))'','',':process_date_first_seen')
    #END
 
+    #IF( #TEXT(Input_process_date_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_process_date_last_seen = (TYPEOF(le.Input_process_date_last_seen))'','',':process_date_last_seen')
    #END
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_file_number)='' )
      '' 
    #ELSE
        IF( le.Input_file_number = (TYPEOF(le.Input_file_number))'','',':file_number')
    #END
 
+    #IF( #TEXT(Input_segment_code)='' )
      '' 
    #ELSE
        IF( le.Input_segment_code = (TYPEOF(le.Input_segment_code))'','',':segment_code')
    #END
 
+    #IF( #TEXT(Input_sequence_number)='' )
      '' 
    #ELSE
        IF( le.Input_sequence_number = (TYPEOF(le.Input_sequence_number))'','',':sequence_number')
    #END
 
+    #IF( #TEXT(Input_sic_1_code)='' )
      '' 
    #ELSE
        IF( le.Input_sic_1_code = (TYPEOF(le.Input_sic_1_code))'','',':sic_1_code')
    #END
 
+    #IF( #TEXT(Input_sic_1_desc)='' )
      '' 
    #ELSE
        IF( le.Input_sic_1_desc = (TYPEOF(le.Input_sic_1_desc))'','',':sic_1_desc')
    #END
 
+    #IF( #TEXT(Input_sic_2_code)='' )
      '' 
    #ELSE
        IF( le.Input_sic_2_code = (TYPEOF(le.Input_sic_2_code))'','',':sic_2_code')
    #END
 
+    #IF( #TEXT(Input_sic_2_desc)='' )
      '' 
    #ELSE
        IF( le.Input_sic_2_desc = (TYPEOF(le.Input_sic_2_desc))'','',':sic_2_desc')
    #END
 
+    #IF( #TEXT(Input_sic_3_code)='' )
      '' 
    #ELSE
        IF( le.Input_sic_3_code = (TYPEOF(le.Input_sic_3_code))'','',':sic_3_code')
    #END
 
+    #IF( #TEXT(Input_sic_3_desc)='' )
      '' 
    #ELSE
        IF( le.Input_sic_3_desc = (TYPEOF(le.Input_sic_3_desc))'','',':sic_3_desc')
    #END
 
+    #IF( #TEXT(Input_sic_4_code)='' )
      '' 
    #ELSE
        IF( le.Input_sic_4_code = (TYPEOF(le.Input_sic_4_code))'','',':sic_4_code')
    #END
 
+    #IF( #TEXT(Input_sic_4_desc)='' )
      '' 
    #ELSE
        IF( le.Input_sic_4_desc = (TYPEOF(le.Input_sic_4_desc))'','',':sic_4_desc')
    #END
 
+    #IF( #TEXT(Input_yrs_in_bus_actual)='' )
      '' 
    #ELSE
        IF( le.Input_yrs_in_bus_actual = (TYPEOF(le.Input_yrs_in_bus_actual))'','',':yrs_in_bus_actual')
    #END
 
+    #IF( #TEXT(Input_sales_actual)='' )
      '' 
    #ELSE
        IF( le.Input_sales_actual = (TYPEOF(le.Input_sales_actual))'','',':sales_actual')
    #END
 
+    #IF( #TEXT(Input_empl_size_actual)='' )
      '' 
    #ELSE
        IF( le.Input_empl_size_actual = (TYPEOF(le.Input_empl_size_actual))'','',':empl_size_actual')
    #END
 
+    #IF( #TEXT(Input_bus_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_bus_type_code = (TYPEOF(le.Input_bus_type_code))'','',':bus_type_code')
    #END
 
+    #IF( #TEXT(Input_bus_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_bus_type_desc = (TYPEOF(le.Input_bus_type_desc))'','',':bus_type_desc')
    #END
 
+    #IF( #TEXT(Input_owner_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_owner_type_code = (TYPEOF(le.Input_owner_type_code))'','',':owner_type_code')
    #END
 
+    #IF( #TEXT(Input_owner_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_owner_type_desc = (TYPEOF(le.Input_owner_type_desc))'','',':owner_type_desc')
    #END
 
+    #IF( #TEXT(Input_location_code)='' )
      '' 
    #ELSE
        IF( le.Input_location_code = (TYPEOF(le.Input_location_code))'','',':location_code')
    #END
 
+    #IF( #TEXT(Input_location_desc)='' )
      '' 
    #ELSE
        IF( le.Input_location_desc = (TYPEOF(le.Input_location_desc))'','',':location_desc')
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
