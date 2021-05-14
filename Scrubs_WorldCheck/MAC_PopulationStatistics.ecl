 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_uid = '',Input_key = '',Input_name_orig = '',Input_name_type = '',Input_last_name = '',Input_first_name = '',Input_category = '',Input_title = '',Input_sub_category = '',Input_position = '',Input_age = '',Input_date_of_birth = '',Input_places_of_birth = '',Input_date_of_death = '',Input_passports = '',Input_social_security_number = '',Input_location = '',Input_countries = '',Input_e_i_ind = '',Input_keywords = '',Input_entered = '',Input_updated = '',Input_editor = '',Input_age_as_of_date = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_WorldCheck;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_uid)='' )
      '' 
    #ELSE
        IF( le.Input_uid = (TYPEOF(le.Input_uid))'','',':uid')
    #END
 
+    #IF( #TEXT(Input_key)='' )
      '' 
    #ELSE
        IF( le.Input_key = (TYPEOF(le.Input_key))'','',':key')
    #END
 
+    #IF( #TEXT(Input_name_orig)='' )
      '' 
    #ELSE
        IF( le.Input_name_orig = (TYPEOF(le.Input_name_orig))'','',':name_orig')
    #END
 
+    #IF( #TEXT(Input_name_type)='' )
      '' 
    #ELSE
        IF( le.Input_name_type = (TYPEOF(le.Input_name_type))'','',':name_type')
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
 
+    #IF( #TEXT(Input_category)='' )
      '' 
    #ELSE
        IF( le.Input_category = (TYPEOF(le.Input_category))'','',':category')
    #END
 
+    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (TYPEOF(le.Input_title))'','',':title')
    #END
 
+    #IF( #TEXT(Input_sub_category)='' )
      '' 
    #ELSE
        IF( le.Input_sub_category = (TYPEOF(le.Input_sub_category))'','',':sub_category')
    #END
 
+    #IF( #TEXT(Input_position)='' )
      '' 
    #ELSE
        IF( le.Input_position = (TYPEOF(le.Input_position))'','',':position')
    #END
 
+    #IF( #TEXT(Input_age)='' )
      '' 
    #ELSE
        IF( le.Input_age = (TYPEOF(le.Input_age))'','',':age')
    #END
 
+    #IF( #TEXT(Input_date_of_birth)='' )
      '' 
    #ELSE
        IF( le.Input_date_of_birth = (TYPEOF(le.Input_date_of_birth))'','',':date_of_birth')
    #END
 
+    #IF( #TEXT(Input_places_of_birth)='' )
      '' 
    #ELSE
        IF( le.Input_places_of_birth = (TYPEOF(le.Input_places_of_birth))'','',':places_of_birth')
    #END
 
+    #IF( #TEXT(Input_date_of_death)='' )
      '' 
    #ELSE
        IF( le.Input_date_of_death = (TYPEOF(le.Input_date_of_death))'','',':date_of_death')
    #END
 
+    #IF( #TEXT(Input_passports)='' )
      '' 
    #ELSE
        IF( le.Input_passports = (TYPEOF(le.Input_passports))'','',':passports')
    #END
 
+    #IF( #TEXT(Input_social_security_number)='' )
      '' 
    #ELSE
        IF( le.Input_social_security_number = (TYPEOF(le.Input_social_security_number))'','',':social_security_number')
    #END
 
+    #IF( #TEXT(Input_location)='' )
      '' 
    #ELSE
        IF( le.Input_location = (TYPEOF(le.Input_location))'','',':location')
    #END
 
+    #IF( #TEXT(Input_countries)='' )
      '' 
    #ELSE
        IF( le.Input_countries = (TYPEOF(le.Input_countries))'','',':countries')
    #END
 
+    #IF( #TEXT(Input_e_i_ind)='' )
      '' 
    #ELSE
        IF( le.Input_e_i_ind = (TYPEOF(le.Input_e_i_ind))'','',':e_i_ind')
    #END
 
+    #IF( #TEXT(Input_keywords)='' )
      '' 
    #ELSE
        IF( le.Input_keywords = (TYPEOF(le.Input_keywords))'','',':keywords')
    #END
 
+    #IF( #TEXT(Input_entered)='' )
      '' 
    #ELSE
        IF( le.Input_entered = (TYPEOF(le.Input_entered))'','',':entered')
    #END
 
+    #IF( #TEXT(Input_updated)='' )
      '' 
    #ELSE
        IF( le.Input_updated = (TYPEOF(le.Input_updated))'','',':updated')
    #END
 
+    #IF( #TEXT(Input_editor)='' )
      '' 
    #ELSE
        IF( le.Input_editor = (TYPEOF(le.Input_editor))'','',':editor')
    #END
 
+    #IF( #TEXT(Input_age_as_of_date)='' )
      '' 
    #ELSE
        IF( le.Input_age_as_of_date = (TYPEOF(le.Input_age_as_of_date))'','',':age_as_of_date')
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
