EXPORT MAC_PopulationStatistics(infile,Ref='',source_state='',Input_process_date = '',Input_source_state = '',Input_certificate_vol_no = '',Input_certificate_vol_year = '',Input_publication = '',Input_decedent_name = '',Input_decedent_race = '',Input_decedent_origin = '',Input_decedent_sex = '',Input_decedent_age = '',Input_education = '',Input_occupation = '',Input_where_worked = '',Input_cause = '',Input_ssn = '',Input_dob = '',Input_dod = '',Input_birthplace = '',Input_marital_status = '',Input_father = '',Input_mother = '',Input_filed_date = '',Input_year = '',Input_county_residence = '',Input_county_death = '',Input_address = '',Input_autopsy = '',Input_autopsy_findings = '',Input_primary_cause_of_death = '',Input_underlying_cause_of_death = '',Input_med_exam = '',Input_est_lic_no = '',Input_disposition = '',Input_disposition_date = '',Input_work_injury = '',Input_injury_date = '',Input_injury_type = '',Input_injury_location = '',Input_surg_performed = '',Input_surgery_date = '',Input_hospital_status = '',Input_pregnancy = '',Input_facility_death = '',Input_embalmer_lic_no = '',Input_death_type = '',Input_time_death = '',Input_birth_cert = '',Input_certifier = '',Input_cert_number = '',Input_birth_vol_year = '',Input_local_file_no = '',Input_vdi = '',Input_cite_id = '',Input_file_id = '',Input_date_last_trans = '',Input_amendment_code = '',Input_amendment_year = '',Input__on_lexis = '',Input__fs_profile = '',Input_us_armed_forces = '',Input_place_of_death = '',Input_state_death_id = '',Input_state_death_flag = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_state = '',Input_zip5 = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dpbc = '',Input_chk_digit = '',Input_rec_type = '',Input_fips_state = '',Input_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_rawaid = '',Input_orig_address1 = '',Input_orig_address2 = '',Input_statefn = '',Input_lf = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_Death_Master_Supplemental;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(source_state)<>'')
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
+    #IF( #TEXT(Input_source_state)='' )
      '' 
    #ELSE
        IF( le.Input_source_state = (TYPEOF(le.Input_source_state))'','',':source_state')
    #END
+    #IF( #TEXT(Input_certificate_vol_no)='' )
      '' 
    #ELSE
        IF( le.Input_certificate_vol_no = (TYPEOF(le.Input_certificate_vol_no))'','',':certificate_vol_no')
    #END
+    #IF( #TEXT(Input_certificate_vol_year)='' )
      '' 
    #ELSE
        IF( le.Input_certificate_vol_year = (TYPEOF(le.Input_certificate_vol_year))'','',':certificate_vol_year')
    #END
+    #IF( #TEXT(Input_publication)='' )
      '' 
    #ELSE
        IF( le.Input_publication = (TYPEOF(le.Input_publication))'','',':publication')
    #END
+    #IF( #TEXT(Input_decedent_name)='' )
      '' 
    #ELSE
        IF( le.Input_decedent_name = (TYPEOF(le.Input_decedent_name))'','',':decedent_name')
    #END
+    #IF( #TEXT(Input_decedent_race)='' )
      '' 
    #ELSE
        IF( le.Input_decedent_race = (TYPEOF(le.Input_decedent_race))'','',':decedent_race')
    #END
+    #IF( #TEXT(Input_decedent_origin)='' )
      '' 
    #ELSE
        IF( le.Input_decedent_origin = (TYPEOF(le.Input_decedent_origin))'','',':decedent_origin')
    #END
+    #IF( #TEXT(Input_decedent_sex)='' )
      '' 
    #ELSE
        IF( le.Input_decedent_sex = (TYPEOF(le.Input_decedent_sex))'','',':decedent_sex')
    #END
+    #IF( #TEXT(Input_decedent_age)='' )
      '' 
    #ELSE
        IF( le.Input_decedent_age = (TYPEOF(le.Input_decedent_age))'','',':decedent_age')
    #END
+    #IF( #TEXT(Input_education)='' )
      '' 
    #ELSE
        IF( le.Input_education = (TYPEOF(le.Input_education))'','',':education')
    #END
+    #IF( #TEXT(Input_occupation)='' )
      '' 
    #ELSE
        IF( le.Input_occupation = (TYPEOF(le.Input_occupation))'','',':occupation')
    #END
+    #IF( #TEXT(Input_where_worked)='' )
      '' 
    #ELSE
        IF( le.Input_where_worked = (TYPEOF(le.Input_where_worked))'','',':where_worked')
    #END
+    #IF( #TEXT(Input_cause)='' )
      '' 
    #ELSE
        IF( le.Input_cause = (TYPEOF(le.Input_cause))'','',':cause')
    #END
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
+    #IF( #TEXT(Input_dod)='' )
      '' 
    #ELSE
        IF( le.Input_dod = (TYPEOF(le.Input_dod))'','',':dod')
    #END
+    #IF( #TEXT(Input_birthplace)='' )
      '' 
    #ELSE
        IF( le.Input_birthplace = (TYPEOF(le.Input_birthplace))'','',':birthplace')
    #END
+    #IF( #TEXT(Input_marital_status)='' )
      '' 
    #ELSE
        IF( le.Input_marital_status = (TYPEOF(le.Input_marital_status))'','',':marital_status')
    #END
+    #IF( #TEXT(Input_father)='' )
      '' 
    #ELSE
        IF( le.Input_father = (TYPEOF(le.Input_father))'','',':father')
    #END
+    #IF( #TEXT(Input_mother)='' )
      '' 
    #ELSE
        IF( le.Input_mother = (TYPEOF(le.Input_mother))'','',':mother')
    #END
+    #IF( #TEXT(Input_filed_date)='' )
      '' 
    #ELSE
        IF( le.Input_filed_date = (TYPEOF(le.Input_filed_date))'','',':filed_date')
    #END
+    #IF( #TEXT(Input_year)='' )
      '' 
    #ELSE
        IF( le.Input_year = (TYPEOF(le.Input_year))'','',':year')
    #END
+    #IF( #TEXT(Input_county_residence)='' )
      '' 
    #ELSE
        IF( le.Input_county_residence = (TYPEOF(le.Input_county_residence))'','',':county_residence')
    #END
+    #IF( #TEXT(Input_county_death)='' )
      '' 
    #ELSE
        IF( le.Input_county_death = (TYPEOF(le.Input_county_death))'','',':county_death')
    #END
+    #IF( #TEXT(Input_address)='' )
      '' 
    #ELSE
        IF( le.Input_address = (TYPEOF(le.Input_address))'','',':address')
    #END
+    #IF( #TEXT(Input_autopsy)='' )
      '' 
    #ELSE
        IF( le.Input_autopsy = (TYPEOF(le.Input_autopsy))'','',':autopsy')
    #END
+    #IF( #TEXT(Input_autopsy_findings)='' )
      '' 
    #ELSE
        IF( le.Input_autopsy_findings = (TYPEOF(le.Input_autopsy_findings))'','',':autopsy_findings')
    #END
+    #IF( #TEXT(Input_primary_cause_of_death)='' )
      '' 
    #ELSE
        IF( le.Input_primary_cause_of_death = (TYPEOF(le.Input_primary_cause_of_death))'','',':primary_cause_of_death')
    #END
+    #IF( #TEXT(Input_underlying_cause_of_death)='' )
      '' 
    #ELSE
        IF( le.Input_underlying_cause_of_death = (TYPEOF(le.Input_underlying_cause_of_death))'','',':underlying_cause_of_death')
    #END
+    #IF( #TEXT(Input_med_exam)='' )
      '' 
    #ELSE
        IF( le.Input_med_exam = (TYPEOF(le.Input_med_exam))'','',':med_exam')
    #END
+    #IF( #TEXT(Input_est_lic_no)='' )
      '' 
    #ELSE
        IF( le.Input_est_lic_no = (TYPEOF(le.Input_est_lic_no))'','',':est_lic_no')
    #END
+    #IF( #TEXT(Input_disposition)='' )
      '' 
    #ELSE
        IF( le.Input_disposition = (TYPEOF(le.Input_disposition))'','',':disposition')
    #END
+    #IF( #TEXT(Input_disposition_date)='' )
      '' 
    #ELSE
        IF( le.Input_disposition_date = (TYPEOF(le.Input_disposition_date))'','',':disposition_date')
    #END
+    #IF( #TEXT(Input_work_injury)='' )
      '' 
    #ELSE
        IF( le.Input_work_injury = (TYPEOF(le.Input_work_injury))'','',':work_injury')
    #END
+    #IF( #TEXT(Input_injury_date)='' )
      '' 
    #ELSE
        IF( le.Input_injury_date = (TYPEOF(le.Input_injury_date))'','',':injury_date')
    #END
+    #IF( #TEXT(Input_injury_type)='' )
      '' 
    #ELSE
        IF( le.Input_injury_type = (TYPEOF(le.Input_injury_type))'','',':injury_type')
    #END
+    #IF( #TEXT(Input_injury_location)='' )
      '' 
    #ELSE
        IF( le.Input_injury_location = (TYPEOF(le.Input_injury_location))'','',':injury_location')
    #END
+    #IF( #TEXT(Input_surg_performed)='' )
      '' 
    #ELSE
        IF( le.Input_surg_performed = (TYPEOF(le.Input_surg_performed))'','',':surg_performed')
    #END
+    #IF( #TEXT(Input_surgery_date)='' )
      '' 
    #ELSE
        IF( le.Input_surgery_date = (TYPEOF(le.Input_surgery_date))'','',':surgery_date')
    #END
+    #IF( #TEXT(Input_hospital_status)='' )
      '' 
    #ELSE
        IF( le.Input_hospital_status = (TYPEOF(le.Input_hospital_status))'','',':hospital_status')
    #END
+    #IF( #TEXT(Input_pregnancy)='' )
      '' 
    #ELSE
        IF( le.Input_pregnancy = (TYPEOF(le.Input_pregnancy))'','',':pregnancy')
    #END
+    #IF( #TEXT(Input_facility_death)='' )
      '' 
    #ELSE
        IF( le.Input_facility_death = (TYPEOF(le.Input_facility_death))'','',':facility_death')
    #END
+    #IF( #TEXT(Input_embalmer_lic_no)='' )
      '' 
    #ELSE
        IF( le.Input_embalmer_lic_no = (TYPEOF(le.Input_embalmer_lic_no))'','',':embalmer_lic_no')
    #END
+    #IF( #TEXT(Input_death_type)='' )
      '' 
    #ELSE
        IF( le.Input_death_type = (TYPEOF(le.Input_death_type))'','',':death_type')
    #END
+    #IF( #TEXT(Input_time_death)='' )
      '' 
    #ELSE
        IF( le.Input_time_death = (TYPEOF(le.Input_time_death))'','',':time_death')
    #END
+    #IF( #TEXT(Input_birth_cert)='' )
      '' 
    #ELSE
        IF( le.Input_birth_cert = (TYPEOF(le.Input_birth_cert))'','',':birth_cert')
    #END
+    #IF( #TEXT(Input_certifier)='' )
      '' 
    #ELSE
        IF( le.Input_certifier = (TYPEOF(le.Input_certifier))'','',':certifier')
    #END
+    #IF( #TEXT(Input_cert_number)='' )
      '' 
    #ELSE
        IF( le.Input_cert_number = (TYPEOF(le.Input_cert_number))'','',':cert_number')
    #END
+    #IF( #TEXT(Input_birth_vol_year)='' )
      '' 
    #ELSE
        IF( le.Input_birth_vol_year = (TYPEOF(le.Input_birth_vol_year))'','',':birth_vol_year')
    #END
+    #IF( #TEXT(Input_local_file_no)='' )
      '' 
    #ELSE
        IF( le.Input_local_file_no = (TYPEOF(le.Input_local_file_no))'','',':local_file_no')
    #END
+    #IF( #TEXT(Input_vdi)='' )
      '' 
    #ELSE
        IF( le.Input_vdi = (TYPEOF(le.Input_vdi))'','',':vdi')
    #END
+    #IF( #TEXT(Input_cite_id)='' )
      '' 
    #ELSE
        IF( le.Input_cite_id = (TYPEOF(le.Input_cite_id))'','',':cite_id')
    #END
+    #IF( #TEXT(Input_file_id)='' )
      '' 
    #ELSE
        IF( le.Input_file_id = (TYPEOF(le.Input_file_id))'','',':file_id')
    #END
+    #IF( #TEXT(Input_date_last_trans)='' )
      '' 
    #ELSE
        IF( le.Input_date_last_trans = (TYPEOF(le.Input_date_last_trans))'','',':date_last_trans')
    #END
+    #IF( #TEXT(Input_amendment_code)='' )
      '' 
    #ELSE
        IF( le.Input_amendment_code = (TYPEOF(le.Input_amendment_code))'','',':amendment_code')
    #END
+    #IF( #TEXT(Input_amendment_year)='' )
      '' 
    #ELSE
        IF( le.Input_amendment_year = (TYPEOF(le.Input_amendment_year))'','',':amendment_year')
    #END
+    #IF( #TEXT(Input__on_lexis)='' )
      '' 
    #ELSE
        IF( le.Input__on_lexis = (TYPEOF(le.Input__on_lexis))'','',':_on_lexis')
    #END
+    #IF( #TEXT(Input__fs_profile)='' )
      '' 
    #ELSE
        IF( le.Input__fs_profile = (TYPEOF(le.Input__fs_profile))'','',':_fs_profile')
    #END
+    #IF( #TEXT(Input_us_armed_forces)='' )
      '' 
    #ELSE
        IF( le.Input_us_armed_forces = (TYPEOF(le.Input_us_armed_forces))'','',':us_armed_forces')
    #END
+    #IF( #TEXT(Input_place_of_death)='' )
      '' 
    #ELSE
        IF( le.Input_place_of_death = (TYPEOF(le.Input_place_of_death))'','',':place_of_death')
    #END
+    #IF( #TEXT(Input_state_death_id)='' )
      '' 
    #ELSE
        IF( le.Input_state_death_id = (TYPEOF(le.Input_state_death_id))'','',':state_death_id')
    #END
+    #IF( #TEXT(Input_state_death_flag)='' )
      '' 
    #ELSE
        IF( le.Input_state_death_flag = (TYPEOF(le.Input_state_death_flag))'','',':state_death_flag')
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
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
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
+    #IF( #TEXT(Input_fips_state)='' )
      '' 
    #ELSE
        IF( le.Input_fips_state = (TYPEOF(le.Input_fips_state))'','',':fips_state')
    #END
+    #IF( #TEXT(Input_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_fips_county = (TYPEOF(le.Input_fips_county))'','',':fips_county')
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
+    #IF( #TEXT(Input_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_rawaid = (TYPEOF(le.Input_rawaid))'','',':rawaid')
    #END
+    #IF( #TEXT(Input_orig_address1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address1 = (TYPEOF(le.Input_orig_address1))'','',':orig_address1')
    #END
+    #IF( #TEXT(Input_orig_address2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address2 = (TYPEOF(le.Input_orig_address2))'','',':orig_address2')
    #END
+    #IF( #TEXT(Input_statefn)='' )
      '' 
    #ELSE
        IF( le.Input_statefn = (TYPEOF(le.Input_statefn))'','',':statefn')
    #END
+    #IF( #TEXT(Input_lf)='' )
      '' 
    #ELSE
        IF( le.Input_lf = (TYPEOF(le.Input_lf))'','',':lf')
    #END
;
    #IF (#TEXT(source_state)<>'')
    SELF.source := le.source_state;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(source_state)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(source_state)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(source_state)<>'' ) source, #END -cnt );
ENDMACRO;
