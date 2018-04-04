 
EXPORT iConectivMain_MAC_PopulationStatistics(infile,Ref='',Input_country_code = '',Input_phone = '',Input_dial_type = '',Input_spid = '',Input_service_provider = '',Input_service_type = '',Input_routing_code = '',Input_porting_dt = '',Input_country_abbr = '',Input_filename = '',Input_file_dt_time = '',Input_vendor_first_reported_dt = '',Input_vendor_last_reported_dt = '',Input_port_start_dt = '',Input_port_end_dt = '',Input_remove_port_dt = '',Input_is_ported = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_PhonesInfo;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_country_code)='' )
      '' 
    #ELSE
        IF( le.Input_country_code = (TYPEOF(le.Input_country_code))'','',':country_code')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_dial_type)='' )
      '' 
    #ELSE
        IF( le.Input_dial_type = (TYPEOF(le.Input_dial_type))'','',':dial_type')
    #END
 
+    #IF( #TEXT(Input_spid)='' )
      '' 
    #ELSE
        IF( le.Input_spid = (TYPEOF(le.Input_spid))'','',':spid')
    #END
 
+    #IF( #TEXT(Input_service_provider)='' )
      '' 
    #ELSE
        IF( le.Input_service_provider = (TYPEOF(le.Input_service_provider))'','',':service_provider')
    #END
 
+    #IF( #TEXT(Input_service_type)='' )
      '' 
    #ELSE
        IF( le.Input_service_type = (TYPEOF(le.Input_service_type))'','',':service_type')
    #END
 
+    #IF( #TEXT(Input_routing_code)='' )
      '' 
    #ELSE
        IF( le.Input_routing_code = (TYPEOF(le.Input_routing_code))'','',':routing_code')
    #END
 
+    #IF( #TEXT(Input_porting_dt)='' )
      '' 
    #ELSE
        IF( le.Input_porting_dt = (TYPEOF(le.Input_porting_dt))'','',':porting_dt')
    #END
 
+    #IF( #TEXT(Input_country_abbr)='' )
      '' 
    #ELSE
        IF( le.Input_country_abbr = (TYPEOF(le.Input_country_abbr))'','',':country_abbr')
    #END
 
+    #IF( #TEXT(Input_filename)='' )
      '' 
    #ELSE
        IF( le.Input_filename = (TYPEOF(le.Input_filename))'','',':filename')
    #END
 
+    #IF( #TEXT(Input_file_dt_time)='' )
      '' 
    #ELSE
        IF( le.Input_file_dt_time = (TYPEOF(le.Input_file_dt_time))'','',':file_dt_time')
    #END
 
+    #IF( #TEXT(Input_vendor_first_reported_dt)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_first_reported_dt = (TYPEOF(le.Input_vendor_first_reported_dt))'','',':vendor_first_reported_dt')
    #END
 
+    #IF( #TEXT(Input_vendor_last_reported_dt)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_last_reported_dt = (TYPEOF(le.Input_vendor_last_reported_dt))'','',':vendor_last_reported_dt')
    #END
 
+    #IF( #TEXT(Input_port_start_dt)='' )
      '' 
    #ELSE
        IF( le.Input_port_start_dt = (TYPEOF(le.Input_port_start_dt))'','',':port_start_dt')
    #END
 
+    #IF( #TEXT(Input_port_end_dt)='' )
      '' 
    #ELSE
        IF( le.Input_port_end_dt = (TYPEOF(le.Input_port_end_dt))'','',':port_end_dt')
    #END
 
+    #IF( #TEXT(Input_remove_port_dt)='' )
      '' 
    #ELSE
        IF( le.Input_remove_port_dt = (TYPEOF(le.Input_remove_port_dt))'','',':remove_port_dt')
    #END
 
+    #IF( #TEXT(Input_is_ported)='' )
      '' 
    #ELSE
        IF( le.Input_is_ported = (TYPEOF(le.Input_is_ported))'','',':is_ported')
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
