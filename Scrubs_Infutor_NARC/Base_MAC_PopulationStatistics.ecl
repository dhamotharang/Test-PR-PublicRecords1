 
EXPORT Base_MAC_PopulationStatistics(infile,Ref='',Input_orig_hhid = '',Input_orig_pid = '',Input_orig_fname = '',Input_orig_mname = '',Input_orig_lname = '',Input_orig_suffix = '',Input_orig_gender = '',Input_orig_age = '',Input_orig_dob = '',Input_orig_hhnbr = '',Input_orig_tot_males = '',Input_orig_tot_females = '',Input_orig_addrid = '',Input_orig_address = '',Input_orig_house = '',Input_orig_predir = '',Input_orig_street = '',Input_orig_strtype = '',Input_orig_postdir = '',Input_orig_apttype = '',Input_orig_aptnbr = '',Input_orig_city = '',Input_orig_state = '',Input_orig_zip = '',Input_orig_z4 = '',Input_orig_dpc = '',Input_orig_z4type = '',Input_orig_crte = '',Input_orig_dpv = '',Input_orig_vacant = '',Input_orig_msa = '',Input_orig_cbsa = '',Input_orig_county_code = '',Input_orig_time_zone = '',Input_orig_daylight_savings = '',Input_orig_lat_long_assignment_level = '',Input_orig_latitude = '',Input_orig_longitude = '',Input_orig_telephonenumber_1 = '',Input_orig_validationflag_1 = '',Input_orig_validationdate_1 = '',Input_orig_dma_tps_dnc_flag_1 = '',Input_orig_telephonenumber_2 = '',Input_orig_validation_flag_2 = '',Input_orig_validation_date_2 = '',Input_orig_dma_tps_dnc_flag_2 = '',Input_orig_telephonenumber_3 = '',Input_orig_validationflag_3 = '',Input_orig_validationdate_3 = '',Input_orig_dma_tps_dnc_flag_3 = '',Input_orig_telephonenumber_4 = '',Input_orig_validationflag_4 = '',Input_orig_validationdate_4 = '',Input_orig_dma_tps_dnc_flag_4 = '',Input_orig_telephonenumber_5 = '',Input_orig_validationflag_5 = '',Input_orig_validationdate_5 = '',Input_orig_dma_tps_dnc_flag_5 = '',Input_orig_telephonenumber_6 = '',Input_orig_validationflag_6 = '',Input_orig_validationdate_6 = '',Input_orig_dma_tps_dnc_flag_6 = '',Input_orig_telephonenumber_7 = '',Input_orig_validationflag_7 = '',Input_orig_validationdate_7 = '',Input_orig_dma_tps_dnc_flag_7 = '',Input_orig_tot_phones = '',Input_orig_length_of_residence = '',Input_orig_homeowner = '',Input_orig_estimatedincome = '',Input_orig_dwelling_type = '',Input_orig_married = '',Input_orig_child = '',Input_orig_nbrchild = '',Input_orig_teencd = '',Input_orig_percent_range_black = '',Input_orig_percent_range_white = '',Input_orig_percent_range_hispanic = '',Input_orig_percent_range_asian = '',Input_orig_percent_range_english_speaking = '',Input_orig_percnt_range_spanish_speaking = '',Input_orig_percent_range_asian_speaking = '',Input_orig_percent_range_sfdu = '',Input_orig_percent_range_mfdu = '',Input_orig_mhv = '',Input_orig_mor = '',Input_orig_car = '',Input_orig_medschl = '',Input_orig_penetration_range_whitecollar = '',Input_orig_penetration_range_bluecollar = '',Input_orig_penetration_range_otheroccupation = '',Input_orig_demolevel = '',Input_orig_recdate = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_fips_st = '',Input_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_did = '',Input_did_score = '',Input_clean_phone = '',Input_clean_dob = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_date_vendor_first_reported = '',Input_date_vendor_last_reported = '',Input_record_type = '',Input_src = '',Input_rawaid = '',Input_Lexhhid = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_Infutor_NARC;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_orig_hhid)='' )
      '' 
    #ELSE
        IF( le.Input_orig_hhid = (TYPEOF(le.Input_orig_hhid))'','',':orig_hhid')
    #END
 
+    #IF( #TEXT(Input_orig_pid)='' )
      '' 
    #ELSE
        IF( le.Input_orig_pid = (TYPEOF(le.Input_orig_pid))'','',':orig_pid')
    #END
 
+    #IF( #TEXT(Input_orig_fname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_fname = (TYPEOF(le.Input_orig_fname))'','',':orig_fname')
    #END
 
+    #IF( #TEXT(Input_orig_mname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_mname = (TYPEOF(le.Input_orig_mname))'','',':orig_mname')
    #END
 
+    #IF( #TEXT(Input_orig_lname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_lname = (TYPEOF(le.Input_orig_lname))'','',':orig_lname')
    #END
 
+    #IF( #TEXT(Input_orig_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_orig_suffix = (TYPEOF(le.Input_orig_suffix))'','',':orig_suffix')
    #END
 
+    #IF( #TEXT(Input_orig_gender)='' )
      '' 
    #ELSE
        IF( le.Input_orig_gender = (TYPEOF(le.Input_orig_gender))'','',':orig_gender')
    #END
 
+    #IF( #TEXT(Input_orig_age)='' )
      '' 
    #ELSE
        IF( le.Input_orig_age = (TYPEOF(le.Input_orig_age))'','',':orig_age')
    #END
 
+    #IF( #TEXT(Input_orig_dob)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dob = (TYPEOF(le.Input_orig_dob))'','',':orig_dob')
    #END
 
+    #IF( #TEXT(Input_orig_hhnbr)='' )
      '' 
    #ELSE
        IF( le.Input_orig_hhnbr = (TYPEOF(le.Input_orig_hhnbr))'','',':orig_hhnbr')
    #END
 
+    #IF( #TEXT(Input_orig_tot_males)='' )
      '' 
    #ELSE
        IF( le.Input_orig_tot_males = (TYPEOF(le.Input_orig_tot_males))'','',':orig_tot_males')
    #END
 
+    #IF( #TEXT(Input_orig_tot_females)='' )
      '' 
    #ELSE
        IF( le.Input_orig_tot_females = (TYPEOF(le.Input_orig_tot_females))'','',':orig_tot_females')
    #END
 
+    #IF( #TEXT(Input_orig_addrid)='' )
      '' 
    #ELSE
        IF( le.Input_orig_addrid = (TYPEOF(le.Input_orig_addrid))'','',':orig_addrid')
    #END
 
+    #IF( #TEXT(Input_orig_address)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address = (TYPEOF(le.Input_orig_address))'','',':orig_address')
    #END
 
+    #IF( #TEXT(Input_orig_house)='' )
      '' 
    #ELSE
        IF( le.Input_orig_house = (TYPEOF(le.Input_orig_house))'','',':orig_house')
    #END
 
+    #IF( #TEXT(Input_orig_predir)='' )
      '' 
    #ELSE
        IF( le.Input_orig_predir = (TYPEOF(le.Input_orig_predir))'','',':orig_predir')
    #END
 
+    #IF( #TEXT(Input_orig_street)='' )
      '' 
    #ELSE
        IF( le.Input_orig_street = (TYPEOF(le.Input_orig_street))'','',':orig_street')
    #END
 
+    #IF( #TEXT(Input_orig_strtype)='' )
      '' 
    #ELSE
        IF( le.Input_orig_strtype = (TYPEOF(le.Input_orig_strtype))'','',':orig_strtype')
    #END
 
+    #IF( #TEXT(Input_orig_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_orig_postdir = (TYPEOF(le.Input_orig_postdir))'','',':orig_postdir')
    #END
 
+    #IF( #TEXT(Input_orig_apttype)='' )
      '' 
    #ELSE
        IF( le.Input_orig_apttype = (TYPEOF(le.Input_orig_apttype))'','',':orig_apttype')
    #END
 
+    #IF( #TEXT(Input_orig_aptnbr)='' )
      '' 
    #ELSE
        IF( le.Input_orig_aptnbr = (TYPEOF(le.Input_orig_aptnbr))'','',':orig_aptnbr')
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
 
+    #IF( #TEXT(Input_orig_z4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_z4 = (TYPEOF(le.Input_orig_z4))'','',':orig_z4')
    #END
 
+    #IF( #TEXT(Input_orig_dpc)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dpc = (TYPEOF(le.Input_orig_dpc))'','',':orig_dpc')
    #END
 
+    #IF( #TEXT(Input_orig_z4type)='' )
      '' 
    #ELSE
        IF( le.Input_orig_z4type = (TYPEOF(le.Input_orig_z4type))'','',':orig_z4type')
    #END
 
+    #IF( #TEXT(Input_orig_crte)='' )
      '' 
    #ELSE
        IF( le.Input_orig_crte = (TYPEOF(le.Input_orig_crte))'','',':orig_crte')
    #END
 
+    #IF( #TEXT(Input_orig_dpv)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dpv = (TYPEOF(le.Input_orig_dpv))'','',':orig_dpv')
    #END
 
+    #IF( #TEXT(Input_orig_vacant)='' )
      '' 
    #ELSE
        IF( le.Input_orig_vacant = (TYPEOF(le.Input_orig_vacant))'','',':orig_vacant')
    #END
 
+    #IF( #TEXT(Input_orig_msa)='' )
      '' 
    #ELSE
        IF( le.Input_orig_msa = (TYPEOF(le.Input_orig_msa))'','',':orig_msa')
    #END
 
+    #IF( #TEXT(Input_orig_cbsa)='' )
      '' 
    #ELSE
        IF( le.Input_orig_cbsa = (TYPEOF(le.Input_orig_cbsa))'','',':orig_cbsa')
    #END
 
+    #IF( #TEXT(Input_orig_county_code)='' )
      '' 
    #ELSE
        IF( le.Input_orig_county_code = (TYPEOF(le.Input_orig_county_code))'','',':orig_county_code')
    #END
 
+    #IF( #TEXT(Input_orig_time_zone)='' )
      '' 
    #ELSE
        IF( le.Input_orig_time_zone = (TYPEOF(le.Input_orig_time_zone))'','',':orig_time_zone')
    #END
 
+    #IF( #TEXT(Input_orig_daylight_savings)='' )
      '' 
    #ELSE
        IF( le.Input_orig_daylight_savings = (TYPEOF(le.Input_orig_daylight_savings))'','',':orig_daylight_savings')
    #END
 
+    #IF( #TEXT(Input_orig_lat_long_assignment_level)='' )
      '' 
    #ELSE
        IF( le.Input_orig_lat_long_assignment_level = (TYPEOF(le.Input_orig_lat_long_assignment_level))'','',':orig_lat_long_assignment_level')
    #END
 
+    #IF( #TEXT(Input_orig_latitude)='' )
      '' 
    #ELSE
        IF( le.Input_orig_latitude = (TYPEOF(le.Input_orig_latitude))'','',':orig_latitude')
    #END
 
+    #IF( #TEXT(Input_orig_longitude)='' )
      '' 
    #ELSE
        IF( le.Input_orig_longitude = (TYPEOF(le.Input_orig_longitude))'','',':orig_longitude')
    #END
 
+    #IF( #TEXT(Input_orig_telephonenumber_1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_telephonenumber_1 = (TYPEOF(le.Input_orig_telephonenumber_1))'','',':orig_telephonenumber_1')
    #END
 
+    #IF( #TEXT(Input_orig_validationflag_1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_validationflag_1 = (TYPEOF(le.Input_orig_validationflag_1))'','',':orig_validationflag_1')
    #END
 
+    #IF( #TEXT(Input_orig_validationdate_1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_validationdate_1 = (TYPEOF(le.Input_orig_validationdate_1))'','',':orig_validationdate_1')
    #END
 
+    #IF( #TEXT(Input_orig_dma_tps_dnc_flag_1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dma_tps_dnc_flag_1 = (TYPEOF(le.Input_orig_dma_tps_dnc_flag_1))'','',':orig_dma_tps_dnc_flag_1')
    #END
 
+    #IF( #TEXT(Input_orig_telephonenumber_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_telephonenumber_2 = (TYPEOF(le.Input_orig_telephonenumber_2))'','',':orig_telephonenumber_2')
    #END
 
+    #IF( #TEXT(Input_orig_validation_flag_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_validation_flag_2 = (TYPEOF(le.Input_orig_validation_flag_2))'','',':orig_validation_flag_2')
    #END
 
+    #IF( #TEXT(Input_orig_validation_date_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_validation_date_2 = (TYPEOF(le.Input_orig_validation_date_2))'','',':orig_validation_date_2')
    #END
 
+    #IF( #TEXT(Input_orig_dma_tps_dnc_flag_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dma_tps_dnc_flag_2 = (TYPEOF(le.Input_orig_dma_tps_dnc_flag_2))'','',':orig_dma_tps_dnc_flag_2')
    #END
 
+    #IF( #TEXT(Input_orig_telephonenumber_3)='' )
      '' 
    #ELSE
        IF( le.Input_orig_telephonenumber_3 = (TYPEOF(le.Input_orig_telephonenumber_3))'','',':orig_telephonenumber_3')
    #END
 
+    #IF( #TEXT(Input_orig_validationflag_3)='' )
      '' 
    #ELSE
        IF( le.Input_orig_validationflag_3 = (TYPEOF(le.Input_orig_validationflag_3))'','',':orig_validationflag_3')
    #END
 
+    #IF( #TEXT(Input_orig_validationdate_3)='' )
      '' 
    #ELSE
        IF( le.Input_orig_validationdate_3 = (TYPEOF(le.Input_orig_validationdate_3))'','',':orig_validationdate_3')
    #END
 
+    #IF( #TEXT(Input_orig_dma_tps_dnc_flag_3)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dma_tps_dnc_flag_3 = (TYPEOF(le.Input_orig_dma_tps_dnc_flag_3))'','',':orig_dma_tps_dnc_flag_3')
    #END
 
+    #IF( #TEXT(Input_orig_telephonenumber_4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_telephonenumber_4 = (TYPEOF(le.Input_orig_telephonenumber_4))'','',':orig_telephonenumber_4')
    #END
 
+    #IF( #TEXT(Input_orig_validationflag_4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_validationflag_4 = (TYPEOF(le.Input_orig_validationflag_4))'','',':orig_validationflag_4')
    #END
 
+    #IF( #TEXT(Input_orig_validationdate_4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_validationdate_4 = (TYPEOF(le.Input_orig_validationdate_4))'','',':orig_validationdate_4')
    #END
 
+    #IF( #TEXT(Input_orig_dma_tps_dnc_flag_4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dma_tps_dnc_flag_4 = (TYPEOF(le.Input_orig_dma_tps_dnc_flag_4))'','',':orig_dma_tps_dnc_flag_4')
    #END
 
+    #IF( #TEXT(Input_orig_telephonenumber_5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_telephonenumber_5 = (TYPEOF(le.Input_orig_telephonenumber_5))'','',':orig_telephonenumber_5')
    #END
 
+    #IF( #TEXT(Input_orig_validationflag_5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_validationflag_5 = (TYPEOF(le.Input_orig_validationflag_5))'','',':orig_validationflag_5')
    #END
 
+    #IF( #TEXT(Input_orig_validationdate_5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_validationdate_5 = (TYPEOF(le.Input_orig_validationdate_5))'','',':orig_validationdate_5')
    #END
 
+    #IF( #TEXT(Input_orig_dma_tps_dnc_flag_5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dma_tps_dnc_flag_5 = (TYPEOF(le.Input_orig_dma_tps_dnc_flag_5))'','',':orig_dma_tps_dnc_flag_5')
    #END
 
+    #IF( #TEXT(Input_orig_telephonenumber_6)='' )
      '' 
    #ELSE
        IF( le.Input_orig_telephonenumber_6 = (TYPEOF(le.Input_orig_telephonenumber_6))'','',':orig_telephonenumber_6')
    #END
 
+    #IF( #TEXT(Input_orig_validationflag_6)='' )
      '' 
    #ELSE
        IF( le.Input_orig_validationflag_6 = (TYPEOF(le.Input_orig_validationflag_6))'','',':orig_validationflag_6')
    #END
 
+    #IF( #TEXT(Input_orig_validationdate_6)='' )
      '' 
    #ELSE
        IF( le.Input_orig_validationdate_6 = (TYPEOF(le.Input_orig_validationdate_6))'','',':orig_validationdate_6')
    #END
 
+    #IF( #TEXT(Input_orig_dma_tps_dnc_flag_6)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dma_tps_dnc_flag_6 = (TYPEOF(le.Input_orig_dma_tps_dnc_flag_6))'','',':orig_dma_tps_dnc_flag_6')
    #END
 
+    #IF( #TEXT(Input_orig_telephonenumber_7)='' )
      '' 
    #ELSE
        IF( le.Input_orig_telephonenumber_7 = (TYPEOF(le.Input_orig_telephonenumber_7))'','',':orig_telephonenumber_7')
    #END
 
+    #IF( #TEXT(Input_orig_validationflag_7)='' )
      '' 
    #ELSE
        IF( le.Input_orig_validationflag_7 = (TYPEOF(le.Input_orig_validationflag_7))'','',':orig_validationflag_7')
    #END
 
+    #IF( #TEXT(Input_orig_validationdate_7)='' )
      '' 
    #ELSE
        IF( le.Input_orig_validationdate_7 = (TYPEOF(le.Input_orig_validationdate_7))'','',':orig_validationdate_7')
    #END
 
+    #IF( #TEXT(Input_orig_dma_tps_dnc_flag_7)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dma_tps_dnc_flag_7 = (TYPEOF(le.Input_orig_dma_tps_dnc_flag_7))'','',':orig_dma_tps_dnc_flag_7')
    #END
 
+    #IF( #TEXT(Input_orig_tot_phones)='' )
      '' 
    #ELSE
        IF( le.Input_orig_tot_phones = (TYPEOF(le.Input_orig_tot_phones))'','',':orig_tot_phones')
    #END
 
+    #IF( #TEXT(Input_orig_length_of_residence)='' )
      '' 
    #ELSE
        IF( le.Input_orig_length_of_residence = (TYPEOF(le.Input_orig_length_of_residence))'','',':orig_length_of_residence')
    #END
 
+    #IF( #TEXT(Input_orig_homeowner)='' )
      '' 
    #ELSE
        IF( le.Input_orig_homeowner = (TYPEOF(le.Input_orig_homeowner))'','',':orig_homeowner')
    #END
 
+    #IF( #TEXT(Input_orig_estimatedincome)='' )
      '' 
    #ELSE
        IF( le.Input_orig_estimatedincome = (TYPEOF(le.Input_orig_estimatedincome))'','',':orig_estimatedincome')
    #END
 
+    #IF( #TEXT(Input_orig_dwelling_type)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dwelling_type = (TYPEOF(le.Input_orig_dwelling_type))'','',':orig_dwelling_type')
    #END
 
+    #IF( #TEXT(Input_orig_married)='' )
      '' 
    #ELSE
        IF( le.Input_orig_married = (TYPEOF(le.Input_orig_married))'','',':orig_married')
    #END
 
+    #IF( #TEXT(Input_orig_child)='' )
      '' 
    #ELSE
        IF( le.Input_orig_child = (TYPEOF(le.Input_orig_child))'','',':orig_child')
    #END
 
+    #IF( #TEXT(Input_orig_nbrchild)='' )
      '' 
    #ELSE
        IF( le.Input_orig_nbrchild = (TYPEOF(le.Input_orig_nbrchild))'','',':orig_nbrchild')
    #END
 
+    #IF( #TEXT(Input_orig_teencd)='' )
      '' 
    #ELSE
        IF( le.Input_orig_teencd = (TYPEOF(le.Input_orig_teencd))'','',':orig_teencd')
    #END
 
+    #IF( #TEXT(Input_orig_percent_range_black)='' )
      '' 
    #ELSE
        IF( le.Input_orig_percent_range_black = (TYPEOF(le.Input_orig_percent_range_black))'','',':orig_percent_range_black')
    #END
 
+    #IF( #TEXT(Input_orig_percent_range_white)='' )
      '' 
    #ELSE
        IF( le.Input_orig_percent_range_white = (TYPEOF(le.Input_orig_percent_range_white))'','',':orig_percent_range_white')
    #END
 
+    #IF( #TEXT(Input_orig_percent_range_hispanic)='' )
      '' 
    #ELSE
        IF( le.Input_orig_percent_range_hispanic = (TYPEOF(le.Input_orig_percent_range_hispanic))'','',':orig_percent_range_hispanic')
    #END
 
+    #IF( #TEXT(Input_orig_percent_range_asian)='' )
      '' 
    #ELSE
        IF( le.Input_orig_percent_range_asian = (TYPEOF(le.Input_orig_percent_range_asian))'','',':orig_percent_range_asian')
    #END
 
+    #IF( #TEXT(Input_orig_percent_range_english_speaking)='' )
      '' 
    #ELSE
        IF( le.Input_orig_percent_range_english_speaking = (TYPEOF(le.Input_orig_percent_range_english_speaking))'','',':orig_percent_range_english_speaking')
    #END
 
+    #IF( #TEXT(Input_orig_percnt_range_spanish_speaking)='' )
      '' 
    #ELSE
        IF( le.Input_orig_percnt_range_spanish_speaking = (TYPEOF(le.Input_orig_percnt_range_spanish_speaking))'','',':orig_percnt_range_spanish_speaking')
    #END
 
+    #IF( #TEXT(Input_orig_percent_range_asian_speaking)='' )
      '' 
    #ELSE
        IF( le.Input_orig_percent_range_asian_speaking = (TYPEOF(le.Input_orig_percent_range_asian_speaking))'','',':orig_percent_range_asian_speaking')
    #END
 
+    #IF( #TEXT(Input_orig_percent_range_sfdu)='' )
      '' 
    #ELSE
        IF( le.Input_orig_percent_range_sfdu = (TYPEOF(le.Input_orig_percent_range_sfdu))'','',':orig_percent_range_sfdu')
    #END
 
+    #IF( #TEXT(Input_orig_percent_range_mfdu)='' )
      '' 
    #ELSE
        IF( le.Input_orig_percent_range_mfdu = (TYPEOF(le.Input_orig_percent_range_mfdu))'','',':orig_percent_range_mfdu')
    #END
 
+    #IF( #TEXT(Input_orig_mhv)='' )
      '' 
    #ELSE
        IF( le.Input_orig_mhv = (TYPEOF(le.Input_orig_mhv))'','',':orig_mhv')
    #END
 
+    #IF( #TEXT(Input_orig_mor)='' )
      '' 
    #ELSE
        IF( le.Input_orig_mor = (TYPEOF(le.Input_orig_mor))'','',':orig_mor')
    #END
 
+    #IF( #TEXT(Input_orig_car)='' )
      '' 
    #ELSE
        IF( le.Input_orig_car = (TYPEOF(le.Input_orig_car))'','',':orig_car')
    #END
 
+    #IF( #TEXT(Input_orig_medschl)='' )
      '' 
    #ELSE
        IF( le.Input_orig_medschl = (TYPEOF(le.Input_orig_medschl))'','',':orig_medschl')
    #END
 
+    #IF( #TEXT(Input_orig_penetration_range_whitecollar)='' )
      '' 
    #ELSE
        IF( le.Input_orig_penetration_range_whitecollar = (TYPEOF(le.Input_orig_penetration_range_whitecollar))'','',':orig_penetration_range_whitecollar')
    #END
 
+    #IF( #TEXT(Input_orig_penetration_range_bluecollar)='' )
      '' 
    #ELSE
        IF( le.Input_orig_penetration_range_bluecollar = (TYPEOF(le.Input_orig_penetration_range_bluecollar))'','',':orig_penetration_range_bluecollar')
    #END
 
+    #IF( #TEXT(Input_orig_penetration_range_otheroccupation)='' )
      '' 
    #ELSE
        IF( le.Input_orig_penetration_range_otheroccupation = (TYPEOF(le.Input_orig_penetration_range_otheroccupation))'','',':orig_penetration_range_otheroccupation')
    #END
 
+    #IF( #TEXT(Input_orig_demolevel)='' )
      '' 
    #ELSE
        IF( le.Input_orig_demolevel = (TYPEOF(le.Input_orig_demolevel))'','',':orig_demolevel')
    #END
 
+    #IF( #TEXT(Input_orig_recdate)='' )
      '' 
    #ELSE
        IF( le.Input_orig_recdate = (TYPEOF(le.Input_orig_recdate))'','',':orig_recdate')
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
 
+    #IF( #TEXT(Input_clean_phone)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phone = (TYPEOF(le.Input_clean_phone))'','',':clean_phone')
    #END
 
+    #IF( #TEXT(Input_clean_dob)='' )
      '' 
    #ELSE
        IF( le.Input_clean_dob = (TYPEOF(le.Input_clean_dob))'','',':clean_dob')
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
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_src)='' )
      '' 
    #ELSE
        IF( le.Input_src = (TYPEOF(le.Input_src))'','',':src')
    #END
 
+    #IF( #TEXT(Input_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_rawaid = (TYPEOF(le.Input_rawaid))'','',':rawaid')
    #END
 
+    #IF( #TEXT(Input_Lexhhid)='' )
      '' 
    #ELSE
        IF( le.Input_Lexhhid = (TYPEOF(le.Input_Lexhhid))'','',':Lexhhid')
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
