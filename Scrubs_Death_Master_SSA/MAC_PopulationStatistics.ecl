EXPORT MAC_PopulationStatistics(infile,Ref='',rec_type='',Input_filedate = '',Input_rec_type = '',Input_rec_type_orig = '',Input_ssn = '',Input_lname = '',Input_name_suffix = '',Input_fname = '',Input_mname = '',Input_vorp_code = '',Input_dod8 = '',Input_dob8 = '',Input_st_country_code = '',Input_zip_lastres = '',Input_zip_lastpayment = '',Input_state = '',Input_fipscounty = '',Input_clean_title = '',Input_clean_fname = '',Input_clean_mname = '',Input_clean_lname = '',Input_clean_name_suffix = '',Input_clean_name_score = '',Input_crlf = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_Death_Master_SSA;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(rec_type)<>'')
    SALT30.StrType source;
    #END
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_filedate)='' )
      '' 
    #ELSE
        IF( le.Input_filedate = (TYPEOF(le.Input_filedate))'','',':filedate')
    #END
+    #IF( #TEXT(Input_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_rec_type = (TYPEOF(le.Input_rec_type))'','',':rec_type')
    #END
+    #IF( #TEXT(Input_rec_type_orig)='' )
      '' 
    #ELSE
        IF( le.Input_rec_type_orig = (TYPEOF(le.Input_rec_type_orig))'','',':rec_type_orig')
    #END
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
+    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
    #END
+    #IF( #TEXT(Input_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix = (TYPEOF(le.Input_name_suffix))'','',':name_suffix')
    #END
+    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (TYPEOF(le.Input_fname))'','',':fname')
    #END
+    #IF( #TEXT(Input_mname)='' )
      '' 
    #ELSE
        IF( le.Input_mname = (TYPEOF(le.Input_mname))'','',':mname')
    #END
+    #IF( #TEXT(Input_vorp_code)='' )
      '' 
    #ELSE
        IF( le.Input_vorp_code = (TYPEOF(le.Input_vorp_code))'','',':vorp_code')
    #END
+    #IF( #TEXT(Input_dod8)='' )
      '' 
    #ELSE
        IF( le.Input_dod8 = (TYPEOF(le.Input_dod8))'','',':dod8')
    #END
+    #IF( #TEXT(Input_dob8)='' )
      '' 
    #ELSE
        IF( le.Input_dob8 = (TYPEOF(le.Input_dob8))'','',':dob8')
    #END
+    #IF( #TEXT(Input_st_country_code)='' )
      '' 
    #ELSE
        IF( le.Input_st_country_code = (TYPEOF(le.Input_st_country_code))'','',':st_country_code')
    #END
+    #IF( #TEXT(Input_zip_lastres)='' )
      '' 
    #ELSE
        IF( le.Input_zip_lastres = (TYPEOF(le.Input_zip_lastres))'','',':zip_lastres')
    #END
+    #IF( #TEXT(Input_zip_lastpayment)='' )
      '' 
    #ELSE
        IF( le.Input_zip_lastpayment = (TYPEOF(le.Input_zip_lastpayment))'','',':zip_lastpayment')
    #END
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
+    #IF( #TEXT(Input_fipscounty)='' )
      '' 
    #ELSE
        IF( le.Input_fipscounty = (TYPEOF(le.Input_fipscounty))'','',':fipscounty')
    #END
+    #IF( #TEXT(Input_clean_title)='' )
      '' 
    #ELSE
        IF( le.Input_clean_title = (TYPEOF(le.Input_clean_title))'','',':clean_title')
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
+    #IF( #TEXT(Input_crlf)='' )
      '' 
    #ELSE
        IF( le.Input_crlf = (TYPEOF(le.Input_crlf))'','',':crlf')
    #END
;
    #IF (#TEXT(rec_type)<>'')
    SELF.source := le.rec_type;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(rec_type)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(rec_type)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(rec_type)<>'' ) source, #END -cnt );
ENDMACRO;
