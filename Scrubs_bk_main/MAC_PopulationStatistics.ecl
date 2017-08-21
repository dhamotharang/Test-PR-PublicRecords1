EXPORT MAC_PopulationStatistics(infile,Ref='',source='',Input_process_date = '',Input_tmsid = '',Input_source = '',Input_id = '',Input_seq_number = '',Input_date_created = '',Input_date_modified = '',Input_method_dismiss = '',Input_case_status = '',Input_court_code = '',Input_court_name = '',Input_court_location = '',Input_case_number = '',Input_orig_case_number = '',Input_date_filed = '',Input_filing_status = '',Input_orig_chapter = '',Input_orig_filing_date = '',Input_assets_no_asset_indicator = '',Input_filer_type = '',Input_meeting_date = '',Input_meeting_time = '',Input_address_341 = '',Input_claims_deadline = '',Input_complaint_deadline = '',Input_judge_name = '',Input_judges_identification = '',Input_filing_jurisdiction = '',Input_assets = '',Input_liabilities = '',Input_casetype = '',Input_assoccode = '',Input_splitcase = '',Input_filedinerror = '',Input_date_last_seen = '',Input_date_first_seen = '',Input_date_vendor_first_reported = '',Input_date_vendor_last_reported = '',Input_reopen_date = '',Input_case_closing_date = '',Input_datereclosed = '',Input_trusteename = '',Input_trusteeaddress = '',Input_trusteecity = '',Input_trusteestate = '',Input_trusteezip = '',Input_trusteezip4 = '',Input_trusteephone = '',Input_trusteeid = '',Input_caseid = '',Input_bardate = '',Input_transferin = '',Input_trusteeemail = '',Input_planconfdate = '',Input_confheardate = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_did = '',Input_app_ssn = '',Input_delete_flag = '',Input_unique_id = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_bk_main;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(source)<>'')
    SALT30.StrType source;
    #END
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
+    #IF( #TEXT(Input_tmsid)='' )
      '' 
    #ELSE
        IF( le.Input_tmsid = (TYPEOF(le.Input_tmsid))'','',':tmsid')
    #END
+    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
    #END
+    #IF( #TEXT(Input_id)='' )
      '' 
    #ELSE
        IF( le.Input_id = (TYPEOF(le.Input_id))'','',':id')
    #END
+    #IF( #TEXT(Input_seq_number)='' )
      '' 
    #ELSE
        IF( le.Input_seq_number = (TYPEOF(le.Input_seq_number))'','',':seq_number')
    #END
+    #IF( #TEXT(Input_date_created)='' )
      '' 
    #ELSE
        IF( le.Input_date_created = (TYPEOF(le.Input_date_created))'','',':date_created')
    #END
+    #IF( #TEXT(Input_date_modified)='' )
      '' 
    #ELSE
        IF( le.Input_date_modified = (TYPEOF(le.Input_date_modified))'','',':date_modified')
    #END
+    #IF( #TEXT(Input_method_dismiss)='' )
      '' 
    #ELSE
        IF( le.Input_method_dismiss = (TYPEOF(le.Input_method_dismiss))'','',':method_dismiss')
    #END
+    #IF( #TEXT(Input_case_status)='' )
      '' 
    #ELSE
        IF( le.Input_case_status = (TYPEOF(le.Input_case_status))'','',':case_status')
    #END
+    #IF( #TEXT(Input_court_code)='' )
      '' 
    #ELSE
        IF( le.Input_court_code = (TYPEOF(le.Input_court_code))'','',':court_code')
    #END
+    #IF( #TEXT(Input_court_name)='' )
      '' 
    #ELSE
        IF( le.Input_court_name = (TYPEOF(le.Input_court_name))'','',':court_name')
    #END
+    #IF( #TEXT(Input_court_location)='' )
      '' 
    #ELSE
        IF( le.Input_court_location = (TYPEOF(le.Input_court_location))'','',':court_location')
    #END
+    #IF( #TEXT(Input_case_number)='' )
      '' 
    #ELSE
        IF( le.Input_case_number = (TYPEOF(le.Input_case_number))'','',':case_number')
    #END
+    #IF( #TEXT(Input_orig_case_number)='' )
      '' 
    #ELSE
        IF( le.Input_orig_case_number = (TYPEOF(le.Input_orig_case_number))'','',':orig_case_number')
    #END
+    #IF( #TEXT(Input_date_filed)='' )
      '' 
    #ELSE
        IF( le.Input_date_filed = (TYPEOF(le.Input_date_filed))'','',':date_filed')
    #END
+    #IF( #TEXT(Input_filing_status)='' )
      '' 
    #ELSE
        IF( le.Input_filing_status = (TYPEOF(le.Input_filing_status))'','',':filing_status')
    #END
+    #IF( #TEXT(Input_orig_chapter)='' )
      '' 
    #ELSE
        IF( le.Input_orig_chapter = (TYPEOF(le.Input_orig_chapter))'','',':orig_chapter')
    #END
+    #IF( #TEXT(Input_orig_filing_date)='' )
      '' 
    #ELSE
        IF( le.Input_orig_filing_date = (TYPEOF(le.Input_orig_filing_date))'','',':orig_filing_date')
    #END
+    #IF( #TEXT(Input_assets_no_asset_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_assets_no_asset_indicator = (TYPEOF(le.Input_assets_no_asset_indicator))'','',':assets_no_asset_indicator')
    #END
+    #IF( #TEXT(Input_filer_type)='' )
      '' 
    #ELSE
        IF( le.Input_filer_type = (TYPEOF(le.Input_filer_type))'','',':filer_type')
    #END
+    #IF( #TEXT(Input_meeting_date)='' )
      '' 
    #ELSE
        IF( le.Input_meeting_date = (TYPEOF(le.Input_meeting_date))'','',':meeting_date')
    #END
+    #IF( #TEXT(Input_meeting_time)='' )
      '' 
    #ELSE
        IF( le.Input_meeting_time = (TYPEOF(le.Input_meeting_time))'','',':meeting_time')
    #END
+    #IF( #TEXT(Input_address_341)='' )
      '' 
    #ELSE
        IF( le.Input_address_341 = (TYPEOF(le.Input_address_341))'','',':address_341')
    #END
+    #IF( #TEXT(Input_claims_deadline)='' )
      '' 
    #ELSE
        IF( le.Input_claims_deadline = (TYPEOF(le.Input_claims_deadline))'','',':claims_deadline')
    #END
+    #IF( #TEXT(Input_complaint_deadline)='' )
      '' 
    #ELSE
        IF( le.Input_complaint_deadline = (TYPEOF(le.Input_complaint_deadline))'','',':complaint_deadline')
    #END
+    #IF( #TEXT(Input_judge_name)='' )
      '' 
    #ELSE
        IF( le.Input_judge_name = (TYPEOF(le.Input_judge_name))'','',':judge_name')
    #END
+    #IF( #TEXT(Input_judges_identification)='' )
      '' 
    #ELSE
        IF( le.Input_judges_identification = (TYPEOF(le.Input_judges_identification))'','',':judges_identification')
    #END
+    #IF( #TEXT(Input_filing_jurisdiction)='' )
      '' 
    #ELSE
        IF( le.Input_filing_jurisdiction = (TYPEOF(le.Input_filing_jurisdiction))'','',':filing_jurisdiction')
    #END
+    #IF( #TEXT(Input_assets)='' )
      '' 
    #ELSE
        IF( le.Input_assets = (TYPEOF(le.Input_assets))'','',':assets')
    #END
+    #IF( #TEXT(Input_liabilities)='' )
      '' 
    #ELSE
        IF( le.Input_liabilities = (TYPEOF(le.Input_liabilities))'','',':liabilities')
    #END
+    #IF( #TEXT(Input_casetype)='' )
      '' 
    #ELSE
        IF( le.Input_casetype = (TYPEOF(le.Input_casetype))'','',':casetype')
    #END
+    #IF( #TEXT(Input_assoccode)='' )
      '' 
    #ELSE
        IF( le.Input_assoccode = (TYPEOF(le.Input_assoccode))'','',':assoccode')
    #END
+    #IF( #TEXT(Input_splitcase)='' )
      '' 
    #ELSE
        IF( le.Input_splitcase = (TYPEOF(le.Input_splitcase))'','',':splitcase')
    #END
+    #IF( #TEXT(Input_filedinerror)='' )
      '' 
    #ELSE
        IF( le.Input_filedinerror = (TYPEOF(le.Input_filedinerror))'','',':filedinerror')
    #END
+    #IF( #TEXT(Input_date_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_last_seen = (TYPEOF(le.Input_date_last_seen))'','',':date_last_seen')
    #END
+    #IF( #TEXT(Input_date_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_first_seen = (TYPEOF(le.Input_date_first_seen))'','',':date_first_seen')
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
+    #IF( #TEXT(Input_reopen_date)='' )
      '' 
    #ELSE
        IF( le.Input_reopen_date = (TYPEOF(le.Input_reopen_date))'','',':reopen_date')
    #END
+    #IF( #TEXT(Input_case_closing_date)='' )
      '' 
    #ELSE
        IF( le.Input_case_closing_date = (TYPEOF(le.Input_case_closing_date))'','',':case_closing_date')
    #END
+    #IF( #TEXT(Input_datereclosed)='' )
      '' 
    #ELSE
        IF( le.Input_datereclosed = (TYPEOF(le.Input_datereclosed))'','',':datereclosed')
    #END
+    #IF( #TEXT(Input_trusteename)='' )
      '' 
    #ELSE
        IF( le.Input_trusteename = (TYPEOF(le.Input_trusteename))'','',':trusteename')
    #END
+    #IF( #TEXT(Input_trusteeaddress)='' )
      '' 
    #ELSE
        IF( le.Input_trusteeaddress = (TYPEOF(le.Input_trusteeaddress))'','',':trusteeaddress')
    #END
+    #IF( #TEXT(Input_trusteecity)='' )
      '' 
    #ELSE
        IF( le.Input_trusteecity = (TYPEOF(le.Input_trusteecity))'','',':trusteecity')
    #END
+    #IF( #TEXT(Input_trusteestate)='' )
      '' 
    #ELSE
        IF( le.Input_trusteestate = (TYPEOF(le.Input_trusteestate))'','',':trusteestate')
    #END
+    #IF( #TEXT(Input_trusteezip)='' )
      '' 
    #ELSE
        IF( le.Input_trusteezip = (TYPEOF(le.Input_trusteezip))'','',':trusteezip')
    #END
+    #IF( #TEXT(Input_trusteezip4)='' )
      '' 
    #ELSE
        IF( le.Input_trusteezip4 = (TYPEOF(le.Input_trusteezip4))'','',':trusteezip4')
    #END
+    #IF( #TEXT(Input_trusteephone)='' )
      '' 
    #ELSE
        IF( le.Input_trusteephone = (TYPEOF(le.Input_trusteephone))'','',':trusteephone')
    #END
+    #IF( #TEXT(Input_trusteeid)='' )
      '' 
    #ELSE
        IF( le.Input_trusteeid = (TYPEOF(le.Input_trusteeid))'','',':trusteeid')
    #END
+    #IF( #TEXT(Input_caseid)='' )
      '' 
    #ELSE
        IF( le.Input_caseid = (TYPEOF(le.Input_caseid))'','',':caseid')
    #END
+    #IF( #TEXT(Input_bardate)='' )
      '' 
    #ELSE
        IF( le.Input_bardate = (TYPEOF(le.Input_bardate))'','',':bardate')
    #END
+    #IF( #TEXT(Input_transferin)='' )
      '' 
    #ELSE
        IF( le.Input_transferin = (TYPEOF(le.Input_transferin))'','',':transferin')
    #END
+    #IF( #TEXT(Input_trusteeemail)='' )
      '' 
    #ELSE
        IF( le.Input_trusteeemail = (TYPEOF(le.Input_trusteeemail))'','',':trusteeemail')
    #END
+    #IF( #TEXT(Input_planconfdate)='' )
      '' 
    #ELSE
        IF( le.Input_planconfdate = (TYPEOF(le.Input_planconfdate))'','',':planconfdate')
    #END
+    #IF( #TEXT(Input_confheardate)='' )
      '' 
    #ELSE
        IF( le.Input_confheardate = (TYPEOF(le.Input_confheardate))'','',':confheardate')
    #END
+    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (TYPEOF(le.Input_title))'','',':title')
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
+    #IF( #TEXT(Input_name_score)='' )
      '' 
    #ELSE
        IF( le.Input_name_score = (TYPEOF(le.Input_name_score))'','',':name_score')
    #END
+    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
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
+    #IF( #TEXT(Input_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_addr_suffix = (TYPEOF(le.Input_addr_suffix))'','',':addr_suffix')
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
+    #IF( #TEXT(Input_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_p_city_name = (TYPEOF(le.Input_p_city_name))'','',':p_city_name')
    #END
+    #IF( #TEXT(Input_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_v_city_name = (TYPEOF(le.Input_v_city_name))'','',':v_city_name')
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
+    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
+    #IF( #TEXT(Input_cart)='' )
      '' 
    #ELSE
        IF( le.Input_cart = (TYPEOF(le.Input_cart))'','',':cart')
    #END
+    #IF( #TEXT(Input_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_cr_sort_sz = (TYPEOF(le.Input_cr_sort_sz))'','',':cr_sort_sz')
    #END
+    #IF( #TEXT(Input_lot)='' )
      '' 
    #ELSE
        IF( le.Input_lot = (TYPEOF(le.Input_lot))'','',':lot')
    #END
+    #IF( #TEXT(Input_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_lot_order = (TYPEOF(le.Input_lot_order))'','',':lot_order')
    #END
+    #IF( #TEXT(Input_dbpc)='' )
      '' 
    #ELSE
        IF( le.Input_dbpc = (TYPEOF(le.Input_dbpc))'','',':dbpc')
    #END
+    #IF( #TEXT(Input_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_chk_digit = (TYPEOF(le.Input_chk_digit))'','',':chk_digit')
    #END
+    #IF( #TEXT(Input_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_rec_type = (TYPEOF(le.Input_rec_type))'','',':rec_type')
    #END
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
    #END
+    #IF( #TEXT(Input_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_geo_lat = (TYPEOF(le.Input_geo_lat))'','',':geo_lat')
    #END
+    #IF( #TEXT(Input_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_geo_long = (TYPEOF(le.Input_geo_long))'','',':geo_long')
    #END
+    #IF( #TEXT(Input_msa)='' )
      '' 
    #ELSE
        IF( le.Input_msa = (TYPEOF(le.Input_msa))'','',':msa')
    #END
+    #IF( #TEXT(Input_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_geo_blk = (TYPEOF(le.Input_geo_blk))'','',':geo_blk')
    #END
+    #IF( #TEXT(Input_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_geo_match = (TYPEOF(le.Input_geo_match))'','',':geo_match')
    #END
+    #IF( #TEXT(Input_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_err_stat = (TYPEOF(le.Input_err_stat))'','',':err_stat')
    #END
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
+    #IF( #TEXT(Input_app_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_app_ssn = (TYPEOF(le.Input_app_ssn))'','',':app_ssn')
    #END
+    #IF( #TEXT(Input_delete_flag)='' )
      '' 
    #ELSE
        IF( le.Input_delete_flag = (TYPEOF(le.Input_delete_flag))'','',':delete_flag')
    #END
+    #IF( #TEXT(Input_unique_id)='' )
      '' 
    #ELSE
        IF( le.Input_unique_id = (TYPEOF(le.Input_unique_id))'','',':unique_id')
    #END
;
    #IF (#TEXT(source)<>'')
    SELF.source := le.source;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(source)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(source)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(source)<>'' ) source, #END -cnt );
ENDMACRO;
