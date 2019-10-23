 
EXPORT PCR_PII_MAC_PopulationStatistics(infile,Ref='',Input_uid = '',Input_date_created = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_did = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_ssn = '',Input_dob = '',Input_predir = '',Input_prim_name = '',Input_prim_range = '',Input_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_zip4 = '',Input_address = '',Input_city_name = '',Input_st = '',Input_zip = '',Input_phone = '',Input_dl_number = '',Input_dl_state = '',Input_dispute_flag = '',Input_security_freeze = '',Input_security_freeze_pin = '',Input_security_alert = '',Input_negative_alert = '',Input_id_theft_flag = '',Input_insuff_inqry_data = '',Input_consumer_statement_flag = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Overrides;
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
 
+    #IF( #TEXT(Input_date_created)='' )
      '' 
    #ELSE
        IF( le.Input_date_created = (TYPEOF(le.Input_date_created))'','',':date_created')
    #END
 
+    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
 
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
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
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_predir)='' )
      '' 
    #ELSE
        IF( le.Input_predir = (TYPEOF(le.Input_predir))'','',':predir')
    #END
 
+    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (TYPEOF(le.Input_prim_name))'','',':prim_name')
    #END
 
+    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
    #END
 
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
 
+    #IF( #TEXT(Input_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_postdir = (TYPEOF(le.Input_postdir))'','',':postdir')
    #END
 
+    #IF( #TEXT(Input_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_unit_desig = (TYPEOF(le.Input_unit_desig))'','',':unit_desig')
    #END
 
+    #IF( #TEXT(Input_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range = (TYPEOF(le.Input_sec_range))'','',':sec_range')
    #END
 
+    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
 
+    #IF( #TEXT(Input_address)='' )
      '' 
    #ELSE
        IF( le.Input_address = (TYPEOF(le.Input_address))'','',':address')
    #END
 
+    #IF( #TEXT(Input_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_city_name = (TYPEOF(le.Input_city_name))'','',':city_name')
    #END
 
+    #IF( #TEXT(Input_st)='' )
      '' 
    #ELSE
        IF( le.Input_st = (TYPEOF(le.Input_st))'','',':st')
    #END
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_dl_number)='' )
      '' 
    #ELSE
        IF( le.Input_dl_number = (TYPEOF(le.Input_dl_number))'','',':dl_number')
    #END
 
+    #IF( #TEXT(Input_dl_state)='' )
      '' 
    #ELSE
        IF( le.Input_dl_state = (TYPEOF(le.Input_dl_state))'','',':dl_state')
    #END
 
+    #IF( #TEXT(Input_dispute_flag)='' )
      '' 
    #ELSE
        IF( le.Input_dispute_flag = (TYPEOF(le.Input_dispute_flag))'','',':dispute_flag')
    #END
 
+    #IF( #TEXT(Input_security_freeze)='' )
      '' 
    #ELSE
        IF( le.Input_security_freeze = (TYPEOF(le.Input_security_freeze))'','',':security_freeze')
    #END
 
+    #IF( #TEXT(Input_security_freeze_pin)='' )
      '' 
    #ELSE
        IF( le.Input_security_freeze_pin = (TYPEOF(le.Input_security_freeze_pin))'','',':security_freeze_pin')
    #END
 
+    #IF( #TEXT(Input_security_alert)='' )
      '' 
    #ELSE
        IF( le.Input_security_alert = (TYPEOF(le.Input_security_alert))'','',':security_alert')
    #END
 
+    #IF( #TEXT(Input_negative_alert)='' )
      '' 
    #ELSE
        IF( le.Input_negative_alert = (TYPEOF(le.Input_negative_alert))'','',':negative_alert')
    #END
 
+    #IF( #TEXT(Input_id_theft_flag)='' )
      '' 
    #ELSE
        IF( le.Input_id_theft_flag = (TYPEOF(le.Input_id_theft_flag))'','',':id_theft_flag')
    #END
 
+    #IF( #TEXT(Input_insuff_inqry_data)='' )
      '' 
    #ELSE
        IF( le.Input_insuff_inqry_data = (TYPEOF(le.Input_insuff_inqry_data))'','',':insuff_inqry_data')
    #END
 
+    #IF( #TEXT(Input_consumer_statement_flag)='' )
      '' 
    #ELSE
        IF( le.Input_consumer_statement_flag = (TYPEOF(le.Input_consumer_statement_flag))'','',':consumer_statement_flag')
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
