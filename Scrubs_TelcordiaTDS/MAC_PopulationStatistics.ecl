 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_npa = '',Input_nxx = '',Input_tb = '',Input_state = '',Input_timezone = '',Input_coctype = '',Input_ssc = '',Input_wireless_ind = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_TelcordiaTDS;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_npa)='' )
      '' 
    #ELSE
        IF( le.Input_npa = (TYPEOF(le.Input_npa))'','',':npa')
    #END
 
+    #IF( #TEXT(Input_nxx)='' )
      '' 
    #ELSE
        IF( le.Input_nxx = (TYPEOF(le.Input_nxx))'','',':nxx')
    #END
 
+    #IF( #TEXT(Input_tb)='' )
      '' 
    #ELSE
        IF( le.Input_tb = (TYPEOF(le.Input_tb))'','',':tb')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_timezone)='' )
      '' 
    #ELSE
        IF( le.Input_timezone = (TYPEOF(le.Input_timezone))'','',':timezone')
    #END
 
+    #IF( #TEXT(Input_coctype)='' )
      '' 
    #ELSE
        IF( le.Input_coctype = (TYPEOF(le.Input_coctype))'','',':coctype')
    #END
 
+    #IF( #TEXT(Input_ssc)='' )
      '' 
    #ELSE
        IF( le.Input_ssc = (TYPEOF(le.Input_ssc))'','',':ssc')
    #END
 
+    #IF( #TEXT(Input_wireless_ind)='' )
      '' 
    #ELSE
        IF( le.Input_wireless_ind = (TYPEOF(le.Input_wireless_ind))'','',':wireless_ind')
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
