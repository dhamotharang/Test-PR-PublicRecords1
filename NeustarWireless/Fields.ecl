IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 94;
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'phone','fname','mname','lname','salutation','suffix','gender','dob','house','pre_dir','street','street_type','post_dir','apt_type','apt_nbr','zip','plus4','dpc','z4_type','crte','city','state','dpvcmra','dpvconf','fips_state','fips_county','census_tract','census_block_group','cbsa','match_code','latitude','longitude','email','verified','activity_status','prepaid','cord_cutter','raw_file_name','rcid','source','persistent_record_id','did','did_score','xadl2_weight','xadl2_score','xadl2_keys_used','xadl2_distance','xadl2_matches','append_prep_address_1','append_prep_address_2','rawaid','aceaid','clean_address.prim_range','clean_address.predir','clean_address.prim_name','clean_address.addr_suffix','clean_address.postdir','clean_address.unit_desig','clean_address.sec_range','clean_address.p_city_name','clean_address.v_city_name','clean_address.st','clean_address.zip','clean_address.zip4','clean_address.cart','clean_address.cr_sort_sz','clean_address.lot','clean_address.lot_order','clean_address.dbpc','clean_address.chk_digit','clean_address.rec_type','clean_address.county','clean_address.geo_lat','clean_address.geo_long','clean_address.msa','clean_address.geo_blk','clean_address.geo_match','clean_address.err_stat','append_prep_name','nid','name_ind','nametype','cln_title','cln_fname','cln_mname','cln_lname','cln_suffix','cln_fullname','process_date','process_time','date_vendor_first_reported','date_vendor_last_reported','current_rec','ingest_tpe');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'phone','fname','mname','lname','salutation','suffix','gender','dob','house','pre_dir','street','street_type','post_dir','apt_type','apt_nbr','zip','plus4','dpc','z4_type','crte','city','state','dpvcmra','dpvconf','fips_state','fips_county','census_tract','census_block_group','cbsa','match_code','latitude','longitude','email','verified','activity_status','prepaid','cord_cutter','raw_file_name','rcid','source','persistent_record_id','did','did_score','xadl2_weight','xadl2_score','xadl2_keys_used','xadl2_distance','xadl2_matches','append_prep_address_1','append_prep_address_2','rawaid','aceaid','clean_address_prim_range','clean_address_predir','clean_address_prim_name','clean_address_addr_suffix','clean_address_postdir','clean_address_unit_desig','clean_address_sec_range','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip','clean_address_zip4','clean_address_cart','clean_address_cr_sort_sz','clean_address_lot','clean_address_lot_order','clean_address_dbpc','clean_address_chk_digit','clean_address_rec_type','clean_address_county','clean_address_geo_lat','clean_address_geo_long','clean_address_msa','clean_address_geo_blk','clean_address_geo_match','clean_address_err_stat','append_prep_name','nid','name_ind','nametype','cln_title','cln_fname','cln_mname','cln_lname','cln_suffix','cln_fullname','process_date','process_time','date_vendor_first_reported','date_vendor_last_reported','current_rec','ingest_tpe');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'phone' => 0,'fname' => 1,'mname' => 2,'lname' => 3,'salutation' => 4,'suffix' => 5,'gender' => 6,'dob' => 7,'house' => 8,'pre_dir' => 9,'street' => 10,'street_type' => 11,'post_dir' => 12,'apt_type' => 13,'apt_nbr' => 14,'zip' => 15,'plus4' => 16,'dpc' => 17,'z4_type' => 18,'crte' => 19,'city' => 20,'state' => 21,'dpvcmra' => 22,'dpvconf' => 23,'fips_state' => 24,'fips_county' => 25,'census_tract' => 26,'census_block_group' => 27,'cbsa' => 28,'match_code' => 29,'latitude' => 30,'longitude' => 31,'email' => 32,'verified' => 33,'activity_status' => 34,'prepaid' => 35,'cord_cutter' => 36,'raw_file_name' => 37,'rcid' => 38,'source' => 39,'persistent_record_id' => 40,'did' => 41,'did_score' => 42,'xadl2_weight' => 43,'xadl2_score' => 44,'xadl2_keys_used' => 45,'xadl2_distance' => 46,'xadl2_matches' => 47,'append_prep_address_1' => 48,'append_prep_address_2' => 49,'rawaid' => 50,'aceaid' => 51,'clean_address.prim_range' => 52,'clean_address.predir' => 53,'clean_address.prim_name' => 54,'clean_address.addr_suffix' => 55,'clean_address.postdir' => 56,'clean_address.unit_desig' => 57,'clean_address.sec_range' => 58,'clean_address.p_city_name' => 59,'clean_address.v_city_name' => 60,'clean_address.st' => 61,'clean_address.zip' => 62,'clean_address.zip4' => 63,'clean_address.cart' => 64,'clean_address.cr_sort_sz' => 65,'clean_address.lot' => 66,'clean_address.lot_order' => 67,'clean_address.dbpc' => 68,'clean_address.chk_digit' => 69,'clean_address.rec_type' => 70,'clean_address.county' => 71,'clean_address.geo_lat' => 72,'clean_address.geo_long' => 73,'clean_address.msa' => 74,'clean_address.geo_blk' => 75,'clean_address.geo_match' => 76,'clean_address.err_stat' => 77,'append_prep_name' => 78,'nid' => 79,'name_ind' => 80,'nametype' => 81,'cln_title' => 82,'cln_fname' => 83,'cln_mname' => 84,'cln_lname' => 85,'cln_suffix' => 86,'cln_fullname' => 87,'process_date' => 88,'process_time' => 89,'date_vendor_first_reported' => 90,'date_vendor_last_reported' => 91,'current_rec' => 92,'ingest_tpe' => 93,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_phone(SALT311.StrType s0) := s0;
EXPORT InValid_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT311.StrType s0) := s0;
EXPORT InValid_fname(SALT311.StrType s) := 0;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT311.StrType s0) := s0;
EXPORT InValid_mname(SALT311.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT311.StrType s0) := s0;
EXPORT InValid_lname(SALT311.StrType s) := 0;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_salutation(SALT311.StrType s0) := s0;
EXPORT InValid_salutation(SALT311.StrType s) := 0;
EXPORT InValidMessage_salutation(UNSIGNED1 wh) := '';
 
EXPORT Make_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_gender(SALT311.StrType s0) := s0;
EXPORT InValid_gender(SALT311.StrType s) := 0;
EXPORT InValidMessage_gender(UNSIGNED1 wh) := '';
 
EXPORT Make_dob(SALT311.StrType s0) := s0;
EXPORT InValid_dob(SALT311.StrType s) := 0;
EXPORT InValidMessage_dob(UNSIGNED1 wh) := '';
 
EXPORT Make_house(SALT311.StrType s0) := s0;
EXPORT InValid_house(SALT311.StrType s) := 0;
EXPORT InValidMessage_house(UNSIGNED1 wh) := '';
 
EXPORT Make_pre_dir(SALT311.StrType s0) := s0;
EXPORT InValid_pre_dir(SALT311.StrType s) := 0;
EXPORT InValidMessage_pre_dir(UNSIGNED1 wh) := '';
 
EXPORT Make_street(SALT311.StrType s0) := s0;
EXPORT InValid_street(SALT311.StrType s) := 0;
EXPORT InValidMessage_street(UNSIGNED1 wh) := '';
 
EXPORT Make_street_type(SALT311.StrType s0) := s0;
EXPORT InValid_street_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_street_type(UNSIGNED1 wh) := '';
 
EXPORT Make_post_dir(SALT311.StrType s0) := s0;
EXPORT InValid_post_dir(SALT311.StrType s) := 0;
EXPORT InValidMessage_post_dir(UNSIGNED1 wh) := '';
 
EXPORT Make_apt_type(SALT311.StrType s0) := s0;
EXPORT InValid_apt_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_apt_type(UNSIGNED1 wh) := '';
 
EXPORT Make_apt_nbr(SALT311.StrType s0) := s0;
EXPORT InValid_apt_nbr(SALT311.StrType s) := 0;
EXPORT InValidMessage_apt_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT311.StrType s0) := s0;
EXPORT InValid_zip(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_plus4(SALT311.StrType s0) := s0;
EXPORT InValid_plus4(SALT311.StrType s) := 0;
EXPORT InValidMessage_plus4(UNSIGNED1 wh) := '';
 
EXPORT Make_dpc(SALT311.StrType s0) := s0;
EXPORT InValid_dpc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dpc(UNSIGNED1 wh) := '';
 
EXPORT Make_z4_type(SALT311.StrType s0) := s0;
EXPORT InValid_z4_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_z4_type(UNSIGNED1 wh) := '';
 
EXPORT Make_crte(SALT311.StrType s0) := s0;
EXPORT InValid_crte(SALT311.StrType s) := 0;
EXPORT InValidMessage_crte(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT311.StrType s0) := s0;
EXPORT InValid_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_city(UNSIGNED1 wh) := '';
 
EXPORT Make_state(SALT311.StrType s0) := s0;
EXPORT InValid_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_state(UNSIGNED1 wh) := '';
 
EXPORT Make_dpvcmra(SALT311.StrType s0) := s0;
EXPORT InValid_dpvcmra(SALT311.StrType s) := 0;
EXPORT InValidMessage_dpvcmra(UNSIGNED1 wh) := '';
 
EXPORT Make_dpvconf(SALT311.StrType s0) := s0;
EXPORT InValid_dpvconf(SALT311.StrType s) := 0;
EXPORT InValidMessage_dpvconf(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_state(SALT311.StrType s0) := s0;
EXPORT InValid_fips_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_fips_state(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_county(SALT311.StrType s0) := s0;
EXPORT InValid_fips_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := '';
 
EXPORT Make_census_tract(SALT311.StrType s0) := s0;
EXPORT InValid_census_tract(SALT311.StrType s) := 0;
EXPORT InValidMessage_census_tract(UNSIGNED1 wh) := '';
 
EXPORT Make_census_block_group(SALT311.StrType s0) := s0;
EXPORT InValid_census_block_group(SALT311.StrType s) := 0;
EXPORT InValidMessage_census_block_group(UNSIGNED1 wh) := '';
 
EXPORT Make_cbsa(SALT311.StrType s0) := s0;
EXPORT InValid_cbsa(SALT311.StrType s) := 0;
EXPORT InValidMessage_cbsa(UNSIGNED1 wh) := '';
 
EXPORT Make_match_code(SALT311.StrType s0) := s0;
EXPORT InValid_match_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_match_code(UNSIGNED1 wh) := '';
 
EXPORT Make_latitude(SALT311.StrType s0) := s0;
EXPORT InValid_latitude(SALT311.StrType s) := 0;
EXPORT InValidMessage_latitude(UNSIGNED1 wh) := '';
 
EXPORT Make_longitude(SALT311.StrType s0) := s0;
EXPORT InValid_longitude(SALT311.StrType s) := 0;
EXPORT InValidMessage_longitude(UNSIGNED1 wh) := '';
 
EXPORT Make_email(SALT311.StrType s0) := s0;
EXPORT InValid_email(SALT311.StrType s) := 0;
EXPORT InValidMessage_email(UNSIGNED1 wh) := '';
 
EXPORT Make_verified(SALT311.StrType s0) := s0;
EXPORT InValid_verified(SALT311.StrType s) := 0;
EXPORT InValidMessage_verified(UNSIGNED1 wh) := '';
 
EXPORT Make_activity_status(SALT311.StrType s0) := s0;
EXPORT InValid_activity_status(SALT311.StrType s) := 0;
EXPORT InValidMessage_activity_status(UNSIGNED1 wh) := '';
 
EXPORT Make_prepaid(SALT311.StrType s0) := s0;
EXPORT InValid_prepaid(SALT311.StrType s) := 0;
EXPORT InValidMessage_prepaid(UNSIGNED1 wh) := '';
 
EXPORT Make_cord_cutter(SALT311.StrType s0) := s0;
EXPORT InValid_cord_cutter(SALT311.StrType s) := 0;
EXPORT InValidMessage_cord_cutter(UNSIGNED1 wh) := '';
 
EXPORT Make_raw_file_name(SALT311.StrType s0) := s0;
EXPORT InValid_raw_file_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_raw_file_name(UNSIGNED1 wh) := '';
 
EXPORT Make_rcid(SALT311.StrType s0) := s0;
EXPORT InValid_rcid(SALT311.StrType s) := 0;
EXPORT InValidMessage_rcid(UNSIGNED1 wh) := '';
 
EXPORT Make_source(SALT311.StrType s0) := s0;
EXPORT InValid_source(SALT311.StrType s) := 0;
EXPORT InValidMessage_source(UNSIGNED1 wh) := '';
 
EXPORT Make_persistent_record_id(SALT311.StrType s0) := s0;
EXPORT InValid_persistent_record_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_persistent_record_id(UNSIGNED1 wh) := '';
 
EXPORT Make_did(SALT311.StrType s0) := s0;
EXPORT InValid_did(SALT311.StrType s) := 0;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
 
EXPORT Make_did_score(SALT311.StrType s0) := s0;
EXPORT InValid_did_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := '';
 
EXPORT Make_xadl2_weight(SALT311.StrType s0) := s0;
EXPORT InValid_xadl2_weight(SALT311.StrType s) := 0;
EXPORT InValidMessage_xadl2_weight(UNSIGNED1 wh) := '';
 
EXPORT Make_xadl2_score(SALT311.StrType s0) := s0;
EXPORT InValid_xadl2_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_xadl2_score(UNSIGNED1 wh) := '';
 
EXPORT Make_xadl2_keys_used(SALT311.StrType s0) := s0;
EXPORT InValid_xadl2_keys_used(SALT311.StrType s) := 0;
EXPORT InValidMessage_xadl2_keys_used(UNSIGNED1 wh) := '';
 
EXPORT Make_xadl2_distance(SALT311.StrType s0) := s0;
EXPORT InValid_xadl2_distance(SALT311.StrType s) := 0;
EXPORT InValidMessage_xadl2_distance(UNSIGNED1 wh) := '';
 
EXPORT Make_xadl2_matches(SALT311.StrType s0) := s0;
EXPORT InValid_xadl2_matches(SALT311.StrType s) := 0;
EXPORT InValidMessage_xadl2_matches(UNSIGNED1 wh) := '';
 
EXPORT Make_append_prep_address_1(SALT311.StrType s0) := s0;
EXPORT InValid_append_prep_address_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_prep_address_1(UNSIGNED1 wh) := '';
 
EXPORT Make_append_prep_address_2(SALT311.StrType s0) := s0;
EXPORT InValid_append_prep_address_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_prep_address_2(UNSIGNED1 wh) := '';
 
EXPORT Make_rawaid(SALT311.StrType s0) := s0;
EXPORT InValid_rawaid(SALT311.StrType s) := 0;
EXPORT InValidMessage_rawaid(UNSIGNED1 wh) := '';
 
EXPORT Make_aceaid(SALT311.StrType s0) := s0;
EXPORT InValid_aceaid(SALT311.StrType s) := 0;
EXPORT InValidMessage_aceaid(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_prim_range(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_prim_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_predir(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_predir(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_prim_name(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_prim_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_addr_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_addr_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_postdir(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_postdir(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_unit_desig(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_unit_desig(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_sec_range(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_sec_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_p_city_name(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_p_city_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_v_city_name(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_v_city_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_st(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_st(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_zip(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_zip(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_zip4(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_zip4(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_cart(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_cart(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_cr_sort_sz(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_cr_sort_sz(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_lot(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_lot(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_lot_order(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_lot_order(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_dbpc(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_dbpc(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_dbpc(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_chk_digit(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_chk_digit(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_rec_type(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_rec_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_county(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_county(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_geo_lat(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_geo_lat(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_geo_long(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_geo_long(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_msa(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_msa(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_geo_blk(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_geo_blk(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_geo_match(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_geo_match(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_err_stat(SALT311.StrType s0) := s0;
EXPORT InValid_clean_address_err_stat(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_address_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_append_prep_name(SALT311.StrType s0) := s0;
EXPORT InValid_append_prep_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_prep_name(UNSIGNED1 wh) := '';
 
EXPORT Make_nid(SALT311.StrType s0) := s0;
EXPORT InValid_nid(SALT311.StrType s) := 0;
EXPORT InValidMessage_nid(UNSIGNED1 wh) := '';
 
EXPORT Make_name_ind(SALT311.StrType s0) := s0;
EXPORT InValid_name_ind(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_nametype(SALT311.StrType s0) := s0;
EXPORT InValid_nametype(SALT311.StrType s) := 0;
EXPORT InValidMessage_nametype(UNSIGNED1 wh) := '';
 
EXPORT Make_cln_title(SALT311.StrType s0) := s0;
EXPORT InValid_cln_title(SALT311.StrType s) := 0;
EXPORT InValidMessage_cln_title(UNSIGNED1 wh) := '';
 
EXPORT Make_cln_fname(SALT311.StrType s0) := s0;
EXPORT InValid_cln_fname(SALT311.StrType s) := 0;
EXPORT InValidMessage_cln_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_cln_mname(SALT311.StrType s0) := s0;
EXPORT InValid_cln_mname(SALT311.StrType s) := 0;
EXPORT InValidMessage_cln_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_cln_lname(SALT311.StrType s0) := s0;
EXPORT InValid_cln_lname(SALT311.StrType s) := 0;
EXPORT InValidMessage_cln_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_cln_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_cln_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_cln_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_cln_fullname(SALT311.StrType s0) := s0;
EXPORT InValid_cln_fullname(SALT311.StrType s) := 0;
EXPORT InValidMessage_cln_fullname(UNSIGNED1 wh) := '';
 
EXPORT Make_process_date(SALT311.StrType s0) := s0;
EXPORT InValid_process_date(SALT311.StrType s) := 0;
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := '';
 
EXPORT Make_process_time(SALT311.StrType s0) := s0;
EXPORT InValid_process_time(SALT311.StrType s) := 0;
EXPORT InValidMessage_process_time(UNSIGNED1 wh) := '';
 
EXPORT Make_date_vendor_first_reported(SALT311.StrType s0) := s0;
EXPORT InValid_date_vendor_first_reported(SALT311.StrType s) := 0;
EXPORT InValidMessage_date_vendor_first_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_date_vendor_last_reported(SALT311.StrType s0) := s0;
EXPORT InValid_date_vendor_last_reported(SALT311.StrType s) := 0;
EXPORT InValidMessage_date_vendor_last_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_current_rec(SALT311.StrType s0) := s0;
EXPORT InValid_current_rec(SALT311.StrType s) := 0;
EXPORT InValidMessage_current_rec(UNSIGNED1 wh) := '';
 
EXPORT Make_ingest_tpe(SALT311.StrType s0) := s0;
EXPORT InValid_ingest_tpe(SALT311.StrType s) := 0;
EXPORT InValidMessage_ingest_tpe(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,NeustarWireless;
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
    BOOLEAN Diff_phone;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_salutation;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_house;
    BOOLEAN Diff_pre_dir;
    BOOLEAN Diff_street;
    BOOLEAN Diff_street_type;
    BOOLEAN Diff_post_dir;
    BOOLEAN Diff_apt_type;
    BOOLEAN Diff_apt_nbr;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_plus4;
    BOOLEAN Diff_dpc;
    BOOLEAN Diff_z4_type;
    BOOLEAN Diff_crte;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_dpvcmra;
    BOOLEAN Diff_dpvconf;
    BOOLEAN Diff_fips_state;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_census_tract;
    BOOLEAN Diff_census_block_group;
    BOOLEAN Diff_cbsa;
    BOOLEAN Diff_match_code;
    BOOLEAN Diff_latitude;
    BOOLEAN Diff_longitude;
    BOOLEAN Diff_email;
    BOOLEAN Diff_verified;
    BOOLEAN Diff_activity_status;
    BOOLEAN Diff_prepaid;
    BOOLEAN Diff_cord_cutter;
    BOOLEAN Diff_raw_file_name;
    BOOLEAN Diff_rcid;
    BOOLEAN Diff_source;
    BOOLEAN Diff_persistent_record_id;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_xadl2_weight;
    BOOLEAN Diff_xadl2_score;
    BOOLEAN Diff_xadl2_keys_used;
    BOOLEAN Diff_xadl2_distance;
    BOOLEAN Diff_xadl2_matches;
    BOOLEAN Diff_append_prep_address_1;
    BOOLEAN Diff_append_prep_address_2;
    BOOLEAN Diff_rawaid;
    BOOLEAN Diff_aceaid;
    BOOLEAN Diff_clean_address_prim_range;
    BOOLEAN Diff_clean_address_predir;
    BOOLEAN Diff_clean_address_prim_name;
    BOOLEAN Diff_clean_address_addr_suffix;
    BOOLEAN Diff_clean_address_postdir;
    BOOLEAN Diff_clean_address_unit_desig;
    BOOLEAN Diff_clean_address_sec_range;
    BOOLEAN Diff_clean_address_p_city_name;
    BOOLEAN Diff_clean_address_v_city_name;
    BOOLEAN Diff_clean_address_st;
    BOOLEAN Diff_clean_address_zip;
    BOOLEAN Diff_clean_address_zip4;
    BOOLEAN Diff_clean_address_cart;
    BOOLEAN Diff_clean_address_cr_sort_sz;
    BOOLEAN Diff_clean_address_lot;
    BOOLEAN Diff_clean_address_lot_order;
    BOOLEAN Diff_clean_address_dbpc;
    BOOLEAN Diff_clean_address_chk_digit;
    BOOLEAN Diff_clean_address_rec_type;
    BOOLEAN Diff_clean_address_county;
    BOOLEAN Diff_clean_address_geo_lat;
    BOOLEAN Diff_clean_address_geo_long;
    BOOLEAN Diff_clean_address_msa;
    BOOLEAN Diff_clean_address_geo_blk;
    BOOLEAN Diff_clean_address_geo_match;
    BOOLEAN Diff_clean_address_err_stat;
    BOOLEAN Diff_append_prep_name;
    BOOLEAN Diff_nid;
    BOOLEAN Diff_name_ind;
    BOOLEAN Diff_nametype;
    BOOLEAN Diff_cln_title;
    BOOLEAN Diff_cln_fname;
    BOOLEAN Diff_cln_mname;
    BOOLEAN Diff_cln_lname;
    BOOLEAN Diff_cln_suffix;
    BOOLEAN Diff_cln_fullname;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_process_time;
    BOOLEAN Diff_date_vendor_first_reported;
    BOOLEAN Diff_date_vendor_last_reported;
    BOOLEAN Diff_current_rec;
    BOOLEAN Diff_ingest_tpe;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_salutation := le.salutation <> ri.salutation;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_house := le.house <> ri.house;
    SELF.Diff_pre_dir := le.pre_dir <> ri.pre_dir;
    SELF.Diff_street := le.street <> ri.street;
    SELF.Diff_street_type := le.street_type <> ri.street_type;
    SELF.Diff_post_dir := le.post_dir <> ri.post_dir;
    SELF.Diff_apt_type := le.apt_type <> ri.apt_type;
    SELF.Diff_apt_nbr := le.apt_nbr <> ri.apt_nbr;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_plus4 := le.plus4 <> ri.plus4;
    SELF.Diff_dpc := le.dpc <> ri.dpc;
    SELF.Diff_z4_type := le.z4_type <> ri.z4_type;
    SELF.Diff_crte := le.crte <> ri.crte;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_dpvcmra := le.dpvcmra <> ri.dpvcmra;
    SELF.Diff_dpvconf := le.dpvconf <> ri.dpvconf;
    SELF.Diff_fips_state := le.fips_state <> ri.fips_state;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_census_tract := le.census_tract <> ri.census_tract;
    SELF.Diff_census_block_group := le.census_block_group <> ri.census_block_group;
    SELF.Diff_cbsa := le.cbsa <> ri.cbsa;
    SELF.Diff_match_code := le.match_code <> ri.match_code;
    SELF.Diff_latitude := le.latitude <> ri.latitude;
    SELF.Diff_longitude := le.longitude <> ri.longitude;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_verified := le.verified <> ri.verified;
    SELF.Diff_activity_status := le.activity_status <> ri.activity_status;
    SELF.Diff_prepaid := le.prepaid <> ri.prepaid;
    SELF.Diff_cord_cutter := le.cord_cutter <> ri.cord_cutter;
    SELF.Diff_raw_file_name := le.raw_file_name <> ri.raw_file_name;
    SELF.Diff_rcid := le.rcid <> ri.rcid;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_persistent_record_id := le.persistent_record_id <> ri.persistent_record_id;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_xadl2_weight := le.xadl2_weight <> ri.xadl2_weight;
    SELF.Diff_xadl2_score := le.xadl2_score <> ri.xadl2_score;
    SELF.Diff_xadl2_keys_used := le.xadl2_keys_used <> ri.xadl2_keys_used;
    SELF.Diff_xadl2_distance := le.xadl2_distance <> ri.xadl2_distance;
    SELF.Diff_xadl2_matches := le.xadl2_matches <> ri.xadl2_matches;
    SELF.Diff_append_prep_address_1 := le.append_prep_address_1 <> ri.append_prep_address_1;
    SELF.Diff_append_prep_address_2 := le.append_prep_address_2 <> ri.append_prep_address_2;
    SELF.Diff_rawaid := le.rawaid <> ri.rawaid;
    SELF.Diff_aceaid := le.aceaid <> ri.aceaid;
    SELF.Diff_clean_address_prim_range := le.clean_address.prim_range <> ri.clean_address.prim_range;
    SELF.Diff_clean_address_predir := le.clean_address.predir <> ri.clean_address.predir;
    SELF.Diff_clean_address_prim_name := le.clean_address.prim_name <> ri.clean_address.prim_name;
    SELF.Diff_clean_address_addr_suffix := le.clean_address.addr_suffix <> ri.clean_address.addr_suffix;
    SELF.Diff_clean_address_postdir := le.clean_address.postdir <> ri.clean_address.postdir;
    SELF.Diff_clean_address_unit_desig := le.clean_address.unit_desig <> ri.clean_address.unit_desig;
    SELF.Diff_clean_address_sec_range := le.clean_address.sec_range <> ri.clean_address.sec_range;
    SELF.Diff_clean_address_p_city_name := le.clean_address.p_city_name <> ri.clean_address.p_city_name;
    SELF.Diff_clean_address_v_city_name := le.clean_address.v_city_name <> ri.clean_address.v_city_name;
    SELF.Diff_clean_address_st := le.clean_address.st <> ri.clean_address.st;
    SELF.Diff_clean_address_zip := le.clean_address.zip <> ri.clean_address.zip;
    SELF.Diff_clean_address_zip4 := le.clean_address.zip4 <> ri.clean_address.zip4;
    SELF.Diff_clean_address_cart := le.clean_address.cart <> ri.clean_address.cart;
    SELF.Diff_clean_address_cr_sort_sz := le.clean_address.cr_sort_sz <> ri.clean_address.cr_sort_sz;
    SELF.Diff_clean_address_lot := le.clean_address.lot <> ri.clean_address.lot;
    SELF.Diff_clean_address_lot_order := le.clean_address.lot_order <> ri.clean_address.lot_order;
    SELF.Diff_clean_address_dbpc := le.clean_address.dbpc <> ri.clean_address.dbpc;
    SELF.Diff_clean_address_chk_digit := le.clean_address.chk_digit <> ri.clean_address.chk_digit;
    SELF.Diff_clean_address_rec_type := le.clean_address.rec_type <> ri.clean_address.rec_type;
    SELF.Diff_clean_address_county := le.clean_address.county <> ri.clean_address.county;
    SELF.Diff_clean_address_geo_lat := le.clean_address.geo_lat <> ri.clean_address.geo_lat;
    SELF.Diff_clean_address_geo_long := le.clean_address.geo_long <> ri.clean_address.geo_long;
    SELF.Diff_clean_address_msa := le.clean_address.msa <> ri.clean_address.msa;
    SELF.Diff_clean_address_geo_blk := le.clean_address.geo_blk <> ri.clean_address.geo_blk;
    SELF.Diff_clean_address_geo_match := le.clean_address.geo_match <> ri.clean_address.geo_match;
    SELF.Diff_clean_address_err_stat := le.clean_address.err_stat <> ri.clean_address.err_stat;
    SELF.Diff_append_prep_name := le.append_prep_name <> ri.append_prep_name;
    SELF.Diff_nid := le.nid <> ri.nid;
    SELF.Diff_name_ind := le.name_ind <> ri.name_ind;
    SELF.Diff_nametype := le.nametype <> ri.nametype;
    SELF.Diff_cln_title := le.cln_title <> ri.cln_title;
    SELF.Diff_cln_fname := le.cln_fname <> ri.cln_fname;
    SELF.Diff_cln_mname := le.cln_mname <> ri.cln_mname;
    SELF.Diff_cln_lname := le.cln_lname <> ri.cln_lname;
    SELF.Diff_cln_suffix := le.cln_suffix <> ri.cln_suffix;
    SELF.Diff_cln_fullname := le.cln_fullname <> ri.cln_fullname;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_process_time := le.process_time <> ri.process_time;
    SELF.Diff_date_vendor_first_reported := le.date_vendor_first_reported <> ri.date_vendor_first_reported;
    SELF.Diff_date_vendor_last_reported := le.date_vendor_last_reported <> ri.date_vendor_last_reported;
    SELF.Diff_current_rec := le.current_rec <> ri.current_rec;
    SELF.Diff_ingest_tpe := le.ingest_tpe <> ri.ingest_tpe;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_salutation,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_house,1,0)+ IF( SELF.Diff_pre_dir,1,0)+ IF( SELF.Diff_street,1,0)+ IF( SELF.Diff_street_type,1,0)+ IF( SELF.Diff_post_dir,1,0)+ IF( SELF.Diff_apt_type,1,0)+ IF( SELF.Diff_apt_nbr,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_plus4,1,0)+ IF( SELF.Diff_dpc,1,0)+ IF( SELF.Diff_z4_type,1,0)+ IF( SELF.Diff_crte,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_dpvcmra,1,0)+ IF( SELF.Diff_dpvconf,1,0)+ IF( SELF.Diff_fips_state,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_census_tract,1,0)+ IF( SELF.Diff_census_block_group,1,0)+ IF( SELF.Diff_cbsa,1,0)+ IF( SELF.Diff_match_code,1,0)+ IF( SELF.Diff_latitude,1,0)+ IF( SELF.Diff_longitude,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_verified,1,0)+ IF( SELF.Diff_activity_status,1,0)+ IF( SELF.Diff_prepaid,1,0)+ IF( SELF.Diff_cord_cutter,1,0)+ IF( SELF.Diff_raw_file_name,1,0)+ IF( SELF.Diff_rcid,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_persistent_record_id,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_xadl2_weight,1,0)+ IF( SELF.Diff_xadl2_score,1,0)+ IF( SELF.Diff_xadl2_keys_used,1,0)+ IF( SELF.Diff_xadl2_distance,1,0)+ IF( SELF.Diff_xadl2_matches,1,0)+ IF( SELF.Diff_append_prep_address_1,1,0)+ IF( SELF.Diff_append_prep_address_2,1,0)+ IF( SELF.Diff_rawaid,1,0)+ IF( SELF.Diff_aceaid,1,0)+ IF( SELF.Diff_clean_address.prim_range,1,0)+ IF( SELF.Diff_clean_address.predir,1,0)+ IF( SELF.Diff_clean_address.prim_name,1,0)+ IF( SELF.Diff_clean_address.addr_suffix,1,0)+ IF( SELF.Diff_clean_address.postdir,1,0)+ IF( SELF.Diff_clean_address.unit_desig,1,0)+ IF( SELF.Diff_clean_address.sec_range,1,0)+ IF( SELF.Diff_clean_address.p_city_name,1,0)+ IF( SELF.Diff_clean_address.v_city_name,1,0)+ IF( SELF.Diff_clean_address.st,1,0)+ IF( SELF.Diff_clean_address.zip,1,0)+ IF( SELF.Diff_clean_address.zip4,1,0)+ IF( SELF.Diff_clean_address.cart,1,0)+ IF( SELF.Diff_clean_address.cr_sort_sz,1,0)+ IF( SELF.Diff_clean_address.lot,1,0)+ IF( SELF.Diff_clean_address.lot_order,1,0)+ IF( SELF.Diff_clean_address.dbpc,1,0)+ IF( SELF.Diff_clean_address.chk_digit,1,0)+ IF( SELF.Diff_clean_address.rec_type,1,0)+ IF( SELF.Diff_clean_address.county,1,0)+ IF( SELF.Diff_clean_address.geo_lat,1,0)+ IF( SELF.Diff_clean_address.geo_long,1,0)+ IF( SELF.Diff_clean_address.msa,1,0)+ IF( SELF.Diff_clean_address.geo_blk,1,0)+ IF( SELF.Diff_clean_address.geo_match,1,0)+ IF( SELF.Diff_clean_address.err_stat,1,0)+ IF( SELF.Diff_append_prep_name,1,0)+ IF( SELF.Diff_nid,1,0)+ IF( SELF.Diff_name_ind,1,0)+ IF( SELF.Diff_nametype,1,0)+ IF( SELF.Diff_cln_title,1,0)+ IF( SELF.Diff_cln_fname,1,0)+ IF( SELF.Diff_cln_mname,1,0)+ IF( SELF.Diff_cln_lname,1,0)+ IF( SELF.Diff_cln_suffix,1,0)+ IF( SELF.Diff_cln_fullname,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_process_time,1,0)+ IF( SELF.Diff_date_vendor_first_reported,1,0)+ IF( SELF.Diff_date_vendor_last_reported,1,0)+ IF( SELF.Diff_current_rec,1,0)+ IF( SELF.Diff_ingest_tpe,1,0);
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
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_salutation := COUNT(GROUP,%Closest%.Diff_salutation);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_house := COUNT(GROUP,%Closest%.Diff_house);
    Count_Diff_pre_dir := COUNT(GROUP,%Closest%.Diff_pre_dir);
    Count_Diff_street := COUNT(GROUP,%Closest%.Diff_street);
    Count_Diff_street_type := COUNT(GROUP,%Closest%.Diff_street_type);
    Count_Diff_post_dir := COUNT(GROUP,%Closest%.Diff_post_dir);
    Count_Diff_apt_type := COUNT(GROUP,%Closest%.Diff_apt_type);
    Count_Diff_apt_nbr := COUNT(GROUP,%Closest%.Diff_apt_nbr);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_plus4 := COUNT(GROUP,%Closest%.Diff_plus4);
    Count_Diff_dpc := COUNT(GROUP,%Closest%.Diff_dpc);
    Count_Diff_z4_type := COUNT(GROUP,%Closest%.Diff_z4_type);
    Count_Diff_crte := COUNT(GROUP,%Closest%.Diff_crte);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_dpvcmra := COUNT(GROUP,%Closest%.Diff_dpvcmra);
    Count_Diff_dpvconf := COUNT(GROUP,%Closest%.Diff_dpvconf);
    Count_Diff_fips_state := COUNT(GROUP,%Closest%.Diff_fips_state);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_census_tract := COUNT(GROUP,%Closest%.Diff_census_tract);
    Count_Diff_census_block_group := COUNT(GROUP,%Closest%.Diff_census_block_group);
    Count_Diff_cbsa := COUNT(GROUP,%Closest%.Diff_cbsa);
    Count_Diff_match_code := COUNT(GROUP,%Closest%.Diff_match_code);
    Count_Diff_latitude := COUNT(GROUP,%Closest%.Diff_latitude);
    Count_Diff_longitude := COUNT(GROUP,%Closest%.Diff_longitude);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_verified := COUNT(GROUP,%Closest%.Diff_verified);
    Count_Diff_activity_status := COUNT(GROUP,%Closest%.Diff_activity_status);
    Count_Diff_prepaid := COUNT(GROUP,%Closest%.Diff_prepaid);
    Count_Diff_cord_cutter := COUNT(GROUP,%Closest%.Diff_cord_cutter);
    Count_Diff_raw_file_name := COUNT(GROUP,%Closest%.Diff_raw_file_name);
    Count_Diff_rcid := COUNT(GROUP,%Closest%.Diff_rcid);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_persistent_record_id := COUNT(GROUP,%Closest%.Diff_persistent_record_id);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_xadl2_weight := COUNT(GROUP,%Closest%.Diff_xadl2_weight);
    Count_Diff_xadl2_score := COUNT(GROUP,%Closest%.Diff_xadl2_score);
    Count_Diff_xadl2_keys_used := COUNT(GROUP,%Closest%.Diff_xadl2_keys_used);
    Count_Diff_xadl2_distance := COUNT(GROUP,%Closest%.Diff_xadl2_distance);
    Count_Diff_xadl2_matches := COUNT(GROUP,%Closest%.Diff_xadl2_matches);
    Count_Diff_append_prep_address_1 := COUNT(GROUP,%Closest%.Diff_append_prep_address_1);
    Count_Diff_append_prep_address_2 := COUNT(GROUP,%Closest%.Diff_append_prep_address_2);
    Count_Diff_rawaid := COUNT(GROUP,%Closest%.Diff_rawaid);
    Count_Diff_aceaid := COUNT(GROUP,%Closest%.Diff_aceaid);
    Count_Diff_clean_address_prim_range := COUNT(GROUP,%Closest%.Diff_clean_address_prim_range);
    Count_Diff_clean_address_predir := COUNT(GROUP,%Closest%.Diff_clean_address_predir);
    Count_Diff_clean_address_prim_name := COUNT(GROUP,%Closest%.Diff_clean_address_prim_name);
    Count_Diff_clean_address_addr_suffix := COUNT(GROUP,%Closest%.Diff_clean_address_addr_suffix);
    Count_Diff_clean_address_postdir := COUNT(GROUP,%Closest%.Diff_clean_address_postdir);
    Count_Diff_clean_address_unit_desig := COUNT(GROUP,%Closest%.Diff_clean_address_unit_desig);
    Count_Diff_clean_address_sec_range := COUNT(GROUP,%Closest%.Diff_clean_address_sec_range);
    Count_Diff_clean_address_p_city_name := COUNT(GROUP,%Closest%.Diff_clean_address_p_city_name);
    Count_Diff_clean_address_v_city_name := COUNT(GROUP,%Closest%.Diff_clean_address_v_city_name);
    Count_Diff_clean_address_st := COUNT(GROUP,%Closest%.Diff_clean_address_st);
    Count_Diff_clean_address_zip := COUNT(GROUP,%Closest%.Diff_clean_address_zip);
    Count_Diff_clean_address_zip4 := COUNT(GROUP,%Closest%.Diff_clean_address_zip4);
    Count_Diff_clean_address_cart := COUNT(GROUP,%Closest%.Diff_clean_address_cart);
    Count_Diff_clean_address_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_clean_address_cr_sort_sz);
    Count_Diff_clean_address_lot := COUNT(GROUP,%Closest%.Diff_clean_address_lot);
    Count_Diff_clean_address_lot_order := COUNT(GROUP,%Closest%.Diff_clean_address_lot_order);
    Count_Diff_clean_address_dbpc := COUNT(GROUP,%Closest%.Diff_clean_address_dbpc);
    Count_Diff_clean_address_chk_digit := COUNT(GROUP,%Closest%.Diff_clean_address_chk_digit);
    Count_Diff_clean_address_rec_type := COUNT(GROUP,%Closest%.Diff_clean_address_rec_type);
    Count_Diff_clean_address_county := COUNT(GROUP,%Closest%.Diff_clean_address_county);
    Count_Diff_clean_address_geo_lat := COUNT(GROUP,%Closest%.Diff_clean_address_geo_lat);
    Count_Diff_clean_address_geo_long := COUNT(GROUP,%Closest%.Diff_clean_address_geo_long);
    Count_Diff_clean_address_msa := COUNT(GROUP,%Closest%.Diff_clean_address_msa);
    Count_Diff_clean_address_geo_blk := COUNT(GROUP,%Closest%.Diff_clean_address_geo_blk);
    Count_Diff_clean_address_geo_match := COUNT(GROUP,%Closest%.Diff_clean_address_geo_match);
    Count_Diff_clean_address_err_stat := COUNT(GROUP,%Closest%.Diff_clean_address_err_stat);
    Count_Diff_append_prep_name := COUNT(GROUP,%Closest%.Diff_append_prep_name);
    Count_Diff_nid := COUNT(GROUP,%Closest%.Diff_nid);
    Count_Diff_name_ind := COUNT(GROUP,%Closest%.Diff_name_ind);
    Count_Diff_nametype := COUNT(GROUP,%Closest%.Diff_nametype);
    Count_Diff_cln_title := COUNT(GROUP,%Closest%.Diff_cln_title);
    Count_Diff_cln_fname := COUNT(GROUP,%Closest%.Diff_cln_fname);
    Count_Diff_cln_mname := COUNT(GROUP,%Closest%.Diff_cln_mname);
    Count_Diff_cln_lname := COUNT(GROUP,%Closest%.Diff_cln_lname);
    Count_Diff_cln_suffix := COUNT(GROUP,%Closest%.Diff_cln_suffix);
    Count_Diff_cln_fullname := COUNT(GROUP,%Closest%.Diff_cln_fullname);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_process_time := COUNT(GROUP,%Closest%.Diff_process_time);
    Count_Diff_date_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_first_reported);
    Count_Diff_date_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_last_reported);
    Count_Diff_current_rec := COUNT(GROUP,%Closest%.Diff_current_rec);
    Count_Diff_ingest_tpe := COUNT(GROUP,%Closest%.Diff_ingest_tpe);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
