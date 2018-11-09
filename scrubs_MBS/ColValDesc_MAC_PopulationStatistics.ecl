 
EXPORT ColValDesc_MAC_PopulationStatistics(infile,Ref='',Input_column_value_desc_id = '',Input_table_column_id = '',Input_desc_value = '',Input_status = '',Input_description = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_MBS;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_column_value_desc_id)='' )
      '' 
    #ELSE
        IF( le.Input_column_value_desc_id = (TYPEOF(le.Input_column_value_desc_id))'','',':column_value_desc_id')
    #END
 
+    #IF( #TEXT(Input_table_column_id)='' )
      '' 
    #ELSE
        IF( le.Input_table_column_id = (TYPEOF(le.Input_table_column_id))'','',':table_column_id')
    #END
 
+    #IF( #TEXT(Input_desc_value)='' )
      '' 
    #ELSE
        IF( le.Input_desc_value = (TYPEOF(le.Input_desc_value))'','',':desc_value')
    #END
 
+    #IF( #TEXT(Input_status)='' )
      '' 
    #ELSE
        IF( le.Input_status = (TYPEOF(le.Input_status))'','',':status')
    #END
 
+    #IF( #TEXT(Input_description)='' )
      '' 
    #ELSE
        IF( le.Input_description = (TYPEOF(le.Input_description))'','',':description')
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
