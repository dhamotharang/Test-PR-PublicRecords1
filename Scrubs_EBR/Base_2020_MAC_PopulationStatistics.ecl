 
EXPORT Base_2020_MAC_PopulationStatistics(infile,Ref='',Input_powid = '',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_bdid = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_process_date_first_seen = '',Input_process_date_last_seen = '',Input_record_type = '',Input_process_date = '',Input_file_number = '',Input_segment_code = '',Input_sequence_number = '',Input_trend_mm = '',Input_trend_yy = '',Input_dbt = '',Input_acct_bal_mask = '',Input_acct_bal = '',Input_current_balance_pct = '',Input_dbt_01_30_pct = '',Input_dbt_31_60_pct = '',Input_dbt_61_90_pct = '',Input_dbt_91_plus_pct = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_trend_mm)='' )
      '' 
    #ELSE
        IF( le.Input_trend_mm = (TYPEOF(le.Input_trend_mm))'','',':trend_mm')
    #END
 
+    #IF( #TEXT(Input_trend_yy)='' )
      '' 
    #ELSE
        IF( le.Input_trend_yy = (TYPEOF(le.Input_trend_yy))'','',':trend_yy')
    #END
 
+    #IF( #TEXT(Input_dbt)='' )
      '' 
    #ELSE
        IF( le.Input_dbt = (TYPEOF(le.Input_dbt))'','',':dbt')
    #END
 
+    #IF( #TEXT(Input_acct_bal_mask)='' )
      '' 
    #ELSE
        IF( le.Input_acct_bal_mask = (TYPEOF(le.Input_acct_bal_mask))'','',':acct_bal_mask')
    #END
 
+    #IF( #TEXT(Input_acct_bal)='' )
      '' 
    #ELSE
        IF( le.Input_acct_bal = (TYPEOF(le.Input_acct_bal))'','',':acct_bal')
    #END
 
+    #IF( #TEXT(Input_current_balance_pct)='' )
      '' 
    #ELSE
        IF( le.Input_current_balance_pct = (TYPEOF(le.Input_current_balance_pct))'','',':current_balance_pct')
    #END
 
+    #IF( #TEXT(Input_dbt_01_30_pct)='' )
      '' 
    #ELSE
        IF( le.Input_dbt_01_30_pct = (TYPEOF(le.Input_dbt_01_30_pct))'','',':dbt_01_30_pct')
    #END
 
+    #IF( #TEXT(Input_dbt_31_60_pct)='' )
      '' 
    #ELSE
        IF( le.Input_dbt_31_60_pct = (TYPEOF(le.Input_dbt_31_60_pct))'','',':dbt_31_60_pct')
    #END
 
+    #IF( #TEXT(Input_dbt_61_90_pct)='' )
      '' 
    #ELSE
        IF( le.Input_dbt_61_90_pct = (TYPEOF(le.Input_dbt_61_90_pct))'','',':dbt_61_90_pct')
    #END
 
+    #IF( #TEXT(Input_dbt_91_plus_pct)='' )
      '' 
    #ELSE
        IF( le.Input_dbt_91_plus_pct = (TYPEOF(le.Input_dbt_91_plus_pct))'','',':dbt_91_plus_pct')
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
