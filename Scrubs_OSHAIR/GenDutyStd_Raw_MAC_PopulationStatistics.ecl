 
EXPORT GenDutyStd_Raw_MAC_PopulationStatistics(infile,Ref='',Input_activity_nr = '',Input_citation_id = '',Input_line_nr = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_OSHAIR;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_activity_nr)='' )
      '' 
    #ELSE
        IF( le.Input_activity_nr = (TYPEOF(le.Input_activity_nr))'','',':activity_nr')
    #END
 
+    #IF( #TEXT(Input_citation_id)='' )
      '' 
    #ELSE
        IF( le.Input_citation_id = (TYPEOF(le.Input_citation_id))'','',':citation_id')
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
