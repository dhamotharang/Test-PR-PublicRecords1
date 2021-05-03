EXPORT MAC_PopulationStatistics(infile,Ref='',Input_agency_id = '',Input_agency_name = '',Input_source_id = '',Input_agency_state_abbr = '',Input_agency_ori = '',Input_allow_open_search = '',Input_append_overwrite_flag = '',Input_drivers_exchange_flag = '',Input_source_start_date = '',Input_source_end_date = '',Input_source_termination_date = '',Input_source_resale_allowed = '',Input_source_auto_renew = '',Input_source_allow_sale_of_component_data = '',Input_source_allow_extract_of_vehicle_data = '',OutFile) := MACRO
  IMPORT SALT37,Scrubs_eCrash_MBSAgency;
  #uniquename(of)
  %of% := RECORD
    SALT37.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_agency_id)='' )
      '' 
    #ELSE
        IF( le.Input_agency_id = (TYPEOF(le.Input_agency_id))'','',':agency_id')
    #END
+    #IF( #TEXT(Input_agency_name)='' )
      '' 
    #ELSE
        IF( le.Input_agency_name = (TYPEOF(le.Input_agency_name))'','',':agency_name')
    #END
+    #IF( #TEXT(Input_source_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_id = (TYPEOF(le.Input_source_id))'','',':source_id')
    #END
+    #IF( #TEXT(Input_agency_state_abbr)='' )
      '' 
    #ELSE
        IF( le.Input_agency_state_abbr = (TYPEOF(le.Input_agency_state_abbr))'','',':agency_state_abbr')
    #END
+    #IF( #TEXT(Input_agency_ori)='' )
      '' 
    #ELSE
        IF( le.Input_agency_ori = (TYPEOF(le.Input_agency_ori))'','',':agency_ori')
    #END
+    #IF( #TEXT(Input_allow_open_search)='' )
      '' 
    #ELSE
        IF( le.Input_allow_open_search = (TYPEOF(le.Input_allow_open_search))'','',':allow_open_search')
    #END
+    #IF( #TEXT(Input_append_overwrite_flag)='' )
      '' 
    #ELSE
        IF( le.Input_append_overwrite_flag = (TYPEOF(le.Input_append_overwrite_flag))'','',':append_overwrite_flag')
    #END
+    #IF( #TEXT(Input_drivers_exchange_flag)='' )
      '' 
    #ELSE
        IF( le.Input_drivers_exchange_flag = (TYPEOF(le.Input_drivers_exchange_flag))'','',':drivers_exchange_flag')
    #END
+    #IF( #TEXT(Input_source_start_date)='' )
      '' 
    #ELSE
        IF( le.Input_source_start_date = (TYPEOF(le.Input_source_start_date))'','',':source_start_date')
    #END
+    #IF( #TEXT(Input_source_end_date)='' )
      '' 
    #ELSE
        IF( le.Input_source_end_date = (TYPEOF(le.Input_source_end_date))'','',':source_end_date')
    #END
+    #IF( #TEXT(Input_source_termination_date)='' )
      '' 
    #ELSE
        IF( le.Input_source_termination_date = (TYPEOF(le.Input_source_termination_date))'','',':source_termination_date')
    #END
+    #IF( #TEXT(Input_source_resale_allowed)='' )
      '' 
    #ELSE
        IF( le.Input_source_resale_allowed = (TYPEOF(le.Input_source_resale_allowed))'','',':source_resale_allowed')
    #END
+    #IF( #TEXT(Input_source_auto_renew)='' )
      '' 
    #ELSE
        IF( le.Input_source_auto_renew = (TYPEOF(le.Input_source_auto_renew))'','',':source_auto_renew')
    #END
+    #IF( #TEXT(Input_source_allow_sale_of_component_data)='' )
      '' 
    #ELSE
        IF( le.Input_source_allow_sale_of_component_data = (TYPEOF(le.Input_source_allow_sale_of_component_data))'','',':source_allow_sale_of_component_data')
    #END
+    #IF( #TEXT(Input_source_allow_extract_of_vehicle_data)='' )
      '' 
    #ELSE
        IF( le.Input_source_allow_extract_of_vehicle_data = (TYPEOF(le.Input_source_allow_extract_of_vehicle_data))'','',':source_allow_extract_of_vehicle_data')
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
