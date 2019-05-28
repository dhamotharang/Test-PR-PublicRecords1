IMPORT SALT311;
EXPORT raw_Fields := MODULE
 
EXPORT NumFields := 105;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_number','invalid_name','invalid_gender','invalid_dob','invalid_age','invalid_city','invalid_state','invalid_zip');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_number' => 2,'invalid_name' => 3,'invalid_gender' => 4,'invalid_dob' => 5,'invalid_age' => 6,'invalid_city' => 7,'invalid_state' => 8,'invalid_zip' => 9,0);
 
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ- \''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ- \''))));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ- \''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['M','F',' ']);
EXPORT InValidMessageFT_invalid_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('M|F| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dob(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dob(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_age(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_age(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_age(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_city(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_city(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['AK','AL','AR','AZ','CA','CO','CT','DC','DE','FL','GA','HI','IA','ID','IL','IN','KS','KY','LA','MA','MD','ME','MI','MN','MO','MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY','OH','OK','OR','PA','PR','RI','SC','SD','TN','TX','UT','VA','VT','WA','WI','WV','WY',' ']);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('AK|AL|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|IA|ID|IL|IN|KS|KY|LA|MA|MD|ME|MI|MN|MO|MS|MT|NC|ND|NE|NH|NJ|NM|NV|NY|OH|OK|OR|PA|PR|RI|SC|SD|TN|TX|UT|VA|VT|WA|WI|WV|WY| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'orig_hhid','orig_pid','orig_fname','orig_mname','orig_lname','orig_suffix','orig_gender','orig_age','orig_dob','orig_hhnbr','orig_addrid','orig_address','orig_house','orig_predir','orig_street','orig_strtype','orig_postdir','orig_apttype','orig_aptnbr','orig_city','orig_state','orig_zip','orig_z4','orig_dpc','orig_z4type','orig_crte','orig_dpv','orig_vacant','orig_msa','orig_cbsa','orig_dma','orig_county_code','orig_time_zone','orig_daylight_savings','orig_latitude','orig_longitude','orig_telephone_number_1','orig_dma_tps_dnc_flag_1','orig_telephone_number_2','orig_dma_tps_dnc_flag_2','orig_telephone_number_3','orig_dma_tps_dnc_flag_3','orig_length_of_residence','orig_homeowner_renter','orig_year_built','orig_mobile_home_indicator','orig_pool_owner','orig_fireplace_in_home','orig_estimated_income','orig_marital_status','orig_single_parent','orig_senior_in_hh','orig_credit_card_user','orig_wealth_score_estimated_net_worth','orig_donator_to_charity_or_causes','orig_dwelling_type','orig_home_market_value','orig_education','orig_ethnicity','orig_child','orig_child_age_ranges','orig_number_of_children_in_hh','orig_luxury_vehicle_owner','orig_suv_owner','orig_pickup_truck_owner','orig_price_club_and_value_purchasing_indicator','orig_womens_apparel_purchasing_indicator','orig_mens_apparel_purchasing_indcator','orig_parenting_and_childrens_interest_bundle','orig_pet_lovers_or_owners','orig_book_buyers','orig_book_readers','orig_hi_tech_enthusiasts','orig_arts_bundle','orig_collectibles_bundle','orig_hobbies_home_and_garden_bundle','orig_home_improvement','orig_cooking_and_wine','orig_gaming_and_gambling_enthusiast','orig_travel_enthusiasts','orig_physical_fitness','orig_self_improvement','orig_automotive_diy','orig_spectator_sports_interest','orig_outdoors','orig_avid_investors','orig_avid_interest_in_boating','orig_avid_interest_in_motorcycling','orig_percent_range_black','orig_percent_range_white','orig_percent_range_hispanic','orig_percent_range_asian','orig_percent_range_english_speaking','orig_percnt_range_spanish_speaking','orig_percent_range_asian_speaking','orig_percent_range_sfdu','orig_percent_range_mfdu','orig_mhv','orig_mor','orig_car','orig_medschl','orig_penetration_range_white_collar','orig_penetration_range_blue_collar','orig_penetration_range_other_occupation','orig_demolevel');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'orig_hhid','orig_pid','orig_fname','orig_mname','orig_lname','orig_suffix','orig_gender','orig_age','orig_dob','orig_hhnbr','orig_addrid','orig_address','orig_house','orig_predir','orig_street','orig_strtype','orig_postdir','orig_apttype','orig_aptnbr','orig_city','orig_state','orig_zip','orig_z4','orig_dpc','orig_z4type','orig_crte','orig_dpv','orig_vacant','orig_msa','orig_cbsa','orig_dma','orig_county_code','orig_time_zone','orig_daylight_savings','orig_latitude','orig_longitude','orig_telephone_number_1','orig_dma_tps_dnc_flag_1','orig_telephone_number_2','orig_dma_tps_dnc_flag_2','orig_telephone_number_3','orig_dma_tps_dnc_flag_3','orig_length_of_residence','orig_homeowner_renter','orig_year_built','orig_mobile_home_indicator','orig_pool_owner','orig_fireplace_in_home','orig_estimated_income','orig_marital_status','orig_single_parent','orig_senior_in_hh','orig_credit_card_user','orig_wealth_score_estimated_net_worth','orig_donator_to_charity_or_causes','orig_dwelling_type','orig_home_market_value','orig_education','orig_ethnicity','orig_child','orig_child_age_ranges','orig_number_of_children_in_hh','orig_luxury_vehicle_owner','orig_suv_owner','orig_pickup_truck_owner','orig_price_club_and_value_purchasing_indicator','orig_womens_apparel_purchasing_indicator','orig_mens_apparel_purchasing_indcator','orig_parenting_and_childrens_interest_bundle','orig_pet_lovers_or_owners','orig_book_buyers','orig_book_readers','orig_hi_tech_enthusiasts','orig_arts_bundle','orig_collectibles_bundle','orig_hobbies_home_and_garden_bundle','orig_home_improvement','orig_cooking_and_wine','orig_gaming_and_gambling_enthusiast','orig_travel_enthusiasts','orig_physical_fitness','orig_self_improvement','orig_automotive_diy','orig_spectator_sports_interest','orig_outdoors','orig_avid_investors','orig_avid_interest_in_boating','orig_avid_interest_in_motorcycling','orig_percent_range_black','orig_percent_range_white','orig_percent_range_hispanic','orig_percent_range_asian','orig_percent_range_english_speaking','orig_percnt_range_spanish_speaking','orig_percent_range_asian_speaking','orig_percent_range_sfdu','orig_percent_range_mfdu','orig_mhv','orig_mor','orig_car','orig_medschl','orig_penetration_range_white_collar','orig_penetration_range_blue_collar','orig_penetration_range_other_occupation','orig_demolevel');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'orig_hhid' => 0,'orig_pid' => 1,'orig_fname' => 2,'orig_mname' => 3,'orig_lname' => 4,'orig_suffix' => 5,'orig_gender' => 6,'orig_age' => 7,'orig_dob' => 8,'orig_hhnbr' => 9,'orig_addrid' => 10,'orig_address' => 11,'orig_house' => 12,'orig_predir' => 13,'orig_street' => 14,'orig_strtype' => 15,'orig_postdir' => 16,'orig_apttype' => 17,'orig_aptnbr' => 18,'orig_city' => 19,'orig_state' => 20,'orig_zip' => 21,'orig_z4' => 22,'orig_dpc' => 23,'orig_z4type' => 24,'orig_crte' => 25,'orig_dpv' => 26,'orig_vacant' => 27,'orig_msa' => 28,'orig_cbsa' => 29,'orig_dma' => 30,'orig_county_code' => 31,'orig_time_zone' => 32,'orig_daylight_savings' => 33,'orig_latitude' => 34,'orig_longitude' => 35,'orig_telephone_number_1' => 36,'orig_dma_tps_dnc_flag_1' => 37,'orig_telephone_number_2' => 38,'orig_dma_tps_dnc_flag_2' => 39,'orig_telephone_number_3' => 40,'orig_dma_tps_dnc_flag_3' => 41,'orig_length_of_residence' => 42,'orig_homeowner_renter' => 43,'orig_year_built' => 44,'orig_mobile_home_indicator' => 45,'orig_pool_owner' => 46,'orig_fireplace_in_home' => 47,'orig_estimated_income' => 48,'orig_marital_status' => 49,'orig_single_parent' => 50,'orig_senior_in_hh' => 51,'orig_credit_card_user' => 52,'orig_wealth_score_estimated_net_worth' => 53,'orig_donator_to_charity_or_causes' => 54,'orig_dwelling_type' => 55,'orig_home_market_value' => 56,'orig_education' => 57,'orig_ethnicity' => 58,'orig_child' => 59,'orig_child_age_ranges' => 60,'orig_number_of_children_in_hh' => 61,'orig_luxury_vehicle_owner' => 62,'orig_suv_owner' => 63,'orig_pickup_truck_owner' => 64,'orig_price_club_and_value_purchasing_indicator' => 65,'orig_womens_apparel_purchasing_indicator' => 66,'orig_mens_apparel_purchasing_indcator' => 67,'orig_parenting_and_childrens_interest_bundle' => 68,'orig_pet_lovers_or_owners' => 69,'orig_book_buyers' => 70,'orig_book_readers' => 71,'orig_hi_tech_enthusiasts' => 72,'orig_arts_bundle' => 73,'orig_collectibles_bundle' => 74,'orig_hobbies_home_and_garden_bundle' => 75,'orig_home_improvement' => 76,'orig_cooking_and_wine' => 77,'orig_gaming_and_gambling_enthusiast' => 78,'orig_travel_enthusiasts' => 79,'orig_physical_fitness' => 80,'orig_self_improvement' => 81,'orig_automotive_diy' => 82,'orig_spectator_sports_interest' => 83,'orig_outdoors' => 84,'orig_avid_investors' => 85,'orig_avid_interest_in_boating' => 86,'orig_avid_interest_in_motorcycling' => 87,'orig_percent_range_black' => 88,'orig_percent_range_white' => 89,'orig_percent_range_hispanic' => 90,'orig_percent_range_asian' => 91,'orig_percent_range_english_speaking' => 92,'orig_percnt_range_spanish_speaking' => 93,'orig_percent_range_asian_speaking' => 94,'orig_percent_range_sfdu' => 95,'orig_percent_range_mfdu' => 96,'orig_mhv' => 97,'orig_mor' => 98,'orig_car' => 99,'orig_medschl' => 100,'orig_penetration_range_white_collar' => 101,'orig_penetration_range_blue_collar' => 102,'orig_penetration_range_other_occupation' => 103,'orig_demolevel' => 104,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],[],[],[],[],[],[],[],[],[],[],['ALLOW'],['ENUM'],['ALLOW'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_orig_hhid(SALT311.StrType s0) := s0;
EXPORT InValid_orig_hhid(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_hhid(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_pid(SALT311.StrType s0) := s0;
EXPORT InValid_orig_pid(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_pid(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_fname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_orig_fname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_orig_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_orig_mname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_orig_mname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_orig_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_orig_lname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_orig_lname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_orig_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_orig_suffix(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_orig_suffix(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_orig_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_orig_gender(SALT311.StrType s0) := MakeFT_invalid_gender(s0);
EXPORT InValid_orig_gender(SALT311.StrType s) := InValidFT_invalid_gender(s);
EXPORT InValidMessage_orig_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender(wh);
 
EXPORT Make_orig_age(SALT311.StrType s0) := MakeFT_invalid_age(s0);
EXPORT InValid_orig_age(SALT311.StrType s) := InValidFT_invalid_age(s);
EXPORT InValidMessage_orig_age(UNSIGNED1 wh) := InValidMessageFT_invalid_age(wh);
 
EXPORT Make_orig_dob(SALT311.StrType s0) := MakeFT_invalid_dob(s0);
EXPORT InValid_orig_dob(SALT311.StrType s) := InValidFT_invalid_dob(s);
EXPORT InValidMessage_orig_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_dob(wh);
 
EXPORT Make_orig_hhnbr(SALT311.StrType s0) := s0;
EXPORT InValid_orig_hhnbr(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_hhnbr(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_addrid(SALT311.StrType s0) := s0;
EXPORT InValid_orig_addrid(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_addrid(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_address(SALT311.StrType s0) := s0;
EXPORT InValid_orig_address(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_address(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_house(SALT311.StrType s0) := s0;
EXPORT InValid_orig_house(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_house(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_predir(SALT311.StrType s0) := s0;
EXPORT InValid_orig_predir(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_street(SALT311.StrType s0) := s0;
EXPORT InValid_orig_street(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_street(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_strtype(SALT311.StrType s0) := s0;
EXPORT InValid_orig_strtype(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_strtype(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_postdir(SALT311.StrType s0) := s0;
EXPORT InValid_orig_postdir(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_apttype(SALT311.StrType s0) := s0;
EXPORT InValid_orig_apttype(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_apttype(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_aptnbr(SALT311.StrType s0) := s0;
EXPORT InValid_orig_aptnbr(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_aptnbr(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_city(SALT311.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_orig_city(SALT311.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
 
EXPORT Make_orig_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_orig_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_orig_zip(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_orig_zip(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_orig_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_orig_z4(SALT311.StrType s0) := s0;
EXPORT InValid_orig_z4(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_z4(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_dpc(SALT311.StrType s0) := s0;
EXPORT InValid_orig_dpc(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_dpc(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_z4type(SALT311.StrType s0) := s0;
EXPORT InValid_orig_z4type(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_z4type(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_crte(SALT311.StrType s0) := s0;
EXPORT InValid_orig_crte(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_crte(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_dpv(SALT311.StrType s0) := s0;
EXPORT InValid_orig_dpv(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_dpv(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_vacant(SALT311.StrType s0) := s0;
EXPORT InValid_orig_vacant(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_vacant(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_msa(SALT311.StrType s0) := s0;
EXPORT InValid_orig_msa(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_cbsa(SALT311.StrType s0) := s0;
EXPORT InValid_orig_cbsa(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_cbsa(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_dma(SALT311.StrType s0) := s0;
EXPORT InValid_orig_dma(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_dma(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_county_code(SALT311.StrType s0) := s0;
EXPORT InValid_orig_county_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_county_code(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_time_zone(SALT311.StrType s0) := s0;
EXPORT InValid_orig_time_zone(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_time_zone(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_daylight_savings(SALT311.StrType s0) := s0;
EXPORT InValid_orig_daylight_savings(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_daylight_savings(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_latitude(SALT311.StrType s0) := s0;
EXPORT InValid_orig_latitude(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_latitude(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_longitude(SALT311.StrType s0) := s0;
EXPORT InValid_orig_longitude(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_longitude(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_telephone_number_1(SALT311.StrType s0) := s0;
EXPORT InValid_orig_telephone_number_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_telephone_number_1(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_dma_tps_dnc_flag_1(SALT311.StrType s0) := s0;
EXPORT InValid_orig_dma_tps_dnc_flag_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_dma_tps_dnc_flag_1(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_telephone_number_2(SALT311.StrType s0) := s0;
EXPORT InValid_orig_telephone_number_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_telephone_number_2(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_dma_tps_dnc_flag_2(SALT311.StrType s0) := s0;
EXPORT InValid_orig_dma_tps_dnc_flag_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_dma_tps_dnc_flag_2(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_telephone_number_3(SALT311.StrType s0) := s0;
EXPORT InValid_orig_telephone_number_3(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_telephone_number_3(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_dma_tps_dnc_flag_3(SALT311.StrType s0) := s0;
EXPORT InValid_orig_dma_tps_dnc_flag_3(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_dma_tps_dnc_flag_3(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_length_of_residence(SALT311.StrType s0) := s0;
EXPORT InValid_orig_length_of_residence(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_length_of_residence(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_homeowner_renter(SALT311.StrType s0) := s0;
EXPORT InValid_orig_homeowner_renter(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_homeowner_renter(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_year_built(SALT311.StrType s0) := s0;
EXPORT InValid_orig_year_built(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_year_built(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_mobile_home_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_orig_mobile_home_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_mobile_home_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_pool_owner(SALT311.StrType s0) := s0;
EXPORT InValid_orig_pool_owner(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_pool_owner(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_fireplace_in_home(SALT311.StrType s0) := s0;
EXPORT InValid_orig_fireplace_in_home(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_fireplace_in_home(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_estimated_income(SALT311.StrType s0) := s0;
EXPORT InValid_orig_estimated_income(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_estimated_income(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_marital_status(SALT311.StrType s0) := s0;
EXPORT InValid_orig_marital_status(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_marital_status(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_single_parent(SALT311.StrType s0) := s0;
EXPORT InValid_orig_single_parent(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_single_parent(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_senior_in_hh(SALT311.StrType s0) := s0;
EXPORT InValid_orig_senior_in_hh(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_senior_in_hh(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_credit_card_user(SALT311.StrType s0) := s0;
EXPORT InValid_orig_credit_card_user(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_credit_card_user(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_wealth_score_estimated_net_worth(SALT311.StrType s0) := s0;
EXPORT InValid_orig_wealth_score_estimated_net_worth(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_wealth_score_estimated_net_worth(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_donator_to_charity_or_causes(SALT311.StrType s0) := s0;
EXPORT InValid_orig_donator_to_charity_or_causes(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_donator_to_charity_or_causes(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_dwelling_type(SALT311.StrType s0) := s0;
EXPORT InValid_orig_dwelling_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_dwelling_type(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_home_market_value(SALT311.StrType s0) := s0;
EXPORT InValid_orig_home_market_value(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_home_market_value(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_education(SALT311.StrType s0) := s0;
EXPORT InValid_orig_education(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_education(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_ethnicity(SALT311.StrType s0) := s0;
EXPORT InValid_orig_ethnicity(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_ethnicity(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_child(SALT311.StrType s0) := s0;
EXPORT InValid_orig_child(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_child(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_child_age_ranges(SALT311.StrType s0) := s0;
EXPORT InValid_orig_child_age_ranges(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_child_age_ranges(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_number_of_children_in_hh(SALT311.StrType s0) := s0;
EXPORT InValid_orig_number_of_children_in_hh(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_number_of_children_in_hh(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_luxury_vehicle_owner(SALT311.StrType s0) := s0;
EXPORT InValid_orig_luxury_vehicle_owner(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_luxury_vehicle_owner(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_suv_owner(SALT311.StrType s0) := s0;
EXPORT InValid_orig_suv_owner(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_suv_owner(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_pickup_truck_owner(SALT311.StrType s0) := s0;
EXPORT InValid_orig_pickup_truck_owner(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_pickup_truck_owner(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_price_club_and_value_purchasing_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_orig_price_club_and_value_purchasing_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_price_club_and_value_purchasing_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_womens_apparel_purchasing_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_orig_womens_apparel_purchasing_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_womens_apparel_purchasing_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_mens_apparel_purchasing_indcator(SALT311.StrType s0) := s0;
EXPORT InValid_orig_mens_apparel_purchasing_indcator(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_mens_apparel_purchasing_indcator(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_parenting_and_childrens_interest_bundle(SALT311.StrType s0) := s0;
EXPORT InValid_orig_parenting_and_childrens_interest_bundle(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_parenting_and_childrens_interest_bundle(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_pet_lovers_or_owners(SALT311.StrType s0) := s0;
EXPORT InValid_orig_pet_lovers_or_owners(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_pet_lovers_or_owners(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_book_buyers(SALT311.StrType s0) := s0;
EXPORT InValid_orig_book_buyers(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_book_buyers(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_book_readers(SALT311.StrType s0) := s0;
EXPORT InValid_orig_book_readers(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_book_readers(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_hi_tech_enthusiasts(SALT311.StrType s0) := s0;
EXPORT InValid_orig_hi_tech_enthusiasts(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_hi_tech_enthusiasts(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_arts_bundle(SALT311.StrType s0) := s0;
EXPORT InValid_orig_arts_bundle(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_arts_bundle(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_collectibles_bundle(SALT311.StrType s0) := s0;
EXPORT InValid_orig_collectibles_bundle(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_collectibles_bundle(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_hobbies_home_and_garden_bundle(SALT311.StrType s0) := s0;
EXPORT InValid_orig_hobbies_home_and_garden_bundle(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_hobbies_home_and_garden_bundle(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_home_improvement(SALT311.StrType s0) := s0;
EXPORT InValid_orig_home_improvement(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_home_improvement(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_cooking_and_wine(SALT311.StrType s0) := s0;
EXPORT InValid_orig_cooking_and_wine(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_cooking_and_wine(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_gaming_and_gambling_enthusiast(SALT311.StrType s0) := s0;
EXPORT InValid_orig_gaming_and_gambling_enthusiast(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_gaming_and_gambling_enthusiast(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_travel_enthusiasts(SALT311.StrType s0) := s0;
EXPORT InValid_orig_travel_enthusiasts(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_travel_enthusiasts(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_physical_fitness(SALT311.StrType s0) := s0;
EXPORT InValid_orig_physical_fitness(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_physical_fitness(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_self_improvement(SALT311.StrType s0) := s0;
EXPORT InValid_orig_self_improvement(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_self_improvement(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_automotive_diy(SALT311.StrType s0) := s0;
EXPORT InValid_orig_automotive_diy(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_automotive_diy(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_spectator_sports_interest(SALT311.StrType s0) := s0;
EXPORT InValid_orig_spectator_sports_interest(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_spectator_sports_interest(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_outdoors(SALT311.StrType s0) := s0;
EXPORT InValid_orig_outdoors(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_outdoors(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_avid_investors(SALT311.StrType s0) := s0;
EXPORT InValid_orig_avid_investors(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_avid_investors(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_avid_interest_in_boating(SALT311.StrType s0) := s0;
EXPORT InValid_orig_avid_interest_in_boating(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_avid_interest_in_boating(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_avid_interest_in_motorcycling(SALT311.StrType s0) := s0;
EXPORT InValid_orig_avid_interest_in_motorcycling(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_avid_interest_in_motorcycling(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_percent_range_black(SALT311.StrType s0) := s0;
EXPORT InValid_orig_percent_range_black(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_percent_range_black(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_percent_range_white(SALT311.StrType s0) := s0;
EXPORT InValid_orig_percent_range_white(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_percent_range_white(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_percent_range_hispanic(SALT311.StrType s0) := s0;
EXPORT InValid_orig_percent_range_hispanic(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_percent_range_hispanic(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_percent_range_asian(SALT311.StrType s0) := s0;
EXPORT InValid_orig_percent_range_asian(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_percent_range_asian(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_percent_range_english_speaking(SALT311.StrType s0) := s0;
EXPORT InValid_orig_percent_range_english_speaking(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_percent_range_english_speaking(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_percnt_range_spanish_speaking(SALT311.StrType s0) := s0;
EXPORT InValid_orig_percnt_range_spanish_speaking(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_percnt_range_spanish_speaking(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_percent_range_asian_speaking(SALT311.StrType s0) := s0;
EXPORT InValid_orig_percent_range_asian_speaking(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_percent_range_asian_speaking(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_percent_range_sfdu(SALT311.StrType s0) := s0;
EXPORT InValid_orig_percent_range_sfdu(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_percent_range_sfdu(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_percent_range_mfdu(SALT311.StrType s0) := s0;
EXPORT InValid_orig_percent_range_mfdu(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_percent_range_mfdu(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_mhv(SALT311.StrType s0) := s0;
EXPORT InValid_orig_mhv(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_mhv(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_mor(SALT311.StrType s0) := s0;
EXPORT InValid_orig_mor(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_mor(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_car(SALT311.StrType s0) := s0;
EXPORT InValid_orig_car(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_car(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_medschl(SALT311.StrType s0) := s0;
EXPORT InValid_orig_medschl(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_medschl(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_penetration_range_white_collar(SALT311.StrType s0) := s0;
EXPORT InValid_orig_penetration_range_white_collar(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_penetration_range_white_collar(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_penetration_range_blue_collar(SALT311.StrType s0) := s0;
EXPORT InValid_orig_penetration_range_blue_collar(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_penetration_range_blue_collar(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_penetration_range_other_occupation(SALT311.StrType s0) := s0;
EXPORT InValid_orig_penetration_range_other_occupation(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_penetration_range_other_occupation(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_demolevel(SALT311.StrType s0) := s0;
EXPORT InValid_orig_demolevel(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_demolevel(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,scrubs_infutor_narc3;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_orig_hhid;
    BOOLEAN Diff_orig_pid;
    BOOLEAN Diff_orig_fname;
    BOOLEAN Diff_orig_mname;
    BOOLEAN Diff_orig_lname;
    BOOLEAN Diff_orig_suffix;
    BOOLEAN Diff_orig_gender;
    BOOLEAN Diff_orig_age;
    BOOLEAN Diff_orig_dob;
    BOOLEAN Diff_orig_hhnbr;
    BOOLEAN Diff_orig_addrid;
    BOOLEAN Diff_orig_address;
    BOOLEAN Diff_orig_house;
    BOOLEAN Diff_orig_predir;
    BOOLEAN Diff_orig_street;
    BOOLEAN Diff_orig_strtype;
    BOOLEAN Diff_orig_postdir;
    BOOLEAN Diff_orig_apttype;
    BOOLEAN Diff_orig_aptnbr;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip;
    BOOLEAN Diff_orig_z4;
    BOOLEAN Diff_orig_dpc;
    BOOLEAN Diff_orig_z4type;
    BOOLEAN Diff_orig_crte;
    BOOLEAN Diff_orig_dpv;
    BOOLEAN Diff_orig_vacant;
    BOOLEAN Diff_orig_msa;
    BOOLEAN Diff_orig_cbsa;
    BOOLEAN Diff_orig_dma;
    BOOLEAN Diff_orig_county_code;
    BOOLEAN Diff_orig_time_zone;
    BOOLEAN Diff_orig_daylight_savings;
    BOOLEAN Diff_orig_latitude;
    BOOLEAN Diff_orig_longitude;
    BOOLEAN Diff_orig_telephone_number_1;
    BOOLEAN Diff_orig_dma_tps_dnc_flag_1;
    BOOLEAN Diff_orig_telephone_number_2;
    BOOLEAN Diff_orig_dma_tps_dnc_flag_2;
    BOOLEAN Diff_orig_telephone_number_3;
    BOOLEAN Diff_orig_dma_tps_dnc_flag_3;
    BOOLEAN Diff_orig_length_of_residence;
    BOOLEAN Diff_orig_homeowner_renter;
    BOOLEAN Diff_orig_year_built;
    BOOLEAN Diff_orig_mobile_home_indicator;
    BOOLEAN Diff_orig_pool_owner;
    BOOLEAN Diff_orig_fireplace_in_home;
    BOOLEAN Diff_orig_estimated_income;
    BOOLEAN Diff_orig_marital_status;
    BOOLEAN Diff_orig_single_parent;
    BOOLEAN Diff_orig_senior_in_hh;
    BOOLEAN Diff_orig_credit_card_user;
    BOOLEAN Diff_orig_wealth_score_estimated_net_worth;
    BOOLEAN Diff_orig_donator_to_charity_or_causes;
    BOOLEAN Diff_orig_dwelling_type;
    BOOLEAN Diff_orig_home_market_value;
    BOOLEAN Diff_orig_education;
    BOOLEAN Diff_orig_ethnicity;
    BOOLEAN Diff_orig_child;
    BOOLEAN Diff_orig_child_age_ranges;
    BOOLEAN Diff_orig_number_of_children_in_hh;
    BOOLEAN Diff_orig_luxury_vehicle_owner;
    BOOLEAN Diff_orig_suv_owner;
    BOOLEAN Diff_orig_pickup_truck_owner;
    BOOLEAN Diff_orig_price_club_and_value_purchasing_indicator;
    BOOLEAN Diff_orig_womens_apparel_purchasing_indicator;
    BOOLEAN Diff_orig_mens_apparel_purchasing_indcator;
    BOOLEAN Diff_orig_parenting_and_childrens_interest_bundle;
    BOOLEAN Diff_orig_pet_lovers_or_owners;
    BOOLEAN Diff_orig_book_buyers;
    BOOLEAN Diff_orig_book_readers;
    BOOLEAN Diff_orig_hi_tech_enthusiasts;
    BOOLEAN Diff_orig_arts_bundle;
    BOOLEAN Diff_orig_collectibles_bundle;
    BOOLEAN Diff_orig_hobbies_home_and_garden_bundle;
    BOOLEAN Diff_orig_home_improvement;
    BOOLEAN Diff_orig_cooking_and_wine;
    BOOLEAN Diff_orig_gaming_and_gambling_enthusiast;
    BOOLEAN Diff_orig_travel_enthusiasts;
    BOOLEAN Diff_orig_physical_fitness;
    BOOLEAN Diff_orig_self_improvement;
    BOOLEAN Diff_orig_automotive_diy;
    BOOLEAN Diff_orig_spectator_sports_interest;
    BOOLEAN Diff_orig_outdoors;
    BOOLEAN Diff_orig_avid_investors;
    BOOLEAN Diff_orig_avid_interest_in_boating;
    BOOLEAN Diff_orig_avid_interest_in_motorcycling;
    BOOLEAN Diff_orig_percent_range_black;
    BOOLEAN Diff_orig_percent_range_white;
    BOOLEAN Diff_orig_percent_range_hispanic;
    BOOLEAN Diff_orig_percent_range_asian;
    BOOLEAN Diff_orig_percent_range_english_speaking;
    BOOLEAN Diff_orig_percnt_range_spanish_speaking;
    BOOLEAN Diff_orig_percent_range_asian_speaking;
    BOOLEAN Diff_orig_percent_range_sfdu;
    BOOLEAN Diff_orig_percent_range_mfdu;
    BOOLEAN Diff_orig_mhv;
    BOOLEAN Diff_orig_mor;
    BOOLEAN Diff_orig_car;
    BOOLEAN Diff_orig_medschl;
    BOOLEAN Diff_orig_penetration_range_white_collar;
    BOOLEAN Diff_orig_penetration_range_blue_collar;
    BOOLEAN Diff_orig_penetration_range_other_occupation;
    BOOLEAN Diff_orig_demolevel;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_orig_hhid := le.orig_hhid <> ri.orig_hhid;
    SELF.Diff_orig_pid := le.orig_pid <> ri.orig_pid;
    SELF.Diff_orig_fname := le.orig_fname <> ri.orig_fname;
    SELF.Diff_orig_mname := le.orig_mname <> ri.orig_mname;
    SELF.Diff_orig_lname := le.orig_lname <> ri.orig_lname;
    SELF.Diff_orig_suffix := le.orig_suffix <> ri.orig_suffix;
    SELF.Diff_orig_gender := le.orig_gender <> ri.orig_gender;
    SELF.Diff_orig_age := le.orig_age <> ri.orig_age;
    SELF.Diff_orig_dob := le.orig_dob <> ri.orig_dob;
    SELF.Diff_orig_hhnbr := le.orig_hhnbr <> ri.orig_hhnbr;
    SELF.Diff_orig_addrid := le.orig_addrid <> ri.orig_addrid;
    SELF.Diff_orig_address := le.orig_address <> ri.orig_address;
    SELF.Diff_orig_house := le.orig_house <> ri.orig_house;
    SELF.Diff_orig_predir := le.orig_predir <> ri.orig_predir;
    SELF.Diff_orig_street := le.orig_street <> ri.orig_street;
    SELF.Diff_orig_strtype := le.orig_strtype <> ri.orig_strtype;
    SELF.Diff_orig_postdir := le.orig_postdir <> ri.orig_postdir;
    SELF.Diff_orig_apttype := le.orig_apttype <> ri.orig_apttype;
    SELF.Diff_orig_aptnbr := le.orig_aptnbr <> ri.orig_aptnbr;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip := le.orig_zip <> ri.orig_zip;
    SELF.Diff_orig_z4 := le.orig_z4 <> ri.orig_z4;
    SELF.Diff_orig_dpc := le.orig_dpc <> ri.orig_dpc;
    SELF.Diff_orig_z4type := le.orig_z4type <> ri.orig_z4type;
    SELF.Diff_orig_crte := le.orig_crte <> ri.orig_crte;
    SELF.Diff_orig_dpv := le.orig_dpv <> ri.orig_dpv;
    SELF.Diff_orig_vacant := le.orig_vacant <> ri.orig_vacant;
    SELF.Diff_orig_msa := le.orig_msa <> ri.orig_msa;
    SELF.Diff_orig_cbsa := le.orig_cbsa <> ri.orig_cbsa;
    SELF.Diff_orig_dma := le.orig_dma <> ri.orig_dma;
    SELF.Diff_orig_county_code := le.orig_county_code <> ri.orig_county_code;
    SELF.Diff_orig_time_zone := le.orig_time_zone <> ri.orig_time_zone;
    SELF.Diff_orig_daylight_savings := le.orig_daylight_savings <> ri.orig_daylight_savings;
    SELF.Diff_orig_latitude := le.orig_latitude <> ri.orig_latitude;
    SELF.Diff_orig_longitude := le.orig_longitude <> ri.orig_longitude;
    SELF.Diff_orig_telephone_number_1 := le.orig_telephone_number_1 <> ri.orig_telephone_number_1;
    SELF.Diff_orig_dma_tps_dnc_flag_1 := le.orig_dma_tps_dnc_flag_1 <> ri.orig_dma_tps_dnc_flag_1;
    SELF.Diff_orig_telephone_number_2 := le.orig_telephone_number_2 <> ri.orig_telephone_number_2;
    SELF.Diff_orig_dma_tps_dnc_flag_2 := le.orig_dma_tps_dnc_flag_2 <> ri.orig_dma_tps_dnc_flag_2;
    SELF.Diff_orig_telephone_number_3 := le.orig_telephone_number_3 <> ri.orig_telephone_number_3;
    SELF.Diff_orig_dma_tps_dnc_flag_3 := le.orig_dma_tps_dnc_flag_3 <> ri.orig_dma_tps_dnc_flag_3;
    SELF.Diff_orig_length_of_residence := le.orig_length_of_residence <> ri.orig_length_of_residence;
    SELF.Diff_orig_homeowner_renter := le.orig_homeowner_renter <> ri.orig_homeowner_renter;
    SELF.Diff_orig_year_built := le.orig_year_built <> ri.orig_year_built;
    SELF.Diff_orig_mobile_home_indicator := le.orig_mobile_home_indicator <> ri.orig_mobile_home_indicator;
    SELF.Diff_orig_pool_owner := le.orig_pool_owner <> ri.orig_pool_owner;
    SELF.Diff_orig_fireplace_in_home := le.orig_fireplace_in_home <> ri.orig_fireplace_in_home;
    SELF.Diff_orig_estimated_income := le.orig_estimated_income <> ri.orig_estimated_income;
    SELF.Diff_orig_marital_status := le.orig_marital_status <> ri.orig_marital_status;
    SELF.Diff_orig_single_parent := le.orig_single_parent <> ri.orig_single_parent;
    SELF.Diff_orig_senior_in_hh := le.orig_senior_in_hh <> ri.orig_senior_in_hh;
    SELF.Diff_orig_credit_card_user := le.orig_credit_card_user <> ri.orig_credit_card_user;
    SELF.Diff_orig_wealth_score_estimated_net_worth := le.orig_wealth_score_estimated_net_worth <> ri.orig_wealth_score_estimated_net_worth;
    SELF.Diff_orig_donator_to_charity_or_causes := le.orig_donator_to_charity_or_causes <> ri.orig_donator_to_charity_or_causes;
    SELF.Diff_orig_dwelling_type := le.orig_dwelling_type <> ri.orig_dwelling_type;
    SELF.Diff_orig_home_market_value := le.orig_home_market_value <> ri.orig_home_market_value;
    SELF.Diff_orig_education := le.orig_education <> ri.orig_education;
    SELF.Diff_orig_ethnicity := le.orig_ethnicity <> ri.orig_ethnicity;
    SELF.Diff_orig_child := le.orig_child <> ri.orig_child;
    SELF.Diff_orig_child_age_ranges := le.orig_child_age_ranges <> ri.orig_child_age_ranges;
    SELF.Diff_orig_number_of_children_in_hh := le.orig_number_of_children_in_hh <> ri.orig_number_of_children_in_hh;
    SELF.Diff_orig_luxury_vehicle_owner := le.orig_luxury_vehicle_owner <> ri.orig_luxury_vehicle_owner;
    SELF.Diff_orig_suv_owner := le.orig_suv_owner <> ri.orig_suv_owner;
    SELF.Diff_orig_pickup_truck_owner := le.orig_pickup_truck_owner <> ri.orig_pickup_truck_owner;
    SELF.Diff_orig_price_club_and_value_purchasing_indicator := le.orig_price_club_and_value_purchasing_indicator <> ri.orig_price_club_and_value_purchasing_indicator;
    SELF.Diff_orig_womens_apparel_purchasing_indicator := le.orig_womens_apparel_purchasing_indicator <> ri.orig_womens_apparel_purchasing_indicator;
    SELF.Diff_orig_mens_apparel_purchasing_indcator := le.orig_mens_apparel_purchasing_indcator <> ri.orig_mens_apparel_purchasing_indcator;
    SELF.Diff_orig_parenting_and_childrens_interest_bundle := le.orig_parenting_and_childrens_interest_bundle <> ri.orig_parenting_and_childrens_interest_bundle;
    SELF.Diff_orig_pet_lovers_or_owners := le.orig_pet_lovers_or_owners <> ri.orig_pet_lovers_or_owners;
    SELF.Diff_orig_book_buyers := le.orig_book_buyers <> ri.orig_book_buyers;
    SELF.Diff_orig_book_readers := le.orig_book_readers <> ri.orig_book_readers;
    SELF.Diff_orig_hi_tech_enthusiasts := le.orig_hi_tech_enthusiasts <> ri.orig_hi_tech_enthusiasts;
    SELF.Diff_orig_arts_bundle := le.orig_arts_bundle <> ri.orig_arts_bundle;
    SELF.Diff_orig_collectibles_bundle := le.orig_collectibles_bundle <> ri.orig_collectibles_bundle;
    SELF.Diff_orig_hobbies_home_and_garden_bundle := le.orig_hobbies_home_and_garden_bundle <> ri.orig_hobbies_home_and_garden_bundle;
    SELF.Diff_orig_home_improvement := le.orig_home_improvement <> ri.orig_home_improvement;
    SELF.Diff_orig_cooking_and_wine := le.orig_cooking_and_wine <> ri.orig_cooking_and_wine;
    SELF.Diff_orig_gaming_and_gambling_enthusiast := le.orig_gaming_and_gambling_enthusiast <> ri.orig_gaming_and_gambling_enthusiast;
    SELF.Diff_orig_travel_enthusiasts := le.orig_travel_enthusiasts <> ri.orig_travel_enthusiasts;
    SELF.Diff_orig_physical_fitness := le.orig_physical_fitness <> ri.orig_physical_fitness;
    SELF.Diff_orig_self_improvement := le.orig_self_improvement <> ri.orig_self_improvement;
    SELF.Diff_orig_automotive_diy := le.orig_automotive_diy <> ri.orig_automotive_diy;
    SELF.Diff_orig_spectator_sports_interest := le.orig_spectator_sports_interest <> ri.orig_spectator_sports_interest;
    SELF.Diff_orig_outdoors := le.orig_outdoors <> ri.orig_outdoors;
    SELF.Diff_orig_avid_investors := le.orig_avid_investors <> ri.orig_avid_investors;
    SELF.Diff_orig_avid_interest_in_boating := le.orig_avid_interest_in_boating <> ri.orig_avid_interest_in_boating;
    SELF.Diff_orig_avid_interest_in_motorcycling := le.orig_avid_interest_in_motorcycling <> ri.orig_avid_interest_in_motorcycling;
    SELF.Diff_orig_percent_range_black := le.orig_percent_range_black <> ri.orig_percent_range_black;
    SELF.Diff_orig_percent_range_white := le.orig_percent_range_white <> ri.orig_percent_range_white;
    SELF.Diff_orig_percent_range_hispanic := le.orig_percent_range_hispanic <> ri.orig_percent_range_hispanic;
    SELF.Diff_orig_percent_range_asian := le.orig_percent_range_asian <> ri.orig_percent_range_asian;
    SELF.Diff_orig_percent_range_english_speaking := le.orig_percent_range_english_speaking <> ri.orig_percent_range_english_speaking;
    SELF.Diff_orig_percnt_range_spanish_speaking := le.orig_percnt_range_spanish_speaking <> ri.orig_percnt_range_spanish_speaking;
    SELF.Diff_orig_percent_range_asian_speaking := le.orig_percent_range_asian_speaking <> ri.orig_percent_range_asian_speaking;
    SELF.Diff_orig_percent_range_sfdu := le.orig_percent_range_sfdu <> ri.orig_percent_range_sfdu;
    SELF.Diff_orig_percent_range_mfdu := le.orig_percent_range_mfdu <> ri.orig_percent_range_mfdu;
    SELF.Diff_orig_mhv := le.orig_mhv <> ri.orig_mhv;
    SELF.Diff_orig_mor := le.orig_mor <> ri.orig_mor;
    SELF.Diff_orig_car := le.orig_car <> ri.orig_car;
    SELF.Diff_orig_medschl := le.orig_medschl <> ri.orig_medschl;
    SELF.Diff_orig_penetration_range_white_collar := le.orig_penetration_range_white_collar <> ri.orig_penetration_range_white_collar;
    SELF.Diff_orig_penetration_range_blue_collar := le.orig_penetration_range_blue_collar <> ri.orig_penetration_range_blue_collar;
    SELF.Diff_orig_penetration_range_other_occupation := le.orig_penetration_range_other_occupation <> ri.orig_penetration_range_other_occupation;
    SELF.Diff_orig_demolevel := le.orig_demolevel <> ri.orig_demolevel;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_orig_hhid,1,0)+ IF( SELF.Diff_orig_pid,1,0)+ IF( SELF.Diff_orig_fname,1,0)+ IF( SELF.Diff_orig_mname,1,0)+ IF( SELF.Diff_orig_lname,1,0)+ IF( SELF.Diff_orig_suffix,1,0)+ IF( SELF.Diff_orig_gender,1,0)+ IF( SELF.Diff_orig_age,1,0)+ IF( SELF.Diff_orig_dob,1,0)+ IF( SELF.Diff_orig_hhnbr,1,0)+ IF( SELF.Diff_orig_addrid,1,0)+ IF( SELF.Diff_orig_address,1,0)+ IF( SELF.Diff_orig_house,1,0)+ IF( SELF.Diff_orig_predir,1,0)+ IF( SELF.Diff_orig_street,1,0)+ IF( SELF.Diff_orig_strtype,1,0)+ IF( SELF.Diff_orig_postdir,1,0)+ IF( SELF.Diff_orig_apttype,1,0)+ IF( SELF.Diff_orig_aptnbr,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_orig_z4,1,0)+ IF( SELF.Diff_orig_dpc,1,0)+ IF( SELF.Diff_orig_z4type,1,0)+ IF( SELF.Diff_orig_crte,1,0)+ IF( SELF.Diff_orig_dpv,1,0)+ IF( SELF.Diff_orig_vacant,1,0)+ IF( SELF.Diff_orig_msa,1,0)+ IF( SELF.Diff_orig_cbsa,1,0)+ IF( SELF.Diff_orig_dma,1,0)+ IF( SELF.Diff_orig_county_code,1,0)+ IF( SELF.Diff_orig_time_zone,1,0)+ IF( SELF.Diff_orig_daylight_savings,1,0)+ IF( SELF.Diff_orig_latitude,1,0)+ IF( SELF.Diff_orig_longitude,1,0)+ IF( SELF.Diff_orig_telephone_number_1,1,0)+ IF( SELF.Diff_orig_dma_tps_dnc_flag_1,1,0)+ IF( SELF.Diff_orig_telephone_number_2,1,0)+ IF( SELF.Diff_orig_dma_tps_dnc_flag_2,1,0)+ IF( SELF.Diff_orig_telephone_number_3,1,0)+ IF( SELF.Diff_orig_dma_tps_dnc_flag_3,1,0)+ IF( SELF.Diff_orig_length_of_residence,1,0)+ IF( SELF.Diff_orig_homeowner_renter,1,0)+ IF( SELF.Diff_orig_year_built,1,0)+ IF( SELF.Diff_orig_mobile_home_indicator,1,0)+ IF( SELF.Diff_orig_pool_owner,1,0)+ IF( SELF.Diff_orig_fireplace_in_home,1,0)+ IF( SELF.Diff_orig_estimated_income,1,0)+ IF( SELF.Diff_orig_marital_status,1,0)+ IF( SELF.Diff_orig_single_parent,1,0)+ IF( SELF.Diff_orig_senior_in_hh,1,0)+ IF( SELF.Diff_orig_credit_card_user,1,0)+ IF( SELF.Diff_orig_wealth_score_estimated_net_worth,1,0)+ IF( SELF.Diff_orig_donator_to_charity_or_causes,1,0)+ IF( SELF.Diff_orig_dwelling_type,1,0)+ IF( SELF.Diff_orig_home_market_value,1,0)+ IF( SELF.Diff_orig_education,1,0)+ IF( SELF.Diff_orig_ethnicity,1,0)+ IF( SELF.Diff_orig_child,1,0)+ IF( SELF.Diff_orig_child_age_ranges,1,0)+ IF( SELF.Diff_orig_number_of_children_in_hh,1,0)+ IF( SELF.Diff_orig_luxury_vehicle_owner,1,0)+ IF( SELF.Diff_orig_suv_owner,1,0)+ IF( SELF.Diff_orig_pickup_truck_owner,1,0)+ IF( SELF.Diff_orig_price_club_and_value_purchasing_indicator,1,0)+ IF( SELF.Diff_orig_womens_apparel_purchasing_indicator,1,0)+ IF( SELF.Diff_orig_mens_apparel_purchasing_indcator,1,0)+ IF( SELF.Diff_orig_parenting_and_childrens_interest_bundle,1,0)+ IF( SELF.Diff_orig_pet_lovers_or_owners,1,0)+ IF( SELF.Diff_orig_book_buyers,1,0)+ IF( SELF.Diff_orig_book_readers,1,0)+ IF( SELF.Diff_orig_hi_tech_enthusiasts,1,0)+ IF( SELF.Diff_orig_arts_bundle,1,0)+ IF( SELF.Diff_orig_collectibles_bundle,1,0)+ IF( SELF.Diff_orig_hobbies_home_and_garden_bundle,1,0)+ IF( SELF.Diff_orig_home_improvement,1,0)+ IF( SELF.Diff_orig_cooking_and_wine,1,0)+ IF( SELF.Diff_orig_gaming_and_gambling_enthusiast,1,0)+ IF( SELF.Diff_orig_travel_enthusiasts,1,0)+ IF( SELF.Diff_orig_physical_fitness,1,0)+ IF( SELF.Diff_orig_self_improvement,1,0)+ IF( SELF.Diff_orig_automotive_diy,1,0)+ IF( SELF.Diff_orig_spectator_sports_interest,1,0)+ IF( SELF.Diff_orig_outdoors,1,0)+ IF( SELF.Diff_orig_avid_investors,1,0)+ IF( SELF.Diff_orig_avid_interest_in_boating,1,0)+ IF( SELF.Diff_orig_avid_interest_in_motorcycling,1,0)+ IF( SELF.Diff_orig_percent_range_black,1,0)+ IF( SELF.Diff_orig_percent_range_white,1,0)+ IF( SELF.Diff_orig_percent_range_hispanic,1,0)+ IF( SELF.Diff_orig_percent_range_asian,1,0)+ IF( SELF.Diff_orig_percent_range_english_speaking,1,0)+ IF( SELF.Diff_orig_percnt_range_spanish_speaking,1,0)+ IF( SELF.Diff_orig_percent_range_asian_speaking,1,0)+ IF( SELF.Diff_orig_percent_range_sfdu,1,0)+ IF( SELF.Diff_orig_percent_range_mfdu,1,0)+ IF( SELF.Diff_orig_mhv,1,0)+ IF( SELF.Diff_orig_mor,1,0)+ IF( SELF.Diff_orig_car,1,0)+ IF( SELF.Diff_orig_medschl,1,0)+ IF( SELF.Diff_orig_penetration_range_white_collar,1,0)+ IF( SELF.Diff_orig_penetration_range_blue_collar,1,0)+ IF( SELF.Diff_orig_penetration_range_other_occupation,1,0)+ IF( SELF.Diff_orig_demolevel,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_orig_hhid := COUNT(GROUP,%Closest%.Diff_orig_hhid);
    Count_Diff_orig_pid := COUNT(GROUP,%Closest%.Diff_orig_pid);
    Count_Diff_orig_fname := COUNT(GROUP,%Closest%.Diff_orig_fname);
    Count_Diff_orig_mname := COUNT(GROUP,%Closest%.Diff_orig_mname);
    Count_Diff_orig_lname := COUNT(GROUP,%Closest%.Diff_orig_lname);
    Count_Diff_orig_suffix := COUNT(GROUP,%Closest%.Diff_orig_suffix);
    Count_Diff_orig_gender := COUNT(GROUP,%Closest%.Diff_orig_gender);
    Count_Diff_orig_age := COUNT(GROUP,%Closest%.Diff_orig_age);
    Count_Diff_orig_dob := COUNT(GROUP,%Closest%.Diff_orig_dob);
    Count_Diff_orig_hhnbr := COUNT(GROUP,%Closest%.Diff_orig_hhnbr);
    Count_Diff_orig_addrid := COUNT(GROUP,%Closest%.Diff_orig_addrid);
    Count_Diff_orig_address := COUNT(GROUP,%Closest%.Diff_orig_address);
    Count_Diff_orig_house := COUNT(GROUP,%Closest%.Diff_orig_house);
    Count_Diff_orig_predir := COUNT(GROUP,%Closest%.Diff_orig_predir);
    Count_Diff_orig_street := COUNT(GROUP,%Closest%.Diff_orig_street);
    Count_Diff_orig_strtype := COUNT(GROUP,%Closest%.Diff_orig_strtype);
    Count_Diff_orig_postdir := COUNT(GROUP,%Closest%.Diff_orig_postdir);
    Count_Diff_orig_apttype := COUNT(GROUP,%Closest%.Diff_orig_apttype);
    Count_Diff_orig_aptnbr := COUNT(GROUP,%Closest%.Diff_orig_aptnbr);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip := COUNT(GROUP,%Closest%.Diff_orig_zip);
    Count_Diff_orig_z4 := COUNT(GROUP,%Closest%.Diff_orig_z4);
    Count_Diff_orig_dpc := COUNT(GROUP,%Closest%.Diff_orig_dpc);
    Count_Diff_orig_z4type := COUNT(GROUP,%Closest%.Diff_orig_z4type);
    Count_Diff_orig_crte := COUNT(GROUP,%Closest%.Diff_orig_crte);
    Count_Diff_orig_dpv := COUNT(GROUP,%Closest%.Diff_orig_dpv);
    Count_Diff_orig_vacant := COUNT(GROUP,%Closest%.Diff_orig_vacant);
    Count_Diff_orig_msa := COUNT(GROUP,%Closest%.Diff_orig_msa);
    Count_Diff_orig_cbsa := COUNT(GROUP,%Closest%.Diff_orig_cbsa);
    Count_Diff_orig_dma := COUNT(GROUP,%Closest%.Diff_orig_dma);
    Count_Diff_orig_county_code := COUNT(GROUP,%Closest%.Diff_orig_county_code);
    Count_Diff_orig_time_zone := COUNT(GROUP,%Closest%.Diff_orig_time_zone);
    Count_Diff_orig_daylight_savings := COUNT(GROUP,%Closest%.Diff_orig_daylight_savings);
    Count_Diff_orig_latitude := COUNT(GROUP,%Closest%.Diff_orig_latitude);
    Count_Diff_orig_longitude := COUNT(GROUP,%Closest%.Diff_orig_longitude);
    Count_Diff_orig_telephone_number_1 := COUNT(GROUP,%Closest%.Diff_orig_telephone_number_1);
    Count_Diff_orig_dma_tps_dnc_flag_1 := COUNT(GROUP,%Closest%.Diff_orig_dma_tps_dnc_flag_1);
    Count_Diff_orig_telephone_number_2 := COUNT(GROUP,%Closest%.Diff_orig_telephone_number_2);
    Count_Diff_orig_dma_tps_dnc_flag_2 := COUNT(GROUP,%Closest%.Diff_orig_dma_tps_dnc_flag_2);
    Count_Diff_orig_telephone_number_3 := COUNT(GROUP,%Closest%.Diff_orig_telephone_number_3);
    Count_Diff_orig_dma_tps_dnc_flag_3 := COUNT(GROUP,%Closest%.Diff_orig_dma_tps_dnc_flag_3);
    Count_Diff_orig_length_of_residence := COUNT(GROUP,%Closest%.Diff_orig_length_of_residence);
    Count_Diff_orig_homeowner_renter := COUNT(GROUP,%Closest%.Diff_orig_homeowner_renter);
    Count_Diff_orig_year_built := COUNT(GROUP,%Closest%.Diff_orig_year_built);
    Count_Diff_orig_mobile_home_indicator := COUNT(GROUP,%Closest%.Diff_orig_mobile_home_indicator);
    Count_Diff_orig_pool_owner := COUNT(GROUP,%Closest%.Diff_orig_pool_owner);
    Count_Diff_orig_fireplace_in_home := COUNT(GROUP,%Closest%.Diff_orig_fireplace_in_home);
    Count_Diff_orig_estimated_income := COUNT(GROUP,%Closest%.Diff_orig_estimated_income);
    Count_Diff_orig_marital_status := COUNT(GROUP,%Closest%.Diff_orig_marital_status);
    Count_Diff_orig_single_parent := COUNT(GROUP,%Closest%.Diff_orig_single_parent);
    Count_Diff_orig_senior_in_hh := COUNT(GROUP,%Closest%.Diff_orig_senior_in_hh);
    Count_Diff_orig_credit_card_user := COUNT(GROUP,%Closest%.Diff_orig_credit_card_user);
    Count_Diff_orig_wealth_score_estimated_net_worth := COUNT(GROUP,%Closest%.Diff_orig_wealth_score_estimated_net_worth);
    Count_Diff_orig_donator_to_charity_or_causes := COUNT(GROUP,%Closest%.Diff_orig_donator_to_charity_or_causes);
    Count_Diff_orig_dwelling_type := COUNT(GROUP,%Closest%.Diff_orig_dwelling_type);
    Count_Diff_orig_home_market_value := COUNT(GROUP,%Closest%.Diff_orig_home_market_value);
    Count_Diff_orig_education := COUNT(GROUP,%Closest%.Diff_orig_education);
    Count_Diff_orig_ethnicity := COUNT(GROUP,%Closest%.Diff_orig_ethnicity);
    Count_Diff_orig_child := COUNT(GROUP,%Closest%.Diff_orig_child);
    Count_Diff_orig_child_age_ranges := COUNT(GROUP,%Closest%.Diff_orig_child_age_ranges);
    Count_Diff_orig_number_of_children_in_hh := COUNT(GROUP,%Closest%.Diff_orig_number_of_children_in_hh);
    Count_Diff_orig_luxury_vehicle_owner := COUNT(GROUP,%Closest%.Diff_orig_luxury_vehicle_owner);
    Count_Diff_orig_suv_owner := COUNT(GROUP,%Closest%.Diff_orig_suv_owner);
    Count_Diff_orig_pickup_truck_owner := COUNT(GROUP,%Closest%.Diff_orig_pickup_truck_owner);
    Count_Diff_orig_price_club_and_value_purchasing_indicator := COUNT(GROUP,%Closest%.Diff_orig_price_club_and_value_purchasing_indicator);
    Count_Diff_orig_womens_apparel_purchasing_indicator := COUNT(GROUP,%Closest%.Diff_orig_womens_apparel_purchasing_indicator);
    Count_Diff_orig_mens_apparel_purchasing_indcator := COUNT(GROUP,%Closest%.Diff_orig_mens_apparel_purchasing_indcator);
    Count_Diff_orig_parenting_and_childrens_interest_bundle := COUNT(GROUP,%Closest%.Diff_orig_parenting_and_childrens_interest_bundle);
    Count_Diff_orig_pet_lovers_or_owners := COUNT(GROUP,%Closest%.Diff_orig_pet_lovers_or_owners);
    Count_Diff_orig_book_buyers := COUNT(GROUP,%Closest%.Diff_orig_book_buyers);
    Count_Diff_orig_book_readers := COUNT(GROUP,%Closest%.Diff_orig_book_readers);
    Count_Diff_orig_hi_tech_enthusiasts := COUNT(GROUP,%Closest%.Diff_orig_hi_tech_enthusiasts);
    Count_Diff_orig_arts_bundle := COUNT(GROUP,%Closest%.Diff_orig_arts_bundle);
    Count_Diff_orig_collectibles_bundle := COUNT(GROUP,%Closest%.Diff_orig_collectibles_bundle);
    Count_Diff_orig_hobbies_home_and_garden_bundle := COUNT(GROUP,%Closest%.Diff_orig_hobbies_home_and_garden_bundle);
    Count_Diff_orig_home_improvement := COUNT(GROUP,%Closest%.Diff_orig_home_improvement);
    Count_Diff_orig_cooking_and_wine := COUNT(GROUP,%Closest%.Diff_orig_cooking_and_wine);
    Count_Diff_orig_gaming_and_gambling_enthusiast := COUNT(GROUP,%Closest%.Diff_orig_gaming_and_gambling_enthusiast);
    Count_Diff_orig_travel_enthusiasts := COUNT(GROUP,%Closest%.Diff_orig_travel_enthusiasts);
    Count_Diff_orig_physical_fitness := COUNT(GROUP,%Closest%.Diff_orig_physical_fitness);
    Count_Diff_orig_self_improvement := COUNT(GROUP,%Closest%.Diff_orig_self_improvement);
    Count_Diff_orig_automotive_diy := COUNT(GROUP,%Closest%.Diff_orig_automotive_diy);
    Count_Diff_orig_spectator_sports_interest := COUNT(GROUP,%Closest%.Diff_orig_spectator_sports_interest);
    Count_Diff_orig_outdoors := COUNT(GROUP,%Closest%.Diff_orig_outdoors);
    Count_Diff_orig_avid_investors := COUNT(GROUP,%Closest%.Diff_orig_avid_investors);
    Count_Diff_orig_avid_interest_in_boating := COUNT(GROUP,%Closest%.Diff_orig_avid_interest_in_boating);
    Count_Diff_orig_avid_interest_in_motorcycling := COUNT(GROUP,%Closest%.Diff_orig_avid_interest_in_motorcycling);
    Count_Diff_orig_percent_range_black := COUNT(GROUP,%Closest%.Diff_orig_percent_range_black);
    Count_Diff_orig_percent_range_white := COUNT(GROUP,%Closest%.Diff_orig_percent_range_white);
    Count_Diff_orig_percent_range_hispanic := COUNT(GROUP,%Closest%.Diff_orig_percent_range_hispanic);
    Count_Diff_orig_percent_range_asian := COUNT(GROUP,%Closest%.Diff_orig_percent_range_asian);
    Count_Diff_orig_percent_range_english_speaking := COUNT(GROUP,%Closest%.Diff_orig_percent_range_english_speaking);
    Count_Diff_orig_percnt_range_spanish_speaking := COUNT(GROUP,%Closest%.Diff_orig_percnt_range_spanish_speaking);
    Count_Diff_orig_percent_range_asian_speaking := COUNT(GROUP,%Closest%.Diff_orig_percent_range_asian_speaking);
    Count_Diff_orig_percent_range_sfdu := COUNT(GROUP,%Closest%.Diff_orig_percent_range_sfdu);
    Count_Diff_orig_percent_range_mfdu := COUNT(GROUP,%Closest%.Diff_orig_percent_range_mfdu);
    Count_Diff_orig_mhv := COUNT(GROUP,%Closest%.Diff_orig_mhv);
    Count_Diff_orig_mor := COUNT(GROUP,%Closest%.Diff_orig_mor);
    Count_Diff_orig_car := COUNT(GROUP,%Closest%.Diff_orig_car);
    Count_Diff_orig_medschl := COUNT(GROUP,%Closest%.Diff_orig_medschl);
    Count_Diff_orig_penetration_range_white_collar := COUNT(GROUP,%Closest%.Diff_orig_penetration_range_white_collar);
    Count_Diff_orig_penetration_range_blue_collar := COUNT(GROUP,%Closest%.Diff_orig_penetration_range_blue_collar);
    Count_Diff_orig_penetration_range_other_occupation := COUNT(GROUP,%Closest%.Diff_orig_penetration_range_other_occupation);
    Count_Diff_orig_demolevel := COUNT(GROUP,%Closest%.Diff_orig_demolevel);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
