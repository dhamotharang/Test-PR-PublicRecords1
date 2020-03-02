 
EXPORT MAC_PopulationStatistics(infile,Ref='',source_code='',Input_date_first_seen = '',Input_date_last_seen = '',Input_date_vendor_first_reported = '',Input_date_vendor_last_reported = '',Input_watercraft_key = '',Input_sequence_key = '',Input_state_origin = '',Input_source_code = '',Input_dppa_flag = '',Input_orig_name = '',Input_orig_name_type_code = '',Input_orig_name_type_description = '',Input_orig_name_first = '',Input_orig_name_middle = '',Input_orig_name_last = '',Input_orig_name_suffix = '',Input_orig_address_1 = '',Input_orig_address_2 = '',Input_orig_city = '',Input_orig_state = '',Input_orig_zip = '',Input_orig_fips = '',Input_orig_province = '',Input_orig_country = '',Input_dob = '',Input_orig_ssn = '',Input_orig_fein = '',Input_gender = '',Input_phone_1 = '',Input_phone_2 = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_cleaning_score = '',Input_company_name = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip5 = '',Input_zip4 = '',Input_county = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dpbc = '',Input_chk_digit = '',Input_rec_type = '',Input_ace_fips_st = '',Input_ace_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_bdid = '',Input_fein = '',Input_did = '',Input_did_score = '',Input_ssn = '',Input_history_flag = '',Input_rawaid = '',Input_reg_owner_name_2 = '',Input_persistent_record_id = '',Input_source_rec_id = '',Input_dotscore = '',Input_dotweight = '',Input_empid = '',Input_empscore = '',Input_empweight = '',Input_powid = '',Input_powscore = '',Input_powweight = '',Input_proxid = '',Input_proxscore = '',Input_proxweight = '',Input_seleid = '',Input_selescore = '',Input_seleweight = '',Input_orgid = '',Input_orgscore = '',Input_orgweight = '',Input_ultid = '',Input_ultscore = '',Input_ultweight = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Watercraft_Search;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(source_code)<>'')
    SALT311.StrType source;
    #END
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_date_first_seen)='' )
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
 
+    #IF( #TEXT(Input_watercraft_key)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_key = (TYPEOF(le.Input_watercraft_key))'','',':watercraft_key')
    #END
 
+    #IF( #TEXT(Input_sequence_key)='' )
      '' 
    #ELSE
        IF( le.Input_sequence_key = (TYPEOF(le.Input_sequence_key))'','',':sequence_key')
    #END
 
+    #IF( #TEXT(Input_state_origin)='' )
      '' 
    #ELSE
        IF( le.Input_state_origin = (TYPEOF(le.Input_state_origin))'','',':state_origin')
    #END
 
+    #IF( #TEXT(Input_source_code)='' )
      '' 
    #ELSE
        IF( le.Input_source_code = (TYPEOF(le.Input_source_code))'','',':source_code')
    #END
 
+    #IF( #TEXT(Input_dppa_flag)='' )
      '' 
    #ELSE
        IF( le.Input_dppa_flag = (TYPEOF(le.Input_dppa_flag))'','',':dppa_flag')
    #END
 
+    #IF( #TEXT(Input_orig_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_name = (TYPEOF(le.Input_orig_name))'','',':orig_name')
    #END
 
+    #IF( #TEXT(Input_orig_name_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_orig_name_type_code = (TYPEOF(le.Input_orig_name_type_code))'','',':orig_name_type_code')
    #END
 
+    #IF( #TEXT(Input_orig_name_type_description)='' )
      '' 
    #ELSE
        IF( le.Input_orig_name_type_description = (TYPEOF(le.Input_orig_name_type_description))'','',':orig_name_type_description')
    #END
 
+    #IF( #TEXT(Input_orig_name_first)='' )
      '' 
    #ELSE
        IF( le.Input_orig_name_first = (TYPEOF(le.Input_orig_name_first))'','',':orig_name_first')
    #END
 
+    #IF( #TEXT(Input_orig_name_middle)='' )
      '' 
    #ELSE
        IF( le.Input_orig_name_middle = (TYPEOF(le.Input_orig_name_middle))'','',':orig_name_middle')
    #END
 
+    #IF( #TEXT(Input_orig_name_last)='' )
      '' 
    #ELSE
        IF( le.Input_orig_name_last = (TYPEOF(le.Input_orig_name_last))'','',':orig_name_last')
    #END
 
+    #IF( #TEXT(Input_orig_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_orig_name_suffix = (TYPEOF(le.Input_orig_name_suffix))'','',':orig_name_suffix')
    #END
 
+    #IF( #TEXT(Input_orig_address_1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address_1 = (TYPEOF(le.Input_orig_address_1))'','',':orig_address_1')
    #END
 
+    #IF( #TEXT(Input_orig_address_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address_2 = (TYPEOF(le.Input_orig_address_2))'','',':orig_address_2')
    #END
 
+    #IF( #TEXT(Input_orig_city)='' )
      '' 
    #ELSE
        IF( le.Input_orig_city = (TYPEOF(le.Input_orig_city))'','',':orig_city')
    #END
 
+    #IF( #TEXT(Input_orig_state)='' )
      '' 
    #ELSE
        IF( le.Input_orig_state = (TYPEOF(le.Input_orig_state))'','',':orig_state')
    #END
 
+    #IF( #TEXT(Input_orig_zip)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip = (TYPEOF(le.Input_orig_zip))'','',':orig_zip')
    #END
 
+    #IF( #TEXT(Input_orig_fips)='' )
      '' 
    #ELSE
        IF( le.Input_orig_fips = (TYPEOF(le.Input_orig_fips))'','',':orig_fips')
    #END
 
+    #IF( #TEXT(Input_orig_province)='' )
      '' 
    #ELSE
        IF( le.Input_orig_province = (TYPEOF(le.Input_orig_province))'','',':orig_province')
    #END
 
+    #IF( #TEXT(Input_orig_country)='' )
      '' 
    #ELSE
        IF( le.Input_orig_country = (TYPEOF(le.Input_orig_country))'','',':orig_country')
    #END
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_orig_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_orig_ssn = (TYPEOF(le.Input_orig_ssn))'','',':orig_ssn')
    #END
 
+    #IF( #TEXT(Input_orig_fein)='' )
      '' 
    #ELSE
        IF( le.Input_orig_fein = (TYPEOF(le.Input_orig_fein))'','',':orig_fein')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_phone_1)='' )
      '' 
    #ELSE
        IF( le.Input_phone_1 = (TYPEOF(le.Input_phone_1))'','',':phone_1')
    #END
 
+    #IF( #TEXT(Input_phone_2)='' )
      '' 
    #ELSE
        IF( le.Input_phone_2 = (TYPEOF(le.Input_phone_2))'','',':phone_2')
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
 
+    #IF( #TEXT(Input_name_cleaning_score)='' )
      '' 
    #ELSE
        IF( le.Input_name_cleaning_score = (TYPEOF(le.Input_name_cleaning_score))'','',':name_cleaning_score')
    #END
 
+    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (TYPEOF(le.Input_company_name))'','',':company_name')
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
 
+    #IF( #TEXT(Input_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_zip5 = (TYPEOF(le.Input_zip5))'','',':zip5')
    #END
 
+    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
 
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
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
 
+    #IF( #TEXT(Input_ace_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_ace_fips_county = (TYPEOF(le.Input_ace_fips_county))'','',':ace_fips_county')
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
 
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
 
+    #IF( #TEXT(Input_fein)='' )
      '' 
    #ELSE
        IF( le.Input_fein = (TYPEOF(le.Input_fein))'','',':fein')
    #END
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_did_score)='' )
      '' 
    #ELSE
        IF( le.Input_did_score = (TYPEOF(le.Input_did_score))'','',':did_score')
    #END
 
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
 
+    #IF( #TEXT(Input_history_flag)='' )
      '' 
    #ELSE
        IF( le.Input_history_flag = (TYPEOF(le.Input_history_flag))'','',':history_flag')
    #END
 
+    #IF( #TEXT(Input_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_rawaid = (TYPEOF(le.Input_rawaid))'','',':rawaid')
    #END
 
+    #IF( #TEXT(Input_reg_owner_name_2)='' )
      '' 
    #ELSE
        IF( le.Input_reg_owner_name_2 = (TYPEOF(le.Input_reg_owner_name_2))'','',':reg_owner_name_2')
    #END
 
+    #IF( #TEXT(Input_persistent_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_persistent_record_id = (TYPEOF(le.Input_persistent_record_id))'','',':persistent_record_id')
    #END
 
+    #IF( #TEXT(Input_source_rec_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_rec_id = (TYPEOF(le.Input_source_rec_id))'','',':source_rec_id')
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
    #IF (#TEXT(source_code)<>'')
    SELF.source := le.source_code;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(source_code)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(source_code)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(source_code)<>'' ) source, #END -cnt );
ENDMACRO;
