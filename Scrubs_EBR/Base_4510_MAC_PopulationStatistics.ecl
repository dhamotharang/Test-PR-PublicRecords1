 
EXPORT Base_4510_MAC_PopulationStatistics(infile,Ref='',Input_powid = '',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_bdid = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_process_date_first_seen = '',Input_process_date_last_seen = '',Input_record_type = '',Input_process_date = '',Input_file_number = '',Input_segment_code = '',Input_sequence_number = '',Input_orig_date_filed_yymmdd = '',Input_type_code = '',Input_type_desc = '',Input_action_code = '',Input_action_desc = '',Input_document_number = '',Input_filing_location = '',Input_coll_code1 = '',Input_coll_desc1 = '',Input_coll_code2 = '',Input_coll_desc2 = '',Input_coll_code3 = '',Input_coll_desc3 = '',Input_coll_code4 = '',Input_coll_desc4 = '',Input_coll_code5 = '',Input_coll_desc5 = '',Input_coll_code6 = '',Input_coll_desc6 = '',Input_orig_file_state_code = '',Input_orig_file_state_desc = '',Input_orig_file_number = '',Input_date_filed = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_orig_date_filed_yymmdd)='' )
      '' 
    #ELSE
        IF( le.Input_orig_date_filed_yymmdd = (TYPEOF(le.Input_orig_date_filed_yymmdd))'','',':orig_date_filed_yymmdd')
    #END
 
+    #IF( #TEXT(Input_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_type_code = (TYPEOF(le.Input_type_code))'','',':type_code')
    #END
 
+    #IF( #TEXT(Input_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_type_desc = (TYPEOF(le.Input_type_desc))'','',':type_desc')
    #END
 
+    #IF( #TEXT(Input_action_code)='' )
      '' 
    #ELSE
        IF( le.Input_action_code = (TYPEOF(le.Input_action_code))'','',':action_code')
    #END
 
+    #IF( #TEXT(Input_action_desc)='' )
      '' 
    #ELSE
        IF( le.Input_action_desc = (TYPEOF(le.Input_action_desc))'','',':action_desc')
    #END
 
+    #IF( #TEXT(Input_document_number)='' )
      '' 
    #ELSE
        IF( le.Input_document_number = (TYPEOF(le.Input_document_number))'','',':document_number')
    #END
 
+    #IF( #TEXT(Input_filing_location)='' )
      '' 
    #ELSE
        IF( le.Input_filing_location = (TYPEOF(le.Input_filing_location))'','',':filing_location')
    #END
 
+    #IF( #TEXT(Input_coll_code1)='' )
      '' 
    #ELSE
        IF( le.Input_coll_code1 = (TYPEOF(le.Input_coll_code1))'','',':coll_code1')
    #END
 
+    #IF( #TEXT(Input_coll_desc1)='' )
      '' 
    #ELSE
        IF( le.Input_coll_desc1 = (TYPEOF(le.Input_coll_desc1))'','',':coll_desc1')
    #END
 
+    #IF( #TEXT(Input_coll_code2)='' )
      '' 
    #ELSE
        IF( le.Input_coll_code2 = (TYPEOF(le.Input_coll_code2))'','',':coll_code2')
    #END
 
+    #IF( #TEXT(Input_coll_desc2)='' )
      '' 
    #ELSE
        IF( le.Input_coll_desc2 = (TYPEOF(le.Input_coll_desc2))'','',':coll_desc2')
    #END
 
+    #IF( #TEXT(Input_coll_code3)='' )
      '' 
    #ELSE
        IF( le.Input_coll_code3 = (TYPEOF(le.Input_coll_code3))'','',':coll_code3')
    #END
 
+    #IF( #TEXT(Input_coll_desc3)='' )
      '' 
    #ELSE
        IF( le.Input_coll_desc3 = (TYPEOF(le.Input_coll_desc3))'','',':coll_desc3')
    #END
 
+    #IF( #TEXT(Input_coll_code4)='' )
      '' 
    #ELSE
        IF( le.Input_coll_code4 = (TYPEOF(le.Input_coll_code4))'','',':coll_code4')
    #END
 
+    #IF( #TEXT(Input_coll_desc4)='' )
      '' 
    #ELSE
        IF( le.Input_coll_desc4 = (TYPEOF(le.Input_coll_desc4))'','',':coll_desc4')
    #END
 
+    #IF( #TEXT(Input_coll_code5)='' )
      '' 
    #ELSE
        IF( le.Input_coll_code5 = (TYPEOF(le.Input_coll_code5))'','',':coll_code5')
    #END
 
+    #IF( #TEXT(Input_coll_desc5)='' )
      '' 
    #ELSE
        IF( le.Input_coll_desc5 = (TYPEOF(le.Input_coll_desc5))'','',':coll_desc5')
    #END
 
+    #IF( #TEXT(Input_coll_code6)='' )
      '' 
    #ELSE
        IF( le.Input_coll_code6 = (TYPEOF(le.Input_coll_code6))'','',':coll_code6')
    #END
 
+    #IF( #TEXT(Input_coll_desc6)='' )
      '' 
    #ELSE
        IF( le.Input_coll_desc6 = (TYPEOF(le.Input_coll_desc6))'','',':coll_desc6')
    #END
 
+    #IF( #TEXT(Input_orig_file_state_code)='' )
      '' 
    #ELSE
        IF( le.Input_orig_file_state_code = (TYPEOF(le.Input_orig_file_state_code))'','',':orig_file_state_code')
    #END
 
+    #IF( #TEXT(Input_orig_file_state_desc)='' )
      '' 
    #ELSE
        IF( le.Input_orig_file_state_desc = (TYPEOF(le.Input_orig_file_state_desc))'','',':orig_file_state_desc')
    #END
 
+    #IF( #TEXT(Input_orig_file_number)='' )
      '' 
    #ELSE
        IF( le.Input_orig_file_number = (TYPEOF(le.Input_orig_file_number))'','',':orig_file_number')
    #END
 
+    #IF( #TEXT(Input_date_filed)='' )
      '' 
    #ELSE
        IF( le.Input_date_filed = (TYPEOF(le.Input_date_filed))'','',':date_filed')
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
