 
EXPORT Base_4030_MAC_PopulationStatistics(infile,Ref='',Input_powid = '',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_bdid = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_process_date_first_seen = '',Input_process_date_last_seen = '',Input_record_type = '',Input_process_date = '',Input_file_number = '',Input_segment_code = '',Input_sequence_number = '',Input_orig_date_filed_ymd = '',Input_type_code = '',Input_type_description = '',Input_action_code = '',Input_action_description = '',Input_document_number = '',Input_filing_location = '',Input_liability_amount = '',Input_plaintiff_name = '',Input_date_filed = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_orig_date_filed_ymd)='' )
      '' 
    #ELSE
        IF( le.Input_orig_date_filed_ymd = (TYPEOF(le.Input_orig_date_filed_ymd))'','',':orig_date_filed_ymd')
    #END
 
+    #IF( #TEXT(Input_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_type_code = (TYPEOF(le.Input_type_code))'','',':type_code')
    #END
 
+    #IF( #TEXT(Input_type_description)='' )
      '' 
    #ELSE
        IF( le.Input_type_description = (TYPEOF(le.Input_type_description))'','',':type_description')
    #END
 
+    #IF( #TEXT(Input_action_code)='' )
      '' 
    #ELSE
        IF( le.Input_action_code = (TYPEOF(le.Input_action_code))'','',':action_code')
    #END
 
+    #IF( #TEXT(Input_action_description)='' )
      '' 
    #ELSE
        IF( le.Input_action_description = (TYPEOF(le.Input_action_description))'','',':action_description')
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
 
+    #IF( #TEXT(Input_liability_amount)='' )
      '' 
    #ELSE
        IF( le.Input_liability_amount = (TYPEOF(le.Input_liability_amount))'','',':liability_amount')
    #END
 
+    #IF( #TEXT(Input_plaintiff_name)='' )
      '' 
    #ELSE
        IF( le.Input_plaintiff_name = (TYPEOF(le.Input_plaintiff_name))'','',':plaintiff_name')
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
