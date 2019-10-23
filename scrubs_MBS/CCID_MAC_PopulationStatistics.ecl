 
EXPORT CCID_MAC_PopulationStatistics(infile,Ref='',Input_cc_id = '',Input_gc_id = '',Input_account_id = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_MBS;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_cc_id)='' )
      '' 
    #ELSE
        IF( le.Input_cc_id = (TYPEOF(le.Input_cc_id))'','',':cc_id')
    #END
 
+    #IF( #TEXT(Input_gc_id)='' )
      '' 
    #ELSE
        IF( le.Input_gc_id = (TYPEOF(le.Input_gc_id))'','',':gc_id')
    #END
 
+    #IF( #TEXT(Input_account_id)='' )
      '' 
    #ELSE
        IF( le.Input_account_id = (TYPEOF(le.Input_account_id))'','',':account_id')
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
