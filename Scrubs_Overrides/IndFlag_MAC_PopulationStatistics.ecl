 
EXPORT IndFlag_MAC_PopulationStatistics(infile,Ref='',Key_Ind='',Input_Key_Ind = '',Input_flag_file_id = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Overrides;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(Key_Ind)<>'')
    SALT311.StrType source;
    #END
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_Key_Ind)='' )
      '' 
    #ELSE
        IF( le.Input_Key_Ind = (TYPEOF(le.Input_Key_Ind))'','',':Key_Ind')
    #END
 
+    #IF( #TEXT(Input_flag_file_id)='' )
      '' 
    #ELSE
        IF( le.Input_flag_file_id = (TYPEOF(le.Input_flag_file_id))'','',':flag_file_id')
    #END
;
    #IF (#TEXT(Key_Ind)<>'')
    SELF.source := le.Key_Ind;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(Key_Ind)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(Key_Ind)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(Key_Ind)<>'' ) source, #END -cnt );
ENDMACRO;
