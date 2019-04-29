 
EXPORT raw_MAC_PopulationStatistics(infile,Ref='',Input_orig_hhid = '',Input_orig_pid = '',Input_orig_fname = '',Input_orig_mname = '',Input_orig_lname = '',Input_orig_suffix = '',Input_orig_gender = '',Input_orig_age = '',Input_orig_dob = '',Input_orig_hhnbr = '',Input_orig_addrid = '',Input_orig_address = '',Input_orig_house = '',Input_orig_predir = '',Input_orig_street = '',Input_orig_strtype = '',Input_orig_postdir = '',Input_orig_apttype = '',Input_orig_aptnbr = '',Input_orig_city = '',Input_orig_state = '',Input_orig_zip = '',Input_orig_z4 = '',Input_orig_dpc = '',Input_orig_z4type = '',Input_orig_crte = '',Input_orig_dpv = '',Input_orig_vacant = '',Input_orig_msa = '',Input_orig_cbsa = '',Input_orig_dma = '',Input_orig_county_code = '',Input_orig_time_zone = '',Input_orig_daylight_savings = '',Input_orig_latitude = '',Input_orig_longitude = '',Input_orig_telephone_number_1 = '',Input_orig_dma_tps_dnc_flag_1 = '',Input_orig_telephone_number_2 = '',Input_orig_dma_tps_dnc_flag_2 = '',Input_orig_telephone_number_3 = '',Input_orig_dma_tps_dnc_flag_3 = '',Input_orig_length_of_residence = '',Input_orig_homeowner_renter = '',Input_orig_year_built = '',Input_orig_mobile_home_indicator = '',Input_orig_pool_owner = '',Input_orig_fireplace_in_home = '',Input_orig_estimated_income = '',Input_orig_marital_status = '',Input_orig_single_parent = '',Input_orig_senior_in_hh = '',Input_orig_credit_card_user = '',Input_orig_wealth_score_estimated_net_worth = '',Input_orig_donator_to_charity_or_causes = '',Input_orig_dwelling_type = '',Input_orig_home_market_value = '',Input_orig_education = '',Input_orig_ethnicity = '',Input_orig_child = '',Input_orig_child_age_ranges = '',Input_orig_number_of_children_in_hh = '',Input_orig_luxury_vehicle_owner = '',Input_orig_suv_owner = '',Input_orig_pickup_truck_owner = '',Input_orig_price_club_and_value_purchasing_indicator = '',Input_orig_womens_apparel_purchasing_indicator = '',Input_orig_mens_apparel_purchasing_indcator = '',Input_orig_parenting_and_childrens_interest_bundle = '',Input_orig_pet_lovers_or_owners = '',Input_orig_book_buyers = '',Input_orig_book_readers = '',Input_orig_hi_tech_enthusiasts = '',Input_orig_arts_bundle = '',Input_orig_collectibles_bundle = '',Input_orig_hobbies_home_and_garden_bundle = '',Input_orig_home_improvement = '',Input_orig_cooking_and_wine = '',Input_orig_gaming_and_gambling_enthusiast = '',Input_orig_travel_enthusiasts = '',Input_orig_physical_fitness = '',Input_orig_self_improvement = '',Input_orig_automotive_diy = '',Input_orig_spectator_sports_interest = '',Input_orig_outdoors = '',Input_orig_avid_investors = '',Input_orig_avid_interest_in_boating = '',Input_orig_avid_interest_in_motorcycling = '',Input_orig_percent_range_black = '',Input_orig_percent_range_white = '',Input_orig_percent_range_hispanic = '',Input_orig_percent_range_asian = '',Input_orig_percent_range_english_speaking = '',Input_orig_percnt_range_spanish_speaking = '',Input_orig_percent_range_asian_speaking = '',Input_orig_percent_range_sfdu = '',Input_orig_percent_range_mfdu = '',Input_orig_mhv = '',Input_orig_mor = '',Input_orig_car = '',Input_orig_medschl = '',Input_orig_penetration_range_white_collar = '',Input_orig_penetration_range_blue_collar = '',Input_orig_penetration_range_other_occupation = '',Input_orig_demolevel = '',OutFile) := MACRO
  IMPORT SALT311,scrubs_infutor_narc3;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
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
 
+    #IF( #TEXT(Input_orig_dma)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dma = (TYPEOF(le.Input_orig_dma))'','',':orig_dma')
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
 
+    #IF( #TEXT(Input_orig_telephone_number_1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_telephone_number_1 = (TYPEOF(le.Input_orig_telephone_number_1))'','',':orig_telephone_number_1')
    #END
 
+    #IF( #TEXT(Input_orig_dma_tps_dnc_flag_1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dma_tps_dnc_flag_1 = (TYPEOF(le.Input_orig_dma_tps_dnc_flag_1))'','',':orig_dma_tps_dnc_flag_1')
    #END
 
+    #IF( #TEXT(Input_orig_telephone_number_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_telephone_number_2 = (TYPEOF(le.Input_orig_telephone_number_2))'','',':orig_telephone_number_2')
    #END
 
+    #IF( #TEXT(Input_orig_dma_tps_dnc_flag_2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dma_tps_dnc_flag_2 = (TYPEOF(le.Input_orig_dma_tps_dnc_flag_2))'','',':orig_dma_tps_dnc_flag_2')
    #END
 
+    #IF( #TEXT(Input_orig_telephone_number_3)='' )
      '' 
    #ELSE
        IF( le.Input_orig_telephone_number_3 = (TYPEOF(le.Input_orig_telephone_number_3))'','',':orig_telephone_number_3')
    #END
 
+    #IF( #TEXT(Input_orig_dma_tps_dnc_flag_3)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dma_tps_dnc_flag_3 = (TYPEOF(le.Input_orig_dma_tps_dnc_flag_3))'','',':orig_dma_tps_dnc_flag_3')
    #END
 
+    #IF( #TEXT(Input_orig_length_of_residence)='' )
      '' 
    #ELSE
        IF( le.Input_orig_length_of_residence = (TYPEOF(le.Input_orig_length_of_residence))'','',':orig_length_of_residence')
    #END
 
+    #IF( #TEXT(Input_orig_homeowner_renter)='' )
      '' 
    #ELSE
        IF( le.Input_orig_homeowner_renter = (TYPEOF(le.Input_orig_homeowner_renter))'','',':orig_homeowner_renter')
    #END
 
+    #IF( #TEXT(Input_orig_year_built)='' )
      '' 
    #ELSE
        IF( le.Input_orig_year_built = (TYPEOF(le.Input_orig_year_built))'','',':orig_year_built')
    #END
 
+    #IF( #TEXT(Input_orig_mobile_home_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_orig_mobile_home_indicator = (TYPEOF(le.Input_orig_mobile_home_indicator))'','',':orig_mobile_home_indicator')
    #END
 
+    #IF( #TEXT(Input_orig_pool_owner)='' )
      '' 
    #ELSE
        IF( le.Input_orig_pool_owner = (TYPEOF(le.Input_orig_pool_owner))'','',':orig_pool_owner')
    #END
 
+    #IF( #TEXT(Input_orig_fireplace_in_home)='' )
      '' 
    #ELSE
        IF( le.Input_orig_fireplace_in_home = (TYPEOF(le.Input_orig_fireplace_in_home))'','',':orig_fireplace_in_home')
    #END
 
+    #IF( #TEXT(Input_orig_estimated_income)='' )
      '' 
    #ELSE
        IF( le.Input_orig_estimated_income = (TYPEOF(le.Input_orig_estimated_income))'','',':orig_estimated_income')
    #END
 
+    #IF( #TEXT(Input_orig_marital_status)='' )
      '' 
    #ELSE
        IF( le.Input_orig_marital_status = (TYPEOF(le.Input_orig_marital_status))'','',':orig_marital_status')
    #END
 
+    #IF( #TEXT(Input_orig_single_parent)='' )
      '' 
    #ELSE
        IF( le.Input_orig_single_parent = (TYPEOF(le.Input_orig_single_parent))'','',':orig_single_parent')
    #END
 
+    #IF( #TEXT(Input_orig_senior_in_hh)='' )
      '' 
    #ELSE
        IF( le.Input_orig_senior_in_hh = (TYPEOF(le.Input_orig_senior_in_hh))'','',':orig_senior_in_hh')
    #END
 
+    #IF( #TEXT(Input_orig_credit_card_user)='' )
      '' 
    #ELSE
        IF( le.Input_orig_credit_card_user = (TYPEOF(le.Input_orig_credit_card_user))'','',':orig_credit_card_user')
    #END
 
+    #IF( #TEXT(Input_orig_wealth_score_estimated_net_worth)='' )
      '' 
    #ELSE
        IF( le.Input_orig_wealth_score_estimated_net_worth = (TYPEOF(le.Input_orig_wealth_score_estimated_net_worth))'','',':orig_wealth_score_estimated_net_worth')
    #END
 
+    #IF( #TEXT(Input_orig_donator_to_charity_or_causes)='' )
      '' 
    #ELSE
        IF( le.Input_orig_donator_to_charity_or_causes = (TYPEOF(le.Input_orig_donator_to_charity_or_causes))'','',':orig_donator_to_charity_or_causes')
    #END
 
+    #IF( #TEXT(Input_orig_dwelling_type)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dwelling_type = (TYPEOF(le.Input_orig_dwelling_type))'','',':orig_dwelling_type')
    #END
 
+    #IF( #TEXT(Input_orig_home_market_value)='' )
      '' 
    #ELSE
        IF( le.Input_orig_home_market_value = (TYPEOF(le.Input_orig_home_market_value))'','',':orig_home_market_value')
    #END
 
+    #IF( #TEXT(Input_orig_education)='' )
      '' 
    #ELSE
        IF( le.Input_orig_education = (TYPEOF(le.Input_orig_education))'','',':orig_education')
    #END
 
+    #IF( #TEXT(Input_orig_ethnicity)='' )
      '' 
    #ELSE
        IF( le.Input_orig_ethnicity = (TYPEOF(le.Input_orig_ethnicity))'','',':orig_ethnicity')
    #END
 
+    #IF( #TEXT(Input_orig_child)='' )
      '' 
    #ELSE
        IF( le.Input_orig_child = (TYPEOF(le.Input_orig_child))'','',':orig_child')
    #END
 
+    #IF( #TEXT(Input_orig_child_age_ranges)='' )
      '' 
    #ELSE
        IF( le.Input_orig_child_age_ranges = (TYPEOF(le.Input_orig_child_age_ranges))'','',':orig_child_age_ranges')
    #END
 
+    #IF( #TEXT(Input_orig_number_of_children_in_hh)='' )
      '' 
    #ELSE
        IF( le.Input_orig_number_of_children_in_hh = (TYPEOF(le.Input_orig_number_of_children_in_hh))'','',':orig_number_of_children_in_hh')
    #END
 
+    #IF( #TEXT(Input_orig_luxury_vehicle_owner)='' )
      '' 
    #ELSE
        IF( le.Input_orig_luxury_vehicle_owner = (TYPEOF(le.Input_orig_luxury_vehicle_owner))'','',':orig_luxury_vehicle_owner')
    #END
 
+    #IF( #TEXT(Input_orig_suv_owner)='' )
      '' 
    #ELSE
        IF( le.Input_orig_suv_owner = (TYPEOF(le.Input_orig_suv_owner))'','',':orig_suv_owner')
    #END
 
+    #IF( #TEXT(Input_orig_pickup_truck_owner)='' )
      '' 
    #ELSE
        IF( le.Input_orig_pickup_truck_owner = (TYPEOF(le.Input_orig_pickup_truck_owner))'','',':orig_pickup_truck_owner')
    #END
 
+    #IF( #TEXT(Input_orig_price_club_and_value_purchasing_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_orig_price_club_and_value_purchasing_indicator = (TYPEOF(le.Input_orig_price_club_and_value_purchasing_indicator))'','',':orig_price_club_and_value_purchasing_indicator')
    #END
 
+    #IF( #TEXT(Input_orig_womens_apparel_purchasing_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_orig_womens_apparel_purchasing_indicator = (TYPEOF(le.Input_orig_womens_apparel_purchasing_indicator))'','',':orig_womens_apparel_purchasing_indicator')
    #END
 
+    #IF( #TEXT(Input_orig_mens_apparel_purchasing_indcator)='' )
      '' 
    #ELSE
        IF( le.Input_orig_mens_apparel_purchasing_indcator = (TYPEOF(le.Input_orig_mens_apparel_purchasing_indcator))'','',':orig_mens_apparel_purchasing_indcator')
    #END
 
+    #IF( #TEXT(Input_orig_parenting_and_childrens_interest_bundle)='' )
      '' 
    #ELSE
        IF( le.Input_orig_parenting_and_childrens_interest_bundle = (TYPEOF(le.Input_orig_parenting_and_childrens_interest_bundle))'','',':orig_parenting_and_childrens_interest_bundle')
    #END
 
+    #IF( #TEXT(Input_orig_pet_lovers_or_owners)='' )
      '' 
    #ELSE
        IF( le.Input_orig_pet_lovers_or_owners = (TYPEOF(le.Input_orig_pet_lovers_or_owners))'','',':orig_pet_lovers_or_owners')
    #END
 
+    #IF( #TEXT(Input_orig_book_buyers)='' )
      '' 
    #ELSE
        IF( le.Input_orig_book_buyers = (TYPEOF(le.Input_orig_book_buyers))'','',':orig_book_buyers')
    #END
 
+    #IF( #TEXT(Input_orig_book_readers)='' )
      '' 
    #ELSE
        IF( le.Input_orig_book_readers = (TYPEOF(le.Input_orig_book_readers))'','',':orig_book_readers')
    #END
 
+    #IF( #TEXT(Input_orig_hi_tech_enthusiasts)='' )
      '' 
    #ELSE
        IF( le.Input_orig_hi_tech_enthusiasts = (TYPEOF(le.Input_orig_hi_tech_enthusiasts))'','',':orig_hi_tech_enthusiasts')
    #END
 
+    #IF( #TEXT(Input_orig_arts_bundle)='' )
      '' 
    #ELSE
        IF( le.Input_orig_arts_bundle = (TYPEOF(le.Input_orig_arts_bundle))'','',':orig_arts_bundle')
    #END
 
+    #IF( #TEXT(Input_orig_collectibles_bundle)='' )
      '' 
    #ELSE
        IF( le.Input_orig_collectibles_bundle = (TYPEOF(le.Input_orig_collectibles_bundle))'','',':orig_collectibles_bundle')
    #END
 
+    #IF( #TEXT(Input_orig_hobbies_home_and_garden_bundle)='' )
      '' 
    #ELSE
        IF( le.Input_orig_hobbies_home_and_garden_bundle = (TYPEOF(le.Input_orig_hobbies_home_and_garden_bundle))'','',':orig_hobbies_home_and_garden_bundle')
    #END
 
+    #IF( #TEXT(Input_orig_home_improvement)='' )
      '' 
    #ELSE
        IF( le.Input_orig_home_improvement = (TYPEOF(le.Input_orig_home_improvement))'','',':orig_home_improvement')
    #END
 
+    #IF( #TEXT(Input_orig_cooking_and_wine)='' )
      '' 
    #ELSE
        IF( le.Input_orig_cooking_and_wine = (TYPEOF(le.Input_orig_cooking_and_wine))'','',':orig_cooking_and_wine')
    #END
 
+    #IF( #TEXT(Input_orig_gaming_and_gambling_enthusiast)='' )
      '' 
    #ELSE
        IF( le.Input_orig_gaming_and_gambling_enthusiast = (TYPEOF(le.Input_orig_gaming_and_gambling_enthusiast))'','',':orig_gaming_and_gambling_enthusiast')
    #END
 
+    #IF( #TEXT(Input_orig_travel_enthusiasts)='' )
      '' 
    #ELSE
        IF( le.Input_orig_travel_enthusiasts = (TYPEOF(le.Input_orig_travel_enthusiasts))'','',':orig_travel_enthusiasts')
    #END
 
+    #IF( #TEXT(Input_orig_physical_fitness)='' )
      '' 
    #ELSE
        IF( le.Input_orig_physical_fitness = (TYPEOF(le.Input_orig_physical_fitness))'','',':orig_physical_fitness')
    #END
 
+    #IF( #TEXT(Input_orig_self_improvement)='' )
      '' 
    #ELSE
        IF( le.Input_orig_self_improvement = (TYPEOF(le.Input_orig_self_improvement))'','',':orig_self_improvement')
    #END
 
+    #IF( #TEXT(Input_orig_automotive_diy)='' )
      '' 
    #ELSE
        IF( le.Input_orig_automotive_diy = (TYPEOF(le.Input_orig_automotive_diy))'','',':orig_automotive_diy')
    #END
 
+    #IF( #TEXT(Input_orig_spectator_sports_interest)='' )
      '' 
    #ELSE
        IF( le.Input_orig_spectator_sports_interest = (TYPEOF(le.Input_orig_spectator_sports_interest))'','',':orig_spectator_sports_interest')
    #END
 
+    #IF( #TEXT(Input_orig_outdoors)='' )
      '' 
    #ELSE
        IF( le.Input_orig_outdoors = (TYPEOF(le.Input_orig_outdoors))'','',':orig_outdoors')
    #END
 
+    #IF( #TEXT(Input_orig_avid_investors)='' )
      '' 
    #ELSE
        IF( le.Input_orig_avid_investors = (TYPEOF(le.Input_orig_avid_investors))'','',':orig_avid_investors')
    #END
 
+    #IF( #TEXT(Input_orig_avid_interest_in_boating)='' )
      '' 
    #ELSE
        IF( le.Input_orig_avid_interest_in_boating = (TYPEOF(le.Input_orig_avid_interest_in_boating))'','',':orig_avid_interest_in_boating')
    #END
 
+    #IF( #TEXT(Input_orig_avid_interest_in_motorcycling)='' )
      '' 
    #ELSE
        IF( le.Input_orig_avid_interest_in_motorcycling = (TYPEOF(le.Input_orig_avid_interest_in_motorcycling))'','',':orig_avid_interest_in_motorcycling')
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
 
+    #IF( #TEXT(Input_orig_penetration_range_white_collar)='' )
      '' 
    #ELSE
        IF( le.Input_orig_penetration_range_white_collar = (TYPEOF(le.Input_orig_penetration_range_white_collar))'','',':orig_penetration_range_white_collar')
    #END
 
+    #IF( #TEXT(Input_orig_penetration_range_blue_collar)='' )
      '' 
    #ELSE
        IF( le.Input_orig_penetration_range_blue_collar = (TYPEOF(le.Input_orig_penetration_range_blue_collar))'','',':orig_penetration_range_blue_collar')
    #END
 
+    #IF( #TEXT(Input_orig_penetration_range_other_occupation)='' )
      '' 
    #ELSE
        IF( le.Input_orig_penetration_range_other_occupation = (TYPEOF(le.Input_orig_penetration_range_other_occupation))'','',':orig_penetration_range_other_occupation')
    #END
 
+    #IF( #TEXT(Input_orig_demolevel)='' )
      '' 
    #ELSE
        IF( le.Input_orig_demolevel = (TYPEOF(le.Input_orig_demolevel))'','',':orig_demolevel')
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
