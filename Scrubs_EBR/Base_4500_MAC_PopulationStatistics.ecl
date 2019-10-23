 
EXPORT Base_4500_MAC_PopulationStatistics(infile,Ref='',Input_powid = '',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_bdid = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_process_date_first_seen = '',Input_process_date_last_seen = '',Input_record_type = '',Input_process_date = '',Input_file_number = '',Input_segment_code = '',Input_sequence_number = '',Input_total_ucc_filed = '',Input_coll_count_ucc = '',Input_coll_code1 = '',Input_coll_desc1 = '',Input_coll_code2 = '',Input_coll_desc2 = '',Input_coll_code3 = '',Input_coll_desc3 = '',Input_coll_code4 = '',Input_coll_desc4 = '',Input_coll_code5 = '',Input_coll_desc5 = '',Input_coll_code6 = '',Input_coll_desc6 = '',Input_coll_code7 = '',Input_coll_desc7 = '',Input_coll_code8 = '',Input_coll_desc8 = '',Input_coll_code9 = '',Input_coll_desc9 = '',Input_coll_code10 = '',Input_coll_desc10 = '',Input_coll_code11 = '',Input_coll_desc11 = '',Input_coll_code12 = '',Input_coll_desc12 = '',Input_addtnl_coll_codes = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_total_ucc_filed)='' )
      '' 
    #ELSE
        IF( le.Input_total_ucc_filed = (TYPEOF(le.Input_total_ucc_filed))'','',':total_ucc_filed')
    #END
 
+    #IF( #TEXT(Input_coll_count_ucc)='' )
      '' 
    #ELSE
        IF( le.Input_coll_count_ucc = (TYPEOF(le.Input_coll_count_ucc))'','',':coll_count_ucc')
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
 
+    #IF( #TEXT(Input_coll_code7)='' )
      '' 
    #ELSE
        IF( le.Input_coll_code7 = (TYPEOF(le.Input_coll_code7))'','',':coll_code7')
    #END
 
+    #IF( #TEXT(Input_coll_desc7)='' )
      '' 
    #ELSE
        IF( le.Input_coll_desc7 = (TYPEOF(le.Input_coll_desc7))'','',':coll_desc7')
    #END
 
+    #IF( #TEXT(Input_coll_code8)='' )
      '' 
    #ELSE
        IF( le.Input_coll_code8 = (TYPEOF(le.Input_coll_code8))'','',':coll_code8')
    #END
 
+    #IF( #TEXT(Input_coll_desc8)='' )
      '' 
    #ELSE
        IF( le.Input_coll_desc8 = (TYPEOF(le.Input_coll_desc8))'','',':coll_desc8')
    #END
 
+    #IF( #TEXT(Input_coll_code9)='' )
      '' 
    #ELSE
        IF( le.Input_coll_code9 = (TYPEOF(le.Input_coll_code9))'','',':coll_code9')
    #END
 
+    #IF( #TEXT(Input_coll_desc9)='' )
      '' 
    #ELSE
        IF( le.Input_coll_desc9 = (TYPEOF(le.Input_coll_desc9))'','',':coll_desc9')
    #END
 
+    #IF( #TEXT(Input_coll_code10)='' )
      '' 
    #ELSE
        IF( le.Input_coll_code10 = (TYPEOF(le.Input_coll_code10))'','',':coll_code10')
    #END
 
+    #IF( #TEXT(Input_coll_desc10)='' )
      '' 
    #ELSE
        IF( le.Input_coll_desc10 = (TYPEOF(le.Input_coll_desc10))'','',':coll_desc10')
    #END
 
+    #IF( #TEXT(Input_coll_code11)='' )
      '' 
    #ELSE
        IF( le.Input_coll_code11 = (TYPEOF(le.Input_coll_code11))'','',':coll_code11')
    #END
 
+    #IF( #TEXT(Input_coll_desc11)='' )
      '' 
    #ELSE
        IF( le.Input_coll_desc11 = (TYPEOF(le.Input_coll_desc11))'','',':coll_desc11')
    #END
 
+    #IF( #TEXT(Input_coll_code12)='' )
      '' 
    #ELSE
        IF( le.Input_coll_code12 = (TYPEOF(le.Input_coll_code12))'','',':coll_code12')
    #END
 
+    #IF( #TEXT(Input_coll_desc12)='' )
      '' 
    #ELSE
        IF( le.Input_coll_desc12 = (TYPEOF(le.Input_coll_desc12))'','',':coll_desc12')
    #END
 
+    #IF( #TEXT(Input_addtnl_coll_codes)='' )
      '' 
    #ELSE
        IF( le.Input_addtnl_coll_codes = (TYPEOF(le.Input_addtnl_coll_codes))'','',':addtnl_coll_codes')
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
