 
EXPORT Base_2025_MAC_PopulationStatistics(infile,Ref='',Input_powid = '',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_bdid = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_process_date_first_seen = '',Input_process_date_last_seen = '',Input_record_type = '',Input_process_date = '',Input_file_number = '',Input_segment_code = '',Input_sequence_number = '',Input_quarter = '',Input_quarter_yy = '',Input_debt = '',Input_account_balance_mask = '',Input_account_balance = '',Input_current_balance_percent = '',Input_debt_01_30_percent = '',Input_debt_31_60_percent = '',Input_debt_61_90_percent = '',Input_debt_91_plus_percent = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_EBR;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_powid)='' )
      '' 
    #ELSE
        IF( le.Input_powid = (TYPEOF(le.Input_powid))'','',':powid')
    #END
 
+    #IF( #TEXT(Input_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_proxid = (TYPEOF(le.Input_proxid))'','',':proxid')
    #END
 
+    #IF( #TEXT(Input_seleid)='' )
      '' 
    #ELSE
        IF( le.Input_seleid = (TYPEOF(le.Input_seleid))'','',':seleid')
    #END
 
+    #IF( #TEXT(Input_orgid)='' )
      '' 
    #ELSE
        IF( le.Input_orgid = (TYPEOF(le.Input_orgid))'','',':orgid')
    #END
 
+    #IF( #TEXT(Input_ultid)='' )
      '' 
    #ELSE
        IF( le.Input_ultid = (TYPEOF(le.Input_ultid))'','',':ultid')
    #END
 
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
 
+    #IF( #TEXT(Input_date_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_first_seen = (TYPEOF(le.Input_date_first_seen))'','',':date_first_seen')
    #END
 
+    #IF( #TEXT(Input_date_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_last_seen = (TYPEOF(le.Input_date_last_seen))'','',':date_last_seen')
    #END
 
+    #IF( #TEXT(Input_process_date_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_process_date_first_seen = (TYPEOF(le.Input_process_date_first_seen))'','',':process_date_first_seen')
    #END
 
+    #IF( #TEXT(Input_process_date_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_process_date_last_seen = (TYPEOF(le.Input_process_date_last_seen))'','',':process_date_last_seen')
    #END
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_file_number)='' )
      '' 
    #ELSE
        IF( le.Input_file_number = (TYPEOF(le.Input_file_number))'','',':file_number')
    #END
 
+    #IF( #TEXT(Input_segment_code)='' )
      '' 
    #ELSE
        IF( le.Input_segment_code = (TYPEOF(le.Input_segment_code))'','',':segment_code')
    #END
 
+    #IF( #TEXT(Input_sequence_number)='' )
      '' 
    #ELSE
        IF( le.Input_sequence_number = (TYPEOF(le.Input_sequence_number))'','',':sequence_number')
    #END
 
+    #IF( #TEXT(Input_quarter)='' )
      '' 
    #ELSE
        IF( le.Input_quarter = (TYPEOF(le.Input_quarter))'','',':quarter')
    #END
 
+    #IF( #TEXT(Input_quarter_yy)='' )
      '' 
    #ELSE
        IF( le.Input_quarter_yy = (TYPEOF(le.Input_quarter_yy))'','',':quarter_yy')
    #END
 
+    #IF( #TEXT(Input_debt)='' )
      '' 
    #ELSE
        IF( le.Input_debt = (TYPEOF(le.Input_debt))'','',':debt')
    #END
 
+    #IF( #TEXT(Input_account_balance_mask)='' )
      '' 
    #ELSE
        IF( le.Input_account_balance_mask = (TYPEOF(le.Input_account_balance_mask))'','',':account_balance_mask')
    #END
 
+    #IF( #TEXT(Input_account_balance)='' )
      '' 
    #ELSE
        IF( le.Input_account_balance = (TYPEOF(le.Input_account_balance))'','',':account_balance')
    #END
 
+    #IF( #TEXT(Input_current_balance_percent)='' )
      '' 
    #ELSE
        IF( le.Input_current_balance_percent = (TYPEOF(le.Input_current_balance_percent))'','',':current_balance_percent')
    #END
 
+    #IF( #TEXT(Input_debt_01_30_percent)='' )
      '' 
    #ELSE
        IF( le.Input_debt_01_30_percent = (TYPEOF(le.Input_debt_01_30_percent))'','',':debt_01_30_percent')
    #END
 
+    #IF( #TEXT(Input_debt_31_60_percent)='' )
      '' 
    #ELSE
        IF( le.Input_debt_31_60_percent = (TYPEOF(le.Input_debt_31_60_percent))'','',':debt_31_60_percent')
    #END
 
+    #IF( #TEXT(Input_debt_61_90_percent)='' )
      '' 
    #ELSE
        IF( le.Input_debt_61_90_percent = (TYPEOF(le.Input_debt_61_90_percent))'','',':debt_61_90_percent')
    #END
 
+    #IF( #TEXT(Input_debt_91_plus_percent)='' )
      '' 
    #ELSE
        IF( le.Input_debt_91_plus_percent = (TYPEOF(le.Input_debt_91_plus_percent))'','',':debt_91_plus_percent')
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
