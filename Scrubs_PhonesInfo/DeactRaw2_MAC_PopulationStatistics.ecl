 
EXPORT DeactRaw2_MAC_PopulationStatistics(infile,Ref='',Input_msisdn = '',Input_timestamp = '',Input_changeid = '',Input_operatorid = '',Input_msisdneid = '',Input_msisdnnew = '',Input_filename = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_Phonesinfo;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_msisdn)='' )
      '' 
    #ELSE
        IF( le.Input_msisdn = (TYPEOF(le.Input_msisdn))'','',':msisdn')
    #END
 
+    #IF( #TEXT(Input_timestamp)='' )
      '' 
    #ELSE
        IF( le.Input_timestamp = (TYPEOF(le.Input_timestamp))'','',':timestamp')
    #END
 
+    #IF( #TEXT(Input_changeid)='' )
      '' 
    #ELSE
        IF( le.Input_changeid = (TYPEOF(le.Input_changeid))'','',':changeid')
    #END
 
+    #IF( #TEXT(Input_operatorid)='' )
      '' 
    #ELSE
        IF( le.Input_operatorid = (TYPEOF(le.Input_operatorid))'','',':operatorid')
    #END
 
+    #IF( #TEXT(Input_msisdneid)='' )
      '' 
    #ELSE
        IF( le.Input_msisdneid = (TYPEOF(le.Input_msisdneid))'','',':msisdneid')
    #END
 
+    #IF( #TEXT(Input_msisdnnew)='' )
      '' 
    #ELSE
        IF( le.Input_msisdnnew = (TYPEOF(le.Input_msisdnnew))'','',':msisdnnew')
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
