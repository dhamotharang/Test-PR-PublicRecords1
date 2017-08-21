IMPORT ut,SALT31;
EXPORT Individuals_Fields := MODULE
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'hms_piid','first','middle','last','suffix','cred','practitioner_type','active','vendible','npi_num','npi_enumeration_date','npi_deactivation_date','npi_reactivation_date','npi_taxonomy_code','upin','medicare_participation_flag','date_born','date_died','pid','src','date_vendor_first_reported','date_vendor_last_reported','date_first_seen','date_last_seen','record_type','source_rid','lnpid','fname','mname','lname','name_suffix','nametype','nid','clean_npi_enumeration_date','clean_npi_deactivation_date','clean_npi_reactivation_date','clean_date_born','clean_date_died','clean_company_name','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','firm_name','lid','agid','address_std_code','latitude','longitude','prepped_addr1','prepped_addr2','addr_type','state_license_state','state_license_number','state_license_type','state_license_active','state_license_expire','state_license_qualifier','state_license_sub_qualifier','state_license_issued','clean_state_license_expire','clean_state_license_issued','dea_num','dea_bac','dea_sub_bac','dea_schedule','dea_expire','dea_active','clean_dea_expire','csr_number','csr_state','csr_expire_date','csr_issue_date','dsa_lvl_2','dsa_lvl_2n','dsa_lvl_3','dsa_lvl_3n','dsa_lvl_4','dsa_lvl_5','csr_raw1','csr_raw2','csr_raw3','csr_raw4','clean_csr_expire_date','clean_csr_issue_date','sanction_id','sanction_action_code','sanction_action_description','sanction_board_code','sanction_board_description','action_date','sanction_period_start_date','sanction_period_end_date','month_duration','fine_amount','offense_code','offense_description','offense_date','clean_offense_date','clean_action_date','clean_sanction_period_start_date','clean_sanction_period_end_date','gsa_sanction_id','gsa_first','gsa_middle','gsa_last','gsa_suffix','gsa_city','gsa_state','gsa_zip','date','agency','confidence','clean_gsa_first','clean_gsa_middle','clean_gsa_last','clean_gsa_suffix','clean_gsa_city','clean_gsa_state','clean_gsa_zip','clean_gsa_action_date','clean_gsa_date','fax','phone','certification_code','certification_description','board_code','board_description','expiration_year','issue_year','renewal_year','lifetime_flag','covered_recipient_id','cov_rcp_raw_state_code','cov_rcp_raw_full_name','cov_rcp_raw_attribute1','cov_rcp_raw_attribute2','cov_rcp_raw_attribute3','cov_rcp_raw_attribute4','hms_scid','school_name','grad_year','lang_code','language','specialty_description','clean_phone','bdid','bdid_score','did','did_score','clean_dob','best_dob','best_ssn','rec_deactivated_date','superceeding_piid','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'hms_piid' => 1,'first' => 2,'middle' => 3,'last' => 4,'suffix' => 5,'cred' => 6,'practitioner_type' => 7,'active' => 8,'vendible' => 9,'npi_num' => 10,'npi_enumeration_date' => 11,'npi_deactivation_date' => 12,'npi_reactivation_date' => 13,'npi_taxonomy_code' => 14,'upin' => 15,'medicare_participation_flag' => 16,'date_born' => 17,'date_died' => 18,'pid' => 19,'src' => 20,'date_vendor_first_reported' => 21,'date_vendor_last_reported' => 22,'date_first_seen' => 23,'date_last_seen' => 24,'record_type' => 25,'source_rid' => 26,'lnpid' => 27,'fname' => 28,'mname' => 29,'lname' => 30,'name_suffix' => 31,'nametype' => 32,'nid' => 33,'clean_npi_enumeration_date' => 34,'clean_npi_deactivation_date' => 35,'clean_npi_reactivation_date' => 36,'clean_date_born' => 37,'clean_date_died' => 38,'clean_company_name' => 39,'prim_range' => 40,'predir' => 41,'prim_name' => 42,'addr_suffix' => 43,'postdir' => 44,'unit_desig' => 45,'sec_range' => 46,'p_city_name' => 47,'v_city_name' => 48,'st' => 49,'zip' => 50,'zip4' => 51,'cart' => 52,'cr_sort_sz' => 53,'lot' => 54,'lot_order' => 55,'dbpc' => 56,'chk_digit' => 57,'rec_type' => 58,'fips_st' => 59,'fips_county' => 60,'geo_lat' => 61,'geo_long' => 62,'msa' => 63,'geo_blk' => 64,'geo_match' => 65,'err_stat' => 66,'rawaid' => 67,'aceaid' => 68,'firm_name' => 69,'lid' => 70,'agid' => 71,'address_std_code' => 72,'latitude' => 73,'longitude' => 74,'prepped_addr1' => 75,'prepped_addr2' => 76,'addr_type' => 77,'state_license_state' => 78,'state_license_number' => 79,'state_license_type' => 80,'state_license_active' => 81,'state_license_expire' => 82,'state_license_qualifier' => 83,'state_license_sub_qualifier' => 84,'state_license_issued' => 85,'clean_state_license_expire' => 86,'clean_state_license_issued' => 87,'dea_num' => 88,'dea_bac' => 89,'dea_sub_bac' => 90,'dea_schedule' => 91,'dea_expire' => 92,'dea_active' => 93,'clean_dea_expire' => 94,'csr_number' => 95,'csr_state' => 96,'csr_expire_date' => 97,'csr_issue_date' => 98,'dsa_lvl_2' => 99,'dsa_lvl_2n' => 100,'dsa_lvl_3' => 101,'dsa_lvl_3n' => 102,'dsa_lvl_4' => 103,'dsa_lvl_5' => 104,'csr_raw1' => 105,'csr_raw2' => 106,'csr_raw3' => 107,'csr_raw4' => 108,'clean_csr_expire_date' => 109,'clean_csr_issue_date' => 110,'sanction_id' => 111,'sanction_action_code' => 112,'sanction_action_description' => 113,'sanction_board_code' => 114,'sanction_board_description' => 115,'action_date' => 116,'sanction_period_start_date' => 117,'sanction_period_end_date' => 118,'month_duration' => 119,'fine_amount' => 120,'offense_code' => 121,'offense_description' => 122,'offense_date' => 123,'clean_offense_date' => 124,'clean_action_date' => 125,'clean_sanction_period_start_date' => 126,'clean_sanction_period_end_date' => 127,'gsa_sanction_id' => 128,'gsa_first' => 129,'gsa_middle' => 130,'gsa_last' => 131,'gsa_suffix' => 132,'gsa_city' => 133,'gsa_state' => 134,'gsa_zip' => 135,'date' => 136,'agency' => 137,'confidence' => 138,'clean_gsa_first' => 139,'clean_gsa_middle' => 140,'clean_gsa_last' => 141,'clean_gsa_suffix' => 142,'clean_gsa_city' => 143,'clean_gsa_state' => 144,'clean_gsa_zip' => 145,'clean_gsa_action_date' => 146,'clean_gsa_date' => 147,'fax' => 148,'phone' => 149,'certification_code' => 150,'certification_description' => 151,'board_code' => 152,'board_description' => 153,'expiration_year' => 154,'issue_year' => 155,'renewal_year' => 156,'lifetime_flag' => 157,'covered_recipient_id' => 158,'cov_rcp_raw_state_code' => 159,'cov_rcp_raw_full_name' => 160,'cov_rcp_raw_attribute1' => 161,'cov_rcp_raw_attribute2' => 162,'cov_rcp_raw_attribute3' => 163,'cov_rcp_raw_attribute4' => 164,'hms_scid' => 165,'school_name' => 166,'grad_year' => 167,'lang_code' => 168,'language' => 169,'specialty_description' => 170,'clean_phone' => 171,'bdid' => 172,'bdid_score' => 173,'did' => 174,'did_score' => 175,'clean_dob' => 176,'best_dob' => 177,'best_ssn' => 178,'rec_deactivated_date' => 179,'superceeding_piid' => 180,'dotid' => 181,'dotscore' => 182,'dotweight' => 183,'empid' => 184,'empscore' => 185,'empweight' => 186,'powid' => 187,'powscore' => 188,'powweight' => 189,'proxid' => 190,'proxscore' => 191,'proxweight' => 192,'seleid' => 193,'selescore' => 194,'seleweight' => 195,'orgid' => 196,'orgscore' => 197,'orgweight' => 198,'ultid' => 199,'ultscore' => 200,'ultweight' => 201,0);
EXPORT MakeFT_hms_piid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_hms_piid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_hms_piid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_first(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_first(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_first(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_middle(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_middle(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_middle(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_last(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -_ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_last(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -_ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_last(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -_ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_suffix(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'DIMJRSV '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_suffix(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'DIMJRSV '))));
EXPORT InValidMessageFT_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('DIMJRSV '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_cred(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cred(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_cred(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_practitioner_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -ABCDEHMNOPRSTVacdeghilmnoprstuvy '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_practitioner_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -ABCDEHMNOPRSTVacdeghilmnoprstuvy '))));
EXPORT InValidMessageFT_practitioner_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -ABCDEHMNOPRSTVacdeghilmnoprstuvy '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_active(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_active(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'NY '))));
EXPORT InValidMessageFT_active(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('NY '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_vendible(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_vendible(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'NY '))));
EXPORT InValidMessageFT_vendible(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('NY '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_npi_num(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_npi_num(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_npi_num(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_npi_enumeration_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_npi_enumeration_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-0123456789 '))));
EXPORT InValidMessageFT_npi_enumeration_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_npi_deactivation_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_npi_deactivation_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-0123456789 '))));
EXPORT InValidMessageFT_npi_deactivation_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_npi_reactivation_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_npi_reactivation_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-0123456789 '))));
EXPORT InValidMessageFT_npi_reactivation_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_npi_taxonomy_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_npi_taxonomy_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_npi_taxonomy_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_upin(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_upin(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_upin(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_medicare_participation_flag(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_medicare_participation_flag(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'NY '))));
EXPORT InValidMessageFT_medicare_participation_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('NY '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_date_born(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_date_born(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-0123456789 '))));
EXPORT InValidMessageFT_date_born(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_date_died(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_date_died(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-0123456789 '))));
EXPORT InValidMessageFT_date_died(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_pid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_pid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_pid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_src(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'S8 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_src(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'S8 '))));
EXPORT InValidMessageFT_src(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('S8 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_date_vendor_first_reported(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_date_vendor_first_reported(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_date_vendor_first_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_date_vendor_last_reported(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_date_vendor_last_reported(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_date_vendor_last_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_date_first_seen(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_date_first_seen(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))));
EXPORT InValidMessageFT_date_first_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_date_last_seen(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_date_last_seen(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))));
EXPORT InValidMessageFT_date_last_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_record_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'CH '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_record_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'CH '))));
EXPORT InValidMessageFT_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('CH '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_source_rid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_source_rid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_source_rid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lnpid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lnpid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_lnpid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_fname(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fname(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_mname(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_mname(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_mname(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lname(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lname(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_name_suffix(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'IJRSVX '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_name_suffix(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'IJRSVX '))));
EXPORT InValidMessageFT_name_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('IJRSVX '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_nametype(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'BIPU '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_nametype(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'BIPU '))));
EXPORT InValidMessageFT_nametype(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('BIPU '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_nid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_nid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_nid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_npi_enumeration_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_npi_enumeration_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_clean_npi_enumeration_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_npi_deactivation_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_npi_deactivation_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_clean_npi_deactivation_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_npi_reactivation_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_npi_reactivation_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_clean_npi_reactivation_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_date_born(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_date_born(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_clean_date_born(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_date_died(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_date_died(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_clean_date_died(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_company_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' &!"#$+<>?@[]_`{}~0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_company_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' &!"#$+<>?@[]_`{}~0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_clean_company_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' &!"#$+<>?@[]_`{}~0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prim_range(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prim_range(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_predir(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_predir(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prim_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prim_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_addr_suffix(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_addr_suffix(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_addr_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_postdir(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_postdir(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_unit_desig(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_unit_desig(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_sec_range(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_sec_range(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_p_city_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_p_city_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_p_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_v_city_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_v_city_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_v_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_st(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_st(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_st(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_zip(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_zip(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_zip4(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_zip4(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_cart(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cart(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_cr_sort_sz(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cr_sort_sz(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lot(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lot(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lot_order(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lot_order(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dbpc(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dbpc(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_dbpc(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_chk_digit(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_chk_digit(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_rec_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_rec_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_fips_st(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fips_st(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_fips_st(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_fips_county(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fips_county(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_fips_county(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_geo_lat(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_lat(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_geo_lat(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_geo_long(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_long(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_geo_long(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_msa(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_msa(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_msa(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_geo_blk(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_blk(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_geo_blk(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_geo_match(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_match(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_err_stat(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_err_stat(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_rawaid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_rawaid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))));
EXPORT InValidMessageFT_rawaid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_aceaid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_aceaid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))));
EXPORT InValidMessageFT_aceaid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_firm_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -./`&,!"#$%\'()+:;<=>?@[\\]_`-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_firm_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -./`&,!"#$%\'()+:;<=>?@[\\]_`-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))));
EXPORT InValidMessageFT_firm_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -./`&,!"#$%\'()+:;<=>?@[\\]_`-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_lid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_agid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_agid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_agid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_address_std_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ENS '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_address_std_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ENS '))));
EXPORT InValidMessageFT_address_std_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ENS '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_latitude(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'.-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_latitude(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'.-0123456789 '))));
EXPORT InValidMessageFT_latitude(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('.-0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_longitude(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-.0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_longitude(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-.0123456789 '))));
EXPORT InValidMessageFT_longitude(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-.0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prepped_addr1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' #-":;@[]_\'`{}0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prepped_addr1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' #-":;@[]_\'`{}0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_prepped_addr1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' #-":;@[]_\'`{}0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prepped_addr2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,-/:;@[]_\'`{}0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prepped_addr2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,-/:;@[]_\'`{}0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_prepped_addr2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,-/:;@[]_\'`{}0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_addr_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABEHIKLMNOSU '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_addr_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABEHIKLMNOSU '))));
EXPORT InValidMessageFT_addr_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABEHIKLMNOSU '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_state_license_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_state_license_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_state_license_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_state_license_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_state_license_number(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_state_license_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_state_license_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_state_license_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_state_license_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_state_license_active(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'AIPUi '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_state_license_active(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'AIPUi '))));
EXPORT InValidMessageFT_state_license_active(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('AIPUi '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_state_license_expire(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_state_license_expire(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-0123456789 '))));
EXPORT InValidMessageFT_state_license_expire(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_state_license_qualifier(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZn '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_state_license_qualifier(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZn '))));
EXPORT InValidMessageFT_state_license_qualifier(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZn '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_state_license_sub_qualifier(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_state_license_sub_qualifier(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_state_license_sub_qualifier(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_state_license_issued(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_state_license_issued(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-0123456789 '))));
EXPORT InValidMessageFT_state_license_issued(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_state_license_expire(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_state_license_expire(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_clean_state_license_expire(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_state_license_issued(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_state_license_issued(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_clean_state_license_issued(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dea_num(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dea_num(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_dea_num(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dea_bac(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'BCGM '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dea_bac(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'BCGM '))));
EXPORT InValidMessageFT_dea_bac(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('BCGM '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dea_sub_bac(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCD '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dea_sub_bac(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCD '))));
EXPORT InValidMessageFT_dea_sub_bac(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCD '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dea_schedule(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' 2345N '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dea_schedule(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' 2345N '))));
EXPORT InValidMessageFT_dea_schedule(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' 2345N '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dea_expire(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dea_expire(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_dea_expire(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dea_active(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'01 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dea_active(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'01 '))));
EXPORT InValidMessageFT_dea_active(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('01 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_dea_expire(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_dea_expire(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_clean_dea_expire(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_csr_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_csr_number(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_csr_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_csr_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_csr_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_csr_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_csr_expire_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_csr_expire_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-0123456789 '))));
EXPORT InValidMessageFT_csr_expire_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_csr_issue_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_csr_issue_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-0123456789 '))));
EXPORT InValidMessageFT_csr_issue_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dsa_lvl_2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'2Y '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dsa_lvl_2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'2Y '))));
EXPORT InValidMessageFT_dsa_lvl_2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('2Y '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dsa_lvl_2n(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'2N '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dsa_lvl_2n(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'2N '))));
EXPORT InValidMessageFT_dsa_lvl_2n(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('2N '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dsa_lvl_3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'3Y '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dsa_lvl_3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'3Y '))));
EXPORT InValidMessageFT_dsa_lvl_3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('3Y '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dsa_lvl_3n(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'3N '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dsa_lvl_3n(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'3N '))));
EXPORT InValidMessageFT_dsa_lvl_3n(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('3N '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dsa_lvl_4(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'4Y '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dsa_lvl_4(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'4Y '))));
EXPORT InValidMessageFT_dsa_lvl_4(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('4Y '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dsa_lvl_5(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'5Y '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dsa_lvl_5(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'5Y '))));
EXPORT InValidMessageFT_dsa_lvl_5(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('5Y '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_csr_raw1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_csr_raw1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_csr_raw1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_csr_raw2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_csr_raw2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_csr_raw2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_csr_raw3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_csr_raw3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_csr_raw3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_csr_raw4(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_csr_raw4(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_csr_raw4(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_csr_expire_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_csr_expire_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_clean_csr_expire_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_csr_issue_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_csr_issue_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_clean_csr_issue_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_sanction_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789abcdef '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_sanction_id(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789abcdef '))));
EXPORT InValidMessageFT_sanction_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789abcdef '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_sanction_action_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCDETU '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_sanction_action_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCDETU '))));
EXPORT InValidMessageFT_sanction_action_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCDETU '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_sanction_action_description(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_sanction_action_description(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '))));
EXPORT InValidMessageFT_sanction_action_description(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_sanction_board_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789BCDNS '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_sanction_board_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789BCDNS '))));
EXPORT InValidMessageFT_sanction_board_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789BCDNS '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_sanction_board_description(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' &,()/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_sanction_board_description(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' &,()/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '))));
EXPORT InValidMessageFT_sanction_board_description(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' &,()/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_action_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'/0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_action_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'/0123456789 '))));
EXPORT InValidMessageFT_action_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('/0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_sanction_period_start_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_sanction_period_start_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-0123456789 '))));
EXPORT InValidMessageFT_sanction_period_start_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_sanction_period_end_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_sanction_period_end_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-0123456789 '))));
EXPORT InValidMessageFT_sanction_period_end_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_month_duration(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_month_duration(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-0123456789 '))));
EXPORT InValidMessageFT_month_duration(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_fine_amount(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'.0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fine_amount(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'.0123456789 '))));
EXPORT InValidMessageFT_fine_amount(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('.0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_offense_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'012345689ABCEDFGHJKLOU '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_offense_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'012345689ABCEDFGHJKLOU '))));
EXPORT InValidMessageFT_offense_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('012345689ABCEDFGHJKLOU '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_offense_description(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_offense_description(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '))));
EXPORT InValidMessageFT_offense_description(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_offense_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_offense_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_offense_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_offense_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_offense_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_clean_offense_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_action_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_action_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_clean_action_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_sanction_period_start_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_sanction_period_start_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_clean_sanction_period_start_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_sanction_period_end_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_sanction_period_end_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_clean_sanction_period_end_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_gsa_sanction_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_gsa_sanction_id(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_gsa_sanction_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_gsa_first(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' \'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_gsa_first(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' \'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_gsa_first(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' \'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_gsa_middle(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' .-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_gsa_middle(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' .-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_gsa_middle(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' .-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_gsa_last(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_gsa_last(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_gsa_last(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_gsa_suffix(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'.4DHIJMNRSTV '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_gsa_suffix(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'.4DHIJMNRSTV '))));
EXPORT InValidMessageFT_gsa_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('.4DHIJMNRSTV '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_gsa_city(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,-/\'.01234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_gsa_city(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,-/\'.01234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_gsa_city(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,-/\'.01234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_gsa_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_gsa_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_gsa_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_gsa_zip(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_gsa_zip(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-0123456789 '))));
EXPORT InValidMessageFT_gsa_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'/0123456789DEFINT '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'/0123456789DEFINT '))));
EXPORT InValidMessageFT_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('/0123456789DEFINT '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_agency(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-/ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_agency(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-/ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_agency(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-/ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_confidence(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'45 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_confidence(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'45 '))));
EXPORT InValidMessageFT_confidence(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('45 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_gsa_first(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' \'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_gsa_first(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' \'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_clean_gsa_first(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' \'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_gsa_middle(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' .\'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_gsa_middle(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' .\'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_clean_gsa_middle(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' .\'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_gsa_last(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_gsa_last(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_clean_gsa_last(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_gsa_suffix(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'.4DHIJMNRSTV '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_gsa_suffix(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'.4DHIJMNRSTV '))));
EXPORT InValidMessageFT_clean_gsa_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('.4DHIJMNRSTV '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_gsa_city(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,-./ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_gsa_city(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,-./ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_clean_gsa_city(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,-./ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_gsa_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_gsa_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_clean_gsa_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_gsa_zip(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_gsa_zip(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-0123456789 '))));
EXPORT InValidMessageFT_clean_gsa_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_gsa_action_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_gsa_action_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_clean_gsa_action_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_gsa_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'/0123456789DEFINT '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_gsa_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'/0123456789DEFINT '))));
EXPORT InValidMessageFT_clean_gsa_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('/0123456789DEFINT '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_fax(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fax(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_fax(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phone(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phone(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_certification_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789CN '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_certification_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789CN '))));
EXPORT InValidMessageFT_certification_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789CN '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_certification_description(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' &-ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_certification_description(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' &-ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '))));
EXPORT InValidMessageFT_certification_description(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' &-ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_board_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCDEFGHIJKMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_board_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCDEFGHIJKMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_board_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_board_description(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' &ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_board_description(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' &ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '))));
EXPORT InValidMessageFT_board_description(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' &ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_expiration_year(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_expiration_year(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_expiration_year(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_issue_year(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_issue_year(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_issue_year(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_renewal_year(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_renewal_year(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_renewal_year(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lifetime_flag(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'01 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lifetime_flag(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'01 '))));
EXPORT InValidMessageFT_lifetime_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('01 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_covered_recipient_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_covered_recipient_id(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_covered_recipient_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_cov_rcp_raw_state_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'AM '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cov_rcp_raw_state_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'AM '))));
EXPORT InValidMessageFT_cov_rcp_raw_state_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('AM '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_cov_rcp_raw_full_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -.ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cov_rcp_raw_full_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -.ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))));
EXPORT InValidMessageFT_cov_rcp_raw_full_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -.ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_cov_rcp_raw_attribute1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ()-/ACDGHIOLMNPRSTabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cov_rcp_raw_attribute1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()-/ACDGHIOLMNPRSTabcdefghijklmnopqrstuvwxyz '))));
EXPORT InValidMessageFT_cov_rcp_raw_attribute1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()-/ACDGHIOLMNPRSTabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_cov_rcp_raw_attribute2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ACDGHILNPRT '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cov_rcp_raw_attribute2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ACDGHILNPRT '))));
EXPORT InValidMessageFT_cov_rcp_raw_attribute2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ACDGHILNPRT '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_cov_rcp_raw_attribute3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cov_rcp_raw_attribute3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_cov_rcp_raw_attribute3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_cov_rcp_raw_attribute4(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cov_rcp_raw_attribute4(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_cov_rcp_raw_attribute4(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_hms_scid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_hms_scid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_hms_scid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_school_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ./"&\'()-`ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_school_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ./"&\'()-`ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))));
EXPORT InValidMessageFT_school_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ./"&\'()-`ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_grad_year(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_grad_year(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_grad_year(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lang_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lang_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_lang_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_language(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_language(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))));
EXPORT InValidMessageFT_language(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_specialty_description(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' &,-/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_specialty_description(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' &,-/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '))));
EXPORT InValidMessageFT_specialty_description(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' &,-/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_phone(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_phone(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_clean_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_bdid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_bdid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_bdid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_bdid_score(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_bdid_score(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))));
EXPORT InValidMessageFT_bdid_score(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_did(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_did(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_did(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_did_score(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_did_score(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_did_score(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_dob(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_dob(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_clean_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_best_dob(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_best_dob(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_best_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_best_ssn(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_best_ssn(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_best_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_rec_deactivated_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_rec_deactivated_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_rec_deactivated_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_superceeding_piid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_superceeding_piid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_superceeding_piid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dotid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dotid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))));
EXPORT InValidMessageFT_dotid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dotscore(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dotscore(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))));
EXPORT InValidMessageFT_dotscore(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dotweight(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dotweight(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))));
EXPORT InValidMessageFT_dotweight(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_empid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_empid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))));
EXPORT InValidMessageFT_empid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_empscore(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_empscore(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))));
EXPORT InValidMessageFT_empscore(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_empweight(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_empweight(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))));
EXPORT InValidMessageFT_empweight(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_powid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_powid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_powid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_powscore(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_powscore(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_powscore(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_powweight(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_powweight(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_powweight(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_proxid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_proxid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_proxid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_proxscore(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_proxscore(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_proxscore(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_proxweight(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_proxweight(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_proxweight(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_seleid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_seleid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_seleid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_selescore(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_selescore(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_selescore(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_seleweight(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_seleweight(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_seleweight(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_orgid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orgid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_orgid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_orgscore(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orgscore(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_orgscore(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_orgweight(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orgweight(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_orgweight(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_ultid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ultid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_ultid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_ultscore(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ultscore(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_ultscore(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_ultweight(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ultweight(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_ultweight(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'hms_piid','first','middle','last','suffix','cred','practitioner_type','active','vendible','npi_num','npi_enumeration_date','npi_deactivation_date','npi_reactivation_date','npi_taxonomy_code','upin','medicare_participation_flag','date_born','date_died','pid','src','date_vendor_first_reported','date_vendor_last_reported','date_first_seen','date_last_seen','record_type','source_rid','lnpid','fname','mname','lname','name_suffix','nametype','nid','clean_npi_enumeration_date','clean_npi_deactivation_date','clean_npi_reactivation_date','clean_date_born','clean_date_died','clean_company_name','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','firm_name','lid','agid','address_std_code','latitude','longitude','prepped_addr1','prepped_addr2','addr_type','state_license_state','state_license_number','state_license_type','state_license_active','state_license_expire','state_license_qualifier','state_license_sub_qualifier','state_license_issued','clean_state_license_expire','clean_state_license_issued','dea_num','dea_bac','dea_sub_bac','dea_schedule','dea_expire','dea_active','clean_dea_expire','csr_number','csr_state','csr_expire_date','csr_issue_date','dsa_lvl_2','dsa_lvl_2n','dsa_lvl_3','dsa_lvl_3n','dsa_lvl_4','dsa_lvl_5','csr_raw1','csr_raw2','csr_raw3','csr_raw4','clean_csr_expire_date','clean_csr_issue_date','sanction_id','sanction_action_code','sanction_action_description','sanction_board_code','sanction_board_description','action_date','sanction_period_start_date','sanction_period_end_date','month_duration','fine_amount','offense_code','offense_description','offense_date','clean_offense_date','clean_action_date','clean_sanction_period_start_date','clean_sanction_period_end_date','gsa_sanction_id','gsa_first','gsa_middle','gsa_last','gsa_suffix','gsa_city','gsa_state','gsa_zip','date','agency','confidence','clean_gsa_first','clean_gsa_middle','clean_gsa_last','clean_gsa_suffix','clean_gsa_city','clean_gsa_state','clean_gsa_zip','clean_gsa_action_date','clean_gsa_date','fax','phone','certification_code','certification_description','board_code','board_description','expiration_year','issue_year','renewal_year','lifetime_flag','covered_recipient_id','cov_rcp_raw_state_code','cov_rcp_raw_full_name','cov_rcp_raw_attribute1','cov_rcp_raw_attribute2','cov_rcp_raw_attribute3','cov_rcp_raw_attribute4','hms_scid','school_name','grad_year','lang_code','language','specialty_description','clean_phone','bdid','bdid_score','did','did_score','clean_dob','best_dob','best_ssn','rec_deactivated_date','superceeding_piid','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'hms_piid' => 1,'first' => 2,'middle' => 3,'last' => 4,'suffix' => 5,'cred' => 6,'practitioner_type' => 7,'active' => 8,'vendible' => 9,'npi_num' => 10,'npi_enumeration_date' => 11,'npi_deactivation_date' => 12,'npi_reactivation_date' => 13,'npi_taxonomy_code' => 14,'upin' => 15,'medicare_participation_flag' => 16,'date_born' => 17,'date_died' => 18,'pid' => 19,'src' => 20,'date_vendor_first_reported' => 21,'date_vendor_last_reported' => 22,'date_first_seen' => 23,'date_last_seen' => 24,'record_type' => 25,'source_rid' => 26,'lnpid' => 27,'fname' => 28,'mname' => 29,'lname' => 30,'name_suffix' => 31,'nametype' => 32,'nid' => 33,'clean_npi_enumeration_date' => 34,'clean_npi_deactivation_date' => 35,'clean_npi_reactivation_date' => 36,'clean_date_born' => 37,'clean_date_died' => 38,'clean_company_name' => 39,'prim_range' => 40,'predir' => 41,'prim_name' => 42,'addr_suffix' => 43,'postdir' => 44,'unit_desig' => 45,'sec_range' => 46,'p_city_name' => 47,'v_city_name' => 48,'st' => 49,'zip' => 50,'zip4' => 51,'cart' => 52,'cr_sort_sz' => 53,'lot' => 54,'lot_order' => 55,'dbpc' => 56,'chk_digit' => 57,'rec_type' => 58,'fips_st' => 59,'fips_county' => 60,'geo_lat' => 61,'geo_long' => 62,'msa' => 63,'geo_blk' => 64,'geo_match' => 65,'err_stat' => 66,'rawaid' => 67,'aceaid' => 68,'firm_name' => 69,'lid' => 70,'agid' => 71,'address_std_code' => 72,'latitude' => 73,'longitude' => 74,'prepped_addr1' => 75,'prepped_addr2' => 76,'addr_type' => 77,'state_license_state' => 78,'state_license_number' => 79,'state_license_type' => 80,'state_license_active' => 81,'state_license_expire' => 82,'state_license_qualifier' => 83,'state_license_sub_qualifier' => 84,'state_license_issued' => 85,'clean_state_license_expire' => 86,'clean_state_license_issued' => 87,'dea_num' => 88,'dea_bac' => 89,'dea_sub_bac' => 90,'dea_schedule' => 91,'dea_expire' => 92,'dea_active' => 93,'clean_dea_expire' => 94,'csr_number' => 95,'csr_state' => 96,'csr_expire_date' => 97,'csr_issue_date' => 98,'dsa_lvl_2' => 99,'dsa_lvl_2n' => 100,'dsa_lvl_3' => 101,'dsa_lvl_3n' => 102,'dsa_lvl_4' => 103,'dsa_lvl_5' => 104,'csr_raw1' => 105,'csr_raw2' => 106,'csr_raw3' => 107,'csr_raw4' => 108,'clean_csr_expire_date' => 109,'clean_csr_issue_date' => 110,'sanction_id' => 111,'sanction_action_code' => 112,'sanction_action_description' => 113,'sanction_board_code' => 114,'sanction_board_description' => 115,'action_date' => 116,'sanction_period_start_date' => 117,'sanction_period_end_date' => 118,'month_duration' => 119,'fine_amount' => 120,'offense_code' => 121,'offense_description' => 122,'offense_date' => 123,'clean_offense_date' => 124,'clean_action_date' => 125,'clean_sanction_period_start_date' => 126,'clean_sanction_period_end_date' => 127,'gsa_sanction_id' => 128,'gsa_first' => 129,'gsa_middle' => 130,'gsa_last' => 131,'gsa_suffix' => 132,'gsa_city' => 133,'gsa_state' => 134,'gsa_zip' => 135,'date' => 136,'agency' => 137,'confidence' => 138,'clean_gsa_first' => 139,'clean_gsa_middle' => 140,'clean_gsa_last' => 141,'clean_gsa_suffix' => 142,'clean_gsa_city' => 143,'clean_gsa_state' => 144,'clean_gsa_zip' => 145,'clean_gsa_action_date' => 146,'clean_gsa_date' => 147,'fax' => 148,'phone' => 149,'certification_code' => 150,'certification_description' => 151,'board_code' => 152,'board_description' => 153,'expiration_year' => 154,'issue_year' => 155,'renewal_year' => 156,'lifetime_flag' => 157,'covered_recipient_id' => 158,'cov_rcp_raw_state_code' => 159,'cov_rcp_raw_full_name' => 160,'cov_rcp_raw_attribute1' => 161,'cov_rcp_raw_attribute2' => 162,'cov_rcp_raw_attribute3' => 163,'cov_rcp_raw_attribute4' => 164,'hms_scid' => 165,'school_name' => 166,'grad_year' => 167,'lang_code' => 168,'language' => 169,'specialty_description' => 170,'clean_phone' => 171,'bdid' => 172,'bdid_score' => 173,'did' => 174,'did_score' => 175,'clean_dob' => 176,'best_dob' => 177,'best_ssn' => 178,'rec_deactivated_date' => 179,'superceeding_piid' => 180,'dotid' => 181,'dotscore' => 182,'dotweight' => 183,'empid' => 184,'empscore' => 185,'empweight' => 186,'powid' => 187,'powscore' => 188,'powweight' => 189,'proxid' => 190,'proxscore' => 191,'proxweight' => 192,'seleid' => 193,'selescore' => 194,'seleweight' => 195,'orgid' => 196,'orgscore' => 197,'orgweight' => 198,'ultid' => 199,'ultscore' => 200,'ultweight' => 201,0);
//Individual field level validation
EXPORT Make_hms_piid(SALT31.StrType s0) := MakeFT_hms_piid(s0);
EXPORT InValid_hms_piid(SALT31.StrType s) := InValidFT_hms_piid(s);
EXPORT InValidMessage_hms_piid(UNSIGNED1 wh) := InValidMessageFT_hms_piid(wh);
EXPORT Make_first(SALT31.StrType s0) := MakeFT_first(s0);
EXPORT InValid_first(SALT31.StrType s) := InValidFT_first(s);
EXPORT InValidMessage_first(UNSIGNED1 wh) := InValidMessageFT_first(wh);
EXPORT Make_middle(SALT31.StrType s0) := MakeFT_middle(s0);
EXPORT InValid_middle(SALT31.StrType s) := InValidFT_middle(s);
EXPORT InValidMessage_middle(UNSIGNED1 wh) := InValidMessageFT_middle(wh);
EXPORT Make_last(SALT31.StrType s0) := MakeFT_last(s0);
EXPORT InValid_last(SALT31.StrType s) := InValidFT_last(s);
EXPORT InValidMessage_last(UNSIGNED1 wh) := InValidMessageFT_last(wh);
EXPORT Make_suffix(SALT31.StrType s0) := MakeFT_suffix(s0);
EXPORT InValid_suffix(SALT31.StrType s) := InValidFT_suffix(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_suffix(wh);
EXPORT Make_cred(SALT31.StrType s0) := MakeFT_cred(s0);
EXPORT InValid_cred(SALT31.StrType s) := InValidFT_cred(s);
EXPORT InValidMessage_cred(UNSIGNED1 wh) := InValidMessageFT_cred(wh);
EXPORT Make_practitioner_type(SALT31.StrType s0) := MakeFT_practitioner_type(s0);
EXPORT InValid_practitioner_type(SALT31.StrType s) := InValidFT_practitioner_type(s);
EXPORT InValidMessage_practitioner_type(UNSIGNED1 wh) := InValidMessageFT_practitioner_type(wh);
EXPORT Make_active(SALT31.StrType s0) := MakeFT_active(s0);
EXPORT InValid_active(SALT31.StrType s) := InValidFT_active(s);
EXPORT InValidMessage_active(UNSIGNED1 wh) := InValidMessageFT_active(wh);
EXPORT Make_vendible(SALT31.StrType s0) := MakeFT_vendible(s0);
EXPORT InValid_vendible(SALT31.StrType s) := InValidFT_vendible(s);
EXPORT InValidMessage_vendible(UNSIGNED1 wh) := InValidMessageFT_vendible(wh);
EXPORT Make_npi_num(SALT31.StrType s0) := MakeFT_npi_num(s0);
EXPORT InValid_npi_num(SALT31.StrType s) := InValidFT_npi_num(s);
EXPORT InValidMessage_npi_num(UNSIGNED1 wh) := InValidMessageFT_npi_num(wh);
EXPORT Make_npi_enumeration_date(SALT31.StrType s0) := MakeFT_npi_enumeration_date(s0);
EXPORT InValid_npi_enumeration_date(SALT31.StrType s) := InValidFT_npi_enumeration_date(s);
EXPORT InValidMessage_npi_enumeration_date(UNSIGNED1 wh) := InValidMessageFT_npi_enumeration_date(wh);
EXPORT Make_npi_deactivation_date(SALT31.StrType s0) := MakeFT_npi_deactivation_date(s0);
EXPORT InValid_npi_deactivation_date(SALT31.StrType s) := InValidFT_npi_deactivation_date(s);
EXPORT InValidMessage_npi_deactivation_date(UNSIGNED1 wh) := InValidMessageFT_npi_deactivation_date(wh);
EXPORT Make_npi_reactivation_date(SALT31.StrType s0) := MakeFT_npi_reactivation_date(s0);
EXPORT InValid_npi_reactivation_date(SALT31.StrType s) := InValidFT_npi_reactivation_date(s);
EXPORT InValidMessage_npi_reactivation_date(UNSIGNED1 wh) := InValidMessageFT_npi_reactivation_date(wh);
EXPORT Make_npi_taxonomy_code(SALT31.StrType s0) := MakeFT_npi_taxonomy_code(s0);
EXPORT InValid_npi_taxonomy_code(SALT31.StrType s) := InValidFT_npi_taxonomy_code(s);
EXPORT InValidMessage_npi_taxonomy_code(UNSIGNED1 wh) := InValidMessageFT_npi_taxonomy_code(wh);
EXPORT Make_upin(SALT31.StrType s0) := MakeFT_upin(s0);
EXPORT InValid_upin(SALT31.StrType s) := InValidFT_upin(s);
EXPORT InValidMessage_upin(UNSIGNED1 wh) := InValidMessageFT_upin(wh);
EXPORT Make_medicare_participation_flag(SALT31.StrType s0) := MakeFT_medicare_participation_flag(s0);
EXPORT InValid_medicare_participation_flag(SALT31.StrType s) := InValidFT_medicare_participation_flag(s);
EXPORT InValidMessage_medicare_participation_flag(UNSIGNED1 wh) := InValidMessageFT_medicare_participation_flag(wh);
EXPORT Make_date_born(SALT31.StrType s0) := MakeFT_date_born(s0);
EXPORT InValid_date_born(SALT31.StrType s) := InValidFT_date_born(s);
EXPORT InValidMessage_date_born(UNSIGNED1 wh) := InValidMessageFT_date_born(wh);
EXPORT Make_date_died(SALT31.StrType s0) := MakeFT_date_died(s0);
EXPORT InValid_date_died(SALT31.StrType s) := InValidFT_date_died(s);
EXPORT InValidMessage_date_died(UNSIGNED1 wh) := InValidMessageFT_date_died(wh);
EXPORT Make_pid(SALT31.StrType s0) := MakeFT_pid(s0);
EXPORT InValid_pid(SALT31.StrType s) := InValidFT_pid(s);
EXPORT InValidMessage_pid(UNSIGNED1 wh) := InValidMessageFT_pid(wh);
EXPORT Make_src(SALT31.StrType s0) := MakeFT_src(s0);
EXPORT InValid_src(SALT31.StrType s) := InValidFT_src(s);
EXPORT InValidMessage_src(UNSIGNED1 wh) := InValidMessageFT_src(wh);
EXPORT Make_date_vendor_first_reported(SALT31.StrType s0) := MakeFT_date_vendor_first_reported(s0);
EXPORT InValid_date_vendor_first_reported(SALT31.StrType s) := InValidFT_date_vendor_first_reported(s);
EXPORT InValidMessage_date_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_date_vendor_first_reported(wh);
EXPORT Make_date_vendor_last_reported(SALT31.StrType s0) := MakeFT_date_vendor_last_reported(s0);
EXPORT InValid_date_vendor_last_reported(SALT31.StrType s) := InValidFT_date_vendor_last_reported(s);
EXPORT InValidMessage_date_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_date_vendor_last_reported(wh);
EXPORT Make_date_first_seen(SALT31.StrType s0) := MakeFT_date_first_seen(s0);
EXPORT InValid_date_first_seen(SALT31.StrType s) := InValidFT_date_first_seen(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_date_first_seen(wh);
EXPORT Make_date_last_seen(SALT31.StrType s0) := MakeFT_date_last_seen(s0);
EXPORT InValid_date_last_seen(SALT31.StrType s) := InValidFT_date_last_seen(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_date_last_seen(wh);
EXPORT Make_record_type(SALT31.StrType s0) := MakeFT_record_type(s0);
EXPORT InValid_record_type(SALT31.StrType s) := InValidFT_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_record_type(wh);
EXPORT Make_source_rid(SALT31.StrType s0) := MakeFT_source_rid(s0);
EXPORT InValid_source_rid(SALT31.StrType s) := InValidFT_source_rid(s);
EXPORT InValidMessage_source_rid(UNSIGNED1 wh) := InValidMessageFT_source_rid(wh);
EXPORT Make_lnpid(SALT31.StrType s0) := MakeFT_lnpid(s0);
EXPORT InValid_lnpid(SALT31.StrType s) := InValidFT_lnpid(s);
EXPORT InValidMessage_lnpid(UNSIGNED1 wh) := InValidMessageFT_lnpid(wh);
EXPORT Make_fname(SALT31.StrType s0) := MakeFT_fname(s0);
EXPORT InValid_fname(SALT31.StrType s) := InValidFT_fname(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_fname(wh);
EXPORT Make_mname(SALT31.StrType s0) := MakeFT_mname(s0);
EXPORT InValid_mname(SALT31.StrType s) := InValidFT_mname(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_mname(wh);
EXPORT Make_lname(SALT31.StrType s0) := MakeFT_lname(s0);
EXPORT InValid_lname(SALT31.StrType s) := InValidFT_lname(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_lname(wh);
EXPORT Make_name_suffix(SALT31.StrType s0) := MakeFT_name_suffix(s0);
EXPORT InValid_name_suffix(SALT31.StrType s) := InValidFT_name_suffix(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_name_suffix(wh);
EXPORT Make_nametype(SALT31.StrType s0) := MakeFT_nametype(s0);
EXPORT InValid_nametype(SALT31.StrType s) := InValidFT_nametype(s);
EXPORT InValidMessage_nametype(UNSIGNED1 wh) := InValidMessageFT_nametype(wh);
EXPORT Make_nid(SALT31.StrType s0) := MakeFT_nid(s0);
EXPORT InValid_nid(SALT31.StrType s) := InValidFT_nid(s);
EXPORT InValidMessage_nid(UNSIGNED1 wh) := InValidMessageFT_nid(wh);
EXPORT Make_clean_npi_enumeration_date(SALT31.StrType s0) := MakeFT_clean_npi_enumeration_date(s0);
EXPORT InValid_clean_npi_enumeration_date(SALT31.StrType s) := InValidFT_clean_npi_enumeration_date(s);
EXPORT InValidMessage_clean_npi_enumeration_date(UNSIGNED1 wh) := InValidMessageFT_clean_npi_enumeration_date(wh);
EXPORT Make_clean_npi_deactivation_date(SALT31.StrType s0) := MakeFT_clean_npi_deactivation_date(s0);
EXPORT InValid_clean_npi_deactivation_date(SALT31.StrType s) := InValidFT_clean_npi_deactivation_date(s);
EXPORT InValidMessage_clean_npi_deactivation_date(UNSIGNED1 wh) := InValidMessageFT_clean_npi_deactivation_date(wh);
EXPORT Make_clean_npi_reactivation_date(SALT31.StrType s0) := MakeFT_clean_npi_reactivation_date(s0);
EXPORT InValid_clean_npi_reactivation_date(SALT31.StrType s) := InValidFT_clean_npi_reactivation_date(s);
EXPORT InValidMessage_clean_npi_reactivation_date(UNSIGNED1 wh) := InValidMessageFT_clean_npi_reactivation_date(wh);
EXPORT Make_clean_date_born(SALT31.StrType s0) := MakeFT_clean_date_born(s0);
EXPORT InValid_clean_date_born(SALT31.StrType s) := InValidFT_clean_date_born(s);
EXPORT InValidMessage_clean_date_born(UNSIGNED1 wh) := InValidMessageFT_clean_date_born(wh);
EXPORT Make_clean_date_died(SALT31.StrType s0) := MakeFT_clean_date_died(s0);
EXPORT InValid_clean_date_died(SALT31.StrType s) := InValidFT_clean_date_died(s);
EXPORT InValidMessage_clean_date_died(UNSIGNED1 wh) := InValidMessageFT_clean_date_died(wh);
EXPORT Make_clean_company_name(SALT31.StrType s0) := MakeFT_clean_company_name(s0);
EXPORT InValid_clean_company_name(SALT31.StrType s) := InValidFT_clean_company_name(s);
EXPORT InValidMessage_clean_company_name(UNSIGNED1 wh) := InValidMessageFT_clean_company_name(wh);
EXPORT Make_prim_range(SALT31.StrType s0) := MakeFT_prim_range(s0);
EXPORT InValid_prim_range(SALT31.StrType s) := InValidFT_prim_range(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_prim_range(wh);
EXPORT Make_predir(SALT31.StrType s0) := MakeFT_predir(s0);
EXPORT InValid_predir(SALT31.StrType s) := InValidFT_predir(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_predir(wh);
EXPORT Make_prim_name(SALT31.StrType s0) := MakeFT_prim_name(s0);
EXPORT InValid_prim_name(SALT31.StrType s) := InValidFT_prim_name(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_prim_name(wh);
EXPORT Make_addr_suffix(SALT31.StrType s0) := MakeFT_addr_suffix(s0);
EXPORT InValid_addr_suffix(SALT31.StrType s) := InValidFT_addr_suffix(s);
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_addr_suffix(wh);
EXPORT Make_postdir(SALT31.StrType s0) := MakeFT_postdir(s0);
EXPORT InValid_postdir(SALT31.StrType s) := InValidFT_postdir(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_postdir(wh);
EXPORT Make_unit_desig(SALT31.StrType s0) := MakeFT_unit_desig(s0);
EXPORT InValid_unit_desig(SALT31.StrType s) := InValidFT_unit_desig(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_unit_desig(wh);
EXPORT Make_sec_range(SALT31.StrType s0) := MakeFT_sec_range(s0);
EXPORT InValid_sec_range(SALT31.StrType s) := InValidFT_sec_range(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_sec_range(wh);
EXPORT Make_p_city_name(SALT31.StrType s0) := MakeFT_p_city_name(s0);
EXPORT InValid_p_city_name(SALT31.StrType s) := InValidFT_p_city_name(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_p_city_name(wh);
EXPORT Make_v_city_name(SALT31.StrType s0) := MakeFT_v_city_name(s0);
EXPORT InValid_v_city_name(SALT31.StrType s) := InValidFT_v_city_name(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_v_city_name(wh);
EXPORT Make_st(SALT31.StrType s0) := MakeFT_st(s0);
EXPORT InValid_st(SALT31.StrType s) := InValidFT_st(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_st(wh);
EXPORT Make_zip(SALT31.StrType s0) := MakeFT_zip(s0);
EXPORT InValid_zip(SALT31.StrType s) := InValidFT_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_zip(wh);
EXPORT Make_zip4(SALT31.StrType s0) := MakeFT_zip4(s0);
EXPORT InValid_zip4(SALT31.StrType s) := InValidFT_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_zip4(wh);
EXPORT Make_cart(SALT31.StrType s0) := MakeFT_cart(s0);
EXPORT InValid_cart(SALT31.StrType s) := InValidFT_cart(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_cart(wh);
EXPORT Make_cr_sort_sz(SALT31.StrType s0) := MakeFT_cr_sort_sz(s0);
EXPORT InValid_cr_sort_sz(SALT31.StrType s) := InValidFT_cr_sort_sz(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_cr_sort_sz(wh);
EXPORT Make_lot(SALT31.StrType s0) := MakeFT_lot(s0);
EXPORT InValid_lot(SALT31.StrType s) := InValidFT_lot(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_lot(wh);
EXPORT Make_lot_order(SALT31.StrType s0) := MakeFT_lot_order(s0);
EXPORT InValid_lot_order(SALT31.StrType s) := InValidFT_lot_order(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_lot_order(wh);
EXPORT Make_dbpc(SALT31.StrType s0) := MakeFT_dbpc(s0);
EXPORT InValid_dbpc(SALT31.StrType s) := InValidFT_dbpc(s);
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := InValidMessageFT_dbpc(wh);
EXPORT Make_chk_digit(SALT31.StrType s0) := MakeFT_chk_digit(s0);
EXPORT InValid_chk_digit(SALT31.StrType s) := InValidFT_chk_digit(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_chk_digit(wh);
EXPORT Make_rec_type(SALT31.StrType s0) := MakeFT_rec_type(s0);
EXPORT InValid_rec_type(SALT31.StrType s) := InValidFT_rec_type(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_rec_type(wh);
EXPORT Make_fips_st(SALT31.StrType s0) := MakeFT_fips_st(s0);
EXPORT InValid_fips_st(SALT31.StrType s) := InValidFT_fips_st(s);
EXPORT InValidMessage_fips_st(UNSIGNED1 wh) := InValidMessageFT_fips_st(wh);
EXPORT Make_fips_county(SALT31.StrType s0) := MakeFT_fips_county(s0);
EXPORT InValid_fips_county(SALT31.StrType s) := InValidFT_fips_county(s);
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := InValidMessageFT_fips_county(wh);
EXPORT Make_geo_lat(SALT31.StrType s0) := MakeFT_geo_lat(s0);
EXPORT InValid_geo_lat(SALT31.StrType s) := InValidFT_geo_lat(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_geo_lat(wh);
EXPORT Make_geo_long(SALT31.StrType s0) := MakeFT_geo_long(s0);
EXPORT InValid_geo_long(SALT31.StrType s) := InValidFT_geo_long(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_geo_long(wh);
EXPORT Make_msa(SALT31.StrType s0) := MakeFT_msa(s0);
EXPORT InValid_msa(SALT31.StrType s) := InValidFT_msa(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_msa(wh);
EXPORT Make_geo_blk(SALT31.StrType s0) := MakeFT_geo_blk(s0);
EXPORT InValid_geo_blk(SALT31.StrType s) := InValidFT_geo_blk(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_geo_blk(wh);
EXPORT Make_geo_match(SALT31.StrType s0) := MakeFT_geo_match(s0);
EXPORT InValid_geo_match(SALT31.StrType s) := InValidFT_geo_match(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_geo_match(wh);
EXPORT Make_err_stat(SALT31.StrType s0) := MakeFT_err_stat(s0);
EXPORT InValid_err_stat(SALT31.StrType s) := InValidFT_err_stat(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_err_stat(wh);
EXPORT Make_rawaid(SALT31.StrType s0) := MakeFT_rawaid(s0);
EXPORT InValid_rawaid(SALT31.StrType s) := InValidFT_rawaid(s);
EXPORT InValidMessage_rawaid(UNSIGNED1 wh) := InValidMessageFT_rawaid(wh);
EXPORT Make_aceaid(SALT31.StrType s0) := MakeFT_aceaid(s0);
EXPORT InValid_aceaid(SALT31.StrType s) := InValidFT_aceaid(s);
EXPORT InValidMessage_aceaid(UNSIGNED1 wh) := InValidMessageFT_aceaid(wh);
EXPORT Make_firm_name(SALT31.StrType s0) := MakeFT_firm_name(s0);
EXPORT InValid_firm_name(SALT31.StrType s) := InValidFT_firm_name(s);
EXPORT InValidMessage_firm_name(UNSIGNED1 wh) := InValidMessageFT_firm_name(wh);
EXPORT Make_lid(SALT31.StrType s0) := MakeFT_lid(s0);
EXPORT InValid_lid(SALT31.StrType s) := InValidFT_lid(s);
EXPORT InValidMessage_lid(UNSIGNED1 wh) := InValidMessageFT_lid(wh);
EXPORT Make_agid(SALT31.StrType s0) := MakeFT_agid(s0);
EXPORT InValid_agid(SALT31.StrType s) := InValidFT_agid(s);
EXPORT InValidMessage_agid(UNSIGNED1 wh) := InValidMessageFT_agid(wh);
EXPORT Make_address_std_code(SALT31.StrType s0) := MakeFT_address_std_code(s0);
EXPORT InValid_address_std_code(SALT31.StrType s) := InValidFT_address_std_code(s);
EXPORT InValidMessage_address_std_code(UNSIGNED1 wh) := InValidMessageFT_address_std_code(wh);
EXPORT Make_latitude(SALT31.StrType s0) := MakeFT_latitude(s0);
EXPORT InValid_latitude(SALT31.StrType s) := InValidFT_latitude(s);
EXPORT InValidMessage_latitude(UNSIGNED1 wh) := InValidMessageFT_latitude(wh);
EXPORT Make_longitude(SALT31.StrType s0) := MakeFT_longitude(s0);
EXPORT InValid_longitude(SALT31.StrType s) := InValidFT_longitude(s);
EXPORT InValidMessage_longitude(UNSIGNED1 wh) := InValidMessageFT_longitude(wh);
EXPORT Make_prepped_addr1(SALT31.StrType s0) := MakeFT_prepped_addr1(s0);
EXPORT InValid_prepped_addr1(SALT31.StrType s) := InValidFT_prepped_addr1(s);
EXPORT InValidMessage_prepped_addr1(UNSIGNED1 wh) := InValidMessageFT_prepped_addr1(wh);
EXPORT Make_prepped_addr2(SALT31.StrType s0) := MakeFT_prepped_addr2(s0);
EXPORT InValid_prepped_addr2(SALT31.StrType s) := InValidFT_prepped_addr2(s);
EXPORT InValidMessage_prepped_addr2(UNSIGNED1 wh) := InValidMessageFT_prepped_addr2(wh);
EXPORT Make_addr_type(SALT31.StrType s0) := MakeFT_addr_type(s0);
EXPORT InValid_addr_type(SALT31.StrType s) := InValidFT_addr_type(s);
EXPORT InValidMessage_addr_type(UNSIGNED1 wh) := InValidMessageFT_addr_type(wh);
EXPORT Make_state_license_state(SALT31.StrType s0) := MakeFT_state_license_state(s0);
EXPORT InValid_state_license_state(SALT31.StrType s) := InValidFT_state_license_state(s);
EXPORT InValidMessage_state_license_state(UNSIGNED1 wh) := InValidMessageFT_state_license_state(wh);
EXPORT Make_state_license_number(SALT31.StrType s0) := MakeFT_state_license_number(s0);
EXPORT InValid_state_license_number(SALT31.StrType s) := InValidFT_state_license_number(s);
EXPORT InValidMessage_state_license_number(UNSIGNED1 wh) := InValidMessageFT_state_license_number(wh);
EXPORT Make_state_license_type(SALT31.StrType s0) := MakeFT_state_license_type(s0);
EXPORT InValid_state_license_type(SALT31.StrType s) := InValidFT_state_license_type(s);
EXPORT InValidMessage_state_license_type(UNSIGNED1 wh) := InValidMessageFT_state_license_type(wh);
EXPORT Make_state_license_active(SALT31.StrType s0) := MakeFT_state_license_active(s0);
EXPORT InValid_state_license_active(SALT31.StrType s) := InValidFT_state_license_active(s);
EXPORT InValidMessage_state_license_active(UNSIGNED1 wh) := InValidMessageFT_state_license_active(wh);
EXPORT Make_state_license_expire(SALT31.StrType s0) := MakeFT_state_license_expire(s0);
EXPORT InValid_state_license_expire(SALT31.StrType s) := InValidFT_state_license_expire(s);
EXPORT InValidMessage_state_license_expire(UNSIGNED1 wh) := InValidMessageFT_state_license_expire(wh);
EXPORT Make_state_license_qualifier(SALT31.StrType s0) := MakeFT_state_license_qualifier(s0);
EXPORT InValid_state_license_qualifier(SALT31.StrType s) := InValidFT_state_license_qualifier(s);
EXPORT InValidMessage_state_license_qualifier(UNSIGNED1 wh) := InValidMessageFT_state_license_qualifier(wh);
EXPORT Make_state_license_sub_qualifier(SALT31.StrType s0) := MakeFT_state_license_sub_qualifier(s0);
EXPORT InValid_state_license_sub_qualifier(SALT31.StrType s) := InValidFT_state_license_sub_qualifier(s);
EXPORT InValidMessage_state_license_sub_qualifier(UNSIGNED1 wh) := InValidMessageFT_state_license_sub_qualifier(wh);
EXPORT Make_state_license_issued(SALT31.StrType s0) := MakeFT_state_license_issued(s0);
EXPORT InValid_state_license_issued(SALT31.StrType s) := InValidFT_state_license_issued(s);
EXPORT InValidMessage_state_license_issued(UNSIGNED1 wh) := InValidMessageFT_state_license_issued(wh);
EXPORT Make_clean_state_license_expire(SALT31.StrType s0) := MakeFT_clean_state_license_expire(s0);
EXPORT InValid_clean_state_license_expire(SALT31.StrType s) := InValidFT_clean_state_license_expire(s);
EXPORT InValidMessage_clean_state_license_expire(UNSIGNED1 wh) := InValidMessageFT_clean_state_license_expire(wh);
EXPORT Make_clean_state_license_issued(SALT31.StrType s0) := MakeFT_clean_state_license_issued(s0);
EXPORT InValid_clean_state_license_issued(SALT31.StrType s) := InValidFT_clean_state_license_issued(s);
EXPORT InValidMessage_clean_state_license_issued(UNSIGNED1 wh) := InValidMessageFT_clean_state_license_issued(wh);
EXPORT Make_dea_num(SALT31.StrType s0) := MakeFT_dea_num(s0);
EXPORT InValid_dea_num(SALT31.StrType s) := InValidFT_dea_num(s);
EXPORT InValidMessage_dea_num(UNSIGNED1 wh) := InValidMessageFT_dea_num(wh);
EXPORT Make_dea_bac(SALT31.StrType s0) := MakeFT_dea_bac(s0);
EXPORT InValid_dea_bac(SALT31.StrType s) := InValidFT_dea_bac(s);
EXPORT InValidMessage_dea_bac(UNSIGNED1 wh) := InValidMessageFT_dea_bac(wh);
EXPORT Make_dea_sub_bac(SALT31.StrType s0) := MakeFT_dea_sub_bac(s0);
EXPORT InValid_dea_sub_bac(SALT31.StrType s) := InValidFT_dea_sub_bac(s);
EXPORT InValidMessage_dea_sub_bac(UNSIGNED1 wh) := InValidMessageFT_dea_sub_bac(wh);
EXPORT Make_dea_schedule(SALT31.StrType s0) := MakeFT_dea_schedule(s0);
EXPORT InValid_dea_schedule(SALT31.StrType s) := InValidFT_dea_schedule(s);
EXPORT InValidMessage_dea_schedule(UNSIGNED1 wh) := InValidMessageFT_dea_schedule(wh);
EXPORT Make_dea_expire(SALT31.StrType s0) := MakeFT_dea_expire(s0);
EXPORT InValid_dea_expire(SALT31.StrType s) := InValidFT_dea_expire(s);
EXPORT InValidMessage_dea_expire(UNSIGNED1 wh) := InValidMessageFT_dea_expire(wh);
EXPORT Make_dea_active(SALT31.StrType s0) := MakeFT_dea_active(s0);
EXPORT InValid_dea_active(SALT31.StrType s) := InValidFT_dea_active(s);
EXPORT InValidMessage_dea_active(UNSIGNED1 wh) := InValidMessageFT_dea_active(wh);
EXPORT Make_clean_dea_expire(SALT31.StrType s0) := MakeFT_clean_dea_expire(s0);
EXPORT InValid_clean_dea_expire(SALT31.StrType s) := InValidFT_clean_dea_expire(s);
EXPORT InValidMessage_clean_dea_expire(UNSIGNED1 wh) := InValidMessageFT_clean_dea_expire(wh);
EXPORT Make_csr_number(SALT31.StrType s0) := MakeFT_csr_number(s0);
EXPORT InValid_csr_number(SALT31.StrType s) := InValidFT_csr_number(s);
EXPORT InValidMessage_csr_number(UNSIGNED1 wh) := InValidMessageFT_csr_number(wh);
EXPORT Make_csr_state(SALT31.StrType s0) := MakeFT_csr_state(s0);
EXPORT InValid_csr_state(SALT31.StrType s) := InValidFT_csr_state(s);
EXPORT InValidMessage_csr_state(UNSIGNED1 wh) := InValidMessageFT_csr_state(wh);
EXPORT Make_csr_expire_date(SALT31.StrType s0) := MakeFT_csr_expire_date(s0);
EXPORT InValid_csr_expire_date(SALT31.StrType s) := InValidFT_csr_expire_date(s);
EXPORT InValidMessage_csr_expire_date(UNSIGNED1 wh) := InValidMessageFT_csr_expire_date(wh);
EXPORT Make_csr_issue_date(SALT31.StrType s0) := MakeFT_csr_issue_date(s0);
EXPORT InValid_csr_issue_date(SALT31.StrType s) := InValidFT_csr_issue_date(s);
EXPORT InValidMessage_csr_issue_date(UNSIGNED1 wh) := InValidMessageFT_csr_issue_date(wh);
EXPORT Make_dsa_lvl_2(SALT31.StrType s0) := MakeFT_dsa_lvl_2(s0);
EXPORT InValid_dsa_lvl_2(SALT31.StrType s) := InValidFT_dsa_lvl_2(s);
EXPORT InValidMessage_dsa_lvl_2(UNSIGNED1 wh) := InValidMessageFT_dsa_lvl_2(wh);
EXPORT Make_dsa_lvl_2n(SALT31.StrType s0) := MakeFT_dsa_lvl_2n(s0);
EXPORT InValid_dsa_lvl_2n(SALT31.StrType s) := InValidFT_dsa_lvl_2n(s);
EXPORT InValidMessage_dsa_lvl_2n(UNSIGNED1 wh) := InValidMessageFT_dsa_lvl_2n(wh);
EXPORT Make_dsa_lvl_3(SALT31.StrType s0) := MakeFT_dsa_lvl_3(s0);
EXPORT InValid_dsa_lvl_3(SALT31.StrType s) := InValidFT_dsa_lvl_3(s);
EXPORT InValidMessage_dsa_lvl_3(UNSIGNED1 wh) := InValidMessageFT_dsa_lvl_3(wh);
EXPORT Make_dsa_lvl_3n(SALT31.StrType s0) := MakeFT_dsa_lvl_3n(s0);
EXPORT InValid_dsa_lvl_3n(SALT31.StrType s) := InValidFT_dsa_lvl_3n(s);
EXPORT InValidMessage_dsa_lvl_3n(UNSIGNED1 wh) := InValidMessageFT_dsa_lvl_3n(wh);
EXPORT Make_dsa_lvl_4(SALT31.StrType s0) := MakeFT_dsa_lvl_4(s0);
EXPORT InValid_dsa_lvl_4(SALT31.StrType s) := InValidFT_dsa_lvl_4(s);
EXPORT InValidMessage_dsa_lvl_4(UNSIGNED1 wh) := InValidMessageFT_dsa_lvl_4(wh);
EXPORT Make_dsa_lvl_5(SALT31.StrType s0) := MakeFT_dsa_lvl_5(s0);
EXPORT InValid_dsa_lvl_5(SALT31.StrType s) := InValidFT_dsa_lvl_5(s);
EXPORT InValidMessage_dsa_lvl_5(UNSIGNED1 wh) := InValidMessageFT_dsa_lvl_5(wh);
EXPORT Make_csr_raw1(SALT31.StrType s0) := MakeFT_csr_raw1(s0);
EXPORT InValid_csr_raw1(SALT31.StrType s) := InValidFT_csr_raw1(s);
EXPORT InValidMessage_csr_raw1(UNSIGNED1 wh) := InValidMessageFT_csr_raw1(wh);
EXPORT Make_csr_raw2(SALT31.StrType s0) := MakeFT_csr_raw2(s0);
EXPORT InValid_csr_raw2(SALT31.StrType s) := InValidFT_csr_raw2(s);
EXPORT InValidMessage_csr_raw2(UNSIGNED1 wh) := InValidMessageFT_csr_raw2(wh);
EXPORT Make_csr_raw3(SALT31.StrType s0) := MakeFT_csr_raw3(s0);
EXPORT InValid_csr_raw3(SALT31.StrType s) := InValidFT_csr_raw3(s);
EXPORT InValidMessage_csr_raw3(UNSIGNED1 wh) := InValidMessageFT_csr_raw3(wh);
EXPORT Make_csr_raw4(SALT31.StrType s0) := MakeFT_csr_raw4(s0);
EXPORT InValid_csr_raw4(SALT31.StrType s) := InValidFT_csr_raw4(s);
EXPORT InValidMessage_csr_raw4(UNSIGNED1 wh) := InValidMessageFT_csr_raw4(wh);
EXPORT Make_clean_csr_expire_date(SALT31.StrType s0) := MakeFT_clean_csr_expire_date(s0);
EXPORT InValid_clean_csr_expire_date(SALT31.StrType s) := InValidFT_clean_csr_expire_date(s);
EXPORT InValidMessage_clean_csr_expire_date(UNSIGNED1 wh) := InValidMessageFT_clean_csr_expire_date(wh);
EXPORT Make_clean_csr_issue_date(SALT31.StrType s0) := MakeFT_clean_csr_issue_date(s0);
EXPORT InValid_clean_csr_issue_date(SALT31.StrType s) := InValidFT_clean_csr_issue_date(s);
EXPORT InValidMessage_clean_csr_issue_date(UNSIGNED1 wh) := InValidMessageFT_clean_csr_issue_date(wh);
EXPORT Make_sanction_id(SALT31.StrType s0) := MakeFT_sanction_id(s0);
EXPORT InValid_sanction_id(SALT31.StrType s) := InValidFT_sanction_id(s);
EXPORT InValidMessage_sanction_id(UNSIGNED1 wh) := InValidMessageFT_sanction_id(wh);
EXPORT Make_sanction_action_code(SALT31.StrType s0) := MakeFT_sanction_action_code(s0);
EXPORT InValid_sanction_action_code(SALT31.StrType s) := InValidFT_sanction_action_code(s);
EXPORT InValidMessage_sanction_action_code(UNSIGNED1 wh) := InValidMessageFT_sanction_action_code(wh);
EXPORT Make_sanction_action_description(SALT31.StrType s0) := MakeFT_sanction_action_description(s0);
EXPORT InValid_sanction_action_description(SALT31.StrType s) := InValidFT_sanction_action_description(s);
EXPORT InValidMessage_sanction_action_description(UNSIGNED1 wh) := InValidMessageFT_sanction_action_description(wh);
EXPORT Make_sanction_board_code(SALT31.StrType s0) := MakeFT_sanction_board_code(s0);
EXPORT InValid_sanction_board_code(SALT31.StrType s) := InValidFT_sanction_board_code(s);
EXPORT InValidMessage_sanction_board_code(UNSIGNED1 wh) := InValidMessageFT_sanction_board_code(wh);
EXPORT Make_sanction_board_description(SALT31.StrType s0) := MakeFT_sanction_board_description(s0);
EXPORT InValid_sanction_board_description(SALT31.StrType s) := InValidFT_sanction_board_description(s);
EXPORT InValidMessage_sanction_board_description(UNSIGNED1 wh) := InValidMessageFT_sanction_board_description(wh);
EXPORT Make_action_date(SALT31.StrType s0) := MakeFT_action_date(s0);
EXPORT InValid_action_date(SALT31.StrType s) := InValidFT_action_date(s);
EXPORT InValidMessage_action_date(UNSIGNED1 wh) := InValidMessageFT_action_date(wh);
EXPORT Make_sanction_period_start_date(SALT31.StrType s0) := MakeFT_sanction_period_start_date(s0);
EXPORT InValid_sanction_period_start_date(SALT31.StrType s) := InValidFT_sanction_period_start_date(s);
EXPORT InValidMessage_sanction_period_start_date(UNSIGNED1 wh) := InValidMessageFT_sanction_period_start_date(wh);
EXPORT Make_sanction_period_end_date(SALT31.StrType s0) := MakeFT_sanction_period_end_date(s0);
EXPORT InValid_sanction_period_end_date(SALT31.StrType s) := InValidFT_sanction_period_end_date(s);
EXPORT InValidMessage_sanction_period_end_date(UNSIGNED1 wh) := InValidMessageFT_sanction_period_end_date(wh);
EXPORT Make_month_duration(SALT31.StrType s0) := MakeFT_month_duration(s0);
EXPORT InValid_month_duration(SALT31.StrType s) := InValidFT_month_duration(s);
EXPORT InValidMessage_month_duration(UNSIGNED1 wh) := InValidMessageFT_month_duration(wh);
EXPORT Make_fine_amount(SALT31.StrType s0) := MakeFT_fine_amount(s0);
EXPORT InValid_fine_amount(SALT31.StrType s) := InValidFT_fine_amount(s);
EXPORT InValidMessage_fine_amount(UNSIGNED1 wh) := InValidMessageFT_fine_amount(wh);
EXPORT Make_offense_code(SALT31.StrType s0) := MakeFT_offense_code(s0);
EXPORT InValid_offense_code(SALT31.StrType s) := InValidFT_offense_code(s);
EXPORT InValidMessage_offense_code(UNSIGNED1 wh) := InValidMessageFT_offense_code(wh);
EXPORT Make_offense_description(SALT31.StrType s0) := MakeFT_offense_description(s0);
EXPORT InValid_offense_description(SALT31.StrType s) := InValidFT_offense_description(s);
EXPORT InValidMessage_offense_description(UNSIGNED1 wh) := InValidMessageFT_offense_description(wh);
EXPORT Make_offense_date(SALT31.StrType s0) := MakeFT_offense_date(s0);
EXPORT InValid_offense_date(SALT31.StrType s) := InValidFT_offense_date(s);
EXPORT InValidMessage_offense_date(UNSIGNED1 wh) := InValidMessageFT_offense_date(wh);
EXPORT Make_clean_offense_date(SALT31.StrType s0) := MakeFT_clean_offense_date(s0);
EXPORT InValid_clean_offense_date(SALT31.StrType s) := InValidFT_clean_offense_date(s);
EXPORT InValidMessage_clean_offense_date(UNSIGNED1 wh) := InValidMessageFT_clean_offense_date(wh);
EXPORT Make_clean_action_date(SALT31.StrType s0) := MakeFT_clean_action_date(s0);
EXPORT InValid_clean_action_date(SALT31.StrType s) := InValidFT_clean_action_date(s);
EXPORT InValidMessage_clean_action_date(UNSIGNED1 wh) := InValidMessageFT_clean_action_date(wh);
EXPORT Make_clean_sanction_period_start_date(SALT31.StrType s0) := MakeFT_clean_sanction_period_start_date(s0);
EXPORT InValid_clean_sanction_period_start_date(SALT31.StrType s) := InValidFT_clean_sanction_period_start_date(s);
EXPORT InValidMessage_clean_sanction_period_start_date(UNSIGNED1 wh) := InValidMessageFT_clean_sanction_period_start_date(wh);
EXPORT Make_clean_sanction_period_end_date(SALT31.StrType s0) := MakeFT_clean_sanction_period_end_date(s0);
EXPORT InValid_clean_sanction_period_end_date(SALT31.StrType s) := InValidFT_clean_sanction_period_end_date(s);
EXPORT InValidMessage_clean_sanction_period_end_date(UNSIGNED1 wh) := InValidMessageFT_clean_sanction_period_end_date(wh);
EXPORT Make_gsa_sanction_id(SALT31.StrType s0) := MakeFT_gsa_sanction_id(s0);
EXPORT InValid_gsa_sanction_id(SALT31.StrType s) := InValidFT_gsa_sanction_id(s);
EXPORT InValidMessage_gsa_sanction_id(UNSIGNED1 wh) := InValidMessageFT_gsa_sanction_id(wh);
EXPORT Make_gsa_first(SALT31.StrType s0) := MakeFT_gsa_first(s0);
EXPORT InValid_gsa_first(SALT31.StrType s) := InValidFT_gsa_first(s);
EXPORT InValidMessage_gsa_first(UNSIGNED1 wh) := InValidMessageFT_gsa_first(wh);
EXPORT Make_gsa_middle(SALT31.StrType s0) := MakeFT_gsa_middle(s0);
EXPORT InValid_gsa_middle(SALT31.StrType s) := InValidFT_gsa_middle(s);
EXPORT InValidMessage_gsa_middle(UNSIGNED1 wh) := InValidMessageFT_gsa_middle(wh);
EXPORT Make_gsa_last(SALT31.StrType s0) := MakeFT_gsa_last(s0);
EXPORT InValid_gsa_last(SALT31.StrType s) := InValidFT_gsa_last(s);
EXPORT InValidMessage_gsa_last(UNSIGNED1 wh) := InValidMessageFT_gsa_last(wh);
EXPORT Make_gsa_suffix(SALT31.StrType s0) := MakeFT_gsa_suffix(s0);
EXPORT InValid_gsa_suffix(SALT31.StrType s) := InValidFT_gsa_suffix(s);
EXPORT InValidMessage_gsa_suffix(UNSIGNED1 wh) := InValidMessageFT_gsa_suffix(wh);
EXPORT Make_gsa_city(SALT31.StrType s0) := MakeFT_gsa_city(s0);
EXPORT InValid_gsa_city(SALT31.StrType s) := InValidFT_gsa_city(s);
EXPORT InValidMessage_gsa_city(UNSIGNED1 wh) := InValidMessageFT_gsa_city(wh);
EXPORT Make_gsa_state(SALT31.StrType s0) := MakeFT_gsa_state(s0);
EXPORT InValid_gsa_state(SALT31.StrType s) := InValidFT_gsa_state(s);
EXPORT InValidMessage_gsa_state(UNSIGNED1 wh) := InValidMessageFT_gsa_state(wh);
EXPORT Make_gsa_zip(SALT31.StrType s0) := MakeFT_gsa_zip(s0);
EXPORT InValid_gsa_zip(SALT31.StrType s) := InValidFT_gsa_zip(s);
EXPORT InValidMessage_gsa_zip(UNSIGNED1 wh) := InValidMessageFT_gsa_zip(wh);
EXPORT Make_date(SALT31.StrType s0) := MakeFT_date(s0);
EXPORT InValid_date(SALT31.StrType s) := InValidFT_date(s);
EXPORT InValidMessage_date(UNSIGNED1 wh) := InValidMessageFT_date(wh);
EXPORT Make_agency(SALT31.StrType s0) := MakeFT_agency(s0);
EXPORT InValid_agency(SALT31.StrType s) := InValidFT_agency(s);
EXPORT InValidMessage_agency(UNSIGNED1 wh) := InValidMessageFT_agency(wh);
EXPORT Make_confidence(SALT31.StrType s0) := MakeFT_confidence(s0);
EXPORT InValid_confidence(SALT31.StrType s) := InValidFT_confidence(s);
EXPORT InValidMessage_confidence(UNSIGNED1 wh) := InValidMessageFT_confidence(wh);
EXPORT Make_clean_gsa_first(SALT31.StrType s0) := MakeFT_clean_gsa_first(s0);
EXPORT InValid_clean_gsa_first(SALT31.StrType s) := InValidFT_clean_gsa_first(s);
EXPORT InValidMessage_clean_gsa_first(UNSIGNED1 wh) := InValidMessageFT_clean_gsa_first(wh);
EXPORT Make_clean_gsa_middle(SALT31.StrType s0) := MakeFT_clean_gsa_middle(s0);
EXPORT InValid_clean_gsa_middle(SALT31.StrType s) := InValidFT_clean_gsa_middle(s);
EXPORT InValidMessage_clean_gsa_middle(UNSIGNED1 wh) := InValidMessageFT_clean_gsa_middle(wh);
EXPORT Make_clean_gsa_last(SALT31.StrType s0) := MakeFT_clean_gsa_last(s0);
EXPORT InValid_clean_gsa_last(SALT31.StrType s) := InValidFT_clean_gsa_last(s);
EXPORT InValidMessage_clean_gsa_last(UNSIGNED1 wh) := InValidMessageFT_clean_gsa_last(wh);
EXPORT Make_clean_gsa_suffix(SALT31.StrType s0) := MakeFT_clean_gsa_suffix(s0);
EXPORT InValid_clean_gsa_suffix(SALT31.StrType s) := InValidFT_clean_gsa_suffix(s);
EXPORT InValidMessage_clean_gsa_suffix(UNSIGNED1 wh) := InValidMessageFT_clean_gsa_suffix(wh);
EXPORT Make_clean_gsa_city(SALT31.StrType s0) := MakeFT_clean_gsa_city(s0);
EXPORT InValid_clean_gsa_city(SALT31.StrType s) := InValidFT_clean_gsa_city(s);
EXPORT InValidMessage_clean_gsa_city(UNSIGNED1 wh) := InValidMessageFT_clean_gsa_city(wh);
EXPORT Make_clean_gsa_state(SALT31.StrType s0) := MakeFT_clean_gsa_state(s0);
EXPORT InValid_clean_gsa_state(SALT31.StrType s) := InValidFT_clean_gsa_state(s);
EXPORT InValidMessage_clean_gsa_state(UNSIGNED1 wh) := InValidMessageFT_clean_gsa_state(wh);
EXPORT Make_clean_gsa_zip(SALT31.StrType s0) := MakeFT_clean_gsa_zip(s0);
EXPORT InValid_clean_gsa_zip(SALT31.StrType s) := InValidFT_clean_gsa_zip(s);
EXPORT InValidMessage_clean_gsa_zip(UNSIGNED1 wh) := InValidMessageFT_clean_gsa_zip(wh);
EXPORT Make_clean_gsa_action_date(SALT31.StrType s0) := MakeFT_clean_gsa_action_date(s0);
EXPORT InValid_clean_gsa_action_date(SALT31.StrType s) := InValidFT_clean_gsa_action_date(s);
EXPORT InValidMessage_clean_gsa_action_date(UNSIGNED1 wh) := InValidMessageFT_clean_gsa_action_date(wh);
EXPORT Make_clean_gsa_date(SALT31.StrType s0) := MakeFT_clean_gsa_date(s0);
EXPORT InValid_clean_gsa_date(SALT31.StrType s) := InValidFT_clean_gsa_date(s);
EXPORT InValidMessage_clean_gsa_date(UNSIGNED1 wh) := InValidMessageFT_clean_gsa_date(wh);
EXPORT Make_fax(SALT31.StrType s0) := MakeFT_fax(s0);
EXPORT InValid_fax(SALT31.StrType s) := InValidFT_fax(s);
EXPORT InValidMessage_fax(UNSIGNED1 wh) := InValidMessageFT_fax(wh);
EXPORT Make_phone(SALT31.StrType s0) := MakeFT_phone(s0);
EXPORT InValid_phone(SALT31.StrType s) := InValidFT_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_phone(wh);
EXPORT Make_certification_code(SALT31.StrType s0) := MakeFT_certification_code(s0);
EXPORT InValid_certification_code(SALT31.StrType s) := InValidFT_certification_code(s);
EXPORT InValidMessage_certification_code(UNSIGNED1 wh) := InValidMessageFT_certification_code(wh);
EXPORT Make_certification_description(SALT31.StrType s0) := MakeFT_certification_description(s0);
EXPORT InValid_certification_description(SALT31.StrType s) := InValidFT_certification_description(s);
EXPORT InValidMessage_certification_description(UNSIGNED1 wh) := InValidMessageFT_certification_description(wh);
EXPORT Make_board_code(SALT31.StrType s0) := MakeFT_board_code(s0);
EXPORT InValid_board_code(SALT31.StrType s) := InValidFT_board_code(s);
EXPORT InValidMessage_board_code(UNSIGNED1 wh) := InValidMessageFT_board_code(wh);
EXPORT Make_board_description(SALT31.StrType s0) := MakeFT_board_description(s0);
EXPORT InValid_board_description(SALT31.StrType s) := InValidFT_board_description(s);
EXPORT InValidMessage_board_description(UNSIGNED1 wh) := InValidMessageFT_board_description(wh);
EXPORT Make_expiration_year(SALT31.StrType s0) := MakeFT_expiration_year(s0);
EXPORT InValid_expiration_year(SALT31.StrType s) := InValidFT_expiration_year(s);
EXPORT InValidMessage_expiration_year(UNSIGNED1 wh) := InValidMessageFT_expiration_year(wh);
EXPORT Make_issue_year(SALT31.StrType s0) := MakeFT_issue_year(s0);
EXPORT InValid_issue_year(SALT31.StrType s) := InValidFT_issue_year(s);
EXPORT InValidMessage_issue_year(UNSIGNED1 wh) := InValidMessageFT_issue_year(wh);
EXPORT Make_renewal_year(SALT31.StrType s0) := MakeFT_renewal_year(s0);
EXPORT InValid_renewal_year(SALT31.StrType s) := InValidFT_renewal_year(s);
EXPORT InValidMessage_renewal_year(UNSIGNED1 wh) := InValidMessageFT_renewal_year(wh);
EXPORT Make_lifetime_flag(SALT31.StrType s0) := MakeFT_lifetime_flag(s0);
EXPORT InValid_lifetime_flag(SALT31.StrType s) := InValidFT_lifetime_flag(s);
EXPORT InValidMessage_lifetime_flag(UNSIGNED1 wh) := InValidMessageFT_lifetime_flag(wh);
EXPORT Make_covered_recipient_id(SALT31.StrType s0) := MakeFT_covered_recipient_id(s0);
EXPORT InValid_covered_recipient_id(SALT31.StrType s) := InValidFT_covered_recipient_id(s);
EXPORT InValidMessage_covered_recipient_id(UNSIGNED1 wh) := InValidMessageFT_covered_recipient_id(wh);
EXPORT Make_cov_rcp_raw_state_code(SALT31.StrType s0) := MakeFT_cov_rcp_raw_state_code(s0);
EXPORT InValid_cov_rcp_raw_state_code(SALT31.StrType s) := InValidFT_cov_rcp_raw_state_code(s);
EXPORT InValidMessage_cov_rcp_raw_state_code(UNSIGNED1 wh) := InValidMessageFT_cov_rcp_raw_state_code(wh);
EXPORT Make_cov_rcp_raw_full_name(SALT31.StrType s0) := MakeFT_cov_rcp_raw_full_name(s0);
EXPORT InValid_cov_rcp_raw_full_name(SALT31.StrType s) := InValidFT_cov_rcp_raw_full_name(s);
EXPORT InValidMessage_cov_rcp_raw_full_name(UNSIGNED1 wh) := InValidMessageFT_cov_rcp_raw_full_name(wh);
EXPORT Make_cov_rcp_raw_attribute1(SALT31.StrType s0) := MakeFT_cov_rcp_raw_attribute1(s0);
EXPORT InValid_cov_rcp_raw_attribute1(SALT31.StrType s) := InValidFT_cov_rcp_raw_attribute1(s);
EXPORT InValidMessage_cov_rcp_raw_attribute1(UNSIGNED1 wh) := InValidMessageFT_cov_rcp_raw_attribute1(wh);
EXPORT Make_cov_rcp_raw_attribute2(SALT31.StrType s0) := MakeFT_cov_rcp_raw_attribute2(s0);
EXPORT InValid_cov_rcp_raw_attribute2(SALT31.StrType s) := InValidFT_cov_rcp_raw_attribute2(s);
EXPORT InValidMessage_cov_rcp_raw_attribute2(UNSIGNED1 wh) := InValidMessageFT_cov_rcp_raw_attribute2(wh);
EXPORT Make_cov_rcp_raw_attribute3(SALT31.StrType s0) := MakeFT_cov_rcp_raw_attribute3(s0);
EXPORT InValid_cov_rcp_raw_attribute3(SALT31.StrType s) := InValidFT_cov_rcp_raw_attribute3(s);
EXPORT InValidMessage_cov_rcp_raw_attribute3(UNSIGNED1 wh) := InValidMessageFT_cov_rcp_raw_attribute3(wh);
EXPORT Make_cov_rcp_raw_attribute4(SALT31.StrType s0) := MakeFT_cov_rcp_raw_attribute4(s0);
EXPORT InValid_cov_rcp_raw_attribute4(SALT31.StrType s) := InValidFT_cov_rcp_raw_attribute4(s);
EXPORT InValidMessage_cov_rcp_raw_attribute4(UNSIGNED1 wh) := InValidMessageFT_cov_rcp_raw_attribute4(wh);
EXPORT Make_hms_scid(SALT31.StrType s0) := MakeFT_hms_scid(s0);
EXPORT InValid_hms_scid(SALT31.StrType s) := InValidFT_hms_scid(s);
EXPORT InValidMessage_hms_scid(UNSIGNED1 wh) := InValidMessageFT_hms_scid(wh);
EXPORT Make_school_name(SALT31.StrType s0) := MakeFT_school_name(s0);
EXPORT InValid_school_name(SALT31.StrType s) := InValidFT_school_name(s);
EXPORT InValidMessage_school_name(UNSIGNED1 wh) := InValidMessageFT_school_name(wh);
EXPORT Make_grad_year(SALT31.StrType s0) := MakeFT_grad_year(s0);
EXPORT InValid_grad_year(SALT31.StrType s) := InValidFT_grad_year(s);
EXPORT InValidMessage_grad_year(UNSIGNED1 wh) := InValidMessageFT_grad_year(wh);
EXPORT Make_lang_code(SALT31.StrType s0) := MakeFT_lang_code(s0);
EXPORT InValid_lang_code(SALT31.StrType s) := InValidFT_lang_code(s);
EXPORT InValidMessage_lang_code(UNSIGNED1 wh) := InValidMessageFT_lang_code(wh);
EXPORT Make_language(SALT31.StrType s0) := MakeFT_language(s0);
EXPORT InValid_language(SALT31.StrType s) := InValidFT_language(s);
EXPORT InValidMessage_language(UNSIGNED1 wh) := InValidMessageFT_language(wh);
EXPORT Make_specialty_description(SALT31.StrType s0) := MakeFT_specialty_description(s0);
EXPORT InValid_specialty_description(SALT31.StrType s) := InValidFT_specialty_description(s);
EXPORT InValidMessage_specialty_description(UNSIGNED1 wh) := InValidMessageFT_specialty_description(wh);
EXPORT Make_clean_phone(SALT31.StrType s0) := MakeFT_clean_phone(s0);
EXPORT InValid_clean_phone(SALT31.StrType s) := InValidFT_clean_phone(s);
EXPORT InValidMessage_clean_phone(UNSIGNED1 wh) := InValidMessageFT_clean_phone(wh);
EXPORT Make_bdid(SALT31.StrType s0) := MakeFT_bdid(s0);
EXPORT InValid_bdid(SALT31.StrType s) := InValidFT_bdid(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_bdid(wh);
EXPORT Make_bdid_score(SALT31.StrType s0) := MakeFT_bdid_score(s0);
EXPORT InValid_bdid_score(SALT31.StrType s) := InValidFT_bdid_score(s);
EXPORT InValidMessage_bdid_score(UNSIGNED1 wh) := InValidMessageFT_bdid_score(wh);
EXPORT Make_did(SALT31.StrType s0) := MakeFT_did(s0);
EXPORT InValid_did(SALT31.StrType s) := InValidFT_did(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_did(wh);
EXPORT Make_did_score(SALT31.StrType s0) := MakeFT_did_score(s0);
EXPORT InValid_did_score(SALT31.StrType s) := InValidFT_did_score(s);
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := InValidMessageFT_did_score(wh);
EXPORT Make_clean_dob(SALT31.StrType s0) := MakeFT_clean_dob(s0);
EXPORT InValid_clean_dob(SALT31.StrType s) := InValidFT_clean_dob(s);
EXPORT InValidMessage_clean_dob(UNSIGNED1 wh) := InValidMessageFT_clean_dob(wh);
EXPORT Make_best_dob(SALT31.StrType s0) := MakeFT_best_dob(s0);
EXPORT InValid_best_dob(SALT31.StrType s) := InValidFT_best_dob(s);
EXPORT InValidMessage_best_dob(UNSIGNED1 wh) := InValidMessageFT_best_dob(wh);
EXPORT Make_best_ssn(SALT31.StrType s0) := MakeFT_best_ssn(s0);
EXPORT InValid_best_ssn(SALT31.StrType s) := InValidFT_best_ssn(s);
EXPORT InValidMessage_best_ssn(UNSIGNED1 wh) := InValidMessageFT_best_ssn(wh);
EXPORT Make_rec_deactivated_date(SALT31.StrType s0) := MakeFT_rec_deactivated_date(s0);
EXPORT InValid_rec_deactivated_date(SALT31.StrType s) := InValidFT_rec_deactivated_date(s);
EXPORT InValidMessage_rec_deactivated_date(UNSIGNED1 wh) := InValidMessageFT_rec_deactivated_date(wh);
EXPORT Make_superceeding_piid(SALT31.StrType s0) := MakeFT_superceeding_piid(s0);
EXPORT InValid_superceeding_piid(SALT31.StrType s) := InValidFT_superceeding_piid(s);
EXPORT InValidMessage_superceeding_piid(UNSIGNED1 wh) := InValidMessageFT_superceeding_piid(wh);
EXPORT Make_dotid(SALT31.StrType s0) := MakeFT_dotid(s0);
EXPORT InValid_dotid(SALT31.StrType s) := InValidFT_dotid(s);
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := InValidMessageFT_dotid(wh);
EXPORT Make_dotscore(SALT31.StrType s0) := MakeFT_dotscore(s0);
EXPORT InValid_dotscore(SALT31.StrType s) := InValidFT_dotscore(s);
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := InValidMessageFT_dotscore(wh);
EXPORT Make_dotweight(SALT31.StrType s0) := MakeFT_dotweight(s0);
EXPORT InValid_dotweight(SALT31.StrType s) := InValidFT_dotweight(s);
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := InValidMessageFT_dotweight(wh);
EXPORT Make_empid(SALT31.StrType s0) := MakeFT_empid(s0);
EXPORT InValid_empid(SALT31.StrType s) := InValidFT_empid(s);
EXPORT InValidMessage_empid(UNSIGNED1 wh) := InValidMessageFT_empid(wh);
EXPORT Make_empscore(SALT31.StrType s0) := MakeFT_empscore(s0);
EXPORT InValid_empscore(SALT31.StrType s) := InValidFT_empscore(s);
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := InValidMessageFT_empscore(wh);
EXPORT Make_empweight(SALT31.StrType s0) := MakeFT_empweight(s0);
EXPORT InValid_empweight(SALT31.StrType s) := InValidFT_empweight(s);
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := InValidMessageFT_empweight(wh);
EXPORT Make_powid(SALT31.StrType s0) := MakeFT_powid(s0);
EXPORT InValid_powid(SALT31.StrType s) := InValidFT_powid(s);
EXPORT InValidMessage_powid(UNSIGNED1 wh) := InValidMessageFT_powid(wh);
EXPORT Make_powscore(SALT31.StrType s0) := MakeFT_powscore(s0);
EXPORT InValid_powscore(SALT31.StrType s) := InValidFT_powscore(s);
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := InValidMessageFT_powscore(wh);
EXPORT Make_powweight(SALT31.StrType s0) := MakeFT_powweight(s0);
EXPORT InValid_powweight(SALT31.StrType s) := InValidFT_powweight(s);
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := InValidMessageFT_powweight(wh);
EXPORT Make_proxid(SALT31.StrType s0) := MakeFT_proxid(s0);
EXPORT InValid_proxid(SALT31.StrType s) := InValidFT_proxid(s);
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := InValidMessageFT_proxid(wh);
EXPORT Make_proxscore(SALT31.StrType s0) := MakeFT_proxscore(s0);
EXPORT InValid_proxscore(SALT31.StrType s) := InValidFT_proxscore(s);
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := InValidMessageFT_proxscore(wh);
EXPORT Make_proxweight(SALT31.StrType s0) := MakeFT_proxweight(s0);
EXPORT InValid_proxweight(SALT31.StrType s) := InValidFT_proxweight(s);
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := InValidMessageFT_proxweight(wh);
EXPORT Make_seleid(SALT31.StrType s0) := MakeFT_seleid(s0);
EXPORT InValid_seleid(SALT31.StrType s) := InValidFT_seleid(s);
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := InValidMessageFT_seleid(wh);
EXPORT Make_selescore(SALT31.StrType s0) := MakeFT_selescore(s0);
EXPORT InValid_selescore(SALT31.StrType s) := InValidFT_selescore(s);
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := InValidMessageFT_selescore(wh);
EXPORT Make_seleweight(SALT31.StrType s0) := MakeFT_seleweight(s0);
EXPORT InValid_seleweight(SALT31.StrType s) := InValidFT_seleweight(s);
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := InValidMessageFT_seleweight(wh);
EXPORT Make_orgid(SALT31.StrType s0) := MakeFT_orgid(s0);
EXPORT InValid_orgid(SALT31.StrType s) := InValidFT_orgid(s);
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := InValidMessageFT_orgid(wh);
EXPORT Make_orgscore(SALT31.StrType s0) := MakeFT_orgscore(s0);
EXPORT InValid_orgscore(SALT31.StrType s) := InValidFT_orgscore(s);
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := InValidMessageFT_orgscore(wh);
EXPORT Make_orgweight(SALT31.StrType s0) := MakeFT_orgweight(s0);
EXPORT InValid_orgweight(SALT31.StrType s) := InValidFT_orgweight(s);
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := InValidMessageFT_orgweight(wh);
EXPORT Make_ultid(SALT31.StrType s0) := MakeFT_ultid(s0);
EXPORT InValid_ultid(SALT31.StrType s) := InValidFT_ultid(s);
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := InValidMessageFT_ultid(wh);
EXPORT Make_ultscore(SALT31.StrType s0) := MakeFT_ultscore(s0);
EXPORT InValid_ultscore(SALT31.StrType s) := InValidFT_ultscore(s);
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := InValidMessageFT_ultscore(wh);
EXPORT Make_ultweight(SALT31.StrType s0) := MakeFT_ultweight(s0);
EXPORT InValid_ultweight(SALT31.StrType s) := InValidFT_ultweight(s);
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := InValidMessageFT_ultweight(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT31,Scrubs_HMS;
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
    BOOLEAN Diff_hms_piid;
    BOOLEAN Diff_first;
    BOOLEAN Diff_middle;
    BOOLEAN Diff_last;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_cred;
    BOOLEAN Diff_practitioner_type;
    BOOLEAN Diff_active;
    BOOLEAN Diff_vendible;
    BOOLEAN Diff_npi_num;
    BOOLEAN Diff_npi_enumeration_date;
    BOOLEAN Diff_npi_deactivation_date;
    BOOLEAN Diff_npi_reactivation_date;
    BOOLEAN Diff_npi_taxonomy_code;
    BOOLEAN Diff_upin;
    BOOLEAN Diff_medicare_participation_flag;
    BOOLEAN Diff_date_born;
    BOOLEAN Diff_date_died;
    BOOLEAN Diff_pid;
    BOOLEAN Diff_src;
    BOOLEAN Diff_date_vendor_first_reported;
    BOOLEAN Diff_date_vendor_last_reported;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_source_rid;
    BOOLEAN Diff_lnpid;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_nametype;
    BOOLEAN Diff_nid;
    BOOLEAN Diff_clean_npi_enumeration_date;
    BOOLEAN Diff_clean_npi_deactivation_date;
    BOOLEAN Diff_clean_npi_reactivation_date;
    BOOLEAN Diff_clean_date_born;
    BOOLEAN Diff_clean_date_died;
    BOOLEAN Diff_clean_company_name;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dbpc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_fips_st;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_rawaid;
    BOOLEAN Diff_aceaid;
    BOOLEAN Diff_firm_name;
    BOOLEAN Diff_lid;
    BOOLEAN Diff_agid;
    BOOLEAN Diff_address_std_code;
    BOOLEAN Diff_latitude;
    BOOLEAN Diff_longitude;
    BOOLEAN Diff_prepped_addr1;
    BOOLEAN Diff_prepped_addr2;
    BOOLEAN Diff_addr_type;
    BOOLEAN Diff_state_license_state;
    BOOLEAN Diff_state_license_number;
    BOOLEAN Diff_state_license_type;
    BOOLEAN Diff_state_license_active;
    BOOLEAN Diff_state_license_expire;
    BOOLEAN Diff_state_license_qualifier;
    BOOLEAN Diff_state_license_sub_qualifier;
    BOOLEAN Diff_state_license_issued;
    BOOLEAN Diff_clean_state_license_expire;
    BOOLEAN Diff_clean_state_license_issued;
    BOOLEAN Diff_dea_num;
    BOOLEAN Diff_dea_bac;
    BOOLEAN Diff_dea_sub_bac;
    BOOLEAN Diff_dea_schedule;
    BOOLEAN Diff_dea_expire;
    BOOLEAN Diff_dea_active;
    BOOLEAN Diff_clean_dea_expire;
    BOOLEAN Diff_csr_number;
    BOOLEAN Diff_csr_state;
    BOOLEAN Diff_csr_expire_date;
    BOOLEAN Diff_csr_issue_date;
    BOOLEAN Diff_dsa_lvl_2;
    BOOLEAN Diff_dsa_lvl_2n;
    BOOLEAN Diff_dsa_lvl_3;
    BOOLEAN Diff_dsa_lvl_3n;
    BOOLEAN Diff_dsa_lvl_4;
    BOOLEAN Diff_dsa_lvl_5;
    BOOLEAN Diff_csr_raw1;
    BOOLEAN Diff_csr_raw2;
    BOOLEAN Diff_csr_raw3;
    BOOLEAN Diff_csr_raw4;
    BOOLEAN Diff_clean_csr_expire_date;
    BOOLEAN Diff_clean_csr_issue_date;
    BOOLEAN Diff_sanction_id;
    BOOLEAN Diff_sanction_action_code;
    BOOLEAN Diff_sanction_action_description;
    BOOLEAN Diff_sanction_board_code;
    BOOLEAN Diff_sanction_board_description;
    BOOLEAN Diff_action_date;
    BOOLEAN Diff_sanction_period_start_date;
    BOOLEAN Diff_sanction_period_end_date;
    BOOLEAN Diff_month_duration;
    BOOLEAN Diff_fine_amount;
    BOOLEAN Diff_offense_code;
    BOOLEAN Diff_offense_description;
    BOOLEAN Diff_offense_date;
    BOOLEAN Diff_clean_offense_date;
    BOOLEAN Diff_clean_action_date;
    BOOLEAN Diff_clean_sanction_period_start_date;
    BOOLEAN Diff_clean_sanction_period_end_date;
    BOOLEAN Diff_gsa_sanction_id;
    BOOLEAN Diff_gsa_first;
    BOOLEAN Diff_gsa_middle;
    BOOLEAN Diff_gsa_last;
    BOOLEAN Diff_gsa_suffix;
    BOOLEAN Diff_gsa_city;
    BOOLEAN Diff_gsa_state;
    BOOLEAN Diff_gsa_zip;
    BOOLEAN Diff_date;
    BOOLEAN Diff_agency;
    BOOLEAN Diff_confidence;
    BOOLEAN Diff_clean_gsa_first;
    BOOLEAN Diff_clean_gsa_middle;
    BOOLEAN Diff_clean_gsa_last;
    BOOLEAN Diff_clean_gsa_suffix;
    BOOLEAN Diff_clean_gsa_city;
    BOOLEAN Diff_clean_gsa_state;
    BOOLEAN Diff_clean_gsa_zip;
    BOOLEAN Diff_clean_gsa_action_date;
    BOOLEAN Diff_clean_gsa_date;
    BOOLEAN Diff_fax;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_certification_code;
    BOOLEAN Diff_certification_description;
    BOOLEAN Diff_board_code;
    BOOLEAN Diff_board_description;
    BOOLEAN Diff_expiration_year;
    BOOLEAN Diff_issue_year;
    BOOLEAN Diff_renewal_year;
    BOOLEAN Diff_lifetime_flag;
    BOOLEAN Diff_covered_recipient_id;
    BOOLEAN Diff_cov_rcp_raw_state_code;
    BOOLEAN Diff_cov_rcp_raw_full_name;
    BOOLEAN Diff_cov_rcp_raw_attribute1;
    BOOLEAN Diff_cov_rcp_raw_attribute2;
    BOOLEAN Diff_cov_rcp_raw_attribute3;
    BOOLEAN Diff_cov_rcp_raw_attribute4;
    BOOLEAN Diff_hms_scid;
    BOOLEAN Diff_school_name;
    BOOLEAN Diff_grad_year;
    BOOLEAN Diff_lang_code;
    BOOLEAN Diff_language;
    BOOLEAN Diff_specialty_description;
    BOOLEAN Diff_clean_phone;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_bdid_score;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_clean_dob;
    BOOLEAN Diff_best_dob;
    BOOLEAN Diff_best_ssn;
    BOOLEAN Diff_rec_deactivated_date;
    BOOLEAN Diff_superceeding_piid;
    BOOLEAN Diff_dotid;
    BOOLEAN Diff_dotscore;
    BOOLEAN Diff_dotweight;
    BOOLEAN Diff_empid;
    BOOLEAN Diff_empscore;
    BOOLEAN Diff_empweight;
    BOOLEAN Diff_powid;
    BOOLEAN Diff_powscore;
    BOOLEAN Diff_powweight;
    BOOLEAN Diff_proxid;
    BOOLEAN Diff_proxscore;
    BOOLEAN Diff_proxweight;
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_selescore;
    BOOLEAN Diff_seleweight;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_orgscore;
    BOOLEAN Diff_orgweight;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_ultscore;
    BOOLEAN Diff_ultweight;
    UNSIGNED Num_Diffs;
    SALT31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_hms_piid := le.hms_piid <> ri.hms_piid;
    SELF.Diff_first := le.first <> ri.first;
    SELF.Diff_middle := le.middle <> ri.middle;
    SELF.Diff_last := le.last <> ri.last;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_cred := le.cred <> ri.cred;
    SELF.Diff_practitioner_type := le.practitioner_type <> ri.practitioner_type;
    SELF.Diff_active := le.active <> ri.active;
    SELF.Diff_vendible := le.vendible <> ri.vendible;
    SELF.Diff_npi_num := le.npi_num <> ri.npi_num;
    SELF.Diff_npi_enumeration_date := le.npi_enumeration_date <> ri.npi_enumeration_date;
    SELF.Diff_npi_deactivation_date := le.npi_deactivation_date <> ri.npi_deactivation_date;
    SELF.Diff_npi_reactivation_date := le.npi_reactivation_date <> ri.npi_reactivation_date;
    SELF.Diff_npi_taxonomy_code := le.npi_taxonomy_code <> ri.npi_taxonomy_code;
    SELF.Diff_upin := le.upin <> ri.upin;
    SELF.Diff_medicare_participation_flag := le.medicare_participation_flag <> ri.medicare_participation_flag;
    SELF.Diff_date_born := le.date_born <> ri.date_born;
    SELF.Diff_date_died := le.date_died <> ri.date_died;
    SELF.Diff_pid := le.pid <> ri.pid;
    SELF.Diff_src := le.src <> ri.src;
    SELF.Diff_date_vendor_first_reported := le.date_vendor_first_reported <> ri.date_vendor_first_reported;
    SELF.Diff_date_vendor_last_reported := le.date_vendor_last_reported <> ri.date_vendor_last_reported;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_source_rid := le.source_rid <> ri.source_rid;
    SELF.Diff_lnpid := le.lnpid <> ri.lnpid;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_nametype := le.nametype <> ri.nametype;
    SELF.Diff_nid := le.nid <> ri.nid;
    SELF.Diff_clean_npi_enumeration_date := le.clean_npi_enumeration_date <> ri.clean_npi_enumeration_date;
    SELF.Diff_clean_npi_deactivation_date := le.clean_npi_deactivation_date <> ri.clean_npi_deactivation_date;
    SELF.Diff_clean_npi_reactivation_date := le.clean_npi_reactivation_date <> ri.clean_npi_reactivation_date;
    SELF.Diff_clean_date_born := le.clean_date_born <> ri.clean_date_born;
    SELF.Diff_clean_date_died := le.clean_date_died <> ri.clean_date_died;
    SELF.Diff_clean_company_name := le.clean_company_name <> ri.clean_company_name;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dbpc := le.dbpc <> ri.dbpc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_fips_st := le.fips_st <> ri.fips_st;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_rawaid := le.rawaid <> ri.rawaid;
    SELF.Diff_aceaid := le.aceaid <> ri.aceaid;
    SELF.Diff_firm_name := le.firm_name <> ri.firm_name;
    SELF.Diff_lid := le.lid <> ri.lid;
    SELF.Diff_agid := le.agid <> ri.agid;
    SELF.Diff_address_std_code := le.address_std_code <> ri.address_std_code;
    SELF.Diff_latitude := le.latitude <> ri.latitude;
    SELF.Diff_longitude := le.longitude <> ri.longitude;
    SELF.Diff_prepped_addr1 := le.prepped_addr1 <> ri.prepped_addr1;
    SELF.Diff_prepped_addr2 := le.prepped_addr2 <> ri.prepped_addr2;
    SELF.Diff_addr_type := le.addr_type <> ri.addr_type;
    SELF.Diff_state_license_state := le.state_license_state <> ri.state_license_state;
    SELF.Diff_state_license_number := le.state_license_number <> ri.state_license_number;
    SELF.Diff_state_license_type := le.state_license_type <> ri.state_license_type;
    SELF.Diff_state_license_active := le.state_license_active <> ri.state_license_active;
    SELF.Diff_state_license_expire := le.state_license_expire <> ri.state_license_expire;
    SELF.Diff_state_license_qualifier := le.state_license_qualifier <> ri.state_license_qualifier;
    SELF.Diff_state_license_sub_qualifier := le.state_license_sub_qualifier <> ri.state_license_sub_qualifier;
    SELF.Diff_state_license_issued := le.state_license_issued <> ri.state_license_issued;
    SELF.Diff_clean_state_license_expire := le.clean_state_license_expire <> ri.clean_state_license_expire;
    SELF.Diff_clean_state_license_issued := le.clean_state_license_issued <> ri.clean_state_license_issued;
    SELF.Diff_dea_num := le.dea_num <> ri.dea_num;
    SELF.Diff_dea_bac := le.dea_bac <> ri.dea_bac;
    SELF.Diff_dea_sub_bac := le.dea_sub_bac <> ri.dea_sub_bac;
    SELF.Diff_dea_schedule := le.dea_schedule <> ri.dea_schedule;
    SELF.Diff_dea_expire := le.dea_expire <> ri.dea_expire;
    SELF.Diff_dea_active := le.dea_active <> ri.dea_active;
    SELF.Diff_clean_dea_expire := le.clean_dea_expire <> ri.clean_dea_expire;
    SELF.Diff_csr_number := le.csr_number <> ri.csr_number;
    SELF.Diff_csr_state := le.csr_state <> ri.csr_state;
    SELF.Diff_csr_expire_date := le.csr_expire_date <> ri.csr_expire_date;
    SELF.Diff_csr_issue_date := le.csr_issue_date <> ri.csr_issue_date;
    SELF.Diff_dsa_lvl_2 := le.dsa_lvl_2 <> ri.dsa_lvl_2;
    SELF.Diff_dsa_lvl_2n := le.dsa_lvl_2n <> ri.dsa_lvl_2n;
    SELF.Diff_dsa_lvl_3 := le.dsa_lvl_3 <> ri.dsa_lvl_3;
    SELF.Diff_dsa_lvl_3n := le.dsa_lvl_3n <> ri.dsa_lvl_3n;
    SELF.Diff_dsa_lvl_4 := le.dsa_lvl_4 <> ri.dsa_lvl_4;
    SELF.Diff_dsa_lvl_5 := le.dsa_lvl_5 <> ri.dsa_lvl_5;
    SELF.Diff_csr_raw1 := le.csr_raw1 <> ri.csr_raw1;
    SELF.Diff_csr_raw2 := le.csr_raw2 <> ri.csr_raw2;
    SELF.Diff_csr_raw3 := le.csr_raw3 <> ri.csr_raw3;
    SELF.Diff_csr_raw4 := le.csr_raw4 <> ri.csr_raw4;
    SELF.Diff_clean_csr_expire_date := le.clean_csr_expire_date <> ri.clean_csr_expire_date;
    SELF.Diff_clean_csr_issue_date := le.clean_csr_issue_date <> ri.clean_csr_issue_date;
    SELF.Diff_sanction_id := le.sanction_id <> ri.sanction_id;
    SELF.Diff_sanction_action_code := le.sanction_action_code <> ri.sanction_action_code;
    SELF.Diff_sanction_action_description := le.sanction_action_description <> ri.sanction_action_description;
    SELF.Diff_sanction_board_code := le.sanction_board_code <> ri.sanction_board_code;
    SELF.Diff_sanction_board_description := le.sanction_board_description <> ri.sanction_board_description;
    SELF.Diff_action_date := le.action_date <> ri.action_date;
    SELF.Diff_sanction_period_start_date := le.sanction_period_start_date <> ri.sanction_period_start_date;
    SELF.Diff_sanction_period_end_date := le.sanction_period_end_date <> ri.sanction_period_end_date;
    SELF.Diff_month_duration := le.month_duration <> ri.month_duration;
    SELF.Diff_fine_amount := le.fine_amount <> ri.fine_amount;
    SELF.Diff_offense_code := le.offense_code <> ri.offense_code;
    SELF.Diff_offense_description := le.offense_description <> ri.offense_description;
    SELF.Diff_offense_date := le.offense_date <> ri.offense_date;
    SELF.Diff_clean_offense_date := le.clean_offense_date <> ri.clean_offense_date;
    SELF.Diff_clean_action_date := le.clean_action_date <> ri.clean_action_date;
    SELF.Diff_clean_sanction_period_start_date := le.clean_sanction_period_start_date <> ri.clean_sanction_period_start_date;
    SELF.Diff_clean_sanction_period_end_date := le.clean_sanction_period_end_date <> ri.clean_sanction_period_end_date;
    SELF.Diff_gsa_sanction_id := le.gsa_sanction_id <> ri.gsa_sanction_id;
    SELF.Diff_gsa_first := le.gsa_first <> ri.gsa_first;
    SELF.Diff_gsa_middle := le.gsa_middle <> ri.gsa_middle;
    SELF.Diff_gsa_last := le.gsa_last <> ri.gsa_last;
    SELF.Diff_gsa_suffix := le.gsa_suffix <> ri.gsa_suffix;
    SELF.Diff_gsa_city := le.gsa_city <> ri.gsa_city;
    SELF.Diff_gsa_state := le.gsa_state <> ri.gsa_state;
    SELF.Diff_gsa_zip := le.gsa_zip <> ri.gsa_zip;
    SELF.Diff_date := le.date <> ri.date;
    SELF.Diff_agency := le.agency <> ri.agency;
    SELF.Diff_confidence := le.confidence <> ri.confidence;
    SELF.Diff_clean_gsa_first := le.clean_gsa_first <> ri.clean_gsa_first;
    SELF.Diff_clean_gsa_middle := le.clean_gsa_middle <> ri.clean_gsa_middle;
    SELF.Diff_clean_gsa_last := le.clean_gsa_last <> ri.clean_gsa_last;
    SELF.Diff_clean_gsa_suffix := le.clean_gsa_suffix <> ri.clean_gsa_suffix;
    SELF.Diff_clean_gsa_city := le.clean_gsa_city <> ri.clean_gsa_city;
    SELF.Diff_clean_gsa_state := le.clean_gsa_state <> ri.clean_gsa_state;
    SELF.Diff_clean_gsa_zip := le.clean_gsa_zip <> ri.clean_gsa_zip;
    SELF.Diff_clean_gsa_action_date := le.clean_gsa_action_date <> ri.clean_gsa_action_date;
    SELF.Diff_clean_gsa_date := le.clean_gsa_date <> ri.clean_gsa_date;
    SELF.Diff_fax := le.fax <> ri.fax;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_certification_code := le.certification_code <> ri.certification_code;
    SELF.Diff_certification_description := le.certification_description <> ri.certification_description;
    SELF.Diff_board_code := le.board_code <> ri.board_code;
    SELF.Diff_board_description := le.board_description <> ri.board_description;
    SELF.Diff_expiration_year := le.expiration_year <> ri.expiration_year;
    SELF.Diff_issue_year := le.issue_year <> ri.issue_year;
    SELF.Diff_renewal_year := le.renewal_year <> ri.renewal_year;
    SELF.Diff_lifetime_flag := le.lifetime_flag <> ri.lifetime_flag;
    SELF.Diff_covered_recipient_id := le.covered_recipient_id <> ri.covered_recipient_id;
    SELF.Diff_cov_rcp_raw_state_code := le.cov_rcp_raw_state_code <> ri.cov_rcp_raw_state_code;
    SELF.Diff_cov_rcp_raw_full_name := le.cov_rcp_raw_full_name <> ri.cov_rcp_raw_full_name;
    SELF.Diff_cov_rcp_raw_attribute1 := le.cov_rcp_raw_attribute1 <> ri.cov_rcp_raw_attribute1;
    SELF.Diff_cov_rcp_raw_attribute2 := le.cov_rcp_raw_attribute2 <> ri.cov_rcp_raw_attribute2;
    SELF.Diff_cov_rcp_raw_attribute3 := le.cov_rcp_raw_attribute3 <> ri.cov_rcp_raw_attribute3;
    SELF.Diff_cov_rcp_raw_attribute4 := le.cov_rcp_raw_attribute4 <> ri.cov_rcp_raw_attribute4;
    SELF.Diff_hms_scid := le.hms_scid <> ri.hms_scid;
    SELF.Diff_school_name := le.school_name <> ri.school_name;
    SELF.Diff_grad_year := le.grad_year <> ri.grad_year;
    SELF.Diff_lang_code := le.lang_code <> ri.lang_code;
    SELF.Diff_language := le.language <> ri.language;
    SELF.Diff_specialty_description := le.specialty_description <> ri.specialty_description;
    SELF.Diff_clean_phone := le.clean_phone <> ri.clean_phone;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_bdid_score := le.bdid_score <> ri.bdid_score;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_clean_dob := le.clean_dob <> ri.clean_dob;
    SELF.Diff_best_dob := le.best_dob <> ri.best_dob;
    SELF.Diff_best_ssn := le.best_ssn <> ri.best_ssn;
    SELF.Diff_rec_deactivated_date := le.rec_deactivated_date <> ri.rec_deactivated_date;
    SELF.Diff_superceeding_piid := le.superceeding_piid <> ri.superceeding_piid;
    SELF.Diff_dotid := le.dotid <> ri.dotid;
    SELF.Diff_dotscore := le.dotscore <> ri.dotscore;
    SELF.Diff_dotweight := le.dotweight <> ri.dotweight;
    SELF.Diff_empid := le.empid <> ri.empid;
    SELF.Diff_empscore := le.empscore <> ri.empscore;
    SELF.Diff_empweight := le.empweight <> ri.empweight;
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_powscore := le.powscore <> ri.powscore;
    SELF.Diff_powweight := le.powweight <> ri.powweight;
    SELF.Diff_proxid := le.proxid <> ri.proxid;
    SELF.Diff_proxscore := le.proxscore <> ri.proxscore;
    SELF.Diff_proxweight := le.proxweight <> ri.proxweight;
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_selescore := le.selescore <> ri.selescore;
    SELF.Diff_seleweight := le.seleweight <> ri.seleweight;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_orgscore := le.orgscore <> ri.orgscore;
    SELF.Diff_orgweight := le.orgweight <> ri.orgweight;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_ultscore := le.ultscore <> ri.ultscore;
    SELF.Diff_ultweight := le.ultweight <> ri.ultweight;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_hms_piid,1,0)+ IF( SELF.Diff_first,1,0)+ IF( SELF.Diff_middle,1,0)+ IF( SELF.Diff_last,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_cred,1,0)+ IF( SELF.Diff_practitioner_type,1,0)+ IF( SELF.Diff_active,1,0)+ IF( SELF.Diff_vendible,1,0)+ IF( SELF.Diff_npi_num,1,0)+ IF( SELF.Diff_npi_enumeration_date,1,0)+ IF( SELF.Diff_npi_deactivation_date,1,0)+ IF( SELF.Diff_npi_reactivation_date,1,0)+ IF( SELF.Diff_npi_taxonomy_code,1,0)+ IF( SELF.Diff_upin,1,0)+ IF( SELF.Diff_medicare_participation_flag,1,0)+ IF( SELF.Diff_date_born,1,0)+ IF( SELF.Diff_date_died,1,0)+ IF( SELF.Diff_pid,1,0)+ IF( SELF.Diff_src,1,0)+ IF( SELF.Diff_date_vendor_first_reported,1,0)+ IF( SELF.Diff_date_vendor_last_reported,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_source_rid,1,0)+ IF( SELF.Diff_lnpid,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_nametype,1,0)+ IF( SELF.Diff_nid,1,0)+ IF( SELF.Diff_clean_npi_enumeration_date,1,0)+ IF( SELF.Diff_clean_npi_deactivation_date,1,0)+ IF( SELF.Diff_clean_npi_reactivation_date,1,0)+ IF( SELF.Diff_clean_date_born,1,0)+ IF( SELF.Diff_clean_date_died,1,0)+ IF( SELF.Diff_clean_company_name,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_fips_st,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_rawaid,1,0)+ IF( SELF.Diff_aceaid,1,0)+ IF( SELF.Diff_firm_name,1,0)+ IF( SELF.Diff_lid,1,0)+ IF( SELF.Diff_agid,1,0)+ IF( SELF.Diff_address_std_code,1,0)+ IF( SELF.Diff_latitude,1,0)+ IF( SELF.Diff_longitude,1,0)+ IF( SELF.Diff_prepped_addr1,1,0)+ IF( SELF.Diff_prepped_addr2,1,0)+ IF( SELF.Diff_addr_type,1,0)+ IF( SELF.Diff_state_license_state,1,0)+ IF( SELF.Diff_state_license_number,1,0)+ IF( SELF.Diff_state_license_type,1,0)+ IF( SELF.Diff_state_license_active,1,0)+ IF( SELF.Diff_state_license_expire,1,0)+ IF( SELF.Diff_state_license_qualifier,1,0)+ IF( SELF.Diff_state_license_sub_qualifier,1,0)+ IF( SELF.Diff_state_license_issued,1,0)+ IF( SELF.Diff_clean_state_license_expire,1,0)+ IF( SELF.Diff_clean_state_license_issued,1,0)+ IF( SELF.Diff_dea_num,1,0)+ IF( SELF.Diff_dea_bac,1,0)+ IF( SELF.Diff_dea_sub_bac,1,0)+ IF( SELF.Diff_dea_schedule,1,0)+ IF( SELF.Diff_dea_expire,1,0)+ IF( SELF.Diff_dea_active,1,0)+ IF( SELF.Diff_clean_dea_expire,1,0)+ IF( SELF.Diff_csr_number,1,0)+ IF( SELF.Diff_csr_state,1,0)+ IF( SELF.Diff_csr_expire_date,1,0)+ IF( SELF.Diff_csr_issue_date,1,0)+ IF( SELF.Diff_dsa_lvl_2,1,0)+ IF( SELF.Diff_dsa_lvl_2n,1,0)+ IF( SELF.Diff_dsa_lvl_3,1,0)+ IF( SELF.Diff_dsa_lvl_3n,1,0)+ IF( SELF.Diff_dsa_lvl_4,1,0)+ IF( SELF.Diff_dsa_lvl_5,1,0)+ IF( SELF.Diff_csr_raw1,1,0)+ IF( SELF.Diff_csr_raw2,1,0)+ IF( SELF.Diff_csr_raw3,1,0)+ IF( SELF.Diff_csr_raw4,1,0)+ IF( SELF.Diff_clean_csr_expire_date,1,0)+ IF( SELF.Diff_clean_csr_issue_date,1,0)+ IF( SELF.Diff_sanction_id,1,0)+ IF( SELF.Diff_sanction_action_code,1,0)+ IF( SELF.Diff_sanction_action_description,1,0)+ IF( SELF.Diff_sanction_board_code,1,0)+ IF( SELF.Diff_sanction_board_description,1,0)+ IF( SELF.Diff_action_date,1,0)+ IF( SELF.Diff_sanction_period_start_date,1,0)+ IF( SELF.Diff_sanction_period_end_date,1,0)+ IF( SELF.Diff_month_duration,1,0)+ IF( SELF.Diff_fine_amount,1,0)+ IF( SELF.Diff_offense_code,1,0)+ IF( SELF.Diff_offense_description,1,0)+ IF( SELF.Diff_offense_date,1,0)+ IF( SELF.Diff_clean_offense_date,1,0)+ IF( SELF.Diff_clean_action_date,1,0)+ IF( SELF.Diff_clean_sanction_period_start_date,1,0)+ IF( SELF.Diff_clean_sanction_period_end_date,1,0)+ IF( SELF.Diff_gsa_sanction_id,1,0)+ IF( SELF.Diff_gsa_first,1,0)+ IF( SELF.Diff_gsa_middle,1,0)+ IF( SELF.Diff_gsa_last,1,0)+ IF( SELF.Diff_gsa_suffix,1,0)+ IF( SELF.Diff_gsa_city,1,0)+ IF( SELF.Diff_gsa_state,1,0)+ IF( SELF.Diff_gsa_zip,1,0)+ IF( SELF.Diff_date,1,0)+ IF( SELF.Diff_agency,1,0)+ IF( SELF.Diff_confidence,1,0)+ IF( SELF.Diff_clean_gsa_first,1,0)+ IF( SELF.Diff_clean_gsa_middle,1,0)+ IF( SELF.Diff_clean_gsa_last,1,0)+ IF( SELF.Diff_clean_gsa_suffix,1,0)+ IF( SELF.Diff_clean_gsa_city,1,0)+ IF( SELF.Diff_clean_gsa_state,1,0)+ IF( SELF.Diff_clean_gsa_zip,1,0)+ IF( SELF.Diff_clean_gsa_action_date,1,0)+ IF( SELF.Diff_clean_gsa_date,1,0)+ IF( SELF.Diff_fax,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_certification_code,1,0)+ IF( SELF.Diff_certification_description,1,0)+ IF( SELF.Diff_board_code,1,0)+ IF( SELF.Diff_board_description,1,0)+ IF( SELF.Diff_expiration_year,1,0)+ IF( SELF.Diff_issue_year,1,0)+ IF( SELF.Diff_renewal_year,1,0)+ IF( SELF.Diff_lifetime_flag,1,0)+ IF( SELF.Diff_covered_recipient_id,1,0)+ IF( SELF.Diff_cov_rcp_raw_state_code,1,0)+ IF( SELF.Diff_cov_rcp_raw_full_name,1,0)+ IF( SELF.Diff_cov_rcp_raw_attribute1,1,0)+ IF( SELF.Diff_cov_rcp_raw_attribute2,1,0)+ IF( SELF.Diff_cov_rcp_raw_attribute3,1,0)+ IF( SELF.Diff_cov_rcp_raw_attribute4,1,0)+ IF( SELF.Diff_hms_scid,1,0)+ IF( SELF.Diff_school_name,1,0)+ IF( SELF.Diff_grad_year,1,0)+ IF( SELF.Diff_lang_code,1,0)+ IF( SELF.Diff_language,1,0)+ IF( SELF.Diff_specialty_description,1,0)+ IF( SELF.Diff_clean_phone,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_bdid_score,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_clean_dob,1,0)+ IF( SELF.Diff_best_dob,1,0)+ IF( SELF.Diff_best_ssn,1,0)+ IF( SELF.Diff_rec_deactivated_date,1,0)+ IF( SELF.Diff_superceeding_piid,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0);
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
    Count_Diff_hms_piid := COUNT(GROUP,%Closest%.Diff_hms_piid);
    Count_Diff_first := COUNT(GROUP,%Closest%.Diff_first);
    Count_Diff_middle := COUNT(GROUP,%Closest%.Diff_middle);
    Count_Diff_last := COUNT(GROUP,%Closest%.Diff_last);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_cred := COUNT(GROUP,%Closest%.Diff_cred);
    Count_Diff_practitioner_type := COUNT(GROUP,%Closest%.Diff_practitioner_type);
    Count_Diff_active := COUNT(GROUP,%Closest%.Diff_active);
    Count_Diff_vendible := COUNT(GROUP,%Closest%.Diff_vendible);
    Count_Diff_npi_num := COUNT(GROUP,%Closest%.Diff_npi_num);
    Count_Diff_npi_enumeration_date := COUNT(GROUP,%Closest%.Diff_npi_enumeration_date);
    Count_Diff_npi_deactivation_date := COUNT(GROUP,%Closest%.Diff_npi_deactivation_date);
    Count_Diff_npi_reactivation_date := COUNT(GROUP,%Closest%.Diff_npi_reactivation_date);
    Count_Diff_npi_taxonomy_code := COUNT(GROUP,%Closest%.Diff_npi_taxonomy_code);
    Count_Diff_upin := COUNT(GROUP,%Closest%.Diff_upin);
    Count_Diff_medicare_participation_flag := COUNT(GROUP,%Closest%.Diff_medicare_participation_flag);
    Count_Diff_date_born := COUNT(GROUP,%Closest%.Diff_date_born);
    Count_Diff_date_died := COUNT(GROUP,%Closest%.Diff_date_died);
    Count_Diff_pid := COUNT(GROUP,%Closest%.Diff_pid);
    Count_Diff_src := COUNT(GROUP,%Closest%.Diff_src);
    Count_Diff_date_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_first_reported);
    Count_Diff_date_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_last_reported);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_source_rid := COUNT(GROUP,%Closest%.Diff_source_rid);
    Count_Diff_lnpid := COUNT(GROUP,%Closest%.Diff_lnpid);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_nametype := COUNT(GROUP,%Closest%.Diff_nametype);
    Count_Diff_nid := COUNT(GROUP,%Closest%.Diff_nid);
    Count_Diff_clean_npi_enumeration_date := COUNT(GROUP,%Closest%.Diff_clean_npi_enumeration_date);
    Count_Diff_clean_npi_deactivation_date := COUNT(GROUP,%Closest%.Diff_clean_npi_deactivation_date);
    Count_Diff_clean_npi_reactivation_date := COUNT(GROUP,%Closest%.Diff_clean_npi_reactivation_date);
    Count_Diff_clean_date_born := COUNT(GROUP,%Closest%.Diff_clean_date_born);
    Count_Diff_clean_date_died := COUNT(GROUP,%Closest%.Diff_clean_date_died);
    Count_Diff_clean_company_name := COUNT(GROUP,%Closest%.Diff_clean_company_name);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dbpc := COUNT(GROUP,%Closest%.Diff_dbpc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_fips_st := COUNT(GROUP,%Closest%.Diff_fips_st);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_rawaid := COUNT(GROUP,%Closest%.Diff_rawaid);
    Count_Diff_aceaid := COUNT(GROUP,%Closest%.Diff_aceaid);
    Count_Diff_firm_name := COUNT(GROUP,%Closest%.Diff_firm_name);
    Count_Diff_lid := COUNT(GROUP,%Closest%.Diff_lid);
    Count_Diff_agid := COUNT(GROUP,%Closest%.Diff_agid);
    Count_Diff_address_std_code := COUNT(GROUP,%Closest%.Diff_address_std_code);
    Count_Diff_latitude := COUNT(GROUP,%Closest%.Diff_latitude);
    Count_Diff_longitude := COUNT(GROUP,%Closest%.Diff_longitude);
    Count_Diff_prepped_addr1 := COUNT(GROUP,%Closest%.Diff_prepped_addr1);
    Count_Diff_prepped_addr2 := COUNT(GROUP,%Closest%.Diff_prepped_addr2);
    Count_Diff_addr_type := COUNT(GROUP,%Closest%.Diff_addr_type);
    Count_Diff_state_license_state := COUNT(GROUP,%Closest%.Diff_state_license_state);
    Count_Diff_state_license_number := COUNT(GROUP,%Closest%.Diff_state_license_number);
    Count_Diff_state_license_type := COUNT(GROUP,%Closest%.Diff_state_license_type);
    Count_Diff_state_license_active := COUNT(GROUP,%Closest%.Diff_state_license_active);
    Count_Diff_state_license_expire := COUNT(GROUP,%Closest%.Diff_state_license_expire);
    Count_Diff_state_license_qualifier := COUNT(GROUP,%Closest%.Diff_state_license_qualifier);
    Count_Diff_state_license_sub_qualifier := COUNT(GROUP,%Closest%.Diff_state_license_sub_qualifier);
    Count_Diff_state_license_issued := COUNT(GROUP,%Closest%.Diff_state_license_issued);
    Count_Diff_clean_state_license_expire := COUNT(GROUP,%Closest%.Diff_clean_state_license_expire);
    Count_Diff_clean_state_license_issued := COUNT(GROUP,%Closest%.Diff_clean_state_license_issued);
    Count_Diff_dea_num := COUNT(GROUP,%Closest%.Diff_dea_num);
    Count_Diff_dea_bac := COUNT(GROUP,%Closest%.Diff_dea_bac);
    Count_Diff_dea_sub_bac := COUNT(GROUP,%Closest%.Diff_dea_sub_bac);
    Count_Diff_dea_schedule := COUNT(GROUP,%Closest%.Diff_dea_schedule);
    Count_Diff_dea_expire := COUNT(GROUP,%Closest%.Diff_dea_expire);
    Count_Diff_dea_active := COUNT(GROUP,%Closest%.Diff_dea_active);
    Count_Diff_clean_dea_expire := COUNT(GROUP,%Closest%.Diff_clean_dea_expire);
    Count_Diff_csr_number := COUNT(GROUP,%Closest%.Diff_csr_number);
    Count_Diff_csr_state := COUNT(GROUP,%Closest%.Diff_csr_state);
    Count_Diff_csr_expire_date := COUNT(GROUP,%Closest%.Diff_csr_expire_date);
    Count_Diff_csr_issue_date := COUNT(GROUP,%Closest%.Diff_csr_issue_date);
    Count_Diff_dsa_lvl_2 := COUNT(GROUP,%Closest%.Diff_dsa_lvl_2);
    Count_Diff_dsa_lvl_2n := COUNT(GROUP,%Closest%.Diff_dsa_lvl_2n);
    Count_Diff_dsa_lvl_3 := COUNT(GROUP,%Closest%.Diff_dsa_lvl_3);
    Count_Diff_dsa_lvl_3n := COUNT(GROUP,%Closest%.Diff_dsa_lvl_3n);
    Count_Diff_dsa_lvl_4 := COUNT(GROUP,%Closest%.Diff_dsa_lvl_4);
    Count_Diff_dsa_lvl_5 := COUNT(GROUP,%Closest%.Diff_dsa_lvl_5);
    Count_Diff_csr_raw1 := COUNT(GROUP,%Closest%.Diff_csr_raw1);
    Count_Diff_csr_raw2 := COUNT(GROUP,%Closest%.Diff_csr_raw2);
    Count_Diff_csr_raw3 := COUNT(GROUP,%Closest%.Diff_csr_raw3);
    Count_Diff_csr_raw4 := COUNT(GROUP,%Closest%.Diff_csr_raw4);
    Count_Diff_clean_csr_expire_date := COUNT(GROUP,%Closest%.Diff_clean_csr_expire_date);
    Count_Diff_clean_csr_issue_date := COUNT(GROUP,%Closest%.Diff_clean_csr_issue_date);
    Count_Diff_sanction_id := COUNT(GROUP,%Closest%.Diff_sanction_id);
    Count_Diff_sanction_action_code := COUNT(GROUP,%Closest%.Diff_sanction_action_code);
    Count_Diff_sanction_action_description := COUNT(GROUP,%Closest%.Diff_sanction_action_description);
    Count_Diff_sanction_board_code := COUNT(GROUP,%Closest%.Diff_sanction_board_code);
    Count_Diff_sanction_board_description := COUNT(GROUP,%Closest%.Diff_sanction_board_description);
    Count_Diff_action_date := COUNT(GROUP,%Closest%.Diff_action_date);
    Count_Diff_sanction_period_start_date := COUNT(GROUP,%Closest%.Diff_sanction_period_start_date);
    Count_Diff_sanction_period_end_date := COUNT(GROUP,%Closest%.Diff_sanction_period_end_date);
    Count_Diff_month_duration := COUNT(GROUP,%Closest%.Diff_month_duration);
    Count_Diff_fine_amount := COUNT(GROUP,%Closest%.Diff_fine_amount);
    Count_Diff_offense_code := COUNT(GROUP,%Closest%.Diff_offense_code);
    Count_Diff_offense_description := COUNT(GROUP,%Closest%.Diff_offense_description);
    Count_Diff_offense_date := COUNT(GROUP,%Closest%.Diff_offense_date);
    Count_Diff_clean_offense_date := COUNT(GROUP,%Closest%.Diff_clean_offense_date);
    Count_Diff_clean_action_date := COUNT(GROUP,%Closest%.Diff_clean_action_date);
    Count_Diff_clean_sanction_period_start_date := COUNT(GROUP,%Closest%.Diff_clean_sanction_period_start_date);
    Count_Diff_clean_sanction_period_end_date := COUNT(GROUP,%Closest%.Diff_clean_sanction_period_end_date);
    Count_Diff_gsa_sanction_id := COUNT(GROUP,%Closest%.Diff_gsa_sanction_id);
    Count_Diff_gsa_first := COUNT(GROUP,%Closest%.Diff_gsa_first);
    Count_Diff_gsa_middle := COUNT(GROUP,%Closest%.Diff_gsa_middle);
    Count_Diff_gsa_last := COUNT(GROUP,%Closest%.Diff_gsa_last);
    Count_Diff_gsa_suffix := COUNT(GROUP,%Closest%.Diff_gsa_suffix);
    Count_Diff_gsa_city := COUNT(GROUP,%Closest%.Diff_gsa_city);
    Count_Diff_gsa_state := COUNT(GROUP,%Closest%.Diff_gsa_state);
    Count_Diff_gsa_zip := COUNT(GROUP,%Closest%.Diff_gsa_zip);
    Count_Diff_date := COUNT(GROUP,%Closest%.Diff_date);
    Count_Diff_agency := COUNT(GROUP,%Closest%.Diff_agency);
    Count_Diff_confidence := COUNT(GROUP,%Closest%.Diff_confidence);
    Count_Diff_clean_gsa_first := COUNT(GROUP,%Closest%.Diff_clean_gsa_first);
    Count_Diff_clean_gsa_middle := COUNT(GROUP,%Closest%.Diff_clean_gsa_middle);
    Count_Diff_clean_gsa_last := COUNT(GROUP,%Closest%.Diff_clean_gsa_last);
    Count_Diff_clean_gsa_suffix := COUNT(GROUP,%Closest%.Diff_clean_gsa_suffix);
    Count_Diff_clean_gsa_city := COUNT(GROUP,%Closest%.Diff_clean_gsa_city);
    Count_Diff_clean_gsa_state := COUNT(GROUP,%Closest%.Diff_clean_gsa_state);
    Count_Diff_clean_gsa_zip := COUNT(GROUP,%Closest%.Diff_clean_gsa_zip);
    Count_Diff_clean_gsa_action_date := COUNT(GROUP,%Closest%.Diff_clean_gsa_action_date);
    Count_Diff_clean_gsa_date := COUNT(GROUP,%Closest%.Diff_clean_gsa_date);
    Count_Diff_fax := COUNT(GROUP,%Closest%.Diff_fax);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_certification_code := COUNT(GROUP,%Closest%.Diff_certification_code);
    Count_Diff_certification_description := COUNT(GROUP,%Closest%.Diff_certification_description);
    Count_Diff_board_code := COUNT(GROUP,%Closest%.Diff_board_code);
    Count_Diff_board_description := COUNT(GROUP,%Closest%.Diff_board_description);
    Count_Diff_expiration_year := COUNT(GROUP,%Closest%.Diff_expiration_year);
    Count_Diff_issue_year := COUNT(GROUP,%Closest%.Diff_issue_year);
    Count_Diff_renewal_year := COUNT(GROUP,%Closest%.Diff_renewal_year);
    Count_Diff_lifetime_flag := COUNT(GROUP,%Closest%.Diff_lifetime_flag);
    Count_Diff_covered_recipient_id := COUNT(GROUP,%Closest%.Diff_covered_recipient_id);
    Count_Diff_cov_rcp_raw_state_code := COUNT(GROUP,%Closest%.Diff_cov_rcp_raw_state_code);
    Count_Diff_cov_rcp_raw_full_name := COUNT(GROUP,%Closest%.Diff_cov_rcp_raw_full_name);
    Count_Diff_cov_rcp_raw_attribute1 := COUNT(GROUP,%Closest%.Diff_cov_rcp_raw_attribute1);
    Count_Diff_cov_rcp_raw_attribute2 := COUNT(GROUP,%Closest%.Diff_cov_rcp_raw_attribute2);
    Count_Diff_cov_rcp_raw_attribute3 := COUNT(GROUP,%Closest%.Diff_cov_rcp_raw_attribute3);
    Count_Diff_cov_rcp_raw_attribute4 := COUNT(GROUP,%Closest%.Diff_cov_rcp_raw_attribute4);
    Count_Diff_hms_scid := COUNT(GROUP,%Closest%.Diff_hms_scid);
    Count_Diff_school_name := COUNT(GROUP,%Closest%.Diff_school_name);
    Count_Diff_grad_year := COUNT(GROUP,%Closest%.Diff_grad_year);
    Count_Diff_lang_code := COUNT(GROUP,%Closest%.Diff_lang_code);
    Count_Diff_language := COUNT(GROUP,%Closest%.Diff_language);
    Count_Diff_specialty_description := COUNT(GROUP,%Closest%.Diff_specialty_description);
    Count_Diff_clean_phone := COUNT(GROUP,%Closest%.Diff_clean_phone);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_bdid_score := COUNT(GROUP,%Closest%.Diff_bdid_score);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_clean_dob := COUNT(GROUP,%Closest%.Diff_clean_dob);
    Count_Diff_best_dob := COUNT(GROUP,%Closest%.Diff_best_dob);
    Count_Diff_best_ssn := COUNT(GROUP,%Closest%.Diff_best_ssn);
    Count_Diff_rec_deactivated_date := COUNT(GROUP,%Closest%.Diff_rec_deactivated_date);
    Count_Diff_superceeding_piid := COUNT(GROUP,%Closest%.Diff_superceeding_piid);
    Count_Diff_dotid := COUNT(GROUP,%Closest%.Diff_dotid);
    Count_Diff_dotscore := COUNT(GROUP,%Closest%.Diff_dotscore);
    Count_Diff_dotweight := COUNT(GROUP,%Closest%.Diff_dotweight);
    Count_Diff_empid := COUNT(GROUP,%Closest%.Diff_empid);
    Count_Diff_empscore := COUNT(GROUP,%Closest%.Diff_empscore);
    Count_Diff_empweight := COUNT(GROUP,%Closest%.Diff_empweight);
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_powscore := COUNT(GROUP,%Closest%.Diff_powscore);
    Count_Diff_powweight := COUNT(GROUP,%Closest%.Diff_powweight);
    Count_Diff_proxid := COUNT(GROUP,%Closest%.Diff_proxid);
    Count_Diff_proxscore := COUNT(GROUP,%Closest%.Diff_proxscore);
    Count_Diff_proxweight := COUNT(GROUP,%Closest%.Diff_proxweight);
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_selescore := COUNT(GROUP,%Closest%.Diff_selescore);
    Count_Diff_seleweight := COUNT(GROUP,%Closest%.Diff_seleweight);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_orgscore := COUNT(GROUP,%Closest%.Diff_orgscore);
    Count_Diff_orgweight := COUNT(GROUP,%Closest%.Diff_orgweight);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_ultscore := COUNT(GROUP,%Closest%.Diff_ultscore);
    Count_Diff_ultweight := COUNT(GROUP,%Closest%.Diff_ultweight);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
