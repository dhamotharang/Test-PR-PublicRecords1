 
EXPORT Base_Reg_MAC_PopulationStatistics(infile,Ref='',Input_rid = '',Input_did = '',Input_did_score = '',Input_ssn = '',Input_vtid = '',Input_process_date = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_source = '',Input_file_id = '',Input_vendor_id = '',Input_source_state = '',Input_source_code = '',Input_file_acquired_date = '',Input_use_code = '',Input_prefix_title = '',Input_last_name = '',Input_first_name = '',Input_middle_name = '',Input_maiden_prior = '',Input_clean_maiden_pri = '',Input_name_suffix_in = '',Input_voterfiller = '',Input_source_voterid = '',Input_dob = '',Input_agecat = '',Input_agecat_exp = '',Input_headhousehold = '',Input_place_of_birth = '',Input_occupation = '',Input_maiden_name = '',Input_motorvoterid = '',Input_regsource = '',Input_regdate = '',Input_race = '',Input_race_exp = '',Input_gender = '',Input_political_party = '',Input_politicalparty_exp = '',Input_phone = '',Input_work_phone = '',Input_other_phone = '',Input_active_status = '',Input_active_status_exp = '',Input_gendersurnamguess = '',Input_active_other = '',Input_voter_status = '',Input_voter_status_exp = '',Input_res_addr1 = '',Input_res_addr2 = '',Input_res_city = '',Input_res_state = '',Input_res_zip = '',Input_res_county = '',Input_mail_addr1 = '',Input_mail_addr2 = '',Input_mail_city = '',Input_mail_state = '',Input_mail_zip = '',Input_mail_county = '',Input_addr_filler1 = '',Input_addr_filler2 = '',Input_city_filler = '',Input_state_filler = '',Input_zip_filler = '',Input_timezonetbl = '',Input_towncode = '',Input_distcode = '',Input_countycode = '',Input_schoolcode = '',Input_cityinout = '',Input_spec_dist1 = '',Input_spec_dist2 = '',Input_precinct1 = '',Input_precinct2 = '',Input_precinct3 = '',Input_villageprecinct = '',Input_schoolprecinct = '',Input_ward = '',Input_precinct_citytown = '',Input_ancsmdindc = '',Input_citycouncildist = '',Input_countycommdist = '',Input_statehouse = '',Input_statesenate = '',Input_ushouse = '',Input_elemschooldist = '',Input_schooldist = '',Input_schoolfiller = '',Input_commcolldist = '',Input_dist_filler = '',Input_municipal = '',Input_villagedist = '',Input_policejury = '',Input_policedist = '',Input_publicservcomm = '',Input_rescue = '',Input_fire = '',Input_sanitary = '',Input_sewerdist = '',Input_waterdist = '',Input_mosquitodist = '',Input_taxdist = '',Input_supremecourt = '',Input_justiceofpeace = '',Input_judicialdist = '',Input_superiorctdist = '',Input_appealsct = '',Input_courtfiller = '',Input_cassaddrtyptbl = '',Input_cassdelivpointcd = '',Input_casscarrierrtetbl = '',Input_blkgrpenumdist = '',Input_congressionaldist = '',Input_lattitude = '',Input_countyfips = '',Input_censustract = '',Input_fipsstcountycd = '',Input_longitude = '',Input_contributorparty = '',Input_recipientparty = '',Input_dateofcontr = '',Input_dollaramt = '',Input_officecontto = '',Input_cumuldollaramt = '',Input_contfiller1 = '',Input_contfiller2 = '',Input_conttype = '',Input_contfiller4 = '',Input_lastdatevote = '',Input_miscvotehist = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dpbc = '',Input_chk_digit = '',Input_rec_type = '',Input_ace_fips_st = '',Input_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_mail_prim_range = '',Input_mail_predir = '',Input_mail_prim_name = '',Input_mail_addr_suffix = '',Input_mail_postdir = '',Input_mail_unit_desig = '',Input_mail_sec_range = '',Input_mail_p_city_name = '',Input_mail_v_city_name = '',Input_mail_st = '',Input_mail_ace_zip = '',Input_mail_zip4 = '',Input_mail_cart = '',Input_mail_cr_sort_sz = '',Input_mail_lot = '',Input_mail_lot_order = '',Input_mail_dpbc = '',Input_mail_chk_digit = '',Input_mail_rec_type = '',Input_mail_ace_fips_st = '',Input_mail_fips_county = '',Input_mail_geo_lat = '',Input_mail_geo_long = '',Input_mail_msa = '',Input_mail_geo_blk = '',Input_mail_geo_match = '',Input_mail_err_stat = '',Input_idtypes = '',Input_precinct = '',Input_ward1 = '',Input_idcode = '',Input_precinctparttextdesig = '',Input_precinctparttextname = '',Input_precincttextdesig = '',Input_marriedappend = '',Input_supervisordistrict = '',Input_district = '',Input_ward2 = '',Input_citycountycouncil = '',Input_countyprecinct = '',Input_countycommis = '',Input_schoolboard = '',Input_ward3 = '',Input_towncitycouncil1 = '',Input_towncitycouncil2 = '',Input_regents = '',Input_watershed = '',Input_education = '',Input_policeconstable = '',Input_freeholder = '',Input_municourt = '',Input_changedate = '',Input_name_type = '',Input_addr_type = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_Voters;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_rid)='' )
      '' 
    #ELSE
        IF( le.Input_rid = (TYPEOF(le.Input_rid))'','',':rid')
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
 
+    #IF( #TEXT(Input_vtid)='' )
      '' 
    #ELSE
        IF( le.Input_vtid = (TYPEOF(le.Input_vtid))'','',':vtid')
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
 
+    #IF( #TEXT(Input_use_code)='' )
      '' 
    #ELSE
        IF( le.Input_use_code = (TYPEOF(le.Input_use_code))'','',':use_code')
    #END
 
+    #IF( #TEXT(Input_prefix_title)='' )
      '' 
    #ELSE
        IF( le.Input_prefix_title = (TYPEOF(le.Input_prefix_title))'','',':prefix_title')
    #END
 
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
    #END
 
+    #IF( #TEXT(Input_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_name = (TYPEOF(le.Input_first_name))'','',':first_name')
    #END
 
+    #IF( #TEXT(Input_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_middle_name = (TYPEOF(le.Input_middle_name))'','',':middle_name')
    #END
 
+    #IF( #TEXT(Input_maiden_prior)='' )
      '' 
    #ELSE
        IF( le.Input_maiden_prior = (TYPEOF(le.Input_maiden_prior))'','',':maiden_prior')
    #END
 
+    #IF( #TEXT(Input_clean_maiden_pri)='' )
      '' 
    #ELSE
        IF( le.Input_clean_maiden_pri = (TYPEOF(le.Input_clean_maiden_pri))'','',':clean_maiden_pri')
    #END
 
+    #IF( #TEXT(Input_name_suffix_in)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix_in = (TYPEOF(le.Input_name_suffix_in))'','',':name_suffix_in')
    #END
 
+    #IF( #TEXT(Input_voterfiller)='' )
      '' 
    #ELSE
        IF( le.Input_voterfiller = (TYPEOF(le.Input_voterfiller))'','',':voterfiller')
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
 
+    #IF( #TEXT(Input_agecat_exp)='' )
      '' 
    #ELSE
        IF( le.Input_agecat_exp = (TYPEOF(le.Input_agecat_exp))'','',':agecat_exp')
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
 
+    #IF( #TEXT(Input_race_exp)='' )
      '' 
    #ELSE
        IF( le.Input_race_exp = (TYPEOF(le.Input_race_exp))'','',':race_exp')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_political_party)='' )
      '' 
    #ELSE
        IF( le.Input_political_party = (TYPEOF(le.Input_political_party))'','',':political_party')
    #END
 
+    #IF( #TEXT(Input_politicalparty_exp)='' )
      '' 
    #ELSE
        IF( le.Input_politicalparty_exp = (TYPEOF(le.Input_politicalparty_exp))'','',':politicalparty_exp')
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
 
+    #IF( #TEXT(Input_active_status_exp)='' )
      '' 
    #ELSE
        IF( le.Input_active_status_exp = (TYPEOF(le.Input_active_status_exp))'','',':active_status_exp')
    #END
 
+    #IF( #TEXT(Input_gendersurnamguess)='' )
      '' 
    #ELSE
        IF( le.Input_gendersurnamguess = (TYPEOF(le.Input_gendersurnamguess))'','',':gendersurnamguess')
    #END
 
+    #IF( #TEXT(Input_active_other)='' )
      '' 
    #ELSE
        IF( le.Input_active_other = (TYPEOF(le.Input_active_other))'','',':active_other')
    #END
 
+    #IF( #TEXT(Input_voter_status)='' )
      '' 
    #ELSE
        IF( le.Input_voter_status = (TYPEOF(le.Input_voter_status))'','',':voter_status')
    #END
 
+    #IF( #TEXT(Input_voter_status_exp)='' )
      '' 
    #ELSE
        IF( le.Input_voter_status_exp = (TYPEOF(le.Input_voter_status_exp))'','',':voter_status_exp')
    #END
 
+    #IF( #TEXT(Input_res_addr1)='' )
      '' 
    #ELSE
        IF( le.Input_res_addr1 = (TYPEOF(le.Input_res_addr1))'','',':res_addr1')
    #END
 
+    #IF( #TEXT(Input_res_addr2)='' )
      '' 
    #ELSE
        IF( le.Input_res_addr2 = (TYPEOF(le.Input_res_addr2))'','',':res_addr2')
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
 
+    #IF( #TEXT(Input_addr_filler1)='' )
      '' 
    #ELSE
        IF( le.Input_addr_filler1 = (TYPEOF(le.Input_addr_filler1))'','',':addr_filler1')
    #END
 
+    #IF( #TEXT(Input_addr_filler2)='' )
      '' 
    #ELSE
        IF( le.Input_addr_filler2 = (TYPEOF(le.Input_addr_filler2))'','',':addr_filler2')
    #END
 
+    #IF( #TEXT(Input_city_filler)='' )
      '' 
    #ELSE
        IF( le.Input_city_filler = (TYPEOF(le.Input_city_filler))'','',':city_filler')
    #END
 
+    #IF( #TEXT(Input_state_filler)='' )
      '' 
    #ELSE
        IF( le.Input_state_filler = (TYPEOF(le.Input_state_filler))'','',':state_filler')
    #END
 
+    #IF( #TEXT(Input_zip_filler)='' )
      '' 
    #ELSE
        IF( le.Input_zip_filler = (TYPEOF(le.Input_zip_filler))'','',':zip_filler')
    #END
 
+    #IF( #TEXT(Input_timezonetbl)='' )
      '' 
    #ELSE
        IF( le.Input_timezonetbl = (TYPEOF(le.Input_timezonetbl))'','',':timezonetbl')
    #END
 
+    #IF( #TEXT(Input_towncode)='' )
      '' 
    #ELSE
        IF( le.Input_towncode = (TYPEOF(le.Input_towncode))'','',':towncode')
    #END
 
+    #IF( #TEXT(Input_distcode)='' )
      '' 
    #ELSE
        IF( le.Input_distcode = (TYPEOF(le.Input_distcode))'','',':distcode')
    #END
 
+    #IF( #TEXT(Input_countycode)='' )
      '' 
    #ELSE
        IF( le.Input_countycode = (TYPEOF(le.Input_countycode))'','',':countycode')
    #END
 
+    #IF( #TEXT(Input_schoolcode)='' )
      '' 
    #ELSE
        IF( le.Input_schoolcode = (TYPEOF(le.Input_schoolcode))'','',':schoolcode')
    #END
 
+    #IF( #TEXT(Input_cityinout)='' )
      '' 
    #ELSE
        IF( le.Input_cityinout = (TYPEOF(le.Input_cityinout))'','',':cityinout')
    #END
 
+    #IF( #TEXT(Input_spec_dist1)='' )
      '' 
    #ELSE
        IF( le.Input_spec_dist1 = (TYPEOF(le.Input_spec_dist1))'','',':spec_dist1')
    #END
 
+    #IF( #TEXT(Input_spec_dist2)='' )
      '' 
    #ELSE
        IF( le.Input_spec_dist2 = (TYPEOF(le.Input_spec_dist2))'','',':spec_dist2')
    #END
 
+    #IF( #TEXT(Input_precinct1)='' )
      '' 
    #ELSE
        IF( le.Input_precinct1 = (TYPEOF(le.Input_precinct1))'','',':precinct1')
    #END
 
+    #IF( #TEXT(Input_precinct2)='' )
      '' 
    #ELSE
        IF( le.Input_precinct2 = (TYPEOF(le.Input_precinct2))'','',':precinct2')
    #END
 
+    #IF( #TEXT(Input_precinct3)='' )
      '' 
    #ELSE
        IF( le.Input_precinct3 = (TYPEOF(le.Input_precinct3))'','',':precinct3')
    #END
 
+    #IF( #TEXT(Input_villageprecinct)='' )
      '' 
    #ELSE
        IF( le.Input_villageprecinct = (TYPEOF(le.Input_villageprecinct))'','',':villageprecinct')
    #END
 
+    #IF( #TEXT(Input_schoolprecinct)='' )
      '' 
    #ELSE
        IF( le.Input_schoolprecinct = (TYPEOF(le.Input_schoolprecinct))'','',':schoolprecinct')
    #END
 
+    #IF( #TEXT(Input_ward)='' )
      '' 
    #ELSE
        IF( le.Input_ward = (TYPEOF(le.Input_ward))'','',':ward')
    #END
 
+    #IF( #TEXT(Input_precinct_citytown)='' )
      '' 
    #ELSE
        IF( le.Input_precinct_citytown = (TYPEOF(le.Input_precinct_citytown))'','',':precinct_citytown')
    #END
 
+    #IF( #TEXT(Input_ancsmdindc)='' )
      '' 
    #ELSE
        IF( le.Input_ancsmdindc = (TYPEOF(le.Input_ancsmdindc))'','',':ancsmdindc')
    #END
 
+    #IF( #TEXT(Input_citycouncildist)='' )
      '' 
    #ELSE
        IF( le.Input_citycouncildist = (TYPEOF(le.Input_citycouncildist))'','',':citycouncildist')
    #END
 
+    #IF( #TEXT(Input_countycommdist)='' )
      '' 
    #ELSE
        IF( le.Input_countycommdist = (TYPEOF(le.Input_countycommdist))'','',':countycommdist')
    #END
 
+    #IF( #TEXT(Input_statehouse)='' )
      '' 
    #ELSE
        IF( le.Input_statehouse = (TYPEOF(le.Input_statehouse))'','',':statehouse')
    #END
 
+    #IF( #TEXT(Input_statesenate)='' )
      '' 
    #ELSE
        IF( le.Input_statesenate = (TYPEOF(le.Input_statesenate))'','',':statesenate')
    #END
 
+    #IF( #TEXT(Input_ushouse)='' )
      '' 
    #ELSE
        IF( le.Input_ushouse = (TYPEOF(le.Input_ushouse))'','',':ushouse')
    #END
 
+    #IF( #TEXT(Input_elemschooldist)='' )
      '' 
    #ELSE
        IF( le.Input_elemschooldist = (TYPEOF(le.Input_elemschooldist))'','',':elemschooldist')
    #END
 
+    #IF( #TEXT(Input_schooldist)='' )
      '' 
    #ELSE
        IF( le.Input_schooldist = (TYPEOF(le.Input_schooldist))'','',':schooldist')
    #END
 
+    #IF( #TEXT(Input_schoolfiller)='' )
      '' 
    #ELSE
        IF( le.Input_schoolfiller = (TYPEOF(le.Input_schoolfiller))'','',':schoolfiller')
    #END
 
+    #IF( #TEXT(Input_commcolldist)='' )
      '' 
    #ELSE
        IF( le.Input_commcolldist = (TYPEOF(le.Input_commcolldist))'','',':commcolldist')
    #END
 
+    #IF( #TEXT(Input_dist_filler)='' )
      '' 
    #ELSE
        IF( le.Input_dist_filler = (TYPEOF(le.Input_dist_filler))'','',':dist_filler')
    #END
 
+    #IF( #TEXT(Input_municipal)='' )
      '' 
    #ELSE
        IF( le.Input_municipal = (TYPEOF(le.Input_municipal))'','',':municipal')
    #END
 
+    #IF( #TEXT(Input_villagedist)='' )
      '' 
    #ELSE
        IF( le.Input_villagedist = (TYPEOF(le.Input_villagedist))'','',':villagedist')
    #END
 
+    #IF( #TEXT(Input_policejury)='' )
      '' 
    #ELSE
        IF( le.Input_policejury = (TYPEOF(le.Input_policejury))'','',':policejury')
    #END
 
+    #IF( #TEXT(Input_policedist)='' )
      '' 
    #ELSE
        IF( le.Input_policedist = (TYPEOF(le.Input_policedist))'','',':policedist')
    #END
 
+    #IF( #TEXT(Input_publicservcomm)='' )
      '' 
    #ELSE
        IF( le.Input_publicservcomm = (TYPEOF(le.Input_publicservcomm))'','',':publicservcomm')
    #END
 
+    #IF( #TEXT(Input_rescue)='' )
      '' 
    #ELSE
        IF( le.Input_rescue = (TYPEOF(le.Input_rescue))'','',':rescue')
    #END
 
+    #IF( #TEXT(Input_fire)='' )
      '' 
    #ELSE
        IF( le.Input_fire = (TYPEOF(le.Input_fire))'','',':fire')
    #END
 
+    #IF( #TEXT(Input_sanitary)='' )
      '' 
    #ELSE
        IF( le.Input_sanitary = (TYPEOF(le.Input_sanitary))'','',':sanitary')
    #END
 
+    #IF( #TEXT(Input_sewerdist)='' )
      '' 
    #ELSE
        IF( le.Input_sewerdist = (TYPEOF(le.Input_sewerdist))'','',':sewerdist')
    #END
 
+    #IF( #TEXT(Input_waterdist)='' )
      '' 
    #ELSE
        IF( le.Input_waterdist = (TYPEOF(le.Input_waterdist))'','',':waterdist')
    #END
 
+    #IF( #TEXT(Input_mosquitodist)='' )
      '' 
    #ELSE
        IF( le.Input_mosquitodist = (TYPEOF(le.Input_mosquitodist))'','',':mosquitodist')
    #END
 
+    #IF( #TEXT(Input_taxdist)='' )
      '' 
    #ELSE
        IF( le.Input_taxdist = (TYPEOF(le.Input_taxdist))'','',':taxdist')
    #END
 
+    #IF( #TEXT(Input_supremecourt)='' )
      '' 
    #ELSE
        IF( le.Input_supremecourt = (TYPEOF(le.Input_supremecourt))'','',':supremecourt')
    #END
 
+    #IF( #TEXT(Input_justiceofpeace)='' )
      '' 
    #ELSE
        IF( le.Input_justiceofpeace = (TYPEOF(le.Input_justiceofpeace))'','',':justiceofpeace')
    #END
 
+    #IF( #TEXT(Input_judicialdist)='' )
      '' 
    #ELSE
        IF( le.Input_judicialdist = (TYPEOF(le.Input_judicialdist))'','',':judicialdist')
    #END
 
+    #IF( #TEXT(Input_superiorctdist)='' )
      '' 
    #ELSE
        IF( le.Input_superiorctdist = (TYPEOF(le.Input_superiorctdist))'','',':superiorctdist')
    #END
 
+    #IF( #TEXT(Input_appealsct)='' )
      '' 
    #ELSE
        IF( le.Input_appealsct = (TYPEOF(le.Input_appealsct))'','',':appealsct')
    #END
 
+    #IF( #TEXT(Input_courtfiller)='' )
      '' 
    #ELSE
        IF( le.Input_courtfiller = (TYPEOF(le.Input_courtfiller))'','',':courtfiller')
    #END
 
+    #IF( #TEXT(Input_cassaddrtyptbl)='' )
      '' 
    #ELSE
        IF( le.Input_cassaddrtyptbl = (TYPEOF(le.Input_cassaddrtyptbl))'','',':cassaddrtyptbl')
    #END
 
+    #IF( #TEXT(Input_cassdelivpointcd)='' )
      '' 
    #ELSE
        IF( le.Input_cassdelivpointcd = (TYPEOF(le.Input_cassdelivpointcd))'','',':cassdelivpointcd')
    #END
 
+    #IF( #TEXT(Input_casscarrierrtetbl)='' )
      '' 
    #ELSE
        IF( le.Input_casscarrierrtetbl = (TYPEOF(le.Input_casscarrierrtetbl))'','',':casscarrierrtetbl')
    #END
 
+    #IF( #TEXT(Input_blkgrpenumdist)='' )
      '' 
    #ELSE
        IF( le.Input_blkgrpenumdist = (TYPEOF(le.Input_blkgrpenumdist))'','',':blkgrpenumdist')
    #END
 
+    #IF( #TEXT(Input_congressionaldist)='' )
      '' 
    #ELSE
        IF( le.Input_congressionaldist = (TYPEOF(le.Input_congressionaldist))'','',':congressionaldist')
    #END
 
+    #IF( #TEXT(Input_lattitude)='' )
      '' 
    #ELSE
        IF( le.Input_lattitude = (TYPEOF(le.Input_lattitude))'','',':lattitude')
    #END
 
+    #IF( #TEXT(Input_countyfips)='' )
      '' 
    #ELSE
        IF( le.Input_countyfips = (TYPEOF(le.Input_countyfips))'','',':countyfips')
    #END
 
+    #IF( #TEXT(Input_censustract)='' )
      '' 
    #ELSE
        IF( le.Input_censustract = (TYPEOF(le.Input_censustract))'','',':censustract')
    #END
 
+    #IF( #TEXT(Input_fipsstcountycd)='' )
      '' 
    #ELSE
        IF( le.Input_fipsstcountycd = (TYPEOF(le.Input_fipsstcountycd))'','',':fipsstcountycd')
    #END
 
+    #IF( #TEXT(Input_longitude)='' )
      '' 
    #ELSE
        IF( le.Input_longitude = (TYPEOF(le.Input_longitude))'','',':longitude')
    #END
 
+    #IF( #TEXT(Input_contributorparty)='' )
      '' 
    #ELSE
        IF( le.Input_contributorparty = (TYPEOF(le.Input_contributorparty))'','',':contributorparty')
    #END
 
+    #IF( #TEXT(Input_recipientparty)='' )
      '' 
    #ELSE
        IF( le.Input_recipientparty = (TYPEOF(le.Input_recipientparty))'','',':recipientparty')
    #END
 
+    #IF( #TEXT(Input_dateofcontr)='' )
      '' 
    #ELSE
        IF( le.Input_dateofcontr = (TYPEOF(le.Input_dateofcontr))'','',':dateofcontr')
    #END
 
+    #IF( #TEXT(Input_dollaramt)='' )
      '' 
    #ELSE
        IF( le.Input_dollaramt = (TYPEOF(le.Input_dollaramt))'','',':dollaramt')
    #END
 
+    #IF( #TEXT(Input_officecontto)='' )
      '' 
    #ELSE
        IF( le.Input_officecontto = (TYPEOF(le.Input_officecontto))'','',':officecontto')
    #END
 
+    #IF( #TEXT(Input_cumuldollaramt)='' )
      '' 
    #ELSE
        IF( le.Input_cumuldollaramt = (TYPEOF(le.Input_cumuldollaramt))'','',':cumuldollaramt')
    #END
 
+    #IF( #TEXT(Input_contfiller1)='' )
      '' 
    #ELSE
        IF( le.Input_contfiller1 = (TYPEOF(le.Input_contfiller1))'','',':contfiller1')
    #END
 
+    #IF( #TEXT(Input_contfiller2)='' )
      '' 
    #ELSE
        IF( le.Input_contfiller2 = (TYPEOF(le.Input_contfiller2))'','',':contfiller2')
    #END
 
+    #IF( #TEXT(Input_conttype)='' )
      '' 
    #ELSE
        IF( le.Input_conttype = (TYPEOF(le.Input_conttype))'','',':conttype')
    #END
 
+    #IF( #TEXT(Input_contfiller4)='' )
      '' 
    #ELSE
        IF( le.Input_contfiller4 = (TYPEOF(le.Input_contfiller4))'','',':contfiller4')
    #END
 
+    #IF( #TEXT(Input_lastdatevote)='' )
      '' 
    #ELSE
        IF( le.Input_lastdatevote = (TYPEOF(le.Input_lastdatevote))'','',':lastdatevote')
    #END
 
+    #IF( #TEXT(Input_miscvotehist)='' )
      '' 
    #ELSE
        IF( le.Input_miscvotehist = (TYPEOF(le.Input_miscvotehist))'','',':miscvotehist')
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
 
+    #IF( #TEXT(Input_mail_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_mail_rec_type = (TYPEOF(le.Input_mail_rec_type))'','',':mail_rec_type')
    #END
 
+    #IF( #TEXT(Input_mail_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_mail_ace_fips_st = (TYPEOF(le.Input_mail_ace_fips_st))'','',':mail_ace_fips_st')
    #END
 
+    #IF( #TEXT(Input_mail_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_mail_fips_county = (TYPEOF(le.Input_mail_fips_county))'','',':mail_fips_county')
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
 
+    #IF( #TEXT(Input_idtypes)='' )
      '' 
    #ELSE
        IF( le.Input_idtypes = (TYPEOF(le.Input_idtypes))'','',':idtypes')
    #END
 
+    #IF( #TEXT(Input_precinct)='' )
      '' 
    #ELSE
        IF( le.Input_precinct = (TYPEOF(le.Input_precinct))'','',':precinct')
    #END
 
+    #IF( #TEXT(Input_ward1)='' )
      '' 
    #ELSE
        IF( le.Input_ward1 = (TYPEOF(le.Input_ward1))'','',':ward1')
    #END
 
+    #IF( #TEXT(Input_idcode)='' )
      '' 
    #ELSE
        IF( le.Input_idcode = (TYPEOF(le.Input_idcode))'','',':idcode')
    #END
 
+    #IF( #TEXT(Input_precinctparttextdesig)='' )
      '' 
    #ELSE
        IF( le.Input_precinctparttextdesig = (TYPEOF(le.Input_precinctparttextdesig))'','',':precinctparttextdesig')
    #END
 
+    #IF( #TEXT(Input_precinctparttextname)='' )
      '' 
    #ELSE
        IF( le.Input_precinctparttextname = (TYPEOF(le.Input_precinctparttextname))'','',':precinctparttextname')
    #END
 
+    #IF( #TEXT(Input_precincttextdesig)='' )
      '' 
    #ELSE
        IF( le.Input_precincttextdesig = (TYPEOF(le.Input_precincttextdesig))'','',':precincttextdesig')
    #END
 
+    #IF( #TEXT(Input_marriedappend)='' )
      '' 
    #ELSE
        IF( le.Input_marriedappend = (TYPEOF(le.Input_marriedappend))'','',':marriedappend')
    #END
 
+    #IF( #TEXT(Input_supervisordistrict)='' )
      '' 
    #ELSE
        IF( le.Input_supervisordistrict = (TYPEOF(le.Input_supervisordistrict))'','',':supervisordistrict')
    #END
 
+    #IF( #TEXT(Input_district)='' )
      '' 
    #ELSE
        IF( le.Input_district = (TYPEOF(le.Input_district))'','',':district')
    #END
 
+    #IF( #TEXT(Input_ward2)='' )
      '' 
    #ELSE
        IF( le.Input_ward2 = (TYPEOF(le.Input_ward2))'','',':ward2')
    #END
 
+    #IF( #TEXT(Input_citycountycouncil)='' )
      '' 
    #ELSE
        IF( le.Input_citycountycouncil = (TYPEOF(le.Input_citycountycouncil))'','',':citycountycouncil')
    #END
 
+    #IF( #TEXT(Input_countyprecinct)='' )
      '' 
    #ELSE
        IF( le.Input_countyprecinct = (TYPEOF(le.Input_countyprecinct))'','',':countyprecinct')
    #END
 
+    #IF( #TEXT(Input_countycommis)='' )
      '' 
    #ELSE
        IF( le.Input_countycommis = (TYPEOF(le.Input_countycommis))'','',':countycommis')
    #END
 
+    #IF( #TEXT(Input_schoolboard)='' )
      '' 
    #ELSE
        IF( le.Input_schoolboard = (TYPEOF(le.Input_schoolboard))'','',':schoolboard')
    #END
 
+    #IF( #TEXT(Input_ward3)='' )
      '' 
    #ELSE
        IF( le.Input_ward3 = (TYPEOF(le.Input_ward3))'','',':ward3')
    #END
 
+    #IF( #TEXT(Input_towncitycouncil1)='' )
      '' 
    #ELSE
        IF( le.Input_towncitycouncil1 = (TYPEOF(le.Input_towncitycouncil1))'','',':towncitycouncil1')
    #END
 
+    #IF( #TEXT(Input_towncitycouncil2)='' )
      '' 
    #ELSE
        IF( le.Input_towncitycouncil2 = (TYPEOF(le.Input_towncitycouncil2))'','',':towncitycouncil2')
    #END
 
+    #IF( #TEXT(Input_regents)='' )
      '' 
    #ELSE
        IF( le.Input_regents = (TYPEOF(le.Input_regents))'','',':regents')
    #END
 
+    #IF( #TEXT(Input_watershed)='' )
      '' 
    #ELSE
        IF( le.Input_watershed = (TYPEOF(le.Input_watershed))'','',':watershed')
    #END
 
+    #IF( #TEXT(Input_education)='' )
      '' 
    #ELSE
        IF( le.Input_education = (TYPEOF(le.Input_education))'','',':education')
    #END
 
+    #IF( #TEXT(Input_policeconstable)='' )
      '' 
    #ELSE
        IF( le.Input_policeconstable = (TYPEOF(le.Input_policeconstable))'','',':policeconstable')
    #END
 
+    #IF( #TEXT(Input_freeholder)='' )
      '' 
    #ELSE
        IF( le.Input_freeholder = (TYPEOF(le.Input_freeholder))'','',':freeholder')
    #END
 
+    #IF( #TEXT(Input_municourt)='' )
      '' 
    #ELSE
        IF( le.Input_municourt = (TYPEOF(le.Input_municourt))'','',':municourt')
    #END
 
+    #IF( #TEXT(Input_changedate)='' )
      '' 
    #ELSE
        IF( le.Input_changedate = (TYPEOF(le.Input_changedate))'','',':changedate')
    #END
 
+    #IF( #TEXT(Input_name_type)='' )
      '' 
    #ELSE
        IF( le.Input_name_type = (TYPEOF(le.Input_name_type))'','',':name_type')
    #END
 
+    #IF( #TEXT(Input_addr_type)='' )
      '' 
    #ELSE
        IF( le.Input_addr_type = (TYPEOF(le.Input_addr_type))'','',':addr_type')
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
