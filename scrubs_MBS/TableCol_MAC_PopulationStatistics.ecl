 
EXPORT TableCol_MAC_PopulationStatistics(infile,Ref='',Input_table_column_id = '',Input_table_name = '',Input_column_name = '',Input_is_column_value = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_MBS;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_table_column_id)='' )
      '' 
    #ELSE
        IF( le.Input_table_column_id = (TYPEOF(le.Input_table_column_id))'','',':table_column_id')
    #END
 
+    #IF( #TEXT(Input_table_name)='' )
      '' 
    #ELSE
        IF( le.Input_table_name = (TYPEOF(le.Input_table_name))'','',':table_name')
    #END
 
+    #IF( #TEXT(Input_column_name)='' )
      '' 
    #ELSE
        IF( le.Input_column_name = (TYPEOF(le.Input_column_name))'','',':column_name')
    #END
 
+    #IF( #TEXT(Input_is_column_value)='' )
      '' 
    #ELSE
        IF( le.Input_is_column_value = (TYPEOF(le.Input_is_column_value))'','',':is_column_value')
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
