IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Hunters_Fields := MODULE
 
EXPORT NumFields := 187;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_No','Invalid_Float','Invalid_Alpha','Invalid_AlphaNum','Invalid_Date','Invalid_State','Invalid_Zip');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_No' => 1,'Invalid_Float' => 2,'Invalid_Alpha' => 3,'Invalid_AlphaNum' => 4,'Invalid_Date' => 5,'Invalid_State' => 6,'Invalid_Zip' => 7,0);
 
EXPORT MakeFT_Invalid_No(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_No(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_No(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Float(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 .-/'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Float(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 .-/'))));
EXPORT InValidMessageFT_Invalid_Float(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 .-/'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ .\'-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ .\'-'))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ .\'-'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ .\'-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ .\'-'))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ .\'-'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ .\'-'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Alpha(s1);
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ .\'-'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ .\'-'),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 .-/'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Float(s1);
END;
EXPORT InValidFT_Invalid_Zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 .-/'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_Invalid_Zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 .-/'),SALT311.HygieneErrors.NotLength('0,5,9,10'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'persistent_record_id','process_date','date_first_seen','date_last_seen','score','best_ssn','did_out','source','file_id','vendor_id','source_state','source_code','file_acquired_date','_use','title_in','lname_in','fname_in','mname_in','maiden_prior','name_suffix_in','votefiller','source_voterid','dob','agecat','headhousehold','place_of_birth','occupation','maiden_name','motorvoterid','regsource','regdate','race','gender','poliparty','phone','work_phone','other_phone','active_status','votefiller2','active_other','voterstatus','resaddr1','resaddr2','res_city','res_state','res_zip','res_county','mail_addr1','mail_addr2','mail_city','mail_state','mail_zip','mail_county','historyfiller','huntfishperm','license_type_mapped','datelicense','homestate','resident','nonresident','hunt','fish','combosuper','sportsman','trap','archery','muzzle','drawing','day1','day3','day7','day14to15','dayfiller','seasonannual','lifetimepermit','landowner','family','junior','seniorcit','crewmemeber','retarded','indian','serviceman','disabled','lowincome','regioncounty','blind','huntfiller','salmon','freshwater','saltwater','lakesandresevoirs','setlinefish','trout','fallfishing','steelhead','whitejubherring','sturgeon','shellfishcrab','shellfishlobster','deer','bear','elk','moose','buffalo','antelope','sikebull','bighorn','javelina','cougar','anterless','pheasant','goose','duck','turkey','snowmobile','biggame','skipass','migbird','smallgame','sturgeon2','gun','bonus','lottery','otherbirds','huntfill1','title','fname','mname','lname','name_suffix','score_on_input','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','county_name','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_ace_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dpbc','mail_chk_digit','mail_record_type','mail_ace_fips_st','mail_fipscounty','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'persistent_record_id','process_date','date_first_seen','date_last_seen','score','best_ssn','did_out','source','file_id','vendor_id','source_state','source_code','file_acquired_date','_use','title_in','lname_in','fname_in','mname_in','maiden_prior','name_suffix_in','votefiller','source_voterid','dob','agecat','headhousehold','place_of_birth','occupation','maiden_name','motorvoterid','regsource','regdate','race','gender','poliparty','phone','work_phone','other_phone','active_status','votefiller2','active_other','voterstatus','resaddr1','resaddr2','res_city','res_state','res_zip','res_county','mail_addr1','mail_addr2','mail_city','mail_state','mail_zip','mail_county','historyfiller','huntfishperm','license_type_mapped','datelicense','homestate','resident','nonresident','hunt','fish','combosuper','sportsman','trap','archery','muzzle','drawing','day1','day3','day7','day14to15','dayfiller','seasonannual','lifetimepermit','landowner','family','junior','seniorcit','crewmemeber','retarded','indian','serviceman','disabled','lowincome','regioncounty','blind','huntfiller','salmon','freshwater','saltwater','lakesandresevoirs','setlinefish','trout','fallfishing','steelhead','whitejubherring','sturgeon','shellfishcrab','shellfishlobster','deer','bear','elk','moose','buffalo','antelope','sikebull','bighorn','javelina','cougar','anterless','pheasant','goose','duck','turkey','snowmobile','biggame','skipass','migbird','smallgame','sturgeon2','gun','bonus','lottery','otherbirds','huntfill1','title','fname','mname','lname','name_suffix','score_on_input','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','county_name','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_ace_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dpbc','mail_chk_digit','mail_record_type','mail_ace_fips_st','mail_fipscounty','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'persistent_record_id' => 0,'process_date' => 1,'date_first_seen' => 2,'date_last_seen' => 3,'score' => 4,'best_ssn' => 5,'did_out' => 6,'source' => 7,'file_id' => 8,'vendor_id' => 9,'source_state' => 10,'source_code' => 11,'file_acquired_date' => 12,'_use' => 13,'title_in' => 14,'lname_in' => 15,'fname_in' => 16,'mname_in' => 17,'maiden_prior' => 18,'name_suffix_in' => 19,'votefiller' => 20,'source_voterid' => 21,'dob' => 22,'agecat' => 23,'headhousehold' => 24,'place_of_birth' => 25,'occupation' => 26,'maiden_name' => 27,'motorvoterid' => 28,'regsource' => 29,'regdate' => 30,'race' => 31,'gender' => 32,'poliparty' => 33,'phone' => 34,'work_phone' => 35,'other_phone' => 36,'active_status' => 37,'votefiller2' => 38,'active_other' => 39,'voterstatus' => 40,'resaddr1' => 41,'resaddr2' => 42,'res_city' => 43,'res_state' => 44,'res_zip' => 45,'res_county' => 46,'mail_addr1' => 47,'mail_addr2' => 48,'mail_city' => 49,'mail_state' => 50,'mail_zip' => 51,'mail_county' => 52,'historyfiller' => 53,'huntfishperm' => 54,'license_type_mapped' => 55,'datelicense' => 56,'homestate' => 57,'resident' => 58,'nonresident' => 59,'hunt' => 60,'fish' => 61,'combosuper' => 62,'sportsman' => 63,'trap' => 64,'archery' => 65,'muzzle' => 66,'drawing' => 67,'day1' => 68,'day3' => 69,'day7' => 70,'day14to15' => 71,'dayfiller' => 72,'seasonannual' => 73,'lifetimepermit' => 74,'landowner' => 75,'family' => 76,'junior' => 77,'seniorcit' => 78,'crewmemeber' => 79,'retarded' => 80,'indian' => 81,'serviceman' => 82,'disabled' => 83,'lowincome' => 84,'regioncounty' => 85,'blind' => 86,'huntfiller' => 87,'salmon' => 88,'freshwater' => 89,'saltwater' => 90,'lakesandresevoirs' => 91,'setlinefish' => 92,'trout' => 93,'fallfishing' => 94,'steelhead' => 95,'whitejubherring' => 96,'sturgeon' => 97,'shellfishcrab' => 98,'shellfishlobster' => 99,'deer' => 100,'bear' => 101,'elk' => 102,'moose' => 103,'buffalo' => 104,'antelope' => 105,'sikebull' => 106,'bighorn' => 107,'javelina' => 108,'cougar' => 109,'anterless' => 110,'pheasant' => 111,'goose' => 112,'duck' => 113,'turkey' => 114,'snowmobile' => 115,'biggame' => 116,'skipass' => 117,'migbird' => 118,'smallgame' => 119,'sturgeon2' => 120,'gun' => 121,'bonus' => 122,'lottery' => 123,'otherbirds' => 124,'huntfill1' => 125,'title' => 126,'fname' => 127,'mname' => 128,'lname' => 129,'name_suffix' => 130,'score_on_input' => 131,'prim_range' => 132,'predir' => 133,'prim_name' => 134,'suffix' => 135,'postdir' => 136,'unit_desig' => 137,'sec_range' => 138,'p_city_name' => 139,'city_name' => 140,'st' => 141,'zip' => 142,'zip4' => 143,'cart' => 144,'cr_sort_sz' => 145,'lot' => 146,'lot_order' => 147,'dpbc' => 148,'chk_digit' => 149,'record_type' => 150,'ace_fips_st' => 151,'county' => 152,'county_name' => 153,'geo_lat' => 154,'geo_long' => 155,'msa' => 156,'geo_blk' => 157,'geo_match' => 158,'err_stat' => 159,'mail_prim_range' => 160,'mail_predir' => 161,'mail_prim_name' => 162,'mail_addr_suffix' => 163,'mail_postdir' => 164,'mail_unit_desig' => 165,'mail_sec_range' => 166,'mail_p_city_name' => 167,'mail_v_city_name' => 168,'mail_st' => 169,'mail_ace_zip' => 170,'mail_zip4' => 171,'mail_cart' => 172,'mail_cr_sort_sz' => 173,'mail_lot' => 174,'mail_lot_order' => 175,'mail_dpbc' => 176,'mail_chk_digit' => 177,'mail_record_type' => 178,'mail_ace_fips_st' => 179,'mail_fipscounty' => 180,'mail_geo_lat' => 181,'mail_geo_long' => 182,'mail_msa' => 183,'mail_geo_blk' => 184,'mail_geo_match' => 185,'mail_err_stat' => 186,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],[],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_persistent_record_id(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_persistent_record_id(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_persistent_record_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_date_first_seen(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_first_seen(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_date_last_seen(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_last_seen(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_score(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_score(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_best_ssn(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_best_ssn(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_best_ssn(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_did_out(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_did_out(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_did_out(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_source(SALT311.StrType s0) := s0;
EXPORT InValid_source(SALT311.StrType s) := 0;
EXPORT InValidMessage_source(UNSIGNED1 wh) := '';
 
EXPORT Make_file_id(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_file_id(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_file_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_vendor_id(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_vendor_id(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_vendor_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_source_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_source_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_source_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_source_code(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_source_code(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_source_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_file_acquired_date(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_file_acquired_date(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_file_acquired_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make__use(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid__use(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage__use(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_title_in(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_title_in(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_title_in(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_lname_in(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_lname_in(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_lname_in(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_fname_in(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_fname_in(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_fname_in(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mname_in(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mname_in(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mname_in(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_maiden_prior(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_maiden_prior(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_maiden_prior(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_name_suffix_in(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_name_suffix_in(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_name_suffix_in(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_votefiller(SALT311.StrType s0) := s0;
EXPORT InValid_votefiller(SALT311.StrType s) := 0;
EXPORT InValidMessage_votefiller(UNSIGNED1 wh) := '';
 
EXPORT Make_source_voterid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_source_voterid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_source_voterid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_dob(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dob(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_agecat(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_agecat(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_agecat(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_headhousehold(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_headhousehold(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_headhousehold(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_place_of_birth(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_place_of_birth(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_place_of_birth(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_occupation(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_occupation(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_occupation(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_maiden_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_maiden_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_maiden_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_motorvoterid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_motorvoterid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_motorvoterid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_regsource(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_regsource(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_regsource(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_regdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_regdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_regdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_race(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_race(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_race(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_gender(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_gender(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_poliparty(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_poliparty(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_poliparty(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_work_phone(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_work_phone(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_work_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_other_phone(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_other_phone(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_other_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_active_status(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_active_status(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_active_status(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_votefiller2(SALT311.StrType s0) := s0;
EXPORT InValid_votefiller2(SALT311.StrType s) := 0;
EXPORT InValidMessage_votefiller2(UNSIGNED1 wh) := '';
 
EXPORT Make_active_other(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_active_other(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_active_other(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_voterstatus(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_voterstatus(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_voterstatus(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_resaddr1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_resaddr1(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_resaddr1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_resaddr2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_resaddr2(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_resaddr2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_res_city(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_res_city(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_res_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_res_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_res_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_res_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_res_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_res_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_res_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_res_county(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_res_county(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_res_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_addr1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_mail_addr1(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_mail_addr1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_mail_addr2(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_addr2(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_addr2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_city(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_city(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_mail_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_mail_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_mail_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_mail_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_mail_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_mail_county(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_mail_county(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_mail_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_historyfiller(SALT311.StrType s0) := s0;
EXPORT InValid_historyfiller(SALT311.StrType s) := 0;
EXPORT InValidMessage_historyfiller(UNSIGNED1 wh) := '';
 
EXPORT Make_huntfishperm(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_huntfishperm(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_huntfishperm(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_license_type_mapped(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_license_type_mapped(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_license_type_mapped(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_datelicense(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_datelicense(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_datelicense(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_homestate(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_homestate(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_homestate(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_resident(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_resident(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_resident(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_nonresident(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_nonresident(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_nonresident(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_hunt(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_hunt(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_hunt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_fish(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_fish(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_fish(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_combosuper(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_combosuper(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_combosuper(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_sportsman(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_sportsman(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_sportsman(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_trap(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_trap(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_trap(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_archery(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_archery(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_archery(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_muzzle(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_muzzle(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_muzzle(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_drawing(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_drawing(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_drawing(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_day1(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_day1(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_day1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_day3(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_day3(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_day3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_day7(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_day7(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_day7(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_day14to15(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_day14to15(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_day14to15(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dayfiller(SALT311.StrType s0) := s0;
EXPORT InValid_dayfiller(SALT311.StrType s) := 0;
EXPORT InValidMessage_dayfiller(UNSIGNED1 wh) := '';
 
EXPORT Make_seasonannual(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_seasonannual(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_seasonannual(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_lifetimepermit(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_lifetimepermit(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_lifetimepermit(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_landowner(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_landowner(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_landowner(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_family(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_family(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_family(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_junior(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_junior(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_junior(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_seniorcit(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_seniorcit(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_seniorcit(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_crewmemeber(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_crewmemeber(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_crewmemeber(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_retarded(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_retarded(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_retarded(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_indian(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_indian(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_indian(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_serviceman(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_serviceman(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_serviceman(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_disabled(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_disabled(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_disabled(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_lowincome(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_lowincome(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_lowincome(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_regioncounty(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_regioncounty(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_regioncounty(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_blind(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_blind(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_blind(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_huntfiller(SALT311.StrType s0) := s0;
EXPORT InValid_huntfiller(SALT311.StrType s) := 0;
EXPORT InValidMessage_huntfiller(UNSIGNED1 wh) := '';
 
EXPORT Make_salmon(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_salmon(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_salmon(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_freshwater(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_freshwater(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_freshwater(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_saltwater(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_saltwater(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_saltwater(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_lakesandresevoirs(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_lakesandresevoirs(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_lakesandresevoirs(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_setlinefish(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_setlinefish(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_setlinefish(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_trout(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_trout(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_trout(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_fallfishing(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_fallfishing(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_fallfishing(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_steelhead(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_steelhead(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_steelhead(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_whitejubherring(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_whitejubherring(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_whitejubherring(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_sturgeon(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_sturgeon(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_sturgeon(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_shellfishcrab(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_shellfishcrab(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_shellfishcrab(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_shellfishlobster(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_shellfishlobster(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_shellfishlobster(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_deer(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_deer(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_deer(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_bear(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_bear(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_bear(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_elk(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_elk(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_elk(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_moose(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_moose(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_moose(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_buffalo(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_buffalo(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_buffalo(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_antelope(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_antelope(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_antelope(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_sikebull(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_sikebull(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_sikebull(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_bighorn(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_bighorn(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_bighorn(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_javelina(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_javelina(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_javelina(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_cougar(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_cougar(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_cougar(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_anterless(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_anterless(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_anterless(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_pheasant(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_pheasant(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_pheasant(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_goose(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_goose(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_goose(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_duck(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_duck(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_duck(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_turkey(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_turkey(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_turkey(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_snowmobile(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_snowmobile(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_snowmobile(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_biggame(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_biggame(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_biggame(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_skipass(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_skipass(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_skipass(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_migbird(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_migbird(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_migbird(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_smallgame(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_smallgame(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_smallgame(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_sturgeon2(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_sturgeon2(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_sturgeon2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_gun(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_gun(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_gun(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_bonus(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_bonus(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_bonus(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_lottery(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_lottery(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_lottery(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_otherbirds(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_otherbirds(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_otherbirds(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_huntfill1(SALT311.StrType s0) := s0;
EXPORT InValid_huntfill1(SALT311.StrType s) := 0;
EXPORT InValidMessage_huntfill1(UNSIGNED1 wh) := '';
 
EXPORT Make_title(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_title(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_fname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_fname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_lname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_lname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_name_suffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_name_suffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_score_on_input(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_score_on_input(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_score_on_input(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_prim_range(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_prim_range(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_predir(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_predir(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_prim_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_prim_name(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_suffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_suffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_postdir(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_postdir(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_unit_desig(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_unit_desig(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_sec_range(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_sec_range(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_p_city_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_p_city_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_city_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_city_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_st(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_st(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_zip4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_zip4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_cart(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_cart(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_cr_sort_sz(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_cr_sort_sz(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_lot(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_lot(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_lot_order(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_lot_order(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_dpbc(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_dpbc(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_dpbc(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_chk_digit(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_chk_digit(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_record_type(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_record_type(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_ace_fips_st(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_ace_fips_st(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_county(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_county(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_county_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_county_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_county_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_geo_lat(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_geo_lat(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_geo_long(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_geo_long(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_msa(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_msa(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_geo_blk(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_geo_blk(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_geo_match(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_geo_match(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_err_stat(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_err_stat(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_mail_prim_range(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_mail_prim_range(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_mail_prim_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_mail_predir(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_mail_predir(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_mail_predir(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_mail_prim_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_prim_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_prim_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_addr_suffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_addr_suffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_postdir(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_postdir(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_postdir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_unit_desig(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_unit_desig(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_unit_desig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_sec_range(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_mail_sec_range(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_mail_sec_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_mail_p_city_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_p_city_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_p_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_v_city_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_v_city_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_v_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_st(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_st(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_ace_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_mail_ace_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_mail_ace_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_mail_zip4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_mail_zip4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_mail_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_mail_cart(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_mail_cart(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_mail_cart(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_mail_cr_sort_sz(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_cr_sort_sz(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_lot(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_mail_lot(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_mail_lot(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_mail_lot_order(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_lot_order(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_lot_order(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_dpbc(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_mail_dpbc(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_mail_dpbc(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_mail_chk_digit(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_mail_chk_digit(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_mail_chk_digit(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_mail_record_type(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_record_type(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_record_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_ace_fips_st(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_mail_ace_fips_st(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_mail_ace_fips_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_mail_fipscounty(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_mail_fipscounty(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_mail_fipscounty(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_mail_geo_lat(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_mail_geo_lat(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_mail_geo_lat(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_mail_geo_long(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_mail_geo_long(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_mail_geo_long(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_mail_msa(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_mail_msa(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_mail_msa(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_mail_geo_blk(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_mail_geo_blk(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_mail_geo_blk(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_mail_geo_match(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_mail_geo_match(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_mail_geo_match(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_mail_err_stat(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_mail_err_stat(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_mail_err_stat(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_eMerges;
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
    BOOLEAN Diff_persistent_record_id;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_score;
    BOOLEAN Diff_best_ssn;
    BOOLEAN Diff_did_out;
    BOOLEAN Diff_source;
    BOOLEAN Diff_file_id;
    BOOLEAN Diff_vendor_id;
    BOOLEAN Diff_source_state;
    BOOLEAN Diff_source_code;
    BOOLEAN Diff_file_acquired_date;
    BOOLEAN Diff__use;
    BOOLEAN Diff_title_in;
    BOOLEAN Diff_lname_in;
    BOOLEAN Diff_fname_in;
    BOOLEAN Diff_mname_in;
    BOOLEAN Diff_maiden_prior;
    BOOLEAN Diff_name_suffix_in;
    BOOLEAN Diff_votefiller;
    BOOLEAN Diff_source_voterid;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_agecat;
    BOOLEAN Diff_headhousehold;
    BOOLEAN Diff_place_of_birth;
    BOOLEAN Diff_occupation;
    BOOLEAN Diff_maiden_name;
    BOOLEAN Diff_motorvoterid;
    BOOLEAN Diff_regsource;
    BOOLEAN Diff_regdate;
    BOOLEAN Diff_race;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_poliparty;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_work_phone;
    BOOLEAN Diff_other_phone;
    BOOLEAN Diff_active_status;
    BOOLEAN Diff_votefiller2;
    BOOLEAN Diff_active_other;
    BOOLEAN Diff_voterstatus;
    BOOLEAN Diff_resaddr1;
    BOOLEAN Diff_resaddr2;
    BOOLEAN Diff_res_city;
    BOOLEAN Diff_res_state;
    BOOLEAN Diff_res_zip;
    BOOLEAN Diff_res_county;
    BOOLEAN Diff_mail_addr1;
    BOOLEAN Diff_mail_addr2;
    BOOLEAN Diff_mail_city;
    BOOLEAN Diff_mail_state;
    BOOLEAN Diff_mail_zip;
    BOOLEAN Diff_mail_county;
    BOOLEAN Diff_historyfiller;
    BOOLEAN Diff_huntfishperm;
    BOOLEAN Diff_license_type_mapped;
    BOOLEAN Diff_datelicense;
    BOOLEAN Diff_homestate;
    BOOLEAN Diff_resident;
    BOOLEAN Diff_nonresident;
    BOOLEAN Diff_hunt;
    BOOLEAN Diff_fish;
    BOOLEAN Diff_combosuper;
    BOOLEAN Diff_sportsman;
    BOOLEAN Diff_trap;
    BOOLEAN Diff_archery;
    BOOLEAN Diff_muzzle;
    BOOLEAN Diff_drawing;
    BOOLEAN Diff_day1;
    BOOLEAN Diff_day3;
    BOOLEAN Diff_day7;
    BOOLEAN Diff_day14to15;
    BOOLEAN Diff_dayfiller;
    BOOLEAN Diff_seasonannual;
    BOOLEAN Diff_lifetimepermit;
    BOOLEAN Diff_landowner;
    BOOLEAN Diff_family;
    BOOLEAN Diff_junior;
    BOOLEAN Diff_seniorcit;
    BOOLEAN Diff_crewmemeber;
    BOOLEAN Diff_retarded;
    BOOLEAN Diff_indian;
    BOOLEAN Diff_serviceman;
    BOOLEAN Diff_disabled;
    BOOLEAN Diff_lowincome;
    BOOLEAN Diff_regioncounty;
    BOOLEAN Diff_blind;
    BOOLEAN Diff_huntfiller;
    BOOLEAN Diff_salmon;
    BOOLEAN Diff_freshwater;
    BOOLEAN Diff_saltwater;
    BOOLEAN Diff_lakesandresevoirs;
    BOOLEAN Diff_setlinefish;
    BOOLEAN Diff_trout;
    BOOLEAN Diff_fallfishing;
    BOOLEAN Diff_steelhead;
    BOOLEAN Diff_whitejubherring;
    BOOLEAN Diff_sturgeon;
    BOOLEAN Diff_shellfishcrab;
    BOOLEAN Diff_shellfishlobster;
    BOOLEAN Diff_deer;
    BOOLEAN Diff_bear;
    BOOLEAN Diff_elk;
    BOOLEAN Diff_moose;
    BOOLEAN Diff_buffalo;
    BOOLEAN Diff_antelope;
    BOOLEAN Diff_sikebull;
    BOOLEAN Diff_bighorn;
    BOOLEAN Diff_javelina;
    BOOLEAN Diff_cougar;
    BOOLEAN Diff_anterless;
    BOOLEAN Diff_pheasant;
    BOOLEAN Diff_goose;
    BOOLEAN Diff_duck;
    BOOLEAN Diff_turkey;
    BOOLEAN Diff_snowmobile;
    BOOLEAN Diff_biggame;
    BOOLEAN Diff_skipass;
    BOOLEAN Diff_migbird;
    BOOLEAN Diff_smallgame;
    BOOLEAN Diff_sturgeon2;
    BOOLEAN Diff_gun;
    BOOLEAN Diff_bonus;
    BOOLEAN Diff_lottery;
    BOOLEAN Diff_otherbirds;
    BOOLEAN Diff_huntfill1;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_score_on_input;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dpbc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_ace_fips_st;
    BOOLEAN Diff_county;
    BOOLEAN Diff_county_name;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_mail_prim_range;
    BOOLEAN Diff_mail_predir;
    BOOLEAN Diff_mail_prim_name;
    BOOLEAN Diff_mail_addr_suffix;
    BOOLEAN Diff_mail_postdir;
    BOOLEAN Diff_mail_unit_desig;
    BOOLEAN Diff_mail_sec_range;
    BOOLEAN Diff_mail_p_city_name;
    BOOLEAN Diff_mail_v_city_name;
    BOOLEAN Diff_mail_st;
    BOOLEAN Diff_mail_ace_zip;
    BOOLEAN Diff_mail_zip4;
    BOOLEAN Diff_mail_cart;
    BOOLEAN Diff_mail_cr_sort_sz;
    BOOLEAN Diff_mail_lot;
    BOOLEAN Diff_mail_lot_order;
    BOOLEAN Diff_mail_dpbc;
    BOOLEAN Diff_mail_chk_digit;
    BOOLEAN Diff_mail_record_type;
    BOOLEAN Diff_mail_ace_fips_st;
    BOOLEAN Diff_mail_fipscounty;
    BOOLEAN Diff_mail_geo_lat;
    BOOLEAN Diff_mail_geo_long;
    BOOLEAN Diff_mail_msa;
    BOOLEAN Diff_mail_geo_blk;
    BOOLEAN Diff_mail_geo_match;
    BOOLEAN Diff_mail_err_stat;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_persistent_record_id := le.persistent_record_id <> ri.persistent_record_id;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_score := le.score <> ri.score;
    SELF.Diff_best_ssn := le.best_ssn <> ri.best_ssn;
    SELF.Diff_did_out := le.did_out <> ri.did_out;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_file_id := le.file_id <> ri.file_id;
    SELF.Diff_vendor_id := le.vendor_id <> ri.vendor_id;
    SELF.Diff_source_state := le.source_state <> ri.source_state;
    SELF.Diff_source_code := le.source_code <> ri.source_code;
    SELF.Diff_file_acquired_date := le.file_acquired_date <> ri.file_acquired_date;
    SELF.Diff__use := le._use <> ri._use;
    SELF.Diff_title_in := le.title_in <> ri.title_in;
    SELF.Diff_lname_in := le.lname_in <> ri.lname_in;
    SELF.Diff_fname_in := le.fname_in <> ri.fname_in;
    SELF.Diff_mname_in := le.mname_in <> ri.mname_in;
    SELF.Diff_maiden_prior := le.maiden_prior <> ri.maiden_prior;
    SELF.Diff_name_suffix_in := le.name_suffix_in <> ri.name_suffix_in;
    SELF.Diff_votefiller := le.votefiller <> ri.votefiller;
    SELF.Diff_source_voterid := le.source_voterid <> ri.source_voterid;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_agecat := le.agecat <> ri.agecat;
    SELF.Diff_headhousehold := le.headhousehold <> ri.headhousehold;
    SELF.Diff_place_of_birth := le.place_of_birth <> ri.place_of_birth;
    SELF.Diff_occupation := le.occupation <> ri.occupation;
    SELF.Diff_maiden_name := le.maiden_name <> ri.maiden_name;
    SELF.Diff_motorvoterid := le.motorvoterid <> ri.motorvoterid;
    SELF.Diff_regsource := le.regsource <> ri.regsource;
    SELF.Diff_regdate := le.regdate <> ri.regdate;
    SELF.Diff_race := le.race <> ri.race;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_poliparty := le.poliparty <> ri.poliparty;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_work_phone := le.work_phone <> ri.work_phone;
    SELF.Diff_other_phone := le.other_phone <> ri.other_phone;
    SELF.Diff_active_status := le.active_status <> ri.active_status;
    SELF.Diff_votefiller2 := le.votefiller2 <> ri.votefiller2;
    SELF.Diff_active_other := le.active_other <> ri.active_other;
    SELF.Diff_voterstatus := le.voterstatus <> ri.voterstatus;
    SELF.Diff_resaddr1 := le.resaddr1 <> ri.resaddr1;
    SELF.Diff_resaddr2 := le.resaddr2 <> ri.resaddr2;
    SELF.Diff_res_city := le.res_city <> ri.res_city;
    SELF.Diff_res_state := le.res_state <> ri.res_state;
    SELF.Diff_res_zip := le.res_zip <> ri.res_zip;
    SELF.Diff_res_county := le.res_county <> ri.res_county;
    SELF.Diff_mail_addr1 := le.mail_addr1 <> ri.mail_addr1;
    SELF.Diff_mail_addr2 := le.mail_addr2 <> ri.mail_addr2;
    SELF.Diff_mail_city := le.mail_city <> ri.mail_city;
    SELF.Diff_mail_state := le.mail_state <> ri.mail_state;
    SELF.Diff_mail_zip := le.mail_zip <> ri.mail_zip;
    SELF.Diff_mail_county := le.mail_county <> ri.mail_county;
    SELF.Diff_historyfiller := le.historyfiller <> ri.historyfiller;
    SELF.Diff_huntfishperm := le.huntfishperm <> ri.huntfishperm;
    SELF.Diff_license_type_mapped := le.license_type_mapped <> ri.license_type_mapped;
    SELF.Diff_datelicense := le.datelicense <> ri.datelicense;
    SELF.Diff_homestate := le.homestate <> ri.homestate;
    SELF.Diff_resident := le.resident <> ri.resident;
    SELF.Diff_nonresident := le.nonresident <> ri.nonresident;
    SELF.Diff_hunt := le.hunt <> ri.hunt;
    SELF.Diff_fish := le.fish <> ri.fish;
    SELF.Diff_combosuper := le.combosuper <> ri.combosuper;
    SELF.Diff_sportsman := le.sportsman <> ri.sportsman;
    SELF.Diff_trap := le.trap <> ri.trap;
    SELF.Diff_archery := le.archery <> ri.archery;
    SELF.Diff_muzzle := le.muzzle <> ri.muzzle;
    SELF.Diff_drawing := le.drawing <> ri.drawing;
    SELF.Diff_day1 := le.day1 <> ri.day1;
    SELF.Diff_day3 := le.day3 <> ri.day3;
    SELF.Diff_day7 := le.day7 <> ri.day7;
    SELF.Diff_day14to15 := le.day14to15 <> ri.day14to15;
    SELF.Diff_dayfiller := le.dayfiller <> ri.dayfiller;
    SELF.Diff_seasonannual := le.seasonannual <> ri.seasonannual;
    SELF.Diff_lifetimepermit := le.lifetimepermit <> ri.lifetimepermit;
    SELF.Diff_landowner := le.landowner <> ri.landowner;
    SELF.Diff_family := le.family <> ri.family;
    SELF.Diff_junior := le.junior <> ri.junior;
    SELF.Diff_seniorcit := le.seniorcit <> ri.seniorcit;
    SELF.Diff_crewmemeber := le.crewmemeber <> ri.crewmemeber;
    SELF.Diff_retarded := le.retarded <> ri.retarded;
    SELF.Diff_indian := le.indian <> ri.indian;
    SELF.Diff_serviceman := le.serviceman <> ri.serviceman;
    SELF.Diff_disabled := le.disabled <> ri.disabled;
    SELF.Diff_lowincome := le.lowincome <> ri.lowincome;
    SELF.Diff_regioncounty := le.regioncounty <> ri.regioncounty;
    SELF.Diff_blind := le.blind <> ri.blind;
    SELF.Diff_huntfiller := le.huntfiller <> ri.huntfiller;
    SELF.Diff_salmon := le.salmon <> ri.salmon;
    SELF.Diff_freshwater := le.freshwater <> ri.freshwater;
    SELF.Diff_saltwater := le.saltwater <> ri.saltwater;
    SELF.Diff_lakesandresevoirs := le.lakesandresevoirs <> ri.lakesandresevoirs;
    SELF.Diff_setlinefish := le.setlinefish <> ri.setlinefish;
    SELF.Diff_trout := le.trout <> ri.trout;
    SELF.Diff_fallfishing := le.fallfishing <> ri.fallfishing;
    SELF.Diff_steelhead := le.steelhead <> ri.steelhead;
    SELF.Diff_whitejubherring := le.whitejubherring <> ri.whitejubherring;
    SELF.Diff_sturgeon := le.sturgeon <> ri.sturgeon;
    SELF.Diff_shellfishcrab := le.shellfishcrab <> ri.shellfishcrab;
    SELF.Diff_shellfishlobster := le.shellfishlobster <> ri.shellfishlobster;
    SELF.Diff_deer := le.deer <> ri.deer;
    SELF.Diff_bear := le.bear <> ri.bear;
    SELF.Diff_elk := le.elk <> ri.elk;
    SELF.Diff_moose := le.moose <> ri.moose;
    SELF.Diff_buffalo := le.buffalo <> ri.buffalo;
    SELF.Diff_antelope := le.antelope <> ri.antelope;
    SELF.Diff_sikebull := le.sikebull <> ri.sikebull;
    SELF.Diff_bighorn := le.bighorn <> ri.bighorn;
    SELF.Diff_javelina := le.javelina <> ri.javelina;
    SELF.Diff_cougar := le.cougar <> ri.cougar;
    SELF.Diff_anterless := le.anterless <> ri.anterless;
    SELF.Diff_pheasant := le.pheasant <> ri.pheasant;
    SELF.Diff_goose := le.goose <> ri.goose;
    SELF.Diff_duck := le.duck <> ri.duck;
    SELF.Diff_turkey := le.turkey <> ri.turkey;
    SELF.Diff_snowmobile := le.snowmobile <> ri.snowmobile;
    SELF.Diff_biggame := le.biggame <> ri.biggame;
    SELF.Diff_skipass := le.skipass <> ri.skipass;
    SELF.Diff_migbird := le.migbird <> ri.migbird;
    SELF.Diff_smallgame := le.smallgame <> ri.smallgame;
    SELF.Diff_sturgeon2 := le.sturgeon2 <> ri.sturgeon2;
    SELF.Diff_gun := le.gun <> ri.gun;
    SELF.Diff_bonus := le.bonus <> ri.bonus;
    SELF.Diff_lottery := le.lottery <> ri.lottery;
    SELF.Diff_otherbirds := le.otherbirds <> ri.otherbirds;
    SELF.Diff_huntfill1 := le.huntfill1 <> ri.huntfill1;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_score_on_input := le.score_on_input <> ri.score_on_input;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_city_name := le.city_name <> ri.city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dpbc := le.dpbc <> ri.dpbc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_ace_fips_st := le.ace_fips_st <> ri.ace_fips_st;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_county_name := le.county_name <> ri.county_name;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_mail_prim_range := le.mail_prim_range <> ri.mail_prim_range;
    SELF.Diff_mail_predir := le.mail_predir <> ri.mail_predir;
    SELF.Diff_mail_prim_name := le.mail_prim_name <> ri.mail_prim_name;
    SELF.Diff_mail_addr_suffix := le.mail_addr_suffix <> ri.mail_addr_suffix;
    SELF.Diff_mail_postdir := le.mail_postdir <> ri.mail_postdir;
    SELF.Diff_mail_unit_desig := le.mail_unit_desig <> ri.mail_unit_desig;
    SELF.Diff_mail_sec_range := le.mail_sec_range <> ri.mail_sec_range;
    SELF.Diff_mail_p_city_name := le.mail_p_city_name <> ri.mail_p_city_name;
    SELF.Diff_mail_v_city_name := le.mail_v_city_name <> ri.mail_v_city_name;
    SELF.Diff_mail_st := le.mail_st <> ri.mail_st;
    SELF.Diff_mail_ace_zip := le.mail_ace_zip <> ri.mail_ace_zip;
    SELF.Diff_mail_zip4 := le.mail_zip4 <> ri.mail_zip4;
    SELF.Diff_mail_cart := le.mail_cart <> ri.mail_cart;
    SELF.Diff_mail_cr_sort_sz := le.mail_cr_sort_sz <> ri.mail_cr_sort_sz;
    SELF.Diff_mail_lot := le.mail_lot <> ri.mail_lot;
    SELF.Diff_mail_lot_order := le.mail_lot_order <> ri.mail_lot_order;
    SELF.Diff_mail_dpbc := le.mail_dpbc <> ri.mail_dpbc;
    SELF.Diff_mail_chk_digit := le.mail_chk_digit <> ri.mail_chk_digit;
    SELF.Diff_mail_record_type := le.mail_record_type <> ri.mail_record_type;
    SELF.Diff_mail_ace_fips_st := le.mail_ace_fips_st <> ri.mail_ace_fips_st;
    SELF.Diff_mail_fipscounty := le.mail_fipscounty <> ri.mail_fipscounty;
    SELF.Diff_mail_geo_lat := le.mail_geo_lat <> ri.mail_geo_lat;
    SELF.Diff_mail_geo_long := le.mail_geo_long <> ri.mail_geo_long;
    SELF.Diff_mail_msa := le.mail_msa <> ri.mail_msa;
    SELF.Diff_mail_geo_blk := le.mail_geo_blk <> ri.mail_geo_blk;
    SELF.Diff_mail_geo_match := le.mail_geo_match <> ri.mail_geo_match;
    SELF.Diff_mail_err_stat := le.mail_err_stat <> ri.mail_err_stat;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_persistent_record_id,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_score,1,0)+ IF( SELF.Diff_best_ssn,1,0)+ IF( SELF.Diff_did_out,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_file_id,1,0)+ IF( SELF.Diff_vendor_id,1,0)+ IF( SELF.Diff_source_state,1,0)+ IF( SELF.Diff_source_code,1,0)+ IF( SELF.Diff_file_acquired_date,1,0)+ IF( SELF.Diff__use,1,0)+ IF( SELF.Diff_title_in,1,0)+ IF( SELF.Diff_lname_in,1,0)+ IF( SELF.Diff_fname_in,1,0)+ IF( SELF.Diff_mname_in,1,0)+ IF( SELF.Diff_maiden_prior,1,0)+ IF( SELF.Diff_name_suffix_in,1,0)+ IF( SELF.Diff_votefiller,1,0)+ IF( SELF.Diff_source_voterid,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_agecat,1,0)+ IF( SELF.Diff_headhousehold,1,0)+ IF( SELF.Diff_place_of_birth,1,0)+ IF( SELF.Diff_occupation,1,0)+ IF( SELF.Diff_maiden_name,1,0)+ IF( SELF.Diff_motorvoterid,1,0)+ IF( SELF.Diff_regsource,1,0)+ IF( SELF.Diff_regdate,1,0)+ IF( SELF.Diff_race,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_poliparty,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_work_phone,1,0)+ IF( SELF.Diff_other_phone,1,0)+ IF( SELF.Diff_active_status,1,0)+ IF( SELF.Diff_votefiller2,1,0)+ IF( SELF.Diff_active_other,1,0)+ IF( SELF.Diff_voterstatus,1,0)+ IF( SELF.Diff_resaddr1,1,0)+ IF( SELF.Diff_resaddr2,1,0)+ IF( SELF.Diff_res_city,1,0)+ IF( SELF.Diff_res_state,1,0)+ IF( SELF.Diff_res_zip,1,0)+ IF( SELF.Diff_res_county,1,0)+ IF( SELF.Diff_mail_addr1,1,0)+ IF( SELF.Diff_mail_addr2,1,0)+ IF( SELF.Diff_mail_city,1,0)+ IF( SELF.Diff_mail_state,1,0)+ IF( SELF.Diff_mail_zip,1,0)+ IF( SELF.Diff_mail_county,1,0)+ IF( SELF.Diff_historyfiller,1,0)+ IF( SELF.Diff_huntfishperm,1,0)+ IF( SELF.Diff_license_type_mapped,1,0)+ IF( SELF.Diff_datelicense,1,0)+ IF( SELF.Diff_homestate,1,0)+ IF( SELF.Diff_resident,1,0)+ IF( SELF.Diff_nonresident,1,0)+ IF( SELF.Diff_hunt,1,0)+ IF( SELF.Diff_fish,1,0)+ IF( SELF.Diff_combosuper,1,0)+ IF( SELF.Diff_sportsman,1,0)+ IF( SELF.Diff_trap,1,0)+ IF( SELF.Diff_archery,1,0)+ IF( SELF.Diff_muzzle,1,0)+ IF( SELF.Diff_drawing,1,0)+ IF( SELF.Diff_day1,1,0)+ IF( SELF.Diff_day3,1,0)+ IF( SELF.Diff_day7,1,0)+ IF( SELF.Diff_day14to15,1,0)+ IF( SELF.Diff_dayfiller,1,0)+ IF( SELF.Diff_seasonannual,1,0)+ IF( SELF.Diff_lifetimepermit,1,0)+ IF( SELF.Diff_landowner,1,0)+ IF( SELF.Diff_family,1,0)+ IF( SELF.Diff_junior,1,0)+ IF( SELF.Diff_seniorcit,1,0)+ IF( SELF.Diff_crewmemeber,1,0)+ IF( SELF.Diff_retarded,1,0)+ IF( SELF.Diff_indian,1,0)+ IF( SELF.Diff_serviceman,1,0)+ IF( SELF.Diff_disabled,1,0)+ IF( SELF.Diff_lowincome,1,0)+ IF( SELF.Diff_regioncounty,1,0)+ IF( SELF.Diff_blind,1,0)+ IF( SELF.Diff_huntfiller,1,0)+ IF( SELF.Diff_salmon,1,0)+ IF( SELF.Diff_freshwater,1,0)+ IF( SELF.Diff_saltwater,1,0)+ IF( SELF.Diff_lakesandresevoirs,1,0)+ IF( SELF.Diff_setlinefish,1,0)+ IF( SELF.Diff_trout,1,0)+ IF( SELF.Diff_fallfishing,1,0)+ IF( SELF.Diff_steelhead,1,0)+ IF( SELF.Diff_whitejubherring,1,0)+ IF( SELF.Diff_sturgeon,1,0)+ IF( SELF.Diff_shellfishcrab,1,0)+ IF( SELF.Diff_shellfishlobster,1,0)+ IF( SELF.Diff_deer,1,0)+ IF( SELF.Diff_bear,1,0)+ IF( SELF.Diff_elk,1,0)+ IF( SELF.Diff_moose,1,0)+ IF( SELF.Diff_buffalo,1,0)+ IF( SELF.Diff_antelope,1,0)+ IF( SELF.Diff_sikebull,1,0)+ IF( SELF.Diff_bighorn,1,0)+ IF( SELF.Diff_javelina,1,0)+ IF( SELF.Diff_cougar,1,0)+ IF( SELF.Diff_anterless,1,0)+ IF( SELF.Diff_pheasant,1,0)+ IF( SELF.Diff_goose,1,0)+ IF( SELF.Diff_duck,1,0)+ IF( SELF.Diff_turkey,1,0)+ IF( SELF.Diff_snowmobile,1,0)+ IF( SELF.Diff_biggame,1,0)+ IF( SELF.Diff_skipass,1,0)+ IF( SELF.Diff_migbird,1,0)+ IF( SELF.Diff_smallgame,1,0)+ IF( SELF.Diff_sturgeon2,1,0)+ IF( SELF.Diff_gun,1,0)+ IF( SELF.Diff_bonus,1,0)+ IF( SELF.Diff_lottery,1,0)+ IF( SELF.Diff_otherbirds,1,0)+ IF( SELF.Diff_huntfill1,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_score_on_input,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_county_name,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_mail_prim_range,1,0)+ IF( SELF.Diff_mail_predir,1,0)+ IF( SELF.Diff_mail_prim_name,1,0)+ IF( SELF.Diff_mail_addr_suffix,1,0)+ IF( SELF.Diff_mail_postdir,1,0)+ IF( SELF.Diff_mail_unit_desig,1,0)+ IF( SELF.Diff_mail_sec_range,1,0)+ IF( SELF.Diff_mail_p_city_name,1,0)+ IF( SELF.Diff_mail_v_city_name,1,0)+ IF( SELF.Diff_mail_st,1,0)+ IF( SELF.Diff_mail_ace_zip,1,0)+ IF( SELF.Diff_mail_zip4,1,0)+ IF( SELF.Diff_mail_cart,1,0)+ IF( SELF.Diff_mail_cr_sort_sz,1,0)+ IF( SELF.Diff_mail_lot,1,0)+ IF( SELF.Diff_mail_lot_order,1,0)+ IF( SELF.Diff_mail_dpbc,1,0)+ IF( SELF.Diff_mail_chk_digit,1,0)+ IF( SELF.Diff_mail_record_type,1,0)+ IF( SELF.Diff_mail_ace_fips_st,1,0)+ IF( SELF.Diff_mail_fipscounty,1,0)+ IF( SELF.Diff_mail_geo_lat,1,0)+ IF( SELF.Diff_mail_geo_long,1,0)+ IF( SELF.Diff_mail_msa,1,0)+ IF( SELF.Diff_mail_geo_blk,1,0)+ IF( SELF.Diff_mail_geo_match,1,0)+ IF( SELF.Diff_mail_err_stat,1,0);
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
    Count_Diff_persistent_record_id := COUNT(GROUP,%Closest%.Diff_persistent_record_id);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_score := COUNT(GROUP,%Closest%.Diff_score);
    Count_Diff_best_ssn := COUNT(GROUP,%Closest%.Diff_best_ssn);
    Count_Diff_did_out := COUNT(GROUP,%Closest%.Diff_did_out);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_file_id := COUNT(GROUP,%Closest%.Diff_file_id);
    Count_Diff_vendor_id := COUNT(GROUP,%Closest%.Diff_vendor_id);
    Count_Diff_source_state := COUNT(GROUP,%Closest%.Diff_source_state);
    Count_Diff_source_code := COUNT(GROUP,%Closest%.Diff_source_code);
    Count_Diff_file_acquired_date := COUNT(GROUP,%Closest%.Diff_file_acquired_date);
    Count_Diff__use := COUNT(GROUP,%Closest%.Diff__use);
    Count_Diff_title_in := COUNT(GROUP,%Closest%.Diff_title_in);
    Count_Diff_lname_in := COUNT(GROUP,%Closest%.Diff_lname_in);
    Count_Diff_fname_in := COUNT(GROUP,%Closest%.Diff_fname_in);
    Count_Diff_mname_in := COUNT(GROUP,%Closest%.Diff_mname_in);
    Count_Diff_maiden_prior := COUNT(GROUP,%Closest%.Diff_maiden_prior);
    Count_Diff_name_suffix_in := COUNT(GROUP,%Closest%.Diff_name_suffix_in);
    Count_Diff_votefiller := COUNT(GROUP,%Closest%.Diff_votefiller);
    Count_Diff_source_voterid := COUNT(GROUP,%Closest%.Diff_source_voterid);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_agecat := COUNT(GROUP,%Closest%.Diff_agecat);
    Count_Diff_headhousehold := COUNT(GROUP,%Closest%.Diff_headhousehold);
    Count_Diff_place_of_birth := COUNT(GROUP,%Closest%.Diff_place_of_birth);
    Count_Diff_occupation := COUNT(GROUP,%Closest%.Diff_occupation);
    Count_Diff_maiden_name := COUNT(GROUP,%Closest%.Diff_maiden_name);
    Count_Diff_motorvoterid := COUNT(GROUP,%Closest%.Diff_motorvoterid);
    Count_Diff_regsource := COUNT(GROUP,%Closest%.Diff_regsource);
    Count_Diff_regdate := COUNT(GROUP,%Closest%.Diff_regdate);
    Count_Diff_race := COUNT(GROUP,%Closest%.Diff_race);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_poliparty := COUNT(GROUP,%Closest%.Diff_poliparty);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_work_phone := COUNT(GROUP,%Closest%.Diff_work_phone);
    Count_Diff_other_phone := COUNT(GROUP,%Closest%.Diff_other_phone);
    Count_Diff_active_status := COUNT(GROUP,%Closest%.Diff_active_status);
    Count_Diff_votefiller2 := COUNT(GROUP,%Closest%.Diff_votefiller2);
    Count_Diff_active_other := COUNT(GROUP,%Closest%.Diff_active_other);
    Count_Diff_voterstatus := COUNT(GROUP,%Closest%.Diff_voterstatus);
    Count_Diff_resaddr1 := COUNT(GROUP,%Closest%.Diff_resaddr1);
    Count_Diff_resaddr2 := COUNT(GROUP,%Closest%.Diff_resaddr2);
    Count_Diff_res_city := COUNT(GROUP,%Closest%.Diff_res_city);
    Count_Diff_res_state := COUNT(GROUP,%Closest%.Diff_res_state);
    Count_Diff_res_zip := COUNT(GROUP,%Closest%.Diff_res_zip);
    Count_Diff_res_county := COUNT(GROUP,%Closest%.Diff_res_county);
    Count_Diff_mail_addr1 := COUNT(GROUP,%Closest%.Diff_mail_addr1);
    Count_Diff_mail_addr2 := COUNT(GROUP,%Closest%.Diff_mail_addr2);
    Count_Diff_mail_city := COUNT(GROUP,%Closest%.Diff_mail_city);
    Count_Diff_mail_state := COUNT(GROUP,%Closest%.Diff_mail_state);
    Count_Diff_mail_zip := COUNT(GROUP,%Closest%.Diff_mail_zip);
    Count_Diff_mail_county := COUNT(GROUP,%Closest%.Diff_mail_county);
    Count_Diff_historyfiller := COUNT(GROUP,%Closest%.Diff_historyfiller);
    Count_Diff_huntfishperm := COUNT(GROUP,%Closest%.Diff_huntfishperm);
    Count_Diff_license_type_mapped := COUNT(GROUP,%Closest%.Diff_license_type_mapped);
    Count_Diff_datelicense := COUNT(GROUP,%Closest%.Diff_datelicense);
    Count_Diff_homestate := COUNT(GROUP,%Closest%.Diff_homestate);
    Count_Diff_resident := COUNT(GROUP,%Closest%.Diff_resident);
    Count_Diff_nonresident := COUNT(GROUP,%Closest%.Diff_nonresident);
    Count_Diff_hunt := COUNT(GROUP,%Closest%.Diff_hunt);
    Count_Diff_fish := COUNT(GROUP,%Closest%.Diff_fish);
    Count_Diff_combosuper := COUNT(GROUP,%Closest%.Diff_combosuper);
    Count_Diff_sportsman := COUNT(GROUP,%Closest%.Diff_sportsman);
    Count_Diff_trap := COUNT(GROUP,%Closest%.Diff_trap);
    Count_Diff_archery := COUNT(GROUP,%Closest%.Diff_archery);
    Count_Diff_muzzle := COUNT(GROUP,%Closest%.Diff_muzzle);
    Count_Diff_drawing := COUNT(GROUP,%Closest%.Diff_drawing);
    Count_Diff_day1 := COUNT(GROUP,%Closest%.Diff_day1);
    Count_Diff_day3 := COUNT(GROUP,%Closest%.Diff_day3);
    Count_Diff_day7 := COUNT(GROUP,%Closest%.Diff_day7);
    Count_Diff_day14to15 := COUNT(GROUP,%Closest%.Diff_day14to15);
    Count_Diff_dayfiller := COUNT(GROUP,%Closest%.Diff_dayfiller);
    Count_Diff_seasonannual := COUNT(GROUP,%Closest%.Diff_seasonannual);
    Count_Diff_lifetimepermit := COUNT(GROUP,%Closest%.Diff_lifetimepermit);
    Count_Diff_landowner := COUNT(GROUP,%Closest%.Diff_landowner);
    Count_Diff_family := COUNT(GROUP,%Closest%.Diff_family);
    Count_Diff_junior := COUNT(GROUP,%Closest%.Diff_junior);
    Count_Diff_seniorcit := COUNT(GROUP,%Closest%.Diff_seniorcit);
    Count_Diff_crewmemeber := COUNT(GROUP,%Closest%.Diff_crewmemeber);
    Count_Diff_retarded := COUNT(GROUP,%Closest%.Diff_retarded);
    Count_Diff_indian := COUNT(GROUP,%Closest%.Diff_indian);
    Count_Diff_serviceman := COUNT(GROUP,%Closest%.Diff_serviceman);
    Count_Diff_disabled := COUNT(GROUP,%Closest%.Diff_disabled);
    Count_Diff_lowincome := COUNT(GROUP,%Closest%.Diff_lowincome);
    Count_Diff_regioncounty := COUNT(GROUP,%Closest%.Diff_regioncounty);
    Count_Diff_blind := COUNT(GROUP,%Closest%.Diff_blind);
    Count_Diff_huntfiller := COUNT(GROUP,%Closest%.Diff_huntfiller);
    Count_Diff_salmon := COUNT(GROUP,%Closest%.Diff_salmon);
    Count_Diff_freshwater := COUNT(GROUP,%Closest%.Diff_freshwater);
    Count_Diff_saltwater := COUNT(GROUP,%Closest%.Diff_saltwater);
    Count_Diff_lakesandresevoirs := COUNT(GROUP,%Closest%.Diff_lakesandresevoirs);
    Count_Diff_setlinefish := COUNT(GROUP,%Closest%.Diff_setlinefish);
    Count_Diff_trout := COUNT(GROUP,%Closest%.Diff_trout);
    Count_Diff_fallfishing := COUNT(GROUP,%Closest%.Diff_fallfishing);
    Count_Diff_steelhead := COUNT(GROUP,%Closest%.Diff_steelhead);
    Count_Diff_whitejubherring := COUNT(GROUP,%Closest%.Diff_whitejubherring);
    Count_Diff_sturgeon := COUNT(GROUP,%Closest%.Diff_sturgeon);
    Count_Diff_shellfishcrab := COUNT(GROUP,%Closest%.Diff_shellfishcrab);
    Count_Diff_shellfishlobster := COUNT(GROUP,%Closest%.Diff_shellfishlobster);
    Count_Diff_deer := COUNT(GROUP,%Closest%.Diff_deer);
    Count_Diff_bear := COUNT(GROUP,%Closest%.Diff_bear);
    Count_Diff_elk := COUNT(GROUP,%Closest%.Diff_elk);
    Count_Diff_moose := COUNT(GROUP,%Closest%.Diff_moose);
    Count_Diff_buffalo := COUNT(GROUP,%Closest%.Diff_buffalo);
    Count_Diff_antelope := COUNT(GROUP,%Closest%.Diff_antelope);
    Count_Diff_sikebull := COUNT(GROUP,%Closest%.Diff_sikebull);
    Count_Diff_bighorn := COUNT(GROUP,%Closest%.Diff_bighorn);
    Count_Diff_javelina := COUNT(GROUP,%Closest%.Diff_javelina);
    Count_Diff_cougar := COUNT(GROUP,%Closest%.Diff_cougar);
    Count_Diff_anterless := COUNT(GROUP,%Closest%.Diff_anterless);
    Count_Diff_pheasant := COUNT(GROUP,%Closest%.Diff_pheasant);
    Count_Diff_goose := COUNT(GROUP,%Closest%.Diff_goose);
    Count_Diff_duck := COUNT(GROUP,%Closest%.Diff_duck);
    Count_Diff_turkey := COUNT(GROUP,%Closest%.Diff_turkey);
    Count_Diff_snowmobile := COUNT(GROUP,%Closest%.Diff_snowmobile);
    Count_Diff_biggame := COUNT(GROUP,%Closest%.Diff_biggame);
    Count_Diff_skipass := COUNT(GROUP,%Closest%.Diff_skipass);
    Count_Diff_migbird := COUNT(GROUP,%Closest%.Diff_migbird);
    Count_Diff_smallgame := COUNT(GROUP,%Closest%.Diff_smallgame);
    Count_Diff_sturgeon2 := COUNT(GROUP,%Closest%.Diff_sturgeon2);
    Count_Diff_gun := COUNT(GROUP,%Closest%.Diff_gun);
    Count_Diff_bonus := COUNT(GROUP,%Closest%.Diff_bonus);
    Count_Diff_lottery := COUNT(GROUP,%Closest%.Diff_lottery);
    Count_Diff_otherbirds := COUNT(GROUP,%Closest%.Diff_otherbirds);
    Count_Diff_huntfill1 := COUNT(GROUP,%Closest%.Diff_huntfill1);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_score_on_input := COUNT(GROUP,%Closest%.Diff_score_on_input);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_city_name := COUNT(GROUP,%Closest%.Diff_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dpbc := COUNT(GROUP,%Closest%.Diff_dpbc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_ace_fips_st := COUNT(GROUP,%Closest%.Diff_ace_fips_st);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_county_name := COUNT(GROUP,%Closest%.Diff_county_name);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_mail_prim_range := COUNT(GROUP,%Closest%.Diff_mail_prim_range);
    Count_Diff_mail_predir := COUNT(GROUP,%Closest%.Diff_mail_predir);
    Count_Diff_mail_prim_name := COUNT(GROUP,%Closest%.Diff_mail_prim_name);
    Count_Diff_mail_addr_suffix := COUNT(GROUP,%Closest%.Diff_mail_addr_suffix);
    Count_Diff_mail_postdir := COUNT(GROUP,%Closest%.Diff_mail_postdir);
    Count_Diff_mail_unit_desig := COUNT(GROUP,%Closest%.Diff_mail_unit_desig);
    Count_Diff_mail_sec_range := COUNT(GROUP,%Closest%.Diff_mail_sec_range);
    Count_Diff_mail_p_city_name := COUNT(GROUP,%Closest%.Diff_mail_p_city_name);
    Count_Diff_mail_v_city_name := COUNT(GROUP,%Closest%.Diff_mail_v_city_name);
    Count_Diff_mail_st := COUNT(GROUP,%Closest%.Diff_mail_st);
    Count_Diff_mail_ace_zip := COUNT(GROUP,%Closest%.Diff_mail_ace_zip);
    Count_Diff_mail_zip4 := COUNT(GROUP,%Closest%.Diff_mail_zip4);
    Count_Diff_mail_cart := COUNT(GROUP,%Closest%.Diff_mail_cart);
    Count_Diff_mail_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_mail_cr_sort_sz);
    Count_Diff_mail_lot := COUNT(GROUP,%Closest%.Diff_mail_lot);
    Count_Diff_mail_lot_order := COUNT(GROUP,%Closest%.Diff_mail_lot_order);
    Count_Diff_mail_dpbc := COUNT(GROUP,%Closest%.Diff_mail_dpbc);
    Count_Diff_mail_chk_digit := COUNT(GROUP,%Closest%.Diff_mail_chk_digit);
    Count_Diff_mail_record_type := COUNT(GROUP,%Closest%.Diff_mail_record_type);
    Count_Diff_mail_ace_fips_st := COUNT(GROUP,%Closest%.Diff_mail_ace_fips_st);
    Count_Diff_mail_fipscounty := COUNT(GROUP,%Closest%.Diff_mail_fipscounty);
    Count_Diff_mail_geo_lat := COUNT(GROUP,%Closest%.Diff_mail_geo_lat);
    Count_Diff_mail_geo_long := COUNT(GROUP,%Closest%.Diff_mail_geo_long);
    Count_Diff_mail_msa := COUNT(GROUP,%Closest%.Diff_mail_msa);
    Count_Diff_mail_geo_blk := COUNT(GROUP,%Closest%.Diff_mail_geo_blk);
    Count_Diff_mail_geo_match := COUNT(GROUP,%Closest%.Diff_mail_geo_match);
    Count_Diff_mail_err_stat := COUNT(GROUP,%Closest%.Diff_mail_err_stat);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
