 
EXPORT Base_0010_MAC_PopulationStatistics(infile,Ref='',Input_powid = '',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_bdid = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_process_date_first_seen = '',Input_process_date_last_seen = '',Input_record_type = '',Input_process_date = '',Input_file_number = '',Input_orig_extract_date_mdy = '',Input_company_name = '',Input_phone_number = '',Input_sic_code = '',Input_business_desc = '',Input_extract_date = '',Input_file_estab_date = '',Input_prep_addr_line1 = '',Input_prep_addr_last_line = '',Input_source_rec_id = '',Input_clean_address_prim_name = '',Input_clean_address_p_city_name = '',Input_clean_address_v_city_name = '',Input_clean_address_st = '',Input_clean_address_zip = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_orig_extract_date_mdy)='' )
      '' 
    #ELSE
        IF( le.Input_orig_extract_date_mdy = (TYPEOF(le.Input_orig_extract_date_mdy))'','',':orig_extract_date_mdy')
    #END
 
+    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (TYPEOF(le.Input_company_name))'','',':company_name')
    #END
 
+    #IF( #TEXT(Input_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_phone_number = (TYPEOF(le.Input_phone_number))'','',':phone_number')
    #END
 
+    #IF( #TEXT(Input_sic_code)='' )
      '' 
    #ELSE
        IF( le.Input_sic_code = (TYPEOF(le.Input_sic_code))'','',':sic_code')
    #END
 
+    #IF( #TEXT(Input_business_desc)='' )
      '' 
    #ELSE
        IF( le.Input_business_desc = (TYPEOF(le.Input_business_desc))'','',':business_desc')
    #END
 
+    #IF( #TEXT(Input_extract_date)='' )
      '' 
    #ELSE
        IF( le.Input_extract_date = (TYPEOF(le.Input_extract_date))'','',':extract_date')
    #END
 
+    #IF( #TEXT(Input_file_estab_date)='' )
      '' 
    #ELSE
        IF( le.Input_file_estab_date = (TYPEOF(le.Input_file_estab_date))'','',':file_estab_date')
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
 
+    #IF( #TEXT(Input_source_rec_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_rec_id = (TYPEOF(le.Input_source_rec_id))'','',':source_rec_id')
    #END
 
+    #IF( #TEXT(Input_clean_address_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_prim_name = (TYPEOF(le.Input_clean_address_prim_name))'','',':clean_address_prim_name')
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
