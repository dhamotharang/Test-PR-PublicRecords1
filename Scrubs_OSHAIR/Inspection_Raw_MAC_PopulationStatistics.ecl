 
EXPORT Inspection_Raw_MAC_PopulationStatistics(infile,Ref='',Input_activity_nr = '',Input_reporting_id = '',Input_state_flag = '',Input_site_state = '',Input_site_zip = '',Input_owner_type = '',Input_owner_code = '',Input_adv_notice = '',Input_safety_hlth = '',Input_sic_code = '',Input_naics_code = '',Input_insp_type = '',Input_insp_scope = '',Input_why_no_insp = '',Input_union_status = '',Input_safety_manuf = '',Input_safety_const = '',Input_safety_marit = '',Input_health_manuf = '',Input_health_const = '',Input_health_marit = '',Input_migrant = '',Input_mail_state = '',Input_mail_zip = '',Input_host_est_key = '',Input_nr_in_estab = '',Input_open_date = '',Input_case_mod_date = '',Input_close_conf_date = '',Input_close_case_date = '',Input_open_year = '',Input_case_mod_year = '',Input_close_conf_year = '',Input_close_case_year = '',Input_estab_name = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_OSHAIR;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_activity_nr)='' )
      '' 
    #ELSE
        IF( le.Input_activity_nr = (TYPEOF(le.Input_activity_nr))'','',':activity_nr')
    #END
 
+    #IF( #TEXT(Input_reporting_id)='' )
      '' 
    #ELSE
        IF( le.Input_reporting_id = (TYPEOF(le.Input_reporting_id))'','',':reporting_id')
    #END
 
+    #IF( #TEXT(Input_state_flag)='' )
      '' 
    #ELSE
        IF( le.Input_state_flag = (TYPEOF(le.Input_state_flag))'','',':state_flag')
    #END
 
+    #IF( #TEXT(Input_site_state)='' )
      '' 
    #ELSE
        IF( le.Input_site_state = (TYPEOF(le.Input_site_state))'','',':site_state')
    #END
 
+    #IF( #TEXT(Input_site_zip)='' )
      '' 
    #ELSE
        IF( le.Input_site_zip = (TYPEOF(le.Input_site_zip))'','',':site_zip')
    #END
 
+    #IF( #TEXT(Input_owner_type)='' )
      '' 
    #ELSE
        IF( le.Input_owner_type = (TYPEOF(le.Input_owner_type))'','',':owner_type')
    #END
 
+    #IF( #TEXT(Input_owner_code)='' )
      '' 
    #ELSE
        IF( le.Input_owner_code = (TYPEOF(le.Input_owner_code))'','',':owner_code')
    #END
 
+    #IF( #TEXT(Input_adv_notice)='' )
      '' 
    #ELSE
        IF( le.Input_adv_notice = (TYPEOF(le.Input_adv_notice))'','',':adv_notice')
    #END
 
+    #IF( #TEXT(Input_safety_hlth)='' )
      '' 
    #ELSE
        IF( le.Input_safety_hlth = (TYPEOF(le.Input_safety_hlth))'','',':safety_hlth')
    #END
 
+    #IF( #TEXT(Input_sic_code)='' )
      '' 
    #ELSE
        IF( le.Input_sic_code = (TYPEOF(le.Input_sic_code))'','',':sic_code')
    #END
 
+    #IF( #TEXT(Input_naics_code)='' )
      '' 
    #ELSE
        IF( le.Input_naics_code = (TYPEOF(le.Input_naics_code))'','',':naics_code')
    #END
 
+    #IF( #TEXT(Input_insp_type)='' )
      '' 
    #ELSE
        IF( le.Input_insp_type = (TYPEOF(le.Input_insp_type))'','',':insp_type')
    #END
 
+    #IF( #TEXT(Input_insp_scope)='' )
      '' 
    #ELSE
        IF( le.Input_insp_scope = (TYPEOF(le.Input_insp_scope))'','',':insp_scope')
    #END
 
+    #IF( #TEXT(Input_why_no_insp)='' )
      '' 
    #ELSE
        IF( le.Input_why_no_insp = (TYPEOF(le.Input_why_no_insp))'','',':why_no_insp')
    #END
 
+    #IF( #TEXT(Input_union_status)='' )
      '' 
    #ELSE
        IF( le.Input_union_status = (TYPEOF(le.Input_union_status))'','',':union_status')
    #END
 
+    #IF( #TEXT(Input_safety_manuf)='' )
      '' 
    #ELSE
        IF( le.Input_safety_manuf = (TYPEOF(le.Input_safety_manuf))'','',':safety_manuf')
    #END
 
+    #IF( #TEXT(Input_safety_const)='' )
      '' 
    #ELSE
        IF( le.Input_safety_const = (TYPEOF(le.Input_safety_const))'','',':safety_const')
    #END
 
+    #IF( #TEXT(Input_safety_marit)='' )
      '' 
    #ELSE
        IF( le.Input_safety_marit = (TYPEOF(le.Input_safety_marit))'','',':safety_marit')
    #END
 
+    #IF( #TEXT(Input_health_manuf)='' )
      '' 
    #ELSE
        IF( le.Input_health_manuf = (TYPEOF(le.Input_health_manuf))'','',':health_manuf')
    #END
 
+    #IF( #TEXT(Input_health_const)='' )
      '' 
    #ELSE
        IF( le.Input_health_const = (TYPEOF(le.Input_health_const))'','',':health_const')
    #END
 
+    #IF( #TEXT(Input_health_marit)='' )
      '' 
    #ELSE
        IF( le.Input_health_marit = (TYPEOF(le.Input_health_marit))'','',':health_marit')
    #END
 
+    #IF( #TEXT(Input_migrant)='' )
      '' 
    #ELSE
        IF( le.Input_migrant = (TYPEOF(le.Input_migrant))'','',':migrant')
    #END
 
+    #IF( #TEXT(Input_mail_state)='' )
      '' 
    #ELSE
        IF( le.Input_mail_state = (TYPEOF(le.Input_mail_state))'','',':mail_state')
    #END
 
+    #IF( #TEXT(Input_mail_zip)='' )
      '' 
    #ELSE
        IF( le.Input_mail_zip = (TYPEOF(le.Input_mail_zip))'','',':mail_zip')
    #END
 
+    #IF( #TEXT(Input_host_est_key)='' )
      '' 
    #ELSE
        IF( le.Input_host_est_key = (TYPEOF(le.Input_host_est_key))'','',':host_est_key')
    #END
 
+    #IF( #TEXT(Input_nr_in_estab)='' )
      '' 
    #ELSE
        IF( le.Input_nr_in_estab = (TYPEOF(le.Input_nr_in_estab))'','',':nr_in_estab')
    #END
 
+    #IF( #TEXT(Input_open_date)='' )
      '' 
    #ELSE
        IF( le.Input_open_date = (TYPEOF(le.Input_open_date))'','',':open_date')
    #END
 
+    #IF( #TEXT(Input_case_mod_date)='' )
      '' 
    #ELSE
        IF( le.Input_case_mod_date = (TYPEOF(le.Input_case_mod_date))'','',':case_mod_date')
    #END
 
+    #IF( #TEXT(Input_close_conf_date)='' )
      '' 
    #ELSE
        IF( le.Input_close_conf_date = (TYPEOF(le.Input_close_conf_date))'','',':close_conf_date')
    #END
 
+    #IF( #TEXT(Input_close_case_date)='' )
      '' 
    #ELSE
        IF( le.Input_close_case_date = (TYPEOF(le.Input_close_case_date))'','',':close_case_date')
    #END
 
+    #IF( #TEXT(Input_open_year)='' )
      '' 
    #ELSE
        IF( le.Input_open_year = (TYPEOF(le.Input_open_year))'','',':open_year')
    #END
 
+    #IF( #TEXT(Input_case_mod_year)='' )
      '' 
    #ELSE
        IF( le.Input_case_mod_year = (TYPEOF(le.Input_case_mod_year))'','',':case_mod_year')
    #END
 
+    #IF( #TEXT(Input_close_conf_year)='' )
      '' 
    #ELSE
        IF( le.Input_close_conf_year = (TYPEOF(le.Input_close_conf_year))'','',':close_conf_year')
    #END
 
+    #IF( #TEXT(Input_close_case_year)='' )
      '' 
    #ELSE
        IF( le.Input_close_case_year = (TYPEOF(le.Input_close_case_year))'','',':close_case_year')
    #END
 
+    #IF( #TEXT(Input_estab_name)='' )
      '' 
    #ELSE
        IF( le.Input_estab_name = (TYPEOF(le.Input_estab_name))'','',':estab_name')
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
