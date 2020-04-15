 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_address_feedback_id = '',Input_login_history_id = '',Input_phone_number = '',Input_unique_id = '',Input_fname = '',Input_lname = '',Input_mname = '',Input_orig_street_pre_direction = '',Input_orig_street_post_direction = '',Input_orig_street_number = '',Input_orig_street_name = '',Input_orig_street_suffix = '',Input_orig_unit_number = '',Input_orig_unit_designation = '',Input_orig_zip5 = '',Input_orig_zip4 = '',Input_orig_city = '',Input_orig_state = '',Input_alt_phone = '',Input_other_info = '',Input_address_contact_type = '',Input_feedback_source = '',Input_transaction_id = '',Input_date_time_added = '',Input_loginid = '',Input_companyid = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_AddressFeedback;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_address_feedback_id)='' )
      '' 
    #ELSE
        IF( le.Input_address_feedback_id = (TYPEOF(le.Input_address_feedback_id))'','',':address_feedback_id')
    #END
 
+    #IF( #TEXT(Input_login_history_id)='' )
      '' 
    #ELSE
        IF( le.Input_login_history_id = (TYPEOF(le.Input_login_history_id))'','',':login_history_id')
    #END
 
+    #IF( #TEXT(Input_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_phone_number = (TYPEOF(le.Input_phone_number))'','',':phone_number')
    #END
 
+    #IF( #TEXT(Input_unique_id)='' )
      '' 
    #ELSE
        IF( le.Input_unique_id = (TYPEOF(le.Input_unique_id))'','',':unique_id')
    #END
 
+    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (TYPEOF(le.Input_fname))'','',':fname')
    #END
 
+    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
    #END
 
+    #IF( #TEXT(Input_mname)='' )
      '' 
    #ELSE
        IF( le.Input_mname = (TYPEOF(le.Input_mname))'','',':mname')
    #END
 
+    #IF( #TEXT(Input_orig_street_pre_direction)='' )
      '' 
    #ELSE
        IF( le.Input_orig_street_pre_direction = (TYPEOF(le.Input_orig_street_pre_direction))'','',':orig_street_pre_direction')
    #END
 
+    #IF( #TEXT(Input_orig_street_post_direction)='' )
      '' 
    #ELSE
        IF( le.Input_orig_street_post_direction = (TYPEOF(le.Input_orig_street_post_direction))'','',':orig_street_post_direction')
    #END
 
+    #IF( #TEXT(Input_orig_street_number)='' )
      '' 
    #ELSE
        IF( le.Input_orig_street_number = (TYPEOF(le.Input_orig_street_number))'','',':orig_street_number')
    #END
 
+    #IF( #TEXT(Input_orig_street_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_street_name = (TYPEOF(le.Input_orig_street_name))'','',':orig_street_name')
    #END
 
+    #IF( #TEXT(Input_orig_street_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_orig_street_suffix = (TYPEOF(le.Input_orig_street_suffix))'','',':orig_street_suffix')
    #END
 
+    #IF( #TEXT(Input_orig_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_orig_unit_number = (TYPEOF(le.Input_orig_unit_number))'','',':orig_unit_number')
    #END
 
+    #IF( #TEXT(Input_orig_unit_designation)='' )
      '' 
    #ELSE
        IF( le.Input_orig_unit_designation = (TYPEOF(le.Input_orig_unit_designation))'','',':orig_unit_designation')
    #END
 
+    #IF( #TEXT(Input_orig_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip5 = (TYPEOF(le.Input_orig_zip5))'','',':orig_zip5')
    #END
 
+    #IF( #TEXT(Input_orig_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip4 = (TYPEOF(le.Input_orig_zip4))'','',':orig_zip4')
    #END
 
+    #IF( #TEXT(Input_orig_city)='' )
      '' 
    #ELSE
        IF( le.Input_orig_city = (TYPEOF(le.Input_orig_city))'','',':orig_city')
    #END
 
+    #IF( #TEXT(Input_orig_state)='' )
      '' 
    #ELSE
        IF( le.Input_orig_state = (TYPEOF(le.Input_orig_state))'','',':orig_state')
    #END
 
+    #IF( #TEXT(Input_alt_phone)='' )
      '' 
    #ELSE
        IF( le.Input_alt_phone = (TYPEOF(le.Input_alt_phone))'','',':alt_phone')
    #END
 
+    #IF( #TEXT(Input_other_info)='' )
      '' 
    #ELSE
        IF( le.Input_other_info = (TYPEOF(le.Input_other_info))'','',':other_info')
    #END
 
+    #IF( #TEXT(Input_address_contact_type)='' )
      '' 
    #ELSE
        IF( le.Input_address_contact_type = (TYPEOF(le.Input_address_contact_type))'','',':address_contact_type')
    #END
 
+    #IF( #TEXT(Input_feedback_source)='' )
      '' 
    #ELSE
        IF( le.Input_feedback_source = (TYPEOF(le.Input_feedback_source))'','',':feedback_source')
    #END
 
+    #IF( #TEXT(Input_transaction_id)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_id = (TYPEOF(le.Input_transaction_id))'','',':transaction_id')
    #END
 
+    #IF( #TEXT(Input_date_time_added)='' )
      '' 
    #ELSE
        IF( le.Input_date_time_added = (TYPEOF(le.Input_date_time_added))'','',':date_time_added')
    #END
 
+    #IF( #TEXT(Input_loginid)='' )
      '' 
    #ELSE
        IF( le.Input_loginid = (TYPEOF(le.Input_loginid))'','',':loginid')
    #END
 
+    #IF( #TEXT(Input_companyid)='' )
      '' 
    #ELSE
        IF( le.Input_companyid = (TYPEOF(le.Input_companyid))'','',':companyid')
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
