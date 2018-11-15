 
EXPORT Base_1000_MAC_PopulationStatistics(infile,Ref='',Input_powid = '',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_bdid = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_process_date_first_seen = '',Input_process_date_last_seen = '',Input_record_type = '',Input_process_date = '',Input_file_number = '',Input_current_dbt = '',Input_predicted_dbt = '',Input_orig_predicted_dbt_date_mmddyy = '',Input_average_industry_dbt = '',Input_average_all_industries_dbt = '',Input_low_balance = '',Input_high_balance = '',Input_current_account_balance = '',Input_high_credit_extended = '',Input_median_credit_extended = '',Input_payment_performance = '',Input_payment_trend = '',Input_industry_description = '',Input_predicted_dbt_date = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_current_dbt)='' )
      '' 
    #ELSE
        IF( le.Input_current_dbt = (TYPEOF(le.Input_current_dbt))'','',':current_dbt')
    #END
 
+    #IF( #TEXT(Input_predicted_dbt)='' )
      '' 
    #ELSE
        IF( le.Input_predicted_dbt = (TYPEOF(le.Input_predicted_dbt))'','',':predicted_dbt')
    #END
 
+    #IF( #TEXT(Input_orig_predicted_dbt_date_mmddyy)='' )
      '' 
    #ELSE
        IF( le.Input_orig_predicted_dbt_date_mmddyy = (TYPEOF(le.Input_orig_predicted_dbt_date_mmddyy))'','',':orig_predicted_dbt_date_mmddyy')
    #END
 
+    #IF( #TEXT(Input_average_industry_dbt)='' )
      '' 
    #ELSE
        IF( le.Input_average_industry_dbt = (TYPEOF(le.Input_average_industry_dbt))'','',':average_industry_dbt')
    #END
 
+    #IF( #TEXT(Input_average_all_industries_dbt)='' )
      '' 
    #ELSE
        IF( le.Input_average_all_industries_dbt = (TYPEOF(le.Input_average_all_industries_dbt))'','',':average_all_industries_dbt')
    #END
 
+    #IF( #TEXT(Input_low_balance)='' )
      '' 
    #ELSE
        IF( le.Input_low_balance = (TYPEOF(le.Input_low_balance))'','',':low_balance')
    #END
 
+    #IF( #TEXT(Input_high_balance)='' )
      '' 
    #ELSE
        IF( le.Input_high_balance = (TYPEOF(le.Input_high_balance))'','',':high_balance')
    #END
 
+    #IF( #TEXT(Input_current_account_balance)='' )
      '' 
    #ELSE
        IF( le.Input_current_account_balance = (TYPEOF(le.Input_current_account_balance))'','',':current_account_balance')
    #END
 
+    #IF( #TEXT(Input_high_credit_extended)='' )
      '' 
    #ELSE
        IF( le.Input_high_credit_extended = (TYPEOF(le.Input_high_credit_extended))'','',':high_credit_extended')
    #END
 
+    #IF( #TEXT(Input_median_credit_extended)='' )
      '' 
    #ELSE
        IF( le.Input_median_credit_extended = (TYPEOF(le.Input_median_credit_extended))'','',':median_credit_extended')
    #END
 
+    #IF( #TEXT(Input_payment_performance)='' )
      '' 
    #ELSE
        IF( le.Input_payment_performance = (TYPEOF(le.Input_payment_performance))'','',':payment_performance')
    #END
 
+    #IF( #TEXT(Input_payment_trend)='' )
      '' 
    #ELSE
        IF( le.Input_payment_trend = (TYPEOF(le.Input_payment_trend))'','',':payment_trend')
    #END
 
+    #IF( #TEXT(Input_industry_description)='' )
      '' 
    #ELSE
        IF( le.Input_industry_description = (TYPEOF(le.Input_industry_description))'','',':industry_description')
    #END
 
+    #IF( #TEXT(Input_predicted_dbt_date)='' )
      '' 
    #ELSE
        IF( le.Input_predicted_dbt_date = (TYPEOF(le.Input_predicted_dbt_date))'','',':predicted_dbt_date')
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
