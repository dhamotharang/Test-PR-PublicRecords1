// Machine-readable versions of the spec file and subsets thereof
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
  EXPORT spc_RIDFIELD := 'key'; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'basefile';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:key';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,orig_hhid,orig_pid,orig_fname,orig_mname,orig_lname,orig_suffix,orig_gender,orig_age,orig_dob,orig_hhnbr,orig_addrid,orig_address,orig_house,orig_predir,orig_street,orig_strtype,orig_postdir,orig_apttype,orig_aptnbr,orig_city,orig_state,orig_zip,orig_z4,orig_dpc,orig_z4type,orig_crte,orig_dpv,orig_vacant,orig_msa,orig_cbsa,orig_dma,orig_county_code,orig_time_zone,orig_daylight_savings,orig_latitude,orig_longitude,orig_telephonenumber_1,orig_dma_tps_dnc_flag_1,orig_telephonenumber_2,orig_dma_tps_dnc_flag_2,orig_telephonenumber_3,orig_dma_tps_dnc_flag_3,orig_length_of_residence,orig_homeowner,year_built,mobile_home_ind,pool_owner_ind,fireplace_ind,orig_estimatedincome,orig_married,single_parent_ind,senior_hh_ind,credit_card_user_ind,wealth_score,charity_donor_ind,orig_dwelling_type,home_marker_value,education_level,ethnicity,orig_child,child_age_range,orig_nbrchild,luxury_veh_owner_ind,suv_veh_owner_ind,truck_veh_ownere_ind,price_club_purchasing_ind,women_apparal_purchasing_ind,men_apparel_purchasing_ind,parent_child_interest_ind,pet_owner,book_buyer_ind,book_reader_ind,hi_tech_enthusiasts,arts,collectibles,hobbies_garden,home_improvement,cook_wine,gaming_gabling,travel_enthusiast,physical_fitness,self_improvement,automotive_diy,spectator_sport_interest,outdoors,avid_investors_ind,avid_boating_ind,avid_motorcycling_ind,orig_percent_range_black,orig_percent_range_white,orig_percent_range_hispanic,orig_percent_range_asian,orig_percent_range_english_speaking,orig_percnt_range_spanish_speaking,orig_percent_range_asian_speaking,orig_percent_range_sfdu,orig_percent_range_mfdu,orig_mhv,orig_mor,orig_car,orig_medschl,orig_penetration_range_whitecollar,orig_penetration_range_bluecollar,orig_penetration_range_otheroccupation,orig_demolevel,title,fname,mname,lname,name_suffix,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,rec_type,fips_st,fips_county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,did,did_score,clean_phone,clean_dob,process_date,date_first_seen,date_last_seen,date_vendor_first_reported,date_vendor_last_reported,record_type,src,rawaid,lexhhid';
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
    + '\n'
    + 'OPTIONS:-gn\n'
    + 'MODULE:Infutor_NARC3\n'
    + 'FILENAME:basefile\n'
    + 'NAMESCOPE:narc3\n'
    + 'RIDFIELD:key\n'
    + 'INGESTFILE:narc3_Update:NAMED(Infutor_NARC3.Files.base)\n'
    + '\n'
    + '\n'
    + 'FIELD:orig_hhid:DERIVED:TYPE(STRING20):0,0 \n'
    + 'FIELD:orig_pid:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:orig_fname:TYPE(STRING15):0,0 //\n'
    + 'FIELD:orig_mname:TYPE(STRING1):0,0 //  \n'
    + 'FIELD:orig_lname:TYPE(STRING20):0,0 //\n'
    + 'FIELD:orig_suffix:TYPE(STRING10):0,0 //\n'
    + 'FIELD:orig_gender:TYPE(STRING1):0,0 // \n'
    + 'FIELD:orig_age:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:orig_dob:DERIVED:TYPE(STRING6):0,0\n'
    + 'FIELD:orig_hhnbr:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_addrid:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:orig_address:TYPE(STRING64):0,0  //\n'
    + 'FIELD:orig_house:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:orig_predir:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:orig_street:DERIVED:TYPE(STRING28):0,0\n'
    + 'FIELD:orig_strtype:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_postdir:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:orig_apttype:DERIVED:TYPE(STRING15):0,0\n'
    + 'FIELD:orig_aptnbr:DERIVED:TYPE(STRING15):0,0\n'
    + 'FIELD:orig_city:TYPE(STRING28):0,0 //\n'
    + 'FIELD:orig_state:TYPE(STRING2):0,0 //\n'
    + 'FIELD:orig_zip:TYPE(STRING5):0,0 //\n'
    + 'FIELD:orig_z4:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_dpc:TYPE(STRING3):0,0 //\n'
    + 'FIELD:orig_z4type:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_crte:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_dpv:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_vacant:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_msa:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_cbsa:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:orig_dma:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:orig_county_code:DERIVED:TYPE(STRING3):0,0\n'
    + 'FIELD:orig_time_zone:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_daylight_savings:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_latitude:DERIVED:TYPE(STRING11):0,0\n'
    + 'FIELD:orig_longitude:DERIVED:TYPE(STRING11):0,0\n'
    + 'FIELD:orig_telephonenumber_1:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:orig_dma_tps_dnc_flag_1:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_telephonenumber_2:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:orig_dma_tps_dnc_flag_2:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_telephonenumber_3:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:orig_dma_tps_dnc_flag_3:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_length_of_residence:DERIVED:TYPE(STRING3):0,0\n'
    + 'FIELD:orig_homeowner:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:year_built:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:mobile_home_ind:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:pool_owner_ind:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:fireplace_ind:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_estimatedincome:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_married:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:single_parent_ind:DERIVED:TYPE(STRING1):0,0   \n'
    + 'FIELD:senior_hh_ind:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:credit_card_user_ind:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:wealth_score:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:charity_donor_ind:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_dwelling_type:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:home_marker_value:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:education_level:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:ethnicity:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_child:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:child_age_range:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_nbrchild:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:luxury_veh_owner_ind:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:suv_veh_owner_ind:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:truck_veh_ownere_ind:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:price_club_purchasing_ind:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:women_apparal_purchasing_ind:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:men_apparel_purchasing_ind:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:parent_child_interest_ind:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:pet_owner:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:book_buyer_ind:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:book_reader_ind:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:hi_tech_enthusiasts:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:arts:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:collectibles:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:hobbies_garden:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:home_improvement:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:cook_wine:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:gaming_gabling:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:travel_enthusiast:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:physical_fitness:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:self_improvement:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:automotive_diy:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:spectator_sport_interest:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:outdoors:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:avid_investors_ind:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:avid_boating_ind:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:avid_motorcycling_ind:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_black:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_white:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_hispanic:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_asian:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_english_speaking:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percnt_range_spanish_speaking:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_asian_speaking:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_sfdu:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_percent_range_mfdu:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_mhv:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_mor:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_car:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_medschl:DERIVED:TYPE(STRING3):0,0\n'
    + 'FIELD:orig_penetration_range_whitecollar:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_penetration_range_bluecollar:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_penetration_range_otheroccupation:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_demolevel:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:title:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:fname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:mname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:lname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:DERIVED:TYPE(STRING5):0,0\n'
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
    + 'FIELD:did_score:DERIVED:TYPE(UNSIGNED1):0,0\n'
    + 'FIELD:clean_phone:TYPE(STRING10):0,0  //\n'
    + 'FIELD:clean_dob:TYPE(STRING8):0,0  //\n'
    + 'FIELD:process_date:TYPE(STRING8):RECORDDATE(LAST):0,0\n'
    + 'FIELD:date_first_seen:TYPE(STRING8):RECORDDATE(FIRST):0,0  //\n'
    + 'FIELD:date_last_seen:TYPE(STRING8):RECORDDATE(LAST):0,0  //\n'
    + 'FIELD:date_vendor_first_reported:TYPE(STRING8):RECORDDATE(FIRST):0,0  //\n'
    + 'FIELD:date_vendor_last_reported:TYPE(STRING8):RECORDDATE(LAST):0,0  //\n'
    + 'FIELD:record_type:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:src:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:rawaid:DERIVED:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:lexhhid:DERIVED:TYPE(UNSIGNED6):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

