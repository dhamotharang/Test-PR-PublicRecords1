//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_American_Student_List.input_BWR_PopulationStatistics - Population Statistics - SALT V3.8.0');
IMPORT Scrubs_American_Student_List,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_American_Student_List.input_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* name_field */,/* first_name_field */,/* last_name_field */,/* address_1_field */,/* address_2_field */,/* city_field */,/* state_field */,/* z5_field */,/* zip_4_field */,/* crrt_code_field */,/* delivery_point_barcode_field */,/* zip4_check_digit_field */,/* address_type_field */,/* county_number_field */,/* county_name_field */,/* gender_field */,/* age_field */,/* birth_date_field */,/* telephone_field */,/* class_field */,/* college_class_field */,/* college_name_field */,/* college_major_field */,/* college_code_field */,/* college_type_field */,/* head_of_household_first_name_field */,/* head_of_household_gender_field */,/* income_level_field */,/* file_type_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
