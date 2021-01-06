 
EXPORT PhonesTransactionMain_MAC_PopulationStatistics(infile,Ref='',Input_phone = '',Input_source = '',Input_transaction_code = '',Input_transaction_start_dt = '',Input_transaction_start_time = '',Input_transaction_end_dt = '',Input_transaction_end_time = '',Input_transaction_count = '',Input_vendor_first_reported_dt = '',Input_vendor_first_reported_time = '',Input_vendor_last_reported_dt = '',Input_vendor_last_reported_time = '',Input_country_code = '',Input_country_abbr = '',Input_routing_code = '',Input_dial_type = '',Input_spid = '',Input_carrier_name = '',Input_phone_swap = '',Input_ocn = '',Input_global_sid = '',Input_record_sid = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_transaction_code)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_code = (TYPEOF(le.Input_transaction_code))'','',':transaction_code')
    #END
 
+    #IF( #TEXT(Input_transaction_start_dt)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_start_dt = (TYPEOF(le.Input_transaction_start_dt))'','',':transaction_start_dt')
    #END
 
+    #IF( #TEXT(Input_transaction_start_time)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_start_time = (TYPEOF(le.Input_transaction_start_time))'','',':transaction_start_time')
    #END
 
+    #IF( #TEXT(Input_transaction_end_dt)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_end_dt = (TYPEOF(le.Input_transaction_end_dt))'','',':transaction_end_dt')
    #END
 
+    #IF( #TEXT(Input_transaction_end_time)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_end_time = (TYPEOF(le.Input_transaction_end_time))'','',':transaction_end_time')
    #END
 
+    #IF( #TEXT(Input_transaction_count)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_count = (TYPEOF(le.Input_transaction_count))'','',':transaction_count')
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
 
+    #IF( #TEXT(Input_country_code)='' )
      '' 
    #ELSE
        IF( le.Input_country_code = (TYPEOF(le.Input_country_code))'','',':country_code')
    #END
 
+    #IF( #TEXT(Input_country_abbr)='' )
      '' 
    #ELSE
        IF( le.Input_country_abbr = (TYPEOF(le.Input_country_abbr))'','',':country_abbr')
    #END
 
+    #IF( #TEXT(Input_routing_code)='' )
      '' 
    #ELSE
        IF( le.Input_routing_code = (TYPEOF(le.Input_routing_code))'','',':routing_code')
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
 
+    #IF( #TEXT(Input_carrier_name)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_name = (TYPEOF(le.Input_carrier_name))'','',':carrier_name')
    #END
 
+    #IF( #TEXT(Input_phone_swap)='' )
      '' 
    #ELSE
        IF( le.Input_phone_swap = (TYPEOF(le.Input_phone_swap))'','',':phone_swap')
    #END
 
+    #IF( #TEXT(Input_ocn)='' )
      '' 
    #ELSE
        IF( le.Input_ocn = (TYPEOF(le.Input_ocn))'','',':ocn')
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
