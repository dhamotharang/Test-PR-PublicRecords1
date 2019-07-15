 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_orig_datetime_stamp = '',Input_orig_global_company_id = '',Input_orig_company_id = '',Input_orig_product_cd = '',Input_orig_method = '',Input_orig_vertical = '',Input_orig_function_name = '',Input_orig_transaction_type = '',Input_orig_login_history_id = '',Input_orig_job_id = '',Input_orig_sequence_number = '',Input_orig_first_name = '',Input_orig_middle_name = '',Input_orig_last_name = '',Input_orig_ssn = '',Input_orig_dob = '',Input_orig_dl_num = '',Input_orig_dl_state = '',Input_orig_address1_addressline1 = '',Input_orig_address1_addressline2 = '',Input_orig_address1_prim_range = '',Input_orig_address1_predir = '',Input_orig_address1_prim_name = '',Input_orig_address1_suffix = '',Input_orig_address1_postdir = '',Input_orig_address1_unit_desig = '',Input_orig_address1_sec_range = '',Input_orig_address1_city = '',Input_orig_address1_st = '',Input_orig_address1_z5 = '',Input_orig_address1_z4 = '',Input_orig_address2_addressline1 = '',Input_orig_address2_addressline2 = '',Input_orig_address2_prim_range = '',Input_orig_address2_predir = '',Input_orig_address2_prim_name = '',Input_orig_address2_suffix = '',Input_orig_address2_postdir = '',Input_orig_address2_unit_desig = '',Input_orig_address2_sec_range = '',Input_orig_address2_city = '',Input_orig_address2_st = '',Input_orig_address2_z5 = '',Input_orig_address2_z4 = '',Input_orig_bdid = '',Input_orig_bdl = '',Input_orig_did = '',Input_orig_company_name = '',Input_orig_fein = '',Input_orig_phone = '',Input_orig_work_phone = '',Input_orig_company_phone = '',Input_orig_reference_code = '',Input_orig_ip_address_initiated = '',Input_orig_ip_address_executed = '',Input_orig_charter_number = '',Input_orig_ucc_original_filing_number = '',Input_orig_email_address = '',Input_orig_domain_name = '',Input_orig_full_name = '',Input_orig_dl_purpose = '',Input_orig_glb_purpose = '',Input_orig_fcra_purpose = '',Input_orig_process_id = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_Inql_fcra_Batch;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_orig_datetime_stamp)='' )
      '' 
    #ELSE
        IF( le.Input_orig_datetime_stamp = (TYPEOF(le.Input_orig_datetime_stamp))'','',':orig_datetime_stamp')
    #END
 
+    #IF( #TEXT(Input_orig_global_company_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_global_company_id = (TYPEOF(le.Input_orig_global_company_id))'','',':orig_global_company_id')
    #END
 
+    #IF( #TEXT(Input_orig_company_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_company_id = (TYPEOF(le.Input_orig_company_id))'','',':orig_company_id')
    #END
 
+    #IF( #TEXT(Input_orig_product_cd)='' )
      '' 
    #ELSE
        IF( le.Input_orig_product_cd = (TYPEOF(le.Input_orig_product_cd))'','',':orig_product_cd')
    #END
 
+    #IF( #TEXT(Input_orig_method)='' )
      '' 
    #ELSE
        IF( le.Input_orig_method = (TYPEOF(le.Input_orig_method))'','',':orig_method')
    #END
 
+    #IF( #TEXT(Input_orig_vertical)='' )
      '' 
    #ELSE
        IF( le.Input_orig_vertical = (TYPEOF(le.Input_orig_vertical))'','',':orig_vertical')
    #END
 
+    #IF( #TEXT(Input_orig_function_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_function_name = (TYPEOF(le.Input_orig_function_name))'','',':orig_function_name')
    #END
 
+    #IF( #TEXT(Input_orig_transaction_type)='' )
      '' 
    #ELSE
        IF( le.Input_orig_transaction_type = (TYPEOF(le.Input_orig_transaction_type))'','',':orig_transaction_type')
    #END
 
+    #IF( #TEXT(Input_orig_login_history_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_login_history_id = (TYPEOF(le.Input_orig_login_history_id))'','',':orig_login_history_id')
    #END
 
+    #IF( #TEXT(Input_orig_job_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_job_id = (TYPEOF(le.Input_orig_job_id))'','',':orig_job_id')
    #END
 
+    #IF( #TEXT(Input_orig_sequence_number)='' )
      '' 
    #ELSE
        IF( le.Input_orig_sequence_number = (TYPEOF(le.Input_orig_sequence_number))'','',':orig_sequence_number')
    #END
 
+    #IF( #TEXT(Input_orig_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_first_name = (TYPEOF(le.Input_orig_first_name))'','',':orig_first_name')
    #END
 
+    #IF( #TEXT(Input_orig_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_middle_name = (TYPEOF(le.Input_orig_middle_name))'','',':orig_middle_name')
    #END
 
+    #IF( #TEXT(Input_orig_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_last_name = (TYPEOF(le.Input_orig_last_name))'','',':orig_last_name')
    #END
 
+    #IF( #TEXT(Input_orig_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_orig_ssn = (TYPEOF(le.Input_orig_ssn))'','',':orig_ssn')
    #END
 
+    #IF( #TEXT(Input_orig_dob)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dob = (TYPEOF(le.Input_orig_dob))'','',':orig_dob')
    #END
 
+    #IF( #TEXT(Input_orig_dl_num)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dl_num = (TYPEOF(le.Input_orig_dl_num))'','',':orig_dl_num')
    #END
 
+    #IF( #TEXT(Input_orig_dl_state)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dl_state = (TYPEOF(le.Input_orig_dl_state))'','',':orig_dl_state')
    #END
 
+    #IF( #TEXT(Input_orig_address1_addressline1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address1_addressline1 = (TYPEOF(le.Input_orig_address1_addressline1))'','',':orig_address1_addressline1')
    #END
 
+    #IF( #TEXT(Input_orig_address1_addressline2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address1_addressline2 = (TYPEOF(le.Input_orig_address1_addressline2))'','',':orig_address1_addressline2')
    #END
 
+    #IF( #TEXT(Input_orig_address1_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address1_prim_range = (TYPEOF(le.Input_orig_address1_prim_range))'','',':orig_address1_prim_range')
    #END
 
+    #IF( #TEXT(Input_orig_address1_predir)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address1_predir = (TYPEOF(le.Input_orig_address1_predir))'','',':orig_address1_predir')
    #END
 
+    #IF( #TEXT(Input_orig_address1_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address1_prim_name = (TYPEOF(le.Input_orig_address1_prim_name))'','',':orig_address1_prim_name')
    #END
 
+    #IF( #TEXT(Input_orig_address1_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address1_suffix = (TYPEOF(le.Input_orig_address1_suffix))'','',':orig_address1_suffix')
    #END
 
+    #IF( #TEXT(Input_orig_address1_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address1_postdir = (TYPEOF(le.Input_orig_address1_postdir))'','',':orig_address1_postdir')
    #END
 
+    #IF( #TEXT(Input_orig_address1_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address1_unit_desig = (TYPEOF(le.Input_orig_address1_unit_desig))'','',':orig_address1_unit_desig')
    #END
 
+    #IF( #TEXT(Input_orig_address1_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address1_sec_range = (TYPEOF(le.Input_orig_address1_sec_range))'','',':orig_address1_sec_range')
    #END
 
+    #IF( #TEXT(Input_orig_address1_city)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address1_city = (TYPEOF(le.Input_orig_address1_city))'','',':orig_address1_city')
    #END
 
+    #IF( #TEXT(Input_orig_address1_st)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address1_st = (TYPEOF(le.Input_orig_address1_st))'','',':orig_address1_st')
    #END
 
+    #IF( #TEXT(Input_orig_address1_z5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address1_z5 = (TYPEOF(le.Input_orig_address1_z5))'','',':orig_address1_z5')
    #END
 
+    #IF( #TEXT(Input_orig_address1_z4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address1_z4 = (TYPEOF(le.Input_orig_address1_z4))'','',':orig_address1_z4')
    #END
 
+    #IF( #TEXT(Input_orig_address2_addressline1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address2_addressline1 = (TYPEOF(le.Input_orig_address2_addressline1))'','',':orig_address2_addressline1')
    #END
 
+    #IF( #TEXT(Input_orig_address2_addressline2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address2_addressline2 = (TYPEOF(le.Input_orig_address2_addressline2))'','',':orig_address2_addressline2')
    #END
 
+    #IF( #TEXT(Input_orig_address2_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address2_prim_range = (TYPEOF(le.Input_orig_address2_prim_range))'','',':orig_address2_prim_range')
    #END
 
+    #IF( #TEXT(Input_orig_address2_predir)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address2_predir = (TYPEOF(le.Input_orig_address2_predir))'','',':orig_address2_predir')
    #END
 
+    #IF( #TEXT(Input_orig_address2_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address2_prim_name = (TYPEOF(le.Input_orig_address2_prim_name))'','',':orig_address2_prim_name')
    #END
 
+    #IF( #TEXT(Input_orig_address2_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address2_suffix = (TYPEOF(le.Input_orig_address2_suffix))'','',':orig_address2_suffix')
    #END
 
+    #IF( #TEXT(Input_orig_address2_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address2_postdir = (TYPEOF(le.Input_orig_address2_postdir))'','',':orig_address2_postdir')
    #END
 
+    #IF( #TEXT(Input_orig_address2_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address2_unit_desig = (TYPEOF(le.Input_orig_address2_unit_desig))'','',':orig_address2_unit_desig')
    #END
 
+    #IF( #TEXT(Input_orig_address2_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address2_sec_range = (TYPEOF(le.Input_orig_address2_sec_range))'','',':orig_address2_sec_range')
    #END
 
+    #IF( #TEXT(Input_orig_address2_city)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address2_city = (TYPEOF(le.Input_orig_address2_city))'','',':orig_address2_city')
    #END
 
+    #IF( #TEXT(Input_orig_address2_st)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address2_st = (TYPEOF(le.Input_orig_address2_st))'','',':orig_address2_st')
    #END
 
+    #IF( #TEXT(Input_orig_address2_z5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address2_z5 = (TYPEOF(le.Input_orig_address2_z5))'','',':orig_address2_z5')
    #END
 
+    #IF( #TEXT(Input_orig_address2_z4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address2_z4 = (TYPEOF(le.Input_orig_address2_z4))'','',':orig_address2_z4')
    #END
 
+    #IF( #TEXT(Input_orig_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_orig_bdid = (TYPEOF(le.Input_orig_bdid))'','',':orig_bdid')
    #END
 
+    #IF( #TEXT(Input_orig_bdl)='' )
      '' 
    #ELSE
        IF( le.Input_orig_bdl = (TYPEOF(le.Input_orig_bdl))'','',':orig_bdl')
    #END
 
+    #IF( #TEXT(Input_orig_did)='' )
      '' 
    #ELSE
        IF( le.Input_orig_did = (TYPEOF(le.Input_orig_did))'','',':orig_did')
    #END
 
+    #IF( #TEXT(Input_orig_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_company_name = (TYPEOF(le.Input_orig_company_name))'','',':orig_company_name')
    #END
 
+    #IF( #TEXT(Input_orig_fein)='' )
      '' 
    #ELSE
        IF( le.Input_orig_fein = (TYPEOF(le.Input_orig_fein))'','',':orig_fein')
    #END
 
+    #IF( #TEXT(Input_orig_phone)='' )
      '' 
    #ELSE
        IF( le.Input_orig_phone = (TYPEOF(le.Input_orig_phone))'','',':orig_phone')
    #END
 
+    #IF( #TEXT(Input_orig_work_phone)='' )
      '' 
    #ELSE
        IF( le.Input_orig_work_phone = (TYPEOF(le.Input_orig_work_phone))'','',':orig_work_phone')
    #END
 
+    #IF( #TEXT(Input_orig_company_phone)='' )
      '' 
    #ELSE
        IF( le.Input_orig_company_phone = (TYPEOF(le.Input_orig_company_phone))'','',':orig_company_phone')
    #END
 
+    #IF( #TEXT(Input_orig_reference_code)='' )
      '' 
    #ELSE
        IF( le.Input_orig_reference_code = (TYPEOF(le.Input_orig_reference_code))'','',':orig_reference_code')
    #END
 
+    #IF( #TEXT(Input_orig_ip_address_initiated)='' )
      '' 
    #ELSE
        IF( le.Input_orig_ip_address_initiated = (TYPEOF(le.Input_orig_ip_address_initiated))'','',':orig_ip_address_initiated')
    #END
 
+    #IF( #TEXT(Input_orig_ip_address_executed)='' )
      '' 
    #ELSE
        IF( le.Input_orig_ip_address_executed = (TYPEOF(le.Input_orig_ip_address_executed))'','',':orig_ip_address_executed')
    #END
 
+    #IF( #TEXT(Input_orig_charter_number)='' )
      '' 
    #ELSE
        IF( le.Input_orig_charter_number = (TYPEOF(le.Input_orig_charter_number))'','',':orig_charter_number')
    #END
 
+    #IF( #TEXT(Input_orig_ucc_original_filing_number)='' )
      '' 
    #ELSE
        IF( le.Input_orig_ucc_original_filing_number = (TYPEOF(le.Input_orig_ucc_original_filing_number))'','',':orig_ucc_original_filing_number')
    #END
 
+    #IF( #TEXT(Input_orig_email_address)='' )
      '' 
    #ELSE
        IF( le.Input_orig_email_address = (TYPEOF(le.Input_orig_email_address))'','',':orig_email_address')
    #END
 
+    #IF( #TEXT(Input_orig_domain_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_domain_name = (TYPEOF(le.Input_orig_domain_name))'','',':orig_domain_name')
    #END
 
+    #IF( #TEXT(Input_orig_full_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_full_name = (TYPEOF(le.Input_orig_full_name))'','',':orig_full_name')
    #END
 
+    #IF( #TEXT(Input_orig_dl_purpose)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dl_purpose = (TYPEOF(le.Input_orig_dl_purpose))'','',':orig_dl_purpose')
    #END
 
+    #IF( #TEXT(Input_orig_glb_purpose)='' )
      '' 
    #ELSE
        IF( le.Input_orig_glb_purpose = (TYPEOF(le.Input_orig_glb_purpose))'','',':orig_glb_purpose')
    #END
 
+    #IF( #TEXT(Input_orig_fcra_purpose)='' )
      '' 
    #ELSE
        IF( le.Input_orig_fcra_purpose = (TYPEOF(le.Input_orig_fcra_purpose))'','',':orig_fcra_purpose')
    #END
 
+    #IF( #TEXT(Input_orig_process_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_process_id = (TYPEOF(le.Input_orig_process_id))'','',':orig_process_id')
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
