 
EXPORT RelatedActivity_Raw_MAC_PopulationStatistics(infile,Ref='',Input_activity_nr = '',Input_rel_act_nr = '',Input_rel_safety = '',Input_rel_health = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_rel_act_nr)='' )
      '' 
    #ELSE
        IF( le.Input_rel_act_nr = (TYPEOF(le.Input_rel_act_nr))'','',':rel_act_nr')
    #END
 
+    #IF( #TEXT(Input_rel_safety)='' )
      '' 
    #ELSE
        IF( le.Input_rel_safety = (TYPEOF(le.Input_rel_safety))'','',':rel_safety')
    #END
 
+    #IF( #TEXT(Input_rel_health)='' )
      '' 
    #ELSE
        IF( le.Input_rel_health = (TYPEOF(le.Input_rel_health))'','',':rel_health')
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
