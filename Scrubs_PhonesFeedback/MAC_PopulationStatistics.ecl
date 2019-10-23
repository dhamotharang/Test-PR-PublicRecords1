 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_did = '',Input_did_score = '',Input_hhid = '',Input_phone_number = '',Input_login_history_id = '',Input_fname = '',Input_lname = '',Input_mname = '',Input_street_pre_direction = '',Input_street_post_direction = '',Input_street_number = '',Input_street_name = '',Input_street_suffix = '',Input_unit_number = '',Input_unit_designation = '',Input_zip5 = '',Input_zip4 = '',Input_city = '',Input_state = '',Input_alt_phone = '',Input_other_info = '',Input_phone_contact_type = '',Input_feedback_source = '',Input_date_time_added = '',Input_loginid = '',Input_customerid = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_PhonesFeedback;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_did_score)='' )
      '' 
    #ELSE
        IF( le.Input_did_score = (TYPEOF(le.Input_did_score))'','',':did_score')
    #END
 
+    #IF( #TEXT(Input_hhid)='' )
      '' 
    #ELSE
        IF( le.Input_hhid = (TYPEOF(le.Input_hhid))'','',':hhid')
    #END
 
+    #IF( #TEXT(Input_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_phone_number = (TYPEOF(le.Input_phone_number))'','',':phone_number')
    #END
 
+    #IF( #TEXT(Input_login_history_id)='' )
      '' 
    #ELSE
        IF( le.Input_login_history_id = (TYPEOF(le.Input_login_history_id))'','',':login_history_id')
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
 
+    #IF( #TEXT(Input_street_pre_direction)='' )
      '' 
    #ELSE
        IF( le.Input_street_pre_direction = (TYPEOF(le.Input_street_pre_direction))'','',':street_pre_direction')
    #END
 
+    #IF( #TEXT(Input_street_post_direction)='' )
      '' 
    #ELSE
        IF( le.Input_street_post_direction = (TYPEOF(le.Input_street_post_direction))'','',':street_post_direction')
    #END
 
+    #IF( #TEXT(Input_street_number)='' )
      '' 
    #ELSE
        IF( le.Input_street_number = (TYPEOF(le.Input_street_number))'','',':street_number')
    #END
 
+    #IF( #TEXT(Input_street_name)='' )
      '' 
    #ELSE
        IF( le.Input_street_name = (TYPEOF(le.Input_street_name))'','',':street_name')
    #END
 
+    #IF( #TEXT(Input_street_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_street_suffix = (TYPEOF(le.Input_street_suffix))'','',':street_suffix')
    #END
 
+    #IF( #TEXT(Input_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_unit_number = (TYPEOF(le.Input_unit_number))'','',':unit_number')
    #END
 
+    #IF( #TEXT(Input_unit_designation)='' )
      '' 
    #ELSE
        IF( le.Input_unit_designation = (TYPEOF(le.Input_unit_designation))'','',':unit_designation')
    #END
 
+    #IF( #TEXT(Input_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_zip5 = (TYPEOF(le.Input_zip5))'','',':zip5')
    #END
 
+    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
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
 
+    #IF( #TEXT(Input_phone_contact_type)='' )
      '' 
    #ELSE
        IF( le.Input_phone_contact_type = (TYPEOF(le.Input_phone_contact_type))'','',':phone_contact_type')
    #END
 
+    #IF( #TEXT(Input_feedback_source)='' )
      '' 
    #ELSE
        IF( le.Input_feedback_source = (TYPEOF(le.Input_feedback_source))'','',':feedback_source')
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
 
+    #IF( #TEXT(Input_customerid)='' )
      '' 
    #ELSE
        IF( le.Input_customerid = (TYPEOF(le.Input_customerid))'','',':customerid')
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
