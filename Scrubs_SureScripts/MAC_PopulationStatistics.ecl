EXPORT MAC_PopulationStatistics(infile,Ref='',Input_did = '',Input_did_score = '',Input_bdid = '',Input_bdid_score = '',Input_best_dob = '',Input_best_ssn = '',Input_spi = '',Input_dea = '',Input_statelicensenumber = '',Input_specialtycodeprimary = '',Input_prefixname = '',Input_lastname = '',Input_firstname = '',Input_middlename = '',Input_suffixname = '',Input_clinicname = '',Input_addressline1 = '',Input_addressline2 = '',Input_city = '',Input_state = '',Input_zipcode = '',Input_phoneprimary = '',Input_fax = '',Input_email = '',Input_phonealt1 = '',Input_phonealt1qualifier = '',Input_phonealt2 = '',Input_phonealt2qualifier = '',Input_phonealt3 = '',Input_phonealt3qualifier = '',Input_phonealt4 = '',Input_phonealt4qualifier = '',Input_phonealt5 = '',Input_phonealt5qualifier = '',Input_activestarttime = '',Input_activeendtime = '',Input_servicelevel = '',Input_partneraccount = '',Input_lastmodifieddate = '',Input_recordchange = '',Input_oldservicelevel = '',Input_textservicelevel = '',Input_textservicelevelchange = '',Input_version = '',Input_npi = '',Input_npilocation = '',Input_specialitytype1 = '',Input_specialitytype2 = '',Input_specialitytype3 = '',Input_specialitytype4 = '',Input_fileid = '',Input_medicarenumber = '',Input_medicaidnumber = '',Input_dentistlicensenumber = '',Input_upin = '',Input_pponumber = '',Input_socialsecurity = '',Input_priorauthorization = '',Input_mutuallydefined = '',Input_instorencpdpid = '',Input_spec_code = '',Input_spec_desc = '',Input_activity_code = '',Input_practice_type_code = '',Input_practice_type_desc = '',Input_taxonomy = '',Input_src = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_record_type = '',Input_source_rid = '',Input_lnpid = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_type = '',Input_nid = '',Input_clean_clinic_name = '',Input_prepped_addr1 = '',Input_prepped_addr2 = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_fips_st = '',Input_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_rawaid = '',Input_aceaid = '',Input_clean_phone = '',Input_dotid = '',Input_dotscore = '',Input_dotweight = '',Input_empid = '',Input_empscore = '',Input_empweight = '',Input_powid = '',Input_powscore = '',Input_powweight = '',Input_proxid = '',Input_proxscore = '',Input_proxweight = '',Input_seleid = '',Input_selescore = '',Input_seleweight = '',Input_orgid = '',Input_orgscore = '',Input_orgweight = '',Input_ultid = '',Input_ultscore = '',Input_ultweight = '',OutFile) := MACRO
  IMPORT SALT31,Scrubs_SureScripts;
  #uniquename(of)
  %of% := RECORD
    SALT31.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
+    #IF( #TEXT(Input_did_score)='' )
      '' 
    #ELSE
        IF( le.Input_did_score = (TYPEOF(le.Input_did_score))'','',':did_score')
    #END
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
+    #IF( #TEXT(Input_bdid_score)='' )
      '' 
    #ELSE
        IF( le.Input_bdid_score = (TYPEOF(le.Input_bdid_score))'','',':bdid_score')
    #END
+    #IF( #TEXT(Input_best_dob)='' )
      '' 
    #ELSE
        IF( le.Input_best_dob = (TYPEOF(le.Input_best_dob))'','',':best_dob')
    #END
+    #IF( #TEXT(Input_best_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_best_ssn = (TYPEOF(le.Input_best_ssn))'','',':best_ssn')
    #END
+    #IF( #TEXT(Input_spi)='' )
      '' 
    #ELSE
        IF( le.Input_spi = (TYPEOF(le.Input_spi))'','',':spi')
    #END
+    #IF( #TEXT(Input_dea)='' )
      '' 
    #ELSE
        IF( le.Input_dea = (TYPEOF(le.Input_dea))'','',':dea')
    #END
+    #IF( #TEXT(Input_statelicensenumber)='' )
      '' 
    #ELSE
        IF( le.Input_statelicensenumber = (TYPEOF(le.Input_statelicensenumber))'','',':statelicensenumber')
    #END
+    #IF( #TEXT(Input_specialtycodeprimary)='' )
      '' 
    #ELSE
        IF( le.Input_specialtycodeprimary = (TYPEOF(le.Input_specialtycodeprimary))'','',':specialtycodeprimary')
    #END
+    #IF( #TEXT(Input_prefixname)='' )
      '' 
    #ELSE
        IF( le.Input_prefixname = (TYPEOF(le.Input_prefixname))'','',':prefixname')
    #END
+    #IF( #TEXT(Input_lastname)='' )
      '' 
    #ELSE
        IF( le.Input_lastname = (TYPEOF(le.Input_lastname))'','',':lastname')
    #END
+    #IF( #TEXT(Input_firstname)='' )
      '' 
    #ELSE
        IF( le.Input_firstname = (TYPEOF(le.Input_firstname))'','',':firstname')
    #END
+    #IF( #TEXT(Input_middlename)='' )
      '' 
    #ELSE
        IF( le.Input_middlename = (TYPEOF(le.Input_middlename))'','',':middlename')
    #END
+    #IF( #TEXT(Input_suffixname)='' )
      '' 
    #ELSE
        IF( le.Input_suffixname = (TYPEOF(le.Input_suffixname))'','',':suffixname')
    #END
+    #IF( #TEXT(Input_clinicname)='' )
      '' 
    #ELSE
        IF( le.Input_clinicname = (TYPEOF(le.Input_clinicname))'','',':clinicname')
    #END
+    #IF( #TEXT(Input_addressline1)='' )
      '' 
    #ELSE
        IF( le.Input_addressline1 = (TYPEOF(le.Input_addressline1))'','',':addressline1')
    #END
+    #IF( #TEXT(Input_addressline2)='' )
      '' 
    #ELSE
        IF( le.Input_addressline2 = (TYPEOF(le.Input_addressline2))'','',':addressline2')
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
+    #IF( #TEXT(Input_zipcode)='' )
      '' 
    #ELSE
        IF( le.Input_zipcode = (TYPEOF(le.Input_zipcode))'','',':zipcode')
    #END
+    #IF( #TEXT(Input_phoneprimary)='' )
      '' 
    #ELSE
        IF( le.Input_phoneprimary = (TYPEOF(le.Input_phoneprimary))'','',':phoneprimary')
    #END
+    #IF( #TEXT(Input_fax)='' )
      '' 
    #ELSE
        IF( le.Input_fax = (TYPEOF(le.Input_fax))'','',':fax')
    #END
+    #IF( #TEXT(Input_email)='' )
      '' 
    #ELSE
        IF( le.Input_email = (TYPEOF(le.Input_email))'','',':email')
    #END
+    #IF( #TEXT(Input_phonealt1)='' )
      '' 
    #ELSE
        IF( le.Input_phonealt1 = (TYPEOF(le.Input_phonealt1))'','',':phonealt1')
    #END
+    #IF( #TEXT(Input_phonealt1qualifier)='' )
      '' 
    #ELSE
        IF( le.Input_phonealt1qualifier = (TYPEOF(le.Input_phonealt1qualifier))'','',':phonealt1qualifier')
    #END
+    #IF( #TEXT(Input_phonealt2)='' )
      '' 
    #ELSE
        IF( le.Input_phonealt2 = (TYPEOF(le.Input_phonealt2))'','',':phonealt2')
    #END
+    #IF( #TEXT(Input_phonealt2qualifier)='' )
      '' 
    #ELSE
        IF( le.Input_phonealt2qualifier = (TYPEOF(le.Input_phonealt2qualifier))'','',':phonealt2qualifier')
    #END
+    #IF( #TEXT(Input_phonealt3)='' )
      '' 
    #ELSE
        IF( le.Input_phonealt3 = (TYPEOF(le.Input_phonealt3))'','',':phonealt3')
    #END
+    #IF( #TEXT(Input_phonealt3qualifier)='' )
      '' 
    #ELSE
        IF( le.Input_phonealt3qualifier = (TYPEOF(le.Input_phonealt3qualifier))'','',':phonealt3qualifier')
    #END
+    #IF( #TEXT(Input_phonealt4)='' )
      '' 
    #ELSE
        IF( le.Input_phonealt4 = (TYPEOF(le.Input_phonealt4))'','',':phonealt4')
    #END
+    #IF( #TEXT(Input_phonealt4qualifier)='' )
      '' 
    #ELSE
        IF( le.Input_phonealt4qualifier = (TYPEOF(le.Input_phonealt4qualifier))'','',':phonealt4qualifier')
    #END
+    #IF( #TEXT(Input_phonealt5)='' )
      '' 
    #ELSE
        IF( le.Input_phonealt5 = (TYPEOF(le.Input_phonealt5))'','',':phonealt5')
    #END
+    #IF( #TEXT(Input_phonealt5qualifier)='' )
      '' 
    #ELSE
        IF( le.Input_phonealt5qualifier = (TYPEOF(le.Input_phonealt5qualifier))'','',':phonealt5qualifier')
    #END
+    #IF( #TEXT(Input_activestarttime)='' )
      '' 
    #ELSE
        IF( le.Input_activestarttime = (TYPEOF(le.Input_activestarttime))'','',':activestarttime')
    #END
+    #IF( #TEXT(Input_activeendtime)='' )
      '' 
    #ELSE
        IF( le.Input_activeendtime = (TYPEOF(le.Input_activeendtime))'','',':activeendtime')
    #END
+    #IF( #TEXT(Input_servicelevel)='' )
      '' 
    #ELSE
        IF( le.Input_servicelevel = (TYPEOF(le.Input_servicelevel))'','',':servicelevel')
    #END
+    #IF( #TEXT(Input_partneraccount)='' )
      '' 
    #ELSE
        IF( le.Input_partneraccount = (TYPEOF(le.Input_partneraccount))'','',':partneraccount')
    #END
+    #IF( #TEXT(Input_lastmodifieddate)='' )
      '' 
    #ELSE
        IF( le.Input_lastmodifieddate = (TYPEOF(le.Input_lastmodifieddate))'','',':lastmodifieddate')
    #END
+    #IF( #TEXT(Input_recordchange)='' )
      '' 
    #ELSE
        IF( le.Input_recordchange = (TYPEOF(le.Input_recordchange))'','',':recordchange')
    #END
+    #IF( #TEXT(Input_oldservicelevel)='' )
      '' 
    #ELSE
        IF( le.Input_oldservicelevel = (TYPEOF(le.Input_oldservicelevel))'','',':oldservicelevel')
    #END
+    #IF( #TEXT(Input_textservicelevel)='' )
      '' 
    #ELSE
        IF( le.Input_textservicelevel = (TYPEOF(le.Input_textservicelevel))'','',':textservicelevel')
    #END
+    #IF( #TEXT(Input_textservicelevelchange)='' )
      '' 
    #ELSE
        IF( le.Input_textservicelevelchange = (TYPEOF(le.Input_textservicelevelchange))'','',':textservicelevelchange')
    #END
+    #IF( #TEXT(Input_version)='' )
      '' 
    #ELSE
        IF( le.Input_version = (TYPEOF(le.Input_version))'','',':version')
    #END
+    #IF( #TEXT(Input_npi)='' )
      '' 
    #ELSE
        IF( le.Input_npi = (TYPEOF(le.Input_npi))'','',':npi')
    #END
+    #IF( #TEXT(Input_npilocation)='' )
      '' 
    #ELSE
        IF( le.Input_npilocation = (TYPEOF(le.Input_npilocation))'','',':npilocation')
    #END
+    #IF( #TEXT(Input_specialitytype1)='' )
      '' 
    #ELSE
        IF( le.Input_specialitytype1 = (TYPEOF(le.Input_specialitytype1))'','',':specialitytype1')
    #END
+    #IF( #TEXT(Input_specialitytype2)='' )
      '' 
    #ELSE
        IF( le.Input_specialitytype2 = (TYPEOF(le.Input_specialitytype2))'','',':specialitytype2')
    #END
+    #IF( #TEXT(Input_specialitytype3)='' )
      '' 
    #ELSE
        IF( le.Input_specialitytype3 = (TYPEOF(le.Input_specialitytype3))'','',':specialitytype3')
    #END
+    #IF( #TEXT(Input_specialitytype4)='' )
      '' 
    #ELSE
        IF( le.Input_specialitytype4 = (TYPEOF(le.Input_specialitytype4))'','',':specialitytype4')
    #END
+    #IF( #TEXT(Input_fileid)='' )
      '' 
    #ELSE
        IF( le.Input_fileid = (TYPEOF(le.Input_fileid))'','',':fileid')
    #END
+    #IF( #TEXT(Input_medicarenumber)='' )
      '' 
    #ELSE
        IF( le.Input_medicarenumber = (TYPEOF(le.Input_medicarenumber))'','',':medicarenumber')
    #END
+    #IF( #TEXT(Input_medicaidnumber)='' )
      '' 
    #ELSE
        IF( le.Input_medicaidnumber = (TYPEOF(le.Input_medicaidnumber))'','',':medicaidnumber')
    #END
+    #IF( #TEXT(Input_dentistlicensenumber)='' )
      '' 
    #ELSE
        IF( le.Input_dentistlicensenumber = (TYPEOF(le.Input_dentistlicensenumber))'','',':dentistlicensenumber')
    #END
+    #IF( #TEXT(Input_upin)='' )
      '' 
    #ELSE
        IF( le.Input_upin = (TYPEOF(le.Input_upin))'','',':upin')
    #END
+    #IF( #TEXT(Input_pponumber)='' )
      '' 
    #ELSE
        IF( le.Input_pponumber = (TYPEOF(le.Input_pponumber))'','',':pponumber')
    #END
+    #IF( #TEXT(Input_socialsecurity)='' )
      '' 
    #ELSE
        IF( le.Input_socialsecurity = (TYPEOF(le.Input_socialsecurity))'','',':socialsecurity')
    #END
+    #IF( #TEXT(Input_priorauthorization)='' )
      '' 
    #ELSE
        IF( le.Input_priorauthorization = (TYPEOF(le.Input_priorauthorization))'','',':priorauthorization')
    #END
+    #IF( #TEXT(Input_mutuallydefined)='' )
      '' 
    #ELSE
        IF( le.Input_mutuallydefined = (TYPEOF(le.Input_mutuallydefined))'','',':mutuallydefined')
    #END
+    #IF( #TEXT(Input_instorencpdpid)='' )
      '' 
    #ELSE
        IF( le.Input_instorencpdpid = (TYPEOF(le.Input_instorencpdpid))'','',':instorencpdpid')
    #END
+    #IF( #TEXT(Input_spec_code)='' )
      '' 
    #ELSE
        IF( le.Input_spec_code = (TYPEOF(le.Input_spec_code))'','',':spec_code')
    #END
+    #IF( #TEXT(Input_spec_desc)='' )
      '' 
    #ELSE
        IF( le.Input_spec_desc = (TYPEOF(le.Input_spec_desc))'','',':spec_desc')
    #END
+    #IF( #TEXT(Input_activity_code)='' )
      '' 
    #ELSE
        IF( le.Input_activity_code = (TYPEOF(le.Input_activity_code))'','',':activity_code')
    #END
+    #IF( #TEXT(Input_practice_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_practice_type_code = (TYPEOF(le.Input_practice_type_code))'','',':practice_type_code')
    #END
+    #IF( #TEXT(Input_practice_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_practice_type_desc = (TYPEOF(le.Input_practice_type_desc))'','',':practice_type_desc')
    #END
+    #IF( #TEXT(Input_taxonomy)='' )
      '' 
    #ELSE
        IF( le.Input_taxonomy = (TYPEOF(le.Input_taxonomy))'','',':taxonomy')
    #END
+    #IF( #TEXT(Input_src)='' )
      '' 
    #ELSE
        IF( le.Input_src = (TYPEOF(le.Input_src))'','',':src')
    #END
+    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_first_reported = (TYPEOF(le.Input_dt_vendor_first_reported))'','',':dt_vendor_first_reported')
    #END
+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_last_reported = (TYPEOF(le.Input_dt_vendor_last_reported))'','',':dt_vendor_last_reported')
    #END
+    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
+    #IF( #TEXT(Input_source_rid)='' )
      '' 
    #ELSE
        IF( le.Input_source_rid = (TYPEOF(le.Input_source_rid))'','',':source_rid')
    #END
+    #IF( #TEXT(Input_lnpid)='' )
      '' 
    #ELSE
        IF( le.Input_lnpid = (TYPEOF(le.Input_lnpid))'','',':lnpid')
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
+    #IF( #TEXT(Input_name_type)='' )
      '' 
    #ELSE
        IF( le.Input_name_type = (TYPEOF(le.Input_name_type))'','',':name_type')
    #END
+    #IF( #TEXT(Input_nid)='' )
      '' 
    #ELSE
        IF( le.Input_nid = (TYPEOF(le.Input_nid))'','',':nid')
    #END
+    #IF( #TEXT(Input_clean_clinic_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_clinic_name = (TYPEOF(le.Input_clean_clinic_name))'','',':clean_clinic_name')
    #END
+    #IF( #TEXT(Input_prepped_addr1)='' )
      '' 
    #ELSE
        IF( le.Input_prepped_addr1 = (TYPEOF(le.Input_prepped_addr1))'','',':prepped_addr1')
    #END
+    #IF( #TEXT(Input_prepped_addr2)='' )
      '' 
    #ELSE
        IF( le.Input_prepped_addr2 = (TYPEOF(le.Input_prepped_addr2))'','',':prepped_addr2')
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
+    #IF( #TEXT(Input_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_fips_st = (TYPEOF(le.Input_fips_st))'','',':fips_st')
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
+    #IF( #TEXT(Input_aceaid)='' )
      '' 
    #ELSE
        IF( le.Input_aceaid = (TYPEOF(le.Input_aceaid))'','',':aceaid')
    #END
+    #IF( #TEXT(Input_clean_phone)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phone = (TYPEOF(le.Input_clean_phone))'','',':clean_phone')
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
