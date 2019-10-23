 
EXPORT Flag_MAC_PopulationStatistics(infile,Ref='',Input_flag_file_id = '',Input_did = '',Input_file_id = '',Input_record_id = '',Input_override_flag = '',Input_in_dispute_flag = '',Input_consumer_statement_flag = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_ssn = '',Input_dob = '',Input_riskwise_uid = '',Input_user_added = '',Input_date_added = '',Input_known_missing = '',Input_user_changed = '',Input_date_changed = '',Input_lf = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Overrides;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_flag_file_id)='' )
      '' 
    #ELSE
        IF( le.Input_flag_file_id = (TYPEOF(le.Input_flag_file_id))'','',':flag_file_id')
    #END
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_file_id)='' )
      '' 
    #ELSE
        IF( le.Input_file_id = (TYPEOF(le.Input_file_id))'','',':file_id')
    #END
 
+    #IF( #TEXT(Input_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_record_id = (TYPEOF(le.Input_record_id))'','',':record_id')
    #END
 
+    #IF( #TEXT(Input_override_flag)='' )
      '' 
    #ELSE
        IF( le.Input_override_flag = (TYPEOF(le.Input_override_flag))'','',':override_flag')
    #END
 
+    #IF( #TEXT(Input_in_dispute_flag)='' )
      '' 
    #ELSE
        IF( le.Input_in_dispute_flag = (TYPEOF(le.Input_in_dispute_flag))'','',':in_dispute_flag')
    #END
 
+    #IF( #TEXT(Input_consumer_statement_flag)='' )
      '' 
    #ELSE
        IF( le.Input_consumer_statement_flag = (TYPEOF(le.Input_consumer_statement_flag))'','',':consumer_statement_flag')
    #END
 
+    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (TYPEOF(le.Input_fname))'','',':fname')
    #END
 
+    #IF( #TEXT(Input_mname)='' )
      '' 
    #ELSE
        IF( le.Input_mname = (TYPEOF(le.Input_mname))'','',':mname')
    #END
 
+    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
    #END
 
+    #IF( #TEXT(Input_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix = (TYPEOF(le.Input_name_suffix))'','',':name_suffix')
    #END
 
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_riskwise_uid)='' )
      '' 
    #ELSE
        IF( le.Input_riskwise_uid = (TYPEOF(le.Input_riskwise_uid))'','',':riskwise_uid')
    #END
 
+    #IF( #TEXT(Input_user_added)='' )
      '' 
    #ELSE
        IF( le.Input_user_added = (TYPEOF(le.Input_user_added))'','',':user_added')
    #END
 
+    #IF( #TEXT(Input_date_added)='' )
      '' 
    #ELSE
        IF( le.Input_date_added = (TYPEOF(le.Input_date_added))'','',':date_added')
    #END
 
+    #IF( #TEXT(Input_known_missing)='' )
      '' 
    #ELSE
        IF( le.Input_known_missing = (TYPEOF(le.Input_known_missing))'','',':known_missing')
    #END
 
+    #IF( #TEXT(Input_user_changed)='' )
      '' 
    #ELSE
        IF( le.Input_user_changed = (TYPEOF(le.Input_user_changed))'','',':user_changed')
    #END
 
+    #IF( #TEXT(Input_date_changed)='' )
      '' 
    #ELSE
        IF( le.Input_date_changed = (TYPEOF(le.Input_date_changed))'','',':date_changed')
    #END
 
+    #IF( #TEXT(Input_lf)='' )
      '' 
    #ELSE
        IF( le.Input_lf = (TYPEOF(le.Input_lf))'','',':lf')
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
