 
EXPORT Base_5610_MAC_PopulationStatistics(infile,Ref='',Input_powid = '',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_bdid = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_process_date_first_seen = '',Input_process_date_last_seen = '',Input_record_type = '',Input_did = '',Input_ssn = '',Input_process_date = '',Input_file_number = '',Input_segment_code = '',Input_sequence_number = '',Input_officer_title = '',Input_officer_first_name = '',Input_officer_m_i = '',Input_officer_last_name = '',Input_clean_officer_name_title = '',Input_clean_officer_name_fname = '',Input_clean_officer_name_mname = '',Input_clean_officer_name_lname = '',Input_clean_officer_name_name_suffix = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
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
 
+    #IF( #TEXT(Input_officer_title)='' )
      '' 
    #ELSE
        IF( le.Input_officer_title = (TYPEOF(le.Input_officer_title))'','',':officer_title')
    #END
 
+    #IF( #TEXT(Input_officer_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_officer_first_name = (TYPEOF(le.Input_officer_first_name))'','',':officer_first_name')
    #END
 
+    #IF( #TEXT(Input_officer_m_i)='' )
      '' 
    #ELSE
        IF( le.Input_officer_m_i = (TYPEOF(le.Input_officer_m_i))'','',':officer_m_i')
    #END
 
+    #IF( #TEXT(Input_officer_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_officer_last_name = (TYPEOF(le.Input_officer_last_name))'','',':officer_last_name')
    #END
 
+    #IF( #TEXT(Input_clean_officer_name_title)='' )
      '' 
    #ELSE
        IF( le.Input_clean_officer_name_title = (TYPEOF(le.Input_clean_officer_name_title))'','',':clean_officer_name_title')
    #END
 
+    #IF( #TEXT(Input_clean_officer_name_fname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_officer_name_fname = (TYPEOF(le.Input_clean_officer_name_fname))'','',':clean_officer_name_fname')
    #END
 
+    #IF( #TEXT(Input_clean_officer_name_mname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_officer_name_mname = (TYPEOF(le.Input_clean_officer_name_mname))'','',':clean_officer_name_mname')
    #END
 
+    #IF( #TEXT(Input_clean_officer_name_lname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_officer_name_lname = (TYPEOF(le.Input_clean_officer_name_lname))'','',':clean_officer_name_lname')
    #END
 
+    #IF( #TEXT(Input_clean_officer_name_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_officer_name_name_suffix = (TYPEOF(le.Input_clean_officer_name_name_suffix))'','',':clean_officer_name_name_suffix')
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
