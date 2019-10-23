IMPORT SALT39;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Party_Fields := MODULE
 
EXPORT NumFields := 234;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Date','Invalid_Num','Invalid_Letter','Invalid_Char','Invalid_RuledAgainstCode','Invalid_EntityNMFormat','Invalid_Entity1TypeCode');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'Invalid_Date' => 1,'Invalid_Num' => 2,'Invalid_Letter' => 3,'Invalid_Char' => 4,'Invalid_RuledAgainstCode' => 5,'Invalid_EntityNMFormat' => 6,'Invalid_Entity1TypeCode' => 7,0);
 
EXPORT MakeFT_Invalid_Date(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT39.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 -'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 -'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 -'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Letter(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -./abcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Letter(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -./abcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_Invalid_Letter(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -./abcdefghijklmnopqrstuvwxyz'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -*,().&\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -*,().&\''))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -*,().&\''),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_RuledAgainstCode(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_RuledAgainstCode(SALT39.StrType s) := WHICH(((SALT39.StrType) s) NOT IN ['P','A','F','O','D','B','']);
EXPORT InValidMessageFT_Invalid_RuledAgainstCode(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInEnum('P|A|F|O|D|B|'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_EntityNMFormat(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_EntityNMFormat(SALT39.StrType s) := WHICH(((SALT39.StrType) s) NOT IN ['L','F','U']);
EXPORT InValidMessageFT_Invalid_EntityNMFormat(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInEnum('L|F|U'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Entity1TypeCode(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Entity1TypeCode(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_Invalid_Entity1TypeCode(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_first_reported','dt_last_reported','process_date','vendor','state_origin','source_file','case_key','parent_case_key','court_code','court','case_number','case_type_code','case_type','case_title','ruled_for_against_code','ruled_for_against','entity_1','entity_nm_format_1','entity_type_code_1_orig','entity_type_description_1_orig','entity_type_code_1_master','entity_seq_num_1','atty_seq_num_1','entity_1_address_1','entity_1_address_2','entity_1_address_3','entity_1_address_4','entity_1_dob','primary_entity_2','entity_nm_format_2','entity_type_code_2_orig','entity_type_description_2_orig','entity_type_code_2_master','entity_seq_num_2','atty_seq_num_2','entity_2_address_1','entity_2_address_2','entity_2_address_3','entity_2_address_4','entity_2_dob','prim_range1','predir1','prim_name1','addr_suffix1','postdir1','unit_desig1','sec_range1','p_city_name1','v_city_name1','st1','zip1','zip41','cart1','cr_sort_sz1','lot1','lot_order1','dpbc1','chk_digit1','rec_type1','ace_fips_st1','ace_fips_county1','geo_lat1','geo_long1','msa1','geo_blk1','geo_match1','err_stat1','prim_range2','predir2','prim_name2','addr_suffix2','postdir2','unit_desig2','sec_range2','p_city_name2','v_city_name2','st2','zip2','zip42','cart2','cr_sort_sz2','lot2','lot_order2','dpbc2','chk_digit2','rec_type2','ace_fips_st2','ace_fips_county2','geo_lat2','geo_long2','msa2','geo_blk2','geo_match2','err_stat2','e1_title1','e1_fname1','e1_mname1','e1_lname1','e1_suffix1','e1_pname1_score','e1_cname1','e1_title2','e1_fname2','e1_mname2','e1_lname2','e1_suffix2','e1_pname2_score','e1_cname2','e1_title3','e1_fname3','e1_mname3','e1_lname3','e1_suffix3','e1_pname3_score','e1_cname3','e1_title4','e1_fname4','e1_mname4','e1_lname4','e1_suffix4','e1_pname4_score','e1_cname4','e1_title5','e1_fname5','e1_mname5','e1_lname5','e1_suffix5','e1_pname5_score','e1_cname5','e2_title1','e2_fname1','e2_mname1','e2_lname1','e2_suffix1','e2_pname1_score','e2_cname1','e2_title2','e2_fname2','e2_mname2','e2_lname2','e2_suffix2','e2_pname2_score','e2_cname2','e2_title3','e2_fname3','e2_mname3','e2_lname3','e2_suffix3','e2_pname3_score','e2_cname3','e2_title4','e2_fname4','e2_mname4','e2_lname4','e2_suffix4','e2_pname4_score','e2_cname4','e2_title5','e2_fname5','e2_mname5','e2_lname5','e2_suffix5','e2_pname5_score','e2_cname5','v1_title1','v1_fname1','v1_mname1','v1_lname1','v1_suffix1','v1_pname1_score','v1_cname1','v1_title2','v1_fname2','v1_mname2','v1_lname2','v1_suffix2','v1_pname2_score','v1_cname2','v1_title3','v1_fname3','v1_mname3','v1_lname3','v1_suffix3','v1_pname3_score','v1_cname3','v1_title4','v1_fname4','v1_mname4','v1_lname4','v1_suffix4','v1_pname4_score','v1_cname4','v1_title5','v1_fname5','v1_mname5','v1_lname5','v1_suffix5','v1_pname5_score','v1_cname5','v2_title1','v2_fname1','v2_mname1','v2_lname1','v2_suffix1','v2_pname1_score','v2_cname1','v2_title2','v2_fname2','v2_mname2','v2_lname2','v2_suffix2','v2_pname2_score','v2_cname2','v2_title3','v2_fname3','v2_mname3','v2_lname3','v2_suffix3','v2_pname3_score','v2_cname3','v2_title4','v2_fname4','v2_mname4','v2_lname4','v2_suffix4','v2_pname4_score','v2_cname4','v2_title5','v2_fname5','v2_mname5','v2_lname5','v2_suffix5','v2_pname5_score','v2_cname5');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dt_first_reported','dt_last_reported','process_date','vendor','state_origin','source_file','case_key','parent_case_key','court_code','court','case_number','case_type_code','case_type','case_title','ruled_for_against_code','ruled_for_against','entity_1','entity_nm_format_1','entity_type_code_1_orig','entity_type_description_1_orig','entity_type_code_1_master','entity_seq_num_1','atty_seq_num_1','entity_1_address_1','entity_1_address_2','entity_1_address_3','entity_1_address_4','entity_1_dob','primary_entity_2','entity_nm_format_2','entity_type_code_2_orig','entity_type_description_2_orig','entity_type_code_2_master','entity_seq_num_2','atty_seq_num_2','entity_2_address_1','entity_2_address_2','entity_2_address_3','entity_2_address_4','entity_2_dob','prim_range1','predir1','prim_name1','addr_suffix1','postdir1','unit_desig1','sec_range1','p_city_name1','v_city_name1','st1','zip1','zip41','cart1','cr_sort_sz1','lot1','lot_order1','dpbc1','chk_digit1','rec_type1','ace_fips_st1','ace_fips_county1','geo_lat1','geo_long1','msa1','geo_blk1','geo_match1','err_stat1','prim_range2','predir2','prim_name2','addr_suffix2','postdir2','unit_desig2','sec_range2','p_city_name2','v_city_name2','st2','zip2','zip42','cart2','cr_sort_sz2','lot2','lot_order2','dpbc2','chk_digit2','rec_type2','ace_fips_st2','ace_fips_county2','geo_lat2','geo_long2','msa2','geo_blk2','geo_match2','err_stat2','e1_title1','e1_fname1','e1_mname1','e1_lname1','e1_suffix1','e1_pname1_score','e1_cname1','e1_title2','e1_fname2','e1_mname2','e1_lname2','e1_suffix2','e1_pname2_score','e1_cname2','e1_title3','e1_fname3','e1_mname3','e1_lname3','e1_suffix3','e1_pname3_score','e1_cname3','e1_title4','e1_fname4','e1_mname4','e1_lname4','e1_suffix4','e1_pname4_score','e1_cname4','e1_title5','e1_fname5','e1_mname5','e1_lname5','e1_suffix5','e1_pname5_score','e1_cname5','e2_title1','e2_fname1','e2_mname1','e2_lname1','e2_suffix1','e2_pname1_score','e2_cname1','e2_title2','e2_fname2','e2_mname2','e2_lname2','e2_suffix2','e2_pname2_score','e2_cname2','e2_title3','e2_fname3','e2_mname3','e2_lname3','e2_suffix3','e2_pname3_score','e2_cname3','e2_title4','e2_fname4','e2_mname4','e2_lname4','e2_suffix4','e2_pname4_score','e2_cname4','e2_title5','e2_fname5','e2_mname5','e2_lname5','e2_suffix5','e2_pname5_score','e2_cname5','v1_title1','v1_fname1','v1_mname1','v1_lname1','v1_suffix1','v1_pname1_score','v1_cname1','v1_title2','v1_fname2','v1_mname2','v1_lname2','v1_suffix2','v1_pname2_score','v1_cname2','v1_title3','v1_fname3','v1_mname3','v1_lname3','v1_suffix3','v1_pname3_score','v1_cname3','v1_title4','v1_fname4','v1_mname4','v1_lname4','v1_suffix4','v1_pname4_score','v1_cname4','v1_title5','v1_fname5','v1_mname5','v1_lname5','v1_suffix5','v1_pname5_score','v1_cname5','v2_title1','v2_fname1','v2_mname1','v2_lname1','v2_suffix1','v2_pname1_score','v2_cname1','v2_title2','v2_fname2','v2_mname2','v2_lname2','v2_suffix2','v2_pname2_score','v2_cname2','v2_title3','v2_fname3','v2_mname3','v2_lname3','v2_suffix3','v2_pname3_score','v2_cname3','v2_title4','v2_fname4','v2_mname4','v2_lname4','v2_suffix4','v2_pname4_score','v2_cname4','v2_title5','v2_fname5','v2_mname5','v2_lname5','v2_suffix5','v2_pname5_score','v2_cname5');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'dt_first_reported' => 0,'dt_last_reported' => 1,'process_date' => 2,'vendor' => 3,'state_origin' => 4,'source_file' => 5,'case_key' => 6,'parent_case_key' => 7,'court_code' => 8,'court' => 9,'case_number' => 10,'case_type_code' => 11,'case_type' => 12,'case_title' => 13,'ruled_for_against_code' => 14,'ruled_for_against' => 15,'entity_1' => 16,'entity_nm_format_1' => 17,'entity_type_code_1_orig' => 18,'entity_type_description_1_orig' => 19,'entity_type_code_1_master' => 20,'entity_seq_num_1' => 21,'atty_seq_num_1' => 22,'entity_1_address_1' => 23,'entity_1_address_2' => 24,'entity_1_address_3' => 25,'entity_1_address_4' => 26,'entity_1_dob' => 27,'primary_entity_2' => 28,'entity_nm_format_2' => 29,'entity_type_code_2_orig' => 30,'entity_type_description_2_orig' => 31,'entity_type_code_2_master' => 32,'entity_seq_num_2' => 33,'atty_seq_num_2' => 34,'entity_2_address_1' => 35,'entity_2_address_2' => 36,'entity_2_address_3' => 37,'entity_2_address_4' => 38,'entity_2_dob' => 39,'prim_range1' => 40,'predir1' => 41,'prim_name1' => 42,'addr_suffix1' => 43,'postdir1' => 44,'unit_desig1' => 45,'sec_range1' => 46,'p_city_name1' => 47,'v_city_name1' => 48,'st1' => 49,'zip1' => 50,'zip41' => 51,'cart1' => 52,'cr_sort_sz1' => 53,'lot1' => 54,'lot_order1' => 55,'dpbc1' => 56,'chk_digit1' => 57,'rec_type1' => 58,'ace_fips_st1' => 59,'ace_fips_county1' => 60,'geo_lat1' => 61,'geo_long1' => 62,'msa1' => 63,'geo_blk1' => 64,'geo_match1' => 65,'err_stat1' => 66,'prim_range2' => 67,'predir2' => 68,'prim_name2' => 69,'addr_suffix2' => 70,'postdir2' => 71,'unit_desig2' => 72,'sec_range2' => 73,'p_city_name2' => 74,'v_city_name2' => 75,'st2' => 76,'zip2' => 77,'zip42' => 78,'cart2' => 79,'cr_sort_sz2' => 80,'lot2' => 81,'lot_order2' => 82,'dpbc2' => 83,'chk_digit2' => 84,'rec_type2' => 85,'ace_fips_st2' => 86,'ace_fips_county2' => 87,'geo_lat2' => 88,'geo_long2' => 89,'msa2' => 90,'geo_blk2' => 91,'geo_match2' => 92,'err_stat2' => 93,'e1_title1' => 94,'e1_fname1' => 95,'e1_mname1' => 96,'e1_lname1' => 97,'e1_suffix1' => 98,'e1_pname1_score' => 99,'e1_cname1' => 100,'e1_title2' => 101,'e1_fname2' => 102,'e1_mname2' => 103,'e1_lname2' => 104,'e1_suffix2' => 105,'e1_pname2_score' => 106,'e1_cname2' => 107,'e1_title3' => 108,'e1_fname3' => 109,'e1_mname3' => 110,'e1_lname3' => 111,'e1_suffix3' => 112,'e1_pname3_score' => 113,'e1_cname3' => 114,'e1_title4' => 115,'e1_fname4' => 116,'e1_mname4' => 117,'e1_lname4' => 118,'e1_suffix4' => 119,'e1_pname4_score' => 120,'e1_cname4' => 121,'e1_title5' => 122,'e1_fname5' => 123,'e1_mname5' => 124,'e1_lname5' => 125,'e1_suffix5' => 126,'e1_pname5_score' => 127,'e1_cname5' => 128,'e2_title1' => 129,'e2_fname1' => 130,'e2_mname1' => 131,'e2_lname1' => 132,'e2_suffix1' => 133,'e2_pname1_score' => 134,'e2_cname1' => 135,'e2_title2' => 136,'e2_fname2' => 137,'e2_mname2' => 138,'e2_lname2' => 139,'e2_suffix2' => 140,'e2_pname2_score' => 141,'e2_cname2' => 142,'e2_title3' => 143,'e2_fname3' => 144,'e2_mname3' => 145,'e2_lname3' => 146,'e2_suffix3' => 147,'e2_pname3_score' => 148,'e2_cname3' => 149,'e2_title4' => 150,'e2_fname4' => 151,'e2_mname4' => 152,'e2_lname4' => 153,'e2_suffix4' => 154,'e2_pname4_score' => 155,'e2_cname4' => 156,'e2_title5' => 157,'e2_fname5' => 158,'e2_mname5' => 159,'e2_lname5' => 160,'e2_suffix5' => 161,'e2_pname5_score' => 162,'e2_cname5' => 163,'v1_title1' => 164,'v1_fname1' => 165,'v1_mname1' => 166,'v1_lname1' => 167,'v1_suffix1' => 168,'v1_pname1_score' => 169,'v1_cname1' => 170,'v1_title2' => 171,'v1_fname2' => 172,'v1_mname2' => 173,'v1_lname2' => 174,'v1_suffix2' => 175,'v1_pname2_score' => 176,'v1_cname2' => 177,'v1_title3' => 178,'v1_fname3' => 179,'v1_mname3' => 180,'v1_lname3' => 181,'v1_suffix3' => 182,'v1_pname3_score' => 183,'v1_cname3' => 184,'v1_title4' => 185,'v1_fname4' => 186,'v1_mname4' => 187,'v1_lname4' => 188,'v1_suffix4' => 189,'v1_pname4_score' => 190,'v1_cname4' => 191,'v1_title5' => 192,'v1_fname5' => 193,'v1_mname5' => 194,'v1_lname5' => 195,'v1_suffix5' => 196,'v1_pname5_score' => 197,'v1_cname5' => 198,'v2_title1' => 199,'v2_fname1' => 200,'v2_mname1' => 201,'v2_lname1' => 202,'v2_suffix1' => 203,'v2_pname1_score' => 204,'v2_cname1' => 205,'v2_title2' => 206,'v2_fname2' => 207,'v2_mname2' => 208,'v2_lname2' => 209,'v2_suffix2' => 210,'v2_pname2_score' => 211,'v2_cname2' => 212,'v2_title3' => 213,'v2_fname3' => 214,'v2_mname3' => 215,'v2_lname3' => 216,'v2_suffix3' => 217,'v2_pname3_score' => 218,'v2_cname3' => 219,'v2_title4' => 220,'v2_fname4' => 221,'v2_mname4' => 222,'v2_lname4' => 223,'v2_suffix4' => 224,'v2_pname4_score' => 225,'v2_cname4' => 226,'v2_title5' => 227,'v2_fname5' => 228,'v2_mname5' => 229,'v2_lname5' => 230,'v2_suffix5' => 231,'v2_pname5_score' => 232,'v2_cname5' => 233,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],[],[],['ENUM'],[],['ALLOW'],['ENUM'],['ALLOW'],[],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],[],[],[],[],['ALLOW'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dt_first_reported(SALT39.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_first_reported(SALT39.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_first_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_last_reported(SALT39.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_last_reported(SALT39.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_last_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_process_date(SALT39.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_process_date(SALT39.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_vendor(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_vendor(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_vendor(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_state_origin(SALT39.StrType s0) := MakeFT_Invalid_Letter(s0);
EXPORT InValid_state_origin(SALT39.StrType s) := InValidFT_Invalid_Letter(s);
EXPORT InValidMessage_state_origin(UNSIGNED1 wh) := InValidMessageFT_Invalid_Letter(wh);
 
EXPORT Make_source_file(SALT39.StrType s0) := s0;
EXPORT InValid_source_file(SALT39.StrType s) := 0;
EXPORT InValidMessage_source_file(UNSIGNED1 wh) := '';
 
EXPORT Make_case_key(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_case_key(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_case_key(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_parent_case_key(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_parent_case_key(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_parent_case_key(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_court_code(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_court_code(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_court_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_court(SALT39.StrType s0) := s0;
EXPORT InValid_court(SALT39.StrType s) := 0;
EXPORT InValidMessage_court(UNSIGNED1 wh) := '';
 
EXPORT Make_case_number(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_case_number(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_case_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_case_type_code(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_case_type_code(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_case_type_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_case_type(SALT39.StrType s0) := s0;
EXPORT InValid_case_type(SALT39.StrType s) := 0;
EXPORT InValidMessage_case_type(UNSIGNED1 wh) := '';
 
EXPORT Make_case_title(SALT39.StrType s0) := s0;
EXPORT InValid_case_title(SALT39.StrType s) := 0;
EXPORT InValidMessage_case_title(UNSIGNED1 wh) := '';
 
EXPORT Make_ruled_for_against_code(SALT39.StrType s0) := MakeFT_Invalid_RuledAgainstCode(s0);
EXPORT InValid_ruled_for_against_code(SALT39.StrType s) := InValidFT_Invalid_RuledAgainstCode(s);
EXPORT InValidMessage_ruled_for_against_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_RuledAgainstCode(wh);
 
EXPORT Make_ruled_for_against(SALT39.StrType s0) := s0;
EXPORT InValid_ruled_for_against(SALT39.StrType s) := 0;
EXPORT InValidMessage_ruled_for_against(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_1(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_entity_1(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_entity_1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_entity_nm_format_1(SALT39.StrType s0) := MakeFT_Invalid_EntityNMFormat(s0);
EXPORT InValid_entity_nm_format_1(SALT39.StrType s) := InValidFT_Invalid_EntityNMFormat(s);
EXPORT InValidMessage_entity_nm_format_1(UNSIGNED1 wh) := InValidMessageFT_Invalid_EntityNMFormat(wh);
 
EXPORT Make_entity_type_code_1_orig(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_entity_type_code_1_orig(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_entity_type_code_1_orig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_entity_type_description_1_orig(SALT39.StrType s0) := s0;
EXPORT InValid_entity_type_description_1_orig(SALT39.StrType s) := 0;
EXPORT InValidMessage_entity_type_description_1_orig(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_type_code_1_master(SALT39.StrType s0) := MakeFT_Invalid_Entity1TypeCode(s0);
EXPORT InValid_entity_type_code_1_master(SALT39.StrType s) := InValidFT_Invalid_Entity1TypeCode(s);
EXPORT InValidMessage_entity_type_code_1_master(UNSIGNED1 wh) := InValidMessageFT_Invalid_Entity1TypeCode(wh);
 
EXPORT Make_entity_seq_num_1(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_entity_seq_num_1(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_entity_seq_num_1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_atty_seq_num_1(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_atty_seq_num_1(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_atty_seq_num_1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_entity_1_address_1(SALT39.StrType s0) := s0;
EXPORT InValid_entity_1_address_1(SALT39.StrType s) := 0;
EXPORT InValidMessage_entity_1_address_1(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_1_address_2(SALT39.StrType s0) := s0;
EXPORT InValid_entity_1_address_2(SALT39.StrType s) := 0;
EXPORT InValidMessage_entity_1_address_2(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_1_address_3(SALT39.StrType s0) := s0;
EXPORT InValid_entity_1_address_3(SALT39.StrType s) := 0;
EXPORT InValidMessage_entity_1_address_3(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_1_address_4(SALT39.StrType s0) := s0;
EXPORT InValid_entity_1_address_4(SALT39.StrType s) := 0;
EXPORT InValidMessage_entity_1_address_4(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_1_dob(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_entity_1_dob(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_entity_1_dob(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_primary_entity_2(SALT39.StrType s0) := s0;
EXPORT InValid_primary_entity_2(SALT39.StrType s) := 0;
EXPORT InValidMessage_primary_entity_2(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_nm_format_2(SALT39.StrType s0) := s0;
EXPORT InValid_entity_nm_format_2(SALT39.StrType s) := 0;
EXPORT InValidMessage_entity_nm_format_2(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_type_code_2_orig(SALT39.StrType s0) := s0;
EXPORT InValid_entity_type_code_2_orig(SALT39.StrType s) := 0;
EXPORT InValidMessage_entity_type_code_2_orig(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_type_description_2_orig(SALT39.StrType s0) := s0;
EXPORT InValid_entity_type_description_2_orig(SALT39.StrType s) := 0;
EXPORT InValidMessage_entity_type_description_2_orig(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_type_code_2_master(SALT39.StrType s0) := s0;
EXPORT InValid_entity_type_code_2_master(SALT39.StrType s) := 0;
EXPORT InValidMessage_entity_type_code_2_master(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_seq_num_2(SALT39.StrType s0) := s0;
EXPORT InValid_entity_seq_num_2(SALT39.StrType s) := 0;
EXPORT InValidMessage_entity_seq_num_2(UNSIGNED1 wh) := '';
 
EXPORT Make_atty_seq_num_2(SALT39.StrType s0) := s0;
EXPORT InValid_atty_seq_num_2(SALT39.StrType s) := 0;
EXPORT InValidMessage_atty_seq_num_2(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_2_address_1(SALT39.StrType s0) := s0;
EXPORT InValid_entity_2_address_1(SALT39.StrType s) := 0;
EXPORT InValidMessage_entity_2_address_1(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_2_address_2(SALT39.StrType s0) := s0;
EXPORT InValid_entity_2_address_2(SALT39.StrType s) := 0;
EXPORT InValidMessage_entity_2_address_2(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_2_address_3(SALT39.StrType s0) := s0;
EXPORT InValid_entity_2_address_3(SALT39.StrType s) := 0;
EXPORT InValidMessage_entity_2_address_3(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_2_address_4(SALT39.StrType s0) := s0;
EXPORT InValid_entity_2_address_4(SALT39.StrType s) := 0;
EXPORT InValidMessage_entity_2_address_4(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_2_dob(SALT39.StrType s0) := s0;
EXPORT InValid_entity_2_dob(SALT39.StrType s) := 0;
EXPORT InValidMessage_entity_2_dob(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range1(SALT39.StrType s0) := s0;
EXPORT InValid_prim_range1(SALT39.StrType s) := 0;
EXPORT InValidMessage_prim_range1(UNSIGNED1 wh) := '';
 
EXPORT Make_predir1(SALT39.StrType s0) := s0;
EXPORT InValid_predir1(SALT39.StrType s) := 0;
EXPORT InValidMessage_predir1(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name1(SALT39.StrType s0) := s0;
EXPORT InValid_prim_name1(SALT39.StrType s) := 0;
EXPORT InValidMessage_prim_name1(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_suffix1(SALT39.StrType s0) := s0;
EXPORT InValid_addr_suffix1(SALT39.StrType s) := 0;
EXPORT InValidMessage_addr_suffix1(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir1(SALT39.StrType s0) := s0;
EXPORT InValid_postdir1(SALT39.StrType s) := 0;
EXPORT InValidMessage_postdir1(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig1(SALT39.StrType s0) := s0;
EXPORT InValid_unit_desig1(SALT39.StrType s) := 0;
EXPORT InValidMessage_unit_desig1(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range1(SALT39.StrType s0) := s0;
EXPORT InValid_sec_range1(SALT39.StrType s) := 0;
EXPORT InValidMessage_sec_range1(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name1(SALT39.StrType s0) := s0;
EXPORT InValid_p_city_name1(SALT39.StrType s) := 0;
EXPORT InValidMessage_p_city_name1(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name1(SALT39.StrType s0) := s0;
EXPORT InValid_v_city_name1(SALT39.StrType s) := 0;
EXPORT InValidMessage_v_city_name1(UNSIGNED1 wh) := '';
 
EXPORT Make_st1(SALT39.StrType s0) := s0;
EXPORT InValid_st1(SALT39.StrType s) := 0;
EXPORT InValidMessage_st1(UNSIGNED1 wh) := '';
 
EXPORT Make_zip1(SALT39.StrType s0) := s0;
EXPORT InValid_zip1(SALT39.StrType s) := 0;
EXPORT InValidMessage_zip1(UNSIGNED1 wh) := '';
 
EXPORT Make_zip41(SALT39.StrType s0) := s0;
EXPORT InValid_zip41(SALT39.StrType s) := 0;
EXPORT InValidMessage_zip41(UNSIGNED1 wh) := '';
 
EXPORT Make_cart1(SALT39.StrType s0) := s0;
EXPORT InValid_cart1(SALT39.StrType s) := 0;
EXPORT InValidMessage_cart1(UNSIGNED1 wh) := '';
 
EXPORT Make_cr_sort_sz1(SALT39.StrType s0) := s0;
EXPORT InValid_cr_sort_sz1(SALT39.StrType s) := 0;
EXPORT InValidMessage_cr_sort_sz1(UNSIGNED1 wh) := '';
 
EXPORT Make_lot1(SALT39.StrType s0) := s0;
EXPORT InValid_lot1(SALT39.StrType s) := 0;
EXPORT InValidMessage_lot1(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_order1(SALT39.StrType s0) := s0;
EXPORT InValid_lot_order1(SALT39.StrType s) := 0;
EXPORT InValidMessage_lot_order1(UNSIGNED1 wh) := '';
 
EXPORT Make_dpbc1(SALT39.StrType s0) := s0;
EXPORT InValid_dpbc1(SALT39.StrType s) := 0;
EXPORT InValidMessage_dpbc1(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit1(SALT39.StrType s0) := s0;
EXPORT InValid_chk_digit1(SALT39.StrType s) := 0;
EXPORT InValidMessage_chk_digit1(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_type1(SALT39.StrType s0) := s0;
EXPORT InValid_rec_type1(SALT39.StrType s) := 0;
EXPORT InValidMessage_rec_type1(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_st1(SALT39.StrType s0) := s0;
EXPORT InValid_ace_fips_st1(SALT39.StrType s) := 0;
EXPORT InValidMessage_ace_fips_st1(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_county1(SALT39.StrType s0) := s0;
EXPORT InValid_ace_fips_county1(SALT39.StrType s) := 0;
EXPORT InValidMessage_ace_fips_county1(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_lat1(SALT39.StrType s0) := s0;
EXPORT InValid_geo_lat1(SALT39.StrType s) := 0;
EXPORT InValidMessage_geo_lat1(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_long1(SALT39.StrType s0) := s0;
EXPORT InValid_geo_long1(SALT39.StrType s) := 0;
EXPORT InValidMessage_geo_long1(UNSIGNED1 wh) := '';
 
EXPORT Make_msa1(SALT39.StrType s0) := s0;
EXPORT InValid_msa1(SALT39.StrType s) := 0;
EXPORT InValidMessage_msa1(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_blk1(SALT39.StrType s0) := s0;
EXPORT InValid_geo_blk1(SALT39.StrType s) := 0;
EXPORT InValidMessage_geo_blk1(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match1(SALT39.StrType s0) := s0;
EXPORT InValid_geo_match1(SALT39.StrType s) := 0;
EXPORT InValidMessage_geo_match1(UNSIGNED1 wh) := '';
 
EXPORT Make_err_stat1(SALT39.StrType s0) := s0;
EXPORT InValid_err_stat1(SALT39.StrType s) := 0;
EXPORT InValidMessage_err_stat1(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range2(SALT39.StrType s0) := s0;
EXPORT InValid_prim_range2(SALT39.StrType s) := 0;
EXPORT InValidMessage_prim_range2(UNSIGNED1 wh) := '';
 
EXPORT Make_predir2(SALT39.StrType s0) := s0;
EXPORT InValid_predir2(SALT39.StrType s) := 0;
EXPORT InValidMessage_predir2(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name2(SALT39.StrType s0) := s0;
EXPORT InValid_prim_name2(SALT39.StrType s) := 0;
EXPORT InValidMessage_prim_name2(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_suffix2(SALT39.StrType s0) := s0;
EXPORT InValid_addr_suffix2(SALT39.StrType s) := 0;
EXPORT InValidMessage_addr_suffix2(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir2(SALT39.StrType s0) := s0;
EXPORT InValid_postdir2(SALT39.StrType s) := 0;
EXPORT InValidMessage_postdir2(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig2(SALT39.StrType s0) := s0;
EXPORT InValid_unit_desig2(SALT39.StrType s) := 0;
EXPORT InValidMessage_unit_desig2(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range2(SALT39.StrType s0) := s0;
EXPORT InValid_sec_range2(SALT39.StrType s) := 0;
EXPORT InValidMessage_sec_range2(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name2(SALT39.StrType s0) := s0;
EXPORT InValid_p_city_name2(SALT39.StrType s) := 0;
EXPORT InValidMessage_p_city_name2(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name2(SALT39.StrType s0) := s0;
EXPORT InValid_v_city_name2(SALT39.StrType s) := 0;
EXPORT InValidMessage_v_city_name2(UNSIGNED1 wh) := '';
 
EXPORT Make_st2(SALT39.StrType s0) := s0;
EXPORT InValid_st2(SALT39.StrType s) := 0;
EXPORT InValidMessage_st2(UNSIGNED1 wh) := '';
 
EXPORT Make_zip2(SALT39.StrType s0) := s0;
EXPORT InValid_zip2(SALT39.StrType s) := 0;
EXPORT InValidMessage_zip2(UNSIGNED1 wh) := '';
 
EXPORT Make_zip42(SALT39.StrType s0) := s0;
EXPORT InValid_zip42(SALT39.StrType s) := 0;
EXPORT InValidMessage_zip42(UNSIGNED1 wh) := '';
 
EXPORT Make_cart2(SALT39.StrType s0) := s0;
EXPORT InValid_cart2(SALT39.StrType s) := 0;
EXPORT InValidMessage_cart2(UNSIGNED1 wh) := '';
 
EXPORT Make_cr_sort_sz2(SALT39.StrType s0) := s0;
EXPORT InValid_cr_sort_sz2(SALT39.StrType s) := 0;
EXPORT InValidMessage_cr_sort_sz2(UNSIGNED1 wh) := '';
 
EXPORT Make_lot2(SALT39.StrType s0) := s0;
EXPORT InValid_lot2(SALT39.StrType s) := 0;
EXPORT InValidMessage_lot2(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_order2(SALT39.StrType s0) := s0;
EXPORT InValid_lot_order2(SALT39.StrType s) := 0;
EXPORT InValidMessage_lot_order2(UNSIGNED1 wh) := '';
 
EXPORT Make_dpbc2(SALT39.StrType s0) := s0;
EXPORT InValid_dpbc2(SALT39.StrType s) := 0;
EXPORT InValidMessage_dpbc2(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit2(SALT39.StrType s0) := s0;
EXPORT InValid_chk_digit2(SALT39.StrType s) := 0;
EXPORT InValidMessage_chk_digit2(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_type2(SALT39.StrType s0) := s0;
EXPORT InValid_rec_type2(SALT39.StrType s) := 0;
EXPORT InValidMessage_rec_type2(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_st2(SALT39.StrType s0) := s0;
EXPORT InValid_ace_fips_st2(SALT39.StrType s) := 0;
EXPORT InValidMessage_ace_fips_st2(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_county2(SALT39.StrType s0) := s0;
EXPORT InValid_ace_fips_county2(SALT39.StrType s) := 0;
EXPORT InValidMessage_ace_fips_county2(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_lat2(SALT39.StrType s0) := s0;
EXPORT InValid_geo_lat2(SALT39.StrType s) := 0;
EXPORT InValidMessage_geo_lat2(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_long2(SALT39.StrType s0) := s0;
EXPORT InValid_geo_long2(SALT39.StrType s) := 0;
EXPORT InValidMessage_geo_long2(UNSIGNED1 wh) := '';
 
EXPORT Make_msa2(SALT39.StrType s0) := s0;
EXPORT InValid_msa2(SALT39.StrType s) := 0;
EXPORT InValidMessage_msa2(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_blk2(SALT39.StrType s0) := s0;
EXPORT InValid_geo_blk2(SALT39.StrType s) := 0;
EXPORT InValidMessage_geo_blk2(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match2(SALT39.StrType s0) := s0;
EXPORT InValid_geo_match2(SALT39.StrType s) := 0;
EXPORT InValidMessage_geo_match2(UNSIGNED1 wh) := '';
 
EXPORT Make_err_stat2(SALT39.StrType s0) := s0;
EXPORT InValid_err_stat2(SALT39.StrType s) := 0;
EXPORT InValidMessage_err_stat2(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_title1(SALT39.StrType s0) := s0;
EXPORT InValid_e1_title1(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_title1(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_fname1(SALT39.StrType s0) := s0;
EXPORT InValid_e1_fname1(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_fname1(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_mname1(SALT39.StrType s0) := s0;
EXPORT InValid_e1_mname1(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_mname1(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_lname1(SALT39.StrType s0) := s0;
EXPORT InValid_e1_lname1(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_lname1(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_suffix1(SALT39.StrType s0) := s0;
EXPORT InValid_e1_suffix1(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_suffix1(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_pname1_score(SALT39.StrType s0) := s0;
EXPORT InValid_e1_pname1_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_pname1_score(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_cname1(SALT39.StrType s0) := s0;
EXPORT InValid_e1_cname1(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_cname1(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_title2(SALT39.StrType s0) := s0;
EXPORT InValid_e1_title2(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_title2(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_fname2(SALT39.StrType s0) := s0;
EXPORT InValid_e1_fname2(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_fname2(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_mname2(SALT39.StrType s0) := s0;
EXPORT InValid_e1_mname2(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_mname2(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_lname2(SALT39.StrType s0) := s0;
EXPORT InValid_e1_lname2(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_lname2(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_suffix2(SALT39.StrType s0) := s0;
EXPORT InValid_e1_suffix2(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_suffix2(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_pname2_score(SALT39.StrType s0) := s0;
EXPORT InValid_e1_pname2_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_pname2_score(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_cname2(SALT39.StrType s0) := s0;
EXPORT InValid_e1_cname2(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_cname2(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_title3(SALT39.StrType s0) := s0;
EXPORT InValid_e1_title3(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_title3(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_fname3(SALT39.StrType s0) := s0;
EXPORT InValid_e1_fname3(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_fname3(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_mname3(SALT39.StrType s0) := s0;
EXPORT InValid_e1_mname3(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_mname3(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_lname3(SALT39.StrType s0) := s0;
EXPORT InValid_e1_lname3(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_lname3(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_suffix3(SALT39.StrType s0) := s0;
EXPORT InValid_e1_suffix3(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_suffix3(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_pname3_score(SALT39.StrType s0) := s0;
EXPORT InValid_e1_pname3_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_pname3_score(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_cname3(SALT39.StrType s0) := s0;
EXPORT InValid_e1_cname3(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_cname3(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_title4(SALT39.StrType s0) := s0;
EXPORT InValid_e1_title4(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_title4(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_fname4(SALT39.StrType s0) := s0;
EXPORT InValid_e1_fname4(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_fname4(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_mname4(SALT39.StrType s0) := s0;
EXPORT InValid_e1_mname4(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_mname4(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_lname4(SALT39.StrType s0) := s0;
EXPORT InValid_e1_lname4(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_lname4(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_suffix4(SALT39.StrType s0) := s0;
EXPORT InValid_e1_suffix4(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_suffix4(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_pname4_score(SALT39.StrType s0) := s0;
EXPORT InValid_e1_pname4_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_pname4_score(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_cname4(SALT39.StrType s0) := s0;
EXPORT InValid_e1_cname4(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_cname4(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_title5(SALT39.StrType s0) := s0;
EXPORT InValid_e1_title5(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_title5(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_fname5(SALT39.StrType s0) := s0;
EXPORT InValid_e1_fname5(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_fname5(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_mname5(SALT39.StrType s0) := s0;
EXPORT InValid_e1_mname5(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_mname5(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_lname5(SALT39.StrType s0) := s0;
EXPORT InValid_e1_lname5(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_lname5(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_suffix5(SALT39.StrType s0) := s0;
EXPORT InValid_e1_suffix5(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_suffix5(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_pname5_score(SALT39.StrType s0) := s0;
EXPORT InValid_e1_pname5_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_pname5_score(UNSIGNED1 wh) := '';
 
EXPORT Make_e1_cname5(SALT39.StrType s0) := s0;
EXPORT InValid_e1_cname5(SALT39.StrType s) := 0;
EXPORT InValidMessage_e1_cname5(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_title1(SALT39.StrType s0) := s0;
EXPORT InValid_e2_title1(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_title1(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_fname1(SALT39.StrType s0) := s0;
EXPORT InValid_e2_fname1(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_fname1(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_mname1(SALT39.StrType s0) := s0;
EXPORT InValid_e2_mname1(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_mname1(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_lname1(SALT39.StrType s0) := s0;
EXPORT InValid_e2_lname1(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_lname1(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_suffix1(SALT39.StrType s0) := s0;
EXPORT InValid_e2_suffix1(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_suffix1(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_pname1_score(SALT39.StrType s0) := s0;
EXPORT InValid_e2_pname1_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_pname1_score(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_cname1(SALT39.StrType s0) := s0;
EXPORT InValid_e2_cname1(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_cname1(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_title2(SALT39.StrType s0) := s0;
EXPORT InValid_e2_title2(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_title2(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_fname2(SALT39.StrType s0) := s0;
EXPORT InValid_e2_fname2(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_fname2(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_mname2(SALT39.StrType s0) := s0;
EXPORT InValid_e2_mname2(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_mname2(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_lname2(SALT39.StrType s0) := s0;
EXPORT InValid_e2_lname2(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_lname2(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_suffix2(SALT39.StrType s0) := s0;
EXPORT InValid_e2_suffix2(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_suffix2(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_pname2_score(SALT39.StrType s0) := s0;
EXPORT InValid_e2_pname2_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_pname2_score(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_cname2(SALT39.StrType s0) := s0;
EXPORT InValid_e2_cname2(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_cname2(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_title3(SALT39.StrType s0) := s0;
EXPORT InValid_e2_title3(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_title3(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_fname3(SALT39.StrType s0) := s0;
EXPORT InValid_e2_fname3(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_fname3(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_mname3(SALT39.StrType s0) := s0;
EXPORT InValid_e2_mname3(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_mname3(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_lname3(SALT39.StrType s0) := s0;
EXPORT InValid_e2_lname3(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_lname3(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_suffix3(SALT39.StrType s0) := s0;
EXPORT InValid_e2_suffix3(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_suffix3(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_pname3_score(SALT39.StrType s0) := s0;
EXPORT InValid_e2_pname3_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_pname3_score(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_cname3(SALT39.StrType s0) := s0;
EXPORT InValid_e2_cname3(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_cname3(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_title4(SALT39.StrType s0) := s0;
EXPORT InValid_e2_title4(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_title4(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_fname4(SALT39.StrType s0) := s0;
EXPORT InValid_e2_fname4(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_fname4(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_mname4(SALT39.StrType s0) := s0;
EXPORT InValid_e2_mname4(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_mname4(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_lname4(SALT39.StrType s0) := s0;
EXPORT InValid_e2_lname4(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_lname4(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_suffix4(SALT39.StrType s0) := s0;
EXPORT InValid_e2_suffix4(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_suffix4(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_pname4_score(SALT39.StrType s0) := s0;
EXPORT InValid_e2_pname4_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_pname4_score(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_cname4(SALT39.StrType s0) := s0;
EXPORT InValid_e2_cname4(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_cname4(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_title5(SALT39.StrType s0) := s0;
EXPORT InValid_e2_title5(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_title5(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_fname5(SALT39.StrType s0) := s0;
EXPORT InValid_e2_fname5(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_fname5(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_mname5(SALT39.StrType s0) := s0;
EXPORT InValid_e2_mname5(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_mname5(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_lname5(SALT39.StrType s0) := s0;
EXPORT InValid_e2_lname5(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_lname5(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_suffix5(SALT39.StrType s0) := s0;
EXPORT InValid_e2_suffix5(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_suffix5(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_pname5_score(SALT39.StrType s0) := s0;
EXPORT InValid_e2_pname5_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_pname5_score(UNSIGNED1 wh) := '';
 
EXPORT Make_e2_cname5(SALT39.StrType s0) := s0;
EXPORT InValid_e2_cname5(SALT39.StrType s) := 0;
EXPORT InValidMessage_e2_cname5(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_title1(SALT39.StrType s0) := s0;
EXPORT InValid_v1_title1(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_title1(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_fname1(SALT39.StrType s0) := s0;
EXPORT InValid_v1_fname1(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_fname1(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_mname1(SALT39.StrType s0) := s0;
EXPORT InValid_v1_mname1(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_mname1(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_lname1(SALT39.StrType s0) := s0;
EXPORT InValid_v1_lname1(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_lname1(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_suffix1(SALT39.StrType s0) := s0;
EXPORT InValid_v1_suffix1(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_suffix1(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_pname1_score(SALT39.StrType s0) := s0;
EXPORT InValid_v1_pname1_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_pname1_score(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_cname1(SALT39.StrType s0) := s0;
EXPORT InValid_v1_cname1(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_cname1(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_title2(SALT39.StrType s0) := s0;
EXPORT InValid_v1_title2(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_title2(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_fname2(SALT39.StrType s0) := s0;
EXPORT InValid_v1_fname2(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_fname2(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_mname2(SALT39.StrType s0) := s0;
EXPORT InValid_v1_mname2(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_mname2(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_lname2(SALT39.StrType s0) := s0;
EXPORT InValid_v1_lname2(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_lname2(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_suffix2(SALT39.StrType s0) := s0;
EXPORT InValid_v1_suffix2(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_suffix2(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_pname2_score(SALT39.StrType s0) := s0;
EXPORT InValid_v1_pname2_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_pname2_score(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_cname2(SALT39.StrType s0) := s0;
EXPORT InValid_v1_cname2(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_cname2(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_title3(SALT39.StrType s0) := s0;
EXPORT InValid_v1_title3(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_title3(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_fname3(SALT39.StrType s0) := s0;
EXPORT InValid_v1_fname3(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_fname3(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_mname3(SALT39.StrType s0) := s0;
EXPORT InValid_v1_mname3(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_mname3(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_lname3(SALT39.StrType s0) := s0;
EXPORT InValid_v1_lname3(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_lname3(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_suffix3(SALT39.StrType s0) := s0;
EXPORT InValid_v1_suffix3(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_suffix3(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_pname3_score(SALT39.StrType s0) := s0;
EXPORT InValid_v1_pname3_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_pname3_score(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_cname3(SALT39.StrType s0) := s0;
EXPORT InValid_v1_cname3(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_cname3(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_title4(SALT39.StrType s0) := s0;
EXPORT InValid_v1_title4(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_title4(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_fname4(SALT39.StrType s0) := s0;
EXPORT InValid_v1_fname4(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_fname4(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_mname4(SALT39.StrType s0) := s0;
EXPORT InValid_v1_mname4(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_mname4(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_lname4(SALT39.StrType s0) := s0;
EXPORT InValid_v1_lname4(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_lname4(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_suffix4(SALT39.StrType s0) := s0;
EXPORT InValid_v1_suffix4(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_suffix4(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_pname4_score(SALT39.StrType s0) := s0;
EXPORT InValid_v1_pname4_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_pname4_score(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_cname4(SALT39.StrType s0) := s0;
EXPORT InValid_v1_cname4(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_cname4(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_title5(SALT39.StrType s0) := s0;
EXPORT InValid_v1_title5(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_title5(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_fname5(SALT39.StrType s0) := s0;
EXPORT InValid_v1_fname5(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_fname5(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_mname5(SALT39.StrType s0) := s0;
EXPORT InValid_v1_mname5(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_mname5(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_lname5(SALT39.StrType s0) := s0;
EXPORT InValid_v1_lname5(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_lname5(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_suffix5(SALT39.StrType s0) := s0;
EXPORT InValid_v1_suffix5(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_suffix5(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_pname5_score(SALT39.StrType s0) := s0;
EXPORT InValid_v1_pname5_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_pname5_score(UNSIGNED1 wh) := '';
 
EXPORT Make_v1_cname5(SALT39.StrType s0) := s0;
EXPORT InValid_v1_cname5(SALT39.StrType s) := 0;
EXPORT InValidMessage_v1_cname5(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_title1(SALT39.StrType s0) := s0;
EXPORT InValid_v2_title1(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_title1(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_fname1(SALT39.StrType s0) := s0;
EXPORT InValid_v2_fname1(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_fname1(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_mname1(SALT39.StrType s0) := s0;
EXPORT InValid_v2_mname1(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_mname1(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_lname1(SALT39.StrType s0) := s0;
EXPORT InValid_v2_lname1(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_lname1(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_suffix1(SALT39.StrType s0) := s0;
EXPORT InValid_v2_suffix1(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_suffix1(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_pname1_score(SALT39.StrType s0) := s0;
EXPORT InValid_v2_pname1_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_pname1_score(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_cname1(SALT39.StrType s0) := s0;
EXPORT InValid_v2_cname1(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_cname1(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_title2(SALT39.StrType s0) := s0;
EXPORT InValid_v2_title2(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_title2(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_fname2(SALT39.StrType s0) := s0;
EXPORT InValid_v2_fname2(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_fname2(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_mname2(SALT39.StrType s0) := s0;
EXPORT InValid_v2_mname2(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_mname2(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_lname2(SALT39.StrType s0) := s0;
EXPORT InValid_v2_lname2(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_lname2(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_suffix2(SALT39.StrType s0) := s0;
EXPORT InValid_v2_suffix2(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_suffix2(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_pname2_score(SALT39.StrType s0) := s0;
EXPORT InValid_v2_pname2_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_pname2_score(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_cname2(SALT39.StrType s0) := s0;
EXPORT InValid_v2_cname2(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_cname2(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_title3(SALT39.StrType s0) := s0;
EXPORT InValid_v2_title3(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_title3(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_fname3(SALT39.StrType s0) := s0;
EXPORT InValid_v2_fname3(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_fname3(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_mname3(SALT39.StrType s0) := s0;
EXPORT InValid_v2_mname3(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_mname3(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_lname3(SALT39.StrType s0) := s0;
EXPORT InValid_v2_lname3(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_lname3(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_suffix3(SALT39.StrType s0) := s0;
EXPORT InValid_v2_suffix3(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_suffix3(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_pname3_score(SALT39.StrType s0) := s0;
EXPORT InValid_v2_pname3_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_pname3_score(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_cname3(SALT39.StrType s0) := s0;
EXPORT InValid_v2_cname3(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_cname3(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_title4(SALT39.StrType s0) := s0;
EXPORT InValid_v2_title4(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_title4(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_fname4(SALT39.StrType s0) := s0;
EXPORT InValid_v2_fname4(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_fname4(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_mname4(SALT39.StrType s0) := s0;
EXPORT InValid_v2_mname4(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_mname4(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_lname4(SALT39.StrType s0) := s0;
EXPORT InValid_v2_lname4(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_lname4(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_suffix4(SALT39.StrType s0) := s0;
EXPORT InValid_v2_suffix4(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_suffix4(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_pname4_score(SALT39.StrType s0) := s0;
EXPORT InValid_v2_pname4_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_pname4_score(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_cname4(SALT39.StrType s0) := s0;
EXPORT InValid_v2_cname4(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_cname4(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_title5(SALT39.StrType s0) := s0;
EXPORT InValid_v2_title5(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_title5(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_fname5(SALT39.StrType s0) := s0;
EXPORT InValid_v2_fname5(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_fname5(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_mname5(SALT39.StrType s0) := s0;
EXPORT InValid_v2_mname5(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_mname5(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_lname5(SALT39.StrType s0) := s0;
EXPORT InValid_v2_lname5(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_lname5(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_suffix5(SALT39.StrType s0) := s0;
EXPORT InValid_v2_suffix5(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_suffix5(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_pname5_score(SALT39.StrType s0) := s0;
EXPORT InValid_v2_pname5_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_pname5_score(UNSIGNED1 wh) := '';
 
EXPORT Make_v2_cname5(SALT39.StrType s0) := s0;
EXPORT InValid_v2_cname5(SALT39.StrType s) := 0;
EXPORT InValidMessage_v2_cname5(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_Civil_Court;
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
    BOOLEAN Diff_dt_first_reported;
    BOOLEAN Diff_dt_last_reported;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_vendor;
    BOOLEAN Diff_state_origin;
    BOOLEAN Diff_source_file;
    BOOLEAN Diff_case_key;
    BOOLEAN Diff_parent_case_key;
    BOOLEAN Diff_court_code;
    BOOLEAN Diff_court;
    BOOLEAN Diff_case_number;
    BOOLEAN Diff_case_type_code;
    BOOLEAN Diff_case_type;
    BOOLEAN Diff_case_title;
    BOOLEAN Diff_ruled_for_against_code;
    BOOLEAN Diff_ruled_for_against;
    BOOLEAN Diff_entity_1;
    BOOLEAN Diff_entity_nm_format_1;
    BOOLEAN Diff_entity_type_code_1_orig;
    BOOLEAN Diff_entity_type_description_1_orig;
    BOOLEAN Diff_entity_type_code_1_master;
    BOOLEAN Diff_entity_seq_num_1;
    BOOLEAN Diff_atty_seq_num_1;
    BOOLEAN Diff_entity_1_address_1;
    BOOLEAN Diff_entity_1_address_2;
    BOOLEAN Diff_entity_1_address_3;
    BOOLEAN Diff_entity_1_address_4;
    BOOLEAN Diff_entity_1_dob;
    BOOLEAN Diff_primary_entity_2;
    BOOLEAN Diff_entity_nm_format_2;
    BOOLEAN Diff_entity_type_code_2_orig;
    BOOLEAN Diff_entity_type_description_2_orig;
    BOOLEAN Diff_entity_type_code_2_master;
    BOOLEAN Diff_entity_seq_num_2;
    BOOLEAN Diff_atty_seq_num_2;
    BOOLEAN Diff_entity_2_address_1;
    BOOLEAN Diff_entity_2_address_2;
    BOOLEAN Diff_entity_2_address_3;
    BOOLEAN Diff_entity_2_address_4;
    BOOLEAN Diff_entity_2_dob;
    BOOLEAN Diff_prim_range1;
    BOOLEAN Diff_predir1;
    BOOLEAN Diff_prim_name1;
    BOOLEAN Diff_addr_suffix1;
    BOOLEAN Diff_postdir1;
    BOOLEAN Diff_unit_desig1;
    BOOLEAN Diff_sec_range1;
    BOOLEAN Diff_p_city_name1;
    BOOLEAN Diff_v_city_name1;
    BOOLEAN Diff_st1;
    BOOLEAN Diff_zip1;
    BOOLEAN Diff_zip41;
    BOOLEAN Diff_cart1;
    BOOLEAN Diff_cr_sort_sz1;
    BOOLEAN Diff_lot1;
    BOOLEAN Diff_lot_order1;
    BOOLEAN Diff_dpbc1;
    BOOLEAN Diff_chk_digit1;
    BOOLEAN Diff_rec_type1;
    BOOLEAN Diff_ace_fips_st1;
    BOOLEAN Diff_ace_fips_county1;
    BOOLEAN Diff_geo_lat1;
    BOOLEAN Diff_geo_long1;
    BOOLEAN Diff_msa1;
    BOOLEAN Diff_geo_blk1;
    BOOLEAN Diff_geo_match1;
    BOOLEAN Diff_err_stat1;
    BOOLEAN Diff_prim_range2;
    BOOLEAN Diff_predir2;
    BOOLEAN Diff_prim_name2;
    BOOLEAN Diff_addr_suffix2;
    BOOLEAN Diff_postdir2;
    BOOLEAN Diff_unit_desig2;
    BOOLEAN Diff_sec_range2;
    BOOLEAN Diff_p_city_name2;
    BOOLEAN Diff_v_city_name2;
    BOOLEAN Diff_st2;
    BOOLEAN Diff_zip2;
    BOOLEAN Diff_zip42;
    BOOLEAN Diff_cart2;
    BOOLEAN Diff_cr_sort_sz2;
    BOOLEAN Diff_lot2;
    BOOLEAN Diff_lot_order2;
    BOOLEAN Diff_dpbc2;
    BOOLEAN Diff_chk_digit2;
    BOOLEAN Diff_rec_type2;
    BOOLEAN Diff_ace_fips_st2;
    BOOLEAN Diff_ace_fips_county2;
    BOOLEAN Diff_geo_lat2;
    BOOLEAN Diff_geo_long2;
    BOOLEAN Diff_msa2;
    BOOLEAN Diff_geo_blk2;
    BOOLEAN Diff_geo_match2;
    BOOLEAN Diff_err_stat2;
    BOOLEAN Diff_e1_title1;
    BOOLEAN Diff_e1_fname1;
    BOOLEAN Diff_e1_mname1;
    BOOLEAN Diff_e1_lname1;
    BOOLEAN Diff_e1_suffix1;
    BOOLEAN Diff_e1_pname1_score;
    BOOLEAN Diff_e1_cname1;
    BOOLEAN Diff_e1_title2;
    BOOLEAN Diff_e1_fname2;
    BOOLEAN Diff_e1_mname2;
    BOOLEAN Diff_e1_lname2;
    BOOLEAN Diff_e1_suffix2;
    BOOLEAN Diff_e1_pname2_score;
    BOOLEAN Diff_e1_cname2;
    BOOLEAN Diff_e1_title3;
    BOOLEAN Diff_e1_fname3;
    BOOLEAN Diff_e1_mname3;
    BOOLEAN Diff_e1_lname3;
    BOOLEAN Diff_e1_suffix3;
    BOOLEAN Diff_e1_pname3_score;
    BOOLEAN Diff_e1_cname3;
    BOOLEAN Diff_e1_title4;
    BOOLEAN Diff_e1_fname4;
    BOOLEAN Diff_e1_mname4;
    BOOLEAN Diff_e1_lname4;
    BOOLEAN Diff_e1_suffix4;
    BOOLEAN Diff_e1_pname4_score;
    BOOLEAN Diff_e1_cname4;
    BOOLEAN Diff_e1_title5;
    BOOLEAN Diff_e1_fname5;
    BOOLEAN Diff_e1_mname5;
    BOOLEAN Diff_e1_lname5;
    BOOLEAN Diff_e1_suffix5;
    BOOLEAN Diff_e1_pname5_score;
    BOOLEAN Diff_e1_cname5;
    BOOLEAN Diff_e2_title1;
    BOOLEAN Diff_e2_fname1;
    BOOLEAN Diff_e2_mname1;
    BOOLEAN Diff_e2_lname1;
    BOOLEAN Diff_e2_suffix1;
    BOOLEAN Diff_e2_pname1_score;
    BOOLEAN Diff_e2_cname1;
    BOOLEAN Diff_e2_title2;
    BOOLEAN Diff_e2_fname2;
    BOOLEAN Diff_e2_mname2;
    BOOLEAN Diff_e2_lname2;
    BOOLEAN Diff_e2_suffix2;
    BOOLEAN Diff_e2_pname2_score;
    BOOLEAN Diff_e2_cname2;
    BOOLEAN Diff_e2_title3;
    BOOLEAN Diff_e2_fname3;
    BOOLEAN Diff_e2_mname3;
    BOOLEAN Diff_e2_lname3;
    BOOLEAN Diff_e2_suffix3;
    BOOLEAN Diff_e2_pname3_score;
    BOOLEAN Diff_e2_cname3;
    BOOLEAN Diff_e2_title4;
    BOOLEAN Diff_e2_fname4;
    BOOLEAN Diff_e2_mname4;
    BOOLEAN Diff_e2_lname4;
    BOOLEAN Diff_e2_suffix4;
    BOOLEAN Diff_e2_pname4_score;
    BOOLEAN Diff_e2_cname4;
    BOOLEAN Diff_e2_title5;
    BOOLEAN Diff_e2_fname5;
    BOOLEAN Diff_e2_mname5;
    BOOLEAN Diff_e2_lname5;
    BOOLEAN Diff_e2_suffix5;
    BOOLEAN Diff_e2_pname5_score;
    BOOLEAN Diff_e2_cname5;
    BOOLEAN Diff_v1_title1;
    BOOLEAN Diff_v1_fname1;
    BOOLEAN Diff_v1_mname1;
    BOOLEAN Diff_v1_lname1;
    BOOLEAN Diff_v1_suffix1;
    BOOLEAN Diff_v1_pname1_score;
    BOOLEAN Diff_v1_cname1;
    BOOLEAN Diff_v1_title2;
    BOOLEAN Diff_v1_fname2;
    BOOLEAN Diff_v1_mname2;
    BOOLEAN Diff_v1_lname2;
    BOOLEAN Diff_v1_suffix2;
    BOOLEAN Diff_v1_pname2_score;
    BOOLEAN Diff_v1_cname2;
    BOOLEAN Diff_v1_title3;
    BOOLEAN Diff_v1_fname3;
    BOOLEAN Diff_v1_mname3;
    BOOLEAN Diff_v1_lname3;
    BOOLEAN Diff_v1_suffix3;
    BOOLEAN Diff_v1_pname3_score;
    BOOLEAN Diff_v1_cname3;
    BOOLEAN Diff_v1_title4;
    BOOLEAN Diff_v1_fname4;
    BOOLEAN Diff_v1_mname4;
    BOOLEAN Diff_v1_lname4;
    BOOLEAN Diff_v1_suffix4;
    BOOLEAN Diff_v1_pname4_score;
    BOOLEAN Diff_v1_cname4;
    BOOLEAN Diff_v1_title5;
    BOOLEAN Diff_v1_fname5;
    BOOLEAN Diff_v1_mname5;
    BOOLEAN Diff_v1_lname5;
    BOOLEAN Diff_v1_suffix5;
    BOOLEAN Diff_v1_pname5_score;
    BOOLEAN Diff_v1_cname5;
    BOOLEAN Diff_v2_title1;
    BOOLEAN Diff_v2_fname1;
    BOOLEAN Diff_v2_mname1;
    BOOLEAN Diff_v2_lname1;
    BOOLEAN Diff_v2_suffix1;
    BOOLEAN Diff_v2_pname1_score;
    BOOLEAN Diff_v2_cname1;
    BOOLEAN Diff_v2_title2;
    BOOLEAN Diff_v2_fname2;
    BOOLEAN Diff_v2_mname2;
    BOOLEAN Diff_v2_lname2;
    BOOLEAN Diff_v2_suffix2;
    BOOLEAN Diff_v2_pname2_score;
    BOOLEAN Diff_v2_cname2;
    BOOLEAN Diff_v2_title3;
    BOOLEAN Diff_v2_fname3;
    BOOLEAN Diff_v2_mname3;
    BOOLEAN Diff_v2_lname3;
    BOOLEAN Diff_v2_suffix3;
    BOOLEAN Diff_v2_pname3_score;
    BOOLEAN Diff_v2_cname3;
    BOOLEAN Diff_v2_title4;
    BOOLEAN Diff_v2_fname4;
    BOOLEAN Diff_v2_mname4;
    BOOLEAN Diff_v2_lname4;
    BOOLEAN Diff_v2_suffix4;
    BOOLEAN Diff_v2_pname4_score;
    BOOLEAN Diff_v2_cname4;
    BOOLEAN Diff_v2_title5;
    BOOLEAN Diff_v2_fname5;
    BOOLEAN Diff_v2_mname5;
    BOOLEAN Diff_v2_lname5;
    BOOLEAN Diff_v2_suffix5;
    BOOLEAN Diff_v2_pname5_score;
    BOOLEAN Diff_v2_cname5;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dt_first_reported := le.dt_first_reported <> ri.dt_first_reported;
    SELF.Diff_dt_last_reported := le.dt_last_reported <> ri.dt_last_reported;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_vendor := le.vendor <> ri.vendor;
    SELF.Diff_state_origin := le.state_origin <> ri.state_origin;
    SELF.Diff_source_file := le.source_file <> ri.source_file;
    SELF.Diff_case_key := le.case_key <> ri.case_key;
    SELF.Diff_parent_case_key := le.parent_case_key <> ri.parent_case_key;
    SELF.Diff_court_code := le.court_code <> ri.court_code;
    SELF.Diff_court := le.court <> ri.court;
    SELF.Diff_case_number := le.case_number <> ri.case_number;
    SELF.Diff_case_type_code := le.case_type_code <> ri.case_type_code;
    SELF.Diff_case_type := le.case_type <> ri.case_type;
    SELF.Diff_case_title := le.case_title <> ri.case_title;
    SELF.Diff_ruled_for_against_code := le.ruled_for_against_code <> ri.ruled_for_against_code;
    SELF.Diff_ruled_for_against := le.ruled_for_against <> ri.ruled_for_against;
    SELF.Diff_entity_1 := le.entity_1 <> ri.entity_1;
    SELF.Diff_entity_nm_format_1 := le.entity_nm_format_1 <> ri.entity_nm_format_1;
    SELF.Diff_entity_type_code_1_orig := le.entity_type_code_1_orig <> ri.entity_type_code_1_orig;
    SELF.Diff_entity_type_description_1_orig := le.entity_type_description_1_orig <> ri.entity_type_description_1_orig;
    SELF.Diff_entity_type_code_1_master := le.entity_type_code_1_master <> ri.entity_type_code_1_master;
    SELF.Diff_entity_seq_num_1 := le.entity_seq_num_1 <> ri.entity_seq_num_1;
    SELF.Diff_atty_seq_num_1 := le.atty_seq_num_1 <> ri.atty_seq_num_1;
    SELF.Diff_entity_1_address_1 := le.entity_1_address_1 <> ri.entity_1_address_1;
    SELF.Diff_entity_1_address_2 := le.entity_1_address_2 <> ri.entity_1_address_2;
    SELF.Diff_entity_1_address_3 := le.entity_1_address_3 <> ri.entity_1_address_3;
    SELF.Diff_entity_1_address_4 := le.entity_1_address_4 <> ri.entity_1_address_4;
    SELF.Diff_entity_1_dob := le.entity_1_dob <> ri.entity_1_dob;
    SELF.Diff_primary_entity_2 := le.primary_entity_2 <> ri.primary_entity_2;
    SELF.Diff_entity_nm_format_2 := le.entity_nm_format_2 <> ri.entity_nm_format_2;
    SELF.Diff_entity_type_code_2_orig := le.entity_type_code_2_orig <> ri.entity_type_code_2_orig;
    SELF.Diff_entity_type_description_2_orig := le.entity_type_description_2_orig <> ri.entity_type_description_2_orig;
    SELF.Diff_entity_type_code_2_master := le.entity_type_code_2_master <> ri.entity_type_code_2_master;
    SELF.Diff_entity_seq_num_2 := le.entity_seq_num_2 <> ri.entity_seq_num_2;
    SELF.Diff_atty_seq_num_2 := le.atty_seq_num_2 <> ri.atty_seq_num_2;
    SELF.Diff_entity_2_address_1 := le.entity_2_address_1 <> ri.entity_2_address_1;
    SELF.Diff_entity_2_address_2 := le.entity_2_address_2 <> ri.entity_2_address_2;
    SELF.Diff_entity_2_address_3 := le.entity_2_address_3 <> ri.entity_2_address_3;
    SELF.Diff_entity_2_address_4 := le.entity_2_address_4 <> ri.entity_2_address_4;
    SELF.Diff_entity_2_dob := le.entity_2_dob <> ri.entity_2_dob;
    SELF.Diff_prim_range1 := le.prim_range1 <> ri.prim_range1;
    SELF.Diff_predir1 := le.predir1 <> ri.predir1;
    SELF.Diff_prim_name1 := le.prim_name1 <> ri.prim_name1;
    SELF.Diff_addr_suffix1 := le.addr_suffix1 <> ri.addr_suffix1;
    SELF.Diff_postdir1 := le.postdir1 <> ri.postdir1;
    SELF.Diff_unit_desig1 := le.unit_desig1 <> ri.unit_desig1;
    SELF.Diff_sec_range1 := le.sec_range1 <> ri.sec_range1;
    SELF.Diff_p_city_name1 := le.p_city_name1 <> ri.p_city_name1;
    SELF.Diff_v_city_name1 := le.v_city_name1 <> ri.v_city_name1;
    SELF.Diff_st1 := le.st1 <> ri.st1;
    SELF.Diff_zip1 := le.zip1 <> ri.zip1;
    SELF.Diff_zip41 := le.zip41 <> ri.zip41;
    SELF.Diff_cart1 := le.cart1 <> ri.cart1;
    SELF.Diff_cr_sort_sz1 := le.cr_sort_sz1 <> ri.cr_sort_sz1;
    SELF.Diff_lot1 := le.lot1 <> ri.lot1;
    SELF.Diff_lot_order1 := le.lot_order1 <> ri.lot_order1;
    SELF.Diff_dpbc1 := le.dpbc1 <> ri.dpbc1;
    SELF.Diff_chk_digit1 := le.chk_digit1 <> ri.chk_digit1;
    SELF.Diff_rec_type1 := le.rec_type1 <> ri.rec_type1;
    SELF.Diff_ace_fips_st1 := le.ace_fips_st1 <> ri.ace_fips_st1;
    SELF.Diff_ace_fips_county1 := le.ace_fips_county1 <> ri.ace_fips_county1;
    SELF.Diff_geo_lat1 := le.geo_lat1 <> ri.geo_lat1;
    SELF.Diff_geo_long1 := le.geo_long1 <> ri.geo_long1;
    SELF.Diff_msa1 := le.msa1 <> ri.msa1;
    SELF.Diff_geo_blk1 := le.geo_blk1 <> ri.geo_blk1;
    SELF.Diff_geo_match1 := le.geo_match1 <> ri.geo_match1;
    SELF.Diff_err_stat1 := le.err_stat1 <> ri.err_stat1;
    SELF.Diff_prim_range2 := le.prim_range2 <> ri.prim_range2;
    SELF.Diff_predir2 := le.predir2 <> ri.predir2;
    SELF.Diff_prim_name2 := le.prim_name2 <> ri.prim_name2;
    SELF.Diff_addr_suffix2 := le.addr_suffix2 <> ri.addr_suffix2;
    SELF.Diff_postdir2 := le.postdir2 <> ri.postdir2;
    SELF.Diff_unit_desig2 := le.unit_desig2 <> ri.unit_desig2;
    SELF.Diff_sec_range2 := le.sec_range2 <> ri.sec_range2;
    SELF.Diff_p_city_name2 := le.p_city_name2 <> ri.p_city_name2;
    SELF.Diff_v_city_name2 := le.v_city_name2 <> ri.v_city_name2;
    SELF.Diff_st2 := le.st2 <> ri.st2;
    SELF.Diff_zip2 := le.zip2 <> ri.zip2;
    SELF.Diff_zip42 := le.zip42 <> ri.zip42;
    SELF.Diff_cart2 := le.cart2 <> ri.cart2;
    SELF.Diff_cr_sort_sz2 := le.cr_sort_sz2 <> ri.cr_sort_sz2;
    SELF.Diff_lot2 := le.lot2 <> ri.lot2;
    SELF.Diff_lot_order2 := le.lot_order2 <> ri.lot_order2;
    SELF.Diff_dpbc2 := le.dpbc2 <> ri.dpbc2;
    SELF.Diff_chk_digit2 := le.chk_digit2 <> ri.chk_digit2;
    SELF.Diff_rec_type2 := le.rec_type2 <> ri.rec_type2;
    SELF.Diff_ace_fips_st2 := le.ace_fips_st2 <> ri.ace_fips_st2;
    SELF.Diff_ace_fips_county2 := le.ace_fips_county2 <> ri.ace_fips_county2;
    SELF.Diff_geo_lat2 := le.geo_lat2 <> ri.geo_lat2;
    SELF.Diff_geo_long2 := le.geo_long2 <> ri.geo_long2;
    SELF.Diff_msa2 := le.msa2 <> ri.msa2;
    SELF.Diff_geo_blk2 := le.geo_blk2 <> ri.geo_blk2;
    SELF.Diff_geo_match2 := le.geo_match2 <> ri.geo_match2;
    SELF.Diff_err_stat2 := le.err_stat2 <> ri.err_stat2;
    SELF.Diff_e1_title1 := le.e1_title1 <> ri.e1_title1;
    SELF.Diff_e1_fname1 := le.e1_fname1 <> ri.e1_fname1;
    SELF.Diff_e1_mname1 := le.e1_mname1 <> ri.e1_mname1;
    SELF.Diff_e1_lname1 := le.e1_lname1 <> ri.e1_lname1;
    SELF.Diff_e1_suffix1 := le.e1_suffix1 <> ri.e1_suffix1;
    SELF.Diff_e1_pname1_score := le.e1_pname1_score <> ri.e1_pname1_score;
    SELF.Diff_e1_cname1 := le.e1_cname1 <> ri.e1_cname1;
    SELF.Diff_e1_title2 := le.e1_title2 <> ri.e1_title2;
    SELF.Diff_e1_fname2 := le.e1_fname2 <> ri.e1_fname2;
    SELF.Diff_e1_mname2 := le.e1_mname2 <> ri.e1_mname2;
    SELF.Diff_e1_lname2 := le.e1_lname2 <> ri.e1_lname2;
    SELF.Diff_e1_suffix2 := le.e1_suffix2 <> ri.e1_suffix2;
    SELF.Diff_e1_pname2_score := le.e1_pname2_score <> ri.e1_pname2_score;
    SELF.Diff_e1_cname2 := le.e1_cname2 <> ri.e1_cname2;
    SELF.Diff_e1_title3 := le.e1_title3 <> ri.e1_title3;
    SELF.Diff_e1_fname3 := le.e1_fname3 <> ri.e1_fname3;
    SELF.Diff_e1_mname3 := le.e1_mname3 <> ri.e1_mname3;
    SELF.Diff_e1_lname3 := le.e1_lname3 <> ri.e1_lname3;
    SELF.Diff_e1_suffix3 := le.e1_suffix3 <> ri.e1_suffix3;
    SELF.Diff_e1_pname3_score := le.e1_pname3_score <> ri.e1_pname3_score;
    SELF.Diff_e1_cname3 := le.e1_cname3 <> ri.e1_cname3;
    SELF.Diff_e1_title4 := le.e1_title4 <> ri.e1_title4;
    SELF.Diff_e1_fname4 := le.e1_fname4 <> ri.e1_fname4;
    SELF.Diff_e1_mname4 := le.e1_mname4 <> ri.e1_mname4;
    SELF.Diff_e1_lname4 := le.e1_lname4 <> ri.e1_lname4;
    SELF.Diff_e1_suffix4 := le.e1_suffix4 <> ri.e1_suffix4;
    SELF.Diff_e1_pname4_score := le.e1_pname4_score <> ri.e1_pname4_score;
    SELF.Diff_e1_cname4 := le.e1_cname4 <> ri.e1_cname4;
    SELF.Diff_e1_title5 := le.e1_title5 <> ri.e1_title5;
    SELF.Diff_e1_fname5 := le.e1_fname5 <> ri.e1_fname5;
    SELF.Diff_e1_mname5 := le.e1_mname5 <> ri.e1_mname5;
    SELF.Diff_e1_lname5 := le.e1_lname5 <> ri.e1_lname5;
    SELF.Diff_e1_suffix5 := le.e1_suffix5 <> ri.e1_suffix5;
    SELF.Diff_e1_pname5_score := le.e1_pname5_score <> ri.e1_pname5_score;
    SELF.Diff_e1_cname5 := le.e1_cname5 <> ri.e1_cname5;
    SELF.Diff_e2_title1 := le.e2_title1 <> ri.e2_title1;
    SELF.Diff_e2_fname1 := le.e2_fname1 <> ri.e2_fname1;
    SELF.Diff_e2_mname1 := le.e2_mname1 <> ri.e2_mname1;
    SELF.Diff_e2_lname1 := le.e2_lname1 <> ri.e2_lname1;
    SELF.Diff_e2_suffix1 := le.e2_suffix1 <> ri.e2_suffix1;
    SELF.Diff_e2_pname1_score := le.e2_pname1_score <> ri.e2_pname1_score;
    SELF.Diff_e2_cname1 := le.e2_cname1 <> ri.e2_cname1;
    SELF.Diff_e2_title2 := le.e2_title2 <> ri.e2_title2;
    SELF.Diff_e2_fname2 := le.e2_fname2 <> ri.e2_fname2;
    SELF.Diff_e2_mname2 := le.e2_mname2 <> ri.e2_mname2;
    SELF.Diff_e2_lname2 := le.e2_lname2 <> ri.e2_lname2;
    SELF.Diff_e2_suffix2 := le.e2_suffix2 <> ri.e2_suffix2;
    SELF.Diff_e2_pname2_score := le.e2_pname2_score <> ri.e2_pname2_score;
    SELF.Diff_e2_cname2 := le.e2_cname2 <> ri.e2_cname2;
    SELF.Diff_e2_title3 := le.e2_title3 <> ri.e2_title3;
    SELF.Diff_e2_fname3 := le.e2_fname3 <> ri.e2_fname3;
    SELF.Diff_e2_mname3 := le.e2_mname3 <> ri.e2_mname3;
    SELF.Diff_e2_lname3 := le.e2_lname3 <> ri.e2_lname3;
    SELF.Diff_e2_suffix3 := le.e2_suffix3 <> ri.e2_suffix3;
    SELF.Diff_e2_pname3_score := le.e2_pname3_score <> ri.e2_pname3_score;
    SELF.Diff_e2_cname3 := le.e2_cname3 <> ri.e2_cname3;
    SELF.Diff_e2_title4 := le.e2_title4 <> ri.e2_title4;
    SELF.Diff_e2_fname4 := le.e2_fname4 <> ri.e2_fname4;
    SELF.Diff_e2_mname4 := le.e2_mname4 <> ri.e2_mname4;
    SELF.Diff_e2_lname4 := le.e2_lname4 <> ri.e2_lname4;
    SELF.Diff_e2_suffix4 := le.e2_suffix4 <> ri.e2_suffix4;
    SELF.Diff_e2_pname4_score := le.e2_pname4_score <> ri.e2_pname4_score;
    SELF.Diff_e2_cname4 := le.e2_cname4 <> ri.e2_cname4;
    SELF.Diff_e2_title5 := le.e2_title5 <> ri.e2_title5;
    SELF.Diff_e2_fname5 := le.e2_fname5 <> ri.e2_fname5;
    SELF.Diff_e2_mname5 := le.e2_mname5 <> ri.e2_mname5;
    SELF.Diff_e2_lname5 := le.e2_lname5 <> ri.e2_lname5;
    SELF.Diff_e2_suffix5 := le.e2_suffix5 <> ri.e2_suffix5;
    SELF.Diff_e2_pname5_score := le.e2_pname5_score <> ri.e2_pname5_score;
    SELF.Diff_e2_cname5 := le.e2_cname5 <> ri.e2_cname5;
    SELF.Diff_v1_title1 := le.v1_title1 <> ri.v1_title1;
    SELF.Diff_v1_fname1 := le.v1_fname1 <> ri.v1_fname1;
    SELF.Diff_v1_mname1 := le.v1_mname1 <> ri.v1_mname1;
    SELF.Diff_v1_lname1 := le.v1_lname1 <> ri.v1_lname1;
    SELF.Diff_v1_suffix1 := le.v1_suffix1 <> ri.v1_suffix1;
    SELF.Diff_v1_pname1_score := le.v1_pname1_score <> ri.v1_pname1_score;
    SELF.Diff_v1_cname1 := le.v1_cname1 <> ri.v1_cname1;
    SELF.Diff_v1_title2 := le.v1_title2 <> ri.v1_title2;
    SELF.Diff_v1_fname2 := le.v1_fname2 <> ri.v1_fname2;
    SELF.Diff_v1_mname2 := le.v1_mname2 <> ri.v1_mname2;
    SELF.Diff_v1_lname2 := le.v1_lname2 <> ri.v1_lname2;
    SELF.Diff_v1_suffix2 := le.v1_suffix2 <> ri.v1_suffix2;
    SELF.Diff_v1_pname2_score := le.v1_pname2_score <> ri.v1_pname2_score;
    SELF.Diff_v1_cname2 := le.v1_cname2 <> ri.v1_cname2;
    SELF.Diff_v1_title3 := le.v1_title3 <> ri.v1_title3;
    SELF.Diff_v1_fname3 := le.v1_fname3 <> ri.v1_fname3;
    SELF.Diff_v1_mname3 := le.v1_mname3 <> ri.v1_mname3;
    SELF.Diff_v1_lname3 := le.v1_lname3 <> ri.v1_lname3;
    SELF.Diff_v1_suffix3 := le.v1_suffix3 <> ri.v1_suffix3;
    SELF.Diff_v1_pname3_score := le.v1_pname3_score <> ri.v1_pname3_score;
    SELF.Diff_v1_cname3 := le.v1_cname3 <> ri.v1_cname3;
    SELF.Diff_v1_title4 := le.v1_title4 <> ri.v1_title4;
    SELF.Diff_v1_fname4 := le.v1_fname4 <> ri.v1_fname4;
    SELF.Diff_v1_mname4 := le.v1_mname4 <> ri.v1_mname4;
    SELF.Diff_v1_lname4 := le.v1_lname4 <> ri.v1_lname4;
    SELF.Diff_v1_suffix4 := le.v1_suffix4 <> ri.v1_suffix4;
    SELF.Diff_v1_pname4_score := le.v1_pname4_score <> ri.v1_pname4_score;
    SELF.Diff_v1_cname4 := le.v1_cname4 <> ri.v1_cname4;
    SELF.Diff_v1_title5 := le.v1_title5 <> ri.v1_title5;
    SELF.Diff_v1_fname5 := le.v1_fname5 <> ri.v1_fname5;
    SELF.Diff_v1_mname5 := le.v1_mname5 <> ri.v1_mname5;
    SELF.Diff_v1_lname5 := le.v1_lname5 <> ri.v1_lname5;
    SELF.Diff_v1_suffix5 := le.v1_suffix5 <> ri.v1_suffix5;
    SELF.Diff_v1_pname5_score := le.v1_pname5_score <> ri.v1_pname5_score;
    SELF.Diff_v1_cname5 := le.v1_cname5 <> ri.v1_cname5;
    SELF.Diff_v2_title1 := le.v2_title1 <> ri.v2_title1;
    SELF.Diff_v2_fname1 := le.v2_fname1 <> ri.v2_fname1;
    SELF.Diff_v2_mname1 := le.v2_mname1 <> ri.v2_mname1;
    SELF.Diff_v2_lname1 := le.v2_lname1 <> ri.v2_lname1;
    SELF.Diff_v2_suffix1 := le.v2_suffix1 <> ri.v2_suffix1;
    SELF.Diff_v2_pname1_score := le.v2_pname1_score <> ri.v2_pname1_score;
    SELF.Diff_v2_cname1 := le.v2_cname1 <> ri.v2_cname1;
    SELF.Diff_v2_title2 := le.v2_title2 <> ri.v2_title2;
    SELF.Diff_v2_fname2 := le.v2_fname2 <> ri.v2_fname2;
    SELF.Diff_v2_mname2 := le.v2_mname2 <> ri.v2_mname2;
    SELF.Diff_v2_lname2 := le.v2_lname2 <> ri.v2_lname2;
    SELF.Diff_v2_suffix2 := le.v2_suffix2 <> ri.v2_suffix2;
    SELF.Diff_v2_pname2_score := le.v2_pname2_score <> ri.v2_pname2_score;
    SELF.Diff_v2_cname2 := le.v2_cname2 <> ri.v2_cname2;
    SELF.Diff_v2_title3 := le.v2_title3 <> ri.v2_title3;
    SELF.Diff_v2_fname3 := le.v2_fname3 <> ri.v2_fname3;
    SELF.Diff_v2_mname3 := le.v2_mname3 <> ri.v2_mname3;
    SELF.Diff_v2_lname3 := le.v2_lname3 <> ri.v2_lname3;
    SELF.Diff_v2_suffix3 := le.v2_suffix3 <> ri.v2_suffix3;
    SELF.Diff_v2_pname3_score := le.v2_pname3_score <> ri.v2_pname3_score;
    SELF.Diff_v2_cname3 := le.v2_cname3 <> ri.v2_cname3;
    SELF.Diff_v2_title4 := le.v2_title4 <> ri.v2_title4;
    SELF.Diff_v2_fname4 := le.v2_fname4 <> ri.v2_fname4;
    SELF.Diff_v2_mname4 := le.v2_mname4 <> ri.v2_mname4;
    SELF.Diff_v2_lname4 := le.v2_lname4 <> ri.v2_lname4;
    SELF.Diff_v2_suffix4 := le.v2_suffix4 <> ri.v2_suffix4;
    SELF.Diff_v2_pname4_score := le.v2_pname4_score <> ri.v2_pname4_score;
    SELF.Diff_v2_cname4 := le.v2_cname4 <> ri.v2_cname4;
    SELF.Diff_v2_title5 := le.v2_title5 <> ri.v2_title5;
    SELF.Diff_v2_fname5 := le.v2_fname5 <> ri.v2_fname5;
    SELF.Diff_v2_mname5 := le.v2_mname5 <> ri.v2_mname5;
    SELF.Diff_v2_lname5 := le.v2_lname5 <> ri.v2_lname5;
    SELF.Diff_v2_suffix5 := le.v2_suffix5 <> ri.v2_suffix5;
    SELF.Diff_v2_pname5_score := le.v2_pname5_score <> ri.v2_pname5_score;
    SELF.Diff_v2_cname5 := le.v2_cname5 <> ri.v2_cname5;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_first_reported,1,0)+ IF( SELF.Diff_dt_last_reported,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_vendor,1,0)+ IF( SELF.Diff_state_origin,1,0)+ IF( SELF.Diff_source_file,1,0)+ IF( SELF.Diff_case_key,1,0)+ IF( SELF.Diff_parent_case_key,1,0)+ IF( SELF.Diff_court_code,1,0)+ IF( SELF.Diff_court,1,0)+ IF( SELF.Diff_case_number,1,0)+ IF( SELF.Diff_case_type_code,1,0)+ IF( SELF.Diff_case_type,1,0)+ IF( SELF.Diff_case_title,1,0)+ IF( SELF.Diff_ruled_for_against_code,1,0)+ IF( SELF.Diff_ruled_for_against,1,0)+ IF( SELF.Diff_entity_1,1,0)+ IF( SELF.Diff_entity_nm_format_1,1,0)+ IF( SELF.Diff_entity_type_code_1_orig,1,0)+ IF( SELF.Diff_entity_type_description_1_orig,1,0)+ IF( SELF.Diff_entity_type_code_1_master,1,0)+ IF( SELF.Diff_entity_seq_num_1,1,0)+ IF( SELF.Diff_atty_seq_num_1,1,0)+ IF( SELF.Diff_entity_1_address_1,1,0)+ IF( SELF.Diff_entity_1_address_2,1,0)+ IF( SELF.Diff_entity_1_address_3,1,0)+ IF( SELF.Diff_entity_1_address_4,1,0)+ IF( SELF.Diff_entity_1_dob,1,0)+ IF( SELF.Diff_primary_entity_2,1,0)+ IF( SELF.Diff_entity_nm_format_2,1,0)+ IF( SELF.Diff_entity_type_code_2_orig,1,0)+ IF( SELF.Diff_entity_type_description_2_orig,1,0)+ IF( SELF.Diff_entity_type_code_2_master,1,0)+ IF( SELF.Diff_entity_seq_num_2,1,0)+ IF( SELF.Diff_atty_seq_num_2,1,0)+ IF( SELF.Diff_entity_2_address_1,1,0)+ IF( SELF.Diff_entity_2_address_2,1,0)+ IF( SELF.Diff_entity_2_address_3,1,0)+ IF( SELF.Diff_entity_2_address_4,1,0)+ IF( SELF.Diff_entity_2_dob,1,0)+ IF( SELF.Diff_prim_range1,1,0)+ IF( SELF.Diff_predir1,1,0)+ IF( SELF.Diff_prim_name1,1,0)+ IF( SELF.Diff_addr_suffix1,1,0)+ IF( SELF.Diff_postdir1,1,0)+ IF( SELF.Diff_unit_desig1,1,0)+ IF( SELF.Diff_sec_range1,1,0)+ IF( SELF.Diff_p_city_name1,1,0)+ IF( SELF.Diff_v_city_name1,1,0)+ IF( SELF.Diff_st1,1,0)+ IF( SELF.Diff_zip1,1,0)+ IF( SELF.Diff_zip41,1,0)+ IF( SELF.Diff_cart1,1,0)+ IF( SELF.Diff_cr_sort_sz1,1,0)+ IF( SELF.Diff_lot1,1,0)+ IF( SELF.Diff_lot_order1,1,0)+ IF( SELF.Diff_dpbc1,1,0)+ IF( SELF.Diff_chk_digit1,1,0)+ IF( SELF.Diff_rec_type1,1,0)+ IF( SELF.Diff_ace_fips_st1,1,0)+ IF( SELF.Diff_ace_fips_county1,1,0)+ IF( SELF.Diff_geo_lat1,1,0)+ IF( SELF.Diff_geo_long1,1,0)+ IF( SELF.Diff_msa1,1,0)+ IF( SELF.Diff_geo_blk1,1,0)+ IF( SELF.Diff_geo_match1,1,0)+ IF( SELF.Diff_err_stat1,1,0)+ IF( SELF.Diff_prim_range2,1,0)+ IF( SELF.Diff_predir2,1,0)+ IF( SELF.Diff_prim_name2,1,0)+ IF( SELF.Diff_addr_suffix2,1,0)+ IF( SELF.Diff_postdir2,1,0)+ IF( SELF.Diff_unit_desig2,1,0)+ IF( SELF.Diff_sec_range2,1,0)+ IF( SELF.Diff_p_city_name2,1,0)+ IF( SELF.Diff_v_city_name2,1,0)+ IF( SELF.Diff_st2,1,0)+ IF( SELF.Diff_zip2,1,0)+ IF( SELF.Diff_zip42,1,0)+ IF( SELF.Diff_cart2,1,0)+ IF( SELF.Diff_cr_sort_sz2,1,0)+ IF( SELF.Diff_lot2,1,0)+ IF( SELF.Diff_lot_order2,1,0)+ IF( SELF.Diff_dpbc2,1,0)+ IF( SELF.Diff_chk_digit2,1,0)+ IF( SELF.Diff_rec_type2,1,0)+ IF( SELF.Diff_ace_fips_st2,1,0)+ IF( SELF.Diff_ace_fips_county2,1,0)+ IF( SELF.Diff_geo_lat2,1,0)+ IF( SELF.Diff_geo_long2,1,0)+ IF( SELF.Diff_msa2,1,0)+ IF( SELF.Diff_geo_blk2,1,0)+ IF( SELF.Diff_geo_match2,1,0)+ IF( SELF.Diff_err_stat2,1,0)+ IF( SELF.Diff_e1_title1,1,0)+ IF( SELF.Diff_e1_fname1,1,0)+ IF( SELF.Diff_e1_mname1,1,0)+ IF( SELF.Diff_e1_lname1,1,0)+ IF( SELF.Diff_e1_suffix1,1,0)+ IF( SELF.Diff_e1_pname1_score,1,0)+ IF( SELF.Diff_e1_cname1,1,0)+ IF( SELF.Diff_e1_title2,1,0)+ IF( SELF.Diff_e1_fname2,1,0)+ IF( SELF.Diff_e1_mname2,1,0)+ IF( SELF.Diff_e1_lname2,1,0)+ IF( SELF.Diff_e1_suffix2,1,0)+ IF( SELF.Diff_e1_pname2_score,1,0)+ IF( SELF.Diff_e1_cname2,1,0)+ IF( SELF.Diff_e1_title3,1,0)+ IF( SELF.Diff_e1_fname3,1,0)+ IF( SELF.Diff_e1_mname3,1,0)+ IF( SELF.Diff_e1_lname3,1,0)+ IF( SELF.Diff_e1_suffix3,1,0)+ IF( SELF.Diff_e1_pname3_score,1,0)+ IF( SELF.Diff_e1_cname3,1,0)+ IF( SELF.Diff_e1_title4,1,0)+ IF( SELF.Diff_e1_fname4,1,0)+ IF( SELF.Diff_e1_mname4,1,0)+ IF( SELF.Diff_e1_lname4,1,0)+ IF( SELF.Diff_e1_suffix4,1,0)+ IF( SELF.Diff_e1_pname4_score,1,0)+ IF( SELF.Diff_e1_cname4,1,0)+ IF( SELF.Diff_e1_title5,1,0)+ IF( SELF.Diff_e1_fname5,1,0)+ IF( SELF.Diff_e1_mname5,1,0)+ IF( SELF.Diff_e1_lname5,1,0)+ IF( SELF.Diff_e1_suffix5,1,0)+ IF( SELF.Diff_e1_pname5_score,1,0)+ IF( SELF.Diff_e1_cname5,1,0)+ IF( SELF.Diff_e2_title1,1,0)+ IF( SELF.Diff_e2_fname1,1,0)+ IF( SELF.Diff_e2_mname1,1,0)+ IF( SELF.Diff_e2_lname1,1,0)+ IF( SELF.Diff_e2_suffix1,1,0)+ IF( SELF.Diff_e2_pname1_score,1,0)+ IF( SELF.Diff_e2_cname1,1,0)+ IF( SELF.Diff_e2_title2,1,0)+ IF( SELF.Diff_e2_fname2,1,0)+ IF( SELF.Diff_e2_mname2,1,0)+ IF( SELF.Diff_e2_lname2,1,0)+ IF( SELF.Diff_e2_suffix2,1,0)+ IF( SELF.Diff_e2_pname2_score,1,0)+ IF( SELF.Diff_e2_cname2,1,0)+ IF( SELF.Diff_e2_title3,1,0)+ IF( SELF.Diff_e2_fname3,1,0)+ IF( SELF.Diff_e2_mname3,1,0)+ IF( SELF.Diff_e2_lname3,1,0)+ IF( SELF.Diff_e2_suffix3,1,0)+ IF( SELF.Diff_e2_pname3_score,1,0)+ IF( SELF.Diff_e2_cname3,1,0)+ IF( SELF.Diff_e2_title4,1,0)+ IF( SELF.Diff_e2_fname4,1,0)+ IF( SELF.Diff_e2_mname4,1,0)+ IF( SELF.Diff_e2_lname4,1,0)+ IF( SELF.Diff_e2_suffix4,1,0)+ IF( SELF.Diff_e2_pname4_score,1,0)+ IF( SELF.Diff_e2_cname4,1,0)+ IF( SELF.Diff_e2_title5,1,0)+ IF( SELF.Diff_e2_fname5,1,0)+ IF( SELF.Diff_e2_mname5,1,0)+ IF( SELF.Diff_e2_lname5,1,0)+ IF( SELF.Diff_e2_suffix5,1,0)+ IF( SELF.Diff_e2_pname5_score,1,0)+ IF( SELF.Diff_e2_cname5,1,0)+ IF( SELF.Diff_v1_title1,1,0)+ IF( SELF.Diff_v1_fname1,1,0)+ IF( SELF.Diff_v1_mname1,1,0)+ IF( SELF.Diff_v1_lname1,1,0)+ IF( SELF.Diff_v1_suffix1,1,0)+ IF( SELF.Diff_v1_pname1_score,1,0)+ IF( SELF.Diff_v1_cname1,1,0)+ IF( SELF.Diff_v1_title2,1,0)+ IF( SELF.Diff_v1_fname2,1,0)+ IF( SELF.Diff_v1_mname2,1,0)+ IF( SELF.Diff_v1_lname2,1,0)+ IF( SELF.Diff_v1_suffix2,1,0)+ IF( SELF.Diff_v1_pname2_score,1,0)+ IF( SELF.Diff_v1_cname2,1,0)+ IF( SELF.Diff_v1_title3,1,0)+ IF( SELF.Diff_v1_fname3,1,0)+ IF( SELF.Diff_v1_mname3,1,0)+ IF( SELF.Diff_v1_lname3,1,0)+ IF( SELF.Diff_v1_suffix3,1,0)+ IF( SELF.Diff_v1_pname3_score,1,0)+ IF( SELF.Diff_v1_cname3,1,0)+ IF( SELF.Diff_v1_title4,1,0)+ IF( SELF.Diff_v1_fname4,1,0)+ IF( SELF.Diff_v1_mname4,1,0)+ IF( SELF.Diff_v1_lname4,1,0)+ IF( SELF.Diff_v1_suffix4,1,0)+ IF( SELF.Diff_v1_pname4_score,1,0)+ IF( SELF.Diff_v1_cname4,1,0)+ IF( SELF.Diff_v1_title5,1,0)+ IF( SELF.Diff_v1_fname5,1,0)+ IF( SELF.Diff_v1_mname5,1,0)+ IF( SELF.Diff_v1_lname5,1,0)+ IF( SELF.Diff_v1_suffix5,1,0)+ IF( SELF.Diff_v1_pname5_score,1,0)+ IF( SELF.Diff_v1_cname5,1,0)+ IF( SELF.Diff_v2_title1,1,0)+ IF( SELF.Diff_v2_fname1,1,0)+ IF( SELF.Diff_v2_mname1,1,0)+ IF( SELF.Diff_v2_lname1,1,0)+ IF( SELF.Diff_v2_suffix1,1,0)+ IF( SELF.Diff_v2_pname1_score,1,0)+ IF( SELF.Diff_v2_cname1,1,0)+ IF( SELF.Diff_v2_title2,1,0)+ IF( SELF.Diff_v2_fname2,1,0)+ IF( SELF.Diff_v2_mname2,1,0)+ IF( SELF.Diff_v2_lname2,1,0)+ IF( SELF.Diff_v2_suffix2,1,0)+ IF( SELF.Diff_v2_pname2_score,1,0)+ IF( SELF.Diff_v2_cname2,1,0)+ IF( SELF.Diff_v2_title3,1,0)+ IF( SELF.Diff_v2_fname3,1,0)+ IF( SELF.Diff_v2_mname3,1,0)+ IF( SELF.Diff_v2_lname3,1,0)+ IF( SELF.Diff_v2_suffix3,1,0)+ IF( SELF.Diff_v2_pname3_score,1,0)+ IF( SELF.Diff_v2_cname3,1,0)+ IF( SELF.Diff_v2_title4,1,0)+ IF( SELF.Diff_v2_fname4,1,0)+ IF( SELF.Diff_v2_mname4,1,0)+ IF( SELF.Diff_v2_lname4,1,0)+ IF( SELF.Diff_v2_suffix4,1,0)+ IF( SELF.Diff_v2_pname4_score,1,0)+ IF( SELF.Diff_v2_cname4,1,0)+ IF( SELF.Diff_v2_title5,1,0)+ IF( SELF.Diff_v2_fname5,1,0)+ IF( SELF.Diff_v2_mname5,1,0)+ IF( SELF.Diff_v2_lname5,1,0)+ IF( SELF.Diff_v2_suffix5,1,0)+ IF( SELF.Diff_v2_pname5_score,1,0)+ IF( SELF.Diff_v2_cname5,1,0);
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
    Count_Diff_dt_first_reported := COUNT(GROUP,%Closest%.Diff_dt_first_reported);
    Count_Diff_dt_last_reported := COUNT(GROUP,%Closest%.Diff_dt_last_reported);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_vendor := COUNT(GROUP,%Closest%.Diff_vendor);
    Count_Diff_state_origin := COUNT(GROUP,%Closest%.Diff_state_origin);
    Count_Diff_source_file := COUNT(GROUP,%Closest%.Diff_source_file);
    Count_Diff_case_key := COUNT(GROUP,%Closest%.Diff_case_key);
    Count_Diff_parent_case_key := COUNT(GROUP,%Closest%.Diff_parent_case_key);
    Count_Diff_court_code := COUNT(GROUP,%Closest%.Diff_court_code);
    Count_Diff_court := COUNT(GROUP,%Closest%.Diff_court);
    Count_Diff_case_number := COUNT(GROUP,%Closest%.Diff_case_number);
    Count_Diff_case_type_code := COUNT(GROUP,%Closest%.Diff_case_type_code);
    Count_Diff_case_type := COUNT(GROUP,%Closest%.Diff_case_type);
    Count_Diff_case_title := COUNT(GROUP,%Closest%.Diff_case_title);
    Count_Diff_ruled_for_against_code := COUNT(GROUP,%Closest%.Diff_ruled_for_against_code);
    Count_Diff_ruled_for_against := COUNT(GROUP,%Closest%.Diff_ruled_for_against);
    Count_Diff_entity_1 := COUNT(GROUP,%Closest%.Diff_entity_1);
    Count_Diff_entity_nm_format_1 := COUNT(GROUP,%Closest%.Diff_entity_nm_format_1);
    Count_Diff_entity_type_code_1_orig := COUNT(GROUP,%Closest%.Diff_entity_type_code_1_orig);
    Count_Diff_entity_type_description_1_orig := COUNT(GROUP,%Closest%.Diff_entity_type_description_1_orig);
    Count_Diff_entity_type_code_1_master := COUNT(GROUP,%Closest%.Diff_entity_type_code_1_master);
    Count_Diff_entity_seq_num_1 := COUNT(GROUP,%Closest%.Diff_entity_seq_num_1);
    Count_Diff_atty_seq_num_1 := COUNT(GROUP,%Closest%.Diff_atty_seq_num_1);
    Count_Diff_entity_1_address_1 := COUNT(GROUP,%Closest%.Diff_entity_1_address_1);
    Count_Diff_entity_1_address_2 := COUNT(GROUP,%Closest%.Diff_entity_1_address_2);
    Count_Diff_entity_1_address_3 := COUNT(GROUP,%Closest%.Diff_entity_1_address_3);
    Count_Diff_entity_1_address_4 := COUNT(GROUP,%Closest%.Diff_entity_1_address_4);
    Count_Diff_entity_1_dob := COUNT(GROUP,%Closest%.Diff_entity_1_dob);
    Count_Diff_primary_entity_2 := COUNT(GROUP,%Closest%.Diff_primary_entity_2);
    Count_Diff_entity_nm_format_2 := COUNT(GROUP,%Closest%.Diff_entity_nm_format_2);
    Count_Diff_entity_type_code_2_orig := COUNT(GROUP,%Closest%.Diff_entity_type_code_2_orig);
    Count_Diff_entity_type_description_2_orig := COUNT(GROUP,%Closest%.Diff_entity_type_description_2_orig);
    Count_Diff_entity_type_code_2_master := COUNT(GROUP,%Closest%.Diff_entity_type_code_2_master);
    Count_Diff_entity_seq_num_2 := COUNT(GROUP,%Closest%.Diff_entity_seq_num_2);
    Count_Diff_atty_seq_num_2 := COUNT(GROUP,%Closest%.Diff_atty_seq_num_2);
    Count_Diff_entity_2_address_1 := COUNT(GROUP,%Closest%.Diff_entity_2_address_1);
    Count_Diff_entity_2_address_2 := COUNT(GROUP,%Closest%.Diff_entity_2_address_2);
    Count_Diff_entity_2_address_3 := COUNT(GROUP,%Closest%.Diff_entity_2_address_3);
    Count_Diff_entity_2_address_4 := COUNT(GROUP,%Closest%.Diff_entity_2_address_4);
    Count_Diff_entity_2_dob := COUNT(GROUP,%Closest%.Diff_entity_2_dob);
    Count_Diff_prim_range1 := COUNT(GROUP,%Closest%.Diff_prim_range1);
    Count_Diff_predir1 := COUNT(GROUP,%Closest%.Diff_predir1);
    Count_Diff_prim_name1 := COUNT(GROUP,%Closest%.Diff_prim_name1);
    Count_Diff_addr_suffix1 := COUNT(GROUP,%Closest%.Diff_addr_suffix1);
    Count_Diff_postdir1 := COUNT(GROUP,%Closest%.Diff_postdir1);
    Count_Diff_unit_desig1 := COUNT(GROUP,%Closest%.Diff_unit_desig1);
    Count_Diff_sec_range1 := COUNT(GROUP,%Closest%.Diff_sec_range1);
    Count_Diff_p_city_name1 := COUNT(GROUP,%Closest%.Diff_p_city_name1);
    Count_Diff_v_city_name1 := COUNT(GROUP,%Closest%.Diff_v_city_name1);
    Count_Diff_st1 := COUNT(GROUP,%Closest%.Diff_st1);
    Count_Diff_zip1 := COUNT(GROUP,%Closest%.Diff_zip1);
    Count_Diff_zip41 := COUNT(GROUP,%Closest%.Diff_zip41);
    Count_Diff_cart1 := COUNT(GROUP,%Closest%.Diff_cart1);
    Count_Diff_cr_sort_sz1 := COUNT(GROUP,%Closest%.Diff_cr_sort_sz1);
    Count_Diff_lot1 := COUNT(GROUP,%Closest%.Diff_lot1);
    Count_Diff_lot_order1 := COUNT(GROUP,%Closest%.Diff_lot_order1);
    Count_Diff_dpbc1 := COUNT(GROUP,%Closest%.Diff_dpbc1);
    Count_Diff_chk_digit1 := COUNT(GROUP,%Closest%.Diff_chk_digit1);
    Count_Diff_rec_type1 := COUNT(GROUP,%Closest%.Diff_rec_type1);
    Count_Diff_ace_fips_st1 := COUNT(GROUP,%Closest%.Diff_ace_fips_st1);
    Count_Diff_ace_fips_county1 := COUNT(GROUP,%Closest%.Diff_ace_fips_county1);
    Count_Diff_geo_lat1 := COUNT(GROUP,%Closest%.Diff_geo_lat1);
    Count_Diff_geo_long1 := COUNT(GROUP,%Closest%.Diff_geo_long1);
    Count_Diff_msa1 := COUNT(GROUP,%Closest%.Diff_msa1);
    Count_Diff_geo_blk1 := COUNT(GROUP,%Closest%.Diff_geo_blk1);
    Count_Diff_geo_match1 := COUNT(GROUP,%Closest%.Diff_geo_match1);
    Count_Diff_err_stat1 := COUNT(GROUP,%Closest%.Diff_err_stat1);
    Count_Diff_prim_range2 := COUNT(GROUP,%Closest%.Diff_prim_range2);
    Count_Diff_predir2 := COUNT(GROUP,%Closest%.Diff_predir2);
    Count_Diff_prim_name2 := COUNT(GROUP,%Closest%.Diff_prim_name2);
    Count_Diff_addr_suffix2 := COUNT(GROUP,%Closest%.Diff_addr_suffix2);
    Count_Diff_postdir2 := COUNT(GROUP,%Closest%.Diff_postdir2);
    Count_Diff_unit_desig2 := COUNT(GROUP,%Closest%.Diff_unit_desig2);
    Count_Diff_sec_range2 := COUNT(GROUP,%Closest%.Diff_sec_range2);
    Count_Diff_p_city_name2 := COUNT(GROUP,%Closest%.Diff_p_city_name2);
    Count_Diff_v_city_name2 := COUNT(GROUP,%Closest%.Diff_v_city_name2);
    Count_Diff_st2 := COUNT(GROUP,%Closest%.Diff_st2);
    Count_Diff_zip2 := COUNT(GROUP,%Closest%.Diff_zip2);
    Count_Diff_zip42 := COUNT(GROUP,%Closest%.Diff_zip42);
    Count_Diff_cart2 := COUNT(GROUP,%Closest%.Diff_cart2);
    Count_Diff_cr_sort_sz2 := COUNT(GROUP,%Closest%.Diff_cr_sort_sz2);
    Count_Diff_lot2 := COUNT(GROUP,%Closest%.Diff_lot2);
    Count_Diff_lot_order2 := COUNT(GROUP,%Closest%.Diff_lot_order2);
    Count_Diff_dpbc2 := COUNT(GROUP,%Closest%.Diff_dpbc2);
    Count_Diff_chk_digit2 := COUNT(GROUP,%Closest%.Diff_chk_digit2);
    Count_Diff_rec_type2 := COUNT(GROUP,%Closest%.Diff_rec_type2);
    Count_Diff_ace_fips_st2 := COUNT(GROUP,%Closest%.Diff_ace_fips_st2);
    Count_Diff_ace_fips_county2 := COUNT(GROUP,%Closest%.Diff_ace_fips_county2);
    Count_Diff_geo_lat2 := COUNT(GROUP,%Closest%.Diff_geo_lat2);
    Count_Diff_geo_long2 := COUNT(GROUP,%Closest%.Diff_geo_long2);
    Count_Diff_msa2 := COUNT(GROUP,%Closest%.Diff_msa2);
    Count_Diff_geo_blk2 := COUNT(GROUP,%Closest%.Diff_geo_blk2);
    Count_Diff_geo_match2 := COUNT(GROUP,%Closest%.Diff_geo_match2);
    Count_Diff_err_stat2 := COUNT(GROUP,%Closest%.Diff_err_stat2);
    Count_Diff_e1_title1 := COUNT(GROUP,%Closest%.Diff_e1_title1);
    Count_Diff_e1_fname1 := COUNT(GROUP,%Closest%.Diff_e1_fname1);
    Count_Diff_e1_mname1 := COUNT(GROUP,%Closest%.Diff_e1_mname1);
    Count_Diff_e1_lname1 := COUNT(GROUP,%Closest%.Diff_e1_lname1);
    Count_Diff_e1_suffix1 := COUNT(GROUP,%Closest%.Diff_e1_suffix1);
    Count_Diff_e1_pname1_score := COUNT(GROUP,%Closest%.Diff_e1_pname1_score);
    Count_Diff_e1_cname1 := COUNT(GROUP,%Closest%.Diff_e1_cname1);
    Count_Diff_e1_title2 := COUNT(GROUP,%Closest%.Diff_e1_title2);
    Count_Diff_e1_fname2 := COUNT(GROUP,%Closest%.Diff_e1_fname2);
    Count_Diff_e1_mname2 := COUNT(GROUP,%Closest%.Diff_e1_mname2);
    Count_Diff_e1_lname2 := COUNT(GROUP,%Closest%.Diff_e1_lname2);
    Count_Diff_e1_suffix2 := COUNT(GROUP,%Closest%.Diff_e1_suffix2);
    Count_Diff_e1_pname2_score := COUNT(GROUP,%Closest%.Diff_e1_pname2_score);
    Count_Diff_e1_cname2 := COUNT(GROUP,%Closest%.Diff_e1_cname2);
    Count_Diff_e1_title3 := COUNT(GROUP,%Closest%.Diff_e1_title3);
    Count_Diff_e1_fname3 := COUNT(GROUP,%Closest%.Diff_e1_fname3);
    Count_Diff_e1_mname3 := COUNT(GROUP,%Closest%.Diff_e1_mname3);
    Count_Diff_e1_lname3 := COUNT(GROUP,%Closest%.Diff_e1_lname3);
    Count_Diff_e1_suffix3 := COUNT(GROUP,%Closest%.Diff_e1_suffix3);
    Count_Diff_e1_pname3_score := COUNT(GROUP,%Closest%.Diff_e1_pname3_score);
    Count_Diff_e1_cname3 := COUNT(GROUP,%Closest%.Diff_e1_cname3);
    Count_Diff_e1_title4 := COUNT(GROUP,%Closest%.Diff_e1_title4);
    Count_Diff_e1_fname4 := COUNT(GROUP,%Closest%.Diff_e1_fname4);
    Count_Diff_e1_mname4 := COUNT(GROUP,%Closest%.Diff_e1_mname4);
    Count_Diff_e1_lname4 := COUNT(GROUP,%Closest%.Diff_e1_lname4);
    Count_Diff_e1_suffix4 := COUNT(GROUP,%Closest%.Diff_e1_suffix4);
    Count_Diff_e1_pname4_score := COUNT(GROUP,%Closest%.Diff_e1_pname4_score);
    Count_Diff_e1_cname4 := COUNT(GROUP,%Closest%.Diff_e1_cname4);
    Count_Diff_e1_title5 := COUNT(GROUP,%Closest%.Diff_e1_title5);
    Count_Diff_e1_fname5 := COUNT(GROUP,%Closest%.Diff_e1_fname5);
    Count_Diff_e1_mname5 := COUNT(GROUP,%Closest%.Diff_e1_mname5);
    Count_Diff_e1_lname5 := COUNT(GROUP,%Closest%.Diff_e1_lname5);
    Count_Diff_e1_suffix5 := COUNT(GROUP,%Closest%.Diff_e1_suffix5);
    Count_Diff_e1_pname5_score := COUNT(GROUP,%Closest%.Diff_e1_pname5_score);
    Count_Diff_e1_cname5 := COUNT(GROUP,%Closest%.Diff_e1_cname5);
    Count_Diff_e2_title1 := COUNT(GROUP,%Closest%.Diff_e2_title1);
    Count_Diff_e2_fname1 := COUNT(GROUP,%Closest%.Diff_e2_fname1);
    Count_Diff_e2_mname1 := COUNT(GROUP,%Closest%.Diff_e2_mname1);
    Count_Diff_e2_lname1 := COUNT(GROUP,%Closest%.Diff_e2_lname1);
    Count_Diff_e2_suffix1 := COUNT(GROUP,%Closest%.Diff_e2_suffix1);
    Count_Diff_e2_pname1_score := COUNT(GROUP,%Closest%.Diff_e2_pname1_score);
    Count_Diff_e2_cname1 := COUNT(GROUP,%Closest%.Diff_e2_cname1);
    Count_Diff_e2_title2 := COUNT(GROUP,%Closest%.Diff_e2_title2);
    Count_Diff_e2_fname2 := COUNT(GROUP,%Closest%.Diff_e2_fname2);
    Count_Diff_e2_mname2 := COUNT(GROUP,%Closest%.Diff_e2_mname2);
    Count_Diff_e2_lname2 := COUNT(GROUP,%Closest%.Diff_e2_lname2);
    Count_Diff_e2_suffix2 := COUNT(GROUP,%Closest%.Diff_e2_suffix2);
    Count_Diff_e2_pname2_score := COUNT(GROUP,%Closest%.Diff_e2_pname2_score);
    Count_Diff_e2_cname2 := COUNT(GROUP,%Closest%.Diff_e2_cname2);
    Count_Diff_e2_title3 := COUNT(GROUP,%Closest%.Diff_e2_title3);
    Count_Diff_e2_fname3 := COUNT(GROUP,%Closest%.Diff_e2_fname3);
    Count_Diff_e2_mname3 := COUNT(GROUP,%Closest%.Diff_e2_mname3);
    Count_Diff_e2_lname3 := COUNT(GROUP,%Closest%.Diff_e2_lname3);
    Count_Diff_e2_suffix3 := COUNT(GROUP,%Closest%.Diff_e2_suffix3);
    Count_Diff_e2_pname3_score := COUNT(GROUP,%Closest%.Diff_e2_pname3_score);
    Count_Diff_e2_cname3 := COUNT(GROUP,%Closest%.Diff_e2_cname3);
    Count_Diff_e2_title4 := COUNT(GROUP,%Closest%.Diff_e2_title4);
    Count_Diff_e2_fname4 := COUNT(GROUP,%Closest%.Diff_e2_fname4);
    Count_Diff_e2_mname4 := COUNT(GROUP,%Closest%.Diff_e2_mname4);
    Count_Diff_e2_lname4 := COUNT(GROUP,%Closest%.Diff_e2_lname4);
    Count_Diff_e2_suffix4 := COUNT(GROUP,%Closest%.Diff_e2_suffix4);
    Count_Diff_e2_pname4_score := COUNT(GROUP,%Closest%.Diff_e2_pname4_score);
    Count_Diff_e2_cname4 := COUNT(GROUP,%Closest%.Diff_e2_cname4);
    Count_Diff_e2_title5 := COUNT(GROUP,%Closest%.Diff_e2_title5);
    Count_Diff_e2_fname5 := COUNT(GROUP,%Closest%.Diff_e2_fname5);
    Count_Diff_e2_mname5 := COUNT(GROUP,%Closest%.Diff_e2_mname5);
    Count_Diff_e2_lname5 := COUNT(GROUP,%Closest%.Diff_e2_lname5);
    Count_Diff_e2_suffix5 := COUNT(GROUP,%Closest%.Diff_e2_suffix5);
    Count_Diff_e2_pname5_score := COUNT(GROUP,%Closest%.Diff_e2_pname5_score);
    Count_Diff_e2_cname5 := COUNT(GROUP,%Closest%.Diff_e2_cname5);
    Count_Diff_v1_title1 := COUNT(GROUP,%Closest%.Diff_v1_title1);
    Count_Diff_v1_fname1 := COUNT(GROUP,%Closest%.Diff_v1_fname1);
    Count_Diff_v1_mname1 := COUNT(GROUP,%Closest%.Diff_v1_mname1);
    Count_Diff_v1_lname1 := COUNT(GROUP,%Closest%.Diff_v1_lname1);
    Count_Diff_v1_suffix1 := COUNT(GROUP,%Closest%.Diff_v1_suffix1);
    Count_Diff_v1_pname1_score := COUNT(GROUP,%Closest%.Diff_v1_pname1_score);
    Count_Diff_v1_cname1 := COUNT(GROUP,%Closest%.Diff_v1_cname1);
    Count_Diff_v1_title2 := COUNT(GROUP,%Closest%.Diff_v1_title2);
    Count_Diff_v1_fname2 := COUNT(GROUP,%Closest%.Diff_v1_fname2);
    Count_Diff_v1_mname2 := COUNT(GROUP,%Closest%.Diff_v1_mname2);
    Count_Diff_v1_lname2 := COUNT(GROUP,%Closest%.Diff_v1_lname2);
    Count_Diff_v1_suffix2 := COUNT(GROUP,%Closest%.Diff_v1_suffix2);
    Count_Diff_v1_pname2_score := COUNT(GROUP,%Closest%.Diff_v1_pname2_score);
    Count_Diff_v1_cname2 := COUNT(GROUP,%Closest%.Diff_v1_cname2);
    Count_Diff_v1_title3 := COUNT(GROUP,%Closest%.Diff_v1_title3);
    Count_Diff_v1_fname3 := COUNT(GROUP,%Closest%.Diff_v1_fname3);
    Count_Diff_v1_mname3 := COUNT(GROUP,%Closest%.Diff_v1_mname3);
    Count_Diff_v1_lname3 := COUNT(GROUP,%Closest%.Diff_v1_lname3);
    Count_Diff_v1_suffix3 := COUNT(GROUP,%Closest%.Diff_v1_suffix3);
    Count_Diff_v1_pname3_score := COUNT(GROUP,%Closest%.Diff_v1_pname3_score);
    Count_Diff_v1_cname3 := COUNT(GROUP,%Closest%.Diff_v1_cname3);
    Count_Diff_v1_title4 := COUNT(GROUP,%Closest%.Diff_v1_title4);
    Count_Diff_v1_fname4 := COUNT(GROUP,%Closest%.Diff_v1_fname4);
    Count_Diff_v1_mname4 := COUNT(GROUP,%Closest%.Diff_v1_mname4);
    Count_Diff_v1_lname4 := COUNT(GROUP,%Closest%.Diff_v1_lname4);
    Count_Diff_v1_suffix4 := COUNT(GROUP,%Closest%.Diff_v1_suffix4);
    Count_Diff_v1_pname4_score := COUNT(GROUP,%Closest%.Diff_v1_pname4_score);
    Count_Diff_v1_cname4 := COUNT(GROUP,%Closest%.Diff_v1_cname4);
    Count_Diff_v1_title5 := COUNT(GROUP,%Closest%.Diff_v1_title5);
    Count_Diff_v1_fname5 := COUNT(GROUP,%Closest%.Diff_v1_fname5);
    Count_Diff_v1_mname5 := COUNT(GROUP,%Closest%.Diff_v1_mname5);
    Count_Diff_v1_lname5 := COUNT(GROUP,%Closest%.Diff_v1_lname5);
    Count_Diff_v1_suffix5 := COUNT(GROUP,%Closest%.Diff_v1_suffix5);
    Count_Diff_v1_pname5_score := COUNT(GROUP,%Closest%.Diff_v1_pname5_score);
    Count_Diff_v1_cname5 := COUNT(GROUP,%Closest%.Diff_v1_cname5);
    Count_Diff_v2_title1 := COUNT(GROUP,%Closest%.Diff_v2_title1);
    Count_Diff_v2_fname1 := COUNT(GROUP,%Closest%.Diff_v2_fname1);
    Count_Diff_v2_mname1 := COUNT(GROUP,%Closest%.Diff_v2_mname1);
    Count_Diff_v2_lname1 := COUNT(GROUP,%Closest%.Diff_v2_lname1);
    Count_Diff_v2_suffix1 := COUNT(GROUP,%Closest%.Diff_v2_suffix1);
    Count_Diff_v2_pname1_score := COUNT(GROUP,%Closest%.Diff_v2_pname1_score);
    Count_Diff_v2_cname1 := COUNT(GROUP,%Closest%.Diff_v2_cname1);
    Count_Diff_v2_title2 := COUNT(GROUP,%Closest%.Diff_v2_title2);
    Count_Diff_v2_fname2 := COUNT(GROUP,%Closest%.Diff_v2_fname2);
    Count_Diff_v2_mname2 := COUNT(GROUP,%Closest%.Diff_v2_mname2);
    Count_Diff_v2_lname2 := COUNT(GROUP,%Closest%.Diff_v2_lname2);
    Count_Diff_v2_suffix2 := COUNT(GROUP,%Closest%.Diff_v2_suffix2);
    Count_Diff_v2_pname2_score := COUNT(GROUP,%Closest%.Diff_v2_pname2_score);
    Count_Diff_v2_cname2 := COUNT(GROUP,%Closest%.Diff_v2_cname2);
    Count_Diff_v2_title3 := COUNT(GROUP,%Closest%.Diff_v2_title3);
    Count_Diff_v2_fname3 := COUNT(GROUP,%Closest%.Diff_v2_fname3);
    Count_Diff_v2_mname3 := COUNT(GROUP,%Closest%.Diff_v2_mname3);
    Count_Diff_v2_lname3 := COUNT(GROUP,%Closest%.Diff_v2_lname3);
    Count_Diff_v2_suffix3 := COUNT(GROUP,%Closest%.Diff_v2_suffix3);
    Count_Diff_v2_pname3_score := COUNT(GROUP,%Closest%.Diff_v2_pname3_score);
    Count_Diff_v2_cname3 := COUNT(GROUP,%Closest%.Diff_v2_cname3);
    Count_Diff_v2_title4 := COUNT(GROUP,%Closest%.Diff_v2_title4);
    Count_Diff_v2_fname4 := COUNT(GROUP,%Closest%.Diff_v2_fname4);
    Count_Diff_v2_mname4 := COUNT(GROUP,%Closest%.Diff_v2_mname4);
    Count_Diff_v2_lname4 := COUNT(GROUP,%Closest%.Diff_v2_lname4);
    Count_Diff_v2_suffix4 := COUNT(GROUP,%Closest%.Diff_v2_suffix4);
    Count_Diff_v2_pname4_score := COUNT(GROUP,%Closest%.Diff_v2_pname4_score);
    Count_Diff_v2_cname4 := COUNT(GROUP,%Closest%.Diff_v2_cname4);
    Count_Diff_v2_title5 := COUNT(GROUP,%Closest%.Diff_v2_title5);
    Count_Diff_v2_fname5 := COUNT(GROUP,%Closest%.Diff_v2_fname5);
    Count_Diff_v2_mname5 := COUNT(GROUP,%Closest%.Diff_v2_mname5);
    Count_Diff_v2_lname5 := COUNT(GROUP,%Closest%.Diff_v2_lname5);
    Count_Diff_v2_suffix5 := COUNT(GROUP,%Closest%.Diff_v2_suffix5);
    Count_Diff_v2_pname5_score := COUNT(GROUP,%Closest%.Diff_v2_pname5_score);
    Count_Diff_v2_cname5 := COUNT(GROUP,%Closest%.Diff_v2_cname5);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
