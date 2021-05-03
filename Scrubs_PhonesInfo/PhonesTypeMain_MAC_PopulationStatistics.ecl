 
EXPORT PhonesTypeMain_MAC_PopulationStatistics(infile,Ref='',Input_phone = '',Input_source = '',Input_vendor_first_reported_dt = '',Input_vendor_first_reported_time = '',Input_vendor_last_reported_dt = '',Input_vendor_last_reported_time = '',Input_reference_id = '',Input_reply_code = '',Input_local_routing_number = '',Input_account_owner = '',Input_carrier_name = '',Input_carrier_category = '',Input_local_area_transport_area = '',Input_point_code = '',Input_serv = '',Input_line = '',Input_spid = '',Input_operator_fullname = '',Input_high_risk_indicator = '',Input_prepaid = '',Input_global_sid = '',Input_record_sid = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_PhonesInfo;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
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
 
+    #IF( #TEXT(Input_reference_id)='' )
      '' 
    #ELSE
        IF( le.Input_reference_id = (TYPEOF(le.Input_reference_id))'','',':reference_id')
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
 
+    #IF( #TEXT(Input_global_sid)='' )
      '' 
    #ELSE
        IF( le.Input_global_sid = (TYPEOF(le.Input_global_sid))'','',':global_sid')
    #END
 
+    #IF( #TEXT(Input_record_sid)='' )
      '' 
    #ELSE
        IF( le.Input_record_sid = (TYPEOF(le.Input_record_sid))'','',':record_sid')
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
