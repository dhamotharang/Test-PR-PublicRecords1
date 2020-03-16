﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Advo.BWR_PopulationStatistics - Population Statistics - SALT V3.11.9');
IMPORT Advo,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Advo.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* ZIP_5_field */,/* Route_Num_field */,/* ZIP_4_field */,/* WALK_Sequence_field */,/* STREET_NUM_field */,/* STREET_PRE_DIRectional_field */,/* STREET_NAME_field */,/* STREET_POST_DIRectional_field */,/* STREET_SUFFIX_field */,/* Secondary_Unit_Designator_field */,/* Secondary_Unit_Number_field */,/* Address_Vacancy_Indicator_field */,/* Throw_Back_Indicator_field */,/* Seasonal_Delivery_Indicator_field */,/* Seasonal_Start_Suppression_Date_field */,/* Seasonal_End_Suppression_Date_field */,/* DND_Indicator_field */,/* College_Indicator_field */,/* College_Start_Suppression_Date_field */,/* College_End_Suppression_Date_field */,/* Address_Style_Flag_field */,/* Simplify_Address_Count_field */,/* Drop_Indicator_field */,/* Residential_or_Business_Ind_field */,/* DPBC_Digit_field */,/* DPBC_Check_Digit_field */,/* Update_Date_field */,/* File_Release_Date_field */,/* Override_file_release_date_field */,/* County_Num_field */,/* County_Name_field */,/* City_Name_field */,/* State_Code_field */,/* State_Num_field */,/* Congressional_District_Number_field */,/* OWGM_Indicator_field */,/* Record_Type_Code_field */,/* ADVO_Key_field */,/* Address_Type_field */,/* Mixed_Address_Usage_field */,/* date_first_seen_field */,/* date_last_seen_field */,/* date_vendor_first_reported_field */,/* date_vendor_last_reported_field */,/* VAC_BEGDT_field */,/* VAC_ENDDT_field */,/* MONTHS_VAC_CURR_field */,/* MONTHS_VAC_MAX_field */,/* VAC_COUNT_field */,/* prim_range_field */,/* predir_field */,/* prim_name_field */,/* addr_suffix_field */,/* postdir_field */,/* unit_desig_field */,/* sec_range_field */,/* p_city_name_field */,/* v_city_name_field */,/* st_field */,/* zip_field */,/* zip4_field */,/* cart_field */,/* cr_sort_sz_field */,/* lot_field */,/* lot_order_field */,/* dbpc_field */,/* chk_digit_field */,/* rec_type_field */,/* fips_county_field */,/* county_field */,/* geo_lat_field */,/* geo_long_field */,/* msa_field */,/* geo_blk_field */,/* geo_match_field */,/* err_stat_field */,/* RawAID_field */,/* cleanaid_field */,/* addresstype_field */,/* Active_flag_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
