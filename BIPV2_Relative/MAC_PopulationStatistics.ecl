EXPORT MAC_PopulationStatistics(infile,Ref='',Input_cnp_hasnumber = '',Input_active_enterprise_number = '',Input_source_record_id = '',Input_contact_ssn = '',Input_company_fein = '',Input_company_charter_number = '',Input_active_duns_number = '',Input_active_domestic_corp_key = '',Input_contact_phone = '',Input_cnp_name = '',Input_corp_legal_name = '',Input_company_address = '',Input_company_addr1 = '',Input_company_csz = '',Input_prim_name = '',Input_lname = '',Input_zip = '',Input_prim_range = '',Input_zip4 = '',Input_sec_range = '',Input_cnp_number = '',Input_p_city_name = '',Input_v_city_name = '',Input_fname = '',Input_company_inc_state = '',Input_mname = '',Input_postdir = '',Input_st = '',Input_predir = '',Input_addr_suffix = '',Input_cnp_btype = '',Input_source = '',Input_iscorp = '',Input_company_name = '',Input_cnp_lowv = '',Input_cnp_translated = '',Input_cnp_classid = '',Input_company_bdid = '',Input_company_phone = '',Input_unit_desig = '',Input_Company_RAWAID = '',Input_isContact = '',Input_title = '',Input_name_suffix = '',Input_contact_email = '',Input_contact_job_title_raw = '',Input_company_department = '',Input_contact_email_username = '',Input_dt_first_seen = '',Input_dt_last_seen = '',OutFile) := MACRO
  IMPORT SALT25,BIPV2_Relative;
  #uniquename(of)
  %of% := RECORD
    SALT25.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_cnp_hasnumber)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_hasnumber = (TYPEOF(le.Input_cnp_hasnumber))'','',':cnp_hasnumber')
    #END
+
    #IF( #TEXT(Input_active_enterprise_number)='' )
      '' 
    #ELSE
        IF( le.Input_active_enterprise_number = (TYPEOF(le.Input_active_enterprise_number))'','',':active_enterprise_number')
    #END
+
    #IF( #TEXT(Input_source_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_record_id = (TYPEOF(le.Input_source_record_id))'','',':source_record_id')
    #END
+
    #IF( #TEXT(Input_contact_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_contact_ssn = (TYPEOF(le.Input_contact_ssn))'','',':contact_ssn')
    #END
+
    #IF( #TEXT(Input_company_fein)='' )
      '' 
    #ELSE
        IF( le.Input_company_fein = (TYPEOF(le.Input_company_fein))'','',':company_fein')
    #END
+
    #IF( #TEXT(Input_company_charter_number)='' )
      '' 
    #ELSE
        IF( le.Input_company_charter_number = (TYPEOF(le.Input_company_charter_number))'','',':company_charter_number')
    #END
+
    #IF( #TEXT(Input_active_duns_number)='' )
      '' 
    #ELSE
        IF( le.Input_active_duns_number = (TYPEOF(le.Input_active_duns_number))'','',':active_duns_number')
    #END
+
    #IF( #TEXT(Input_active_domestic_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_active_domestic_corp_key = (TYPEOF(le.Input_active_domestic_corp_key))'','',':active_domestic_corp_key')
    #END
+
    #IF( #TEXT(Input_contact_phone)='' )
      '' 
    #ELSE
        IF( le.Input_contact_phone = (TYPEOF(le.Input_contact_phone))'','',':contact_phone')
    #END
+
    #IF( #TEXT(Input_cnp_name)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_name = (TYPEOF(le.Input_cnp_name))'','',':cnp_name')
    #END
+
    #IF( #TEXT(Input_corp_legal_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_legal_name = (TYPEOF(le.Input_corp_legal_name))'','',':corp_legal_name')
    #END
+
    #IF( #TEXT(Input_company_address)='' )
      '' 
    #ELSE
        IF( le.Input_company_address = (TYPEOF(le.Input_company_address))'','',':company_address')
    #END
+
    #IF( #TEXT(Input_company_addr1)='' )
      '' 
    #ELSE
        IF( le.Input_company_addr1 = (TYPEOF(le.Input_company_addr1))'','',':company_addr1')
    #END
+
    #IF( #TEXT(Input_company_csz)='' )
      '' 
    #ELSE
        IF( le.Input_company_csz = (TYPEOF(le.Input_company_csz))'','',':company_csz')
    #END
+
    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (TYPEOF(le.Input_prim_name))'','',':prim_name')
    #END
+
    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
    #END
+
    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
+
    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
    #END
+
    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
+
    #IF( #TEXT(Input_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range = (TYPEOF(le.Input_sec_range))'','',':sec_range')
    #END
+
    #IF( #TEXT(Input_cnp_number)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_number = (TYPEOF(le.Input_cnp_number))'','',':cnp_number')
    #END
+
    #IF( #TEXT(Input_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_p_city_name = (TYPEOF(le.Input_p_city_name))'','',':p_city_name')
    #END
+
    #IF( #TEXT(Input_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_v_city_name = (TYPEOF(le.Input_v_city_name))'','',':v_city_name')
    #END
+
    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (TYPEOF(le.Input_fname))'','',':fname')
    #END
+
    #IF( #TEXT(Input_company_inc_state)='' )
      '' 
    #ELSE
        IF( le.Input_company_inc_state = (TYPEOF(le.Input_company_inc_state))'','',':company_inc_state')
    #END
+
    #IF( #TEXT(Input_mname)='' )
      '' 
    #ELSE
        IF( le.Input_mname = (TYPEOF(le.Input_mname))'','',':mname')
    #END
+
    #IF( #TEXT(Input_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_postdir = (TYPEOF(le.Input_postdir))'','',':postdir')
    #END
+
    #IF( #TEXT(Input_st)='' )
      '' 
    #ELSE
        IF( le.Input_st = (TYPEOF(le.Input_st))'','',':st')
    #END
+
    #IF( #TEXT(Input_predir)='' )
      '' 
    #ELSE
        IF( le.Input_predir = (TYPEOF(le.Input_predir))'','',':predir')
    #END
+
    #IF( #TEXT(Input_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_addr_suffix = (TYPEOF(le.Input_addr_suffix))'','',':addr_suffix')
    #END
+
    #IF( #TEXT(Input_cnp_btype)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_btype = (TYPEOF(le.Input_cnp_btype))'','',':cnp_btype')
    #END
+
    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
    #END
+
    #IF( #TEXT(Input_iscorp)='' )
      '' 
    #ELSE
        IF( le.Input_iscorp = (TYPEOF(le.Input_iscorp))'','',':iscorp')
    #END
+
    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (TYPEOF(le.Input_company_name))'','',':company_name')
    #END
+
    #IF( #TEXT(Input_cnp_lowv)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_lowv = (TYPEOF(le.Input_cnp_lowv))'','',':cnp_lowv')
    #END
+
    #IF( #TEXT(Input_cnp_translated)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_translated = (TYPEOF(le.Input_cnp_translated))'','',':cnp_translated')
    #END
+
    #IF( #TEXT(Input_cnp_classid)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_classid = (TYPEOF(le.Input_cnp_classid))'','',':cnp_classid')
    #END
+
    #IF( #TEXT(Input_company_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_company_bdid = (TYPEOF(le.Input_company_bdid))'','',':company_bdid')
    #END
+
    #IF( #TEXT(Input_company_phone)='' )
      '' 
    #ELSE
        IF( le.Input_company_phone = (TYPEOF(le.Input_company_phone))'','',':company_phone')
    #END
+
    #IF( #TEXT(Input_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_unit_desig = (TYPEOF(le.Input_unit_desig))'','',':unit_desig')
    #END
+
    #IF( #TEXT(Input_Company_RAWAID)='' )
      '' 
    #ELSE
        IF( le.Input_Company_RAWAID = (TYPEOF(le.Input_Company_RAWAID))'','',':Company_RAWAID')
    #END
+
    #IF( #TEXT(Input_isContact)='' )
      '' 
    #ELSE
        IF( le.Input_isContact = (TYPEOF(le.Input_isContact))'','',':isContact')
    #END
+
    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (TYPEOF(le.Input_title))'','',':title')
    #END
+
    #IF( #TEXT(Input_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix = (TYPEOF(le.Input_name_suffix))'','',':name_suffix')
    #END
+
    #IF( #TEXT(Input_contact_email)='' )
      '' 
    #ELSE
        IF( le.Input_contact_email = (TYPEOF(le.Input_contact_email))'','',':contact_email')
    #END
+
    #IF( #TEXT(Input_contact_job_title_raw)='' )
      '' 
    #ELSE
        IF( le.Input_contact_job_title_raw = (TYPEOF(le.Input_contact_job_title_raw))'','',':contact_job_title_raw')
    #END
+
    #IF( #TEXT(Input_company_department)='' )
      '' 
    #ELSE
        IF( le.Input_company_department = (TYPEOF(le.Input_company_department))'','',':company_department')
    #END
+
    #IF( #TEXT(Input_contact_email_username)='' )
      '' 
    #ELSE
        IF( le.Input_contact_email_username = (TYPEOF(le.Input_contact_email_username))'','',':contact_email_username')
    #END
+
    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
+
    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
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
