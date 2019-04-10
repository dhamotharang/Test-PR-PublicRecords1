 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_dtmatch = '',Input_email = '',Input_name_full = '',Input_address1 = '',Input_address2 = '',Input_city = '',Input_state = '',Input_zip5 = '',Input_zip_ext = '',Input_ipaddr = '',Input_datestamp = '',Input_url = '',Input_lastdate = '',Input_em_src_cnt = '',Input_num_emails = '',Input_num_indiv = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_DunnData_Email;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dtmatch)='' )
      '' 
    #ELSE
        IF( le.Input_dtmatch = (TYPEOF(le.Input_dtmatch))'','',':dtmatch')
    #END
 
+    #IF( #TEXT(Input_email)='' )
      '' 
    #ELSE
        IF( le.Input_email = (TYPEOF(le.Input_email))'','',':email')
    #END
 
+    #IF( #TEXT(Input_name_full)='' )
      '' 
    #ELSE
        IF( le.Input_name_full = (TYPEOF(le.Input_name_full))'','',':name_full')
    #END
 
+    #IF( #TEXT(Input_address1)='' )
      '' 
    #ELSE
        IF( le.Input_address1 = (TYPEOF(le.Input_address1))'','',':address1')
    #END
 
+    #IF( #TEXT(Input_address2)='' )
      '' 
    #ELSE
        IF( le.Input_address2 = (TYPEOF(le.Input_address2))'','',':address2')
    #END
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_zip5 = (TYPEOF(le.Input_zip5))'','',':zip5')
    #END
 
+    #IF( #TEXT(Input_zip_ext)='' )
      '' 
    #ELSE
        IF( le.Input_zip_ext = (TYPEOF(le.Input_zip_ext))'','',':zip_ext')
    #END
 
+    #IF( #TEXT(Input_ipaddr)='' )
      '' 
    #ELSE
        IF( le.Input_ipaddr = (TYPEOF(le.Input_ipaddr))'','',':ipaddr')
    #END
 
+    #IF( #TEXT(Input_datestamp)='' )
      '' 
    #ELSE
        IF( le.Input_datestamp = (TYPEOF(le.Input_datestamp))'','',':datestamp')
    #END
 
+    #IF( #TEXT(Input_url)='' )
      '' 
    #ELSE
        IF( le.Input_url = (TYPEOF(le.Input_url))'','',':url')
    #END
 
+    #IF( #TEXT(Input_lastdate)='' )
      '' 
    #ELSE
        IF( le.Input_lastdate = (TYPEOF(le.Input_lastdate))'','',':lastdate')
    #END
 
+    #IF( #TEXT(Input_em_src_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_em_src_cnt = (TYPEOF(le.Input_em_src_cnt))'','',':em_src_cnt')
    #END
 
+    #IF( #TEXT(Input_num_emails)='' )
      '' 
    #ELSE
        IF( le.Input_num_emails = (TYPEOF(le.Input_num_emails))'','',':num_emails')
    #END
 
+    #IF( #TEXT(Input_num_indiv)='' )
      '' 
    #ELSE
        IF( le.Input_num_indiv = (TYPEOF(le.Input_num_indiv))'','',':num_indiv')
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
