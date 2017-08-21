EXPORT MAC_PopulationStatistics(infile,Ref='',source_file='',Input_tmsid = '',Input_rmsid = '',Input_orig_rmsid = '',Input_process_date = '',Input_record_code = '',Input_date_vendor_removed = '',Input_filing_jurisdiction = '',Input_filing_state = '',Input_orig_filing_number = '',Input_orig_filing_type = '',Input_orig_filing_date = '',Input_orig_filing_time = '',Input_case_number = '',Input_filing_number = '',Input_filing_type_desc = '',Input_filing_date = '',Input_filing_time = '',Input_vendor_entry_date = '',Input_judge = '',Input_case_title = '',Input_filing_book = '',Input_filing_page = '',Input_release_date = '',Input_amount = '',Input_eviction = '',Input_satisifaction_type = '',Input_judg_satisfied_date = '',Input_judg_vacated_date = '',Input_tax_code = '',Input_irs_serial_number = '',Input_effective_date = '',Input_lapse_date = '',Input_accident_date = '',Input_sherrif_indc = '',Input_expiration_date = '',Input_agency = '',Input_agency_city = '',Input_agency_state = '',Input_agency_county = '',Input_legal_lot = '',Input_legal_block = '',Input_legal_borough = '',Input_certificate_number = '',Input_persistent_record_id = '',Input_source_file = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_LiensV2_Main;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(source_file)<>'')
    SALT30.StrType source;
    #END
    SALT30.Str512Type fields;
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
+    #IF( #TEXT(Input_orig_rmsid)='' )
      '' 
    #ELSE
        IF( le.Input_orig_rmsid = (TYPEOF(le.Input_orig_rmsid))'','',':orig_rmsid')
    #END
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
+    #IF( #TEXT(Input_record_code)='' )
      '' 
    #ELSE
        IF( le.Input_record_code = (TYPEOF(le.Input_record_code))'','',':record_code')
    #END
+    #IF( #TEXT(Input_date_vendor_removed)='' )
      '' 
    #ELSE
        IF( le.Input_date_vendor_removed = (TYPEOF(le.Input_date_vendor_removed))'','',':date_vendor_removed')
    #END
+    #IF( #TEXT(Input_filing_jurisdiction)='' )
      '' 
    #ELSE
        IF( le.Input_filing_jurisdiction = (TYPEOF(le.Input_filing_jurisdiction))'','',':filing_jurisdiction')
    #END
+    #IF( #TEXT(Input_filing_state)='' )
      '' 
    #ELSE
        IF( le.Input_filing_state = (TYPEOF(le.Input_filing_state))'','',':filing_state')
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
+    #IF( #TEXT(Input_case_number)='' )
      '' 
    #ELSE
        IF( le.Input_case_number = (TYPEOF(le.Input_case_number))'','',':case_number')
    #END
+    #IF( #TEXT(Input_filing_number)='' )
      '' 
    #ELSE
        IF( le.Input_filing_number = (TYPEOF(le.Input_filing_number))'','',':filing_number')
    #END
+    #IF( #TEXT(Input_filing_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_filing_type_desc = (TYPEOF(le.Input_filing_type_desc))'','',':filing_type_desc')
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
+    #IF( #TEXT(Input_vendor_entry_date)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_entry_date = (TYPEOF(le.Input_vendor_entry_date))'','',':vendor_entry_date')
    #END
+    #IF( #TEXT(Input_judge)='' )
      '' 
    #ELSE
        IF( le.Input_judge = (TYPEOF(le.Input_judge))'','',':judge')
    #END
+    #IF( #TEXT(Input_case_title)='' )
      '' 
    #ELSE
        IF( le.Input_case_title = (TYPEOF(le.Input_case_title))'','',':case_title')
    #END
+    #IF( #TEXT(Input_filing_book)='' )
      '' 
    #ELSE
        IF( le.Input_filing_book = (TYPEOF(le.Input_filing_book))'','',':filing_book')
    #END
+    #IF( #TEXT(Input_filing_page)='' )
      '' 
    #ELSE
        IF( le.Input_filing_page = (TYPEOF(le.Input_filing_page))'','',':filing_page')
    #END
+    #IF( #TEXT(Input_release_date)='' )
      '' 
    #ELSE
        IF( le.Input_release_date = (TYPEOF(le.Input_release_date))'','',':release_date')
    #END
+    #IF( #TEXT(Input_amount)='' )
      '' 
    #ELSE
        IF( le.Input_amount = (TYPEOF(le.Input_amount))'','',':amount')
    #END
+    #IF( #TEXT(Input_eviction)='' )
      '' 
    #ELSE
        IF( le.Input_eviction = (TYPEOF(le.Input_eviction))'','',':eviction')
    #END
+    #IF( #TEXT(Input_satisifaction_type)='' )
      '' 
    #ELSE
        IF( le.Input_satisifaction_type = (TYPEOF(le.Input_satisifaction_type))'','',':satisifaction_type')
    #END
+    #IF( #TEXT(Input_judg_satisfied_date)='' )
      '' 
    #ELSE
        IF( le.Input_judg_satisfied_date = (TYPEOF(le.Input_judg_satisfied_date))'','',':judg_satisfied_date')
    #END
+    #IF( #TEXT(Input_judg_vacated_date)='' )
      '' 
    #ELSE
        IF( le.Input_judg_vacated_date = (TYPEOF(le.Input_judg_vacated_date))'','',':judg_vacated_date')
    #END
+    #IF( #TEXT(Input_tax_code)='' )
      '' 
    #ELSE
        IF( le.Input_tax_code = (TYPEOF(le.Input_tax_code))'','',':tax_code')
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
+    #IF( #TEXT(Input_lapse_date)='' )
      '' 
    #ELSE
        IF( le.Input_lapse_date = (TYPEOF(le.Input_lapse_date))'','',':lapse_date')
    #END
+    #IF( #TEXT(Input_accident_date)='' )
      '' 
    #ELSE
        IF( le.Input_accident_date = (TYPEOF(le.Input_accident_date))'','',':accident_date')
    #END
+    #IF( #TEXT(Input_sherrif_indc)='' )
      '' 
    #ELSE
        IF( le.Input_sherrif_indc = (TYPEOF(le.Input_sherrif_indc))'','',':sherrif_indc')
    #END
+    #IF( #TEXT(Input_expiration_date)='' )
      '' 
    #ELSE
        IF( le.Input_expiration_date = (TYPEOF(le.Input_expiration_date))'','',':expiration_date')
    #END
+    #IF( #TEXT(Input_agency)='' )
      '' 
    #ELSE
        IF( le.Input_agency = (TYPEOF(le.Input_agency))'','',':agency')
    #END
+    #IF( #TEXT(Input_agency_city)='' )
      '' 
    #ELSE
        IF( le.Input_agency_city = (TYPEOF(le.Input_agency_city))'','',':agency_city')
    #END
+    #IF( #TEXT(Input_agency_state)='' )
      '' 
    #ELSE
        IF( le.Input_agency_state = (TYPEOF(le.Input_agency_state))'','',':agency_state')
    #END
+    #IF( #TEXT(Input_agency_county)='' )
      '' 
    #ELSE
        IF( le.Input_agency_county = (TYPEOF(le.Input_agency_county))'','',':agency_county')
    #END
+    #IF( #TEXT(Input_legal_lot)='' )
      '' 
    #ELSE
        IF( le.Input_legal_lot = (TYPEOF(le.Input_legal_lot))'','',':legal_lot')
    #END
+    #IF( #TEXT(Input_legal_block)='' )
      '' 
    #ELSE
        IF( le.Input_legal_block = (TYPEOF(le.Input_legal_block))'','',':legal_block')
    #END
+    #IF( #TEXT(Input_legal_borough)='' )
      '' 
    #ELSE
        IF( le.Input_legal_borough = (TYPEOF(le.Input_legal_borough))'','',':legal_borough')
    #END
+    #IF( #TEXT(Input_certificate_number)='' )
      '' 
    #ELSE
        IF( le.Input_certificate_number = (TYPEOF(le.Input_certificate_number))'','',':certificate_number')
    #END
+    #IF( #TEXT(Input_persistent_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_persistent_record_id = (TYPEOF(le.Input_persistent_record_id))'','',':persistent_record_id')
    #END
+    #IF( #TEXT(Input_source_file)='' )
      '' 
    #ELSE
        IF( le.Input_source_file = (TYPEOF(le.Input_source_file))'','',':source_file')
    #END
;
    #IF (#TEXT(source_file)<>'')
    SELF.source := le.source_file;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(source_file)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(source_file)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(source_file)<>'' ) source, #END -cnt );
ENDMACRO;
