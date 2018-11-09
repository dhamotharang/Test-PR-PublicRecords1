
EXPORT DeactRaw_MAC_PopulationStatistics(infile,Ref='',Input_action_code = '',Input_timestamp = '',Input_phone = '',Input_phone_swap = '',Input_filename = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_PhonesInfo;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_action_code)='' )
      '' 
    #ELSE
        IF( le.Input_action_code = (TYPEOF(le.Input_action_code))'','',':action_code')
    #END

+    #IF( #TEXT(Input_timestamp)='' )
      '' 
    #ELSE
        IF( le.Input_timestamp = (TYPEOF(le.Input_timestamp))'','',':timestamp')
    #END

+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END

+    #IF( #TEXT(Input_phone_swap)='' )
      '' 
    #ELSE
        IF( le.Input_phone_swap = (TYPEOF(le.Input_phone_swap))'','',':phone_swap')
    #END

+    #IF( #TEXT(Input_filename)='' )
      '' 
    #ELSE
        IF( le.Input_filename = (TYPEOF(le.Input_filename))'','',':filename')
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
