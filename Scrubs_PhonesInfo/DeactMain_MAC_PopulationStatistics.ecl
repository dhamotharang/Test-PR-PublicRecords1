
EXPORT DeactMain_MAC_PopulationStatistics(infile,Ref='',Input_vendor_first_reported_dt = '',Input_vendor_last_reported_dt = '',Input_action_code = '',Input_timestamp = '',Input_phone = '',Input_phone_swap = '',Input_filename = '',Input_carrier_name = '',Input_filedate = '',Input_swap_start_dt = '',Input_swap_end_dt = '',Input_deact_code = '',Input_deact_start_dt = '',Input_deact_end_dt = '',Input_react_start_dt = '',Input_react_end_dt = '',Input_is_react = '',Input_is_deact = '',Input_porting_dt = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_PhonesInfo;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_vendor_first_reported_dt)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_first_reported_dt = (TYPEOF(le.Input_vendor_first_reported_dt))'','',':vendor_first_reported_dt')
    #END

+    #IF( #TEXT(Input_vendor_last_reported_dt)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_last_reported_dt = (TYPEOF(le.Input_vendor_last_reported_dt))'','',':vendor_last_reported_dt')
    #END

+    #IF( #TEXT(Input_action_code)='' )
      '' 
    #ELSE
        IF( le.Input_action_code = (TYPEOF(le.Input_action_code))'','',':action_code')
    #END

+    #IF( #TEXT(Input_timestamp)='' )
      '' 
    #ELSE
        IF( le.Input_timestamp = (TYPEOF(le.Input_timestamp))'','',':timestamp')
    #END

+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END

+    #IF( #TEXT(Input_phone_swap)='' )
      '' 
    #ELSE
        IF( le.Input_phone_swap = (TYPEOF(le.Input_phone_swap))'','',':phone_swap')
    #END

+    #IF( #TEXT(Input_filename)='' )
      '' 
    #ELSE
        IF( le.Input_filename = (TYPEOF(le.Input_filename))'','',':filename')
    #END

+    #IF( #TEXT(Input_carrier_name)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_name = (TYPEOF(le.Input_carrier_name))'','',':carrier_name')
    #END

+    #IF( #TEXT(Input_filedate)='' )
      '' 
    #ELSE
        IF( le.Input_filedate = (TYPEOF(le.Input_filedate))'','',':filedate')
    #END

+    #IF( #TEXT(Input_swap_start_dt)='' )
      '' 
    #ELSE
        IF( le.Input_swap_start_dt = (TYPEOF(le.Input_swap_start_dt))'','',':swap_start_dt')
    #END

+    #IF( #TEXT(Input_swap_end_dt)='' )
      '' 
    #ELSE
        IF( le.Input_swap_end_dt = (TYPEOF(le.Input_swap_end_dt))'','',':swap_end_dt')
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

+    #IF( #TEXT(Input_deact_end_dt)='' )
      '' 
    #ELSE
        IF( le.Input_deact_end_dt = (TYPEOF(le.Input_deact_end_dt))'','',':deact_end_dt')
    #END

+    #IF( #TEXT(Input_react_start_dt)='' )
      '' 
    #ELSE
        IF( le.Input_react_start_dt = (TYPEOF(le.Input_react_start_dt))'','',':react_start_dt')
    #END

+    #IF( #TEXT(Input_react_end_dt)='' )
      '' 
    #ELSE
        IF( le.Input_react_end_dt = (TYPEOF(le.Input_react_end_dt))'','',':react_end_dt')
    #END

+    #IF( #TEXT(Input_is_react)='' )
      '' 
    #ELSE
        IF( le.Input_is_react = (TYPEOF(le.Input_is_react))'','',':is_react')
    #END

+    #IF( #TEXT(Input_is_deact)='' )
      '' 
    #ELSE
        IF( le.Input_is_deact = (TYPEOF(le.Input_is_deact))'','',':is_deact')
    #END

+    #IF( #TEXT(Input_porting_dt)='' )
      '' 
    #ELSE
        IF( le.Input_porting_dt = (TYPEOF(le.Input_porting_dt))'','',':porting_dt')
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
