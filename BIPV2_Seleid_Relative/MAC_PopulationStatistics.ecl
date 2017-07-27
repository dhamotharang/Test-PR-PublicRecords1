EXPORT MAC_PopulationStatistics(infile,Ref='',Input_active_duns_number = '',Input_active_enterprise_number = '',Input_company_charter_number = '',Input_company_fein = '',Input_source_record_id = '',Input_contact_ssn = '',Input_contact_phone = '',Input_contact_email_username = '',Input_cnp_name = '',Input_lname = '',Input_prim_name = '',Input_prim_range = '',Input_sec_range = '',Input_v_city_name = '',Input_fname = '',Input_mname = '',Input_company_inc_state = '',Input_postdir = '',Input_st = '',Input_source = '',Input_unit_desig = '',Input_company_department = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_first_seen_contact = '',Input_dt_last_seen_contact = '',OutFile) := MACRO
  IMPORT SALT31,BIPV2_Seleid_Relative;
  #uniquename(of)
  %of% := RECORD
    SALT31.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_active_duns_number)='' )
      ''
    #ELSE
        IF( le.Input_active_duns_number = (TYPEOF(le.Input_active_duns_number))'','',':active_duns_number')
    #END
+    #IF( #TEXT(Input_active_enterprise_number)='' )
      ''
    #ELSE
        IF( le.Input_active_enterprise_number = (TYPEOF(le.Input_active_enterprise_number))'','',':active_enterprise_number')
    #END
+    #IF( #TEXT(Input_company_charter_number)='' )
      ''
    #ELSE
        IF( le.Input_company_charter_number = (TYPEOF(le.Input_company_charter_number))'','',':company_charter_number')
    #END
+    #IF( #TEXT(Input_company_fein)='' )
      ''
    #ELSE
        IF( le.Input_company_fein = (TYPEOF(le.Input_company_fein))'','',':company_fein')
    #END
+    #IF( #TEXT(Input_source_record_id)='' )
      ''
    #ELSE
        IF( le.Input_source_record_id = (TYPEOF(le.Input_source_record_id))'','',':source_record_id')
    #END
+    #IF( #TEXT(Input_contact_ssn)='' )
      ''
    #ELSE
        IF( le.Input_contact_ssn = (TYPEOF(le.Input_contact_ssn))'','',':contact_ssn')
    #END
+    #IF( #TEXT(Input_contact_phone)='' )
      ''
    #ELSE
        IF( le.Input_contact_phone = (TYPEOF(le.Input_contact_phone))'','',':contact_phone')
    #END
+    #IF( #TEXT(Input_contact_email_username)='' )
      ''
    #ELSE
        IF( le.Input_contact_email_username = (TYPEOF(le.Input_contact_email_username))'','',':contact_email_username')
    #END
+    #IF( #TEXT(Input_cnp_name)='' )
      ''
    #ELSE
        IF( le.Input_cnp_name = (TYPEOF(le.Input_cnp_name))'','',':cnp_name')
    #END
+    #IF( #TEXT(Input_lname)='' )
      ''
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
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
+    #IF( #TEXT(Input_sec_range)='' )
      ''
    #ELSE
        IF( le.Input_sec_range = (TYPEOF(le.Input_sec_range))'','',':sec_range')
    #END
+    #IF( #TEXT(Input_v_city_name)='' )
      ''
    #ELSE
        IF( le.Input_v_city_name = (TYPEOF(le.Input_v_city_name))'','',':v_city_name')
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
+    #IF( #TEXT(Input_company_inc_state)='' )
      ''
    #ELSE
        IF( le.Input_company_inc_state = (TYPEOF(le.Input_company_inc_state))'','',':company_inc_state')
    #END
+    #IF( #TEXT(Input_postdir)='' )
      ''
    #ELSE
        IF( le.Input_postdir = (TYPEOF(le.Input_postdir))'','',':postdir')
    #END
+    #IF( #TEXT(Input_st)='' )
      ''
    #ELSE
        IF( le.Input_st = (TYPEOF(le.Input_st))'','',':st')
    #END
+    #IF( #TEXT(Input_source)='' )
      ''
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
    #END
+    #IF( #TEXT(Input_unit_desig)='' )
      ''
    #ELSE
        IF( le.Input_unit_desig = (TYPEOF(le.Input_unit_desig))'','',':unit_desig')
    #END
+    #IF( #TEXT(Input_company_department)='' )
      ''
    #ELSE
        IF( le.Input_company_department = (TYPEOF(le.Input_company_department))'','',':company_department')
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
+    #IF( #TEXT(Input_dt_first_seen_contact)='' )
      ''
    #ELSE
        IF( le.Input_dt_first_seen_contact = (TYPEOF(le.Input_dt_first_seen_contact))'','',':dt_first_seen_contact')
    #END
+    #IF( #TEXT(Input_dt_last_seen_contact)='' )
      ''
    #ELSE
        IF( le.Input_dt_last_seen_contact = (TYPEOF(le.Input_dt_last_seen_contact))'','',':dt_last_seen_contact')
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