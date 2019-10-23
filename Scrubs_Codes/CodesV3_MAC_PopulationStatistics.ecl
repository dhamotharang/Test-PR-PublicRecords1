 
EXPORT CodesV3_MAC_PopulationStatistics(infile,Ref='',Input_file_name = '',Input_field_name = '',Input_field_name2 = '',Input_code = '',Input_long_flag = '',Input_long_desc = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_Codes;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_file_name)='' )
      '' 
    #ELSE
        IF( le.Input_file_name = (TYPEOF(le.Input_file_name))'','',':file_name')
    #END
 
+    #IF( #TEXT(Input_field_name)='' )
      '' 
    #ELSE
        IF( le.Input_field_name = (TYPEOF(le.Input_field_name))'','',':field_name')
    #END
 
+    #IF( #TEXT(Input_field_name2)='' )
      '' 
    #ELSE
        IF( le.Input_field_name2 = (TYPEOF(le.Input_field_name2))'','',':field_name2')
    #END
 
+    #IF( #TEXT(Input_code)='' )
      '' 
    #ELSE
        IF( le.Input_code = (TYPEOF(le.Input_code))'','',':code')
    #END
 
+    #IF( #TEXT(Input_long_flag)='' )
      '' 
    #ELSE
        IF( le.Input_long_flag = (TYPEOF(le.Input_long_flag))'','',':long_flag')
    #END
 
+    #IF( #TEXT(Input_long_desc)='' )
      '' 
    #ELSE
        IF( le.Input_long_desc = (TYPEOF(le.Input_long_desc))'','',':long_desc')
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
