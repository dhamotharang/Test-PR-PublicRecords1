 
EXPORT PortData_ValidateIn_MAC_PopulationStatistics(infile,Ref='',Input_tid = '',Input_action = '',Input_actts = '',Input_digits = '',Input_spid = '',Input_altspid = '',Input_laltspid = '',Input_linetype = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_PhonesInfo;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_tid)='' )
      '' 
    #ELSE
        IF( le.Input_tid = (TYPEOF(le.Input_tid))'','',':tid')
    #END
 
+    #IF( #TEXT(Input_action)='' )
      '' 
    #ELSE
        IF( le.Input_action = (TYPEOF(le.Input_action))'','',':action')
    #END
 
+    #IF( #TEXT(Input_actts)='' )
      '' 
    #ELSE
        IF( le.Input_actts = (TYPEOF(le.Input_actts))'','',':actts')
    #END
 
+    #IF( #TEXT(Input_digits)='' )
      '' 
    #ELSE
        IF( le.Input_digits = (TYPEOF(le.Input_digits))'','',':digits')
    #END
 
+    #IF( #TEXT(Input_spid)='' )
      '' 
    #ELSE
        IF( le.Input_spid = (TYPEOF(le.Input_spid))'','',':spid')
    #END
 
+    #IF( #TEXT(Input_altspid)='' )
      '' 
    #ELSE
        IF( le.Input_altspid = (TYPEOF(le.Input_altspid))'','',':altspid')
    #END
 
+    #IF( #TEXT(Input_laltspid)='' )
      '' 
    #ELSE
        IF( le.Input_laltspid = (TYPEOF(le.Input_laltspid))'','',':laltspid')
    #END
 
+    #IF( #TEXT(Input_linetype)='' )
      '' 
    #ELSE
        IF( le.Input_linetype = (TYPEOF(le.Input_linetype))'','',':linetype')
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
