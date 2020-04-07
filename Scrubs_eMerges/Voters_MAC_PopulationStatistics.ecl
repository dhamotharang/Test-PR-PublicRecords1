 
EXPORT Voters_MAC_PopulationStatistics(infile,Ref='',Input_process_date = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_score = '',Input_best_ssn = '',Input_did_out = '',Input_source = '',Input_file_id = '',Input_vendor_id = '',Input_source_state = '',Input_source_code = '',Input_file_acquired_date = '',Input__use = '',Input_title_in = '',Input_lname_in = '',Input_fname_in = '',Input_mname_in = '',Input_maiden_prior = '',Input_name_suffix_in = '',Input_votefiller = '',Input_source_voterid = '',Input_dob = '',Input_agecat = '',Input_headhousehold = '',Input_place_of_birth = '',Input_occupation = '',Input_maiden_name = '',Input_motorvoterid = '',Input_regsource = '',Input_regdate = '',Input_race = '',Input_gender = '',Input_poliparty = '',Input_poliparty_mapped = '',Input_phone = '',Input_work_phone = '',Input_other_phone = '',Input_active_status = '',Input_active_status_mapped = '',Input_votefiller2 = '',Input_active_other = '',Input_voterstatus = '',Input_voterstatus_mapped = '',Input_resaddr1 = '',Input_resaddr2 = '',Input_res_city = '',Input_res_state = '',Input_res_zip = '',Input_res_county = '',Input_mail_addr1 = '',Input_mail_addr2 = '',Input_mail_city = '',Input_mail_state = '',Input_mail_zip = '',Input_mail_county = '',Input_addr_filler1 = '',Input_addr_filler2 = '',Input_city_filler = '',Input_state_filler = '',Input_zip_filler = '',Input_county_filler = '',Input_towncode = '',Input_distcode = '',Input_countycode = '',Input_schoolcode = '',Input_cityinout = '',Input_spec_dist1 = '',Input_spec_dist2 = '',Input_precinct1 = '',Input_precinct2 = '',Input_precinct3 = '',Input_villageprecinct = '',Input_schoolprecinct = '',Input_ward = '',Input_precinct_citytown = '',Input_ancsmdindc = '',Input_citycouncildist = '',Input_countycommdist = '',Input_statehouse = '',Input_statesenate = '',Input_ushouse = '',Input_elemschooldist = '',Input_schooldist = '',Input_schoolfiller = '',Input_commcolldist = '',Input_dist_filler = '',Input_municipal = '',Input_villagedist = '',Input_policejury = '',Input_policedist = '',Input_publicservcomm = '',Input_rescue = '',Input_fire = '',Input_sanitary = '',Input_sewerdist = '',Input_waterdist = '',Input_mosquitodist = '',Input_taxdist = '',Input_supremecourt = '',Input_justiceofpeace = '',Input_judicialdist = '',Input_superiorctdist = '',Input_appealsct = '',Input_courtfiller = '',Input_contributorparty = '',Input_recptparty = '',Input_dateofcontr = '',Input_dollaramt = '',Input_officecontto = '',Input_cumuldollaramt = '',Input_contfiller1 = '',Input_contfiller2 = '',Input_conttype = '',Input_contfiller3 = '',Input_primary02 = '',Input_special02 = '',Input_other02 = '',Input_special202 = '',Input_general02 = '',Input_primary01 = '',Input_special01 = '',Input_other01 = '',Input_special201 = '',Input_general01 = '',Input_pres00 = '',Input_primary00 = '',Input_special00 = '',Input_other00 = '',Input_special200 = '',Input_general00 = '',Input_primary99 = '',Input_special99 = '',Input_other99 = '',Input_special299 = '',Input_general99 = '',Input_primary98 = '',Input_special98 = '',Input_other98 = '',Input_special298 = '',Input_general98 = '',Input_primary97 = '',Input_special97 = '',Input_other97 = '',Input_special297 = '',Input_general97 = '',Input_pres96 = '',Input_primary96 = '',Input_special96 = '',Input_other96 = '',Input_special296 = '',Input_general96 = '',Input_lastdayvote = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_score_on_input = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dpbc = '',Input_chk_digit = '',Input_record_type = '',Input_ace_fips_st = '',Input_county = '',Input_county_name = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_mail_prim_range = '',Input_mail_predir = '',Input_mail_prim_name = '',Input_mail_addr_suffix = '',Input_mail_postdir = '',Input_mail_unit_desig = '',Input_mail_sec_range = '',Input_mail_p_city_name = '',Input_mail_v_city_name = '',Input_mail_st = '',Input_mail_ace_zip = '',Input_mail_zip4 = '',Input_mail_cart = '',Input_mail_cr_sort_sz = '',Input_mail_lot = '',Input_mail_lot_order = '',Input_mail_dpbc = '',Input_mail_chk_digit = '',Input_mail_record_type = '',Input_mail_ace_fips_st = '',Input_mail_fipscounty = '',Input_mail_geo_lat = '',Input_mail_geo_long = '',Input_mail_msa = '',Input_mail_geo_blk = '',Input_mail_geo_match = '',Input_mail_err_stat = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_eMerges;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_process_date)='' )
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
 
+    #IF( #TEXT(Input_poliparty_mapped)='' )
      '' 
    #ELSE
        IF( le.Input_poliparty_mapped = (TYPEOF(le.Input_poliparty_mapped))'','',':poliparty_mapped')
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
 
+    #IF( #TEXT(Input_active_status_mapped)='' )
      '' 
    #ELSE
        IF( le.Input_active_status_mapped = (TYPEOF(le.Input_active_status_mapped))'','',':active_status_mapped')
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
 
+    #IF( #TEXT(Input_voterstatus_mapped)='' )
      '' 
    #ELSE
        IF( le.Input_voterstatus_mapped = (TYPEOF(le.Input_voterstatus_mapped))'','',':voterstatus_mapped')
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
 
+    #IF( #TEXT(Input_county_filler)='' )
      '' 
    #ELSE
        IF( le.Input_county_filler = (TYPEOF(le.Input_county_filler))'','',':county_filler')
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
 
+    #IF( #TEXT(Input_contributorparty)='' )
      '' 
    #ELSE
        IF( le.Input_contributorparty = (TYPEOF(le.Input_contributorparty))'','',':contributorparty')
    #END
 
+    #IF( #TEXT(Input_recptparty)='' )
      '' 
    #ELSE
        IF( le.Input_recptparty = (TYPEOF(le.Input_recptparty))'','',':recptparty')
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
 
+    #IF( #TEXT(Input_contfiller3)='' )
      '' 
    #ELSE
        IF( le.Input_contfiller3 = (TYPEOF(le.Input_contfiller3))'','',':contfiller3')
    #END
 
+    #IF( #TEXT(Input_primary02)='' )
      '' 
    #ELSE
        IF( le.Input_primary02 = (TYPEOF(le.Input_primary02))'','',':primary02')
    #END
 
+    #IF( #TEXT(Input_special02)='' )
      '' 
    #ELSE
        IF( le.Input_special02 = (TYPEOF(le.Input_special02))'','',':special02')
    #END
 
+    #IF( #TEXT(Input_other02)='' )
      '' 
    #ELSE
        IF( le.Input_other02 = (TYPEOF(le.Input_other02))'','',':other02')
    #END
 
+    #IF( #TEXT(Input_special202)='' )
      '' 
    #ELSE
        IF( le.Input_special202 = (TYPEOF(le.Input_special202))'','',':special202')
    #END
 
+    #IF( #TEXT(Input_general02)='' )
      '' 
    #ELSE
        IF( le.Input_general02 = (TYPEOF(le.Input_general02))'','',':general02')
    #END
 
+    #IF( #TEXT(Input_primary01)='' )
      '' 
    #ELSE
        IF( le.Input_primary01 = (TYPEOF(le.Input_primary01))'','',':primary01')
    #END
 
+    #IF( #TEXT(Input_special01)='' )
      '' 
    #ELSE
        IF( le.Input_special01 = (TYPEOF(le.Input_special01))'','',':special01')
    #END
 
+    #IF( #TEXT(Input_other01)='' )
      '' 
    #ELSE
        IF( le.Input_other01 = (TYPEOF(le.Input_other01))'','',':other01')
    #END
 
+    #IF( #TEXT(Input_special201)='' )
      '' 
    #ELSE
        IF( le.Input_special201 = (TYPEOF(le.Input_special201))'','',':special201')
    #END
 
+    #IF( #TEXT(Input_general01)='' )
      '' 
    #ELSE
        IF( le.Input_general01 = (TYPEOF(le.Input_general01))'','',':general01')
    #END
 
+    #IF( #TEXT(Input_pres00)='' )
      '' 
    #ELSE
        IF( le.Input_pres00 = (TYPEOF(le.Input_pres00))'','',':pres00')
    #END
 
+    #IF( #TEXT(Input_primary00)='' )
      '' 
    #ELSE
        IF( le.Input_primary00 = (TYPEOF(le.Input_primary00))'','',':primary00')
    #END
 
+    #IF( #TEXT(Input_special00)='' )
      '' 
    #ELSE
        IF( le.Input_special00 = (TYPEOF(le.Input_special00))'','',':special00')
    #END
 
+    #IF( #TEXT(Input_other00)='' )
      '' 
    #ELSE
        IF( le.Input_other00 = (TYPEOF(le.Input_other00))'','',':other00')
    #END
 
+    #IF( #TEXT(Input_special200)='' )
      '' 
    #ELSE
        IF( le.Input_special200 = (TYPEOF(le.Input_special200))'','',':special200')
    #END
 
+    #IF( #TEXT(Input_general00)='' )
      '' 
    #ELSE
        IF( le.Input_general00 = (TYPEOF(le.Input_general00))'','',':general00')
    #END
 
+    #IF( #TEXT(Input_primary99)='' )
      '' 
    #ELSE
        IF( le.Input_primary99 = (TYPEOF(le.Input_primary99))'','',':primary99')
    #END
 
+    #IF( #TEXT(Input_special99)='' )
      '' 
    #ELSE
        IF( le.Input_special99 = (TYPEOF(le.Input_special99))'','',':special99')
    #END
 
+    #IF( #TEXT(Input_other99)='' )
      '' 
    #ELSE
        IF( le.Input_other99 = (TYPEOF(le.Input_other99))'','',':other99')
    #END
 
+    #IF( #TEXT(Input_special299)='' )
      '' 
    #ELSE
        IF( le.Input_special299 = (TYPEOF(le.Input_special299))'','',':special299')
    #END
 
+    #IF( #TEXT(Input_general99)='' )
      '' 
    #ELSE
        IF( le.Input_general99 = (TYPEOF(le.Input_general99))'','',':general99')
    #END
 
+    #IF( #TEXT(Input_primary98)='' )
      '' 
    #ELSE
        IF( le.Input_primary98 = (TYPEOF(le.Input_primary98))'','',':primary98')
    #END
 
+    #IF( #TEXT(Input_special98)='' )
      '' 
    #ELSE
        IF( le.Input_special98 = (TYPEOF(le.Input_special98))'','',':special98')
    #END
 
+    #IF( #TEXT(Input_other98)='' )
      '' 
    #ELSE
        IF( le.Input_other98 = (TYPEOF(le.Input_other98))'','',':other98')
    #END
 
+    #IF( #TEXT(Input_special298)='' )
      '' 
    #ELSE
        IF( le.Input_special298 = (TYPEOF(le.Input_special298))'','',':special298')
    #END
 
+    #IF( #TEXT(Input_general98)='' )
      '' 
    #ELSE
        IF( le.Input_general98 = (TYPEOF(le.Input_general98))'','',':general98')
    #END
 
+    #IF( #TEXT(Input_primary97)='' )
      '' 
    #ELSE
        IF( le.Input_primary97 = (TYPEOF(le.Input_primary97))'','',':primary97')
    #END
 
+    #IF( #TEXT(Input_special97)='' )
      '' 
    #ELSE
        IF( le.Input_special97 = (TYPEOF(le.Input_special97))'','',':special97')
    #END
 
+    #IF( #TEXT(Input_other97)='' )
      '' 
    #ELSE
        IF( le.Input_other97 = (TYPEOF(le.Input_other97))'','',':other97')
    #END
 
+    #IF( #TEXT(Input_special297)='' )
      '' 
    #ELSE
        IF( le.Input_special297 = (TYPEOF(le.Input_special297))'','',':special297')
    #END
 
+    #IF( #TEXT(Input_general97)='' )
      '' 
    #ELSE
        IF( le.Input_general97 = (TYPEOF(le.Input_general97))'','',':general97')
    #END
 
+    #IF( #TEXT(Input_pres96)='' )
      '' 
    #ELSE
        IF( le.Input_pres96 = (TYPEOF(le.Input_pres96))'','',':pres96')
    #END
 
+    #IF( #TEXT(Input_primary96)='' )
      '' 
    #ELSE
        IF( le.Input_primary96 = (TYPEOF(le.Input_primary96))'','',':primary96')
    #END
 
+    #IF( #TEXT(Input_special96)='' )
      '' 
    #ELSE
        IF( le.Input_special96 = (TYPEOF(le.Input_special96))'','',':special96')
    #END
 
+    #IF( #TEXT(Input_other96)='' )
      '' 
    #ELSE
        IF( le.Input_other96 = (TYPEOF(le.Input_other96))'','',':other96')
    #END
 
+    #IF( #TEXT(Input_special296)='' )
      '' 
    #ELSE
        IF( le.Input_special296 = (TYPEOF(le.Input_special296))'','',':special296')
    #END
 
+    #IF( #TEXT(Input_general96)='' )
      '' 
    #ELSE
        IF( le.Input_general96 = (TYPEOF(le.Input_general96))'','',':general96')
    #END
 
+    #IF( #TEXT(Input_lastdayvote)='' )
      '' 
    #ELSE
        IF( le.Input_lastdayvote = (TYPEOF(le.Input_lastdayvote))'','',':lastdayvote')
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
