 
EXPORT Aircraft_MAC_PopulationStatistics(infile,Ref='',Input_d_score = '',Input_best_ssn = '',Input_did_out = '',Input_bdid_out = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_current_flag = '',Input_n_number = '',Input_serial_number = '',Input_mfr_mdl_code = '',Input_eng_mfr_mdl = '',Input_year_mfr = '',Input_type_registrant = '',Input_name = '',Input_street = '',Input_street2 = '',Input_city = '',Input_state = '',Input_zip_code = '',Input_region = '',Input_orig_county = '',Input_country = '',Input_last_action_date = '',Input_cert_issue_date = '',Input_certification = '',Input_type_aircraft = '',Input_type_engine = '',Input_status_code = '',Input_mode_s_code = '',Input_fract_owner = '',Input_aircraft_mfr_name = '',Input_model_name = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_z4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dpbc = '',Input_chk_digit = '',Input_rec_type = '',Input_ace_fips_st = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_compname = '',Input_lf = '',Input_source_rec_id = '',Input_dotid = '',Input_dotscore = '',Input_dotweight = '',Input_empid = '',Input_empscore = '',Input_empweight = '',Input_powid = '',Input_powscore = '',Input_powweight = '',Input_proxid = '',Input_proxscore = '',Input_proxweight = '',Input_seleid = '',Input_selescore = '',Input_seleweight = '',Input_orgid = '',Input_orgscore = '',Input_orgweight = '',Input_ultid = '',Input_ultscore = '',Input_ultweight = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_FAA;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_d_score)='' )
      '' 
    #ELSE
        IF( le.Input_d_score = (TYPEOF(le.Input_d_score))'','',':d_score')
    #END
 
+    #IF( #TEXT(Input_best_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_best_ssn = (TYPEOF(le.Input_best_ssn))'','',':best_ssn')
    #END
 
+    #IF( #TEXT(Input_did_out)='' )
      '' 
    #ELSE
        IF( le.Input_did_out = (TYPEOF(le.Input_did_out))'','',':did_out')
    #END
 
+    #IF( #TEXT(Input_bdid_out)='' )
      '' 
    #ELSE
        IF( le.Input_bdid_out = (TYPEOF(le.Input_bdid_out))'','',':bdid_out')
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
 
+    #IF( #TEXT(Input_current_flag)='' )
      '' 
    #ELSE
        IF( le.Input_current_flag = (TYPEOF(le.Input_current_flag))'','',':current_flag')
    #END
 
+    #IF( #TEXT(Input_n_number)='' )
      '' 
    #ELSE
        IF( le.Input_n_number = (TYPEOF(le.Input_n_number))'','',':n_number')
    #END
 
+    #IF( #TEXT(Input_serial_number)='' )
      '' 
    #ELSE
        IF( le.Input_serial_number = (TYPEOF(le.Input_serial_number))'','',':serial_number')
    #END
 
+    #IF( #TEXT(Input_mfr_mdl_code)='' )
      '' 
    #ELSE
        IF( le.Input_mfr_mdl_code = (TYPEOF(le.Input_mfr_mdl_code))'','',':mfr_mdl_code')
    #END
 
+    #IF( #TEXT(Input_eng_mfr_mdl)='' )
      '' 
    #ELSE
        IF( le.Input_eng_mfr_mdl = (TYPEOF(le.Input_eng_mfr_mdl))'','',':eng_mfr_mdl')
    #END
 
+    #IF( #TEXT(Input_year_mfr)='' )
      '' 
    #ELSE
        IF( le.Input_year_mfr = (TYPEOF(le.Input_year_mfr))'','',':year_mfr')
    #END
 
+    #IF( #TEXT(Input_type_registrant)='' )
      '' 
    #ELSE
        IF( le.Input_type_registrant = (TYPEOF(le.Input_type_registrant))'','',':type_registrant')
    #END
 
+    #IF( #TEXT(Input_name)='' )
      '' 
    #ELSE
        IF( le.Input_name = (TYPEOF(le.Input_name))'','',':name')
    #END
 
+    #IF( #TEXT(Input_street)='' )
      '' 
    #ELSE
        IF( le.Input_street = (TYPEOF(le.Input_street))'','',':street')
    #END
 
+    #IF( #TEXT(Input_street2)='' )
      '' 
    #ELSE
        IF( le.Input_street2 = (TYPEOF(le.Input_street2))'','',':street2')
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
 
+    #IF( #TEXT(Input_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_zip_code = (TYPEOF(le.Input_zip_code))'','',':zip_code')
    #END
 
+    #IF( #TEXT(Input_region)='' )
      '' 
    #ELSE
        IF( le.Input_region = (TYPEOF(le.Input_region))'','',':region')
    #END
 
+    #IF( #TEXT(Input_orig_county)='' )
      '' 
    #ELSE
        IF( le.Input_orig_county = (TYPEOF(le.Input_orig_county))'','',':orig_county')
    #END
 
+    #IF( #TEXT(Input_country)='' )
      '' 
    #ELSE
        IF( le.Input_country = (TYPEOF(le.Input_country))'','',':country')
    #END
 
+    #IF( #TEXT(Input_last_action_date)='' )
      '' 
    #ELSE
        IF( le.Input_last_action_date = (TYPEOF(le.Input_last_action_date))'','',':last_action_date')
    #END
 
+    #IF( #TEXT(Input_cert_issue_date)='' )
      '' 
    #ELSE
        IF( le.Input_cert_issue_date = (TYPEOF(le.Input_cert_issue_date))'','',':cert_issue_date')
    #END
 
+    #IF( #TEXT(Input_certification)='' )
      '' 
    #ELSE
        IF( le.Input_certification = (TYPEOF(le.Input_certification))'','',':certification')
    #END
 
+    #IF( #TEXT(Input_type_aircraft)='' )
      '' 
    #ELSE
        IF( le.Input_type_aircraft = (TYPEOF(le.Input_type_aircraft))'','',':type_aircraft')
    #END
 
+    #IF( #TEXT(Input_type_engine)='' )
      '' 
    #ELSE
        IF( le.Input_type_engine = (TYPEOF(le.Input_type_engine))'','',':type_engine')
    #END
 
+    #IF( #TEXT(Input_status_code)='' )
      '' 
    #ELSE
        IF( le.Input_status_code = (TYPEOF(le.Input_status_code))'','',':status_code')
    #END
 
+    #IF( #TEXT(Input_mode_s_code)='' )
      '' 
    #ELSE
        IF( le.Input_mode_s_code = (TYPEOF(le.Input_mode_s_code))'','',':mode_s_code')
    #END
 
+    #IF( #TEXT(Input_fract_owner)='' )
      '' 
    #ELSE
        IF( le.Input_fract_owner = (TYPEOF(le.Input_fract_owner))'','',':fract_owner')
    #END
 
+    #IF( #TEXT(Input_aircraft_mfr_name)='' )
      '' 
    #ELSE
        IF( le.Input_aircraft_mfr_name = (TYPEOF(le.Input_aircraft_mfr_name))'','',':aircraft_mfr_name')
    #END
 
+    #IF( #TEXT(Input_model_name)='' )
      '' 
    #ELSE
        IF( le.Input_model_name = (TYPEOF(le.Input_model_name))'','',':model_name')
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
 
+    #IF( #TEXT(Input_z4)='' )
      '' 
    #ELSE
        IF( le.Input_z4 = (TYPEOF(le.Input_z4))'','',':z4')
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
 
+    #IF( #TEXT(Input_dpbc)='' )
      '' 
    #ELSE
        IF( le.Input_dpbc = (TYPEOF(le.Input_dpbc))'','',':dpbc')
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
 
+    #IF( #TEXT(Input_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_ace_fips_st = (TYPEOF(le.Input_ace_fips_st))'','',':ace_fips_st')
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
 
+    #IF( #TEXT(Input_compname)='' )
      '' 
    #ELSE
        IF( le.Input_compname = (TYPEOF(le.Input_compname))'','',':compname')
    #END
 
+    #IF( #TEXT(Input_lf)='' )
      '' 
    #ELSE
        IF( le.Input_lf = (TYPEOF(le.Input_lf))'','',':lf')
    #END
 
+    #IF( #TEXT(Input_source_rec_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_rec_id = (TYPEOF(le.Input_source_rec_id))'','',':source_rec_id')
    #END
 
+    #IF( #TEXT(Input_dotid)='' )
      '' 
    #ELSE
        IF( le.Input_dotid = (TYPEOF(le.Input_dotid))'','',':dotid')
    #END
 
+    #IF( #TEXT(Input_dotscore)='' )
      '' 
    #ELSE
        IF( le.Input_dotscore = (TYPEOF(le.Input_dotscore))'','',':dotscore')
    #END
 
+    #IF( #TEXT(Input_dotweight)='' )
      '' 
    #ELSE
        IF( le.Input_dotweight = (TYPEOF(le.Input_dotweight))'','',':dotweight')
    #END
 
+    #IF( #TEXT(Input_empid)='' )
      '' 
    #ELSE
        IF( le.Input_empid = (TYPEOF(le.Input_empid))'','',':empid')
    #END
 
+    #IF( #TEXT(Input_empscore)='' )
      '' 
    #ELSE
        IF( le.Input_empscore = (TYPEOF(le.Input_empscore))'','',':empscore')
    #END
 
+    #IF( #TEXT(Input_empweight)='' )
      '' 
    #ELSE
        IF( le.Input_empweight = (TYPEOF(le.Input_empweight))'','',':empweight')
    #END
 
+    #IF( #TEXT(Input_powid)='' )
      '' 
    #ELSE
        IF( le.Input_powid = (TYPEOF(le.Input_powid))'','',':powid')
    #END
 
+    #IF( #TEXT(Input_powscore)='' )
      '' 
    #ELSE
        IF( le.Input_powscore = (TYPEOF(le.Input_powscore))'','',':powscore')
    #END
 
+    #IF( #TEXT(Input_powweight)='' )
      '' 
    #ELSE
        IF( le.Input_powweight = (TYPEOF(le.Input_powweight))'','',':powweight')
    #END
 
+    #IF( #TEXT(Input_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_proxid = (TYPEOF(le.Input_proxid))'','',':proxid')
    #END
 
+    #IF( #TEXT(Input_proxscore)='' )
      '' 
    #ELSE
        IF( le.Input_proxscore = (TYPEOF(le.Input_proxscore))'','',':proxscore')
    #END
 
+    #IF( #TEXT(Input_proxweight)='' )
      '' 
    #ELSE
        IF( le.Input_proxweight = (TYPEOF(le.Input_proxweight))'','',':proxweight')
    #END
 
+    #IF( #TEXT(Input_seleid)='' )
      '' 
    #ELSE
        IF( le.Input_seleid = (TYPEOF(le.Input_seleid))'','',':seleid')
    #END
 
+    #IF( #TEXT(Input_selescore)='' )
      '' 
    #ELSE
        IF( le.Input_selescore = (TYPEOF(le.Input_selescore))'','',':selescore')
    #END
 
+    #IF( #TEXT(Input_seleweight)='' )
      '' 
    #ELSE
        IF( le.Input_seleweight = (TYPEOF(le.Input_seleweight))'','',':seleweight')
    #END
 
+    #IF( #TEXT(Input_orgid)='' )
      '' 
    #ELSE
        IF( le.Input_orgid = (TYPEOF(le.Input_orgid))'','',':orgid')
    #END
 
+    #IF( #TEXT(Input_orgscore)='' )
      '' 
    #ELSE
        IF( le.Input_orgscore = (TYPEOF(le.Input_orgscore))'','',':orgscore')
    #END
 
+    #IF( #TEXT(Input_orgweight)='' )
      '' 
    #ELSE
        IF( le.Input_orgweight = (TYPEOF(le.Input_orgweight))'','',':orgweight')
    #END
 
+    #IF( #TEXT(Input_ultid)='' )
      '' 
    #ELSE
        IF( le.Input_ultid = (TYPEOF(le.Input_ultid))'','',':ultid')
    #END
 
+    #IF( #TEXT(Input_ultscore)='' )
      '' 
    #ELSE
        IF( le.Input_ultscore = (TYPEOF(le.Input_ultscore))'','',':ultscore')
    #END
 
+    #IF( #TEXT(Input_ultweight)='' )
      '' 
    #ELSE
        IF( le.Input_ultweight = (TYPEOF(le.Input_ultweight))'','',':ultweight')
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
