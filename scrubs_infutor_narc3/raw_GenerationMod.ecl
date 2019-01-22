// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT raw_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.3';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'scrubs_infutor_narc3';
  EXPORT spc_NAMESCOPE := 'raw';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'infutor_narc3';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,orig_hhid,orig_pid,orig_fname,orig_mname,orig_lname,orig_suffix,orig_gender,orig_age,orig_dob,orig_hhnbr,orig_addrid,orig_address,orig_house,orig_predir,orig_street,orig_strtype,orig_postdir,orig_apttype,orig_aptnbr,orig_city,orig_state,orig_zip,orig_z4,orig_dpc,orig_z4type,orig_crte,orig_dpv,orig_vacant,orig_msa,orig_cbsa,orig_dma,orig_county_code,orig_time_zone,orig_daylight_savings,orig_latitude,orig_longitude,orig_telephone_number_1,orig_dma_tps_dnc_flag_1,orig_telephone_number_2,orig_dma_tps_dnc_flag_2,orig_telephone_number_3,orig_dma_tps_dnc_flag_3,orig_length_of_residence,orig_homeowner_renter,orig_year_built,orig_mobile_home_indicator,orig_pool_owner,orig_fireplace_in_home,orig_estimated_income,orig_marital_status,orig_single_parent,orig_senior_in_hh,orig_credit_card_user,orig_wealth_score_estimated_net_worth,orig_donator_to_charity_or_causes,orig_dwelling_type,orig_home_market_value,orig_education,orig_ethnicity,orig_child,orig_child_age_ranges,orig_number_of_children_in_hh,orig_luxury_vehicle_owner,orig_suv_owner,orig_pickup_truck_owner,orig_price_club_and_value_purchasing_indicator,orig_womens_apparel_purchasing_indicator,orig_mens_apparel_purchasing_indcator,orig_parenting_and_childrens_interest_bundle,orig_pet_lovers_or_owners,orig_book_buyers,orig_book_readers,orig_hi_tech_enthusiasts,orig_arts_bundle,orig_collectibles_bundle,orig_hobbies_home_and_garden_bundle,orig_home_improvement,orig_cooking_and_wine,orig_gaming_and_gambling_enthusiast,orig_travel_enthusiasts,orig_physical_fitness,orig_self_improvement,orig_automotive_diy,orig_spectator_sports_interest,orig_outdoors,orig_avid_investors,orig_avid_interest_in_boating,orig_avid_interest_in_motorcycling,orig_percent_range_black,orig_percent_range_white,orig_percent_range_hispanic,orig_percent_range_asian,orig_percent_range_english_speaking,orig_percnt_range_spanish_speaking,orig_percent_range_asian_speaking,orig_percent_range_sfdu,orig_percent_range_mfdu,orig_mhv,orig_mor,orig_car,orig_medschl,orig_penetration_range_white_collar,orig_penetration_range_blue_collar,orig_penetration_range_other_occupation,orig_demolevel';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
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
    + 'OPTIONS:-gh\n'
    + 'MODULE:scrubs_infutor_narc3\n'
    + 'FILENAME:infutor_narc3       \n'
    + 'NAMESCOPE:raw\n'
    + '//SOURCEFIELD:source\n'
    + '\n'
    + '//***set FIELDTYPE\n'
    + '\n'
    + 'FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)  \n'
    + 'FIELDTYPE:invalid_number:ALLOW(0123456789) \n'
    + '\n'
    + '//name and gender\n'
    + 'FIELDTYPE:invalid_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ- \')  \n'
    + 'FIELDTYPE:invalid_gender:ENUM(M|F| )\n'
    + 'FIELDTYPE:invalid_dob:ALLOW(0123456789 )\n'
    + 'FIELDTYPE:invalid_age:ALLOW(0123456789 ) \n'
    + '\n'
    + '//address\n'
    + 'FIELDTYPE:invalid_city:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ )  \n'
    + 'FIELDTYPE:invalid_state:ENUM(AK|AL|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|IA|ID|IL|IN|KS|KY|LA|MA|MD|ME|MI|MN|MO|MS|MT|NC|ND|NE|NH|NJ|NM|NV|NY|OH|OK|OR|PA|PR|RI|SC|SD|TN|TX|UT|VA|VT|WA|WI|WV|WY| )\n'
    + 'FIELDTYPE:invalid_zip:ALLOW(0123456789 )\n'
    + '\n'
    + '\n'
    + '\n'
    + '//***set FIELD\n'
    + 'FIELD:orig_hhid:TYPE(STRING20):0,0\n'
    + 'FIELD:orig_pid:TYPE(STRING20):0,0\n'
    + 'FIELD:orig_fname:LIKE(invalid_name):TYPE(STRING15):0,0 \n'
    + 'FIELD:orig_mname:LIKE(invalid_name):TYPE(STRING1):0,0 \n'
    + 'FIELD:orig_lname:LIKE(invalid_name):TYPE(STRING20):0,0  \n'
    + 'FIELD:orig_suffix:LIKE(invalid_name):TYPE(STRING10):0,0 \n'
    + 'FIELD:orig_gender:LIKE(invalid_gender):TYPE(STRING1):0,0   \n'
    + 'FIELD:orig_age:LIKE(invalid_age):TYPE(STRING2):0,0  \n'
    + 'FIELD:orig_dob:LIKE(invalid_dob):TYPE(STRING6):0,0 \n'
    + 'FIELD:orig_hhnbr:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_addrid:TYPE(STRING20):0,0\n'
    + 'FIELD:orig_address:TYPE(STRING64):0,0  \n'
    + 'FIELD:orig_house:TYPE(STRING10):0,0\n'
    + 'FIELD:orig_predir:TYPE(STRING2):0,0\n'
    + 'FIELD:orig_street:TYPE(STRING28):0,0\n'
    + 'FIELD:orig_strtype:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_postdir:TYPE(STRING2):0,0\n'
    + 'FIELD:orig_apttype:TYPE(STRING15):0,0\n'
    + 'FIELD:orig_aptnbr:TYPE(STRING15):0,0\n'
    + 'FIELD:orig_city:LIKE(invalid_city):TYPE(STRING28):0,0  \n'
    + 'FIELD:orig_state:LIKE(invalid_state):TYPE(STRING2):0,0     \n'
    + 'FIELD:orig_zip:LIKE(invalid_zip):TYPE(STRING5):0,0 \n'
    + 'FIELD:orig_z4:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_dpc:TYPE(STRING3):0,0\n'
    + 'FIELD:orig_z4type:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_crte:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_dpv:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_vacant:TYPE(STRING):0,0\n'
    + 'FIELD:orig_msa:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_cbsa:TYPE(STRING5):0,0\n'
    + 'FIELD:orig_dma:TYPE(STRING5):0,0\n'
    + 'FIELD:orig_county_code:TYPE(STRING3):0,0\n'
    + 'FIELD:orig_time_zone:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_daylight_savings:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_latitude:TYPE(STRING11):0,0\n'
    + 'FIELD:orig_longitude:TYPE(STRING11):0,0\n'
    + 'FIELD:orig_telephone_number_1:TYPE(STRING10):0,0\n'
    + 'FIELD:orig_dma_tps_dnc_flag_1:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_telephone_number_2:TYPE(STRING10):0,0\n'
    + 'FIELD:orig_dma_tps_dnc_flag_2:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_telephone_number_3:TYPE(STRING10):0,0\n'
    + 'FIELD:orig_dma_tps_dnc_flag_3:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_length_of_residence:TYPE(STRING3):0,0\n'
    + 'FIELD:orig_homeowner_renter:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_year_built:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_mobile_home_indicator:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_pool_owner:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_fireplace_in_home:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_estimated_income:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_marital_status:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_single_parent:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_senior_in_hh:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_credit_card_user:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_wealth_score_estimated_net_worth:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_donator_to_charity_or_causes:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_dwelling_type:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_home_market_value:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_education:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_ethnicity:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_child:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_child_age_ranges:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_number_of_children_in_hh:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_luxury_vehicle_owner:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_suv_owner:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_pickup_truck_owner:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_price_club_and_value_purchasing_indicator:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_womens_apparel_purchasing_indicator:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_mens_apparel_purchasing_indcator:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_parenting_and_childrens_interest_bundle:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_pet_lovers_or_owners:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_book_buyers:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_book_readers:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_hi_tech_enthusiasts:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_arts_bundle:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_collectibles_bundle:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_hobbies_home_and_garden_bundle:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_home_improvement:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_cooking_and_wine:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_gaming_and_gambling_enthusiast:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_travel_enthusiasts:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_physical_fitness:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_self_improvement:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_automotive_diy:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_spectator_sports_interest:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_outdoors:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_avid_investors:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_avid_interest_in_boating:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_avid_interest_in_motorcycling:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_black:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_white:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_hispanic:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_asian:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_english_speaking:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percnt_range_spanish_speaking:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_asian_speaking:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_sfdu:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_mfdu:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_mhv:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_mor:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_car:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_medschl:TYPE(STRING3):0,0\n'
    + 'FIELD:orig_penetration_range_white_collar:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_penetration_range_blue_collar:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_penetration_range_other_occupation:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_demolevel:TYPE(STRING1):0,0\n'
    + '\n'
    + '\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

