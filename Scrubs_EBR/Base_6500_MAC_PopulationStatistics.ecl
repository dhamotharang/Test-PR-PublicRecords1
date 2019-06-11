 
EXPORT Base_6500_MAC_PopulationStatistics(infile,Ref='',Input_powid = '',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_bdid = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_process_date_first_seen = '',Input_process_date_last_seen = '',Input_record_type = '',Input_process_date = '',Input_file_number = '',Input_segment_code = '',Input_sequence_number = '',Input_bus_cat_code = '',Input_bus_cat_desc = '',Input_orig_date_reported_ymd = '',Input_orig_date_last_sale_ym = '',Input_payment_terms = '',Input_high_credit_mask = '',Input_recent_high_credit = '',Input_acct_bal_mask = '',Input_masked_acct_bal = '',Input_current_pct = '',Input_dbt_01_30_pct = '',Input_dbt_31_60_pct = '',Input_dbt_61_90_pct = '',Input_dbt_91_plus_pct = '',Input_comment_code = '',Input_comment_desc = '',Input_date_reported = '',Input_date_last_sale = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_bus_cat_code)='' )
      '' 
    #ELSE
        IF( le.Input_bus_cat_code = (TYPEOF(le.Input_bus_cat_code))'','',':bus_cat_code')
    #END
 
+    #IF( #TEXT(Input_bus_cat_desc)='' )
      '' 
    #ELSE
        IF( le.Input_bus_cat_desc = (TYPEOF(le.Input_bus_cat_desc))'','',':bus_cat_desc')
    #END
 
+    #IF( #TEXT(Input_orig_date_reported_ymd)='' )
      '' 
    #ELSE
        IF( le.Input_orig_date_reported_ymd = (TYPEOF(le.Input_orig_date_reported_ymd))'','',':orig_date_reported_ymd')
    #END
 
+    #IF( #TEXT(Input_orig_date_last_sale_ym)='' )
      '' 
    #ELSE
        IF( le.Input_orig_date_last_sale_ym = (TYPEOF(le.Input_orig_date_last_sale_ym))'','',':orig_date_last_sale_ym')
    #END
 
+    #IF( #TEXT(Input_payment_terms)='' )
      '' 
    #ELSE
        IF( le.Input_payment_terms = (TYPEOF(le.Input_payment_terms))'','',':payment_terms')
    #END
 
+    #IF( #TEXT(Input_high_credit_mask)='' )
      '' 
    #ELSE
        IF( le.Input_high_credit_mask = (TYPEOF(le.Input_high_credit_mask))'','',':high_credit_mask')
    #END
 
+    #IF( #TEXT(Input_recent_high_credit)='' )
      '' 
    #ELSE
        IF( le.Input_recent_high_credit = (TYPEOF(le.Input_recent_high_credit))'','',':recent_high_credit')
    #END
 
+    #IF( #TEXT(Input_acct_bal_mask)='' )
      '' 
    #ELSE
        IF( le.Input_acct_bal_mask = (TYPEOF(le.Input_acct_bal_mask))'','',':acct_bal_mask')
    #END
 
+    #IF( #TEXT(Input_masked_acct_bal)='' )
      '' 
    #ELSE
        IF( le.Input_masked_acct_bal = (TYPEOF(le.Input_masked_acct_bal))'','',':masked_acct_bal')
    #END
 
+    #IF( #TEXT(Input_current_pct)='' )
      '' 
    #ELSE
        IF( le.Input_current_pct = (TYPEOF(le.Input_current_pct))'','',':current_pct')
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
 
+    #IF( #TEXT(Input_comment_code)='' )
      '' 
    #ELSE
        IF( le.Input_comment_code = (TYPEOF(le.Input_comment_code))'','',':comment_code')
    #END
 
+    #IF( #TEXT(Input_comment_desc)='' )
      '' 
    #ELSE
        IF( le.Input_comment_desc = (TYPEOF(le.Input_comment_desc))'','',':comment_desc')
    #END
 
+    #IF( #TEXT(Input_date_reported)='' )
      '' 
    #ELSE
        IF( le.Input_date_reported = (TYPEOF(le.Input_date_reported))'','',':date_reported')
    #END
 
+    #IF( #TEXT(Input_date_last_sale)='' )
      '' 
    #ELSE
        IF( le.Input_date_last_sale = (TYPEOF(le.Input_date_last_sale))'','',':date_last_sale')
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
