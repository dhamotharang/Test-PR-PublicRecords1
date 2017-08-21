IMPORT ut,SALT32;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Raw_Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT32.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_nums','invalid_residence_len','invalid_gender','invalid_gender_code','invalid_alpha','invalid_address','invalid_csz','invalid_county_name','invalid_zip','invalid_zip4','invalid_date','invalid_suffix','invalid_indicator','invalid_validation_flag','invalid_mhv','invalid_penetration_percentage_ranges','invalid_child_num','invalid_dwelling_type','invalid_homeowner','invalid_time_zone');
EXPORT FieldTypeNum(SALT32.StrType fn) := CASE(fn,'invalid_nums' => 1,'invalid_residence_len' => 2,'invalid_gender' => 3,'invalid_gender_code' => 4,'invalid_alpha' => 5,'invalid_address' => 6,'invalid_csz' => 7,'invalid_county_name' => 8,'invalid_zip' => 9,'invalid_zip4' => 10,'invalid_date' => 11,'invalid_suffix' => 12,'invalid_indicator' => 13,'invalid_validation_flag' => 14,'invalid_mhv' => 15,'invalid_penetration_percentage_ranges' => 16,'invalid_child_num' => 17,'invalid_dwelling_type' => 18,'invalid_homeowner' => 19,'invalid_time_zone' => 20,0);
 
EXPORT MakeFT_invalid_nums(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_nums(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_nums(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_residence_len(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789. '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_residence_len(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789. '))));
EXPORT InValidMessageFT_invalid_residence_len(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('0123456789. '),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN ['M','F','']);
EXPORT InValidMessageFT_invalid_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('M|F|'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender_code(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender_code(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN ['1','2','']);
EXPORT InValidMessageFT_invalid_gender_code(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('1|2|'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz- '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz- '))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz- '),SALT32.HygieneErrors.NotLength('1..'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_address(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_csz(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' ,-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_csz(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' ,-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))));
EXPORT InValidMessageFT_invalid_csz(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars(' ,-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_county_name(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_county_name(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'))),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' -',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' -',' ')) = 2 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' -',' ')) = 3 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' -',' ')) = 4 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' -',' ')) = 5));
EXPORT InValidMessageFT_invalid_county_name(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'),SALT32.HygieneErrors.NotWords('1,2,3,4,5'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('0123456789'),SALT32.HygieneErrors.NotLength('5,9'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip4(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip4(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('0123456789'),SALT32.HygieneErrors.NotLength('0,4'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date(SALT32.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_suffix(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_suffix(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),((SALT32.StrType) s) NOT IN ['SR','JR','I','II','III','IV','V','VI','VII','VIII','IX','X','8TH','']);
EXPORT InValidMessageFT_invalid_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT32.HygieneErrors.NotInEnum('SR|JR|I|II|III|IV|V|VI|VII|VIII|IX|X|8TH|'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_indicator(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_indicator(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN ['Y','N','']);
EXPORT InValidMessageFT_invalid_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('Y|N|'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_validation_flag(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_validation_flag(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN ['C','N','']);
EXPORT InValidMessageFT_invalid_validation_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('C|N|'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mhv(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mhv(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN ['A','B','C','D','E','F','G','H','I','']);
EXPORT InValidMessageFT_invalid_mhv(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('A|B|C|D|E|F|G|H|I|'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_penetration_percentage_ranges(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_penetration_percentage_ranges(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','']);
EXPORT InValidMessageFT_invalid_penetration_percentage_ranges(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_child_num(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_child_num(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN ['0','1','2','3','4','5','6','7','8','9','']);
EXPORT InValidMessageFT_invalid_child_num(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('0|1|2|3|4|5|6|7|8|9|'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dwelling_type(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dwelling_type(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN ['A','B','C','D','']);
EXPORT InValidMessageFT_invalid_dwelling_type(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('A|B|C|D|'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_homeowner(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_homeowner(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN ['H','R','']);
EXPORT InValidMessageFT_invalid_homeowner(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('H|R|'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_time_zone(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_time_zone(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN ['2','3','4','5','6','7','8','']);
EXPORT InValidMessageFT_invalid_time_zone(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('2|3|4|5|6|7|8|'),SALT32.HygieneErrors.Good);
 
EXPORT SALT32.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'orig_hhid','orig_pid','orig_fname','orig_mname','orig_lname','orig_suffix','orig_gender','orig_age','orig_dob','orig_hhnbr','orig_tot_males','orig_tot_females','orig_addrid','orig_address','orig_house','orig_predir','orig_street','orig_strtype','orig_postdir','orig_apttype','orig_aptnbr','orig_city','orig_state','orig_zip','orig_z4','orig_dpc','orig_z4type','orig_crte','orig_dpv','orig_vacant','orig_msa','orig_cbsa','orig_county_code','orig_time_zone','orig_daylight_savings','orig_lat_long_assignment_level','orig_latitude','orig_longitude','orig_telephonenumber_1','orig_validationflag_1','orig_validationdate_1','orig_dma_tps_dnc_flag_1','orig_telephonenumber_2','orig_validation_flag_2','orig_validation_date_2','orig_dma_tps_dnc_flag_2','orig_telephonenumber_3','orig_validationflag_3','orig_validationdate_3','orig_dma_tps_dnc_flag_3','orig_telephonenumber_4','orig_validationflag_4','orig_validationdate_4','orig_dma_tps_dnc_flag_4','orig_telephonenumber_5','orig_validationflag_5','orig_validationdate_5','orig_dma_tps_dnc_flag_5','orig_telephonenumber_6','orig_validationflag_6','orig_validationdate_6','orig_dma_tps_dnc_flag_6','orig_telephonenumber_7','orig_validationflag_7','orig_validationdate_7','orig_dma_tps_dnc_flag_7','orig_tot_phones','orig_length_of_residence','orig_homeowner','orig_estimatedincome','orig_dwelling_type','orig_married','orig_child','orig_nbrchild','orig_teencd','orig_percent_range_black','orig_percent_range_white','orig_percent_range_hispanic','orig_percent_range_asian','orig_percent_range_english_speaking','orig_percnt_range_spanish_speaking','orig_percent_range_asian_speaking','orig_percent_range_sfdu','orig_percent_range_mfdu','orig_mhv','orig_mor','orig_car','orig_medschl','orig_penetration_range_whitecollar','orig_penetration_range_bluecollar','orig_penetration_range_otheroccupation','orig_demolevel','orig_recdate');
EXPORT FieldNum(SALT32.StrType fn) := CASE(fn,'orig_hhid' => 0,'orig_pid' => 1,'orig_fname' => 2,'orig_mname' => 3,'orig_lname' => 4,'orig_suffix' => 5,'orig_gender' => 6,'orig_age' => 7,'orig_dob' => 8,'orig_hhnbr' => 9,'orig_tot_males' => 10,'orig_tot_females' => 11,'orig_addrid' => 12,'orig_address' => 13,'orig_house' => 14,'orig_predir' => 15,'orig_street' => 16,'orig_strtype' => 17,'orig_postdir' => 18,'orig_apttype' => 19,'orig_aptnbr' => 20,'orig_city' => 21,'orig_state' => 22,'orig_zip' => 23,'orig_z4' => 24,'orig_dpc' => 25,'orig_z4type' => 26,'orig_crte' => 27,'orig_dpv' => 28,'orig_vacant' => 29,'orig_msa' => 30,'orig_cbsa' => 31,'orig_county_code' => 32,'orig_time_zone' => 33,'orig_daylight_savings' => 34,'orig_lat_long_assignment_level' => 35,'orig_latitude' => 36,'orig_longitude' => 37,'orig_telephonenumber_1' => 38,'orig_validationflag_1' => 39,'orig_validationdate_1' => 40,'orig_dma_tps_dnc_flag_1' => 41,'orig_telephonenumber_2' => 42,'orig_validation_flag_2' => 43,'orig_validation_date_2' => 44,'orig_dma_tps_dnc_flag_2' => 45,'orig_telephonenumber_3' => 46,'orig_validationflag_3' => 47,'orig_validationdate_3' => 48,'orig_dma_tps_dnc_flag_3' => 49,'orig_telephonenumber_4' => 50,'orig_validationflag_4' => 51,'orig_validationdate_4' => 52,'orig_dma_tps_dnc_flag_4' => 53,'orig_telephonenumber_5' => 54,'orig_validationflag_5' => 55,'orig_validationdate_5' => 56,'orig_dma_tps_dnc_flag_5' => 57,'orig_telephonenumber_6' => 58,'orig_validationflag_6' => 59,'orig_validationdate_6' => 60,'orig_dma_tps_dnc_flag_6' => 61,'orig_telephonenumber_7' => 62,'orig_validationflag_7' => 63,'orig_validationdate_7' => 64,'orig_dma_tps_dnc_flag_7' => 65,'orig_tot_phones' => 66,'orig_length_of_residence' => 67,'orig_homeowner' => 68,'orig_estimatedincome' => 69,'orig_dwelling_type' => 70,'orig_married' => 71,'orig_child' => 72,'orig_nbrchild' => 73,'orig_teencd' => 74,'orig_percent_range_black' => 75,'orig_percent_range_white' => 76,'orig_percent_range_hispanic' => 77,'orig_percent_range_asian' => 78,'orig_percent_range_english_speaking' => 79,'orig_percnt_range_spanish_speaking' => 80,'orig_percent_range_asian_speaking' => 81,'orig_percent_range_sfdu' => 82,'orig_percent_range_mfdu' => 83,'orig_mhv' => 84,'orig_mor' => 85,'orig_car' => 86,'orig_medschl' => 87,'orig_penetration_range_whitecollar' => 88,'orig_penetration_range_bluecollar' => 89,'orig_penetration_range_otheroccupation' => 90,'orig_demolevel' => 91,'orig_recdate' => 92,0);
 
//Individual field level validation
 
EXPORT Make_orig_hhid(SALT32.StrType s0) := s0;
EXPORT InValid_orig_hhid(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_orig_hhid(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_pid(SALT32.StrType s0) := s0;
EXPORT InValid_orig_pid(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_orig_pid(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_fname(SALT32.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_orig_fname(SALT32.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_orig_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_orig_mname(SALT32.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_orig_mname(SALT32.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_orig_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_orig_lname(SALT32.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_orig_lname(SALT32.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_orig_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_orig_suffix(SALT32.StrType s0) := MakeFT_invalid_suffix(s0);
EXPORT InValid_orig_suffix(SALT32.StrType s) := InValidFT_invalid_suffix(s);
EXPORT InValidMessage_orig_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_suffix(wh);
 
EXPORT Make_orig_gender(SALT32.StrType s0) := MakeFT_invalid_gender(s0);
EXPORT InValid_orig_gender(SALT32.StrType s) := InValidFT_invalid_gender(s);
EXPORT InValidMessage_orig_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender(wh);
 
EXPORT Make_orig_age(SALT32.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_orig_age(SALT32.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_orig_age(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_orig_dob(SALT32.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_orig_dob(SALT32.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_orig_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_orig_hhnbr(SALT32.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_orig_hhnbr(SALT32.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_orig_hhnbr(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_orig_tot_males(SALT32.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_orig_tot_males(SALT32.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_orig_tot_males(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_orig_tot_females(SALT32.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_orig_tot_females(SALT32.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_orig_tot_females(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_orig_addrid(SALT32.StrType s0) := s0;
EXPORT InValid_orig_addrid(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_orig_addrid(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_address(SALT32.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_orig_address(SALT32.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_orig_address(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_orig_house(SALT32.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_orig_house(SALT32.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_orig_house(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_orig_predir(SALT32.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_orig_predir(SALT32.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_orig_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_orig_street(SALT32.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_orig_street(SALT32.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_orig_street(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_orig_strtype(SALT32.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_orig_strtype(SALT32.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_orig_strtype(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_orig_postdir(SALT32.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_orig_postdir(SALT32.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_orig_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_orig_apttype(SALT32.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_orig_apttype(SALT32.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_orig_apttype(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_orig_aptnbr(SALT32.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_orig_aptnbr(SALT32.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_orig_aptnbr(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_orig_city(SALT32.StrType s0) := MakeFT_invalid_county_name(s0);
EXPORT InValid_orig_city(SALT32.StrType s) := InValidFT_invalid_county_name(s);
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := InValidMessageFT_invalid_county_name(wh);
 
EXPORT Make_orig_state(SALT32.StrType s0) := s0;
EXPORT InValid_orig_state(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_zip(SALT32.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_orig_zip(SALT32.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_orig_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_orig_z4(SALT32.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_orig_z4(SALT32.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_orig_z4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_orig_dpc(SALT32.StrType s0) := s0;
EXPORT InValid_orig_dpc(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_orig_dpc(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_z4type(SALT32.StrType s0) := s0;
EXPORT InValid_orig_z4type(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_orig_z4type(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_crte(SALT32.StrType s0) := s0;
EXPORT InValid_orig_crte(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_orig_crte(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_dpv(SALT32.StrType s0) := s0;
EXPORT InValid_orig_dpv(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_orig_dpv(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_vacant(SALT32.StrType s0) := MakeFT_invalid_indicator(s0);
EXPORT InValid_orig_vacant(SALT32.StrType s) := InValidFT_invalid_indicator(s);
EXPORT InValidMessage_orig_vacant(UNSIGNED1 wh) := InValidMessageFT_invalid_indicator(wh);
 
EXPORT Make_orig_msa(SALT32.StrType s0) := s0;
EXPORT InValid_orig_msa(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_orig_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_cbsa(SALT32.StrType s0) := s0;
EXPORT InValid_orig_cbsa(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_orig_cbsa(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_county_code(SALT32.StrType s0) := s0;
EXPORT InValid_orig_county_code(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_orig_county_code(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_time_zone(SALT32.StrType s0) := MakeFT_invalid_time_zone(s0);
EXPORT InValid_orig_time_zone(SALT32.StrType s) := InValidFT_invalid_time_zone(s);
EXPORT InValidMessage_orig_time_zone(UNSIGNED1 wh) := InValidMessageFT_invalid_time_zone(wh);
 
EXPORT Make_orig_daylight_savings(SALT32.StrType s0) := s0;
EXPORT InValid_orig_daylight_savings(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_orig_daylight_savings(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_lat_long_assignment_level(SALT32.StrType s0) := s0;
EXPORT InValid_orig_lat_long_assignment_level(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_orig_lat_long_assignment_level(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_latitude(SALT32.StrType s0) := s0;
EXPORT InValid_orig_latitude(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_orig_latitude(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_longitude(SALT32.StrType s0) := s0;
EXPORT InValid_orig_longitude(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_orig_longitude(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_telephonenumber_1(SALT32.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_orig_telephonenumber_1(SALT32.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_orig_telephonenumber_1(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_orig_validationflag_1(SALT32.StrType s0) := MakeFT_invalid_validation_flag(s0);
EXPORT InValid_orig_validationflag_1(SALT32.StrType s) := InValidFT_invalid_validation_flag(s);
EXPORT InValidMessage_orig_validationflag_1(UNSIGNED1 wh) := InValidMessageFT_invalid_validation_flag(wh);
 
EXPORT Make_orig_validationdate_1(SALT32.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_orig_validationdate_1(SALT32.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_orig_validationdate_1(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_orig_dma_tps_dnc_flag_1(SALT32.StrType s0) := MakeFT_invalid_indicator(s0);
EXPORT InValid_orig_dma_tps_dnc_flag_1(SALT32.StrType s) := InValidFT_invalid_indicator(s);
EXPORT InValidMessage_orig_dma_tps_dnc_flag_1(UNSIGNED1 wh) := InValidMessageFT_invalid_indicator(wh);
 
EXPORT Make_orig_telephonenumber_2(SALT32.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_orig_telephonenumber_2(SALT32.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_orig_telephonenumber_2(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_orig_validation_flag_2(SALT32.StrType s0) := MakeFT_invalid_validation_flag(s0);
EXPORT InValid_orig_validation_flag_2(SALT32.StrType s) := InValidFT_invalid_validation_flag(s);
EXPORT InValidMessage_orig_validation_flag_2(UNSIGNED1 wh) := InValidMessageFT_invalid_validation_flag(wh);
 
EXPORT Make_orig_validation_date_2(SALT32.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_orig_validation_date_2(SALT32.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_orig_validation_date_2(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_orig_dma_tps_dnc_flag_2(SALT32.StrType s0) := MakeFT_invalid_indicator(s0);
EXPORT InValid_orig_dma_tps_dnc_flag_2(SALT32.StrType s) := InValidFT_invalid_indicator(s);
EXPORT InValidMessage_orig_dma_tps_dnc_flag_2(UNSIGNED1 wh) := InValidMessageFT_invalid_indicator(wh);
 
EXPORT Make_orig_telephonenumber_3(SALT32.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_orig_telephonenumber_3(SALT32.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_orig_telephonenumber_3(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_orig_validationflag_3(SALT32.StrType s0) := MakeFT_invalid_validation_flag(s0);
EXPORT InValid_orig_validationflag_3(SALT32.StrType s) := InValidFT_invalid_validation_flag(s);
EXPORT InValidMessage_orig_validationflag_3(UNSIGNED1 wh) := InValidMessageFT_invalid_validation_flag(wh);
 
EXPORT Make_orig_validationdate_3(SALT32.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_orig_validationdate_3(SALT32.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_orig_validationdate_3(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_orig_dma_tps_dnc_flag_3(SALT32.StrType s0) := MakeFT_invalid_indicator(s0);
EXPORT InValid_orig_dma_tps_dnc_flag_3(SALT32.StrType s) := InValidFT_invalid_indicator(s);
EXPORT InValidMessage_orig_dma_tps_dnc_flag_3(UNSIGNED1 wh) := InValidMessageFT_invalid_indicator(wh);
 
EXPORT Make_orig_telephonenumber_4(SALT32.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_orig_telephonenumber_4(SALT32.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_orig_telephonenumber_4(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_orig_validationflag_4(SALT32.StrType s0) := MakeFT_invalid_validation_flag(s0);
EXPORT InValid_orig_validationflag_4(SALT32.StrType s) := InValidFT_invalid_validation_flag(s);
EXPORT InValidMessage_orig_validationflag_4(UNSIGNED1 wh) := InValidMessageFT_invalid_validation_flag(wh);
 
EXPORT Make_orig_validationdate_4(SALT32.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_orig_validationdate_4(SALT32.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_orig_validationdate_4(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_orig_dma_tps_dnc_flag_4(SALT32.StrType s0) := MakeFT_invalid_indicator(s0);
EXPORT InValid_orig_dma_tps_dnc_flag_4(SALT32.StrType s) := InValidFT_invalid_indicator(s);
EXPORT InValidMessage_orig_dma_tps_dnc_flag_4(UNSIGNED1 wh) := InValidMessageFT_invalid_indicator(wh);
 
EXPORT Make_orig_telephonenumber_5(SALT32.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_orig_telephonenumber_5(SALT32.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_orig_telephonenumber_5(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_orig_validationflag_5(SALT32.StrType s0) := MakeFT_invalid_validation_flag(s0);
EXPORT InValid_orig_validationflag_5(SALT32.StrType s) := InValidFT_invalid_validation_flag(s);
EXPORT InValidMessage_orig_validationflag_5(UNSIGNED1 wh) := InValidMessageFT_invalid_validation_flag(wh);
 
EXPORT Make_orig_validationdate_5(SALT32.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_orig_validationdate_5(SALT32.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_orig_validationdate_5(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_orig_dma_tps_dnc_flag_5(SALT32.StrType s0) := MakeFT_invalid_indicator(s0);
EXPORT InValid_orig_dma_tps_dnc_flag_5(SALT32.StrType s) := InValidFT_invalid_indicator(s);
EXPORT InValidMessage_orig_dma_tps_dnc_flag_5(UNSIGNED1 wh) := InValidMessageFT_invalid_indicator(wh);
 
EXPORT Make_orig_telephonenumber_6(SALT32.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_orig_telephonenumber_6(SALT32.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_orig_telephonenumber_6(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_orig_validationflag_6(SALT32.StrType s0) := MakeFT_invalid_validation_flag(s0);
EXPORT InValid_orig_validationflag_6(SALT32.StrType s) := InValidFT_invalid_validation_flag(s);
EXPORT InValidMessage_orig_validationflag_6(UNSIGNED1 wh) := InValidMessageFT_invalid_validation_flag(wh);
 
EXPORT Make_orig_validationdate_6(SALT32.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_orig_validationdate_6(SALT32.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_orig_validationdate_6(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_orig_dma_tps_dnc_flag_6(SALT32.StrType s0) := MakeFT_invalid_indicator(s0);
EXPORT InValid_orig_dma_tps_dnc_flag_6(SALT32.StrType s) := InValidFT_invalid_indicator(s);
EXPORT InValidMessage_orig_dma_tps_dnc_flag_6(UNSIGNED1 wh) := InValidMessageFT_invalid_indicator(wh);
 
EXPORT Make_orig_telephonenumber_7(SALT32.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_orig_telephonenumber_7(SALT32.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_orig_telephonenumber_7(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_orig_validationflag_7(SALT32.StrType s0) := MakeFT_invalid_validation_flag(s0);
EXPORT InValid_orig_validationflag_7(SALT32.StrType s) := InValidFT_invalid_validation_flag(s);
EXPORT InValidMessage_orig_validationflag_7(UNSIGNED1 wh) := InValidMessageFT_invalid_validation_flag(wh);
 
EXPORT Make_orig_validationdate_7(SALT32.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_orig_validationdate_7(SALT32.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_orig_validationdate_7(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_orig_dma_tps_dnc_flag_7(SALT32.StrType s0) := MakeFT_invalid_indicator(s0);
EXPORT InValid_orig_dma_tps_dnc_flag_7(SALT32.StrType s) := InValidFT_invalid_indicator(s);
EXPORT InValidMessage_orig_dma_tps_dnc_flag_7(UNSIGNED1 wh) := InValidMessageFT_invalid_indicator(wh);
 
EXPORT Make_orig_tot_phones(SALT32.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_orig_tot_phones(SALT32.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_orig_tot_phones(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_orig_length_of_residence(SALT32.StrType s0) := MakeFT_invalid_residence_len(s0);
EXPORT InValid_orig_length_of_residence(SALT32.StrType s) := InValidFT_invalid_residence_len(s);
EXPORT InValidMessage_orig_length_of_residence(UNSIGNED1 wh) := InValidMessageFT_invalid_residence_len(wh);
 
EXPORT Make_orig_homeowner(SALT32.StrType s0) := MakeFT_invalid_homeowner(s0);
EXPORT InValid_orig_homeowner(SALT32.StrType s) := InValidFT_invalid_homeowner(s);
EXPORT InValidMessage_orig_homeowner(UNSIGNED1 wh) := InValidMessageFT_invalid_homeowner(wh);
 
EXPORT Make_orig_estimatedincome(SALT32.StrType s0) := MakeFT_invalid_mhv(s0);
EXPORT InValid_orig_estimatedincome(SALT32.StrType s) := InValidFT_invalid_mhv(s);
EXPORT InValidMessage_orig_estimatedincome(UNSIGNED1 wh) := InValidMessageFT_invalid_mhv(wh);
 
EXPORT Make_orig_dwelling_type(SALT32.StrType s0) := MakeFT_invalid_dwelling_type(s0);
EXPORT InValid_orig_dwelling_type(SALT32.StrType s) := InValidFT_invalid_dwelling_type(s);
EXPORT InValidMessage_orig_dwelling_type(UNSIGNED1 wh) := InValidMessageFT_invalid_dwelling_type(wh);
 
EXPORT Make_orig_married(SALT32.StrType s0) := MakeFT_invalid_indicator(s0);
EXPORT InValid_orig_married(SALT32.StrType s) := InValidFT_invalid_indicator(s);
EXPORT InValidMessage_orig_married(UNSIGNED1 wh) := InValidMessageFT_invalid_indicator(wh);
 
EXPORT Make_orig_child(SALT32.StrType s0) := MakeFT_invalid_indicator(s0);
EXPORT InValid_orig_child(SALT32.StrType s) := InValidFT_invalid_indicator(s);
EXPORT InValidMessage_orig_child(UNSIGNED1 wh) := InValidMessageFT_invalid_indicator(wh);
 
EXPORT Make_orig_nbrchild(SALT32.StrType s0) := MakeFT_invalid_child_num(s0);
EXPORT InValid_orig_nbrchild(SALT32.StrType s) := InValidFT_invalid_child_num(s);
EXPORT InValidMessage_orig_nbrchild(UNSIGNED1 wh) := InValidMessageFT_invalid_child_num(wh);
 
EXPORT Make_orig_teencd(SALT32.StrType s0) := MakeFT_invalid_indicator(s0);
EXPORT InValid_orig_teencd(SALT32.StrType s) := InValidFT_invalid_indicator(s);
EXPORT InValidMessage_orig_teencd(UNSIGNED1 wh) := InValidMessageFT_invalid_indicator(wh);
 
EXPORT Make_orig_percent_range_black(SALT32.StrType s0) := MakeFT_invalid_penetration_percentage_ranges(s0);
EXPORT InValid_orig_percent_range_black(SALT32.StrType s) := InValidFT_invalid_penetration_percentage_ranges(s);
EXPORT InValidMessage_orig_percent_range_black(UNSIGNED1 wh) := InValidMessageFT_invalid_penetration_percentage_ranges(wh);
 
EXPORT Make_orig_percent_range_white(SALT32.StrType s0) := MakeFT_invalid_penetration_percentage_ranges(s0);
EXPORT InValid_orig_percent_range_white(SALT32.StrType s) := InValidFT_invalid_penetration_percentage_ranges(s);
EXPORT InValidMessage_orig_percent_range_white(UNSIGNED1 wh) := InValidMessageFT_invalid_penetration_percentage_ranges(wh);
 
EXPORT Make_orig_percent_range_hispanic(SALT32.StrType s0) := MakeFT_invalid_penetration_percentage_ranges(s0);
EXPORT InValid_orig_percent_range_hispanic(SALT32.StrType s) := InValidFT_invalid_penetration_percentage_ranges(s);
EXPORT InValidMessage_orig_percent_range_hispanic(UNSIGNED1 wh) := InValidMessageFT_invalid_penetration_percentage_ranges(wh);
 
EXPORT Make_orig_percent_range_asian(SALT32.StrType s0) := MakeFT_invalid_penetration_percentage_ranges(s0);
EXPORT InValid_orig_percent_range_asian(SALT32.StrType s) := InValidFT_invalid_penetration_percentage_ranges(s);
EXPORT InValidMessage_orig_percent_range_asian(UNSIGNED1 wh) := InValidMessageFT_invalid_penetration_percentage_ranges(wh);
 
EXPORT Make_orig_percent_range_english_speaking(SALT32.StrType s0) := MakeFT_invalid_penetration_percentage_ranges(s0);
EXPORT InValid_orig_percent_range_english_speaking(SALT32.StrType s) := InValidFT_invalid_penetration_percentage_ranges(s);
EXPORT InValidMessage_orig_percent_range_english_speaking(UNSIGNED1 wh) := InValidMessageFT_invalid_penetration_percentage_ranges(wh);
 
EXPORT Make_orig_percnt_range_spanish_speaking(SALT32.StrType s0) := MakeFT_invalid_penetration_percentage_ranges(s0);
EXPORT InValid_orig_percnt_range_spanish_speaking(SALT32.StrType s) := InValidFT_invalid_penetration_percentage_ranges(s);
EXPORT InValidMessage_orig_percnt_range_spanish_speaking(UNSIGNED1 wh) := InValidMessageFT_invalid_penetration_percentage_ranges(wh);
 
EXPORT Make_orig_percent_range_asian_speaking(SALT32.StrType s0) := MakeFT_invalid_penetration_percentage_ranges(s0);
EXPORT InValid_orig_percent_range_asian_speaking(SALT32.StrType s) := InValidFT_invalid_penetration_percentage_ranges(s);
EXPORT InValidMessage_orig_percent_range_asian_speaking(UNSIGNED1 wh) := InValidMessageFT_invalid_penetration_percentage_ranges(wh);
 
EXPORT Make_orig_percent_range_sfdu(SALT32.StrType s0) := MakeFT_invalid_penetration_percentage_ranges(s0);
EXPORT InValid_orig_percent_range_sfdu(SALT32.StrType s) := InValidFT_invalid_penetration_percentage_ranges(s);
EXPORT InValidMessage_orig_percent_range_sfdu(UNSIGNED1 wh) := InValidMessageFT_invalid_penetration_percentage_ranges(wh);
 
EXPORT Make_orig_percent_range_mfdu(SALT32.StrType s0) := MakeFT_invalid_penetration_percentage_ranges(s0);
EXPORT InValid_orig_percent_range_mfdu(SALT32.StrType s) := InValidFT_invalid_penetration_percentage_ranges(s);
EXPORT InValidMessage_orig_percent_range_mfdu(UNSIGNED1 wh) := InValidMessageFT_invalid_penetration_percentage_ranges(wh);
 
EXPORT Make_orig_mhv(SALT32.StrType s0) := MakeFT_invalid_mhv(s0);
EXPORT InValid_orig_mhv(SALT32.StrType s) := InValidFT_invalid_mhv(s);
EXPORT InValidMessage_orig_mhv(UNSIGNED1 wh) := InValidMessageFT_invalid_mhv(wh);
 
EXPORT Make_orig_mor(SALT32.StrType s0) := MakeFT_invalid_penetration_percentage_ranges(s0);
EXPORT InValid_orig_mor(SALT32.StrType s) := InValidFT_invalid_penetration_percentage_ranges(s);
EXPORT InValidMessage_orig_mor(UNSIGNED1 wh) := InValidMessageFT_invalid_penetration_percentage_ranges(wh);
 
EXPORT Make_orig_car(SALT32.StrType s0) := MakeFT_invalid_penetration_percentage_ranges(s0);
EXPORT InValid_orig_car(SALT32.StrType s) := InValidFT_invalid_penetration_percentage_ranges(s);
EXPORT InValidMessage_orig_car(UNSIGNED1 wh) := InValidMessageFT_invalid_penetration_percentage_ranges(wh);
 
EXPORT Make_orig_medschl(SALT32.StrType s0) := s0;
EXPORT InValid_orig_medschl(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_orig_medschl(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_penetration_range_whitecollar(SALT32.StrType s0) := MakeFT_invalid_penetration_percentage_ranges(s0);
EXPORT InValid_orig_penetration_range_whitecollar(SALT32.StrType s) := InValidFT_invalid_penetration_percentage_ranges(s);
EXPORT InValidMessage_orig_penetration_range_whitecollar(UNSIGNED1 wh) := InValidMessageFT_invalid_penetration_percentage_ranges(wh);
 
EXPORT Make_orig_penetration_range_bluecollar(SALT32.StrType s0) := MakeFT_invalid_penetration_percentage_ranges(s0);
EXPORT InValid_orig_penetration_range_bluecollar(SALT32.StrType s) := InValidFT_invalid_penetration_percentage_ranges(s);
EXPORT InValidMessage_orig_penetration_range_bluecollar(UNSIGNED1 wh) := InValidMessageFT_invalid_penetration_percentage_ranges(wh);
 
EXPORT Make_orig_penetration_range_otheroccupation(SALT32.StrType s0) := MakeFT_invalid_penetration_percentage_ranges(s0);
EXPORT InValid_orig_penetration_range_otheroccupation(SALT32.StrType s) := InValidFT_invalid_penetration_percentage_ranges(s);
EXPORT InValidMessage_orig_penetration_range_otheroccupation(UNSIGNED1 wh) := InValidMessageFT_invalid_penetration_percentage_ranges(wh);
 
EXPORT Make_orig_demolevel(SALT32.StrType s0) := s0;
EXPORT InValid_orig_demolevel(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_orig_demolevel(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_recdate(SALT32.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_orig_recdate(SALT32.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_orig_recdate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT32,Scrubs_Infutor_NARC;
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
    BOOLEAN Diff_orig_tot_males;
    BOOLEAN Diff_orig_tot_females;
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
    BOOLEAN Diff_orig_county_code;
    BOOLEAN Diff_orig_time_zone;
    BOOLEAN Diff_orig_daylight_savings;
    BOOLEAN Diff_orig_lat_long_assignment_level;
    BOOLEAN Diff_orig_latitude;
    BOOLEAN Diff_orig_longitude;
    BOOLEAN Diff_orig_telephonenumber_1;
    BOOLEAN Diff_orig_validationflag_1;
    BOOLEAN Diff_orig_validationdate_1;
    BOOLEAN Diff_orig_dma_tps_dnc_flag_1;
    BOOLEAN Diff_orig_telephonenumber_2;
    BOOLEAN Diff_orig_validation_flag_2;
    BOOLEAN Diff_orig_validation_date_2;
    BOOLEAN Diff_orig_dma_tps_dnc_flag_2;
    BOOLEAN Diff_orig_telephonenumber_3;
    BOOLEAN Diff_orig_validationflag_3;
    BOOLEAN Diff_orig_validationdate_3;
    BOOLEAN Diff_orig_dma_tps_dnc_flag_3;
    BOOLEAN Diff_orig_telephonenumber_4;
    BOOLEAN Diff_orig_validationflag_4;
    BOOLEAN Diff_orig_validationdate_4;
    BOOLEAN Diff_orig_dma_tps_dnc_flag_4;
    BOOLEAN Diff_orig_telephonenumber_5;
    BOOLEAN Diff_orig_validationflag_5;
    BOOLEAN Diff_orig_validationdate_5;
    BOOLEAN Diff_orig_dma_tps_dnc_flag_5;
    BOOLEAN Diff_orig_telephonenumber_6;
    BOOLEAN Diff_orig_validationflag_6;
    BOOLEAN Diff_orig_validationdate_6;
    BOOLEAN Diff_orig_dma_tps_dnc_flag_6;
    BOOLEAN Diff_orig_telephonenumber_7;
    BOOLEAN Diff_orig_validationflag_7;
    BOOLEAN Diff_orig_validationdate_7;
    BOOLEAN Diff_orig_dma_tps_dnc_flag_7;
    BOOLEAN Diff_orig_tot_phones;
    BOOLEAN Diff_orig_length_of_residence;
    BOOLEAN Diff_orig_homeowner;
    BOOLEAN Diff_orig_estimatedincome;
    BOOLEAN Diff_orig_dwelling_type;
    BOOLEAN Diff_orig_married;
    BOOLEAN Diff_orig_child;
    BOOLEAN Diff_orig_nbrchild;
    BOOLEAN Diff_orig_teencd;
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
    BOOLEAN Diff_orig_penetration_range_whitecollar;
    BOOLEAN Diff_orig_penetration_range_bluecollar;
    BOOLEAN Diff_orig_penetration_range_otheroccupation;
    BOOLEAN Diff_orig_demolevel;
    BOOLEAN Diff_orig_recdate;
    UNSIGNED Num_Diffs;
    SALT32.StrType Val {MAXLENGTH(1024)};
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
    SELF.Diff_orig_tot_males := le.orig_tot_males <> ri.orig_tot_males;
    SELF.Diff_orig_tot_females := le.orig_tot_females <> ri.orig_tot_females;
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
    SELF.Diff_orig_county_code := le.orig_county_code <> ri.orig_county_code;
    SELF.Diff_orig_time_zone := le.orig_time_zone <> ri.orig_time_zone;
    SELF.Diff_orig_daylight_savings := le.orig_daylight_savings <> ri.orig_daylight_savings;
    SELF.Diff_orig_lat_long_assignment_level := le.orig_lat_long_assignment_level <> ri.orig_lat_long_assignment_level;
    SELF.Diff_orig_latitude := le.orig_latitude <> ri.orig_latitude;
    SELF.Diff_orig_longitude := le.orig_longitude <> ri.orig_longitude;
    SELF.Diff_orig_telephonenumber_1 := le.orig_telephonenumber_1 <> ri.orig_telephonenumber_1;
    SELF.Diff_orig_validationflag_1 := le.orig_validationflag_1 <> ri.orig_validationflag_1;
    SELF.Diff_orig_validationdate_1 := le.orig_validationdate_1 <> ri.orig_validationdate_1;
    SELF.Diff_orig_dma_tps_dnc_flag_1 := le.orig_dma_tps_dnc_flag_1 <> ri.orig_dma_tps_dnc_flag_1;
    SELF.Diff_orig_telephonenumber_2 := le.orig_telephonenumber_2 <> ri.orig_telephonenumber_2;
    SELF.Diff_orig_validation_flag_2 := le.orig_validation_flag_2 <> ri.orig_validation_flag_2;
    SELF.Diff_orig_validation_date_2 := le.orig_validation_date_2 <> ri.orig_validation_date_2;
    SELF.Diff_orig_dma_tps_dnc_flag_2 := le.orig_dma_tps_dnc_flag_2 <> ri.orig_dma_tps_dnc_flag_2;
    SELF.Diff_orig_telephonenumber_3 := le.orig_telephonenumber_3 <> ri.orig_telephonenumber_3;
    SELF.Diff_orig_validationflag_3 := le.orig_validationflag_3 <> ri.orig_validationflag_3;
    SELF.Diff_orig_validationdate_3 := le.orig_validationdate_3 <> ri.orig_validationdate_3;
    SELF.Diff_orig_dma_tps_dnc_flag_3 := le.orig_dma_tps_dnc_flag_3 <> ri.orig_dma_tps_dnc_flag_3;
    SELF.Diff_orig_telephonenumber_4 := le.orig_telephonenumber_4 <> ri.orig_telephonenumber_4;
    SELF.Diff_orig_validationflag_4 := le.orig_validationflag_4 <> ri.orig_validationflag_4;
    SELF.Diff_orig_validationdate_4 := le.orig_validationdate_4 <> ri.orig_validationdate_4;
    SELF.Diff_orig_dma_tps_dnc_flag_4 := le.orig_dma_tps_dnc_flag_4 <> ri.orig_dma_tps_dnc_flag_4;
    SELF.Diff_orig_telephonenumber_5 := le.orig_telephonenumber_5 <> ri.orig_telephonenumber_5;
    SELF.Diff_orig_validationflag_5 := le.orig_validationflag_5 <> ri.orig_validationflag_5;
    SELF.Diff_orig_validationdate_5 := le.orig_validationdate_5 <> ri.orig_validationdate_5;
    SELF.Diff_orig_dma_tps_dnc_flag_5 := le.orig_dma_tps_dnc_flag_5 <> ri.orig_dma_tps_dnc_flag_5;
    SELF.Diff_orig_telephonenumber_6 := le.orig_telephonenumber_6 <> ri.orig_telephonenumber_6;
    SELF.Diff_orig_validationflag_6 := le.orig_validationflag_6 <> ri.orig_validationflag_6;
    SELF.Diff_orig_validationdate_6 := le.orig_validationdate_6 <> ri.orig_validationdate_6;
    SELF.Diff_orig_dma_tps_dnc_flag_6 := le.orig_dma_tps_dnc_flag_6 <> ri.orig_dma_tps_dnc_flag_6;
    SELF.Diff_orig_telephonenumber_7 := le.orig_telephonenumber_7 <> ri.orig_telephonenumber_7;
    SELF.Diff_orig_validationflag_7 := le.orig_validationflag_7 <> ri.orig_validationflag_7;
    SELF.Diff_orig_validationdate_7 := le.orig_validationdate_7 <> ri.orig_validationdate_7;
    SELF.Diff_orig_dma_tps_dnc_flag_7 := le.orig_dma_tps_dnc_flag_7 <> ri.orig_dma_tps_dnc_flag_7;
    SELF.Diff_orig_tot_phones := le.orig_tot_phones <> ri.orig_tot_phones;
    SELF.Diff_orig_length_of_residence := le.orig_length_of_residence <> ri.orig_length_of_residence;
    SELF.Diff_orig_homeowner := le.orig_homeowner <> ri.orig_homeowner;
    SELF.Diff_orig_estimatedincome := le.orig_estimatedincome <> ri.orig_estimatedincome;
    SELF.Diff_orig_dwelling_type := le.orig_dwelling_type <> ri.orig_dwelling_type;
    SELF.Diff_orig_married := le.orig_married <> ri.orig_married;
    SELF.Diff_orig_child := le.orig_child <> ri.orig_child;
    SELF.Diff_orig_nbrchild := le.orig_nbrchild <> ri.orig_nbrchild;
    SELF.Diff_orig_teencd := le.orig_teencd <> ri.orig_teencd;
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
    SELF.Diff_orig_penetration_range_whitecollar := le.orig_penetration_range_whitecollar <> ri.orig_penetration_range_whitecollar;
    SELF.Diff_orig_penetration_range_bluecollar := le.orig_penetration_range_bluecollar <> ri.orig_penetration_range_bluecollar;
    SELF.Diff_orig_penetration_range_otheroccupation := le.orig_penetration_range_otheroccupation <> ri.orig_penetration_range_otheroccupation;
    SELF.Diff_orig_demolevel := le.orig_demolevel <> ri.orig_demolevel;
    SELF.Diff_orig_recdate := le.orig_recdate <> ri.orig_recdate;
    SELF.Val := (SALT32.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_orig_hhid,1,0)+ IF( SELF.Diff_orig_pid,1,0)+ IF( SELF.Diff_orig_fname,1,0)+ IF( SELF.Diff_orig_mname,1,0)+ IF( SELF.Diff_orig_lname,1,0)+ IF( SELF.Diff_orig_suffix,1,0)+ IF( SELF.Diff_orig_gender,1,0)+ IF( SELF.Diff_orig_age,1,0)+ IF( SELF.Diff_orig_dob,1,0)+ IF( SELF.Diff_orig_hhnbr,1,0)+ IF( SELF.Diff_orig_tot_males,1,0)+ IF( SELF.Diff_orig_tot_females,1,0)+ IF( SELF.Diff_orig_addrid,1,0)+ IF( SELF.Diff_orig_address,1,0)+ IF( SELF.Diff_orig_house,1,0)+ IF( SELF.Diff_orig_predir,1,0)+ IF( SELF.Diff_orig_street,1,0)+ IF( SELF.Diff_orig_strtype,1,0)+ IF( SELF.Diff_orig_postdir,1,0)+ IF( SELF.Diff_orig_apttype,1,0)+ IF( SELF.Diff_orig_aptnbr,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_orig_z4,1,0)+ IF( SELF.Diff_orig_dpc,1,0)+ IF( SELF.Diff_orig_z4type,1,0)+ IF( SELF.Diff_orig_crte,1,0)+ IF( SELF.Diff_orig_dpv,1,0)+ IF( SELF.Diff_orig_vacant,1,0)+ IF( SELF.Diff_orig_msa,1,0)+ IF( SELF.Diff_orig_cbsa,1,0)+ IF( SELF.Diff_orig_county_code,1,0)+ IF( SELF.Diff_orig_time_zone,1,0)+ IF( SELF.Diff_orig_daylight_savings,1,0)+ IF( SELF.Diff_orig_lat_long_assignment_level,1,0)+ IF( SELF.Diff_orig_latitude,1,0)+ IF( SELF.Diff_orig_longitude,1,0)+ IF( SELF.Diff_orig_telephonenumber_1,1,0)+ IF( SELF.Diff_orig_validationflag_1,1,0)+ IF( SELF.Diff_orig_validationdate_1,1,0)+ IF( SELF.Diff_orig_dma_tps_dnc_flag_1,1,0)+ IF( SELF.Diff_orig_telephonenumber_2,1,0)+ IF( SELF.Diff_orig_validation_flag_2,1,0)+ IF( SELF.Diff_orig_validation_date_2,1,0)+ IF( SELF.Diff_orig_dma_tps_dnc_flag_2,1,0)+ IF( SELF.Diff_orig_telephonenumber_3,1,0)+ IF( SELF.Diff_orig_validationflag_3,1,0)+ IF( SELF.Diff_orig_validationdate_3,1,0)+ IF( SELF.Diff_orig_dma_tps_dnc_flag_3,1,0)+ IF( SELF.Diff_orig_telephonenumber_4,1,0)+ IF( SELF.Diff_orig_validationflag_4,1,0)+ IF( SELF.Diff_orig_validationdate_4,1,0)+ IF( SELF.Diff_orig_dma_tps_dnc_flag_4,1,0)+ IF( SELF.Diff_orig_telephonenumber_5,1,0)+ IF( SELF.Diff_orig_validationflag_5,1,0)+ IF( SELF.Diff_orig_validationdate_5,1,0)+ IF( SELF.Diff_orig_dma_tps_dnc_flag_5,1,0)+ IF( SELF.Diff_orig_telephonenumber_6,1,0)+ IF( SELF.Diff_orig_validationflag_6,1,0)+ IF( SELF.Diff_orig_validationdate_6,1,0)+ IF( SELF.Diff_orig_dma_tps_dnc_flag_6,1,0)+ IF( SELF.Diff_orig_telephonenumber_7,1,0)+ IF( SELF.Diff_orig_validationflag_7,1,0)+ IF( SELF.Diff_orig_validationdate_7,1,0)+ IF( SELF.Diff_orig_dma_tps_dnc_flag_7,1,0)+ IF( SELF.Diff_orig_tot_phones,1,0)+ IF( SELF.Diff_orig_length_of_residence,1,0)+ IF( SELF.Diff_orig_homeowner,1,0)+ IF( SELF.Diff_orig_estimatedincome,1,0)+ IF( SELF.Diff_orig_dwelling_type,1,0)+ IF( SELF.Diff_orig_married,1,0)+ IF( SELF.Diff_orig_child,1,0)+ IF( SELF.Diff_orig_nbrchild,1,0)+ IF( SELF.Diff_orig_teencd,1,0)+ IF( SELF.Diff_orig_percent_range_black,1,0)+ IF( SELF.Diff_orig_percent_range_white,1,0)+ IF( SELF.Diff_orig_percent_range_hispanic,1,0)+ IF( SELF.Diff_orig_percent_range_asian,1,0)+ IF( SELF.Diff_orig_percent_range_english_speaking,1,0)+ IF( SELF.Diff_orig_percnt_range_spanish_speaking,1,0)+ IF( SELF.Diff_orig_percent_range_asian_speaking,1,0)+ IF( SELF.Diff_orig_percent_range_sfdu,1,0)+ IF( SELF.Diff_orig_percent_range_mfdu,1,0)+ IF( SELF.Diff_orig_mhv,1,0)+ IF( SELF.Diff_orig_mor,1,0)+ IF( SELF.Diff_orig_car,1,0)+ IF( SELF.Diff_orig_medschl,1,0)+ IF( SELF.Diff_orig_penetration_range_whitecollar,1,0)+ IF( SELF.Diff_orig_penetration_range_bluecollar,1,0)+ IF( SELF.Diff_orig_penetration_range_otheroccupation,1,0)+ IF( SELF.Diff_orig_demolevel,1,0)+ IF( SELF.Diff_orig_recdate,1,0);
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
    Count_Diff_orig_tot_males := COUNT(GROUP,%Closest%.Diff_orig_tot_males);
    Count_Diff_orig_tot_females := COUNT(GROUP,%Closest%.Diff_orig_tot_females);
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
    Count_Diff_orig_county_code := COUNT(GROUP,%Closest%.Diff_orig_county_code);
    Count_Diff_orig_time_zone := COUNT(GROUP,%Closest%.Diff_orig_time_zone);
    Count_Diff_orig_daylight_savings := COUNT(GROUP,%Closest%.Diff_orig_daylight_savings);
    Count_Diff_orig_lat_long_assignment_level := COUNT(GROUP,%Closest%.Diff_orig_lat_long_assignment_level);
    Count_Diff_orig_latitude := COUNT(GROUP,%Closest%.Diff_orig_latitude);
    Count_Diff_orig_longitude := COUNT(GROUP,%Closest%.Diff_orig_longitude);
    Count_Diff_orig_telephonenumber_1 := COUNT(GROUP,%Closest%.Diff_orig_telephonenumber_1);
    Count_Diff_orig_validationflag_1 := COUNT(GROUP,%Closest%.Diff_orig_validationflag_1);
    Count_Diff_orig_validationdate_1 := COUNT(GROUP,%Closest%.Diff_orig_validationdate_1);
    Count_Diff_orig_dma_tps_dnc_flag_1 := COUNT(GROUP,%Closest%.Diff_orig_dma_tps_dnc_flag_1);
    Count_Diff_orig_telephonenumber_2 := COUNT(GROUP,%Closest%.Diff_orig_telephonenumber_2);
    Count_Diff_orig_validation_flag_2 := COUNT(GROUP,%Closest%.Diff_orig_validation_flag_2);
    Count_Diff_orig_validation_date_2 := COUNT(GROUP,%Closest%.Diff_orig_validation_date_2);
    Count_Diff_orig_dma_tps_dnc_flag_2 := COUNT(GROUP,%Closest%.Diff_orig_dma_tps_dnc_flag_2);
    Count_Diff_orig_telephonenumber_3 := COUNT(GROUP,%Closest%.Diff_orig_telephonenumber_3);
    Count_Diff_orig_validationflag_3 := COUNT(GROUP,%Closest%.Diff_orig_validationflag_3);
    Count_Diff_orig_validationdate_3 := COUNT(GROUP,%Closest%.Diff_orig_validationdate_3);
    Count_Diff_orig_dma_tps_dnc_flag_3 := COUNT(GROUP,%Closest%.Diff_orig_dma_tps_dnc_flag_3);
    Count_Diff_orig_telephonenumber_4 := COUNT(GROUP,%Closest%.Diff_orig_telephonenumber_4);
    Count_Diff_orig_validationflag_4 := COUNT(GROUP,%Closest%.Diff_orig_validationflag_4);
    Count_Diff_orig_validationdate_4 := COUNT(GROUP,%Closest%.Diff_orig_validationdate_4);
    Count_Diff_orig_dma_tps_dnc_flag_4 := COUNT(GROUP,%Closest%.Diff_orig_dma_tps_dnc_flag_4);
    Count_Diff_orig_telephonenumber_5 := COUNT(GROUP,%Closest%.Diff_orig_telephonenumber_5);
    Count_Diff_orig_validationflag_5 := COUNT(GROUP,%Closest%.Diff_orig_validationflag_5);
    Count_Diff_orig_validationdate_5 := COUNT(GROUP,%Closest%.Diff_orig_validationdate_5);
    Count_Diff_orig_dma_tps_dnc_flag_5 := COUNT(GROUP,%Closest%.Diff_orig_dma_tps_dnc_flag_5);
    Count_Diff_orig_telephonenumber_6 := COUNT(GROUP,%Closest%.Diff_orig_telephonenumber_6);
    Count_Diff_orig_validationflag_6 := COUNT(GROUP,%Closest%.Diff_orig_validationflag_6);
    Count_Diff_orig_validationdate_6 := COUNT(GROUP,%Closest%.Diff_orig_validationdate_6);
    Count_Diff_orig_dma_tps_dnc_flag_6 := COUNT(GROUP,%Closest%.Diff_orig_dma_tps_dnc_flag_6);
    Count_Diff_orig_telephonenumber_7 := COUNT(GROUP,%Closest%.Diff_orig_telephonenumber_7);
    Count_Diff_orig_validationflag_7 := COUNT(GROUP,%Closest%.Diff_orig_validationflag_7);
    Count_Diff_orig_validationdate_7 := COUNT(GROUP,%Closest%.Diff_orig_validationdate_7);
    Count_Diff_orig_dma_tps_dnc_flag_7 := COUNT(GROUP,%Closest%.Diff_orig_dma_tps_dnc_flag_7);
    Count_Diff_orig_tot_phones := COUNT(GROUP,%Closest%.Diff_orig_tot_phones);
    Count_Diff_orig_length_of_residence := COUNT(GROUP,%Closest%.Diff_orig_length_of_residence);
    Count_Diff_orig_homeowner := COUNT(GROUP,%Closest%.Diff_orig_homeowner);
    Count_Diff_orig_estimatedincome := COUNT(GROUP,%Closest%.Diff_orig_estimatedincome);
    Count_Diff_orig_dwelling_type := COUNT(GROUP,%Closest%.Diff_orig_dwelling_type);
    Count_Diff_orig_married := COUNT(GROUP,%Closest%.Diff_orig_married);
    Count_Diff_orig_child := COUNT(GROUP,%Closest%.Diff_orig_child);
    Count_Diff_orig_nbrchild := COUNT(GROUP,%Closest%.Diff_orig_nbrchild);
    Count_Diff_orig_teencd := COUNT(GROUP,%Closest%.Diff_orig_teencd);
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
    Count_Diff_orig_penetration_range_whitecollar := COUNT(GROUP,%Closest%.Diff_orig_penetration_range_whitecollar);
    Count_Diff_orig_penetration_range_bluecollar := COUNT(GROUP,%Closest%.Diff_orig_penetration_range_bluecollar);
    Count_Diff_orig_penetration_range_otheroccupation := COUNT(GROUP,%Closest%.Diff_orig_penetration_range_otheroccupation);
    Count_Diff_orig_demolevel := COUNT(GROUP,%Closest%.Diff_orig_demolevel);
    Count_Diff_orig_recdate := COUNT(GROUP,%Closest%.Diff_orig_recdate);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
