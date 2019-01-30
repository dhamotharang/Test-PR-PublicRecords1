﻿// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT narc3_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.3';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Infutor_NARC3';
  EXPORT spc_NAMESCOPE := 'narc3';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := 'rcid'; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'basefile';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:rcid';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,persistent_record_id,src,process_date,date_first_seen,date_last_seen,date_vendor_first_reported,date_vendor_last_reported,orig_hhid,orig_pid,orig_fname,orig_mname,orig_lname,orig_suffix,orig_gender,orig_age,orig_dob,orig_hhnbr,orig_addrid,orig_address,orig_house,orig_predir,orig_street,orig_strtype,orig_postdir,orig_apttype,orig_aptnbr,orig_city,orig_state,orig_zip,orig_z4,orig_dpc,orig_z4type,orig_crte,orig_dpv,orig_vacant,orig_msa,orig_cbsa,orig_dma,orig_county_code,orig_time_zone,orig_time_zone_descr,orig_daylight_savings,orig_latitude,orig_longitude,orig_telephone_number_1,orig_dma_tps_dnc_flag_1,orig_telephone_number_2,orig_dma_tps_dnc_flag_2,orig_telephone_number_3,orig_dma_tps_dnc_flag_3,orig_length_of_residence,orig_homeowner_renter,orig_homeowner_renter_descr,orig_year_built,orig_mobile_home_indicator,orig_pool_owner,orig_fireplace_in_home,orig_estimated_income,orig_estimated_income_descr,orig_marital_status,orig_marital_status_descr,orig_single_parent,orig_senior_in_hh,orig_credit_card_user,orig_wealth_score_estimated_net_worth,orig_wealth_score_estimated_net_worth_descr,orig_donator_to_charity_or_causes,orig_dwelling_type,orig_dwelling_type_descr,orig_home_market_value,orig_home_market_value_descr,orig_education,orig_education_descr,orig_ethnicity,orig_ethnicity_descr,orig_child,orig_child_age_ranges,orig_child_age_ranges_descr,orig_number_of_children_in_hh,orig_number_of_children_in_hh_descr,orig_luxury_vehicle_owner,orig_suv_owner,orig_pickup_truck_owner,orig_price_club_and_value_purchasing_indicator,orig_womens_apparel_purchasing_indicator,orig_womens_apparel_purchasing_indicator_descr,orig_mens_apparel_purchasing_indcator,orig_mens_apparel_purchasing_indcator_descr,orig_parenting_and_childrens_interest_bundle,orig_pet_lovers_or_owners,orig_pet_lovers_or_owners_descr,orig_book_buyers,orig_book_readers,orig_hi_tech_enthusiasts,orig_arts_bundle,orig_arts_bundle_descr,orig_collectibles_bundle,orig_collectibles_bundle_descr,orig_hobbies_home_and_garden_bundle,orig_hobbies_home_and_garden_bundle_descr,orig_home_improvement,orig_home_improvement_descr,orig_cooking_and_wine,orig_cooking_and_wine_descr,orig_gaming_and_gambling_enthusiast,orig_travel_enthusiasts,orig_travel_enthusiasts_descr,orig_physical_fitness,orig_physical_fitness_descr,orig_self_improvement,orig_self_improvement_descr,orig_automotive_diy,orig_spectator_sports_interest,orig_spectator_sports_interest_descr,orig_outdoors,orig_outdoors_descr,orig_avid_investors,orig_avid_interest_in_boating,orig_avid_interest_in_motorcycling,orig_percent_range_black,orig_percent_range_black_descr,orig_percent_range_white,orig_percent_range_white_descr,orig_percent_range_hispanic,orig_percent_range_hispanic_descr,orig_percent_range_asian,orig_percent_range_asian_descr,orig_percent_range_english_speaking,orig_percent_range_english_speaking_descr,orig_percnt_range_spanish_speaking,orig_percnt_range_spanish_speaking_descr,orig_percent_range_asian_speaking,orig_percent_range_asian_speaking_descr,orig_percent_range_sfdu,orig_percent_range_sfdu_descr,orig_percent_range_mfdu,orig_percent_range_mfdu_descr,orig_mhv,orig_mhv_descr,orig_mor,orig_mor_descr,orig_car,orig_car_descr,orig_medschl,orig_penetration_range_white_collar,orig_penetration_range_white_collar_descr,orig_penetration_range_blue_collar,orig_penetration_range_blue_collar_descr,orig_penetration_range_other_occupation,orig_penetration_range_other_occupation_descr,orig_demolevel,orig_demolevel_descr,nid,nametype,title,fname,mname,lname,name_suffix,name_ind,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,rec_type,fips_st,fips_county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,did,ssn_append,did_score,clean_phone,clean_dob,rawaid';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := FALSE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
  EXPORT spc_HAS_CONSISTENT := FALSE;
  EXPORT spc_HAS_EXTERNAL := FALSE;
  EXPORT spc_HAS_PARENTS := FALSE;
  EXPORT spc_HAS_FORCE := FALSE;
  EXPORT spc_HAS_BLOCKLINK := FALSE;
 
  // The entire spec file
  EXPORT spcString :=
    '\n'
    + '//\n'
    + 'OPTIONS:-gn\n'
    + 'MODULE:Infutor_NARC3\n'
    + 'FILENAME:basefile\n'
    + 'NAMESCOPE:narc3\n'
    + 'RIDFIELD:rcid\n'
    + 'INGESTFILE:narc3_Update:NAMED(Infutor_NARC3.Files.base)\n'
    + '\n'
    + 'FIELD:persistent_record_id:DERIVED:TYPE(STRING100):0,0\n'
    + 'FIELD:src:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:process_date:TYPE(STRING8):RECORDDATE(LAST):0,0  //data tracking\n'
    + 'FIELD:date_first_seen:TYPE(STRING8):RECORDDATE(FIRST):0,0  //data tracking\n'
    + 'FIELD:date_last_seen:TYPE(STRING8):RECORDDATE(LAST):0,0  //data tracking\n'
    + 'FIELD:date_vendor_first_reported:TYPE(STRING8):RECORDDATE(FIRST):0,0  //data tracking\n'
    + 'FIELD:date_vendor_last_reported:TYPE(STRING8):RECORDDATE(LAST):0,0  //data tracking\n'
    + 'FIELD:orig_hhid:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:orig_pid:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:orig_fname:TYPE(STRING15):0,0  //used for upsert\n'
    + 'FIELD:orig_mname:TYPE(STRING1):0,0  //used for upsert\n'
    + 'FIELD:orig_lname:TYPE(STRING20):0,0  //used for upsert\n'
    + 'FIELD:orig_suffix:TYPE(STRING10):0,0  //used for upsert\n'
    + 'FIELD:orig_gender:TYPE(STRING1):0,0  //used for upsert\n'
    + 'FIELD:orig_age:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:orig_dob:TYPE(STRING6):0,0 //used for upsert\n'
    + 'FIELD:orig_hhnbr:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_addrid:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:orig_address:TYPE(STRING64):0,0  //used for upsert\n'
    + 'FIELD:orig_house:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:orig_predir:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:orig_street:DERIVED:TYPE(STRING28):0,0\n'
    + 'FIELD:orig_strtype:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_postdir:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:orig_apttype:DERIVED:TYPE(STRING15):0,0\n'
    + 'FIELD:orig_aptnbr:DERIVED:TYPE(STRING15):0,0\n'
    + 'FIELD:orig_city:TYPE(STRING28):0,0  //used for upsert\n'
    + 'FIELD:orig_state:TYPE(STRING2):0,0  //used for upsert\n'
    + 'FIELD:orig_zip:TYPE(STRING5):0,0  //used for upsert\n'
    + 'FIELD:orig_z4:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_dpc:TYPE(STRING3):0,0  //used for upsert\n'
    + 'FIELD:orig_z4type:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_crte:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_dpv:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_vacant:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_msa:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_cbsa:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:orig_dma:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:orig_county_code:DERIVED:TYPE(STRING3):0,0\n'
    + 'FIELD:orig_time_zone:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_time_zone_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_daylight_savings:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_latitude:DERIVED:TYPE(STRING11):0,0\n'
    + 'FIELD:orig_longitude:DERIVED:TYPE(STRING11):0,0\n'
    + 'FIELD:orig_telephone_number_1:TYPE(STRING10):0,0  //used for upsert\n'
    + 'FIELD:orig_dma_tps_dnc_flag_1:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_telephone_number_2:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:orig_dma_tps_dnc_flag_2:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_telephone_number_3:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:orig_dma_tps_dnc_flag_3:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_length_of_residence:DERIVED:TYPE(STRING3):0,0\n'
    + 'FIELD:orig_homeowner_renter:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_homeowner_renter_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_year_built:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_mobile_home_indicator:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_pool_owner:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_fireplace_in_home:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_estimated_income:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_estimated_income_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_marital_status:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_marital_status_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_single_parent:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_senior_in_hh:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_credit_card_user:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_wealth_score_estimated_net_worth:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_wealth_score_estimated_net_worth_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_donator_to_charity_or_causes:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_dwelling_type:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_dwelling_type_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_home_market_value:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_home_market_value_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_education:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_education_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_ethnicity:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_ethnicity_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_child:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_child_age_ranges:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_child_age_ranges_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_number_of_children_in_hh:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_number_of_children_in_hh_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_luxury_vehicle_owner:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_suv_owner:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_pickup_truck_owner:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_price_club_and_value_purchasing_indicator:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_womens_apparel_purchasing_indicator:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_womens_apparel_purchasing_indicator_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_mens_apparel_purchasing_indcator:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_mens_apparel_purchasing_indcator_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_parenting_and_childrens_interest_bundle:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_pet_lovers_or_owners:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_pet_lovers_or_owners_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_book_buyers:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_book_readers:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_hi_tech_enthusiasts:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_arts_bundle:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_arts_bundle_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_collectibles_bundle:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_collectibles_bundle_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_hobbies_home_and_garden_bundle:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_hobbies_home_and_garden_bundle_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_home_improvement:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_home_improvement_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_cooking_and_wine:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_cooking_and_wine_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_gaming_and_gambling_enthusiast:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_travel_enthusiasts:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_travel_enthusiasts_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_physical_fitness:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_physical_fitness_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_self_improvement:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_self_improvement_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_automotive_diy:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_spectator_sports_interest:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_spectator_sports_interest_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_outdoors:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_outdoors_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_avid_investors:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_avid_interest_in_boating:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_avid_interest_in_motorcycling:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_black:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_black_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_percent_range_white:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_white_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_percent_range_hispanic:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_hispanic_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_percent_range_asian:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_asian_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_percent_range_english_speaking:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_english_speaking_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_percnt_range_spanish_speaking:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percnt_range_spanish_speaking_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_percent_range_asian_speaking:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_asian_speaking_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_percent_range_sfdu:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_sfdu_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_percent_range_mfdu:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_mfdu_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_mhv:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_mhv_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_mor:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_mor_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_car:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_car_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_medschl:DERIVED:TYPE(STRING3):0,0\n'
    + 'FIELD:orig_penetration_range_white_collar:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_penetration_range_white_collar_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_penetration_range_blue_collar:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_penetration_range_blue_collar_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_penetration_range_other_occupation:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_penetration_range_other_occupation_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:orig_demolevel:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_demolevel_descr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:nid:DERIVED:TYPE(unsigned8):0,0\n'
    + 'FIELD:nametype:DERIVED:TYPE(string1):0,0\n'
    + 'FIELD:title:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:fname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:mname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:lname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:name_ind:DERIVED:TYPE(unsigned2):0,0\n'
    + 'FIELD:prim_range:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:DERIVED:TYPE(STRING28):0,0\n'
    + 'FIELD:addr_suffix:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:DERIVED:TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:DERIVED:TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:DERIVED:TYPE(STRING25):0,0\n'
    + 'FIELD:st:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:zip:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:cart:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:lot:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:dbpc:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:fips_st:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:fips_county:DERIVED:TYPE(STRING3):0,0\n'
    + 'FIELD:geo_lat:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:DERIVED:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:DERIVED:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:did:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:ssn_append:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:did_score:DERIVED:TYPE(UNSIGNED1):0,0\n'
    + 'FIELD:clean_phone:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:clean_dob:DERIVED:TYPE(STRING8):0,0\n'
    + 'FIELD:rawaid:DERIVED:TYPE(UNSIGNED8):0,0\n'
    + '\n'
    + '\n'
    + '\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

