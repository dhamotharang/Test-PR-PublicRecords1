 
EXPORT IL_Main_MAC_PopulationStatistics(infile,Ref='',Input_tmsid = '',Input_rmsid = '',Input_process_date = '',Input_static_value = '',Input_date_vendor_removed = '',Input_date_vendor_changed = '',Input_filing_jurisdiction = '',Input_orig_filing_number = '',Input_orig_filing_type = '',Input_orig_filing_date = '',Input_orig_filing_time = '',Input_filing_number = '',Input_filing_number_indc = '',Input_filing_type = '',Input_filing_date = '',Input_filing_time = '',Input_filing_status = '',Input_status_type = '',Input_page = '',Input_expiration_date = '',Input_contract_type = '',Input_vendor_entry_date = '',Input_vendor_upd_date = '',Input_statements_filed = '',Input_continuious_expiration = '',Input_microfilm_number = '',Input_amount = '',Input_irs_serial_number = '',Input_effective_date = '',Input_signer_name = '',Input_title = '',Input_filing_agency = '',Input_address = '',Input_city = '',Input_state = '',Input_county = '',Input_zip = '',Input_duns_number = '',Input_cmnt_effective_date = '',Input_description = '',Input_collateral_desc = '',Input_prim_machine = '',Input_sec_machine = '',Input_manufacturer_code = '',Input_manufacturer_name = '',Input_model = '',Input_model_year = '',Input_model_desc = '',Input_collateral_count = '',Input_manufactured_year = '',Input_new_used = '',Input_serial_number = '',Input_property_desc = '',Input_borough = '',Input_block = '',Input_lot = '',Input_collateral_address = '',Input_air_rights_indc = '',Input_subterranean_rights_indc = '',Input_easment_indc = '',Input_volume = '',Input_persistent_record_id = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_UCCV2;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_tmsid)='' )
      '' 
    #ELSE
        IF( le.Input_tmsid = (TYPEOF(le.Input_tmsid))'','',':tmsid')
    #END
 
+    #IF( #TEXT(Input_rmsid)='' )
      '' 
    #ELSE
        IF( le.Input_rmsid = (TYPEOF(le.Input_rmsid))'','',':rmsid')
    #END
 
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_static_value)='' )
      '' 
    #ELSE
        IF( le.Input_static_value = (TYPEOF(le.Input_static_value))'','',':static_value')
    #END
 
+    #IF( #TEXT(Input_date_vendor_removed)='' )
      '' 
    #ELSE
        IF( le.Input_date_vendor_removed = (TYPEOF(le.Input_date_vendor_removed))'','',':date_vendor_removed')
    #END
 
+    #IF( #TEXT(Input_date_vendor_changed)='' )
      '' 
    #ELSE
        IF( le.Input_date_vendor_changed = (TYPEOF(le.Input_date_vendor_changed))'','',':date_vendor_changed')
    #END
 
+    #IF( #TEXT(Input_filing_jurisdiction)='' )
      '' 
    #ELSE
        IF( le.Input_filing_jurisdiction = (TYPEOF(le.Input_filing_jurisdiction))'','',':filing_jurisdiction')
    #END
 
+    #IF( #TEXT(Input_orig_filing_number)='' )
      '' 
    #ELSE
        IF( le.Input_orig_filing_number = (TYPEOF(le.Input_orig_filing_number))'','',':orig_filing_number')
    #END
 
+    #IF( #TEXT(Input_orig_filing_type)='' )
      '' 
    #ELSE
        IF( le.Input_orig_filing_type = (TYPEOF(le.Input_orig_filing_type))'','',':orig_filing_type')
    #END
 
+    #IF( #TEXT(Input_orig_filing_date)='' )
      '' 
    #ELSE
        IF( le.Input_orig_filing_date = (TYPEOF(le.Input_orig_filing_date))'','',':orig_filing_date')
    #END
 
+    #IF( #TEXT(Input_orig_filing_time)='' )
      '' 
    #ELSE
        IF( le.Input_orig_filing_time = (TYPEOF(le.Input_orig_filing_time))'','',':orig_filing_time')
    #END
 
+    #IF( #TEXT(Input_filing_number)='' )
      '' 
    #ELSE
        IF( le.Input_filing_number = (TYPEOF(le.Input_filing_number))'','',':filing_number')
    #END
 
+    #IF( #TEXT(Input_filing_number_indc)='' )
      '' 
    #ELSE
        IF( le.Input_filing_number_indc = (TYPEOF(le.Input_filing_number_indc))'','',':filing_number_indc')
    #END
 
+    #IF( #TEXT(Input_filing_type)='' )
      '' 
    #ELSE
        IF( le.Input_filing_type = (TYPEOF(le.Input_filing_type))'','',':filing_type')
    #END
 
+    #IF( #TEXT(Input_filing_date)='' )
      '' 
    #ELSE
        IF( le.Input_filing_date = (TYPEOF(le.Input_filing_date))'','',':filing_date')
    #END
 
+    #IF( #TEXT(Input_filing_time)='' )
      '' 
    #ELSE
        IF( le.Input_filing_time = (TYPEOF(le.Input_filing_time))'','',':filing_time')
    #END
 
+    #IF( #TEXT(Input_filing_status)='' )
      '' 
    #ELSE
        IF( le.Input_filing_status = (TYPEOF(le.Input_filing_status))'','',':filing_status')
    #END
 
+    #IF( #TEXT(Input_status_type)='' )
      '' 
    #ELSE
        IF( le.Input_status_type = (TYPEOF(le.Input_status_type))'','',':status_type')
    #END
 
+    #IF( #TEXT(Input_page)='' )
      '' 
    #ELSE
        IF( le.Input_page = (TYPEOF(le.Input_page))'','',':page')
    #END
 
+    #IF( #TEXT(Input_expiration_date)='' )
      '' 
    #ELSE
        IF( le.Input_expiration_date = (TYPEOF(le.Input_expiration_date))'','',':expiration_date')
    #END
 
+    #IF( #TEXT(Input_contract_type)='' )
      '' 
    #ELSE
        IF( le.Input_contract_type = (TYPEOF(le.Input_contract_type))'','',':contract_type')
    #END
 
+    #IF( #TEXT(Input_vendor_entry_date)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_entry_date = (TYPEOF(le.Input_vendor_entry_date))'','',':vendor_entry_date')
    #END
 
+    #IF( #TEXT(Input_vendor_upd_date)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_upd_date = (TYPEOF(le.Input_vendor_upd_date))'','',':vendor_upd_date')
    #END
 
+    #IF( #TEXT(Input_statements_filed)='' )
      '' 
    #ELSE
        IF( le.Input_statements_filed = (TYPEOF(le.Input_statements_filed))'','',':statements_filed')
    #END
 
+    #IF( #TEXT(Input_continuious_expiration)='' )
      '' 
    #ELSE
        IF( le.Input_continuious_expiration = (TYPEOF(le.Input_continuious_expiration))'','',':continuious_expiration')
    #END
 
+    #IF( #TEXT(Input_microfilm_number)='' )
      '' 
    #ELSE
        IF( le.Input_microfilm_number = (TYPEOF(le.Input_microfilm_number))'','',':microfilm_number')
    #END
 
+    #IF( #TEXT(Input_amount)='' )
      '' 
    #ELSE
        IF( le.Input_amount = (TYPEOF(le.Input_amount))'','',':amount')
    #END
 
+    #IF( #TEXT(Input_irs_serial_number)='' )
      '' 
    #ELSE
        IF( le.Input_irs_serial_number = (TYPEOF(le.Input_irs_serial_number))'','',':irs_serial_number')
    #END
 
+    #IF( #TEXT(Input_effective_date)='' )
      '' 
    #ELSE
        IF( le.Input_effective_date = (TYPEOF(le.Input_effective_date))'','',':effective_date')
    #END
 
+    #IF( #TEXT(Input_signer_name)='' )
      '' 
    #ELSE
        IF( le.Input_signer_name = (TYPEOF(le.Input_signer_name))'','',':signer_name')
    #END
 
+    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (TYPEOF(le.Input_title))'','',':title')
    #END
 
+    #IF( #TEXT(Input_filing_agency)='' )
      '' 
    #ELSE
        IF( le.Input_filing_agency = (TYPEOF(le.Input_filing_agency))'','',':filing_agency')
    #END
 
+    #IF( #TEXT(Input_address)='' )
      '' 
    #ELSE
        IF( le.Input_address = (TYPEOF(le.Input_address))'','',':address')
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
 
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
    #END
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_duns_number)='' )
      '' 
    #ELSE
        IF( le.Input_duns_number = (TYPEOF(le.Input_duns_number))'','',':duns_number')
    #END
 
+    #IF( #TEXT(Input_cmnt_effective_date)='' )
      '' 
    #ELSE
        IF( le.Input_cmnt_effective_date = (TYPEOF(le.Input_cmnt_effective_date))'','',':cmnt_effective_date')
    #END
 
+    #IF( #TEXT(Input_description)='' )
      '' 
    #ELSE
        IF( le.Input_description = (TYPEOF(le.Input_description))'','',':description')
    #END
 
+    #IF( #TEXT(Input_collateral_desc)='' )
      '' 
    #ELSE
        IF( le.Input_collateral_desc = (TYPEOF(le.Input_collateral_desc))'','',':collateral_desc')
    #END
 
+    #IF( #TEXT(Input_prim_machine)='' )
      '' 
    #ELSE
        IF( le.Input_prim_machine = (TYPEOF(le.Input_prim_machine))'','',':prim_machine')
    #END
 
+    #IF( #TEXT(Input_sec_machine)='' )
      '' 
    #ELSE
        IF( le.Input_sec_machine = (TYPEOF(le.Input_sec_machine))'','',':sec_machine')
    #END
 
+    #IF( #TEXT(Input_manufacturer_code)='' )
      '' 
    #ELSE
        IF( le.Input_manufacturer_code = (TYPEOF(le.Input_manufacturer_code))'','',':manufacturer_code')
    #END
 
+    #IF( #TEXT(Input_manufacturer_name)='' )
      '' 
    #ELSE
        IF( le.Input_manufacturer_name = (TYPEOF(le.Input_manufacturer_name))'','',':manufacturer_name')
    #END
 
+    #IF( #TEXT(Input_model)='' )
      '' 
    #ELSE
        IF( le.Input_model = (TYPEOF(le.Input_model))'','',':model')
    #END
 
+    #IF( #TEXT(Input_model_year)='' )
      '' 
    #ELSE
        IF( le.Input_model_year = (TYPEOF(le.Input_model_year))'','',':model_year')
    #END
 
+    #IF( #TEXT(Input_model_desc)='' )
      '' 
    #ELSE
        IF( le.Input_model_desc = (TYPEOF(le.Input_model_desc))'','',':model_desc')
    #END
 
+    #IF( #TEXT(Input_collateral_count)='' )
      '' 
    #ELSE
        IF( le.Input_collateral_count = (TYPEOF(le.Input_collateral_count))'','',':collateral_count')
    #END
 
+    #IF( #TEXT(Input_manufactured_year)='' )
      '' 
    #ELSE
        IF( le.Input_manufactured_year = (TYPEOF(le.Input_manufactured_year))'','',':manufactured_year')
    #END
 
+    #IF( #TEXT(Input_new_used)='' )
      '' 
    #ELSE
        IF( le.Input_new_used = (TYPEOF(le.Input_new_used))'','',':new_used')
    #END
 
+    #IF( #TEXT(Input_serial_number)='' )
      '' 
    #ELSE
        IF( le.Input_serial_number = (TYPEOF(le.Input_serial_number))'','',':serial_number')
    #END
 
+    #IF( #TEXT(Input_property_desc)='' )
      '' 
    #ELSE
        IF( le.Input_property_desc = (TYPEOF(le.Input_property_desc))'','',':property_desc')
    #END
 
+    #IF( #TEXT(Input_borough)='' )
      '' 
    #ELSE
        IF( le.Input_borough = (TYPEOF(le.Input_borough))'','',':borough')
    #END
 
+    #IF( #TEXT(Input_block)='' )
      '' 
    #ELSE
        IF( le.Input_block = (TYPEOF(le.Input_block))'','',':block')
    #END
 
+    #IF( #TEXT(Input_lot)='' )
      '' 
    #ELSE
        IF( le.Input_lot = (TYPEOF(le.Input_lot))'','',':lot')
    #END
 
+    #IF( #TEXT(Input_collateral_address)='' )
      '' 
    #ELSE
        IF( le.Input_collateral_address = (TYPEOF(le.Input_collateral_address))'','',':collateral_address')
    #END
 
+    #IF( #TEXT(Input_air_rights_indc)='' )
      '' 
    #ELSE
        IF( le.Input_air_rights_indc = (TYPEOF(le.Input_air_rights_indc))'','',':air_rights_indc')
    #END
 
+    #IF( #TEXT(Input_subterranean_rights_indc)='' )
      '' 
    #ELSE
        IF( le.Input_subterranean_rights_indc = (TYPEOF(le.Input_subterranean_rights_indc))'','',':subterranean_rights_indc')
    #END
 
+    #IF( #TEXT(Input_easment_indc)='' )
      '' 
    #ELSE
        IF( le.Input_easment_indc = (TYPEOF(le.Input_easment_indc))'','',':easment_indc')
    #END
 
+    #IF( #TEXT(Input_volume)='' )
      '' 
    #ELSE
        IF( le.Input_volume = (TYPEOF(le.Input_volume))'','',':volume')
    #END
 
+    #IF( #TEXT(Input_persistent_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_persistent_record_id = (TYPEOF(le.Input_persistent_record_id))'','',':persistent_record_id')
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
