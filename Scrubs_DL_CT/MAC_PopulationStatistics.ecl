 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_append_process_date = '',Input_credentialstate = '',Input_credentialnumber = '',Input_lastname = '',Input_firstname = '',Input_middleinitial = '',Input_gender = '',Input_height = '',Input_eyecolor = '',Input_date_birth = '',Input_resiaddrstreet = '',Input_residencycity = '',Input_residencystate = '',Input_residencyzip = '',Input_mailaddrstreet = '',Input_mailingcity = '',Input_mailingstate = '',Input_mailingzip = '',Input_credentialtype = '',Input_credential_class = '',Input_endorsements = '',Input_restrictions = '',Input_expdate = '',Input_lastissuerenewaldate = '',Input_date_noncdl = '',Input_originaldate_cdl = '',Input_statusnoncdl = '',Input_licensestatuscdl = '',Input_originaldate_lp = '',Input_originaldate_id = '',Input_cancelstate = '',Input_canceldate = '',Input_cdlmedicertissuedate = '',Input_cdlmedicertexpdate = '',Input_clean_name_prefix = '',Input_clean_name_first = '',Input_clean_name_middle = '',Input_clean_name_last = '',Input_clean_name_suffix = '',Input_clean_name_score = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_DL_CT;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_append_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_append_process_date = (TYPEOF(le.Input_append_process_date))'','',':append_process_date')
    #END
 
+    #IF( #TEXT(Input_credentialstate)='' )
      '' 
    #ELSE
        IF( le.Input_credentialstate = (TYPEOF(le.Input_credentialstate))'','',':credentialstate')
    #END
 
+    #IF( #TEXT(Input_credentialnumber)='' )
      '' 
    #ELSE
        IF( le.Input_credentialnumber = (TYPEOF(le.Input_credentialnumber))'','',':credentialnumber')
    #END
 
+    #IF( #TEXT(Input_lastname)='' )
      '' 
    #ELSE
        IF( le.Input_lastname = (TYPEOF(le.Input_lastname))'','',':lastname')
    #END
 
+    #IF( #TEXT(Input_firstname)='' )
      '' 
    #ELSE
        IF( le.Input_firstname = (TYPEOF(le.Input_firstname))'','',':firstname')
    #END
 
+    #IF( #TEXT(Input_middleinitial)='' )
      '' 
    #ELSE
        IF( le.Input_middleinitial = (TYPEOF(le.Input_middleinitial))'','',':middleinitial')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_height)='' )
      '' 
    #ELSE
        IF( le.Input_height = (TYPEOF(le.Input_height))'','',':height')
    #END
 
+    #IF( #TEXT(Input_eyecolor)='' )
      '' 
    #ELSE
        IF( le.Input_eyecolor = (TYPEOF(le.Input_eyecolor))'','',':eyecolor')
    #END
 
+    #IF( #TEXT(Input_date_birth)='' )
      '' 
    #ELSE
        IF( le.Input_date_birth = (TYPEOF(le.Input_date_birth))'','',':date_birth')
    #END
 
+    #IF( #TEXT(Input_resiaddrstreet)='' )
      '' 
    #ELSE
        IF( le.Input_resiaddrstreet = (TYPEOF(le.Input_resiaddrstreet))'','',':resiaddrstreet')
    #END
 
+    #IF( #TEXT(Input_residencycity)='' )
      '' 
    #ELSE
        IF( le.Input_residencycity = (TYPEOF(le.Input_residencycity))'','',':residencycity')
    #END
 
+    #IF( #TEXT(Input_residencystate)='' )
      '' 
    #ELSE
        IF( le.Input_residencystate = (TYPEOF(le.Input_residencystate))'','',':residencystate')
    #END
 
+    #IF( #TEXT(Input_residencyzip)='' )
      '' 
    #ELSE
        IF( le.Input_residencyzip = (TYPEOF(le.Input_residencyzip))'','',':residencyzip')
    #END
 
+    #IF( #TEXT(Input_mailaddrstreet)='' )
      '' 
    #ELSE
        IF( le.Input_mailaddrstreet = (TYPEOF(le.Input_mailaddrstreet))'','',':mailaddrstreet')
    #END
 
+    #IF( #TEXT(Input_mailingcity)='' )
      '' 
    #ELSE
        IF( le.Input_mailingcity = (TYPEOF(le.Input_mailingcity))'','',':mailingcity')
    #END
 
+    #IF( #TEXT(Input_mailingstate)='' )
      '' 
    #ELSE
        IF( le.Input_mailingstate = (TYPEOF(le.Input_mailingstate))'','',':mailingstate')
    #END
 
+    #IF( #TEXT(Input_mailingzip)='' )
      '' 
    #ELSE
        IF( le.Input_mailingzip = (TYPEOF(le.Input_mailingzip))'','',':mailingzip')
    #END
 
+    #IF( #TEXT(Input_credentialtype)='' )
      '' 
    #ELSE
        IF( le.Input_credentialtype = (TYPEOF(le.Input_credentialtype))'','',':credentialtype')
    #END
 
+    #IF( #TEXT(Input_credential_class)='' )
      '' 
    #ELSE
        IF( le.Input_credential_class = (TYPEOF(le.Input_credential_class))'','',':credential_class')
    #END
 
+    #IF( #TEXT(Input_endorsements)='' )
      '' 
    #ELSE
        IF( le.Input_endorsements = (TYPEOF(le.Input_endorsements))'','',':endorsements')
    #END
 
+    #IF( #TEXT(Input_restrictions)='' )
      '' 
    #ELSE
        IF( le.Input_restrictions = (TYPEOF(le.Input_restrictions))'','',':restrictions')
    #END
 
+    #IF( #TEXT(Input_expdate)='' )
      '' 
    #ELSE
        IF( le.Input_expdate = (TYPEOF(le.Input_expdate))'','',':expdate')
    #END
 
+    #IF( #TEXT(Input_lastissuerenewaldate)='' )
      '' 
    #ELSE
        IF( le.Input_lastissuerenewaldate = (TYPEOF(le.Input_lastissuerenewaldate))'','',':lastissuerenewaldate')
    #END
 
+    #IF( #TEXT(Input_date_noncdl)='' )
      '' 
    #ELSE
        IF( le.Input_date_noncdl = (TYPEOF(le.Input_date_noncdl))'','',':date_noncdl')
    #END
 
+    #IF( #TEXT(Input_originaldate_cdl)='' )
      '' 
    #ELSE
        IF( le.Input_originaldate_cdl = (TYPEOF(le.Input_originaldate_cdl))'','',':originaldate_cdl')
    #END
 
+    #IF( #TEXT(Input_statusnoncdl)='' )
      '' 
    #ELSE
        IF( le.Input_statusnoncdl = (TYPEOF(le.Input_statusnoncdl))'','',':statusnoncdl')
    #END
 
+    #IF( #TEXT(Input_licensestatuscdl)='' )
      '' 
    #ELSE
        IF( le.Input_licensestatuscdl = (TYPEOF(le.Input_licensestatuscdl))'','',':licensestatuscdl')
    #END
 
+    #IF( #TEXT(Input_originaldate_lp)='' )
      '' 
    #ELSE
        IF( le.Input_originaldate_lp = (TYPEOF(le.Input_originaldate_lp))'','',':originaldate_lp')
    #END
 
+    #IF( #TEXT(Input_originaldate_id)='' )
      '' 
    #ELSE
        IF( le.Input_originaldate_id = (TYPEOF(le.Input_originaldate_id))'','',':originaldate_id')
    #END
 
+    #IF( #TEXT(Input_cancelstate)='' )
      '' 
    #ELSE
        IF( le.Input_cancelstate = (TYPEOF(le.Input_cancelstate))'','',':cancelstate')
    #END
 
+    #IF( #TEXT(Input_canceldate)='' )
      '' 
    #ELSE
        IF( le.Input_canceldate = (TYPEOF(le.Input_canceldate))'','',':canceldate')
    #END
 
+    #IF( #TEXT(Input_cdlmedicertissuedate)='' )
      '' 
    #ELSE
        IF( le.Input_cdlmedicertissuedate = (TYPEOF(le.Input_cdlmedicertissuedate))'','',':cdlmedicertissuedate')
    #END
 
+    #IF( #TEXT(Input_cdlmedicertexpdate)='' )
      '' 
    #ELSE
        IF( le.Input_cdlmedicertexpdate = (TYPEOF(le.Input_cdlmedicertexpdate))'','',':cdlmedicertexpdate')
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
