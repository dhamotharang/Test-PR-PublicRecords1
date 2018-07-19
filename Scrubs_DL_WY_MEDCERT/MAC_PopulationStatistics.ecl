 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_append_process_date = '',Input_orig_first_name = '',Input_orig_middle_name = '',Input_orig_last_name = '',Input_mailing_street_addr_1 = '',Input_mailing_city_1 = '',Input_mailing_state_1 = '',Input_mailing_zip_code_1 = '',Input_phys_street_addr_2 = '',Input_phys_city_2 = '',Input_phys_state_2 = '',Input_phys_zip_code_2 = '',Input_orig_dl_number = '',Input_orig_dob = '',Input_orig_code_1 = '',Input_orig_code_2 = '',Input_orig_code_3 = '',Input_orig_code_4 = '',Input_orig_code_5 = '',Input_orig_code_6 = '',Input_orig_code_7 = '',Input_orig_code_8 = '',Input_orig_issue_date = '',Input_orig_expire_date = '',Input_med_cert_status = '',Input_med_cert_type = '',Input_med_cert_expire_date = '',Input_name_suffix = '',Input_clean_name_prefix = '',Input_clean_name_first = '',Input_clean_name_middle = '',Input_clean_name_last = '',Input_clean_name_suffix = '',Input_clean_name_score = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_DL_WY_MEDCERT;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_append_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_append_process_date = (TYPEOF(le.Input_append_process_date))'','',':append_process_date')
    #END
 
+    #IF( #TEXT(Input_orig_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_first_name = (TYPEOF(le.Input_orig_first_name))'','',':orig_first_name')
    #END
 
+    #IF( #TEXT(Input_orig_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_middle_name = (TYPEOF(le.Input_orig_middle_name))'','',':orig_middle_name')
    #END
 
+    #IF( #TEXT(Input_orig_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_last_name = (TYPEOF(le.Input_orig_last_name))'','',':orig_last_name')
    #END
 
+    #IF( #TEXT(Input_mailing_street_addr_1)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_street_addr_1 = (TYPEOF(le.Input_mailing_street_addr_1))'','',':mailing_street_addr_1')
    #END
 
+    #IF( #TEXT(Input_mailing_city_1)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_city_1 = (TYPEOF(le.Input_mailing_city_1))'','',':mailing_city_1')
    #END
 
+    #IF( #TEXT(Input_mailing_state_1)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_state_1 = (TYPEOF(le.Input_mailing_state_1))'','',':mailing_state_1')
    #END
 
+    #IF( #TEXT(Input_mailing_zip_code_1)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_zip_code_1 = (TYPEOF(le.Input_mailing_zip_code_1))'','',':mailing_zip_code_1')
    #END
 
+    #IF( #TEXT(Input_phys_street_addr_2)='' )
      '' 
    #ELSE
        IF( le.Input_phys_street_addr_2 = (TYPEOF(le.Input_phys_street_addr_2))'','',':phys_street_addr_2')
    #END
 
+    #IF( #TEXT(Input_phys_city_2)='' )
      '' 
    #ELSE
        IF( le.Input_phys_city_2 = (TYPEOF(le.Input_phys_city_2))'','',':phys_city_2')
    #END
 
+    #IF( #TEXT(Input_phys_state_2)='' )
      '' 
    #ELSE
        IF( le.Input_phys_state_2 = (TYPEOF(le.Input_phys_state_2))'','',':phys_state_2')
    #END
 
+    #IF( #TEXT(Input_phys_zip_code_2)='' )
      '' 
    #ELSE
        IF( le.Input_phys_zip_code_2 = (TYPEOF(le.Input_phys_zip_code_2))'','',':phys_zip_code_2')
    #END
 
+    #IF( #TEXT(Input_orig_dl_number)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dl_number = (TYPEOF(le.Input_orig_dl_number))'','',':orig_dl_number')
    #END
 
+    #IF( #TEXT(Input_orig_dob)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dob = (TYPEOF(le.Input_orig_dob))'','',':orig_dob')
    #END
 
+    #IF( #TEXT(Input_orig_code_1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_code_1 = (TYPEOF(le.Input_orig_code_1))'','',':orig_code_1')
    #END
 
+    #IF( #TEXT(Input_orig_code_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_code_2 = (TYPEOF(le.Input_orig_code_2))'','',':orig_code_2')
    #END
 
+    #IF( #TEXT(Input_orig_code_3)='' )
      '' 
    #ELSE
        IF( le.Input_orig_code_3 = (TYPEOF(le.Input_orig_code_3))'','',':orig_code_3')
    #END
 
+    #IF( #TEXT(Input_orig_code_4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_code_4 = (TYPEOF(le.Input_orig_code_4))'','',':orig_code_4')
    #END
 
+    #IF( #TEXT(Input_orig_code_5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_code_5 = (TYPEOF(le.Input_orig_code_5))'','',':orig_code_5')
    #END
 
+    #IF( #TEXT(Input_orig_code_6)='' )
      '' 
    #ELSE
        IF( le.Input_orig_code_6 = (TYPEOF(le.Input_orig_code_6))'','',':orig_code_6')
    #END
 
+    #IF( #TEXT(Input_orig_code_7)='' )
      '' 
    #ELSE
        IF( le.Input_orig_code_7 = (TYPEOF(le.Input_orig_code_7))'','',':orig_code_7')
    #END
 
+    #IF( #TEXT(Input_orig_code_8)='' )
      '' 
    #ELSE
        IF( le.Input_orig_code_8 = (TYPEOF(le.Input_orig_code_8))'','',':orig_code_8')
    #END
 
+    #IF( #TEXT(Input_orig_issue_date)='' )
      '' 
    #ELSE
        IF( le.Input_orig_issue_date = (TYPEOF(le.Input_orig_issue_date))'','',':orig_issue_date')
    #END
 
+    #IF( #TEXT(Input_orig_expire_date)='' )
      '' 
    #ELSE
        IF( le.Input_orig_expire_date = (TYPEOF(le.Input_orig_expire_date))'','',':orig_expire_date')
    #END
 
+    #IF( #TEXT(Input_med_cert_status)='' )
      '' 
    #ELSE
        IF( le.Input_med_cert_status = (TYPEOF(le.Input_med_cert_status))'','',':med_cert_status')
    #END
 
+    #IF( #TEXT(Input_med_cert_type)='' )
      '' 
    #ELSE
        IF( le.Input_med_cert_type = (TYPEOF(le.Input_med_cert_type))'','',':med_cert_type')
    #END
 
+    #IF( #TEXT(Input_med_cert_expire_date)='' )
      '' 
    #ELSE
        IF( le.Input_med_cert_expire_date = (TYPEOF(le.Input_med_cert_expire_date))'','',':med_cert_expire_date')
    #END
 
+    #IF( #TEXT(Input_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix = (TYPEOF(le.Input_name_suffix))'','',':name_suffix')
    #END
 
+    #IF( #TEXT(Input_clean_name_prefix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_prefix = (TYPEOF(le.Input_clean_name_prefix))'','',':clean_name_prefix')
    #END
 
+    #IF( #TEXT(Input_clean_name_first)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_first = (TYPEOF(le.Input_clean_name_first))'','',':clean_name_first')
    #END
 
+    #IF( #TEXT(Input_clean_name_middle)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_middle = (TYPEOF(le.Input_clean_name_middle))'','',':clean_name_middle')
    #END
 
+    #IF( #TEXT(Input_clean_name_last)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_last = (TYPEOF(le.Input_clean_name_last))'','',':clean_name_last')
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
