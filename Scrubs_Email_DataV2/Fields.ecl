IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 106;
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'clean_email','append_email_username','append_domain','append_domain_type','append_domain_root','append_domain_ext','append_is_tld_state','append_is_tld_generic','append_is_tld_country','append_is_valid_domain_ext','email_rec_key','email_src','orig_pmghousehold_id','orig_pmgindividual_id','orig_first_name','orig_last_name','orig_middle_name','orig_name_suffix','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_email','orig_ip','orig_login_date','orig_site','orig_e360_id','orig_teramedia_id','orig_phone','orig_ssn','orig_dob','did','did_score','did_type','hhid','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','append_rawaid','clean_phone','clean_ssn','clean_dob','process_date','activecode','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','current_rec','orig_companyname','cln_companyname','companytitle','rules','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','global_sid','record_sid');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'clean_email','append_email_username','append_domain','append_domain_type','append_domain_root','append_domain_ext','append_is_tld_state','append_is_tld_generic','append_is_tld_country','append_is_valid_domain_ext','email_rec_key','email_src','orig_pmghousehold_id','orig_pmgindividual_id','orig_first_name','orig_last_name','orig_middle_name','orig_name_suffix','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_email','orig_ip','orig_login_date','orig_site','orig_e360_id','orig_teramedia_id','orig_phone','orig_ssn','orig_dob','did','did_score','did_type','hhid','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','append_rawaid','clean_phone','clean_ssn','clean_dob','process_date','activecode','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','current_rec','orig_companyname','cln_companyname','companytitle','rules','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','global_sid','record_sid');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'clean_email' => 0,'append_email_username' => 1,'append_domain' => 2,'append_domain_type' => 3,'append_domain_root' => 4,'append_domain_ext' => 5,'append_is_tld_state' => 6,'append_is_tld_generic' => 7,'append_is_tld_country' => 8,'append_is_valid_domain_ext' => 9,'email_rec_key' => 10,'email_src' => 11,'orig_pmghousehold_id' => 12,'orig_pmgindividual_id' => 13,'orig_first_name' => 14,'orig_last_name' => 15,'orig_middle_name' => 16,'orig_name_suffix' => 17,'orig_address' => 18,'orig_city' => 19,'orig_state' => 20,'orig_zip' => 21,'orig_zip4' => 22,'orig_email' => 23,'orig_ip' => 24,'orig_login_date' => 25,'orig_site' => 26,'orig_e360_id' => 27,'orig_teramedia_id' => 28,'orig_phone' => 29,'orig_ssn' => 30,'orig_dob' => 31,'did' => 32,'did_score' => 33,'did_type' => 34,'hhid' => 35,'title' => 36,'fname' => 37,'mname' => 38,'lname' => 39,'name_suffix' => 40,'name_score' => 41,'prim_range' => 42,'predir' => 43,'prim_name' => 44,'addr_suffix' => 45,'postdir' => 46,'unit_desig' => 47,'sec_range' => 48,'p_city_name' => 49,'v_city_name' => 50,'st' => 51,'zip' => 52,'zip4' => 53,'cart' => 54,'cr_sort_sz' => 55,'lot' => 56,'lot_order' => 57,'dbpc' => 58,'chk_digit' => 59,'rec_type' => 60,'county' => 61,'geo_lat' => 62,'geo_long' => 63,'msa' => 64,'geo_blk' => 65,'geo_match' => 66,'err_stat' => 67,'append_rawaid' => 68,'clean_phone' => 69,'clean_ssn' => 70,'clean_dob' => 71,'process_date' => 72,'activecode' => 73,'date_first_seen' => 74,'date_last_seen' => 75,'date_vendor_first_reported' => 76,'date_vendor_last_reported' => 77,'current_rec' => 78,'orig_companyname' => 79,'cln_companyname' => 80,'companytitle' => 81,'rules' => 82,'dotid' => 83,'dotscore' => 84,'dotweight' => 85,'empid' => 86,'empscore' => 87,'empweight' => 88,'powid' => 89,'powscore' => 90,'powweight' => 91,'proxid' => 92,'proxscore' => 93,'proxweight' => 94,'seleid' => 95,'selescore' => 96,'seleweight' => 97,'orgid' => 98,'orgscore' => 99,'orgweight' => 100,'ultid' => 101,'ultscore' => 102,'ultweight' => 103,'global_sid' => 104,'record_sid' => 105,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_clean_email(SALT311.StrType s0) := s0;
EXPORT InValid_clean_email(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_email(UNSIGNED1 wh) := '';
 
EXPORT Make_append_email_username(SALT311.StrType s0) := s0;
EXPORT InValid_append_email_username(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_email_username(UNSIGNED1 wh) := '';
 
EXPORT Make_append_domain(SALT311.StrType s0) := s0;
EXPORT InValid_append_domain(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_domain(UNSIGNED1 wh) := '';
 
EXPORT Make_append_domain_type(SALT311.StrType s0) := s0;
EXPORT InValid_append_domain_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_domain_type(UNSIGNED1 wh) := '';
 
EXPORT Make_append_domain_root(SALT311.StrType s0) := s0;
EXPORT InValid_append_domain_root(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_domain_root(UNSIGNED1 wh) := '';
 
EXPORT Make_append_domain_ext(SALT311.StrType s0) := s0;
EXPORT InValid_append_domain_ext(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_domain_ext(UNSIGNED1 wh) := '';
 
EXPORT Make_append_is_tld_state(SALT311.StrType s0) := s0;
EXPORT InValid_append_is_tld_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_is_tld_state(UNSIGNED1 wh) := '';
 
EXPORT Make_append_is_tld_generic(SALT311.StrType s0) := s0;
EXPORT InValid_append_is_tld_generic(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_is_tld_generic(UNSIGNED1 wh) := '';
 
EXPORT Make_append_is_tld_country(SALT311.StrType s0) := s0;
EXPORT InValid_append_is_tld_country(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_is_tld_country(UNSIGNED1 wh) := '';
 
EXPORT Make_append_is_valid_domain_ext(SALT311.StrType s0) := s0;
EXPORT InValid_append_is_valid_domain_ext(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_is_valid_domain_ext(UNSIGNED1 wh) := '';
 
EXPORT Make_email_rec_key(SALT311.StrType s0) := s0;
EXPORT InValid_email_rec_key(SALT311.StrType s) := 0;
EXPORT InValidMessage_email_rec_key(UNSIGNED1 wh) := '';
 
EXPORT Make_email_src(SALT311.StrType s0) := s0;
EXPORT InValid_email_src(SALT311.StrType s) := 0;
EXPORT InValidMessage_email_src(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_pmghousehold_id(SALT311.StrType s0) := s0;
EXPORT InValid_orig_pmghousehold_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_pmghousehold_id(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_pmgindividual_id(SALT311.StrType s0) := s0;
EXPORT InValid_orig_pmgindividual_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_pmgindividual_id(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_first_name(SALT311.StrType s0) := s0;
EXPORT InValid_orig_first_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_last_name(SALT311.StrType s0) := s0;
EXPORT InValid_orig_last_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_last_name(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_middle_name(SALT311.StrType s0) := s0;
EXPORT InValid_orig_middle_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_middle_name(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_name_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_orig_name_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_address(SALT311.StrType s0) := s0;
EXPORT InValid_orig_address(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_address(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_city(SALT311.StrType s0) := s0;
EXPORT InValid_orig_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_state(SALT311.StrType s0) := s0;
EXPORT InValid_orig_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_zip(SALT311.StrType s0) := s0;
EXPORT InValid_orig_zip(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_zip4(SALT311.StrType s0) := s0;
EXPORT InValid_orig_zip4(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_email(SALT311.StrType s0) := s0;
EXPORT InValid_orig_email(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_email(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_ip(SALT311.StrType s0) := s0;
EXPORT InValid_orig_ip(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_ip(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_login_date(SALT311.StrType s0) := s0;
EXPORT InValid_orig_login_date(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_login_date(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_site(SALT311.StrType s0) := s0;
EXPORT InValid_orig_site(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_site(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_e360_id(SALT311.StrType s0) := s0;
EXPORT InValid_orig_e360_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_e360_id(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_teramedia_id(SALT311.StrType s0) := s0;
EXPORT InValid_orig_teramedia_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_teramedia_id(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_phone(SALT311.StrType s0) := s0;
EXPORT InValid_orig_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_ssn(SALT311.StrType s0) := s0;
EXPORT InValid_orig_ssn(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_dob(SALT311.StrType s0) := s0;
EXPORT InValid_orig_dob(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_dob(UNSIGNED1 wh) := '';
 
EXPORT Make_did(SALT311.StrType s0) := s0;
EXPORT InValid_did(SALT311.StrType s) := 0;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
 
EXPORT Make_did_score(SALT311.StrType s0) := s0;
EXPORT InValid_did_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := '';
 
EXPORT Make_did_type(SALT311.StrType s0) := s0;
EXPORT InValid_did_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_did_type(UNSIGNED1 wh) := '';
 
EXPORT Make_hhid(SALT311.StrType s0) := s0;
EXPORT InValid_hhid(SALT311.StrType s) := 0;
EXPORT InValidMessage_hhid(UNSIGNED1 wh) := '';
 
EXPORT Make_title(SALT311.StrType s0) := s0;
EXPORT InValid_title(SALT311.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT311.StrType s0) := s0;
EXPORT InValid_fname(SALT311.StrType s) := 0;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT311.StrType s0) := s0;
EXPORT InValid_mname(SALT311.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT311.StrType s0) := s0;
EXPORT InValid_lname(SALT311.StrType s) := 0;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_name_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_name_score(SALT311.StrType s0) := s0;
EXPORT InValid_name_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT311.StrType s0) := s0;
EXPORT InValid_prim_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT311.StrType s0) := s0;
EXPORT InValid_predir(SALT311.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT311.StrType s0) := s0;
EXPORT InValid_prim_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT311.StrType s0) := s0;
EXPORT InValid_postdir(SALT311.StrType s) := 0;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig(SALT311.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT311.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT311.StrType s0) := s0;
EXPORT InValid_sec_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT311.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT311.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT311.StrType s0) := s0;
EXPORT InValid_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT311.StrType s0) := s0;
EXPORT InValid_zip(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_zip4(SALT311.StrType s0) := s0;
EXPORT InValid_zip4(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_cart(SALT311.StrType s0) := s0;
EXPORT InValid_cart(SALT311.StrType s) := 0;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_cr_sort_sz(SALT311.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT311.StrType s) := 0;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_lot(SALT311.StrType s0) := s0;
EXPORT InValid_lot(SALT311.StrType s) := 0;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_order(SALT311.StrType s0) := s0;
EXPORT InValid_lot_order(SALT311.StrType s) := 0;
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_dbpc(SALT311.StrType s0) := s0;
EXPORT InValid_dbpc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT311.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT311.StrType s) := 0;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_type(SALT311.StrType s0) := s0;
EXPORT InValid_rec_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_county(SALT311.StrType s0) := s0;
EXPORT InValid_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_lat(SALT311.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_long(SALT311.StrType s0) := s0;
EXPORT InValid_geo_long(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_msa(SALT311.StrType s0) := s0;
EXPORT InValid_msa(SALT311.StrType s) := 0;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_blk(SALT311.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match(SALT311.StrType s0) := s0;
EXPORT InValid_geo_match(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_err_stat(SALT311.StrType s0) := s0;
EXPORT InValid_err_stat(SALT311.StrType s) := 0;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_append_rawaid(SALT311.StrType s0) := s0;
EXPORT InValid_append_rawaid(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_rawaid(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_phone(SALT311.StrType s0) := s0;
EXPORT InValid_clean_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_ssn(SALT311.StrType s0) := s0;
EXPORT InValid_clean_ssn(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_dob(SALT311.StrType s0) := s0;
EXPORT InValid_clean_dob(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_dob(UNSIGNED1 wh) := '';
 
EXPORT Make_process_date(SALT311.StrType s0) := s0;
EXPORT InValid_process_date(SALT311.StrType s) := 0;
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := '';
 
EXPORT Make_activecode(SALT311.StrType s0) := s0;
EXPORT InValid_activecode(SALT311.StrType s) := 0;
EXPORT InValidMessage_activecode(UNSIGNED1 wh) := '';
 
EXPORT Make_date_first_seen(SALT311.StrType s0) := s0;
EXPORT InValid_date_first_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_date_last_seen(SALT311.StrType s0) := s0;
EXPORT InValid_date_last_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_date_vendor_first_reported(SALT311.StrType s0) := s0;
EXPORT InValid_date_vendor_first_reported(SALT311.StrType s) := 0;
EXPORT InValidMessage_date_vendor_first_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_date_vendor_last_reported(SALT311.StrType s0) := s0;
EXPORT InValid_date_vendor_last_reported(SALT311.StrType s) := 0;
EXPORT InValidMessage_date_vendor_last_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_current_rec(SALT311.StrType s0) := s0;
EXPORT InValid_current_rec(SALT311.StrType s) := 0;
EXPORT InValidMessage_current_rec(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_companyname(SALT311.StrType s0) := s0;
EXPORT InValid_orig_companyname(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_companyname(UNSIGNED1 wh) := '';
 
EXPORT Make_cln_companyname(SALT311.StrType s0) := s0;
EXPORT InValid_cln_companyname(SALT311.StrType s) := 0;
EXPORT InValidMessage_cln_companyname(UNSIGNED1 wh) := '';
 
EXPORT Make_companytitle(SALT311.StrType s0) := s0;
EXPORT InValid_companytitle(SALT311.StrType s) := 0;
EXPORT InValidMessage_companytitle(UNSIGNED1 wh) := '';
 
EXPORT Make_rules(SALT311.StrType s0) := s0;
EXPORT InValid_rules(SALT311.StrType s) := 0;
EXPORT InValidMessage_rules(UNSIGNED1 wh) := '';
 
EXPORT Make_dotid(SALT311.StrType s0) := s0;
EXPORT InValid_dotid(SALT311.StrType s) := 0;
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := '';
 
EXPORT Make_dotscore(SALT311.StrType s0) := s0;
EXPORT InValid_dotscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := '';
 
EXPORT Make_dotweight(SALT311.StrType s0) := s0;
EXPORT InValid_dotweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := '';
 
EXPORT Make_empid(SALT311.StrType s0) := s0;
EXPORT InValid_empid(SALT311.StrType s) := 0;
EXPORT InValidMessage_empid(UNSIGNED1 wh) := '';
 
EXPORT Make_empscore(SALT311.StrType s0) := s0;
EXPORT InValid_empscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := '';
 
EXPORT Make_empweight(SALT311.StrType s0) := s0;
EXPORT InValid_empweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := '';
 
EXPORT Make_powid(SALT311.StrType s0) := s0;
EXPORT InValid_powid(SALT311.StrType s) := 0;
EXPORT InValidMessage_powid(UNSIGNED1 wh) := '';
 
EXPORT Make_powscore(SALT311.StrType s0) := s0;
EXPORT InValid_powscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := '';
 
EXPORT Make_powweight(SALT311.StrType s0) := s0;
EXPORT InValid_powweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := '';
 
EXPORT Make_proxid(SALT311.StrType s0) := s0;
EXPORT InValid_proxid(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := '';
 
EXPORT Make_proxscore(SALT311.StrType s0) := s0;
EXPORT InValid_proxscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := '';
 
EXPORT Make_proxweight(SALT311.StrType s0) := s0;
EXPORT InValid_proxweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := '';
 
EXPORT Make_seleid(SALT311.StrType s0) := s0;
EXPORT InValid_seleid(SALT311.StrType s) := 0;
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := '';
 
EXPORT Make_selescore(SALT311.StrType s0) := s0;
EXPORT InValid_selescore(SALT311.StrType s) := 0;
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := '';
 
EXPORT Make_seleweight(SALT311.StrType s0) := s0;
EXPORT InValid_seleweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := '';
 
EXPORT Make_orgid(SALT311.StrType s0) := s0;
EXPORT InValid_orgid(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := '';
 
EXPORT Make_orgscore(SALT311.StrType s0) := s0;
EXPORT InValid_orgscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := '';
 
EXPORT Make_orgweight(SALT311.StrType s0) := s0;
EXPORT InValid_orgweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := '';
 
EXPORT Make_ultid(SALT311.StrType s0) := s0;
EXPORT InValid_ultid(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := '';
 
EXPORT Make_ultscore(SALT311.StrType s0) := s0;
EXPORT InValid_ultscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := '';
 
EXPORT Make_ultweight(SALT311.StrType s0) := s0;
EXPORT InValid_ultweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := '';
 
EXPORT Make_global_sid(SALT311.StrType s0) := s0;
EXPORT InValid_global_sid(SALT311.StrType s) := 0;
EXPORT InValidMessage_global_sid(UNSIGNED1 wh) := '';
 
EXPORT Make_record_sid(SALT311.StrType s0) := s0;
EXPORT InValid_record_sid(SALT311.StrType s) := 0;
EXPORT InValidMessage_record_sid(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Email_DataV2;
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
    BOOLEAN Diff_clean_email;
    BOOLEAN Diff_append_email_username;
    BOOLEAN Diff_append_domain;
    BOOLEAN Diff_append_domain_type;
    BOOLEAN Diff_append_domain_root;
    BOOLEAN Diff_append_domain_ext;
    BOOLEAN Diff_append_is_tld_state;
    BOOLEAN Diff_append_is_tld_generic;
    BOOLEAN Diff_append_is_tld_country;
    BOOLEAN Diff_append_is_valid_domain_ext;
    BOOLEAN Diff_email_rec_key;
    BOOLEAN Diff_email_src;
    BOOLEAN Diff_orig_pmghousehold_id;
    BOOLEAN Diff_orig_pmgindividual_id;
    BOOLEAN Diff_orig_first_name;
    BOOLEAN Diff_orig_last_name;
    BOOLEAN Diff_orig_middle_name;
    BOOLEAN Diff_orig_name_suffix;
    BOOLEAN Diff_orig_address;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip;
    BOOLEAN Diff_orig_zip4;
    BOOLEAN Diff_orig_email;
    BOOLEAN Diff_orig_ip;
    BOOLEAN Diff_orig_login_date;
    BOOLEAN Diff_orig_site;
    BOOLEAN Diff_orig_e360_id;
    BOOLEAN Diff_orig_teramedia_id;
    BOOLEAN Diff_orig_phone;
    BOOLEAN Diff_orig_ssn;
    BOOLEAN Diff_orig_dob;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_did_type;
    BOOLEAN Diff_hhid;
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
    BOOLEAN Diff_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_append_rawaid;
    BOOLEAN Diff_clean_phone;
    BOOLEAN Diff_clean_ssn;
    BOOLEAN Diff_clean_dob;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_activecode;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_date_vendor_first_reported;
    BOOLEAN Diff_date_vendor_last_reported;
    BOOLEAN Diff_current_rec;
    BOOLEAN Diff_orig_companyname;
    BOOLEAN Diff_cln_companyname;
    BOOLEAN Diff_companytitle;
    BOOLEAN Diff_rules;
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
    BOOLEAN Diff_global_sid;
    BOOLEAN Diff_record_sid;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_clean_email := le.clean_email <> ri.clean_email;
    SELF.Diff_append_email_username := le.append_email_username <> ri.append_email_username;
    SELF.Diff_append_domain := le.append_domain <> ri.append_domain;
    SELF.Diff_append_domain_type := le.append_domain_type <> ri.append_domain_type;
    SELF.Diff_append_domain_root := le.append_domain_root <> ri.append_domain_root;
    SELF.Diff_append_domain_ext := le.append_domain_ext <> ri.append_domain_ext;
    SELF.Diff_append_is_tld_state := le.append_is_tld_state <> ri.append_is_tld_state;
    SELF.Diff_append_is_tld_generic := le.append_is_tld_generic <> ri.append_is_tld_generic;
    SELF.Diff_append_is_tld_country := le.append_is_tld_country <> ri.append_is_tld_country;
    SELF.Diff_append_is_valid_domain_ext := le.append_is_valid_domain_ext <> ri.append_is_valid_domain_ext;
    SELF.Diff_email_rec_key := le.email_rec_key <> ri.email_rec_key;
    SELF.Diff_email_src := le.email_src <> ri.email_src;
    SELF.Diff_orig_pmghousehold_id := le.orig_pmghousehold_id <> ri.orig_pmghousehold_id;
    SELF.Diff_orig_pmgindividual_id := le.orig_pmgindividual_id <> ri.orig_pmgindividual_id;
    SELF.Diff_orig_first_name := le.orig_first_name <> ri.orig_first_name;
    SELF.Diff_orig_last_name := le.orig_last_name <> ri.orig_last_name;
    SELF.Diff_orig_middle_name := le.orig_middle_name <> ri.orig_middle_name;
    SELF.Diff_orig_name_suffix := le.orig_name_suffix <> ri.orig_name_suffix;
    SELF.Diff_orig_address := le.orig_address <> ri.orig_address;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip := le.orig_zip <> ri.orig_zip;
    SELF.Diff_orig_zip4 := le.orig_zip4 <> ri.orig_zip4;
    SELF.Diff_orig_email := le.orig_email <> ri.orig_email;
    SELF.Diff_orig_ip := le.orig_ip <> ri.orig_ip;
    SELF.Diff_orig_login_date := le.orig_login_date <> ri.orig_login_date;
    SELF.Diff_orig_site := le.orig_site <> ri.orig_site;
    SELF.Diff_orig_e360_id := le.orig_e360_id <> ri.orig_e360_id;
    SELF.Diff_orig_teramedia_id := le.orig_teramedia_id <> ri.orig_teramedia_id;
    SELF.Diff_orig_phone := le.orig_phone <> ri.orig_phone;
    SELF.Diff_orig_ssn := le.orig_ssn <> ri.orig_ssn;
    SELF.Diff_orig_dob := le.orig_dob <> ri.orig_dob;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_did_type := le.did_type <> ri.did_type;
    SELF.Diff_hhid := le.hhid <> ri.hhid;
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
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_append_rawaid := le.append_rawaid <> ri.append_rawaid;
    SELF.Diff_clean_phone := le.clean_phone <> ri.clean_phone;
    SELF.Diff_clean_ssn := le.clean_ssn <> ri.clean_ssn;
    SELF.Diff_clean_dob := le.clean_dob <> ri.clean_dob;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_activecode := le.activecode <> ri.activecode;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_date_vendor_first_reported := le.date_vendor_first_reported <> ri.date_vendor_first_reported;
    SELF.Diff_date_vendor_last_reported := le.date_vendor_last_reported <> ri.date_vendor_last_reported;
    SELF.Diff_current_rec := le.current_rec <> ri.current_rec;
    SELF.Diff_orig_companyname := le.orig_companyname <> ri.orig_companyname;
    SELF.Diff_cln_companyname := le.cln_companyname <> ri.cln_companyname;
    SELF.Diff_companytitle := le.companytitle <> ri.companytitle;
    SELF.Diff_rules := le.rules <> ri.rules;
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
    SELF.Diff_global_sid := le.global_sid <> ri.global_sid;
    SELF.Diff_record_sid := le.record_sid <> ri.record_sid;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.email_src;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_clean_email,1,0)+ IF( SELF.Diff_append_email_username,1,0)+ IF( SELF.Diff_append_domain,1,0)+ IF( SELF.Diff_append_domain_type,1,0)+ IF( SELF.Diff_append_domain_root,1,0)+ IF( SELF.Diff_append_domain_ext,1,0)+ IF( SELF.Diff_append_is_tld_state,1,0)+ IF( SELF.Diff_append_is_tld_generic,1,0)+ IF( SELF.Diff_append_is_tld_country,1,0)+ IF( SELF.Diff_append_is_valid_domain_ext,1,0)+ IF( SELF.Diff_email_rec_key,1,0)+ IF( SELF.Diff_email_src,1,0)+ IF( SELF.Diff_orig_pmghousehold_id,1,0)+ IF( SELF.Diff_orig_pmgindividual_id,1,0)+ IF( SELF.Diff_orig_first_name,1,0)+ IF( SELF.Diff_orig_last_name,1,0)+ IF( SELF.Diff_orig_middle_name,1,0)+ IF( SELF.Diff_orig_name_suffix,1,0)+ IF( SELF.Diff_orig_address,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_orig_zip4,1,0)+ IF( SELF.Diff_orig_email,1,0)+ IF( SELF.Diff_orig_ip,1,0)+ IF( SELF.Diff_orig_login_date,1,0)+ IF( SELF.Diff_orig_site,1,0)+ IF( SELF.Diff_orig_e360_id,1,0)+ IF( SELF.Diff_orig_teramedia_id,1,0)+ IF( SELF.Diff_orig_phone,1,0)+ IF( SELF.Diff_orig_ssn,1,0)+ IF( SELF.Diff_orig_dob,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_did_type,1,0)+ IF( SELF.Diff_hhid,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_append_rawaid,1,0)+ IF( SELF.Diff_clean_phone,1,0)+ IF( SELF.Diff_clean_ssn,1,0)+ IF( SELF.Diff_clean_dob,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_activecode,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_date_vendor_first_reported,1,0)+ IF( SELF.Diff_date_vendor_last_reported,1,0)+ IF( SELF.Diff_current_rec,1,0)+ IF( SELF.Diff_orig_companyname,1,0)+ IF( SELF.Diff_cln_companyname,1,0)+ IF( SELF.Diff_companytitle,1,0)+ IF( SELF.Diff_rules,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff_global_sid,1,0)+ IF( SELF.Diff_record_sid,1,0);
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
    Count_Diff_clean_email := COUNT(GROUP,%Closest%.Diff_clean_email);
    Count_Diff_append_email_username := COUNT(GROUP,%Closest%.Diff_append_email_username);
    Count_Diff_append_domain := COUNT(GROUP,%Closest%.Diff_append_domain);
    Count_Diff_append_domain_type := COUNT(GROUP,%Closest%.Diff_append_domain_type);
    Count_Diff_append_domain_root := COUNT(GROUP,%Closest%.Diff_append_domain_root);
    Count_Diff_append_domain_ext := COUNT(GROUP,%Closest%.Diff_append_domain_ext);
    Count_Diff_append_is_tld_state := COUNT(GROUP,%Closest%.Diff_append_is_tld_state);
    Count_Diff_append_is_tld_generic := COUNT(GROUP,%Closest%.Diff_append_is_tld_generic);
    Count_Diff_append_is_tld_country := COUNT(GROUP,%Closest%.Diff_append_is_tld_country);
    Count_Diff_append_is_valid_domain_ext := COUNT(GROUP,%Closest%.Diff_append_is_valid_domain_ext);
    Count_Diff_email_rec_key := COUNT(GROUP,%Closest%.Diff_email_rec_key);
    Count_Diff_email_src := COUNT(GROUP,%Closest%.Diff_email_src);
    Count_Diff_orig_pmghousehold_id := COUNT(GROUP,%Closest%.Diff_orig_pmghousehold_id);
    Count_Diff_orig_pmgindividual_id := COUNT(GROUP,%Closest%.Diff_orig_pmgindividual_id);
    Count_Diff_orig_first_name := COUNT(GROUP,%Closest%.Diff_orig_first_name);
    Count_Diff_orig_last_name := COUNT(GROUP,%Closest%.Diff_orig_last_name);
    Count_Diff_orig_middle_name := COUNT(GROUP,%Closest%.Diff_orig_middle_name);
    Count_Diff_orig_name_suffix := COUNT(GROUP,%Closest%.Diff_orig_name_suffix);
    Count_Diff_orig_address := COUNT(GROUP,%Closest%.Diff_orig_address);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip := COUNT(GROUP,%Closest%.Diff_orig_zip);
    Count_Diff_orig_zip4 := COUNT(GROUP,%Closest%.Diff_orig_zip4);
    Count_Diff_orig_email := COUNT(GROUP,%Closest%.Diff_orig_email);
    Count_Diff_orig_ip := COUNT(GROUP,%Closest%.Diff_orig_ip);
    Count_Diff_orig_login_date := COUNT(GROUP,%Closest%.Diff_orig_login_date);
    Count_Diff_orig_site := COUNT(GROUP,%Closest%.Diff_orig_site);
    Count_Diff_orig_e360_id := COUNT(GROUP,%Closest%.Diff_orig_e360_id);
    Count_Diff_orig_teramedia_id := COUNT(GROUP,%Closest%.Diff_orig_teramedia_id);
    Count_Diff_orig_phone := COUNT(GROUP,%Closest%.Diff_orig_phone);
    Count_Diff_orig_ssn := COUNT(GROUP,%Closest%.Diff_orig_ssn);
    Count_Diff_orig_dob := COUNT(GROUP,%Closest%.Diff_orig_dob);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_did_type := COUNT(GROUP,%Closest%.Diff_did_type);
    Count_Diff_hhid := COUNT(GROUP,%Closest%.Diff_hhid);
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
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_append_rawaid := COUNT(GROUP,%Closest%.Diff_append_rawaid);
    Count_Diff_clean_phone := COUNT(GROUP,%Closest%.Diff_clean_phone);
    Count_Diff_clean_ssn := COUNT(GROUP,%Closest%.Diff_clean_ssn);
    Count_Diff_clean_dob := COUNT(GROUP,%Closest%.Diff_clean_dob);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_activecode := COUNT(GROUP,%Closest%.Diff_activecode);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_date_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_first_reported);
    Count_Diff_date_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_last_reported);
    Count_Diff_current_rec := COUNT(GROUP,%Closest%.Diff_current_rec);
    Count_Diff_orig_companyname := COUNT(GROUP,%Closest%.Diff_orig_companyname);
    Count_Diff_cln_companyname := COUNT(GROUP,%Closest%.Diff_cln_companyname);
    Count_Diff_companytitle := COUNT(GROUP,%Closest%.Diff_companytitle);
    Count_Diff_rules := COUNT(GROUP,%Closest%.Diff_rules);
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
    Count_Diff_global_sid := COUNT(GROUP,%Closest%.Diff_global_sid);
    Count_Diff_record_sid := COUNT(GROUP,%Closest%.Diff_record_sid);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
