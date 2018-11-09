 
EXPORT license_MAC_PopulationStatistics(infile,Ref='',Input_batch_number = '',Input_incident_number = '',Input_party_number = '',Input_record_type = '',Input_order_number = '',Input_license_number = '',Input_license_type = '',Input_license_state = '',Input_cln_license_number = '',Input_std_type_desc = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_SANCTNKeys;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_batch_number)='' )
      '' 
    #ELSE
        IF( le.Input_batch_number = (TYPEOF(le.Input_batch_number))'','',':batch_number')
    #END
 
+    #IF( #TEXT(Input_incident_number)='' )
      '' 
    #ELSE
        IF( le.Input_incident_number = (TYPEOF(le.Input_incident_number))'','',':incident_number')
    #END
 
+    #IF( #TEXT(Input_party_number)='' )
      '' 
    #ELSE
        IF( le.Input_party_number = (TYPEOF(le.Input_party_number))'','',':party_number')
    #END
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_order_number)='' )
      '' 
    #ELSE
        IF( le.Input_order_number = (TYPEOF(le.Input_order_number))'','',':order_number')
    #END
 
+    #IF( #TEXT(Input_license_number)='' )
      '' 
    #ELSE
        IF( le.Input_license_number = (TYPEOF(le.Input_license_number))'','',':license_number')
    #END
 
+    #IF( #TEXT(Input_license_type)='' )
      '' 
    #ELSE
        IF( le.Input_license_type = (TYPEOF(le.Input_license_type))'','',':license_type')
    #END
 
+    #IF( #TEXT(Input_license_state)='' )
      '' 
    #ELSE
        IF( le.Input_license_state = (TYPEOF(le.Input_license_state))'','',':license_state')
    #END
 
+    #IF( #TEXT(Input_cln_license_number)='' )
      '' 
    #ELSE
        IF( le.Input_cln_license_number = (TYPEOF(le.Input_cln_license_number))'','',':cln_license_number')
    #END
 
+    #IF( #TEXT(Input_std_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_std_type_desc = (TYPEOF(le.Input_std_type_desc))'','',':std_type_desc')
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
