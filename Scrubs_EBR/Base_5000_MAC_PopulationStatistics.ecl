 
EXPORT Base_5000_MAC_PopulationStatistics(infile,Ref='',Input_powid = '',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_bdid = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_process_date_first_seen = '',Input_process_date_last_seen = '',Input_record_type = '',Input_process_date = '',Input_file_number = '',Input_segment_code = '',Input_sequence_number = '',Input_name = '',Input_street_address = '',Input_city = '',Input_state_code = '',Input_state_desc = '',Input_zip_code = '',Input_telephone = '',Input_relationship_code = '',Input_relationship_desc = '',Input_bal_range_code = '',Input_acct_bal_range_code = '',Input_nbr_fig_in_bal = '',Input_acct_bal_total = '',Input_acct_rating_code = '',Input_date_acct_opened_ymd = '',Input_date_acct_closed_ymd = '',Input_name_addr_key = '',Input_append_rawaid = '',Input_append_aceaid = '',Input_prep_addr_line1 = '',Input_prep_addr_last_line = '',Input_clean_address_predir = '',Input_clean_address_prim_name = '',Input_clean_address_postdir = '',Input_clean_address_p_city_name = '',Input_clean_address_v_city_name = '',Input_clean_address_st = '',Input_clean_address_zip = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_name)='' )
      '' 
    #ELSE
        IF( le.Input_name = (TYPEOF(le.Input_name))'','',':name')
    #END
 
+    #IF( #TEXT(Input_street_address)='' )
      '' 
    #ELSE
        IF( le.Input_street_address = (TYPEOF(le.Input_street_address))'','',':street_address')
    #END
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
 
+    #IF( #TEXT(Input_state_code)='' )
      '' 
    #ELSE
        IF( le.Input_state_code = (TYPEOF(le.Input_state_code))'','',':state_code')
    #END
 
+    #IF( #TEXT(Input_state_desc)='' )
      '' 
    #ELSE
        IF( le.Input_state_desc = (TYPEOF(le.Input_state_desc))'','',':state_desc')
    #END
 
+    #IF( #TEXT(Input_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_zip_code = (TYPEOF(le.Input_zip_code))'','',':zip_code')
    #END
 
+    #IF( #TEXT(Input_telephone)='' )
      '' 
    #ELSE
        IF( le.Input_telephone = (TYPEOF(le.Input_telephone))'','',':telephone')
    #END
 
+    #IF( #TEXT(Input_relationship_code)='' )
      '' 
    #ELSE
        IF( le.Input_relationship_code = (TYPEOF(le.Input_relationship_code))'','',':relationship_code')
    #END
 
+    #IF( #TEXT(Input_relationship_desc)='' )
      '' 
    #ELSE
        IF( le.Input_relationship_desc = (TYPEOF(le.Input_relationship_desc))'','',':relationship_desc')
    #END
 
+    #IF( #TEXT(Input_bal_range_code)='' )
      '' 
    #ELSE
        IF( le.Input_bal_range_code = (TYPEOF(le.Input_bal_range_code))'','',':bal_range_code')
    #END
 
+    #IF( #TEXT(Input_acct_bal_range_code)='' )
      '' 
    #ELSE
        IF( le.Input_acct_bal_range_code = (TYPEOF(le.Input_acct_bal_range_code))'','',':acct_bal_range_code')
    #END
 
+    #IF( #TEXT(Input_nbr_fig_in_bal)='' )
      '' 
    #ELSE
        IF( le.Input_nbr_fig_in_bal = (TYPEOF(le.Input_nbr_fig_in_bal))'','',':nbr_fig_in_bal')
    #END
 
+    #IF( #TEXT(Input_acct_bal_total)='' )
      '' 
    #ELSE
        IF( le.Input_acct_bal_total = (TYPEOF(le.Input_acct_bal_total))'','',':acct_bal_total')
    #END
 
+    #IF( #TEXT(Input_acct_rating_code)='' )
      '' 
    #ELSE
        IF( le.Input_acct_rating_code = (TYPEOF(le.Input_acct_rating_code))'','',':acct_rating_code')
    #END
 
+    #IF( #TEXT(Input_date_acct_opened_ymd)='' )
      '' 
    #ELSE
        IF( le.Input_date_acct_opened_ymd = (TYPEOF(le.Input_date_acct_opened_ymd))'','',':date_acct_opened_ymd')
    #END
 
+    #IF( #TEXT(Input_date_acct_closed_ymd)='' )
      '' 
    #ELSE
        IF( le.Input_date_acct_closed_ymd = (TYPEOF(le.Input_date_acct_closed_ymd))'','',':date_acct_closed_ymd')
    #END
 
+    #IF( #TEXT(Input_name_addr_key)='' )
      '' 
    #ELSE
        IF( le.Input_name_addr_key = (TYPEOF(le.Input_name_addr_key))'','',':name_addr_key')
    #END
 
+    #IF( #TEXT(Input_append_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_append_rawaid = (TYPEOF(le.Input_append_rawaid))'','',':append_rawaid')
    #END
 
+    #IF( #TEXT(Input_append_aceaid)='' )
      '' 
    #ELSE
        IF( le.Input_append_aceaid = (TYPEOF(le.Input_append_aceaid))'','',':append_aceaid')
    #END
 
+    #IF( #TEXT(Input_prep_addr_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr_line1 = (TYPEOF(le.Input_prep_addr_line1))'','',':prep_addr_line1')
    #END
 
+    #IF( #TEXT(Input_prep_addr_last_line)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr_last_line = (TYPEOF(le.Input_prep_addr_last_line))'','',':prep_addr_last_line')
    #END
 
+    #IF( #TEXT(Input_clean_address_predir)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_predir = (TYPEOF(le.Input_clean_address_predir))'','',':clean_address_predir')
    #END
 
+    #IF( #TEXT(Input_clean_address_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_prim_name = (TYPEOF(le.Input_clean_address_prim_name))'','',':clean_address_prim_name')
    #END
 
+    #IF( #TEXT(Input_clean_address_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_postdir = (TYPEOF(le.Input_clean_address_postdir))'','',':clean_address_postdir')
    #END
 
+    #IF( #TEXT(Input_clean_address_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_p_city_name = (TYPEOF(le.Input_clean_address_p_city_name))'','',':clean_address_p_city_name')
    #END
 
+    #IF( #TEXT(Input_clean_address_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_v_city_name = (TYPEOF(le.Input_clean_address_v_city_name))'','',':clean_address_v_city_name')
    #END
 
+    #IF( #TEXT(Input_clean_address_st)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_st = (TYPEOF(le.Input_clean_address_st))'','',':clean_address_st')
    #END
 
+    #IF( #TEXT(Input_clean_address_zip)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_zip = (TYPEOF(le.Input_clean_address_zip))'','',':clean_address_zip')
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
