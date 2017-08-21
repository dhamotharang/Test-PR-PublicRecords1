EXPORT MAC_PopulationStatistics(infile,Ref='',dbcode='',Input_batch = '',Input_dbcode = '',Input_primary_key = '',Input_foreign_key = '',Input_incident_num = '',Input_number = '',Input_field_name = '',Input_code_type = '',Input_code_value = '',Input_code_state = '',Input_other_desc = '',Input_std_type_desc = '',Input_cln_license_number = '',OutFile) := MACRO
  IMPORT SALT33,Scrubs_SANCTN_NPKeys;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(dbcode)<>'')
    SALT33.StrType source;
    #END
    SALT33.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_batch)='' )
      '' 
    #ELSE
        IF( le.Input_batch = (TYPEOF(le.Input_batch))'','',':batch')
    #END
+    #IF( #TEXT(Input_dbcode)='' )
      '' 
    #ELSE
        IF( le.Input_dbcode = (TYPEOF(le.Input_dbcode))'','',':dbcode')
    #END
+    #IF( #TEXT(Input_primary_key)='' )
      '' 
    #ELSE
        IF( le.Input_primary_key = (TYPEOF(le.Input_primary_key))'','',':primary_key')
    #END
+    #IF( #TEXT(Input_foreign_key)='' )
      '' 
    #ELSE
        IF( le.Input_foreign_key = (TYPEOF(le.Input_foreign_key))'','',':foreign_key')
    #END
+    #IF( #TEXT(Input_incident_num)='' )
      '' 
    #ELSE
        IF( le.Input_incident_num = (TYPEOF(le.Input_incident_num))'','',':incident_num')
    #END
+    #IF( #TEXT(Input_number)='' )
      '' 
    #ELSE
        IF( le.Input_number = (TYPEOF(le.Input_number))'','',':number')
    #END
+    #IF( #TEXT(Input_field_name)='' )
      '' 
    #ELSE
        IF( le.Input_field_name = (TYPEOF(le.Input_field_name))'','',':field_name')
    #END
+    #IF( #TEXT(Input_code_type)='' )
      '' 
    #ELSE
        IF( le.Input_code_type = (TYPEOF(le.Input_code_type))'','',':code_type')
    #END
+    #IF( #TEXT(Input_code_value)='' )
      '' 
    #ELSE
        IF( le.Input_code_value = (TYPEOF(le.Input_code_value))'','',':code_value')
    #END
+    #IF( #TEXT(Input_code_state)='' )
      '' 
    #ELSE
        IF( le.Input_code_state = (TYPEOF(le.Input_code_state))'','',':code_state')
    #END
+    #IF( #TEXT(Input_other_desc)='' )
      '' 
    #ELSE
        IF( le.Input_other_desc = (TYPEOF(le.Input_other_desc))'','',':other_desc')
    #END
+    #IF( #TEXT(Input_std_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_std_type_desc = (TYPEOF(le.Input_std_type_desc))'','',':std_type_desc')
    #END
+    #IF( #TEXT(Input_cln_license_number)='' )
      '' 
    #ELSE
        IF( le.Input_cln_license_number = (TYPEOF(le.Input_cln_license_number))'','',':cln_license_number')
    #END
;
    #IF (#TEXT(dbcode)<>'')
    SELF.source := le.dbcode;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(dbcode)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(dbcode)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(dbcode)<>'' ) source, #END -cnt );
ENDMACRO;
