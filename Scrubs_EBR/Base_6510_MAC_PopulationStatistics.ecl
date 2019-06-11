 
EXPORT Base_6510_MAC_PopulationStatistics(infile,Ref='',Input_powid = '',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_bdid = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_process_date_first_seen = '',Input_process_date_last_seen = '',Input_record_type = '',Input_process_date = '',Input_file_number = '',Input_segment_code = '',Input_sequence_number = '',Input_orig_date_reported_yymmdd = '',Input_action_code = '',Input_action_desc = '',Input_co_bus_name = '',Input_co_bus_address = '',Input_co_bus_city = '',Input_co_bus_state_code = '',Input_co_bus_state_desc = '',Input_co_bus_zip = '',Input_extent_of_action = '',Input_agency_code = '',Input_agency_desc = '',Input_date_reported = '',Input_prep_addr_line1 = '',Input_prep_addr_last_line = '',Input_clean_business_address_prim_range = '',Input_clean_business_address_prim_name = '',Input_clean_business_address_p_city_name = '',Input_clean_business_address_v_city_name = '',Input_clean_business_address_st = '',Input_clean_business_address_zip = '',Input_clean_business_name_title = '',Input_clean_business_name_fname = '',Input_clean_business_name_mname = '',Input_clean_business_name_lname = '',Input_clean_business_name_name_suffix = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_orig_date_reported_yymmdd)='' )
      '' 
    #ELSE
        IF( le.Input_orig_date_reported_yymmdd = (TYPEOF(le.Input_orig_date_reported_yymmdd))'','',':orig_date_reported_yymmdd')
    #END
 
+    #IF( #TEXT(Input_action_code)='' )
      '' 
    #ELSE
        IF( le.Input_action_code = (TYPEOF(le.Input_action_code))'','',':action_code')
    #END
 
+    #IF( #TEXT(Input_action_desc)='' )
      '' 
    #ELSE
        IF( le.Input_action_desc = (TYPEOF(le.Input_action_desc))'','',':action_desc')
    #END
 
+    #IF( #TEXT(Input_co_bus_name)='' )
      '' 
    #ELSE
        IF( le.Input_co_bus_name = (TYPEOF(le.Input_co_bus_name))'','',':co_bus_name')
    #END
 
+    #IF( #TEXT(Input_co_bus_address)='' )
      '' 
    #ELSE
        IF( le.Input_co_bus_address = (TYPEOF(le.Input_co_bus_address))'','',':co_bus_address')
    #END
 
+    #IF( #TEXT(Input_co_bus_city)='' )
      '' 
    #ELSE
        IF( le.Input_co_bus_city = (TYPEOF(le.Input_co_bus_city))'','',':co_bus_city')
    #END
 
+    #IF( #TEXT(Input_co_bus_state_code)='' )
      '' 
    #ELSE
        IF( le.Input_co_bus_state_code = (TYPEOF(le.Input_co_bus_state_code))'','',':co_bus_state_code')
    #END
 
+    #IF( #TEXT(Input_co_bus_state_desc)='' )
      '' 
    #ELSE
        IF( le.Input_co_bus_state_desc = (TYPEOF(le.Input_co_bus_state_desc))'','',':co_bus_state_desc')
    #END
 
+    #IF( #TEXT(Input_co_bus_zip)='' )
      '' 
    #ELSE
        IF( le.Input_co_bus_zip = (TYPEOF(le.Input_co_bus_zip))'','',':co_bus_zip')
    #END
 
+    #IF( #TEXT(Input_extent_of_action)='' )
      '' 
    #ELSE
        IF( le.Input_extent_of_action = (TYPEOF(le.Input_extent_of_action))'','',':extent_of_action')
    #END
 
+    #IF( #TEXT(Input_agency_code)='' )
      '' 
    #ELSE
        IF( le.Input_agency_code = (TYPEOF(le.Input_agency_code))'','',':agency_code')
    #END
 
+    #IF( #TEXT(Input_agency_desc)='' )
      '' 
    #ELSE
        IF( le.Input_agency_desc = (TYPEOF(le.Input_agency_desc))'','',':agency_desc')
    #END
 
+    #IF( #TEXT(Input_date_reported)='' )
      '' 
    #ELSE
        IF( le.Input_date_reported = (TYPEOF(le.Input_date_reported))'','',':date_reported')
    #END
 
+    #IF( #TEXT(Input_prep_addr_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr_line1 = (TYPEOF(le.Input_prep_addr_line1))'','',':prep_addr_line1')
    #END
 
+    #IF( #TEXT(Input_prep_addr_last_line)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr_last_line = (TYPEOF(le.Input_prep_addr_last_line))'','',':prep_addr_last_line')
    #END
 
+    #IF( #TEXT(Input_clean_business_address_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_clean_business_address_prim_range = (TYPEOF(le.Input_clean_business_address_prim_range))'','',':clean_business_address_prim_range')
    #END
 
+    #IF( #TEXT(Input_clean_business_address_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_business_address_prim_name = (TYPEOF(le.Input_clean_business_address_prim_name))'','',':clean_business_address_prim_name')
    #END
 
+    #IF( #TEXT(Input_clean_business_address_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_business_address_p_city_name = (TYPEOF(le.Input_clean_business_address_p_city_name))'','',':clean_business_address_p_city_name')
    #END
 
+    #IF( #TEXT(Input_clean_business_address_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_business_address_v_city_name = (TYPEOF(le.Input_clean_business_address_v_city_name))'','',':clean_business_address_v_city_name')
    #END
 
+    #IF( #TEXT(Input_clean_business_address_st)='' )
      '' 
    #ELSE
        IF( le.Input_clean_business_address_st = (TYPEOF(le.Input_clean_business_address_st))'','',':clean_business_address_st')
    #END
 
+    #IF( #TEXT(Input_clean_business_address_zip)='' )
      '' 
    #ELSE
        IF( le.Input_clean_business_address_zip = (TYPEOF(le.Input_clean_business_address_zip))'','',':clean_business_address_zip')
    #END
 
+    #IF( #TEXT(Input_clean_business_name_title)='' )
      '' 
    #ELSE
        IF( le.Input_clean_business_name_title = (TYPEOF(le.Input_clean_business_name_title))'','',':clean_business_name_title')
    #END
 
+    #IF( #TEXT(Input_clean_business_name_fname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_business_name_fname = (TYPEOF(le.Input_clean_business_name_fname))'','',':clean_business_name_fname')
    #END
 
+    #IF( #TEXT(Input_clean_business_name_mname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_business_name_mname = (TYPEOF(le.Input_clean_business_name_mname))'','',':clean_business_name_mname')
    #END
 
+    #IF( #TEXT(Input_clean_business_name_lname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_business_name_lname = (TYPEOF(le.Input_clean_business_name_lname))'','',':clean_business_name_lname')
    #END
 
+    #IF( #TEXT(Input_clean_business_name_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_business_name_name_suffix = (TYPEOF(le.Input_clean_business_name_name_suffix))'','',':clean_business_name_name_suffix')
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
