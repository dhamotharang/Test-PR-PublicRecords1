 
EXPORT Hunters_MAC_PopulationStatistics(infile,Ref='',Input_persistent_record_id = '',Input_process_date = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_score = '',Input_best_ssn = '',Input_did_out = '',Input_source = '',Input_file_id = '',Input_vendor_id = '',Input_source_state = '',Input_source_code = '',Input_file_acquired_date = '',Input__use = '',Input_title_in = '',Input_lname_in = '',Input_fname_in = '',Input_mname_in = '',Input_maiden_prior = '',Input_name_suffix_in = '',Input_votefiller = '',Input_source_voterid = '',Input_dob = '',Input_agecat = '',Input_headhousehold = '',Input_place_of_birth = '',Input_occupation = '',Input_maiden_name = '',Input_motorvoterid = '',Input_regsource = '',Input_regdate = '',Input_race = '',Input_gender = '',Input_poliparty = '',Input_phone = '',Input_work_phone = '',Input_other_phone = '',Input_active_status = '',Input_votefiller2 = '',Input_active_other = '',Input_voterstatus = '',Input_resaddr1 = '',Input_resaddr2 = '',Input_res_city = '',Input_res_state = '',Input_res_zip = '',Input_res_county = '',Input_mail_addr1 = '',Input_mail_addr2 = '',Input_mail_city = '',Input_mail_state = '',Input_mail_zip = '',Input_mail_county = '',Input_historyfiller = '',Input_huntfishperm = '',Input_license_type_mapped = '',Input_datelicense = '',Input_homestate = '',Input_resident = '',Input_nonresident = '',Input_hunt = '',Input_fish = '',Input_combosuper = '',Input_sportsman = '',Input_trap = '',Input_archery = '',Input_muzzle = '',Input_drawing = '',Input_day1 = '',Input_day3 = '',Input_day7 = '',Input_day14to15 = '',Input_dayfiller = '',Input_seasonannual = '',Input_lifetimepermit = '',Input_landowner = '',Input_family = '',Input_junior = '',Input_seniorcit = '',Input_crewmemeber = '',Input_retarded = '',Input_indian = '',Input_serviceman = '',Input_disabled = '',Input_lowincome = '',Input_regioncounty = '',Input_blind = '',Input_huntfiller = '',Input_salmon = '',Input_freshwater = '',Input_saltwater = '',Input_lakesandresevoirs = '',Input_setlinefish = '',Input_trout = '',Input_fallfishing = '',Input_steelhead = '',Input_whitejubherring = '',Input_sturgeon = '',Input_shellfishcrab = '',Input_shellfishlobster = '',Input_deer = '',Input_bear = '',Input_elk = '',Input_moose = '',Input_buffalo = '',Input_antelope = '',Input_sikebull = '',Input_bighorn = '',Input_javelina = '',Input_cougar = '',Input_anterless = '',Input_pheasant = '',Input_goose = '',Input_duck = '',Input_turkey = '',Input_snowmobile = '',Input_biggame = '',Input_skipass = '',Input_migbird = '',Input_smallgame = '',Input_sturgeon2 = '',Input_gun = '',Input_bonus = '',Input_lottery = '',Input_otherbirds = '',Input_huntfill1 = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_score_on_input = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dpbc = '',Input_chk_digit = '',Input_record_type = '',Input_ace_fips_st = '',Input_county = '',Input_county_name = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_mail_prim_range = '',Input_mail_predir = '',Input_mail_prim_name = '',Input_mail_addr_suffix = '',Input_mail_postdir = '',Input_mail_unit_desig = '',Input_mail_sec_range = '',Input_mail_p_city_name = '',Input_mail_v_city_name = '',Input_mail_st = '',Input_mail_ace_zip = '',Input_mail_zip4 = '',Input_mail_cart = '',Input_mail_cr_sort_sz = '',Input_mail_lot = '',Input_mail_lot_order = '',Input_mail_dpbc = '',Input_mail_chk_digit = '',Input_mail_record_type = '',Input_mail_ace_fips_st = '',Input_mail_fipscounty = '',Input_mail_geo_lat = '',Input_mail_geo_long = '',Input_mail_msa = '',Input_mail_geo_blk = '',Input_mail_geo_match = '',Input_mail_err_stat = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_eMerges;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_persistent_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_persistent_record_id = (TYPEOF(le.Input_persistent_record_id))'','',':persistent_record_id')
    #END
 
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
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
 
+    #IF( #TEXT(Input_score)='' )
      '' 
    #ELSE
        IF( le.Input_score = (TYPEOF(le.Input_score))'','',':score')
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
 
+    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
    #END
 
+    #IF( #TEXT(Input_file_id)='' )
      '' 
    #ELSE
        IF( le.Input_file_id = (TYPEOF(le.Input_file_id))'','',':file_id')
    #END
 
+    #IF( #TEXT(Input_vendor_id)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_id = (TYPEOF(le.Input_vendor_id))'','',':vendor_id')
    #END
 
+    #IF( #TEXT(Input_source_state)='' )
      '' 
    #ELSE
        IF( le.Input_source_state = (TYPEOF(le.Input_source_state))'','',':source_state')
    #END
 
+    #IF( #TEXT(Input_source_code)='' )
      '' 
    #ELSE
        IF( le.Input_source_code = (TYPEOF(le.Input_source_code))'','',':source_code')
    #END
 
+    #IF( #TEXT(Input_file_acquired_date)='' )
      '' 
    #ELSE
        IF( le.Input_file_acquired_date = (TYPEOF(le.Input_file_acquired_date))'','',':file_acquired_date')
    #END
 
+    #IF( #TEXT(Input__use)='' )
      '' 
    #ELSE
        IF( le.Input__use = (TYPEOF(le.Input__use))'','',':_use')
    #END
 
+    #IF( #TEXT(Input_title_in)='' )
      '' 
    #ELSE
        IF( le.Input_title_in = (TYPEOF(le.Input_title_in))'','',':title_in')
    #END
 
+    #IF( #TEXT(Input_lname_in)='' )
      '' 
    #ELSE
        IF( le.Input_lname_in = (TYPEOF(le.Input_lname_in))'','',':lname_in')
    #END
 
+    #IF( #TEXT(Input_fname_in)='' )
      '' 
    #ELSE
        IF( le.Input_fname_in = (TYPEOF(le.Input_fname_in))'','',':fname_in')
    #END
 
+    #IF( #TEXT(Input_mname_in)='' )
      '' 
    #ELSE
        IF( le.Input_mname_in = (TYPEOF(le.Input_mname_in))'','',':mname_in')
    #END
 
+    #IF( #TEXT(Input_maiden_prior)='' )
      '' 
    #ELSE
        IF( le.Input_maiden_prior = (TYPEOF(le.Input_maiden_prior))'','',':maiden_prior')
    #END
 
+    #IF( #TEXT(Input_name_suffix_in)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix_in = (TYPEOF(le.Input_name_suffix_in))'','',':name_suffix_in')
    #END
 
+    #IF( #TEXT(Input_votefiller)='' )
      '' 
    #ELSE
        IF( le.Input_votefiller = (TYPEOF(le.Input_votefiller))'','',':votefiller')
    #END
 
+    #IF( #TEXT(Input_source_voterid)='' )
      '' 
    #ELSE
        IF( le.Input_source_voterid = (TYPEOF(le.Input_source_voterid))'','',':source_voterid')
    #END
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_agecat)='' )
      '' 
    #ELSE
        IF( le.Input_agecat = (TYPEOF(le.Input_agecat))'','',':agecat')
    #END
 
+    #IF( #TEXT(Input_headhousehold)='' )
      '' 
    #ELSE
        IF( le.Input_headhousehold = (TYPEOF(le.Input_headhousehold))'','',':headhousehold')
    #END
 
+    #IF( #TEXT(Input_place_of_birth)='' )
      '' 
    #ELSE
        IF( le.Input_place_of_birth = (TYPEOF(le.Input_place_of_birth))'','',':place_of_birth')
    #END
 
+    #IF( #TEXT(Input_occupation)='' )
      '' 
    #ELSE
        IF( le.Input_occupation = (TYPEOF(le.Input_occupation))'','',':occupation')
    #END
 
+    #IF( #TEXT(Input_maiden_name)='' )
      '' 
    #ELSE
        IF( le.Input_maiden_name = (TYPEOF(le.Input_maiden_name))'','',':maiden_name')
    #END
 
+    #IF( #TEXT(Input_motorvoterid)='' )
      '' 
    #ELSE
        IF( le.Input_motorvoterid = (TYPEOF(le.Input_motorvoterid))'','',':motorvoterid')
    #END
 
+    #IF( #TEXT(Input_regsource)='' )
      '' 
    #ELSE
        IF( le.Input_regsource = (TYPEOF(le.Input_regsource))'','',':regsource')
    #END
 
+    #IF( #TEXT(Input_regdate)='' )
      '' 
    #ELSE
        IF( le.Input_regdate = (TYPEOF(le.Input_regdate))'','',':regdate')
    #END
 
+    #IF( #TEXT(Input_race)='' )
      '' 
    #ELSE
        IF( le.Input_race = (TYPEOF(le.Input_race))'','',':race')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_poliparty)='' )
      '' 
    #ELSE
        IF( le.Input_poliparty = (TYPEOF(le.Input_poliparty))'','',':poliparty')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_work_phone)='' )
      '' 
    #ELSE
        IF( le.Input_work_phone = (TYPEOF(le.Input_work_phone))'','',':work_phone')
    #END
 
+    #IF( #TEXT(Input_other_phone)='' )
      '' 
    #ELSE
        IF( le.Input_other_phone = (TYPEOF(le.Input_other_phone))'','',':other_phone')
    #END
 
+    #IF( #TEXT(Input_active_status)='' )
      '' 
    #ELSE
        IF( le.Input_active_status = (TYPEOF(le.Input_active_status))'','',':active_status')
    #END
 
+    #IF( #TEXT(Input_votefiller2)='' )
      '' 
    #ELSE
        IF( le.Input_votefiller2 = (TYPEOF(le.Input_votefiller2))'','',':votefiller2')
    #END
 
+    #IF( #TEXT(Input_active_other)='' )
      '' 
    #ELSE
        IF( le.Input_active_other = (TYPEOF(le.Input_active_other))'','',':active_other')
    #END
 
+    #IF( #TEXT(Input_voterstatus)='' )
      '' 
    #ELSE
        IF( le.Input_voterstatus = (TYPEOF(le.Input_voterstatus))'','',':voterstatus')
    #END
 
+    #IF( #TEXT(Input_resaddr1)='' )
      '' 
    #ELSE
        IF( le.Input_resaddr1 = (TYPEOF(le.Input_resaddr1))'','',':resaddr1')
    #END
 
+    #IF( #TEXT(Input_resaddr2)='' )
      '' 
    #ELSE
        IF( le.Input_resaddr2 = (TYPEOF(le.Input_resaddr2))'','',':resaddr2')
    #END
 
+    #IF( #TEXT(Input_res_city)='' )
      '' 
    #ELSE
        IF( le.Input_res_city = (TYPEOF(le.Input_res_city))'','',':res_city')
    #END
 
+    #IF( #TEXT(Input_res_state)='' )
      '' 
    #ELSE
        IF( le.Input_res_state = (TYPEOF(le.Input_res_state))'','',':res_state')
    #END
 
+    #IF( #TEXT(Input_res_zip)='' )
      '' 
    #ELSE
        IF( le.Input_res_zip = (TYPEOF(le.Input_res_zip))'','',':res_zip')
    #END
 
+    #IF( #TEXT(Input_res_county)='' )
      '' 
    #ELSE
        IF( le.Input_res_county = (TYPEOF(le.Input_res_county))'','',':res_county')
    #END
 
+    #IF( #TEXT(Input_mail_addr1)='' )
      '' 
    #ELSE
        IF( le.Input_mail_addr1 = (TYPEOF(le.Input_mail_addr1))'','',':mail_addr1')
    #END
 
+    #IF( #TEXT(Input_mail_addr2)='' )
      '' 
    #ELSE
        IF( le.Input_mail_addr2 = (TYPEOF(le.Input_mail_addr2))'','',':mail_addr2')
    #END
 
+    #IF( #TEXT(Input_mail_city)='' )
      '' 
    #ELSE
        IF( le.Input_mail_city = (TYPEOF(le.Input_mail_city))'','',':mail_city')
    #END
 
+    #IF( #TEXT(Input_mail_state)='' )
      '' 
    #ELSE
        IF( le.Input_mail_state = (TYPEOF(le.Input_mail_state))'','',':mail_state')
    #END
 
+    #IF( #TEXT(Input_mail_zip)='' )
      '' 
    #ELSE
        IF( le.Input_mail_zip = (TYPEOF(le.Input_mail_zip))'','',':mail_zip')
    #END
 
+    #IF( #TEXT(Input_mail_county)='' )
      '' 
    #ELSE
        IF( le.Input_mail_county = (TYPEOF(le.Input_mail_county))'','',':mail_county')
    #END
 
+    #IF( #TEXT(Input_historyfiller)='' )
      '' 
    #ELSE
        IF( le.Input_historyfiller = (TYPEOF(le.Input_historyfiller))'','',':historyfiller')
    #END
 
+    #IF( #TEXT(Input_huntfishperm)='' )
      '' 
    #ELSE
        IF( le.Input_huntfishperm = (TYPEOF(le.Input_huntfishperm))'','',':huntfishperm')
    #END
 
+    #IF( #TEXT(Input_license_type_mapped)='' )
      '' 
    #ELSE
        IF( le.Input_license_type_mapped = (TYPEOF(le.Input_license_type_mapped))'','',':license_type_mapped')
    #END
 
+    #IF( #TEXT(Input_datelicense)='' )
      '' 
    #ELSE
        IF( le.Input_datelicense = (TYPEOF(le.Input_datelicense))'','',':datelicense')
    #END
 
+    #IF( #TEXT(Input_homestate)='' )
      '' 
    #ELSE
        IF( le.Input_homestate = (TYPEOF(le.Input_homestate))'','',':homestate')
    #END
 
+    #IF( #TEXT(Input_resident)='' )
      '' 
    #ELSE
        IF( le.Input_resident = (TYPEOF(le.Input_resident))'','',':resident')
    #END
 
+    #IF( #TEXT(Input_nonresident)='' )
      '' 
    #ELSE
        IF( le.Input_nonresident = (TYPEOF(le.Input_nonresident))'','',':nonresident')
    #END
 
+    #IF( #TEXT(Input_hunt)='' )
      '' 
    #ELSE
        IF( le.Input_hunt = (TYPEOF(le.Input_hunt))'','',':hunt')
    #END
 
+    #IF( #TEXT(Input_fish)='' )
      '' 
    #ELSE
        IF( le.Input_fish = (TYPEOF(le.Input_fish))'','',':fish')
    #END
 
+    #IF( #TEXT(Input_combosuper)='' )
      '' 
    #ELSE
        IF( le.Input_combosuper = (TYPEOF(le.Input_combosuper))'','',':combosuper')
    #END
 
+    #IF( #TEXT(Input_sportsman)='' )
      '' 
    #ELSE
        IF( le.Input_sportsman = (TYPEOF(le.Input_sportsman))'','',':sportsman')
    #END
 
+    #IF( #TEXT(Input_trap)='' )
      '' 
    #ELSE
        IF( le.Input_trap = (TYPEOF(le.Input_trap))'','',':trap')
    #END
 
+    #IF( #TEXT(Input_archery)='' )
      '' 
    #ELSE
        IF( le.Input_archery = (TYPEOF(le.Input_archery))'','',':archery')
    #END
 
+    #IF( #TEXT(Input_muzzle)='' )
      '' 
    #ELSE
        IF( le.Input_muzzle = (TYPEOF(le.Input_muzzle))'','',':muzzle')
    #END
 
+    #IF( #TEXT(Input_drawing)='' )
      '' 
    #ELSE
        IF( le.Input_drawing = (TYPEOF(le.Input_drawing))'','',':drawing')
    #END
 
+    #IF( #TEXT(Input_day1)='' )
      '' 
    #ELSE
        IF( le.Input_day1 = (TYPEOF(le.Input_day1))'','',':day1')
    #END
 
+    #IF( #TEXT(Input_day3)='' )
      '' 
    #ELSE
        IF( le.Input_day3 = (TYPEOF(le.Input_day3))'','',':day3')
    #END
 
+    #IF( #TEXT(Input_day7)='' )
      '' 
    #ELSE
        IF( le.Input_day7 = (TYPEOF(le.Input_day7))'','',':day7')
    #END
 
+    #IF( #TEXT(Input_day14to15)='' )
      '' 
    #ELSE
        IF( le.Input_day14to15 = (TYPEOF(le.Input_day14to15))'','',':day14to15')
    #END
 
+    #IF( #TEXT(Input_dayfiller)='' )
      '' 
    #ELSE
        IF( le.Input_dayfiller = (TYPEOF(le.Input_dayfiller))'','',':dayfiller')
    #END
 
+    #IF( #TEXT(Input_seasonannual)='' )
      '' 
    #ELSE
        IF( le.Input_seasonannual = (TYPEOF(le.Input_seasonannual))'','',':seasonannual')
    #END
 
+    #IF( #TEXT(Input_lifetimepermit)='' )
      '' 
    #ELSE
        IF( le.Input_lifetimepermit = (TYPEOF(le.Input_lifetimepermit))'','',':lifetimepermit')
    #END
 
+    #IF( #TEXT(Input_landowner)='' )
      '' 
    #ELSE
        IF( le.Input_landowner = (TYPEOF(le.Input_landowner))'','',':landowner')
    #END
 
+    #IF( #TEXT(Input_family)='' )
      '' 
    #ELSE
        IF( le.Input_family = (TYPEOF(le.Input_family))'','',':family')
    #END
 
+    #IF( #TEXT(Input_junior)='' )
      '' 
    #ELSE
        IF( le.Input_junior = (TYPEOF(le.Input_junior))'','',':junior')
    #END
 
+    #IF( #TEXT(Input_seniorcit)='' )
      '' 
    #ELSE
        IF( le.Input_seniorcit = (TYPEOF(le.Input_seniorcit))'','',':seniorcit')
    #END
 
+    #IF( #TEXT(Input_crewmemeber)='' )
      '' 
    #ELSE
        IF( le.Input_crewmemeber = (TYPEOF(le.Input_crewmemeber))'','',':crewmemeber')
    #END
 
+    #IF( #TEXT(Input_retarded)='' )
      '' 
    #ELSE
        IF( le.Input_retarded = (TYPEOF(le.Input_retarded))'','',':retarded')
    #END
 
+    #IF( #TEXT(Input_indian)='' )
      '' 
    #ELSE
        IF( le.Input_indian = (TYPEOF(le.Input_indian))'','',':indian')
    #END
 
+    #IF( #TEXT(Input_serviceman)='' )
      '' 
    #ELSE
        IF( le.Input_serviceman = (TYPEOF(le.Input_serviceman))'','',':serviceman')
    #END
 
+    #IF( #TEXT(Input_disabled)='' )
      '' 
    #ELSE
        IF( le.Input_disabled = (TYPEOF(le.Input_disabled))'','',':disabled')
    #END
 
+    #IF( #TEXT(Input_lowincome)='' )
      '' 
    #ELSE
        IF( le.Input_lowincome = (TYPEOF(le.Input_lowincome))'','',':lowincome')
    #END
 
+    #IF( #TEXT(Input_regioncounty)='' )
      '' 
    #ELSE
        IF( le.Input_regioncounty = (TYPEOF(le.Input_regioncounty))'','',':regioncounty')
    #END
 
+    #IF( #TEXT(Input_blind)='' )
      '' 
    #ELSE
        IF( le.Input_blind = (TYPEOF(le.Input_blind))'','',':blind')
    #END
 
+    #IF( #TEXT(Input_huntfiller)='' )
      '' 
    #ELSE
        IF( le.Input_huntfiller = (TYPEOF(le.Input_huntfiller))'','',':huntfiller')
    #END
 
+    #IF( #TEXT(Input_salmon)='' )
      '' 
    #ELSE
        IF( le.Input_salmon = (TYPEOF(le.Input_salmon))'','',':salmon')
    #END
 
+    #IF( #TEXT(Input_freshwater)='' )
      '' 
    #ELSE
        IF( le.Input_freshwater = (TYPEOF(le.Input_freshwater))'','',':freshwater')
    #END
 
+    #IF( #TEXT(Input_saltwater)='' )
      '' 
    #ELSE
        IF( le.Input_saltwater = (TYPEOF(le.Input_saltwater))'','',':saltwater')
    #END
 
+    #IF( #TEXT(Input_lakesandresevoirs)='' )
      '' 
    #ELSE
        IF( le.Input_lakesandresevoirs = (TYPEOF(le.Input_lakesandresevoirs))'','',':lakesandresevoirs')
    #END
 
+    #IF( #TEXT(Input_setlinefish)='' )
      '' 
    #ELSE
        IF( le.Input_setlinefish = (TYPEOF(le.Input_setlinefish))'','',':setlinefish')
    #END
 
+    #IF( #TEXT(Input_trout)='' )
      '' 
    #ELSE
        IF( le.Input_trout = (TYPEOF(le.Input_trout))'','',':trout')
    #END
 
+    #IF( #TEXT(Input_fallfishing)='' )
      '' 
    #ELSE
        IF( le.Input_fallfishing = (TYPEOF(le.Input_fallfishing))'','',':fallfishing')
    #END
 
+    #IF( #TEXT(Input_steelhead)='' )
      '' 
    #ELSE
        IF( le.Input_steelhead = (TYPEOF(le.Input_steelhead))'','',':steelhead')
    #END
 
+    #IF( #TEXT(Input_whitejubherring)='' )
      '' 
    #ELSE
        IF( le.Input_whitejubherring = (TYPEOF(le.Input_whitejubherring))'','',':whitejubherring')
    #END
 
+    #IF( #TEXT(Input_sturgeon)='' )
      '' 
    #ELSE
        IF( le.Input_sturgeon = (TYPEOF(le.Input_sturgeon))'','',':sturgeon')
    #END
 
+    #IF( #TEXT(Input_shellfishcrab)='' )
      '' 
    #ELSE
        IF( le.Input_shellfishcrab = (TYPEOF(le.Input_shellfishcrab))'','',':shellfishcrab')
    #END
 
+    #IF( #TEXT(Input_shellfishlobster)='' )
      '' 
    #ELSE
        IF( le.Input_shellfishlobster = (TYPEOF(le.Input_shellfishlobster))'','',':shellfishlobster')
    #END
 
+    #IF( #TEXT(Input_deer)='' )
      '' 
    #ELSE
        IF( le.Input_deer = (TYPEOF(le.Input_deer))'','',':deer')
    #END
 
+    #IF( #TEXT(Input_bear)='' )
      '' 
    #ELSE
        IF( le.Input_bear = (TYPEOF(le.Input_bear))'','',':bear')
    #END
 
+    #IF( #TEXT(Input_elk)='' )
      '' 
    #ELSE
        IF( le.Input_elk = (TYPEOF(le.Input_elk))'','',':elk')
    #END
 
+    #IF( #TEXT(Input_moose)='' )
      '' 
    #ELSE
        IF( le.Input_moose = (TYPEOF(le.Input_moose))'','',':moose')
    #END
 
+    #IF( #TEXT(Input_buffalo)='' )
      '' 
    #ELSE
        IF( le.Input_buffalo = (TYPEOF(le.Input_buffalo))'','',':buffalo')
    #END
 
+    #IF( #TEXT(Input_antelope)='' )
      '' 
    #ELSE
        IF( le.Input_antelope = (TYPEOF(le.Input_antelope))'','',':antelope')
    #END
 
+    #IF( #TEXT(Input_sikebull)='' )
      '' 
    #ELSE
        IF( le.Input_sikebull = (TYPEOF(le.Input_sikebull))'','',':sikebull')
    #END
 
+    #IF( #TEXT(Input_bighorn)='' )
      '' 
    #ELSE
        IF( le.Input_bighorn = (TYPEOF(le.Input_bighorn))'','',':bighorn')
    #END
 
+    #IF( #TEXT(Input_javelina)='' )
      '' 
    #ELSE
        IF( le.Input_javelina = (TYPEOF(le.Input_javelina))'','',':javelina')
    #END
 
+    #IF( #TEXT(Input_cougar)='' )
      '' 
    #ELSE
        IF( le.Input_cougar = (TYPEOF(le.Input_cougar))'','',':cougar')
    #END
 
+    #IF( #TEXT(Input_anterless)='' )
      '' 
    #ELSE
        IF( le.Input_anterless = (TYPEOF(le.Input_anterless))'','',':anterless')
    #END
 
+    #IF( #TEXT(Input_pheasant)='' )
      '' 
    #ELSE
        IF( le.Input_pheasant = (TYPEOF(le.Input_pheasant))'','',':pheasant')
    #END
 
+    #IF( #TEXT(Input_goose)='' )
      '' 
    #ELSE
        IF( le.Input_goose = (TYPEOF(le.Input_goose))'','',':goose')
    #END
 
+    #IF( #TEXT(Input_duck)='' )
      '' 
    #ELSE
        IF( le.Input_duck = (TYPEOF(le.Input_duck))'','',':duck')
    #END
 
+    #IF( #TEXT(Input_turkey)='' )
      '' 
    #ELSE
        IF( le.Input_turkey = (TYPEOF(le.Input_turkey))'','',':turkey')
    #END
 
+    #IF( #TEXT(Input_snowmobile)='' )
      '' 
    #ELSE
        IF( le.Input_snowmobile = (TYPEOF(le.Input_snowmobile))'','',':snowmobile')
    #END
 
+    #IF( #TEXT(Input_biggame)='' )
      '' 
    #ELSE
        IF( le.Input_biggame = (TYPEOF(le.Input_biggame))'','',':biggame')
    #END
 
+    #IF( #TEXT(Input_skipass)='' )
      '' 
    #ELSE
        IF( le.Input_skipass = (TYPEOF(le.Input_skipass))'','',':skipass')
    #END
 
+    #IF( #TEXT(Input_migbird)='' )
      '' 
    #ELSE
        IF( le.Input_migbird = (TYPEOF(le.Input_migbird))'','',':migbird')
    #END
 
+    #IF( #TEXT(Input_smallgame)='' )
      '' 
    #ELSE
        IF( le.Input_smallgame = (TYPEOF(le.Input_smallgame))'','',':smallgame')
    #END
 
+    #IF( #TEXT(Input_sturgeon2)='' )
      '' 
    #ELSE
        IF( le.Input_sturgeon2 = (TYPEOF(le.Input_sturgeon2))'','',':sturgeon2')
    #END
 
+    #IF( #TEXT(Input_gun)='' )
      '' 
    #ELSE
        IF( le.Input_gun = (TYPEOF(le.Input_gun))'','',':gun')
    #END
 
+    #IF( #TEXT(Input_bonus)='' )
      '' 
    #ELSE
        IF( le.Input_bonus = (TYPEOF(le.Input_bonus))'','',':bonus')
    #END
 
+    #IF( #TEXT(Input_lottery)='' )
      '' 
    #ELSE
        IF( le.Input_lottery = (TYPEOF(le.Input_lottery))'','',':lottery')
    #END
 
+    #IF( #TEXT(Input_otherbirds)='' )
      '' 
    #ELSE
        IF( le.Input_otherbirds = (TYPEOF(le.Input_otherbirds))'','',':otherbirds')
    #END
 
+    #IF( #TEXT(Input_huntfill1)='' )
      '' 
    #ELSE
        IF( le.Input_huntfill1 = (TYPEOF(le.Input_huntfill1))'','',':huntfill1')
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
 
+    #IF( #TEXT(Input_score_on_input)='' )
      '' 
    #ELSE
        IF( le.Input_score_on_input = (TYPEOF(le.Input_score_on_input))'','',':score_on_input')
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
 
+    #IF( #TEXT(Input_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_city_name = (TYPEOF(le.Input_city_name))'','',':city_name')
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
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
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
 
+    #IF( #TEXT(Input_county_name)='' )
      '' 
    #ELSE
        IF( le.Input_county_name = (TYPEOF(le.Input_county_name))'','',':county_name')
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
 
+    #IF( #TEXT(Input_mail_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_mail_prim_range = (TYPEOF(le.Input_mail_prim_range))'','',':mail_prim_range')
    #END
 
+    #IF( #TEXT(Input_mail_predir)='' )
      '' 
    #ELSE
        IF( le.Input_mail_predir = (TYPEOF(le.Input_mail_predir))'','',':mail_predir')
    #END
 
+    #IF( #TEXT(Input_mail_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_mail_prim_name = (TYPEOF(le.Input_mail_prim_name))'','',':mail_prim_name')
    #END
 
+    #IF( #TEXT(Input_mail_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_mail_addr_suffix = (TYPEOF(le.Input_mail_addr_suffix))'','',':mail_addr_suffix')
    #END
 
+    #IF( #TEXT(Input_mail_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_mail_postdir = (TYPEOF(le.Input_mail_postdir))'','',':mail_postdir')
    #END
 
+    #IF( #TEXT(Input_mail_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_mail_unit_desig = (TYPEOF(le.Input_mail_unit_desig))'','',':mail_unit_desig')
    #END
 
+    #IF( #TEXT(Input_mail_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_mail_sec_range = (TYPEOF(le.Input_mail_sec_range))'','',':mail_sec_range')
    #END
 
+    #IF( #TEXT(Input_mail_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_mail_p_city_name = (TYPEOF(le.Input_mail_p_city_name))'','',':mail_p_city_name')
    #END
 
+    #IF( #TEXT(Input_mail_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_mail_v_city_name = (TYPEOF(le.Input_mail_v_city_name))'','',':mail_v_city_name')
    #END
 
+    #IF( #TEXT(Input_mail_st)='' )
      '' 
    #ELSE
        IF( le.Input_mail_st = (TYPEOF(le.Input_mail_st))'','',':mail_st')
    #END
 
+    #IF( #TEXT(Input_mail_ace_zip)='' )
      '' 
    #ELSE
        IF( le.Input_mail_ace_zip = (TYPEOF(le.Input_mail_ace_zip))'','',':mail_ace_zip')
    #END
 
+    #IF( #TEXT(Input_mail_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_mail_zip4 = (TYPEOF(le.Input_mail_zip4))'','',':mail_zip4')
    #END
 
+    #IF( #TEXT(Input_mail_cart)='' )
      '' 
    #ELSE
        IF( le.Input_mail_cart = (TYPEOF(le.Input_mail_cart))'','',':mail_cart')
    #END
 
+    #IF( #TEXT(Input_mail_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_mail_cr_sort_sz = (TYPEOF(le.Input_mail_cr_sort_sz))'','',':mail_cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_mail_lot)='' )
      '' 
    #ELSE
        IF( le.Input_mail_lot = (TYPEOF(le.Input_mail_lot))'','',':mail_lot')
    #END
 
+    #IF( #TEXT(Input_mail_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_mail_lot_order = (TYPEOF(le.Input_mail_lot_order))'','',':mail_lot_order')
    #END
 
+    #IF( #TEXT(Input_mail_dpbc)='' )
      '' 
    #ELSE
        IF( le.Input_mail_dpbc = (TYPEOF(le.Input_mail_dpbc))'','',':mail_dpbc')
    #END
 
+    #IF( #TEXT(Input_mail_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_mail_chk_digit = (TYPEOF(le.Input_mail_chk_digit))'','',':mail_chk_digit')
    #END
 
+    #IF( #TEXT(Input_mail_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_mail_record_type = (TYPEOF(le.Input_mail_record_type))'','',':mail_record_type')
    #END
 
+    #IF( #TEXT(Input_mail_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_mail_ace_fips_st = (TYPEOF(le.Input_mail_ace_fips_st))'','',':mail_ace_fips_st')
    #END
 
+    #IF( #TEXT(Input_mail_fipscounty)='' )
      '' 
    #ELSE
        IF( le.Input_mail_fipscounty = (TYPEOF(le.Input_mail_fipscounty))'','',':mail_fipscounty')
    #END
 
+    #IF( #TEXT(Input_mail_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_mail_geo_lat = (TYPEOF(le.Input_mail_geo_lat))'','',':mail_geo_lat')
    #END
 
+    #IF( #TEXT(Input_mail_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_mail_geo_long = (TYPEOF(le.Input_mail_geo_long))'','',':mail_geo_long')
    #END
 
+    #IF( #TEXT(Input_mail_msa)='' )
      '' 
    #ELSE
        IF( le.Input_mail_msa = (TYPEOF(le.Input_mail_msa))'','',':mail_msa')
    #END
 
+    #IF( #TEXT(Input_mail_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_mail_geo_blk = (TYPEOF(le.Input_mail_geo_blk))'','',':mail_geo_blk')
    #END
 
+    #IF( #TEXT(Input_mail_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_mail_geo_match = (TYPEOF(le.Input_mail_geo_match))'','',':mail_geo_match')
    #END
 
+    #IF( #TEXT(Input_mail_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_mail_err_stat = (TYPEOF(le.Input_mail_err_stat))'','',':mail_err_stat')
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
