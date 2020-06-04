 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_process_date = '',Input_filedate = '',Input_record_type = '',Input_action_code = '',Input_cons_id = '',Input_dl_state = '',Input_dl_id = '',Input_first_seen_date_true = '',Input_last_seen_date = '',Input_dispute_status = '',Input_lex_id = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_FirstData;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_filedate)='' )
      '' 
    #ELSE
        IF( le.Input_filedate = (TYPEOF(le.Input_filedate))'','',':filedate')
    #END
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_action_code)='' )
      '' 
    #ELSE
        IF( le.Input_action_code = (TYPEOF(le.Input_action_code))'','',':action_code')
    #END
 
+    #IF( #TEXT(Input_cons_id)='' )
      '' 
    #ELSE
        IF( le.Input_cons_id = (TYPEOF(le.Input_cons_id))'','',':cons_id')
    #END
 
+    #IF( #TEXT(Input_dl_state)='' )
      '' 
    #ELSE
        IF( le.Input_dl_state = (TYPEOF(le.Input_dl_state))'','',':dl_state')
    #END
 
+    #IF( #TEXT(Input_dl_id)='' )
      '' 
    #ELSE
        IF( le.Input_dl_id = (TYPEOF(le.Input_dl_id))'','',':dl_id')
    #END
 
+    #IF( #TEXT(Input_first_seen_date_true)='' )
      '' 
    #ELSE
        IF( le.Input_first_seen_date_true = (TYPEOF(le.Input_first_seen_date_true))'','',':first_seen_date_true')
    #END
 
+    #IF( #TEXT(Input_last_seen_date)='' )
      '' 
    #ELSE
        IF( le.Input_last_seen_date = (TYPEOF(le.Input_last_seen_date))'','',':last_seen_date')
    #END
 
+    #IF( #TEXT(Input_dispute_status)='' )
      '' 
    #ELSE
        IF( le.Input_dispute_status = (TYPEOF(le.Input_dispute_status))'','',':dispute_status')
    #END
 
+    #IF( #TEXT(Input_lex_id)='' )
      '' 
    #ELSE
        IF( le.Input_lex_id = (TYPEOF(le.Input_lex_id))'','',':lex_id')
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
