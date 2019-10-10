
EXPORT OptOut_MAC_PopulationStatistics(infile,Ref='',Input_entry_type = '',Input_lexid = '',Input_prof_data = '',Input_state_act = '',Input_date_of_request = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Suppress;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_entry_type)='' )
      '' 
    #ELSE
        IF( le.Input_entry_type = (TYPEOF(le.Input_entry_type))'','',':entry_type')
    #END

+    #IF( #TEXT(Input_lexid)='' )
      '' 
    #ELSE
        IF( le.Input_lexid = (TYPEOF(le.Input_lexid))'','',':lexid')
    #END

+    #IF( #TEXT(Input_prof_data)='' )
      '' 
    #ELSE
        IF( le.Input_prof_data = (TYPEOF(le.Input_prof_data))'','',':prof_data')
    #END

+    #IF( #TEXT(Input_state_act)='' )
      '' 
    #ELSE
        IF( le.Input_state_act = (TYPEOF(le.Input_state_act))'','',':state_act')
    #END

+    #IF( #TEXT(Input_date_of_request)='' )
      '' 
    #ELSE
        IF( le.Input_date_of_request = (TYPEOF(le.Input_date_of_request))'','',':date_of_request')
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
