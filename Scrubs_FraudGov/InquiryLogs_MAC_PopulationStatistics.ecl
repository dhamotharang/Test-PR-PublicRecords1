 
EXPORT InquiryLogs_MAC_PopulationStatistics(infile,Ref='',Input_transaction_id = '',Input_datetime = '',Input_full_name = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_ssn = '',Input_appended_ssn = '',Input_address = '',Input_city = '',Input_state = '',Input_zip = '',Input_fips_county = '',Input_personal_phone = '',Input_dob = '',Input_email_address = '',Input_dl_st = '',Input_dl = '',Input_ipaddr = '',Input_geo_lat = '',Input_geo_long = '',Input_Source = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_FraudGov;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_transaction_id)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_id = (TYPEOF(le.Input_transaction_id))'','',':transaction_id')
    #END
 
+    #IF( #TEXT(Input_datetime)='' )
      '' 
    #ELSE
        IF( le.Input_datetime = (TYPEOF(le.Input_datetime))'','',':datetime')
    #END
 
+    #IF( #TEXT(Input_full_name)='' )
      '' 
    #ELSE
        IF( le.Input_full_name = (TYPEOF(le.Input_full_name))'','',':full_name')
    #END
 
+    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (TYPEOF(le.Input_title))'','',':title')
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
 
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
 
+    #IF( #TEXT(Input_appended_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_appended_ssn = (TYPEOF(le.Input_appended_ssn))'','',':appended_ssn')
    #END
 
+    #IF( #TEXT(Input_address)='' )
      '' 
    #ELSE
        IF( le.Input_address = (TYPEOF(le.Input_address))'','',':address')
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
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_fips_county = (TYPEOF(le.Input_fips_county))'','',':fips_county')
    #END
 
+    #IF( #TEXT(Input_personal_phone)='' )
      '' 
    #ELSE
        IF( le.Input_personal_phone = (TYPEOF(le.Input_personal_phone))'','',':personal_phone')
    #END
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_email_address)='' )
      '' 
    #ELSE
        IF( le.Input_email_address = (TYPEOF(le.Input_email_address))'','',':email_address')
    #END
 
+    #IF( #TEXT(Input_dl_st)='' )
      '' 
    #ELSE
        IF( le.Input_dl_st = (TYPEOF(le.Input_dl_st))'','',':dl_st')
    #END
 
+    #IF( #TEXT(Input_dl)='' )
      '' 
    #ELSE
        IF( le.Input_dl = (TYPEOF(le.Input_dl))'','',':dl')
    #END
 
+    #IF( #TEXT(Input_ipaddr)='' )
      '' 
    #ELSE
        IF( le.Input_ipaddr = (TYPEOF(le.Input_ipaddr))'','',':ipaddr')
    #END
 
+    #IF( #TEXT(Input_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_geo_lat = (TYPEOF(le.Input_geo_lat))'','',':geo_lat')
    #END
 
+    #IF( #TEXT(Input_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_geo_long = (TYPEOF(le.Input_geo_long))'','',':geo_long')
    #END
 
+    #IF( #TEXT(Input_Source)='' )
      '' 
    #ELSE
        IF( le.Input_Source = (TYPEOF(le.Input_Source))'','',':Source')
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
