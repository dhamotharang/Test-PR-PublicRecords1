 
EXPORT Base_2015_MAC_PopulationStatistics(infile,Ref='',Input_powid = '',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_bdid = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_process_date_first_seen = '',Input_process_date_last_seen = '',Input_record_type = '',Input_process_date = '',Input_file_number = '',Input_segment_code = '',Input_trade_count1 = '',Input_debt1 = '',Input_high_credit_mask1 = '',Input_recent_high_credit1 = '',Input_account_balance_mask1 = '',Input_masked_account_balance1 = '',Input_current_balance_percent1 = '',Input_debt_01_30_percent1 = '',Input_debt_31_60_percent1 = '',Input_debt_61_90_percent1 = '',Input_debt_91_plus_percent1 = '',Input_trade_count2 = '',Input_debt2 = '',Input_high_credit_mask2 = '',Input_recent_high_credit2 = '',Input_account_balance_mask2 = '',Input_masked_account_balance2 = '',Input_current_balance_percent2 = '',Input_debt_01_30_percent2 = '',Input_debt_31_60_percent2 = '',Input_debt_61_90_percent2 = '',Input_debt_91_plus_percent2 = '',Input_trade_count3 = '',Input_debt3 = '',Input_high_credit_mask3 = '',Input_recent_high_credit3 = '',Input_account_balance_mask3 = '',Input_masked_account_balance3 = '',Input_current_balance_percent3 = '',Input_debt_01_30_percent3 = '',Input_debt_31_60_percent3 = '',Input_debt_61_90_percent3 = '',Input_debt_91_plus_percent3 = '',Input_highest_credit_median = '',Input_orig_account_balance_regular_tradelines = '',Input_orig_account_balance_new = '',Input_orig_account_balance_combined = '',Input_aged_trades_count = '',Input_account_balance_regular_tradelines = '',Input_account_balance_new = '',Input_account_balance_combined = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_trade_count1)='' )
      '' 
    #ELSE
        IF( le.Input_trade_count1 = (TYPEOF(le.Input_trade_count1))'','',':trade_count1')
    #END
 
+    #IF( #TEXT(Input_debt1)='' )
      '' 
    #ELSE
        IF( le.Input_debt1 = (TYPEOF(le.Input_debt1))'','',':debt1')
    #END
 
+    #IF( #TEXT(Input_high_credit_mask1)='' )
      '' 
    #ELSE
        IF( le.Input_high_credit_mask1 = (TYPEOF(le.Input_high_credit_mask1))'','',':high_credit_mask1')
    #END
 
+    #IF( #TEXT(Input_recent_high_credit1)='' )
      '' 
    #ELSE
        IF( le.Input_recent_high_credit1 = (TYPEOF(le.Input_recent_high_credit1))'','',':recent_high_credit1')
    #END
 
+    #IF( #TEXT(Input_account_balance_mask1)='' )
      '' 
    #ELSE
        IF( le.Input_account_balance_mask1 = (TYPEOF(le.Input_account_balance_mask1))'','',':account_balance_mask1')
    #END
 
+    #IF( #TEXT(Input_masked_account_balance1)='' )
      '' 
    #ELSE
        IF( le.Input_masked_account_balance1 = (TYPEOF(le.Input_masked_account_balance1))'','',':masked_account_balance1')
    #END
 
+    #IF( #TEXT(Input_current_balance_percent1)='' )
      '' 
    #ELSE
        IF( le.Input_current_balance_percent1 = (TYPEOF(le.Input_current_balance_percent1))'','',':current_balance_percent1')
    #END
 
+    #IF( #TEXT(Input_debt_01_30_percent1)='' )
      '' 
    #ELSE
        IF( le.Input_debt_01_30_percent1 = (TYPEOF(le.Input_debt_01_30_percent1))'','',':debt_01_30_percent1')
    #END
 
+    #IF( #TEXT(Input_debt_31_60_percent1)='' )
      '' 
    #ELSE
        IF( le.Input_debt_31_60_percent1 = (TYPEOF(le.Input_debt_31_60_percent1))'','',':debt_31_60_percent1')
    #END
 
+    #IF( #TEXT(Input_debt_61_90_percent1)='' )
      '' 
    #ELSE
        IF( le.Input_debt_61_90_percent1 = (TYPEOF(le.Input_debt_61_90_percent1))'','',':debt_61_90_percent1')
    #END
 
+    #IF( #TEXT(Input_debt_91_plus_percent1)='' )
      '' 
    #ELSE
        IF( le.Input_debt_91_plus_percent1 = (TYPEOF(le.Input_debt_91_plus_percent1))'','',':debt_91_plus_percent1')
    #END
 
+    #IF( #TEXT(Input_trade_count2)='' )
      '' 
    #ELSE
        IF( le.Input_trade_count2 = (TYPEOF(le.Input_trade_count2))'','',':trade_count2')
    #END
 
+    #IF( #TEXT(Input_debt2)='' )
      '' 
    #ELSE
        IF( le.Input_debt2 = (TYPEOF(le.Input_debt2))'','',':debt2')
    #END
 
+    #IF( #TEXT(Input_high_credit_mask2)='' )
      '' 
    #ELSE
        IF( le.Input_high_credit_mask2 = (TYPEOF(le.Input_high_credit_mask2))'','',':high_credit_mask2')
    #END
 
+    #IF( #TEXT(Input_recent_high_credit2)='' )
      '' 
    #ELSE
        IF( le.Input_recent_high_credit2 = (TYPEOF(le.Input_recent_high_credit2))'','',':recent_high_credit2')
    #END
 
+    #IF( #TEXT(Input_account_balance_mask2)='' )
      '' 
    #ELSE
        IF( le.Input_account_balance_mask2 = (TYPEOF(le.Input_account_balance_mask2))'','',':account_balance_mask2')
    #END
 
+    #IF( #TEXT(Input_masked_account_balance2)='' )
      '' 
    #ELSE
        IF( le.Input_masked_account_balance2 = (TYPEOF(le.Input_masked_account_balance2))'','',':masked_account_balance2')
    #END
 
+    #IF( #TEXT(Input_current_balance_percent2)='' )
      '' 
    #ELSE
        IF( le.Input_current_balance_percent2 = (TYPEOF(le.Input_current_balance_percent2))'','',':current_balance_percent2')
    #END
 
+    #IF( #TEXT(Input_debt_01_30_percent2)='' )
      '' 
    #ELSE
        IF( le.Input_debt_01_30_percent2 = (TYPEOF(le.Input_debt_01_30_percent2))'','',':debt_01_30_percent2')
    #END
 
+    #IF( #TEXT(Input_debt_31_60_percent2)='' )
      '' 
    #ELSE
        IF( le.Input_debt_31_60_percent2 = (TYPEOF(le.Input_debt_31_60_percent2))'','',':debt_31_60_percent2')
    #END
 
+    #IF( #TEXT(Input_debt_61_90_percent2)='' )
      '' 
    #ELSE
        IF( le.Input_debt_61_90_percent2 = (TYPEOF(le.Input_debt_61_90_percent2))'','',':debt_61_90_percent2')
    #END
 
+    #IF( #TEXT(Input_debt_91_plus_percent2)='' )
      '' 
    #ELSE
        IF( le.Input_debt_91_plus_percent2 = (TYPEOF(le.Input_debt_91_plus_percent2))'','',':debt_91_plus_percent2')
    #END
 
+    #IF( #TEXT(Input_trade_count3)='' )
      '' 
    #ELSE
        IF( le.Input_trade_count3 = (TYPEOF(le.Input_trade_count3))'','',':trade_count3')
    #END
 
+    #IF( #TEXT(Input_debt3)='' )
      '' 
    #ELSE
        IF( le.Input_debt3 = (TYPEOF(le.Input_debt3))'','',':debt3')
    #END
 
+    #IF( #TEXT(Input_high_credit_mask3)='' )
      '' 
    #ELSE
        IF( le.Input_high_credit_mask3 = (TYPEOF(le.Input_high_credit_mask3))'','',':high_credit_mask3')
    #END
 
+    #IF( #TEXT(Input_recent_high_credit3)='' )
      '' 
    #ELSE
        IF( le.Input_recent_high_credit3 = (TYPEOF(le.Input_recent_high_credit3))'','',':recent_high_credit3')
    #END
 
+    #IF( #TEXT(Input_account_balance_mask3)='' )
      '' 
    #ELSE
        IF( le.Input_account_balance_mask3 = (TYPEOF(le.Input_account_balance_mask3))'','',':account_balance_mask3')
    #END
 
+    #IF( #TEXT(Input_masked_account_balance3)='' )
      '' 
    #ELSE
        IF( le.Input_masked_account_balance3 = (TYPEOF(le.Input_masked_account_balance3))'','',':masked_account_balance3')
    #END
 
+    #IF( #TEXT(Input_current_balance_percent3)='' )
      '' 
    #ELSE
        IF( le.Input_current_balance_percent3 = (TYPEOF(le.Input_current_balance_percent3))'','',':current_balance_percent3')
    #END
 
+    #IF( #TEXT(Input_debt_01_30_percent3)='' )
      '' 
    #ELSE
        IF( le.Input_debt_01_30_percent3 = (TYPEOF(le.Input_debt_01_30_percent3))'','',':debt_01_30_percent3')
    #END
 
+    #IF( #TEXT(Input_debt_31_60_percent3)='' )
      '' 
    #ELSE
        IF( le.Input_debt_31_60_percent3 = (TYPEOF(le.Input_debt_31_60_percent3))'','',':debt_31_60_percent3')
    #END
 
+    #IF( #TEXT(Input_debt_61_90_percent3)='' )
      '' 
    #ELSE
        IF( le.Input_debt_61_90_percent3 = (TYPEOF(le.Input_debt_61_90_percent3))'','',':debt_61_90_percent3')
    #END
 
+    #IF( #TEXT(Input_debt_91_plus_percent3)='' )
      '' 
    #ELSE
        IF( le.Input_debt_91_plus_percent3 = (TYPEOF(le.Input_debt_91_plus_percent3))'','',':debt_91_plus_percent3')
    #END
 
+    #IF( #TEXT(Input_highest_credit_median)='' )
      '' 
    #ELSE
        IF( le.Input_highest_credit_median = (TYPEOF(le.Input_highest_credit_median))'','',':highest_credit_median')
    #END
 
+    #IF( #TEXT(Input_orig_account_balance_regular_tradelines)='' )
      '' 
    #ELSE
        IF( le.Input_orig_account_balance_regular_tradelines = (TYPEOF(le.Input_orig_account_balance_regular_tradelines))'','',':orig_account_balance_regular_tradelines')
    #END
 
+    #IF( #TEXT(Input_orig_account_balance_new)='' )
      '' 
    #ELSE
        IF( le.Input_orig_account_balance_new = (TYPEOF(le.Input_orig_account_balance_new))'','',':orig_account_balance_new')
    #END
 
+    #IF( #TEXT(Input_orig_account_balance_combined)='' )
      '' 
    #ELSE
        IF( le.Input_orig_account_balance_combined = (TYPEOF(le.Input_orig_account_balance_combined))'','',':orig_account_balance_combined')
    #END
 
+    #IF( #TEXT(Input_aged_trades_count)='' )
      '' 
    #ELSE
        IF( le.Input_aged_trades_count = (TYPEOF(le.Input_aged_trades_count))'','',':aged_trades_count')
    #END
 
+    #IF( #TEXT(Input_account_balance_regular_tradelines)='' )
      '' 
    #ELSE
        IF( le.Input_account_balance_regular_tradelines = (TYPEOF(le.Input_account_balance_regular_tradelines))'','',':account_balance_regular_tradelines')
    #END
 
+    #IF( #TEXT(Input_account_balance_new)='' )
      '' 
    #ELSE
        IF( le.Input_account_balance_new = (TYPEOF(le.Input_account_balance_new))'','',':account_balance_new')
    #END
 
+    #IF( #TEXT(Input_account_balance_combined)='' )
      '' 
    #ELSE
        IF( le.Input_account_balance_combined = (TYPEOF(le.Input_account_balance_combined))'','',':account_balance_combined')
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
