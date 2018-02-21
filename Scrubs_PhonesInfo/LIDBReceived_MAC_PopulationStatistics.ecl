 
EXPORT LIDBReceived_MAC_PopulationStatistics(infile,Ref='',Input_reference_id = '',Input_phone = '',Input_reply_code = '',Input_local_routing_number = '',Input_account_owner = '',Input_carrier_name = '',Input_carrier_category = '',Input_local_area_transport_area = '',Input_point_code = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
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
