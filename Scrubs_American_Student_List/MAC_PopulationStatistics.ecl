 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_name = '',Input_first_name = '',Input_last_name = '',Input_address_1 = '',Input_address_2 = '',Input_city = '',Input_state = '',Input_z5 = '',Input_zip_4 = '',Input_crrt_code = '',Input_delivery_point_barcode = '',Input_zip4_check_digit = '',Input_address_type = '',Input_county_number = '',Input_county_name = '',Input_gender = '',Input_age = '',Input_birth_date = '',Input_telephone = '',Input_class = '',Input_college_class = '',Input_college_name = '',Input_college_major = '',Input_college_code = '',Input_college_type = '',Input_head_of_household_first_name = '',Input_head_of_household_gender = '',Input_income_level = '',Input_file_type = '',OutFile) := MACRO
  IMPORT SALT36,Scrubs_American_Student_List;
  #uniquename(of)
  %of% := RECORD
    SALT36.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_name)='' )
      '' 
    #ELSE
        IF( le.Input_name = (TYPEOF(le.Input_name))'','',':name')
    #END
 
+    #IF( #TEXT(Input_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_name = (TYPEOF(le.Input_first_name))'','',':first_name')
    #END
 
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
    #END
 
+    #IF( #TEXT(Input_address_1)='' )
      '' 
    #ELSE
        IF( le.Input_address_1 = (TYPEOF(le.Input_address_1))'','',':address_1')
    #END
 
+    #IF( #TEXT(Input_address_2)='' )
      '' 
    #ELSE
        IF( le.Input_address_2 = (TYPEOF(le.Input_address_2))'','',':address_2')
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
 
+    #IF( #TEXT(Input_z5)='' )
      '' 
    #ELSE
        IF( le.Input_z5 = (TYPEOF(le.Input_z5))'','',':z5')
    #END
 
+    #IF( #TEXT(Input_zip_4)='' )
      '' 
    #ELSE
        IF( le.Input_zip_4 = (TYPEOF(le.Input_zip_4))'','',':zip_4')
    #END
 
+    #IF( #TEXT(Input_crrt_code)='' )
      '' 
    #ELSE
        IF( le.Input_crrt_code = (TYPEOF(le.Input_crrt_code))'','',':crrt_code')
    #END
 
+    #IF( #TEXT(Input_delivery_point_barcode)='' )
      '' 
    #ELSE
        IF( le.Input_delivery_point_barcode = (TYPEOF(le.Input_delivery_point_barcode))'','',':delivery_point_barcode')
    #END
 
+    #IF( #TEXT(Input_zip4_check_digit)='' )
      '' 
    #ELSE
        IF( le.Input_zip4_check_digit = (TYPEOF(le.Input_zip4_check_digit))'','',':zip4_check_digit')
    #END
 
+    #IF( #TEXT(Input_address_type)='' )
      '' 
    #ELSE
        IF( le.Input_address_type = (TYPEOF(le.Input_address_type))'','',':address_type')
    #END
 
+    #IF( #TEXT(Input_county_number)='' )
      '' 
    #ELSE
        IF( le.Input_county_number = (TYPEOF(le.Input_county_number))'','',':county_number')
    #END
 
+    #IF( #TEXT(Input_county_name)='' )
      '' 
    #ELSE
        IF( le.Input_county_name = (TYPEOF(le.Input_county_name))'','',':county_name')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_age)='' )
      '' 
    #ELSE
        IF( le.Input_age = (TYPEOF(le.Input_age))'','',':age')
    #END
 
+    #IF( #TEXT(Input_birth_date)='' )
      '' 
    #ELSE
        IF( le.Input_birth_date = (TYPEOF(le.Input_birth_date))'','',':birth_date')
    #END
 
+    #IF( #TEXT(Input_telephone)='' )
      '' 
    #ELSE
        IF( le.Input_telephone = (TYPEOF(le.Input_telephone))'','',':telephone')
    #END
 
+    #IF( #TEXT(Input_class)='' )
      '' 
    #ELSE
        IF( le.Input_class = (TYPEOF(le.Input_class))'','',':class')
    #END
 
+    #IF( #TEXT(Input_college_class)='' )
      '' 
    #ELSE
        IF( le.Input_college_class = (TYPEOF(le.Input_college_class))'','',':college_class')
    #END
 
+    #IF( #TEXT(Input_college_name)='' )
      '' 
    #ELSE
        IF( le.Input_college_name = (TYPEOF(le.Input_college_name))'','',':college_name')
    #END
 
+    #IF( #TEXT(Input_college_major)='' )
      '' 
    #ELSE
        IF( le.Input_college_major = (TYPEOF(le.Input_college_major))'','',':college_major')
    #END
 
+    #IF( #TEXT(Input_college_code)='' )
      '' 
    #ELSE
        IF( le.Input_college_code = (TYPEOF(le.Input_college_code))'','',':college_code')
    #END
 
+    #IF( #TEXT(Input_college_type)='' )
      '' 
    #ELSE
        IF( le.Input_college_type = (TYPEOF(le.Input_college_type))'','',':college_type')
    #END
 
+    #IF( #TEXT(Input_head_of_household_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_head_of_household_first_name = (TYPEOF(le.Input_head_of_household_first_name))'','',':head_of_household_first_name')
    #END
 
+    #IF( #TEXT(Input_head_of_household_gender)='' )
      '' 
    #ELSE
        IF( le.Input_head_of_household_gender = (TYPEOF(le.Input_head_of_household_gender))'','',':head_of_household_gender')
    #END
 
+    #IF( #TEXT(Input_income_level)='' )
      '' 
    #ELSE
        IF( le.Input_income_level = (TYPEOF(le.Input_income_level))'','',':income_level')
    #END
 
+    #IF( #TEXT(Input_file_type)='' )
      '' 
    #ELSE
        IF( le.Input_file_type = (TYPEOF(le.Input_file_type))'','',':file_type')
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
