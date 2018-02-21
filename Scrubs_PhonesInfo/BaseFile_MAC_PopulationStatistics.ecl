 
EXPORT BaseFile_MAC_PopulationStatistics(infile,Ref='',Input_reference_id = '',Input_source = '',Input_dt_first_reported = '',Input_dt_last_reported = '',Input_phone = '',Input_phonetype = '',Input_reply_code = '',Input_local_routing_number = '',Input_account_owner = '',Input_carrier_name = '',Input_carrier_category = '',Input_local_area_transport_area = '',Input_point_code = '',Input_country_code = '',Input_dial_type = '',Input_routing_code = '',Input_porting_dt = '',Input_porting_time = '',Input_country_abbr = '',Input_vendor_first_reported_dt = '',Input_vendor_first_reported_time = '',Input_vendor_last_reported_dt = '',Input_vendor_last_reported_time = '',Input_port_start_dt = '',Input_port_start_time = '',Input_port_end_dt = '',Input_port_end_time = '',Input_remove_port_dt = '',Input_is_ported = '',Input_serv = '',Input_line = '',Input_spid = '',Input_operator_fullname = '',Input_number_in_service = '',Input_high_risk_indicator = '',Input_prepaid = '',Input_phone_swap = '',Input_swap_start_dt = '',Input_swap_start_time = '',Input_swap_end_dt = '',Input_swap_end_time = '',Input_deact_code = '',Input_deact_start_dt = '',Input_deact_start_time = '',Input_deact_end_dt = '',Input_deact_end_time = '',Input_react_start_dt = '',Input_react_start_time = '',Input_react_end_dt = '',Input_react_end_time = '',Input_is_deact = '',Input_is_react = '',Input_call_forward_dt = '',Input_caller_id = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_PhonesInfo;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_reference_id)='' )
      '' 
    #ELSE
        IF( le.Input_reference_id = (TYPEOF(le.Input_reference_id))'','',':reference_id')
    #END
 
+    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
    #END
 
+    #IF( #TEXT(Input_dt_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_reported = (TYPEOF(le.Input_dt_first_reported))'','',':dt_first_reported')
    #END
 
+    #IF( #TEXT(Input_dt_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_reported = (TYPEOF(le.Input_dt_last_reported))'','',':dt_last_reported')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_phonetype)='' )
      '' 
    #ELSE
        IF( le.Input_phonetype = (TYPEOF(le.Input_phonetype))'','',':phonetype')
    #END
 
+    #IF( #TEXT(Input_reply_code)='' )
      '' 
    #ELSE
        IF( le.Input_reply_code = (TYPEOF(le.Input_reply_code))'','',':reply_code')
    #END
 
+    #IF( #TEXT(Input_local_routing_number)='' )
      '' 
    #ELSE
        IF( le.Input_local_routing_number = (TYPEOF(le.Input_local_routing_number))'','',':local_routing_number')
    #END
 
+    #IF( #TEXT(Input_account_owner)='' )
      '' 
    #ELSE
        IF( le.Input_account_owner = (TYPEOF(le.Input_account_owner))'','',':account_owner')
    #END
 
+    #IF( #TEXT(Input_carrier_name)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_name = (TYPEOF(le.Input_carrier_name))'','',':carrier_name')
    #END
 
+    #IF( #TEXT(Input_carrier_category)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_category = (TYPEOF(le.Input_carrier_category))'','',':carrier_category')
    #END
 
+    #IF( #TEXT(Input_local_area_transport_area)='' )
      '' 
    #ELSE
        IF( le.Input_local_area_transport_area = (TYPEOF(le.Input_local_area_transport_area))'','',':local_area_transport_area')
    #END
 
+    #IF( #TEXT(Input_point_code)='' )
      '' 
    #ELSE
        IF( le.Input_point_code = (TYPEOF(le.Input_point_code))'','',':point_code')
    #END
 
+    #IF( #TEXT(Input_country_code)='' )
      '' 
    #ELSE
        IF( le.Input_country_code = (TYPEOF(le.Input_country_code))'','',':country_code')
    #END
 
+    #IF( #TEXT(Input_dial_type)='' )
      '' 
    #ELSE
        IF( le.Input_dial_type = (TYPEOF(le.Input_dial_type))'','',':dial_type')
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
 
+    #IF( #TEXT(Input_porting_time)='' )
      '' 
    #ELSE
        IF( le.Input_porting_time = (TYPEOF(le.Input_porting_time))'','',':porting_time')
    #END
 
+    #IF( #TEXT(Input_country_abbr)='' )
      '' 
    #ELSE
        IF( le.Input_country_abbr = (TYPEOF(le.Input_country_abbr))'','',':country_abbr')
    #END
 
+    #IF( #TEXT(Input_vendor_first_reported_dt)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_first_reported_dt = (TYPEOF(le.Input_vendor_first_reported_dt))'','',':vendor_first_reported_dt')
    #END
 
+    #IF( #TEXT(Input_vendor_first_reported_time)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_first_reported_time = (TYPEOF(le.Input_vendor_first_reported_time))'','',':vendor_first_reported_time')
    #END
 
+    #IF( #TEXT(Input_vendor_last_reported_dt)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_last_reported_dt = (TYPEOF(le.Input_vendor_last_reported_dt))'','',':vendor_last_reported_dt')
    #END
 
+    #IF( #TEXT(Input_vendor_last_reported_time)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_last_reported_time = (TYPEOF(le.Input_vendor_last_reported_time))'','',':vendor_last_reported_time')
    #END
 
+    #IF( #TEXT(Input_port_start_dt)='' )
      '' 
    #ELSE
        IF( le.Input_port_start_dt = (TYPEOF(le.Input_port_start_dt))'','',':port_start_dt')
    #END
 
+    #IF( #TEXT(Input_port_start_time)='' )
      '' 
    #ELSE
        IF( le.Input_port_start_time = (TYPEOF(le.Input_port_start_time))'','',':port_start_time')
    #END
 
+    #IF( #TEXT(Input_port_end_dt)='' )
      '' 
    #ELSE
        IF( le.Input_port_end_dt = (TYPEOF(le.Input_port_end_dt))'','',':port_end_dt')
    #END
 
+    #IF( #TEXT(Input_port_end_time)='' )
      '' 
    #ELSE
        IF( le.Input_port_end_time = (TYPEOF(le.Input_port_end_time))'','',':port_end_time')
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
 
+    #IF( #TEXT(Input_serv)='' )
      '' 
    #ELSE
        IF( le.Input_serv = (TYPEOF(le.Input_serv))'','',':serv')
    #END
 
+    #IF( #TEXT(Input_line)='' )
      '' 
    #ELSE
        IF( le.Input_line = (TYPEOF(le.Input_line))'','',':line')
    #END
 
+    #IF( #TEXT(Input_spid)='' )
      '' 
    #ELSE
        IF( le.Input_spid = (TYPEOF(le.Input_spid))'','',':spid')
    #END
 
+    #IF( #TEXT(Input_operator_fullname)='' )
      '' 
    #ELSE
        IF( le.Input_operator_fullname = (TYPEOF(le.Input_operator_fullname))'','',':operator_fullname')
    #END
 
+    #IF( #TEXT(Input_number_in_service)='' )
      '' 
    #ELSE
        IF( le.Input_number_in_service = (TYPEOF(le.Input_number_in_service))'','',':number_in_service')
    #END
 
+    #IF( #TEXT(Input_high_risk_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_high_risk_indicator = (TYPEOF(le.Input_high_risk_indicator))'','',':high_risk_indicator')
    #END
 
+    #IF( #TEXT(Input_prepaid)='' )
      '' 
    #ELSE
        IF( le.Input_prepaid = (TYPEOF(le.Input_prepaid))'','',':prepaid')
    #END
 
+    #IF( #TEXT(Input_phone_swap)='' )
      '' 
    #ELSE
        IF( le.Input_phone_swap = (TYPEOF(le.Input_phone_swap))'','',':phone_swap')
    #END
 
+    #IF( #TEXT(Input_swap_start_dt)='' )
      '' 
    #ELSE
        IF( le.Input_swap_start_dt = (TYPEOF(le.Input_swap_start_dt))'','',':swap_start_dt')
    #END
 
+    #IF( #TEXT(Input_swap_start_time)='' )
      '' 
    #ELSE
        IF( le.Input_swap_start_time = (TYPEOF(le.Input_swap_start_time))'','',':swap_start_time')
    #END
 
+    #IF( #TEXT(Input_swap_end_dt)='' )
      '' 
    #ELSE
        IF( le.Input_swap_end_dt = (TYPEOF(le.Input_swap_end_dt))'','',':swap_end_dt')
    #END
 
+    #IF( #TEXT(Input_swap_end_time)='' )
      '' 
    #ELSE
        IF( le.Input_swap_end_time = (TYPEOF(le.Input_swap_end_time))'','',':swap_end_time')
    #END
 
+    #IF( #TEXT(Input_deact_code)='' )
      '' 
    #ELSE
        IF( le.Input_deact_code = (TYPEOF(le.Input_deact_code))'','',':deact_code')
    #END
 
+    #IF( #TEXT(Input_deact_start_dt)='' )
      '' 
    #ELSE
        IF( le.Input_deact_start_dt = (TYPEOF(le.Input_deact_start_dt))'','',':deact_start_dt')
    #END
 
+    #IF( #TEXT(Input_deact_start_time)='' )
      '' 
    #ELSE
        IF( le.Input_deact_start_time = (TYPEOF(le.Input_deact_start_time))'','',':deact_start_time')
    #END
 
+    #IF( #TEXT(Input_deact_end_dt)='' )
      '' 
    #ELSE
        IF( le.Input_deact_end_dt = (TYPEOF(le.Input_deact_end_dt))'','',':deact_end_dt')
    #END
 
+    #IF( #TEXT(Input_deact_end_time)='' )
      '' 
    #ELSE
        IF( le.Input_deact_end_time = (TYPEOF(le.Input_deact_end_time))'','',':deact_end_time')
    #END
 
+    #IF( #TEXT(Input_react_start_dt)='' )
      '' 
    #ELSE
        IF( le.Input_react_start_dt = (TYPEOF(le.Input_react_start_dt))'','',':react_start_dt')
    #END
 
+    #IF( #TEXT(Input_react_start_time)='' )
      '' 
    #ELSE
        IF( le.Input_react_start_time = (TYPEOF(le.Input_react_start_time))'','',':react_start_time')
    #END
 
+    #IF( #TEXT(Input_react_end_dt)='' )
      '' 
    #ELSE
        IF( le.Input_react_end_dt = (TYPEOF(le.Input_react_end_dt))'','',':react_end_dt')
    #END
 
+    #IF( #TEXT(Input_react_end_time)='' )
      '' 
    #ELSE
        IF( le.Input_react_end_time = (TYPEOF(le.Input_react_end_time))'','',':react_end_time')
    #END
 
+    #IF( #TEXT(Input_is_deact)='' )
      '' 
    #ELSE
        IF( le.Input_is_deact = (TYPEOF(le.Input_is_deact))'','',':is_deact')
    #END
 
+    #IF( #TEXT(Input_is_react)='' )
      '' 
    #ELSE
        IF( le.Input_is_react = (TYPEOF(le.Input_is_react))'','',':is_react')
    #END
 
+    #IF( #TEXT(Input_call_forward_dt)='' )
      '' 
    #ELSE
        IF( le.Input_call_forward_dt = (TYPEOF(le.Input_call_forward_dt))'','',':call_forward_dt')
    #END
 
+    #IF( #TEXT(Input_caller_id)='' )
      '' 
    #ELSE
        IF( le.Input_caller_id = (TYPEOF(le.Input_caller_id))'','',':caller_id')
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
