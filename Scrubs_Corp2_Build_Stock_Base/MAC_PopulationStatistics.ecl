 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_bdid = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_corp_key = '',Input_corp_vendor = '',Input_corp_vendor_county = '',Input_corp_vendor_subcode = '',Input_corp_state_origin = '',Input_corp_process_date = '',Input_corp_sos_charter_nbr = '',Input_stock_ticker_symbol = '',Input_stock_exchange = '',Input_stock_type = '',Input_stock_class = '',Input_stock_shares_issued = '',Input_stock_authorized_nbr = '',Input_stock_par_value = '',Input_stock_nbr_par_shares = '',Input_stock_change_ind = '',Input_stock_change_date = '',Input_stock_voting_rights_ind = '',Input_stock_convert_ind = '',Input_stock_convert_date = '',Input_stock_change_in_cap = '',Input_stock_tax_capital = '',Input_stock_total_capital = '',Input_stock_addl_info = '',Input_record_type = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_Corp2_Build_Stock_Base;
  #uniquename(of)
  %of% := RECORD
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
 
+    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
 
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_first_reported = (TYPEOF(le.Input_dt_vendor_first_reported))'','',':dt_vendor_first_reported')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_last_reported = (TYPEOF(le.Input_dt_vendor_last_reported))'','',':dt_vendor_last_reported')
    #END
 
+    #IF( #TEXT(Input_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_corp_key = (TYPEOF(le.Input_corp_key))'','',':corp_key')
    #END
 
+    #IF( #TEXT(Input_corp_vendor)='' )
      '' 
    #ELSE
        IF( le.Input_corp_vendor = (TYPEOF(le.Input_corp_vendor))'','',':corp_vendor')
    #END
 
+    #IF( #TEXT(Input_corp_vendor_county)='' )
      '' 
    #ELSE
        IF( le.Input_corp_vendor_county = (TYPEOF(le.Input_corp_vendor_county))'','',':corp_vendor_county')
    #END
 
+    #IF( #TEXT(Input_corp_vendor_subcode)='' )
      '' 
    #ELSE
        IF( le.Input_corp_vendor_subcode = (TYPEOF(le.Input_corp_vendor_subcode))'','',':corp_vendor_subcode')
    #END
 
+    #IF( #TEXT(Input_corp_state_origin)='' )
      '' 
    #ELSE
        IF( le.Input_corp_state_origin = (TYPEOF(le.Input_corp_state_origin))'','',':corp_state_origin')
    #END
 
+    #IF( #TEXT(Input_corp_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_process_date = (TYPEOF(le.Input_corp_process_date))'','',':corp_process_date')
    #END
 
+    #IF( #TEXT(Input_corp_sos_charter_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_sos_charter_nbr = (TYPEOF(le.Input_corp_sos_charter_nbr))'','',':corp_sos_charter_nbr')
    #END
 
+    #IF( #TEXT(Input_stock_ticker_symbol)='' )
      '' 
    #ELSE
        IF( le.Input_stock_ticker_symbol = (TYPEOF(le.Input_stock_ticker_symbol))'','',':stock_ticker_symbol')
    #END
 
+    #IF( #TEXT(Input_stock_exchange)='' )
      '' 
    #ELSE
        IF( le.Input_stock_exchange = (TYPEOF(le.Input_stock_exchange))'','',':stock_exchange')
    #END
 
+    #IF( #TEXT(Input_stock_type)='' )
      '' 
    #ELSE
        IF( le.Input_stock_type = (TYPEOF(le.Input_stock_type))'','',':stock_type')
    #END
 
+    #IF( #TEXT(Input_stock_class)='' )
      '' 
    #ELSE
        IF( le.Input_stock_class = (TYPEOF(le.Input_stock_class))'','',':stock_class')
    #END
 
+    #IF( #TEXT(Input_stock_shares_issued)='' )
      '' 
    #ELSE
        IF( le.Input_stock_shares_issued = (TYPEOF(le.Input_stock_shares_issued))'','',':stock_shares_issued')
    #END
 
+    #IF( #TEXT(Input_stock_authorized_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_stock_authorized_nbr = (TYPEOF(le.Input_stock_authorized_nbr))'','',':stock_authorized_nbr')
    #END
 
+    #IF( #TEXT(Input_stock_par_value)='' )
      '' 
    #ELSE
        IF( le.Input_stock_par_value = (TYPEOF(le.Input_stock_par_value))'','',':stock_par_value')
    #END
 
+    #IF( #TEXT(Input_stock_nbr_par_shares)='' )
      '' 
    #ELSE
        IF( le.Input_stock_nbr_par_shares = (TYPEOF(le.Input_stock_nbr_par_shares))'','',':stock_nbr_par_shares')
    #END
 
+    #IF( #TEXT(Input_stock_change_ind)='' )
      '' 
    #ELSE
        IF( le.Input_stock_change_ind = (TYPEOF(le.Input_stock_change_ind))'','',':stock_change_ind')
    #END
 
+    #IF( #TEXT(Input_stock_change_date)='' )
      '' 
    #ELSE
        IF( le.Input_stock_change_date = (TYPEOF(le.Input_stock_change_date))'','',':stock_change_date')
    #END
 
+    #IF( #TEXT(Input_stock_voting_rights_ind)='' )
      '' 
    #ELSE
        IF( le.Input_stock_voting_rights_ind = (TYPEOF(le.Input_stock_voting_rights_ind))'','',':stock_voting_rights_ind')
    #END
 
+    #IF( #TEXT(Input_stock_convert_ind)='' )
      '' 
    #ELSE
        IF( le.Input_stock_convert_ind = (TYPEOF(le.Input_stock_convert_ind))'','',':stock_convert_ind')
    #END
 
+    #IF( #TEXT(Input_stock_convert_date)='' )
      '' 
    #ELSE
        IF( le.Input_stock_convert_date = (TYPEOF(le.Input_stock_convert_date))'','',':stock_convert_date')
    #END
 
+    #IF( #TEXT(Input_stock_change_in_cap)='' )
      '' 
    #ELSE
        IF( le.Input_stock_change_in_cap = (TYPEOF(le.Input_stock_change_in_cap))'','',':stock_change_in_cap')
    #END
 
+    #IF( #TEXT(Input_stock_tax_capital)='' )
      '' 
    #ELSE
        IF( le.Input_stock_tax_capital = (TYPEOF(le.Input_stock_tax_capital))'','',':stock_tax_capital')
    #END
 
+    #IF( #TEXT(Input_stock_total_capital)='' )
      '' 
    #ELSE
        IF( le.Input_stock_total_capital = (TYPEOF(le.Input_stock_total_capital))'','',':stock_total_capital')
    #END
 
+    #IF( #TEXT(Input_stock_addl_info)='' )
      '' 
    #ELSE
        IF( le.Input_stock_addl_info = (TYPEOF(le.Input_stock_addl_info))'','',':stock_addl_info')
    #END
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
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
