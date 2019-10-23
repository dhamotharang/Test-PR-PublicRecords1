 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_pers_surrogate = '',Input_filler1 = '',Input_license_licno = '',Input_filler2 = '',Input_license_bdate_yyyymmdd = '',Input_license_edate_yyyymmdd = '',Input_license_lic_class = '',Input_license_height = '',Input_license_sex = '',Input_license_last_name = '',Input_license_first_name = '',Input_license_middle_name = '',Input_licmail_street1 = '',Input_licmail_street2 = '',Input_licmail_city = '',Input_licmail_state = '',Input_licmail_zip = '',Input_licresi_street1 = '',Input_licresi_street2 = '',Input_licresi_city = '',Input_licresi_state = '',Input_licresi_zip = '',Input_issue_date_yyyymmdd = '',Input_license_status = '',Input_clean_status = '',Input_process_date = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_DL_MA;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_pers_surrogate)='' )
      '' 
    #ELSE
        IF( le.Input_pers_surrogate = (TYPEOF(le.Input_pers_surrogate))'','',':pers_surrogate')
    #END
 
+    #IF( #TEXT(Input_filler1)='' )
      '' 
    #ELSE
        IF( le.Input_filler1 = (TYPEOF(le.Input_filler1))'','',':filler1')
    #END
 
+    #IF( #TEXT(Input_license_licno)='' )
      '' 
    #ELSE
        IF( le.Input_license_licno = (TYPEOF(le.Input_license_licno))'','',':license_licno')
    #END
 
+    #IF( #TEXT(Input_filler2)='' )
      '' 
    #ELSE
        IF( le.Input_filler2 = (TYPEOF(le.Input_filler2))'','',':filler2')
    #END
 
+    #IF( #TEXT(Input_license_bdate_yyyymmdd)='' )
      '' 
    #ELSE
        IF( le.Input_license_bdate_yyyymmdd = (TYPEOF(le.Input_license_bdate_yyyymmdd))'','',':license_bdate_yyyymmdd')
    #END
 
+    #IF( #TEXT(Input_license_edate_yyyymmdd)='' )
      '' 
    #ELSE
        IF( le.Input_license_edate_yyyymmdd = (TYPEOF(le.Input_license_edate_yyyymmdd))'','',':license_edate_yyyymmdd')
    #END
 
+    #IF( #TEXT(Input_license_lic_class)='' )
      '' 
    #ELSE
        IF( le.Input_license_lic_class = (TYPEOF(le.Input_license_lic_class))'','',':license_lic_class')
    #END
 
+    #IF( #TEXT(Input_license_height)='' )
      '' 
    #ELSE
        IF( le.Input_license_height = (TYPEOF(le.Input_license_height))'','',':license_height')
    #END
 
+    #IF( #TEXT(Input_license_sex)='' )
      '' 
    #ELSE
        IF( le.Input_license_sex = (TYPEOF(le.Input_license_sex))'','',':license_sex')
    #END
 
+    #IF( #TEXT(Input_license_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_license_last_name = (TYPEOF(le.Input_license_last_name))'','',':license_last_name')
    #END
 
+    #IF( #TEXT(Input_license_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_license_first_name = (TYPEOF(le.Input_license_first_name))'','',':license_first_name')
    #END
 
+    #IF( #TEXT(Input_license_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_license_middle_name = (TYPEOF(le.Input_license_middle_name))'','',':license_middle_name')
    #END
 
+    #IF( #TEXT(Input_licmail_street1)='' )
      '' 
    #ELSE
        IF( le.Input_licmail_street1 = (TYPEOF(le.Input_licmail_street1))'','',':licmail_street1')
    #END
 
+    #IF( #TEXT(Input_licmail_street2)='' )
      '' 
    #ELSE
        IF( le.Input_licmail_street2 = (TYPEOF(le.Input_licmail_street2))'','',':licmail_street2')
    #END
 
+    #IF( #TEXT(Input_licmail_city)='' )
      '' 
    #ELSE
        IF( le.Input_licmail_city = (TYPEOF(le.Input_licmail_city))'','',':licmail_city')
    #END
 
+    #IF( #TEXT(Input_licmail_state)='' )
      '' 
    #ELSE
        IF( le.Input_licmail_state = (TYPEOF(le.Input_licmail_state))'','',':licmail_state')
    #END
 
+    #IF( #TEXT(Input_licmail_zip)='' )
      '' 
    #ELSE
        IF( le.Input_licmail_zip = (TYPEOF(le.Input_licmail_zip))'','',':licmail_zip')
    #END
 
+    #IF( #TEXT(Input_licresi_street1)='' )
      '' 
    #ELSE
        IF( le.Input_licresi_street1 = (TYPEOF(le.Input_licresi_street1))'','',':licresi_street1')
    #END
 
+    #IF( #TEXT(Input_licresi_street2)='' )
      '' 
    #ELSE
        IF( le.Input_licresi_street2 = (TYPEOF(le.Input_licresi_street2))'','',':licresi_street2')
    #END
 
+    #IF( #TEXT(Input_licresi_city)='' )
      '' 
    #ELSE
        IF( le.Input_licresi_city = (TYPEOF(le.Input_licresi_city))'','',':licresi_city')
    #END
 
+    #IF( #TEXT(Input_licresi_state)='' )
      '' 
    #ELSE
        IF( le.Input_licresi_state = (TYPEOF(le.Input_licresi_state))'','',':licresi_state')
    #END
 
+    #IF( #TEXT(Input_licresi_zip)='' )
      '' 
    #ELSE
        IF( le.Input_licresi_zip = (TYPEOF(le.Input_licresi_zip))'','',':licresi_zip')
    #END
 
+    #IF( #TEXT(Input_issue_date_yyyymmdd)='' )
      '' 
    #ELSE
        IF( le.Input_issue_date_yyyymmdd = (TYPEOF(le.Input_issue_date_yyyymmdd))'','',':issue_date_yyyymmdd')
    #END
 
+    #IF( #TEXT(Input_license_status)='' )
      '' 
    #ELSE
        IF( le.Input_license_status = (TYPEOF(le.Input_license_status))'','',':license_status')
    #END
 
+    #IF( #TEXT(Input_clean_status)='' )
      '' 
    #ELSE
        IF( le.Input_clean_status = (TYPEOF(le.Input_clean_status))'','',':clean_status')
    #END
 
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
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
