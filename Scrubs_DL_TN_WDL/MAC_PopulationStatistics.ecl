 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_process_date = '',Input_dl_number = '',Input_action_code = '',Input_event_date = '',Input_last_name = '',Input_birthdate = '',Input_post_date = '',Input_county_code = '',Input_action_type = '',Input_filler = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_DL_TN_WDL;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_dl_number)='' )
      '' 
    #ELSE
        IF( le.Input_dl_number = (TYPEOF(le.Input_dl_number))'','',':dl_number')
    #END
 
+    #IF( #TEXT(Input_action_code)='' )
      '' 
    #ELSE
        IF( le.Input_action_code = (TYPEOF(le.Input_action_code))'','',':action_code')
    #END
 
+    #IF( #TEXT(Input_event_date)='' )
      '' 
    #ELSE
        IF( le.Input_event_date = (TYPEOF(le.Input_event_date))'','',':event_date')
    #END
 
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
    #END
 
+    #IF( #TEXT(Input_birthdate)='' )
      '' 
    #ELSE
        IF( le.Input_birthdate = (TYPEOF(le.Input_birthdate))'','',':birthdate')
    #END
 
+    #IF( #TEXT(Input_post_date)='' )
      '' 
    #ELSE
        IF( le.Input_post_date = (TYPEOF(le.Input_post_date))'','',':post_date')
    #END
 
+    #IF( #TEXT(Input_county_code)='' )
      '' 
    #ELSE
        IF( le.Input_county_code = (TYPEOF(le.Input_county_code))'','',':county_code')
    #END
 
+    #IF( #TEXT(Input_action_type)='' )
      '' 
    #ELSE
        IF( le.Input_action_type = (TYPEOF(le.Input_action_type))'','',':action_type')
    #END
 
+    #IF( #TEXT(Input_filler)='' )
      '' 
    #ELSE
        IF( le.Input_filler = (TYPEOF(le.Input_filler))'','',':filler')
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
