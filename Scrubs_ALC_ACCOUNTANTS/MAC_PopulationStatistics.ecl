 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_fname = '',Input_lname = '',Input_title = '',Input_company = '',Input_address1 = '',Input_address2 = '',Input_city = '',Input_state = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_bar = '',Input_gender = '',Input_country = '',Input_postal_cd = '',Input_dpv = '',Input_addr_type = '',Input_county_cd = '',Input_job_code = '',Input_nielsen_county_cd = '',Input_number_of_employees = '',Input_msa = '',Input_source_code = '',Input_company_type = '',Input_phone = '',Input_email = '',Input_list_id = '',Input_scno = '',Input_keycode = '',Input_custno = '',Input_license_no = '',Input_dob = '',Input_orig_date = '',Input_exp_date = '',Input_degree = '',Input_specialty = '',OutFile) := MACRO
  IMPORT SALT32,Scrubs_ALC_ACCOUNTANTS;
  #uniquename(of)
  %of% := RECORD
    SALT32.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (TYPEOF(le.Input_fname))'','',':fname')
    #END
 
+    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
    #END
 
+    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (TYPEOF(le.Input_title))'','',':title')
    #END
 
+    #IF( #TEXT(Input_company)='' )
      '' 
    #ELSE
        IF( le.Input_company = (TYPEOF(le.Input_company))'','',':company')
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
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
 
+    #IF( #TEXT(Input_cart)='' )
      '' 
    #ELSE
        IF( le.Input_cart = (TYPEOF(le.Input_cart))'','',':cart')
    #END
 
+    #IF( #TEXT(Input_bar)='' )
      '' 
    #ELSE
        IF( le.Input_bar = (TYPEOF(le.Input_bar))'','',':bar')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_country)='' )
      '' 
    #ELSE
        IF( le.Input_country = (TYPEOF(le.Input_country))'','',':country')
    #END
 
+    #IF( #TEXT(Input_postal_cd)='' )
      '' 
    #ELSE
        IF( le.Input_postal_cd = (TYPEOF(le.Input_postal_cd))'','',':postal_cd')
    #END
 
+    #IF( #TEXT(Input_dpv)='' )
      '' 
    #ELSE
        IF( le.Input_dpv = (TYPEOF(le.Input_dpv))'','',':dpv')
    #END
 
+    #IF( #TEXT(Input_addr_type)='' )
      '' 
    #ELSE
        IF( le.Input_addr_type = (TYPEOF(le.Input_addr_type))'','',':addr_type')
    #END
 
+    #IF( #TEXT(Input_county_cd)='' )
      '' 
    #ELSE
        IF( le.Input_county_cd = (TYPEOF(le.Input_county_cd))'','',':county_cd')
    #END
 
+    #IF( #TEXT(Input_job_code)='' )
      '' 
    #ELSE
        IF( le.Input_job_code = (TYPEOF(le.Input_job_code))'','',':job_code')
    #END
 
+    #IF( #TEXT(Input_nielsen_county_cd)='' )
      '' 
    #ELSE
        IF( le.Input_nielsen_county_cd = (TYPEOF(le.Input_nielsen_county_cd))'','',':nielsen_county_cd')
    #END
 
+    #IF( #TEXT(Input_number_of_employees)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_employees = (TYPEOF(le.Input_number_of_employees))'','',':number_of_employees')
    #END
 
+    #IF( #TEXT(Input_msa)='' )
      '' 
    #ELSE
        IF( le.Input_msa = (TYPEOF(le.Input_msa))'','',':msa')
    #END
 
+    #IF( #TEXT(Input_source_code)='' )
      '' 
    #ELSE
        IF( le.Input_source_code = (TYPEOF(le.Input_source_code))'','',':source_code')
    #END
 
+    #IF( #TEXT(Input_company_type)='' )
      '' 
    #ELSE
        IF( le.Input_company_type = (TYPEOF(le.Input_company_type))'','',':company_type')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_email)='' )
      '' 
    #ELSE
        IF( le.Input_email = (TYPEOF(le.Input_email))'','',':email')
    #END
 
+    #IF( #TEXT(Input_list_id)='' )
      '' 
    #ELSE
        IF( le.Input_list_id = (TYPEOF(le.Input_list_id))'','',':list_id')
    #END
 
+    #IF( #TEXT(Input_scno)='' )
      '' 
    #ELSE
        IF( le.Input_scno = (TYPEOF(le.Input_scno))'','',':scno')
    #END
 
+    #IF( #TEXT(Input_keycode)='' )
      '' 
    #ELSE
        IF( le.Input_keycode = (TYPEOF(le.Input_keycode))'','',':keycode')
    #END
 
+    #IF( #TEXT(Input_custno)='' )
      '' 
    #ELSE
        IF( le.Input_custno = (TYPEOF(le.Input_custno))'','',':custno')
    #END
 
+    #IF( #TEXT(Input_license_no)='' )
      '' 
    #ELSE
        IF( le.Input_license_no = (TYPEOF(le.Input_license_no))'','',':license_no')
    #END
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_orig_date)='' )
      '' 
    #ELSE
        IF( le.Input_orig_date = (TYPEOF(le.Input_orig_date))'','',':orig_date')
    #END
 
+    #IF( #TEXT(Input_exp_date)='' )
      '' 
    #ELSE
        IF( le.Input_exp_date = (TYPEOF(le.Input_exp_date))'','',':exp_date')
    #END
 
+    #IF( #TEXT(Input_degree)='' )
      '' 
    #ELSE
        IF( le.Input_degree = (TYPEOF(le.Input_degree))'','',':degree')
    #END
 
+    #IF( #TEXT(Input_specialty)='' )
      '' 
    #ELSE
        IF( le.Input_specialty = (TYPEOF(le.Input_specialty))'','',':specialty')
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
