
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_contrib_risk_field = '',Input_contrib_risk_value = '',Input_contrib_risk_attr = '',Input_contrib_state_excl = '',OutFile) := MACRO
  IMPORT SALT311,scrubs_tris_lnssi;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_contrib_risk_field)='' )
      '' 
    #ELSE
        IF( le.Input_contrib_risk_field = (TYPEOF(le.Input_contrib_risk_field))'','',':contrib_risk_field')
    #END

+    #IF( #TEXT(Input_contrib_risk_value)='' )
      '' 
    #ELSE
        IF( le.Input_contrib_risk_value = (TYPEOF(le.Input_contrib_risk_value))'','',':contrib_risk_value')
    #END

+    #IF( #TEXT(Input_contrib_risk_attr)='' )
      '' 
    #ELSE
        IF( le.Input_contrib_risk_attr = (TYPEOF(le.Input_contrib_risk_attr))'','',':contrib_risk_attr')
    #END

+    #IF( #TEXT(Input_contrib_state_excl)='' )
      '' 
    #ELSE
        IF( le.Input_contrib_state_excl = (TYPEOF(le.Input_contrib_state_excl))'','',':contrib_state_excl')
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
