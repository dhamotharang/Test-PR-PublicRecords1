EXPORT MAC_PopulationStatistics(infile,Ref='',std_source_upd='',Input_primary_key = '',Input_create_dte = '',Input_last_upd_dte = '',Input_stamp_dte = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_date_vendor_first_reported = '',Input_date_vendor_last_reported = '',Input_process_date = '',Input_gen_nbr = '',Input_std_prof_cd = '',Input_std_prof_desc = '',Input_std_source_upd = '',Input_std_source_desc = '',Input_type_cd = '',Input_name_org_prefx = '',Input_name_org = '',Input_name_org_sufx = '',Input_store_nbr = '',Input_name_dba_prefx = '',Input_name_dba = '',Input_name_dba_sufx = '',Input_store_nbr_dba = '',Input_dba_flag = '',Input_name_office = '',Input_office_parse = '',Input_name_prefx = '',Input_name_first = '',Input_name_mid = '',Input_name_last = '',Input_name_sufx = '',Input_name_nick = '',Input_birth_dte = '',Input_gender = '',Input_prov_stat = '',Input_credential = '',Input_license_nbr = '',Input_off_license_nbr = '',Input_prev_license_nbr = '',Input_prev_license_type = '',Input_license_state = '',Input_raw_license_type = '',Input_std_license_type = '',Input_std_license_desc = '',Input_raw_license_status = '',Input_std_license_status = '',Input_std_status_desc = '',Input_curr_issue_dte = '',Input_orig_issue_dte = '',Input_expire_dte = '',Input_renewal_dte = '',Input_active_flag = '',Input_ssn_taxid_1 = '',Input_tax_type_1 = '',Input_ssn_taxid_2 = '',Input_tax_type_2 = '',Input_fed_rssd = '',Input_addr_bus_ind = '',Input_name_format = '',Input_name_org_orig = '',Input_name_dba_orig = '',Input_name_mari_org = '',Input_name_mari_dba = '',Input_phn_mari_1 = '',Input_phn_mari_fax_1 = '',Input_phn_mari_2 = '',Input_phn_mari_fax_2 = '',Input_addr_addr1_1 = '',Input_addr_addr2_1 = '',Input_addr_addr3_1 = '',Input_addr_addr4_1 = '',Input_addr_city_1 = '',Input_addr_state_1 = '',Input_addr_zip5_1 = '',Input_addr_zip4_1 = '',Input_phn_phone_1 = '',Input_phn_fax_1 = '',Input_addr_cnty_1 = '',Input_addr_cntry_1 = '',Input_sud_key_1 = '',Input_ooc_ind_1 = '',Input_addr_mail_ind = '',Input_addr_addr1_2 = '',Input_addr_addr2_2 = '',Input_addr_addr3_2 = '',Input_addr_addr4_2 = '',Input_addr_city_2 = '',Input_addr_state_2 = '',Input_addr_zip5_2 = '',Input_addr_zip4_2 = '',Input_addr_cnty_2 = '',Input_addr_cntry_2 = '',Input_phn_phone_2 = '',Input_phn_fax_2 = '',Input_sud_key_2 = '',Input_ooc_ind_2 = '',Input_license_nbr_contact = '',Input_name_contact_prefx = '',Input_name_contact_first = '',Input_name_contact_mid = '',Input_name_contact_last = '',Input_name_contact_sufx = '',Input_name_contact_nick = '',Input_name_contact_ttl = '',Input_phn_contact = '',Input_phn_contact_ext = '',Input_phn_contact_fax = '',Input_email = '',Input_url = '',Input_bk_class = '',Input_bk_class_desc = '',Input_charter = '',Input_inst_beg_dte = '',Input_origin_cd = '',Input_origin_cd_desc = '',Input_disp_type_cd = '',Input_disp_type_desc = '',Input_reg_agent = '',Input_regulator = '',Input_hqtr_city = '',Input_hqtr_name = '',Input_domestic_off_nbr = '',Input_foreign_off_nbr = '',Input_hcr_rssd = '',Input_hcr_location = '',Input_affil_type_cd = '',Input_genlink = '',Input_research_ind = '',Input_docket_id = '',Input_mltreckey = '',Input_cmc_slpk = '',Input_pcmc_slpk = '',Input_affil_key = '',Input_provnote_1 = '',Input_provnote_2 = '',Input_provnote_3 = '',Input_action_taken_ind = '',Input_viol_type = '',Input_viol_cd = '',Input_viol_desc = '',Input_viol_dte = '',Input_viol_case_nbr = '',Input_viol_eff_dte = '',Input_action_final_nbr = '',Input_action_status = '',Input_action_status_dte = '',Input_displinary_action = '',Input_action_file_name = '',Input_occupation = '',Input_practice_hrs = '',Input_practice_type = '',Input_misc_other_id = '',Input_misc_other_type = '',Input_cont_education_ernd = '',Input_cont_education_req = '',Input_cont_education_term = '',Input_schl_attend_1 = '',Input_schl_attend_dte_1 = '',Input_schl_curriculum_1 = '',Input_schl_degree_1 = '',Input_schl_attend_2 = '',Input_schl_attend_dte_2 = '',Input_schl_curriculum_2 = '',Input_schl_degree_2 = '',Input_schl_attend_3 = '',Input_schl_attend_dte_3 = '',Input_schl_curriculum_3 = '',Input_schl_degree_3 = '',Input_addl_license_spec = '',Input_place_birth_cd = '',Input_place_birth_desc = '',Input_race_cd = '',Input_std_race_cd = '',Input_race_desc = '',Input_status_effect_dte = '',Input_status_renew_desc = '',Input_agency_status = '',Input_prev_primary_key = '',Input_prev_mltreckey = '',Input_prev_cmc_slpk = '',Input_prev_pcmc_slpk = '',Input_license_id = '',Input_nmls_id = '',Input_foreign_nmls_id = '',Input_location_type = '',Input_off_license_nbr_type = '',Input_brkr_license_nbr = '',Input_brkr_license_nbr_type = '',Input_agency_id = '',Input_site_location = '',Input_business_type = '',Input_name_type = '',Input_start_dte = '',Input_is_authorized_license = '',Input_is_authorized_conduct = '',Input_federal_regulator = '',OutFile) := MACRO
  IMPORT SALT31,Scrubs_Prof_License_Mari;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(std_source_upd)<>'')
    SALT31.StrType source;
    #END
    SALT31.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_primary_key)='' )
      '' 
    #ELSE
        IF( le.Input_primary_key = (TYPEOF(le.Input_primary_key))'','',':primary_key')
    #END
+    #IF( #TEXT(Input_create_dte)='' )
      '' 
    #ELSE
        IF( le.Input_create_dte = (TYPEOF(le.Input_create_dte))'','',':create_dte')
    #END
+    #IF( #TEXT(Input_last_upd_dte)='' )
      '' 
    #ELSE
        IF( le.Input_last_upd_dte = (TYPEOF(le.Input_last_upd_dte))'','',':last_upd_dte')
    #END
+    #IF( #TEXT(Input_stamp_dte)='' )
      '' 
    #ELSE
        IF( le.Input_stamp_dte = (TYPEOF(le.Input_stamp_dte))'','',':stamp_dte')
    #END
+    #IF( #TEXT(Input_date_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_first_seen = (TYPEOF(le.Input_date_first_seen))'','',':date_first_seen')
    #END
+    #IF( #TEXT(Input_date_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_last_seen = (TYPEOF(le.Input_date_last_seen))'','',':date_last_seen')
    #END
+    #IF( #TEXT(Input_date_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_date_vendor_first_reported = (TYPEOF(le.Input_date_vendor_first_reported))'','',':date_vendor_first_reported')
    #END
+    #IF( #TEXT(Input_date_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_date_vendor_last_reported = (TYPEOF(le.Input_date_vendor_last_reported))'','',':date_vendor_last_reported')
    #END
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
+    #IF( #TEXT(Input_gen_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_gen_nbr = (TYPEOF(le.Input_gen_nbr))'','',':gen_nbr')
    #END
+    #IF( #TEXT(Input_std_prof_cd)='' )
      '' 
    #ELSE
        IF( le.Input_std_prof_cd = (TYPEOF(le.Input_std_prof_cd))'','',':std_prof_cd')
    #END
+    #IF( #TEXT(Input_std_prof_desc)='' )
      '' 
    #ELSE
        IF( le.Input_std_prof_desc = (TYPEOF(le.Input_std_prof_desc))'','',':std_prof_desc')
    #END
+    #IF( #TEXT(Input_std_source_upd)='' )
      '' 
    #ELSE
        IF( le.Input_std_source_upd = (TYPEOF(le.Input_std_source_upd))'','',':std_source_upd')
    #END
+    #IF( #TEXT(Input_std_source_desc)='' )
      '' 
    #ELSE
        IF( le.Input_std_source_desc = (TYPEOF(le.Input_std_source_desc))'','',':std_source_desc')
    #END
+    #IF( #TEXT(Input_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_type_cd = (TYPEOF(le.Input_type_cd))'','',':type_cd')
    #END
+    #IF( #TEXT(Input_name_org_prefx)='' )
      '' 
    #ELSE
        IF( le.Input_name_org_prefx = (TYPEOF(le.Input_name_org_prefx))'','',':name_org_prefx')
    #END
+    #IF( #TEXT(Input_name_org)='' )
      '' 
    #ELSE
        IF( le.Input_name_org = (TYPEOF(le.Input_name_org))'','',':name_org')
    #END
+    #IF( #TEXT(Input_name_org_sufx)='' )
      '' 
    #ELSE
        IF( le.Input_name_org_sufx = (TYPEOF(le.Input_name_org_sufx))'','',':name_org_sufx')
    #END
+    #IF( #TEXT(Input_store_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_store_nbr = (TYPEOF(le.Input_store_nbr))'','',':store_nbr')
    #END
+    #IF( #TEXT(Input_name_dba_prefx)='' )
      '' 
    #ELSE
        IF( le.Input_name_dba_prefx = (TYPEOF(le.Input_name_dba_prefx))'','',':name_dba_prefx')
    #END
+    #IF( #TEXT(Input_name_dba)='' )
      '' 
    #ELSE
        IF( le.Input_name_dba = (TYPEOF(le.Input_name_dba))'','',':name_dba')
    #END
+    #IF( #TEXT(Input_name_dba_sufx)='' )
      '' 
    #ELSE
        IF( le.Input_name_dba_sufx = (TYPEOF(le.Input_name_dba_sufx))'','',':name_dba_sufx')
    #END
+    #IF( #TEXT(Input_store_nbr_dba)='' )
      '' 
    #ELSE
        IF( le.Input_store_nbr_dba = (TYPEOF(le.Input_store_nbr_dba))'','',':store_nbr_dba')
    #END
+    #IF( #TEXT(Input_dba_flag)='' )
      '' 
    #ELSE
        IF( le.Input_dba_flag = (TYPEOF(le.Input_dba_flag))'','',':dba_flag')
    #END
+    #IF( #TEXT(Input_name_office)='' )
      '' 
    #ELSE
        IF( le.Input_name_office = (TYPEOF(le.Input_name_office))'','',':name_office')
    #END
+    #IF( #TEXT(Input_office_parse)='' )
      '' 
    #ELSE
        IF( le.Input_office_parse = (TYPEOF(le.Input_office_parse))'','',':office_parse')
    #END
+    #IF( #TEXT(Input_name_prefx)='' )
      '' 
    #ELSE
        IF( le.Input_name_prefx = (TYPEOF(le.Input_name_prefx))'','',':name_prefx')
    #END
+    #IF( #TEXT(Input_name_first)='' )
      '' 
    #ELSE
        IF( le.Input_name_first = (TYPEOF(le.Input_name_first))'','',':name_first')
    #END
+    #IF( #TEXT(Input_name_mid)='' )
      '' 
    #ELSE
        IF( le.Input_name_mid = (TYPEOF(le.Input_name_mid))'','',':name_mid')
    #END
+    #IF( #TEXT(Input_name_last)='' )
      '' 
    #ELSE
        IF( le.Input_name_last = (TYPEOF(le.Input_name_last))'','',':name_last')
    #END
+    #IF( #TEXT(Input_name_sufx)='' )
      '' 
    #ELSE
        IF( le.Input_name_sufx = (TYPEOF(le.Input_name_sufx))'','',':name_sufx')
    #END
+    #IF( #TEXT(Input_name_nick)='' )
      '' 
    #ELSE
        IF( le.Input_name_nick = (TYPEOF(le.Input_name_nick))'','',':name_nick')
    #END
+    #IF( #TEXT(Input_birth_dte)='' )
      '' 
    #ELSE
        IF( le.Input_birth_dte = (TYPEOF(le.Input_birth_dte))'','',':birth_dte')
    #END
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
+    #IF( #TEXT(Input_prov_stat)='' )
      '' 
    #ELSE
        IF( le.Input_prov_stat = (TYPEOF(le.Input_prov_stat))'','',':prov_stat')
    #END
+    #IF( #TEXT(Input_credential)='' )
      '' 
    #ELSE
        IF( le.Input_credential = (TYPEOF(le.Input_credential))'','',':credential')
    #END
+    #IF( #TEXT(Input_license_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_license_nbr = (TYPEOF(le.Input_license_nbr))'','',':license_nbr')
    #END
+    #IF( #TEXT(Input_off_license_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_off_license_nbr = (TYPEOF(le.Input_off_license_nbr))'','',':off_license_nbr')
    #END
+    #IF( #TEXT(Input_prev_license_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_prev_license_nbr = (TYPEOF(le.Input_prev_license_nbr))'','',':prev_license_nbr')
    #END
+    #IF( #TEXT(Input_prev_license_type)='' )
      '' 
    #ELSE
        IF( le.Input_prev_license_type = (TYPEOF(le.Input_prev_license_type))'','',':prev_license_type')
    #END
+    #IF( #TEXT(Input_license_state)='' )
      '' 
    #ELSE
        IF( le.Input_license_state = (TYPEOF(le.Input_license_state))'','',':license_state')
    #END
+    #IF( #TEXT(Input_raw_license_type)='' )
      '' 
    #ELSE
        IF( le.Input_raw_license_type = (TYPEOF(le.Input_raw_license_type))'','',':raw_license_type')
    #END
+    #IF( #TEXT(Input_std_license_type)='' )
      '' 
    #ELSE
        IF( le.Input_std_license_type = (TYPEOF(le.Input_std_license_type))'','',':std_license_type')
    #END
+    #IF( #TEXT(Input_std_license_desc)='' )
      '' 
    #ELSE
        IF( le.Input_std_license_desc = (TYPEOF(le.Input_std_license_desc))'','',':std_license_desc')
    #END
+    #IF( #TEXT(Input_raw_license_status)='' )
      '' 
    #ELSE
        IF( le.Input_raw_license_status = (TYPEOF(le.Input_raw_license_status))'','',':raw_license_status')
    #END
+    #IF( #TEXT(Input_std_license_status)='' )
      '' 
    #ELSE
        IF( le.Input_std_license_status = (TYPEOF(le.Input_std_license_status))'','',':std_license_status')
    #END
+    #IF( #TEXT(Input_std_status_desc)='' )
      '' 
    #ELSE
        IF( le.Input_std_status_desc = (TYPEOF(le.Input_std_status_desc))'','',':std_status_desc')
    #END
+    #IF( #TEXT(Input_curr_issue_dte)='' )
      '' 
    #ELSE
        IF( le.Input_curr_issue_dte = (TYPEOF(le.Input_curr_issue_dte))'','',':curr_issue_dte')
    #END
+    #IF( #TEXT(Input_orig_issue_dte)='' )
      '' 
    #ELSE
        IF( le.Input_orig_issue_dte = (TYPEOF(le.Input_orig_issue_dte))'','',':orig_issue_dte')
    #END
+    #IF( #TEXT(Input_expire_dte)='' )
      '' 
    #ELSE
        IF( le.Input_expire_dte = (TYPEOF(le.Input_expire_dte))'','',':expire_dte')
    #END
+    #IF( #TEXT(Input_renewal_dte)='' )
      '' 
    #ELSE
        IF( le.Input_renewal_dte = (TYPEOF(le.Input_renewal_dte))'','',':renewal_dte')
    #END
+    #IF( #TEXT(Input_active_flag)='' )
      '' 
    #ELSE
        IF( le.Input_active_flag = (TYPEOF(le.Input_active_flag))'','',':active_flag')
    #END
+    #IF( #TEXT(Input_ssn_taxid_1)='' )
      '' 
    #ELSE
        IF( le.Input_ssn_taxid_1 = (TYPEOF(le.Input_ssn_taxid_1))'','',':ssn_taxid_1')
    #END
+    #IF( #TEXT(Input_tax_type_1)='' )
      '' 
    #ELSE
        IF( le.Input_tax_type_1 = (TYPEOF(le.Input_tax_type_1))'','',':tax_type_1')
    #END
+    #IF( #TEXT(Input_ssn_taxid_2)='' )
      '' 
    #ELSE
        IF( le.Input_ssn_taxid_2 = (TYPEOF(le.Input_ssn_taxid_2))'','',':ssn_taxid_2')
    #END
+    #IF( #TEXT(Input_tax_type_2)='' )
      '' 
    #ELSE
        IF( le.Input_tax_type_2 = (TYPEOF(le.Input_tax_type_2))'','',':tax_type_2')
    #END
+    #IF( #TEXT(Input_fed_rssd)='' )
      '' 
    #ELSE
        IF( le.Input_fed_rssd = (TYPEOF(le.Input_fed_rssd))'','',':fed_rssd')
    #END
+    #IF( #TEXT(Input_addr_bus_ind)='' )
      '' 
    #ELSE
        IF( le.Input_addr_bus_ind = (TYPEOF(le.Input_addr_bus_ind))'','',':addr_bus_ind')
    #END
+    #IF( #TEXT(Input_name_format)='' )
      '' 
    #ELSE
        IF( le.Input_name_format = (TYPEOF(le.Input_name_format))'','',':name_format')
    #END
+    #IF( #TEXT(Input_name_org_orig)='' )
      '' 
    #ELSE
        IF( le.Input_name_org_orig = (TYPEOF(le.Input_name_org_orig))'','',':name_org_orig')
    #END
+    #IF( #TEXT(Input_name_dba_orig)='' )
      '' 
    #ELSE
        IF( le.Input_name_dba_orig = (TYPEOF(le.Input_name_dba_orig))'','',':name_dba_orig')
    #END
+    #IF( #TEXT(Input_name_mari_org)='' )
      '' 
    #ELSE
        IF( le.Input_name_mari_org = (TYPEOF(le.Input_name_mari_org))'','',':name_mari_org')
    #END
+    #IF( #TEXT(Input_name_mari_dba)='' )
      '' 
    #ELSE
        IF( le.Input_name_mari_dba = (TYPEOF(le.Input_name_mari_dba))'','',':name_mari_dba')
    #END
+    #IF( #TEXT(Input_phn_mari_1)='' )
      '' 
    #ELSE
        IF( le.Input_phn_mari_1 = (TYPEOF(le.Input_phn_mari_1))'','',':phn_mari_1')
    #END
+    #IF( #TEXT(Input_phn_mari_fax_1)='' )
      '' 
    #ELSE
        IF( le.Input_phn_mari_fax_1 = (TYPEOF(le.Input_phn_mari_fax_1))'','',':phn_mari_fax_1')
    #END
+    #IF( #TEXT(Input_phn_mari_2)='' )
      '' 
    #ELSE
        IF( le.Input_phn_mari_2 = (TYPEOF(le.Input_phn_mari_2))'','',':phn_mari_2')
    #END
+    #IF( #TEXT(Input_phn_mari_fax_2)='' )
      '' 
    #ELSE
        IF( le.Input_phn_mari_fax_2 = (TYPEOF(le.Input_phn_mari_fax_2))'','',':phn_mari_fax_2')
    #END
+    #IF( #TEXT(Input_addr_addr1_1)='' )
      '' 
    #ELSE
        IF( le.Input_addr_addr1_1 = (TYPEOF(le.Input_addr_addr1_1))'','',':addr_addr1_1')
    #END
+    #IF( #TEXT(Input_addr_addr2_1)='' )
      '' 
    #ELSE
        IF( le.Input_addr_addr2_1 = (TYPEOF(le.Input_addr_addr2_1))'','',':addr_addr2_1')
    #END
+    #IF( #TEXT(Input_addr_addr3_1)='' )
      '' 
    #ELSE
        IF( le.Input_addr_addr3_1 = (TYPEOF(le.Input_addr_addr3_1))'','',':addr_addr3_1')
    #END
+    #IF( #TEXT(Input_addr_addr4_1)='' )
      '' 
    #ELSE
        IF( le.Input_addr_addr4_1 = (TYPEOF(le.Input_addr_addr4_1))'','',':addr_addr4_1')
    #END
+    #IF( #TEXT(Input_addr_city_1)='' )
      '' 
    #ELSE
        IF( le.Input_addr_city_1 = (TYPEOF(le.Input_addr_city_1))'','',':addr_city_1')
    #END
+    #IF( #TEXT(Input_addr_state_1)='' )
      '' 
    #ELSE
        IF( le.Input_addr_state_1 = (TYPEOF(le.Input_addr_state_1))'','',':addr_state_1')
    #END
+    #IF( #TEXT(Input_addr_zip5_1)='' )
      '' 
    #ELSE
        IF( le.Input_addr_zip5_1 = (TYPEOF(le.Input_addr_zip5_1))'','',':addr_zip5_1')
    #END
+    #IF( #TEXT(Input_addr_zip4_1)='' )
      '' 
    #ELSE
        IF( le.Input_addr_zip4_1 = (TYPEOF(le.Input_addr_zip4_1))'','',':addr_zip4_1')
    #END
+    #IF( #TEXT(Input_phn_phone_1)='' )
      '' 
    #ELSE
        IF( le.Input_phn_phone_1 = (TYPEOF(le.Input_phn_phone_1))'','',':phn_phone_1')
    #END
+    #IF( #TEXT(Input_phn_fax_1)='' )
      '' 
    #ELSE
        IF( le.Input_phn_fax_1 = (TYPEOF(le.Input_phn_fax_1))'','',':phn_fax_1')
    #END
+    #IF( #TEXT(Input_addr_cnty_1)='' )
      '' 
    #ELSE
        IF( le.Input_addr_cnty_1 = (TYPEOF(le.Input_addr_cnty_1))'','',':addr_cnty_1')
    #END
+    #IF( #TEXT(Input_addr_cntry_1)='' )
      '' 
    #ELSE
        IF( le.Input_addr_cntry_1 = (TYPEOF(le.Input_addr_cntry_1))'','',':addr_cntry_1')
    #END
+    #IF( #TEXT(Input_sud_key_1)='' )
      '' 
    #ELSE
        IF( le.Input_sud_key_1 = (TYPEOF(le.Input_sud_key_1))'','',':sud_key_1')
    #END
+    #IF( #TEXT(Input_ooc_ind_1)='' )
      '' 
    #ELSE
        IF( le.Input_ooc_ind_1 = (TYPEOF(le.Input_ooc_ind_1))'','',':ooc_ind_1')
    #END
+    #IF( #TEXT(Input_addr_mail_ind)='' )
      '' 
    #ELSE
        IF( le.Input_addr_mail_ind = (TYPEOF(le.Input_addr_mail_ind))'','',':addr_mail_ind')
    #END
+    #IF( #TEXT(Input_addr_addr1_2)='' )
      '' 
    #ELSE
        IF( le.Input_addr_addr1_2 = (TYPEOF(le.Input_addr_addr1_2))'','',':addr_addr1_2')
    #END
+    #IF( #TEXT(Input_addr_addr2_2)='' )
      '' 
    #ELSE
        IF( le.Input_addr_addr2_2 = (TYPEOF(le.Input_addr_addr2_2))'','',':addr_addr2_2')
    #END
+    #IF( #TEXT(Input_addr_addr3_2)='' )
      '' 
    #ELSE
        IF( le.Input_addr_addr3_2 = (TYPEOF(le.Input_addr_addr3_2))'','',':addr_addr3_2')
    #END
+    #IF( #TEXT(Input_addr_addr4_2)='' )
      '' 
    #ELSE
        IF( le.Input_addr_addr4_2 = (TYPEOF(le.Input_addr_addr4_2))'','',':addr_addr4_2')
    #END
+    #IF( #TEXT(Input_addr_city_2)='' )
      '' 
    #ELSE
        IF( le.Input_addr_city_2 = (TYPEOF(le.Input_addr_city_2))'','',':addr_city_2')
    #END
+    #IF( #TEXT(Input_addr_state_2)='' )
      '' 
    #ELSE
        IF( le.Input_addr_state_2 = (TYPEOF(le.Input_addr_state_2))'','',':addr_state_2')
    #END
+    #IF( #TEXT(Input_addr_zip5_2)='' )
      '' 
    #ELSE
        IF( le.Input_addr_zip5_2 = (TYPEOF(le.Input_addr_zip5_2))'','',':addr_zip5_2')
    #END
+    #IF( #TEXT(Input_addr_zip4_2)='' )
      '' 
    #ELSE
        IF( le.Input_addr_zip4_2 = (TYPEOF(le.Input_addr_zip4_2))'','',':addr_zip4_2')
    #END
+    #IF( #TEXT(Input_addr_cnty_2)='' )
      '' 
    #ELSE
        IF( le.Input_addr_cnty_2 = (TYPEOF(le.Input_addr_cnty_2))'','',':addr_cnty_2')
    #END
+    #IF( #TEXT(Input_addr_cntry_2)='' )
      '' 
    #ELSE
        IF( le.Input_addr_cntry_2 = (TYPEOF(le.Input_addr_cntry_2))'','',':addr_cntry_2')
    #END
+    #IF( #TEXT(Input_phn_phone_2)='' )
      '' 
    #ELSE
        IF( le.Input_phn_phone_2 = (TYPEOF(le.Input_phn_phone_2))'','',':phn_phone_2')
    #END
+    #IF( #TEXT(Input_phn_fax_2)='' )
      '' 
    #ELSE
        IF( le.Input_phn_fax_2 = (TYPEOF(le.Input_phn_fax_2))'','',':phn_fax_2')
    #END
+    #IF( #TEXT(Input_sud_key_2)='' )
      '' 
    #ELSE
        IF( le.Input_sud_key_2 = (TYPEOF(le.Input_sud_key_2))'','',':sud_key_2')
    #END
+    #IF( #TEXT(Input_ooc_ind_2)='' )
      '' 
    #ELSE
        IF( le.Input_ooc_ind_2 = (TYPEOF(le.Input_ooc_ind_2))'','',':ooc_ind_2')
    #END
+    #IF( #TEXT(Input_license_nbr_contact)='' )
      '' 
    #ELSE
        IF( le.Input_license_nbr_contact = (TYPEOF(le.Input_license_nbr_contact))'','',':license_nbr_contact')
    #END
+    #IF( #TEXT(Input_name_contact_prefx)='' )
      '' 
    #ELSE
        IF( le.Input_name_contact_prefx = (TYPEOF(le.Input_name_contact_prefx))'','',':name_contact_prefx')
    #END
+    #IF( #TEXT(Input_name_contact_first)='' )
      '' 
    #ELSE
        IF( le.Input_name_contact_first = (TYPEOF(le.Input_name_contact_first))'','',':name_contact_first')
    #END
+    #IF( #TEXT(Input_name_contact_mid)='' )
      '' 
    #ELSE
        IF( le.Input_name_contact_mid = (TYPEOF(le.Input_name_contact_mid))'','',':name_contact_mid')
    #END
+    #IF( #TEXT(Input_name_contact_last)='' )
      '' 
    #ELSE
        IF( le.Input_name_contact_last = (TYPEOF(le.Input_name_contact_last))'','',':name_contact_last')
    #END
+    #IF( #TEXT(Input_name_contact_sufx)='' )
      '' 
    #ELSE
        IF( le.Input_name_contact_sufx = (TYPEOF(le.Input_name_contact_sufx))'','',':name_contact_sufx')
    #END
+    #IF( #TEXT(Input_name_contact_nick)='' )
      '' 
    #ELSE
        IF( le.Input_name_contact_nick = (TYPEOF(le.Input_name_contact_nick))'','',':name_contact_nick')
    #END
+    #IF( #TEXT(Input_name_contact_ttl)='' )
      '' 
    #ELSE
        IF( le.Input_name_contact_ttl = (TYPEOF(le.Input_name_contact_ttl))'','',':name_contact_ttl')
    #END
+    #IF( #TEXT(Input_phn_contact)='' )
      '' 
    #ELSE
        IF( le.Input_phn_contact = (TYPEOF(le.Input_phn_contact))'','',':phn_contact')
    #END
+    #IF( #TEXT(Input_phn_contact_ext)='' )
      '' 
    #ELSE
        IF( le.Input_phn_contact_ext = (TYPEOF(le.Input_phn_contact_ext))'','',':phn_contact_ext')
    #END
+    #IF( #TEXT(Input_phn_contact_fax)='' )
      '' 
    #ELSE
        IF( le.Input_phn_contact_fax = (TYPEOF(le.Input_phn_contact_fax))'','',':phn_contact_fax')
    #END
+    #IF( #TEXT(Input_email)='' )
      '' 
    #ELSE
        IF( le.Input_email = (TYPEOF(le.Input_email))'','',':email')
    #END
+    #IF( #TEXT(Input_url)='' )
      '' 
    #ELSE
        IF( le.Input_url = (TYPEOF(le.Input_url))'','',':url')
    #END
+    #IF( #TEXT(Input_bk_class)='' )
      '' 
    #ELSE
        IF( le.Input_bk_class = (TYPEOF(le.Input_bk_class))'','',':bk_class')
    #END
+    #IF( #TEXT(Input_bk_class_desc)='' )
      '' 
    #ELSE
        IF( le.Input_bk_class_desc = (TYPEOF(le.Input_bk_class_desc))'','',':bk_class_desc')
    #END
+    #IF( #TEXT(Input_charter)='' )
      '' 
    #ELSE
        IF( le.Input_charter = (TYPEOF(le.Input_charter))'','',':charter')
    #END
+    #IF( #TEXT(Input_inst_beg_dte)='' )
      '' 
    #ELSE
        IF( le.Input_inst_beg_dte = (TYPEOF(le.Input_inst_beg_dte))'','',':inst_beg_dte')
    #END
+    #IF( #TEXT(Input_origin_cd)='' )
      '' 
    #ELSE
        IF( le.Input_origin_cd = (TYPEOF(le.Input_origin_cd))'','',':origin_cd')
    #END
+    #IF( #TEXT(Input_origin_cd_desc)='' )
      '' 
    #ELSE
        IF( le.Input_origin_cd_desc = (TYPEOF(le.Input_origin_cd_desc))'','',':origin_cd_desc')
    #END
+    #IF( #TEXT(Input_disp_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_disp_type_cd = (TYPEOF(le.Input_disp_type_cd))'','',':disp_type_cd')
    #END
+    #IF( #TEXT(Input_disp_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_disp_type_desc = (TYPEOF(le.Input_disp_type_desc))'','',':disp_type_desc')
    #END
+    #IF( #TEXT(Input_reg_agent)='' )
      '' 
    #ELSE
        IF( le.Input_reg_agent = (TYPEOF(le.Input_reg_agent))'','',':reg_agent')
    #END
+    #IF( #TEXT(Input_regulator)='' )
      '' 
    #ELSE
        IF( le.Input_regulator = (TYPEOF(le.Input_regulator))'','',':regulator')
    #END
+    #IF( #TEXT(Input_hqtr_city)='' )
      '' 
    #ELSE
        IF( le.Input_hqtr_city = (TYPEOF(le.Input_hqtr_city))'','',':hqtr_city')
    #END
+    #IF( #TEXT(Input_hqtr_name)='' )
      '' 
    #ELSE
        IF( le.Input_hqtr_name = (TYPEOF(le.Input_hqtr_name))'','',':hqtr_name')
    #END
+    #IF( #TEXT(Input_domestic_off_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_domestic_off_nbr = (TYPEOF(le.Input_domestic_off_nbr))'','',':domestic_off_nbr')
    #END
+    #IF( #TEXT(Input_foreign_off_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_foreign_off_nbr = (TYPEOF(le.Input_foreign_off_nbr))'','',':foreign_off_nbr')
    #END
+    #IF( #TEXT(Input_hcr_rssd)='' )
      '' 
    #ELSE
        IF( le.Input_hcr_rssd = (TYPEOF(le.Input_hcr_rssd))'','',':hcr_rssd')
    #END
+    #IF( #TEXT(Input_hcr_location)='' )
      '' 
    #ELSE
        IF( le.Input_hcr_location = (TYPEOF(le.Input_hcr_location))'','',':hcr_location')
    #END
+    #IF( #TEXT(Input_affil_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_affil_type_cd = (TYPEOF(le.Input_affil_type_cd))'','',':affil_type_cd')
    #END
+    #IF( #TEXT(Input_genlink)='' )
      '' 
    #ELSE
        IF( le.Input_genlink = (TYPEOF(le.Input_genlink))'','',':genlink')
    #END
+    #IF( #TEXT(Input_research_ind)='' )
      '' 
    #ELSE
        IF( le.Input_research_ind = (TYPEOF(le.Input_research_ind))'','',':research_ind')
    #END
+    #IF( #TEXT(Input_docket_id)='' )
      '' 
    #ELSE
        IF( le.Input_docket_id = (TYPEOF(le.Input_docket_id))'','',':docket_id')
    #END
+    #IF( #TEXT(Input_mltreckey)='' )
      '' 
    #ELSE
        IF( le.Input_mltreckey = (TYPEOF(le.Input_mltreckey))'','',':mltreckey')
    #END
+    #IF( #TEXT(Input_cmc_slpk)='' )
      '' 
    #ELSE
        IF( le.Input_cmc_slpk = (TYPEOF(le.Input_cmc_slpk))'','',':cmc_slpk')
    #END
+    #IF( #TEXT(Input_pcmc_slpk)='' )
      '' 
    #ELSE
        IF( le.Input_pcmc_slpk = (TYPEOF(le.Input_pcmc_slpk))'','',':pcmc_slpk')
    #END
+    #IF( #TEXT(Input_affil_key)='' )
      '' 
    #ELSE
        IF( le.Input_affil_key = (TYPEOF(le.Input_affil_key))'','',':affil_key')
    #END
+    #IF( #TEXT(Input_provnote_1)='' )
      '' 
    #ELSE
        IF( le.Input_provnote_1 = (TYPEOF(le.Input_provnote_1))'','',':provnote_1')
    #END
+    #IF( #TEXT(Input_provnote_2)='' )
      '' 
    #ELSE
        IF( le.Input_provnote_2 = (TYPEOF(le.Input_provnote_2))'','',':provnote_2')
    #END
+    #IF( #TEXT(Input_provnote_3)='' )
      '' 
    #ELSE
        IF( le.Input_provnote_3 = (TYPEOF(le.Input_provnote_3))'','',':provnote_3')
    #END
+    #IF( #TEXT(Input_action_taken_ind)='' )
      '' 
    #ELSE
        IF( le.Input_action_taken_ind = (TYPEOF(le.Input_action_taken_ind))'','',':action_taken_ind')
    #END
+    #IF( #TEXT(Input_viol_type)='' )
      '' 
    #ELSE
        IF( le.Input_viol_type = (TYPEOF(le.Input_viol_type))'','',':viol_type')
    #END
+    #IF( #TEXT(Input_viol_cd)='' )
      '' 
    #ELSE
        IF( le.Input_viol_cd = (TYPEOF(le.Input_viol_cd))'','',':viol_cd')
    #END
+    #IF( #TEXT(Input_viol_desc)='' )
      '' 
    #ELSE
        IF( le.Input_viol_desc = (TYPEOF(le.Input_viol_desc))'','',':viol_desc')
    #END
+    #IF( #TEXT(Input_viol_dte)='' )
      '' 
    #ELSE
        IF( le.Input_viol_dte = (TYPEOF(le.Input_viol_dte))'','',':viol_dte')
    #END
+    #IF( #TEXT(Input_viol_case_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_viol_case_nbr = (TYPEOF(le.Input_viol_case_nbr))'','',':viol_case_nbr')
    #END
+    #IF( #TEXT(Input_viol_eff_dte)='' )
      '' 
    #ELSE
        IF( le.Input_viol_eff_dte = (TYPEOF(le.Input_viol_eff_dte))'','',':viol_eff_dte')
    #END
+    #IF( #TEXT(Input_action_final_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_action_final_nbr = (TYPEOF(le.Input_action_final_nbr))'','',':action_final_nbr')
    #END
+    #IF( #TEXT(Input_action_status)='' )
      '' 
    #ELSE
        IF( le.Input_action_status = (TYPEOF(le.Input_action_status))'','',':action_status')
    #END
+    #IF( #TEXT(Input_action_status_dte)='' )
      '' 
    #ELSE
        IF( le.Input_action_status_dte = (TYPEOF(le.Input_action_status_dte))'','',':action_status_dte')
    #END
+    #IF( #TEXT(Input_displinary_action)='' )
      '' 
    #ELSE
        IF( le.Input_displinary_action = (TYPEOF(le.Input_displinary_action))'','',':displinary_action')
    #END
+    #IF( #TEXT(Input_action_file_name)='' )
      '' 
    #ELSE
        IF( le.Input_action_file_name = (TYPEOF(le.Input_action_file_name))'','',':action_file_name')
    #END
+    #IF( #TEXT(Input_occupation)='' )
      '' 
    #ELSE
        IF( le.Input_occupation = (TYPEOF(le.Input_occupation))'','',':occupation')
    #END
+    #IF( #TEXT(Input_practice_hrs)='' )
      '' 
    #ELSE
        IF( le.Input_practice_hrs = (TYPEOF(le.Input_practice_hrs))'','',':practice_hrs')
    #END
+    #IF( #TEXT(Input_practice_type)='' )
      '' 
    #ELSE
        IF( le.Input_practice_type = (TYPEOF(le.Input_practice_type))'','',':practice_type')
    #END
+    #IF( #TEXT(Input_misc_other_id)='' )
      '' 
    #ELSE
        IF( le.Input_misc_other_id = (TYPEOF(le.Input_misc_other_id))'','',':misc_other_id')
    #END
+    #IF( #TEXT(Input_misc_other_type)='' )
      '' 
    #ELSE
        IF( le.Input_misc_other_type = (TYPEOF(le.Input_misc_other_type))'','',':misc_other_type')
    #END
+    #IF( #TEXT(Input_cont_education_ernd)='' )
      '' 
    #ELSE
        IF( le.Input_cont_education_ernd = (TYPEOF(le.Input_cont_education_ernd))'','',':cont_education_ernd')
    #END
+    #IF( #TEXT(Input_cont_education_req)='' )
      '' 
    #ELSE
        IF( le.Input_cont_education_req = (TYPEOF(le.Input_cont_education_req))'','',':cont_education_req')
    #END
+    #IF( #TEXT(Input_cont_education_term)='' )
      '' 
    #ELSE
        IF( le.Input_cont_education_term = (TYPEOF(le.Input_cont_education_term))'','',':cont_education_term')
    #END
+    #IF( #TEXT(Input_schl_attend_1)='' )
      '' 
    #ELSE
        IF( le.Input_schl_attend_1 = (TYPEOF(le.Input_schl_attend_1))'','',':schl_attend_1')
    #END
+    #IF( #TEXT(Input_schl_attend_dte_1)='' )
      '' 
    #ELSE
        IF( le.Input_schl_attend_dte_1 = (TYPEOF(le.Input_schl_attend_dte_1))'','',':schl_attend_dte_1')
    #END
+    #IF( #TEXT(Input_schl_curriculum_1)='' )
      '' 
    #ELSE
        IF( le.Input_schl_curriculum_1 = (TYPEOF(le.Input_schl_curriculum_1))'','',':schl_curriculum_1')
    #END
+    #IF( #TEXT(Input_schl_degree_1)='' )
      '' 
    #ELSE
        IF( le.Input_schl_degree_1 = (TYPEOF(le.Input_schl_degree_1))'','',':schl_degree_1')
    #END
+    #IF( #TEXT(Input_schl_attend_2)='' )
      '' 
    #ELSE
        IF( le.Input_schl_attend_2 = (TYPEOF(le.Input_schl_attend_2))'','',':schl_attend_2')
    #END
+    #IF( #TEXT(Input_schl_attend_dte_2)='' )
      '' 
    #ELSE
        IF( le.Input_schl_attend_dte_2 = (TYPEOF(le.Input_schl_attend_dte_2))'','',':schl_attend_dte_2')
    #END
+    #IF( #TEXT(Input_schl_curriculum_2)='' )
      '' 
    #ELSE
        IF( le.Input_schl_curriculum_2 = (TYPEOF(le.Input_schl_curriculum_2))'','',':schl_curriculum_2')
    #END
+    #IF( #TEXT(Input_schl_degree_2)='' )
      '' 
    #ELSE
        IF( le.Input_schl_degree_2 = (TYPEOF(le.Input_schl_degree_2))'','',':schl_degree_2')
    #END
+    #IF( #TEXT(Input_schl_attend_3)='' )
      '' 
    #ELSE
        IF( le.Input_schl_attend_3 = (TYPEOF(le.Input_schl_attend_3))'','',':schl_attend_3')
    #END
+    #IF( #TEXT(Input_schl_attend_dte_3)='' )
      '' 
    #ELSE
        IF( le.Input_schl_attend_dte_3 = (TYPEOF(le.Input_schl_attend_dte_3))'','',':schl_attend_dte_3')
    #END
+    #IF( #TEXT(Input_schl_curriculum_3)='' )
      '' 
    #ELSE
        IF( le.Input_schl_curriculum_3 = (TYPEOF(le.Input_schl_curriculum_3))'','',':schl_curriculum_3')
    #END
+    #IF( #TEXT(Input_schl_degree_3)='' )
      '' 
    #ELSE
        IF( le.Input_schl_degree_3 = (TYPEOF(le.Input_schl_degree_3))'','',':schl_degree_3')
    #END
+    #IF( #TEXT(Input_addl_license_spec)='' )
      '' 
    #ELSE
        IF( le.Input_addl_license_spec = (TYPEOF(le.Input_addl_license_spec))'','',':addl_license_spec')
    #END
+    #IF( #TEXT(Input_place_birth_cd)='' )
      '' 
    #ELSE
        IF( le.Input_place_birth_cd = (TYPEOF(le.Input_place_birth_cd))'','',':place_birth_cd')
    #END
+    #IF( #TEXT(Input_place_birth_desc)='' )
      '' 
    #ELSE
        IF( le.Input_place_birth_desc = (TYPEOF(le.Input_place_birth_desc))'','',':place_birth_desc')
    #END
+    #IF( #TEXT(Input_race_cd)='' )
      '' 
    #ELSE
        IF( le.Input_race_cd = (TYPEOF(le.Input_race_cd))'','',':race_cd')
    #END
+    #IF( #TEXT(Input_std_race_cd)='' )
      '' 
    #ELSE
        IF( le.Input_std_race_cd = (TYPEOF(le.Input_std_race_cd))'','',':std_race_cd')
    #END
+    #IF( #TEXT(Input_race_desc)='' )
      '' 
    #ELSE
        IF( le.Input_race_desc = (TYPEOF(le.Input_race_desc))'','',':race_desc')
    #END
+    #IF( #TEXT(Input_status_effect_dte)='' )
      '' 
    #ELSE
        IF( le.Input_status_effect_dte = (TYPEOF(le.Input_status_effect_dte))'','',':status_effect_dte')
    #END
+    #IF( #TEXT(Input_status_renew_desc)='' )
      '' 
    #ELSE
        IF( le.Input_status_renew_desc = (TYPEOF(le.Input_status_renew_desc))'','',':status_renew_desc')
    #END
+    #IF( #TEXT(Input_agency_status)='' )
      '' 
    #ELSE
        IF( le.Input_agency_status = (TYPEOF(le.Input_agency_status))'','',':agency_status')
    #END
+    #IF( #TEXT(Input_prev_primary_key)='' )
      '' 
    #ELSE
        IF( le.Input_prev_primary_key = (TYPEOF(le.Input_prev_primary_key))'','',':prev_primary_key')
    #END
+    #IF( #TEXT(Input_prev_mltreckey)='' )
      '' 
    #ELSE
        IF( le.Input_prev_mltreckey = (TYPEOF(le.Input_prev_mltreckey))'','',':prev_mltreckey')
    #END
+    #IF( #TEXT(Input_prev_cmc_slpk)='' )
      '' 
    #ELSE
        IF( le.Input_prev_cmc_slpk = (TYPEOF(le.Input_prev_cmc_slpk))'','',':prev_cmc_slpk')
    #END
+    #IF( #TEXT(Input_prev_pcmc_slpk)='' )
      '' 
    #ELSE
        IF( le.Input_prev_pcmc_slpk = (TYPEOF(le.Input_prev_pcmc_slpk))'','',':prev_pcmc_slpk')
    #END
+    #IF( #TEXT(Input_license_id)='' )
      '' 
    #ELSE
        IF( le.Input_license_id = (TYPEOF(le.Input_license_id))'','',':license_id')
    #END
+    #IF( #TEXT(Input_nmls_id)='' )
      '' 
    #ELSE
        IF( le.Input_nmls_id = (TYPEOF(le.Input_nmls_id))'','',':nmls_id')
    #END
+    #IF( #TEXT(Input_foreign_nmls_id)='' )
      '' 
    #ELSE
        IF( le.Input_foreign_nmls_id = (TYPEOF(le.Input_foreign_nmls_id))'','',':foreign_nmls_id')
    #END
+    #IF( #TEXT(Input_location_type)='' )
      '' 
    #ELSE
        IF( le.Input_location_type = (TYPEOF(le.Input_location_type))'','',':location_type')
    #END
+    #IF( #TEXT(Input_off_license_nbr_type)='' )
      '' 
    #ELSE
        IF( le.Input_off_license_nbr_type = (TYPEOF(le.Input_off_license_nbr_type))'','',':off_license_nbr_type')
    #END
+    #IF( #TEXT(Input_brkr_license_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_brkr_license_nbr = (TYPEOF(le.Input_brkr_license_nbr))'','',':brkr_license_nbr')
    #END
+    #IF( #TEXT(Input_brkr_license_nbr_type)='' )
      '' 
    #ELSE
        IF( le.Input_brkr_license_nbr_type = (TYPEOF(le.Input_brkr_license_nbr_type))'','',':brkr_license_nbr_type')
    #END
+    #IF( #TEXT(Input_agency_id)='' )
      '' 
    #ELSE
        IF( le.Input_agency_id = (TYPEOF(le.Input_agency_id))'','',':agency_id')
    #END
+    #IF( #TEXT(Input_site_location)='' )
      '' 
    #ELSE
        IF( le.Input_site_location = (TYPEOF(le.Input_site_location))'','',':site_location')
    #END
+    #IF( #TEXT(Input_business_type)='' )
      '' 
    #ELSE
        IF( le.Input_business_type = (TYPEOF(le.Input_business_type))'','',':business_type')
    #END
+    #IF( #TEXT(Input_name_type)='' )
      '' 
    #ELSE
        IF( le.Input_name_type = (TYPEOF(le.Input_name_type))'','',':name_type')
    #END
+    #IF( #TEXT(Input_start_dte)='' )
      '' 
    #ELSE
        IF( le.Input_start_dte = (TYPEOF(le.Input_start_dte))'','',':start_dte')
    #END
+    #IF( #TEXT(Input_is_authorized_license)='' )
      '' 
    #ELSE
        IF( le.Input_is_authorized_license = (TYPEOF(le.Input_is_authorized_license))'','',':is_authorized_license')
    #END
+    #IF( #TEXT(Input_is_authorized_conduct)='' )
      '' 
    #ELSE
        IF( le.Input_is_authorized_conduct = (TYPEOF(le.Input_is_authorized_conduct))'','',':is_authorized_conduct')
    #END
+    #IF( #TEXT(Input_federal_regulator)='' )
      '' 
    #ELSE
        IF( le.Input_federal_regulator = (TYPEOF(le.Input_federal_regulator))'','',':federal_regulator')
    #END
;
    #IF (#TEXT(std_source_upd)<>'')
    SELF.source := le.std_source_upd;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(std_source_upd)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(std_source_upd)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(std_source_upd)<>'' ) source, #END -cnt );
ENDMACRO;
