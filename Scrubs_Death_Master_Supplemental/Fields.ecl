IMPORT ut,SALT30;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT30.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_process_date','invalid_source_state','invalid_certificate_vol_no','invalid_certificate_vol_year','invalid_publication','invalid_decedent_name','invalid_decedent_race','invalid_decedent_origin','invalid_decedent_sex','invalid_decedent_age','invalid_education','invalid_occupation','invalid_where_worked','invalid_cause','invalid_ssn','invalid_date','invalid_birthplace','invalid_marital_status','invalid_parent_name','invalid_year','invalid_county_residence','invalid_county_death','invalid_address','invalid_autopsy','invalid_autopsy_findings','invalid_primary_cause_of_death','invalid_underlying_cause_of_death','invalid_med_exam','invalid_est_lic_no','invalid_disposition','invalid_work_injury','invalid_injury_date','invalid_injury_type','invalid_injury_location','invalid_surg_performed','invalid_hospital_status','invalid_pregnancy','invalid_facility_death','invalid_embalmer_lic_no','invalid_death_type','invalid_time_death','invalid_birth_cert','invalid_certifier','invalid_cert_number','invalid_local_file_no','invalid_vdi','invalid_cite_id','invalid_file_id','invalid_amendment_code','invalid_amendment_year','invalid__on_lexis','invalid__fs_profile','invalid_us_armed_forces','invalid_place_of_death','invalid_state_death_id','invalid_state_death_flag','invalid_name','invalid_name_score','invalid_prim_range','invalid_predir','invalid_prim_name','invalid_addr_suffix','invalid_postdir','invalid_unit_desig','invalid_sec_range','invalid_p_city_name','invalid_v_city_name','invalid_state','invalid_zip','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_rec_type','invalid_fipsstate','invalid_fipscounty','invalid_geo_lat','invalid_geo_long','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','invalid_rawaid','invalid_statefn','invalid_lf');
EXPORT FieldTypeNum(SALT30.StrType fn) := CASE(fn,'invalid_process_date' => 1,'invalid_source_state' => 2,'invalid_certificate_vol_no' => 3,'invalid_certificate_vol_year' => 4,'invalid_publication' => 5,'invalid_decedent_name' => 6,'invalid_decedent_race' => 7,'invalid_decedent_origin' => 8,'invalid_decedent_sex' => 9,'invalid_decedent_age' => 10,'invalid_education' => 11,'invalid_occupation' => 12,'invalid_where_worked' => 13,'invalid_cause' => 14,'invalid_ssn' => 15,'invalid_date' => 16,'invalid_birthplace' => 17,'invalid_marital_status' => 18,'invalid_parent_name' => 19,'invalid_year' => 20,'invalid_county_residence' => 21,'invalid_county_death' => 22,'invalid_address' => 23,'invalid_autopsy' => 24,'invalid_autopsy_findings' => 25,'invalid_primary_cause_of_death' => 26,'invalid_underlying_cause_of_death' => 27,'invalid_med_exam' => 28,'invalid_est_lic_no' => 29,'invalid_disposition' => 30,'invalid_work_injury' => 31,'invalid_injury_date' => 32,'invalid_injury_type' => 33,'invalid_injury_location' => 34,'invalid_surg_performed' => 35,'invalid_hospital_status' => 36,'invalid_pregnancy' => 37,'invalid_facility_death' => 38,'invalid_embalmer_lic_no' => 39,'invalid_death_type' => 40,'invalid_time_death' => 41,'invalid_birth_cert' => 42,'invalid_certifier' => 43,'invalid_cert_number' => 44,'invalid_local_file_no' => 45,'invalid_vdi' => 46,'invalid_cite_id' => 47,'invalid_file_id' => 48,'invalid_amendment_code' => 49,'invalid_amendment_year' => 50,'invalid__on_lexis' => 51,'invalid__fs_profile' => 52,'invalid_us_armed_forces' => 53,'invalid_place_of_death' => 54,'invalid_state_death_id' => 55,'invalid_state_death_flag' => 56,'invalid_name' => 57,'invalid_name_score' => 58,'invalid_prim_range' => 59,'invalid_predir' => 60,'invalid_prim_name' => 61,'invalid_addr_suffix' => 62,'invalid_postdir' => 63,'invalid_unit_desig' => 64,'invalid_sec_range' => 65,'invalid_p_city_name' => 66,'invalid_v_city_name' => 67,'invalid_state' => 68,'invalid_zip' => 69,'invalid_zip4' => 70,'invalid_cart' => 71,'invalid_cr_sort_sz' => 72,'invalid_lot' => 73,'invalid_lot_order' => 74,'invalid_dpbc' => 75,'invalid_chk_digit' => 76,'invalid_rec_type' => 77,'invalid_fipsstate' => 78,'invalid_fipscounty' => 79,'invalid_geo_lat' => 80,'invalid_geo_long' => 81,'invalid_msa' => 82,'invalid_geo_blk' => 83,'invalid_geo_match' => 84,'invalid_err_stat' => 85,'invalid_rawaid' => 86,'invalid_statefn' => 87,'invalid_lf' => 88,0);
EXPORT MakeFT_invalid_process_date(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_process_date(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_process_date(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('8'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_source_state(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_source_state(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_source_state(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT30.HygieneErrors.NotLength('2'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_certificate_vol_no(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_certificate_vol_no(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_certificate_vol_no(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('3,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_certificate_vol_year(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_certificate_vol_year(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_certificate_vol_year(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('4,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_publication(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' '); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_publication(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' '))));
EXPORT InValidMessageFT_invalid_publication(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ\' '),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_decedent_name(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃÃ“Ã¶Ã©\' ,-.()'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ,-.()',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_decedent_name(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃÃ“Ã¶Ã©\' ,-.()'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_decedent_name(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃÃ“Ã¶Ã©\' ,-.()'),SALT30.HygieneErrors.NotLength('1..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_decedent_race(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,-/.();\''); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ,-/.();\'',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_decedent_race(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,-/.();\''))));
EXPORT InValidMessageFT_invalid_decedent_race(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ ,-/.();\''),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_decedent_origin(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,-.()/;\'&'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ,-.()/;\'&',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_decedent_origin(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,-.()/;\'&'))));
EXPORT InValidMessageFT_invalid_decedent_origin(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ ,-.()/;\'&'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_decedent_sex(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_decedent_sex(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['MALE','FEMALE','UNDETERMINED','UNKNOWN','']);
EXPORT InValidMessageFT_invalid_decedent_sex(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('MALE|FEMALE|UNDETERMINED|UNKNOWN|'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_decedent_age(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_decedent_age(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))));
EXPORT InValidMessageFT_invalid_decedent_age(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_education(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,;.-()+/\''); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ,;.-()+/\'',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_education(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,;.-()+/\''))));
EXPORT InValidMessageFT_invalid_education(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,;.-()+/\''),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_occupation(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,-'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ,-',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_occupation(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,-'))));
EXPORT InValidMessageFT_invalid_occupation(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ ,-'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_where_worked(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ (),.-'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' (),.-',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_where_worked(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ (),.-'))));
EXPORT InValidMessageFT_invalid_where_worked(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ (),.-'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_cause(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,;-()'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ,;-()',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_cause(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,;-()'))));
EXPORT InValidMessageFT_invalid_cause(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ ,;-()'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_ssn(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ssn(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('9,4,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_date(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_date(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789 '),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_birthplace(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã© ,./-()\''); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ,./-()\'',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_birthplace(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã© ,./-()\''))));
EXPORT InValidMessageFT_invalid_birthplace(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã© ,./-()\''),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_marital_status(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ()-/\','); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ()-/\',',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_marital_status(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ()-/\','))));
EXPORT InValidMessageFT_invalid_marital_status(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ ()-/\','),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_parent_name(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ“Ã¶Ã© (),-.\''); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' (),-.\'',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_parent_name(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ“Ã¶Ã© (),-.\''))));
EXPORT InValidMessageFT_invalid_parent_name(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ“Ã¶Ã© (),-.\''),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_year(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_year(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_year(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('4,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_county_residence(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ()\'-.&'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ()\'-.&',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_county_residence(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ()\'-.&'))));
EXPORT InValidMessageFT_invalid_county_residence(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ ()\'-.&'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_county_death(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ()\'-.&'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ()\'-.&',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_county_death(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ()\'-.&'))));
EXPORT InValidMessageFT_invalid_county_death(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ ()\'-.&'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_address(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ‘Ã0123456789 ,-.()\':;"&#/'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ,-.()\':;"&#/',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_address(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ‘Ã0123456789 ,-.()\':;"&#/'))));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÃ‘Ã0123456789 ,-.()\':;"&#/'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_autopsy(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_autopsy(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['NO','YES','UNK','UNKNOWN','']);
EXPORT InValidMessageFT_invalid_autopsy(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('NO|YES|UNK|UNKNOWN|'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_autopsy_findings(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ /'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' /',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_autopsy_findings(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ /'))));
EXPORT InValidMessageFT_invalid_autopsy_findings(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ /'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_primary_cause_of_death(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_primary_cause_of_death(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 4));
EXPORT InValidMessageFT_invalid_primary_cause_of_death(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT30.HygieneErrors.NotLength('0..4'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_underlying_cause_of_death(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ;,'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ;,',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_underlying_cause_of_death(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ;,'))));
EXPORT InValidMessageFT_invalid_underlying_cause_of_death(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ;,'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_med_exam(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_med_exam(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['NO','YES','UNK','']);
EXPORT InValidMessageFT_invalid_med_exam(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('NO|YES|UNK|'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_est_lic_no(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_est_lic_no(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_est_lic_no(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('6,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_disposition(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ./-'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ./-',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_disposition(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ./-'))));
EXPORT InValidMessageFT_invalid_disposition(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ ./-'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_work_injury(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_work_injury(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['NO','YES','UNKNOWN','UNK','REG CERT','']);
EXPORT InValidMessageFT_invalid_work_injury(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('NO|YES|UNKNOWN|UNK|REG CERT|'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_injury_date(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789NOIJURY '); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_injury_date(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789NOIJURY '))),~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_injury_date(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789NOIJURY '),SALT30.HygieneErrors.NotLength('8'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_injury_type(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ./'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ./',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_injury_type(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ./'))));
EXPORT InValidMessageFT_invalid_injury_type(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ ./'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_injury_location(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,-./'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ,-./',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_injury_location(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,-./'))));
EXPORT InValidMessageFT_invalid_injury_location(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ ,-./'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_surg_performed(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_surg_performed(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['NO','YES','UNKNOWN','UNK','']);
EXPORT InValidMessageFT_invalid_surg_performed(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('NO|YES|UNKNOWN|UNK|'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_hospital_status(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -,/().\''); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -,/().\'',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_hospital_status(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -,/().\''))));
EXPORT InValidMessageFT_invalid_hospital_status(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -,/().\''),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_pregnancy(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_pregnancy(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -'))));
EXPORT InValidMessageFT_invalid_pregnancy(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_facility_death(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -,/().\'&'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -,/().\'&',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_facility_death(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -,/().\'&'))));
EXPORT InValidMessageFT_invalid_facility_death(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -,/().\'&'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_embalmer_lic_no(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_embalmer_lic_no(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_embalmer_lic_no(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('6,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_death_type(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_death_type(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_death_type(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_time_death(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' /',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_time_death(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /'))));
EXPORT InValidMessageFT_invalid_time_death(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_birth_cert(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789 ,'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ,',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_birth_cert(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789 ,'))));
EXPORT InValidMessageFT_invalid_birth_cert(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789 ,'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_certifier(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ .,'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' .,',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_certifier(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ .,'))));
EXPORT InValidMessageFT_invalid_certifier(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ .,'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_cert_number(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_cert_number(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_cert_number(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('7,6,5,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_local_file_no(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_local_file_no(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_local_file_no(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('5,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_vdi(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-,.'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,'-,.',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_vdi(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-,.'))));
EXPORT InValidMessageFT_invalid_vdi(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-,.'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_cite_id(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_cite_id(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_cite_id(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_file_id(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_file_id(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_file_id(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT30.HygieneErrors.NotLength('5,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_amendment_code(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'1A'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_amendment_code(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'1A'))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_amendment_code(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('1A'),SALT30.HygieneErrors.NotLength('1,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_amendment_year(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_amendment_year(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_amendment_year(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('2,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid__on_lexis(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789/'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,'/',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid__on_lexis(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789/'))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid__on_lexis(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789/'),SALT30.HygieneErrors.NotLength('10,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid__fs_profile(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid__fs_profile(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid__fs_profile(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT30.HygieneErrors.NotLength('9,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_us_armed_forces(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_us_armed_forces(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['NO','YES','UNK','']);
EXPORT InValidMessageFT_invalid_us_armed_forces(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('NO|YES|UNK|'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_place_of_death(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -/\\.,&()\''); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -/\\.,&()\'',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_place_of_death(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -/\\.,&()\''))));
EXPORT InValidMessageFT_invalid_place_of_death(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -/\\.,&()\''),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_state_death_id(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_state_death_id(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) = 16));
EXPORT InValidMessageFT_invalid_state_death_id(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT30.HygieneErrors.NotLength('16'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_state_death_flag(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state_death_flag(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['Y','N'],~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_state_death_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('Y|N'),SALT30.HygieneErrors.NotLength('1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_name(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã© -.()\''); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -.()\'',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_name(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã© -.()\''))));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã© -.()\''),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_name_score(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_name_score(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_name_score(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_prim_range(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ./\\Â½-'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ./\\Â½-',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_prim_range(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ./\\Â½-'))));
EXPORT InValidMessageFT_invalid_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ./\\Â½-'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_predir(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'NSEW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_predir(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'NSEW'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 2));
EXPORT InValidMessageFT_invalid_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('NSEW'),SALT30.HygieneErrors.NotLength('0..2'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_prim_name(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789Ã‘ -/\\\''); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -/\\\'',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_prim_name(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789Ã‘ -/\\\''))));
EXPORT InValidMessageFT_invalid_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789Ã‘ -/\\\''),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_addr_suffix(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_addr_suffix(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_addr_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_postdir(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'NSEW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_postdir(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'NSEW'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 2));
EXPORT InValidMessageFT_invalid_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('NSEW'),SALT30.HygieneErrors.NotLength('0..2'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_unit_desig(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -.\'#'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -.\'#',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_unit_desig(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -.\'#'))));
EXPORT InValidMessageFT_invalid_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -.\'#'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_sec_range(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.\'#/'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -.\'#/',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_sec_range(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.\'#/'))));
EXPORT InValidMessageFT_invalid_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.\'#/'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_p_city_name(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.\''); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -.\'',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_p_city_name(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.\''))));
EXPORT InValidMessageFT_invalid_p_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.\''),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_v_city_name(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.\''); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -.\'',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_v_city_name(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.\''))));
EXPORT InValidMessageFT_invalid_v_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.\''),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_state(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_state(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT30.HygieneErrors.NotLength('2,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT30.HygieneErrors.NotLength('5,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip4(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip4(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('4,1,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_cart(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'RCHBG0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_cart(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'RCHBG0123456789'))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('RCHBG0123456789'),SALT30.HygieneErrors.NotLength('4,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_cr_sort_sz(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCD'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_cr_sort_sz(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCD'))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCD'),SALT30.HygieneErrors.NotLength('1,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_lot(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_lot(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('4,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_lot_order(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'AD'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_lot_order(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'AD'))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('AD'),SALT30.HygieneErrors.NotLength('1,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_dpbc(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dpbc(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_dpbc(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('2,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_chk_digit(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_chk_digit(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('1,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_rec_type(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_rec_type(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 2));
EXPORT InValidMessageFT_invalid_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT30.HygieneErrors.NotLength('0..2'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_fipsstate(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_fipsstate(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_fipsstate(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('2,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_fipscounty(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_fipscounty(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_fipscounty(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('3,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_geo_lat(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_geo_lat(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789.'))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_geo_lat(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789.'),SALT30.HygieneErrors.NotLength('9,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_geo_long(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789.-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_geo_long(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789.-'))),~(LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_geo_long(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789.-'),SALT30.HygieneErrors.NotLength('11,10,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_msa(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_msa(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_msa(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('4,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_geo_blk(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_geo_blk(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_geo_blk(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('7,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_geo_match(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_geo_match(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('1,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_err_stat(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_err_stat(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT30.HygieneErrors.NotLength('4,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_rawaid(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_rawaid(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0'))),~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_rawaid(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0'),SALT30.HygieneErrors.NotLength('1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_statefn(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_statefn(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_invalid_statefn(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_lf(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lf(SALT30.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_lf(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotLength('1,0'),SALT30.HygieneErrors.Good);
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'process_date','source_state','certificate_vol_no','certificate_vol_year','publication','decedent_name','decedent_race','decedent_origin','decedent_sex','decedent_age','education','occupation','where_worked','cause','ssn','dob','dod','birthplace','marital_status','father','mother','filed_date','year','county_residence','county_death','address','autopsy','autopsy_findings','primary_cause_of_death','underlying_cause_of_death','med_exam','est_lic_no','disposition','disposition_date','work_injury','injury_date','injury_type','injury_location','surg_performed','surgery_date','hospital_status','pregnancy','facility_death','embalmer_lic_no','death_type','time_death','birth_cert','certifier','cert_number','birth_vol_year','local_file_no','vdi','cite_id','file_id','date_last_trans','amendment_code','amendment_year','_on_lexis','_fs_profile','us_armed_forces','place_of_death','state_death_id','state_death_flag','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','state','zip5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','orig_address1','orig_address2','statefn','lf');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'process_date' => 1,'source_state' => 2,'certificate_vol_no' => 3,'certificate_vol_year' => 4,'publication' => 5,'decedent_name' => 6,'decedent_race' => 7,'decedent_origin' => 8,'decedent_sex' => 9,'decedent_age' => 10,'education' => 11,'occupation' => 12,'where_worked' => 13,'cause' => 14,'ssn' => 15,'dob' => 16,'dod' => 17,'birthplace' => 18,'marital_status' => 19,'father' => 20,'mother' => 21,'filed_date' => 22,'year' => 23,'county_residence' => 24,'county_death' => 25,'address' => 26,'autopsy' => 27,'autopsy_findings' => 28,'primary_cause_of_death' => 29,'underlying_cause_of_death' => 30,'med_exam' => 31,'est_lic_no' => 32,'disposition' => 33,'disposition_date' => 34,'work_injury' => 35,'injury_date' => 36,'injury_type' => 37,'injury_location' => 38,'surg_performed' => 39,'surgery_date' => 40,'hospital_status' => 41,'pregnancy' => 42,'facility_death' => 43,'embalmer_lic_no' => 44,'death_type' => 45,'time_death' => 46,'birth_cert' => 47,'certifier' => 48,'cert_number' => 49,'birth_vol_year' => 50,'local_file_no' => 51,'vdi' => 52,'cite_id' => 53,'file_id' => 54,'date_last_trans' => 55,'amendment_code' => 56,'amendment_year' => 57,'_on_lexis' => 58,'_fs_profile' => 59,'us_armed_forces' => 60,'place_of_death' => 61,'state_death_id' => 62,'state_death_flag' => 63,'title' => 64,'fname' => 65,'mname' => 66,'lname' => 67,'name_suffix' => 68,'name_score' => 69,'prim_range' => 70,'predir' => 71,'prim_name' => 72,'addr_suffix' => 73,'postdir' => 74,'unit_desig' => 75,'sec_range' => 76,'p_city_name' => 77,'v_city_name' => 78,'state' => 79,'zip5' => 80,'zip4' => 81,'cart' => 82,'cr_sort_sz' => 83,'lot' => 84,'lot_order' => 85,'dpbc' => 86,'chk_digit' => 87,'rec_type' => 88,'fips_state' => 89,'fips_county' => 90,'geo_lat' => 91,'geo_long' => 92,'msa' => 93,'geo_blk' => 94,'geo_match' => 95,'err_stat' => 96,'rawaid' => 97,'orig_address1' => 98,'orig_address2' => 99,'statefn' => 100,'lf' => 101,0);
//Individual field level validation
EXPORT Make_process_date(SALT30.StrType s0) := MakeFT_invalid_process_date(s0);
EXPORT InValid_process_date(SALT30.StrType s) := InValidFT_invalid_process_date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_process_date(wh);
EXPORT Make_source_state(SALT30.StrType s0) := MakeFT_invalid_source_state(s0);
EXPORT InValid_source_state(SALT30.StrType s) := InValidFT_invalid_source_state(s);
EXPORT InValidMessage_source_state(UNSIGNED1 wh) := InValidMessageFT_invalid_source_state(wh);
EXPORT Make_certificate_vol_no(SALT30.StrType s0) := MakeFT_invalid_certificate_vol_no(s0);
EXPORT InValid_certificate_vol_no(SALT30.StrType s) := InValidFT_invalid_certificate_vol_no(s);
EXPORT InValidMessage_certificate_vol_no(UNSIGNED1 wh) := InValidMessageFT_invalid_certificate_vol_no(wh);
EXPORT Make_certificate_vol_year(SALT30.StrType s0) := MakeFT_invalid_certificate_vol_year(s0);
EXPORT InValid_certificate_vol_year(SALT30.StrType s) := InValidFT_invalid_certificate_vol_year(s);
EXPORT InValidMessage_certificate_vol_year(UNSIGNED1 wh) := InValidMessageFT_invalid_certificate_vol_year(wh);
EXPORT Make_publication(SALT30.StrType s0) := MakeFT_invalid_publication(s0);
EXPORT InValid_publication(SALT30.StrType s) := InValidFT_invalid_publication(s);
EXPORT InValidMessage_publication(UNSIGNED1 wh) := InValidMessageFT_invalid_publication(wh);
EXPORT Make_decedent_name(SALT30.StrType s0) := MakeFT_invalid_decedent_name(s0);
EXPORT InValid_decedent_name(SALT30.StrType s) := InValidFT_invalid_decedent_name(s);
EXPORT InValidMessage_decedent_name(UNSIGNED1 wh) := InValidMessageFT_invalid_decedent_name(wh);
EXPORT Make_decedent_race(SALT30.StrType s0) := MakeFT_invalid_decedent_race(s0);
EXPORT InValid_decedent_race(SALT30.StrType s) := InValidFT_invalid_decedent_race(s);
EXPORT InValidMessage_decedent_race(UNSIGNED1 wh) := InValidMessageFT_invalid_decedent_race(wh);
EXPORT Make_decedent_origin(SALT30.StrType s0) := MakeFT_invalid_decedent_origin(s0);
EXPORT InValid_decedent_origin(SALT30.StrType s) := InValidFT_invalid_decedent_origin(s);
EXPORT InValidMessage_decedent_origin(UNSIGNED1 wh) := InValidMessageFT_invalid_decedent_origin(wh);
EXPORT Make_decedent_sex(SALT30.StrType s0) := MakeFT_invalid_decedent_sex(s0);
EXPORT InValid_decedent_sex(SALT30.StrType s) := InValidFT_invalid_decedent_sex(s);
EXPORT InValidMessage_decedent_sex(UNSIGNED1 wh) := InValidMessageFT_invalid_decedent_sex(wh);
EXPORT Make_decedent_age(SALT30.StrType s0) := MakeFT_invalid_decedent_age(s0);
EXPORT InValid_decedent_age(SALT30.StrType s) := InValidFT_invalid_decedent_age(s);
EXPORT InValidMessage_decedent_age(UNSIGNED1 wh) := InValidMessageFT_invalid_decedent_age(wh);
EXPORT Make_education(SALT30.StrType s0) := MakeFT_invalid_education(s0);
EXPORT InValid_education(SALT30.StrType s) := InValidFT_invalid_education(s);
EXPORT InValidMessage_education(UNSIGNED1 wh) := InValidMessageFT_invalid_education(wh);
EXPORT Make_occupation(SALT30.StrType s0) := MakeFT_invalid_occupation(s0);
EXPORT InValid_occupation(SALT30.StrType s) := InValidFT_invalid_occupation(s);
EXPORT InValidMessage_occupation(UNSIGNED1 wh) := InValidMessageFT_invalid_occupation(wh);
EXPORT Make_where_worked(SALT30.StrType s0) := MakeFT_invalid_where_worked(s0);
EXPORT InValid_where_worked(SALT30.StrType s) := InValidFT_invalid_where_worked(s);
EXPORT InValidMessage_where_worked(UNSIGNED1 wh) := InValidMessageFT_invalid_where_worked(wh);
EXPORT Make_cause(SALT30.StrType s0) := MakeFT_invalid_cause(s0);
EXPORT InValid_cause(SALT30.StrType s) := InValidFT_invalid_cause(s);
EXPORT InValidMessage_cause(UNSIGNED1 wh) := InValidMessageFT_invalid_cause(wh);
EXPORT Make_ssn(SALT30.StrType s0) := MakeFT_invalid_ssn(s0);
EXPORT InValid_ssn(SALT30.StrType s) := InValidFT_invalid_ssn(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_ssn(wh);
EXPORT Make_dob(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_dod(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dod(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dod(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_birthplace(SALT30.StrType s0) := MakeFT_invalid_birthplace(s0);
EXPORT InValid_birthplace(SALT30.StrType s) := InValidFT_invalid_birthplace(s);
EXPORT InValidMessage_birthplace(UNSIGNED1 wh) := InValidMessageFT_invalid_birthplace(wh);
EXPORT Make_marital_status(SALT30.StrType s0) := MakeFT_invalid_marital_status(s0);
EXPORT InValid_marital_status(SALT30.StrType s) := InValidFT_invalid_marital_status(s);
EXPORT InValidMessage_marital_status(UNSIGNED1 wh) := InValidMessageFT_invalid_marital_status(wh);
EXPORT Make_father(SALT30.StrType s0) := MakeFT_invalid_parent_name(s0);
EXPORT InValid_father(SALT30.StrType s) := InValidFT_invalid_parent_name(s);
EXPORT InValidMessage_father(UNSIGNED1 wh) := InValidMessageFT_invalid_parent_name(wh);
EXPORT Make_mother(SALT30.StrType s0) := MakeFT_invalid_parent_name(s0);
EXPORT InValid_mother(SALT30.StrType s) := InValidFT_invalid_parent_name(s);
EXPORT InValidMessage_mother(UNSIGNED1 wh) := InValidMessageFT_invalid_parent_name(wh);
EXPORT Make_filed_date(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_filed_date(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_filed_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_year(SALT30.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_year(SALT30.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_year(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
EXPORT Make_county_residence(SALT30.StrType s0) := MakeFT_invalid_county_residence(s0);
EXPORT InValid_county_residence(SALT30.StrType s) := InValidFT_invalid_county_residence(s);
EXPORT InValidMessage_county_residence(UNSIGNED1 wh) := InValidMessageFT_invalid_county_residence(wh);
EXPORT Make_county_death(SALT30.StrType s0) := MakeFT_invalid_county_death(s0);
EXPORT InValid_county_death(SALT30.StrType s) := InValidFT_invalid_county_death(s);
EXPORT InValidMessage_county_death(UNSIGNED1 wh) := InValidMessageFT_invalid_county_death(wh);
EXPORT Make_address(SALT30.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_address(SALT30.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_address(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_autopsy(SALT30.StrType s0) := MakeFT_invalid_autopsy(s0);
EXPORT InValid_autopsy(SALT30.StrType s) := InValidFT_invalid_autopsy(s);
EXPORT InValidMessage_autopsy(UNSIGNED1 wh) := InValidMessageFT_invalid_autopsy(wh);
EXPORT Make_autopsy_findings(SALT30.StrType s0) := MakeFT_invalid_autopsy_findings(s0);
EXPORT InValid_autopsy_findings(SALT30.StrType s) := InValidFT_invalid_autopsy_findings(s);
EXPORT InValidMessage_autopsy_findings(UNSIGNED1 wh) := InValidMessageFT_invalid_autopsy_findings(wh);
EXPORT Make_primary_cause_of_death(SALT30.StrType s0) := MakeFT_invalid_primary_cause_of_death(s0);
EXPORT InValid_primary_cause_of_death(SALT30.StrType s) := InValidFT_invalid_primary_cause_of_death(s);
EXPORT InValidMessage_primary_cause_of_death(UNSIGNED1 wh) := InValidMessageFT_invalid_primary_cause_of_death(wh);
EXPORT Make_underlying_cause_of_death(SALT30.StrType s0) := MakeFT_invalid_underlying_cause_of_death(s0);
EXPORT InValid_underlying_cause_of_death(SALT30.StrType s) := InValidFT_invalid_underlying_cause_of_death(s);
EXPORT InValidMessage_underlying_cause_of_death(UNSIGNED1 wh) := InValidMessageFT_invalid_underlying_cause_of_death(wh);
EXPORT Make_med_exam(SALT30.StrType s0) := MakeFT_invalid_med_exam(s0);
EXPORT InValid_med_exam(SALT30.StrType s) := InValidFT_invalid_med_exam(s);
EXPORT InValidMessage_med_exam(UNSIGNED1 wh) := InValidMessageFT_invalid_med_exam(wh);
EXPORT Make_est_lic_no(SALT30.StrType s0) := MakeFT_invalid_est_lic_no(s0);
EXPORT InValid_est_lic_no(SALT30.StrType s) := InValidFT_invalid_est_lic_no(s);
EXPORT InValidMessage_est_lic_no(UNSIGNED1 wh) := InValidMessageFT_invalid_est_lic_no(wh);
EXPORT Make_disposition(SALT30.StrType s0) := MakeFT_invalid_disposition(s0);
EXPORT InValid_disposition(SALT30.StrType s) := InValidFT_invalid_disposition(s);
EXPORT InValidMessage_disposition(UNSIGNED1 wh) := InValidMessageFT_invalid_disposition(wh);
EXPORT Make_disposition_date(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_disposition_date(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_disposition_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_work_injury(SALT30.StrType s0) := MakeFT_invalid_work_injury(s0);
EXPORT InValid_work_injury(SALT30.StrType s) := InValidFT_invalid_work_injury(s);
EXPORT InValidMessage_work_injury(UNSIGNED1 wh) := InValidMessageFT_invalid_work_injury(wh);
EXPORT Make_injury_date(SALT30.StrType s0) := MakeFT_invalid_injury_date(s0);
EXPORT InValid_injury_date(SALT30.StrType s) := InValidFT_invalid_injury_date(s);
EXPORT InValidMessage_injury_date(UNSIGNED1 wh) := InValidMessageFT_invalid_injury_date(wh);
EXPORT Make_injury_type(SALT30.StrType s0) := MakeFT_invalid_injury_type(s0);
EXPORT InValid_injury_type(SALT30.StrType s) := InValidFT_invalid_injury_type(s);
EXPORT InValidMessage_injury_type(UNSIGNED1 wh) := InValidMessageFT_invalid_injury_type(wh);
EXPORT Make_injury_location(SALT30.StrType s0) := MakeFT_invalid_injury_location(s0);
EXPORT InValid_injury_location(SALT30.StrType s) := InValidFT_invalid_injury_location(s);
EXPORT InValidMessage_injury_location(UNSIGNED1 wh) := InValidMessageFT_invalid_injury_location(wh);
EXPORT Make_surg_performed(SALT30.StrType s0) := MakeFT_invalid_surg_performed(s0);
EXPORT InValid_surg_performed(SALT30.StrType s) := InValidFT_invalid_surg_performed(s);
EXPORT InValidMessage_surg_performed(UNSIGNED1 wh) := InValidMessageFT_invalid_surg_performed(wh);
EXPORT Make_surgery_date(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_surgery_date(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_surgery_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_hospital_status(SALT30.StrType s0) := MakeFT_invalid_hospital_status(s0);
EXPORT InValid_hospital_status(SALT30.StrType s) := InValidFT_invalid_hospital_status(s);
EXPORT InValidMessage_hospital_status(UNSIGNED1 wh) := InValidMessageFT_invalid_hospital_status(wh);
EXPORT Make_pregnancy(SALT30.StrType s0) := MakeFT_invalid_pregnancy(s0);
EXPORT InValid_pregnancy(SALT30.StrType s) := InValidFT_invalid_pregnancy(s);
EXPORT InValidMessage_pregnancy(UNSIGNED1 wh) := InValidMessageFT_invalid_pregnancy(wh);
EXPORT Make_facility_death(SALT30.StrType s0) := MakeFT_invalid_facility_death(s0);
EXPORT InValid_facility_death(SALT30.StrType s) := InValidFT_invalid_facility_death(s);
EXPORT InValidMessage_facility_death(UNSIGNED1 wh) := InValidMessageFT_invalid_facility_death(wh);
EXPORT Make_embalmer_lic_no(SALT30.StrType s0) := MakeFT_invalid_embalmer_lic_no(s0);
EXPORT InValid_embalmer_lic_no(SALT30.StrType s) := InValidFT_invalid_embalmer_lic_no(s);
EXPORT InValidMessage_embalmer_lic_no(UNSIGNED1 wh) := InValidMessageFT_invalid_embalmer_lic_no(wh);
EXPORT Make_death_type(SALT30.StrType s0) := MakeFT_invalid_death_type(s0);
EXPORT InValid_death_type(SALT30.StrType s) := InValidFT_invalid_death_type(s);
EXPORT InValidMessage_death_type(UNSIGNED1 wh) := InValidMessageFT_invalid_death_type(wh);
EXPORT Make_time_death(SALT30.StrType s0) := MakeFT_invalid_time_death(s0);
EXPORT InValid_time_death(SALT30.StrType s) := InValidFT_invalid_time_death(s);
EXPORT InValidMessage_time_death(UNSIGNED1 wh) := InValidMessageFT_invalid_time_death(wh);
EXPORT Make_birth_cert(SALT30.StrType s0) := MakeFT_invalid_birth_cert(s0);
EXPORT InValid_birth_cert(SALT30.StrType s) := InValidFT_invalid_birth_cert(s);
EXPORT InValidMessage_birth_cert(UNSIGNED1 wh) := InValidMessageFT_invalid_birth_cert(wh);
EXPORT Make_certifier(SALT30.StrType s0) := MakeFT_invalid_certifier(s0);
EXPORT InValid_certifier(SALT30.StrType s) := InValidFT_invalid_certifier(s);
EXPORT InValidMessage_certifier(UNSIGNED1 wh) := InValidMessageFT_invalid_certifier(wh);
EXPORT Make_cert_number(SALT30.StrType s0) := MakeFT_invalid_cert_number(s0);
EXPORT InValid_cert_number(SALT30.StrType s) := InValidFT_invalid_cert_number(s);
EXPORT InValidMessage_cert_number(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_number(wh);
EXPORT Make_birth_vol_year(SALT30.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_birth_vol_year(SALT30.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_birth_vol_year(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
EXPORT Make_local_file_no(SALT30.StrType s0) := MakeFT_invalid_local_file_no(s0);
EXPORT InValid_local_file_no(SALT30.StrType s) := InValidFT_invalid_local_file_no(s);
EXPORT InValidMessage_local_file_no(UNSIGNED1 wh) := InValidMessageFT_invalid_local_file_no(wh);
EXPORT Make_vdi(SALT30.StrType s0) := MakeFT_invalid_vdi(s0);
EXPORT InValid_vdi(SALT30.StrType s) := InValidFT_invalid_vdi(s);
EXPORT InValidMessage_vdi(UNSIGNED1 wh) := InValidMessageFT_invalid_vdi(wh);
EXPORT Make_cite_id(SALT30.StrType s0) := MakeFT_invalid_cite_id(s0);
EXPORT InValid_cite_id(SALT30.StrType s) := InValidFT_invalid_cite_id(s);
EXPORT InValidMessage_cite_id(UNSIGNED1 wh) := InValidMessageFT_invalid_cite_id(wh);
EXPORT Make_file_id(SALT30.StrType s0) := MakeFT_invalid_file_id(s0);
EXPORT InValid_file_id(SALT30.StrType s) := InValidFT_invalid_file_id(s);
EXPORT InValidMessage_file_id(UNSIGNED1 wh) := InValidMessageFT_invalid_file_id(wh);
EXPORT Make_date_last_trans(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_last_trans(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_last_trans(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_amendment_code(SALT30.StrType s0) := MakeFT_invalid_amendment_code(s0);
EXPORT InValid_amendment_code(SALT30.StrType s) := InValidFT_invalid_amendment_code(s);
EXPORT InValidMessage_amendment_code(UNSIGNED1 wh) := InValidMessageFT_invalid_amendment_code(wh);
EXPORT Make_amendment_year(SALT30.StrType s0) := MakeFT_invalid_amendment_year(s0);
EXPORT InValid_amendment_year(SALT30.StrType s) := InValidFT_invalid_amendment_year(s);
EXPORT InValidMessage_amendment_year(UNSIGNED1 wh) := InValidMessageFT_invalid_amendment_year(wh);
EXPORT Make__on_lexis(SALT30.StrType s0) := MakeFT_invalid__on_lexis(s0);
EXPORT InValid__on_lexis(SALT30.StrType s) := InValidFT_invalid__on_lexis(s);
EXPORT InValidMessage__on_lexis(UNSIGNED1 wh) := InValidMessageFT_invalid__on_lexis(wh);
EXPORT Make__fs_profile(SALT30.StrType s0) := MakeFT_invalid__fs_profile(s0);
EXPORT InValid__fs_profile(SALT30.StrType s) := InValidFT_invalid__fs_profile(s);
EXPORT InValidMessage__fs_profile(UNSIGNED1 wh) := InValidMessageFT_invalid__fs_profile(wh);
EXPORT Make_us_armed_forces(SALT30.StrType s0) := MakeFT_invalid_us_armed_forces(s0);
EXPORT InValid_us_armed_forces(SALT30.StrType s) := InValidFT_invalid_us_armed_forces(s);
EXPORT InValidMessage_us_armed_forces(UNSIGNED1 wh) := InValidMessageFT_invalid_us_armed_forces(wh);
EXPORT Make_place_of_death(SALT30.StrType s0) := MakeFT_invalid_place_of_death(s0);
EXPORT InValid_place_of_death(SALT30.StrType s) := InValidFT_invalid_place_of_death(s);
EXPORT InValidMessage_place_of_death(UNSIGNED1 wh) := InValidMessageFT_invalid_place_of_death(wh);
EXPORT Make_state_death_id(SALT30.StrType s0) := MakeFT_invalid_state_death_id(s0);
EXPORT InValid_state_death_id(SALT30.StrType s) := InValidFT_invalid_state_death_id(s);
EXPORT InValidMessage_state_death_id(UNSIGNED1 wh) := InValidMessageFT_invalid_state_death_id(wh);
EXPORT Make_state_death_flag(SALT30.StrType s0) := MakeFT_invalid_state_death_flag(s0);
EXPORT InValid_state_death_flag(SALT30.StrType s) := InValidFT_invalid_state_death_flag(s);
EXPORT InValidMessage_state_death_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_state_death_flag(wh);
EXPORT Make_title(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_title(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_fname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_fname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_mname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_mname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_lname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_lname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_name_suffix(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_name_suffix(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_name_score(SALT30.StrType s0) := MakeFT_invalid_name_score(s0);
EXPORT InValid_name_score(SALT30.StrType s) := InValidFT_invalid_name_score(s);
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := InValidMessageFT_invalid_name_score(wh);
EXPORT Make_prim_range(SALT30.StrType s0) := MakeFT_invalid_prim_range(s0);
EXPORT InValid_prim_range(SALT30.StrType s) := InValidFT_invalid_prim_range(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_invalid_prim_range(wh);
EXPORT Make_predir(SALT30.StrType s0) := MakeFT_invalid_predir(s0);
EXPORT InValid_predir(SALT30.StrType s) := InValidFT_invalid_predir(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_predir(wh);
EXPORT Make_prim_name(SALT30.StrType s0) := MakeFT_invalid_prim_name(s0);
EXPORT InValid_prim_name(SALT30.StrType s) := InValidFT_invalid_prim_name(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_prim_name(wh);
EXPORT Make_addr_suffix(SALT30.StrType s0) := MakeFT_invalid_addr_suffix(s0);
EXPORT InValid_addr_suffix(SALT30.StrType s) := InValidFT_invalid_addr_suffix(s);
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_addr_suffix(wh);
EXPORT Make_postdir(SALT30.StrType s0) := MakeFT_invalid_postdir(s0);
EXPORT InValid_postdir(SALT30.StrType s) := InValidFT_invalid_postdir(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_postdir(wh);
EXPORT Make_unit_desig(SALT30.StrType s0) := MakeFT_invalid_unit_desig(s0);
EXPORT InValid_unit_desig(SALT30.StrType s) := InValidFT_invalid_unit_desig(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_invalid_unit_desig(wh);
EXPORT Make_sec_range(SALT30.StrType s0) := MakeFT_invalid_sec_range(s0);
EXPORT InValid_sec_range(SALT30.StrType s) := InValidFT_invalid_sec_range(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_invalid_sec_range(wh);
EXPORT Make_p_city_name(SALT30.StrType s0) := MakeFT_invalid_p_city_name(s0);
EXPORT InValid_p_city_name(SALT30.StrType s) := InValidFT_invalid_p_city_name(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_p_city_name(wh);
EXPORT Make_v_city_name(SALT30.StrType s0) := MakeFT_invalid_v_city_name(s0);
EXPORT InValid_v_city_name(SALT30.StrType s) := InValidFT_invalid_v_city_name(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_v_city_name(wh);
EXPORT Make_state(SALT30.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT30.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
EXPORT Make_zip5(SALT30.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip5(SALT30.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
EXPORT Make_zip4(SALT30.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_zip4(SALT30.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
EXPORT Make_cart(SALT30.StrType s0) := MakeFT_invalid_cart(s0);
EXPORT InValid_cart(SALT30.StrType s) := InValidFT_invalid_cart(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_invalid_cart(wh);
EXPORT Make_cr_sort_sz(SALT30.StrType s0) := MakeFT_invalid_cr_sort_sz(s0);
EXPORT InValid_cr_sort_sz(SALT30.StrType s) := InValidFT_invalid_cr_sort_sz(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_invalid_cr_sort_sz(wh);
EXPORT Make_lot(SALT30.StrType s0) := MakeFT_invalid_lot(s0);
EXPORT InValid_lot(SALT30.StrType s) := InValidFT_invalid_lot(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_invalid_lot(wh);
EXPORT Make_lot_order(SALT30.StrType s0) := MakeFT_invalid_lot_order(s0);
EXPORT InValid_lot_order(SALT30.StrType s) := InValidFT_invalid_lot_order(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_invalid_lot_order(wh);
EXPORT Make_dpbc(SALT30.StrType s0) := MakeFT_invalid_dpbc(s0);
EXPORT InValid_dpbc(SALT30.StrType s) := InValidFT_invalid_dpbc(s);
EXPORT InValidMessage_dpbc(UNSIGNED1 wh) := InValidMessageFT_invalid_dpbc(wh);
EXPORT Make_chk_digit(SALT30.StrType s0) := MakeFT_invalid_chk_digit(s0);
EXPORT InValid_chk_digit(SALT30.StrType s) := InValidFT_invalid_chk_digit(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_invalid_chk_digit(wh);
EXPORT Make_rec_type(SALT30.StrType s0) := MakeFT_invalid_rec_type(s0);
EXPORT InValid_rec_type(SALT30.StrType s) := InValidFT_invalid_rec_type(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_invalid_rec_type(wh);
EXPORT Make_fips_state(SALT30.StrType s0) := MakeFT_invalid_fipsstate(s0);
EXPORT InValid_fips_state(SALT30.StrType s) := InValidFT_invalid_fipsstate(s);
EXPORT InValidMessage_fips_state(UNSIGNED1 wh) := InValidMessageFT_invalid_fipsstate(wh);
EXPORT Make_fips_county(SALT30.StrType s0) := MakeFT_invalid_fipscounty(s0);
EXPORT InValid_fips_county(SALT30.StrType s) := InValidFT_invalid_fipscounty(s);
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := InValidMessageFT_invalid_fipscounty(wh);
EXPORT Make_geo_lat(SALT30.StrType s0) := MakeFT_invalid_geo_lat(s0);
EXPORT InValid_geo_lat(SALT30.StrType s) := InValidFT_invalid_geo_lat(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_lat(wh);
EXPORT Make_geo_long(SALT30.StrType s0) := MakeFT_invalid_geo_long(s0);
EXPORT InValid_geo_long(SALT30.StrType s) := InValidFT_invalid_geo_long(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_long(wh);
EXPORT Make_msa(SALT30.StrType s0) := MakeFT_invalid_msa(s0);
EXPORT InValid_msa(SALT30.StrType s) := InValidFT_invalid_msa(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_invalid_msa(wh);
EXPORT Make_geo_blk(SALT30.StrType s0) := MakeFT_invalid_geo_blk(s0);
EXPORT InValid_geo_blk(SALT30.StrType s) := InValidFT_invalid_geo_blk(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_blk(wh);
EXPORT Make_geo_match(SALT30.StrType s0) := MakeFT_invalid_geo_match(s0);
EXPORT InValid_geo_match(SALT30.StrType s) := InValidFT_invalid_geo_match(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_match(wh);
EXPORT Make_err_stat(SALT30.StrType s0) := MakeFT_invalid_err_stat(s0);
EXPORT InValid_err_stat(SALT30.StrType s) := InValidFT_invalid_err_stat(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_invalid_err_stat(wh);
EXPORT Make_rawaid(SALT30.StrType s0) := MakeFT_invalid_rawaid(s0);
EXPORT InValid_rawaid(SALT30.StrType s) := InValidFT_invalid_rawaid(s);
EXPORT InValidMessage_rawaid(UNSIGNED1 wh) := InValidMessageFT_invalid_rawaid(wh);
EXPORT Make_orig_address1(SALT30.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_orig_address1(SALT30.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_orig_address1(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_orig_address2(SALT30.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_orig_address2(SALT30.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_orig_address2(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_statefn(SALT30.StrType s0) := MakeFT_invalid_statefn(s0);
EXPORT InValid_statefn(SALT30.StrType s) := InValidFT_invalid_statefn(s);
EXPORT InValidMessage_statefn(UNSIGNED1 wh) := InValidMessageFT_invalid_statefn(wh);
EXPORT Make_lf(SALT30.StrType s0) := MakeFT_invalid_lf(s0);
EXPORT InValid_lf(SALT30.StrType s) := InValidFT_invalid_lf(s);
EXPORT InValidMessage_lf(UNSIGNED1 wh) := InValidMessageFT_invalid_lf(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,Scrubs_Death_Master_Supplemental;
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
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_source_state;
    BOOLEAN Diff_certificate_vol_no;
    BOOLEAN Diff_certificate_vol_year;
    BOOLEAN Diff_publication;
    BOOLEAN Diff_decedent_name;
    BOOLEAN Diff_decedent_race;
    BOOLEAN Diff_decedent_origin;
    BOOLEAN Diff_decedent_sex;
    BOOLEAN Diff_decedent_age;
    BOOLEAN Diff_education;
    BOOLEAN Diff_occupation;
    BOOLEAN Diff_where_worked;
    BOOLEAN Diff_cause;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_dod;
    BOOLEAN Diff_birthplace;
    BOOLEAN Diff_marital_status;
    BOOLEAN Diff_father;
    BOOLEAN Diff_mother;
    BOOLEAN Diff_filed_date;
    BOOLEAN Diff_year;
    BOOLEAN Diff_county_residence;
    BOOLEAN Diff_county_death;
    BOOLEAN Diff_address;
    BOOLEAN Diff_autopsy;
    BOOLEAN Diff_autopsy_findings;
    BOOLEAN Diff_primary_cause_of_death;
    BOOLEAN Diff_underlying_cause_of_death;
    BOOLEAN Diff_med_exam;
    BOOLEAN Diff_est_lic_no;
    BOOLEAN Diff_disposition;
    BOOLEAN Diff_disposition_date;
    BOOLEAN Diff_work_injury;
    BOOLEAN Diff_injury_date;
    BOOLEAN Diff_injury_type;
    BOOLEAN Diff_injury_location;
    BOOLEAN Diff_surg_performed;
    BOOLEAN Diff_surgery_date;
    BOOLEAN Diff_hospital_status;
    BOOLEAN Diff_pregnancy;
    BOOLEAN Diff_facility_death;
    BOOLEAN Diff_embalmer_lic_no;
    BOOLEAN Diff_death_type;
    BOOLEAN Diff_time_death;
    BOOLEAN Diff_birth_cert;
    BOOLEAN Diff_certifier;
    BOOLEAN Diff_cert_number;
    BOOLEAN Diff_birth_vol_year;
    BOOLEAN Diff_local_file_no;
    BOOLEAN Diff_vdi;
    BOOLEAN Diff_cite_id;
    BOOLEAN Diff_file_id;
    BOOLEAN Diff_date_last_trans;
    BOOLEAN Diff_amendment_code;
    BOOLEAN Diff_amendment_year;
    BOOLEAN Diff__on_lexis;
    BOOLEAN Diff__fs_profile;
    BOOLEAN Diff_us_armed_forces;
    BOOLEAN Diff_place_of_death;
    BOOLEAN Diff_state_death_id;
    BOOLEAN Diff_state_death_flag;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip5;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dpbc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_fips_state;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_rawaid;
    BOOLEAN Diff_orig_address1;
    BOOLEAN Diff_orig_address2;
    BOOLEAN Diff_statefn;
    BOOLEAN Diff_lf;
    SALT30.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT30.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_source_state := le.source_state <> ri.source_state;
    SELF.Diff_certificate_vol_no := le.certificate_vol_no <> ri.certificate_vol_no;
    SELF.Diff_certificate_vol_year := le.certificate_vol_year <> ri.certificate_vol_year;
    SELF.Diff_publication := le.publication <> ri.publication;
    SELF.Diff_decedent_name := le.decedent_name <> ri.decedent_name;
    SELF.Diff_decedent_race := le.decedent_race <> ri.decedent_race;
    SELF.Diff_decedent_origin := le.decedent_origin <> ri.decedent_origin;
    SELF.Diff_decedent_sex := le.decedent_sex <> ri.decedent_sex;
    SELF.Diff_decedent_age := le.decedent_age <> ri.decedent_age;
    SELF.Diff_education := le.education <> ri.education;
    SELF.Diff_occupation := le.occupation <> ri.occupation;
    SELF.Diff_where_worked := le.where_worked <> ri.where_worked;
    SELF.Diff_cause := le.cause <> ri.cause;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_dod := le.dod <> ri.dod;
    SELF.Diff_birthplace := le.birthplace <> ri.birthplace;
    SELF.Diff_marital_status := le.marital_status <> ri.marital_status;
    SELF.Diff_father := le.father <> ri.father;
    SELF.Diff_mother := le.mother <> ri.mother;
    SELF.Diff_filed_date := le.filed_date <> ri.filed_date;
    SELF.Diff_year := le.year <> ri.year;
    SELF.Diff_county_residence := le.county_residence <> ri.county_residence;
    SELF.Diff_county_death := le.county_death <> ri.county_death;
    SELF.Diff_address := le.address <> ri.address;
    SELF.Diff_autopsy := le.autopsy <> ri.autopsy;
    SELF.Diff_autopsy_findings := le.autopsy_findings <> ri.autopsy_findings;
    SELF.Diff_primary_cause_of_death := le.primary_cause_of_death <> ri.primary_cause_of_death;
    SELF.Diff_underlying_cause_of_death := le.underlying_cause_of_death <> ri.underlying_cause_of_death;
    SELF.Diff_med_exam := le.med_exam <> ri.med_exam;
    SELF.Diff_est_lic_no := le.est_lic_no <> ri.est_lic_no;
    SELF.Diff_disposition := le.disposition <> ri.disposition;
    SELF.Diff_disposition_date := le.disposition_date <> ri.disposition_date;
    SELF.Diff_work_injury := le.work_injury <> ri.work_injury;
    SELF.Diff_injury_date := le.injury_date <> ri.injury_date;
    SELF.Diff_injury_type := le.injury_type <> ri.injury_type;
    SELF.Diff_injury_location := le.injury_location <> ri.injury_location;
    SELF.Diff_surg_performed := le.surg_performed <> ri.surg_performed;
    SELF.Diff_surgery_date := le.surgery_date <> ri.surgery_date;
    SELF.Diff_hospital_status := le.hospital_status <> ri.hospital_status;
    SELF.Diff_pregnancy := le.pregnancy <> ri.pregnancy;
    SELF.Diff_facility_death := le.facility_death <> ri.facility_death;
    SELF.Diff_embalmer_lic_no := le.embalmer_lic_no <> ri.embalmer_lic_no;
    SELF.Diff_death_type := le.death_type <> ri.death_type;
    SELF.Diff_time_death := le.time_death <> ri.time_death;
    SELF.Diff_birth_cert := le.birth_cert <> ri.birth_cert;
    SELF.Diff_certifier := le.certifier <> ri.certifier;
    SELF.Diff_cert_number := le.cert_number <> ri.cert_number;
    SELF.Diff_birth_vol_year := le.birth_vol_year <> ri.birth_vol_year;
    SELF.Diff_local_file_no := le.local_file_no <> ri.local_file_no;
    SELF.Diff_vdi := le.vdi <> ri.vdi;
    SELF.Diff_cite_id := le.cite_id <> ri.cite_id;
    SELF.Diff_file_id := le.file_id <> ri.file_id;
    SELF.Diff_date_last_trans := le.date_last_trans <> ri.date_last_trans;
    SELF.Diff_amendment_code := le.amendment_code <> ri.amendment_code;
    SELF.Diff_amendment_year := le.amendment_year <> ri.amendment_year;
    SELF.Diff__on_lexis := le._on_lexis <> ri._on_lexis;
    SELF.Diff__fs_profile := le._fs_profile <> ri._fs_profile;
    SELF.Diff_us_armed_forces := le.us_armed_forces <> ri.us_armed_forces;
    SELF.Diff_place_of_death := le.place_of_death <> ri.place_of_death;
    SELF.Diff_state_death_id := le.state_death_id <> ri.state_death_id;
    SELF.Diff_state_death_flag := le.state_death_flag <> ri.state_death_flag;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip5 := le.zip5 <> ri.zip5;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dpbc := le.dpbc <> ri.dpbc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_fips_state := le.fips_state <> ri.fips_state;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_rawaid := le.rawaid <> ri.rawaid;
    SELF.Diff_orig_address1 := le.orig_address1 <> ri.orig_address1;
    SELF.Diff_orig_address2 := le.orig_address2 <> ri.orig_address2;
    SELF.Diff_statefn := le.statefn <> ri.statefn;
    SELF.Diff_lf := le.lf <> ri.lf;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source_state;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_source_state,1,0)+ IF( SELF.Diff_certificate_vol_no,1,0)+ IF( SELF.Diff_certificate_vol_year,1,0)+ IF( SELF.Diff_publication,1,0)+ IF( SELF.Diff_decedent_name,1,0)+ IF( SELF.Diff_decedent_race,1,0)+ IF( SELF.Diff_decedent_origin,1,0)+ IF( SELF.Diff_decedent_sex,1,0)+ IF( SELF.Diff_decedent_age,1,0)+ IF( SELF.Diff_education,1,0)+ IF( SELF.Diff_occupation,1,0)+ IF( SELF.Diff_where_worked,1,0)+ IF( SELF.Diff_cause,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_dod,1,0)+ IF( SELF.Diff_birthplace,1,0)+ IF( SELF.Diff_marital_status,1,0)+ IF( SELF.Diff_father,1,0)+ IF( SELF.Diff_mother,1,0)+ IF( SELF.Diff_filed_date,1,0)+ IF( SELF.Diff_year,1,0)+ IF( SELF.Diff_county_residence,1,0)+ IF( SELF.Diff_county_death,1,0)+ IF( SELF.Diff_address,1,0)+ IF( SELF.Diff_autopsy,1,0)+ IF( SELF.Diff_autopsy_findings,1,0)+ IF( SELF.Diff_primary_cause_of_death,1,0)+ IF( SELF.Diff_underlying_cause_of_death,1,0)+ IF( SELF.Diff_med_exam,1,0)+ IF( SELF.Diff_est_lic_no,1,0)+ IF( SELF.Diff_disposition,1,0)+ IF( SELF.Diff_disposition_date,1,0)+ IF( SELF.Diff_work_injury,1,0)+ IF( SELF.Diff_injury_date,1,0)+ IF( SELF.Diff_injury_type,1,0)+ IF( SELF.Diff_injury_location,1,0)+ IF( SELF.Diff_surg_performed,1,0)+ IF( SELF.Diff_surgery_date,1,0)+ IF( SELF.Diff_hospital_status,1,0)+ IF( SELF.Diff_pregnancy,1,0)+ IF( SELF.Diff_facility_death,1,0)+ IF( SELF.Diff_embalmer_lic_no,1,0)+ IF( SELF.Diff_death_type,1,0)+ IF( SELF.Diff_time_death,1,0)+ IF( SELF.Diff_birth_cert,1,0)+ IF( SELF.Diff_certifier,1,0)+ IF( SELF.Diff_cert_number,1,0)+ IF( SELF.Diff_birth_vol_year,1,0)+ IF( SELF.Diff_local_file_no,1,0)+ IF( SELF.Diff_vdi,1,0)+ IF( SELF.Diff_cite_id,1,0)+ IF( SELF.Diff_file_id,1,0)+ IF( SELF.Diff_date_last_trans,1,0)+ IF( SELF.Diff_amendment_code,1,0)+ IF( SELF.Diff_amendment_year,1,0)+ IF( SELF.Diff__on_lexis,1,0)+ IF( SELF.Diff__fs_profile,1,0)+ IF( SELF.Diff_us_armed_forces,1,0)+ IF( SELF.Diff_place_of_death,1,0)+ IF( SELF.Diff_state_death_id,1,0)+ IF( SELF.Diff_state_death_flag,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip5,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_fips_state,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_rawaid,1,0)+ IF( SELF.Diff_orig_address1,1,0)+ IF( SELF.Diff_orig_address2,1,0)+ IF( SELF.Diff_statefn,1,0)+ IF( SELF.Diff_lf,1,0);
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
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_source_state := COUNT(GROUP,%Closest%.Diff_source_state);
    Count_Diff_certificate_vol_no := COUNT(GROUP,%Closest%.Diff_certificate_vol_no);
    Count_Diff_certificate_vol_year := COUNT(GROUP,%Closest%.Diff_certificate_vol_year);
    Count_Diff_publication := COUNT(GROUP,%Closest%.Diff_publication);
    Count_Diff_decedent_name := COUNT(GROUP,%Closest%.Diff_decedent_name);
    Count_Diff_decedent_race := COUNT(GROUP,%Closest%.Diff_decedent_race);
    Count_Diff_decedent_origin := COUNT(GROUP,%Closest%.Diff_decedent_origin);
    Count_Diff_decedent_sex := COUNT(GROUP,%Closest%.Diff_decedent_sex);
    Count_Diff_decedent_age := COUNT(GROUP,%Closest%.Diff_decedent_age);
    Count_Diff_education := COUNT(GROUP,%Closest%.Diff_education);
    Count_Diff_occupation := COUNT(GROUP,%Closest%.Diff_occupation);
    Count_Diff_where_worked := COUNT(GROUP,%Closest%.Diff_where_worked);
    Count_Diff_cause := COUNT(GROUP,%Closest%.Diff_cause);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_dod := COUNT(GROUP,%Closest%.Diff_dod);
    Count_Diff_birthplace := COUNT(GROUP,%Closest%.Diff_birthplace);
    Count_Diff_marital_status := COUNT(GROUP,%Closest%.Diff_marital_status);
    Count_Diff_father := COUNT(GROUP,%Closest%.Diff_father);
    Count_Diff_mother := COUNT(GROUP,%Closest%.Diff_mother);
    Count_Diff_filed_date := COUNT(GROUP,%Closest%.Diff_filed_date);
    Count_Diff_year := COUNT(GROUP,%Closest%.Diff_year);
    Count_Diff_county_residence := COUNT(GROUP,%Closest%.Diff_county_residence);
    Count_Diff_county_death := COUNT(GROUP,%Closest%.Diff_county_death);
    Count_Diff_address := COUNT(GROUP,%Closest%.Diff_address);
    Count_Diff_autopsy := COUNT(GROUP,%Closest%.Diff_autopsy);
    Count_Diff_autopsy_findings := COUNT(GROUP,%Closest%.Diff_autopsy_findings);
    Count_Diff_primary_cause_of_death := COUNT(GROUP,%Closest%.Diff_primary_cause_of_death);
    Count_Diff_underlying_cause_of_death := COUNT(GROUP,%Closest%.Diff_underlying_cause_of_death);
    Count_Diff_med_exam := COUNT(GROUP,%Closest%.Diff_med_exam);
    Count_Diff_est_lic_no := COUNT(GROUP,%Closest%.Diff_est_lic_no);
    Count_Diff_disposition := COUNT(GROUP,%Closest%.Diff_disposition);
    Count_Diff_disposition_date := COUNT(GROUP,%Closest%.Diff_disposition_date);
    Count_Diff_work_injury := COUNT(GROUP,%Closest%.Diff_work_injury);
    Count_Diff_injury_date := COUNT(GROUP,%Closest%.Diff_injury_date);
    Count_Diff_injury_type := COUNT(GROUP,%Closest%.Diff_injury_type);
    Count_Diff_injury_location := COUNT(GROUP,%Closest%.Diff_injury_location);
    Count_Diff_surg_performed := COUNT(GROUP,%Closest%.Diff_surg_performed);
    Count_Diff_surgery_date := COUNT(GROUP,%Closest%.Diff_surgery_date);
    Count_Diff_hospital_status := COUNT(GROUP,%Closest%.Diff_hospital_status);
    Count_Diff_pregnancy := COUNT(GROUP,%Closest%.Diff_pregnancy);
    Count_Diff_facility_death := COUNT(GROUP,%Closest%.Diff_facility_death);
    Count_Diff_embalmer_lic_no := COUNT(GROUP,%Closest%.Diff_embalmer_lic_no);
    Count_Diff_death_type := COUNT(GROUP,%Closest%.Diff_death_type);
    Count_Diff_time_death := COUNT(GROUP,%Closest%.Diff_time_death);
    Count_Diff_birth_cert := COUNT(GROUP,%Closest%.Diff_birth_cert);
    Count_Diff_certifier := COUNT(GROUP,%Closest%.Diff_certifier);
    Count_Diff_cert_number := COUNT(GROUP,%Closest%.Diff_cert_number);
    Count_Diff_birth_vol_year := COUNT(GROUP,%Closest%.Diff_birth_vol_year);
    Count_Diff_local_file_no := COUNT(GROUP,%Closest%.Diff_local_file_no);
    Count_Diff_vdi := COUNT(GROUP,%Closest%.Diff_vdi);
    Count_Diff_cite_id := COUNT(GROUP,%Closest%.Diff_cite_id);
    Count_Diff_file_id := COUNT(GROUP,%Closest%.Diff_file_id);
    Count_Diff_date_last_trans := COUNT(GROUP,%Closest%.Diff_date_last_trans);
    Count_Diff_amendment_code := COUNT(GROUP,%Closest%.Diff_amendment_code);
    Count_Diff_amendment_year := COUNT(GROUP,%Closest%.Diff_amendment_year);
    Count_Diff__on_lexis := COUNT(GROUP,%Closest%.Diff__on_lexis);
    Count_Diff__fs_profile := COUNT(GROUP,%Closest%.Diff__fs_profile);
    Count_Diff_us_armed_forces := COUNT(GROUP,%Closest%.Diff_us_armed_forces);
    Count_Diff_place_of_death := COUNT(GROUP,%Closest%.Diff_place_of_death);
    Count_Diff_state_death_id := COUNT(GROUP,%Closest%.Diff_state_death_id);
    Count_Diff_state_death_flag := COUNT(GROUP,%Closest%.Diff_state_death_flag);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip5 := COUNT(GROUP,%Closest%.Diff_zip5);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dpbc := COUNT(GROUP,%Closest%.Diff_dpbc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_fips_state := COUNT(GROUP,%Closest%.Diff_fips_state);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_rawaid := COUNT(GROUP,%Closest%.Diff_rawaid);
    Count_Diff_orig_address1 := COUNT(GROUP,%Closest%.Diff_orig_address1);
    Count_Diff_orig_address2 := COUNT(GROUP,%Closest%.Diff_orig_address2);
    Count_Diff_statefn := COUNT(GROUP,%Closest%.Diff_statefn);
    Count_Diff_lf := COUNT(GROUP,%Closest%.Diff_lf);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
