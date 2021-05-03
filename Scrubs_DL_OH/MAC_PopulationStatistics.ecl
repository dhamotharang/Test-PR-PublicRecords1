 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_process_date = '',Input_key_number = '',Input_license_number = '',Input_license_class = '',Input_donor_flag = '',Input_hair_color = '',Input_eye_color = '',Input_weight_l = '',Input_height_feet = '',Input_height_inches = '',Input_sex_gender = '',Input_permanent_license_issue_date = '',Input_license_expiration_date = '',Input_restriction_codes = '',Input_endorsement_codes = '',Input_first_name = '',Input_middle_name = '',Input_last_name = '',Input_street_address = '',Input_city = '',Input_state = '',Input_zip_code = '',Input_county_number = '',Input_birth_date = '',Input_clean_name_prefix = '',Input_clean_fname = '',Input_clean_mname = '',Input_clean_lname = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_DL_OH;
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
 
+    #IF( #TEXT(Input_key_number)='' )
      '' 
    #ELSE
        IF( le.Input_key_number = (TYPEOF(le.Input_key_number))'','',':key_number')
    #END
 
+    #IF( #TEXT(Input_license_number)='' )
      '' 
    #ELSE
        IF( le.Input_license_number = (TYPEOF(le.Input_license_number))'','',':license_number')
    #END
 
+    #IF( #TEXT(Input_license_class)='' )
      '' 
    #ELSE
        IF( le.Input_license_class = (TYPEOF(le.Input_license_class))'','',':license_class')
    #END
 
+    #IF( #TEXT(Input_donor_flag)='' )
      '' 
    #ELSE
        IF( le.Input_donor_flag = (TYPEOF(le.Input_donor_flag))'','',':donor_flag')
    #END
 
+    #IF( #TEXT(Input_hair_color)='' )
      '' 
    #ELSE
        IF( le.Input_hair_color = (TYPEOF(le.Input_hair_color))'','',':hair_color')
    #END
 
+    #IF( #TEXT(Input_eye_color)='' )
      '' 
    #ELSE
        IF( le.Input_eye_color = (TYPEOF(le.Input_eye_color))'','',':eye_color')
    #END
 
+    #IF( #TEXT(Input_weight_l)='' )
      '' 
    #ELSE
        IF( le.Input_weight_l = (TYPEOF(le.Input_weight_l))'','',':weight_l')
    #END
 
+    #IF( #TEXT(Input_height_feet)='' )
      '' 
    #ELSE
        IF( le.Input_height_feet = (TYPEOF(le.Input_height_feet))'','',':height_feet')
    #END
 
+    #IF( #TEXT(Input_height_inches)='' )
      '' 
    #ELSE
        IF( le.Input_height_inches = (TYPEOF(le.Input_height_inches))'','',':height_inches')
    #END
 
+    #IF( #TEXT(Input_sex_gender)='' )
      '' 
    #ELSE
        IF( le.Input_sex_gender = (TYPEOF(le.Input_sex_gender))'','',':sex_gender')
    #END
 
+    #IF( #TEXT(Input_permanent_license_issue_date)='' )
      '' 
    #ELSE
        IF( le.Input_permanent_license_issue_date = (TYPEOF(le.Input_permanent_license_issue_date))'','',':permanent_license_issue_date')
    #END
 
+    #IF( #TEXT(Input_license_expiration_date)='' )
      '' 
    #ELSE
        IF( le.Input_license_expiration_date = (TYPEOF(le.Input_license_expiration_date))'','',':license_expiration_date')
    #END
 
+    #IF( #TEXT(Input_restriction_codes)='' )
      '' 
    #ELSE
        IF( le.Input_restriction_codes = (TYPEOF(le.Input_restriction_codes))'','',':restriction_codes')
    #END
 
+    #IF( #TEXT(Input_endorsement_codes)='' )
      '' 
    #ELSE
        IF( le.Input_endorsement_codes = (TYPEOF(le.Input_endorsement_codes))'','',':endorsement_codes')
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
 
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
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
 
+    #IF( #TEXT(Input_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_zip_code = (TYPEOF(le.Input_zip_code))'','',':zip_code')
    #END
 
+    #IF( #TEXT(Input_county_number)='' )
      '' 
    #ELSE
        IF( le.Input_county_number = (TYPEOF(le.Input_county_number))'','',':county_number')
    #END
 
+    #IF( #TEXT(Input_birth_date)='' )
      '' 
    #ELSE
        IF( le.Input_birth_date = (TYPEOF(le.Input_birth_date))'','',':birth_date')
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
