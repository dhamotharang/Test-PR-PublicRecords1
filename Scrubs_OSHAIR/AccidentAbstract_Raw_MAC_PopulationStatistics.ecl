 
EXPORT AccidentAbstract_Raw_MAC_PopulationStatistics(infile,Ref='',Input_summary_nr = '',Input_line_nr = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_OSHAIR;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_summary_nr)='' )
      '' 
    #ELSE
        IF( le.Input_summary_nr = (TYPEOF(le.Input_summary_nr))'','',':summary_nr')
    #END
 
+    #IF( #TEXT(Input_line_nr)='' )
      '' 
    #ELSE
        IF( le.Input_line_nr = (TYPEOF(le.Input_line_nr))'','',':line_nr')
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
