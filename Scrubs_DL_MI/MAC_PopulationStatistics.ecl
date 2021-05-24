 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_process_date = '',Input_code = '',Input_customer_dln_pid = '',Input_last_name = '',Input_first_name = '',Input_middle_name = '',Input_name_suffix = '',Input_street_address = '',Input_city = '',Input_state = '',Input_zipcode = '',Input_date_of_birth = '',Input_gender = '',Input_county = '',Input_dln_pid_indicator = '',Input_mailing_street_address = '',Input_mailing_city = '',Input_mailing_state = '',Input_mailing_zipcode = '',Input_blob = '',Input_clean_name_prefix = '',Input_clean_fname = '',Input_clean_mname = '',Input_clean_lname = '',Input_clean_name_suffix = '',Input_clean_name_score = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_DL_MI;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_code)='' )
      '' 
    #ELSE
        IF( le.Input_code = (TYPEOF(le.Input_code))'','',':code')
    #END
 
+    #IF( #TEXT(Input_customer_dln_pid)='' )
      '' 
    #ELSE
        IF( le.Input_customer_dln_pid = (TYPEOF(le.Input_customer_dln_pid))'','',':customer_dln_pid')
    #END
 
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
    #END
 
+    #IF( #TEXT(Input_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_name = (TYPEOF(le.Input_first_name))'','',':first_name')
    #END
 
+    #IF( #TEXT(Input_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_middle_name = (TYPEOF(le.Input_middle_name))'','',':middle_name')
    #END
 
+    #IF( #TEXT(Input_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix = (TYPEOF(le.Input_name_suffix))'','',':name_suffix')
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
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_zipcode)='' )
      '' 
    #ELSE
        IF( le.Input_zipcode = (TYPEOF(le.Input_zipcode))'','',':zipcode')
    #END
 
+    #IF( #TEXT(Input_date_of_birth)='' )
      '' 
    #ELSE
        IF( le.Input_date_of_birth = (TYPEOF(le.Input_date_of_birth))'','',':date_of_birth')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
    #END
 
+    #IF( #TEXT(Input_dln_pid_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_dln_pid_indicator = (TYPEOF(le.Input_dln_pid_indicator))'','',':dln_pid_indicator')
    #END
 
+    #IF( #TEXT(Input_mailing_street_address)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_street_address = (TYPEOF(le.Input_mailing_street_address))'','',':mailing_street_address')
    #END
 
+    #IF( #TEXT(Input_mailing_city)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_city = (TYPEOF(le.Input_mailing_city))'','',':mailing_city')
    #END
 
+    #IF( #TEXT(Input_mailing_state)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_state = (TYPEOF(le.Input_mailing_state))'','',':mailing_state')
    #END
 
+    #IF( #TEXT(Input_mailing_zipcode)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_zipcode = (TYPEOF(le.Input_mailing_zipcode))'','',':mailing_zipcode')
    #END
 
+    #IF( #TEXT(Input_blob)='' )
      '' 
    #ELSE
        IF( le.Input_blob = (TYPEOF(le.Input_blob))'','',':blob')
    #END
 
+    #IF( #TEXT(Input_clean_name_prefix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_prefix = (TYPEOF(le.Input_clean_name_prefix))'','',':clean_name_prefix')
    #END
 
+    #IF( #TEXT(Input_clean_fname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_fname = (TYPEOF(le.Input_clean_fname))'','',':clean_fname')
    #END
 
+    #IF( #TEXT(Input_clean_mname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_mname = (TYPEOF(le.Input_clean_mname))'','',':clean_mname')
    #END
 
+    #IF( #TEXT(Input_clean_lname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_lname = (TYPEOF(le.Input_clean_lname))'','',':clean_lname')
    #END
 
+    #IF( #TEXT(Input_clean_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_suffix = (TYPEOF(le.Input_clean_name_suffix))'','',':clean_name_suffix')
    #END
 
+    #IF( #TEXT(Input_clean_name_score)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_score = (TYPEOF(le.Input_clean_name_score))'','',':clean_name_score')
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
